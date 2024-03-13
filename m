Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F043DC54791
	for <qemu-devel@archiver.kernel.org>; Wed, 13 Mar 2024 09:54:00 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rkLI7-0004pQ-Fb; Wed, 13 Mar 2024 05:52:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ajones@ventanamicro.com>)
 id 1rkLI5-0004oe-9w
 for qemu-devel@nongnu.org; Wed, 13 Mar 2024 05:52:53 -0400
Received: from mail-ej1-x630.google.com ([2a00:1450:4864:20::630])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <ajones@ventanamicro.com>)
 id 1rkLI3-0003bF-96
 for qemu-devel@nongnu.org; Wed, 13 Mar 2024 05:52:53 -0400
Received: by mail-ej1-x630.google.com with SMTP id
 a640c23a62f3a-a44f2d894b7so106336966b.1
 for <qemu-devel@nongnu.org>; Wed, 13 Mar 2024 02:52:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=ventanamicro.com; s=google; t=1710323569; x=1710928369; darn=nongnu.org;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=ruQFcJuHUQqZP8BhvR0EDOl0VOmtFkHUR9/tKdO75is=;
 b=i7S21LqfYsob1gUDe4cxF6nvHnl3KYBrHJ2V3FU7YTd1lCS7YR6nnNGooLVRxtEBoB
 QBFwAP3LdoA99h1S68KtSUyO3A/3dWvjTejNHOqVEbiDBsAdTP+fYbqyldSEUD734Uy3
 e6aEuvQvOTgucK3aigEaQkCcK043Y4TkJDi/DswewLjdCXbVETOF4xiXY9+HQkrhB9q9
 g5BL0bVseA1LTU//zLOZW9vEN2R0kI2Jo/BZ6ZsKx8tKvAyydrb+WGJrv3N2DrrVKIjl
 6Nr45+QOdc5HktqlXiiY4WP16MaVDo5LnBVY01ZWkKUh1I7CykKSqjWxia+5IAogrP/F
 0mLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1710323569; x=1710928369;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=ruQFcJuHUQqZP8BhvR0EDOl0VOmtFkHUR9/tKdO75is=;
 b=Lq/r1IJwOtAczW57LSy1JKRHIAJEjbBoLGLzE07+Gi5OdqjhkzANVMIzceqjZ8uiPK
 pDGFu6pQMWccb2oFe2JocwdH9054cpS+AWCjWuUtyRuzeRkzd4ehYSOEGmWLbvNIkkOg
 4bzW+mgzlW9tvBTtEfJpPxtcyhzpXxssHJ44U84K23MYIP8BvmEJJEvulwzjmcLUDIgT
 dwmagYnL20kMA21LXZU27Ec1gJrwKGjA0+XeqevsKFhe/T/TuWSXDyQQOT3RuRcawG77
 z2NeGbJd0hXc9304h0En0eIgP+TK80P8dQbb2NLDvce/eWb2NnyUD9SFNkPeYFTEv8aQ
 jaAA==
X-Forwarded-Encrypted: i=1;
 AJvYcCVdQwyQ+4PolktwhYAUJ4tsaqK8wYz0b/IZz5GAOmHZUhkmH0X/syDvy/6WPJKlzIVRhmaM7aJbK6nTqdX2UsnYm6mrDfs=
X-Gm-Message-State: AOJu0Yy3jkbDuN4hLDz8e/My1PmfjU9Tjgo4L3MKOdoAiKM3Pkj7pMqU
 nVP+pckGtcRSexuz81MXp7QL0wRcQ/xgUJIyg6L31lbaIWuhBhBl5vB43tvwjwc=
X-Google-Smtp-Source: AGHT+IHeWdRwrWlsnX+qww/Fng+daJsY+SZQswyAFQP5z6SkmzBUxgtVbNcg7Pl8SC6b7RCrAzX8FA==
X-Received: by 2002:a17:907:a0d2:b0:a44:277c:1683 with SMTP id
 hw18-20020a170907a0d200b00a44277c1683mr4992771ejc.53.1710323569533; 
 Wed, 13 Mar 2024 02:52:49 -0700 (PDT)
Received: from localhost (cst2-173-16.cust.vodafone.cz. [31.30.173.16])
 by smtp.gmail.com with ESMTPSA id
 l20-20020a1709067d5400b00a46224d4442sm3156887ejp.212.2024.03.13.02.52.48
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 13 Mar 2024 02:52:49 -0700 (PDT)
Date: Wed, 13 Mar 2024 10:52:48 +0100
From: Andrew Jones <ajones@ventanamicro.com>
To: Himanshu Chauhan <hchauhan@ventanamicro.com>
Cc: qemu-riscv@nongnu.org, qemu-devel@nongnu.org
Subject: Re: [PATCH v4 1/3] target/riscv: Enable mcontrol6 triggers only when
 sdtrig is selected
Message-ID: <20240313-a62777ede69ea38aad80b882@orel>
References: <20240313060931.242161-1-hchauhan@ventanamicro.com>
 <20240313060931.242161-2-hchauhan@ventanamicro.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240313060931.242161-2-hchauhan@ventanamicro.com>
