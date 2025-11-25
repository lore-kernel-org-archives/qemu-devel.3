Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1620CD0EE1F
	for <qemu-devel@archiver.kernel.org>; Tue, 25 Nov 2025 20:09:59 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vNzKf-0001oB-Hu; Tue, 25 Nov 2025 15:08:13 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dbarboza@ventanamicro.com>)
 id 1vNzKd-0001kk-7y
 for qemu-devel@nongnu.org; Tue, 25 Nov 2025 15:08:11 -0500
Received: from mail-vk1-xa29.google.com ([2607:f8b0:4864:20::a29])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <dbarboza@ventanamicro.com>)
 id 1vNzKa-0001eA-Ij
 for qemu-devel@nongnu.org; Tue, 25 Nov 2025 15:08:10 -0500
Received: by mail-vk1-xa29.google.com with SMTP id
 71dfb90a1353d-55b104727c8so1771775e0c.0
 for <qemu-devel@nongnu.org>; Tue, 25 Nov 2025 12:08:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=ventanamicro.com; s=google; t=1764101286; x=1764706086; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=HAluFmRQzvonJYhEiip0TSivJaJk5sVlEka+7uOiEMo=;
 b=iF3ahKWO/GyNKX36KmSTg45UKjApZkAftCtAqrEibuUn5/6OVQAsqHrIE5Y+jUxOxa
 WkDoe//zkXAwYBucAsONQIQvZ0abHOHu+4x6J+uCTQPx6efIG41rryC3pUw4/h/uGTa7
 xeCGoABSgSfLD3C8zG8s6uC6Oydnh1j6kthhjtFhpXPweoXDEUpNzvt7dPnGCDvUX9yE
 dw9AZLNlt3IbZ4g0dn5CG8q2XcnOcR5OWtxGSVdU5NTWd6qa4eizZb1dloK43L2hBPjq
 xJhCi+klUpPmfoPIplI7Nmu5x+bRFq9A0wKNlFQYbRK/C/jLojLQIhTvEP1w+2sIJwIl
 dbUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1764101286; x=1764706086;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=HAluFmRQzvonJYhEiip0TSivJaJk5sVlEka+7uOiEMo=;
 b=B82Nwu+k4OE88mImhN48REDaXsP76FOxo6p5ZjTws4zkVeUBWGw16Xc7O4iXgXfWyw
 oTrwgZxTbbPZbHP6y/74N1h3mbh40tBcKiV0tjxlhROf1xlVxrsSfo9cKv0Xr9blVcIQ
 ypq3DKKv3Mb+yVQ9ZQCVSxEOpgrXY5oID5mJ1RnFL5tdUGRZRH9u91L9Q/StcQpq+udV
 bjJUH1TZoUmN9AJQu81TVy5q5UKD4ppxAR8+LE1/QqyXJctItnd7SHq72Bti4ycLiYsg
 bFcdnfyYLjBoW6hVNX9zVzr1SuaGYyHkolJKXMD8Gz9RBg2IFG3wFDpnYL+r4ghgJTen
 OsLw==
X-Forwarded-Encrypted: i=1;
 AJvYcCUqTKafJyz6jJRTsBdR3fZoXAzk7/C2ahN/CdHT4/20fia2ZD74CWrcgpFdOmSOrTXX8FcCgNEXO/GQ@nongnu.org
X-Gm-Message-State: AOJu0YzW8Hr71IeCfYph6/EgOpgw/0ic5+QrD4tXlQS828zaNvYcuz5I
 dohuAP1VdMXb/o3uROnLNrcBTeltToS8gU8ntMnNFpBAO9nep2BW2USOGYlNxgIOcG0=
X-Gm-Gg: ASbGncsya1N7AhXbDdn79KhS3VaOfoDVgMb2uMB2CdP2Z/0nn6nuCjrd9dyhr7On2Qv
 luq2Af8ebQMgs3zpIJAG6alY9sxz+tnkEsB0ETTsOXsDTrfo4LKjtZlYbY8yZfaAS9FrlWvDJf3
 //9pgKp7xQSl4+JYZUaTFupvN1ZhCW5aKHKz/JSPD8D4AjKuvmwv8mGVz5s67hrKdUJp2T43Ttf
 0WUpfmkugsyXAPJBd5UA3/H7ZWIoJtfd/7VDh1jUdO2KAVB1+6CG6Y5G/zdx+bWpPTnj2Ei2nZD
 qTrTY3ajzJ64mwXhxvfw60WlZkIPsdN8rN/H28AIHiMicQ6ejeCa5EPhUcDUOhe1evZCJlJbfiE
 TdTstFpYia9/kCfrG6jAbUfRPgo4I0kXWDWArn+onIBlyu5ilRY++ZgEGnpNUt+1Bzcx63XQmTP
 CQPhJ2Y4aMCHV0cEy3hPOYGwxWCzUL0G7/ngelCyrtXv9ajiZO5YHeG+eDt1Glf00=
