Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EA7BBC61DD3
	for <qemu-devel@archiver.kernel.org>; Mon, 31 Aug 2026 06:52:59 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x0vsM-0007hr-M6; Mon, 31 Aug 2026 02:52:14 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@kaod.org>)
 id 1x0vsI-0007h5-7V; Mon, 31 Aug 2026 02:52:10 -0400
Received: from smtpout1.mo528.mail-out.ovh.net ([46.105.34.251])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@kaod.org>)
 id 1x0vsE-0007gu-KB; Mon, 31 Aug 2026 02:52:09 -0400
Received: from director6.derp.mail-out.ovh.net
 (director6.derp.mail-out.ovh.net [79.137.60.226])
 by mo528.mail-out.ovh.net (Postfix) with ESMTPS id 4hYKRH0VQtz66V1;
 Mon, 31 Aug 2026 06:51:54 +0000 (UTC)
Received: from director6.derp.mail-out.ovh.net
 (director6.derp.mail-out.ovh.net. [127.0.0.1])
 by director6.derp.mail-out.ovh.net (inspect_sender_mail_agent) with SMTP
 for <jamin_lin@aspeedtech.com>; Mon, 31 Aug 2026 06:51:54 +0000 (UTC)
Received: from mta11.priv.ovhmail-u2.ea.mail.ovh.net (unknown [10.109.249.239])
 by director6.derp.mail-out.ovh.net (Postfix) with ESMTPS id 4hYKRG2sjyz47ld;
 Mon, 31 Aug 2026 06:51:54 +0000 (UTC)
Received: from kaod.org (unknown [10.1.6.6])
 (Authenticated sender: clg@kaod.org)
 by mta11.priv.ovhmail-u2.ea.mail.ovh.net (Postfix) with ESMTPSA id
 BBEA72403FCF; Mon, 31 Aug 2026 06:51:52 +0000 (UTC)
Authentication-Results: garm.ovh; auth=pass
 (GARM-114S00819dd8b88-7edb-482f-9412-e1de060ca198,
 20713A92955D5A277E4AF24F7FE8A47CC1774BFC) smtp.auth=clg@kaod.org
X-OVh-ClientIp: 82.64.250.170
Message-ID: <a15d9b2b-76c3-4fb0-920f-778687268cdf@kaod.org>
Date: Mon, 31 Aug 2026 08:51:52 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 1/4] hw/misc/aspeed_acry: Add ASPEED ACRY model
To: Jamin Lin <jamin_lin@aspeedtech.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 Steven Lee <steven_lee@aspeedtech.com>, Troy Lee <leetroy@gmail.com>,
 Kane Chen <kane_chen@aspeedtech.com>,
 Andrew Jeffery <andrew@codeconstruct.com.au>, Joel Stanley <joel@jms.id.au>,
 Fabiano Rosas <farosas@suse.de>, Laurent Vivier <lvivier@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 "open list:ASPEED BMCs" <qemu-arm@nongnu.org>,
 "open list:All patches CC here" <qemu-devel@nongnu.org>
Cc: Troy Lee <troy_lee@aspeedtech.com>
References: <20260831024450.27178-1-jamin_lin@aspeedtech.com>
 <20260831024450.27178-2-jamin_lin@aspeedtech.com>
From: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@kaod.org>
Content-Language: en-US, fr
Autocrypt: addr=clg@kaod.org; keydata=
 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
