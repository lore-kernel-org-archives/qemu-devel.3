Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3DC15C5DF81
	for <qemu-devel@archiver.kernel.org>; Wed, 19 Aug 2026 20:02:07 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wwmTi-0002WE-Cj; Wed, 19 Aug 2026 16:01:38 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@kaod.org>)
 id 1wwmTY-0002S0-GL; Wed, 19 Aug 2026 16:01:29 -0400
Received: from smtpout1.mo528.mail-out.ovh.net ([46.105.34.251])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@kaod.org>)
 id 1wwmTS-0003dc-Rf; Wed, 19 Aug 2026 16:01:26 -0400
Received: from director6.derp.mail-out.ovh.net
 (director6.derp.mail-out.ovh.net [79.137.60.226])
 by mo528.mail-out.ovh.net (Postfix) with ESMTPS id 4hQHMw36fpz66yR;
 Wed, 19 Aug 2026 19:54:36 +0000 (UTC)
Received: from director6.derp.mail-out.ovh.net
 (director6.derp.mail-out.ovh.net. [127.0.0.1])
 by director6.derp.mail-out.ovh.net (inspect_sender_mail_agent) with SMTP
 for <jamin_lin@aspeedtech.com>; Wed, 19 Aug 2026 19:54:36 +0000 (UTC)
Received: from mta11.priv.ovhmail-u2.ea.mail.ovh.net (unknown [10.110.37.222])
 by director6.derp.mail-out.ovh.net (Postfix) with ESMTPS id
 4hQHMw2RSpz422l; Wed, 19 Aug 2026 19:54:36 +0000 (UTC)
Received: from kaod.org (unknown [10.1.6.3])
 (Authenticated sender: clg@kaod.org)
 by mta11.priv.ovhmail-u2.ea.mail.ovh.net (Postfix) with ESMTPSA id
 7E28F2403E79; Wed, 19 Aug 2026 19:54:34 +0000 (UTC)
Authentication-Results: garm.ovh; auth=pass
 (GARM-104R005910cfae5-0e47-4172-b459-811450307d3c,
 C24CD8B75EED539221ACEA448CE881038350F7ED) smtp.auth=clg@kaod.org
X-OVh-ClientIp: 2.10.174.70
Message-ID: <ec0c762d-216c-4584-8b5b-3d3011b283de@kaod.org>
Date: Wed, 19 Aug 2026 21:54:33 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 1/5] hw/misc/aspeed_acry: Add ASPEED ACRY model
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
References: <20260813062359.425268-1-jamin_lin@aspeedtech.com>
 <20260813062359.425268-2-jamin_lin@aspeedtech.com>
From: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@kaod.org>
Content-Language: en-US, fr
Autocrypt: addr=clg@kaod.org; keydata=
 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
