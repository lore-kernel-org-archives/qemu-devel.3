Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 98818CD5BAC
	for <qemu-devel@archiver.kernel.org>; Thu, 21 May 2026 08:58:13 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wPzDo-000122-7G; Thu, 21 May 2026 04:57:40 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@kaod.org>) id 1wPzDm-00010U-7s
 for qemu-devel@nongnu.org; Thu, 21 May 2026 04:57:38 -0400
Received: from smtpout4.mo533.mail-out.ovh.net ([46.105.32.238])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@kaod.org>) id 1wPzDe-0008Sg-68
 for qemu-devel@nongnu.org; Thu, 21 May 2026 04:57:37 -0400
Received: from director3.derp.mail-out.ovh.net
 (director3.derp.mail-out.ovh.net [152.228.215.222])
 by mo533.mail-out.ovh.net (Postfix) with ESMTPS id 4gLj2j23Lgz6Ckw;
 Thu, 21 May 2026 08:57:01 +0000 (UTC)
Received: from director3.derp.mail-out.ovh.net
 (director3.derp.mail-out.ovh.net. [127.0.0.1])
 by director3.derp.mail-out.ovh.net (inspect_sender_mail_agent) with SMTP
 for <jamin_lin@aspeedtech.com>; Thu, 21 May 2026 08:57:01 +0000 (UTC)
Received: from mta7.priv.ovhmail-u2.ea.mail.ovh.net (unknown [10.109.249.47])
 by director3.derp.mail-out.ovh.net (Postfix) with ESMTPS id
 4gLj2j0GP7z5vfw; Thu, 21 May 2026 08:57:01 +0000 (UTC)
Received: from kaod.org (unknown [10.1.6.1])
 (Authenticated sender: clg@kaod.org)
 by mta7.priv.ovhmail-u2.ea.mail.ovh.net (Postfix) with ESMTPSA id BA140203B6C; 
 Thu, 21 May 2026 08:56:59 +0000 (UTC)
Authentication-Results: garm.ovh; auth=pass
 (GARM-104R00533b20e0e-82b5-4fb0-8efa-dc9cd43adca3,
 155D954443A34AB19E7EFB78D45315E373F1C727) smtp.auth=clg@kaod.org
X-OVh-ClientIp: 82.64.250.170
Message-ID: <14262972-3693-4fdb-81cf-695f230d184c@kaod.org>
Date: Thu, 21 May 2026 10:56:59 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 4/4] hw/arm/aspeed: Add AST1040 EVB machine model
To: Jamin Lin <jamin_lin@aspeedtech.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 Steven Lee <steven_lee@aspeedtech.com>, Troy Lee <leetroy@gmail.com>,
 Kane Chen <kane_chen@aspeedtech.com>,
 Andrew Jeffery <andrew@codeconstruct.com.au>, Joel Stanley <joel@jms.id.au>,
 "open list:ASPEED BMCs" <qemu-arm@nongnu.org>,
 "open list:All patches CC here" <qemu-devel@nongnu.org>
Cc: Troy Lee <troy_lee@aspeedtech.com>
References: <20260521065203.3713466-1-jamin_lin@aspeedtech.com>
 <20260521065203.3713466-5-jamin_lin@aspeedtech.com>
Content-Language: en-US, fr
From: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@kaod.org>
Autocrypt: addr=clg@kaod.org; keydata=
 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
