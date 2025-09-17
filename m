Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1A948CAC598
	for <qemu-devel@archiver.kernel.org>; Wed, 17 Sep 2025 11:17:36 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uyq9Z-0002pU-OD; Wed, 17 Sep 2025 07:16:49 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dbarboza@ventanamicro.com>)
 id 1uyq9X-0002p8-CX
 for qemu-devel@nongnu.org; Wed, 17 Sep 2025 07:16:47 -0400
Received: from mail-yw1-x112c.google.com ([2607:f8b0:4864:20::112c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <dbarboza@ventanamicro.com>)
 id 1uyq9Q-0004uz-CX
 for qemu-devel@nongnu.org; Wed, 17 Sep 2025 07:16:47 -0400
Received: by mail-yw1-x112c.google.com with SMTP id
 00721157ae682-723bc91d7bbso56201757b3.3
 for <qemu-devel@nongnu.org>; Wed, 17 Sep 2025 04:16:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=ventanamicro.com; s=google; t=1758107799; x=1758712599; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=gfooqCPdo9DGFNKzHgfUsaomv9B++V/+6K04xinZRgk=;
 b=k8Jumd6kuILK2q1XtI1pg6MaGwgojQ4D0Ywd2wYpZKPAN8/+lB+swquASXcyyWQjWn
 tosHXtze07kZzrvH+5FWJ5ndL0dM8RZFc1qF8TET6L6KHWGIrQJv4lfnGow4goFixWzt
 OKBwT+yU9lJjajqP5egDxFOeP3lZxvx9kWEGg0s6IHnpaIMUbi6XJpfIncwFYQWAX+QP
 hVmo1sjjJh+tr6QLuLPmnsCZRf82pi3yb5MH7Qh9wdcgbiKUlWJ6zh6j+9uzm6vhhUTg
 vtFfsWVHzW79mGDfJSHC9nhqii7cPIZL3qk9UX58FT0OrseTO5TVA0iRT5CEmgHAC7GA
 lWtw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1758107799; x=1758712599;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=gfooqCPdo9DGFNKzHgfUsaomv9B++V/+6K04xinZRgk=;
 b=q77iAD3+LQFt9Q5+8KgefPcpuG+5MRolMoTYCea2LE5gLZmm3+d0jHwouWaXdQDO6T
 tsM93xA4s/xvxRAFXP2U4yf4T4mLOOYxbNNE6+wRYCBg+CKL1UOxj7zK/2+410ikcjoQ
 g2D8HMUzkNVhqg7MQTETF4OaOd4Ic3NooQJIGrkNM+7EkcepwI900TnEXBgpXG0jeEHS
 rybWOZpPpdLphUeEhaouCFMY77f63mz/qQRcTH5WcnmTFKxtGYSNk1/FmieVMtxaTHZ9
 GYdDKBYzWyk8EEYxs12YVF3cxDkKHSASbOoNYa3IZ7tR4GbH2oWNCgaBzb7zJBQCYaJb
 gZTw==
X-Forwarded-Encrypted: i=1;
 AJvYcCUIx9o0eGsoXDxmgm8EsYtpqSc4PYUWe71KvYdwSfrYSNQHf+uQH8SLK+tr0YO9b/lxzAwQtVfkfEB3@nongnu.org
X-Gm-Message-State: AOJu0Yxccr3mT2OhGopEn7QuxXXoYHYjBWmo5TCTvB7NI2i55VBP8/UV
 yxpVF+K/x6ojZsSzO3yT63EH5LTo4S739ZFKHFO1Su/aaFql3pQS6vm8ThjWSF6xtAQ=
X-Gm-Gg: ASbGncupkuxRCo4XNu75R0+iWTiiunOc9Gnm76+F1jtjzIqmQbQ6X8nio6TYGCI+zDG
 Orvc/yJPnhNzsosNGcI1TeHIusSHDqvXndFG+1hGci/MEbqsnXSjJ9n0pnQI7jdJWl17ktPW3J9
 RwfG2B8Qe42y8fiZj14bd9TsGJRmJU+Phdz3OtxuDehMWj0uGK/IA7NDw5oG1/jztczOqTCn7q0
 83lxBJzNfxqYy/kgolPcQgqFB2tESASZE/Tk0OEGOVUiZjjsZlc6OOCZ7C65uizSMudf3DP+ghr
 vExXug+8vnxioNE3rPCxiISjMwANS7JWOX1IcuebXJ/gwHZXUSAb5bd0FeAJ+2W5cEgP4skGAkW
 Q54WTpO3UbmR1A9UluFoqKs4J9Hzc14NvKfhhlJSdmDaZ0LKRSD6RtxMhKP4Zmp0cVMwVKfq1i1
 wt
X-Google-Smtp-Source: AGHT+IHbXfw0YWvJtVE3dzIlEDhr7Gwm+SXX6iZkrg2K3+cvPV5V+TnVu/78je8Exi+HrJyD3S5dQg==
X-Received: by 2002:a05:690c:dc8:b0:71b:69fd:257b with SMTP id
 00721157ae682-7388d713b62mr12713387b3.0.1758107798535; 
 Wed, 17 Sep 2025 04:16:38 -0700 (PDT)
Received: from ?IPV6:2804:7f0:bcc0:ba1a:8719:7c4c:526a:fdea?
 ([2804:7f0:bcc0:ba1a:8719:7c4c:526a:fdea])
 by smtp.gmail.com with ESMTPSA id
 00721157ae682-72f791a35bcsm46231297b3.39.2025.09.17.04.16.36
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 17 Sep 2025 04:16:37 -0700 (PDT)
Message-ID: <71565bcc-9d7a-4fbc-be4f-aa77e8679831@ventanamicro.com>
Date: Wed, 17 Sep 2025 08:16:34 -0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH 1/5] target/riscv: Add basic definitions and CSRs for
 SMMPT
