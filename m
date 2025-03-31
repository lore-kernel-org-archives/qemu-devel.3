Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 719DBC3600C
	for <qemu-devel@archiver.kernel.org>; Mon, 31 Mar 2025 14:17:10 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tzFw9-0005Pl-1Z; Mon, 31 Mar 2025 10:16:25 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tzFvz-0005OD-An
 for qemu-devel@nongnu.org; Mon, 31 Mar 2025 10:16:16 -0400
Received: from mail-wm1-x333.google.com ([2a00:1450:4864:20::333])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tzFvx-0005Yj-8x
 for qemu-devel@nongnu.org; Mon, 31 Mar 2025 10:16:14 -0400
Received: by mail-wm1-x333.google.com with SMTP id
 5b1f17b1804b1-4394345e4d5so28897085e9.0
 for <qemu-devel@nongnu.org>; Mon, 31 Mar 2025 07:16:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1743430571; x=1744035371; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=I64BiwOIwbYPhS3F9PbebY8ATXDtTgB3BXvfnFWJZ8Y=;
 b=GqrLYF+yfztxUNwedzlNM+FcsICvcD00MEwICwCUF/ACIK6/ODiVhlV5seBg5luc9c
 9/mYzJeKw8dy+YJPsvMLLF4Izbx8OR2wHKjHq8CdkGM5Mrln7fEWWQUOp/nBdONlmYpt
 /8u2ITancLOuAsC/eiaCBJJoVSzGAJS8y21qC3WNYfJ5YDXxFvLsKRJIROJ5TwqcYEBu
 jO9QNSzUqA9plWqs92l1hbEZC8EbcoOu9ritLBWz1z5QgtkUB+rNMLzRP1TIqYf6cCyE
 6FANyfNeH3VFPGHhwO98a3S9X2Kf69/sCAzRncoslh2D87VL3GzMeks7X1ai1sigKFQT
 C7Gw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1743430571; x=1744035371;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=I64BiwOIwbYPhS3F9PbebY8ATXDtTgB3BXvfnFWJZ8Y=;
 b=KUeBw00zzFmf0svDTQxCF9JO++Mwpq+C2nQQTdnTAP1M4ZeB1nPecDUJ8sWKdST45f
 G0e9mC0A5Q1p5cYLO8T2SzlsndnqZOk1YgTCcLPryxN2snY1cxg0wYUh1w/KYd7DH2Xe
 Sq26uwTYbzebXR5kGDs1Y8PvfJDt4oPK3WySnWQU2r/0sF5DuKfrhU+HfeqC2PRTzMTS
 wj1TR3f58swxguGrkYgQ4SIFrhCJHM4BclYArBOZ4/XU0RocMyrma6smdJ0RZC8ik2F9
 gY47XMaVUkd4UG6XryB64QyhT692UVF87ynfs8v68+9jKw+wrc7ljeOkfBGcOCUSEXwp
 Eu4w==
X-Forwarded-Encrypted: i=1;
 AJvYcCXPbI+xuFuvXSVUOC6RydQiYKTbuzP/2kUFzhF9XCSHLOGvPeCzBIzUJ5plJLarVrh/n2wI//x87X8P@nongnu.org
X-Gm-Message-State: AOJu0YxAtVaFRlamsdnkOqNXLHqrkwoUj4V7xX/MJEEVckVwYMp55S2l
 4N2KinduYvNSeC4hKMZyRnYE7epcdMI0uPBhCWcrOzr/4eS3cG8crM+1Ctk2+NQ=
X-Gm-Gg: ASbGncunyTNypeRxXqPEx0qTrdj2RE096yFzbl1QV4IwuDqgL79LybjCXJqGDJPfk8F
 5xyl+s/jPQm9P5Lok39qLUrckWHo/tREn+lNBfpEQKmXksdY6KRAaAFoIn7MR4rRrH6HWRKvXPp
 OQbQzJQEUMPyMUZXcMXjbGfEvmRRyfWwQIA/vnqBB/soHKCU6JoI7PusgiUhAVFhsDj6Y6LrXDi
 gkITjNeRM9d5tjCdr4HTRDq7HBQJnyDBR3Q82yyBuFLT29srktDq3pTHFUB2KhHTyHHzm491BVR
 pUavU4W/lf2u263C50CDi0uIX9h/jjiwfolWSkM7+uhV/uODweS08AjAlkc1qMCR0EYsqCGe6dH
 jlhFNuKJLpTgD
X-Google-Smtp-Source: AGHT+IF0sWtFMgOi9Wu1wkVWl6LqZ8G34vh3+nnBA++fx2Ke+JQhTAoUnfuRnzoGQD+iCNbL0Mximw==
X-Received: by 2002:a05:600c:1912:b0:43b:c5a3:2e1a with SMTP id
 5b1f17b1804b1-43db61d75d3mr84762625e9.2.1743430571416; 
 Mon, 31 Mar 2025 07:16:11 -0700 (PDT)
Received: from [192.168.69.235] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-39c0b662bf9sm11065948f8f.29.2025.03.31.07.16.10
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 31 Mar 2025 07:16:10 -0700 (PDT)
Message-ID: <102ba955-61c4-437b-b535-55e1c93b435f@linaro.org>
Date: Mon, 31 Mar 2025 16:16:10 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/1] goldfish_rtc: keep time offset when resetting
To: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>,
 Anup Patel <anup.patel@wdc.com>, Alistair Francis <Alistair.Francis@wdc.com>
Cc: Frederik Du Toit Lotter <fred.lotter@canonical.com>,
 qemu-riscv@nongnu.org, qemu-devel@nongnu.org, qemu-stable@nongnu.org
References: <20250321221248.17764-1-heinrich.schuchardt@canonical.com>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20250321221248.17764-1-heinrich.schuchardt@canonical.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::333;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x333.google.com
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

On 21/3/25 23:12, Heinrich Schuchardt wrote:
> Currently resetting the leads to resynchronizing the Goldfish RTC with the
> system clock of the host. In real hardware an RTC reset would not change
> the wall time. Other RTCs like pl031 do not show this behavior.
> 
> Move the synchronization of the RTC with the system clock to the instance
> realization.
> 
> Cc: qemu-stable@nongnu.org
> Reported-by: Frederik Du Toit Lotter <fred.lotter@canonical.com>
> Fixes: 9a5b40b8427 ("hw: rtc: Add Goldfish RTC device")
> Signed-off-by: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
> Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
> ---
> v2:
> 	Remove a superfluous intialization to nul.
> 	Add Cc:, Fixes:, and Reviewed-by: tags.
> v1:
> 	https://lore.kernel.org/qemu-devel/CAAhSdy0-we9B19wRRqk_rRFkjY2LPPMRGaTdE=_4Ge_pCR4Y4Q@mail.gmail.com/T/
> ---
>   hw/rtc/goldfish_rtc.c | 13 ++++++-------
>   1 file changed, 6 insertions(+), 7 deletions(-)

Thanks, patch queued!

