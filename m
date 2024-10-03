Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 18AB2CF34C3
	for <qemu-devel@archiver.kernel.org>; Thu,  3 Oct 2024 19:57:35 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1swRwC-0004Ec-15; Thu, 03 Oct 2024 15:56:36 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1swRwA-0004EJ-2t
 for qemu-devel@nongnu.org; Thu, 03 Oct 2024 15:56:34 -0400
Received: from mail-pf1-x433.google.com ([2607:f8b0:4864:20::433])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1swRw8-0007a7-Cp
 for qemu-devel@nongnu.org; Thu, 03 Oct 2024 15:56:33 -0400
Received: by mail-pf1-x433.google.com with SMTP id
 d2e1a72fcca58-717934728adso1218167b3a.2
 for <qemu-devel@nongnu.org>; Thu, 03 Oct 2024 12:56:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1727985390; x=1728590190; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=1K9X+TY89oBYMX4PjqJvocsPvmc3bOMw9kZy7Pcn6xk=;
 b=uD/Bsz2xnsvI5nuWBfXspEleAa4qmA6wU9X12bPmv1yI61Q/QJsfmkzUlCVe/QVV+D
 SzjLnwPSFh7LXa/eNTJ7svN/oiNVxsTb4WeHIjbQDXIptu49DBcv0YDVEIA2OU5ueill
 K3rbBzKGKB+rdoB9CSPdVp8aQEpdyWauqp5ppSPhAhOgFq8/fXnSgtPQ07+xPs2vCTjv
 lT5UfejM2OR18NC2iztn99t8k27kCEANMaJuxO9ll4hvC6658e4liRGbu0lUOfa+uzDJ
 qQ726spqTXbjjs3ubOmUOMlG4aY2W1IgYRBM3GtOtPFsyZWceSWkS3pDM5iP4DoTDv4+
 4GfQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1727985390; x=1728590190;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=1K9X+TY89oBYMX4PjqJvocsPvmc3bOMw9kZy7Pcn6xk=;
 b=WBAG/JoTVB2uAy013MDDOnnOfY0lUt9/is9o4tZznJOr9wrF/6ALdgr2Va3U0EgrYh
 v7KKt9yTZJjK4GanBhNOOInwMeqNY7GtVaPGJiC958TS4yrZIANeLWjzHS65U1go5Xeh
 QObNwVsHNhIklyMz76nVQGTGl99V5WCkW8AJ2ThIO8up+tXTQNsvlvqZebQpziM+uDKx
 uSSxs5K2cSTS0mHySf+6M2rtUJoRaENg9qMrB7Y/xK2q2rEebjHDJU98dnKMqT0S2bmO
 +4mPEJmcQDVdJgjw4ttRwTutSqq/mtVkgWw92H4p9+dkt4X5BixT0GtoxT6tjfhfcpl9
 Lfhg==
X-Gm-Message-State: AOJu0YySI25n/4A53sg/cw+/EIP+OSNKeHZgLr30pmhtWKZc5sA77mKh
 +4TwHVPMoHHFO7Re5nnRjyWQxnEeJ661Qt0Lyxlr5XOQAAqPeHieicb/XhsgqE0=
X-Google-Smtp-Source: AGHT+IE5RPNWxqjQoMPO+hm2E+lq1cGFh/YD3zbTUY/QJ1ncNYXezqynR1UwZr9uWlY+P7L9YQCcuA==
X-Received: by 2002:a05:6a00:4b55:b0:70d:2708:d7ec with SMTP id
 d2e1a72fcca58-71de23a4f94mr353331b3a.5.1727985390250; 
 Thu, 03 Oct 2024 12:56:30 -0700 (PDT)
Received: from [192.168.0.4] (174-21-81-121.tukw.qwest.net. [174.21.81.121])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-71dd9ddc8d6sm1748122b3a.125.2024.10.03.12.56.29
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 03 Oct 2024 12:56:29 -0700 (PDT)
Message-ID: <ac79fcea-b1b7-4396-8f82-eaa3ba78b455@linaro.org>
Date: Thu, 3 Oct 2024 12:56:28 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4] tests/tcg/x86_64: Add cross-modifying code test
To: Ilya Leoshkevich <iii@linux.ibm.com>, Paolo Bonzini
 <pbonzini@redhat.com>, Eduardo Habkost <eduardo@habkost.net>
Cc: qemu-devel@nongnu.org
References: <20241001150617.9977-1-iii@linux.ibm.com>
Content-Language: en-US
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20241001150617.9977-1-iii@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::433;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x433.google.com
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

On 10/1/24 08:03, Ilya Leoshkevich wrote:
> commit f025692c992c ("accel/tcg: Clear PAGE_WRITE before translation")
> fixed cross-modifying code handling, but did not add a test. The
> changed code was further improved recently [1], and I was not sure
> whether these modifications were safe (spoiler: they were fine).
> 
> Add a test to make sure there are no regressions.
> 
> [1]https://lists.gnu.org/archive/html/qemu-devel/2022-09/msg00034.html
> 
> Signed-off-by: Ilya Leoshkevich<iii@linux.ibm.com>
> ---
> 
> v3:https://lore.kernel.org/qemu-devel/20230316214711.318339-1-iii@linux.ibm.com/
> v3 -> v4: Rebase.
>            I've been looking into the .NET failures under QEMU again and
>            what this test looks for was a suspect. It turned out to be
>            https://gitlab.com/qemu-project/qemu/-/issues/2600
>            but it would be good to have this test upstream to ensure
>            there are no regressions.
> 
> v2:https://patchew.org/QEMU/20220905154944.1284289-1-iii@linux.ibm.com/
> v2 -> v3: Resend with a trivial rebase.
> 
> v1:https://lists.gnu.org/archive/html/qemu-devel/2022-09/msg00455.html
> v1 -> v2: Fix tweaking the flags (Alex).
>            Keep the custom build rule for now.
> 
>   tests/tcg/x86_64/Makefile.target        |  4 ++
>   tests/tcg/x86_64/cross-modifying-code.c | 80 +++++++++++++++++++++++++
>   2 files changed, 84 insertions(+)
>   create mode 100644 tests/tcg/x86_64/cross-modifying-code.c

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>


r~

