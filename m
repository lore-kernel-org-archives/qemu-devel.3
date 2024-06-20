Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A8219C41513
	for <qemu-devel@archiver.kernel.org>; Thu, 20 Jun 2024 19:54:17 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sKNrC-0003yz-0X; Thu, 20 Jun 2024 15:54:06 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dbarboza@ventanamicro.com>)
 id 1sKNr6-0003n4-Ck
 for qemu-devel@nongnu.org; Thu, 20 Jun 2024 15:54:00 -0400
Received: from mail-pj1-x102b.google.com ([2607:f8b0:4864:20::102b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <dbarboza@ventanamicro.com>)
 id 1sKNr4-0000po-Hd
 for qemu-devel@nongnu.org; Thu, 20 Jun 2024 15:54:00 -0400
Received: by mail-pj1-x102b.google.com with SMTP id
 98e67ed59e1d1-2bfff08fc29so1103923a91.1
 for <qemu-devel@nongnu.org>; Thu, 20 Jun 2024 12:53:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=ventanamicro.com; s=google; t=1718913237; x=1719518037; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=3mgU0ecJQ4bNICa1yM6H41haHOC2A9aIvYn3EgY5AA0=;
 b=K+YWuS4nZz2SrJRmfKt1O6m1GI4XAXIFgxYuUu5OAMlKUuMBEoS+w+LI/jtDoTss+4
 gIQ+zxI8YIAVu+UTbh4klsNGOP22sBAzjaWPTTniEe5fKrZ5nQIH3KqxpYhwVCGHfjUP
 wZDSkxy2FG9eEuuH6NwW0TzWGvEker6sPqSbkSezyMaHzPzpGHMXEqf1MANRATEczsq/
 NSTWKLGA7CA8d50IJLBN4G/ZA22Rz+fk51Q61Y+9U2VWSSxZa3DcIXoVKwGiLitGf9Ek
 h0nX+CB+GKsD1AW8M1wMS7gxcinyRvhKQBbwwUA7kygzqbphkTxVmODi/H4FOE9qjrEf
 C0wQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1718913237; x=1719518037;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=3mgU0ecJQ4bNICa1yM6H41haHOC2A9aIvYn3EgY5AA0=;
 b=Iz2+a/+JKhvpjTQ2uANkyLQyYlT7EfZRafq6ukml0VnP1X9/OwwnYfUBmOF4UARNYa
 aDsKehs3ftTo+yWovlSF+fvGR8f0hhdgIFJDR3xJ4+s4QDsAJuuqQP34bz+lTz5ZsB0M
 h8ZNDtsXf6zCNenG2nUj+MCIPvIwjMyYA0Sru2G396xVqeYXRUBXr7CpHo9HnbjZqFAZ
 CJJ/TKdWcuQ30se7ff6NUs8McnRF29AzcEZsdbcnusWgMXNNhm0Vf6bYZjbFR55t5gBq
 1CJzOee+BVowRKoqX7ExG2+37YkgUTFzw3d+ylI1yRpuNIuebdk+GmzNAJd2YZ2vTbxc
 uOpA==
X-Forwarded-Encrypted: i=1;
 AJvYcCWwAnxgqHnA2qMrNzcJhFWzifaf3o0BPZnvy0XjGcCZfDdQOfoWKS7e24bC4sgohe1tagCp+lndFNuPkC1px9hn+CeBoxY=
X-Gm-Message-State: AOJu0YzPduCitqLWKCQdv23vwWChtN1RIm45twlffit/ougs1PKe4Me8
 A94J8Nqq/LnD8UQXvPYawGmicoNbq3mOknpFuYyzLLPDPzFq3QJ9Vnwkqvzd3TN6tibEMTKn4hy
 D
X-Google-Smtp-Source: AGHT+IEDH3hEPqusuRGUghCuX9nQ4UlIYotfe1cHGuE/O3vS94fFFxRHdrNBj41VR2Kos0dOUgzKIg==
X-Received: by 2002:a17:90a:1fc7:b0:2c7:c788:d34d with SMTP id
 98e67ed59e1d1-2c7c788d4dcmr5464444a91.38.1718913237175; 
 Thu, 20 Jun 2024 12:53:57 -0700 (PDT)
Received: from ?IPV6:2804:7f0:bdcd:fb00:6501:2693:db52:c621?
 ([2804:7f0:bdcd:fb00:6501:2693:db52:c621])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-2c7e55dcccasm2088738a91.31.2024.06.20.12.53.53
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 20 Jun 2024 12:53:56 -0700 (PDT)
Message-ID: <67d320fe-66ff-4686-8ea6-cf68190f9132@ventanamicro.com>
Date: Thu, 20 Jun 2024 16:53:50 -0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 5/6] target/riscv: Add Zc extension implied rule
To: frank.chang@sifive.com, qemu-devel@nongnu.org
Cc: Palmer Dabbelt <palmer@dabbelt.com>,
 Alistair Francis <alistair.francis@wdc.com>, Bin Meng <bmeng.cn@gmail.com>,
 Weiwei Li <liwei1518@gmail.com>, Liu Zhiwei <zhiwei_liu@linux.alibaba.com>,
 "open list:RISC-V TCG CPUs" <qemu-riscv@nongnu.org>,
 Jerry Zhang Jian <jerry.zhangjian@sifive.com>, Max Chou <max.chou@sifive.com>
