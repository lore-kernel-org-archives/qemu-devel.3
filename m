Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 251A1CD343F
	for <qemu-devel@archiver.kernel.org>; Thu,  7 May 2026 13:47:53 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wKz4m-0007to-1Q; Thu, 07 May 2026 09:47:40 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1wKz4b-0007rR-9b
 for qemu-devel@nongnu.org; Thu, 07 May 2026 09:47:31 -0400
Received: from mail-wm1-x334.google.com ([2a00:1450:4864:20::334])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1wKz4Z-0004T6-9K
 for qemu-devel@nongnu.org; Thu, 07 May 2026 09:47:28 -0400
Received: by mail-wm1-x334.google.com with SMTP id
 5b1f17b1804b1-488a8ca4aadso8390295e9.3
 for <qemu-devel@nongnu.org>; Thu, 07 May 2026 06:47:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1778161645; x=1778766445; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=q9chL/SLwUMeu/2j+R75W2A1pHuRpO6RtXQfsY6XREY=;
 b=Xyl6YXSz1Q+5iVz9eLoTbjSrRzZ2qayN7VAq10jx5pFh7gYiEpxj5iWt9oGETJSFrK
 qiCardtFl+dV8GrkNCdsLe08N4Bjr17cQmJxE2JJEBBvVusJkUFjk+/paOacr65MbhHa
 vy7HF5nGFY7LgPPB4CKgbuAMY5CbKbNswBh5wLNPvwOWdq9TjVqjyBSycXOFudu7qjb6
 7NmzxIdbTIq8iXwOraP+55zDIAqpZ5vlQehgzthjWPNpp5DcwsXdEu8MKpO8yIYAbA7z
 vO89JuCSMI/X1hN6uQTJUXNwPXQ7BAdK5b7mvBFDyQVQB3wynHcaTtOxvPrNk28WlWhQ
 ulQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1778161645; x=1778766445;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=q9chL/SLwUMeu/2j+R75W2A1pHuRpO6RtXQfsY6XREY=;
 b=FgkHXAKLosWVHBkXCaPKvqVkM/ZRSq9C3JhbFX0ARZ+QP17UpfI5XL3M7oXGmb8ztX
 aa1UUOrSKIgjqZWwLflNw0tugVEv6duh3jSxoPD7t7BSxo4RzWY9k+7OSc4CzUyUbmTD
 UX7CkDshrT95bGrOKc+6pqWE/rnu1JxQRfFvMUzvoJ7RTLAQahyEHqt2NsE+nn7B+SMw
 rZZ3iABPjTqgb9J640Pm/afcpM//6hWTQ4xpHDn6cB7Ybg1P7qMsDInkOU6zE0J7vbn2
 F7tEZr9NTpK2+Qe15M9FIm8PvDg+4vMTJQQRZQXawhXR0jJJTPbbjGZGbT+X9pPFKDHC
 oOgg==
X-Gm-Message-State: AOJu0YzFUg+zIa1olM/0SlNT8TW0lSQdpwhYEtxeMHtZvESJacU+WZAB
 zvURBi9YFGM/OVzH2HocEqVRdr5TW8gn3agMM1u5p09umeS7Us7A15Nb09iWC9S50wzqYPMQxn2
 eEdYzNt4=
