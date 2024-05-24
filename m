Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2CC8CC25B74
	for <qemu-devel@archiver.kernel.org>; Fri, 24 May 2024 11:23:58 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sAT0u-0001OP-Ql; Fri, 24 May 2024 07:23:08 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dbarboza@ventanamicro.com>)
 id 1sAT0m-0001Kk-H0
 for qemu-devel@nongnu.org; Fri, 24 May 2024 07:23:04 -0400
Received: from mail-pf1-x42f.google.com ([2607:f8b0:4864:20::42f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <dbarboza@ventanamicro.com>)
 id 1sAT0j-0005p0-8W
 for qemu-devel@nongnu.org; Fri, 24 May 2024 07:23:00 -0400
Received: by mail-pf1-x42f.google.com with SMTP id
 d2e1a72fcca58-6f850ff30c0so1384094b3a.0
 for <qemu-devel@nongnu.org>; Fri, 24 May 2024 04:22:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=ventanamicro.com; s=google; t=1716549775; x=1717154575; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=N2CSJVUqAZMMOewPP7WnOoYurOlsi8p+Y2XioFQJjTs=;
 b=aX0d3tv5J2ui6+TEQk99Onbz5hZlugR0wQS+VIzBMvbesse/kmPup0ugXM8iDQrgH3
 KLEFCT0g14Zzx3DuBYipxGEtxvY6+RZ0XDOxYDiMnq4xb+bK8J/wqrAKI8E8YhJcMaHD
 PXuOpS5NQHxLQgdOhq6JjdUDjmBz4Uzh60hAhHMs5ETLFNqRceQeySNZLzyP5pzYZKas
 4dqnDpM1wHsABC7BD8j/iAS0gwSjDQt2b0I2bTNYU7Fjv7ULTaV5BBJyIhe6hFMipbyw
 FmjOBTzpoFZLFphaY7uylNVyg/ZESvdxlRnYNmUc+wJ+4GTIWSzHu0Oq1C6DCDi+Rlt0
 Oblg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1716549775; x=1717154575;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=N2CSJVUqAZMMOewPP7WnOoYurOlsi8p+Y2XioFQJjTs=;
 b=c0USPjzl5oI9cxedPB+8ENaVzfVzEB4cZ5jvZnJ7x6pz7nEDIeKpQsi/pvW392DrQU
 bugUayz5lc4MftV27N3doLrFWjakrqbXWnQ6xzTrELITzcEpBM5od0oMWardzWf2qxsG
 nzz8B1I+efp1+8nY0WIAovIUlbJURX2fc64Tl+WMgmzCFwJVkcsufp+mfP3EvEdcY18X
 P8fwazkxYO7N3C9A8fv7cD9uHVjVytZEFF64Tc1gxI+3rkFQ+lo8clrpawLIABm0wPzr
 RCh59XQ/zxfNN3UFgTRp/z0PoH8nb2l53XYQR2E1qGASoQ76l7Mx90UXYeLg2/fEa17+
 1jPw==
X-Forwarded-Encrypted: i=1;
 AJvYcCUIlxNJrRTQpB/Z+mUrvOdWaq/NXc7KvCE2yFXYGAk8WJbuEh0IkqPiLyxPjIDulWRAcUREx8R+A4OWif6+O8oLuGuzg9Q=
X-Gm-Message-State: AOJu0Ywr9/oM/u5ke8R96VCdYQRQNJjM66yhj9L+z5MO9HoCcEff9K+9
 t4g5yFVqni5MdZ9tKzWQH+zYTQ9zH/vG7KwH4x/SAN2PAN9A9/QWhsciVU+A1pk=
X-Google-Smtp-Source: AGHT+IGwPiBZAWiBW1sfhPVCT9ov3P03igjFEl7CK7VOIfIXlGfVCpPEYslPoE6cN1VpjvS4i0gbMw==
X-Received: by 2002:a05:6a00:4c12:b0:6f0:c79f:cd7e with SMTP id
 d2e1a72fcca58-6f8f1960325mr2213045b3a.0.1716549774743; 
 Fri, 24 May 2024 04:22:54 -0700 (PDT)
Received: from [192.168.68.110] ([177.94.42.4])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-6f8fd1d2006sm946625b3a.172.2024.05.24.04.22.52
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 24 May 2024 04:22:54 -0700 (PDT)
Message-ID: <28c9b2c1-3f1f-414e-9164-43695181c193@ventanamicro.com>
Date: Fri, 24 May 2024 08:22:50 -0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/1] target/riscv: Support Zama16b extension
To: LIU Zhiwei <zhiwei_liu@linux.alibaba.com>, qemu-devel@nongnu.org
Cc: qemu-riscv@nongnu.org, palmer@dabbelt.com, Alistair.Francis@wdc.com,
 bmeng.cn@gmail.com, iwei1518@gmail.com
