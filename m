Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 04E63FF60F4
	for <qemu-devel@archiver.kernel.org>; Tue, 31 Mar 2026 17:09:24 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w7caN-0004EK-Rc; Tue, 31 Mar 2026 13:09:04 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <soumyajyotisarkar23@gmail.com>)
 id 1w7caL-00041X-0Q
 for qemu-devel@nongnu.org; Tue, 31 Mar 2026 13:09:01 -0400
Received: from mail-pf1-x444.google.com ([2607:f8b0:4864:20::444])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <soumyajyotisarkar23@gmail.com>)
 id 1w7caJ-0003Cw-7v
 for qemu-devel@nongnu.org; Tue, 31 Mar 2026 13:09:00 -0400
Received: by mail-pf1-x444.google.com with SMTP id
 d2e1a72fcca58-82cd5c07f93so603224b3a.1
 for <qemu-devel@nongnu.org>; Tue, 31 Mar 2026 10:08:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1774976937; x=1775581737; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=r6LmsEgjBpvDaeps0oORvh1u7wQKk8Q2dxRBNItGx1w=;
 b=lB9+2sk7LMfrC1aNV+yH3ljBXh2kiENduHNH1eAEV+ZukviyPwjWrClGXM2gqluTEZ
 6fTu3lvA9+yZA9NABSTzamhSzNjuHNVzu1YIkasY2/BPxIcWS0uvPvwmL4XK6fn97gac
 +U+WOVkSNFxHYmnEjp3XMg5LW8PefIiDAOz4vY7wMNORCLxdOLnPt7dix7vJJkDyIWPC
 W+kuoRZMeFVvCQJWGyIcdxqLDxZzIgAN+gb3/3X4d26i3STK+c5sFSsGxHRvEgyJKQtI
 8f3LTg16cbNTzcXodlRLEdLs4RHWraLOPBSU4Ez42u5U5wI7KCRDNVEaNSpNAQ2H7JMB
 yAfQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1774976937; x=1775581737;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=r6LmsEgjBpvDaeps0oORvh1u7wQKk8Q2dxRBNItGx1w=;
 b=aMDBeB65CIXFu/ClWhQGjqRT6mzFCRFwEmO6WnG/2f9a8jZAIlDB0cb4UwEcoSiSwM
 6SzhFhOW7VAAOw3L+T5QDI883jBHtrZ8nrvsg+YaEEUX1boTYsczK5y3z2ONkxAc2Oxz
 rrDAlyZgNqAZscjw1NJ63pW+unPcsHnfY6gl6SvnmLBdP8tvmTrmxJXFOBcvbP5HfByA
 jXvk8dyyewb+Ws70hksIa460fXPTPxv4EW3tgfTmenTiQs5Oq87sPfjUXnbkhqTssrnq
 3w6SQT/T/eL00+1192OR5bePRvKH3nmoafDlmyVRVChXD+75GHwj1lsgo06Tn6QLp6UK
 iQeA==
X-Gm-Message-State: AOJu0YypnOU3Z3zD8og79jKwst2Lo5LIL8+l7z8NsTdOZqs/Uz/F1B9M
 eDBbl9u8j8QKkPQfD3p7WkLJn0I1sgo7EUn5zvGG5sbqp0ZiAVC2emxSCxB/DTeR
