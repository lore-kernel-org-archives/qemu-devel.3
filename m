Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 774DEC54E5D
	for <qemu-devel@archiver.kernel.org>; Thu, 14 Mar 2024 19:30:17 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rkqlX-0003fd-Ho; Thu, 14 Mar 2024 15:29:23 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ajones@ventanamicro.com>)
 id 1rkqlV-0003fK-Ft
 for qemu-devel@nongnu.org; Thu, 14 Mar 2024 15:29:21 -0400
Received: from mail-lj1-x22d.google.com ([2a00:1450:4864:20::22d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <ajones@ventanamicro.com>)
 id 1rkqlT-0006Dc-RD
 for qemu-devel@nongnu.org; Thu, 14 Mar 2024 15:29:21 -0400
Received: by mail-lj1-x22d.google.com with SMTP id
 38308e7fff4ca-2d28387db09so16047591fa.0
 for <qemu-devel@nongnu.org>; Thu, 14 Mar 2024 12:29:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=ventanamicro.com; s=google; t=1710444557; x=1711049357; darn=nongnu.org;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=l0twAIAOyluO31r9AfwKh1z3D3aYOKL7rRl2v9VVFVE=;
 b=SdLc351PddiJqAiSGUCPw1ohYWJeCdUIRKa0CTaFOJ9/nRcmVH9eeuc/E1B3bo/jtE
 sXtOYhtPzavhHtl77w/XY4+VnZbRFqXIJ6JUwOqvg2mFVHj1KvF8Mz5n2Px3e6VfgFrE
 p0MIuqeR9hL9zFTzmbhJOBQVyKmY6bbBDBqMQxvpWn0vt6IEvOp/52aZrncHNW1CHcqU
 33VlB0tJfKk9D2z+azntnGWklimHG3MSEfwXVtVa6svIfkdD42TEo4D1QGfaxR7ox40f
 ob1kb3FQdJ/qJyPtNhE27eDIr1CJh+ODbw4CZnuPOhzyVIyMqlXEQ1purflg7/LYisnI
 8sMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1710444557; x=1711049357;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=l0twAIAOyluO31r9AfwKh1z3D3aYOKL7rRl2v9VVFVE=;
 b=cGleqszgBTfbcwnSSE9+oJ6MZeBTF9WxMF0I9a23UhrgL0qRthmqjv1WeWaKcKYyYb
 KxagFB1lZ8VAUjf18RROGG5Nik0FnGUTn9eIPuR+Nod77sAIiaLSOmaVIyRI2e+ZXi4B
 h3eQfojMQ7tKiafwyNvAPMs0d+xBz/h9FpDJ0RPYPQvwMGQsfGob6+4vy4i5flnl6XMr
 5iwNIKhUvjcCWR3DsmMN5jlD7OX3ugyfx0Yjw3T48x27v7xBnyr50IIwe3Z9bINFaJ27
 Cf1p+PvTLLSfSwGfINCo8BP9r1LxH11OfXRTb7spzLHZ+3PIX4LSTEX6qT7SJJBgGhiM
 YLEw==
X-Forwarded-Encrypted: i=1;
 AJvYcCVvcDNXRdyZDg17mi3scxVMGJova9jmPkkW2dRbnK627npVM96eZzS0yXkxGLH0W7mAIuOKBypFVtytI0fHDSUy2mgpI3A=
X-Gm-Message-State: AOJu0YxrVhbzw2yjHoFBCbiI0VAX6T8Ah6XDk6iBCB4H84/4nwhHSyfV
 Bxhk+YWcxc1jnxgB+m6UfIwOYemqix8PuEIPkbJKbCEUud6EJcCLQzT1E3fjblo=
X-Google-Smtp-Source: AGHT+IGVFhk+X6dAvyoiiYBcojLMb/kvfqjA1Ex22aDHfJVal0QjUHWVOQGuB2fRjVgc04KaLNx1BA==
X-Received: by 2002:a19:9118:0:b0:513:c658:7997 with SMTP id
 t24-20020a199118000000b00513c6587997mr795125lfd.24.1710444557121; 
 Thu, 14 Mar 2024 12:29:17 -0700 (PDT)
Received: from localhost (cst2-173-16.cust.vodafone.cz. [31.30.173.16])
 by smtp.gmail.com with ESMTPSA id
 jl27-20020a17090775db00b00a45c9ea48e3sm970026ejc.193.2024.03.14.12.29.16
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 14 Mar 2024 12:29:16 -0700 (PDT)
Date: Thu, 14 Mar 2024 20:29:15 +0100
From: Andrew Jones <ajones@ventanamicro.com>
To: Himanshu Chauhan <hchauhan@ventanamicro.com>
Cc: qemu-riscv@nongnu.org, qemu-devel@nongnu.org
Subject: Re: [PATCH v7 2/4] target/riscv: Enable mcontrol6 triggers only when
 sdtrig is selected
Message-ID: <20240314-d0b94959078556cbf94a1633@orel>
References: <20240314185957.36940-1-hchauhan@ventanamicro.com>
 <20240314185957.36940-3-hchauhan@ventanamicro.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240314185957.36940-3-hchauhan@ventanamicro.com>
Received-SPF: pass client-ip=2a00:1450:4864:20::22d;
 envelope-from=ajones@ventanamicro.com; helo=mail-lj1-x22d.google.com
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

On Fri, Mar 15, 2024 at 12:29:55AM +0530, Himanshu Chauhan wrote:
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
> +        cpu->cfg.debug = true;
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
> +        if (cfg->ext_sdtrig) {
> +            action = (tdata1 & TYPE6_ACTION) >> 12;
> +        }
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
> @@ -750,9 +758,13 @@ void tdata_csr_write(CPURISCVState *env, int tdata_index, target_ulong val)
>  
>  target_ulong tinfo_csr_read(CPURISCVState *env)
>  {
> -    /* assume all triggers support the same types of triggers */
> -    return BIT(TRIGGER_TYPE_AD_MATCH) |
> -           BIT(TRIGGER_TYPE_AD_MATCH6);
> +    target_ulong ts = BIT(TRIGGER_TYPE_AD_MATCH);
> +
> +    if (riscv_cpu_cfg(env)->ext_sdtrig) {
> +        ts |= BIT(TRIGGER_TYPE_AD_MATCH6);
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
>                  ctrl = env->tdata1[i];
>                  pc = env->tdata2[i];
>  
> @@ -869,6 +885,10 @@ bool riscv_cpu_debug_check_watchpoint(CPUState *cs, CPUWatchpoint *wp)
>              }
>              break;
>          case TRIGGER_TYPE_AD_MATCH6:
> +            if (!cpu->cfg.ext_sdtrig) {
> +                break;
> +            }
> +
>              ctrl = env->tdata1[i];
>              addr = env->tdata2[i];
>              flags = 0;
> -- 
> 2.34.1
>

Reviewed-by: Andrew Jones <ajones@ventanamicro.com>

