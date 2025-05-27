Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 92AEBC54F30
	for <qemu-devel@archiver.kernel.org>; Tue, 27 May 2025 07:00:05 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uJoHe-0003ae-RH; Tue, 27 May 2025 02:59:35 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <SRS0=kr5U=YL=kaod.org=clg@ozlabs.org>)
 id 1uJoHd-0003Zp-BL; Tue, 27 May 2025 02:59:33 -0400
Received: from gandalf.ozlabs.org ([150.107.74.76] helo=mail.ozlabs.org)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <SRS0=kr5U=YL=kaod.org=clg@ozlabs.org>)
 id 1uJoHZ-0001WD-A2; Tue, 27 May 2025 02:59:33 -0400
Received: from mail.ozlabs.org (mail.ozlabs.org [IPv6:2404:9400:2221:ea00::3])
 by gandalf.ozlabs.org (Postfix) with ESMTP id 4b63Qd0Cdpz4x0t;
 Tue, 27 May 2025 16:59:21 +1000 (AEST)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (Client did not present a certificate)
 by mail.ozlabs.org (Postfix) with ESMTPSA id 4b63QY236jz4wy6;
 Tue, 27 May 2025 16:59:14 +1000 (AEST)
Message-ID: <d3b2f128-58ab-4efc-a48d-b42ad4407f9b@kaod.org>
Date: Tue, 27 May 2025 08:59:11 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 1/3] hw/misc/aspeed_otp: Add ASPEED OTP memory device
 model
To: Kane Chen <kane_chen@aspeedtech.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 Steven Lee <steven_lee@aspeedtech.com>, Troy Lee <leetroy@gmail.com>,
 Jamin Lin <jamin_lin@aspeedtech.com>,
 Andrew Jeffery <andrew@codeconstruct.com.au>, Joel Stanley <joel@jms.id.au>,
 "open list:ASPEED BMCs" <qemu-arm@nongnu.org>,
 "open list:All patches CC here" <qemu-devel@nongnu.org>
Cc: troy_lee@aspeedtech.com
References: <20250512091014.3454083-1-kane_chen@aspeedtech.com>
 <20250512091014.3454083-2-kane_chen@aspeedtech.com>
Content-Language: en-US, fr
From: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@kaod.org>
Autocrypt: addr=clg@kaod.org; keydata=
 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
In-Reply-To: <20250512091014.3454083-2-kane_chen@aspeedtech.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=150.107.74.76;
 envelope-from=SRS0=kr5U=YL=kaod.org=clg@ozlabs.org; helo=mail.ozlabs.org
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

Hello Kane

On 5/12/25 11:10, Kane Chen wrote:
> From: Kane-Chen-AS <kane_chen@aspeedtech.com>
> 
> Introduce a QEMU model for ASPEED One-Time Programmable (OTP) memory.
> 
> This device provides:
> - Bit-level irreversible programming (0→1 for even, 1→0 for odd)
> - Read, program, and default-value initialization interfaces
> - File-backed OTP content via machine parameter
> - Trace support for bit conflict debugging
> - Error propagation via QEMU's Error** interface
> 
> The OTP backend is designed to integrate with SoCs requiring secure fuse storage
> or secure boot features.
> 
> Signed-off-by: Kane-Chen-AS <kane_chen@aspeedtech.com>
> ---
>   hw/misc/aspeed_otpmem.c         | 198 ++++++++++++++++++++++++++++++++
>   hw/misc/meson.build             |   1 +
>   hw/misc/trace-events            |   5 +
>   include/hw/misc/aspeed_otpmem.h |  39 +++++++

please include in your .git/config

[diff]
	orderFile = /path/to/qemu/scripts/git.orderfile

