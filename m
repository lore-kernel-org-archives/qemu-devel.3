Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5B81510F92E0
	for <qemu-devel@archiver.kernel.org>; Tue, 31 Mar 2026 17:09:06 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w7ca3-0003Zi-28; Tue, 31 Mar 2026 13:08:43 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <soumyajyotisarkar23@gmail.com>)
 id 1w7ca0-0003ZD-TN
 for qemu-devel@nongnu.org; Tue, 31 Mar 2026 13:08:40 -0400
Received: from mail-pf1-x442.google.com ([2607:f8b0:4864:20::442])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <soumyajyotisarkar23@gmail.com>)
 id 1w7cZz-0003BZ-Bc
 for qemu-devel@nongnu.org; Tue, 31 Mar 2026 13:08:40 -0400
Received: by mail-pf1-x442.google.com with SMTP id
 d2e1a72fcca58-82cd9d0eceaso829347b3a.3
 for <qemu-devel@nongnu.org>; Tue, 31 Mar 2026 10:08:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1774976917; x=1775581717; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=t6Oeyhq61VM068HLUikqnd7NmAFwnBHXZU5fNxj+eTU=;
 b=V8Z6Wv4XUPaIzvGvJE9kvcLtRVXnpQ03FNvit33g4d8cH2HAXDds5UrU2VQ92w6CBg
 rDAhdyc/Li6OWaAgBhC73s0YNnfAEftKlGhGfU8pfMCrdE0Wd4XEJ6zzOvR8+O4AY+30
 rFTj6VCE3ukztu+TK/npvEIwavCTENUz1c/HZWdO7VFMVQKZtJCsHWzXZ5rxkV8PRhMb
 2IMFYF0nccpU4tARwLE4Fe+cbXUq6ZhrehiX7A/8U8GONFmZg0ggaIUo0dRt8POYJC61
 d5Wm/sa36e/M5iEWCBWdLzoSdSYc+KTsh2/P5y2SRHB614HxFlQCp6NIFnH4Z6N59dBM
 CXNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1774976917; x=1775581717;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=t6Oeyhq61VM068HLUikqnd7NmAFwnBHXZU5fNxj+eTU=;
 b=XI0IA6UZ/p1rl1lqoC4TrmDaNmzUXJ8+7vt9ORasPdGycsj1aPlux+gUUH1pR17ToQ
 pul0aQ4E9oD00J6Qii+TSdXC4RvrWQvmiFmaTCD4/VSB47r6luClsP/ClPK2Q3VBIb+o
 WykOdbMdBmZmZnsRt3D2D5BCyBQHqJhpsm1PKUC83VQFS5bJi8QUfkKyCRswOuNainYc
 zEyFEHsbMH2O+OzY5w6Gy37ieUJFz5jB33CTcenzY8ggfRbhWc33FsQls/xK4f3JtBRs
 GgLJXl/kEJb8DyWdDBPvwzlzO7zMCepdA8R91pC5mH5w0FiXH65tD59dNC2tw78H5neT
 JOXg==
X-Gm-Message-State: AOJu0Ywiw4nfODSmX5GalzxhN2khLCEnOIyADgdueOoZ997TDOwoZA6Y
 e/a/Rhp97w4u/nXOFAnr9bnkL5JyN60PWb1Py01YI3c4BsR6Zqv/GNKTVm/KmSUJ
X-Gm-Gg: ATEYQzwbmVjBXEt9GRU1Z9pDd/MeVOBY5/NLv2ziHbQ9LAkzXpvqpJ4j9jDUyhlboiR
 GYSXjSjN1XRC2q7AdTJbWyJUzazdHKHXrEmb1SfAIvv9XVAr4e6S4nmzw2Ip11Wyz1hsYjoTRKd
 rEgTGS09YMcqDgcn56NkXDQZdR72i1wJwGWui1KvfrdeJ/PNHq8CMocivZNGmLZfV30pu6UTRJw
 Pn1y7UPuWMc4jDQWsrkXm4xrvY7k0VX4w0OiDAw50zYzePD2HBSgrSenEvDfqhCU/BiFN3aZ5A7
 SYzW3gZGRUFcpsPEqDwJUpIVmPoeu2K1VPW6BYBXS+3oHJWr2aP+9/6e+Hbgsa/5J0PqO1IW1ss
 glXriEv+NpCHmEuLPZPDVH7l6ZZwWfBinH5w2kDov1TmXx2ElT7lX9DAHSAZul3gZzlUdA8SpwD
 5/qY8ULn70mu6ocLtbhzLEUBlxwMIAiO8/F1jXR4RReEZTpBbzG5DR08BfT1oUhvU3rsBYUpszG
 ZAoCXzK5ugmZbhkPJsEUm6kgKUezkNLkbLmE2lUHV/ttlAzCReP5Md8Zud+xuvBycrABdRpcw==
