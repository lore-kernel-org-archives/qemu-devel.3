Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 72530C4829A
	for <qemu-devel@archiver.kernel.org>; Tue, 13 Feb 2024 12:01:37 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rZrTR-0002al-Lf; Tue, 13 Feb 2024 07:01:17 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1rZrTQ-0002Py-0C
 for qemu-devel@nongnu.org; Tue, 13 Feb 2024 07:01:16 -0500
Received: from mail-pj1-x1030.google.com ([2607:f8b0:4864:20::1030])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1rZrTL-0000tT-Ew
 for qemu-devel@nongnu.org; Tue, 13 Feb 2024 07:01:14 -0500
Received: by mail-pj1-x1030.google.com with SMTP id
 98e67ed59e1d1-290d59df3f0so3049627a91.2
 for <qemu-devel@nongnu.org>; Tue, 13 Feb 2024 04:01:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=daynix-com.20230601.gappssmtp.com; s=20230601; t=1707825670; x=1708430470;
 darn=nongnu.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=56ee4etfJA850s0p6g1ufFjFmjKUeH8d+LYXSx01txk=;
 b=L+kRfvtAarJi+4G32c9CLc8Tjb8L3QU6K7TXZlqiLQF+s4aM4ZS0HJoUCnBSwR9Zj2
 HC9Wj/jiIjCP1QrbG7sf1FrMOecDhfn3fyRlgPdJXGqgd9rQsr3eQDKKv2AxAlYJg4Ag
 k7EzlTwPrEWRwPeOsQ9COXnrN2hWXELvjDy8wT7j90CkwqnZk7765hs8Xv/rSKGZ0lpd
 wID6HdRJi7MBKfMdJ9geQrKgHsagru5NOpdcKWZcJFwiDIXZORndYy8FDb++1qVBAsGM
 AnXslR0BBwO45yMIzG5vlD7bTI7MeiepPFXynHKJYjZfHy5VMHUnNKmyIVVqW/tTs7rc
 7FJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1707825670; x=1708430470;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=56ee4etfJA850s0p6g1ufFjFmjKUeH8d+LYXSx01txk=;
 b=m6dnsnbi5Ppf6TkmKOPXO6co5f1X76XJ9cPvHPCd130JHYVIlSaWcufNJVGYWE7LDn
 RjfwbhhKXhh1bMuejxnnKQtMlPHN7TvlqeT0xUVYeQpgpeeuq7sYwl0m+Xqb3m+RMGis
 Ndnqx9zOzOeiiMY2gnaWUIeYiKdqaE4xzyEAvzAv2jfWp4mj/4QbRkwyA0w9oAPjV5f2
 cjbKYW+3tkpDt2Xv3qZwSrHgCjShRQMfQ/q2SxVmcqKSOFuAu3UQK09rQ6QIeoVf5Vc4
 Z42hII6Gc73eiKHmUlxbqvRqfbalB9zOrn2GO2CON09Kky1pBkPwRXR+2ZCIr7GNJ+77
 nSAQ==
X-Gm-Message-State: AOJu0YyZH3dOK9ZxhuZQexRIfnKX5aTFTn3TuL0a/+LfzhEWi0JfP2aD
 RyDUJOulfdEQnmFWN0HZ02shPUNVyDpvTS4C4nUsZXgfNChDETtFSmIqzsWb3sVIn//pSEoQkOM
 p
X-Google-Smtp-Source: AGHT+IGdKogM0T7mZDbx2nlvuAGd4uhS8fQBRjk5DxLlz7yao8yXGwPBQC2zV4yJtN68lI3iX6hMQw==
X-Received: by 2002:a17:90b:302:b0:296:f874:6844 with SMTP id
 ay2-20020a17090b030200b00296f8746844mr6610841pjb.15.1707825669127; 
 Tue, 13 Feb 2024 04:01:09 -0800 (PST)