In-Reply-To: <20260521065203.3713466-5-jamin_lin@aspeedtech.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
x-ovh-tracer-id: 14473724778551487499
X-VR-SPAMSTATE: OK
X-VR-SPAMSCORE: -100
X-VR-SPAMCAUSE: dmFkZTGpXznD9slKRIXOZg7Wqf7oh8jfFCxgHm4cnuSK0dnNSuaPCO5yRzhbhzD0Rfo9VOmoJMXNODbfqdDBbGScohG0cnxEyXunktkNY1bOOHVGDJ3tvMyqZYILQyh9LasV42Qo4oFVQgaUyWr8D6Vf0KIpM+r/tAK2jRDyYdbXDKfHooQ3Fpe5l++YS1TcV3ZQP7SZILt8TXha5IQKiYkuZVvXHJeDFRV9B8LxQnV7S63gcdMNXlfROFDoprwZZrTO+vKGyS//un46qRJrPgOQTErhW3LzDfI+ifNIHvuSqXglQ8D/rtKbM/wBwdZSb7enPB4xJz9EC+59Iv3F+VojriMWK3PnDbNu1iX+hQvdl5UgX/xwKupDIbIrO5x4/BYyhWZUlrKUtmB9D923Vloe+wXVJB1BIuVwNZ2IHMF9FtFoB7QVUS8KMeYPL/PyqExTmMWKprU5xQsICHt9EMu0tA/zAo6qsacmAGeIr7pNkM3nal5YNwA7Lvw6OKpNN2Qv18NjUsbUgztZ+fnGrYBteYYhDoJROpPahgqBeBoyHmNfo11FElFQCMUsCNLZrbyH48NwwXkKva6ytnRWp3QfbEcUbVX75Ra2AvtiLbVFTeA42vZlQMySimrq71pat51/t6/PwdB+wjB683MjXSmmzVXeUlLkN11jkadRgL1xCFtAMg
DKIM-Signature: a=rsa-sha256; bh=9SD4CbHi8S3NxCsw12TxgaCVJT+ZcJAc883JxG4s7UA=; 
 c=relaxed/relaxed; d=kaod.org; h=From; s=ovhmo393970-selector1;
 t=1779353822; v=1;
 b=K73GpFO14oC+ofRO9G22THLTRT9eztZ9H+/cX3hVOvvBDcoeuY7nB5udce6PWxuU+WMqPMeo
 U8REQSTIbFoMeqbX29dMN95VGpHaRIsQxcGIvR37BU0AKpg0W+UUIW6eq/HSQ76i4PYFq6cRz3X
 1L+0gbF8Pj/KCsZiDF94Ec9bKzMxKV+w+I+mRzz6rY5EoQ1itwBc4zaMaCa9/C92QjAZuAMmmzx
 Q17YWD0NYFMI/vdTl6YadFQe/VT1ojlGeI1narlZSVW+yG6MpmEk4oyOtzFg5tjoQqkpyF2ZXit
 6vcMtphaz4oqWBTAOsYQijz4Ou4JYl1SNxqSqiNfa7Zig==
Received-SPF: pass client-ip=46.105.32.238; envelope-from=clg@kaod.org;
 helo=smtpout4.mo533.mail-out.ovh.net
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
List-Id: qemu development <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

On 5/21/26 08:52, Jamin Lin wrote:
> AST1040 is the next-generation device following AST1030 and is
> primarily designed as a bridge/BIC controller platform. Introduce
> a dedicated AST1040 EVB machine implementation for firmware
> development and validation.
> 
> Although the existing ast10x0 EVB machine code already provides
> a reusable minibmc initialization flow, AST1040 requires
> different platform settings, including:
> 
>    - Different SYSCLK frequency
>    - Different internal flash size
> 
> To avoid overloading the existing AST1030-specific helper,
> introduce a separate aspeed_bic_machine_init() implementation in
> a dedicated source file.
> 
> Signed-off-by: Jamin Lin <jamin_lin@aspeedtech.com>
> ---
>   hw/arm/aspeed_ast1040_evb.c | 72 +++++++++++++++++++++++++++++++++++++
>   hw/arm/meson.build          |  3 +-
>   2 files changed, 74 insertions(+), 1 deletion(-)
>   create mode 100644 hw/arm/aspeed_ast1040_evb.c


No functional test ?

