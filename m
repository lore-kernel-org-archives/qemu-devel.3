Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C8F18C5478C
	for <qemu-devel@archiver.kernel.org>; Fri, 23 Feb 2024 19:12:56 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rdaxd-0006Jc-AE; Fri, 23 Feb 2024 14:11:53 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <balaton@eik.bme.hu>)
 id 1rdaJ3-0003Vp-Po; Fri, 23 Feb 2024 13:29:57 -0500
Received: from zero.eik.bme.hu ([2001:738:2001:2001::2001])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <balaton@eik.bme.hu>)
 id 1rdaJ0-0003IW-U6; Fri, 23 Feb 2024 13:29:57 -0500
Received: from zero.eik.bme.hu (localhost [127.0.0.1])
 by zero.eik.bme.hu (Postfix) with ESMTP id 137554E6004;
 Fri, 23 Feb 2024 19:29:50 +0100 (CET)
X-Virus-Scanned: amavisd-new at eik.bme.hu
Received: from zero.eik.bme.hu ([127.0.0.1])
 by zero.eik.bme.hu (zero.eik.bme.hu [127.0.0.1]) (amavisd-new, port 10028)
 with ESMTP id 6dhJnxTjsXcP; Fri, 23 Feb 2024 19:29:47 +0100 (CET)
Received: by zero.eik.bme.hu (Postfix, from userid 432)
 id BB6624E6003; Fri, 23 Feb 2024 19:29:47 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
 by zero.eik.bme.hu (Postfix) with ESMTP id B97557456FE;
 Fri, 23 Feb 2024 19:29:47 +0100 (CET)
Date: Fri, 23 Feb 2024 19:29:47 +0100 (CET)
From: BALATON Zoltan <balaton@eik.bme.hu>
To: David Parsons <dave@daveparsons.net>
cc: Akihiko Odaki <akihiko.odaki@daynix.com>, 
 Peter Maydell <peter.maydell@linaro.org>, Michael Tokarev <mjt@tls.msk.ru>, 
 qemu-devel@nongnu.org, qemu-trivial@nongnu.org, 
 =?ISO-8859-15?Q?Philippe_Mathieu-Daud=E9?= <philmd@linaro.org>, 
 Gerd Hoffmann <kraxel@redhat.com>, 
 =?ISO-8859-15?Q?Marc-Andr=E9_Lureau?= <marcandre.lureau@redhat.com>
Subject: Re: [PATCH] ui/cocoa: Fix incorrect window clipping on macOS
 Sonoma
In-Reply-To: <E5C37F0E-3B73-45FA-8FC7-5E39CBF765BF@daveparsons.net>
Message-ID: <3c915fba-f332-f0f1-056a-8d8a454b6383@eik.bme.hu>
References: <DDADA9A9-DED4-4510-A532-7600C0233467@daveparsons.net>
 <fdda385d-2e18-4554-88d0-e43cb5b90e39@tls.msk.ru>
 <CAFEAcA9psJuvPz+mWYzWz0NLTcQTCNhknFrGZ2bx7Frtb3=B4A@mail.gmail.com>
 <c018e266-0092-4d9e-ba2f-397cb0a1518e@daynix.com>
 <E5C37F0E-3B73-45FA-8FC7-5E39CBF765BF@daveparsons.net>
MIME-Version: 1.0
Content-Type: multipart/mixed;
 boundary="3866299591-458185346-1708712987=:13514"
Received-SPF: pass client-ip=2001:738:2001:2001::2001;
 envelope-from=balaton@eik.bme.hu; helo=zero.eik.bme.hu
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001, T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

--3866299591-458185346-1708712987=:13514
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8BIT

On Fri, 23 Feb 2024, David Parsons wrote:
> Hi Akihiko
>
> I’ve re-worked the patch to match your suggestion. I have compiled
> and tested it on Sonoma and Monterey and both builds worked correctly.
>
> New patch is below. I’m new to sending patches to QEMU so please let
> me know if I need to do anything else to get it incorporated into the
> repo.

See here for detailed docs:
https://www.qemu.org/docs/master/devel/submitting-a-patch.html

In short you'd need to make the patch the same way you did the first 
version with the changed content but as [PATCH v2] and send it again as a 
new patch like you did the first time. (You can use -v2 option to git 
format-patch to add v2 to subject but if you're not using git format-patch 
directly then I'm not sure what option will do that for the way you send 
the patch.)

Regards,
BALATON Zoltan

