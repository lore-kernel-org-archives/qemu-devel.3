Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0C42CC369AB
	for <qemu-devel@archiver.kernel.org>; Thu, 24 Apr 2025 10:56:05 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u7uF6-0003BQ-Lc; Thu, 24 Apr 2025 06:55:44 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1u7uF3-00039H-Cp; Thu, 24 Apr 2025 06:55:41 -0400
Received: from mail-ua1-x932.google.com ([2607:f8b0:4864:20::932])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1u7uF0-0001SA-TX; Thu, 24 Apr 2025 06:55:41 -0400
Received: by mail-ua1-x932.google.com with SMTP id
 a1e0cc1a2514c-86dde90e7a3so381726241.1; 
 Thu, 24 Apr 2025 03:55:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1745492137; x=1746096937; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=pSy+7jNHCIFVji4+7wYJZAo15hkwjeTWQ/gDvLLY7cQ=;
 b=fKqRnFr5Y79QVZE+zzfSSPviyfNRi7PCM/1cpnqZ93BkpoRmJbktBtDYjiSvmZDC3/
 VU6SLBYRDc4RIHPtxzx60NIOqu6Glk/ZWzZL3Vps4juqSxdgDcVtv2VftkI7VzfwbM9S
 XwF26/eYL44afnQMwRrPZhip7vCUZA9fL0uIpoDJWMQNHXIjWNF5pHdBLtUmlZtn/I+8
 HX/e94vI+RFTzD9F7a+Zc5IBXH3Cwv65sSkrrFb6qVPCjz989DYammIY5Jqz63D8XEwZ
 5YO62wQMxh+pHKN7N5oUDp/kj6Nc47zTUzmWn1K0FdTdLp4z9OF2s4CrfNZGvPIhBlGH
 82fg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1745492137; x=1746096937;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=pSy+7jNHCIFVji4+7wYJZAo15hkwjeTWQ/gDvLLY7cQ=;
 b=C0FwT6Jib/X7R6WsHc9h56THFSytxbg9wxK5Wzzf5jc6Noef2zy77ggB2KJSUYY2Mj
 0uhF7n1eXmqFvvdpbL2uKzgWSZHezI8xmjrgeiEKA54uwV78JXIKnm0PWDQMl0jYlQZO
 YkdXt4qpxljjHpR10BUBHCe6ovLrx64NmOuz2abY6wPzQO26tJZN0ulQuwRhClpryIu+
 lG1SXI53m5mYHMi9OxaHkTPQLBrUofSl02Aocdvlm2BRpsETFaG+hromFrPtPm+6I167
 rkzmuGGgrBg9sPUA9grH3+Npv3BYFpJnbqf5Ph1GJyPzGN6PgyEQrWIdXlePmRrZblGm
 R+6w==
X-Forwarded-Encrypted: i=1;
 AJvYcCVrFxHPU78b18qFhnHjbnJQnl380jPONmtyE3m8i/98eBrhiwnFEf/ymzJIoRn/jVmYqSq+24zHarDt@nongnu.org
X-Gm-Message-State: AOJu0YzUqyDeuen/KlxZxfXnoU6KU/k7Q6jK+MepRO250C7j8FAYfXly
 NR2vN2PWBw5D5XJ2DAbG8xCUwtQeBoCyQd9pfeGteFOp8Kh7bG9v+qNjbE1qBB/dnhuZsBJmJze
 0SkeU++vNpDAOBHpcI3KaVKFuBOY=
X-Gm-Gg: ASbGncuA44/ApHeRtpEfvQCj55eFkDFk3NNPpI+gEs3PYXJmpn9SJ1F/F1MJSfDi7MW
 CB4KDijbkqmeycU7SLTd4/YYUfi0m+lGVx3EyS+XFw0xSEr5mL2jj+C+tKKfszzj5I1EkWnkiwS
 Qr84Xdx+t3Wv26OmiTd8tCjYORlU9wtnaJRiWTJvuKFmj4lQmtwYB4
