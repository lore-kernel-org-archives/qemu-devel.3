Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1AB0DCD4F3D
	for <qemu-devel@archiver.kernel.org>; Wed, 20 May 2026 17:45:09 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wPkyA-0006qX-R9; Wed, 20 May 2026 13:44:34 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1wPky9-0006qL-6W
 for qemu-devel@nongnu.org; Wed, 20 May 2026 13:44:33 -0400
Received: from mail-wr1-x435.google.com ([2a00:1450:4864:20::435])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1wPky5-0000FO-Pz
 for qemu-devel@nongnu.org; Wed, 20 May 2026 13:44:32 -0400
Received: by mail-wr1-x435.google.com with SMTP id
 ffacd0b85a97d-4526a8170ceso2494640f8f.2
 for <qemu-devel@nongnu.org>; Wed, 20 May 2026 10:44:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1779299062; x=1779903862; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:references:cc:to:from
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=k4XXUeIimgsoXitQgruHnqIoFn+CTx5oG9PfH/YLYXI=;
 b=xRm1DmpvgKdiiy9/GQ9pNxxuaX8Q018Ni8DiQta8IzWnYQPfocbOQqAm6tlbT4IBCn
 kNfp3YhkF9lwF8pxB8/0Nfkr73vaSll8lDwFsVDxNSFz55gkdzDDNBI+4jhclJ5hZvts
 WodR2pagVI6mcfkj0UOC1iEnvoCs/eM65uTUysNNLrwLwS8gSlLh2/jguePfXMthg0kq
 ztZpE/NyiOl3v2Oj19J8SKFbLXIJfB+OifCcX3NkFyvPKkpLPJ8EOy+eCfc2tyXx9eqA
 4qwT/0ZGGf7+T229RV94yq6cL2rZv9F1Ll54brKIMY3fAgGDM+fKVkS8t5BKtcZing7s
 7ZNg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779299062; x=1779903862;
 h=content-transfer-encoding:in-reply-to:references:cc:to:from
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=k4XXUeIimgsoXitQgruHnqIoFn+CTx5oG9PfH/YLYXI=;
 b=bDeCVqSkAdcebuMKUjN8ocFm+uInofFXx193srQQzpMMj9aPtqauyWSeFoK5I0jV9n
 R5RMkjmi8a+Damzuf86ztDGSGM8K79CJXNi9hYrQ0OsL0Zd45AfaNS/F0waCeyQYby4O
 enE/SSKioUKssk/XCF1oEhvYclYs6tXk7s+F7V71EooByCSwGCuRLwAwIxfKgMn7E+VD
 G5teSv5V5pYZkOOOPqAWMGLIVMyOanrckK0rjF/LAkLDI/dBrhv9XOImDJlKWEKfAWr4
 L3JAUd7PItNpk69Ztdhj0d5B6z48+SyTjH0HoLs9CV6UekiCk0L6PzySn7rgqKeQJFLZ
 bCKA==
X-Gm-Message-State: AOJu0YzsURPgAh1inac4fZWAmO1hBWYhhUE88gLyJIPmKBAgPh7xn7pv
 SqROsM7H5RaczjX20omfYchiuoAoVCpS+WiwsV/28n4b6MHQQ8y12fm3RACPocDQe5PCSlmJmRd
 7wiQqqrM=
X-Gm-Gg: Acq92OF41iUw2LkTqg7ra/1oX/uCB6BLcB9iXMJ4l3F5s/XBll16nSRwxN+HUG10enN
 ojgr+79yIG5oiNxlmlykNS5zOc8u3k0QlNZW3MNx2nIeYJPjp3M8BAJWehVOe+YhFVbnR9VF2fS
 Lp+GluS7rHhWJzsHTmcStich9GCWg9HnRlqRIiH/gnsdmX8wxHzblOh1f6a9+5zh2+Sn85IZ5Mk
 kzzTvNN848ZqC+ATm92YfjmKYIPYtSwtte/hK808OdXByzvy7PmZvVEcarMXJWZNA0JNFBZLR2U
 JAiO3HZtNLG2BHf6KR7m3sq16BEyW1klSjMaveNu0BUFD78/RoONlwcmHptijnvtjIFb9jY85V6
 yrfxlYf04OYsR8lmQQ084TkMcPb1jhHO71uBcaPnXSlQHKj4gY/7umfJdbGRdyPtk0U2Sk1jWg5
 yoZe/wukkLtf8us1ol11gmLu1AWEcA2LeZePwghLehXwkxr/63C2LHr8aytXxsVyf2UygN+BCIe
 6R9sb5vpei6JA8=
X-Received: by 2002:a05:6000:2083:b0:43f:ea04:dcc7 with SMTP id
 ffacd0b85a97d-45e5c5f277emr42544304f8f.24.1779299061908; 
 Wed, 20 May 2026 10:44:21 -0700 (PDT)
