Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0AC19C46CD2
	for <qemu-devel@archiver.kernel.org>; Sun, 28 Jan 2024 00:38:29 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rTtB3-00033w-Gk; Sat, 27 Jan 2024 19:37:37 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1rTtAx-00033d-N2
 for qemu-devel@nongnu.org; Sat, 27 Jan 2024 19:37:31 -0500
Received: from mail-oi1-x233.google.com ([2607:f8b0:4864:20::233])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1rTtAv-0006Zy-TH
 for qemu-devel@nongnu.org; Sat, 27 Jan 2024 19:37:31 -0500
Received: by mail-oi1-x233.google.com with SMTP id
 5614622812f47-3bd4e6a7cb0so1178680b6e.3
 for <qemu-devel@nongnu.org>; Sat, 27 Jan 2024 16:37:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1706402248; x=1707007048; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:references:cc:to:from
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=n8p1dgxEKaBROB4mEow15EYRrrmzd45j7LldFuDEV60=;
 b=hUYBSNX+vzJfJBXJH+T3Y0lKABM1EwqJ9jpqckdacQBNezl8oR0yATNdtZrjdBILOb
 jc0tixrfd+fUOapLeI1yPdt7YNX2AsvXxGcAJN4TkrDkYyV91BNsleZiZUWsWDjr9wO2
 YpweTvMUMhjqghHJ7BEYD1BsdCyMUAWTYZVXCzKWyIRGX65YTXT/FYXZ89HOm8T/jbqP
 7YaW+1WfrRBLszs771bEh3T/R06L2zue6JoyE5lm50+SSXxNjuAp4TF3/KfRzw0JBleZ
 nbMuU9wnnq4MwjN9BeSGZo7tife1K3B3Qp7qZTBAk0fGa501/dYuAPSZsH9Q+TQLmtid
 sXmg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1706402248; x=1707007048;
 h=content-transfer-encoding:in-reply-to:references:cc:to:from
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=n8p1dgxEKaBROB4mEow15EYRrrmzd45j7LldFuDEV60=;
 b=XCoiX4ct+Uhznti/ofVm51EjzCkbmFpfv1h+R/UZuob9etvIdpyrqhcA0Cu+y+pHCs
 P9p4V8JJB7QVB5C+dPQhDo2Afr5RLR5NdZl9w2Ac7Epu7GD5JT+QQHmU+9oJzIkkRLDP
 KDz0cOUJG27QytqMEhS1BRpw9M3GSoQ05Q3KxP0vsGooVwXP5zlsJJtYVltV6iYKdrNe
 xEN0Ynh90YL0qjMiezcopaA+ccdlJ6gPuPbo6PH59ftFvAFww9XxdYsp8AzdlKBkRFDy
 OYp8uQYahwnnup3VByQr4kOml1dDz/Sx1yHX28KQs48BpHkZHAaGhHhXM5ecjGQOyZIV
 v+7g==
X-Gm-Message-State: AOJu0YyLOZrAfNKp2fq1APfgDF/bMy7HaLLRVQsU/Zme/u1sgjcJzS7o
 DxV8zuzoRCQPSlDVK4V0phKwdjNosrNFxSc8pNBxJz9JoYpX1Ct+9jpghLDcrfs=
X-Google-Smtp-Source: AGHT+IGAQyan4n6weQzszfc66sRqFdDiY5PVkR/gCqrv6/nrdmOyyR6yTZUwPMoasQ7PQ++SaMBLaA==
X-Received: by 2002:a05:6808:4488:b0:3be:3de9:68eb with SMTP id
 eq8-20020a056808448800b003be3de968ebmr466806oib.39.1706402248276; 
 Sat, 27 Jan 2024 16:37:28 -0800 (PST)
Received: from ?IPV6:2001:44b8:2176:c800:5c13:51aa:e666:7387?
 ([2001:44b8:2176:c800:5c13:51aa:e666:7387])
 by smtp.gmail.com with ESMTPSA id
 lo1-20020a056a003d0100b006d9b2694b0csm3232818pfb.200.2024.01.27.16.37.25
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sat, 27 Jan 2024 16:37:27 -0800 (PST)
Message-ID: <df0bd33a-90c6-4499-a368-a4f12d28b014@linaro.org>
Date: Sun, 28 Jan 2024 10:37:20 +1000
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH 17/34] hw/core: [CPUTLB] Move target specifics to end
 of TCGCPUOps
Content-Language: en-US
From: Richard Henderson <richard.henderson@linaro.org>
To: Anton Johansson <anjo@rev.ng>, qemu-devel@nongnu.org
Cc: ale@rev.ng, philmd@linaro.org
References: <20240119144024.14289-1-anjo@rev.ng>
 <20240119144024.14289-18-anjo@rev.ng>
 <c79c2c68-8f0d-40ae-95db-b7ccb7bf438e@linaro.org>
In-Reply-To: <c79c2c68-8f0d-40ae-95db-b7ccb7bf438e@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::233;
 envelope-from=richard.henderson@linaro.org; helo=mail-oi1-x233.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

On 1/24/24 10:43, Richard Henderson wrote:
> On 1/20/24 00:40, Anton Johansson wrote:
>> TCGCPUOps contains an extra function pointer when included with
>> NEED_CPU_H, these are moved from the middle to the end of the struct. As
>> such offsets to target independent function pointers don't vary in
>> target specific and independent code.
>>
>> [Move target specfic fields to separate struct?]
>>
>> Signed-off-by: Anton Johansson <anjo@rev.ng>
> 
> Or make these unconditional.  Move fake_user_interrupt into the CONFIG_USER_ONLY block and 
> do_interrupt into the system block.

I have split the patch in two, made fake_user_interrupt unconditional, and queued.


r~


