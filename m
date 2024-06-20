Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 67AF8C2BA1A
	for <qemu-devel@archiver.kernel.org>; Thu, 20 Jun 2024 18:04:33 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sKM8K-0005t6-Rr; Thu, 20 Jun 2024 14:03:40 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1sKM8H-0005so-Py
 for qemu-devel@nongnu.org; Thu, 20 Jun 2024 14:03:38 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1sKM8F-0006kW-S9
 for qemu-devel@nongnu.org; Thu, 20 Jun 2024 14:03:37 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1718906615;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=jF9RJwBaWxQmJpUbJPQoexGOsyeWL8jJa5vrmyg522E=;
 b=DPJ/XhPcTrUHuYqtTvC1w4ksp3nhht1hqEWl01I36shPgT7F9xjlDZXAyw1u0rmIdwbp83
 1NovJZxrns1ZVY5518rhaKIpLSSpQHVm3DTukyBcJxAumCsw3N0AMDssk9B7Dz52/7nQU9
 5jYp4OD838kakqJDtNcHkwu+J6upttM=
Received: from mail-ej1-f69.google.com (mail-ej1-f69.google.com
 [209.85.218.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-522-MoTqhl4vOxaH4quIr2duiw-1; Thu, 20 Jun 2024 14:03:33 -0400
X-MC-Unique: MoTqhl4vOxaH4quIr2duiw-1
Received: by mail-ej1-f69.google.com with SMTP id
 a640c23a62f3a-a6f99aca0f8so51901566b.1
 for <qemu-devel@nongnu.org>; Thu, 20 Jun 2024 11:03:33 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1718906612; x=1719511412;
 h=content-transfer-encoding:in-reply-to:autocrypt:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=jF9RJwBaWxQmJpUbJPQoexGOsyeWL8jJa5vrmyg522E=;
 b=Xlxftbi2Va8yTh3PRRswO6lxpzUj9TuDMN14T6nI7zTfkbGgKbt6c51D04ESX7LKZc
 pN46lubPc3kWhnk+eKY7Y5/2CVHL2GthTc1bZoej8hoDGEu7C9rug33+QH8VCQ4gow0N
 lOli/70TEwYZwxl5+DITNsacJ7NZdANFrpQW7PKzV4ffCTZy4GeGX72uxqoAJJoQZMXp
 3x2y7m98W/lb4LOgy00QVbG+2yVvCUwGHVQQz93LhicNzOpBLlU11Uud6Drrurogaz0p
 xlTTdCO+N60cO3FWa8pNO6i2FwljMuV7ZYbqg7mMTtimAzzNG5L2BJ7cJwczjR3nat4q
 Qhfw==
X-Forwarded-Encrypted: i=1;
 AJvYcCUU64FBwOXDWJUTqqnvq4s5plnbrgpJeqe2wi6yJxJN1v88wlvMBdyeDXoCbRdkzGyrbeX5HXDjYpE5NhyKLnt0dfFcKlc=
X-Gm-Message-State: AOJu0YyxRUm0KP7uCnCjSxe0mksFQS1aTKIc14jhbwvO2Rdiqp89v2iH
 BQ84v0pmgaIfimkkr1dd0StIn0sF1DiPW4w6DCxzurFN0jP6qrzZ+cs8ljgGrExPNGCALt6dKc6
 KhZUN3aZfS/5pWuP1PmomEsjHaJOX+k65IoOtTPkbYNT2UnfRMAa/
X-Received: by 2002:a17:906:26db:b0:a6e:4693:1f6e with SMTP id
 a640c23a62f3a-a6fab61d347mr392515066b.29.1718906612199; 
 Thu, 20 Jun 2024 11:03:32 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IG7IjWD2YvBNR+NI+13vidiq0HEO6EEdJVqgTnev4Oux+4kLKKbSgc2rrgCAOePo3HAuih3Dw==
X-Received: by 2002:a17:906:26db:b0:a6e:4693:1f6e with SMTP id
 a640c23a62f3a-a6fab61d347mr392513566b.29.1718906611817; 
 Thu, 20 Jun 2024 11:03:31 -0700 (PDT)
Received: from [192.168.10.81] ([151.62.196.71])
 by smtp.googlemail.com with ESMTPSA id
 a640c23a62f3a-a6f56db61ebsm784810566b.56.2024.06.20.11.03.30
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 20 Jun 2024 11:03:31 -0700 (PDT)
Message-ID: <89b635cd-6cad-4146-89e4-1b118f3f1ad1@redhat.com>
Date: Thu, 20 Jun 2024 20:03:30 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/3] exec: avoid using C++ keywords in function parameters
To: Roman Kiryanov <rkir@google.com>, qemu-devel@nongnu.org
Cc: jansene@google.com, mett@google.com, jpcottin@google.com
References: <20240618224553.878869-1-rkir@google.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Content-Language: en-US
Autocrypt: addr=pbonzini@redhat.com; keydata=
 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
In-Reply-To: <20240618224553.878869-1-rkir@google.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -22
X-Spam_score: -2.3
X-Spam_bar: --
X-Spam_report: (-2.3 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.152,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

On 6/19/24 00:45, Roman Kiryanov wrote:
> to use the QEMU headers with a C++ compiler.
> 
> Google-Bug-Id: 331190993
> Change-Id: Ic4e49b9c791616bb22c973922772b0494706092c
> Signed-off-by: Roman Kiryanov <rkir@google.com>
> ---
>   include/exec/memory.h | 4 ++--
>   1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/include/exec/memory.h b/include/exec/memory.h
> index 1be58f694c..d7591a60d9 100644
> --- a/include/exec/memory.h
> +++ b/include/exec/memory.h
> @@ -945,7 +945,7 @@ struct MemoryListener {
>        * the current transaction.
>        */
>       void (*log_start)(MemoryListener *listener, MemoryRegionSection *section,
> -                      int old, int new);
> +                      int old_val, int new_val);
>   
>       /**
>        * @log_stop:
> @@ -964,7 +964,7 @@ struct MemoryListener {
>        * the current transaction.
>        */
>       void (*log_stop)(MemoryListener *listener, MemoryRegionSection *section,
> -                     int old, int new);
> +                     int old_val, int new_val);
>   
>       /**
>        * @log_sync:

Queued, thanks.

Paolo


