Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3CBFBE77180
	for <qemu-devel@archiver.kernel.org>; Thu, 12 Dec 2024 18:56:07 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tLoLz-0007NO-CW; Thu, 12 Dec 2024 13:56:03 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <balaton@eik.bme.hu>)
 id 1tLoLl-0006ju-0K
 for qemu-devel@nongnu.org; Thu, 12 Dec 2024 13:55:51 -0500
Received: from zero.eik.bme.hu ([2001:738:2001:2001::2001])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <balaton@eik.bme.hu>)
 id 1tLoLf-0006po-0O
 for qemu-devel@nongnu.org; Thu, 12 Dec 2024 13:55:48 -0500
Received: from zero.eik.bme.hu (localhost [127.0.0.1])
 by zero.eik.bme.hu (Postfix) with ESMTP id C120C4E60F7;
 Thu, 12 Dec 2024 19:55:39 +0100 (CET)
X-Virus-Scanned: amavisd-new at eik.bme.hu
Received: from zero.eik.bme.hu ([127.0.0.1])
 by zero.eik.bme.hu (zero.eik.bme.hu [127.0.0.1]) (amavisd-new, port 10028)
 with ESMTP id AODKhdqjZVS1; Thu, 12 Dec 2024 19:55:37 +0100 (CET)
Received: by zero.eik.bme.hu (Postfix, from userid 432)
 id CC69C4E60F5; Thu, 12 Dec 2024 19:55:37 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
 by zero.eik.bme.hu (Postfix) with ESMTP id CA14B746F60;
 Thu, 12 Dec 2024 19:55:37 +0100 (CET)
Date: Thu, 12 Dec 2024 19:55:37 +0100 (CET)
From: BALATON Zoltan <balaton@eik.bme.hu>
To: =?ISO-8859-15?Q?Philippe_Mathieu-Daud=E9?= <philmd@linaro.org>
cc: qemu-devel@nongnu.org, 
 =?ISO-8859-15?Q?Marc-Andr=E9_Lureau?= <marcandre.lureau@redhat.com>, 
 Pankaj Gupta <pankaj.gupta.linux@gmail.com>, 
 Wei Yang <richardw.yang@linux.intel.com>, 
 Paolo Bonzini <pbonzini@redhat.com>, 
 Haozhong Zhang <haozhong.zhang@intel.com>
Subject: Re: [PATCH 2/2] system: Restrict libpmem and libdaxctl CPPFLAGS to
 physmem.c
In-Reply-To: <684c89b4-a898-484f-aff9-92b46bc78c04@linaro.org>
Message-ID: <1a36f9f9-3783-9d40-7e85-b0ff290e3857@eik.bme.hu>
References: <20241212092632.18538-1-philmd@linaro.org>
 <20241212092632.18538-3-philmd@linaro.org>
 <5c323271-8563-342f-35d1-6f9575265f72@eik.bme.hu>
 <684c89b4-a898-484f-aff9-92b46bc78c04@linaro.org>
MIME-Version: 1.0
Content-Type: multipart/mixed;
 boundary="3866299591-558334730-1734029737=:55625"
Received-SPF: pass client-ip=2001:738:2001:2001::2001;
 envelope-from=balaton@eik.bme.hu; helo=zero.eik.bme.hu
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, SPF_HELO_NONE=0.001,
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

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--3866299591-558334730-1734029737=:55625
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8BIT

On Thu, 12 Dec 2024, Philippe Mathieu-Daudé wrote:
> On 12/12/24 14:11, BALATON Zoltan wrote:
>> On Thu, 12 Dec 2024, Philippe Mathieu-Daudé wrote:
>>> Only physmem.c includes libpmem and libdaxctl headers.
>>> No need to pass them to all system_ss[] files.
>> 
>> I think doing this patch first would leave the other one unnecessary so 
>
> This one is about libpmem / libdaxctl in physmem.c,
> the previous one is about libsdl in vl.c. I'm missing
> what inverting the order would change.

It seems odd to add the libpmem, libdaxctl libs to one set in the first 
patch then remove it right away in the next patch. Swapping patches would 
avoid that and move these to the final place without churn then the sdl 
change is simpler.

> Besides in 2 patches it is simpler to check what CPPFLAGS are applied.
>
> Anyhow if you insist, I can squash. I don't care much as long as
> we reduce the flags applied to system_ss[].

I don't insist and don't mind much either but I see others also suggested 
squashing patches so this will be resolved by that.

Regards,
BALATON Zoltan

>> you could do both in one patch with less churn and maybe reduce this series 
>> to a single patch.
>> 
>> Regards,
>> BALATON Zoltan
>> 
>>> Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
>>> ---
>>> system/meson.build | 7 +++++--
>>> 1 file changed, 5 insertions(+), 2 deletions(-)
>>> 
>>> diff --git a/system/meson.build b/system/meson.build
>>> index f7e2c8b826f..50d915bd80c 100644
>>> --- a/system/meson.build
>>> +++ b/system/meson.build
>>> @@ -2,10 +2,13 @@ specific_ss.add(when: 'CONFIG_SYSTEM_ONLY', if_true: 
>>> [files(
>>>   'arch_init.c',
>>>   'ioport.c',
>>>   'memory.c',
>>> -  'physmem.c',
>>>   'watchpoint.c',
>>> )])
>>> 
>>> +specific_ss.add(when: 'CONFIG_SYSTEM_ONLY', if_true: [files(
>>> +  'physmem.c',
>>> +), libpmem, libdaxctl])
>>> +
>>> system_ss.add(files(
>>>   'balloon.c',
>>>   'bootdevice.c',
>>> @@ -23,7 +26,7 @@ system_ss.add(files(
>>>   'runstate-hmp-cmds.c',
>>>   'runstate.c',
>>>   'tpm-hmp-cmds.c',
>>> -), libpmem, libdaxctl)
>>> +))
>>> 
>>> system_ss.add(files(
>>>   'vl.c',
>>> 
>
>
--3866299591-558334730-1734029737=:55625--

