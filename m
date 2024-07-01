Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 48CC2C2BD09
	for <qemu-devel@archiver.kernel.org>; Mon,  1 Jul 2024 19:39:40 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sOMrr-0001Gl-4G; Mon, 01 Jul 2024 15:39:15 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dbarboza@ventanamicro.com>)
 id 1sOMro-0001GN-TY
 for qemu-devel@nongnu.org; Mon, 01 Jul 2024 15:39:12 -0400
Received: from mail-pl1-x630.google.com ([2607:f8b0:4864:20::630])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <dbarboza@ventanamicro.com>)
 id 1sOMrm-0000xn-7j
 for qemu-devel@nongnu.org; Mon, 01 Jul 2024 15:39:11 -0400
Received: by mail-pl1-x630.google.com with SMTP id
 d9443c01a7336-1f6fabe9da3so19804345ad.0
 for <qemu-devel@nongnu.org>; Mon, 01 Jul 2024 12:39:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=ventanamicro.com; s=google; t=1719862748; x=1720467548; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=TDSiGneJCdNw4uwBfJMM5U8FSM7QwZWIIwYTIEskkRk=;
 b=ouWOnSFJfa4bJkX9vo4Ugok82kbNCutoM1o8Xrq/chgCcGQJ+TTV3jEEeVyHE+guR3
 F8L3eEltyfrh6/WIi3aozqwH27Ju8wXzZcsViEp9qby3DtZHbtEdpbuAY82AlU9Uh2yd
 wo8s3HvGKLhyeB6O/CpFw7RYIgitzryH9ywcd9QICllfvvhxGNHJdW7neFTCatq96Qkb
 KkYZOINGI+X345/wgWfg6u3hyhMMJqxVEDseUEEHGZ153pcSyjLLsdfvlQ3ImO09qEhX
 XkGf0jGISklMFjWDLCDuwZnfQ83ryM+tbKHaqgiiUy7E8dfFxNdUOU+79KSaLkgJS8dC
 aGiQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1719862748; x=1720467548;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=TDSiGneJCdNw4uwBfJMM5U8FSM7QwZWIIwYTIEskkRk=;
 b=gPDQGzQfIiIhXagc29TfPFyQ8wQ/DbmzTb23f+6uT4VVAQcuGyBpugcR8WuV9KfOWb
 QZqhUYgn85T/1XTtdr6t3wbbB9jHxWA0VqtXUt7raLpUsvuXFJepKmBNnHbKGiunAplb
 AzyjMwkgY+iDxJQqJhrxHuEJ3BFVt0HDYrn853985Rx5DQycSvtA+K7Y+d37jWJtqJDw
 Zi1aiddaL5IPwOQYKwlzsXS456r/rD41ZP52D27o6n3dMiRQoN88BcG1xdWfmgIjETsS
 dty1ZZb1sKPX+gvdb8pVlD23RKU6dnA5ibceJYLcyaRZKUVDvOxRVXiVrcY6TwcD/LF8
 zTcQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCXePZ66W3td9GbcChUNy92cm8sV8VGGE5AB0BbffRE9AwhDOHnRTFWSQ56EHnAIAmZ8WhXHbBtJiqmRp1REYikOQiMxXCM=
X-Gm-Message-State: AOJu0YzoDIuR68nt0rsbc5j4x5D2bUvjDMGocfWRiKMfGAwi2Q9wDTL0
 dNXrYsyRsRw5Bjn+TPaIBKcMSoBEzLIkIG6CPM0NWCu7tVY2PPoiZlVZY9W/egk=
X-Google-Smtp-Source: AGHT+IH80gw73lAnSFqf9aG+p4dTATR8kw5QwATlnI5nXq8PkMwCQ51ODN2gIO/eJdizUCmIDShspA==
X-Received: by 2002:a17:903:22c5:b0:1fa:a89:fd1a with SMTP id
 d9443c01a7336-1fadbc73843mr40889635ad.10.1719862747763; 
 Mon, 01 Jul 2024 12:39:07 -0700 (PDT)
Received: from ?IPV6:2804:7f0:bcc0:1aea:63a7:288e:eb77:fe54?
 ([2804:7f0:bcc0:1aea:63a7:288e:eb77:fe54])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-1fac1599c23sm68441335ad.280.2024.07.01.12.39.04
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 01 Jul 2024 12:39:07 -0700 (PDT)
Message-ID: <8faf9cd8-571d-4fd9-b553-cfdfd46d5b0f@ventanamicro.com>
Date: Mon, 1 Jul 2024 16:39:03 -0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v7 11/11] target/riscv: Do not setup pmu timer if OF is
 disabled
To: Atish Patra <atishp@rivosinc.com>, qemu-riscv@nongnu.org,
 qemu-devel@nongnu.org
Cc: Rajnesh Kanwal <rkanwal@rivosinc.com>, palmer@dabbelt.com,
 liwei1518@gmail.com, zhiwei_liu@linux.alibaba.com, bin.meng@windriver.com,
 alistair.francis@wdc.com
References: <20240626-smcntrpmf_v7-v7-0-bb0f10af7fa9@rivosinc.com>
 <20240626-smcntrpmf_v7-v7-11-bb0f10af7fa9@rivosinc.com>
