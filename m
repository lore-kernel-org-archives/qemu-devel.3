Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0DB28C36014
	for <qemu-devel@archiver.kernel.org>; Tue,  1 Apr 2025 06:19:16 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tzUxZ-0004I0-Hy; Tue, 01 Apr 2025 02:18:53 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tzUxW-0004Gi-7K
 for qemu-devel@nongnu.org; Tue, 01 Apr 2025 02:18:50 -0400
Received: from mail-wr1-x434.google.com ([2a00:1450:4864:20::434])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tzUxU-00011W-18
 for qemu-devel@nongnu.org; Tue, 01 Apr 2025 02:18:49 -0400
Received: by mail-wr1-x434.google.com with SMTP id
 ffacd0b85a97d-39ac8e7688aso4027215f8f.2
 for <qemu-devel@nongnu.org>; Mon, 31 Mar 2025 23:18:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1743488326; x=1744093126; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=zrBYSrQECCHHU7VRlWpCfOKFP6wJqZynf+6K7nNAk/A=;
 b=y+C4zO8VVp8h0mCHsGr2Sjj0c9K/7Nxz+hsBtkujigj5QEXFddBwKGoHBYKB1iQAp5
 upAHujwp8aD3/G+D6gACQ77n6O+FkBfYJA8FFNddp2Z1LmQWpDEEiHQZdIaONvrbhHVi
 qFM9KS8Hhvwosi6GsYlnCqfZlLLQuOMXwwSiTt+ckk8vMiPlaJ5urSq0x1W7LCt/cyFz
 LqcCTUKQkipCYwgq4bXl59HMo/KA836XW8/EE4U35k+oOpKWXX8rVLrIQXh4YkkZ2pT2
 R2F1Wvw5K/sZK8NvoPFhrWqMGqvgcqpfeTuHeNrNKdjQN6DoGHZfkv3vHsOpjXSlTHQs
 RTfA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1743488326; x=1744093126;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=zrBYSrQECCHHU7VRlWpCfOKFP6wJqZynf+6K7nNAk/A=;
 b=jMcRPgvz+930IAkzfJ7O9oHNrWJ4wEohRz/0kvuSmi0Ba2zRemlPYa+lWFTGHmk0tw
 bzNZqqD4+wmMNicy84/yUyr842DiCg2Ot9lGxyRQe+5vNfPk9NFjfwf8xobuO02wsm9x
 V5+VN9NeIMGHli2yfYl2KxaImHP/pQRCRl1/ltg3iFqu5NhLqXjgL4trWqWXGv/ZZoaN
 +VuBX33FFvQvGSyEyNgDhg8eTtiPRP8HrBGJSk8AJUZfCo/tk0tO6HImncEHegIm4lIa
 K2y1Dj/nWzidSiF3g7raBT2PwSqrbiMWqh5cleyM2zxMnwtrAlotODVDmHVvUm8AMBWS
 N3UA==
X-Forwarded-Encrypted: i=1;
 AJvYcCVQE6ShtCMl3UPDecRREh1tYRRCzKsohRVlDGZYxy2/OzJHUgxgnSMi3BTPNDEk2zwrZgiC+qaG0q9I@nongnu.org
X-Gm-Message-State: AOJu0YxdjzbYOewvGw9DNrQxpISXjzn0xX55UuXL2zh4DvJUfpTZlGLS
 mC3gf06UuAJtJMMglnaPWM1ymy+ZE8+MJORJBnvZIwXUOw0bwM/h+2oE8nPr01o=
X-Gm-Gg: ASbGncssPtYfXiPt2NL7aVVEH79YDQOrhbNlrUA1TvgaoFM2YNjV0iVHitcd9GnhFJg
 Mrkp3wmh5/wc8eHscgIMqSxNI4mgP6UdxF5dr/MtoRp+y8wS0CoBcB/7OaVx/1ssmPJ2BTegBqs
 X5QZ4Oj6EZLDA7+q+ugJ+IboJp+BybSDFSGnYRIleus+f8zXpJyWeZ8cSLMJlme0L6/mpaZSwJ4
 4QAf6m8KlM8kG8QzrnPO7UeeNfee1QOk1Ayr5MCM3RFFIIhRrRUoGrn5OzUsQ/cC0NkvREGVo37
 GdLviIe8IhkLUFf1eTt+aVc5ee+OjHUnSOrDycmxjKFbcW79tEnK3SeVCT0w4P/RaWk5vMZAPaX
 CkyJlWXf5y5im5WxF9kMkC88=
X-Google-Smtp-Source: AGHT+IHEFcKR7QF74a23sK5/31lyy/w+za3XO2MYnXpQmlWSIhz402/KMJtUhwOAB7RJzht7BYgIeQ==
X-Received: by 2002:a5d:47c8:0:b0:390:e48a:3869 with SMTP id
 ffacd0b85a97d-39c120cbacbmr8678800f8f.11.1743488326355; 
 Mon, 31 Mar 2025 23:18:46 -0700 (PDT)
Received: from [192.168.69.235] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-43d8fbc10e1sm144316795e9.12.2025.03.31.23.18.45
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 31 Mar 2025 23:18:45 -0700 (PDT)
Message-ID: <c460aa3c-b953-4fd8-8675-6e9151971ad2@linaro.org>
Date: Tue, 1 Apr 2025 08:18:45 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 11/42] accel/tcg: Perform aligned atomic reads in
 translator_ld
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
Cc: pierrick.bouvier@linaro.org, Jim Shu <jim.shu@sifive.com>,
 Frank Chang <frank.chang@sifive.com>, qemu-riscv <qemu-riscv@nongnu.org>
References: <20250318213209.2579218-1-richard.henderson@linaro.org>
 <20250318213209.2579218-12-richard.henderson@linaro.org>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20250318213209.2579218-12-richard.henderson@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2a00:1450:4864:20::434;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x434.google.com
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

Cc'ing Jim & Frank

On 18/3/25 22:31, Richard Henderson wrote:
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


