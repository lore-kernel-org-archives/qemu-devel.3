Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0E082C54798
	for <qemu-devel@archiver.kernel.org>; Thu,  7 Mar 2024 19:31:50 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1riJSh-0004T4-3S; Thu, 07 Mar 2024 14:31:27 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1riJSe-0004Sm-98
 for qemu-devel@nongnu.org; Thu, 07 Mar 2024 14:31:24 -0500
Received: from mail-pf1-x42e.google.com ([2607:f8b0:4864:20::42e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1riJSc-0000w9-KC
 for qemu-devel@nongnu.org; Thu, 07 Mar 2024 14:31:23 -0500
Received: by mail-pf1-x42e.google.com with SMTP id
 d2e1a72fcca58-6d9f94b9186so1283642b3a.0
 for <qemu-devel@nongnu.org>; Thu, 07 Mar 2024 11:31:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1709839881; x=1710444681; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=prEeomYjDWfdu2yP6uDTDR0YkSUn/bR4KmwOGYSeq9E=;
 b=YELBn1e8XBbPhf0ROj13BsfP04638ZTT+53RI7y1V8NoUNGqA2K/B8LN2fTotWowTM
 r43TJbZL2UEQ5kt10x4CzL0A8OClC/pfrRDYciQRb/FSTThLtv8t0T0UaGGEni93TFWW
 DIYzQQC9pRVvqCSGGjZECCxdaT5ZfQIIo60HnJBx8vgs+OULuXygcipDix2kJSIJ5adk
 NWYZaP50hIDY8dfcaFBLR4239/vJ5D6QNPgGtqEcPebjSDmSwJTz9eSegcSDpq28m7lm
 gwubfi/KwXrIlYEwNpe1v41ayzwp0hcYYOwA6ZoX9Y6hl3FcSpk1CkCi39Xd5d9kAdUw
 jrMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1709839881; x=1710444681;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=prEeomYjDWfdu2yP6uDTDR0YkSUn/bR4KmwOGYSeq9E=;
 b=Psfa9QzChw5kplTCc1PLFyuxWNhAidXS8o4/KlanxBGuBHJ8gzQ3r8FHLFgEVOg/SH
 pemQq8zAhTfeNOleDNWSIgkjdEyh3vmrgFJzL2w1g2M0k7JMeeKJ0ETXcl4ZxpnhKSqk
 WDv6APe0JJLMFJOIQulzG//RHVLHfXO8elwo8CnY4SmDdQAqK6bP7kpaH6ESi+f16BJ9
 LUu9spt33ItGBAq71FnirzEAJbxiMS0u1VypsOS3TbZ8l5yZHNBsCK9d6OZnlKBIUP36
 H9ot008j3K40pLAztZmxi5WrLAVHfQUbkgiZmoG5+vrVblH8OBYMB202mw6kB3NojgKB
 iMyg==
X-Forwarded-Encrypted: i=1;
 AJvYcCXSREwNtOxnl75krZv3zAhKtVuB8zznc6ePhZEYtr32jHLDa1cKOomPB5N/j+HayGJ4wV5yzxn8PFpZn4ImcRJw5p3rySY=
X-Gm-Message-State: AOJu0YxunjtP1YXUUmIrWnnN8DtNFIyfHDUK0xvPzPS4pDgx0vwz4GCt
 3jZ/WM2/Zv3zL25gFYoJGiguVjEdtV6oNr4KqJEc2/e4g5zoC83nm7B67LFB1r8=
X-Google-Smtp-Source: AGHT+IGDl9yvH1QzyeepbHLMqp0xeYcdA+KTKM2Yb9sHzBxbVSa12EjI12XG9vx5ebhb7lDM4ODwbg==
X-Received: by 2002:a05:6a00:2407:b0:6e6:5343:c165 with SMTP id
 z7-20020a056a00240700b006e65343c165mr4449230pfh.16.1709839880938; 
 Thu, 07 Mar 2024 11:31:20 -0800 (PST)
Received: from [192.168.6.128] (098-147-055-211.res.spectrum.com.
 [98.147.55.211]) by smtp.gmail.com with ESMTPSA id
 b64-20020a62cf43000000b006e5a915a9e7sm12748854pfg.10.2024.03.07.11.31.19
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 07 Mar 2024 11:31:20 -0800 (PST)
Message-ID: <43d5ea83-5fc1-47b0-a6d1-f8564c238d88@linaro.org>
Date: Thu, 7 Mar 2024 09:31:17 -1000
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/2] tests/tcg: Add multiarch test for Xfer:siginfo:read
 stub
Content-Language: en-US
To: Gustavo Romero <gustavo.romero@linaro.org>, qemu-devel@nongnu.org,
 alex.bennee@linaro.org
Cc: peter.maydell@linaro.org
References: <20240303192610.498490-1-gustavo.romero@linaro.org>
 <20240303192610.498490-2-gustavo.romero@linaro.org>
 <e33ab9ae-e2d4-41ba-b053-e7e918572808@linaro.org>
 <d98ef081-b25d-4dbf-7b67-fe27e09ff2f0@linaro.org>
 <cd6b5e0f-5a10-4acb-94d6-51073ceb5acf@linaro.org>
 <3973e3e8-cff0-19a3-3fed-f0eebc52d624@linaro.org>
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <3973e3e8-cff0-19a3-3fed-f0eebc52d624@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::42e;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x42e.google.com
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

On 3/7/24 07:50, Gustavo Romero wrote:
> Hi Richard,
> 
> On 3/4/24 7:51 PM, Richard Henderson wrote:
>> On 3/4/24 10:59, Gustavo Romero wrote:
>>>> Perhaps just abort for SIGABRT instead?
>>>
>>> Although this can make a simpler test, the test can't control
>>> the si_addr value easily, which I think is interesting to be tested.
>>>
>>> Why do you prefer SIGABRT?
>>
>> I missed that you were testing si_addr -- in which case SIGSEGV is a good match.
>>
>>
>>>> A test using setitimer to raise SIGALRM would test the async path.
>>>
>>> SIGLARM doesn't generate any interesting siginfo?
>>
>> It should at minimum have si_sig = SIGALRM.
>>
>>>
>>> gromero@arm64:~$ gdb -q ./sigalrm
>>> Reading symbols from ./sigalrm...
>>> (gdb) run
>>> Starting program: /home/gromero/sigalrm
>>>
>>> Program terminated with signal SIGALRM, Alarm clock.
>>> The program no longer exists.
>>> (gdb) p $_siginfo
>>> $1 = void
>>
>> Well that's because the program died.
>> Do you need to have gdb handle the signal?
> 
> ouch, right :)
> 
> However, on a remote target, even if I catch that signal using
> 'catch signal SIGALRM' the GDBstub only closes the connection
> when SIGALRM is delivered. That's odd, I don't understand why.
> 
> I'm using the same binary that pretty much works on GDB locally.
> 
> 
> [Remote target]
> 
> gromero@arm64:~$ gdb -q
> gromero@arm64:~/qemu_tests$ gdb -q ./sigalrm
> Reading symbols from ./sigalrm...
> (gdb) catch signal SIGALRM
> Catchpoint 1 (signal SIGALRM)
> (gdb) c
> The program is not being run.
> (gdb) run
> Starting program: /home/gromero/qemu_tests/sigalrm
> [Inferior 1 (process 12732) exited normally]
> (gdb) quit
> 
> on the QEMU gdbstub side it reports "Alarm clock":
> 
> gromero@amd:~/git/qemu/build$ ./qemu-aarch64 -g 1234 ./sigalrm -s
> Alarm clock
> gromero@amd:~/git/qemu/build$
> 
> 
> [Locally]
> 
> gromero@arm64:~/qemu_tests$ gdb -q ./sigalrm
> Reading symbols from ./sigalrm...
> (gdb) catch signal SIGALRM
> Catchpoint 1 (signal SIGALRM)
> (gdb) run -s
> Starting program: /home/gromero/qemu_tests/sigalrm -s
> 
> Catchpoint 1 (signal SIGALRM), 0x000000000041a410 in ualarm ()
> (gdb) quit
> 
> 
> I'd like to add for the async path using SIGALRM but I need more
> time to understand what's going on regarding SIGLARM. I understand
> that's nothing wrong with the Xfer:siginfo:read stub itself, and
> because the main goal of the test is to test the stub, if you don't
> mind, I'd like to keep only the test with SIGSEGV for v2 and leave
> the async test as a follow-up.

Well that's certainly surprising.
Would you please file a bug report about this?
I think I know what the problem is, but let's track it anyway.


r~

