Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AD390C25B76
	for <qemu-devel@archiver.kernel.org>; Mon,  3 Jun 2024 03:48:54 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sDyg2-0001Q6-4k; Sun, 02 Jun 2024 23:48:06 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dbarboza@ventanamicro.com>)
 id 1sDyg0-0001Lf-Gs
 for qemu-devel@nongnu.org; Sun, 02 Jun 2024 23:48:04 -0400
Received: from mail-pf1-x432.google.com ([2607:f8b0:4864:20::432])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <dbarboza@ventanamicro.com>)
 id 1sDuC4-0005SP-N8
 for qemu-devel@nongnu.org; Sun, 02 Jun 2024 19:00:55 -0400
Received: by mail-pf1-x432.google.com with SMTP id
 d2e1a72fcca58-702447766fdso2722925b3a.1
 for <qemu-devel@nongnu.org>; Sun, 02 Jun 2024 16:00:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=ventanamicro.com; s=google; t=1717369251; x=1717974051; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=p4y1UPcwh05bv68DDAz+lJMvVuXZvniLnfQQqNeP5/U=;
 b=dABqebN/u1VO/wpUPUQtbNXMZmbWbZpOfmjX4pgCsA/WDJm0MPuWIzJrHh7uF+x3n4
 ZgDTm50QNnXbA6f/qULk9/EyhnxVFvVui1tv+BZyvMI2EqauzpOKweuuVePdzvv/hG/o
 c/0ywZbZNMcJcocuRjZ49XSNPObG6+WFP+nneEkrvwEDMqqRyF8B1D9AH/MLjyrqeH5+
 Nvz8sV/uRObAgkdVhKNKDoZKSeXXoKlOO7RKYa/dYlZhhCjkPqGKzixi0ZkoB11UbbU6
 LT+xRLWrYYFAQGSWnOSVo9lQkPKFFVpeTKEvtbB0R5E1YN7ko7l/6JYR8y0FUScFI017
 0pFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1717369251; x=1717974051;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=p4y1UPcwh05bv68DDAz+lJMvVuXZvniLnfQQqNeP5/U=;
 b=rIPA5L1XgYW+C5eWWkEoevc42edBaC9rJiOqNyVcdemaI/GKPI7BdUDPN9xc7pC7uC
 b7cQ1BovMXeJLO8bTQ11v9tvy6wNL4N94u05Ss/9aBp80keH3Zxtipv5rqIs2FBTnO21
 qQMsxNTNXFJwGCBhwSeyiTsiXfAryOrxUujF6smoO97LMSSMsnNZqu4Ge4ZEKxciGY1T
 nvpNw8UYYEMwi0hlsSSXGlSvYO4MhoJjWkVgln+VpktqADnM4LSRzexDEgo+Q6GA+zlB
 zGRHGWR+puwqDiGLlqxTJM5DEpncy+4KDlzqWtb0PoRkpKbCgfpumywb8YBqzke9YPC1
 dAEg==
X-Forwarded-Encrypted: i=1;
 AJvYcCWmhL+JceAzZnWbHKIxVT+Z1++ksOeDC98BzYLRUZXZbdsKNQUcuAOdCyRCnVu4kR8K381O6/wHPzO9l0shpuYZCRHeGRM=
X-Gm-Message-State: AOJu0YzB3hB8FYkygHkI6UVzjbwwJdteyyC3vj7QhyrtBS9GekaEGeQF
 dAY476997XJsBJpZcjbqXYkikLpjY7OpAiW3XA2licIwMmQsZfd6pIbjKq3nBdI=
X-Google-Smtp-Source: AGHT+IG41SXiufbU/2/s/D0l8QKk9xX/bkWDBjeF4n32obkZPmbKBf468LelhD8P1vjb1dAluXEM5A==
X-Received: by 2002:aa7:8890:0:b0:702:2d79:f4e5 with SMTP id
 d2e1a72fcca58-702477be3bbmr9553495b3a.5.1717369250578; 
 Sun, 02 Jun 2024 16:00:50 -0700 (PDT)
