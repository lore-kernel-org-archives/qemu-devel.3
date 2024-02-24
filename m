Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 48572C48BF6
	for <qemu-devel@archiver.kernel.org>; Sat, 24 Feb 2024 12:45:55 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rdrNa-000244-OH; Sat, 24 Feb 2024 07:43:46 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1rdrNY-00023e-T4
 for qemu-devel@nongnu.org; Sat, 24 Feb 2024 07:43:44 -0500
Received: from mail-pf1-x436.google.com ([2607:f8b0:4864:20::436])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1rdrNW-0006kI-8s
 for qemu-devel@nongnu.org; Sat, 24 Feb 2024 07:43:44 -0500
Received: by mail-pf1-x436.google.com with SMTP id
 d2e1a72fcca58-6e459b39e2cso822960b3a.1
 for <qemu-devel@nongnu.org>; Sat, 24 Feb 2024 04:43:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=daynix-com.20230601.gappssmtp.com; s=20230601; t=1708778620; x=1709383420;
 darn=nongnu.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=QHNJuFjiujtFNVkkX8VyNbVFZUCFddQxl5GcQ9h6SbA=;
 b=reb01+HU2hpC5vFNZ8Iba+m6Ri4HMjUZIGBiGE6QDIf/bPURq6zxt931XfYxiRy79K
 9Jo1E/SzgspCgtikOkLfmxBYoqnTlpbBbvnG4P8r5QpikdHpWZEiWCPxOjgW5d+eLjM7
 TVCsZVxiaQzOCljJSKa/JwUZ8/3EVIGigk1xgn1U2aaVLOIKAprfbO3xNMfY2BlJoO/C
 UIbb/cwNYrW8cXzHE9C+QCV8Mimduy4HZof4l56PqR4Y8YssTCMUygl/rrhdXpYRjyRG
 nDHx/5JF4xpMDszKCOKrk+Bg8em/I8fsFu9o/Z1fRRRsEn0Tkq4PVIcq+xHapLZmvLxL
 Dy/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1708778620; x=1709383420;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=QHNJuFjiujtFNVkkX8VyNbVFZUCFddQxl5GcQ9h6SbA=;
 b=musLgx+ZJW3JZBFwyd0rbztq0taTKe+Ir895HjPPQR9ELo0bx4ZTRNK+CI+fNrW9GN
 kLYp7Q+wD6lP6GtU56S0n2ynixDxWYiVA1esyQsbo4VqdqfeYQpdRq9RNSyG5oAMa5nf
 tGbDBkqmMAFcS4U/x1HG1vaBSfF4JG4w36R4msLDbXOHESXB9E9lriHBUmmDiNBOcdIY
 1UNvpzB7PCxnI5Cjyg5ec8I6RlWPivEoRAl2OVNyNFVq/XP8Y9r/C+vsn+1o4ZO2Ow04
 cpnaAHYI46JSPuiixlhx1O/Os5FWnl2yJahkIMkGvLlZV6YR5u08KqAAHeEuELhHAxvQ
 JOcA==
X-Gm-Message-State: AOJu0YwGh7hy46iEwGU2EvTUKYjIzAD4MacjkXFWOu4rs2dJF10GdExT
 sE2XoiDgcZtQNwknbUOI9PJTsM0HPkkjw8CzyMhR8y8cmKtHi9R/DPuCABqDZY8=
X-Google-Smtp-Source: AGHT+IEqN3l+HIWWlk309bl0EmSulcmlS4VfnuKf47bSxJRJktlnpxWdCvG5v7ZjQVqP/DN68cb7Fg==
X-Received: by 2002:a05:6a20:d48c:b0:1a0:5de4:2f53 with SMTP id
 im12-20020a056a20d48c00b001a05de42f53mr3354939pzb.25.1708778620369; 
 Sat, 24 Feb 2024 04:43:40 -0800 (PST)
Received: from localhost ([157.82.203.206])
 by smtp.gmail.com with UTF8SMTPSA id
 j15-20020a63fc0f000000b005dc2ca5b667sm1023913pgi.10.2024.02.24.04.43.38
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sat, 24 Feb 2024 04:43:40 -0800 (PST)
From: Akihiko Odaki <akihiko.odaki@daynix.com>
Date: Sat, 24 Feb 2024 21:43:32 +0900
Subject: [PATCH v12 01/10] ui/cocoa: Split [-QemuCocoaView handleEventLocked:]
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240224-cocoa-v12-1-e89f70bdda71@daynix.com>
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
Received-SPF: none client-ip=2607:f8b0:4864:20::436;
 envelope-from=akihiko.odaki@daynix.com; helo=mail-pf1-x436.google.com
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

Currently [-QemuCocoaView handleEventLocked:] parses the passed event,
stores operations to be done to variables, and perform them according
to the variables. This construct will be cluttered with variables and
hard to read when we need more different operations for different
events.

Split the methods so that we can call appropriate methods depending on
events instead of relying on variables.

Signed-off-by: Akihiko Odaki <akihiko.odaki@daynix.com>
---
 ui/cocoa.m | 82 +++++++++++++++++++++++++++++++++++++-------------------------
 1 file changed, 49 insertions(+), 33 deletions(-)

diff --git a/ui/cocoa.m b/ui/cocoa.m
index eb99064beeb4..32d61e226507 100644
--- a/ui/cocoa.m
+++ b/ui/cocoa.m
@@ -1094,42 +1094,58 @@ - (bool) handleEventLocked:(NSEvent *)event
     }
 
     if (mouse_event) {
-        /* Don't send button events to the guest unless we've got a
-         * mouse grab or window focus. If we have neither then this event
-         * is the user clicking on the background window to activate and
-         * bring us to the front, which will be done by the sendEvent
-         * call below. We definitely don't want to pass that click through
-         * to the guest.
+        return [self handleMouseEvent:event buttons:buttons];
+    }
+    return true;
+}
+
+- (bool) handleMouseEvent:(NSEvent *)event buttons:(uint32_t)buttons
+{
+    /* Don't send button events to the guest unless we've got a
+     * mouse grab or window focus. If we have neither then this event
+     * is the user clicking on the background window to activate and
+     * bring us to the front, which will be done by the sendEvent
+     * call below. We definitely don't want to pass that click through
+     * to the guest.
+     */
+    if ((isMouseGrabbed || [[self window] isKeyWindow]) &&
+        (last_buttons != buttons)) {
+        static uint32_t bmap[INPUT_BUTTON__MAX] = {
+            [INPUT_BUTTON_LEFT]       = MOUSE_EVENT_LBUTTON,
+            [INPUT_BUTTON_MIDDLE]     = MOUSE_EVENT_MBUTTON,
+            [INPUT_BUTTON_RIGHT]      = MOUSE_EVENT_RBUTTON
+        };
+        qemu_input_update_buttons(dcl.con, bmap, last_buttons, buttons);
+        last_buttons = buttons;
+    }
+
+    return [self handleMouseEvent:event];
+}
+
+- (bool) handleMouseEvent:(NSEvent *)event
+{
+    if (!isMouseGrabbed) {
+        return false;
+    }
+
+    if (isAbsoluteEnabled) {
+        NSPoint p = [self screenLocationOfEvent:event];
+
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
+        if ([self screenContainsPoint:p]) {
+            qemu_input_queue_abs(dcl.con, INPUT_AXIS_X, p.x, 0, screen.width);
+            qemu_input_queue_abs(dcl.con, INPUT_AXIS_Y, screen.height - p.y, 0, screen.height);
         }
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
-        }
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
 

-- 
2.43.2


