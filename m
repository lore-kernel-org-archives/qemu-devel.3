Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 292E1C369D1
	for <qemu-devel@archiver.kernel.org>; Fri, 25 Apr 2025 09:44:39 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u8FbS-0006jI-Jb; Fri, 25 Apr 2025 05:44:14 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jay.chang@sifive.com>)
 id 1u8FbQ-0006ir-Tm
 for qemu-devel@nongnu.org; Fri, 25 Apr 2025 05:44:12 -0400
Received: from mail-pl1-x632.google.com ([2607:f8b0:4864:20::632])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <jay.chang@sifive.com>)
 id 1u8FbN-0000x3-KJ
 for qemu-devel@nongnu.org; Fri, 25 Apr 2025 05:44:12 -0400
Received: by mail-pl1-x632.google.com with SMTP id
 d9443c01a7336-22438c356c8so23111875ad.1
 for <qemu-devel@nongnu.org>; Fri, 25 Apr 2025 02:44:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sifive.com; s=google; t=1745574247; x=1746179047; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=NaXvKVlpN/kfTHgCUj8QEE+5EChXJdZ3ONFjD0KiP0c=;
 b=XK5ryQ8yFi8TFqXWMyVO+82mhf2/ztWBWuX3Bu1qmqk+iFmEJ8VbyA/NZhXolyZ1MG
 8sNOLaD/cV8RgMUqWo163ksC56iCHQzEtvro2h7NEF3sNB/OUvbd7LwL697eg2SVOppF
 8pY+L6gmGOeRRzUL26hvF4+KcBuQl8Kftb1Iuf5/SOkzJIWP8KliiakS9YFPA2Hs/aYJ
 eTf3H0n5KsX/I5x7b16Dlf0FmmXNocaGrsFhvbeM1WqydEGKKCDwxLcdqKIMNvxfzta6
 qX0AzKr/Dn2e5m/qOqBD/jtfedX54WMHz0ouxwNyLqN+w7pGXL+dDPUHpiPfNEJ8XRX6
 x2eQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1745574247; x=1746179047;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=NaXvKVlpN/kfTHgCUj8QEE+5EChXJdZ3ONFjD0KiP0c=;
 b=irrnWvx7rD6JACAj3aLwQpoPoVT547lLrjC4UJSTL54zZjSopqSClFq3BpuUm5+dQ3
 lQD3S5cONDedCAB2aoU2QPG8N6sCFZ15JA7oK6lL0bBxiCR5zQ6TxvWgVGMacIMqAZA9
 u9nO8Hm9NZwt5NfaiOe5ieCK1dBGxk2u4kx7APQQS0hy+2UUCkfQcYPPrb5pnzSQBVjM
 9v8Rh+ojeoMeWpciy+rzUZikyeQ8M+9S329JpQ5uvygY6+ilj5TkBnvMjmLr0BceIERE
 x9aJEvAysk9VuVWCevFtNXdBXa0zYwgBxFozX75GhwNkCDyh1ktlPOcOlL2HmaktzsVp
 RQAw==
X-Gm-Message-State: AOJu0YzZajoyj+y8fRwA0gpGk2/9Zox6UywwoCckRt31scrJg3udGq49
 1f7ACWrpExoko2VDhyEWBcm/AL84TTkbilZ0owDfhonFRZVvAqdlQBJAoBKSyEmxEG/De79VRZX
 BSg3DXpTGPso0aK8mvH2aujWJraFPb40FWQ+wyg==
X-Gm-Gg: ASbGnctc5Zh5+D0EzSUzceX+wrQAter45zkzw3nP73IJpPHMiG3PG2Mrg29Eu+VpPuD
 bqMqOojgty/jIkdC046gwvtqIBLBb04uh75RYqQu3s/3Jpm/p+jVy4ohabhYIViz3Ok/w7986M1
 dt+VJfvpejdv7zGwHjb847yGP/
X-Google-Smtp-Source: AGHT+IEvbCFZnHeEQ8FVE7E+lcPFu2qzMCXlXi4lkuG/wMEycgKAD9WjS6KB/G2pC10Di2IwDER8L2S99nOY7fk8qo4=
X-Received: by 2002:a17:90b:5405:b0:2ff:6488:e01c with SMTP id
 98e67ed59e1d1-309f7ea3f9bmr2377390a91.29.1745574247152; Fri, 25 Apr 2025
 02:44:07 -0700 (PDT)
MIME-Version: 1.0
References: <20250421094656.48997-1-jay.chang@sifive.com>
 <20250421094656.48997-3-jay.chang@sifive.com>
 <CAKmqyKM4Si1_gEU37xjqZ-RZ7_B0qwuQXxzieEkDPrDnY9hQ3A@mail.gmail.com>
In-Reply-To: <CAKmqyKM4Si1_gEU37xjqZ-RZ7_B0qwuQXxzieEkDPrDnY9hQ3A@mail.gmail.com>
From: Jay Chang <jay.chang@sifive.com>
Date: Fri, 25 Apr 2025 17:43:55 +0800
X-Gm-Features: ATxdqUFKzWNon2gj8M7e3Nn-yR9xyIjrlDed7B0wMp7v0LJz17ew0IZG7ksjD1A
Message-ID: <CACNNAjPXUF+pLQumiUbXgmy3kF8GU28OnKcrwhSSW6XH79MpsA@mail.gmail.com>
Subject: Re: [PATCH 2/2] target/riscv: Make PMP region count configurable
To: Alistair Francis <alistair23@gmail.com>
Cc: qemu-devel@nongnu.org, qemu-riscv@nongnu.org, 
 Palmer Dabbelt <palmer@dabbelt.com>,
 Alistair Francis <alistair.francis@wdc.com>, 
 Weiwei Li <liwei1518@gmail.com>,
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>, 
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>, Frank Chang <frank.chang@sifive.com>
Content-Type: multipart/alternative; boundary="000000000000ee61320633972cbb"
Received-SPF: pass client-ip=2607:f8b0:4864:20::632;
 envelope-from=jay.chang@sifive.com; helo=mail-pl1-x632.google.com
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

