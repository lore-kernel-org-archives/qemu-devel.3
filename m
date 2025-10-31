Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DF475CCF9F0
	for <qemu-devel@archiver.kernel.org>; Fri, 31 Oct 2025 02:53:36 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vEfF0-00043w-FY; Thu, 30 Oct 2025 22:51:50 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1vEfEy-00043a-GL
 for qemu-devel@nongnu.org; Thu, 30 Oct 2025 22:51:48 -0400
Received: from mail-ed1-x52a.google.com ([2a00:1450:4864:20::52a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1vEfEs-0003Vt-MF
 for qemu-devel@nongnu.org; Thu, 30 Oct 2025 22:51:47 -0400
Received: by mail-ed1-x52a.google.com with SMTP id
 4fb4d7f45d1cf-63c4b5a1b70so3795838a12.1
 for <qemu-devel@nongnu.org>; Thu, 30 Oct 2025 19:51:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1761879095; x=1762483895; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=1ldAju6zchBK2m6iDWpLUdTqCFI0L3zDJb1Du42JzDo=;
 b=Zy8HUffGMGDQpkK2JniA6hnXIaXFcNFRmqs/O31Ejoogrzfu35uaiHZQDW2owHjSAP
 4ZGtcFYe1mV6O0O/tfVryRBzfYXhgaRhmPJvvzPm4/I1fkVaDgenUvCPF19uvKZ4Y11c
 LI32HSgDCyUe3FGwyJXHB9rRJ6GMIsesnAuC3+3WEidh0XdZB2v8MkI4T0l6jnrtRVUS
 DsgFxkmJJhSIF3RJoGecEQJD/TYcllyhNKS+RktQz29L1iHhJSFSE40bwAfbKyyZba2V
 mjhf5dx1hao5+s5wbCaA2jzHviuerfuAClUbzaPPixY9MMWSXsQgm2bwGbEHoDtc095v
 9Pcw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1761879095; x=1762483895;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=1ldAju6zchBK2m6iDWpLUdTqCFI0L3zDJb1Du42JzDo=;
 b=FG9wnkjFv0ZyB7KBx7G8TWbmyn2p8n1Mj5vLmg704pfadqCxV/D1vmVAIp4S2mHanZ
 dugt+A6wT4dXn0eWHadGbO07x/DtTQpgkA8TUxWSwBbb/80yebW0hlJ5DCeYH/Zez0o+
 E8x83mXWAEyIPwLhRsMRCjfXzXchCmCGMd1c+5nKK32aLIAIVggJ9l6AT18yNQfkU/eK
 poUNsGDLKDVCCpVLHA9Zaoj0vy7RrHYFQfdDN1sk+Tvg5dAhI9hiTE/cHmrAjrA/Emur
 SBUqpwR0n1fXikUdJBxsbcfAufdBk92jWpDohxUnagepK9X74PUxM5URt6K7DbP/SESM
 y3Rw==
X-Gm-Message-State: AOJu0YzoafQurdKeFtR104a3vvE4rYAx7H4V6/knTqrdYzYnpeS5b4LC
 1qejsPAue6rT/DZy/Ixy3dYzvr3lwpTNom4kfb1hQOsdstaK/tK6tc++O9j6oSeJOPZCXu6Vvzz
 19oUokITqUWTPxroZom5OGZy19iAPWPg=
X-Gm-Gg: ASbGncttYPT41BL8F/I0gVIn1zAunqVTJKHMD6J8yHLAJk+rYzAp9osLGS4Auef1moR
 bWbLGDoksRVahqr9ah5r6XrrIfybVVUXXl4VM9XWGiVoSG4Aime9fJk2GKQiZDG6HQvAUR3MNNd
 G1iYTPAGlgH2LNmed+/mvxvwFnShJco7vxfWXiljbs6E8h8uNMp/1tIiotl93E8quZ1ADFT/7YG
 pYnQTdq1ZvTx9szoR1BhF57i9zEWzs60Ao3P8cpiDWbij1f10Bh1x17FOgJaWAl6u3WdS37W15K
 kyxCFpyHTUDvDUqnocXnu7b4Pg==
X-Google-Smtp-Source: AGHT+IFL6/Z5Y0GewjVyP45P8iP5RTJqDIuYHDtcQBSZ9IeDU+NwXKtygaMIsZlbk+f32nfmPVXPNFh5sKaSRx78fn0=
X-Received: by 2002:a05:6402:50cd:b0:63b:ee76:3f7a with SMTP id
 4fb4d7f45d1cf-6407702dceamr1546861a12.26.1761879094922; Thu, 30 Oct 2025
 19:51:34 -0700 (PDT)
MIME-Version: 1.0
References: <20251027181831.27016-1-anjo@rev.ng>
 <20251027181831.27016-24-anjo@rev.ng>
In-Reply-To: <20251027181831.27016-24-anjo@rev.ng>
From: Alistair Francis <alistair23@gmail.com>
Date: Fri, 31 Oct 2025 12:51:08 +1000
X-Gm-Features: AWmQ_blMoCn4uhv2CWS2ng2sQIoqaj6afOmozUyYbgNwSfdqVS-13tiWYticH8E
Message-ID: <CAKmqyKOaZ3ky5aMM2CSoTU_20ggMhwo__ce4E+iQ0T=Zv+5WSA@mail.gmail.com>
Subject: Re: [PATCH v4 23/33] target/riscv: Fix arguments to board IMSIC
 emulation callbacks
To: Anton Johansson <anjo@rev.ng>
Cc: qemu-devel@nongnu.org, pierrick.bouvier@linaro.org, philmd@linaro.org, 
 alistair.francis@wdc.com, palmer@dabbelt.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::52a;
 envelope-from=alistair23@gmail.com; helo=mail-ed1-x52a.google.com
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

On Tue, Oct 28, 2025 at 4:27=E2=80=AFAM Anton Johansson via
<qemu-devel@nongnu.org> wrote:
>
> In hw/ the relevant RISCVIMSICState fields
> eidelivery, eithreshold, eistate are uint32_t.
>
> Signed-off-by: Anton Johansson <anjo@rev.ng>
> Reviewed-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>

Acked-by: Alistair Francis <alistair.francis@wdc.com>

Alistair

> ---
>  target/riscv/cpu.h        | 42 ++++++++++++++++++++-------------------
>  hw/intc/riscv_imsic.c     | 34 +++++++++++++++----------------
>  target/riscv/cpu_helper.c | 12 ++++-------
>  target/riscv/csr.c        | 24 ++++++++++++----------
>  4 files changed, 57 insertions(+), 55 deletions(-)
>
> diff --git a/target/riscv/cpu.h b/target/riscv/cpu.h
> index b35851cf4f..d6ad0e1896 100644
> --- a/target/riscv/cpu.h
> +++ b/target/riscv/cpu.h
> @@ -200,6 +200,24 @@ FIELD(VTYPE, VMA, 7, 1)
>  FIELD(VTYPE, VEDIV, 8, 2)
>  FIELD(VTYPE, RESERVED, 10, sizeof(uint64_t) * 8 - 11)
>
> +#ifndef CONFIG_USER_ONLY
> +/* machine specific AIA ireg read-modify-write callback */
> +#define AIA_MAKE_IREG(__isel, __priv, __virt, __vgein, __xlen)          =
       \
> +    ((uint32_t)((((__xlen) & 0xff) << 24) |                             =
       \
> +                (((__vgein) & 0x3f) << 20) |                            =
       \
> +                (((__virt) & 0x1) << 18) |                              =
       \
> +                (((__priv) & 0x3) << 16) |                              =
       \
> +                  (__isel & 0xffff)))
> +#define AIA_IREG_ISEL(__ireg) ((__ireg) & 0xffff)
> +#define AIA_IREG_PRIV(__ireg) (((__ireg) >> 16) & 0x3)
> +#define AIA_IREG_VIRT(__ireg) (((__ireg) >> 18) & 0x1)
> +#define AIA_IREG_VGEIN(__ireg) (((__ireg) >> 20) & 0x3f)
> +#define AIA_IREG_XLEN(__ireg) (((__ireg) >> 24) & 0xff)
> +
> +typedef int (*aia_ireg_rmw_fn)(void *arg, uint32_t reg, uint64_t *val,
> +                               uint64_t new_val, uint64_t write_mask);
> +#endif
> +
>  typedef struct PMUCTRState {
>      /* Current value of a counter */
>      uint64_t mhpmcounter_val;
> @@ -465,20 +483,8 @@ struct CPUArchState {
>      void *rdtime_fn_arg;
>
>      /* machine specific AIA ireg read-modify-write callback */
> -#define AIA_MAKE_IREG(__isel, __priv, __virt, __vgein, __xlen) \
> -    ((((__xlen) & 0xff) << 24) | \
> -     (((__vgein) & 0x3f) << 20) | \
> -     (((__virt) & 0x1) << 18) | \
> -     (((__priv) & 0x3) << 16) | \
> -     (__isel & 0xffff))
> -#define AIA_IREG_ISEL(__ireg)                  ((__ireg) & 0xffff)
> -#define AIA_IREG_PRIV(__ireg)                  (((__ireg) >> 16) & 0x3)
> -#define AIA_IREG_VIRT(__ireg)                  (((__ireg) >> 18) & 0x1)
> -#define AIA_IREG_VGEIN(__ireg)                 (((__ireg) >> 20) & 0x3f)
> -#define AIA_IREG_XLEN(__ireg)                  (((__ireg) >> 24) & 0xff)
> -    int (*aia_ireg_rmw_fn[4])(void *arg, target_ulong reg,
> -        target_ulong *val, target_ulong new_val, target_ulong write_mask=
);
> -    void *aia_ireg_rmw_fn_arg[4];
> +    aia_ireg_rmw_fn aia_ireg_rmw_cb[4];
> +    void *aia_ireg_rmw_cb_arg[4];
>
>      /* True if in debugger mode.  */
>      bool debugger;
> @@ -646,12 +652,8 @@ void riscv_cpu_interrupt(CPURISCVState *env);
>  #define BOOL_TO_MASK(x) (-!!(x)) /* helper for riscv_cpu_update_mip valu=
e */
>  void riscv_cpu_set_rdtime_fn(CPURISCVState *env, uint64_t (*fn)(void *),
>                               void *arg);
> -void riscv_cpu_set_aia_ireg_rmw_fn(CPURISCVState *env, uint32_t priv,
> -                                   int (*rmw_fn)(void *arg,
> -                                                 target_ulong reg,
> -                                                 target_ulong *val,
> -                                                 target_ulong new_val,
> -                                                 target_ulong write_mask=
),
> +void riscv_cpu_set_aia_ireg_rmw_cb(CPURISCVState *env, uint32_t priv,
> +                                   aia_ireg_rmw_fn rmw_fn,
>                                     void *rmw_fn_arg);
>
>  RISCVException smstateen_acc_ok(CPURISCVState *env, int index, uint64_t =
bit);
> diff --git a/hw/intc/riscv_imsic.c b/hw/intc/riscv_imsic.c
> index 6174e1a05d..9274a1e842 100644
> --- a/hw/intc/riscv_imsic.c
> +++ b/hw/intc/riscv_imsic.c
> @@ -88,11 +88,11 @@ static void riscv_imsic_update(RISCVIMSICState *imsic=
, uint32_t page)
>  }
>
>  static int riscv_imsic_eidelivery_rmw(RISCVIMSICState *imsic, uint32_t p=
age,
> -                                      target_ulong *val,
> -                                      target_ulong new_val,
> -                                      target_ulong wr_mask)
> +                                      uint64_t *val,
> +                                      uint64_t new_val,
> +                                      uint64_t wr_mask)
>  {
> -    target_ulong old_val =3D imsic->eidelivery[page];
> +    uint32_t old_val =3D imsic->eidelivery[page];
>
>      if (val) {
>          *val =3D old_val;
> @@ -106,11 +106,11 @@ static int riscv_imsic_eidelivery_rmw(RISCVIMSICSta=
te *imsic, uint32_t page,
>  }
>
>  static int riscv_imsic_eithreshold_rmw(RISCVIMSICState *imsic, uint32_t =
page,
> -                                      target_ulong *val,
> -                                      target_ulong new_val,
> -                                      target_ulong wr_mask)
> +                                      uint64_t *val,
> +                                      uint64_t new_val,
> +                                      uint64_t wr_mask)
>  {
> -    target_ulong old_val =3D imsic->eithreshold[page];
> +    uint32_t old_val =3D imsic->eithreshold[page];
>
>      if (val) {
>          *val =3D old_val;
> @@ -124,8 +124,8 @@ static int riscv_imsic_eithreshold_rmw(RISCVIMSICStat=
e *imsic, uint32_t page,
>  }
>
>  static int riscv_imsic_topei_rmw(RISCVIMSICState *imsic, uint32_t page,
> -                                 target_ulong *val, target_ulong new_val=
,
> -                                 target_ulong wr_mask)
> +                                 uint64_t *val, uint64_t new_val,
> +                                 uint64_t wr_mask)
>  {
>      uint32_t base, topei =3D riscv_imsic_topei(imsic, page);
>
> @@ -149,11 +149,11 @@ static int riscv_imsic_topei_rmw(RISCVIMSICState *i=
msic, uint32_t page,
>
>  static int riscv_imsic_eix_rmw(RISCVIMSICState *imsic,
>                                 uint32_t xlen, uint32_t page,
> -                               uint32_t num, bool pend, target_ulong *va=
l,
> -                               target_ulong new_val, target_ulong wr_mas=
k)
> +                               uint32_t num, bool pend, uint64_t *val,
> +                               uint64_t new_val, uint64_t wr_mask)
>  {
>      uint32_t i, base, prev;
> -    target_ulong mask;
> +    uint64_t mask;
>      uint32_t state =3D (pend) ? IMSIC_EISTATE_PENDING : IMSIC_EISTATE_EN=
ABLED;
>
>      if (xlen !=3D 32) {
> @@ -178,7 +178,7 @@ static int riscv_imsic_eix_rmw(RISCVIMSICState *imsic=
,
>              continue;
>          }
>
> -        mask =3D (target_ulong)1 << i;
> +        mask =3D 1ull << i;
>          if (wr_mask & mask) {
>              if (new_val & mask) {
>                  prev =3D qatomic_fetch_or(&imsic->eistate[base + i], sta=
te);
> @@ -197,8 +197,8 @@ static int riscv_imsic_eix_rmw(RISCVIMSICState *imsic=
,
>      return 0;
>  }
>
> -static int riscv_imsic_rmw(void *arg, target_ulong reg, target_ulong *va=
l,
> -                           target_ulong new_val, target_ulong wr_mask)
> +static int riscv_imsic_rmw(void *arg, uint32_t reg, uint64_t *val,
> +                           uint64_t new_val, uint64_t wr_mask)
>  {
>      RISCVIMSICState *imsic =3D arg;
>      uint32_t isel, priv, virt, vgein, xlen, page;
> @@ -383,7 +383,7 @@ static void riscv_imsic_realize(DeviceState *dev, Err=
or **errp)
>          }
>
>          if (!kvm_irqchip_in_kernel()) {
> -            riscv_cpu_set_aia_ireg_rmw_fn(env, (imsic->mmode) ? PRV_M : =
PRV_S,
> +            riscv_cpu_set_aia_ireg_rmw_cb(env, (imsic->mmode) ? PRV_M : =
PRV_S,
>                                            riscv_imsic_rmw, imsic);
>          }
>      }
> diff --git a/target/riscv/cpu_helper.c b/target/riscv/cpu_helper.c
> index e0a324b401..b102f15ac6 100644
> --- a/target/riscv/cpu_helper.c
> +++ b/target/riscv/cpu_helper.c
> @@ -765,17 +765,13 @@ void riscv_cpu_set_rdtime_fn(CPURISCVState *env, ui=
nt64_t (*fn)(void *),
>      env->rdtime_fn_arg =3D arg;
>  }
>
> -void riscv_cpu_set_aia_ireg_rmw_fn(CPURISCVState *env, uint32_t priv,
> -                                   int (*rmw_fn)(void *arg,
> -                                                 target_ulong reg,
> -                                                 target_ulong *val,
> -                                                 target_ulong new_val,
> -                                                 target_ulong write_mask=
),
> +void riscv_cpu_set_aia_ireg_rmw_cb(CPURISCVState *env, uint32_t priv,
> +                                   aia_ireg_rmw_fn rmw_fn,
>                                     void *rmw_fn_arg)
>  {
>      if (priv <=3D PRV_M) {
> -        env->aia_ireg_rmw_fn[priv] =3D rmw_fn;
> -        env->aia_ireg_rmw_fn_arg[priv] =3D rmw_fn_arg;
> +        env->aia_ireg_rmw_cb[priv] =3D rmw_fn;
> +        env->aia_ireg_rmw_cb_arg[priv] =3D rmw_fn_arg;
>      }
>  }
>
> diff --git a/target/riscv/csr.c b/target/riscv/csr.c
> index ebdb955869..491186d9c7 100644
> --- a/target/riscv/csr.c
> +++ b/target/riscv/csr.c
> @@ -2637,6 +2637,7 @@ static RISCVException rmw_xireg_aia(CPURISCVState *=
env, int csrno,
>      int ret =3D -EINVAL;
>      uint8_t *iprio;
>      target_ulong priv, vgein;
> +    uint64_t wide_val;
>
>      /* VS-mode CSR number passed in has already been translated */
>      switch (csrno) {
> @@ -2681,16 +2682,17 @@ static RISCVException rmw_xireg_aia(CPURISCVState=
 *env, int csrno,
>          }
>      } else if (ISELECT_IMSIC_FIRST <=3D isel && isel <=3D ISELECT_IMSIC_=
LAST) {
>          /* IMSIC registers only available when machine implements it. */
> -        if (env->aia_ireg_rmw_fn[priv]) {
> +        if (env->aia_ireg_rmw_cb[priv]) {
>              /* Selected guest interrupt file should not be zero */
>              if (virt && (!vgein || env->geilen < vgein)) {
>                  goto done;
>              }
>              /* Call machine specific IMSIC register emulation */
> -            ret =3D env->aia_ireg_rmw_fn[priv](env->aia_ireg_rmw_fn_arg[=
priv],
> +            ret =3D env->aia_ireg_rmw_cb[priv](env->aia_ireg_rmw_cb_arg[=
priv],
>                                      AIA_MAKE_IREG(isel, priv, virt, vgei=
n,
>                                                    riscv_cpu_mxl_bits(env=
)),
> -                                    val, new_val, wr_mask);
> +                                    &wide_val, new_val, wr_mask);
> +            *val =3D wide_val;
>          }
>      } else {
>          isel_reserved =3D true;
> @@ -2922,6 +2924,7 @@ static RISCVException rmw_xtopei(CPURISCVState *env=
, int csrno,
>      bool virt;
>      int ret =3D -EINVAL;
>      target_ulong priv, vgein;
> +    uint64_t wide_val;
>
>      /* Translate CSR number for VS-mode */
>      csrno =3D aia_xlate_vs_csrno(env, csrno);
> @@ -2947,7 +2950,7 @@ static RISCVException rmw_xtopei(CPURISCVState *env=
, int csrno,
>      };
>
>      /* IMSIC CSRs only available when machine implements IMSIC. */
> -    if (!env->aia_ireg_rmw_fn[priv]) {
> +    if (!env->aia_ireg_rmw_cb[priv]) {
>          goto done;
>      }
>
> @@ -2960,10 +2963,11 @@ static RISCVException rmw_xtopei(CPURISCVState *e=
nv, int csrno,
>      }
>
>      /* Call machine specific IMSIC register emulation for TOPEI */
> -    ret =3D env->aia_ireg_rmw_fn[priv](env->aia_ireg_rmw_fn_arg[priv],
> +    ret =3D env->aia_ireg_rmw_cb[priv](env->aia_ireg_rmw_cb_arg[priv],
>                      AIA_MAKE_IREG(ISELECT_IMSIC_TOPEI, priv, virt, vgein=
,
>                                    riscv_cpu_mxl_bits(env)),
> -                    val, new_val, wr_mask);
> +                    &wide_val, new_val, wr_mask);
> +    *val =3D wide_val;
>
>  done:
>      if (ret) {
> @@ -4428,7 +4432,7 @@ static RISCVException read_vstopi(CPURISCVState *en=
v, int csrno,
>                                    target_ulong *val)
>  {
>      int irq, ret;
> -    target_ulong topei;
> +    uint64_t topei =3D 0;
>      uint64_t vseip, vsgein;
>      uint32_t iid, iprio, hviid, hviprio, gein;
>      uint32_t s, scount =3D 0, siid[VSTOPI_NUM_SRCS], siprio[VSTOPI_NUM_S=
RCS];
> @@ -4443,13 +4447,13 @@ static RISCVException read_vstopi(CPURISCVState *=
env, int csrno,
>          if (gein <=3D env->geilen && vseip) {
>              siid[scount] =3D IRQ_S_EXT;
>              siprio[scount] =3D IPRIO_MMAXIPRIO + 1;
> -            if (env->aia_ireg_rmw_fn[PRV_S]) {
> +            if (env->aia_ireg_rmw_cb[PRV_S]) {
>                  /*
>                   * Call machine specific IMSIC register emulation for
>                   * reading TOPEI.
>                   */
> -                ret =3D env->aia_ireg_rmw_fn[PRV_S](
> -                        env->aia_ireg_rmw_fn_arg[PRV_S],
> +                ret =3D env->aia_ireg_rmw_cb[PRV_S](
> +                        env->aia_ireg_rmw_cb_arg[PRV_S],
>                          AIA_MAKE_IREG(ISELECT_IMSIC_TOPEI, PRV_S, true, =
gein,
>                                        riscv_cpu_mxl_bits(env)),
>                          &topei, 0, 0);
> --
> 2.51.0
>
>

