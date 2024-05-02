Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C8943C4345F
	for <qemu-devel@archiver.kernel.org>; Thu,  2 May 2024 10:27:59 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s2Tf2-0005jA-41; Thu, 02 May 2024 06:27:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1s2Tf0-0005iq-4W
 for qemu-devel@nongnu.org; Thu, 02 May 2024 06:27:30 -0400
Received: from mail-lf1-x12a.google.com ([2a00:1450:4864:20::12a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1s2Teu-0006Uc-BV
 for qemu-devel@nongnu.org; Thu, 02 May 2024 06:27:26 -0400
Received: by mail-lf1-x12a.google.com with SMTP id
 2adb3069b0e04-51ca95db667so7961096e87.0
 for <qemu-devel@nongnu.org>; Thu, 02 May 2024 03:27:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1714645641; x=1715250441; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=KkuiXdIiO089AYWsnf/uvwGSaI5E9N0WtVA3qDtQsOU=;
 b=HKrZBx/SWoi8ipkvzMgcgtHoIX1b/gEBnu6B3ZI/uF3hEDAK7fl9nJ5jV20QDQwD8Q
 QqnVHZnD3BuEc73WJb2EixxLmrH4FzqCXVZ7mFl67X8+0foYjapjM4hNtw9MPlJ3G2GQ
 Ltv1Ts4qVFAq25zX6mcS+pHEbj++vyM+R5iOPIJ/4KFZUsr3jpEAHeiZYssLp5yzhoKx
 TVHa83Dl19QlmHeZ3LNgsFJU2/Nj8Tj4R0jNri6GRRfSbLPDKeYXLMW1WyR9MMIej6dO
 WOHwJdK6ziC7maBFUnvTp6wjfQWek4JnD2Z8xRuQ/LeqD0yWuAk4tm2k1IAYTRxjS0/R
 zxdA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1714645641; x=1715250441;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=KkuiXdIiO089AYWsnf/uvwGSaI5E9N0WtVA3qDtQsOU=;
 b=FEND/7VMsQ4e+8QZpWPQtQk+v5Mwu5ODzCEbeNkL7P2nYxcMWbdPJe3cxd2c6Wlk+z
 Q4BxhLITrj7WBj6OD8e05tdKJmB3sr9aWkSUqGcGQ7y1zcvwjDJSC1AFDirHVHLiLH6+
 poc33Vp38V1ZRumb+KnhNQ8j3kaiSnSDufuhn8hwugfbpe4suawE/nrL3ROR5C2oC8Ou
 8UtuTMhqrmYhxmnCHGayfrlPt3LBxXSKRPHRrgVtKiuPkLSEp0MJ8ArECe7EHqpXXqef
 MMLUCuQqXfu4FLm969bmclG8E2J3AhtacQDCeNuIhDpfd80Qo/m5edrCWDHggohgzIy8
 W47g==
X-Forwarded-Encrypted: i=1;
 AJvYcCWIuvrJkj36jGcAhTpI6fIxFzzlZZPMvwb3kZjQF+Ik10O6x6YKwRRSwBDiH7QskJa03BZ4O8vHAM51js90SIRS09rGGmg=
X-Gm-Message-State: AOJu0YzIxszn2EtQZEXZg6tn+7qe6N6Jsjpl7i8OMdqyoQ9VCGANrl98
 1LVmJyEMLtef4frSOXfP26y1KZl1axBnSh7ATJ4Dubyb3xePSgDNDEIEuHTc5OM=
X-Google-Smtp-Source: AGHT+IE/zTrmta8MJUnf6xyyNUAKyqVjii31zDOuFpj+UaldfOmPnixHbF9k2DNt+werqWdy69famQ==
X-Received: by 2002:a05:6512:3ac:b0:51c:dc6:a1ce with SMTP id
 v12-20020a05651203ac00b0051c0dc6a1cemr1047656lfp.7.1714645640797; 
 Thu, 02 May 2024 03:27:20 -0700 (PDT)
Received: from [192.168.69.100] ([176.187.215.106])
 by smtp.gmail.com with ESMTPSA id
 fc20-20020a05600c525400b00418accde252sm1451986wmb.30.2024.05.02.03.27.19
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 02 May 2024 03:27:20 -0700 (PDT)
Message-ID: <0f147b71-a013-4c72-a860-d12636a45d22@linaro.org>
Date: Thu, 2 May 2024 12:27:18 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 00/13] exec: Rework around CPUState user fields (part 2)
To: Ilya Leoshkevich <iii@linux.ibm.com>, qemu-devel@nongnu.org,
 Richard Henderson <richard.henderson@linaro.org>
Cc: Anton Johansson <anjo@rev.ng>, Peter Maydell <peter.maydell@linaro.org>
References: <20240430122808.72025-1-philmd@linaro.org>
 <363wwielvdpy37h7cqo7jo5luyys2aqmfgeb4t3wypsb3myqxg@kvasyjy4e767>
 <2a5e3a10-cc9a-44ff-8241-484d17b1f9cb@linaro.org>
 <90e4b6c6-2bc4-4f4a-ac65-8141c2eb4cb5@linaro.org>
 <uuuk6a2vo24yrrqrchjxaeko3utqshrdu6txcnqziokpg7dkom@4l4kd3dqh6jc>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <uuuk6a2vo24yrrqrchjxaeko3utqshrdu6txcnqziokpg7dkom@4l4kd3dqh6jc>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::12a;
 envelope-from=philmd@linaro.org; helo=mail-lf1-x12a.google.com
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

On 30/4/24 23:42, Ilya Leoshkevich wrote:
> On Tue, Apr 30, 2024 at 09:00:17PM +0200, Philippe Mathieu-Daudé wrote:
>> On 30/4/24 20:45, Philippe Mathieu-Daudé wrote:
>>> Hi Ilya,
>>>
>>> On 30/4/24 19:55, Ilya Leoshkevich wrote:
>>>> On Tue, Apr 30, 2024 at 02:27:54PM +0200, Philippe Mathieu-Daudé wrote:
>>>>> Missing WASM testing by Ilya (branch available at
>>>>> https://gitlab.com/philmd/qemu/-/commits/tcg_flush_jmp_cache)
>>>>
>>>> Hmm, it dies very early now:
>>>>
>>>>     # gdb --args ./qemu-s390x -L /usr/s390x-linux-gnu /build/wasmtime/target/s390x-unknown-linux-gnu/debug/deps/component_fuzz_util-d10a3a6b4ad8af47
>>>>
>>>>     Thread 1 "qemu-s390x" received signal SIGSEGV, Segmentation fault.
>>>>     0x000055555559b718 in cpu_common_realizefn (dev=0x5555557c28c0,
>>>> errp=<optimized out>) at
>>>> ../home/iii/myrepos/qemu/hw/core/cpu-common.c:217
>>>>     217             cpu->accel->plugin_state =
>>>> qemu_plugin_create_vcpu_state();
>>>>
>>>>     (gdb) bt
>>>>     #0  0x000055555559b718 in cpu_common_realizefn
>>>> (dev=0x5555557c28c0, errp=<optimized out>) at
>>>> ../home/iii/myrepos/qemu/hw/core/cpu-common.c:217
>>>>     #1  0x000055555559f59a in s390_cpu_realizefn (dev=0x5555557c28c0,
>>>> errp=0x7fffffffe1a0) at
>>>> ../home/iii/myrepos/qemu/target/s390x/cpu.c:284
>>>>     #2  0x000055555563f76b in device_set_realized (obj=<optimized
>>>> out>, value=<optimized out>, errp=0x7fffffffe2e0) at
>>>> ../home/iii/myrepos/qemu/hw/core/qdev.c:510
>>>>     #3  0x000055555564363d in property_set_bool (obj=0x5555557c28c0,
>>>> v=<optimized out>, name=<optimized out>, opaque=0x5555557a9140,
>>>> errp=0x7fffffffe2e0) at ../home/iii/myrepos/qemu/qom/object.c:2362
>>>>     #4  0x0000555555646b9b in object_property_set
>>>> (obj=obj@entry=0x5555557c28c0, name=name@entry=0x5555556e8ae2
>>>> "realized", v=v@entry=0x5555557c6650,
>>>> errp=errp@entry=0x7fffffffe2e0)
>>>>         at ../home/iii/myrepos/qemu/qom/object.c:1471
>>>>     #5  0x000055555564a43f in object_property_set_qobject
>>>> (obj=obj@entry=0x5555557c28c0, name=name@entry=0x5555556e8ae2
>>>> "realized", value=value@entry=0x5555557a7a90,
>>>> errp=errp@entry=0x7fffffffe2e0)
>>>>         at ../home/iii/myrepos/qemu/qom/qom-qobject.c:28
>>>>     #6  0x0000555555647204 in object_property_set_bool
>>>> (obj=0x5555557c28c0, name=name@entry=0x5555556e8ae2 "realized",
>>>> value=value@entry=true, errp=errp@entry=0x7fffffffe2e0)
>>>>         at ../home/iii/myrepos/qemu/qom/object.c:1541
>>>>     #7  0x000055555564025c in qdev_realize (dev=<optimized out>,
>>>> bus=bus@entry=0x0, errp=errp@entry=0x7fffffffe2e0) at
>>>> ../home/iii/myrepos/qemu/hw/core/qdev.c:291
>>>>     #8  0x000055555559bbb4 in cpu_create (typename=<optimized out>)
>>>> at ../home/iii/myrepos/qemu/hw/core/cpu-common.c:61
>>>>     #9  0x000055555559a467 in main (argc=4, argv=0x7fffffffeaa8,
>>>> envp=<optimized out>) at
>>>> ../home/iii/myrepos/qemu/linux-user/main.c:811
>>>>
>>>>     (gdb) p cpu
>>>>     $1 = (CPUState *) 0x5555557c28c0
>>>>     (gdb) p cpu->accel
>>>>     $2 = (AccelCPUState *) 0x0
>>>>
>>>> Configured with: '/home/iii/myrepos/qemu/configure'
>>>> '--target-list=s390x-linux-user' '--disable-tools' '--disable-slirp'
>>>> '--disable-fdt' '--disable-capstone' '--disable-docs'
>>>>


