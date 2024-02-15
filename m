Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 31782C48BC4
	for <qemu-devel@archiver.kernel.org>; Thu, 15 Feb 2024 20:22:00 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1raiEL-0004xa-34; Thu, 15 Feb 2024 15:21:13 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dbarboza@ventanamicro.com>)
 id 1raiEJ-0004vm-Dj
 for qemu-devel@nongnu.org; Thu, 15 Feb 2024 15:21:11 -0500
Received: from mail-pl1-x635.google.com ([2607:f8b0:4864:20::635])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <dbarboza@ventanamicro.com>)
 id 1raiEG-0006RV-5v
 for qemu-devel@nongnu.org; Thu, 15 Feb 2024 15:21:11 -0500
Received: by mail-pl1-x635.google.com with SMTP id
 d9443c01a7336-1d71cb97937so13116355ad.3
 for <qemu-devel@nongnu.org>; Thu, 15 Feb 2024 12:21:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=ventanamicro.com; s=google; t=1708028465; x=1708633265; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=llkySfZMZVR6N0eP5dCv9W52SMF7H6ZoRsxlIERnhpE=;
 b=X/yk2WuiApHKc063UlB2gauYl4UWubTyWyWgvCEWr57EFiJg5480+usCyeDKTqBEAd
 pZ836/pU1rghzxSgyyINEbObDZYsWUem0mLlcOR8FNxsOJO3PtYQFEwggC3aWCvio38b
 Xvvj3U9PqIp8mixDJP+i7tVPzw3lOYH9PQJ6rPa82KL/frTCZklCd3TUoc7LR4Eb6cy3
 kAMvkz9VMEHHA7+kdZKgtGMjjCemWJCqdtH7JcnTwoSMyWOw7QL+VwRDkRpNp86tGmjy
 Eey5Xxb9DNoLC80u9L+TPzwhrXJ7j3u1Z0yyUnNnUnm0JMr5sicCHYoIwzfdLnFpDUwY
 pkiQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1708028465; x=1708633265;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=llkySfZMZVR6N0eP5dCv9W52SMF7H6ZoRsxlIERnhpE=;
 b=DvbQImAWaMNK4u9OFGm4h/oDacXyvICsgxU+lqGU2hbh5F7XDajkOS8Ne/5aJ/a62i
 KgePoQ54Zm+QVpVPPuDcrB4NhVOl0IftcU3gKIJF/a9k/kdeMxFMFD7lpJ/jny2BJ22i
 unw9uruc2KQ7IqiSujVcAGV4ERvQTeQBqD0JfJNnmg8wNl7g0KAqLO07cUmHVxgq6zTH
 NdV3Hu0hKlLl3vJYoSLuxyEExREHqUF1roOZuOEtAD+86SqheNNSvg917cUvdbpCWu3H
 Pyz3QxrGSH07rW/u29LhsABl6g2UsMla/ctts/jYHlOkUouyawW/Ec33vNhaFYpa8R9R
 dezA==
X-Forwarded-Encrypted: i=1;
 AJvYcCX67YmIoJxlfGEutfl2k8bEL21ASrkKA7IRPOC7Ywlnc5fqiR8lker9NqvDZZ5a6xy1OmlaoF2m/sSYsi0YTvSKcr4tDqk=
X-Gm-Message-State: AOJu0YwJkYWYJK44NGjlcB5lVqJJfiOQxQIXaSWu0bqdVuA/pj7XUZWO
 m4KllySzGt8UlQmh6I/a2biF7vWsljhbp0kmseQFjQSjCfgSuI1fmWg3FQpqhlpHCMYqukYqzJi
 8
X-Google-Smtp-Source: AGHT+IGWhayL25YlmQRZMb8uxtloNwr5v7vf5rB9gtp3TH9fqSUxWRiHXkP+VegfKOBFKW0dMJEW6Q==
X-Received: by 2002:a17:903:244d:b0:1db:5d07:f8ea with SMTP id
 l13-20020a170903244d00b001db5d07f8eamr3240866pls.64.1708028465601; 
 Thu, 15 Feb 2024 12:21:05 -0800 (PST)
