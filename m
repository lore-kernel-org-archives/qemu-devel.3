Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 46EA0E7E36B
	for <qemu-devel@archiver.kernel.org>; Fri,  3 Apr 2026 10:44:41 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w8c06-0003zW-CA; Fri, 03 Apr 2026 06:43:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>) id 1w8c03-0003yr-LM
 for qemu-devel@nongnu.org; Fri, 03 Apr 2026 06:43:39 -0400
Received: from isrv.corpit.ru ([212.248.84.144])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>) id 1w8c01-0005YO-SL
 for qemu-devel@nongnu.org; Fri, 03 Apr 2026 06:43:39 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=tls.msk.ru; s=202602;
 t=1775212971; bh=RrlxCV4E2YhfW6wkGShBvS/UZsM8Fiy1F7kyYksAPqg=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References;
 b=rl78ktypZxSR3JDdugwp6mXIRAk327+aYk5tHyxCepYQGaH3yGIsmgGmcpF7stZwe
 ehki3rLw9Dtp7vcDzo3KpI4d5w9V6ZhYcqlgshZuyXiPBFlWrRpJFUQ1CnUtOuiD4H
 VARGge8yfKRTU2nv/Nnq2+btIaCel290GhjmvWSfRUVO4C7EhezKyZ61MSnHcdXjJb
 plhwepmIKY3u9fj4dKqH0FKRn34QAUUgMa7MooGtoZt0c8iuaxqhg6ytnhME3Bp4pw
 T95VJySSK1yLsHfOihjAvnsxck4feI1LMGiRYEoTzB7425C3g1AEC7IBKGx8/Cfo49
 hF1ojy5RjHQ3A==
Received: from tsrv.corpit.ru (tsrv.tls.msk.ru [192.168.177.2])
 by isrv.corpit.ru (Postfix) with ESMTP id 19EFA19A63D;
 Fri, 03 Apr 2026 13:42:51 +0300 (MSK)
Received: from think4mjt.tls.msk.ru (mjtthink.wg.tls.msk.ru [192.168.177.146])
 by tsrv.corpit.ru (Postfix) with ESMTP id CC8DF38DB6D;
 Fri, 03 Apr 2026 13:43:28 +0300 (MSK)
From: Michael Tokarev <mjt@tls.msk.ru>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Michael Tokarev <mjt@tls.msk.ru>
Subject: [PATCH for-11.0 3/6] qom: Declare GlobalProperty structure in
 'qom/compat-properties.h'
Date: Fri,  3 Apr 2026 13:43:23 +0300
Message-ID: <20260403104327.1163942-4-mjt@tls.msk.ru>
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

While GlobalProperty is expected to only be used by QDev board
layer, it is used by the lower QOM API, so define it in the
qom/ namespace. This helps to build binary which use QOM but
don't need the QDev layer.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Michael Tokarev <mjt@tls.msk.ru>
---
 include/hw/core/boards.h          |  1 +
 include/hw/core/qdev-properties.h |  1 +
 include/hw/core/qdev.h            | 17 ----------------
 include/qom/compat-properties.h   | 32 +++++++++++++++++++++++++++++++
 qom/object.c                      |  2 +-
 5 files changed, 35 insertions(+), 18 deletions(-)
 create mode 100644 include/qom/compat-properties.h

diff --git a/include/hw/core/boards.h b/include/hw/core/boards.h
index 0ac7e17ef7..3f9a7127ad 100644
--- a/include/hw/core/boards.h
+++ b/include/hw/core/boards.h
@@ -8,6 +8,7 @@
 #include "system/blockdev.h"
 #include "qapi/qapi-types-machine.h"
 #include "qemu/module.h"
+#include "qom/compat-properties.h"
 #include "qom/object.h"
 #include "hw/core/cpu.h"
 #include "hw/core/resettable.h"
diff --git a/include/hw/core/qdev-properties.h b/include/hw/core/qdev-properties.h
index d8745d4c65..17543957a6 100644
--- a/include/hw/core/qdev-properties.h
+++ b/include/hw/core/qdev-properties.h
@@ -1,6 +1,7 @@
 #ifndef QEMU_QDEV_PROPERTIES_H
 #define QEMU_QDEV_PROPERTIES_H
 
+#include "qom/compat-properties.h"
 #include "hw/core/qdev.h"
 
 /**
diff --git a/include/hw/core/qdev.h b/include/hw/core/qdev.h
index 778617787c..337d69ea2c 100644
--- a/include/hw/core/qdev.h
+++ b/include/hw/core/qdev.h
@@ -404,23 +404,6 @@ struct BusState {
     ResettableState reset;
 };
 
-/**
- * typedef GlobalProperty - a global property type
- *
- * @used: Set to true if property was used when initializing a device.
- * @optional: If set to true, GlobalProperty will be skipped without errors
- *            if the property doesn't exist.
- *
- * An error is fatal for non-hotplugged devices, when the global is applied.
- */
-typedef struct GlobalProperty {
-    const char *driver;
-    const char *property;
-    const char *value;
-    bool used;
-    bool optional;
-} GlobalProperty;
-
 /*** Board API.  This should go away once we have a machine config file.  ***/
 
 /**
diff --git a/include/qom/compat-properties.h b/include/qom/compat-properties.h
new file mode 100644
index 0000000000..6e44aabc26
--- /dev/null
+++ b/include/qom/compat-properties.h
@@ -0,0 +1,32 @@
+/*
+ * QEMU Object Model
+ *
+ * Copyright IBM, Corp. 2011
+ *
+ * Authors:
+ *  Anthony Liguori   <aliguori@us.ibm.com>
+ *
+ * SPDX-License-Identifier: GPL-2.0-or-later
+ */
+
+#ifndef QEMU_COMPAT_PROPERTIES_H
+#define QEMU_COMPAT_PROPERTIES_H
+
+/**
+ * typedef GlobalProperty - a global property type
+ *
+ * @used: Set to true if property was used when initializing a device.
+ * @optional: If set to true, GlobalProperty will be skipped without errors
+ *            if the property doesn't exist.
+ *
+ * An error is fatal for non-hotplugged devices, when the global is applied.
+ */
+typedef struct GlobalProperty {
+    const char *driver;
+    const char *property;
+    const char *value;
+    bool used;
+    bool optional;
+} GlobalProperty;
+
+#endif
diff --git a/qom/object.c b/qom/object.c
index ff8ede8a32..838b1d2b22 100644
--- a/qom/object.c
+++ b/qom/object.c
@@ -11,8 +11,8 @@
  */
 
 #include "qemu/osdep.h"
-#include "hw/core/qdev.h"
 #include "qapi/error.h"
+#include "qom/compat-properties.h"
 #include "qom/object.h"
 #include "qom/object_interfaces.h"
 #include "qemu/cutils.h"
-- 
2.47.3