> diff --git a/hw/arm/aspeed_ast1040_evb.c b/hw/arm/aspeed_ast1040_evb.c
> new file mode 100644
> index 0000000000..5851cf6967
> --- /dev/null
> +++ b/hw/arm/aspeed_ast1040_evb.c
> @@ -0,0 +1,72 @@
> +/*
> + * ASPEED AST1040 EVB
> + *
> + * Copyright (C) 2026 ASPEED Technology Inc.
> + *
> + * SPDX-License-Identifier: GPL-2.0-or-later
> + */
> +
> +#include "qemu/osdep.h"
> +#include "qapi/error.h"
> +#include "hw/arm/boot.h"
> +#include "hw/arm/machines-qom.h"
> +#include "hw/arm/aspeed.h"
> +#include "hw/arm/aspeed_soc.h"
> +#include "hw/core/qdev-clock.h"
> +#include "system/system.h"
> +
> +#define AST1040_INTERNAL_FLASH_SIZE (4 * MiB)
> +/* Main SYSCLK frequency in Hz (400MHz) */
> +#define SYSCLK_FRQ 400000000ULL
> +
> +static void aspeed_bic_machine_init(MachineState *machine)
> +{
> +    AspeedMachineState *bmc = ASPEED_MACHINE(machine);
> +    AspeedMachineClass *amc = ASPEED_MACHINE_GET_CLASS(machine);
> +    Clock *sysclk;
> +
> +    sysclk = clock_new(OBJECT(machine), "SYSCLK");
> +    clock_set_hz(sysclk, SYSCLK_FRQ);
> +
> +    bmc->soc = ASPEED_SOC(object_new(amc->soc_name));
> +    object_property_add_child(OBJECT(machine), "soc", OBJECT(bmc->soc));
> +    object_unref(OBJECT(bmc->soc));
> +    qdev_connect_clock_in(DEVICE(bmc->soc), "sysclk", sysclk);
> +
> +    object_property_set_link(OBJECT(bmc->soc), "memory",
> +                             OBJECT(get_system_memory()), &error_abort);
> +    aspeed_connect_serial_hds_to_uarts(bmc);
> +    qdev_realize(DEVICE(bmc->soc), NULL, &error_abort);
> +
> +    armv7m_load_kernel(ARM_CPU(first_cpu),
> +                       machine->kernel_filename,
> +                       0,
> +                       AST1040_INTERNAL_FLASH_SIZE);
> +}
> +
> +static void aspeed_machine_ast1040_evb_class_init(ObjectClass *oc,
> +                                                          const void *data)
> +{
> +    MachineClass *mc = MACHINE_CLASS(oc);
> +    AspeedMachineClass *amc = ASPEED_MACHINE_CLASS(oc);
> +
> +    mc->desc = "Aspeed AST1040 BIC EVB (Cortex-M4F)";
> +    amc->soc_name  = "ast1040-a0";
> +    amc->hw_strap1 = 0;
> +    amc->hw_strap2 = 0;
> +    mc->init       = aspeed_bic_machine_init;

   mc->default_ram_size = 0; ?

> +    amc->macs_mask = 0;
> +    amc->uart_default = ASPEED_DEV_UART12;
> +    aspeed_machine_class_init_cpus_defaults(mc);
> +}
> +
> +static const TypeInfo aspeed_ast1040_evb_types[] = {
> +    {
> +        .name           = MACHINE_TYPE_NAME("ast1040-evb"),
> +        .parent         = TYPE_ASPEED_MACHINE,
> +        .class_init     = aspeed_machine_ast1040_evb_class_init,
> +        .interfaces     = arm_machine_interfaces,
> +    }
> +};
> +
> +DEFINE_TYPES(aspeed_ast1040_evb_types)
> diff --git a/hw/arm/meson.build b/hw/arm/meson.build
> index fa3a848492..9b75cc7fb1 100644
> --- a/hw/arm/meson.build
> +++ b/hw/arm/meson.build
> @@ -63,7 +63,8 @@ arm_ss.add(when: 'CONFIG_ASPEED_SOC', if_true: files(
>     'aspeed_ast2600_rainier.c',
>     'aspeed_ast10x0.c',
>     'aspeed_ast10x0_evb.c',
> -  'aspeed_ast1040.c'))
> +  'aspeed_ast1040.c',
> +  'aspeed_ast1040_evb.c'))
>   arm_common_ss.add(when: ['CONFIG_ASPEED_SOC', 'TARGET_AARCH64'], if_true: files(
>     'aspeed_ast1700.c',
>     'aspeed_ast27x0.c',


