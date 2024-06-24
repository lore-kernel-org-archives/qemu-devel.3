Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 38D71C2BD09
	for <qemu-devel@archiver.kernel.org>; Mon, 24 Jun 2024 17:03:17 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sLn5C-0004n8-P8; Mon, 24 Jun 2024 13:02:22 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <minhquangbui99@gmail.com>)
 id 1sLn5B-0004mX-5I
 for qemu-devel@nongnu.org; Mon, 24 Jun 2024 13:02:21 -0400
Received: from mail-pf1-x42f.google.com ([2607:f8b0:4864:20::42f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <minhquangbui99@gmail.com>)
 id 1sLn59-0001ug-DF
 for qemu-devel@nongnu.org; Mon, 24 Jun 2024 13:02:20 -0400
Received: by mail-pf1-x42f.google.com with SMTP id
 d2e1a72fcca58-706627ff48dso1937619b3a.1
 for <qemu-devel@nongnu.org>; Mon, 24 Jun 2024 10:02:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1719248537; x=1719853337; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=TgrgCqsmVUSWsqB/Yo24ECxC1vm0Opw3swgMentvX0w=;
 b=LETznU9meYV4OyUNDUj8kRdzHr7SZKHemf0Wds0LlTC3fvirR0/Y/nF+F9KsRfL+ss
 AfJMf5XgJrEsU8lWKAiCou0CHjH2gzTmyMtJIUXvcv/dv8c8sAH362N9BnFylYQAFjTc
 fdKLVU7IYMOr+MUzcz7OMV0qwJxY1d3lzcINXrZ/sRD5kZRiS2uvB5ZgCj5NikruXzZQ
 ECjXsj73tDQFrjRvoeQUSfYQyVQtMG/QUAhw46gHLiqkZmjSljzzyttoC2sOW2BUPQL7
 QfcPwaSuuTQELGPj13uNfhEthHCMjYLEQi4xDl77HbKtPO1WtbeVmEk4K2Y2nSePfHQe
 BC8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1719248537; x=1719853337;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=TgrgCqsmVUSWsqB/Yo24ECxC1vm0Opw3swgMentvX0w=;
 b=nlgzoBiEVutjoQ3PELFxReS3tf+9kSCaJPK2CYi9i7wgUsXH7Y+WPvvEISzGIbEx7U
 0jD1240yIB+wijEWX4Uela30hv8sF2tzDTKVwXzV+0Tkcx10FiyjxEAuRLDEO3gAjjJe
 Rev0fCuaD5XJDJz6tNKwJ9LtQURuaid+8b7bPhhMhi/Uuwh79fof3VlukCzXALKIqRJr
 pJ8diA0y50BEXLVKpjD0nVhudqBvZGz+SHiX9cJFHya3gpIPbhnK1bGujE4tPpq2ZWr6
 Nrot4tNuIkaOD/jFhV+FcwPTdiqTtNxo+5bAgaFTN6R6GORu1NuCEktm6Mm5cj9WB+Wa
 74Jg==
X-Forwarded-Encrypted: i=1;
 AJvYcCWZnUZPYbCA5nj0eOdDIO/dksUT6rMKc6ukSlLamSL5dqRwOrigX0vUQFcT4899ERSFoLG0+uE9EZJnJurXlyjwdb64g7Y=
X-Gm-Message-State: AOJu0YyqjqxmmFP1AUYwjcsAo61Z94rs2fHX/uKdYwG2a8fdkD7K/zTp
 cJIYSJDW2jTlTs7OqpIe1slMRg4FVg7ZVCJYJN+N9xdmLOTiLvW+
X-Google-Smtp-Source: AGHT+IF+ymfkFkJ5xYTnM6iT4EJqA5Imu0MlYDbPOr4B6Dh9XRaEX8JHrtWlYjjfhej0cNJWqKww7g==
X-Received: by 2002:a17:90a:ea17:b0:2c7:e001:6172 with SMTP id
 98e67ed59e1d1-2c86141dddbmr4556033a91.48.1719248537248; 
 Mon, 24 Jun 2024 10:02:17 -0700 (PDT)
Received: from [192.168.0.115] ([14.191.222.211])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-2c819a8f786sm6943167a91.34.2024.06.24.10.02.15
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 24 Jun 2024 10:02:16 -0700 (PDT)
Message-ID: <dc25d2d7-fbd2-488b-b7c8-48e3b9d61776@gmail.com>
Date: Tue, 25 Jun 2024 00:02:13 +0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] i386/hvf: Integrates x2APIC support with hvf accel
To: Phil Dennis-Jordan <phil@philjordan.eu>, qemu-devel@nongnu.org
Cc: dirty@apple.com, rbolshakov@ddn.com, lists@philjordan.eu
References: <20240624094647.77156-1-phil@philjordan.eu>
Content-Language: en-US
From: Bui Quang Minh <minhquangbui99@gmail.com>
In-Reply-To: <20240624094647.77156-1-phil@philjordan.eu>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::42f;
 envelope-from=minhquangbui99@gmail.com; helo=mail-pf1-x42f.google.com
