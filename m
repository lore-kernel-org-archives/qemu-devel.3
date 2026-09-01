Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6EE08C61DE4
	for <qemu-devel@archiver.kernel.org>; Tue,  1 Sep 2026 06:18:41 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x1Hp5-0005IH-BC; Tue, 01 Sep 2026 02:18:19 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@kaod.org>) id 1x1Hp3-0005FZ-HQ
 for qemu-devel@nongnu.org; Tue, 01 Sep 2026 02:18:17 -0400
Received: from smtpout6.mo538.mail-out.ovh.net ([51.210.91.35])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@kaod.org>) id 1x1Hp0-0005YS-9Z
 for qemu-devel@nongnu.org; Tue, 01 Sep 2026 02:18:17 -0400
Received: from director6.derp.mail-out.ovh.net
 (director6.derp.mail-out.ovh.net [79.137.60.226])
 by mo538.mail-out.ovh.net (Postfix) with ESMTPS id 4hYwdt1QD8z6GNm;
 Tue,  1 Sep 2026 06:18:10 +0000 (UTC)
Received: from director6.derp.mail-out.ovh.net
 (director6.derp.mail-out.ovh.net. [127.0.0.1])
 by director6.derp.mail-out.ovh.net (inspect_sender_mail_agent) with SMTP
 for <jamin_lin@aspeedtech.com>; Tue,  1 Sep 2026 06:18:10 +0000 (UTC)
Received: from mta2.priv.ovhmail-u2.ea.mail.ovh.net (unknown [10.110.164.229])
 by director6.derp.mail-out.ovh.net (Postfix) with ESMTPS id
 4hYwdt0LYVz47PW; Tue,  1 Sep 2026 06:18:10 +0000 (UTC)
Received: from kaod.org (unknown [10.1.6.2])
 (Authenticated sender: clg@kaod.org)
 by mta2.priv.ovhmail-u2.ea.mail.ovh.net (Postfix) with ESMTPSA id 630F0941BDA; 
 Tue,  1 Sep 2026 06:18:08 +0000 (UTC)
Authentication-Results: garm.ovh; auth=pass
 (GARM-96R0015c0d6e83-2a48-460a-80e6-ad3482722f6b,
 60FF1D1BA71F1148B3CBA6CDBAED02576558214C) smtp.auth=clg@kaod.org
X-OVh-ClientIp: 82.64.250.170
Message-ID: <d44087a5-bfd5-4e73-bda8-2fd3d940d16b@kaod.org>
Date: Tue, 1 Sep 2026 08:18:07 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 1/4] hw/usb/aspeed-udc: Add ASPEED UDC device controller
To: Jamin Lin <jamin_lin@aspeedtech.com>, Paolo Bonzini
 <pbonzini@redhat.com>, Peter Maydell <peter.maydell@linaro.org>,
 Steven Lee <steven_lee@aspeedtech.com>, Troy Lee <leetroy@gmail.com>,
 Kane Chen <kane_chen@aspeedtech.com>,
 Andrew Jeffery <andrew@codeconstruct.com.au>, Joel Stanley <joel@jms.id.au>,
 "open list:ARM TCG CPUs" <qemu-arm@nongnu.org>,
 "open list:All patches CC here" <qemu-devel@nongnu.org>
Cc: Troy Lee <troy_lee@aspeedtech.com>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
References: <20260901024400.3488429-1-jamin_lin@aspeedtech.com>
 <20260901024400.3488429-2-jamin_lin@aspeedtech.com>
From: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@kaod.org>
Content-Language: en-US, fr
Autocrypt: addr=clg@kaod.org; keydata=
 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