In-Reply-To: <20260813062359.425268-2-jamin_lin@aspeedtech.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
x-ovh-tracer-id: 719450041947434029
X-VR-SPAMSTATE: OK
X-VR-SPAMSCORE: -100
X-VR-SPAMCAUSE: dmFkZTFFpYReO2Oil0SgNOUnqVJJi5mn6/n4lK7R1mazMbkOwUO2dsbG2f35tBM2nqjfusYzXDjXI24WFQ8pFjy8Ozc6ZihsHsbcpbznk+x1QSDLwnjd3+bW3BCcCJP58aEWttbaK4VvAND4iX68qk9ECJvVyc3AUkwbGyYu58pJZx6IbDoNRisoOxTI934WR26Ic1TtQrDq22TMKlF6aeUm30YNm9yN3VXPbgiRbRgkuMGIl4z0ExmgqgBfmnQzdR6WJnEo6XT2q57okqPoap0N1Lls0ktxCMAetMnjAX3EQY9vxxEWTckJBOx72nR/RF4qKeZxojxHWaN/64Mn9+enQ9fEhR2SJ26reaNVUVnnWIBDA0A9pdOAKLEniR8upMvIq0Jp277VS5toTiiiswPYXpnMxGjSq1jCs7m9Rurc777n1zyYFMUHAyk4ZhVNaXpyfef+Ahx0LjMVP9zZ63NxlUZG2CLK2U2azIxOT99srB48eVpWjPHHhLPM8E9dzxcTTP+qsI/k6aIjDLHYpfs1Yj2vhu/Z0d453awyk+F85nJD6ln8L4GkIwW4FKrxxwqNYc1a/N7lktrZhaq8/LtV3h+XFW5bko6HhKgFD7fm7Gu1de3WjR/3xPpLMPl0leqZzuTtEnt0SUXiAHREITv0EdB2HcgcosbV4lky33xUNqOIgg
DKIM-Signature: a=rsa-sha256; bh=w5+ox5Wi3khKRFDiCLUn71odV0kJQneTXxJYEHnV30A=; 
 c=relaxed/relaxed; d=kaod.org; h=From; s=ovhmo393970-selector1;
 t=1787169277; v=1;
 b=icOAWzP3mPZzEvS00NJ3umjZnsEgE+QgYiLPhMVdI3mCPosRO2Q2oJih7tRyqe1e/+00APqh
 Ce9CFUgGFCeaLbLEslcyfwoIVcZJX0nJUKGvPxzMRO3Ok36wqVVnJeZdg1nVzdBCsXQhza5bR4C
 gtQn4dfAEOrh8p8dRNhvGCzyXQvNrS/hr8XnfmGXbho8onR5VXSKTcDYKQNvYFVior8603IemzA
 Dokmu2sSym+rGpdc/aKqZJQShZLPTkA5erQFXhUJYmvJuc+p1AuF39t+OOUbVcQPsZN9Hi67Kaz
 aTKfTHNPBo2y8+26xLEBi8vWrzdViJmxOITIcXWdp09AQ==
Received-SPF: pass client-ip=46.105.34.251; envelope-from=clg@kaod.org;
 helo=smtpout1.mo528.mail-out.ovh.net
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

On 8/13/26 08:24, Jamin Lin wrote:
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
> padding), so this device needs QEMU built with --enable-gcrypt.
> 
> When that support is missing, the engine still completes and raises its
> completion IRQ as real hardware would, but produces an all-zero result
> so that whatever signature check the guest performs on it fails cleanly
> instead of the guest hanging forever waiting for an interrupt that
> would otherwise never come.
> 
> Signed-off-by: Jamin Lin <jamin_lin@aspeedtech.com>
> ---
>   include/hw/misc/aspeed_acry.h |  50 ++++
>   hw/misc/aspeed_acry.c         | 447 ++++++++++++++++++++++++++++++++++
>   hw/misc/meson.build           |   1 +
>   hw/misc/trace-events          |   6 +
>   4 files changed, 504 insertions(+)
>   create mode 100644 include/hw/misc/aspeed_acry.h
>   create mode 100644 hw/misc/aspeed_acry.c
> 
> diff --git a/include/hw/misc/aspeed_acry.h b/include/hw/misc/aspeed_acry.h
> new file mode 100644
> index 0000000000..5af2296830
> --- /dev/null
> +++ b/include/hw/misc/aspeed_acry.h
> @@ -0,0 +1,50 @@
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
> +    /*
> +     * Byte-position lookup tables: exp_map[k] / mod_map[k] / data_map[k]
> +     * give the offset in the scattered buffer of byte k (k = 0 =
> +     * least significant) of the exponent / modulus / data.
> +     */
> +    uint32_t exp_map[ASPEED_ACRY_MAX_BYTES];
> +    uint32_t mod_map[ASPEED_ACRY_MAX_BYTES];
> +    uint32_t data_map[ASPEED_ACRY_DATA_MAX_LEN];
> +
> +    MemoryRegion *dram_mr;
> +    AddressSpace dram_as;
> +
> +    MemoryRegion *sram_mr;
> +    AddressSpace sram_as;
> +    uint64_t sram_base;

A device model should not know its mapping address.

