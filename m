Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B4F96D277C2
	for <qemu-devel@archiver.kernel.org>; Fri,  9 Jan 2026 22:28:32 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1veKxq-0001xe-Fl; Fri, 09 Jan 2026 17:28:14 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1veKxp-0001xE-4T
 for qemu-devel@nongnu.org; Fri, 09 Jan 2026 17:28:13 -0500
Received: from mail-pl1-x636.google.com ([2607:f8b0:4864:20::636])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1veKxn-0006Yk-I2
 for qemu-devel@nongnu.org; Fri, 09 Jan 2026 17:28:12 -0500
Received: by mail-pl1-x636.google.com with SMTP id
 d9443c01a7336-2a137692691so33156115ad.0
 for <qemu-devel@nongnu.org>; Fri, 09 Jan 2026 14:28:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1767997690; x=1768602490; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=GKEKJLLXd3Tl7xrQprnBJZYzTUdArdpKYe80LicB7+k=;
 b=VV0QbE2nauJCyjJ9wYz3qP6Ez65t12+9cckYvEYrdEY23aRMNB9Nm7ckp2dFk6TOAa
 7G88nhNWgKkq/RmnKFyzOlsgIgrQiZRMsz3bTJdwkK8VdSHPlSkBOD3gzH52pgwVpYGS
 cPg3/hIuIQSDMxP3cxgYNeejbNp1ngp1pckMQ7vsD63u44C960wKnVXtYAM3tj/skzNM
 QhOH5PzCiT9zaaOwZiV/vGHzlIc0a+hn51Lao8BsHtBU3FG1ptQxhPlWOWj8eUaEQXJP
 4II6fBFV6mVZ8FDDhGbzLfhRQe5NkBq4pI0jYJzfoCb+52mUBExQreU9flTzhjs+Coyw
 rTjA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1767997690; x=1768602490;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=GKEKJLLXd3Tl7xrQprnBJZYzTUdArdpKYe80LicB7+k=;
 b=t41uJUJg5AuZqW0xUMObuZgEdmGYHyFAJgSMBfUKercnr6nz8Z/Ao0quSMv/RWDCzl
 k+mydcymuU/ZYVnmYggCyYYuCYq8rBu5eSvCnKqTNb//7WYrai2RAUm/xuERGieQh4hK
 1WXMz/GVRKRBmySJWubGYXS2QpTZ/mm3ENPZyJJDXyvAq53/vGDcoEwLzzvcUsNlpumx
 UCpWeNpPdth1eJzuzUgkyDZPqrL9cWI/PXUROKmoCrTEuQMLI1P9cLtGtTpqsnookfVq
 5Y3qSf5fiFOqzQgfs706Jb4ZkOOUvbUbxn1v12FnvP4+pA7rZfvVTwUJ6FovWTO5gsxF
 DIrw==
X-Forwarded-Encrypted: i=1;
 AJvYcCVG0APiGgGNjkbk8T1ZJmVSAJlMI+QV+F18bcFwpvS4RhoMec2tAbQxRxls2gEiujXeXeHlsce9nZe1@nongnu.org
X-Gm-Message-State: AOJu0YxlxewjG/5qJgJLh0lfiR/OTQG1Kb5yueMXxHteUcxffSp5NVq/
 8wedxkoPF2087jb828vX1N4TMvmF3t49lD65owQGSt2VyK+WhWUEU5LOyPfHiladf6LRZ0ZTRe5
 3EJWg/AY=
X-Gm-Gg: AY/fxX7EXsV+LvKEqDD2zap+uUGDcPgYCumMRHoFXu8Mvn2tL/rvHto9mhWphPWT3Ir
 3Ds9caSpo2HJGA84ef1jggQitmSweP9Kddyi03DxYke6ZR2lSNiGtplZyv5oty7I6u6ypS+xg3P
 Muvb7IbwTzvlcLOmnHNWPfI9eaufbRvbg2ie8TWPU0lEil94IOIPFbBuJ0UKulAFRJ5HfmyjVD3
 LhythZQQ/AI9UnHbByx5OAUJj95+jMB59r+0DxJM1TBYVZNefxdNVRRjWoIQZBsG7GzY7BNpqBh
 94i3z2gzWvmNQKsEOgqbd7L5aOJIGxyiN3CL2wJ+LleiLR0vZdCn0oFkpy9319WjOx9wB4JUyqq
 ns/Cft20xcqJ9JRjx+ZAbn/mRuGQEE9i53t+OWjSt8bOz4J9EKICpQ5cU8oCVbXgU+kBEj5s3TH
 IPsvS1KUBhVPOncjIOiUMpJj1raw==