X-Forwarded-Encrypted: i=1;
 AJvYcCWlLePxs+qSy7p1miBUnFsTOAUK78tsewba4w/RJp7BYMGqKC95wvpS2EV+l/lGX3lTNhiiaLnd1gHw0/f31t+mpqeB09Vievz5H5ISH7vFNQSf91flWTsdjjnZIWInHziZMsJPV1tqBzO6YyM/oeDA8/QtJ5ZWbJHTYZDsGPVHtyh+ve7BVlWvcZe1tp1DF+T2kvvoYRb9djKbD9WOwG6JCS4AaYT5rEC99ZS3sifL4sUGKaJyUsrbEpEfQKGA8HMdSMvVqmlILPtE
Received: from localhost ([157.82.207.134])
 by smtp.gmail.com with UTF8SMTPSA id
 s63-20020a17090a2f4500b00296f5a3de52sm2545778pjd.4.2024.02.13.04.01.07
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 13 Feb 2024 04:01:08 -0800 (PST)
From: Akihiko Odaki <akihiko.odaki@daynix.com>
Date: Tue, 13 Feb 2024 21:00:55 +0900
Subject: [PATCH v9 1/6] ui/cocoa: Release specific mouse buttons
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240213-cocoa-v9-1-d5a5e1bf0490@daynix.com>
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
Received-SPF: none client-ip=2607:f8b0:4864:20::1030;
 envelope-from=akihiko.odaki@daynix.com; helo=mail-pj1-x1030.google.com
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

ui/cocoa used to release all mouse buttons when it sees
NSEventTypeLeftMouseUp, NSEventTypeRightMouseUp, or
NSEventTypeOtherMouseUp, but it can instead release specific one
according to the delivered event.

Signed-off-by: Akihiko Odaki <akihiko.odaki@daynix.com>
---
 ui/cocoa.m | 132 ++++++++++++++++++++++++++-----------------------------------
 1 file changed, 55 insertions(+), 77 deletions(-)

diff --git a/ui/cocoa.m b/ui/cocoa.m
index eb99064beeb4..fe0eb74b0743 100644
--- a/ui/cocoa.m
+++ b/ui/cocoa.m
@@ -99,7 +99,6 @@ static void cocoa_switch(DisplayChangeListener *dcl,
 static DisplayChangeListener dcl = {
     .ops = &dcl_ops,
 };
-static int last_buttons;
 static int cursor_hide = 1;
 static int left_command_key_enabled = 1;
 static bool swap_opt_cmd;
@@ -801,8 +800,6 @@ - (bool) handleEventLocked:(NSEvent *)event
     COCOA_DEBUG("QemuCocoaView: handleEvent\n");
     int buttons = 0;
     int keycode = 0;
-    bool mouse_event = false;
-    // Location of event in virtual screen coordinates
     NSPoint p = [self screenLocationOfEvent:event];
     NSUInteger modifiers = [event modifierFlags];
 
@@ -883,25 +880,25 @@ - (bool) handleEventLocked:(NSEvent *)event
                     if (!!(modifiers & NSEventModifierFlagShift)) {
                         [self toggleKey:Q_KEY_CODE_SHIFT];
                     }
-                    break;
+                    return true;
 
                 case kVK_RightShift:
                     if (!!(modifiers & NSEventModifierFlagShift)) {
                         [self toggleKey:Q_KEY_CODE_SHIFT_R];
                     }
-                    break;
+                    return true;
 
                 case kVK_Control:
                     if (!!(modifiers & NSEventModifierFlagControl)) {
                         [self toggleKey:Q_KEY_CODE_CTRL];
                     }
-                    break;
+                    return true;
 
                 case kVK_RightControl:
                     if (!!(modifiers & NSEventModifierFlagControl)) {
                         [self toggleKey:Q_KEY_CODE_CTRL_R];
                     }
-                    break;
+                    return true;
 
                 case kVK_Option:
                     if (!!(modifiers & NSEventModifierFlagOption)) {
@@ -911,7 +908,7 @@ - (bool) handleEventLocked:(NSEvent *)event
                             [self toggleKey:Q_KEY_CODE_ALT];
                         }
                     }
