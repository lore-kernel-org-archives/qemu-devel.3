Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 73DE7D78770
	for <qemu-devel@archiver.kernel.org>; Fri, 19 Dec 2025 16:57:59 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vWdnS-000635-VM; Fri, 19 Dec 2025 11:57:42 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@kaod.org>) id 1vWdnR-00062g-EQ
 for qemu-devel@nongnu.org; Fri, 19 Dec 2025 11:57:41 -0500
Received: from 9.mo552.mail-out.ovh.net ([87.98.180.222])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@kaod.org>) id 1vWdnP-0004zA-I0
 for qemu-devel@nongnu.org; Fri, 19 Dec 2025 11:57:41 -0500
Received: from mxplan5.mail.ovh.net (unknown [10.110.54.78])
 by mo552.mail-out.ovh.net (Postfix) with ESMTPS id 4dXtxs0Mlvz5yWq;
 Fri, 19 Dec 2025 16:57:37 +0000 (UTC)
Received: from kaod.org (37.59.142.99) by DAG3EX1.mxp5.local (172.16.2.21)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.61; Fri, 19 Dec
 2025 17:57:36 +0100
Authentication-Results: garm.ovh; auth=pass
 (GARM-99G003a439b075-0992-4bf2-8b27-625121347a16,
 13AF5B8175AA3308F51DC8C03696883D036152F7) smtp.auth=clg@kaod.org
X-OVh-ClientIp: 82.64.250.170
Message-ID: <5372c8e5-3aef-41da-ad57-be244351fec4@kaod.org>
Date: Fri, 19 Dec 2025 17:57:35 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [SPAM] [PATCH v3 03/18] hw/misc: Add basic Aspeed PWM model
To: Kane Chen <kane_chen@aspeedtech.com>, Peter Maydell
 <peter.maydell@linaro.org>, Steven Lee <steven_lee@aspeedtech.com>, Troy Lee
 <leetroy@gmail.com>, Jamin Lin <jamin_lin@aspeedtech.com>, Andrew Jeffery
 <andrew@codeconstruct.com.au>, Joel Stanley <joel@jms.id.au>, "open
 list:ASPEED BMCs" <qemu-arm@nongnu.org>, "open list:All patches CC here"
 <qemu-devel@nongnu.org>
CC: <troy_lee@aspeedtech.com>
References: <20251208074436.1871180-1-kane_chen@aspeedtech.com>
 <20251208074436.1871180-4-kane_chen@aspeedtech.com>
Content-Language: en-US, fr
From: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@kaod.org>
Autocrypt: addr=clg@kaod.org; keydata=
 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
In-Reply-To: <20251208074436.1871180-4-kane_chen@aspeedtech.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [37.59.142.99]
X-ClientProxiedBy: DAG5EX1.mxp5.local (172.16.2.41) To DAG3EX1.mxp5.local
 (172.16.2.21)
