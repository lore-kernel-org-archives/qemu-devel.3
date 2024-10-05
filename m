Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 120A2CFB42B
	for <qemu-devel@archiver.kernel.org>; Sat,  5 Oct 2024 17:44:48 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sx8p6-0001Rd-E3; Sat, 05 Oct 2024 13:44:08 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1sx8p4-0001RT-R3
 for qemu-devel@nongnu.org; Sat, 05 Oct 2024 13:44:06 -0400
Received: from mail-pl1-x62a.google.com ([2607:f8b0:4864:20::62a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1sx8p2-00048Z-Pu
 for qemu-devel@nongnu.org; Sat, 05 Oct 2024 13:44:06 -0400
Received: by mail-pl1-x62a.google.com with SMTP id
 d9443c01a7336-207115e3056so28832735ad.2
 for <qemu-devel@nongnu.org>; Sat, 05 Oct 2024 10:44:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1728150243; x=1728755043; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:content-language:references
 :cc:to:from:subject:user-agent:mime-version:date:message-id:from:to
 :cc:subject:date:message-id:reply-to;
 bh=gfEKgdiT3WP2kSZTMp7cI2aT/lR7+GpjtlOc6AX5xtw=;
 b=gXu0xGnzXUqlP5gebdIWPbKP3LpIGZMGrYV/AETUUBsLImZyQG/0gypSN+AFC7gjZ6
 mKoUOW8x3C+N0uN8825bBrAWw0S8+Xb/Qr54HAM2bwLmZUOL+199+4K2xVYlZKu6pVWE
 6mhWxezmAo8WY1/j14hhaXhVX2SOwcqnlFAjFvdE7SBUhIQTVNAkaPg5WIZZ2gODbO4D
 L5kZxe0fSstj6dcQVzTmK8RD6e4kK+6ngbfZEZlqPw+bQQybaBdxsGNq1ErBRt0HyXx0
 GeXQpkSR0TEQ6AULLLYQD0zHjtWi5TFUsSjDGHd6UuMbGnp4QU0ue62GpTMWWin9c/o9
 egCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1728150243; x=1728755043;
 h=content-transfer-encoding:in-reply-to:content-language:references
 :cc:to:from:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=gfEKgdiT3WP2kSZTMp7cI2aT/lR7+GpjtlOc6AX5xtw=;
 b=KUkdfA5HNvGTDw2c3EKn5oWhTnulNNFYMvE5m77IHNEuDlZK2+Rtu9rM25zUcEkSlm
 9Is288HcCH1DGLoHtIjz0u9+fkstgE2IxOFRi6fr/Bp2ASfsGRww3r26pB5hPKVGBgtg
 zW2cM5HZhsXQCU47xt53xffL+HJaGVDxFOH8jgOxkiAHFDhGUet+SveQL4ORawThhLSQ
 dh2at2BAM5fKyT7AjigtbNxaQd8m8awFYyEPgrdMYaZRep9RD28PaEMv4BkqHFELBOOg
 OOXBxqwCyY9L/KnYx3HPcXkqMRngLMQA530AMJdQ4k3bIUzGxkEEqKfKmZ5TbqW5cQ/l
 7gKA==
X-Forwarded-Encrypted: i=1;
 AJvYcCVTRj48aJ3oKbAGULPWhGHoxVz3C/UdS3jUpB+hpkP0d7DPPlPLz9KTbjb7XPFha1TTPrTvcZLUc8Hf@nongnu.org
X-Gm-Message-State: AOJu0YwNupCGJaCkr7BCTUezSmBj0HN5r5QZIQAHLLwHmOKHA1q2QPCs
 Ee0ux8Hj0x9BNmrv+j1408ZMxI/KvVfxjD6Ey7EsIukrSFWR0CmaxMtlRKh4o9k=
X-Google-Smtp-Source: AGHT+IEdb8GPBCLQgYyKJI2JjRAa1ikjHSemVGQM54h3keA8k2GooGagxmcczkpf4hRQJjJ6nR8brQ==
X-Received: by 2002:a17:902:da8c:b0:205:861c:5c4a with SMTP id
 d9443c01a7336-20bff1ea9e7mr80804865ad.60.1728150242945; 
 Sat, 05 Oct 2024 10:44:02 -0700 (PDT)
Received: from [192.168.1.67] (216-180-64-156.dyn.novuscom.net.
 [216.180.64.156]) by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-20c138cc5b1sm15639455ad.92.2024.10.05.10.44.02
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sat, 05 Oct 2024 10:44:02 -0700 (PDT)
Message-ID: <c106f7a4-7f73-49c8-8b31-3f468004ed2c@linaro.org>
Date: Sat, 5 Oct 2024 10:44:01 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] meson: ensure we enable CMPXCHG128 on x86_64
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
To: Michael Tokarev <mjt@tls.msk.ru>, qemu-devel@nongnu.org
Cc: alex.bennee@linaro.org, Paolo Bonzini <pbonzini@redhat.com>,
 richard.henderson@linaro.org, =?UTF-8?Q?Marc-Andr=C3=A9_Lureau?=
 <marcandre.lureau@redhat.com>, =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?=
 <berrange@redhat.com>, =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?=
 <philmd@linaro.org>
References: <20241004220123.978938-1-pierrick.bouvier@linaro.org>
 <5604626b-cba7-4d1c-8dfb-2c2e3b8495a5@tls.msk.ru>
 <bbbeebd4-2769-41f3-8cd0-1c0121ed4f06@linaro.org>
Content-Language: en-US
In-Reply-To: <bbbeebd4-2769-41f3-8cd0-1c0121ed4f06@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62a;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-pl1-x62a.google.com
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

On 10/5/24 10:34, Pierrick Bouvier wrote:
> On 10/5/24 09:16, Michael Tokarev wrote:
>> 05.10.2024 01:01, Pierrick Bouvier wrote:
>>> Alex discovered that CMPXCHG128 was not enabled when building for
>>> x86_64, resulting in slow execution for wide atomic instructions,
>>> creating a huge contention when combined with a high number of cpus
>>> (found while booting android aarch64 guest on x86_64 host).
>>>
>>> The problem is that even though we enable -mcx16 option for x86_64, this
>>> is not used when testing for CMPXCHG128. Thus, we silently turn it off.
>>>
>>> x86_64 is the only architecture adding machine flags for now, so the
>>> problem is limited to this host architecture.
>>>
>>> Meson compiler tests are supposed to be independent of environment flags
>>> (https://mesonbuild.com/Reference-manual_returned_compiler.html#returned-by).
>>> However, CFLAGS are used anyway, thus masking the problem when using
>>> something like CFLAGS='-march=native'. This is a meson bug and was reported:
>>> https://github.com/mesonbuild/meson/issues/13757
>>>
>>> Signed-off-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
>>> ---
>>>     meson.build | 10 +++++++++-
>>>     1 file changed, 9 insertions(+), 1 deletion(-)
>>>
>>> diff --git a/meson.build b/meson.build
>>> index b18c2a54ab5..af2ce595dcc 100644
>>> --- a/meson.build
>>> +++ b/meson.build
>>> @@ -2867,6 +2867,13 @@ if has_int128_type
>>>         config_host_data.set('CONFIG_ATOMIC128_OPT', has_atomic128_opt)
>>>     
>>>         if not has_atomic128_opt
>>> +
>>> +      host_flags = []
>>> +      if host_arch == 'x86_64'
>>> +        # for x86_64, x86_version must be >= 1, and we always enable cmpxchg16
>>> +        # in this case.
>>> +        host_flags += ['-mcx16']
>>> +      endif
>>>           config_host_data.set('CONFIG_CMPXCHG128', cc.links('''
>>>             int main(void)
>>>             {
>>> @@ -2874,7 +2881,8 @@ if has_int128_type
>>>               __sync_val_compare_and_swap_16(&x, y, x);
>>>               return 0;
>>>             }
>>> -      '''))
>>> +      ''',
>>> +      args: host_flags))
>>>         endif
>>>       endif
>>>     endif
>>
>>
>> This does not look right.  We test with an extra compiler flag, we should
>> ensure it is actually enabled for the actual build.  Here, we only test
>> if cmpxchg128 works with this flag appended, but do not enable if for
>> the build.  It just happens we have it enabled elsewhere..
>>
>> Maybe we should add this flags somewhere to $qemu_cflags in this place
>> if the test were successful.  With the proposed variant it is confusing
>> and works just because it happens to match in a few places, not because
>> it is supposed to work :)
> 
> If you look upper in meson.build (x86_version), you'll see this flag
> (-mcx16) is *always* enabled for x86_64, which is what the comment
> states in this patch.
> So it's already added to qemu_common_flags anyway. The problem is just
> that when we call cc.links, environment we defined is not reused.
> After discussing on IRC, we identified it was a really special case only
> for x64 and this instruction, so I didn't find useful to make a more
> complex solution than just using the same flag.
> 
> Maybe it would be more clear to define a qemu_machine_flags, and reuse
> it here (or in other places where it might be needed), but I feel like
> it's too complicated, and we can always add this later.
> 
> I'm open to implement something different for flags management, but I
> feel like we are thinking too much ahead.
> 
>>
>> Besides, in the current situation where CONFIG_CMPXCHG128 is not defined
>> due to this bug, the final link fails due to generated calls to -latomic, -
>> which might mean we have something else wrong.
>>
> 
> By default, __sync_val_compare_and_swap_16 is not available, except if
> we use explicitely -mcx16, or if we use an -march that implies this.
> 
> Our default level for x86_version does not enable it.
> 
> $ cat ./build/meson-logs/meson-log.txt
> 
> Code:
> 
>   
>   
> 
>           int main(void)
>   
> 
>           {
> 
>             __uint128_t x = 0, y = 0;
> 
>             __sync_val_compare_and_swap_16(&x, y, x);
>   
> 
>             return 0;
>   
> 
>           }
>   
> 
>   
> 
> -----------
>   
> 
> Command line: `cc -m64
> /home/user/.work/qemu/build/meson-private/tmpkoy6pfnd/testfile.c -o
> /home/user/.work/qemu/build/meson-private/tmpkoy6pfnd/output.exe -O2 -g
> -fno-omit-f
> rame-pointer -D_FILE_OFFSET_BITS=64 -O0 -std=gnu11` -> 1
>   
> 
> stderr:
>   
> 
> /usr/bin/ld: /tmp/cccPzS5X.o: in function `main':
> 
> /home/user/.work/qemu/build/meson-private/tmpkoy6pfnd/testfile.c:5:
> undefined reference to `__sync_val_compare_and_swap_16'
> 
> collect2: error: ld returned 1 exit status
> -----------
> 
>> FWIW.
>>
>> /mjt

Initially, the flag -mcx16 was forced in definition of CC in meson cross 
file (see c2bf2ccb266dc9ae4a6da75b845f54535417e109).
When it was removed and added in meson.build instead, it silently 
deactivated cmpxchg128 feature detection, and since everything still 
compiles/links correctly, we didn't notice until a recent investigation 
on a performance issue.

Root cause if that we try to identify a feature that depends on a 
specific compilation flag, and it's a scenario for which 
cc.compiles/cc.links is not designed out of the box. So it's normal that 
we have to add this flag manually somewhere.

I feel that having this explicitely in the meson.build is better than 
implicitly define it in value of CC.

I'm open to any idea you would like, we just need to have this flag 
somewhere, that's what fix the problem.

Regards,
Pierrick