Received: from ?IPV6:2804:7f0:bdcd:fb00:6501:2693:db52:c621?
 ([2804:7f0:bdcd:fb00:6501:2693:db52:c621])
 by smtp.gmail.com with ESMTPSA id
 b12-20020a170902bd4c00b001db693d89fdsm1651860plx.179.2024.02.15.12.21.03
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 15 Feb 2024 12:21:05 -0800 (PST)
Message-ID: <2d119d74-3a12-4efa-94e1-acebfe4f0742@ventanamicro.com>
Date: Thu, 15 Feb 2024 17:21:02 -0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH 2/6] accel/tcg: Avoid uncessary call overhead from
 qemu_plugin_vcpu_mem_cb
Content-Language: en-US
To: Max Chou <max.chou@sifive.com>, qemu-devel@nongnu.org,
 qemu-riscv@nongnu.org
Cc: Richard Henderson <richard.henderson@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>
References: <20240215192823.729209-1-max.chou@sifive.com>
 <20240215192823.729209-3-max.chou@sifive.com>
From: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
In-Reply-To: <20240215192823.729209-3-max.chou@sifive.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::635;
 envelope-from=dbarboza@ventanamicro.com; helo=mail-pl1-x635.google.com
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



On 2/15/24 16:28, Max Chou wrote:
> If there are not any QEMU plugin memory callback functions, checking
> before calling the qemu_plugin_vcpu_mem_cb function can reduce the
> function call overhead.
> 
> Signed-off-by: Max Chou <max.chou@sifive.com>
> ---

This was in my TODO list for some time. Thanks for looking it up.

Can't we avoid all callbacks, not just qemu_plugin_vcpu_mem_cb, if there's no
plugin loaded? The performance increase when building with --disable-plugins
shouldn't be a thing - if the user isn't using plug-ins it should have a
penalty to it.

Thanks,

Daniel

