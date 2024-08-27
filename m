Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 52DEAC5472D
	for <qemu-devel@archiver.kernel.org>; Tue, 27 Aug 2024 02:59:40 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1simPh-0002ef-Qd; Mon, 26 Aug 2024 22:58:34 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1simPf-0002d6-T0; Mon, 26 Aug 2024 22:58:32 -0400
Received: from mail-vs1-xe2f.google.com ([2607:f8b0:4864:20::e2f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1simPd-0007Pd-UG; Mon, 26 Aug 2024 22:58:31 -0400
Received: by mail-vs1-xe2f.google.com with SMTP id
 ada2fe7eead31-498dbd7dc89so1438320137.1; 
 Mon, 26 Aug 2024 19:58:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1724727508; x=1725332308; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=FIgDRQYqG3xXgWOKw4fXwJ2a8vryHTZ25VJKLesP8Xk=;
 b=KrvoI8myr1SaxMh6rpn8PT2sPNkXCQaXEFOgiuiYbaDqZpVSgGoLhyp5JoAwhe4ru5
 RqF+F8jawZNdkgCmfMIWejmvGhvx9FhMTcllFSyidQlLrbV2oNhjWcfWuj4fpx5pKUOt
 ZC5khRX0k0hN/AxVorRrXtw7RNuEMGXSCD8TzeBcaiPydMVIqakYdI4xVxUCPHP6jxwj
 spqXriWaVRcYEihNGOUMsnuheIdZURR8aoTFy9Thm0FWtNiZdwIBlV3HBrn6WVOMhCgB
 3zDAlmBS0yRIHGMsFEmIjuNk0whBKvOQ0ijp4A01GHG4ZnjuOoEloVkUjezamdo91sR3
 WSkA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1724727508; x=1725332308;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=FIgDRQYqG3xXgWOKw4fXwJ2a8vryHTZ25VJKLesP8Xk=;
 b=NxRh6q6PlktKoNTlFU3imQ2T5zzLsEvdTvqgvwLCbM3cUVsz0vyVeanLKHyqaWew/x
 Edj78LfdqsV8CE6UHgCl29U7owr8mQhdhc96laAuuFrNi475hfheyoEmG0/Q3Lh4NLQo
 AOc/R34vJXp/aSWemVxSw+RB5NRdv9UYzC/MCzgUZaGLnMOEPBV9Tf+EN+pwb9IBKb+Q
 LIlzDuomhYAjmH8HX/P9CQ8LN7FvO2Y6vnoEgJBwrYKzxzYJL/19T9IMRQj73+s4gjc/
 B1aQ7pu3hMp1XsgsQLzo2asFwvzsD1VKSDItz4f6WIhAQMix6D2kOymOyL36l0/yw9zA
 b1ug==
X-Forwarded-Encrypted: i=1;
 AJvYcCXUqiVV975J3JENu9cz+QTluVgQ1BwC+IdH6r0F0zX+80vRdCi2u01/89lMvz9OVVtYD1fUCsaU1/I0@nongnu.org
X-Gm-Message-State: AOJu0YxSWHwT0zbFcVyHqcSR90MrOyzL4v+YYtVAahKPiz/jLj6D9Q89
 iOHIyM/baiTHKTxD6kbZkKlGX3kPStAv51zCYM4Qd1JVrTZlro4qKMYU4QYGa3V/9OnaXq7BztW
 QH0P5iG7BkPATwubxfMKyX5exXQY=
X-Google-Smtp-Source: AGHT+IH/qG0kMTkydFd2LfJTh+E9+mIawMFeDRVIGUda4ILXFA3u7FUnFFE1zVrs1sYWQA1loHMZQukx/rT00x7hAss=
X-Received: by 2002:a05:6102:c48:b0:48f:23b4:1d96 with SMTP id
 ada2fe7eead31-49a3bbcbbd2mr1970653137.16.1724727507661; Mon, 26 Aug 2024
 19:58:27 -0700 (PDT)
MIME-Version: 1.0
References: <20240826152949.294506-1-debug@rivosinc.com>
 <20240826152949.294506-3-debug@rivosinc.com>
In-Reply-To: <20240826152949.294506-3-debug@rivosinc.com>
From: Alistair Francis <alistair23@gmail.com>
Date: Tue, 27 Aug 2024 12:58:01 +1000
Message-ID: <CAKmqyKPNH4TRXa8EZ7qV8483s3hT4MnbkVApchV4EaxU_2rE-A@mail.gmail.com>
Subject: Re: [PATCH v9 02/17] target/riscv: Introduce elp state and enabling
 controls for zicfilp
To: Deepak Gupta <debug@rivosinc.com>
Cc: qemu-riscv@nongnu.org, qemu-devel@nongnu.org, palmer@dabbelt.com, 
 Alistair.Francis@wdc.com, bmeng.cn@gmail.com, liwei1518@gmail.com, 
 dbarboza@ventanamicro.com, zhiwei_liu@linux.alibaba.com, jim.shu@sifive.com, 
 andy.chiu@sifive.com, richard.henderson@linaro.org, kito.cheng@sifive.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::e2f;
 envelope-from=alistair23@gmail.com; helo=mail-vs1-xe2f.google.com
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

On Tue, Aug 27, 2024 at 1:30=E2=80=AFAM Deepak Gupta <debug@rivosinc.com> w=
rote:
>
> zicfilp introduces a new state elp ("expected landing pad") in cpu.
> During normal execution, elp is idle (NO_LP_EXPECTED) i.e not expecting
> landing pad. On an indirect call, elp moves LP_EXPECTED. When elp is
> LP_EXPECTED, only a subsquent landing pad instruction can set state back
> to NO_LP_EXPECTED. On reset, elp is set to NO_LP_EXPECTED.
>
> zicfilp is enabled via bit2 in *envcfg CSRs. Enabling control for M-mode
> is in mseccfg CSR at bit position 10.
>
> On trap, elp state is saved away in *status.
> Adds elp to the migration state as well.
>
> Signed-off-by: Deepak Gupta <debug@rivosinc.com>
> Co-developed-by: Jim Shu <jim.shu@sifive.com>
> Co-developed-by: Andy Chiu <andy.chiu@sifive.com>
> Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

Reviewed-by: Alistair Francis <alistair.francis@wdc.com>

Alistair

> ---
>  target/riscv/cpu.c      |  3 +++
>  target/riscv/cpu.h      |  2 ++
>  target/riscv/cpu_bits.h |  6 ++++++
>  target/riscv/csr.c      | 31 +++++++++++++++++++++++++++++++
>  target/riscv/machine.c  | 19 +++++++++++++++++++
>  target/riscv/pmp.c      |  5 +++++
>  target/riscv/pmp.h      |  3 ++-
>  7 files changed, 68 insertions(+), 1 deletion(-)
>
> diff --git a/target/riscv/cpu.c b/target/riscv/cpu.c
> index 5dfb3f39ab..8e1f05e5b1 100644
> --- a/target/riscv/cpu.c
> +++ b/target/riscv/cpu.c
> @@ -994,6 +994,9 @@ static void riscv_cpu_reset_hold(Object *obj, ResetTy=
pe type)
>      /* mmte is supposed to have pm.current hardwired to 1 */
>      env->mmte |=3D (EXT_STATUS_INITIAL | MMTE_M_PM_CURRENT);
>
> +    /* on reset elp is clear */
> +    env->elp =3D false;
> +
>      /*
>       * Bits 10, 6, 2 and 12 of mideleg are read only 1 when the Hypervis=
or
>       * extension is enabled.
> diff --git a/target/riscv/cpu.h b/target/riscv/cpu.h
> index 87742047ce..f966c36a31 100644
> --- a/target/riscv/cpu.h
> +++ b/target/riscv/cpu.h
> @@ -222,6 +222,8 @@ struct CPUArchState {
>
>      target_ulong jvt;
>
> +    /* elp state for zicfilp extension */
> +    bool      elp;
>  #ifdef CONFIG_USER_ONLY
>      uint32_t elf_flags;
>  #endif
> diff --git a/target/riscv/cpu_bits.h b/target/riscv/cpu_bits.h
> index c257c5ed7d..b05ebe6f29 100644
> --- a/target/riscv/cpu_bits.h
> +++ b/target/riscv/cpu_bits.h
> @@ -545,6 +545,8 @@
>  #define MSTATUS_TVM         0x00100000 /* since: priv-1.10 */
>  #define MSTATUS_TW          0x00200000 /* since: priv-1.10 */
>  #define MSTATUS_TSR         0x00400000 /* since: priv-1.10 */
> +#define MSTATUS_SPELP       0x00800000 /* zicfilp */
> +#define MSTATUS_MPELP       0x020000000000 /* zicfilp */
>  #define MSTATUS_GVA         0x4000000000ULL
>  #define MSTATUS_MPV         0x8000000000ULL
>
> @@ -575,6 +577,7 @@ typedef enum {
>  #define SSTATUS_XS          0x00018000
>  #define SSTATUS_SUM         0x00040000 /* since: priv-1.10 */
>  #define SSTATUS_MXR         0x00080000
> +#define SSTATUS_SPELP       MSTATUS_SPELP   /* zicfilp */
>
>  #define SSTATUS64_UXL       0x0000000300000000ULL
>
> @@ -747,6 +750,7 @@ typedef enum RISCVException {
>
>  /* Execution environment configuration bits */
>  #define MENVCFG_FIOM                       BIT(0)
> +#define MENVCFG_LPE                        BIT(2) /* zicfilp */
>  #define MENVCFG_CBIE                       (3UL << 4)
>  #define MENVCFG_CBCFE                      BIT(6)
>  #define MENVCFG_CBZE                       BIT(7)
> @@ -760,11 +764,13 @@ typedef enum RISCVException {
>  #define MENVCFGH_STCE                      BIT(31)
>
>  #define SENVCFG_FIOM                       MENVCFG_FIOM
> +#define SENVCFG_LPE                        MENVCFG_LPE
>  #define SENVCFG_CBIE                       MENVCFG_CBIE
>  #define SENVCFG_CBCFE                      MENVCFG_CBCFE
>  #define SENVCFG_CBZE                       MENVCFG_CBZE
>
>  #define HENVCFG_FIOM                       MENVCFG_FIOM
> +#define HENVCFG_LPE                        MENVCFG_LPE
>  #define HENVCFG_CBIE                       MENVCFG_CBIE
>  #define HENVCFG_CBCFE                      MENVCFG_CBCFE
>  #define HENVCFG_CBZE                       MENVCFG_CBZE
> diff --git a/target/riscv/csr.c b/target/riscv/csr.c
> index 432c59dc66..5771a14848 100644
> --- a/target/riscv/csr.c
> +++ b/target/riscv/csr.c
> @@ -1400,6 +1400,11 @@ static RISCVException write_mstatus(CPURISCVState =
*env, int csrno,
>          }
>      }
>
> +    /* If cfi lp extension is available, then apply cfi lp mask */
> +    if (env_archcpu(env)->cfg.ext_zicfilp) {
> +        mask |=3D (MSTATUS_MPELP | MSTATUS_SPELP);
> +    }
> +
>      mstatus =3D (mstatus & ~mask) | (val & mask);
>
>      env->mstatus =3D mstatus;
> @@ -2101,6 +2106,10 @@ static RISCVException write_menvcfg(CPURISCVState =
*env, int csrno,
>          mask |=3D (cfg->ext_svpbmt ? MENVCFG_PBMTE : 0) |
>                  (cfg->ext_sstc ? MENVCFG_STCE : 0) |
>                  (cfg->ext_svadu ? MENVCFG_ADUE : 0);
> +
> +        if (env_archcpu(env)->cfg.ext_zicfilp) {
> +            mask |=3D MENVCFG_LPE;
> +        }
>      }
>      env->menvcfg =3D (env->menvcfg & ~mask) | (val & mask);
>
> @@ -2153,6 +2162,10 @@ static RISCVException write_senvcfg(CPURISCVState =
*env, int csrno,
>          return ret;
>      }
>
> +    if (env_archcpu(env)->cfg.ext_zicfilp) {
> +        mask |=3D SENVCFG_LPE;
> +    }
> +
>      env->senvcfg =3D (env->senvcfg & ~mask) | (val & mask);
>      return RISCV_EXCP_NONE;
>  }
> @@ -2190,6 +2203,10 @@ static RISCVException write_henvcfg(CPURISCVState =
*env, int csrno,
>
>      if (riscv_cpu_mxl(env) =3D=3D MXL_RV64) {
>          mask |=3D env->menvcfg & (HENVCFG_PBMTE | HENVCFG_STCE | HENVCFG=
_ADUE);
> +
> +        if (env_archcpu(env)->cfg.ext_zicfilp) {
> +            mask |=3D HENVCFG_LPE;
> +        }
>      }
>
>      env->henvcfg =3D (env->henvcfg & ~mask) | (val & mask);
> @@ -2654,6 +2671,10 @@ static RISCVException read_sstatus_i128(CPURISCVSt=
ate *env, int csrno,
>          mask |=3D SSTATUS64_UXL;
>      }
>
> +    if (env_archcpu(env)->cfg.ext_zicfilp) {
> +        mask |=3D SSTATUS_SPELP;
> +    }
> +
>      *val =3D int128_make128(sstatus, add_status_sd(MXL_RV128, sstatus));
>      return RISCV_EXCP_NONE;
>  }
> @@ -2665,6 +2686,11 @@ static RISCVException read_sstatus(CPURISCVState *=
env, int csrno,
>      if (env->xl !=3D MXL_RV32 || env->debugger) {
>          mask |=3D SSTATUS64_UXL;
>      }
> +
> +    if (env_archcpu(env)->cfg.ext_zicfilp) {
> +        mask |=3D SSTATUS_SPELP;
> +    }
> +
>      /* TODO: Use SXL not MXL. */
>      *val =3D add_status_sd(riscv_cpu_mxl(env), env->mstatus & mask);
>      return RISCV_EXCP_NONE;
> @@ -2680,6 +2706,11 @@ static RISCVException write_sstatus(CPURISCVState =
*env, int csrno,
>              mask |=3D SSTATUS64_UXL;
>          }
>      }
> +
> +    if (env_archcpu(env)->cfg.ext_zicfilp) {
> +        mask |=3D SSTATUS_SPELP;
> +    }
> +
>      target_ulong newval =3D (env->mstatus & ~mask) | (val & mask);
>      return write_mstatus(env, CSR_MSTATUS, newval);
>  }
> diff --git a/target/riscv/machine.c b/target/riscv/machine.c
> index 76f2150f78..873957c4ab 100644
> --- a/target/riscv/machine.c
> +++ b/target/riscv/machine.c
> @@ -351,6 +351,24 @@ static const VMStateDescription vmstate_jvt =3D {
>      }
>  };
>
> +static bool elp_needed(void *opaque)
> +{
> +    RISCVCPU *cpu =3D opaque;
> +
> +    return cpu->cfg.ext_zicfilp;
> +}
> +
> +static const VMStateDescription vmstate_elp =3D {
> +    .name =3D "cpu/elp",
> +    .version_id =3D 1,
> +    .minimum_version_id =3D 1,
> +    .needed =3D elp_needed,
> +    .fields =3D (const VMStateField[]) {
> +        VMSTATE_BOOL(env.elp, RISCVCPU),
> +        VMSTATE_END_OF_LIST()
> +    }
> +};
> +
>  const VMStateDescription vmstate_riscv_cpu =3D {
>      .name =3D "cpu",
>      .version_id =3D 10,
> @@ -423,6 +441,7 @@ const VMStateDescription vmstate_riscv_cpu =3D {
>          &vmstate_debug,
>          &vmstate_smstateen,
>          &vmstate_jvt,
> +        &vmstate_elp,
>          NULL
>      }
>  };
> diff --git a/target/riscv/pmp.c b/target/riscv/pmp.c
> index 9eea397e72..1111d08d08 100644
> --- a/target/riscv/pmp.c
> +++ b/target/riscv/pmp.c
> @@ -598,6 +598,11 @@ void mseccfg_csr_write(CPURISCVState *env, target_ul=
ong val)
>          val &=3D ~(MSECCFG_MMWP | MSECCFG_MML | MSECCFG_RLB);
>      }
>
> +    /* M-mode forward cfi to be enabled if cfi extension is implemented =
*/
> +    if (env_archcpu(env)->cfg.ext_zicfilp) {
> +        val |=3D (val & MSECCFG_MLPE);
> +    }
> +
>      env->mseccfg =3D val;
>  }
>
> diff --git a/target/riscv/pmp.h b/target/riscv/pmp.h
> index f5c10ce85c..e0530a17a3 100644
> --- a/target/riscv/pmp.h
> +++ b/target/riscv/pmp.h
> @@ -44,7 +44,8 @@ typedef enum {
>      MSECCFG_MMWP  =3D 1 << 1,
>      MSECCFG_RLB   =3D 1 << 2,
>      MSECCFG_USEED =3D 1 << 8,
> -    MSECCFG_SSEED =3D 1 << 9
> +    MSECCFG_SSEED =3D 1 << 9,
> +    MSECCFG_MLPE =3D  1 << 10,
>  } mseccfg_field_t;
>
>  typedef struct {
> --
> 2.44.0
>
>

