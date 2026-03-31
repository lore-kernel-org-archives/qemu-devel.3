Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DF9D7FF60F4
	for <qemu-devel@archiver.kernel.org>; Tue, 31 Mar 2026 17:09:06 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w7caG-0003oa-15; Tue, 31 Mar 2026 13:08:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <soumyajyotisarkar23@gmail.com>)
 id 1w7caA-0003hc-SB
 for qemu-devel@nongnu.org; Tue, 31 Mar 2026 13:08:53 -0400
Received: from mail-pf1-x441.google.com ([2607:f8b0:4864:20::441])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <soumyajyotisarkar23@gmail.com>)
 id 1w7ca9-0003CE-DH
 for qemu-devel@nongnu.org; Tue, 31 Mar 2026 13:08:50 -0400
Received: by mail-pf1-x441.google.com with SMTP id
 d2e1a72fcca58-82cd5c07f93so603160b3a.1
 for <qemu-devel@nongnu.org>; Tue, 31 Mar 2026 10:08:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1774976927; x=1775581727; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=J8ahBUFbg7fqe92Gw6f+jugDAsKFBZJ7p8mHe2Ycic4=;
 b=JwsznwfbB8YkzGn8KdqRGUoeu7a/0ApAlZz9CnfNCIPMhujb8OJW4Ue6DGWsUYALow
 ovHtrZZgmDICbZxp6m45t3uFig8v2dfyJER8s8tvtG0jAKUB0IINlvVXBwF71e7E7xWC
 00X+WljHK3I8MBQe4rbpyOojIAKlvZsATy6PlZU2eVI05x9LZyJCA3Fdq8y+OOOIub4J
 /Q6id811pzQjQ15+mbz6hbM36dMRL1v4Tj9tqJb2GY+rH4J1IgrLZN17Bsk+k9+5RlTx
 J8THBQeytU4+O2syvOADN+d3VyQavRwRIW1mN173w9KbYnSgDOWxcKReOjBLApEGo3of
 glRg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1774976927; x=1775581727;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=J8ahBUFbg7fqe92Gw6f+jugDAsKFBZJ7p8mHe2Ycic4=;
 b=Sb3/0jZzmm2e3dGkBC2ORFf2uCSd7NMxlq0AWFxmy7Z5nC6VXlAEq21McU+s4rfPk/
 x9ThzaCclfvh4qOWy/xdi+5hqWWvpYT/QNCbJaN/tRsC9dZr1C2flWyNN6HR08T1UtwE
 WBNPlkMlPjd1ySO4Nh30XfhzCbwYlx1Uyf9P7jT6UIbsGq3BVMk3DG3LujIRYO7iYuw7
 EK+L70M5x/emtIQy/9FS0UGojZaagqDYoxDdxKpVQQZ/4DiEjUDLfrKKTF7g/qg647hS
 YcNE8SNF+oj0lbNj8eNmKZZlv9v1nyEJb1GqtAAfy9uryNxGX3JEJIoiT+mmy11ozARZ
 esdQ==
X-Gm-Message-State: AOJu0YxCyJ3OR8Kih6aVvqt9kQCEU+Sevzr/oaaWkWmMsGqZ051wm1VN
 6fAYiSswCeoJdyAjS1yF5z7T7WDgaS3qLlaaDA1ZNNBs1judXzihvTifh1Ykd2ai
X-Gm-Gg: ATEYQzyLCqzgVewUu6btsWqgeQf/qF4JAkKz3aaYAiil0+M+CqOcViqjm9Bun6WCW0M
 6LAY2v6CdQp5KQAVFtplcQ1NRIEYzEf6wUamyc+/Vvgoy9TQBH92efVSOAcyNrv9CzFo8r9VP1E
 vmJZ1HVqgYMSsPCKZ3/EL579H851//UWPumGpr5bVaaAFe/E6nVHIqNhfSTKWLvmGsuweAo0loW
 1VEgFPBGtnbKC4k8rfyH8WCDnxyWTqboUZgFEFis+0KTIkSAvnHYhQmn0QTiKGLOHNlC1P6TEtK
 +MNow347BIbFU9Spxx9aXwcAaOo9vW+JuCjuwSEVxROfDo+7tyVls1xpWXP5FBsDzx+4jfQ2A4t
 9zVSptTrFxaO7GAjIsO9xXm6Bf6/mv01s7jucHXoVL/QVkE19SfDAbslllF35P88kCCk0r5iaQF
 2EAVKPuIOHpPE3TZVUOKzISibXYOEALGDzVmAKIbr1E4Re/gKSorKOcEXZjTbK9yxombBoxY+Nh
 ogMxJzhYTyRcxbgdjwATk9APDIHibDXeq+slmCTXSh0r76PF3pAOU4twe1Rne++P2Tfshwl1gul
 M5pS/esx
X-Received: by 2002:a05:6a00:4fd1:b0:823:3fd0:7a08 with SMTP id
 d2e1a72fcca58-82ce8b42ef2mr333552b3a.49.1774976927503; 
 Tue, 31 Mar 2026 10:08:47 -0700 (PDT)
Received: from fedora ([103.2.232.250]) by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-82ca843b818sm13647889b3a.6.2026.03.31.10.08.42
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 31 Mar 2026 10:08:47 -0700 (PDT)
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
Subject: [RFC PATCH 3/5] input/hid: emit protocol aware mouse reports with pan
 support
Date: Tue, 31 Mar 2026 22:38:21 +0530
Message-ID: <20260331170823.72511-4-soumyajyotisarkar23@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260331170823.72511-1-soumyajyotisarkar23@gmail.com>
References: <20260331170823.72511-1-soumyajyotisarkar23@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::441;
 envelope-from=soumyajyotisarkar23@gmail.com; helo=mail-pf1-x441.google.com
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

Implement protocol-aware mouse report output to support both boot
protocol (protocol 0) and report protocol (protocol 1).

Boot protocol: 4-byte reports (button, dx, dy, dz)
Report protocol: 6-byte reports with report ID 0x01 + pan byte

Both modes now support the 'pan' field for horizontal scrolling. The
distinction ensures correct behavior across different guest operating
systems and their HID implementations.

Signed-off-by: Soumyajyotii Ssarkar <soumyajyotisarkar23@gmail.com>
---
 hw/input/hid.c | 44 +++++++++++++++++++++++++++++++++-----------
 1 file changed, 33 insertions(+), 11 deletions(-)

diff --git a/hw/input/hid.c b/hw/input/hid.c
index 457dbb0096..d0b7af7c13 100644
--- a/hw/input/hid.c
+++ b/hw/input/hid.c
@@ -403,20 +403,42 @@ int hid_pointer_poll(HIDState *hs, uint8_t *buf, int len)

     /* Appears we have to invert the wheel direction */
     dz = 0 - dz;
+    pan = 0 - pan;
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

--
2.53.0


