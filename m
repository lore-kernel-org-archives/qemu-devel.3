Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3ED1EC4345F
	for <qemu-devel@archiver.kernel.org>; Mon, 15 Apr 2024 09:42:01 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rwIqI-0003uC-2V; Mon, 15 Apr 2024 05:41:39 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rwIq4-0003tN-HG
 for qemu-devel@nongnu.org; Mon, 15 Apr 2024 05:41:25 -0400
Received: from mail-lj1-x229.google.com ([2a00:1450:4864:20::229])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rwIpz-0005jt-QZ
 for qemu-devel@nongnu.org; Mon, 15 Apr 2024 05:41:24 -0400
Received: by mail-lj1-x229.google.com with SMTP id
 38308e7fff4ca-2d8b194341eso24822731fa.3
 for <qemu-devel@nongnu.org>; Mon, 15 Apr 2024 02:41:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1713174075; x=1713778875; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=CmaCiUrvyVtRYi9Y9EJpG/Va5Q4CHt5H8x2chPqH73g=;
 b=wTPgWQajlmetO2G3iUq5bHCd/TSg59g+yopRV3Bs/SH9elblk+p66iapJQBMvpvDuG
 8sZXafgN8hubkzVh796P7M1L/e462yyszc11QKmaVUfEVYmgCFAACGxliV+kFEQcZeul
 tOIPRhsGKGEBQXL4gtI/frz4OZQuYdys17kP/ihvZDbHyDJ4SHkkvMZ8iScTb9sAurAX
 rUTI3uWNX1qwyJcNV6EBwbznud5j6ftAn38RF8QlYRW5ks5uWVi+FPq+4zvkZMKKaWd9
 Iwm5BWVnI4LzAELIXpQS/Cszglc8P1TTahV5+ZY1Zt1J/bi0KLIBSq+BG3nfIS46u7kc
 Wzgg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1713174075; x=1713778875;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=CmaCiUrvyVtRYi9Y9EJpG/Va5Q4CHt5H8x2chPqH73g=;
 b=Ff2YknvNPQ6ESB5buyMagce33Y5+Xmbh914VACh8bbs2omY+FN6ZzmQ+Lx6u/hH8ZX
 ji4e1vTCN7NivGJRkzLeGYu6h2ltoF9ujA/8ekJWmdhgZE9EPTXXFIQ5xp4wtbRj7liT
 wDL4w97Y6GydXHdgsELErOgu81hkD/FF1NPiL2PNq7MH3PQpRKidbSOCGJYXMr5JRRG6
 t2hDWwTX3on0ix3CFxFR3wYgE0XGWzdu1XTPzbFhEL3cFvkjt02YG/c3lMRVI0KutQx6
 YXqXp7qOPauLZgirBKq3tn6xp1PJfldzeazzX5Szzrp70YrommrUp/TFIHIMTsCVnUCm
 eXMg==
X-Forwarded-Encrypted: i=1;
 AJvYcCWhn2EeWiicbq9AVOh5eZjHcmpNE3HGeCIS2eek0nUq6DY6hZqUH24Y3gqzvgJuXfVV4ymzW43UDrAqUW5vMfCpPIGR2vY=
X-Gm-Message-State: AOJu0Yy1F0KwABo8aQQC1iuJKnEy32nwQjndpX3/9lAFNzH3//QzZ4bY
 vVpCMhQV76w/Xy8KTjJaYdHrylE0RYaBGyDYT1DXbvRC7FON0BmqYInKT0DHUTg=
X-Google-Smtp-Source: AGHT+IH3umij8ke0AmNCEUyq9JWqzhFxI9R5CFORD4r/GcVefgQTaxAk0axSyx3Si9mxhBpiraJNXg==
X-Received: by 2002:a2e:9b49:0:b0:2d8:df61:9c6c with SMTP id
 o9-20020a2e9b49000000b002d8df619c6cmr5895426ljj.20.1713174074947; 
 Mon, 15 Apr 2024 02:41:14 -0700 (PDT)
Received: from [192.168.69.100] ([176.176.132.126])
 by smtp.gmail.com with ESMTPSA id
 ay36-20020a05600c1e2400b004186df974f1sm1897343wmb.33.2024.04.15.02.41.13
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 15 Apr 2024 02:41:14 -0700 (PDT)
Message-ID: <beef0bc3-7964-4f41-af51-374b84ba20aa@linaro.org>
Date: Mon, 15 Apr 2024 11:41:12 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 4/5] hw/arm : Connect DM163 to B-L475E-IOT01A
To: =?UTF-8?Q?In=C3=A8s_Varhol?= <ines.varhol@telecom-paris.fr>,
 qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>, Thomas Huth <thuth@redhat.com>,
 =?UTF-8?Q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>,
 qemu-arm@nongnu.org, Laurent Vivier <lvivier@redhat.com>,
 Samuel Tardieu <sam@rfc1149.net>,
 Arnaud Minier <arnaud.minier@telecom-paris.fr>,
 Peter Maydell <peter.maydell@linaro.org>
