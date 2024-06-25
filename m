Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 49EA5C2BBCA
	for <qemu-devel@archiver.kernel.org>; Tue, 25 Jun 2024 09:07:10 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sM27w-00044j-18; Tue, 25 Jun 2024 05:06:12 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jason.chien@sifive.com>)
 id 1sM27r-000445-P4
 for qemu-devel@nongnu.org; Tue, 25 Jun 2024 05:06:07 -0400
Received: from mail-pl1-x635.google.com ([2607:f8b0:4864:20::635])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <jason.chien@sifive.com>)
 id 1sM27n-00046t-5u
 for qemu-devel@nongnu.org; Tue, 25 Jun 2024 05:06:07 -0400
Received: by mail-pl1-x635.google.com with SMTP id
 d9443c01a7336-1f9b52ef481so42563565ad.1
 for <qemu-devel@nongnu.org>; Tue, 25 Jun 2024 02:06:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sifive.com; s=google; t=1719306361; x=1719911161; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=l1mjy6PFHzw51e2+khPMMeLEFIU2iOYItBpJX4sz8Ng=;
 b=mIsc29tQTzEPJsM1Vil6XmnLKo+qZWIgB/4kj05bhKlV5KpI1oZdhU3OLvE6bQ5AsR
 2oOolTrB8EFwXBGvw8FA5qbURWEZh8nWF0ALns9qP1gPh4KNQDXzLAZBv6ASaFjDaD37
 g+GSlvyHdXnP0M9fTOqRBc5ijtNEiksvKwKBqvQI2uIcOnqQGO4KzemwGpUhOljxQDtH
 esJ//ZQGDotGaTyYa9wBonwHsPbwBTr+I3vQ57ETTT34Oy7Mt4ExdD7EmzTjOSjbWFCn
 /uA6yvl8RYSweXLYRsHuCJgkjInlAwCok2Ydn/UHgRK19vwfSon8Ff7mmoW5uTC1Wb1x
 YSjA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1719306361; x=1719911161;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=l1mjy6PFHzw51e2+khPMMeLEFIU2iOYItBpJX4sz8Ng=;
 b=evZ9hMEY+sXu2DPfFpkLWqZxoCz74YwmFdczbXeSyvBJyz6NPC6GzkXIXLkR7z9mWa
 2r1sUtsvOKolMVs/y3lT5OAjvgMQZ22s8WN9E5F6l9pxcGhpikAF0UiBtnNMZ1/58yAN
 +Qgd4SNIB3TwMbdCQwxPsNYo0csmNSna3H8PrafC6AkDJ5Dr+aqvTpwDjsLWLB6R5aV0
 NJ+g+YnDM+FwCHQ84Uk969/lZ5ghEVuo7sZJTjpMa5kmiYcbkTPtYMTKj8yoUZkol08A
 C2CPjFQ9+Lc5iXgT8o5YfiwN7sMeDmK7xqNJLygiJfOyXRHufh9qewGtwxpiuPi/HVY5
 anaA==
X-Forwarded-Encrypted: i=1;
 AJvYcCUPMpMiUp4H0J+juwHQYdSei3oNna00DgVMwRcuzzV6Zg+p92KqRmrGNcTCX6mltshz1OcwGSmCnKjkMccQk3/XtcXOabs=
X-Gm-Message-State: AOJu0YwGb7emx3jrGlG35crmDs3q+C6AaKVfInqTp9AqTE3bON113ocz
 zemBqm3vxCWbuwuea2o4UQOnT9UV+O5GaeVsdT8B5ydUWczT9MyDhBAhZMn9rX4=
X-Google-Smtp-Source: AGHT+IHLHFbeWG+NtuGHkLd9s73kMeb8fVoFomS7Lu9vvy0RgRTHAc6J1A89ZExvGK/Weyhs9T4c1g==
X-Received: by 2002:a17:902:e846:b0:1f9:f217:83d with SMTP id
 d9443c01a7336-1fa23be177dmr84791505ad.2.1719306360977; 
 Tue, 25 Jun 2024 02:06:00 -0700 (PDT)