X-Ovh-Tracer-GUID: 9ca63d2a-a91c-47bd-907c-22aa8d30c9b0
X-Ovh-Tracer-Id: 9511602413436439474
X-VR-SPAMSTATE: OK
X-VR-SPAMSCORE: -100
X-VR-SPAMCAUSE: dmFkZTFzQTMDqd7zqxY08PK+GjYCDilcYc053prcv0hSmx6Mwn3LOrkhv7WTCuk09snRTTumG6UJax/nkxq4wJB2A7KrYg7UlJs5uFIrOmCGNpZHZIbr4Vlog8klT3dxvE54jgW0d6dx3Mr4geZ2CT2GimWxk7P4vIt6571Qz0lKPziguYP3KtcSnEElHKmzT/C5ElkiTVrGhDD/G4uFwVSFrMOunqPK7XkUh90HR4Dz5B3vAf3fqfryRb9gtfYZ9wffNkqU7VViWQsWwZzELuMTYUaHm7XBTDTISOUtMejyM/3vN5iHaqRIpivzxYi1q+91PJxWaR2MK4dUToO/taaT7iaiZNb1yF/qK3GXYloExM4spWlaOk0YTS2Y/2y25seKhUo55rM+iiY7uF/+hzVlnwjk0159NUUR2M1Ft9gepL+16xik8fQrqFVl4D7jqFSyD1p/7VhMddn01fQb3R9na0bHDQTQJeVYBKp36Y0xXeyopDKxc8HdjFSxUkFqsbzTW18/W/IqtLY+OymYd+tnn4EFpdMLsoP4yonDGJj/aFwa3bneEy8iB0JOYxnFLidvT4DLh9+4OZtvcmDo6JPPCfS874NSTt9mxj/VTh2oPdcAy7WGbYzG+MZijcJQk5RF3SZQ4K8BPLOfxlHo+TS9fU/IGE4YhvF/rXCXsIznOSEYKA
DKIM-Signature: a=rsa-sha256; bh=UttQ/gO+i0ah+4hMJts5nJeLgE6ieeDyK3hdcoHik+8=; 
 c=relaxed/relaxed; d=kaod.org; h=From; s=ovhmo393970-selector1;
 t=1766163457; v=1;
 b=GqVChkLtmMwL/mVPOi4k+ol3lJOTFohHBgKSjbD3HeLCly7NhbqVBAB8C2X6S21w4mlIfQBP
 xxRfwGr6bXhvhcVeTuJgVNSA6Xwjzh1DsdbWj5Un+hKea9Gh/7pnil1/RQHauiip9eCa4hWvoBg
 +P3dhhQ6YT1uIvTm6UgOydgs3z2UJrh18ifZ9Kwui2kiVqJeCpQ7o+4o4jcAx32gTZ/04vvqBLN
 X+VKVY2yYlxzCSNUR883X/8uzKJeeci3sRwhwGEd5ktA0BYucqQCOL/5Ac2s7hb+yzyGU6wErAy
 d4uTwXgxs9UyTQMj7C/6QXbOClaKR7AxpQAEPb5sLBAFg==
Received-SPF: pass client-ip=87.98.180.222; envelope-from=clg@kaod.org;
 helo=9.mo552.mail-out.ovh.net
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001, SPF_HELO_NONE=0.001,
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

On 12/8/25 08:44, Kane Chen wrote:
> From: Kane-Chen-AS <kane_chen@aspeedtech.com>

Please keep the original Author name.

> Add an initial PWM model for Aspeed SoCs, including device state,
> register definitions, and basic initialization as a sysbus device.
> 
> Signed-off-by: Kane-Chen-AS <kane_chen@aspeedtech.com>

Also keep his S-o-b and add yours too.



Thanks,

C.

