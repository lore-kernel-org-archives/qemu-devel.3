Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BDDFAC25B76
	for <qemu-devel@archiver.kernel.org>; Sat,  8 Jun 2024 20:21:30 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sG2Z3-0000sJ-Vf; Sat, 08 Jun 2024 16:21:26 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <phil@philjordan.eu>)
 id 1sG2Z2-0000qh-KH
 for qemu-devel@nongnu.org; Sat, 08 Jun 2024 16:21:24 -0400
Received: from mail-wm1-x330.google.com ([2a00:1450:4864:20::330])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <phil@philjordan.eu>)
 id 1sG2Z0-0006b7-FB
 for qemu-devel@nongnu.org; Sat, 08 Jun 2024 16:21:24 -0400
Received: by mail-wm1-x330.google.com with SMTP id
 5b1f17b1804b1-421798185f0so8560435e9.1
 for <qemu-devel@nongnu.org>; Sat, 08 Jun 2024 13:21:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=philjordan-eu.20230601.gappssmtp.com; s=20230601; t=1717878080; x=1718482880;
 darn=nongnu.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Dxl23C1D5XzzTzk0m+i0wmEqonXMUbdqpGsXRiYEAFg=;
 b=YHCn/zd1nhjc6ypUPqdcfVbCjrmFvS5F4HiYzsy52V3RgbT0jmqZnQVZ5nmWTOJ53o
 FJOAmWaL9N7+ZVaHdpffGoQybqwm9hzkwiIVj/OMqtnn5TFyvT3M7c5mw1V9Tge73PTa
 AYyG1WqoNnVeoPgzGa0+8peSLKeXBBSpFn58d0OMonfW4j+k7m2dSAd6FAUU1UeLmzNt
 +y7GlVRf4jdJpvMl841gTGAbtogkEZz+B5gkmwkmoq1svpd4F+7i+rBOyTVY7iL5oOEH
 znSGkRKfpGuX7kvsmW+Q5UoNIQT4M2JLqzNfB6R0/LMdvP0uhYhaovug/4dC7O0tV/r0
 zRrA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1717878080; x=1718482880;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Dxl23C1D5XzzTzk0m+i0wmEqonXMUbdqpGsXRiYEAFg=;
 b=ZM9Dg5MpSKzWG7MoLc9yU8N/hRtojmfYZ3nmmn4Vyz4k8ljlwekclnwEfx6nbEJDN4
 sPqkujwd465k+C0rji/A2VevkXxOInz2Vh2KuVBCGFOXXgtqIo4Xk1eKblFDd8oDcGaM
 fc7dNE3FbG13FV9LDFc18Yz9LD3NpOk63Br7mWww3u/P8C+CI/rAjqT2ic3alaO9xboj
 AViyFoJE11GTMuQ5L+62YBytsyVzUW6quGzpFQAlkoc5p01Z4VAjykPkCkKxfqiW8qkH
 C52NocPleDSno8dCFYwEGE/G+alanVjbjTcOHGd27uFvzD+rdeNpZp7DpxJb7HlUy+Fl
 PY9w==
X-Gm-Message-State: AOJu0YyQzSHOkI8UllcRXmbFJ4vjg+nf+a6fDXhuT9202yrTtVTulHOB
 n4z0jUNAzshbk/Pm9zhiNBm7UaLKPmPippwPWhuRVdoueFHYvwJN2FnySSQeBWVsOpJNB9qslAg
 =
X-Google-Smtp-Source: AGHT+IHoNjyzlUraKjTkqG0iB21jvsxx/ijmNIf4UkvN28ua/dQ+XNXoqG5lfy29LG/wKzYmmCEFAw==
X-Received: by 2002:adf:fc85:0:b0:35b:5a14:984a with SMTP id
 ffacd0b85a97d-35efee03d4fmr3691525f8f.56.1717878080206; 
 Sat, 08 Jun 2024 13:21:20 -0700 (PDT)
