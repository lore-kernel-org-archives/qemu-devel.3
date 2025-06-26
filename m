Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A5AC4C77B7F
	for <qemu-devel@archiver.kernel.org>; Thu, 26 Jun 2025 08:23:47 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uUhss-0002c5-RR; Thu, 26 Jun 2025 04:23:03 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <SRS0=Iwxx=ZJ=kaod.org=clg@ozlabs.org>)
 id 1uUhsr-0002bN-4X; Thu, 26 Jun 2025 04:23:01 -0400
Received: from gandalf.ozlabs.org ([150.107.74.76] helo=mail.ozlabs.org)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <SRS0=Iwxx=ZJ=kaod.org=clg@ozlabs.org>)
 id 1uUhso-0001g8-EA; Thu, 26 Jun 2025 04:23:00 -0400
Received: from mail.ozlabs.org (mail.ozlabs.org [IPv6:2404:9400:2221:ea00::3])
 by gandalf.ozlabs.org (Postfix) with ESMTP id 4bSWs54n39z4x5g;
 Thu, 26 Jun 2025 18:22:49 +1000 (AEST)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (Client did not present a certificate)
 by mail.ozlabs.org (Postfix) with ESMTPSA id 4bSWs22vf9z4x0C;
 Thu, 26 Jun 2025 18:22:46 +1000 (AEST)
Message-ID: <37b1845f-85f6-4c5a-aba1-45433844ad7f@kaod.org>
Date: Thu, 26 Jun 2025 10:22:43 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 1/3] hw/misc/aspeed_otp: Add ASPEED OTP memory device
 model
To: Kane Chen <kane_chen@aspeedtech.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 Steven Lee <steven_lee@aspeedtech.com>, Troy Lee <leetroy@gmail.com>,
 Jamin Lin <jamin_lin@aspeedtech.com>,
 Andrew Jeffery <andrew@codeconstruct.com.au>, Joel Stanley <joel@jms.id.au>,
 "open list:ASPEED BMCs" <qemu-arm@nongnu.org>,
 "open list:All patches CC here" <qemu-devel@nongnu.org>
Cc: troy_lee@aspeedtech.com
References: <20250626075711.1589039-1-kane_chen@aspeedtech.com>
 <20250626075711.1589039-2-kane_chen@aspeedtech.com>
Content-Language: en-US, fr
From: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@kaod.org>
Autocrypt: addr=clg@kaod.org; keydata=
 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
In-Reply-To: <20250626075711.1589039-2-kane_chen@aspeedtech.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=150.107.74.76;
 envelope-from=SRS0=Iwxx=ZJ=kaod.org=clg@ozlabs.org; helo=mail.ozlabs.org
X-Spam_score_int: -41
X-Spam_score: -4.2
X-Spam_bar: ----
X-Spam_report: (-4.2 / 5.0 requ) BAYES_00=-1.9,
 HEADER_FROM_DIFFERENT_DOMAINS=0.001, RCVD_IN_DNSWL_MED=-2.3,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
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

On 6/26/25 09:57, Kane Chen wrote:
> From: Kane-Chen-AS <kane_chen@aspeedtech.com>
> 
> Introduce a QEMU device model for ASPEED's One-Time Programmable (OTP)
> memory.
> 
> This model simulates a word-addressable OTP region used for secure
> fuse storage. The OTP memory can operate with an internal memory
> buffer.
> 
> The OTP model provides a memory-like interface through a dedicated
> AddressSpace, allowing other device models (e.g., SBC) to issue
> transactions as if accessing a memory-mapped region.
> 
> Signed-off-by: Kane-Chen-AS <kane_chen@aspeedtech.com>
> ---
>   include/hw/misc/aspeed_otpmem.h | 33 ++++++++++++
>   hw/misc/aspeed_otpmem.c         | 91 +++++++++++++++++++++++++++++++++

Peter suggested to move these files under hw/nvram/ with the
other OTP models.

Please consider renaming to :

    include/hw/nvram/aspeed_otp.h
    hw/nvram/aspeed_otp.c


>   3 files changed, 125 insertions(+)
>   create mode 100644 include/hw/misc/aspeed_otpmem.h
>   create mode 100644 hw/misc/aspeed_otpmem.c
> 
> diff --git a/include/hw/misc/aspeed_otpmem.h b/include/hw/misc/aspeed_otpmem.h
> new file mode 100644
> index 0000000000..64cd4d1a7c
> --- /dev/null
> +++ b/include/hw/misc/aspeed_otpmem.h
> @@ -0,0 +1,33 @@
> +/*
> + *  ASPEED OTP (One-Time Programmable) memory
> + *
> + *  Copyright (C) 2025 Aspeed
> + *
> + *  SPDX-License-Identifier: GPL-2.0-or-later
> + */
> +
> +#ifndef ASPEED_OTPMEM_H
> +#define ASPEED_OTPMEM_H
> +
> +#include "system/memory.h"
> +#include "hw/block/block.h"
> +#include "system/memory.h"
> +#include "system/address-spaces.h"
> +
> +#define OTPMEM_SIZE 0x4000

