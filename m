Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 162C0C46CD2
	for <qemu-devel@archiver.kernel.org>; Tue, 30 Jan 2024 08:21:43 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rUjMa-0000VI-U5; Tue, 30 Jan 2024 03:21:00 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rUjMZ-0000VA-JT
 for qemu-devel@nongnu.org; Tue, 30 Jan 2024 03:20:59 -0500
Received: from mail-ej1-x62e.google.com ([2a00:1450:4864:20::62e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rUjMX-0002kE-RM
 for qemu-devel@nongnu.org; Tue, 30 Jan 2024 03:20:59 -0500
Received: by mail-ej1-x62e.google.com with SMTP id
 a640c23a62f3a-a35e9161b8cso199191566b.3
 for <qemu-devel@nongnu.org>; Tue, 30 Jan 2024 00:20:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1706602856; x=1707207656; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=tpfKHfwRkhm5M2uvL8jlJ4thgcW+XVnyEDvot+QlDZw=;
 b=xd2yVswPzf/LbXlqX9A4GwniJX1hDqWyaI0SyV+ks+ILFlKdyV9VBI3n+3B+P90RY/
 oq0Y5dWlDB9k6AvnFaLpXoYQnhqNDeXyQK200H4g2qe3bq8CneKtqigtqraeTUK2b5JY
 3X8n4AkIb1l7WG4a9eowZFTlP+Dmqk1RePB7sN3wHGw6N19NrFwlCjT3nw2Gxj2igncf
 IQpTnkpmJSVRon4jDGoHV2aBAvbhSqIQIvqZDjjTHQPx7c2ktQ+3eJY12QKt6jvOjJ3z
 IWlVWiqeFX+4soxazGGEGBY4feJkgs/5Vr8lbo3NHREqh9e7/klXE8gy62iQNtRxWCKM
 TyZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1706602856; x=1707207656;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=tpfKHfwRkhm5M2uvL8jlJ4thgcW+XVnyEDvot+QlDZw=;
 b=prFwgAstYgPD1AIq2c9cLyYGwOVzb//8Xw2aNrbuOdmZ15dOp0poATzjtiHCwUwyQe
 +BDCncusOmdIcI28sN5jwb5pw2JNEfBqZudPGAC9N0DNY2Cbe35ApwkNnPhDKWBQlDkT
 GDT4UJ2eKi/ssGcKbD5we+Fzu8xOKTtWG7U/c3UjuYAZ9ClLWnwCxQVlzC+8mLGZY4Ct
 RR4GhxzkEaPWzG4Y03eMjHvrD0XCBsHBJl4ucaXA17SDzfdVbD78e25YPeB3PD/iG3cu
 vXNZbZt/c8LpERc6wZ8qvW9fBoYv76gMxqWH5LVxcAhT1Awg3wDQ8xHhJlrzkv34Colu
 0e6g==
X-Gm-Message-State: AOJu0YwtBSbspwoyYFHkIqSWr/xJj/vKmIaRYSZPXSyUkKnMV4PJk4nL
 izYkdt4CHo1kuB20Kjjyk7vXTvBrb8HdFn9YybT6hDWC5J0Zo10np+esMqzFEiNismSfFmZhD4o
 Y
X-Google-Smtp-Source: AGHT+IFyiwEWNdDVRgvIvzlfBvgXIasWenYhJccpk0wJFqyq8fOQGB+TA1OkDzCuoQyZMBqcIPO7Hw==
X-Received: by 2002:a17:907:1043:b0:a27:6570:adbc with SMTP id
 oy3-20020a170907104300b00a276570adbcmr5507104ejb.33.1706602856125; 
 Tue, 30 Jan 2024 00:20:56 -0800 (PST)
Received: from [192.168.69.100] ([176.187.218.134])
 by smtp.gmail.com with ESMTPSA id
 vu3-20020a170907a64300b00a360ba43173sm716124ejc.99.2024.01.30.00.20.55
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 30 Jan 2024 00:20:55 -0800 (PST)
Message-ID: <7b142c6e-07c4-4f57-bc47-b8490b2810d1@linaro.org>
Date: Tue, 30 Jan 2024 09:20:54 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 01/33] include/hw/core: Add mmu_index to CPUClass
Content-Language: en-US
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
Cc: anjo@rev.ng
References: <20240129233043.34558-1-richard.henderson@linaro.org>
 <20240129233043.34558-2-richard.henderson@linaro.org>
 <238c5053-47d2-42c2-a012-5a88f318e290@linaro.org>
 <ab8d0b2c-4ee0-43ff-98a1-afaf02320dae@linaro.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <ab8d0b2c-4ee0-43ff-98a1-afaf02320dae@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::62e;
 envelope-from=philmd@linaro.org; helo=mail-ej1-x62e.google.com
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

On 30/1/24 08:51, Richard Henderson wrote:
> On 1/30/24 17:46, Philippe Mathieu-Daudé wrote:
>> Hi Richard,
>>
>> On 30/1/24 00:30, Richard Henderson wrote:
>>> To be used after all targets have populated the hook.
>>>
>>> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
>>> ---
>>>   include/hw/core/cpu.h | 3 +++
>>>   1 file changed, 3 insertions(+)
>>>
>>> diff --git a/include/hw/core/cpu.h b/include/hw/core/cpu.h
>>> index 2c284d6397..4385ce54c9 100644
>>> --- a/include/hw/core/cpu.h
>>> +++ b/include/hw/core/cpu.h
>>> @@ -103,6 +103,8 @@ struct SysemuCPUOps;
>>>    * @parse_features: Callback to parse command line arguments.
>>>    * @reset_dump_flags: #CPUDumpFlags to use for reset logging.
>>>    * @has_work: Callback for checking if there is work to do.
>>> + * @mmu_index: Callback for choosing softmmu mmu index;
>>> + *       may be used internally by memory_rw_debug without TCG.
>>>    * @memory_rw_debug: Callback for GDB memory access.
>>>    * @dump_state: Callback for dumping state.
>>>    * @query_cpu_fast:
>>> @@ -150,6 +152,7 @@ struct CPUClass {
>>>       void (*parse_features)(const char *typename, char *str, Error 
>>> **errp);
>>>       bool (*has_work)(CPUState *cpu);
>>> +    int (*mmu_index)(CPUState *cpu, bool ifetch);
>>
>> Can the index ever be negative?
> 
> No.

Then why not return an unsigned type?

>> Would it be useful to also have a mmu_index_max() so we could
>> check mmu_index() is in range in the final cpu_mmu_index()?
> 
> We have NB_MMU_MODES, a target-independent constant.

Ah right.


