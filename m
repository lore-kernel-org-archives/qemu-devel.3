Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 00E1FE7E36C
	for <qemu-devel@archiver.kernel.org>; Fri,  3 Apr 2026 10:44:12 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w8c09-00040W-Sc; Fri, 03 Apr 2026 06:43:46 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>) id 1w8c06-0003ze-Qx
 for qemu-devel@nongnu.org; Fri, 03 Apr 2026 06:43:43 -0400
Received: from isrv.corpit.ru ([212.248.84.144])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>) id 1w8c04-0005Zm-Oc
 for qemu-devel@nongnu.org; Fri, 03 Apr 2026 06:43:42 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=tls.msk.ru; s=202602;
 t=1775212971; bh=gq60/YFiZnFG3mBQOq32B3RaPpFjLtZ3CVqIC3UfUdg=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References;
 b=rqdgxJPyRAEr3wE0PfNtvcFiDQu3Fu7RsALFptLWK9STdfZEWyD3p1q0BysEQFrgW
 iZ57Ui0KaCd0Jae/M1qmlGOe5g1XjmoN0DGDTlRe1GkHFA/jU85o7M8blwm3ZbOmYW
 xRxhcciWjToW2hNEx64KfvlhZldu4tHrhszJpMwQjp+dix5uA7AnVxyQfG3LP6YsDT
 IFld1hqr7p0j1iJk9u+myizY1KpTk1z1dcxy7dl0WruGvzsge2jt9sCeu0x85hfbwT
 POcuF/F+TOae9fYVnj9jODTmMEJu8tiEYreWyZH/cXQsr+cmIQvmzPDDqoiCcB1h8v
 74QlvM6hTcXKQ==
Received: from tsrv.corpit.ru (tsrv.tls.msk.ru [192.168.177.2])
 by isrv.corpit.ru (Postfix) with ESMTP id 25B2119A63E;
 Fri, 03 Apr 2026 13:42:51 +0300 (MSK)
Received: from think4mjt.tls.msk.ru (mjtthink.wg.tls.msk.ru [192.168.177.146])
 by tsrv.corpit.ru (Postfix) with ESMTP id D8C7738DB6E;
 Fri, 03 Apr 2026 13:43:28 +0300 (MSK)
From: Michael Tokarev <mjt@tls.msk.ru>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Michael Tokarev <mjt@tls.msk.ru>
Subject: [PATCH for-11.0 4/6] qom: Declare compat properties API in
 'qom/compat-properties.h'
Date: Fri,  3 Apr 2026 13:43:24 +0300
Message-ID: <20260403104327.1163942-5-mjt@tls.msk.ru>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260403104327.1163942-1-mjt@tls.msk.ru>
References: <20260403104327.1163942-1-mjt@tls.msk.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=212.248.84.144; envelope-from=mjt@tls.msk.ru;
 helo=isrv.corpit.ru
