Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 16961C25B75
	for <qemu-devel@archiver.kernel.org>; Mon,  3 Jun 2024 08:50:53 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sE3OW-00063I-D1; Mon, 03 Jun 2024 04:50:20 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1sE3OU-00061M-JG
 for qemu-devel@nongnu.org; Mon, 03 Jun 2024 04:50:18 -0400
Received: from mail-ot1-x333.google.com ([2607:f8b0:4864:20::333])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1sE3OS-0003M0-Aw
 for qemu-devel@nongnu.org; Mon, 03 Jun 2024 04:50:18 -0400
Received: by mail-ot1-x333.google.com with SMTP id
 46e09a7af769-6f361af4cb6so1243844a34.3
 for <qemu-devel@nongnu.org>; Mon, 03 Jun 2024 01:50:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=daynix-com.20230601.gappssmtp.com; s=20230601; t=1717404614; x=1718009414;
 darn=nongnu.org; 
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=0+InOUYYh0unNoXVbk3mH+fM4gOws4eW9rSF3AdbcNI=;
 b=O8SOubFOmBmHypy8zYAFZ5+rukD8gGcY2I+7a0UTKZEbUGI65mCr0BuWtzx2ccUjzp
 WZrUNA99CAh7amjGPvM+N15FRlBQKXwE7BrXuNZxwOS3QUvuM/fAw1PHXwyajxTnnoPK
 nB0FWM/LtRgihEPAcG2XAJtI7oFCcC30Bo7wL0mC/1+fhKT5dT2DAiSBUPukHmAInAfN
 QaxSnyJRcI62boqWM2/SIiSYL0JOeySuUXUrNWaLkh1gD0Ha1Mzj72Quh93yaxYqp27u
 uJstTPSGP+yvWpmCpabNJpBqNTw7whDCM5eGD9wL+7k75SHF017u19A18bl6qE1zNako
 I9tA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1717404614; x=1718009414;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=0+InOUYYh0unNoXVbk3mH+fM4gOws4eW9rSF3AdbcNI=;
 b=K1bz9aNbBZFwMIfFiPYAVJ1QSYdhp/2fsOAMM2y0vDJxGNtWsEEKhpzt+qpPyTly5G
 DpWswhk31HPYkChONhXokLcQ6Hxz/+Ykkqo9E4CBWUipEOh12sB5Gg5tdTVqqrvBblFR
 VRf+DwxWqytvvM0GmCaaZmPB4iyFZrQH2mmxcIax1otfafHAidyCx8QKnaMbFUgcrhvV
 2F0gA19AUpKWMQdIweqpnQz8onFswTGTuAcfUZoTKQ8lCcd1VUpU2a+0hrD0+Sd7xLDQ
 cMm5qrYPjBVcNecXbzhpK/9zFnzglJ4dfbqpT8eWZ88Wr3tlX6lXnwdeJp3wzhuMSFnH
 37Pw==
X-Forwarded-Encrypted: i=1;
 AJvYcCVVOZA23d0sSs5ivAD6cbtYFiwU7R+p4lgimITessmAgWCA4xKOLfvxsXxhfvETV+hfh0n5pllFatwHnwE0VqZabOBEEvo=
X-Gm-Message-State: AOJu0YwG58kyq7aawT9577gRAz0L3Ccv3GIltSBYPmDBX/oEstQPIb+q
 R1zpuwsWcTctB85+YpmFoMVhTkJToL1OBcLfNLtOQsEEl7EUXvOIHqnRuMQaqu8=
X-Google-Smtp-Source: AGHT+IEg2krSzVvBwi/3Pxj7rmzcKOiKJGPSR5w6Hrp07bdyTB5Z/3ZLjSYC00+iFm+A7b0TTmr1EQ==
X-Received: by 2002:a05:6830:2713:b0:6ed:7c7e:1bce with SMTP id
 46e09a7af769-6f911f26f70mr13753914a34.3.1717404613963; 
 Mon, 03 Jun 2024 01:50:13 -0700 (PDT)
Received: from [157.82.204.135] ([157.82.204.135])
 by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-6c35937a4a1sm4662781a12.57.2024.06.03.01.50.12
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 03 Jun 2024 01:50:13 -0700 (PDT)
Message-ID: <22e6b199-a23f-4b5d-ad80-86e82a232c8c@daynix.com>
Date: Mon, 3 Jun 2024 17:50:11 +0900
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
Content-Language: en-US
From: Akihiko Odaki <akihiko.odaki@daynix.com>
In-Reply-To: <d32e3ea3-32fb-4893-a950-91e60c9778d2@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: none client-ip=2607:f8b0:4864:20::333;
 envelope-from=akihiko.odaki@daynix.com; helo=mail-ot1-x333.google.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_NONE=0.001, T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

On 2024/06/03 16:56, Michal Prívozník wrote:
> On 6/2/24 08:26, Akihiko Odaki wrote:
>> On 2024/06/01 0:46, Philippe Mathieu-Daudé wrote:
>>> On 31/5/24 17:10, Michal Privoznik wrote:
>>>> The unspoken premise of qemu_madvise() is that errno is set on
>>>> error. And it is mostly the case except for posix_madvise() which
>>>> is documented to return either zero (on success) or a positive
>>>> error number. This means, we must set errno ourselves. And while
>>>> at it, make the function return a negative value on error, just
>>>> like other error paths do.
>>>>
>>>> Signed-off-by: Michal Privoznik <mprivozn@redhat.com>
>>>> ---
>>>>    util/osdep.c | 14 +++++++++++++-
>>>>    1 file changed, 13 insertions(+), 1 deletion(-)
>>>>
>>>> diff --git a/util/osdep.c b/util/osdep.c
>>>> index e996c4744a..1345238a5c 100644
>>>> --- a/util/osdep.c
>>>> +++ b/util/osdep.c
>>>> @@ -57,7 +57,19 @@ int qemu_madvise(void *addr, size_t len, int advice)
>>>>    #if defined(CONFIG_MADVISE)
>>>>        return madvise(addr, len, advice);
>>>>    #elif defined(CONFIG_POSIX_MADVISE)
>>>> -    return posix_madvise(addr, len, advice);
>>>> +    /*
>>>> +     * On Darwin posix_madvise() has the same return semantics as
>>>> +     * plain madvise, i.e. errno is set and -1 is returned. Otherwise,
>>>> +     * a positive error number is returned.
>>>> +     */
>>>
>>> Alternative is to guard with #ifdef CONFIG_DARWIN ... #else ... #endif
>>> which might be clearer.
>>>
>>> Although this approach seems reasonable, so:
>>> Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
>>
>> We should use plain madvise() if posix_madvise() is broken. In fact,
>> QEMU detects the availability of plain madvise() and use it instead of
>> posix_madvise() on my MacBook.
>>
>> Perhaps it may be better to stop defining CONFIG_POSIX_MADVISE on Darwin
>> to ensure we never use the broken implementation.
>>
> 
> Well, doesn't Darwin have madvise() in the first place?
> 
> https://opensource.apple.com/source/xnu/xnu-7195.81.3/bsd/man/man2/madvise.2.auto.html
> 
> I thought that's the reason for posix_madvise() to behave the same as madvise() there.

It does have madvise() and QEMU on my MacBook uses it instead of 
posix_madvise().

The behavior of posix_madvise() is probably just a bug (and perhaps it 
is too late for them to fix).

