Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5BA31E77197
	for <qemu-devel@archiver.kernel.org>; Tue,  7 Jan 2025 08:53:58 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tV5Kv-0005mw-84; Tue, 07 Jan 2025 03:53:18 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tV5Kj-0005kI-95
 for qemu-devel@nongnu.org; Tue, 07 Jan 2025 03:53:05 -0500
Received: from mail-wr1-x432.google.com ([2a00:1450:4864:20::432])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tV5Kh-00011y-GF
 for qemu-devel@nongnu.org; Tue, 07 Jan 2025 03:53:05 -0500
Received: by mail-wr1-x432.google.com with SMTP id
 ffacd0b85a97d-385d7b4da2bso12921677f8f.1
 for <qemu-devel@nongnu.org>; Tue, 07 Jan 2025 00:53:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1736239980; x=1736844780; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=NB+uT1ZGTxOF5kMHAIvom8Vcx46Zc94qv30ZNIEEzFg=;
 b=AANAWngIz7Gaf/Q6iQ4SLPMqbIxxNqcujs7pe2G2cUl4iuTqmqa7PkfaS0FfHE8wT8
 dE5xfK0HuHkrFFbybXWQByYjzzKrItGkeG4vwTCA6OEM6V93uy6yWL3oLbwQOuhZzoV2
 uWds/S0Dh4FKnZVApDE/z/x1WQmBemEbR8c0DH4gC5CPz9caBNwglj7r+PoJQ4GPKQl9
 KoAafK34+0DCXWOT1fqrJWPDgMCX/u4qOMENbU1lZ93RaswflF3Z4lkdMfWgkXDN3VCK
 ZHEWJekZAwBjTSL8a7/qV1KsEJ2VAU1DtLmVJtnM7cvEfu4sboRZqwYgDVJsnH+KTXdP
 dM0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1736239980; x=1736844780;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=NB+uT1ZGTxOF5kMHAIvom8Vcx46Zc94qv30ZNIEEzFg=;
 b=xCYPxaHAzuQ8Sr8AMQSC4fQt8JnHt7O5ubJVgdZY/EU4KVGWSKlWz4tLjjgOw3qoHL
 KcZKzqSC0kjwCakD0HZpZqUXeUMVKoVLOMzv06jtIL/IZ4EmGIrKGRV23tbA7t6SFDJD
 kYKjho8QcPe5ws0Jegzmtc1UmO39imKwSDwKOUiORT2oe5aBdspMLklhqNdwm8WWmHxX
 mj4GOfW6slkfQy/v02vqcs97gO4ZpUe8wvWgLOzX2bDkTT5dipe0ivusrHeRQ8Gza8Da
 SnQUGh6oyAUkPNEoLfKAMLgJpDVxDy5P2iFgqY24bKSm7aNppa/7+ALCOYRk5jxIbzUK
 ODvg==
X-Forwarded-Encrypted: i=1;
 AJvYcCUKOVM2Zc63m3RHfSPdBMXV8sTzkJq3PvsEp7ZMtvr+gM3QKpgmnKsq2U6mYRuBMvC1bNHFjdQjgbts@nongnu.org
X-Gm-Message-State: AOJu0YzNuY/8nMR8y7gq5BXUTv4x3tdD3rHfoSsrRxf0AFeU9lewSJjB
 8yMkuHZpbo9syJVozOlu6CfVvzb/ZV7Df60ISviCskWibiqpE4jSJMT/xmNRWss=
X-Gm-Gg: ASbGncsVqZa7dblWl3oBoC7+Z4xCnHeDKdE9H7Mk5ix/aQk37WaQvo3cryueZ+nzakI
 0EESHF3IEn5XG1R6IlhYjYfLEGvbqTbkqxG+PX5LvPqA1CmH6YhVM5AmLinBBN6L5b4UN5hELVp
 vyXf7iwslBT3zUB9RGk90Qz0MdJx7T6ue3RRvQxvMLaCQoWzsXdfNNNkzDqG9XcfVhn/UWofGE7
 BvclcjmZEDvTnebGhMeruHICePDP0hWTbOOKkqEAzSdRVrECmPp5c6/bE6vEYzUEF2WucllIP0Y
 xqkiu+ixvOSoG4caqHdn9QBE
X-Google-Smtp-Source: AGHT+IGEyVyNq5a2Wnkdu+r629fI1WgamG4iU5FgbMGgqzm6gCIUrl+9MuJpOE4efcSYTyRjNLQxag==
X-Received: by 2002:a5d:5e09:0:b0:385:e4a7:df09 with SMTP id
 ffacd0b85a97d-38a223f75fbmr67422383f8f.44.1736239980322; 
 Tue, 07 Jan 2025 00:53:00 -0800 (PST)
