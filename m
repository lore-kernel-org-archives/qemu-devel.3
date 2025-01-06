Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 398CAE77188
	for <qemu-devel@archiver.kernel.org>; Mon,  6 Jan 2025 05:46:02 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tUfum-0003rY-JD; Mon, 06 Jan 2025 00:44:36 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <frank.chang@sifive.com>)
 id 1tUfuk-0003qa-6t
 for qemu-devel@nongnu.org; Mon, 06 Jan 2025 00:44:34 -0500
Received: from mail-ej1-x631.google.com ([2a00:1450:4864:20::631])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <frank.chang@sifive.com>)
 id 1tUfug-0004MZ-G6
 for qemu-devel@nongnu.org; Mon, 06 Jan 2025 00:44:33 -0500
Received: by mail-ej1-x631.google.com with SMTP id
 a640c23a62f3a-aa68b513abcso2611490866b.0
 for <qemu-devel@nongnu.org>; Sun, 05 Jan 2025 21:44:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sifive.com; s=google; t=1736142268; x=1736747068; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=Id6m3UeCKQGIqbvwo/gx83xVOLaO0XC3nt8kNAauB8A=;
 b=D1rh4g/3ZqzfQYY+Wxg3yjb4inVSgdXkq3zUypYps9EYKuBC4ehGWFELu9zW3KN9G6
 Qehwx6VPFa2eH2BOwT4H6pFKALNHnLrcceXkLD8asmYV/GYjaFZQPpqkwpn6NnUesM0V
 zAdwsr8AvjpgsPS82aUAuxoMOfrzb86U61au5tCLXexZRT0gn6fEx4BBtUp9+eFusG8q
 MHICRl0FBIhAh1H/xc2aTTaw3X7JPMJmdWmAdo+WW3rSs0af8uEJtb1BBfr4dhfAIak8
 TD9Yr4px/71sJGEzhtiN4++ymiOId20Tz6WYFkNLwf5fmDEMGy1dbJjZfQLJ5sQY13/w
 34eA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1736142268; x=1736747068;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=Id6m3UeCKQGIqbvwo/gx83xVOLaO0XC3nt8kNAauB8A=;
 b=ZDbnAbqnq8SDvKBtaC5GyRNohu21mf6xh55i3vOuapMVUfQqs4zGTReku5kLXBUY7O
 H2bSxHdJMRU2qSeupKJaTu0PoQvqYmf1vTQOztNkupxLCyC02rdKEJDBkILnMd2sHJnR
 bnfONFOetS5XFD29ljLdVsv/y85GoPCbCvQ0QNQv5lPyXs9hZCCkpYg0bCPo3bSjwlZw
 43a32kNNOhkGKlXC+aFulDKrZvTrc7L3qZQFvm9qvvxoJoftGeMSDyP0S6HFx8vMGpGX
 rC9LQ4nZL1aDJI0gq1NtNqql1n+6kgIHL9oxCBWVpfnE+iRAK49gUv5iviUJDJ0HlvQ9
 SQqw==
X-Gm-Message-State: AOJu0Yxo1VSIo9GNK6bhGS9oy0rg2aYWKPzFPDAQQDT2fn/gPKzDGUPQ
 +jRLzjuixmGCfhk6MsJeoV9RnfAcFGRorh7oXhwzODFPBjo+HMVad4UvJvn+uDtP40LttmsvH3w
 vAE7RDJ18HXDfs+AejX08t9brpH8sJgKkfR1ljg==
X-Gm-Gg: ASbGncuVozQ244Pn26oykg7rPoNQ/1znDt9dGT9zMSo0/iZ6ecn/w8UiZN/o27T6/fH
 maL9n5FQG4OLJM/3d+9inrgHQYr3w1DMOna+iViE=
X-Google-Smtp-Source: AGHT+IGwYLwF42wpBZqNGJU+R35c4q6IO8wOOMGFTXvzo8YscKMWMyPe5I6RssK/Kl3EySS34c8/hbB6bskLTJAGazg=
X-Received: by 2002:a17:907:72c4:b0:aa6:9599:a9af with SMTP id
 a640c23a62f3a-aac3368ad56mr4408974566b.53.1736142268236; Sun, 05 Jan 2025
 21:44:28 -0800 (PST)
MIME-Version: 1.0
References: <20241231032654.133039-1-frank.chang@sifive.com>
 <20241231032654.133039-4-frank.chang@sifive.com>
 <CAKmqyKOgY1SgL=iFD7iE74hMuQzqYNhwpdBBp_Lg02QGTFc7LA@mail.gmail.com>
In-Reply-To: <CAKmqyKOgY1SgL=iFD7iE74hMuQzqYNhwpdBBp_Lg02QGTFc7LA@mail.gmail.com>
From: Frank Chang <frank.chang@sifive.com>
Date: Mon, 6 Jan 2025 13:44:16 +0800
Message-ID: <CAE_xrPicV+Gbpt_JQg4CQNHN0qTPF_YrXiF0C0gAsPgoE=g3vQ@mail.gmail.com>
Subject: Re: [PATCH v11 3/6] target/riscv: Handle Smrnmi interrupt and
 exception
To: Alistair Francis <alistair23@gmail.com>
Cc: qemu-devel@nongnu.org, qemu-riscv@nongnu.org, 
 Palmer Dabbelt <palmer@dabbelt.com>,
 Alistair Francis <alistair.francis@wdc.com>, 
 Bin Meng <bmeng.cn@gmail.com>, Weiwei Li <liwei1518@gmail.com>, 
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>,
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>, Tommy Wu <tommy.wu@sifive.com>
Content-Type: multipart/alternative; boundary="0000000000002dab08062b031fd6"
Received-SPF: pass client-ip=2a00:1450:4864:20::631;
 envelope-from=frank.chang@sifive.com; helo=mail-ej1-x631.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, HTML_MESSAGE=0.001,
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

--0000000000002dab08062b031fd6
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Jan 6, 2025 at 9:45=E2=80=AFAM Alistair Francis <alistair23@gmail.c=
om>
wrote:

> On Tue, Dec 31, 2024 at 1:28=E2=80=AFPM <frank.chang@sifive.com> wrote:
> >
> > From: Tommy Wu <tommy.wu@sifive.com>
> >
> > Because the RNMI interrupt trap handler address is implementation
> defined.
> > We add the 'rnmi-interrupt-vector' and 'rnmi-exception-vector' as the
> property
> > of the harts. It=E2=80=99s very easy for users to set the address based=
 on their
