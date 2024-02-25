Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D6CF8C54798
	for <qemu-devel@archiver.kernel.org>; Sun, 25 Feb 2024 16:49:47 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1reHge-0006l8-8P; Sun, 25 Feb 2024 11:49:12 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1reHga-0006gH-4M
 for qemu-devel@nongnu.org; Sun, 25 Feb 2024 11:49:08 -0500
Received: from mail-wm1-x32b.google.com ([2a00:1450:4864:20::32b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1reHgY-00065P-IR
 for qemu-devel@nongnu.org; Sun, 25 Feb 2024 11:49:07 -0500
Received: by mail-wm1-x32b.google.com with SMTP id
 5b1f17b1804b1-412a4b42c03so1263725e9.3
 for <qemu-devel@nongnu.org>; Sun, 25 Feb 2024 08:49:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1708879745; x=1709484545; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=cQ93+U4iF7Lp6xVGeVCZ93z2WCS/RCy7fhk0Vh/5pHY=;
 b=pb3ncUXeenJGC+qqCaa3hc7czLb+XsB2KP2Gkjx2oWE95rJg6UG1YJmvaQWfkR49ZR
 Trl6Mdd7TsWDC+p8WDsvorPKwDfdGdVlRXA8VHm4mI0EwDBHUZykZl602amO7DzWJy4A
 U6lLrnA7Z9m6O8ouldF6cYwve2KuSUio/p1p47cP9+047rp93Jlht8cLuIqDeiBU0m3u
 i6Tkry6a3dNyh5B7KBZFUydwQqguoCq2uinq0i2ulmdOyNafQJkWs2n3q+es4znMaZB7
 8nm97/9AT5t5U/HchT2RtMc26w93+3V1qZ27ci14VR9nHk6iaK7LYCtbXn2v/eg9hP/h
 Sx2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1708879745; x=1709484545;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=cQ93+U4iF7Lp6xVGeVCZ93z2WCS/RCy7fhk0Vh/5pHY=;
 b=JtN56WK0Qktkm7G/n0UX4bwXxDFP5bemAjHj1DCROracJYsHsaoBkXwc3FS86mBH+L
 AOg3G0YQ2OXcmHMHtXP09lqAptn6OGAQRz47+IvFY4d6/xj3RV96DAERViavU7ax2YKI
 p9dqG1Ky2kZw5fsqyYiGDDDgxEPPGWXbjazXCtjufg86mTijWZobn16ih6XUBaI9PIvL
 DdnFG8T9vyD2l/QypFBWE3O6EHrNHegh4SwIngnJNA+LngYB6qM7Ga8LbXjMFBe6p62y
 DnWG05Sd6iqlXYJbyWJfqAMVtAwv7GqhpR60wJxUqPwdrh4KmdbheXofT4m2rqMsrazJ
 gI9w==
X-Forwarded-Encrypted: i=1;
 AJvYcCUjJ9LLvSpmKC8N0cLbCYu23sX9SU6U285/+pyLNu7dJ32KxAUeLdyaMgVhKvs5CI6H1LzQ88XAQh6AQ97S3schf55+WHo=
X-Gm-Message-State: AOJu0Yy2yC0ooflxkwPOrr+KKg8Kg2uMgvhIqNAFs+VrtLvPZQMiu9BH
 6Dm6jKd+pvRyYK90n0UPPT6aNTyN2IVS6vEn4qWB84V9GaGsHLS0eIlIazuczc7dJan2spQEyTL
 a
X-Google-Smtp-Source: AGHT+IFwr04bKRwYcQOWkROh2+PK8cHsjqoQCqqEuJq8LlXhDX3Vi4ddqM2FmeQ5nYpZRSAQ6inJRw==
X-Received: by 2002:a05:600c:a385:b0:412:96e2:96aa with SMTP id
 hn5-20020a05600ca38500b0041296e296aamr3725947wmb.28.1708879744742; 
 Sun, 25 Feb 2024 08:49:04 -0800 (PST)
Received: from [192.168.69.100] ([176.176.164.69])
 by smtp.gmail.com with ESMTPSA id
 u16-20020a05600c211000b004126732390asm9333876wml.37.2024.02.25.08.49.03
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sun, 25 Feb 2024 08:49:04 -0800 (PST)
Message-ID: <d3bd9fa7-3034-4423-b3fa-d3761c3008ce@linaro.org>
Date: Sun, 25 Feb 2024 17:49:02 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] target/riscv: Fix shift count overflow
Content-Language: en-US
To: "demin.han" <demin.han@starfivetech.com>, qemu-devel@nongnu.org
Cc: qemu-riscv@nongnu.org, dbarboza@ventanamicro.com, alistair.francis@wdc.com
References: <20240225032720.375078-1-demin.han@starfivetech.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20240225032720.375078-1-demin.han@starfivetech.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32b;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x32b.google.com
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

On 25/2/24 04:27, demin.han wrote:
> The result of (8 - 3 - vlmul) is negtive when vlmul >= 6,

Typo "negative".

> and results in wrong vill.
> 
> Signed-off-by: demin.han <demin.han@starfivetech.com>
> ---
>   target/riscv/vector_helper.c | 5 ++---
>   1 file changed, 2 insertions(+), 3 deletions(-)
> 
> diff --git a/target/riscv/vector_helper.c b/target/riscv/vector_helper.c
> index 84cec73eb2..fe56c007d5 100644
> --- a/target/riscv/vector_helper.c
> +++ b/target/riscv/vector_helper.c
> @@ -44,6 +44,7 @@ target_ulong HELPER(vsetvl)(CPURISCVState *env, target_ulong s1,
>       target_ulong reserved = s2 &
>                               MAKE_64BIT_MASK(R_VTYPE_RESERVED_SHIFT,
>                                               xlen - 1 - R_VTYPE_RESERVED_SHIFT);
> +    uint16_t vlen = cpu->cfg.vlenb << 3;
>       int8_t lmul;
>   
>       if (vlmul & 4) {
> @@ -53,10 +54,8 @@ target_ulong HELPER(vsetvl)(CPURISCVState *env, target_ulong s1,
>            * VLEN * LMUL >= SEW
>            * VLEN >> (8 - lmul) >= sew
>            * (vlenb << 3) >> (8 - lmul) >= sew
> -         * vlenb >> (8 - 3 - lmul) >= sew
>            */
> -        if (vlmul == 4 ||
> -            cpu->cfg.vlenb >> (8 - 3 - vlmul) < sew) {
> +        if (vlmul == 4 || (vlen >> (8 - vlmul)) < sew) {
>               vill = true;
>           }
>       }