References: <20240616024657.17948-1-frank.chang@sifive.com>
 <20240616024657.17948-6-frank.chang@sifive.com>
Content-Language: en-US
From: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
In-Reply-To: <20240616024657.17948-6-frank.chang@sifive.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::102b;
 envelope-from=dbarboza@ventanamicro.com; helo=mail-pj1-x102b.google.com
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
> Zc extension has special implied rules that need to be handled separately.
> 
> Signed-off-by: Frank Chang <frank.chang@sifive.com>
> Reviewed-by: Jerry Zhang Jian <jerry.zhangjian@sifive.com>
> Tested-by: Max Chou <max.chou@sifive.com>
> ---

Reviewed-by: Daniel Henrique Barboza <dbarboza@ventanamicro.com>

>   target/riscv/tcg/tcg-cpu.c | 34 ++++++++++++++++++++++++++++++++++
>   1 file changed, 34 insertions(+)
> 
> diff --git a/target/riscv/tcg/tcg-cpu.c b/target/riscv/tcg/tcg-cpu.c
> index f8d6371764..fe84d4402e 100644
> --- a/target/riscv/tcg/tcg-cpu.c
> +++ b/target/riscv/tcg/tcg-cpu.c
> @@ -902,11 +902,45 @@ static void cpu_enable_implied_rule(RISCVCPU *cpu,
>       }
>   }
>   
> +/* Zc extension has special implied rules that need to be handled separately. */
> +static void cpu_enable_zc_implied_rules(RISCVCPU *cpu)
> +{
> +    RISCVCPUClass *mcc = RISCV_CPU_GET_CLASS(cpu);
> +    CPURISCVState *env = &cpu->env;
> +
> +    if (cpu->cfg.ext_zce) {
> +        cpu_cfg_ext_auto_update(cpu, CPU_CFG_OFFSET(ext_zca), true);
> +        cpu_cfg_ext_auto_update(cpu, CPU_CFG_OFFSET(ext_zcb), true);
> +        cpu_cfg_ext_auto_update(cpu, CPU_CFG_OFFSET(ext_zcmp), true);
> +        cpu_cfg_ext_auto_update(cpu, CPU_CFG_OFFSET(ext_zcmt), true);
> +
> +        if (riscv_has_ext(env, RVF) && mcc->misa_mxl_max == MXL_RV32) {
> +            cpu_cfg_ext_auto_update(cpu, CPU_CFG_OFFSET(ext_zcf), true);
> +        }
> +    }
> +
> +    /* Zca, Zcd and Zcf has a PRIV 1.12.0 restriction */
> +    if (riscv_has_ext(env, RVC) && env->priv_ver >= PRIV_VERSION_1_12_0) {
> +        cpu_cfg_ext_auto_update(cpu, CPU_CFG_OFFSET(ext_zca), true);
> +
> +        if (riscv_has_ext(env, RVF) && mcc->misa_mxl_max == MXL_RV32) {
> +            cpu_cfg_ext_auto_update(cpu, CPU_CFG_OFFSET(ext_zcf), true);
> +        }
> +
> +        if (riscv_has_ext(env, RVD)) {
> +            cpu_cfg_ext_auto_update(cpu, CPU_CFG_OFFSET(ext_zcd), true);
> +        }
> +    }
> +}
> +
>   static void riscv_cpu_enable_implied_rules(RISCVCPU *cpu)
>   {
>       RISCVCPUImpliedExtsRule *rule;
>       int i;
>   
> +    /* Enable the implied extensions for Zc. */
> +    cpu_enable_zc_implied_rules(cpu);
> +
>       /* Enable the implied MISAs. */
>       for (i = 0; (rule = riscv_misa_implied_rules[i]); i++) {
>           if (riscv_has_ext(&cpu->env, rule->ext)) {

