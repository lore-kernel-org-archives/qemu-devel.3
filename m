Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4C9BED1039A
	for <qemu-devel@archiver.kernel.org>; Wed, 26 Nov 2025 09:04:58 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vOBRg-0005Qu-NI; Wed, 26 Nov 2025 04:04:16 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <k.semichastnov@syntacore.com>)
 id 1vOBRe-0005KV-UZ; Wed, 26 Nov 2025 04:04:15 -0500
Received: from m.syntacore.com ([178.249.69.228])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <k.semichastnov@syntacore.com>)
 id 1vOBRa-0008FT-FL; Wed, 26 Nov 2025 04:04:12 -0500
Received: from MRN-SC-KSMG-01.corp.syntacore.com (localhost [127.0.0.1])
 by m.syntacore.com (Postfix) with ESMTP id 5795C1A0003;
 Wed, 26 Nov 2025 09:04:01 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 m.syntacore.com 5795C1A0003
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=syntacore.com; s=m;
 t=1764147841; bh=kB4n1yI0v52Phsj6kNoj3VF5+RhkooRR5y7nD3A9gdc=;
 h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type:From;
 b=FS7bNrZSDdfCoLTxEbGeuf1QlRkKRVRMuSKUgz/44K6AdP/Vk5UqEaZX5pZYdFUDe
 Y7BTSS1XrZGOBhmgQMR9Zt18MZV1d3a5QUR6/4XebCP7/HE38J+i7axidUsJ1r+9UP
 JJi/BfKvg50nWERfPKDFEmbe1kwRUWJCA/2NZiVUMBBCPhjLYUY1vek1ExA084KuQm
 UpMlcn39mqJ0PVkzcJ7xDWlHltK3uYdih6jXotA+pLNYCy1oPYxq1w7dhOqFn6qNsF
 ucs64yQtcrJqfcxJ950Q91gU9/BgfkmGcgCvH8YiFIZKYLfAuS0Mk4O0/24gPag5jc
 Ql1cmepF8jLiw==
Received: from S-SC-EXCH-01.corp.syntacore.com (exchange.syntacore.com
 [10.76.202.20])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by m.syntacore.com (Postfix) with ESMTPS;
 Wed, 26 Nov 2025 09:04:00 +0000 (UTC)
Received: from [10.30.18.170] (10.30.18.170) by
 S-SC-EXCH-01.corp.syntacore.com (10.76.202.20) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.29; Wed, 26 Nov 2025 12:03:18 +0300
Message-ID: <cfde73ab-c9aa-4cef-a1ad-5a32d2a33261@syntacore.com>
Date: Wed, 26 Nov 2025 12:03:59 +0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 06/17] hw/riscv: add e-trace message helpers
To: Daniel Henrique Barboza <dbarboza@ventanamicro.com>,
 <qemu-devel@nongnu.org>
CC: <qemu-riscv@nongnu.org>, <alistair.francis@wdc.com>,
 <liwei1518@gmail.com>, <zhiwei_liu@linux.alibaba.com>, <palmer@dabbelt.com>
References: <20251111114656.2285048-1-dbarboza@ventanamicro.com>
 <20251111114656.2285048-7-dbarboza@ventanamicro.com>
Content-Language: en-US
From: Konstantin Semichastnov <k.semichastnov@syntacore.com>
In-Reply-To: <20251111114656.2285048-7-dbarboza@ventanamicro.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.30.18.170]
X-ClientProxiedBy: S-SC-EXCH-01.corp.syntacore.com (10.76.202.20) To
 S-SC-EXCH-01.corp.syntacore.com (10.76.202.20)
X-KSMG-AntiPhishing: not scanned, disabled by settings
X-KSMG-AntiSpam-Interceptor-Info: not scanned
X-KSMG-AntiSpam-Status: not scanned, disabled by settings
X-KSMG-AntiVirus: Kaspersky Secure Mail Gateway, version 2.1.1.8310,
 bases: 2025/11/26 05:52:00 #27975606
