Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0222DCCD184
	for <qemu-devel@archiver.kernel.org>; Sun, 12 Oct 2025 17:33:42 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v7zwC-0002fX-EH; Sun, 12 Oct 2025 13:32:52 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dbarboza@ventanamicro.com>)
 id 1v7zwA-0002fI-OG
 for qemu-devel@nongnu.org; Sun, 12 Oct 2025 13:32:50 -0400
Received: from mail-pl1-x632.google.com ([2607:f8b0:4864:20::632])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <dbarboza@ventanamicro.com>)
 id 1v7zw7-0001oD-8U
 for qemu-devel@nongnu.org; Sun, 12 Oct 2025 13:32:50 -0400
Received: by mail-pl1-x632.google.com with SMTP id
 d9443c01a7336-27edcbbe7bfso42440005ad.0
 for <qemu-devel@nongnu.org>; Sun, 12 Oct 2025 10:32:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=ventanamicro.com; s=google; t=1760290365; x=1760895165; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=z7F/r1mGKoFNRQEl8vPP8Ch0jSyFFee0pGdrTXyJaxw=;
 b=jhHohiVbsA5SYvVL4k/CiE2OLtOQ80q63TFrNd57pBNeMW8AR2JFBs771Z7GGZ/zxj
 vztkOzefgKBl0S71LRpKft7GUbDA4myt11YZ0zbZTCKOkBiANmeUaNfKb+H8yauca+gW
 tXKE1koAX+5AHzd/I3Jjohvb9qo8L+82Qwb1g0YeKXLZBdUWwmeaxFkPt77fHDnzdmh3
 VfDdDN/ojZqSdenj2S+yn1cCTiGGIbaISdULURZtZEBXrkMIU+FJNU0ly05oN69ESFPF
 VYIrq3yyJeOwxGRc461MNU2ztf3Tyz6OaRhdF6T8i/yICsSJeJ1OhyDgTKEu7SJVdcsI
 BbWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1760290365; x=1760895165;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=z7F/r1mGKoFNRQEl8vPP8Ch0jSyFFee0pGdrTXyJaxw=;
 b=Y9jGVe/QFLPgY12OZ4arVp9Op6FFgMLuWjQDLrr54eGVZ/5CGuHwT6k7KTeyD9x4jP
 4Xk9CV6psr8w5qo3ez1cK+qe4dbUuC9iTD2tV7HkJAuTsCoobggdLw8sRYVTCZJRW+Ne
 Kh2GRXe3jbXqoerKJIahpmFJ5f6LQLddDhav2laAIJVu/UtSdoJM8mgUJH0v6iPWJJ0H
 h3MDjr4+0g70mwYqNvawFdczUE04MdIslGfc/zIeGligSoDGSfihn2Wa4q+cYF/1JcCk
 xLzkl6D1XyZJfDtJdN8iN8Xm7wj0zi3p1e82dXQRqNB88sx6O2wrW+POnwSz4Kx2ERSG
 O+tg==
X-Forwarded-Encrypted: i=1;
 AJvYcCWeT+0pjk6J9rCLde4iE1bVJNs8uFVXerY80HHsplCUCbd/i3kLEfTV/Mn/D19K6DE/VVyHsXoxcazk@nongnu.org
X-Gm-Message-State: AOJu0YzfUSTxTyMWx5g8xiYUnQBp4Jq+jX0QE58vDtjssmQmeHya1/JF
 fy/uDXUYuUQJj/R66/p4z90U7bwOSg8FWPuBaNF33uWtT+wsE/YWgNFBKyXaOw6M0AA=
X-Gm-Gg: ASbGncsnpDTz98CIqySFDUs/3s9JHxKdbiFvqcjIH6UbyNVjunK75xROPi+xBCS8IaJ
 Z/qEYqcU6y1DRul+cbHiMfbew96yAcRIusJMJCtDFfLteH9KAKaRjA2qMeNsodbE6ImxyNs8Oau
 zxUk/qfHfVzrXVxjhZofVLPd2ZwFh5NGDgEAn757z6t8eQGE7pbdocgIle26FvTbt5PI5bLyKQ/
 XnXAzHgB8WmZ2oSA/oJL9DHjlAho3csXAexWecU7YsljGyjTTNwX6ArBh6Vjb/mhP4MA3kZjO3S
 qETs4vO+/udVR+CQiZV84Vr19TUv+UkG17EK6TU7HrqK6/XV8WK4AkoEkwKFBW1HSQSExWYStdc
 6vtpn2w1J69e4c9DxlTOKz4AEy1e9uaQ7GyjR3kqQ4hql/V4KuyfccLVRO80HcO4SGMM=
