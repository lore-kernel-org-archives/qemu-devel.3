Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ED7B1C3DA5D
	for <qemu-devel@archiver.kernel.org>; Mon, 22 Jul 2024 07:36:13 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sVna0-0006G1-SK; Mon, 22 Jul 2024 03:35:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1sVnZx-00061z-G4
 for qemu-devel@nongnu.org; Mon, 22 Jul 2024 03:35:30 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1sVnZv-0004Ia-Q2
 for qemu-devel@nongnu.org; Mon, 22 Jul 2024 03:35:29 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1721633722;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=Bk2lRLut9uIaV0mNz3ml9cJiQ6qOMmZS4NUfsYcBW/g=;
 b=gln74nzgWAIWUyiomTFIXUPCeIshJ64LfnSmljrKD7SOZc0oTeUuvz6htbcbpQFRCCSS0Y
 D+Zsij/yMVQaA9aqb63F+Cb0TIflJmOLZUn9xZStSt8LSWH50Azi9k7fqoNyYi0f3XYZ9Z
 UQOeRoe2g80d3IJKx37EWEhNBZNfY2o=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-311-FVLxUe-3NmOS7RFU3FrS8w-1; Mon, 22 Jul 2024 03:35:20 -0400
X-MC-Unique: FVLxUe-3NmOS7RFU3FrS8w-1
Received: by mail-wm1-f70.google.com with SMTP id
 5b1f17b1804b1-4266fbae4c6so29949955e9.0
 for <qemu-devel@nongnu.org>; Mon, 22 Jul 2024 00:35:20 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1721633719; x=1722238519;
 h=content-transfer-encoding:in-reply-to:autocrypt:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Bk2lRLut9uIaV0mNz3ml9cJiQ6qOMmZS4NUfsYcBW/g=;
 b=CLJhxSyhqTE2NiHnL17csru3eLbcnPf42bixTQmI3ecHXIxyiJtTQiB8j9xOQjwcJw
 VDzFQ++/fFdBcQiVsMK/8bDFmna5Ob25xF28TDDOmtxyBppGhguzHsTSOQIwh7JbI5ub
 kp0839fqS45ZwehWMAbIlUtOCrTTLe+2cTNRiIqtXSzj9/IIuH1Ift6DSrREO0yrPa8N
 qvqH+iqhvK0St98hVOVgIyj5pUsWlyDrFhDUUqmGyfOpc9XgThFgMZQ/aZOsE1AFYChF
 /Qu5bqfV4vBSEXQjgCClkkJAFvm5q7VqEhomRnmQZptYH3S2iCZpongqDXu9BUWhGZyq
 +Gvg==
X-Forwarded-Encrypted: i=1;
 AJvYcCXA5l8kL1cjxfUE7goEovIA8sTxI+xVp0sVNKH/E9icYL22B1UJW8JbGG/p+jSTQCUDjR9QLG7Q0XKtoD2IdYzg06VgmU8=
X-Gm-Message-State: AOJu0YxAN8xG1Ud1khG1sCqFXpnbhndd7UOHA6hQnDjzOVvx53ljb2/B
 1nIOnLkveKjKzFauIRCV+A926mJ8ncOr9LrW/WVhe9SxUoUU/VNYtUONv15STmyj32Ha2C0HT+f
 pFmG2zbqSRwdJHMd38WQ10dISJJzlRk5iNJdlQPfCqg5vWTLxFQLw
X-Received: by 2002:a05:600c:1f10:b0:426:5e8e:aa47 with SMTP id
 5b1f17b1804b1-427dcf69b05mr37464555e9.4.1721633719713; 
 Mon, 22 Jul 2024 00:35:19 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHCSIEqsMQNeb1SIzoxD6NHr1Fg7tv/hOed6Xu/CaHcBOi7eeiekrjSBPRejg3sxMtaHy5RKg==
X-Received: by 2002:a05:600c:1f10:b0:426:5e8e:aa47 with SMTP id
 5b1f17b1804b1-427dcf69b05mr37464485e9.4.1721633719333; 
 Mon, 22 Jul 2024 00:35:19 -0700 (PDT)
Received: from [192.168.0.4] (ip-109-43-177-101.web.vodafone.de.
 [109.43.177.101]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-427d2a6efb6sm144358625e9.24.2024.07.22.00.35.18
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 22 Jul 2024 00:35:19 -0700 (PDT)
Message-ID: <b538c18f-1b95-45b3-9aba-d1d92491c750@redhat.com>
Date: Mon, 22 Jul 2024 09:35:17 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] tests: increase timeout per instance of bios-tables-test
To: Igor Mammedov <imammedo@redhat.com>, qemu-devel@nongnu.org
Cc: lvivier@redhat.com, pbonzini@redhat.com, mst@redhat.com
References: <20240716125930.620861-1-imammedo@redhat.com>
Content-Language: en-US
From: Thomas Huth <thuth@redhat.com>
Autocrypt: addr=thuth@redhat.com; keydata=
 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
In-Reply-To: <20240716125930.620861-1-imammedo@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=thuth@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -22
X-Spam_score: -2.3
X-Spam_bar: --
X-Spam_report: (-2.3 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.141,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

On 16/07/2024 14.59, Igor Mammedov wrote:
> CI often fails 'cross-i686-tci' job due to runner slowness
> Log shows that test almost complete, with a few remaining
> when bios-tables-test timeout hits:
> 
>    19/270 qemu:qtest+qtest-aarch64 / qtest-aarch64/bios-tables-test
>      TIMEOUT        610.02s   killed by signal 15 SIGTERM
>    ...
>    stderr:
>    TAP parsing error: Too few tests run (expected 8, got 7)
> 
> At the same time overall job running time is only ~30 out of 1hr allowed.
> 
> Increase bios-tables-test instance timeout on 5min as a fix
> for slow CI runners.
> 
> Signed-off-by: Igor Mammedov <imammedo@redhat.com>
> ---
>   tests/qtest/meson.build | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)

Since we're entering the freeze period this week, I'm going to pick up this 
patch for my next pull request in the hope that it will help to get this job 
green again during the freeze period. But in the long run, it would be 
really good if someone familiar with the bios-tables-test could analyze why 
the run time increased so much in recent times for this test and provide a 
better fix for the problem.

  Thanks,
   Thomas



