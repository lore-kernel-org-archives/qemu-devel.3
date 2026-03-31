Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6A65EFF60F4
	for <qemu-devel@archiver.kernel.org>; Tue, 31 Mar 2026 17:09:26 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w7caK-0003wa-So; Tue, 31 Mar 2026 13:09:01 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <soumyajyotisarkar23@gmail.com>)
 id 1w7caG-0003pT-Lj
 for qemu-devel@nongnu.org; Tue, 31 Mar 2026 13:08:56 -0400
Received: from mail-pf1-x442.google.com ([2607:f8b0:4864:20::442])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <soumyajyotisarkar23@gmail.com>)
 id 1w7caF-0003Cd-6u
 for qemu-devel@nongnu.org; Tue, 31 Mar 2026 13:08:56 -0400
Received: by mail-pf1-x442.google.com with SMTP id
 d2e1a72fcca58-829a9d08644so3156308b3a.1
 for <qemu-devel@nongnu.org>; Tue, 31 Mar 2026 10:08:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1774976932; x=1775581732; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=W/Vp9csjxDdP8UCdEEf84+/qxz8piPF+LrR8kcVgFz0=;
 b=tBHGtJrAfydRqCBxljz5f9awSV+vffYEO8epUIv3pQSWh4tlvqPD8BG2CJ9vBYOihv
 Sp9fxnfh4BH76Jfto9CIOyRDZjq3O2F63UUA1wtU/4aMNUOp9zxECYv78Uvbg/1Wq7jO
 6l8dplOSgnyuUcYvthFW3mjgWGATISK7VnT5qfwB68fdd/Yb4fK4iWe0wEko3IM3aQGN
 Nowcb4/dnm89ToqGlgMHCpGl1nRedsacw7cpvsNqkmUv0MZhaPkpQry46m0/S+p7Y6Jk
 W1NWrzWvJWEcVvA2nCn9SikpJIdNlFRDLZv8+DQhqoehKRBi7wOb52dg8K2dwzMTKgs4
 Yi3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1774976932; x=1775581732;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=W/Vp9csjxDdP8UCdEEf84+/qxz8piPF+LrR8kcVgFz0=;
 b=ZLNr5uqxuVWWuOibMClP0uGtCvCJT12X5IAOwqFLY6jstphPQ1+Uu4PIAR5FNMhJmQ
 iOOLml+ElWgkys93pMMipTAusNkYLV4+6w915AEcLaO0zuhS48mevuDBUkp+5O/Ti7Rb
 RVQijk8i1s2eBQnfnUI8EkFMH4nnvcBFzsmIu/KyTAGwLFfO7A7Npm4PW9LhaK+BKFh5
 SOYFxGZbjLZ920gj4O8t6WQK5gMKdN/l0kLwMUV459XUPBZVZw3kwH8snB8mO1/KQPrf
 UfiCn+6z2Rmy/BNDZCKwiQdVeTQ9pZkKublkpobxwtCgC3gEsloP4nsHuL+S3wu5Eoom
 49fQ==
X-Gm-Message-State: AOJu0YxvwJKI2qrzrpcGqoeiaaXKfqUqPaiGQqN/ieaobtkDHRd5MPqR
 /CxubIsEQueAdOTurL+USoTrzbxzCBOio3Vm90oQ9WFkFrZpF3D2jIbVBFBG38OF
X-Gm-Gg: ATEYQzx50VTOS8ULWpg/Gd191FCD0LsEuXl40yPrmc95DCxnNnxsE5lLsub6nCL5sQL
 19uqe2dBVVW0gZzhnMGp0zrbjUOPtfbFUqS3mzDct4CJBr5yWu+6PRjt3H8XaPuw8vBAxGBxRNz
 2aXVnLedFgQ7jiUCLBgEePA6F/D0ts2Wv4r6IXQ2Pnhq3tm7edtMNnzX2en0d8inrPta3GktS10
 oPoqne7slySWb8tfWvoILaHjePwev7uJ6Tx+kChBeXdxgeH+xylMvF6WRhUNlC81/pM2e20QrX3
 xr45vFjjrGKZyWmdLUrzLZcjgNU08h5vP9xfW3WoZIvPZor03QzvxKXYVAbBqueLTg7qpf44de5
 WFKW6o2t22nLgmZEffCDlqsWV3IVFPSysOmZHpYOI3KIqTYqXCn1lNUDhKX5iLEFqlVJHxRc0qG
 VpZxXI0TD8OKIcMYnWZwkfs0RvMDd3F3drS10SOG4R5QzE3PiuPe/q2fs4p8b1nxjFZ+sQv091N
 8lC7Ie9iA9QMHepClfAfa+nNwjWqmt0B8s0HwLvRF1QU2PEs4vSdaoEFEA2TOdXdiHUrXurdg==
X-Received: by 2002:a05:6a00:a1b:b0:7aa:a2a8:9808 with SMTP id
 d2e1a72fcca58-82ce893ed22mr420788b3a.20.1774976932503; 
 Tue, 31 Mar 2026 10:08:52 -0700 (PDT)
Received: from fedora ([103.2.232.250]) by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-82ca843b818sm13647889b3a.6.2026.03.31.10.08.47
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 31 Mar 2026 10:08:51 -0700 (PDT)
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
Subject: [RFC PATCH 4/5] usb/hid: handle mouse feature report for wheel/pan
 multipliers
Date: Tue, 31 Mar 2026 22:38:22 +0530
Message-ID: <20260331170823.72511-5-soumyajyotisarkar23@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260331170823.72511-1-soumyajyotisarkar23@gmail.com>
References: <20260331170823.72511-1-soumyajyotisarkar23@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::442;
 envelope-from=soumyajyotisarkar23@gmail.com; helo=mail-pf1-x442.google.com
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

Implement HID feature report handlers (GET_REPORT/SET_REPORT) for
report ID 0x02 to allow guests to configure wheel/pan resolution
multipliers.

Multiplier encoding:
- Bits [1:0]: wheel_multiplier (0=+-1, 1=+-4, 2=+-8, 3=+-16)
- Bits [3:2]: pan_multiplier (0=+-1, 1=+-4, 2=+-8, 3=+-16)

Supports flexible payload formats (with/without report ID byte).
Allows Windows guests to dynamically adjust scroll sensitivity without
driver installation.

Signed-off-by: Soumyajyotii Ssarkar <soumyajyotisarkar23@gmail.com>
---
 hw/usb/dev-hid.c       | 65 ++++++++++++++++++++++++++++++++++++------
 include/hw/input/hid.h |  2 ++
 2 files changed, 59 insertions(+), 8 deletions(-)

diff --git a/hw/usb/dev-hid.c b/hw/usb/dev-hid.c
index 49e23c2319..cdcf2a4a0e 100644
--- a/hw/usb/dev-hid.c
+++ b/hw/usb/dev-hid.c
@@ -672,17 +672,66 @@ static void usb_hid_handle_control(USBDevice *dev, USBPacket *p,
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
index 1bb1778ee7..1a1941d371 100644
--- a/include/hw/input/hid.h
+++ b/include/hw/input/hid.h
@@ -23,6 +23,8 @@ typedef void (*HIDEventFunc)(HIDState *s);
 typedef struct HIDMouseState {
     HIDPointerEvent queue[QUEUE_LENGTH];
     int mouse_grabbed;
+    uint8_t wheel_multiplier;
+    uint8_t pan_multiplier;
 } HIDMouseState;

 typedef struct HIDKeyboardState {
--
2.53.0


