Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8F198EDEBF9
	for <qemu-devel@archiver.kernel.org>; Tue,  3 Mar 2026 22:35:32 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vxYKg-0004Fr-ML; Tue, 03 Mar 2026 17:35:14 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1vxYKe-0004Fj-FN
 for qemu-devel@nongnu.org; Tue, 03 Mar 2026 17:35:12 -0500
Received: from mail-pg1-x52c.google.com ([2607:f8b0:4864:20::52c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1vxYKc-0000xs-Qc
 for qemu-devel@nongnu.org; Tue, 03 Mar 2026 17:35:12 -0500
Received: by mail-pg1-x52c.google.com with SMTP id
 41be03b00d2f7-c70ea5e9e9dso2258933a12.1
 for <qemu-devel@nongnu.org>; Tue, 03 Mar 2026 14:35:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1772577309; x=1773182109; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=cJhuPwuUVg5YuDiElIynvNSC5St5OIpuCjigwF+HnF0=;
 b=CTpM+vaqXok+3AChnnuiJIl1bNIKOQBFZ/KDVxDTb2PKA4Z6CgTPExBqgLlb1il+7b
 WGfAR0QfptIADATcN4SeMbnOn6I+HK4tVt95B0h1+hFRaanzDSDsKIE0J5EN4YP1ul7m
 5jmcqvvG1YvGHGQjIwo+MnjkKKNq61++/QrHriYoc1lNBztAZVtQWdxo26p2O0LKNgB9
 Ymdm7l+RDudi2v1Yhw9QnkUe+WyU7JGvgPTLj3zj5KBLJ+kuJpA5+ukmAmgUGAy+LHV+
 BRQE9D7XzJhRvkaJInA95JWg6FManjV2sYCG5k2u1icNDBskkumQUdxe2qmTeM3+qqde
 7ROg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1772577309; x=1773182109;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=cJhuPwuUVg5YuDiElIynvNSC5St5OIpuCjigwF+HnF0=;
 b=wjjjFVtR1yxNVbInaOX2oE29MBrgk3KIYtnmHYb/bZi33EqoFpfRUQ+OqDgaRcPvy2
 pqvp3M7MIgXR3ksp5rpDWDTNgizTiijzcHsdeUrXyj63VLyRb6OqOuCHhz27VZqbrLIS
 496UTiYiMZX5gg/MUkb28I3aPl6F1qQO2H0Lc4KZ+Jrv6kH24++IVyAWmnZQK036/i63
 cZswlH8bWUZ0NJzpqNCu/u8sLwhRQiF49xPmg4SYjdj3lZAZSkqucd7Xgdj+DHPdnWJ3
 3nbqo9Azlfd3FCzDdbyZ88DBwXH5LQtNaFjH1KMp4bPE0PfuH0gqeCRUyiJiv3582nBV
 xKpg==
X-Forwarded-Encrypted: i=1;
 AJvYcCWJWfoXVjBCOBqEVnEHD3oc+gvrWCwtNf2F6c0kwl11HDdSVEPwi4aTdNYT28lItQA4LqSqRq34mHbI@nongnu.org
X-Gm-Message-State: AOJu0YyZVVELfHj9TvqZynYOH4/UU55ccfY9u9F+u49doDaR+fOZ1fY5
 scpD50kTFQK0A+4JJThnXkDsJpvgcBgSAEvMtURQ0B1RkJ2LRVlDRgLcla1bz3Z2b8EJFQ0un15
 ZYMTfenY=
X-Gm-Gg: ATEYQzzddq788l6+zUHMIzm9EDb0rD9UPEd5uZVEZh/J5Ig8lLuHZ1u7MizndkWN98I
 +IOGmBrLLslZ2kYc10SkmP0fZEGm0M1f+trqQqfr5r1sn4wIuLGY8YrwzEVkaSdEyFAaSiukMxl
 YWXRzt59FdRu+Y37DMsswi8Uf1xcXo4UnUqz3MI0O9M372L1OrzW8VGxri223z0xFO1a6W64dhK
 Mbm7kLwuE7cjFkt/y9v+iyvNb2NuC2i668hMCnrCQxwJ3xC6AO2KmOR/QIKq6i5cwPgtd/cgxSX
 wj9X5MeWuZminxX4PxGDhKsx42cFMt5cO+ClFc7i7lpy5Ui/lLYs/uTznBn/flqTfwgh/he4Jzb
 tVIRGZkg4aWVugXORRO1GAmj6FTO48akK+iYE20v/OjotjmRB4S+WxVEbf0mvPDWeLAGaNe5bsZ
 Q7umiBd7fxRge8Kk4H10hBefzfSjZqZzbWx5Nk9E/Rqsf39P/NEZal
X-Received: by 2002:a17:902:c94b:b0:2ae:5442:45cf with SMTP id
 d9443c01a7336-2ae54424962mr82594605ad.33.1772577309139; 
 Tue, 03 Mar 2026 14:35:09 -0800 (PST)
Received: from [192.168.10.140] ([180.233.125.15])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-3599cc41db6sm1710291a91.13.2026.03.03.14.35.06
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 03 Mar 2026 14:35:08 -0800 (PST)
Message-ID: <988762d7-6cbc-4ef7-889c-0482502ae248@linaro.org>
Date: Wed, 4 Mar 2026 09:35:03 +1100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 3/4] hppa: Get physical address space bits from
 HPPACPUDef
To: Anton Johansson <anjo@rev.ng>, qemu-devel@nongnu.org
Cc: Helge Deller <deller@gmx.de>
References: <20260303-hppa-c3600-v5-0-277bfe6b40b8@rev.ng>
 <20260303-hppa-c3600-v5-3-277bfe6b40b8@rev.ng>
From: Richard Henderson <richard.henderson@linaro.org>
Content-Language: en-US
In-Reply-To: <20260303-hppa-c3600-v5-3-277bfe6b40b8@rev.ng>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::52c;
 envelope-from=richard.henderson@linaro.org; helo=mail-pg1-x52c.google.com
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
List-Id: qemu development <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

On 3/4/26 03:11, Anton Johansson wrote:
> Reviewed-by: Helge Deller <deller@gmx.de>
> Signed-off-by: Anton Johansson <anjo@rev.ng>
> ---
>   target/hppa/cpu.h        | 11 ++++++++---
>   hw/hppa/machine.c        |  4 ++--
>   hw/pci-host/astro.c      |  2 +-
>   target/hppa/cpu.c        |  9 ++++++++-
>   target/hppa/mem_helper.c | 39 +++++++++++----------------------------
>   5 files changed, 30 insertions(+), 35 deletions(-)
> 
> diff --git a/target/hppa/cpu.h b/target/hppa/cpu.h
> index 43b4882fb4..487f0f5e9e 100644
> --- a/target/hppa/cpu.h
> +++ b/target/hppa/cpu.h
> @@ -320,6 +320,11 @@ static inline const HPPACPUDef *hppa_def(CPUHPPAState *env)
>       return HPPA_CPU_GET_CLASS(env_cpu(env))->def;
>   }
>   
> +static inline uint8_t hppa_phys_addr_bits(CPUHPPAState *env)
> +{
> +    return hppa_def(env)->phys_addr_bits;
> +}
> +
>   static inline bool hppa_is_pa20(CPUHPPAState *env)
>   {
>       return hppa_def(env)->is_pa20;
> @@ -352,9 +357,9 @@ static inline vaddr hppa_form_gva(CPUHPPAState *env, uint64_t spc,
>       return hppa_form_gva_mask(env->gva_offset_mask, spc, off);
>   }
>   
> -hwaddr hppa_abs_to_phys_pa1x(vaddr addr);
> -hwaddr hppa_abs_to_phys_pa2_w0(vaddr addr);
> -hwaddr hppa_abs_to_phys_pa2_w1(vaddr addr);
> +hwaddr hppa_abs_to_phys_pa1x(CPUHPPAState *env, vaddr addr);
> +hwaddr hppa_abs_to_phys_pa2_w0(CPUHPPAState *env, vaddr addr);
> +hwaddr hppa_abs_to_phys_pa2_w1(CPUHPPAState *env, vaddr addr);
>   
>   /*
>    * Since PSW_{I,CB} will never need to be in tb->flags, reuse them.
> diff --git a/hw/hppa/machine.c b/hw/hppa/machine.c
> index 5d0d4de09e..bb6b7dc76c 100644
> --- a/hw/hppa/machine.c
> +++ b/hw/hppa/machine.c
> @@ -181,12 +181,12 @@ static uint64_t linux_kernel_virt_to_phys(void *opaque, uint64_t addr)
>   
>   static uint64_t translate_pa10(void *dummy, uint64_t addr)
>   {
> -    return hppa_abs_to_phys_pa1x(addr);
> +    return hppa_abs_to_phys_pa1x(cpu_env(first_cpu), addr);
>   }
>   
>   static uint64_t translate_pa20(void *dummy, uint64_t addr)
>   {
> -    return hppa_abs_to_phys_pa2_w0(addr);
> +    return hppa_abs_to_phys_pa2_w0(cpu_env(first_cpu), addr);
>   }
>   
>   static HPPACPU *cpu[HPPA_MAX_CPUS];
> diff --git a/hw/pci-host/astro.c b/hw/pci-host/astro.c
> index 00a904277c..d38f81e553 100644
> --- a/hw/pci-host/astro.c
> +++ b/hw/pci-host/astro.c
> @@ -303,7 +303,7 @@ static IOMMUTLBEntry astro_translate_iommu(IOMMUMemoryRegion *iommu,
>        * language which not-coincidentally matches the PSW.W=0 mapping.
>        */
>       if (addr <= UINT32_MAX) {
> -        entry = hppa_abs_to_phys_pa2_w0(addr);
> +        entry = hppa_abs_to_phys_pa2_w0(cpu_env(first_cpu), addr);
>       } else {
>           entry = addr;
>       }
> diff --git a/target/hppa/cpu.c b/target/hppa/cpu.c
> index cc755da8be..b04bcfa6a0 100644
> --- a/target/hppa/cpu.c
> +++ b/target/hppa/cpu.c
> @@ -282,7 +282,14 @@ static void hppa_cpu_class_base_init(ObjectClass *oc, const void *data)
>       HPPACPUClass *acc = HPPA_CPU_CLASS(oc);
>       /* Make sure all CPU models define a HPPACPUDef */
>       g_assert(!object_class_is_abstract(oc) && data != NULL);
> -    acc->def = data;
> +    if (data) {

You just asserted data != NULL.


r~

