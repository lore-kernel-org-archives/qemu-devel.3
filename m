Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 996F410F9972
	for <qemu-devel@archiver.kernel.org>; Wed,  8 Apr 2026 19:06:40 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wAYDG-0001pL-PC; Wed, 08 Apr 2026 15:05:18 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1wAYCe-0001V5-0O
 for qemu-devel@nongnu.org; Wed, 08 Apr 2026 15:04:41 -0400
Received: from mail-pl1-x634.google.com ([2607:f8b0:4864:20::634])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1wAWzZ-0005JJ-FO
 for qemu-devel@nongnu.org; Wed, 08 Apr 2026 13:47:06 -0400
Received: by mail-pl1-x634.google.com with SMTP id
 d9443c01a7336-2b0c8362d93so3685ad.3
 for <qemu-devel@nongnu.org>; Wed, 08 Apr 2026 10:47:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1775670424; x=1776275224; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
 :to:content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=S+6tFhx4Tr65tUBXxFW21YPAysSNW5/zvmxvgwcSkro=;
 b=ehSDjt4dBvocs0aZ2TI/H0ELmsBivelYvGB1Ck511x1iHvjtJDOuQDlp5v5pCb7K17
 LnSFVN8kkrfM3kzxZJ/umFyT033a08+4fNego6kienTys5GjBHRRVcJVIMZqdy460p+U
 xgawuQwFBHv0/9n7Q68aQ2X873I6Po2Rtj3AkFRB6kY4OLUrV3xF0yZrVh6aswQM47+f
 geQ84D3gowpv09Fvn+nXZ1RWj26icBpz+AhW5bZ6VqOKT2sDOVXjB7jgWrwOVJ5L0EIk
 lBrCurtvugjroqYw5R2jziIXxn1Sj1SC65Bgq5dk1sVbKWE0FTUGW1S505Wx6UozQwZi
 fYrQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1775670424; x=1776275224;
 h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
 :to:content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=S+6tFhx4Tr65tUBXxFW21YPAysSNW5/zvmxvgwcSkro=;
 b=YNwhoV0rHJacWaIDqIPL7dCOEAfa44/6BihpEH1VOz8Ro/+7CP40eRJnwo+ZAs0iDK
 g5K9kRx1E7f6Bnm7biRmupAKEgm0+ZeVXRGWnoBBwMEmcp7a0JMkPMXQUVN7Zooggvun
 47P8Imq6lynLuYwl1az2vYue488BfCQKJ7cBNkpa0oc2otPq0L6DzM4mkeWFOw99ZeB+
 OVY7rH6i6SAHHJJuYjlom9pSiYulj+xVBRt6XiAQhsUx9sMl+NzM40dpmx/tPPmtI3ZG
 MWwJBGG1d18MDq57m3y9IxvzSne5NicREuAQayjwCarBot2k/itfcFaIt+cBszi7zqde
 +75w==
X-Forwarded-Encrypted: i=1;
 AJvYcCVVSS8/zByccR1iLqtkn1wS6Ia5EP0WfY1Z4hMbpvFKYKY0bA6KBvTX32FVnd258XW2nA9lg1nX7PbG@nongnu.org
X-Gm-Message-State: AOJu0YwVYFTI/CJnQxNC7VBJv69R6JKvPpiVQX8FN3XPJyXdy6/gvAJZ
 PLWY6NzGtVYOFEbaS7R2RbMPhA99i5qgG/5/+0BinP8za3uMynU2dUtrPx2HnKw75xI=
X-Gm-Gg: AeBDieu+TuRhDZTTMAuYhO1q/7eoFOfVKnTYBFxvGQzh2bh2ylSC7N5/CXj3R0zfoqN
 JdKqTMcuvFxZkwnOSOCjvTyubBlZlQ3Nlce66ubpfoMfkC3luCd43VtMkHlXFig8jwKyEJOIo8s
 PMfB87bEisJFpL+ul295dBLtCv6zw3scHwWdfb2Q5tH+k62hd24aP+Cy5FhengiBHcWHAMf/aZP
 aivlOhgGX1FSuLBhpu1l9R1/+qCZrGGvQxY5yPzL6I3IlM0oerYK7G3f7G8V4k1Lhx6o/a2T++B
 RcBghClAOauuTppFo8opD/JT0L220sPXrh/+bGFsaVRJ9z3stGhZrcUUbe92TLthhYm4i/pEuyP
 hfsu/ChRvJVA96ASsWi4oP6xGYY5MlOQVFCxIbN07nb95DLDBNPnK8UtqolZyUNBQ9HR/SB9FhP
 bfME2/3vnpF/397hKDwLgKpsz4hjgkqcMBxVxDFbZ3euiinmde3SHRY4cM/onQVxU8JmNWUQ==
X-Received: by 2002:a17:902:e547:b0:2ae:6092:8d93 with SMTP id
 d9443c01a7336-2b2818329f3mr234433765ad.28.1775670423582; 
 Wed, 08 Apr 2026 10:47:03 -0700 (PDT)
Received: from [192.168.1.169] (216-71-219-44.dyn.novuscom.net.
 [216.71.219.44]) by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2b2749794e8sm222775315ad.53.2026.04.08.10.47.02
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 08 Apr 2026 10:47:03 -0700 (PDT)
Message-ID: <f8610c5b-77f7-4f35-9a77-43158d680256@linaro.org>
Date: Wed, 8 Apr 2026 10:47:02 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] linux-user/arm: Improve get_user_code_u32 and usage
Content-Language: en-US
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org
References: <20260408013309.56122-1-richard.henderson@linaro.org>
 <20260408013309.56122-2-richard.henderson@linaro.org>
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
Autocrypt: addr=pierrick.bouvier@linaro.org; keydata=
 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
 ZtfdHNZotF092MIH0IQC3poExQpV/WBYFAI=
