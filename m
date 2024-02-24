Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D4F83C54E49
	for <qemu-devel@archiver.kernel.org>; Sat, 24 Feb 2024 13:00:43 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rdrd2-0000c4-D4; Sat, 24 Feb 2024 07:59:44 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1rdrd1-0000bu-IR
 for qemu-devel@nongnu.org; Sat, 24 Feb 2024 07:59:43 -0500
Received: from mail-pg1-x533.google.com ([2607:f8b0:4864:20::533])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1rdrcz-0000pU-Fw
 for qemu-devel@nongnu.org; Sat, 24 Feb 2024 07:59:43 -0500
Received: by mail-pg1-x533.google.com with SMTP id
 41be03b00d2f7-5dbd519bde6so1139864a12.1
 for <qemu-devel@nongnu.org>; Sat, 24 Feb 2024 04:59:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=daynix-com.20230601.gappssmtp.com; s=20230601; t=1708779580; x=1709384380;
 darn=nongnu.org; 
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=avJOyotMME/6+cL0v/0lmhORRZhfc7rw1aAAbPPirgY=;
 b=QGc1dXZaFAScKMCQuAu8suMNjSCJd80ByHZeYO1k6inOz1KixelCe0HcxuPVVuZcQw
 ofVjEnUFD7CgtQLx4Qz/G87Q+WAtk8bmR68xI0ITLiFqWX1ATqnVOLtYw7vH57o5hmdn
 pNyr9HpGSPnhbJjqx471P0i0hNBL8k1kohpOdt4JMBxvdgu6O34M/kKyn7lMjwZjF5q3
 fdeqEHCo8/UDr+I91Sg0b+5Se4BGJqznMz2m91YAzO89fYmjWGfUvgcdCcX5gwmtF7kL
 zFZuQRwruciYLQTYgO2gvqMmiZPg6rsYC1ZZvF8rgzfJaNFYIACYZ/4tQ6693T4YVsof
 8WGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1708779580; x=1709384380;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=avJOyotMME/6+cL0v/0lmhORRZhfc7rw1aAAbPPirgY=;
 b=f62EUN/Tz8DX8O6b93lgNcJQZDOaHR4qHucHFCEaPaYANwBgHch8+YOyRaaiEZgMnf
 DVBjIB/ZAXVM/9KHvmCWRsPv/5uaKujsath8gMr4SUhDyyodNbCdfSvdvNOw7gsOzTzq
 UY9wgd+Y6bvGELBT5q2y56MRPTSFMeRFDuieO3Iq+WctJPw3JdwjII+1oZK/9AblvCcS
 dXF2mY8nRWBjpHHEsZtokWSqbhX2cvpj3wL8c0msfYVxyGDIsG5a+f9FrnMOtgh7gX46
 ytJ3xRkFij6tKrIDuH56w5MjRk+hYwN5B/m5gby2GjTcMbTNkqi2RFtV/qpz2BWF0bmg
 gwdw==
X-Forwarded-Encrypted: i=1;
 AJvYcCVGzsI7JPOY4koRahyC0ke1Uazp+FcTIEwN1ipoajABpq6Uk4bnwNqSXXttLrumgdv0VgmlKSPOxEUJEA0s3TZXJ+ot3Cg=
X-Gm-Message-State: AOJu0YwZuZuJ3XuIuQI6bEFhP+H9aTGyi5FQRHmz1RxcLWgBO8DlOeO6
 h1oQXIzdhyasSczB0+0TR65FipoQxPcbyOi/FYs4T5oEpcxB0imV0KFQQBvdq+Q=
X-Google-Smtp-Source: AGHT+IGxGHfaETL0l1ouQDA/IbuElpOPCEdz07uk6MYNve398b7QWAfoY/QoAgRmIN/2+PeLDiz3Yg==
X-Received: by 2002:a05:6a20:c896:b0:1a0:dbe3:ce5b with SMTP id
 hb22-20020a056a20c89600b001a0dbe3ce5bmr2439217pzb.20.1708779580035; 
 Sat, 24 Feb 2024 04:59:40 -0800 (PST)
Received: from [157.82.203.206] ([157.82.203.206])
 by smtp.gmail.com with ESMTPSA id
 y6-20020a17090a1f4600b00299a8011e67sm1276833pjy.55.2024.02.24.04.59.38
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sat, 24 Feb 2024 04:59:39 -0800 (PST)
Message-ID: <d65d0dea-b76b-4a22-9d71-e60965c5c868@daynix.com>
Date: Sat, 24 Feb 2024 21:59:36 +0900
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v11 6/6] ui/cocoa: Remove stretch_video flag
Content-Language: en-US
To: Peter Maydell <peter.maydell@linaro.org>
Cc: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Gerd Hoffmann <kraxel@redhat.com>,
 =?UTF-8?Q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>,
 Marek Glogowski <smarkusg@gmail.com>, BALATON Zoltan <balaton@eik.bme.hu>,
 Rene Engel <ReneEngel80@emailn.de>, qemu-devel@nongnu.org
References: <20240217-cocoa-v11-0-0a17a7e534d4@daynix.com>
 <20240217-cocoa-v11-6-0a17a7e534d4@daynix.com>
 <CAFEAcA_QUMsOXbwOSAEZu5Qkc+G85DfchunxQQbEhRAEBv+Xqw@mail.gmail.com>
