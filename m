Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 41FC7CF857F
	for <qemu-devel@archiver.kernel.org>; Thu, 20 Nov 2025 11:31:48 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vM2sV-0007Mw-25; Thu, 20 Nov 2025 06:31:07 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dbarboza@ventanamicro.com>)
 id 1vM2sR-0007MO-NY
 for qemu-devel@nongnu.org; Thu, 20 Nov 2025 06:31:03 -0500
Received: from mail-ot1-x32b.google.com ([2607:f8b0:4864:20::32b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <dbarboza@ventanamicro.com>)
 id 1vM2sO-0006g1-Uz
 for qemu-devel@nongnu.org; Thu, 20 Nov 2025 06:31:03 -0500
Received: by mail-ot1-x32b.google.com with SMTP id
 46e09a7af769-7c75a5cb752so488932a34.2
 for <qemu-devel@nongnu.org>; Thu, 20 Nov 2025 03:30:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=ventanamicro.com; s=google; t=1763638258; x=1764243058; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=bWM7SOnj8IXxnsjvITWtruLHxXr9gFoRWbtc0wMT8/M=;
 b=OYeoNRl4ICxWG27Q9VpmMZ0nqeeMsuuhWNBVmKyG7NzJD+6N2EWGN95idtGXq44z8u
 Yq+aXAkMEjq49Dhtej/TaNhAUhXK85Kf4j1FDxim4KWmmDuiVqenomLmQSeQRHclGuA7
 OrRdG1u0h4g/77kauT3gcLsWgVbWoZjc9/qHEDlE1WTNwL5EixNn+puNPt2ivlnCwOkj
 RUrN9Dush4K+UEgkDzHqwE0g3asF7opaFdg+2nQ9SXs/Q0JxeoxC8MDf/8awwgA16vEO
 WbC1go24BPLE+RMg3mFjXUoLvmx9DTSraD/UYvaTt2gVC6IOv/FB6ISoFC8u3+sXdJcV
 HmGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1763638258; x=1764243058;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=bWM7SOnj8IXxnsjvITWtruLHxXr9gFoRWbtc0wMT8/M=;
 b=YdTat7l41UTM3fYDYWd8WxGRPDQbift9dShGCznMIQ2O02jGrok2/8ngKN0HKbJiQX
 IOG0Q1zBXKkKZ18oApvdqWJwgE0lOo1XqJPYXjtsJJkIiJu2swOGDidHmSlamCBpxDLu
 Mbhcbat7HN+pQSCJjNQddGsh+0aIu/8H7N5ri/2fEKXA2B5Nx+IJ9M4FOGIGyfJ/Kezc
 P2tPuIzKQ6spMsNNYaBp8XGqv7CVd8qfru8knuZqpQsQfXSTy1n0YA9+2xFzbM1yeZl9
 JHPcZkXo3aCexSInWc4zqIvM8kEVg9yg3DloUl+ggvOb+gGkfwA/c9PHPZ6DbL5mxbl2
 P1sQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCUYNe+BC51UcZyKhdtMA/UjuYjAKGBbx21VJ5MFa/UaZnmGUmUBaD6TiAB2nZpRaWc0psAeyaBYa3Ew@nongnu.org
X-Gm-Message-State: AOJu0YynxNmHZHW80E/HObB1Sns4wclAV5SNOcBRLVtEkHgHhVyK5zmp
 Csa3ChIiHhGIBHMd4LhYsncDxoMOCrTxxL+X9q9wef9GVv+YfsTOO8ob7x0b7DA6vUQ=
X-Gm-Gg: ASbGnctGCRUMQwkbww0eP95r1B4pc7UIgi8RrqWNEAmphp7vfsHDVIFi9XvQ6ngUQ+E
 boiQVgxs0ft1tY+Jnzi3k0TKZE9gENoC6XbVAa9arpBuzmh9/g0sqbS0c3l1Rt8SSB882UfIgG+
 EE5FvSKAM1Uptumtqiy1HSYavMzP1ULUvTixvJtWAkrIEJJ6ES/rp31x+AfTTuaQv7lK9K83pON
 ALkQzlyhUpaRxxTyhtxY03X0dKxQWUAoLfvdkMNatoHyRWMnsfeZmF1swC73nXW9uLsAYlLfqyB
 Bew0+7ITlf4qFXZVYs5UOuRkRJ8TWYszE786Zl6E1C5sw57KwVSS9TZH9fdINwaET1tUMmFoMs8
 5Hd5QhpyoRWp2cgaFfSF+PnwwuNVXKTlunLv5vK1/gHChSU6KSRiicnh+3XtzX/XoyLmTXgxbIa
 YIvQxah6UxF07VQH8bxSOEcr8elGc=
X-Google-Smtp-Source: AGHT+IHtZ1Rswo0oTDU8Z9h8JiUVaWMzHUr8/mj5Z6InfErs4zNtC+GJABD9YCo/RrjgZc2Wv9EMhA==
X-Received: by 2002:a05:6830:304e:b0:7c7:2e9d:aee1 with SMTP id
 46e09a7af769-7c78f40bc1bmr1001933a34.19.1763638258346; 
 Thu, 20 Nov 2025 03:30:58 -0800 (PST)
Received: from [192.168.68.110] ([177.188.133.235])
 by smtp.gmail.com with ESMTPSA id
 46e09a7af769-7c78d30475asm893622a34.3.2025.11.20.03.30.52
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 20 Nov 2025 03:30:57 -0800 (PST)
Message-ID: <3592062a-f5f1-4350-87c1-ee9c4753ba15@ventanamicro.com>
Date: Thu, 20 Nov 2025 08:30:50 -0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/7] riscv: implement Ssqosid extension and srmcfg CSR
To: Drew Fustini <fustini@kernel.org>, qemu-devel@nongnu.org
Cc: Palmer Dabbelt <palmer@dabbelt.com>,
 Alistair Francis <Alistair.Francis@wdc.com>, Weiwei Li
 <liwei1518@gmail.com>, Liu Zhiwei <zhiwei_liu@linux.alibaba.com>,
 qemu-riscv@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>,
 Nicolas Pitre <npitre@baylibre.com>, =?UTF-8?Q?Kornel_Dul=C4=99ba?=
 <mindal@semihalf.com>, Atish Kumar Patra <atishp@rivosinc.com>,
 Atish Patra <atish.patra@linux.dev>, Vasudevan Srinivasan
 <vasu@rivosinc.com>, =?UTF-8?B?UmFkaW0gS3LEjW3DocWZ?=
 <rkrcmar@ventanamicro.com>, yunhui cui <cuiyunhui@bytedance.com>,
 Chen Pei <cp0613@linux.alibaba.com>, guo.wenjia23@zte.com.cn,
 liu.qingtao2@zte.com.cn
