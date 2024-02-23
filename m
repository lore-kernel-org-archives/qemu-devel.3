Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A07ABC54798
	for <qemu-devel@archiver.kernel.org>; Fri, 23 Feb 2024 12:27:15 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rdUdK-0001XV-F9; Fri, 23 Feb 2024 07:26:30 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rdUcA-0007MY-O2
 for qemu-devel@nongnu.org; Fri, 23 Feb 2024 07:25:19 -0500
Received: from mail-wr1-x433.google.com ([2a00:1450:4864:20::433])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rdUc8-0000Up-Jc
 for qemu-devel@nongnu.org; Fri, 23 Feb 2024 07:25:18 -0500
Received: by mail-wr1-x433.google.com with SMTP id
 ffacd0b85a97d-33adec41b55so544013f8f.0
 for <qemu-devel@nongnu.org>; Fri, 23 Feb 2024 04:25:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1708691115; x=1709295915; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=zfoVqz9hrWMYTu3FBjcdg+zNi/5qfs8T/qrZe8dDN4Y=;
 b=vCgbjEtjHGJaJHoWUMuMA7uLXovXPiJqTaAHqtvbW7VFMG0A9d8fBYmHsxI/bFEhqw
 NxmGfdZBGWr02gC0UzHAyC+hFGz8rg0goWDRdF0TEL+ncNuJEUePl5loZ7Q8UZBjr/+t
 fDneHj2DZrH/Kp0emlQVG5mJS+3XJwaqSl1/ZQOSafeGnyG1GSKOivy+BH0eODgRP3gU
 sExGKp0mQa/TNx/YjB5DSlyLN/XLgAvgzwy80RT0wVlI8WiyoebU6TQYF9yPjk+8yqrO
 EQGEqaRDLk9+tkz1p+BtLmx7iBZyT3NYKyou9DUQGegRGQcPjXBYPAQz7rRbC9Zv1fy1
 d9qg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1708691115; x=1709295915;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=zfoVqz9hrWMYTu3FBjcdg+zNi/5qfs8T/qrZe8dDN4Y=;
 b=MAar0uGJLceL0Ggy4B7/6YI0RjpzldOQjeWr1ATtNQSZttipRNlS0Uf6XLKraYhZUw
 KOPbD4dwkbHG//mnxlE84cKvuYjNG7XQZ+7/MZbyGRPkPzRFtbgTkpkPY1GpvJpRHtH/
 hMjM7Eri8BvH0r+Du75aryDnq7XGJw4DmafZQ/BlxADdllJV3Xaiuhu/lngPu081ts5m
 Ly4a0A2R4IVfYSM4Pr/Ckgxe8U6/lE2EpETeV8i5Rb7fNQ1lFgzHvNYG6sDE4AstbRzE
 oLlSSnPIjfwd1DSvuDkjKYL95VjVFcDkcnPWVj9ieJ1jP5aKtOK5PO6d8KbLCQIeLTzP
 /32Q==
X-Forwarded-Encrypted: i=1;
 AJvYcCWTmrtFr1gS5YJt648XSvruXl82MA++bTcSXOygAW1ua03VRe6fzmz6ri5wKJZcQO/B8Y/xC+epFm5A76UrqHkfsjdZx8E=
X-Gm-Message-State: AOJu0Yz8UTieZsKWlt8vKgAJ78iFIRJzxvj/opN7dEn87VTJTOs5/5eo
 b4kvlU+3bwrmWvdPU/pRNWtDFr0JDL21ogq97FrHV0LOyUhoygVU1GT1nXoOIFg=
X-Google-Smtp-Source: AGHT+IEg7i/lB96ye1XBm+Z0eO4ouXlZia9XtDa/2IqJTxvZ9nGAj010QaZ37AYDgDmcS//xBsvTRg==
X-Received: by 2002:adf:eb51:0:b0:33d:88c1:31b8 with SMTP id
 u17-20020adfeb51000000b0033d88c131b8mr1378718wrn.60.1708691114979; 
 Fri, 23 Feb 2024 04:25:14 -0800 (PST)
