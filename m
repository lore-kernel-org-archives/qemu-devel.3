Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4600CC27C4F
	for <qemu-devel@archiver.kernel.org>; Tue, 18 Jun 2024 14:16:55 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sJZdF-000099-5J; Tue, 18 Jun 2024 10:16:21 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sJZdD-0008VL-Sa
 for qemu-devel@nongnu.org; Tue, 18 Jun 2024 10:16:19 -0400
Received: from mail-ej1-x62b.google.com ([2a00:1450:4864:20::62b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sJZdB-0005fM-2T
 for qemu-devel@nongnu.org; Tue, 18 Jun 2024 10:16:19 -0400
Received: by mail-ej1-x62b.google.com with SMTP id
 a640c23a62f3a-a6f04afcce1so708130066b.2
 for <qemu-devel@nongnu.org>; Tue, 18 Jun 2024 07:16:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1718720175; x=1719324975; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=AESVLnBWRylmnXQa+uafsA6TDVagSYeBpeHb+g6d2M0=;
 b=eW6+syrl1q/rfzA3XpzrR2BgyN/lfQKI5lanaevBkMoGOtm4VGGjknWyeipkNCnfBv
 TKcibj1O7i9zaWuByeOv3LOAvN7QT0OJW3R22WKZqj3PAdD5625TKHO88r293ca3AfbF
 oy4LxBG0v3mbcQy0hPOimY/7YMn9xxijPJBsnSerZ6P255u73U0Iy1m1zHhCIclOpDYO
 WP1OJT2EPa5eg+oKERLNIWZC5iojEZxhLncwRXw8d1c/47+bFqQlXLxdaeHaDwUJMUMj
 9M+p3bZK0Js/CpTFw3j/Pa7orrGfGYWKrp77oCWdAAP1dW+nFg2r6LVW6RCWccmn8ALo
 BrlA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1718720175; x=1719324975;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=AESVLnBWRylmnXQa+uafsA6TDVagSYeBpeHb+g6d2M0=;
 b=FD00Kr2JFuZC2F4BceL/5F+GBaAHL1wMyWs0cDuJQhOxT2eTuWASirq2VfBh5jAfLY
 abnEQJBCSsDEXhICdp1wMkF99N/hUpBlNph3JN8dqb9vszFbjbVvyzUF7TYgal3be+I2
 hl0FpyZ8QzY5GpujPznVfJ4px/ck+CvSJ0oVnmRX9F8xJwQpLHLR0n9b2XlUEPgJ3maX
 +ucB0MGS9AQpzNkpxIdLyuybpQ7owz+myTXbAuw9oR2PeFgDGkNZZJpXtVGXd1YHGuDP
 ATNQHc5dBGvFWPfAFWdCZ+4s5H4BmYp2D/t6YdJ8MQS7IitDY0RZyR4rcNt63LbOmjCt
 uR5w==
X-Forwarded-Encrypted: i=1;
 AJvYcCVK6JcqBxB1WfESas81H7nSypzOCWVnKoERdNONN2TFXRAKTyjo1B4ZnnXQp/aIPUq0c4h1F31shJaVl4we8QG6pREgtKc=
X-Gm-Message-State: AOJu0Yzf4EW2rJX7GH/Y+c1lKhxktAmgNMZcYJa+HWOmYh3uWNgpXuGg
 d4n0/LG9v+SC8uMn4L4kPi0S4OMJuwXvy+O3Fo7JYlu9d2yEu4Vw9b4odJ1Lcok=
X-Google-Smtp-Source: AGHT+IFXJWFEnSlq2u4MP+I10hzuvolZ0QzQsbtfiW2cjFEOg6qZ3v3/KJNaMARr/3ZmcoTBKhG6tw==
X-Received: by 2002:a17:906:33da:b0:a6f:1445:9de8 with SMTP id
 a640c23a62f3a-a6f60dc4f22mr914002666b.54.1718720175086; 
 Tue, 18 Jun 2024 07:16:15 -0700 (PDT)
Received: from [192.168.69.100] ([176.187.212.55])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-a6f56ed39ddsm634877666b.142.2024.06.18.07.16.14
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 18 Jun 2024 07:16:14 -0700 (PDT)
Message-ID: <4ca6b6a1-674a-4a8b-8633-08824bba9e6d@linaro.org>
Date: Tue, 18 Jun 2024 16:16:13 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 3/3] semihosting: Restrict to TCG
To: =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>
Cc: Paolo Bonzini <pbonzini@redhat.com>, qemu-devel@nongnu.org,
 Anton Johansson <anjo@rev.ng>
References: <20240529155548.5878-1-philmd@linaro.org>
 <20240529155548.5878-4-philmd@linaro.org>
 <CABgObfYmuvMq80Xz0ZBZQiHmKgoiSTVVqio8FmmpttT8rg64kA@mail.gmail.com>
 <7ce86375-779d-43d6-9871-7f9587c95ba6@linaro.org>
 <CABgObfbvjG9bBgCwM-kL+YhjhMw1qLnQdQToCEkKW+V3trskoA@mail.gmail.com>
 <d2b81c56-a57c-4fbe-a65e-86e9755e7c48@linaro.org>
 <5c913504-d917-4fd1-86d5-85d3bc293623@linaro.org>
 <8a22ada3-34e6-4d6d-aebe-67bc07d0f38f@linaro.org>
 <87zfricq2p.fsf@draig.linaro.org>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <87zfricq2p.fsf@draig.linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::62b;
 envelope-from=philmd@linaro.org; helo=mail-ej1-x62b.google.com
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

On 18/6/24 15:56, Alex Bennée wrote:
> Philippe Mathieu-Daudé <philmd@linaro.org> writes:
> 
>> ping :)
>>
>> On 12/6/24 15:12, Philippe Mathieu-Daudé wrote:
>>> Hi Paolo,
>>> On 30/5/24 15:58, Philippe Mathieu-Daudé wrote:
>>>> On 30/5/24 09:31, Paolo Bonzini wrote:
>>>>> On Thu, May 30, 2024 at 9:22 AM Philippe Mathieu-Daudé
>>>>> <philmd@linaro.org> wrote:
>>>>>>
>>>>>> On 30/5/24 08:02, Paolo Bonzini wrote:
>>>>>>> On Wed, May 29, 2024 at 5:56 PM Philippe Mathieu-Daudé
>>>>>>> <philmd@linaro.org> wrote:
>>>>>>>> It is pointless to build semihosting when TCG is not available.
>>>>>>>
>>>>>>> Why? I would have naively assumed that a suitable semihosting API
>>>>>>> could be implemented by KVM. The justification (and thus the commit
>>>>>>> message) needs to be different for each architecture if it's a matter
>>>>>>> of instruction set or insufficient KVM userspace API.
>>>>>>
>>>>>> I wasn't sure where semihosting could be used so asked on IRC and
>>>>>> Alex told me TCG only. Maybe the current implementation is TCG
>>>>>> only, and I can reword. It certainly need some refactor to work
>>>>>> on KVM, because currently semihosting end calling the TCG probe_access
>>>>>> API, which I'm trying to restrict to TCG in order to ease linking
>>>>>> multiple libtcg for the single binary (see
>>>>>> https://lore.kernel.org/qemu-devel/20240529155918.6221-1-philmd@linaro.org/).
>>>>>
>>>>> Ok, that goes in the commit message though.
>>>>>
>>>>> "Semihosting currently uses the TCG probe_access API. It is pointless
>>>>> to have it in the binary when TCG isn't".
>>>>>
>>>>> and in the first two patches:
>>>>>
>>>>> "Semihosting currently uses the TCG probe_access API. To prepare for
>>>>> encoding the TCG dependency in Kconfig, do not enable it unless TCG is
>>>>> available".
>>>>>
>>>>> But then, "select FOO if TCG" mean that it can be compiled out; so
>>>>> perhaps "imply SEMIHOSTING if TCG" is better? Same for RISC-V's
>>>>> "select ARM_COMPATIBLE_SEMIHOSTING if TCG".
>>> Building qemu-system-mips configured with --without-default-devices:
>>> Undefined symbols for architecture arm64:
>>>     "_qemu_semihosting_console_write", referenced from:
>>>         _mips_semihosting in target_mips_tcg_sysemu_mips-semi.c.o
>>>     "_semihost_sys_close", referenced from:
>>>         _mips_semihosting in target_mips_tcg_sysemu_mips-semi.c.o
>>>     "_uaccess_strlen_user", referenced from:
>>>         _mips_semihosting in target_mips_tcg_sysemu_mips-semi.c.o
>>>     ...
>>> So this one has to use "select".
>>> Similarly m68k:
>>> Undefined symbols for architecture arm64:
>>>     "_semihost_sys_close", referenced from:
>>>         _do_m68k_semihosting in target_m68k_m68k-semi.c.o
>>>     ...
>>> I can link m68k using semihosting stubs but I'm not sure it is
>>> right:
>>> -- >8 --
>>> diff --git a/semihosting/stubs-target-all.c
>>> b/semihosting/stubs-target-all.c
>>> new file mode 100644
>>> index 0000000000..1f33173f43
>>> --- /dev/null
>>> +++ b/semihosting/stubs-target-all.c
>>> @@ -0,0 +1,97 @@
>>> +/*
>>> + * Semihosting Stubs
>>> + *
>>> + * Copyright (c) 2024 Linaro Ltd
>>> + *
>>> + * Stubs for semihosting targets that don't actually do semihosting.
>>> + *
>>> + * SPDX-License-Identifier: GPL-2.0-or-later
>>> + */
>>> +
>>> +#include "qemu/osdep.h"
>>> +#include "exec/exec-all.h"
>>> +#include "semihosting/syscalls.h"
>>> +
>>> +void semihost_sys_open(CPUState *cs, gdb_syscall_complete_cb complete,
>>> +                       target_ulong fname, target_ulong fname_len,
>>> +                       int gdb_flags, int mode)
>>> +{
>>> +}
>>> +
>>> +void semihost_sys_close(CPUState *cs, gdb_syscall_complete_cb
>>> complete, int fd)
>>> +{
>>> +}
>>> +
>>> +void semihost_sys_read_gf(CPUState *cs, gdb_syscall_complete_cb complete,
>>> +                          GuestFD *gf, target_ulong buf, target_ulong len)
>>> +{
>>> +}
>>> +
>>> +void semihost_sys_read(CPUState *cs, gdb_syscall_complete_cb complete,
>>> +                       int fd, target_ulong buf, target_ulong len)
>>> +{
>>> +}
>>> +
>>> +void semihost_sys_write_gf(CPUState *cs, gdb_syscall_complete_cb complete,
>>> +                           GuestFD *gf, target_ulong buf,
>>> target_ulong len)
>>> +{
>>> +}
>>> +
>>> +void semihost_sys_write(CPUState *cs, gdb_syscall_complete_cb complete,
>>> +                        int fd, target_ulong buf, target_ulong len)
>>> +{
>>> +}
>>> +
>>> +void semihost_sys_lseek(CPUState *cs, gdb_syscall_complete_cb complete,
>>> +                        int fd, int64_t off, int gdb_whence)
>>> +{
>>> +}
>>> +
>>> +void semihost_sys_isatty(CPUState *cs, gdb_syscall_complete_cb
>>> complete, int fd)
>>> +{
>>> +}
>>> +
>>> +void semihost_sys_flen(CPUState *cs, gdb_syscall_complete_cb fstat_cb,
>>> +                       gdb_syscall_complete_cb flen_cb, int fd,
>>> +                       target_ulong fstat_addr)
>>> +{
>>> +}
>>> +
>>> +void semihost_sys_fstat(CPUState *cs, gdb_syscall_complete_cb complete,
>>> +                        int fd, target_ulong addr)
>>> +{
>>> +}
>>> +
>>> +void semihost_sys_stat(CPUState *cs, gdb_syscall_complete_cb complete,
>>> +                       target_ulong fname, target_ulong fname_len,
>>> +                       target_ulong addr)
>>> +{
>>> +}
>>> +
>>> +void semihost_sys_remove(CPUState *cs, gdb_syscall_complete_cb complete,
>>> +                         target_ulong fname, target_ulong fname_len)
>>> +{
>>> +}
>>> +
>>> +void semihost_sys_rename(CPUState *cs, gdb_syscall_complete_cb complete,
>>> +                         target_ulong oname, target_ulong oname_len,
>>> +                         target_ulong nname, target_ulong nname_len)
>>> +{
>>> +}
>>> +
>>> +void semihost_sys_system(CPUState *cs, gdb_syscall_complete_cb complete,
>>> +                         target_ulong cmd, target_ulong cmd_len)
>>> +{
>>> +}
>>> +
>>> +void semihost_sys_gettimeofday(CPUState *cs,
>>> gdb_syscall_complete_cb complete,
>>> +                               target_ulong tv_addr, target_ulong tz_addr)
>>> +{
>>> +}
>>> +
>>> +#ifndef CONFIG_USER_ONLY
>>> +void semihost_sys_poll_one(CPUState *cs, gdb_syscall_complete_cb complete,
>>> +                           int fd, GIOCondition cond, int timeout)
>>> +{
>>> +}
>>> +#endif
>>> diff --git a/semihosting/meson.build b/semihosting/meson.build
>>> index 34933e5a19..aa8b7a9913 100644
>>> --- a/semihosting/meson.build
>>> +++ b/semihosting/meson.build
>>> @@ -7,7 +7,7 @@ specific_ss.add(when: ['CONFIG_SEMIHOSTING',
>>> 'CONFIG_SYSTEM_ONLY'], if_true: fil
>>>      'config.c',
>>>      'console.c',
>>>      'uaccess.c',
>>> -))
>>> +), if_false: files('stubs-target-all.c'))
>>>    common_ss.add(when: ['CONFIG_SEMIHOSTING', 'CONFIG_SYSTEM_ONLY'],
>>> if_false: files('stubs-all.c'))
>>>    system_ss.add(when: ['CONFIG_SEMIHOSTING'], if_false:
>>> files('stubs-system.c'))
>>> ---
>>> For mips more stubs are needed:
>>> Undefined symbols for architecture arm64:
>>>     "_qemu_semihosting_console_write", referenced from:
>>>         _mips_semihosting in target_mips_tcg_sysemu_mips-semi.c.o
>>>     "_uaccess_lock_user", referenced from:
>>>         _mips_semihosting in target_mips_tcg_sysemu_mips-semi.c.o
>>>         _mips_semihosting in target_mips_tcg_sysemu_mips-semi.c.o
>>>         _mips_semihosting in target_mips_tcg_sysemu_mips-semi.c.o
>>>         _uhi_fstat_cb in target_mips_tcg_sysemu_mips-semi.c.o
>>>     "_uaccess_lock_user_string", referenced from:
>>>         _mips_semihosting in target_mips_tcg_sysemu_mips-semi.c.o
>>>         _mips_semihosting.cold.6 in target_mips_tcg_sysemu_mips-semi.c.o
>>>         _mips_semihosting.cold.6 in target_mips_tcg_sysemu_mips-semi.c.o
>>>     "_uaccess_strlen_user", referenced from:
>>>         _mips_semihosting in target_mips_tcg_sysemu_mips-semi.c.o
>>>     "_uaccess_unlock_user", referenced from:
>>>         _mips_semihosting in target_mips_tcg_sysemu_mips-semi.c.o
>>>         _mips_semihosting in target_mips_tcg_sysemu_mips-semi.c.o
>>>         _mips_semihosting in target_mips_tcg_sysemu_mips-semi.c.o
>>>         _mips_semihosting in target_mips_tcg_sysemu_mips-semi.c.o
>>>         _mips_semihosting in target_mips_tcg_sysemu_mips-semi.c.o
>>>         _mips_semihosting in target_mips_tcg_sysemu_mips-semi.c.o
>>>         _uhi_fstat_cb in target_mips_tcg_sysemu_mips-semi.c.o
>>>         ...
>>>
> 
> Oh sorry I was waiting for a re-spin. I should just apply the above to
> 3/3?

No, this is still unresolved :/ (this is a ping for Paolo :p)


