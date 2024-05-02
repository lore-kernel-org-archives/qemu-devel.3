Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1EB17C4345F
	for <qemu-devel@archiver.kernel.org>; Thu,  2 May 2024 13:35:37 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s2Wal-0003mG-GV; Thu, 02 May 2024 09:35:19 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1s2Waj-0003lM-CY
 for qemu-devel@nongnu.org; Thu, 02 May 2024 09:35:17 -0400
Received: from mail-wm1-x32c.google.com ([2a00:1450:4864:20::32c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1s2Wah-00073S-KP
 for qemu-devel@nongnu.org; Thu, 02 May 2024 09:35:17 -0400
Received: by mail-wm1-x32c.google.com with SMTP id
 5b1f17b1804b1-41a1d88723bso56075575e9.0
 for <qemu-devel@nongnu.org>; Thu, 02 May 2024 06:35:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1714656914; x=1715261714; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:content-language:references
 :cc:to:from:subject:user-agent:mime-version:date:message-id:from:to
 :cc:subject:date:message-id:reply-to;
 bh=navvtQMAII48l2qClK+Ufo/574aAb9S091cV2u33lic=;
 b=E48m/ERwPwVsUoIjExgEm5CvLOOeIir3gwM4/IJnIsGu1pwnRP34o5hd0FezMm4OoO
 /zEe/kRI2FSs9yc5zKwpA36hc6ZVa8SVs3JHajB2XZXVY3EtNC8l1yCwDx3uL7IPddwW
 QXt9eK9xqlyJS8m7Rlzzq0qwZf6P8Nam3cjvslBBNGPvKYQcF8lols1QnMZf9BKmhw8B
 Dzo4wgqqh0+TxPw1W3wTu6oyuPORfA3HEtaTaXm+a6C8gmUdPjPawEONKFhY8RCDKIbk
 YcH+iaHvXFN7AfwEI4Sqf3epJyMWGbaAyxu0Cy/p3OvQucVNhzM6UujX7inTFgutl+2Y
 LpmA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1714656914; x=1715261714;
 h=content-transfer-encoding:in-reply-to:content-language:references
 :cc:to:from:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=navvtQMAII48l2qClK+Ufo/574aAb9S091cV2u33lic=;
 b=MmY6JEC1mS2zHOtTxFtMz0aBpBLrEkCiHLq3mqbz1a5ObFsSqqXEQkj9wBq1Q/lbp8
 ivVwWuNdxFMgejEFm416KZAIF84Nye59oWPoul77gVsYm3fqq/bp+ZHCxLH6TyoJdnYA
 ExeqteuYU9jW2E5lP7ZGxcX5+HnXI9bAyT51E2b7jkgCUjjcZVqD+kuDi9ACMfOJH6WD
 eUY4c12vIM+O4FC7bdiZXBMeoGyF154ztcp1FboZwGs9Laz1AlJkpoJxEqOVHnRpUWkP
 hebGCbjrHoq1hkW3cLqH5LGQ2CJ1tTrTh2EOmK0eWtAhYDHgD9pw3zg+A6BUvDbmJzKJ
 RaVQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCUceeEJgSUhW2m6G3NawIJyF6vb0b7KS2338BbApUJZRDYoaBjUBNw+4+HZq2nXOYgs+fjXBkY0Ffupe3Qk1yiLQV2uXZk=
X-Gm-Message-State: AOJu0YwBAocXal6aKFS3cBAWk+4xbG1xO7LqqF3IXjme9Y3RhMD6HOhK
 E0dn0tSnSbGGnTzkhZw6euoKOG14nBTRwHnwhtORz/7eItS8/0mvWr33lgwdiFY=
X-Google-Smtp-Source: AGHT+IFSYANR9X3WhJwymIdYjItr3qHIRFLxOI+NOJo6D0PIhHSIfJgfhIofK77qAyPYlP0yS2m12A==
X-Received: by 2002:a05:600c:1d8c:b0:41a:fa9a:d86b with SMTP id
 p12-20020a05600c1d8c00b0041afa9ad86bmr3753710wms.11.1714656913980; 
 Thu, 02 May 2024 06:35:13 -0700 (PDT)
Received: from [192.168.69.100] ([176.187.215.106])
 by smtp.gmail.com with ESMTPSA id
 s7-20020a05600c384700b0041c12324eb6sm5777006wmr.22.2024.05.02.06.35.12
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 02 May 2024 06:35:13 -0700 (PDT)
Message-ID: <acb2ce05-a6a1-4a82-8db0-9248c05b6550@linaro.org>
Date: Thu, 2 May 2024 15:35:11 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 00/13] exec: Rework around CPUState user fields (part 2)
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: Ilya Leoshkevich <iii@linux.ibm.com>, qemu-devel@nongnu.org,
 Richard Henderson <richard.henderson@linaro.org>
Cc: Anton Johansson <anjo@rev.ng>, Peter Maydell <peter.maydell@linaro.org>
References: <20240430122808.72025-1-philmd@linaro.org>
 <363wwielvdpy37h7cqo7jo5luyys2aqmfgeb4t3wypsb3myqxg@kvasyjy4e767>
 <2a5e3a10-cc9a-44ff-8241-484d17b1f9cb@linaro.org>
 <90e4b6c6-2bc4-4f4a-ac65-8141c2eb4cb5@linaro.org>
 <uuuk6a2vo24yrrqrchjxaeko3utqshrdu6txcnqziokpg7dkom@4l4kd3dqh6jc>
 <0f147b71-a013-4c72-a860-d12636a45d22@linaro.org>
Content-Language: en-US
In-Reply-To: <0f147b71-a013-4c72-a860-d12636a45d22@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32c;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x32c.google.com
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

On 2/5/24 12:27, Philippe Mathieu-Daudé wrote:
> On 30/4/24 23:42, Ilya Leoshkevich wrote:
>> On Tue, Apr 30, 2024 at 09:00:17PM +0200, Philippe Mathieu-Daudé wrote:
>>> On 30/4/24 20:45, Philippe Mathieu-Daudé wrote:
>>>> Hi Ilya,
>>>>
>>>> On 30/4/24 19:55, Ilya Leoshkevich wrote:
>>>>> On Tue, Apr 30, 2024 at 02:27:54PM +0200, Philippe Mathieu-Daudé 
>>>>> wrote:
>>>>>> Missing WASM testing by Ilya (branch available at
>>>>>> https://gitlab.com/philmd/qemu/-/commits/tcg_flush_jmp_cache)
>>>>>
>>>>> Hmm, it dies very early now:
>>>>>
>>>>>     # gdb --args ./qemu-s390x -L /usr/s390x-linux-gnu 
>>>>> /build/wasmtime/target/s390x-unknown-linux-gnu/debug/deps/component_fuzz_util-d10a3a6b4ad8af47
>>>>>
>>>>>     Thread 1 "qemu-s390x" received signal SIGSEGV, Segmentation fault.
>>>>>     0x000055555559b718 in cpu_common_realizefn (dev=0x5555557c28c0,
>>>>> errp=<optimized out>) at
>>>>> ../home/iii/myrepos/qemu/hw/core/cpu-common.c:217
>>>>>     217             cpu->accel->plugin_state =
>>>>> qemu_plugin_create_vcpu_state();
>>>>>
>>>>>     (gdb) bt
>>>>>     #0  0x000055555559b718 in cpu_common_realizefn
>>>>> (dev=0x5555557c28c0, errp=<optimized out>) at
>>>>> ../home/iii/myrepos/qemu/hw/core/cpu-common.c:217
>>>>>     #1  0x000055555559f59a in s390_cpu_realizefn (dev=0x5555557c28c0,
>>>>> errp=0x7fffffffe1a0) at


>>>>>     (gdb) p cpu
>>>>>     $1 = (CPUState *) 0x5555557c28c0
>>>>>     (gdb) p cpu->accel
>>>>>     $2 = (AccelCPUState *) 0x0
>>>>>
>>>>> Configured with: '/home/iii/myrepos/qemu/configure'
>>>>> '--target-list=s390x-linux-user' '--disable-tools' '--disable-slirp'
>>>>> '--disable-fdt' '--disable-capstone' '--disable-docs'
>>>>>
> 
> 
>> Now I get:
>>
>>    Thread 1 "qemu-s390x" received signal SIGABRT, Aborted.
>>    __pthread_kill_implementation (threadid=<optimized out>, 
>> signo=signo@entry=6, no_tid=no_tid@entry=0) at ./nptl/pthread_kill.c:44
>>    44      ./nptl/pthread_kill.c: No such file or directory.
>>    (gdb) bt
>>    #0  __pthread_kill_implementation (threadid=<optimized out>, 
>> signo=signo@entry=6, no_tid=no_tid@entry=0) at ./nptl/pthread_kill.c:44
>>    #1  0x00007ffff7c41e8f in __pthread_kill_internal (signo=6, 
>> threadid=<optimized out>) at ./nptl/pthread_kill.c:78
>>    #2  0x00007ffff7bf2fb2 in __GI_raise (sig=sig@entry=6) at 
>> ../sysdeps/posix/raise.c:26
>>    #3  0x00007ffff7bdd472 in __GI_abort () at ./stdlib/abort.c:79
>>    #4  0x00007ffff7bdd395 in __assert_fail_base (fmt=0x7ffff7d51a90 
>> "%s%s%s:%u: %s%sAssertion `%s' failed.\n%n", 
>> assertion=assertion@entry=0x5555556d71b8 "cpu->accel",
>>        file=file@entry=0x5555556d70e0 
>> "../home/iii/myrepos/qemu/cpu-target.c", line=line@entry=158, 
>> function=function@entry=0x5555556d7260 <__PRETTY_FUNCTION__.3> 
>> "cpu_exec_realizefn") at ./assert/assert.c:92
>>    #5  0x00007ffff7bebeb2 in __GI___assert_fail 
>> (assertion=assertion@entry=0x5555556d71b8 "cpu->accel", 
>> file=file@entry=0x5555556d70e0 
>> "../home/iii/myrepos/qemu/cpu-target.c", line=line@entry=158,
>>        function=function@entry=0x5555556d7260 <__PRETTY_FUNCTION__.3> 
>> "cpu_exec_realizefn") at ./assert/assert.c:101
>>    #6  0x00005555555d44ca in cpu_exec_realizefn 
>> (cpu=cpu@entry=0x5555557c28c0, errp=errp@entry=0x7fffffffe140) at 
>> ../home/iii/myrepos/qemu/cpu-target.c:158
>>    #7  0x000055555559f50b in s390_cpu_realizefn (dev=0x5555557c28c0, 
>> errp=0x7fffffffe1a0) at ../home/iii/myrepos/qemu/target/s390x/cpu.c:261

>  From code review I think the problem is my commit bb6cf6f016
> ("accel/tcg: Factor tcg_cpu_reset_hold() out") which wanted
> to restrict tlb_flush() to system emulation, but inadvertently
> also restricted tcg_flush_jmp_cache(), which was before called
> via Realize -> Reset -> cpu_common_reset_hold(). Apparently
> now this code can't happen on user emulation.

This is indeed the root cause, I'll post a series fixing it.

