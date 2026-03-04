Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F048AEFCE33
	for <qemu-devel@archiver.kernel.org>; Wed,  4 Mar 2026 17:57:07 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vxqSs-0005Pq-5x; Wed, 04 Mar 2026 12:56:54 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1vxqSq-0005Pc-BJ
 for qemu-devel@nongnu.org; Wed, 04 Mar 2026 12:56:52 -0500
Received: from mail-pl1-x62b.google.com ([2607:f8b0:4864:20::62b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1vxqSo-0000KA-J2
 for qemu-devel@nongnu.org; Wed, 04 Mar 2026 12:56:52 -0500
Received: by mail-pl1-x62b.google.com with SMTP id
 d9443c01a7336-2aaf59c4f7cso32764065ad.1
 for <qemu-devel@nongnu.org>; Wed, 04 Mar 2026 09:56:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1772647009; x=1773251809; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
 :to:content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=yujQbXx9ep/Dg1gAtxd3zBTRU1BfVfRuYXXRipd8iDA=;
 b=TUi322AlU+veEpXTad/bYApniiPIwE2mBROEhHaY5aZMgXLZIqlmIpau+Fl88YlykE
 /mfABGC2jvV+LfHafrVfCDpk5eqpANc7PnolKFZ2VDvuSQNMrKIsninOJnCuK5tdo3Z0
 esXdt6XSzQh62m7oIXRP8WbsevFB4I+pXEDZERBFyyxRAR+3nWMVtDF6SJDK2hBrEv7Q
 gHUsAfut6KQnLcmOxd9VWNaL31Zkm8Wq2Df3GeVa1ghkJzzAUZdc4hmh9g+bLI4GqbZ1
 uGK/Rq2NWNQ3Puz2t7kMzc4yChmwD75oO0YVP3RyUqdc9K+5EubK+kAyleZQ2buW2eQL
 Wndg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1772647009; x=1773251809;
 h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
 :to:content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=yujQbXx9ep/Dg1gAtxd3zBTRU1BfVfRuYXXRipd8iDA=;
 b=NP/KHyocMcZ+8APUG8vTtI64qavV6xB+1/zwErp+UtT9vn+vs9icvw7EMGKvctF+Xb
 a/9XqKMlvVXYCzlNRtPkYOkXCg9i1g2QeuSucfBAL+KKI8Q2+agCKTOdNv9OccwOboI8
 lOPbAs5fpDw1/Pq62F1OCOJz07GkNFxkX7p47xeLWh/dj1sMFnYZKHH3nHpHxefBhs+3
 Z3O8pfVcMCyCAQEEX72ATGhybYwwF6i0UHLao86hg7OfeQyDgh74rrO/I1oVL+VRN9MI
 +rF8faoShCs0UjVBcESZUWoJserZu83JSZYh2ii5vv0Nnv4gcw/GqzbuETeb8Az+qqhl
 QPfg==
X-Forwarded-Encrypted: i=1;
 AJvYcCU2xOE6IgT0kUOmo8j/hmOtKZygkVzeoKsiKbMMnCcLCk3UTmTWxlFH4a8wObiU6vwY53xWFKx0XkcB@nongnu.org
X-Gm-Message-State: AOJu0YyxVNYZd7vbEWfvN4so7VSBxBrdXdDr/jrvxWpzEWKmJhDGIACg
 9vgxYvKuWTISOKy3cNyy8oJa7vvkpELnwIWgE0dLp3TLyURJECp7bcfmmpf6kSEsbGQ=
X-Gm-Gg: ATEYQzye2J4zq3Dlujrak9anDdQPnZoOdXKsTuyGvEdy0nD2bBcs+dde7jQP9fiAWW9
 5pefGWctANLNmItMmbxB5fxp7NfuDDGSrBZyQwNznXT1NJlxY+cnRtMcOhsYu7yWtsx9vJXaWAN
 GYybZ5TogrvirocH49cBfxpRnLDjEmpO3AVgOjpSfbs3Y5Kt8BMr9kA5H9SblJNiiPNg834ztv+
 LzR9kx2oGHFd0QtK4NDP9qbbuiQ3c4JzZZBjm2oC1EaqyKePBG+BLVYe6eEZXQm7LXMo3cZX8nQ
 RL8AG4E2DxtJhv2YpeadaJWxNsq2wnOYHl3leess90hpIuJcBcSi83vxxbBxw3kl1Epp4LFLr12
 spP8aJ1ln+4fe48FKRID4VnF9HQ3KQC2fT8uXf4rK5oH5lcalaj1lwRIzNXhpzKFeRVzI4bsZUs
 L3n8zix/QFU55mktsCHMDDUQ4PuGxHx7WDbnSY2L7eqV/DsjYm1Kgiq1/UtO90eO2GLdQA
X-Received: by 2002:a17:903:46c8:b0:2ae:6364:e6f1 with SMTP id
 d9443c01a7336-2ae6a9c77fdmr32512465ad.1.1772647008915; 
 Wed, 04 Mar 2026 09:56:48 -0800 (PST)
Received: from [192.168.1.87] (216-71-219-44.dyn.novuscom.net. [216.71.219.44])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2ae5e1699c9sm56853655ad.10.2026.03.04.09.56.48
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 04 Mar 2026 09:56:48 -0800 (PST)
Message-ID: <9e830f45-840b-4e5a-8548-c618663f9500@linaro.org>
Date: Wed, 4 Mar 2026 09:56:48 -0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 4/7] tests/tcg: add tests for qemu_plugin_set_pc API
Content-Language: en-US
To: Florian Hofhammer <florian.hofhammer@epfl.ch>, qemu-devel@nongnu.org
Cc: =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Laurent Vivier <laurent@vivier.eu>, berrange@redhat.com,
 richard.henderson@linaro.org, imp@bsdimp.com
References: <20260303-setpc-v5-v6-0-15c77cfe184e@epfl.ch>
 <20260303-setpc-v5-v6-4-15c77cfe184e@epfl.ch>
 <430d1aa6-c36c-4399-8e5f-b38a9ae1bd35@linaro.org>
 <5b8bbc1e-cb8b-44ea-822b-0bdcb6ac225f@epfl.ch>
 <5a9a17dc-9781-418c-ae23-a183234e4a53@epfl.ch>
 <eb4a6f15-a63c-48aa-a7c0-832d123b98f5@epfl.ch>
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
Autocrypt: addr=pierrick.bouvier@linaro.org; keydata=
 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
 ZtfdHNZotF092MIH0IQC3poExQpV/WBYFAI=
In-Reply-To: <eb4a6f15-a63c-48aa-a7c0-832d123b98f5@epfl.ch>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62b;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-pl1-x62b.google.com
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

On 3/4/26 8:18 AM, Florian Hofhammer wrote:
>>>>> +static bool vcpu_syscall_filter(qemu_plugin_id_t id, unsigned int vcpu_index,
>>>>> +                                int64_t num, uint64_t a1, uint64_t a2,
>>>>> +                                uint64_t a3, uint64_t a4, uint64_t a5,
>>>>> +                                uint64_t a6, uint64_t a7, uint64_t a8,
>>>>> +                                uint64_t *sysret)
>>>>> +{
>>>>> +    if (num == 4095) {
>>>>> +        qemu_plugin_outs("Communication syscall detected, set target_pc / "
>>>>> +                         "target_vaddr\n");
>>>>> +        source_pc = a1;
>>>>> +        target_pc = a2;
>>>>> +        target_vaddr = a3;
>>>>> +        if (source_pc >> 63 || target_pc >> 63 || target_vaddr >> 63) {
>>>>> +            /*
>>>>> +             * Some architectures (e.g., m68k) use 32-bit addresses with the
>>>>> +             * top bit set, which causes them to get sign-extended somewhere in
>>>>> +             * the chain to this callback. We mask the top bits off here to get
>>>>> +             * the actual addresses.
>>>>> +             */
>>>>
>>>> This looks like an actual bug. Using a backtrace here, can you find which function extended it?
>>>> Parameter should be treated as unsigned everywhere, else something is really going wrong.
>>>
>>> tl;dr: register values are considered signed in the syscall handling
>>> code, which seems incorrect to me. Details below.
>>>
>>> This seems to be a bigger issue in the syscall handling code and I'm
>>> surprised this never surfaced before. Generally, the CPUArchState struct
>>> in target/*/cpu.h defines the registers as unsigned types. When a
>>> syscall is encountered, the main cpu loop calls do_syscall() from
>>> linux-user/syscall.c, which takes and returns abi_long values. abi_long
>>> is defined as either int32_t or target_long in include/user/abitypes.h
>>> and therefore a signed type, so the register values get converted from
>>> unsigned to signed types here. do_syscall() passes those abi_long values
>>> on, e.g., to record_syscall_start() and send_through_syscall_filters(),
>>> which still take the register values in as abi_long. Those in turn
>>> however pass the values on to qemu_plugin_vcpu_syscall() and
>>> qemu_plugin_vcpu_syscall_filter(), respectively. Those two functions now
>>> take uint64_t values for the arguments, so for 32-bit architectures the
>>> conversion chain is uint32_t (CPUArchState) -> int32_t (do_syscall) ->
>>> uint64_t (callbacks).
>>>
>>> This seems to be some bigger refactoring changing all those abi_longs to
>>> abi_ulongs. Would you like me to prepare a separate patch series for
>>> this?
>>

Indeed, they are signed in linux-user, so maybe my original assumption 
that it *should* be unsigned is wrong. Let me take a look to see what 
should be the correct semantic here.

>> As a follow-up on this, changing this seems to be a bit more complicated
>> than I initially thought. The arguments could be simply made unsigned,
>> but the return value (which is also just a register content and should
>> therefore be unsigned if I understand correctly) can't easily be made
>> unsigned. The per-target main loop relies on the return value of
>> do_syscall() to be signed to determine whether one of the QEMU-specific
>> errors (e.g., QEMU_ERESTARTSYS) was returned.
> 
> Note: some architectures already define the return value as unsigned in
> the main cpu loop and implicitly cast the return value of do_syscall().
> Given that in theory, a syscall's return value could always coincide
> with the values of QEMU's special errors, I'm wondering whether it would
> make sense to make do_syscall()'s return value unsigned and signal those
> special error codes out-of-band instead of in the syscall return value,
> e.g., either via a separate pointer argument to do_syscall() or by
> making do_syscall() return a struct containing both the return value and
> a potential error code.
>

It could be a solution. I'm just a little bit relunctant to make such a 
change now because we have limited time (soft freeze is coming next 
week), so not the right time to make such deep changes and... it has 
been working like that for long time.

> But maybe I'm getting ahead of myself here, please let me know what you
> think!
>
Thanks for your very good analysis. I'll come back once I have more 
information about what should be the correct fix.

Meanwhile, and because we are close from softfreeze, just keep the 
current hack in the test. This way, we can focus on sending your series 
and the additional comment patch you sent.

Thanks,
Pierrick