> > expectation. This patch also adds the functionality to handle the RNMI
> signals.
> >
> > Signed-off-by: Frank Chang <frank.chang@sifive.com>
> > Signed-off-by: Tommy Wu <tommy.wu@sifive.com>
> > Reviewed-by: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
> > ---
> >  hw/riscv/riscv_hart.c         | 42 ++++++++++++++++-
> >  include/hw/riscv/riscv_hart.h |  4 ++
> >  target/riscv/cpu.c            | 11 +++++
> >  target/riscv/cpu.h            |  3 ++
> >  target/riscv/cpu_bits.h       | 12 +++++
> >  target/riscv/cpu_helper.c     | 85 ++++++++++++++++++++++++++++++++---
> >  6 files changed, 151 insertions(+), 6 deletions(-)
> >
> > diff --git a/hw/riscv/riscv_hart.c b/hw/riscv/riscv_hart.c
> > index 0df454772f..c2781848ce 100644
> > --- a/hw/riscv/riscv_hart.c
> > +++ b/hw/riscv/riscv_hart.c
> > @@ -26,6 +26,7 @@
> >  #include "target/riscv/cpu.h"
> >  #include "hw/qdev-properties.h"
> >  #include "hw/riscv/riscv_hart.h"
> > +#include "qemu/error-report.h"
> >
> >  static const Property riscv_harts_props[] =3D {
> >      DEFINE_PROP_UINT32("num-harts", RISCVHartArrayState, num_harts, 1)=
,
> > @@ -33,7 +34,23 @@ static const Property riscv_harts_props[] =3D {
> >      DEFINE_PROP_STRING("cpu-type", RISCVHartArrayState, cpu_type),
> >      DEFINE_PROP_UINT64("resetvec", RISCVHartArrayState, resetvec,
> >                         DEFAULT_RSTVEC),
> > -    DEFINE_PROP_END_OF_LIST(),
> > +
> > +    /*
> > +     * Smrnmi implementation-defined interrupt and exception trap
> handlers.
> > +     *
> > +     * When an RNMI interrupt is detected, the hart then enters M-mode
> and
> > +     * jumps to the address defined by "rnmi-interrupt-vector".
> > +     *
> > +     * When the hart encounters an exception while executing in M-mode
> with
> > +     * the mnstatus.NMIE bit clear, the hart then jumps to the address
> > +     * defined by "rnmi-exception-vector".
> > +     */
> > +    DEFINE_PROP_ARRAY("rnmi-interrupt-vector", RISCVHartArrayState,
> > +                      num_rnmi_irqvec, rnmi_irqvec, qdev_prop_uint64,
> > +                      uint64_t),
> > +    DEFINE_PROP_ARRAY("rnmi-exception-vector", RISCVHartArrayState,
> > +                      num_rnmi_excpvec, rnmi_excpvec, qdev_prop_uint64=
,
> > +                      uint64_t),
> >  };
> >
> >  static void riscv_harts_cpu_reset(void *opaque)
> > @@ -47,6 +64,29 @@ static bool riscv_hart_realize(RISCVHartArrayState
> *s, int idx,
> >  {
> >      object_initialize_child(OBJECT(s), "harts[*]", &s->harts[idx],
> cpu_type);
> >      qdev_prop_set_uint64(DEVICE(&s->harts[idx]), "resetvec",
> s->resetvec);
> > +
> > +    if (s->harts[idx].cfg.ext_smrnmi) {
> > +        if (idx < s->num_rnmi_irqvec) {
> > +            qdev_prop_set_uint64(DEVICE(&s->harts[idx]),
> > +                                 "rnmi-interrupt-vector",
> s->rnmi_irqvec[idx]);
> > +        }
> > +
> > +        if (idx < s->num_rnmi_excpvec) {
> > +            qdev_prop_set_uint64(DEVICE(&s->harts[idx]),
> > +                                 "rnmi-exception-vector",
> s->rnmi_excpvec[idx]);
> > +        }
> > +    } else {
> > +        if (s->num_rnmi_irqvec > 0) {
> > +            warn_report_once("rnmi-interrupt-vector property is ignore=
d
> "
> > +                             "because Smrnmi extension is not
> enabled.");
> > +        }
> > +
> > +        if (s->num_rnmi_excpvec > 0) {
> > +            warn_report_once("rnmi-exception-vector property is ignore=
d
> "
> > +                             "because Smrnmi extension is not
> enabled.");
> > +        }
> > +    }
> > +
> >      s->harts[idx].env.mhartid =3D s->hartid_base + idx;
> >      qemu_register_reset(riscv_harts_cpu_reset, &s->harts[idx]);
> >      return qdev_realize(DEVICE(&s->harts[idx]), NULL, errp);
> > diff --git a/include/hw/riscv/riscv_hart.h
> b/include/hw/riscv/riscv_hart.h
> > index 912b4a2682..a6ed73a195 100644
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
> > diff --git a/target/riscv/cpu.c b/target/riscv/cpu.c
> > index c5d5c2f7df..6c46a2f076 100644
> > --- a/target/riscv/cpu.c
> > +++ b/target/riscv/cpu.c
> > @@ -1412,6 +1412,11 @@ static void riscv_cpu_set_irq(void *opaque, int
> irq, int level)
> >          g_assert_not_reached();
> >      }
> >  }
> > +
> > +static void riscv_cpu_set_nmi(void *opaque, int irq, int level)
> > +{
> > +    riscv_cpu_set_rnmi(RISCV_CPU(opaque), irq, level);
> > +}
> >  #endif /* CONFIG_USER_ONLY */
> >
> >  static bool riscv_cpu_is_dynamic(Object *cpu_obj)
> > @@ -1435,6 +1440,8 @@ static void riscv_cpu_init(Object *obj)
> >  #ifndef CONFIG_USER_ONLY
> >      qdev_init_gpio_in(DEVICE(obj), riscv_cpu_set_irq,
> >                        IRQ_LOCAL_MAX + IRQ_LOCAL_GUEST_MAX);
> > +    qdev_init_gpio_in_named(DEVICE(cpu), riscv_cpu_set_nmi,
> > +                            "riscv.cpu.rnmi", RNMI_MAX);
> >  #endif /* CONFIG_USER_ONLY */
> >
> >      general_user_opts =3D g_hash_table_new(g_str_hash, g_str_equal);
> > @@ -2789,6 +2796,10 @@ static const Property riscv_cpu_properties[] =3D=
 {
> >
> >  #ifndef CONFIG_USER_ONLY
> >      DEFINE_PROP_UINT64("resetvec", RISCVCPU, env.resetvec,
> DEFAULT_RSTVEC),
> > +    DEFINE_PROP_UINT64("rnmi-interrupt-vector", RISCVCPU,
> env.rnmi_irqvec,
> > +                       DEFAULT_RNMI_IRQVEC),
> > +    DEFINE_PROP_UINT64("rnmi-exception-vector", RISCVCPU,
> env.rnmi_excpvec,
> > +                       DEFAULT_RNMI_EXCPVEC),
> >  #endif
> >
> >      DEFINE_PROP_BOOL("short-isa-string", RISCVCPU,
> cfg.short_isa_string, false),
> > diff --git a/target/riscv/cpu.h b/target/riscv/cpu.h
> > index a2cb471b3c..8dc5b4d002 100644
> > --- a/target/riscv/cpu.h
> > +++ b/target/riscv/cpu.h
> > @@ -493,6 +493,8 @@ struct CPUArchState {
> >      target_ulong mncause; /* mncause without bit XLEN-1 set to 1 */
> >      target_ulong mnstatus;
> >      target_ulong rnmip;
> > +    uint64_t rnmi_irqvec;
> > +    uint64_t rnmi_excpvec;
> >  };
> >
> >  /*
> > @@ -591,6 +593,7 @@ void riscv_cpu_swap_hypervisor_regs(CPURISCVState
> *env);
> >  int riscv_cpu_claim_interrupts(RISCVCPU *cpu, uint64_t interrupts);
> >  uint64_t riscv_cpu_update_mip(CPURISCVState *env, uint64_t mask,
> >                                uint64_t value);
> > +void riscv_cpu_set_rnmi(RISCVCPU *cpu, uint32_t irq, bool level);
> >  void riscv_cpu_interrupt(CPURISCVState *env);
> >  #define BOOL_TO_MASK(x) (-!!(x)) /* helper for riscv_cpu_update_mip
> value */
> >  void riscv_cpu_set_rdtime_fn(CPURISCVState *env, uint64_t (*fn)(void *=
),
> > diff --git a/target/riscv/cpu_bits.h b/target/riscv/cpu_bits.h
> > index 9e9637263d..17787fd693 100644
> > --- a/target/riscv/cpu_bits.h
> > +++ b/target/riscv/cpu_bits.h
> > @@ -680,6 +680,12 @@ typedef enum {
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
> >      RISCV_EXCP_NONE =3D -1, /* sentinel value */
> > @@ -734,6 +740,9 @@ typedef enum RISCVException {
> >  /* -1 is due to bit zero of hgeip and hgeie being ROZ. */
> >  #define IRQ_LOCAL_GUEST_MAX                (TARGET_LONG_BITS - 1)
> >
> > +/* RNMI causes */
> > +#define RNMI_MAX                           16
> > +
> >  /* mip masks */
> >  #define MIP_USIP                           (1 << IRQ_U_SOFT)
> >  #define MIP_SSIP                           (1 << IRQ_S_SOFT)
> > @@ -972,6 +981,9 @@ typedef enum RISCVException {
> >  #define MHPMEVENT_IDX_MASK                 0xFFFFF
> >  #define MHPMEVENT_SSCOF_RESVD              16
> >
> > +/* RISC-V-specific interrupt pending bits. */
> > +#define CPU_INTERRUPT_RNMI                 CPU_INTERRUPT_TGT_EXT_0
> > +
> >  /* JVT CSR bits */
> >  #define JVT_MODE                           0x3F
> >  #define JVT_BASE                           (~0x3F)
> > diff --git a/target/riscv/cpu_helper.c b/target/riscv/cpu_helper.c
> > index 750c0537ca..e5ffbbbd83 100644
> > --- a/target/riscv/cpu_helper.c
> > +++ b/target/riscv/cpu_helper.c
> > @@ -505,6 +505,18 @@ static int
> riscv_cpu_local_irq_pending(CPURISCVState *env)
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
> > @@ -567,7 +579,9 @@ static int riscv_cpu_local_irq_pending(CPURISCVStat=
e
> *env)
> >
> >  bool riscv_cpu_exec_interrupt(CPUState *cs, int interrupt_request)
> >  {
> > -    if (interrupt_request & CPU_INTERRUPT_HARD) {
> > +    uint32_t mask =3D CPU_INTERRUPT_HARD | CPU_INTERRUPT_RNMI;
> > +
> > +    if (interrupt_request & mask) {
> >          RISCVCPU *cpu =3D RISCV_CPU(cs);
> >          CPURISCVState *env =3D &cpu->env;
> >          int interruptno =3D riscv_cpu_local_irq_pending(env);
> > @@ -699,6 +713,30 @@ void riscv_cpu_set_geilen(CPURISCVState *env,
> target_ulong geilen)
> >      env->geilen =3D geilen;
> >  }
> >
> > +void riscv_cpu_set_rnmi(RISCVCPU *cpu, uint32_t irq, bool level)
> > +{
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
> >  int riscv_cpu_claim_interrupts(RISCVCPU *cpu, uint64_t interrupts)
> >  {
> >      CPURISCVState *env =3D &cpu->env;
> > @@ -1849,6 +1887,7 @@ void riscv_cpu_do_interrupt(CPUState *cs)
> >      bool write_gva =3D false;
> >      bool always_storeamo =3D (env->excp_uw2 & RISCV_UW2_ALWAYS_STORE_A=
MO);
> >      uint64_t s;
> > +    int mode;
> >
> >      /*
> >       * cs->exception is 32-bits wide unlike mcause which is XLEN-bits
> wide
> > @@ -1867,6 +1906,23 @@ void riscv_cpu_do_interrupt(CPUState *cs)
> >      target_ulong mtval2 =3D 0;
> >      int sxlen =3D 0;
> >      int mxlen =3D 0;
> > +    bool nnmi_excep =3D false;
> > +
> > +    if (cpu->cfg.ext_smrnmi && env->rnmip && async) {
> > +        env->mnstatus =3D set_field(env->mnstatus, MNSTATUS_NMIE, fals=
e);
> > +        env->mnstatus =3D set_field(env->mnstatus, MNSTATUS_MNPV,
> > +                                  env->virt_enabled);
> > +        env->mnstatus =3D set_field(env->mnstatus, MNSTATUS_MNPP,
> > +                                  env->priv);
> > +        env->mncause =3D cause | ((target_ulong)1U << (TARGET_LONG_BIT=
S -
> 1));
>
> TARGET_LONG_BITS won't work if running a 32-bit CPU on a 64-bit built
> binary. You will need to look at MXL instead
>
> Alistair
>

Thanks, I've fixed it in the v12 patchset.

Regards,
Frank Chang


>
> > +        env->mnepc =3D env->pc;
> > +        env->pc =3D env->rnmi_irqvec;
> > +
> > +        /* Trapping to M mode, virt is disabled */
> > +        riscv_cpu_set_mode(env, PRV_M, false);
> > +
> > +        return;
> > +    }
> >
> >      if (!async) {
> >          /* set tval to badaddr for traps with address information */
> > @@ -1960,8 +2016,10 @@ void riscv_cpu_do_interrupt(CPUState *cs)
> >                    __func__, env->mhartid, async, cause, env->pc, tval,
> >                    riscv_cpu_get_trap_name(cause, async));
> >
> > -    if (env->priv <=3D PRV_S && cause < 64 &&
> > -        (((deleg >> cause) & 1) || s_injected || vs_injected)) {
> > +    mode =3D env->priv <=3D PRV_S && cause < 64 &&
> > +        (((deleg >> cause) & 1) || s_injected || vs_injected) ? PRV_S =
:
> PRV_M;
> > +
> > +    if (mode =3D=3D PRV_S) {
> >          /* handle the trap in S-mode */
> >          /* save elp status */
> >          if (cpu_get_fcfien(env)) {
> > @@ -2016,6 +2074,14 @@ void riscv_cpu_do_interrupt(CPUState *cs)
> >                    ((async && (env->stvec & 3) =3D=3D 1) ? cause * 4 : =
0);
> >          riscv_cpu_set_mode(env, PRV_S, virt);
> >      } else {
> > +        /*
> > +         * If the hart encounters an exception while executing in M-mo=
de
> > +         * with the mnstatus.NMIE bit clear, the exception is an RNMI
> exception.
> > +         */
> > +        nnmi_excep =3D cpu->cfg.ext_smrnmi &&
> > +                     !get_field(env->mnstatus, MNSTATUS_NMIE) &&
> > +                     !async;
> > +
> >          /* handle the trap in M-mode */
> >          /* save elp status */
> >          if (cpu_get_fcfien(env)) {
> > @@ -2049,8 +2115,17 @@ void riscv_cpu_do_interrupt(CPUState *cs)
> >          env->mtval =3D tval;
> >          env->mtval2 =3D mtval2;
> >          env->mtinst =3D tinst;
> > -        env->pc =3D (env->mtvec >> 2 << 2) +
> > -                  ((async && (env->mtvec & 3) =3D=3D 1) ? cause * 4 : =
0);
> > +
> > +        /*
> > +         * For RNMI exception, program counter is set to the RNMI
> exception
> > +         * trap handler address.
> > +         */
> > +        if (nnmi_excep) {
> > +            env->pc =3D env->rnmi_excpvec;
> > +        } else {
> > +            env->pc =3D (env->mtvec >> 2 << 2) +
> > +                      ((async && (env->mtvec & 3) =3D=3D 1) ? cause * =
4 :
> 0);
> > +        }
> >          riscv_cpu_set_mode(env, PRV_M, virt);
> >      }
> >
> > --
> > 2.34.1
> >
> >
>

--0000000000002dab08062b031fd6
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div dir=3D"ltr">On Mon, Jan 6, 2025 at 9:45=E2=80=AFAM Al=
istair Francis &lt;<a href=3D"mailto:alistair23@gmail.com">alistair23@gmail=
.com</a>&gt; wrote:</div><div class=3D"gmail_quote gmail_quote_container"><=
blockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-l=
eft:1px solid rgb(204,204,204);padding-left:1ex">On Tue, Dec 31, 2024 at 1:=
28=E2=80=AFPM &lt;<a href=3D"mailto:frank.chang@sifive.com" target=3D"_blan=
k">frank.chang@sifive.com</a>&gt; wrote:<br>
&gt;<br>
&gt; From: Tommy Wu &lt;<a href=3D"mailto:tommy.wu@sifive.com" target=3D"_b=
lank">tommy.wu@sifive.com</a>&gt;<br>
&gt;<br>
&gt; Because the RNMI interrupt trap handler address is implementation defi=
ned.<br>
&gt; We add the &#39;rnmi-interrupt-vector&#39; and &#39;rnmi-exception-vec=
tor&#39; as the property<br>
&gt; of the harts. It=E2=80=99s very easy for users to set the address base=
d on their<br>
&gt; expectation. This patch also adds the functionality to handle the RNMI=
 signals.<br>
&gt;<br>
&gt; Signed-off-by: Frank Chang &lt;<a href=3D"mailto:frank.chang@sifive.co=
m" target=3D"_blank">frank.chang@sifive.com</a>&gt;<br>
&gt; Signed-off-by: Tommy Wu &lt;<a href=3D"mailto:tommy.wu@sifive.com" tar=
get=3D"_blank">tommy.wu@sifive.com</a>&gt;<br>
&gt; Reviewed-by: Daniel Henrique Barboza &lt;<a href=3D"mailto:dbarboza@ve=
ntanamicro.com" target=3D"_blank">dbarboza@ventanamicro.com</a>&gt;<br>
&gt; ---<br>
&gt;=C2=A0 hw/riscv/riscv_hart.c=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0| 42 ++++=
++++++++++++-<br>
&gt;=C2=A0 include/hw/riscv/riscv_hart.h |=C2=A0 4 ++<br>
&gt;=C2=A0 target/riscv/cpu.c=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 | 11=
 +++++<br>
&gt;=C2=A0 target/riscv/cpu.h=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 |=C2=
=A0 3 ++<br>
&gt;=C2=A0 target/riscv/cpu_bits.h=C2=A0 =C2=A0 =C2=A0 =C2=A0| 12 +++++<br>
&gt;=C2=A0 target/riscv/cpu_helper.c=C2=A0 =C2=A0 =C2=A0| 85 ++++++++++++++=
++++++++++++++++++---<br>
&gt;=C2=A0 6 files changed, 151 insertions(+), 6 deletions(-)<br>
&gt;<br>
&gt; diff --git a/hw/riscv/riscv_hart.c b/hw/riscv/riscv_hart.c<br>
&gt; index 0df454772f..c2781848ce 100644<br>
&gt; --- a/hw/riscv/riscv_hart.c<br>
&gt; +++ b/hw/riscv/riscv_hart.c<br>
&gt; @@ -26,6 +26,7 @@<br>
&gt;=C2=A0 #include &quot;target/riscv/cpu.h&quot;<br>
&gt;=C2=A0 #include &quot;hw/qdev-properties.h&quot;<br>
&gt;=C2=A0 #include &quot;hw/riscv/riscv_hart.h&quot;<br>
&gt; +#include &quot;qemu/error-report.h&quot;<br>
&gt;<br>
&gt;=C2=A0 static const Property riscv_harts_props[] =3D {<br>
&gt;=C2=A0 =C2=A0 =C2=A0 DEFINE_PROP_UINT32(&quot;num-harts&quot;, RISCVHar=
tArrayState, num_harts, 1),<br>
&gt; @@ -33,7 +34,23 @@ static const Property riscv_harts_props[] =3D {<br>
&gt;=C2=A0 =C2=A0 =C2=A0 DEFINE_PROP_STRING(&quot;cpu-type&quot;, RISCVHart=
ArrayState, cpu_type),<br>
&gt;=C2=A0 =C2=A0 =C2=A0 DEFINE_PROP_UINT64(&quot;resetvec&quot;, RISCVHart=
ArrayState, resetvec,<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0DEFAULT_RSTVEC),<br>
&gt; -=C2=A0 =C2=A0 DEFINE_PROP_END_OF_LIST(),<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 /*<br>
&gt; +=C2=A0 =C2=A0 =C2=A0* Smrnmi implementation-defined interrupt and exc=
eption trap handlers.<br>
&gt; +=C2=A0 =C2=A0 =C2=A0*<br>
&gt; +=C2=A0 =C2=A0 =C2=A0* When an RNMI interrupt is detected, the hart th=
en enters M-mode and<br>
&gt; +=C2=A0 =C2=A0 =C2=A0* jumps to the address defined by &quot;rnmi-inte=
rrupt-vector&quot;.<br>
&gt; +=C2=A0 =C2=A0 =C2=A0*<br>
&gt; +=C2=A0 =C2=A0 =C2=A0* When the hart encounters an exception while exe=
cuting in M-mode with<br>
&gt; +=C2=A0 =C2=A0 =C2=A0* the mnstatus.NMIE bit clear, the hart then jump=
s to the address<br>
&gt; +=C2=A0 =C2=A0 =C2=A0* defined by &quot;rnmi-exception-vector&quot;.<b=
r>
&gt; +=C2=A0 =C2=A0 =C2=A0*/<br>
&gt; +=C2=A0 =C2=A0 DEFINE_PROP_ARRAY(&quot;rnmi-interrupt-vector&quot;, RI=
SCVHartArrayState,<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 num_rnmi_irqvec, rnmi_irqvec, qdev_prop_uint64,<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 uint64_t),<br>
&gt; +=C2=A0 =C2=A0 DEFINE_PROP_ARRAY(&quot;rnmi-exception-vector&quot;, RI=
SCVHartArrayState,<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 num_rnmi_excpvec, rnmi_excpvec, qdev_prop_uint64,<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 uint64_t),<br>
&gt;=C2=A0 };<br>
&gt;<br>
&gt;=C2=A0 static void riscv_harts_cpu_reset(void *opaque)<br>
&gt; @@ -47,6 +64,29 @@ static bool riscv_hart_realize(RISCVHartArrayState =
*s, int idx,<br>
&gt;=C2=A0 {<br>
&gt;=C2=A0 =C2=A0 =C2=A0 object_initialize_child(OBJECT(s), &quot;harts[*]&=
quot;, &amp;s-&gt;harts[idx], cpu_type);<br>
&gt;=C2=A0 =C2=A0 =C2=A0 qdev_prop_set_uint64(DEVICE(&amp;s-&gt;harts[idx])=
, &quot;resetvec&quot;, s-&gt;resetvec);<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 if (s-&gt;harts[idx].cfg.ext_smrnmi) {<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 if (idx &lt; s-&gt;num_rnmi_irqvec) {<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 qdev_prop_set_uint64(DEVICE=
(&amp;s-&gt;harts[idx]),<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0&quot;rnmi-interrupt-vecto=
r&quot;, s-&gt;rnmi_irqvec[idx]);<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 }<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 if (idx &lt; s-&gt;num_rnmi_excpvec) {<br=
>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 qdev_prop_set_uint64(DEVICE=
(&amp;s-&gt;harts[idx]),<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0&quot;rnmi-exception-vecto=
r&quot;, s-&gt;rnmi_excpvec[idx]);<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 }<br>
&gt; +=C2=A0 =C2=A0 } else {<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 if (s-&gt;num_rnmi_irqvec &gt; 0) {<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 warn_report_once(&quot;rnmi=
-interrupt-vector property is ignored &quot;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0&quot;because Smrnmi extension is not en=
abled.&quot;);<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 }<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 if (s-&gt;num_rnmi_excpvec &gt; 0) {<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 warn_report_once(&quot;rnmi=
-exception-vector property is ignored &quot;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0&quot;because Smrnmi extension is not en=
abled.&quot;);<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 }<br>
&gt; +=C2=A0 =C2=A0 }<br>
&gt; +<br>
&gt;=C2=A0 =C2=A0 =C2=A0 s-&gt;harts[idx].env.mhartid =3D s-&gt;hartid_base=
 + idx;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 qemu_register_reset(riscv_harts_cpu_reset, &amp;s-=
&gt;harts[idx]);<br>
&gt;=C2=A0 =C2=A0 =C2=A0 return qdev_realize(DEVICE(&amp;s-&gt;harts[idx]),=
 NULL, errp);<br>
&gt; diff --git a/include/hw/riscv/riscv_hart.h b/include/hw/riscv/riscv_ha=
rt.h<br>
&gt; index 912b4a2682..a6ed73a195 100644<br>
&gt; --- a/include/hw/riscv/riscv_hart.h<br>
&gt; +++ b/include/hw/riscv/riscv_hart.h<br>
&gt; @@ -38,6 +38,10 @@ struct RISCVHartArrayState {<br>
&gt;=C2=A0 =C2=A0 =C2=A0 uint32_t hartid_base;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 char *cpu_type;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 uint64_t resetvec;<br>
&gt; +=C2=A0 =C2=A0 uint32_t num_rnmi_irqvec;<br>
&gt; +=C2=A0 =C2=A0 uint64_t *rnmi_irqvec;<br>
&gt; +=C2=A0 =C2=A0 uint32_t num_rnmi_excpvec;<br>
&gt; +=C2=A0 =C2=A0 uint64_t *rnmi_excpvec;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 RISCVCPU *harts;<br>
&gt;=C2=A0 };<br>
&gt;<br>
&gt; diff --git a/target/riscv/cpu.c b/target/riscv/cpu.c<br>
&gt; index c5d5c2f7df..6c46a2f076 100644<br>
&gt; --- a/target/riscv/cpu.c<br>
&gt; +++ b/target/riscv/cpu.c<br>
&gt; @@ -1412,6 +1412,11 @@ static void riscv_cpu_set_irq(void *opaque, int=
 irq, int level)<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 g_assert_not_reached();<br>
&gt;=C2=A0 =C2=A0 =C2=A0 }<br>
&gt;=C2=A0 }<br>
&gt; +<br>
&gt; +static void riscv_cpu_set_nmi(void *opaque, int irq, int level)<br>
&gt; +{<br>
&gt; +=C2=A0 =C2=A0 riscv_cpu_set_rnmi(RISCV_CPU(opaque), irq, level);<br>
&gt; +}<br>
&gt;=C2=A0 #endif /* CONFIG_USER_ONLY */<br>
&gt;<br>
&gt;=C2=A0 static bool riscv_cpu_is_dynamic(Object *cpu_obj)<br>
&gt; @@ -1435,6 +1440,8 @@ static void riscv_cpu_init(Object *obj)<br>
&gt;=C2=A0 #ifndef CONFIG_USER_ONLY<br>
&gt;=C2=A0 =C2=A0 =C2=A0 qdev_init_gpio_in(DEVICE(obj), riscv_cpu_set_irq,<=
br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 IRQ_LOCAL_MAX + IRQ_LOCAL_GUEST_MAX);<br>
&gt; +=C2=A0 =C2=A0 qdev_init_gpio_in_named(DEVICE(cpu), riscv_cpu_set_nmi,=
<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 &quot;riscv.cpu.rnmi&quot;, RNMI_MAX);<br>
&gt;=C2=A0 #endif /* CONFIG_USER_ONLY */<br>
&gt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 general_user_opts =3D g_hash_table_new(g_str_hash,=
 g_str_equal);<br>
&gt; @@ -2789,6 +2796,10 @@ static const Property riscv_cpu_properties[] =
=3D {<br>
&gt;<br>
&gt;=C2=A0 #ifndef CONFIG_USER_ONLY<br>
&gt;=C2=A0 =C2=A0 =C2=A0 DEFINE_PROP_UINT64(&quot;resetvec&quot;, RISCVCPU,=
 env.resetvec, DEFAULT_RSTVEC),<br>
&gt; +=C2=A0 =C2=A0 DEFINE_PROP_UINT64(&quot;rnmi-interrupt-vector&quot;, R=
ISCVCPU, env.rnmi_irqvec,<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0DEFAULT_RNMI_IRQVEC),<br>
&gt; +=C2=A0 =C2=A0 DEFINE_PROP_UINT64(&quot;rnmi-exception-vector&quot;, R=
ISCVCPU, env.rnmi_excpvec,<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0DEFAULT_RNMI_EXCPVEC),<br>
&gt;=C2=A0 #endif<br>
&gt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 DEFINE_PROP_BOOL(&quot;short-isa-string&quot;, RIS=
CVCPU, cfg.short_isa_string, false),<br>
&gt; diff --git a/target/riscv/cpu.h b/target/riscv/cpu.h<br>
&gt; index a2cb471b3c..8dc5b4d002 100644<br>
&gt; --- a/target/riscv/cpu.h<br>
&gt; +++ b/target/riscv/cpu.h<br>
&gt; @@ -493,6 +493,8 @@ struct CPUArchState {<br>
&gt;=C2=A0 =C2=A0 =C2=A0 target_ulong mncause; /* mncause without bit XLEN-=
1 set to 1 */<br>
&gt;=C2=A0 =C2=A0 =C2=A0 target_ulong mnstatus;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 target_ulong rnmip;<br>
&gt; +=C2=A0 =C2=A0 uint64_t rnmi_irqvec;<br>
&gt; +=C2=A0 =C2=A0 uint64_t rnmi_excpvec;<br>
&gt;=C2=A0 };<br>
&gt;<br>
&gt;=C2=A0 /*<br>
&gt; @@ -591,6 +593,7 @@ void riscv_cpu_swap_hypervisor_regs(CPURISCVState =
*env);<br>
&gt;=C2=A0 int riscv_cpu_claim_interrupts(RISCVCPU *cpu, uint64_t interrupt=
s);<br>
&gt;=C2=A0 uint64_t riscv_cpu_update_mip(CPURISCVState *env, uint64_t mask,=
<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 uint64_t value);<br>
&gt; +void riscv_cpu_set_rnmi(RISCVCPU *cpu, uint32_t irq, bool level);<br>
&gt;=C2=A0 void riscv_cpu_interrupt(CPURISCVState *env);<br>
&gt;=C2=A0 #define BOOL_TO_MASK(x) (-!!(x)) /* helper for riscv_cpu_update_=
mip value */<br>
&gt;=C2=A0 void riscv_cpu_set_rdtime_fn(CPURISCVState *env, uint64_t (*fn)(=
void *),<br>
&gt; diff --git a/target/riscv/cpu_bits.h b/target/riscv/cpu_bits.h<br>
&gt; index 9e9637263d..17787fd693 100644<br>
&gt; --- a/target/riscv/cpu_bits.h<br>
&gt; +++ b/target/riscv/cpu_bits.h<br>
&gt; @@ -680,6 +680,12 @@ typedef enum {<br>
&gt;=C2=A0 /* Default Reset Vector address */<br>
&gt;=C2=A0 #define DEFAULT_RSTVEC=C2=A0 =C2=A0 =C2=A0 0x1000<br>
&gt;<br>
&gt; +/* Default RNMI Interrupt Vector address */<br>
&gt; +#define DEFAULT_RNMI_IRQVEC=C2=A0 =C2=A0 =C2=A00x0<br>
&gt; +<br>
&gt; +/* Default RNMI Exception Vector address */<br>
&gt; +#define DEFAULT_RNMI_EXCPVEC=C2=A0 =C2=A0 0x0<br>
&gt; +<br>
&gt;=C2=A0 /* Exception causes */<br>
&gt;=C2=A0 typedef enum RISCVException {<br>
&gt;=C2=A0 =C2=A0 =C2=A0 RISCV_EXCP_NONE =3D -1, /* sentinel value */<br>
&gt; @@ -734,6 +740,9 @@ typedef enum RISCVException {<br>
&gt;=C2=A0 /* -1 is due to bit zero of hgeip and hgeie being ROZ. */<br>
&gt;=C2=A0 #define IRQ_LOCAL_GUEST_MAX=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 (TARGET_LONG_BITS - 1)<br>
&gt;<br>
&gt; +/* RNMI causes */<br>
&gt; +#define RNMI_MAX=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A016<br>
&gt; +<br>
&gt;=C2=A0 /* mip masks */<br>
&gt;=C2=A0 #define MIP_USIP=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0(1 &lt;&lt; IRQ_U_SOFT)<br=
>
&gt;=C2=A0 #define MIP_SSIP=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0(1 &lt;&lt; IRQ_S_SOFT)<br=
>
&gt; @@ -972,6 +981,9 @@ typedef enum RISCVException {<br>
&gt;=C2=A0 #define MHPMEVENT_IDX_MASK=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A00xFFFFF<br>
&gt;=C2=A0 #define MHPMEVENT_SSCOF_RESVD=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 16<br>
&gt;<br>
&gt; +/* RISC-V-specific interrupt pending bits. */<br>
&gt; +#define CPU_INTERRUPT_RNMI=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0CPU_INTERRUPT_TGT_EXT_0<br>
&gt; +<br>
&gt;=C2=A0 /* JVT CSR bits */<br>
&gt;=C2=A0 #define JVT_MODE=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A00x3F<br>
&gt;=C2=A0 #define JVT_BASE=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0(~0x3F)<br>
&gt; diff --git a/target/riscv/cpu_helper.c b/target/riscv/cpu_helper.c<br>
&gt; index 750c0537ca..e5ffbbbd83 100644<br>
&gt; --- a/target/riscv/cpu_helper.c<br>
&gt; +++ b/target/riscv/cpu_helper.c<br>
&gt; @@ -505,6 +505,18 @@ static int riscv_cpu_local_irq_pending(CPURISCVSt=
ate *env)<br>
&gt;=C2=A0 =C2=A0 =C2=A0 uint64_t vsbits, irq_delegated;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 int virq;<br>
&gt;<br>
&gt; +=C2=A0 =C2=A0 /* Priority: RNMI &gt; Other interrupt. */<br>
&gt; +=C2=A0 =C2=A0 if (riscv_cpu_cfg(env)-&gt;ext_smrnmi) {<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 /* If mnstatus.NMIE =3D=3D 0, all interru=
pts are disabled. */<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 if (!get_field(env-&gt;mnstatus, MNSTATUS=
_NMIE)) {<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 return RISCV_EXCP_NONE;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 }<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 if (env-&gt;rnmip) {<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 return ctz64(env-&gt;rnmip)=
; /* since non-zero */<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 }<br>
&gt; +=C2=A0 =C2=A0 }<br>
&gt; +<br>
&gt;=C2=A0 =C2=A0 =C2=A0 /* Determine interrupt enable state of all privile=
ge modes */<br>
&gt;=C2=A0 =C2=A0 =C2=A0 if (env-&gt;virt_enabled) {<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 mie =3D 1;<br>
&gt; @@ -567,7 +579,9 @@ static int riscv_cpu_local_irq_pending(CPURISCVSta=
te *env)<br>
&gt;<br>
&gt;=C2=A0 bool riscv_cpu_exec_interrupt(CPUState *cs, int interrupt_reques=
t)<br>
&gt;=C2=A0 {<br>
&gt; -=C2=A0 =C2=A0 if (interrupt_request &amp; CPU_INTERRUPT_HARD) {<br>
&gt; +=C2=A0 =C2=A0 uint32_t mask =3D CPU_INTERRUPT_HARD | CPU_INTERRUPT_RN=
MI;<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 if (interrupt_request &amp; mask) {<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 RISCVCPU *cpu =3D RISCV_CPU(cs);<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 CPURISCVState *env =3D &amp;cpu-&gt;=
env;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 int interruptno =3D riscv_cpu_local_=
irq_pending(env);<br>
&gt; @@ -699,6 +713,30 @@ void riscv_cpu_set_geilen(CPURISCVState *env, tar=
get_ulong geilen)<br>
&gt;=C2=A0 =C2=A0 =C2=A0 env-&gt;geilen =3D geilen;<br>
&gt;=C2=A0 }<br>
&gt;<br>
&gt; +void riscv_cpu_set_rnmi(RISCVCPU *cpu, uint32_t irq, bool level)<br>
&gt; +{<br>
&gt; +=C2=A0 =C2=A0 CPURISCVState *env =3D &amp;cpu-&gt;env;<br>
&gt; +=C2=A0 =C2=A0 CPUState *cs =3D CPU(cpu);<br>
&gt; +=C2=A0 =C2=A0 bool release_lock =3D false;<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 if (!bql_locked()) {<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 release_lock =3D true;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 bql_lock();<br>
&gt; +=C2=A0 =C2=A0 }<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 if (level) {<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 env-&gt;rnmip |=3D 1 &lt;&lt; irq;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 cpu_interrupt(cs, CPU_INTERRUPT_RNMI);<br=
>
&gt; +=C2=A0 =C2=A0 } else {<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 env-&gt;rnmip &amp;=3D ~(1 &lt;&lt; irq);=
<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 cpu_reset_interrupt(cs, CPU_INTERRUPT_RNM=
I);<br>
&gt; +=C2=A0 =C2=A0 }<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 if (release_lock) {<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 bql_unlock();<br>
&gt; +=C2=A0 =C2=A0 }<br>
&gt; +}<br>
&gt; +<br>
&gt;=C2=A0 int riscv_cpu_claim_interrupts(RISCVCPU *cpu, uint64_t interrupt=
s)<br>
&gt;=C2=A0 {<br>
&gt;=C2=A0 =C2=A0 =C2=A0 CPURISCVState *env =3D &amp;cpu-&gt;env;<br>
&gt; @@ -1849,6 +1887,7 @@ void riscv_cpu_do_interrupt(CPUState *cs)<br>
&gt;=C2=A0 =C2=A0 =C2=A0 bool write_gva =3D false;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 bool always_storeamo =3D (env-&gt;excp_uw2 &amp; R=
ISCV_UW2_ALWAYS_STORE_AMO);<br>
&gt;=C2=A0 =C2=A0 =C2=A0 uint64_t s;<br>
&gt; +=C2=A0 =C2=A0 int mode;<br>
&gt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 /*<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0* cs-&gt;exception is 32-bits wide unlike mc=
ause which is XLEN-bits wide<br>
&gt; @@ -1867,6 +1906,23 @@ void riscv_cpu_do_interrupt(CPUState *cs)<br>
&gt;=C2=A0 =C2=A0 =C2=A0 target_ulong mtval2 =3D 0;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 int sxlen =3D 0;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 int mxlen =3D 0;<br>
&gt; +=C2=A0 =C2=A0 bool nnmi_excep =3D false;<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 if (cpu-&gt;cfg.ext_smrnmi &amp;&amp; env-&gt;rnmip &am=
p;&amp; async) {<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 env-&gt;mnstatus =3D set_field(env-&gt;mn=
status, MNSTATUS_NMIE, false);<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 env-&gt;mnstatus =3D set_field(env-&gt;mn=
status, MNSTATUS_MNPV,<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 env-&gt;virt_enabled);<br=
>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 env-&gt;mnstatus =3D set_field(env-&gt;mn=
status, MNSTATUS_MNPP,<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 env-&gt;priv);<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 env-&gt;mncause =3D cause | ((target_ulon=
g)1U &lt;&lt; (TARGET_LONG_BITS - 1));<br>
<br>
TARGET_LONG_BITS won&#39;t work if running a 32-bit CPU on a 64-bit built<b=
r>
binary. You will need to look at MXL instead<br>
<br>
Alistair<br></blockquote><div><br></div><div>Thanks, I&#39;ve fixed it in t=
he v12 patchset.</div><div><br></div><div>Regards,</div><div>Frank Chang</d=
iv><div>=C2=A0</div><blockquote class=3D"gmail_quote" style=3D"margin:0px 0=
px 0px 0.8ex;border-left:1px solid rgb(204,204,204);padding-left:1ex">
<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 env-&gt;mnepc =3D env-&gt;pc;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 env-&gt;pc =3D env-&gt;rnmi_irqvec;<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 /* Trapping to M mode, virt is disabled *=
/<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 riscv_cpu_set_mode(env, PRV_M, false);<br=
>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 return;<br>
&gt; +=C2=A0 =C2=A0 }<br>
&gt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 if (!async) {<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 /* set tval to badaddr for traps wit=
h address information */<br>
&gt; @@ -1960,8 +2016,10 @@ void riscv_cpu_do_interrupt(CPUState *cs)<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 _=
_func__, env-&gt;mhartid, async, cause, env-&gt;pc, tval,<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 r=
iscv_cpu_get_trap_name(cause, async));<br>
&gt;<br>
&gt; -=C2=A0 =C2=A0 if (env-&gt;priv &lt;=3D PRV_S &amp;&amp; cause &lt; 64=
 &amp;&amp;<br>
&gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 (((deleg &gt;&gt; cause) &amp; 1) || s_in=
jected || vs_injected)) {<br>
&gt; +=C2=A0 =C2=A0 mode =3D env-&gt;priv &lt;=3D PRV_S &amp;&amp; cause &l=
t; 64 &amp;&amp;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 (((deleg &gt;&gt; cause) &amp; 1) || s_in=
jected || vs_injected) ? PRV_S : PRV_M;<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 if (mode =3D=3D PRV_S) {<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 /* handle the trap in S-mode */<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 /* save elp status */<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 if (cpu_get_fcfien(env)) {<br>
&gt; @@ -2016,6 +2074,14 @@ void riscv_cpu_do_interrupt(CPUState *cs)<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 (=
(async &amp;&amp; (env-&gt;stvec &amp; 3) =3D=3D 1) ? cause * 4 : 0);<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 riscv_cpu_set_mode(env, PRV_S, virt)=
;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 } else {<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 /*<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0* If the hart encounters an excepti=
on while executing in M-mode<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0* with the mnstatus.NMIE bit clear,=
 the exception is an RNMI exception.<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0*/<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 nnmi_excep =3D cpu-&gt;cfg.ext_smrnmi &am=
p;&amp;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0!get_field(env-&gt;mnstatus, MNSTATUS_NMIE) &amp;&amp;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0!async;<br>
&gt; +<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 /* handle the trap in M-mode */<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 /* save elp status */<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 if (cpu_get_fcfien(env)) {<br>
&gt; @@ -2049,8 +2115,17 @@ void riscv_cpu_do_interrupt(CPUState *cs)<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 env-&gt;mtval =3D tval;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 env-&gt;mtval2 =3D mtval2;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 env-&gt;mtinst =3D tinst;<br>
&gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 env-&gt;pc =3D (env-&gt;mtvec &gt;&gt; 2 =
&lt;&lt; 2) +<br>
&gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 ((asyn=
c &amp;&amp; (env-&gt;mtvec &amp; 3) =3D=3D 1) ? cause * 4 : 0);<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 /*<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0* For RNMI exception, program count=
er is set to the RNMI exception<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0* trap handler address.<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0*/<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 if (nnmi_excep) {<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 env-&gt;pc =3D env-&gt;rnmi=
_excpvec;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 } else {<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 env-&gt;pc =3D (env-&gt;mtv=
ec &gt;&gt; 2 &lt;&lt; 2) +<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 ((async &amp;&amp; (env-&gt;mtvec &amp; 3) =3D=3D 1) ? cause * 4 : =
0);<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 }<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 riscv_cpu_set_mode(env, PRV_M, virt)=
;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 }<br>
&gt;<br>
&gt; --<br>
&gt; 2.34.1<br>
&gt;<br>
&gt;<br>
</blockquote></div></div>

--0000000000002dab08062b031fd6--

