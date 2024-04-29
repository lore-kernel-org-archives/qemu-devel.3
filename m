Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1566FC4345F
	for <qemu-devel@archiver.kernel.org>; Mon, 29 Apr 2024 04:09:20 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s1IJz-0006it-Ph; Mon, 29 Apr 2024 00:08:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1s1IJp-0006gC-5k; Mon, 29 Apr 2024 00:08:45 -0400
Received: from mail-vk1-xa36.google.com ([2607:f8b0:4864:20::a36])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1s1IJn-0002DK-GL; Mon, 29 Apr 2024 00:08:44 -0400
Received: by mail-vk1-xa36.google.com with SMTP id
 71dfb90a1353d-4dab344ace5so1082708e0c.3; 
 Sun, 28 Apr 2024 21:08:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1714363720; x=1714968520; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=iuxX0DfE2ioM8GqORqaUXBJyHlAExjOT5uU/LlQXZqo=;
 b=V1r9GLX0tAxYGPq+voA/73oNi04Z3gAwsft+vSmFnUYmnN7jk/pizNyrpRwKbyrUOP
 8OWO660SIGXsgAtbCBkHMoQOUn96GDiGtHbjBnk7p2gR6QRri1XE3GXWPPPIKk9XvnOy
 WXFaW1E1okjTtBgAjOdxyWE+EQN/At1FzKhE25/rmwp7TYyCI0J3Pt6HgAJxvYMadd1n
 7AX+nteUoPm6oIw0iOtJAgchV7wLISgdUcS5JwBhaCY3GSRKfYS1CHtgz9aSR4vMIYFM
 GOPhfobjUR3ofMCkHpBye9x7xsc8UhPiDxKGzfSbdYYOLY6P4BiPd0ofbLIgN1Barjn/
 ZF9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1714363720; x=1714968520;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=iuxX0DfE2ioM8GqORqaUXBJyHlAExjOT5uU/LlQXZqo=;
 b=JALl83Ww6cT4Zw/LuB96e1mrjrkq3h8aFnNnG0yPKODmqGTproSNFBA8j3TswKyudg
 gXH5mB/HQeW3ELH7us9AC/y/mL1UczbnFxihJ2w5936oEOItxP0uDqbP2lRVkaqa2Tur
 oQCXGHW8zqeFDUeCKJ5uuVKC1B6lsANN77/qDQ4iyIg9CtndJzUVWK6BXLgek46C4omF
 TKDQxgRdarvNHOX3pFxM5vpDeYevCkhLgELykotchBaYS85PFPJS2o0FWMFu+UjEwkDB
 INirwNzdEhaSNXM7adEPwQZ0cs4mi30Gap6VxXkA29wDEcpSODAdzBSQORU1HGteWfV4
 0LOw==
X-Forwarded-Encrypted: i=1;
 AJvYcCUS2CwnSTZa1lEPTNEiSmcDeFLDn626UT+ShzNUWtLiu6R4S7y0Ue25NeU9K4SqaMGc4gZc4IvTDR4yHDcDxuNSZ/nx9yM=
X-Gm-Message-State: AOJu0YxNhr0FNIwQhYHez/Ao5qnr730uU327iulI6YxOU4aIGHogAcLb
 0eH8RxVnYJw6dRQWugZjkgfT8uL30HwgAxvBM8nLcmsLzHYGrtd7Fn6/0goDCCT10x/4NW8A7Jl
 G7dfPlM2xl6bD8xesn2zMq66PDAQ=
X-Google-Smtp-Source: AGHT+IF0OMgdKc99hV+4eW+MwVi+AOZ1dieLgXa+RnLtt13e9/CXjbU4iFKQ+PsreHsyro8Oz4Fd5IN/jjiV83yT+TQ=
X-Received: by 2002:a05:6122:2a0f:b0:4d3:1ef2:c97d with SMTP id
 fw15-20020a0561222a0f00b004d31ef2c97dmr9129665vkb.2.1714363720106; Sun, 28
 Apr 2024 21:08:40 -0700 (PDT)
MIME-Version: 1.0
References: <20240314185957.36940-1-hchauhan@ventanamicro.com>
 <20240314185957.36940-3-hchauhan@ventanamicro.com>
In-Reply-To: <20240314185957.36940-3-hchauhan@ventanamicro.com>
From: Alistair Francis <alistair23@gmail.com>
Date: Mon, 29 Apr 2024 14:08:14 +1000
Message-ID: <CAKmqyKPLh7cOz3orJ0BBihNvR=d7s2X2M+ykY0vrwYKHAKFzMg@mail.gmail.com>
Subject: Re: [PATCH v7 2/4] target/riscv: Enable mcontrol6 triggers only when
 sdtrig is selected
To: Himanshu Chauhan <hchauhan@ventanamicro.com>
Cc: qemu-riscv@nongnu.org, qemu-devel@nongnu.org, ajones@ventanamicro.com
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

On Fri, Mar 15, 2024 at 5:01=E2=80=AFAM Himanshu Chauhan
<hchauhan@ventanamicro.com> wrote:
>
> The mcontrol6 triggers are not defined in debug specification v0.13
> These triggers are defined in sdtrig ISA extension.
>
> This patch:
>    * Adds ext_sdtrig capability which is used to select mcontrol6 trigger=
s
>    * Keeps the debug property. All triggers that are defined in v0.13 are
>      exposed.

Thanks for this!

