Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BF49DC4828D
	for <qemu-devel@archiver.kernel.org>; Wed,  7 Feb 2024 22:02:59 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rXpzu-0001H3-SZ; Wed, 07 Feb 2024 17:02:26 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rXpzs-0001Ga-VQ
 for qemu-devel@nongnu.org; Wed, 07 Feb 2024 17:02:25 -0500
Received: from mail-ej1-x62b.google.com ([2a00:1450:4864:20::62b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rXpzr-00008R-5r
 for qemu-devel@nongnu.org; Wed, 07 Feb 2024 17:02:24 -0500
Received: by mail-ej1-x62b.google.com with SMTP id
 a640c23a62f3a-a30e445602cso60075366b.0
 for <qemu-devel@nongnu.org>; Wed, 07 Feb 2024 14:02:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1707343341; x=1707948141; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=uAc1wvIUDxU1I9G8ZSlaEAqd9DpOun06YT3b5GbCdSU=;
 b=kWW7DxjJa2vJ24DjjHbrZI8NITOkxJPieqDFLWKG+2hR6mHF6jXXiFIWbYk4FK390C
 TyufxgNW1MxtmgduK6TTf2ZMc+zfXL1X+dBkxdPU5m6sCmVvlXNo1bw55vvlZ8PDp9bP
 vNN7ebrE256xWe/toazem+aowTsFDpBFFP9mO6gMiBO29+em0nndxOpDd5fsQzHZ108w
 21TYkC1h139SZcnjwokEC/eBp7ypIUYluxnH83jZNlvmRW0vM6ODirSDFXmo3w4PMjXS
 1W4OY+Deb5jeMLLX1UHaqxhb1Ck3wJIV3xXglXMdlwtC2CHs1hr6SCXZGa70iXRabj2U
 JMfQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1707343341; x=1707948141;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=uAc1wvIUDxU1I9G8ZSlaEAqd9DpOun06YT3b5GbCdSU=;
 b=EttQII5WPsoRzo+DBIDVleKSaORZT9n6ds7ExsWsw5VxinV7BHNBjx0aTom3syWkK2
 D09+89AFqvkp0c538HaC8Smphhn5Sxb0oTHzfQ4PjrYXr9KQIpndTv2mYwgnK6bowxWe
 S1x3VXPit/4LKIBBii/heLhDQGzT8tTJm4PL13e272frVwJrrzM/uv/iaW11DHMQRI/w
 MeHYRtCxDlDyJ7mhwT9xhcUJRe+v4UXrrEzMrOP7CTIAmvkYLHTyR+36dAhVFHfIcywK
 o8Ig9N/cYLU51YpQWnKBzizHojzb1YkitCikj5gRc/9hogQ0znnSzgscJxwk03T/fQho
 ttZg==
X-Gm-Message-State: AOJu0YxIaHtBvnbAkJwmDBF0e6PACKp8D1GRtC9twuaxFi/hZhuJP3z4
 kqga/m2vwUcrutRBNOBpTqaPsBQgsqK9vKYcoCLNEKqDA2FepgvbHXg1fOs6iVE=
X-Google-Smtp-Source: AGHT+IFRukTQdds0W/rmZrELSCKmQHRV4Q+xo29lgsdHx7j4JvKjnRL98byTtnBUT/5/kpoD9lszDg==
X-Received: by 2002:a17:906:5fc2:b0:a38:3fbb:9186 with SMTP id
 k2-20020a1709065fc200b00a383fbb9186mr762517ejv.29.1707343341330; 
 Wed, 07 Feb 2024 14:02:21 -0800 (PST)
X-Forwarded-Encrypted: i=1;
 AJvYcCWl3SMw5VtZQQCXPxiwYwN+K16ID0LOiFhUeQQ2r5Ya87rQzjq78EvmAHDqYFLNu20g0JmBKykityhVJCZ4bkcPrjq6OwBBB5zEugKP/86GOIkChdCyvkwpQtBoxm3Dt9CUZWkHLfpltfSABbNEShMXOfFJTOsRS0SrS193oKYIpTIKXaRM+ZqG06PtwFrP5Pt4o9/2iWNSpRBEj5oK63wpxHR0t6exGfSYPIsW9ZAVz3lQHwPddA1Js1kbLu6sYWIisJGGcXZW3CXgQvrbOCbfjei8kjwoj2u6tuBvSMomzMUOkj1hnFA1QBDO1yALocFcCHNcI5S7bS3Q16+egt7XM4v4GSWNHiLKmKs=
Received: from [192.168.69.100] ([176.187.214.82])
 by smtp.gmail.com with ESMTPSA id
 jt20-20020a170906ca1400b00a3843b13729sm1195671ejb.35.2024.02.07.14.02.19
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 07 Feb 2024 14:02:20 -0800 (PST)
Message-ID: <5a7594d9-3fbd-4d90-a5f9-81b7b845fba7@linaro.org>
Date: Wed, 7 Feb 2024 23:02:18 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v8 2/3] hw/arm: Connect STM32L4x5 EXTI to STM32L4x5 SoC
Content-Language: en-US
To: Arnaud Minier <arnaud.minier@telecom-paris.fr>,
 =?UTF-8?Q?In=C3=A8s_Varhol?= <ines.varhol@telecom-paris.fr>,
 qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>, Thomas Huth <thuth@redhat.com>,
 Laurent Vivier <lvivier@redhat.com>, qemu-arm@nongnu.org,
 Samuel Tardieu <samuel.tardieu@telecom-paris.fr>,
 Alistair Francis <alistair@alistair23.me>,
 Alistair Francis <alistair.francis@wdc.com>
References: <20240109160658.311932-1-ines.varhol@telecom-paris.fr>
 <20240109160658.311932-3-ines.varhol@telecom-paris.fr>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20240109160658.311932-3-ines.varhol@telecom-paris.fr>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::62b;
 envelope-from=philmd@linaro.org; helo=mail-ej1-x62b.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
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

Hi Inès,

(this is now commit 52671f69f7).

On 9/1/24 17:06, Inès Varhol wrote:
> Tested-by: Philippe Mathieu-Daudé <philmd@linaro.org>
> Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
> Reviewed-by: Alistair Francis <alistair.francis@wdc.com>
> Signed-off-by: Arnaud Minier <arnaud.minier@telecom-paris.fr>
> Signed-off-by: Inès Varhol <ines.varhol@telecom-paris.fr>
> ---
>   hw/arm/Kconfig                 |  1 +
>   hw/arm/stm32l4x5_soc.c         | 52 +++++++++++++++++++++++++++++++++-
>   include/hw/arm/stm32l4x5_soc.h |  3 ++
>   3 files changed, 55 insertions(+), 1 deletion(-)


> +#define NUM_EXTI_IRQ 40
> +/* Match exti line connections with their CPU IRQ number */
> +/* See Vector Table (Reference Manual p.396) */
> +static const int exti_irq[NUM_EXTI_IRQ] = {
> +    6,                      /* GPIO[0]                 */
> +    7,                      /* GPIO[1]                 */
> +    8,                      /* GPIO[2]                 */
> +    9,                      /* GPIO[3]                 */
> +    10,                     /* GPIO[4]                 */
> +    23, 23, 23, 23, 23,     /* GPIO[5..9]              */
> +    40, 40, 40, 40, 40, 40, /* GPIO[10..15]            */

I'm sorry because I missed that earlier, and I'm surprised
you aren't chasing weird bugs. Due to how QEMU IRQs are
implemented, we can not wire multiple input lines to the same
output without using an intermediate "OR gate". We model it
as TYPE_OR_IRQ. See the comment in "hw/qdev-core.h" added in
commit cd07d7f9f5 ("qdev: Document GPIO related functions"):

  * It is not valid to try to connect one outbound GPIO to multiple
  * qemu_irqs at once, or to connect multiple outbound GPIOs to the
  * same qemu_irq. (Warning: there is no assertion or other guard to
  * catch this error: the model will just not do the right thing.)
  * Instead, for fan-out you can use the TYPE_SPLIT_IRQ device: connect
  * a device's outbound GPIO to the splitter's input, and connect each
  * of the splitter's outputs to a different device.  For fan-in you
  * can use the TYPE_OR_IRQ device, which is a model of a logical OR
  * gate with multiple inputs and one output.

So for example for the GPIO[10..15] you need to create a 6-line
OR gate as (totally untested):

   /* 6-line OR IRQ gate */
   Object *orgate40 = object_new(TYPE_OR_IRQ);
   object_property_set_int(orgate40, "num-lines", 6, &error_fatal);
   qdev_realize(DEVICE(orgate), NULL, &error_fatal);

   /* OR gate -> IRQ #40 */
   qdev_connect_gpio_out(DEVICE(orgate40), 0,
                         qdev_get_gpio_in(armv7m, 40));

   /* EXTI GPIO[10..15] -> OR gate */
   for (unsigned i = 0; i < 6; i++) {
       sysbus_connect_irq(SYS_BUS_DEVICE(&s->exti), 10 + i,
                          qdev_get_gpio_in(DEVICE(orgate40), i));
   }

> +    1,                      /* PVD                     */
> +    67,                     /* OTG_FS_WKUP, Direct     */
> +    41,                     /* RTC_ALARM               */
> +    2,                      /* RTC_TAMP_STAMP2/CSS_LSE */
> +    3,                      /* RTC wakeup timer        */
> +    63,                     /* COMP1                   */
> +    63,                     /* COMP2                   */
> +    31,                     /* I2C1 wakeup, Direct     */
> +    33,                     /* I2C2 wakeup, Direct     */
> +    72,                     /* I2C3 wakeup, Direct     */
> +    37,                     /* USART1 wakeup, Direct   */
> +    38,                     /* USART2 wakeup, Direct   */
> +    39,                     /* USART3 wakeup, Direct   */
> +    52,                     /* UART4 wakeup, Direct    */
> +    53,                     /* UART4 wakeup, Direct    */
> +    70,                     /* LPUART1 wakeup, Direct  */
> +    65,                     /* LPTIM1, Direct          */
> +    66,                     /* LPTIM2, Direct          */
> +    76,                     /* SWPMI1 wakeup, Direct   */
> +    1,                      /* PVM1 wakeup             */
> +    1,                      /* PVM2 wakeup             */
> +    1,                      /* PVM3 wakeup             */
> +    1,                      /* PVM4 wakeup             */
> +    78                      /* LCD wakeup, Direct      */
> +};

> +    busdev = SYS_BUS_DEVICE(&s->exti);
> +    if (!sysbus_realize(busdev, errp)) {
> +        return;
> +    }
> +    sysbus_mmio_map(busdev, 0, EXTI_ADDR);
> +    for (unsigned i = 0; i < NUM_EXTI_IRQ; i++) {
> +        sysbus_connect_irq(busdev, i, qdev_get_gpio_in(armv7m, exti_irq[i]));

                                                               ^^^^^^^^^^
> +    }
Regards,

Phil.

