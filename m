Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DC788C3064D
	for <qemu-devel@archiver.kernel.org>; Tue, 25 Jun 2024 13:50:27 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sM6YZ-0006zN-N1; Tue, 25 Jun 2024 09:49:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <phil@philjordan.eu>)
 id 1sM6YX-0006yr-9d
 for qemu-devel@nongnu.org; Tue, 25 Jun 2024 09:49:57 -0400
Received: from mail-lj1-x229.google.com ([2a00:1450:4864:20::229])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <phil@philjordan.eu>)
 id 1sM6YU-0007Kt-9X
 for qemu-devel@nongnu.org; Tue, 25 Jun 2024 09:49:56 -0400
Received: by mail-lj1-x229.google.com with SMTP id
 38308e7fff4ca-2eaea28868dso73417441fa.3
 for <qemu-devel@nongnu.org>; Tue, 25 Jun 2024 06:49:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=philjordan-eu.20230601.gappssmtp.com; s=20230601; t=1719323392; x=1719928192;
 darn=nongnu.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=fblMUAK/+8LE6mBEBaO4iTmx3F9Zc50cn4A+rhgKV38=;
 b=qjTJdSNYDWKR/B+FuCQOeeQWKo8J83R4A3MmSyPLdDDdTc3fqfKWdJieEBkULSvdl4
 Pl8d0IlU6x+f9psY3Amc13nBb8xvh2YFe8WJw4g4QZT+NV4XMc9uemmPfyDQb5PIjGuD
 ofDaks/5Db8UYGbP2sIIuAypeTUBHPOPp7IV6rTkX6RR7IfuZ9io+jfNW+V/T4cb/81O
 OY6FDFNCbmeYT7ylbsG5/TYqPTqcYT6w0jE/rIFCDC99Zg6ZpvsysxlR/1kIjkZ4XSu2
 sjt1s9eN3g49EMoTY3c6ERQMZl7qxhliisi7JJYW+7YRxJK+MzDORP1JvKFQZgrPy5xy
 zRZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1719323392; x=1719928192;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=fblMUAK/+8LE6mBEBaO4iTmx3F9Zc50cn4A+rhgKV38=;
 b=gipXhGSBIKEJV2OTdgKor71ApNipvr/r7itdSLDQRul8jMbzOzvg/Od7Iu7HO48LbK
 dpud3QpwmQcIoKDWyLA6iKvibYoRrwYNp4pomOkYncEQVntFKmLsvpjNF2wH7hqv40wi
 W8yQnO6Rhz/R4URpRZ/5/Y4Jm1Jew2fK1fIoxntTyl70ESNgpF4ujctbA26U0fQuqJYq
 DcyBu3IAVM+Sq4kpCbn3SuQDXl3A/RolH8LX2GkHc0R7Yiptb6IVz1O33CiAMBnKy3v9
 BWAjIfhVr/VRiYh2K9/E1tUawFor09weM+rOA5+VU2hYvNrer+/uRAGzJ4beXm2pzPw8
 z1aA==
X-Gm-Message-State: AOJu0Yy41ZZzPr+sg0WCmOBUccm61vimWZlwzyHarxAoJwkKdOSSqNj4
 ed59CYoBPyqyRXZNuTabdBv6YCGwdZy5j+avHb2ZjrT4ISNFmvNhULKMoslvagPCeCivAzDieDf
 gXA==
X-Google-Smtp-Source: AGHT+IHrzcuQUcF8hirbaCMrHB+nev4Ps+eKDNJVnmxIXcXjtQGLOwwgbk5nzOp1ZPflW5qRvAIedw==
X-Received: by 2002:a05:6512:48c5:b0:52c:dba2:4f1 with SMTP id
 2adb3069b0e04-52ce18524e1mr4890998e87.48.1719323392538; 
 Tue, 25 Jun 2024 06:49:52 -0700 (PDT)