>   accel/tcg/ldst_common.c.inc | 40 +++++++++++++++++++++++++++----------
>   1 file changed, 30 insertions(+), 10 deletions(-)
> 
> diff --git a/accel/tcg/ldst_common.c.inc b/accel/tcg/ldst_common.c.inc
> index c82048e377e..bf24986c562 100644
> --- a/accel/tcg/ldst_common.c.inc
> +++ b/accel/tcg/ldst_common.c.inc
> @@ -134,7 +134,9 @@ uint8_t cpu_ldb_mmu(CPUArchState *env, abi_ptr addr, MemOpIdx oi, uintptr_t ra)
>   
>       tcg_debug_assert((get_memop(oi) & MO_SIZE) == MO_UB);
>       ret = do_ld1_mmu(env_cpu(env), addr, oi, ra, MMU_DATA_LOAD);
> -    plugin_load_cb(env, addr, oi);
> +    if (cpu_plugin_mem_cbs_enabled(env_cpu(env))) {
> +        plugin_load_cb(env, addr, oi);
> +    }
>       return ret;
>   }
>   
> @@ -145,7 +147,9 @@ uint16_t cpu_ldw_mmu(CPUArchState *env, abi_ptr addr,
>   
>       tcg_debug_assert((get_memop(oi) & MO_SIZE) == MO_16);
>       ret = do_ld2_mmu(env_cpu(env), addr, oi, ra, MMU_DATA_LOAD);
> -    plugin_load_cb(env, addr, oi);
> +    if (cpu_plugin_mem_cbs_enabled(env_cpu(env))) {
> +        plugin_load_cb(env, addr, oi);
> +    }
>       return ret;
>   }
>   
> @@ -156,7 +160,9 @@ uint32_t cpu_ldl_mmu(CPUArchState *env, abi_ptr addr,
>   
>       tcg_debug_assert((get_memop(oi) & MO_SIZE) == MO_32);
>       ret = do_ld4_mmu(env_cpu(env), addr, oi, ra, MMU_DATA_LOAD);
> -    plugin_load_cb(env, addr, oi);
> +    if (cpu_plugin_mem_cbs_enabled(env_cpu(env))) {
> +        plugin_load_cb(env, addr, oi);
> +    }
>       return ret;
>   }
>   
> @@ -167,7 +173,9 @@ uint64_t cpu_ldq_mmu(CPUArchState *env, abi_ptr addr,
>   
>       tcg_debug_assert((get_memop(oi) & MO_SIZE) == MO_64);
>       ret = do_ld8_mmu(env_cpu(env), addr, oi, ra, MMU_DATA_LOAD);
> -    plugin_load_cb(env, addr, oi);
> +    if (cpu_plugin_mem_cbs_enabled(env_cpu(env))) {
> +        plugin_load_cb(env, addr, oi);
> +    }
>       return ret;
>   }
>   
> @@ -178,7 +186,9 @@ Int128 cpu_ld16_mmu(CPUArchState *env, abi_ptr addr,
>   
>       tcg_debug_assert((get_memop(oi) & MO_SIZE) == MO_128);
>       ret = do_ld16_mmu(env_cpu(env), addr, oi, ra);
> -    plugin_load_cb(env, addr, oi);
> +    if (cpu_plugin_mem_cbs_enabled(env_cpu(env))) {
> +        plugin_load_cb(env, addr, oi);
> +    }
>       return ret;
>   }
>   
> @@ -195,7 +205,9 @@ void cpu_stb_mmu(CPUArchState *env, abi_ptr addr, uint8_t val,
>                    MemOpIdx oi, uintptr_t retaddr)
>   {
>       helper_stb_mmu(env, addr, val, oi, retaddr);
> -    plugin_store_cb(env, addr, oi);
> +    if (cpu_plugin_mem_cbs_enabled(env_cpu(env))) {
> +        plugin_store_cb(env, addr, oi);
> +    }
>   }
>   
>   void cpu_stw_mmu(CPUArchState *env, abi_ptr addr, uint16_t val,
> @@ -203,7 +215,9 @@ void cpu_stw_mmu(CPUArchState *env, abi_ptr addr, uint16_t val,
>   {
>       tcg_debug_assert((get_memop(oi) & MO_SIZE) == MO_16);
>       do_st2_mmu(env_cpu(env), addr, val, oi, retaddr);
> -    plugin_store_cb(env, addr, oi);
> +    if (cpu_plugin_mem_cbs_enabled(env_cpu(env))) {
> +        plugin_store_cb(env, addr, oi);
> +    }
>   }
>   
>   void cpu_stl_mmu(CPUArchState *env, abi_ptr addr, uint32_t val,
> @@ -211,7 +225,9 @@ void cpu_stl_mmu(CPUArchState *env, abi_ptr addr, uint32_t val,
>   {
>       tcg_debug_assert((get_memop(oi) & MO_SIZE) == MO_32);
>       do_st4_mmu(env_cpu(env), addr, val, oi, retaddr);
> -    plugin_store_cb(env, addr, oi);
> +    if (cpu_plugin_mem_cbs_enabled(env_cpu(env))) {
> +        plugin_store_cb(env, addr, oi);
> +    }
>   }
>   
>   void cpu_stq_mmu(CPUArchState *env, abi_ptr addr, uint64_t val,
> @@ -219,7 +235,9 @@ void cpu_stq_mmu(CPUArchState *env, abi_ptr addr, uint64_t val,
>   {
>       tcg_debug_assert((get_memop(oi) & MO_SIZE) == MO_64);
>       do_st8_mmu(env_cpu(env), addr, val, oi, retaddr);
> -    plugin_store_cb(env, addr, oi);
> +    if (cpu_plugin_mem_cbs_enabled(env_cpu(env))) {
> +        plugin_store_cb(env, addr, oi);
> +    }
>   }
>   
>   void cpu_st16_mmu(CPUArchState *env, abi_ptr addr, Int128 val,
> @@ -227,7 +245,9 @@ void cpu_st16_mmu(CPUArchState *env, abi_ptr addr, Int128 val,
>   {
>       tcg_debug_assert((get_memop(oi) & MO_SIZE) == MO_128);
>       do_st16_mmu(env_cpu(env), addr, val, oi, retaddr);
> -    plugin_store_cb(env, addr, oi);
> +    if (cpu_plugin_mem_cbs_enabled(env_cpu(env))) {
> +        plugin_store_cb(env, addr, oi);
> +    }
>   }
>   
>   /*

