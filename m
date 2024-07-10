Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C8DC1C3DA47
	for <qemu-devel@archiver.kernel.org>; Wed, 10 Jul 2024 14:42:16 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sRYW3-0004TO-Tp; Wed, 10 Jul 2024 10:41:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1sRYW1-0004RS-EX
 for qemu-devel@nongnu.org; Wed, 10 Jul 2024 10:41:53 -0400
Received: from mail-pl1-x632.google.com ([2607:f8b0:4864:20::632])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1sRYVu-0000j3-3O
 for qemu-devel@nongnu.org; Wed, 10 Jul 2024 10:41:53 -0400
Received: by mail-pl1-x632.google.com with SMTP id
 d9443c01a7336-1fb0d7e4ee9so41939635ad.3
 for <qemu-devel@nongnu.org>; Wed, 10 Jul 2024 07:41:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1720622504; x=1721227304; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=oqPuOV35hS4wUFu0YtiEejYDbu7rppufXjp6qX6lfOg=;
 b=NRctRgcSZBN79rLvLG4xpH4hXQ5ABFjc3QEwZZh6HkWvNACnhCOffcDh85QOmEbz/3
 CqDv2FEG6YyoJVB+pLmhF0YZuFPCz48iE8nhchYRqbV1/Ma/Y6m0diJ5pmL2UBIRv+wD
 R4cpsHA1eeb0icyoYxkavnqkAs9hoAWEndAMNHJM1L5BwuPb9FpF8mg+lOw3267VeXDw
 +jTNs2Qg6F5/Fa6VIUrPqpwpZFZqxO64DDgHVOdKXIKv2oUyUHMGJU8tuYboSF3EM+hJ
 IwK9f5EJnKuZ3DJQOFw0aNqhyAVWXmjyhoDOw+/T2jOFMcuGRI3v7moevUcHm/MCqq1y
 UYUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1720622504; x=1721227304;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=oqPuOV35hS4wUFu0YtiEejYDbu7rppufXjp6qX6lfOg=;
 b=aSJDZSqb+TxoARKohkWsK+L5gS+UwtzowD+3H0Yf50A0oKnWhNCwG+mxHWi0GysW8t
 hFmeqtdpVKu1FbCwyc4XsocpnYH4/8oCm1Ph/iL9zZjHWwKBwiicMeAsICMga44LhM2j
 ZhsF1UcnqwNSTMatGwXC3ilD2LIigTM64F617nr4QE0+F7mk/wg4LytvfNVZIVZ6fBzV
 GUIDvbbfD1hVgG80PZvHyWWrchUJ63IiE0R5VWgfe7Abqx0wk/fynS0LF05NL2zekGja
 8e/DfC56YzNhskiiWsLuS3b7TmAJFQgtt50lXdyQDuj75vQlstacyIZFm9LoN9HTNZo1
 8/3w==
X-Gm-Message-State: AOJu0Yzjash3iq7qMtXyJ1BFcvNa8awBAo6zJliIa4Zdfl7zjghRPrkw
 MF+AUOhnKQllideE1eTuz4T32ZkJQqtLYLD0XU3WQ4HivjO7Be598hXqtFJYW98=
X-Google-Smtp-Source: AGHT+IFbs4TT7vMCDH+ubHVbFwrUacP6v93UFF/qlSYXIZ8TQ3lYyyVWLvvhxJ/ujFGbFXavrC2Zug==
X-Received: by 2002:a17:902:e54d:b0:1fb:44e1:b5d6 with SMTP id
 d9443c01a7336-1fbb6d43a23mr46456035ad.23.1720622504208; 
 Wed, 10 Jul 2024 07:41:44 -0700 (PDT)
Received: from [192.168.0.4] (174-21-76-141.tukw.qwest.net. [174.21.76.141])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-1fbb6a1083bsm34569895ad.37.2024.07.10.07.41.43
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 10 Jul 2024 07:41:43 -0700 (PDT)
Message-ID: <884fdcec-f1ba-483d-99e5-ec22ed7187fa@linaro.org>
Date: Wed, 10 Jul 2024 07:41:41 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 08/13] target/ppc: Merge helper_{dcbz,dcbzep}
To: BALATON Zoltan <balaton@eik.bme.hu>
Cc: qemu-devel@nongnu.org, qemu-arm@nongnu.org, qemu-ppc@nongu.org,
 qemu-s390x@nongnu.org, qemu-riscv@nongnu.org, max.chou@sifive.com
References: <20240710032814.104643-1-richard.henderson@linaro.org>
 <20240710032814.104643-9-richard.henderson@linaro.org>
 <e5887250-eabd-f04b-e95f-0ea27ad8876a@eik.bme.hu>
Content-Language: en-US
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <e5887250-eabd-f04b-e95f-0ea27ad8876a@eik.bme.hu>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::632;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x632.google.com
X-Spam_score_int: 4
X-Spam_score: 0.4
X-Spam_bar: /
X-Spam_report: (0.4 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1, DKIM_VALID=-0.1,
 DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_DNSWL_NONE=-0.0001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 SUSPICIOUS_RECIPS=2.51 autolearn=no autolearn_force=no
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

On 7/10/24 05:20, BALATON Zoltan wrote:
> On Tue, 9 Jul 2024, Richard Henderson wrote:
>> Merge the two and pass the mmu_idx directly from translation.
>> Swap the argument order in dcbz_common to avoid extra swaps.
>>
>> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
>> ---
>> target/ppc/helper.h     |  3 +--
>> target/ppc/mem_helper.c | 14 ++++----------
>> target/ppc/translate.c  |  4 ++--
>> 3 files changed, 7 insertions(+), 14 deletions(-)
>>
>> diff --git a/target/ppc/helper.h b/target/ppc/helper.h
>> index afc56855ff..4fa089cbf9 100644
>> --- a/target/ppc/helper.h
>> +++ b/target/ppc/helper.h
>> @@ -46,8 +46,7 @@ DEF_HELPER_FLAGS_3(stmw, TCG_CALL_NO_WG, void, env, tl, i32)
>> DEF_HELPER_4(lsw, void, env, tl, i32, i32)
>> DEF_HELPER_5(lswx, void, env, tl, i32, i32, i32)
>> DEF_HELPER_FLAGS_4(stsw, TCG_CALL_NO_WG, void, env, tl, i32, i32)
>> -DEF_HELPER_FLAGS_2(dcbz, TCG_CALL_NO_WG, void, env, tl)
>> -DEF_HELPER_FLAGS_2(dcbzep, TCG_CALL_NO_WG, void, env, tl)
>> +DEF_HELPER_FLAGS_3(dcbz, TCG_CALL_NO_WG, void, env, tl, int)
>> #ifdef TARGET_PPC64
>> DEF_HELPER_FLAGS_2(dcbzl, TCG_CALL_NO_WG, void, env, tl)
> 
> Why only dcbz but not dcbzl as well to make them uniform?

Because dcbzl has extra logic, so doesn't get merged.
The expansion of ppc_env_mmu_index() is not large, so there's no gain in passing it in.

The point was to eliminate duplication where it was easy.


r~

