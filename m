Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8E38EC54E5D
	for <qemu-devel@archiver.kernel.org>; Mon, 18 Mar 2024 07:53:44 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rm7oA-0002xx-46; Mon, 18 Mar 2024 03:53:22 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1rm7o8-0002xe-LP
 for qemu-devel@nongnu.org; Mon, 18 Mar 2024 03:53:20 -0400
Received: from mail-pf1-x42a.google.com ([2607:f8b0:4864:20::42a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1rm7o7-000061-1v
 for qemu-devel@nongnu.org; Mon, 18 Mar 2024 03:53:20 -0400
Received: by mail-pf1-x42a.google.com with SMTP id
 d2e1a72fcca58-6e6ee9e3cffso2314020b3a.1
 for <qemu-devel@nongnu.org>; Mon, 18 Mar 2024 00:53:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=daynix-com.20230601.gappssmtp.com; s=20230601; t=1710748398; x=1711353198;
 darn=nongnu.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=AtoTEhnfQvLOFmj6OES89MI4C55bFzE0mr1LF1KLIWc=;
 b=fl/a+18pY3/Jrqxfpd9rCyNKteMXPdKms94Dz/1tKb+xu08RYSTA2OaG3Lxt1/hEZ9
 BqPlnHfVA+FDoq7D4kHsWQk+49GhlsXZQXEczaBO8msXQl2cv22ZkWw9RuT03KyYvyW1
 qhcgksASQAhWLMLgFbEdEG3FBh9yNnAejB6QlQ0/XLAkBFOrX6Sxlf5LtFitspNqWF04
 Fn9ncnS65qOwM+hNovWso+SJTbDCM2zZ2P3V9y0PMDk5gN776CNRCZB0OZYILc9UQ21p
 HlCF5BM3Afb4ZaQByadMMnz7vY5nqiGpz8o7RahMxeYwpub1fNM49JL9RsEqyPw+nC6/
 ZTqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1710748398; x=1711353198;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=AtoTEhnfQvLOFmj6OES89MI4C55bFzE0mr1LF1KLIWc=;
 b=weDRao4WUEVlopmZoYURbCmBhb4BAaqMv68LjrsWaSqY9NdX14K8QpvVyBpih1gdwZ
 VTFOPrA9ZA7mwxCec9k9RBXBGXKneEj+9Ojvm9J9STaz7wZ4dxszOmpPR1J9jZD6tHzJ
 zgZstlXmNjxLHKf74M1OOGG1W9PNhEfi0HZhbsbWi6oQ25z2d1WSH79iH7NOssuLq0Xi
 Eu3NxRm89Nd2GN2sLFGoz+nfHBgXI6VtDfnw2prFfAmG2Hy1pg0aSAftUdmxyNh7J9R3
 H3cJynIHf+fHFcNaQq6AHgIAQZ0Rf9ssp9nBdkLWW+iJqHrmyiXsR2z5izW/xg0yCBJ9
 WIcQ==
X-Gm-Message-State: AOJu0Yy4xjjgLw7QGwyj2r446a1zUAt1AbXf23osv4KBxoYlevi6s+Qi
 dUa/5EMi9rI+BnIP22kUjRz1m+RJRzGjS131S9p/zW11pkLBCQWg3/286IMVktc=
X-Google-Smtp-Source: AGHT+IHlBlXs60U8nB/1EDgFflfJ+qej5tA5hB92VOMr45YO1GtC1ESZWobSME00btK5xrmyZfeJCg==
X-Received: by 2002:a05:6a00:21d4:b0:6e7:933:9ecf with SMTP id
 t20-20020a056a0021d400b006e709339ecfmr8880852pfj.16.1710748397739; 
 Mon, 18 Mar 2024 00:53:17 -0700 (PDT)
Received: from localhost ([157.82.200.213])
 by smtp.gmail.com with UTF8SMTPSA id
 p13-20020a62ab0d000000b006e53cc789c3sm7258871pff.107.2024.03.18.00.53.16
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 18 Mar 2024 00:53:17 -0700 (PDT)
From: Akihiko Odaki <akihiko.odaki@daynix.com>
Date: Mon, 18 Mar 2024 16:53:02 +0900
Subject: [PATCH 3/3] ui/cocoa: Use NSTrackingInVisibleRect
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240318-fixes-v1-3-34f1a849b0d9@daynix.com>
References: <20240318-fixes-v1-0-34f1a849b0d9@daynix.com>
In-Reply-To: <20240318-fixes-v1-0-34f1a849b0d9@daynix.com>
To: Peter Maydell <peter.maydell@linaro.org>, 
 =?utf-8?q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>, 
 Gerd Hoffmann <kraxel@redhat.com>, 
 =?utf-8?q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>
Cc: qemu-devel@nongnu.org, Akihiko Odaki <akihiko.odaki@daynix.com>
X-Mailer: b4 0.12.3
Received-SPF: none client-ip=2607:f8b0:4864:20::42a;
 envelope-from=akihiko.odaki@daynix.com; helo=mail-pf1-x42a.google.com
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

I observed [NSTrackingArea rect] becomes de-synchronized with the view
frame with some unknown condition. Specify NSTrackingInVisibleRect
option to let Cocoa automatically update NSTrackingArea, which also
saves code for synchronization.

Fixes: 91aa508d0274 ("ui/cocoa: Let the platform toggle fullscreen")
Signed-off-by: Akihiko Odaki <akihiko.odaki@daynix.com>
---
 ui/cocoa.m | 48 ++++++++++++++----------------------------------
 1 file changed, 14 insertions(+), 34 deletions(-)

diff --git a/ui/cocoa.m b/ui/cocoa.m
index 1324be6d32fe..1e2b7d931905 100644
--- a/ui/cocoa.m
+++ b/ui/cocoa.m
@@ -306,7 +306,6 @@ static void handleAnyDeviceErrors(Error * err)
 */
 @interface QemuCocoaView : NSView
 {
-    NSTrackingArea *trackingArea;
     QEMUScreen screen;
     pixman_image_t *pixman_image;
     QKbdState *kbd;
@@ -359,6 +358,19 @@ - (id)initWithFrame:(NSRect)frameRect
     self = [super initWithFrame:frameRect];
     if (self) {
 
+        NSTrackingAreaOptions options = NSTrackingActiveInKeyWindow |
+                                        NSTrackingMouseEnteredAndExited |
+                                        NSTrackingMouseMoved |
+                                        NSTrackingInVisibleRect;
+
+        NSTrackingArea *trackingArea =
+            [[NSTrackingArea alloc] initWithRect:CGRectZero
+                                         options:options
+                                           owner:self
+                                        userInfo:nil];
+
+        [self addTrackingArea:trackingArea];
+        [trackingArea release];
         screen.width = frameRect.size.width;
         screen.height = frameRect.size.height;
         kbd = qkbd_state_init(dcl.con);
@@ -392,41 +404,9 @@ - (BOOL) isOpaque
     return YES;
 }
 
-- (void) removeTrackingRect
-{
-    if (trackingArea) {
-        [self removeTrackingArea:trackingArea];
-        [trackingArea release];
-        trackingArea = nil;
-    }
-}
-
-- (void) frameUpdated
-{
-    [self removeTrackingRect];
-
-    if ([self window]) {
-        NSTrackingAreaOptions options = NSTrackingActiveInKeyWindow |
-                                        NSTrackingMouseEnteredAndExited |
-                                        NSTrackingMouseMoved;
-        trackingArea = [[NSTrackingArea alloc] initWithRect:[self frame]
-                                                    options:options
-                                                      owner:self
-                                                   userInfo:nil];
-        [self addTrackingArea:trackingArea];
-        [self updateUIInfo];
-    }
-}
-
 - (void) viewDidMoveToWindow
 {
     [self resizeWindow];
-    [self frameUpdated];
-}
-
-- (void) viewWillMoveToWindow:(NSWindow *)newWindow
-{
-    [self removeTrackingRect];
 }
 
 - (void) hideCursor
@@ -1284,7 +1264,7 @@ - (void)windowDidExitFullScreen:(NSNotification *)notification
 - (void)windowDidResize:(NSNotification *)notification
 {
     [cocoaView updateBounds];
-    [cocoaView frameUpdated];
+    [cocoaView updateUIInfo];
 }
 
 /* Called when the user clicks on a window's close button */

-- 
2.44.0


