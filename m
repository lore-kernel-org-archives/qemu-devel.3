Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C6022C28B30
	for <qemu-devel@archiver.kernel.org>; Fri, 14 Mar 2025 13:17:54 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tt4uD-00058K-44; Fri, 14 Mar 2025 09:16:53 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1tt4u8-00057Z-El
 for qemu-devel@nongnu.org; Fri, 14 Mar 2025 09:16:48 -0400
Received: from mail-wm1-x329.google.com ([2a00:1450:4864:20::329])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1tt4u6-00013w-D0
 for qemu-devel@nongnu.org; Fri, 14 Mar 2025 09:16:48 -0400
Received: by mail-wm1-x329.google.com with SMTP id
 5b1f17b1804b1-43cf06eabdaso19898575e9.2
 for <qemu-devel@nongnu.org>; Fri, 14 Mar 2025 06:16:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1741958205; x=1742563005; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=MFEetzhpy67fb1rZmq/TyHXKzbhpMLPrqzm1/ZE2RQA=;
 b=zxp4wtDsLPqWqwTHnv9eVb6qltpMmSKsHTQLh2QFSDchat4NSyY1RZ98UIEnDm3RI0
 sd5y7Vdcc/tqP/rQKwv5Xr9f0Q6kZkIYaLcjxY6ZzQTf0YUgNF1ma0daPBqnlqkIaIqF
 OSYSYtYuOP/69DV+K/IWOV3iJB2p47vVxDPtmPx8ct8KEghVaX9lQRSUJj96oT/KUykL
 MdfkSjebAMUwYuDfFCGfUoqMQEsF95onPgNdAn1RXzOmjFdwLYbHOlAKYK5iLCGUu2aG
 NxRz8RcZ0tQ8ummwExdph48+wbbwA2hugCFLe75HZ4qx/2UUPQUMDI38l5YQb8U8ITNY
 Jv2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1741958205; x=1742563005;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=MFEetzhpy67fb1rZmq/TyHXKzbhpMLPrqzm1/ZE2RQA=;
 b=NqUfITtcNOA5hfD2P+5WU7gB9Am57M0jIEwGKlMnnBHSM+3CDLJT22Ucvg4VG0AWhs
 crJPPaUJPYe9OjgM2Q47vt/U/hTlECAqEM5zDls2y3N070mF2Q0OrT+ay5VQkxYu2MEI
 6H459st9ve7tSgDnGMMwkEHBZMVAy7oDJHGRy8F73jMZ+GUd8c5/7vAygxcGSNYhGojo
 m0SNckd5CgAqxIs4JF6OmpOOFvEzcZLI2USWWnRMQJWcgJRkKl5iVokG0LbunLzfB0Ek
 nXLuyIx2A/oDOHAnFdJy/5BrJ+xgTvd/tzq05iE0HjfB7gqNxX/5aO/O2Cp3AJKkrmCD
 KVVw==
X-Gm-Message-State: AOJu0Ywp33k9jIabePQwp90v+rh59/JqP4WRAk0Uih72q0COwCEX3QkQ
 uCGHRpxSv+XtL6rLsn/70LpKJQ4RbMxX+4q4h6qVKVJmiUtzhkE86JKSXHDnm+6e1N2laUqaFiL
 C
X-Gm-Gg: ASbGnct/2w9f3OjaG3ILZJ93oze4A4FPne+rbNav1ONtKqYuiitJGS0T4bckKz7gDhJ
 kBQ3MGn6IB16C1XtZsgq9eNuODddxPOYJ/LX4/rl2AVefBfL+lm3TyNPXQcHd+/3E87BuIeMaRI
 UcM53X25DCWcbchT6f1My2Q3ZGZNVjQCCmDj4lCSjia8FsxYuEXmYpMISYyPuezP/jnbbg4ZGRu
 nNepo0NiDkSoiUUzV7NHr9i6FrAcdpmNCERZh9LNtc1UsS0lsl+/QIMu6R+eQTMdChbKwxDTuLx
 KGMSzdZmE/e8r8T61of5ZVJbC4u0yQ6k2lxR5bi7B+DXV+3kaqc=
X-Google-Smtp-Source: AGHT+IEPlQtZnrUYrcipvFZM7x3kZiRYxT7K78w3QC4eSxRrZW5yfp83tSUq6VQn7lUOd478syUCAw==
X-Received: by 2002:a05:600c:a21b:b0:43c:fcbc:968c with SMTP id
 5b1f17b1804b1-43d1ef4b09amr33168435e9.7.1741958204826; 
 Fri, 14 Mar 2025 06:16:44 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [2001:8b0:1d0::2])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-395cb7eb93csm5437923f8f.86.2025.03.14.06.16.43
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 14 Mar 2025 06:16:44 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 05/17] target/arm: Move arm_cpu_data_is_big_endian() etc to
 internals.h
Date: Fri, 14 Mar 2025 13:16:25 +0000
Message-ID: <20250314131637.371866-6-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250314131637.371866-1-peter.maydell@linaro.org>
References: <20250314131637.371866-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::329;
 envelope-from=peter.maydell@linaro.org; helo=mail-wm1-x329.google.com
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

The arm_cpu_data_is_big_endian() and related functions are now used
only in target/arm; they can be moved to internals.h.

