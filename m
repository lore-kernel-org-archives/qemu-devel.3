Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3040ED5B87B
	for <qemu-devel@archiver.kernel.org>; Tue, 16 Dec 2025 00:02:25 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vVIVW-0008By-O1; Mon, 15 Dec 2025 19:01:38 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1vVIVV-0008B3-Bk
 for qemu-devel@nongnu.org; Mon, 15 Dec 2025 19:01:37 -0500
Received: from mail-pl1-x633.google.com ([2607:f8b0:4864:20::633])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1vVIVS-0002KZ-8d
 for qemu-devel@nongnu.org; Mon, 15 Dec 2025 19:01:37 -0500
Received: by mail-pl1-x633.google.com with SMTP id
 d9443c01a7336-2a0c09bb78cso13234705ad.0
 for <qemu-devel@nongnu.org>; Mon, 15 Dec 2025 16:01:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1765843292; x=1766448092; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=mB+44J3Weaa/cCaOL32lJvGGNKnTuCfAMwh/wlpYSLQ=;
 b=Px5khcjZC4aE7qtkxR0STn+Lk80GvOPw7m0xnUtuhwxHOayB94Y1aOlJFmrEQxczR/
 eSyNkZfrGOmPWAf+/r2Nussjbgr7cyL5lZF51gsUPlDt0FQ8ufVs5gWN5kyOHC3QUhMn
 8GG2VBYngwFLowRnJmSuPDh5JIH4WPXpf/PEOK37nTPqyjnOg7HLtXdTWZtmwSgVbyGX
 27vD3Am4+Oleu7T0dvomRjk3tUa6HeGK/BZM3/hj9a4U4S1l6lTpv3ePpjBr1ngbGsm1
 hek0pWCaNsskvcy1CDui07HPb+oRWXFDlCWPc1G/SJ5Xp/QEluX2w+ZUR8ByuomZBIYh
 AhDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1765843292; x=1766448092;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=mB+44J3Weaa/cCaOL32lJvGGNKnTuCfAMwh/wlpYSLQ=;
 b=Re3TFpna2HvMWibdihFqpSXJS1ZONcGFF2c/vCNOK1YFizwnltTY2LF5mqHNW1CGqK
 L/PUIbyR/dvqiWVxEQ5K/bVSHlkIaaeV8E7TzA7QVTUjr7kHQOhS8k+EXdZnREsB/XJ/
 yW09AkvK4M3qzIHbh7oFkXEcZIGAXxdzCbIJbEYsye69LHXsEaudlK6OCKPnipkfuHlG
 fJz59Y0le++3Sio9bdrkZP+y5EE56QG2PzlxdJAc/SFow5W1DQ2ucDw0cABea6n0X6yo
 tmQSDjesji9oK2Yn+YsAUd7LMITmHnBN/kUZT+Tur3yeNkGsojFtyR8Ocml2ZNmTQPTo
 FM3w==
X-Gm-Message-State: AOJu0Yx2RYauFCTMfySwRDcnroVyXMaC5vYgX6qZAQ9jnKSmsIy2CJtq
 0DvdZueydafNJCY1V9eoPm2OsnbE31DrJ4dYg1NAGYFqu3d1DE9FOMVSHwljSFU+uqbHhFquutM
 EAW46Iew=
X-Gm-Gg: AY/fxX6ntT69vTA9wWQHIyvHvkMJDaYvMYKYBukWsJCUmzGJHkcO/Ko2dAOPRTSVFaV
 +9ZBksTqZC1BLM1OdI291DFNBFVV4oPXJrjN5/16vrvVEEKJPZDrso5rTtpdpckKfJzbjVbURxD
 PRqPeK3Qd8dJplmTvu/CNyPBFyRPystpkNgvpXYtju5lnyhSbaiGTLgBBSEt8eMkddLx4y7DqIr
 1Tj3CGWRXtsjHbTfLW5wdezdWcC37JkfmbsktIPILjbl1V2H5iadKXBKC2Ji1G0QHh/yK1/sSAX
 HZI3TOTFKUcCQP9pDBcqXvMbvjTwMRxMJmsrGy2Vgrpp96PuVicVA3cwmnjf6Yco/c7n3uxgdXz
 g/6MLNFVWUeLYS7DZJ7KXFFITnaceu9C7kHr8uBJXoGc1C6D82nHYFOy4Ytjc34uy1oJfa8g+1W
 0iBUJp5dvNPZtNI9QdZIkH4cpdiGqd9VvmO4DyHPfUnM98f5IhKcjgeH4QUG2zIok=
X-Google-Smtp-Source: AGHT+IEb4ztqg6RSp9Z9YMzj5QCXPCWo32KgE7TVyWf5pHLnUC4WDNaLkLcwsig+8P9AwQPZkjl88g==
X-Received: by 2002:a17:903:1a0d:b0:2a0:a33d:1385 with SMTP id
 d9443c01a7336-2a0a33d1628mr95502485ad.17.1765843292019; 
 Mon, 15 Dec 2025 16:01:32 -0800 (PST)
Received: from pc.taild8403c.ts.net (216-71-219-44.dyn.novuscom.net.
 [216.71.219.44]) by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2a0e96df1c9sm44882915ad.39.2025.12.15.16.01.30
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 15 Dec 2025 16:01:30 -0800 (PST)
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
To: qemu-devel@nongnu.org
Cc: Tao Tang <tangtao1634@phytium.com.cn>, qemu-arm@nongnu.org,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Peter Maydell <peter.maydell@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>,
 Eric Auger <eric.auger@redhat.com>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>
Subject: [PATCH v2 1/2] target/arm: Move ARMSecuritySpace to a common header
Date: Mon, 15 Dec 2025 16:01:21 -0800
Message-ID: <20251216000122.763264-2-pierrick.bouvier@linaro.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20251216000122.763264-1-pierrick.bouvier@linaro.org>
References: <20251216000122.763264-1-pierrick.bouvier@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::633;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-pl1-x633.google.com
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
Link: https://lists.nongnu.org/archive/html/qemu-arm/2025-09/msg01288.html
Signed-off-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
---
 include/hw/arm/arm-security.h | 37 +++++++++++++++++++++++++++++++++++
 target/arm/cpu.h              | 25 +----------------------
 2 files changed, 38 insertions(+), 24 deletions(-)
 create mode 100644 include/hw/arm/arm-security.h

diff --git a/include/hw/arm/arm-security.h b/include/hw/arm/arm-security.h
new file mode 100644
index 00000000000..196cddd14c9
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
index 39f2b2e54de..efbef0341da 100644
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


