Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BD536CCF9F2
	for <qemu-devel@archiver.kernel.org>; Tue, 28 Oct 2025 10:21:18 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vDgog-0005n1-Qx; Tue, 28 Oct 2025 06:20:40 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <chenmiao@openatom.club>)
 id 1vDgoJ-0005fO-KX
 for qemu-devel@nongnu.org; Tue, 28 Oct 2025 06:20:15 -0400
Received: from sg-1-17.ptr.blmpb.com ([118.26.132.17])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <chenmiao@openatom.club>)
 id 1vDgo1-0001sU-0C
 for qemu-devel@nongnu.org; Tue, 28 Oct 2025 06:20:09 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 s=s1; d=openatom-club.20200927.dkim.feishu.cn; t=1761646719;
 h=from:subject:mime-version:from:date:message-id:subject:to:cc:
 reply-to:content-type:mime-version:in-reply-to:message-id;
 bh=p2Lb6KDhFWP4ZK7MaEAb4RoYa/tWZzFmxXGoAhw00CM=;
 b=yIjRopHqLp9khzvO3SGguCDzEXmNjlRMmwMpqypM+5rEb+XtPv+3RoRGRQBDWvRKz4gLko
 9RpGUkJXQW5AeeQXSG1dnPgTOm5Z9OOxLlT7soI/mmNdcqFtwVRJ2H4oqImyj4tPrEIGkT
 Kq0WE97WyQDB+zLY2aJrKJV5gneqxyB+wnOguH/5n1Elkb+G1Zrk9SSFS3btX6kRW8LVnL
 qHHFQrh691XJmtqnhBCnsZFYvk7kX4CUmqM9f7MMmS6v4rxQdvZ9+oA9P07x0TStjK4Obc
 6CjSDFhDdtOCE7TQnBEfs+oE714TciUCr1h7oHZgn9o+5O0w3KYkNyd3T+V7Ww==
Subject: [RFC PATCH v2 3/5] hw/gpio: Move the pcf8574 struct to header
Mime-Version: 1.0
Message-Id: <90746cd6a57c0df971158f604c422a23d750e0b4.1761644606.git.chenmiao@openatom.club>
Content-Transfer-Encoding: 7bit
X-Lms-Return-Path: <lba+26900987d+6e2e2b+nongnu.org+chenmiao@openatom.club>
Content-Type: text/plain; charset=UTF-8
To: <zhao1.liu@intel.com>, <pbonzini@redhat.com>, 
 <manos.pitsidianakis@linaro.org>, <richard.henderson@linaro.org>, 
 <philmd@linaro.org>
From: "chenmiao" <chenmiao@openatom.club>
Date: Tue, 28 Oct 2025 10:18:27 +0000
X-Mailer: git-send-email 2.43.0
Cc: <chao.liu@openatom.club>, <qemu-rust@nongnu.org>, 
 <qemu-devel@nongnu.org>, <hust-os-kernel-patches@googlegroups.com>
X-Original-From: chenmiao <chenmiao@openatom.club>
Received: from nyaos.localdomain ([114.249.194.57]) by smtp.feishu.cn with
 ESMTPS; Tue, 28 Oct 2025 18:18:36 +0800
Received-SPF: pass client-ip=118.26.132.17;
 envelope-from=chenmiao@openatom.club; helo=sg-1-17.ptr.blmpb.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, MSGID_FROM_MTA_HEADER=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

To better implement the Rust PCF8574 bindings, move its struct definition to
the header file.

Signed-off-by: chenmiao <chenmiao@openatom.club>
---
 hw/gpio/pcf8574.c         | 32 --------------------------------
 include/hw/gpio/pcf8574.h | 36 ++++++++++++++++++++++++++++++++++++
 2 files changed, 36 insertions(+), 32 deletions(-)

diff --git a/hw/gpio/pcf8574.c b/hw/gpio/pcf8574.c
index 274b44bb61..670fc006bb 100644
--- a/hw/gpio/pcf8574.c
+++ b/hw/gpio/pcf8574.c
@@ -15,38 +15,6 @@
 #include "qemu/module.h"
 #include "qom/object.h"
 
-/*
- * PCF8574 and compatible chips incorporate quasi-bidirectional
- * IO. Electrically it means that device sustain pull-up to line
- * unless IO port is configured as output _and_ driven low.
- *
- * IO access is implemented as simple I2C single-byte read
- * or write operation. So, to configure line to input user write 1
- * to corresponding bit. To configure line to output and drive it low
- * user write 0 to corresponding bit.
- *
- * In essence, user can think of quasi-bidirectional IO as
- * open-drain line, except presence of builtin rising edge acceleration
- * embedded in PCF8574 IC
- *
- * PCF8574 has interrupt request line, which is being pulled down when
- * port line state differs from last read. Port read operation clears
- * state and INT line returns to high state via pullup.
- */
-
-OBJECT_DECLARE_SIMPLE_TYPE(PCF8574State, PCF8574)
-
-#define PORTS_COUNT (8)
-
-struct PCF8574State {
-    I2CSlave parent_obj;
-    uint8_t  lastrq;     /* Last requested state. If changed - assert irq */
-    uint8_t  input;      /* external electrical line state */
-    uint8_t  output;     /* Pull-up (1) or drive low (0) on bit */
-    qemu_irq handler[PORTS_COUNT];
-    qemu_irq intrq;      /* External irq request */
-};
-
 static void pcf8574_reset(DeviceState *dev)
 {
     PCF8574State *s = PCF8574(dev);
diff --git a/include/hw/gpio/pcf8574.h b/include/hw/gpio/pcf8574.h
index 3291d7dbbc..fe1ce891b7 100644
--- a/include/hw/gpio/pcf8574.h
+++ b/include/hw/gpio/pcf8574.h
@@ -10,6 +10,42 @@
 #ifndef _HW_GPIO_PCF8574
 #define _HW_GPIO_PCF8574
 
+#include "qemu/osdep.h"
+#include "hw/i2c/i2c.h"
+#include "qom/object.h"
+
 #define TYPE_PCF8574 "pcf8574"
 
+/*
+ * PCF8574 and compatible chips incorporate quasi-bidirectional
+ * IO. Electrically it means that device sustain pull-up to line
+ * unless IO port is configured as output _and_ driven low.
+ *
+ * IO access is implemented as simple I2C single-byte read
+ * or write operation. So, to configure line to input user write 1
+ * to corresponding bit. To configure line to output and drive it low
+ * user write 0 to corresponding bit.
+ *
+ * In essence, user can think of quasi-bidirectional IO as
+ * open-drain line, except presence of builtin rising edge acceleration
+ * embedded in PCF8574 IC
+ *
+ * PCF8574 has interrupt request line, which is being pulled down when
+ * port line state differs from last read. Port read operation clears
+ * state and INT line returns to high state via pullup.
+ */
+
+OBJECT_DECLARE_SIMPLE_TYPE(PCF8574State, PCF8574)
+
+#define PORTS_COUNT (8)
+
+struct PCF8574State {
+    I2CSlave parent_obj;
+    uint8_t  lastrq;     /* Last requested state. If changed - assert irq */
+    uint8_t  input;      /* external electrical line state */
+    uint8_t  output;     /* Pull-up (1) or drive low (0) on bit */
+    qemu_irq handler[PORTS_COUNT];
+    qemu_irq intrq;      /* External irq request */
+};
+
 #endif /* _HW_GPIO_PCF8574 */
-- 
2.43.0

