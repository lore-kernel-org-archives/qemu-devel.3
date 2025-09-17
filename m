Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6EC06CA0EE8
	for <qemu-devel@archiver.kernel.org>; Wed, 17 Sep 2025 08:27:28 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uynVY-0004TE-Tf; Wed, 17 Sep 2025 04:27:21 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <SRS0=uXDK=34=kaod.org=clg@ozlabs.org>)
 id 1uynVF-0004Lx-VW; Wed, 17 Sep 2025 04:27:02 -0400
Received: from mail.ozlabs.org ([2404:9400:2221:ea00::3])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <SRS0=uXDK=34=kaod.org=clg@ozlabs.org>)
 id 1uynVD-0005Ii-0p; Wed, 17 Sep 2025 04:27:01 -0400
Received: from mail.ozlabs.org (mail.ozlabs.org [IPv6:2404:9400:2221:ea00::3])
 by gandalf.ozlabs.org (Postfix) with ESMTP id 4cRX1W10q0z4wDV;
 Wed, 17 Sep 2025 18:26:55 +1000 (AEST)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits))
 (Client did not present a certificate)
 by mail.ozlabs.org (Postfix) with ESMTPSA id 4cRX1R3zycz4wCq;
 Wed, 17 Sep 2025 18:26:51 +1000 (AEST)
Message-ID: <d54e0718-480a-46ea-88fd-7ca2f72117d0@kaod.org>
Date: Wed, 17 Sep 2025 10:26:49 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [SPAM] [PATCH v1 2/6] hw/arm/aspeed: Add LTPI controller
To: Kane Chen <kane_chen@aspeedtech.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 Steven Lee <steven_lee@aspeedtech.com>, Troy Lee <leetroy@gmail.com>,
 Jamin Lin <jamin_lin@aspeedtech.com>,
 Andrew Jeffery <andrew@codeconstruct.com.au>, Joel Stanley <joel@jms.id.au>,
 "open list:ASPEED BMCs" <qemu-arm@nongnu.org>,
 "open list:All patches CC here" <qemu-devel@nongnu.org>
Cc: troy_lee@aspeedtech.com
References: <20250917013143.1600377-1-kane_chen@aspeedtech.com>
 <20250917013143.1600377-3-kane_chen@aspeedtech.com>
From: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@kaod.org>
Content-Language: en-US, fr
Autocrypt: addr=clg@kaod.org; keydata=
 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
In-Reply-To: <20250917013143.1600377-3-kane_chen@aspeedtech.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2404:9400:2221:ea00::3;
 envelope-from=SRS0=uXDK=34=kaod.org=clg@ozlabs.org; helo=mail.ozlabs.org
X-Spam_score_int: -41
X-Spam_score: -4.2
X-Spam_bar: ----
X-Spam_report: (-4.2 / 5.0 requ) BAYES_00=-1.9,
 HEADER_FROM_DIFFERENT_DOMAINS=0.001, RCVD_IN_DNSWL_MED=-2.3,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

Hello,

On 9/17/25 03:31, Kane Chen wrote:
> From: Kane-Chen-AS <kane_chen@aspeedtech.com>
> 
> AST27x0 platforms support two LTPI controllers. Each LTPI controller

What is an LTPI controller ? Please provide a small description.

