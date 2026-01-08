Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1104DD185C6
	for <qemu-devel@archiver.kernel.org>; Thu,  8 Jan 2026 11:15:01 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vdnyZ-0007IP-Pe; Thu, 08 Jan 2026 06:14:47 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vdnyN-0006sS-Se
 for qemu-devel@nongnu.org; Thu, 08 Jan 2026 06:14:39 -0500
Received: from mail-wr1-x434.google.com ([2a00:1450:4864:20::434])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vdnyM-0002sr-AA
 for qemu-devel@nongnu.org; Thu, 08 Jan 2026 06:14:35 -0500
Received: by mail-wr1-x434.google.com with SMTP id
 ffacd0b85a97d-42fb6ce71c7so2341773f8f.1
 for <qemu-devel@nongnu.org>; Thu, 08 Jan 2026 03:14:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1767870872; x=1768475672; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=qioBBHUiaxMZYeEB0MbHiTObDQ8AuHCkGzXcCkhKKZI=;
 b=sP+WlU2w40dOKdUuqYBc6as9Dw2im7MZLHbFIRl1k7OiVuCqpqaCN7ogUyEPWLNe9F
 2+qz7x7a0RnwYTHbc3Nlxhg4ebXeF8Hc5kkUO39ODAfu+7VMyhwQUuN4OtJdrOJsQfiP
 uquM2+lPZ7NZtbv/Jb8T14VT9vL7UAFpkFEzFiUffTQLFr+lTMYZDpSFeasPokNCkV/b
 KReNmlFoI8v2IG1ym6OfG2RyKeA/ScmEkwGUaL3ECmg1LwH/7BHg271Az32jOlxldFwy
 nVxFlwhrMVOAY9/C+hFjxpkaTm2JUeS4AqWO06SLg1mcdjb/BrBQnDyMn8CX/+5/TlmS
 3+0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1767870872; x=1768475672;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=qioBBHUiaxMZYeEB0MbHiTObDQ8AuHCkGzXcCkhKKZI=;
 b=NAaKTrcWZbJxRqfAmKynyVGGY63aL3FAvpqq9/e2yztfNacggcsH9y+GEEPE4W3TPf
 zw6XtCV2csc3wB0SMot2O61USw8x4KjI61UZgVHa3Q8zKxKJp84fX12dGg25P+c0KOuu
 jFmjJYRST3PMVp/6gQ/w78VykEaPm/76lNduJM1cTe+6aTAQpyBZEgdI9rT376Uorcdu
 4S76luBpgzCB5cMPe07Y5FyLyS8YXQs6oetLjjeBy35sjGFvbE6vnMlxzkHshCgtAAEj
 6RqGc2IvoC8UU7TVWM5euk6tvlSH1v1/I4BXtU4lhAJamxOrX+s2nudbpx1WjzHuJnxW
 K5WA==
X-Gm-Message-State: AOJu0YwtG1AK3n6hQDvp4OAdFGns8gRwxpqqDUdhMXqfQajqEnjOBIPF
 t7ZNYOZ8qdOg3I0kSa5r9CK/Xs1WJBbJ5+VWjAaiqAV5WixAslbqtFyKQLpciIw0MpE=
X-Gm-Gg: AY/fxX5vdd++ejK2JrTu+SbQx7rCYfWk/etXsyIpPotW/hg9xX6YAihSy/jsi3f+xyo
 nMnC5GbAwsBLOfIcxiK4+GREBLWfXD7T5I36UQR7SzEVUFoXELlFKUeA8yqFyB+9/mOgyYLGWLM
 sh0oIIFqqu7O8pDIP5i0pFLXDrRkHD0Rlq50Mn2uR5kmtPPBC7Xma4h26VpT6ooTMjgrDB4qZUz
 mYmR0PoM4BWcE2Mc7sVFHXjN1M9aT4X7kER2uAJmRCBX8gaOwEw+5fO6Tsw0Q9rWOrufK3ZyT41
 8BpWPrtXGq/aHDipepCpoAlvqYIZO3lyoE7lRDDoSjh+grdG9b1uuDSuhq2H10m9y+53kp41zgs
 H/HttAgxSlIbNqdJ+JzUnj9f1BE4QNwG2cRMpZhIAp6orPUS7Id1eyrGD+pRM/DyXta1jT5K9jv
 dGKNn99Sy80hTRArQw/vZDlB5wg+46fIIWopeSgN/qWxVUQ5PZe2g/HQ==
