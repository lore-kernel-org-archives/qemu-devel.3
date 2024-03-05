Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3087DC54798
	for <qemu-devel@archiver.kernel.org>; Tue,  5 Mar 2024 09:19:46 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rhQxT-0005xV-NK; Tue, 05 Mar 2024 04:19:35 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rhQxR-0005w0-Lj
 for qemu-devel@nongnu.org; Tue, 05 Mar 2024 04:19:33 -0500
Received: from mail-wr1-x42e.google.com ([2a00:1450:4864:20::42e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rhQxD-0007W9-Ji
 for qemu-devel@nongnu.org; Tue, 05 Mar 2024 04:19:33 -0500
Received: by mail-wr1-x42e.google.com with SMTP id
 ffacd0b85a97d-33e17342ea7so2825242f8f.2
 for <qemu-devel@nongnu.org>; Tue, 05 Mar 2024 01:19:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1709630358; x=1710235158; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=SBGWjvKzxGlK6swN0imY7LpdB8TE7rSqLvXeRQtd6rQ=;
 b=ZgJIMtGEEx0tTFDmi33rMxVJkEZS0JuZ7pOaKTCN9rAA8zck/wpBiezRQusiP9igdB
 VawHEbE1QDJUDTogFs0jFVRHdm5ZHI1dc1ZsN+CnkGi1xQusNukcNRY+lCjTLvAwfP2o
 fhFovAzXDVuZnaiNN+znyNY4aitqx4B0v/aMmV6bAfPVz+r4j6t3CIdsEktrkfTLZY1H
 1uGPTNeNxB7+06fTAChdtQsXBwAjuxOOu4DGwvoDmsZnCjau5n3Zsc/SzQAIR+hcxi1s
 jUppS4EivdtxREjaAyjer7XMhUfaS9YGd6aioF13qHrF/ZGJnHg9w3M7JNgbn2HXysqX
 yIZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1709630358; x=1710235158;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=SBGWjvKzxGlK6swN0imY7LpdB8TE7rSqLvXeRQtd6rQ=;
 b=RHF5H6MSClxpUFp98c1FRfFIhAA/DTJzzrbyN246G5bvsdpBy2Bd8JJ526t9vO7wRk
 3VJR93ZZGfZ8DUOUFyo9iQ1fG5KYVDDr71LSjoqf51jLqR3hS6OXbuJqSX4DB14KQ13Z
 vvtdYhgy4u8H5QyY0xecWjZNyYKZ/SJfksPOPR3jtLaBu355eSTq9wjqMg4iFc0VyruE
 Ce4XDJnX/16CAPWDCEUrhg8plm3V9BHD5hh6ujhkyp3BLNI7hqjMZh3ankI8M0a/jQOK
 DpNHz05+ZRVWjage2YDpnErW/zJaK9lYEN+u1eqvYsS2ky1cvQcSI0iF8OJf57VkS/FQ
 ADAg==
X-Forwarded-Encrypted: i=1;
 AJvYcCVs2yTwZzZRn7GjQxRUjDwTAG5EAR32t5jrLSkEwktUWVRReAE3oYzkY+pLsFffjFaJ92r/zgh83SFXBApIEQyOmegHpww=
X-Gm-Message-State: AOJu0YyvmvWyTfBVk449QF6nC/eSGST0j8rXKrPKx4qrIWPWFO27IOxv
 ER04Lt5GqVmrpmhI56az0kGyUwgKRFXb90uH+RdDO0LJlnAIN5EazLV2FQqQgCI=
X-Google-Smtp-Source: AGHT+IFtlOlk+gLm3DfmH9tpfj3LCoumED0VBX8D5kJ54SOUFzinWWmA2DeqpYkIxby0mYz10Ad2Zw==
X-Received: by 2002:adf:9d93:0:b0:33e:17fd:5f25 with SMTP id
 p19-20020adf9d93000000b0033e17fd5f25mr8627195wre.2.1709630357791; 
 Tue, 05 Mar 2024 01:19:17 -0800 (PST)
Received: from [192.168.69.100] ([176.176.177.70])
 by smtp.gmail.com with ESMTPSA id
 q13-20020adfcb8d000000b0033ce06c303csm14337479wrh.40.2024.03.05.01.19.16
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 05 Mar 2024 01:19:17 -0800 (PST)
Message-ID: <fa8f1d52-f88d-4107-abfa-fa10ebef511c@linaro.org>
Date: Tue, 5 Mar 2024 10:19:15 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] target/arm: Fix 32-bit SMOPA
Content-Language: en-US
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org, qemu-stable@nongnu.org
References: <20240305023116.234256-1-richard.henderson@linaro.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20240305023116.234256-1-richard.henderson@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42e;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x42e.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=unavailable autolearn_force=no
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

Hi Richard,

On 5/3/24 03:31, Richard Henderson wrote:
> The while the 8-bit input elements are sequential in the input vector,
> the 32-bit output elements are not sequential in the output matrix.
> Do not attempt to compute 2 32-bit outputs at the same time.
> 
> Cc: qemu-stable@nongnu.org
> Fixes: 23a5e3859f5 ("target/arm: Implement SME integer outer product")
> Resolves: https://gitlab.com/qemu-project/qemu/-/issues/2083
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>   target/arm/tcg/sme_helper.c       | 77 ++++++++++++++++++-------------
>   tests/tcg/aarch64/sme-smopa-1.c   | 47 +++++++++++++++++++
>   tests/tcg/aarch64/sme-smopa-2.c   | 54 ++++++++++++++++++++++
>   tests/tcg/aarch64/Makefile.target |  2 +-
>   4 files changed, 147 insertions(+), 33 deletions(-)
>   create mode 100644 tests/tcg/aarch64/sme-smopa-1.c
>   create mode 100644 tests/tcg/aarch64/sme-smopa-2.c
> 
> diff --git a/target/arm/tcg/sme_helper.c b/target/arm/tcg/sme_helper.c
> index 904bfdac43..ef39eee48d 100644
> --- a/target/arm/tcg/sme_helper.c
> +++ b/target/arm/tcg/sme_helper.c
> @@ -1083,11 +1083,32 @@ void HELPER(sme_bfmopa)(void *vza, void *vzn, void *vzm, void *vpn,
>       }
>   }
>   
> -typedef uint64_t IMOPFn(uint64_t, uint64_t, uint64_t, uint8_t, bool);
> +typedef uint32_t IMOPFn32(uint32_t, uint32_t, uint32_t, uint8_t, bool);
> +static inline void do_imopa_s(uint32_t *za, uint32_t *zn, uint32_t *zm,
> +                              uint8_t *pn, uint8_t *pm,
> +                              uint32_t desc, IMOPFn32 *fn)
> +{
> +    intptr_t row, col, oprsz = simd_oprsz(desc) / 4;
> +    bool neg = simd_data(desc);
>   
> -static inline void do_imopa(uint64_t *za, uint64_t *zn, uint64_t *zm,
> -                            uint8_t *pn, uint8_t *pm,
> -                            uint32_t desc, IMOPFn *fn)
> +    for (row = 0; row < oprsz; ++row) {
> +        uint8_t pa = pn[H1(row >> 1)] >> ((row & 1) * 4);
> +        uint32_t *za_row = &za[H4(tile_vslice_index(row))];
> +        uint32_t n = zn[H4(row)];
> +
> +        for (col = 0; col < oprsz; ++col) {
> +            uint8_t pb = pm[H1(col >> 1)] >> ((col & 1) * 4);
> +            uint32_t *a = &za_row[col];

Shouldn't this be:

               uint32_t *a = &za_row[H4(col)];

to work on big endian hosts?

> +
> +            *a = fn(n, zm[H4(col)], *a, pa & pb & 0xf, neg);
> +        }
> +    }
> +}
> +
> +typedef uint64_t IMOPFn64(uint64_t, uint64_t, uint64_t, uint8_t, bool);
> +static inline void do_imopa_d(uint64_t *za, uint64_t *zn, uint64_t *zm,
> +                              uint8_t *pn, uint8_t *pm,
> +                              uint32_t desc, IMOPFn64 *fn)
>   {
>       intptr_t row, col, oprsz = simd_oprsz(desc) / 8;
>       bool neg = simd_data(desc);
> @@ -1107,25 +1128,16 @@ static inline void do_imopa(uint64_t *za, uint64_t *zn, uint64_t *zm,
>   }
>   
>   #define DEF_IMOP_32(NAME, NTYPE, MTYPE) \
> -static uint64_t NAME(uint64_t n, uint64_t m, uint64_t a, uint8_t p, bool neg) \
> +static uint32_t NAME(uint32_t n, uint32_t m, uint32_t a, uint8_t p, bool neg) \
>   {                                                                           \
> -    uint32_t sum0 = 0, sum1 = 0;                                            \
> +    uint32_t sum = 0;                                                       \
>       /* Apply P to N as a mask, making the inactive elements 0. */           \
>       n &= expand_pred_b(p);                                                  \
> -    sum0 += (NTYPE)(n >> 0) * (MTYPE)(m >> 0);                              \
> -    sum0 += (NTYPE)(n >> 8) * (MTYPE)(m >> 8);                              \
> -    sum0 += (NTYPE)(n >> 16) * (MTYPE)(m >> 16);                            \
> -    sum0 += (NTYPE)(n >> 24) * (MTYPE)(m >> 24);                            \
> -    sum1 += (NTYPE)(n >> 32) * (MTYPE)(m >> 32);                            \
> -    sum1 += (NTYPE)(n >> 40) * (MTYPE)(m >> 40);                            \
> -    sum1 += (NTYPE)(n >> 48) * (MTYPE)(m >> 48);                            \
> -    sum1 += (NTYPE)(n >> 56) * (MTYPE)(m >> 56);                            \
> -    if (neg) {                                                              \
> -        sum0 = (uint32_t)a - sum0, sum1 = (uint32_t)(a >> 32) - sum1;       \
> -    } else {                                                                \
> -        sum0 = (uint32_t)a + sum0, sum1 = (uint32_t)(a >> 32) + sum1;       \
> -    }                                                                       \
> -    return ((uint64_t)sum1 << 32) | sum0;                                   \
> +    sum += (NTYPE)(n >> 0) * (MTYPE)(m >> 0);                               \
> +    sum += (NTYPE)(n >> 8) * (MTYPE)(m >> 8);                               \
> +    sum += (NTYPE)(n >> 16) * (MTYPE)(m >> 16);                             \
> +    sum += (NTYPE)(n >> 24) * (MTYPE)(m >> 24);                             \
> +    return neg ? a - sum : a + sum;                                         \
>   }


