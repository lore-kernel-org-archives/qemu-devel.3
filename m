Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 26FB5CD6E49
	for <qemu-devel@archiver.kernel.org>; Sat, 30 May 2026 15:25:32 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wTLYO-0004ML-Uj; Sat, 30 May 2026 11:24:48 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1wTLY4-0004Ig-AA
 for qemu-devel@nongnu.org; Sat, 30 May 2026 11:24:29 -0400
Received: from mail-wr1-x42c.google.com ([2a00:1450:4864:20::42c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1wTLY1-0004y8-Eo
 for qemu-devel@nongnu.org; Sat, 30 May 2026 11:24:28 -0400
Received: by mail-wr1-x42c.google.com with SMTP id
 ffacd0b85a97d-45fe59255beso14625f8f.1
 for <qemu-devel@nongnu.org>; Sat, 30 May 2026 08:24:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1780154658; x=1780759458; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=miqkmpDkdxvgV3EMp6jZTGZaHE2jYmNI3ZgpaFiZpjg=;
 b=tX1clzVFGuoFf2WZXmS5yRgGtVZPWG2ZoNAio1dMPpR9fgktwIHjp7HsVTPas5VgpD
 7PhVJyuTIh4M7eDV/aUDUZj66hBQIwMl2wen/FMXTzXJ09zOewAdVKck8St8Yh6EK+ni
 vFfx17Bn8h6azUzBx8ddWvYIuS9sTd62SqhAI47wUnGdH6zH+ZwKIc9EXZd38Twb8Tyu
 9n7GjkiCqhAXlbLk6sFlYH3pdrhkhRBq04SHLKtdfknZ4bBaR1lJgRHql7tPl0WRvWjv
 dr78BBDjw6KB9HWSO5AqPFjCPQ05VyNJcNXQi5dOv/t6AIM1G5PwdgKBz2YTQTvsvn2r
 wA8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1780154658; x=1780759458;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=miqkmpDkdxvgV3EMp6jZTGZaHE2jYmNI3ZgpaFiZpjg=;
 b=R3+m59ZEv/9BRGjDGY/Rp5YkhzqUkOx7wrBLBSD4Gbh3DQVQxk4eM5VzgVjSWwUXiq
 h9KyiIYkJvnE0H2P8NWEAd8Qi3MDU/JWsMMyrnNDU60jXRbnAcu5G/XRgpCgqoBT19PZ
 hXPYh0Zsunz1G4FvoNd87uU5pIoWJoHwL8ysMlzufQz7otoh1aIdRoKnQmCMdcaGX/He
 0vWvm+DPPS/w/SfZyiplJej7FOyzFJf75p8b7t8akqZHFTI4Iw1/A80lTbnuSnvoWim4
 jKIHQDCjF72L/YFbC3vMzbebvUvkUnTEBHZND3XzCaPKdePfSeggVMBLCnbj8XhzUNOx
 jc2w==
X-Forwarded-Encrypted: i=1;
 AFNElJ9mX7y2QvibJxfGbtzGjxHI337OT/njzqQFtOa58ZYhTF7EHyisetSl8F0ZfokKFUGET/IsLQSaAflG@nongnu.org
X-Gm-Message-State: AOJu0Ywj6sVOqjTWVCmjNtUnkRv14cEODB/Ka7PrY3J3GSlLjMGDyTQ+
 DkhI8pd0zj+wzgPDzhYmV+6Vakaf2kSlh8yQfYjskq+VZrhVuXw0ftFj81lU0RIBBFtL+oOIOXn
 1OzeUBZVT3w==
X-Gm-Gg: Acq92OEO1kox6Prz1y9zaqWq8ja6+fcHCDPQ7QmqZuoxF0Nppj6gYZMyEh+R5oIEupF
 7JHyX/yTIWOf3LPkU/KznvodZnYiZzimvRg7ZGd1SIgKqflZ332rCZoDDP7oDF70dbTExR2Z1M0
 hnqvV5Ve2LK535Tsy+HZ+5771H0adhPQ/KRzQGej3ON8dj9joGEEScY1n89pCzm/1UojA4jHnjH
 Gxbk/yxeZqEovgjfIw2wbKTtIkgNfR4k6TpPiZMtYKYp4lOrMHcBabPoskhNA6AArQGNQoQ/SKL
 wcrns2TJpSXLiSZ1NKrDgc7rPKkRk9aQds8HOB45pPry3yOxaCxjak3BimPqELUgqn6p+N+VA6R
 +G0Fqod791H6pimmke0Q2SkcBcytapitVqaCqj7kmRxwj1DG0VKtWlyN4TKdjtM9K3+0hbrhCQW
 ZfllNv+VIOUDyhSwHI+gLoltmKjoVdzla5mLO1oToUG2trut8Lbk3kGCvRpk2atzwTF6M7nJcN7
 cfw
X-Received: by 2002:a05:600c:6592:b0:490:a1dc:e542 with SMTP id
 5b1f17b1804b1-490a2904ab0mr78935065e9.6.1780154658330; 
 Sat, 30 May 2026 08:24:18 -0700 (PDT)
Received: from [192.168.69.207] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-45ef34b47eesm12638888f8f.9.2026.05.30.08.24.16
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sat, 30 May 2026 08:24:16 -0700 (PDT)
Message-ID: <b115271a-d183-4211-8048-caba34c23a27@linaro.org>
Date: Mon, 5 May 2025 16:29:40 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 04/12] target/arm: Fill in TCGCPUOps.pointer_wrap
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
Cc: foss@percivaleng.com, qemu-arm@nongnu.org
References: <20250504205714.3432096-1-richard.henderson@linaro.org>
 <20250504205714.3432096-5-richard.henderson@linaro.org>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20250504205714.3432096-5-richard.henderson@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42c;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x42c.google.com
X-Spam_score_int: 13
X-Spam_score: 1.3
X-Spam_bar: +
X-Spam_report: (1.3 / 5.0 requ) BAYES_00=-1.9, DATE_IN_PAST_96_XX=3.405,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

On 4/5/25 22:57, Richard Henderson wrote:
> For a-profile, check A32 vs A64 state.
> For m-profile, use cpu_pointer_wrap_uint32.
> 
> Cc: qemu-arm@nongnu.org
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>   target/arm/cpu.c         | 24 ++++++++++++++++++++++++
>   target/arm/tcg/cpu-v7m.c |  1 +
>   2 files changed, 25 insertions(+)
> 
> diff --git a/target/arm/cpu.c b/target/arm/cpu.c
> index 45cb6fd7ee..18edcf49c6 100644
> --- a/target/arm/cpu.c
> +++ b/target/arm/cpu.c
> @@ -2710,6 +2710,29 @@ static const struct SysemuCPUOps arm_sysemu_ops = {
>   #endif
>   
>   #ifdef CONFIG_TCG
> +#ifndef CONFIG_USER_ONLY
> +static vaddr aprofile_pointer_wrap(CPUState *cs, int mmu_idx,
> +                                   vaddr result, vaddr base)
> +{
> +    /*
> +     * The Stage2 and Phys indexes are only used for ptw on arm32,
> +     * and all pte's are aligned, so we never produce a wrap for these.
> +     * Double check that we're not truncating a 40-bit physical address.
> +     */
> +    assert((unsigned)mmu_idx < (ARMMMUIdx_Stage2_S & ARM_MMU_IDX_COREIDX_MASK));
> +
> +    if (!is_a64(cpu_env(cs))) {
> +        return (uint32_t)result;

I see around ARM_MMU_IDX_* definitions:

  * R profile CPUs have an MPU, but can use the same set of MMU indexes
  * as A profile. They only need to distinguish EL0 and EL1 (and
  * EL2 for cores like the Cortex-R52).

Maybe rename as ar_profile_pointer_wrap?

Patch seems OK but I'd rather have someone with better ARM MMU
knowledge to review ;)

> +    }
> +
> +    /*
> +     * TODO: For FEAT_CPA2, decide how to we want to resolve
> +     * Unpredictable_CPACHECK in AddressIncrement.
> +     */
> +    return result;
> +}
> +#endif /* !CONFIG_USER_ONLY */
> +
>   static const TCGCPUOps arm_tcg_ops = {
>       .mttcg_supported = true,
>       /* ARM processors have a weak memory model */
> @@ -2729,6 +2752,7 @@ static const TCGCPUOps arm_tcg_ops = {
>       .untagged_addr = aarch64_untagged_addr,
>   #else
>       .tlb_fill_align = arm_cpu_tlb_fill_align,
> +    .pointer_wrap = aprofile_pointer_wrap,
>       .cpu_exec_interrupt = arm_cpu_exec_interrupt,
>       .cpu_exec_halt = arm_cpu_exec_halt,
>       .cpu_exec_reset = cpu_reset,
> diff --git a/target/arm/tcg/cpu-v7m.c b/target/arm/tcg/cpu-v7m.c
> index 95b23d9b55..8e1a083b91 100644
> --- a/target/arm/tcg/cpu-v7m.c
> +++ b/target/arm/tcg/cpu-v7m.c
> @@ -249,6 +249,7 @@ static const TCGCPUOps arm_v7m_tcg_ops = {
>       .record_sigbus = arm_cpu_record_sigbus,
>   #else
>       .tlb_fill_align = arm_cpu_tlb_fill_align,
> +    .pointer_wrap = cpu_pointer_wrap_uint32,
>       .cpu_exec_interrupt = arm_v7m_cpu_exec_interrupt,
>       .cpu_exec_halt = arm_cpu_exec_halt,
>       .cpu_exec_reset = cpu_reset,


