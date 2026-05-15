Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B9B49CD4F25
	for <qemu-devel@archiver.kernel.org>; Fri, 15 May 2026 10:51:32 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wNq7N-0000fy-8q; Fri, 15 May 2026 06:50:09 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1wNq7B-0000bz-P1
 for qemu-devel@nongnu.org; Fri, 15 May 2026 06:49:59 -0400
Received: from mail-wm1-x331.google.com ([2a00:1450:4864:20::331])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1wNq79-0001DB-QU
 for qemu-devel@nongnu.org; Fri, 15 May 2026 06:49:57 -0400
Received: by mail-wm1-x331.google.com with SMTP id
 5b1f17b1804b1-488a14c31eeso60883635e9.0
 for <qemu-devel@nongnu.org>; Fri, 15 May 2026 03:49:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1778842193; x=1779446993; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=tARkjxsKkE264H1PKp6MVO3zbSIFjjAhzFnkn3FZYuA=;
 b=Gn1R3F1SWZ9aBwcTM8RM08YyfAPj+sZYlbG6Ia980oC6SfmJLuGl0ecBQypQ0mMy7/
 ylJuJErtskJOMxS71Ts5922RyV1PZEFUezpbmuPNTvXiU8eGOGNuP0ay5K1VdKEJ69Xi
 Y0db9E0bWN18lPE+WgoGGSN5rrA0xHwigrUwZphW1qWGXOE4sZquYNZWGuQMHBGSTi/u
 +B6gPwHpEEPBUwjzq/IeI160YQ1d/dQfuP69+nPD6GVZZ2OVdk+teV3PnnezWObZlihE
 wJZcwvgUjEp+u3sXcsAt98AK3THCfWHUbUhS6ybb+3hLLjWp59OeoHjihCPhqgWdZUQO
 SlsA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1778842193; x=1779446993;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=tARkjxsKkE264H1PKp6MVO3zbSIFjjAhzFnkn3FZYuA=;
 b=Vj03BtBDBXDiL4YDhX+6+//YiKS9s9YouMMmlbozMfqxazL9grtrCyjCFAp2FJW8Mh
 Vse7GjPuwuvdfzNfrYBTzJCZie7cOrYGtctPFmANzejmdvZJ//iE/P2nQYYY07B2G4z7
 kvfkgnl08ni06RrbQv46QbgWYpDgjVX0PrJjII26RXlgpFCQ5Ossu8ELErcI6e+AsMPE
 /BM7SbjH+tvSpNqfXuOX1sgcw0zYVVTSZ8X/0W+3Gq+sa2FSX1tC1Cwvgogy0tLMy5iH
 2Zu+66d/PTiVHHLM5WjvdB6yyBorKHewguKQNKDoCY/0W5gjCMR0gLma14GRgZi1sWf+
 0O+g==
X-Gm-Message-State: AOJu0Yy0zL0ot52kYziT9SgWo76IfWHoBdJiTgfEBW+eOI6xORMuX/5w
 r7kRbUa8DB6MF4Z5VQbXTZzggBMJEnds/XGn1cl45rzB7PrNoaeTOND3lu8hIviWlCFwCKuoAf1
 2Yorf
X-Gm-Gg: Acq92OEQDPwZMjZ3d5pnGwBwir83w0vEmtl79KXP7K18aBMBDtzVUQkmsaEyeHmoUhF
 BeSfXCBoUbcS3VPGH7OYuXfZFl8E2bX+P68y+/F+MdHvDHt7EM5N3enEAkUEC3X9La3W3AdM6Sj
 IY/NTsw0E5z+Sbqy2sqz/rW3mW7raehn+t4mVeAsa36dogfxwTQOunYFajUZhC0RCI+D4moJ6wS
 ytPQ1ueGJu/G16i+oYzvDL6aQlsjgHVrOVH5Qxn2RKVFCetft//r9af7MFQSpjte0eV0+hqQ52j
 2g3bc3/y1+8kJc3tYpgCZxux21VYsZj0vT541KRSl+FjMsUPskJLeigSFp6FOSZcW1oa1j3qL+z
 BVCiNiulrnBX3VFeqaJn58SpEGwOqf2BrMdWZV9PHED5pabLdgjPiHMxrLbYNtcIv8jhFIWPa/N
 QAG+rY6A3IEA50SwbK50CrqdRMYjoNf7UKEXFNY4/J6wBcFwbWb+fe1Fc65jVSuXHThP6x2788y
 m+qYcxSBkS0/gJdN5/64m9IR3l74xI=
X-Received: by 2002:a05:600c:4685:b0:48e:5d91:cfe3 with SMTP id
 5b1f17b1804b1-48fe5fd494dmr46671105e9.1.1778842193358; 
 Fri, 15 May 2026 03:49:53 -0700 (PDT)
Received: from lanath.. (wildly.archaic.org.uk. [81.2.115.145])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-48feaa2949asm18194355e9.1.2026.05.15.03.49.52
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 15 May 2026 03:49:52 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 05/23] target/arm: Extract IDAU interface to its own unit
Date: Fri, 15 May 2026 11:49:27 +0100
Message-ID: <20260515104945.4145203-6-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260515104945.4145203-1-peter.maydell@linaro.org>
References: <20260515104945.4145203-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::331;
 envelope-from=peter.maydell@linaro.org; helo=mail-wm1-x331.google.com
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

From: Philippe Mathieu-Daudé <philmd@linaro.org>

Move IDAU TypeInfo structure to its own source file and
build it once as common ARM object.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Message-id: 20260507134709.70507-3-philmd@linaro.org
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 hw/arm/armv7m.c             |  2 +-
 include/hw/arm/armv7m.h     |  2 +-
 include/hw/misc/tz-msc.h    |  2 +-
 target/arm/cpu.c            |  2 +-
 target/arm/ptw.c            |  2 +-
 target/arm/tcg/cpu32.c      |  8 --------
 target/arm/tcg/idau.c       | 20 ++++++++++++++++++++
 target/arm/{ => tcg}/idau.h |  0
 target/arm/tcg/meson.build  |  1 +
 9 files changed, 26 insertions(+), 13 deletions(-)
 create mode 100644 target/arm/tcg/idau.c
 rename target/arm/{ => tcg}/idau.h (100%)

diff --git a/hw/arm/armv7m.c b/hw/arm/armv7m.c
index a29eab6c91..68a1cbd631 100644
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
diff --git a/include/hw/arm/armv7m.h b/include/hw/arm/armv7m.h
index 98ad08db03..70555962bb 100644
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
index 07112d8caa..6cf4c6b09e 100644
--- a/include/hw/misc/tz-msc.h
+++ b/include/hw/misc/tz-msc.h
@@ -51,7 +51,7 @@
 #define TZ_MSC_H
 
 #include "hw/core/sysbus.h"
-#include "target/arm/idau.h"
+#include "target/arm/tcg/idau.h"
 #include "qom/object.h"
 
 #define TYPE_TZ_MSC "tz-msc"
diff --git a/target/arm/cpu.c b/target/arm/cpu.c
index 1462e1f501..c47b70ac69 100644
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
index 8706dd59dd..a4842a4b62 100644
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
index 2127d456ad..73d21c6cf7 100644
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
index 0000000000..57e5c658e9
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
diff --git a/target/arm/idau.h b/target/arm/tcg/idau.h
similarity index 100%
rename from target/arm/idau.h
rename to target/arm/tcg/idau.h
diff --git a/target/arm/tcg/meson.build b/target/arm/tcg/meson.build
index 4fb2c15f7e..1b751d5918 100644
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
2.43.0


