Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8BC3BC04FFE
	for <qemu-devel@archiver.kernel.org>; Mon, 20 May 2024 18:49:25 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s983y-0004Tu-Jf; Mon, 20 May 2024 14:48:46 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <perry@mosi.io>) id 1s983x-0004Tc-08
 for qemu-devel@nongnu.org; Mon, 20 May 2024 14:48:45 -0400
Received: from mail-pl1-x633.google.com ([2607:f8b0:4864:20::633])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <perry@mosi.io>) id 1s983u-00067C-VR
 for qemu-devel@nongnu.org; Mon, 20 May 2024 14:48:44 -0400
Received: by mail-pl1-x633.google.com with SMTP id
 d9443c01a7336-1ed904c2280so72699435ad.2
 for <qemu-devel@nongnu.org>; Mon, 20 May 2024 11:48:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mosi-io.20230601.gappssmtp.com; s=20230601; t=1716230921; x=1716835721;
 darn=nongnu.org; 
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=rgMh1b8jfQDDpXmKRMIWnzZOWOSSOQzEU2PxVTUo8MI=;
 b=of2poDspEAj90PWueai7DRrNzoITY1mWUrgVXR4LAtvMWKLBttNhemUoRDvV9/WbcJ
 B3DTvPVruY/miRXCzneYkCH0ipDYkY17X3n8SLWeXw1WVEd+qEheWdWDl3owAhuxofRl
 N9pOFdERaV/zYXBZXXpnVFX/S9D6LpyJpY1vJ/IQzRe7SqlgLEGuXOxuwSCm/cJZ5uXI
 c227QF0eUOTDWpisRHW+qUNsASaQ59y0ODAuP509td0fw+5K0GqOZWLz+kuS5ZDfkpsq
 O2NYWtc/j2e+XcmfhDLj3iy5tmw2kOzpITh6tiq+Uxkw4I3ZOrxC5vRqv8YlcV+R1stj
 kInw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1716230921; x=1716835721;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=rgMh1b8jfQDDpXmKRMIWnzZOWOSSOQzEU2PxVTUo8MI=;
 b=LofBv8X7nFUNO1tTIh+o/RN+QaObRhNLeKaF4QftF54DvxZuEy7no+rKq/uZnKakq6
 rIiyGISQXdJRLQSjk5b0xWWoUnSpfJU5EpS8cCbca58eyRbKRM8WuWllnxpqVBzYyDp/
 7Y09rs110ma7YuemhvFnlSVDYkHLaniXOsi9nVguzIcdy9JF2VMQe4qMgRXC/FWeR+US
 9Pr9IGgS/xVQ8H9fgwWloNZr6QR6avQ5+HsRDEuLdl6uXF77EzeFdBbRS7tSD3gnSzXD
 zOYzkvKOCpd59z0FivyTbjvxvZmdfqMzmxnth3CxvglqRjRjUq4vZKQ6XJ3U0YQQx+yB
 obpg==
X-Gm-Message-State: AOJu0YyYvtWQPiXmhM40Rada8w+W3IUA3bYOndSoCZirw1xY2w2j2u7w
 ME7V2pJf3vcdcGkGxUaOIAd8ULmeeBccdhaTIbLtxih4gZHNP/HTPD42Tc4AIP0=
X-Google-Smtp-Source: AGHT+IElPGlsaxP7YEIPIcSeUO/IesU7m/LmVIEGelSmAsNKXqbZc6skrq2w7bqzv0zT3ZTHg8xOeQ==
X-Received: by 2002:a05:6a20:9f9a:b0:1af:fbab:cfaf with SMTP id
 adf61e73a8af0-1affbabd262mr18120316637.62.1716230920727; 
 Mon, 20 May 2024 11:48:40 -0700 (PDT)
Received: from [10.12.0.91] (108-78-254-250.lightspeed.sntcca.sbcglobal.net.
 [108.78.254.250]) by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-65cfed58446sm5780730a12.74.2024.05.20.11.48.39
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 20 May 2024 11:48:40 -0700 (PDT)
Message-ID: <8e1b7975-85f8-48f6-8c4a-063f465a7f91@mosi.io>
Date: Mon, 20 May 2024 11:48:38 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] physmem: allow debug writes to MMIO regions
To: Peter Maydell <peter.maydell@linaro.org>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Cc: qemu-devel@nongnu.org, pbonzini@redhat.com, peterx@redhat.com,
 david@redhat.com, Andreas Rasmusson <andreas.rasmusson@gmail.com>
