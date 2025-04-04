Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6E3E5C36010
	for <qemu-devel@archiver.kernel.org>; Fri,  4 Apr 2025 06:04:03 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u0a96-0001Fa-5U; Fri, 04 Apr 2025 02:03:16 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1u0a95-0001FJ-1c; Fri, 04 Apr 2025 02:03:15 -0400
Received: from mail-vk1-xa36.google.com ([2607:f8b0:4864:20::a36])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1u0a92-0007I0-SS; Fri, 04 Apr 2025 02:03:14 -0400
Received: by mail-vk1-xa36.google.com with SMTP id
 71dfb90a1353d-523dc190f95so845233e0c.1; 
 Thu, 03 Apr 2025 23:03:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1743746591; x=1744351391; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=unPCSx6AQFYj12/RyC9QvD2Ewl7EObuHkMI4n+tnEvo=;
 b=fMnneHRGZql2Zr5E7Tc9iMjt0IOZszusA/boM3jsmVuBZt5BVMK1kq5+PAg3kzQrEQ
 dt5DZJUVDnYzQVcXOaNT/qzdkOYqGsrG6ubBi0RuuHsCWhMTien8yFjO0Ywlx5bt2WbG
 ajQkTci1RHxH+0LfUnAD+iMuwcnz0bn4YK3ytZB/vNIRBqYq5vVfZVBZxqvwe7Ihax10
 YIch2LG481r99cMCk3F//S6JIsVsZegFHwIr9UIHnT2fPs/AcnoqvyHoE2/8M72eAWHC
 sw5Wlg0hU5JAH2d7Ra5HAWCX9iVtzjoxEI1sjnZFlmpSfifd890vLWYDARVmWN9i/iv5
 v61w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1743746591; x=1744351391;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=unPCSx6AQFYj12/RyC9QvD2Ewl7EObuHkMI4n+tnEvo=;
 b=V58cx/JwSg4ofjfoFbYaTDex04eEhIX/NSLiqx02N5ScQCriWk4rJHcOwuV3KSbxZ9
 MChxsRuwimv7FuKBd3SN1jIUM9/I30a9QEqx5TzKfm4RCLuY+msXIW+bshxuNmm+jD5Q
 EFOyySINuZJqvZ8YYCNqsN5h1PMkLMi8dgqN1jM04speBakmx/aA2T+f0qkPwpKRkGNF
 26VRSL2lzuoeEbbYkH1w4kOtVpgFKLCL8hOcLm+bz8xxrBTlUh6b4BwIOWljjK0sKqvs
 G9vBpstMs4aK5hso5S/xVnbmE5BviWVUJ6sfAhsjINynCaUqlo8JEfWxe+mrsdpMrRMH
 vhvg==
X-Forwarded-Encrypted: i=1;
 AJvYcCVD5jLVy7hRPzHVe0RUpad88iCH3olkjRZppHH7aM5AbBrbsqkl6oRzAce24J/akpY2tZn6IjFmlqOF@nongnu.org
X-Gm-Message-State: AOJu0Yw90FK+CFFhtFvlCggXP5Vyuzwr/jAZtAx8shErtzIJcjmHdqWU
 Q0Z5kk8amwNVVshrf3yNbx+eg9UNyKqhQFVo88sNzu6BxZ0F4qi1zC3jE1SHnJ0w2qg7UC5slP/
 8EJnj3i7RouL6vLS6zgnbx9dctqU=
X-Gm-Gg: ASbGncs4xSO1LPGQtrcXWfMxx5V53l9DnrWygsUt+7nZ2pwndNrAkF7RZW/EjhKAtE8
 M5KOteV8OL3fD55ajeOQZehQ/qC+Upm7EhpIiWGiNpqI+dFM3+/aiaMZseFL3zujbK9JO8BnC5o
 419BsDF05kclOjcGIt9sh3WtaxDYJNkCXGRimTQP60mFkWw5AKHbdaS1Bd
