Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B53EAC3ABD8
	for <qemu-devel@archiver.kernel.org>; Mon, 19 May 2025 00:45:11 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uGocP-00062V-4s; Sun, 18 May 2025 20:44:37 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1uGocN-00062J-RH; Sun, 18 May 2025 20:44:35 -0400
Received: from mail-vk1-xa29.google.com ([2607:f8b0:4864:20::a29])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1uGocJ-0003H9-S5; Sun, 18 May 2025 20:44:34 -0400
Received: by mail-vk1-xa29.google.com with SMTP id
 71dfb90a1353d-52c55db3743so1019472e0c.1; 
 Sun, 18 May 2025 17:44:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1747615469; x=1748220269; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=WSvgOcAFtyo4Ec9z1HrvW7eGeNRrclUGECs5adckWzk=;
 b=jRiI2vDKJe0t32KlyjMNMGfs9mEzv7MDht3hVXEoYA5S5BtlfEn7v15t48SxDGTCXS
 uFx7bYZQ6+YgEzmUxt1S8oa/oAxRQ4O6XHGQwy8vodCKpBNrpfq2p5L+A7IPsYXL1YEy
 ABBBi9BKY5b8b8wcbzEOTsPMdTchXoRMgSmS5MpE9Zt5HAZddkKM2H7vNM18oJBFRiRv
 Ylx6MLWNZtejG7JWrx6noUkpFfTo+5d3zcPRsdF19DnXVjzYmGr15OouUZfY1VtTDLjS
 rDxVbvFlx/Sra5lI+yGD00pg5e9lgg6plI9FJpI9bTRkTN7fCb+UU+pMHuZHnXOt/vzb
 TPgQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1747615469; x=1748220269;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=WSvgOcAFtyo4Ec9z1HrvW7eGeNRrclUGECs5adckWzk=;
 b=IQiVRyyCwqvY2Q6XBpHm719E8s3po7nASjf3ZicgjEW0wWW+LjXUpenGPOFSAjXW8k
 8hSUZf0NvdXM5VAri/uNnNs/U8rVHxAl0HLm0h01QDzFCF8hxFm2NqdHkX+dBq4xM2+9
 4cDQ+HRTJhrcLIgf8AJLONjx+knO5LdhJVZdtR/UIwMShnHApMUQhLqDSj8JDKl52Yn5
 HAyoDXwzTQOEDyl9wgQk4QnCwXwWAE2B/qsxr00zcQGGZ3U0tjwieC9W/cbB5QVyLAvB
 xhWLIq19crSJtl8UJ1dxJefWtWzrIagsBMxz6STRvEv7isv6qSfAexyoCWpVMEd8kqLe
 zAEw==
X-Forwarded-Encrypted: i=1;
 AJvYcCVdc6C5abjW7O/j3LdU+fBdV2gyb7gB9/yY3jMoNXuTmkDjXlxd6ajMCbc1tGQOSZ3Ykfumrabi9DVd@nongnu.org
X-Gm-Message-State: AOJu0YxF1YaRt4d2VblHbQYokHqtNQdes7QZGaDNKMd4YpZDsRoDkxNC
 Ku8uDw2K6JaQ9uTs6hTpkXFYlc2vZgtLdYOabp+6mGa4wbO+LJR2DkreIyfUhAEUC+I/xDX/ZPp
 aGrQveggHbmOyIWcGx5byR6utQr2A8lA2CA==
X-Gm-Gg: ASbGncsIJk65jke2rx4f2J+WqraOpam/w8YiA7db5a2YT21Emn3J9pS9y7B02DYH6zq
 5RyCH5mtk8IMPN0nQX03bF5bSzC1xFNEU/x4AM5qOE5zatfskC5m5uHnEoeK9qG8AIdD78RYhDB
 fK90r+iJHlprhIGvPzqIfaVpbWpMfCHYDiSo+vKkA1WennsrZZ9OCoKVVU/g/Xap7cDwRy12OrE
 g==
X-Google-Smtp-Source: AGHT+IFeK/4oxFs17PebeM54kahX8I3vftS221vnDg2L0Y3MKGo6C6M51letrnFP6Sc14TkjAAgYROny9JpoYvSYDo4=
X-Received: by 2002:a05:6122:d16:b0:529:be0:8353 with SMTP id
 71dfb90a1353d-52dbcc563e6mr9877943e0c.2.1747615469481; Sun, 18 May 2025
 17:44:29 -0700 (PDT)
