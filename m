Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7146CC25B78
	for <qemu-devel@archiver.kernel.org>; Tue,  4 Jun 2024 10:15:36 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sERBb-0006fI-Fh; Tue, 04 Jun 2024 06:14:35 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jason.chien@sifive.com>)
 id 1sERBZ-0006dA-0f
 for qemu-devel@nongnu.org; Tue, 04 Jun 2024 06:14:33 -0400
Received: from mail-pl1-x62f.google.com ([2607:f8b0:4864:20::62f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <jason.chien@sifive.com>)
 id 1sERBW-0000kp-4M
 for qemu-devel@nongnu.org; Tue, 04 Jun 2024 06:14:32 -0400
Received: by mail-pl1-x62f.google.com with SMTP id
 d9443c01a7336-1f47f07acd3so7723675ad.0
 for <qemu-devel@nongnu.org>; Tue, 04 Jun 2024 03:14:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sifive.com; s=google; t=1717496068; x=1718100868; darn=nongnu.org;
 h=in-reply-to:from:content-language:references:cc:to:subject
 :user-agent:mime-version:date:message-id:from:to:cc:subject:date
 :message-id:reply-to;
 bh=ohH2CE4Aa+EFMZj4nIK/fCdlHTNN4SZO7xcBNi8AmYw=;
 b=go0VDM3U3hkgpmwvQY/fa9T2epmMX+IpwvQTREkavQdBFeKkkYKoxN5G/rCrs1bHWO
 MpTkAUeePTsPj/215W7I/U70JM26b/A9qvXiSEwhGaAoRqNTBVnZh2Et543Lq5t+Kl4L
 +KPoNZG7OKIudl29kRcV1I8tyrB/FejpMmx2t2XFSgn5m/0Aptxrz6alRuATP0K1eOwN
 ZcLUyi7+sfq4MXRZUkhMXo+t1m3gNspKhL5QYqRT1Emk5RQPD6hI++BFyPvgSyCSDQXi
 tNeEwqim60LE7/KLNbo0JLsvv0kX+9sPBuBsQXToHIXgRexk/1SMr48PL3x4NdiuxpQU
 OilA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1717496068; x=1718100868;
 h=in-reply-to:from:content-language:references:cc:to:subject
 :user-agent:mime-version:date:message-id:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=ohH2CE4Aa+EFMZj4nIK/fCdlHTNN4SZO7xcBNi8AmYw=;
 b=l6MhfPpxNx4Oz3qNCXrDS6xOg5Ta/MmU+51F/NcIbUMHJVgLkBz6oGW47NOzhRzDNJ
 6K87wtXuHDkZt9wGjkxG8dMF6K9/TKmrbasc4RlJ7XKlch+xyG4k4J1H5C7r6M2kz6j/
 lacv73w+DpStc0PShPgsLeOh0Bxhc/C8vPxhCz/1C5FzUfnEeZ2kfqqcHsKQQmFWaicE
 31GOTdUchgSRI7FChNQH+CuPsm+Y7W/f398qSQAIX20uet8M60Yu2PBDF8SGZWvT0ptB
 3X7UinqWBo9HrkDO5zBgeT648Z9oagU2Q/ojn9Mc8xswdzRBb7uSI1MaxUXekeEcSA0o
 9JVQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCXYlyFhoxGaWdptFwMEYlvDR9Fg04/bXNkhMpPwHI5yiKh+vKm7sbQwVwsb9WUT1p3pCNj21WpTdp1IOQgVORYNcTiPlKQ=
X-Gm-Message-State: AOJu0YwONPtxSxmGbmgmPgJhIRykS2ZPEILXb/EKKHVKRyn1gyNpm0Uy
 2wRUTf5zbyISyYdAtOOJV+JhnNOmarSMlW1QeG/a6dRrb9Vprn/6XksGSJ+2XGU=
X-Google-Smtp-Source: AGHT+IHkMwqbboo7QRnJVps70A/GXpg/wteA6CDX26+Fl/ALXcedb5KUXm7FDELvuPBmRBhbe4sUew==
X-Received: by 2002:a17:902:c94c:b0:1f6:5a50:93b3 with SMTP id
 d9443c01a7336-1f65a509712mr97772515ad.43.1717496068239; 
 Tue, 04 Jun 2024 03:14:28 -0700 (PDT)
Received: from [192.168.100.252] (59-124-168-89.hinet-ip.hinet.net.
 [59.124.168.89]) by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-1f63241c392sm79119095ad.291.2024.06.04.03.14.25
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 04 Jun 2024 03:14:27 -0700 (PDT)
Content-Type: multipart/alternative;
 boundary="------------HdwHUJx5fdBvZT0cld0x6xoB"
Message-ID: <3f3cc0f1-0a56-452a-a934-b3f770056570@sifive.com>
Date: Tue, 4 Jun 2024 18:14:24 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 3/6] target/riscv: Add support for Control Transfer
 Records extension CSRs.