X-Received: by 2002:a05:6a00:bd03:b0:82a:8865:6fe6 with SMTP id
 d2e1a72fcca58-82ce8af75f9mr335102b3a.28.1774976917084; 
 Tue, 31 Mar 2026 10:08:37 -0700 (PDT)
Received: from fedora ([103.2.232.250]) by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-82ca843b818sm13647889b3a.6.2026.03.31.10.08.32
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 31 Mar 2026 10:08:36 -0700 (PDT)
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
Subject: [RFC PATCH 1/5] input/hid: add horizontal pan to pointer event path
Date: Tue, 31 Mar 2026 22:38:19 +0530
Message-ID: <20260331170823.72511-2-soumyajyotisarkar23@gmail.com>
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

Add support for horizontal wheel scrolling (pan) in the HID mouse
implementation. Extend the HIDPointerEvent structure with "pan" field
to track horizontal scroll deltas, similar to the existing 'dz' field
for vertical scrolling.

Map INPUT_BUTTON_WHEEL_LEFT and INPUT_BUTTON_WHEEL_RIGHT to pan delta
changes in the event handler. Integrate pan field handling into event
compression logic and queue management to ensure consistent behavior with
vertical wheel events.

This changes enables subsequent patches to implement
multiplier based scaling and protocol aware reporting for horizontal
scrolling.

Signed-off-by: Soumyajyotii Ssarkar <soumyajyotisarkar23@gmail.com>
---
 hw/input/hid.c         | 13 ++++++++++++-
 include/hw/input/hid.h |  1 +
 2 files changed, 13 insertions(+), 1 deletion(-)

diff --git a/hw/input/hid.c b/hw/input/hid.c
index de24cd0ef0..457dbb0096 100644
--- a/hw/input/hid.c
+++ b/hw/input/hid.c
@@ -152,6 +152,10 @@ static void hid_pointer_event(DeviceState *dev, QemuConsole *src,
                 e->dz--;
             } else if (btn->button == INPUT_BUTTON_WHEEL_DOWN) {
                 e->dz++;
+            } else if (btn->button == INPUT_BUTTON_WHEEL_LEFT) {
+                e->pan--;
+            } else if (btn->button == INPUT_BUTTON_WHEEL_RIGHT) {
+                e->pan++;
             }
         } else {
             e->buttons_state &= ~bmap[btn->button];
@@ -208,6 +212,8 @@ static void hid_pointer_sync(DeviceState *dev)
         }
         prev->dz += curr->dz;
         curr->dz = 0;
+        prev->pan += curr->pan;
+        curr->pan = 0;
     } else {
         /* prepare next (clear rel, copy abs + btns) */
         if (hs->kind == HID_MOUSE) {
@@ -218,6 +224,7 @@ static void hid_pointer_sync(DeviceState *dev)
             next->ydy = curr->ydy;
         }
         next->dz = 0;
+        next->pan = 0;
         next->buttons_state = curr->buttons_state;
         /* make current guest visible, notify guest */
         hs->n++;
@@ -357,7 +364,7 @@ void hid_pointer_activate(HIDState *hs)

 int hid_pointer_poll(HIDState *hs, uint8_t *buf, int len)
 {
-    int dx, dy, dz, l;
+    int dx, dy, dz, pan, l;
     int index;
     HIDPointerEvent *e;

@@ -381,9 +388,13 @@ int hid_pointer_poll(HIDState *hs, uint8_t *buf, int len)
     }
     dz = int_clamp(e->dz, -127, 127);
     e->dz -= dz;
+    pan = int_clamp(e->pan, -127, 127);
+    e->pan -= pan;
+

     if (hs->n &&
         !e->dz &&
+        !e->pan &&
         (hs->kind == HID_TABLET || (!e->xdx && !e->ydy))) {
         /* that deals with this event */
         QUEUE_INCR(hs->head);
diff --git a/include/hw/input/hid.h b/include/hw/input/hid.h
index 6a9d7bf466..1bb1778ee7 100644
--- a/include/hw/input/hid.h
+++ b/include/hw/input/hid.h
@@ -10,6 +10,7 @@
 typedef struct HIDPointerEvent {
     int32_t xdx, ydy; /* relative iff it's a mouse, otherwise absolute */
     int32_t dz, buttons_state;
+    int32_t pan;
 } HIDPointerEvent;

 #define QUEUE_LENGTH    16 /* should be enough for a triple-click */
--
2.53.0


