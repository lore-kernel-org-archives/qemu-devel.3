Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9A8EBC48BF6
	for <qemu-devel@archiver.kernel.org>; Sat, 24 Feb 2024 12:45:37 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rdrO8-0002CF-9q; Sat, 24 Feb 2024 07:44:20 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1rdrO6-0002C5-Iw
 for qemu-devel@nongnu.org; Sat, 24 Feb 2024 07:44:18 -0500
Received: from mail-pl1-x629.google.com ([2607:f8b0:4864:20::629])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1rdrO5-0006xn-1g
 for qemu-devel@nongnu.org; Sat, 24 Feb 2024 07:44:18 -0500
Received: by mail-pl1-x629.google.com with SMTP id
 d9443c01a7336-1d95d67ff45so11255405ad.2
 for <qemu-devel@nongnu.org>; Sat, 24 Feb 2024 04:44:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=daynix-com.20230601.gappssmtp.com; s=20230601; t=1708778656; x=1709383456;
 darn=nongnu.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=jqtng6eTMtQKGpQNRytiSork9i3+Tz3l9sTU1dsSA4k=;
 b=wTa8W2I8ButUqG8AvFmDCmqCChKKW/imSFNkkQ4bLEzKfrerSQnHY4SI2f6oM8Tdo5
 gVDYfuXUa2wysNgdLnqOOXSzoJFnodLPchfI8wvAbZtemCQtVYwfsbBoCBZIROrVLSok
 2C5cO2s77mqiYgYUU7k1/+LIbVfi8kMyHHO7FhxP+pdHaoZ+p5iburGHTvAC5iiqzDRd
 YVC25g74lRi/olEXSfTXd5+tPv4eMncegUmuX5Kz4pPy3qNA6zdkJyFlg2HKbrQJZaOd
 d6BmRP/VjNwhEfKpz1rz5rt8fdFCfAv/g7TU4ljgsvd4Dcp2WdnjJrPpD/BKqaK1BJ31
 HKaw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1708778656; x=1709383456;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=jqtng6eTMtQKGpQNRytiSork9i3+Tz3l9sTU1dsSA4k=;
 b=MhVh89uXfre93Nn0yaiRNNEYqjnN9XyWDWhlYtWAO+GRTHE1C6NZbzJp3wyyRpAUVg
 eivKKO8jOsBZt5PE6iSeX4EysdE1dnd1IIz4zWE0vMlVSCvcAkOL9fFFPUVOUe/7cPhu
 OFk+HfuH+lU47K6kwKUyZ5kLg87PMmtPmW7IqtqowTA11xPWSCQlOA3ZbFRWCgj5KV+o
 s+DuRJTseJS2s9aDXNNCzjY29/fiGimNYzIvLJhbZEJ3eRx0fbqfQPCIEkSjlDqauqos
 a7MtR2Gu/mpcpKl1LgbSFlYPZXwpLX5pok5+WEOSZyzLqE9PuoNx9AvDmQl5iBY4xgSS
 gXvw==
X-Gm-Message-State: AOJu0YyM3szaRT96RoIuExFWi0XaUGnp9My1ltxDk8CePBMfxQgDzWbE
 npInckYzGqTDRhyVKRWNeLVoaHc3CXyT0vfSAc5KDo8p7MOdXv8vWe5YbQi1wPM=
X-Google-Smtp-Source: AGHT+IF2Ute0k5bWDUygAaUdeqJGFJ8UIkSu+OXUfsDZOGe79DVEk2/usZZpam3DjUrfA3pgvG3W8g==
X-Received: by 2002:a17:902:720c:b0:1db:51ee:8677 with SMTP id
 ba12-20020a170902720c00b001db51ee8677mr2622657plb.59.1708778655889; 
 Sat, 24 Feb 2024 04:44:15 -0800 (PST)
Received: from localhost ([157.82.203.206])
 by smtp.gmail.com with UTF8SMTPSA id
 y18-20020a170902b49200b001d94e6a7685sm953135plr.234.2024.02.24.04.44.13
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sat, 24 Feb 2024 04:44:15 -0800 (PST)
From: Akihiko Odaki <akihiko.odaki@daynix.com>
Date: Sat, 24 Feb 2024 21:43:41 +0900
Subject: [PATCH v12 10/10] ui/cocoa: Remove stretch_video flag
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240224-cocoa-v12-10-e89f70bdda71@daynix.com>
References: <20240224-cocoa-v12-0-e89f70bdda71@daynix.com>
In-Reply-To: <20240224-cocoa-v12-0-e89f70bdda71@daynix.com>
To: Peter Maydell <peter.maydell@linaro.org>, 
 =?utf-8?q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>, 
 Gerd Hoffmann <kraxel@redhat.com>, 
 =?utf-8?q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>, 
 Marek Glogowski <smarkusg@gmail.com>, BALATON Zoltan <balaton@eik.bme.hu>, 
 Rene Engel <ReneEngel80@emailn.de>