X-KSMG-AntiVirus-Status: NotDetected, skipped
X-KSMG-LinksScanning: NotDetected
X-KSMG-Message-Action: skipped
X-KSMG-Rule-ID: 5
Received-SPF: pass client-ip=178.249.69.228;
 envelope-from=k.semichastnov@syntacore.com; helo=m.syntacore.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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



On 11/11/25 14:46, Daniel Henrique Barboza wrote:
> Before making the trace encoder writing into the RAM sink we need a way
> to encode the messages/packets. The encoding is LSB (least significant
> bit) based. The doc "Efficient Trace for RISC-V", Chapter 7, mentions:
> 
> "The remainder of this section describes the contents of the payload
> portion which should be independent of the infrastructure. In each
> table, the fields are listed in transmission order: first field in
> the table is transmitted first, and multi-bit fields are transmitted
> LSB first."
> 
> The "RISC-V Trace Control Interface Specification" docs, Chapter 7,
> states when talking about the Trace RAM Sink:
> 
> "Trace data is placed in memory in LSB order (first byte of trace
> packet/data is placed on LSB)."
> 
> This means that the LSB encoding must be used to write into the RAM Sink
> memory, which is our goal.
> 
> The design we're going for is to have all these encoder helpers, along
> with the message formats, in a separated file. The trace encoder will
> make use of these helpers to blindly write a byte array with the packet
> desired, and then write it as is in the RAM Sink.
> 
> We'll start by modeling the synchronisation packet first, adding more
> formats as we increment the Trace Encoder capabilities.
> 
> Signed-off-by: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
> ---
>   hw/riscv/meson.build         |  3 +-
>   hw/riscv/rv-trace-messages.c | 94 ++++++++++++++++++++++++++++++++++++
>   hw/riscv/rv-trace-messages.h | 25 ++++++++++
>   3 files changed, 121 insertions(+), 1 deletion(-)
>   create mode 100644 hw/riscv/rv-trace-messages.c
>   create mode 100644 hw/riscv/rv-trace-messages.h
> 
> diff --git a/hw/riscv/meson.build b/hw/riscv/meson.build
> index 2aadbe1e50..7d3576fcdf 100644
> --- a/hw/riscv/meson.build
> +++ b/hw/riscv/meson.build
> @@ -14,6 +14,7 @@ riscv_ss.add(when: 'CONFIG_RISCV_IOMMU', if_true: files(
>   	'riscv-iommu.c', 'riscv-iommu-pci.c', 'riscv-iommu-sys.c', 'riscv-iommu-hpm.c'))
>   riscv_ss.add(when: 'CONFIG_MICROBLAZE_V', if_true: files('microblaze-v-generic.c'))
>   riscv_ss.add(when: 'CONFIG_XIANGSHAN_KUNMINGHU', if_true: files('xiangshan_kmh.c'))
> -riscv_ss.add(when: 'CONFIG_RISCV_TRACE', if_true: files('trace-encoder.c', 'trace-ram-sink.c'))
> +riscv_ss.add(when: 'CONFIG_RISCV_TRACE', if_true: files('trace-encoder.c',
> +        'trace-ram-sink.c', 'rv-trace-messages.c'))
>   
>   hw_arch += {'riscv': riscv_ss}
> diff --git a/hw/riscv/rv-trace-messages.c b/hw/riscv/rv-trace-messages.c
> new file mode 100644
> index 0000000000..215135dd47
> --- /dev/null
> +++ b/hw/riscv/rv-trace-messages.c
> @@ -0,0 +1,94 @@
> +/*
> + * Helpers for RISC-V Trace Messages
> + *
> + * Copyright (C) 2025 Ventana Micro Systems Inc.
> + *
> + * SPDX-License-Identifier: GPL-2.0-or-later
> + */
> +
> +#include "qemu/osdep.h"
> +
> +#include "rv-trace-messages.h"
> +#include "qemu/bitops.h"
> +#include "qemu/log.h"
> +#include "qemu/module.h"
> +#include "qapi/error.h"
> +#include "trace.h"
> +
> +typedef struct RVTraceMessageHeader {
> +    uint8_t length:5;
> +    uint8_t flow:2;
> +    uint8_t extend:1;
> +} RVTraceMessageHeader;
> +#define HEADER_SIZE 1
I suggest to move all such size macros
to single enum to keep them all in one place:

