Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 27868C27C44
	for <qemu-devel@archiver.kernel.org>; Mon,  3 Jun 2024 11:19:01 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sE5h3-0004Jb-Nz; Mon, 03 Jun 2024 07:17:38 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1sE5gx-00046J-Ah
 for qemu-devel@nongnu.org; Mon, 03 Jun 2024 07:17:31 -0400
Received: from mail-pl1-x62d.google.com ([2607:f8b0:4864:20::62d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1sE5ge-0006Bk-0W
 for qemu-devel@nongnu.org; Mon, 03 Jun 2024 07:17:24 -0400
Received: by mail-pl1-x62d.google.com with SMTP id
 d9443c01a7336-1f62fae8c3cso28799495ad.3
 for <qemu-devel@nongnu.org>; Mon, 03 Jun 2024 04:17:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=daynix-com.20230601.gappssmtp.com; s=20230601; t=1717413430; x=1718018230;
 darn=nongnu.org; 
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=A885skJMu8sWdVQrS46wFUx/4xOSYNYMrymGY5OQ5ug=;
 b=h/mSfUdwcDdqbJgANrWkNsO7j88MvqTwNsiByaHEOjfJJDq1qE4VigLnav8gMuhLqe
 m43Ec/ZXvaY8yP1ffd83PeLrWnpxzZmZc34uLvpsPEkdI3MGlOMmkijNw0pyeeisXWl4
 QGTt/A5tfavXVttGkLgc5rcAmlb/lZrsqM271kbt6915lbbJm+EN/Pcne8bLWrwBUeYk
 j0Nzp4BsfwD3QRrW91QbJ3KRIXyuGXoOUAqzAOScx+OlacLSAdIsYvFFRSSYa9TPUnyL
 JYxR7POR97JJr5SPA9M6yYZt8qBtfCovRggaz3V0nVFndte+Jd8OfA+S2mkGr2RQgjHi
 ljCQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1717413430; x=1718018230;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=A885skJMu8sWdVQrS46wFUx/4xOSYNYMrymGY5OQ5ug=;
 b=I0xq7wTld+8KFEqxoZKgmVFQo/B/Uxe+MQqnGMlnNrW4bYuHvHOpXEGn35ThP0d5uo
 GqAt6+o2fV/MF/VSsXj8KhNit9yR3ZeavidJR3ESwwY9aWuWh0b0dveoij0l6xpcgqwz
 GQhj+SGcfgiQIeKJgA8IgHviVk8JjRruthUAHL+7sxFxbIZtpJB5usSdEUkK1sgkD8S3
 4EEMWvuWofakuOyLRZHNbL0Tn+M8CsplcKXAHS4nxRpcc1k2mFdWnJ2C6vilZ+gWYWNC
 MT77JjxTurmwgKdJcGDwY5+dkJhHp4uvkwqGLnFxDIwFpnK5BxZZd5UX07KsQMu54cKT
 rZZA==
X-Forwarded-Encrypted: i=1;
 AJvYcCXyNVkxM7iAuAam6XMqpx2HgxsWBQpBtNiefGZwdeNq/jTTdBKXAQk2UP8+FfcsIBHOXBd0HdUOb+DWIP8xmo+5MxJPfPk=
X-Gm-Message-State: AOJu0YzuM2DEmd/aS2N3raGhuEPKFc79KYufZ/cr5Zr7NefPyNw+xgOr
 Bopm2BHbQNgnEt6BTleOrfqCGkNMrRDTnkXOGx97BXtvnnzUlWf1moo97DUoJN8=
X-Google-Smtp-Source: AGHT+IF1PqCUUJQZsjG72DQc6f1T9lbSIgNbHUTHM9T1ph+KnPPwUnHoGRllFKavKDKeXoOW/koQvQ==
X-Received: by 2002:a17:903:22c3:b0:1f4:bb5c:b7bd with SMTP id
 d9443c01a7336-1f6370b8aa1mr95412095ad.61.1717413429612; 
 Mon, 03 Jun 2024 04:17:09 -0700 (PDT)
Received: from ?IPV6:2400:4050:a840:1e00:9ac7:6d57:2b16:6932?
 ([2400:4050:a840:1e00:9ac7:6d57:2b16:6932])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-1f6323e3c33sm62572685ad.176.2024.06.03.04.17.08
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 03 Jun 2024 04:17:09 -0700 (PDT)
Message-ID: <ae9f48f2-466a-42bd-9aab-82279fb9011d@daynix.com>
Date: Mon, 3 Jun 2024 20:17:06 +0900
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 1/4] osdep: Make qemu_madvise() to set errno in all
 cases
To: =?UTF-8?B?TWljaGFsIFByw612b3puw61r?= <mprivozn@redhat.com>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org
Cc: Cameron Esfahani <dirty@apple.com>
References: <cover.1717168113.git.mprivozn@redhat.com>
 <393c7b26302cb445f1a086a2c80b1d718c31a071.1717168113.git.mprivozn@redhat.com>
 <4b146ec6-bec2-4191-8c95-fc30d8307ef6@linaro.org>
 <08ff19ed-9d1b-4fa3-8a40-3fe10d1f9bfa@daynix.com>
 <d32e3ea3-32fb-4893-a950-91e60c9778d2@redhat.com>
 <22e6b199-a23f-4b5d-ad80-86e82a232c8c@daynix.com>
 <78f8d06f-9dee-4944-8635-af2316c84a33@redhat.com>
Content-Language: en-US
From: Akihiko Odaki <akihiko.odaki@daynix.com>
In-Reply-To: <78f8d06f-9dee-4944-8635-af2316c84a33@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: none client-ip=2607:f8b0:4864:20::62d;
 envelope-from=akihiko.odaki@daynix.com; helo=mail-pl1-x62d.google.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, SPF_HELO_NONE=0.001, SPF_NONE=0.001,
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

On 2024/06/03 19:07, Michal Prívozník wrote:
> On 6/3/24 10:50, Akihiko Odaki wrote:
>> On 2024/06/03 16:56, Michal Prívozník wrote:
>>> On 6/2/24 08:26, Akihiko Odaki wrote:
>>>> On 2024/06/01 0:46, Philippe Mathieu-Daudé wrote:
>>>>> On 31/5/24 17:10, Michal Privoznik wrote:
>>>>>> The unspoken premise of qemu_madvise() is that errno is set on
>>>>>> error. And it is mostly the case except for posix_madvise() which
>>>>>> is documented to return either zero (on success) or a positive
>>>>>> error number. This means, we must set errno ourselves. And while
>>>>>> at it, make the function return a negative value on error, just
>>>>>> like other error paths do.
>>>>>>
>>>>>> Signed-off-by: Michal Privoznik <mprivozn@redhat.com>
>>>>>> ---
>>>>>>     util/osdep.c | 14 +++++++++++++-
>>>>>>     1 file changed, 13 insertions(+), 1 deletion(-)
>>>>>>
>>>>>> diff --git a/util/osdep.c b/util/osdep.c
>>>>>> index e996c4744a..1345238a5c 100644
>>>>>> --- a/util/osdep.c
>>>>>> +++ b/util/osdep.c
>>>>>> @@ -57,7 +57,19 @@ int qemu_madvise(void *addr, size_t len, int
>>>>>> advice)
>>>>>>     #if defined(CONFIG_MADVISE)
>>>>>>         return madvise(addr, len, advice);
>>>>>>     #elif defined(CONFIG_POSIX_MADVISE)
>>>>>> -    return posix_madvise(addr, len, advice);
>>>>>> +    /*
>>>>>> +     * On Darwin posix_madvise() has the same return semantics as
>>>>>> +     * plain madvise, i.e. errno is set and -1 is returned.
>>>>>> Otherwise,
>>>>>> +     * a positive error number is returned.
>>>>>> +     */
>>>>>
>>>>> Alternative is to guard with #ifdef CONFIG_DARWIN ... #else ... #endif
>>>>> which might be clearer.
>>>>>
>>>>> Although this approach seems reasonable, so:
>>>>> Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
>>>>
>>>> We should use plain madvise() if posix_madvise() is broken. In fact,
>>>> QEMU detects the availability of plain madvise() and use it instead of
>>>> posix_madvise() on my MacBook.
>>>>
>>>> Perhaps it may be better to stop defining CONFIG_POSIX_MADVISE on Darwin
>>>> to ensure we never use the broken implementation.
>>>>
>>>
>>> Well, doesn't Darwin have madvise() in the first place?
>>>
>>> https://opensource.apple.com/source/xnu/xnu-7195.81.3/bsd/man/man2/madvise.2.auto.html
>>>
>>> I thought that's the reason for posix_madvise() to behave the same as
>>> madvise() there.
>>
>> It does have madvise() and QEMU on my MacBook uses it instead of
>> posix_madvise().
>>
> 
> I don't have a Mac myself, but I ran some tests on my colleague's Mac
> and yes, posix_madvise() is basically just an alias to madvise(). No
> dispute there.
> 
>> The behavior of posix_madvise() is probably just a bug (and perhaps it
>> is too late for them to fix).
>>
> 
> So what does this mean for this patch? Should I resend with the change
> you're suggesting or this is good as is? I mean, posix_madvise() is not
> going to be used on Mac anyways.

I'm for my suggestion. The current patch seems to imply that we will use 
posix_madvise() on macOS but in reality plain madivse() is used so it is 
a bit misleading. We can explicitly say we won't use posix_madvise() on 
macOS by not defining CONFIG_POSIX_MADVISE for that platform.

