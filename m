Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B6A7CC48BF6
	for <qemu-devel@archiver.kernel.org>; Mon,  4 Mar 2024 14:36:39 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rh9QS-0002nz-4l; Mon, 04 Mar 2024 09:36:20 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <SRS0=daq9=KK=kaod.org=clg@ozlabs.org>)
 id 1rh9QQ-0002n9-LF; Mon, 04 Mar 2024 09:36:18 -0500
Received: from mail.ozlabs.org ([2404:9400:2221:ea00::3]
 helo=gandalf.ozlabs.org)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <SRS0=daq9=KK=kaod.org=clg@ozlabs.org>)
 id 1rh9QN-0004pd-1P; Mon, 04 Mar 2024 09:36:17 -0500
Received: from gandalf.ozlabs.org (mail.ozlabs.org
 [IPv6:2404:9400:2221:ea00::3])
 by gandalf.ozlabs.org (Postfix) with ESMTP id 4TpLq04RJyz4wnq;
 Tue,  5 Mar 2024 01:36:12 +1100 (AEDT)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits))
 (No client certificate requested)
 by mail.ozlabs.org (Postfix) with ESMTPSA id 4TpLpx4pXjz4wcJ;
 Tue,  5 Mar 2024 01:36:09 +1100 (AEDT)
Message-ID: <0a9edbde-3bda-425a-8235-41e4204abb16@kaod.org>
Date: Mon, 4 Mar 2024 15:36:07 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 2/9] aspeed/sli: Add AST2700 support
Content-Language: en-US, fr
To: Jamin Lin <jamin_lin@aspeedtech.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 Andrew Jeffery <andrew@codeconstruct.com.au>, Joel Stanley <joel@jms.id.au>,
 Alistair Francis <alistair@alistair23.me>,
 "open list:ASPEED BMCs" <qemu-arm@nongnu.org>,
 "open list:All patches CC here" <qemu-devel@nongnu.org>
Cc: troy_lee@aspeedtech.com, yunlin.tang@aspeedtech.com
References: <20240304092934.1953198-1-jamin_lin@aspeedtech.com>
 <20240304092934.1953198-3-jamin_lin@aspeedtech.com>
From: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@kaod.org>
In-Reply-To: <20240304092934.1953198-3-jamin_lin@aspeedtech.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2404:9400:2221:ea00::3;
 envelope-from=SRS0=daq9=KK=kaod.org=clg@ozlabs.org; helo=gandalf.ozlabs.org
X-Spam_score_int: -39
X-Spam_score: -4.0
X-Spam_bar: ----
X-Spam_report: (-4.0 / 5.0 requ) BAYES_00=-1.9,
 HEADER_FROM_DIFFERENT_DOMAINS=0.249, RCVD_IN_DNSWL_MED=-2.3,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001,
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

On 3/4/24 10:29, Jamin Lin wrote:
> AST2700 SLI engine is designed to accelerate the
> throughput between cross-die connections.
> It have CPU_SLI at CPU die and IO_SLI at IO die.
> 
> Introduce new ast2700_sli and ast2700_sliio class
> with instance_init and realize handlers.

This should say that the implementation is a dummy one.

