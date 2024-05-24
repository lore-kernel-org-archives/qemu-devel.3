Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CC3F1C25B74
	for <qemu-devel@archiver.kernel.org>; Fri, 24 May 2024 09:48:00 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sARVi-0003Pg-0O; Fri, 24 May 2024 05:46:50 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dbarboza@ventanamicro.com>)
 id 1sARVg-0003PD-PL
 for qemu-devel@nongnu.org; Fri, 24 May 2024 05:46:48 -0400
Received: from mail-pl1-x630.google.com ([2607:f8b0:4864:20::630])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <dbarboza@ventanamicro.com>)
 id 1sARVe-0002nA-BT
 for qemu-devel@nongnu.org; Fri, 24 May 2024 05:46:48 -0400
Received: by mail-pl1-x630.google.com with SMTP id
 d9443c01a7336-1f332511457so5756355ad.2
 for <qemu-devel@nongnu.org>; Fri, 24 May 2024 02:46:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=ventanamicro.com; s=google; t=1716544004; x=1717148804; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=2lfXR6QCwoyV9M+9/1P28Lh1+2iSol7vJwQ5+ilCIB8=;
 b=QqlFNtB9/UbZcT0Jot0aVfplZRlpKvpq+qLgalmF0CmcEVKkaAzLOPB15HJVOcPV4j
 zqGx87cNKTDcV7MzYzH5rN2xJqLkitLrrUA8f1zXpvYyT8tI6So5fOIOJtz//5EVZIel
 04Piy2P6QStRZdN+GYj7UVNVb1EOwlLJaIdzErAcUexngqZG9Ae83AeOmTVmWie4VRFK
 f+kJh538C1V1szo2OSqkKpM4SHyVt3pgsMT0KRYUcnBX2E9R6W9YkIniUCxF1qqqCWJf
 6QW/acY8IFmy4VnAVhuyG+PSCZ0wwY4gZFPoO7MijrkBEMkWE16c5anjUyHZXGK2sWVy
 st5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1716544004; x=1717148804;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=2lfXR6QCwoyV9M+9/1P28Lh1+2iSol7vJwQ5+ilCIB8=;
 b=Z+2VGOW9Q6YsYHwoVDJFzgZJILrHgb4+0kxPzGbGwyxYTVR6ZUF7Oa1pR7VOuaTwCP
 JzuzpVAFpPo+O1emOvD44+ThCDmfPb7ztQfMspBvM8nxTW39IU1RpbCYqcdcRh2dqebp
 affZSye7FrYzh0LzgQbXHHrE8QaFXs16uEjpbSC2TgT5o98DQzCK8zMkE1Xib5dnBVjz
 8GyADp1ZAeNVrmbcyZdoS0cdT7zDFDg6oLT4bOcmS90WZ4lDPi4Gn+CVtkqV70w/XNO6
 0XaWH3uIgH6j485L/7KZuLX1pYWe8VJnJB5VHLHL9l2h0yePZR6eN0fZT7rdY31+g6kW
 F9sA==
X-Forwarded-Encrypted: i=1;
 AJvYcCVt9LYeRWeSi5xnRKbP6X1w/9h5Eiu/b6BOpDHV4/KwRKmcd2VH6VJjZ1kbFLSB7yt1HQq5qHneyN8raXZ9ICUCN5WnQF4=
X-Gm-Message-State: AOJu0YyHuvlWQ6Ffn7qm202nG81ZBj+ntJL022no5gn692eIZwIzVFyo
 FQdnPo0p4fMv1RovTQzJP9znazXqk4xiLOqbvmmlUJUp1Fj2NGFuPu38RhyNJVFHrFStjVcZqrO
 s
X-Google-Smtp-Source: AGHT+IEIE9NjFXWobXVDn0JDLdC3Q9yvIVrlpA1ur42RtAVqjSZem/tcVYM4dDJNYClJXL+MrnjTRg==
X-Received: by 2002:a17:902:f9c3:b0:1f3:26e2:cf9f with SMTP id
 d9443c01a7336-1f44872cf54mr15598065ad.23.1716544003722; 
 Fri, 24 May 2024 02:46:43 -0700 (PDT)
Received: from [192.168.68.110] ([177.94.42.4])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-1f44c9ba3f5sm9841735ad.265.2024.05.24.02.46.40
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 24 May 2024 02:46:42 -0700 (PDT)
Message-ID: <05cbd3c7-cf62-4a17-91a6-b73e3ff3ad04@ventanamicro.com>
Date: Fri, 24 May 2024 06:46:38 -0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/4] target/riscv: Add zimop extension
To: LIU Zhiwei <zhiwei_liu@linux.alibaba.com>, qemu-devel@nongnu.org
Cc: qemu-riscv@nongnu.org, palmer@dabbelt.com, Alistair.Francis@wdc.com,
 bmeng.cn@gmail.com, iwei1518@gmail.com
