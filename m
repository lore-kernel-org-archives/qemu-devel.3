Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 983D4C36010
	for <qemu-devel@archiver.kernel.org>; Mon,  7 Apr 2025 09:43:40 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u1j0h-0005Mt-CF; Mon, 07 Apr 2025 05:43:19 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jim.shu@sifive.com>)
 id 1u1j0e-0005Ln-Ro
 for qemu-devel@nongnu.org; Mon, 07 Apr 2025 05:43:16 -0400
Received: from mail-ed1-x536.google.com ([2a00:1450:4864:20::536])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <jim.shu@sifive.com>)
 id 1u1j0c-0004gG-1V
 for qemu-devel@nongnu.org; Mon, 07 Apr 2025 05:43:16 -0400
Received: by mail-ed1-x536.google.com with SMTP id
 4fb4d7f45d1cf-5e614da8615so2587864a12.1
 for <qemu-devel@nongnu.org>; Mon, 07 Apr 2025 02:43:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sifive.com; s=google; t=1744018991; x=1744623791; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=frAdG82IzSpKFdF9BYUPNXFXA1qcYxRah5S2vNxJgmQ=;
 b=JcD6Tj1yiWReT3OBilrpoScp7rWVVvuC4NIovIS8P6FQMflAanftRcdJhDBJHh7HW9
 oya0UNbUykCqE6BHmjg89YQRU459YGGnyAcKoN2x3BIv9qtW6GJcnGP/+digDct53w45
 vpFaHcij8xPYLe5F7DJts+o8Yfi50m+jns9LQrV/xQJz9lB/n9RaXNl8iAEMxAypAqhB
 6NARsmc+fQPxM24zv4Q/4oyQdtMLyJHvoYuPFA3XpGTBndPREI6WmC92D/ovRQjbZpFB
 qcZHroRjx62/cQCy0mJ0OmhwPiFbaTt2dY9AOh8/9nouBHKZX3V0SQWNkJH8BHbrdr+Z
 AyMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1744018991; x=1744623791;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=frAdG82IzSpKFdF9BYUPNXFXA1qcYxRah5S2vNxJgmQ=;
 b=UpPWxCrq68XlSL9ua6bBF+ZCEQgC+mQQiONaSrJy9gEFFHIRM2dzQmcTHm5EFQiaD1
 rvEurT+n1gneE7/p9grhZR/nWR6C9toL8wd3iVIVV+1fIbVHK2gmWdYnOrm8VzRi6eFL
 qiTLMo1Dzua4UrqEyKgFoY1VERgsNe0l8gZbCn7EoThY3f3U1wMtTffeDPhP7aHIku+G
 3Y7MaQLhyebQghC28xnlPpmgee7n1Z1fiJMVDextI3JQ37pGTTBckfQdnSncWjDn9pXg
 DfJEr6nBMVlVQqPiqPjeQ+zlBQmouvEBng0Q/rqLQwY0gvP7UxZ9puqGCAxcMvM7ugNG
 BWaw==
X-Gm-Message-State: AOJu0YwXgY4pq9LfYlqu0tIEFjNmG9m5gBXi+4mGjEsMYa72V1bSTD1D
 u6mSXzpjYKlih/+alObL0BphFfNYouiz680ULyItjt0WUgyiQfuzK8CMPMEkdbukOO8R646X5bk
 xRgRQ71bBoF2f8UsW++FIrxsRrv/ZSKdXbgMWPA==
X-Gm-Gg: ASbGncvwTD190qXwmcfW7GhCnQq+kEdg2N3l9PACBVU2a7TkX7NwT0FHXfEywfOrilg
 GTj+5cJ6uvS4oO78i4RiXmvFuSFmtGXNS4zz256lguAbcOR7Rmt62CZuGrXDDM9SbGaWqsHXXmH
 xj/8/OmQEAV2roYBz05CblC4djwnpf
X-Google-Smtp-Source: AGHT+IHBT2QwPW67OF+XinZDo56beTyUPleiOhytNCHpyNHJwV4YB2uhfjjqh1dWzAz/CTjLdiskDXP2lRhwOYpqmkU=
X-Received: by 2002:a05:6402:1d4e:b0:5e5:4807:545f with SMTP id
 4fb4d7f45d1cf-5f0b292ac40mr9554807a12.12.1744018990988; Mon, 07 Apr 2025
 02:43:10 -0700 (PDT)
