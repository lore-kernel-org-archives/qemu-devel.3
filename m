Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A2EE7D0E6C6
	for <qemu-devel@archiver.kernel.org>; Tue, 25 Nov 2025 11:06:45 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vNqsB-0003Fu-3G; Tue, 25 Nov 2025 06:06:15 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vNqs9-0003CY-0k
 for qemu-devel@nongnu.org; Tue, 25 Nov 2025 06:06:13 -0500
Received: from mail-wm1-x341.google.com ([2a00:1450:4864:20::341])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vNqs5-00032Y-Am
 for qemu-devel@nongnu.org; Tue, 25 Nov 2025 06:06:12 -0500
Received: by mail-wm1-x341.google.com with SMTP id
 5b1f17b1804b1-47775fb6cb4so35176565e9.0
 for <qemu-devel@nongnu.org>; Tue, 25 Nov 2025 03:06:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1764068767; x=1764673567; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=PMbNNdOK3FXcxpjGxNcYFCYsbnL48q8Pe37lhBGmw+U=;
 b=ymYvudhxXHXz0Q+FcCX0cqcQRgqvxycjnXNAgSn4GmYciPshwUaIvV7MEy/W6YCWZ/
 gKJbpToK3qwpASIMnG0o7t6kRZwUIvHIXIMT3yUM12p/2iTVmBJ2h/CoM4dVf/qjFG2r
 bb07SDS8NYDQ9QWeGVoaKU7fqas5l5FIxBhowoQ8syT8HeOpbBmxl6x9+9xt0S8B2mL+
 dswK1kmaY4lwqu2WkXm46jaG3G1Kwxr7w+6GFzgvrlAqbC8LSb9jVsrfFsA+U45kzG7y
 IgnybpJEbiazLOgwrsbmhPfpuMwPAOcneN0PNg7DoSUaXBqjLS5TuZJvTA79pOQDacLq
 Gskg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1764068767; x=1764673567;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=PMbNNdOK3FXcxpjGxNcYFCYsbnL48q8Pe37lhBGmw+U=;
 b=WpKQuZUPmcBkZ89+jFasuY2aw5zAi87KtUH5MBr30Q5yPhUbTl0OwdNaCc6GaXOQJL
 RrND34Lp1lMEOqOW/zwkp6kTrFrWCVPfLQ8erLY9/v0ghBU0A60T+hnojPcm1tzfdfoI
 r9ypNgQy0+hr/bRZ3Sx4QhPFlL/ngjmoC3L0JPEOgOMb7zodokB/dMEU8zxIsTHN8O7H
 9W0F8x3t0NIaAGeqGVtYbtFEjOwGozIfjrSfme9pnxWcHLVNv4eBCR9ZyDZgEngjkalj
 lRVN4HvtDKpMAv94hDYvgNjqO3c2ElduR45N9t6B2FAmAh2f7etiT1SIAedbaLXGZB8b
 xgIg==
X-Gm-Message-State: AOJu0Ywj+brpQ38+mjn51NWeMTTe3k7+yo1NsxQu6Vsgjp50cOkTYzXa
 FD1+yMjxykm9CXc8U6Qgk6+zd4IguTTZ3qopZER3hjkpevT1QlSkUMc/Rc7iPidyOwNHQ1UwXM3
 /Ruk+668xXaGC
