Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 56AB0C5AD49
	for <qemu-devel@archiver.kernel.org>; Mon,  9 Jun 2025 02:48:29 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uOSYJ-00010l-C1; Sun, 08 Jun 2025 22:47:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1uOSYH-00010V-HS; Sun, 08 Jun 2025 22:47:57 -0400
Received: from mail-oi1-x236.google.com ([2607:f8b0:4864:20::236])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1uOSYF-0008GZ-8K; Sun, 08 Jun 2025 22:47:57 -0400
Received: by mail-oi1-x236.google.com with SMTP id
 5614622812f47-4079f80ff0fso2933775b6e.1; 
 Sun, 08 Jun 2025 19:47:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1749437272; x=1750042072; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=cgFInykvIcrYsReWaek7LrQ4G58FlpqtUVimnd6PyYg=;
 b=GD3OTza6Ge8sTkqNkRKxG/3jIDyUEHNPgbEaXZ+Bc8C8lhd4sLVt+StkxR+CYwWSOu
 5KPriP1tuaKa+DS+kxwBCUI8Frhg/k2WnWCzGfEWWnimkyoiuIh6cs0r8xP6jqSk4d8c
 2t6RHzc2CUyGPawWZ+CvnUp4O4B9jttitL6MvnU9FQFXGTUuNjOk8FOMEZW9rd9xebhN
 uCkVArcIJl0Epxax7kMya550cq5sqzTj+GCNuI3lcuK9tB2P1UyGVMoDWGhTv1xExKRg
 h3z8zq0+bawPEiDURG3jjP0FOBXsBfPc7Fk/kZ6JP29+GnPNVmP4vNcuEpRhc+eMvoBZ
 6yLQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1749437272; x=1750042072;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=cgFInykvIcrYsReWaek7LrQ4G58FlpqtUVimnd6PyYg=;
 b=cXtR0mGufOmCfIgWrY8VekRIgBRuYbhQ1aDkKN5xT4iCkycND7PCbDKue88hJhsxfJ
 NbRGGsu3QCxFsPR2FTzJzxUOeJp9fel5X1i9ULD0W7LJK3ScR3Tc8fETy1I1/MH1JSZ7
 q27MNXzlTMDY8bORMDNNJMD0Pgm4Y2H1j4Al23vTPY1OL6VvnxTAgWGvh+qxYKEeUDcL
 yw+0s3v6m1Rn3cLcGFBk65utgtjopyybLbKAD/uVeLrfGLa3lv4d2/6gdfZ9INjNK0Us
 2kt1kkev2UUMs40jZpRQDpv1fgplDBUYkxl6zq4hr2m6SWzn1hSWmWor9vVnrP8uIRxk
 Qosw==
X-Forwarded-Encrypted: i=1;
 AJvYcCVWo6OIdz9LneeZy7SsEYJRSeayKNXBBrAah5f6Ks23AVTBGmDHtE2JhwPur4tKOlJb0dcccvX8rJjb@nongnu.org
X-Gm-Message-State: AOJu0YzY3FMiMzv4FgVTrQkZtZ26VOwTOhFsqoydtsM7DF0aaKbYUnpF
 Xjopqf1UsscfdJWPCNv7d7Q8pbS1isda4/K559Hp8aqicwvt7b551zfMRXYBewtpIcpQryIIMvt
 /ZlVHQRwDhX1+9ljZg612mMafBy718ktbQA==
X-Gm-Gg: ASbGnctamoC/lT7a5ohggy4w7g6wpvWeEAbEtKqf4G4WQoW+bsxgPtXZ2w0tWqnABED
 mZ7Y4SuNz3N3VKOPTGBWcm1b8V85ZBknaGi06CJ7CqzG3WlC4wfaKjUwWAq43+3Gvz9zRTb5fhb
 7MDKSuIHA/jYuxl83jWM59m8vAXnYZQtLzj2f8LzzRtwtFs94nXm7OP3rxn2PUVzGa2uwTUnwjR
 Q==
X-Google-Smtp-Source: AGHT+IGUERzXIY1f2I1sSTq2XzHL0FnqC5obGgf/3z5GVLKNBLPa9nqtbeViMyiGNUP9QgfdkOek8OoLMcb9V+Fum8g=
X-Received: by 2002:a05:6102:834b:b0:4e7:866c:5cd9 with SMTP id
 ada2fe7eead31-4e7866c6146mr2849500137.11.1749437258659; Sun, 08 Jun 2025
 19:47:38 -0700 (PDT)