X-Gm-Gg: AeBDieurFlL64FA6kDaBDI0nclY4pZ4LXLV4f09a7TxTp00TUmrBG02vO6RVSAJzI2A
 aPlN5dAzP+Xhqz6kyQg0aLt4zzuxiL55J7n6LNrADD5CD1yRg6sHSQASF4r3L3gTeGJci7aWKoO
 cmQGJrYTN+smMSIQDVKxqRuv6ASh9IQNKXvEYH8akUR0zb81regkhpkyswG+3JOIhcW6nsQLu+c
 LsdnUebdtspXbQv3Jam7l6aVhBbXyFjNi6scjZWQyDkpaCOyxamgaYstINJxUr3wYMmHWQaQ9j/
 ZuhncVuYN0R/anTMp0zLC+PZkuYE7D8dFwTdzdKaYG38VtrLOB6LKh6v86fGcd2oQEEd2gVvRxG
 Xt0N06WlxMFwUUc32hhnNJqCXLdPnRKby2bNfOQkDYCbwQZOWxd+ODu5CrTmFHZVWb+hEKKuJJY
 iLD7QGFtupGlB7e2Uj7l42WaE2osRNXyd5sFypvzP6f8bmUytlxteC1b7zqCvWZS/rVy13sDbo3
 S7V86ew34w=
X-Received: by 2002:a05:600c:354b:b0:488:ab26:8fe0 with SMTP id
 5b1f17b1804b1-48e51f32bdemr132794885e9.15.1778161645105; 
 Thu, 07 May 2026 06:47:25 -0700 (PDT)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-48e53891d62sm200348655e9.1.2026.05.07.06.47.24
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Thu, 07 May 2026 06:47:24 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>, qemu-arm@nongnu.org,
 Peter Maydell <peter.maydell@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH 2/2] target/arm: Extract IDAU interface to its own unit
Date: Thu,  7 May 2026 15:47:09 +0200
Message-ID: <20260507134709.70507-3-philmd@linaro.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260507134709.70507-1-philmd@linaro.org>
References: <20260507134709.70507-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::334;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x334.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
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

Move IDAU TypeInfo structure to its own source file and
build it once as common ARM object.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 include/hw/arm/armv7m.h     |  2 +-
 include/hw/misc/tz-msc.h    |  2 +-
 target/arm/{ => tcg}/idau.h |  0
 hw/arm/armv7m.c             |  2 +-
 target/arm/cpu.c            |  2 +-
 target/arm/ptw.c            |  2 +-
 target/arm/tcg/cpu32.c      |  8 --------
 target/arm/tcg/idau.c       | 20 ++++++++++++++++++++
 target/arm/tcg/meson.build  |  1 +
 9 files changed, 26 insertions(+), 13 deletions(-)
 rename target/arm/{ => tcg}/idau.h (100%)
 create mode 100644 target/arm/tcg/idau.c

diff --git a/include/hw/arm/armv7m.h b/include/hw/arm/armv7m.h
index 98ad08db036..70555962bb9 100644
--- a/include/hw/arm/armv7m.h
+++ b/include/hw/arm/armv7m.h
@@ -13,7 +13,7 @@
 #include "hw/core/sysbus.h"
 #include "hw/intc/armv7m_nvic.h"
 #include "hw/misc/armv7m_ras.h"
-#include "target/arm/idau.h"
+#include "target/arm/tcg/idau.h"
 #include "qom/object.h"
 #include "hw/core/clock.h"
 
diff --git a/include/hw/misc/tz-msc.h b/include/hw/misc/tz-msc.h
index 07112d8caa3..6cf4c6b09eb 100644
--- a/include/hw/misc/tz-msc.h
+++ b/include/hw/misc/tz-msc.h
@@ -51,7 +51,7 @@
 #define TZ_MSC_H
 
 #include "hw/core/sysbus.h"
-#include "target/arm/idau.h"
+#include "target/arm/tcg/idau.h"
 #include "qom/object.h"
 
 #define TYPE_TZ_MSC "tz-msc"
diff --git a/target/arm/idau.h b/target/arm/tcg/idau.h
similarity index 100%
rename from target/arm/idau.h
rename to target/arm/tcg/idau.h
diff --git a/hw/arm/armv7m.c b/hw/arm/armv7m.c
index a29eab6c915..68a1cbd6316 100644
--- a/hw/arm/armv7m.c
+++ b/hw/arm/armv7m.c
@@ -20,7 +20,7 @@
 #include "qemu/error-report.h"
 #include "qemu/module.h"
 #include "qemu/log.h"
