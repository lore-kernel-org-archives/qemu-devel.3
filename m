Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F2194CA0FFD
	for <qemu-devel@archiver.kernel.org>; Mon,  1 Sep 2025 08:03:58 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uszVa-0004NK-Pm; Mon, 01 Sep 2025 04:03:22 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1uszVZ-0004Mn-0M
 for qemu-devel@nongnu.org; Mon, 01 Sep 2025 04:03:21 -0400
Received: from mail-wr1-x431.google.com ([2a00:1450:4864:20::431])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1uszVW-0001NA-P8
 for qemu-devel@nongnu.org; Mon, 01 Sep 2025 04:03:20 -0400
Received: by mail-wr1-x431.google.com with SMTP id
 ffacd0b85a97d-3d1bf79d6eeso1104957f8f.2
 for <qemu-devel@nongnu.org>; Mon, 01 Sep 2025 01:03:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1756713797; x=1757318597; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=+7Q9myghIcsZdoAphzG+RBMWVZ/y1QRGAR1qpXZUaJg=;
 b=vAtugQciq8TKESnQUHo2IrMLXsxO2h4zpjyJ40bLGS8fte2h0TJ+pHdayN/nb6M+7M
 e4ZB8XJBK+RVrFle20cUW+HoGDEevtmBHDJc0YbWJOifdZMdwHh5Ocf6sb6j2eBtOXak
 cYtJuCaJ1HS2ZYv2QKXAZS5ZLHL17ch+wZ1723dnL68oiLTwkUljXWKzlyq/35wzyDcy
 bSaOPDotvfLuLczVf7QPM/yGN4Mr2rk/DjxtEhcITonXalHwZCSCeLOOK4qjkmaJwha7
 ZpQ3FbfpnAZk4zW8+RJBUtsv4+88egwUljwFI22iBpvJqrvGccGGkpWrsvDbi31rLzdS
 MSyA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1756713797; x=1757318597;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=+7Q9myghIcsZdoAphzG+RBMWVZ/y1QRGAR1qpXZUaJg=;
 b=oopQuXRrRwupLhYkYkRugLOrHJYxyCTksuUyBwJ7lF2mPLWDtp6uW2Hw/iRRuXdQOA
 pGE/Cdb7GP6Ulucd/RP7Pdi2ZjN7tqgazfDG9moi92TXvR06OrzOA0Ud+2Shzas/30K4
 fzsVs7xOl+3M7aViy4iU4DlO1WIkHc/Fi68BgfYWNLBEXSBprjVARKndAIhh4tTx3Cvz
 zR5J3z2D7UPwi8Cy051aKVL2xqFT+8JFhLiLlX+Mfd7nTvlhrncVtN++aDD4UQ3yyNuC
 wu4Uqov2/a+pxBlUfgRqoC99CcCkxYWQAspF7Lumfqf6HiSTK6IO8NRbAPtqTzloUmmG
 NahQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCX2Kvwi2hKInZ88urDICN3iwOQGqq7to2+NLbCJMmRoO02WH7M9y2GfP1E6s8nPE0P4STz1rtzq/AuF@nongnu.org
X-Gm-Message-State: AOJu0YxCiLaZ1iPs7a5oB18KispzqLrivEmg2BWH3k/fPiaEQPOVdqnj
 Qutitb8wivxAMHFTQIRpvR0qs1LVCSJ00EKjYgfIahHqbFnLdYsNX6hXc/TD9P/S0LU=
X-Gm-Gg: ASbGncurJqaVNRvxZxLOWKjp3fSO0g2vGmIINVgU8JsAOy9BtfWxRZLULUKAR8yB75h
 tlxAI+6e3UUWebxh9WB+yxY0zait13YsPrBLPxSQEQh06zDQ11FGrCZyCyNuUniOunsUh3FHDiV
 Np2A1cpneDCOLFN0k39rFCKjHTT/N8iNPoceUl1BK6TEeEzNKpF4tNhSckeIILuO6u7kxbAbXac
 iNaIwqyYVhFLYf1XRPxnYj0vg9tv6N0kIuCRoW/wkD9bBX/GuaI0ZrwIn2EcsQo520dvROxVm3x
 CZsTcFB+QngAtTNqshHkd2yGmtT3JuCuZZLcLW9Ru2MYxubYqcdYZVYL6smJy1DYbsIYtzWpS2Q
 kCFO2Lm1zTMT1u5mYrLGdX8fBVgkL8qw9c6u/UDmpAgyI9ZGN0+1mdpNIYQSztFeJWQ==
X-Google-Smtp-Source: AGHT+IGYNpOeoxJuW7CiHj9I3myc4oQSIbvKFpsebevK0fG6DvwJ2EO/pOsdp7CF07ZNoSGOJdJXFQ==
X-Received: by 2002:a05:6000:2083:b0:3b7:89c2:463c with SMTP id
 ffacd0b85a97d-3d1dea86e46mr5546548f8f.29.1756713796110; 
 Mon, 01 Sep 2025 01:03:16 -0700 (PDT)
Received: from [192.168.69.207] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-45b7df3ff72sm91670855e9.1.2025.09.01.01.03.14
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 01 Sep 2025 01:03:15 -0700 (PDT)
Message-ID: <119df69e-592d-4a79-8408-6301ae7af812@linaro.org>
Date: Mon, 1 Sep 2025 10:03:13 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 11/18] accel/tcg: create a thread-kick function for TCG
To: Paolo Bonzini <pbonzini@redhat.com>, qemu-devel@nongnu.org
Cc: peterx@redhat.com, richard.henderson@linaro.org, imammedo@redhat.com
References: <20250829152909.1589668-1-pbonzini@redhat.com>
 <20250829153115.1590048-7-pbonzini@redhat.com>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20250829153115.1590048-7-pbonzini@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::431;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x431.google.com
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

On 29/8/25 17:31, Paolo Bonzini wrote:
> Round-robin TCG is calling into cpu_exit() directly.  In preparation
> for making cpu_exit() usable from all accelerators, define a generic
> thread-kick function for TCG which is used directly in the multi-threaded
> case, and through CPU_FOREACH in the round-robin case.
> 
> Use it also for user-mode emulation, and take the occasion to move
> the implementation to accel/tcg/user-exec.c.
> 
> Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
> ---
>   docs/devel/tcg-icount.rst       | 2 +-
>   accel/tcg/tcg-accel-ops-mttcg.h | 3 ---
>   accel/tcg/tcg-accel-ops.h       | 1 +
>   accel/tcg/cpu-exec.c            | 6 ++++++
>   accel/tcg/tcg-accel-ops-mttcg.c | 5 -----
>   accel/tcg/tcg-accel-ops-rr.c    | 2 +-
>   accel/tcg/tcg-accel-ops.c       | 2 +-
>   accel/tcg/user-exec.c           | 6 ++++++
>   bsd-user/main.c                 | 5 -----
>   linux-user/main.c               | 5 -----
>   10 files changed, 16 insertions(+), 21 deletions(-)

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>


