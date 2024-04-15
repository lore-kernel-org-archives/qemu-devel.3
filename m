Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AE8C5C4345F
	for <qemu-devel@archiver.kernel.org>; Mon, 15 Apr 2024 09:30:01 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rwIeg-0006Ey-KT; Mon, 15 Apr 2024 05:29:38 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rwIee-0006EJ-VU
 for qemu-devel@nongnu.org; Mon, 15 Apr 2024 05:29:36 -0400
Received: from mail-lf1-x12c.google.com ([2a00:1450:4864:20::12c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rwIeV-0002ka-FR
 for qemu-devel@nongnu.org; Mon, 15 Apr 2024 05:29:36 -0400
Received: by mail-lf1-x12c.google.com with SMTP id
 2adb3069b0e04-518931f8d23so1953735e87.3
 for <qemu-devel@nongnu.org>; Mon, 15 Apr 2024 02:29:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1713173365; x=1713778165; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=tPghi+khfbsX3M2QwoJwWMPYYX7hpr2w3EB7/rkQGVg=;
 b=ZnKIb6uU0DosUnkKPToAAt8Sj58kZjgalE1T/0xJH6KI5NUZIJ9vXMFXklgdbZ5I/F
 Pch9NIX5IK0SYSc2EqyzQb7YwLVIj++aXvUTxJdERZcsW5mX69sI/q5w4hzgsjgU5mwP
 LQzMN8nxtx3iMJA8cNT1/S2afnhXbWvQ3XzuOHXga8ki2sHeQSD5yz4nHGFgij3Dau6S
 ynU7njg04F4XAhQPRU8bnq8wUirirZmHWReI5RReDuYYZa73opvV6R/oBRmM4WUDcMPu
 Md5x0Mek2tgghmcMhdsU56GdRcz4pQdIPRdbhqxKwY8kJV9lMYWCPcrI60FgvfzXp/we
 nzKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1713173365; x=1713778165;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=tPghi+khfbsX3M2QwoJwWMPYYX7hpr2w3EB7/rkQGVg=;
 b=Q7CIA7ILIOzu+F9MKfdbWvNh72YAn1beVVEkrhyWEFWMdusvFk8zmIMMOZcU9co2ae
 f2BZUoIO/KJrVhRF65QgYnLf7VIuppH48SaaQH6YMDIrq5lxFqNk62H1mmrAMv6xGiSS
 g9sfAKeXt4JGw67dySkAsDIq3gQmZt7wItQX53fSc+HipaWKbsnRLruSXzdMpOahwuAQ
 oLUPKURMV2+xT1G8ndCJOfw2dINY/W6s7AoPQXugdsIoZTCtsmGubIJaX/HykaxpKX6l
 L3ujf8gEq/QT6raF4Z0RedqtruU3b4dJ8vlx1uNUZRXUpgAFukzKNM+hC59Siec616a7
 u9cg==
X-Forwarded-Encrypted: i=1;
 AJvYcCV1mMiCXygXV4IIncLQ8Z0KqJqCoXycSFO8biPhz6Wq5MkkLTfGQ1LF+PLldlacRPoz1e3vuI6R4nyhB2bqveR7Birfmow=
X-Gm-Message-State: AOJu0Yyd52iU6d6lSKt3ITg1GgoqHwtwSCTkUaIQEPFssJ1ARfcNlU6/
 G621JpzOag09yH7Q7vRUfWf5FaCGqXRVxTGMyw5f+hlEiWQgEPFYFJAxwPwcd6I=
X-Google-Smtp-Source: AGHT+IHl1bDJjOUfw4TJ7fv6+DOFhfYsbMeYYIbRB7t2iWvolECyetH6D11Dfup2UakTL35tVVuBEw==
X-Received: by 2002:a05:6512:38d1:b0:518:9b78:317 with SMTP id
 p17-20020a05651238d100b005189b780317mr4193515lft.52.1713173364673; 
 Mon, 15 Apr 2024 02:29:24 -0700 (PDT)
Received: from [192.168.69.100] ([176.176.132.126])
 by smtp.gmail.com with ESMTPSA id
 g10-20020ac24d8a000000b005159fa03501sm1213531lfe.302.2024.04.15.02.29.22
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 15 Apr 2024 02:29:24 -0700 (PDT)
Message-ID: <11343bd1-1f0d-4654-a50d-f3b19fabf9e8@linaro.org>
Date: Mon, 15 Apr 2024 11:29:21 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 2/5] hw/arm : Pass STM32L4x5 SYSCFG gpios to STM32L4x5
 SoC
To: =?UTF-8?Q?In=C3=A8s_Varhol?= <ines.varhol@telecom-paris.fr>,
 qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>, Thomas Huth <thuth@redhat.com>,
 =?UTF-8?Q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>,
 qemu-arm@nongnu.org, Laurent Vivier <lvivier@redhat.com>,
 Samuel Tardieu <sam@rfc1149.net>,
 Arnaud Minier <arnaud.minier@telecom-paris.fr>,
 Peter Maydell <peter.maydell@linaro.org>
References: <20240414130604.182059-1-ines.varhol@telecom-paris.fr>
 <20240414130604.182059-3-ines.varhol@telecom-paris.fr>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20240414130604.182059-3-ines.varhol@telecom-paris.fr>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::12c;
 envelope-from=philmd@linaro.org; helo=mail-lf1-x12c.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_NONE=0.001,
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

Hi Inès,

On 14/4/24 15:05, Inès Varhol wrote:
> Exposing SYSCFG inputs to the SoC is practical in order to wire the SoC
> to the optional DM163 display from the board code (GPIOs outputs need
> to be connected to both SYSCFG inputs and DM163 inputs).
> 
> STM32L4x5 SYSCFG in-irq interception needed to be changed accordingly.
> 
> Signed-off-by: Arnaud Minier <arnaud.minier@telecom-paris.fr>
> Signed-off-by: Inès Varhol <ines.varhol@telecom-paris.fr>
> ---
>   hw/arm/stm32l4x5_soc.c              |  6 ++++--
>   tests/qtest/stm32l4x5_gpio-test.c   | 12 +++++++-----
>   tests/qtest/stm32l4x5_syscfg-test.c | 16 +++++++++-------
>   3 files changed, 20 insertions(+), 14 deletions(-)
> 
> diff --git a/hw/arm/stm32l4x5_soc.c b/hw/arm/stm32l4x5_soc.c
> index 40e294f838..c4b45e6956 100644
> --- a/hw/arm/stm32l4x5_soc.c
> +++ b/hw/arm/stm32l4x5_soc.c
> @@ -1,8 +1,8 @@
>   /*
>    * STM32L4x5 SoC family
>    *
> - * Copyright (c) 2023 Arnaud Minier <arnaud.minier@telecom-paris.fr>
> - * Copyright (c) 2023 Inès Varhol <ines.varhol@telecom-paris.fr>
> + * Copyright (c) 2024 Arnaud Minier <arnaud.minier@telecom-paris.fr>
> + * Copyright (c) 2024 Inès Varhol <ines.varhol@telecom-paris.fr>

You can keep 2023-2024.

>    *
>    * SPDX-License-Identifier: GPL-2.0-or-later
>    *
> @@ -221,6 +221,8 @@ static void stm32l4x5_soc_realize(DeviceState *dev_soc, Error **errp)
>           }
>       }
>   
> +    qdev_pass_gpios(DEVICE(&s->syscfg), dev_soc, NULL);
> +
>       /* EXTI device */
>       busdev = SYS_BUS_DEVICE(&s->exti);
>       if (!sysbus_realize(busdev, errp)) {
> diff --git a/tests/qtest/stm32l4x5_gpio-test.c b/tests/qtest/stm32l4x5_gpio-test.c
> index 0f6bda54d3..495a6fc413 100644
> --- a/tests/qtest/stm32l4x5_gpio-test.c
> +++ b/tests/qtest/stm32l4x5_gpio-test.c
> @@ -43,6 +43,8 @@
>   #define OTYPER_PUSH_PULL 0
>   #define OTYPER_OPEN_DRAIN 1
>   
> +#define SYSCFG "/machine/soc"

Can we have a comment such /* SoC forwards GPIOs to SysCfg */?

(Similar comments for stm32l4x5_syscfg-test.c).


