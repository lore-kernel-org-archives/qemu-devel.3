Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4751AFF8867
	for <qemu-devel@archiver.kernel.org>; Tue, 28 Apr 2026 02:59:49 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wHYfM-00018R-PL; Mon, 27 Apr 2026 22:59:16 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1wHYfK-00017o-VC
 for qemu-devel@nongnu.org; Mon, 27 Apr 2026 22:59:14 -0400
Received: from mail-ej1-x62a.google.com ([2a00:1450:4864:20::62a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1wHYfJ-0000vm-BH
 for qemu-devel@nongnu.org; Mon, 27 Apr 2026 22:59:14 -0400
Received: by mail-ej1-x62a.google.com with SMTP id
 a640c23a62f3a-b9c3e2cf3c0so1852958866b.1
 for <qemu-devel@nongnu.org>; Mon, 27 Apr 2026 19:59:12 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1777345151; cv=none;
 d=google.com; s=arc-20240605;
 b=KYfnuogBaEB50MnH32zqtTIJgtLbvlNr7CRRrPHjp3Q10KEQ8Qsrz9PfaOpqVZYpeO
 Ahf+jvI6kG6y2exdu3BKjeu8bC4RopdTlGLkL1nhyz70R3AZItrUhDbp5uMPXLKfwuRj
 309HUO8pZjzPWvHBcI7OiC73YX3jUL5uCQMk/8o2dBvLg2b39kt5ZqJ3id2Z7mx9QlXF
 ktPOGb3VmE47PwgF+E8BVbzsecEohLgiH/v102Y20yUAaGJZoXMWZP0WEegUWt0GVXvz
 u7ZtfD0xO2Uk+ai5IiVjtzeg+5hMDjRvDI6/DwDqt3oCB6tG9aOVWHxCA8L7bkpm5w/x
 g6Vg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=nqXW4V7Z7yOQxhOYQjNZIqTVn3L5kpgyHP52Rgrt+VM=;
 fh=LooIvm3XqX8KsPkvrl6FxlquFJj5aKz3cS9aa4O7vws=;
 b=aY3PWkTRxhgOeYfb48Rl66siTPM0tp9BGrL5iBSQ/WwVIV+4FmSzbWp5Xx++vhK+Si
 hgcZmz+a5ny3ppRnhPD9syRaDlqVhjFq3ebvQqQ8WIFY6/rOcGWuqwXy1VCzfFhB1dF6
 LSpqie1WITqRpXFVFtu+6uGGKTKRCkeJDWbkjBwFy+6sPTNi/7FND3wQZFLO6Z0cLPgH
 EMBjgzXjxtVOnVIhNVp9ehFTe8BScpASdw1TpuzYV+w8Jcr4V9V92xbAbJrLQp+TCQ60
 xXkGAlW/JvPaHg+QLzZG2hHNX0V0p9T94a8liEIIjVEfXyZIUpHqgoqC4qnrXBAFG8bK
 dGUA==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1777345151; x=1777949951; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=nqXW4V7Z7yOQxhOYQjNZIqTVn3L5kpgyHP52Rgrt+VM=;
 b=JCl160KxSG0gp1C3NaLeH9rRnwEKkoDWbe0rkJH2XPfDk8kp+6bjgZPUh6JLbweAPx
 MldtqipZ17bNrxUe3w50sme8vYQUau56SNQ3Q0TiHVE4pGPiLNvqDMVSbw6sPDIJFnkw
 fIaM5pRHx8Qgu/2uHiQYn21D5/YB7In2k4MPDnyMrfbdY6nQaa4ZPf2rAy0MEklLF8bl
 Ns69h5ZLCna43QZydqEHwQcuDZLhCzT0A6xloLg91y8fayIoY/m56YB7vw3tqnrhr4aD
 Am1uy39z3OF0Phpx1gQiUZ1hvqYTXKeH0w8SRB5CodseLKexrUjhqp9QsFuioChbBphR
 AMJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1777345151; x=1777949951;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=nqXW4V7Z7yOQxhOYQjNZIqTVn3L5kpgyHP52Rgrt+VM=;
 b=j+WuyUZ24GyoPS7gK4WDXfhwUL9Bb6v71lV0kEYQL4m3JTmn162oq4AOqYST7YPRD4
 jjcfoqhdFR8/siR2c109wYsqCiflJ9o0BfWE8eaKYxZbIjP1sMbPypfmeJOIJLlSyw88
 pzsaJvmjDwoHLcAngVzUA/QyB+LJ2gO/48dtw8dxpYWhHkWjWFgJaj5rGMXI4xdYr7cz
 RsQ04+6Gkp/Rr+Z0LeOvthGszTKsbd4tU11oc0B0868UwkMxn6dmsuhUS6v19hVyJYDc
 /JaJbIvY26jYv/DlaQVIT9NMU13acxLMtaSuVWSkAVRZ3ZQ9GauuEG0JV2FkSfECs/Th
 SBdA==
X-Gm-Message-State: AOJu0YzUOrnXLOvkuLH4yXN/BSbRAVB0dzx3MXe7dDYQVjszTWv72fbV
 AF/vFE6VsRVjf2EbBaVhTErzBt5PXOb2P25Ia5qCKbBrKHuB2+qc76ySSp6LUCKZ8GNdlp32cn0
 oaoUembPPQFA6eiqhTy6+WISKT/0WLTI=
X-Gm-Gg: AeBDietxlPhpBX+Q2mv1nOQr2GX0VvSZBjzqvQBJqzObBGHlvof0ONIUMKS9h186ZnN
 pQe3T5C9kfmqiEF0strfevwNsH/ROJzQ4l0mTC6iU4u5lllk9jURC/c1j0D24/i2jblrHRJNOEs
 mFMf1j/YM6psl9prO+vKlCQWnRJfQqwMXruAjRn8rfBG+Axsm+rWA6lAioOECEr2glaDu56sOhz
 soAOKGdcKbEsTkRVYJ3ltEl1zE/lGC82MNsEWMvzDDU/Ob397sMSL92fSF6qo2F7RNl91TV9a2F
 sOrSkAYfftrTQBJ1PeutVs59kVF3SYB5+Rb1MoAfEb6NelfS
X-Received: by 2002:a17:907:7295:b0:ba8:ca25:e6ab with SMTP id
 a640c23a62f3a-bb801ad6b78mr75564366b.11.1777345151037; Mon, 27 Apr 2026
 19:59:11 -0700 (PDT)
MIME-Version: 1.0
References: <20260421093715.2995067-1-frank.chang@sifive.com>
 <20260421093715.2995067-4-frank.chang@sifive.com>
In-Reply-To: <20260421093715.2995067-4-frank.chang@sifive.com>
From: Alistair Francis <alistair23@gmail.com>
Date: Tue, 28 Apr 2026 12:58:44 +1000
X-Gm-Features: AVHnY4L-MRlGeTdPxqPkHrVVE4hqLEKnSUjAVBTMPERP9xAKuX4PKGFxaqhYRBI
Message-ID: <CAKmqyKOOnzUZzJ-9e7EAZVijJONhZGyUp=_MvmQJWFPiwu-D=g@mail.gmail.com>
Subject: Re: [PATCH v4 3/6] target/riscv: Fix pointer masking PMM field
 selection logic
To: frank.chang@sifive.com
Cc: qemu-devel@nongnu.org, Palmer Dabbelt <palmer@dabbelt.com>, 
 Alistair Francis <alistair.francis@wdc.com>, Weiwei Li <liwei1518@gmail.com>, 
 Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>,
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>, 
 Chao Liu <chao.liu.zevorn@gmail.com>, 
 "open list:RISC-V TCG CPUs" <qemu-riscv@nongnu.org>,
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::62a;
 envelope-from=alistair23@gmail.com; helo=mail-ej1-x62a.google.com
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
List-Id: qemu development <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

On Tue, Apr 21, 2026 at 7:38=E2=80=AFPM <frank.chang@sifive.com> wrote:
>
> From: Frank Chang <frank.chang@sifive.com>
>
> mstatus.MPV only records the previous virtualization state, and does not
> affect pointer masking according to the Zjpm specification.
>
> This patch rewrites riscv_pm_get_pmm() to follow the architectural
> definition of Smmpm, Smnpm, and Ssnpm.
>
> The resulting PMM selection logic for each mode is summarized below:
>
>   * mstatus.MXR =3D 1: pointer masking disabled
>
>   * Smmpm + Smnpm + Ssnpm:
>       M-mode:  mseccfg.PMM
>       S-mode:  menvcfg.PMM
>       U-mode:  senvcfg.PMM
>       VS-mode: henvcfg.PMM
>       VU-mode: senvcfg.PMM
>
>   * Smmpm + Smnpm (RVS implemented):
>       M-mode:  mseccfg.PMM
>       S-mode:  menvcfg.PMM
>       U/VS/VU: disabled (Ssnpm not present)
>
>   * Smmpm + Smnpm (RVS not implemented):
>       M-mode:  mseccfg.PMM
>       U-mode:  menvcfg.PMM
>       S/VS/VU: disabled (no S-mode)
>
>   * Smmpm only:
>       M-mode:  mseccfg.PMM
>       Other existing modes: pointer masking disabled
>
> Signed-off-by: Frank Chang <frank.chang@sifive.com>
> Reviewed-by: Daniel Henrique Barboza <dbarboza@ventanamicro.com>

Reviewed-by: Alistair Francis <alistair.francis@wdc.com>

Alistair

> ---
>  target/riscv/cpu_helper.c | 51 +++++++++++++++++++++++++++++++++------
>  1 file changed, 44 insertions(+), 7 deletions(-)
>
> diff --git a/target/riscv/cpu_helper.c b/target/riscv/cpu_helper.c
> index 513bad21afa..bab4153e53b 100644
> --- a/target/riscv/cpu_helper.c
> +++ b/target/riscv/cpu_helper.c
> @@ -131,13 +131,47 @@ bool riscv_env_smode_dbltrp_enabled(CPURISCVState *=
env, bool virt)
>  #endif
>  }
>
> +/*
> + * Returns the effective PMM field.
> + *
> + * @env: CPURISCVState
> + *
> + * The PMM field selection logic for each effective privilege mode
> + * is as follows:
> + *
> + * - mstatus.MXR =3D 1: disabled
> + *
> + * - Smmpm + Smnpm + Ssnpm:
> + *     M-mode:  mseccfg.PMM
> + *     S-mode:  menvcfg.PMM
> + *     U-mode:  senvcfg.PMM
> + *     VS-mode: henvcfg.PMM
> + *     VU-mode: senvcfg.PMM
> + *
> + * - Smmpm + Smnpm (RVS implemented):
> + *     M-mode:  mseccfg.PMM
> + *     S-mode:  menvcfg.PMM
> + *     U/VS/VU: disabled (Ssnpm not present)
> + *
> + * - Smmpm + Smnpm (RVS not implemented):
> + *     M-mode:  mseccfg.PMM
> + *     U-mode:  menvcfg.PMM
> + *     S/VS/VU: disabled (no S-mode)
> + *
> + * - Smmpm only:
> + *     M-mode:  mseccfg.PMM
> + *     Other existing modes: disabled
> + */
>  RISCVPmPmm riscv_pm_get_pmm(CPURISCVState *env)
>  {
>  #ifndef CONFIG_USER_ONLY
> -    int priv_mode =3D cpu_address_mode(env);
> +    int priv_mode;
> +    bool virt;
> +
> +    riscv_cpu_eff_priv(env, &priv_mode, &virt);
>
> -    if (get_field(env->mstatus, MSTATUS_MPRV) &&
> -        get_field(env->mstatus, MSTATUS_MXR)) {
> +    if ((priv_mode !=3D PRV_M && get_field(env->mstatus, MSTATUS_MXR)) |=
|
> +        (virt && get_field(env->vsstatus, MSTATUS_MXR))) {
>          return PMM_FIELD_DISABLED;
>      }
>
> @@ -149,12 +183,14 @@ RISCVPmPmm riscv_pm_get_pmm(CPURISCVState *env)
>          }
>          break;
>      case PRV_S:
> -        if (riscv_cpu_cfg(env)->ext_smnpm) {
> -            if (get_field(env->mstatus, MSTATUS_MPV)) {
> -                return get_field(env->henvcfg, HENVCFG_PMM);
> -            } else {
> +        if (!virt) {
> +            if (riscv_cpu_cfg(env)->ext_smnpm) {
>                  return get_field(env->menvcfg, MENVCFG_PMM);
>              }
> +        } else {
> +            if (riscv_cpu_cfg(env)->ext_ssnpm) {
> +                return get_field(env->henvcfg, HENVCFG_PMM);
> +            }
>          }
>          break;
>      case PRV_U:
> @@ -171,6 +207,7 @@ RISCVPmPmm riscv_pm_get_pmm(CPURISCVState *env)
>      default:
>          g_assert_not_reached();
>      }
> +
>      return PMM_FIELD_DISABLED;
>  #else
>      return PMM_FIELD_DISABLED;
> --
> 2.43.0
>
>

