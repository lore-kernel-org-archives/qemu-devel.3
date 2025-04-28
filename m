Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5DA4DC369D3
	for <qemu-devel@archiver.kernel.org>; Mon, 28 Apr 2025 07:07:35 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u9IZa-0002Lk-FZ; Mon, 28 Apr 2025 03:06:38 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <SRS0=KRh2=XO=kaod.org=clg@ozlabs.org>)
 id 1u9IZX-0002Ky-Jn; Mon, 28 Apr 2025 03:06:35 -0400
Received: from mail.ozlabs.org ([2404:9400:2221:ea00::3])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <SRS0=KRh2=XO=kaod.org=clg@ozlabs.org>)
 id 1u9IZS-0004C3-SR; Mon, 28 Apr 2025 03:06:34 -0400
Received: from mail.ozlabs.org (mail.ozlabs.org [IPv6:2404:9400:2221:ea00::3])
 by gandalf.ozlabs.org (Postfix) with ESMTP id 4ZmDy44lm9z4xCy;
 Mon, 28 Apr 2025 17:06:20 +1000 (AEST)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (Client did not present a certificate)
 by mail.ozlabs.org (Postfix) with ESMTPSA id 4ZmDy10WXSz4x0t;
 Mon, 28 Apr 2025 17:06:14 +1000 (AEST)
Message-ID: <ed2f2840-1eee-46d9-8f2f-aa720e015c83@kaod.org>
Date: Mon, 28 Apr 2025 09:06:11 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 1/3] hw/misc/aspeed_otp: Add Aspeed OTP memory device
 model
To: Kane Chen <kane_chen@aspeedtech.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 Steven Lee <steven_lee@aspeedtech.com>, Troy Lee <leetroy@gmail.com>,
 Jamin Lin <jamin_lin@aspeedtech.com>,
 Andrew Jeffery <andrew@codeconstruct.com.au>, Joel Stanley <joel@jms.id.au>,
 "open list:ASPEED BMCs" <qemu-arm@nongnu.org>,
 "open list:All patches CC here" <qemu-devel@nongnu.org>
Cc: troy_lee@aspeedtech.com
References: <20250423025651.189702-1-kane_chen@aspeedtech.com>
 <20250423025651.189702-2-kane_chen@aspeedtech.com>
Content-Language: en-US, fr
From: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@kaod.org>
Autocrypt: addr=clg@kaod.org; keydata=
 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
In-Reply-To: <20250423025651.189702-2-kane_chen@aspeedtech.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2404:9400:2221:ea00::3;
 envelope-from=SRS0=KRh2=XO=kaod.org=clg@ozlabs.org; helo=mail.ozlabs.org
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

On 4/23/25 04:56, Kane Chen wrote:
> From: Kane-Chen-AS <kane_chen@aspeedtech.com>
> 
> This introduces a new model for the ASPEED OTP (One-Time Programmable)
> memory. The device is implemented as a `SysBusDevice` and provides an
> abstracted interface for OTP read, write (program), and default value
> initialization.
> 
> OTP content is backed by a block device and supports QEMU’s drive
> infrastructure via the "drive" property.
> 
> Features:
> - Enforces irreversible bit programming logic (0->1 or 1->0)
> - Provides interface for SoC/secure controller integration
> - Validates bounds and bit-level constraints
> - Uses QEMU error handling conventions and logging
> 
> Signed-off-by: Kane-Chen-AS <kane_chen@aspeedtech.com>
> ---
>   hw/misc/aspeed_otpmem.c         | 211 ++++++++++++++++++++++++++++++++
>   hw/misc/meson.build             |   1 +
>   include/hw/misc/aspeed_otpmem.h |  40 ++++++
>   3 files changed, 252 insertions(+)
>   create mode 100644 hw/misc/aspeed_otpmem.c
>   create mode 100644 include/hw/misc/aspeed_otpmem.h
> 
> diff --git a/hw/misc/aspeed_otpmem.c b/hw/misc/aspeed_otpmem.c
> new file mode 100644
> index 0000000000..4f8f2827f7
> --- /dev/null
> +++ b/hw/misc/aspeed_otpmem.c
> @@ -0,0 +1,211 @@
> +/*
> + *  ASPEED OTP (One-Time Programmable) memory
> + *
> + *  Copyright (C) 2025 Aspeed
> + *
> + * This code is licensed under the GPL version 2 or later.  See
> + * the COPYING file in the top-level directory.
> + */
> +
> +#include "qemu/osdep.h"
> +#include "hw/block/block.h"
> +#include "hw/block/flash.h"
> +#include "hw/qdev-properties.h"
> +#include "hw/qdev-properties-system.h"
> +#include "system/block-backend.h"
> +#include "qemu/log.h"
> +#include "qemu/option.h"
> +#include "hw/sysbus.h"
> +#include "qemu/error-report.h"
> +#include "hw/misc/aspeed_otpmem.h"
> +
> +static const Property aspeed_otpmem_properties[] = {
> +    DEFINE_PROP_DRIVE("drive", AspeedOTPMemState, blk),
> +};

