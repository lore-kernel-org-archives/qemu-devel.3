Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CA219C48BF6
	for <qemu-devel@archiver.kernel.org>; Sat, 24 Feb 2024 13:05:48 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rdriC-0003LW-IZ; Sat, 24 Feb 2024 08:05:04 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <balaton@eik.bme.hu>)
 id 1rdri6-0003Kr-S2
 for qemu-devel@nongnu.org; Sat, 24 Feb 2024 08:05:00 -0500
Received: from zero.eik.bme.hu ([2001:738:2001:2001::2001])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <balaton@eik.bme.hu>)
 id 1rdri4-0001mg-DN
 for qemu-devel@nongnu.org; Sat, 24 Feb 2024 08:04:58 -0500
Received: from zero.eik.bme.hu (localhost [127.0.0.1])
 by zero.eik.bme.hu (Postfix) with ESMTP id F3B684E601F;
 Sat, 24 Feb 2024 14:04:51 +0100 (CET)
X-Virus-Scanned: amavisd-new at eik.bme.hu
Received: from zero.eik.bme.hu ([127.0.0.1])
 by zero.eik.bme.hu (zero.eik.bme.hu [127.0.0.1]) (amavisd-new, port 10028)
 with ESMTP id syBneFUbw43W; Sat, 24 Feb 2024 14:04:50 +0100 (CET)
Received: by zero.eik.bme.hu (Postfix, from userid 432)
 id 0C8684E601E; Sat, 24 Feb 2024 14:04:50 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
 by zero.eik.bme.hu (Postfix) with ESMTP id 0B2B07456B4;
 Sat, 24 Feb 2024 14:04:50 +0100 (CET)
Date: Sat, 24 Feb 2024 14:04:50 +0100 (CET)
From: BALATON Zoltan <balaton@eik.bme.hu>
To: Akihiko Odaki <akihiko.odaki@daynix.com>
cc: Peter Maydell <peter.maydell@linaro.org>, 
 =?ISO-8859-15?Q?Philippe_Mathieu-Daud=E9?= <philmd@linaro.org>, 
 Gerd Hoffmann <kraxel@redhat.com>, 
 =?ISO-8859-15?Q?Marc-Andr=E9_Lureau?= <marcandre.lureau@redhat.com>, 
 Marek Glogowski <smarkusg@gmail.com>, Rene Engel <ReneEngel80@emailn.de>, 
 qemu-devel@nongnu.org
Subject: Re: [PATCH v11 6/6] ui/cocoa: Remove stretch_video flag
In-Reply-To: <d65d0dea-b76b-4a22-9d71-e60965c5c868@daynix.com>
Message-ID: <de8318b1-28d0-e581-b308-5d695e52956d@eik.bme.hu>
References: <20240217-cocoa-v11-0-0a17a7e534d4@daynix.com>
 <20240217-cocoa-v11-6-0a17a7e534d4@daynix.com>
 <CAFEAcA_QUMsOXbwOSAEZu5Qkc+G85DfchunxQQbEhRAEBv+Xqw@mail.gmail.com>
 <d65d0dea-b76b-4a22-9d71-e60965c5c868@daynix.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII; format=flowed
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

