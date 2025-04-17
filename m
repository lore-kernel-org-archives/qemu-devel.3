Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AB4E7C369C9
	for <qemu-devel@archiver.kernel.org>; Thu, 17 Apr 2025 19:28:13 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u5Utj-00015C-Qj; Thu, 17 Apr 2025 15:27:43 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1u5Uth-00010m-Uo
 for qemu-devel@nongnu.org; Thu, 17 Apr 2025 15:27:42 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1u5Utf-0004Iu-Ij
 for qemu-devel@nongnu.org; Thu, 17 Apr 2025 15:27:41 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1744918057;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=6AWA15SqwBPxBUAe422IeS3mTbISZ3sRZVtBJWK8XYM=;
 b=iLlg4q8x+T5lG/fjgFS53VyhEhEFUAXoO2xLFBYLjwc8eCNUS0jucUtqbSF0joIlY4RbPp
 fIsiK0TGHRCVUKM1rz7atrT85tQSokkXCNtCHuDS0cSeHPE7qxJjQ73UH8bcfNU4QsXxO4
 peQFNeDxe1jS2W4acHqNRWknRJAO7KQ=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-25-RJeniMqXMgSJmR3Aj0IKow-1; Thu, 17 Apr 2025 15:27:35 -0400
X-MC-Unique: RJeniMqXMgSJmR3Aj0IKow-1
X-Mimecast-MFC-AGG-ID: RJeniMqXMgSJmR3Aj0IKow_1744918055
Received: by mail-wm1-f71.google.com with SMTP id
 5b1f17b1804b1-43cf446681cso6244885e9.1
 for <qemu-devel@nongnu.org>; Thu, 17 Apr 2025 12:27:35 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1744918055; x=1745522855;
 h=content-transfer-encoding:in-reply-to:autocrypt:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=6AWA15SqwBPxBUAe422IeS3mTbISZ3sRZVtBJWK8XYM=;
 b=dLNDAViW70i4G83MqBiBMjyqmltFa3pz6ZiEGlUsSMEHr2Yhw3wl/N8XLzK6XwdJyI
 2cfqtHMTpCOq+vRf0BxaLV3fAKrQcUByPcEUcfFWXjQy23GEc1fzkbmhSymsDTLmX7WY
 kGoZB0u5XEB/7yPchgG9fcmAJQSGc5vmVSgAGfz8KYlxLpb/1tQxbOUf/7a7vJkHSTcr
 i3ZoDmKgBEBVwFbbWe695t1aAahmWawfcDQV1k8qpxtf1sD70wmd24cpgol56HzbMuyn
 k/9J34V4G/s+Ui755MnK1uECvg30wfoc1ducULMxf2aQ+u7C6rBFEYdVarzt/P3uoXix
 2fgw==
X-Forwarded-Encrypted: i=1;
 AJvYcCU5An6bCKC9vHiGejsl1ynio3QGrzqEdcJ+klmUkJ0Y7fRJekOLeNT7czw+37qDuat3ybejvR5GaQqH@nongnu.org
X-Gm-Message-State: AOJu0YzJpvdKHI+3+Owue7M6gVkM7hy/piQv0lz1tHDFZCPZjHcxRyLI
 otpt3RKchE8EFZ7oao9kvQ8vdfDv+Mo7NAlb9J3t+Bwbow2g+H/QY18QGN9PT/rWx0Tlp6sv+HE
 aMdcasoDHHBw4zdbLhvpVHCCJzmtmzpi7rGzGUzP+f8t4m8XggD40
X-Gm-Gg: ASbGnctp8t+viohN9OpC4OkbsX7Wxn0beblDAKhK27d02wo0vnKpIh/bl1khfsAqDMs
 D+QzzWj8LAD62DfFkmUKK7k+CIsbI2tU45QjPHvQq5gl14Gn1h9WJTkuTEtH0TQKf114zFnY4Ai
 KkCiZGWhqOV9OY08cRG2gqWaP4d/TSzWHdjJ8wq22VMQwUHG99auXH5AkvkUwpscaR+BymW8rw8
 vR9JkBN/EGqzZ0rJpiJt18ZaHbu56ktC7D42VdecWekLYQZv0S8Md8POV/xCIDoqCotjkNedVyH
 raqGgWNhZZtTR7ZiMvxI1oRJqrkSCB7wW0g7D6rV4oo=
X-Received: by 2002:a05:6000:188b:b0:38f:503a:d93f with SMTP id
 ffacd0b85a97d-39efbacdc16mr120480f8f.40.1744918054809; 
 Thu, 17 Apr 2025 12:27:34 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFHPCGGk4QqqhqHJAAVfQ1Y8JmaWF4XkDl1qG/VGNDyd9h/OwGseiK73zdtsgmo4zz75OVxAw==
X-Received: by 2002:a05:6000:188b:b0:38f:503a:d93f with SMTP id
 ffacd0b85a97d-39efbacdc16mr120467f8f.40.1744918054445; 
 Thu, 17 Apr 2025 12:27:34 -0700 (PDT)
Received: from [192.168.0.7] (ip-109-43-176-89.web.vodafone.de.
 [109.43.176.89]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-39efa4a4b68sm500183f8f.87.2025.04.17.12.27.32
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 17 Apr 2025 12:27:32 -0700 (PDT)
Message-ID: <325d3f62-b94b-4391-bdf1-2063da5e3b99@redhat.com>
Date: Thu, 17 Apr 2025 21:27:31 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 3/3] hw/ppc/e500: Add Freescale eSDHC to e500plat
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org, Bernhard Beschow <shentey@gmail.com>
Cc: Daniel Henrique Barboza <danielhb413@gmail.com>,
 Bin Meng <bin.meng@windriver.com>, qemu-ppc@nongnu.org, qemu-block@nongnu.org
References: <20221101222934.52444-1-philmd@linaro.org>
 <20221101222934.52444-4-philmd@linaro.org>
From: Thomas Huth <thuth@redhat.com>
Content-Language: en-US
Autocrypt: addr=thuth@redhat.com; keydata=
 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
In-Reply-To: <20221101222934.52444-4-philmd@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=thuth@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
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

On 01/11/2022 23.29, Philippe Mathieu-Daudé wrote:
> Adds missing functionality to e500plat machine which increases the
> chance of given "real" firmware images to access SD cards.
> 
> Signed-off-by: Bernhard Beschow <shentey@gmail.com>
> Message-Id: <20221018210146.193159-8-shentey@gmail.com>
> [PMD: Simplify using create_unimplemented_device("esdhc")]
> Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
> ---

  Hi!

I recently noticed that the QEMU advent calendar 2018 day 19 image 
(https://www.qemu-advent-calendar.org/2018/download/day19.tar.xz) is 
flooding the console with "mmc0: Internal clock never stabilised" messages 
when it's started like this:

  /qemu-system-ppc64 -vga none -nographic -monitor none -M ppce500 -cpu 
e5500  -kernel ../day19/uImage

This was not the case when I assembled the image in 2018. I bisected the 
problem and apparently this patch here is causing the problem. Do you know 
whether there is a way to fix this again?

  Thanks,
   Thomas


