Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2DE01C48295
	for <qemu-devel@archiver.kernel.org>; Mon,  5 Feb 2024 13:48:14 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rWzJc-0007UW-Kj; Mon, 05 Feb 2024 08:47:16 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rWzJT-0007Ty-6f
 for qemu-devel@nongnu.org; Mon, 05 Feb 2024 08:47:08 -0500
Received: from mail-ej1-x634.google.com ([2a00:1450:4864:20::634])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rWzJP-0003uU-Vc
 for qemu-devel@nongnu.org; Mon, 05 Feb 2024 08:47:06 -0500
Received: by mail-ej1-x634.google.com with SMTP id
 a640c23a62f3a-a2d7e2e7fe0so581903966b.1
 for <qemu-devel@nongnu.org>; Mon, 05 Feb 2024 05:47:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1707140821; x=1707745621; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=OT8usIBI/R6EoqXiVlG877zeju+QK276nLgHhkV9l6k=;
 b=QjMZj7Y74Nvzs6rbB6iXMCpmL5s45Fkj7sXaKHcVEn1S2/s2hWOTcqsTUORHMK1Bq2
 aAaDIsFuLTIXuBByu2VWQ6eAwaKmJwlpqp1rSfL/hruq8TAqA9hQjqvMZgbN8chPVsgt
 Wph1MXGJqgSl+98rTqA3aovui84MvTGESew8d6jrXlQP37gZ5t3BYiulDKZfM3cRHNQ1
 5GbmaGRYiEDkq69GkU0BDUPPkFG4or6EB6xScRXj01rxs1aJq1o6gHI6FRabuP1CeX6S
 +/HUirnITKr5PQO+KpyXYxgv36PcvhhD0Ij3lmKmeQpGY25JK2IhsY9+62Ad/p33pGPK
 P4HA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1707140821; x=1707745621;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=OT8usIBI/R6EoqXiVlG877zeju+QK276nLgHhkV9l6k=;
 b=vsGQP2OaGEfO6iy8QOd6avSu3bsQk5OF3zHL6NDdpmeizUblcFr98DfNuKH5l7otLQ
 74g3hA80TA3wkmiacmCwmUlx0IdrwGEMzWflVKHpUYggxTE8muCCZ6vYgdJP0M/62mLk
 +vz5FcrYgDYYKgI4+cCkWoqgyVJgL6E4iHlpvDSq3NRLUk2Sf2nZ9f3oKTCoA7OvklYF
 tWK3JBAjYicGfUZTXsayKt/pRcYppuw/W1xCE45PGOD7uKKWOoRn8fwf11Bed62tiGwx
 8c7pRcisAeSXKOq9FPDo3nYSp2ow8qcPx5hLZyDYTddDL4DH9tG+RZZRfirf6dcaHeye
 pQSQ==
X-Gm-Message-State: AOJu0Yw+u+7ICnSX74Z2EJrt0BH/8U/D10M0gcXcMGpwwHwsxBHOVZb0
 /GKVCB2Z0du7EF4IgsWC7GgiMPK+O8/Q5pIqrNwzMngI4qsIWq8GCypBy1PuiYs=
X-Google-Smtp-Source: AGHT+IFiuwGXlDKcbmUKhlcVc2paNYCHhH4smMPv0Hn74LCtukhpBxTp3T8RA7rqdyCXnSI8c4dQEA==
X-Received: by 2002:a17:907:7656:b0:a37:b5e7:467b with SMTP id
 kj22-20020a170907765600b00a37b5e7467bmr2918597ejc.24.1707140821477; 
 Mon, 05 Feb 2024 05:47:01 -0800 (PST)
X-Forwarded-Encrypted: i=0;
 AJvYcCX3qmh/NWRXtQo4B2bBH+Vz9MoCH94cqCIZqDLUvY9uqrx2Si7CNQOEr0yINCINrSIpUNBteyfcihxTnHTNHTJxMd//soi1S1IruO5Hs/E2DTHyS9N9cL6GXwnUwICva3BXF1DIStg9PKvc/IWgrsxl1IA5Rl7zSO2Skm8YPZOKUMzyNjK3BiZkaOsjrnP0/EG/hNOxCWg/BypCP46R2x3kJP05TRqMZ+7cR1WDt4XkOr5ZeCW5OuXc340RZznXZnNSfzlSbiZGkcFk29q6Cy4ZxSzppkdMeVY=
