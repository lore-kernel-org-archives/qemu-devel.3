Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2530AC4345F
	for <qemu-devel@archiver.kernel.org>; Mon, 29 Apr 2024 11:07:21 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s1OqX-0007NX-W9; Mon, 29 Apr 2024 07:06:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1s1OqV-0007IN-Im
 for qemu-devel@nongnu.org; Mon, 29 Apr 2024 07:06:55 -0400
Received: from mail-lf1-x129.google.com ([2a00:1450:4864:20::129])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1s1OqT-0000Mo-6s
 for qemu-devel@nongnu.org; Mon, 29 Apr 2024 07:06:55 -0400
Received: by mail-lf1-x129.google.com with SMTP id
 2adb3069b0e04-518a56cdc03so4722836e87.1
 for <qemu-devel@nongnu.org>; Mon, 29 Apr 2024 04:06:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1714388811; x=1714993611; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:cc:content-language
 :references:to:subject:user-agent:mime-version:date:message-id:from
 :to:cc:subject:date:message-id:reply-to;
 bh=gTQiyHpzybArn7D7Du7MW4rxC4rxoVqHvTItuN7Ziu4=;
 b=uRL5+pmRlUuZ/Lfg6FLUQK6uktTUl/1Eo6okK1FmYfpxUZNHICx2nn45cLwsUaqXKW
 XqZkATBUfjqiqTouJWMxdDVt9ODgAmLGio5dLKwMNj07oCmlXdcQHi0eH/0qRMeFhXeu
 FY/MT7qMwAZbl2Qtl0NfM1oESibkiBUwZR3/uSq2fQWUJw8eN6GVOTN2R/2Wq+NRt6U4
 ERBWKUs4g3UYoNIHzN0FxVy4qGEeZndAURWUQQD0ANHFpKheHx47Chx9ChMfIASgmo3a
 6+sM3RvgR4UgD7yDw9XrOhMKj6g/mC85Unit2Rgl89f1hEkzJPHKyPXsCuik9alSKIuz
 exyg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1714388811; x=1714993611;
 h=content-transfer-encoding:in-reply-to:from:cc:content-language
 :references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=gTQiyHpzybArn7D7Du7MW4rxC4rxoVqHvTItuN7Ziu4=;
 b=S+ar0rIA3Rv5rUKLBa83WsJAyQ+5IG+SsvldcxhHHYhXXQeWA97iX9R+Ykj5wmBMFz
 N0F0L0KIViFRHyXUc40Hn8S1YK1GX/IMQaE/KV7pzzzaQx9c8TMmH4iiaa1MUsbDTsD7
 unVfiwG7wEH2/j0dmjQd5tNN32c3LW0gGr+mcB7HL/VxKdkfGzSIPThWb+W7HOdGCb4i
 3D6FfI502tDcRxU9RQVGvnaIX6EYToLxOSWGxWjo9qqt6ZCUzK9XocHAiXdPvnjDJETy
 yIR4UVs3cDtOu/WBV2OUsu8F4M4OTh18zqst2vjbnMOoox1KZyeYb73zE9hdsZx/lrde
 6Agg==
X-Forwarded-Encrypted: i=1;
 AJvYcCV3n+7u2X78J2qQ/9yIMwts7XcJVbA2llR03aEh7/o3W3iUP/6s2j+OtteOejZuE11oIDp6Zi8FC3L7auK3Z/3jvfNRFxE=
X-Gm-Message-State: AOJu0YwiRUcWehvm9UUMYzNNHEYM6h4hNVp5XXBDl24TL0Ui14Tn9b3f
 NpbqIXcqZzgRjZVEKNAhdcPwb75L1Y+wkzIRuLLGMYwzoXZHIhl5eMynnHibwvg=
X-Google-Smtp-Source: AGHT+IGINJGi6Gvcz3UTHqe6tHnzf1Sm99MqV9bIGDyEjNOOnQ5JaamnXO+SwqCF54ZK9lC2R+OKWQ==
X-Received: by 2002:a05:6512:159e:b0:51d:a687:bf2e with SMTP id
 bp30-20020a056512159e00b0051da687bf2emr2891719lfb.21.1714388811186; 
 Mon, 29 Apr 2024 04:06:51 -0700 (PDT)