Received: from [192.168.69.200] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-45e7c22d8b7sm26522853f8f.6.2026.05.20.10.44.20
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 20 May 2026 10:44:21 -0700 (PDT)
Message-ID: <bd591571-121c-4eac-8ce6-e1e2234dcf3f@linaro.org>
Date: Wed, 20 May 2026 19:44:20 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v12 24/24] target/mips: add Octeon LA* atomic instructions
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org, Richard Henderson <richard.henderson@linaro.org>
Cc: James Hilliard <james.hilliard1@gmail.com>
References: <20260520172313.23777-1-philmd@linaro.org>
 <20260520172313.23777-25-philmd@linaro.org>
In-Reply-To: <20260520172313.23777-25-philmd@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::435;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x435.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On 20/5/26 19:23, Philippe Mathieu-Daudé wrote:
> From: James Hilliard <james.hilliard1@gmail.com>
> 
> Implement the Octeon LA* read-modify-write atomic instruction family:
> LAI/LAID, LAD/LADD, LAA/LAAD, LAS/LASD, LAC/LACD, and LAW/LAWD.
> 
> These operations are architecturally distinct from SAA/SAAD and are used
> by existing Octeon user-mode code for atomic counters, bit operations,
> and exchange-style updates.
> 
> Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
> Signed-off-by: James Hilliard <james.hilliard1@gmail.com>
> Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
> ---
>   target/mips/tcg/octeon.decode      | 17 +++++++++++
>   target/mips/tcg/octeon_translate.c | 49 ++++++++++++++++++++++++++++++
>   2 files changed, 66 insertions(+)
> 
> diff --git a/target/mips/tcg/octeon.decode b/target/mips/tcg/octeon.decode
> index 2d02b4e0bc3..1e44c588dd6 100644
> --- a/target/mips/tcg/octeon.decode
> +++ b/target/mips/tcg/octeon.decode
> @@ -68,6 +68,23 @@ V3MULU       011100 ..... ..... ..... 00000 010001 @r3
>   SAA          011100 ..... ..... 00000 00000 011000 @saa
>   SAAD         011100 ..... ..... 00000 00000 011001 @saa
>   
> +&la          base rd
> +&laa         base add rd
> +@la          ...... base:5 ..... rd:5 ........... &la
> +@laa         ...... base:5 add:5 rd:5 ........... &laa
> +LAI          011100 ..... 00000 ..... 00010 011111 @la
> +LAID         011100 ..... 00000 ..... 00011 011111 @la
> +LAD          011100 ..... 00000 ..... 00110 011111 @la
> +LADD         011100 ..... 00000 ..... 00111 011111 @la
> +LAA          011100 ..... ..... ..... 10010 011111 @laa
> +LAAD         011100 ..... ..... ..... 10011 011111 @laa
> +LAS          011100 ..... 00000 ..... 01010 011111 @la
> +LASD         011100 ..... 00000 ..... 01011 011111 @la
> +LAC          011100 ..... 00000 ..... 01110 011111 @la
> +LACD         011100 ..... 00000 ..... 01111 011111 @la
> +LAW          011100 ..... ..... ..... 10110 011111 @laa
> +LAWD         011100 ..... ..... ..... 10111 011111 @laa
> +
>   &zcb         base
>   ZCB          011100 base:5 00000 00000 1110- 011111 &zcb
>   
> diff --git a/target/mips/tcg/octeon_translate.c b/target/mips/tcg/octeon_translate.c
> index 90bd68cbf25..47d46999487 100644
> --- a/target/mips/tcg/octeon_translate.c
> +++ b/target/mips/tcg/octeon_translate.c
> @@ -185,6 +185,55 @@ static bool trans_saa(DisasContext *ctx, arg_saa *a, MemOp mop)
>   TRANS(SAA,  trans_saa, MO_32);
>   TRANS(SAAD, trans_saa, MO_64);
>   
> +typedef void AtomicThreeOpFn(TCGv_i64, TCGv_va, TCGv_i64, TCGArg, MemOp);
> +
> +static bool do_atomic_ld(DisasContext *ctx, AtomicThreeOpFn *atomic_fn,
> +                         int base, int add_reg, int rd, int64_t imm, MemOp mop)
> +{
> +    TCGv_i64 addr = tcg_temp_new_i64();
> +    TCGv_i64 old = tcg_temp_new_i64();
> +    TCGv_i64 value;
> +    MemOp amo = mo_endian(ctx) | mop | MO_ALIGN;
> +
> +    gen_base_offset_addr(ctx, addr, base, 0);
> +
> +    if (add_reg >= 0) {
> +        value = tcg_temp_new_i64();
> +        gen_load_gpr(value, add_reg);
> +    } else {
> +        value = tcg_constant_i64(imm);
> +    }
> +
> +    atomic_fn(old, addr, value, ctx->mem_idx, amo);
> +    gen_store_gpr(old, rd);
> +    return true;
> +}
> +
> +static bool do_atomic_la(DisasContext *ctx, arg_la *a, AtomicThreeOpFn *fn,
> +                         int64_t imm, MemOp mop)
> +{
> +    return do_atomic_ld(ctx, fn, a->base, -1, a->rd, imm, mop);
> +}
> +
> +static bool do_atomic_laa(DisasContext *ctx, arg_laa *a, AtomicThreeOpFn *fn,
> +                          int64_t imm, MemOp mop)
> +{
> +    return do_atomic_ld(ctx, fn, a->base, a->add, a->rd, imm, mop);
> +}
> +
> +TRANS(LAI,  do_atomic_la,  tcg_gen_atomic_fetch_add_i64,  1, MO_SL);
> +TRANS(LAID, do_atomic_la,  tcg_gen_atomic_fetch_add_i64,  1, MO_UQ);
> +TRANS(LAD,  do_atomic_la,  tcg_gen_atomic_fetch_add_i64, -1, MO_SL);
> +TRANS(LADD, do_atomic_la,  tcg_gen_atomic_fetch_add_i64, -1, MO_UQ);
> +TRANS(LAA,  do_atomic_laa, tcg_gen_atomic_fetch_add_i64,  0, MO_SL);
> +TRANS(LAAD, do_atomic_laa, tcg_gen_atomic_fetch_add_i64,  0, MO_UQ);
> +TRANS(LAS,  do_atomic_la,  tcg_gen_atomic_xchg_i64,      -1, MO_SL);
> +TRANS(LASD, do_atomic_la,  tcg_gen_atomic_xchg_i64,      -1, MO_UQ);
> +TRANS(LAC,  do_atomic_la,  tcg_gen_atomic_xchg_i64,       0, MO_SL);
> +TRANS(LACD, do_atomic_la,  tcg_gen_atomic_xchg_i64,       0, MO_UQ);
> +TRANS(LAW,  do_atomic_laa, tcg_gen_atomic_xchg_i64,       0, MO_SL);
> +TRANS(LAWD, do_atomic_laa, tcg_gen_atomic_xchg_i64,       0, MO_UQ);

