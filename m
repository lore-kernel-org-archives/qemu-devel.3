Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1574FC7EE2A
	for <qemu-devel@archiver.kernel.org>; Mon, 30 Jun 2025 06:18:42 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uW7qM-0001Jx-3L; Mon, 30 Jun 2025 02:18:18 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <SRS0=bKmi=ZN=kaod.org=clg@ozlabs.org>)
 id 1uW7q1-0001Ca-EB; Mon, 30 Jun 2025 02:17:57 -0400
Received: from mail.ozlabs.org ([2404:9400:2221:ea00::3])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <SRS0=bKmi=ZN=kaod.org=clg@ozlabs.org>)
 id 1uW7py-0003sp-PU; Mon, 30 Jun 2025 02:17:57 -0400
Received: from mail.ozlabs.org (mail.ozlabs.org [IPv6:2404:9400:2221:ea00::3])
 by gandalf.ozlabs.org (Postfix) with ESMTP id 4bVwtw2r4zz4xQ0;
 Mon, 30 Jun 2025 16:17:44 +1000 (AEST)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (Client did not present a certificate)
 by mail.ozlabs.org (Postfix) with ESMTPSA id 4bVwts055kz4wvb;
 Mon, 30 Jun 2025 16:17:40 +1000 (AEST)
Message-ID: <4ee5bd2c-fd15-4947-88ee-30a28946d805@kaod.org>
Date: Mon, 30 Jun 2025 08:17:37 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 1/3] hw/misc/aspeed_otp: Add OTP device model with
 fallback RAM storage
To: Kane Chen <kane_chen@aspeedtech.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 Steven Lee <steven_lee@aspeedtech.com>, Troy Lee <leetroy@gmail.com>,
 Jamin Lin <jamin_lin@aspeedtech.com>,
 Andrew Jeffery <andrew@codeconstruct.com.au>, Joel Stanley <joel@jms.id.au>,
 "open list:ASPEED BMCs" <qemu-arm@nongnu.org>,
 "open list:All patches CC here" <qemu-devel@nongnu.org>
Cc: troy_lee@aspeedtech.com
References: <20250630051721.254207-1-kane_chen@aspeedtech.com>
 <20250630051721.254207-2-kane_chen@aspeedtech.com>
Content-Language: en-US, fr
From: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@kaod.org>
Autocrypt: addr=clg@kaod.org; keydata=
 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
In-Reply-To: <20250630051721.254207-2-kane_chen@aspeedtech.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2404:9400:2221:ea00::3;
 envelope-from=SRS0=bKmi=ZN=kaod.org=clg@ozlabs.org; helo=mail.ozlabs.org
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