>
> Signed-off-by: Himanshu Chauhan <hchauhan@ventanamicro.com>
> ---
>  target/riscv/cpu.c     |  5 +++++
>  target/riscv/cpu_cfg.h |  1 +
>  target/riscv/debug.c   | 30 +++++++++++++++++++++++++-----
>  3 files changed, 31 insertions(+), 5 deletions(-)
>
> diff --git a/target/riscv/cpu.c b/target/riscv/cpu.c
> index c160b9216b..ab631500ac 100644
> --- a/target/riscv/cpu.c
> +++ b/target/riscv/cpu.c
> @@ -1008,6 +1008,11 @@ static void riscv_cpu_reset_hold(Object *obj)
>      set_default_nan_mode(1, &env->fp_status);
>
>  #ifndef CONFIG_USER_ONLY
> +    if (!cpu->cfg.debug && cpu->cfg.ext_sdtrig) {
> +        warn_report("Enabling 'debug' since 'sdtrig' is enabled.");

I don't think we need the warning. It isn't a problem for the user

Otherwise

Reviewed-by: Alistair Francis <alistair.francis@wdc.com>

Alistair

> +        cpu->cfg.debug =3D true;
> +    }
> +
>      if (cpu->cfg.debug) {
>          riscv_trigger_reset_hold(env);
>      }
> diff --git a/target/riscv/cpu_cfg.h b/target/riscv/cpu_cfg.h
> index 2040b90da0..0c57e1acd4 100644
> --- a/target/riscv/cpu_cfg.h
> +++ b/target/riscv/cpu_cfg.h
> @@ -114,6 +114,7 @@ struct RISCVCPUConfig {
>      bool ext_zvfbfwma;
>      bool ext_zvfh;
>      bool ext_zvfhmin;
> +    bool ext_sdtrig;
>      bool ext_smaia;
>      bool ext_ssaia;
>      bool ext_sscofpmf;
> diff --git a/target/riscv/debug.c b/target/riscv/debug.c
> index 5f14b39b06..c40e727e12 100644
> --- a/target/riscv/debug.c
> +++ b/target/riscv/debug.c
> @@ -100,13 +100,16 @@ static trigger_action_t get_trigger_action(CPURISCV=
State *env,
>      target_ulong tdata1 =3D env->tdata1[trigger_index];
>      int trigger_type =3D get_trigger_type(env, trigger_index);
>      trigger_action_t action =3D DBG_ACTION_NONE;
> +    const RISCVCPUConfig *cfg =3D riscv_cpu_cfg(env);
>
>      switch (trigger_type) {
>      case TRIGGER_TYPE_AD_MATCH:
>          action =3D (tdata1 & TYPE2_ACTION) >> 12;
>          break;
>      case TRIGGER_TYPE_AD_MATCH6:
> -        action =3D (tdata1 & TYPE6_ACTION) >> 12;
> +        if (cfg->ext_sdtrig) {
> +            action =3D (tdata1 & TYPE6_ACTION) >> 12;
> +        }
>          break;
>      case TRIGGER_TYPE_INST_CNT:
>      case TRIGGER_TYPE_INT:
> @@ -727,7 +730,12 @@ void tdata_csr_write(CPURISCVState *env, int tdata_i=
ndex, target_ulong val)
>          type2_reg_write(env, env->trigger_cur, tdata_index, val);
>          break;
>      case TRIGGER_TYPE_AD_MATCH6:
> -        type6_reg_write(env, env->trigger_cur, tdata_index, val);
> +        if (riscv_cpu_cfg(env)->ext_sdtrig) {
> +            type6_reg_write(env, env->trigger_cur, tdata_index, val);
> +        } else {
> +            qemu_log_mask(LOG_UNIMP, "trigger type: %d is not supported\=
n",
> +                          trigger_type);
> +        }
>          break;
>      case TRIGGER_TYPE_INST_CNT:
>          itrigger_reg_write(env, env->trigger_cur, tdata_index, val);
> @@ -750,9 +758,13 @@ void tdata_csr_write(CPURISCVState *env, int tdata_i=
ndex, target_ulong val)
>
>  target_ulong tinfo_csr_read(CPURISCVState *env)
>  {
> -    /* assume all triggers support the same types of triggers */
> -    return BIT(TRIGGER_TYPE_AD_MATCH) |
> -           BIT(TRIGGER_TYPE_AD_MATCH6);
> +    target_ulong ts =3D BIT(TRIGGER_TYPE_AD_MATCH);
> +
> +    if (riscv_cpu_cfg(env)->ext_sdtrig) {
> +        ts |=3D BIT(TRIGGER_TYPE_AD_MATCH6);
> +    }
> +
> +    return ts;
>  }
>
>  void riscv_cpu_debug_excp_handler(CPUState *cs)
> @@ -803,6 +815,10 @@ bool riscv_cpu_debug_check_breakpoint(CPUState *cs)
>                  }
>                  break;
>              case TRIGGER_TYPE_AD_MATCH6:
> +                if (!cpu->cfg.ext_sdtrig) {
> +                    break;
> +                }
> +
>                  ctrl =3D env->tdata1[i];
>                  pc =3D env->tdata2[i];
>
> @@ -869,6 +885,10 @@ bool riscv_cpu_debug_check_watchpoint(CPUState *cs, =
CPUWatchpoint *wp)
>              }
>              break;
>          case TRIGGER_TYPE_AD_MATCH6:
> +            if (!cpu->cfg.ext_sdtrig) {
> +                break;
> +            }
> +
>              ctrl =3D env->tdata1[i];
>              addr =3D env->tdata2[i];
>              flags =3D 0;
> --
> 2.34.1
>
>

