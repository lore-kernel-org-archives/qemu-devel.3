Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9BD25C30653
	for <qemu-devel@archiver.kernel.org>; Tue, 25 Jun 2024 08:28:56 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sM1XB-00054S-Dg; Tue, 25 Jun 2024 04:28:13 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jason.chien@sifive.com>)
 id 1sM1X9-00053B-Gn
 for qemu-devel@nongnu.org; Tue, 25 Jun 2024 04:28:11 -0400
Received: from mail-pl1-x636.google.com ([2607:f8b0:4864:20::636])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <jason.chien@sifive.com>)
 id 1sM1X7-0005WM-K8
 for qemu-devel@nongnu.org; Tue, 25 Jun 2024 04:28:11 -0400
Received: by mail-pl1-x636.google.com with SMTP id
 d9443c01a7336-1f65a3abd01so42431115ad.3
 for <qemu-devel@nongnu.org>; Tue, 25 Jun 2024 01:28:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sifive.com; s=google; t=1719304088; x=1719908888; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=KLuk9IwD49CU3/IrwQ44V4FXQO/7qQ+Y63l7LiZAYH8=;
 b=B0mVm6n/mtZpl/6dTu44ZTTF2hHZbOpBNihGNap54c5rfZEzYmUpvhPOzQgQSkkoJD
 Elw/CMUvszrswCprGykgS1VsTY/X96nC/ofupvCbDk0kNK7KgfhohPb3veNiygeeKhcC
 N1XqUTg5xFUcjt+YnCAjbL3/C3W/nSICKRpyH0vPFlTlM69ieLGGlkNjcKEnTzKmabBL
 TbwM14++6pW/06GUoRjRh8OqsrZ46tSvPPtryqLZVdgzP++Off9W4OQ+Zf6vHiua1IlV
 7xHfW40Q8uU1BXhIODOZ2AU/B+AjUsjxbRTEX2qMIJ0pYYMU5hX0wEYXYk6coz+RaQi/
 y1uQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1719304088; x=1719908888;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=KLuk9IwD49CU3/IrwQ44V4FXQO/7qQ+Y63l7LiZAYH8=;
 b=AjKzfTUMIsD/w+d39L3fNl2Hju2lMxYyVm5e5HnjH06osVylq/k2dVd+3NHA1YqAWM
 h3cSWxzul6oanUVo6dF9N6knhz4mAUHSYnA2MfNdKB513gdcGwfw6HZdgCkahY+SY5k4
 HkEcfx14gf09jz2wq+OPrhC32sLQxS9wmxJRqCC/Jc6b7HzfZ4M7XaTtSfYRpm3rApb9
 68kK663jF6OIBjwk2YDjLvs/wKfWKo4g18veS/5SiMLUbXV242yxqSS2WlcVqjeERKQU
 FJ8/gTXzWcztj6ajyHo0H32i0+k7GRxyXS+xuiBJaJw3Dm5EbzuzxIzZBqqk9NjrZaEV
 PB1g==
X-Forwarded-Encrypted: i=1;
 AJvYcCXX7Q8pnXPyNyvea/H7OmTCJk6utulGu70hm47e2QsNxE3yiwJn7I75oHmMI83OmpbubFTS9NMHspLGLWmBKU1TaD2Pw1c=
X-Gm-Message-State: AOJu0YyTP07zz4qh2ivFGVO1zoDnBjarfxzqE5Q0qNabJaOSDmtDb6Gy
 8eG9jp81KbFByHJZlfI353fHKG7riXTCBTp/WcdbM4UneZ33TUgY+LghhZaBj/Y=
X-Google-Smtp-Source: AGHT+IF5CN09lGrPkRrH1WSn2sYvtn/kYdNGne9kjk9Z0ijJ9jWdIhsYGydQQRY4llFbhGwyKFCvCg==
X-Received: by 2002:a17:903:2290:b0:1f8:3c5d:9eb with SMTP id
 d9443c01a7336-1fa23bd1b2amr94259985ad.7.1719304087896; 
 Tue, 25 Jun 2024 01:28:07 -0700 (PDT)
Received: from [192.168.100.252] (59-124-168-89.hinet-ip.hinet.net.
 [59.124.168.89]) by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-1f9ebab6fffsm75701405ad.243.2024.06.25.01.28.05
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 25 Jun 2024 01:28:07 -0700 (PDT)
Message-ID: <3445ae80-c3db-4f32-95b7-8dcde9bb2b1d@sifive.com>
Date: Tue, 25 Jun 2024 16:28:04 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 3/6] target/riscv: Add support for Control Transfer
 Records extension CSRs.
To: Rajnesh Kanwal <rkanwal@rivosinc.com>, qemu-riscv@nongnu.org,
 qemu-devel@nongnu.org