-                    break;
+                    return true;
 
                 case kVK_RightOption:
                     if (!!(modifiers & NSEventModifierFlagOption)) {
@@ -921,7 +918,7 @@ - (bool) handleEventLocked:(NSEvent *)event
                             [self toggleKey:Q_KEY_CODE_ALT_R];
                         }
                     }
-                    break;
+                    return true;
 
                 /* Don't pass command key changes to guest unless mouse is grabbed */
                 case kVK_Command:
@@ -934,7 +931,7 @@ - (bool) handleEventLocked:(NSEvent *)event
                             [self toggleKey:Q_KEY_CODE_META_L];
                         }
                     }
-                    break;
+                    return true;
 
                 case kVK_RightCommand:
                     if (isMouseGrabbed &&
@@ -945,9 +942,11 @@ - (bool) handleEventLocked:(NSEvent *)event
                             [self toggleKey:Q_KEY_CODE_META_R];
                         }
                     }
-                    break;
+                    return true;
+
+                default:
+                    return true;
             }
-            break;
         case NSEventTypeKeyDown:
             keycode = cocoa_keycode_to_qemu([event keyCode]);
 
@@ -983,7 +982,7 @@ - (bool) handleEventLocked:(NSEvent *)event
             } else {
                 [self handleMonitorInput: event];
             }
-            break;
+            return true;
         case NSEventTypeKeyUp:
             keycode = cocoa_keycode_to_qemu([event keyCode]);
 
@@ -996,7 +995,7 @@ - (bool) handleEventLocked:(NSEvent *)event
             if (qemu_console_is_graphic(NULL)) {
                 qkbd_state_key_event(kbd, keycode, false);
             }
-            break;
+            return true;
         case NSEventTypeMouseMoved:
             if (isAbsoluteEnabled) {
                 // Cursor re-entered into a window might generate events bound to screen coordinates
@@ -1012,34 +1011,18 @@ - (bool) handleEventLocked:(NSEvent *)event
                     }
                 }
             }
-            mouse_event = true;
-            break;
+            return [self handleMouseEvent:event];
         case NSEventTypeLeftMouseDown:
-            buttons |= MOUSE_EVENT_LBUTTON;
-            mouse_event = true;
-            break;
+            return [self handleMouseEvent:event button:MOUSE_EVENT_LBUTTON down:true];
         case NSEventTypeRightMouseDown:
-            buttons |= MOUSE_EVENT_RBUTTON;
-            mouse_event = true;
-            break;
-        case NSEventTypeOtherMouseDown:
-            buttons |= MOUSE_EVENT_MBUTTON;
-            mouse_event = true;
-            break;
+            return [self handleMouseEvent:event button:MOUSE_EVENT_RBUTTON down:true];
         case NSEventTypeLeftMouseDragged:
-            buttons |= MOUSE_EVENT_LBUTTON;
-            mouse_event = true;
-            break;
+            return [self handleMouseEvent:event button:MOUSE_EVENT_LBUTTON down:true];
         case NSEventTypeRightMouseDragged:
-            buttons |= MOUSE_EVENT_RBUTTON;
-            mouse_event = true;
-            break;
+            return [self handleMouseEvent:event button:MOUSE_EVENT_RBUTTON down:true];
         case NSEventTypeOtherMouseDragged:
-            buttons |= MOUSE_EVENT_MBUTTON;
-            mouse_event = true;
-            break;
+            return [self handleMouseEvent:event button:MOUSE_EVENT_MBUTTON down:true];
         case NSEventTypeLeftMouseUp:
-            mouse_event = true;
             if (!isMouseGrabbed && [self screenContainsPoint:p]) {
                 /*
                  * In fullscreen mode, the window of cocoaView may not be the
@@ -1050,13 +1033,11 @@ - (bool) handleEventLocked:(NSEvent *)event
                     [self grabMouse];
                 }
             }
-            break;
+            return [self handleMouseEvent:event button:MOUSE_EVENT_LBUTTON down:false];
         case NSEventTypeRightMouseUp:
-            mouse_event = true;
-            break;
+            return [self handleMouseEvent:event button:MOUSE_EVENT_RBUTTON down:false];
         case NSEventTypeOtherMouseUp:
-            mouse_event = true;
-            break;
+            return [self handleMouseEvent:event button:MOUSE_EVENT_MBUTTON down:false];
         case NSEventTypeScrollWheel:
             /*
              * Send wheel events to the guest regardless of window focus.
@@ -1087,52 +1068,49 @@ - (bool) handleEventLocked:(NSEvent *)event
              * Since deltaX/deltaY also report scroll wheel events we prevent mouse
              * movement code from executing.
              */
-            mouse_event = false;
-            break;
+            return true;
         default:
             return false;
     }
+}
+
+- (bool) handleMouseEvent:(NSEvent *)event
+{
+    if (!isMouseGrabbed) {
+        return false;
+    }
 
-    if (mouse_event) {
-        /* Don't send button events to the guest unless we've got a
-         * mouse grab or window focus. If we have neither then this event
-         * is the user clicking on the background window to activate and
-         * bring us to the front, which will be done by the sendEvent
-         * call below. We definitely don't want to pass that click through
-         * to the guest.
+    if (isAbsoluteEnabled) {
+        NSPoint p = [self screenLocationOfEvent:event];
+        /* Note that the origin for Cocoa mouse coords is bottom left, not top left.
+         * The check on screenContainsPoint is to avoid sending out of range values for
+         * clicks in the titlebar.
          */
-        if ((isMouseGrabbed || [[self window] isKeyWindow]) &&
-            (last_buttons != buttons)) {
-            static uint32_t bmap[INPUT_BUTTON__MAX] = {
-                [INPUT_BUTTON_LEFT]       = MOUSE_EVENT_LBUTTON,
-                [INPUT_BUTTON_MIDDLE]     = MOUSE_EVENT_MBUTTON,
-                [INPUT_BUTTON_RIGHT]      = MOUSE_EVENT_RBUTTON
-            };
-            qemu_input_update_buttons(dcl.con, bmap, last_buttons, buttons);
-            last_buttons = buttons;
-        }
-        if (isMouseGrabbed) {
-            if (isAbsoluteEnabled) {
-                /* Note that the origin for Cocoa mouse coords is bottom left, not top left.
-                 * The check on screenContainsPoint is to avoid sending out of range values for
-                 * clicks in the titlebar.
-                 */
-                if ([self screenContainsPoint:p]) {
-                    qemu_input_queue_abs(dcl.con, INPUT_AXIS_X, p.x, 0, screen.width);
-                    qemu_input_queue_abs(dcl.con, INPUT_AXIS_Y, screen.height - p.y, 0, screen.height);
-                }
-            } else {
-                qemu_input_queue_rel(dcl.con, INPUT_AXIS_X, (int)[event deltaX]);
-                qemu_input_queue_rel(dcl.con, INPUT_AXIS_Y, (int)[event deltaY]);
-            }
-        } else {
-            return false;
+        if ([self screenContainsPoint:p]) {
+            qemu_input_queue_abs(dcl.con, INPUT_AXIS_X, p.x, 0, screen.width);
+            qemu_input_queue_abs(dcl.con, INPUT_AXIS_Y, screen.height - p.y, 0, screen.height);
         }
-        qemu_input_event_sync();
+    } else {
+        qemu_input_queue_rel(dcl.con, INPUT_AXIS_X, (int)[event deltaX]);
+        qemu_input_queue_rel(dcl.con, INPUT_AXIS_Y, (int)[event deltaY]);
     }
+
+    qemu_input_event_sync();
+
     return true;
 }
 
+- (bool) handleMouseEvent:(NSEvent *)event button:(InputButton)button down:(bool)down
+{
+    if (!isMouseGrabbed && ![[self window] isKeyWindow]) {
+        return false;
+    }
+
+    qemu_input_queue_btn(dcl.con, button, down);
+
+    return [self handleMouseEvent:event];
+}
+
 - (void) grabMouse
 {
     COCOA_DEBUG("QemuCocoaView: grabMouse\n");

-- 
2.43.0