X-Google-Smtp-Source: AGHT+IFNw7WlE2piD2N+fO5KsmYr+AvD4kDH+b9polVkxC6XmuKpIzolCFW/KiV+EJfMkBJFdeZmRsSrZByz91eq3h4=
X-Received: by 2002:a05:6122:8c01:b0:525:9440:243c with SMTP id
 71dfb90a1353d-527645a5e47mr1314490e0c.11.1743746591289; Thu, 03 Apr 2025
 23:03:11 -0700 (PDT)
MIME-Version: 1.0
References: <20250319192153.28549-1-jim.shu@sifive.com>
 <20250319192153.28549-5-jim.shu@sifive.com>
In-Reply-To: <20250319192153.28549-5-jim.shu@sifive.com>
From: Alistair Francis <alistair23@gmail.com>
Date: Fri, 4 Apr 2025 16:02:44 +1000
X-Gm-Features: ATxdqUFGmyW4qpF_gTaIOt8UmPZa1OtGW9vuBOlThVGTYnh6ffPWt8w6rhDbI2I
Message-ID: <CAKmqyKPFBaGdEQeLewGyvhNcmzqO0gtRN=4BytoAH7QO5qm_Lw@mail.gmail.com>
Subject: Re: [PATCH 4/4] target/riscv: Enable/Disable S/VS-mode Timer when
 STCE bit is changed
To: Jim Shu <jim.shu@sifive.com>
Cc: qemu-devel@nongnu.org, qemu-riscv@nongnu.org, 
 Palmer Dabbelt <palmer@dabbelt.com>,
 Alistair Francis <alistair.francis@wdc.com>, 
 Weiwei Li <liwei1518@gmail.com>,
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>, 
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::a36;
 envelope-from=alistair23@gmail.com; helo=mail-vk1-xa36.google.com
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

