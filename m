Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BA3D2D24467
	for <qemu-devel@archiver.kernel.org>; Fri, 11 Oct 2024 02:51:38 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sz5jf-0005MT-0w; Thu, 10 Oct 2024 22:50:35 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1sz5jT-0005Lh-Rl; Thu, 10 Oct 2024 22:50:24 -0400
Received: from mail-vk1-xa34.google.com ([2607:f8b0:4864:20::a34])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1sz5jR-0008CI-Sb; Thu, 10 Oct 2024 22:50:23 -0400
Received: by mail-vk1-xa34.google.com with SMTP id
 71dfb90a1353d-50c9feaed3dso447122e0c.1; 
 Thu, 10 Oct 2024 19:50:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1728615020; x=1729219820; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=iNMQkLFk+9ZRIz+MPIM9NUlFmJ4F31yA05yVQR3LYwg=;
 b=XlPyLOqxfzlShuOZSYcURoYGe6HiJ+43FAL6NJHpUePnbFLwsLIAUy38KU7ddbbCAQ
 ItjM3CGT7zMhzEVruihHybK4X6VNNaMt+H4a1DchoOzKIOXiDMxwsrN8p/FqqpGrC7Lj
 S+QS1IsfV4bO0NBhLMrCQIxpQjiX0thNUGsZkqkiXoySHpCV3zNss0CGlIhW7Ymqs3qx
 UME/sePK2QSIb3lS6oRJk4I6D8qO1/QgFlVulmoDekmHFgROuwafTCv+aYa2x9ezabCE
 gkdvkO/9jbGKkxp5yrlRuyZgpyx4l8ph7hrc4ktv8GLDmzGE8ZdPN0c7FJmGWOBby6a8
 hRQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1728615020; x=1729219820;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=iNMQkLFk+9ZRIz+MPIM9NUlFmJ4F31yA05yVQR3LYwg=;
 b=hZRUrdG1gFJyRKyXtV7tNHnv/gmjHITLF3BSYYucGT1IxpSJ2wEA+SRTVzgzKxvV2H
 FZcpwIUUXAZ+UwqlJKr6+it0QmQP0cbN8RAtYLa9BrsFCYvLfu8J01L3tASk9aJ8NMQ7
 01FPBZ9gIvInQ6o0YII4BZSQBuH45HgPjguRWaXwL+aB8Vj9hbaS+G9JU+cfNlT98bN+
 8++bEG9WzwoKo6XDTi8fvkvI9HYReKDoipURrQ6HQG/FnY6KzIpP/5Am6g0R9lWdilcK
 w4lPsiAReWJz8lA2tWKBtw5P3E37PW7Ir1V+E28W06yNVdjH61+ex3B4S9zN/QHJTjs/
 cwWg==
X-Forwarded-Encrypted: i=1;
 AJvYcCUAq49ioPPE0qpSRan9RfzEahsv+RJuDnT1P2jj4MgaeCOS2SNfxm0SnSBdH1CfPcQVMozalYZUVunF@nongnu.org
X-Gm-Message-State: AOJu0YzMP8Cd/y36d0Vgo+vlWPFD25yk3WAe1daAnBPOnxg7XkpnSOhF
 VbsiSx0ZPK95RBphBNMViz8oasdkvx2+FY1PJ441i3UGfz4MrwSFL6WciQGcJjcUKqZO3q+OljU
 i5HHQtrcc4moUkJmxmgg6P8hVBUc=
X-Google-Smtp-Source: AGHT+IFPazW1PRsA3FMK/GLm3JVV11yWM9/seEawjXd0ernluBMZMz7lchWbLqFruIPylDJFO5VMch91xkqwoMNb3kc=
X-Received: by 2002:a05:6122:3b02:b0:50b:c245:a040 with SMTP id
 71dfb90a1353d-50d1f4d8ff7mr577726e0c.7.1728615019996; Thu, 10 Oct 2024
 19:50:19 -0700 (PDT)
MIME-Version: 1.0
References: <20240925115808.77874-1-cleger@rivosinc.com>
 <20240925115808.77874-2-cleger@rivosinc.com>