I actually changed my mind for:

-- >8 --
+typedef void AtomicThreeOpFn(TCGv_i64, TCGv_va, TCGv_i64, TCGArg, MemOp);
+
+static bool do_atomic_la(DisasContext *ctx, arg_la *a,
+                         AtomicThreeOpFn *atomic_fn, int64_t imm, MemOp 
mop)
+{
+    TCGv_i64 addr = tcg_temp_new_i64();
+    TCGv_i64 old = tcg_temp_new_i64();
+    MemOp amo = mo_endian(ctx) | mop | MO_ALIGN;
+
+    gen_base_offset_addr(ctx, addr, a->base, 0);
+
+    atomic_fn(old, addr, tcg_constant_i64(imm), ctx->mem_idx, amo);
+    gen_store_gpr(old, a->rd);
+    return true;
+}
+
+static bool do_atomic_laa(DisasContext *ctx, arg_laa *a,
+                          AtomicThreeOpFn *atomic_fn, MemOp mop)
+{
+    TCGv_i64 addr = tcg_temp_new_i64();
+    TCGv_i64 old = tcg_temp_new_i64();
+    TCGv_i64 value = tcg_temp_new_i64();
+    MemOp amo = mo_endian(ctx) | mop | MO_ALIGN;
+
+    gen_base_offset_addr(ctx, addr, a->base, 0);
+    gen_load_gpr(value, a->add);
+
+    atomic_fn(old, addr, value, ctx->mem_idx, amo);
+    gen_store_gpr(old, a->rd);
+    return true;
+}
+
+TRANS(LAI,  do_atomic_la,  tcg_gen_atomic_fetch_add_i64,  1, MO_SL);
+TRANS(LAID, do_atomic_la,  tcg_gen_atomic_fetch_add_i64,  1, MO_UQ);
+TRANS(LAD,  do_atomic_la,  tcg_gen_atomic_fetch_add_i64, -1, MO_SL);
+TRANS(LADD, do_atomic_la,  tcg_gen_atomic_fetch_add_i64, -1, MO_UQ);
+TRANS(LAA,  do_atomic_laa, tcg_gen_atomic_fetch_add_i64,     MO_SL);
+TRANS(LAAD, do_atomic_laa, tcg_gen_atomic_fetch_add_i64,     MO_UQ);
+TRANS(LAS,  do_atomic_la,  tcg_gen_atomic_xchg_i64,      -1, MO_SL);
+TRANS(LASD, do_atomic_la,  tcg_gen_atomic_xchg_i64,      -1, MO_UQ);
+TRANS(LAC,  do_atomic_la,  tcg_gen_atomic_xchg_i64,       0, MO_SL);
+TRANS(LACD, do_atomic_la,  tcg_gen_atomic_xchg_i64,       0, MO_UQ);
+TRANS(LAW,  do_atomic_laa, tcg_gen_atomic_xchg_i64,          MO_SL);
+TRANS(LAWD, do_atomic_laa, tcg_gen_atomic_xchg_i64,          MO_UQ);
---

