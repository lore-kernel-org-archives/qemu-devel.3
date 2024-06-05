Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 80134C25B76
	for <qemu-devel@archiver.kernel.org>; Wed,  5 Jun 2024 08:18:46 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sElqD-0005Xp-4n; Wed, 05 Jun 2024 04:17:53 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jason.chien@sifive.com>)
 id 1sElqB-0005XS-Sq
 for qemu-devel@nongnu.org; Wed, 05 Jun 2024 04:17:51 -0400
Received: from mail-pl1-x62b.google.com ([2607:f8b0:4864:20::62b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <jason.chien@sifive.com>)
 id 1sElq9-00024a-DK
 for qemu-devel@nongnu.org; Wed, 05 Jun 2024 04:17:51 -0400
Received: by mail-pl1-x62b.google.com with SMTP id
 d9443c01a7336-1f630e35a01so42727825ad.1
 for <qemu-devel@nongnu.org>; Wed, 05 Jun 2024 01:17:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sifive.com; s=google; t=1717575467; x=1718180267; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=LEj83dBXOu2qEphM6UOhOPo2iklPRANVgHhOpC50vEQ=;
 b=mM3LAQdX0oHEhsE7MN4sHfASxL8rHvGs4Z4ap27Gl7nsRajTf6/CsLHbBJgSIpQfkN
 ixTunQoXHvZJt1ukJaThzfBBKw4dw5ez4I5OUTzgBMrDBUJFb8rap9JCBIKZdOP1/+Ov
 AAnpjCRqDHxs3bLHKf8T4CAXGTOphmSAf/pEl9VJ9fhPM+FWZXkxexzwZVgTvA8soiKp
 aMelOw4dkWB96XZ80fp3biwb6JGc1Xu4PzNrM6/qqJphj6XwF8iqqgFEk4PWK0tWwLFY
 /M3pGkEslS8b0M6aFC1OhkiURg9t7TMQCRQ+Sf5hRcQ9pGPWNwwoYkoD2/GC9hjAU62c
 x7ZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1717575467; x=1718180267;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=LEj83dBXOu2qEphM6UOhOPo2iklPRANVgHhOpC50vEQ=;
 b=bYKPMg33+e36DMiEIHLO/ojNDeCqnMtU2k3m0NWl6bhZngFV422RmL/6RXZrsv5ujS
 /p54lznPVHu0B6jf5d7pJ7lQn3PUYISY/Xp9FyD8tj27kh1HdLGhjacRbWcUT1Lv4meB
 C1YxrvRRYIaAg/UG2JrRUXfgm+TTThfKGij8IDcQjN7MEN6rOVO3VhnxErY/BQOmcPhN
 WeCJAJtLglm+ipkAkRQ1kQjvxCIYM6eJfNrL5ykmGvWPTN3DXUA/Gqn5yThSdRGoAw9D
 8+hUKSFBWFhdUmLaQFsadvgUPJe4Hdcd8T4Yb7z49FOAAFOEi4qBPd8AiPbeRTt1oBx/
 vMEQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCWjm4XHZk5C8DN1sqMDwa9a/krOgA0T4cyCnybnGIK0PU2CasoCkMinZVmND7KT5vYhYSznUsZs4KA0ddXdKkUDrPnlQU4=
X-Gm-Message-State: AOJu0YxQ28M048dcfczLXuSjex+nJuxFY1zg4KNaTva9+Hlr6Hom21Yi
 QjMuD989A/YGUcF9O2zwpW1Xf3PcFYAXK8M0oQyI711p42Q9pasQUwENqoYJ2NI=
X-Google-Smtp-Source: AGHT+IEA4md/zmwhIF35cZzRN7xnGBXm7tnfMofe63MFPhXysOYMOTGVn4wV/+d2MGpiCnZPVbrBPg==
X-Received: by 2002:a17:902:e54f:b0:1f6:7fa4:e064 with SMTP id
 d9443c01a7336-1f6a5a83917mr22629815ad.61.1717575467164; 
 Wed, 05 Jun 2024 01:17:47 -0700 (PDT)
Received: from [192.168.100.252] (59-124-168-89.hinet-ip.hinet.net.
 [59.124.168.89]) by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-1f6323ea10csm96151595ad.201.2024.06.05.01.17.44
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 05 Jun 2024 01:17:46 -0700 (PDT)
Message-ID: <0532dfa4-793d-4c61-a5a5-394f4516f4ab@sifive.com>
Date: Wed, 5 Jun 2024 16:17:43 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH RFC 2/8] target/riscv: Decouple AIA processing from
 xiselect and xireg
