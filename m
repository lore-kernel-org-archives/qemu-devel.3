Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BC498C282D1
	for <qemu-devel@archiver.kernel.org>; Thu,  6 Mar 2025 16:42:08 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tqEGB-0006vk-4g; Thu, 06 Mar 2025 11:39:47 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1tqEG0-0006lm-VT
 for qemu-devel@nongnu.org; Thu, 06 Mar 2025 11:39:37 -0500
Received: from mail-wr1-x434.google.com ([2a00:1450:4864:20::434])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1tqEFy-0004ae-P8
 for qemu-devel@nongnu.org; Thu, 06 Mar 2025 11:39:36 -0500
Received: by mail-wr1-x434.google.com with SMTP id
 ffacd0b85a97d-3912baafc58so546165f8f.1
 for <qemu-devel@nongnu.org>; Thu, 06 Mar 2025 08:39:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1741279173; x=1741883973; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=vxTSFCna0HuVCZNyrZWduZwQIOEnzTKyAVW239fxJio=;
 b=KEPeZQXE+d+eT0Ngb9h+TZ3WaV2ItuXH0kwUcdqGae6RXLL0I8ykrn94HBey2xDFxt
 LlWseabZBWqF4I9E7pzAqqSXGvw3uWhpvtBTUVBtRfk5OR4eVQZH8qy7ajUr2FWbXmCO
 mG7Z92SUlC6o0LpEldkcYnjmthajmU/wCndZqa91l+lRcu7VopAseQNSnGMRsZ5jOk1G
 pRf5k1QIIwIZ6Ga6J8yZRlmcyXldpkd4TTSSFraxmciJOTTiOuT6Er5C5cXvDs1ZbnlB
 KrL2ml/ZJ9BAO++AiGob4gUuBW9UjEEgfWDWx0RDCKnVNDslDemsG8pON+kMlhBF22xu
 Iz7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1741279173; x=1741883973;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=vxTSFCna0HuVCZNyrZWduZwQIOEnzTKyAVW239fxJio=;
 b=NRDD5SDhiB24E40jKV5c7wfqasa1R/r8LgpJzvRNV4XiuteEnP9WYEe/wcvf8lGhru
 sYaKZXQLd5lpYNp/TP9iLrn5YCgSgd/zfa59nsFdOrzhmYwgD+geL+REAziLtKa2SLBr
 wXA5XRyM5rmnRk/wxQog3Y4sEA7WRM2QNWPjB4bjc6+CiUHv9DXhqUiuPX2rjoZejhwj
 l36yzyygRQN2BGUEhPAWvRC1zpJ1uqo55PfEtJD8BycS2camWGVs5dcoITsUGaPuaZq/
 KWNGKPyj0IssCrP5W/PgIllmTsAd8caL8znHELmUTiSTGNEuz5DRxDo2uXYNZBKPve8Q
 4KHw==
X-Forwarded-Encrypted: i=1;
 AJvYcCUI7peEgMp2ieG66ZcpdzKK+ugeP6+GjURz1iZFOaPBfwzQqxlbfdAJrO8ve5/qD9w8FSZRpNMvbd5d@nongnu.org
X-Gm-Message-State: AOJu0Yx2cypNl93X67ZSEROQbdKtoCIG49ta7WQ5mT2Qd2xLc7Mj3AD1
 NLCJ+1C5h4ebQLqwYHT2xsR1AcAb2dG+q28N5kcPD8Xqy8ofX2//JXkfkFp+BJ/Y2Ut/RYg+RZU
 Q
X-Gm-Gg: ASbGncvn8qhP9s/Hc9fO65bhMGlaPCB5fIT8QqWHdiSX5ZUEL4HDyxed3N+1ED3qsg7
 pqH8aqH0edwSHXHi0TP3zHGpzLcZZcV6yhEU2an2IOSMxZCTd7TqO2yEPH0l4crEr+vDoVXcAvC
 rCqnU3gt3D3AnxKfPfV0BGIidbxBus4STMLG7ExdxmW0F2t8drMKBLog4HeH26XEpqr7f8WG/Kb
 0OlKYwyvW7WXdo/KQj8hTQcjLDHRDZ56iXhUbf0sAndwfQzEFy2FeckeM9j8w/BbB6pJdYRn9HX
 2yStEMTsY0tiSAWCCg9iJ+XKfH2vkYrRwHCp3/e76x4T67zDMuo=
