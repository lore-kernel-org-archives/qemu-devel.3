Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C1CB5C25B7D
	for <qemu-devel@archiver.kernel.org>; Fri, 24 May 2024 09:48:38 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sARXG-0006c7-0K; Fri, 24 May 2024 05:48:26 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dbarboza@ventanamicro.com>)
 id 1sARXE-0006Y9-LD
 for qemu-devel@nongnu.org; Fri, 24 May 2024 05:48:24 -0400
Received: from mail-pf1-x42b.google.com ([2607:f8b0:4864:20::42b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <dbarboza@ventanamicro.com>)
 id 1sARXC-000393-Ii
 for qemu-devel@nongnu.org; Fri, 24 May 2024 05:48:24 -0400
Received: by mail-pf1-x42b.google.com with SMTP id
 d2e1a72fcca58-6f8ecafd661so640994b3a.3
 for <qemu-devel@nongnu.org>; Fri, 24 May 2024 02:48:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=ventanamicro.com; s=google; t=1716544101; x=1717148901; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=1WN4SEGBKnPYfS+wH2Kh0CyI6wXv3yukSU2oetMs3w4=;
 b=gXzlBRx1uwWEgw1d4KRAVSpvmxa3yV6KhYPnnvnqW1oVAmHjq8lN87TpN6LqgRpYxx
 Y6P3VdoAKMrEOVN5gTUQS4B2d5Bw3WbYOlljMMVAbpDBREqbwOiQYcZFeClDsrU8XreK
 JhfS6EUj2phnkDbYqOaWu1QSJCJiduHkn97LB/3ZgsjNGBjzgdRtTmCE0ggDHzaejrvE
 ef31crv7VlOFPLMp2/mPYd9GGvVLB0EIaOhzBDqk8MoGRxF+WTMDUFBYcvvFhSjqENMf
 jLUOz6q1bDwh8jUzE0LCbtxMkL377H4HCaedghjoW0dlY1BBOpPwUId7jg+aD+oMLWRN
 Vr3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1716544101; x=1717148901;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=1WN4SEGBKnPYfS+wH2Kh0CyI6wXv3yukSU2oetMs3w4=;
 b=UUt3q1b6M+iKy0+nCT285bwfC4EDUZQH6tYpbp7j4egrig36P2TMVpuIH/mq7OABOz
 fdVdTFK/K84K9DK/qgxaCJKfdFZQg+vHkB3MIdNTeB6DBksCwe0ZeixA4mo/qzPujBbn
 9oGMrGVUzkhXsVffe0W8/R4tY1JoIdemGnBvfPboLAyzG2czfn8K/dDixX3CkXFM30Os
 I8E2hHqsIiwM/kG5P0xtIMIR44jiC9ywln8bNuMSzV9E/Bvqp6GraHbLLwL3FsjfeZU0
 xURo/j3ZQmLT+vsluu7k9vNdoGH/TMod4xJuesWb/SaeRehrviChgygPSyEPjyfY+MS8
 UB6A==
X-Forwarded-Encrypted: i=1;
 AJvYcCUEaR9N55SnY0Imflyk1q76bSv9PK3UBmC5++fHzZETIrQM4FWYOCelVzTkoH7Wkj84jaBBJUGmexlbaglXaj2ioxxjh1o=
X-Gm-Message-State: AOJu0YxLlnTNO07u6nA8UtqvM7nMyP/pNOQ01a1QRQ0QdTnn6KqcGNVA
 jNTr1ddOZvllV6jECYJ45pNOEO6WbrcXqigCNtp/wFpktWVeAxtHlw1jsgI2vVE=
X-Google-Smtp-Source: AGHT+IE+0JBuwmtuGhEIImth49d6XEKJVHJ2KY6SgxKZlOHnvTlM3w5U+xvBazSrN0HvUXXjFv4N7w==
X-Received: by 2002:a05:6a21:3417:b0:1af:9728:de86 with SMTP id
 adf61e73a8af0-1b212d382famr2009712637.32.1716544101052; 
 Fri, 24 May 2024 02:48:21 -0700 (PDT)
Received: from [192.168.68.110] ([177.94.42.4])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-1f44c993fa7sm9900705ad.196.2024.05.24.02.48.18
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 24 May 2024 02:48:20 -0700 (PDT)
Message-ID: <59cb3f8e-78ff-447d-9968-032ae68ac136@ventanamicro.com>
Date: Fri, 24 May 2024 06:48:17 -0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 3/4] target/riscv: Add zcmop extension
To: LIU Zhiwei <zhiwei_liu@linux.alibaba.com>, qemu-devel@nongnu.org
Cc: qemu-riscv@nongnu.org, palmer@dabbelt.com, Alistair.Francis@wdc.com,
 bmeng.cn@gmail.com, iwei1518@gmail.com
