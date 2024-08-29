Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 65E27C83F2D
	for <qemu-devel@archiver.kernel.org>; Thu, 29 Aug 2024 15:18:52 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sjguG-0005hP-6A; Thu, 29 Aug 2024 11:17:52 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <tommy.wu@sifive.com>)
 id 1sjgu8-0005am-9S
 for qemu-devel@nongnu.org; Thu, 29 Aug 2024 11:17:44 -0400
Received: from mail-wm1-x335.google.com ([2a00:1450:4864:20::335])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <tommy.wu@sifive.com>)
 id 1sjgu2-00075i-Hx
 for qemu-devel@nongnu.org; Thu, 29 Aug 2024 11:17:44 -0400
Received: by mail-wm1-x335.google.com with SMTP id
 5b1f17b1804b1-4280ee5f1e3so7547145e9.0
 for <qemu-devel@nongnu.org>; Thu, 29 Aug 2024 08:17:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sifive.com; s=google; t=1724944656; x=1725549456; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=OOG/sGAn40wnIZQPTGZNJ5y3+jB3IP+W33S6NtXSmF8=;
 b=SU7vbnype+uaWqk56uVosykQPWrWk7SGxLg0dmnfcg0gxEuD+1z1MrPUDSbshueA/K
 jKSLEeXocC84b3Qc5xFpYli8arWb+vpFD6KEfQYXjm69ZGXd4LhjjXfIsAOC5SRS2F2Y
 G01LRsE58ujglb8qqZJPQZlgSedc05A5EpB8q6Wv7Bx7s+DTfFqKG/XrcpUilHBJbXHU
 vVNAowLJpHchG2oDMyKrhwGEmr2aFZdnZQCvnC+51sb5BORrlvrThYQUYrBB6GGuvwXz
 RYNJJjreEipuXneXX6CSeCAeYJ6gUj52d0LtcYByhgE8ztHEiuB5qJKMCPrRLMDdTYhy
 ejew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1724944656; x=1725549456;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=OOG/sGAn40wnIZQPTGZNJ5y3+jB3IP+W33S6NtXSmF8=;
 b=pzAI4AJELOSWsEXx4yNdpLfgnHoY0STitXPp2g0rn6BEJAFzJOZeMha5mxsHd4hvik
 WvRqQ76Vr5IhmoJ35VfQvSBR8QScG/4uA45NArk+S2Wu2AwIFYbN4eFb/Z5HB/gpxMzV
 5uZWIgqpZMrfxrBSyQWq9pPCPauzBb/y7T7BlSRqm2H/krSTH4KZ7pMqrukJ3EVyjqCv
 Dv3ghC957ZVyqJv/kKn8ABHQC7rY+Sx8iRECyCTJTCM+ge6FyBvcyt875IqU4iyioZTK
 q3eiSSTgB4nrx20+HsgGIlgblWAhK/Fc80LmV7jsR7F5P+fOK6QWk9WY4xZV5cqOQiLM
 idMg==
X-Gm-Message-State: AOJu0YxWN/fEbcnxzQZ9Zc6Z5xP++FRMdb6ALa2Y/WUiHE3E3w/8noX2
 Bp1afNI8vAAGHG47KT7wIREEA6Zo1Qnw79lxVirWw1ua8b0KV9yrmt6gQVr6nu6R3vdT4eNQQ//
 dJVPIgVhMlpdBkcsuj5YG/z6dZcknzHddSDj6hA==
X-Google-Smtp-Source: AGHT+IHtzVHapLXYSGChsBmvur5UP1JACZZR73d0n5bZELtb6CXUZgm3qa6VkCN9P6dPNA1Yt0fD3gyJzo/CLbb+GCg=
X-Received: by 2002:a05:600c:3104:b0:42b:a88f:f872 with SMTP id
 5b1f17b1804b1-42bb27ba51bmr28470135e9.32.1724944656517; Thu, 29 Aug 2024
 08:17:36 -0700 (PDT)
MIME-Version: 1.0
References: <20240809081227.1588508-1-tommy.wu@sifive.com>
 <20240809081227.1588508-3-tommy.wu@sifive.com>
 <SEYPR03MB6700217C202361DE37802EABA8802@SEYPR03MB6700.apcprd03.prod.outlook.com>
