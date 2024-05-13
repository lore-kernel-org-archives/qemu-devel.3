Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BC6C1C25B5F
	for <qemu-devel@archiver.kernel.org>; Mon, 13 May 2024 13:52:24 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s6W5i-000687-EA; Mon, 13 May 2024 09:51:46 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1s6W5X-00062T-Sp
 for qemu-devel@nongnu.org; Mon, 13 May 2024 09:51:37 -0400
Received: from mail-ej1-x62d.google.com ([2a00:1450:4864:20::62d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1s6W5O-0002Fe-8s
 for qemu-devel@nongnu.org; Mon, 13 May 2024 09:51:34 -0400
Received: by mail-ej1-x62d.google.com with SMTP id
 a640c23a62f3a-a59ce1e8609so934774466b.0
 for <qemu-devel@nongnu.org>; Mon, 13 May 2024 06:51:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1715608284; x=1716213084; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=82LYSb9QtxmGOJ7FKKd622y2hJxOOUzTKXszhiub2EM=;
 b=KSgOrCjYZp8zKirL0r9VLvAgExPX9xXyALT5/IFCIqU8BquZlI4iuzEaOntNd7b9cK
 1L+bSLrWeHxXcNI/vNFpyS20UgOUcAHcLfdpiqxOXbuTPfDj32HhQ8AHZKo8f7gTv0u/
 bVgSNHxn2VCvJn6Moj+xExlQgBozxmnJsckeyBPDnHvPgjdTNb5598gLHUYytIj6g3FP
 joiJPQdNZjAgbPUPpZegA3fJ/oBtz+ZMSJVbW89eS2kWCDNpiqLBsra4cUhELgd2Vq3v
 /3aiOnnbGoYcewWa4bwWXhZg/+w1i8btuYS/ATF/Rb74r+hrbjWwrzJzNzj6BD9n5vTw
 2MwA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1715608284; x=1716213084;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=82LYSb9QtxmGOJ7FKKd622y2hJxOOUzTKXszhiub2EM=;
 b=CpFAojtV5XhfwvQzXoOeurn7Dc3ocCbnrUWUx6HL5MV++/z34u6fejs5ryMGhW/OuW
 A+VYT3iCOqi5q4RoJyNXQ2eZHVzrofdX9JRDq2XuNgkAz4vySvdWppL745VY8pZ7cZg8
 MwQQVAOfJ0TdCmwsWkxIyguJSA6Q3m9pvVbc/fDpwq7W0xMrl0oE4+HZEPH5zZ+wYu0y
 j2VD1Q2F0FynG/tJzimdqxD5WQRtqmuv4XA2+mnvm3GELi57EAGJmjUsDDX4g20GNTQH
 G3tYMzw6urkVLKH68qHjMwwvJqusvhUa8F7kTK5tnp/ND3S2/J42ZxP65ePP13NAb79b
 DYQQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCXZmCSslZUonwTOpmwm5/awPoQP1YGEtgnyO8j/ZUztEHq3iGzm/bbWm3/vZiW+0n5HTCReIHgC3pNkIPhY1Jm5KxNGDFU=
X-Gm-Message-State: AOJu0YzeDlUPjn1sr6M7pOByYQ5MEOZzSyPKpxDn9GHuW71cZuQjHiGg
 u9uMKISBzOyIKa8xNm/NHtuuiLCWunCzGJ3KHJAO/7sVEWvbBo/6OyRar5uehLl3N/l8xLMgeeg
 a5Rs=
X-Google-Smtp-Source: AGHT+IEDgABWEFDaag/aW7NZIsFSIwSePj/ddxdguGSyVAxw6n4EDz7l9aH05WDqMe1Qi1Sp1p4AnA==
X-Received: by 2002:a17:906:17d9:b0:a5a:177b:d8d2 with SMTP id
 a640c23a62f3a-a5a177bd952mr1009852466b.22.1715608284482; 
 Mon, 13 May 2024 06:51:24 -0700 (PDT)
Received: from [10.1.2.72] ([149.14.240.163]) by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-a5a1781ce4esm612859466b.13.2024.05.13.06.51.23
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 13 May 2024 06:51:24 -0700 (PDT)
Message-ID: <fd6de35c-dc98-4900-b542-946a132ca0f1@linaro.org>
Date: Mon, 13 May 2024 15:51:23 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 3/3] hw/misc: Implement mailbox properties for customer
 OTP and device specific private keys
To: Rayhan Faizel <rayhan.faizel@gmail.com>, qemu-devel@nongnu.org
Cc: peter.maydell@linaro.org, qemu-arm@nongnu.org
References: <20240510141010.656561-1-rayhan.faizel@gmail.com>
 <20240510141010.656561-4-rayhan.faizel@gmail.com>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20240510141010.656561-4-rayhan.faizel@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2a00:1450:4864:20::62d;
 envelope-from=philmd@linaro.org; helo=mail-ej1-x62d.google.com
X-Spam_score_int: -16
X-Spam_score: -1.7
X-Spam_bar: -
X-Spam_report: (-1.7 / 5.0 requ) BAYES_00=-1.9, DKIM_INVALID=0.1,
 DKIM_SIGNED=0.1, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

On 10/5/24 16:10, Rayhan Faizel wrote:
> Four mailbox properties are implemented as follows:
> 1. Customer OTP: GET_CUSTOMER_OTP and SET_CUSTOMER_OTP
> 2. Device-specific private key: GET_PRIVATE_KEY and
> SET_PRIVATE_KEY.
> 
> The customer OTP is located in the rows 36-43. The device-specific private key
> is located in the rows 56-63.

Better to define these instead of using magic values in the code,
i.e.:

   #define OTP_PRIVATE_KEY_OFFSET 56
   #define OTP_PRIVATE_KEY_LENGTH 8

> The customer OTP can be locked with the magic numbers 0xffffffff 0xaffe0000
> when running the SET_CUSTOMER_OTP mailbox command.
> 
> P.S I am not sure if the magic lock combo applies to the private key as well.
> 
> Signed-off-by: Rayhan Faizel <rayhan.faizel@gmail.com>
> ---
>   hw/arm/bcm2835_peripherals.c         |  2 +
>   hw/misc/bcm2835_property.c           | 71 ++++++++++++++++++++++++++++
>   include/hw/arm/raspberrypi-fw-defs.h |  2 +
>   include/hw/misc/bcm2835_property.h   |  2 +
>   4 files changed, 77 insertions(+)


> +        /* Device-specific private key */
> +
> +        case RPI_FWREQ_GET_PRIVATE_KEY:
> +            start_num = ldl_le_phys(&s->dma_as, value + 12);
> +            number = ldl_le_phys(&s->dma_as, value + 16);
> +
> +            resplen = 8 + 4 * number;
> +
> +            for (n = start_num; n < start_num + number && n < 8; n++) {
> +                stl_le_phys(&s->dma_as,
> +                            value + 20 + ((n - start_num) << 2),
> +                            bcm2835_otp_read_row(s->otp, 56 + n));
> +            }
> +            break;
> +        case RPI_FWREQ_SET_PRIVATE_KEY:
> +            start_num = ldl_le_phys(&s->dma_as, value + 12);
> +            number = ldl_le_phys(&s->dma_as, value + 16);
> +
> +            resplen = 4;
> +
> +            for (n = start_num; n < start_num + number && n < 8; n++) {
> +                otp_row = ldl_le_phys(&s->dma_as,
> +                                      value + 20 + ((n - start_num) << 2));
> +                bcm2835_otp_write_row(s->otp, 56 + n, otp_row);
> +            }
> +            break;


