Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 70FE2606A31F
	for <qemu-devel@archiver.kernel.org>; Thu, 29 Oct 2026 15:34:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256 header.s=google header.b=V1sEASiH
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xMS9J-0003qI-Se; Thu, 29 Oct 2026 11:34:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1xMS8r-0003pT-CQ
 for qemu-devel@nongnu.org; Thu, 29 Oct 2026 11:34:14 -0400
Received: from mail-ot1-x32b.google.com ([2607:f8b0:4864:20::32b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1xMS8p-00054f-R9
 for qemu-devel@nongnu.org; Thu, 29 Oct 2026 11:34:13 -0400
Received: by mail-ot1-x32b.google.com with SMTP id
 46e09a7af769-83bbcfba0ffso1710767a34.0
 for <qemu-devel@nongnu.org>; Thu, 29 Oct 2026 08:34:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1793288050; x=1793892850; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=zJusoTQbRudW6VVAM3fQyVgAJpXrq0H/8g7ieztShoA=;
 b=V1sEASiHGfGPc3OhjP6Dlb4WFbYVvh/NcN5YiNP74mkDpvz+g+ANT2CtXSVgMxy7+e
 j0qpT82CRh0Ph6GzSnz/SlmISrTpaX1fwmtuJkVxx+SBwiwKFIZWHk4qKCZCfzaMvPI3
 YMdiU/x89QWyRdgpGyx3zjTTdNlWH4X63HVPQgA6oS0PZqYE0xuno3VNH43x95XM7mAM
 lTco7gnka0XQy524T1drJs8k/VPLeLMzKwPpe3BnYVT1QHS44Ciu+3goOsPAc7j32MlL
 W7pQFG+c6T4mDRmsOAx3MT5jghbaWVQ7gnWGHZqOebQb+mN4bXk8PsmRnpprZwpp9r2Q
 Bw5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793288050; x=1793892850;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=zJusoTQbRudW6VVAM3fQyVgAJpXrq0H/8g7ieztShoA=;
 b=DVt+ydp4J396IdBcqcCrAGYz3tirnOb7gfFqm8HqkWdtjHWb0h13NIYn0LTTKcrs7O
 afJNPZqLxB/zPdljFBsMS9oHfZYJotxbC05PeLTwp9BrPF7PdGBoBw3zWKNujqlpr6QK
 vFURLT4snBR6AEqSOhcl1zETsvfQ7EqlWW8oX2ONACO94YSn8YsXvm0TRK/Uwl0fwAgS
 p+c8aCGqzWKlbWfF88jgu6FEzRGZtnvn6+lbhqyPAbg+BOs7ZPiTIgWe6RVRcc4tXaio
 hsmQlpHvQw/Obiu01pCqjXqiQZFUhs7EVeKcvDzBop39/M0vDvbvdflRF93jUyO5Q6VB
 AS3A==
X-Forwarded-Encrypted: i=1;
 AKwUvBzmNllte5zWCWmdPgiV1zTpHV2snA7SxsY9MGYzQakiVk7VvTHTPKS/uSnMoMQVUU1KTpSgo+1k2aXO@nongnu.org
X-Gm-Message-State: AFq9FYI4o8++M6nOn6E6NVcXP6Trh7WL2RVXQYPYnsWiToOEfI/i5HTs
 II+SZWDjhxRATHDZJnOAeu/s228MEXkjgZhXQLQnyBJX17h0IULND+Vattn4vOFwKYg=
X-Gm-Gg: AYBFou1abXJBnGCCF2Mzrd9HNtqrNIIHHSiDqpXNXEtPhoQk5VSlowA3BgCIAxG43e+
 Yd+qQrN5n6NGHwDFCOpvsndJETUrX5wv5EszsC3Iw4kVDDXDMO/kof0im9/ORcJfbj+/7YrkXYe
 JDeZpt0/P47jjpHdueGjbGxJLcel5G+ADZ/hLsx0JBEXwbXhEWBZY6BBWEx/QXRrlTTjFRCZrmN
 FgvHesqqVn+uYOQjcp8sSp0ab2FXHYFIm+4v5AodT41K5U4wXcpnB2BoGCpCDZwkQ/0rYXQJIxy
 Bi/p91NibCq+CExCMsOYnXr3eFVCQ38K23MmgKCr0DArXlo19JU9TlXfolptrRGhe5qyVoscVDn
 DhtKK7YVqVwKjpUUH+8cnIt0rqOkqGbHLmoYVIjrvwxENoV/BVr5FkNlk3aJ/sUec0SkRHjEO/c
 FhCXIImKPVkts3NtX+NH0lHgdlm637I4/LdjBmsaXCyJ9E1uMrPBAEDBEArEthwE8BvXH+2Kt4N
 yB2xT8H/o4Zy43m/8aiMVbTUg/S4/7cvX/Xl3V37eHXejqzqTnnYV3lUyqbtg9uANVblPZI7DMx
 jaNmWimIsgtU+1XXHTe6eVnZpabgN1N7/9ZT6VzfF8Tz
X-Received: by 2002:a05:6830:2b22:b0:81b:a5f9:3490 with SMTP id
 46e09a7af769-85abe6c5c7cmr5137207a34.24.1793288049728; 
 Thu, 29 Oct 2026 08:34:09 -0700 (PDT)
Received: from [192.168.129.53] ([50.233.235.3])
 by smtp.gmail.com with ESMTPSA id
 46e09a7af769-85d3400540asm79283a34.19.2026.10.29.08.34.06
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 29 Oct 2026 08:34:07 -0700 (PDT)
Message-ID: <cc879e21-1c6f-4aae-b4b6-afa9675c17ac@linaro.org>
Date: Thu, 29 Oct 2026 10:34:05 -0500
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/3] tests/tcg/mips64: Report Octeon test results with TAP
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>,
 qemu-devel@nongnu.org
Cc: =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 Aurelien Jarno <aurelien@aurel32.net>, Aleksandar Rikalo
 <arikalo@gmail.com>, Jiaxun Yang <jiaxun.yang@flygoat.com>
References: <20261029152009.19812-1-philmd@oss.qualcomm.com>
 <20261029152009.19812-3-philmd@oss.qualcomm.com>
From: Richard Henderson <richard.henderson@linaro.org>
Content-Language: en-US
In-Reply-To: <20261029152009.19812-3-philmd@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::32b;
 envelope-from=richard.henderson@linaro.org; helo=mail-ot1-x32b.google.com
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

On 10/29/26 10:20, Philippe Mathieu-Daudé wrote:
> Replace assert() by a CHECK() macro printing one TAP line per check,
> so a failure no longer aborts the remaining ones. Select the TAP
> protocol in the meson setup.
> 
> Signed-off-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>
> ---
>   tests/tcg/mips64/octeon-insns.c | 76 +++++++++++++++++++--------------
>   tests/tcg/mips64/meson.build    |  1 +
>   2 files changed, 45 insertions(+), 32 deletions(-)
> 
> diff --git a/tests/tcg/mips64/octeon-insns.c b/tests/tcg/mips64/octeon-insns.c
> index 6fffc8201034..2c4fe8f58875 100644
> --- a/tests/tcg/mips64/octeon-insns.c
> +++ b/tests/tcg/mips64/octeon-insns.c
> @@ -4,8 +4,17 @@
>    * SPDX-License-Identifier: GPL-2.0-or-later
>    */
>   
> -#include <assert.h>
>   #include <stdint.h>
> +#include <stdio.h>
> +
> +static int tests, failures;
> +
> +#define CHECK(cond) \
> +    do { \
> +        int ok_ = !!(cond); \
> +        printf("%s %d - %s\n", ok_ ? "ok" : "not ok", ++tests, #cond); \
> +        failures += !ok_; \
> +    } while (0)
...
> +    printf("1..%d\n", tests);
> +
> +    return failures ? 1 : 0;
>   }
I assume you're going to use this elsewhere.  Header?  Macro/function 
for finishing up in main?


r~

