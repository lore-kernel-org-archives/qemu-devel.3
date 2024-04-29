Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 542AAC4345F
	for <qemu-devel@archiver.kernel.org>; Mon, 29 Apr 2024 21:23:28 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s1YT2-0004tw-2p; Mon, 29 Apr 2024 17:23:20 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1s1YSu-0004rR-Sd
 for qemu-devel@nongnu.org; Mon, 29 Apr 2024 17:23:13 -0400
Received: from mail-lf1-x130.google.com ([2a00:1450:4864:20::130])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1s1YSr-00024X-9J
 for qemu-devel@nongnu.org; Mon, 29 Apr 2024 17:23:12 -0400
Received: by mail-lf1-x130.google.com with SMTP id
 2adb3069b0e04-516d3a470d5so6142889e87.3
 for <qemu-devel@nongnu.org>; Mon, 29 Apr 2024 14:23:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1714425787; x=1715030587; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:content-language:references
 :to:from:subject:user-agent:mime-version:date:message-id:from:to:cc
 :subject:date:message-id:reply-to;
 bh=ijjvjcP7rji01E+OHmfsRQmWcG5uS8IX+qjX3deUG2o=;
 b=yFHjJQgBCLyM0HKmaK3yh+0qZhUTvEmuRFrugkhoGB4zJ6UnAW+auCpzMPQ7JWyTE/
 4i/jLpN1r8IBwso3nTYsTwgCmKyCjMPmyZEHk1xqbXCsG2296XptyiFuaaF/irPsTfmX
 2a/KQzt7Ad+L7cjlCtgR/VlfLmhuGjZppcYCo6sH3EHstmPFQtHk2pbJXlp+8j24FUy2
 +bih6hI7PD7gVSRUI/si+CWntc9i+3fKW/6ptNcPN7t88IEVmxfZhwHdPZf6NpGYHKpR
 MpnL7sF3OiL6zG8yP5La/zXM5uY1N5EM5ODtv9+2s+PyamnIKcRI/yvy0Uc43wL8htTe
 KBjw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1714425787; x=1715030587;
 h=content-transfer-encoding:in-reply-to:content-language:references
 :to:from:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=ijjvjcP7rji01E+OHmfsRQmWcG5uS8IX+qjX3deUG2o=;
 b=RSyEIgOqQz3ki1F1VJ06E6k8OF/5A33We1CXQGHQPzr7lERIHdjpw0mxFAf+SS5Gc9
 LlXZhZXqFgsj4QWkmNji3Eu+bDoavOVwjd4fjs+TMcV2J2Pw5dcoG0pzJEvPOOZrhssX
 cmKQ/PaNpL17oOyieyu//O4Zb5NuH1gO6eOeX06PRFG1mNSEZjNoE1MZwHwNgT/hlmC6
 wo7gryBtWaeEEp0FZR7WNI7WueR5/LGkUQMSLrHoTPLqCPwqsON+LMSWOcfeAQTT/1cP
 y8WJ/7+Wq+l1h00ReqTxi9m+SaLBagT7zUUtWAUNazbYGO7Nv3kPIg8U6fXTvhgyeCSY
 orOQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCVVoqrvi+yCzCSMa2HZxJ0ABUqY6Z3IDqopt8d5pEp7cQTbG7qNPsfap4MlVG19S5QBmXSPt+MlOrHWwcxv9maJ6CcVB9o=
X-Gm-Message-State: AOJu0Yw1w/cvr2tj3JDz1jlnXCfifRDZonvQxzlnXNyM+Y+6/65WBE6T
 mmC1Rkldbuh3xd4LdsBaNsKzYV/FQRdIEpsF7X3wynnHQ1oVpWVbnXBb7pKMzX0=
X-Google-Smtp-Source: AGHT+IFvA+NuZj5waGlEEBIK6cKXRr+QnttoDFMgi0VcJDbO5LZA89uKAA3IV5yzVGidttMgW1CwRQ==
X-Received: by 2002:ac2:4c27:0:b0:51a:1f56:f96d with SMTP id
 u7-20020ac24c27000000b0051a1f56f96dmr7098242lfq.51.1714425786900; 
 Mon, 29 Apr 2024 14:23:06 -0700 (PDT)
Received: from [192.168.69.100] (bny92-h02-176-184-44-142.dsl.sta.abo.bbox.fr.
 [176.184.44.142]) by smtp.gmail.com with ESMTPSA id
 rn2-20020a170906d92200b00a55a67a81c8sm10784638ejb.126.2024.04.29.14.23.06
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 29 Apr 2024 14:23:06 -0700 (PDT)
Message-ID: <7a592afc-bf95-4b82-b996-788ed1fa99ae@linaro.org>
Date: Mon, 29 Apr 2024 23:23:05 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 09/12] accel/tcg: Restrict cpu_loop_exit_requested() to
 TCG
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
References: <20240428214915.10339-1-philmd@linaro.org>
 <20240428214915.10339-10-philmd@linaro.org>
 <28f02378-b01a-4986-9dcd-9c397297d25a@linaro.org>
 <92fb184a-9301-4dd0-9271-7c169449e5a5@linaro.org>
Content-Language: en-US
In-Reply-To: <92fb184a-9301-4dd0-9271-7c169449e5a5@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::130;
 envelope-from=philmd@linaro.org; helo=mail-lf1-x130.google.com
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

On 29/4/24 00:17, Philippe Mathieu-Daudé wrote:
> On 29/4/24 00:08, Richard Henderson wrote:
>> On 4/28/24 14:49, Philippe Mathieu-Daudé wrote:
>>> cpu_loop_exit_requested() is specific to TCG, move it
>>> to "exec/translate-all.h".
>>>
>>> Signed-off-by: Philippe Mathieu-Daudé<philmd@linaro.org>
>>> ---
>>>   include/exec/exec-all.h       | 17 -----------------
>>>   include/exec/translate-all.h  | 20 ++++++++++++++++++++
>>>   target/arm/tcg/helper-a64.c   |  1 +
>>>   target/s390x/tcg/mem_helper.c |  1 +
>>>   4 files changed, 22 insertions(+), 17 deletions(-)
>>
>> I guess we could dither about whether this is the best place, but I 
>> guess it doesn't matter.  Do you really need the CONFIG_TCG ifdef?
> 
> Right, actually 50 patches later it ends in "exec/cpu-loop.h",
> and "exec/translate-all.h" is removed. I need to check whether
> or not this patch is required at this stage, maybe not. Otherwise
> I'll directly introduce "exec/cpu-loop.h" I guess.

So we need it at this point because cpu_loop_exit_requested()
access neg.icount_decr, which we'll restrict in few commits
(I'll mention that in the commit description).

In "exec/translate-all.h" we don't need the CONFIG_TCG #ifdef,
but we'll need it in "exec/cpu-loop.h".

>> Either way,
>> Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
>>
>>
>> r~
> 