> ---
>   include/hw/arm/aspeed_soc.h  |   3 +-
>   include/hw/misc/aspeed_pwm.h |  31 +++++++++
>   hw/misc/aspeed_pwm.c         | 121 +++++++++++++++++++++++++++++++++++
>   hw/misc/meson.build          |   1 +
>   hw/misc/trace-events         |   4 ++
>   5 files changed, 159 insertions(+), 1 deletion(-)
>   create mode 100644 include/hw/misc/aspeed_pwm.h
>   create mode 100644 hw/misc/aspeed_pwm.c
> 
> diff --git a/include/hw/arm/aspeed_soc.h b/include/hw/arm/aspeed_soc.h
> index bca10c387b..5b0680f319 100644
> --- a/include/hw/arm/aspeed_soc.h
> +++ b/include/hw/arm/aspeed_soc.h
> @@ -28,6 +28,7 @@
>   #include "hw/misc/aspeed_hace.h"
>   #include "hw/misc/aspeed_sbc.h"
>   #include "hw/misc/aspeed_sli.h"
> +#include "hw/misc/aspeed_pwm.h"
>   #include "hw/watchdog/wdt_aspeed.h"
>   #include "hw/net/ftgmac100.h"
>   #include "target/arm/cpu.h"
> @@ -108,7 +109,7 @@ struct AspeedSoCState {
>       UnimplementedDeviceState video;
>       UnimplementedDeviceState emmc_boot_controller;
>       UnimplementedDeviceState dpmcu;
> -    UnimplementedDeviceState pwm;
> +    AspeedPWMState pwm;
>       UnimplementedDeviceState espi;
>       UnimplementedDeviceState udc;
>       UnimplementedDeviceState ltpi;
> diff --git a/include/hw/misc/aspeed_pwm.h b/include/hw/misc/aspeed_pwm.h
> new file mode 100644
> index 0000000000..13dc3ea45b
> --- /dev/null
> +++ b/include/hw/misc/aspeed_pwm.h
> @@ -0,0 +1,31 @@
> +/*
> + * ASPEED PWM Controller
> + *
> + * Copyright (C) 2017-2021 IBM Corp.
> + *
> + * This code is licensed under the GPL version 2 or later.  See
> + * the COPYING file in the top-level directory.
> + */
> +
> +#ifndef ASPEED_PWM_H
> +#define ASPEED_PWM_H
> +
> +#include "hw/sysbus.h"
> +
> +#define TYPE_ASPEED_PWM "aspeed.pwm"
> +#define ASPEED_PWM(obj) OBJECT_CHECK(AspeedPWMState, (obj), TYPE_ASPEED_PWM)
> +
> +#define ASPEED_PWM_NR_REGS (0x10C >> 2)
> +
> +typedef struct AspeedPWMState {
> +    /* <private> */
> +    SysBusDevice parent;
> +
> +    /*< public >*/
> +    MemoryRegion iomem;
> +    qemu_irq irq;
> +
> +    uint32_t regs[ASPEED_PWM_NR_REGS];
> +} AspeedPWMState;
> +
> +#endif /* _ASPEED_PWM_H_ */
> diff --git a/hw/misc/aspeed_pwm.c b/hw/misc/aspeed_pwm.c
> new file mode 100644
> index 0000000000..de209274af
> --- /dev/null
> +++ b/hw/misc/aspeed_pwm.c
> @@ -0,0 +1,121 @@
> +/*
> + * ASPEED PWM Controller
> + *
> + * Copyright (C) 2017-2021 IBM Corp.
> + *
> + * This code is licensed under the GPL version 2 or later.  See
> + * the COPYING file in the top-level directory.
> + */
> +
> +#include "qemu/osdep.h"
> +#include "qemu/log.h"
> +#include "qemu/error-report.h"
> +#include "hw/misc/aspeed_pwm.h"
> +#include "qapi/error.h"
> +#include "migration/vmstate.h"
> +
> +#include "trace.h"
> +
> +static uint64_t aspeed_pwm_read(void *opaque, hwaddr addr,
> +                                     unsigned int size)
> +{
> +    AspeedPWMState *s = ASPEED_PWM(opaque);
> +    uint64_t val = 0;
> +
> +    addr >>= 2;
> +
> +    if (addr >= ASPEED_PWM_NR_REGS) {
> +        qemu_log_mask(LOG_GUEST_ERROR,
> +                      "%s: Out-of-bounds read at offset 0x%" HWADDR_PRIx "\n",
> +                      __func__, addr << 2);
> +    } else {
> +        val = s->regs[addr];
> +    }
> +
> +    trace_aspeed_pwm_read(addr << 2, val);
> +
> +    return val;
> +}
> +
> +static void aspeed_pwm_write(void *opaque, hwaddr addr, uint64_t data,
> +                              unsigned int size)
> +{
> +    AspeedPWMState *s = ASPEED_PWM(opaque);
> +
> +    trace_aspeed_pwm_write(addr, data);
> +
> +    addr >>= 2;
> +
> +    if (addr >= ASPEED_PWM_NR_REGS) {
> +        qemu_log_mask(LOG_GUEST_ERROR,
> +                      "%s: Out-of-bounds write at offset 0x%" HWADDR_PRIx "\n",
> +                      __func__, addr << 2);
> +        return;
> +    }
> +
> +    s->regs[addr] = data;
> +}
> +
> +static const MemoryRegionOps aspeed_pwm_ops = {
> +    .read = aspeed_pwm_read,
> +    .write = aspeed_pwm_write,
> +    .endianness = DEVICE_LITTLE_ENDIAN,
> +    .valid = {
> +        .min_access_size = 1,
> +        .max_access_size = 4,
> +    },
> +};
> +
> +static void aspeed_pwm_reset(DeviceState *dev)
> +{
> +    struct AspeedPWMState *s = ASPEED_PWM(dev);
> +
> +    memset(s->regs, 0, sizeof(s->regs));
> +}
> +
> +static void aspeed_pwm_realize(DeviceState *dev, Error **errp)
> +{
> +    AspeedPWMState *s = ASPEED_PWM(dev);
> +    SysBusDevice *sbd = SYS_BUS_DEVICE(dev);
> +
> +    sysbus_init_irq(sbd, &s->irq);
> +
> +    memory_region_init_io(&s->iomem, OBJECT(s), &aspeed_pwm_ops, s,
> +            TYPE_ASPEED_PWM, 0x1000);
> +
> +    sysbus_init_mmio(sbd, &s->iomem);
> +}
> +
> +static const VMStateDescription vmstate_aspeed_pwm = {
> +    .name = TYPE_ASPEED_PWM,
> +    .version_id = 1,
> +    .minimum_version_id = 1,
> +    .fields = (VMStateField[]) {
> +        VMSTATE_UINT32_ARRAY(regs, AspeedPWMState, ASPEED_PWM_NR_REGS),
> +        VMSTATE_END_OF_LIST(),
> +    }
> +};
> +
> +static void aspeed_pwm_class_init(ObjectClass *klass, const void *data)
> +{
> +    DeviceClass *dc = DEVICE_CLASS(klass);
> +
> +    dc->realize = aspeed_pwm_realize;
> +    device_class_set_legacy_reset(dc, aspeed_pwm_reset);
> +    dc->desc = "Aspeed PWM Controller";
> +    dc->vmsd = &vmstate_aspeed_pwm;
> +}
> +
> +static const TypeInfo aspeed_pwm_info = {
> +    .name = TYPE_ASPEED_PWM,
> +    .parent = TYPE_SYS_BUS_DEVICE,
> +    .instance_size = sizeof(AspeedPWMState),
> +    .class_init = aspeed_pwm_class_init,
> +};
> +
> +static void aspeed_pwm_register_types(void)
> +{
> +    type_register_static(&aspeed_pwm_info);
> +}
> +
> +type_init(aspeed_pwm_register_types);
> diff --git a/hw/misc/meson.build b/hw/misc/meson.build
> index 45b16e7797..7afe1d0009 100644
> --- a/hw/misc/meson.build
> +++ b/hw/misc/meson.build
> @@ -137,6 +137,7 @@ system_ss.add(when: 'CONFIG_ASPEED_SOC', if_true: files(
>     'aspeed_i3c.c',
>     'aspeed_lpc.c',
>     'aspeed_ltpi.c',
> +  'aspeed_pwm.c',
>     'aspeed_scu.c',
>     'aspeed_sbc.c',
>     'aspeed_sdmc.c',
> diff --git a/hw/misc/trace-events b/hw/misc/trace-events
> index eeb9243898..f7870babba 100644
> --- a/hw/misc/trace-events
> +++ b/hw/misc/trace-events
> @@ -299,6 +299,10 @@ aspeed_i3c_write(uint64_t offset, uint64_t data) "I3C write: offset 0x%" PRIx64
>   aspeed_i3c_device_read(uint32_t deviceid, uint64_t offset, uint64_t data) "I3C Dev[%u] read: offset 0x%" PRIx64 " data 0x%" PRIx64
>   aspeed_i3c_device_write(uint32_t deviceid, uint64_t offset, uint64_t data) "I3C Dev[%u] write: offset 0x%" PRIx64 " data 0x%" PRIx64
>   
> +# aspeed_pwm.c
> +aspeed_pwm_read(uint64_t offset, uint64_t data) "read: offset 0x%" PRIx64 " data 0x%" PRIx64
> +aspeed_pwm_write(uint64_t offset, uint64_t data) "write: offset 0x%" PRIx64 " data 0x%" PRIx64
> +
>   # aspeed_sdmc.c
>   aspeed_sdmc_write(uint64_t reg, uint64_t data) "reg @0x%" PRIx64 " data: 0x%" PRIx64
>   aspeed_sdmc_read(uint64_t reg, uint64_t data) "reg @0x%" PRIx64 " data: 0x%" PRIx64


