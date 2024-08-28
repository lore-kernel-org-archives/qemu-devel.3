Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B11B0C71150
	for <qemu-devel@archiver.kernel.org>; Wed, 28 Aug 2024 23:17:51 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sjRuR-0002vx-RZ; Wed, 28 Aug 2024 19:17:03 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1sjRuQ-0002u5-9o; Wed, 28 Aug 2024 19:17:02 -0400
Received: from mail-vk1-xa36.google.com ([2607:f8b0:4864:20::a36])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1sjRuO-0008QJ-7H; Wed, 28 Aug 2024 19:17:02 -0400
Received: by mail-vk1-xa36.google.com with SMTP id
 71dfb90a1353d-4fd05947340so32393e0c.3; 
 Wed, 28 Aug 2024 16:16:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1724887017; x=1725491817; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=w1WjxTOsoXTlw/hvJyZycSb1OBN6c6YTexZir4kzxTM=;
 b=V+v7eRYp/JB47HwTzINsjRoOQwCwrqaKYuxepYbRL3FQNwh90yZHqg6cKb3o6Iq0nd
 k4ynEvfTVWRDFBwgm4wapKILJ7OyYuvqGDQ+yAu3w5g8VyWGI23zLT4iYdttLSGh2e1h
 B9vyPxgtUbQAmTju3IKwcrKFJEdbyjIYpBW0TwcgpTfYWr0m2BupTOovSRlfcVn4s4Ds
 Chn3/jBtHlFxm4DgCaWmbNZ2cu6aVmI2QNZXhOG6QwXFoNhmLdl7DQDzgp2vCmUH2RMl
 q7kdvatw8202gWHCs8wa+adORhPOHcIVYuYZ1MUJhB/S+C1YrPGa+eX/SLFD2YOjGwra
 bw6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1724887017; x=1725491817;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=w1WjxTOsoXTlw/hvJyZycSb1OBN6c6YTexZir4kzxTM=;
 b=JmfAWNKtkBzYGQN+OFPrEY6bey9swYN4iye6QjaM8PkG24EQaHEjJGYsKo9SSsg95L
 buG+xbDYNFw4ObhMlprmRsRIU57hasWPu2ICH+NyNkO24YSygGeznFiOUzWVsBGfMg8V
 PtTx5qxilBKRAv+72gK+BqL409Woog5fQtkdVksADGiHUyQBX97aoMhQostWvLchqf1/
 +DXtIPGeKcxip6qcoRwbhVf5zzk6/AHMdPlMnKlUUXVMLzYP3eZR2Ecm6Z5e26988oZM
 Y9psQnKbuQfbQT4eDoQhFhxGRMP9+x6qKLqmq3jEQRfgG4mYBzw7huswrE0t/t9W7rLQ
 50hA==
X-Forwarded-Encrypted: i=1;
 AJvYcCV5k3+Tg0Rft4lfLy6Mi6iJNygxk9h3Ey+TF5YHNI/17TgUdJc5Gjh4xCXmUklEcULWwKEUbbzHnWJY@nongnu.org
X-Gm-Message-State: AOJu0YyTST9gc3eLVBQ9Mh0i2Bh/VXmNQWlpPwYG9PhzKFV8FAjersCU
 YhrSlcaiW8Huo5kLNxFYuYy54lt3bYiFDV4h2sDnAmQ03eNVG58HiH5M8Rjmf4cdkKZ4J4cTkfK
 4ZWChQgviIswjJOFangcgtl9ALKc=
X-Google-Smtp-Source: AGHT+IFSL7Rur8nH0Vvw4DBC9jIq6lzM+6FSoG+eVurtkGxp4UH4CLsqkrStusceQ0Cu2otriIe6aYIrernbKw3wsfA=
X-Received: by 2002:a05:6122:2a45:b0:4f6:a697:d380 with SMTP id
 71dfb90a1353d-4fff169e144mr1053902e0c.10.1724887017094; Wed, 28 Aug 2024
 16:16:57 -0700 (PDT)
MIME-Version: 1.0
References: <20240828174739.714313-1-debug@rivosinc.com>
 <20240828174739.714313-12-debug@rivosinc.com>
In-Reply-To: <20240828174739.714313-12-debug@rivosinc.com>
From: Alistair Francis <alistair23@gmail.com>
Date: Thu, 29 Aug 2024 09:16:30 +1000
Message-ID: <CAKmqyKM+Tg=okBNV5c59EDfTkr6fW5PEak2tYJqoiTZxaa88=g@mail.gmail.com>
Subject: Re: [PATCH v11 11/20] target/riscv: introduce ssp and enabling
 controls for zicfiss