X-Gm-Gg: ASbGncuazI2KE8isnTPO4EV5QEpjLj0PflXqTSlGGy8JN4yXcrkJZMYoG7+/STbBtGZ
 bd0paAIrzSsHCevsPFj0+M+/Guo5thvL+72UqTGB04H4RyoFg2B/Pj32+AKGwK2Lpg+LFU+1vwa
 UB1ZrBmcnM52k0GHUzqfP95cGxGlkDFTWJGMw73azb8JwcQLwn+xgbESbuh/Qmg8jrwtZvQP4vW
 UPMJYVGoQreAKQ5cHvP3CjfLTv02vRUQWgg/O0PjbguCfBMSHNSjPrvh+EvZtAZtSqRNtto26ux
 RdP30Ogndx1n0Mh7YcDsBBOYzaPlRsJd4s+RdEbbznc3Cn65JUXORP0zkmg2hnJBaRAw/8XCJfl
 BA6eZtiBGC3lcfIeRPIGio9wSQY5nsGZB6hIlyufK0eMzKDL8CUsi3+2q0FyfnxxPdIGyswStZH
 nL/XbwwSj1l7edbpsXs/MHdQx73IWjMj5Kpsjun5bmwqOEkJ/Q0zUV+Hlabz6FLQMO
X-Google-Smtp-Source: AGHT+IFBKOYmnV5vC3AlQmANQXFWgcikeE/Cikn0yQsch1+6W/1LY+IHzcWiEdQnY5H3Gdyr8NtQhQ==
X-Received: by 2002:a05:600c:c490:b0:477:b734:8c41 with SMTP id
 5b1f17b1804b1-477c10c8596mr148537185e9.1.1764068766963; 
 Tue, 25 Nov 2025 03:06:06 -0800 (PST)
Received: from [192.168.69.210] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-477bf1df392sm248172015e9.1.2025.11.25.03.06.06
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 25 Nov 2025 03:06:06 -0800 (PST)
Message-ID: <040d8ba8-0451-4524-8eae-6458aa127945@linaro.org>
Date: Tue, 25 Nov 2025 12:06:05 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH-for-11.0 04/12] target/m68k: Use little-endian variant of
 cpu_ld/st_data*()
Content-Language: en-US
To: qemu-devel@nongnu.org
Cc: qemu-s390x@nongnu.org, qemu-riscv@nongnu.org,
 Richard Henderson <richard.henderson@linaro.org>,
 Laurent Vivier <laurent@vivier.eu>
References: <20251125105434.92355-1-philmd@linaro.org>
 <20251125105434.92355-5-philmd@linaro.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20251125105434.92355-5-philmd@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::341;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x341.google.com
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

On 25/11/25 11:54, Philippe Mathieu-Daudé wrote:
> We only build the M68k target using little endianness order,
> therefore the cpu_ld/st_data*() definitions expand to the little
> endian declarations. Use the explicit little-endian variants.

Wrong endianness in patch description, code change correct.