I think sram[1] should be wrapped in a container MR at offset 0 and
mapped at the physical address. With that the device can use relative
offsets.

Look at the DRAM dram_container in aspeed_soc_common.c for this.

  

> +};
> +
> +#endif /* ASPEED_ACRY_H */
> diff --git a/hw/misc/aspeed_acry.c b/hw/misc/aspeed_acry.c
> new file mode 100644
> index 0000000000..53ef68d284
> --- /dev/null
> +++ b/hw/misc/aspeed_acry.c
> @@ -0,0 +1,447 @@
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
> +REG32(ACRY_RSA_KEY_LEN, 0x058)
> +REG32(ACRY_INT_MASK, 0x3F8)
> +    FIELD(ACRY_INT_MASK, RSA_DMA_MASK, 2, 1)
> +    FIELD(ACRY_INT_MASK, RSA_ENG_MASK, 1, 1)
> +REG32(ACRY_STATUS, 0x3FC)
> +    FIELD(ACRY_STATUS, RSA_DMA_DONE, 2, 1)
> +    FIELD(ACRY_STATUS, RSA_ENG_DONE, 1, 1)
> +
> +/*
> + * Total size of the interleaved SRAM buffer. Data is 4 of every 12
> + * dwords of a block (see aspeed_acry_init_mapping()), i.e. one third of
> + * the buffer, so the whole buffer is 3x the data region.
> + */
> +#define ASPEED_ACRY_SRAM_SIZE   (3 * ASPEED_ACRY_DATA_MAX_LEN)
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
> + * The SRAM buffer is a series of 12-dword blocks, each split into
> + * three 4-dword regions - exp, mod, data:
> + *
> + *   dword in block:  0    1    2    3    4    5    6    7    8    9   10   11
> + *   region:          \---- exp ----/    \---- mod ----/    \---- data ----/
> + *   lane:            0    1    2    3    0    1    2    3    0    1    2    3
> + *
> + * Successive blocks hold the next 4 dwords of each operand, so operand
> + * dword d is in block (d / 4), lane (d % 4). Dwords are little-endian, so
> + * byte b of the dword at SRAM dword D is at byte D * 4 + b.
> + *
> + * exp_map[op_byte] / mod_map[op_byte] / data_map[op_byte] give the buffer
> + * offset of operand byte op_byte (op_byte = 0 = least significant).
> + */
> +static void aspeed_acry_init_mapping(AspeedACRYState *s)
> +{
> +    int byte_in_dword;
> +    int block_base;
> +    int op_dword;
> +    int op_byte;
> +    int block;
> +    int lane;
> +
> +    for (op_byte = 0; op_byte < ASPEED_ACRY_DATA_MAX_LEN; op_byte++) {
> +        op_dword = op_byte / 4;
> +        byte_in_dword = op_byte % 4;
> +        block = op_dword / 4;
> +        lane = op_dword % 4;
> +        block_base = block * 12;
> +
> +        /* exp starts each block; mod is +4 dwords, data +8 dwords. */
> +        s->data_map[op_byte] = (block_base + 8 + lane) * 4 + byte_in_dword;
> +        if (op_byte < ASPEED_ACRY_MAX_BYTES) {
> +            s->exp_map[op_byte] = (block_base + 0 + lane) * 4 + byte_in_dword;
> +            s->mod_map[op_byte] = (block_base + 4 + lane) * 4 + byte_in_dword;
> +        }
> +    }
> +}


This is a lot of constant values for each state. Can we build the offsets
on the fly ?


