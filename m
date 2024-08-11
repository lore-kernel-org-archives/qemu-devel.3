Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5A49CC52D7F
	for <qemu-devel@archiver.kernel.org>; Sun, 11 Aug 2024 21:37:32 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sdGFA-0005Us-P3; Sun, 11 Aug 2024 17:36:52 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1sdGF7-0005UI-U0
 for qemu-devel@nongnu.org; Sun, 11 Aug 2024 17:36:50 -0400
Received: from mail-ot1-x332.google.com ([2607:f8b0:4864:20::332])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1sdGF5-00042i-4L
 for qemu-devel@nongnu.org; Sun, 11 Aug 2024 17:36:48 -0400
Received: by mail-ot1-x332.google.com with SMTP id
 46e09a7af769-70943b07c2cso2404713a34.1
 for <qemu-devel@nongnu.org>; Sun, 11 Aug 2024 14:36:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1723412206; x=1724017006; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=342OA3gdy1M7THNu6AGQ4PvgvaGCStGPq0UcEfUofK4=;
 b=kxGMTLeznRTji3w819NF9T2YC/lKKKMmdsHwuJtgrKncvaLwCUcOOZACbxwErulEwz
 9LLFSeseko/Nj1v8D4wDUyd59hHcuI03Uv7cbSYfgRYyo9OBElPYppqEJS9Nlt7iOHFs
 Kk+b9aVcM4J2SReiXxYpo7JtbG6OXdFjhKeSZvrOyi81SPiRjxZXU2VoQfZOuEV/UW2E
 0YH/ha/iXm8vJfdm9KiC5YS0jnS4x/hYk/leOeIE8vzOx4yTHA+/bl06Ey/sswE5wkkH
 ZgDhIZKjRFTmUeSkiop8/pETyjRc802ldO7n6Ur4XcO6cN/r+AIrHf7caAeZRRuJniKh
 EukQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1723412206; x=1724017006;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=342OA3gdy1M7THNu6AGQ4PvgvaGCStGPq0UcEfUofK4=;
 b=RyTC1su5wfAe5Srp68g028lD2udfdDtuKV/W5AgDfwabtseH76xYul72EJpKyA8V0F
 f1ejwEdpX682x+Gp3jMbO2OvdxRTqb2EO1mlrlfOYQ8C6v5tr/IMs9h0fLJHBKQAlLgn
 j4v0qAT9GGFaazw9FVp/iR054T6Qs85uQUZgWkVKrsm047OFPHhLi2O+/owzi1hMc0cX
 bCRfYEm6WtQJYcJPmGfskkgUkFNxjwLMtsk4kRynHbrb3VAvaKmL53IQaqNGZ/YLDNMw
 PVDDnB/snrJIkWX2n7RA9ElsA/yOMWD4lNe7DRAoV54as6q04G70KQj6OrO6LyaiAYB6
 djmg==
X-Forwarded-Encrypted: i=1;
 AJvYcCXhnJMlTTAFkf3hqL22oCvaHEaFmeo9VOci8C+oX5Al8U3lTK41tvJIvVyBiJVRUY9x4tTpD1+iL2N8ifFjDY9Ml8U94JY=
X-Gm-Message-State: AOJu0YxcnX26/lF2l5QIyZBkP9zZgMKO21WB1B6f3j6HaILvEMhVJRXf
 2jufc1R8X2tNRKwmBkagLipuSv5KZvU0Zk2ss3zNDqg27xGbhLnYkzhEhgX4fjk=
X-Google-Smtp-Source: AGHT+IFZAy+zLdm5vHMuqhz9RCQkE9A12U+nPpV6lb9edqLQ7KVQv9P0nZx0n106ZThwd7vKa2nKNQ==
X-Received: by 2002:a05:6830:2d8c:b0:709:4060:1093 with SMTP id
 46e09a7af769-70b74874142mr10037795a34.22.1723412205809; 
 Sun, 11 Aug 2024 14:36:45 -0700 (PDT)
Received: from [192.168.1.113] ([203.30.4.111])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-2d1fcfed6c1sm3495234a91.36.2024.08.11.14.36.43
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sun, 11 Aug 2024 14:36:45 -0700 (PDT)
Message-ID: <f7996a2f-3002-4399-9963-2b3f941b4b26@linaro.org>
Date: Sun, 11 Aug 2024 14:12:41 +1000
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH qemu v3 1/1] target/riscv: Add Zilsd and Zclsd extension
 support
