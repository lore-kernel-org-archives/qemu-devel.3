Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 18422C54E60
	for <qemu-devel@archiver.kernel.org>; Wed, 13 Mar 2024 19:07:41 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rkTvz-0008IO-EB; Wed, 13 Mar 2024 15:06:39 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ajones@ventanamicro.com>)
 id 1rkTvs-0008I9-TV
 for qemu-devel@nongnu.org; Wed, 13 Mar 2024 15:06:33 -0400
Received: from mail-lf1-x134.google.com ([2a00:1450:4864:20::134])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <ajones@ventanamicro.com>)
 id 1rkTvr-0006js-0Y
 for qemu-devel@nongnu.org; Wed, 13 Mar 2024 15:06:32 -0400
Received: by mail-lf1-x134.google.com with SMTP id
 2adb3069b0e04-513c53ed3d8so260455e87.3
 for <qemu-devel@nongnu.org>; Wed, 13 Mar 2024 12:06:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=ventanamicro.com; s=google; t=1710356787; x=1710961587; darn=nongnu.org;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=25IAnW90jZ78aTwEWy+x9rhtEYMv+xdl/Qj1hLOjQXQ=;
 b=DgeM6sMT1OLRuizqzSTn5opEybssFPhS5CEPB3Z91Gr/56cX4kszH9DJQLObkcZqYR
 5D3Et1qsKv3v7Z2FiYE2g6dReDQo+4GyR4BZlK4Vn4k89677NkvfxVi/KYo7iq/XAh8e
 2YIzSGhbqlIsZ1Ra9GW+SzncRP40IzDJSTccbqIH9V2NTmddfiauaYwVlceGKXcz/aFg
 IIG9qbjcfE07QdXz40KW5b/OePfl/stPZs/spR9uXZbZ2+bCBDEHKVBSGyhgJ/W9VVab
 Yr1zRR7M6hyXk0pINpa5zFm0J5SewdUedOX8n6XhHVr9NwCw9xBT33XyFRAmSV+wb82w
 nGqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1710356787; x=1710961587;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=25IAnW90jZ78aTwEWy+x9rhtEYMv+xdl/Qj1hLOjQXQ=;
 b=qykJb0F1zqktYmkNbcp+/zK2bT6LWVsUb21Fo7WOtC/QTaiVT59qIquITaMmfjm6Ml
 0YBCVz5jBqharx4/hcW0x0pX6LXotWB6z7lkojFExNYgamind0LDdJN89gxpSA0c/NeU
 SZlVg2uSY/7U99JPn2GMF52Z6Y2CfUf0J6ax9BRB75tuPnUbi6BpyEWg9g+cWvnTObdF
 b4kO8TrRWKt/Yx5cGgx0R+yglCa7WWjtJoCoh/fQF0GhdbLgUI1hawqbVUJPJiDzGzi8
 MOVcgmcYyTV9bkJE1g8PR/fYX+u63RPkfe6g2/AY/3fXkH1OSvUOEX5rc/2JNKLcuR6j
 yoRg==
X-Forwarded-Encrypted: i=1;
 AJvYcCVpJkCSM/zENV/CcCr7/A+LXst3Qw330c3G5sWaSoCR5nyjzdzsNcb9wNLBkw3Q3xwYK4vOrSpi5dGRUt7qa3379fHq72k=
X-Gm-Message-State: AOJu0YwHHHH3pSQozyXpC6R+d+tPUSlhm2SnWccVYnfPt4uRhLJDnd+S
 pXhDkCAD2VqMfJ6d4QYRpaouC3osTWbuFxvH/jyLHni345H6f/4vP00mpTlcq67s/9HdYCX81rK
 g