Content-Language: en-US
From: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
In-Reply-To: <20240626-smcntrpmf_v7-v7-11-bb0f10af7fa9@rivosinc.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::630;
 envelope-from=dbarboza@ventanamicro.com; helo=mail-pl1-x630.google.com
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
> The timer is setup function is invoked in both hpmcounter
> write and mcountinhibit write path. If the OF bit set, the
> LCOFI interrupt is disabled. There is no benefitting in
> setting up the qemu timer until LCOFI is cleared to indicate
> that interrupts can be fired again.
> 
> Signed-off-by: Atish Patra <atishp@rivosinc.com>
> ---

Reviewed-by: Daniel Henrique Barboza <dbarboza@ventanamicro.com>

>   target/riscv/pmu.c | 56 ++++++++++++++++++++++++++++++++++++++++++------------
>   1 file changed, 44 insertions(+), 12 deletions(-)
> 
> diff --git a/target/riscv/pmu.c b/target/riscv/pmu.c
> index a4729f6c53bb..3cc0b3648cad 100644
> --- a/target/riscv/pmu.c
> +++ b/target/riscv/pmu.c
> @@ -416,14 +416,49 @@ int riscv_pmu_update_event_map(CPURISCVState *env, uint64_t value,
>       return 0;
>   }
>   
> +static bool pmu_hpmevent_is_of_set(CPURISCVState *env, uint32_t ctr_idx)
> +{
> +    target_ulong mhpmevent_val;
> +    uint64_t of_bit_mask;
> +
> +    if (riscv_cpu_mxl(env) == MXL_RV32) {
> +        mhpmevent_val = env->mhpmeventh_val[ctr_idx];
> +        of_bit_mask = MHPMEVENTH_BIT_OF;
> +     } else {
> +        mhpmevent_val = env->mhpmevent_val[ctr_idx];
> +        of_bit_mask = MHPMEVENT_BIT_OF;
> +    }
> +
> +    return get_field(mhpmevent_val, of_bit_mask);
> +}
> +
> +static bool pmu_hpmevent_set_of_if_clear(CPURISCVState *env, uint32_t ctr_idx)
> +{
> +    target_ulong *mhpmevent_val;
> +    uint64_t of_bit_mask;
> +
> +    if (riscv_cpu_mxl(env) == MXL_RV32) {
> +        mhpmevent_val = &env->mhpmeventh_val[ctr_idx];
> +        of_bit_mask = MHPMEVENTH_BIT_OF;
> +     } else {
> +        mhpmevent_val = &env->mhpmevent_val[ctr_idx];
> +        of_bit_mask = MHPMEVENT_BIT_OF;
> +    }
> +
> +    if (!get_field(*mhpmevent_val, of_bit_mask)) {
> +        *mhpmevent_val |= of_bit_mask;
> +        return true;
> +    }
> +
> +    return false;
> +}
> +
>   static void pmu_timer_trigger_irq(RISCVCPU *cpu,
>                                     enum riscv_pmu_event_idx evt_idx)
>   {
>       uint32_t ctr_idx;
>       CPURISCVState *env = &cpu->env;
>       PMUCTRState *counter;
> -    target_ulong *mhpmevent_val;
> -    uint64_t of_bit_mask;
>       int64_t irq_trigger_at;
>       uint64_t curr_ctr_val, curr_ctrh_val;
>       uint64_t ctr_val;
> @@ -439,12 +474,9 @@ static void pmu_timer_trigger_irq(RISCVCPU *cpu,
>           return;
>       }
>   
> -    if (riscv_cpu_mxl(env) == MXL_RV32) {
> -        mhpmevent_val = &env->mhpmeventh_val[ctr_idx];
> -        of_bit_mask = MHPMEVENTH_BIT_OF;
> -     } else {
> -        mhpmevent_val = &env->mhpmevent_val[ctr_idx];
> -        of_bit_mask = MHPMEVENT_BIT_OF;
> +    /* Generate interrupt only if OF bit is clear */
> +    if (pmu_hpmevent_is_of_set(env, ctr_idx)) {
> +        return;
>       }
>   
>       counter = &env->pmu_ctrs[ctr_idx];
> @@ -477,9 +509,7 @@ static void pmu_timer_trigger_irq(RISCVCPU *cpu,
>       }
>   
>       if (cpu->pmu_avail_ctrs & BIT(ctr_idx)) {
> -        /* Generate interrupt only if OF bit is clear */
> -        if (!(*mhpmevent_val & of_bit_mask)) {
> -            *mhpmevent_val |= of_bit_mask;
> +        if (pmu_hpmevent_set_of_if_clear(env, ctr_idx)) {
>               riscv_cpu_update_mip(env, MIP_LCOFIP, BOOL_TO_MASK(1));
>           }
>       }
> @@ -502,7 +532,9 @@ int riscv_pmu_setup_timer(CPURISCVState *env, uint64_t value, uint32_t ctr_idx)
>       RISCVCPU *cpu = env_archcpu(env);
>       PMUCTRState *counter = &env->pmu_ctrs[ctr_idx];
>   
> -    if (!riscv_pmu_counter_valid(cpu, ctr_idx) || !cpu->cfg.ext_sscofpmf) {
> +    /* No need to setup a timer if LCOFI is disabled when OF is set */
> +    if (!riscv_pmu_counter_valid(cpu, ctr_idx) || !cpu->cfg.ext_sscofpmf ||
> +        pmu_hpmevent_is_of_set(env, ctr_idx)) {
>           return -1;
>       }
>   
> 

