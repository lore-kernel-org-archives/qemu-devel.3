Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CCB2FC4829A
	for <qemu-devel@archiver.kernel.org>; Wed, 14 Feb 2024 04:33:00 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ra6ww-0002VY-Dw; Tue, 13 Feb 2024 23:32:49 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1ra6wu-0002SC-Jp
 for qemu-devel@nongnu.org; Tue, 13 Feb 2024 23:32:44 -0500
Received: from mail-pl1-x62b.google.com ([2607:f8b0:4864:20::62b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1ra6wt-0006Dj-42
 for qemu-devel@nongnu.org; Tue, 13 Feb 2024 23:32:44 -0500
Received: by mail-pl1-x62b.google.com with SMTP id
 d9443c01a7336-1db562438e0so2892375ad.3
 for <qemu-devel@nongnu.org>; Tue, 13 Feb 2024 20:32:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=daynix-com.20230601.gappssmtp.com; s=20230601; t=1707885162; x=1708489962;
 darn=nongnu.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=UAkgWf/eVOSYqx05p8SSBnT0prb7qhT56AlPFl+HP5E=;
 b=uIFrcRnBgQdU3PLp+AgO3HJVYpN1M73SrrV6ddjLEiTK8hVSigCOgSoXdXPaOEPbPh
 N+0ZJOah3S0SfEh8p/S8sCztUZ4P59C1YEDYt9MNtsINCO0h9oWjRHi6sPBLvMM05rbm
 MVgGGmaMpCWofdAnWionn9Z9LxsWLZ0alSfxJfuSiTUX1UkB1prTV0SDpU8yxYIMxM38
 l8W0VEe1XyPnf7pzNhwGAGoAawB0qctWxDbUao0vXQNIGutRju6S069aTgAhex72CUNe
 p/gj1ddeFiL0S/DGmWN/tFlmlxQp9lrwSI0sOQDQVdc6WFIsxwEeD9nq6uDriTpQxjJ4
 eVfw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1707885162; x=1708489962;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=UAkgWf/eVOSYqx05p8SSBnT0prb7qhT56AlPFl+HP5E=;
 b=TIzI2Ru9hZlzx9KJTjCvnNLn5TXygxKsj0gW0rT1n8L+c6wDxJ94tTDeJt2g3xFW76
 i3ns3mcGiIyy3e445GWhfuQbiR4YuZmuI0pNJC20x3YenT3IJHtQ9CH9/dnOX3chee/U
 93qPbh5/DtCVKl3N0qvNAftxnGZGDt0h+lXuQOUH0ei3UUrgE1KzQMsVU4XxP+AKiNRT
 hy9bZj7w1ZDtu9sbrQYaRVKZw8YuSV4AbB6SJ19AUhuZe3VVWHpGMJEsijuJ/4VdHE6e
 NEPjFNsAgGgOoxLUzgi6nFkQPFsWzxQgymD/82VYF8B1rszJc2sdpeITkViP1MiDBev5
 zYQw==
X-Gm-Message-State: AOJu0YxYHiRAp2TvGrUsGAA3CfhoEYqUDey5rUeS6rCESdnlW/9vDXEX
 2LEPZPSdo6BB9ECMd8ClNk1rv5fN9WHO5Xbcd9v4vmgqg/4IBQKd4ZbJPwd/uKg=
X-Google-Smtp-Source: AGHT+IFzN09qvkWQ0Vecodybx2TkKMWaTxBDpIOYoQPOBgFfN5ztyB+bgccq65GXVnHY17MaBbRXGw==
X-Received: by 2002:a17:903:1246:b0:1db:33bb:1757 with SMTP id
 u6-20020a170903124600b001db33bb1757mr1675408plh.57.1707885161949; 
 Tue, 13 Feb 2024 20:32:41 -0800 (PST)
X-Forwarded-Encrypted: i=1;
 AJvYcCXBKKT0H/bPuudypMdFR7c4AHMg4qtUe9bSLb33mlaJJTUj0PpkVXqKGwEqTbRehA7yccJJMJMsIdf8UtjBWZKB2FZDwjYgG/0xtZF7WqyS5Pppt52a8Xv5/UnpX+O2NNxKcn2V7mzUUcDgn4NwfYKbIL0eO6b0lIOTvd7sk7/RF5OUzuE7tcDzmFRt2NDyV9cYBFuyuk5i+sZ82cVu/5d/i5UENFUb1XMLD6AlreM/Ll9pyMt7ki5aWRnBMih2ZlAwKlrR9oxq50e1
Received: from localhost ([2400:4050:a840:1e00:9ac7:6d57:2b16:6932])
 by smtp.gmail.com with UTF8SMTPSA id
 12-20020a170902e9cc00b001d8dbb867b1sm2822005plk.179.2024.02.13.20.32.39
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 13 Feb 2024 20:32:41 -0800 (PST)
From: Akihiko Odaki <akihiko.odaki@daynix.com>
Date: Wed, 14 Feb 2024 13:32:06 +0900
Subject: [PATCH v10 6/6] ui/cocoa: Remove stretch_video flag
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240214-cocoa-v10-6-c7ffe5d9f08a@daynix.com>
References: <20240214-cocoa-v10-0-c7ffe5d9f08a@daynix.com>
In-Reply-To: <20240214-cocoa-v10-0-c7ffe5d9f08a@daynix.com>
To: Peter Maydell <peter.maydell@linaro.org>, 
 =?utf-8?q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>, 
 Gerd Hoffmann <kraxel@redhat.com>, 
 =?utf-8?q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>, 
 Marek Glogowski <smarkusg@gmail.com>, BALATON Zoltan <balaton@eik.bme.hu>, 
 Rene Engel <ReneEngel80@emailn.de>
Cc: qemu-devel@nongnu.org, Akihiko Odaki <akihiko.odaki@daynix.com>
X-Mailer: b4 0.12.3
Received-SPF: none client-ip=2607:f8b0:4864:20::62b;
 envelope-from=akihiko.odaki@daynix.com; helo=mail-pl1-x62b.google.com
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
 ui/cocoa.m | 11 ++++-------
 1 file changed, 4 insertions(+), 7 deletions(-)

diff --git a/ui/cocoa.m b/ui/cocoa.m
index aeec3c48859c..0ed40cd97d28 100644
--- a/ui/cocoa.m
+++ b/ui/cocoa.m
@@ -103,7 +103,6 @@ static void cocoa_switch(DisplayChangeListener *dcl,
 static int left_command_key_enabled = 1;
 static bool swap_opt_cmd;
 
-static bool stretch_video;
 static NSTextField *pauseLabel;
 
 static bool allow_events;
@@ -533,7 +532,7 @@ - (void) resizeWindow
 {
     [[self window] setContentAspectRatio:NSMakeSize(screen.width, screen.height)];
 
-    if (!stretch_video) {
+    if (!([[self window] styleMask] & NSWindowStyleMaskResizable)) {
         [[self window] setContentSize:NSMakeSize(screen.width, screen.height)];
         [[self window] center];
     } else if ([[self window] styleMask] & NSWindowStyleMaskFullScreen) {
@@ -1295,7 +1294,7 @@ - (BOOL)windowShouldClose:(id)sender
 
 - (NSSize) window:(NSWindow *)window willUseFullScreenContentSize:(NSSize)proposedSize
 {
-    if (stretch_video) {
+    if ([normalWindow styleMask] & NSWindowStyleMaskResizable) {
         return [cocoaView fixZoomedFullScreenSize:proposedSize];
     }
 
@@ -1376,8 +1375,7 @@ - (void)showQEMUDoc:(id)sender
 /* Stretches video to fit host monitor size */
 - (void)zoomToFit:(id) sender
 {
-    stretch_video = !stretch_video;
-    if (stretch_video == true) {
+    if (([normalWindow styleMask] & NSWindowStyleMaskResizable) == 0) {
         [normalWindow setStyleMask:[normalWindow styleMask] | NSWindowStyleMaskResizable];
         [sender setState: NSControlStateValueOn];
     } else {
@@ -1649,7 +1647,7 @@ static void create_initial_menus(void)
     menu = [[NSMenu alloc] initWithTitle:@"View"];
     [menu addItem: [[[NSMenuItem alloc] initWithTitle:@"Enter Fullscreen" action:@selector(doToggleFullScreen:) keyEquivalent:@"f"] autorelease]]; // Fullscreen
     menuItem = [[[NSMenuItem alloc] initWithTitle:@"Zoom To Fit" action:@selector(zoomToFit:) keyEquivalent:@""] autorelease];
-    [menuItem setState: stretch_video ? NSControlStateValueOn : NSControlStateValueOff];
+    [menuItem setState: [normalWindow styleMask] & NSWindowStyleMaskResizable ? NSControlStateValueOn : NSControlStateValueOff];
     [menu addItem: menuItem];
     menuItem = [[[NSMenuItem alloc] initWithTitle:@"View" action:nil keyEquivalent:@""] autorelease];
     [menuItem setSubmenu:menu];
@@ -2035,7 +2033,6 @@ static void cocoa_display_init(DisplayState *ds, DisplayOptions *opts)
     }
 
     if (opts->u.cocoa.has_zoom_to_fit && opts->u.cocoa.zoom_to_fit) {
-        stretch_video = true;
         [normalWindow setStyleMask:[normalWindow styleMask] | NSWindowStyleMaskResizable];
     }
 

-- 
2.43.0


