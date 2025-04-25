Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8356BC369C2
	for <qemu-devel@archiver.kernel.org>; Fri, 25 Apr 2025 19:45:31 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u8Oyx-0004xp-1p; Fri, 25 Apr 2025 15:45:07 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1u8Oyr-0004tw-1p
 for qemu-devel@nongnu.org; Fri, 25 Apr 2025 15:45:02 -0400
Received: from mail-pl1-x629.google.com ([2607:f8b0:4864:20::629])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1u8Oyl-0007qR-3l
 for qemu-devel@nongnu.org; Fri, 25 Apr 2025 15:44:58 -0400
Received: by mail-pl1-x629.google.com with SMTP id
 d9443c01a7336-22c3407a87aso42237285ad.3
 for <qemu-devel@nongnu.org>; Fri, 25 Apr 2025 12:44:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1745610291; x=1746215091; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=AHdOTPefrO61NwJ4vi2YUXugsGVqBSpa5jUSMFJWoLs=;
 b=qjenLSz3odC+jl1VDN0DDWxcmMvW93FKlb1lPTPQlXUiIpPnT1njKaPpMftIfU4iAy
 kwKqySkYDRKiGaV7L6wu5gNPTkhMQh0iA5l0yHwgA4ECC4Dk9miv0TXTts0LrmRSdQQ6
 zJFCRqpC9NB+H0Lup0wvVRGkCHbNFh3j77yEzvP2b21GVbAwd/PGzeyWzNEvpscYOp4w
 Sd+AgZlPKC01zgylwqMZajED6pXP2mKV2N4jve05U49oqrVVjL46+YnEtGD9GLDQe/fB
 em36MryZnDgDtHtVszEj0X5uVAuqf25EMlTCqqvqt3TPQarfjyaeRdx6HM/xUtpT6hWv
 1cow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1745610291; x=1746215091;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=AHdOTPefrO61NwJ4vi2YUXugsGVqBSpa5jUSMFJWoLs=;
 b=TF50yFO0blaDc4qPyS0Dq9XOUT8J0r623L2lxBpVy9HLN+GNvo9+wTrwaoBafGAUup
 Hkg/76V241vMRk11a1nu2fVaZDGG0DAVAqqPV/69W7/JhfiNulcJyticRyNJspdrQRHu
 HsgY46fKs7YuzLVxIqzJbfeVe7a/h7IEjwFN9P//qw8WFkmjoaaLfHHrTcXEP4nbEiVQ
 coM36xOXE5kYKTNAQg3/AEe3LzdFstVv8I8MgylSYLfdTafe9p5yKTq89mToBmW5vLGP
 CdENMw+wtDKZQgSx4M8pQaJr8I1osZMSJx8Bzb9hh9HP1RGjg/nzMcbumpcx0dbccxMq
 Fm9g==
X-Forwarded-Encrypted: i=1;
 AJvYcCU6U0Ybj2fTjJjMC0pZjXgiAI/ys+TD+lC8HN9riENAFILmvzC55rKvmcJhWcC5NwpeBRy4msQgi31h@nongnu.org
X-Gm-Message-State: AOJu0YwUiG1qlr8vZRRDFyTbB4NNwBIk8i2t1p5lD/OQISIPtDN+LDre
 iAwEfh6a8hvAvg0Zh6nIEJsHM5+hoR5iDJSsfZmdAh8vgWRCj1h4zEjQmPqIn5Ck/i+FrasqyyB
 cNoem8g==
X-Gm-Gg: ASbGncsplC1BAVKnycob6/B0BIuhOfHLQi0EghShm+pywoQJQ38TNUk8Qzp01Yk3pNi
 U3S6W8dPgZ2EzHG9GWRx6vh0ftXRxXNchquVK1SA5aCQeJPa9fBpbMzeh/Y5IdXxaH8fGN2tiAs
 AtzSKwbNHqqrNmhqFUXICOb5jZLS8iEG555Ag3vSy0a1OLvYlz0LpG2bgBt1+IMLkzOUAC36Jmg
 dKaBs7yBvQDWCO/9dACtZTXqWZESM4wvmFDSncoLi6paJEF8ci4eXwK9t930xrVZwCkZym3HamY
 0fhtERC3mHFyagqbwkEAM3IVmza3Hge4jMwLOq+wG4PHpLcq7raVsg==
X-Google-Smtp-Source: AGHT+IHLyYxPtP2extltigty8VfORaUFv5O83rEs1So0Si47v4SMhRUv1J0nLiGDN4cQnZi3P5C7Tw==
X-Received: by 2002:a17:903:18b:b0:223:5ace:eccf with SMTP id
 d9443c01a7336-22dbf5fa8bcmr52715455ad.25.1745610290891; 
 Fri, 25 Apr 2025 12:44:50 -0700 (PDT)
Received: from [192.168.1.87] ([38.41.223.211])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-22db4d76f7fsm36769695ad.33.2025.04.25.12.44.50
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 25 Apr 2025 12:44:50 -0700 (PDT)
Message-ID: <bc7f35ec-d562-434d-b0c6-2fb1ad2b5afe@linaro.org>
Date: Fri, 25 Apr 2025 12:44:49 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 12/15] accel/tcg: Use vaddr for walk_memory_regions
 callback
Content-Language: en-US
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
References: <20250424011918.599958-1-richard.henderson@linaro.org>
 <20250424011918.599958-13-richard.henderson@linaro.org>
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
In-Reply-To: <20250424011918.599958-13-richard.henderson@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::629;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-pl1-x629.google.com
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

On 4/23/25 18:19, Richard Henderson wrote:
> Use vaddr instead of target_ulong.  At the same time,
> use int instead of unsigned long for flags, to match
> page_set_flags().
> 
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>   include/user/page-protection.h |  4 +---
>   accel/tcg/user-exec.c          | 10 +++++-----
>   linux-user/elfload.c           | 19 +++++++++----------
>   linux-user/syscall.c           |  8 ++++----
>   4 files changed, 19 insertions(+), 22 deletions(-)

Reviewed-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>


