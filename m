Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 70C54E63FFF
	for <qemu-devel@archiver.kernel.org>; Sat,  4 Apr 2026 23:38:50 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w9AZ6-0006l7-Bz; Sat, 04 Apr 2026 19:38:08 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1w9AZ5-0006kq-5y
 for qemu-devel@nongnu.org; Sat, 04 Apr 2026 19:38:07 -0400
Received: from mail-pf1-x42a.google.com ([2607:f8b0:4864:20::42a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1w9AZ3-0006rT-KP
 for qemu-devel@nongnu.org; Sat, 04 Apr 2026 19:38:06 -0400
Received: by mail-pf1-x42a.google.com with SMTP id
 d2e1a72fcca58-82c70e4654eso1324652b3a.2
 for <qemu-devel@nongnu.org>; Sat, 04 Apr 2026 16:38:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1775345884; x=1775950684; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=Ynl6IrhpnHYUA6XsNX/OB6lzvYdxveK74dk4UocRJ0c=;
 b=svExHg6ipPe1YE6lUC2KoXE6nfow1eJA8fi648B7laY1lI1sb7qIxPPfql88Mmtw8s
 TXy3y+MB3L1St41yMYTYaOrFBhsBmr5amPB8jGOZaNO80jObSd/qKdePXA8fGdmaxdTd
 thQcWhIutrwRAD1UYtuebqyd+95bxBzYOlUuVFGF4zM6P+rNQD3mVfc9685WdlC2G91j
 LNs7nP36NY8J5210O1J0D4tN9aYvP1KAtVXGeOLje9s9xZeTQhBUSU2MPSt57IS+1jf3
 dnzSOSHHVxZXYG1WRilfnxFiGApwYR0qI+H7/p+364uO0YG7xRDpjmwTb8G+6F5hjC9j
 Y+dw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1775345884; x=1775950684;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=Ynl6IrhpnHYUA6XsNX/OB6lzvYdxveK74dk4UocRJ0c=;
 b=mRPVZ3urk7wS+Elq2yg8baq4WeGUwCIRQ76U6Qr9Fg4ZQS0X8RUWTumiOf/PTz2dzh
 Sl6rn+qB57CqGj19CdxRD1z7M3pk0fFKbAf4AzygVmM0gBHHiMGuM31aBq6OPbEpn1kN
 mQXiiM4Prv7RD4ZAivIqYMlIux6LQiyabGMsc9kxPsd4jodG73z1tKr/JhzRWF1F/cMg
 T2OQK5Tc2Jdq9ca8U86sHMg19LpZ2LbsW8u9m7JDEQ5l806CK+7SjUhfvuE69BG6rWbF
 Ux9BHjVglgfbuCzCaESg6ntqWWpXpV1fFJj25RYw71f3DDXvmDO4Bxa/DU7+sS1GH0C+
 +peA==
X-Forwarded-Encrypted: i=1;
 AJvYcCX0RSPqvUW+rXOhrRGqw33xXfSyAl+PvHUy0BiY4v6D54zotWWYQms3dNb+7QgOT3k/vilNvr5uFAPV@nongnu.org
X-Gm-Message-State: AOJu0Yx4arDFvCRAIirwOFGga5F7BivFwWEuNHPvfJq2lyvdrHRIJHts
 4BDOZCv6D1PMEf1XMrToTwnu1FrbHqQc67LrYCkxRg0K0qt/16bdhRzEnFQq6zCcpZ4=
X-Gm-Gg: AeBDiet2+qE8sRfHB+mHV4jHPXhv0uSCJ9bKwITapXlf4eQ7FDakDUZbYR/2hGJfDSX
 sEJGTJjWGIA1+xQwaqI1QOn24IyNkyHY7mp9W5Fh91bj1t2JoVvtqWHEMjx//rYmKTAlCEvp6iq
 VC6Emdh9u5x9JT+pZJIiOEUtbJJzfEvmY0sQqrAXhBv8haQAC6TSrC9Qm3pIAAXUya0M4IEP3Hj
 DmVUytaYLRzNoAtMpQQ/U6zv6qOVRprzbCCmF+jmfeD0xZ0uotV28TtK9DaAB/DDWO9ATSj6mLl
 kzrfhuEc870sQT5FclIJ8jc0/1XDq538rVpv/Efq5ldNnD8VJJNGEO9wAgbBLB98ATnaqyEqQLz
 mq9vcLPuZlcgdCfEDBazGt9/c5g66S+2qvH3KVfm35J4lA2ENsRwIiJxvBfOrzIspfxV9NxSYh9
 RidtbumEcd+n4XToOiEGi4tQXiZW2queJTEcdtx0EDp+j9rFoXRPobBGjFKqGiA1wxTn4fwifux
 cTDeQ==
X-Received: by 2002:a05:6a00:4b50:b0:827:37d5:af4d with SMTP id
 d2e1a72fcca58-82d0daa016fmr7533125b3a.24.1775345883896; 
 Sat, 04 Apr 2026 16:38:03 -0700 (PDT)
Received: from [192.168.1.105] (124-150-69-109.tpgi.com.au. [124.150.69.109])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-82cf9c6ba2fsm9828591b3a.45.2026.04.04.16.37.59
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sat, 04 Apr 2026 16:38:03 -0700 (PDT)
Message-ID: <2ba609c8-4c55-4d9d-9a36-318336f0a31d@linaro.org>
Date: Sun, 5 Apr 2026 09:37:56 +1000
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 03/13] target/arm: mte_check unemitted on STORE_ONLY
 load
To: Gabriel Brookman <brookmangabriel@gmail.com>, qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Gustavo Romero <gustavo.romero@linaro.org>, qemu-arm@nongnu.org,
 Laurent Vivier <laurent@vivier.eu>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>
References: <20260309-feat-mte4-v4-0-daaf0375620d@gmail.com>
 <20260309-feat-mte4-v4-3-daaf0375620d@gmail.com>
From: Richard Henderson <richard.henderson@linaro.org>
Content-Language: en-US
In-Reply-To: <20260309-feat-mte4-v4-3-daaf0375620d@gmail.com>
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
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On 3/10/26 08:59, Gabriel Brookman wrote:
> This feature disables generation of the mte check helper on loads when
> STORE_ONLY tag checking mode is enabled.
> 
> Signed-off-by: Gabriel Brookman<brookmangabriel@gmail.com>
> ---
>   target/arm/cpu.h               |  2 ++
>   target/arm/tcg/hflags.c        | 12 ++++++++++++
>   target/arm/tcg/translate-a64.c |  8 ++++++--
>   target/arm/tcg/translate.h     |  2 ++
>   4 files changed, 22 insertions(+), 2 deletions(-)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>


r~

