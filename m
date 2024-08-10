Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E7DF4C3DA4A
	for <qemu-devel@archiver.kernel.org>; Sat, 10 Aug 2024 10:32:25 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1scjNT-0007nJ-DC; Sat, 10 Aug 2024 06:31:15 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1scjNS-0007k2-5g
 for qemu-devel@nongnu.org; Sat, 10 Aug 2024 06:31:14 -0400
Received: from mail-pf1-x42a.google.com ([2607:f8b0:4864:20::42a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1scjNP-0005GH-5V
 for qemu-devel@nongnu.org; Sat, 10 Aug 2024 06:31:13 -0400
Received: by mail-pf1-x42a.google.com with SMTP id
 d2e1a72fcca58-710dc3015bfso892243b3a.0
 for <qemu-devel@nongnu.org>; Sat, 10 Aug 2024 03:31:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1723285869; x=1723890669; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=y25t+TJxNw42DZozoQ+uUPD1k1WiAZ6yQumzegCb2r8=;
 b=UHZXqpikKR91mfIbzdHCQqc0kH8nmQXnuwb0MHQvsKo1L/eW5FBSbU9xkJ2fWoo8M5
 gYdnEVnh9Yt9bt0HKO42NUqMJxaS1dOn8eCFetXOBAz/eupk50WLRX7UmG37ZJttLmVW
 guTfJnnXIvEznvOKay3K9LYeRnEuvA5XbJGLx03DBlntoOmMNMF6Zkk7SmydtZaIhBP1
 H2Hw4UYNr4gky+Bc+qr3P3PgAeBqxsczByPQJWpekWdsilYedFZBex72Czu2VJg0VYEU
 EY4HzU0VCVhaHBjX08MUWswKtj9/4tmZRmwDsCLHAGAur8wyQycczeYH/+3uC/LnabyJ
 WKYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1723285869; x=1723890669;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=y25t+TJxNw42DZozoQ+uUPD1k1WiAZ6yQumzegCb2r8=;
 b=mul3C70GvvQ8owRTNMBIPJ2bhhnDcQosh2E3QGB2axSXgScjH5KPt1gjvVSUPhdOOx
 /tX7PSI+pPkk9nK4Hciw75K+UM1r2QUlXskiU2t5mDohq7JYehw2RKINi0AaciUQnrYN
 zvvEI/cGekb4hdXTqNgBKPT17LlimEvvxlvG63bVWHB+A70bM/9W+23+iYtJaEb6LA8V
 PHOf71dThKEUzqQc7A4P3RK6LknJnTHM50OQuF33LRsaSl4pU15c50Oe7AisjeCkQnqP
 VG6rC8mzrm7ivesiE5V0C3MqyXsrfpm8KLgSek/gvU3QGCz2rvSKPDFqeAoq71TBLCZD
 YYqQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCWNOc9PF0fuTp1f9GsOqDSctFicnNI0Z11JYWIBYb30wb7Haoj9Qevnl9X5njq4QyL/vpcAH2UtQs/0JYFc+8oQy8jWQ9k=
X-Gm-Message-State: AOJu0YxwZbYLPA2u9Hj9C5RUE5H2ZzZEWXMKdEt7ZHI+GM/Piph1bx3O
 YgkLB6HI1HKMGvPsSpRDkPjcSwl0cz05XnKkQB21fGGFrR1o+i1N7rl0c/Sz2rU=
X-Google-Smtp-Source: AGHT+IHvTdKDwJuj9FfFt6zYxERQ3fo9YppBIBRmQps2h7bqlup61tBdwGksQuGV7e+Dl5HPC7TCVA==
X-Received: by 2002:a05:6a00:3d09:b0:710:9d5d:fd13 with SMTP id
 d2e1a72fcca58-710dc765225mr6801774b3a.0.1723285868426; 
 Sat, 10 Aug 2024 03:31:08 -0700 (PDT)
Received: from [192.168.1.113] ([203.30.4.111])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-710e5874e00sm1064009b3a.12.2024.08.10.03.31.05
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sat, 10 Aug 2024 03:31:08 -0700 (PDT)
Message-ID: <54088801-9425-4522-b801-96b8e3f0834d@linaro.org>
Date: Sat, 10 Aug 2024 20:31:00 +1000
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] target/arm: Update translation regime comment for new
 features
To: Peter Maydell <peter.maydell@linaro.org>, qemu-arm@nongnu.org,
 qemu-devel@nongnu.org
Cc: qemu-stable@nongnu.org, Bernhard Beschow <shentey@gmail.com>
References: <20240809160430.1144805-1-peter.maydell@linaro.org>
 <20240809160430.1144805-2-peter.maydell@linaro.org>
Content-Language: en-US
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20240809160430.1144805-2-peter.maydell@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::42a;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x42a.google.com
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

On 8/10/24 02:04, Peter Maydell wrote:
> We have a long comment describing the Arm architectural translation
> regimes and how we map them to QEMU MMU indexes.  This comment has
> got a bit out of date:
> 
>   * FEAT_SEL2 allows Secure EL2 and corresponding new regimes
>   * FEAT_RME introduces Realm state and its translation regimes
>   * We now model the Cortex-R52 so that is no longer a hypothetical
>   * We separated Secure Stage 2 and NonSecure Stage 2 MMU indexes
>   * We have an MMU index per physical address spacea
> 
> Add the missing pieces so that the list of architectural translation
> regimes matches the Arm ARM, and the list and count of QEMU MMU
> indexes in the comment matches the enum.
> 
> Signed-off-by: Peter Maydell<peter.maydell@linaro.org>
> ---
>   target/arm/cpu.h | 23 ++++++++++++++++-------
>   1 file changed, 16 insertions(+), 7 deletions(-)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~

