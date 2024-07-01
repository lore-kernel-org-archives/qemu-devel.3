Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AA49DC3065B
	for <qemu-devel@archiver.kernel.org>; Mon,  1 Jul 2024 18:22:20 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sOLeY-00053a-UB; Mon, 01 Jul 2024 14:21:26 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dbarboza@ventanamicro.com>)
 id 1sOLeY-0004zf-0a
 for qemu-devel@nongnu.org; Mon, 01 Jul 2024 14:21:26 -0400
Received: from mail-pj1-x102a.google.com ([2607:f8b0:4864:20::102a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <dbarboza@ventanamicro.com>)
 id 1sOLeU-0000b8-EY
 for qemu-devel@nongnu.org; Mon, 01 Jul 2024 14:21:25 -0400
Received: by mail-pj1-x102a.google.com with SMTP id
 98e67ed59e1d1-2c9015b075bso3088863a91.1
 for <qemu-devel@nongnu.org>; Mon, 01 Jul 2024 11:21:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=ventanamicro.com; s=google; t=1719858080; x=1720462880; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=RhPz9qJrwS/Y6fuwX+2ROwcb9fKyO0BVGpIGpKIKwHE=;
 b=RvqRwbx+eHoebepq6AVxQgpX85QZZAj/h/XS+diT3dYxU1oeJhIh4pfrQsJ/j5QBoY
 f1EeBMfHHXj5CT8mlj8eSM69UPxuCzZnI6H/qATD3eg1KXtbq8Xg9FplyASZKZF2ljOT
 j8Cd5oHEBujg2gxUxTKwdDTqHFv6rGrpqhff+AXn3pB0oOmVO7KkbUOIDaS4P0QD219I
 AP3LXiWyI18m+LrQCdqqo5okl9aWr2MdVdb9Bxses1XHwmUDQOGjYXeknihTNLXHUM2d
 pLstul6GeW37+l4vhyStD7yN8687akNMFF2sknouetznxCHYZXEbRtqTo+SXWLHuUuFB
 60dA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1719858080; x=1720462880;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=RhPz9qJrwS/Y6fuwX+2ROwcb9fKyO0BVGpIGpKIKwHE=;
 b=PXFKWgizK3prhVZ6I3tnqIIp99TlGJxhMlgVJEjREMAPsmoTsZmJaTgPOhh4cRIbot
 pw6MiLgQr6kInwQX7cDydGJHywu/YaylqLIhGFss6OvmLbDtjGh1+dYPd3qsevJSAl54
 Wh2iRV5XFTHDgA9F/KaBH2JJAlUYtl95nnEvk5q0X8buTSCC6mt/QBTncwNsoQAhAQoz
 DDpJ83KvifyygEkDwS8gYZzcPrOCutpiIfcmfdC1O2BpkXG1YtHa6wCJL7xZM7x/5FGy
 CvF+szfV97zoka+BXeJW42APcrChXSuGzxXfW4g4VktLbMSeqlmVyuAx6KDRZ3SD46Nj
 b9iw==
X-Forwarded-Encrypted: i=1;
 AJvYcCWrh42V7UOAeBbQqYbtWP0vgCtdHVS39YznDN5cu9EppQZKqexRRiv+yQWAXcZWHWECyI7eOQH9BdF9IzDJXxBjUFu3pX8=
X-Gm-Message-State: AOJu0Yyr5fOqpE3t8Vy8OXT3KiIxPh9WJSBU3MLm/TxpOYG9xAvDG3sS
 9MejC0Wpv/xIl2fW4Nn81pRIsk1TBbjes59fyLYqwqoST4wcjYdUn4/Lzpub0b8=
X-Google-Smtp-Source: AGHT+IF4nzY4pbN4bLsgjJ7EVtXh/oYoZPxpCdKj35+xceNpByyrZc5eOEaPKX4uYSLbUGt+apnW6g==
X-Received: by 2002:a17:90b:230f:b0:2c4:e2d6:8de6 with SMTP id
 98e67ed59e1d1-2c93d2d18d8mr10035933a91.21.1719858067846; 
 Mon, 01 Jul 2024 11:21:07 -0700 (PDT)
Received: from [192.168.68.109] ([179.193.8.43])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-2c91d3eac7esm7120129a91.55.2024.07.01.11.21.04
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 01 Jul 2024 11:21:07 -0700 (PDT)
Message-ID: <668fba48-a161-4535-872b-1d44585e6184@ventanamicro.com>
Date: Mon, 1 Jul 2024 15:21:02 -0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v7 01/11] target/riscv: Combine set_mode and set_virt
 functions.
To: Atish Patra <atishp@rivosinc.com>, qemu-riscv@nongnu.org,
 qemu-devel@nongnu.org
Cc: Rajnesh Kanwal <rkanwal@rivosinc.com>, palmer@dabbelt.com,
 liwei1518@gmail.com, zhiwei_liu@linux.alibaba.com, bin.meng@windriver.com,
 alistair.francis@wdc.com