Received: from localhost.localdomain (89-104-8-17.customer.bnet.at.
 [89.104.8.17]) by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-a726e13a4d7sm77299166b.19.2024.06.25.06.49.51
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 25 Jun 2024 06:49:52 -0700 (PDT)
From: Phil Dennis-Jordan <phil@philjordan.eu>
To: qemu-devel@nongnu.org
Cc: peter.maydell@linaro.org, philmd@linaro.org, marcandre.lureau@redhat.com,
 akihiko.odaki@daynix.com, lists@philjordan.eu,
 Phil Dennis-Jordan <phil@philjordan.eu>
Subject: [PATCH v2 2/2] ui/cocoa: Adds NSCursor absolute pointer support
Date: Tue, 25 Jun 2024 15:49:31 +0200
Message-Id: <20240625134931.92279-3-phil@philjordan.eu>
X-Mailer: git-send-email 2.39.3 (Apple Git-146)
In-Reply-To: <20240625134931.92279-1-phil@philjordan.eu>
References: <20240625134931.92279-1-phil@philjordan.eu>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: neutral client-ip=2a00:1450:4864:20::229;
 envelope-from=phil@philjordan.eu; helo=mail-lj1-x229.google.com
X-Spam_score_int: -10
X-Spam_score: -1.1
X-Spam_bar: -
X-Spam_report: (-1.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_NEUTRAL=0.779 autolearn=no autolearn_force=no
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

When pointer input is absolute, use the native macOS host’s Cocoa
NSCursor to render the guest’s cursor. The rendered cursor is no longer
cropped to the guest viewport, and the correct cursor image is passed to
anything tapping into the host system’s native cursor. (such as remote
access)

The CALayer is retained for rendering the cursor in relative pointer
input mode. Cropping the cursor here gives a visual indication of the
captured pointer (the mouse must be explicitly ungrabbed before allowing
the cursor to leave the Qemu window), and teleporting the host cursor
when its position is changed by the guest causes a feedback loop in
input events.

Signed-off-by: Phil Dennis-Jordan <phil@philjordan.eu>
---
 ui/cocoa.m | 82 +++++++++++++++++++++++++++++++++++++++++++-----------
 1 file changed, 65 insertions(+), 17 deletions(-)

diff --git a/ui/cocoa.m b/ui/cocoa.m
index cca987eac7..131c442e16 100644
--- a/ui/cocoa.m
+++ b/ui/cocoa.m
@@ -314,6 +314,7 @@ @interface QemuCocoaView : NSView
     CFMachPortRef eventsTap;
     CALayer *cursorLayer;
     QEMUCursor *cursor;
+    NSCursor *cocoaCursor;
     int mouseX;
     int mouseY;
     int mouseOn;
@@ -402,6 +403,9 @@ - (void) dealloc
 
     [cursorLayer release];
     cursorLayer = nil;
+    [cocoaCursor release];
+    cocoaCursor = nil;
+
     [super dealloc];
 }
 
@@ -460,27 +464,14 @@ - (void)setMouseX:(int)x y:(int)y on:(int)on
     [CATransaction begin];
     [CATransaction setDisableActions:YES];
     [cursorLayer setPosition:position];
-    [cursorLayer setHidden:!mouseOn];
+    [cursorLayer setHidden:!mouseOn || isAbsoluteEnabled];
     [CATransaction commit];
 }
 