In-Reply-To: <20260901024400.3488429-2-jamin_lin@aspeedtech.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
x-ovh-tracer-id: 7935905493786668271
X-VR-SPAMSTATE: OK
X-VR-SPAMSCORE: -100
X-VR-SPAMCAUSE: dmFkZTFEnb7PAZpKdPvXVJ3Is1f2qRU1GoEggeQI79I98W0m4Y65ZHXMQrzotmsZDVAVtWdJxZUKSd1GPtAjTQlpf9/XR32gTr1voJiJKC/A0/McHOZbdQ7Hj710vwLFmeCsf0FU5CdxopO0EJ7ocBi/9Sc7j0L8IXP9w1DWXYzoBfS9LM+GNsQdWHAAOMNyqwMB63lLK7SiPDQObcg1i9fRmuQXxpDzuQwtVLNJY+AocQGfi/cuguwZertuaQTcQwbBdSGcxljmg4Q1Xcvn1A8YCojFIWAxhMC7yIuS47w+PaLgQL54jHAjkeVcokPlaJO2SnOPw6XiqFWIXZh+ZQfMuoErGFqDKdRATbjoERvR5T/DrDx0Re/NMI0m3pNkaqZ0n3JAlhjj1Vccj3HbSxvgfRJg03yeAOULpFOMP3bqzdpugdrkVEeSNqNBKO6JceKUX5I+oZowV7hqciJMFfaiC5w3bzR9F4ABKpmR0gBaiaE5DU2JVqajO2oD/STBjZ702LnWyihPu5FyOQS/iw8CSLbrz6UxgygYEEsbfqC0IYZyoqNFYp4ilvEf/Fh/3wVxwJl0qdL5GMaRTzGdGNjZ1tXxd7STgg8wJgaVgIdGhRQEakWmX6ovI5oKFo4i+PjZ0fRI9wOwaholRn1yWlEX5lOezhV0w32nIqIDPPoITamibw
DKIM-Signature: a=rsa-sha256; bh=7PHhR2DVmtCTepQMqDvmH4ZF9mjhX/K+npMEaYULJpQ=; 
 c=relaxed/relaxed; d=kaod.org; h=From; s=ovhmo393970-selector1;
 t=1788243491; v=1;
 b=p5g0kCj6EN2xGkEFrkW0J75325F2iRcC9/Oj/l6J+0FeGeJ74MXEov39Qmb6ruSGrSHNMLvl
 GL2cK8jSrqwDyptfQDoAqKUjZqLnCzOUxL0BMHmwhvwNHFDS42Y+pDlOX6BvBsilqn1gL9PfHDS
 Btn86fbkpflMzmsMjNj17GZ6S4VeSQh2I7eqyCTFcZNYnm0RyD/NLkYN/T5ur6MvJToIxVaiW1c
 Sphdy6Fax5TSbjnFuUkeStDyKhKiN1p5Zza5Wus33tSJ+ebvkhLEjVXvYfv2A47bMNJndjHa4vK
 Vigxf5oYT+4b/eYbFo0RFOpMZoZmWZ4q7J8kaGpap7Skg==
Received-SPF: pass client-ip=51.210.91.35; envelope-from=clg@kaod.org;
 helo=smtpout6.mo538.mail-out.ovh.net
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

