Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D6EE5C27C4F
	for <qemu-devel@archiver.kernel.org>; Thu, 27 Jun 2024 02:19:55 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sMej0-0002tC-Lb; Wed, 26 Jun 2024 22:19:04 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1sMeij-0002sQ-6w; Wed, 26 Jun 2024 22:18:45 -0400
Received: from mail-vk1-xa31.google.com ([2607:f8b0:4864:20::a31])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1sMeif-000762-SY; Wed, 26 Jun 2024 22:18:43 -0400
Received: by mail-vk1-xa31.google.com with SMTP id
 71dfb90a1353d-4ef6e79b47dso635420e0c.0; 
 Wed, 26 Jun 2024 19:18:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1719454720; x=1720059520; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=1BjHIdMGmy2ukY1HHVb8Nzgic1CWWfFgSSCj4zTqEgM=;
 b=Drk/K1N43S/oc3uUPUTMBToZXFnVrEjFe2QzPQ2RB/HE9NNgFtLSY92AHyRe9CTPLs
 KdWKwAp14QBgLMXBxidzA182ml6b6o9kmpFQwBomxXRKSrUMbsFmP7FtBkTQIrESPts8
 OMhLCmyxeJSFyoo5+a240rMfFyAX7GIggQnboePjybbm0k2/g2JO4iioGtf1QQqJ0fGJ
 g+kduif6hsSsk2UkXKKlqp2dFTj0MkRQJgeRCmNaON3dvMLg2hx1I/GhR+DT+oEPXEci
 PqWMf/xvcq23qLB4HDp3WFCUfmL8pvxhv9xp56gwY/33w7rN4l6FqoRnlT9nkhIfRGls
 8n/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1719454720; x=1720059520;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=1BjHIdMGmy2ukY1HHVb8Nzgic1CWWfFgSSCj4zTqEgM=;
 b=Ggb+gXL1bkbEAKMgmbjKpyETli1EmF0TNE8AVwrsAFGsdrvJI8kTRJ65VD+F2Twznd
 wDs3PnXkZs9FkIIXQT5pgBNcoUoaa1GbeyW1h+8kxR+0e/JvY2tHim2B1x1DQUcAoDXa
 +mZEeQPffP4hcmR6grFK9OAb/gMVjDpKfs5+VL4iy8Uk+5BY5+CidlozN5o6SFjkku9H
 5DDqhqcq9+WKmWEnAW5SR34oAjkXdnATkTawvkhLYqJ+OB2rMJwvLTdBO/Hls7xMDMwU
 nS7fpckMEHfLm9KR+gyIaZrrRSGJWsWIy3ATBNi2bzvZr9U/c34WexyOpwFY72TRXAhC
 x5Rg==
X-Forwarded-Encrypted: i=1;
 AJvYcCVbXGwJfqjkVBhq95zRGXMs1ElB+tHTbYztGBV6+sV+lBwyBe9ba9MlaxC8KA+HyPI+9gh3qjogJ3XCbnd4C6spq9gtTcQ=
X-Gm-Message-State: AOJu0YyMyKlAFwHqTmrGmnaoZmmmL+mSx+Ox7X4ejDZfZ0R85/i7fYo+
 lIX6emsA5ItlauMMgPPyqWiuTWfJVQZ1WY93U1B/GLGPvMRVcofi7sHJibvmq7/Xkc2x/SXgYzB
 6XXVRqCUAbOisHtId0eJMhtn3vWI=
X-Google-Smtp-Source: AGHT+IEva/4jXMo7G/wpFvv0EqXuK1jhuQyM8RF/l1rDwJXqm6hoJPtwFgFRMtjAtar9CrPkyhyJ8wtFyiAw6YerFCo=
X-Received: by 2002:a05:6122:9a9:b0:4d3:34f4:7e99 with SMTP id
 71dfb90a1353d-4ef88b89565mr7109738e0c.0.1719454719910; Wed, 26 Jun 2024
 19:18:39 -0700 (PDT)
