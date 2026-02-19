Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1A6F1C531CB
	for <qemu-devel@archiver.kernel.org>; Thu, 19 Feb 2026 21:07:00 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vtBEb-0006Du-1w; Thu, 19 Feb 2026 16:06:53 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1vtBEZ-0006Bs-Kw
 for qemu-devel@nongnu.org; Thu, 19 Feb 2026 16:06:51 -0500
Received: from mail-pf1-x431.google.com ([2607:f8b0:4864:20::431])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1vtBEX-0003MX-09
 for qemu-devel@nongnu.org; Thu, 19 Feb 2026 16:06:51 -0500
Received: by mail-pf1-x431.google.com with SMTP id
 d2e1a72fcca58-824c9da9928so736159b3a.3
 for <qemu-devel@nongnu.org>; Thu, 19 Feb 2026 13:06:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1771535207; x=1772140007; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
 :to:content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=diiJOp40SvLWp+GaVGZM1Zyt7MmkZLCdFLF81Ga31RA=;
 b=s+wFvkj0d4f+oDZiFj4G1l9AMt2SvXgSEOIH4vVvOpuT6pvgaY7tKdIDAyq4X5gx+g
 n5s2/cwNMTY53L4yaYQy48FfCtxl8No3xdf1tjYB61Yo0oMXf0AIL/+/28qSjEM0jub0
 6xsmir/HEieK+c3M/IHV/A6oKzcBAxzNXj3dE4jjxKpL+Ao2WAb61eklFjqdlRAmtdou
 k3Tyjy9mLBGnV6eruwH8Wn09ip5Q0G2GoLq5r3hYkamFN8XFIZzB25tBZpN1eWo5HLUL
 iS4Luy7Ml33AO0swM9WpfcwxXkZ5KDRmEnVQElbr2VdveIO2xik024X+AFd0ejRrLUfF
 RaBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1771535207; x=1772140007;
 h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
 :to:content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=diiJOp40SvLWp+GaVGZM1Zyt7MmkZLCdFLF81Ga31RA=;
 b=DhvSGp7gqWhA9B7olea9GltZfYFlOfZa3d7PJN18DuQEKQk9arC2HAfGryn6Tdng4M
 YcFH25CSPz+z/b4NyMOAC5VwSnB5hlHIcXnGQ84r0rLOE84nGGCfkde/6QummqagqXxr
 np5qWSaO+zTvqLvSMQqeCY19aCVlYsMJrtXxqo63HHnnGt/Q0jDFKvmAksbQOCUg/PCT
 Au/mSktffRIKaLPK/nt7YlLpAsRbfPw7FN/SaODMsDVb6NXgMF1DSQHX3V2qjwlCy4DK
 gHyM9OQ17ZCFudjElyl/YnwfA8XyzHURz6QSFr5DeyPuo3HHm/GIiVcdG6PUtXJPjd2E
 ZkQA==
X-Forwarded-Encrypted: i=1;
 AJvYcCVb0kk+eOThNiC/mN5F0ahnSYFBqIYFquc8YqhaGRd5RxWJ4VSHcm2/wdh+Nv9XVuchhmzjIhqfjN+C@nongnu.org
X-Gm-Message-State: AOJu0YyWmS1e/TTXzwR2spbeAIcyf/1XGihg7O6zBuwdq+6mqvs/D1KJ
 ub34/wN/2BQ6R18FT4wxmm2+IsyVhJFsi1CsxpjdsgwHeJ1qqsXzj2nFrdlEwwa4BBc=
X-Gm-Gg: AZuq6aJbBjUitO2MnumSO56s2k0LbrHdeaJAsJJyjZTPrHG+OecPFfIU8PNITbYPFey
 bdjyZx0FKqz9GH3zbEOod2/zmBUFY30hBJDDKyQ1vL5CajwGPSEYPLBz0MyKvMtAP5VP2iUfHCj
 3XFdLsZ9Dr4g3J/R3d0JdCNgFrfaMkOIjrSp1R6SCmuM9gyJ2CnEElUCHCUP3q96gR+GtW4vdZk
 GMvh/exWVifTsu5FQEnm6gPEtrMNmZHK+lJx/tK5rl/YoXAyRVXQZaZ3teIG+6oFZeyDBLAWrC9
 81oBF8NMSHb0gNBW3bBodD9VTeHLCBOaoMhvCQRmowtmwir4hRLkzMbzu3F+sroXlDgJbWkCodC
 QbEtHfOLxWiCIwPw3KfYrBG5HjQxCSAX68MnpL0/aAwhDrnn3pJIe5I50i+dnJKmWNN2yXWMpl+
 zigm5dAye2NF7kGz60coO5GJKASwK983v5DlDqjeFe16bzzlV+6R4rkwCjLkfBBXlfWWjh22Je1
 mFSIhM=
X-Received: by 2002:a05:6a00:2c85:b0:81f:4675:c2a7 with SMTP id
 d2e1a72fcca58-826b68ddb6dmr2792402b3a.55.1771535207501; 
 Thu, 19 Feb 2026 13:06:47 -0800 (PST)
Received: from [192.168.1.87] (216-71-219-44.dyn.novuscom.net. [216.71.219.44])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-824c6bb5596sm20063188b3a.58.2026.02.19.13.06.46
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 19 Feb 2026 13:06:47 -0800 (PST)
Message-ID: <9df817da-7c18-4ed1-8ad2-2c4ce98849fb@linaro.org>
Date: Thu, 19 Feb 2026 13:06:46 -0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 08/50] target/ppc: Remove dead code depending on
 USE_APPLE_GDB
Content-Language: en-US
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org
Cc: Richard Henderson <richard.henderson@linaro.org>, qemu-s390x@nongnu.org,
 =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>,
 qemu-riscv@nongnu.org, qemu-ppc@nongnu.org,
 Nicholas Piggin <npiggin@gmail.com>, Chinmay Rath <rathc@linux.ibm.com>
References: <20260219191955.83815-1-philmd@linaro.org>
 <20260219191955.83815-9-philmd@linaro.org>
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
Autocrypt: addr=pierrick.bouvier@linaro.org; keydata=
 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
 ZtfdHNZotF092MIH0IQC3poExQpV/WBYFAI=
In-Reply-To: <20260219191955.83815-9-philmd@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::431;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-pf1-x431.google.com
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
List-Id: qemu development <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

On 2/19/26 11:19 AM, Philippe Mathieu-Daudé wrote:
> We never defined USE_APPLE_GDB, so the code introduced in commit
> b3cad3abf6d ("PPC: Add support for Apple gdb in gdbstub") is dead
> since almost 12 years. Remove it.
> 
> Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
> ---
>   target/ppc/cpu.h      |   2 -
>   target/ppc/cpu_init.c |   7 ---
>   target/ppc/gdbstub.c  | 124 ------------------------------------------
>   3 files changed, 133 deletions(-)
> 

Reviewed-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>

