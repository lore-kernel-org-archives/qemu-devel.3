Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5FFA8C54E49
	for <qemu-devel@archiver.kernel.org>; Sat, 24 Feb 2024 12:45:14 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rdrNd-00024t-DB; Sat, 24 Feb 2024 07:43:49 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1rdrNc-00024E-2m
 for qemu-devel@nongnu.org; Sat, 24 Feb 2024 07:43:48 -0500
Received: from mail-pg1-x52c.google.com ([2607:f8b0:4864:20::52c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1rdrNa-0006n5-DL
 for qemu-devel@nongnu.org; Sat, 24 Feb 2024 07:43:47 -0500
Received: by mail-pg1-x52c.google.com with SMTP id
 41be03b00d2f7-5cfd95130c6so769004a12.1
 for <qemu-devel@nongnu.org>; Sat, 24 Feb 2024 04:43:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=daynix-com.20230601.gappssmtp.com; s=20230601; t=1708778625; x=1709383425;
 darn=nongnu.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=GG87OFLhC3noDXFr+Lno/CpVrGOAWm4AVgErsmIKfbI=;
 b=hY7fEoXBSBHVGVbDq3+C2Sy4A6yBIwhMeUx9BdYIUOdCbBXLoSyGMoGZpfgluY6EDt
 r5xbUGu9qQ7GDTv44octgzg3eGNYHUCgDaJezyVhfkOMSjCUHfZpXxBI5T4658SfK2hP
 Z28nbxcmChQoUFnnrD1lHZvo6z6reMBUT6rU9EePaR+HHAsg8ApNeYBwYXUo3c0u+kDS
 qhxxvXCBlQtRlB0OEzshSj3ZorpK2jfbL6kBfzam/+89SzI9Hv4yeMa3bwUsDqN6V/2h
 mOdzDygvZe/AjfHKYFEQOY4Vu0WturlUQ91Xx6HJcugKm4uRSIjRtxJsGMSgPGY7wTEn
 +DkQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1708778625; x=1709383425;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=GG87OFLhC3noDXFr+Lno/CpVrGOAWm4AVgErsmIKfbI=;
 b=dRmWQgGtbhJe65y6VoCP0/BJohI4KZpY2Ea1lvpOMgvnBi1W6pWoi7Fy0QXEu7TOpv
 bvTa96tBbv1a6WhsPRhGh0FuFzo9+NcYGpcP7LBlzWF+BDUM71foJ++Uex6DVep38wqS
 xGxq3a5YOp2BlZMnB9fkx3kln72NExId7a9+8f9XscijviQA8W9HCkICo/yb6fUuvZAE
 EZEwwTaXnZBVrrbYvfUxAL7Z8sRnmdYEzVztNVdrX5OHAPH+ke2oKEXiPz/ayM4FSgFt
 tObr01SC2u0K6kkIjpgzseztXi4EQYPt2FZGHS8Aat6afUErNoLRlrIOCmB5S5hEgKai
 CzhQ==
X-Gm-Message-State: AOJu0YyEBV4Utx1Lte9HTbrzON1pswG2zHNsvnbAUW+AkO1wVYlqcSPk
 ZtzuKBQpTLJ8vOeK4mYO/zkBi8v86ywO4nQNC43mp+EN/7b2fAlGsAyb9l+J6+LXSlM3qMJajMi
 n
X-Google-Smtp-Source: AGHT+IHLiIGBQezQQBfLFKZz7e/D00/30rQFx0ybNZddasXRaa4lW7sheBPLt4Hzhj0gsDGNrJv7Jw==
X-Received: by 2002:a17:90b:358b:b0:299:544c:4933 with SMTP id
 mm11-20020a17090b358b00b00299544c4933mr2015676pjb.14.1708778624815; 
 Sat, 24 Feb 2024 04:43:44 -0800 (PST)
Received: from localhost ([157.82.203.206])
 by smtp.gmail.com with UTF8SMTPSA id
 p1-20020a17090ac00100b0029969cc66f2sm1143862pjt.48.2024.02.24.04.43.42
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sat, 24 Feb 2024 04:43:44 -0800 (PST)
From: Akihiko Odaki <akihiko.odaki@daynix.com>
Date: Sat, 24 Feb 2024 21:43:33 +0900
Subject: [PATCH v12 02/10] ui/cocoa: Immediately call [-QemuCocoaView
 handleMouseEvent:buttons:]
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240224-cocoa-v12-2-e89f70bdda71@daynix.com>
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
Received-SPF: none client-ip=2607:f8b0:4864:20::52c;
 envelope-from=akihiko.odaki@daynix.com; helo=mail-pg1-x52c.google.com
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

Instead of using mouse_event variable to tell to handle a mouse event
later, immediately call [-QemuCocoaView handleMouseEvent:buttons:].

Signed-off-by: Akihiko Odaki <akihiko.odaki@daynix.com>
---
 ui/cocoa.m | 87 ++++++++++++++++++++++----------------------------------------
 1 file changed, 30 insertions(+), 57 deletions(-)

diff --git a/ui/cocoa.m b/ui/cocoa.m
index 32d61e226507..06bd5737636b 100644
--- a/ui/cocoa.m
+++ b/ui/cocoa.m
@@ -799,9 +799,8 @@ - (bool) handleEventLocked:(NSEvent *)event
 {
     /* Return true if we handled the event, false if it should be given to OSX */
     COCOA_DEBUG("QemuCocoaView: handleEvent\n");
-    int buttons = 0;
+    InputButton button;
     int keycode = 0;
-    bool mouse_event = false;
     // Location of event in virtual screen coordinates
     NSPoint p = [self screenLocationOfEvent:event];
     NSUInteger modifiers = [event modifierFlags];
@@ -947,7 +946,7 @@ - (bool) handleEventLocked:(NSEvent *)event
                     }
                     break;
             }
-            break;
+            return true;
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
@@ -1012,34 +1011,20 @@ - (bool) handleEventLocked:(NSEvent *)event
                     }
                 }
             }