X-Google-Smtp-Source: AGHT+IFFC11t8J2dG7EdTHy4Oi+24oNiVnrjyopFAcBm/cufc+ha0lKkEYlw48lA9f2jMoFR8Il7gw==
X-Received: by 2002:a17:902:ea11:b0:2a0:f0e5:9468 with SMTP id
 d9443c01a7336-2a3ee4e8281mr100071165ad.32.1767997689957; 
 Fri, 09 Jan 2026 14:28:09 -0800 (PST)
Received: from [172.23.81.179] ([202.86.209.61])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2a3e3cd495dsm114993475ad.96.2026.01.09.14.28.06
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 09 Jan 2026 14:28:09 -0800 (PST)
Message-ID: <6465b320-aedf-4dfe-9562-9a327f84d448@linaro.org>
Date: Sat, 10 Jan 2026 09:28:03 +1100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 23/29] target/arm/tcg/translate: extract helper64 info in
 translate-a64
To: Pierrick Bouvier <pierrick.bouvier@linaro.org>, qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Jim MacArthur <jim.macarthur@linaro.org>, anjo@rev.ng
References: <20260109053158.2800705-1-pierrick.bouvier@linaro.org>
 <20260109053158.2800705-24-pierrick.bouvier@linaro.org>
From: Richard Henderson <richard.henderson@linaro.org>
Content-Language: en-US
In-Reply-To: <20260109053158.2800705-24-pierrick.bouvier@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::636;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x636.google.com
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

On 1/9/26 16:31, Pierrick Bouvier wrote:
> Thanks to HAS_HELPER64 mechanism, we can now move helper info generation
> to a translate-a64 for 64 bits helper.
> This allows to get rid of TARGET_AARCH64 in translate.c.
> 
> Signed-off-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
> ---
>   target/arm/tcg/translate-a64.c | 7 +++++++
>   target/arm/tcg/translate.c     | 9 ---------
>   2 files changed, 7 insertions(+), 9 deletions(-)
> 
> diff --git a/target/arm/tcg/translate-a64.c b/target/arm/tcg/translate-a64.c
> index b7a8e94b937..fed2eb18f13 100644
> --- a/target/arm/tcg/translate-a64.c
> +++ b/target/arm/tcg/translate-a64.c
> @@ -26,6 +26,13 @@
>   #include "semihosting/semihost.h"
>   #include "cpregs.h"
>   
> +#define HAS_HELPER64
> +#include "exec/helper-proto.h"
> +
> +#define HELPER_H "helper64.h"
> +#include "exec/helper-info.c.inc"
> +#undef  HELPER_H
> +
>   static TCGv_i64 cpu_X[32];
>   static TCGv_i64 cpu_gcspr[4];
>   static TCGv_i64 cpu_pc;
> diff --git a/target/arm/tcg/translate.c b/target/arm/tcg/translate.c
> index 5c496f42c55..ec4358ba402 100644
> --- a/target/arm/tcg/translate.c
> +++ b/target/arm/tcg/translate.c
> @@ -26,9 +26,6 @@
>   #include "arm_ldst.h"
>   #include "semihosting/semihost.h"
>   #include "cpregs.h"
> -#ifdef TARGET_AARCH64
> -#define HAS_HELPER64
> -#endif
>   #include "exec/helper-proto.h"
>   #include "exec/target_page.h"
>   
> @@ -36,12 +33,6 @@
>   #include "exec/helper-info.c.inc"
>   #undef  HELPER_H
>   
> -#ifdef TARGET_AARCH64
> -#define HELPER_H "helper64.h"
> -#include "exec/helper-info.c.inc"
> -#undef  HELPER_H
> -#endif
> -
>   #define ENABLE_ARCH_4T    arm_dc_feature(s, ARM_FEATURE_V4T)
>   #define ENABLE_ARCH_5     arm_dc_feature(s, ARM_FEATURE_V5)
>   /* currently all emulated v5 cores are also v5TE, so don't bother */

This is the sort of thing I envisioned for HELPER_H way back when.
The patch set could be improved by placing the helper64.h usage into translate-a64.c in 
the first place, rather than moving it here.


r~

