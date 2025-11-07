Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 60420CCFA05
	for <qemu-devel@archiver.kernel.org>; Fri,  7 Nov 2025 13:07:58 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vHMBh-0005To-W1; Fri, 07 Nov 2025 08:07:34 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@kaod.org>) id 1vHMBX-0005MY-5Q
 for qemu-devel@nongnu.org; Fri, 07 Nov 2025 08:07:24 -0500
Received: from 8.mo552.mail-out.ovh.net ([46.105.37.156])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@kaod.org>) id 1vHMBT-0003Mr-Un
 for qemu-devel@nongnu.org; Fri, 07 Nov 2025 08:07:22 -0500
Received: from mxplan5.mail.ovh.net (unknown [10.109.254.104])
 by mo552.mail-out.ovh.net (Postfix) with ESMTPS id 4d2zqP6Z6nz5xbl;
 Fri,  7 Nov 2025 13:07:13 +0000 (UTC)
Received: from kaod.org (37.59.142.111) by DAG8EX2.mxp5.local (172.16.2.72)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.61; Fri, 7 Nov
 2025 14:07:13 +0100
Authentication-Results: garm.ovh; auth=pass
 (GARM-111S0050f59d8bd-9e8f-49c7-a095-d7ef59166425,
 22B515FCB2325FA901564F8AB94FB8FB00D14EB6) smtp.auth=clg@kaod.org
X-OVh-ClientIp: 82.64.250.170
Message-ID: <325c9c29-2ff0-4623-ba1f-5061b1ae3df3@kaod.org>
Date: Fri, 7 Nov 2025 14:07:12 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 01/17] hw/arm/aspeed: Add LTPI controller
To: Kane Chen <kane_chen@aspeedtech.com>, Peter Maydell
 <peter.maydell@linaro.org>, Steven Lee <steven_lee@aspeedtech.com>, Troy Lee
 <leetroy@gmail.com>, Jamin Lin <jamin_lin@aspeedtech.com>, Andrew Jeffery
 <andrew@codeconstruct.com.au>, Joel Stanley <joel@jms.id.au>, "open
 list:ASPEED BMCs" <qemu-arm@nongnu.org>, "open list:All patches CC here"
 <qemu-devel@nongnu.org>
CC: <troy_lee@aspeedtech.com>
References: <20251105035859.3709907-1-kane_chen@aspeedtech.com>
 <20251105035859.3709907-2-kane_chen@aspeedtech.com>
From: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@kaod.org>
Content-Language: en-US, fr
Autocrypt: addr=clg@kaod.org; keydata=
 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
In-Reply-To: <20251105035859.3709907-2-kane_chen@aspeedtech.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [37.59.142.111]
X-ClientProxiedBy: DAG9EX2.mxp5.local (172.16.2.82) To DAG8EX2.mxp5.local
 (172.16.2.72)
X-Ovh-Tracer-GUID: 58e99346-6ce7-4751-814f-4cf0571620d6
X-Ovh-Tracer-Id: 17222046451377540018
X-VR-SPAMSTATE: OK
X-VR-SPAMSCORE: -100
X-VR-SPAMCAUSE: dmFkZTFngLPu69BEgtFmW7VNIuVa61RFLeTB+3sJb1bpfV/WhAyQOdx3l7QBE9/aydgjo/IYiDhbNGZVlVMU+pD15AQ+nVwTrWykg/0NRkcrV/nso6FCI8VHm7ggOnlf5AmfOX5ScE0mqcs6hDFypNzS1U1c4e6O8OJ4sLMWxipaiKFUPI1kbImAV2rh2v3PDulIvCQ8MsF2dUeFkfNWtt1AaEgJ+g6f0YFXMjWr/AHX4XyHaHdEUqgjYMsETqE/IHvaYuAPYr8f65vtXrT8AY8bWMyMIFA10mxJ23Hn05vKzIx3pkf61BgaNvzH/vhYZuP0qsCN0CtPyMMuNMzrRI0spJ9XhjvqrdaCaKM/5pfsEth3p/DBFObltl6rsLaF9aSh/3AO6cV8iTmeEGq2Z20TtJjfU0E5+leixGYnmtzPbcpNuzxyM3t4k8nXDgulVQqhOnDHThlnTG1NIIX9CSYbVBxVPYsk/SD3NHWqwtkcX/1AnQLoFH44wUBmiWx8BdpYJ1cZab4axMPmRD9fzhnQoH4xtvMxJoUdlBSl4VYrZ3kPl2Kn5wRxY61E3w3qk3ktgIIHtZIZKaQ8xIUcm5fQDfMRgZtjO1tzC2qpc+HeRYS3QRSftyFJp5dGjqPCX0brYqMdL3rQw0NJcZzEVZT9fI2hI+hoQwFgcpKb4++H0Q8iSg
DKIM-Signature: a=rsa-sha256; bh=9XGaOAGT//nN2u5DOG0AHqs/nIMu7wTSckhpua9pu3Y=; 
 c=relaxed/relaxed; d=kaod.org; h=From; s=ovhmo393970-selector1;
 t=1762520835; v=1;
 b=uPsdt8Nt8g+7PfCSQ4zaDqpLoEUN32rUJNwJHjStmLu34IggTAVYGZi0TavtWpH0m18IgEm5
 sRcutyinfgqCHlsk1FATOxbm+QaQHU+dTnbcUWVd74/Ul06ZG+7nRS0j5VDUmVXC0rEndqVVvPE
 KyyOLrDTyWWiHV9ayAp+AT8VSpY0thbUiJ4W7kMdTK+4kKNu50FpAjGYdJ7O8c/q1ryE5VuUdYP
 nWJyjN6Jkgn+rOOUsH0mTjGUcHfMRSBuAOmtZhmb4KNncSBr59HQvjCHhZ/xDzlYLl0or87t34M
 E9xDpBRqX8XC8ifDqMOUYRdbHw2/doY1RRP3DA0z/UVsg==
