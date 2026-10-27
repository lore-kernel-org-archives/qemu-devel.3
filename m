Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 74114606A31D
	for <qemu-devel@archiver.kernel.org>; Tue, 27 Oct 2026 19:44:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=JbVRppq8
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xLn54-0006qh-3G; Tue, 27 Oct 2026 15:43:34 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <soumyajyotisarkar23@gmail.com>)
 id 1xLn51-0006pQ-RO
 for qemu-devel@nongnu.org; Tue, 27 Oct 2026 15:43:33 -0400
Received: from mail-dl2-x04.google.com ([2607:f8b0:4864:38::4])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <soumyajyotisarkar23@gmail.com>)
 id 1xLn4y-0003tc-Jq
 for qemu-devel@nongnu.org; Tue, 27 Oct 2026 15:43:30 -0400
Received: by mail-dl2-x04.google.com with SMTP id
 a92af1059eb24-1922a6f0d23so30335c88.0
 for <qemu-devel@nongnu.org>; Tue, 27 Oct 2026 12:43:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20260707; t=1793130207; x=1793735007; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=kV9MGrhLfQt8+CvLTa6nad43g4dkqoltiDEq1TElRZs=;
 b=JbVRppq86K5HxTn/+d1A0d3ZhkuGEfuzt+In68u3uZg2SaC9yAkQOcmDM6gIYcq0/K
 PKfJUmlK4hCbbD2E1oLVrhF+k4M/MOQLfUaXxfd97GuGAQGooAMzcqJBit45pEjDZoho
 Mc8eJlQhd6DYXDZbaUqLsWjkQRcipS1wEeYOBQlvZTj+N8w2wG+vKSxgGwBF+di8vcG9
 d0zUKY//jEjarGkk3p97yoKo+X3VCVOrLKKy4k07/en9zenr2bsE+H8Gj9diHd2WSFqP
 AOmXYiJgppJxbN/pGxboay8silsH7vS3xSUj2P2/Q1xbZahrgkzad9x7XPMTnE2Lp4pw
 kuEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793130207; x=1793735007;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=kV9MGrhLfQt8+CvLTa6nad43g4dkqoltiDEq1TElRZs=;
 b=yZ2VQghshrrnqxERlSVZFAPFrHyIoOe2Peci2nyUttR7OCIIUAyUUr360qayJSdzCP
 OPstpt4OHOQacmu0YLL5SMDEw7HQ1oCrqSdVsCSLPypN9TBgaxkE5G13omor+oZte+GX
 cjj5H2vpkFqgg1S3XZ+54r8YuRPOlMjOwm5jRmwznXgCXwRP53WYwEHB2RyHmgu4hiZe
 vSfBRSBQjHjiaY7ssfcJ92FW2zabgSxaUXdBiZrRrdeYotuIBj94STBskvJbsZIWtDPi
 c5/dWzaKtuJBtu9sXEAHFSI/26aaAsIPRYzxp+cVdAbRO5dzYCefmq5MnTtcCSCxc+yi
 zIlA==
X-Forwarded-Encrypted: i=1;
 AKwUvBxaVy6812dXGK0bFxBsFXb64YLK4ZhAhWWfKnsQQ0ocRT69A37IppPMae1VOM9rBb7VE9n8LP6QbUeh@nongnu.org
X-Gm-Message-State: AFq9FYJDjTQ5wtKP0qq8XVqmsTWCUUsKcLFPZWfc1ApAPGklvXpo/eM6
 5u9KgGSjTWS5uoMRbQiL98lmqQ+FE6eIDcpcp0r/phFLs0Cj2AXpgG9y
X-Gm-Gg: AYBFou3uv14DNkVHTJ9noXZDh48nfUOk3zmKXVvFiRaRAbZ5NgUb52PX2s30IsIkIcY
 DdiwyH6JZvqS69J1XCs9kRQzrJw+h9Dg/wDyV2LMCnsQWOHlyKlmKabXX+t7G50FqcifutlEvJm
 Ryb3V3I8GdhrraaOXJrGepIHrw76zmOs1N1xOJRI9f9WtxZ2oCuNCciIpLumsxPtdsJr2WUpo/X
 PDwD+kmTuC+8GVMNIjleXBLDFLLbKWdpGEkdHt98bQ2wiXuHNmnZ6eGJmgnMedtWZVDRFr6HYkm
 rAZFjtxVixu0AbwdXTCco+FPVu0USbqh08nOxq5V175bfXxKCKy6ODOhzigwsJHKd1yeX2ArrJ0
 hn/+9lPksAaFWVEWb7bahIZkQ4mm6EJMboNgNlUZabvVSoYjC3AZxkt0ICExqT3bpBkzqJAKYTR
 2/mxe6S/QFEgg5IaOFZIma1uNwaVLBgUFwa3/8ZDyiz7Dx/YDVDAtfdqV/8a7K2t61GsG3Q3Mx9
 p5g/Z8IXixCZpJe8FXc5qYGNt4TYw6rY3/9hBgVSxRh9NVlc1rhtOWfvfBlvpdo3WtpaaWGIS2C
 xXvgQWhaN5hhtc5OaoO9M7dtFocdRveSwUGHyfdu5a82dFY/HzH4pAgrrZdDailWHSnbWUMn+ah
 XxtCOTg5phrsOf7UwifmC+mIut4ttSPbprBgjfG3SqIoJndq+pA==
