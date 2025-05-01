Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6531AC369DC
	for <qemu-devel@archiver.kernel.org>; Thu,  1 May 2025 16:31:06 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uAWo3-0003kh-3K; Thu, 01 May 2025 12:30:39 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1uAWo1-0003kL-Py
 for qemu-devel@nongnu.org; Thu, 01 May 2025 12:30:37 -0400
Received: from mail-pg1-x52a.google.com ([2607:f8b0:4864:20::52a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1uAWnz-0004uc-LA
 for qemu-devel@nongnu.org; Thu, 01 May 2025 12:30:37 -0400
Received: by mail-pg1-x52a.google.com with SMTP id
 41be03b00d2f7-b12b984e791so1060038a12.2
 for <qemu-devel@nongnu.org>; Thu, 01 May 2025 09:30:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1746117034; x=1746721834; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=/b9sR/a1jkRMuRGB1+qsGBSWC0mmzSLV2+K1kJwm2vo=;
 b=mtFBx2YJD78tCO94PaaYeT8WULKWG0cSsfK/tY8uVo1RFAvg5mtOTUrvNrGS8PZ8B/
 ePAM8VuALK4fhrFk/D5xKZK6yPjI0NI696+IDbaW/kFCIf4Lz4mRSkOTAKmxfD0vsztC
 DQAWM5nsI1Ph+TAnXsegXw4AYZIuThqGK4V5qWN33mQFExoFDtPDG1FHIHC+vMu8aZl4
 L7uH4NO5BpMp+X14yPH5Ie2PrNVmD4Iu3eg57ndOKQLDgHJYgSl54KcWGkXQMgR9vHma
 bvnS445pWKaY4m1/zdZQma7QPomR7t/6oxqUxo89aFRuB9pjjcbbyicYhGc1IwZWML4m
 5wXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1746117034; x=1746721834;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=/b9sR/a1jkRMuRGB1+qsGBSWC0mmzSLV2+K1kJwm2vo=;
 b=fIswTP348BIUl4baqqbEGtxbrwXHKWIJLdrJ1DJ24b0QwArZRoEaTsa3OWM3LZmy0p
 yxEMxFQku34TLNzCc0DXDJOuP+NmoHC5p4KFQzFSy7nvNueeCQxD7fzp/1gkCo72l2LV
 muM0aZdj/i9RaD5/h5YNew9O7L6Ikihl4cvtqToP2oCY1leiljncgCKwPTtu7bwRHdA2
 PMYq59ittxyqx2OpRmuTUF/2BWtky7lN1GbFn0Ajat4ZXBueOuX3EPFVx4ZIzhgTh/gV
 oF6sZI84sBWf82MTNOq2gvjr7oEKIkcZKfewPfAc0bRTQgZz2+OOuaW/68hN+bEPY2mI
 n30Q==
X-Forwarded-Encrypted: i=1;
 AJvYcCVCYlk4QqfWp2KdQsK2Hq65fLMv1KdfHyRdw5PFGmQ4gzru6km2P9CgdcdIa6zSU8/WtwEVr7C/Phez@nongnu.org
X-Gm-Message-State: AOJu0Yw3spAabDZFkLUpeMOOjktOqQJhsrw+4lZ7luA+VPlOFmxYjucg
 D/hCRkG1KKfdjGJsPTm8DEjgEQ1EVsbwDZJlg73jRGMHlutiLEwq5wgoYp0jbL0=
X-Gm-Gg: ASbGnctiW2BUAxk8+0PD17i6HzxPYEx8Us4ZtKBwzjHMHfZxAKbqhpFd9+uHPG5taL1
 TlFkXtkY28JtSw0D2x32SH6vmMzW48f9a5Kp59YYcei14JaLjXODptOclL2zEtdbpSOuY9KnFHJ
 wBDk2NcCEi9A/w5mgUkD0ZeQPowNWxftRq4LMexd9PxiYlx8gr8IADC6ZU651pFd8L3UyzwprLW
 yLFL2py20Z9Gk4SLHASJt88wwXNeMuTW72pK60ItkWI1qoMC9FsdWDDi9YW4tc9aEqBcfzYSe9J
 WMTbuZD91VuUbJ2a+kgW0xKr9I7J2AtysxddUFElHa+fENSEJxn8joWI50GpISRKaUMbfD5+rmA
 Wxaf+/rc=
X-Google-Smtp-Source: AGHT+IGiCAh52t7LH0a8SvFCCkcE0hYgB+oEHY1fvkQO27qj56jGPcQbgqGDJEMwfRNN4croOPIk3w==
X-Received: by 2002:a17:90b:3d44:b0:2ff:64c3:3bd4 with SMTP id
 98e67ed59e1d1-30a41eeaed1mr4379678a91.31.1746117034107; 
 Thu, 01 May 2025 09:30:34 -0700 (PDT)
Received: from [192.168.0.4] (71-212-47-143.tukw.qwest.net. [71.212.47.143])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-22e0bc7bca9sm8693335ad.180.2025.05.01.09.30.33
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 01 May 2025 09:30:33 -0700 (PDT)
Message-ID: <1844146d-18cd-42c7-a095-6d1b64ad6293@linaro.org>
Date: Thu, 1 May 2025 09:30:32 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 13/33] target/arm/helper: use i64 for
 exception_pc_alignment
To: Pierrick Bouvier <pierrick.bouvier@linaro.org>, qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>, qemu-arm@nongnu.org,
 alex.bennee@linaro.org, Paolo Bonzini <pbonzini@redhat.com>, anjo@rev.ng,
 =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 kvm@vger.kernel.org
References: <20250501062344.2526061-1-pierrick.bouvier@linaro.org>
 <20250501062344.2526061-14-pierrick.bouvier@linaro.org>
Content-Language: en-US
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20250501062344.2526061-14-pierrick.bouvier@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::52a;
 envelope-from=richard.henderson@linaro.org; helo=mail-pg1-x52a.google.com
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

On 4/30/25 23:23, Pierrick Bouvier wrote:
> --- a/target/arm/helper.h
> +++ b/target/arm/helper.h
> @@ -49,7 +49,7 @@ DEF_HELPER_3(exception_with_syndrome, noreturn, env, i32, i32)
>   DEF_HELPER_4(exception_with_syndrome_el, noreturn, env, i32, i32, i32)
>   DEF_HELPER_2(exception_bkpt_insn, noreturn, env, i32)
>   DEF_HELPER_2(exception_swstep, noreturn, env, i32)
> -DEF_HELPER_2(exception_pc_alignment, noreturn, env, tl)
> +DEF_HELPER_2(exception_pc_alignment, noreturn, env, i64)
>   DEF_HELPER_1(setend, void, env)
>   DEF_HELPER_2(wfi, void, env, i32)
>   DEF_HELPER_1(wfe, void, env)
> diff --git a/target/arm/tcg/tlb_helper.c b/target/arm/tcg/tlb_helper.c
> index 8841f039bc6..943b8438fc7 100644
> --- a/target/arm/tcg/tlb_helper.c
> +++ b/target/arm/tcg/tlb_helper.c
> @@ -277,7 +277,7 @@ void arm_cpu_do_unaligned_access(CPUState *cs, vaddr vaddr,
>       arm_deliver_fault(cpu, vaddr, access_type, mmu_idx, &fi);
>   }
>   
> -void helper_exception_pc_alignment(CPUARMState *env, target_ulong pc)
> +void helper_exception_pc_alignment(CPUARMState *env, uint64_t pc)
>   {
>       ARMMMUFaultInfo fi = { .type = ARMFault_Alignment };
>       int target_el = exception_target_el(env);

I think for this and the next patch, it would be worth extending
include/exec/helper-head.h.inc and include/tcg/ to allow vaddr.


r~

