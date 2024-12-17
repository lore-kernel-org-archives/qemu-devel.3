Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8541CE7717F
	for <qemu-devel@archiver.kernel.org>; Tue, 17 Dec 2024 00:20:04 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tNLIk-0004Eq-IX; Mon, 16 Dec 2024 19:19:02 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1tNLIh-0004EX-2P; Mon, 16 Dec 2024 19:19:00 -0500
Received: from mail-vk1-xa30.google.com ([2607:f8b0:4864:20::a30])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1tNLIe-0005w6-G7; Mon, 16 Dec 2024 19:18:58 -0500
Received: by mail-vk1-xa30.google.com with SMTP id
 71dfb90a1353d-518957b0533so1400198e0c.1; 
 Mon, 16 Dec 2024 16:18:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1734394735; x=1734999535; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=+wtP+BMA/UMrXkQs3lIglsTuTDzJniqBemsUSN6ijz0=;
 b=RYwQTF1myLwYMgfl6HvaHpil7a/ao+sigx5Mqyg4OV6RwoyFEbbId8RqTcdlhoueDH
 rkfBg1tjjhq7VoU3TYKMFPM0jgAdetwTRmC+WEbzB5FFkj5VBTSDmA0mU69wN+H51uD7
 YhSQFfk17nJnXBpQKm47vwoVQv4N1CVKdrFTsBcv7SBU36y/eifxqoTnQnGz1mBBa5mr
 WBcajuiXfRzBl8/36CuurLOdDmZQso/I2NfGTcUTwCAE0sQSCcLZlo3Oc/l+qL9Hvgu/
 3btwYQHFlo70sG/zjG/SahEjJWd16MeAigtH8tIAq/nYZJkImx39ymjvof0FCLtDs5zK
 aHOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1734394735; x=1734999535;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=+wtP+BMA/UMrXkQs3lIglsTuTDzJniqBemsUSN6ijz0=;
 b=BKujnLIaQlvutfF5JDXr40gaeGKuCYwGraiZS9u6L5Xvr5jnieHdRjh0FqotGW899F
 EiB6b3rRs6kEXRWa6zMEyKlpyNE9fimf+hEqrAi28Ie+4OlXKXqRsRnJS0CFneswk7vi
 SPAf3rtvPNF5JahT0IJHFUEeoBoSmaErkrV3dbeysZuxEXWTRjpj+dPRAnWwwMCZOf3W
 HFlmW56Lhh6SfluVjET35e9uCMfq3R72IMXdJZi0+qHDZBlzrjhEnigmfb/jQ5lnY5p9
 aApY49qn92NQJA3r4gfAIFk9TM0Ms85FKnQ50Nk3tEWPx98Cgnlfo6fbU8J11meeVTaz
 oC9g==
X-Forwarded-Encrypted: i=1;
 AJvYcCVCkKbU22ZhjkJRkmfxu171DXVaQQSnQSEQJznro+G6k6iSCaaGw/sX3WBnXi3fZ+a8eFLRd5QSHVq1@nongnu.org
X-Gm-Message-State: AOJu0YwpeQpsyD02WZWwb2UQMcAbqmpX3T7h9xsXdIqGMuq/+xjF0Wph
 JXHWZCtbyhI/8SwSQC+E3LDBWPQi8P0/llI04SQNNnkotU12NDV8jaQrQ/g6jWKqCuAgo+9epxw
 iR3pchMsgdSmd76Pr8DpSgWKHS5o=
X-Gm-Gg: ASbGncs31DOu/TbNW4jRrGbyv0GNu70FxVjZclyj2wVvpHWAIosipfyT/xNq85zfkwu
 IiNSGFp3ucgatXUEZYwWYzIIwi5vQkoK3ymD0iCaTG84JgatRx0cYbfMY1fg0rqUStG32
X-Google-Smtp-Source: AGHT+IHdw0Te7mTWZk7s3SI2jTGuOBigdNw9W7tr7YyQtOngZQhsp7NV18H4ouCDDdm0Sv4xfx7+yKN2xk8AIr8Z/1o=
X-Received: by 2002:a05:6122:2228:b0:518:7eec:be7a with SMTP id
 71dfb90a1353d-518ca3a69b9mr12355409e0c.5.1734394734493; Mon, 16 Dec 2024
 16:18:54 -0800 (PST)
MIME-Version: 1.0
References: <20241128141230.284320-1-cleger@rivosinc.com>
 <20241128141230.284320-3-cleger@rivosinc.com>