To: Deepak Gupta <debug@rivosinc.com>
Cc: qemu-riscv@nongnu.org, qemu-devel@nongnu.org, palmer@dabbelt.com, 
 Alistair.Francis@wdc.com, laurent@vivier.eu, bmeng.cn@gmail.com, 
 liwei1518@gmail.com, dbarboza@ventanamicro.com, zhiwei_liu@linux.alibaba.com, 
 jim.shu@sifive.com, andy.chiu@sifive.com, kito.cheng@sifive.com, 
 Richard Henderson <richard.henderson@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::a36;
 envelope-from=alistair23@gmail.com; helo=mail-vk1-xa36.google.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FREEMAIL_ENVFROM_END_DIGIT=0.25, FREEMAIL_FROM=0.001,
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

On Thu, Aug 29, 2024 at 3:54=E2=80=AFAM Deepak Gupta <debug@rivosinc.com> w=
rote:
>
> zicfiss introduces a new state ssp ("shadow stack register") in cpu.
> ssp is expressed as a new unprivileged csr (CSR_SSP=3D0x11) and holds
> virtual address for shadow stack as programmed by software.
>
> Shadow stack (for each mode) is enabled via bit3 in *envcfg CSRs.
> Shadow stack can be enabled for a mode only if it's higher privileged
> mode had it enabled for itself. M mode doesn't need enabling control,
> it's always available if extension is available on cpu.
>
> This patch also implements helper bcfi function which determines if bcfi
> is enabled at current privilege or not. qemu-user also gets field
> `ubcfien` indicating whether qemu user has shadow stack enabled or not.
>
> Adds ssp to migration state as well.
>
> Signed-off-by: Deepak Gupta <debug@rivosinc.com>
> Co-developed-by: Jim Shu <jim.shu@sifive.com>
> Co-developed-by: Andy Chiu <andy.chiu@sifive.com>
> Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

Reviewed-by: Alistair Francis <alistair.francis@wdc.com>

Alistair