In-Reply-To: <SEYPR03MB6700217C202361DE37802EABA8802@SEYPR03MB6700.apcprd03.prod.outlook.com>
From: Tommy Wu <tommy.wu@sifive.com>
Date: Thu, 29 Aug 2024 23:17:25 +0800
Message-ID: <CANj3q_kUPFh+hT5sm6CzUEPENxdsE7hz0e2EAC3dS7Pfr5vDBQ@mail.gmail.com>
Subject: Re: [PATCH v5 2/5] target/riscv: Handle Smrnmi interrupt and
 exception.
To: =?UTF-8?B?QWx2aW4gQ2hlLUNoaWEgQ2hhbmco5by15ZOy5ZiJKQ==?=
 <alvinga@andestech.com>
Cc: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
 "qemu-riscv@nongnu.org" <qemu-riscv@nongnu.org>, 
 "frank.chang@sifive.com" <frank.chang@sifive.com>,
 "palmer@dabbelt.com" <palmer@dabbelt.com>, 
 "alistair.francis@wdc.com" <alistair.francis@wdc.com>,
 "alistair23@gmail.com" <alistair23@gmail.com>, 
 "bin.meng@windriver.com" <bin.meng@windriver.com>,
 "liweiwei@iscas.ac.cn" <liweiwei@iscas.ac.cn>, 
 "dbarboza@ventanamicro.com" <dbarboza@ventanamicro.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::335;
 envelope-from=tommy.wu@sifive.com; helo=mail-wm1-x335.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, T_SCC_BODY_TEXT_LINE=-0.01,
 T_SPF_TEMPERROR=0.01 autolearn=unavailable autolearn_force=no
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