To: LIU Zhiwei <zhiwei_liu@linux.alibaba.com>, qemu-devel@nongnu.org
Cc: qemu-riscv@nongnu.org, palmer@dabbelt.com, alistair.francis@wdc.com,
 liwei1518@gmail.com, Huang Tao <eric.huang@linux.alibaba.com>,
 TANG Tiancheng <lyndra@linux.alibaba.com>
References: <20250909132533.32205-1-zhiwei_liu@linux.alibaba.com>
 <20250909132533.32205-2-zhiwei_liu@linux.alibaba.com>
From: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
Content-Language: en-US
In-Reply-To: <20250909132533.32205-2-zhiwei_liu@linux.alibaba.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::112c;
 envelope-from=dbarboza@ventanamicro.com; helo=mail-yw1-x112c.google.com
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



On 9/9/25 10:25 AM, LIU Zhiwei wrote:
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
>   target/riscv/cpu.h                |  9 +++-
>   target/riscv/cpu_bits.h           | 27 ++++++++++
>   target/riscv/cpu_cfg_fields.h.inc |  2 +
>   target/riscv/csr.c                | 83 +++++++++++++++++++++++++++++++
>   4 files changed, 120 insertions(+), 1 deletion(-)
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
> index 8842e07a73..77bc596ed3 100644
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
> @@ -5470,6 +5479,77 @@ static RISCVException write_mnstatus(CPURISCVState *env, int csrno,
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
> +            mode_value -= SMMTT43 - SMMTT34;
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
> +    /* Fixme: if mode is bare, the remaining fields in mmpt must be zero */
> +    if (riscv_cpu_xlen(env) == 32) {
> +        /* Only write the legal value */
> +        uint32_t mode_value = (val & MMPT_MODE_MASK_32) >> MMPT_MODE_SHIFT_32;
> +        if (mode_value <= SMMTT34) {
> +            env->mptmode = mode_value;
> +        }
> +        env->sdid = (val & MMPT_SDID_MASK_32) >> MMPT_SDID_SHIFT_32;
> +        env->mptppn = val & MMPT_PPN_MASK_32;
> +    } else if (riscv_cpu_xlen(env) == 64) {
> +        uint32_t mode_value = (val & MMPT_MODE_MASK_64) >> MMPT_MODE_SHIFT_64;
> +        /* check legal value */
> +        if (mode_value < SMMTTMAX) {
> +            /* convert to mpt_mode_t */
> +            if (mode_value) {
> +                mode_value += SMMTT43 - SMMTT34;
> +            }
> +            env->mptmode = mode_value;
> +        }
> +        env->sdid = (val & MMPT_SDID_MASK_64) >> MMPT_SDID_SHIFT_64;
> +        env->mptppn = val & MMPT_PPN_MASK_64;
> +    } else {
> +        return RISCV_EXCP_ILLEGAL_INST;
> +    }
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
> @@ -6666,6 +6746,9 @@ riscv_csr_operations csr_ops[CSR_TABLE_SIZE] = {
>                                write_mhpmcounterh                         },
>       [CSR_SCOUNTOVF]      = { "scountovf", sscofpmf,  read_scountovf,
>                                .min_priv_ver = PRIV_VERSION_1_12_0 },
> +    /* Supervisor Domain Identifier and Protection Registers */
> +    [CSR_MMPT] =    { "mmpt",   smsdid,  read_mmpt,   write_mmpt   },
> +    [CSR_MSDCFG] =  { "msdcfg", smsdid,  read_msdcfg, write_msdcfg },

I see that you added ext_smmpt but ended up not using in this patch. Shouldn't
read_mmpt and write_mmpt dependent on ext_smmpt?


Thanks,

Daniel

>   
>   #endif /* !CONFIG_USER_ONLY */
>   };