X-Spam_score_int: -17
X-Spam_score: -1.8
X-Spam_bar: -
X-Spam_report: (-1.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FREEMAIL_ENVFROM_END_DIGIT=0.25, FREEMAIL_FROM=0.001,
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

On 6/24/24 16:46, Phil Dennis-Jordan wrote:
> Support for x2APIC mode was recently introduced in the software emulated
> APIC implementation for TCG. Enabling it when using macOS’s hvf
> accelerator is useful and significantly helps performance, as Qemu
> currently uses the emulated APIC when running on hvf as well.
> 
> This change wires up the read & write operations for the MSR VM exits
> and allow-lists the CPUID flag in the x86 hvf runtime.
> 
> Signed-off-by: Phil Dennis-Jordan <phil@philjordan.eu>
> ---
>   target/i386/hvf/x86_cpuid.c |  4 ++--
>   target/i386/hvf/x86_emu.c   | 31 +++++++++++++++++++++++++++++++
>   2 files changed, 33 insertions(+), 2 deletions(-)
> 
> diff --git a/target/i386/hvf/x86_cpuid.c b/target/i386/hvf/x86_cpuid.c
> index e56cd8411b..4f260d46a8 100644
> --- a/target/i386/hvf/x86_cpuid.c
> +++ b/target/i386/hvf/x86_cpuid.c
> @@ -64,8 +64,8 @@ uint32_t hvf_get_supported_cpuid(uint32_t func, uint32_t idx,
>                CPUID_PAT | CPUID_PSE36 | CPUID_CLFLUSH | CPUID_MMX |
>                CPUID_FXSR | CPUID_SSE | CPUID_SSE2 | CPUID_SS;
>           ecx &= CPUID_EXT_SSE3 | CPUID_EXT_PCLMULQDQ | CPUID_EXT_SSSE3 |
> -             CPUID_EXT_FMA | CPUID_EXT_CX16 | CPUID_EXT_PCID |
> -             CPUID_EXT_SSE41 | CPUID_EXT_SSE42 | CPUID_EXT_MOVBE |
> +             CPUID_EXT_FMA | CPUID_EXT_CX16 | CPUID_EXT_PCID | CPUID_EXT_SSE41 |
> +             CPUID_EXT_SSE42 | CPUID_EXT_X2APIC | CPUID_EXT_MOVBE |
>                CPUID_EXT_POPCNT | CPUID_EXT_AES | CPUID_EXT_XSAVE |
>                CPUID_EXT_AVX | CPUID_EXT_F16C | CPUID_EXT_RDRAND;
>           ecx |= CPUID_EXT_HYPERVISOR;
> diff --git a/target/i386/hvf/x86_emu.c b/target/i386/hvf/x86_emu.c
> index 38c782b8e3..be675bcfb7 100644
> --- a/target/i386/hvf/x86_emu.c
> +++ b/target/i386/hvf/x86_emu.c
> @@ -663,6 +663,15 @@ static void exec_lods(CPUX86State *env, struct x86_decode *decode)
>       env->eip += decode->len;
>   }
>   
> +static void raise_exception(CPUX86State *env, int exception_index,
> +                            int error_code)
> +{
> +    env->exception_nr = exception_index;
> +    env->error_code = error_code;
> +    env->has_error_code = true;
> +    env->exception_injected = 1;
> +}
> +
>   void simulate_rdmsr(CPUX86State *env)
>   {
>       X86CPU *cpu = env_archcpu(env);
> @@ -677,6 +686,17 @@ void simulate_rdmsr(CPUX86State *env)
>       case MSR_IA32_APICBASE:
>           val = cpu_get_apic_base(cpu->apic_state);
>           break;
> +    case MSR_APIC_START ... MSR_APIC_END: {
> +        int ret;
> +        int index = (uint32_t)env->regs[R_ECX] - MSR_APIC_START;
> +
> +        ret = apic_msr_read(index, &val);
> +        if (ret < 0) {
> +            raise_exception(env, EXCP0D_GPF, 0);
> +        }
> +
> +        break;
> +    }
>       case MSR_IA32_UCODE_REV:
>           val = cpu->ucode_rev;
>           break;
> @@ -777,6 +797,17 @@ void simulate_wrmsr(CPUX86State *env)
>       case MSR_IA32_APICBASE:
>           cpu_set_apic_base(cpu->apic_state, data);
>           break;
> +    case MSR_APIC_START ... MSR_APIC_END: {
> +        int ret;
> +        int index = (uint32_t)env->regs[R_ECX] - MSR_APIC_START;
> +
> +        ret = apic_msr_write(index, data);
> +        if (ret < 0) {
> +            raise_exception(env, EXCP0D_GPF, 0);
> +        }
> +
> +        break;
> +    }
>       case MSR_FSBASE:
>           wvmcs(cs->accel->fd, VMCS_GUEST_FS_BASE, data);
>           break;

Acked-by: Bui Quang Minh <minhquangbui99@gmail.com>