> has one set of device registers, one set of PHY register and one OEM
> channel for AST1700 connection.
> 
> Signed-off-by: Kane-Chen-AS <kane_chen@aspeedtech.com>
> ---
>   include/hw/arm/aspeed_soc.h   |   4 ++
>   include/hw/misc/aspeed_ltpi.h |  25 ++++++++
>   hw/arm/aspeed_ast27x0.c       |  28 +++++++++
>   hw/misc/aspeed_ltpi.c         | 111 ++++++++++++++++++++++++++++++++++
>   hw/misc/meson.build           |   1 +
>   5 files changed, 169 insertions(+)
>   create mode 100644 include/hw/misc/aspeed_ltpi.h
>   create mode 100644 hw/misc/aspeed_ltpi.c
> 
> diff --git a/include/hw/arm/aspeed_soc.h b/include/hw/arm/aspeed_soc.h
> index 77263cc6ec..72eefb0327 100644
> --- a/include/hw/arm/aspeed_soc.h
> +++ b/include/hw/arm/aspeed_soc.h
> @@ -41,6 +41,7 @@
>   #include "hw/fsi/aspeed_apb2opb.h"
>   #include "hw/char/serial-mm.h"
>   #include "hw/intc/arm_gicv3.h"
> +#include "hw/misc/aspeed_ltpi.h"
>   
>   #define ASPEED_SPIS_NUM  3
>   #define ASPEED_EHCIS_NUM 4
> @@ -104,6 +105,7 @@ struct AspeedSoCState {
>       UnimplementedDeviceState ltpi;
>       UnimplementedDeviceState jtag[ASPEED_JTAG_NUM];
>       AspeedAPB2OPBState fsi[2];
> +    AspeedLTPIState ltpi_ctrl[ASPEED_IOEXP_NUM];
>       uint8_t ioexp_num;
>   };
>   
> @@ -287,6 +289,8 @@ enum {
>       ASPEED_GIC_REDIST,
>       ASPEED_DEV_IPC0,
>       ASPEED_DEV_IPC1,
> +    ASPEED_DEV_LTPI_CTRL1,
> +    ASPEED_DEV_LTPI_CTRL2,
>   };
>   
>   qemu_irq aspeed_soc_get_irq(AspeedSoCState *s, int dev);
> diff --git a/include/hw/misc/aspeed_ltpi.h b/include/hw/misc/aspeed_ltpi.h
> new file mode 100644
> index 0000000000..2c31a555dd
> --- /dev/null
> +++ b/include/hw/misc/aspeed_ltpi.h
> @@ -0,0 +1,25 @@
> +/*
> + * ASPEED LTPI Controller
> + *
> + * Copyright (C) 2025 ASPEED Technology Inc.
> + *
> + * SPDX-License-Identifier: GPL-2.0-or-later
> + */
> +#ifndef ASPEED_LTPI_H
> +#define ASPEED_LTPI_H
> +
> +#include "hw/sysbus.h"
> +
> +#define TYPE_ASPEED_LTPI "aspeed.ltpi-ctrl"
> +OBJECT_DECLARE_SIMPLE_TYPE(AspeedLTPIState, ASPEED_LTPI)
> +
> +#define ASPEED_LTPI_NR_REGS  (0x900 >> 2)
> +
> +struct AspeedLTPIState {
> +    SysBusDevice parent;
> +    MemoryRegion mmio;
> +
> +    uint32_t regs[ASPEED_LTPI_NR_REGS];
> +};
> +
> +#endif /* ASPEED_LTPI_H */
> diff --git a/hw/arm/aspeed_ast27x0.c b/hw/arm/aspeed_ast27x0.c
> index 6aa3841b69..3f93554027 100644
> --- a/hw/arm/aspeed_ast27x0.c
> +++ b/hw/arm/aspeed_ast27x0.c
> @@ -80,6 +80,8 @@ static const hwaddr aspeed_soc_ast2700_memmap[] = {
>       [ASPEED_DEV_UART10]    =  0x14C33900,
>       [ASPEED_DEV_UART11]    =  0x14C33A00,
>       [ASPEED_DEV_UART12]    =  0x14C33B00,
> +    [ASPEED_DEV_LTPI_CTRL1] =  0x14C34000,
> +    [ASPEED_DEV_LTPI_CTRL2] =  0x14C35000,
>       [ASPEED_DEV_WDT]       =  0x14C37000,
>       [ASPEED_DEV_SPI_BOOT]  =  0x100000000,
>       [ASPEED_DEV_LTPI]      =  0x300000000,
> @@ -531,6 +533,12 @@ static void aspeed_soc_ast2700_init(Object *obj)
>                               TYPE_UNIMPLEMENTED_DEVICE);
>   }
>   
> +static void aspeed_ast2700_ast1700_init(AspeedSoCState *s, int i)
> +{
> +    object_initialize_child(OBJECT(s), "ltpi-ctrl[*]",
> +                            &s->ltpi_ctrl[i], TYPE_ASPEED_LTPI);


This should be under aspeed_soc_ast2700_init()

> +}
> +
>   /*
>    * ASPEED ast2700 has 0x0 as cluster ID
>    *
> @@ -610,6 +618,20 @@ static bool aspeed_soc_ast2700_gic_realize(DeviceState *dev, Error **errp)
>       return true;
>   }
>   
> +static void aspeed_soc_ast2700_ast1700_realize(Aspeed27x0SoCState *a,
> +                                               AspeedSoCState *s,
> +                                               AspeedSoCClass *sc,
> +                                               int index, Error **errp)

Please move the code under aspeed_soc_ast2700_realize().

> +{
> +    AspeedLTPIState *ltpi_ctrl = ASPEED_LTPI(&s->ltpi_ctrl[index]);
> +    hwaddr ltpi_base = sc->memmap[ASPEED_DEV_LTPI_CTRL1 + index];
> +
> +    if (!sysbus_realize(SYS_BUS_DEVICE(ltpi_ctrl), errp)) {
> +        return;
> +    }
> +    aspeed_mmio_map(s, SYS_BUS_DEVICE(ltpi_ctrl), 0, ltpi_base);
> +}
> +
>   static void aspeed_soc_ast2700_realize(DeviceState *dev, Error **errp)
>   {
>       int i;
> @@ -936,6 +958,12 @@ static void aspeed_soc_ast2700_realize(DeviceState *dev, Error **errp)
>       sysbus_connect_irq(SYS_BUS_DEVICE(&s->hace), 0,
>                          aspeed_soc_get_irq(s, ASPEED_DEV_HACE));
>   
> +    /* I/O Expander */
> +    for (i = 0; i < s->ioexp_num; i++) {
> +        aspeed_ast2700_ast1700_init(s, i);

object_initialize_child() should not called at realize time when
it can be avoided.


> +        aspeed_soc_ast2700_ast1700_realize(a, s, sc, i, errp);
> +    }
> +
>       aspeed_mmio_map_unimplemented(s, SYS_BUS_DEVICE(&s->dpmcu),
>                                     "aspeed.dpmcu",
>                                     sc->memmap[ASPEED_DEV_DPMCU],
> diff --git a/hw/misc/aspeed_ltpi.c b/hw/misc/aspeed_ltpi.c
> new file mode 100644
> index 0000000000..0c9cf40094
> --- /dev/null
> +++ b/hw/misc/aspeed_ltpi.c
> @@ -0,0 +1,111 @@
> +/*
> + * ASPEED LTPI Controller
> + *
> + * Copyright (C) 2025 ASPEED Technology Inc.
> + *
> + * SPDX-License-Identifier: GPL-2.0-or-later
> + */
> +
> +#include "qemu/osdep.h"
> +#include "qemu/log.h"
> +#include "migration/vmstate.h"
> +#include "hw/misc/aspeed_ltpi.h"
> +
> +#define LTPI_LINK_MNG 0x42
> +#define LTPI_PHY_MODE 0x80
> +
> +static uint64_t ltpi_read(void *opaque, hwaddr offset, unsigned size)
> +{
> +    AspeedLTPIState *s = opaque;
> +    uint32_t idx = offset >> 2;
> +
> +    if (idx >= ASPEED_LTPI_NR_REGS) {
> +        qemu_log_mask(LOG_GUEST_ERROR,
> +                      "%s: bad offset=0x%" HWADDR_PRIx "\n",
> +                      TYPE_ASPEED_LTPI, offset);

if the MMIO region is sized correctly, it should not be necessary to
test for invalid offsets. You could add an assert() though.

> +        return 0;
> +    }
> +
> +    return s->regs[idx];
> +}
> +
> +static void ltpi_write(void *opaque, hwaddr offset, uint64_t val, unsigned size)
> +{
> +    AspeedLTPIState *s = opaque;
> +    uint32_t idx = offset >> 2;
> +
> +    if (idx >= ASPEED_LTPI_NR_REGS) {
> +        qemu_log_mask(LOG_GUEST_ERROR,
> +                      "%s: bad offset=0x%" HWADDR_PRIx " val=0x%" PRIx64 "\n",
> +                      TYPE_ASPEED_LTPI, offset, val);
> +        return;
> +    }
> +
> +    switch (offset) {
> +    default:
> +        s->regs[idx] = (uint32_t)val;
> +        break;
> +    }
> +}
> +
> +static const MemoryRegionOps ltpi_ops = {
> +    .read = ltpi_read,
> +    .write = ltpi_write,
> +    .endianness = DEVICE_LITTLE_ENDIAN,
> +    .valid = {
> +        .min_access_size = 1,
> +        .max_access_size = 4,
> +    },
> +};
> +
> +static void ltpi_reset(DeviceState *dev)
> +{
> +    AspeedLTPIState *s = ASPEED_LTPI(dev);
> +    memset(s->regs, 0, sizeof(s->regs));
> +    /* set default values */
> +    s->regs[LTPI_LINK_MNG] = 0x11900007;
> +    s->regs[LTPI_PHY_MODE] = 0x2;
> +}
> +
> +
> +static const VMStateDescription vmstate_ltpi = {
> +    .name = TYPE_ASPEED_LTPI,
> +    .version_id = 1,
> +    .minimum_version_id = 1,
> +    .fields = (VMStateField[]) {
> +        VMSTATE_UINT32_ARRAY(regs, AspeedLTPIState,
> +                             ASPEED_LTPI_NR_REGS),
> +        VMSTATE_END_OF_LIST()
> +    }
> +};
> +
> +static void ltpi_realize(DeviceState *dev, Error **errp)
> +{
> +    AspeedLTPIState *s = ASPEED_LTPI(dev);
> +
> +    memory_region_init_io(&s->mmio, OBJECT(s), &ltpi_ops, s,
> +                          TYPE_ASPEED_LTPI, ASPEED_LTPI_NR_REGS);
> +    sysbus_init_mmio(SYS_BUS_DEVICE(s), &s->mmio);
> +}
> +
> +static void ltpi_class_init(ObjectClass *klass, const void *data)
> +{
> +    DeviceClass *dc = DEVICE_CLASS(klass);
> +    dc->realize = ltpi_realize;
> +    dc->vmsd = &vmstate_ltpi;
> +    device_class_set_legacy_reset(dc, ltpi_reset);
> +}
> +
> +static const TypeInfo ltpi_info = {
> +    .name          = TYPE_ASPEED_LTPI,
> +    .parent        = TYPE_SYS_BUS_DEVICE,
> +    .instance_size = sizeof(AspeedLTPIState),
> +    .class_init    = ltpi_class_init,
> +};
> +
> +static void ltpi_register_types(void)
> +{
> +    type_register_static(&ltpi_info);
> +}
> +
> +type_init(ltpi_register_types);
> diff --git a/hw/misc/meson.build b/hw/misc/meson.build
> index b1d8d8e5d2..45b16e7797 100644
> --- a/hw/misc/meson.build
> +++ b/hw/misc/meson.build
> @@ -136,6 +136,7 @@ system_ss.add(when: 'CONFIG_ASPEED_SOC', if_true: files(
>     'aspeed_hace.c',
>     'aspeed_i3c.c',
>     'aspeed_lpc.c',
> +  'aspeed_ltpi.c',
>     'aspeed_scu.c',
>     'aspeed_sbc.c',
>     'aspeed_sdmc.c',


Thanks,

C.