X-Google-Smtp-Source: AGHT+IGza5+T3h3mhHyNSiGGhaEcb0dNAfU82kvEGYquWm+hvOZghjY8LU8JKBI2Px04AGdwPK6tFXzDI2O19QGGxYc=
X-Received: by 2002:a05:6102:2c8d:b0:4c1:903e:7bed with SMTP id
 ada2fe7eead31-4d38a2395d5mr1616023137.0.1745492137264; Thu, 24 Apr 2025
 03:55:37 -0700 (PDT)
MIME-Version: 1.0
References: <20250421094656.48997-1-jay.chang@sifive.com>
 <20250421094656.48997-3-jay.chang@sifive.com>
In-Reply-To: <20250421094656.48997-3-jay.chang@sifive.com>
From: Alistair Francis <alistair23@gmail.com>
Date: Thu, 24 Apr 2025 20:55:10 +1000
X-Gm-Features: ATxdqUFZ3HeTJD9VF-OGnTCzMRKfmzkCGsVsy7C0RNLWU537eyXBgwjGrjZqCEo
Message-ID: <CAKmqyKM4Si1_gEU37xjqZ-RZ7_B0qwuQXxzieEkDPrDnY9hQ3A@mail.gmail.com>
Subject: Re: [PATCH 2/2] target/riscv: Make PMP region count configurable
To: Jay Chang <jay.chang@sifive.com>
Cc: qemu-devel@nongnu.org, qemu-riscv@nongnu.org, 
 Palmer Dabbelt <palmer@dabbelt.com>,
 Alistair Francis <alistair.francis@wdc.com>, 
 Weiwei Li <liwei1518@gmail.com>,
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>, 
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>, Frank Chang <frank.chang@sifive.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::932;
 envelope-from=alistair23@gmail.com; helo=mail-ua1-x932.google.com
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

On Mon, Apr 21, 2025 at 7:48=E2=80=AFPM Jay Chang <jay.chang@sifive.com> wr=
ote:
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
> Reviewed-by: Frank Chang <frank.chang@sifive.com>
> Signed-off-by: Jay Chang <jay.chang@sifive.com>
> ---
>  target/riscv/cpu.c     | 46 ++++++++++++++++++++++++++++++++++++++++++
>  target/riscv/cpu.h     |  2 +-
>  target/riscv/cpu_cfg.h |  1 +
>  target/riscv/csr.c     |  5 ++++-
>  target/riscv/machine.c |  3 ++-
>  target/riscv/pmp.c     | 28 ++++++++++++++++---------
>  6 files changed, 73 insertions(+), 12 deletions(-)
>
> diff --git a/target/riscv/cpu.c b/target/riscv/cpu.c
> index 09ded6829a..528d77b820 100644
> --- a/target/riscv/cpu.c
> +++ b/target/riscv/cpu.c
> @@ -512,6 +512,7 @@ static void rv64_sifive_u_cpu_init(Object *obj)
>      cpu->cfg.ext_zicsr =3D true;
>      cpu->cfg.mmu =3D true;
>      cpu->cfg.pmp =3D true;
> +    cpu->cfg.pmp_regions =3D 8;
>  }
>
>  static void rv64_sifive_e_cpu_init(Object *obj)
> @@ -529,6 +530,7 @@ static void rv64_sifive_e_cpu_init(Object *obj)
>      cpu->cfg.ext_zifencei =3D true;
>      cpu->cfg.ext_zicsr =3D true;
>      cpu->cfg.pmp =3D true;
> +    cpu->cfg.pmp_regions =3D 8;
>  }
>
>  static void rv64_thead_c906_cpu_init(Object *obj)
> @@ -761,6 +763,7 @@ static void rv32_sifive_u_cpu_init(Object *obj)
>      cpu->cfg.ext_zicsr =3D true;
>      cpu->cfg.mmu =3D true;
>      cpu->cfg.pmp =3D true;
> +    cpu->cfg.pmp_regions =3D 8;
>  }
>
>  static void rv32_sifive_e_cpu_init(Object *obj)
> @@ -778,6 +781,7 @@ static void rv32_sifive_e_cpu_init(Object *obj)
>      cpu->cfg.ext_zifencei =3D true;
>      cpu->cfg.ext_zicsr =3D true;
>      cpu->cfg.pmp =3D true;
> +    cpu->cfg.pmp_regions =3D 8;
>  }
>
>  static void rv32_ibex_cpu_init(Object *obj)
> @@ -1478,6 +1482,7 @@ static void riscv_cpu_init(Object *obj)
>      cpu->cfg.cbom_blocksize =3D 64;
>      cpu->cfg.cbop_blocksize =3D 64;
>      cpu->cfg.cboz_blocksize =3D 64;
> +    cpu->cfg.pmp_regions =3D 16;
>      cpu->env.vext_ver =3D VEXT_VERSION_1_00_0;
>  }

