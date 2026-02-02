Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D773DE7DF13
	for <qemu-devel@archiver.kernel.org>; Mon,  2 Feb 2026 17:31:21 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vmxl2-0003Tk-Fo; Mon, 02 Feb 2026 12:30:40 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1vmxky-0003TB-DS
 for qemu-devel@nongnu.org; Mon, 02 Feb 2026 12:30:36 -0500
Received: from mail-pl1-x62c.google.com ([2607:f8b0:4864:20::62c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1vmxkw-0003du-QE
 for qemu-devel@nongnu.org; Mon, 02 Feb 2026 12:30:36 -0500
Received: by mail-pl1-x62c.google.com with SMTP id
 d9443c01a7336-2a09d981507so33334045ad.1
 for <qemu-devel@nongnu.org>; Mon, 02 Feb 2026 09:30:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1770053433; x=1770658233; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
 :to:content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=nV+ASwh7NgR5/jO0pKAjRDTa0DsQirBu5mggt2j8RwE=;
 b=d1L/NLKndfLGNIRv+GyTeAwmtNUM/vKi6RHWpMhkm7Q9hHNKBr1ngRWUdWZPPimnja
 TGEJ/M+viEl8retCL1Kg1iNEM04YpQiG5qG3g8+hg5sIzEiZdRHxyciEIXZYkdK6OudG
 g3o5MQ7IuatevCwFbAzJH3CYWYFWUsWHGLifqbAK9diGEOu9p17LH/2YX8kELpEL4oX+
 vtQFYMNEJYtteQJ+O98Qhc7QTdZWm1pPUvvvms9UtoPwjPjyR2BTs3lJpL8C97qIFgGB
 qesF1D/ILkW6u6ILZqjXI/eBP5OC69R7YAFl2s49ya43ahUbf0D2O0ykSDOvec3Ear/l
 AOeQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1770053433; x=1770658233;
 h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
 :to:content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=nV+ASwh7NgR5/jO0pKAjRDTa0DsQirBu5mggt2j8RwE=;
 b=eG9qRCv1JjqR/99hhxSzRChJ7Mwxur6jfVlD0Hg8wO00GHd1umnzFnC3DCIhN6HlVb
 Km7WthKrivO+HLeu5c1AiXAjsnQTD+XzgdMausFmCRqNyNxtLRV0r6rRxP7VIpM4tUJE
 4/w99YKpi/0bb7dws8iLhfR8HdemxoRp8SMP8KuwQgclGEmDschqVYOZJKA0CFKqmi9b
 RIjrcxhIAC3w+BmKtnYYwV/kIruZT5hoQ2SJRKryxWJhY4SAzFLKuLJWgazxTJ9Kii98
 yA895dNyy3kECiUhgM0YcRz7taH0011NuIHa6x840t4ZBU3g6j5uYdXEhmurzdkahGdP
 +P2g==
X-Gm-Message-State: AOJu0YxsZGqdqEX7n65d7rFRO6CHOKrO6xaRU1C5NsFe92TAlZ4ZPIAO
 bWUFQQctlwDD/UDsnF2HoM8Yzn0glufpqD6Iq1O0J/AqGy10zezUn8cLUiAuGkTjBnz6QnymPNF
 sORVm
X-Gm-Gg: AZuq6aIHEulZqRSzLqSbhZzGffUpbhXuv8T06tQhhk/vLljSxQoBLwsLR+cuzbFM8DO
 p6YHxa3n6aUszB4dLvQuCfs0B1WbBsMiDTjVYZeTmiZLuxgSiMr9bVDMuD6d40qRx7hoSzhe0CB
 UBTG5RhyUe6f/1P8LiDmMPtnhCseezB22JIgxvmn5h/qcxItpXNMRgr8OsgyH+PM/VPRBhE8ZWJ
 Yib4fdW7XTadyJSuk1oCS1iMDELRNYEy5pqjGwTQc3slBtkSyZHEUL/4NQ6hJz11DUN0e9a743a
 axt2rND872okIBP+YylrnrkICS8o8YvJX46dnFbNfd5nGlP9xbDFWeDg0owvTOuGQhls8P9ETRK
 m2/Qe+9EetJIFTyLh3VezB7fHhbEIhtLoK65P6oJVklCPhYh5vUaBHdtwsX+V4hkj9ShXXlul3M
 zRbVSkkLDkazbLq3kQrs78wZalwXsmLIF86OGrvIJEyM7UrD1OiWDUE95YXcYnf9A+wr4=
X-Received: by 2002:a17:903:2f4d:b0:2a0:99f7:67b4 with SMTP id
 d9443c01a7336-2a9245b9468mr1638725ad.8.1770053432783; 
 Mon, 02 Feb 2026 09:30:32 -0800 (PST)
Received: from [192.168.1.87] (216-71-219-44.dyn.novuscom.net. [216.71.219.44])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2a88b6efc1bsm148159965ad.74.2026.02.02.09.30.32
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 02 Feb 2026 09:30:32 -0800 (PST)
Message-ID: <bd097ad0-d18e-42fc-9746-db4d448b71fa@linaro.org>
Date: Mon, 2 Feb 2026 09:30:31 -0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PULL 00/21] Plugins patches for 2026-01-29
Content-Language: en-US
To: Mark Cave-Ayland <mark.caveayland@nutanix.com>,
 Cornelia Huck <cohuck@redhat.com>, Peter Maydell <peter.maydell@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>
Cc: qemu-devel@nongnu.org
References: <20260129173811.138036-1-pierrick.bouvier@linaro.org>
 <2d69de6e-da9f-4f90-b805-9553bb72c78d@linaro.org>
 <7ac8fe1f-8098-4417-a97b-1a82c0fd23ca@linaro.org>
 <CAFEAcA_zghZeA0PzivCY9vCcFk6rVLwvP3in35rA=bF8yrdeyQ@mail.gmail.com>
 <878qdbtam7.fsf@redhat.com>
 <23be2c83-01ea-495d-b14e-496bd3e0a687@nutanix.com>
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
Autocrypt: addr=pierrick.bouvier@linaro.org; keydata=
 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
 ZtfdHNZotF092MIH0IQC3poExQpV/WBYFAI=
In-Reply-To: <23be2c83-01ea-495d-b14e-496bd3e0a687@nutanix.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62c;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-pl1-x62c.google.com
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

On 2/2/26 8:55 AM, Mark Cave-Ayland wrote:
> On 02/02/2026 15:42, Cornelia Huck wrote:
> 
>> On Mon, Feb 02 2026, Peter Maydell <peter.maydell@linaro.org> wrote:
>>
>>> On Mon, 2 Feb 2026 at 04:04, Richard Henderson
>>> <richard.henderson@linaro.org> wrote:
>>>>
>>>> On 1/30/26 04:41, Pierrick Bouvier wrote:
>>>>> On 1/29/26 9:37 AM, Pierrick Bouvier wrote:
>>>>>>          contrib/plugins: add empty cpp plugin
>>>
>>> Hi; this fails to build for me on Linux (Ubuntu 24.04) with clang:
>>>
>>> In file included from ../../contrib/plugins/cpp.cpp:33:
>>> /usr/bin/../lib/gcc/x86_64-linux-gnu/14/../../../../include/c++/14/coroutine:38:3:
>>> error: "the <coroutine> header requires -fcoroutines"
>>>      38 | # error "the <coroutine> header requires -fcoroutines"
>>>         |   ^
>>> 1 error generated.
>>
>> Fails for me as well on Fedora 42 (x86_64) with gcc:
>>
>> In file included from ../qemu/contrib/plugins/cpp.cpp:33:
>> /usr/include/c++/15/coroutine:43:3: error: #error "the <coroutine> header requires -fcoroutines"
>>      43 | # error "the <coroutine> header requires -fcoroutines"
>>         |   ^~~~~
>>
>> (It works for me on an aarch64 RHEL 9 system.)
> 
> Is this with a clean build? I had exactly the same error message
> earlier, but I was able to fix it by destroying my build/ directory,
> then re-running configure followed again by make.
> 
> 
> ATB,
> 
> Mark.
> 

Thanks for the reports everyone.

I tried it on ubuntu LTS and didn't encounter this problem.
What is happening is that meson unfortunately caches default_options 
set, including the C++ standard version in our case.
Thus, you indeed need to clean and rebuild once.

The solution for this would be to not use default_options and add the 
flag to qemu_cflags instead. It's the same limitation if we change the 
default warning level, or any other option set with default_options.

Let me know if cleaning solved the problem for you Cornelia and Peter, 
and sorry for the noise it created.

Regards,
Pierrick

