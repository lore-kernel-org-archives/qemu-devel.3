Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A5038C25B10
	for <qemu-devel@archiver.kernel.org>; Mon, 13 May 2024 06:10:23 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s6OsW-0005PF-8O; Mon, 13 May 2024 02:09:40 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <SRS0=xtei=MQ=kaod.org=clg@ozlabs.org>)
 id 1s6OsU-0005Oy-A1; Mon, 13 May 2024 02:09:38 -0400
Received: from gandalf.ozlabs.org ([150.107.74.76] helo=mail.ozlabs.org)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <SRS0=xtei=MQ=kaod.org=clg@ozlabs.org>)
 id 1s6OsQ-0000YO-Qw; Mon, 13 May 2024 02:09:38 -0400
Received: from mail.ozlabs.org (mail.ozlabs.org [IPv6:2404:9400:2221:ea00::3])
 by gandalf.ozlabs.org (Postfix) with ESMTP id 4Vd8Ft70hqz4wxt;
 Mon, 13 May 2024 16:09:22 +1000 (AEST)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits))
 (No client certificate requested)
 by mail.ozlabs.org (Postfix) with ESMTPSA id 4Vd8Fr4mPCz4wcp;
 Mon, 13 May 2024 16:09:20 +1000 (AEST)
Message-ID: <36696eb8-162f-48a9-a569-a4fbb2045109@kaod.org>
Date: Mon, 13 May 2024 08:09:18 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/2] ppc/pnv: Begin a more complete ADU LPC model for
 POWER9/10
To: Nicholas Piggin <npiggin@gmail.com>, qemu-ppc@nongnu.org
Cc: qemu-devel@nongnu.org, Daniel Henrique Barboza <danielhb413@gmail.com>,
 =?UTF-8?B?RnLDqWTDqXJpYyBCYXJyYXQ=?= <fbarrat@linux.ibm.com>
References: <20240510141446.108360-1-npiggin@gmail.com>
 <20240510141446.108360-2-npiggin@gmail.com>
Content-Language: en-US, fr
From: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@kaod.org>
In-Reply-To: <20240510141446.108360-2-npiggin@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=150.107.74.76;
 envelope-from=SRS0=xtei=MQ=kaod.org=clg@ozlabs.org; helo=mail.ozlabs.org
X-Spam_score_int: -41
X-Spam_score: -4.2
X-Spam_bar: ----
X-Spam_report: (-4.2 / 5.0 requ) BAYES_00=-1.9,
 HEADER_FROM_DIFFERENT_DOMAINS=0.001, RCVD_IN_DNSWL_MED=-2.3,
 SPF_HELO_FAIL=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On 5/10/24 16:14, Nicholas Piggin wrote:
> This implements a framework for an ADU unit model.
> 
> The ADU unit actually implements XSCOM, which is the bridge between MMIO
> and PIB. However it also includes control and status registers and other
> functions that are exposed as PIB (xscom) registers.
> 
> To keep things simple, pnv_xscom.c remains the XSCOM bridge
> implementation, and pnv_adu.c implements the ADU registers and other
> functions.
> 
> So far, just the ADU no-op registers in the pnv_xscom.c default handler
> are moved over to the adu model.
> 
> Signed-off-by: Nicholas Piggin <npiggin@gmail.com>


Reviewed-by: Cédric Le Goater <clg@kaod.org>

Thanks,

C.