Received: from [192.168.68.109] (189-69-160-78.dial-up.telesp.net.br.
 [189.69.160.78]) by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-6c355aeaae3sm4370170a12.43.2024.06.02.16.00.47
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sun, 02 Jun 2024 16:00:50 -0700 (PDT)
Message-ID: <fe9a662e-1d35-4e6a-9a79-419d64b87a88@ventanamicro.com>
Date: Sun, 2 Jun 2024 20:00:45 -0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v9 2/6] target/riscv: Add new CSR fields for S{sn, mn,
 m}pm extensions as part of Zjpm v0.8
To: Alexey Baturo <baturo.alexey@gmail.com>
Cc: richard.henderson@linaro.org, space.monkey.delivers@gmail.com,
 palmer@dabbelt.com, Alistair.Francis@wdc.com, sagark@eecs.berkeley.edu,
 kbastian@mail.uni-paderborn.de, qemu-devel@nongnu.org, qemu-riscv@nongnu.org
References: <20240511101053.1875596-1-me@deliversmonkey.space>
 <20240511101053.1875596-3-me@deliversmonkey.space>
Content-Language: en-US
From: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
In-Reply-To: <20240511101053.1875596-3-me@deliversmonkey.space>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::432;
 envelope-from=dbarboza@ventanamicro.com; helo=mail-pf1-x432.google.com
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