Received: from [192.168.100.252] (59-124-168-89.hinet-ip.hinet.net.
 [59.124.168.89]) by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-1f9eb2f1187sm76511555ad.56.2024.06.25.02.05.57
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 25 Jun 2024 02:06:00 -0700 (PDT)
Message-ID: <0d741790-b9ef-475c-b147-9fbefdc9dac5@sifive.com>
Date: Tue, 25 Jun 2024 17:05:56 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 5/6] target/riscv: Add CTR sctrclr instruction.
To: Rajnesh Kanwal <rkanwal@rivosinc.com>, qemu-riscv@nongnu.org,
 qemu-devel@nongnu.org
Cc: alistair.francis@wdc.com, bin.meng@windriver.com, liweiwei@iscas.ac.cn,
 dbarboza@ventanamicro.com, zhiwei_liu@linux.alibaba.com,
 atishp@rivosinc.com, apatel@ventanamicro.com, beeman@rivosinc.com,
 tech-control-transfer-records@lists.riscv.org
References: <20240619152708.135991-1-rkanwal@rivosinc.com>
 <20240619152708.135991-6-rkanwal@rivosinc.com>
Content-Language: en-US
From: Jason Chien <jason.chien@sifive.com>
In-Reply-To: <20240619152708.135991-6-rkanwal@rivosinc.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::635;
 envelope-from=jason.chien@sifive.com; helo=mail-pl1-x635.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
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

Hi Rajnesh,