Thanks for the patch

These CPU init properties will need a rebase on:
https://github.com/alistair23/qemu/tree/riscv-to-apply.next

Do you mind rebasing and sending a new version

Alistair

>
> @@ -1935,6 +1940,46 @@ static const PropertyInfo prop_pmp =3D {
>      .set =3D prop_pmp_set,
>  };
>
> +static void prop_num_pmp_regions_set(Object *obj, Visitor *v, const char=
 *name,
> +                                     void *opaque, Error **errp)
> +{
> +    RISCVCPU *cpu =3D RISCV_CPU(obj);
> +    uint16_t value;
> +
> +    visit_type_uint16(v, name, &value, errp);
> +
> +    if (cpu->cfg.pmp_regions !=3D value && riscv_cpu_is_vendor(obj)) {
> +        cpu_set_prop_err(cpu, name, errp);
> +        return;
> +    }
> +
> +    if (cpu->env.priv_ver < PRIV_VERSION_1_12_0 && value > 16) {
> +        error_setg(errp, "Number of PMP regions exceeds maximum availabl=
e");
> +        return;
> +    } else if (value > 64) {
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
> +    uint16_t value =3D RISCV_CPU(obj)->cfg.pmp_regions;
> +
> +    visit_type_uint16(v, name, &value, errp);
> +}
> +
> +static const PropertyInfo prop_num_pmp_regions =3D {
> +    .type =3D "uint16",
> +    .description =3D "num-pmp-regions",
> +    .get =3D prop_num_pmp_regions_get,
> +    .set =3D prop_num_pmp_regions_set,
> +};
> +
>  static int priv_spec_from_str(const char *priv_spec_str)
>  {
>      int priv_version =3D -1;
> @@ -2934,6 +2979,7 @@ static const Property riscv_cpu_properties[] =3D {
>
>      {.name =3D "mmu", .info =3D &prop_mmu},
>      {.name =3D "pmp", .info =3D &prop_pmp},
> +    {.name =3D "num-pmp-regions", .info =3D &prop_num_pmp_regions},
>
>      {.name =3D "priv_spec", .info =3D &prop_priv_spec},
>      {.name =3D "vext_spec", .info =3D &prop_vext_spec},
> diff --git a/target/riscv/cpu.h b/target/riscv/cpu.h
> index 51e49e03de..50d58c15f2 100644
> --- a/target/riscv/cpu.h
> +++ b/target/riscv/cpu.h
> @@ -162,7 +162,7 @@ extern RISCVCPUImpliedExtsRule *riscv_multi_ext_impli=
ed_rules[];
>
>  #define MMU_USER_IDX 3
>
> -#define MAX_RISCV_PMPS (16)
> +#define MAX_RISCV_PMPS (64)
>
>  #if !defined(CONFIG_USER_ONLY)
>  #include "pmp.h"
> diff --git a/target/riscv/cpu_cfg.h b/target/riscv/cpu_cfg.h
> index 8a843482cc..8c805b45f6 100644
> --- a/target/riscv/cpu_cfg.h
> +++ b/target/riscv/cpu_cfg.h
> @@ -189,6 +189,7 @@ struct RISCVCPUConfig {
>      uint16_t cbom_blocksize;
>      uint16_t cbop_blocksize;
>      uint16_t cboz_blocksize;
> +    uint16_t pmp_regions;
>      bool mmu;
>      bool pmp;
>      bool debug;
> diff --git a/target/riscv/csr.c b/target/riscv/csr.c
> index f8f61ffff5..65f91be9c0 100644
> --- a/target/riscv/csr.c
> +++ b/target/riscv/csr.c
> @@ -736,7 +736,10 @@ static RISCVException dbltrp_hmode(CPURISCVState *en=
v, int csrno)
>  static RISCVException pmp(CPURISCVState *env, int csrno)
>  {
>      if (riscv_cpu_cfg(env)->pmp) {
> -        if (csrno <=3D CSR_PMPCFG3) {
> +        uint16_t MAX_PMPCFG =3D (env->priv_ver >=3D PRIV_VERSION_1_12_0)=
 ?
> ++                              CSR_PMPCFG15 : CSR_PMPCFG3;
> +
> +        if (csrno <=3D MAX_PMPCFG) {
>              uint32_t reg_index =3D csrno - CSR_PMPCFG0;
>
>              /* TODO: RV128 restriction check */
> diff --git a/target/riscv/machine.c b/target/riscv/machine.c
> index 889e2b6570..c3e4e78802 100644
> --- a/target/riscv/machine.c
> +++ b/target/riscv/machine.c
> @@ -36,8 +36,9 @@ static int pmp_post_load(void *opaque, int version_id)
>      RISCVCPU *cpu =3D opaque;
>      CPURISCVState *env =3D &cpu->env;
>      int i;
> +    uint16_t pmp_regions =3D riscv_cpu_cfg(env)->pmp_regions;
>
> -    for (i =3D 0; i < MAX_RISCV_PMPS; i++) {
> +    for (i =3D 0; i < pmp_regions; i++) {
>          pmp_update_rule_addr(env, i);
>      }
>      pmp_update_rule_nums(env);
> diff --git a/target/riscv/pmp.c b/target/riscv/pmp.c
> index c685f7f2c5..3439295d41 100644
> --- a/target/riscv/pmp.c
> +++ b/target/riscv/pmp.c
> @@ -121,7 +121,9 @@ uint32_t pmp_get_num_rules(CPURISCVState *env)
>   */
>  static inline uint8_t pmp_read_cfg(CPURISCVState *env, uint32_t pmp_inde=
x)
>  {
> -    if (pmp_index < MAX_RISCV_PMPS) {
> +    uint16_t pmp_regions =3D riscv_cpu_cfg(env)->pmp_regions;
> +
> +    if (pmp_index < pmp_regions) {
>          return env->pmp_state.pmp[pmp_index].cfg_reg;
>      }
>
> @@ -135,7 +137,9 @@ static inline uint8_t pmp_read_cfg(CPURISCVState *env=
, uint32_t pmp_index)
>   */
>  static bool pmp_write_cfg(CPURISCVState *env, uint32_t pmp_index, uint8_=
t val)
>  {
> -    if (pmp_index < MAX_RISCV_PMPS) {
> +    uint16_t pmp_regions =3D riscv_cpu_cfg(env)->pmp_regions;
> +
> +    if (pmp_index < pmp_regions) {
>          if (env->pmp_state.pmp[pmp_index].cfg_reg =3D=3D val) {
>              /* no change */
>              return false;
> @@ -235,9 +239,10 @@ void pmp_update_rule_addr(CPURISCVState *env, uint32=
_t pmp_index)
>  void pmp_update_rule_nums(CPURISCVState *env)
>  {
>      int i;
> +    uint16_t pmp_regions =3D riscv_cpu_cfg(env)->pmp_regions;
>
>      env->pmp_state.num_rules =3D 0;
> -    for (i =3D 0; i < MAX_RISCV_PMPS; i++) {
> +    for (i =3D 0; i < pmp_regions; i++) {
>          const uint8_t a_field =3D
>              pmp_get_a_field(env->pmp_state.pmp[i].cfg_reg);
>          if (PMP_AMATCH_OFF !=3D a_field) {
> @@ -331,6 +336,7 @@ bool pmp_hart_has_privs(CPURISCVState *env, hwaddr ad=
dr,
>      int pmp_size =3D 0;
>      hwaddr s =3D 0;
>      hwaddr e =3D 0;
> +    uint16_t pmp_regions =3D riscv_cpu_cfg(env)->pmp_regions;
>
>      /* Short cut if no rules */
>      if (0 =3D=3D pmp_get_num_rules(env)) {
> @@ -355,7 +361,7 @@ bool pmp_hart_has_privs(CPURISCVState *env, hwaddr ad=
dr,
>       * 1.10 draft priv spec states there is an implicit order
>       * from low to high
>       */
> -    for (i =3D 0; i < MAX_RISCV_PMPS; i++) {
> +    for (i =3D 0; i < pmp_regions; i++) {
>          s =3D pmp_is_in_range(env, i, addr);
>          e =3D pmp_is_in_range(env, i, addr + pmp_size - 1);
>
> @@ -526,8 +532,9 @@ void pmpaddr_csr_write(CPURISCVState *env, uint32_t a=
ddr_index,
>  {
>      trace_pmpaddr_csr_write(env->mhartid, addr_index, val);
>      bool is_next_cfg_tor =3D false;
> +    uint16_t pmp_regions =3D riscv_cpu_cfg(env)->pmp_regions;
>
> -    if (addr_index < MAX_RISCV_PMPS) {
> +    if (addr_index < pmp_regions) {
>          if (env->pmp_state.pmp[addr_index].addr_reg =3D=3D val) {
>              /* no change */
>              return;
> @@ -537,7 +544,7 @@ void pmpaddr_csr_write(CPURISCVState *env, uint32_t a=
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
> @@ -572,8 +579,9 @@ void pmpaddr_csr_write(CPURISCVState *env, uint32_t a=
ddr_index,
>  target_ulong pmpaddr_csr_read(CPURISCVState *env, uint32_t addr_index)
>  {
>      target_ulong val =3D 0;
> +    uint16_t pmp_regions =3D riscv_cpu_cfg(env)->pmp_regions;
>
> -    if (addr_index < MAX_RISCV_PMPS) {
> +    if (addr_index < pmp_regions) {
>          val =3D env->pmp_state.pmp[addr_index].addr_reg;
>          trace_pmpaddr_csr_read(env->mhartid, addr_index, val);
>      } else {
> @@ -591,6 +599,7 @@ void mseccfg_csr_write(CPURISCVState *env, target_ulo=
ng val)
>  {
>      int i;
>      uint64_t mask =3D MSECCFG_MMWP | MSECCFG_MML;
> +    uint16_t pmp_regions =3D riscv_cpu_cfg(env)->pmp_regions;
>      /* Update PMM field only if the value is valid according to Zjpm v1.=
0 */
>      if (riscv_cpu_cfg(env)->ext_smmpm &&
>          riscv_cpu_mxl(env) =3D=3D MXL_RV64 &&
> @@ -602,7 +611,7 @@ void mseccfg_csr_write(CPURISCVState *env, target_ulo=
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
> @@ -658,6 +667,7 @@ target_ulong pmp_get_tlb_size(CPURISCVState *env, hwa=
ddr addr)
>      hwaddr tlb_sa =3D addr & ~(TARGET_PAGE_SIZE - 1);
>      hwaddr tlb_ea =3D tlb_sa + TARGET_PAGE_SIZE - 1;
>      int i;
> +    uint16_t pmp_regions =3D riscv_cpu_cfg(env)->pmp_regions;
>
>      /*
>       * If PMP is not supported or there are no PMP rules, the TLB page w=
ill not
> @@ -668,7 +678,7 @@ target_ulong pmp_get_tlb_size(CPURISCVState *env, hwa=
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

