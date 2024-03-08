Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 03F09C54E4A
	for <qemu-devel@archiver.kernel.org>; Fri,  8 Mar 2024 14:59:26 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ribgu-0005Yz-UO; Fri, 08 Mar 2024 09:59:20 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <gustavo.romero@linaro.org>)
 id 1ribgt-0005YQ-M0
 for qemu-devel@nongnu.org; Fri, 08 Mar 2024 09:59:19 -0500
Received: from mail-pg1-x52e.google.com ([2607:f8b0:4864:20::52e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <gustavo.romero@linaro.org>)
 id 1ribgr-0006Hj-SX
 for qemu-devel@nongnu.org; Fri, 08 Mar 2024 09:59:19 -0500
Received: by mail-pg1-x52e.google.com with SMTP id
 41be03b00d2f7-5e152c757a5so711469a12.2
 for <qemu-devel@nongnu.org>; Fri, 08 Mar 2024 06:59:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1709909956; x=1710514756; darn=nongnu.org;
 h=content-transfer-encoding:content-language:in-reply-to:mime-version
 :user-agent:date:message-id:from:references:cc:to:subject:from:to:cc
 :subject:date:message-id:reply-to;
 bh=McH2CAxbADs4vfJAx7zUq2p93qOKC5DAfjx+vHVHnPc=;
 b=RzFtqneOv96jaWiiuGOiVOkSdpRGI9v30ZwW/13fluuduOzA5+ps7P1EC++uBIqN0a
 r0bXLix9usC1fICa3GAQs6sFI5QX0amqZ02nN6G7ORegmsewyJ81/fQeJV8Y9IZpJORx
 S4g+ovHGPaKRH/4vaqWs/rqE6Os+WoKlNY79GK5lQWt/b6hHt0uLikp3STrrNqFME8Ya
 lb8+geAnOkS/0mJVxZ4YveieNUI601WkqvPwkfbBhoMVvqIFOgRzMWUCiO/DYsUcxzqo
 /zHxBL2XAHd4Qc5flDpIInpJP6gqKT+3CdiLVMkMjK4Ao9UgR+g8mbIR0mOWtr1SMzZi
 F9UQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1709909956; x=1710514756;
 h=content-transfer-encoding:content-language:in-reply-to:mime-version
 :user-agent:date:message-id:from:references:cc:to:subject
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=McH2CAxbADs4vfJAx7zUq2p93qOKC5DAfjx+vHVHnPc=;
 b=alrDOkgowxTjpFczdaTK9EeWN5IV54dqTHbEdogDECRvPUNanU4uWhtmxjytd9xy+0
 Am/ENkTmKvMj1fuH0MEef9HWHKrZfN6SS03tcvYeB44TWRmmGcYn/kCw3ot6yLPuKrZ7
 tsS8bWK9uli2P2lU43ig7ekjIOBggTzVA5qhuWoD1Zys+Kl64WHK4qAz9u1k7l1f3AG7
 nr7qpZ84QlACcm0mOt32J68Br2MW85jL20sB0hmJyhtiVBSfdfvydan3jRj+2lYrC8AQ
 XYN36hz/m7VoqcwMDQX7Bel9JHJJNEGXLmIhE5YkBBCni3F4U8dWOC+CA9+EH6W4WiEZ
 Qw8w==
X-Forwarded-Encrypted: i=1;
 AJvYcCXrTfjFfgjcuyoTSnmvMJ7gc8XxhbB0rjnGqhnjaBOI9AaeikQ3TGHd0AfoXfSRyElwYCIvYYlOevar+xhwOnPVnSSDuSM=
X-Gm-Message-State: AOJu0YwAXwhGzrZvnfK48UMy1LrHaFd70hfLwTLTz9ySxAj6e+97mc3g
 cjgxNQZk+l4xwZRcGwwFvoqK9mJebGsmk6WxMa6yVoaXPNKa8mpzF3hD2Zb4uv8=
X-Google-Smtp-Source: AGHT+IEhlYGIYMde39/cBImRsS1QIzr/12djFkYeik8nwsIjxhslBMNTPeq8lZg4H32sJUEo6eOQaA==
X-Received: by 2002:a17:90a:d517:b0:299:63fe:3a27 with SMTP id
 t23-20020a17090ad51700b0029963fe3a27mr220081pju.19.1709909956151; 
 Fri, 08 Mar 2024 06:59:16 -0800 (PST)
Received: from ?IPv6:2804:7f0:b401:7e8e:216c:3f1a:12a4:d415?
 ([2804:7f0:b401:7e8e:216c:3f1a:12a4:d415])
 by smtp.gmail.com with ESMTPSA id
 cc9-20020a17090af10900b0029ab17eaa40sm3166067pjb.3.2024.03.08.06.59.14
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 08 Mar 2024 06:59:15 -0800 (PST)
Subject: Re: [PATCH 2/2] tests/tcg: Add multiarch test for Xfer:siginfo:read
 stub
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org,
 alex.bennee@linaro.org
Cc: peter.maydell@linaro.org
References: <20240303192610.498490-1-gustavo.romero@linaro.org>
 <20240303192610.498490-2-gustavo.romero@linaro.org>
 <e33ab9ae-e2d4-41ba-b053-e7e918572808@linaro.org>
 <d98ef081-b25d-4dbf-7b67-fe27e09ff2f0@linaro.org>
 <cd6b5e0f-5a10-4acb-94d6-51073ceb5acf@linaro.org>
 <3973e3e8-cff0-19a3-3fed-f0eebc52d624@linaro.org>
 <43d5ea83-5fc1-47b0-a6d1-f8564c238d88@linaro.org>
From: Gustavo Romero <gustavo.romero@linaro.org>
Message-ID: <dcc0983b-8931-aab4-2179-f0e48f11e86a@linaro.org>
Date: Fri, 8 Mar 2024 11:59:12 -0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.6.0
MIME-Version: 1.0
In-Reply-To: <43d5ea83-5fc1-47b0-a6d1-f8564c238d88@linaro.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::52e;
 envelope-from=gustavo.romero@linaro.org; helo=mail-pg1-x52e.google.com
X-Spam_score_int: -60
X-Spam_score: -6.1
X-Spam_bar: ------
X-Spam_report: (-6.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, NICE_REPLY_A=-3.994,
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


On 3/7/24 4:31 PM, Richard Henderson wrote:
> On 3/7/24 07:50, Gustavo Romero wrote:
>> Hi Richard,
>>
>> On 3/4/24 7:51 PM, Richard Henderson wrote:
>>> On 3/4/24 10:59, Gustavo Romero wrote:
>>>>> Perhaps just abort for SIGABRT instead?
>>>>
>>>> Although this can make a simpler test, the test can't control
>>>> the si_addr value easily, which I think is interesting to be tested.
>>>>
>>>> Why do you prefer SIGABRT?
>>>
>>> I missed that you were testing si_addr -- in which case SIGSEGV is a good match.
>>>
>>>
>>>>> A test using setitimer to raise SIGALRM would test the async path.
>>>>
>>>> SIGLARM doesn't generate any interesting siginfo?
>>>
>>> It should at minimum have si_sig = SIGALRM.
>>>
>>>>
>>>> gromero@arm64:~$ gdb -q ./sigalrm
>>>> Reading symbols from ./sigalrm...
>>>> (gdb) run
>>>> Starting program: /home/gromero/sigalrm
>>>>
>>>> Program terminated with signal SIGALRM, Alarm clock.
>>>> The program no longer exists.
>>>> (gdb) p $_siginfo
>>>> $1 = void
>>>
>>> Well that's because the program died.
>>> Do you need to have gdb handle the signal?
>>
>> ouch, right :)
>>
>> However, on a remote target, even if I catch that signal using
>> 'catch signal SIGALRM' the GDBstub only closes the connection
>> when SIGALRM is delivered. That's odd, I don't understand why.
>>
>> I'm using the same binary that pretty much works on GDB locally.
>>
>>
>> [Remote target]
>>
>> gromero@arm64:~$ gdb -q
>> gromero@arm64:~/qemu_tests$ gdb -q ./sigalrm
>> Reading symbols from ./sigalrm...
>> (gdb) catch signal SIGALRM
>> Catchpoint 1 (signal SIGALRM)
>> (gdb) c
>> The program is not being run.
>> (gdb) run
>> Starting program: /home/gromero/qemu_tests/sigalrm
>> [Inferior 1 (process 12732) exited normally]
>> (gdb) quit
>>
>> on the QEMU gdbstub side it reports "Alarm clock":
>>
>> gromero@amd:~/git/qemu/build$ ./qemu-aarch64 -g 1234 ./sigalrm -s
>> Alarm clock
>> gromero@amd:~/git/qemu/build$
>>
>>
>> [Locally]
>>
>> gromero@arm64:~/qemu_tests$ gdb -q ./sigalrm
>> Reading symbols from ./sigalrm...
>> (gdb) catch signal SIGALRM
>> Catchpoint 1 (signal SIGALRM)
>> (gdb) run -s
>> Starting program: /home/gromero/qemu_tests/sigalrm -s
>>
>> Catchpoint 1 (signal SIGALRM), 0x000000000041a410 in ualarm ()
>> (gdb) quit
>>
>>
>> I'd like to add for the async path using SIGALRM but I need more
>> time to understand what's going on regarding SIGLARM. I understand
>> that's nothing wrong with the Xfer:siginfo:read stub itself, and
>> because the main goal of the test is to test the stub, if you don't
>> mind, I'd like to keep only the test with SIGSEGV for v2 and leave
>> the async test as a follow-up.
> 
> Well that's certainly surprising.
> Would you please file a bug report about this?
> I think I know what the problem is, but let's track it anyway.

Yeah.. I filed an issue here:

https://gitlab.com/qemu-project/qemu/-/issues/2214


Cheers,
Gustavo