Cc: qemu-devel@nongnu.org, Akihiko Odaki <akihiko.odaki@daynix.com>
X-Mailer: b4 0.12.3
Received-SPF: none client-ip=2607:f8b0:4864:20::629;
 envelope-from=akihiko.odaki@daynix.com; helo=mail-pl1-x629.google.com
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

Evaluate [normalWindow styleMask] & NSWindowStyleMaskResizable instead.

Signed-off-by: Akihiko Odaki <akihiko.odaki@daynix.com>
---
 ui/cocoa.m | 19 ++++++-------------
 1 file changed, 6 insertions(+), 13 deletions(-)

diff --git a/ui/cocoa.m b/ui/cocoa.m
index 33d31b82bcab..b33842e70280 100644
--- a/ui/cocoa.m
+++ b/ui/cocoa.m
@@ -102,7 +102,6 @@ static void cocoa_switch(DisplayChangeListener *dcl,
 static int left_command_key_enabled = 1;
 static bool swap_opt_cmd;
 
-static bool stretch_video;
 static NSTextField *pauseLabel;
 
 static bool allow_events;
@@ -514,7 +513,7 @@ - (void) resizeWindow
 {
     [[self window] setContentAspectRatio:NSMakeSize(screen.width, screen.height)];
 
-    if (!stretch_video) {
+    if (!([[self window] styleMask] & NSWindowStyleMaskResizable)) {
         [[self window] setContentSize:NSMakeSize(screen.width, screen.height)];
         [[self window] center];
     } else if ([[self window] styleMask] & NSWindowStyleMaskFullScreen) {
@@ -1346,15 +1345,10 @@ - (void)showQEMUDoc:(id)sender
 /* Stretches video to fit host monitor size */
 - (void)zoomToFit:(id) sender
 {
-    stretch_video = !stretch_video;
-    if (stretch_video == true) {
-        [cocoaView window].styleMask |= NSWindowStyleMaskResizable;
-        [sender setState: NSControlStateValueOn];
-    } else {
-        [cocoaView window].styleMask &= ~NSWindowStyleMaskResizable;
-        [cocoaView resizeWindow];
-        [sender setState: NSControlStateValueOff];
-    }
+    NSWindowStyleMask styleMask = [[cocoaView window] styleMask] ^ NSWindowStyleMaskResizable;
+
+    [[cocoaView window] setStyleMask:styleMask];
+    [sender setState:styleMask & NSWindowStyleMaskResizable ? NSControlStateValueOn : NSControlStateValueOff];
 }
 
 /* Displays the console on the screen */
@@ -1619,7 +1613,7 @@ static void create_initial_menus(void)
     menu = [[NSMenu alloc] initWithTitle:@"View"];
     [menu addItem: [[[NSMenuItem alloc] initWithTitle:@"Enter Fullscreen" action:@selector(doToggleFullScreen:) keyEquivalent:@"f"] autorelease]]; // Fullscreen
     menuItem = [[[NSMenuItem alloc] initWithTitle:@"Zoom To Fit" action:@selector(zoomToFit:) keyEquivalent:@""] autorelease];
-    [menuItem setState: stretch_video ? NSControlStateValueOn : NSControlStateValueOff];
+    [menuItem setState: [[cocoaView window] styleMask] & NSWindowStyleMaskResizable ? NSControlStateValueOn : NSControlStateValueOff];
     [menu addItem: menuItem];
     menuItem = [[[NSMenuItem alloc] initWithTitle:@"View" action:nil keyEquivalent:@""] autorelease];
     [menuItem setSubmenu:menu];
@@ -2005,7 +1999,6 @@ static void cocoa_display_init(DisplayState *ds, DisplayOptions *opts)
     }
 
     if (opts->u.cocoa.has_zoom_to_fit && opts->u.cocoa.zoom_to_fit) {
-        stretch_video = true;
         [cocoaView window].styleMask |= NSWindowStyleMaskResizable;
     }
 

-- 
2.43.2


