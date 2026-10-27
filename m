Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C229606A31A
	for <qemu-devel@archiver.kernel.org>; Tue, 27 Oct 2026 19:43:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=Ytoj8nHi
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xLn5B-0006sJ-U1; Tue, 27 Oct 2026 15:43:41 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <soumyajyotisarkar23@gmail.com>)
 id 1xLn5A-0006s5-6n
 for qemu-devel@nongnu.org; Tue, 27 Oct 2026 15:43:40 -0400
Received: from mail-dy2-x07.google.com ([2607:f8b0:4864:36::7])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <soumyajyotisarkar23@gmail.com>)
 id 1xLn58-0003uG-0I
 for qemu-devel@nongnu.org; Tue, 27 Oct 2026 15:43:39 -0400
Received: by mail-dy2-x07.google.com with SMTP id
 5a478bee46e88-369ef2c6802so29046eec.1
 for <qemu-devel@nongnu.org>; Tue, 27 Oct 2026 12:43:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20260707; t=1793130216; x=1793735016; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=iD/yZnopZ26jXY6NfunmdxdiTNNYDEqf2sjNrQDEsuA=;
 b=Ytoj8nHiWFQqfoLb1yjoQBXFWa0P1XcBdrIwVMpwCy/mcYlCjwbP4D+8qZ424bjwnj
 dFC80QFJbxsaw7a6ghY9toCELea4MyGf0PYfk+I3DcYtD70UAtovCOgR9X1mcAnGMkmP
 eK5I/wrWTgoURG1njqwBXQd2ZyF4kHEGfv6r7R4HskXT2v4e6xvUtHOwxEbMGOCEY9zy
 /gFlmzoUdyXxtA3ge0szedCZtRS9wKIxAptuQ/ukaSnZpu8IAbVnIhnYbyAf01PV7wg+
 Z0lUiPj8WBK7cpUHfrh6ioWY+dDGw6MHC5jr2Zvg9iZ0rXoVq+XL1iEJb5FKo5hSS2UZ
 qyqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793130216; x=1793735016;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=iD/yZnopZ26jXY6NfunmdxdiTNNYDEqf2sjNrQDEsuA=;
 b=eIn7D816/foB9+sksOPYysoLnboEMZl1pEkHwoTX/6dE3q/U7PXS0PQAJZvsV/Yl37
 5MH+uMa6xufqGYK0urMMWbYMlLFR5XY0FLsT5zqUMlyqMXi+YFWkW9wQBpgxHJm55fN1
 A7y6CvWq16MRuANlPLCh+3+8UXQDl6q6ap52zV6pjVsmJF5UiYEds4Jah6PiJaUrin8h
 YWNa8H0ImAPVxxmoPSkTlplxcufq2U8+BzBQuMIf5TEQNxuruiZYvht1yrdgvp2Qm9pw
 NeOBHtKArgVJb6O4KTS64duHYymk/HgVTB76VHasc99XIPHK9l/ndYG6fgi+sQa1RJ7u
 nWEw==
X-Forwarded-Encrypted: i=1;
 AKwUvBzGuoh9VkMIfEjDroRT6aChr1RRZVm2GFjkhYBGLUvkld/bVimEwCw2H7cMS+2jwXJNBfnRm/FGiJRr@nongnu.org
X-Gm-Message-State: AFq9FYLzgRnLqmkc5Ab+a7iVb8+gKRf7SwUtYtjZ3TMxK2jL7EHaXGyN
 3/mEgEzSLfce3m4WqBjLGtKcnPWQdN3FsLgGaXg0qOB5hTLopZqazTky
X-Gm-Gg: AYBFou3vX6YLEoUUVqmh+3rKca6lCJaVsF1KtL7sD01k8oXDS9bRjSuMv+f/6f8J5bP
 wM0aOTciNE7DHsoG8UGHA5XE5p33+z7TqOX8nRZmB+geLW9yHTtK6TBG8UX5vscgov6t7uhCxAq
 i+akgnLVvuD/XQ4Ztd5j5iC38fDZ6XXCN0krDavYWOaDbpwYgrO/mVZKv94QzlAO+vemKkBDjvW
 wVZ/f+KQl+tpOFqiUlpmRKy29aaiOuzYQq0DgOJqzb8+yKGPrpJC6E0hrBpW6PLPWX4nA8kr35R
 8zR8DmfC7hJhQ07My74z/8HzCnV6xGncCzE2KgDEJ1o0HYGkQtQa9NeyORwLeQE9/ZEsPsgn9pz
 VHtgpcZXHhFHaBLLx47dxLc5uCkicHrrCVDA8AOexW9ZpaS0BllIYQkAmxteIohekfPaX5c/way
 Lwegv1FvNr2tzfi4n+hshPO9aIyWT2q0ACyWmkoLt2tJDCEkY/tIXhN/UBeteBFqKMjwzMTYB+S
 likfXKKwdxmBFz9OVQRhDKwyTEtNalkVTxYbhhEzzFecOencoYPDkKEojPM+F6XRmXGL4rUOyxG
 4WvKMWQF7183Rc84fCiQwTdk/Ga9BZ5n/P2Z6dYFn8pP1UzAY+WKrJe1fcO8A917kNWSy7Dwl/N
 JgRY/STLkNnQ8Smq5mZZDoHgwGnCS/i+YRyBU1IPIcXg4ii45rPvLqSSvtcrHRGZ9FVj6iOk=
