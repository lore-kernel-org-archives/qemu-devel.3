Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 941EDC5320E
	for <qemu-devel@archiver.kernel.org>; Tue, 27 Aug 2024 05:35:56 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1siore-0001zp-Fo; Tue, 27 Aug 2024 01:35:34 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <tommy.wu@sifive.com>)
 id 1siorX-0001h4-Vr
 for qemu-devel@nongnu.org; Tue, 27 Aug 2024 01:35:28 -0400
Received: from mail-wr1-x42a.google.com ([2a00:1450:4864:20::42a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <tommy.wu@sifive.com>)
 id 1siorU-0007Nu-76
 for qemu-devel@nongnu.org; Tue, 27 Aug 2024 01:35:27 -0400
Received: by mail-wr1-x42a.google.com with SMTP id
 ffacd0b85a97d-371afae614aso2684153f8f.0
 for <qemu-devel@nongnu.org>; Mon, 26 Aug 2024 22:35:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sifive.com; s=google; t=1724736922; x=1725341722; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=00wrBqkgzvtjcWbL8c3stMd47XvQ4h4z+fSZwtT69Dw=;
 b=ZBvAhCjfZ2ay4BueT5dw3w8gFkd/IdoapJzU5EkvzzYjRmi9lY6Dso46VnZAp0IKIz
 5Ll6+aROWMw3E8Kt2i5gZWf+UXzXzzHMfBryinvfVS81PWmiRTDMyeX+fFe6PQ57vNeJ
 eXEHXYknnKCe63sZat3tnRe6CjPGu/KWIRq4vwgDaUjxENLAVR87spnlZJIGcDiDuIH6
 v9nhPBD1zt4djsFrKCI8b6yyV70Kp8sWgavHinBralr0WKj5miuO+yJaD+chVSKlatHA
 LFXdfVVYu9EY0yxtwD01GlCerMgsLODCoy9+msKn/UAuLe7yAzsoqic/Yyrn3yIItqAq
 p4eg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1724736922; x=1725341722;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=00wrBqkgzvtjcWbL8c3stMd47XvQ4h4z+fSZwtT69Dw=;
 b=dofruGAnbOP4tR6ihUDE81aLqPFLpuFuKDBvd+8BBPitpqWs8tb6hrdf08Ce5gn77l
 04wXURQevJ0DMfUNvmeIpMnE0yE81cXXcF7TBXV4WSJuAtyumRyEX+FkyTWtRKLJ3xfr
 w4VuC1SROtnccr22UU61g2uPihgoebv12mtIE3lxV2ChMGLpJZzSoQs06Clhnr7QDf0I
 kDYpLBRqOEt1hCQu52Euc7gxvhA6bQGOlQLETqDsa9/8m4s5WIZz6LBgXEWyQnBJ4SM1
 i1Rc5bC+Glvjly1EgW0fMWsWroB9JtsHoSvYClG9M/C3E8L+ILmb6LaYl6LRCRilsrRG
 v+5Q==
X-Forwarded-Encrypted: i=1;
 AJvYcCWYNFa0iGAs4k3Aj2ylvH6Yx9nLPSW8jOg7VVNGb0YblPpnXqsmkyoCaaODr6z+CDFu0w42/+jnqZfh@nongnu.org
X-Gm-Message-State: AOJu0YxsIN/4XVkdKxTzopT6qOBcwIphp3uLHdfVS+9uAfkvZofzII+P
 lXg96m1p5/v2tYKqRpAgSBltlxtoI3T0h9va3GnZKtg3gNEqGXd1+PjqW11/Xa0M/qRa6xCGFAF
 IXIXmVTDE7pjWBPnWtM+zENoFjbAajIUgfQ99Gw==
X-Google-Smtp-Source: AGHT+IHWMSF5zXdSwNM4syXNuM+VmmSZQAQzSUeWudbMeXtr3yZMD8pQBhvkzqboLcT/okAEPfQbv34fvcgfsBGzZ/Q=
X-Received: by 2002:a05:6000:402a:b0:368:3717:10c7 with SMTP id
 ffacd0b85a97d-37311841b20mr9362556f8f.4.1724736921876; Mon, 26 Aug 2024
 22:35:21 -0700 (PDT)
MIME-Version: 1.0
References: <20240418133916.1442471-1-cleger@rivosinc.com>
 <20240418133916.1442471-3-cleger@rivosinc.com>
In-Reply-To: <20240418133916.1442471-3-cleger@rivosinc.com>
From: Tommy Wu <tommy.wu@sifive.com>
Date: Tue, 27 Aug 2024 13:35:10 +0800
Message-ID: <CANj3q_nMox8vyFJQKgchDiLpamytyog8Wq7iNYTe_W6Mmj=ADw@mail.gmail.com>
Subject: Re: [RFC PATCH 2/3] target/riscv: add Ssdbltrp extension support
To: =?UTF-8?B?Q2zDqW1lbnQgTMOpZ2Vy?= <cleger@rivosinc.com>
Cc: qemu-riscv@nongnu.org, Palmer Dabbelt <palmer@dabbelt.com>, 
 Alistair Francis <alistair.francis@wdc.com>, Bin Meng <bin.meng@windriver.com>,
 Weiwei Li <liwei1518@gmail.com>,
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>, 
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>, Ved Shanbhogue <ved@rivosinc.com>, 
 Atish Patra <atishp@rivosinc.com>, qemu-devel@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::42a;
 envelope-from=tommy.wu@sifive.com; helo=mail-wr1-x42a.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
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

On Thu, Apr 18, 2024 at 9:40=E2=80=AFPM Cl=C3=A9ment L=C3=A9ger <cleger@riv=
osinc.com> wrote:
>
> The Ssdbltrp extension allows handling trap when being in non-reentrant
> state (mainly during exception handling) for S-mode [1]. This patch add
> support for this extension as an experimental extension.
>
> Link: https://github.com/riscv/riscv-double-trap/releases/download/v0.56/=
riscv-double-trap.pdf [1]
> Signed-off-by: Cl=C3=A9ment L=C3=A9ger <cleger@rivosinc.com>
> ---
>  target/riscv/cpu.c        |  4 ++-
>  target/riscv/cpu.h        |  1 +
>  target/riscv/cpu_bits.h   |  7 +++++
>  target/riscv/cpu_cfg.h    |  1 +
>  target/riscv/cpu_helper.c | 60 ++++++++++++++++++++++++++++++++++-----
>  target/riscv/csr.c        | 44 +++++++++++++++++++++-------
>  target/riscv/op_helper.c  | 11 +++++++
>  7 files changed, 110 insertions(+), 18 deletions(-)
>
> diff --git a/target/riscv/cpu.c b/target/riscv/cpu.c
> index 36e3e5fdaf..d159b0c6b6 100644
> --- a/target/riscv/cpu.c
> +++ b/target/riscv/cpu.c
> @@ -182,6 +182,7 @@ const RISCVIsaExtData isa_edata_arr[] =3D {
>      ISA_EXT_DATA_ENTRY(ssccptr, PRIV_VERSION_1_11_0, has_priv_1_11),
>      ISA_EXT_DATA_ENTRY(sscofpmf, PRIV_VERSION_1_12_0, ext_sscofpmf),
>      ISA_EXT_DATA_ENTRY(sscounterenw, PRIV_VERSION_1_12_0, has_priv_1_12)=
,
> +    ISA_EXT_DATA_ENTRY(ssdbltrp, PRIV_VERSION_1_12_0, ext_ssdbltrp),
>      ISA_EXT_DATA_ENTRY(sstc, PRIV_VERSION_1_12_0, ext_sstc),
>      ISA_EXT_DATA_ENTRY(sstvala, PRIV_VERSION_1_12_0, has_priv_1_12),
>      ISA_EXT_DATA_ENTRY(sstvecd, PRIV_VERSION_1_12_0, has_priv_1_12),
> @@ -276,7 +277,7 @@ static const char * const riscv_excp_names[] =3D {
>      "load_page_fault",
>      "reserved",
>      "store_page_fault",
> -    "reserved",
> +    "double_trap",
>      "reserved",
>      "reserved",
>      "reserved",
> @@ -1572,6 +1573,7 @@ const RISCVCPUMultiExtConfig riscv_cpu_vendor_exts[=
] =3D {
>
>  /* These are experimental so mark with 'x-' */
>  const RISCVCPUMultiExtConfig riscv_cpu_experimental_exts[] =3D {
> +    MULTI_EXT_CFG_BOOL("x-ssdbltrp", ext_ssdbltrp, false),
>      DEFINE_PROP_END_OF_LIST(),
>  };
>
> diff --git a/target/riscv/cpu.h b/target/riscv/cpu.h
> index 3b1a02b944..14f83d4f05 100644
> --- a/target/riscv/cpu.h
> +++ b/target/riscv/cpu.h
> @@ -505,6 +505,7 @@ void riscv_cpu_set_geilen(CPURISCVState *env, target_=
ulong geilen);
>  bool riscv_cpu_vector_enabled(CPURISCVState *env);
>  void riscv_cpu_set_virt_enabled(CPURISCVState *env, bool enable);
>  int riscv_env_mmu_index(CPURISCVState *env, bool ifetch);
> +bool riscv_env_smode_dbltrp_enabled(CPURISCVState *env);
>  G_NORETURN void  riscv_cpu_do_unaligned_access(CPUState *cs, vaddr addr,
>                                                 MMUAccessType access_type=
,
>                                                 int mmu_idx, uintptr_t re=
taddr);
> diff --git a/target/riscv/cpu_bits.h b/target/riscv/cpu_bits.h
> index 9ade72ff31..494a036f6e 100644
> --- a/target/riscv/cpu_bits.h
> +++ b/target/riscv/cpu_bits.h
> @@ -542,6 +542,7 @@
>  #define MSTATUS_TVM         0x00100000 /* since: priv-1.10 */
>  #define MSTATUS_TW          0x00200000 /* since: priv-1.10 */
>  #define MSTATUS_TSR         0x00400000 /* since: priv-1.10 */
> +#define MSTATUS_SDT         0x01000000 /* Ssdbltrp extension */
>  #define MSTATUS_GVA         0x4000000000ULL
>  #define MSTATUS_MPV         0x8000000000ULL
>
> @@ -572,6 +573,7 @@ typedef enum {
>  #define SSTATUS_XS          0x00018000
>  #define SSTATUS_SUM         0x00040000 /* since: priv-1.10 */
>  #define SSTATUS_MXR         0x00080000
> +#define SSTATUS_SDT         0x01000000 /* Ssdbltrp extension */
>
>  #define SSTATUS64_UXL       0x0000000300000000ULL
>
> @@ -670,6 +672,7 @@ typedef enum RISCVException {
>      RISCV_EXCP_INST_PAGE_FAULT =3D 0xc, /* since: priv-1.10.0 */
>      RISCV_EXCP_LOAD_PAGE_FAULT =3D 0xd, /* since: priv-1.10.0 */
>      RISCV_EXCP_STORE_PAGE_FAULT =3D 0xf, /* since: priv-1.10.0 */
> +    RISCV_EXCP_DOUBLE_TRAP =3D 0x10, /* Ssdbltrp extension */
>      RISCV_EXCP_SEMIHOST =3D 0x11,
>      RISCV_EXCP_INST_GUEST_PAGE_FAULT =3D 0x14,
>      RISCV_EXCP_LOAD_GUEST_ACCESS_FAULT =3D 0x15,
> @@ -744,11 +747,13 @@ typedef enum RISCVException {
>  #define MENVCFG_CBIE                       (3UL << 4)
>  #define MENVCFG_CBCFE                      BIT(6)
>  #define MENVCFG_CBZE                       BIT(7)
> +#define MENVCFG_DTE                        (1ULL << 59) /* Ssdbltrp exte=
nsion */
>  #define MENVCFG_ADUE                       (1ULL << 61)
>  #define MENVCFG_PBMTE                      (1ULL << 62)
>  #define MENVCFG_STCE                       (1ULL << 63)
>
>  /* For RV32 */
> +#define MENVCFGH_DTE                       BIT(27) /* Ssdbltrp extension=
 */
>  #define MENVCFGH_ADUE                      BIT(29)
>  #define MENVCFGH_PBMTE                     BIT(30)
>  #define MENVCFGH_STCE                      BIT(31)
> @@ -762,11 +767,13 @@ typedef enum RISCVException {
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
> index cb750154bd..a149c08167 100644
> --- a/target/riscv/cpu_cfg.h
> +++ b/target/riscv/cpu_cfg.h
> @@ -74,6 +74,7 @@ struct RISCVCPUConfig {
>      bool ext_ztso;
>      bool ext_smstateen;
>      bool ext_sstc;
> +    bool ext_ssdbltrp;
>      bool ext_svadu;
>      bool ext_svinval;
>      bool ext_svnapot;
> diff --git a/target/riscv/cpu_helper.c b/target/riscv/cpu_helper.c
> index fc090d729a..3d747e5bfc 100644
> --- a/target/riscv/cpu_helper.c
> +++ b/target/riscv/cpu_helper.c
> @@ -62,6 +62,15 @@ int riscv_env_mmu_index(CPURISCVState *env, bool ifetc=
h)
>  #endif
>  }
>
> +bool riscv_env_smode_dbltrp_enabled(CPURISCVState *env)
> +{
> +    if (env->virt_enabled) {
> +        return (env->henvcfg & HENVCFG_DTE) !=3D 0;
> +    } else {
> +        return (env->menvcfg & MENVCFG_DTE) !=3D 0;
> +    }
> +}
> +

It seems that we need to add the `#ifdef CONFIG_USER_ONLY`
like
````````
bool riscv_env_smode_dbltrp_enabled(CPURISCVState *env)
{
#ifdef CONFIG_USER_ONLY
    return false;
#else
    if (!riscv_cpu_cfg(env)->ext_ssdbltrp) {
        return false;
    }
    if (env->virt_enabled) {
        return (env->henvcfg & HENVCFG_DTE) !=3D 0;
    } else {
        return (env->menvcfg & MENVCFG_DTE) !=3D 0;
    }
#endif
}
````````

If we don't do this, it seems that we will get a build failure when
we try to build user mode QEMU.

>  void cpu_get_tb_cpu_state(CPURISCVState *env, vaddr *pc,
>                            uint64_t *cs_base, uint32_t *pflags)
>  {
> @@ -544,7 +553,12 @@ void riscv_cpu_swap_hypervisor_regs(CPURISCVState *e=
nv)
>          mstatus_mask |=3D MSTATUS_FS;
>      }
>      bool current_virt =3D env->virt_enabled;
> +    uint64_t dte =3D current_virt ? env->menvcfg & MENVCFG_DTE :
> +                                  env->henvcfg & HENVCFG_DTE;
>
> +    if (riscv_cpu_cfg(env)->ext_ssdbltrp && dte) {
> +                mstatus_mask |=3D MSTATUS_SDT;
> +    }
Nit: Indent issue.

>      g_assert(riscv_has_ext(env, RVH));
>
>      if (current_virt) {
> @@ -1648,7 +1662,10 @@ void riscv_cpu_do_interrupt(CPUState *cs)
>
>      RISCVCPU *cpu =3D RISCV_CPU(cs);
>      CPURISCVState *env =3D &cpu->env;
> +    const RISCVCPUConfig *cfg =3D riscv_cpu_cfg(env);
>      bool write_gva =3D false;
> +    bool smode_exception;
> +    bool vsmode_exception;
>      uint64_t s;
>
>      /*
> @@ -1662,6 +1679,8 @@ void riscv_cpu_do_interrupt(CPUState *cs)
>          !(env->mip & (1 << cause));
>      bool vs_injected =3D env->hvip & (1 << cause) & env->hvien &&
>          !(env->mip & (1 << cause));
> +    bool smode_double_trap =3D false;
> +    uint64_t hdeleg =3D async ? env->hideleg : env->hedeleg;
>      target_ulong tval =3D 0;
>      target_ulong tinst =3D 0;
>      target_ulong htval =3D 0;
> @@ -1750,14 +1769,33 @@ void riscv_cpu_do_interrupt(CPUState *cs)
>                    __func__, env->mhartid, async, cause, env->pc, tval,
>                    riscv_cpu_get_trap_name(cause, async));
>
> -    if (env->priv <=3D PRV_S && cause < 64 &&
> -        (((deleg >> cause) & 1) || s_injected || vs_injected)) {
> -        /* handle the trap in S-mode */
> +    smode_exception =3D env->priv <=3D PRV_S && cause < 64 &&
> +                      (((deleg >> cause) & 1) || s_injected || vs_inject=
ed);
> +    vsmode_exception =3D env->virt_enabled &&
> +                       (((hdeleg >> cause) & 1) || vs_injected);
> +    /* Check S-mode double trap condition */
> +    if (cfg->ext_ssdbltrp && smode_exception) {
> +        uint64_t dte =3D env->menvcfg & MENVCFG_DTE;
>          if (riscv_has_ext(env, RVH)) {
> -            uint64_t hdeleg =3D async ? env->hideleg : env->hedeleg;
> +            if (vsmode_exception) {
> +                /* Trap to VS mode, use henvcfg instead of menvcfg*/
Nit: indent issue.

> +                dte =3D env->henvcfg & HENVCFG_DTE;
> +            } else if (env->virt_enabled) {
> +                /* Trap into HS mode, from virt
> +                 * We can not have a double trap when switching from one=
 mode to
> +                 * another since sret clears the SDT flag, so when trapp=
ing in
> +                 * S-mode, SDT is cleared
> +                 * */
Nit: indent issue

> +                dte =3D 0;
> +            }
> +        }
> +        smode_double_trap =3D dte && (env->mstatus & MSTATUS_SDT);
> +    }
>
> -            if (env->virt_enabled &&
> -                (((hdeleg >> cause) & 1) || vs_injected)) {
> +    if (smode_exception && !smode_double_trap) {
> +        /* handle the trap in S-mode */
> +        if (riscv_has_ext(env, RVH)) {
> +            if (vsmode_exception) {
>                  /* Trap to VS mode */
>                  /*
>                   * See if we need to adjust cause. Yes if its VS mode in=
terrupt
> @@ -1790,6 +1828,9 @@ void riscv_cpu_do_interrupt(CPUState *cs)
>          s =3D set_field(s, MSTATUS_SPIE, get_field(s, MSTATUS_SIE));
>          s =3D set_field(s, MSTATUS_SPP, env->priv);
>          s =3D set_field(s, MSTATUS_SIE, 0);
> +        if (riscv_env_smode_dbltrp_enabled(env)) {
> +            s =3D set_field(s, MSTATUS_SDT, 1);
> +        }
>          env->mstatus =3D s;
>          env->scause =3D cause | ((target_ulong)async << (TARGET_LONG_BIT=
S - 1));
>          env->sepc =3D env->pc;
> @@ -1823,9 +1864,14 @@ void riscv_cpu_do_interrupt(CPUState *cs)
>          s =3D set_field(s, MSTATUS_MIE, 0);
>          env->mstatus =3D s;
>          env->mcause =3D cause | ~(((target_ulong)-1) >> async);
> +        if (smode_double_trap) {
> +            env->mtval2 =3D env->mcause;
> +            env->mcause =3D RISCV_EXCP_DOUBLE_TRAP;
> +        } else {
> +            env->mtval2 =3D mtval2;
> +        }
>          env->mepc =3D env->pc;
>          env->mtval =3D tval;
> -        env->mtval2 =3D mtval2;
>          env->mtinst =3D tinst;
>          env->pc =3D (env->mtvec >> 2 << 2) +
>                    ((async && (env->mtvec & 3) =3D=3D 1) ? cause * 4 : 0)=
;
> diff --git a/target/riscv/csr.c b/target/riscv/csr.c
> index 726096444f..1a2e739947 100644
> --- a/target/riscv/csr.c
> +++ b/target/riscv/csr.c
> @@ -514,6 +514,15 @@ static RISCVException aia_hmode32(CPURISCVState *env=
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
> @@ -1182,7 +1191,7 @@ static const target_ulong vs_delegable_excps =3D DE=
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
> @@ -1380,6 +1389,13 @@ static RISCVException write_mstatus(CPURISCVState =
*env, int csrno,
>          mask |=3D MSTATUS_VS;
>      }
>
> +    if (riscv_env_smode_dbltrp_enabled(env)) {
> +        mask |=3D MSTATUS_SDT;
> +        if ((val & MSTATUS_SDT) !=3D 0) {
> +            mask &=3D ~MSTATUS_SIE;
> +        }
> +    }

When the SDT bit is set to 1 by an explicit CSR write, the SIE
(Supervisor Interrupt Enable) bit is cleared to 0.
Here we only clear the mask, not the mstatus.SIE bit.
If the mstatus.SIE has been set before this CSR write, we'll not set
the mstatus.SIE to 0 at this explicit CSR write.

> +
>      if (xl !=3D MXL_RV32 || env->debugger) {
>          if (riscv_has_ext(env, RVH)) {
>              mask |=3D MSTATUS_MPV | MSTATUS_GVA;
> @@ -2089,7 +2105,8 @@ static RISCVException write_menvcfg(CPURISCVState *=
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
> @@ -2109,7 +2126,8 @@ static RISCVException write_menvcfgh(CPURISCVState =
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
> @@ -2160,9 +2178,10 @@ static RISCVException read_henvcfg(CPURISCVState *=
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
> @@ -2170,6 +2189,7 @@ static RISCVException write_henvcfg(CPURISCVState *=
env, int csrno,
>                                      target_ulong val)
>  {
>      uint64_t mask =3D HENVCFG_FIOM | HENVCFG_CBIE | HENVCFG_CBCFE | HENV=
CFG_CBZE;
> +    uint64_t menvcfg_mask;
>      RISCVException ret;
>
>      ret =3D smstateen_acc_ok(env, 0, SMSTATEEN0_HSENVCFG);
> @@ -2178,7 +2198,11 @@ static RISCVException write_henvcfg(CPURISCVState =
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
> @@ -2196,8 +2220,8 @@ static RISCVException read_henvcfgh(CPURISCVState *=
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
> @@ -2205,7 +2229,7 @@ static RISCVException write_henvcfgh(CPURISCVState =
*env, int csrno,
>                                       target_ulong val)
>  {
>      uint64_t mask =3D env->menvcfg & (HENVCFG_PBMTE | HENVCFG_STCE |
> -                                    HENVCFG_ADUE);
> +                                    HENVCFG_ADUE | HENVCFG_DTE);
>      uint64_t valh =3D (uint64_t)val << 32;
>      RISCVException ret;
>
> @@ -4801,7 +4825,7 @@ riscv_csr_operations csr_ops[CSR_TABLE_SIZE] =3D {
>      [CSR_VSATP]       =3D { "vsatp",       hmode,   read_vsatp,    write=
_vsatp,
>                            .min_priv_ver =3D PRIV_VERSION_1_12_0         =
       },
>
> -    [CSR_MTVAL2]      =3D { "mtval2",      hmode,   read_mtval2,   write=
_mtval2,
> +    [CSR_MTVAL2]      =3D { "mtval2",      dbltrp_hmode,   read_mtval2, =
  write_mtval2,
>                            .min_priv_ver =3D PRIV_VERSION_1_12_0         =
       },
>      [CSR_MTINST]      =3D { "mtinst",      hmode,   read_mtinst,   write=
_mtinst,
>                            .min_priv_ver =3D PRIV_VERSION_1_12_0         =
       },
> diff --git a/target/riscv/op_helper.c b/target/riscv/op_helper.c
> index f414aaebdb..468ee58a00 100644
> --- a/target/riscv/op_helper.c
> +++ b/target/riscv/op_helper.c
> @@ -289,6 +289,17 @@ target_ulong helper_sret(CPURISCVState *env)
>                          get_field(mstatus, MSTATUS_SPIE));
>      mstatus =3D set_field(mstatus, MSTATUS_SPIE, 1);
>      mstatus =3D set_field(mstatus, MSTATUS_SPP, PRV_U);
> +    if (riscv_cpu_cfg(env)->ext_ssdbltrp) {
> +        if (env->virt_enabled) {
> +            if (get_field(env->henvcfg, HENVCFG_DTE)) {
> +                mstatus =3D set_field(mstatus, MSTATUS_SDT, 0);
> +            }
> +        } else {
> +            if (get_field(env->menvcfg, MENVCFG_DTE)) {
> +                mstatus =3D set_field(mstatus, MSTATUS_SDT, 0);
> +            }
> +        }
> +    }
>      if (env->priv_ver >=3D PRIV_VERSION_1_12_0) {
>          mstatus =3D set_field(mstatus, MSTATUS_MPRV, 0);
>      }
> --
> 2.43.0
>
>

Thanks for the patchset.

Best Regards,
Tommy Wu.