X-Google-Smtp-Source: AGHT+IF+ILfuGfui2YFF8mLu9wVYOkgUtoaZvdOjBpVwODC0lcBV7eVKw13ntAZwShXjnflldmNUQw==
X-Received: by 2002:ac2:5f8e:0:b0:513:c625:a6f6 with SMTP id
 r14-20020ac25f8e000000b00513c625a6f6mr2900821lfe.49.1710356787367; 
 Wed, 13 Mar 2024 12:06:27 -0700 (PDT)
Received: from localhost (cst2-173-16.cust.vodafone.cz. [31.30.173.16])
 by smtp.gmail.com with ESMTPSA id
 fs27-20020a05600c3f9b00b00413e63bb140sm3107557wmb.41.2024.03.13.12.06.25
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 13 Mar 2024 12:06:26 -0700 (PDT)
Date: Wed, 13 Mar 2024 20:06:25 +0100
From: Andrew Jones <ajones@ventanamicro.com>
To: Himanshu Chauhan <hchauhan@ventanamicro.com>
Cc: qemu-riscv@nongnu.org, qemu-devel@nongnu.org
Subject: Re: [PATCH v5 1/3] target/riscv: Enable mcontrol6 triggers only when
 sdtrig is selected
Message-ID: <20240313-7736ce7e5110189807de2287@orel>
References: <20240313182009.608685-1-hchauhan@ventanamicro.com>
 <20240313182009.608685-2-hchauhan@ventanamicro.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240313182009.608685-2-hchauhan@ventanamicro.com>
Received-SPF: pass client-ip=2a00:1450:4864:20::134;
 envelope-from=ajones@ventanamicro.com; helo=mail-lf1-x134.google.com
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

On Wed, Mar 13, 2024 at 11:50:07PM +0530, Himanshu Chauhan wrote:
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
>  target/riscv/debug.c   | 90 +++++++++++++++++++++++++-----------------
>  target/riscv/machine.c |  2 +-
>  5 files changed, 58 insertions(+), 41 deletions(-)
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
> index e30d99cc2f..674223e966 100644
> --- a/target/riscv/debug.c
> +++ b/target/riscv/debug.c
> @@ -100,13 +100,15 @@ static trigger_action_t get_trigger_action(CPURISCVState *env,
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
> +        if (cfg->ext_sdtrig)
> +            action = (tdata1 & TYPE6_ACTION) >> 12;
>          break;
>      case TRIGGER_TYPE_INST_CNT:
>      case TRIGGER_TYPE_INT:
> @@ -727,7 +729,12 @@ void tdata_csr_write(CPURISCVState *env, int tdata_index, target_ulong val)
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
> @@ -750,9 +757,14 @@ void tdata_csr_write(CPURISCVState *env, int tdata_index, target_ulong val)
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
> +    if (riscv_cpu_cfg(env)->ext_sdtrig)
> +        ts |= BIT(TRIGGER_TYPE_AD_MATCH6);
> +
> +    return ts;
>  }
>  
>  void riscv_cpu_debug_excp_handler(CPUState *cs)
> @@ -803,19 +815,21 @@ bool riscv_cpu_debug_check_breakpoint(CPUState *cs)
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
> +                    ctrl = env->tdata1[i];
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
> @@ -869,27 +883,29 @@ bool riscv_cpu_debug_check_watchpoint(CPUState *cs, CPUWatchpoint *wp)
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
> index 76f2150f78..383151a4f8 100644
> --- a/target/riscv/machine.c
> +++ b/target/riscv/machine.c
> @@ -230,7 +230,7 @@ static bool debug_needed(void *opaque)
>  {
>      RISCVCPU *cpu = opaque;
>  
> -    return cpu->cfg.debug;
> +    return cpu->cfg.debug || cpu->cfg.ext_sdtrig;
>  }
>  
>  static int debug_post_load(void *opaque, int version_id)
> -- 
> 2.34.1
> 
>

afaict we never have if cfg.debug without '|| cfg.ext_sdtrig', so I
maintain that we don't need to add the '|| cfg.ext_sdtrig' now that we
ensure debug is set when ext_sdtrig is set.

Thanks,
drew