> Mechanical change running:
> 
>    $ tgt=m68k; \
>      end=be; \
>      for op in data mmuidx_ra; do \
>        for ac in uw sw l q; do \
>          sed -i -e "s/cpu_ld${ac}_${op}/cpu_ld${ac}_${end}_${op}/" \
>                    $(git grep -l cpu_ target/${tgt}/); \
>        done;
>        for ac in w l q; do \
>          sed -i -e "s/cpu_st${ac}_${op}/cpu_st${ac}_${end}_${op}/" \
>                    $(git grep -l cpu_ target/${tgt}/); \
>        done;
>      done
> 
> Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
> ---
>   target/m68k/fpu_helper.c | 12 +++---
>   target/m68k/op_helper.c  | 88 ++++++++++++++++++++--------------------
>   2 files changed, 50 insertions(+), 50 deletions(-)
> 
> diff --git a/target/m68k/fpu_helper.c b/target/m68k/fpu_helper.c
> index 56012863c85..f49f841d489 100644
> --- a/target/m68k/fpu_helper.c
> +++ b/target/m68k/fpu_helper.c
> @@ -510,8 +510,8 @@ static int cpu_ld_floatx80_ra(CPUM68KState *env, uint32_t addr, FPReg *fp,
>       uint32_t high;
>       uint64_t low;
>   
> -    high = cpu_ldl_data_ra(env, addr, ra);
> -    low = cpu_ldq_data_ra(env, addr + 4, ra);
> +    high = cpu_ldl_be_data_ra(env, addr, ra);
> +    low = cpu_ldq_be_data_ra(env, addr + 4, ra);
>   
>       fp->l.upper = high >> 16;
>       fp->l.lower = low;
> @@ -522,8 +522,8 @@ static int cpu_ld_floatx80_ra(CPUM68KState *env, uint32_t addr, FPReg *fp,
>   static int cpu_st_floatx80_ra(CPUM68KState *env, uint32_t addr, FPReg *fp,
>                                  uintptr_t ra)
>   {
> -    cpu_stl_data_ra(env, addr, fp->l.upper << 16, ra);
> -    cpu_stq_data_ra(env, addr + 4, fp->l.lower, ra);
> +    cpu_stl_be_data_ra(env, addr, fp->l.upper << 16, ra);
> +    cpu_stq_be_data_ra(env, addr + 4, fp->l.lower, ra);
>   
>       return 12;
>   }
> @@ -533,7 +533,7 @@ static int cpu_ld_float64_ra(CPUM68KState *env, uint32_t addr, FPReg *fp,
>   {
>       uint64_t val;
>   
> -    val = cpu_ldq_data_ra(env, addr, ra);
> +    val = cpu_ldq_be_data_ra(env, addr, ra);
>       fp->d = float64_to_floatx80(*(float64 *)&val, &env->fp_status);
>   
>       return 8;
> @@ -545,7 +545,7 @@ static int cpu_st_float64_ra(CPUM68KState *env, uint32_t addr, FPReg *fp,
>       float64 val;
>   
>       val = floatx80_to_float64(fp->d, &env->fp_status);
> -    cpu_stq_data_ra(env, addr, *(uint64_t *)&val, ra);
> +    cpu_stq_be_data_ra(env, addr, *(uint64_t *)&val, ra);
>   
>       return 8;
>   }
> diff --git a/target/m68k/op_helper.c b/target/m68k/op_helper.c
> index e9c20a8e032..eac45669ce7 100644
> --- a/target/m68k/op_helper.c
> +++ b/target/m68k/op_helper.c
> @@ -32,8 +32,8 @@ static void cf_rte(CPUM68KState *env)
>       uint32_t fmt;
>   
>       sp = env->aregs[7];
> -    fmt = cpu_ldl_mmuidx_ra(env, sp, MMU_KERNEL_IDX, 0);
> -    env->pc = cpu_ldl_mmuidx_ra(env, sp + 4, MMU_KERNEL_IDX, 0);
> +    fmt = cpu_ldl_be_mmuidx_ra(env, sp, MMU_KERNEL_IDX, 0);
> +    env->pc = cpu_ldl_be_mmuidx_ra(env, sp + 4, MMU_KERNEL_IDX, 0);
>       sp |= (fmt >> 28) & 3;
>       env->aregs[7] = sp + 8;
>   
> @@ -48,13 +48,13 @@ static void m68k_rte(CPUM68KState *env)
>   
>       sp = env->aregs[7];
>   throwaway:
> -    sr = cpu_lduw_mmuidx_ra(env, sp, MMU_KERNEL_IDX, 0);
> +    sr = cpu_lduw_be_mmuidx_ra(env, sp, MMU_KERNEL_IDX, 0);
>       sp += 2;
> -    env->pc = cpu_ldl_mmuidx_ra(env, sp, MMU_KERNEL_IDX, 0);
> +    env->pc = cpu_ldl_be_mmuidx_ra(env, sp, MMU_KERNEL_IDX, 0);
>       sp += 4;
>       if (m68k_feature(env, M68K_FEATURE_EXCEPTION_FORMAT_VEC)) {
>           /*  all except 68000 */
> -        fmt = cpu_lduw_mmuidx_ra(env, sp, MMU_KERNEL_IDX, 0);
> +        fmt = cpu_lduw_be_mmuidx_ra(env, sp, MMU_KERNEL_IDX, 0);
>           sp += 2;
>           switch (fmt >> 12) {
>           case 0:
> @@ -250,12 +250,12 @@ static void cf_interrupt_all(CPUM68KState *env, int is_hw)
>       /* ??? This could cause MMU faults.  */
>       sp &= ~3;
>       sp -= 4;
> -    cpu_stl_mmuidx_ra(env, sp, retaddr, MMU_KERNEL_IDX, 0);
> +    cpu_stl_be_mmuidx_ra(env, sp, retaddr, MMU_KERNEL_IDX, 0);
>       sp -= 4;
> -    cpu_stl_mmuidx_ra(env, sp, fmt, MMU_KERNEL_IDX, 0);
> +    cpu_stl_be_mmuidx_ra(env, sp, fmt, MMU_KERNEL_IDX, 0);
>       env->aregs[7] = sp;
>       /* Jump to vector.  */
> -    env->pc = cpu_ldl_mmuidx_ra(env, env->vbr + vector, MMU_KERNEL_IDX, 0);
> +    env->pc = cpu_ldl_be_mmuidx_ra(env, env->vbr + vector, MMU_KERNEL_IDX, 0);
>   
>       do_plugin_vcpu_interrupt_cb(cs, retaddr);
>   }
> @@ -270,24 +270,24 @@ static inline void do_stack_frame(CPUM68KState *env, uint32_t *sp,
>           switch (format) {
>           case 4:
>               *sp -= 4;
> -            cpu_stl_mmuidx_ra(env, *sp, env->pc, MMU_KERNEL_IDX, 0);
> +            cpu_stl_be_mmuidx_ra(env, *sp, env->pc, MMU_KERNEL_IDX, 0);
>               *sp -= 4;
> -            cpu_stl_mmuidx_ra(env, *sp, addr, MMU_KERNEL_IDX, 0);
> +            cpu_stl_be_mmuidx_ra(env, *sp, addr, MMU_KERNEL_IDX, 0);
>               break;
>           case 3:
>           case 2:
>               *sp -= 4;
> -            cpu_stl_mmuidx_ra(env, *sp, addr, MMU_KERNEL_IDX, 0);
> +            cpu_stl_be_mmuidx_ra(env, *sp, addr, MMU_KERNEL_IDX, 0);
>               break;
>           }
>           *sp -= 2;
> -        cpu_stw_mmuidx_ra(env, *sp, (format << 12) + (cs->exception_index << 2),
> +        cpu_stw_be_mmuidx_ra(env, *sp, (format << 12) + (cs->exception_index << 2),
>                             MMU_KERNEL_IDX, 0);
>       }
>       *sp -= 4;
> -    cpu_stl_mmuidx_ra(env, *sp, retaddr, MMU_KERNEL_IDX, 0);
> +    cpu_stl_be_mmuidx_ra(env, *sp, retaddr, MMU_KERNEL_IDX, 0);
>       *sp -= 2;
> -    cpu_stw_mmuidx_ra(env, *sp, sr, MMU_KERNEL_IDX, 0);
> +    cpu_stw_be_mmuidx_ra(env, *sp, sr, MMU_KERNEL_IDX, 0);
>   }
>   
>   static void m68k_interrupt_all(CPUM68KState *env, int is_hw)
> @@ -346,49 +346,49 @@ static void m68k_interrupt_all(CPUM68KState *env, int is_hw)
>           env->mmu.fault = true;
>           /* push data 3 */
>           sp -= 4;
> -        cpu_stl_mmuidx_ra(env, sp, 0, MMU_KERNEL_IDX, 0);
> +        cpu_stl_be_mmuidx_ra(env, sp, 0, MMU_KERNEL_IDX, 0);
>           /* push data 2 */
>           sp -= 4;
> -        cpu_stl_mmuidx_ra(env, sp, 0, MMU_KERNEL_IDX, 0);
> +        cpu_stl_be_mmuidx_ra(env, sp, 0, MMU_KERNEL_IDX, 0);
>           /* push data 1 */
>           sp -= 4;
> -        cpu_stl_mmuidx_ra(env, sp, 0, MMU_KERNEL_IDX, 0);
> +        cpu_stl_be_mmuidx_ra(env, sp, 0, MMU_KERNEL_IDX, 0);
>           /* write back 1 / push data 0 */
>           sp -= 4;
> -        cpu_stl_mmuidx_ra(env, sp, 0, MMU_KERNEL_IDX, 0);
> +        cpu_stl_be_mmuidx_ra(env, sp, 0, MMU_KERNEL_IDX, 0);
>           /* write back 1 address */
>           sp -= 4;
> -        cpu_stl_mmuidx_ra(env, sp, 0, MMU_KERNEL_IDX, 0);
> +        cpu_stl_be_mmuidx_ra(env, sp, 0, MMU_KERNEL_IDX, 0);
>           /* write back 2 data */
>           sp -= 4;
> -        cpu_stl_mmuidx_ra(env, sp, 0, MMU_KERNEL_IDX, 0);
> +        cpu_stl_be_mmuidx_ra(env, sp, 0, MMU_KERNEL_IDX, 0);
>           /* write back 2 address */
>           sp -= 4;
> -        cpu_stl_mmuidx_ra(env, sp, 0, MMU_KERNEL_IDX, 0);
> +        cpu_stl_be_mmuidx_ra(env, sp, 0, MMU_KERNEL_IDX, 0);
>           /* write back 3 data */
>           sp -= 4;
> -        cpu_stl_mmuidx_ra(env, sp, 0, MMU_KERNEL_IDX, 0);
> +        cpu_stl_be_mmuidx_ra(env, sp, 0, MMU_KERNEL_IDX, 0);
>           /* write back 3 address */
>           sp -= 4;
> -        cpu_stl_mmuidx_ra(env, sp, env->mmu.ar, MMU_KERNEL_IDX, 0);
> +        cpu_stl_be_mmuidx_ra(env, sp, env->mmu.ar, MMU_KERNEL_IDX, 0);
>           /* fault address */
>           sp -= 4;
> -        cpu_stl_mmuidx_ra(env, sp, env->mmu.ar, MMU_KERNEL_IDX, 0);
> +        cpu_stl_be_mmuidx_ra(env, sp, env->mmu.ar, MMU_KERNEL_IDX, 0);
>           /* write back 1 status */
>           sp -= 2;
> -        cpu_stw_mmuidx_ra(env, sp, 0, MMU_KERNEL_IDX, 0);
> +        cpu_stw_be_mmuidx_ra(env, sp, 0, MMU_KERNEL_IDX, 0);
>           /* write back 2 status */
>           sp -= 2;
> -        cpu_stw_mmuidx_ra(env, sp, 0, MMU_KERNEL_IDX, 0);
> +        cpu_stw_be_mmuidx_ra(env, sp, 0, MMU_KERNEL_IDX, 0);
>           /* write back 3 status */
>           sp -= 2;
> -        cpu_stw_mmuidx_ra(env, sp, 0, MMU_KERNEL_IDX, 0);
> +        cpu_stw_be_mmuidx_ra(env, sp, 0, MMU_KERNEL_IDX, 0);
>           /* special status word */
>           sp -= 2;
> -        cpu_stw_mmuidx_ra(env, sp, env->mmu.ssw, MMU_KERNEL_IDX, 0);
> +        cpu_stw_be_mmuidx_ra(env, sp, env->mmu.ssw, MMU_KERNEL_IDX, 0);
>           /* effective address */
>           sp -= 4;
> -        cpu_stl_mmuidx_ra(env, sp, env->mmu.ar, MMU_KERNEL_IDX, 0);
> +        cpu_stl_be_mmuidx_ra(env, sp, env->mmu.ar, MMU_KERNEL_IDX, 0);
>   
>           do_stack_frame(env, &sp, 7, oldsr, 0, env->pc);
>           env->mmu.fault = false;
> @@ -436,7 +436,7 @@ static void m68k_interrupt_all(CPUM68KState *env, int is_hw)
>   
>       env->aregs[7] = sp;
>       /* Jump to vector.  */
> -    env->pc = cpu_ldl_mmuidx_ra(env, env->vbr + vector, MMU_KERNEL_IDX, 0);
> +    env->pc = cpu_ldl_be_mmuidx_ra(env, env->vbr + vector, MMU_KERNEL_IDX, 0);
>   
>       do_plugin_vcpu_interrupt_cb(cs, last_pc);
>   }
> @@ -784,11 +784,11 @@ void HELPER(cas2w)(CPUM68KState *env, uint32_t regs, uint32_t a1, uint32_t a2)
>       int16_t l1, l2;
>       uintptr_t ra = GETPC();
>   
> -    l1 = cpu_lduw_data_ra(env, a1, ra);
> -    l2 = cpu_lduw_data_ra(env, a2, ra);
> +    l1 = cpu_lduw_be_data_ra(env, a1, ra);
> +    l2 = cpu_lduw_be_data_ra(env, a2, ra);
>       if (l1 == c1 && l2 == c2) {
> -        cpu_stw_data_ra(env, a1, u1, ra);
> -        cpu_stw_data_ra(env, a2, u2, ra);
> +        cpu_stw_be_data_ra(env, a1, u1, ra);
> +        cpu_stw_be_data_ra(env, a2, u2, ra);
>       }
>   
>       if (c1 != l1) {
> @@ -845,11 +845,11 @@ static void do_cas2l(CPUM68KState *env, uint32_t regs, uint32_t a1, uint32_t a2,
>           }
>       } else {
>           /* We're executing in a serial context -- no need to be atomic.  */
> -        l1 = cpu_ldl_data_ra(env, a1, ra);
> -        l2 = cpu_ldl_data_ra(env, a2, ra);
> +        l1 = cpu_ldl_be_data_ra(env, a1, ra);
> +        l2 = cpu_ldl_be_data_ra(env, a2, ra);
>           if (l1 == c1 && l2 == c2) {
> -            cpu_stl_data_ra(env, a1, u1, ra);
> -            cpu_stl_data_ra(env, a2, u2, ra);
> +            cpu_stl_be_data_ra(env, a1, u1, ra);
> +            cpu_stl_be_data_ra(env, a2, u2, ra);
>           }
>       }
>   
> @@ -951,12 +951,12 @@ static uint64_t bf_load(CPUM68KState *env, uint32_t addr, int blen,
>       case 0:
>           return cpu_ldub_data_ra(env, addr, ra);
>       case 1:
> -        return cpu_lduw_data_ra(env, addr, ra);
> +        return cpu_lduw_be_data_ra(env, addr, ra);
>       case 2:
>       case 3:
> -        return cpu_ldl_data_ra(env, addr, ra);
> +        return cpu_ldl_be_data_ra(env, addr, ra);
>       case 4:
> -        return cpu_ldq_data_ra(env, addr, ra);
> +        return cpu_ldq_be_data_ra(env, addr, ra);
>       default:
>           g_assert_not_reached();
>       }
> @@ -970,14 +970,14 @@ static void bf_store(CPUM68KState *env, uint32_t addr, int blen,
>           cpu_stb_data_ra(env, addr, data, ra);
>           break;
>       case 1:
> -        cpu_stw_data_ra(env, addr, data, ra);
> +        cpu_stw_be_data_ra(env, addr, data, ra);
>           break;
>       case 2:
>       case 3:
> -        cpu_stl_data_ra(env, addr, data, ra);
> +        cpu_stl_be_data_ra(env, addr, data, ra);
>           break;
>       case 4:
> -        cpu_stq_data_ra(env, addr, data, ra);
> +        cpu_stq_be_data_ra(env, addr, data, ra);
>           break;
>       default:
>           g_assert_not_reached();