This define doesn't seem useful. May be instead, set the OTP object
"size" from the parent model at realize time.

> +#define TYPE_ASPEED_OTPMEM "aspeed.otpmem"
> +OBJECT_DECLARE_SIMPLE_TYPE(AspeedOTPMemState, ASPEED_OTPMEM)
> +
> +typedef struct AspeedOTPMemState {
> +    DeviceState parent_obj;
> +
> +    uint64_t size;
> +
> +    AddressSpace as;
> +
> +    MemoryRegion mmio;
> +
> +    uint8_t *storage;
> +} AspeedOTPMemState;
> +
> +#endif /* ASPEED_OTPMEM_H */
> diff --git a/hw/misc/aspeed_otpmem.c b/hw/misc/aspeed_otpmem.c
> new file mode 100644
> index 0000000000..a77d4186f8
> --- /dev/null
> +++ b/hw/misc/aspeed_otpmem.c
> @@ -0,0 +1,91 @@
> +/*
> + *  ASPEED OTP (One-Time Programmable) memory
> + *
> + *  Copyright (C) 2025 Aspeed
> + *
> + *  SPDX-License-Identifier: GPL-2.0-or-later
> + */
> +
> +#include "qemu/osdep.h"
> +#include "qemu/log.h"
> +#include "qapi/error.h"
> +#include "trace.h"
> +#include "system/block-backend-global-state.h"
> +#include "system/block-backend-io.h"
> +#include "hw/misc/aspeed_otpmem.h"
> +
> +static uint64_t aspeed_otpmem_read(void *opaque, hwaddr offset, unsigned size)
> +{
> +    AspeedOTPMemState *s = opaque;
> +    uint64_t val = 0;
> +
> +    memcpy(&val, s->storage + offset, size);
> +
> +    return val;
> +}
> +
> +static void aspeed_otpmem_write(void *opaque, hwaddr offset,
> +                                uint64_t val, unsigned size)
> +{
> +    AspeedOTPMemState *s = opaque;
> +
> +    memcpy(s->storage + offset, &val, size);
> +}
> +
> +static void aspeed_otpmem_init_storage(uint8_t *storage, uint64_t size)
> +{
> +    uint32_t *p;
> +    int i, num;
> +
> +    num = size / sizeof(uint32_t);
> +    p = (uint32_t *)storage;
> +    for (i = 0; i < num; i++) {
> +        p[i] = (i % 2 == 0) ? 0x00000000 : 0xFFFFFFFF;
> +    }
> +}
> +
> +static const MemoryRegionOps aspeed_otpmem_ops = {
> +    .read = aspeed_otpmem_read,
> +    .write = aspeed_otpmem_write,
> +    .endianness = DEVICE_LITTLE_ENDIAN,
> +    .valid.min_access_size = 1,
> +    .valid.max_access_size = 4,
> +};
> +
> +static void aspeed_otpmem_realize(DeviceState *dev, Error **errp)
> +{
> +    AspeedOTPMemState *s = ASPEED_OTPMEM(dev);
> +
> +    s->storage = g_malloc(s->size);
> +
> +    aspeed_otpmem_init_storage(s->storage, s->size);
> +
> +    memory_region_init_io(&s->mmio, OBJECT(dev), &aspeed_otpmem_ops,
> +                          s, "aspeed.otpmem", s->size);
> +    address_space_init(&s->as, &s->mmio, NULL);
> +}
> +
> +static const Property aspeed_otpmem_properties[] = {
> +    DEFINE_PROP_UINT64("size", AspeedOTPMemState, size, OTPMEM_SIZE),
> +};
> +
> +static void aspeed_otpmem_class_init(ObjectClass *klass, const void *data)
> +{
> +    DeviceClass *dc = DEVICE_CLASS(klass);
> +    dc->realize = aspeed_otpmem_realize;
> +    device_class_set_props(dc, aspeed_otpmem_properties);
> +}
> +
> +static const TypeInfo aspeed_otpmem_info = {
> +    .name          = TYPE_ASPEED_OTPMEM,
> +    .parent        = TYPE_DEVICE,
> +    .instance_size = sizeof(AspeedOTPMemState),
> +    .class_init    = aspeed_otpmem_class_init,
> +};
> +
> +static void aspeed_otpmem_register_types(void)
> +{
> +    type_register_static(&aspeed_otpmem_info);
> +}
> +
> +type_init(aspeed_otpmem_register_types)
> diff --git a/hw/misc/meson.build b/hw/misc/meson.build
> index 6d47de482c..ed1eaaa2ad 100644
> --- a/hw/misc/meson.build
> +++ b/hw/misc/meson.build
> @@ -136,6 +136,7 @@ system_ss.add(when: 'CONFIG_ASPEED_SOC', if_true: files(
>     'aspeed_sbc.c',
>     'aspeed_sdmc.c',
>     'aspeed_xdma.c',
> +  'aspeed_otpmem.c',
>     'aspeed_peci.c',
>     'aspeed_sli.c'))
>   