> ---
>   include/hw/ppc/pnv_adu.h   |  25 +++++++++
>   include/hw/ppc/pnv_chip.h  |   3 +
>   include/hw/ppc/pnv_xscom.h |   6 ++
>   hw/ppc/pnv.c               |  16 ++++++
>   hw/ppc/pnv_adu.c           | 111 +++++++++++++++++++++++++++++++++++++
>   hw/ppc/pnv_xscom.c         |   9 ---
>   hw/ppc/meson.build         |   1 +
>   hw/ppc/trace-events        |   4 ++
>   8 files changed, 166 insertions(+), 9 deletions(-)
>   create mode 100644 include/hw/ppc/pnv_adu.h
>   create mode 100644 hw/ppc/pnv_adu.c
> 
> diff --git a/include/hw/ppc/pnv_adu.h b/include/hw/ppc/pnv_adu.h
> new file mode 100644
> index 0000000000..b5f308627b
> --- /dev/null
> +++ b/include/hw/ppc/pnv_adu.h
> @@ -0,0 +1,25 @@
> +/*
> + * QEMU PowerPC PowerNV Emulation of some ADU behaviour
> + *
> + * Copyright (c) 2024, IBM Corporation.
> + *
> + * SPDX-License-Identifier: GPL-2.0-or-later
> + */
> +
> +#ifndef PPC_PNV_ADU_H
> +#define PPC_PNV_ADU_H
> +
> +#include "hw/ppc/pnv.h"
> +#include "hw/qdev-core.h"
> +
> +#define TYPE_PNV_ADU "pnv-adu"
> +
> +OBJECT_DECLARE_TYPE(PnvADU, PnvADUClass, PNV_ADU)
> +
> +struct PnvADU {
> +    DeviceState xd;
> +
> +    MemoryRegion xscom_regs;
> +};
> +
> +#endif /* PPC_PNV_ADU_H */
> diff --git a/include/hw/ppc/pnv_chip.h b/include/hw/ppc/pnv_chip.h
> index 8589f3291e..96e50a2983 100644
> --- a/include/hw/ppc/pnv_chip.h
> +++ b/include/hw/ppc/pnv_chip.h
> @@ -2,6 +2,7 @@
>   #define PPC_PNV_CHIP_H
>   
>   #include "hw/pci-host/pnv_phb4.h"
> +#include "hw/ppc/pnv_adu.h"
>   #include "hw/ppc/pnv_chiptod.h"
>   #include "hw/ppc/pnv_core.h"
>   #include "hw/ppc/pnv_homer.h"
> @@ -77,6 +78,7 @@ struct Pnv9Chip {
>       PnvChip      parent_obj;
>   
>       /*< public >*/
> +    PnvADU       adu;
>       PnvXive      xive;
>       Pnv9Psi      psi;
>       PnvLpcController lpc;
> @@ -110,6 +112,7 @@ struct Pnv10Chip {
>       PnvChip      parent_obj;
>   
>       /*< public >*/
> +    PnvADU       adu;
>       PnvXive2     xive;
>       Pnv9Psi      psi;
>       PnvLpcController lpc;
> diff --git a/include/hw/ppc/pnv_xscom.h b/include/hw/ppc/pnv_xscom.h
> index 6209e18492..e93d310e79 100644
> --- a/include/hw/ppc/pnv_xscom.h
> +++ b/include/hw/ppc/pnv_xscom.h
> @@ -82,6 +82,9 @@ struct PnvXScomInterfaceClass {
>   #define PNV_XSCOM_PBCQ_SPCI_BASE  0x9013c00
>   #define PNV_XSCOM_PBCQ_SPCI_SIZE  0x5
>   
> +#define PNV9_XSCOM_ADU_BASE       0x0090000
> +#define PNV9_XSCOM_ADU_SIZE       0x55
> +
>   /*
>    * Layout of the XSCOM PCB addresses (POWER 9)
>    */
> @@ -128,6 +131,9 @@ struct PnvXScomInterfaceClass {
>   #define PNV9_XSCOM_PEC_PCI_STK1   0x140
>   #define PNV9_XSCOM_PEC_PCI_STK2   0x180
>   
> +#define PNV10_XSCOM_ADU_BASE      0x0090000
> +#define PNV10_XSCOM_ADU_SIZE      0x55
> +
>   /*
>    * Layout of the XSCOM PCB addresses (POWER 10)
>    */
> diff --git a/hw/ppc/pnv.c b/hw/ppc/pnv.c
> index 6e3a5ccdec..5869aac89a 100644
> --- a/hw/ppc/pnv.c
> +++ b/hw/ppc/pnv.c
> @@ -1530,6 +1530,7 @@ static void pnv_chip_power9_instance_init(Object *obj)
>       PnvChipClass *pcc = PNV_CHIP_GET_CLASS(obj);
>       int i;
>   
> +    object_initialize_child(obj, "adu",  &chip9->adu, TYPE_PNV_ADU);
>       object_initialize_child(obj, "xive", &chip9->xive, TYPE_PNV_XIVE);
>       object_property_add_alias(obj, "xive-fabric", OBJECT(&chip9->xive),
>                                 "xive-fabric");
> @@ -1640,6 +1641,13 @@ static void pnv_chip_power9_realize(DeviceState *dev, Error **errp)
>           return;
>       }
>   
> +    /* ADU */
> +    if (!qdev_realize(DEVICE(&chip9->adu), NULL, errp)) {
> +        return;
> +    }
> +    pnv_xscom_add_subregion(chip, PNV9_XSCOM_ADU_BASE,
> +                            &chip9->adu.xscom_regs);
> +
>       pnv_chip_quad_realize(chip9, &local_err);
>       if (local_err) {
>           error_propagate(errp, local_err);
> @@ -1806,6 +1814,7 @@ static void pnv_chip_power10_instance_init(Object *obj)
>       PnvChipClass *pcc = PNV_CHIP_GET_CLASS(obj);
>       int i;
>   
> +    object_initialize_child(obj, "adu",  &chip10->adu, TYPE_PNV_ADU);
>       object_initialize_child(obj, "xive", &chip10->xive, TYPE_PNV_XIVE2);
>       object_property_add_alias(obj, "xive-fabric", OBJECT(&chip10->xive),
>                                 "xive-fabric");
> @@ -1898,6 +1907,13 @@ static void pnv_chip_power10_realize(DeviceState *dev, Error **errp)
>           return;
>       }
>   
> +    /* ADU */
> +    if (!qdev_realize(DEVICE(&chip10->adu), NULL, errp)) {
> +        return;
> +    }
> +    pnv_xscom_add_subregion(chip, PNV10_XSCOM_ADU_BASE,
> +                            &chip10->adu.xscom_regs);
> +
>       pnv_chip_power10_quad_realize(chip10, &local_err);
>       if (local_err) {
>           error_propagate(errp, local_err);
> diff --git a/hw/ppc/pnv_adu.c b/hw/ppc/pnv_adu.c
> new file mode 100644
> index 0000000000..8279bc8b26
> --- /dev/null
> +++ b/hw/ppc/pnv_adu.c
> @@ -0,0 +1,111 @@
> +/*
> + * QEMU PowerPC PowerNV ADU unit
> + *
> + * The ADU unit actually implements XSCOM, which is the bridge between MMIO
> + * and PIB. However it also includes control and status registers and other
> + * functions that are exposed as PIB (xscom) registers.
> + *
> + * To keep things simple, pnv_xscom.c remains the XSCOM bridge
> + * implementation, and pnv_adu.c implements the ADU registers and other
> + * functions.
> + *
> + * Copyright (c) 2024, IBM Corporation.
> + *
> + * SPDX-License-Identifier: GPL-2.0-or-later
> + */
> +
> +#include "qemu/osdep.h"
> +#include "qemu/log.h"
> +
> +#include "hw/qdev-properties.h"
> +#include "hw/ppc/pnv.h"
> +#include "hw/ppc/pnv_adu.h"
> +#include "hw/ppc/pnv_chip.h"
> +#include "hw/ppc/pnv_xscom.h"
> +#include "trace.h"
> +
> +static uint64_t pnv_adu_xscom_read(void *opaque, hwaddr addr, unsigned width)
> +{
> +    uint32_t offset = addr >> 3;
> +    uint64_t val = 0;
> +
> +    switch (offset) {
> +    case 0x18:     /* Receive status reg */
> +    case 0x12:     /* log register */
> +    case 0x13:     /* error register */
> +        break;
> +
> +    default:
> +        qemu_log_mask(LOG_UNIMP, "ADU Unimplemented read register: Ox%08x\n",
> +                                                                     offset);
> +    }
> +
> +    trace_pnv_adu_xscom_read(addr, val);
> +
> +    return val;
> +}
> +
> +static void pnv_adu_xscom_write(void *opaque, hwaddr addr, uint64_t val,
> +                                unsigned width)
> +{
> +    uint32_t offset = addr >> 3;
> +
> +    trace_pnv_adu_xscom_write(addr, val);
> +
> +    switch (offset) {
> +    case 0x18:     /* Receive status reg */
> +    case 0x12:     /* log register */
> +    case 0x13:     /* error register */
> +        break;
> +
> +    default:
> +        qemu_log_mask(LOG_UNIMP, "ADU Unimplemented write register: Ox%08x\n",
> +                                                                     offset);
> +    }
> +}
> +
> +const MemoryRegionOps pnv_adu_xscom_ops = {
> +    .read = pnv_adu_xscom_read,
> +    .write = pnv_adu_xscom_write,
> +    .valid.min_access_size = 8,
> +    .valid.max_access_size = 8,
> +    .impl.min_access_size = 8,
> +    .impl.max_access_size = 8,
> +    .endianness = DEVICE_BIG_ENDIAN,
> +};
> +
> +static void pnv_adu_realize(DeviceState *dev, Error **errp)
> +{
> +    PnvADU *adu = PNV_ADU(dev);
> +
> +    /* XScom regions for ADU registers */
> +    pnv_xscom_region_init(&adu->xscom_regs, OBJECT(dev),
> +                          &pnv_adu_xscom_ops, adu, "xscom-adu",
> +                          PNV9_XSCOM_ADU_SIZE);
> +}
> +
> +static void pnv_adu_class_init(ObjectClass *klass, void *data)
> +{
> +    DeviceClass *dc = DEVICE_CLASS(klass);
> +
> +    dc->realize = pnv_adu_realize;
> +    dc->desc = "PowerNV ADU";
> +    dc->user_creatable = false;
> +}
> +
> +static const TypeInfo pnv_adu_type_info = {
> +    .name          = TYPE_PNV_ADU,
> +    .parent        = TYPE_DEVICE,
> +    .instance_size = sizeof(PnvADU),
> +    .class_init    = pnv_adu_class_init,
> +    .interfaces    = (InterfaceInfo[]) {
> +        { TYPE_PNV_XSCOM_INTERFACE },
> +        { } },
> +};
> +
> +static void pnv_adu_register_types(void)
> +{
> +    type_register_static(&pnv_adu_type_info);
> +}
> +
> +type_init(pnv_adu_register_types);
> diff --git a/hw/ppc/pnv_xscom.c b/hw/ppc/pnv_xscom.c
> index a17816d072..d192bbe2c2 100644
> --- a/hw/ppc/pnv_xscom.c
> +++ b/hw/ppc/pnv_xscom.c
> @@ -75,11 +75,6 @@ static uint64_t xscom_read_default(PnvChip *chip, uint32_t pcba)
>       case PRD_P9_IPOLL_REG_MASK:
>       case PRD_P9_IPOLL_REG_STATUS:
>   
> -        /* P9 xscom reset */
> -    case 0x0090018:     /* Receive status reg */
> -    case 0x0090012:     /* log register */
> -    case 0x0090013:     /* error register */
> -
>           /* P8 xscom reset */
>       case 0x2020007:     /* ADU stuff, log register */
>       case 0x2020009:     /* ADU stuff, error register */
> @@ -119,10 +114,6 @@ static bool xscom_write_default(PnvChip *chip, uint32_t pcba, uint64_t val)
>       case 0x1010c03:     /* PIBAM FIR MASK */
>       case 0x1010c04:     /* PIBAM FIR MASK */
>       case 0x1010c05:     /* PIBAM FIR MASK */
> -        /* P9 xscom reset */
> -    case 0x0090018:     /* Receive status reg */
> -    case 0x0090012:     /* log register */
> -    case 0x0090013:     /* error register */
>   
>           /* P8 xscom reset */
>       case 0x2020007:     /* ADU stuff, log register */
> diff --git a/hw/ppc/meson.build b/hw/ppc/meson.build
> index d096636ee7..932ade7b21 100644
> --- a/hw/ppc/meson.build
> +++ b/hw/ppc/meson.build
> @@ -44,6 +44,7 @@ endif
>   ppc_ss.add(when: 'CONFIG_POWERNV', if_true: files(
>     'pnv.c',
>     'pnv_xscom.c',
> +  'pnv_adu.c',
>     'pnv_core.c',
>     'pnv_i2c.c',
>     'pnv_lpc.c',
> diff --git a/hw/ppc/trace-events b/hw/ppc/trace-events
> index bf29bbfd4b..1f125ce841 100644
> --- a/hw/ppc/trace-events
> +++ b/hw/ppc/trace-events
> @@ -95,6 +95,10 @@ vof_write(uint32_t ih, unsigned cb, const char *msg) "ih=0x%x [%u] \"%s\""
>   vof_avail(uint64_t start, uint64_t end, uint64_t size) "0x%"PRIx64"..0x%"PRIx64" size=0x%"PRIx64
>   vof_claimed(uint64_t start, uint64_t end, uint64_t size) "0x%"PRIx64"..0x%"PRIx64" size=0x%"PRIx64
>   
> +# pnv_adu.c
> +pnv_adu_xscom_read(uint64_t addr, uint64_t val) "addr 0x%" PRIx64 " val 0x%" PRIx64
> +pnv_adu_xscom_write(uint64_t addr, uint64_t val) "addr 0x%" PRIx64 " val 0x%" PRIx64
> +
>   # pnv_chiptod.c
>   pnv_chiptod_xscom_read(uint64_t addr, uint64_t val) "addr 0x%" PRIx64 " val 0x%" PRIx64
>   pnv_chiptod_xscom_write(uint64_t addr, uint64_t val) "addr 0x%" PRIx64 " val 0x%" PRIx64