From: Akihiko Odaki <akihiko.odaki@daynix.com>
In-Reply-To: <CAFEAcA_QUMsOXbwOSAEZu5Qkc+G85DfchunxQQbEhRAEBv+Xqw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: none client-ip=2607:f8b0:4864:20::533;
 envelope-from=akihiko.odaki@daynix.com; helo=mail-pg1-x533.google.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_NONE=0.001, T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

On 2024/02/23 1:53, Peter Maydell wrote:
> On Sat, 17 Feb 2024 at 11:19, Akihiko Odaki <akihiko.odaki@daynix.com> wrote:
>>
>> Evaluate [normalWindow styleMask] & NSWindowStyleMaskResizable instead.
>>
>> Signed-off-by: Akihiko Odaki <akihiko.odaki@daynix.com>
>> ---
>>   ui/cocoa.m | 11 ++++-------
>>   1 file changed, 4 insertions(+), 7 deletions(-)
>>
>> diff --git a/ui/cocoa.m b/ui/cocoa.m
>> index 81de8d92669b..401ed0c3f1f5 100644
>> --- a/ui/cocoa.m
>> +++ b/ui/cocoa.m
>> @@ -103,7 +103,6 @@ static void cocoa_switch(DisplayChangeListener *dcl,
>>   static int left_command_key_enabled = 1;
>>   static bool swap_opt_cmd;
>>
>> -static bool stretch_video;
>>   static NSTextField *pauseLabel;
>>
>>   static bool allow_events;
>> @@ -533,7 +532,7 @@ - (void) resizeWindow
>>   {
>>       [[self window] setContentAspectRatio:NSMakeSize(screen.width, screen.height)];
>>
>> -    if (!stretch_video) {
>> +    if (!([[self window] styleMask] & NSWindowStyleMaskResizable)) {
>>           [[self window] setContentSize:NSMakeSize(screen.width, screen.height)];
>>           [[self window] center];
>>       } else if ([[self window] styleMask] & NSWindowStyleMaskFullScreen) {
>> @@ -1296,7 +1295,7 @@ - (BOOL)windowShouldClose:(id)sender
>>
>>   - (NSSize) window:(NSWindow *)window willUseFullScreenContentSize:(NSSize)proposedSize
>>   {
>> -    if (stretch_video) {
>> +    if ([normalWindow styleMask] & NSWindowStyleMaskResizable) {
>>           return [cocoaView fixZoomedFullScreenSize:proposedSize];
>>       }
>>
>> @@ -1377,8 +1376,7 @@ - (void)showQEMUDoc:(id)sender
>>   /* Stretches video to fit host monitor size */
>>   - (void)zoomToFit:(id) sender
>>   {
>> -    stretch_video = !stretch_video;
>> -    if (stretch_video == true) {
>> +    if (([normalWindow styleMask] & NSWindowStyleMaskResizable) == 0) {
>>           [normalWindow setStyleMask:[normalWindow styleMask] | NSWindowStyleMaskResizable];
>>           [sender setState: NSControlStateValueOn];
>>       } else {
>> @@ -1650,7 +1648,7 @@ static void create_initial_menus(void)
>>       menu = [[NSMenu alloc] initWithTitle:@"View"];
>>       [menu addItem: [[[NSMenuItem alloc] initWithTitle:@"Enter Fullscreen" action:@selector(doToggleFullScreen:) keyEquivalent:@"f"] autorelease]]; // Fullscreen
>>       menuItem = [[[NSMenuItem alloc] initWithTitle:@"Zoom To Fit" action:@selector(zoomToFit:) keyEquivalent:@""] autorelease];
>> -    [menuItem setState: stretch_video ? NSControlStateValueOn : NSControlStateValueOff];
>> +    [menuItem setState: [normalWindow styleMask] & NSWindowStyleMaskResizable ? NSControlStateValueOn : NSControlStateValueOff];
>>       [menu addItem: menuItem];
>>       menuItem = [[[NSMenuItem alloc] initWithTitle:@"View" action:nil keyEquivalent:@""] autorelease];
>>       [menuItem setSubmenu:menu];
>> @@ -2036,7 +2034,6 @@ static void cocoa_display_init(DisplayState *ds, DisplayOptions *opts)
>>       }
>>
>>       if (opts->u.cocoa.has_zoom_to_fit && opts->u.cocoa.zoom_to_fit) {
>> -        stretch_video = true;
>>           [normalWindow setStyleMask:[normalWindow styleMask] | NSWindowStyleMaskResizable];
>>       }
> 
> It's nice to get rid of the boolean, but
>   [normalWindow styleMask] & NSWindowStyleMaskResizable
> feels a bit clunky -- maybe we should wrap it in a method with
> a suitable name ? (isZoomToFit, maybe? but I'm not too familiar
> with what cocoa function naming style is.)

I don't think we should have a method for this. It's verbose but the 
main reason of that is NSWindowStyleMaskResizable is wordy; otherwise 
it's quite a simple. There are few places that use this construct after all.

In any case, I put a bit more effort to simplify style mask references 
with v12 so please check it out.

Regards,
Akihiko Odaki

