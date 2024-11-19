Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9E897D591CC
	for <qemu-devel@archiver.kernel.org>; Tue, 19 Nov 2024 06:21:30 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tDHb7-0003iC-P2; Tue, 19 Nov 2024 01:20:25 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1tDHb5-0003hx-JF; Tue, 19 Nov 2024 01:20:23 -0500
Received: from mail-ua1-x92c.google.com ([2607:f8b0:4864:20::92c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1tDHb3-0006xt-FT; Tue, 19 Nov 2024 01:20:23 -0500
Received: by mail-ua1-x92c.google.com with SMTP id
 a1e0cc1a2514c-856e82a32bcso2190268241.1; 
 Mon, 18 Nov 2024 22:20:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1731997220; x=1732602020; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=KHwpfZ4YXdSBeYYWgZobDgtkxWJOfZfX1Q6tLmx5IsU=;
 b=UOJfCnBemLJfj4H5woYXyiCgDhaqKN+rtygssb50Jk12WfrcCyguV8GszW3fKzDPuw
 A65oJcsjDDgPdiMuVDU6jyY7PYHjeRF6eNQzJQP4Qxi7Sq1M78ZJx4LX6CI84kKjTXkG
 89aMAYWPPu91cuehvuLTBjw6ZIb7njQpR/qikkdraAgZGhF/Fu76pFUGB8jYj9AQll26
 lQu4+dj7LleJ/VwbDNh+CRXjaTRbeoNVlHZJ2Q+Q2uxtIdIPlMk3i/+6RY1EhRBCPguz
 BjJnFFpJtoTqq70kVDM7boZOvPXKcxmLys1UDzmpOqLjZimJvkrklNvN9jAnV6yr75EM
 nRPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1731997220; x=1732602020;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=KHwpfZ4YXdSBeYYWgZobDgtkxWJOfZfX1Q6tLmx5IsU=;
 b=ZvB2QrJaOy1r6Bb8bUJo0d6F41jp/ATsfC2USK0mx4fR874FZLEdneFA4G2ai4Y7Lp
 vy4ts/hEtw7zc+N8JbTPgSpPRrVSLNJCTPWQvF6oHUXDraEeTlZEeyV0yrTkXiK2HenS
 FOzBV3iJbR8dBpkawsb5dcYNy4tVFUK4FpxAJkuQpOWfyomaOUZNM7vwGUp9PQ+WBA2l
 MnUZplTUCWgJyZogkI2uQ2jed2SuMm0E74T6iSSPwJc7YDDRfj3pBoBbnYARE3mvQqoX
 BB0FnG3oDRou43YqBZRHgbyQ6Ew6Oofjekfu8cc3mhaNQajwTEGgVcDlgWSWJSrIuWLk
 O2qg==
X-Forwarded-Encrypted: i=1;
 AJvYcCUfg5aT6/31c60C2jnS8wt5REoQ9QB0d9MLhUk18sMtsNIjU6Aq5sscSWFtBg5OBogEBKaAokEZX2uP@nongnu.org
X-Gm-Message-State: AOJu0Yy5+edQQz4YlZsib2dCKuCQOtdR7/tOK4m+etDV0ink5eTzhEI7
 O+K78xreDiug1PaP7O0nKtjMyQHwpq5GLkeUM+XQOh/fCRN60aZdnyn9gBCOFmdVbkCvel97q7i
 SWPSUgcw+UhadEhR5Ug8pO/0MkSQ=
X-Google-Smtp-Source: AGHT+IGQ4S6DKPluQhpvAqf2vJKoUsd41c/YAZneJqNtCE4X39Kej4bNF8o6YFcbj23eiWz2J/dz/LySN39FX0abQnM=
X-Received: by 2002:a05:6102:32c2:b0:4a4:8a29:a8f8 with SMTP id
 ada2fe7eead31-4ad62af2785mr12383917137.2.1731997219834; Mon, 18 Nov 2024
 22:20:19 -0800 (PST)
MIME-Version: 1.0
References: <20241114091332.108811-1-cleger@rivosinc.com>
 <20241114091332.108811-3-cleger@rivosinc.com>
In-Reply-To: <20241114091332.108811-3-cleger@rivosinc.com>
From: Alistair Francis <alistair23@gmail.com>
Date: Tue, 19 Nov 2024 16:19:53 +1000
Message-ID: <CAKmqyKPyt7i6gKe5DwsLOg1V3Yv1uPCR8_CAdr3ywEQ58-syYQ@mail.gmail.com>
Subject: Re: [PATCH v5 2/9] target/riscv: Add Ssdbltrp CSRs handling
To: =?UTF-8?B?Q2zDqW1lbnQgTMOpZ2Vy?= <cleger@rivosinc.com>
Cc: qemu-riscv@nongnu.org, Palmer Dabbelt <palmer@dabbelt.com>, 
 Alistair Francis <alistair.francis@wdc.com>, Bin Meng <bin.meng@windriver.com>,
 Weiwei Li <liwei1518@gmail.com>,
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>, 
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>, Ved Shanbhogue <ved@rivosinc.com>, 
 Atish Patra <atishp@rivosinc.com>, qemu-devel@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::92c;
 envelope-from=alistair23@gmail.com; helo=mail-ua1-x92c.google.com
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

On Thu, Nov 14, 2024 at 7:16=E2=80=AFPM Cl=C3=A9ment L=C3=A9ger <cleger@riv=
osinc.com> wrote:
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
>  target/riscv/cpu_helper.c | 17 ++++++++++
>  target/riscv/csr.c        | 70 +++++++++++++++++++++++++++++++++------
>  5 files changed, 85 insertions(+), 10 deletions(-)
>
> diff --git a/target/riscv/cpu.h b/target/riscv/cpu.h
> index 832556cc34..695de5667f 100644
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
> index 1a5200d1d5..08cc5b2e22 100644
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
> index 092744360e..518102d748 100644
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
> index 648d4ed833..b9f36e8621 100644
> --- a/target/riscv/cpu_helper.c
> +++ b/target/riscv/cpu_helper.c
> @@ -63,6 +63,19 @@ int riscv_env_mmu_index(CPURISCVState *env, bool ifetc=
h)
>  #endif
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
> @@ -562,6 +575,10 @@ void riscv_cpu_swap_hypervisor_regs(CPURISCVState *e=
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
> index 73ac4d5449..054418ff54 100644
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
> @@ -1600,6 +1609,13 @@ static RISCVException write_mstatus(CPURISCVState =
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
> @@ -2356,7 +2372,11 @@ static RISCVException write_menvcfg(CPURISCVState =
*env, int csrno,
>      if (riscv_cpu_mxl(env) =3D=3D MXL_RV64) {
>          mask |=3D (cfg->ext_svpbmt ? MENVCFG_PBMTE : 0) |
>                  (cfg->ext_sstc ? MENVCFG_STCE : 0) |
> -                (cfg->ext_svadu ? MENVCFG_ADUE : 0);
> +                (cfg->ext_svadu ? MENVCFG_ADUE : 0) |
> +                (cfg->ext_ssdbltrp ? MENVCFG_DTE : 0);
> +        if ((val & MENVCFG_DTE) =3D=3D 0) {
> +            env->mstatus &=3D ~MSTATUS_SDT;
> +        }
>      }
>      env->menvcfg =3D (env->menvcfg & ~mask) | (val & mask);
>      write_henvcfg(env, CSR_HENVCFG, env->henvcfg);
> @@ -2379,9 +2399,14 @@ static RISCVException write_menvcfgh(CPURISCVState=
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
> @@ -2431,9 +2456,10 @@ static RISCVException read_henvcfg(CPURISCVState *=
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
> @@ -2457,7 +2483,8 @@ static RISCVException write_henvcfg(CPURISCVState *=
env, int csrno,
>           * keeping stale menvcfg bits in henvcfg value if a bit was enab=
led in
>           * menvcfg and then disabled before updating henvcfg for instanc=
e.
>           */
> -        menvcfg_mask =3D HENVCFG_PBMTE | HENVCFG_STCE | HENVCFG_ADUE;
> +        menvcfg_mask =3D HENVCFG_PBMTE | HENVCFG_STCE | HENVCFG_ADUE |
> +                       HENVCFG_DTE;
>          mask |=3D env->menvcfg & menvcfg_mask;
>          henvcfg_mask |=3D menvcfg_mask;
>      }
> @@ -2468,6 +2495,9 @@ static RISCVException write_henvcfg(CPURISCVState *=
env, int csrno,
>       * menvcfg enabled bits only.
>       */
>      env->henvcfg =3D (env->henvcfg & ~henvcfg_mask) | (val & mask);
> +    if ((env->henvcfg & HENVCFG_DTE) =3D=3D 0) {
> +        env->vsstatus &=3D ~MSTATUS_SDT;
> +    }
>
>      return RISCV_EXCP_NONE;
>  }
> @@ -2482,8 +2512,8 @@ static RISCVException read_henvcfgh(CPURISCVState *=
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
> @@ -2495,7 +2525,8 @@ static RISCVException write_henvcfgh(CPURISCVState =
*env, int csrno,
>       * clear all previous menvcfg bits before enabling some new one to a=
void
>       * stale menvcfg bits in henvcfg.
>       */
> -    uint64_t henvcfg_mask =3D (HENVCFG_PBMTE | HENVCFG_STCE | HENVCFG_AD=
UE);
> +    uint64_t henvcfg_mask =3D (HENVCFG_PBMTE | HENVCFG_STCE | HENVCFG_AD=
UE |
> +                             HENVCFG_DTE);
>      uint64_t mask =3D env->menvcfg & henvcfg_mask;
>      uint64_t valh =3D (uint64_t)val << 32;
>      RISCVException ret;
> @@ -2504,12 +2535,15 @@ static RISCVException write_henvcfgh(CPURISCVStat=
e *env, int csrno,
>      if (ret !=3D RISCV_EXCP_NONE) {
>          return ret;
>      }
> -
>      /*
>       * 'henvcfg_mask' contains all menvcfg supported bits and 'mask' con=
tains
>       * menvcfg enabled bits only.
>       */
>      env->henvcfg =3D (env->henvcfg & ~henvcfg_mask) | (valh & mask);
> +    if ((env->henvcfg & HENVCFG_DTE) =3D=3D 0) {
> +        env->vsstatus &=3D ~MSTATUS_SDT;
> +    }
> +
>      return RISCV_EXCP_NONE;
>  }
>
> @@ -2937,6 +2971,9 @@ static RISCVException read_sstatus_i128(CPURISCVSta=
te *env, int csrno,
>      if (env->xl !=3D MXL_RV32 || env->debugger) {
>          mask |=3D SSTATUS64_UXL;
>      }
> +    if (riscv_cpu_cfg(env)->ext_ssdbltrp) {
> +        mask |=3D SSTATUS_SDT;
> +    }
>
>      *val =3D int128_make128(sstatus, add_status_sd(MXL_RV128, sstatus));
>      return RISCV_EXCP_NONE;
> @@ -2949,6 +2986,9 @@ static RISCVException read_sstatus(CPURISCVState *e=
nv, int csrno,
>      if (env->xl !=3D MXL_RV32 || env->debugger) {
>          mask |=3D SSTATUS64_UXL;
>      }
> +    if (riscv_cpu_cfg(env)->ext_ssdbltrp) {
> +        mask |=3D SSTATUS_SDT;
> +    }
>      /* TODO: Use SXL not MXL. */
>      *val =3D add_status_sd(riscv_cpu_mxl(env), env->mstatus & mask);
>      return RISCV_EXCP_NONE;
> @@ -2964,6 +3004,9 @@ static RISCVException write_sstatus(CPURISCVState *=
env, int csrno,
>              mask |=3D SSTATUS64_UXL;
>          }
>      }
> +    if (riscv_cpu_cfg(env)->ext_ssdbltrp) {
> +        mask |=3D SSTATUS_SDT;
> +    }
>      target_ulong newval =3D (env->mstatus & ~mask) | (val & mask);
>      return write_mstatus(env, CSR_MSTATUS, newval);
>  }
> @@ -4069,6 +4112,13 @@ static RISCVException write_vsstatus(CPURISCVState=
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
> @@ -5276,7 +5326,7 @@ riscv_csr_operations csr_ops[CSR_TABLE_SIZE] =3D {
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

