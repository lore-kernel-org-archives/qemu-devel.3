Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 38787C87FD3
	for <qemu-devel@archiver.kernel.org>; Sun,  3 Aug 2025 01:15:57 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uiNK4-0000hx-V8; Sat, 02 Aug 2025 21:15:37 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1uiNJb-0000Ji-2B
 for qemu-devel@nongnu.org; Sat, 02 Aug 2025 21:15:14 -0400
Received: from mail-yw1-x112c.google.com ([2607:f8b0:4864:20::112c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1uiNJX-0000su-1g
 for qemu-devel@nongnu.org; Sat, 02 Aug 2025 21:15:04 -0400
Received: by mail-yw1-x112c.google.com with SMTP id
 00721157ae682-717b580ff2aso29489267b3.0
 for <qemu-devel@nongnu.org>; Sat, 02 Aug 2025 18:15:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1754183701; x=1754788501; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=ntj8FEQwbXAfJHTNi00ZVz0CGHm/kh4v/LPxbPz56Wo=;
 b=O0Pyz8AacdZ9aIzG8i1bXlGOKaRJYSYs9gOFZ8HrDWIb+2DGtsspL5u/Re3R2Kybxc
 OjpE4Q2rKBR0Dqlwsan3FrHy0PRlTn0cZM4+MRIV7ZDur68xb/XBPafqWUMUQ4CgP/M/
 lSeriGN0ETTJhyb5G2saqTDAOlZceVu/CqJZJVMJl4OZO1x6hE3KXubbpXfhVvjeTkAp
 ZHO0CQfFY4UIfw5WaW76Pjvoa29Se94aGZL3vmWcpvnxMqogisDHA0LBFTw9CHJlMnaw
 ZRIvQyEDGblS20GRIhO9fmQfsZagApJfNB1qh8cA312uRla2NqUeiqb44S2YouApTjwD
 ZzGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1754183701; x=1754788501;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=ntj8FEQwbXAfJHTNi00ZVz0CGHm/kh4v/LPxbPz56Wo=;
 b=T8ymthAClyW+mnQyyelOsEWOWl/+IUaFSDUrV1iM/Kw7dk9v2EH50sKOr7ouubpfdf
 NrRelJZA34pqFN9gYhgpxRXfXBO9yAZXv2UMlem7Yr7inkJt59UuZxMt3FQYJITFDz6J
 GgI7vMEVk/pvIMniTnw4uxoN3X6ZGsQU79cmEZAZpgY6kVZpeGG1QKhjdO1H4SdTwHtI
 bQJqKmTHM5s1I54oAqySjrggn8fJgmkXquYszi5kbS4FnIKs5KH82yhJwMsSlwC8lHyI
 xr8A8r9MrM4vnyBjAx3+ctPTtxeNt+RDgbqYr6PpvY4/kTOEEdLGAG7XCgDmhZbLd9Ox
 JOUA==
X-Gm-Message-State: AOJu0Yw0rRrfDeHxGmCSfB2id7WijpMCnHyeEIbzfcpjlF5ed2VGm0zP
 RU5KRG1xpdCp1Z3hDkGoPa3WejvCQmLGPKfedZhio66bpK3Ux3mTdQpjZ5IzPspJkuaE4nJFKjQ
 Uesiggbs=
X-Gm-Gg: ASbGnctSt2OoIb1xs4xr1wefp2bT3CO3K8CkymD2dyetKGRDknrE3ivWXWb83b5cWan
 rxU6U/xF3ynBLlPCuLRGKX9aiPYPFnbfXbLv6B745ivqJZj3RuDmqSZEbo4jQ0HQ8ZT33NdkSpk
 1MO0fSqO/zSXU7s2J9vf9bO5thGbwiVjDz5cPeznawUKu7tmdwR3CxEum3Dr8LhkohRjyjk/j8L
 iNlonxmc3h3Ypbp7ziIA4IqM3VXC2VBcgAMiGda54Pjr0v/GtBZlpkOEsGpUp2yM9aoahuIPu2v
 zRDhNBEdwnJH77Ns7RFzuTPpUMuKMbAJxV/yfohzbqKN6U/b7NYheLjS4jLYnmJphldPIOL8EOA
 isfsMD/rusp495grFHSMihDidM4g2w6mGJ4fsNtNEQYkTcltwuzcQNdu3HUO/coCq
X-Google-Smtp-Source: AGHT+IH/LNs3FT1D+2khzATS4M3FaKXuBVtXZnzddXkW03UMmOJBWAW04VA+7NodBzDxWNQvFJD3VA==
X-Received: by 2002:a05:690c:8694:20b0:71a:413d:5668 with SMTP id
 00721157ae682-71b7f3cb253mr32756747b3.11.1754183701301; 
 Sat, 02 Aug 2025 18:15:01 -0700 (PDT)
Received: from [10.153.194.227] ([172.58.111.133])
 by smtp.gmail.com with ESMTPSA id
 00721157ae682-71b5a3f5fb0sm18725737b3.23.2025.08.02.18.14.58
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sat, 02 Aug 2025 18:15:01 -0700 (PDT)
Message-ID: <306b4d65-fe44-4754-90bc-fc3f50e8f53f@linaro.org>
Date: Sun, 3 Aug 2025 11:14:52 +1000
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 04/14] whpx: ifdef out some x86-only code paths
To: Mohamed Mediouni <mohamed@unpredictable.fr>
Cc: qemu-devel@nongnu.org
References: <20250802081800.76030-1-mohamed@unpredictable.fr>
 <20250802081800.76030-5-mohamed@unpredictable.fr>
 <712da351-3bf6-4a31-92e6-b198d5dc21ff@linaro.org>
 <533A5BF2-9CD5-4FE1-99A7-6E9FB212CCBC@unpredictable.fr>
 <9904edf1-9419-4dd7-ae82-1c4668a3a98e@linaro.org>
 <1652BD3B-0721-49F8-93A0-F5DEEAFD52AE@unpredictable.fr>
From: Richard Henderson <richard.henderson@linaro.org>
Content-Language: en-US
In-Reply-To: <1652BD3B-0721-49F8-93A0-F5DEEAFD52AE@unpredictable.fr>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::112c;
 envelope-from=richard.henderson@linaro.org; helo=mail-yw1-x112c.google.com
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

On 8/3/25 11:08, Mohamed Mediouni wrote:
> 
> 
>> On 3. Aug 2025, at 03:03, Richard Henderson <richard.henderson@linaro.org> wrote:
>>
>> On 8/3/25 10:55, Mohamed Mediouni wrote:
>>> Arm WHPX has no specific functionality for debugging today, but we could support kernel mode breakpoints via replacing them by an unhandled hvc #2, stubbing might be the right route to go...
>>
>> Surely the debug registers are usable?  In the meantime, stub functions which do nothing are better than ifdefs wherever possible.
> The debug exception goes to EL1 if we do so instead of the hypervisor because there aren't exit bitmaps/a debug trap API on arm64 WHP to make the HV vmexit in that case

Huh.  I thought I remembered some el2 debugging.  Oh well.
Leaving it support as stub functions is good enough for now.


r~