X-Received: by 2002:a05:7301:2422:b0:35a:3b98:b428 with SMTP id
 5a478bee46e88-36a0f7d0250mr4566226eec.12.1793130215442; 
 Tue, 27 Oct 2026 12:43:35 -0700 (PDT)
Received: from fedora.tail9bb79b.ts.net ([119.82.106.50])
 by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-36a064510b0sm20446558eec.2.2026.10.27.12.43.31
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 27 Oct 2026 12:43:35 -0700 (PDT)
From: soumyajyotisarkar23@gmail.com
To: sarkarsoumyajyoti23@gmail.com,
	qemu-devel@nongnu.org
Cc: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Helge Deller <deller@kernel.org>, Eric Blake <eblake@redhat.com>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Markus Armbruster <armbru@redhat.com>,
 Soumyajyotii Ssarkar <soumyajyotisarkar23@gmail.com>
Subject: [PATCH v2 7/8] hw/usb/dev-hid: support the wheel Resolution
 Multiplier feature report
Date: Wed, 28 Oct 2026 01:12:55 +0530
Message-ID: <20261027194256.76031-8-soumyajyotisarkar23@gmail.com>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <20261027194256.76031-1-soumyajyotisarkar23@gmail.com>
References: <20261027194256.76031-1-soumyajyotisarkar23@gmail.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:36::7;
 envelope-from=soumyajyotisarkar23@gmail.com; helo=mail-dy2-x07.google.com