To: Rajnesh Kanwal <rkanwal@rivosinc.com>, qemu-riscv@nongnu.org,
 qemu-devel@nongnu.org
Cc: alistair.francis@wdc.com, bin.meng@windriver.com, liweiwei@iscas.ac.cn,
 dbarboza@ventanamicro.com, zhiwei_liu@linux.alibaba.com,
 atishp@rivosinc.com, apatel@ventanamicro.com, beeman@rivosinc.com,
 tech-control-transfer-records@lists.riscv.org
References: <20240529160950.132754-1-rkanwal@rivosinc.com>
 <20240529160950.132754-4-rkanwal@rivosinc.com>
Content-Language: en-US
From: Jason Chien <jason.chien@sifive.com>
In-Reply-To: <20240529160950.132754-4-rkanwal@rivosinc.com>
Received-SPF: pass client-ip=2607:f8b0:4864:20::62f;
 envelope-from=jason.chien@sifive.com; helo=mail-pl1-x62f.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, HTML_MESSAGE=0.001,
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

This is a multi-part message in MIME format.
--------------HdwHUJx5fdBvZT0cld0x6xoB
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit


Rajnesh Kanwal 於 2024/5/30 上午 12:09 寫道:
> This commit adds support for [m|s|vs]ctrcontrol, sctrstatus and
> sctrdepth CSRs handling.
>
> Signed-off-by: Rajnesh Kanwal<rkanwal@rivosinc.com>
> ---
>   target/riscv/cpu.h     |   5 ++
>   target/riscv/cpu_cfg.h |   2 +
>   target/riscv/csr.c     | 159 +++++++++++++++++++++++++++++++++++++++++
>   3 files changed, 166 insertions(+)
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
> index 2f92e4b717..888084d8e5 100644
> --- a/target/riscv/csr.c
> +++ b/target/riscv/csr.c
> @@ -621,6 +621,61 @@ static RISCVException pointer_masking(CPURISCVState *env, int csrno)
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
> + * Otherwise allow vsctrctl, sctrstatus, 0x200-0x2ff entry range.
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
> +    if ((env->priv == PRV_M && riscv_cpu_cfg(env)->ext_smctr) ||
> +        (env->priv == PRV_S && !env->virt_enabled &&
> +         riscv_cpu_cfg(env)->ext_ssctr)) {
> +        return smstateen_acc_ok(env, 0, SMSTATEEN0_CTR);
> +    }
> +
> +    if (env->priv == PRV_S && env->virt_enabled &&
> +        riscv_cpu_cfg(env)->ext_ssctr) {
> +        if (csrno == CSR_SCTRSTATUS) {
missing sctrctl?
> +            return smstateen_acc_ok(env, 0, SMSTATEEN0_CTR);
> +        }
> +
> +        return RISCV_EXCP_VIRT_INSTRUCTION_FAULT;
> +    }
> +
> +    return RISCV_EXCP_ILLEGAL_INST;
> +}

I think there is no need to bind M-mode with ext_smctr, S-mode with 
ext_ssctr and VS-mode with ext_ssctr, since this predicate function is 
for S-mode CSRs, which are defined in both smctr and ssctr, we just need 
to check at least one of ext_ssctr or ext_smctr is true.

The spec states that:
Attempts to access sctrdepth from VS-mode or VU-mode raise a 
virtual-instruction exception, unless CTR state enable access 
restrictions apply.

