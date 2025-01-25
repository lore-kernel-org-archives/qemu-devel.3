Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4783BC0218C
	for <qemu-devel@archiver.kernel.org>; Sat, 25 Jan 2025 17:26:44 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tbjv6-0004FS-UJ; Sat, 25 Jan 2025 12:26:08 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tbjv4-0004FG-Vc
 for qemu-devel@nongnu.org; Sat, 25 Jan 2025 12:26:07 -0500
Received: from mail-pl1-x62b.google.com ([2607:f8b0:4864:20::62b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tbjv0-0004ov-GT
 for qemu-devel@nongnu.org; Sat, 25 Jan 2025 12:26:06 -0500
Received: by mail-pl1-x62b.google.com with SMTP id
 d9443c01a7336-21636268e43so67762415ad.2
 for <qemu-devel@nongnu.org>; Sat, 25 Jan 2025 09:26:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1737825959; x=1738430759; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id:from
 :to:cc:subject:date:message-id:reply-to;
 bh=bQ8K6v9ihP0TEE5KNigwewktQaMLiitA7TK3blt+inA=;
 b=KRmJMXnv9MWWnCq4oAXEUXCmfFRM+KAKaGl7ATZQHmPNfWhrLLGQUWtqsv7B5rkD6j
 /LHwm2L1gQjh7TdR+L9ZjWETY47SjsqNS4xoZ32y7ggclaTsCCeyhO4fm8N+Icn6xXP/
 f48z0r39qDr3rJE5a/2ZljvVou+tyEKHAFUZZ9gfBsRC+eXpHZ9oBJXvlfU64EpI5aU9
 BsuRt7Y//7aycSe5pzB0YmynVkzJLr9uG1MHdfHRdDFKJSFfLVzrGHEYOtWxP0hGPgde
 UhzSppJkeuBMW+lwp3Et/T4dqVYUDKhUtHM9eSRHnYIpdAwAOsdkxEb1P7mK+p2OrzVu
 OELA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1737825959; x=1738430759;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=bQ8K6v9ihP0TEE5KNigwewktQaMLiitA7TK3blt+inA=;
 b=SIaK9n1d+F2w7Mcafu2EdmHIpREYU10j+p3lQxZTlnvkMIoRIiQq94PhCfv7QzSaCE
 Z1g7L2NnIc22w5Cnq19V7Go8KCWmAE+lqXwyqCvzVVbdu59KqCaJzANZ5LNdmEnW3JCN
 mSTG2DYA+szZH11Lj82YH4F2ZHzlDLa0U22XzBQg4Z+vHYRMyu+fYQjxcFSX1N8XYTbb
 xp+0rMRslYfwcyV0bOqawU5JTgq/ox6RDMAyXT9CwnZsiExS/yVgyJaccmupYoqeNasr
 W7P6VMNdzFGNh6PzFY7VDn+XkZR50R2uVOy8V4xOZ+C6SKCSEf01SgiWL0j+T2UP6ZtC
 fxHg==
X-Gm-Message-State: AOJu0YxJ452IKC+HfKbtu+pqqZWK3ma+Eodqkf6w1ZJTTQ8UGLhiz7ud
 ge5WFQIXzrlkxh0dT8sRf93/rZZ2qjZr4RiFtJSjvwi0YCQiXn1ka/Jx7oThqIAQ037G1alqwuE
 u
X-Gm-Gg: ASbGncuVyji18OgQ0p9tZkJT5gruL4/rP8H01wETGOdd0EDEWxRNRgo9XgvYh6bL8px
 afY+CrkWqn3F70uDREZOagBGkYf2gzApCMQ6gMkwEcEwpGxDqvpTTZc9/QuaONBw03PF6W54bT0
 Yehy16fqBk0Oi59woI8JcayFYuu+CCylyWkmKDfqFnVJ9gv9/ZDuThuZs9aXPEgf8NmZ5Ie/OUV
 lvzUOd6t1tRM4uCc8ko9TOdO4/Ex/bOaRNoSabM2jDz79QmuQFDc6LQjW48TDetMv5vsv+UvGvE
 /RwEGa5cpa/8U9OP3kIVQg==
X-Google-Smtp-Source: AGHT+IE3nkECkdGpsvBGjwb0pGJUbCWnXtj1yqJSNXuy4o+VYnXepW45voZ1vJn9QFhMzILb4srcSQ==
X-Received: by 2002:a05:6a20:4d95:b0:1e1:bf32:7d3a with SMTP id
 adf61e73a8af0-1eb215ec4c4mr39711123637.26.1737825958688; 
 Sat, 25 Jan 2025 09:25:58 -0800 (PST)
Received: from [192.168.74.94] ([50.200.230.211])
 by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-ac48f897f8dsm3439095a12.22.2025.01.25.09.25.58
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sat, 25 Jan 2025 09:25:58 -0800 (PST)
Message-ID: <97144c39-9a84-4574-bff5-3a6d3b09b83e@linaro.org>
Date: Sat, 25 Jan 2025 09:25:56 -0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 28/76] target/arm: Implement FPCR.FIZ handling
To: qemu-devel@nongnu.org
References: <20250124162836.2332150-1-peter.maydell@linaro.org>
 <20250124162836.2332150-29-peter.maydell@linaro.org>
Content-Language: en-US
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20250124162836.2332150-29-peter.maydell@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62b;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x62b.google.com
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

On 1/24/25 08:27, Peter Maydell wrote:
> Part of FEAT_AFP is the new control bit FPCR.FIZ.  This bit affects
> flushing of single and double precision denormal inputs to zero for
> AArch64 floating point instructions.  (For half-precision, the
> existing FPCR.FZ16 control remains the only one.)
> 
> FPCR.FIZ differs from FPCR.FZ in that if we flush an input denormal
> only because of FPCR.FIZ then we should *not* set the cumulative
> exception bit FPSR.IDC.
> 
> FEAT_AFP also defines that in AArch64 the existing FPCR.FZ only
> applies when FPCR.AH is 0.
> 
> We can implement this by setting the "flush inputs to zero" state
> appropriately when FPCR is written, and by not reflecting the
> float_flag_input_denormal status flag into FPSR reads when it is the
> result only of FPSR.FIZ.
> 
> Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
> ---
>   target/arm/vfp_helper.c | 58 ++++++++++++++++++++++++++++++++++-------
>   1 file changed, 48 insertions(+), 10 deletions(-)
> 
> diff --git a/target/arm/vfp_helper.c b/target/arm/vfp_helper.c
> index 8c79ab4fc8a..5a0b389f7a3 100644
> --- a/target/arm/vfp_helper.c
> +++ b/target/arm/vfp_helper.c
> @@ -61,19 +61,29 @@ static inline uint32_t vfp_exceptbits_from_host(int host_bits)
>   
>   static uint32_t vfp_get_fpsr_from_host(CPUARMState *env)
>   {
> -    uint32_t i = 0;
> +    uint32_t a32_flags = 0, a64_flags = 0;
>   
> -    i |= get_float_exception_flags(&env->vfp.fp_status_a32);
> -    i |= get_float_exception_flags(&env->vfp.fp_status_a64);
> -    i |= get_float_exception_flags(&env->vfp.standard_fp_status);
> +    a32_flags |= get_float_exception_flags(&env->vfp.fp_status_a32);
> +    a32_flags |= get_float_exception_flags(&env->vfp.standard_fp_status);
>       /* FZ16 does not generate an input denormal exception.  */
> -    i |= (get_float_exception_flags(&env->vfp.fp_status_f16_a32)
> +    a32_flags |= (get_float_exception_flags(&env->vfp.fp_status_f16_a32)
>             & ~float_flag_input_denormal_flushed);
> -    i |= (get_float_exception_flags(&env->vfp.fp_status_f16_a64)
> +    a32_flags |= (get_float_exception_flags(&env->vfp.standard_fp_status_f16)
>             & ~float_flag_input_denormal_flushed);
> -    i |= (get_float_exception_flags(&env->vfp.standard_fp_status_f16)
> +
> +    a64_flags |= get_float_exception_flags(&env->vfp.fp_status_a64);
> +    a64_flags |= (get_float_exception_flags(&env->vfp.fp_status_f16_a64)
>             & ~float_flag_input_denormal_flushed);
> -    return vfp_exceptbits_from_host(i);
> +    /*
> +     * Flushing an input denormal only because FPCR.FIZ == 1 does
> +     * not set FPSR.IDC. So squash it unless (FPCR.AH == 0 && FPCR.FZ == 1).
> +     * We only do this for the a64 flags because FIZ has no effect
> +     * on AArch32 even if it is set.
> +     */
> +    if ((env->vfp.fpcr & (FPCR_FZ | FPCR_AH)) != FPCR_FZ) {
> +        a64_flags &= ~float_flag_input_denormal_flushed;
> +    }

It might be worth pointing to FPUnpackBase pseudocode to say if both FZ and FIZ set, FZ 
takes precedence for setting IDC.

Anyway,
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>


r~