-- (void)setCursor:(QEMUCursor *)given_cursor
+static CGImageRef cursor_cgimage_create(QEMUCursor *cursor)
 {
     CGDataProviderRef provider;
     CGImageRef image;
-    CGRect bounds = CGRectZero;
-
-    cursor_unref(cursor);
-    cursor = given_cursor;
-
-    if (!cursor) {
-        return;
-    }
-
-    cursor_ref(cursor);
-
-    bounds.size.width = cursor->width;
-    bounds.size.height = cursor->height;
     CGColorSpaceRef color_space = CGColorSpaceCreateWithName(kCGColorSpaceSRGB);
 
     provider = CGDataProviderCreateWithData(
@@ -506,6 +497,43 @@ - (void)setCursor:(QEMUCursor *)given_cursor
 
     CGDataProviderRelease(provider);
     CGColorSpaceRelease(color_space);
+    return image;
+}
+
+static NSCursor *cocoa_cursor_create(QEMUCursor *cursor, CGImageRef image)
+{
+    NSPoint hotspot = { cursor->hot_x, cursor->hot_y };
+    NSSize size = NSMakeSize(cursor->width, cursor->height);
+    NSImage *cursor_image = [[NSImage alloc] initWithCGImage:image size:size];
+    NSCursor *cocoa_cursor =
+        [[NSCursor alloc] initWithImage:cursor_image hotSpot:hotspot];
+    [cursor_image release];
+    return cocoa_cursor;
+}
+
+- (void)setCursor:(QEMUCursor *)given_cursor
+{
+    CGImageRef image;
+    NSImage *cursor_nsimage = nil;
+    CGRect bounds = CGRectZero;
+
+    cursor_unref(cursor);
+    cursor = given_cursor;
+
+    if (!cursor) {
+        return;
+    }
+
+    cursor_ref(cursor);
+
+    bounds.size.width = cursor->width;
+    bounds.size.height = cursor->height;
+
+    image = cursor_cgimage_create(cursor);
+    [cocoaCursor release];
+    cocoaCursor = cocoa_cursor_create(cursor, image);
+    [self.window invalidateCursorRectsForView:self];
+
     [CATransaction begin];
     [CATransaction setDisableActions:YES];
     [cursorLayer setBounds:bounds];
@@ -514,6 +542,16 @@ - (void)setCursor:(QEMUCursor *)given_cursor
     CGImageRelease(image);
 }
 
+- (void) resetCursorRects
+{
+    if (self->cocoaCursor == nil) {
+        [super resetCursorRects];
+    } else {
+        NSRect guest_area = {{ 0.0, 0.0 }, { screen.width, screen.height }};
+        [self addCursorRect:guest_area cursor:cocoaCursor];
+    }
+}
+
 - (void) drawRect:(NSRect) rect
 {
     COCOA_DEBUG("QemuCocoaView: drawRect\n");
@@ -1181,7 +1219,12 @@ - (void) grabMouse
         [[self window] setTitle:[NSString stringWithFormat:@"QEMU %s - (Press  " UC_CTRL_KEY " " UC_ALT_KEY " G  to release Mouse)", qemu_name]];
     else
         [[self window] setTitle:@"QEMU - (Press  " UC_CTRL_KEY " " UC_ALT_KEY " G  to release Mouse)"];
-    [self hideCursor];
+
+    [cursorLayer setHidden:!mouseOn || isAbsoluteEnabled];
+    if (!isAbsoluteEnabled) {
+        [self hideCursor];
+    }
+
     CGAssociateMouseAndMouseCursorPosition(isAbsoluteEnabled);
     isMouseGrabbed = TRUE; // while isMouseGrabbed = TRUE, QemuCocoaApp sends all events to [cocoaView handleEvent:]
 }
@@ -1194,7 +1237,11 @@ - (void) ungrabMouse
         [[self window] setTitle:[NSString stringWithFormat:@"QEMU %s", qemu_name]];
     else
         [[self window] setTitle:@"QEMU"];
-    [self unhideCursor];
+
+    [cursorLayer setHidden:!mouseOn || isAbsoluteEnabled];
+    if (!isAbsoluteEnabled) {
+        [self unhideCursor];
+    }
     CGAssociateMouseAndMouseCursorPosition(TRUE);
     isMouseGrabbed = FALSE;
     [self raiseAllButtons];
@@ -1216,6 +1263,7 @@ - (void) notifyMouseModeChange {
             [self ungrabMouse];
         } else {
             CGAssociateMouseAndMouseCursorPosition(isAbsoluteEnabled);
+            [self hideCursor];
         }
     }
 }
-- 
2.39.3 (Apple Git-146)