X-Google-Smtp-Source: AGHT+IEzZIO4Gq16jzgu/JLIZNwptz64vcPuSKKBEqs8+wHdINEg6zY3oDwFCgG1E1sUZJLrgPuCbA==
X-Received: by 2002:a05:6000:2508:b0:430:fbe1:382a with SMTP id
 ffacd0b85a97d-432c37d36e3mr8054661f8f.54.1767870871556; 
 Thu, 08 Jan 2026 03:14:31 -0800 (PST)
Received: from [192.168.69.213] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-432bd5ee5e3sm15853948f8f.35.2026.01.08.03.14.30
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 08 Jan 2026 03:14:30 -0800 (PST)
Message-ID: <a5c263e3-20a0-4736-9999-eca0ef639ba8@linaro.org>
Date: Thu, 8 Jan 2026 12:14:30 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/2] dump/win_dump: Use stubs on non-Windows hosts like
 POSIX
Content-Language: en-US
To: =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>
Cc: qemu-devel@nongnu.org, Ani Sinha <anisinha@redhat.com>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 =?UTF-8?Q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>
References: <20260107180519.50820-1-philmd@linaro.org>
 <20260107180519.50820-3-philmd@linaro.org> <aV902eZnijhEnONE@redhat.com>
 <0438ddd7-6061-4b7b-a995-0ec32f250f95@linaro.org>
 <aV-Ms5PQDCiIA86v@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <aV-Ms5PQDCiIA86v@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::434;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x434.google.com
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

On 8/1/26 11:53, Daniel P. Berrangé wrote:
> On Thu, Jan 08, 2026 at 11:51:00AM +0100, Philippe Mathieu-Daudé wrote:
>> On 8/1/26 10:11, Daniel P. Berrangé wrote:
>>> On Wed, Jan 07, 2026 at 07:05:19PM +0100, Philippe Mathieu-Daudé wrote:
>>>> Rather than compiling the same content for all targets (unused
>>>> most of the time, i.e. qemu-system-avr ...), build it once per
>>>> POSIX hosts. Check Windows host (less likely) before x86 host.
>>>>
>>>> Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
>>>> ---
>>>>    dump/win_dump-stubs.c | 21 +++++++++++++++++++++
>>>>    dump/win_dump.c       | 12 ++++++++----
>>>>    dump/meson.build      |  6 +++++-
>>>>    3 files changed, 34 insertions(+), 5 deletions(-)
>>>>    create mode 100644 dump/win_dump-stubs.c
>>>
>>> snip
>>>
>>>> diff --git a/dump/meson.build b/dump/meson.build
>>>> index 4277ce9328a..0aaf3f65d9c 100644
>>>> --- a/dump/meson.build
>>>> +++ b/dump/meson.build
>>>> @@ -1,2 +1,6 @@
>>>>    system_ss.add([files('dump.c', 'dump-hmp-cmds.c'), snappy, lzo])
>>>> -specific_ss.add(when: 'CONFIG_SYSTEM_ONLY', if_true: files('win_dump.c'))
>>>> +if host_os == 'windows'
>>>> +  system_ss.add(files('win_dump.c'))
>>>> +else
>>>> +  system_ss.add(files('win_dump-stubs.c'))
>>>> +endif
>>>
>>> This is very wrong.
>>>
>>> The win_dump.c  file has no association with Windows hosts. It is about
>>> creating crash dumps of Windows *guests* in the Windows dump format. The
>>> current conditional which builds it on TARGET_X86_64 is correct.
>>
>> Great to know this is a *guest* feature and not a *host* one.
>>
>> Something else is currently wrong, because this file is built with
>> qemu-system-avr on macOS.
> 
> Why is that a problem ?

Single binary can not be linked because each target has these same symbols.

> The entire file content is surrounded with
> 
>    #if defined(TARGET_X86_64)
>    ...the impl...
>    #else
>    ...stubs...
>    #endif
> 
> soo qemu-system-avr will be building the stubs which is fine. macOS
> is not a factor, since QEMU is fine to emulate Windows guests on
> macOS hosts and thus Win dump is in scope for macOS
> 
> With regards,
> Daniel