References: <20251119-riscv-ssqosid-cbqri-v1-0-3392fc760e48@kernel.org>
 <20251119-riscv-ssqosid-cbqri-v1-1-3392fc760e48@kernel.org>
From: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
Content-Language: en-US
In-Reply-To: <20251119-riscv-ssqosid-cbqri-v1-1-3392fc760e48@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::32b;
 envelope-from=dbarboza@ventanamicro.com; helo=mail-ot1-x32b.google.com
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



On 11/19/25 9:42 PM, Drew Fustini wrote:
> From: Kornel Dulęba <mindal@semihalf.com>
> 
> Implement the srmcfg CSR defined by the Ssqosid ISA extension
> (Supervisor-mode Quality of Service ID). The CSR contains two fields:
> 
>    - Resource Control ID (RCID) used determine resource allocation
>    - Monitoring Counter ID (MCID) used to track resource usage
> 
> The CSR is defined for S-mode but accessing it when V=1 shall cause a
> virtual instruction exception. Implement this behavior by calling the
> hmode predicate.
> 
> Link: https://github.com/riscv-non-isa/riscv-cbqri/releases/download/v1.0/riscv-cbqri.pdf
> Signed-off-by: Kornel Dulęba <mindal@semihalf.com>
> [fustini: rebase on v10.1.50, fix check_srmcfg]
> Signed-off-by: Drew Fustini <fustini@kernel.org>
> ---
>   disas/riscv.c                     |  1 +
>   target/riscv/cpu.c                |  2 ++
>   target/riscv/cpu.h                |  3 +++
>   target/riscv/cpu_bits.h           |  8 ++++++++
>   target/riscv/cpu_cfg_fields.h.inc |  1 +
>   target/riscv/csr.c                | 34 ++++++++++++++++++++++++++++++++++
>   6 files changed, 49 insertions(+)
> 
> diff --git a/disas/riscv.c b/disas/riscv.c
> index 85cd2a9c2aef..86fc710528c1 100644
> --- a/disas/riscv.c
> +++ b/disas/riscv.c
> @@ -2289,6 +2289,7 @@ static const char *csr_name(int csrno)
>       case 0x0143: return "stval";
>       case 0x0144: return "sip";
>       case 0x0180: return "satp";
> +    case 0x0181: return "srmcfg";
>       case 0x0200: return "hstatus";
>       case 0x0202: return "hedeleg";
>       case 0x0203: return "hideleg";
> diff --git a/target/riscv/cpu.c b/target/riscv/cpu.c
> index 73d4280d7c84..2e2e642de26b 100644
> --- a/target/riscv/cpu.c
> +++ b/target/riscv/cpu.c
> @@ -216,6 +216,7 @@ const RISCVIsaExtData isa_edata_arr[] = {
>       ISA_EXT_DATA_ENTRY(ssdbltrp, PRIV_VERSION_1_13_0, ext_ssdbltrp),
>       ISA_EXT_DATA_ENTRY(ssnpm, PRIV_VERSION_1_13_0, ext_ssnpm),
>       ISA_EXT_DATA_ENTRY(sspm, PRIV_VERSION_1_13_0, ext_sspm),
> +    ISA_EXT_DATA_ENTRY(ssqosid, PRIV_VERSION_1_12_0, ext_ssqosid),
>       ISA_EXT_DATA_ENTRY(ssstateen, PRIV_VERSION_1_12_0, ext_ssstateen),
>       ISA_EXT_DATA_ENTRY(ssstrict, PRIV_VERSION_1_12_0, has_priv_1_12),
>       ISA_EXT_DATA_ENTRY(sstc, PRIV_VERSION_1_12_0, ext_sstc),
> @@ -1268,6 +1269,7 @@ const RISCVCPUMultiExtConfig riscv_cpu_extensions[] = {
>       MULTI_EXT_CFG_BOOL("zvfbfwma", ext_zvfbfwma, false),
>       MULTI_EXT_CFG_BOOL("zvfh", ext_zvfh, false),
>       MULTI_EXT_CFG_BOOL("zvfhmin", ext_zvfhmin, false),
> +    MULTI_EXT_CFG_BOOL("ssqosid", ext_ssqosid, true),
>       MULTI_EXT_CFG_BOOL("sstc", ext_sstc, true),
>       MULTI_EXT_CFG_BOOL("ssnpm", ext_ssnpm, false),
>       MULTI_EXT_CFG_BOOL("sspm", ext_sspm, false),
> diff --git a/target/riscv/cpu.h b/target/riscv/cpu.h
> index 36e7f100374d..21688d8ca002 100644
> --- a/target/riscv/cpu.h
> +++ b/target/riscv/cpu.h
> @@ -336,6 +336,9 @@ struct CPUArchState {
>       uint64_t ctr_dst[16 << SCTRDEPTH_MAX];
>       uint64_t ctr_data[16 << SCTRDEPTH_MAX];
>   
> +    /* Ssqosid extension */
> +    target_ulong srmcfg;
> +
>       /* Machine and Supervisor interrupt priorities */
>       uint8_t miprio[64];
>       uint8_t siprio[64];
> diff --git a/target/riscv/cpu_bits.h b/target/riscv/cpu_bits.h
> index b62dd82fe7c0..ebb400bf6f2c 100644
> --- a/target/riscv/cpu_bits.h
> +++ b/target/riscv/cpu_bits.h
> @@ -228,6 +228,9 @@
>   #define CSR_SPTBR           0x180
>   #define CSR_SATP            0x180
>   
> +/* Ssqosid extension */
> +#define CSR_SRMCFG          0x181
> +
>   /* Supervisor-Level Window to Indirectly Accessed Registers (AIA) */
>   #define CSR_SISELECT        0x150
>   #define CSR_SIREG           0x151
> @@ -1164,4 +1167,9 @@ typedef enum CTRType {
>   #define MCONTEXT64                         0x0000000000001FFFULL
>   #define MCONTEXT32_HCONTEXT                0x0000007F
>   #define MCONTEXT64_HCONTEXT                0x0000000000003FFFULL
> +
> +/* SRMCFG CSR field masks (Ssqosid extensions) */
> +#define SRMCFG_RCID                      0x00000FFF
> +#define SRMCFG_MCID                      0x0FFF0000
> +
>   #endif
> diff --git a/target/riscv/cpu_cfg_fields.h.inc b/target/riscv/cpu_cfg_fields.h.inc
> index a154ecdc792b..6518f6f9c571 100644
> --- a/target/riscv/cpu_cfg_fields.h.inc
> +++ b/target/riscv/cpu_cfg_fields.h.inc
> @@ -105,6 +105,7 @@ BOOL_FIELD(ext_ssaia)
>   BOOL_FIELD(ext_smctr)
>   BOOL_FIELD(ext_ssctr)
>   BOOL_FIELD(ext_sscofpmf)
> +BOOL_FIELD(ext_ssqosid)
>   BOOL_FIELD(ext_smepmp)
>   BOOL_FIELD(ext_smrnmi)
>   BOOL_FIELD(ext_ssnpm)
> diff --git a/target/riscv/csr.c b/target/riscv/csr.c
> index 5c91658c3dc4..06a6212c672d 100644
> --- a/target/riscv/csr.c
> +++ b/target/riscv/csr.c
> @@ -1759,6 +1759,37 @@ static RISCVException write_stimecmph(CPURISCVState *env, int csrno,
>       return RISCV_EXCP_NONE;
>   }
>   
> +static RISCVException check_srmcfg(CPURISCVState *env, int csrno)
> +{
> +    RISCVCPU *cpu = env_archcpu(env);
> +
> +    if (!cpu->cfg.ext_ssqosid) {
> +        return RISCV_EXCP_ILLEGAL_INST;
> +    }

env_archcpu() is a bit heavyweight and we usually avoid it. Since you're using the 'cpu' ptr
solely to access the CFG pointer I suggest using riscv_cpu_cfg() instead:

if (!riscv_cpu_cfg(env)->ext_ssqosid) {...}


Thanks,

Daniel

> +
> +    /*
> +     * Even though this is an S-mode CSR the spec says that we need to throw
> +     * and virt instruction fault if a guest tries to access it.
> +     */
> +    return env->virt_enabled ?
> +           RISCV_EXCP_VIRT_INSTRUCTION_FAULT : smode(env, csrno);
> +}
> +
> +static RISCVException read_srmcfg(CPURISCVState *env, int csrno,
> +                                  target_ulong *val)
> +{
> +    *val = env->srmcfg;
> +    return RISCV_EXCP_NONE;
> +}
> +
> +static RISCVException write_srmcfg(CPURISCVState *env, int csrno,
> +                                   target_ulong val, uintptr_t ra)
> +{
> +    env->srmcfg = val & (SRMCFG_RCID | SRMCFG_MCID);
> +    return RISCV_EXCP_NONE;
> +}
> +
> +
>   #define VSTOPI_NUM_SRCS 5
>   
>   /*
> @@ -6035,6 +6066,9 @@ riscv_csr_operations csr_ops[CSR_TABLE_SIZE] = {
>       /* Supervisor Protection and Translation */
>       [CSR_SATP]     = { "satp",     satp, read_satp,     write_satp     },
>   
> +    /* Supervisor-Level Quality-of-Service Identifiers (Ssqosid) */
> +    [CSR_SRMCFG]   = { "srmcfg",  check_srmcfg, read_srmcfg, write_srmcfg },
> +
>       /* Supervisor-Level Window to Indirectly Accessed Registers (AIA) */
>       [CSR_SISELECT]   = { "siselect",   csrind_or_aia_smode, NULL, NULL,
>                            rmw_xiselect                                       },
> 


