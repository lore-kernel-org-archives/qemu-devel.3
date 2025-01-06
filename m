Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EF6CBE77197
	for <qemu-devel@archiver.kernel.org>; Mon,  6 Jan 2025 01:45:56 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tUcBJ-0003Ux-DE; Sun, 05 Jan 2025 20:45:25 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1tUcBH-0003TC-Fg; Sun, 05 Jan 2025 20:45:23 -0500
Received: from mail-vk1-xa35.google.com ([2607:f8b0:4864:20::a35])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1tUcBE-0004X8-P5; Sun, 05 Jan 2025 20:45:22 -0500
Received: by mail-vk1-xa35.google.com with SMTP id
 71dfb90a1353d-5160f80e652so3866587e0c.2; 
 Sun, 05 Jan 2025 17:45:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1736127919; x=1736732719; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=KT4XzKPDhqVH59dOwT6QfNCc1OAzsK3GKgF/7fr2oPQ=;
 b=NwLN/fHfyeh7KaNyVDcvfWI00jLg+3xj8kYT4PbkmZLl8ozoop4B5kclbnN/Nihgrx
 jYL4WIUueFoeua/cQntk6SDDVyHv0C/MenBVfyxTsIu17N+WizJpfRdbsX+qmpCrE78f
 9Sl5myzx4Djac4YuMMmT5JweqXfH+ZR31pqTx2lOiNQ4Gn5Vf6PxKhUisFR1IYLsf/AR
 jBPbO/Lon1gg2z+CZoz7MhLNuGBoe39RmtDHF9wH/EBKVLaHcrGEAleAGNj1eYthtOxY
 +gl6NIHWuS+qzshzaeifxcAnSER3Vf4kSAfvrntRM96O+gRuCrxwcbAY/N2mfYovnxK4
 qwHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1736127919; x=1736732719;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=KT4XzKPDhqVH59dOwT6QfNCc1OAzsK3GKgF/7fr2oPQ=;
 b=LInM/4pjWx6ItMn2nTRrvIJaDJpIdWnLXQUFp5F306Dy4nSHC7rsE7bIOZJfdapGmE
 rtZaiXb/Pmdio0RFy70u/ovP6vn1SzMTnoqruCp7vb0nYwSkzQVWshzg+c90ht96UXTs
 GgOGr8DaRSpn2LJnNXzo2KIU8SiiBOou3tDp0IYnTCZgEGma1UlAOqpFfZV/Tvfg9m+m
 C92FCLhmdtEoMRwAbg/YTXEEgUql0yYQ4PTxBsc68ItuSw9UQsz7csBai9KL8n+pU/Ih
 7FI+w961zXdVnOH4Tb24f1wJXEsh742BHavP0rz+xlbj8x2EO7i1sdy097Inxv/KxhgM
 aNkA==
X-Forwarded-Encrypted: i=1;
 AJvYcCW7UfMm+8TNYukjD85jyjvB3rzJ1tLFdYYxK6nGm/sOU+QJlcFoKXa6C+RFyVXBDz33tl0EKGfrDcSv@nongnu.org
X-Gm-Message-State: AOJu0YzO8oGAsNkSXOQFHTe0liN4IsO7MqQaGS50YaheDDBpF+U/HsYM
 Bm9o4U/0EWdPM230TWuQEuGuCJ+Q9yON0tP6ZXfDQhVkpbCTn4Rl34kWY6T41rsAgGqcKT03Xkw
 sIthJOfZC67FqxBcOfk+PjGP20aY=
X-Gm-Gg: ASbGncsKZWfA2iNNW25vR+Zn3EBvtEvY8tigiqwCEuEJd0Ds6jOBCxfZuKUtXqWZE7p
 hyBPKK+XeYK8wT4eYv7DacRen/7AUvTeiza66CvoR9oUnHXadF1Zw2ZOTjVVVKbXzbJ4=
X-Google-Smtp-Source: AGHT+IFK0WK6nzxTQ3o9Bix1l40QDvOjtrh/S1yUgFvY0FtEpktPhOa4l4k/f6iuB+TXKtvrkD+mm9pcuxiNPihxBtg=
X-Received: by 2002:a05:6102:32cc:b0:4af:4974:a489 with SMTP id
 ada2fe7eead31-4b2cc46245cmr44260739137.20.1736127919179; Sun, 05 Jan 2025
 17:45:19 -0800 (PST)
MIME-Version: 1.0
References: <20241231032654.133039-1-frank.chang@sifive.com>
 <20241231032654.133039-4-frank.chang@sifive.com>
In-Reply-To: <20241231032654.133039-4-frank.chang@sifive.com>
From: Alistair Francis <alistair23@gmail.com>
Date: Mon, 6 Jan 2025 11:44:53 +1000
Message-ID: <CAKmqyKOgY1SgL=iFD7iE74hMuQzqYNhwpdBBp_Lg02QGTFc7LA@mail.gmail.com>
Subject: Re: [PATCH v11 3/6] target/riscv: Handle Smrnmi interrupt and
 exception
