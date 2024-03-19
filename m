Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F1307C54E58
	for <qemu-devel@archiver.kernel.org>; Tue, 19 Mar 2024 03:09:30 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rmPqa-00056o-AH; Mon, 18 Mar 2024 23:09:04 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1rmPqX-00056N-An
 for qemu-devel@nongnu.org; Mon, 18 Mar 2024 23:09:01 -0400
Received: from mail-pg1-x531.google.com ([2607:f8b0:4864:20::531])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1rmPqV-0007Z9-Lo
 for qemu-devel@nongnu.org; Mon, 18 Mar 2024 23:09:01 -0400
Received: by mail-pg1-x531.google.com with SMTP id
 41be03b00d2f7-5dca1efad59so3248575a12.2
 for <qemu-devel@nongnu.org>; Mon, 18 Mar 2024 20:08:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=daynix-com.20230601.gappssmtp.com; s=20230601; t=1710817738; x=1711422538;
 darn=nongnu.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=3RegtZ3nIGTQTRcqp9yX+20kk5CmZ38gK/hIVQ4XCFU=;
 b=aHIsog4fxq4Y0HpDndsBOBByn7qe+ubxK1SNc9uwwBQzuJW2JxwVtSBqvLVs/u5OoN
 8BSSoBCPwuSlv9B/0Ky6hnovIybp0Ztm6nXT6jZtHnmyiqcwHA30/7YsiX2B3gfKOlGO
 DeKiG2S4T66horFsq81Lmz11uLTIRKbc9uJbZQs9p6BKSryvgrybsLb1y4JINM1+2qYt
 Lpz1Nkhrzt2BtA3Hk1TDQg5e7oAWSfJXolcvIko97XqQelZGD/5DWskeGPxsZZKVzk5Q
 warxaA+2zePRDQuOVVz7SHwuW6T73KpCF02ccvtQGIYDBO6x15xbcXS4g3bX3SX6Cm+f
 E8EA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1710817738; x=1711422538;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=3RegtZ3nIGTQTRcqp9yX+20kk5CmZ38gK/hIVQ4XCFU=;
 b=gseHmEowBK/ZQvrmror9h2CkMIQ4ajK4jxzOuRfUvzdY/0XUL5vblf7GjnMflPGhD0
 BFNtzoPaAp+ytiRqa829WCfpl5MSDIrO2TQvZDS3aYGlVS2DXqrxVEoHbDT5S9WbMtf5
 De6IE/8AIfuZqereLfIitqi7tsU5RJAkziP7VOcEE85GdJf3jXbWM262knlhaV3nVVG0
 uEd4e3MZ30jnKCTGMk3xDpY9ntjwtM6vYT1GZSCwZBQrwQtSWNAqrx8LFa1i0qs/qou6
 8fPRjGJI9ZK4cIrTsjfaE2TA2mnNvCqLdC3+JUqooIm5J0Q/etmQveHw6FAGgNbX0xfS
 D3TQ==
X-Gm-Message-State: AOJu0Yz3I2FKuM192iVX4bI+Kwma3y7w5mkdeO580SjtKyAt1n7IfGSl
 NpW377vzw8J6t/jOxaUNl5UjwlVjVTlsLORJ4IA7YnRZ5oIe5BLW01jmA6ctIEiH2qeaYfsq6Ay
 A
X-Google-Smtp-Source: AGHT+IHApxg3ocwopxlieR8lp8f3LVosY0Fo7Z/S9rJ2GEJpDUnzBiNfjdjjQfTDRJu2ERYtR7ntHw==
X-Received: by 2002:a05:6a21:a58f:b0:1a1:476b:81a8 with SMTP id
 gd15-20020a056a21a58f00b001a1476b81a8mr13405475pzc.6.1710817738028; 
 Mon, 18 Mar 2024 20:08:58 -0700 (PDT)
Received: from localhost ([2400:4050:a840:1e00:9ac7:6d57:2b16:6932])
 by smtp.gmail.com with UTF8SMTPSA id
 lb4-20020a170902fa4400b001e0287592c4sm2736497plb.267.2024.03.18.20.08.56
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 18 Mar 2024 20:08:57 -0700 (PDT)
From: Akihiko Odaki <akihiko.odaki@daynix.com>
Date: Tue, 19 Mar 2024 12:08:41 +0900
Subject: [PATCH v2 3/4] ui/cocoa: Do not use console_select()
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240319-console-v2-3-3fd6feef321a@daynix.com>
References: <20240319-console-v2-0-3fd6feef321a@daynix.com>
In-Reply-To: <20240319-console-v2-0-3fd6feef321a@daynix.com>
To: Gerd Hoffmann <kraxel@redhat.com>, 
 =?utf-8?q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>, 
 Peter Maydell <peter.maydell@linaro.org>, 
 =?utf-8?q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Cc: qemu-devel@nongnu.org, Akihiko Odaki <akihiko.odaki@daynix.com>
X-Mailer: b4 0.12.3
Received-SPF: none client-ip=2607:f8b0:4864:20::531;
 envelope-from=akihiko.odaki@daynix.com; helo=mail-pg1-x531.google.com
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

ui/cocoa needs to update the UI info and reset the keyboard state
tracker when switching the console, or the new console will see the
stale UI info or keyboard state. Previously, updating the UI info was
done with cocoa_switch(), but it is meant to be called when the surface
is being replaced, and may be called even when not switching the
console. ui/cocoa never reset the keyboard state, which resulted in
stuck keys.

