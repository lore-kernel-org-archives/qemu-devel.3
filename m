Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B03A6C4345F
	for <qemu-devel@archiver.kernel.org>; Fri,  3 May 2024 21:43:13 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s30fa-0007Ms-J2; Fri, 03 May 2024 17:42:18 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1s30fZ-0007LN-SE
 for qemu-devel@nongnu.org; Fri, 03 May 2024 17:42:17 -0400
Received: from mail-il1-x12c.google.com ([2607:f8b0:4864:20::12c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1s30fY-0001II-3Z
 for qemu-devel@nongnu.org; Fri, 03 May 2024 17:42:17 -0400
Received: by mail-il1-x12c.google.com with SMTP id
 e9e14a558f8ab-36c6e69180fso600715ab.3
 for <qemu-devel@nongnu.org>; Fri, 03 May 2024 14:42:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1714772534; x=1715377334; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:content-language:references
 :to:from:subject:user-agent:mime-version:date:message-id:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Qhs4Oke+BUAOVkCW+ZOFdOlEp8jkUJsHbBCpLZtUdfI=;
 b=qNiCNmUVRHS7vOpfyYSoTCW6tPmXorcviqzP/0MiIa5NKeE2ekfuMJqhytAAINOmF3
 LdYh2MBUNKFiy2VwjG2fY990Rjpe/2cS4vVztnmEHbzeuLwpdiYluWsomS7D+t2/KLJi
 gVPR1HlXmrHQ8TfL2WZxl85OR1ZoWgEUkoOTRXL/g6hBKdqfteLO2Iu4oPDIOq4/PCkQ
 YZ3zaSxDuIJNPF/cqQjc+ng+pr1Z7k9nbhFDRK1kKTE4KfETxmGu2iY38tmyxlgRx+jX
 48rE1B6ZNYUMTfbUs45QXWUFXN6tSYjv3VOBMetrAv8LNHhh0AViAVGdVJZXtYUiJ+er
 jpfg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1714772534; x=1715377334;
 h=content-transfer-encoding:in-reply-to:content-language:references
 :to:from:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=Qhs4Oke+BUAOVkCW+ZOFdOlEp8jkUJsHbBCpLZtUdfI=;
 b=Jr5L7mZRb60nsLph1LQqt+EH819RlPjRIIU4azfyyUxdYRQiyUpxk0rXndvXB/2PKO
 owiZMWjSK1hCpaWPsjcH67B0cIeOEe/8A4enk0703/lPV+uxpiNyUC74qqRgMsspBhyo
 vMcvBZMVXJMALgKGd8eJ5JCRF9OTBnJglQvT0OnJwNFVrujYKW8NEH2zXrTQirH/IXJb
 uP/ZHUUkzqgpr7WvjrIbf+FPYwb8vJNdB4MApsxvULaatTagcSyWlv364PvqZeDfjgDh
 OQKmtuNyK3zrUkv6/tuNickN60AsyKE2juqxfqFnkpvPMD8BNrHEI09jz/Znbzlz07eB
 SmXg==
X-Gm-Message-State: AOJu0Yxh+lwKJAl+f9gTqTlSmLTDcJ2cyeNXqFHYUOXMcESY7BkZwslx
 MpPv4osLCjtyDMfdMWWBeLxyLxrRbEGy4ZnaQ4AKw4TzJrkjgmwwVrDdzxFWe5ZSp20mrHmi1zt
 Y
X-Google-Smtp-Source: AGHT+IF5Dn+7j07UEro2XXW9IQsEonbgHGqpJyR6QZQUPhw1ZcZvNlRHsIy4DN6WciOstMCJLzrM2w==
X-Received: by 2002:a92:c56f:0:b0:36c:be3:9674 with SMTP id
 b15-20020a92c56f000000b0036c0be39674mr4558884ilj.31.1714772534551; 
 Fri, 03 May 2024 14:42:14 -0700 (PDT)
Received: from [192.168.0.4] (174-21-72-5.tukw.qwest.net. [174.21.72.5])
 by smtp.gmail.com with ESMTPSA id
 w17-20020aa79a11000000b006f4476e078dsm2361679pfj.192.2024.05.03.14.42.13
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 03 May 2024 14:42:14 -0700 (PDT)
Message-ID: <1ff93b21-4769-4253-91bc-2f17c071231a@linaro.org>
Date: Fri, 3 May 2024 14:42:12 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PULL 00/10] bufferiszero improvements
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
References: <20240503151314.336357-1-richard.henderson@linaro.org>
Content-Language: en-US
In-Reply-To: <20240503151314.336357-1-richard.henderson@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::12c;
 envelope-from=richard.henderson@linaro.org; helo=mail-il1-x12c.google.com
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

On 5/3/24 08:13, Richard Henderson wrote:
> The following changes since commit 4977ce198d2390bff8c71ad5cb1a5f6aa24b56fb:
> 
>    Merge tag 'pull-tcg-20240501' ofhttps://gitlab.com/rth7680/qemu  into staging (2024-05-01 15:15:33 -0700)
> 
> are available in the Git repository at:
> 
>    https://gitlab.com/rth7680/qemu.git  tags/pull-misc-20240503
> 
> for you to fetch changes up to a06d9eddb015a9f5895161b0a3958a2e4be21579:
> 
>    tests/bench: Add bufferiszero-bench (2024-05-03 08:03:35 -0700)
> 
> ----------------------------------------------------------------
> util/bufferiszero:
>    - Remove sse4.1 and avx512 variants
>    - Reorganize for early test for acceleration
>    - Remove useless prefetches
>    - Optimize sse2, avx2 and integer variants
>    - Add simd acceleration for aarch64
>    - Add bufferiszero-bench

Applied, thanks.  Please update https://wiki.qemu.org/ChangeLog/9.1 as appropriate.


r~