To: Atish Patra <atishp@rivosinc.com>, qemu-devel@nongnu.org
Cc: Alistair Francis <alistair.francis@wdc.com>,
 Bin Meng <bin.meng@windriver.com>,
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>,
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>,
 Palmer Dabbelt <palmer@dabbelt.com>, qemu-riscv@nongnu.org,
 Weiwei Li <liwei1518@gmail.com>, kaiwenxue1@gmail.com
References: <20240217000134.3634191-1-atishp@rivosinc.com>
 <20240217000134.3634191-3-atishp@rivosinc.com>
Content-Language: en-US
From: Jason Chien <jason.chien@sifive.com>
In-Reply-To: <20240217000134.3634191-3-atishp@rivosinc.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62b;
 envelope-from=jason.chien@sifive.com; helo=mail-pl1-x62b.google.com
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


Atish Patra 於 2024/2/17 上午 08:01 寫道:
> From: Kaiwen Xue <kaiwenx@rivosinc.com>
>
> Since xiselect and xireg also will be of use in sxcsrind, AIA should
> have its own separated interface when those CSRs are accessed.
>
> Signed-off-by: Atish Patra <atishp@rivosinc.com>
> Signed-off-by: Kaiwen Xue <kaiwenx@rivosinc.com>
> ---
>   target/riscv/csr.c | 147 +++++++++++++++++++++++++++++++++++++--------
>   1 file changed, 122 insertions(+), 25 deletions(-)
>
> diff --git a/target/riscv/csr.c b/target/riscv/csr.c
> index 8829dee7bc75..1af0c8890a2b 100644
> --- a/target/riscv/csr.c
> +++ b/target/riscv/csr.c
> @@ -287,6 +287,15 @@ static int aia_any32(CPURISCVState *env, int csrno)
>       return any32(env, csrno);
>   }
>   
> +static int sxcsrind_or_aia_any(CPURISCVState *env, int csrno)
Could you rename the function as csrind_or_aia_any() to keep the naming 
consistency with aia?
> +{
> +    if (!riscv_cpu_cfg(env)->ext_smaia && !riscv_cpu_cfg(env)->ext_smcsrind) {
> +        return RISCV_EXCP_ILLEGAL_INST;
> +    }
> +
> +    return any(env, csrno);
> +}
> +
>   static RISCVException smode(CPURISCVState *env, int csrno)
>   {
>       if (riscv_has_ext(env, RVS)) {
> @@ -323,6 +332,15 @@ static int aia_smode32(CPURISCVState *env, int csrno)
>       return smode32(env, csrno);
>   }
>   
> +static int sxcsrind_or_aia_smode(CPURISCVState *env, int csrno)
Could you rename the function as csrind_or_aia_smode() to keep the 
naming consistency with aia?
> +{
> +    if (!riscv_cpu_cfg(env)->ext_ssaia && !riscv_cpu_cfg(env)->ext_sscsrind) {
S-mode CSRs are defined in Smaia and Smcsrind as well. We should ensure 
at least one of Smaia, Ssaia, Smcsrind, Sscsrind is enabled.
> +        return RISCV_EXCP_ILLEGAL_INST;
> +    }
> +
> +    return smode(env, csrno);
> +}
> +
>   static RISCVException hmode(CPURISCVState *env, int csrno)
>   {
>       if (riscv_has_ext(env, RVH)) {
> @@ -342,6 +360,15 @@ static RISCVException hmode32(CPURISCVState *env, int csrno)
>   
>   }
>   
> +static int sxcsrind_or_aia_hmode(CPURISCVState *env, int csrno)
Could you rename the function as csrind_or_aia_hmode() to keep the 
naming consistency with aia?
> +{
> +    if (!riscv_cpu_cfg(env)->ext_ssaia && !riscv_cpu_cfg(env)->ext_sscsrind) {
Hypervisor and VS CSRs are defined in Smaia and Smcsrind as well. We 
should ensure at least one of Smaia, Ssaia, Smcsrind, Sscsrind is enabled.
> +        return RISCV_EXCP_ILLEGAL_INST;
> +    }
> +
> +    return hmode(env, csrno);
> +}
> +
>   static RISCVException umode(CPURISCVState *env, int csrno)
>   {
>       if (riscv_has_ext(env, RVU)) {
> @@ -1804,13 +1831,29 @@ static int aia_xlate_vs_csrno(CPURISCVState *env, int csrno)
>       };
>   }
>   
> +static int sxcsrind_xlate_vs_csrno(CPURISCVState *env, int csrno)
Could you rename the function as csrind_xlate_vs_csrno() to keep the 
naming consistency with aia_xlate_vs_csrno()?
> +{
> +    if (!env->virt_enabled) {
> +        return csrno;
> +    }
> +
> +    switch (csrno) {
> +    case CSR_SISELECT:
> +        return CSR_VSISELECT;
> +    case CSR_SIREG:
> +        return CSR_VSIREG;
> +    default:
> +        return csrno;
> +    };
> +}
> +
>   static int rmw_xiselect(CPURISCVState *env, int csrno, target_ulong *val,
>                           target_ulong new_val, target_ulong wr_mask)
>   {
>       target_ulong *iselect;
>   
>       /* Translate CSR number for VS-mode */
> -    csrno = aia_xlate_vs_csrno(env, csrno);
> +    csrno = sxcsrind_xlate_vs_csrno(env, csrno);
>   
>       /* Find the iselect CSR based on CSR number */
>       switch (csrno) {
> @@ -1839,6 +1882,12 @@ static int rmw_xiselect(CPURISCVState *env, int csrno, target_ulong *val,
>       return RISCV_EXCP_NONE;
>   }
>   
> +static bool xiselect_aia_range(target_ulong isel)
> +{
> +    return (ISELECT_IPRIO0 <= isel && isel <= ISELECT_IPRIO15) ||
> +           (ISELECT_IMSIC_FIRST <= isel && isel <= ISELECT_IMSIC_LAST);
> +}
> +
>   static int rmw_iprio(target_ulong xlen,
>                        target_ulong iselect, uint8_t *iprio,
>                        target_ulong *val, target_ulong new_val,
> @@ -1884,44 +1933,44 @@ static int rmw_iprio(target_ulong xlen,
>       return 0;
>   }
>   
> -static int rmw_xireg(CPURISCVState *env, int csrno, target_ulong *val,
> -                     target_ulong new_val, target_ulong wr_mask)
> +static int rmw_xireg_aia(CPURISCVState *env, int csrno,
> +                         target_ulong isel, target_ulong *val,
> +                         target_ulong new_val, target_ulong wr_mask)
>   {
> -    bool virt, isel_reserved;
> -    uint8_t *iprio;
> +    bool virt = false, isel_reserved = false;
>       int ret = -EINVAL;
> -    target_ulong priv, isel, vgein;
> -
> -    /* Translate CSR number for VS-mode */
> -    csrno = aia_xlate_vs_csrno(env, csrno);
> +    uint8_t *iprio;
> +    target_ulong priv, vgein;
>   
> -    /* Decode register details from CSR number */
> -    virt = false;
> -    isel_reserved = false;
> +    /* VS-mode CSR number passed in has already been translated */
>       switch (csrno) {
>       case CSR_MIREG:
> +        if (!riscv_cpu_cfg(env)->ext_smaia) {
> +            goto done;
> +        }
>           iprio = env->miprio;
> -        isel = env->miselect;
>           priv = PRV_M;
>           break;
>       case CSR_SIREG:
> -        if (env->priv == PRV_S && env->mvien & MIP_SEIP &&
> +        if (!riscv_cpu_cfg(env)->ext_ssaia ||
> +            (env->priv == PRV_S && env->mvien & MIP_SEIP &&
>               env->siselect >= ISELECT_IMSIC_EIDELIVERY &&
> -            env->siselect <= ISELECT_IMSIC_EIE63) {
> +            env->siselect <= ISELECT_IMSIC_EIE63)) {
>               goto done;
>           }
>           iprio = env->siprio;
> -        isel = env->siselect;
>           priv = PRV_S;
>           break;
>       case CSR_VSIREG:
> +        if (!riscv_cpu_cfg(env)->ext_ssaia) {
> +            goto done;
> +        }
>           iprio = env->hviprio;
> -        isel = env->vsiselect;
>           priv = PRV_S;
>           virt = true;
>           break;
>       default:
> -         goto done;
> +        goto done;
>       };
>   
>       /* Find the selected guest interrupt file */
> @@ -1952,10 +2001,53 @@ static int rmw_xireg(CPURISCVState *env, int csrno, target_ulong *val,
>       }
>   
>   done:
> +    /*
> +     * If AIA is not enabled, illegal instruction exception is always
> +     * returned regardless of whether we are in VS-mode or not
> +     */
>       if (ret) {
>           return (env->virt_enabled && virt && !isel_reserved) ?
>                  RISCV_EXCP_VIRT_INSTRUCTION_FAULT : RISCV_EXCP_ILLEGAL_INST;
>       }
> +
> +    return RISCV_EXCP_NONE;
> +}
> +
> +static int rmw_xireg(CPURISCVState *env, int csrno, target_ulong *val,
> +                     target_ulong new_val, target_ulong wr_mask)
> +{
> +    bool virt = false;
> +    int ret = -EINVAL;
> +    target_ulong isel;
> +
> +    /* Translate CSR number for VS-mode */
> +    csrno = sxcsrind_xlate_vs_csrno(env, csrno);
> +
> +    /* Decode register details from CSR number */
> +    switch (csrno) {
> +    case CSR_MIREG:
> +        isel = env->miselect;
> +        break;
> +    case CSR_SIREG:
> +        isel = env->siselect;
> +        break;
> +    case CSR_VSIREG:
> +        isel = env->vsiselect;
> +        virt = true;
> +        break;
> +    default:
> +         goto done;
> +    };
> +
> +    if (xiselect_aia_range(isel)) {
> +        return rmw_xireg_aia(env, csrno, isel, val, new_val, wr_mask);
> +    }
> +
> +done:
> +    if (ret) {
> +        return (env->virt_enabled && virt) ?
> +               RISCV_EXCP_VIRT_INSTRUCTION_FAULT : RISCV_EXCP_ILLEGAL_INST;
A virtual instruction exception is raised for attempts from VS-mode or 
VU-mode to directly access vsiselect or vsireg* in riscv_csrrw_check(), 
we don't need to check again here.
> +    }
>       return RISCV_EXCP_NONE;
>   }
>   
> @@ -4682,8 +4774,10 @@ riscv_csr_operations csr_ops[CSR_TABLE_SIZE] = {
>       [CSR_MIP]      = { "mip",      any,  NULL,    NULL, rmw_mip        },
>   
>       /* Machine-Level Window to Indirectly Accessed Registers (AIA) */
> -    [CSR_MISELECT] = { "miselect", aia_any,   NULL, NULL,    rmw_xiselect },
> -    [CSR_MIREG]    = { "mireg",    aia_any,   NULL, NULL,    rmw_xireg },
> +    [CSR_MISELECT] = { "miselect", sxcsrind_or_aia_any,   NULL, NULL,
> +                       rmw_xiselect                                    },
> +    [CSR_MIREG]    = { "mireg",    sxcsrind_or_aia_any,   NULL, NULL,
> +                       rmw_xireg                                       },
>   
>       /* Machine-Level Interrupts (AIA) */
>       [CSR_MTOPEI]   = { "mtopei",   aia_any, NULL, NULL, rmw_xtopei },
> @@ -4801,8 +4895,10 @@ riscv_csr_operations csr_ops[CSR_TABLE_SIZE] = {
>       [CSR_SATP]     = { "satp",     satp, read_satp,     write_satp     },
>   
>       /* Supervisor-Level Window to Indirectly Accessed Registers (AIA) */
> -    [CSR_SISELECT]   = { "siselect",   aia_smode, NULL, NULL, rmw_xiselect },
> -    [CSR_SIREG]      = { "sireg",      aia_smode, NULL, NULL, rmw_xireg },
> +    [CSR_SISELECT]   = { "siselect",   sxcsrind_or_aia_smode, NULL, NULL,
> +                         rmw_xiselect                                       },
> +    [CSR_SIREG]      = { "sireg",      sxcsrind_or_aia_smode, NULL, NULL,
> +                         rmw_xireg                                          },
>   
>       /* Supervisor-Level Interrupts (AIA) */
>       [CSR_STOPEI]     = { "stopei",     aia_smode, NULL, NULL, rmw_xtopei },
> @@ -4881,9 +4977,10 @@ riscv_csr_operations csr_ops[CSR_TABLE_SIZE] = {
>       /*
>        * VS-Level Window to Indirectly Accessed Registers (H-extension with AIA)
>        */
> -    [CSR_VSISELECT]   = { "vsiselect",   aia_hmode, NULL, NULL,
> -                          rmw_xiselect                                     },
> -    [CSR_VSIREG]      = { "vsireg",      aia_hmode, NULL, NULL, rmw_xireg  },
> +    [CSR_VSISELECT]   = { "vsiselect",   sxcsrind_or_aia_hmode, NULL, NULL,
> +                          rmw_xiselect                                      },
> +    [CSR_VSIREG]      = { "vsireg",      sxcsrind_or_aia_hmode, NULL, NULL,
> +                          rmw_xireg                                         },
>   
>       /* VS-Level Interrupts (H-extension with AIA) */
>       [CSR_VSTOPEI]     = { "vstopei",     aia_hmode, NULL, NULL, rmw_xtopei },