X-Received: by 2002:a05:693c:23c4:b0:36a:15c3:2aaa with SMTP id
 5a478bee46e88-36a200d82ccmr935861eec.29.1793130206717; 
 Tue, 27 Oct 2026 12:43:26 -0700 (PDT)
Received: from fedora.tail9bb79b.ts.net ([119.82.106.50])
 by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-36a064510b0sm20446558eec.2.2026.10.27.12.43.22
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 27 Oct 2026 12:43:26 -0700 (PDT)
From: soumyajyotisarkar23@gmail.com
To: sarkarsoumyajyoti23@gmail.com,
	qemu-devel@nongnu.org
Cc: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Helge Deller <deller@kernel.org>, Eric Blake <eblake@redhat.com>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Markus Armbruster <armbru@redhat.com>,
 Soumyajyotii Ssarkar <soumyajyotisarkar23@gmail.com>
Subject: [PATCH v2 5/8] hw/input/hid: accept high-resolution vertical scroll
 events
Date: Wed, 28 Oct 2026 01:12:53 +0530
Message-ID: <20261027194256.76031-6-soumyajyotisarkar23@gmail.com>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <20261027194256.76031-1-soumyajyotisarkar23@gmail.com>
References: <20261027194256.76031-1-soumyajyotisarkar23@gmail.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:38::4;
 envelope-from=soumyajyotisarkar23@gmail.com; helo=mail-dl2-x04.google.com
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

Keep the pending vertical wheel movement in 1/120 detent units instead
of whole detents and let the HID mouse receive scroll events directly
by setting INPUT_EVENT_MASK_SCROLL. Wheel button clicks now add a full
detent (120 units).

hid_pointer_poll() still reports whole detents, so the guest-visible
behaviour does not change yet. The sub-detent remainder is kept in a
per-device residual so that slow scrolling adds up instead of being
dropped and whole detents that do not fit into the 8-bit report field
stay queued for the next poll as before.

The residual is migrated in a new optional subsection, which is only
sent while wheel movement is pending. Because the unit of the queued
dz values changes an incoming stream without the subsection (from an
older QEMU, or with no wheel movement pending) has its queued dz values
converted from detents to 1/120 units in post_load.

Signed-off-by: Soumyajyotii Ssarkar <soumyajyotisarkar23@gmail.com>
---
 hw/input/hid.c         | 97 +++++++++++++++++++++++++++++++++++++++---
 include/hw/input/hid.h |  2 +
 2 files changed, 93 insertions(+), 6 deletions(-)

diff --git a/hw/input/hid.c b/hw/input/hid.c
index 0f28827554..2855f6a3d9 100644
--- a/hw/input/hid.c
+++ b/hw/input/hid.c
@@ -145,15 +145,21 @@ static void hid_pointer_event(DeviceState *dev, QemuConsole *src,
         if (evt->btn.down) {
             e->buttons_state |= bmap[evt->btn.button];
             if (evt->btn.button == INPUT_BUTTON_WHEEL_UP) {
-                e->dz--;
+                e->dz -= INPUT_EVENT_SCROLL_DETENT;
             } else if (evt->btn.button == INPUT_BUTTON_WHEEL_DOWN) {
-                e->dz++;
+                e->dz += INPUT_EVENT_SCROLL_DETENT;
             }
         } else {
             e->buttons_state &= ~bmap[evt->btn.button];
         }
         break;
 
+    case INPUT_EVENT_KIND_SCROLL:
+        if (evt->scroll.axis == INPUT_SCROLL_AXIS_VERTICAL) {
+            e->dz += evt->scroll.value;
+        }
+        break;
+
     default:
         /* keep gcc happy */
         break;
@@ -349,6 +355,18 @@ void hid_pointer_activate(HIDState *hs)
     }
 }
 
+static int hid_scroll_counts(int32_t *pending, int32_t *residual, int mult)
+{
+    int unit = INPUT_EVENT_SCROLL_DETENT / mult;
+    int32_t acc = *pending + *residual;
+    int counts = int_clamp(acc / unit, -127, 127);
+
+    acc -= counts * unit;
+    *residual = acc % unit;
+    *pending = acc - *residual;
+    return counts;
+}
+
 int hid_pointer_poll(HIDState *hs, uint8_t *buf, int len)
 {
     int dx, dy, dz, l;
@@ -373,8 +391,7 @@ int hid_pointer_poll(HIDState *hs, uint8_t *buf, int len)
         dx = e->xdx;
         dy = e->ydy;
     }
