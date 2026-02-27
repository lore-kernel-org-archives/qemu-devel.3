Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A9FF5104891A
	for <qemu-devel@archiver.kernel.org>; Fri, 27 Feb 2026 21:47:59 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vw5gW-0004lk-Pi; Fri, 27 Feb 2026 16:47:44 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1vw5gV-0004lR-MF
 for qemu-devel@nongnu.org; Fri, 27 Feb 2026 16:47:43 -0500
Received: from mail-pg1-x535.google.com ([2607:f8b0:4864:20::535])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1vw5gT-0002Lm-W1
 for qemu-devel@nongnu.org; Fri, 27 Feb 2026 16:47:43 -0500
Received: by mail-pg1-x535.google.com with SMTP id
 41be03b00d2f7-bde0f62464cso1018534a12.2
 for <qemu-devel@nongnu.org>; Fri, 27 Feb 2026 13:47:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1772228860; x=1772833660; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:autocrypt:references:cc:to
 :from:content-language:subject:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to;
 bh=DGiB4BV2NUCWEqPQRDA28quzz5F8WAm6gER1eWRE+ms=;
 b=xkM6c/o+5SCenFuqjKANo4MlBaFNiAX4vVnlCW3+aUVas2TTRVa4NaSB+bd9KS4EjV
 w7hkjD58zcAsKaCUiCRUdcjnJb8+n6PkoJL2476kPGYvejuGCTHgeqF9E6GHPANkHhCb
 jwvORPV3EbkbWoivWji2kag8E3flmaCxQfFM/xf+OwXpbFjw15Ss+GtR7YG+h7C+HmwT
 fBJYyP3jCtuQrqY/hoYYqx5GsPIBfx8TuehL0P7udUoZC9csImFJJozJjqm1Oa74oDJ8
 CLFWlQ+kPTaQK2MsU1r/FICMl71k6Vydvp87HyegVj17LoWBP8KpIdPZk7xsawMjseWF
 BsCg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1772228860; x=1772833660;
 h=content-transfer-encoding:in-reply-to:autocrypt:references:cc:to
 :from:content-language:subject:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=DGiB4BV2NUCWEqPQRDA28quzz5F8WAm6gER1eWRE+ms=;
 b=QAhTeYgeD8g4kYu5CXoWm50BS5NYItmjSE1sbU/1nMCKE0u+TNA+wLLhn1ZzzyPyD2
 sq7Ilmn5I1xcoJVGxwwlHc3A8s4BR8vTsPJAveAvAnOTAUQM1pu8ICAZV94Ilnf6xE9J
 rRs/h9FTpUdbhcsgoo5rOSGF8uH4o7UwFUE3ltgXmBuCkAiZGqUBsHCpSpixXo26mmtM
 apZMRgMOeA4uTXcZsQWgbKgBExGygRDhzZAXL+Jts7Mcey7Po9PHC+FxSLFUg+9e89d+
 HH/PmOIUorkYz+7jYp/F3x2qgyRGfgInQgIjg/Qlm6YFacENriD4G7mKWeOQtZ9bHZCB
 yddQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCW2wSNoqOUWtosLbX101xcy8FeNsPeoTL5Ay1G4rIQX9FDFHn8g6Td4H7jv09Z5i7FbizTyLyPHfXtt@nongnu.org
X-Gm-Message-State: AOJu0YwahxhZVOnL6j/sXpG9s9PuY/hOvUVZ9roCG5EaYanHMIfN1gMj
 fz+RRd9DbF2xVWGOAOpJQjIZflvd3LL01VhRFXV28XuYbcgnfvQBncIxSIT0YlJFv24=
X-Gm-Gg: ATEYQzzdclJCt1irajxgEvgyNlERIkTHYUI75LdHUme6NvYWTs1+skkDvYqiRN+kKik
 9+MiICMQO5rnVbst/A9O57h8GtntKccYbRgc3PRdaz6UJbGSaQY8OxSfV9DT2cghHE7sbw1PWI0
 9ocpKxXog44vAxsBjKQq3lgOd0WKsLd0Feeefmes/kDNEHGfpUP3dv0LAF05DoKz0KwUzZpx4rK
 Fqg/VQFo7fELtg0a9KW8BjN2hCVSemdGFZ9Ju/J/73dW//0UNtXXyCp2cNLlGsWhVd9NSLwtr3a
 msuusn0MPV3QVjn5ZAVkT9EnJel/ig0J0hfYdNvue4b3Rx5MFl6zG3ME9iiok41uCg/ONvkrapU
 t2O8sOYCoBnuWRET0V57QCWD5FzTZCcsyfrswBa8cknKTCzF4f5y0GHw2qoDFJyR9C4R7qpiPs6
 txk70xywS6Yx28bUURJ2TYQYiBP90/GMbZhEjwtR8lbdTsKtL04KGmK6xo5PCWrJ7QoegC