On 2024/6/19 下午 11:27, Rajnesh Kanwal wrote:
> CTR extension adds a new instruction sctrclr to quickly
> clear the recorded entries buffer.
>
> Signed-off-by: Rajnesh Kanwal <rkanwal@rivosinc.com>
> ---
>   target/riscv/cpu.h                            |  1 +
>   target/riscv/cpu_helper.c                     |  7 ++++
>   target/riscv/helper.h                         |  1 +
>   target/riscv/insn32.decode                    |  1 +
>   .../riscv/insn_trans/trans_privileged.c.inc   | 10 ++++++
>   target/riscv/op_helper.c                      | 33 +++++++++++++++++++
>   6 files changed, 53 insertions(+)
>
> diff --git a/target/riscv/cpu.h b/target/riscv/cpu.h
> index e32f5ab146..fdc18a782a 100644
> --- a/target/riscv/cpu.h
> +++ b/target/riscv/cpu.h
> @@ -572,6 +572,7 @@ void riscv_cpu_set_mode(CPURISCVState *env, target_ulong newpriv, bool virt_en);
>   void riscv_ctr_freeze(CPURISCVState *env, uint64_t freeze_mask, bool virt);
>   void riscv_ctr_add_entry(CPURISCVState *env, target_long src, target_long dst,
>                            uint64_t type, target_ulong prev_priv, bool prev_virt);
> +void riscv_ctr_clear(CPURISCVState *env);
>   
>   void riscv_translate_init(void);
>   G_NORETURN void riscv_raise_exception(CPURISCVState *env,
> diff --git a/target/riscv/cpu_helper.c b/target/riscv/cpu_helper.c
> index 1537602e1b..d98628cfe3 100644
> --- a/target/riscv/cpu_helper.c
> +++ b/target/riscv/cpu_helper.c
> @@ -702,6 +702,13 @@ void riscv_ctr_freeze(CPURISCVState *env, uint64_t freeze_mask, bool virt)
>       }
>   }
>   
> +void riscv_ctr_clear(CPURISCVState *env)
> +{
> +    memset(env->ctr_src, 0x0, sizeof(env->ctr_src));
> +    memset(env->ctr_dst, 0x0, sizeof(env->ctr_dst));
> +    memset(env->ctr_data, 0x0, sizeof(env->ctr_data));
> +}
> +
>   static uint64_t riscv_ctr_priv_to_mask(target_ulong priv, bool virt)
>   {
>       switch (priv) {
> diff --git a/target/riscv/helper.h b/target/riscv/helper.h
> index b8fb7c8734..a3b2d87527 100644
> --- a/target/riscv/helper.h
> +++ b/target/riscv/helper.h
> @@ -131,6 +131,7 @@ DEF_HELPER_6(csrrw_i128, tl, env, int, tl, tl, tl, tl)
>   #ifndef CONFIG_USER_ONLY
>   DEF_HELPER_2(sret, tl, env, tl)
>   DEF_HELPER_2(mret, tl, env, tl)
> +DEF_HELPER_1(ctr_clear, void, env)
>   DEF_HELPER_1(wfi, void, env)
>   DEF_HELPER_1(wrs_nto, void, env)
>   DEF_HELPER_1(tlb_flush, void, env)
> diff --git a/target/riscv/insn32.decode b/target/riscv/insn32.decode
> index 9cb1a1b4ec..d3d38c7c68 100644
> --- a/target/riscv/insn32.decode
> +++ b/target/riscv/insn32.decode
> @@ -107,6 +107,7 @@
>   # *** Privileged Instructions ***
>   ecall       000000000000     00000 000 00000 1110011
>   ebreak      000000000001     00000 000 00000 1110011
> +sctrclr     000100000100     00000 000 00000 1110011
>   uret        0000000    00010 00000 000 00000 1110011
>   sret        0001000    00010 00000 000 00000 1110011
>   mret        0011000    00010 00000 000 00000 1110011
> diff --git a/target/riscv/insn_trans/trans_privileged.c.inc b/target/riscv/insn_trans/trans_privileged.c.inc
> index 339d659151..dd9da8651f 100644
> --- a/target/riscv/insn_trans/trans_privileged.c.inc
> +++ b/target/riscv/insn_trans/trans_privileged.c.inc
> @@ -69,6 +69,16 @@ static bool trans_ebreak(DisasContext *ctx, arg_ebreak *a)
>       return true;
>   }
>   
> +static bool trans_sctrclr(DisasContext *ctx, arg_sctrclr *a)
> +{
> +#ifndef CONFIG_USER_ONLY
> +    gen_helper_ctr_clear(tcg_env);
This will always generate a helper function call, which can be avoided 
by checking the existence of Smctr and Ssctr here instead of checking 
them in the helper function.
> +    return true;
> +#else
> +    return false;
> +#endif
> +}
> +
>   static bool trans_uret(DisasContext *ctx, arg_uret *a)
>   {
>       return false;
> diff --git a/target/riscv/op_helper.c b/target/riscv/op_helper.c
> index 5a1e92c45e..15a770360e 100644
> --- a/target/riscv/op_helper.c
> +++ b/target/riscv/op_helper.c
> @@ -475,6 +475,39 @@ void helper_ctr_branch(CPURISCVState *env, target_ulong src, target_ulong dest,
>       }
>   }
>   
> +void helper_ctr_clear(CPURISCVState *env)
> +{
> +    if (!riscv_cpu_cfg(env)->ext_ssctr && !riscv_cpu_cfg(env)->ext_smctr) {
> +        riscv_raise_exception(env, RISCV_EXCP_ILLEGAL_INST, GETPC());
> +    }
> +
> +    /*
> +     * It's safe to call smstateen_acc_ok() for umode access regardless of the
> +     * state of bit 54 (CTR bit in case of m/hstateen) of sstateen. If the bit
> +     * is zero, smstateen_acc_ok() will return the correct exception code and
> +     * if it's one, smstateen_acc_ok() will return RISCV_EXCP_NONE. In that
> +     * scenario the U-mode check below will handle that case.
> +     */
> +    RISCVException ret = smstateen_acc_ok(env, 0, SMSTATEEN0_CTR);
> +    if (ret != RISCV_EXCP_NONE) {
> +        riscv_raise_exception(env, ret, GETPC());
> +    }
> +
> +    if (env->priv == PRV_U) {
> +        /*
> +         * One corner case is when sctrclr is executed from VU-mode and
> +         * mstateen.CTR = 0, in which case we are supposed to raise
> +         * RISCV_EXCP_ILLEGAL_INST. This case is already handled in
> +         * smstateen_acc_ok().
> +         */
> +        uint32_t excep = env->virt_enabled ? RISCV_EXCP_VIRT_INSTRUCTION_FAULT :
> +            RISCV_EXCP_ILLEGAL_INST;
> +        riscv_raise_exception(env, excep, GETPC());
> +    }
> +
> +    riscv_ctr_clear(env);
> +}
> +
>   void helper_wfi(CPURISCVState *env)
>   {
>       CPUState *cs = env_cpu(env);

