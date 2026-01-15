Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 64A35D4660D
	for <qemu-devel@archiver.kernel.org>; Thu, 15 Jan 2026 18:55:56 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vgSVb-00016H-P3; Thu, 15 Jan 2026 13:55:53 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1vgSV8-0000ds-3x
 for qemu-devel@nongnu.org; Thu, 15 Jan 2026 13:55:24 -0500
Received: from mail-wm1-x32e.google.com ([2a00:1450:4864:20::32e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1vgSV4-0005tE-Gk
 for qemu-devel@nongnu.org; Thu, 15 Jan 2026 13:55:21 -0500
Received: by mail-wm1-x32e.google.com with SMTP id
 5b1f17b1804b1-47f3b7ef761so7223705e9.0
 for <qemu-devel@nongnu.org>; Thu, 15 Jan 2026 10:55:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1768503317; x=1769108117; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=AEo8xACRrqFksaTq19NMJKvtuBauiXQ84oXtSBtjaLQ=;
 b=B1/BTKDkceuaFrscUlHIwzbvoJX2qyFWVQcrgz6d8VXsWo5yqmdIcrTa7x1m65qRCT
 La/74YkbfzUfp2Wxwdarn7qd+Yj4BJVMhbXfX5Ajes5VUnPSXzkd+UFh5NOdmZ+VPdix
 m8G6aO0FM1ncMHI1/hVme6sfoNmhpg+544JY2hMvZPEc0sIKdVEfRRUHZATm8JoJEwW4
 UT2kYQVccG930gsztdGEj6P0e3ASn13xisZv3OzD4E1eZsBEwVBYe/48c3BHW+WPCI8C
 85AQWofQ0QMo7xhxaKOJNl+6F/zT0Ef7Hp7tgYmWcdMWkBRqLYZnSD/qkhJn2ykvECnn
 C4MQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1768503317; x=1769108117;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=AEo8xACRrqFksaTq19NMJKvtuBauiXQ84oXtSBtjaLQ=;
 b=h2dlqw8yApF7NlgN1+jbf9IP1XlMbMv53TmbOKWqYDWQFtJ+5ZORwhncQArmLj/aOp
 0xoEPnFXq7jZjOVw8QFY+VSFmsJltQk+UwGoc+QTk5K58iaXooqT9I5Eb8h7SedDrejd
 hgoc0+cM4m57kJVakmGNsvoiqy20ango80YavvStAPIhnl0tpK0A3eBDcTsNlUjI9H8J
 hXvb9JTEuNV6Ta3UI0D4t4fb672ukg7Y3POqDtkeWs6ZLOSbswBueICSK4UqecSpwNIH
 JdWADDYfzljiTWqWJwHN/0cc0WBk8NEz9wGG7VhTtxgjrsAqfbSefUUyHBx5X7gdHp5/
 7TZA==
X-Gm-Message-State: AOJu0Yxbmw9Ufd6mn/15JGoDYACIiKcImJXI9r2Cy3Bbc/J6V/tdxAXt
 fw6fyocoW++E8AN21Ay3uD3Rj6YOYc+L0op5ck4/0J/BAmIWUzI53JiH8XqeSmH8PUc6jDMrUv5
 gPnrN
X-Gm-Gg: AY/fxX5B9fhAljLVRhIBRurcwiLZ6AT9AxsE1uyc5gbq9JoaRTEFpdhY/2gCgLaRkUj
 annKVKIqXQZg3jhZAL442pcncc2h30K3SZ8C0bKDU86vCcCzuTThf5wtT2eOqOf+P/4hNZwCRS3
 Eg/TmZQTwYC0yS0SrvDgns7sWK4O6obC9DJdTphe3bX1eIvG8FLirZHv5iovaPU9KGAgWjCDx9p
 MrzLx2Lh9T/6p03gzZJ4Z0HhhZ9eVzrevuNPphIn/Nljd6gs1tTquuT5qrT39g8z19/NtowYh79
 rqRe05W+dh6zESzxfBoZFjxKk7xKLuyrpuzOww0oGpYHEoSiBXpuLp/YPW3wWSuZ/2rKSg/fEZc
 boG/JaR+sds6hWu+VHWTzR+eos+0u+vAyYKWzo4bOyolqImd9GvxG4SgHaZTqP8D3xwm6j4YyA6
 tOyZ7TOAVzjmPXb9RjxKw2vbSXdGBml8Va4I3suUGKh71xwjyK0q+BSak+F8Ot4lAupfdzkg3mN
 8CYcRNpHgSvQ+E40N+Y016OodDnRiUKqJ17mfC5xnRsGA==
X-Received: by 2002:a05:6000:4387:b0:431:9f1:e4c8 with SMTP id
 ffacd0b85a97d-4356998ad34mr441044f8f.17.1768503316909; 
 Thu, 15 Jan 2026 10:55:16 -0800 (PST)
Received: from mnementh.archaic.org.uk
 (f.7.f.1.7.5.e.f.f.f.c.5.d.8.2.4.0.0.0.0.0.d.1.0.0.b.8.0.1.0.0.2.ip6.arpa.
 [2001:8b0:1d0:0:428d:5cff:fe57:1f7f])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-4356996cecasm514207f8f.26.2026.01.15.10.55.16
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 15 Jan 2026 10:55:16 -0800 (PST)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 08/25] target/arm: Move ARMSecuritySpace to a common header
Date: Thu, 15 Jan 2026 18:54:50 +0000
Message-ID: <20260115185508.786428-9-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260115185508.786428-1-peter.maydell@linaro.org>
References: <20260115185508.786428-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32e;
 envelope-from=peter.maydell@linaro.org; helo=mail-wm1-x32e.google.com
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

From: Tao Tang <tangtao1634@phytium.com.cn>

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
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Signed-off-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Message-id: 20251216000122.763264-2-pierrick.bouvier@linaro.org
Link: https://lists.nongnu.org/archive/html/qemu-arm/2025-09/msg01288.html
Signed-off-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 include/hw/arm/arm-security.h | 37 +++++++++++++++++++++++++++++++++++
 target/arm/cpu.h              | 25 +----------------------
 2 files changed, 38 insertions(+), 24 deletions(-)
 create mode 100644 include/hw/arm/arm-security.h

diff --git a/include/hw/arm/arm-security.h b/include/hw/arm/arm-security.h
new file mode 100644
index 0000000000..196cddd14c
--- /dev/null
+++ b/include/hw/arm/arm-security.h
@@ -0,0 +1,37 @@
+/*
+ * ARM security space helpers
+ *
+ * Provide ARMSecuritySpace and helpers for code that is not tied to CPU.
+ *
+ * SPDX-License-Identifier: GPL-2.0-or-later
+ */
+
+#ifndef HW_ARM_ARM_SECURITY_H
+#define HW_ARM_ARM_SECURITY_H
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
diff --git a/target/arm/cpu.h b/target/arm/cpu.h
index 9579d43ba3..992dff41c3 100644
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
@@ -2102,30 +2103,6 @@ static inline int arm_feature(CPUARMState *env, int feature)
 
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
2.47.3