Received-SPF: pass client-ip=46.105.37.156; envelope-from=clg@kaod.org;
 helo=8.mo552.mail-out.ovh.net
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, SPF_HELO_NONE=0.001,
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

On 11/5/25 04:58, Kane Chen wrote:
> From: Kane-Chen-AS <kane_chen@aspeedtech.com>
> 
> LTPI (LVDS Tunneling Protocol & Interface) is defined in the OCP DC-SCM
> 2.0 specification:
> https://www.opencompute.org/documents/ocp-dc-scm-2-0-ltpi-ver-1-0-pdf
> 
> LTPI is a protocol and physical interface for tunneling various low-speed
> signals between the HPM and SCM. As shown in Figure 2, the AST27x0 (left)
> integrates two LTPI controllers, allowing it to connect to up to two
> extended boards.
> 
> This commit introduces a simple device model for the ASPEED LTPI
> controller in QEMU.
> 
> The model includes basic MMIO read/write operations and sets default
> register values during reset to emulate a link-up state.
> 
> Implements register space with read/write callbacks.
> 
> Signed-off-by: Kane-Chen-AS <kane_chen@aspeedtech.com>
> ---
>   include/hw/misc/aspeed_ltpi.h | 25 +++++++++
>   hw/misc/aspeed_ltpi.c         | 98 +++++++++++++++++++++++++++++++++++
>   hw/misc/meson.build           |  1 +
>   3 files changed, 124 insertions(+)
>   create mode 100644 include/hw/misc/aspeed_ltpi.h
>   create mode 100644 hw/misc/aspeed_ltpi.c
> 
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
> diff --git a/hw/misc/aspeed_ltpi.c b/hw/misc/aspeed_ltpi.c
> new file mode 100644
> index 0000000000..fdb71077a4
> --- /dev/null
> +++ b/hw/misc/aspeed_ltpi.c
> @@ -0,0 +1,98 @@
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
> +static uint64_t aspeed_ltpi_read(void *opaque, hwaddr offset, unsigned size)
> +{
> +    AspeedLTPIState *s = opaque;
> +    uint32_t idx = offset >> 2;
> +
> +    return s->regs[idx];
> +}
> +
> +static void aspeed_ltpi_write(void *opaque, hwaddr offset,
> +                              uint64_t val, unsigned size)
> +{
> +    AspeedLTPIState *s = opaque;
> +    uint32_t idx = offset >> 2;
> +
> +    switch (offset) {
> +    default:
> +        s->regs[idx] = (uint32_t)val;
> +        break;
> +    }
> +}
> +
> +static const MemoryRegionOps aspeed_ltpi_ops = {
> +    .read = aspeed_ltpi_read,
> +    .write = aspeed_ltpi_write,
> +    .endianness = DEVICE_LITTLE_ENDIAN,
> +    .valid = {
> +        .min_access_size = 1,
> +        .max_access_size = 4,
> +    },
> +};
> +
> +static void aspeed_ltpi_reset(DeviceState *dev)
> +{
> +    AspeedLTPIState *s = ASPEED_LTPI(dev);
> +    memset(s->regs, 0, sizeof(s->regs));
> +    /* set default values */
> +    s->regs[LTPI_LINK_MNG] = 0x11900007;
> +    s->regs[LTPI_PHY_MODE] = 0x2;
> +}
> +
> +
> +static const VMStateDescription vmstate_aspeed_ltpi = {
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
> +static void aspeed_ltpi_realize(DeviceState *dev, Error **errp)
> +{
> +    AspeedLTPIState *s = ASPEED_LTPI(dev);
> +
> +    memory_region_init_io(&s->mmio, OBJECT(s), &aspeed_ltpi_ops, s,
> +                          TYPE_ASPEED_LTPI, ASPEED_LTPI_NR_REGS);

The MMIO aperture is not number of registers. It should be 0x900.

Also, AIUI, there are 3 different register sets under this controller.
Don't we want to model them with sub regions ?


Thanks,

C.




> +    sysbus_init_mmio(SYS_BUS_DEVICE(s), &s->mmio);
> +}
> +
> +static void aspeed_ltpi_class_init(ObjectClass *klass, const void *data)
> +{
> +    DeviceClass *dc = DEVICE_CLASS(klass);
> +    dc->realize = aspeed_ltpi_realize;
> +    dc->vmsd = &vmstate_aspeed_ltpi;
> +    device_class_set_legacy_reset(dc, aspeed_ltpi_reset);
> +}
> +
> +static const TypeInfo aspeed_ltpi_info = {
> +    .name          = TYPE_ASPEED_LTPI,
> +    .parent        = TYPE_SYS_BUS_DEVICE,
> +    .instance_size = sizeof(AspeedLTPIState),
> +    .class_init    = aspeed_ltpi_class_init,
> +};
> +
> +static void aspeed_ltpi_register_types(void)
> +{
> +    type_register_static(&aspeed_ltpi_info);
> +}
> +
> +type_init(aspeed_ltpi_register_types);
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


