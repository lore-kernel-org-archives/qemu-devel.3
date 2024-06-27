Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ADF9BC2BD09
	for <qemu-devel@archiver.kernel.org>; Thu, 27 Jun 2024 11:18:44 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sMn8b-0004Ei-0H; Thu, 27 Jun 2024 07:18:01 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1sMn8X-0004EU-67
 for qemu-devel@nongnu.org; Thu, 27 Jun 2024 07:17:57 -0400
Received: from mail-pl1-x62c.google.com ([2607:f8b0:4864:20::62c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1sMn8V-0000Sc-Ao
 for qemu-devel@nongnu.org; Thu, 27 Jun 2024 07:17:56 -0400
Received: by mail-pl1-x62c.google.com with SMTP id
 d9443c01a7336-1f9b364faddso62604395ad.3
 for <qemu-devel@nongnu.org>; Thu, 27 Jun 2024 04:17:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=daynix-com.20230601.gappssmtp.com; s=20230601; t=1719487073; x=1720091873;
 darn=nongnu.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=7M6buw52eZMZE8chSs+8yqu1mcRqVq2tRe1GuSt0QPw=;
 b=ENhlH3lFFVMznk990+gpmD/A+Dld4jV89yrb+uVEfQxjH1CA2X/6bHNtHzUXYXl0rX
 qplit2tiJqBTpC1dFkDoLE5CsaQVlouU5kZG935NbCZ9uVTb2L/uWJeIBS84+Ed4GI+D
 a32Jk0cslYBNcCzk5pSv2XDep1I11J4kC8IrOiZYB9RCVDt0MgBjq0a7zaGxqnW5Zhw9
 ubZY6MgOB0un4V/b0dIJHLY0cd1/qtHD7G4Tqt3Z9PxIO2k7tM/c6m/Sg7EiOW2TeyxX
 hok0T0ov0rHbOEbD2ecLZZFhvL7GI+u5ni+JUXrKo3/cz8wmSGVcpMSd+CUyHloBCT/2
 HVKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1719487073; x=1720091873;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=7M6buw52eZMZE8chSs+8yqu1mcRqVq2tRe1GuSt0QPw=;
 b=XIvQF0l/x/0kMukiwkPOddjqVos/t40T8thF5zm4Gxo7p8JCgNZfhGTDLrCJQIKBqN
 yqHLVU/F8DK1IveXBs72YxvLOe8OzQazz3q3ybAkdIypDzsPquLIUzsvO1CfwlPwZN3e
 Z5LI20nGB7J+b5VgMO/76yxNLkwDphprYcx4NJMKYXlP/pARm4U/pTNKhLGKkg0w8G5r
 3+gltDtwgKFInea5VL3VqGn2RMt190JweX3k9KUfDuPKc0V1Lp0sub1f7UwyLKroa+yb
 THRjkFbANCu1/R8KxDNir24DqAUvC6PSFz8EFGIs5uh+dH27VpuO9OCsi7E4lNFhIFLG
 DoaA==
X-Gm-Message-State: AOJu0YwvnN44SzMZANtQlNsSQ8sIF7960RdAlVRtrepUW+ustlSI0l8Z
 m9YyI9j29P4s+S2pnLA8DqF4xQXpJLcVVCRaG/fwuJf8mgNtPWXNrwEufNN9hJTQUe4u8fhah3U
 AEbw=
X-Google-Smtp-Source: AGHT+IGr3FR59n6Xaeo/BB3X3NuDgvjAscr5jqWPD62MeN1pL0Kl7F/Hsb9R5XRcH/7kFpeyQYLPhA==
X-Received: by 2002:a17:902:e5c1:b0:1f9:df83:8ab2 with SMTP id
 d9443c01a7336-1fa240c518bmr164304535ad.58.1719487073353; 
 Thu, 27 Jun 2024 04:17:53 -0700 (PDT)
Received: from localhost ([157.82.204.135])
 by smtp.gmail.com with UTF8SMTPSA id
 d9443c01a7336-1faac8df839sm10992895ad.52.2024.06.27.04.17.50
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 27 Jun 2024 04:17:53 -0700 (PDT)
From: Akihiko Odaki <akihiko.odaki@daynix.com>
Date: Thu, 27 Jun 2024 20:17:35 +0900
Subject: [PATCH v2 3/4] ui/cocoa: Add cursor composition
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240627-cursor-v2-3-c3cd3ee35616@daynix.com>
References: <20240627-cursor-v2-0-c3cd3ee35616@daynix.com>
In-Reply-To: <20240627-cursor-v2-0-c3cd3ee35616@daynix.com>
To: Paolo Bonzini <pbonzini@redhat.com>, 
 =?utf-8?q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>, 
 =?utf-8?q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>, 
 Thomas Huth <thuth@redhat.com>, 
 =?utf-8?q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>, 
 Peter Maydell <peter.maydell@linaro.org>, Gerd Hoffmann <kraxel@redhat.com>, 
 Dmitry Fleytman <dmitry.fleytman@gmail.com>, 
 Phil Dennis-Jordan <phil@philjordan.eu>
Cc: qemu-devel@nongnu.org, Akihiko Odaki <akihiko.odaki@daynix.com>
X-Mailer: b4 0.14-dev-fd6e3
Received-SPF: none client-ip=2607:f8b0:4864:20::62c;
 envelope-from=akihiko.odaki@daynix.com; helo=mail-pl1-x62c.google.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_NONE=0.001 autolearn=ham autolearn_force=no
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
the correct position on the guest display for relative pointer devices.
Unfortunately, ui/cocoa cannot do the same because warping the cursor
position interfers with the mouse input so it uses CALayer instead;
although it is not specialized for cursor composition, it still can
compose images with hardware acceleration.

Co-authored-by: Phil Dennis-Jordan <phil@philjordan.eu>
Signed-off-by: Akihiko Odaki <akihiko.odaki@daynix.com>
---
 meson.build |  3 +-
 ui/cocoa.m  | 99 +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 101 insertions(+), 1 deletion(-)

diff --git a/meson.build b/meson.build
index 638660714455..59cc1fb8bcfc 100644
--- a/meson.build
+++ b/meson.build
@@ -1041,7 +1041,8 @@ if get_option('attr').allowed()
   endif
 endif
 
-cocoa = dependency('appleframeworks', modules: ['Cocoa', 'CoreVideo'],
+cocoa = dependency('appleframeworks',
+                   modules: ['Cocoa', 'CoreVideo', 'QuartzCore'],
                    required: get_option('cocoa'))
 
 vmnet = dependency('appleframeworks', modules: 'vmnet', required: get_option('vmnet'))
diff --git a/ui/cocoa.m b/ui/cocoa.m
index 908454a434c5..0dcd1923bfb3 100644
--- a/ui/cocoa.m
+++ b/ui/cocoa.m
@@ -25,6 +25,7 @@
 #include "qemu/osdep.h"
 
 #import <Cocoa/Cocoa.h>
+#import <QuartzCore/QuartzCore.h>
 #include <crt_externs.h>
 
 #include "qemu/help-texts.h"
@@ -79,12 +80,16 @@ static void cocoa_switch(DisplayChangeListener *dcl,
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
@@ -300,6 +305,11 @@ @interface QemuCocoaView : NSView
     BOOL isAbsoluteEnabled;
     CFMachPortRef eventsTap;
     CGColorSpaceRef colorspace;
+    CALayer *cursorLayer;
+    QEMUCursor *cursor;
+    int mouseX;
+    int mouseY;
+    bool mouseOn;
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
@@ -383,6 +399,8 @@ - (void) dealloc
     }
 
     CGColorSpaceRelease(colorspace);
+    [cursorLayer release];
+    cursor_unref(cursor);
     [super dealloc];
 }
 
@@ -426,6 +444,72 @@ - (void) unhideCursor
     [NSCursor unhide];
 }
 
+- (void)setMouseX:(int)x y:(int)y on:(bool)on
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
+        colorspace, //colorspace
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
@@ -2003,6 +2087,21 @@ static void cocoa_refresh(DisplayChangeListener *dcl)
     [pool release];
 }
 
+static void cocoa_mouse_set(DisplayChangeListener *dcl, int x, int y, bool on)
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
2.45.2


