Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1EA22C3064D
	for <qemu-devel@archiver.kernel.org>; Fri, 28 Jun 2024 16:07:15 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sNE7X-0001Dg-Do; Fri, 28 Jun 2024 12:06:43 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1sNE7V-0001Cy-19
 for qemu-devel@nongnu.org; Fri, 28 Jun 2024 12:06:41 -0400
Received: from mail-pf1-x436.google.com ([2607:f8b0:4864:20::436])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1sNE7R-00068P-FH
 for qemu-devel@nongnu.org; Fri, 28 Jun 2024 12:06:39 -0400
Received: by mail-pf1-x436.google.com with SMTP id
 d2e1a72fcca58-70671ecd334so644028b3a.0
 for <qemu-devel@nongnu.org>; Fri, 28 Jun 2024 09:06:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1719590796; x=1720195596; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id:from
 :to:cc:subject:date:message-id:reply-to;
 bh=HklQvYOQqBccF+QXOx59MrZwyVotJY12tRs5aXYMGfg=;
 b=JCZ3zP/WJ18efrfOXVsn9BIbLbDrMq0hc/Lt+L2PnH1vmDd/Axkfwkgqk0kUOtZIf4
 Pr8mBBy0NQT9fHg/aU11g+y7z2GMq//QZi3fC5Zi+jDv2MMI/hESgCKK/eo9ow3H1Cj/
 cylHHQXmAqb8kWjg5tHUvIMv9mOL0nMbiRj9lQqukaprV1vlBpJod4dQf2+ZFlwvTN8E
 H2GIebGtquc1pZpOD04dokKCZ7igZBPbyP/L6sx+82uGm8CdDp7iMc5mh0fvKgVZHche
 Pm4TV4MtZFoRQC66dV35JJxepN9bSKxN3NO6exPxK697OlB3Ihj25SLCdsFLaFePQEFF
 8UxQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1719590796; x=1720195596;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=HklQvYOQqBccF+QXOx59MrZwyVotJY12tRs5aXYMGfg=;
 b=sgISouNYTKXw2smuiK26Su0/hs5sy0oSKJuIEwq+fm8hf+Jr9xTBsGSoaQ4j2f5N2k
 SloJ7e+w37oVH6fQSQc9FrtivyeV6xrUefk97ZUodLgfMVoYEtzKdCGKw4fh1FLBjHCN
 efPBiYcJ/M8HH3vhRoV4mayULQWetaUw2eKQyyyACzqoWCN4CioFpFUu/z3IpLvW45U2
 z6jsa5EkQESEq2Wznoo5dAiCm9dkTpt35qDTrBvh+NGifzgoc6YiLHiocGikmZUkQsN0
 q1YMJXv2d2kl5QPMjISL2Z3FElUZwUCuQzdFX+MOkFVb9Jlzke17uX4ybFDMwO0hyLGE
 EMgg==
X-Forwarded-Encrypted: i=1;
 AJvYcCX5RRErEXU0iEezswmg541PbncKMVBEz/PQXbxtn5sGkYQ6pes8+O5rbC6ZjBdjtMT8Sbnn4iYVibWYxF+q1o1s1Bhbq3U=
X-Gm-Message-State: AOJu0Yz30NTOwEgdsWtrtgdQA72rgdf9fVfR/u1G5cJFiHNiAlOs5p9z
 strPHOj0as1NsdTPXNi2c1VfgakUAORxo2XJGGJP3bHRWYh8YwwwrVXaz1x3hTOum02jkuWd7AT
 f
X-Google-Smtp-Source: AGHT+IFctRnsZkdvAJAdY9a5FaWnQxlQPigctmtXnq1Fp454J0hal5xwPmaUmSg2OX+AlMqppCW2VQ==
X-Received: by 2002:a05:6a20:8420:b0:1bc:e5b4:8972 with SMTP id
 adf61e73a8af0-1bcf44391e5mr23402521637.12.1719590795502; 
 Fri, 28 Jun 2024 09:06:35 -0700 (PDT)
Received: from [192.168.0.4] (174-21-76-141.tukw.qwest.net. [174.21.76.141])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-70803ecf878sm1770250b3a.135.2024.06.28.09.06.34
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 28 Jun 2024 09:06:34 -0700 (PDT)
Message-ID: <851098d0-4183-468c-b5a5-458baa3892d6@linaro.org>
Date: Fri, 28 Jun 2024 09:06:32 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 6/9] target/arm: Store FPSR and FPCR in separate CPU state
 fields
To: Peter Maydell <peter.maydell@linaro.org>, qemu-arm@nongnu.org,
 qemu-devel@nongnu.org
References: <20240628142347.1283015-1-peter.maydell@linaro.org>
 <20240628142347.1283015-7-peter.maydell@linaro.org>
Content-Language: en-US
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20240628142347.1283015-7-peter.maydell@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::436;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x436.google.com
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

On 6/28/24 07:23, Peter Maydell wrote:
> Now that we have refactored the set/get functions so that the FPSCR
> format is no longer the authoritative one, we can keep FPSR and FPCR
> in separate CPU state fields.
> 
> As well as the get and set functions, we also have a scattering of
> places in the code which directly access vfp.xregs[ARM_VFP_FPSCR] to
> extract single fields which are stored there.  These all change to
> directly access either vfp.fpsr or vfp.fpcr, depending on the
> location of the field.  (Most commonly, this is the NZCV flags.)
> 
> We make the field in the CPU state struct 64 bits, because
> architecturally FPSR and FPCR are 64 bits.  However we leave the
> types of the arguments and return values of the get/set functions as
> 32 bits, since we don't need to make that change with the current
> architecture and various callsites would be unable to handle
> set bits in the high half (for instance the gdbstub protocol
> assumes they're only 32 bit registers).
> 
> Signed-off-by: Peter Maydell<peter.maydell@linaro.org>
> ---
>   target/arm/cpu.h                  |  7 +++++++
>   target/arm/tcg/translate.h        |  3 +--
>   target/arm/tcg/mve_helper.c       | 12 ++++++------
>   target/arm/tcg/translate-m-nocp.c |  6 +++---
>   target/arm/tcg/translate-vfp.c    |  2 +-
>   target/arm/vfp_helper.c           | 25 ++++++++++---------------
>   6 files changed, 28 insertions(+), 27 deletions(-)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~