In-Reply-To: <20260831024450.27178-2-jamin_lin@aspeedtech.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
x-ovh-tracer-id: 2632916935548578861
X-VR-SPAMSTATE: OK
X-VR-SPAMSCORE: -100
X-VR-SPAMCAUSE: dmFkZTGyFTWb/Y4P0S7WCJB+4tPd0r/nFt6cwiDJZWXHMfdOuuFHBsbnOb+tMJQViJ6grUq2TcmtHvfH1boQX3RZK9W5n0w+dvOGVOyMzXbDnEzE/8tSNcvwlJjIEQ5KG3SyNm9fkAVEBUzRvwgZTXl2lq6cr/uxkkgr8XLwcgmyRe00k7FpWDM/fGowJWf4BRbOFs0EtgrSUhV8NZYVLEHq+Y+QElZ303OJPWwoxC9sF9ujMtfQNZC0TZjwnQ3NxlS4NYN9fop0piKR1KBDPPH1gLXO27/iPMILzvjOMvUvvzhy9Fg2xMvXUVp4i4dobUmTbaCaYnNltgDK40c2OwtgG3KAL5U9q0UQKjdSm+kRgals7YPGr1OYVBJEbhPCiDH5NR1b8abVUwFHiDamf2PdfCXBuYaiIa0lpqaqkGDUpHLVnEq/sycHxQqWCuuooSfH7iuMb8cmhVHSILXuP9ExFh9xGM94RHQ3jSmiX1CD2RtxAHv3cpGrSZs91nLhAALRfHQRg1pD5aQnhcO1rQ3YsTKAiiZt/8gye0byZ435gbwWPHHNTTybGhwoHEzhHLrFXZwUfa3JK/3hmwBQloDHx/D7Y5BNLRDvkcShyhzN9Lwt43mYVquGlGba/lVCaTKNg8X40yI7UeIus0HNrcN8jY5cAihBJ2/E6r6wUBJEC8v2Qg
DKIM-Signature: a=rsa-sha256; bh=SnQ5WRJbwPPT2bGsQCx5trQH1A3ysqU+/4Lr3VeVkYA=; 
 c=relaxed/relaxed; d=kaod.org; h=From; s=ovhmo393970-selector1;
 t=1788159116; v=1;
 b=cyMmWT2wGMq4E2T8121aXlLE/memPwt3jCU6A5Hxiwi506bcaG5jH4nFa6VUzj0u94W+I95k
 rwbTh/Gpx78FFrccoZk0z8IaHqZD9zHkAHVaRtx9udMFM8fPgR0HwjEIRWPgz++sa08pdGXItTV
 C+SDbw9LMvcT20M6RxBWuQidkIPPd4Eq9T3FD1qSo2/U5eRxrhxJ0FnTthSdyKbhFuccAG5LV+O
 9QaUNEKFxrEATQHmTzuD8dPkO7NLi6Y8QuP93ISJxtFNT1n7LXSiMUmA0PEc4a2cjjeEvroSuTZ
 r6IbXR2KlxXQDU7V4uJM956ZMX7zXNfyPs/VnNUzhWO4A==
Received-SPF: pass client-ip=46.105.34.251; envelope-from=clg@kaod.org;
 helo=smtpout1.mo528.mail-out.ovh.net