-    dz = int_clamp(e->dz, -127, 127);
-    e->dz -= dz;
+    dz = hid_scroll_counts(&e->dz, &hs->ptr.wheel_residual, 1);
 
     if (hs->n &&
         !e->dz &&
@@ -513,7 +530,8 @@ static const QemuInputHandler hid_keyboard_handler = {
 
 static const QemuInputHandler hid_mouse_handler = {
     .name  = "QEMU HID Mouse",
-    .mask  = INPUT_EVENT_MASK_BTN | INPUT_EVENT_MASK_REL,
+    .mask  = INPUT_EVENT_MASK_BTN | INPUT_EVENT_MASK_REL |
+             INPUT_EVENT_MASK_SCROLL,
     .event = hid_pointer_event,
     .sync  = hid_pointer_sync,
 };
@@ -585,11 +603,74 @@ static const VMStateDescription vmstate_hid_ptr_queue = {
     }
 };
 
+/*
+ * Wheel movement used to be queued in whole detents and is now kept in
+ * 1/120 detent units.  Without this subsection the source either was an
+ * older QEMU or had no wheel state pending, so rescaling dz is safe.
+ */
+static bool hid_ptr_wheel_needed(void *opaque)
+{
+    HIDState *s = opaque;
+    int i;
+
+    if (s->ptr.wheel_residual) {
+        return true;
+    }
+    for (i = 0; i < QUEUE_LENGTH; i++) {
+        if (s->ptr.queue[i].dz) {
+            return true;
+        }
+    }
+    return false;
+}
+
+static int hid_ptr_pre_load(void *opaque)
+{
+    HIDState *s = opaque;
+
+    s->ptr.wheel_state_loaded = false;
+    return 0;
+}
+
+static int hid_ptr_wheel_post_load(void *opaque, int version_id)
+{
+    HIDState *s = opaque;
+
+    s->ptr.wheel_state_loaded = true;
+    return 0;
+}
+
+static int hid_ptr_post_load(void *opaque, int version_id)
+{
+    HIDState *s = opaque;
+    int i;
+
+    if (!s->ptr.wheel_state_loaded) {
+        for (i = 0; i < QUEUE_LENGTH; i++) {
+            s->ptr.queue[i].dz *= INPUT_EVENT_SCROLL_DETENT;
+        }
+    }
+    return hid_post_load(opaque, version_id);
+}
+
+static const VMStateDescription vmstate_hid_ptr_wheel = {
+    .name = "HIDPointerDevice/wheel",
+    .version_id = 1,
+    .minimum_version_id = 1,
+    .needed = hid_ptr_wheel_needed,
+    .post_load = hid_ptr_wheel_post_load,
+    .fields = (const VMStateField[]) {
+        VMSTATE_INT32(ptr.wheel_residual, HIDState),
+        VMSTATE_END_OF_LIST()
+    }
+};
+
 const VMStateDescription vmstate_hid_ptr_device = {
     .name = "HIDPointerDevice",
     .version_id = 1,
     .minimum_version_id = 1,
-    .post_load = hid_post_load,
+    .pre_load = hid_ptr_pre_load,
+    .post_load = hid_ptr_post_load,
     .fields = (const VMStateField[]) {
         VMSTATE_STRUCT_ARRAY(ptr.queue, HIDState, QUEUE_LENGTH, 0,
                              vmstate_hid_ptr_queue, HIDPointerEvent),
@@ -598,6 +679,10 @@ const VMStateDescription vmstate_hid_ptr_device = {
         VMSTATE_INT32(protocol, HIDState),
         VMSTATE_UINT8(idle, HIDState),
         VMSTATE_END_OF_LIST(),
+    },
+    .subsections = (const VMStateDescription * const []) {
+        &vmstate_hid_ptr_wheel,
+        NULL
     }
 };
 
diff --git a/include/hw/input/hid.h b/include/hw/input/hid.h
index 6a9d7bf466..1e29f4ada4 100644
--- a/include/hw/input/hid.h
+++ b/include/hw/input/hid.h
@@ -22,6 +22,8 @@ typedef void (*HIDEventFunc)(HIDState *s);
 typedef struct HIDMouseState {
     HIDPointerEvent queue[QUEUE_LENGTH];
     int mouse_grabbed;
+    int32_t wheel_residual;
+    bool wheel_state_loaded;
 } HIDMouseState;
 
 typedef struct HIDKeyboardState {
-- 
2.56.0


