Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 297C9C48260
	for <qemu-devel@archiver.kernel.org>; Tue, 13 Feb 2024 12:01:53 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rZrTw-0004MG-Pf; Tue, 13 Feb 2024 07:01:51 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1rZrTn-0004Db-KO
 for qemu-devel@nongnu.org; Tue, 13 Feb 2024 07:01:40 -0500
Received: from mail-pf1-x433.google.com ([2607:f8b0:4864:20::433])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1rZrTl-0000xs-E8
 for qemu-devel@nongnu.org; Tue, 13 Feb 2024 07:01:39 -0500
Received: by mail-pf1-x433.google.com with SMTP id
 d2e1a72fcca58-6e0fc87fc2dso203217b3a.3
 for <qemu-devel@nongnu.org>; Tue, 13 Feb 2024 04:01:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=daynix-com.20230601.gappssmtp.com; s=20230601; t=1707825695; x=1708430495;
 darn=nongnu.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=xxggzNoSHA/NLM+K6602kCvWVNLthDE/kRWJr7Ttw8g=;
 b=PurE6EucoYmwmVgBbOtXlJNaF3Kz4FXbD2FsO/ug0DrIOP/uuEVN44Qe2rWqXXmwt3
 C7QVWqJ80paxi6mAoRkLe7VwXkzuWtpC37R5vnjyBRL3++J35DlYz2hO2uhlduPkr6WU
 sPQ4r5pxwSOKMvRehXJEfpHV3cJLlwaoZmzDTMNhUHkGb5VecomWylRXFULHqBSX54ep
 gIChYNL8CgdjiKTQFPif5EPwXcI9MYz7MniWH8W7I0IbMuJIBFV0ZLTPIjm+t/EQgVSj
 CvCYb7qXCUdtBVuYmCUcJYW7Rls6+piSHG+A6i4PRuXRopJgY/Cvv+35d2ePMKoV+qTp
 5EWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1707825695; x=1708430495;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=xxggzNoSHA/NLM+K6602kCvWVNLthDE/kRWJr7Ttw8g=;
 b=DUhHjkeIBCrtStWG6kuMKLx3vbe9emptb7OOnTTPoYxtfOBpRKOBaqyCZGOMWpeM0/
 bNqxXyj4kdFxpO/WNgRoMY2YAA6/C2Enjcn1RVILivhCAazfns9CQNUfFmAEyU4laj/0
 5mZGdjBqfgQMSX5txVl7HOfA6MtFSIj+01vNPwN1er0IKPLW3LZoq2IfI/wS7CtQyOZ6
 wpSGk3GtLnEVvNw24DPRsvaLiDi6q4wZTFt4ooXW7oyQQgpz5qZl82zhFrAtKXxtfARU
 VkpWXUSPTfgfu69ZQ7fjfgr/7ZoKWNZSZPkXYXEcqtUlVWef3vYwdyk6ewwixBsHOLQp
 Nrcg==
X-Gm-Message-State: AOJu0YwsQBJyIXiogwrE9JNyE42Cj44sgj/gsg/drFPcmzXQcu1JuPaw
 EohFiABTfFX30JFqhveLQ04cokSomwzmpXknjjbQ5c3DYi7s5HsRJ4xJ6ibXjhR6+DYXUz6QiEg
 K
X-Google-Smtp-Source: AGHT+IH69OyZ84u11JypLgfaCsxD20dK6QyJLhdWQ0vnkEKAaf8nPpEtHQmUsqM1y0eQEgjca90HEg==
X-Received: by 2002:a62:ce4e:0:b0:6e0:a025:feb2 with SMTP id
 y75-20020a62ce4e000000b006e0a025feb2mr7793977pfg.11.1707825695110; 
 Tue, 13 Feb 2024 04:01:35 -0800 (PST)
X-Forwarded-Encrypted: i=1;
 AJvYcCWuITPVZOhgMqF73ouEs9ab0OyXijXJpJPWbX5nVB9ICEFuu7FLzRXyHPS0+zXmXx23oGnzCZUgqRs77XWTltYPFrXkEG521Jwak2Mj6No1qdNjGMI4y8Xe/eAIc75myOLsJ5Pmky2B5Tu0/WupXgob78q3e2z6qsduFi16gXrGoo3+fsjv+HPCbO+um8xAAVpKnlBpVxm4Pa7kRwgB9OoYg88rryf+g12OkwQ/AwoPI1qrc3w7uW9WPyHhchn7EG1/jlbWRSNyciO3