To: ~liuxu <liuxu@nucleisys.com>, qemu-devel@nongnu.org
Cc: Alistair Francis <alistair23@gmail.com>
References: <172319759236.18926.5462684264176580538-1@git.sr.ht>
Content-Language: en-US
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <172319759236.18926.5462684264176580538-1@git.sr.ht>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::332;
 envelope-from=richard.henderson@linaro.org; helo=mail-ot1-x332.google.com
X-Spam_score_int: -10
X-Spam_score: -1.1
X-Spam_bar: -
X-Spam_report: (-1.1 / 5.0 requ) BAYES_00=-1.9, DATE_IN_PAST_12_24=1.049,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=no autolearn_force=no
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

On 7/31/24 13:22, ~liuxu wrote:
> From: lxx <1733205434@qq.com>
> 
> This patch adds support for the Zilsd and Zclsd extension,
> which is documented at https://github.com/riscv/riscv-zilsd/releases/tag/v0.9.0
> 
> Co-developed-by: SUN Dongya <sundongya@nucleisys.com>
> Co-developed-by: LIU Xu <liuxu@nucleisys.com>
> Co-developed-by: ZHAO Fujin <zhaofujin@nucleisys.com>
> ---
>   target/riscv/cpu.c                        |  4 +
>   target/riscv/cpu_cfg.h                    |  2 +
>   target/riscv/insn16.decode                |  8 ++
>   target/riscv/insn32.decode                | 12 ++-
>   target/riscv/insn_trans/trans_zclsd.c.inc | 99 +++++++++++++++++++++++
>   target/riscv/insn_trans/trans_zilsd.c.inc | 89 ++++++++++++++++++++
>   target/riscv/tcg/tcg-cpu.c                | 16 ++++
>   target/riscv/translate.c                  |  2 +
>   8 files changed, 230 insertions(+), 2 deletions(-)
>   create mode 100644 target/riscv/insn_trans/trans_zclsd.c.inc
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
> diff --git a/target/riscv/insn_trans/trans_zclsd.c.inc b/target/riscv/insn_trans/trans_zclsd.c.inc
> new file mode 100644
> index 0000000000..657584aca0
> --- /dev/null
> +++ b/target/riscv/insn_trans/trans_zclsd.c.inc
> @@ -0,0 +1,99 @@
> +/*
> + * RISC-V translation routines for the Zclsd Extension.
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
> +#define REQUIRE_ZCLSD(ctx) do {    \
> +    if (!ctx->cfg_ptr->ext_zclsd)  \
> +        return false;              \
> +} while (0)
> +
> +static bool gen_c_load_i64(DisasContext *ctx, arg_lb *a, bool is_ldsp)
> +{
> +    REQUIRE_ZCLSD(ctx);
> +    REQUIRE_32BIT(ctx);
> +
> +    if ((a->rd) % 2) {
> +        return false;
> +    }
> +
> +    if (a->rd == 0) {
> +        return is_ldsp ? false : true;
> +    }
> +
> +    TCGv dest_low = dest_gpr(ctx, a->rd);
> +    TCGv dest_high = dest_gpr(ctx, a->rd + 1);
> +    TCGv addr = get_address(ctx, a->rs1, a->imm);
> +    TCGv_i64 tmp = tcg_temp_new_i64();
> +
> +    tcg_gen_qemu_ld_i64(tmp, addr, ctx->mem_idx, MO_TESQ);
> +    tcg_gen_extr_i64_tl(dest_low, dest_high, tmp);
> +    gen_set_gpr(ctx, a->rd, dest_low);
> +    gen_set_gpr(ctx, a->rd + 1, dest_high);
> +
> +    return true;
> +}

First, you should not separate zclsd from zilsd.
This duplicates the gen_load_i64 function for no reason.

> +
> +static bool trans_zclsd_ldsp(DisasContext *ctx, arg_zclsd_ldsp *a)
> +{

The check for rd == 0 belongs here, not via a parameter to another function.
The REQUIRE_ZCLDSD check can go here...

> +    return gen_c_load_i64(ctx, a, true);
> +}
> +
> +static bool trans_zclsd_ld(DisasContext *ctx, arg_zclsd_ld *a)
> +{

... and here.

> +static bool gen_c_store_i64(DisasContext *ctx, arg_sb *a)
> +{
> +    REQUIRE_ZCLSD(ctx);
> +    REQUIRE_32BIT(ctx);

Similarly.


r~

