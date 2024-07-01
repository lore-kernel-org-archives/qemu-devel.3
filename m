Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DBF9CC2BD09
	for <qemu-devel@archiver.kernel.org>; Mon,  1 Jul 2024 22:21:13 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sOPNK-00076I-VA; Mon, 01 Jul 2024 18:19:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1sOPNJ-00075s-22
 for qemu-devel@nongnu.org; Mon, 01 Jul 2024 18:19:53 -0400
Received: from mail-pl1-x635.google.com ([2607:f8b0:4864:20::635])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1sOPN9-0006a3-St
 for qemu-devel@nongnu.org; Mon, 01 Jul 2024 18:19:52 -0400
Received: by mail-pl1-x635.google.com with SMTP id
 d9443c01a7336-1f480624d0dso27426725ad.1
 for <qemu-devel@nongnu.org>; Mon, 01 Jul 2024 15:19:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1719872382; x=1720477182; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id:from
 :to:cc:subject:date:message-id:reply-to;
 bh=MclgBFNQYRKnTqxDdvpQqwi6L02hTB/dHZin+eRgaXU=;
 b=t1HQ5gqBiFwbPN76S1XmfQQ0Bh3hCmgnVwlch7AizmUjZyGKSVUDmIh7kBqrH29FeQ
 MVjs32mQsPKORruuyeaEDjtf9T5porlMdlt+MG20Ng+SFeoB2qNzxcHynC5slChf6sqg
 AWgEZG+jAOZPiz4wksEoi02xo6ZQAwd3O9svPmCTl8a80xj3nPP743VZNO8YnwgGHBx3
 Rbu6wNAr29FLTvXqBR9G5fjGUw6VqJGwBLJEtwcMXhppIlpi8btU333guVlfKXwch8kG
 JEwd0E/xtCLdLiwfqr/T0po/6MQ8WkH5uXCz0Ey4YX9uZym6rHMQFgC7J4rxNd5omitC
 yRwQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1719872382; x=1720477182;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=MclgBFNQYRKnTqxDdvpQqwi6L02hTB/dHZin+eRgaXU=;
 b=tcrAHn7BJ4XTjFMAQ7d3tipqQmqopGkbZN6cRp6iB6gJNxnKCPk00af0O6iJUgEQ+T
 5mKMV4irKd6uDWeIv0jZNImz7wT32PBrJML42AJ5ewcEiEWjD636Gt4EKuX0sVoJSGW3
 b1icqNdggtdFNop3NfDL4ft4WQxQ2QkIzWWDupXJLinUOL087+zAVcw8zqXgrZM1BIF4
 mRwjowtB0V8xzpYNlUO9OQY5LqbnTwrfGpuezh4u/blLCxrPY5OQ860dSfg9qSp+K4om
 t6UJ0bYrEdR4VOr0RA08nwYGGVHCoEbGd79D1B0hBxzTpyNoQc6RuN3IQ8LnbikmbBDO
 TeZw==
X-Forwarded-Encrypted: i=1;
 AJvYcCU0x+RC/USEtWAKkqqFcCt3rnetV3wJBdtw6ICYXwEMgMIFQ4cX2MHZwJCVrqT2ZTH061zXqDEf9Dj39je8lSSkVCkPvqo=
X-Gm-Message-State: AOJu0YwTW75z5mRg5lOJVUt+GreGQzDfOKv9xHc9GMKuuWS7wiDtLqPI
 tMXsdx3WAwUFRq1Aq8O/rDXXY9BvuTname9we2hZLtsIqrMMHkOOSrPMoLGuR9A=
X-Google-Smtp-Source: AGHT+IELH7jc7tAGH5lMjuIHU7dM8NAyeNBoOnqBhqSw4mdm+ZfyPtFWZbABvlcsTmesyyz+KSpLNg==
X-Received: by 2002:a17:903:2346:b0:1fa:2b89:f549 with SMTP id
 d9443c01a7336-1fadbc5c20bmr67213775ad.10.1719872382079; 
 Mon, 01 Jul 2024 15:19:42 -0700 (PDT)
Received: from [192.168.0.4] (174-21-76-141.tukw.qwest.net. [174.21.76.141])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-1fac10c8d8esm69768895ad.47.2024.07.01.15.19.41
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 01 Jul 2024 15:19:41 -0700 (PDT)
Message-ID: <8c67b71d-27dc-4d47-a310-be321795bdbe@linaro.org>
Date: Mon, 1 Jul 2024 15:19:39 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PULL 00/29] target-arm queue
To: Peter Maydell <peter.maydell@linaro.org>, qemu-devel@nongnu.org
References: <20240701160729.1910763-1-peter.maydell@linaro.org>
Content-Language: en-US
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20240701160729.1910763-1-peter.maydell@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::635;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x635.google.com
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

On 7/1/24 09:07, Peter Maydell wrote:
> The following changes since commit b6d32a06fc0984e537091cba08f2e1ed9f775d74:
> 
>    Merge tag 'pull-trivial-patches' ofhttps://gitlab.com/mjt0k/qemu  into staging (2024-06-30 16:12:24 -0700)
> 
> are available in the Git repository at:
> 
>    https://git.linaro.org/people/pmaydell/qemu-arm.git  tags/pull-target-arm-20240701
> 
> for you to fetch changes up to 58c782de557beb496bfb4c5ade721bbbd2480c72:
> 
>    tests/qtest: Ensure STM32L4x5 EXTI state is correct at the end of QTests (2024-07-01 15:40:54 +0100)
> 
> ----------------------------------------------------------------
> target-arm queue:
>   * tests/avocado: update firmware for sbsa-ref and use all cores
>   * hw/arm/smmu-common: Replace smmu_iommu_mr with smmu_find_sdev
>   * arm: Fix VCMLA Dd, Dn, Dm[idx]
>   * arm: Fix SQDMULH (by element) with Q=0
>   * arm: Fix FJCVTZS vs flush-to-zero
>   * arm: More conversion of A64 AdvSIMD to decodetree
>   * arm: Enable FEAT_Debugv8p8 for -cpu max
>   * MAINTAINERS: Update family name for Patrick Leis
>   * hw/arm/xilinx_zynq: Add boot-mode property
>   * docs/system/arm: Add a doc for zynq board
>   * hw/misc: In STM32L4x5 EXTI, correct configurable interrupts
>   * tests/qtest: fix minor issues in STM32L4x5 tests

Applied, thanks.  Please update https://wiki.qemu.org/ChangeLog/9.1 as appropriate.


r~