On 6/30/25 07:17, Kane Chen wrote:
> From: Kane-Chen-AS <kane_chen@aspeedtech.com>
> 
> This patch introduces a QEMU model of the ASPEED One-Time Programmable
> (OTP) memory, used for secure fuse storage. The model simulates a
> word-addressable OTP region with a memory-like interface via a dedicated
> AddressSpace.
> 
> If no external block backend is provided via the "drive" property, the
> model automatically allocates an internal RAM-backed storage buffer
> to hold OTP data, enabling simplified usage without CLI configuration.
> 
> Signed-off-by: Kane-Chen-AS <kane_chen@aspeedtech.com>
> ---
>   include/hw/nvram/aspeed_otp.h |  33 ++++++++++
>   hw/nvram/aspeed_otp.c         | 113 ++++++++++++++++++++++++++++++++++
>   hw/nvram/meson.build          |   4 ++
>   3 files changed, 150 insertions(+)
>   create mode 100644 include/hw/nvram/aspeed_otp.h
>   create mode 100644 hw/nvram/aspeed_otp.c
> 
> diff --git a/include/hw/nvram/aspeed_otp.h b/include/hw/nvram/aspeed_otp.h
> new file mode 100644
> index 0000000000..22b2195a00
> --- /dev/null
> +++ b/include/hw/nvram/aspeed_otp.h
> @@ -0,0 +1,33 @@
> +/*
> + *  ASPEED OTP (One-Time Programmable) memory
> + *
> + *  Copyright (C) 2025 Aspeed
> + *
> + *  SPDX-License-Identifier: GPL-2.0-or-later
> + */
> +
> +#ifndef ASPEED_OTP_H
> +#define ASPEED_OTP_H
> +
> +#include "system/memory.h"
> +#include "hw/block/block.h"
> +#include "system/address-spaces.h"
> +
> +#define TYPE_ASPEED_OTP "aspeed.otp"
> +OBJECT_DECLARE_SIMPLE_TYPE(AspeedOTPState, ASPEED_OTP)
> +
> +typedef struct AspeedOTPState {
> +    DeviceState parent_obj;
> +
> +    BlockBackend *blk;
> +
> +    uint64_t size;
> +
> +    AddressSpace as;
> +
> +    MemoryRegion mmio;
> +
> +    uint8_t *storage;
> +} AspeedOTPState;
> +
> +#endif /* ASPEED_OTP_H */
> diff --git a/hw/nvram/aspeed_otp.c b/hw/nvram/aspeed_otp.c
> new file mode 100644
> index 0000000000..f018c58713
> --- /dev/null
> +++ b/hw/nvram/aspeed_otp.c
> @@ -0,0 +1,113 @@
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
> +#include "system/block-backend-global-state.h"
> +#include "system/block-backend-io.h"
> +#include "hw/qdev-properties.h"
> +#include "hw/nvram/aspeed_otp.h"
> +
> +static uint64_t aspeed_otp_read(void *opaque, hwaddr offset, unsigned size)
> +{
> +    AspeedOTPState *s = opaque;
> +    uint64_t val = 0;
> +
> +    memcpy(&val, s->storage + offset, size);
> +
> +    return val;
> +}
> +
> +static void aspeed_otp_write(void *opaque, hwaddr offset,
> +                                uint64_t val, unsigned size)
> +{
> +    AspeedOTPState *s = opaque;
> +
> +    memcpy(s->storage + offset, &val, size);
> +}
> +
> +static bool aspeed_otp_init_storage(AspeedOTPState *s, Error **errp)
> +{
> +    uint32_t *p;
> +    int i, num;
> +    uint64_t perm;
> +
> +    if (s->blk) {
> +        perm = BLK_PERM_CONSISTENT_READ |
> +               (blk_supports_write_perm(s->blk) ? BLK_PERM_WRITE : 0);
> +        if (blk_set_perm(s->blk, perm, BLK_PERM_ALL, errp) < 0) {
> +            return false;
> +        }
> +        if (blk_pread(s->blk, 0, s->size, s->storage, 0) < 0) {
> +            error_setg(errp, "Failed to read the initial flash content");
> +            return false;
> +        }
> +    } else {
> +        num = s->size / sizeof(uint32_t);
> +        p = (uint32_t *)s->storage;
> +        for (i = 0; i < num; i++) {
> +            p[i] = (i % 2 == 0) ? 0x00000000 : 0xFFFFFFFF;
> +        }
> +    }
> +    return true;
> +}
> +
> +static const MemoryRegionOps aspeed_otp_ops = {
> +    .read = aspeed_otp_read,
> +    .write = aspeed_otp_write,
> +    .endianness = DEVICE_LITTLE_ENDIAN,
> +    .valid.min_access_size = 1,
> +    .valid.max_access_size = 4,
> +};
> +
> +static void aspeed_otp_realize(DeviceState *dev, Error **errp)
> +{
> +    AspeedOTPState *s = ASPEED_OTP(dev);
> +
> +    if (s->size == 0) {
> +        error_setg(errp, "aspeed.otp: 'size' property must be set");
> +        return;
> +    }
> +
> +    s->storage = blk_blockalign(s->blk, s->size);
> +
> +    if (!aspeed_otp_init_storage(s, errp)) {
> +        return;
> +    }
> +
> +    memory_region_init_io(&s->mmio, OBJECT(dev), &aspeed_otp_ops,
> +                          s, "aspeed.otp", s->size);
> +    address_space_init(&s->as, &s->mmio, NULL);
> +}
> +
> +static const Property aspeed_otp_properties[] = {
> +    DEFINE_PROP_UINT64("size", AspeedOTPState, size, 0),
> +    DEFINE_PROP_DRIVE("drive", AspeedOTPState, blk),
> +};
> +
> +static void aspeed_otp_class_init(ObjectClass *klass, const void *data)
> +{
> +    DeviceClass *dc = DEVICE_CLASS(klass);
> +    dc->realize = aspeed_otp_realize;
> +    device_class_set_props(dc, aspeed_otp_properties);
> +}
> +
> +static const TypeInfo aspeed_otp_info = {
> +    .name          = TYPE_ASPEED_OTP,
> +    .parent        = TYPE_DEVICE,
> +    .instance_size = sizeof(AspeedOTPState),
> +    .class_init    = aspeed_otp_class_init,
> +};
> +
> +static void aspeed_otp_register_types(void)
> +{
> +    type_register_static(&aspeed_otp_info);
> +}
> +
> +type_init(aspeed_otp_register_types)
> diff --git a/hw/nvram/meson.build b/hw/nvram/meson.build
> index 10f3639db6..b66f23605b 100644
> --- a/hw/nvram/meson.build
> +++ b/hw/nvram/meson.build
> @@ -19,3 +19,7 @@ system_ss.add(when: 'CONFIG_XLNX_BBRAM', if_true: files('xlnx-bbram.c'))
>   
>   specific_ss.add(when: 'CONFIG_PSERIES', if_true: files('spapr_nvram.c'))
>   specific_ss.add(when: 'CONFIG_ACPI', if_true: files('fw_cfg-acpi.c'))
> +
> +system_ss.add(when: 'CONFIG_ASPEED_SOC', if_true: files(
> +  'aspeed_otp.c',
> +  ))
> \ No newline at end of file


The patch looks OK but, in the previous round, I asked to add the
BlockBackend and drive in a new patch. May be I wasn't clear ?

Thanks,

C.