typedef enum {
     HEADER_SIZE              = 1,
     SYNC_PAYLOAD_SIZE_64BITS = 9,
     /* and other */
} RVTraceMessagePayloadSize;

> +
> +/*
> + * Format 3 subformat 0 without 'time' and 'context' fields
> + */
> +typedef struct RVTraceSyncPayload {
> +    uint8_t format:2;
> +    uint8_t subformat:2;
> +    uint8_t branch:1;
> +    uint8_t privilege:3;
> +    uint32_t addressLow;
> +    uint32_t addressHigh;
> +} RVTraceSyncPayload;
> +#define SYNC_PAYLOAD_SIZE_64BITS 9
> +
> +static void rv_etrace_write_bits(uint8_t *bytes, uint32_t bit_pos,
> +                                 uint32_t num_bits, uint32_t val)
Let's return num_bits here, so we could increment bit offset with return 
value.

> +{
> +    uint32_t pos, byte_index, byte_pos, byte_bits = 0;
> +
> +    if (!num_bits || 32 < num_bits) {
> +        return;
> +    }
> +
> +    for (pos = 0; pos < num_bits; pos += byte_bits) {
> +        byte_index = (bit_pos + pos) >> 3;
> +        byte_pos = (bit_pos + pos) & 0x7;
> +        byte_bits = (8 - byte_pos) < (num_bits - pos) ?
> +                    (8 - byte_pos) : (num_bits - pos);
> +        bytes[byte_index] &= ~(((1U << byte_bits) - 1) << byte_pos);
> +        bytes[byte_index] |= ((val >> pos) & ((1U << byte_bits) - 1)) << byte_pos;
I suggest to break this down a bit, because it very overloaded,
and this is very unclear without comments or references to
specification.

1. Let's add a reference to chapter 7 of e-trace spec in comment.

2. Let's use arithmetic operations to compute byte_index
and byte_pos:

     byte_index = (bit_pos + pos) / 8;
     byte_pos = (bit_pos + pos) % 8;

Compiler will optimize it anyway, but it is more clear what does
division and reminder mean compared to bitwise "shift" and "and".

3. Let's use macro MIN to comute byte_bits:

     byte_bits = MIN(8 - byte_pos, num_bits - pos);

4. Let's use extract32 and deposit32 to move bits from "val" to
"bytes" instead of manually shifting bits:

     uint8_t chunk = extract32(val, pos, byte_bits);
     bytes[byte_index] = deposit32(bytes[byte_index], byte_pos, 
byte_bits, chunk);


> +    }
> +}
> +
> +static void rv_etrace_write_header(uint8_t *buf, RVTraceMessageHeader header)
> +{
> +    /* flow and extend are always zero, i.e just write length */
> +    rv_etrace_write_bits(buf, 0, 5, header.length);
Flow and extend are, indeed, always zero, but we still need to write 
them to buffer.
Also, let's keep it as generic as possible, and write all fields from 
header, and not hardcoded zeroes.

     uint8_t bit_pos = 0;

     bit_pos += rv_etrace_write_bits(buf, bit_pos, 5, header.length);
     bit_pos += rv_etrace_write_bits(buf, bit_pos, 2, header.flow);
     bit_pos += rv_etrace_write_bits(buf, bit_pos, 1, header.extend);
> +}
> +
> +size_t rv_etrace_gen_encoded_sync_msg(uint8_t *buf, uint64_t pc,
> +                                      TracePrivLevel priv_level)
> +{
> +    RVTraceSyncPayload payload = {.format = 0b11,
> +                                  .subformat = 0b00,
> +                                  .branch = 1,
> +                                  .privilege = priv_level};
Let's assign addressLow and addressHigh right away:

     RVTraceSyncPayload payload = {.format = 0b11,
                                   .subformat = 0b00,
                                   .branch = 1,
                                   .privilege = priv_level,
                                   .addressLow = extract64(pc, 0, 32),
                                   .addressHigh = extract64(pc, 32, 32)};


> +    RVTraceMessageHeader header = {.flow = 0, .extend = 0,
> +                                   .length = SYNC_PAYLOAD_SIZE_64BITS};
> +    uint8_t bit_pos;
> +
> +    payload.addressLow = extract64(pc, 0, 32);
> +    payload.addressHigh = extract64(pc, 32, 32);
> +
> +    rv_etrace_write_header(buf, header);
> +    bit_pos = 8;
> +
> +    rv_etrace_write_bits(buf, bit_pos, 2, payload.format);
> +    bit_pos += 2;
> +    rv_etrace_write_bits(buf, bit_pos, 2, payload.subformat);
> +    bit_pos += 2;
> +    rv_etrace_write_bits(buf, bit_pos, 1, payload.branch);
> +    bit_pos += 1;
> +    rv_etrace_write_bits(buf, bit_pos, 3, payload.privilege);
> +    bit_pos += 3;
> +
> +    rv_etrace_write_bits(buf, bit_pos, 32, payload.addressLow);
> +    bit_pos += 32;
> +    rv_etrace_write_bits(buf, bit_pos, 32, payload.addressHigh);
Let's return num_bits value from rv_etrace_write_bits(), so we could 
just increment bit_pos with return value:


     uint8_t bit_pos = 0;

     bit_pos += rv_etrace_write_header(buf, header);

     bit_pos += rv_etrace_write_bits(buf, bit_pos, 2, payload.format);
     bit_pos += rv_etrace_write_bits(buf, bit_pos, 2, payload.subformat);
     bit_pos += rv_etrace_write_bits(buf, bit_pos, 1, payload.branch);
     bit_pos += rv_etrace_write_bits(buf, bit_pos, 3, payload.privilege);

     bit_pos += rv_etrace_write_bits(buf, bit_pos, 32,
                                     payload.addressLow);
     bit_pos += rv_etrace_write_bits(buf, bit_pos, 32,
                                     payload.addressHigh);

> +
> +    return HEADER_SIZE + SYNC_PAYLOAD_SIZE_64BITS;
> +}
> diff --git a/hw/riscv/rv-trace-messages.h b/hw/riscv/rv-trace-messages.h
> new file mode 100644
> index 0000000000..aeafea8849
> --- /dev/null
> +++ b/hw/riscv/rv-trace-messages.h
> @@ -0,0 +1,25 @@
> +/*
> + * Helpers for RISC-V Trace Messages
> + *
> + * Copyright (C) 2025 Ventana Micro Systems Inc.
> + *
> + * SPDX-License-Identifier: GPL-2.0-or-later
> + */
> +
> +#ifndef RISCV_RV_TRACE_MESSAGES_H
> +#define RISCV_RV_TRACE_MESSAGES_H
> +
> +typedef enum {
> +    U = 0,
> +    S_HS = 1,
> +    RESERVED = 2,
> +    M = 3,
> +    D = 4,
> +    VU = 5,
> +    VS = 6,
> +} TracePrivLevel;
> +
> +size_t rv_etrace_gen_encoded_sync_msg(uint8_t *buf, uint64_t pc,
> +                                      TracePrivLevel priv_level);
> +
> +#endif

