Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3B1D7C48260
	for <qemu-devel@archiver.kernel.org>; Sat, 10 Feb 2024 17:46:51 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rYrQ6-0008Ja-S1; Sat, 10 Feb 2024 12:45:42 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1rYrQ2-0008JB-Oe
 for qemu-devel@nongnu.org; Sat, 10 Feb 2024 12:45:38 -0500
Received: from mail-pl1-x629.google.com ([2607:f8b0:4864:20::629])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1rYrQ1-0007ck-62
 for qemu-devel@nongnu.org; Sat, 10 Feb 2024 12:45:38 -0500
Received: by mail-pl1-x629.google.com with SMTP id
 d9443c01a7336-1d958e0d73dso14093365ad.1
 for <qemu-devel@nongnu.org>; Sat, 10 Feb 2024 09:45:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1707587135; x=1708191935; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=FPzuGnRvax2Em/g2PgCLdQ+XK9qEz9BJWoUCN2YBu9c=;
 b=gf24qI6k0r7EYxnkE8hWpOK3EFOBXTAFZ9OMmol0Qg1VwM8UGLi65PjxohunfCy50u
 Q4lDnsAyfS6e+LM1VU6MZXmyb1ccAiLUX2H4b+ig+E3FZrvb+l+xEV5uQP0eyoZN1FiL
 GIf3qJG99UqM5lbzWP++6/O/AeSBUlJDWB5MXC/I209o0ddvAIo/PlE2PR5WTBAsP8s6
 DBJ0p921XVXdippYeAQ9jZ6/t1YL1fNMxNL4/3FYbn/oHzGTHtboe6I93QCgnQKkFI8g
 dI2udUGi+s+ZhvLmKW2Is0FdH7uSmQ5+ank/APQYtAOEyJo1vvlFUIIKOrNHQRD20B94
 2aGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1707587135; x=1708191935;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=FPzuGnRvax2Em/g2PgCLdQ+XK9qEz9BJWoUCN2YBu9c=;
 b=E0zYmRfPO+5GRBFOTbnNmZgzPhJXOs2ehkf30tLiDfZ1wbZFWBdF44CVD1QLm6RXGR
 zHCsToXWklvDV1/Ht8iLz6/oMfZ8gmTsgY+yI9c9G9Di7hLoxDIz9KM69R7BXWVrqZ5C
 nD88Vxh65s31/ucSNZJlgXD8Q3cMN+z8rHeDF8ZHk8X440lbA7Z3Oqpp9erzgu7z8t9B
 dmaYzHVl/4Zt4VpEI37kvuKdGI6rRZ5EKGrPI4zz3qCMLkYMSNPlWZk9ikHcULe1QDsY
 VMQ4iGTZFM5a8VNDPFNv10bfnqfRgCDrT8q2jyj5d4t1VQDeh9aXzxEvkyMpMf/qLSYM
 ecEA==
X-Gm-Message-State: AOJu0Yx0rFZKOEHwmxRMRlgi8+fzQgccorAtPrGlvMxGrQnSKoE7XC4V
 jLKqT30N1f67IKXppQ+aGmrvPPLmnk3V4Szj6w/GGUKskADapmMlJYaM4J70Ne0=
X-Google-Smtp-Source: AGHT+IHCy1i4RxpC3Iv9hVgVgaoF8i/7y47gt9lRvhbBOOGDmZoaIduLVu5fuIIm7kKGG7bhx+plXg==
X-Received: by 2002:a17:902:ea06:b0:1d9:a0f2:bc90 with SMTP id
 s6-20020a170902ea0600b001d9a0f2bc90mr7028529plg.17.1707587134961; 
 Sat, 10 Feb 2024 09:45:34 -0800 (PST)
X-Forwarded-Encrypted: i=1;
 AJvYcCUGBQmBYk3HNoFLk2KIZ0XYbibCA7C1uXeEuJ/vZR2O79F1CWY7AvoIdDttnE/1guEZHo0O6jixBZba8a9rDxbDHxF18ZLAZovZ5shGwJtMsNBcv0R6/KB5dz8=
Received: from [192.168.4.112] (066-027-223-101.inf.spectrum.com.
 [66.27.223.101]) by smtp.gmail.com with ESMTPSA id
 kd5-20020a17090313c500b001d97ed98dbbsm3297774plb.42.2024.02.10.09.45.33
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sat, 10 Feb 2024 09:45:34 -0800 (PST)
Message-ID: <35860a77-f44d-4e93-8512-fd109ff4b688@linaro.org>
Date: Sat, 10 Feb 2024 07:45:30 -1000
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] target/arm: Don't get MDCR_EL2 in pmu_counter_enabled()
 before checking ARM_FEATURE_PMU
To: Peter Maydell <peter.maydell@linaro.org>, qemu-arm@nongnu.org,
 qemu-devel@nongnu.org
Cc: qemu-stable@nongnu.org
References: <20240208153346.970021-1-peter.maydell@linaro.org>
Content-Language: en-US
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20240208153346.970021-1-peter.maydell@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::629;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x629.google.com
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

On 2/8/24 05:33, Peter Maydell wrote:
> It doesn't make sense to read the value of MDCR_EL2 on a non-A-profile
> CPU, and in fact if you try to do it we will assert:
> 
> #6  0x00007ffff4b95e96 in __GI___assert_fail
>      (assertion=0x5555565a8c70 "!arm_feature(env, ARM_FEATURE_M)",
> file=0x5555565a6e5c "../../target/arm/helper.c", line=12600,
> function=0x5555565a9560 <__PRETTY_FUNCTION__.0>
> "arm_security_space_below_el3") at ./assert/assert.c:101
> #7  0x0000555555ebf412 in arm_security_space_below_el3
> (env=0x555557bc8190) at ../../target/arm/helper.c:12600
> #8  0x0000555555ea6f89 in arm_is_el2_enabled (env=0x555557bc8190) at
> ../../target/arm/cpu.h:2595
> #9  0x0000555555ea942f in arm_mdcr_el2_eff (env=0x555557bc8190) at
> ../../target/arm/internals.h:1512
> 
> We might call pmu_counter_enabled() on an M-profile CPU (for example
> from the migration pre/post hooks in machine.c); this should always
> return false because these CPUs don't set ARM_FEATURE_PMU.
> 
> Avoid the assertion by not calling arm_mdcr_el2_eff() before we
> have done the early return for "PMU not present".
> 
> This fixes an assertion failure if you try to do a loadvm or
> savevm for an M-profile board.
> 
> Cc:qemu-stable@nongnu.org
> Resolves:https://gitlab.com/qemu-project/qemu/-/issues/2155
> Signed-off-by: Peter Maydell<peter.maydell@linaro.org>
> ---
>   target/arm/helper.c | 12 ++++++++++--
>   1 file changed, 10 insertions(+), 2 deletions(-)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~