References: <20240522062905.1799-1-zhiwei_liu@linux.alibaba.com>
 <20240522062905.1799-2-zhiwei_liu@linux.alibaba.com>
Content-Language: en-US
From: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
In-Reply-To: <20240522062905.1799-2-zhiwei_liu@linux.alibaba.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::630;
 envelope-from=dbarboza@ventanamicro.com; helo=mail-pl1-x630.google.com
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



On 5/22/24 03:29, LIU Zhiwei wrote:
> Zimop extension defines an encoding space for 40 MOPs.The Zimop
> extension defines 32 MOP instructions named MOP.R.n, where n is
> an integer between 0 and 31, inclusive. The Zimop extension
> additionally defines 8 MOP instructions named MOP.RR.n, where n
> is an integer between 0 and 7.
> 
> These 40 MOPs initially are defined to simply write zero to x[rd],
> but are designed to be redefined by later extensions to perform some
> other action.
> 
> Signed-off-by: LIU Zhiwei <zhiwei_liu@linux.alibaba.com>
> ---
>   target/riscv/cpu.c                          |  2 ++
>   target/riscv/cpu_cfg.h                      |  1 +
>   target/riscv/insn32.decode                  | 11 ++++++
>   target/riscv/insn_trans/trans_rvzimop.c.inc | 37 +++++++++++++++++++++
>   target/riscv/translate.c                    |  1 +
>   5 files changed, 52 insertions(+)
>   create mode 100644 target/riscv/insn_trans/trans_rvzimop.c.inc
> 
> diff --git a/target/riscv/cpu.c b/target/riscv/cpu.c
> index eb1a2e7d6d..c1ac521142 100644
> --- a/target/riscv/cpu.c
> +++ b/target/riscv/cpu.c
> @@ -175,6 +175,7 @@ const RISCVIsaExtData isa_edata_arr[] = {
>       ISA_EXT_DATA_ENTRY(zvkt, PRIV_VERSION_1_12_0, ext_zvkt),
>       ISA_EXT_DATA_ENTRY(zhinx, PRIV_VERSION_1_12_0, ext_zhinx),
>       ISA_EXT_DATA_ENTRY(zhinxmin, PRIV_VERSION_1_12_0, ext_zhinxmin),
> +    ISA_EXT_DATA_ENTRY(zimop, PRIV_VERSION_1_12_0, ext_zimop),

Shouldn't this be placed right after zihpm?

     ISA_EXT_DATA_ENTRY(zihintpause, PRIV_VERSION_1_10_0, ext_zihintpause),
     ISA_EXT_DATA_ENTRY(zihpm, PRIV_VERSION_1_12_0, ext_zihpm),
> +    ISA_EXT_DATA_ENTRY(zimop, PRIV_VERSION_1_12_0, ext_zimop),
     ISA_EXT_DATA_ENTRY(zmmul, PRIV_VERSION_1_12_0, ext_zmmul),


Thanks,

Daniel


>       ISA_EXT_DATA_ENTRY(smaia, PRIV_VERSION_1_12_0, ext_smaia),
>       ISA_EXT_DATA_ENTRY(smepmp, PRIV_VERSION_1_12_0, ext_smepmp),
>       ISA_EXT_DATA_ENTRY(smstateen, PRIV_VERSION_1_12_0, ext_smstateen),
> @@ -1463,6 +1464,7 @@ const RISCVCPUMultiExtConfig riscv_cpu_extensions[] = {
>       MULTI_EXT_CFG_BOOL("zicsr", ext_zicsr, true),
>       MULTI_EXT_CFG_BOOL("zihintntl", ext_zihintntl, true),
>       MULTI_EXT_CFG_BOOL("zihintpause", ext_zihintpause, true),
> +    MULTI_EXT_CFG_BOOL("zimop", ext_zimop, false),
>       MULTI_EXT_CFG_BOOL("zacas", ext_zacas, false),
>       MULTI_EXT_CFG_BOOL("zaamo", ext_zaamo, false),
>       MULTI_EXT_CFG_BOOL("zalrsc", ext_zalrsc, false),
> diff --git a/target/riscv/cpu_cfg.h b/target/riscv/cpu_cfg.h
> index cb750154bd..b547fbba9d 100644
> --- a/target/riscv/cpu_cfg.h
> +++ b/target/riscv/cpu_cfg.h
> @@ -71,6 +71,7 @@ struct RISCVCPUConfig {
>       bool ext_zihintntl;
>       bool ext_zihintpause;
>       bool ext_zihpm;
> +    bool ext_zimop;
>       bool ext_ztso;
>       bool ext_smstateen;
>       bool ext_sstc;
> diff --git a/target/riscv/insn32.decode b/target/riscv/insn32.decode
> index f22df04cfd..972a1e8fd1 100644
> --- a/target/riscv/insn32.decode
> +++ b/target/riscv/insn32.decode
> @@ -38,6 +38,8 @@
>   %imm_bs   30:2                   !function=ex_shift_3
>   %imm_rnum 20:4
>   %imm_z6   26:1 15:5
> +%imm_mop5 30:1 26:2 20:2
> +%imm_mop3 30:1 26:2
>   
>   # Argument sets:
>   &empty
> @@ -56,6 +58,8 @@
>   &r2nfvm    vm rd rs1 nf
>   &rnfvm     vm rd rs1 rs2 nf
>   &k_aes     shamt rs2 rs1 rd
> +&mop5 imm rd rs1
> +&mop3 imm rd rs1 rs2
>   
>   # Formats 32:
>   @r       .......   ..... ..... ... ..... ....... &r                %rs2 %rs1 %rd
> @@ -98,6 +102,9 @@
>   @k_aes   .. ..... ..... .....  ... ..... ....... &k_aes  shamt=%imm_bs   %rs2 %rs1 %rd
>   @i_aes   .. ..... ..... .....  ... ..... ....... &i      imm=%imm_rnum        %rs1 %rd
>   
> +@mop5 . . .. .. .... .. ..... ... ..... ....... &mop5 imm=%imm_mop5 %rd %rs1
> +@mop3 . . .. .. . ..... ..... ... ..... ....... &mop3 imm=%imm_mop3 %rd %rs1 %rs2
> +
>   # Formats 64:
>   @sh5     .......  ..... .....  ... ..... ....... &shift  shamt=%sh5      %rs1 %rd
>   
> @@ -1010,3 +1017,7 @@ amocas_w    00101 . . ..... ..... 010 ..... 0101111 @atom_st
>   amocas_d    00101 . . ..... ..... 011 ..... 0101111 @atom_st
>   # *** RV64 Zacas Standard Extension ***
>   amocas_q    00101 . . ..... ..... 100 ..... 0101111 @atom_st
> +
> +# *** Zimop may-be-operation extension ***
> +mop_r_n     1 . 00 .. 0111 .. ..... 100 ..... 0111011 @mop5
> +mop_rr_n    1 . 00 .. 1 ..... ..... 100 ..... 0111011 @mop3
> diff --git a/target/riscv/insn_trans/trans_rvzimop.c.inc b/target/riscv/insn_trans/trans_rvzimop.c.inc
> new file mode 100644
> index 0000000000..165aacd2b6
> --- /dev/null
> +++ b/target/riscv/insn_trans/trans_rvzimop.c.inc
> @@ -0,0 +1,37 @@
> +/*
> + * RISC-V translation routines for May-Be-Operation(zimop).
> + *
> + * Copyright (c) 2024 Alibaba Group.
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
> +#define REQUIRE_ZIMOP(ctx) do {           \
> +    if (!ctx->cfg_ptr->ext_zimop) {       \
> +        return false;                     \
> +    }                                     \
> +} while (0)
> +
> +static bool trans_mop_r_n(DisasContext *ctx, arg_mop_r_n *a)
> +{
> +    REQUIRE_ZIMOP(ctx);
> +    gen_set_gpr(ctx, a->rd, ctx->zero);
> +    return true;
> +}
> +
> +static bool trans_mop_rr_n(DisasContext *ctx, arg_mop_rr_n *a)
> +{
> +    REQUIRE_ZIMOP(ctx);
> +    gen_set_gpr(ctx, a->rd, ctx->zero);
> +    return true;
> +}
> diff --git a/target/riscv/translate.c b/target/riscv/translate.c
> index 2c27fd4ce1..77c6564834 100644
> --- a/target/riscv/translate.c
> +++ b/target/riscv/translate.c
> @@ -1097,6 +1097,7 @@ static uint32_t opcode_at(DisasContextBase *dcbase, target_ulong pc)
>   #include "insn_trans/trans_rvzacas.c.inc"
>   #include "insn_trans/trans_rvzawrs.c.inc"
>   #include "insn_trans/trans_rvzicbo.c.inc"
> +#include "insn_trans/trans_rvzimop.c.inc"
>   #include "insn_trans/trans_rvzfa.c.inc"
>   #include "insn_trans/trans_rvzfh.c.inc"
>   #include "insn_trans/trans_rvk.c.inc"