> Dave
>
> diff --git a/ui/cocoa.m b/ui/cocoa.m
> index eb99064bee..bbf9704b8c 100644
> --- a/ui/cocoa.m
> +++ b/ui/cocoa.m
> @@ -54,6 +54,10 @@
> #define MAC_OS_X_VERSION_10_13 101300
> #endif
>
> +#ifndef MAC_OS_VERSION_14_0
> +#define MAC_OS_VERSION_14_0 140000
> +#endif
> +
> /* 10.14 deprecates NSOnState and NSOffState in favor of
>  * NSControlStateValueOn/Off, which were introduced in 10.13.
>  * Define for older versions
> @@ -365,6 +369,9 @@ - (id)initWithFrame:(NSRect)frameRect
>         screen.width = frameRect.size.width;
>         screen.height = frameRect.size.height;
>         kbd = qkbd_state_init(dcl.con);
> +#if MAC_OS_X_VERSION_MAX_ALLOWED >= MAC_OS_VERSION_14_0
> +        [self setClipsToBounds:YES];
> +#endif
>
>     }
>     return self;
>
>
>> On 23 Feb 2024, at 11:28, Akihiko Odaki <akihiko.odaki@daynix.com> wrote:
>>
>> On 2024/02/23 2:10, Peter Maydell wrote:
>>> On Thu, 22 Feb 2024 at 06:08, Michael Tokarev <mjt@tls.msk.ru> wrote:
>>>>
>>>> [Adding a few more Ccs]
>>>>
>>>> 17.02.2024 18:58, David Parsons :
>>>>> macOS Sonoma changes the NSView.clipsToBounds to false by default where it was true in
>>>>> earlier version of macOS. This causes the window contents to be obscured by the window
>>>>> frame. This fixes the issue by conditionally setting the clipping on Sonoma to true.
>>
>> Thanks for posting a patch for this critical problem.
>>
>>>>>
>>>>> Resolves: https://gitlab.com/qemu-project/qemu/-/issues/1994
>>>>> Signed-off-by: David Parsons <dave@daveparsons.net>
>>>>>
>>>>> diff --git a/ui/cocoa.m b/ui/cocoa.m
>>>>> index eb99064bee..c9e3b96004 100644
>>>>> --- a/ui/cocoa.m
>>>>> +++ b/ui/cocoa.m
>>>>> @@ -365,6 +365,9 @@ - (id)initWithFrame:(NSRect)frameRect
>>>>>           screen.width = frameRect.size.width;
>>>>>           screen.height = frameRect.size.height;
>>>>>           kbd = qkbd_state_init(dcl.con);
>>>>> +        if (@available(macOS 14, *)) {
>>>>> +            [self setClipsToBounds:YES];
>>>>> +        }
>>>>>
>>>>>       }
>>>>>       return self;
>>>>>
>>>>
>>>> Hi David!
>>>>
>>>> While the code change is tiny, I for one know nothing about MacOS and
>>>> its cocoa thing, so to me (with my trivial-patches hat on) this is a
>>>> no-go.  I'd love to have a review from someone more knowlegeable in
>>>> this area.
>>> Mmm. Akihiko is the expert here, but I do notice that we don't
>>> seem to be handling the "macos-version-specific" stuff in a
>>> way we've done it before (we don't use @available elsewhere).
>>> I did wonder if we could call the setClipsToBounds method unconditionally;
>>> The release notes say
>>> https://developer.apple.com/documentation/macos-release-notes/appkit-release-notes-for-macos-14#NSView
>>> "This property is available back to macOS 10.9. This availability is
>>> intended to allow code targeting older OSes to set this property to
>>> true without guarding the setter in an availability check."
>>> but I think that might only mean "you can do this building on a new
>>> SDK that's targeting an old version", not "you can do this
>>> when building on an older SDK" (at least judging from the
>>> comments in the gitlab issue).
>>
>> Apparently it is that case.
>>
>> Please check if MAC_OS_X_VERSION_MAX_ALLOWED >= MAC_OS_VERSION_14_0
>> instead of using @available. See commit 5e24600a7c1c ("ui/cocoa.m: Fix macOS 10.14 deprecation warnings") for example.
>>
>>> The other option would be to fix whatever it is that we're
>>> presumably not getting right that means this default change
>>> caused the bug. My guess is that we are in the case
>>> "Confusing a view’s bounds and its dirty rect. The dirty rect
>>>  passed to .drawRect() should be used to determine what to draw,
>>>  not where to draw it. Use NSView.bounds when determining the
>>>  layout of what your view draws."
>>> But unless the fix for that is really obvious and easy I guess
>>> that flipping the default back to its old value is the better
>>> approach.
>>
>> It is a chore to convert the coordinates using NSView.bounds. Let's keep using clipsToBounds.
>>
>>> -- PMM
>>
>>
>
>
--3866299591-458185346-1708712987=:13514--