In-Reply-To: <20260408013309.56122-2-richard.henderson@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::634;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-pl1-x634.google.com
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

On 4/7/26 6:33 PM, Richard Henderson wrote:
> Force a little-endian load before applying SCTLR.B.
> Handle the BE32 swap correctly in thumb mode.  This
> fixes a bug with its later usage in insn_is_linux_bkpt.
> 
> Handle lock_user failure: in one case by simply falling back
> to the original SIGILL and the other by raising SIGSEGV.
> 
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>   linux-user/arm/cpu_loop.c | 64 ++++++++++++++++++++++++---------------
>   1 file changed, 40 insertions(+), 24 deletions(-)
> 
> diff --git a/linux-user/arm/cpu_loop.c b/linux-user/arm/cpu_loop.c
> index 19874f4c72..419136fdee 100644
> --- a/linux-user/arm/cpu_loop.c
> +++ b/linux-user/arm/cpu_loop.c
> @@ -29,13 +29,34 @@
>   #include "user/page-protection.h"
>   #include "target/arm/syndrome.h"
>   
> -#define get_user_code_u32(x, gaddr, env)                \
> -    ({ abi_long __r = get_user_u32((x), (gaddr));       \
> -        if (!__r && bswap_code(arm_sctlr_b(env))) {     \
> -            (x) = bswap32(x);                           \
> -        }                                               \
> -        __r;                                            \
> -    })
> +static bool get_user_code_u32(uint32_t *ret, uint32_t va, CPUARMState *env)
> +{
> +    uint32_t insn, *hptr;
> +
> +    hptr = lock_user(VERIFY_READ, va, sizeof(uint32_t), 1);
> +    if (!hptr) {
> +        *ret = 0;
> +        return false;
> +    }
> +
> +    /* Load as little-endian by default. */
> +    __get_user_e(insn, hptr, le);
> +    unlock_user(hptr, va, 0);
> +
> +    /*
> +     * Adjust the little-endian load for BE32 as required.
> +     * In thumb mode, bswap both halfwords by bswap of word then
> +     * swapping the halfwords again to restore the original order.
> +     */
> +    if (arm_sctlr_b(env)) {
> +        insn = bswap32(insn);
> +        if (env->thumb) {
> +            insn = hswap32(insn);
> +        }
> +    }
> +    *ret = insn;
> +    return true;
> +}
>   
>   /*
>    * Note that if we need to do data accesses here, they should do a
> @@ -271,7 +292,8 @@ void cpu_loop(CPUARMState *env)
>   {
>       CPUState *cs = env_cpu(env);
>       int trapnr, si_signo, si_code;
> -    unsigned int n, insn;
> +    unsigned int n;
> +    uint32_t insn;
>       abi_ulong ret;
>   
>       for(;;) {
> @@ -284,31 +306,23 @@ void cpu_loop(CPUARMState *env)
>           case EXCP_UDEF:
>           case EXCP_NOCP:
>           case EXCP_INVSTATE:
> -            {
> -                uint32_t opcode;
> -
> -                /* we handle the FPU emulation here, as Linux */
> -                /* we get the opcode */
> -                /* FIXME - what to do if get_user() fails? */
> -                get_user_code_u32(opcode, env->regs[15], env);
> -
> +            /* we handle the FPU emulation here, as Linux */
> +            if (get_user_code_u32(&insn, env->regs[15], env)) {
>                   /*
>                    * The Linux kernel treats some UDF patterns specially
>                    * to use as breakpoints (instead of the architectural
>                    * bkpt insn). These should trigger a SIGTRAP rather
>                    * than SIGILL.
>                    */
> -                if (insn_is_linux_bkpt(opcode, env->thumb)) {
> +                if (insn_is_linux_bkpt(insn, env->thumb)) {
>                       goto excp_debug;
>                   }
>   
> -                if (!env->thumb && emulate_arm_fpa11(env, opcode)) {
> +                if (!env->thumb && emulate_arm_fpa11(env, insn)) {
>                       break;
>                   }
> -
> -                force_sig_fault(TARGET_SIGILL, TARGET_ILL_ILLOPN,
> -                                env->regs[15]);
>               }
> +            force_sig_fault(TARGET_SIGILL, TARGET_ILL_ILLOPN, env->regs[15]);
>               break;
>           case EXCP_SWI:
>               {
> @@ -317,14 +331,12 @@ void cpu_loop(CPUARMState *env)
>                   if (env->thumb) {
>                       /* Thumb is always EABI style with syscall number in r7 */
>                       n = env->regs[7];
> -                } else {
> +                } else if (get_user_code_u32(&insn, env->regs[15] - 4, env)) {
>                       /*
>                        * Equivalent of kernel CONFIG_OABI_COMPAT: read the
>                        * Arm SVC insn to extract the immediate, which is the
>                        * syscall number in OABI.
>                        */
> -                    /* FIXME - what to do if get_user() fails? */
> -                    get_user_code_u32(insn, env->regs[15] - 4, env);
>                       n = insn & 0xffffff;
>                       if (n == 0) {
>                           /* zero immediate: EABI, syscall number in r7 */
> @@ -340,6 +352,10 @@ void cpu_loop(CPUARMState *env)
>                           n ^= ARM_SYSCALL_BASE;
>                           env->eabi = false;
>                       }
> +                } else {
> +                    /* Failed to re-load instruction. */
> +                    force_sig_fault(TARGET_SIGSEGV, 0, env->regs[15] - 4);
> +                    break;
>                   }
>   
>                   if (n > ARM_NR_BASE) {

Tested-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
Reviewed-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>

Regards,
Pierrick

