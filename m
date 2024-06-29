Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D64CDC30659
	for <qemu-devel@archiver.kernel.org>; Sat, 29 Jun 2024 16:22:36 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sNaph-0007u0-Q5; Sat, 29 Jun 2024 12:21:49 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1sNapg-0007td-B9
 for qemu-devel@nongnu.org; Sat, 29 Jun 2024 12:21:48 -0400
Received: from mail-pf1-x434.google.com ([2607:f8b0:4864:20::434])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1sNape-0006es-Qn
 for qemu-devel@nongnu.org; Sat, 29 Jun 2024 12:21:48 -0400
Received: by mail-pf1-x434.google.com with SMTP id
 d2e1a72fcca58-706683e5249so1086957b3a.2
 for <qemu-devel@nongnu.org>; Sat, 29 Jun 2024 09:21:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1719678104; x=1720282904; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=mMdwZVEfI/dAA94EPLCTlDwq3F6q1KZmQl9heAggKEA=;
 b=nXwz+xouT1ASovhpeipjJVjrhbBDl+DfGvqTKEJYaQCbK24xZXFI65r1LO2WecLQD/
 JaIvwYeRlpzDOcdT25v81JCvLj0e8xGjTfJAJaqjgBa8IMMY4tcQ4bO3bGQa5MPGgtzD
 rah+53K6RA8dWMfj0CW2Esa9eQJvmWJRVQmwc2XidhsWUNc8Fmr/N5mhGglo9NJoKyMD
 PGCO7ZqBrFmzoQi640XtC22Djcb+iQZE6bmknpIUi195bg3VeshDFPUHcZl97oz60JbC
 ez6Vp7zz8UfBOoUP09ZpDDxAtwPMqwF3/gxeU+auV+crtK7lKr80B0erS9M58LlIehl5
 nTSA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1719678104; x=1720282904;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=mMdwZVEfI/dAA94EPLCTlDwq3F6q1KZmQl9heAggKEA=;
 b=jD2XqcJrvwa3VRkxx+q0jzPAHk3BOV9oJsG9tRjygXkuzgjqxbvIRBjs+B2Tpx/Iuv
 y/WE454PvO7x6wK4muXCx+bgzGHluJ0VPBQF2GB5vil/XqSxsfleuKSjt15M3ac/E6LR
 Mfk3peBQxrucJk/V3eLOJqUDfCmZ8bntaoPrOrsn0GGhNzGWMb+uhbED1E+WOG3eho9U
 aA+53Wv482EuHM0D5h4m2o5fB2KcaPCQnyEii9QHxNgx4+gc4HM54RoC4hKuBr1MYieK
 qbT7HTq6/EsGtiCnPOJ8XB+t2rLtwJZPLFq+FxDtL9vSjVh9DX1bZ8zjqycy1K2ZPYci
 LKBw==
X-Forwarded-Encrypted: i=1;
 AJvYcCU6S+n0B4Zjms4jmcvgGB2OyxKriBpsSapmJWCzJmuDb+92hF/0rf/7yFBEC0uWGOE/7D1fKgB/bxSToI/2No6JMwxKSXo=
X-Gm-Message-State: AOJu0YwQ66mfT47KssTDto+IOhQedPXcbEkY4BYv4W8mipp/E+hjuUqP
 TPvmlC3P91m7NG/BVJhXapm9pKe9tHE3MePM+tYk4UXOPTj+IocvxKPHKEdHNrc=
X-Google-Smtp-Source: AGHT+IGx+z5FWeu8q3RAQkyPHswkryLa+WpD0XSI3F20wvWjtI6raNMpTb/q61hlLUZm8OiQITmgCg==
X-Received: by 2002:a05:6a00:2d06:b0:706:62d9:a4f1 with SMTP id
 d2e1a72fcca58-70aaaf44f51mr1358767b3a.31.1719678103482; 
 Sat, 29 Jun 2024 09:21:43 -0700 (PDT)
Received: from [192.168.0.4] (174-21-76-141.tukw.qwest.net. [174.21.76.141])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-708042be4e6sm3454740b3a.153.2024.06.29.09.21.42
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sat, 29 Jun 2024 09:21:42 -0700 (PDT)
Message-ID: <eb2c8141-4b16-43bb-94ba-698e3d937eff@linaro.org>
Date: Sat, 29 Jun 2024 09:21:40 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 7/7] tests/tcg/arm: Manually bit-cast half-precision
 numbers
To: Akihiko Odaki <akihiko.odaki@daynix.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Cc: qemu-arm@nongnu.org, qemu-devel@nongnu.org
References: <20240629-tcg-v3-0-fa57918bdf09@daynix.com>
 <20240629-tcg-v3-7-fa57918bdf09@daynix.com>
Content-Language: en-US
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20240629-tcg-v3-7-fa57918bdf09@daynix.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::434;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x434.google.com
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

On 6/29/24 01:56, Akihiko Odaki wrote:
> clang version 18.1.6 does not allow specifying an integer as the value
> of a single-precision register. Manually bit-cast into float with vmov
> first.
> 
> Signed-off-by: Akihiko Odaki <akihiko.odaki@daynix.com>
> ---
>   tests/tcg/arm/fcvt.c | 4 +++-
>   1 file changed, 3 insertions(+), 1 deletion(-)
> 
> diff --git a/tests/tcg/arm/fcvt.c b/tests/tcg/arm/fcvt.c
> index f631197287a1..5263f607b59c 100644
> --- a/tests/tcg/arm/fcvt.c
> +++ b/tests/tcg/arm/fcvt.c
> @@ -355,7 +355,9 @@ static void convert_half_to_single(void)
>   
>           print_half_number(i, input);
>   #if defined(__arm__)
> -        asm("vcvtb.f32.f16 %0, %1" : "=w" (output) : "x" ((uint32_t)input));
> +        float tmp;
> +        asm("vmov %0, %1" : "=w" (tmp) : "r" (input));
> +        asm("vcvtb.f32.f16 %0, %1" : "=w" (output) : "x" (tmp));
>   #else
>           asm("fcvt %s0, %h1" : "=w" (output) : "w" (input));
>   #endif

Better as

  #if defined(__arm__)
-        asm("vcvtb.f32.f16 %0, %1" : "=w" (output) : "x" ((uint32_t)input));
+        /*
+         * Clang refuses to allocate an integer to a fp register.
+         * Perform the move from a general register by hand.
+         */
+        asm("vmov %0, %1\n\t"
+            "vcvtb.f32.f16 %0, %0" : "=w" (output) : "r" (input));
  #else

without the C temporary.  With that,

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>


r~