On 5/11/24 7:10 AM, Alexey Baturo wrote:
> From: Alexey Baturo <baturo.alexey@gmail.com>
> 
> Signed-off-by: Alexey Baturo <baturo.alexey@gmail.com>
> 
> Reviewed-by: Alistair Francis <alistair.francis@wdc.com>
> ---
>   target/riscv/cpu.h      |  8 ++++++++
>   target/riscv/cpu_bits.h |  3 +++
>   target/riscv/cpu_cfg.h  |  3 +++
>   target/riscv/csr.c      | 11 +++++++++++
>   target/riscv/machine.c  | 10 +++++++---
>   target/riscv/pmp.c      | 13 ++++++++++---
>   target/riscv/pmp.h      | 11 ++++++-----
>   7 files changed, 48 insertions(+), 11 deletions(-)
> 
> diff --git a/target/riscv/cpu.h b/target/riscv/cpu.h
> index 232521bb87..52b6ba73c8 100644
> --- a/target/riscv/cpu.h
> +++ b/target/riscv/cpu.h
> @@ -121,6 +121,14 @@ typedef enum {
>       EXT_STATUS_DIRTY,
>   } RISCVExtStatus;
>   
> +/* Enum holds PMM field values for Zjpm v0.8 extension */
> +typedef enum {
> +    PMM_FIELD_DISABLED = 0,
> +    PMM_FIELD_RESERVED = 1,
> +    PMM_FIELD_PMLEN7   = 2,
> +    PMM_FIELD_PMLEN16  = 3,
> +} RISCVPmPmm;
> +
>   #define MMU_USER_IDX 3
>   
>   #define MAX_RISCV_PMPS (16)
> diff --git a/target/riscv/cpu_bits.h b/target/riscv/cpu_bits.h
> index da16ba236a..13ce2218d1 100644
> --- a/target/riscv/cpu_bits.h
> +++ b/target/riscv/cpu_bits.h
> @@ -708,6 +708,7 @@ typedef enum RISCVException {
>   #define MENVCFG_CBIE                       (3UL << 4)
>   #define MENVCFG_CBCFE                      BIT(6)
>   #define MENVCFG_CBZE                       BIT(7)
> +#define MENVCFG_PMM                        (3ULL << 32)
>   #define MENVCFG_ADUE                       (1ULL << 61)
>   #define MENVCFG_PBMTE                      (1ULL << 62)
>   #define MENVCFG_STCE                       (1ULL << 63)
> @@ -721,11 +722,13 @@ typedef enum RISCVException {
>   #define SENVCFG_CBIE                       MENVCFG_CBIE
>   #define SENVCFG_CBCFE                      MENVCFG_CBCFE
>   #define SENVCFG_CBZE                       MENVCFG_CBZE
> +#define SENVCFG_PMM                        MENVCFG_PMM
>   
>   #define HENVCFG_FIOM                       MENVCFG_FIOM
>   #define HENVCFG_CBIE                       MENVCFG_CBIE
>   #define HENVCFG_CBCFE                      MENVCFG_CBCFE
>   #define HENVCFG_CBZE                       MENVCFG_CBZE
> +#define HENVCFG_PMM                        MENVCFG_PMM
>   #define HENVCFG_ADUE                       MENVCFG_ADUE
>   #define HENVCFG_PBMTE                      MENVCFG_PBMTE
>   #define HENVCFG_STCE                       MENVCFG_STCE
> diff --git a/target/riscv/cpu_cfg.h b/target/riscv/cpu_cfg.h
> index e1e4f32698..9ecdc792c5 100644
> --- a/target/riscv/cpu_cfg.h
> +++ b/target/riscv/cpu_cfg.h
> @@ -120,6 +120,9 @@ struct RISCVCPUConfig {
>       bool ext_ssaia;
>       bool ext_sscofpmf;
>       bool ext_smepmp;
> +    bool ext_ssnpm;
> +    bool ext_smnpm;
> +    bool ext_smmpm;
>       bool rvv_ta_all_1s;
>       bool rvv_ma_all_1s;
>   
> diff --git a/target/riscv/csr.c b/target/riscv/csr.c
> index 4b2c932564..45b548eb0b 100644
> --- a/target/riscv/csr.c
> +++ b/target/riscv/csr.c
> @@ -530,6 +530,9 @@ static RISCVException have_mseccfg(CPURISCVState *env, int csrno)
>       if (riscv_cpu_cfg(env)->ext_zkr) {
>           return RISCV_EXCP_NONE;
>       }
> +    if (riscv_cpu_cfg(env)->ext_smmpm) {
> +        return RISCV_EXCP_NONE;
> +    }
>   
>       return RISCV_EXCP_ILLEGAL_INST;
>   }
> @@ -2083,6 +2086,10 @@ static RISCVException write_menvcfg(CPURISCVState *env, int csrno,
>                   (cfg->ext_sstc ? MENVCFG_STCE : 0) |
>                   (cfg->ext_svadu ? MENVCFG_ADUE : 0);
>       }
> +    /* Update PMM field only if the value is valid according to Zjpm v0.8 */
> +    if (((val & MENVCFG_PMM) >> 32) != PMM_FIELD_RESERVED) {
> +        mask |= MENVCFG_PMM;
> +    }
>       env->menvcfg = (env->menvcfg & ~mask) | (val & mask);
>   
>       return RISCV_EXCP_NONE;
> @@ -2127,6 +2134,10 @@ static RISCVException write_senvcfg(CPURISCVState *env, int csrno,
>                                       target_ulong val)
>   {
>       uint64_t mask = SENVCFG_FIOM | SENVCFG_CBIE | SENVCFG_CBCFE | SENVCFG_CBZE;
> +    /* Update PMM field only if the value is valid according to Zjpm v0.8 */
> +    if (((val & SENVCFG_PMM) >> 32) != PMM_FIELD_RESERVED) {
> +        mask |= SENVCFG_PMM;
> +    }
>       RISCVException ret;
>   
>       ret = smstateen_acc_ok(env, 0, SMSTATEEN0_HSENVCFG);
> diff --git a/target/riscv/machine.c b/target/riscv/machine.c
> index 64ab66e332..bbbb28f373 100644
> --- a/target/riscv/machine.c
> +++ b/target/riscv/machine.c
> @@ -152,15 +152,19 @@ static const VMStateDescription vmstate_vector = {
>   
>   static bool pointermasking_needed(void *opaque)
>   {
> -    return false;
> +    RISCVCPU *cpu = opaque;
> +    return cpu->cfg.ext_ssnpm || cpu->cfg.ext_smnpm || cpu->cfg.ext_smmpm;
>   }
>   
>   static const VMStateDescription vmstate_pointermasking = {
>       .name = "cpu/pointer_masking",
> -    .version_id = 1,
> -    .minimum_version_id = 1,
> +    .version_id = 2,
> +    .minimum_version_id = 2,
>       .needed = pointermasking_needed,
>       .fields = (const VMStateField[]) {
> +        VMSTATE_UINTTL(env.mseccfg, RISCVCPU),
> +        VMSTATE_UINTTL(env.senvcfg, RISCVCPU),
> +        VMSTATE_UINTTL(env.menvcfg, RISCVCPU),
>           VMSTATE_END_OF_LIST()
>       }


These fields are already being added in the machine vmstate via vmstate_envcfg,
added via commit 29a9ec9b, "target/riscv: Add *envcfg* CSRs support":


static const VMStateDescription vmstate_envcfg = {
     .name = "cpu/envcfg",
     .version_id = 1,
     .minimum_version_id = 1,
     .needed = envcfg_needed,
     .fields = (const VMStateField[]) {
         VMSTATE_UINT64(env.menvcfg, RISCVCPU),
         VMSTATE_UINTTL(env.senvcfg, RISCVCPU),
         VMSTATE_UINT64(env.henvcfg, RISCVCPU),
         VMSTATE_END_OF_LIST()
     }
};

You need to keep both pointermasking_needed() and vmstate_pointermasking
untouched. Doing that will also fix the build problem that Alistair mentioned
in his reply.


Thanks,

Daniel

>   };
> diff --git a/target/riscv/pmp.c b/target/riscv/pmp.c
> index 2a76b611a0..7ddb9dbf0b 100644
> --- a/target/riscv/pmp.c
> +++ b/target/riscv/pmp.c
> @@ -574,6 +574,12 @@ target_ulong pmpaddr_csr_read(CPURISCVState *env, uint32_t addr_index)
>   void mseccfg_csr_write(CPURISCVState *env, target_ulong val)
>   {
>       int i;
> +    uint64_t mask = MSECCFG_MMWP | MSECCFG_MML;
> +
> +    /* Update PMM field only if the value is valid according to Zjpm v0.8 */
> +    if (((val & MSECCFG_PMM) >> 32) != PMM_FIELD_RESERVED) {
> +        mask |= MSECCFG_PMM;
> +    }
>   
>       trace_mseccfg_csr_write(env->mhartid, val);
>   
> @@ -589,12 +595,13 @@ void mseccfg_csr_write(CPURISCVState *env, target_ulong val)
>   
>       if (riscv_cpu_cfg(env)->ext_smepmp) {
>           /* Sticky bits */
> -        val |= (env->mseccfg & (MSECCFG_MMWP | MSECCFG_MML));
> -        if ((val ^ env->mseccfg) & (MSECCFG_MMWP | MSECCFG_MML)) {
> +        val |= (env->mseccfg & mask);
> +        if ((val ^ env->mseccfg) & mask) {
>               tlb_flush(env_cpu(env));
>           }
>       } else {
> -        val &= ~(MSECCFG_MMWP | MSECCFG_MML | MSECCFG_RLB);
> +        mask |= MSECCFG_RLB;
> +        val &= ~(mask);
>       }
>   
>       env->mseccfg = val;
> diff --git a/target/riscv/pmp.h b/target/riscv/pmp.h
> index f5c10ce85c..ccff0eb9b6 100644
> --- a/target/riscv/pmp.h
> +++ b/target/riscv/pmp.h
> @@ -40,11 +40,12 @@ typedef enum {
>   } pmp_am_t;
>   
>   typedef enum {
> -    MSECCFG_MML   = 1 << 0,
> -    MSECCFG_MMWP  = 1 << 1,
> -    MSECCFG_RLB   = 1 << 2,
> -    MSECCFG_USEED = 1 << 8,
> -    MSECCFG_SSEED = 1 << 9
> +    MSECCFG_MML       = 1 << 0,
> +    MSECCFG_MMWP      = 1 << 1,
> +    MSECCFG_RLB       = 1 << 2,
> +    MSECCFG_USEED     = 1 << 8,
> +    MSECCFG_SSEED     = 1 << 9,
> +    MSECCFG_PMM       = 3UL << 32,
>   } mseccfg_field_t;
>   
>   typedef struct {