References: <20240414130604.182059-1-ines.varhol@telecom-paris.fr>
 <20240414130604.182059-5-ines.varhol@telecom-paris.fr>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20240414130604.182059-5-ines.varhol@telecom-paris.fr>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::229;
 envelope-from=philmd@linaro.org; helo=mail-lj1-x229.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

On 14/4/24 15:05, Inès Varhol wrote:
> Signed-off-by: Arnaud Minier <arnaud.minier@telecom-paris.fr>
> Signed-off-by: Inès Varhol <ines.varhol@telecom-paris.fr>
> ---
>   hw/arm/b-l475e-iot01a.c | 59 +++++++++++++++++++++++++++++++++++++++--
>   hw/arm/Kconfig          |  1 +
>   2 files changed, 58 insertions(+), 2 deletions(-)


> +/*
> + * There are actually 14 input pins in the DM163 device.
> + * Here the DM163 input pin EN isn't connected to the STM32L4x5
> + * GPIOs as the IM120417002 colors shield doesn't actually use
> + * this pin to drive the RGB matrix.
> + */
> +#define NUM_DM163_INPUTS 13
> +
> +static const int dm163_input[NUM_DM163_INPUTS] = {

s/int/unsigned/

> +    1 * GPIO_NUM_PINS + 2,  /* ROW0  PB2       */
> +    0 * GPIO_NUM_PINS + 15, /* ROW1  PA15      */
> +    0 * GPIO_NUM_PINS + 2,  /* ROW2  PA2       */
> +    0 * GPIO_NUM_PINS + 7,  /* ROW3  PA7       */
> +    0 * GPIO_NUM_PINS + 6,  /* ROW4  PA6       */
> +    0 * GPIO_NUM_PINS + 5,  /* ROW5  PA5       */
> +    1 * GPIO_NUM_PINS + 0,  /* ROW6  PB0       */
> +    0 * GPIO_NUM_PINS + 3,  /* ROW7  PA3       */
> +    0 * GPIO_NUM_PINS + 4,  /* SIN (SDA) PA4   */
> +    1 * GPIO_NUM_PINS + 1,  /* DCK (SCK) PB1   */
> +    2 * GPIO_NUM_PINS + 3,  /* RST_B (RST) PC3 */
> +    2 * GPIO_NUM_PINS + 4,  /* LAT_B (LAT) PC4 */
> +    2 * GPIO_NUM_PINS + 5,  /* SELBK (SB)  PC5 */
> +};
>   
>   #define TYPE_B_L475E_IOT01A MACHINE_TYPE_NAME("b-l475e-iot01a")
>   OBJECT_DECLARE_SIMPLE_TYPE(Bl475eMachineState, B_L475E_IOT01A)
> @@ -39,12 +66,16 @@ typedef struct Bl475eMachineState {
>       MachineState parent_obj;
>   
>       Stm32l4x5SocState soc;
> +    SplitIRQ gpio_splitters[NUM_DM163_INPUTS];
> +    DM163State dm163;
>   } Bl475eMachineState;
>   
>   static void bl475e_init(MachineState *machine)
>   {
>       Bl475eMachineState *s = B_L475E_IOT01A(machine);
>       const Stm32l4x5SocClass *sc;
> +    DeviceState *dev, *gpio_out_splitter;
> +    int gpio, pin;

unsigned.

>   
>       object_initialize_child(OBJECT(machine), "soc", &s->soc,
>                               TYPE_STM32L4X5XG_SOC);
> @@ -53,6 +84,30 @@ static void bl475e_init(MachineState *machine)
>       sc = STM32L4X5_SOC_GET_CLASS(&s->soc);
>       armv7m_load_kernel(ARM_CPU(first_cpu),
>           machine->kernel_filename, 0, sc->flash_size);
> +
> +    if (object_class_by_name("dm163")) {

TYPE_DM163

> +        object_initialize_child(OBJECT(machine), "dm163",
> +                                &s->dm163, TYPE_DM163);
> +        dev = DEVICE(&s->dm163);
> +        qdev_realize(dev, NULL, &error_abort);

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>


