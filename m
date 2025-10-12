Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A3A52CCD187
	for <qemu-devel@archiver.kernel.org>; Sun, 12 Oct 2025 15:09:26 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v7xfb-0001hO-AN; Sun, 12 Oct 2025 11:07:36 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <tangtao1634@phytium.com.cn>)
 id 1v7xfP-0001d3-Mw; Sun, 12 Oct 2025 11:07:23 -0400
Received: from zg8tmtyylji0my4xnjqumte4.icoremail.net ([162.243.164.118])
 by eggs.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <tangtao1634@phytium.com.cn>)
 id 1v7xfL-0001cm-E4; Sun, 12 Oct 2025 11:07:23 -0400
Received: from prodtpl.icoremail.net (unknown [10.12.1.20])
 by hzbj-icmmx-6 (Coremail) with SMTP id AQAAfwBHKCUcxOtoZycrAA--.7486S2;
 Sun, 12 Oct 2025 23:07:08 +0800 (CST)
Received: from phytium.com.cn (unknown [218.76.62.144])
 by mail (Coremail) with SMTP id AQAAfwDXPOoXxOto33dMAA--.3068S7;
 Sun, 12 Oct 2025 23:07:06 +0800 (CST)
From: Tao Tang <tangtao1634@phytium.com.cn>
To: Eric Auger <eric.auger@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>
Cc: qemu-devel@nongnu.org, qemu-arm@nongnu.org,
 Chen Baozi <chenbaozi@phytium.com.cn>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Jean-Philippe Brucker <jean-philippe@linaro.org>,
 Mostafa Saleh <smostafa@google.com>, Tao Tang <tangtao1634@phytium.com.cn>
Subject: [RFC v3 04/21] refactor: Move ARMSecuritySpace to a common header
Date: Sun, 12 Oct 2025 23:06:44 +0800
Message-Id: <20251012150701.4127034-5-tangtao1634@phytium.com.cn>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20251012150701.4127034-1-tangtao1634@phytium.com.cn>
References: <20251012150701.4127034-1-tangtao1634@phytium.com.cn>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: AQAAfwDXPOoXxOto33dMAA--.3068S7
X-CM-SenderInfo: pwdqw3tdrrljuu6sx5pwlxzhxfrphubq/1tbiAQABBWjqskUBWwAAsq
Authentication-Results: hzbj-icmmx-6; spf=neutral smtp.mail=tangtao163
 4@phytium.com.cn;
X-Coremail-Antispam: 1Uk129KBjvJXoWxXF45CF1xJr1fJF4kJryDAwb_yoWrurW7pF
 4Yyas3Gr48Ga43Gas3ZFsrGF1rK395WF47KFyxWr4kXFnxur1kCr4vyF1YkFy5GrW5Z3WF
 9r1xZr4fKF1kXrJanT9S1TB71UUUUUDqnTZGkaVYY2UrUUUUj1kv1TuYvTs0mT0YCTnIWj
 DUYxn0WfASr-VFAU7a7-sFnT9fnUUIcSsGvfJ3UbIYCTnIWIevJa73UjIFyTuYvj4RJUUU
 UUUUU
Received-SPF: pass client-ip=162.243.164.118;
 envelope-from=tangtao1634@phytium.com.cn;
 helo=zg8tmtyylji0my4xnjqumte4.icoremail.net