In-Reply-To: <20241128141230.284320-3-cleger@rivosinc.com>
From: Alistair Francis <alistair23@gmail.com>
Date: Tue, 17 Dec 2024 10:18:28 +1000
Message-ID: <CAKmqyKMeNOXCcEVVGJGCOD=06nhNcixsdQ_9XuHf+anMLgMnhQ@mail.gmail.com>
Subject: Re: [PATCH v6 2/9] target/riscv: Add Ssdbltrp CSRs handling
To: =?UTF-8?B?Q2zDqW1lbnQgTMOpZ2Vy?= <cleger@rivosinc.com>
Cc: qemu-riscv@nongnu.org, Palmer Dabbelt <palmer@dabbelt.com>, 
 Alistair Francis <alistair.francis@wdc.com>, Bin Meng <bin.meng@windriver.com>,
 Weiwei Li <liwei1518@gmail.com>,
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>, 
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>, Ved Shanbhogue <ved@rivosinc.com>, 
 Atish Patra <atishp@rivosinc.com>, qemu-devel@nongnu.org, 
 Frank Chang <frank.chang@sifive.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::a30;
 envelope-from=alistair23@gmail.com; helo=mail-vk1-xa30.google.com
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

On Fri, Nov 29, 2024 at 12:14=E2=80=AFAM Cl=C3=A9ment L=C3=A9ger <cleger@ri=
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
>  target/riscv/cpu_bits.h   |  6 ++++
>  target/riscv/cpu_cfg.h    |  1 +
>  target/riscv/cpu_helper.c | 17 +++++++++
>  target/riscv/csr.c        | 72 ++++++++++++++++++++++++++++++++-------
>  5 files changed, 84 insertions(+), 13 deletions(-)
>
> diff --git a/target/riscv/cpu.h b/target/riscv/cpu.h
> index 8dc5b4d002..02e502768e 100644
> --- a/target/riscv/cpu.h
> +++ b/target/riscv/cpu.h
> @@ -569,6 +569,7 @@ void riscv_cpu_set_virt_enabled(CPURISCVState *env, b=
ool enable);
>  int riscv_env_mmu_index(CPURISCVState *env, bool ifetch);
>  bool cpu_get_fcfien(CPURISCVState *env);
>  bool cpu_get_bcfien(CPURISCVState *env);
> +bool riscv_env_smode_dbltrp_enabled(CPURISCVState *env, bool virt);
>  G_NORETURN void  riscv_cpu_do_unaligned_access(CPUState *cs, vaddr addr,
>                                                 MMUAccessType access_type=
,
>                                                 int mmu_idx, uintptr_t re=
taddr);
> diff --git a/target/riscv/cpu_bits.h b/target/riscv/cpu_bits.h
> index f31735d15b..dcf63b7f32 100644
> --- a/target/riscv/cpu_bits.h
> +++ b/target/riscv/cpu_bits.h
> @@ -562,6 +562,7 @@
>  #define MSTATUS_TW          0x00200000 /* since: priv-1.10 */
>  #define MSTATUS_TSR         0x00400000 /* since: priv-1.10 */
>  #define MSTATUS_SPELP       0x00800000 /* zicfilp */
> +#define MSTATUS_SDT         0x01000000
>  #define MSTATUS_MPELP       0x020000000000 /* zicfilp */
>  #define MSTATUS_GVA         0x4000000000ULL
>  #define MSTATUS_MPV         0x8000000000ULL
> @@ -594,6 +595,7 @@ typedef enum {
>  #define SSTATUS_SUM         0x00040000 /* since: priv-1.10 */
>  #define SSTATUS_MXR         0x00080000
>  #define SSTATUS_SPELP       MSTATUS_SPELP   /* zicfilp */
> +#define SSTATUS_SDT         MSTATUS_SDT
>
>  #define SSTATUS64_UXL       0x0000000300000000ULL
>
> @@ -791,11 +793,13 @@ typedef enum RISCVException {
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
> @@ -813,11 +817,13 @@ typedef enum RISCVException {
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
> index 321f64fd72..1194dfd3bc 100644
> --- a/target/riscv/cpu_cfg.h
> +++ b/target/riscv/cpu_cfg.h
> @@ -79,6 +79,7 @@ struct RISCVCPUConfig {
>      bool ext_smstateen;
>      bool ext_sstc;
>      bool ext_smcntrpmf;
> +    bool ext_ssdbltrp;
>      bool ext_svadu;
>      bool ext_svinval;
>      bool ext_svnapot;
> diff --git a/target/riscv/cpu_helper.c b/target/riscv/cpu_helper.c
> index d53ddc384f..3fabd3379c 100644
> --- a/target/riscv/cpu_helper.c
> +++ b/target/riscv/cpu_helper.c
> @@ -120,6 +120,19 @@ bool cpu_get_bcfien(CPURISCVState *env)
>      }
>  }
>
> +bool riscv_env_smode_dbltrp_enabled(CPURISCVState *env, bool virt)
> +{
> +#ifdef CONFIG_USER_ONLY
> +    return false;
> +#else
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
> @@ -642,6 +655,10 @@ void riscv_cpu_swap_hypervisor_regs(CPURISCVState *e=
nv)
>
>      g_assert(riscv_has_ext(env, RVH));
>
> +    if (riscv_env_smode_dbltrp_enabled(env, current_virt)) {
> +        mstatus_mask |=3D MSTATUS_SDT;
> +    }
> +
>      if (current_virt) {
>          /* Current V=3D1 and we are about to change to V=3D0 */
>          env->vsstatus =3D env->mstatus & mstatus_mask;
> diff --git a/target/riscv/csr.c b/target/riscv/csr.c
> index 98c683df60..611f44e044 100644
> --- a/target/riscv/csr.c
> +++ b/target/riscv/csr.c
> @@ -559,6 +559,15 @@ static RISCVException aia_hmode32(CPURISCVState *env=
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
> @@ -1633,6 +1642,13 @@ static RISCVException write_mstatus(CPURISCVState =
*env, int csrno,
>          mask |=3D MSTATUS_VS;
>      }
>
> +    if (riscv_env_smode_dbltrp_enabled(env, env->virt_enabled)) {
> +        mask |=3D MSTATUS_SDT;
> +        if ((val & MSTATUS_SDT) !=3D 0) {
> +            val &=3D ~MSTATUS_SIE;
> +        }
> +    }
> +
>      if (xl !=3D MXL_RV32 || env->debugger) {
>          if (riscv_has_ext(env, RVH)) {
>              mask |=3D MSTATUS_MPV | MSTATUS_GVA;
> @@ -2394,7 +2410,8 @@ static RISCVException write_menvcfg(CPURISCVState *=
env, int csrno,
>      if (riscv_cpu_mxl(env) =3D=3D MXL_RV64) {
>          mask |=3D (cfg->ext_svpbmt ? MENVCFG_PBMTE : 0) |
>                  (cfg->ext_sstc ? MENVCFG_STCE : 0) |
> -                (cfg->ext_svadu ? MENVCFG_ADUE : 0);
> +                (cfg->ext_svadu ? MENVCFG_ADUE : 0) |
> +                (cfg->ext_ssdbltrp ? MENVCFG_DTE : 0);
>
>          if (env_archcpu(env)->cfg.ext_zicfilp) {
>              mask |=3D MENVCFG_LPE;
> @@ -2403,6 +2420,10 @@ static RISCVException write_menvcfg(CPURISCVState =
*env, int csrno,
>          if (env_archcpu(env)->cfg.ext_zicfiss) {
>              mask |=3D MENVCFG_SSE;
>          }
> +
> +        if ((val & MENVCFG_DTE) =3D=3D 0) {
> +            env->mstatus &=3D ~MSTATUS_SDT;
> +        }
>      }
>      env->menvcfg =3D (env->menvcfg & ~mask) | (val & mask);
>      write_henvcfg(env, CSR_HENVCFG, env->henvcfg);
> @@ -2425,9 +2446,14 @@ static RISCVException write_menvcfgh(CPURISCVState=
 *env, int csrno,
>      const RISCVCPUConfig *cfg =3D riscv_cpu_cfg(env);
>      uint64_t mask =3D (cfg->ext_svpbmt ? MENVCFG_PBMTE : 0) |
>                      (cfg->ext_sstc ? MENVCFG_STCE : 0) |
> -                    (cfg->ext_svadu ? MENVCFG_ADUE : 0);
> +                    (cfg->ext_svadu ? MENVCFG_ADUE : 0) |
> +                    (cfg->ext_ssdbltrp ? MENVCFG_DTE : 0);
>      uint64_t valh =3D (uint64_t)val << 32;
>
> +    if ((valh & MENVCFG_DTE) =3D=3D 0) {
> +        env->mstatus &=3D ~MSTATUS_SDT;
> +    }
> +
>      env->menvcfg =3D (env->menvcfg & ~mask) | (valh & mask);
>      write_henvcfgh(env, CSR_HENVCFGH, env->henvcfg >> 32);
>
> @@ -2488,9 +2514,10 @@ static RISCVException read_henvcfg(CPURISCVState *=
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
> @@ -2506,7 +2533,8 @@ static RISCVException write_henvcfg(CPURISCVState *=
env, int csrno,
>      }
>
>      if (riscv_cpu_mxl(env) =3D=3D MXL_RV64) {
> -        mask |=3D env->menvcfg & (HENVCFG_PBMTE | HENVCFG_STCE | HENVCFG=
_ADUE);
> +        mask |=3D env->menvcfg & (HENVCFG_PBMTE | HENVCFG_STCE | HENVCFG=
_ADUE |
> +                                HENVCFG_DTE);
>
>          if (env_archcpu(env)->cfg.ext_zicfilp) {
>              mask |=3D HENVCFG_LPE;
> @@ -2520,6 +2548,9 @@ static RISCVException write_henvcfg(CPURISCVState *=
env, int csrno,
>      }
>
>      env->henvcfg =3D val & mask;
> +    if ((env->henvcfg & HENVCFG_DTE) =3D=3D 0) {
> +        env->vsstatus &=3D ~MSTATUS_SDT;
> +    }
>
>      return RISCV_EXCP_NONE;
>  }
> @@ -2534,8 +2565,8 @@ static RISCVException read_henvcfgh(CPURISCVState *=
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
> @@ -2543,7 +2574,7 @@ static RISCVException write_henvcfgh(CPURISCVState =
*env, int csrno,
>                                       target_ulong val)
>  {
>      uint64_t mask =3D env->menvcfg & (HENVCFG_PBMTE | HENVCFG_STCE |
> -                                    HENVCFG_ADUE);
> +                                    HENVCFG_ADUE | HENVCFG_DTE);
>      uint64_t valh =3D (uint64_t)val << 32;
>      RISCVException ret;
>
> @@ -2551,8 +2582,10 @@ static RISCVException write_henvcfgh(CPURISCVState=
 *env, int csrno,
>      if (ret !=3D RISCV_EXCP_NONE) {
>          return ret;
>      }
> -
>      env->henvcfg =3D (env->henvcfg & 0xFFFFFFFF) | (valh & mask);
> +    if ((env->henvcfg & HENVCFG_DTE) =3D=3D 0) {
> +        env->vsstatus &=3D ~MSTATUS_SDT;
> +    }
>      return RISCV_EXCP_NONE;
>  }
>
> @@ -2980,6 +3013,9 @@ static RISCVException read_sstatus_i128(CPURISCVSta=
te *env, int csrno,
>      if (env->xl !=3D MXL_RV32 || env->debugger) {
>          mask |=3D SSTATUS64_UXL;
>      }
> +    if (riscv_cpu_cfg(env)->ext_ssdbltrp) {
> +        mask |=3D SSTATUS_SDT;
> +    }
>
>      if (env_archcpu(env)->cfg.ext_zicfilp) {
>          mask |=3D SSTATUS_SPELP;
> @@ -2996,11 +3032,12 @@ static RISCVException read_sstatus(CPURISCVState =
*env, int csrno,
>      if (env->xl !=3D MXL_RV32 || env->debugger) {
>          mask |=3D SSTATUS64_UXL;
>      }
> -
>      if (env_archcpu(env)->cfg.ext_zicfilp) {
>          mask |=3D SSTATUS_SPELP;
>      }
> -
> +    if (riscv_cpu_cfg(env)->ext_ssdbltrp) {
> +        mask |=3D SSTATUS_SDT;
> +    }
>      /* TODO: Use SXL not MXL. */
>      *val =3D add_status_sd(riscv_cpu_mxl(env), env->mstatus & mask);
>      return RISCV_EXCP_NONE;
> @@ -3020,7 +3057,9 @@ static RISCVException write_sstatus(CPURISCVState *=
env, int csrno,
>      if (env_archcpu(env)->cfg.ext_zicfilp) {
>          mask |=3D SSTATUS_SPELP;
>      }
> -
> +    if (riscv_cpu_cfg(env)->ext_ssdbltrp) {
> +        mask |=3D SSTATUS_SDT;
> +    }
>      target_ulong newval =3D (env->mstatus & ~mask) | (val & mask);
>      return write_mstatus(env, CSR_MSTATUS, newval);
>  }
> @@ -4126,6 +4165,13 @@ static RISCVException write_vsstatus(CPURISCVState=
 *env, int csrno,
>      if ((val & VSSTATUS64_UXL) =3D=3D 0) {
>          mask &=3D ~VSSTATUS64_UXL;
>      }
> +    if ((env->henvcfg & HENVCFG_DTE)) {
> +        if ((val & SSTATUS_SDT) !=3D 0) {
> +            val &=3D ~SSTATUS_SIE;
> +        }
> +    } else {
> +        val &=3D ~SSTATUS_SDT;
> +    }
>      env->vsstatus =3D (env->vsstatus & ~mask) | (uint64_t)val;
>      return RISCV_EXCP_NONE;
>  }
> @@ -5336,7 +5382,7 @@ riscv_csr_operations csr_ops[CSR_TABLE_SIZE] =3D {
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

