Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 193BAC36005
	for <qemu-devel@archiver.kernel.org>; Tue, 25 Mar 2025 01:39:46 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1twtER-0001W0-4L; Mon, 24 Mar 2025 21:37:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1twtEK-0001Uo-Ob
 for qemu-devel@nongnu.org; Mon, 24 Mar 2025 21:37:24 -0400
Received: from mail-pl1-x636.google.com ([2607:f8b0:4864:20::636])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1twtEI-0007PA-4B
 for qemu-devel@nongnu.org; Mon, 24 Mar 2025 21:37:23 -0400
Received: by mail-pl1-x636.google.com with SMTP id
 d9443c01a7336-225477548e1so93981645ad.0
 for <qemu-devel@nongnu.org>; Mon, 24 Mar 2025 18:37:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1742866640; x=1743471440; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=3w9DhmowczHvs1JiFYb2LZX6ZUXuVOWpO5YW7Ek+lOo=;
 b=Su7hpnSWYcrNSEvU70/zWDcwTE5LW+bo2bY0Y0uMWJh28fVS3x8li2S8LTPEvVL2+5
 y0AHlYtljQjnbkFLJzp/N0a7uKM3YyKZpwq4uTuOr553mKPEwBM6Ba3fHiS1bf2RW8N1
 c5Wy7or06ynTVJqoGq6M18jtjoHzWn/KdqU6LfvPCVv00ARdGaboSijarpRG/IPlsbPu
 uU2ZeFZNAOZcMH4KuQrf/sjEmuI5jkrmYNhB+/QCz97wAgjRO9PwToJ5NdgLTdUOoVT7
 aorzGazwyyHRDJxvhbYjAljqpcu0RNA14722zfb5XAh+B+pEInCzNUvYsH9i1tcv6aOz
 KVWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1742866640; x=1743471440;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=3w9DhmowczHvs1JiFYb2LZX6ZUXuVOWpO5YW7Ek+lOo=;
 b=xT7RzdMwoHEP6EL8grLLvtNciANqE4PKZibuAF9SHIjE3r2cbSIn7wuQN2BokXsfds
 GCUYVmEA5qW76MCHU83Or0M0YhfWIXJffhupY1s0+Gny3nit9O+ci+N+gSHr2GOGZH/x
 NbG1qT5CRO1xWWE/YdB0VXmZ4/3pC5o04YYocyLpeyp4ntasLvcO6tXjhcjRAGxAIth7
 Fvqfn/ENf2fZS3zBh6ww/SlmOQZGAM4IdyNI9OndV/9UxFNhmYQ5op7ISM0DZsm/W1xj
 5rM5zGkOgSEo1aQHHuxEt+mDG/E30+D6sZcVZdFD5/+wPov9AocMUmRA8v2TtMOjhH+j
 Q9fQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCXCaot0itEyM8lrOno+l+tCnqvq+nE9ClyEFMkWFdgwwVCO407bbPfyzEkbIHXXo5m9CQOVES7O0JAy@nongnu.org
X-Gm-Message-State: AOJu0Yw3dhz1r/5c3plmIv2CFZmVdarIGCk/iyJMcFj2eLwi2NUaGMJ/
 V3mXMregefDY8IJ6kcFKmYR0BtCGKlr7WBOUuvnnhM9wm8dna2d8nFnAVoAsgt0=
X-Gm-Gg: ASbGnctzr87MWdz0TcoKJOlb8wsh+sxOQGUbn5H7yBN20PPssgJYdjsq2bAMfRm5EkX
 G6iWNu7hu+nie/KdlNaa5nRDquWWww4JPgG5viYPurTLrGDBPOLHm6E9Zw2yhYh3abgItWlFfHA
 4Cue1n0y2UDz9FaxQYwlAjV7YSoYiqb9cZymIefDgMbYKnj4g38+W2XheDX/G7tbxoBqP5FZ70f
 kiryRb6cLTR/i1e94r8z3whHkEInTeN/t95PhMe5rQAQKzMFReP2EEDrt/LpDSXyX3Cf90QSPgN
 X3iM2b0mvYfpyI1G57QMD01Akx6c1mvGbDBrZIj0DFe9WbH5u284kxdT9A==
X-Google-Smtp-Source: AGHT+IFPLM77V7cYy3BO/mwgzEUIWpMlJKvorGVkKRj5fSI4j9oxUI8HgCwXkebDBXt4yEB6mGTj6A==
X-Received: by 2002:a05:6a00:ac8:b0:736:4ebd:e5a with SMTP id
 d2e1a72fcca58-73905a63bd5mr26455469b3a.20.1742866640392; 
 Mon, 24 Mar 2025 18:37:20 -0700 (PDT)
Received: from [192.168.1.67] ([38.39.164.180])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-73906158ef2sm9090422b3a.141.2025.03.24.18.37.19
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 24 Mar 2025 18:37:19 -0700 (PDT)
Message-ID: <1b32a0c9-4073-409c-acde-bb819c5c79c3@linaro.org>
Date: Mon, 24 Mar 2025 18:09:29 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 07/17] target/avr: Use do_stb in avr_cpu_do_interrupt
Content-Language: en-US
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
Cc: mrolnik@gmail.com, philmd@linaro.org
References: <20250323173730.3213964-1-richard.henderson@linaro.org>
 <20250323173730.3213964-8-richard.henderson@linaro.org>
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
In-Reply-To: <20250323173730.3213964-8-richard.henderson@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::636;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-pl1-x636.google.com
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

On 3/23/25 10:37, Richard Henderson wrote:
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>   target/avr/helper.c | 12 ++++++------
>   1 file changed, 6 insertions(+), 6 deletions(-)
> 
> diff --git a/target/avr/helper.c b/target/avr/helper.c
> index 7cfd3d1093..9608e59584 100644
> --- a/target/avr/helper.c
> +++ b/target/avr/helper.c
> @@ -88,14 +88,14 @@ void avr_cpu_do_interrupt(CPUState *cs)
>       }
>   
>       if (avr_feature(env, AVR_FEATURE_3_BYTE_PC)) {
> -        cpu_stb_data(env, env->sp--, (ret & 0x0000ff));
> -        cpu_stb_data(env, env->sp--, (ret & 0x00ff00) >> 8);
> -        cpu_stb_data(env, env->sp--, (ret & 0xff0000) >> 16);
> +        do_stb(env, env->sp--, ret, 0);
> +        do_stb(env, env->sp--, ret >> 8, 0);
> +        do_stb(env, env->sp--, ret >> 16, 0);
>       } else if (avr_feature(env, AVR_FEATURE_2_BYTE_PC)) {
> -        cpu_stb_data(env, env->sp--, (ret & 0x0000ff));
> -        cpu_stb_data(env, env->sp--, (ret & 0x00ff00) >> 8);
> +        do_stb(env, env->sp--, ret, 0);
> +        do_stb(env, env->sp--, ret >> 8, 0);
>       } else {
> -        cpu_stb_data(env, env->sp--, (ret & 0x0000ff));
> +        do_stb(env, env->sp--, ret, 0);
>       }
>   
>       env->pc_w = base + vector * size;

Reviewed-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>


