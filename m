Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5E015C04FFE
	for <qemu-devel@archiver.kernel.org>; Sat, 11 May 2024 14:43:50 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s5nvn-0000SB-OE; Sat, 11 May 2024 10:42:35 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <liwei1518@gmail.com>)
 id 1s5nWN-0004zy-43; Sat, 11 May 2024 10:16:19 -0400
Received: from mail-pf1-x42e.google.com ([2607:f8b0:4864:20::42e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <liwei1518@gmail.com>)
 id 1s5nWJ-0004xK-Kb; Sat, 11 May 2024 10:16:18 -0400
Received: by mail-pf1-x42e.google.com with SMTP id
 d2e1a72fcca58-6f44dc475f4so2453964b3a.2; 
 Sat, 11 May 2024 07:16:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1715436974; x=1716041774; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=r5x98VahclHZ7BtaGFSPvYPQ6HFNNJQAdz9ld6rWCoU=;
 b=XqkuWycWHIGIw6rG5XbHxGfxju0fliFEVn1YjLeSW3hnGPNP1T6jzb5YBjijQQZkXt
 WY8gVx87rmJF3VaM6dM7ZsCVydHQ775sCVBBfw+mfAWZAqB2jYYVmAyhTvdTA1feZvOh
 XX3caYODfcOsCn4Ed/Yt4CTaGsWuKGQc44UEDnZ8jbRgVUeRarHGGx56rYgQhG+0WL++
 V4WBv/qkhRKctesitkkFdmTLflA7h21qmzYsLjK2cct/HlruzQVLj6N1nV122yR31AmS
 bedTy/E9YErmde9pn3PYj0QkDU8HZs1pcEGckcA2qLprVwYCD87emfN7rPNya6v/17o0
 /2TQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1715436974; x=1716041774;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=r5x98VahclHZ7BtaGFSPvYPQ6HFNNJQAdz9ld6rWCoU=;
 b=BwrkXHQKK+XgHEdTfEWrU7lbNi9QHDF8x7sVMnRibEEZoLJaOcahMjvnisTlD4zBYb
 aA2/kiYPzSHezJLfwDv9FqXhwBu5eYk0ZKcnsQUScHUDouT7OdIcYctY2yzLxsLtqoqi
 IVtbN5wT7cCxFjRs2iMhSLO3Jkve52dbJm3SO6MmcHc2sJxLsvxq3wHiJZziONOVbiG5
 6uYWiM3dF/CDql+BDDQ/NHm/ZR0tzEm3rvRszykfgL9NnPOqTtnkn9JK1RBGkqaKq/fj
 stf4xW+/qSy0pxb/XIkR8YtwyfDZexSz/EO9wDPvEzHch7tE/V/2uX+eJzrBjJvy/V/d
 2lkw==
X-Forwarded-Encrypted: i=1;
 AJvYcCVhl2MvtSnyGid8mn9xHEP4QdaHWP1E9KasBG7DaTUSND6uH5VKP7LyA8uzskgTa4Tw2887jG5bx6uBWr+ZE2HifNTCnirflTS3IQ5eXBMf9b8wUGyoRt1y9xEhWg==
X-Gm-Message-State: AOJu0YxRUc2F69XLx3co0Zp+z4a8qaDMwRrHUMq8OeTQnZsu38NaCYvW
 AyPcJ2ld5hyyzgE+6CgnfKN3DDcIBpaz2FFCzTiqKmH/uDWAJbLV0pvzcvdW
X-Google-Smtp-Source: AGHT+IH75eEQBk5MhnjnMpmIiA2h97KDFfJVHFMBMg0VSnivK6YOexO5BNhv4cx/kQ3YdoX9NXRryQ==
X-Received: by 2002:a05:6a20:5607:b0:1af:dc74:a34a with SMTP id
 adf61e73a8af0-1afde0e6081mr5524619637.20.1715436973630; 
 Sat, 11 May 2024 07:16:13 -0700 (PDT)
Received: from [192.168.0.120] ([114.95.238.28])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-6f4d2aa017dsm4651662b3a.96.2024.05.11.07.16.10
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sat, 11 May 2024 07:16:13 -0700 (PDT)
Message-ID: <f39ed3c3-1ddb-4faf-91e7-d6a533df4b14@gmail.com>
Date: Sat, 11 May 2024 22:16:08 +0800
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
From: liwei <liwei1518@gmail.com>
In-Reply-To: <20240511101053.1875596-3-me@deliversmonkey.space>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::42e;
 envelope-from=liwei1518@gmail.com; helo=mail-pf1-x42e.google.com
X-Spam_score_int: -17
X-Spam_score: -1.8
X-Spam_bar: -
X-Spam_report: (-1.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FREEMAIL_ENVFROM_END_DIGIT=0.25, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-Mailman-Approved-At: Sat, 11 May 2024 10:42:31 -0400
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


On 2024/5/11 18:10, Alexey Baturo wrote:
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

Extension and RV64 check seems missed here.This field is added by smnpm, 
So I think it's can only be changed only when smnpm is enabled.

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
>       RISCVException ret
similar to above.
> ;
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

similar to above too.

Regards,

Weiwei Li

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