X-Spam_score_int: -30
X-Spam_score: -3.1
X-Spam_bar: ---
X-Spam_report: (-3.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=-1, RCVD_IN_MSPIKE_WL=-0.01,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On 8/31/26 04:44, Jamin Lin wrote:
> Introduce a ASPEED ACRY model, which performs RSA modular
> exponentiation. The datasheet documents the engine as
> supporting both RSA and ECDSA, but ECDSA is broken on this
> hardware, so only RSA is modelled.
> 
> The engine DMAs its operands (data, exponent, modulus) from a guest
> DRAM buffer and writes the result back into a memory-mapped SRAM
> region. Both regions share the same interleaved byte/dword layout:
> repeating 12-dword blocks of [4 dwords exponent][4 dwords modulus][4
> dwords data], index 0 holding the least-significant word/byte of each
> value.
> 
> The engine accesses DRAM by relative offset, so the CPU-visible
> address written to the DMA source register has its top (base) bit
> masked off.
> 
> The modular exponentiation itself is delegated to QEMU's generic
> akcipher crypto API (crypto/akcipher.c) using raw (unpadded) RSA,
> matching what the real hardware performs - PKCS1 padding is handled
> by the guest's software crypto stack, not by this engine.
> 
> The RSA public-key operand DER encoding needed by that API is built with
> crypto/der.h's generic encoder. Raw (unpadded) RSA is only implemented
> by that API's libgcrypt backend (its nettle backend rejects raw
> padding).
> 
> When that support is missing, the engine still completes and raises its
> completion IRQ as real hardware would, but produces an all-zero result
> so that whatever signature check the guest performs on it fails cleanly
> instead of the guest hanging forever waiting for an interrupt that
> would otherwise never come.
> 
> Signed-off-by: Jamin Lin <jamin_lin@aspeedtech.com>
> ---
>   include/hw/misc/aspeed_acry.h |  39 +++
>   hw/misc/aspeed_acry.c         | 456 ++++++++++++++++++++++++++++++++++
>   hw/misc/meson.build           |   1 +
>   hw/misc/trace-events          |   6 +
>   4 files changed, 502 insertions(+)
>   create mode 100644 include/hw/misc/aspeed_acry.h
>   create mode 100644 hw/misc/aspeed_acry.c
> 
> diff --git a/include/hw/misc/aspeed_acry.h b/include/hw/misc/aspeed_acry.h
> new file mode 100644
> index 0000000000..5ca80deec4
> --- /dev/null
> +++ b/include/hw/misc/aspeed_acry.h
> @@ -0,0 +1,39 @@
> +/*
> + * ASPEED ACRY Engine
> + *
> + * Copyright (C) 2026 ASPEED Technology Inc.
> + *
> + * SPDX-License-Identifier: GPL-2.0-or-later
> + */
> +
> +#ifndef ASPEED_ACRY_H
> +#define ASPEED_ACRY_H
> +
> +#include "hw/core/sysbus.h"
> +#include "system/memory.h"
> +
> +#define TYPE_ASPEED_ACRY "aspeed.acry"
> +OBJECT_DECLARE_SIMPLE_TYPE(AspeedACRYState, ASPEED_ACRY)
> +
> +#define ASPEED_ACRY_NR_REGS     (0x400 >> 2)
> +/* Max size of the "data" (message) field within the SRAM buffer. */
> +#define ASPEED_ACRY_DATA_MAX_LEN 0x800
> +#define ASPEED_ACRY_MAX_BITS     4096
> +/* Max exponent/modulus size for a 4096-bit RSA key, in bytes. */
> +#define ASPEED_ACRY_MAX_BYTES    (ASPEED_ACRY_MAX_BITS / 8)
> +
> +struct AspeedACRYState {
> +    SysBusDevice parent_obj;
> +
> +    MemoryRegion iomem;
> +    qemu_irq irq;
> +
> +    uint32_t regs[ASPEED_ACRY_NR_REGS];
> +
> +    MemoryRegion *dram_mr;
> +    MemoryRegion *sram_mr;
> +    AddressSpace dram_as;
> +    AddressSpace sram_as;
> +};
> +
> +#endif /* ASPEED_ACRY_H */
> diff --git a/hw/misc/aspeed_acry.c b/hw/misc/aspeed_acry.c
> new file mode 100644
> index 0000000000..b9fd9f11fd
> --- /dev/null
> +++ b/hw/misc/aspeed_acry.c
> @@ -0,0 +1,456 @@
> +/*
> + * ASPEED ACRY Engine
> + *
> + * Copyright (C) 2026 ASPEED Technology Inc.
> + *
> + * SPDX-License-Identifier: GPL-2.0-or-later
> + *
> + * The datasheet documents the ACRY engine as supporting both RSA and
> + * ECDSA, but ECDSA is broken on this hardware, so only RSA is modelled
> + * here.
> + */
> +
> +#include "qemu/osdep.h"
> +#include "qemu/cutils.h"
> +#include "qemu/log.h"
> +#include "hw/misc/aspeed_acry.h"
> +#include "hw/core/qdev-properties.h"
> +#include "hw/core/irq.h"
> +#include "hw/core/registerfields.h"
> +#include "qapi/error.h"
> +#include "crypto/akcipher.h"
> +#include "crypto/der.h"
> +#include "trace.h"
> +
> +REG32(ACRY_TRIGGER, 0x000)
> +    FIELD(ACRY_TRIGGER, RSA_DMA_DATA, 1, 1)
> +    FIELD(ACRY_TRIGGER, RSA_START, 0, 1)
> +REG32(ACRY_DMA_CMD, 0x048)
> +REG32(ACRY_DMA_SRC, 0x04C)
> +REG32(ACRY_DMA_LEN, 0x050)
> +    FIELD(ACRY_DMA_LEN, DEST, 16, 16)
> +    FIELD(ACRY_DMA_LEN, DATALEN, 0, 16)
> +REG32(ACRY_RSA_KEY_LEN, 0x058)

ACRY_RSA_KEY_LEN is never used.

