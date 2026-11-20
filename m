Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 59623606A6DD
	for <qemu-devel@archiver.kernel.org>; Fri, 20 Nov 2026 19:40:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256 header.s=google header.b=EAJt1ys2
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xUUTA-0001lf-V2; Fri, 20 Nov 2026 14:40:24 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1xUUT9-0001j8-Gq
 for qemu-devel@nongnu.org; Fri, 20 Nov 2026 14:40:23 -0500
Received: from mail-pg1-x535.google.com ([2607:f8b0:4864:20::535])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1xUUT7-0001br-ON
 for qemu-devel@nongnu.org; Fri, 20 Nov 2026 14:40:23 -0500
Received: by mail-pg1-x535.google.com with SMTP id
 41be03b00d2f7-cd61cef87f1so711935a12.0
 for <qemu-devel@nongnu.org>; Fri, 20 Nov 2026 11:40:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1795203620; x=1795808420; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=43AJsRYeQzJj0XCASFj/qvKHJk5o7oxzyS5SO1D/nuc=;
 b=EAJt1ys2ysSSACH8ICOP744DMzZ3i8tK/EB+lvMTL5Ed6oCOpX8olXSokLAOXlhg1U
 41Wp01pN5/1CzNXjyq9DTdiKNemcLWKhulhibE/Q6oyViHG+YM0YF8G6zJkEAxXQhIs9
 7nvfGVl1RK4XBph6VMYcrwW+4tTPL11dpD+ApnPZApQGbN05klNqA7RPbz3lwtOBCKXO
 CZYO+yeDIEh68eohLKMjdB5i5I8BEBom+OkDt4QPWHB7bHnd1ngBKDfk5HeDulbgBiPI
 nzv2LASL0Shu2+tTsMrdp6BLjoG0y2JmW8ISzYvCWp9H1b+dfHfdWM5nTbiiANwM1Wa1
 H3OA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1795203620; x=1795808420;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=43AJsRYeQzJj0XCASFj/qvKHJk5o7oxzyS5SO1D/nuc=;
 b=GloYIqs0A+5iMG9WXl1XgLdZ2GK2+ZxgcFTAK/MKAe822/RRb3C8yecAV9ZuR2GjLQ
 k3Nn1ATtpc8W80rrrzCpMvCVWuUP7mDTVoSAtAaak8aixkGkTRuPXGFJWGKH4WLcb0WZ
 mpqa2c9uO9MqLtVdMRzWEuNQnjmDGLKCzD19863LElu4HhhdyHJHqLmOoG3kYmofAIss
 5WPZClunBrrJqJf60u3it7HMKmzLS9Rontn0u/VAUBwMALfBsNjcNthH6EaQ8kAYTP+a
 YKsqmqLO/mqdYpJ1x1m/YsKVi9TiPoR7Kv0/bqrBpCZSANZXjX9y1LdTAFrs/2K4JFYQ
 R5qQ==
X-Forwarded-Encrypted: i=1;
 AL+hErHDIkzcVb+bjmUjxYf95+OIsporfGNYSmaOVQMdBCNJHCaxjlewSlku0QYXSeNcDunchmtsoCZNm3e1@nongnu.org
X-Gm-Message-State: APuU4Z/mlOEC5LYC66DfWI5IsAwQN4CwROX/V4cMlOAb45S3499FCMzQ
 9acTLlVKMOaYd+5N46h6nV8sFI5hBrquN1H7STN/+2gS3m0exIEpLBqhuhfm0R7Sm3o=
X-Gm-Gg: AZFdTZf6m8AcsO2ZhZO8OhSQZkABh4sazNl7Y6Xv8b5Xf+mqIDBc+11ntvy0YjYT3Y7
 FsnrycXMXgVFdv0REzUkEB5vl5dD+9oIQA7eEw5ZXoAu2W8ZPpmaOFKyUPdxcIEOKcMsZUbZvHU
 u+mkZk8E9A7CW920hYv6FzO9vgiBSipjE1ottnQf8mVkanqCND+Xf0MJ4D1dAqfS1sz9fcta1CU
 eccIWnZAOOHsixqJpU2u30J6i+o0HXNiTJQHD7wR3M3N3xxJmNyF66zkkKnJnTIiSyWNd90rYGB
 fPvTApe9xciB6RxumUDmTI0xDRO2qXnAANbIAmqUXqmGbX6SXQEqRFEpXcY7meqGMIwIGYn9Zx2
 dapsMlqst4R2I9Yu/DwEtHu1J2ppCcuNztMBFzr838hnlM+sWoFnvYeJ9AGD5c0/dwfZVqMoeFN
 bmTybM3NasItlsDRrVsXgDA5l7SgpF7DuTHyK8UVL9nIg5FcmqwZlZsioD/SRQhnlxJdkyXpkKC
 UcWoFZhU7dvW9kVj19Cus88I6VANzPSxQZzmEBl+dJgtWIKU05ZZcc+HTDl6iJBvndWsA7HilEn
 KhjfHlZT//XSWd/RQUokINyKeECvgyO18F6icAcc+R/v0WHcnhbUfx8achLi87oszDstMps=
X-Received: by 2002:a17:90b:2585:b0:3ac:a11a:7c7f with SMTP id
 98e67ed59e1d1-3b41c9cd182mr3638997a91.23.1795203620185; 
 Fri, 20 Nov 2026 11:40:20 -0800 (PST)
Received: from [192.168.0.4] (174-21-68-150.tukw.qwest.net. [174.21.68.150])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-3b405d11753sm8582106a91.5.2026.11.20.11.40.19
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 20 Nov 2026 11:40:19 -0800 (PST)
Message-ID: <3d9b1b6c-4edc-4b21-9708-aa656ca75935@linaro.org>
Date: Fri, 20 Nov 2026 11:40:18 -0800
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 4/4] target/arm: Kick other vCPUs on SEV under TCG
 round-robin
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>,
 qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>, Ashish Anand
 <ashish.a6@samsung.com>, Peter Maydell <peter.maydell@linaro.org>,
 qemu-arm@nongnu.org, =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>
References: <20261119225514.4080-1-philmd@oss.qualcomm.com>
 <20261119225514.4080-5-philmd@oss.qualcomm.com>
From: Richard Henderson <richard.henderson@linaro.org>
Content-Language: en-US
In-Reply-To: <20261119225514.4080-5-philmd@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::535;
 envelope-from=richard.henderson@linaro.org; helo=mail-pg1-x535.google.com
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

On 11/19/26 14:55, Philippe Mathieu-Daudé wrote:
> In round-robin (single-thread) TCG, all vCPUs share one
> host thread, so qemu_cpu_is_self() is true for every vCPU.
> 
> The SEV helper used it to skip the kick of the issuing vCPU,
> and so skipped it for every other vCPU too: a vCPU sleeping
> in WFE is only woken when the RR kick timer fires.
> 
> Compare against the issuing vCPU instead.
> 
> Fixes: d238858bff60 ("target/arm: Implement WFE, SEV and SEVONPEND")
> Signed-off-by: Philippe Mathieu-Daudé<philmd@oss.qualcomm.com>
> ---
>   target/arm/tcg/op_helper.c | 4 ++--
>   1 file changed, 2 insertions(+), 2 deletions(-)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~

