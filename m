Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8DA02606A31D
	for <qemu-devel@archiver.kernel.org>; Tue, 27 Oct 2026 19:43:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=bTMwfP1V
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xLn59-0006rd-VY; Tue, 27 Oct 2026 15:43:40 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <soumyajyotisarkar23@gmail.com>)
 id 1xLn58-0006rN-7d
 for qemu-devel@nongnu.org; Tue, 27 Oct 2026 15:43:38 -0400
Received: from mail-dy2-x0a.google.com ([2607:f8b0:4864:36::a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <soumyajyotisarkar23@gmail.com>)
 id 1xLn52-0003tv-QJ
 for qemu-devel@nongnu.org; Tue, 27 Oct 2026 15:43:34 -0400
Received: by mail-dy2-x0a.google.com with SMTP id
 5a478bee46e88-33e5ae86ff2so65678eec.0
 for <qemu-devel@nongnu.org>; Tue, 27 Oct 2026 12:43:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20260707; t=1793130211; x=1793735011; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=SdfoF/OwK31Vto+fkLrSnBQEp5sDuc7DP41XnDQoJqc=;
 b=bTMwfP1VE+QNHxXSn2HE2DVWRt9VsEdxoxoLzD5xYmQT7GrI2d2eWQ3DvnmAx+/jNA
 nwyzxOrnW5+gTsR9nyM1i9iTX1Z7gNJEaI0+XSe7vcQeGYrBvi45kFy6KNtTao/Ol1m9
 bb9ydoaf+6HmD+9fsCeFSJVZn0bGSxKZP6WWdv/0nBkM0kM9td3lOAXtA7BgB3GQAg2q
 P+fVXuyc3iR1bTXjsFy/lgpPLj5aag1ZEljhJ31Ukhc/2/ieIcFBomNxAD8HS+phRZDz
 umHnntk10+bFCC1uladU5SPReJoXyC7yaH6pNNJs5Q5TLz191OdWPigk5wG2w0WW/O83
 OObA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793130211; x=1793735011;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=SdfoF/OwK31Vto+fkLrSnBQEp5sDuc7DP41XnDQoJqc=;
 b=c+nC061W3MOur6gynv85PoYfj88Mv0moPQ7TR73AJvc02uQ7s22ib60IhNEFin6T/0
 EqnrW+q8oXY3lS5hzqPHGFjKwb5X/Uk9HQ21Fzftt5bPu0mjcbc7OE5vB9CotoKnnWmq
 PxLzCd3TA9FqeMyhiC+EKah0lBqGTaqLiMoG4PaZV1n1C3YRS+QJ4iHcHKj08Q780TzO
 oNVDUoWlnhg087Vl7iR3bARp3ucH3KUcxj0vZ1Jxg9r9G37h004nyyjA8AyzAeZOYxOa
 2AD500asbxhVJ2WB8IsX7/0tZt4ufi2jih91uSaxDCs8w+1clwo6HiPIkbVppRDORUQ9
 rtkA==
X-Forwarded-Encrypted: i=1;
 AKwUvBzRHlL9eLm5MHf9ofMKtszaeSWymAaGSr4QuSEHOdoTpk2sfdH3IljBYmgkgVkxHXSgh5Y6j1uqr4Kt@nongnu.org
X-Gm-Message-State: AFq9FYLSclfVlZAc4FgfJTlLAecK8sFp9O7JxGNIIBxsUoxz8nHx2SCo
 pH6XhTc7+sabQwnDEmyKgPf1D/dNagu2vobQb5YA5QsOI13HH68rz/nxxBdhJZsTmZ0=
X-Gm-Gg: AYBFou140Vvdbcp+EYTeFd23EG2UANHlByR+0bmEinj466inhom2hCyNwmzfLSMhVMO
 gsaFB25LkxvbYEl5D/edA3lOVzIqQiif1mKeJ+C3/bsf5LpQG93BrSkyzqRj1T0n5hdDFte1XM4
 1C/nrwaH0H3MQzwd6A64JTMFoLt80SCAT8MHGWbynGHn7YyvoD9AjFnKBTScbUmxC1belKHk/pW
 jbJkaMlGoDd08uUWYbzI+s6CTK3TXDwceV/QzHSHXOg78om/eg0cxVVwMWk36+gCclUjB8+13jc
 p2nkO9fxCp/NlVCpAEAXY3UZLQ90h+SF7OpSQaHD0x4j5XosXxbVNY4JTqJGFzTP6qraegUcx26
 bNSyNJDe16WWmrswoZnuOd37WA7IDGn+Zettor9Z8gDGM1zosHINxWc0gjC3fVxK6VGj1b3AswR
 /7SxIeSF4Rdf44tCOaMooKAx0kFY4iZ/noRvmYB/S+JR2h7QxHGo0o+au3NkTuUId//2eg5kCwA
 Q3W2RYiBPin1tKb9RoOAaKOtNjvxs6lt3zl24/PjdcBlPeobj9wd0pDGiT3aj3Jea9szlRol2gG
 pToJ2/Rs5U7/k0j+3j6aNi7NU9s4Psgkjyi6rf6eeI8Zc/yg62kag4VXUcoRh6VnSi7frkHBP2Q
 nSJ2RTMmf54NPO++SLmyqoc2w+cmnPafpKRRY3aKQfr/U1BZOTg==
X-Received: by 2002:a05:693c:20c6:20b0:369:f9da:a70f with SMTP id
 5a478bee46e88-36a200beebcmr635777eec.17.1793130211068; 
 Tue, 27 Oct 2026 12:43:31 -0700 (PDT)
Received: from fedora.tail9bb79b.ts.net ([119.82.106.50])
 by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-36a064510b0sm20446558eec.2.2026.10.27.12.43.27
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 27 Oct 2026 12:43:30 -0700 (PDT)
From: soumyajyotisarkar23@gmail.com
To: sarkarsoumyajyoti23@gmail.com,
	qemu-devel@nongnu.org
Cc: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Helge Deller <deller@kernel.org>, Eric Blake <eblake@redhat.com>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Markus Armbruster <armbru@redhat.com>,
 Soumyajyotii Ssarkar <soumyajyotisarkar23@gmail.com>
Subject: [PATCH v2 6/8] hw/usb/dev-hid: report horizontal wheel through AC Pan
Date: Wed, 28 Oct 2026 01:12:54 +0530
Message-ID: <20261027194256.76031-7-soumyajyotisarkar23@gmail.com>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <20261027194256.76031-1-soumyajyotisarkar23@gmail.com>
References: <20261027194256.76031-1-soumyajyotisarkar23@gmail.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:36::a;
 envelope-from=soumyajyotisarkar23@gmail.com; helo=mail-dy2-x0a.google.com
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

The USB mouse report descriptor only describes buttons, X, Y and a
vertical wheel, so horizontal scrolling from the host never reaches
the guest.

Rework the descriptor following the layout in Microsoft's "Enhanced
Wheel Support in Windows" paper: the pointer fields move into input
report 1 and the vertical Wheel and the Consumer AC Pan usages each
get their own logical collection. The report descriptor grows from 52
to 90 bytes and the interrupt endpoint packet size from 4 to 6 bytes.

On the HID side, track horizontal movement in a new 'pan' field of the
pointer event queue, fed from WHEEL_LEFT/RIGHT button clicks and from
horizontal scroll events, with the same residual handling as the
vertical wheel. In report protocol hid_pointer_poll() now emits a
6-byte report: report ID, buttons, X, Y, wheel and one pan byte. Boot
protocol keeps the 4-byte layout without report ID and pan.

The pan value is not inverted: a positive AC Pan value means scrolling
right, which matches the sign of the input layer's horizontal scroll.

The queued pan values and the pan residual are migrated in the
optional wheel subsection.

Signed-off-by: Soumyajyotii Ssarkar <soumyajyotisarkar23@gmail.com>
---
 hw/input/hid.c         | 75 ++++++++++++++++++++++++++++-------
 hw/usb/dev-hid.c       | 88 +++++++++++++++++++++++++++++-------------
 include/hw/input/hid.h |  2 +
 3 files changed, 124 insertions(+), 41 deletions(-)

diff --git a/hw/input/hid.c b/hw/input/hid.c
index 2855f6a3d9..9f26850112 100644
--- a/hw/input/hid.c
+++ b/hw/input/hid.c
@@ -148,6 +148,10 @@ static void hid_pointer_event(DeviceState *dev, QemuConsole *src,
                 e->dz -= INPUT_EVENT_SCROLL_DETENT;
             } else if (evt->btn.button == INPUT_BUTTON_WHEEL_DOWN) {
                 e->dz += INPUT_EVENT_SCROLL_DETENT;
+            } else if (evt->btn.button == INPUT_BUTTON_WHEEL_LEFT) {
+                e->pan -= INPUT_EVENT_SCROLL_DETENT;
+            } else if (evt->btn.button == INPUT_BUTTON_WHEEL_RIGHT) {
+                e->pan += INPUT_EVENT_SCROLL_DETENT;
             }
         } else {
             e->buttons_state &= ~bmap[evt->btn.button];
@@ -157,6 +161,8 @@ static void hid_pointer_event(DeviceState *dev, QemuConsole *src,
     case INPUT_EVENT_KIND_SCROLL:
         if (evt->scroll.axis == INPUT_SCROLL_AXIS_VERTICAL) {
             e->dz += evt->scroll.value;
+        } else if (evt->scroll.axis == INPUT_SCROLL_AXIS_HORIZONTAL) {
+            e->pan += evt->scroll.value;
         }
         break;
 
@@ -210,6 +216,8 @@ static void hid_pointer_sync(DeviceState *dev)
         }
         prev->dz += curr->dz;
         curr->dz = 0;
+        prev->pan += curr->pan;
+        curr->pan = 0;
     } else {
         /* prepare next (clear rel, copy abs + btns) */
         if (hs->kind == HID_MOUSE) {
@@ -220,6 +228,7 @@ static void hid_pointer_sync(DeviceState *dev)
             next->ydy = curr->ydy;
         }
         next->dz = 0;
+        next->pan = 0;
         next->buttons_state = curr->buttons_state;
         /* make current guest visible, notify guest */
         hs->n++;
@@ -369,7 +378,7 @@ static int hid_scroll_counts(int32_t *pending, int32_t *residual, int mult)
 
 int hid_pointer_poll(HIDState *hs, uint8_t *buf, int len)
 {
-    int dx, dy, dz, l;
+    int dx, dy, dz, pan, l;
     int index;
     HIDPointerEvent *e;
 
@@ -392,9 +401,11 @@ int hid_pointer_poll(HIDState *hs, uint8_t *buf, int len)
         dy = e->ydy;
     }
     dz = hid_scroll_counts(&e->dz, &hs->ptr.wheel_residual, 1);
+    pan = hid_scroll_counts(&e->pan, &hs->ptr.pan_residual, 1);
 
     if (hs->n &&
         !e->dz &&
+        !e->pan &&
         (hs->kind == HID_TABLET || (!e->xdx && !e->ydy))) {
         /* that deals with this event */
         QUEUE_INCR(hs->head);
@@ -406,17 +417,40 @@ int hid_pointer_poll(HIDState *hs, uint8_t *buf, int len)
     l = 0;
     switch (hs->kind) {
     case HID_MOUSE:
-        if (len > l) {
-            buf[l++] = e->buttons_state;
-        }
-        if (len > l) {
-            buf[l++] = dx;
-        }
-        if (len > l) {
-            buf[l++] = dy;
-        }
-        if (len > l) {
-            buf[l++] = dz;
+        if (hs->protocol == 0) {
+            /* boot protocol (0) */
+            if (len > l) {
+                buf[l++] = e->buttons_state;
+            }
+            if (len > l) {
+                buf[l++] = dx;
+            }
+            if (len > l) {
+                buf[l++] = dy;
+            }
+            if (len > l) {
+                buf[l++] = dz;
+            }
+        } else {
+            /* report protocol (1) */
+            if (len > l) {
+                buf[l++] = 0x01;
+            }
+            if (len > l) {
+                buf[l++] = e->buttons_state;
+            }
+            if (len > l) {
+                buf[l++] = dx;
+            }
+            if (len > l) {
+                buf[l++] = dy;
+            }
+            if (len > l) {
+                buf[l++] = dz;
+            }
+            if (len > l) {
+                buf[l++] = pan;
+            }
         }
         break;
 
@@ -603,6 +637,16 @@ static const VMStateDescription vmstate_hid_ptr_queue = {
     }
 };
 
+static const VMStateDescription vmstate_hid_ptr_queue_pan = {
+    .name = "HIDPointerEventQueue/pan",
+    .version_id = 1,
+    .minimum_version_id = 1,
+    .fields = (const VMStateField[]) {
+        VMSTATE_INT32(pan, HIDPointerEvent),
+        VMSTATE_END_OF_LIST()
+    }
+};
+
 /*
  * Wheel movement used to be queued in whole detents and is now kept in
  * 1/120 detent units.  Without this subsection the source either was an
@@ -613,11 +657,11 @@ static bool hid_ptr_wheel_needed(void *opaque)
     HIDState *s = opaque;
     int i;
 
-    if (s->ptr.wheel_residual) {
+    if (s->ptr.wheel_residual || s->ptr.pan_residual) {
         return true;
     }
     for (i = 0; i < QUEUE_LENGTH; i++) {
-        if (s->ptr.queue[i].dz) {
+        if (s->ptr.queue[i].dz || s->ptr.queue[i].pan) {
             return true;
         }
     }
@@ -660,7 +704,10 @@ static const VMStateDescription vmstate_hid_ptr_wheel = {
     .needed = hid_ptr_wheel_needed,
     .post_load = hid_ptr_wheel_post_load,
     .fields = (const VMStateField[]) {
+        VMSTATE_STRUCT_ARRAY(ptr.queue, HIDState, QUEUE_LENGTH, 0,
+                             vmstate_hid_ptr_queue_pan, HIDPointerEvent),
         VMSTATE_INT32(ptr.wheel_residual, HIDState),
+        VMSTATE_INT32(ptr.pan_residual, HIDState),
         VMSTATE_END_OF_LIST()
     }
 };
diff --git a/hw/usb/dev-hid.c b/hw/usb/dev-hid.c
index 2c10e88c85..804119006b 100644
--- a/hw/usb/dev-hid.c
+++ b/hw/usb/dev-hid.c
@@ -85,31 +85,65 @@ static const USBDescStrings desc_strings = {
 static const uint8_t qemu_mouse_hid_report_descriptor[] = {
     0x05, 0x01,         /* Usage Page (Generic Desktop) */
     0x09, 0x02,         /* Usage (Mouse) */
-    0xa1, 0x01,         /* Collection (Application) */
-    0x09, 0x01,         /*   Usage (Pointer) */
-    0xa1, 0x00,         /*   Collection (Physical) */
-    0x05, 0x09,         /*     Usage Page (Button) */
-    0x19, 0x01,         /*     Usage Minimum (1) */
-    0x29, 0x05,         /*     Usage Maximum (5) */
-    0x15, 0x00,         /*     Logical Minimum (0) */
-    0x25, 0x01,         /*     Logical Maximum (1) */
-    0x95, 0x05,         /*     Report Count (5) */
-    0x75, 0x01,         /*     Report Size (1) */
-    0x81, 0x02,         /*     Input (Data, Variable, Absolute) */
-    0x95, 0x01,         /*     Report Count (1) */
-    0x75, 0x03,         /*     Report Size (3) */
-    0x81, 0x01,         /*     Input (Constant) */
-    0x05, 0x01,         /*     Usage Page (Generic Desktop) */
-    0x09, 0x30,         /*     Usage (X) */
-    0x09, 0x31,         /*     Usage (Y) */
-    0x09, 0x38,         /*     Usage (Wheel) */
-    0x15, 0x81,         /*     Logical Minimum (-0x7f) */
-    0x25, 0x7f,         /*     Logical Maximum (0x7f) */
-    0x75, 0x08,         /*     Report Size (8) */
-    0x95, 0x03,         /*     Report Count (3) */
-    0x81, 0x06,         /*     Input (Data, Variable, Relative) */
-    0xc0,               /*   End Collection */
-    0xc0,               /* End Collection */
+    0xA1, 0x01,         /* Collection (Application) */
+
+    0x09, 0x02,         /* Usage (Mouse) */
+    0xA1, 0x02,         /* Collection (Logical) */
+
+    0x85, 0x01,         /* Report ID (0x01) */
+    0x09, 0x01,         /* Usage (Pointer) */
+    0xA1, 0x00,         /* Collection (Physical) */
+
+    0x05, 0x09,         /* Usage Page (Button) */
+    0x19, 0x01,         /* Usage Minimum (1) */
+    0x29, 0x05,         /* Usage Maximum (5) */
+    0x15, 0x00,         /* Logical Minimum (0) */
+    0x25, 0x01,         /* Logical Maximum (1) */
+    0x95, 0x05,         /* Report Count (5) */
+    0x75, 0x01,         /* Report Size (1) */
+    0x81, 0x02,         /* Input (Data,Var,Abs) */
+
+    0x95, 0x01,         /*  Report Count (1) */
+    0x75, 0x03,         /*  Report Size (3) */
+    0x81, 0x01,         /*  Input (Const) */
+
+    0x05, 0x01,         /*  Usage Page (Generic Desktop) */
+    0x09, 0x30,         /*  Usage (X) */
+    0x09, 0x31,         /*  Usage (Y) */
+    0x95, 0x02,         /*  Report Count (2) */
+    0x75, 0x08,         /*  Report Size (8) */
+    0x15, 0x81,         /*  Logical Minimum (-127) */
+    0x25, 0x7F,         /*  Logical Maximum (127) */
+    0x81, 0x06,         /*  Input (Data,Var,Rel) */
+
+    /* Vertical wheel logical collection */
+    0xA1, 0x02,         /*  Collection (Logical) */
+
+    0x09, 0x38,         /*  Usage (Wheel) */
+    0x15, 0x81,         /*  Logical Minimum (-0x7f) */
+    0x25, 0x7F,         /*  Logical Maximum (0x7f) */
+    0x75, 0x08,         /*  Report Size (8) */
+    0x95, 0x01,         /*  Report Count (1) */
+    0x81, 0x06,         /*  Input (Data,Var,Rel) */
+
+    0xC0,               /*  End Collection */
+
+    /* Horizontal wheel logical collection */
+    0xA1, 0x02,         /*  Collection (Logical) */
+
+    0x05, 0x0C,         /*  Usage Page (Consumer Devices) */
+    0x0A, 0x38, 0x02,   /*  Usage (AC Pan) */
+    0x15, 0x81,         /*  Logical Minimum (-0x7f) */
+    0x25, 0x7F,         /*  Logical Maximum (0x7f) */
+    0x75, 0x08,         /*  Report Size (8) */
+    0x95, 0x01,         /*  Report Count (1) */
+    0x81, 0x06,         /*  Input (Data,Var,Rel) */
+
+    0xC0,               /*  End Collection */
+
+    0xC0,               /*  End Collection (Physical) */
+    0xC0,               /*  End Collection (Logical) */
+    0xC0                /*  End Collection (Application) */
 };
 
 static const USBDescIface desc_iface_mouse = {
@@ -139,7 +173,7 @@ static const USBDescIface desc_iface_mouse = {
         {
             .bEndpointAddress      = USB_DIR_IN | 0x01,
             .bmAttributes          = USB_ENDPOINT_XFER_INT,
-            .wMaxPacketSize        = 4,
+            .wMaxPacketSize        = 6,
             .bInterval             = 0x0a,
         },
     },
@@ -172,7 +206,7 @@ static const USBDescIface desc_iface_mouse2 = {
         {
             .bEndpointAddress      = USB_DIR_IN | 0x01,
             .bmAttributes          = USB_ENDPOINT_XFER_INT,
-            .wMaxPacketSize        = 4,
+            .wMaxPacketSize        = 6,
             .bInterval             = 7, /* 2 ^ (8-1) * 125 usecs = 8 ms */
         },
     },
diff --git a/include/hw/input/hid.h b/include/hw/input/hid.h
index 1e29f4ada4..b7cdeb54c2 100644
--- a/include/hw/input/hid.h
+++ b/include/hw/input/hid.h
@@ -10,6 +10,7 @@
 typedef struct HIDPointerEvent {
     int32_t xdx, ydy; /* relative iff it's a mouse, otherwise absolute */
     int32_t dz, buttons_state;
+    int32_t pan;
 } HIDPointerEvent;
 
 #define QUEUE_LENGTH    16 /* should be enough for a triple-click */
@@ -23,6 +24,7 @@ typedef struct HIDMouseState {
     HIDPointerEvent queue[QUEUE_LENGTH];
     int mouse_grabbed;
     int32_t wheel_residual;
+    int32_t pan_residual;
     bool wheel_state_loaded;
 } HIDMouseState;
 
-- 
2.56.0


