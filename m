Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C920A606A335
	for <qemu-devel@archiver.kernel.org>; Thu, 19 Nov 2026 18:42:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256 header.s=google header.b=KLMADWuu
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xU74p-0003bW-Mc; Thu, 19 Nov 2026 13:41:43 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1xU74o-0003bL-9x
 for qemu-devel@nongnu.org; Thu, 19 Nov 2026 13:41:42 -0500
Received: from mail-pf1-x42a.google.com ([2607:f8b0:4864:20::42a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1xU74l-0003qV-HO
 for qemu-devel@nongnu.org; Thu, 19 Nov 2026 13:41:40 -0500
Received: by mail-pf1-x42a.google.com with SMTP id
 d2e1a72fcca58-8b2382bf051so80835b3a.3
 for <qemu-devel@nongnu.org>; Thu, 19 Nov 2026 10:41:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1795113698; x=1795718498; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=mcehBbXePOa48hlsY2Fi55ZCrpdAYthz6Seo/91MfH4=;
 b=KLMADWuuNdu5voxV+G9UJDgC/Pwgbg9XDYV2OQXVNEKBDrE4VGnfCEtQW+aH/AZXLT
 ke//Pw56DnWCyVJdlLzJ7qThbQcVTbgNcISKfZw07g+cYbbeWTg8axTvlsZQhsOzHcNS
 pQFTer20kBHe4ylRewABIUPqz7zHhh40iJsYxFybjjQp4QAtxZn2pNII9HVo4s+18yUd
 t4pDImFpvcVo21xkc7uLwkNkdyop6MjTqvtFUJ9x+2iVYiHN8/9a3bQoFZ0q9ur6Oj2j
 aCvttP89SXxFaDvLp2OFArfyh6xzOc64nX5awHfhRHcFhaUin132wV+My8YkV6zaQK10
 qI8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1795113698; x=1795718498;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=mcehBbXePOa48hlsY2Fi55ZCrpdAYthz6Seo/91MfH4=;
 b=tvp7uMspARxnu+OUjA7eDGkrrq503r1oX9C7av87Fiykwqn8hNRrL80+xS0+H3JDyA
 xbwCniCei/SDa3NNznOCkH4zZCbztOrJTPCF5x4dN65lCK39XEJu3sSq3T7HM7eG95I5
 2MymOqDoI4Lm0zvp1YXUDVYU7Z70Gh5Z++81KUI+Fwm7MmO8Pt7gpJ8q13cF4P1ZkSXT
 B0x/lDjL6NTwm4YwM/0wlaAKJTUem/DpgVEYEgp2xHlgScM67Yh4UlnAilB/k3ai/FTm
 u/Htv/uCGmWGsybjXqGK5xB6DxS/yHg+eLtqBpitTthtV9Ym6KHKsrMuV5+wGLe9RFN6
 KXOg==
X-Forwarded-Encrypted: i=1;
 AL+hErH4pVrIh3gUG5h7hkPQY+zahc2ZkRJCVcB5MxxkU5KkR+GeNzyLW0EEyR+VroChp8SB0EIaw5ls8KlI@nongnu.org
X-Gm-Message-State: APuU4Z+sNbu7CMUizkNmK8BjERtfroxuZzY5CgP6fHW8HuM5B0eGVyk6
 X+XES1aO130prwi/PwFLDq88mfwsjV6quXIKzn4FxQzZFPi4/Hw2z1etpSeGO7EMjx4=
X-Gm-Gg: AYBFou3Euua515di21eOj51S2NUdW2B93U+9fTl1Gz071NIfm05K4XucZgl8jn6f5/p
 qB3RXdB3fra+JnkIe4C4SJLaB6nnh+ADvPcQGCMaIK8W4y7fuc2Rs/6YRhmRASj8vdLSZei2Vyq
 VS5bkICp8xfQ6raiBWhtcb/k0E3Y04I1ptQj5MrhcU0eXIqcKlsCfoMP61n92jAedYN8e3FuHCr
 hG7nfYXSKMNWTIHwQhNWfNTHNTYR9o1bVQbPHmfYKgeL3GOPAMx8fe8fMvZ0JwZmcbf4Ny6v4l7
 bibE+cWlR+yQfUCKazy4ycsHKnb7RtInBfGdGu6teDFDpayWw86X97hPA7DXfl91lah2v+WI68o
 FqzC0XAlXCTlxKeOWYRUFX8t2+Hh1cRhQk9u9xqe0SLUayTUMmojlKLjwQ8VCev/7WK8ljfzpYc
 AE8K9fxgdrUeUKaWe4WLBgxQxd3aclRC/9XpHY7mv0Dtj9Kf3Muo0GQC6CbHgrarmaJqlA9v5jU
 YEC6mgM0sPoDm4xHuFabvNJcDqjEgF5MQBzrYD464hmqYpyOtM+0XyKXurtgpH/RosRgw8T7Yl6
 +AVrY3VSyqqwURy3LzYUpQ3dhf0sat9eBveE347laFKnHdCIDyrkufKqoX4+8yI6efSjv2k=
X-Received: by 2002:a05:6a00:438b:b0:878:3538:8f7a with SMTP id
 d2e1a72fcca58-8c87ca5055dmr436632b3a.40.1795113697843; 
 Thu, 19 Nov 2026 10:41:37 -0800 (PST)
Received: from [192.168.0.4] (174-21-68-150.tukw.qwest.net. [174.21.68.150])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-8c872e4c43bsm295822b3a.26.2026.11.19.10.41.37
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 19 Nov 2026 10:41:37 -0800 (PST)
Message-ID: <d2768b66-5a60-4efd-b75d-9c4904f46faa@linaro.org>
Date: Thu, 19 Nov 2026 10:41:35 -0800
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 19/19] target/mips: Do not negate NaN results in NMADD.fmt
 and NMSUB.fmt
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>,
 qemu-devel@nongnu.org
Cc: Jiaxun Yang <jiaxun.yang@flygoat.com>,
 Vince Del Vecchio <Vince.DelVecchio@mediatek.com>,
 Faraz Shahbazker <faraz.shahbazker@mediatek.com>,
 Aurelien Jarno <aurelien@aurel32.net>,
 Milica Lazarevic <Milica.Lazarevic@Syrmia.com>,
 James Hilliard <james.hilliard1@gmail.com>,
 Aleksandar Rikalo <arikalo@gmail.com>
References: <20261113161158.25811-1-philmd@oss.qualcomm.com>
 <20261113161158.25811-20-philmd@oss.qualcomm.com>
 <3d021b3f-fdd0-4c83-8b3c-3924a5cb42d8@linaro.org>
 <53dcc9c6-474e-430c-abbf-0b667675a497@oss.qualcomm.com>
From: Richard Henderson <richard.henderson@linaro.org>
Content-Language: en-US
In-Reply-To: <53dcc9c6-474e-430c-abbf-0b667675a497@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::42a;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x42a.google.com
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
X-Spam-Status: No, score=-12.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,MAILING_LIST_MULTI,SPF_HELO_PASS,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On 11/19/26 04:04, Philippe Mathieu-Daudé wrote:
> On 17/11/26 20:37, Richard Henderson wrote:
>> Isn't the larger problem that this should be using a fused multiply- 
>> add via float64_muladd, and thus the negation via 
>> float_muladd_negate_result (which will not affect NaN results).
>>
>> Certainly MD00087 says the product uses infinite precision.
> 
> MD00087 says the opposite for NMADD/NMSUB... Vol II-A rev 6.06,
> NMADD.fmt (p.376) and NMSUB.fmt (p.378):
> 
>    "The intermediate product is rounded according to the current
>     rounding mode in FCSR [...] The results and flags are as if
>     separate floating-point multiply and add and negate instructions
>     were executed"
> 
> The infinite-precision-product wording is from the Release 6
> MADDF.fmt/MSUBF.fmt (p.324), which the same manual describes as
> replacing the pre-R6 instructions that were "unfused multiply-add,
> with an intermediate rounding".
> Those are already implemented with float_muladd (float_maddf_*/
> float_msubf_*); using it for NMADD/NMSUB would remove the required
> intermediate rounding and change Inexact in double-rounding cases.

Weird.

MD00087 rev 2.00, p269:

The value in FPR fs is multiplied by the value in FPR ft to produce an 
intermediate product. The value in FPR fr is added to the product. The 
result sum is calculated to infinite precision, rounded according to the 
current rounding mode in FCSR, negated by changing the sign bit, and 
placed into FPR fd. The operands and result are values in format fmt.

Hmph.  rev 5 adds the language that rounds the intermediate product.
Oh well.

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~

