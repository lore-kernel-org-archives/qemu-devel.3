Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D147CFD376A
	for <qemu-devel@archiver.kernel.org>; Wed, 25 Feb 2026 17:04:02 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vvIFm-0008K1-7j; Wed, 25 Feb 2026 12:00:50 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1vvIFi-0008Hd-IB
 for qemu-devel@nongnu.org; Wed, 25 Feb 2026 12:00:47 -0500
Received: from mail-pl1-x635.google.com ([2607:f8b0:4864:20::635])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1vvIFg-0005AX-Ot
 for qemu-devel@nongnu.org; Wed, 25 Feb 2026 12:00:46 -0500
Received: by mail-pl1-x635.google.com with SMTP id
 d9443c01a7336-2ab232cc803so34355025ad.3
 for <qemu-devel@nongnu.org>; Wed, 25 Feb 2026 09:00:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1772038842; x=1772643642; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:autocrypt:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to;
 bh=K0b/EFHi0YUG5Z8njjU5r4LfNjQ5YJ3RoxQQjHgIq4Q=;
 b=i8/zOF+UGc/4wlLlwPHz3z+Np5SitqEiIdGeNRnGex4nugtKc1iaEJljJHmlfszILh
 WUmG/gClTUmsHhrm8/ocqluR3YSSsPe6Y5EmfC4oJcoKp9jejclPN+w1hz4mtlZbligP
 86lWl9ZYcqCjzQgMyqsoh2qoaMVA0VGGZHfawHiOx4pGzJYSIVMpPXPNwdS8ezuzfpop
 mQ18ZuxR6ywEfr6oIBs6CXu1QIJGpUSrPzl7mpZvx+U8fD7WETrEG4q8NygfwQpY4TdD
 quJKDCEZgTH5J1+wXK2UzZDYrklZbIhAepVOUEwDHXfE/B5ERiAkDtT9kQYuAOz3Zz1i
 pyLA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1772038842; x=1772643642;
 h=content-transfer-encoding:in-reply-to:autocrypt:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=K0b/EFHi0YUG5Z8njjU5r4LfNjQ5YJ3RoxQQjHgIq4Q=;
 b=WBB4NHuWCRX+HGaZJtzWUYYnrfZwHFc+SNSZa1csEEo6WTcDB/2I4KPJmFOeZ+20ut
 nwv8l74FjtBAmkkhU0mtti+vUJ5KM+bqyEybTZ8QzuzmeHP8Dk7HCtqSju3lTh5k8F1H
 l1JLq7Z27eB29jAM+sGWoniqBhSKN2NVX7Nn88gFgV4wIei2SOSj0Fmnf4t3wQbRAT29
 ZMOIYdIJ7w2N3oZpyt/1tpggmFt1NF3hXmmf9v0uZfhBngOQlCUQ8hnfITHLtdPYcpvb
 lVWPMduAoGE3J9ouUIIWKbSC4qI32su/cfPoDdpUHn0i/zxeB5g9LS0WaXBM3OYV3jE6
 bxYw==
X-Forwarded-Encrypted: i=1;
 AJvYcCVmCWRtx83RZjys3SSgS6gmdGmpjuT4XZ6S8YKFF6HrtN247iAgWnHnmuoFJUC2PC+DgZ+HPOJ92GHj@nongnu.org
X-Gm-Message-State: AOJu0YyDLOZ8zJ7ESwsbTZ1Xtx/OVX7M4gBKMvCqfYeftug6PzGOdhHn
 z/fPJmqKSwBKMF+YytsO/NACh6DXA/CeczJ0lBUQrR119LWEoY0Z/HgnugOvOomesi0=