X-Google-Smtp-Source: AGHT+IHNYm86kR67cJNuPfhqYTUX+GrCZ8SWsO0LSEN/V2GplgcAbQLFkxrQ0TlT7Tbk4ybUZVgxow==
X-Received: by 2002:a05:6122:2490:b0:55b:1a1b:3273 with SMTP id
 71dfb90a1353d-55cd767cfccmr1358406e0c.6.1764101285709; 
 Tue, 25 Nov 2025 12:08:05 -0800 (PST)
Received: from ?IPV6:2804:7f0:bcc3:a505:14f4:4d6:efdc:f8fd?
 ([2804:7f0:bcc3:a505:14f4:4d6:efdc:f8fd])
 by smtp.gmail.com with ESMTPSA id
 71dfb90a1353d-55b7f60308csm7496672e0c.2.2025.11.25.12.08.03
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 25 Nov 2025 12:08:05 -0800 (PST)
Message-ID: <1ef35914-ba81-4f8a-9fc8-317d556d2f6b@ventanamicro.com>
Date: Tue, 25 Nov 2025 17:08:01 -0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 02/17] hw/riscv: Trace RAM Sink initial impl
To: Konstantin Semichastnov <k.semichastnov@syntacore.com>,
 qemu-devel@nongnu.org
Cc: qemu-riscv@nongnu.org, alistair.francis@wdc.com, liwei1518@gmail.com,
 zhiwei_liu@linux.alibaba.com, palmer@dabbelt.com
References: <20251111114656.2285048-1-dbarboza@ventanamicro.com>
 <20251111114656.2285048-3-dbarboza@ventanamicro.com>
 <0dd528f1-8785-4cdb-a462-b93f81eeb837@syntacore.com>
From: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
Content-Language: en-US
In-Reply-To: <0dd528f1-8785-4cdb-a462-b93f81eeb837@syntacore.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::a29;
 envelope-from=dbarboza@ventanamicro.com; helo=mail-vk1-xa29.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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