References: <20240522091305.1858-1-zhiwei_liu@linux.alibaba.com>
Content-Language: en-US
From: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
In-Reply-To: <20240522091305.1858-1-zhiwei_liu@linux.alibaba.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::42f;
 envelope-from=dbarboza@ventanamicro.com; helo=mail-pf1-x42f.google.com
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



On 5/22/24 06:13, LIU Zhiwei wrote:
> Zama16b is the property that misaligned load/stores/atomics within
> a naturally aligned 16-byte region are atomic.
> 
> According to the specification, Zama16b applies only to AMOs, loads
> and stores defined in the base ISAs, and loads and stores of no more
> than XLEN bits defined in the F, D, and Q extensions. Thus it should
> not apply to zacas or RVC instructions.
> 
> For an instruction in that set, if all accessed bytes lie within 16B granule,
> the instruction will not raise an exception for reasons of address alignment,
> and the instruction will give rise to only one memory operation for the
> purposes of RVWMO—i.e., it will execute atomically.
> 
> Signed-off-by: LIU Zhiwei <zhiwei_liu@linux.alibaba.com>
> ---
>   target/riscv/cpu.c                      |  2 ++
>   target/riscv/cpu_cfg.h                  |  1 +
>   target/riscv/insn_trans/trans_rva.c.inc | 42 ++++++++++++++-----------
>   target/riscv/insn_trans/trans_rvd.c.inc | 14 +++++++--
>   target/riscv/insn_trans/trans_rvf.c.inc | 14 +++++++--
>   target/riscv/insn_trans/trans_rvi.c.inc |  6 ++++
>   6 files changed, 57 insertions(+), 22 deletions(-)
> 
> diff --git a/target/riscv/cpu.c b/target/riscv/cpu.c
> index eb1a2e7d6d..911e9892ed 100644
> --- a/target/riscv/cpu.c
> +++ b/target/riscv/cpu.c
> @@ -117,6 +117,7 @@ const RISCVIsaExtData isa_edata_arr[] = {
>       ISA_EXT_DATA_ENTRY(za64rs, PRIV_VERSION_1_12_0, has_priv_1_11),
>       ISA_EXT_DATA_ENTRY(zaamo, PRIV_VERSION_1_12_0, ext_zaamo),
>       ISA_EXT_DATA_ENTRY(zacas, PRIV_VERSION_1_12_0, ext_zacas),
> +    ISA_EXT_DATA_ENTRY(zama16b, PRIV_VERSION_1_12_0, ext_zama16b),

Is this the right order? Shouldn't it be after zalrsc?


LGTM otherwise. Thanks,


Daniel

>       ISA_EXT_DATA_ENTRY(zalrsc, PRIV_VERSION_1_12_0, ext_zalrsc),
>       ISA_EXT_DATA_ENTRY(zawrs, PRIV_VERSION_1_12_0, ext_zawrs),
>       ISA_EXT_DATA_ENTRY(zfa, PRIV_VERSION_1_12_0, ext_zfa),
> @@ -1464,6 +1465,7 @@ const RISCVCPUMultiExtConfig riscv_cpu_extensions[] = {
>       MULTI_EXT_CFG_BOOL("zihintntl", ext_zihintntl, true),
>       MULTI_EXT_CFG_BOOL("zihintpause", ext_zihintpause, true),
>       MULTI_EXT_CFG_BOOL("zacas", ext_zacas, false),
> +    MULTI_EXT_CFG_BOOL("zama16b", ext_zama16b, false),
>       MULTI_EXT_CFG_BOOL("zaamo", ext_zaamo, false),
>       MULTI_EXT_CFG_BOOL("zalrsc", ext_zalrsc, false),
>       MULTI_EXT_CFG_BOOL("zawrs", ext_zawrs, true),
> diff --git a/target/riscv/cpu_cfg.h b/target/riscv/cpu_cfg.h
> index cb750154bd..eaa66eb4f8 100644
> --- a/target/riscv/cpu_cfg.h
> +++ b/target/riscv/cpu_cfg.h
> @@ -81,6 +81,7 @@ struct RISCVCPUConfig {
>       bool ext_zdinx;
>       bool ext_zaamo;
>       bool ext_zacas;
> +    bool ext_zama16b;
>       bool ext_zalrsc;
>       bool ext_zawrs;
>       bool ext_zfa;
> diff --git a/target/riscv/insn_trans/trans_rva.c.inc b/target/riscv/insn_trans/trans_rva.c.inc
> index 4a9e4591d1..eb080baddd 100644
> --- a/target/riscv/insn_trans/trans_rva.c.inc
> +++ b/target/riscv/insn_trans/trans_rva.c.inc
> @@ -103,6 +103,12 @@ static bool gen_amo(DisasContext *ctx, arg_atomic *a,
>       TCGv dest = dest_gpr(ctx, a->rd);
>       TCGv src1, src2 = get_gpr(ctx, a->rs2, EXT_NONE);
>   
> +    if (ctx->cfg_ptr->ext_zama16b) {
> +        mop |= MO_ATOM_WITHIN16;
> +    } else {
> +        mop |= MO_ALIGN;
> +    }
> +
>       decode_save_opc(ctx);
>       src1 = get_address(ctx, a->rs1, 0);
>       func(dest, src1, src2, ctx->mem_idx, mop);
> @@ -126,55 +132,55 @@ static bool trans_sc_w(DisasContext *ctx, arg_sc_w *a)
>   static bool trans_amoswap_w(DisasContext *ctx, arg_amoswap_w *a)
>   {
>       REQUIRE_A_OR_ZAAMO(ctx);
> -    return gen_amo(ctx, a, &tcg_gen_atomic_xchg_tl, (MO_ALIGN | MO_TESL));
> +    return gen_amo(ctx, a, &tcg_gen_atomic_xchg_tl, MO_TESL);
>   }
>   
>   static bool trans_amoadd_w(DisasContext *ctx, arg_amoadd_w *a)
>   {
>       REQUIRE_A_OR_ZAAMO(ctx);
> -    return gen_amo(ctx, a, &tcg_gen_atomic_fetch_add_tl, (MO_ALIGN | MO_TESL));
> +    return gen_amo(ctx, a, &tcg_gen_atomic_fetch_add_tl, MO_TESL);
>   }
>   
>   static bool trans_amoxor_w(DisasContext *ctx, arg_amoxor_w *a)
>   {
>       REQUIRE_A_OR_ZAAMO(ctx);
> -    return gen_amo(ctx, a, &tcg_gen_atomic_fetch_xor_tl, (MO_ALIGN | MO_TESL));
> +    return gen_amo(ctx, a, &tcg_gen_atomic_fetch_xor_tl, MO_TESL);
>   }
>   
>   static bool trans_amoand_w(DisasContext *ctx, arg_amoand_w *a)
>   {
>       REQUIRE_A_OR_ZAAMO(ctx);
> -    return gen_amo(ctx, a, &tcg_gen_atomic_fetch_and_tl, (MO_ALIGN | MO_TESL));
> +    return gen_amo(ctx, a, &tcg_gen_atomic_fetch_and_tl, MO_TESL);
>   }
>   
>   static bool trans_amoor_w(DisasContext *ctx, arg_amoor_w *a)
>   {
>       REQUIRE_A_OR_ZAAMO(ctx);
> -    return gen_amo(ctx, a, &tcg_gen_atomic_fetch_or_tl, (MO_ALIGN | MO_TESL));
> +    return gen_amo(ctx, a, &tcg_gen_atomic_fetch_or_tl, MO_TESL);
>   }
>   
>   static bool trans_amomin_w(DisasContext *ctx, arg_amomin_w *a)
>   {
>       REQUIRE_A_OR_ZAAMO(ctx);
> -    return gen_amo(ctx, a, &tcg_gen_atomic_fetch_smin_tl, (MO_ALIGN | MO_TESL));
> +    return gen_amo(ctx, a, &tcg_gen_atomic_fetch_smin_tl, MO_TESL);
>   }
>   
>   static bool trans_amomax_w(DisasContext *ctx, arg_amomax_w *a)
>   {
>       REQUIRE_A_OR_ZAAMO(ctx);
> -    return gen_amo(ctx, a, &tcg_gen_atomic_fetch_smax_tl, (MO_ALIGN | MO_TESL));
> +    return gen_amo(ctx, a, &tcg_gen_atomic_fetch_smax_tl, MO_TESL);
>   }
>   
>   static bool trans_amominu_w(DisasContext *ctx, arg_amominu_w *a)
>   {
>       REQUIRE_A_OR_ZAAMO(ctx);
> -    return gen_amo(ctx, a, &tcg_gen_atomic_fetch_umin_tl, (MO_ALIGN | MO_TESL));
> +    return gen_amo(ctx, a, &tcg_gen_atomic_fetch_umin_tl, MO_TESL);
>   }
>   
>   static bool trans_amomaxu_w(DisasContext *ctx, arg_amomaxu_w *a)
>   {
>       REQUIRE_A_OR_ZAAMO(ctx);
> -    return gen_amo(ctx, a, &tcg_gen_atomic_fetch_umax_tl, (MO_ALIGN | MO_TESL));
> +    return gen_amo(ctx, a, &tcg_gen_atomic_fetch_umax_tl, MO_TESL);
>   }
>   
>   static bool trans_lr_d(DisasContext *ctx, arg_lr_d *a)
> @@ -195,61 +201,61 @@ static bool trans_amoswap_d(DisasContext *ctx, arg_amoswap_d *a)
>   {
>       REQUIRE_64BIT(ctx);
>       REQUIRE_A_OR_ZAAMO(ctx);
> -    return gen_amo(ctx, a, &tcg_gen_atomic_xchg_tl, (MO_ALIGN | MO_TEUQ));
> +    return gen_amo(ctx, a, &tcg_gen_atomic_xchg_tl, MO_TEUQ);
>   }
>   
>   static bool trans_amoadd_d(DisasContext *ctx, arg_amoadd_d *a)
>   {
>       REQUIRE_64BIT(ctx);
>       REQUIRE_A_OR_ZAAMO(ctx);
> -    return gen_amo(ctx, a, &tcg_gen_atomic_fetch_add_tl, (MO_ALIGN | MO_TEUQ));
> +    return gen_amo(ctx, a, &tcg_gen_atomic_fetch_add_tl, MO_TEUQ);
>   }
>   
>   static bool trans_amoxor_d(DisasContext *ctx, arg_amoxor_d *a)
>   {
>       REQUIRE_64BIT(ctx);
>       REQUIRE_A_OR_ZAAMO(ctx);
> -    return gen_amo(ctx, a, &tcg_gen_atomic_fetch_xor_tl, (MO_ALIGN | MO_TEUQ));
> +    return gen_amo(ctx, a, &tcg_gen_atomic_fetch_xor_tl, MO_TEUQ);
>   }
>   
>   static bool trans_amoand_d(DisasContext *ctx, arg_amoand_d *a)
>   {
>       REQUIRE_64BIT(ctx);
>       REQUIRE_A_OR_ZAAMO(ctx);
> -    return gen_amo(ctx, a, &tcg_gen_atomic_fetch_and_tl, (MO_ALIGN | MO_TEUQ));
> +    return gen_amo(ctx, a, &tcg_gen_atomic_fetch_and_tl, MO_TEUQ);
>   }
>   
>   static bool trans_amoor_d(DisasContext *ctx, arg_amoor_d *a)
>   {
>       REQUIRE_64BIT(ctx);
>       REQUIRE_A_OR_ZAAMO(ctx);
> -    return gen_amo(ctx, a, &tcg_gen_atomic_fetch_or_tl, (MO_ALIGN | MO_TEUQ));
> +    return gen_amo(ctx, a, &tcg_gen_atomic_fetch_or_tl, MO_TEUQ);
>   }
>   
>   static bool trans_amomin_d(DisasContext *ctx, arg_amomin_d *a)
>   {
>       REQUIRE_64BIT(ctx);
>       REQUIRE_A_OR_ZAAMO(ctx);
> -    return gen_amo(ctx, a, &tcg_gen_atomic_fetch_smin_tl, (MO_ALIGN | MO_TEUQ));
> +    return gen_amo(ctx, a, &tcg_gen_atomic_fetch_smin_tl, MO_TEUQ);
>   }
>   
>   static bool trans_amomax_d(DisasContext *ctx, arg_amomax_d *a)
>   {
>       REQUIRE_64BIT(ctx);
>       REQUIRE_A_OR_ZAAMO(ctx);
> -    return gen_amo(ctx, a, &tcg_gen_atomic_fetch_smax_tl, (MO_ALIGN | MO_TEUQ));
> +    return gen_amo(ctx, a, &tcg_gen_atomic_fetch_smax_tl, MO_TEUQ);
>   }
>   
>   static bool trans_amominu_d(DisasContext *ctx, arg_amominu_d *a)
>   {
>       REQUIRE_64BIT(ctx);
>       REQUIRE_A_OR_ZAAMO(ctx);
> -    return gen_amo(ctx, a, &tcg_gen_atomic_fetch_umin_tl, (MO_ALIGN | MO_TEUQ));
> +    return gen_amo(ctx, a, &tcg_gen_atomic_fetch_umin_tl, MO_TEUQ);
>   }
>   
>   static bool trans_amomaxu_d(DisasContext *ctx, arg_amomaxu_d *a)
>   {
>       REQUIRE_64BIT(ctx);
>       REQUIRE_A_OR_ZAAMO(ctx);
> -    return gen_amo(ctx, a, &tcg_gen_atomic_fetch_umax_tl, (MO_ALIGN | MO_TEUQ));
> +    return gen_amo(ctx, a, &tcg_gen_atomic_fetch_umax_tl, MO_TEUQ);
>   }
> diff --git a/target/riscv/insn_trans/trans_rvd.c.inc b/target/riscv/insn_trans/trans_rvd.c.inc
> index d9ce9e407f..1f5fac65a2 100644
> --- a/target/riscv/insn_trans/trans_rvd.c.inc
> +++ b/target/riscv/insn_trans/trans_rvd.c.inc
> @@ -42,13 +42,18 @@
>   static bool trans_fld(DisasContext *ctx, arg_fld *a)
>   {
>       TCGv addr;
> +    MemOp memop = MO_TEUQ;
>   
>       REQUIRE_FPU;
>       REQUIRE_EXT(ctx, RVD);
>   
> +    if (ctx->cfg_ptr->ext_zama16b && (ctx->cur_insn_len != 2)) {
> +        memop |= MO_ATOM_WITHIN16;
> +    }
> +
>       decode_save_opc(ctx);
>       addr = get_address(ctx, a->rs1, a->imm);
> -    tcg_gen_qemu_ld_i64(cpu_fpr[a->rd], addr, ctx->mem_idx, MO_TEUQ);
> +    tcg_gen_qemu_ld_i64(cpu_fpr[a->rd], addr, ctx->mem_idx, memop);
>   
>       mark_fs_dirty(ctx);
>       return true;
> @@ -57,13 +62,18 @@ static bool trans_fld(DisasContext *ctx, arg_fld *a)
>   static bool trans_fsd(DisasContext *ctx, arg_fsd *a)
>   {
>       TCGv addr;
> +    MemOp memop = MO_TEUQ;
>   
>       REQUIRE_FPU;
>       REQUIRE_EXT(ctx, RVD);
>   
> +    if (ctx->cfg_ptr->ext_zama16b && (ctx->cur_insn_len != 2)) {
> +        memop |= MO_ATOM_WITHIN16;
> +    }
> +
>       decode_save_opc(ctx);
>       addr = get_address(ctx, a->rs1, a->imm);
> -    tcg_gen_qemu_st_i64(cpu_fpr[a->rs2], addr, ctx->mem_idx, MO_TEUQ);
> +    tcg_gen_qemu_st_i64(cpu_fpr[a->rs2], addr, ctx->mem_idx, memop);
>       return true;
>   }
>   
> diff --git a/target/riscv/insn_trans/trans_rvf.c.inc b/target/riscv/insn_trans/trans_rvf.c.inc
> index 97a368970b..f771aa1939 100644
> --- a/target/riscv/insn_trans/trans_rvf.c.inc
> +++ b/target/riscv/insn_trans/trans_rvf.c.inc
> @@ -43,14 +43,19 @@ static bool trans_flw(DisasContext *ctx, arg_flw *a)
>   {
>       TCGv_i64 dest;
>       TCGv addr;
> +    MemOp memop = MO_TEUL;
>   
>       REQUIRE_FPU;
>       REQUIRE_EXT(ctx, RVF);
>   
> +    if (ctx->cfg_ptr->ext_zama16b && (ctx->cur_insn_len != 2)) {
> +        memop |= MO_ATOM_WITHIN16;
> +    }
> +
>       decode_save_opc(ctx);
>       addr = get_address(ctx, a->rs1, a->imm);
>       dest = cpu_fpr[a->rd];
> -    tcg_gen_qemu_ld_i64(dest, addr, ctx->mem_idx, MO_TEUL);
> +    tcg_gen_qemu_ld_i64(dest, addr, ctx->mem_idx, memop);
>       gen_nanbox_s(dest, dest);
>   
>       mark_fs_dirty(ctx);
> @@ -60,13 +65,18 @@ static bool trans_flw(DisasContext *ctx, arg_flw *a)
>   static bool trans_fsw(DisasContext *ctx, arg_fsw *a)
>   {
>       TCGv addr;
> +    MemOp memop = MO_TEUL;
>   
>       REQUIRE_FPU;
>       REQUIRE_EXT(ctx, RVF);
>   
> +    if (ctx->cfg_ptr->ext_zama16b && (ctx->cur_insn_len != 2)) {
> +        memop |= MO_ATOM_WITHIN16;
> +    }
> +
>       decode_save_opc(ctx);
>       addr = get_address(ctx, a->rs1, a->imm);
> -    tcg_gen_qemu_st_i64(cpu_fpr[a->rs2], addr, ctx->mem_idx, MO_TEUL);
> +    tcg_gen_qemu_st_i64(cpu_fpr[a->rs2], addr, ctx->mem_idx, memop);
>       return true;
>   }
>   
> diff --git a/target/riscv/insn_trans/trans_rvi.c.inc b/target/riscv/insn_trans/trans_rvi.c.inc
> index ad40d3e87f..98e3806d5e 100644
> --- a/target/riscv/insn_trans/trans_rvi.c.inc
> +++ b/target/riscv/insn_trans/trans_rvi.c.inc
> @@ -268,6 +268,9 @@ static bool gen_load(DisasContext *ctx, arg_lb *a, MemOp memop)
>   {
>       bool out;
>   
> +    if (ctx->cfg_ptr->ext_zama16b && (ctx->cur_insn_len != 2)) {
> +        memop |= MO_ATOM_WITHIN16;
> +    }
>       decode_save_opc(ctx);
>       if (get_xl(ctx) == MXL_RV128) {
>           out = gen_load_i128(ctx, a, memop);
> @@ -366,6 +369,9 @@ static bool gen_store_i128(DisasContext *ctx, arg_sb *a, MemOp memop)
>   
>   static bool gen_store(DisasContext *ctx, arg_sb *a, MemOp memop)
>   {
> +    if (ctx->cfg_ptr->ext_zama16b && (ctx->cur_insn_len != 2)) {
> +        memop |= MO_ATOM_WITHIN16;
> +    }
>       decode_save_opc(ctx);
>       if (get_xl(ctx) == MXL_RV128) {
>           return gen_store_i128(ctx, a, memop);