On 9/1/26 04:44, Jamin Lin wrote:
> The AST2600 has a USB 2.0 Device Controller (UDC) at 0x1e6a2000 with one
> control endpoint and four programmable endpoints.
> 
> Add the controller as a sysbus (system) device: the MMIO register map
> described with the registerfields macros, the interrupt line and the
> soft reset. This is only the register/system side.
> 
> Note: this "device controller" is the system-bus device (TYPE_ASPEED_UDC).
> It is not the gadget USB device (TYPE_ASPEED_UDC_GADGET) that a host
> controller enumerates, which is added in the next patch.
> 
> Signed-off-by: Jamin Lin <jamin_lin@aspeedtech.com>
> Reviewed-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>
> ---
>   include/hw/usb/aspeed-udc.h |  49 ++++++++
>   hw/usb/aspeed-udc.c         | 236 ++++++++++++++++++++++++++++++++++++
>   hw/arm/Kconfig              |   1 +
>   hw/usb/Kconfig              |   3 +
>   hw/usb/meson.build          |   1 +
>   hw/usb/trace-events         |   7 ++
>   6 files changed, 297 insertions(+)
>   create mode 100644 include/hw/usb/aspeed-udc.h
>   create mode 100644 hw/usb/aspeed-udc.c
> 
> diff --git a/include/hw/usb/aspeed-udc.h b/include/hw/usb/aspeed-udc.h
> new file mode 100644
> index 0000000000..58fed5f9a2
> --- /dev/null
> +++ b/include/hw/usb/aspeed-udc.h
> @@ -0,0 +1,49 @@
> +/*
> + * ASPEED USB Device Controller (UDC)
> + *
> + * Copyright (c) 2026 ASPEED Technology Inc.
> + *
> + * SPDX-License-Identifier: GPL-2.0-or-later
> + */
> +
> +#ifndef HW_USB_ASPEED_UDC_H
> +#define HW_USB_ASPEED_UDC_H
> +
> +#include "hw/core/sysbus.h"
> +#include "qom/object.h"
> +
> +#define TYPE_ASPEED_UDC "aspeed.udc"
> +OBJECT_DECLARE_SIMPLE_TYPE(AspeedUDCState, ASPEED_UDC)
> +
> +/*
> + * Register map: root/global block at 0x000 - 0x087, then one 0x10 byte bank
> + * per programmable endpoint from 0x200.
> + */
> +#define ASPEED_UDC_MEM_SIZE     0x300
> +#define ASPEED_UDC_ROOT_NR_REGS (0x88 >> 2)
> +#define ASPEED_UDC_EP_REG_BASE  0x200
> +#define ASPEED_UDC_EP_NR_REGS   (0x10 >> 2)
> +
> +/*
> + * EP0 (control) is served through the root registers (UDC_EP0_*), so only
> + * the 4 programmable endpoints get their own register bank / ep[] entry.
> + */
> +#define ASPEED_UDC_NUM_EP   4
> +
> +typedef struct AspeedUDCEP {
> +    MemoryRegion mr;
> +    uint32_t regs[ASPEED_UDC_EP_NR_REGS];
> +    int index;
> +} AspeedUDCEP;
> +
> +struct AspeedUDCState {
> +    SysBusDevice parent_obj;
> +
> +    MemoryRegion udc_container;
> +    MemoryRegion root_mr;
> +    uint32_t regs[ASPEED_UDC_ROOT_NR_REGS];
> +    AspeedUDCEP ep[ASPEED_UDC_NUM_EP];
> +    qemu_irq irq;
> +};
> +
> +#endif /* HW_USB_ASPEED_UDC_H */
> diff --git a/hw/usb/aspeed-udc.c b/hw/usb/aspeed-udc.c
> new file mode 100644
> index 0000000000..cd773e979b
> --- /dev/null
> +++ b/hw/usb/aspeed-udc.c
> @@ -0,0 +1,236 @@
> +/*
> + * ASPEED USB Device Controller (UDC)
> + *
> + * Copyright (c) 2026 ASPEED Technology Inc.
> + *
> + * SPDX-License-Identifier: GPL-2.0-or-later
> + *
> + * Models the ASPEED USB Device Controller (UDC). It implements one control
> + * endpoint (EP0) and 4 programmable endpoints.
> + *
> + * This file is the system-bus side of the controller: the MMIO register map,
> + * the interrupt and the soft reset. The gadget USB device presented to a host
> + * controller (and the endpoint data path) is added on top of this.
> + */
> +
> +#include "qemu/osdep.h"
> +#include "hw/core/irq.h"
> +#include "hw/core/registerfields.h"
> +#include "hw/usb/aspeed-udc.h"
> +#include "qemu/module.h"
> +#include "trace.h"
> +
> +/* Root / Global registers (offset from the controller base) */
> +REG32(UDC_FUNC_CTRL, 0x00)
> +    FIELD(UDC_FUNC_CTRL, UPSTREAM_EN,       0, 1)
> +REG32(UDC_IER, 0x08)
> +REG32(UDC_ISR, 0x0C)
> +    FIELD(UDC_ISR, EP_POOL_ACK,            16, 1)
> +    FIELD(UDC_ISR, BUS_RESET,               6, 1)
> +    FIELD(UDC_ISR, EP0_IN_ACK,              3, 1)
> +    FIELD(UDC_ISR, EP0_OUT_ACK,             1, 1)
> +    FIELD(UDC_ISR, EP0_SETUP,               0, 1)
> +REG32(UDC_EP_ACK_IER, 0x10)
> +REG32(UDC_EP_NAK_IER, 0x14)
> +REG32(UDC_EP_ACK_ISR, 0x18)
> +REG32(UDC_EP_NAK_ISR, 0x1C)
> +REG32(UDC_DEV_RESET, 0x20)
> +    FIELD(UDC_DEV_RESET, EP_POOL,           9, 1)
> +    FIELD(UDC_DEV_RESET, DMA,               8, 1)
> +    FIELD(UDC_DEV_RESET, ROOT,              0, 1)
> +REG32(UDC_STS, 0x24)
> +    FIELD(UDC_STS, HIGHSPEED,              27, 1)
> +REG32(UDC_EP0_CTRL, 0x30)
> +    FIELD(UDC_EP0_CTRL, RX_LEN,            16, 7)
> +    FIELD(UDC_EP0_CTRL, TX_LEN,             8, 7)
> +    FIELD(UDC_EP0_CTRL, RX_RDY,             2, 1)
> +    FIELD(UDC_EP0_CTRL, TX_RDY,             1, 1)
> +    FIELD(UDC_EP0_CTRL, STALL,              0, 1)
> +REG32(UDC_EP0_DATA_BUFF, 0x34)
> +/* EP0 SETUP packet buffer: SETUP0 = bytes 0...3, SETUP1 = bytes 4...7 */
> +REG32(UDC_SETUP0, 0x80)
> +REG32(UDC_SETUP1, 0x84)
> +
> +/* Per programmable-endpoint registers (offset from the EP register base) */
> +REG32(EP_CONFIG, 0x00)
> +    FIELD(EP_CONFIG, MAX_PKT,              16, 10)
> +    FIELD(EP_CONFIG, EP_NUM,                8, 4)
> +    FIELD(EP_CONFIG, DIR_OUT,               4, 1)
> +    FIELD(EP_CONFIG, ENABLE,                0, 1)
> +REG32(EP_DMA_CTRL, 0x04)
> +    FIELD(EP_DMA_CTRL, PROC_STS,            4, 4)
> +    FIELD(EP_DMA_CTRL, DESC_OP_EN,          0, 1)
> +REG32(EP_DMA_BUFF, 0x08)
> +REG32(EP_DMA_STS, 0x0C)
> +    FIELD(EP_DMA_STS, PKT_SIZE,            16, 11)
> +    FIELD(EP_DMA_STS, RPTR,                 8, 8)
> +    FIELD(EP_DMA_STS, WPTR,                 0, 8)
> +
> +static void aspeed_udc_update_irq(AspeedUDCState *s)
> +{
> +    bool level;
> +
> +    level = (s->regs[R_UDC_ISR] & s->regs[R_UDC_IER]) ||
> +            (s->regs[R_UDC_EP_ACK_ISR] & s->regs[R_UDC_EP_ACK_IER]) ||
> +            (s->regs[R_UDC_EP_NAK_ISR] & s->regs[R_UDC_EP_NAK_IER]);
> +
> +    trace_aspeed_udc_irq(s->regs[R_UDC_ISR], s->regs[R_UDC_IER], level);
> +    qemu_set_irq(s->irq, level);
> +}
> +
> +static uint64_t aspeed_udc_read(void *opaque, hwaddr offset, unsigned size)
> +{
> +    AspeedUDCState *s = ASPEED_UDC(opaque);
> +    uint32_t reg = offset >> 2;
> +    uint32_t val;
> +
> +    val = s->regs[reg];
> +    trace_aspeed_udc_read(offset, val);
> +
> +    return val;
> +}
> +
> +static void aspeed_udc_write(void *opaque, hwaddr offset, uint64_t data,
> +                             unsigned size)
> +{
> +    AspeedUDCState *s = ASPEED_UDC(opaque);
> +    uint32_t reg = offset >> 2;
> +    uint32_t val = data;
> +
> +    trace_aspeed_udc_write(offset, val);
> +
> +    switch (reg) {
> +    case R_UDC_IER:
> +    case R_UDC_EP_ACK_IER:
> +    case R_UDC_EP_NAK_IER:
> +        s->regs[reg] = val;
> +        aspeed_udc_update_irq(s);
> +        break;
> +    case R_UDC_ISR:
> +    case R_UDC_EP_ACK_ISR:
> +    case R_UDC_EP_NAK_ISR:
> +        s->regs[reg] &= ~val;
> +        aspeed_udc_update_irq(s);
> +        break;
> +    default:
> +        s->regs[reg] = val;
> +        break;
> +    }
> +}
> +
> +static const MemoryRegionOps aspeed_udc_ops = {
> +    .read = aspeed_udc_read,
> +    .write = aspeed_udc_write,
> +    .endianness = DEVICE_LITTLE_ENDIAN,
> +    .valid = {
> +        .min_access_size = 1,
> +        .max_access_size = 4,
> +    },
> +    .impl = {
> +        .min_access_size = 4,
> +        .max_access_size = 4,
> +    },
> +};
> +
> +static uint64_t aspeed_udc_ep_read(void *opaque, hwaddr offset, unsigned size)
> +{
> +    AspeedUDCEP *e = opaque;
> +    uint32_t reg = offset >> 2;
> +    uint32_t val;
> +
> +    val = e->regs[reg];
> +    trace_aspeed_udc_ep_read(e->index, offset, val);
> +
> +    return val;
> +}
> +
> +static void aspeed_udc_ep_write(void *opaque, hwaddr offset, uint64_t data,
> +                                unsigned size)
> +{
> +    AspeedUDCEP *e = opaque;
> +    uint32_t reg = offset >> 2;
> +
> +    trace_aspeed_udc_ep_write(e->index, offset, data);
> +    e->regs[reg] = data;
> +}
> +
> +static const MemoryRegionOps aspeed_udc_ep_ops = {
> +    .read = aspeed_udc_ep_read,
> +    .write = aspeed_udc_ep_write,
> +    .endianness = DEVICE_LITTLE_ENDIAN,
> +    .valid = {
> +        .min_access_size = 1,
> +        .max_access_size = 4,
> +    },
> +    .impl = {
> +        .min_access_size = 4,
> +        .max_access_size = 4,
> +    },
> +};
> +
> +static void aspeed_udc_reset_hold(Object *obj, ResetType type)
> +{
> +    AspeedUDCState *s = ASPEED_UDC(obj);
> +    int i;
> +
> +    memset(s->regs, 0, sizeof(s->regs));
> +    for (i = 0; i < ASPEED_UDC_NUM_EP; i++) {
> +        memset(s->ep[i].regs, 0, sizeof(s->ep[i].regs));
> +    }
> +
> +    /* Device-reset default: root, DMA and EP-pool soft-reset bits set */
> +    s->regs[R_UDC_DEV_RESET] = (R_UDC_DEV_RESET_ROOT_MASK |
> +                                R_UDC_DEV_RESET_DMA_MASK |
> +                                R_UDC_DEV_RESET_EP_POOL_MASK);
> +}
> +
> +static void aspeed_udc_realize(DeviceState *dev, Error **errp)
> +{
> +    SysBusDevice *sbd = SYS_BUS_DEVICE(dev);
> +    AspeedUDCState *s = ASPEED_UDC(dev);
> +    int i;
> +
> +    memory_region_init(&s->udc_container, OBJECT(s), TYPE_ASPEED_UDC,
> +                       ASPEED_UDC_MEM_SIZE);
> +    memory_region_init_io(&s->root_mr, OBJECT(s), &aspeed_udc_ops, s,
> +                          TYPE_ASPEED_UDC ".root",
> +                          ASPEED_UDC_ROOT_NR_REGS << 2);
> +    memory_region_add_subregion(&s->udc_container, 0, &s->root_mr);
> +
> +    /* Each programmable endpoint has its own register bank */
> +    for (i = 0; i < ASPEED_UDC_NUM_EP; i++) {
> +        g_autofree char *name = g_strdup_printf(TYPE_ASPEED_UDC ".ep%d", i);
> +
> +        s->ep[i].index = i;
> +        memory_region_init_io(&s->ep[i].mr, OBJECT(s), &aspeed_udc_ep_ops,
> +                              &s->ep[i], name, ASPEED_UDC_EP_NR_REGS << 2);
> +        memory_region_add_subregion(&s->udc_container,
> +                                    ASPEED_UDC_EP_REG_BASE +
> +                                    i * (ASPEED_UDC_EP_NR_REGS << 2),
> +                                    &s->ep[i].mr);
> +    }
> +
> +    sysbus_init_mmio(sbd, &s->udc_container);
> +    sysbus_init_irq(sbd, &s->irq);
> +}
> +
> +static void aspeed_udc_class_init(ObjectClass *klass, const void *data)
> +{
> +    DeviceClass *dc = DEVICE_CLASS(klass);
> +    ResettableClass *rc = RESETTABLE_CLASS(klass);
> +
> +    dc->desc = "ASPEED USB Device Controller";
> +    dc->realize = aspeed_udc_realize;
> +    rc->phases.hold = aspeed_udc_reset_hold;
> +}
> +
> +static const TypeInfo aspeed_udc_types[] = {
> +    {
> +        .name          = TYPE_ASPEED_UDC,
> +        .parent        = TYPE_SYS_BUS_DEVICE,
> +        .instance_size = sizeof(AspeedUDCState),
> +        .class_init    = aspeed_udc_class_init,
> +    },
> +};
> +
> +DEFINE_TYPES(aspeed_udc_types)
> diff --git a/hw/arm/Kconfig b/hw/arm/Kconfig
> index 260d2f0751..146ed1a0be 100644
> --- a/hw/arm/Kconfig
> +++ b/hw/arm/Kconfig
> @@ -536,6 +536,7 @@ config ASPEED_SOC
>       imply GENERIC_LOADER
>       imply PCI_DEVICES
>       imply E1000E_PCI_EXPRESS
> +    select ASPEED_UDC
>       select DS1338
>       select FTGMAC100
>       select I2C
> diff --git a/hw/usb/Kconfig b/hw/usb/Kconfig
> index de95686720..e4df15fe7c 100644
> --- a/hw/usb/Kconfig
> +++ b/hw/usb/Kconfig
> @@ -146,3 +146,6 @@ config XLNX_USB_SUBSYS
>   config USB_CHIPIDEA
>       bool
>       select USB_EHCI_SYSBUS
> +
> +config ASPEED_UDC
> +    bool
> diff --git a/hw/usb/meson.build b/hw/usb/meson.build
> index ba55c28ef6..d4ba60a91c 100644
> --- a/hw/usb/meson.build
> +++ b/hw/usb/meson.build
> @@ -27,6 +27,7 @@ system_ss.add(when: 'CONFIG_USB_XHCI_NEC', if_true: files('hcd-xhci-nec.c'))
>   system_ss.add(when: 'CONFIG_USB_DWC2', if_true: files('hcd-dwc2.c'))
>   system_ss.add(when: 'CONFIG_USB_DWC3', if_true: files('hcd-dwc3.c'))
>   system_ss.add(when: 'CONFIG_USB_CHIPIDEA', if_true: files('chipidea.c'))
> +system_ss.add(when: 'CONFIG_ASPEED_UDC', if_true: files('aspeed-udc.c'))
>   
>   system_ss.add(when: 'CONFIG_IMX_USBPHY', if_true: files('imx-usb-phy.c'))
>   system_ss.add(when: 'CONFIG_VT82C686', if_true: files('vt82c686-uhci-pci.c'))
> diff --git a/hw/usb/trace-events b/hw/usb/trace-events
> index 67249d69c2..ed05304520 100644
> --- a/hw/usb/trace-events
> +++ b/hw/usb/trace-events
> @@ -377,3 +377,10 @@ canokey_handle_data_out(uint8_t ep_out, uint32_t out_len) "ep %d len %d"
>   canokey_handle_data_in(uint8_t ep_in, uint32_t in_len) "ep %d len %d"
>   canokey_realize(void)
>   canokey_unrealize(void)
> +
> +# aspeed-udc.c
> +aspeed_udc_read(uint64_t offset, uint32_t value) "offset 0x%" PRIx64 " value 0x%x"
> +aspeed_udc_write(uint64_t offset, uint32_t value) "offset 0x%" PRIx64 " value 0x%x"
> +aspeed_udc_ep_read(int ep, uint64_t offset, uint32_t value) "ep %d, offset 0x%" PRIx64 " value 0x%x"
> +aspeed_udc_ep_write(int ep, uint64_t offset, uint32_t value) "ep %d, offset 0x%" PRIx64 " value 0x%x"
> +aspeed_udc_irq(uint32_t isr, uint32_t ier, int level) "isr 0x%x, ier 0x%x, level %d"

Reviewed-by: Cédric Le Goater <clg@redhat.com>

Thanks,

C.


