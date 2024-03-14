Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6D36DC54E60
	for <qemu-devel@archiver.kernel.org>; Thu, 14 Mar 2024 17:08:49 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rkoYM-00019J-95; Thu, 14 Mar 2024 13:07:38 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ajones@ventanamicro.com>)
 id 1rkoYK-00018H-3E
 for qemu-devel@nongnu.org; Thu, 14 Mar 2024 13:07:36 -0400
Received: from mail-ed1-x533.google.com ([2a00:1450:4864:20::533])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <ajones@ventanamicro.com>)
 id 1rkoYI-00056p-6A
 for qemu-devel@nongnu.org; Thu, 14 Mar 2024 13:07:35 -0400
Received: by mail-ed1-x533.google.com with SMTP id
 4fb4d7f45d1cf-5685d46b199so1917757a12.3
 for <qemu-devel@nongnu.org>; Thu, 14 Mar 2024 10:07:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=ventanamicro.com; s=google; t=1710436052; x=1711040852; darn=nongnu.org;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=+uXJho7DjxrNCCW815rjV6N+SXU1gp6Idw3A08Wq44U=;
 b=Gcute4tGmf+GIKjJsA3k4R3bw/tMCjcsErBhM7o7tv1ky5nLZquZc36oLwwoThy9wk
 /UZzQ8IIIHlSa9DCXFDDIlQnGixXA/LiKRZaUaIx8ri6KdpvGIT4sqDB5nashyAIBIA8
 uLYS/hRPUvxV2ruNUXmm1W+z1SQe7a1KQid/CKuuCXhaYxJxwHqNK/hhSMYft2PZvNFY
 tMbHxqANRgGkoyF/1onBpvdhz+3TuPiVpwcckmqQx3sOvsWwKQjOn1iniw6nkeD5Mjj2
 z0qbZSHGpiUgpow7bPibYeH3trDYXwR0s+Ba2vZhr0hrvbwz1GTsLokcst2unGFLM+VG
 P7dg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1710436052; x=1711040852;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=+uXJho7DjxrNCCW815rjV6N+SXU1gp6Idw3A08Wq44U=;
 b=OX8YC8y3FUUUjnEFIBNiafY4c0XFxfy7Wuf1ltje9xru7y26bVNDIIDTQEkLZ2nood
 nzphHeLdz3uvvf904rcm3SUu4sqAeYy4+bZ080xHZ/ZKVVV0vODZ5Jl2tvVWuz7Rjxnw
 xKCQ1riHN08zlO4GPMFlIXe4cXoQuvXoaqr+Gq8DKdo/LdGaFJSEqpwe+Q+nBkW5PfUy
 ix9CZQUUESrb88kjOk/NPecTq01nlaFEWToW1VDkOonzF5e02Mn9mphtT1yA934/u6f7
 nwndWF0qa0Uw/yKixLAH/m7cTS7xls0tyctVZDIYLgS31driaydw//KwCzMBKvDi5Q81
 x6JQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCWVut5BW4jP2wy7V2nYGCJ8yO+CxpyxIuzAohw1fBabykKGb0RToq8dWXsY3ZLXur/7IH+Xgguvq1w27K/zfSMex7UghBc=
X-Gm-Message-State: AOJu0YwsLkd6Li9O7GGGiLzE9R0ye8sBiHyhAuwsKcPV+r6dG2JYw6hv
 GjOv8lcfhivNbYlmGdoFZuaRuzGAU+3ZuIiMhP+MNg91cHOXbeXxPbXCgUHlHAA=
X-Google-Smtp-Source: AGHT+IGei9OT3Sq0h6JrGIM6TFdzoHwtiuGbjqakMFr9zSehyFgVUJJLHqwAoJ1Nv/oF3A5lj+EwBw==
X-Received: by 2002:aa7:da85:0:b0:565:7116:11d with SMTP id
 q5-20020aa7da85000000b005657116011dmr1384284eds.27.1710436052443; 
 Thu, 14 Mar 2024 10:07:32 -0700 (PDT)
Received: from localhost (cst2-173-16.cust.vodafone.cz. [31.30.173.16])
 by smtp.gmail.com with ESMTPSA id
 f6-20020a056402160600b005687f8721f9sm866171edv.82.2024.03.14.10.07.31
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 14 Mar 2024 10:07:31 -0700 (PDT)
Date: Thu, 14 Mar 2024 18:07:30 +0100
From: Andrew Jones <ajones@ventanamicro.com>
To: Himanshu Chauhan <hchauhan@ventanamicro.com>
Cc: qemu-riscv@nongnu.org, qemu-devel@nongnu.org
Subject: Re: [PATCH v6 1/3] target/riscv: Enable mcontrol6 triggers only when
 sdtrig is selected
Message-ID: <20240314-00c015519323ddca7ac7de74@orel>
References: <20240314113510.477862-1-hchauhan@ventanamicro.com>
 <20240314113510.477862-2-hchauhan@ventanamicro.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240314113510.477862-2-hchauhan@ventanamicro.com>
Received-SPF: pass client-ip=2a00:1450:4864:20::533;
 envelope-from=ajones@ventanamicro.com; helo=mail-ed1-x533.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

On Thu, Mar 14, 2024 at 05:05:08PM +0530, Himanshu Chauhan wrote:
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
>  4 files changed, 57 insertions(+), 40 deletions(-)
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

I still don't see the point of adding '|| cpu->cfg.ext_sdtrig'. debug must
be true when ext_sdtrig is true.

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

QEMU requires {}, even for single line blocks. I'm not sure if QEMU's
checkpatch is smart enough to complain about that, but if you haven't
run checkpatch, then you probably should.

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

Useless initialization to zero since it's assigned in the next line.
Actually, should just do

  target_ulong ts = BIT(TRIGGER_TYPE_AD_MATCH);

> +
> +    ts = BIT(TRIGGER_TYPE_AD_MATCH);
> +
> +    if (riscv_cpu_cfg(env)->ext_sdtrig)
> +        ts |= BIT(TRIGGER_TYPE_AD_MATCH6);

Need {}

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
> -- 
> 2.34.1
>

For the two TRIGGER_TYPE_AD_MATCH6 cases above in
riscv_cpu_debug_check_breakpoint() and riscv_cpu_debug_check_watchpoint()
I'd just put a

 if (!cpu->cfg.ext_sdtrig) {
     break;
 }

at the top of the code, rather than indenting everything. But either way
is fine.

Thanks,
drew