X-Gm-Gg: ATEYQzyMy+gGYsgsPHu651SD1/AgJgZeYKK3fulLIqdarGxv7ISiNJJ3GxgVqYwJT/P
 EwyOvBes5O/SNeb2kli+GAr+XkjmSKbNlj5cI+XHiFTrefwpJys6dkC7fsdXMDHA8rrwE7YoXSg
 AnBmn47OLTQbZVQoRvp7J9t7wtzl8Bc+exESxexzVEaQVDzr4/3yIwUqVEjELaU/lkXWdCMalR4
 6RhEooVcSI9F8pksHOOawER4UzG/FlfU4Y0JWHlARXQ4i4yH+EOnzOfaZKGl7VbUAxPLWEuC+Wu
 Gk5LPBFdsfHPa+AkBa+mG/amFSQ+P90GHeCV1wlppPFt2YAmvdEUYdvvfRkk61LB3xWa4Jy4rtU
 3G1yeauNnDf/HTMUuNu8pI2JlBuMYUXcadpOaQf+RkpE1C9DQ518BHZB6RmUJf/fePGDrfsf6N+
 k7RHKm95m6GCBMW9OqqCQtoFzzWxyhuufwdpbuxe0w/IXXh14bvI4HdaFp8jSRMuFWODFZ
X-Received: by 2002:a17:903:41ca:b0:295:560a:e499 with SMTP id
 d9443c01a7336-2ade99a62f3mr8215325ad.5.1772038841808; 
 Wed, 25 Feb 2026 09:00:41 -0800 (PST)
Received: from [192.168.1.87] (216-71-219-44.dyn.novuscom.net. [216.71.219.44])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2ad75027641sm180404985ad.64.2026.02.25.09.00.40
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 25 Feb 2026 09:00:41 -0800 (PST)
Message-ID: <c39a8ca6-f727-4684-9c20-cade239e627c@linaro.org>
Date: Wed, 25 Feb 2026 09:00:40 -0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 2/7] linux-user: make syscall emulation interruptible
To: Florian Hofhammer <florian.hofhammer@epfl.ch>, qemu-devel@nongnu.org
Cc: alex.bennee@linaro.org, richard.henderson@linaro.org, laurent@vivier.eu,
 imp@bsdimp.com, berrange@redhat.com
References: <909b0a4f-9759-4e27-bba8-997ae2f41bd6@epfl.ch>
 <8096590c-bf13-4e5e-8167-ab38a37180bc@epfl.ch>
 <538ada16-07b8-403c-b1fa-f42db7cfc195@linaro.org>
 <1b6eef52-d6d0-4b11-a91c-6d8b43f4e3f8@epfl.ch>
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
Content-Language: en-US
Autocrypt: addr=pierrick.bouvier@linaro.org; keydata=
 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
 ZtfdHNZotF092MIH0IQC3poExQpV/WBYFAI=
In-Reply-To: <1b6eef52-d6d0-4b11-a91c-6d8b43f4e3f8@epfl.ch>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::635;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-pl1-x635.google.com
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

