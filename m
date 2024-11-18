Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1A470D10F41
	for <qemu-devel@archiver.kernel.org>; Mon, 18 Nov 2024 03:14:55 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tCsD9-000416-96; Sun, 17 Nov 2024 22:14:00 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1tCsD5-0003u5-1x; Sun, 17 Nov 2024 22:13:55 -0500
Received: from mail-vk1-xa2d.google.com ([2607:f8b0:4864:20::a2d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1tCsD0-0001Ry-AZ; Sun, 17 Nov 2024 22:13:54 -0500
Received: by mail-vk1-xa2d.google.com with SMTP id
 71dfb90a1353d-50d34db4edeso2710784e0c.0; 
 Sun, 17 Nov 2024 19:13:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1731899624; x=1732504424; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=cRvXACT1A8U5IIpje577+iohndssfbU2e/gKAxIR2S0=;
 b=QCN+nx4wJ+z608Xfoy8NF8Ojo2y1RiArpS5PWgQvcjEfi2nTc3E7fFE5IQVKAt3elV
 85/BgzY9cWKLC4OsQsHMGO/AcMPONYvPKDuqNAoWZLlIgvnxjdE94Z15G/FJ4DOTlm9h
 uHkK75o0IuojRkPg7vCwDLv2mvIgpJjnpyBUwJKixqilZcM9AzqqQ1lgOf/3DtB4u5eP
 Pcv0+eNH2VajiZ23lJ4lUUiPMflGxNQT/1gjAOCgTPp/qmK5YmmG+O64jFO5RF+y89SU
 pjhP7HFvvmgzz10v5hQ9ghAwVWDHwBLSlcSwq5NYra6P17pKC8FExcAbqXY0P1WqP+H2
 j/Tw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1731899624; x=1732504424;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=cRvXACT1A8U5IIpje577+iohndssfbU2e/gKAxIR2S0=;
 b=taP+9d1lruPb2GCh+6JDgkkcuM1KA9ngsZXRMUMztRutbza53LsXgFfsJGEKQz/LEs
 mJazb23bcKu/+D8Qz7Bug/aSCY8bs9vhwhBGkaLhbeaZZjlMn/qKCmqd9nzpXLIkotZP
 V1G2r87F/U40RFfoUtRinlm+pNN289Q1hMzCwsVNnA5cTroFNN9wkhoMxu41j0K0XG27
 L+2Lzes3w4FjjHoh6iMJarU6ewqoRe2IX/3V5Aub8ggIYHWLuPi3hkbuVb5msiSdE+YN
 rvhEE23PSHwcdtqTkNqhCF6TX5zJKF7ZKMep5xBmb/F0/qscR3lZhuo+fI8KtPyz2ORr
 KzCQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCXYsbZ0xRsQ8Z1S+GX/3akALsEmHXv3CXYfpzRd3TRu8htDi5VUuyHtieyyg8DZRyM5HnkRtWenhpk9@nongnu.org
X-Gm-Message-State: AOJu0YyBvyPms270ilHDLoghxY42CHBXHaIBY204+17uNY6kH8inWpC0
 dJhC+mJ/pH4FsagnCbdU1vE+uh44kgO0jSHTC8loCLZQ2u114GpD95rrXkaJ3LQa6+/SNBGU5DB
 oWqmrs6lX9MZCl3JZtzf4Bb9ZBUQ=
X-Google-Smtp-Source: AGHT+IGSHW6RBDUY3kxs7TzwDUDMPXdYDV/cFaPs78rPPItN7eFD4+mxoMINBSf2zCGFugN1vcumfn0HCZW8GC2Avxc=
X-Received: by 2002:a05:6122:c9a:b0:50c:eb10:9792 with SMTP id
 71dfb90a1353d-514781fdf6bmr7075530e0c.4.1731899624590; Sun, 17 Nov 2024
 19:13:44 -0800 (PST)
MIME-Version: 1.0
References: <20241021030358.12454-1-frank.chang@sifive.com>
 <20241021030358.12454-3-frank.chang@sifive.com>
In-Reply-To: <20241021030358.12454-3-frank.chang@sifive.com>
From: Alistair Francis <alistair23@gmail.com>
Date: Mon, 18 Nov 2024 13:13:18 +1000
Message-ID: <CAKmqyKM=umHQqh=zYbyR8UZbTbnmNXE33pm=UV2bbffF48_Okw@mail.gmail.com>
Subject: Re: [PATCH v8 2/5] target/riscv: Handle Smrnmi interrupt and exception
To: frank.chang@sifive.com
Cc: qemu-devel@nongnu.org, Palmer Dabbelt <palmer@dabbelt.com>, 
 Alistair Francis <alistair.francis@wdc.com>, Bin Meng <bmeng.cn@gmail.com>, 
 Weiwei Li <liwei1518@gmail.com>,
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>, 
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>, 
 "open list:RISC-V TCG CPUs" <qemu-riscv@nongnu.org>,
 Tommy Wu <tommy.wu@sifive.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::a2d;
 envelope-from=alistair23@gmail.com; helo=mail-vk1-xa2d.google.com
X-Spam_score_int: -17
X-Spam_score: -1.8
X-Spam_bar: -
X-Spam_report: (-1.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FREEMAIL_ENVFROM_END_DIGIT=0.25, FREEMAIL_FROM=0.001,
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

On Mon, Oct 21, 2024 at 1:06=E2=80=AFPM <frank.chang@sifive.com> wrote:
>
> From: Tommy Wu <tommy.wu@sifive.com>
>
> Because the RNMI interrupt trap handler address is implementation defined=
.
> We add the 'rnmi-interrupt-vector' and 'rnmi-exception-vector' as the pro=
perty
> of the harts. It=E2=80=99s very easy for users to set the address based o=
n their
> expectation. This patch also adds the functionality to handle the RNMI si=
gnals.
>
> Signed-off-by: Frank Chang <frank.chang@sifive.com>
> Signed-off-by: Tommy Wu <tommy.wu@sifive.com>
> ---
>  hw/riscv/riscv_hart.c         | 18 ++++++++
>  include/hw/riscv/riscv_hart.h |  4 ++
>  target/riscv/cpu.c            | 11 +++++
>  target/riscv/cpu.h            |  6 +++
>  target/riscv/cpu_bits.h       | 12 +++++
>  target/riscv/cpu_helper.c     | 82 ++++++++++++++++++++++++++++++++---
>  6 files changed, 128 insertions(+), 5 deletions(-)
>
> diff --git a/hw/riscv/riscv_hart.c b/hw/riscv/riscv_hart.c
> index 613ea2aaa0..b7d73f7a82 100644
> --- a/hw/riscv/riscv_hart.c
> +++ b/hw/riscv/riscv_hart.c
> @@ -33,6 +33,12 @@ static Property riscv_harts_props[] =3D {
>      DEFINE_PROP_STRING("cpu-type", RISCVHartArrayState, cpu_type),
>      DEFINE_PROP_UINT64("resetvec", RISCVHartArrayState, resetvec,
>                         DEFAULT_RSTVEC),
> +    DEFINE_PROP_ARRAY("rnmi-interrupt-vector", RISCVHartArrayState,
> +                      num_rnmi_irqvec, rnmi_irqvec, qdev_prop_uint64,
> +                      uint64_t),
> +    DEFINE_PROP_ARRAY("rnmi-exception-vector", RISCVHartArrayState,
> +                      num_rnmi_excpvec, rnmi_excpvec, qdev_prop_uint64,
> +                      uint64_t),

These will need some documentation somewhere, it's not really clear
from the names what these do.

>      DEFINE_PROP_END_OF_LIST(),
>  };
>
> @@ -47,6 +53,18 @@ static bool riscv_hart_realize(RISCVHartArrayState *s,=
 int idx,
>  {
>      object_initialize_child(OBJECT(s), "harts[*]", &s->harts[idx], cpu_t=
ype);
>      qdev_prop_set_uint64(DEVICE(&s->harts[idx]), "resetvec", s->resetvec=
);
> +    if (s->harts[idx].cfg.ext_smrnmi) {
> +        if (s->rnmi_irqvec) {
> +            qdev_prop_set_uint64(DEVICE(&s->harts[idx]),
> +                                 "rnmi-interrupt-vector",
> +                                 s->rnmi_irqvec[idx]);
> +        }
> +        if (s->rnmi_excpvec) {
> +            qdev_prop_set_uint64(DEVICE(&s->harts[idx]),
> +                                 "rnmi-exception-vector",
> +                                 s->rnmi_excpvec[idx]);
> +        }
> +    }

We should probably warn the user if we are ignoring the values that
they specified because the extension isn't enabled

Alistair

>      s->harts[idx].env.mhartid =3D s->hartid_base + idx;
>      qemu_register_reset(riscv_harts_cpu_reset, &s->harts[idx]);
>      return qdev_realize(DEVICE(&s->harts[idx]), NULL, errp);
> diff --git a/include/hw/riscv/riscv_hart.h b/include/hw/riscv/riscv_hart.=
h
> index 912b4a2682..a6ed73a195 100644
> --- a/include/hw/riscv/riscv_hart.h
> +++ b/include/hw/riscv/riscv_hart.h
> @@ -38,6 +38,10 @@ struct RISCVHartArrayState {
>      uint32_t hartid_base;
>      char *cpu_type;
>      uint64_t resetvec;
> +    uint32_t num_rnmi_irqvec;
> +    uint64_t *rnmi_irqvec;
> +    uint32_t num_rnmi_excpvec;
> +    uint64_t *rnmi_excpvec;
>      RISCVCPU *harts;
>  };
>
> diff --git a/target/riscv/cpu.c b/target/riscv/cpu.c
> index 2a78cd639b..5ce6ed31ec 100644
> --- a/target/riscv/cpu.c
> +++ b/target/riscv/cpu.c
> @@ -1297,6 +1297,11 @@ static void riscv_cpu_set_irq(void *opaque, int ir=
q, int level)
>          g_assert_not_reached();
>      }
>  }
> +
> +static void riscv_cpu_set_nmi(void *opaque, int irq, int level)
> +{
> +    riscv_cpu_set_rnmi(RISCV_CPU(opaque), irq, level);
> +}
>  #endif /* CONFIG_USER_ONLY */
>
>  static bool riscv_cpu_is_dynamic(Object *cpu_obj)
> @@ -1320,6 +1325,8 @@ static void riscv_cpu_init(Object *obj)
>  #ifndef CONFIG_USER_ONLY
>      qdev_init_gpio_in(DEVICE(obj), riscv_cpu_set_irq,
>                        IRQ_LOCAL_MAX + IRQ_LOCAL_GUEST_MAX);
> +    qdev_init_gpio_in_named(DEVICE(cpu), riscv_cpu_set_nmi,
> +                            "riscv.cpu.rnmi", RNMI_MAX);
>  #endif /* CONFIG_USER_ONLY */
>
>      general_user_opts =3D g_hash_table_new(g_str_hash, g_str_equal);
> @@ -2670,6 +2677,10 @@ static Property riscv_cpu_properties[] =3D {
>
>  #ifndef CONFIG_USER_ONLY
>      DEFINE_PROP_UINT64("resetvec", RISCVCPU, env.resetvec, DEFAULT_RSTVE=
C),
> +    DEFINE_PROP_UINT64("rnmi-interrupt-vector", RISCVCPU, env.rnmi_irqve=
c,
> +                       DEFAULT_RNMI_IRQVEC),
> +    DEFINE_PROP_UINT64("rnmi-exception-vector", RISCVCPU, env.rnmi_excpv=
ec,
> +                       DEFAULT_RNMI_EXCPVEC),
>  #endif
>
>      DEFINE_PROP_BOOL("short-isa-string", RISCVCPU, cfg.short_isa_string,=
 false),
> diff --git a/target/riscv/cpu.h b/target/riscv/cpu.h
> index a63a29744c..8b2a863c50 100644
> --- a/target/riscv/cpu.h
> +++ b/target/riscv/cpu.h
> @@ -472,6 +472,11 @@ struct CPUArchState {
>      uint64_t kvm_timer_state;
>      uint64_t kvm_timer_frequency;
>  #endif /* CONFIG_KVM */
> +
> +    /* RNMI */
> +    target_ulong rnmip;
> +    uint64_t rnmi_irqvec;
> +    uint64_t rnmi_excpvec;
>  };
>
>  /*
> @@ -568,6 +573,7 @@ void riscv_cpu_swap_hypervisor_regs(CPURISCVState *en=
v);
>  int riscv_cpu_claim_interrupts(RISCVCPU *cpu, uint64_t interrupts);
>  uint64_t riscv_cpu_update_mip(CPURISCVState *env, uint64_t mask,
>                                uint64_t value);
> +void riscv_cpu_set_rnmi(RISCVCPU *cpu, uint32_t irq, bool level);
>  void riscv_cpu_interrupt(CPURISCVState *env);
>  #define BOOL_TO_MASK(x) (-!!(x)) /* helper for riscv_cpu_update_mip valu=
e */
>  void riscv_cpu_set_rdtime_fn(CPURISCVState *env, uint64_t (*fn)(void *),
> diff --git a/target/riscv/cpu_bits.h b/target/riscv/cpu_bits.h
> index 7e3f629356..6df2cbc2be 100644
> --- a/target/riscv/cpu_bits.h
> +++ b/target/riscv/cpu_bits.h
> @@ -662,6 +662,12 @@ typedef enum {
>  /* Default Reset Vector address */
>  #define DEFAULT_RSTVEC      0x1000
>
> +/* Default RNMI Interrupt Vector address */
> +#define DEFAULT_RNMI_IRQVEC     0x0
> +
> +/* Default RNMI Exception Vector address */
> +#define DEFAULT_RNMI_EXCPVEC    0x0
> +
>  /* Exception causes */
>  typedef enum RISCVException {
>      RISCV_EXCP_NONE =3D -1, /* sentinel value */
> @@ -711,6 +717,9 @@ typedef enum RISCVException {
>  /* -1 is due to bit zero of hgeip and hgeie being ROZ. */
>  #define IRQ_LOCAL_GUEST_MAX                (TARGET_LONG_BITS - 1)
>
> +/* RNMI causes */
> +#define RNMI_MAX                           16
> +
>  /* mip masks */
>  #define MIP_USIP                           (1 << IRQ_U_SOFT)
>  #define MIP_SSIP                           (1 << IRQ_S_SOFT)
> @@ -942,6 +951,9 @@ typedef enum RISCVException {
>  #define MHPMEVENT_IDX_MASK                 0xFFFFF
>  #define MHPMEVENT_SSCOF_RESVD              16
>
> +/* RISC-V-specific interrupt pending bits. */
> +#define CPU_INTERRUPT_RNMI                 CPU_INTERRUPT_TGT_EXT_0
> +
>  /* JVT CSR bits */
>  #define JVT_MODE                           0x3F
>  #define JVT_BASE                           (~0x3F)
> diff --git a/target/riscv/cpu_helper.c b/target/riscv/cpu_helper.c
> index 203c0a92ab..977bf97c16 100644
> --- a/target/riscv/cpu_helper.c
> +++ b/target/riscv/cpu_helper.c
> @@ -434,6 +434,18 @@ static int riscv_cpu_local_irq_pending(CPURISCVState=
 *env)
>      uint64_t vsbits, irq_delegated;
>      int virq;
>
> +    /* Priority: RNMI > Other interrupt. */
> +    if (riscv_cpu_cfg(env)->ext_smrnmi) {
> +        /* If mnstatus.NMIE =3D=3D 0, all interrupts are disabled. */
> +        if (!get_field(env->mnstatus, MNSTATUS_NMIE)) {
> +            return RISCV_EXCP_NONE;
> +        }
> +
> +        if (env->rnmip) {
> +            return ctz64(env->rnmip); /* since non-zero */
> +        }
> +    }
> +
>      /* Determine interrupt enable state of all privilege modes */
>      if (env->virt_enabled) {
>          mie =3D 1;
> @@ -496,7 +508,9 @@ static int riscv_cpu_local_irq_pending(CPURISCVState =
*env)
>
>  bool riscv_cpu_exec_interrupt(CPUState *cs, int interrupt_request)
>  {
> -    if (interrupt_request & CPU_INTERRUPT_HARD) {
> +    uint32_t mask =3D CPU_INTERRUPT_HARD | CPU_INTERRUPT_RNMI;
> +
> +    if (interrupt_request & mask) {
>          RISCVCPU *cpu =3D RISCV_CPU(cs);
>          CPURISCVState *env =3D &cpu->env;
>          int interruptno =3D riscv_cpu_local_irq_pending(env);
> @@ -619,6 +633,30 @@ void riscv_cpu_set_geilen(CPURISCVState *env, target=
_ulong geilen)
>      env->geilen =3D geilen;
>  }
>
> +void riscv_cpu_set_rnmi(RISCVCPU *cpu, uint32_t irq, bool level)
> +{
> +    CPURISCVState *env =3D &cpu->env;
> +    CPUState *cs =3D CPU(cpu);
> +    bool release_lock =3D false;
> +
> +    if (!bql_locked()) {
> +        release_lock =3D true;
> +        bql_lock();
> +    }
> +
> +    if (level) {
> +        env->rnmip |=3D 1 << irq;
> +        cpu_interrupt(cs, CPU_INTERRUPT_RNMI);
> +    } else {
> +        env->rnmip &=3D ~(1 << irq);
> +        cpu_reset_interrupt(cs, CPU_INTERRUPT_RNMI);
> +    }
> +
> +    if (release_lock) {
> +        bql_unlock();
> +    }
> +}
> +
>  int riscv_cpu_claim_interrupts(RISCVCPU *cpu, uint64_t interrupts)
>  {
>      CPURISCVState *env =3D &cpu->env;
> @@ -1661,6 +1699,7 @@ void riscv_cpu_do_interrupt(CPUState *cs)
>      bool virt =3D env->virt_enabled;
>      bool write_gva =3D false;
>      uint64_t s;
> +    int mode;
>
>      /*
>       * cs->exception is 32-bits wide unlike mcause which is XLEN-bits wi=
de
> @@ -1679,6 +1718,23 @@ void riscv_cpu_do_interrupt(CPUState *cs)
>      target_ulong mtval2 =3D 0;
>      int sxlen =3D 0;
>      int mxlen =3D 0;
> +    bool nnmi_excep =3D false;
> +
> +    if (cpu->cfg.ext_smrnmi && env->rnmip && async) {
> +        env->mnstatus =3D set_field(env->mnstatus, MNSTATUS_NMIE, false)=
;
> +        env->mnstatus =3D set_field(env->mnstatus, MNSTATUS_MNPV,
> +                                  env->virt_enabled);
> +        env->mnstatus =3D set_field(env->mnstatus, MNSTATUS_MNPP,
> +                                  env->priv);
> +        env->mncause =3D cause | ((target_ulong)1U << (TARGET_LONG_BITS =
- 1));
> +        env->mnepc =3D env->pc;
> +        env->pc =3D env->rnmi_irqvec;
> +
> +        /* Trapping to M mode, virt is disabled */
> +        riscv_cpu_set_mode(env, PRV_M, false);
> +
> +        return;
> +    }
>
>      if (!async) {
>          /* set tval to badaddr for traps with address information */
> @@ -1766,8 +1822,10 @@ void riscv_cpu_do_interrupt(CPUState *cs)
>                    __func__, env->mhartid, async, cause, env->pc, tval,
>                    riscv_cpu_get_trap_name(cause, async));
>
> -    if (env->priv <=3D PRV_S && cause < 64 &&
> -        (((deleg >> cause) & 1) || s_injected || vs_injected)) {
> +    mode =3D env->priv <=3D PRV_S && cause < 64 &&
> +        (((deleg >> cause) & 1) || s_injected || vs_injected) ? PRV_S : =
PRV_M;
> +
> +    if (mode =3D=3D PRV_S) {
>          /* handle the trap in S-mode */
>          if (riscv_has_ext(env, RVH)) {
>              uint64_t hdeleg =3D async ? env->hideleg : env->hedeleg;
> @@ -1845,8 +1903,22 @@ void riscv_cpu_do_interrupt(CPUState *cs)
>          env->mtval =3D tval;
>          env->mtval2 =3D mtval2;
>          env->mtinst =3D tinst;
> -        env->pc =3D (env->mtvec >> 2 << 2) +
> -                  ((async && (env->mtvec & 3) =3D=3D 1) ? cause * 4 : 0)=
;
> +
> +        /*
> +         * If the hart encounters an exception while executing in M-mode=
,
> +         * with the mnstatus.NMIE bit clear, the program counter is set =
to
> +         * the RNMI exception trap handler address.
> +         */
> +        nnmi_excep =3D cpu->cfg.ext_smrnmi &&
> +                     !get_field(env->mnstatus, MNSTATUS_NMIE) &&
> +                     !async;
> +
> +        if (nnmi_excep) {
> +            env->pc =3D env->rnmi_excpvec;
> +        } else {
> +            env->pc =3D (env->mtvec >> 2 << 2) +
> +                      ((async && (env->mtvec & 3) =3D=3D 1) ? cause * 4 =
: 0);
> +        }
>          riscv_cpu_set_mode(env, PRV_M, virt);
>      }
>
> --
> 2.43.2
>
>

