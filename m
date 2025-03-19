Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8D58CC282EC
	for <qemu-devel@archiver.kernel.org>; Wed, 19 Mar 2025 00:15:42 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tuh5R-0004I6-B1; Tue, 18 Mar 2025 20:15:09 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1tuh5O-0004Fo-TL
 for qemu-devel@nongnu.org; Tue, 18 Mar 2025 20:15:06 -0400
Received: from mail-pl1-x62c.google.com ([2607:f8b0:4864:20::62c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1tuh5M-0005HB-UF
 for qemu-devel@nongnu.org; Tue, 18 Mar 2025 20:15:06 -0400
Received: by mail-pl1-x62c.google.com with SMTP id
 d9443c01a7336-223f4c06e9fso2689065ad.1
 for <qemu-devel@nongnu.org>; Tue, 18 Mar 2025 17:15:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1742343303; x=1742948103; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=JlbDiJc7Dz5I1s5d6+G1xzjjunSiftPM5Z9tmf4shjw=;
 b=lMFsXOzOE7kmDxJem6z5tsUHuD0KSnd7+M0Sw80S9q3r0fk3OQ55DTMJJHrSC9URnH
 selySJl8XjcOy+DvZMliFkN6o8mV55JvPE/15clr2bmlIQvOgOD6zTziiB9xbvO8MrCn
 IL6EtUp/mJbIjJym1BYU87G3uDLt3JND9QjEMZPa1V14Hvms2A2z7us+Ty7pmf66tQNH
 jlNTMDf0bAE9+jVt75aS1zmWopYmkmS/MuvnkSHlE3TRiqsO1eaGa8cFSu6J6NZ4wcBe
 yqaQrbLdJkqIOfLLKKQbQj4fkn1j9ExtdjfxPkRXOPOdhG0qWzWgavNawpyAsfTvjpef
 AUMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1742343303; x=1742948103;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=JlbDiJc7Dz5I1s5d6+G1xzjjunSiftPM5Z9tmf4shjw=;
 b=JuDaiLvrF0ISjn2DqXWqDL6U9Y+mO4q4rpBEdQ1XJ6h26r+Nk172obVA5o1eWAwdjE
 J0F0QOyin/MZLtPOvqpmJBM4VQPjOKcgohNUyAHMWs9iYViEF45O7PXh9kusv3Vj7Syv
 7GKghFKQKzS3cb/MONhJfvcX+qzQKY/91TBXBaJsl58F23UBFG5I6AOnqHzwZLAfuJul
 sM3LmvtP8mmw+3XpK42NvnTvic6FJ+NeM6PmZSOmqufsmtxIOZvtDrqb/t3hTGTnRmky
 VW5xaOg/6yfyx6+l5vh8hQ20bXSLhFSfvQ2GcFSQYf0FZRcIU13/GiZYaCTloCluXB8n
 SQzw==
X-Forwarded-Encrypted: i=1;
 AJvYcCW+mCYzNy6wECaa4huomPlbRfhqSp10AvSB7AO+YfHiyC8U+UH2aTwOoWNXtWdsIvEPqHzzvUc55Spu@nongnu.org
X-Gm-Message-State: AOJu0YxFUn9pdYGmq2fOSGIgSPNaImYEJuUAeqVnh0QkqJnrzuse+/+4
 LcUJM3QHsHFJeVG8Uc+9FXeJZAZesj/t9BoZmvcZPReb0EZhLsjbxVv5zPq8sm1a3so/kOsZGjp
 B
X-Gm-Gg: ASbGnctUiY77vDIFB3U7Z5Vwsc5w6qIovrhCokX3Y2Nc5Dw8jECbHZoMLLJHx05/sa6
 3UOy4v6T2kVRY8ZjPMMCXSLFT0MQtoJTh1oCZB9wTW7jXfEcRpIzauIp4Bnb8SLpJLd0LzI6R4Z
 B433X7s68pA9grOJYN9tPsX5Gr/xNkfwg3iO6/auHHbW6MuiOmyTu09aRhDzJf1DuYWCn2Y3Bsp
 ADV9nAIRvxEGHZBd/6rTmTo6oSWEwGhWdgXosEBqDRO+F8Ca+HRRQ6Y29cuCxAHojXo+hzZXzHx
 jBri7i0XY5dMPj2MzAU76+py4gLMLqboR/SA5s1451kMQ3rFgWxxp+/I9g==
X-Google-Smtp-Source: AGHT+IF1ds34BfT+ta7HKncNasuld9Lxm6VVPq21SiG5JfN3pcihGwnjO6jOwO4R+Qir2qrr5jo+Bw==
X-Received: by 2002:a17:902:e803:b0:21f:6f33:f96 with SMTP id
 d9443c01a7336-2262c99c631mr69484415ad.6.1742343303184; 
 Tue, 18 Mar 2025 17:15:03 -0700 (PDT)
Received: from [192.168.1.67] ([38.39.164.180])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-301bf58b02csm137038a91.17.2025.03.18.17.15.02
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 18 Mar 2025 17:15:02 -0700 (PDT)
Message-ID: <2fe37412-dc19-4e32-9f97-1cdcf71fb720@linaro.org>
Date: Tue, 18 Mar 2025 17:15:02 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 11/42] accel/tcg: Perform aligned atomic reads in
 translator_ld
Content-Language: en-US
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
Cc: philmd@linaro.org
References: <20250318213209.2579218-1-richard.henderson@linaro.org>
 <20250318213209.2579218-12-richard.henderson@linaro.org>
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
In-Reply-To: <20250318213209.2579218-12-richard.henderson@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62c;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-pl1-x62c.google.com
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

On 3/18/25 14:31, Richard Henderson wrote:
> Perform aligned atomic reads in translator_ld, if possible.
> According to
> 
> https://lore.kernel.org/qemu-devel/20240607101403.1109-1-jim.shu@sifive.com/
> 
> this is required for RISC-V Ziccif.
> 
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>   accel/tcg/translator.c | 42 ++++++++++++++++++++++++++++++++++++++----
>   1 file changed, 38 insertions(+), 4 deletions(-)
> 
> diff --git a/accel/tcg/translator.c b/accel/tcg/translator.c
> index ef1538b4fc..157be33bf6 100644
> --- a/accel/tcg/translator.c
> +++ b/accel/tcg/translator.c
> @@ -265,12 +265,14 @@ static bool translator_ld(CPUArchState *env, DisasContextBase *db,
>   
>       if (likely(((base ^ last) & TARGET_PAGE_MASK) == 0)) {
>           /* Entire read is from the first page. */
> -        memcpy(dest, host + (pc - base), len);
> -        return true;
> +        goto do_read;
>       }
>   
>       if (unlikely(((base ^ pc) & TARGET_PAGE_MASK) == 0)) {
> -        /* Read begins on the first page and extends to the second. */
> +        /*
> +         * Read begins on the first page and extends to the second.
> +         * The unaligned read is never atomic.
> +         */
>           size_t len0 = -(pc | TARGET_PAGE_MASK);
>           memcpy(dest, host + (pc - base), len0);
>           pc += len0;
> @@ -329,7 +331,39 @@ static bool translator_ld(CPUArchState *env, DisasContextBase *db,
>           host = db->host_addr[1];
>       }
>   
> -    memcpy(dest, host + (pc - base), len);
> + do_read:
> +    /*
> +     * Assume aligned reads should be atomic, if possible.
> +     * We're not in a position to jump out with EXCP_ATOMIC.
> +     */
> +    host += pc - base;
> +    switch (len) {

Should we have a case for:
case 1:
	uint8_t t = *(uint8_t *)host;
	stb_he_p(dest, t);
	return true;

To skip the memcpy for a single byte?

> +    case 2:
> +        if (QEMU_IS_ALIGNED(pc, 2)) {
> +            uint16_t t = qatomic_read((uint16_t *)host);
> +            stw_he_p(dest, t);
> +            return true;
> +        }
> +        break;
> +    case 4:
> +        if (QEMU_IS_ALIGNED(pc, 4)) {
> +            uint32_t t = qatomic_read((uint32_t *)host);
> +            stl_he_p(dest, t);
> +            return true;
> +        }
> +        break;
> +#ifdef CONFIG_ATOMIC64
> +    case 8:
> +        if (QEMU_IS_ALIGNED(pc, 8)) {
> +            uint64_t t = qatomic_read__nocheck((uint64_t *)host);
> +            stq_he_p(dest, t);
> +            return true;
> +        }
> +        break;
> +#endif
> +    }
> +    /* Unaligned or partial read from the second page is not atomic. */
> +    memcpy(dest, host, len);
>       return true;
>   }
>   