On 11/20/25 3:03 PM, Konstantin Semichastnov wrote:
> 
> 
> On 11/11/25 14:46, Daniel Henrique Barboza wrote:
>> Following the effort to implement the basic support for Efficient Trace
>> (e-trace) in QEMU we'll add a Trace RAM Sink implementation.
>>
>> Similar to the Trace Encoder, this is inspired in both the Efficient
>> Trace for RISC-V [1] and  RISC-V Trace Control Interface Specification
>> [2] specs. It implements a minimal set of features to get started - only
>> SMEM will be supported for now.
>>
>> We'll implement the RAM sink logic in the next patches, although most of
>> the work will be done by the trace encoder.
>>
>> [1] https://github.com/riscv-non-isa/riscv-trace-spec/releases/download/v2.0-20250616/riscv-trace-spec-asciidoc.pdf
>> [2] https://github.com/riscv-non-isa/tg-nexus-trace/releases/download/1.0_Ratified/RISC-V-Trace-Control-Interface.pdf
>>
>> Signed-off-by: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
>> ---
>>   hw/riscv/meson.build      |   2 +-
>>   hw/riscv/trace-events     |   4 +
>>   hw/riscv/trace-ram-sink.c | 263 ++++++++++++++++++++++++++++++++++++++
>>   hw/riscv/trace-ram-sink.h |  83 ++++++++++++
>>   4 files changed, 351 insertions(+), 1 deletion(-)
>>   create mode 100644 hw/riscv/trace-ram-sink.c
>>   create mode 100644 hw/riscv/trace-ram-sink.h
>>
>> diff --git a/hw/riscv/meson.build b/hw/riscv/meson.build
>> index b4a9988a62..2aadbe1e50 100644
>> --- a/hw/riscv/meson.build
>> +++ b/hw/riscv/meson.build
>> @@ -14,6 +14,6 @@ riscv_ss.add(when: 'CONFIG_RISCV_IOMMU', if_true: files(
>>       'riscv-iommu.c', 'riscv-iommu-pci.c', 'riscv-iommu-sys.c', 'riscv-iommu-hpm.c'))
>>   riscv_ss.add(when: 'CONFIG_MICROBLAZE_V', if_true: files('microblaze-v-generic.c'))
>>   riscv_ss.add(when: 'CONFIG_XIANGSHAN_KUNMINGHU', if_true: files('xiangshan_kmh.c'))
>> -riscv_ss.add(when: 'CONFIG_RISCV_TRACE', if_true: files('trace-encoder.c'))
>> +riscv_ss.add(when: 'CONFIG_RISCV_TRACE', if_true: files('trace-encoder.c', 'trace-ram-sink.c'))
>>   hw_arch += {'riscv': riscv_ss}
>> diff --git a/hw/riscv/trace-events b/hw/riscv/trace-events
>> index 0cbf6ffcb6..14e333fd9e 100644
>> --- a/hw/riscv/trace-events
>> +++ b/hw/riscv/trace-events
>> @@ -28,3 +28,7 @@ riscv_iommu_hpm_evt_write(uint32_t ctr_idx, uint32_t ovf, uint64_t val) "ctr_idx
>>   # trace-encoder.c
>>   trencoder_read_error(uint64_t addr) "addr 0x%" PRIx64
>>   trencoder_write_error(uint64_t addr, uint64_t value) "addr 0x%" PRIx64 " value 0x%" PRIx64
>> +
>> +# trace-ram-sink.c
>> +tr_ramsink_read_error(uint64_t addr) "addr 0x%" PRIx64
>> +tr_ramsink_write_error(uint64_t addr, uint64_t value) "addr 0x%" PRIx64 " value 0x%" PRIx64
>> diff --git a/hw/riscv/trace-ram-sink.c b/hw/riscv/trace-ram-sink.c
>> new file mode 100644
>> index 0000000000..e00de80c04
>> --- /dev/null
>> +++ b/hw/riscv/trace-ram-sink.c
>> @@ -0,0 +1,263 @@
>> +/*
>> + * Emulation of a RISC-V Trace RAM Sink
>> + *
>> + * Copyright (C) 2025 Ventana Micro Systems Inc.
>> + *
>> + * SPDX-License-Identifier: GPL-2.0-or-later
>> + */
>> +
>> +#include "qemu/osdep.h"
>> +
>> +#include "trace-ram-sink.h"
>> +#include "hw/irq.h"
>> +#include "hw/qdev-properties.h"
>> +#include "migration/vmstate.h"
>> +#include "qemu/bitops.h"
>> +#include "qemu/log.h"
>> +#include "qemu/module.h"
>> +#include "qapi/error.h"
>> +#include "trace.h"
>> +#include "system/device_tree.h"
>> +#include "hw/sysbus.h"
>> +#include "hw/register.h"
>> +
>> +#define R_TR_RAM_CONTROL_RSVP_BITS (MAKE_64BIT_MASK(32, 32) | \
>> +                                    R_TR_RAM_CONTROL_RSVP1_MASK | \
>> +                                    R_TR_RAM_CONTROL_RSVP2_MASK | \
>> +                                    R_TR_RAM_CONTROL_RSVP3_MASK | \
>> +                                    R_TR_RAM_CONTROL_RSVP4_MASK)
>> +
>> +/* trRamEmpty is the only RO field and reset value */
>> +#define R_TR_RAM_CONTROL_RESET R_TR_RAM_CONTROL_EMPTY_MASK
>> +#define R_TR_RAM_CONTROL_RO_BITS R_TR_RAM_CONTROL_EMPTY_MASK
>> +
>> +#define R_TR_RAM_IMPL_RSVP_BITS (MAKE_64BIT_MASK(32, 32) | \
>> +                                 R_TR_RAM_IMPL_RSVP1_MASK)
>> +
>> +#define R_TR_RAM_IMPL_RO_BITS (R_TR_RAM_IMPL_VER_MAJOR_MASK | \
>> +                               R_TR_RAM_IMPL_VER_MINOR_MASK | \
>> +                               R_TR_RAM_IMPL_COMP_TYPE_MASK | \
>> +                               R_TR_RAM_IMPL_HAS_SRAM_MASK | \
>> +                               R_TR_RAM_IMPL_HAS_SMEM_MASK)
>> +
>> +#define R_TR_RAM_IMPL_RESET (BIT(0) | 0x9 << 8)
> I suggest to set here trRamHasSMEM bit to 1, because we actually do have SMEM supported
>