In-Reply-To: <20240925115808.77874-2-cleger@rivosinc.com>
From: Alistair Francis <alistair23@gmail.com>
Date: Fri, 11 Oct 2024 12:49:53 +1000
Message-ID: <CAKmqyKO7N6zr9Fa2-sufdtxPobdPUWqkis9iMEY47C3HPmzFnw@mail.gmail.com>
Subject: Re: [PATCH v2 1/8] target/riscv: Add Ssdbltrp CSRs handling
To: =?UTF-8?B?Q2zDqW1lbnQgTMOpZ2Vy?= <cleger@rivosinc.com>
Cc: qemu-riscv@nongnu.org, Palmer Dabbelt <palmer@dabbelt.com>, 
 Alistair Francis <alistair.francis@wdc.com>, Bin Meng <bin.meng@windriver.com>,
 Weiwei Li <liwei1518@gmail.com>,
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>, 
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>, Ved Shanbhogue <ved@rivosinc.com>, 
 Atish Patra <atishp@rivosinc.com>, qemu-devel@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::a34;
 envelope-from=alistair23@gmail.com; helo=mail-vk1-xa34.google.com
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

On Wed, Sep 25, 2024 at 10:02=E2=80=AFPM Cl=C3=A9ment L=C3=A9ger <cleger@ri=
vosinc.com> wrote:
>
> Add ext_ssdbltrp in RISCVCPUConfig and implement MSTATUS.SDT,
> {H|M}ENVCFG.DTE and modify the availability of MTVAL2 based on the
> presence of the Ssdbltrp ISA extension.
>
> Signed-off-by: Cl=C3=A9ment L=C3=A9ger <cleger@rivosinc.com>

Reviewed-by: Alistair Francis <alistair.francis@wdc.com>

Alistair

