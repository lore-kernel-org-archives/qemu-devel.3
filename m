Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E0495C35FFA
	for <qemu-devel@archiver.kernel.org>; Wed, 19 Mar 2025 13:53:48 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tutqk-0003RB-H0; Wed, 19 Mar 2025 09:52:50 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tutqi-0003OE-KM
 for qemu-devel@nongnu.org; Wed, 19 Mar 2025 09:52:48 -0400
Received: from mail-wm1-x331.google.com ([2a00:1450:4864:20::331])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tutqg-0000HC-Jd
 for qemu-devel@nongnu.org; Wed, 19 Mar 2025 09:52:48 -0400
Received: by mail-wm1-x331.google.com with SMTP id
 5b1f17b1804b1-43cfebc343dso33142195e9.2
 for <qemu-devel@nongnu.org>; Wed, 19 Mar 2025 06:52:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1742392365; x=1742997165; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:cc:content-language
 :references:to:subject:user-agent:mime-version:date:message-id:from
 :to:cc:subject:date:message-id:reply-to;
 bh=VD8MM05qvyF2yrd4fNVU8fBron+v2neKEmPRY8dsoEA=;
 b=ZKCF1Fh/5lHDn+M46VFq65h1pDFTjxcBiZXkRQZ75XMhjXFcn4vbrsHCI5Gwwxdv8Y
 VVCF4l0ZMkvb+kBvgUXeY4hLyiWkWsVoIe67s1QdBNlgiFe7KqDSPAkT2usAjbvu6d9A
 h4AYt8UnaBxuk2+oWumGBdDh7dIxF9gFtO3DEdnoMAAdb2jwhZDz3anaKgu8fOeZRO+6
 v/GHJCWG/3N8AqTOHFcBAWZk+3o+xZdtkTuLstAOZyU3YnPXtQMkE5Z5386YU1i5BrjJ
 n/EhaVPvFTZsooE+s8JZkHsEr+BeREGzq/1ud0fqkI2HvJvJ4zK3aI+qNeCthhEyaCh0
 SjjQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1742392365; x=1742997165;
 h=content-transfer-encoding:in-reply-to:from:cc:content-language
 :references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=VD8MM05qvyF2yrd4fNVU8fBron+v2neKEmPRY8dsoEA=;
 b=Qe2NyE6Kc0n48T/rbd+LQxNEQdgqP/T2B/sCaRKLAjI0CQEN77bYy91IATs5jtQIcs
 IvrotGYfkTEIvkWRIJB7xjnQEXZMQTyXMUsSBbIR27Vdd2C9KRIpnBDINxqHP/vMLy3N
 tIKDHcdFzNu0nHXhbq+hVTpzHAy2gyAiBlrLsRw5n6TMFGfLfUQ4j34dZA/qvxOIStJ0
 d6vV7yHAwwMj9vlM/akIhyWTI3UDEo81u6LetwfT4Rb6SquOcXmCTwGiTtH68bxQQJsE
 csR2YUHxTdWV+gi9Igy1wbfNXBgUwEhSjfw8Zrvi6Z2qVdbDgrtfcX+moU623K1yK/h/
 YJIg==
X-Forwarded-Encrypted: i=1;
 AJvYcCVIAGl+Lfp4Pyn9BJrrpw29tylXJYhf5Pt2la4eJrJbG5292l6j7OI+iNZ2SdNqzwX6uFOsaLoROP50@nongnu.org
X-Gm-Message-State: AOJu0YzZK3bEL4IdPkFaZMHCz/qlUBKSHbmSaM8BXThPL9YyvUDWS0Ek
 mSmD3DQzjVau1Lpa0gnbRsKjPuV7+/SZncPK9UTUcU2qnqPZ6W7NOz4Cyt5ahDU=
