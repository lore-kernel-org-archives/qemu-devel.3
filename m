Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 38B0EC87FCA
	for <qemu-devel@archiver.kernel.org>; Sat, 26 Jul 2025 01:11:49 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ufTR6-000375-Hf; Fri, 25 Jul 2025 21:10:52 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1ufTR4-00036L-Qx
 for qemu-devel@nongnu.org; Fri, 25 Jul 2025 21:10:50 -0400
Received: from mail-pl1-x62e.google.com ([2607:f8b0:4864:20::62e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1ufTR3-0005fo-0L
 for qemu-devel@nongnu.org; Fri, 25 Jul 2025 21:10:50 -0400
Received: by mail-pl1-x62e.google.com with SMTP id
 d9443c01a7336-234c5b57557so23748015ad.3
 for <qemu-devel@nongnu.org>; Fri, 25 Jul 2025 18:10:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1753492247; x=1754097047; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id:from
 :to:cc:subject:date:message-id:reply-to;
 bh=zQgHPVb5qvks0W0iSB5fjgaH9U0zRJR9mCcAsfh1/0I=;
 b=M0upvEpOV2EZtAAnwZrPGVPaQ6xH1xrvuvA45/wzKB2xl2oyTW6lNB5mXla38dQl2A
 brDx9eSoqEgSYenSvpzc6N0jxd1feJJY+qCIBuIiHo08B0NGDRGiIiazcNysKKV4syJQ
 qRiYfd+h1UC/n6m0sghRU13Qq9NF3fR1bnNhQvYQvOP9V3i13FILazG00haqhY54FBVL
 qkSomTPUjlAXjtNY1QIEbaj4G/nEDF+adMCWcC79O9incPXfo1DiZkLGLCzoQe81v/Jl
 ONnau8wLpM4wpGPIkFviyJMGOwHUMsvg0ekzZ6IoJ60/oh2TuAth2qo9byRbi+cUDSQg
 omOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1753492247; x=1754097047;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=zQgHPVb5qvks0W0iSB5fjgaH9U0zRJR9mCcAsfh1/0I=;
 b=SEP4Ficxa0hWpmCtnIhOzFRX6RqpwzqNKCqJPwX1kI2sCOsFX9kKEPVuxw28JET76e
 RWve3Mt4m/6AJqjpG0xoX9g6DPNEb3XRniHokuNtPE7GRq7oLahqgCHwAcBjwNOrhSFA
 Y4Z+4VSXUn4n84ZnoL7c9VXBl6BqHlugrfC58u0BoetwXjGpqqQyn0RoVCtobh5kT+s9
 RlXvRw6mxG43nH8UjqBamdWet1eQRZCN/XJP/xMdOguRi22pgoO+M+4lHxtlhhrP55qv
 IqYj41vLgOfu8BT0aoIBMpCJBBK3Ls/gwFZzzCAvWlrgLVTOlQccfUxxBNyKjHNrEgOZ
 4GWQ==
X-Gm-Message-State: AOJu0YzS8b8UgBgG/syJqdXSx14flFNo7obVAWbcR17jQWMHQ2r5w3gE
 HBEA9m/WZ+qSbTi3cgMjgvtN5GVTGhE/TtXxldFN0ub6Mda3hEuAo4J2kVcYltc8+8zT8YhPPcu
 fwjYx
X-Gm-Gg: ASbGncsTUJHXcHLS0FSi1JYLD61ERbOEkwadW1xR81PdvsWLSNi4idjWfq1w1uik4mU
 8EX5z8V5OkByEWb7WZLSyTxrh4Xxqr6rQZmQJD20p5zXSzdMxsvlTc+MA0mkf+/y2XK5HiNXhIL
 UW5MftD9sjFjIGlTUfcRvYvf4RzXqI10KiJAftXFJaozsT7NpbJBGDyowoLt26zrM3LzeGusxaH
 Vq/B0jcuiWHEvB9rYZqYmSB8/EajX+G67NO+7EHo9byejL5FIs50+VSY+mDFUVZ/Qjr7hRpNzNN
 Pja1cNmLuIktXfBkbvfeIvNCQQAwRRh/UaRgrLtGGbYscAq1oKYoLPgCvdaQ5nGWhM0QpyBt9MF
 LxKpk+82L6OJwT/i0km9emfkFh0VMACDiN6ThhvThnMT6qkd3DM2P/Am53kvNkvNEZH1LzwdAmo
 I9pA==
X-Google-Smtp-Source: AGHT+IG95jAFvb5Dl0jyM5NaMQ8KFU5zGlXv1NPcYWb4rYteSssTgsQGnRmi45FbY5npTkAMeSACrg==
X-Received: by 2002:a17:903:234c:b0:237:f7f8:7453 with SMTP id
 d9443c01a7336-23fb313a5d9mr63344975ad.51.1753492246704; 
 Fri, 25 Jul 2025 18:10:46 -0700 (PDT)
Received: from [192.168.4.112] (syn-098-150-199-049.res.spectrum.com.
 [98.150.199.49]) by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-23fbe30ff79sm6367065ad.9.2025.07.25.18.10.45
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 25 Jul 2025 18:10:46 -0700 (PDT)
Message-ID: <c3eb69e9-41ea-4881-b3e6-578fb7045b3b@linaro.org>
Date: Fri, 25 Jul 2025 15:10:43 -1000
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 04/17] target/loongarch: Add header file cpu-mmu.h
To: qemu-devel@nongnu.org
References: <20250725013739.994437-1-maobibo@loongson.cn>
 <20250725013739.994437-5-maobibo@loongson.cn>
Content-Language: en-US
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20250725013739.994437-5-maobibo@loongson.cn>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62e;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x62e.google.com
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

On 7/24/25 15:37, Bibo Mao wrote:
> New header file cpu-mmu.h is added and move mmu relative function
> declaration to this file.
> 
> Signed-off-by: Bibo Mao <maobibo@loongson.cn>
> ---
>   target/loongarch/cpu-mmu.h        | 30 ++++++++++++++++++++++++++++++
>   target/loongarch/cpu.c            |  1 +
>   target/loongarch/cpu_helper.c     |  1 +
>   target/loongarch/internals.h      | 20 --------------------
>   target/loongarch/tcg/csr_helper.c |  1 +
>   target/loongarch/tcg/tlb_helper.c |  1 +
>   6 files changed, 34 insertions(+), 20 deletions(-)
>   create mode 100644 target/loongarch/cpu-mmu.h


Reviewed-by: Richard Henderson <richard.henderson@linaro.org>


r~