MIME-Version: 1.0
References: <20250606072525.17313-1-jay.chang@sifive.com>
 <20250606072525.17313-3-jay.chang@sifive.com>
In-Reply-To: <20250606072525.17313-3-jay.chang@sifive.com>
From: Alistair Francis <alistair23@gmail.com>
Date: Mon, 9 Jun 2025 12:47:12 +1000
X-Gm-Features: AX0GCFtoi1cF7ZvdgwExYz8D3ipneh102gfNo8kJoKM7qiXOalTdiHvTB9oOGH0
Message-ID: <CAKmqyKN-06j1BRn-LBS4w7fau3c8_1YOe9dNBJOEo9ES949yLQ@mail.gmail.com>
Subject: Re: [PATCH v5 2/2] target/riscv: Make PMP region count configurable
To: Jay Chang <jay.chang@sifive.com>
Cc: qemu-devel@nongnu.org, qemu-riscv@nongnu.org, 
 Palmer Dabbelt <palmer@dabbelt.com>,
 Alistair Francis <alistair.francis@wdc.com>, 
 Weiwei Li <liwei1518@gmail.com>,
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>, 
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>, Frank Chang <frank.chang@sifive.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::236;
 envelope-from=alistair23@gmail.com; helo=mail-oi1-x236.google.com
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

On Fri, Jun 6, 2025 at 5:28=E2=80=AFPM Jay Chang <jay.chang@sifive.com> wro=
te:
>
> Previously, the number of PMP regions was hardcoded to 16 in QEMU.
> This patch replaces the fixed value with a new `pmp_regions` field,
> allowing platforms to configure the number of PMP regions.
>
> If no specific value is provided, the default number of PMP regions
> remains 16 to preserve the existing behavior.
>
> A new CPU parameter num-pmp-regions has been introduced to the QEMU
> command line. For example:
>
>         -cpu rv64, g=3Dtrue, c=3Dtrue, pmp=3Dtrue, num-pmp-regions=3D8
>
> Signed-off-by: Jay Chang <jay.chang@sifive.com>
> Reviewed-by: Frank Chang <frank.chang@sifive.com>

Reviewed-by: Alistair Francis <alistair.francis@wdc.com>

Alistair