X-Received: by 2002:a17:902:ce92:b0:2aa:f2ce:5aba with SMTP id
 d9443c01a7336-2ae2e4bc557mr44898745ad.38.1772228860330; 
 Fri, 27 Feb 2026 13:47:40 -0800 (PST)
Received: from [192.168.1.87] (216-71-219-44.dyn.novuscom.net. [216.71.219.44])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2ae39cfc271sm2464195ad.65.2026.02.27.13.47.39
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 27 Feb 2026 13:47:39 -0800 (PST)
Message-ID: <844edc05-11dc-40c1-8cd1-6bdc0bf6bc34@linaro.org>
Date: Fri, 27 Feb 2026 13:47:39 -0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: ppc-linux-user GDB stub broken
Content-Language: en-US
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Florian Hofhammer <florian.hofhammer@fhofhammer.de>
Cc: qemu-ppc@nongnu.org, qemu-devel@nongnu.org
References: <e44df309-d40d-46f0-88a8-7ac55f9a3634@fhofhammer.de>
 <CAPMQPEL1__biyd5e81EW78OA1rmVYqfsdEOmH5cs-nOvwnB3cg@mail.gmail.com>
 <70d4f460-c5c5-45ac-9ef0-2307ea4834f2@linaro.org>
 <3ec72a91-7326-43ff-8a8a-30135920ebe1@linaro.org>
 <3f07b026-3975-4869-9c3f-b64dd9ddeaab@linaro.org>
Autocrypt: addr=pierrick.bouvier@linaro.org; keydata=
 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
 ZtfdHNZotF092MIH0IQC3poExQpV/WBYFAI=
In-Reply-To: <3f07b026-3975-4869-9c3f-b64dd9ddeaab@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::535;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-pg1-x535.google.com
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

On 2/27/26 1:43 PM, Pierrick Bouvier wrote:
> On 2/27/26 1:40 PM, Philippe Mathieu-Daudé wrote:
>> On 27/2/26 14:09, Philippe Mathieu-Daudé wrote:
>>> On 27/2/26 10:58, Philippe Mathieu-Daudé wrote:
>>>> Hi Florian,
>>>
>>>
>>>>> on current master (d8a9d97317d03190b34498741f98f22e2a9afe3e), the basic
>>>>> gdb stub test fails for ppc-linux-user when running "make check-tcg".
>>>
>>>
>>>>> I've debugged around a bit but I don't know my way around the gdbstub
>>>>> internals enough to propose a patch right away, so I'll just summarize
>>>>> what I figured out so far.
>>>>> 1. Due to cc->gdb_num_core_regs not being set explicitly anymore, it is
>>>>>       set to 0 at the end of gdbstub/gdbstub.c:gdb_init_cpu(). In the same
>>>>>       function, cpu->gdb_num_regs gets set to 70.
>>>>> 2. When the test tries to read a register in gdbstub/
>>>>> gdbstub.c:gdb_read_register(),
>>>>>       the first condition of "reg < cc->gdb_num_core_regs" is always
>>>>> false.
>>>>>       Also, the register number for fpscr passed to the function is is
>>>>> 103,
>>>>>       and cpu->gdb_num_regs is also 103. If the register number is
>>>>> supposed
>>>>>       to be an index (as I understand it), this would indicate an
>>>>>       off-by-one error somewhere.
>>>>>
>>>>> If you have some pointers on where to look / what to check out for
>>>>> fixing this, I'll happily try to work on a patch. But I suppose that
>>>>> somebody more experienced with this could probably fix this much faster
>>>>> than I can.
>>>>
>>>> I'll have a look.
>>>
>>> Short term, this seems to fix it:
>>
>> Series for the generic fix posted:
>>
>> https://lore.kernel.org/qemu-devel/20260227213958.21170-1-philmd@linaro.org/
>>
> 
> Broken link, and unknown series.
> Can you send the good one?
>

Oops, was just a lore.kernel.org delay.

> Regards,
> Pierrick