Add ui/cocoa's own implementation of console_select(), which updates the
UI info and resets the keyboard state tracker.

Signed-off-by: Akihiko Odaki <akihiko.odaki@daynix.com>
---
 ui/cocoa.m | 37 ++++++++++++++++++++++++++-----------
 1 file changed, 26 insertions(+), 11 deletions(-)

diff --git a/ui/cocoa.m b/ui/cocoa.m
index fa879d7dcd4b..810751cf2644 100644
--- a/ui/cocoa.m
+++ b/ui/cocoa.m
@@ -102,6 +102,7 @@ static void cocoa_switch(DisplayChangeListener *dcl,
 static DisplayChangeListener dcl = {
     .ops = &dcl_ops,
 };
+static QKbdState *kbd;
 static int cursor_hide = 1;
 static int left_command_key_enabled = 1;
 static bool swap_opt_cmd;
@@ -309,7 +310,6 @@ @interface QemuCocoaView : NSView
     NSTrackingArea *trackingArea;
     QEMUScreen screen;
     pixman_image_t *pixman_image;
-    QKbdState *kbd;
     BOOL isMouseGrabbed;
     BOOL isAbsoluteEnabled;
     CFMachPortRef eventsTap;
@@ -361,7 +361,6 @@ - (id)initWithFrame:(NSRect)frameRect
 
         screen.width = frameRect.size.width;
         screen.height = frameRect.size.height;
-        kbd = qkbd_state_init(dcl.con);
 #if MAC_OS_X_VERSION_MAX_ALLOWED >= MAC_OS_VERSION_14_0
         [self setClipsToBounds:YES];
 #endif
@@ -378,8 +377,6 @@ - (void) dealloc
         pixman_image_unref(pixman_image);
     }
 
-    qkbd_state_free(kbd);
-
     if (eventsTap) {
         CFRelease(eventsTap);
     }
@@ -429,6 +426,20 @@ - (void) viewWillMoveToWindow:(NSWindow *)newWindow
     [self removeTrackingRect];
 }
 
+- (void) selectConsoleLocked:(unsigned int)index
+{
+    QemuConsole *con = qemu_console_lookup_by_index(index);
+    if (!con) {
+        return;
+    }
+
+    unregister_displaychangelistener(&dcl);
+    qkbd_state_switch_console(kbd, con);
+    dcl.con = con;
+    register_displaychangelistener(&dcl);
+    [self updateUIInfo];
+}
+
 - (void) hideCursor
 {
     if (!cursor_hide) {
@@ -718,7 +729,8 @@ - (void) handleMonitorInput:(NSEvent *)event
     }
 
     if (keysym) {
-        qemu_text_console_put_keysym(NULL, keysym);
+        QemuTextConsole *con = QEMU_TEXT_CONSOLE(dcl.con);
+        qemu_text_console_put_keysym(con, keysym);
     }
 }
 
@@ -898,7 +910,7 @@ - (bool) handleEventLocked:(NSEvent *)event
 
                         // enable graphic console
                         case '1' ... '9':
-                            console_select(key - '0' - 1); /* ascii math */
+                            [self selectConsoleLocked:key - '0' - 1]; /* ascii math */
                             return true;
 
                         // release the mouse grab
@@ -909,7 +921,7 @@ - (bool) handleEventLocked:(NSEvent *)event
                 }
             }
 
-            if (qemu_console_is_graphic(NULL)) {
+            if (qemu_console_is_graphic(dcl.con)) {
                 qkbd_state_key_event(kbd, keycode, true);
             } else {
                 [self handleMonitorInput: event];
@@ -924,7 +936,7 @@ - (bool) handleEventLocked:(NSEvent *)event
                 return true;
             }
 
-            if (qemu_console_is_graphic(NULL)) {
+            if (qemu_console_is_graphic(dcl.con)) {
                 qkbd_state_key_event(kbd, keycode, false);
             }
             return true;
@@ -1374,7 +1386,7 @@ - (void)toggleZoomInterpolation:(id) sender
 - (void)displayConsole:(id)sender
 {
     with_bql(^{
-        console_select([sender tag]);
+        [cocoaView selectConsoleLocked:[sender tag]];
     });
 }
 
@@ -1945,7 +1957,6 @@ static void cocoa_switch(DisplayChangeListener *dcl,
     pixman_image_ref(image);
 
     dispatch_async(dispatch_get_main_queue(), ^{
-        [cocoaView updateUIInfo];
         [cocoaView switchSurface:image];
     });
 }
@@ -1955,7 +1966,7 @@ static void cocoa_refresh(DisplayChangeListener *dcl)
     NSAutoreleasePool * pool = [[NSAutoreleasePool alloc] init];
 
     COCOA_DEBUG("qemu_cocoa: cocoa_refresh\n");
-    graphic_hw_update(NULL);
+    graphic_hw_update(dcl->con);
 
     if (qemu_input_is_absolute(dcl->con)) {
         dispatch_async(dispatch_get_main_queue(), ^{
@@ -2039,8 +2050,12 @@ static void cocoa_display_init(DisplayState *ds, DisplayOptions *opts)
     add_console_menu_entries();
     addRemovableDevicesMenuItems();
 
+    dcl.con = qemu_console_lookup_default();
+    kbd = qkbd_state_init(dcl.con);
+
     // register vga output callbacks
     register_displaychangelistener(&dcl);
+    [cocoaView updateUIInfo];
 
     qemu_event_init(&cbevent, false);
     cbowner = [[QemuCocoaPasteboardTypeOwner alloc] init];

-- 
2.44.0