If you check down below:

  
>> +
>> +static RegisterAccessInfo tr_ramsink_regs_info[] = {
>> +    {   .name = "TR_RAM_CONTROL", .addr = A_TR_RAM_CONTROL,
>> +        .rsvd = R_TR_RAM_CONTROL_RSVP_BITS,
>> +        .reset = R_TR_RAM_CONTROL_RESET,
>> +        .ro = R_TR_RAM_CONTROL_RO_BITS,
>> +    },
>> +    {   .name = "TR_RAM_IMPL", .addr = A_TR_RAM_IMPL,
>> +        .rsvd = R_TR_RAM_IMPL_RSVP_BITS,
>> +        .reset = R_TR_RAM_IMPL_RESET,
>> +        .ro = R_TR_RAM_IMPL_RO_BITS,
>> +    },

^ here, the .reset callback is set to R_TR_RAM_IMPL_RESET. When the device is
reset we'll also set this bit.

>> +    {   .name = "TR_RAM_START_LOW", .addr = A_TR_RAM_START_LOW,
>> +    },
>> +    {   .name = "TR_RAM_START_HIGH", .addr = A_TR_RAM_START_HIGH,
>> +    },
>> +    {   .name = "TR_RAM_LIMIT_LOW", .addr = A_TR_RAM_LIMIT_LOW,
>> +    },
>> +    {   .name = "TR_RAM_LIMIT_HIGH", .addr = A_TR_RAM_LIMIT_HIGH,
>> +    },
>> +    {   .name = "TR_RAM_WP_LOW", .addr = A_TR_RAM_WP_LOW,
>> +    },
>> +    {   .name = "TR_RAM_WP_HIGH", .addr = A_TR_RAM_WP_HIGH,
>> +    },
>> +};
>> +
>> +static uint64_t tr_ramsink_regread(void *opaque, hwaddr addr, unsigned size)
>> +{
>> +    TraceRamSink *tram = TRACE_RAM_SINK(opaque);
>> +    RegisterInfo *r = &tram->regs_info[addr / 4];
>> +
>> +    if (!r->data) {
>> +        trace_tr_ramsink_read_error(addr);
>> +        return 0;
>> +    }
>> +
>> +    return register_read(r, ~0, NULL, false);
>> +}
>> +
>> +static void tr_ramsink_regwrite(void *opaque, hwaddr addr,
>> +                            uint64_t value, unsigned size)
>> +{
>> +    TraceRamSink *tram = TRACE_RAM_SINK(opaque);
>> +    RegisterInfo *r = &tram->regs_info[addr / 4];
>> +
>> +    if (!r->data) {
>> +        trace_tr_ramsink_write_error(addr, value);
>> +        return;
>> +    }
>> +
>> +    register_write(r, value, ~0, NULL, false);
>> +}
>> +
>> +static const MemoryRegionOps tr_ramsink_regops = {
>> +    .read = tr_ramsink_regread,
>> +    .write = tr_ramsink_regwrite,
>> +    .endianness = DEVICE_LITTLE_ENDIAN,
>> +    .valid = {
>> +        .min_access_size = 4,
>> +        .max_access_size = 4,
>> +    },
>> +};
>> +
>> +static uint64_t tr_ramsink_msgread(void *opaque, hwaddr addr, unsigned size)
>> +{
>> +    TraceRamSink *tram = TRACE_RAM_SINK(opaque);
>> +
>> +    switch (size) {
>> +    case 1:
>> +        return tram->msgs[addr];
>> +    case 2:
>> +        return (uint16_t)tram->msgs[addr];
>> +    case 4:
>> +        return (uint32_t)tram->msgs[addr];
>> +    default:
>> +        g_assert_not_reached();
>> +    }
> Here we will always return single byte, because tram->msgs has
> type (uint8_t *)

The specs I've read didn't put any restriction on read/write size ... and
to be honest I haven't checked how the device is being read by the kernel
driver.

I'll ask around to see whether the driver will always do single byte
reads/writes or whatnot. It's easy enough to support up to 4 bytes r/w at
it is, so unless we're certain that the kernel will never bother reading
more than 1 byte I'd rather keep it as is.


> 
> So, I suggest to call here little endian load helper
> to avoid manually handling size and byte order:
> 
> ldn_le_p(tram->msgs + addr, size)


We don't need to care about endianness. The memory ops (tr_ramsink_smemops)
is declared as .endianness = DEVICE_LITTLE_ENDIAN. If you check
system/memory.c, memory_region_dispatch_read():

{
...
     r = memory_region_dispatch_read1(mr, addr, pval, size, attrs);
     adjust_endianness(mr, pval, op);
     return r;
}

'adjust_endianness' will read the MemoryOps .endianness setting and do
any conversions we need. In this specific case, a little_endian device
being emulated by a little endian host won't require additional bitops.
In case this emulation is run in a big endian host, this code in
system/memory.c will handle any required byte swaps. Same thing with the
write cb.

This allow us to keep our internal data structures in native host endianess,
regardless of device endianness. The read cb can just return the bytes read,
the write cb can blindly store whatever we received in our data array.


Thanks,

Daniel



> 
>> +}
>> +
>> +static void tr_ramsink_msgwrite(void *opaque, hwaddr addr,
>> +                                uint64_t value, unsigned size)
>> +{
>> +    TraceRamSink *tram = TRACE_RAM_SINK(opaque);
>> +
>> +    switch (size) {
>> +    case 1:
>> +        tram->msgs[addr] = value;
>> +        break;
>> +    case 2:
>> +        tram->msgs[addr] = extract16(value, 0, 8);
>> +        tram->msgs[addr + 1] = extract16(value, 8, 8);
>> +        break;
>> +    case 4:
>> +        tram->msgs[addr] = extract32(value, 0, 8);
>> +        tram->msgs[addr + 1] = extract32(value, 8, 8);
>> +        tram->msgs[addr + 2] = extract32(value, 16, 8);
>> +        tram->msgs[addr + 3] = extract32(value, 24, 8);
>> +        break;
>> +    default:
>> +        g_assert_not_reached();
>> +    }
> Here also we can use little endian store helper to avoid
> handling write size and byte order:
> 
> stn_le_p(tram->msgs + addr, size, value)
> 
>> +}
>> +
>> +static const MemoryRegionOps tr_ramsink_smemops = {
>> +    .read = tr_ramsink_msgread,
>> +    .write = tr_ramsink_msgwrite,
>> +    .endianness = DEVICE_LITTLE_ENDIAN,
>> +    .valid = {
>> +        .min_access_size = 1,
>> +        .max_access_size = 4,
>> +    },
>> +};
>> +
>> +static void tr_ramsink_setup_regs(TraceRamSink *tram)
>> +{
>> +    hwaddr ramlimit = tram->smemaddr + tram->smemsize;
>> +
>> +    ARRAY_FIELD_DP32(tram->regs, TR_RAM_START_LOW, ADDR,
>> +                     extract64(tram->smemaddr, 2, 30));
>> +    ARRAY_FIELD_DP32(tram->regs, TR_RAM_START_HIGH, ADDR,
>> +                     extract64(tram->smemaddr, 32, 32));
>> +
>> +    ARRAY_FIELD_DP32(tram->regs, TR_RAM_WP_LOW, ADDR,
>> +                     extract64(tram->smemaddr, 2, 30));
>> +    ARRAY_FIELD_DP32(tram->regs, TR_RAM_WP_HIGH, ADDR,
>> +                     extract64(tram->smemaddr, 32, 32));
>> +
>> +    ARRAY_FIELD_DP32(tram->regs, TR_RAM_LIMIT_LOW, ADDR,
>> +                     extract64(ramlimit, 2, 30));
>> +    ARRAY_FIELD_DP32(tram->regs, TR_RAM_LIMIT_HIGH, ADDR,
>> +                     extract64(ramlimit, 32, 32));
>> +}
>> +
>> +static void tr_ramsink_reset(DeviceState *dev)
>> +{
>> +    TraceRamSink *tram = TRACE_RAM_SINK(dev);
>> +
>> +    for (int i = 0; i < ARRAY_SIZE(tram->regs_info); i++) {
>> +        register_reset(&tram->regs_info[i]);
>> +    }
>> +
>> +    tr_ramsink_setup_regs(tram);
>> +}
>> +
>> +static void tr_ramsink_realize(DeviceState *dev, Error **errp)
>> +{
>> +    TraceRamSink *tram = TRACE_RAM_SINK(dev);
>> +
>> +    memory_region_init_io(&tram->reg_mem, OBJECT(dev),
>> +                          &tr_ramsink_regops, tram,
>> +                          "trace-ram-sink-regs",
>> +                          tram->reg_mem_size);
>> +    sysbus_init_mmio(SYS_BUS_DEVICE(tram), &tram->reg_mem);
>> +    sysbus_mmio_map(SYS_BUS_DEVICE(tram), 0, tram->baseaddr);
>> +
>> +    g_assert(tram->smemsize > 0);
>> +    tram->msgs = g_malloc0(tram->smemsize);
>> +
>> +    memory_region_init_io(&tram->smem, OBJECT(dev),
>> +                          &tr_ramsink_smemops, tram,
>> +                          "trace-ram-sink-smem",
>> +                          tram->smemsize);
>> +    sysbus_init_mmio(SYS_BUS_DEVICE(dev), &tram->smem);
>> +    sysbus_mmio_map(SYS_BUS_DEVICE(dev), 1, tram->smemaddr);
>> +
>> +    /* RegisterInfo init taken from hw/dma/xlnx-zdma.c */
>> +    for (int i = 0; i < ARRAY_SIZE(tr_ramsink_regs_info); i++) {
>> +        uint32_t reg_idx = tr_ramsink_regs_info[i].addr / 4;
>> +        RegisterInfo *r = &tram->regs_info[reg_idx];
>> +
>> +        *r = (RegisterInfo) {
>> +            .data = (uint8_t *)&tram->regs[reg_idx],
>> +            .data_size = sizeof(uint32_t),
>> +            .access = &tr_ramsink_regs_info[i],
>> +            .opaque = tram,
>> +        };
>> +    }
>> +}
>> +
>> +static const Property tr_ramsink_props[] = {
>> +    DEFINE_PROP_UINT64("baseaddr", TraceRamSink, baseaddr, 0),
>> +    DEFINE_PROP_UINT64("smemaddr", TraceRamSink, smemaddr, 0),
>> +    DEFINE_PROP_UINT32("smemsize", TraceRamSink, smemsize, 0),
>> +    DEFINE_PROP_UINT32("reg-mem-size", TraceRamSink,
>> +                       reg_mem_size, TR_DEV_REGMAP_SIZE),
>> +};
>> +
>> +static const VMStateDescription vmstate_tr_ramsink = {
>> +    .name = TYPE_TRACE_RAM_SINK,
>> +    .version_id = 1,
>> +    .minimum_version_id = 1,
>> +    .fields = (const VMStateField[]) {
>> +        VMSTATE_UINT32_ARRAY(regs, TraceRamSink, TRACE_R_MAX),
>> +        VMSTATE_END_OF_LIST(),
>> +    }
>> +};
>> +
>> +static void tr_ramsink_class_init(ObjectClass *klass, const void *data)
>> +{
>> +    DeviceClass *dc = DEVICE_CLASS(klass);
>> +
>> +    device_class_set_legacy_reset(dc, tr_ramsink_reset);
>> +    device_class_set_props(dc, tr_ramsink_props);
>> +    dc->realize = tr_ramsink_realize;
>> +    dc->vmsd = &vmstate_tr_ramsink;
>> +}
>> +
>> +static const TypeInfo tr_ramsink_info = {
>> +    .name          = TYPE_TRACE_RAM_SINK,
>> +    .parent        = TYPE_SYS_BUS_DEVICE,
>> +    .instance_size = sizeof(TraceRamSink),
>> +    .class_init    = tr_ramsink_class_init,
>> +};
>> +
>> +static void tr_ramsink_register_types(void)
>> +{
>> +    type_register_static(&tr_ramsink_info);
>> +}
>> +
>> +type_init(tr_ramsink_register_types)
>> diff --git a/hw/riscv/trace-ram-sink.h b/hw/riscv/trace-ram-sink.h
>> new file mode 100644
>> index 0000000000..cd55145669
>> --- /dev/null
>> +++ b/hw/riscv/trace-ram-sink.h
>> @@ -0,0 +1,83 @@
>> +/*
>> + * Emulation of a RISC-V Trace RAM Sink
>> + *
>> + * Copyright (C) 2025 Ventana Micro Systems Inc.
>> + *
>> + * SPDX-License-Identifier: GPL-2.0-or-later
>> + */
>> +
>> +#ifndef RISCV_TRACE_RAM_SINK_H
>> +#define RISCV_TRACE_RAM_SINK_H
>> +
>> +#include "hw/register.h"
>> +#include "hw/sysbus.h"
>> +#include "system/dma.h"
>> +#include "qom/object.h"
>> +
>> +#define TRACE_R_MAX (0xFFF / 4)
>> +#define TR_DEV_REGMAP_SIZE 0x1000
>> +
>> +/*
>> + * The Trace Encoder will read/write those regs so put their
>> + * declaration in this header.
>> + */
>> +REG32(TR_RAM_CONTROL, 0x0)
>> +    FIELD(TR_RAM_CONTROL, ACTIVE, 0, 1)
>> +    FIELD(TR_RAM_CONTROL, ENABLE, 1, 1)
>> +    FIELD(TR_RAM_CONTROL, EMPTY, 3, 1)
>> +    FIELD(TR_RAM_CONTROL, MODE, 4, 1)
>> +    FIELD(TR_RAM_CONTROL, STOP_ON_WRAP, 8, 1)
>> +    FIELD(TR_RAM_CONTROL, MEM_FORMAT, 9, 2)
>> +    /* reserved bits */
>> +    FIELD(TR_RAM_CONTROL, RSVP1, 2, 1)
>> +    FIELD(TR_RAM_CONTROL, RSVP2, 5, 2)
> RSVP2 should be 3 bits long, as it occupies bits [7:5]
> 
>> +    FIELD(TR_RAM_CONTROL, RSVP3, 11, 1)
>> +    FIELD(TR_RAM_CONTROL, RSVP4, 15, 16)
> Here is the same typo: RSVP4 should be 17 bits long, as it occupies
> bits [31:15]
> 
>> +
>> +REG32(TR_RAM_IMPL, 0x4)
>> +    FIELD(TR_RAM_IMPL, VER_MAJOR, 0, 4)
>> +    FIELD(TR_RAM_IMPL, VER_MINOR, 4, 4)
>> +    FIELD(TR_RAM_IMPL, COMP_TYPE, 8, 4)
>> +    FIELD(TR_RAM_IMPL, HAS_SRAM, 12, 1)
>> +    FIELD(TR_RAM_IMPL, HAS_SMEM, 13, 1)
>> +    /* reserved bits */
>> +    FIELD(TR_RAM_IMPL, RSVP1, 14, 18)
>> +
>> +REG32(TR_RAM_START_LOW, 0x010)
>> +    FIELD(TR_RAM_START_LOW, ADDR, 2, 30)
>> +REG32(TR_RAM_START_HIGH, 0x014)
>> +    FIELD(TR_RAM_START_HIGH, ADDR, 0, 32)
>> +
>> +REG32(TR_RAM_LIMIT_LOW, 0x018)
>> +    FIELD(TR_RAM_LIMIT_LOW, ADDR, 2, 30)
>> +REG32(TR_RAM_LIMIT_HIGH, 0x01C)
>> +    FIELD(TR_RAM_LIMIT_HIGH, ADDR, 0, 32)
>> +
>> +REG32(TR_RAM_WP_LOW, 0x020)
>> +    FIELD(TR_RAM_WP_LOW, WRAP, 0, 1)
>> +    FIELD(TR_RAM_WP_LOW, ADDR, 2, 30)
>> +REG32(TR_RAM_WP_HIGH, 0x024)
>> +    FIELD(TR_RAM_WP_HIGH, ADDR, 0, 32)
>> +
>> +struct TraceRamSink {
>> +    /*< private >*/
>> +    SysBusDevice parent_obj;
>> +
>> +    MemoryRegion reg_mem;
>> +    uint32_t reg_mem_size;
>> +
>> +    hwaddr baseaddr;
>> +    uint32_t regs[TRACE_R_MAX];
>> +    RegisterInfo regs_info[TRACE_R_MAX];
>> +
>> +    hwaddr smemaddr;
>> +    MemoryRegion smem;
>> +    uint32_t smemsize;
>> +    uint8_t *msgs;
>> +};
>> +
>> +#define TYPE_TRACE_RAM_SINK "trace-ram-sink"
>> +
>> +OBJECT_DECLARE_SIMPLE_TYPE(TraceRamSink, TRACE_RAM_SINK)
>> +
>> +#endif
> 


