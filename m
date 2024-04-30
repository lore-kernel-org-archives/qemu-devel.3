Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D7049C4345F
	for <qemu-devel@archiver.kernel.org>; Tue, 30 Apr 2024 23:02:17 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s1wU9-0007iX-4d; Tue, 30 Apr 2024 19:02:05 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1s1wU4-0007hN-MS
 for qemu-devel@nongnu.org; Tue, 30 Apr 2024 19:02:00 -0400
Received: from mail-pf1-x42d.google.com ([2607:f8b0:4864:20::42d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1s1wTy-0007Dm-Vh
 for qemu-devel@nongnu.org; Tue, 30 Apr 2024 19:02:00 -0400
Received: by mail-pf1-x42d.google.com with SMTP id
 d2e1a72fcca58-6f26588dd5eso5354524b3a.0
 for <qemu-devel@nongnu.org>; Tue, 30 Apr 2024 16:01:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1714518113; x=1715122913; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id:from
 :to:cc:subject:date:message-id:reply-to;
 bh=GT28dIlm00nmvPFYTKfVLKxpdFdz+PopsyCVy4D06vo=;
 b=E6uVOFyKOujqs8mhHWC7ZMz+Hu8XY0qziMnw2NhB3IKCXeJr33KYMsuaSNm/4qv8c/
 uHaj4LZM/fvCJnxzCL7ak/1Swl3AFLOttRSKYteshH+Zt85QssBfJFHEQdsSkEF4Lb0a
 bJItg99QUlCKalowcPPJxLbhH8wQmhdXrAqUEAta1Oszcj1RiC81P/YUYmRs1fkApCJu
 ZZrElFi0mmQvkavgFHRSBVHjwQVYimDDkFlPrR9P0g9LIAR9qaYbcOAmKmoYDuswttze
 /RbevDGscHA0BNLKnDJLhY72a7cWhw7UkFgi2GpWEKbW72iaYvxE0KKC6VW8K7iFEhog
 I9mQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1714518113; x=1715122913;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=GT28dIlm00nmvPFYTKfVLKxpdFdz+PopsyCVy4D06vo=;
 b=BZlk7F1H7POR/Z52NDSaeRu8dON4/eD4AGCZKeUNXiIYQWCwsL5r8bHPmd+cKhh3QJ
 GfLGz/8nha6o/g6DWBaNu4xUoFVeH+620D1iMVniH64w42HVI3Brb2ZftIu9Vkt9qlEE
 3mCtDUodTkmEcrq4A+Tx0ac28Qu3azCprxk5jPYHL0WNad0DlL79CBavo4vP6OljZK6O
 M8JbU5n3jaf88BvchDnkpm9G/e2IdBpT+uKrDu4n4JYclMSiiFip8IjZuFlauYwZSFx/
 d0ZBLK3qKJxYmkL4noSgtgEN/265tpBgQuYbdKmIQuleDJ4IMDUIEhxANpGCmEiZgZF0
 4GHg==
X-Forwarded-Encrypted: i=1;
 AJvYcCV1n3Ddqcqq8thO38n19D0rmb4EK13gjprZ+8w6Sg++mea12f1VASo4q7AyBSP88atnQgzjhcE0/8qVR/NJhxto3BY5B1Y=
X-Gm-Message-State: AOJu0YyQ5f81yPcP/NtmmddvL9WDVH+sRcAgqmcXRtcyFumUo0KnoNxN
 DqpmlNiS44+FH5y/q60p2GjuLiJczvoDskIESi61RvHZ2LoPXbUAdIgAftLnANtvWbUR2hRseot
 2
X-Google-Smtp-Source: AGHT+IGm6ClBiDyUQ1FyJg+aSNnyn1xIPbvsiqaECVpYlJsmEx2Z5gti4rybj8SJ/0SFrWQPL5/I4Q==
X-Received: by 2002:a05:6a21:2d05:b0:1af:3a17:6545 with SMTP id
 tw5-20020a056a212d0500b001af3a176545mr911482pzb.12.1714518113592; 
 Tue, 30 Apr 2024 16:01:53 -0700 (PDT)
Received: from [192.168.0.4] (174-21-72-5.tukw.qwest.net. [174.21.72.5])
 by smtp.gmail.com with ESMTPSA id
 c5-20020a170903234500b001ec36b6b28csm2213914plh.266.2024.04.30.16.01.52
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 30 Apr 2024 16:01:53 -0700 (PDT)
Message-ID: <a32a6245-8cef-4ef7-8d9e-39b289bb4191@linaro.org>
Date: Tue, 30 Apr 2024 16:01:51 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PULL 00/21] target-arm queue
To: Peter Maydell <peter.maydell@linaro.org>, qemu-devel@nongnu.org
References: <20240430164842.4074734-1-peter.maydell@linaro.org>
Content-Language: en-US
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20240430164842.4074734-1-peter.maydell@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::42d;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x42d.google.com
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

On 4/30/24 09:48, Peter Maydell wrote:
> Here's another arm pullreq; nothing too exciting in here I think.
> 
> thanks
> -- PMM
> 
> The following changes since commit 5fee33d97a7f2e95716417bd164f2f5264acd976:
> 
>    Merge tag 'samuel-thibault' ofhttps://people.debian.org/~sthibault/qemu  into staging (2024-04-29 14:34:25 -0700)
> 
> are available in the Git repository at:
> 
>    https://git.linaro.org/people/pmaydell/qemu-arm.git  tags/pull-target-arm-20240430
> 
> for you to fetch changes up to a0c325c4b05cf7815739d6a84e567b95c8c5be7e:
> 
>    tests/qtest : Add testcase for DM163 (2024-04-30 16:05:08 +0100)
> 
> ----------------------------------------------------------------
> target-arm queue:
>   * hw/core/clock: allow clock_propagate on child clocks
>   * hvf: arm: Remove unused PL1_WRITE_MASK define
>   * target/arm: Restrict translation disabled alignment check to VMSA
>   * docs/system/arm/emulation.rst: Add missing implemented features
>   * target/arm: Enable FEAT_CSV2_3, FEAT_ETS2, FEAT_Spec_FPACC for 'max'
>   * tests/avocado: update sunxi kernel from armbian to 6.6.16
>   * target/arm: Make new CPUs default to 1GHz generic timer
>   * hw/dmax/xlnx_dpdma: fix handling of address_extension descriptor fields
>   * hw/char/stm32l4x5_usart: Fix memory corruption by adding correct class_size
>   * hw/arm/npcm7xx: Store derivative OTP fuse key in little endian
>   * hw/arm: Add DM163 display to B-L475E-IOT01A board

Applied, thanks.  Please update https://wiki.qemu.org/ChangeLog/9.1 as appropriate.


r~