Received: from localhost ([157.82.207.134])
 by smtp.gmail.com with UTF8SMTPSA id
 y20-20020a056a00181400b006e06af90ff4sm7165010pfa.204.2024.02.13.04.01.32
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 13 Feb 2024 04:01:34 -0800 (PST)
From: Akihiko Odaki <akihiko.odaki@daynix.com>
Date: Tue, 13 Feb 2024 21:01:00 +0900
Subject: [PATCH v9 6/6] ui/cocoa: Remove stretch_video flag
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240213-cocoa-v9-6-d5a5e1bf0490@daynix.com>
References: <20240213-cocoa-v9-0-d5a5e1bf0490@daynix.com>
In-Reply-To: <20240213-cocoa-v9-0-d5a5e1bf0490@daynix.com>
To: Peter Maydell <peter.maydell@linaro.org>, 
 =?utf-8?q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>, 
 Gerd Hoffmann <kraxel@redhat.com>, 
 =?utf-8?q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>, 
 Marek Glogowski <smarkusg@gmail.com>, BALATON Zoltan <balaton@eik.bme.hu>, 
 Rene Engel <ReneEngel80@emailn.de>
Cc: qemu-devel@nongnu.org, Akihiko Odaki <akihiko.odaki@daynix.com>
X-Mailer: b4 0.12.3
Received-SPF: none client-ip=2607:f8b0:4864:20::433;
 envelope-from=akihiko.odaki@daynix.com; helo=mail-pf1-x433.google.com
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
index 93e761f09c6e..e68f418d9e42 100644
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
@@ -1296,7 +1295,7 @@ - (BOOL)windowShouldClose:(id)sender
 
 - (NSSize) window:(NSWindow *)window willUseFullScreenContentSize:(NSSize)proposedSize
 {
-    if (stretch_video) {
+    if ([normalWindow styleMask] & NSWindowStyleMaskResizable) {
         return [cocoaView fixZoomedFullScreenSize:proposedSize];
     }
 
@@ -1377,8 +1376,7 @@ - (void)showQEMUDoc:(id)sender
 /* Stretches video to fit host monitor size */
 - (void)zoomToFit:(id) sender
 {
-    stretch_video = !stretch_video;
-    if (stretch_video == true) {
+    if (([normalWindow styleMask] & NSWindowStyleMaskResizable) == 0) {
         [normalWindow setStyleMask:[normalWindow styleMask] | NSWindowStyleMaskResizable];
         [sender setState: NSControlStateValueOn];
     } else {
@@ -1650,7 +1648,7 @@ static void create_initial_menus(void)
     menu = [[NSMenu alloc] initWithTitle:@"View"];
     [menu addItem: [[[NSMenuItem alloc] initWithTitle:@"Enter Fullscreen" action:@selector(doToggleFullScreen:) keyEquivalent:@"f"] autorelease]]; // Fullscreen
     menuItem = [[[NSMenuItem alloc] initWithTitle:@"Zoom To Fit" action:@selector(zoomToFit:) keyEquivalent:@""] autorelease];
-    [menuItem setState: stretch_video ? NSControlStateValueOn : NSControlStateValueOff];
+    [menuItem setState: [normalWindow styleMask] & NSWindowStyleMaskResizable ? NSControlStateValueOn : NSControlStateValueOff];
     [menu addItem: menuItem];
     menuItem = [[[NSMenuItem alloc] initWithTitle:@"View" action:nil keyEquivalent:@""] autorelease];
     [menuItem setSubmenu:menu];
@@ -2036,7 +2034,6 @@ static void cocoa_display_init(DisplayState *ds, DisplayOptions *opts)
     }
 
     if (opts->u.cocoa.has_zoom_to_fit && opts->u.cocoa.zoom_to_fit) {
-        stretch_video = true;
         [normalWindow setStyleMask:[normalWindow styleMask] | NSWindowStyleMaskResizable];
     }
 

-- 
2.43.0