X-Google-Smtp-Source: AGHT+IH4KVbaMISuzOYsAPqbPgMkGvEvc90VWxve7ucpp2HdwOsqrewdw2fIUlYc9v1m1iyiXvYIzQ==
X-Received: by 2002:a5d:5889:0:b0:390:f745:bbfb with SMTP id
 ffacd0b85a97d-3911f74256dmr6902144f8f.26.1741279172805; 
 Thu, 06 Mar 2025 08:39:32 -0800 (PST)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [2001:8b0:1d0::2])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-43bdd94913fsm23999905e9.37.2025.03.06.08.39.32
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 06 Mar 2025 08:39:32 -0800 (PST)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-arm@nongnu.org,
	qemu-devel@nongnu.org
Subject: [PATCH 06/10] target/arm: Move arm_current_el() and arm_el_is_aa64()
 to internals.h
Date: Thu,  6 Mar 2025 16:39:20 +0000
Message-ID: <20250306163925.2940297-7-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250306163925.2940297-1-peter.maydell@linaro.org>
References: <20250306163925.2940297-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::434;
 envelope-from=peter.maydell@linaro.org; helo=mail-wr1-x434.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

The functions arm_current_el() and arm_el_is_aa64() are used only in
target/arm and in hw/intc/arm_gicv3_cpuif.c.  They're functions that
query internal state of the CPU.  Move them out of cpu.h and into
internals.h.

This means we need to include internals.h in arm_gicv3_cpuif.c, but
this is justifiable because that file is implementing the GICv3 CPU
interface, which really is part of the CPU proper; we just ended up
implementing it in code in hw/intc/ for historical reasons.

The motivation for this move is that we'd like to change
arm_el_is_aa64() to add a condition that uses cpu_isar_feature();
but we don't want to include cpu-features.h in cpu.h.

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 target/arm/cpu.h          | 66 --------------------------------------
 target/arm/internals.h    | 67 +++++++++++++++++++++++++++++++++++++++
 hw/intc/arm_gicv3_cpuif.c |  1 +
 target/arm/arch_dump.c    |  1 +
 4 files changed, 69 insertions(+), 66 deletions(-)

diff --git a/target/arm/cpu.h b/target/arm/cpu.h
index 16c9083be61..a779fd5ae94 100644
--- a/target/arm/cpu.h
+++ b/target/arm/cpu.h
@@ -2633,39 +2633,6 @@ uint64_t arm_hcr_el2_eff_secstate(CPUARMState *env, ARMSecuritySpace space);
 uint64_t arm_hcr_el2_eff(CPUARMState *env);
 uint64_t arm_hcrx_el2_eff(CPUARMState *env);
 