Received: from [192.168.69.132] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-38a1fa2bdfbsm49094454f8f.102.2025.01.07.00.52.59
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 07 Jan 2025 00:52:59 -0800 (PST)
Message-ID: <061b3eae-8ca1-43a4-ac3b-2f8b4e66538c@linaro.org>
Date: Tue, 7 Jan 2025 09:52:58 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 0/2] qtest: Remove uses of 'first_cpu'
To: Thomas Huth <thuth@redhat.com>, Fabiano Rosas <farosas@suse.de>,
 qemu-devel@nongnu.org
Cc: Bandan Das <bsd@redhat.com>, Alexander Bulekov <alxndr@bu.edu>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Peter Maydell <peter.maydell@linaro.org>,
 Markus Armbruster <armbru@redhat.com>, =?UTF-8?Q?Alex_Benn=C3=A9e?=
 <alex.bennee@linaro.org>, qemu-arm <qemu-arm@nongnu.org>
References: <20241211233727.98923-1-philmd@linaro.org>
 <5d2a536d-9b68-4b31-8d92-6cc42ed72e5c@linaro.org> <87msg884mn.fsf@suse.de>
 <05820c9b-a683-4eb4-a836-e97aa708d5e5@linaro.org>
 <3fb8281e-23f0-44a7-904b-34b8ea8ca7f3@redhat.com>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <3fb8281e-23f0-44a7-904b-34b8ea8ca7f3@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::432;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x432.google.com
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

On 7/1/25 09:03, Thomas Huth wrote:
> On 04/01/2025 00.48, Philippe Mathieu-Daudé wrote:
>> On 3/1/25 13:26, Fabiano Rosas wrote:
>>> Philippe Mathieu-Daudé <philmd@linaro.org> writes:
>>>
>>>> Hi Fabiano,
>>>>
>>>> On 12/12/24 00:37, Philippe Mathieu-Daudé wrote:
>>>>> Replace first_cpu->as by address_space_memory.
>>>>>
>>>>> Philippe Mathieu-Daudé (2):
>>>>>     system/qtest: Remove uses of 'first_cpu'
>>>>>     qtest/fuzz: Remove uses of 'first_cpu'
>>
>>>> Ping :)
>>>
>>> Hi!
>>>
>>> Good that you pinged, I thought you were looking into the test failures
>>> from v1. I copied you in this other thread that mentioned them as well:
>>>
>>> https://lore.kernel.org/r/87y10jctbd.fsf@suse.de
>>>
>>> Applying this series on top of master just now:
>>>
>>> Summary of Failures:
>>>
>>>   10/519 qemu:qtest+qtest-arm / qtest-arm/stm32l4x5_usart- 
>>> test               ERROR            1.40s   exit status 1
>>> 165/519 qemu:qtest+qtest-arm / qtest-arm/sse-timer- 
>>> test                     ERROR            0.40s   killed by signal 6 
>>> SIGABRT
>>> 185/519 qemu:qtest+qtest-arm / qtest-arm/stm32l4x5_exti- 
>>> test                ERROR            0.19s   exit status 1
>>> 187/519 qemu:qtest+qtest-arm / qtest-arm/stm32l4x5_rcc- 
>>> test                 ERROR            0.19s   exit status 1
>>> 515/519 qemu:qtest+qtest-arm / qtest-arm/microbit- 
>>> test                      TIMEOUT         60.01s   killed by signal 
>>> 15 SIGTERM
>>
>> Hmm interesting, I have a "quick-before-posting-series" set
>> of tests, and a "full-before-posting-pullreq" one. The quick
>> is quite extensive, but only include Aarch64. I thought, since
>> it contains the ARM targets, they would also be tested, but
>> no...
> 
> IIRC this was a deliberate decision once in the past to avoid double 
> testing: qtests_aarch64 in tests/qtest/meson.build does not include 
> qtest_arm, it's a separate set of tests indeed.
> 
> IMHO it's a little bit unfortunate, since in a couple of spots in the 
> CI, we are taking the shortcut of only adding aarch64-softmmu to the 
> target list, but not arm-softmmu.
> 
> Maybe we should add some logic to tests/qtest/meson.build so that if 
> arm-softmmu is not in target_dirs, we add the tests to qtests_aarch64 ?

I'm working in unifying both targets. With that in mind, optimizing
CI coverage doesn't seem a good use of our time IMHO, because once
I get there the CI will also be unified.