-            mouse_event = true;
-            break;
+            return [self handleMouseEvent:event buttons:0];
         case NSEventTypeLeftMouseDown:
-            buttons |= MOUSE_EVENT_LBUTTON;
-            mouse_event = true;
-            break;
+            return [self handleMouseEvent:event buttons:MOUSE_EVENT_LBUTTON];
         case NSEventTypeRightMouseDown:
-            buttons |= MOUSE_EVENT_RBUTTON;
-            mouse_event = true;
-            break;
+            return [self handleMouseEvent:event buttons:MOUSE_EVENT_RBUTTON];
         case NSEventTypeOtherMouseDown:
-            buttons |= MOUSE_EVENT_MBUTTON;
-            mouse_event = true;
-            break;
+            return [self handleMouseEvent:event buttons:MOUSE_EVENT_MBUTTON];
         case NSEventTypeLeftMouseDragged:
-            buttons |= MOUSE_EVENT_LBUTTON;
-            mouse_event = true;
-            break;
+            return [self handleMouseEvent:event buttons:MOUSE_EVENT_LBUTTON];
         case NSEventTypeRightMouseDragged:
-            buttons |= MOUSE_EVENT_RBUTTON;
-            mouse_event = true;
-            break;
+            return [self handleMouseEvent:event buttons:MOUSE_EVENT_RBUTTON];
         case NSEventTypeOtherMouseDragged:
-            buttons |= MOUSE_EVENT_MBUTTON;
-            mouse_event = true;
-            break;
+            return [self handleMouseEvent:event buttons:MOUSE_EVENT_MBUTTON];
         case NSEventTypeLeftMouseUp:
-            mouse_event = true;
             if (!isMouseGrabbed && [self screenContainsPoint:p]) {
                 /*
                  * In fullscreen mode, the window of cocoaView may not be the
@@ -1050,53 +1035,41 @@ - (bool) handleEventLocked:(NSEvent *)event
                     [self grabMouse];
                 }
             }
-            break;
+            return [self handleMouseEvent:event buttons:0];
         case NSEventTypeRightMouseUp:
-            mouse_event = true;
-            break;
+            return [self handleMouseEvent:event buttons:0];
         case NSEventTypeOtherMouseUp:
-            mouse_event = true;
-            break;
+            return [self handleMouseEvent:event buttons:0];
         case NSEventTypeScrollWheel:
             /*
              * Send wheel events to the guest regardless of window focus.
              * This is in-line with standard Mac OS X UI behaviour.
              */
 
-            /*
-             * We shouldn't have got a scroll event when deltaY and delta Y
-             * are zero, hence no harm in dropping the event
-             */
-            if ([event deltaY] != 0 || [event deltaX] != 0) {
             /* Determine if this is a scroll up or scroll down event */
-                if ([event deltaY] != 0) {
-                  buttons = ([event deltaY] > 0) ?
+            if ([event deltaY] != 0) {
+                button = ([event deltaY] > 0) ?
                     INPUT_BUTTON_WHEEL_UP : INPUT_BUTTON_WHEEL_DOWN;
-                } else if ([event deltaX] != 0) {
-                  buttons = ([event deltaX] > 0) ?
+            } else if ([event deltaX] != 0) {
+                button = ([event deltaX] > 0) ?
                     INPUT_BUTTON_WHEEL_LEFT : INPUT_BUTTON_WHEEL_RIGHT;
-                }
-
-                qemu_input_queue_btn(dcl.con, buttons, true);
-                qemu_input_event_sync();
-                qemu_input_queue_btn(dcl.con, buttons, false);
-                qemu_input_event_sync();
+            } else {
+                /*
+                 * We shouldn't have got a scroll event when deltaY and delta Y
+                 * are zero, hence no harm in dropping the event
+                 */
+                return true;
             }
 
-            /*
-             * Since deltaX/deltaY also report scroll wheel events we prevent mouse
-             * movement code from executing.
-             */
-            mouse_event = false;
-            break;
+            qemu_input_queue_btn(dcl.con, button, true);
+            qemu_input_event_sync();
+            qemu_input_queue_btn(dcl.con, button, false);
+            qemu_input_event_sync();
+
+            return true;
         default:
             return false;
     }
-
-    if (mouse_event) {
-        return [self handleMouseEvent:event buttons:buttons];
-    }
-    return true;
 }
 
 - (bool) handleMouseEvent:(NSEvent *)event buttons:(uint32_t)buttons

-- 
2.43.2