X-Spam_score_int: -19
X-Spam_score: -2.0
X-Spam_bar: --
X-Spam_report: (-2.0 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, SPF_HELO_NONE=0.001,
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

While most of QEMU files use the QOM concept, few of them
use the compatibility properties API (mostly use in system
emulation). Move its prototype to a new "qom/compat-properties.h"
header, keeping "qom/object.h" for generic QOM.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Michael Tokarev <mjt@tls.msk.ru>
---
 accel/accel-system.c            | 1 +
 backends/hostmem.c              | 1 +
 hw/core/machine.c               | 1 +
 hw/core/qdev-properties.c       | 1 +
 hw/core/qdev.c                  | 1 +
 hw/i386/pc_q35.c                | 1 +
 include/qom/compat-properties.h | 8 ++++++++
 include/qom/object.h            | 8 --------
 system/rtc.c                    | 1 +
 system/vl.c                     | 1 +
 target/i386/sev.c               | 1 +
 ui/vdagent.c                    | 1 +
 12 files changed, 18 insertions(+), 8 deletions(-)

diff --git a/accel/accel-system.c b/accel/accel-system.c
index 150af05bf5..9176665202 100644
--- a/accel/accel-system.c
+++ b/accel/accel-system.c
@@ -25,6 +25,7 @@
 
 #include "qemu/osdep.h"
 #include "qemu/accel.h"
+#include "qom/compat-properties.h"
 #include "qapi/qapi-commands-accelerator.h"
 #include "monitor/monitor.h"
 #include "hw/core/boards.h"
diff --git a/backends/hostmem.c b/backends/hostmem.c
index 15d4365b69..cd2085fb3c 100644
--- a/backends/hostmem.c
+++ b/backends/hostmem.c
@@ -18,6 +18,7 @@
 #include "qapi/qapi-builtin-visit.h"
 #include "qapi/visitor.h"
 #include "qemu/config-file.h"
+#include "qom/compat-properties.h"
 #include "qom/object_interfaces.h"
 #include "qemu/mmap-alloc.h"
 #include "qemu/madvise.h"
diff --git a/hw/core/machine.c b/hw/core/machine.c
index 0aa77a57e9..cba5031094 100644
--- a/hw/core/machine.c
+++ b/hw/core/machine.c
@@ -21,6 +21,7 @@
 #include "qapi/qapi-visit-machine.h"
 #include "qapi/qapi-commands-machine.h"
 #include "qemu/madvise.h"
+#include "qom/compat-properties.h"
 #include "qom/object_interfaces.h"
 #include "system/cpus.h"
 #include "system/system.h"
diff --git a/hw/core/qdev-properties.c b/hw/core/qdev-properties.c
index ba8461e9a4..73539c727b 100644
--- a/hw/core/qdev-properties.c
+++ b/hw/core/qdev-properties.c
@@ -10,6 +10,7 @@
 #include "qemu/units.h"
 #include "qemu/cutils.h"
 #include "qdev-prop-internal.h"
+#include "qom/compat-properties.h"
 #include "qom/qom-qobject.h"
 
 void qdev_prop_set_after_realize(DeviceState *dev, const char *name,
diff --git a/hw/core/qdev.c b/hw/core/qdev.c
index e48616b2c6..b36101f3a7 100644
--- a/hw/core/qdev.c
+++ b/hw/core/qdev.c
@@ -32,6 +32,7 @@
 #include "qapi/visitor.h"
 #include "qemu/error-report.h"
 #include "qemu/option.h"
+#include "qom/compat-properties.h"
 #include "hw/core/irq.h"
 #include "hw/core/qdev-properties.h"
 #include "hw/core/boards.h"
diff --git a/hw/i386/pc_q35.c b/hw/i386/pc_q35.c
index cb23322f5a..6a0967ecd1 100644
--- a/hw/i386/pc_q35.c
+++ b/hw/i386/pc_q35.c
@@ -56,6 +56,7 @@
 #include "hw/usb/hcd-uhci.h"
 #include "qapi/error.h"
 #include "qemu/error-report.h"
+#include "qom/compat-properties.h"
 #include "system/numa.h"
 #include "hw/hyperv/vmbus-bridge.h"
 #include "hw/mem/nvdimm.h"
diff --git a/include/qom/compat-properties.h b/include/qom/compat-properties.h
index 6e44aabc26..90f8320adf 100644
--- a/include/qom/compat-properties.h
+++ b/include/qom/compat-properties.h
@@ -29,4 +29,12 @@ typedef struct GlobalProperty {
     bool optional;
 } GlobalProperty;
 
+void object_set_machine_compat_props(GPtrArray *compat_props);
+void object_set_accelerator_compat_props(GPtrArray *compat_props);
+void object_register_sugar_prop(const char *driver, const char *prop,
+                                const char *value, bool optional);
+void object_apply_compat_props(Object *obj);
+bool object_apply_global_props(Object *obj, const GPtrArray *props,
+                               Error **errp);
+
 #endif
diff --git a/include/qom/object.h b/include/qom/object.h
index 26df6137b9..510885218b 100644
--- a/include/qom/object.h
+++ b/include/qom/object.h
@@ -700,14 +700,6 @@ Object *object_new_with_propv(const char *typename,
                               Error **errp,
                               va_list vargs);
 
-bool object_apply_global_props(Object *obj, const GPtrArray *props,
-                               Error **errp);
-void object_set_machine_compat_props(GPtrArray *compat_props);
-void object_set_accelerator_compat_props(GPtrArray *compat_props);
-void object_register_sugar_prop(const char *driver, const char *prop,
-                                const char *value, bool optional);
-void object_apply_compat_props(Object *obj);
-
 /**
  * object_set_props:
  * @obj: the object instance to set properties on
diff --git a/system/rtc.c b/system/rtc.c
index 56951288c4..f13dd392a7 100644
--- a/system/rtc.c
+++ b/system/rtc.c
@@ -28,6 +28,7 @@
 #include "qemu/error-report.h"
 #include "qemu/option.h"
 #include "qemu/timer.h"
+#include "qom/compat-properties.h"
 #include "qom/object.h"
 #include "system/replay.h"
 #include "system/system.h"
diff --git a/system/vl.c b/system/vl.c
index 246623b319..0e1fc217b4 100644
--- a/system/vl.c
+++ b/system/vl.c
@@ -119,6 +119,7 @@
 #include "qapi/string-input-visitor.h"
 #include "qapi/opts-visitor.h"
 #include "qapi/clone-visitor.h"
+#include "qom/compat-properties.h"
 #include "qom/object_interfaces.h"
 #include "semihosting/semihost.h"
 #include "crypto/init.h"
diff --git a/target/i386/sev.c b/target/i386/sev.c
index 9dde972c11..261b6aaa37 100644
--- a/target/i386/sev.c
+++ b/target/i386/sev.c
@@ -36,6 +36,7 @@
 #include "system/reset.h"
 #include "trace.h"
 #include "migration/blocker.h"
+#include "qom/compat-properties.h"
 #include "qom/object.h"
 #include "monitor/monitor.h"
 #include "monitor/hmp.h"
diff --git a/ui/vdagent.c b/ui/vdagent.c
index bb0c4aa14c..bb55cbefc9 100644
--- a/ui/vdagent.c
+++ b/ui/vdagent.c
@@ -5,6 +5,7 @@
 #include "qemu/error-report.h"
 #include "qemu/option.h"
 #include "qemu/units.h"
+#include "qom/compat-properties.h"
 #include "hw/core/qdev.h"
 #include "hw/core/qdev-properties.h"
 #include "migration/blocker.h"
-- 
2.47.3