> ---
>  target/riscv/cpu.c                | 48 +++++++++++++++++++++++++++++--
>  target/riscv/cpu.h                |  3 +-
>  target/riscv/cpu_cfg_fields.h.inc |  1 +
>  target/riscv/csr.c                |  5 +++-
>  target/riscv/machine.c            |  3 +-
>  target/riscv/pmp.c                | 28 ++++++++++++------
>  6 files changed, 74 insertions(+), 14 deletions(-)
>
> diff --git a/target/riscv/cpu.c b/target/riscv/cpu.c
> index 629ac37501..f4a09ae70f 100644
> --- a/target/riscv/cpu.c
> +++ b/target/riscv/cpu.c
> @@ -1117,6 +1117,7 @@ static void riscv_cpu_init(Object *obj)
>      cpu->cfg.cbom_blocksize =3D 64;
>      cpu->cfg.cbop_blocksize =3D 64;
>      cpu->cfg.cboz_blocksize =3D 64;
> +    cpu->cfg.pmp_regions =3D 16;
>      cpu->env.vext_ver =3D VEXT_VERSION_1_00_0;
>      cpu->cfg.max_satp_mode =3D -1;
>
> @@ -1568,6 +1569,46 @@ static const PropertyInfo prop_pmp =3D {
>      .set =3D prop_pmp_set,
>  };
>
> +static void prop_num_pmp_regions_set(Object *obj, Visitor *v, const char=
 *name,
> +                                     void *opaque, Error **errp)
> +{
> +    RISCVCPU *cpu =3D RISCV_CPU(obj);
> +    uint8_t value;
> +
> +    visit_type_uint8(v, name, &value, errp);
> +
> +    if (cpu->cfg.pmp_regions !=3D value && riscv_cpu_is_vendor(obj)) {
> +        cpu_set_prop_err(cpu, name, errp);
> +        return;
> +    }
> +
> +    if (cpu->env.priv_ver < PRIV_VERSION_1_12_0 && value > OLD_MAX_RISCV=
_PMPS) {
> +        error_setg(errp, "Number of PMP regions exceeds maximum availabl=
e");
> +        return;
> +    } else if (value > MAX_RISCV_PMPS) {
> +        error_setg(errp, "Number of PMP regions exceeds maximum availabl=
e");
> +        return;
> +    }
> +
> +    cpu_option_add_user_setting(name, value);
> +    cpu->cfg.pmp_regions =3D value;
> +}
> +
> +static void prop_num_pmp_regions_get(Object *obj, Visitor *v, const char=
 *name,
> +                                     void *opaque, Error **errp)
> +{
> +    uint8_t value =3D RISCV_CPU(obj)->cfg.pmp_regions;
> +
> +    visit_type_uint8(v, name, &value, errp);
> +}
> +
> +static const PropertyInfo prop_num_pmp_regions =3D {
> +    .type =3D "uint8",
> +    .description =3D "num-pmp-regions",
> +    .get =3D prop_num_pmp_regions_get,
> +    .set =3D prop_num_pmp_regions_set,
> +};
> +
>  static int priv_spec_from_str(const char *priv_spec_str)
>  {
>      int priv_version =3D -1;
> @@ -2567,6 +2608,7 @@ static const Property riscv_cpu_properties[] =3D {
>
>      {.name =3D "mmu", .info =3D &prop_mmu},
>      {.name =3D "pmp", .info =3D &prop_pmp},
> +    {.name =3D "num-pmp-regions", .info =3D &prop_num_pmp_regions},
>
>      {.name =3D "priv_spec", .info =3D &prop_priv_spec},
>      {.name =3D "vext_spec", .info =3D &prop_vext_spec},
> @@ -2937,7 +2979,8 @@ static const TypeInfo riscv_cpu_type_infos[] =3D {
>          .cfg.max_satp_mode =3D VM_1_10_MBARE,
>          .cfg.ext_zifencei =3D true,
>          .cfg.ext_zicsr =3D true,
> -        .cfg.pmp =3D true
> +        .cfg.pmp =3D true,
> +        .cfg.pmp_regions =3D 8
>      ),
>
>      DEFINE_ABSTRACT_RISCV_CPU(TYPE_RISCV_CPU_SIFIVE_U, TYPE_RISCV_VENDOR=
_CPU,
> @@ -2948,7 +2991,8 @@ static const TypeInfo riscv_cpu_type_infos[] =3D {
>          .cfg.ext_zifencei =3D true,
>          .cfg.ext_zicsr =3D true,
>          .cfg.mmu =3D true,
> -        .cfg.pmp =3D true
> +        .cfg.pmp =3D true,
> +        .cfg.pmp_regions =3D 8
>      ),
>
>  #if defined(TARGET_RISCV32) || \
> diff --git a/target/riscv/cpu.h b/target/riscv/cpu.h
> index 229ade9ed9..67323a7d9d 100644
> --- a/target/riscv/cpu.h
> +++ b/target/riscv/cpu.h
> @@ -159,7 +159,8 @@ extern RISCVCPUImpliedExtsRule *riscv_multi_ext_impli=
ed_rules[];
>
>  #define MMU_USER_IDX 3
>
> -#define MAX_RISCV_PMPS (16)
> +#define MAX_RISCV_PMPS (64)
> +#define OLD_MAX_RISCV_PMPS (16)
>
>  #if !defined(CONFIG_USER_ONLY)
>  #include "pmp.h"
> diff --git a/target/riscv/cpu_cfg_fields.h.inc b/target/riscv/cpu_cfg_fie=
lds.h.inc
> index 59f134a419..33c4f9bac8 100644
> --- a/target/riscv/cpu_cfg_fields.h.inc
> +++ b/target/riscv/cpu_cfg_fields.h.inc
> @@ -163,6 +163,7 @@ TYPED_FIELD(uint16_t, elen, 0)
>  TYPED_FIELD(uint16_t, cbom_blocksize, 0)
>  TYPED_FIELD(uint16_t, cbop_blocksize, 0)
>  TYPED_FIELD(uint16_t, cboz_blocksize, 0)
> +TYPED_FIELD(uint8_t,  pmp_regions, 0)
>
>  TYPED_FIELD(int8_t, max_satp_mode, -1)
>
> diff --git a/target/riscv/csr.c b/target/riscv/csr.c
> index d6cd441133..6296ecd1e1 100644
> --- a/target/riscv/csr.c
> +++ b/target/riscv/csr.c
> @@ -738,7 +738,10 @@ static RISCVException dbltrp_hmode(CPURISCVState *en=
v, int csrno)
>  static RISCVException pmp(CPURISCVState *env, int csrno)
>  {
>      if (riscv_cpu_cfg(env)->pmp) {
> -        if (csrno <=3D CSR_PMPCFG3) {
> +        int max_pmpcfg =3D (env->priv_ver >=3D PRIV_VERSION_1_12_0) ?
> ++                              CSR_PMPCFG15 : CSR_PMPCFG3;
> +
> +        if (csrno <=3D max_pmpcfg) {
>              uint32_t reg_index =3D csrno - CSR_PMPCFG0;
>
>              /* TODO: RV128 restriction check */
> diff --git a/target/riscv/machine.c b/target/riscv/machine.c
> index c97e9ce9df..1600ec44f0 100644
> --- a/target/riscv/machine.c
> +++ b/target/riscv/machine.c
> @@ -36,8 +36,9 @@ static int pmp_post_load(void *opaque, int version_id)
>      RISCVCPU *cpu =3D opaque;
>      CPURISCVState *env =3D &cpu->env;
>      int i;
> +    uint8_t pmp_regions =3D riscv_cpu_cfg(env)->pmp_regions;
>
> -    for (i =3D 0; i < MAX_RISCV_PMPS; i++) {
> +    for (i =3D 0; i < pmp_regions; i++) {
>          pmp_update_rule_addr(env, i);
>      }
>      pmp_update_rule_nums(env);
> diff --git a/target/riscv/pmp.c b/target/riscv/pmp.c
> index 5af295e410..3540327c9a 100644
> --- a/target/riscv/pmp.c
> +++ b/target/riscv/pmp.c
> @@ -122,7 +122,9 @@ uint32_t pmp_get_num_rules(CPURISCVState *env)
>   */
>  static inline uint8_t pmp_read_cfg(CPURISCVState *env, uint32_t pmp_inde=
x)
>  {
> -    if (pmp_index < MAX_RISCV_PMPS) {
> +    uint8_t pmp_regions =3D riscv_cpu_cfg(env)->pmp_regions;
> +
> +    if (pmp_index < pmp_regions) {
>          return env->pmp_state.pmp[pmp_index].cfg_reg;
>      }
>
> @@ -136,7 +138,9 @@ static inline uint8_t pmp_read_cfg(CPURISCVState *env=
, uint32_t pmp_index)
>   */
>  static bool pmp_write_cfg(CPURISCVState *env, uint32_t pmp_index, uint8_=
t val)
>  {
> -    if (pmp_index < MAX_RISCV_PMPS) {
> +    uint8_t pmp_regions =3D riscv_cpu_cfg(env)->pmp_regions;
> +
> +    if (pmp_index < pmp_regions) {
>          if (env->pmp_state.pmp[pmp_index].cfg_reg =3D=3D val) {
>              /* no change */
>              return false;
> @@ -236,9 +240,10 @@ void pmp_update_rule_addr(CPURISCVState *env, uint32=
_t pmp_index)
>  void pmp_update_rule_nums(CPURISCVState *env)
>  {
>      int i;
> +    uint8_t pmp_regions =3D riscv_cpu_cfg(env)->pmp_regions;
>
>      env->pmp_state.num_rules =3D 0;
> -    for (i =3D 0; i < MAX_RISCV_PMPS; i++) {
> +    for (i =3D 0; i < pmp_regions; i++) {
>          const uint8_t a_field =3D
>              pmp_get_a_field(env->pmp_state.pmp[i].cfg_reg);
>          if (PMP_AMATCH_OFF !=3D a_field) {
> @@ -332,6 +337,7 @@ bool pmp_hart_has_privs(CPURISCVState *env, hwaddr ad=
dr,
>      int pmp_size =3D 0;
>      hwaddr s =3D 0;
>      hwaddr e =3D 0;
> +    uint8_t pmp_regions =3D riscv_cpu_cfg(env)->pmp_regions;
>
>      /* Short cut if no rules */
>      if (0 =3D=3D pmp_get_num_rules(env)) {
> @@ -356,7 +362,7 @@ bool pmp_hart_has_privs(CPURISCVState *env, hwaddr ad=
dr,
>       * 1.10 draft priv spec states there is an implicit order
>       * from low to high
>       */
> -    for (i =3D 0; i < MAX_RISCV_PMPS; i++) {
> +    for (i =3D 0; i < pmp_regions; i++) {
>          s =3D pmp_is_in_range(env, i, addr);
>          e =3D pmp_is_in_range(env, i, addr + pmp_size - 1);
>
> @@ -527,8 +533,9 @@ void pmpaddr_csr_write(CPURISCVState *env, uint32_t a=
ddr_index,
>  {
>      trace_pmpaddr_csr_write(env->mhartid, addr_index, val);
>      bool is_next_cfg_tor =3D false;
> +    uint8_t pmp_regions =3D riscv_cpu_cfg(env)->pmp_regions;
>
> -    if (addr_index < MAX_RISCV_PMPS) {
> +    if (addr_index < pmp_regions) {
>          if (env->pmp_state.pmp[addr_index].addr_reg =3D=3D val) {
>              /* no change */
>              return;
> @@ -538,7 +545,7 @@ void pmpaddr_csr_write(CPURISCVState *env, uint32_t a=
ddr_index,
>           * In TOR mode, need to check the lock bit of the next pmp
>           * (if there is a next).
>           */
> -        if (addr_index + 1 < MAX_RISCV_PMPS) {
> +        if (addr_index + 1 < pmp_regions) {
>              uint8_t pmp_cfg =3D env->pmp_state.pmp[addr_index + 1].cfg_r=
eg;
>              is_next_cfg_tor =3D PMP_AMATCH_TOR =3D=3D pmp_get_a_field(pm=
p_cfg);
>
> @@ -573,8 +580,9 @@ void pmpaddr_csr_write(CPURISCVState *env, uint32_t a=
ddr_index,
>  target_ulong pmpaddr_csr_read(CPURISCVState *env, uint32_t addr_index)
>  {
>      target_ulong val =3D 0;
> +    uint8_t pmp_regions =3D riscv_cpu_cfg(env)->pmp_regions;
>
> -    if (addr_index < MAX_RISCV_PMPS) {
> +    if (addr_index < pmp_regions) {
>          val =3D env->pmp_state.pmp[addr_index].addr_reg;
>          trace_pmpaddr_csr_read(env->mhartid, addr_index, val);
>      } else {
> @@ -592,6 +600,7 @@ void mseccfg_csr_write(CPURISCVState *env, target_ulo=
ng val)
>  {
>      int i;
>      uint64_t mask =3D MSECCFG_MMWP | MSECCFG_MML;
> +    uint8_t pmp_regions =3D riscv_cpu_cfg(env)->pmp_regions;
>      /* Update PMM field only if the value is valid according to Zjpm v1.=
0 */
>      if (riscv_cpu_cfg(env)->ext_smmpm &&
>          riscv_cpu_mxl(env) =3D=3D MXL_RV64 &&
> @@ -603,7 +612,7 @@ void mseccfg_csr_write(CPURISCVState *env, target_ulo=
ng val)
>
>      /* RLB cannot be enabled if it's already 0 and if any regions are lo=
cked */
>      if (!MSECCFG_RLB_ISSET(env)) {
> -        for (i =3D 0; i < MAX_RISCV_PMPS; i++) {
> +        for (i =3D 0; i < pmp_regions; i++) {
>              if (pmp_is_locked(env, i)) {
>                  val &=3D ~MSECCFG_RLB;
>                  break;
> @@ -659,6 +668,7 @@ target_ulong pmp_get_tlb_size(CPURISCVState *env, hwa=
ddr addr)
>      hwaddr tlb_sa =3D addr & ~(TARGET_PAGE_SIZE - 1);
>      hwaddr tlb_ea =3D tlb_sa + TARGET_PAGE_SIZE - 1;
>      int i;
> +    uint8_t pmp_regions =3D riscv_cpu_cfg(env)->pmp_regions;
>
>      /*
>       * If PMP is not supported or there are no PMP rules, the TLB page w=
ill not
> @@ -669,7 +679,7 @@ target_ulong pmp_get_tlb_size(CPURISCVState *env, hwa=
ddr addr)
>          return TARGET_PAGE_SIZE;
>      }
>
> -    for (i =3D 0; i < MAX_RISCV_PMPS; i++) {
> +    for (i =3D 0; i < pmp_regions; i++) {
>          if (pmp_get_a_field(env->pmp_state.pmp[i].cfg_reg) =3D=3D PMP_AM=
ATCH_OFF) {
>              continue;
>          }
> --
> 2.48.1
>
>

