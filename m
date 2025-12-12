Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 765B3D59D6F
	for <qemu-devel@archiver.kernel.org>; Fri, 12 Dec 2025 17:36:26 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vU73s-0001kQ-0k; Fri, 12 Dec 2025 12:36:12 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1vU73p-0001jq-Sc
 for qemu-devel@nongnu.org; Fri, 12 Dec 2025 12:36:10 -0500
Received: from mail-pf1-x42e.google.com ([2607:f8b0:4864:20::42e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1vU73o-0005sq-0h
 for qemu-devel@nongnu.org; Fri, 12 Dec 2025 12:36:09 -0500
Received: by mail-pf1-x42e.google.com with SMTP id
 d2e1a72fcca58-7b75e366866so701543b3a.2
 for <qemu-devel@nongnu.org>; Fri, 12 Dec 2025 09:36:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1765560966; x=1766165766; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=FjJ8kmq+PNmH+QUBOdNLacaBstO6FE7Kc9eBq//2RGE=;
 b=voN3XtwhOV4ZcCZ/ShrQgEiDoyXWGk44PW3juwnAkgXVB8uMUg+RoOxxfNiwWuf2Bb
 GOFFF8hWr+sATm3d0V59osLdjuC7crD1+nRENgu7WTmp3Vj1d0tLybFst4Ddp79bOuM0
 eIFy1/ipSfnZDXAHDSCy4oo/PSXILZVNCvOLEDstDz8a/6+vZqnE9GSCykhPgFbDeH8H
 vSqF/GKDecRGtJhvs77pOa1keBCs0BxZxNlK+EHfNh2ZZHVKu5SOT59mLVfnbGMKGsmd
 t1zhjjmapDnVOo2HeCtDvXO7R/na/CBNmcf74TyMgqwKXKguc45iyuajPV6E43LVQxm8
 jKlw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1765560966; x=1766165766;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=FjJ8kmq+PNmH+QUBOdNLacaBstO6FE7Kc9eBq//2RGE=;
 b=dDB9EqF4NiElQZxgphcPxx4qrm/Rri2ISf7Hj8EDETRT5K6ZPOw5UHVEToyx51Q1C0
 c0tf8qHN69/khDRC3+0TXPB7oAVAWhzSlAgvp2HWtPPD4riCLXcP41K+wkQnodZ5TP77
 6c5GUvZRk4NnRL5eDxCnU6UBgYfLMWQYD8wtcXkel5rWqfiZO8VjUDUXeW7O+ItiaZue
 NnGZxSqYNhL+ORhK6X3cupNV9KloVRON9ikYdvm0OHUaN5r6l91S6ZF+VIPwCaVxNqN/
 WAFgrP9HbJEzrekQaQlnYQlVKMqkjTJoGWuoUq5u2Jrqs3imMj4FlG/EszeXBzlbHFTZ
 WwcA==
X-Gm-Message-State: AOJu0Yy1746uYHNGXImBg7lKKMrL8v6P3weSYGufUfLCeER75r0hjBw+
 MO16z02wkRY9KznH0LXL4GHtXbfudJ8RST5LcWcvvJFL/aXnIeqN+eGjcAG3BLjdvVQ=
X-Gm-Gg: AY/fxX49c6aed8gebxCb7o4yDgzlU0tqL///Xa2RfBq6nLse69ZUbqv0lZ8PGrm5nW0
 HuzD9GvWErtYf4ngj4M3jmRv5r2z5Z3len33B7rDuYWoLdwY+uOYYK8ruFR8SPFClSMvh8R9bPK
 MY4HUjNORSXulXFUmzrVIwoiv25+lc3PXBFFz3yzgituCR9FpqJ7y6QyJ80BL1cY9LvYdwmo8Ox
 knnfN/Iw9/Akzj9Ex0mxZX1tm8kpWbqw1PhaQYRUHMue+5RvE1klJggFdkV/4UYzivHp+uRinDs
 0p2p8kprT33D+M1edzKPplh0JCsdPnNF6YUqw2UEdj52JNnmIkdwy2K4gDUO96wPHYFjhKpKyqd
 dkdEMphE0Z1lhrLD8q51ldyfS+dbPyyLYMPHfewOc1FeRvuNRS3p8b0s1w6NOyqYbDVXdsU/Pyb
 CaEeIx6gW11G1gIfTKCBG0aVtBz2LPmwNjFypzqmFz1Ui3dXDpq0p1vDg=
X-Google-Smtp-Source: AGHT+IE9ucljhxu5JbbPnixp1thjht90uzItHZMjtfq0Zk2s/nDVJ5EIk44aaB3XnpfDv41OIJv5cg==
X-Received: by 2002:a05:6a00:b486:b0:7e8:43f5:bd57 with SMTP id
 d2e1a72fcca58-7f669c8d79bmr2620153b3a.67.1765560966240; 
 Fri, 12 Dec 2025 09:36:06 -0800 (PST)
Received: from [192.168.1.87] (216-71-219-44.dyn.novuscom.net. [216.71.219.44])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-7f4c4aa6c49sm5716409b3a.34.2025.12.12.09.36.05
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 12 Dec 2025 09:36:05 -0800 (PST)
Message-ID: <f9c8243e-1b34-464d-a6ed-d26e5b844fcc@linaro.org>
Date: Fri, 12 Dec 2025 09:36:05 -0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH v2 0/2] Enable PC diversion via the plugin API
Content-Language: en-US
To: =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Florian Hofhammer <florian.hofhammer@epfl.ch>
Cc: qemu-devel@nongnu.org, richard.henderson@linaro.org, laurent@vivier.eu,
 imp@bsdimp.com, berrange@redhat.com
References: <e9bcd7c7-2d67-469e-b2f3-d1a68e456b2b@epfl.ch>
 <f06e2059-9d86-4a5c-acff-84cbeabcfb06@epfl.ch>
 <87ikebucv4.fsf@draig.linaro.org>
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
In-Reply-To: <87ikebucv4.fsf@draig.linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::42e;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-pf1-x42e.google.com
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

On 12/12/25 4:02 AM, Alex Bennée wrote:
> Florian Hofhammer <florian.hofhammer@epfl.ch> writes:
> 
>> Hi,
>>
>> Sorry for necrobumping this thread. I just wanted to follow up on this
>> and ask if there is still interest in this plugin API extension or if it
>> is going to be dropped in favor of the Lorelei patches (which would also
>> fulfill my original use case).
> 
> These are the system call filter patches?
> 
> I guess that depends on if being able to change PC is only for skipping
> syscalls?
>

Both can probably coexist, as they serve different purposes.
If only considering syscalls, the syscall filter (that you propose 
first) is the best way to deal with it, as it's architecture agnostic.

That said, it would be sad to drop the effort you made into this series, 
and overriding pc can be convenient if anyone wants to filter anything 
else than syscalls, or for fuzzing purpose.

>>
>> Thanks for your time,
>> Florian
>>
>> On 06/10/2025 15:21, Florian Hofhammer wrote:
>>> Hi,
>>>
>>> As originally discussed in the thread at
>>> https://lists.nongnu.org/archive/html/qemu-devel/2025-08/msg00656.html
>>> and later proposed in a patch at
>>> https://lists.nongnu.org/archive/html/qemu-devel/2025-09/msg02218.html,
>>> I am sending an updated version of my patch based on the previous
>>> feedback.
>>>
>>> Notable changes to v1:
>>> - Added a setjmp() in the syscall handling path to allow redirecting
>>>    the PC via cpu_loop_exit() also in syscall callbacks. The previous
>>>    version would only work in instruction execution / memory access
>>>    callback contexts, as the setjmp() corresponding to the longjmp() in
>>>    cpu_loop_exit() was only live in those contexts.
>>> - Added a flag to make sure the new API function is only called in
>>>    contexts where it makes sense, i.e., during execution of guest code.
>>> - Added a test that checks the new functionality by skipping a
>>>    non-existent sentinel syscall.
>>>
>>> I made it an RFC patch this time as I am not entirely sure if my
>>> setting/handling of the new flag makes sense the way it is. I briefly
>>> looked into making the QEMU_PLUGIN_CB_* flags actual flags via a
>>> bitfield instead of enum values, but that would have required touching
>>> a lot of code all over the place, so I'm not sure this is the way to go.
>>>
>>> Happy to get feedback and your thoughts on the patches!
>>>
>>> Thanks,
>>> Florian
>>>
>>>
>>> Florian Hofhammer (2):
>>>    plugins: Add PC diversion API function
>>>    tests/tcg: add test for qemu_plugin_set_pc API
>>>
>>>   include/qemu/qemu-plugin.h                    | 15 +++++++
>>>   linux-user/aarch64/cpu_loop.c                 |  2 +-
>>>   linux-user/alpha/cpu_loop.c                   |  2 +-
>>>   linux-user/arm/cpu_loop.c                     |  2 +-
>>>   linux-user/hexagon/cpu_loop.c                 |  2 +-
>>>   linux-user/hppa/cpu_loop.c                    |  4 ++
>>>   linux-user/i386/cpu_loop.c                    |  8 ++--
>>>   linux-user/include/special-errno.h            |  8 ++++
>>>   linux-user/loongarch64/cpu_loop.c             |  5 ++-
>>>   linux-user/m68k/cpu_loop.c                    |  2 +-
>>>   linux-user/microblaze/cpu_loop.c              |  2 +-
>>>   linux-user/mips/cpu_loop.c                    |  5 ++-
>>>   linux-user/openrisc/cpu_loop.c                |  2 +-
>>>   linux-user/ppc/cpu_loop.c                     |  6 ++-
>>>   linux-user/riscv/cpu_loop.c                   |  2 +-
>>>   linux-user/s390x/cpu_loop.c                   |  2 +-
>>>   linux-user/sh4/cpu_loop.c                     |  2 +-
>>>   linux-user/sparc/cpu_loop.c                   |  4 +-
>>>   linux-user/syscall.c                          |  8 ++++
>>>   linux-user/xtensa/cpu_loop.c                  |  3 ++
>>>   plugins/api.c                                 | 17 +++++++-
>>>   plugins/core.c                                | 25 ++++++-----
>>>   tests/tcg/multiarch/Makefile.target           | 42 +++++++++++++++++++
>>>   .../tcg/multiarch/test-plugin-skip-syscalls.c | 26 ++++++++++++
>>>   tests/tcg/plugins/syscall.c                   |  6 +++
>>>   25 files changed, 170 insertions(+), 32 deletions(-)
>>>   create mode 100644 tests/tcg/multiarch/test-plugin-skip-syscalls.c
>>>
> 