Cc: alistair.francis@wdc.com, bin.meng@windriver.com, liweiwei@iscas.ac.cn,
 dbarboza@ventanamicro.com, zhiwei_liu@linux.alibaba.com,
 atishp@rivosinc.com, apatel@ventanamicro.com, beeman@rivosinc.com,
 tech-control-transfer-records@lists.riscv.org
References: <20240619152708.135991-1-rkanwal@rivosinc.com>
 <20240619152708.135991-4-rkanwal@rivosinc.com>
Content-Language: en-US
From: Jason Chien <jason.chien@sifive.com>
In-Reply-To: <20240619152708.135991-4-rkanwal@rivosinc.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::636;
 envelope-from=jason.chien@sifive.com; helo=mail-pl1-x636.google.com
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

Hi Rajnesh,

On 2024/6/19 下午 11:27, Rajnesh Kanwal wrote:
> This commit adds support for [m|s|vs]ctrcontrol, sctrstatus and
> sctrdepth CSRs handling.
>
> Signed-off-by: Rajnesh Kanwal <rkanwal@rivosinc.com>
> ---
>   target/riscv/cpu.h     |   5 ++
>   target/riscv/cpu_cfg.h |   2 +
>   target/riscv/csr.c     | 128 +++++++++++++++++++++++++++++++++++++++++
>   3 files changed, 135 insertions(+)
>
> diff --git a/target/riscv/cpu.h b/target/riscv/cpu.h
> index a185e2d494..3d4d5172b8 100644
> --- a/target/riscv/cpu.h
> +++ b/target/riscv/cpu.h
> @@ -263,6 +263,11 @@ struct CPUArchState {
>       target_ulong mcause;
>       target_ulong mtval;  /* since: priv-1.10.0 */
>   
> +    uint64_t mctrctl;
> +    uint32_t sctrdepth;
> +    uint32_t sctrstatus;
> +    uint64_t vsctrctl;
> +
>       /* Machine and Supervisor interrupt priorities */
>       uint8_t miprio[64];
>       uint8_t siprio[64];
> diff --git a/target/riscv/cpu_cfg.h b/target/riscv/cpu_cfg.h
> index d9354dc80a..d329a65811 100644
> --- a/target/riscv/cpu_cfg.h
> +++ b/target/riscv/cpu_cfg.h
> @@ -123,6 +123,8 @@ struct RISCVCPUConfig {
>       bool ext_zvfhmin;
>       bool ext_smaia;
>       bool ext_ssaia;
> +    bool ext_smctr;
> +    bool ext_ssctr;
>       bool ext_sscofpmf;
>       bool ext_smepmp;
>       bool rvv_ta_all_1s;
> diff --git a/target/riscv/csr.c b/target/riscv/csr.c
> index 2f92e4b717..0b5bf4d050 100644
> --- a/target/riscv/csr.c
> +++ b/target/riscv/csr.c
> @@ -621,6 +621,48 @@ static RISCVException pointer_masking(CPURISCVState *env, int csrno)
>       return RISCV_EXCP_ILLEGAL_INST;
>   }
>   
> +/*
> + * M-mode:
> + * Without ext_smctr raise illegal inst excep.
> + * Otherwise everything is accessible to m-mode.
> + *
> + * S-mode:
> + * Without ext_ssctr or mstateen.ctr raise illegal inst excep.
> + * Otherwise everything other than mctrctl is accessible.
> + *
> + * VS-mode:
> + * Without ext_ssctr or mstateen.ctr raise illegal inst excep.
> + * Without hstateen.ctr raise virtual illegal inst excep.
> + * Otherwise allow sctrctl (vsctrctl), sctrstatus, 0x200-0x2ff entry range.
> + * Always raise illegal instruction exception for sctrdepth.
> + */
> +static RISCVException ctr_mmode(CPURISCVState *env, int csrno)
> +{
> +    /* Check if smctr-ext is present */
> +    if (riscv_cpu_cfg(env)->ext_smctr) {
> +        return RISCV_EXCP_NONE;
> +    }
> +
> +    return RISCV_EXCP_ILLEGAL_INST;
> +}
> +
> +static RISCVException ctr_smode(CPURISCVState *env, int csrno)
> +{
> +    const RISCVCPUConfig *cfg = riscv_cpu_cfg(env);
> +
> +    if (!cfg->ext_smctr && !cfg->ext_ssctr) {
> +        return RISCV_EXCP_ILLEGAL_INST;
> +    }
> +
> +    RISCVException ret = smstateen_acc_ok(env, 0, SMSTATEEN0_CTR);
> +    if (ret == RISCV_EXCP_NONE && csrno == CSR_SCTRDEPTH &&
> +        env->virt_enabled) {
> +        return RISCV_EXCP_VIRT_INSTRUCTION_FAULT;
> +    }
> +
> +    return ret;
> +}
> +
>   static RISCVException aia_hmode(CPURISCVState *env, int csrno)
>   {
>       int ret;
> @@ -3835,6 +3877,86 @@ static RISCVException write_satp(CPURISCVState *env, int csrno,
>       return RISCV_EXCP_NONE;
>   }
>   
> +static RISCVException rmw_sctrdepth(CPURISCVState *env, int csrno,
> +                                    target_ulong *ret_val,
> +                                    target_ulong new_val, target_ulong wr_mask)
> +{
> +    uint64_t mask = wr_mask & SCTRDEPTH_MASK;
> +
> +    if (ret_val) {
> +        *ret_val = env->sctrdepth;
> +    }
> +
> +    env->sctrdepth = (env->sctrdepth & ~mask) | (new_val & mask);
> +
> +    /* Correct depth. */
> +    if (wr_mask & SCTRDEPTH_MASK) {

We can use the variable "mask" here.

if (mask) {}

> +        uint64_t depth = get_field(env->sctrdepth, SCTRDEPTH_MASK);
> +
> +        if (depth > SCTRDEPTH_MAX) {
> +            depth = SCTRDEPTH_MAX;
> +            env->sctrdepth = set_field(env->sctrdepth, SCTRDEPTH_MASK, depth);
> +        }
> +
> +        /* Update sctrstatus.WRPTR with a legal value */
> +        depth = 16 << depth;
> +        env->sctrstatus =
> +            env->sctrstatus & (~SCTRSTATUS_WRPTR_MASK | (depth - 1));
> +    }
> +
> +    return RISCV_EXCP_NONE;
> +}
> +
> +static RISCVException rmw_sctrstatus(CPURISCVState *env, int csrno,
> +                                     target_ulong *ret_val,
> +                                     target_ulong new_val, target_ulong wr_mask)
> +{
> +    uint32_t depth = 16 << get_field(env->sctrdepth, SCTRDEPTH_MASK);
> +    uint32_t mask = wr_mask & SCTRSTATUS_MASK;
> +
> +    if (ret_val) {
> +        *ret_val = env->sctrstatus;
> +    }
> +
> +    env->sctrstatus = (env->sctrstatus & ~mask) | (new_val & mask);
> +
> +    /* Update sctrstatus.WRPTR with a legal value */
> +    env->sctrstatus = env->sctrstatus & (~SCTRSTATUS_WRPTR_MASK | (depth - 1));
> +
> +    return RISCV_EXCP_NONE;
> +}
> +
> +static RISCVException rmw_xctrctl(CPURISCVState *env, int csrno,
> +                                    target_ulong *ret_val,
> +                                    target_ulong new_val, target_ulong wr_mask)
> +{
> +    uint64_t csr_mask, mask = wr_mask;
> +    uint64_t *ctl_ptr = &env->mctrctl;
> +
> +    if (csrno == CSR_MCTRCTL) {
> +        csr_mask = MCTRCTL_MASK;
> +    } else if (csrno == CSR_SCTRCTL && !env->virt_enabled) {
> +        csr_mask = SCTRCTL_MASK;
> +    } else {
> +        /*
> +         * This is for csrno == CSR_SCTRCTL and env->virt_enabled == true
> +         * or csrno == CSR_VSCTRCTL.
> +         */
> +        csr_mask = VSCTRCTL_MASK;
> +        ctl_ptr = &env->vsctrctl;
> +    }
> +
> +    mask &= csr_mask;
> +
> +    if (ret_val) {
> +        *ret_val = *ctl_ptr & csr_mask;
> +    }
> +
> +    *ctl_ptr = (*ctl_ptr & ~mask) | (new_val & mask);
> +
> +    return RISCV_EXCP_NONE;
> +}
> +
>   static RISCVException read_vstopi(CPURISCVState *env, int csrno,
>                                     target_ulong *val)
>   {
> @@ -5771,6 +5893,12 @@ riscv_csr_operations csr_ops[CSR_TABLE_SIZE] = {
>       [CSR_SPMBASE] =    { "spmbase", pointer_masking, read_spmbase,
>                            write_spmbase                                      },
>   
> +    [CSR_MCTRCTL]    = { "mctrctl",    ctr_mmode,  NULL, NULL, rmw_xctrctl },
> +    [CSR_SCTRCTL]    = { "sctrctl",    ctr_smode,  NULL, NULL, rmw_xctrctl },
> +    [CSR_VSCTRCTL]   = { "vsctrctl",   ctr_smode,  NULL, NULL, rmw_xctrctl },
> +    [CSR_SCTRDEPTH]  = { "sctrdepth",  ctr_smode,  NULL, NULL, rmw_sctrdepth },
> +    [CSR_SCTRSTATUS] = { "sctrstatus", ctr_smode,  NULL, NULL, rmw_sctrstatus },
Would you mind aligning the right curly bracket like other CSR entries?
> +
>       /* Performance Counters */
>       [CSR_HPMCOUNTER3]    = { "hpmcounter3",    ctr,    read_hpmcounter },
>       [CSR_HPMCOUNTER4]    = { "hpmcounter4",    ctr,    read_hpmcounter },