Usually the 'Property' array is defined just before the class_init
routine. Please move it there.

> +static void aspeed_otpmem_read(void *opaque, uint32_t addr,
> +                               uint32_t *out, Error **errp)

hmm, that's not a MemoryRegion handler. Why not ? I will check in the
following patches

> +{
> +    AspeedOTPMemState *otp = ASPEED_OTPMEM(opaque);
> +
> +    assert(otp->blk);

This check shouldn't be needed if the backend id initialized in the
realize routine.

> +    if (out == NULL) {
> +        error_setg(errp, "out is NULL");
> +        return;
> +    }
> +
> +    if (addr > (otp->max_size - 4)) {

Why a MemoryRegion, no need for this check.

> +        error_setg(errp, "OTP memory 0x%x is exceeded", addr);
> +        return;
> +    }
> +
> +    if (blk_pread(otp->blk, (int64_t)addr, sizeof(uint32_t), out, 0) < 0) {
> +        error_setg(errp, "Failed to read data 0x%x", addr);
> +        return;
> +    }
> +    return;
> +}
> +
> +static bool valid_program_data(uint32_t otp_addr,
> +                                 uint32_t value, uint32_t prog_bit)
> +{
> +    uint32_t programmed_bits, has_programmable_bits;
> +    bool is_odd = otp_addr & 1;
> +
> +    /*
> +     * prog_bit uses 0s to indicate target bits to program:
> +     *   - if OTP word is even-indexed, programmed bits flip 0->1
> +     *   - if odd, bits flip 1->0
> +     * Bit programming is one-way only and irreversible.
> +     */
> +    if (is_odd) {
> +        programmed_bits = ~value & prog_bit;
> +    } else {
> +        programmed_bits = value & (~prog_bit);
> +    }
> +
> +    /* If there is some bit can be programed, to accept the request */
> +    has_programmable_bits = value ^ (~prog_bit);
> +
> +    if (programmed_bits) {
> +        qemu_log_mask(LOG_GUEST_ERROR,
> +                      "%s: Found programmed bits in addr %x\n",
> +                      __func__, otp_addr);
> +        for (int i = 0; i < 32; ++i) {
> +            if (programmed_bits & (1U << i)) {
> +                qemu_log_mask(LOG_GUEST_ERROR,
> +                              "  Programmed bit %d\n",
> +                              i);
> +            }
> +        }
> +    }
> +
> +    return has_programmable_bits != 0;
> +}
> +
> +static bool program_otpmem_data(void *opaque, uint32_t otp_addr,
> +                             uint32_t prog_bit, uint32_t *value)
> +{
> +    AspeedOTPMemState *s = ASPEED_OTPMEM(opaque);
> +    bool is_odd = otp_addr & 1;
> +    uint32_t otp_offset = otp_addr << 2;
> +
> +    if (blk_pread(s->blk, (int64_t)otp_offset,
> +                  sizeof(uint32_t), value, 0) < 0) {
> +        qemu_log_mask(LOG_GUEST_ERROR,
> +                      "%s: Failed to read data 0x%x\n",
> +                      __func__, otp_offset);
> +        return false;
> +    }
> +
> +    if (!valid_program_data(otp_addr, *value, prog_bit)) {
> +        return false;
> +    }
> +
> +    if (is_odd) {
> +        *value &= ~prog_bit;
> +    } else {
> +        *value |= ~prog_bit;
> +    }
> +
> +    return true;
> +}
> +
> +static void aspeed_otpmem_prog(void *s, uint32_t otp_addr,
> +                               uint32_t data, Error **errp)
> +{
> +    AspeedOTPMemState *otp = ASPEED_OTPMEM(s);
> +    uint32_t otp_offset, value;
> +
> +    assert(otp->blk);
> +
> +    if (otp_addr > (otp->max_size >> 2)) {
> +        error_setg(errp, "OTP memory 0x%x is exceeded", otp_addr);
> +        return;
> +    }
> +
> +    otp_offset = otp_addr << 2;
> +    if (!program_otpmem_data(s, otp_addr, data, &value)) {
> +        error_setg(errp, "Failed to program data");
> +        return;
> +    }
> +
> +    if (blk_pwrite(otp->blk, (int64_t)otp_offset,
> +                   sizeof(value), &value, 0) < 0) {
> +        error_setg(errp, "Failed to write data");
> +    }
> +
> +    return;
> +}
> +
> +static void aspeed_otpmem_set_default(void *s, uint32_t otp_offset,
> +                                      uint32_t data, Error **errp)
> +{
> +    AspeedOTPMemState *otp = ASPEED_OTPMEM(s);
> +
> +    if ((otp_offset + 4) > otp->max_size) {
> +        error_setg(errp, "OTP memory 0x%x is exceeded", otp_offset);
> +        return;
> +    }
> +
> +    if (blk_pwrite(otp->blk, (int64_t)otp_offset,
> +                   sizeof(data), &data, 0) < 0) {
> +        error_setg(errp, "Failed to write data");
> +    }
> +    return;
> +}
> +
> +static AspeedOTPMemOps aspeed_otpmem_ops = {
> +    .read = aspeed_otpmem_read,
> +    .prog = aspeed_otpmem_prog,
> +    .set_default_value = aspeed_otpmem_set_default
> +};
> +
> +static void aspeed_otpmem_realize(DeviceState *dev, Error **errp)
> +{
> +    AspeedOTPMemState *s = ASPEED_OTPMEM(dev);
> +
> +    if (!s->blk) {
> +        error_setg(&error_fatal, "OTP memory is not initialized");
> +        return;
> +    }
> +
> +    s->max_size = blk_getlength(s->blk);
> +    if (s->max_size < 0 || (s->max_size % 4)) {
> +        error_setg(&error_fatal,
> +                   "Unexpected OTP memory size: %" PRId64 "",
> +                   s->max_size);
> +        return;
> +    }
> +
> +    s->ops = &aspeed_otpmem_ops;

You should consider using an AddressSpace for the OTP transactions.

> +    return;
> +}
> +
> +static void aspeed_otpmem_system_reset(DeviceState *dev)
> +{
> +    return;
> +}
> +