To: frank.chang@sifive.com
Cc: qemu-devel@nongnu.org, qemu-riscv@nongnu.org, 
 Palmer Dabbelt <palmer@dabbelt.com>,
 Alistair Francis <alistair.francis@wdc.com>, 
 Bin Meng <bmeng.cn@gmail.com>, Weiwei Li <liwei1518@gmail.com>, 
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>,
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>, Tommy Wu <tommy.wu@sifive.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::a35;
 envelope-from=alistair23@gmail.com; helo=mail-vk1-xa35.google.com
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

On Tue, Dec 31, 2024 at 1:28=E2=80=AFPM <frank.chang@sifive.com> wrote:
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
> Reviewed-by: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
> ---
>  hw/riscv/riscv_hart.c         | 42 ++++++++++++++++-
>  include/hw/riscv/riscv_hart.h |  4 ++
>  target/riscv/cpu.c            | 11 +++++
>  target/riscv/cpu.h            |  3 ++
>  target/riscv/cpu_bits.h       | 12 +++++
>  target/riscv/cpu_helper.c     | 85 ++++++++++++++++++++++++++++++++---
>  6 files changed, 151 insertions(+), 6 deletions(-)
>
> diff --git a/hw/riscv/riscv_hart.c b/hw/riscv/riscv_hart.c
> index 0df454772f..c2781848ce 100644
> --- a/hw/riscv/riscv_hart.c
> +++ b/hw/riscv/riscv_hart.c
> @@ -26,6 +26,7 @@
>  #include "target/riscv/cpu.h"
>  #include "hw/qdev-properties.h"
>  #include "hw/riscv/riscv_hart.h"
> +#include "qemu/error-report.h"
>
>  static const Property riscv_harts_props[] =3D {
>      DEFINE_PROP_UINT32("num-harts", RISCVHartArrayState, num_harts, 1),
> @@ -33,7 +34,23 @@ static const Property riscv_harts_props[] =3D {
>      DEFINE_PROP_STRING("cpu-type", RISCVHartArrayState, cpu_type),
>      DEFINE_PROP_UINT64("resetvec", RISCVHartArrayState, resetvec,
>                         DEFAULT_RSTVEC),
> -    DEFINE_PROP_END_OF_LIST(),
> +
> +    /*
> +     * Smrnmi implementation-defined interrupt and exception trap handle=
rs.
> +     *
> +     * When an RNMI interrupt is detected, the hart then enters M-mode a=
nd
> +     * jumps to the address defined by "rnmi-interrupt-vector".
> +     *
> +     * When the hart encounters an exception while executing in M-mode w=
ith
> +     * the mnstatus.NMIE bit clear, the hart then jumps to the address
> +     * defined by "rnmi-exception-vector".
> +     */
> +    DEFINE_PROP_ARRAY("rnmi-interrupt-vector", RISCVHartArrayState,
> +                      num_rnmi_irqvec, rnmi_irqvec, qdev_prop_uint64,
> +                      uint64_t),
> +    DEFINE_PROP_ARRAY("rnmi-exception-vector", RISCVHartArrayState,
> +                      num_rnmi_excpvec, rnmi_excpvec, qdev_prop_uint64,
> +                      uint64_t),
>  };
>
>  static void riscv_harts_cpu_reset(void *opaque)
> @@ -47,6 +64,29 @@ static bool riscv_hart_realize(RISCVHartArrayState *s,=
 int idx,
>  {
>      object_initialize_child(OBJECT(s), "harts[*]", &s->harts[idx], cpu_t=
ype);
>      qdev_prop_set_uint64(DEVICE(&s->harts[idx]), "resetvec", s->resetvec=
);
> +
> +    if (s->harts[idx].cfg.ext_smrnmi) {
> +        if (idx < s->num_rnmi_irqvec) {
> +            qdev_prop_set_uint64(DEVICE(&s->harts[idx]),
> +                                 "rnmi-interrupt-vector", s->rnmi_irqvec=
[idx]);
> +        }
> +
> +        if (idx < s->num_rnmi_excpvec) {
> +            qdev_prop_set_uint64(DEVICE(&s->harts[idx]),
> +                                 "rnmi-exception-vector", s->rnmi_excpve=
c[idx]);
> +        }
> +    } else {
> +        if (s->num_rnmi_irqvec > 0) {
> +            warn_report_once("rnmi-interrupt-vector property is ignored =
"
> +                             "because Smrnmi extension is not enabled.")=
;
> +        }
> +
> +        if (s->num_rnmi_excpvec > 0) {
> +            warn_report_once("rnmi-exception-vector property is ignored =
"
> +                             "because Smrnmi extension is not enabled.")=
;
> +        }
> +    }
> +
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
> index c5d5c2f7df..6c46a2f076 100644
> --- a/target/riscv/cpu.c
> +++ b/target/riscv/cpu.c
> @@ -1412,6 +1412,11 @@ static void riscv_cpu_set_irq(void *opaque, int ir=
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
> @@ -1435,6 +1440,8 @@ static void riscv_cpu_init(Object *obj)
>  #ifndef CONFIG_USER_ONLY
>      qdev_init_gpio_in(DEVICE(obj), riscv_cpu_set_irq,
>                        IRQ_LOCAL_MAX + IRQ_LOCAL_GUEST_MAX);
> +    qdev_init_gpio_in_named(DEVICE(cpu), riscv_cpu_set_nmi,
> +                            "riscv.cpu.rnmi", RNMI_MAX);
>  #endif /* CONFIG_USER_ONLY */
>
>      general_user_opts =3D g_hash_table_new(g_str_hash, g_str_equal);
> @@ -2789,6 +2796,10 @@ static const Property riscv_cpu_properties[] =3D {
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
> index a2cb471b3c..8dc5b4d002 100644
> --- a/target/riscv/cpu.h
> +++ b/target/riscv/cpu.h
> @@ -493,6 +493,8 @@ struct CPUArchState {
>      target_ulong mncause; /* mncause without bit XLEN-1 set to 1 */
>      target_ulong mnstatus;
>      target_ulong rnmip;
> +    uint64_t rnmi_irqvec;
> +    uint64_t rnmi_excpvec;
>  };
>
>  /*
> @@ -591,6 +593,7 @@ void riscv_cpu_swap_hypervisor_regs(CPURISCVState *en=
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
> index 9e9637263d..17787fd693 100644
> --- a/target/riscv/cpu_bits.h
> +++ b/target/riscv/cpu_bits.h
> @@ -680,6 +680,12 @@ typedef enum {
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
> @@ -734,6 +740,9 @@ typedef enum RISCVException {
>  /* -1 is due to bit zero of hgeip and hgeie being ROZ. */
>  #define IRQ_LOCAL_GUEST_MAX                (TARGET_LONG_BITS - 1)
>
> +/* RNMI causes */
> +#define RNMI_MAX                           16
> +
>  /* mip masks */
>  #define MIP_USIP                           (1 << IRQ_U_SOFT)
>  #define MIP_SSIP                           (1 << IRQ_S_SOFT)
> @@ -972,6 +981,9 @@ typedef enum RISCVException {
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
> index 750c0537ca..e5ffbbbd83 100644
> --- a/target/riscv/cpu_helper.c
> +++ b/target/riscv/cpu_helper.c
> @@ -505,6 +505,18 @@ static int riscv_cpu_local_irq_pending(CPURISCVState=
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
> @@ -567,7 +579,9 @@ static int riscv_cpu_local_irq_pending(CPURISCVState =
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
> @@ -699,6 +713,30 @@ void riscv_cpu_set_geilen(CPURISCVState *env, target=
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
> @@ -1849,6 +1887,7 @@ void riscv_cpu_do_interrupt(CPUState *cs)
>      bool write_gva =3D false;
>      bool always_storeamo =3D (env->excp_uw2 & RISCV_UW2_ALWAYS_STORE_AMO=
);
>      uint64_t s;
> +    int mode;
>
>      /*
>       * cs->exception is 32-bits wide unlike mcause which is XLEN-bits wi=
de
> @@ -1867,6 +1906,23 @@ void riscv_cpu_do_interrupt(CPUState *cs)
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

TARGET_LONG_BITS won't work if running a 32-bit CPU on a 64-bit built
binary. You will need to look at MXL instead

Alistair

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
> @@ -1960,8 +2016,10 @@ void riscv_cpu_do_interrupt(CPUState *cs)
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
>          /* save elp status */
>          if (cpu_get_fcfien(env)) {
> @@ -2016,6 +2074,14 @@ void riscv_cpu_do_interrupt(CPUState *cs)
>                    ((async && (env->stvec & 3) =3D=3D 1) ? cause * 4 : 0)=
;
>          riscv_cpu_set_mode(env, PRV_S, virt);
>      } else {
> +        /*
> +         * If the hart encounters an exception while executing in M-mode
> +         * with the mnstatus.NMIE bit clear, the exception is an RNMI ex=
ception.
> +         */
> +        nnmi_excep =3D cpu->cfg.ext_smrnmi &&
> +                     !get_field(env->mnstatus, MNSTATUS_NMIE) &&
> +                     !async;
> +
>          /* handle the trap in M-mode */
>          /* save elp status */
>          if (cpu_get_fcfien(env)) {
> @@ -2049,8 +2115,17 @@ void riscv_cpu_do_interrupt(CPUState *cs)
>          env->mtval =3D tval;
>          env->mtval2 =3D mtval2;
>          env->mtinst =3D tinst;
> -        env->pc =3D (env->mtvec >> 2 << 2) +
> -                  ((async && (env->mtvec & 3) =3D=3D 1) ? cause * 4 : 0)=
;
> +
> +        /*
> +         * For RNMI exception, program counter is set to the RNMI except=
ion
> +         * trap handler address.
> +         */
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
> 2.34.1
>
>