On 2/25/26 12:02 AM, Florian Hofhammer wrote:
> On 24/02/2026 22:05, Pierrick Bouvier wrote:
>> On 2/24/26 7:50 AM, Florian Hofhammer wrote:
>>> The syscall emulation code previously wasn't interruptible via
>>> cpu_loop_exit(), as this construct relies on a longjmp target that is not
>>> live anymore in the syscall handling code. Consequently, longjmp() would
>>> operate on a (potentially overwritten) stale jump buffer. This patch adds an additional
>>> setjmp and the necessary handling around it to make longjmp() (and by
>>> proxy cpu_loop_exit() safe to call even within a syscall context.
>>>
>>> Signed-off-by: Florian Hofhammer <florian.hofhammer@epfl.ch>
>>> ---
>>>    linux-user/aarch64/cpu_loop.c      |  2 +-
>>>    linux-user/alpha/cpu_loop.c        |  2 +-
>>>    linux-user/arm/cpu_loop.c          |  2 +-
>>>    linux-user/hexagon/cpu_loop.c      |  2 +-
>>>    linux-user/hppa/cpu_loop.c         |  4 ++++
>>>    linux-user/i386/cpu_loop.c         |  8 +++++---
>>>    linux-user/include/special-errno.h |  8 ++++++++
>>>    linux-user/loongarch64/cpu_loop.c  |  5 +++--
>>>    linux-user/m68k/cpu_loop.c         |  2 +-
>>>    linux-user/microblaze/cpu_loop.c   |  2 +-
>>>    linux-user/mips/cpu_loop.c         |  5 +++--
>>>    linux-user/or1k/cpu_loop.c         |  2 +-
>>>    linux-user/ppc/cpu_loop.c          |  6 ++++--
>>>    linux-user/riscv/cpu_loop.c        |  2 +-
>>>    linux-user/s390x/cpu_loop.c        |  2 +-
>>>    linux-user/sh4/cpu_loop.c          |  2 +-
>>>    linux-user/sparc/cpu_loop.c        |  4 +++-
>>>    linux-user/syscall.c               | 16 ++++++++++++++++
>>>    linux-user/xtensa/cpu_loop.c       |  3 +++
>>>    19 files changed, 59 insertions(+), 20 deletions(-)
>>>
>>> diff --git a/linux-user/sparc/cpu_loop.c b/linux-user/sparc/cpu_loop.c
>>> index 7391e2add8..f054316dce 100644
>>> --- a/linux-user/sparc/cpu_loop.c
>>> +++ b/linux-user/sparc/cpu_loop.c
>>> @@ -229,7 +229,9 @@ void cpu_loop (CPUSPARCState *env)
>>>                                  env->regwptr[2], env->regwptr[3],
>>>                                  env->regwptr[4], env->regwptr[5],
>>>                                  0, 0);
>>> -            if (ret == -QEMU_ERESTARTSYS || ret == -QEMU_ESIGRETURN) {
>>> +            if (ret == -QEMU_ERESTARTSYS
>>> +                    || ret == -QEMU_ESIGRETURN
>>> +                    || ret == -QEMU_ESETPC) {
>>>                    break;
>>>                }
>>
>> Just a style nit:
>> if (ret == -QEMU_ERESTARTSYS ||
>>      ret == -QEMU_ESIGRETURN ||
>>      ret == -QEMU_ESETPC) {
>>
>>>                if ((abi_ulong)ret >= (abi_ulong)(-515)) {
>>> diff --git a/linux-user/syscall.c b/linux-user/syscall.c
>>> index d466d0e32f..99e1ed97d9 100644
>>> --- a/linux-user/syscall.c
>>> +++ b/linux-user/syscall.c
>>> @@ -43,6 +43,7 @@
>>>    #include <linux/capability.h>
>>>    #include <sched.h>
>>>    #include <sys/timex.h>
>>> +#include <setjmp.h>
>>>    #include <sys/socket.h>
>>>    #include <linux/sockios.h>
>>>    #include <sys/un.h>
>>> @@ -600,6 +601,9 @@ const char *target_strerror(int err)
>>>        if (err == QEMU_ESIGRETURN) {
>>>            return "Successful exit from sigreturn";
>>>        }
>>> +    if (err == QEMU_ESETPC) {
>>> +        return "Successfully redirected control flow";
>>> +    }
>>>          return strerror(target_to_host_errno(err));
>>>    }
>>> @@ -14410,6 +14414,18 @@ abi_long do_syscall(CPUArchState *cpu_env, int num, abi_long arg1,
>>>            return -QEMU_ESIGRETURN;
>>>        }
>>>    +    /*
>>> +     * Set up a longjmp target here so that we can call cpu_loop_exit to
>>> +     * redirect control flow back to the main loop even from within
>>> +     * syscall-related plugin callbacks.
>>> +     * For other types of callbacks or longjmp call sites, the longjmp target
>>> +     * is set up in the cpu loop itself but in syscalls the target is not live
>>> +     * anymore.
>>> +     */
>>> +    if (unlikely(sigsetjmp(cpu->jmp_env, 0) != 0)) {
>>> +        return -QEMU_ESETPC;
>>> +    }
>>> +
>>
>> Makes sense, and I guess you found that when running the series test.
>>
>> Do you need all the new QEMU_FALLTHROUGH introduced here? Is it for removing warnings?
> 
> I think they're not strictly necessary, but if I recall correctly, I had
> warnings otherwise.
> I can remove them if you prefer but I think making the fallthrough
> explicit encodes the intent better.
>

If that compiles warning-free without it, you can remove it. Else, leave 
it as it is.

Fallthrough attribute is precisely used to silence warning compiler, and 
not to document code, even though it can help with that.

Thanks,
Pierrick

