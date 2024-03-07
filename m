Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3A3B4C54E49
	for <qemu-devel@archiver.kernel.org>; Thu,  7 Mar 2024 17:50:51 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1riHt2-0005uW-Ht; Thu, 07 Mar 2024 12:50:32 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <gustavo.romero@linaro.org>)
 id 1riHsz-0005tw-PL
 for qemu-devel@nongnu.org; Thu, 07 Mar 2024 12:50:29 -0500
Received: from mail-pf1-x42b.google.com ([2607:f8b0:4864:20::42b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <gustavo.romero@linaro.org>)
 id 1riHsx-0006Sj-DW
 for qemu-devel@nongnu.org; Thu, 07 Mar 2024 12:50:28 -0500
Received: by mail-pf1-x42b.google.com with SMTP id
 d2e1a72fcca58-6e62c65865cso1017369b3a.2
 for <qemu-devel@nongnu.org>; Thu, 07 Mar 2024 09:50:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1709833825; x=1710438625; darn=nongnu.org;
 h=content-transfer-encoding:content-language:in-reply-to:mime-version
 :user-agent:date:message-id:from:references:cc:to:subject:from:to:cc
 :subject:date:message-id:reply-to;
 bh=uPRtQV9H/oHcAqCcikIo1lgFFFIXUZpnUgBrM9PM5Ow=;
 b=FsNGQBJ9VvX0kEUs/boJOi/m1AG3Oi9I6UgDSFD5FNo3USupRXiSrdOLtQjafEJemD
 1Pjaj7FsDUun91Jt1mhKoU8YVbCFkbLVq/p1M7k6jAXRslfToWf4Ww4rOYaczM8ij51Z
 0XoxhEVKcEY6cyTggq8j6qo5PUjeHEkStFx2A2IretcAf4zS5gg6Jb0u6RZTWrlgOQ6R
 jW78fGVchuSc9FLrIph3RPIUbBaqeds3e2vdLPm6WX3LNoogz1E3hh/BZDBEfazgeuJ1
 EKq4f1/0L+EKNiirRvVQiXC3XuWKfeGVr6IhbJwPZEf1tHEiQEVby6uVpisW1IEThrf0
 TnyA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1709833825; x=1710438625;
 h=content-transfer-encoding:content-language:in-reply-to:mime-version
 :user-agent:date:message-id:from:references:cc:to:subject
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=uPRtQV9H/oHcAqCcikIo1lgFFFIXUZpnUgBrM9PM5Ow=;
 b=iReOCEydUwnjRIeNu4/jALXqkSt1kaNTBwMhdQ0piAhtStXs5VP8AcJkEN/sR58TYE
 n2CsNNlOM9ZE/Opr9nuq90169JVGkkQrEbhTLpeNEvjUA9kPNsJGJQVX6ISscny+A+8d
 849jiQ1byP9T3pPLmXWlm1EdbWf1jQY60BVYsgay4fvmsCLGZJxT01fGOR/6khhi9ir6
 rGTeRfTfDBC1YeHDR2gAM+O3dsgkQYWMTKWYir7LcyXOkhGL3EmMD5sEOTLhAxUXWW69
 CdJSSeugOWfevx/2DGcH08xewEnkpGa5JYn8HlPEutDtSmagcG98XUgSXj4N/KDyOlU1
 34YQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCVtNPf/IoX0wG9mOdpiMboDD90MwOu3fQhDIZxU4vWO3YkxALw5c1hAdo1ZUK5rWtX/mjgW8wx0m/p9UyiGzQyI7wucngM=
X-Gm-Message-State: AOJu0YxuJedfj0VZgvXViZN3HOKLvg4lGmQUcHq6vKOpCsetzFvvXV3+
 8BarYC3R+pVAdPW+RgCNJhabAMSNYjOLCh+LWI+kCO6HO3QeJ5wxVY3rbpqA4lQ=
X-Google-Smtp-Source: AGHT+IHSmifLzl2fl79pr1QKuCn+AegYgbb8JkzTYsAuiWAFVroH77tEMXflkoGTle7gX+52Rr+02Q==
X-Received: by 2002:a05:6a20:840e:b0:19e:9a59:20df with SMTP id
 c14-20020a056a20840e00b0019e9a5920dfmr9454503pzd.9.1709833825125; 
 Thu, 07 Mar 2024 09:50:25 -0800 (PST)
Received: from ?IPv6:2804:7f0:b401:120f:a4b2:91d8:ce8:af88?
 ([2804:7f0:b401:120f:a4b2:91d8:ce8:af88])
 by smtp.gmail.com with ESMTPSA id
 z13-20020aa7990d000000b006e6629e6a76sm975990pff.137.2024.03.07.09.50.23
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 07 Mar 2024 09:50:24 -0800 (PST)
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
From: Gustavo Romero <gustavo.romero@linaro.org>
Message-ID: <3973e3e8-cff0-19a3-3fed-f0eebc52d624@linaro.org>
Date: Thu, 7 Mar 2024 14:50:21 -0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.6.0
MIME-Version: 1.0
In-Reply-To: <cd6b5e0f-5a10-4acb-94d6-51073ceb5acf@linaro.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::42b;
 envelope-from=gustavo.romero@linaro.org; helo=mail-pf1-x42b.google.com
X-Spam_score_int: -41
X-Spam_score: -4.2
X-Spam_bar: ----
X-Spam_report: (-4.2 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, NICE_REPLY_A=-2.08,
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

Hi Richard,

On 3/4/24 7:51 PM, Richard Henderson wrote:
> On 3/4/24 10:59, Gustavo Romero wrote:
>>> Perhaps just abort for SIGABRT instead?
>>
>> Although this can make a simpler test, the test can't control
>> the si_addr value easily, which I think is interesting to be tested.
>>
>> Why do you prefer SIGABRT?
> 
> I missed that you were testing si_addr -- in which case SIGSEGV is a good match.
> 
> 
>>> A test using setitimer to raise SIGALRM would test the async path.
>>
>> SIGLARM doesn't generate any interesting siginfo?
> 
> It should at minimum have si_sig = SIGALRM.
> 
>>
>> gromero@arm64:~$ gdb -q ./sigalrm
>> Reading symbols from ./sigalrm...
>> (gdb) run
>> Starting program: /home/gromero/sigalrm
>>
>> Program terminated with signal SIGALRM, Alarm clock.
>> The program no longer exists.
>> (gdb) p $_siginfo
>> $1 = void
> 
> Well that's because the program died.
> Do you need to have gdb handle the signal?

ouch, right :)

However, on a remote target, even if I catch that signal using
'catch signal SIGALRM' the GDBstub only closes the connection
when SIGALRM is delivered. That's odd, I don't understand why.

I'm using the same binary that pretty much works on GDB locally.


[Remote target]

gromero@arm64:~$ gdb -q
gromero@arm64:~/qemu_tests$ gdb -q ./sigalrm
Reading symbols from ./sigalrm...
(gdb) catch signal SIGALRM
Catchpoint 1 (signal SIGALRM)
(gdb) c
The program is not being run.
(gdb) run
Starting program: /home/gromero/qemu_tests/sigalrm
[Inferior 1 (process 12732) exited normally]
(gdb) quit

on the QEMU gdbstub side it reports "Alarm clock":

gromero@amd:~/git/qemu/build$ ./qemu-aarch64 -g 1234 ./sigalrm -s
Alarm clock
gromero@amd:~/git/qemu/build$


[Locally]

gromero@arm64:~/qemu_tests$ gdb -q ./sigalrm
Reading symbols from ./sigalrm...
(gdb) catch signal SIGALRM
Catchpoint 1 (signal SIGALRM)
(gdb) run -s
Starting program: /home/gromero/qemu_tests/sigalrm -s

Catchpoint 1 (signal SIGALRM), 0x000000000041a410 in ualarm ()
(gdb) quit


I'd like to add for the async path using SIGALRM but I need more
time to understand what's going on regarding SIGLARM. I understand
that's nothing wrong with the Xfer:siginfo:read stub itself, and
because the main goal of the test is to test the stub, if you don't
mind, I'd like to keep only the test with SIGSEGV for v2 and leave
the async test as a follow-up.


Cheers,
Gustavo