> ---
>  target/riscv/cpu.c        |  2 ++
>  target/riscv/cpu.h        |  3 +++
>  target/riscv/cpu_bits.h   |  6 +++++
>  target/riscv/cpu_helper.c | 27 ++++++++++++++++++++
>  target/riscv/csr.c        | 52 +++++++++++++++++++++++++++++++++++++++
>  target/riscv/machine.c    | 19 ++++++++++++++
>  6 files changed, 109 insertions(+)
>
> diff --git a/target/riscv/cpu.c b/target/riscv/cpu.c
> index 29b4bdb40a..c5ebcefeb5 100644
> --- a/target/riscv/cpu.c
> +++ b/target/riscv/cpu.c
> @@ -1021,6 +1021,8 @@ static void riscv_cpu_reset_hold(Object *obj, Reset=
Type type)
>
>      /* on reset elp is clear */
>      env->elp =3D false;
> +    /* on reset ssp is set to 0 */
> +    env->ssp =3D 0;
>
>      env->xl =3D riscv_cpu_mxl(env);
>      riscv_cpu_update_mask(env);
> diff --git a/target/riscv/cpu.h b/target/riscv/cpu.h
> index f372a4074b..4ace54a2eb 100644
> --- a/target/riscv/cpu.h
> +++ b/target/riscv/cpu.h
> @@ -224,6 +224,8 @@ struct CPUArchState {
>
>      /* elp state for zicfilp extension */
>      bool      elp;
> +    /* shadow stack register for zicfiss extension */
> +    target_ulong ssp;
>      /* sw check code for sw check exception */
>      target_ulong sw_check_code;
>  #ifdef CONFIG_USER_ONLY
> @@ -534,6 +536,7 @@ bool riscv_cpu_vector_enabled(CPURISCVState *env);
>  void riscv_cpu_set_virt_enabled(CPURISCVState *env, bool enable);
>  int riscv_env_mmu_index(CPURISCVState *env, bool ifetch);
>  bool cpu_get_fcfien(CPURISCVState *env);
> +bool cpu_get_bcfien(CPURISCVState *env);
>  G_NORETURN void  riscv_cpu_do_unaligned_access(CPUState *cs, vaddr addr,
>                                                 MMUAccessType access_type=
,
>                                                 int mmu_idx, uintptr_t re=
taddr);
> diff --git a/target/riscv/cpu_bits.h b/target/riscv/cpu_bits.h
> index 900769ce60..48ce24dc32 100644
> --- a/target/riscv/cpu_bits.h
> +++ b/target/riscv/cpu_bits.h
> @@ -34,6 +34,9 @@
>
>  /* Control and Status Registers */
>
> +/* zicfiss user ssp csr */
> +#define CSR_SSP             0x011
> +
>  /* User Trap Setup */
>  #define CSR_USTATUS         0x000
>  #define CSR_UIE             0x004
> @@ -754,6 +757,7 @@ typedef enum RISCVException {
>  /* Execution environment configuration bits */
>  #define MENVCFG_FIOM                       BIT(0)
>  #define MENVCFG_LPE                        BIT(2) /* zicfilp */
> +#define MENVCFG_SSE                        BIT(3) /* zicfiss */
>  #define MENVCFG_CBIE                       (3UL << 4)
>  #define MENVCFG_CBCFE                      BIT(6)
>  #define MENVCFG_CBZE                       BIT(7)
> @@ -768,12 +772,14 @@ typedef enum RISCVException {
>
>  #define SENVCFG_FIOM                       MENVCFG_FIOM
>  #define SENVCFG_LPE                        MENVCFG_LPE
> +#define SENVCFG_SSE                        MENVCFG_SSE
>  #define SENVCFG_CBIE                       MENVCFG_CBIE
>  #define SENVCFG_CBCFE                      MENVCFG_CBCFE
>  #define SENVCFG_CBZE                       MENVCFG_CBZE
>
>  #define HENVCFG_FIOM                       MENVCFG_FIOM
>  #define HENVCFG_LPE                        MENVCFG_LPE
> +#define HENVCFG_SSE                        MENVCFG_SSE
>  #define HENVCFG_CBIE                       MENVCFG_CBIE
>  #define HENVCFG_CBCFE                      MENVCFG_CBCFE
>  #define HENVCFG_CBZE                       MENVCFG_CBZE
> diff --git a/target/riscv/cpu_helper.c b/target/riscv/cpu_helper.c
> index c3820eff8f..f7e97eabfa 100644
> --- a/target/riscv/cpu_helper.c
> +++ b/target/riscv/cpu_helper.c
> @@ -91,6 +91,33 @@ bool cpu_get_fcfien(CPURISCVState *env)
>      }
>  }
>
> +bool cpu_get_bcfien(CPURISCVState *env)
> +{
> +    /* no cfi extension, return false */
> +    if (!env_archcpu(env)->cfg.ext_zicfiss) {
> +        return false;
> +    }
> +
> +    switch (env->priv) {
> +    case PRV_U:
> +        if (riscv_has_ext(env, RVS)) {
> +            return env->senvcfg & SENVCFG_SSE;
> +        }
> +        return env->menvcfg & MENVCFG_SSE;
> +#ifndef CONFIG_USER_ONLY
> +    case PRV_S:
> +        if (env->virt_enabled) {
> +            return env->henvcfg & HENVCFG_SSE;
> +        }
> +        return env->menvcfg & MENVCFG_SSE;
> +    case PRV_M: /* M-mode shadow stack is always on if hart implements *=
/
> +        return true;
> +#endif
> +    default:
> +        g_assert_not_reached();
> +    }
> +}
> +
>  void cpu_get_tb_cpu_state(CPURISCVState *env, vaddr *pc,
>                            uint64_t *cs_base, uint32_t *pflags)
>  {
> diff --git a/target/riscv/csr.c b/target/riscv/csr.c
> index a5a969a377..ec04b2b32b 100644
> --- a/target/riscv/csr.c
> +++ b/target/riscv/csr.c
> @@ -185,6 +185,25 @@ static RISCVException zcmt(CPURISCVState *env, int c=
srno)
>      return RISCV_EXCP_NONE;
>  }
>
> +static RISCVException cfi_ss(CPURISCVState *env, int csrno)
> +{
> +    if (!env_archcpu(env)->cfg.ext_zicfiss) {
> +        return RISCV_EXCP_ILLEGAL_INST;
> +    }
> +
> +    /* if bcfi not active for current env, access to csr is illegal */
> +    if (!cpu_get_bcfien(env)) {
> +#if !defined(CONFIG_USER_ONLY)
> +        if (env->debugger) {
> +            return RISCV_EXCP_NONE;
> +        }
> +#endif
> +        return RISCV_EXCP_ILLEGAL_INST;
> +    }
> +
> +    return RISCV_EXCP_NONE;
> +}
> +
>  #if !defined(CONFIG_USER_ONLY)
>  static RISCVException mctr(CPURISCVState *env, int csrno)
>  {
> @@ -596,6 +615,19 @@ static RISCVException seed(CPURISCVState *env, int c=
srno)
>  #endif
>  }
>
> +/* zicfiss CSR_SSP read and write */
> +static int read_ssp(CPURISCVState *env, int csrno, target_ulong *val)
> +{
> +    *val =3D env->ssp;
> +    return RISCV_EXCP_NONE;
> +}
> +
> +static int write_ssp(CPURISCVState *env, int csrno, target_ulong val)
> +{
> +    env->ssp =3D val;
> +    return RISCV_EXCP_NONE;
> +}
> +
>  /* User Floating-Point CSRs */
>  static RISCVException read_fflags(CPURISCVState *env, int csrno,
>                                    target_ulong *val)
> @@ -2111,6 +2143,10 @@ static RISCVException write_menvcfg(CPURISCVState =
*env, int csrno,
>          if (env_archcpu(env)->cfg.ext_zicfilp) {
>              mask |=3D MENVCFG_LPE;
>          }
> +
> +        if (env_archcpu(env)->cfg.ext_zicfiss) {
> +            mask |=3D MENVCFG_SSE;
> +        }
>      }
>      env->menvcfg =3D (env->menvcfg & ~mask) | (val & mask);
>
> @@ -2167,6 +2203,13 @@ static RISCVException write_senvcfg(CPURISCVState =
*env, int csrno,
>          mask |=3D SENVCFG_LPE;
>      }
>
> +    /* Higher mode SSE must be ON for next-less mode SSE to be ON */
> +    if (env_archcpu(env)->cfg.ext_zicfiss &&
> +        get_field(env->menvcfg, MENVCFG_SSE) &&
> +        (env->virt_enabled ? get_field(env->henvcfg, HENVCFG_SSE) : true=
)) {
> +        mask |=3D SENVCFG_SSE;
> +    }
> +
>      env->senvcfg =3D (env->senvcfg & ~mask) | (val & mask);
>      return RISCV_EXCP_NONE;
>  }
> @@ -2208,6 +2251,12 @@ static RISCVException write_henvcfg(CPURISCVState =
*env, int csrno,
>          if (env_archcpu(env)->cfg.ext_zicfilp) {
>              mask |=3D HENVCFG_LPE;
>          }
> +
> +        /* H can light up SSE for VS only if HS had it from menvcfg */
> +        if (env_archcpu(env)->cfg.ext_zicfiss &&
> +            get_field(env->menvcfg, MENVCFG_SSE)) {
> +            mask |=3D HENVCFG_SSE;
> +        }
>      }
>
>      env->henvcfg =3D (env->henvcfg & ~mask) | (val & mask);
> @@ -4663,6 +4712,9 @@ riscv_csr_operations csr_ops[CSR_TABLE_SIZE] =3D {
>      /* Zcmt Extension */
>      [CSR_JVT] =3D {"jvt", zcmt, read_jvt, write_jvt},
>
> +    /* zicfiss Extension, shadow stack register */
> +    [CSR_SSP]  =3D { "ssp", cfi_ss, read_ssp, write_ssp },
> +
>  #if !defined(CONFIG_USER_ONLY)
>      /* Machine Timers and Counters */
>      [CSR_MCYCLE]    =3D { "mcycle",    any,   read_hpmcounter,
> diff --git a/target/riscv/machine.c b/target/riscv/machine.c
> index 873957c4ab..84d5ecf436 100644
> --- a/target/riscv/machine.c
> +++ b/target/riscv/machine.c
> @@ -369,6 +369,24 @@ static const VMStateDescription vmstate_elp =3D {
>      }
>  };
>
> +static bool ssp_needed(void *opaque)
> +{
> +    RISCVCPU *cpu =3D opaque;
> +
> +    return cpu->cfg.ext_zicfiss;
> +}
> +
> +static const VMStateDescription vmstate_ssp =3D {
> +    .name =3D "cpu/ssp",
> +    .version_id =3D 1,
> +    .minimum_version_id =3D 1,
> +    .needed =3D ssp_needed,
> +    .fields =3D (const VMStateField[]) {
> +        VMSTATE_UINTTL(env.ssp, RISCVCPU),
> +        VMSTATE_END_OF_LIST()
> +    }
> +};
> +
>  const VMStateDescription vmstate_riscv_cpu =3D {
>      .name =3D "cpu",
>      .version_id =3D 10,
> @@ -442,6 +460,7 @@ const VMStateDescription vmstate_riscv_cpu =3D {
>          &vmstate_smstateen,
>          &vmstate_jvt,
>          &vmstate_elp,
> +        &vmstate_ssp,
>          NULL
>      }
>  };
> --
> 2.44.0
>
>

