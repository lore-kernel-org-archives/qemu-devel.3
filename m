Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 645ECC19776
	for <qemu-devel@archiver.kernel.org>; Wed, 26 Feb 2025 21:38:31 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tnP5g-0005bB-NU; Wed, 26 Feb 2025 16:37:16 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tnP5e-0005ap-RR
 for qemu-devel@nongnu.org; Wed, 26 Feb 2025 16:37:14 -0500
Received: from mail-wr1-x42c.google.com ([2a00:1450:4864:20::42c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tnP5c-0007S6-FB
 for qemu-devel@nongnu.org; Wed, 26 Feb 2025 16:37:14 -0500
Received: by mail-wr1-x42c.google.com with SMTP id
 ffacd0b85a97d-38a25d4b9d4so95084f8f.0
 for <qemu-devel@nongnu.org>; Wed, 26 Feb 2025 13:37:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1740605829; x=1741210629; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id:from
 :to:cc:subject:date:message-id:reply-to;
 bh=9LfgPyznGXoTvuUeXjk8keuJk5Al6WOywHvQ05kGlBU=;
 b=bWFMWZva8uwT9COQcr8fZPnV9oEPyYBuYvON2RYWUSakEcUOXod5MvhquicsWQ5UgS
 5ZHpgMKLBy6NH8VKFS1ssC2NPqDf/y6Lt6KGNjjClUiCfWDnM7KYctWd0QY7BGGctQhW
 JBEW9Aig7QTxlIqxgiUuo5Ks5o3FrEB3KCqK8gVOr2CZr4p7JYSkwni8kANZ3cnKffJs
 akaBTCd+WdAObl+quI6P+zm09VThns/ddY29pHsv+HGYT3eIOJTygeAt//aFJjgSkVcr
 rdwAAoalH1JaQZMlmRVu/VkATZBK2qyEP2sfvHc6qsop2qYbhGVyBoj2VJ9RgWh6TxUc
 egfA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1740605829; x=1741210629;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=9LfgPyznGXoTvuUeXjk8keuJk5Al6WOywHvQ05kGlBU=;
 b=tc4s/VHl1PIUmpePKvrBvyLQQHa+UduC3d6KtxCdAlzxpBoHEhxdwbC2bykf+dvZ5S
 nl4VAAmIwW+IaBoP4HB1OGfWFzBUnEK6X+FIF7/GwBCgc0qs4Ta0x4XFhWO7OoDeHkqX
 JMoODyC5dh5nFV3UQuCvwqX42yPyKHR9hmbBAnFMx98UWUrXZ8RPH+5946j6oFaQvy/F
 FWYZs3mMk5w5XnqEXvXYqLBw0ki97ehfpPbA2n5SK6LUD6ILL/rNQvD2ZSz7dzI+t2KN
 +1gE6b/KPbDHduqyivmD2dvcYfxEHBjK2Wd2mZVLjCf4BGlbt5EiGbshG6++fXVNB7+p
 tcfA==
X-Forwarded-Encrypted: i=1;
 AJvYcCW06I+yfRwerKTw7nNSRHJB9dGQTgtUTlwXlX+lMOK6n3/mifIzZUPUkhn5kDz43L1xKk6YSQuJ8N0r@nongnu.org
X-Gm-Message-State: AOJu0YzarbGqjKcb34b7c3OZFVhdFexMg1EaOFGSuq8LsZj78tBDToiH
 TywKeyqlFAfh+wz7wpw132Uy0BRKKJkHbdJfMQJLPrjyXtT+xdu1fk0OOkjF9ek=
X-Gm-Gg: ASbGnct990RQmukVA5oCa/T1WUrtIMcNiGG+RRE8SZwHXGBwbSn//901WPByEonLSuu
 Z4o+zsmwaiCHQ442dyZWI6Ewt77PYF2kyv+vj5+xtGH8eMk3TFeSARDR/K0R09Z6ZL/jeFF3VVu
 nnkEb5Lo+H92ZxWTg168cqUXPEpcNPgRWl7gwF4P11m0uueu8UXYRwZ9QR9pBudXqNMAtn4Wzov
 2SRa4piZFWRGw0pAclO7BXiLFxR1qn7r2wPghW+QyOO8cHxV4gc0sYtP1bVg9GBsxy53JC0TU4N
 oKqtKHt9oDcPGHMrLwg3QZUcgezH/rLVLV2ktprZ2EuST5DF8nHBmLvyl25R9i61G4XREQ==
X-Google-Smtp-Source: AGHT+IFLpCE+sLM8oCfONTGBzUg4mO66a4aDHvFjU95/PCyTFvNRC5i1hvMbYpNJI3wGCbzZtYoHug==
X-Received: by 2002:a5d:6d87:0:b0:38d:d8c0:1f8c with SMTP id
 ffacd0b85a97d-390cc632334mr9441309f8f.38.1740605829587; 
 Wed, 26 Feb 2025 13:37:09 -0800 (PST)
Received: from [192.168.69.196] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-43b737043aasm2005935e9.14.2025.02.26.13.37.08
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 26 Feb 2025 13:37:09 -0800 (PST)
Message-ID: <0c1553c2-0f58-4a7b-9e91-7f81251d2652@linaro.org>
Date: Wed, 26 Feb 2025 22:37:08 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 020/162] tcg: Convert eqv to TCGOutOpBinary
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
References: <20250216231012.2808572-1-richard.henderson@linaro.org>
 <20250216231012.2808572-21-richard.henderson@linaro.org>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20250216231012.2808572-21-richard.henderson@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42c;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x42c.google.com
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

On 17/2/25 00:07, Richard Henderson wrote:
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>   tcg/aarch64/tcg-target-has.h     |  2 --
>   tcg/arm/tcg-target-has.h         |  1 -
>   tcg/i386/tcg-target-has.h        |  2 --
>   tcg/loongarch64/tcg-target-has.h |  2 --
>   tcg/mips/tcg-target-has.h        |  2 --
>   tcg/ppc/tcg-target-has.h         |  2 --
>   tcg/riscv/tcg-target-con-set.h   |  1 -
>   tcg/riscv/tcg-target-con-str.h   |  1 -
>   tcg/riscv/tcg-target-has.h       |  2 --
>   tcg/s390x/tcg-target-con-set.h   |  1 -
>   tcg/s390x/tcg-target-has.h       |  2 --
>   tcg/sparc64/tcg-target-has.h     |  2 --
>   tcg/tcg-has.h                    |  1 -
>   tcg/tci/tcg-target-has.h         |  2 --
>   tcg/tcg-op.c                     |  4 ++--
>   tcg/tcg.c                        |  8 +++----
>   tcg/tci.c                        |  2 --
>   tcg/aarch64/tcg-target.c.inc     | 26 +++++++++------------
>   tcg/arm/tcg-target.c.inc         |  4 ++++
>   tcg/i386/tcg-target.c.inc        |  4 ++++
>   tcg/loongarch64/tcg-target.c.inc |  4 ++++
>   tcg/mips/tcg-target.c.inc        |  4 ++++
>   tcg/ppc/tcg-target.c.inc         | 22 +++++++++---------
>   tcg/riscv/tcg-target.c.inc       | 37 ++++++++++++------------------
>   tcg/s390x/tcg-target.c.inc       | 39 +++++++++++++-------------------
>   tcg/sparc64/tcg-target.c.inc     |  4 ++++
>   tcg/tci/tcg-target.c.inc         | 14 +++++++++---
>   27 files changed, 89 insertions(+), 106 deletions(-)

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>