> +REG32(ACRY_INT_MASK, 0x3F8)
> +    FIELD(ACRY_INT_MASK, RSA_DMA_MASK, 2, 1)
> +    FIELD(ACRY_INT_MASK, RSA_ENG_MASK, 1, 1)
> +REG32(ACRY_STATUS, 0x3FC)
> +    FIELD(ACRY_STATUS, RSA_DMA_DONE, 2, 1)
> +    FIELD(ACRY_STATUS, RSA_ENG_DONE, 1, 1)
> +
> +/*
> + * Total size of the interleaved buffer. Data is 4 of every 12
> + * dwords of a block, one third of the buffer, so the whole buffer is 3x
> + * the data region.
> + */
> +#define ASPEED_ACRY_SRAM_SIZE   (3 * ASPEED_ACRY_DATA_MAX_LEN)
> +
> +/* Dwords into each 12-dword block where each operand's region starts. */
> +#define ASPEED_ACRY_EXP_OFFSET   0
> +#define ASPEED_ACRY_MOD_OFFSET   4
> +#define ASPEED_ACRY_DATA_OFFSET  8
> +
> +static void aspeed_acry_hexdump(const char *desc, const uint8_t *buf,
> +                                size_t size)
> +{
> +    g_autoptr(GString) str = g_string_sized_new(64);
> +    size_t len;
> +    size_t i;
> +
> +    for (i = 0; i < size; i += len) {
> +        len = MIN(16, size - i);
> +        g_string_truncate(str, 0);
> +        qemu_hexdump_line(str, buf + i, len, 1, 4);
> +        trace_aspeed_acry_hexdump(desc, i, str->str);
> +    }
> +}
> +
> +/*
> + * The interleaved buffer is a series of 12-dword blocks, each split into
> + * three 4-dword regions - exp, mod, data:
> + *
> + *   dword in block:  0    1    2    3    4    5    6    7    8    9   10   11
> + *   region:          \---- exp ----/    \---- mod ----/    \---- data ----/
> + *   lane:            0    1    2    3    0    1    2    3    0    1    2    3
> + *
> + * Successive blocks hold the next 4 dwords of each operand, so operand
> + * dword d is in block (d / 4), lane (d % 4). Dwords are little-endian, so
> + * byte b of dword D is at byte D * 4 + b.
> + *
> + * Return the buffer offset of byte 'op_byte' (op_byte = 0 = least
> + * significant) of the operand whose region starts 'region' dwords into
> + * each block (0 = exp, 4 = mod, 8 = data).
> + */
> +static int aspeed_acry_operand_offset(int region, int op_byte)
> +{
> +    int byte_in_dword;
> +    int op_dword;
> +    int block;
> +    int lane;
> +
> +    op_dword = op_byte / 4;
> +    byte_in_dword = op_byte % 4;
> +    block = op_dword / 4;
> +    lane = op_dword % 4;
> +
> +    return (block * 12 + region + lane) * 4 + byte_in_dword;

aspeed_acry_operand_offset() return value indexes without bounds checking.
It seems fragile. Could you please add compile-time constants ?

   

> +}
> +
> +/*
> + * Read one operand out of the buffer as a big-endian magnitude.
> + *
> + * The operand's bytes are scattered through buf; byte k (significance level
> + * k, k = 0 = least significant) is at aspeed_acry_operand_offset(region, k).
> + * Walk from the top down, drop leading zero bytes, and write the result most
> + * significant byte first into out[]. Returns the number of bytes written
> + * (the value 0 yields a single 0x00 byte, so always >= 1).
> + */
> +static int aspeed_acry_extract_be(const uint8_t *buf, int region,
> +                                  int max_bytes, uint8_t *out)
> +{
> +    int offset;
> +    int msb;
> +    int len;
> +    int k;
> +
> +    /* Highest significance level holding a non-zero byte (skip leading 0s). */
> +    for (msb = max_bytes - 1; msb >= 0; msb--) {
> +        offset = aspeed_acry_operand_offset(region, msb);
> +        if (buf[offset] != 0) {
> +            break;
> +        }
> +    }
> +
> +    /* All bytes zero: the value is 0. */
> +    if (msb < 0) {
> +        out[0] = 0;
> +        return 1;
> +    }
> +
> +    /* Copy most significant byte first: level msb down to level 0. */
> +    len = 0;
> +    for (k = msb; k >= 0; k--) {
> +        offset = aspeed_acry_operand_offset(region, k);
> +        out[len++] = buf[offset];
> +    }
> +
> +    return len;
> +}
> +
> +/*
> + * Return a DER INTEGER body for the unsigned big-endian magnitude 'be'.
> + *
> + * DER INTEGERs are signed, so if the top byte has bit 7 set the value
> + * would decode as negative; prepend a 0x00 guard byte in that case.
> + *
> + * The padded copy is written into 'pad_buf' (caller-owned, sized len + 1)
> + * rather than a local, because qcrypto_der_encode_int() only stores the
> + * pointer we hand it - the bytes are not copied until
> + * qcrypto_der_encode_ctx_flush_and_free() - so the body must stay valid
> + * until then. Returns a pointer into 'be' or 'pad_buf' as appropriate,
> + * with the body length in *body_len.
> + */
> +static const uint8_t *aspeed_acry_der_uint_body(const uint8_t *be, size_t len,
> +                                                uint8_t *pad_buf,
> +                                                size_t *body_len)
> +{
> +    if (be[0] & 0x80) {
> +        pad_buf[0] = 0x00;
> +        memcpy(pad_buf + 1, be, len);
> +        *body_len = len + 1;
> +        return pad_buf;
> +    }
> +
> +    *body_len = len;
> +    return be;
> +}
> +
> +/*
> + * DER-encode a "RsaPubKey ::= SEQUENCE { n INTEGER, e INTEGER }" (see
> + * crypto/rsakey.h), the format expected by qcrypto_akcipher_new(). n and e
> + * are minimal big-endian magnitudes (as produced by
> + * aspeed_acry_extract_be()); the engine does a raw modexp, so the guest's
> + * exponent is always encoded here as the public 'e'.
> + */
> +static uint8_t *aspeed_acry_der_encode_pubkey(const uint8_t *n, size_t n_len,
> +                                              const uint8_t *e, size_t e_len,
> +                                              size_t *out_len)
> +{
> +    QCryptoEncodeContext *ctx = qcrypto_der_encode_ctx_new();
> +    uint8_t n_pad[ASPEED_ACRY_MAX_BYTES + 1];
> +    uint8_t e_pad[ASPEED_ACRY_MAX_BYTES + 1];
> +    const uint8_t *n_body;
> +    const uint8_t *e_body;
> +    size_t n_body_len;
> +    size_t e_body_len;
> +    uint8_t *buf;
> +
> +    n_body = aspeed_acry_der_uint_body(n, n_len, n_pad, &n_body_len);
> +    e_body = aspeed_acry_der_uint_body(e, e_len, e_pad, &e_body_len);
> +
> +    qcrypto_der_encode_seq_begin(ctx);
> +    qcrypto_der_encode_int(ctx, n_body, n_body_len);
> +    qcrypto_der_encode_int(ctx, e_body, e_body_len);
> +    qcrypto_der_encode_seq_end(ctx);
> +
> +    *out_len = qcrypto_der_encode_ctx_buffer_len(ctx);
> +    buf = g_malloc(*out_len);
> +    qcrypto_der_encode_ctx_flush_and_free(ctx, buf);
> +
> +    return buf;
> +}
> +
> +/*
> + * Store the RSA result into the output SRAM data region as 'n_len' bytes
> + * (the key size): the low 'result_len' bytes are result_be (big-endian),
> + * the rest is zero. sram_as is a 0-based AddressSpace over the SRAM, so the
> + * offset from aspeed_acry_operand_offset() is used directly; each data dword
> + * is written as a little-endian word.
> + */
> +static void aspeed_acry_store_result(AspeedACRYState *s,
> +                                     const uint8_t *result_be,
> +                                     int result_len, int n_len)
> +{
> +    uint32_t result_word;
> +    MemTxResult res;
> +    int offset;
> +    int src;
> +    int i;
> +    int j;
> +
> +    /* result_be is MSB-first; take bytes from its LSB end. */
> +    src = result_len - 1;
> +    for (i = 0; i < n_len / 4; i++) {
> +        /* Pack up to 4 result bytes (LSB first) into a little-endian dword. */
> +        result_word = 0;
> +        for (j = 0; j < 4; j++) {
> +            if (src >= 0) {
> +                result_word |= (uint32_t)result_be[src--] << (8 * j);
> +            }
> +        }
> +
> +        offset = aspeed_acry_operand_offset(ASPEED_ACRY_DATA_OFFSET, 4 * i);
> +        address_space_stl_le(&s->sram_as, offset, result_word,
> +                             MEMTXATTRS_UNSPECIFIED, &res);
> +        if (res != MEMTX_OK) {
> +            qemu_log_mask(LOG_GUEST_ERROR,
> +                          "%s: failed to write result\n", __func__);
> +            return;
> +        }
> +    }
> +}
> +
> +static void aspeed_acry_do_rsa(AspeedACRYState *s)