On Sat, 24 Feb 2024, Akihiko Odaki wrote:
> On 2024/02/23 1:53, Peter Maydell wrote:
>> On Sat, 17 Feb 2024 at 11:19, Akihiko Odaki <akihiko.odaki@daynix.com> 
>> wrote:
>>> 
>>> Evaluate [normalWindow styleMask] & NSWindowStyleMaskResizable instead.
>>> 
>>> Signed-off-by: Akihiko Odaki <akihiko.odaki@daynix.com>
>>> ---
>>>   ui/cocoa.m | 11 ++++-------
>>>   1 file changed, 4 insertions(+), 7 deletions(-)
>>> 
>>> diff --git a/ui/cocoa.m b/ui/cocoa.m
>>> index 81de8d92669b..401ed0c3f1f5 100644
>>> --- a/ui/cocoa.m
>>> +++ b/ui/cocoa.m
>>> @@ -103,7 +103,6 @@ static void cocoa_switch(DisplayChangeListener *dcl,
>>>   static int left_command_key_enabled = 1;
>>>   static bool swap_opt_cmd;
>>> 
>>> -static bool stretch_video;
>>>   static NSTextField *pauseLabel;
>>>
>>>   static bool allow_events;
>>> @@ -533,7 +532,7 @@ - (void) resizeWindow
>>>   {
>>>       [[self window] setContentAspectRatio:NSMakeSize(screen.width, 
>>> screen.height)];
>>> 
>>> -    if (!stretch_video) {
>>> +    if (!([[self window] styleMask] & NSWindowStyleMaskResizable)) {
>>>           [[self window] setContentSize:NSMakeSize(screen.width, 
>>> screen.height)];
>>>           [[self window] center];
>>>       } else if ([[self window] styleMask] & NSWindowStyleMaskFullScreen) 
>>> {
>>> @@ -1296,7 +1295,7 @@ - (BOOL)windowShouldClose:(id)sender
>>>
>>>   - (NSSize) window:(NSWindow *)window 
>>> willUseFullScreenContentSize:(NSSize)proposedSize
>>>   {
>>> -    if (stretch_video) {
>>> +    if ([normalWindow styleMask] & NSWindowStyleMaskResizable) {
>>>           return [cocoaView fixZoomedFullScreenSize:proposedSize];
>>>       }
>>> 
>>> @@ -1377,8 +1376,7 @@ - (void)showQEMUDoc:(id)sender
>>>   /* Stretches video to fit host monitor size */
>>>   - (void)zoomToFit:(id) sender
>>>   {
>>> -    stretch_video = !stretch_video;
>>> -    if (stretch_video == true) {
>>> +    if (([normalWindow styleMask] & NSWindowStyleMaskResizable) == 0) {
>>>           [normalWindow setStyleMask:[normalWindow styleMask] | 
>>> NSWindowStyleMaskResizable];
>>>           [sender setState: NSControlStateValueOn];
>>>       } else {
>>> @@ -1650,7 +1648,7 @@ static void create_initial_menus(void)
>>>       menu = [[NSMenu alloc] initWithTitle:@"View"];
>>>       [menu addItem: [[[NSMenuItem alloc] initWithTitle:@"Enter 
>>> Fullscreen" action:@selector(doToggleFullScreen:) keyEquivalent:@"f"] 
>>> autorelease]]; // Fullscreen
>>>       menuItem = [[[NSMenuItem alloc] initWithTitle:@"Zoom To Fit" 
>>> action:@selector(zoomToFit:) keyEquivalent:@""] autorelease];
>>> -    [menuItem setState: stretch_video ? NSControlStateValueOn : 
>>> NSControlStateValueOff];
>>> +    [menuItem setState: [normalWindow styleMask] & 
>>> NSWindowStyleMaskResizable ? NSControlStateValueOn : 
>>> NSControlStateValueOff];
>>>       [menu addItem: menuItem];
>>>       menuItem = [[[NSMenuItem alloc] initWithTitle:@"View" action:nil 
>>> keyEquivalent:@""] autorelease];
>>>       [menuItem setSubmenu:menu];
>>> @@ -2036,7 +2034,6 @@ static void cocoa_display_init(DisplayState *ds, 
>>> DisplayOptions *opts)
>>>       }
>>>
>>>       if (opts->u.cocoa.has_zoom_to_fit && opts->u.cocoa.zoom_to_fit) {
>>> -        stretch_video = true;
>>>           [normalWindow setStyleMask:[normalWindow styleMask] | 
>>> NSWindowStyleMaskResizable];
>>>       }
>> 
>> It's nice to get rid of the boolean, but
>>   [normalWindow styleMask] & NSWindowStyleMaskResizable
>> feels a bit clunky -- maybe we should wrap it in a method with
>> a suitable name ? (isZoomToFit, maybe? but I'm not too familiar
>> with what cocoa function naming style is.)
>
> I don't think we should have a method for this. It's verbose but the main 
> reason of that is NSWindowStyleMaskResizable is wordy; otherwise it's quite a 
> simple. There are few places that use this construct after all.

If not a method how about a macro just to make it less long? But if Peter 
is otherwise happy with the current version just this does not need 
another version IMO.

Regards,
BALATON Zoltan