On Thu, Mar 20, 2025 at 5:24=E2=80=AFAM Jim Shu <jim.shu@sifive.com> wrote:
>
> Updating STCE will enable/disable SSTC in S-mode or/and VS-mode, so we
> also need to update S/VS-mode Timer and S/VSTIP bits in $mip CSR.
>
> Signed-off-by: Jim Shu <jim.shu@sifive.com>
> ---
>  target/riscv/csr.c         | 44 ++++++++++++++++++++++++++++++++
>  target/riscv/time_helper.c | 51 ++++++++++++++++++++++++++++++++++++++
>  target/riscv/time_helper.h |  1 +
>  3 files changed, 96 insertions(+)
>
> diff --git a/target/riscv/csr.c b/target/riscv/csr.c
> index ba026dfc8e..c954e49cae 100644
> --- a/target/riscv/csr.c
> +++ b/target/riscv/csr.c
> @@ -3156,6 +3156,7 @@ static RISCVException write_menvcfg(CPURISCVState *=
env, int csrno,
>      const RISCVCPUConfig *cfg =3D riscv_cpu_cfg(env);
>      uint64_t mask =3D MENVCFG_FIOM | MENVCFG_CBIE | MENVCFG_CBCFE |
>                      MENVCFG_CBZE | MENVCFG_CDE;
> +    bool stce_changed =3D false;
>
>      if (riscv_cpu_mxl(env) =3D=3D MXL_RV64) {
>          mask |=3D (cfg->ext_svpbmt ? MENVCFG_PBMTE : 0) |
> @@ -3181,10 +3182,19 @@ static RISCVException write_menvcfg(CPURISCVState=
 *env, int csrno,
>          if ((val & MENVCFG_DTE) =3D=3D 0) {
>              env->mstatus &=3D ~MSTATUS_SDT;
>          }
> +
> +        if (cfg->ext_sstc &&
> +            ((env->menvcfg & MENVCFG_STCE) !=3D (val & MENVCFG_STCE))) {
> +            stce_changed =3D true;
> +        }
>      }
>      env->menvcfg =3D (env->menvcfg & ~mask) | (val & mask);
>      write_henvcfg(env, CSR_HENVCFG, env->henvcfg);
>
> +    if (stce_changed) {
> +        riscv_timer_stce_changed(env, true, !!(val & MENVCFG_STCE));
> +    }
> +
>      return RISCV_EXCP_NONE;
>  }
>
> @@ -3207,6 +3217,12 @@ static RISCVException write_menvcfgh(CPURISCVState=
 *env, int csrno,
>                      (cfg->ext_smcdeleg ? MENVCFG_CDE : 0) |
>                      (cfg->ext_ssdbltrp ? MENVCFG_DTE : 0);
>      uint64_t valh =3D (uint64_t)val << 32;
> +    bool stce_changed =3D false;
> +
> +    if (cfg->ext_sstc &&
> +        ((env->menvcfg & MENVCFG_STCE) !=3D (valh & MENVCFG_STCE))) {
> +        stce_changed =3D true;
> +    }
>
>      if ((valh & MENVCFG_DTE) =3D=3D 0) {
>          env->mstatus &=3D ~MSTATUS_SDT;
> @@ -3215,6 +3231,10 @@ static RISCVException write_menvcfgh(CPURISCVState=
 *env, int csrno,
>      env->menvcfg =3D (env->menvcfg & ~mask) | (valh & mask);
>      write_henvcfgh(env, CSR_HENVCFGH, env->henvcfg >> 32);
>
> +    if (stce_changed) {
> +        riscv_timer_stce_changed(env, true, !!(valh & MENVCFG_STCE));
> +    }
> +
>      return RISCV_EXCP_NONE;
>  }
>
> @@ -3292,8 +3312,10 @@ static RISCVException read_henvcfg(CPURISCVState *=
env, int csrno,
>  static RISCVException write_henvcfg(CPURISCVState *env, int csrno,
>                                      target_ulong val)
>  {
> +    const RISCVCPUConfig *cfg =3D riscv_cpu_cfg(env);
>      uint64_t mask =3D HENVCFG_FIOM | HENVCFG_CBIE | HENVCFG_CBCFE | HENV=
CFG_CBZE;
>      RISCVException ret;
> +    bool stce_changed =3D false;
>
>      ret =3D smstateen_acc_ok(env, 0, SMSTATEEN0_HSENVCFG);
>      if (ret !=3D RISCV_EXCP_NONE) {
> @@ -3319,6 +3341,11 @@ static RISCVException write_henvcfg(CPURISCVState =
*env, int csrno,
>              get_field(val, HENVCFG_PMM) !=3D PMM_FIELD_RESERVED) {
>              mask |=3D HENVCFG_PMM;
>          }
> +
> +        if (cfg->ext_sstc &&
> +            ((env->henvcfg & HENVCFG_STCE) !=3D (val & HENVCFG_STCE))) {
> +            stce_changed =3D true;
> +        }
>      }
>
>      env->henvcfg =3D val & mask;
> @@ -3326,6 +3353,10 @@ static RISCVException write_henvcfg(CPURISCVState =
*env, int csrno,
>          env->vsstatus &=3D ~MSTATUS_SDT;
>      }
>
> +    if (stce_changed) {
> +        riscv_timer_stce_changed(env, false, !!(val & HENVCFG_STCE));
> +    }
> +
>      return RISCV_EXCP_NONE;
>  }
>
> @@ -3347,19 +3378,32 @@ static RISCVException read_henvcfgh(CPURISCVState=
 *env, int csrno,
>  static RISCVException write_henvcfgh(CPURISCVState *env, int csrno,
>                                       target_ulong val)
>  {
> +    const RISCVCPUConfig *cfg =3D riscv_cpu_cfg(env);
>      uint64_t mask =3D env->menvcfg & (HENVCFG_PBMTE | HENVCFG_STCE |
>                                      HENVCFG_ADUE | HENVCFG_DTE);
>      uint64_t valh =3D (uint64_t)val << 32;
>      RISCVException ret;
> +    bool stce_changed =3D false;
>
>      ret =3D smstateen_acc_ok(env, 0, SMSTATEEN0_HSENVCFG);
>      if (ret !=3D RISCV_EXCP_NONE) {
>          return ret;
>      }
> +
> +    if (cfg->ext_sstc &&
> +        ((env->henvcfg & HENVCFG_STCE) !=3D (valh & HENVCFG_STCE))) {
> +        stce_changed =3D true;
> +    }
> +
>      env->henvcfg =3D (env->henvcfg & 0xFFFFFFFF) | (valh & mask);
>      if ((env->henvcfg & HENVCFG_DTE) =3D=3D 0) {
>          env->vsstatus &=3D ~MSTATUS_SDT;
>      }
> +
> +    if (stce_changed) {
> +        riscv_timer_stce_changed(env, false, !!(val & HENVCFG_STCE));
> +    }
> +
>      return RISCV_EXCP_NONE;
>  }
>
> diff --git a/target/riscv/time_helper.c b/target/riscv/time_helper.c
> index aebf0798d0..c648c9fac7 100644
> --- a/target/riscv/time_helper.c
> +++ b/target/riscv/time_helper.c
> @@ -140,6 +140,57 @@ void riscv_timer_write_timecmp(CPURISCVState *env, Q=
EMUTimer *timer,
>      timer_mod(timer, next);
>  }
>
> +/*
> + * When disabling xenvcfg.STCE, the S/VS Timer may be disabled at the sa=
me time.
> + * It is safe to call this function regardless of whether the timer has =
been
> + * deleted or not. timer_del() will do nothing if the timer has already
> + * been deleted.
> + */
> +static void riscv_timer_disable_timecmp(CPURISCVState *env, QEMUTimer *t=
imer,
> +                                 uint32_t timer_irq)
> +{
> +    /* Disable S-mode Timer IRQ and HW-based STIP */
> +    if ((timer_irq =3D=3D MIP_STIP) && !get_field(env->menvcfg, MENVCFG_=
STCE)) {
> +        riscv_cpu_update_mip(env, timer_irq, BOOL_TO_MASK(0));
> +        timer_del(timer);
> +        return;
> +    }
> +
> +    /* Disable VS-mode Timer IRQ and HW-based VSTIP */
> +    if ((timer_irq =3D=3D MIP_VSTIP) &&
> +        (!get_field(env->menvcfg, MENVCFG_STCE) ||
> +         !get_field(env->henvcfg, HENVCFG_STCE))) {
> +        env->vstime_irq =3D 0;
> +        riscv_cpu_update_mip(env, 0, BOOL_TO_MASK(0));
> +        timer_del(timer);
> +        return;
> +    }
> +}
> +
> +/* Enable or disable S/VS-mode Timer when xenvcfg.STCE is changed */
> +void riscv_timer_stce_changed(CPURISCVState *env, bool is_m_mode, bool e=
nable)
> +{
> +    if (is_m_mode) {
> +        /* menvcfg.STCE changes */
> +        if (enable) {
> +            riscv_timer_write_timecmp(env, env->stimer, env->stimecmp, 0=
, MIP_STIP);
> +            riscv_timer_write_timecmp(env, env->vstimer, env->vstimecmp,
> +                                      env->htimedelta, MIP_VSTIP);

This line and ...

> +        } else {
> +            riscv_timer_disable_timecmp(env, env->stimer, MIP_STIP);
> +            riscv_timer_disable_timecmp(env, env->vstimer, MIP_VSTIP);

This line are duplicated below.

> +        }
> +    } else {

We can remove the else

> +        /* henvcfg.STCE changes */
> +        if (enable) {
> +            riscv_timer_write_timecmp(env, env->vstimer, env->vstimecmp,
> +                                      env->htimedelta, MIP_VSTIP);
> +        } else {
> +            riscv_timer_disable_timecmp(env, env->vstimer, MIP_VSTIP);
> +        }

and always run this branch to remove the duplicated code above

Alistair

> +    }
> +}
> +
>  void riscv_timer_init(RISCVCPU *cpu)
>  {
>      CPURISCVState *env;
> diff --git a/target/riscv/time_helper.h b/target/riscv/time_helper.h
> index cacd79b80c..af1f634f89 100644
> --- a/target/riscv/time_helper.h
> +++ b/target/riscv/time_helper.h
> @@ -25,6 +25,7 @@
>  void riscv_timer_write_timecmp(CPURISCVState *env, QEMUTimer *timer,
>                                 uint64_t timecmp, uint64_t delta,
>                                 uint32_t timer_irq);
> +void riscv_timer_stce_changed(CPURISCVState *env, bool is_m_mode, bool e=
nable);
>  void riscv_timer_init(RISCVCPU *cpu);
>
>  #endif
> --
> 2.17.1
>
>

