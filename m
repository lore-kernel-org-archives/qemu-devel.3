Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DE17CC369B2
	for <qemu-devel@archiver.kernel.org>; Thu, 17 Apr 2025 10:02:13 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u5M4H-0003vL-Bc; Thu, 17 Apr 2025 06:02:01 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1u5M40-0003uu-45
 for qemu-devel@nongnu.org; Thu, 17 Apr 2025 06:01:44 -0400
Received: from mail-wm1-x32a.google.com ([2a00:1450:4864:20::32a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1u5M3x-0002lM-OJ
 for qemu-devel@nongnu.org; Thu, 17 Apr 2025 06:01:43 -0400
Received: by mail-wm1-x32a.google.com with SMTP id
 5b1f17b1804b1-43d04ea9d9aso2619425e9.3
 for <qemu-devel@nongnu.org>; Thu, 17 Apr 2025 03:01:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1744884100; x=1745488900; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=QvC94Pc+7EGjof3EEjWr9xBEqVfwbilB9/MicTkVeW4=;
 b=MEQxrTOeJiq9nE47R7AajBOcRlmhFbQ7z3c+q1DgpxVFu1QlcJczbsm3ONqDF5XAve
 +BpJ2TgURWMsTTSxrb9dhXHu/xg9Cm1kB20oAjfKz1f6aotfBCVm67j0rLVRCMMsUwod
 TW90tKFcc9ze9vQDOdiDYmbRSDdRpBzes41ziyE0T+OJGZThcfEhr+6QSRihpYfkiupa
 AJVWIwIx3iAaOLOhN+I7bW+YnGcfrnUDZKiq+t1Zc70o310BKIih3ClF/QMuCVYKFOz4
 5QIbTLPKH0KdIg8UN8+rPzhxRF24CuaV31kipoS4iAGlkHIe2RXU0YDtf3D/DADamujD
 UhxQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1744884100; x=1745488900;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=QvC94Pc+7EGjof3EEjWr9xBEqVfwbilB9/MicTkVeW4=;
 b=DsyASiRj1ihEnJWKvk4nNtCeClJosZCjfI0zbVMpTH2q6BkLizBzDpCTZKdYk4z9LU
 K9WD3caz3nwlh7Dl42GSJNZHs5cNOxWWlScgmzDUa30ZZk21mlUYTjhDDF8FUgPxg+Wp
 s1piw78wtigBgKSNwcovIZ8DNqhJiZEv2SK8LIM9EZTpwlfaXN+cX9hTbNUlcls3L/sM
 j9DKrd8DwXvG/RMVSfSFuh7DqVzeY/PAPlR8bWExlkSyfvOxM9q31h9ARn1A8gGFhxo7
 WYWMThvfXE0Q56Jjod0DnAUUYcoS5ap6UxTlzvUx+PFIwb4dTv/5QrzFLPuSfadotJac
 +zZg==
X-Gm-Message-State: AOJu0YwguVjTmtKGg46o6C27ecuTTLCjy5lm9zyk0p6VCNsTh1H6eInL
 oXyPr4ZdFafhOoI7IEH1IVYX5SPJmQCvg7Ge2125V2zc23cs9FwMvguR0RCKB9U=
X-Gm-Gg: ASbGncs8V/YInXtXcoPUquXXU0u4/16dnQ0QUBp1KZ1XmiDj32o14pfgfHmoHQRkEja
 WxIRv5YcYpP6BlONQHUqw+haFPQYe5gkQ3090eB7bTwu0t3LlvgsIJX5OuLU4PZ1EJ2TlJ8L5S1
 ODvn4VwPCNMDGR3CE6TRJoqqhTnb0+Mx3o1wa/sj52iLjm04OF0Skwu9Rk0K0algwsGVa10SpTL
 PqMx965EjKrv4GY4POMysZletQ5QEHsqiZBiNzybAA/QhYKKu7wtw6cdrTsQ9wb4sGyDkjbXj4Y
 s4rJsCv0qLRzRGGJVj6nXEuGVK1JmhaHAC4dm+bWpAzZNKIbvA0doz4+KFvGMXSfXm77JnHe0Il
 1elKiiekt
X-Google-Smtp-Source: AGHT+IGmE+mz1qS01O2yUM313JgkehCspM/c0cRYMYehZ41205T/vJF80vM96ZU13n041S+msYDB7Q==
X-Received: by 2002:a5d:6da5:0:b0:399:6dc0:f15b with SMTP id
 ffacd0b85a97d-39ee5bad621mr4890313f8f.48.1744884100216; 
 Thu, 17 Apr 2025 03:01:40 -0700 (PDT)
Received: from [192.168.69.176] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-39eaf445515sm19178938f8f.89.2025.04.17.03.01.39
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 17 Apr 2025 03:01:39 -0700 (PDT)
Message-ID: <33b477b3-6579-4c6e-afb2-d54fa4e13141@linaro.org>
Date: Thu, 17 Apr 2025 12:01:39 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 6/6] target/loongarch: Move function
 loongarch_tlb_search to directory tcg
To: Bibo Mao <maobibo@loongson.cn>, Song Gao <gaosong@loongson.cn>,
 Richard Henderson <richard.henderson@linaro.org>
Cc: qemu-devel@nongnu.org
References: <20250417035143.268248-1-maobibo@loongson.cn>
 <20250417035143.268248-7-maobibo@loongson.cn>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20250417035143.268248-7-maobibo@loongson.cn>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32a;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x32a.google.com
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

On 17/4/25 05:51, Bibo Mao wrote:
> Function loongarch_tlb_search() and loongarch_map_tlb_entry() works
> only in TCG mode, move these functions to directory tcg.
> 
> Signed-off-by: Bibo Mao <maobibo@loongson.cn>
> ---
>   target/loongarch/cpu_helper.c     | 153 ------------------------------
>   target/loongarch/internals.h      |  14 ++-
>   target/loongarch/tcg/tlb_helper.c | 144 ++++++++++++++++++++++++++++
>   3 files changed, 156 insertions(+), 155 deletions(-)


> diff --git a/target/loongarch/internals.h b/target/loongarch/internals.h
> index 9fdc3059d8..f85927860b 100644
> --- a/target/loongarch/internals.h
> +++ b/target/loongarch/internals.h
> @@ -54,8 +54,6 @@ uint64_t cpu_loongarch_get_constant_timer_counter(LoongArchCPU *cpu);
>   uint64_t cpu_loongarch_get_constant_timer_ticks(LoongArchCPU *cpu);
>   void cpu_loongarch_store_constant_timer_config(LoongArchCPU *cpu,
>                                                  uint64_t value);
> -bool loongarch_tlb_search(CPULoongArchState *env, target_ulong vaddr,
> -                          int *index);
>   int get_physical_address(CPULoongArchState *env, hwaddr *physical,
>                            int *prot, target_ulong address,
>                            MMUAccessType access_type, int mmu_idx, int is_debug);
> @@ -67,6 +65,18 @@ hwaddr loongarch_cpu_get_phys_page_debug(CPUState *cpu, vaddr addr);
>   bool loongarch_cpu_tlb_fill(CPUState *cs, vaddr address, int size,
>                               MMUAccessType access_type, int mmu_idx,
>                               bool probe, uintptr_t retaddr);
> +int loongarch_get_addr_from_tlb(CPULoongArchState *env, hwaddr *physical,
> +                                int *prot, target_ulong address,
> +                                MMUAccessType access_type, int mmu_idx);
> +#else
> +static inline int loongarch_get_addr_from_tlb(CPULoongArchState *env,
> +                                              hwaddr *physical,
> +                                              int *prot, target_ulong address,
> +                                              MMUAccessType access_type,
> +                                              int mmu_idx)
> +{
> +    return TLBRET_NOMATCH;
> +}
>   #endif

I wonder if we shouldn't move these declarations to
target/loongarch/tcg/tcg_loongarch.h. Can be done as
future cleanup, so:

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>

>   #endif /* !CONFIG_USER_ONLY */
>   