References: <20240522062905.1799-1-zhiwei_liu@linux.alibaba.com>
 <20240522062905.1799-4-zhiwei_liu@linux.alibaba.com>
Content-Language: en-US
From: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
In-Reply-To: <20240522062905.1799-4-zhiwei_liu@linux.alibaba.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::42b;
 envelope-from=dbarboza@ventanamicro.com; helo=mail-pf1-x42b.google.com
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
> Zcmop defines eight 16-bit MOP instructions named C.MOP.n, where n is
> an odd integer between 1 and 15, inclusive. C.MOP.n is encoded in
> the reserved encoding space corresponding to C.LUI xn, 0.
> 
> Unlike the MOPs defined in the Zimop extension, the C.MOP.n instructions
> are defined to not write any register.
> 
> In current implementation, C.MOP.n only has an check function, without any
> other more behavior.
> 
> Signed-off-by: LIU Zhiwei <zhiwei_liu@linux.alibaba.com>
> ---
>   target/riscv/cpu.c                          |  2 ++
>   target/riscv/cpu_cfg.h                      |  1 +
>   target/riscv/insn16.decode                  |  1 +
>   target/riscv/insn_trans/trans_rvzcmop.c.inc | 29 +++++++++++++++++++++
>   target/riscv/tcg/tcg-cpu.c                  |  5 ++++
>   target/riscv/translate.c                    |  1 +
>   6 files changed, 39 insertions(+)
>   create mode 100644 target/riscv/insn_trans/trans_rvzcmop.c.inc
> 
> diff --git a/target/riscv/cpu.c b/target/riscv/cpu.c
> index c1ac521142..5052237a5b 100644
> --- a/target/riscv/cpu.c
> +++ b/target/riscv/cpu.c
> @@ -176,6 +176,7 @@ const RISCVIsaExtData isa_edata_arr[] = {
>       ISA_EXT_DATA_ENTRY(zhinx, PRIV_VERSION_1_12_0, ext_zhinx),
>       ISA_EXT_DATA_ENTRY(zhinxmin, PRIV_VERSION_1_12_0, ext_zhinxmin),
>       ISA_EXT_DATA_ENTRY(zimop, PRIV_VERSION_1_12_0, ext_zimop),
> +    ISA_EXT_DATA_ENTRY(zcmop, PRIV_VERSION_1_12_0, ext_zcmop),


I'm not sure if zcmop goes here. Perhaps here?


     ISA_EXT_DATA_ENTRY(zce, PRIV_VERSION_1_12_0, ext_zce),
> +    ISA_EXT_DATA_ENTRY(zcmop, PRIV_VERSION_1_12_0, ext_zcmop),
     ISA_EXT_DATA_ENTRY(zcmp, PRIV_VERSION_1_12_0, ext_zcmp),
     ISA_EXT_DATA_ENTRY(zcmt, PRIV_VERSION_1_12_0, ext_zcmt),
     ISA_EXT_DATA_ENTRY(zba, PRIV_VERSION_1_12_0, ext_zba),


Thanks,


Daniel


>       ISA_EXT_DATA_ENTRY(smaia, PRIV_VERSION_1_12_0, ext_smaia),
>       ISA_EXT_DATA_ENTRY(smepmp, PRIV_VERSION_1_12_0, ext_smepmp),
>       ISA_EXT_DATA_ENTRY(smstateen, PRIV_VERSION_1_12_0, ext_smstateen),
> @@ -1465,6 +1466,7 @@ const RISCVCPUMultiExtConfig riscv_cpu_extensions[] = {
>       MULTI_EXT_CFG_BOOL("zihintntl", ext_zihintntl, true),
>       MULTI_EXT_CFG_BOOL("zihintpause", ext_zihintpause, true),
>       MULTI_EXT_CFG_BOOL("zimop", ext_zimop, false),
> +    MULTI_EXT_CFG_BOOL("zcmop", ext_zcmop, false),
>       MULTI_EXT_CFG_BOOL("zacas", ext_zacas, false),
>       MULTI_EXT_CFG_BOOL("zaamo", ext_zaamo, false),
>       MULTI_EXT_CFG_BOOL("zalrsc", ext_zalrsc, false),
> diff --git a/target/riscv/cpu_cfg.h b/target/riscv/cpu_cfg.h
> index b547fbba9d..e29d4f6f9c 100644
> --- a/target/riscv/cpu_cfg.h
> +++ b/target/riscv/cpu_cfg.h
> @@ -72,6 +72,7 @@ struct RISCVCPUConfig {
>       bool ext_zihintpause;
>       bool ext_zihpm;
>       bool ext_zimop;
> +    bool ext_zcmop;
>       bool ext_ztso;
>       bool ext_smstateen;
>       bool ext_sstc;
> diff --git a/target/riscv/insn16.decode b/target/riscv/insn16.decode
> index b96c534e73..3953bcf82d 100644
> --- a/target/riscv/insn16.decode
> +++ b/target/riscv/insn16.decode
> @@ -140,6 +140,7 @@ sw                110  ... ... .. ... 00 @cs_w
>   addi              000 .  .....  ..... 01 @ci
>   addi              010 .  .....  ..... 01 @c_li
>   {
> +  c_mop_n         011 0 0 n:3 1 00000 01
>     illegal         011 0  -----  00000 01 # c.addi16sp and c.lui, RES nzimm=0
>     addi            011 .  00010  ..... 01 @c_addi16sp
>     lui             011 .  .....  ..... 01 @c_lui
> diff --git a/target/riscv/insn_trans/trans_rvzcmop.c.inc b/target/riscv/insn_trans/trans_rvzcmop.c.inc
> new file mode 100644
> index 0000000000..7205586508
> --- /dev/null
> +++ b/target/riscv/insn_trans/trans_rvzcmop.c.inc
> @@ -0,0 +1,29 @@
> +/*
> + * RISC-V translation routines for compressed May-Be-Operation(zcmop).
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
> +#define REQUIRE_ZCMOP(ctx) do {           \
> +    if (!ctx->cfg_ptr->ext_zcmop) {       \
> +        return false;                     \
> +    }                                     \
> +} while (0)
> +
> +static bool trans_c_mop_n(DisasContext *ctx, arg_c_mop_n *a)
> +{
> +    REQUIRE_ZCMOP(ctx);
> +    return true;
> +}
> diff --git a/target/riscv/tcg/tcg-cpu.c b/target/riscv/tcg/tcg-cpu.c
> index 40054a391a..499b48dce8 100644
> --- a/target/riscv/tcg/tcg-cpu.c
> +++ b/target/riscv/tcg/tcg-cpu.c
> @@ -583,6 +583,11 @@ void riscv_cpu_validate_set_extensions(RISCVCPU *cpu, Error **errp)
>           }
>       }
>   
> +    if (cpu->cfg.ext_zcmop && !cpu->cfg.ext_zca) {
> +        error_setg(errp, "Zcmop extensions require Zca");
> +        return;
> +    }
> +
>       if (mcc->misa_mxl_max != MXL_RV32 && cpu->cfg.ext_zcf) {
>           error_setg(errp, "Zcf extension is only relevant to RV32");
>           return;
> diff --git a/target/riscv/translate.c b/target/riscv/translate.c
> index 77c6564834..51dfb03685 100644
> --- a/target/riscv/translate.c
> +++ b/target/riscv/translate.c
> @@ -1112,6 +1112,7 @@ static uint32_t opcode_at(DisasContextBase *dcbase, target_ulong pc)
>   /* Include the auto-generated decoder for 16 bit insn */
>   #include "decode-insn16.c.inc"
>   #include "insn_trans/trans_rvzce.c.inc"
> +#include "insn_trans/trans_rvzcmop.c.inc"
>   
>   /* Include decoders for factored-out extensions */
>   #include "decode-XVentanaCondOps.c.inc"