Received: from [192.168.69.100] (sto95-h01-176-184-18-96.dsl.sta.abo.bbox.fr.
 [176.184.18.96]) by smtp.gmail.com with ESMTPSA id
 v11-20020a5d4b0b000000b0033d90b314e7sm2631441wrq.101.2024.02.23.04.25.13
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 23 Feb 2024 04:25:14 -0800 (PST)
Message-ID: <f350fbb7-b954-4bb2-abf4-05ad049ceeae@linaro.org>
Date: Fri, 23 Feb 2024 13:25:12 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 2/3] hw/arm: Connect STM32L4x5 GPIO to STM32L4x5 SoC
Content-Language: en-US
To: =?UTF-8?Q?In=C3=A8s_Varhol?= <ines.varhol@telecom-paris.fr>,
 qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org, Laurent Vivier <lvivier@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Peter Maydell
 <peter.maydell@linaro.org>, Alistair Francis <alistair@alistair23.me>,
 Samuel Tardieu <samuel.tardieu@telecom-paris.fr>,
 Thomas Huth <thuth@redhat.com>,
 Arnaud Minier <arnaud.minier@telecom-paris.fr>
References: <20240207132517.198348-1-ines.varhol@telecom-paris.fr>
 <20240207132517.198348-3-ines.varhol@telecom-paris.fr>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20240207132517.198348-3-ines.varhol@telecom-paris.fr>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::433;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x433.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=unavailable autolearn_force=no
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

On 7/2/24 14:23, Inès Varhol wrote:
> Signed-off-by: Arnaud Minier <arnaud.minier@telecom-paris.fr>
> Signed-off-by: Inès Varhol <ines.varhol@telecom-paris.fr>
> ---
>   include/hw/arm/stm32l4x5_soc.h |  2 +
>   hw/arm/stm32l4x5_soc.c         | 78 ++++++++++++++++++++++++++++------
>   hw/arm/Kconfig                 |  3 +-
>   3 files changed, 68 insertions(+), 15 deletions(-)


> diff --git a/hw/arm/stm32l4x5_soc.c b/hw/arm/stm32l4x5_soc.c
> index 347a5377e5..ff38585dd6 100644
> --- a/hw/arm/stm32l4x5_soc.c
> +++ b/hw/arm/stm32l4x5_soc.c
> @@ -78,6 +78,32 @@ static const int exti_irq[NUM_EXTI_IRQ] = {
>   #define RCC_BASE_ADDRESS 0x40021000
>   #define RCC_IRQ 5
>   
> +static const uint32_t gpio_addr[

NUM_GPIOS

> ] = {
> +    0x48000000,
> +    0x48000400,
> +    0x48000800,
> +    0x48000C00,
> +    0x48001000,
> +    0x48001400,
> +    0x48001800,
> +    0x48001C00,
> +};
> +
> +static const struct {

gpio_addr[] should be moved in this same struct (eventually
naming it stm32l4x5_gpio_cfg), since the init val are related
to the gpio peripheral / base addr.

> +    uint32_t moder;
> +    uint32_t ospeedr;
> +    uint32_t pupdr;
> +} stm32l4x5_gpio_initval[NUM_GPIOS] = {
> +    { 0xABFFFFFF, 0x0C000000, 0x64000000 },
> +    { 0xFFFFFEBF, 0x00000000, 0x00000100 },
> +    { 0xFFFFFFFF, 0x00000000, 0x00000000 },
> +    { 0xFFFFFFFF, 0x00000000, 0x00000000 },
> +    { 0xFFFFFFFF, 0x00000000, 0x00000000 },
> +    { 0xFFFFFFFF, 0x00000000, 0x00000000 },
> +    { 0xFFFFFFFF, 0x00000000, 0x00000000 },
> +    { 0x0000000F, 0x00000000, 0x00000000 },
> +};

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>