It seems that error paths return early without zeroing SRAM and the caller
still sets completion + IRQ, so the guest sees success with stale data.

I would return a bool and pass an Error ** parameter to aspeed_acry_do_rsa()
and adjust the caller.


> +{
> +    QCryptoAkCipherOptions opts = {
> +        .alg = QCRYPTO_AK_CIPHER_ALGO_RSA,
> +        .u.rsa = {
> +            .padding_alg = QCRYPTO_RSA_PADDING_ALGO_RAW,
> +        },
> +    };
> +    uint32_t len = FIELD_EX32(s->regs[R_ACRY_DMA_LEN], ACRY_DMA_LEN, DATALEN);
> +    uint8_t src_buf[ASPEED_ACRY_SRAM_SIZE] = { 0 };
> +    uint8_t result[ASPEED_ACRY_MAX_BYTES] = { 0 };
> +    uint64_t src_addr = s->regs[R_ACRY_DMA_SRC];
> +    uint8_t data[ASPEED_ACRY_DATA_MAX_LEN];
> +    g_autofree uint8_t *der_key = NULL;
> +    uint8_t n[ASPEED_ACRY_MAX_BYTES];
> +    uint8_t e[ASPEED_ACRY_MAX_BYTES];

The stack allocation size is ~10 KB. Please allocate the src_buf and data
buffers.

> +    QCryptoAkCipher *cipher = NULL;
> +    Error *local_err = NULL;
> +    int result_len = 0;
> +    size_t der_len;
> +    int data_len;
> +    int n_len;
> +    int e_len;
> +
> +    if (!qcrypto_akcipher_supports(&opts)) {
> +        qemu_log_mask(LOG_UNIMP,
> +                     "%s: RSA ModExp not supported by the crypto backend; "
> +                     "completing with an invalid result\n", __func__);
> +        return;
> +    }
> +
> +    if (len == 0 || len > ASPEED_ACRY_SRAM_SIZE) {
> +        qemu_log_mask(LOG_GUEST_ERROR, "%s: invalid DMA length %u\n",
> +                     __func__, len);
> +        return;
> +    }
> +
> +    trace_aspeed_acry_rsa_trigger(src_addr, len);
> +
> +    if (address_space_read(&s->dram_as, src_addr, MEMTXATTRS_UNSPECIFIED,
> +                           src_buf, len) != MEMTX_OK) {
> +        qemu_log_mask(LOG_GUEST_ERROR,
> +                     "%s: failed to read DMA buffer at 0x%" PRIx64 "\n",
> +                     __func__, src_addr);
> +        return;
> +    }
> +
> +    n_len = aspeed_acry_extract_be(src_buf, ASPEED_ACRY_MOD_OFFSET,
> +                                   ASPEED_ACRY_MAX_BYTES, n);
> +    e_len = aspeed_acry_extract_be(src_buf, ASPEED_ACRY_EXP_OFFSET,
> +                                   ASPEED_ACRY_MAX_BYTES, e);
> +    data_len = aspeed_acry_extract_be(src_buf, ASPEED_ACRY_DATA_OFFSET,
> +                                      ASPEED_ACRY_DATA_MAX_LEN, data);
> +
> +    if (trace_event_get_state_backends(TRACE_ASPEED_ACRY_HEXDUMP)) {
> +        aspeed_acry_hexdump("buf", src_buf, len);
> +        aspeed_acry_hexdump("n", n, n_len);
> +        aspeed_acry_hexdump("e", e, e_len);
> +        aspeed_acry_hexdump("data", data, data_len);
> +    }
> +
> +    der_key = aspeed_acry_der_encode_pubkey(n, n_len, e, e_len, &der_len);
> +    cipher = qcrypto_akcipher_new(&opts, QCRYPTO_AK_CIPHER_KEY_TYPE_PUBLIC,
> +                                  der_key, der_len, &local_err);
> +    if (!cipher) {
> +        qemu_log_mask(LOG_GUEST_ERROR,
> +                     "%s: failed to create RSA cipher: %s\n",
> +                     __func__, error_get_pretty(local_err));
> +        error_free(local_err);
> +        return;
> +    }
> +
> +    result_len = qcrypto_akcipher_encrypt(cipher, data, data_len,
> +                                          result, sizeof(result),
> +                                          &local_err);
> +    if (result_len < 0) {
> +        qemu_log_mask(LOG_GUEST_ERROR, "%s: RSA modexp failed: %s\n",
> +                     __func__, error_get_pretty(local_err));
> +        error_free(local_err);
> +        result_len = 0;
> +    }
> +
> +    qcrypto_akcipher_free(cipher);
> +
> +    if (trace_event_get_state_backends(TRACE_ASPEED_ACRY_HEXDUMP)) {
> +        aspeed_acry_hexdump("result", result, result_len);
> +    }
> +
> +    aspeed_acry_store_result(s, result, result_len, n_len);
> +}
> +
> +static uint64_t aspeed_acry_read(void *opaque, hwaddr offset, unsigned int size)
> +{
> +    AspeedACRYState *s = ASPEED_ACRY(opaque);
> +    uint32_t reg = offset >> 2;
> +
> +    trace_aspeed_acry_read(offset, s->regs[reg]);
> +
> +    return s->regs[reg];
> +}
> +
> +static void aspeed_acry_write(void *opaque, hwaddr offset, uint64_t data,
> +                              unsigned int size)
> +{
> +    AspeedACRYState *s = ASPEED_ACRY(opaque);
> +    uint32_t reg = offset >> 2;
> +
> +    trace_aspeed_acry_write(offset, data);
> +
> +    switch (reg) {
> +    case R_ACRY_DMA_SRC:
> +        /*
> +         * The DMA source register holds a CPU-visible DRAM address (e.g.
> +         * 0x8xxxxxxx on AST2600); the engine addresses DRAM from offset 0,
> +         * so mask off the top bit to get the DRAM-relative offset.
> +         */
> +        data &= 0x7FFFFFFF;
> +        break;
> +    case R_ACRY_STATUS:
> +        data = s->regs[R_ACRY_STATUS] & ~data;
> +        if (!(data & (R_ACRY_STATUS_RSA_ENG_DONE_MASK |
> +                      R_ACRY_STATUS_RSA_DMA_DONE_MASK))) {
> +            qemu_irq_lower(s->irq);
> +        }
> +        break;
> +    case R_ACRY_TRIGGER:
> +        if (FIELD_EX32(data, ACRY_TRIGGER, RSA_START)) {
> +            aspeed_acry_do_rsa(s);
> +
> +            s->regs[R_ACRY_STATUS] |= R_ACRY_STATUS_RSA_ENG_DONE_MASK |
> +                                      R_ACRY_STATUS_RSA_DMA_DONE_MASK;
> +            if (s->regs[R_ACRY_INT_MASK] &
> +                (R_ACRY_INT_MASK_RSA_ENG_MASK_MASK |
> +                 R_ACRY_INT_MASK_RSA_DMA_MASK_MASK)) {
> +                qemu_irq_raise(s->irq);
> +            }
> +        }
> +        break;
> +    default:
> +        break;
> +    }
> +
> +    s->regs[reg] = data;
> +}
> +
> +static const MemoryRegionOps aspeed_acry_ops = {
> +    .read = aspeed_acry_read,
> +    .write = aspeed_acry_write,
> +    .endianness = DEVICE_LITTLE_ENDIAN,
> +    .valid = {
> +        .min_access_size = 1,
> +        .max_access_size = 4,
> +    },
> +};
> +
> +static void aspeed_acry_reset_hold(Object *obj, ResetType type)
> +{
> +    AspeedACRYState *s = ASPEED_ACRY(obj);
> +
> +    memset(s->regs, 0, sizeof(s->regs));
> +}
> +
> +static void aspeed_acry_realize(DeviceState *dev, Error **errp)
> +{
> +    SysBusDevice *sbd = SYS_BUS_DEVICE(dev);
> +    AspeedACRYState *s = ASPEED_ACRY(dev);
> +
> +    if (!s->dram_mr) {
> +        error_setg(errp, TYPE_ASPEED_ACRY ": 'dram' link not set");
> +        return;
> +    }
> +    address_space_init(&s->dram_as, s->dram_mr, "dram");

Please move address_space_init() after if (!s->sram_mr).

> +
> +    if (!s->sram_mr) {
> +        error_setg(errp, TYPE_ASPEED_ACRY ": 'sram' link not set");
> +        return;
> +    }
> +    address_space_init(&s->sram_as, s->sram_mr, "sram");
> +
> +    memory_region_init_io(&s->iomem, OBJECT(s), &aspeed_acry_ops, s,
> +                          TYPE_ASPEED_ACRY, ASPEED_ACRY_NR_REGS << 2);
> +    sysbus_init_mmio(sbd, &s->iomem);
> +
> +    sysbus_init_irq(sbd, &s->irq);
> +}
> +
> +static const Property aspeed_acry_properties[] = {
> +    DEFINE_PROP_LINK("dram", AspeedACRYState, dram_mr,
> +                     TYPE_MEMORY_REGION, MemoryRegion *),
> +    DEFINE_PROP_LINK("sram", AspeedACRYState, sram_mr,
> +                     TYPE_MEMORY_REGION, MemoryRegion *),
> +};
> +
> +static void aspeed_acry_class_init(ObjectClass *klass, const void *data)
> +{
> +    DeviceClass *dc = DEVICE_CLASS(klass);
> +    ResettableClass *rc = RESETTABLE_CLASS(klass);
> +
> +    dc->desc = "ASPEED ACRY Engine";
> +    dc->realize = aspeed_acry_realize;
> +    rc->phases.hold = aspeed_acry_reset_hold;
> +    device_class_set_props(dc, aspeed_acry_properties);
> +}
> +
> +static const TypeInfo aspeed_acry_types[] = {
> +    {
> +        .name = TYPE_ASPEED_ACRY,
> +        .parent = TYPE_SYS_BUS_DEVICE,
> +        .instance_size = sizeof(AspeedACRYState),
> +        .class_init = aspeed_acry_class_init,
> +    },
> +};
> +
> +DEFINE_TYPES(aspeed_acry_types)
> diff --git a/hw/misc/meson.build b/hw/misc/meson.build
> index e86d9ad6b3..3912dc2bce 100644
> --- a/hw/misc/meson.build
> +++ b/hw/misc/meson.build
> @@ -137,6 +137,7 @@ system_ss.add(when: 'CONFIG_PVPANIC_PCI', if_true: files('pvpanic-pci.c'))
>   system_ss.add(when: 'CONFIG_PVPANIC_MMIO', if_true: files('pvpanic-mmio.c'))
>   system_ss.add(when: 'CONFIG_AUX', if_true: files('auxbus.c'))
>   system_ss.add(when: 'CONFIG_ASPEED_SOC', if_true: files(
> +  'aspeed_acry.c',
>     'aspeed_hace.c',
>     'aspeed_lpc.c',
>     'aspeed_ltpi.c',
> diff --git a/hw/misc/trace-events b/hw/misc/trace-events
> index c9a868b3ef..bbec0d2178 100644
> --- a/hw/misc/trace-events
> +++ b/hw/misc/trace-events
> @@ -331,6 +331,12 @@ aspeed_peci_read(uint64_t offset, uint64_t data) "offset 0x%" PRIx64 " data 0x%"
>   aspeed_peci_write(uint64_t offset, uint64_t data) "offset 0x%" PRIx64 " data 0x%" PRIx64
>   aspeed_peci_raise_interrupt(uint32_t ctrl, uint32_t status) "ctrl 0x%" PRIx32 " status 0x%" PRIx32
>   
> +# aspeed_acry.c
> +aspeed_acry_read(uint64_t offset, uint64_t data) "offset 0x%" PRIx64 " data 0x%" PRIx64
> +aspeed_acry_write(uint64_t offset, uint64_t data) "offset 0x%" PRIx64 " data 0x%" PRIx64
> +aspeed_acry_rsa_trigger(uint64_t src_addr, uint32_t len) "src_addr 0x%" PRIx64 " len 0x%" PRIx32
> +aspeed_acry_hexdump(const char *desc, uint32_t offset, const char *s) "%s: 0x%08x: %s"
> +
>   # aspeed_hace.c
>   aspeed_hace_read(uint64_t offset, uint64_t data) "offset 0x%" PRIx64 " data 0x%" PRIx64
>   aspeed_hace_write(uint64_t offset, uint64_t data) "offset 0x%" PRIx64 " data 0x%" PRIx64