In my understanding, we should check the presence of smstateen extension 
first, and

if smstateen is implemented:

  * for sctrctl and sctrstatus, call smstateen_acc_ok()
  * for sctrdepth, call smstateen_acc_ok(), and if there is any
    exception returned, always report virtual-instruction exception.

If smstateen is not implemented:

  * for sctrctl and sctrstatus, there is no check.
  * for sctrdepth, I think the spec is ambiguous. What does "CTR state
    enable access restrictions apply" mean when smstateen is not
    implemented?

Here is the code to better understand my description.

static RISCVException ctr_smode(CPURISCVState *env, int csrno)
{
     const RISCVCPUConfig *cfg = riscv_cpu_cfg(env);

     if (!cfg->ext_ssctr && !cfg->ext_smctr) {
         return RISCV_EXCP_ILLEGAL_INST;
     }

     if (riscv_cpu_cfg(env)->ext_smstateen) {
         RISCVException ret = smstateen_acc_ok(env, 0, SMSTATEEN0_CTR);
         if (ret != RISCV_EXCP_NONE) {
             if (csrno == CSR_SCTRDEPTH && env->virt_enabled) {
                 return RISCV_EXCP_VIRT_INSTRUCTION_FAULT;
             }

             return ret;
         }
     } else {
         /* The spec is ambiguous. */
         if (csrno == CSR_SCTRDEPTH && env->virt_enabled) {
             return RISCV_EXCP_VIRT_INSTRUCTION_FAULT;
         }
     }

     return RISCV_EXCP_NONE;
}