Received: from [10.79.37.248] ([83.247.137.20])
 by smtp.gmail.com with ESMTPSA id
 u14-20020a05600c19ce00b0041c23148330sm4890939wmq.10.2024.04.29.04.06.50
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 29 Apr 2024 04:06:50 -0700 (PDT)
Message-ID: <396aa894-0ce8-4843-925f-e426677d67f7@linaro.org>
Date: Mon, 29 Apr 2024 13:06:49 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 09/10] util/bufferiszero: Add simd acceleration for
 aarch64
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
References: <20240424225705.929812-1-richard.henderson@linaro.org>
 <20240424225705.929812-10-richard.henderson@linaro.org>
Content-Language: en-US
Cc: Ard Biesheuvel <ardb@kernel.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20240424225705.929812-10-richard.henderson@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2a00:1450:4864:20::129;
 envelope-from=philmd@linaro.org; helo=mail-lf1-x129.google.com
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

Cc'ing Ard :)

On 25/4/24 00:57, Richard Henderson wrote:
> Because non-embedded aarch64 is expected to have AdvSIMD enabled, merely
> double-check with the compiler flags for __ARM_NEON and don't bother with
> a runtime check.  Otherwise, model the loop after the x86 SSE2 function.
> 
> Use UMAXV for the vector reduction.  This is 3 cycles on cortex-a76 and
> 2 cycles on neoverse-n1.
> 
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>   util/bufferiszero.c | 77 +++++++++++++++++++++++++++++++++++++++++++++
>   1 file changed, 77 insertions(+)
> 
> diff --git a/util/bufferiszero.c b/util/bufferiszero.c
> index ff003dc40e..38477a3eac 100644
> --- a/util/bufferiszero.c
> +++ b/util/bufferiszero.c
> @@ -213,7 +213,84 @@ bool test_buffer_is_zero_next_accel(void)
>       }
>       return false;
>   }
> +
> +#elif defined(__aarch64__) && defined(__ARM_NEON)
> +#include <arm_neon.h>
> +
> +#define REASSOC_BARRIER(vec0, vec1) asm("" : "+w"(vec0), "+w"(vec1))
> +
> +static bool buffer_is_zero_simd(const void *buf, size_t len)
> +{
> +    uint32x4_t t0, t1, t2, t3;
> +
> +    /* Align head/tail to 16-byte boundaries.  */
> +    const uint32x4_t *p = QEMU_ALIGN_PTR_DOWN(buf + 16, 16);
> +    const uint32x4_t *e = QEMU_ALIGN_PTR_DOWN(buf + len - 1, 16);
> +
> +    /* Unaligned loads at head/tail.  */
> +    t0 = vld1q_u32(buf) | vld1q_u32(buf + len - 16);
> +
> +    /* Collect a partial block at tail end.  */
> +    t1 = e[-7] | e[-6];
> +    t2 = e[-5] | e[-4];
> +    t3 = e[-3] | e[-2];
> +    t0 |= e[-1];
> +    REASSOC_BARRIER(t0, t1);
> +    REASSOC_BARRIER(t2, t3);
> +    t0 |= t1;
> +    t2 |= t3;
> +    REASSOC_BARRIER(t0, t2);
> +    t0 |= t2;
> +
> +    /*
> +     * Loop over complete 128-byte blocks.
> +     * With the head and tail removed, e - p >= 14, so the loop
> +     * must iterate at least once.
> +     */
> +    do {
> +        /*
> +         * Reduce via UMAXV.  Whatever the actual result,
> +         * it will only be zero if all input bytes are zero.
> +         */
> +        if (unlikely(vmaxvq_u32(t0) != 0)) {
> +            return false;
> +        }
> +
> +        t0 = p[0] | p[1];
> +        t1 = p[2] | p[3];
> +        t2 = p[4] | p[5];
> +        t3 = p[6] | p[7];
> +        REASSOC_BARRIER(t0, t1);
> +        REASSOC_BARRIER(t2, t3);
> +        t0 |= t1;
> +        t2 |= t3;
> +        REASSOC_BARRIER(t0, t2);
> +        t0 |= t2;
> +        p += 8;
> +    } while (p < e - 7);
> +
> +    return vmaxvq_u32(t0) == 0;
> +}
> +
> +static biz_accel_fn const accel_table[] = {
> +    buffer_is_zero_int_ge256,
> +    buffer_is_zero_simd,
> +};
> +
> +static unsigned accel_index = 1;
> +#define INIT_ACCEL buffer_is_zero_simd
> +
> +bool test_buffer_is_zero_next_accel(void)
> +{
> +    if (accel_index != 0) {
> +        buffer_is_zero_accel = accel_table[--accel_index];
> +        return true;
> +    }
> +    return false;
> +}
> +
>   #else
> +
>   bool test_buffer_is_zero_next_accel(void)
>   {
>       return false;