X-Google-Smtp-Source: AGHT+IFzE8liKt2SvSBBQp2GTw1IgxsO7IJrJiYsmLQNEL5ry/C/7HPVjZSF6+WQadaIYEsCE9TAlQ==
X-Received: by 2002:a17:902:e786:b0:26e:7468:8a99 with SMTP id
 d9443c01a7336-290272c18e1mr228655645ad.36.1760290365534; 
 Sun, 12 Oct 2025 10:32:45 -0700 (PDT)
Received: from [192.168.68.110] ([152.234.122.223])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-29034f93e06sm111085775ad.115.2025.10.12.10.32.42
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sun, 12 Oct 2025 10:32:45 -0700 (PDT)
Message-ID: <6ed2b204-6df4-4341-a0e0-6354c8800c57@ventanamicro.com>
Date: Sun, 12 Oct 2025 14:32:41 -0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/6] target/riscv: Add basic definitions and CSRs for
 SMMPT
To: LIU Zhiwei <zhiwei_liu@linux.alibaba.com>, qemu-devel@nongnu.org
Cc: qemu-riscv@nongnu.org, palmer@dabbelt.com, alistair.francis@wdc.com,
 liwei1518@gmail.com, Huang Tao <eric.huang@linux.alibaba.com>,
 TANG Tiancheng <lyndra@linux.alibaba.com>
References: <20250918061911.904-1-zhiwei_liu@linux.alibaba.com>
 <20250918061911.904-2-zhiwei_liu@linux.alibaba.com>
From: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
Content-Language: en-US
In-Reply-To: <20250918061911.904-2-zhiwei_liu@linux.alibaba.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::632;
 envelope-from=dbarboza@ventanamicro.com; helo=mail-pl1-x632.google.com
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



On 9/18/25 3:19 AM, LIU Zhiwei wrote:
> This patch lays the groundwork for the SMMPT (Supervisor Domains Access
> Protection) extension by introducing its fundamental components.
> 
> It adds:
> - New CPU configuration flags, `ext_smmpt` and `ext_smsdid`, to enable
>    the extension.
> - Bit-field definitions for the `mmpt` CSR in `cpu_bits.h`.
> - The `mmpt` and `msdcfg` CSR numbers and their read/write handlers in
>    `csr.c`.
> - New fields in `CPUArchState` to store the state of these new CSRs.
> - A new translation failure reason `TRANSLATE_MPT_FAIL`.
> 
> This provides the necessary infrastructure for the core MPT logic and
> MMU integration that will follow.
> 
> Co-authored-by: Huang Tao <eric.huang@linux.alibaba.com>
> Co-authored-by: TANG Tiancheng <lyndra@linux.alibaba.com>
> Signed-off-by: LIU Zhiwei <zhiwei_liu@linux.alibaba.com>
> ---

Reviewed-by: Daniel Henrique Barboza <dbarboza@ventanamicro.com>