> +
> +static RISCVException ctr_vsmode(CPURISCVState *env, int csrno)
> +{
> +    if (env->priv == PRV_S && env->virt_enabled &&
> +        riscv_cpu_cfg(env)->ext_ssctr) {
> +        return smstateen_acc_ok(env, 0, SMSTATEEN0_CTR);
In riscv_csrrw_check(), an virtual-instruction exception is always 
reported no matter what. Do we need this check?
> +    }
> +
> +    return ctr_smode(env, csrno);
> +}
> +
>   static RISCVException aia_hmode(CPURISCVState *env, int csrno)
>   {
>       int ret;
> @@ -3835,6 +3890,100 @@ static RISCVException write_satp(CPURISCVState *env, int csrno,
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
> +        *ret_val = env->sctrdepth & SCTRDEPTH_MASK;
We don't need to do bitwise and with SCTRDEPTH_MASK on read accesses 
when we always do bitwise and with SCTRDEPTH_MASK on write accesses.
> +    }
> +
> +    env->sctrdepth = (env->sctrdepth & ~mask) | (new_val & mask);
> +
> +    /* Correct depth. */
> +    if (wr_mask & SCTRDEPTH_MASK) {
> +        uint64_t depth = get_field(env->sctrdepth, SCTRDEPTH_MASK);
> +
> +        if (depth > SCTRDEPTH_MAX) {
> +            env->sctrdepth =
> +                set_field(env->sctrdepth, SCTRDEPTH_MASK, SCTRDEPTH_MAX);
> +        }
> +
> +        /* Update sctrstatus.WRPTR with a legal value */
> +        depth = 16 << depth;
The "depth" on the right side may exceed SCTRDEPTH_MAX.
> +        env->sctrstatus =
> +            env->sctrstatus & (~SCTRSTATUS_WRPTR_MASK | (depth - 1));
> +    }
> +
> +    return RISCV_EXCP_NONE;
> +}
> +
> +static RISCVException rmw_mctrctl(CPURISCVState *env, int csrno,
> +                                    target_ulong *ret_val,
> +                                    target_ulong new_val, target_ulong wr_mask)
> +{
> +    uint64_t mask = wr_mask & MCTRCTL_MASK;
> +
> +    if (ret_val) {
> +        *ret_val = env->mctrctl & MCTRCTL_MASK;
There is no need to do bitwise and with the mask on read accesses when 
we always do bitwise and with the mask on write accesses.
> +    }
> +
> +    env->mctrctl = (env->mctrctl & ~mask) | (new_val & mask);
> +
> +    return RISCV_EXCP_NONE;
> +}
> +
> +static RISCVException rmw_sctrctl(CPURISCVState *env, int csrno,
> +                                    target_ulong *ret_val,
> +                                    target_ulong new_val, target_ulong wr_mask)
> +{
> +    uint64_t mask = wr_mask & SCTRCTL_MASK;
> +    RISCVException ret;
> +
> +    ret = rmw_mctrctl(env, csrno, ret_val, new_val, mask);
When V=1, vsctrctl substitutes for sctrctl.
> +    if (ret_val) {
> +        *ret_val &= SCTRCTL_MASK;
> +    }
> +
> +    return ret;
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
> +        *ret_val = env->sctrstatus & SCTRSTATUS_MASK;
There is no need to do bitwise and with the mask on read accesses when 
we always do bitwise and with the mask on write accesses.
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
> +static RISCVException rmw_vsctrctl(CPURISCVState *env, int csrno,
> +                                    target_ulong *ret_val,
> +                                    target_ulong new_val, target_ulong wr_mask)
> +{
> +    uint64_t mask = wr_mask & VSCTRCTL_MASK;
> +
> +    if (ret_val) {
> +        *ret_val = env->vsctrctl & VSCTRCTL_MASK;
There is no need to do bitwise and with the mask on read accesses when 
we always do bitwise and with the mask on write accesses.
> +    }
> +
> +    env->vsctrctl = (env->vsctrctl & ~mask) | (new_val & mask);
> +
> +    return RISCV_EXCP_NONE;
> +}
Is it possible to define rmw_xctrctl() instead of three individual rmw 
functions and use a switch case to select the mask and the CSR for the 
purpose of reducing code size?
> +
>   static RISCVException read_vstopi(CPURISCVState *env, int csrno,
>                                     target_ulong *val)
>   {
> @@ -5771,6 +5920,16 @@ riscv_csr_operations csr_ops[CSR_TABLE_SIZE] = {
>       [CSR_SPMBASE] =    { "spmbase", pointer_masking, read_spmbase,
>                            write_spmbase                                      },
>   
> +    [CSR_MCTRCTL]       = { "mctrctl",       ctr_mmode, NULL, NULL,
> +                                rmw_mctrctl },
I think this can be one line.
> +    [CSR_SCTRCTL]       = { "sctrctl",       ctr_smode, NULL, NULL,
> +                                rmw_sctrctl },
same here
> +    [CSR_SCTRDEPTH]       = { "sctrdepth",       ctr_smode, NULL, NULL,
> +                                rmw_sctrdepth },
same here
> +    [CSR_SCTRSTATUS]       = { "sctrstatus",       ctr_smode, NULL, NULL,
> +                                rmw_sctrstatus },
same here
> +    [CSR_VSCTRCTL]      = { "vsctrctl",      ctr_vsmode, NULL, NULL,
> +                                rmw_vsctrctl },
same here
>       /* Performance Counters */
>       [CSR_HPMCOUNTER3]    = { "hpmcounter3",    ctr,    read_hpmcounter },
>       [CSR_HPMCOUNTER4]    = { "hpmcounter4",    ctr,    read_hpmcounter },
--------------HdwHUJx5fdBvZT0cld0x6xoB
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: 8bit

<!DOCTYPE html>
<html>
  <head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
  </head>
  <body>
    <p><br>
    </p>
    <div class="moz-cite-prefix">Rajnesh Kanwal 於 2024/5/30 上午 12:09 寫道:<br>
    </div>
    <blockquote type="cite"
      cite="mid:20240529160950.132754-4-rkanwal@rivosinc.com">
      <pre class="moz-quote-pre" wrap="">This commit adds support for [m|s|vs]ctrcontrol, sctrstatus and
sctrdepth CSRs handling.

Signed-off-by: Rajnesh Kanwal <a class="moz-txt-link-rfc2396E" href="mailto:rkanwal@rivosinc.com">&lt;rkanwal@rivosinc.com&gt;</a>
---
 target/riscv/cpu.h     |   5 ++
 target/riscv/cpu_cfg.h |   2 +
 target/riscv/csr.c     | 159 +++++++++++++++++++++++++++++++++++++++++
 3 files changed, 166 insertions(+)

diff --git a/target/riscv/cpu.h b/target/riscv/cpu.h
index a185e2d494..3d4d5172b8 100644
--- a/target/riscv/cpu.h
+++ b/target/riscv/cpu.h
@@ -263,6 +263,11 @@ struct CPUArchState {
     target_ulong mcause;
     target_ulong mtval;  /* since: priv-1.10.0 */
 
+    uint64_t mctrctl;
+    uint32_t sctrdepth;
+    uint32_t sctrstatus;
+    uint64_t vsctrctl;
+
     /* Machine and Supervisor interrupt priorities */
     uint8_t miprio[64];
     uint8_t siprio[64];
diff --git a/target/riscv/cpu_cfg.h b/target/riscv/cpu_cfg.h
index d9354dc80a..d329a65811 100644
--- a/target/riscv/cpu_cfg.h
+++ b/target/riscv/cpu_cfg.h
@@ -123,6 +123,8 @@ struct RISCVCPUConfig {
     bool ext_zvfhmin;
     bool ext_smaia;
     bool ext_ssaia;
+    bool ext_smctr;
+    bool ext_ssctr;
     bool ext_sscofpmf;
     bool ext_smepmp;
     bool rvv_ta_all_1s;
diff --git a/target/riscv/csr.c b/target/riscv/csr.c
index 2f92e4b717..888084d8e5 100644
--- a/target/riscv/csr.c
+++ b/target/riscv/csr.c
@@ -621,6 +621,61 @@ static RISCVException pointer_masking(CPURISCVState *env, int csrno)
     return RISCV_EXCP_ILLEGAL_INST;
 }
 
+/*
+ * M-mode:
+ * Without ext_smctr raise illegal inst excep.
+ * Otherwise everything is accessible to m-mode.
+ *
+ * S-mode:
+ * Without ext_ssctr or mstateen.ctr raise illegal inst excep.
+ * Otherwise everything other than mctrctl is accessible.
+ *
+ * VS-mode:
+ * Without ext_ssctr or mstateen.ctr raise illegal inst excep.
+ * Without hstateen.ctr raise virtual illegal inst excep.
+ * Otherwise allow vsctrctl, sctrstatus, 0x200-0x2ff entry range.
+ * Always raise illegal instruction exception for sctrdepth.
+ */
+static RISCVException ctr_mmode(CPURISCVState *env, int csrno)
+{
+    /* Check if smctr-ext is present */
+    if (riscv_cpu_cfg(env)-&gt;ext_smctr) {
+        return RISCV_EXCP_NONE;
+    }
+
+    return RISCV_EXCP_ILLEGAL_INST;
+}
+
+static RISCVException ctr_smode(CPURISCVState *env, int csrno)
+{
+    if ((env-&gt;priv == PRV_M &amp;&amp; riscv_cpu_cfg(env)-&gt;ext_smctr) ||
+        (env-&gt;priv == PRV_S &amp;&amp; !env-&gt;virt_enabled &amp;&amp;
+         riscv_cpu_cfg(env)-&gt;ext_ssctr)) {
+        return smstateen_acc_ok(env, 0, SMSTATEEN0_CTR);
+    }
+
+    if (env-&gt;priv == PRV_S &amp;&amp; env-&gt;virt_enabled &amp;&amp;
+        riscv_cpu_cfg(env)-&gt;ext_ssctr) {
+        if (csrno == CSR_SCTRSTATUS) {</pre>
    </blockquote>
    missing sctrctl?<br>
    <blockquote type="cite"
      cite="mid:20240529160950.132754-4-rkanwal@rivosinc.com">
      <pre class="moz-quote-pre" wrap="">
+            return smstateen_acc_ok(env, 0, SMSTATEEN0_CTR);
+        }
+
+        return RISCV_EXCP_VIRT_INSTRUCTION_FAULT;
+    }
+
+    return RISCV_EXCP_ILLEGAL_INST;
+}</pre>
    </blockquote>
    <p>I think there is no need to bind M-mode with ext_smctr, S-mode
      with ext_ssctr and VS-mode with ext_ssctr, since this predicate
      function is for S-mode CSRs, which are defined in both smctr and
      ssctr, we just need to check at least one of ext_ssctr or
      ext_smctr is true.</p>
    <p>The spec states that:<br>
      Attempts to access sctrdepth from VS-mode or VU-mode raise a
      virtual-instruction exception, unless CTR state enable access
      restrictions apply.</p>
    <p>In my understanding, we should check the presence of smstateen
      extension first, and</p>
    <p>if smstateen is implemented:</p>
    <ul>
      <li>for sctrctl and sctrstatus, call smstateen_acc_ok()</li>
      <li>for sctrdepth, call smstateen_acc_ok(), and if there is any
        exception returned, always report virtual-instruction exception.</li>
    </ul>
    <p>If smstateen is not implemented:</p>
    <ul>
      <li>for sctrctl and sctrstatus, there is no check.</li>
      <li>for sctrdepth, I think the spec is ambiguous. What does "CTR
        state enable access restrictions apply" mean when smstateen is
        not implemented?<br>
      </li>
    </ul>
    <p>Here is the code to better understand my description.<br>
    </p>
    <p>static RISCVException ctr_smode(CPURISCVState *env, int csrno)<br>
      {<br>
          const RISCVCPUConfig *cfg = riscv_cpu_cfg(env);<br>
      <br>
          if (!cfg-&gt;ext_ssctr &amp;&amp; !cfg-&gt;ext_smctr) {<br>
              return RISCV_EXCP_ILLEGAL_INST;<br>
          }<br>
      <br>
          if (riscv_cpu_cfg(env)-&gt;ext_smstateen) {<br>
              RISCVException ret = smstateen_acc_ok(env, 0,
      SMSTATEEN0_CTR);<br>
              if (ret != RISCV_EXCP_NONE) {<br>
                  if (csrno == CSR_SCTRDEPTH &amp;&amp;
      env-&gt;virt_enabled) {<br>
                      return RISCV_EXCP_VIRT_INSTRUCTION_FAULT;<br>
                  }<br>
      <br>
                  return ret;<br>
              }<br>
          } else {<br>
              /* The spec is ambiguous. */<br>
              if (csrno == CSR_SCTRDEPTH &amp;&amp;
      env-&gt;virt_enabled) {<br>
                  return RISCV_EXCP_VIRT_INSTRUCTION_FAULT;<br>
              }<br>
          }<br>
      <br>
          return RISCV_EXCP_NONE;<br>
      }<br>
      <br>
    </p>
    <blockquote type="cite"
      cite="mid:20240529160950.132754-4-rkanwal@rivosinc.com">
      <pre class="moz-quote-pre" wrap="">
+
+static RISCVException ctr_vsmode(CPURISCVState *env, int csrno)
+{
+    if (env-&gt;priv == PRV_S &amp;&amp; env-&gt;virt_enabled &amp;&amp;
+        riscv_cpu_cfg(env)-&gt;ext_ssctr) {
+        return smstateen_acc_ok(env, 0, SMSTATEEN0_CTR);</pre>
    </blockquote>
    In riscv_csrrw_check(), an virtual-instruction exception is always
    reported no matter what. Do we need this check?<br>
    <blockquote type="cite"
      cite="mid:20240529160950.132754-4-rkanwal@rivosinc.com">
      <pre class="moz-quote-pre" wrap="">
+    }
+
+    return ctr_smode(env, csrno);
+}
+
 static RISCVException aia_hmode(CPURISCVState *env, int csrno)
 {
     int ret;
@@ -3835,6 +3890,100 @@ static RISCVException write_satp(CPURISCVState *env, int csrno,
     return RISCV_EXCP_NONE;
 }
 
+static RISCVException rmw_sctrdepth(CPURISCVState *env, int csrno,
+                                    target_ulong *ret_val,
+                                    target_ulong new_val, target_ulong wr_mask)
+{
+    uint64_t mask = wr_mask &amp; SCTRDEPTH_MASK;
+
+    if (ret_val) {
+        *ret_val = env-&gt;sctrdepth &amp; SCTRDEPTH_MASK;</pre>
    </blockquote>
    We don't need to do bitwise and with SCTRDEPTH_MASK on read accesses
    when we always do bitwise and with SCTRDEPTH_MASK on write accesses.<br>
    <blockquote type="cite"
      cite="mid:20240529160950.132754-4-rkanwal@rivosinc.com">
      <pre class="moz-quote-pre" wrap="">
+    }
+
+    env-&gt;sctrdepth = (env-&gt;sctrdepth &amp; ~mask) | (new_val &amp; mask);
+
+    /* Correct depth. */
+    if (wr_mask &amp; SCTRDEPTH_MASK) {
+        uint64_t depth = get_field(env-&gt;sctrdepth, SCTRDEPTH_MASK);
+
+        if (depth &gt; SCTRDEPTH_MAX) {
+            env-&gt;sctrdepth =
+                set_field(env-&gt;sctrdepth, SCTRDEPTH_MASK, SCTRDEPTH_MAX);
+        }
+
+        /* Update sctrstatus.WRPTR with a legal value */
+        depth = 16 &lt;&lt; depth;</pre>
    </blockquote>
    The "depth" on the right side may exceed SCTRDEPTH_MAX.<br>
    <blockquote type="cite"
      cite="mid:20240529160950.132754-4-rkanwal@rivosinc.com">
      <pre class="moz-quote-pre" wrap="">
+        env-&gt;sctrstatus =
+            env-&gt;sctrstatus &amp; (~SCTRSTATUS_WRPTR_MASK | (depth - 1));
+    }
+
+    return RISCV_EXCP_NONE;
+}
+
+static RISCVException rmw_mctrctl(CPURISCVState *env, int csrno,
+                                    target_ulong *ret_val,
+                                    target_ulong new_val, target_ulong wr_mask)
+{
+    uint64_t mask = wr_mask &amp; MCTRCTL_MASK;
+
+    if (ret_val) {
+        *ret_val = env-&gt;mctrctl &amp; MCTRCTL_MASK;</pre>
    </blockquote>
    There is no need to do bitwise and with the mask on read accesses
    when we always do bitwise and with the mask on write accesses.<br>
    <blockquote type="cite"
      cite="mid:20240529160950.132754-4-rkanwal@rivosinc.com">
      <pre class="moz-quote-pre" wrap="">
+    }
+
+    env-&gt;mctrctl = (env-&gt;mctrctl &amp; ~mask) | (new_val &amp; mask);
+
+    return RISCV_EXCP_NONE;
+}
+
+static RISCVException rmw_sctrctl(CPURISCVState *env, int csrno,
+                                    target_ulong *ret_val,
+                                    target_ulong new_val, target_ulong wr_mask)
+{
+    uint64_t mask = wr_mask &amp; SCTRCTL_MASK;
+    RISCVException ret;
+
+    ret = rmw_mctrctl(env, csrno, ret_val, new_val, mask);</pre>
    </blockquote>
    When V=1, vsctrctl substitutes for sctrctl.<br>
    <blockquote type="cite"
      cite="mid:20240529160950.132754-4-rkanwal@rivosinc.com">
      <pre class="moz-quote-pre" wrap="">
+    if (ret_val) {
+        *ret_val &amp;= SCTRCTL_MASK;
+    }
+
+    return ret;
+}
+
+static RISCVException rmw_sctrstatus(CPURISCVState *env, int csrno,
+                                     target_ulong *ret_val,
+                                     target_ulong new_val, target_ulong wr_mask)
+{
+    uint32_t depth = 16 &lt;&lt; get_field(env-&gt;sctrdepth, SCTRDEPTH_MASK);
+    uint32_t mask = wr_mask &amp; SCTRSTATUS_MASK;
+
+    if (ret_val) {
+        *ret_val = env-&gt;sctrstatus &amp; SCTRSTATUS_MASK;</pre>
    </blockquote>
    There is no need to do bitwise and with the mask on read accesses
    when we always do bitwise and with the mask on write accesses.<br>
    <blockquote type="cite"
      cite="mid:20240529160950.132754-4-rkanwal@rivosinc.com">
      <pre class="moz-quote-pre" wrap="">
+    }
+
+    env-&gt;sctrstatus = (env-&gt;sctrstatus &amp; ~mask) | (new_val &amp; mask);
+
+    /* Update sctrstatus.WRPTR with a legal value */
+    env-&gt;sctrstatus = env-&gt;sctrstatus &amp; (~SCTRSTATUS_WRPTR_MASK | (depth - 1));
+
+    return RISCV_EXCP_NONE;
+}
+
+static RISCVException rmw_vsctrctl(CPURISCVState *env, int csrno,
+                                    target_ulong *ret_val,
+                                    target_ulong new_val, target_ulong wr_mask)
+{
+    uint64_t mask = wr_mask &amp; VSCTRCTL_MASK;
+
+    if (ret_val) {
+        *ret_val = env-&gt;vsctrctl &amp; VSCTRCTL_MASK;</pre>
    </blockquote>
    There is no need to do bitwise and with the mask on read accesses
    when we always do bitwise and with the mask on write accesses.
    <blockquote type="cite"
      cite="mid:20240529160950.132754-4-rkanwal@rivosinc.com">
      <pre class="moz-quote-pre" wrap="">
+    }
+
+    env-&gt;vsctrctl = (env-&gt;vsctrctl &amp; ~mask) | (new_val &amp; mask);
+
+    return RISCV_EXCP_NONE;
+}</pre>
    </blockquote>
    Is it possible to define rmw_xctrctl() instead of three individual
    rmw functions and use a switch case to select the mask and the CSR
    for the purpose of reducing code size?<br>
    <blockquote type="cite"
      cite="mid:20240529160950.132754-4-rkanwal@rivosinc.com">
      <pre class="moz-quote-pre" wrap="">
+
 static RISCVException read_vstopi(CPURISCVState *env, int csrno,
                                   target_ulong *val)
 {
@@ -5771,6 +5920,16 @@ riscv_csr_operations csr_ops[CSR_TABLE_SIZE] = {
     [CSR_SPMBASE] =    { "spmbase", pointer_masking, read_spmbase,
                          write_spmbase                                      },
 
+    [CSR_MCTRCTL]       = { "mctrctl",       ctr_mmode, NULL, NULL,
+                                rmw_mctrctl },</pre>
    </blockquote>
    I think this can be one line.<br>
    <blockquote type="cite"
      cite="mid:20240529160950.132754-4-rkanwal@rivosinc.com">
      <pre class="moz-quote-pre" wrap="">
+    [CSR_SCTRCTL]       = { "sctrctl",       ctr_smode, NULL, NULL,
+                                rmw_sctrctl },</pre>
    </blockquote>
    same here<br>
    <blockquote type="cite"
      cite="mid:20240529160950.132754-4-rkanwal@rivosinc.com">
      <pre class="moz-quote-pre" wrap="">
+    [CSR_SCTRDEPTH]       = { "sctrdepth",       ctr_smode, NULL, NULL,
+                                rmw_sctrdepth },</pre>
    </blockquote>
    same here
    <blockquote type="cite"
      cite="mid:20240529160950.132754-4-rkanwal@rivosinc.com">
      <pre class="moz-quote-pre" wrap="">
+    [CSR_SCTRSTATUS]       = { "sctrstatus",       ctr_smode, NULL, NULL,
+                                rmw_sctrstatus },</pre>
    </blockquote>
    same here
    <blockquote type="cite"
      cite="mid:20240529160950.132754-4-rkanwal@rivosinc.com">
      <pre class="moz-quote-pre" wrap="">
+    [CSR_VSCTRCTL]      = { "vsctrctl",      ctr_vsmode, NULL, NULL,
+                                rmw_vsctrctl },</pre>
    </blockquote>
    same here
    <blockquote type="cite"
      cite="mid:20240529160950.132754-4-rkanwal@rivosinc.com">
      <pre class="moz-quote-pre" wrap="">
     /* Performance Counters */
     [CSR_HPMCOUNTER3]    = { "hpmcounter3",    ctr,    read_hpmcounter },
     [CSR_HPMCOUNTER4]    = { "hpmcounter4",    ctr,    read_hpmcounter },
</pre>
    </blockquote>
  </body>
</html>

--------------HdwHUJx5fdBvZT0cld0x6xoB--