References: <20240626-smcntrpmf_v7-v7-0-bb0f10af7fa9@rivosinc.com>
 <20240626-smcntrpmf_v7-v7-1-bb0f10af7fa9@rivosinc.com>
Content-Language: en-US
From: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
In-Reply-To: <20240626-smcntrpmf_v7-v7-1-bb0f10af7fa9@rivosinc.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::102a;
 envelope-from=dbarboza@ventanamicro.com; helo=mail-pj1-x102a.google.com
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



On 6/26/24 8:57 PM, Atish Patra wrote:
> From: Rajnesh Kanwal <rkanwal@rivosinc.com>
> 
> Combining riscv_cpu_set_virt_enabled() and riscv_cpu_set_mode()
> functions. This is to make complete mode change information
> available through a single function.
> 
> This allows to easily differentiate between HS->VS, VS->HS
> and VS->VS transitions when executing state update codes.
> For example: One use-case which inspired this change is
> to update mode-specific instruction and cycle counters
> which requires information of both prev mode and current
> mode.
> 
> Signed-off-by: Rajnesh Kanwal <rkanwal@rivosinc.com>
> ---

Reviewed-by: Daniel Henrique Barboza <dbarboza@ventanamicro.com>

>   target/riscv/cpu.h        |  2 +-
>   target/riscv/cpu_helper.c | 57 +++++++++++++++++++++++------------------------
>   target/riscv/op_helper.c  | 17 +++++---------
>   3 files changed, 35 insertions(+), 41 deletions(-)
> 
> diff --git a/target/riscv/cpu.h b/target/riscv/cpu.h
> index 90b8f1b08f83..46faefd24e09 100644
> --- a/target/riscv/cpu.h
> +++ b/target/riscv/cpu.h
> @@ -544,7 +544,7 @@ void riscv_cpu_set_aia_ireg_rmw_fn(CPURISCVState *env, uint32_t priv,
>   RISCVException smstateen_acc_ok(CPURISCVState *env, int index, uint64_t bit);
>   #endif /* !CONFIG_USER_ONLY */
>   
> -void riscv_cpu_set_mode(CPURISCVState *env, target_ulong newpriv);
> +void riscv_cpu_set_mode(CPURISCVState *env, target_ulong newpriv, bool virt_en);
>   
>   void riscv_translate_init(void);
>   G_NORETURN void riscv_raise_exception(CPURISCVState *env,
> diff --git a/target/riscv/cpu_helper.c b/target/riscv/cpu_helper.c
> index 6709622dd3ab..10d3fdaed376 100644
> --- a/target/riscv/cpu_helper.c
> +++ b/target/riscv/cpu_helper.c
> @@ -619,30 +619,6 @@ void riscv_cpu_set_geilen(CPURISCVState *env, target_ulong geilen)
>       env->geilen = geilen;
>   }
>   
> -/* This function can only be called to set virt when RVH is enabled */
> -void riscv_cpu_set_virt_enabled(CPURISCVState *env, bool enable)
> -{
> -    /* Flush the TLB on all virt mode changes. */
> -    if (env->virt_enabled != enable) {
> -        tlb_flush(env_cpu(env));
> -    }
> -
> -    env->virt_enabled = enable;
> -
> -    if (enable) {
> -        /*
> -         * The guest external interrupts from an interrupt controller are
> -         * delivered only when the Guest/VM is running (i.e. V=1). This means
> -         * any guest external interrupt which is triggered while the Guest/VM
> -         * is not running (i.e. V=0) will be missed on QEMU resulting in guest
> -         * with sluggish response to serial console input and other I/O events.
> -         *
> -         * To solve this, we check and inject interrupt after setting V=1.
> -         */
> -        riscv_cpu_update_mip(env, 0, 0);
> -    }
> -}
> -
>   int riscv_cpu_claim_interrupts(RISCVCPU *cpu, uint64_t interrupts)
>   {
>       CPURISCVState *env = &cpu->env;
> @@ -715,7 +691,7 @@ void riscv_cpu_set_aia_ireg_rmw_fn(CPURISCVState *env, uint32_t priv,
>       }
>   }
>   
> -void riscv_cpu_set_mode(CPURISCVState *env, target_ulong newpriv)
> +void riscv_cpu_set_mode(CPURISCVState *env, target_ulong newpriv, bool virt_en)
>   {
>       g_assert(newpriv <= PRV_M && newpriv != PRV_RESERVED);
>   
> @@ -736,6 +712,28 @@ void riscv_cpu_set_mode(CPURISCVState *env, target_ulong newpriv)
>        * preemptive context switch. As a result, do both.
>        */
>       env->load_res = -1;
> +
> +    if (riscv_has_ext(env, RVH)) {
> +        /* Flush the TLB on all virt mode changes. */
> +        if (env->virt_enabled != virt_en) {
> +            tlb_flush(env_cpu(env));
> +        }
> +
> +        env->virt_enabled = virt_en;
> +        if (virt_en) {
> +            /*
> +             * The guest external interrupts from an interrupt controller are
> +             * delivered only when the Guest/VM is running (i.e. V=1). This
> +             * means any guest external interrupt which is triggered while the
> +             * Guest/VM is not running (i.e. V=0) will be missed on QEMU
> +             * resulting in guest with sluggish response to serial console
> +             * input and other I/O events.
> +             *
> +             * To solve this, we check and inject interrupt after setting V=1.
> +             */
> +            riscv_cpu_update_mip(env, 0, 0);
> +        }
> +    }
>   }
>   
>   /*
> @@ -1648,6 +1646,7 @@ void riscv_cpu_do_interrupt(CPUState *cs)
>   {
>       RISCVCPU *cpu = RISCV_CPU(cs);
>       CPURISCVState *env = &cpu->env;
> +    bool virt = env->virt_enabled;
>       bool write_gva = false;
>       uint64_t s;
>   
> @@ -1778,7 +1777,7 @@ void riscv_cpu_do_interrupt(CPUState *cs)
>   
>                   htval = env->guest_phys_fault_addr;
>   
> -                riscv_cpu_set_virt_enabled(env, 0);
> +                virt = false;
>               } else {
>                   /* Trap into HS mode */
>                   env->hstatus = set_field(env->hstatus, HSTATUS_SPV, false);
> @@ -1799,7 +1798,7 @@ void riscv_cpu_do_interrupt(CPUState *cs)
>           env->htinst = tinst;
>           env->pc = (env->stvec >> 2 << 2) +
>                     ((async && (env->stvec & 3) == 1) ? cause * 4 : 0);
> -        riscv_cpu_set_mode(env, PRV_S);
> +        riscv_cpu_set_mode(env, PRV_S, virt);
>       } else {
>           /* handle the trap in M-mode */
>           if (riscv_has_ext(env, RVH)) {
> @@ -1815,7 +1814,7 @@ void riscv_cpu_do_interrupt(CPUState *cs)
>               mtval2 = env->guest_phys_fault_addr;
>   
>               /* Trapping to M mode, virt is disabled */
> -            riscv_cpu_set_virt_enabled(env, 0);
> +            virt = false;
>           }
>   
>           s = env->mstatus;
> @@ -1830,7 +1829,7 @@ void riscv_cpu_do_interrupt(CPUState *cs)
>           env->mtinst = tinst;
>           env->pc = (env->mtvec >> 2 << 2) +
>                     ((async && (env->mtvec & 3) == 1) ? cause * 4 : 0);
> -        riscv_cpu_set_mode(env, PRV_M);
> +        riscv_cpu_set_mode(env, PRV_M, virt);
>       }
>   
>       /*
> diff --git a/target/riscv/op_helper.c b/target/riscv/op_helper.c
> index 2baf5bc3ca19..ec1408ba0fb1 100644
> --- a/target/riscv/op_helper.c
> +++ b/target/riscv/op_helper.c
> @@ -264,7 +264,7 @@ void helper_cbo_inval(CPURISCVState *env, target_ulong address)
>   target_ulong helper_sret(CPURISCVState *env)
>   {
>       uint64_t mstatus;
> -    target_ulong prev_priv, prev_virt;
> +    target_ulong prev_priv, prev_virt = env->virt_enabled;
>   
>       if (!(env->priv >= PRV_S)) {
>           riscv_raise_exception(env, RISCV_EXCP_ILLEGAL_INST, GETPC());
> @@ -307,11 +307,9 @@ target_ulong helper_sret(CPURISCVState *env)
>           if (prev_virt) {
>               riscv_cpu_swap_hypervisor_regs(env);
>           }
> -
> -        riscv_cpu_set_virt_enabled(env, prev_virt);
>       }
>   
> -    riscv_cpu_set_mode(env, prev_priv);
> +    riscv_cpu_set_mode(env, prev_priv, prev_virt);
>   
>       return retpc;
>   }
> @@ -347,16 +345,13 @@ target_ulong helper_mret(CPURISCVState *env)
>           mstatus = set_field(mstatus, MSTATUS_MPRV, 0);
>       }
>       env->mstatus = mstatus;
> -    riscv_cpu_set_mode(env, prev_priv);
> -
> -    if (riscv_has_ext(env, RVH)) {
> -        if (prev_virt) {
> -            riscv_cpu_swap_hypervisor_regs(env);
> -        }
>   
> -        riscv_cpu_set_virt_enabled(env, prev_virt);
> +    if (riscv_has_ext(env, RVH) && prev_virt) {
> +        riscv_cpu_swap_hypervisor_regs(env);
>       }
>   
> +    riscv_cpu_set_mode(env, prev_priv, prev_virt);
> +
>       return retpc;
>   }
>   
> 