X-Gm-Gg: ASbGnctnbklxtoS1PjzevXUsjqdIkoWvKi87woySBZZCYmGNnJvHp4f1OmPclZCBfSV
 7waN4dTd4122CZQl6Rl+4twOqxblk0tti7LCQGvBphouBajKUGRBjUgzpqdgop0N7NqGVYHiRsz
 xx/LqT/AEvBG15kcIXorDP/hUPwn18oeVnUwxaTPUfsotZZn/VQg36+6LQmNS4cZSVweUzAbdSc
 M3JPoCkp+ZSBFp+MQm+CelXcxZtMqK9pGbjXMh4nMb+V+xKVsaWzHQFIwvcy9o1AL5S73Uda1BF
 Tas14ECa7Nv+puVHJW5WVyQzIaefGuQrkTznKCB821qFw3WJWTbiTQ4WO1xV39/rZOHaT8IssRE
 Hdipaouy/5lIy
X-Google-Smtp-Source: AGHT+IHnmCvYvqbgSC+urOhVIGn2GvQgUDjkoBHR40UbKtnB8l2gn9foBofB9SRUD/8hgdjwyvAuMA==
X-Received: by 2002:a05:600c:1f14:b0:43c:e478:889 with SMTP id
 5b1f17b1804b1-43d436c6807mr28360275e9.0.1742392364651; 
 Wed, 19 Mar 2025 06:52:44 -0700 (PDT)
Received: from [192.168.69.235] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-43d43f43ecbsm19405535e9.10.2025.03.19.06.52.43
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 19 Mar 2025 06:52:44 -0700 (PDT)
Message-ID: <b642a46c-6b7d-4afe-a9fe-0c4ee9f734a0@linaro.org>
Date: Wed, 19 Mar 2025 14:52:43 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] Fix duplicate symbol error on MacOS build
To: Tanish Desai <tanishdesai37@gmail.com>, qemu-devel@nongnu.org
References: <20250319023036.71493-1-tanishdesai37@gmail.com>
Content-Language: en-US
Cc: Thomas Huth <thuth@redhat.com>, =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?=
 <berrange@redhat.com>, =?UTF-8?Q?Alex_Benn=C3=A9e?=
 <alex.bennee@linaro.org>, Paolo Bonzini <pbonzini@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20250319023036.71493-1-tanishdesai37@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2a00:1450:4864:20::331;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x331.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

Cc'ing CI maintainers.

On 19/3/25 03:30, Tanish Desai wrote:
> The issue started after commit https://github.com/qemu/qemu/commit/59f4d65584bd3372070e2484876436c8d02505e4
> 
> Reproduction:
>    1. In the build directory on MacOS (haven't tried on other OS), run:
>         ../configure --enable-rust --target-list=aarch64-softmmu

This config isn't covered on our CI, we only test --enable-rust on
Linux. Should we also test it for all non-Linux hosts? I'd rather not...

>    2. Then run either:
>         ninja -C .
>         OR
>         make
>    3. At the end, you will encounter the error:
>         duplicate symbol '_pl011_create' in:
>             /Users/tanishdesai37/Downloads/qemu-master/build/libcommon.a.p/hw_char_pl011.c.o
>             librust_aarch64_softmmu.a[5](pl011.pl011.390d424367e209af-cgu.1.rcgu.o)
>         ld: 1 duplicate symbols
> 
> Root cause:
>    Both CONFIG_PL011 and X_PL011_RUST are selected, causing C++ and Rust to produce the same object.
>    This is due to the commit above where 'select PL011' forces a true condition instead of checking if HAVE_RUST is true.
>    If HAVE_RUST is true, X_PL011_RUST should be selected instead of CONFIG_PL011.
> 
> Signed-off-by: Tanish Desai <tanishdesai37@gmail.com>
> ---
>   hw/vmapple/Kconfig | 3 ++-
>   1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/hw/vmapple/Kconfig b/hw/vmapple/Kconfig
> index 2382b297672..01bcbf40e00 100644
> --- a/hw/vmapple/Kconfig
> +++ b/hw/vmapple/Kconfig
> @@ -22,7 +22,8 @@ config VMAPPLE
>       select PLATFORM_BUS
>       select PCI_EXPRESS
>       select PCI_EXPRESS_GENERIC_BRIDGE
> -    select PL011 # UART
> +    select PL011 if !HAVE_RUST # UART
> +    select X_PL011_RUST if HAVE_RUST # UART
>       select PL031 # RTC
>       select PL061 # GPIO
>       select GPIO_PWR