Received: from [192.168.197.175] ([92.88.170.125])
 by smtp.gmail.com with ESMTPSA id
 i25-20020a1709064ed900b00a2e7d1b6042sm4328824ejv.196.2024.02.05.05.46.59
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 05 Feb 2024 05:47:01 -0800 (PST)
Message-ID: <22defe7a-6c67-4aae-b028-838ee6aa4e1a@linaro.org>
Date: Mon, 5 Feb 2024 14:46:58 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/3] hw/arm : Connect DM163 to STM32L4x5
Content-Language: en-US
To: =?UTF-8?Q?In=C3=A8s_Varhol?= <ines.varhol@telecom-paris.fr>,
 qemu-devel@nongnu.org
Cc: Arnaud Minier <arnaud.minier@telecom-paris.fr>,
 Paolo Bonzini <pbonzini@redhat.com>, qemu-arm@nongnu.org,
 Samuel Tardieu <sam@rfc1149.net>, Peter Maydell <peter.maydell@linaro.org>,
 Alistair Francis <alistair@alistair23.me>, Thomas Huth <thuth@redhat.com>,
 Laurent Vivier <lvivier@redhat.com>
References: <20240126193657.792005-1-ines.varhol@telecom-paris.fr>
 <20240126193657.792005-3-ines.varhol@telecom-paris.fr>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20240126193657.792005-3-ines.varhol@telecom-paris.fr>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::634;
 envelope-from=philmd@linaro.org; helo=mail-ej1-x634.google.com
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

Hi Inès,

On 26/1/24 20:31, Inès Varhol wrote:
> Signed-off-by: Arnaud Minier <arnaud.minier@telecom-paris.fr>
> Signed-off-by: Inès Varhol <ines.varhol@telecom-paris.fr>
> ---
>   hw/arm/Kconfig                 |  1 +
>   hw/arm/stm32l4x5_soc.c         | 55 +++++++++++++++++++++++++++++++++-
>   include/hw/arm/stm32l4x5_soc.h |  3 ++
>   3 files changed, 58 insertions(+), 1 deletion(-)
> 
> diff --git a/hw/arm/Kconfig b/hw/arm/Kconfig
> index 3e49b913f8..818aa2f1a2 100644
> --- a/hw/arm/Kconfig
> +++ b/hw/arm/Kconfig
> @@ -463,6 +463,7 @@ config STM32L4X5_SOC
>       select STM32L4X5_SYSCFG
>       select STM32L4X5_RCC
>       select STM32L4X5_GPIO
> +    select DM163


> +/*
> + * There are actually 14 input pins in the DM163 device.
> + * Here the DM163 input pin EN isn't connected to the STM32L4x5
> + * GPIOs as the IM120417002 colors shield doesn't actually use
> + * this pin to drive the RGB matrix.
> + */
> +#define NUM_DM163_INPUTS 13
> +
> +static const int dm163_input[NUM_DM163_INPUTS] = {
> +    1 * 16 + 2,  /* ROW0  PB2       */
> +    0 * 16 + 15, /* ROW1  PA15      */
> +    0 * 16 + 2,  /* ROW2  PA2       */
> +    0 * 16 + 7,  /* ROW3  PA7       */
> +    0 * 16 + 6,  /* ROW4  PA6       */
> +    0 * 16 + 5,  /* ROW5  PA5       */
> +    1 * 16 + 0,  /* ROW6  PB0       */
> +    0 * 16 + 3,  /* ROW7  PA3       */
> +    0 * 16 + 4,  /* SIN (SDA) PA4   */
> +    1 * 16 + 1,  /* DCK (SCK) PB1   */
> +    2 * 16 + 3,  /* RST_B (RST) PC3 */
> +    2 * 16 + 4,  /* LAT_B (LAT) PC4 */
> +    2 * 16 + 5,  /* SELBK (SB)  PC5 */
> +};
> +
> +
>   static const uint32_t gpio_addr[] = {
>       0x48000000,
>       0x48000400,
> @@ -116,6 +143,8 @@ static void stm32l4x5_soc_initfn(Object *obj)
>           g_autofree char *name = g_strdup_printf("gpio%c", 'a' + i);
>           object_initialize_child(obj, name, &s->gpio[i], TYPE_STM32L4X5_GPIO);
>       }
> +
> +    object_initialize_child(obj, "dm163", &s->dm163, TYPE_DM163);

The DM163 is another chip, not a component part of the SoC;
it belongs to the machine and should be created/wired in
b_l475e_iot01a_init(). Similarly to the IRQ splitters.

Keeping board component states in a Bl475eMachineState structure
could help organizing your model. You can find an example on how
extend the MachineState in hw/avr/arduino.c.

You might call qdev_pass_gpios() to exposes the SysCfg lines out
of the SoC.

Regards,

Phil.