> +/*
> + * Read one operand out of the buffer as a big-endian magnitude.
> + *
> + * The operand's bytes are scattered through buf: buf[map[k]] is the byte
> + * at significance level k (k = 0 is the least significant). Walk from the
> + * top down, drop leading zero bytes, and write the result most significant
> + * byte first into out[]. Returns the number of bytes written (the value 0
> + * yields a single 0x00 byte, so always >= 1).
> + */
> +static int aspeed_acry_extract_be(const uint8_t *buf, const uint32_t *map,
> +                                  int max_bytes, uint8_t *out)
> +{
> +    int msb;
> +    int len;
> +    int k;
> +
> +    /* Highest significance level holding a non-zero byte (skip leading 0s). */
> +    msb = max_bytes - 1;
> +    while (msb >= 0 && buf[map[msb]] == 0) {
> +        msb--;
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
> +        out[len++] = buf[map[k]];
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
> + * Store the RSA result into the output SRAM, scattered through the data
> + * region via data_map[] (result_be is big-endian; the region above the
> + * result is zeroed).
> + *
> + * data_map[] holds SRAM-relative offsets, but sram_as is an AddressSpace
> + * over the SoC memory, where the SRAM is mapped at sram_base - so the
> + * absolute address is sram_base + data_map[k].
> + */
> +static void aspeed_acry_store_result(AspeedACRYState *s,
> +                                     const uint8_t *result_be, int result_len)
> +{
> +    uint8_t value;
> +    int src;
> +    int k;
> +
> +    /* result_be is MSB-first, so its last byte is the least significant. */

There are address_space store/load be/le helpers which could simplify
the transactions.

> +    src = result_len - 1;
> +    for (k = 0; k < ASPEED_ACRY_DATA_MAX_LEN; k++) {
> +        value = 0;
> +        if (src >= 0) {
> +            value = result_be[src--];
> +        }
> +        address_space_write(&s->sram_as, s->sram_base + s->data_map[k],
> +                            MEMTXATTRS_UNSPECIFIED, &value, 1);

the return value should be tested.


Thanks,

C.


> +    }
> +}
> +
> +static void aspeed_acry_do_rsa(AspeedACRYState *s)
> +{
> +    QCryptoAkCipherOptions opts = {
> +        .alg = QCRYPTO_AK_CIPHER_ALGO_RSA,
> +        .u.rsa = {
> +            .padding_alg = QCRYPTO_RSA_PADDING_ALGO_RAW,
> +        },
> +    };
> +    uint8_t result[ASPEED_ACRY_MAX_BYTES] = { 0 };
> +    uint64_t src_addr = s->regs[R_ACRY_DMA_SRC];
> +    uint8_t buf[ASPEED_ACRY_SRAM_SIZE] = { 0 };
> +    uint8_t data[ASPEED_ACRY_DATA_MAX_LEN];
> +    uint32_t len = s->regs[R_ACRY_DMA_LEN];
> +    g_autofree uint8_t *der_key = NULL;
> +    uint8_t n[ASPEED_ACRY_MAX_BYTES];
> +    uint8_t e[ASPEED_ACRY_MAX_BYTES];
> +    QCryptoAkCipher *cipher = NULL;
> +    Error *local_err = NULL;
> +    int result_len = 0;
> +    size_t der_len;
> +    int data_len;
> +    int n_len;
> +    int e_len;
> +
> +    if (len == 0 || len > ASPEED_ACRY_SRAM_SIZE) {
> +        len = ASPEED_ACRY_SRAM_SIZE;
> +    }
> +
> +    trace_aspeed_acry_rsa_trigger(src_addr, len);
> +
> +    if (address_space_read(&s->dram_as, src_addr, MEMTXATTRS_UNSPECIFIED,
> +                           buf, len) != MEMTX_OK) {
> +        qemu_log_mask(LOG_GUEST_ERROR,
> +                     "%s: failed to read DMA buffer at 0x%" PRIx64 "\n",
> +                     __func__, src_addr);
> +    }
> +
> +    n_len = aspeed_acry_extract_be(buf, s->mod_map, ASPEED_ACRY_MAX_BYTES, n);
> +    e_len = aspeed_acry_extract_be(buf, s->exp_map, ASPEED_ACRY_MAX_BYTES, e);
> +    data_len = aspeed_acry_extract_be(buf, s->data_map,
> +                                      ASPEED_ACRY_DATA_MAX_LEN, data);
> +
> +    if (trace_event_get_state_backends(TRACE_ASPEED_ACRY_HEXDUMP)) {
> +        aspeed_acry_hexdump("buf", buf, len);
> +        aspeed_acry_hexdump("n", n, n_len);
> +        aspeed_acry_hexdump("e", e, e_len);
> +        aspeed_acry_hexdump("data", data, data_len);
> +    }
> +
> +    if (!qcrypto_akcipher_supports(&opts)) {
> +        qemu_log_mask(LOG_UNIMP,
> +                     "%s: RSA ModExp not supported by the crypto backend; "
> +                     "completing with an invalid result\n", __func__);
> +        return;
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
> +    } else {
> +        result_len = qcrypto_akcipher_encrypt(cipher, data, data_len,
> +                                              result, sizeof(result),
> +                                              &local_err);
> +        if (result_len < 0) {
> +            qemu_log_mask(LOG_GUEST_ERROR, "%s: RSA modexp failed: %s\n",
> +                         __func__, error_get_pretty(local_err));
> +            error_free(local_err);
> +            result_len = 0;
> +        }
> +
> +        qcrypto_akcipher_free(cipher);
> +    }
> +
> +    if (trace_event_get_state_backends(TRACE_ASPEED_ACRY_HEXDUMP)) {
> +        aspeed_acry_hexdump("result", result, result_len);
> +    }
> +
> +    aspeed_acry_store_result(s, result, result_len);
> +}
> +
> +static uint64_t aspeed_acry_read(void *opaque, hwaddr addr, unsigned int size)
> +{
> +    AspeedACRYState *s = ASPEED_ACRY(opaque);
> +
> +    addr >>= 2;
> +
> +    trace_aspeed_acry_read(addr << 2, s->regs[addr]);
> +
> +    return s->regs[addr];
> +}
> +
> +static void aspeed_acry_write(void *opaque, hwaddr addr, uint64_t data,
> +                              unsigned int size)
> +{
> +    AspeedACRYState *s = ASPEED_ACRY(opaque);
> +
> +    addr >>= 2;
> +
> +    trace_aspeed_acry_write(addr << 2, data);
> +
> +    switch (addr) {
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
> +    s->regs[addr] = data;
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
> +static void aspeed_acry_instance_init(Object *obj)
> +{
> +    AspeedACRYState *s = ASPEED_ACRY(obj);
> +
> +    aspeed_acry_init_mapping(s);
> +}
> +
> +static void aspeed_acry_realize(DeviceState *dev, Error **errp)
> +{
> +    SysBusDevice *sbd = SYS_BUS_DEVICE(dev);
> +    AspeedACRYState *s = ASPEED_ACRY(dev);
> +
> +    sysbus_init_irq(sbd, &s->irq);
> +
> +    memory_region_init_io(&s->iomem, OBJECT(s), &aspeed_acry_ops, s,
> +                          TYPE_ASPEED_ACRY, ASPEED_ACRY_NR_REGS << 2);
> +    sysbus_init_mmio(sbd, &s->iomem);
> +
> +    if (!s->dram_mr) {
> +        error_setg(errp, TYPE_ASPEED_ACRY ": 'dram' link not set");
> +        return;
> +    }
> +    address_space_init(&s->dram_as, s->dram_mr, "dram");
> +
> +    if (!s->sram_mr) {
> +        error_setg(errp, TYPE_ASPEED_ACRY ": 'sram' link not set");
> +        return;
> +    }
> +    address_space_init(&s->sram_as, s->sram_mr, "sram");
> +}
> +
> +static const Property aspeed_acry_properties[] = {
> +    DEFINE_PROP_LINK("dram", AspeedACRYState, dram_mr,
> +                     TYPE_MEMORY_REGION, MemoryRegion *),
> +    DEFINE_PROP_LINK("sram", AspeedACRYState, sram_mr,
> +                     TYPE_MEMORY_REGION, MemoryRegion *),
> +    DEFINE_PROP_UINT64("sram-base", AspeedACRYState, sram_base, 0),
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
> +        .instance_init = aspeed_acry_instance_init,
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


