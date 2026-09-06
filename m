Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 816ADC79FA0
	for <qemu-devel@archiver.kernel.org>; Sun,  6 Sep 2026 19:46:05 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x3InY-0002L4-SB; Sun, 06 Sep 2026 15:45:04 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <gilles.grimaud@univ-lille.fr>)
 id 1x3InX-0002KR-6L; Sun, 06 Sep 2026 15:45:03 -0400
Received: from smtp-out-2.univ-lille.fr ([194.254.129.106])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <gilles.grimaud@univ-lille.fr>)
 id 1x3InV-0006yN-Lh; Sun, 06 Sep 2026 15:45:02 -0400
Received: from smtp01.univ-lille.fr (smtp01.univ-lille.fr [194.254.129.95])
 by smtp-out-2.univ-lille.fr (Postfix) with ESMTPS id 4hdLJ91xGrz7vlJ;
 Sun,  6 Sep 2026 21:44:41 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=univ-lille.fr;
 s=dkim; t=1788723881;
 bh=fWlupKOwpNva6XUoID2x2f5wQDb7+vl7d68rmgn+t5Y=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=tVf3FHY5AN84/gaJIiHPcOciz8J3EW3CsXO3mHSapPOrQdKg6A1Ct18fgl+1Cz6CE
 wEuP/sHnbwzrq8BsSXZJ5jGE4RybNvDUtH+px9juoKET4FvhtUG6nKL4+rkcBuywQj
 j/DJEKwIrOOrfOexe+0BQgupZZb2xYzLkXe9Y63DYk24BHt64fauk2gmOD24OEcT7J
 3cdm9jyiN51jjrY3A7KH/9yaX0FN5xmjCNDIHS4hkbHmyYZLeBIweMSctI8wGfTkAZ
 GM3safkYTzHWlRY2osZkrujhsjYmZJSmIcY6A3imamrOLtN1TP998NOyIcyizbBsVZ
 Mb/ynFoEki6Sw==
Received: from mac.home (lfbn-lil-1-243-101.w90-45.abo.wanadoo.fr
 [90.45.87.101]) (Authenticated sender: gilles.grimaud)
 by smtp01.univ-lille.fr (Postfix) with ESMTPSA id 4hdLJ90JmKz7wXp;
 Sun,  6 Sep 2026 21:44:41 +0200 (CEST)
From: Gilles Grimaud <gilles.grimaud@univ-lille.fr>
To: qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org,
	alex.bennee@linaro.org,
	peter.maydell@linaro.org
Subject: [PATCH v3 05/36] hw/misc: add common RP2040 peripheral definitions
Date: Sun,  6 Sep 2026 21:44:04 +0200
Message-ID: <20260906194438.93046-6-gilles.grimaud@univ-lille.fr>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260906194438.93046-1-gilles.grimaud@univ-lille.fr>
References: <20260906194438.93046-1-gilles.grimaud@univ-lille.fr>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=194.254.129.106;
 envelope-from=gilles.grimaud@univ-lille.fr; helo=smtp-out-2.univ-lille.fr
X-Spam_score_int: -43
X-Spam_score: -4.4
X-Spam_bar: ----
X-Spam_report: (-4.4 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, SPF_HELO_NONE=0.001,
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

RP2040 APB peripherals share atomic XOR, SET and CLEAR alias windows.
Add common constants and an inline update helper so individual device
models do not duplicate this behavior.

Signed-off-by: Gilles Grimaud <gilles.grimaud@univ-lille.fr>
---
 MAINTAINERS              |  7 +++++++
 include/hw/misc/rp2040.h | 32 ++++++++++++++++++++++++++++++++
 2 files changed, 39 insertions(+)
 create mode 100644 include/hw/misc/rp2040.h

diff --git a/MAINTAINERS b/MAINTAINERS
index 15c9b8bf2c..962988f94d 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -1026,6 +1026,13 @@ F: docs/system/arm/raspi.rst
 F: tests/functional/arm/test_raspi2.py
 F: tests/functional/aarch64/test_raspi*.py
 
+Raspberry Pi Pico / RP2040
+M: Gilles Grimaud <gilles.grimaud@univ-lille.fr>
+L: qemu-arm@nongnu.org
+S: Maintained
+F: hw/*/rp2040*
+F: include/hw/*/rp2040*
+
 Real View
 M: Peter Maydell <peter.maydell@linaro.org>
 L: qemu-arm@nongnu.org
diff --git a/include/hw/misc/rp2040.h b/include/hw/misc/rp2040.h
new file mode 100644
index 0000000000..13e05c9526
--- /dev/null
+++ b/include/hw/misc/rp2040.h
@@ -0,0 +1,32 @@
+/*
+ * RP2040 common peripheral helpers
+ *
+ * SPDX-License-Identifier: GPL-2.0-or-later
+ */
+
+#ifndef HW_MISC_RP2040_H
+#define HW_MISC_RP2040_H
+
+#include "exec/hwaddr.h"
+
+#define RP2040_ATOMIC_ALIAS_MASK 0x3000
+#define RP2040_ATOMIC_XOR        0x1000
+#define RP2040_ATOMIC_SET        0x2000
+#define RP2040_ATOMIC_CLR        0x3000
+
+static inline uint32_t rp2040_atomic_update(uint32_t old, uint32_t value,
+                                            hwaddr alias)
+{
+    switch (alias) {
+    case RP2040_ATOMIC_XOR:
+        return old ^ value;
+    case RP2040_ATOMIC_SET:
+        return old | value;
+    case RP2040_ATOMIC_CLR:
+        return old & ~value;
+    default:
+        return value;
+    }
+}
+
+#endif
-- 
2.55.0