> Now I get:
> 
>    Thread 1 "qemu-s390x" received signal SIGABRT, Aborted.
>    __pthread_kill_implementation (threadid=<optimized out>, signo=signo@entry=6, no_tid=no_tid@entry=0) at ./nptl/pthread_kill.c:44
>    44      ./nptl/pthread_kill.c: No such file or directory.
>    (gdb) bt
>    #0  __pthread_kill_implementation (threadid=<optimized out>, signo=signo@entry=6, no_tid=no_tid@entry=0) at ./nptl/pthread_kill.c:44
>    #1  0x00007ffff7c41e8f in __pthread_kill_internal (signo=6, threadid=<optimized out>) at ./nptl/pthread_kill.c:78
>    #2  0x00007ffff7bf2fb2 in __GI_raise (sig=sig@entry=6) at ../sysdeps/posix/raise.c:26
>    #3  0x00007ffff7bdd472 in __GI_abort () at ./stdlib/abort.c:79
>    #4  0x00007ffff7bdd395 in __assert_fail_base (fmt=0x7ffff7d51a90 "%s%s%s:%u: %s%sAssertion `%s' failed.\n%n", assertion=assertion@entry=0x5555556d71b8 "cpu->accel",
>        file=file@entry=0x5555556d70e0 "../home/iii/myrepos/qemu/cpu-target.c", line=line@entry=158, function=function@entry=0x5555556d7260 <__PRETTY_FUNCTION__.3> "cpu_exec_realizefn") at ./assert/assert.c:92
>    #5  0x00007ffff7bebeb2 in __GI___assert_fail (assertion=assertion@entry=0x5555556d71b8 "cpu->accel", file=file@entry=0x5555556d70e0 "../home/iii/myrepos/qemu/cpu-target.c", line=line@entry=158,
>        function=function@entry=0x5555556d7260 <__PRETTY_FUNCTION__.3> "cpu_exec_realizefn") at ./assert/assert.c:101
>    #6  0x00005555555d44ca in cpu_exec_realizefn (cpu=cpu@entry=0x5555557c28c0, errp=errp@entry=0x7fffffffe140) at ../home/iii/myrepos/qemu/cpu-target.c:158
>    #7  0x000055555559f50b in s390_cpu_realizefn (dev=0x5555557c28c0, errp=0x7fffffffe1a0) at ../home/iii/myrepos/qemu/target/s390x/cpu.c:261
>    #8  0x000055555563f78b in device_set_realized (obj=<optimized out>, value=<optimized out>, errp=0x7fffffffe2e0) at ../home/iii/myrepos/qemu/hw/core/qdev.c:510
>    #9  0x000055555564365d in property_set_bool (obj=0x5555557c28c0, v=<optimized out>, name=<optimized out>, opaque=0x5555557a9140, errp=0x7fffffffe2e0) at ../home/iii/myrepos/qemu/qom/object.c:2362
>    #10 0x0000555555646bbb in object_property_set (obj=obj@entry=0x5555557c28c0, name=name@entry=0x5555556e8ae2 "realized", v=v@entry=0x5555557c6650, errp=errp@entry=0x7fffffffe2e0)
>        at ../home/iii/myrepos/qemu/qom/object.c:1471
>    #11 0x000055555564a45f in object_property_set_qobject (obj=obj@entry=0x5555557c28c0, name=name@entry=0x5555556e8ae2 "realized", value=value@entry=0x5555557a7a90, errp=errp@entry=0x7fffffffe2e0)
>        at ../home/iii/myrepos/qemu/qom/qom-qobject.c:28
>    #12 0x0000555555647224 in object_property_set_bool (obj=0x5555557c28c0, name=name@entry=0x5555556e8ae2 "realized", value=value@entry=true, errp=errp@entry=0x7fffffffe2e0)
>        at ../home/iii/myrepos/qemu/qom/object.c:1541
>    #13 0x000055555564027c in qdev_realize (dev=<optimized out>, bus=bus@entry=0x0, errp=errp@entry=0x7fffffffe2e0) at ../home/iii/myrepos/qemu/hw/core/qdev.c:291
>    #14 0x000055555559bb54 in cpu_create (typename=<optimized out>) at ../home/iii/myrepos/qemu/hw/core/cpu-common.c:57
>    #15 0x000055555559a467 in main (argc=4, argv=0x7fffffffeaa8, envp=<optimized out>) at ../home/iii/myrepos/qemu/linux-user/main.c:811

 From code review I think the problem is my commit bb6cf6f016
("accel/tcg: Factor tcg_cpu_reset_hold() out") which wanted
to restrict tlb_flush() to system emulation, but inadvertently
also restricted tcg_flush_jmp_cache(), which was before called
via Realize -> Reset -> cpu_common_reset_hold(). Apparently
now this code can't happen on user emulation.

