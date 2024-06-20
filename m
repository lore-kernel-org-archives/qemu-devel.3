Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DBA98C27C79
	for <qemu-devel@archiver.kernel.org>; Thu, 20 Jun 2024 19:53:05 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sKNpx-0002Aj-QS; Thu, 20 Jun 2024 15:52:49 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dbarboza@ventanamicro.com>)
 id 1sKNpv-00029o-M1
 for qemu-devel@nongnu.org; Thu, 20 Jun 2024 15:52:47 -0400
Received: from mail-pj1-x1035.google.com ([2607:f8b0:4864:20::1035])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <dbarboza@ventanamicro.com>)
 id 1sKNpt-0000jU-PT
 for qemu-devel@nongnu.org; Thu, 20 Jun 2024 15:52:47 -0400
Received: by mail-pj1-x1035.google.com with SMTP id
 98e67ed59e1d1-2c31144881eso1098621a91.1
 for <qemu-devel@nongnu.org>; Thu, 20 Jun 2024 12:52:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=ventanamicro.com; s=google; t=1718913164; x=1719517964; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=qKX+DFUt/R/wcox2lUteMR9f7Nxb6mB4nR+l80ESKdY=;
 b=ckLqrD4x4OVnn6sDpl7g8kZJUvquK6eyd5ZLt4s3eMCh8O7da7R3p43lTini4QKGC/
 W/cazCU+YKeFTbGGxZHQK5OgTb2dcEgitz5VmEet0+87Kp41l5hqqWfxEiVMsSEChSeK
 J5HnDq2rio9RpzWQidvjx17TP9IHbqMWH23ISgrF0XshrUKytSPyvwj4K58SU1/Q+wbW
 XJE/iALl6qm1nlBfj4O4EuBBaocWuhZ6ZRjA0cntTbXcwXdXhples09feCsJXg4qS4Cr
 ABKm+fBBv9P30EbCjX8Eh14G3Fa5Gre1rJoRFAaJPl1scu7l7PxMgPjTpLbs3H0UCKzw
 sAaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1718913164; x=1719517964;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=qKX+DFUt/R/wcox2lUteMR9f7Nxb6mB4nR+l80ESKdY=;
 b=TyLp5Jf9MrFrco84m1O/mB7HGpFd1bgQIXlVOQlxS9VZiNTRtEdjNDqNZvRS0G808J
 205gXd1B4V68RVgW4TasF0SYoKt74TU5jTzdylSOnAVvz/9ueezPnOwbjMYwgy6RJ7Bt
 F7l0JEeNyZP2z+hOM+ycTSA6uV2PqMZ2Ez1tGxtNiZfG2qvP3cErk1ZZ1nJWTTNmx0GB
 uzEVYSC0Yt44LHmk7rrTok2Uu4Tr0nfUqNnn1LffovDRYCLpCgkweB8Z8LOiU95vpjVL
 /5XrT58P/fLKAUImg9l0dxQsT3fAR0LJ9BlIZddptD81LotTtKxAlQqsKA6VpL2WTQud
 /skA==
X-Forwarded-Encrypted: i=1;
 AJvYcCUQzW7Z2tdwOpvbsiUoNocgpzhHnRWBGoEotbhVUT6iVdLXxWZWqBdTAMDDco/0ujqS2N5AAALN5LAT+vhDQo+VtVPp+As=
X-Gm-Message-State: AOJu0Yxes79sJvHXQsdugTUMyE74AmOvW0M+vMdd+eSwuud356QaLnvk
 p5EKWBtxeTCMu16sXkYRuS4H3NjTOJm/2p/waqEDJ1zEMaoyzlQI1fFYX3I4pnc=
X-Google-Smtp-Source: AGHT+IHzNpZ4kPn0kseOp/OmC0Z4PDDmf3W0hMfDuQ6di87ffpHIJRgh2kTtuG5SfVCLAYRz/GuLlQ==
X-Received: by 2002:a17:90a:de94:b0:2c2:e7e5:5c29 with SMTP id
 98e67ed59e1d1-2c7b5ccf9c7mr6098901a91.29.1718913164234; 
 Thu, 20 Jun 2024 12:52:44 -0700 (PDT)