MIME-Version: 1.0
References: <20250409025131.3670-1-jim.shu@sifive.com>
 <20250409025131.3670-5-jim.shu@sifive.com>
In-Reply-To: <20250409025131.3670-5-jim.shu@sifive.com>
From: Alistair Francis <alistair23@gmail.com>
Date: Mon, 19 May 2025 10:44:02 +1000
X-Gm-Features: AX0GCFvANRXDQdoJ_Z-cUGfj8lmtr63VQbnPLA32srtY3cYaeu41z5ZzCtsDBkI
Message-ID: <CAKmqyKOb-eALzqMK+Hq9Bt=Te2AE04y_ZBzOpEhrpvr5_8MNiw@mail.gmail.com>
Subject: Re: [PATCH v2 4/4] target/riscv: Enable/Disable S/VS-mode Timer when
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
Received-SPF: pass client-ip=2607:f8b0:4864:20::a29;
 envelope-from=alistair23@gmail.com; helo=mail-vk1-xa29.google.com
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

On Wed, Apr 9, 2025 at 12:52=E2=80=AFPM Jim Shu <jim.shu@sifive.com> wrote:
>
> Updating STCE will enable/disable SSTC in S-mode or/and VS-mode, so we
> also need to update S/VS-mode Timer and S/VSTIP bits in $mip CSR.
>
> Signed-off-by: Jim Shu <jim.shu@sifive.com>

Acked-by: Alistair Francis <alistair.francis@wdc.com>

Alistair

> ---
>  target/riscv/csr.c         | 44 ++++++++++++++++++++++++++++++++++++
>  target/riscv/time_helper.c | 46 ++++++++++++++++++++++++++++++++++++++
>  target/riscv/time_helper.h |  1 +
>  3 files changed, 91 insertions(+)
>
> diff --git a/target/riscv/csr.c b/target/riscv/csr.c
> index e86808fd98..548daf6a7a 100644
> --- a/target/riscv/csr.c
> +++ b/target/riscv/csr.c
> @@ -3161,6 +3161,7 @@ static RISCVException write_menvcfg(CPURISCVState *=
env, int csrno,
>      const RISCVCPUConfig *cfg =3D riscv_cpu_cfg(env);
>      uint64_t mask =3D MENVCFG_FIOM | MENVCFG_CBIE | MENVCFG_CBCFE |
>                      MENVCFG_CBZE | MENVCFG_CDE;
> +    bool stce_changed =3D false;
>
>      if (riscv_cpu_mxl(env) =3D=3D MXL_RV64) {
>          mask |=3D (cfg->ext_svpbmt ? MENVCFG_PBMTE : 0) |
> @@ -3186,10 +3187,19 @@ static RISCVException write_menvcfg(CPURISCVState=
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
> @@ -3212,6 +3222,12 @@ static RISCVException write_menvcfgh(CPURISCVState=
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
> @@ -3220,6 +3236,10 @@ static RISCVException write_menvcfgh(CPURISCVState=
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
> @@ -3297,8 +3317,10 @@ static RISCVException read_henvcfg(CPURISCVState *=
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
> @@ -3324,6 +3346,11 @@ static RISCVException write_henvcfg(CPURISCVState =
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
> @@ -3331,6 +3358,10 @@ static RISCVException write_henvcfg(CPURISCVState =
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
> @@ -3352,19 +3383,32 @@ static RISCVException read_henvcfgh(CPURISCVState=
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
> index aebf0798d0..400e917354 100644
> --- a/target/riscv/time_helper.c
> +++ b/target/riscv/time_helper.c
> @@ -140,6 +140,52 @@ void riscv_timer_write_timecmp(CPURISCVState *env, Q=
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
> +    if (enable) {
> +        riscv_timer_write_timecmp(env, env->vstimer, env->vstimecmp,
> +                                  env->htimedelta, MIP_VSTIP);
> +    } else {
> +        riscv_timer_disable_timecmp(env, env->vstimer, MIP_VSTIP);
> +    }
> +
> +    if (is_m_mode) {
> +        if (enable) {
> +            riscv_timer_write_timecmp(env, env->stimer, env->stimecmp, 0=
, MIP_STIP);
> +        } else {
> +            riscv_timer_disable_timecmp(env, env->stimer, MIP_STIP);
> +        }
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

