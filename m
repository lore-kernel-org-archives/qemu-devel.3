Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 295A8C3DA4A
	for <qemu-devel@archiver.kernel.org>; Fri, 16 Aug 2024 08:03:05 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1seruv-00076y-Ft; Fri, 16 Aug 2024 04:02:37 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1serur-0006rl-D1
 for qemu-devel@nongnu.org; Fri, 16 Aug 2024 04:02:33 -0400
Received: from mail-pf1-x42a.google.com ([2607:f8b0:4864:20::42a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1seruo-0001F3-46
 for qemu-devel@nongnu.org; Fri, 16 Aug 2024 04:02:32 -0400
Received: by mail-pf1-x42a.google.com with SMTP id
 d2e1a72fcca58-70d28023accso1415433b3a.0
 for <qemu-devel@nongnu.org>; Fri, 16 Aug 2024 01:02:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1723795348; x=1724400148; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=Z8Tf22oh1HWXKf+rR0psvsCQgJ47U0kWHgJNG8KQ37E=;
 b=SHyY8UuCsT3WQd3eHzgT85GcWnVOxpfxri4F7Yc5Ge4oS2g4VtNfDPHQRLmd3vvzsY
 INaqZLQNOi26fyBntqAyz1McCKyMnLOTYp79EeJnMEM/rqKukxSsAxQt2oEInjuq2rxj
 lGdXBkY+6fhyu2AicYFYL1LYSAmD7MdyXN1/nEEd9gUgYSSNmq9vn33BjRmCaMcRMxwQ
 4fNwss6rNiSXx/jVtFCioRicq70aw8+BMH37PaDamhIxIsr8mBxgZe5ZPiAEMDFeAcbs
 Un7nNpbaxr51JGtjq7RqRVannrFKF64oQLZbEMU2MRIjCtD8DK2jc1gGw3R/PD4TTu32
 4qKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1723795348; x=1724400148;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=Z8Tf22oh1HWXKf+rR0psvsCQgJ47U0kWHgJNG8KQ37E=;
 b=fOu/x86KsyL9lK7kqlMQ3aZYm8CV9IaAkS0i9B5//K80ZXTV35HKyla3N9wXMqqbbz
 t8n1/gnvpp6EEuscwlmw33XIS/42yOEHH7LkiKK8TUW2FVODpSRr3XokaK9f2X/Bz3L6
 MLAjjkcky6Y/r1SVDmGp3Ia8jh88GX3WGrQK3sbuxfib/4u1/WOR7+/DUBnVSKxHnQ5y
 AzcB9Bo2zR9Z36SoskucQwgmAyFcCLyu7fMzUnOyYSGEL53kTk7khNr67j94ewtO+05M
 D5AvHnWImyjP/h18d36Kasleo0AqofgaXSdhsxqxJp+10KjiaSy7p98WxK/j0wbyO5Sn
 A6gQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCXzSFwSAFvkV8Nvt+yx9u6RQs/elGvarSsgAmN+TVvmKaX9L2e4T513NMQEmAR0IwtChurSeZeNcT5+w6xJufgyMwiNOcI=
X-Gm-Message-State: AOJu0YyTOPiVZexbCjeIcL7+AfTbhvX4+mAGmBWCRqus3qUwm7zEhaEA
 741dPWH/PYSpVlHM61Dz1i0WxXRJ6kOal5Y4BRiv/wqbUMUp2/vuCoK//gBDIU4IDEiSCipvn11
 P9pA=
X-Google-Smtp-Source: AGHT+IHMRCjkiw9LGy1QfRGv/Iax7bTEerZtgx1Om2AqPN2PG7K/4Xh7kwTaSLtVcy34Lh8XaxCm/w==
X-Received: by 2002:a05:6a00:13a7:b0:70d:2e7e:1853 with SMTP id
 d2e1a72fcca58-713c5030772mr2431248b3a.19.1723795347436; 
 Fri, 16 Aug 2024 01:02:27 -0700 (PDT)
Received: from ?IPV6:2403:580a:f89b:0:1b6b:8c7b:90f9:144f?
 (2403-580a-f89b-0-1b6b-8c7b-90f9-144f.ip6.aussiebb.net.
 [2403:580a:f89b:0:1b6b:8c7b:90f9:144f])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-7127ae07583sm2134649b3a.60.2024.08.16.01.02.25
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 16 Aug 2024 01:02:27 -0700 (PDT)
Message-ID: <4ba8985c-7cc6-45aa-9635-176972525496@linaro.org>
Date: Fri, 16 Aug 2024 18:02:21 +1000
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH qemu v4 1/1] target/riscv: Add Zilsd and Zclsd extension
 support
To: ~liuxu <liuxu@nucleisys.com>, qemu-devel@nongnu.org
Cc: Alistair Francis <alistair23@gmail.com>
References: <172379341272.30818.9359380874395527120-1@git.sr.ht>
Content-Language: en-US
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <172379341272.30818.9359380874395527120-1@git.sr.ht>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::42a;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x42a.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

On 8/16/24 16:41, ~liuxu wrote:
> From: lxx <1733205434@qq.com>
> 
> This patch adds support for the Zilsd and Zclsd extension,
> which is documented at https://github.com/riscv/riscv-zilsd/releases/tag/v0.9.0
> 
> Co-developed-by: SUN Dongya <sundongya@nucleisys.com>
> Co-developed-by: LIU Xu <liuxu@nucleisys.com>
> Co-developed-by: ZHAO Fujin <zhaofujin@nucleisys.com>
> ---
>   target/riscv/cpu.c                        |   4 +
>   target/riscv/cpu_cfg.h                    |   2 +
>   target/riscv/insn16.decode                |   8 ++
>   target/riscv/insn32.decode                |  12 +-
>   target/riscv/insn_trans/trans_zilsd.c.inc | 128 ++++++++++++++++++++++
>   target/riscv/tcg/tcg-cpu.c                |  16 +++
>   target/riscv/translate.c                  |   1 +
>   7 files changed, 169 insertions(+), 2 deletions(-)
>   create mode 100644 target/riscv/insn_trans/trans_zilsd.c.inc
> 
> diff --git a/target/riscv/cpu.c b/target/riscv/cpu.c
> index 36e3e5fdaf..be9746d361 100644
> --- a/target/riscv/cpu.c
> +++ b/target/riscv/cpu.c
> @@ -113,6 +113,7 @@ const RISCVIsaExtData isa_edata_arr[] = {
>       ISA_EXT_DATA_ENTRY(zihintntl, PRIV_VERSION_1_10_0, ext_zihintntl),
>       ISA_EXT_DATA_ENTRY(zihintpause, PRIV_VERSION_1_10_0, ext_zihintpause),
>       ISA_EXT_DATA_ENTRY(zihpm, PRIV_VERSION_1_12_0, ext_zihpm),
> +    ISA_EXT_DATA_ENTRY(zilsd, PRIV_VERSION_1_12_0, ext_zilsd),
>       ISA_EXT_DATA_ENTRY(zmmul, PRIV_VERSION_1_12_0, ext_zmmul),
>       ISA_EXT_DATA_ENTRY(za64rs, PRIV_VERSION_1_12_0, has_priv_1_11),
>       ISA_EXT_DATA_ENTRY(zaamo, PRIV_VERSION_1_12_0, ext_zaamo),
> @@ -132,6 +133,7 @@ const RISCVIsaExtData isa_edata_arr[] = {
>       ISA_EXT_DATA_ENTRY(zce, PRIV_VERSION_1_12_0, ext_zce),
>       ISA_EXT_DATA_ENTRY(zcmp, PRIV_VERSION_1_12_0, ext_zcmp),
>       ISA_EXT_DATA_ENTRY(zcmt, PRIV_VERSION_1_12_0, ext_zcmt),
> +    ISA_EXT_DATA_ENTRY(zclsd, PRIV_VERSION_1_12_0, ext_zclsd),
>       ISA_EXT_DATA_ENTRY(zba, PRIV_VERSION_1_12_0, ext_zba),
>       ISA_EXT_DATA_ENTRY(zbb, PRIV_VERSION_1_12_0, ext_zbb),
>       ISA_EXT_DATA_ENTRY(zbc, PRIV_VERSION_1_12_0, ext_zbc),
> @@ -1492,6 +1494,7 @@ const RISCVCPUMultiExtConfig riscv_cpu_extensions[] = {
>   
>       MULTI_EXT_CFG_BOOL("zicntr", ext_zicntr, true),
>       MULTI_EXT_CFG_BOOL("zihpm", ext_zihpm, true),
> +    MULTI_EXT_CFG_BOOL("zilsd", ext_zilsd, false),
>   
>       MULTI_EXT_CFG_BOOL("zba", ext_zba, true),
>       MULTI_EXT_CFG_BOOL("zbb", ext_zbb, true),
> @@ -1531,6 +1534,7 @@ const RISCVCPUMultiExtConfig riscv_cpu_extensions[] = {
>       MULTI_EXT_CFG_BOOL("zcmp", ext_zcmp, false),
>       MULTI_EXT_CFG_BOOL("zcmt", ext_zcmt, false),
>       MULTI_EXT_CFG_BOOL("zicond", ext_zicond, false),
> +    MULTI_EXT_CFG_BOOL("zclsd", ext_zclsd, false),
>   
>       /* Vector cryptography extensions */
>       MULTI_EXT_CFG_BOOL("zvbb", ext_zvbb, false),
> diff --git a/target/riscv/cpu_cfg.h b/target/riscv/cpu_cfg.h
> index cb750154bd..76ae1e95d7 100644
> --- a/target/riscv/cpu_cfg.h
> +++ b/target/riscv/cpu_cfg.h
> @@ -51,6 +51,7 @@ struct RISCVCPUConfig {
>       bool ext_zcf;
>       bool ext_zcmp;
>       bool ext_zcmt;
> +    bool ext_zclsd;
>       bool ext_zk;
>       bool ext_zkn;
>       bool ext_zknd;
> @@ -71,6 +72,7 @@ struct RISCVCPUConfig {
>       bool ext_zihintntl;
>       bool ext_zihintpause;
>       bool ext_zihpm;
> +    bool ext_zilsd;
>       bool ext_ztso;
>       bool ext_smstateen;
>       bool ext_sstc;
> diff --git a/target/riscv/insn16.decode b/target/riscv/insn16.decode
> index b96c534e73..726666fc0e 100644
> --- a/target/riscv/insn16.decode
> +++ b/target/riscv/insn16.decode
> @@ -130,10 +130,14 @@ sw                110  ... ... .. ... 00 @cs_w
>   {
>     ld              011  ... ... .. ... 00 @cl_d
>     c_flw           011  ... ... .. ... 00 @cl_w
> +  # *** Zclsd Extension ***
> +  zclsd_ld        011  ... ... .. ... 00 @cl_d
>   }
>   {
>     sd              111  ... ... .. ... 00 @cs_d
>     c_fsw           111  ... ... .. ... 00 @cs_w
> +  # *** Zclsd Extension ***
> +  zclsd_sd        111  ... ... .. ... 00 @cs_d
>   }
>   
>   # *** RV32/64C Standard Extension (Quadrant 1) ***
> @@ -207,10 +211,14 @@ sw                110 .  .....  ..... 10 @c_swsp
>     c64_illegal     011 -  00000  ----- 10 # c.ldsp, RES rd=0
>     ld              011 .  .....  ..... 10 @c_ldsp
>     c_flw           011 .  .....  ..... 10 @c_lwsp
> +  # *** Zclsd Extension ***
> +  zclsd_ldsp      011 .  .....  ..... 10 @c_ldsp
>   }
>   {
>     sd              111 .  .....  ..... 10 @c_sdsp
>     c_fsw           111 .  .....  ..... 10 @c_swsp
> +  # *** Zclsd Extension ***
> +  zclsd_sdsp      111 .  .....  ..... 10 @c_sdsp
>   }
>   
>   # *** RV64 and RV32 Zcb Extension ***
> diff --git a/target/riscv/insn32.decode b/target/riscv/insn32.decode
> index f22df04cfd..f6f4b7950b 100644
> --- a/target/riscv/insn32.decode
> +++ b/target/riscv/insn32.decode
> @@ -169,8 +169,16 @@ csrrci   ............     ..... 111 ..... 1110011 @csr
>   
>   # *** RV64I Base Instruction Set (in addition to RV32I) ***
>   lwu      ............   ..... 110 ..... 0000011 @i
> -ld       ............   ..... 011 ..... 0000011 @i
> -sd       ....... .....  ..... 011 ..... 0100011 @s
> +{
> +  ld       ............   ..... 011 ..... 0000011 @i
> +  # *** Zilsd instructions ***
> +  zilsd_ld ............   ..... 011 ..... 0000011 @i
> +}
> +{
> +  sd       ....... .....  ..... 011 ..... 0100011 @s
> +  # *** Zilsd instructions ***
> +  zilsd_sd ....... .....  ..... 011 ..... 0100011 @s
> +}
>   addiw    ............   ..... 000 ..... 0011011 @i
>   slliw    0000000 .....  ..... 001 ..... 0011011 @sh5
>   srliw    0000000 .....  ..... 101 ..... 0011011 @sh5
> diff --git a/target/riscv/insn_trans/trans_zilsd.c.inc b/target/riscv/insn_trans/trans_zilsd.c.inc
> new file mode 100644
> index 0000000000..33985ccbc3
> --- /dev/null
> +++ b/target/riscv/insn_trans/trans_zilsd.c.inc
> @@ -0,0 +1,128 @@
> +/*
> + * RISC-V translation routines for the Zilsd & Zclsd Extension.
> + *
> + * Copyright (c) 2024 Nucleisys, Inc.
> + *
> + * This program is free software; you can redistribute it and/or modify it
> + * under the terms and conditions of the GNU General Public License,
> + * version 2 or later, as published by the Free Software Foundation.
> + *
> + * This program is distributed in the hope it will be useful, but WITHOUT
> + * ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or
> + * FITNESS FOR A PARTICULAR PURPOSE.  See the GNU General Public License for
> + * more details.
> + *
> + * You should have received a copy of the GNU General Public License along with
> + * this program.  If not, see <http://www.gnu.org/licenses/>.
> + */
> +
> +#define REQUIRE_ZILSD(ctx) do {    \
> +    if (!ctx->cfg_ptr->ext_zilsd)  \
> +        return false;              \
> +} while (0)
> +
> +#define REQUIRE_ZCLSD(ctx) do {    \
> +    if (!ctx->cfg_ptr->ext_zclsd)  \
> +        return false;              \
> +} while (0)
> +
> +static bool gen_load_i64(DisasContext *ctx, arg_ld *a)
> +{
> +    if ((a->rd) % 2) {
> +        return false;
> +    }
> +
> +    TCGv dest_low = dest_gpr(ctx, a->rd);
> +    TCGv dest_high = dest_gpr(ctx, a->rd + 1);
> +    TCGv addr = get_address(ctx, a->rs1, a->imm);
> +    TCGv_i64 tmp = tcg_temp_new_i64();
> +
> +    tcg_gen_qemu_ld_i64(tmp, addr, ctx->mem_idx, MO_TESQ);
> +    tcg_gen_extr_i64_tl(dest_low, dest_high, tmp);
> +
> +    gen_set_gpr(ctx, a->rd, dest_low);
> +    gen_set_gpr(ctx, a->rd + 1, dest_high);
> +
> +    return true;
> +}
> +
> +static bool trans_zilsd_ld(DisasContext *ctx, arg_zilsd_ld *a)
> +{
> +    REQUIRE_32BIT(ctx);
> +    REQUIRE_ZILSD(ctx);
> +
> +    if (a->rd == 0) {
> +        return true;
> +    }

I believe the load is still supposed to happen, triggering any faults, but the result is 
not recorded.  Thus, in gen_load_i64, skip the writeback.

> +static bool trans_zclsd_ld(DisasContext *ctx, arg_zclsd_ld *a)
> +{
> +    REQUIRE_32BIT(ctx);
> +    REQUIRE_ZCLSD(ctx);
> +
> +    if (a->rd == 0) {
> +        return true;
> +    }

Likewise.

> +static bool gen_store_i64(DisasContext *ctx, arg_sd *a)
> +{
> +    if ((a->rs2) % 2) {
> +        return false;
> +    }
> +    if (a->rs2 == 0) {
> +        TCGv data = get_gpr(ctx, a->rs2, EXT_NONE);
> +        TCGv addr = get_address(ctx, a->rs1, a->imm);
> +        TCGv_i64 tmp = tcg_temp_new_i64();
> +
> +        tcg_gen_ext_tl_i64(tmp, data);
> +        tcg_gen_qemu_st_i64(tmp, addr, ctx->mem_idx, MO_TESQ);

Don't read and extend r0 this way.
Skip straight to the result:

   tmp = tcg_constant_i64(0);

> +    TCGv data_low = get_gpr(ctx, a->rs2, EXT_NONE);
> +    TCGv data_high = get_gpr(ctx, a->rs2 + 1, EXT_NONE);
> +    TCGv addr = get_address(ctx, a->rs1, a->imm);
> +    TCGv_i64 tmp = tcg_temp_new_i64();
> +
> +    tcg_gen_concat_tl_i64(tmp, data_low, data_high);

Put this in an else...

> +    tcg_gen_qemu_st_i64(tmp, addr, ctx->mem_idx, MO_TESQ);

and sink this out of both branches.

> +
> +    return true;
> +}
> +
> +static bool trans_zilsd_sd(DisasContext *ctx, arg_zilsd_sd *a)
> +{
> +    REQUIRE_32BIT(ctx);
> +    REQUIRE_ZILSD(ctx);
> +    return gen_store_i64(ctx, a);
> +}
> +
> +static bool trans_zclsd_sdsp(DisasContext *ctx, arg_zclsd_sdsp *a)
> +{
> +    REQUIRE_32BIT(ctx);
> +    REQUIRE_ZCLSD(ctx);
> +    return gen_store_i64(ctx, a);
> +}
> +
> +static bool trans_zclsd_sd(DisasContext *ctx, arg_zclsd_sd *a)
> +{
> +    REQUIRE_32BIT(ctx);
> +    REQUIRE_ZCLSD(ctx);
> +    return gen_store_i64(ctx, a);
> +}

c_sdsp and c_sd are identical and should share a trans_* function.
A comment is sufficient to distinguish in the decode file.


r~