Received: from ?IPV6:2804:7f0:bdcd:fb00:6501:2693:db52:c621?
 ([2804:7f0:bdcd:fb00:6501:2693:db52:c621])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-2c7e5af9e1fsm2093615a91.36.2024.06.20.12.52.40
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 20 Jun 2024 12:52:43 -0700 (PDT)
Message-ID: <4757a019-30b3-4372-85ed-4832e2165e27@ventanamicro.com>
Date: Thu, 20 Jun 2024 16:52:39 -0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 2/6] target/riscv: Introduce extension implied rule
 helpers
To: frank.chang@sifive.com, qemu-devel@nongnu.org
Cc: Palmer Dabbelt <palmer@dabbelt.com>,
 Alistair Francis <alistair.francis@wdc.com>, Bin Meng <bmeng.cn@gmail.com>,
 Weiwei Li <liwei1518@gmail.com>, Liu Zhiwei <zhiwei_liu@linux.alibaba.com>,
 "open list:RISC-V TCG CPUs" <qemu-riscv@nongnu.org>,
 Jerry Zhang Jian <jerry.zhangjian@sifive.com>, Max Chou <max.chou@sifive.com>
References: <20240616024657.17948-1-frank.chang@sifive.com>
 <20240616024657.17948-3-frank.chang@sifive.com>
Content-Language: en-US
From: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
In-Reply-To: <20240616024657.17948-3-frank.chang@sifive.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::1035;
 envelope-from=dbarboza@ventanamicro.com; helo=mail-pj1-x1035.google.com
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



On 6/15/24 11:46 PM, frank.chang@sifive.com wrote:
> From: Frank Chang <frank.chang@sifive.com>
> 
> Introduce helpers to enable the extensions based on the implied rules.
> The implied extensions are enabled recursively, so we don't have to
> expand all of them manually. This also eliminates the old-fashioned
> ordering requirement. For example, Zvksg implies Zvks, Zvks implies
> Zvksed, etc., removing the need to check the implied rules of Zvksg
> before Zvks.
> 
> Signed-off-by: Frank Chang <frank.chang@sifive.com>
> Reviewed-by: Jerry Zhang Jian <jerry.zhangjian@sifive.com>
> Tested-by: Max Chou <max.chou@sifive.com>
> ---

Reviewed-by: Daniel Henrique Barboza <dbarboza@ventanamicro.com>