>   4 files changed, 243 insertions(+)
>   create mode 100644 hw/misc/aspeed_otpmem.c
>   create mode 100644 include/hw/misc/aspeed_otpmem.h
> 
> diff --git a/hw/misc/aspeed_otpmem.c b/hw/misc/aspeed_otpmem.c
> new file mode 100644
> index 0000000000..4c1dee8782
> --- /dev/null
> +++ b/hw/misc/aspeed_otpmem.c
> @@ -0,0 +1,198 @@
> +/*
> + *  ASPEED OTP (One-Time Programmable) memory
> + *
> + *  Copyright (C) 2025 Aspeed
> + *
> + * This code is licensed under the GPL version 2 or later.  See
> + * the COPYING file in the top-level directory.

Replace the license boiler plate with :

       SPDX-License-Identifier: GPL-2.0-or-later


> + */
> +
> +#include "qemu/osdep.h"
> +#include "qemu/log.h"
> +#include "qapi/error.h"
> +#include "trace.h"
> +#include "hw/misc/aspeed_otpmem.h"
> +
> +void aspeed_otpmem_set_backend(AspeedOTPMemState *s, const char *path)
> +{
> +    g_free(s->otpmem_img_path);
> +    s->otpmem_img_path = g_strdup(path);
> +}
> +
> +static void aspeed_otpmem_sync_region(AspeedOTPMemState *s,
> +                                      hwaddr offset, hwaddr size)
> +{
> +    memory_region_msync(&s->iomem, offset, size);
> +}
> +
> +static uint32_t aspeed_otpmem_read(AspeedOtpmemState *s,
> +                                   uint32_t addr, Error **errp)
> +{
> +    uint32_t val = 0;
> +    MemTxResult ret;
> +
> +    ret = address_space_read(&s->as, addr, MEMTXATTRS_UNSPECIFIED,
> +                             (uint8_t *)&val, sizeof(val));
> +    if (ret != MEMTX_OK) {
> +        error_setg(errp, "Failed to read data from 0x%x", addr);
> +        return OTPMEM_ERR_MAGIC;
> +    }
> +    return val;
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
> +    /* If any bit can be programmed, accept the request */
> +    has_programmable_bits = value ^ (~prog_bit);
> +
> +    if (programmed_bits) {
> +        trace_aspeed_otpmem_prog_conflict(otp_addr, programmed_bits);
> +        for (int i = 0; i < 32; ++i) {
> +            if (programmed_bits & (1U << i)) {
> +                trace_aspeed_otpmem_prog_bit(i);
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
> +    MemTxResult ret;
> +
> +    ret = address_space_read(&s->as, otp_offset, MEMTXATTRS_UNSPECIFIED,
> +                             value, sizeof(uint32_t));
> +    if (ret != MEMTX_OK) {
> +        qemu_log_mask(LOG_GUEST_ERROR,
> +                      "Failed to read data 0x%x\n",
> +                      otp_offset);
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
> +static void aspeed_otpmem_prog(AspeedOtpmemState *s, uint32_t otp_addr,
> +                               uint32_t val, Error **errp)
> +{
> +    uint32_t otp_offset, value;
> +    MemTxResult ret;
> +
> +    if (!program_otpmem_data(s, otp_addr, val, &value)) {
> +        error_setg(errp, "Failed to program data");
> +        return;
> +    }
> +
> +    otp_offset = otp_addr << 2;
> +    ret = address_space_write(&s->as, otp_offset, MEMTXATTRS_UNSPECIFIED,
> +                              (uint8_t *)&value, sizeof(value));
> +    if (ret != MEMTX_OK) {
> +        error_setg(errp, "Failed to write %x to OTP [%x]", val, otp_addr);
> +        return;
> +    }
> +    trace_aspeed_otpmem_prog(otp_offset, value, val);
> +    aspeed_otpmem_sync_region(s, otp_offset, sizeof(value));
> +}
> +
> +static void aspeed_otpmem_set_default(AspeedOtpmemState *s, uint32_t otp_offset,
> +                                      uint32_t val, Error **errp)
> +{
> +    MemTxResult ret;
> +
> +    ret = address_space_write(&s->as, otp_offset, MEMTXATTRS_UNSPECIFIED,
> +                              (uint8_t *)&val, sizeof(val));
> +    if (ret != MEMTX_OK) {
> +        error_setg(errp, "Failed to set value %x to OTP [%x]", val, otp_offset);
> +        return;
> +    }
> +    aspeed_otpmem_sync_region(s, otp_offset, sizeof(val));
> +}
> +
> +static const AspeedOTPMemOps aspeed_otpmem_default_ops = {
> +    .read = aspeed_otpmem_read,
> +    .prog = aspeed_otpmem_prog,
> +    .set_default = aspeed_otpmem_set_default,
> +};> +
> +const AspeedOTPMemOps *aspeed_otpmem_get_ops(AspeedOTPMemState *s)
> +{
> +    return s->ops;
> +}
> +
> +static void aspeed_otpmem_realize(DeviceState *dev, Error **errp)
> +{
> +    AspeedOTPMemState *s = ASPEED_OTPMEM(dev);
> +    struct stat st;
> +
> +    s->size = OTPMEM_SIZE;
> +    s->ops = &aspeed_otpmem_default_ops;
> +
> +    if (s->otpmem_img_path && strlen(s->otpmem_img_path)) {
> +        if (stat(s->otpmem_img_path, &st) < 0) {
> +            error_setg(errp, "Failed to open %s",
> +                       s->otpmem_img_path);
> +            return;
> +        }
> +        if (st.st_size != OTPMEM_SIZE) {
> +            error_setg(errp, "Invalid OTP size %ld",
> +                       st.st_size);
> +            return;
> +        }
> +        memory_region_init_ram_from_file(&s->iomem, OBJECT(dev),
> +                "aspeed.otpmem.backend", s->size, s->size,
> +                RAM_SHARED, s->otpmem_img_path, 0, errp);
> +        address_space_init(&s->as, &s->iomem, NULL);
> +    }
> +}
> +
> +static void aspeed_otpmem_class_init(ObjectClass *klass, const void *data)
> +{
> +    DeviceClass *dc = DEVICE_CLASS(klass);
> +    dc->realize = aspeed_otpmem_realize;
> +    dc->user_creatable = false;
> +}

IIRC, I thought the AspeedOTPMemState model would have a drive property ?
See pnv_pnor.c for a simple example.

static const Property aspeed_otpmem_info_properties[] = {
     DEFINE_PROP_INT64("size", AspeedOTPMemState, size, 64 * KiB),
     DEFINE_PROP_DRIVE("drive", AspeedOTPMemState, blk),
};



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
> diff --git a/hw/misc/trace-events b/hw/misc/trace-events
> index 4383808d7a..e9df349f6d 100644
> --- a/hw/misc/trace-events
> +++ b/hw/misc/trace-events
> @@ -90,6 +90,11 @@ slavio_sysctrl_mem_readl(uint32_t ret) "Read system control 0x%08x"
>   slavio_led_mem_writew(uint32_t val) "Write diagnostic LED 0x%04x"
>   slavio_led_mem_readw(uint32_t ret) "Read diagnostic LED 0x%04x"
>   
> +# aspeed_otpmem.c
> +aspeed_otpmem_prog(uint32_t addr, uint32_t prog_value, uint32_t value) "OTP Memory program: addr 0x%" PRIx32 " prog_value 0x%" PRIx32 " value 0x%" PRIx32
> +aspeed_otpmem_prog_conflict(uint32_t addr, uint32_t bits) "Conflict at addr=0x%x, bits=0x%08x"
> +aspeed_otpmem_prog_bit(int bit) "Programmed bit %d"
> +
>   # aspeed_scu.c
>   aspeed_scu_write(uint64_t offset, unsigned size, uint32_t data) "To 0x%" PRIx64 " of size %u: 0x%" PRIx32
>   aspeed_scu_read(uint64_t offset, unsigned size, uint32_t data) "To 0x%" PRIx64 " of size %u: 0x%" PRIx32
> diff --git a/include/hw/misc/aspeed_otpmem.h b/include/hw/misc/aspeed_otpmem.h
> new file mode 100644
> index 0000000000..f50f4cebf1
> --- /dev/null
> +++ b/include/hw/misc/aspeed_otpmem.h
> @@ -0,0 +1,39 @@
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
> +#include "system/memory.h"
> +
> +#define OTPMEM_SIZE 0x4000
> +#define OTPMEM_ERR_MAGIC 0x45727200
> +#define TYPE_ASPEED_OTPMEM "aspeed.otpmem"
> +OBJECT_DECLARE_SIMPLE_TYPE(AspeedOTPMemState, ASPEED_OTPMEM)
> +
> +typedef struct AspeedOTPMemOps {
> +    uint32_t (*read)(AspeedOTPMemState *s, uint32_t addr, Error **errp);
> +    void (*prog)(AspeedOTPMemState *s, uint32_t addr, uint32_t val, Error **errp);
> +    void (*set_default)(AspeedOTPMemState *s, uint32_t addr, uint32_t val, Error **errp);
> +} AspeedOTPMemOps;

I fail to understand how these ops are useful. See comments on patch 2.

> +
> +typedef struct AspeedOTPMemState {
> +    DeviceState parent_obj;
> +
> +    MemoryRegion iomem;
> +    AddressSpace as;
> +    size_t size;

may be add a property for size too.

Thanks,

C.


> +
> +    const AspeedOTPMemOps *ops;
> +    char *otpmem_img_path;
> +} AspeedOtpmemState;
> +
> +const AspeedOTPMemOps *aspeed_otpmem_get_ops(AspeedOTPMemState *s);
> +void aspeed_otpmem_set_backend(AspeedOTPMemState *s, const char *path);
> +#endif /* ASPEED_OTPMMEM_H */