Received-SPF: pass client-ip=2a00:1450:4864:20::630;
 envelope-from=ajones@ventanamicro.com; helo=mail-ej1-x630.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=unavailable autolearn_force=no
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

On Wed, Mar 13, 2024 at 11:39:29AM +0530, Himanshu Chauhan wrote:
> The mcontrol6 triggers are not defined in debug specification v0.13
> These triggers are defined in sdtrig ISA extension.
> 
> This patch:
>    * Adds ext_sdtrig capability which is used to select mcontrol6 triggers
>    * Keeps the debug property. All triggers that are defined in v0.13 are
>      exposed.
> 
> Signed-off-by: Himanshu Chauhan <hchauhan@ventanamicro.com>
> ---
>  target/riscv/cpu.c     |  4 +-
>  target/riscv/cpu_cfg.h |  1 +
>  target/riscv/csr.c     |  2 +-
>  target/riscv/debug.c   | 92 +++++++++++++++++++++++++-----------------
>  target/riscv/machine.c |  2 +-
>  5 files changed, 60 insertions(+), 41 deletions(-)
> 
> diff --git a/target/riscv/cpu.c b/target/riscv/cpu.c
> index c160b9216b..2602aae9f5 100644
> --- a/target/riscv/cpu.c
> +++ b/target/riscv/cpu.c
> @@ -1008,7 +1008,7 @@ static void riscv_cpu_reset_hold(Object *obj)
>      set_default_nan_mode(1, &env->fp_status);
>  
>  #ifndef CONFIG_USER_ONLY
> -    if (cpu->cfg.debug) {
> +    if (cpu->cfg.debug || cpu->cfg.ext_sdtrig) {
>          riscv_trigger_reset_hold(env);
>      }
>  
> @@ -1168,7 +1168,7 @@ static void riscv_cpu_realize(DeviceState *dev, Error **errp)
>      riscv_cpu_register_gdb_regs_for_features(cs);
>  
>  #ifndef CONFIG_USER_ONLY
> -    if (cpu->cfg.debug) {
> +    if (cpu->cfg.debug || cpu->cfg.ext_sdtrig) {
>          riscv_trigger_realize(&cpu->env);
>      }
>  #endif
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
> diff --git a/target/riscv/csr.c b/target/riscv/csr.c
> index 726096444f..26623d3640 100644
> --- a/target/riscv/csr.c
> +++ b/target/riscv/csr.c
> @@ -546,7 +546,7 @@ static RISCVException have_mseccfg(CPURISCVState *env, int csrno)
>  
>  static RISCVException debug(CPURISCVState *env, int csrno)
>  {
> -    if (riscv_cpu_cfg(env)->debug) {
> +    if (riscv_cpu_cfg(env)->debug || riscv_cpu_cfg(env)->ext_sdtrig) {
>          return RISCV_EXCP_NONE;
>      }
>  
> diff --git a/target/riscv/debug.c b/target/riscv/debug.c
> index e30d99cc2f..c6a92ba0f7 100644
> --- a/target/riscv/debug.c
> +++ b/target/riscv/debug.c
> @@ -100,13 +100,16 @@ static trigger_action_t get_trigger_action(CPURISCVState *env,
>      target_ulong tdata1 = env->tdata1[trigger_index];
>      int trigger_type = get_trigger_type(env, trigger_index);
>      trigger_action_t action = DBG_ACTION_NONE;
> +    const RISCVCPUConfig *cfg = riscv_cpu_cfg(env);
>  
>      switch (trigger_type) {
>      case TRIGGER_TYPE_AD_MATCH:
>          action = (tdata1 & TYPE2_ACTION) >> 12;
>          break;
>      case TRIGGER_TYPE_AD_MATCH6:
> -        action = (tdata1 & TYPE6_ACTION) >> 12;
> +        /* Only sdtrig ISA extension supports type 6 match */

I'd drop the comment since the if-statement says the same thing.

> +        if (cfg->ext_sdtrig)
> +            action = (tdata1 & TYPE6_ACTION) >> 12;
>          break;
>      case TRIGGER_TYPE_INST_CNT:
>      case TRIGGER_TYPE_INT:
> @@ -727,7 +730,12 @@ void tdata_csr_write(CPURISCVState *env, int tdata_index, target_ulong val)
>          type2_reg_write(env, env->trigger_cur, tdata_index, val);
>          break;
>      case TRIGGER_TYPE_AD_MATCH6:
> -        type6_reg_write(env, env->trigger_cur, tdata_index, val);
> +        if (riscv_cpu_cfg(env)->ext_sdtrig) {
> +            type6_reg_write(env, env->trigger_cur, tdata_index, val);
> +        } else {
> +            qemu_log_mask(LOG_UNIMP, "trigger type: %d is not supported\n",
> +                          trigger_type);
> +        }
>          break;
>      case TRIGGER_TYPE_INST_CNT:
>          itrigger_reg_write(env, env->trigger_cur, tdata_index, val);
> @@ -750,9 +758,15 @@ void tdata_csr_write(CPURISCVState *env, int tdata_index, target_ulong val)
>  
>  target_ulong tinfo_csr_read(CPURISCVState *env)
>  {
> -    /* assume all triggers support the same types of triggers */
> -    return BIT(TRIGGER_TYPE_AD_MATCH) |
> -           BIT(TRIGGER_TYPE_AD_MATCH6);
> +    target_ulong ts = 0;
> +
> +    ts = BIT(TRIGGER_TYPE_AD_MATCH);
> +
> +    /* sdtrig ISA extension supports type 6 match */

Also drop this comment.

> +    if (riscv_cpu_cfg(env)->ext_sdtrig)
> +        ts |= BIT(TRIGGER_TYPE_AD_MATCH6);
> +
> +    return ts;
>  }
>  
>  void riscv_cpu_debug_excp_handler(CPUState *cs)
> @@ -803,19 +817,21 @@ bool riscv_cpu_debug_check_breakpoint(CPUState *cs)
>                  }
>                  break;
>              case TRIGGER_TYPE_AD_MATCH6:
> -                ctrl = env->tdata1[i];
> -                pc = env->tdata2[i];
> -
> -                if ((ctrl & TYPE6_EXEC) && (bp->pc == pc)) {
> -                    if (env->virt_enabled) {
> -                        /* check VU/VS bit against current privilege level */
> -                        if ((ctrl >> 23) & BIT(env->priv)) {
> -                            return true;
> -                        }
> -                    } else {
> -                        /* check U/S/M bit against current privilege level */
> -                        if ((ctrl >> 3) & BIT(env->priv)) {
> -                            return true;
> +                if (cpu->cfg.ext_sdtrig) {
> +                   ctrl = env->tdata1[i];

Check your whitespace. Missing one space of indent in the line above.

> +                    pc = env->tdata2[i];
> +
> +                    if ((ctrl & TYPE6_EXEC) && (bp->pc == pc)) {
> +                        if (env->virt_enabled) {
> +                            /* check VU/VS bit against current privilege level */
> +                            if ((ctrl >> 23) & BIT(env->priv)) {
> +                                return true;
> +                            }
> +                        } else {
> +                            /* check U/S/M bit against current privilege level */
> +                            if ((ctrl >> 3) & BIT(env->priv)) {
> +                                return true;
> +                            }
>                          }
>                      }
>                  }
> @@ -869,27 +885,29 @@ bool riscv_cpu_debug_check_watchpoint(CPUState *cs, CPUWatchpoint *wp)
>              }
>              break;
>          case TRIGGER_TYPE_AD_MATCH6:
> -            ctrl = env->tdata1[i];
> -            addr = env->tdata2[i];
> -            flags = 0;
> +            if (cpu->cfg.ext_sdtrig) {
> +                ctrl = env->tdata1[i];
> +                addr = env->tdata2[i];
> +                flags = 0;
>  
> -            if (ctrl & TYPE6_LOAD) {
> -                flags |= BP_MEM_READ;
> -            }
> -            if (ctrl & TYPE6_STORE) {
> -                flags |= BP_MEM_WRITE;
> -            }
> +                if (ctrl & TYPE6_LOAD) {
> +                    flags |= BP_MEM_READ;
> +                }
> +                if (ctrl & TYPE6_STORE) {
> +                    flags |= BP_MEM_WRITE;
> +                }
>  
> -            if ((wp->flags & flags) && (wp->vaddr == addr)) {
> -                if (env->virt_enabled) {
> -                    /* check VU/VS bit against current privilege level */
> -                    if ((ctrl >> 23) & BIT(env->priv)) {
> -                        return true;
> -                    }
> -                } else {
> -                    /* check U/S/M bit against current privilege level */
> -                    if ((ctrl >> 3) & BIT(env->priv)) {
> -                        return true;
> +                if ((wp->flags & flags) && (wp->vaddr == addr)) {
> +                    if (env->virt_enabled) {
> +                        /* check VU/VS bit against current privilege level */
> +                        if ((ctrl >> 23) & BIT(env->priv)) {
> +                            return true;
> +                        }
> +                    } else {
> +                        /* check U/S/M bit against current privilege level */
> +                        if ((ctrl >> 3) & BIT(env->priv)) {
> +                            return true;
> +                        }
>                      }
>                  }
>              }
> diff --git a/target/riscv/machine.c b/target/riscv/machine.c
> index 76f2150f78..1cb8656191 100644
> --- a/target/riscv/machine.c
> +++ b/target/riscv/machine.c
> @@ -230,7 +230,7 @@ static bool debug_needed(void *opaque)
>  {
>      RISCVCPU *cpu = opaque;
>  
> -    return cpu->cfg.debug;
> +    return (cpu->cfg.debug || cpu->cfg.ext_sdtrig);

nit: Unnecssary ()

>  }
>  
>  static int debug_post_load(void *opaque, int version_id)
> -- 
> 2.34.1
> 
>

Thanks,
drew

