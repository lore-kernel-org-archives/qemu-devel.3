Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1DCF8CCD1BF
	for <qemu-devel@archiver.kernel.org>; Sat, 25 Oct 2025 14:28:27 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vCfEq-00042n-KB; Sat, 25 Oct 2025 10:27:24 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <chenmiao@openatom.club>)
 id 1vCdZG-0001bq-P6
 for qemu-devel@nongnu.org; Sat, 25 Oct 2025 08:40:22 -0400
Received: from sg-1-12.ptr.blmpb.com ([118.26.132.12])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <chenmiao@openatom.club>)
 id 1vCdZ7-0003jK-Sr
 for qemu-devel@nongnu.org; Sat, 25 Oct 2025 08:40:22 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 s=s1; d=openatom-club.20200927.dkim.feishu.cn; t=1761395939;
 h=from:subject:mime-version:from:date:message-id:subject:to:cc:
 reply-to:content-type:mime-version:in-reply-to:message-id;
 bh=gR+aViI6I08ckniD2DB2RSpyPEY8T+Gw+c1ftkb472c=;
 b=TBcSrg+MmTf9qFNI5AfAtrdpw1f1esUZmiTzhhq6UaM9K8ANdgi4/HJwkPZGymYs+rrclT
 Nsn8kXZTN+qSJCyI9+dUhtakt/K/YVJO32IldgaDwpbi5MrE3u37MvjUrlu/UHiMpyZ3i+
 9Ctin24heL1XW5HaG8GdnWpCncgDRfGModqnsOsQirPg4Mo5dr3m0AcnBnva1aeXd9+qHx
 IivqH/M21O8dwBuZ5waEpzJGoxS+yoKrOUmSMoZoOqoVybGG9KvUAER7OmdVZpcS63ngPg
 yBOkA4OLCJiTWdiDplqbeImdyoh/UJFUknopzG+C9dvgac4sC+M4iDQQLcLAng==
Message-Id: <20251025123853.63139-4-chenmiao@openatom.club>
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset=UTF-8
To: <pbonzini@redhat.com>, <manos.pitsidianakis@linaro.org>, 
 <richard.henderson@linaro.org>, <philmd@linaro.org>
X-Lms-Return-Path: <lba+268fcc4e1+f535d1+nongnu.org+chenmiao@openatom.club>
X-Mailer: git-send-email 2.43.0
X-Original-From: chenmiao <chenmiao@openatom.club>
Cc: <qemu-rust@nongnu.org>, <qemu-devel@nongnu.org>, 
 <hust-os-kernel-patches@googlegroups.com>
From: "chenmiao" <chenmiao@openatom.club>
Subject: [RFC 3/5] hw: gpio: Move the pcf8574 struct to header
Date: Sat, 25 Oct 2025 12:38:51 +0000
Mime-Version: 1.0
Received: from nyaos.localdomain ([114.249.194.57]) by smtp.feishu.cn with
 ESMTPS; Sat, 25 Oct 2025 20:38:57 +0800
Received-SPF: pass client-ip=118.26.132.12;
 envelope-from=chenmiao@openatom.club; helo=sg-1-12.ptr.blmpb.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, MSGID_FROM_MTA_HEADER=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
X-Spam_action: no action
X-Mailman-Approved-At: Sat, 25 Oct 2025 10:27:12 -0400
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
index 274b44b..670fc00 100644
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
index 3291d7d..fe1ce89 100644
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