MIME-Version: 1.0
References: <20240626132247.2761286-1-alvinga@andestech.com>
 <20240626132247.2761286-2-alvinga@andestech.com>
In-Reply-To: <20240626132247.2761286-2-alvinga@andestech.com>
From: Alistair Francis <alistair23@gmail.com>
Date: Thu, 27 Jun 2024 12:18:13 +1000
Message-ID: <CAKmqyKPv5rcLisLhMvcSYswqgzsqW4VWX5V62Lf1rSgs9NvMUA@mail.gmail.com>
Subject: Re: [PATCH v6 1/3] target/riscv: Add functions for common matching
 conditions of trigger
To: Alvin Chang <alvinga@andestech.com>
Cc: qemu-riscv@nongnu.org, qemu-devel@nongnu.org, alistair.francis@wdc.com, 
 bin.meng@windriver.com, liwei1518@gmail.com, dbarboza@ventanamicro.com, 
 zhiwei_liu@linux.alibaba.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::a31;
 envelope-from=alistair23@gmail.com; helo=mail-vk1-xa31.google.com
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

On Wed, Jun 26, 2024 at 11:25=E2=80=AFPM Alvin Chang via <qemu-devel@nongnu=
.org> wrote:
>
> From: Alvin Chang via <qemu-devel@nongnu.org>

Something is still strange with your From

Alistair