> 
> Signed-off-by: Troy Lee <troy_lee@aspeedtech.com>
> Signed-off-by: Jamin Lin <jamin_lin@aspeedtech.com>
> ---
>   hw/misc/aspeed_sli.c         | 179 +++++++++++++++++++++++++++++++++++
>   hw/misc/meson.build          |   3 +-
>   hw/misc/trace-events         |   7 ++
>   include/hw/misc/aspeed_sli.h |  32 +++++++
>   4 files changed, 220 insertions(+), 1 deletion(-)
>   create mode 100644 hw/misc/aspeed_sli.c
>   create mode 100644 include/hw/misc/aspeed_sli.h
> 
> diff --git a/hw/misc/aspeed_sli.c b/hw/misc/aspeed_sli.c
> new file mode 100644
> index 0000000000..4af42f145c
> --- /dev/null
> +++ b/hw/misc/aspeed_sli.c
> @@ -0,0 +1,179 @@
> +/*
> + * ASPEED SLI Controller
> + *
> + * Copyright (C) 2024 ASPEED Technology Inc.
> + *
> + * This code is licensed under the GPL version 2 or later.  See
> + * the COPYING file in the top-level directory.

In all files, the paragraph above can be replaced with :

* SPDX-License-Identifier: GPL-2.0-or-later


Thanks,

C.




> + */
> +
> +#include "qemu/osdep.h"
> +#include "qemu/log.h"
> +#include "qemu/error-report.h"
> +#include "hw/qdev-properties.h"
> +#include "hw/misc/aspeed_sli.h"
> +#include "qapi/error.h"
> +#include "migration/vmstate.h"
> +#include "trace.h"
> +
> +#define SLI_REGION_SIZE 0x500
> +#define TO_REG(addr) ((addr) >> 2)
> +
> +static uint64_t aspeed_sli_read(void *opaque, hwaddr addr, unsigned int size)
> +{
> +    AspeedSLIState *s = ASPEED_SLI(opaque);
> +    int reg = TO_REG(addr);
> +
> +    if (reg >= ARRAY_SIZE(s->regs)) {
> +        qemu_log_mask(LOG_GUEST_ERROR,
> +                      "%s: Out-of-bounds read at offset 0x%" HWADDR_PRIx "\n",
> +                      __func__, addr);
> +        return 0;
> +    }
> +
> +    trace_aspeed_sli_read(addr, size, s->regs[reg]);
> +    return s->regs[reg];
> +}
> +
> +static void aspeed_sli_write(void *opaque, hwaddr addr, uint64_t data,
> +                              unsigned int size)
> +{
> +    AspeedSLIState *s = ASPEED_SLI(opaque);
> +    int reg = TO_REG(addr);
> +
> +    if (reg >= ARRAY_SIZE(s->regs)) {
> +        qemu_log_mask(LOG_GUEST_ERROR,
> +                      "%s: Out-of-bounds write at offset 0x%" HWADDR_PRIx "\n",
> +                      __func__, addr);
> +        return;
> +    }
> +
> +    trace_aspeed_sli_write(addr, size, data);
> +    s->regs[reg] = data;
> +}
> +
> +static uint64_t aspeed_sliio_read(void *opaque, hwaddr addr, unsigned int size)
> +{
> +    AspeedSLIState *s = ASPEED_SLI(opaque);
> +    int reg = TO_REG(addr);
> +
> +    if (reg >= ARRAY_SIZE(s->regs)) {
> +        qemu_log_mask(LOG_GUEST_ERROR,
> +                      "%s: Out-of-bounds read at offset 0x%" HWADDR_PRIx "\n",
> +                      __func__, addr);
> +        return 0;
> +    }
> +
> +    trace_aspeed_sliio_read(addr, size, s->regs[reg]);
> +    return s->regs[reg];
> +}
> +
> +static void aspeed_sliio_write(void *opaque, hwaddr addr, uint64_t data,
> +                              unsigned int size)
> +{
> +    AspeedSLIState *s = ASPEED_SLI(opaque);
> +    int reg = TO_REG(addr);
> +
> +    if (reg >= ARRAY_SIZE(s->regs)) {
> +        qemu_log_mask(LOG_GUEST_ERROR,
> +                      "%s: Out-of-bounds write at offset 0x%" HWADDR_PRIx "\n",
> +                      __func__, addr);
> +        return;
> +    }
> +
> +    trace_aspeed_sliio_write(addr, size, data);
> +    s->regs[reg] = data;
> +}
> +
> +static const MemoryRegionOps aspeed_sli_ops = {
> +    .read = aspeed_sli_read,
> +    .write = aspeed_sli_write,
> +    .endianness = DEVICE_LITTLE_ENDIAN,
> +    .valid = {
> +        .min_access_size = 1,
> +        .max_access_size = 4,
> +    },
> +};
> +
> +static const MemoryRegionOps aspeed_sliio_ops = {
> +    .read = aspeed_sliio_read,
> +    .write = aspeed_sliio_write,
> +    .endianness = DEVICE_LITTLE_ENDIAN,
> +    .valid = {
> +        .min_access_size = 1,
> +        .max_access_size = 4,
> +    },
> +};
> +
> +static void aspeed_sli_realize(DeviceState *dev, Error **errp)
> +{
> +    AspeedSLIState *s = ASPEED_SLI(dev);
> +    SysBusDevice *sbd = SYS_BUS_DEVICE(dev);
> +
> +    memory_region_init_io(&s->iomem, OBJECT(s), &aspeed_sli_ops, s,
> +                          TYPE_ASPEED_SLI, SLI_REGION_SIZE);
> +    sysbus_init_mmio(sbd, &s->iomem);
> +}
> +
> +static void aspeed_sliio_realize(DeviceState *dev, Error **errp)
> +{
> +    AspeedSLIState *s = ASPEED_SLI(dev);
> +    SysBusDevice *sbd = SYS_BUS_DEVICE(dev);
> +
> +    memory_region_init_io(&s->iomem, OBJECT(s), &aspeed_sliio_ops, s,
> +                          TYPE_ASPEED_SLI, SLI_REGION_SIZE);
> +    sysbus_init_mmio(sbd, &s->iomem);
> +}
> +
> +static void aspeed_sli_class_init(ObjectClass *klass, void *data)
> +{
> +    DeviceClass *dc = DEVICE_CLASS(klass);
> +
> +    dc->desc = "Aspeed SLI Controller";
> +    dc->realize = aspeed_sli_realize;
> +}
> +
> +static const TypeInfo aspeed_sli_info = {
> +    .name          = TYPE_ASPEED_SLI,
> +    .parent        = TYPE_SYS_BUS_DEVICE,
> +    .instance_size = sizeof(AspeedSLIState),
> +    .class_init    = aspeed_sli_class_init,
> +    .class_size    = sizeof(AspeedSLIClass),
> +    .abstract      = true,
> +};
> +
> +static void aspeed_2700_sli_class_init(ObjectClass *klass, void *data)
> +{
> +    DeviceClass *dc = DEVICE_CLASS(klass);
> +
> +    dc->desc = "AST2700 SLI Controller";
> +}
> +
> +static void aspeed_2700_sliio_class_init(ObjectClass *klass, void *data)
> +{
> +    DeviceClass *dc = DEVICE_CLASS(klass);
> +
> +    dc->desc = "AST2700 I/O SLI Controller";
> +    dc->realize = aspeed_sliio_realize;
> +}
> +
> +static const TypeInfo aspeed_2700_sli_info = {
> +    .name           = TYPE_ASPEED_2700_SLI,
> +    .parent         = TYPE_ASPEED_SLI,
> +    .class_init     = aspeed_2700_sli_class_init,
> +};
> +
> +static const TypeInfo aspeed_2700_sliio_info = {
> +    .name           = TYPE_ASPEED_2700_SLIIO,
> +    .parent         = TYPE_ASPEED_SLI,
> +    .class_init     = aspeed_2700_sliio_class_init,
> +};
> +
> +static void aspeed_sli_register_types(void)
> +{
> +    type_register_static(&aspeed_sli_info);
> +    type_register_static(&aspeed_2700_sli_info);
> +    type_register_static(&aspeed_2700_sliio_info);
> +}
> +
> +type_init(aspeed_sli_register_types);
> diff --git a/hw/misc/meson.build b/hw/misc/meson.build
> index 746686835b..790f05525a 100644
> --- a/hw/misc/meson.build
> +++ b/hw/misc/meson.build
> @@ -137,7 +137,8 @@ system_ss.add(when: 'CONFIG_ASPEED_SOC', if_true: files(
>     'aspeed_sbc.c',
>     'aspeed_sdmc.c',
>     'aspeed_xdma.c',
> -  'aspeed_peci.c'))
> +  'aspeed_peci.c',
> +  'aspeed_sli.c'))
>   
>   system_ss.add(when: 'CONFIG_MSF2', if_true: files('msf2-sysreg.c'))
>   system_ss.add(when: 'CONFIG_NRF51_SOC', if_true: files('nrf51_rng.c'))
> diff --git a/hw/misc/trace-events b/hw/misc/trace-events
> index 5f5bc92222..07010a7ea6 100644
> --- a/hw/misc/trace-events
> +++ b/hw/misc/trace-events
> @@ -341,3 +341,10 @@ djmemc_write(int reg, uint64_t value, unsigned int size) "reg=0x%x value=0x%"PRI
>   # iosb.c
>   iosb_read(int reg, uint64_t value, unsigned int size) "reg=0x%x value=0x%"PRIx64" size=%u"
>   iosb_write(int reg, uint64_t value, unsigned int size) "reg=0x%x value=0x%"PRIx64" size=%u"
> +
> +# aspeed_sli.c
> +aspeed_sli_write(uint64_t offset, unsigned int size, uint32_t data) "To 0x%" PRIx64 " of size %u: 0x%" PRIx32
> +aspeed_sli_read(uint64_t offset, unsigned int size, uint32_t data) "To 0x%" PRIx64 " of size %u: 0x%" PRIx32
> +aspeed_sliio_write(uint64_t offset, unsigned int size, uint32_t data) "To 0x%" PRIx64 " of size %u: 0x%" PRIx32
> +aspeed_sliio_read(uint64_t offset, unsigned int size, uint32_t data) "To 0x%" PRIx64 " of size %u: 0x%" PRIx32
> +
> diff --git a/include/hw/misc/aspeed_sli.h b/include/hw/misc/aspeed_sli.h
> new file mode 100644
> index 0000000000..15892950e2
> --- /dev/null
> +++ b/include/hw/misc/aspeed_sli.h
> @@ -0,0 +1,32 @@
> +/*
> + * ASPEED SLI Controller
> + *
> + * Copyright (C) 2024 ASPEED Technology Inc.
> + *
> + * This code is licensed under the GPL version 2 or later.  See
> + * the COPYING file in the top-level directory.
> + */
> +#ifndef ASPEED_SLI_H
> +#define ASPEED_SLI_H
> +
> +#include "hw/sysbus.h"
> +
> +#define TYPE_ASPEED_SLI "aspeed.sli"
> +#define TYPE_ASPEED_2700_SLI TYPE_ASPEED_SLI "-ast2700"
> +#define TYPE_ASPEED_2700_SLIIO TYPE_ASPEED_SLI "io" "-ast2700"
> +OBJECT_DECLARE_TYPE(AspeedSLIState, AspeedSLIClass, ASPEED_SLI)
> +
> +#define ASPEED_SLI_NR_REGS  (0x500 >> 2)
> +
> +struct AspeedSLIState {
> +    SysBusDevice parent;
> +    MemoryRegion iomem;
> +
> +    uint32_t regs[ASPEED_SLI_NR_REGS];
> +};
> +
> +struct AspeedSLIClass {
> +    SysBusDeviceClass parent_class;
> +};
> +
> +#endif /* ASPEED_SLI_H */