X-Gm-Gg: ATEYQzyMJZtpWZ/pY5AuQrgNNKaiXIEAdVu5aAhCwL9/f8xGD7fbbI7XuqEgKO+PPss
 o5skH/aEzagiL+1lKql5MYlzZU2TMlI3ipQSXMJVOhYpFzV095FVdVs2dVzK1RoUagesj5ruUpa
 hyagq8eSX2Xp17u5u8EU9K2/ga6kWN5ujurqse5a6sr3VjUKCz5czY+fHtZ3kGchUgkKn23e0mJ
 Jzzv8pct2Hgs0GoO3xcIa1am8YIuwqzFxEOkcBXBpJ5LhpZ7FE0+0V9wsRV4bCe7uWnoSpdnvtQ
 r4YxJ4zlLtWnIEWpYxj4MuTy6wdN2PP8tPIYyUivna9KDffMopfss9HWcmklPP/vRcXrhiYHJah
 R+YvAwWl6427TgQYvNo+MX3mPRhUr78qw1Dc/JsjfaAMHlADXbPBzI45gAtGiVBT7VAyk7isMqp
 n0lFkehP/ZKWsmbQTNCQGiyZYXrmLv4wZzMHDM73DtCwMxZggpmf5x7oOWhNZp+hAORgjXDV//2
 t8YQk+Vxh4So38SZ9S9mwd5whiDardVj0CH0WFT5lfz6WCIhroi5JwizwtrBg93DWsLFBzDoo28
 X5L5Vv1+
X-Received: by 2002:a05:6a00:4505:b0:82c:7f08:8826 with SMTP id
 d2e1a72fcca58-82ce892c23emr342082b3a.17.1774976937342; 
 Tue, 31 Mar 2026 10:08:57 -0700 (PDT)
Received: from fedora ([103.2.232.250]) by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-82ca843b818sm13647889b3a.6.2026.03.31.10.08.53
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 31 Mar 2026 10:08:56 -0700 (PDT)
From: Soumyajyotii Ssarkar <soumyajyotisarkar23@gmail.com>
To: qemu-devel@nongnu.org
Cc: Richard Henderson <richard.henderson@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Soumyajyotii Ssarkar <sarkarsoumyajyoti23@gmail.com>,
 Michael Tokarev <mjt@tls.msk.ru>,
 Thomas Lambertz <patch@thomaslambertz.de>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Alex Golovko <alex@browserling.com>, ShengYi Hung <aokblast@FreeBSD.org>,
 Soumyajyotii Ssarkar <soumyajyotisarkar23@gmail.com>
Subject: [RFC PATCH 5/5] input/hid: apply multiplier scaling with residual
 accumulation
Date: Tue, 31 Mar 2026 22:38:23 +0530
Message-ID: <20260331170823.72511-6-soumyajyotisarkar23@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260331170823.72511-1-soumyajyotisarkar23@gmail.com>
References: <20260331170823.72511-1-soumyajyotisarkar23@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::444;
 envelope-from=soumyajyotisarkar23@gmail.com; helo=mail-pf1-x444.google.com
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
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

Implement multiplier-based scaling with residual accumulation for
fine-grained mouse wheel and pan sensitivity control in report mode.

Applies divisor based scaling (1, 4, 8, 16) based on negotiated
multiplier values.
Then uses residual based approach to prevent precision loss:

  residual += delta
  output = residual / divisor
  residual -= output * divisor

Residual state preserved across VM migrations via VMState.

Signed-off-by: Soumyajyotii Ssarkar <soumyajyotisarkar23@gmail.com>
---
 hw/input/hid.c         | 60 ++++++++++++++++++++++++++++++++++++++++++
 include/hw/input/hid.h |  2 ++
 2 files changed, 62 insertions(+)

