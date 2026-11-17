Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5AA48606A32A
	for <qemu-devel@archiver.kernel.org>; Tue, 17 Nov 2026 19:37:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256 header.s=google header.b=zJonulMd
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xTOzg-0008HF-D5; Tue, 17 Nov 2026 14:37:28 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1xTOze-0008H0-I3
 for qemu-devel@nongnu.org; Tue, 17 Nov 2026 14:37:26 -0500
Received: from mail-pf1-x42a.google.com ([2607:f8b0:4864:20::42a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1xTOzc-0001XH-Ib
 for qemu-devel@nongnu.org; Tue, 17 Nov 2026 14:37:26 -0500
Received: by mail-pf1-x42a.google.com with SMTP id
 d2e1a72fcca58-8b6b22be970so77792b3a.1
 for <qemu-devel@nongnu.org>; Tue, 17 Nov 2026 11:37:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1794944242; x=1795549042; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=YbwgfZuDq0tduzENs2CkoJUhwONbtstWRpctZ3epdgs=;
 b=zJonulMdIEMXcnnWaIBYOB3TWsNBQ7XzrmMHf5JHaHFlH/R9+1cHsjHW5Cgfs0Hzpq
 TcpgsB3PBLXE4cuNxLvdY4g8Q6y/XufTyJ69j2LI7ZDb9zSxRRQP2kVL0xD2jXqYDJlS
 D+NZB87aJUYDy0l8nYL9rk/pXqAT4hWcQGjDeF+4HuWBXSz+tL+83qLmKdu3tRGpuyPw
 Z+Kl/XY7mBwTYABtfl/2DRCIhxoBRSjmeFYZ1anXby6dxD6nz32hroj9oAj7JWQoY6ey
 EhguW6eK4nZ0X1a8DnGhetgwccrYVdf8L3GKDEVy/t7bRS5s7Ndq7kHQytUxarBVSo8b
 lX2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1794944242; x=1795549042;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=YbwgfZuDq0tduzENs2CkoJUhwONbtstWRpctZ3epdgs=;
 b=MXYRqhAoA6lwb1RLWCAetGJ5tuL0dpJ+hEt81g/jVrH1Vo+qwQ1hJT6qetoEFJ9794
 D20G8ttu5kTTRQ8AHK3YjgPF0GVLOQXrM/9pKPdcUqrPlP3tGUlAuWboitndlgnlio0H
 8dJ7HfTImRQ7Yf0AiyaJ55gfubYeXe0Ltvc8d8XvvJ7fTV3dUtvP3kLGSE3JfvmrEwAt
 BBAe+AK7P6dNaEU78LXSvS3ihD4JNjQ9/EiIHUHdIUULX0Rht8RzpnzR3sawSpDkcsY2
 11lgB7em1l7XNRqmyxTGSFmTwySX2WJHRISvgxDz+d1mH/zeqX4JFm+SYzqD9muKIrxD
 z+vA==
X-Forwarded-Encrypted: i=1;
 AL+hErGkdQhaPOOTPLU1Qr1agHHFTErWuOwuchBmis6kbQhsAwgzfwTMg29GDmmMR8jnWOow4IDz9DmDmlxE@nongnu.org
X-Gm-Message-State: APuU4Z+t/9h1ZLmWxqa7CYzMW5tqTeUGn7f+6pKiW5uXu6dzutS1OF07
 XBY+ZGB+js7YcVTlgviQN+1A5tONHYhz7/e2FQl9SIhVOlB5EMU9EWA74lBng2PkUIE=
X-Gm-Gg: AZFdTZdFlzqOGxWpOHe5xUJDuCZKHRHaOgI9f8zp0ls8vNkhE2yIVBYKuze/jYdqRoh
 qdXU5sCIIGO8W61qyEgyThxrXJm0LRER63TQ2FD9Y2zWNWUk8ZK3GKGJ04p5RofIzucwlXXGuIb
 tMP8xnap87Ay9QlWtOkTY6hGYDVApdhcnnB6KJMDUZYBN5SXT/uuU34h73QtamoQsAvGQHS5z3H
 3Y0wMNKDkMO8JCYvRr/FoMJmTKSQ6G2LYcKikuGF64rIHpqC2RTPJ6K8T5z7P1s+VKUWiG89XgC
 qcJwT/avdaMOTx20ZT4eDbyPI+/OASSYLK9YdLVIW7rnix6NkIcEGkrrdO3ZQOnWM5M3IyJ+uiG
 +MRcXnKdGRVVBSJUHgKELTuqDjdRQTH7wmUmqYsTPDwEd8PcdQv/PmNszaqbs8qo5wzCbr7HxX6
 cW+pmMQSPFU1NzvqXD/pswmBvUrrxM1IPM6SF2EODiAQOisRvPU5W3TcWxAG5yHqNvIynXBenYV
 jK2M/hY8UVjKQcAUA3H5soZIaVk3OZkp4jBvDMG9xFZbIjtLFzEh5fERku8We+OhHeu31JMc8Mo
 fLXnEwPIgJqm06HHQEIRRtDec0WP2SyyIOYAvUD9j02MRzn8puVTRUL5kfVZoX5HpgPV3us=
X-Received: by 2002:a17:90b:3f0b:b0:3b1:2d60:66cc with SMTP id
 98e67ed59e1d1-3b3d06412f4mr430355a91.8.1794944242377; 
 Tue, 17 Nov 2026 11:37:22 -0800 (PST)
Received: from [192.168.0.4] (174-21-68-150.tukw.qwest.net. [174.21.68.150])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-3b3d1c03df9sm360780a91.16.2026.11.17.11.37.21
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 17 Nov 2026 11:37:22 -0800 (PST)
Message-ID: <3d021b3f-fdd0-4c83-8b3c-3924a5cb42d8@linaro.org>
Date: Tue, 17 Nov 2026 11:37:20 -0800
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 19/19] target/mips: Do not negate NaN results in NMADD.fmt
 and NMSUB.fmt
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>,
 qemu-devel@nongnu.org
Cc: Jiaxun Yang <jiaxun.yang@flygoat.com>,
 Vince Del Vecchio <Vince.DelVecchio@mediatek.com>,
 Faraz Shahbazker <faraz.shahbazker@mediatek.com>,
 Aurelien Jarno <aurelien@aurel32.net>,
 Milica Lazarevic <Milica.Lazarevic@Syrmia.com>,
 James Hilliard <james.hilliard1@gmail.com>,
 Aleksandar Rikalo <arikalo@gmail.com>
References: <20261113161158.25811-1-philmd@oss.qualcomm.com>
 <20261113161158.25811-20-philmd@oss.qualcomm.com>
From: Richard Henderson <richard.henderson@linaro.org>
Content-Language: en-US
In-Reply-To: <20261113161158.25811-20-philmd@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::42a;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x42a.google.com
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
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
X-Spam-Status: No, score=-17.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On 11/13/26 08:11, Philippe Mathieu-Daudé wrote:
> The final negation of NMADD.fmt and NMSUB.fmt is arithmetic. With the
> legacy NaN encoding (FCSR.NAN2008 = 0) QEMU returns the default NaN
> (0x7ff7ffffffffffff for double precision, positive) for a NaN result,
> then flipped its sign with float{32,64}_chs().
> 
> Observed on a Cavium Octeon III V0.2 (FPU V0.0, Linux 4.9.79) running
> risu: "nmsub.d $f7,$f27,$f23,$f15" with $f27 = 0x7fffffffffffffff (a
> signaling NaN in the legacy encoding), $f23 = 0 and
> $f15 = 0x472fa6f57f408dcc gives 0x7ff7ffffffffffff on the hardware,
> where QEMU gave 0xfff7ffffffffffff. The same was seen for the single
> precision "nmsub.s $f1,$f18,$f22,$f21".
> 
> Do not change the sign of a NaN result when NAN2008 is 0. Non-NaN
> results and the NAN2008 = 1 behavior are unchanged. NMADD.fmt, which
> shares the code, was not exercised on the hardware.
> 
> The hardware (or its kernel FPU emulator) also returns a different NaN
> than QEMU for "mul.d" with a signaling NaN operand and a denormal
> operand: this is not addressed here.
> 
> Signed-off-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>
> ---
>   target/mips/tcg/fpu_helper.c | 39 ++++++++++++++++++++++++++++--------
>   1 file changed, 31 insertions(+), 8 deletions(-)

Isn't the larger problem that this should be using a fused multiply-add 
via float64_muladd, and thus the negation via float_muladd_negate_result 
(which will not affect NaN results).

Certainly MD00087 says the product uses infinite precision.


r~

> 
> diff --git a/target/mips/tcg/fpu_helper.c b/target/mips/tcg/fpu_helper.c
> index d6595da6482f..e085aa5669f0 100644
> --- a/target/mips/tcg/fpu_helper.c
> +++ b/target/mips/tcg/fpu_helper.c
> @@ -1627,12 +1627,35 @@ uint64_t HELPER(float_msub_ps)(CPUMIPSState *env, uint64_t fdt0,
>       return ((uint64_t)fsth0 << 32) | fstl0;
>   }
>   
> +/*
> + * The final negation of NMADD.fmt and NMSUB.fmt is arithmetic: with the
> + * legacy NaN encoding (FCSR.NAN2008 = 0) the sign of a NaN result is not
> + * changed.
> + */
> +static inline float64 nm_negate_d(CPUMIPSState *env, float64 a)
> +{
> +    if (!(env->active_fpu.fcr31 & (1 << FCR31_NAN2008)) &&
> +        float64_is_any_nan(a)) {
> +        return a;
> +    }
> +    return float64_chs(a);
> +}
> +
> +static inline float32 nm_negate_s(CPUMIPSState *env, float32 a)
> +{
> +    if (!(env->active_fpu.fcr31 & (1 << FCR31_NAN2008)) &&
> +        float32_is_any_nan(a)) {
> +        return a;
> +    }
> +    return float32_chs(a);
> +}
> +
>   uint64_t HELPER(float_nmadd_d)(CPUMIPSState *env, uint64_t fst0,
>                                uint64_t fst1, uint64_t fst2)
>   {
>       fst0 = float64_mul(fst0, fst1, &env->active_fpu.fp_status);
>       fst0 = float64_add(fst0, fst2, &env->active_fpu.fp_status);
> -    fst0 = float64_chs(fst0);
> +    fst0 = nm_negate_d(env, fst0);
>   
>       update_fcr31(env, GETPC());
>       return fst0;
> @@ -1643,7 +1666,7 @@ uint32_t HELPER(float_nmadd_s)(CPUMIPSState *env, uint32_t fst0,
>   {
>       fst0 = float32_mul(fst0, fst1, &env->active_fpu.fp_status);
>       fst0 = float32_add(fst0, fst2, &env->active_fpu.fp_status);
> -    fst0 = float32_chs(fst0);
> +    fst0 = nm_negate_s(env, fst0);
>   
>       update_fcr31(env, GETPC());
>       return fst0;
> @@ -1661,10 +1684,10 @@ uint64_t HELPER(float_nmadd_ps)(CPUMIPSState *env, uint64_t fdt0,
>   
>       fstl0 = float32_mul(fstl0, fstl1, &env->active_fpu.fp_status);
>       fstl0 = float32_add(fstl0, fstl2, &env->active_fpu.fp_status);
> -    fstl0 = float32_chs(fstl0);
> +    fstl0 = nm_negate_s(env, fstl0);
>       fsth0 = float32_mul(fsth0, fsth1, &env->active_fpu.fp_status);
>       fsth0 = float32_add(fsth0, fsth2, &env->active_fpu.fp_status);
> -    fsth0 = float32_chs(fsth0);
> +    fsth0 = nm_negate_s(env, fsth0);
>   
>       update_fcr31(env, GETPC());
>       return ((uint64_t)fsth0 << 32) | fstl0;
> @@ -1675,7 +1698,7 @@ uint64_t HELPER(float_nmsub_d)(CPUMIPSState *env, uint64_t fst0,
>   {
>       fst0 = float64_mul(fst0, fst1, &env->active_fpu.fp_status);
>       fst0 = float64_sub(fst0, fst2, &env->active_fpu.fp_status);
> -    fst0 = float64_chs(fst0);
> +    fst0 = nm_negate_d(env, fst0);
>   
>       update_fcr31(env, GETPC());
>       return fst0;
> @@ -1686,7 +1709,7 @@ uint32_t HELPER(float_nmsub_s)(CPUMIPSState *env, uint32_t fst0,
>   {
>       fst0 = float32_mul(fst0, fst1, &env->active_fpu.fp_status);
>       fst0 = float32_sub(fst0, fst2, &env->active_fpu.fp_status);
> -    fst0 = float32_chs(fst0);
> +    fst0 = nm_negate_s(env, fst0);
>   
>       update_fcr31(env, GETPC());
>       return fst0;
> @@ -1704,10 +1727,10 @@ uint64_t HELPER(float_nmsub_ps)(CPUMIPSState *env, uint64_t fdt0,
>   
>       fstl0 = float32_mul(fstl0, fstl1, &env->active_fpu.fp_status);
>       fstl0 = float32_sub(fstl0, fstl2, &env->active_fpu.fp_status);
> -    fstl0 = float32_chs(fstl0);
> +    fstl0 = nm_negate_s(env, fstl0);
>       fsth0 = float32_mul(fsth0, fsth1, &env->active_fpu.fp_status);
>       fsth0 = float32_sub(fsth0, fsth2, &env->active_fpu.fp_status);
> -    fsth0 = float32_chs(fsth0);
> +    fsth0 = nm_negate_s(env, fsth0);
>   
>       update_fcr31(env, GETPC());
>       return ((uint64_t)fsth0 << 32) | fstl0;