MIME-Version: 1.0
References: <20250319192153.28549-1-jim.shu@sifive.com>
 <20250319192153.28549-5-jim.shu@sifive.com>
 <CAKmqyKPFBaGdEQeLewGyvhNcmzqO0gtRN=4BytoAH7QO5qm_Lw@mail.gmail.com>
In-Reply-To: <CAKmqyKPFBaGdEQeLewGyvhNcmzqO0gtRN=4BytoAH7QO5qm_Lw@mail.gmail.com>
From: Jim Shu <jim.shu@sifive.com>
Date: Mon, 7 Apr 2025 17:42:59 +0800
X-Gm-Features: ATxdqUHyOBVd4-RGovufR-Y10_ggCZ6GLHHsjBoOVbwpMa0MZmxCCeaOtycKv6g
Message-ID: <CALw707ouoGcASSCd1ODHiqVw3XqtrdeRJw2k6b2kZZx8vpbWnQ@mail.gmail.com>
Subject: Re: [PATCH 4/4] target/riscv: Enable/Disable S/VS-mode Timer when
 STCE bit is changed
To: Alistair Francis <alistair23@gmail.com>
Cc: qemu-devel@nongnu.org, qemu-riscv@nongnu.org, 
 Palmer Dabbelt <palmer@dabbelt.com>,
 Alistair Francis <alistair.francis@wdc.com>, 
 Weiwei Li <liwei1518@gmail.com>,
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>, 
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::536;
 envelope-from=jim.shu@sifive.com; helo=mail-ed1-x536.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

OK, I will fix it in the v2 patchset.


Jim Shu

