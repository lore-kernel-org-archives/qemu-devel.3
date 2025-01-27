Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E3BE3C0218C
	for <qemu-devel@archiver.kernel.org>; Mon, 27 Jan 2025 07:39:38 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tcJiM-0001Ci-4S; Mon, 27 Jan 2025 02:39:22 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tcJiH-0001C5-32
 for qemu-devel@nongnu.org; Mon, 27 Jan 2025 02:39:18 -0500
Received: from mail-wm1-x334.google.com ([2a00:1450:4864:20::334])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tcJiF-0000Cn-86
 for qemu-devel@nongnu.org; Mon, 27 Jan 2025 02:39:16 -0500
Received: by mail-wm1-x334.google.com with SMTP id
 5b1f17b1804b1-436a39e4891so26624465e9.1
 for <qemu-devel@nongnu.org>; Sun, 26 Jan 2025 23:39:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1737963553; x=1738568353; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=Gpv2l3R1VJBW+Ge2xKFxwGte3q9zy3oa3cWK5QGMrqg=;
 b=JCapP66Y8kQAsaK+2URdA1sokJUXLcWZOONVDE6V7VkWk1hVHnub0sQCmHqpk+ZROY
 k0UMhC9wjkfrLrTVgdVgZcFabzFnajzu0Iy+AvvRGGwJkQyuP6ZsqPawNH+KSin/BKXg
 1P3FIUTqo51/zfKB51Y3KVE/ZPyvGY3+bzVxNEZT6f3Rf/e9z7M8EgrcqnLGAZvFpkf8
 W2q2/KH1PL9Cp9cxgeoWAIZcMlvOM3WnQPDWu8oIcAvK64GLth8Q8BB3N64B0uH7xD2M
 i4RXQdldoedc1RGc3u3ZGmmmvkJ7SyQFjT/ylgebO+RgjtvLUCo7eZjIQKH6E5vhuw6q
 LZ/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1737963553; x=1738568353;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=Gpv2l3R1VJBW+Ge2xKFxwGte3q9zy3oa3cWK5QGMrqg=;
 b=puQAFUBZCcEg3386+j/GAlVbwRN664nu2ynKR7em9agR1J6GddQyb792TE1GSKsx9V
 q0Q8UyDRtXrEzocZhNsTJMe0hIGe3BqbNMQ1PRXwUhlgxc9NUy4TjGPXcwk1DPfPm5N7
 oVLJKZn7kcsi6ZGOaKov26oZ6lx2zIr8VsO64FWbPuVtcF5W0fI1AARNJuuRDhdGZs+q
 VNWCQk1g+ZX+HCTEGNRLDB6qhR7cijUiBaXweIxhK9iuuoSGv6qK7UylMeaVxLOZDqY5
 2D4ZwB0q1WJBaRPHxBXy8LZIw6kk7vWXlop8H5C/DU3HvdFJeACIatUbhhHaFsBy0EKu
 HOow==
X-Gm-Message-State: AOJu0YxerTtj9pK7HqV7dEs7uvOOLcpcMdZ+/R5pqKkUAUiSIOqYIPk9
 ndSFWM4r84p2xbD3rKzd0vJmudgM0C7DqpPJHeXlzmuS+92pVbYdsxd+5cn8Toy0+tJPgNHbBkD
 YDPM=
X-Gm-Gg: ASbGnctmS/Qdxks8zKoXzIcqDrf5f0Oekw1V5bB4+pXh+ERS1YaiLZtJNVdxCRFebx4
 L2af6rwU33bdWKAH/J2aTQqFG+Vu083EDRDgksKNl2Ho0X4yZ7lWrAwwYm1bq9lfaKp23eIvjKD
 rnnfyXQqqHUDERlFkcbLS7wc8HKeTK8ghSkgXoHjQfpygT1sksAfCzqltwWCNbNo/d1XEx7c+RT
 SgyV26DDSg+xC5+D9Tz7elariopFf9Ak982i0gCOwdLkMGtgez35ZwB+BmJP7LOZoAVcvwLGKJO
 lF8wFkzv4TSWtagYRNuG163vWyXacuGuuebEGaUZHw52fwfy
X-Google-Smtp-Source: AGHT+IGVNKOIDIrhyJe9b/wsftL9iaX14dDk27caZYFeYEToUKsT9tv+UPV7H9UnxMTeyeLnwa8JtA==
X-Received: by 2002:a05:600c:1d14:b0:436:46f9:4fc6 with SMTP id
 5b1f17b1804b1-438913d63cfmr355823035e9.8.1737963552700; 
 Sun, 26 Jan 2025 23:39:12 -0800 (PST)