>
> According to RISC-V Debug specification version 0.13 [1] (also applied
> to version 1.0 [2] but it has not been ratified yet), there are several
> common matching conditions before firing a trigger, including the
> enabled privilege levels of the trigger.
>
> This commit adds trigger_common_match() to prepare the common matching
> conditions for the type 2/3/6 triggers. For now, we just implement
> trigger_priv_match() to check if the enabled privilege levels of the
> trigger match CPU's current privilege level.
>
> Remove the related code in riscv_cpu_debug_check_breakpoint() and invoke
> trigger_common_match() to check the privilege levels of the type 2 and
> type 6 triggers for the breakpoints.
>
> This commit also changes the behavior of looping the triggers. In
> previous implementation, if we have a type 2 trigger and
> env->virt_enabled is true, we directly return false to stop the loop.
> Now we keep looping all the triggers until we find a matched trigger.
>
> Only the execution bit and the executed PC should be futher checked in
> riscv_cpu_debug_check_breakpoint().
>
> [1]: https://github.com/riscv/riscv-debug-spec/releases/tag/task_group_vo=
te
> [2]: https://github.com/riscv/riscv-debug-spec/releases/tag/1.0.0-rc1-asc=
iidoc
>
> Signed-off-by: Alvin Chang <alvinga@andestech.com>
> Reviewed-by: Alistair Francis <alistair.francis@wdc.com>
> ---
>  target/riscv/debug.c | 101 +++++++++++++++++++++++++++++++++----------
>  1 file changed, 78 insertions(+), 23 deletions(-)
>
> diff --git a/target/riscv/debug.c b/target/riscv/debug.c
> index b110370e..11125f33 100644
> --- a/target/riscv/debug.c
> +++ b/target/riscv/debug.c
> @@ -241,6 +241,76 @@ static void do_trigger_action(CPURISCVState *env, ta=
rget_ulong trigger_index)
>      }
>  }
>
> +/*
> + * Check the privilege level of specific trigger matches CPU's current p=
rivilege
> + * level.
> + */
> +static bool trigger_priv_match(CPURISCVState *env, trigger_type_t type,
> +                               int trigger_index)
> +{
> +    target_ulong ctrl =3D env->tdata1[trigger_index];
> +
> +    switch (type) {
> +    case TRIGGER_TYPE_AD_MATCH:
> +        /* type 2 trigger cannot be fired in VU/VS mode */
> +        if (env->virt_enabled) {
> +            return false;
> +        }
> +        /* check U/S/M bit against current privilege level */
> +        if ((ctrl >> 3) & BIT(env->priv)) {
> +            return true;
> +        }
> +        break;
> +    case TRIGGER_TYPE_AD_MATCH6:
> +        if (env->virt_enabled) {
> +            /* check VU/VS bit against current privilege level */
> +            if ((ctrl >> 23) & BIT(env->priv)) {
> +                return true;
> +            }
> +        } else {
> +            /* check U/S/M bit against current privilege level */
> +            if ((ctrl >> 3) & BIT(env->priv)) {
> +                return true;
> +            }
> +        }
> +        break;
> +    case TRIGGER_TYPE_INST_CNT:
> +        if (env->virt_enabled) {
> +            /* check VU/VS bit against current privilege level */
> +            if ((ctrl >> 25) & BIT(env->priv)) {
> +                return true;
> +            }
> +        } else {
> +            /* check U/S/M bit against current privilege level */
> +            if ((ctrl >> 6) & BIT(env->priv)) {
> +                return true;
> +            }
> +        }
> +        break;
> +    case TRIGGER_TYPE_INT:
> +    case TRIGGER_TYPE_EXCP:
> +    case TRIGGER_TYPE_EXT_SRC:
> +        qemu_log_mask(LOG_UNIMP, "trigger type: %d is not supported\n", =
type);
> +        break;
> +    case TRIGGER_TYPE_NO_EXIST:
> +    case TRIGGER_TYPE_UNAVAIL:
> +        qemu_log_mask(LOG_GUEST_ERROR, "trigger type: %d does not exist\=
n",
> +                      type);
> +        break;
> +    default:
> +        g_assert_not_reached();
> +    }
> +
> +    return false;
> +}
> +
> +/* Common matching conditions for all types of the triggers. */
> +static bool trigger_common_match(CPURISCVState *env, trigger_type_t type=
,
> +                                 int trigger_index)
> +{
> +    return trigger_priv_match(env, type, trigger_index);
> +}
> +
>  /* type 2 trigger */
>
>  static uint32_t type2_breakpoint_size(CPURISCVState *env, target_ulong c=
trl)
> @@ -785,22 +855,18 @@ bool riscv_cpu_debug_check_breakpoint(CPUState *cs)
>          for (i =3D 0; i < RV_MAX_TRIGGERS; i++) {
>              trigger_type =3D get_trigger_type(env, i);
>
> +            if (!trigger_common_match(env, trigger_type, i)) {
> +                continue;
> +            }
> +
>              switch (trigger_type) {
>              case TRIGGER_TYPE_AD_MATCH:
> -                /* type 2 trigger cannot be fired in VU/VS mode */
> -                if (env->virt_enabled) {
> -                    return false;
> -                }
> -
>                  ctrl =3D env->tdata1[i];
>                  pc =3D env->tdata2[i];
>
>                  if ((ctrl & TYPE2_EXEC) && (bp->pc =3D=3D pc)) {
> -                    /* check U/S/M bit against current privilege level *=
/
> -                    if ((ctrl >> 3) & BIT(env->priv)) {
> -                        env->badaddr =3D pc;
> -                        return true;
> -                    }
> +                    env->badaddr =3D pc;
> +                    return true;
>                  }
>                  break;
>              case TRIGGER_TYPE_AD_MATCH6:
> @@ -808,19 +874,8 @@ bool riscv_cpu_debug_check_breakpoint(CPUState *cs)
>                  pc =3D env->tdata2[i];
>
>                  if ((ctrl & TYPE6_EXEC) && (bp->pc =3D=3D pc)) {
> -                    if (env->virt_enabled) {
> -                        /* check VU/VS bit against current privilege lev=
el */
> -                        if ((ctrl >> 23) & BIT(env->priv)) {
> -                            env->badaddr =3D pc;
> -                            return true;
> -                        }
> -                    } else {
> -                        /* check U/S/M bit against current privilege lev=
el */
> -                        if ((ctrl >> 3) & BIT(env->priv)) {
> -                            env->badaddr =3D pc;
> -                            return true;
> -                        }
> -                    }
> +                    env->badaddr =3D pc;
> +                    return true;
>                  }
>                  break;
>              default:
> --
> 2.34.1
>
>