diff --git a/hw/input/hid.c b/hw/input/hid.c
index d0b7af7c13..9b800faeb0 100644
--- a/hw/input/hid.c
+++ b/hw/input/hid.c
@@ -365,6 +365,7 @@ void hid_pointer_activate(HIDState *hs)
 int hid_pointer_poll(HIDState *hs, uint8_t *buf, int len)
 {
     int dx, dy, dz, pan, l;
+    int wheel_divisor, pan_divisor;
     int index;
     HIDPointerEvent *e;

@@ -392,6 +393,54 @@ int hid_pointer_poll(HIDState *hs, uint8_t *buf, int len)
     e->pan -= pan;


+    if (hs->kind == HID_MOUSE && hs->protocol != 0) {
+        switch (hs->ptr.wheel_multiplier & 0x03) {
+        case 0:
+            wheel_divisor = 1;
+            break;
+        case 1:
+            wheel_divisor = 4;
+            break;
+        case 2:
+            wheel_divisor = 8;
+            break;
+        default:
+            wheel_divisor = 16;
+            break;
+        }
+
+        switch (hs->ptr.pan_multiplier & 0x03) {
+        case 0:
+            pan_divisor = 1;
+            break;
+        case 1:
+            pan_divisor = 4;
+            break;
+        case 2:
+            pan_divisor = 8;
+            break;
+        default:
+            pan_divisor = 16;
+            break;
+        }
+
+        if (wheel_divisor > 1) {
+            hs->ptr.wheel_residual += dz;
+            dz = hs->ptr.wheel_residual / wheel_divisor;
+            hs->ptr.wheel_residual -= dz * wheel_divisor;
+        } else {
+            hs->ptr.wheel_residual = 0;
+        }
+
+        if (pan_divisor > 1) {
+            hs->ptr.pan_residual += pan;
+            pan = hs->ptr.pan_residual / pan_divisor;
+            hs->ptr.pan_residual -= pan * pan_divisor;
+        } else {
+            hs->ptr.pan_residual = 0;
+        }
+    }
+
     if (hs->n &&
         !e->dz &&
         !e->pan &&
@@ -405,6 +454,7 @@ int hid_pointer_poll(HIDState *hs, uint8_t *buf, int len)
     dz = 0 - dz;
     pan = 0 - pan;
     l = 0;
+
     switch (hs->kind) {
     case HID_MOUSE:
         if (hs->protocol == 0) {
@@ -528,6 +578,11 @@ void hid_reset(HIDState *hs)
     case HID_MOUSE:
     case HID_TABLET:
         memset(hs->ptr.queue, 0, sizeof(hs->ptr.queue));
+        hs->ptr.mouse_grabbed = 0;
+        hs->ptr.wheel_multiplier = 0;
+        hs->ptr.pan_multiplier = 0;
+        hs->ptr.wheel_residual = 0;
+        hs->ptr.pan_residual = 0;
         break;
     }
     hs->head = 0;
@@ -619,6 +674,7 @@ static const VMStateDescription vmstate_hid_ptr_queue = {
         VMSTATE_INT32(xdx, HIDPointerEvent),
         VMSTATE_INT32(ydy, HIDPointerEvent),
         VMSTATE_INT32(dz, HIDPointerEvent),
+        VMSTATE_INT32(pan, HIDPointerEvent),
         VMSTATE_INT32(buttons_state, HIDPointerEvent),
         VMSTATE_END_OF_LIST()
     }
@@ -636,6 +692,10 @@ const VMStateDescription vmstate_hid_ptr_device = {
         VMSTATE_UINT32(n, HIDState),
         VMSTATE_INT32(protocol, HIDState),
         VMSTATE_UINT8(idle, HIDState),
+        VMSTATE_UINT8(ptr.wheel_multiplier, HIDState),
+        VMSTATE_UINT8(ptr.pan_multiplier, HIDState),
+        VMSTATE_INT32(ptr.wheel_residual, HIDState),
+        VMSTATE_INT32(ptr.pan_residual, HIDState),
         VMSTATE_END_OF_LIST(),
     }
 };
diff --git a/include/hw/input/hid.h b/include/hw/input/hid.h
index 1a1941d371..db902fa023 100644
--- a/include/hw/input/hid.h
+++ b/include/hw/input/hid.h
@@ -25,6 +25,8 @@ typedef struct HIDMouseState {
     int mouse_grabbed;
     uint8_t wheel_multiplier;
     uint8_t pan_multiplier;
+    int32_t wheel_residual;
+    int32_t pan_residual;
 } HIDMouseState;

 typedef struct HIDKeyboardState {
--
2.53.0