>   target/riscv/cpu.h                |  9 ++-
>   target/riscv/cpu_bits.h           | 27 +++++++++
>   target/riscv/cpu_cfg_fields.h.inc |  2 +
>   target/riscv/csr.c                | 95 +++++++++++++++++++++++++++++++
>   target/riscv/riscv_smmpt.h        | 21 +++++++
>   5 files changed, 153 insertions(+), 1 deletion(-)
>   create mode 100644 target/riscv/riscv_smmpt.h
> 
> diff --git a/target/riscv/cpu.h b/target/riscv/cpu.h
> index 4a862da615..fa7b804cb3 100644
> --- a/target/riscv/cpu.h
> +++ b/target/riscv/cpu.h
> @@ -130,7 +130,8 @@ enum {
>       TRANSLATE_SUCCESS,
>       TRANSLATE_FAIL,
>       TRANSLATE_PMP_FAIL,
> -    TRANSLATE_G_STAGE_FAIL
> +    TRANSLATE_G_STAGE_FAIL,
> +    TRANSLATE_MPT_FAIL
>   };
>   
>   /* Extension context status */
> @@ -180,6 +181,7 @@ extern RISCVCPUImpliedExtsRule *riscv_multi_ext_implied_rules[];
>   #if !defined(CONFIG_USER_ONLY)
>   #include "pmp.h"
>   #include "debug.h"
> +#include "riscv_smmpt.h"
>   #endif
>   
>   #define RV_VLEN_MAX 1024
> @@ -486,6 +488,11 @@ struct CPUArchState {
>       uint64_t hstateen[SMSTATEEN_MAX_COUNT];
>       uint64_t sstateen[SMSTATEEN_MAX_COUNT];
>       uint64_t henvcfg;
> +    /* Smsdid */
> +    uint32_t mptmode;
> +    uint32_t sdid;
> +    uint64_t mptppn;
> +    uint32_t msdcfg;
>   #endif
>   
>       /* Fields from here on are preserved across CPU reset. */
> diff --git a/target/riscv/cpu_bits.h b/target/riscv/cpu_bits.h
> index b62dd82fe7..c6a34863d1 100644
> --- a/target/riscv/cpu_bits.h
> +++ b/target/riscv/cpu_bits.h
> @@ -1164,4 +1164,31 @@ typedef enum CTRType {
>   #define MCONTEXT64                         0x0000000000001FFFULL
>   #define MCONTEXT32_HCONTEXT                0x0000007F
>   #define MCONTEXT64_HCONTEXT                0x0000000000003FFFULL
> +
> +/* Smsdid */
> +#define CSR_MMPT        0xbc0
> +#define CSR_MSDCFG      0xbd1
> +
> +#define MMPT_MODE_MASK_32   0xC0000000
> +#define MMPT_SDID_MASK_32   0x3F000000
> +#define MMPT_PPN_MASK_32    0x003FFFFF
> +
> +#define MMPT_MODE_SHIFT_32  30
> +#define MMPT_SDID_SHIFT_32  24
> +
> +#define MMPT_MODE_MASK_64   0xF000000000000000ULL
> +#define MMPT_SDID_MASK_64   0x0FC0000000000000ULL
> +#define MMPT_PPN_MASK_64    0x000FFFFFFFFFFFFFULL
> +
> +#define MPTE_L3_VALID       0x0000100000000000ULL
> +#define MPTE_L3_RESERVED    0xFFFFE00000000000ULL
> +
> +#define MPTE_L2_RESERVED_64    0xFFFF800000000000ULL
> +#define MPTE_L2_RESERVED_32    0xFE000000
> +
> +#define MPTE_L1_RESERVED_64    0xFFFFFFFF00000000ULL
> +#define MPTE_L1_RESERVED_32    0xFFFF0000
> +
> +#define MMPT_MODE_SHIFT_64  60
> +#define MMPT_SDID_SHIFT_64  54
>   #endif
> diff --git a/target/riscv/cpu_cfg_fields.h.inc b/target/riscv/cpu_cfg_fields.h.inc
> index e2d116f0df..8c8a4ac236 100644
> --- a/target/riscv/cpu_cfg_fields.h.inc
> +++ b/target/riscv/cpu_cfg_fields.h.inc
> @@ -60,6 +60,8 @@ BOOL_FIELD(ext_svpbmt)
>   BOOL_FIELD(ext_svrsw60t59b)
>   BOOL_FIELD(ext_svvptc)
>   BOOL_FIELD(ext_svukte)
> +BOOL_FIELD(ext_smmpt)
> +BOOL_FIELD(ext_smsdid)
>   BOOL_FIELD(ext_zdinx)
>   BOOL_FIELD(ext_zaamo)
>   BOOL_FIELD(ext_zacas)
> diff --git a/target/riscv/csr.c b/target/riscv/csr.c
> index 8842e07a73..e7e85b4310 100644
> --- a/target/riscv/csr.c
> +++ b/target/riscv/csr.c
> @@ -793,6 +793,15 @@ static RISCVException rnmi(CPURISCVState *env, int csrno)
>   
>       return RISCV_EXCP_ILLEGAL_INST;
>   }
> +
> +static RISCVException smsdid(CPURISCVState *env, int csrno)
> +{
> +    if (riscv_cpu_cfg(env)->ext_smsdid) {
> +        return RISCV_EXCP_NONE;
> +    }
> +
> +    return RISCV_EXCP_ILLEGAL_INST;
> +}
>   #endif
>   
>   static RISCVException seed(CPURISCVState *env, int csrno)
> @@ -5470,6 +5479,89 @@ static RISCVException write_mnstatus(CPURISCVState *env, int csrno,
>       return RISCV_EXCP_NONE;
>   }
>   
> +static RISCVException read_mmpt(CPURISCVState *env, int csrno,
> +                                target_ulong *val)
> +{
> +    if (riscv_cpu_xlen(env) == 32) {
> +        uint32_t value = 0;
> +        value |= env->mptmode << MMPT_MODE_SHIFT_32;
> +        value |= (env->sdid << MMPT_SDID_SHIFT_32) & MMPT_SDID_MASK_32;
> +        value |= env->mptppn & MMPT_PPN_MASK_32;
> +        *val = value;
> +    } else if (riscv_cpu_xlen(env) == 64) {
> +        uint64_t value_64 = 0;
> +        uint32_t mode_value = env->mptmode;
> +        /* mpt_mode_t convert to mmpt.mode value */
> +        if (mode_value) {
> +            mode_value -= SMMPT43 - SMMPT34;
> +        }
> +        value_64 |= (uint64_t)mode_value << MMPT_MODE_SHIFT_64;
> +        value_64 |= ((uint64_t)env->sdid << MMPT_SDID_SHIFT_64)
> +                    & MMPT_SDID_MASK_64;
> +        value_64 |= (uint64_t)env->mptppn & MMPT_PPN_MASK_64;
> +        *val = value_64;
> +    } else {
> +        return RISCV_EXCP_ILLEGAL_INST;
> +    }
> +    return RISCV_EXCP_NONE;
> +}
> +
> +static RISCVException write_mmpt(CPURISCVState *env, int csrno,
> +                                 target_ulong val, uintptr_t ra)
> +{
> +    uint32_t mode_value = 0;
> +    if (!riscv_cpu_cfg(env)->ext_smmpt) {
> +        goto set_remaining_fields_zero;
> +    }
> +
> +    if (riscv_cpu_xlen(env) == 32) {
> +        mode_value = (val & MMPT_MODE_MASK_32) >> MMPT_MODE_SHIFT_32;
> +        /* If mode is bare, the remaining fields in mmpt must be zero */
> +        if (mode_value == SMMPTBARE) {
> +            goto set_remaining_fields_zero;
> +        } else if (mode_value <= SMMPT34) {
> +            /* Only write the legal value */
> +            env->mptmode = mode_value;
> +        }
> +        env->sdid = (val & MMPT_SDID_MASK_32) >> MMPT_SDID_SHIFT_32;
> +        env->mptppn = val & MMPT_PPN_MASK_32;
> +    } else if (riscv_cpu_xlen(env) == 64) {
> +        mode_value = (val & MMPT_MODE_MASK_64) >> MMPT_MODE_SHIFT_64;
> +        if (mode_value == SMMPTBARE) {
> +            goto set_remaining_fields_zero;
> +        } else if (mode_value < SMMPTMAX) {
> +            /* convert to mpt_mode_t */
> +            mode_value += SMMPT43 - SMMPT34;
> +            env->mptmode = mode_value;
> +        }
> +        env->sdid = (val & MMPT_SDID_MASK_64) >> MMPT_SDID_SHIFT_64;
> +        env->mptppn = val & MMPT_PPN_MASK_64;
> +    } else {
> +        return RISCV_EXCP_ILLEGAL_INST;
> +    }
> +    return RISCV_EXCP_NONE;
> +
> +set_remaining_fields_zero:
> +    env->sdid = 0;
> +    env->mptmode = SMMPTBARE;
> +    env->mptppn = 0;
> +    return RISCV_EXCP_NONE;
> +}
> +
> +static RISCVException read_msdcfg(CPURISCVState *env, int csrno,
> +                                   target_ulong *val)
> +{
> +    *val = env->msdcfg;
> +    return RISCV_EXCP_NONE;
> +}
> +
> +static RISCVException write_msdcfg(CPURISCVState *env, int csrno,
> +                                    target_ulong val, uintptr_t ra)
> +{
> +    env->msdcfg = val;
> +    return RISCV_EXCP_NONE;
> +}
> +
>   #endif
>   
>   /* Crypto Extension */
> @@ -6666,6 +6758,9 @@ riscv_csr_operations csr_ops[CSR_TABLE_SIZE] = {
>                                write_mhpmcounterh                         },
>       [CSR_SCOUNTOVF]      = { "scountovf", sscofpmf,  read_scountovf,
>                                .min_priv_ver = PRIV_VERSION_1_12_0 },
> +    /* Supervisor Domain Identifier and Protection Registers */
> +    [CSR_MMPT] =    { "mmpt",   smsdid,  read_mmpt,   write_mmpt   },
> +    [CSR_MSDCFG] =  { "msdcfg", smsdid,  read_msdcfg, write_msdcfg },
>   
>   #endif /* !CONFIG_USER_ONLY */
>   };
> diff --git a/target/riscv/riscv_smmpt.h b/target/riscv/riscv_smmpt.h
> new file mode 100644
> index 0000000000..74dcccf4be
> --- /dev/null
> +++ b/target/riscv/riscv_smmpt.h
> @@ -0,0 +1,21 @@
> +/*
> + * QEMU RISC-V Smmpt (Memory Protection Table)
> + *
> + * Copyright (c) 2024 Alibaba Group. All rights reserved.
> + *
> + * SPDX-License-Identifier: GPL-2.0-or-later
> + */
> +
> +#ifndef RISCV_SMMPT_H
> +#define RISCV_SMMPT_H
> +
> +typedef enum {
> +    SMMPTBARE = 0,
> +    SMMPT34   = 1,
> +    SMMPT43   = 2,
> +    SMMPT52   = 3,
> +    SMMPT64   = 4,
> +    SMMPTMAX
> +} mpt_mode_t;
> +
> +#endif