Received: from localhost.localdomain (89-104-8-17.customer.bnet.at.
 [89.104.8.17]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-35f0ccc5f03sm3803845f8f.88.2024.06.08.13.21.19
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 08 Jun 2024 13:21:19 -0700 (PDT)
From: Phil Dennis-Jordan <phil@philjordan.eu>
To: qemu-devel@nongnu.org
Cc: peter.maydell@linaro.org, philmd@linaro.org, akihiko.odaki@daynix.com,
 marcandre.lureau@redhat.com, Phil Dennis-Jordan <phil@philjordan.eu>
Subject: [PATCH 3/3] ui/cocoa: Adds support for mouse cursors
Date: Sat,  8 Jun 2024 22:20:45 +0200
Message-Id: <20240608202045.2815-4-phil@philjordan.eu>
X-Mailer: git-send-email 2.36.1
In-Reply-To: <20240608202045.2815-1-phil@philjordan.eu>
References: <20240608202045.2815-1-phil@philjordan.eu>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: neutral client-ip=2a00:1450:4864:20::330;
 envelope-from=phil@philjordan.eu; helo=mail-wm1-x330.google.com
X-Spam_score_int: -10
X-Spam_score: -1.1
X-Spam_bar: -
X-Spam_report: (-1.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_NEUTRAL=0.779, T_SCC_BODY_TEXT_LINE=-0.01 autolearn=no autolearn_force=no
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

This change implements the callbacks dpy_cursor_define and dpy_mouse_set
for the Cocoa UI. The incoming mouse cursor image is converted into an
NSCursor object, allowing the guest mouse cursor to be rendered as the
host's native OS cursor on macOS.

This is straightforward in absolute pointing mode, but rather trickier
with a relative pointing device:

 1. The cursor position in Qemu's coordinate system must be translated
    and converted into macOS's Core Graphics/Quartz coordinates when
    positioning the cursor. Additionally, the position already includes
    the hotspot offset; we'd prefer to use the host OS's hotspot support
    so we need subtract the hotspot vector off again.
 2. Setting the cursor position programmatically on macOS biases the
    next mouse movement event by the amount the cursor was shifted.
    If we didn't reverse that bias when forwarding the next event
    back into Qemu's input stack, this would create a feedback loop.
    (The behaviour of affecting mouse events makes sense for e.g.
    setting the cursor position in a remote access system.)

This change slightly improves the user experience when using virtual
display adapter implementations which check for UI back-end cursor
support, and fixes the issue of no visible mouse cursor when using one
which does not. (Such as virtio-vga)

Signed-off-by: Phil Dennis-Jordan <phil@philjordan.eu>
---
 ui/cocoa.m      | 167 +++++++++++++++++++++++++++++++++++++++++++++++-
 ui/trace-events |   7 ++
 2 files changed, 171 insertions(+), 3 deletions(-)

diff --git a/ui/cocoa.m b/ui/cocoa.m
index 981615a8b9..0c71533835 100644
--- a/ui/cocoa.m
+++ b/ui/cocoa.m
@@ -49,6 +49,7 @@
 #include "qemu/error-report.h"
 #include <Carbon/Carbon.h>
 #include "hw/core/cpu.h"
+#include "trace.h"
 
 #ifndef MAC_OS_VERSION_14_0
 #define MAC_OS_VERSION_14_0 140000
@@ -80,11 +81,17 @@ static void cocoa_switch(DisplayChangeListener *dcl,
 
 static void cocoa_refresh(DisplayChangeListener *dcl);
 
+static void cocoa_cursor_define(DisplayChangeListener *dcl, QEMUCursor *cursor);
+
+static void cocoa_mouse_set(DisplayChangeListener *dcl, int x, int y, int on);
+
 static const DisplayChangeListenerOps dcl_ops = {
     .dpy_name          = "cocoa",
     .dpy_gfx_update = cocoa_update,
     .dpy_gfx_switch = cocoa_switch,
     .dpy_refresh = cocoa_refresh,
+    .dpy_cursor_define = cocoa_cursor_define,
+    .dpy_mouse_set = cocoa_mouse_set,
 };
 static DisplayChangeListener dcl = {
     .ops = &dcl_ops,
@@ -299,6 +306,11 @@ @interface QemuCocoaView : NSView
     BOOL isMouseGrabbed;
     BOOL isAbsoluteEnabled;
     CFMachPortRef eventsTap;
+    NSCursor *current_cursor;
+    int cursor_hot_x;
+    int cursor_hot_y;
+    int offset_delta_x;
+    int offset_delta_y;
 }
 - (void) switchSurface:(pixman_image_t *)image;
 - (void) grabMouse;
@@ -320,6 +332,9 @@ - (BOOL) isMouseGrabbed;
 - (BOOL) isAbsoluteEnabled;
 - (QEMUScreen) gscreen;
 - (void) raiseAllKeys;
+- (void) setCursor:(NSCursor*)newCursor hotspotX:(int)hotX y:(int)hotY;
+- (void) setMouseX:(int)x y:(int)y showCursor:(BOOL)showCursor;
+
 @end
 
 QemuCocoaView *cocoaView;
@@ -376,6 +391,9 @@ - (void) dealloc
         pixman_image_unref(pixman_image);
     }
 
+    [self->current_cursor release];
+    self->current_cursor = nil;
+
     if (eventsTap) {
         CFRelease(eventsTap);
     }
@@ -407,6 +425,68 @@ - (void) selectConsoleLocked:(unsigned int)index
     [self updateUIInfo];
 }
 
+- (void) setCursor:(NSCursor*)newCursor hotspotX:(int)hotX y:(int)hotY
+{
+    [self->current_cursor release];
+    [newCursor retain];
+    self->current_cursor = newCursor;
+
+    cocoaView->cursor_hot_x = hotX;
+    cocoaView->cursor_hot_y = hotY;
+
+    [self.window invalidateCursorRectsForView:self];
+}
+
+- (void) resetCursorRects
+{
+    if (self->current_cursor == nil) {
+        [super resetCursorRects];
+    } else {
+        [self addCursorRect:NSMakeRect(0.0, 0.0, self->screen.width, self->screen.height) cursor:self->current_cursor];
+    }
+}
+
+- (void) setMouseX:(int)x y:(int)y showCursor:(BOOL)showCursor
+{
+    if (isAbsoluteEnabled) {
+        offset_delta_x = 0;
+        offset_delta_y = 0;
+        return;
+    } else if (!isMouseGrabbed) {
+        return;
+    }
+
+    NSWindow* window = [self window];
+
+    /* Coordinates seem to come in already offset by hotspot; undo that. Also
+     * avoid out-of-window coordinates. */
+    x += cursor_hot_x;
+    y += cursor_hot_y;
+    x = int_clamp(x, 0, screen.width);
+    y = int_clamp(y, 0, screen.height);
+    /* Flip coordinates so origin is bottom left (Cocoa), not top left (Qemu),
+     * before translating into window and then desktop coordinate systems. */
+    y = screen.height - y;
+
+    NSPoint new_pos_window = [self convertPoint:NSMakePoint(x, y) toView:nil];
+    NSPoint prev_pos_window = window.mouseLocationOutsideOfEventStream;
+
+    CGPoint screen_pos = [window convertPointToScreen:new_pos_window];
+
+    /* Translate from Cocoa (origin: main screen bottom left, +y up)
+     * to Quartz (origin: top left, +y down) coordinate system. */
+    screen_pos.y = NSScreen.mainScreen.frame.size.height - screen_pos.y;
+
+    /* Warp moves the host cursor to the new position. This doesn't generate a
+     * spurious move event, but it does offset the delta for next genuine event,
+     * which we need to take into account when that event comes in. */
+    CGWarpMouseCursorPosition(screen_pos);
+
+    offset_delta_x += (prev_pos_window.x - new_pos_window.x);
+    /* -ve due to Cocoa -> Qemu/Quartz Y axis conversion: */
+    offset_delta_y -= (prev_pos_window.y - new_pos_window.y);
+}
+
 - (void) hideCursor
 {
     if (!cursor_hide) {
@@ -1005,9 +1085,21 @@ - (void) handleMouseEvent:(NSEvent *)event
             /* Note that the origin for Cocoa mouse coords is bottom left, not top left. */
             qemu_input_queue_abs(dcl.con, INPUT_AXIS_X, p.x * d, 0, screen.width);
             qemu_input_queue_abs(dcl.con, INPUT_AXIS_Y, screen.height - p.y * d, 0, screen.height);
+            trace_cocoa_handle_mouse_event_absolute(p.x, p.y, screen.width, screen.height, p.x * d, screen.height - p.y * d);
         } else {
-            qemu_input_queue_rel(dcl.con, INPUT_AXIS_X, [event deltaX]);
-            qemu_input_queue_rel(dcl.con, INPUT_AXIS_Y, [event deltaY]);
+            /* Programmatically moving the Cocoa mouse cursor also offsets the
+             * next mouse event, so we offset by the amount we moved the cursor
+             * to avoid a feedback loop. */
+            int delta_x = [event deltaX] + offset_delta_x;
+            int delta_y = [event deltaY] + offset_delta_y;
+            trace_cocoa_handle_mouse_event_relative(
+                [event deltaX], [event deltaY],
+                offset_delta_x, offset_delta_y,
+                delta_x, delta_y);
+            qemu_input_queue_rel(dcl.con, INPUT_AXIS_X, /*[event deltaX]/*/delta_x/**/);
+            qemu_input_queue_rel(dcl.con, INPUT_AXIS_Y, /*[event deltaY]/*/delta_y/**/);
+            offset_delta_x = 0;
+            offset_delta_y = 0;
         }
 
         qemu_input_event_sync();
@@ -1084,19 +1176,26 @@ - (void) otherMouseUp:(NSEvent *)event
 
 - (void) grabMouse
 {
+    trace_cocoa_grab_mouse();
     COCOA_DEBUG("QemuCocoaView: grabMouse\n");
 
     if (qemu_name)
         [[self window] setTitle:[NSString stringWithFormat:@"QEMU %s - (Press  " UC_CTRL_KEY " " UC_ALT_KEY " G  to release Mouse)", qemu_name]];
     else
         [[self window] setTitle:@"QEMU - (Press  " UC_CTRL_KEY " " UC_ALT_KEY " G  to release Mouse)"];
-    [self hideCursor];
+
+    if (current_cursor == nil) {
+        [self hideCursor];
+    }
     CGAssociateMouseAndMouseCursorPosition(isAbsoluteEnabled);
     isMouseGrabbed = TRUE; // while isMouseGrabbed = TRUE, QemuCocoaApp sends all events to [cocoaView handleEvent:]
+    offset_delta_x = 0;
+    offset_delta_y = 0;
 }
 
 - (void) ungrabMouse
 {
+    trace_cocoa_ungrab_mouse();
     COCOA_DEBUG("QemuCocoaView: ungrabMouse\n");
 
     if (qemu_name)
@@ -1104,6 +1203,11 @@ - (void) ungrabMouse
     else
         [[self window] setTitle:@"QEMU"];
     [self unhideCursor];
+
+    if (current_cursor == nil) {
+        [self unhideCursor];
+    }
+
     CGAssociateMouseAndMouseCursorPosition(TRUE);
     isMouseGrabbed = FALSE;
     [self raiseAllButtons];
@@ -2000,6 +2104,63 @@ static void cocoa_refresh(DisplayChangeListener *dcl)
     [pool release];
 }
 
+static NSImage *cocoa_create_image_argb32(size_t width, size_t height, const void *pixel_data)
+{
+    size_t buffer_size = width * height * 4lu;
+    CGDataProviderRef provider = CGDataProviderCreateWithData(
+        NULL, pixel_data, buffer_size, NULL);
+    size_t bpc = 8;
+    size_t bpp = 32;
+    size_t bytes_per_row = 4u * width;
+    CGColorSpaceRef color_space = CGColorSpaceCreateDeviceRGB();
+    CGBitmapInfo bitmap_info =
+        kCGBitmapByteOrder32Little | kCGImageAlphaFirst;
+    CGColorRenderingIntent intent = kCGRenderingIntentDefault;
+
+    CGImageRef cg_image = CGImageCreate(
+        width,
+        height,
+        bpc,
+        bpp,
+        bytes_per_row,
+        color_space,
+        bitmap_info,
+        provider,
+        NULL,       // decode
+        YES,        // should interpolate
+        intent);
+
+    NSImage *image = [[NSImage alloc] initWithCGImage:cg_image size:NSMakeSize(width, height)];
+    CGImageRelease(cg_image);
+    CGColorSpaceRelease(color_space);
+    CGDataProviderRelease(provider);
+    return image;
+}
+
+static void cocoa_cursor_define(DisplayChangeListener *dcl, QEMUCursor *cursor)
+{
+    NSImage *cursor_image = nil;
+    NSPoint hotspot = { cursor->hot_x, cursor->hot_y };
+    trace_cocoa_cursor_define(cursor->hot_x, cursor->hot_y,
+                              cursor->width, cursor->height);
+    if (cursor == NULL || cursor->width <= 0 || cursor->height <= 0) {
+        cursor_image = [[NSImage alloc] initWithSize:NSMakeSize(1.0, 1.0)];
+    } else {
+        cursor_image = cocoa_create_image_argb32(cursor->width, cursor->height,
+                                                 cursor->data);
+    }
+    NSCursor *cocoa_cursor =
+        [[NSCursor alloc] initWithImage:cursor_image hotSpot:hotspot];
+    [cursor_image release];
+    [cocoaView setCursor:cocoa_cursor hotspotX:cursor->hot_x y:cursor->hot_y];
+    [cocoa_cursor release];
+}
+
+static void cocoa_mouse_set(DisplayChangeListener *dcl, int x, int y, int on)
+{
+    [cocoaView setMouseX:x y:y showCursor:(on != 0)];
+}
+
 static void cocoa_display_init(DisplayState *ds, DisplayOptions *opts)
 {
     NSAutoreleasePool * pool = [[NSAutoreleasePool alloc] init];
diff --git a/ui/trace-events b/ui/trace-events
index 69ff22955d..e53601693d 100644
--- a/ui/trace-events
+++ b/ui/trace-events
@@ -166,3 +166,10 @@ dbus_filter(unsigned int serial, unsigned int filter) "serial=%u (<= %u)"
 
 # egl-helpers.c
 egl_init_d3d11_device(void *p) "d3d device: %p"
+
+# cocoa.m
+cocoa_cursor_define(int hot_x, int hot_y, uint16_t width, uint16_t height) "Cursor hotspot: (%d, %d), size: %" PRIu16 "x%" PRIu16
+cocoa_grab_mouse(void) ""
+cocoa_ungrab_mouse(void) ""
+cocoa_handle_mouse_event_relative(int raw_dx, int raw_dy, int offset_dx, int offset_dy, int net_dx, int net_dy) "raw delta: %d, %d; offset for delta: %d, %d; net delta: %d, %d"
+cocoa_handle_mouse_event_absolute(int event_x, int event_y, int screen_width, int screen_height, int window_x, int window_y) "event: %d, %d; screen: %d x %d; position: %d, %d"
-- 
2.36.1