Received: from [192.168.69.181] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-438bd47eecasm120152875e9.6.2025.01.26.23.39.11
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sun, 26 Jan 2025 23:39:12 -0800 (PST)
Message-ID: <2eff4bdc-ac87-42ae-a896-38883c515de9@linaro.org>
Date: Mon, 27 Jan 2025 08:39:11 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 10/15] target/ppc: Restrict ppc_tcg_hv_emu() to TCG
To: qemu-devel@nongnu.org
Cc: Daniel Henrique Barboza <danielhb413@gmail.com>,
 Harsh Prateek Bora <harshpb@linux.ibm.com>,
 Richard Henderson <richard.henderson@linaro.org>, qemu-ppc@nongnu.org,
 Nicholas Piggin <npiggin@gmail.com>
References: <20250123215609.30432-1-philmd@linaro.org>
 <20250123215609.30432-11-philmd@linaro.org>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20250123215609.30432-11-philmd@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::334;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x334.google.com
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

On 23/1/25 22:56, Philippe Mathieu-Daudé wrote:
> Make is_prefix_insn_excp() prototype but have it guarded by
> a tcg_enabled() check. Inline part of it in powerpc_excp_books().
> 
> Extract POWERPC_EXCP_HV_EMU handling code to ppc_tcg_hv_emu(),
> also exposing its prototype in "internal.h".
> 
> Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
> ---
>   target/ppc/internal.h        |   3 ++
>   target/ppc/excp_helper.c     | 101 +++++------------------------------
>   target/ppc/tcg-excp_helper.c |  71 ++++++++++++++++++++++++
>   3 files changed, 86 insertions(+), 89 deletions(-)

I missed this code is TARGET_PPC64 ...:

>   static void powerpc_excp_books(PowerPCCPU *cpu, int excp)
>   {
>       CPUPPCState *env = &cpu->env;
> @@ -1310,7 +1236,15 @@ static void powerpc_excp_books(PowerPCCPU *cpu, int excp)
>       }
>       vector |= env->excp_prefix;
>   
> -    if (is_prefix_insn_excp(cpu, excp)) {
> +    if (env->insns_flags2 & PPC2_ISA310) {
> +        /* nothing to do */
> +    } else if (kvm_enabled()) {
> +        /*
> +         * This does not load instructions and set the prefix bit correctly
> +         * for injected interrupts with KVM. That may have to be discovered
> +         * and set by the KVM layer before injecting.
> +         */
> +    } else if (tcg_enabled() && is_prefix_insn_excp(env, excp)) {
>           msr |= PPC_BIT(34);
>       }
>   
> @@ -1484,20 +1418,9 @@ static void powerpc_excp_books(PowerPCCPU *cpu, int excp)
>           new_msr |= env->msr & ((target_ulong)1 << MSR_RI);
>           break;
>   #ifdef CONFIG_TCG
> -    case POWERPC_EXCP_HV_EMU: {
> -        uint32_t insn = ppc_ldl_code(env, env->nip);
> -        env->spr[SPR_HEIR] = insn;
> -        if (is_prefix_insn(env, insn)) {
> -            uint32_t insn2 = ppc_ldl_code(env, env->nip + 4);
> -            env->spr[SPR_HEIR] <<= 32;
> -            env->spr[SPR_HEIR] |= insn2;
> -        }
> -        srr0 = SPR_HSRR0;
> -        srr1 = SPR_HSRR1;
> -        new_msr |= (target_ulong)MSR_HVB;
> -        new_msr |= env->msr & ((target_ulong)1 << MSR_RI);
> +    case POWERPC_EXCP_HV_EMU:
> +        ppc_tcg_hv_emu(env, &new_msr, &srr0, &srr1);
>           break;
> -    }
>   #endif


> diff --git a/target/ppc/tcg-excp_helper.c b/target/ppc/tcg-excp_helper.c
> index 268a1614597..ecc9e4de8ba 100644
> --- a/target/ppc/tcg-excp_helper.c
> +++ b/target/ppc/tcg-excp_helper.c

... so should be this:

> +void ppc_tcg_hv_emu(CPUPPCState *env, target_ulong *new_msr,
> +                    int *srr0, int *srr1)
> +{
> +    uint32_t insn = ppc_ldl_code(env, env->nip);
> +
> +    env->spr[SPR_HEIR] = insn;
> +    if (is_prefix_insn(env, insn)) {
> +        uint32_t insn2 = ppc_ldl_code(env, env->nip + 4);
> +
> +        env->spr[SPR_HEIR] <<= 32;
> +        env->spr[SPR_HEIR] |= insn2;
> +    }
> +    *srr0 = SPR_HSRR0;
> +    *srr1 = SPR_HSRR1;
> +    *new_msr |= (target_ulong)MSR_HVB;
> +    *new_msr |= env->msr & ((target_ulong)1 << MSR_RI);
> +}
> +
>   #endif /* !CONFIG_USER_ONLY */