> ---
>  target/riscv/cpu.h        |  1 +
>  target/riscv/cpu_bits.h   |  6 ++++++
>  target/riscv/cpu_cfg.h    |  1 +
>  target/riscv/cpu_helper.c | 16 ++++++++++++++
>  target/riscv/csr.c        | 45 ++++++++++++++++++++++++++++++---------
>  5 files changed, 59 insertions(+), 10 deletions(-)
>
> diff --git a/target/riscv/cpu.h b/target/riscv/cpu.h
> index a84e719d3f..ee984bf270 100644
> --- a/target/riscv/cpu.h
> +++ b/target/riscv/cpu.h
> @@ -553,6 +553,7 @@ void riscv_cpu_set_geilen(CPURISCVState *env, target_=
ulong geilen);
>  bool riscv_cpu_vector_enabled(CPURISCVState *env);
>  void riscv_cpu_set_virt_enabled(CPURISCVState *env, bool enable);
>  int riscv_env_mmu_index(CPURISCVState *env, bool ifetch);
> +bool riscv_env_smode_dbltrp_enabled(CPURISCVState *env, bool virt);
>  G_NORETURN void  riscv_cpu_do_unaligned_access(CPUState *cs, vaddr addr,
>                                                 MMUAccessType access_type=
,
>                                                 int mmu_idx, uintptr_t re=
taddr);
> diff --git a/target/riscv/cpu_bits.h b/target/riscv/cpu_bits.h
> index da1723496c..3a5588d4df 100644
> --- a/target/riscv/cpu_bits.h
> +++ b/target/riscv/cpu_bits.h
> @@ -558,6 +558,7 @@
>  #define MSTATUS_TVM         0x00100000 /* since: priv-1.10 */
>  #define MSTATUS_TW          0x00200000 /* since: priv-1.10 */
>  #define MSTATUS_TSR         0x00400000 /* since: priv-1.10 */
> +#define MSTATUS_SDT         0x01000000
>  #define MSTATUS_GVA         0x4000000000ULL
>  #define MSTATUS_MPV         0x8000000000ULL
>
> @@ -588,6 +589,7 @@ typedef enum {
>  #define SSTATUS_XS          0x00018000
>  #define SSTATUS_SUM         0x00040000 /* since: priv-1.10 */
>  #define SSTATUS_MXR         0x00080000
> +#define SSTATUS_SDT         0x01000000
>
>  #define SSTATUS64_UXL       0x0000000300000000ULL
>
> @@ -777,11 +779,13 @@ typedef enum RISCVException {
>  #define MENVCFG_CBIE                       (3UL << 4)
>  #define MENVCFG_CBCFE                      BIT(6)
>  #define MENVCFG_CBZE                       BIT(7)
> +#define MENVCFG_DTE                        (1ULL << 59)
>  #define MENVCFG_ADUE                       (1ULL << 61)
>  #define MENVCFG_PBMTE                      (1ULL << 62)
>  #define MENVCFG_STCE                       (1ULL << 63)
>
>  /* For RV32 */
> +#define MENVCFGH_DTE                       BIT(27)
>  #define MENVCFGH_ADUE                      BIT(29)
>  #define MENVCFGH_PBMTE                     BIT(30)
>  #define MENVCFGH_STCE                      BIT(31)
> @@ -795,11 +799,13 @@ typedef enum RISCVException {
>  #define HENVCFG_CBIE                       MENVCFG_CBIE
>  #define HENVCFG_CBCFE                      MENVCFG_CBCFE
>  #define HENVCFG_CBZE                       MENVCFG_CBZE
> +#define HENVCFG_DTE                        MENVCFG_DTE
>  #define HENVCFG_ADUE                       MENVCFG_ADUE
>  #define HENVCFG_PBMTE                      MENVCFG_PBMTE
>  #define HENVCFG_STCE                       MENVCFG_STCE
>
>  /* For RV32 */
> +#define HENVCFGH_DTE                        MENVCFGH_DTE
>  #define HENVCFGH_ADUE                       MENVCFGH_ADUE
>  #define HENVCFGH_PBMTE                      MENVCFGH_PBMTE
>  #define HENVCFGH_STCE                       MENVCFGH_STCE
> diff --git a/target/riscv/cpu_cfg.h b/target/riscv/cpu_cfg.h
> index ae2a945b5f..dd804f95d4 100644
> --- a/target/riscv/cpu_cfg.h
> +++ b/target/riscv/cpu_cfg.h
> @@ -77,6 +77,7 @@ struct RISCVCPUConfig {
>      bool ext_smstateen;
>      bool ext_sstc;
>      bool ext_smcntrpmf;
> +    bool ext_ssdbltrp;
>      bool ext_svadu;
>      bool ext_svinval;
>      bool ext_svnapot;
> diff --git a/target/riscv/cpu_helper.c b/target/riscv/cpu_helper.c
> index 9d0400035f..395d8235ce 100644
> --- a/target/riscv/cpu_helper.c
> +++ b/target/riscv/cpu_helper.c
> @@ -63,6 +63,22 @@ int riscv_env_mmu_index(CPURISCVState *env, bool ifetc=
h)
>  #endif
>  }
>
> +bool riscv_env_smode_dbltrp_enabled(CPURISCVState *env, bool virt)
> +{
> +#ifdef CONFIG_USER_ONLY
> +    return false;
> +#else
> +    if (!riscv_cpu_cfg(env)->ext_ssdbltrp) {
> +        return false;
> +    }
> +    if (virt) {
> +        return (env->henvcfg & HENVCFG_DTE) !=3D 0;
> +    } else {
> +        return (env->menvcfg & MENVCFG_DTE) !=3D 0;
> +    }
> +#endif
> +}
> +
>  void cpu_get_tb_cpu_state(CPURISCVState *env, vaddr *pc,
>                            uint64_t *cs_base, uint32_t *pflags)
>  {
> diff --git a/target/riscv/csr.c b/target/riscv/csr.c
> index e5de72453c..d8280ec956 100644
> --- a/target/riscv/csr.c
> +++ b/target/riscv/csr.c
> @@ -540,6 +540,15 @@ static RISCVException aia_hmode32(CPURISCVState *env=
, int csrno)
>      return hmode32(env, csrno);
>  }
>
> +static RISCVException dbltrp_hmode(CPURISCVState *env, int csrno)
> +{
> +    if (riscv_cpu_cfg(env)->ext_ssdbltrp) {
> +        return RISCV_EXCP_NONE;
> +    }
> +
> +    return hmode(env, csrno);
> +}
> +
>  static RISCVException pmp(CPURISCVState *env, int csrno)
>  {
>      if (riscv_cpu_cfg(env)->pmp) {
> @@ -1402,7 +1411,7 @@ static const target_ulong vs_delegable_excps =3D DE=
LEGABLE_EXCPS &
>        (1ULL << (RISCV_EXCP_STORE_GUEST_AMO_ACCESS_FAULT)));
>  static const target_ulong sstatus_v1_10_mask =3D SSTATUS_SIE | SSTATUS_S=
PIE |
>      SSTATUS_UIE | SSTATUS_UPIE | SSTATUS_SPP | SSTATUS_FS | SSTATUS_XS |
> -    SSTATUS_SUM | SSTATUS_MXR | SSTATUS_VS;
> +    SSTATUS_SUM | SSTATUS_MXR | SSTATUS_VS | SSTATUS_SDT;
>
>  /*
>   * Spec allows for bits 13:63 to be either read-only or writable.
> @@ -1600,6 +1609,14 @@ static RISCVException write_mstatus(CPURISCVState =
*env, int csrno,
>          mask |=3D MSTATUS_VS;
>      }
>
> +    if (riscv_env_smode_dbltrp_enabled(env, env->virt_enabled)) {
> +        mask |=3D MSTATUS_SDT;
> +        if ((val & MSTATUS_SDT) !=3D 0) {
> +            mstatus &=3D ~MSTATUS_SIE;
> +            val &=3D ~MSTATUS_SIE;
> +        }
> +    }
> +
>      if (xl !=3D MXL_RV32 || env->debugger) {
>          if (riscv_has_ext(env, RVH)) {
>              mask |=3D MSTATUS_MPV | MSTATUS_GVA;
> @@ -2354,7 +2371,8 @@ static RISCVException write_menvcfg(CPURISCVState *=
env, int csrno,
>      if (riscv_cpu_mxl(env) =3D=3D MXL_RV64) {
>          mask |=3D (cfg->ext_svpbmt ? MENVCFG_PBMTE : 0) |
>                  (cfg->ext_sstc ? MENVCFG_STCE : 0) |
> -                (cfg->ext_svadu ? MENVCFG_ADUE : 0);
> +                (cfg->ext_svadu ? MENVCFG_ADUE : 0) |
> +                (cfg->ext_ssdbltrp ? MENVCFG_DTE : 0);
>      }
>      env->menvcfg =3D (env->menvcfg & ~mask) | (val & mask);
>
> @@ -2374,7 +2392,8 @@ static RISCVException write_menvcfgh(CPURISCVState =
*env, int csrno,
>      const RISCVCPUConfig *cfg =3D riscv_cpu_cfg(env);
>      uint64_t mask =3D (cfg->ext_svpbmt ? MENVCFG_PBMTE : 0) |
>                      (cfg->ext_sstc ? MENVCFG_STCE : 0) |
> -                    (cfg->ext_svadu ? MENVCFG_ADUE : 0);
> +                    (cfg->ext_svadu ? MENVCFG_ADUE : 0) |
> +                    (cfg->ext_ssdbltrp ? MENVCFG_DTE : 0);
>      uint64_t valh =3D (uint64_t)val << 32;
>
>      env->menvcfg =3D (env->menvcfg & ~mask) | (valh & mask);
> @@ -2425,9 +2444,10 @@ static RISCVException read_henvcfg(CPURISCVState *=
env, int csrno,
>       * henvcfg.pbmte is read_only 0 when menvcfg.pbmte =3D 0
>       * henvcfg.stce is read_only 0 when menvcfg.stce =3D 0
>       * henvcfg.adue is read_only 0 when menvcfg.adue =3D 0
> +     * henvcfg.dte is read_only 0 when menvcfg.dte =3D 0
>       */
> -    *val =3D env->henvcfg & (~(HENVCFG_PBMTE | HENVCFG_STCE | HENVCFG_AD=
UE) |
> -                           env->menvcfg);
> +    *val =3D env->henvcfg & (~(HENVCFG_PBMTE | HENVCFG_STCE | HENVCFG_AD=
UE |
> +                             HENVCFG_DTE) | env->menvcfg);
>      return RISCV_EXCP_NONE;
>  }
>
> @@ -2435,6 +2455,7 @@ static RISCVException write_henvcfg(CPURISCVState *=
env, int csrno,
>                                      target_ulong val)
>  {
>      uint64_t mask =3D HENVCFG_FIOM | HENVCFG_CBIE | HENVCFG_CBCFE | HENV=
CFG_CBZE;
> +    uint64_t menvcfg_mask;
>      RISCVException ret;
>
>      ret =3D smstateen_acc_ok(env, 0, SMSTATEEN0_HSENVCFG);
> @@ -2443,7 +2464,11 @@ static RISCVException write_henvcfg(CPURISCVState =
*env, int csrno,
>      }
>
>      if (riscv_cpu_mxl(env) =3D=3D MXL_RV64) {
> -        mask |=3D env->menvcfg & (HENVCFG_PBMTE | HENVCFG_STCE | HENVCFG=
_ADUE);
> +        menvcfg_mask =3D HENVCFG_PBMTE | HENVCFG_STCE | HENVCFG_ADUE;
> +        if (riscv_cpu_cfg(env)->ext_ssdbltrp) {
> +            menvcfg_mask |=3D HENVCFG_DTE;
> +        }
> +        mask |=3D env->menvcfg & menvcfg_mask;
>      }
>
>      env->henvcfg =3D (env->henvcfg & ~mask) | (val & mask);
> @@ -2461,8 +2486,8 @@ static RISCVException read_henvcfgh(CPURISCVState *=
env, int csrno,
>          return ret;
>      }
>
> -    *val =3D (env->henvcfg & (~(HENVCFG_PBMTE | HENVCFG_STCE | HENVCFG_A=
DUE) |
> -                            env->menvcfg)) >> 32;
> +    *val =3D (env->henvcfg & (~(HENVCFG_PBMTE | HENVCFG_STCE | HENVCFG_A=
DUE |
> +                              HENVCFG_DTE) | env->menvcfg)) >> 32;
>      return RISCV_EXCP_NONE;
>  }
>
> @@ -2470,7 +2495,7 @@ static RISCVException write_henvcfgh(CPURISCVState =
*env, int csrno,
>                                       target_ulong val)
>  {
>      uint64_t mask =3D env->menvcfg & (HENVCFG_PBMTE | HENVCFG_STCE |
> -                                    HENVCFG_ADUE);
> +                                    HENVCFG_ADUE | HENVCFG_DTE);
>      uint64_t valh =3D (uint64_t)val << 32;
>      RISCVException ret;
>
> @@ -5246,7 +5271,7 @@ riscv_csr_operations csr_ops[CSR_TABLE_SIZE] =3D {
>      [CSR_VSATP]       =3D { "vsatp",       hmode,   read_vsatp,    write=
_vsatp,
>                            .min_priv_ver =3D PRIV_VERSION_1_12_0         =
       },
>
> -    [CSR_MTVAL2]      =3D { "mtval2",      hmode,   read_mtval2,   write=
_mtval2,
> +    [CSR_MTVAL2]      =3D { "mtval2", dbltrp_hmode, read_mtval2, write_m=
tval2,
>                            .min_priv_ver =3D PRIV_VERSION_1_12_0         =
       },
>      [CSR_MTINST]      =3D { "mtinst",      hmode,   read_mtinst,   write=
_mtinst,
>                            .min_priv_ver =3D PRIV_VERSION_1_12_0         =
       },
> --
> 2.45.2
>
>