-/* Return true if the specified exception level is running in AArch64 state. */
-static inline bool arm_el_is_aa64(CPUARMState *env, int el)
-{
-    /* This isn't valid for EL0 (if we're in EL0, is_a64() is what you want,
-     * and if we're not in EL0 then the state of EL0 isn't well defined.)
-     */
-    assert(el >= 1 && el <= 3);
-    bool aa64 = arm_feature(env, ARM_FEATURE_AARCH64);
-
-    /* The highest exception level is always at the maximum supported
-     * register width, and then lower levels have a register width controlled
-     * by bits in the SCR or HCR registers.
-     */
-    if (el == 3) {
-        return aa64;
-    }
-
-    if (arm_feature(env, ARM_FEATURE_EL3) &&
-        ((env->cp15.scr_el3 & SCR_NS) || !(env->cp15.scr_el3 & SCR_EEL2))) {
-        aa64 = aa64 && (env->cp15.scr_el3 & SCR_RW);
-    }
-
-    if (el == 2) {
-        return aa64;
-    }
-
-    if (arm_is_el2_enabled(env)) {
-        aa64 = aa64 && (env->cp15.hcr_el2 & HCR_RW);
-    }
-
-    return aa64;
-}
-
 /*
  * Function for determining whether guest cp register reads and writes should
  * access the secure or non-secure bank of a cp register.  When EL3 is
@@ -2697,39 +2664,6 @@ static inline bool arm_v7m_is_handler_mode(CPUARMState *env)
     return env->v7m.exception != 0;
 }
 
-/* Return the current Exception Level (as per ARMv8; note that this differs
- * from the ARMv7 Privilege Level).
- */
-static inline int arm_current_el(CPUARMState *env)
-{
-    if (arm_feature(env, ARM_FEATURE_M)) {
-        return arm_v7m_is_handler_mode(env) ||
-            !(env->v7m.control[env->v7m.secure] & 1);
-    }
-
-    if (is_a64(env)) {
-        return extract32(env->pstate, 2, 2);
-    }
-
-    switch (env->uncached_cpsr & 0x1f) {
-    case ARM_CPU_MODE_USR:
-        return 0;
-    case ARM_CPU_MODE_HYP:
-        return 2;
-    case ARM_CPU_MODE_MON:
-        return 3;
-    default:
-        if (arm_is_secure(env) && !arm_el_is_aa64(env, 3)) {
-            /* If EL3 is 32-bit then all secure privileged modes run in
-             * EL3
-             */
-            return 3;
-        }
-
-        return 1;
-    }
-}
-
 /**
  * write_list_to_cpustate
  * @cpu: ARMCPU
diff --git a/target/arm/internals.h b/target/arm/internals.h
index 70d1f88c20b..b3f732233f4 100644
--- a/target/arm/internals.h
+++ b/target/arm/internals.h
@@ -392,6 +392,73 @@ static inline FloatRoundMode arm_rmode_to_sf(ARMFPRounding rmode)
     return arm_rmode_to_sf_map[rmode];
 }
 
+/* Return true if the specified exception level is running in AArch64 state. */
+static inline bool arm_el_is_aa64(CPUARMState *env, int el)
+{
+    /*
+     * This isn't valid for EL0 (if we're in EL0, is_a64() is what you want,
+     * and if we're not in EL0 then the state of EL0 isn't well defined.)
+     */
+    assert(el >= 1 && el <= 3);
+    bool aa64 = arm_feature(env, ARM_FEATURE_AARCH64);
+
+    /*
+     * The highest exception level is always at the maximum supported
+     * register width, and then lower levels have a register width controlled
+     * by bits in the SCR or HCR registers.
+     */
+    if (el == 3) {
+        return aa64;
+    }
+
+    if (arm_feature(env, ARM_FEATURE_EL3) &&
+        ((env->cp15.scr_el3 & SCR_NS) || !(env->cp15.scr_el3 & SCR_EEL2))) {
+        aa64 = aa64 && (env->cp15.scr_el3 & SCR_RW);
+    }
+
+    if (el == 2) {
+        return aa64;
+    }
+
+    if (arm_is_el2_enabled(env)) {
+        aa64 = aa64 && (env->cp15.hcr_el2 & HCR_RW);
+    }
+
+    return aa64;
+}
+
+/*
+ * Return the current Exception Level (as per ARMv8; note that this differs
+ * from the ARMv7 Privilege Level).
+ */
+static inline int arm_current_el(CPUARMState *env)
+{
+    if (arm_feature(env, ARM_FEATURE_M)) {
+        return arm_v7m_is_handler_mode(env) ||
+            !(env->v7m.control[env->v7m.secure] & 1);
+    }
+
+    if (is_a64(env)) {
+        return extract32(env->pstate, 2, 2);
+    }
+
+    switch (env->uncached_cpsr & 0x1f) {
+    case ARM_CPU_MODE_USR:
+        return 0;
+    case ARM_CPU_MODE_HYP:
+        return 2;
+    case ARM_CPU_MODE_MON:
+        return 3;
+    default:
+        if (arm_is_secure(env) && !arm_el_is_aa64(env, 3)) {
+            /* If EL3 is 32-bit then all secure privileged modes run in EL3 */
+            return 3;
+        }
+
+        return 1;
+    }
+}
+
 static inline bool arm_cpu_data_is_big_endian_a32(CPUARMState *env,
                                                   bool sctlr_b)
 {
diff --git a/hw/intc/arm_gicv3_cpuif.c b/hw/intc/arm_gicv3_cpuif.c
index 7f1d071c198..de37465bc87 100644
--- a/hw/intc/arm_gicv3_cpuif.c
+++ b/hw/intc/arm_gicv3_cpuif.c
@@ -22,6 +22,7 @@
 #include "cpu.h"
 #include "target/arm/cpregs.h"
 #include "target/arm/cpu-features.h"
+#include "target/arm/internals.h"
 #include "system/tcg.h"
 #include "system/qtest.h"
 
diff --git a/target/arm/arch_dump.c b/target/arm/arch_dump.c
index 5c943dc27b5..c40df4e7fd7 100644
--- a/target/arm/arch_dump.c
+++ b/target/arm/arch_dump.c
@@ -23,6 +23,7 @@
 #include "elf.h"
 #include "system/dump.h"
 #include "cpu-features.h"
+#include "internals.h"
 
 /* struct user_pt_regs from arch/arm64/include/uapi/asm/ptrace.h */
 struct aarch64_user_regs {
-- 
2.43.0