Reset is empty. Please remove.


> +static void aspeed_otpmem_class_init(ObjectClass *klass, void *data)> +{
> +    DeviceClass *dc = DEVICE_CLASS(klass);
> +
> +    device_class_set_legacy_reset(dc, aspeed_otpmem_system_reset);
> +    dc->realize = aspeed_otpmem_realize;
> +    device_class_set_props(dc, aspeed_otpmem_properties);
> +
> +}
> +
> +static const TypeInfo aspeed_otpmem_types[] = {
> +    {
> +        .name           = TYPE_ASPEED_OTPMEM,
> +        .parent         = TYPE_SYS_BUS_DEVICE,
> +        .instance_size  = sizeof(AspeedOTPMemState),
> +        .class_init     = aspeed_otpmem_class_init,
> +    },
> +};
> +
> +DEFINE_TYPES(aspeed_otpmem_types)
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
> diff --git a/include/hw/misc/aspeed_otpmem.h b/include/hw/misc/aspeed_otpmem.h
> new file mode 100644
> index 0000000000..11e2de70b6
> --- /dev/null
> +++ b/include/hw/misc/aspeed_otpmem.h
> @@ -0,0 +1,40 @@
> +/*
> + *  ASPEED OTP (One-Time Programmable) memory
> + *
> + *  Copyright (C) 2025 Aspeed
> + *
> + * This code is licensed under the GPL version 2 or later.  See
> + * the COPYING file in the top-level directory.
> + */
> +
> +#ifndef ASPEED_OTPMMEM_H
> +#define ASPEED_OTPMMEM_H
> +
> +#include "hw/sysbus.h"
> +#include "qapi/error.h"
> +
> +#define TYPE_ASPEED_OTPMEM "aspeed.otpmem"
> +#define ASPEED_OTPMEM_DRIVE "otpmem"

This ASPEED_OTPMEM_DRIVE definition looks wrong to me. What is it for ?

Thanks,

C.


> +
> +#define ASPEED_OTPMEM(obj) OBJECT_CHECK(AspeedOTPMemState, (obj), \
> +                                        TYPE_ASPEED_OTPMEM)
> +
> +typedef struct AspeedOTPMemOps {
> +    void (*read)(void *s, uint32_t addr, uint32_t *out, Error **errp);
> +    void (*prog)(void *s, uint32_t addr, uint32_t data, Error **errp);
> +    void (*set_default_value)(void *s, uint32_t otp_offset,
> +                              uint32_t data, Error **errp);
> +} AspeedOTPMemOps;
> +
> +typedef struct AspeedOTPMemState {
> +    SysBusDevice parent_obj;
> +
> +    MemoryRegion mmio;
> +    BlockBackend *blk;
> +    int64_t max_size;
> +
> +    AspeedOTPMemOps *ops;
> +} AspeedOTPMemState;
> +
> +#endif /* ASPEED_OTPMMEM_H */
> +