On Thu, Aug 15, 2024 at 9:40=E2=80=AFAM Alvin Che-Chia Chang(=E5=BC=B5=E5=
=93=B2=E5=98=89)
<alvinga@andestech.com> wrote:
>
> Hi Tommy,
>
> > -----Original Message-----
> > From: qemu-riscv-bounces+alvinga=3Dandestech.com@nongnu.org
> > <qemu-riscv-bounces+alvinga=3Dandestech.com@nongnu.org> On Behalf Of
> > Tommy Wu
> > Sent: Friday, August 9, 2024 4:12 PM
> > To: qemu-devel@nongnu.org; qemu-riscv@nongnu.org
> > Cc: frank.chang@sifive.com; palmer@dabbelt.com; alistair.francis@wdc.co=
m;
> > alistair23@gmail.com; bin.meng@windriver.com; liweiwei@iscas.ac.cn;
> > dbarboza@ventanamicro.com; Tommy Wu <tommy.wu@sifive.com>
> > Subject: [PATCH v5 2/5] target/riscv: Handle Smrnmi interrupt and excep=
tion.
> >
> > [EXTERNAL MAIL]
> >
> > Because the RNMI interrupt trap handler address is implementation defin=
ed.
> > We add the `rnmi-interrupt-vector` and `rnmi-exception-vector` as the
> > property of the harts. It=E2=80=99s very easy for users to set the addr=
ess based on their
> > expectation. This patch also adds the functionality to handle the RNMI =
signals.
> >
> > Signed-off-by: Frank Chang <frank.chang@sifive.com>
> > Signed-off-by: Tommy Wu <tommy.wu@sifive.com>
> > ---
> >  hw/riscv/riscv_hart.c         | 18 ++++++++
> >  include/hw/riscv/riscv_hart.h |  4 ++
> >  target/riscv/cpu.c            | 11 +++++
> >  target/riscv/cpu.h            |  6 +++
> >  target/riscv/cpu_bits.h       | 12 ++++++
> >  target/riscv/cpu_helper.c     | 77
> > +++++++++++++++++++++++++++++++++--
> >  6 files changed, 125 insertions(+), 3 deletions(-)
> >
> > diff --git a/hw/riscv/riscv_hart.c b/hw/riscv/riscv_hart.c index
> > 613ea2aaa0..b7d73f7a82 100644
> > --- a/hw/riscv/riscv_hart.c
> > +++ b/hw/riscv/riscv_hart.c
> > @@ -33,6 +33,12 @@ static Property riscv_harts_props[] =3D {
> >      DEFINE_PROP_STRING("cpu-type", RISCVHartArrayState, cpu_type),
> >      DEFINE_PROP_UINT64("resetvec", RISCVHartArrayState, resetvec,
> >                         DEFAULT_RSTVEC),
> > +    DEFINE_PROP_ARRAY("rnmi-interrupt-vector", RISCVHartArrayState,
> > +                      num_rnmi_irqvec, rnmi_irqvec,
> > qdev_prop_uint64,
> > +                      uint64_t),
> > +    DEFINE_PROP_ARRAY("rnmi-exception-vector", RISCVHartArrayState,
> > +                      num_rnmi_excpvec, rnmi_excpvec,
> > qdev_prop_uint64,
> > +                      uint64_t),
> >      DEFINE_PROP_END_OF_LIST(),
> >  };
> >
> > @@ -47,6 +53,18 @@ static bool riscv_hart_realize(RISCVHartArrayState *=
s,
> > int idx,  {
> >      object_initialize_child(OBJECT(s), "harts[*]", &s->harts[idx], cpu=
_type);
> >      qdev_prop_set_uint64(DEVICE(&s->harts[idx]), "resetvec", s->resetv=
ec);
> > +    if (s->harts[idx].cfg.ext_smrnmi) {
> > +        if (s->rnmi_irqvec) {
> > +            qdev_prop_set_uint64(DEVICE(&s->harts[idx]),
> > +                                 "rnmi-interrupt-vector",
> > +                                 s->rnmi_irqvec[idx]);
> > +        }
> > +        if (s->rnmi_excpvec) {
> > +            qdev_prop_set_uint64(DEVICE(&s->harts[idx]),
> > +                                 "rnmi-exception-vector",
> > +                                 s->rnmi_excpvec[idx]);
> > +        }
> > +    }
> >      s->harts[idx].env.mhartid =3D s->hartid_base + idx;
> >      qemu_register_reset(riscv_harts_cpu_reset, &s->harts[idx]);
> >      return qdev_realize(DEVICE(&s->harts[idx]), NULL, errp); diff --gi=
t
> > a/include/hw/riscv/riscv_hart.h b/include/hw/riscv/riscv_hart.h index
> > 912b4a2682..a6ed73a195 100644
> > --- a/include/hw/riscv/riscv_hart.h
> > +++ b/include/hw/riscv/riscv_hart.h
> > @@ -38,6 +38,10 @@ struct RISCVHartArrayState {
> >      uint32_t hartid_base;
> >      char *cpu_type;
> >      uint64_t resetvec;
> > +    uint32_t num_rnmi_irqvec;
> > +    uint64_t *rnmi_irqvec;
> > +    uint32_t num_rnmi_excpvec;
> > +    uint64_t *rnmi_excpvec;
> >      RISCVCPU *harts;
> >  };
> >
> > diff --git a/target/riscv/cpu.c b/target/riscv/cpu.c index
> > a90808a3ba..2f64b3df22 100644
> > --- a/target/riscv/cpu.c
> > +++ b/target/riscv/cpu.c
> > @@ -1309,6 +1309,11 @@ static void riscv_cpu_set_irq(void *opaque, int =
irq,
> > int level)
> >          g_assert_not_reached();
> >      }
> >  }
> > +
> > +static void riscv_cpu_set_nmi(void *opaque, int irq, int level) {
> > +    riscv_cpu_set_rnmi(RISCV_CPU(opaque), irq, level); }
> >  #endif /* CONFIG_USER_ONLY */
> >
> >  static bool riscv_cpu_is_dynamic(Object *cpu_obj) @@ -1332,6 +1337,8 @=
@
> > static void riscv_cpu_init(Object *obj)  #ifndef CONFIG_USER_ONLY
> >      qdev_init_gpio_in(DEVICE(obj), riscv_cpu_set_irq,
> >                        IRQ_LOCAL_MAX + IRQ_LOCAL_GUEST_MAX);
> > +    qdev_init_gpio_in_named(DEVICE(cpu), riscv_cpu_set_nmi,
> > +                            "riscv.cpu.rnmi", RNMI_MAX);
> >  #endif /* CONFIG_USER_ONLY */
> >
> >      general_user_opts =3D g_hash_table_new(g_str_hash, g_str_equal); @=
@
> > -2681,6 +2688,10 @@ static Property riscv_cpu_properties[] =3D {
> >
> >  #ifndef CONFIG_USER_ONLY
> >      DEFINE_PROP_UINT64("resetvec", RISCVCPU, env.resetvec,
> > DEFAULT_RSTVEC),
> > +    DEFINE_PROP_UINT64("rnmi-interrupt-vector", RISCVCPU,
> > env.rnmi_irqvec,
> > +                       DEFAULT_RNMI_IRQVEC),
> > +    DEFINE_PROP_UINT64("rnmi-exception-vector", RISCVCPU,
> > env.rnmi_excpvec,
> > +                       DEFAULT_RNMI_EXCPVEC),
> >  #endif
> >
> >      DEFINE_PROP_BOOL("short-isa-string", RISCVCPU, cfg.short_isa_strin=
g,
> > false), diff --git a/target/riscv/cpu.h b/target/riscv/cpu.h index
> > 1619c3acb6..d8ad04ec31 100644
> > --- a/target/riscv/cpu.h
> > +++ b/target/riscv/cpu.h
> > @@ -472,6 +472,11 @@ struct CPUArchState {
> >      uint64_t kvm_timer_state;
> >      uint64_t kvm_timer_frequency;
> >  #endif /* CONFIG_KVM */
> > +
> > +    /* RNMI */
> > +    target_ulong rnmip;
> > +    uint64_t rnmi_irqvec;
> > +    uint64_t rnmi_excpvec;
> >  };
> >
> >  /*
> > @@ -568,6 +573,7 @@ void riscv_cpu_swap_hypervisor_regs(CPURISCVState
> > *env);  int riscv_cpu_claim_interrupts(RISCVCPU *cpu, uint64_t interrup=
ts);
> > uint64_t riscv_cpu_update_mip(CPURISCVState *env, uint64_t mask,
> >                                uint64_t value);
> > +void riscv_cpu_set_rnmi(RISCVCPU *cpu, uint32_t irq, bool level);
> >  void riscv_cpu_interrupt(CPURISCVState *env);  #define BOOL_TO_MASK(x)
> > (-!!(x)) /* helper for riscv_cpu_update_mip value */  void
> > riscv_cpu_set_rdtime_fn(CPURISCVState *env, uint64_t (*fn)(void *), dif=
f --git
> > a/target/riscv/cpu_bits.h b/target/riscv/cpu_bits.h index
> > 32b068f18a..e14b654c35 100644
> > --- a/target/riscv/cpu_bits.h
> > +++ b/target/riscv/cpu_bits.h
> > @@ -662,6 +662,12 @@ typedef enum {
> >  /* Default Reset Vector address */
> >  #define DEFAULT_RSTVEC      0x1000
> >
> > +/* Default RNMI Interrupt Vector address */
> > +#define DEFAULT_RNMI_IRQVEC     0x0
> > +
> > +/* Default RNMI Exception Vector address */
> > +#define DEFAULT_RNMI_EXCPVEC    0x0
> > +
> >  /* Exception causes */
> >  typedef enum RISCVException {
> >      RISCV_EXCP_NONE =3D -1, /* sentinel value */ @@ -711,6 +717,9 @@
> > typedef enum RISCVException {
> >  /* -1 is due to bit zero of hgeip and hgeie being ROZ. */
> >  #define IRQ_LOCAL_GUEST_MAX                (TARGET_LONG_BITS -
> > 1)
> >
> > +/* RNMI causes */
> > +#define RNMI_MAX                           16
> > +
> >  /* mip masks */
> >  #define MIP_USIP                           (1 << IRQ_U_SOFT)
> >  #define MIP_SSIP                           (1 << IRQ_S_SOFT)
> > @@ -942,6 +951,9 @@ typedef enum RISCVException {
> >  #define MHPMEVENT_IDX_MASK                 0xFFFFF
> >  #define MHPMEVENT_SSCOF_RESVD              16
> >
> > +/* RISC-V-specific interrupt pending bits. */
> > +#define CPU_INTERRUPT_RNMI
> > CPU_INTERRUPT_TGT_EXT_0
> > +
> >  /* JVT CSR bits */
> >  #define JVT_MODE                           0x3F
> >  #define JVT_BASE                           (~0x3F)
> > diff --git a/target/riscv/cpu_helper.c b/target/riscv/cpu_helper.c inde=
x
> > 395a1d9140..f1d464a554 100644
> > --- a/target/riscv/cpu_helper.c
> > +++ b/target/riscv/cpu_helper.c
> > @@ -434,6 +434,18 @@ static int riscv_cpu_local_irq_pending(CPURISCVSta=
te
> > *env)
> >      uint64_t vsbits, irq_delegated;
> >      int virq;
> >
> > +    /* Priority: RNMI > Other interrupt. */
> > +    if (riscv_cpu_cfg(env)->ext_smrnmi) {
> > +        /* If mnstatus.NMIE =3D=3D 0, all interrupts are disabled. */
> > +        if (!get_field(env->mnstatus, MNSTATUS_NMIE)) {
> > +            return RISCV_EXCP_NONE;
> > +        }
> > +
> > +        if (env->rnmip) {
> > +            return ctz64(env->rnmip); /* since non-zero */
> > +        }
> > +    }
> > +
> >      /* Determine interrupt enable state of all privilege modes */
> >      if (env->virt_enabled) {
> >          mie =3D 1;
> > @@ -496,7 +508,9 @@ static int riscv_cpu_local_irq_pending(CPURISCVStat=
e
> > *env)
> >
> >  bool riscv_cpu_exec_interrupt(CPUState *cs, int interrupt_request)  {
> > -    if (interrupt_request & CPU_INTERRUPT_HARD) {
> > +    uint32_t mask =3D CPU_INTERRUPT_HARD | CPU_INTERRUPT_RNMI;
> > +
> > +    if (interrupt_request & mask) {
> >          RISCVCPU *cpu =3D RISCV_CPU(cs);
> >          CPURISCVState *env =3D &cpu->env;
> >          int interruptno =3D riscv_cpu_local_irq_pending(env); @@ -619,=
6
> > +633,30 @@ void riscv_cpu_set_geilen(CPURISCVState *env, target_ulong
> > geilen)
> >      env->geilen =3D geilen;
> >  }
> >
> > +void riscv_cpu_set_rnmi(RISCVCPU *cpu, uint32_t irq, bool level) {
> > +    CPURISCVState *env =3D &cpu->env;
> > +    CPUState *cs =3D CPU(cpu);
> > +    bool release_lock =3D false;
> > +
> > +    if (!bql_locked()) {
> > +        release_lock =3D true;
> > +        bql_lock();
> > +    }
> > +
> > +    if (level) {
> > +        env->rnmip |=3D 1 << irq;
> > +        cpu_interrupt(cs, CPU_INTERRUPT_RNMI);
> > +    } else {
> > +        env->rnmip &=3D ~(1 << irq);
> > +        cpu_reset_interrupt(cs, CPU_INTERRUPT_RNMI);
> > +    }
> > +
> > +    if (release_lock) {
> > +        bql_unlock();
> > +    }
> > +}
> > +
> >  int riscv_cpu_claim_interrupts(RISCVCPU *cpu, uint64_t interrupts)  {
> >      CPURISCVState *env =3D &cpu->env;
> > @@ -1654,6 +1692,7 @@ void riscv_cpu_do_interrupt(CPUState *cs)
> >      bool virt =3D env->virt_enabled;
> >      bool write_gva =3D false;
> >      uint64_t s;
> > +    int mode;
> >
> >      /*
> >       * cs->exception is 32-bits wide unlike mcause which is XLEN-bits =
wide
> > @@ -1670,6 +1709,20 @@ void riscv_cpu_do_interrupt(CPUState *cs)
> >      target_ulong tinst =3D 0;
> >      target_ulong htval =3D 0;
> >      target_ulong mtval2 =3D 0;
> > +    bool nmi_execp =3D false;
> > +
> > +    if (cpu->cfg.ext_smrnmi && env->rnmip && async) {
> > +        env->mnstatus =3D set_field(env->mnstatus, MNSTATUS_NMIE, fals=
e);
> > +        env->mnstatus =3D set_field(env->mnstatus, MNSTATUS_MNPV,
> > +                                  env->virt_enabled);
> > +        env->mnstatus =3D set_field(env->mnstatus, MNSTATUS_MNPP,
> > +                                  env->priv);
> > +        env->mncause =3D cause | ((target_ulong)1U << (TARGET_LONG_BIT=
S
> > - 1));
> > +        env->mnepc =3D env->pc;
> > +        env->pc =3D env->rnmi_irqvec;
> > +        riscv_cpu_set_mode(env, PRV_M, virt);
> > +        return;
> > +    }
> >
> >      if (!async) {
> >          /* set tval to badaddr for traps with address information */ @=
@
> > -1755,8 +1808,20 @@ void riscv_cpu_do_interrupt(CPUState *cs)
> >                    __func__, env->mhartid, async, cause, env->pc, tval,
> >                    riscv_cpu_get_trap_name(cause, async));
> >
> > -    if (env->priv <=3D PRV_S && cause < 64 &&
> > -        (((deleg >> cause) & 1) || s_injected || vs_injected)) {
> > +    mode =3D env->priv <=3D PRV_S && cause < 64 &&
> > +        (((deleg >> cause) & 1) || s_injected || vs_injected) ? PRV_S =
:
> > + PRV_M;
> > +
> > +    /*
> > +     * If the hart encounters an exception while executing in M-mode,
> > +     * with the mnstatus.NMIE bit clear, the program counter is set to
> > +     * the RNMI exception trap handler address.
> > +     */
> > +    nmi_execp =3D cpu->cfg.ext_smrnmi &&
> > +                !get_field(env->mnstatus, MNSTATUS_NMIE) &&
> > +                !async &&
> > +                mode =3D=3D PRV_M;
> > +
> > +    if (mode =3D=3D PRV_S) {
> >          /* handle the trap in S-mode */
> >          if (riscv_has_ext(env, RVH)) {
> >              uint64_t hdeleg =3D async ? env->hideleg : env->hedeleg; @=
@
> > -1834,6 +1899,12 @@ void riscv_cpu_do_interrupt(CPUState *cs)
> >          env->mtinst =3D tinst;
> >          env->pc =3D (env->mtvec >> 2 << 2) +
> >                    ((async && (env->mtvec & 3) =3D=3D 1) ? cause * 4 : =
0);
> Seems above two lines could be removed, since you set env->pc again in th=
e following if-else.
>

Thank you! I forgot to delete the redundant code.
I'll delete that in the v6 patchset.

Regards,
Tommy Wu

> > +        if (cpu->cfg.ext_smrnmi && nmi_execp) {
> > +            env->pc =3D env->rnmi_excpvec;
> > +        } else {
> > +            env->pc =3D (env->mtvec >> 2 << 2) +
> > +                      ((async && (env->mtvec & 3) =3D=3D 1) ? cause * =
4 :
> > 0);
> > +        }
> >          riscv_cpu_set_mode(env, PRV_M, virt);
> >      }
> >
> > --
> > 2.39.3
> >
>
> BRs,
> Alvin Chang
>
> CONFIDENTIALITY NOTICE:
>
> This e-mail (and its attachments) may contain confidential and legally pr=
ivileged information or information protected from disclosure. If you are n=
ot the intended recipient, you are hereby notified that any disclosure, cop=
ying, distribution, or use of the information contained herein is strictly =
prohibited. In this case, please immediately notify the sender by return e-=
mail, delete the message (and any accompanying documents) and destroy all p=
rinted hard copies. Thank you for your cooperation.
>
> Copyright ANDES TECHNOLOGY CORPORATION - All Rights Reserved.