--000000000000ee61320633972cbb
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

I will send v2 patch

Jay Chang

On Thu, Apr 24, 2025 at 6:55=E2=80=AFPM Alistair Francis <alistair23@gmail.=
com>
wrote:

> On Mon, Apr 21, 2025 at 7:48=E2=80=AFPM Jay Chang <jay.chang@sifive.com> =
wrote:
> >
> > Previously, the number of PMP regions was hardcoded to 16 in QEMU.
> > This patch replaces the fixed value with a new `pmp_regions` field,
> > allowing platforms to configure the number of PMP regions.
> >
> > If no specific value is provided, the default number of PMP regions
> > remains 16 to preserve the existing behavior.
> >
> > A new CPU parameter num-pmp-regions has been introduced to the QEMU
> > command line. For example:
> >
> >         -cpu rv64, g=3Dtrue, c=3Dtrue, pmp=3Dtrue, num-pmp-regions=3D8
> >
> > Reviewed-by: Frank Chang <frank.chang@sifive.com>
> > Signed-off-by: Jay Chang <jay.chang@sifive.com>
> > ---
> >  target/riscv/cpu.c     | 46 ++++++++++++++++++++++++++++++++++++++++++
> >  target/riscv/cpu.h     |  2 +-
> >  target/riscv/cpu_cfg.h |  1 +
> >  target/riscv/csr.c     |  5 ++++-
> >  target/riscv/machine.c |  3 ++-
> >  target/riscv/pmp.c     | 28 ++++++++++++++++---------
> >  6 files changed, 73 insertions(+), 12 deletions(-)
> >
> > diff --git a/target/riscv/cpu.c b/target/riscv/cpu.c
> > index 09ded6829a..528d77b820 100644
> > --- a/target/riscv/cpu.c
> > +++ b/target/riscv/cpu.c
> > @@ -512,6 +512,7 @@ static void rv64_sifive_u_cpu_init(Object *obj)
> >      cpu->cfg.ext_zicsr =3D true;
> >      cpu->cfg.mmu =3D true;
> >      cpu->cfg.pmp =3D true;
> > +    cpu->cfg.pmp_regions =3D 8;
> >  }
> >
> >  static void rv64_sifive_e_cpu_init(Object *obj)
> > @@ -529,6 +530,7 @@ static void rv64_sifive_e_cpu_init(Object *obj)
> >      cpu->cfg.ext_zifencei =3D true;
> >      cpu->cfg.ext_zicsr =3D true;
> >      cpu->cfg.pmp =3D true;
> > +    cpu->cfg.pmp_regions =3D 8;
> >  }
> >
> >  static void rv64_thead_c906_cpu_init(Object *obj)
> > @@ -761,6 +763,7 @@ static void rv32_sifive_u_cpu_init(Object *obj)
> >      cpu->cfg.ext_zicsr =3D true;
> >      cpu->cfg.mmu =3D true;
> >      cpu->cfg.pmp =3D true;
> > +    cpu->cfg.pmp_regions =3D 8;
> >  }
> >
> >  static void rv32_sifive_e_cpu_init(Object *obj)
> > @@ -778,6 +781,7 @@ static void rv32_sifive_e_cpu_init(Object *obj)
> >      cpu->cfg.ext_zifencei =3D true;
> >      cpu->cfg.ext_zicsr =3D true;
> >      cpu->cfg.pmp =3D true;
> > +    cpu->cfg.pmp_regions =3D 8;
> >  }
> >
> >  static void rv32_ibex_cpu_init(Object *obj)
> > @@ -1478,6 +1482,7 @@ static void riscv_cpu_init(Object *obj)
> >      cpu->cfg.cbom_blocksize =3D 64;
> >      cpu->cfg.cbop_blocksize =3D 64;
> >      cpu->cfg.cboz_blocksize =3D 64;
> > +    cpu->cfg.pmp_regions =3D 16;
> >      cpu->env.vext_ver =3D VEXT_VERSION_1_00_0;
> >  }
>
> Thanks for the patch
>
> These CPU init properties will need a rebase on:
> https://github.com/alistair23/qemu/tree/riscv-to-apply.next
>
> Do you mind rebasing and sending a new version
>
> Alistair
>
> >
> > @@ -1935,6 +1940,46 @@ static const PropertyInfo prop_pmp =3D {
> >      .set =3D prop_pmp_set,
> >  };
> >
> > +static void prop_num_pmp_regions_set(Object *obj, Visitor *v, const
> char *name,
> > +                                     void *opaque, Error **errp)
> > +{
> > +    RISCVCPU *cpu =3D RISCV_CPU(obj);
> > +    uint16_t value;
> > +
> > +    visit_type_uint16(v, name, &value, errp);
> > +
> > +    if (cpu->cfg.pmp_regions !=3D value && riscv_cpu_is_vendor(obj)) {
> > +        cpu_set_prop_err(cpu, name, errp);
> > +        return;
> > +    }
> > +
> > +    if (cpu->env.priv_ver < PRIV_VERSION_1_12_0 && value > 16) {
> > +        error_setg(errp, "Number of PMP regions exceeds maximum
> available");
> > +        return;
> > +    } else if (value > 64) {
> > +        error_setg(errp, "Number of PMP regions exceeds maximum
> available");
> > +        return;
> > +    }
> > +
> > +    cpu_option_add_user_setting(name, value);
> > +    cpu->cfg.pmp_regions =3D value;
> > +}
> > +
> > +static void prop_num_pmp_regions_get(Object *obj, Visitor *v, const
> char *name,
> > +                                     void *opaque, Error **errp)
> > +{
> > +    uint16_t value =3D RISCV_CPU(obj)->cfg.pmp_regions;
> > +
> > +    visit_type_uint16(v, name, &value, errp);
> > +}
> > +
> > +static const PropertyInfo prop_num_pmp_regions =3D {
> > +    .type =3D "uint16",
> > +    .description =3D "num-pmp-regions",
> > +    .get =3D prop_num_pmp_regions_get,
> > +    .set =3D prop_num_pmp_regions_set,
> > +};
> > +
> >  static int priv_spec_from_str(const char *priv_spec_str)
> >  {
> >      int priv_version =3D -1;
> > @@ -2934,6 +2979,7 @@ static const Property riscv_cpu_properties[] =3D =
{
> >
> >      {.name =3D "mmu", .info =3D &prop_mmu},
> >      {.name =3D "pmp", .info =3D &prop_pmp},
> > +    {.name =3D "num-pmp-regions", .info =3D &prop_num_pmp_regions},
> >
> >      {.name =3D "priv_spec", .info =3D &prop_priv_spec},
> >      {.name =3D "vext_spec", .info =3D &prop_vext_spec},
> > diff --git a/target/riscv/cpu.h b/target/riscv/cpu.h
> > index 51e49e03de..50d58c15f2 100644
> > --- a/target/riscv/cpu.h
> > +++ b/target/riscv/cpu.h
> > @@ -162,7 +162,7 @@ extern RISCVCPUImpliedExtsRule
> *riscv_multi_ext_implied_rules[];
> >
> >  #define MMU_USER_IDX 3
> >
> > -#define MAX_RISCV_PMPS (16)
> > +#define MAX_RISCV_PMPS (64)
> >
> >  #if !defined(CONFIG_USER_ONLY)
> >  #include "pmp.h"
> > diff --git a/target/riscv/cpu_cfg.h b/target/riscv/cpu_cfg.h
> > index 8a843482cc..8c805b45f6 100644
> > --- a/target/riscv/cpu_cfg.h
> > +++ b/target/riscv/cpu_cfg.h
> > @@ -189,6 +189,7 @@ struct RISCVCPUConfig {
> >      uint16_t cbom_blocksize;
> >      uint16_t cbop_blocksize;
> >      uint16_t cboz_blocksize;
> > +    uint16_t pmp_regions;
> >      bool mmu;
> >      bool pmp;
> >      bool debug;
> > diff --git a/target/riscv/csr.c b/target/riscv/csr.c
> > index f8f61ffff5..65f91be9c0 100644
> > --- a/target/riscv/csr.c
> > +++ b/target/riscv/csr.c
> > @@ -736,7 +736,10 @@ static RISCVException dbltrp_hmode(CPURISCVState
> *env, int csrno)
> >  static RISCVException pmp(CPURISCVState *env, int csrno)
> >  {
> >      if (riscv_cpu_cfg(env)->pmp) {
> > -        if (csrno <=3D CSR_PMPCFG3) {
> > +        uint16_t MAX_PMPCFG =3D (env->priv_ver >=3D PRIV_VERSION_1_12_=
0) ?
> > ++                              CSR_PMPCFG15 : CSR_PMPCFG3;
> > +
> > +        if (csrno <=3D MAX_PMPCFG) {
> >              uint32_t reg_index =3D csrno - CSR_PMPCFG0;
> >
> >              /* TODO: RV128 restriction check */
> > diff --git a/target/riscv/machine.c b/target/riscv/machine.c
> > index 889e2b6570..c3e4e78802 100644
> > --- a/target/riscv/machine.c
> > +++ b/target/riscv/machine.c
> > @@ -36,8 +36,9 @@ static int pmp_post_load(void *opaque, int version_id=
)
> >      RISCVCPU *cpu =3D opaque;
> >      CPURISCVState *env =3D &cpu->env;
> >      int i;
> > +    uint16_t pmp_regions =3D riscv_cpu_cfg(env)->pmp_regions;
> >
> > -    for (i =3D 0; i < MAX_RISCV_PMPS; i++) {
> > +    for (i =3D 0; i < pmp_regions; i++) {
> >          pmp_update_rule_addr(env, i);
> >      }
> >      pmp_update_rule_nums(env);
> > diff --git a/target/riscv/pmp.c b/target/riscv/pmp.c
> > index c685f7f2c5..3439295d41 100644
> > --- a/target/riscv/pmp.c
> > +++ b/target/riscv/pmp.c
> > @@ -121,7 +121,9 @@ uint32_t pmp_get_num_rules(CPURISCVState *env)
> >   */
> >  static inline uint8_t pmp_read_cfg(CPURISCVState *env, uint32_t
> pmp_index)
> >  {
> > -    if (pmp_index < MAX_RISCV_PMPS) {
> > +    uint16_t pmp_regions =3D riscv_cpu_cfg(env)->pmp_regions;
> > +
> > +    if (pmp_index < pmp_regions) {
> >          return env->pmp_state.pmp[pmp_index].cfg_reg;
> >      }
> >
> > @@ -135,7 +137,9 @@ static inline uint8_t pmp_read_cfg(CPURISCVState
> *env, uint32_t pmp_index)
> >   */
> >  static bool pmp_write_cfg(CPURISCVState *env, uint32_t pmp_index,
> uint8_t val)
> >  {
> > -    if (pmp_index < MAX_RISCV_PMPS) {
> > +    uint16_t pmp_regions =3D riscv_cpu_cfg(env)->pmp_regions;
> > +
> > +    if (pmp_index < pmp_regions) {
> >          if (env->pmp_state.pmp[pmp_index].cfg_reg =3D=3D val) {
> >              /* no change */
> >              return false;
> > @@ -235,9 +239,10 @@ void pmp_update_rule_addr(CPURISCVState *env,
> uint32_t pmp_index)
> >  void pmp_update_rule_nums(CPURISCVState *env)
> >  {
> >      int i;
> > +    uint16_t pmp_regions =3D riscv_cpu_cfg(env)->pmp_regions;
> >
> >      env->pmp_state.num_rules =3D 0;
> > -    for (i =3D 0; i < MAX_RISCV_PMPS; i++) {
> > +    for (i =3D 0; i < pmp_regions; i++) {
> >          const uint8_t a_field =3D
> >              pmp_get_a_field(env->pmp_state.pmp[i].cfg_reg);
> >          if (PMP_AMATCH_OFF !=3D a_field) {
> > @@ -331,6 +336,7 @@ bool pmp_hart_has_privs(CPURISCVState *env, hwaddr
> addr,
> >      int pmp_size =3D 0;
> >      hwaddr s =3D 0;
> >      hwaddr e =3D 0;
> > +    uint16_t pmp_regions =3D riscv_cpu_cfg(env)->pmp_regions;
> >
> >      /* Short cut if no rules */
> >      if (0 =3D=3D pmp_get_num_rules(env)) {
> > @@ -355,7 +361,7 @@ bool pmp_hart_has_privs(CPURISCVState *env, hwaddr
> addr,
> >       * 1.10 draft priv spec states there is an implicit order
> >       * from low to high
> >       */
> > -    for (i =3D 0; i < MAX_RISCV_PMPS; i++) {
> > +    for (i =3D 0; i < pmp_regions; i++) {
> >          s =3D pmp_is_in_range(env, i, addr);
> >          e =3D pmp_is_in_range(env, i, addr + pmp_size - 1);
> >
> > @@ -526,8 +532,9 @@ void pmpaddr_csr_write(CPURISCVState *env, uint32_t
> addr_index,
> >  {
> >      trace_pmpaddr_csr_write(env->mhartid, addr_index, val);
> >      bool is_next_cfg_tor =3D false;
> > +    uint16_t pmp_regions =3D riscv_cpu_cfg(env)->pmp_regions;
> >
> > -    if (addr_index < MAX_RISCV_PMPS) {
> > +    if (addr_index < pmp_regions) {
> >          if (env->pmp_state.pmp[addr_index].addr_reg =3D=3D val) {
> >              /* no change */
> >              return;
> > @@ -537,7 +544,7 @@ void pmpaddr_csr_write(CPURISCVState *env, uint32_t
> addr_index,
> >           * In TOR mode, need to check the lock bit of the next pmp
> >           * (if there is a next).
> >           */
> > -        if (addr_index + 1 < MAX_RISCV_PMPS) {
> > +        if (addr_index + 1 < pmp_regions) {
> >              uint8_t pmp_cfg =3D env->pmp_state.pmp[addr_index +
> 1].cfg_reg;
> >              is_next_cfg_tor =3D PMP_AMATCH_TOR =3D=3D
> pmp_get_a_field(pmp_cfg);
> >
> > @@ -572,8 +579,9 @@ void pmpaddr_csr_write(CPURISCVState *env, uint32_t
> addr_index,
> >  target_ulong pmpaddr_csr_read(CPURISCVState *env, uint32_t addr_index)
> >  {
> >      target_ulong val =3D 0;
> > +    uint16_t pmp_regions =3D riscv_cpu_cfg(env)->pmp_regions;
> >
> > -    if (addr_index < MAX_RISCV_PMPS) {
> > +    if (addr_index < pmp_regions) {
> >          val =3D env->pmp_state.pmp[addr_index].addr_reg;
> >          trace_pmpaddr_csr_read(env->mhartid, addr_index, val);
> >      } else {
> > @@ -591,6 +599,7 @@ void mseccfg_csr_write(CPURISCVState *env,
> target_ulong val)
> >  {
> >      int i;
> >      uint64_t mask =3D MSECCFG_MMWP | MSECCFG_MML;
> > +    uint16_t pmp_regions =3D riscv_cpu_cfg(env)->pmp_regions;
> >      /* Update PMM field only if the value is valid according to Zjpm
> v1.0 */
> >      if (riscv_cpu_cfg(env)->ext_smmpm &&
> >          riscv_cpu_mxl(env) =3D=3D MXL_RV64 &&
> > @@ -602,7 +611,7 @@ void mseccfg_csr_write(CPURISCVState *env,
> target_ulong val)
> >
> >      /* RLB cannot be enabled if it's already 0 and if any regions are
> locked */
> >      if (!MSECCFG_RLB_ISSET(env)) {
> > -        for (i =3D 0; i < MAX_RISCV_PMPS; i++) {
> > +        for (i =3D 0; i < pmp_regions; i++) {
> >              if (pmp_is_locked(env, i)) {
> >                  val &=3D ~MSECCFG_RLB;
> >                  break;
> > @@ -658,6 +667,7 @@ target_ulong pmp_get_tlb_size(CPURISCVState *env,
> hwaddr addr)
> >      hwaddr tlb_sa =3D addr & ~(TARGET_PAGE_SIZE - 1);
> >      hwaddr tlb_ea =3D tlb_sa + TARGET_PAGE_SIZE - 1;
> >      int i;
> > +    uint16_t pmp_regions =3D riscv_cpu_cfg(env)->pmp_regions;
> >
> >      /*
> >       * If PMP is not supported or there are no PMP rules, the TLB page
> will not
> > @@ -668,7 +678,7 @@ target_ulong pmp_get_tlb_size(CPURISCVState *env,
> hwaddr addr)
> >          return TARGET_PAGE_SIZE;
> >      }
> >
> > -    for (i =3D 0; i < MAX_RISCV_PMPS; i++) {
> > +    for (i =3D 0; i < pmp_regions; i++) {
> >          if (pmp_get_a_field(env->pmp_state.pmp[i].cfg_reg) =3D=3D
> PMP_AMATCH_OFF) {
> >              continue;
> >          }
> > --
> > 2.48.1
> >
> >
>

--000000000000ee61320633972cbb
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr">I will send v2 patch<br><br>Jay Chang</div><br><div class=
=3D"gmail_quote gmail_quote_container"><div dir=3D"ltr" class=3D"gmail_attr=
">On Thu, Apr 24, 2025 at 6:55=E2=80=AFPM Alistair Francis &lt;<a href=3D"m=
ailto:alistair23@gmail.com">alistair23@gmail.com</a>&gt; wrote:<br></div><b=
lockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-le=
ft:1px solid rgb(204,204,204);padding-left:1ex">On Mon, Apr 21, 2025 at 7:4=
8=E2=80=AFPM Jay Chang &lt;<a href=3D"mailto:jay.chang@sifive.com" target=
=3D"_blank">jay.chang@sifive.com</a>&gt; wrote:<br>
&gt;<br>
&gt; Previously, the number of PMP regions was hardcoded to 16 in QEMU.<br>
&gt; This patch replaces the fixed value with a new `pmp_regions` field,<br=
>
&gt; allowing platforms to configure the number of PMP regions.<br>
&gt;<br>
&gt; If no specific value is provided, the default number of PMP regions<br=
>
&gt; remains 16 to preserve the existing behavior.<br>
&gt;<br>
&gt; A new CPU parameter num-pmp-regions has been introduced to the QEMU<br=
>
&gt; command line. For example:<br>
&gt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0-cpu rv64, g=3Dtrue, c=3Dtrue, pmp=3D=
true, num-pmp-regions=3D8<br>
&gt;<br>
&gt; Reviewed-by: Frank Chang &lt;<a href=3D"mailto:frank.chang@sifive.com"=
 target=3D"_blank">frank.chang@sifive.com</a>&gt;<br>
&gt; Signed-off-by: Jay Chang &lt;<a href=3D"mailto:jay.chang@sifive.com" t=
arget=3D"_blank">jay.chang@sifive.com</a>&gt;<br>
&gt; ---<br>
&gt;=C2=A0 target/riscv/cpu.c=C2=A0 =C2=A0 =C2=A0| 46 +++++++++++++++++++++=
+++++++++++++++++++++<br>
&gt;=C2=A0 target/riscv/cpu.h=C2=A0 =C2=A0 =C2=A0|=C2=A0 2 +-<br>
&gt;=C2=A0 target/riscv/cpu_cfg.h |=C2=A0 1 +<br>
&gt;=C2=A0 target/riscv/csr.c=C2=A0 =C2=A0 =C2=A0|=C2=A0 5 ++++-<br>
&gt;=C2=A0 target/riscv/machine.c |=C2=A0 3 ++-<br>
&gt;=C2=A0 target/riscv/pmp.c=C2=A0 =C2=A0 =C2=A0| 28 ++++++++++++++++-----=
----<br>
&gt;=C2=A0 6 files changed, 73 insertions(+), 12 deletions(-)<br>
&gt;<br>
&gt; diff --git a/target/riscv/cpu.c b/target/riscv/cpu.c<br>
&gt; index 09ded6829a..528d77b820 100644<br>
&gt; --- a/target/riscv/cpu.c<br>
&gt; +++ b/target/riscv/cpu.c<br>
&gt; @@ -512,6 +512,7 @@ static void rv64_sifive_u_cpu_init(Object *obj)<br=
>
&gt;=C2=A0 =C2=A0 =C2=A0 cpu-&gt;cfg.ext_zicsr =3D true;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 cpu-&gt;cfg.mmu =3D true;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 cpu-&gt;cfg.pmp =3D true;<br>
&gt; +=C2=A0 =C2=A0 cpu-&gt;cfg.pmp_regions =3D 8;<br>
&gt;=C2=A0 }<br>
&gt;<br>
&gt;=C2=A0 static void rv64_sifive_e_cpu_init(Object *obj)<br>
&gt; @@ -529,6 +530,7 @@ static void rv64_sifive_e_cpu_init(Object *obj)<br=
>
&gt;=C2=A0 =C2=A0 =C2=A0 cpu-&gt;cfg.ext_zifencei =3D true;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 cpu-&gt;cfg.ext_zicsr =3D true;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 cpu-&gt;cfg.pmp =3D true;<br>
&gt; +=C2=A0 =C2=A0 cpu-&gt;cfg.pmp_regions =3D 8;<br>
&gt;=C2=A0 }<br>
&gt;<br>
&gt;=C2=A0 static void rv64_thead_c906_cpu_init(Object *obj)<br>
&gt; @@ -761,6 +763,7 @@ static void rv32_sifive_u_cpu_init(Object *obj)<br=
>
&gt;=C2=A0 =C2=A0 =C2=A0 cpu-&gt;cfg.ext_zicsr =3D true;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 cpu-&gt;cfg.mmu =3D true;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 cpu-&gt;cfg.pmp =3D true;<br>
&gt; +=C2=A0 =C2=A0 cpu-&gt;cfg.pmp_regions =3D 8;<br>
&gt;=C2=A0 }<br>
&gt;<br>
&gt;=C2=A0 static void rv32_sifive_e_cpu_init(Object *obj)<br>
&gt; @@ -778,6 +781,7 @@ static void rv32_sifive_e_cpu_init(Object *obj)<br=
>
&gt;=C2=A0 =C2=A0 =C2=A0 cpu-&gt;cfg.ext_zifencei =3D true;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 cpu-&gt;cfg.ext_zicsr =3D true;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 cpu-&gt;cfg.pmp =3D true;<br>
&gt; +=C2=A0 =C2=A0 cpu-&gt;cfg.pmp_regions =3D 8;<br>
&gt;=C2=A0 }<br>
&gt;<br>
&gt;=C2=A0 static void rv32_ibex_cpu_init(Object *obj)<br>
&gt; @@ -1478,6 +1482,7 @@ static void riscv_cpu_init(Object *obj)<br>
&gt;=C2=A0 =C2=A0 =C2=A0 cpu-&gt;cfg.cbom_blocksize =3D 64;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 cpu-&gt;cfg.cbop_blocksize =3D 64;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 cpu-&gt;cfg.cboz_blocksize =3D 64;<br>
&gt; +=C2=A0 =C2=A0 cpu-&gt;cfg.pmp_regions =3D 16;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 cpu-&gt;env.vext_ver =3D VEXT_VERSION_1_00_0;<br>
&gt;=C2=A0 }<br>
<br>
Thanks for the patch<br>
<br>
These CPU init properties will need a rebase on:<br>
<a href=3D"https://github.com/alistair23/qemu/tree/riscv-to-apply.next" rel=
=3D"noreferrer" target=3D"_blank">https://github.com/alistair23/qemu/tree/r=
iscv-to-apply.next</a><br>
<br>
Do you mind rebasing and sending a new version<br>
<br>
Alistair<br>
<br>
&gt;<br>
&gt; @@ -1935,6 +1940,46 @@ static const PropertyInfo prop_pmp =3D {<br>
&gt;=C2=A0 =C2=A0 =C2=A0 .set =3D prop_pmp_set,<br>
&gt;=C2=A0 };<br>
&gt;<br>
&gt; +static void prop_num_pmp_regions_set(Object *obj, Visitor *v, const c=
har *name,<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0void *opaque=
, Error **errp)<br>
&gt; +{<br>
&gt; +=C2=A0 =C2=A0 RISCVCPU *cpu =3D RISCV_CPU(obj);<br>
&gt; +=C2=A0 =C2=A0 uint16_t value;<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 visit_type_uint16(v, name, &amp;value, errp);<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 if (cpu-&gt;cfg.pmp_regions !=3D value &amp;&amp; riscv=
_cpu_is_vendor(obj)) {<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 cpu_set_prop_err(cpu, name, errp);<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 return;<br>
&gt; +=C2=A0 =C2=A0 }<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 if (cpu-&gt;env.priv_ver &lt; PRIV_VERSION_1_12_0 &amp;=
&amp; value &gt; 16) {<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 error_setg(errp, &quot;Number of PMP regi=
ons exceeds maximum available&quot;);<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 return;<br>
&gt; +=C2=A0 =C2=A0 } else if (value &gt; 64) {<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 error_setg(errp, &quot;Number of PMP regi=
ons exceeds maximum available&quot;);<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 return;<br>
&gt; +=C2=A0 =C2=A0 }<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 cpu_option_add_user_setting(name, value);<br>
&gt; +=C2=A0 =C2=A0 cpu-&gt;cfg.pmp_regions =3D value;<br>
&gt; +}<br>
&gt; +<br>
&gt; +static void prop_num_pmp_regions_get(Object *obj, Visitor *v, const c=
har *name,<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0void *opaque=
, Error **errp)<br>
&gt; +{<br>
&gt; +=C2=A0 =C2=A0 uint16_t value =3D RISCV_CPU(obj)-&gt;cfg.pmp_regions;<=
br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 visit_type_uint16(v, name, &amp;value, errp);<br>
&gt; +}<br>
&gt; +<br>
&gt; +static const PropertyInfo prop_num_pmp_regions =3D {<br>
&gt; +=C2=A0 =C2=A0 .type =3D &quot;uint16&quot;,<br>
&gt; +=C2=A0 =C2=A0 .description =3D &quot;num-pmp-regions&quot;,<br>
&gt; +=C2=A0 =C2=A0 .get =3D prop_num_pmp_regions_get,<br>
&gt; +=C2=A0 =C2=A0 .set =3D prop_num_pmp_regions_set,<br>
&gt; +};<br>
&gt; +<br>
&gt;=C2=A0 static int priv_spec_from_str(const char *priv_spec_str)<br>
&gt;=C2=A0 {<br>
&gt;=C2=A0 =C2=A0 =C2=A0 int priv_version =3D -1;<br>
&gt; @@ -2934,6 +2979,7 @@ static const Property riscv_cpu_properties[] =3D=
 {<br>
&gt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 {.name =3D &quot;mmu&quot;, .info =3D &amp;prop_mm=
u},<br>
&gt;=C2=A0 =C2=A0 =C2=A0 {.name =3D &quot;pmp&quot;, .info =3D &amp;prop_pm=
p},<br>
&gt; +=C2=A0 =C2=A0 {.name =3D &quot;num-pmp-regions&quot;, .info =3D &amp;=
prop_num_pmp_regions},<br>
&gt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 {.name =3D &quot;priv_spec&quot;, .info =3D &amp;p=
rop_priv_spec},<br>
&gt;=C2=A0 =C2=A0 =C2=A0 {.name =3D &quot;vext_spec&quot;, .info =3D &amp;p=
rop_vext_spec},<br>
&gt; diff --git a/target/riscv/cpu.h b/target/riscv/cpu.h<br>
&gt; index 51e49e03de..50d58c15f2 100644<br>
&gt; --- a/target/riscv/cpu.h<br>
&gt; +++ b/target/riscv/cpu.h<br>
&gt; @@ -162,7 +162,7 @@ extern RISCVCPUImpliedExtsRule *riscv_multi_ext_im=
plied_rules[];<br>
&gt;<br>
&gt;=C2=A0 #define MMU_USER_IDX 3<br>
&gt;<br>
&gt; -#define MAX_RISCV_PMPS (16)<br>
&gt; +#define MAX_RISCV_PMPS (64)<br>
&gt;<br>
&gt;=C2=A0 #if !defined(CONFIG_USER_ONLY)<br>
&gt;=C2=A0 #include &quot;pmp.h&quot;<br>
&gt; diff --git a/target/riscv/cpu_cfg.h b/target/riscv/cpu_cfg.h<br>
&gt; index 8a843482cc..8c805b45f6 100644<br>
&gt; --- a/target/riscv/cpu_cfg.h<br>
&gt; +++ b/target/riscv/cpu_cfg.h<br>
&gt; @@ -189,6 +189,7 @@ struct RISCVCPUConfig {<br>
&gt;=C2=A0 =C2=A0 =C2=A0 uint16_t cbom_blocksize;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 uint16_t cbop_blocksize;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 uint16_t cboz_blocksize;<br>
&gt; +=C2=A0 =C2=A0 uint16_t pmp_regions;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 bool mmu;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 bool pmp;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 bool debug;<br>
&gt; diff --git a/target/riscv/csr.c b/target/riscv/csr.c<br>
&gt; index f8f61ffff5..65f91be9c0 100644<br>
&gt; --- a/target/riscv/csr.c<br>
&gt; +++ b/target/riscv/csr.c<br>
&gt; @@ -736,7 +736,10 @@ static RISCVException dbltrp_hmode(CPURISCVState =
*env, int csrno)<br>
&gt;=C2=A0 static RISCVException pmp(CPURISCVState *env, int csrno)<br>
&gt;=C2=A0 {<br>
&gt;=C2=A0 =C2=A0 =C2=A0 if (riscv_cpu_cfg(env)-&gt;pmp) {<br>
&gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 if (csrno &lt;=3D CSR_PMPCFG3) {<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 uint16_t MAX_PMPCFG =3D (env-&gt;priv_ver=
 &gt;=3D PRIV_VERSION_1_12_0) ?<br>
&gt; ++=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 CSR_PMPCFG15 : CSR_PMPCFG3;<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 if (csrno &lt;=3D MAX_PMPCFG) {<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 uint32_t reg_index =3D=
 csrno - CSR_PMPCFG0;<br>
&gt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 /* TODO: RV128 restric=
tion check */<br>
&gt; diff --git a/target/riscv/machine.c b/target/riscv/machine.c<br>
&gt; index 889e2b6570..c3e4e78802 100644<br>
&gt; --- a/target/riscv/machine.c<br>
&gt; +++ b/target/riscv/machine.c<br>
&gt; @@ -36,8 +36,9 @@ static int pmp_post_load(void *opaque, int version_i=
d)<br>
&gt;=C2=A0 =C2=A0 =C2=A0 RISCVCPU *cpu =3D opaque;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 CPURISCVState *env =3D &amp;cpu-&gt;env;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 int i;<br>
&gt; +=C2=A0 =C2=A0 uint16_t pmp_regions =3D riscv_cpu_cfg(env)-&gt;pmp_reg=
ions;<br>
&gt;<br>
&gt; -=C2=A0 =C2=A0 for (i =3D 0; i &lt; MAX_RISCV_PMPS; i++) {<br>
&gt; +=C2=A0 =C2=A0 for (i =3D 0; i &lt; pmp_regions; i++) {<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 pmp_update_rule_addr(env, i);<br>
&gt;=C2=A0 =C2=A0 =C2=A0 }<br>
&gt;=C2=A0 =C2=A0 =C2=A0 pmp_update_rule_nums(env);<br>
&gt; diff --git a/target/riscv/pmp.c b/target/riscv/pmp.c<br>
&gt; index c685f7f2c5..3439295d41 100644<br>
&gt; --- a/target/riscv/pmp.c<br>
&gt; +++ b/target/riscv/pmp.c<br>
&gt; @@ -121,7 +121,9 @@ uint32_t pmp_get_num_rules(CPURISCVState *env)<br>
&gt;=C2=A0 =C2=A0*/<br>
&gt;=C2=A0 static inline uint8_t pmp_read_cfg(CPURISCVState *env, uint32_t =
pmp_index)<br>
&gt;=C2=A0 {<br>
&gt; -=C2=A0 =C2=A0 if (pmp_index &lt; MAX_RISCV_PMPS) {<br>
&gt; +=C2=A0 =C2=A0 uint16_t pmp_regions =3D riscv_cpu_cfg(env)-&gt;pmp_reg=
ions;<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 if (pmp_index &lt; pmp_regions) {<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 return env-&gt;pmp_state.pmp[pmp_ind=
ex].cfg_reg;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 }<br>
&gt;<br>
&gt; @@ -135,7 +137,9 @@ static inline uint8_t pmp_read_cfg(CPURISCVState *=
env, uint32_t pmp_index)<br>
&gt;=C2=A0 =C2=A0*/<br>
&gt;=C2=A0 static bool pmp_write_cfg(CPURISCVState *env, uint32_t pmp_index=
, uint8_t val)<br>
&gt;=C2=A0 {<br>
&gt; -=C2=A0 =C2=A0 if (pmp_index &lt; MAX_RISCV_PMPS) {<br>
&gt; +=C2=A0 =C2=A0 uint16_t pmp_regions =3D riscv_cpu_cfg(env)-&gt;pmp_reg=
ions;<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 if (pmp_index &lt; pmp_regions) {<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 if (env-&gt;pmp_state.pmp[pmp_index]=
.cfg_reg =3D=3D val) {<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 /* no change */<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 return false;<br>
&gt; @@ -235,9 +239,10 @@ void pmp_update_rule_addr(CPURISCVState *env, uin=
t32_t pmp_index)<br>
&gt;=C2=A0 void pmp_update_rule_nums(CPURISCVState *env)<br>
&gt;=C2=A0 {<br>
&gt;=C2=A0 =C2=A0 =C2=A0 int i;<br>
&gt; +=C2=A0 =C2=A0 uint16_t pmp_regions =3D riscv_cpu_cfg(env)-&gt;pmp_reg=
ions;<br>
&gt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 env-&gt;pmp_state.num_rules =3D 0;<br>
&gt; -=C2=A0 =C2=A0 for (i =3D 0; i &lt; MAX_RISCV_PMPS; i++) {<br>
&gt; +=C2=A0 =C2=A0 for (i =3D 0; i &lt; pmp_regions; i++) {<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 const uint8_t a_field =3D<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 pmp_get_a_field(env-&g=
t;pmp_state.pmp[i].cfg_reg);<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 if (PMP_AMATCH_OFF !=3D a_field) {<b=
r>
&gt; @@ -331,6 +336,7 @@ bool pmp_hart_has_privs(CPURISCVState *env, hwaddr=
 addr,<br>
&gt;=C2=A0 =C2=A0 =C2=A0 int pmp_size =3D 0;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 hwaddr s =3D 0;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 hwaddr e =3D 0;<br>
&gt; +=C2=A0 =C2=A0 uint16_t pmp_regions =3D riscv_cpu_cfg(env)-&gt;pmp_reg=
ions;<br>
&gt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 /* Short cut if no rules */<br>
&gt;=C2=A0 =C2=A0 =C2=A0 if (0 =3D=3D pmp_get_num_rules(env)) {<br>
&gt; @@ -355,7 +361,7 @@ bool pmp_hart_has_privs(CPURISCVState *env, hwaddr=
 addr,<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0* 1.10 draft priv spec states there is an im=
plicit order<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0* from low to high<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0*/<br>
&gt; -=C2=A0 =C2=A0 for (i =3D 0; i &lt; MAX_RISCV_PMPS; i++) {<br>
&gt; +=C2=A0 =C2=A0 for (i =3D 0; i &lt; pmp_regions; i++) {<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 s =3D pmp_is_in_range(env, i, addr);=
<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 e =3D pmp_is_in_range(env, i, addr +=
 pmp_size - 1);<br>
&gt;<br>
&gt; @@ -526,8 +532,9 @@ void pmpaddr_csr_write(CPURISCVState *env, uint32_=
t addr_index,<br>
&gt;=C2=A0 {<br>
&gt;=C2=A0 =C2=A0 =C2=A0 trace_pmpaddr_csr_write(env-&gt;mhartid, addr_inde=
x, val);<br>
&gt;=C2=A0 =C2=A0 =C2=A0 bool is_next_cfg_tor =3D false;<br>
&gt; +=C2=A0 =C2=A0 uint16_t pmp_regions =3D riscv_cpu_cfg(env)-&gt;pmp_reg=
ions;<br>
&gt;<br>
&gt; -=C2=A0 =C2=A0 if (addr_index &lt; MAX_RISCV_PMPS) {<br>
&gt; +=C2=A0 =C2=A0 if (addr_index &lt; pmp_regions) {<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 if (env-&gt;pmp_state.pmp[addr_index=
].addr_reg =3D=3D val) {<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 /* no change */<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 return;<br>
&gt; @@ -537,7 +544,7 @@ void pmpaddr_csr_write(CPURISCVState *env, uint32_=
t addr_index,<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0* In TOR mode, need to check t=
he lock bit of the next pmp<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0* (if there is a next).<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0*/<br>
&gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 if (addr_index + 1 &lt; MAX_RISCV_PMPS) {=
<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 if (addr_index + 1 &lt; pmp_regions) {<br=
>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 uint8_t pmp_cfg =3D en=
v-&gt;pmp_state.pmp[addr_index + 1].cfg_reg;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 is_next_cfg_tor =3D PM=
P_AMATCH_TOR =3D=3D pmp_get_a_field(pmp_cfg);<br>
&gt;<br>
&gt; @@ -572,8 +579,9 @@ void pmpaddr_csr_write(CPURISCVState *env, uint32_=
t addr_index,<br>
&gt;=C2=A0 target_ulong pmpaddr_csr_read(CPURISCVState *env, uint32_t addr_=
index)<br>
&gt;=C2=A0 {<br>
&gt;=C2=A0 =C2=A0 =C2=A0 target_ulong val =3D 0;<br>
&gt; +=C2=A0 =C2=A0 uint16_t pmp_regions =3D riscv_cpu_cfg(env)-&gt;pmp_reg=
ions;<br>
&gt;<br>
&gt; -=C2=A0 =C2=A0 if (addr_index &lt; MAX_RISCV_PMPS) {<br>
&gt; +=C2=A0 =C2=A0 if (addr_index &lt; pmp_regions) {<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 val =3D env-&gt;pmp_state.pmp[addr_i=
ndex].addr_reg;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 trace_pmpaddr_csr_read(env-&gt;mhart=
id, addr_index, val);<br>
&gt;=C2=A0 =C2=A0 =C2=A0 } else {<br>
&gt; @@ -591,6 +599,7 @@ void mseccfg_csr_write(CPURISCVState *env, target_=
ulong val)<br>
&gt;=C2=A0 {<br>
&gt;=C2=A0 =C2=A0 =C2=A0 int i;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 uint64_t mask =3D MSECCFG_MMWP | MSECCFG_MML;<br>
&gt; +=C2=A0 =C2=A0 uint16_t pmp_regions =3D riscv_cpu_cfg(env)-&gt;pmp_reg=
ions;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 /* Update PMM field only if the value is valid acc=
ording to Zjpm v1.0 */<br>
&gt;=C2=A0 =C2=A0 =C2=A0 if (riscv_cpu_cfg(env)-&gt;ext_smmpm &amp;&amp;<br=
>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 riscv_cpu_mxl(env) =3D=3D MXL_RV64 &=
amp;&amp;<br>
&gt; @@ -602,7 +611,7 @@ void mseccfg_csr_write(CPURISCVState *env, target_=
ulong val)<br>
&gt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 /* RLB cannot be enabled if it&#39;s already 0 and=
 if any regions are locked */<br>
&gt;=C2=A0 =C2=A0 =C2=A0 if (!MSECCFG_RLB_ISSET(env)) {<br>
&gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 for (i =3D 0; i &lt; MAX_RISCV_PMPS; i++)=
 {<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 for (i =3D 0; i &lt; pmp_regions; i++) {<=
br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 if (pmp_is_locked(env,=
 i)) {<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 val &amp=
;=3D ~MSECCFG_RLB;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 break;<b=
r>
&gt; @@ -658,6 +667,7 @@ target_ulong pmp_get_tlb_size(CPURISCVState *env, =
hwaddr addr)<br>
&gt;=C2=A0 =C2=A0 =C2=A0 hwaddr tlb_sa =3D addr &amp; ~(TARGET_PAGE_SIZE - =
1);<br>
&gt;=C2=A0 =C2=A0 =C2=A0 hwaddr tlb_ea =3D tlb_sa + TARGET_PAGE_SIZE - 1;<b=
r>
&gt;=C2=A0 =C2=A0 =C2=A0 int i;<br>
&gt; +=C2=A0 =C2=A0 uint16_t pmp_regions =3D riscv_cpu_cfg(env)-&gt;pmp_reg=
ions;<br>
&gt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 /*<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0* If PMP is not supported or there are no PM=
P rules, the TLB page will not<br>
&gt; @@ -668,7 +678,7 @@ target_ulong pmp_get_tlb_size(CPURISCVState *env, =
hwaddr addr)<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 return TARGET_PAGE_SIZE;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 }<br>
&gt;<br>
&gt; -=C2=A0 =C2=A0 for (i =3D 0; i &lt; MAX_RISCV_PMPS; i++) {<br>
&gt; +=C2=A0 =C2=A0 for (i =3D 0; i &lt; pmp_regions; i++) {<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 if (pmp_get_a_field(env-&gt;pmp_stat=
e.pmp[i].cfg_reg) =3D=3D PMP_AMATCH_OFF) {<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 continue;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 }<br>
&gt; --<br>
&gt; 2.48.1<br>
&gt;<br>
&gt;<br>
</blockquote></div>

--000000000000ee61320633972cbb--