-#include "target/arm/idau.h"
+#include "target/arm/tcg/idau.h"
 #include "target/arm/cpu.h"
 #include "target/arm/cpu-features.h"
 #include "target/arm/cpu-qom.h"
diff --git a/target/arm/cpu.c b/target/arm/cpu.c
index d670ffe4de0..7b29532e6ee 100644
--- a/target/arm/cpu.c
+++ b/target/arm/cpu.c
@@ -24,7 +24,7 @@
 #include "qemu/log.h"
 #include "exec/page-vary.h"
 #include "system/whpx.h"
-#include "target/arm/idau.h"
+#include "target/arm/tcg/idau.h"
 #include "qemu/module.h"
 #include "qapi/error.h"
 #include "cpu.h"
diff --git a/target/arm/ptw.c b/target/arm/ptw.c
index 316e201cfe0..ff7b7a4d0c8 100644
--- a/target/arm/ptw.c
+++ b/target/arm/ptw.c
@@ -17,7 +17,7 @@
 #include "cpu.h"
 #include "internals.h"
 #include "cpu-features.h"
-#include "idau.h"
+#include "target/arm/tcg/idau.h"
 
 typedef struct S1Translate {
     /*
diff --git a/target/arm/tcg/cpu32.c b/target/arm/tcg/cpu32.c
index 2127d456ad6..73d21c6cf7d 100644
--- a/target/arm/tcg/cpu32.c
+++ b/target/arm/tcg/cpu32.c
@@ -12,7 +12,6 @@
 #include "cpu.h"
 #include "accel/tcg/cpu-ops.h"
 #include "internals.h"
-#include "target/arm/idau.h"
 #if !defined(CONFIG_USER_ONLY)
 #include "hw/core/boards.h"
 #endif
@@ -899,17 +898,10 @@ static const ARMCPUInfo arm_tcg_cpus[] = {
 #endif
 };
 
-static const TypeInfo idau_interface_type_info = {
-    .name = TYPE_IDAU_INTERFACE,
-    .parent = TYPE_INTERFACE,
-    .class_size = sizeof(IDAUInterfaceClass),
-};
-
 static void arm_tcg_cpu_register_types(void)
 {
     size_t i;
 
-    type_register_static(&idau_interface_type_info);
     for (i = 0; i < ARRAY_SIZE(arm_tcg_cpus); ++i) {
         arm_cpu_register(&arm_tcg_cpus[i]);
     }
diff --git a/target/arm/tcg/idau.c b/target/arm/tcg/idau.c
new file mode 100644
index 00000000000..57e5c658e9d
--- /dev/null
+++ b/target/arm/tcg/idau.c
@@ -0,0 +1,20 @@
+/*
+ * QEMU ARM CPU -- interface for the Arm v8M IDAU
+ *
+ * Copyright (c) 2018 Linaro Ltd
+ *
+ * SPDX-License-Identifier: GPL-2.0-or-later
+ */
+
+#include "qemu/osdep.h"
+#include "target/arm/tcg/idau.h"
+
+static const TypeInfo idau_types[] = {
+    {
+        .name       = TYPE_IDAU_INTERFACE,
+        .parent     = TYPE_INTERFACE,
+        .class_size = sizeof(IDAUInterfaceClass),
+    }
+};
+
+DEFINE_TYPES(idau_types)
diff --git a/target/arm/tcg/meson.build b/target/arm/tcg/meson.build
index d2364aa39c4..fa1e3d6640c 100644
--- a/target/arm/tcg/meson.build
+++ b/target/arm/tcg/meson.build
@@ -56,6 +56,7 @@ arm_common_ss.add(zlib)
 arm_common_ss.add(files(
   'arith_helper.c',
   'crypto_helper.c',
+  'idau.c',
 ))
 
 arm_common_system_ss.add(
-- 
2.53.0