X-Spam_score_int: -17
X-Spam_score: -1.8
X-Spam_bar: -
X-Spam_report: (-1.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FREEMAIL_ENVFROM_END_DIGIT=0.25, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_PASS,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

From: Soumyajyotii Ssarkar <soumyajyotisarkar23@gmail.com>

Even with high-resolution scroll events reaching the HID mouse, each
wheel report count is still a whole detent, so guests see the same
coarse steps as before.

Add a Resolution Multiplier feature (report ID 2) to the vertical
wheel and AC Pan logical collections, as described in Microsoft's
"Enhanced Wheel Support in Windows" docs. The feature byte holds the
wheel multiplier in bits [1:0] and the pan multiplier in bits [3:2],
each with logical range 0..1 and physical range 1..120. The report
descriptor grows to 144 bytes.

Handle GET_REPORT and SET_REPORT for the feature report, accepting the
payload with or without the leading report ID byte. Windows (Vista and
later) and Linux set each multiplier to its logical maximum. While a
multiplier is enabled in report protocol, hid_pointer_poll() reports
that axis in counts of 1/120 detent, so one count reaches applications
as one WHEEL_DELTA unit. Boot protocol and guests that never enable
the multiplier keep getting whole detents.

The multiplier state is migrated in the optional wheel subsection.

Signed-off-by: Soumyajyotii Ssarkar <soumyajyotisarkar23@gmail.com>
---
 hw/input/hid.c         | 22 ++++++++--
 hw/usb/dev-hid.c       | 97 ++++++++++++++++++++++++++++++++++++++----
 include/hw/input/hid.h |  4 ++
 3 files changed, 111 insertions(+), 12 deletions(-)

diff --git a/hw/input/hid.c b/hw/input/hid.c
index 9f26850112..bc84e99dbc 100644
--- a/hw/input/hid.c
+++ b/hw/input/hid.c
@@ -378,7 +378,7 @@ static int hid_scroll_counts(int32_t *pending, int32_t *residual, int mult)
 
 int hid_pointer_poll(HIDState *hs, uint8_t *buf, int len)
 {
-    int dx, dy, dz, pan, l;
+    int dx, dy, dz, pan, l, mult;
     int index;
     HIDPointerEvent *e;
 
@@ -400,8 +400,19 @@ int hid_pointer_poll(HIDState *hs, uint8_t *buf, int len)
         dx = e->xdx;
         dy = e->ydy;
     }
-    dz = hid_scroll_counts(&e->dz, &hs->ptr.wheel_residual, 1);
-    pan = hid_scroll_counts(&e->pan, &hs->ptr.pan_residual, 1);
+    mult = 1;
+    if (hs->kind == HID_MOUSE && hs->protocol == 1 &&
+        hs->ptr.wheel_multiplier) {
+        mult = HID_WHEEL_RESOLUTION_MULTIPLIER;
+    }
+    dz = hid_scroll_counts(&e->dz, &hs->ptr.wheel_residual, mult);
+
+    mult = 1;
+    if (hs->kind == HID_MOUSE && hs->protocol == 1 &&
+        hs->ptr.pan_multiplier) {
+        mult = HID_WHEEL_RESOLUTION_MULTIPLIER;
+    }
+    pan = hid_scroll_counts(&e->pan, &hs->ptr.pan_residual, mult);
 
     if (hs->n &&
         !e->dz &&
@@ -657,7 +668,8 @@ static bool hid_ptr_wheel_needed(void *opaque)
     HIDState *s = opaque;
     int i;
 
-    if (s->ptr.wheel_residual || s->ptr.pan_residual) {
+    if (s->ptr.wheel_multiplier || s->ptr.pan_multiplier ||
+        s->ptr.wheel_residual || s->ptr.pan_residual) {
         return true;
     }
     for (i = 0; i < QUEUE_LENGTH; i++) {
@@ -706,6 +718,8 @@ static const VMStateDescription vmstate_hid_ptr_wheel = {
     .fields = (const VMStateField[]) {
         VMSTATE_STRUCT_ARRAY(ptr.queue, HIDState, QUEUE_LENGTH, 0,
                              vmstate_hid_ptr_queue_pan, HIDPointerEvent),
+        VMSTATE_UINT8(ptr.wheel_multiplier, HIDState),
+        VMSTATE_UINT8(ptr.pan_multiplier, HIDState),
         VMSTATE_INT32(ptr.wheel_residual, HIDState),
         VMSTATE_INT32(ptr.pan_residual, HIDState),
         VMSTATE_END_OF_LIST()
diff --git a/hw/usb/dev-hid.c b/hw/usb/dev-hid.c
index 804119006b..ffe07ff68b 100644
--- a/hw/usb/dev-hid.c
+++ b/hw/usb/dev-hid.c
@@ -81,6 +81,8 @@ static const USBDescStrings desc_strings = {
  * descriptor.
  * Note: Windows stops recognising the mouse if it does not match
  * exactly.
+ * The enhanced wheel support grew the descriptor from 52 to 144
+ * bytes.
  */
 static const uint8_t qemu_mouse_hid_report_descriptor[] = {
     0x05, 0x01,         /* Usage Page (Generic Desktop) */
@@ -119,7 +121,20 @@ static const uint8_t qemu_mouse_hid_report_descriptor[] = {
     /* Vertical wheel logical collection */
     0xA1, 0x02,         /*  Collection (Logical) */
 
+    0x85, 0x02,         /*  Report ID (0x02) */
+    0x09, 0x48,         /*  Usage (Resolution Multiplier) */
+    0x15, 0x00,         /*  Logical Minimum (0) */
+    0x25, 0x01,         /*  Logical Maximum (1) */
+    0x35, 0x01,         /*  Physical Minimum (1) */
+    0x45, 0x78,         /*  Physical Maximum (120) */
+    0x75, 0x02,         /*  Report Size (2) */
+    0x95, 0x01,         /*  Report Count (1) */
+    0xB1, 0x02,         /*  Feature (Data,Var,Abs) */
+
+    0x85, 0x01,         /*  Report ID (0x01) */
     0x09, 0x38,         /*  Usage (Wheel) */
+    0x35, 0x00,         /*  Physical Minimum (0) */
+    0x45, 0x00,         /*  Physical Maximum (0) */
     0x15, 0x81,         /*  Logical Minimum (-0x7f) */
     0x25, 0x7F,         /*  Logical Maximum (0x7f) */
     0x75, 0x08,         /*  Report Size (8) */
@@ -131,6 +146,23 @@ static const uint8_t qemu_mouse_hid_report_descriptor[] = {
     /* Horizontal wheel logical collection */
     0xA1, 0x02,         /*  Collection (Logical) */
 
+    0x85, 0x02,         /*  Report ID (0x02) */
+    0x09, 0x48,         /*  Usage (Resolution Multiplier) */
+    0x15, 0x00,         /*  Logical Minimum (0) */
+    0x25, 0x01,         /*  Logical Maximum (1) */
+    0x35, 0x01,         /*  Physical Minimum (1) */
+    0x45, 0x78,         /*  Physical Maximum (120) */
+    0x75, 0x02,         /*  Report Size (2) */
+    0x95, 0x01,         /*  Report Count (1) */
+    0xB1, 0x02,         /*  Feature (Data,Var,Abs) */
+
+    0x35, 0x00,         /*  Physical Minimum (0) */
+    0x45, 0x00,         /*  Physical Maximum (0) */
+    0x75, 0x04,         /*  Report Size (4) */
+    0x95, 0x01,         /*  Report Count (1) */
+    0xB1, 0x01,         /*  Feature (Const) */
+
+    0x85, 0x01,         /*  Report ID (0x01) */
     0x05, 0x0C,         /*  Usage Page (Consumer Devices) */
     0x0A, 0x38, 0x02,   /*  Usage (AC Pan) */
     0x15, 0x81,         /*  Logical Minimum (-0x7f) */
@@ -652,17 +684,66 @@ static void usb_hid_handle_control(USBDevice *dev, USBPacket *p,
         }
         break;
     case HID_GET_REPORT:
-        if (hs->kind == HID_MOUSE || hs->kind == HID_TABLET) {
-            p->actual_length = hid_pointer_poll(hs, data, length);
-        } else if (hs->kind == HID_KEYBOARD) {
-            p->actual_length = hid_keyboard_poll(hs, data, length);
+        {
+            uint8_t mult;
+            uint8_t report_type = (value >> 8) & 0xFF;
+            uint8_t report_id = value & 0xFF;
+
+            if (report_type == 0x03 && report_id == 0x02 &&
+                hs->kind == HID_MOUSE) {
+
+                if (length < 1) {
+                    goto fail;
+                }
+
+                mult = ((hs->ptr.pan_multiplier & 0x03) << 2) |
+                       (hs->ptr.wheel_multiplier & 0x03);
+                if (length >= 2) {
+                    data[0] = 0x02;
+                    data[1] = mult;
+                    p->actual_length = 2;
+                } else {
+                    data[0] = mult;
+                    p->actual_length = 1;
+                }
+
+            } else if (hs->kind == HID_MOUSE || hs->kind == HID_TABLET) {
+                p->actual_length = hid_pointer_poll(hs, data, length);
+            } else if (hs->kind == HID_KEYBOARD) {
+                p->actual_length = hid_keyboard_poll(hs, data, length);
+            } else {
+                goto fail;
+            }
         }
         break;
     case HID_SET_REPORT:
-        if (hs->kind == HID_KEYBOARD) {
-            p->actual_length = hid_keyboard_write(hs, data, length);
-        } else {
-            goto fail;
+        {
+            uint8_t mult;
+            uint8_t report_type = (value >> 8) & 0xFF;
+            uint8_t report_id = value & 0xFF;
+
+            if (report_type == 0x03 && report_id == 0x02 &&
+                hs->kind == HID_MOUSE) {
+
+                if (length < 1) {
+                    goto fail;
+                }
+
+                if (length >= 2 && data[0] == 0x02) {
+                    mult = data[1];
+                } else {
+                    mult = data[0];
+                }
+
+                hs->ptr.wheel_multiplier = mult & 0x03;
+                hs->ptr.pan_multiplier = (mult >> 2) & 0x03;
+                p->actual_length = length;
+
+            } else if (hs->kind == HID_KEYBOARD) {
+                p->actual_length = hid_keyboard_write(hs, data, length);
+            } else {
+                goto fail;
+            }
         }
         break;
     case HID_GET_PROTOCOL:
diff --git a/include/hw/input/hid.h b/include/hw/input/hid.h
index b7cdeb54c2..458aa07cae 100644
--- a/include/hw/input/hid.h
+++ b/include/hw/input/hid.h
@@ -7,6 +7,8 @@
 #define HID_TABLET    2
 #define HID_KEYBOARD  3
 
+#define HID_WHEEL_RESOLUTION_MULTIPLIER 120
+
 typedef struct HIDPointerEvent {
     int32_t xdx, ydy; /* relative iff it's a mouse, otherwise absolute */
     int32_t dz, buttons_state;
@@ -23,6 +25,8 @@ typedef void (*HIDEventFunc)(HIDState *s);
 typedef struct HIDMouseState {
     HIDPointerEvent queue[QUEUE_LENGTH];
     int mouse_grabbed;
+    uint8_t wheel_multiplier;
+    uint8_t pan_multiplier;
     int32_t wheel_residual;
     int32_t pan_residual;
     bool wheel_state_loaded;
-- 
2.56.0


