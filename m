Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DCD44C54E58
	for <qemu-devel@archiver.kernel.org>; Mon, 18 Mar 2024 07:59:25 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rm7tO-0006RQ-F2; Mon, 18 Mar 2024 03:58:47 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1rm7tM-0006Pf-1U
 for qemu-devel@nongnu.org; Mon, 18 Mar 2024 03:58:44 -0400
Received: from mail-pj1-x102b.google.com ([2607:f8b0:4864:20::102b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1rm7tE-00011C-9w
 for qemu-devel@nongnu.org; Mon, 18 Mar 2024 03:58:43 -0400
Received: by mail-pj1-x102b.google.com with SMTP id
 98e67ed59e1d1-29fb11f4b34so323686a91.0
 for <qemu-devel@nongnu.org>; Mon, 18 Mar 2024 00:58:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=daynix-com.20230601.gappssmtp.com; s=20230601; t=1710748715; x=1711353515;
 darn=nongnu.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=0XM3xdzPI4uVUMqsF0fbvM8bgAigPZTBLc/D9c25dcs=;
 b=gtXtjSH2EOa0Ba1257x+KcP+OYDfG3a3cHuiiFawJ/kr2EggkbNlOMPlHC5D2RBRMF
 2PvemncC7i3XHVk07Ut1VuuDPxE4a0wsTYc+plzkNmDl7IwAe19aMTHpqVK5s/394yMw
 uDV+EoUH0lmeR0PrNV9HgeJ3zg9+cdq4YENn9agy0IJLn2eT943RfCp08PEwI1ORYmZs
 eZX/Dlq/Tk5RywUuNoAEH1aKwOYHuxsSqomW40dvJmiUNlIthjd+IWeGOJIRPaKOBy04
 oyoGokRIU9QT2SfA1uw0LtHmUO1KsnVJ+JHVWrwvAVSmA9dAz3YyKDcx3ysEAwwwW3FR
 SWIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1710748715; x=1711353515;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=0XM3xdzPI4uVUMqsF0fbvM8bgAigPZTBLc/D9c25dcs=;
 b=ODI/sI+wLs6nmSUGWDU6sVlUBHMql0I12crni3a5Vq4W/+tSnpx19o8Yx/rgGLDJRb
 uE2yegpxvoGZePI1JUvzoZF/UV7EC8ltwJ8OuuPSgPBiIRNZoJhPuGt+k0XNfbeMDPW9
 Jh143AW0LIKvGvdLFxQpu1oYkfovQy1+i0jdvYEzZlVmku8lbrg1Hcb0yH1AQQ4LQagk
 ujyxgiuwS1IrHuuUfgUeYgGrggR6ovd7I8bCIIjhMdW/jefpzmmkTTt3oWQgI6PefcN5
 7O6rD8H2YEITn6eM5gUDeeHYlfMwDo0NkQkP4F4lmaWnZSnqyyqAoMn3Rx4hTPVVqIzb
 UBgw==
X-Gm-Message-State: AOJu0YwlGFTpECRGhVovy2s2vVAlZ5bA6XQkWDRue+9kGeZiA4TzvvH7
 HtvtkF35LFkKaIoPYdLRdH9h8KAym2DlmzF+GZZaDNr2ndwV+d2OCRKSs3h5IMMm0XVvm4ltJNt
 d
X-Google-Smtp-Source: AGHT+IEyS9/Vl07fsmLu5muMa9uNvqiiOgLriqUbePm+YvLYrZyOKxpgn8HN+KQ9Q5IGzXJfUdK4eg==
X-Received: by 2002:a17:90a:f0c6:b0:29d:e0fc:b7a4 with SMTP id
 fa6-20020a17090af0c600b0029de0fcb7a4mr14485462pjb.22.1710748714694; 
 Mon, 18 Mar 2024 00:58:34 -0700 (PDT)
Received: from localhost ([157.82.200.213])
 by smtp.gmail.com with UTF8SMTPSA id
 w13-20020a17090ad60d00b0029baef194f7sm7080050pju.38.2024.03.18.00.58.32
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 18 Mar 2024 00:58:34 -0700 (PDT)
From: Akihiko Odaki <akihiko.odaki@daynix.com>
Date: Mon, 18 Mar 2024 16:58:13 +0900
Subject: [PATCH 1/2] ui/cocoa: Add cursor composition
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240318-cursor-v1-1-0bbe6c382217@daynix.com>
References: <20240318-cursor-v1-0-0bbe6c382217@daynix.com>
In-Reply-To: <20240318-cursor-v1-0-0bbe6c382217@daynix.com>
To: Paolo Bonzini <pbonzini@redhat.com>, 
 =?utf-8?q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>, 
 =?utf-8?q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>, 
 Thomas Huth <thuth@redhat.com>, 
 =?utf-8?q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>, 
 Peter Maydell <peter.maydell@linaro.org>, Gerd Hoffmann <kraxel@redhat.com>, 
 Dmitry Fleytman <dmitry.fleytman@gmail.com>
Cc: qemu-devel@nongnu.org, Akihiko Odaki <akihiko.odaki@daynix.com>
X-Mailer: b4 0.12.3
Received-SPF: none client-ip=2607:f8b0:4864:20::102b;
 envelope-from=akihiko.odaki@daynix.com; helo=mail-pj1-x102b.google.com
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

Add accelerated cursor composition to ui/cocoa. This does not only
improve performance for display devices that exposes the capability to
the guest according to dpy_cursor_define_supported(), but fixes the
cursor display for devices that unconditionally expects the availability
of the capability (e.g., virtio-gpu).

The common pattern to implement accelerated cursor composition is to
replace the cursor and warp it so that the replaced cursor is shown at
the correct position on the guest display. Unfortunately, ui/cocoa
cannot do the same because warping the cursor position interfers with
the mouse input so it uses CALayer instead; although it is not
specialized for cursor composition, it still can compose images with
hardware acceleration.

Signed-off-by: Akihiko Odaki <akihiko.odaki@daynix.com>
---
 meson.build |  3 +-
 ui/cocoa.m  | 97 +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 99 insertions(+), 1 deletion(-)

diff --git a/meson.build b/meson.build
index b375248a7614..b198ca2972ed 100644
--- a/meson.build
+++ b/meson.build
@@ -1044,7 +1044,8 @@ if get_option('attr').allowed()
   endif
 endif
 
-cocoa = dependency('appleframeworks', modules: ['Cocoa', 'CoreVideo'],
+cocoa = dependency('appleframeworks',
+                   modules: ['Cocoa', 'CoreVideo', 'QuartzCore'],
                    required: get_option('cocoa'))
 
 vmnet = dependency('appleframeworks', modules: 'vmnet', required: get_option('vmnet'))
diff --git a/ui/cocoa.m b/ui/cocoa.m
index fa879d7dcd4b..c13c2a01e947 100644
--- a/ui/cocoa.m
+++ b/ui/cocoa.m
@@ -25,6 +25,7 @@
 #include "qemu/osdep.h"
 
 #import <Cocoa/Cocoa.h>
+#import <QuartzCore/QuartzCore.h>
 #include <crt_externs.h>
 
 #include "qemu/help-texts.h"
@@ -92,12 +93,16 @@ static void cocoa_switch(DisplayChangeListener *dcl,
                          DisplaySurface *surface);
 
 static void cocoa_refresh(DisplayChangeListener *dcl);
+static void cocoa_mouse_set(DisplayChangeListener *dcl, int x, int y, int on);
+static void cocoa_cursor_define(DisplayChangeListener *dcl, QEMUCursor *cursor);
 
 static const DisplayChangeListenerOps dcl_ops = {
     .dpy_name          = "cocoa",
     .dpy_gfx_update = cocoa_update,
     .dpy_gfx_switch = cocoa_switch,
     .dpy_refresh = cocoa_refresh,
+    .dpy_mouse_set = cocoa_mouse_set,
+    .dpy_cursor_define = cocoa_cursor_define,
 };
 static DisplayChangeListener dcl = {
     .ops = &dcl_ops,
@@ -313,6 +318,11 @@ @interface QemuCocoaView : NSView
     BOOL isMouseGrabbed;
     BOOL isAbsoluteEnabled;
     CFMachPortRef eventsTap;
+    CALayer *cursorLayer;
+    QEMUCursor *cursor;
+    int mouseX;
+    int mouseY;
+    int mouseOn;
 }
 - (void) switchSurface:(pixman_image_t *)image;
 - (void) grabMouse;
@@ -365,6 +375,12 @@ - (id)initWithFrame:(NSRect)frameRect
 #if MAC_OS_X_VERSION_MAX_ALLOWED >= MAC_OS_VERSION_14_0
         [self setClipsToBounds:YES];
 #endif
+        [self setWantsLayer:YES];
+        cursorLayer = [[CALayer alloc] init];
+        [cursorLayer setAnchorPoint:CGPointMake(0, 1)];
+        [cursorLayer setAutoresizingMask:kCALayerMaxXMargin |
+                                         kCALayerMinYMargin];
+        [[self layer] addSublayer:cursorLayer];
 
     }
     return self;
@@ -445,6 +461,72 @@ - (void) unhideCursor
     [NSCursor unhide];
 }
 
+- (void)setMouseX:(int)x y:(int)y on:(int)on
+{
+    CGPoint position;
+
+    mouseX = x;
+    mouseY = y;
+    mouseOn = on;
+
+    position.x = mouseX;
+    position.y = screen.height - mouseY;
+
+    [CATransaction begin];
+    [CATransaction setDisableActions:YES];
+    [cursorLayer setPosition:position];
+    [cursorLayer setHidden:!mouseOn];
+    [CATransaction commit];
+}
+
+- (void)setCursor:(QEMUCursor *)given_cursor
+{
+    CGDataProviderRef provider;
+    CGImageRef image;
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
+    provider = CGDataProviderCreateWithData(
+        NULL,
+        cursor->data,
+        cursor->width * cursor->height * 4,
+        NULL
+    );
+
+    image = CGImageCreate(
+        cursor->width, //width
+        cursor->height, //height
+        8, //bitsPerComponent
+        32, //bitsPerPixel
+        cursor->width * 4, //bytesPerRow
+        CGColorSpaceCreateWithName(kCGColorSpaceSRGB), //colorspace
+        kCGBitmapByteOrder32Little | kCGImageAlphaFirst, //bitmapInfo
+        provider, //provider
+        NULL, //decode
+        0, //interpolate
+        kCGRenderingIntentDefault //intent
+    );
+
+    CGDataProviderRelease(provider);
+    [CATransaction begin];
+    [CATransaction setDisableActions:YES];
+    [cursorLayer setBounds:bounds];
+    [cursorLayer setContents:(id)image];
+    [CATransaction commit];
+    CGImageRelease(image);
+}
+
 - (void) drawRect:(NSRect) rect
 {
     COCOA_DEBUG("QemuCocoaView: drawRect\n");
@@ -1982,6 +2064,21 @@ static void cocoa_refresh(DisplayChangeListener *dcl)
     [pool release];
 }
 
+static void cocoa_mouse_set(DisplayChangeListener *dcl, int x, int y, int on)
+{
+    dispatch_async(dispatch_get_main_queue(), ^{
+        [cocoaView setMouseX:x y:y on:on];
+    });
+}
+
+static void cocoa_cursor_define(DisplayChangeListener *dcl, QEMUCursor *cursor)
+{
+    dispatch_async(dispatch_get_main_queue(), ^{
+        BQL_LOCK_GUARD();
+        [cocoaView setCursor:qemu_console_get_cursor(dcl->con)];
+    });
+}
+
 static void cocoa_display_init(DisplayState *ds, DisplayOptions *opts)
 {
     NSAutoreleasePool * pool = [[NSAutoreleasePool alloc] init];

-- 
2.44.0