References: <20240513233305.2975295-1-perry@mosi.io>
 <42e47d17-1d49-43e8-abd6-76abdcb159dc@linaro.org>
 <CAFEAcA9t9t7R9FR9mwEssT8+7XVcaBdThetZawB+VmL+0OcxDg@mail.gmail.com>
Content-Language: en-US
From: Perry Hung <perry@mosi.io>
In-Reply-To: <CAFEAcA9t9t7R9FR9mwEssT8+7XVcaBdThetZawB+VmL+0OcxDg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: none client-ip=2607:f8b0:4864:20::633;
 envelope-from=perry@mosi.io; helo=mail-pl1-x633.google.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_NONE=0.001 autolearn=ham autolearn_force=no
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

Philippe, Peter,

Thank you for the comments. I am not even sure what the semantics of 
putting a breakpoint or watchpoint
on device regions are supposed to be. I would imagine it is 
architecture-specific as to whether this is even allowed.

It appears for example, that armv8-a allows watchpoints to be set on any 
type of memory. armv7-a prohibits
watchpoints on Device or Strongly-ordered memory that might be accessed 
by instructions multiple times
(e.g LDM and LDC instructions).

What is the current behavior for QEMU and what should 
breakpoints/watchpoints do when placed on IO memory?

-perry

On 5/20/24 10:22 AM, Peter Maydell wrote:
> On Wed, 15 May 2024 at 13:49, Philippe Mathieu-Daudé <philmd@linaro.org> wrote:
>> Hi Perry,
>>
>> On 14/5/24 01:33, Perry Hung wrote:
>>> Writes from GDB to memory-mapped IO regions are currently silently
>>> dropped. cpu_memory_rw_debug() calls address_space_write_rom(), which
>>> calls address_space_write_rom_internal(), which ignores all non-ram/rom
>>> regions.
>>>
>>> Add a check for MMIO regions and direct those to address_space_rw()
>>> instead.
>>>
>> Reported-by: Andreas Rasmusson <andreas.rasmusson@gmail.com>
>> BugLink: https://bugs.launchpad.net/qemu/+bug/1625216
>>
>>> Resolves: https://gitlab.com/qemu-project/qemu/-/issues/213
>>> Signed-off-by: Perry Hung <perry@mosi.io>
>>> ---
>>>    system/physmem.c | 5 ++++-
>>>    1 file changed, 4 insertions(+), 1 deletion(-)
>>>
>>> diff --git a/system/physmem.c b/system/physmem.c
>>> index 342b7a8fd4..013cdd2ab1 100644
>>> --- a/system/physmem.c
>>> +++ b/system/physmem.c
>>> @@ -3508,7 +3508,10 @@ int cpu_memory_rw_debug(CPUState *cpu, vaddr addr,
>>>            if (l > len)
>>>                l = len;
>>>            phys_addr += (addr & ~TARGET_PAGE_MASK);
>>> -        if (is_write) {
>>> +        if (cpu_physical_memory_is_io(phys_addr)) {
>>> +            res = address_space_rw(cpu->cpu_ases[asidx].as, phys_addr, attrs,
>>> +                                   buf, l, is_write);
>>> +        } else if (is_write) {
>>>                res = address_space_write_rom(cpu->cpu_ases[asidx].as, phys_addr,
>>>                                              attrs, buf, l);
>>>            } else {
> The other option is to make address_space_write_rom_internal()
> also write to devices...
>
>> I wonder if we shouldn't be safer with a preliminary patch
>> adding a 'can_do_io' boolean argument to cpu_memory_rw_debug()
>> (updating the call sites), then this patch would become:
>>
>>       if (can_do_io && cpu_physical_memory_is_io(phys_addr)) {
>>
>> One of my worries for example is if someone accidently insert
>> a breakpoint at a I/O address, the device might change its
>> state and return MEMTX_OK which is confusing.
> You can definitely do some silly things if we remove this
> restriction.
>
> On the other hand if you're using gdb as a debugger on real
> (bare metal) hardware does anything stop you doing that?
>
> -- PMM