X-Spam_score_int: -25
X-Spam_score: -2.6
X-Spam_bar: --
X-Spam_report: (-2.6 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_LOW=-0.7,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
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

The ARMSecuritySpace enum and its related helpers were defined in the
target-specific header target/arm/cpu.h. This prevented common,
target-agnostic code like the SMMU model from using these definitions
without triggering "cpu.h included from common code" errors.

To resolve this, this commit introduces a new, lightweight header,
include/hw/arm/arm-security.h, which is safe for inclusion by common
code.

The following change was made:

- The ARMSecuritySpace enum and the arm_space_is_secure() and
arm_secure_to_space() helpers have been moved from target/arm/cpu.h
to the new hw/arm/arm-security.h header.

This refactoring decouples the security state definitions from the core
CPU implementation, allowing common hardware models to correctly handle
security states without pulling in heavyweight, target-specific headers.

Signed-off-by: Tao Tang <tangtao1634@phytium.com.cn>
Reviewed-by: Eric Auger <eric.auger@redhat.com>
Link: https://lists.nongnu.org/archive/html/qemu-arm/2025-09/msg01288.html
---
 include/hw/arm/arm-security.h | 54 +++++++++++++++++++++++++++++++++++
 target/arm/cpu.h              | 25 +---------------
 2 files changed, 55 insertions(+), 24 deletions(-)
 create mode 100644 include/hw/arm/arm-security.h

diff --git a/include/hw/arm/arm-security.h b/include/hw/arm/arm-security.h
new file mode 100644
index 0000000000..9664c0f95e
--- /dev/null
+++ b/include/hw/arm/arm-security.h
@@ -0,0 +1,54 @@
+/*
+ * ARM security space helpers
+ *
+ * Provide ARMSecuritySpace and helpers for code that is not tied to CPU.
+ *
+ *  Copyright (c) 2003 Fabrice Bellard
+ *
+ * This library is free software; you can redistribute it and/or
+ * modify it under the terms of the GNU Lesser General Public
+ * License as published by the Free Software Foundation; either
+ * version 2.1 of the License, or (at your option) any later version.
+ *
+ * This library is distributed in the hope that it will be useful,
+ * but WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
+ * Lesser General Public License for more details.
+ *
+ * You should have received a copy of the GNU Lesser General Public
+ * License along with this library; if not, see <http://www.gnu.org/licenses/>.
+ */
+
+#ifndef HW_ARM_ARM_SECURITY_H
+#define HW_ARM_ARM_SECURITY_H
+
+#include <stdbool.h>
+
+/*
+ * ARM v9 security states.
+ * The ordering of the enumeration corresponds to the low 2 bits
+ * of the GPI value, and (except for Root) the concat of NSE:NS.
+ */
+
+ typedef enum ARMSecuritySpace {
+    ARMSS_Secure     = 0,
+    ARMSS_NonSecure  = 1,
+    ARMSS_Root       = 2,
+    ARMSS_Realm      = 3,
+} ARMSecuritySpace;
+
+/* Return true if @space is secure, in the pre-v9 sense. */
+static inline bool arm_space_is_secure(ARMSecuritySpace space)
+{
+    return space == ARMSS_Secure || space == ARMSS_Root;
+}
+
+/* Return the ARMSecuritySpace for @secure, assuming !RME or EL[0-2]. */
+static inline ARMSecuritySpace arm_secure_to_space(bool secure)
+{
+    return secure ? ARMSS_Secure : ARMSS_NonSecure;
+}
+
+#endif /* HW_ARM_ARM_SECURITY_H */
+
+
diff --git a/target/arm/cpu.h b/target/arm/cpu.h
index 1d4e13320c..3336d95c6a 100644
--- a/target/arm/cpu.h
+++ b/target/arm/cpu.h
@@ -31,6 +31,7 @@
 #include "exec/page-protection.h"
 #include "qapi/qapi-types-common.h"
 #include "target/arm/multiprocessing.h"
+#include "hw/arm/arm-security.h"
 #include "target/arm/gtimer.h"
 #include "target/arm/cpu-sysregs.h"
 #include "target/arm/mmuidx.h"
@@ -2098,30 +2099,6 @@ static inline int arm_feature(CPUARMState *env, int feature)
 
 void arm_cpu_finalize_features(ARMCPU *cpu, Error **errp);
 
-/*
- * ARM v9 security states.
- * The ordering of the enumeration corresponds to the low 2 bits
- * of the GPI value, and (except for Root) the concat of NSE:NS.
- */
-
-typedef enum ARMSecuritySpace {
-    ARMSS_Secure     = 0,
-    ARMSS_NonSecure  = 1,
-    ARMSS_Root       = 2,
-    ARMSS_Realm      = 3,
-} ARMSecuritySpace;
-
-/* Return true if @space is secure, in the pre-v9 sense. */
-static inline bool arm_space_is_secure(ARMSecuritySpace space)
-{
-    return space == ARMSS_Secure || space == ARMSS_Root;
-}
-
-/* Return the ARMSecuritySpace for @secure, assuming !RME or EL[0-2]. */
-static inline ARMSecuritySpace arm_secure_to_space(bool secure)
-{
-    return secure ? ARMSS_Secure : ARMSS_NonSecure;
-}
 
 #if !defined(CONFIG_USER_ONLY)
 /**
-- 
2.34.1