On Fri, Apr 4, 2025 at 2:03=E2=80=AFPM Alistair Francis <alistair23@gmail.c=
om> wrote:
>
> On Thu, Mar 20, 2025 at 5:24=E2=80=AFAM Jim Shu <jim.shu@sifive.com> wrot=
e:
> >
> > Updating STCE will enable/disable SSTC in S-mode or/and VS-mode, so we
> > also need to update S/VS-mode Timer and S/VSTIP bits in $mip CSR.
> >
> > Signed-off-by: Jim Shu <jim.shu@sifive.com>
> > ---
> >  target/riscv/csr.c         | 44 ++++++++++++++++++++++++++++++++
> >  target/riscv/time_helper.c | 51 ++++++++++++++++++++++++++++++++++++++
> >  target/riscv/time_helper.h |  1 +
> >  3 files changed, 96 insertions(+)
> >
> > diff --git a/target/riscv/csr.c b/target/riscv/csr.c
> > index ba026dfc8e..c954e49cae 100644
> > --- a/target/riscv/csr.c
> > +++ b/target/riscv/csr.c
> > @@ -3156,6 +3156,7 @@ static RISCVException write_menvcfg(CPURISCVState=
 *env, int csrno,
> >      const RISCVCPUConfig *cfg =3D riscv_cpu_cfg(env);
> >      uint64_t mask =3D MENVCFG_FIOM | MENVCFG_CBIE | MENVCFG_CBCFE |
> >                      MENVCFG_CBZE | MENVCFG_CDE;
> > +    bool stce_changed =3D false;
> >
> >      if (riscv_cpu_mxl(env) =3D=3D MXL_RV64) {
> >          mask |=3D (cfg->ext_svpbmt ? MENVCFG_PBMTE : 0) |
> > @@ -3181,10 +3182,19 @@ static RISCVException write_menvcfg(CPURISCVSta=
te *env, int csrno,
> >          if ((val & MENVCFG_DTE) =3D=3D 0) {
> >              env->mstatus &=3D ~MSTATUS_SDT;
> >          }
> > +
> > +        if (cfg->ext_sstc &&
> > +            ((env->menvcfg & MENVCFG_STCE) !=3D (val & MENVCFG_STCE)))=
 {
> > +            stce_changed =3D true;
> > +        }
> >      }
> >      env->menvcfg =3D (env->menvcfg & ~mask) | (val & mask);
> >      write_henvcfg(env, CSR_HENVCFG, env->henvcfg);
> >
> > +    if (stce_changed) {
> > +        riscv_timer_stce_changed(env, true, !!(val & MENVCFG_STCE));
> > +    }
> > +
> >      return RISCV_EXCP_NONE;
> >  }
> >
> > @@ -3207,6 +3217,12 @@ static RISCVException write_menvcfgh(CPURISCVSta=
te *env, int csrno,
> >                      (cfg->ext_smcdeleg ? MENVCFG_CDE : 0) |
> >                      (cfg->ext_ssdbltrp ? MENVCFG_DTE : 0);
> >      uint64_t valh =3D (uint64_t)val << 32;
> > +    bool stce_changed =3D false;
> > +
> > +    if (cfg->ext_sstc &&
> > +        ((env->menvcfg & MENVCFG_STCE) !=3D (valh & MENVCFG_STCE))) {
> > +        stce_changed =3D true;
> > +    }
> >
> >      if ((valh & MENVCFG_DTE) =3D=3D 0) {
> >          env->mstatus &=3D ~MSTATUS_SDT;
> > @@ -3215,6 +3231,10 @@ static RISCVException write_menvcfgh(CPURISCVSta=
te *env, int csrno,
> >      env->menvcfg =3D (env->menvcfg & ~mask) | (valh & mask);
> >      write_henvcfgh(env, CSR_HENVCFGH, env->henvcfg >> 32);
> >
> > +    if (stce_changed) {
> > +        riscv_timer_stce_changed(env, true, !!(valh & MENVCFG_STCE));
> > +    }
> > +
> >      return RISCV_EXCP_NONE;
> >  }
> >
> > @@ -3292,8 +3312,10 @@ static RISCVException read_henvcfg(CPURISCVState=
 *env, int csrno,
> >  static RISCVException write_henvcfg(CPURISCVState *env, int csrno,
> >                                      target_ulong val)
> >  {
> > +    const RISCVCPUConfig *cfg =3D riscv_cpu_cfg(env);
> >      uint64_t mask =3D HENVCFG_FIOM | HENVCFG_CBIE | HENVCFG_CBCFE | HE=
NVCFG_CBZE;
> >      RISCVException ret;
> > +    bool stce_changed =3D false;
> >
> >      ret =3D smstateen_acc_ok(env, 0, SMSTATEEN0_HSENVCFG);
> >      if (ret !=3D RISCV_EXCP_NONE) {
> > @@ -3319,6 +3341,11 @@ static RISCVException write_henvcfg(CPURISCVStat=
e *env, int csrno,
> >              get_field(val, HENVCFG_PMM) !=3D PMM_FIELD_RESERVED) {
> >              mask |=3D HENVCFG_PMM;
> >          }
> > +
> > +        if (cfg->ext_sstc &&
> > +            ((env->henvcfg & HENVCFG_STCE) !=3D (val & HENVCFG_STCE)))=
 {
> > +            stce_changed =3D true;
> > +        }
> >      }
> >
> >      env->henvcfg =3D val & mask;
> > @@ -3326,6 +3353,10 @@ static RISCVException write_henvcfg(CPURISCVStat=
e *env, int csrno,
> >          env->vsstatus &=3D ~MSTATUS_SDT;
> >      }
> >
> > +    if (stce_changed) {
> > +        riscv_timer_stce_changed(env, false, !!(val & HENVCFG_STCE));
> > +    }
> > +
> >      return RISCV_EXCP_NONE;
> >  }
> >
> > @@ -3347,19 +3378,32 @@ static RISCVException read_henvcfgh(CPURISCVSta=
te *env, int csrno,
> >  static RISCVException write_henvcfgh(CPURISCVState *env, int csrno,
> >                                       target_ulong val)
> >  {
> > +    const RISCVCPUConfig *cfg =3D riscv_cpu_cfg(env);
> >      uint64_t mask =3D env->menvcfg & (HENVCFG_PBMTE | HENVCFG_STCE |
> >                                      HENVCFG_ADUE | HENVCFG_DTE);
> >      uint64_t valh =3D (uint64_t)val << 32;
> >      RISCVException ret;
> > +    bool stce_changed =3D false;
> >
> >      ret =3D smstateen_acc_ok(env, 0, SMSTATEEN0_HSENVCFG);
> >      if (ret !=3D RISCV_EXCP_NONE) {
> >          return ret;
> >      }
> > +
> > +    if (cfg->ext_sstc &&
> > +        ((env->henvcfg & HENVCFG_STCE) !=3D (valh & HENVCFG_STCE))) {
> > +        stce_changed =3D true;
> > +    }
> > +
> >      env->henvcfg =3D (env->henvcfg & 0xFFFFFFFF) | (valh & mask);
> >      if ((env->henvcfg & HENVCFG_DTE) =3D=3D 0) {
> >          env->vsstatus &=3D ~MSTATUS_SDT;
> >      }
> > +
> > +    if (stce_changed) {
> > +        riscv_timer_stce_changed(env, false, !!(val & HENVCFG_STCE));
> > +    }
> > +
> >      return RISCV_EXCP_NONE;
> >  }
> >
> > diff --git a/target/riscv/time_helper.c b/target/riscv/time_helper.c
> > index aebf0798d0..c648c9fac7 100644
> > --- a/target/riscv/time_helper.c
> > +++ b/target/riscv/time_helper.c
> > @@ -140,6 +140,57 @@ void riscv_timer_write_timecmp(CPURISCVState *env,=
 QEMUTimer *timer,
> >      timer_mod(timer, next);
> >  }
> >
> > +/*
> > + * When disabling xenvcfg.STCE, the S/VS Timer may be disabled at the =
same time.
> > + * It is safe to call this function regardless of whether the timer ha=
s been
> > + * deleted or not. timer_del() will do nothing if the timer has alread=
y
> > + * been deleted.
> > + */
> > +static void riscv_timer_disable_timecmp(CPURISCVState *env, QEMUTimer =
*timer,
> > +                                 uint32_t timer_irq)
> > +{
> > +    /* Disable S-mode Timer IRQ and HW-based STIP */
> > +    if ((timer_irq =3D=3D MIP_STIP) && !get_field(env->menvcfg, MENVCF=
G_STCE)) {
> > +        riscv_cpu_update_mip(env, timer_irq, BOOL_TO_MASK(0));
> > +        timer_del(timer);
> > +        return;
> > +    }
> > +
> > +    /* Disable VS-mode Timer IRQ and HW-based VSTIP */
> > +    if ((timer_irq =3D=3D MIP_VSTIP) &&
> > +        (!get_field(env->menvcfg, MENVCFG_STCE) ||
> > +         !get_field(env->henvcfg, HENVCFG_STCE))) {
> > +        env->vstime_irq =3D 0;
> > +        riscv_cpu_update_mip(env, 0, BOOL_TO_MASK(0));
> > +        timer_del(timer);
> > +        return;
> > +    }
> > +}
> > +
> > +/* Enable or disable S/VS-mode Timer when xenvcfg.STCE is changed */
> > +void riscv_timer_stce_changed(CPURISCVState *env, bool is_m_mode, bool=
 enable)
> > +{
> > +    if (is_m_mode) {
> > +        /* menvcfg.STCE changes */
> > +        if (enable) {
> > +            riscv_timer_write_timecmp(env, env->stimer, env->stimecmp,=
 0, MIP_STIP);
> > +            riscv_timer_write_timecmp(env, env->vstimer, env->vstimecm=
p,
> > +                                      env->htimedelta, MIP_VSTIP);
>
> This line and ...
>
> > +        } else {
> > +            riscv_timer_disable_timecmp(env, env->stimer, MIP_STIP);
> > +            riscv_timer_disable_timecmp(env, env->vstimer, MIP_VSTIP);
>
> This line are duplicated below.
>
> > +        }
> > +    } else {
>
> We can remove the else
>
> > +        /* henvcfg.STCE changes */
> > +        if (enable) {
> > +            riscv_timer_write_timecmp(env, env->vstimer, env->vstimecm=
p,
> > +                                      env->htimedelta, MIP_VSTIP);
> > +        } else {
> > +            riscv_timer_disable_timecmp(env, env->vstimer, MIP_VSTIP);
> > +        }
>
> and always run this branch to remove the duplicated code above
>
> Alistair
>
> > +    }
> > +}
> > +
> >  void riscv_timer_init(RISCVCPU *cpu)
> >  {
> >      CPURISCVState *env;
> > diff --git a/target/riscv/time_helper.h b/target/riscv/time_helper.h
> > index cacd79b80c..af1f634f89 100644
> > --- a/target/riscv/time_helper.h
> > +++ b/target/riscv/time_helper.h
> > @@ -25,6 +25,7 @@
> >  void riscv_timer_write_timecmp(CPURISCVState *env, QEMUTimer *timer,
> >                                 uint64_t timecmp, uint64_t delta,
> >                                 uint32_t timer_irq);
> > +void riscv_timer_stce_changed(CPURISCVState *env, bool is_m_mode, bool=
 enable);
> >  void riscv_timer_init(RISCVCPU *cpu);
> >
> >  #endif
> > --
> > 2.17.1
> >
> >