>   target/riscv/tcg/tcg-cpu.c | 91 ++++++++++++++++++++++++++++++++++++++
>   1 file changed, 91 insertions(+)
> 
> diff --git a/target/riscv/tcg/tcg-cpu.c b/target/riscv/tcg/tcg-cpu.c
> index eb6f7b9d12..f8d6371764 100644
> --- a/target/riscv/tcg/tcg-cpu.c
> +++ b/target/riscv/tcg/tcg-cpu.c
> @@ -36,6 +36,9 @@
>   static GHashTable *multi_ext_user_opts;
>   static GHashTable *misa_ext_user_opts;
>   
> +static GHashTable *misa_implied_rules;
> +static GHashTable *ext_implied_rules;
> +
>   static bool cpu_cfg_ext_is_user_set(uint32_t ext_offset)
>   {
>       return g_hash_table_contains(multi_ext_user_opts,
> @@ -836,11 +839,97 @@ static void riscv_cpu_validate_profiles(RISCVCPU *cpu)
>       }
>   }
>   
> +static void riscv_cpu_init_implied_exts_rules(void)
> +{
> +    RISCVCPUImpliedExtsRule *rule;
> +    int i;
> +
> +    for (i = 0; (rule = riscv_misa_implied_rules[i]); i++) {
> +        g_hash_table_insert(misa_implied_rules, GUINT_TO_POINTER(rule->ext),
> +                            (gpointer)rule);
> +    }
> +
> +    for (i = 0; (rule = riscv_ext_implied_rules[i]); i++) {
> +        g_hash_table_insert(ext_implied_rules, GUINT_TO_POINTER(rule->ext),
> +                            (gpointer)rule);
> +    }
> +}
> +
> +static void cpu_enable_implied_rule(RISCVCPU *cpu,
> +                                    RISCVCPUImpliedExtsRule *rule)
> +{
> +    CPURISCVState *env = &cpu->env;
> +    RISCVCPUImpliedExtsRule *ir;
> +    bool enabled = false;
> +    int i;
> +
> +#ifndef CONFIG_USER_ONLY
> +    enabled = qatomic_read(&rule->enabled) & BIT_ULL(cpu->env.mhartid);
> +#endif
> +
> +    if (!enabled) {
> +        /* Enable the implied MISAs. */
> +        if (rule->implied_misas) {
> +            riscv_cpu_set_misa_ext(env, env->misa_ext | rule->implied_misas);
> +
> +            for (i = 0; misa_bits[i] != 0; i++) {
> +                if (rule->implied_misas & misa_bits[i]) {
> +                    ir = g_hash_table_lookup(misa_implied_rules,
> +                                             GUINT_TO_POINTER(misa_bits[i]));
> +
> +                    if (ir) {
> +                        cpu_enable_implied_rule(cpu, ir);
> +                    }
> +                }
> +            }
> +        }
> +
> +        /* Enable the implied extensions. */
> +        for (i = 0; rule->implied_exts[i] != RISCV_IMPLIED_EXTS_RULE_END; i++) {
> +            cpu_cfg_ext_auto_update(cpu, rule->implied_exts[i], true);
> +
> +            ir = g_hash_table_lookup(ext_implied_rules,
> +                                     GUINT_TO_POINTER(rule->implied_exts[i]));
> +
> +            if (ir) {
> +                cpu_enable_implied_rule(cpu, ir);
> +            }
> +        }
> +
> +#ifndef CONFIG_USER_ONLY
> +        qatomic_or(&rule->enabled, BIT_ULL(cpu->env.mhartid));
> +#endif
> +    }
> +}
> +
> +static void riscv_cpu_enable_implied_rules(RISCVCPU *cpu)
> +{
> +    RISCVCPUImpliedExtsRule *rule;
> +    int i;
> +
> +    /* Enable the implied MISAs. */
> +    for (i = 0; (rule = riscv_misa_implied_rules[i]); i++) {
> +        if (riscv_has_ext(&cpu->env, rule->ext)) {
> +            cpu_enable_implied_rule(cpu, rule);
> +        }
> +    }
> +
> +    /* Enable the implied extensions. */
> +    for (i = 0; (rule = riscv_ext_implied_rules[i]); i++) {
> +        if (isa_ext_is_enabled(cpu, rule->ext)) {
> +            cpu_enable_implied_rule(cpu, rule);
> +        }
> +    }
> +}
> +
>   void riscv_tcg_cpu_finalize_features(RISCVCPU *cpu, Error **errp)
>   {
>       CPURISCVState *env = &cpu->env;
>       Error *local_err = NULL;
>   
> +    riscv_cpu_init_implied_exts_rules();
> +    riscv_cpu_enable_implied_rules(cpu);
> +
>       riscv_cpu_validate_misa_priv(env, &local_err);
>       if (local_err != NULL) {
>           error_propagate(errp, local_err);
> @@ -1346,6 +1435,8 @@ static void riscv_tcg_cpu_instance_init(CPUState *cs)
>   
>       misa_ext_user_opts = g_hash_table_new(NULL, g_direct_equal);
>       multi_ext_user_opts = g_hash_table_new(NULL, g_direct_equal);
> +    misa_implied_rules = g_hash_table_new(NULL, g_direct_equal);
> +    ext_implied_rules = g_hash_table_new(NULL, g_direct_equal);
>       riscv_cpu_add_user_properties(obj);
>   
>       if (riscv_cpu_has_max_extensions(obj)) {