The motivation here is that we would like to move arm_current_el()
to internals.h.

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/arm/cpu.h       | 48 ------------------------------------------
 target/arm/internals.h | 48 ++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 48 insertions(+), 48 deletions(-)

diff --git a/target/arm/cpu.h b/target/arm/cpu.h
index 12d2706f2b5..8a59f705167 100644
--- a/target/arm/cpu.h
+++ b/target/arm/cpu.h
@@ -3032,47 +3032,6 @@ static inline bool arm_sctlr_b(CPUARMState *env)
 
 uint64_t arm_sctlr(CPUARMState *env, int el);
 
-static inline bool arm_cpu_data_is_big_endian_a32(CPUARMState *env,
-                                                  bool sctlr_b)
-{
-#ifdef CONFIG_USER_ONLY
-    /*
-     * In system mode, BE32 is modelled in line with the
-     * architecture (as word-invariant big-endianness), where loads
-     * and stores are done little endian but from addresses which
-     * are adjusted by XORing with the appropriate constant. So the
-     * endianness to use for the raw data access is not affected by
-     * SCTLR.B.
-     * In user mode, however, we model BE32 as byte-invariant
-     * big-endianness (because user-only code cannot tell the
-     * difference), and so we need to use a data access endianness
-     * that depends on SCTLR.B.
-     */
-    if (sctlr_b) {
-        return true;
-    }
-#endif
-    /* In 32bit endianness is determined by looking at CPSR's E bit */
-    return env->uncached_cpsr & CPSR_E;
-}
-
-static inline bool arm_cpu_data_is_big_endian_a64(int el, uint64_t sctlr)
-{
-    return sctlr & (el ? SCTLR_EE : SCTLR_E0E);
-}
-
-/* Return true if the processor is in big-endian mode. */
-static inline bool arm_cpu_data_is_big_endian(CPUARMState *env)
-{
-    if (!is_a64(env)) {
-        return arm_cpu_data_is_big_endian_a32(env, arm_sctlr_b(env));
-    } else {
-        int cur_el = arm_current_el(env);
-        uint64_t sctlr = arm_sctlr(env, cur_el);
-        return arm_cpu_data_is_big_endian_a64(cur_el, sctlr);
-    }
-}
-
 #include "exec/cpu-all.h"
 
 /*
@@ -3258,13 +3217,6 @@ static inline bool bswap_code(bool sctlr_b)
 #endif
 }
 
-#ifdef CONFIG_USER_ONLY
-static inline bool arm_cpu_bswap_data(CPUARMState *env)
-{
-    return TARGET_BIG_ENDIAN ^ arm_cpu_data_is_big_endian(env);
-}
-#endif
-
 void cpu_get_tb_cpu_state(CPUARMState *env, vaddr *pc,
                           uint64_t *cs_base, uint32_t *flags);
 
diff --git a/target/arm/internals.h b/target/arm/internals.h
index bb962389192..c2c59e60309 100644
--- a/target/arm/internals.h
+++ b/target/arm/internals.h
@@ -392,6 +392,54 @@ static inline FloatRoundMode arm_rmode_to_sf(ARMFPRounding rmode)
     return arm_rmode_to_sf_map[rmode];
 }
 
+static inline bool arm_cpu_data_is_big_endian_a32(CPUARMState *env,
+                                                  bool sctlr_b)
+{
+#ifdef CONFIG_USER_ONLY
+    /*
+     * In system mode, BE32 is modelled in line with the
+     * architecture (as word-invariant big-endianness), where loads
+     * and stores are done little endian but from addresses which
+     * are adjusted by XORing with the appropriate constant. So the
+     * endianness to use for the raw data access is not affected by
+     * SCTLR.B.
+     * In user mode, however, we model BE32 as byte-invariant
+     * big-endianness (because user-only code cannot tell the
+     * difference), and so we need to use a data access endianness
+     * that depends on SCTLR.B.
+     */
+    if (sctlr_b) {
+        return true;
+    }
+#endif
+    /* In 32bit endianness is determined by looking at CPSR's E bit */
+    return env->uncached_cpsr & CPSR_E;
+}
+
+static inline bool arm_cpu_data_is_big_endian_a64(int el, uint64_t sctlr)
+{
+    return sctlr & (el ? SCTLR_EE : SCTLR_E0E);
+}
+
+/* Return true if the processor is in big-endian mode. */
+static inline bool arm_cpu_data_is_big_endian(CPUARMState *env)
+{
+    if (!is_a64(env)) {
+        return arm_cpu_data_is_big_endian_a32(env, arm_sctlr_b(env));
+    } else {
+        int cur_el = arm_current_el(env);
+        uint64_t sctlr = arm_sctlr(env, cur_el);
+        return arm_cpu_data_is_big_endian_a64(cur_el, sctlr);
+    }
+}
+
+#ifdef CONFIG_USER_ONLY
+static inline bool arm_cpu_bswap_data(CPUARMState *env)
+{
+    return TARGET_BIG_ENDIAN ^ arm_cpu_data_is_big_endian(env);
+}
+#endif
+
 static inline void aarch64_save_sp(CPUARMState *env, int el)
 {
     if (env->pstate & PSTATE_SP) {
-- 
2.43.0


