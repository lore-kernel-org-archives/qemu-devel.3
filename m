Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CFB91C44516
	for <qemu-devel@archiver.kernel.org>; Fri, 17 Jul 2026 23:27:09 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wkrtr-0001Vq-30; Fri, 17 Jul 2026 19:23:23 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wkrtk-0001SI-Fp
 for qemu-devel@nongnu.org; Fri, 17 Jul 2026 19:23:17 -0400
Received: from mail-pj1-x102d.google.com ([2607:f8b0:4864:20::102d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wkrti-0006xp-Hk
 for qemu-devel@nongnu.org; Fri, 17 Jul 2026 19:23:16 -0400
Received: by mail-pj1-x102d.google.com with SMTP id
 98e67ed59e1d1-381c51fde6bso8331347a91.2
 for <qemu-devel@nongnu.org>; Fri, 17 Jul 2026 16:23:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1784330593; x=1784935393; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=/3aFVhh4R0lFQSwDx2BhLx8jPqJaBt2/8J/G1SbTklc=;
 b=j97965/CssragNDEUxROdPlZhyrQxNdGcJOxcQ6+qd+ADb+ovE5FxOQP+5PeJXADqk
 zRxNlWsky0tnoO6BJlHtpUb3sbLgNhDfSncOMNOZtcKYW5yiu6L1ibwnWYQQLmq7CYov
 BuddXvmXXiS/whq6WJYNlYVOAWNbpKrpps1i3lAW4Eqchs3JLg7HQ4qHtZ2JfRm4XAbP
 JZD5uwMru8+nrr/9ArqiRhKTGAWB6nPAaeW2KqOCthjH/+PuITdN6OAkiBa2Zgc8gbQF
 j52Bm3FgR78BxashExAiMa+r3eEKey34NbKJgJlM9KdTpkXYU6lqCs/hAm2tqPTLSqyV
 JrZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1784330593; x=1784935393;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=/3aFVhh4R0lFQSwDx2BhLx8jPqJaBt2/8J/G1SbTklc=;
 b=IVoqCoKqjflC6BWINk/b9LxoCHxdmgPhgLDPlUSiUGa/Yp7LYA5k7tk4Z0y3I5K5MP
 Zh77luqiMgg9mgEJP3ChM6sJ50OXRiyUBSeLdSjvQH2ag/WQTZi5waI57GUWMr9ToHUX
 CuXSV85/vo3nXHTrUnNbKRkx8YnW7xf026XmwmoxwkC0m+38u2Fmfgl0dIlSolQb0igm
 TtDnS4bYK4GChGRRdt+hQPtyn1hfxNFyNa9nc3KAoQ5VZUN+AWam32W7lLth9DrgIirP
 prvoopeYqTpPBbA+lOBHl8jYQ1CacgtFBpdZYluuQHHaQYnusSi7QyfVL8KtLMd+B/nc
 YOLA==
X-Gm-Message-State: AOJu0Ywb6j7YT+S3BstqoFVottBq1qtJLVo+QSeDTb1JZyELAYVBQi2g
 VMK+4vroXREMZJfuXWw2uavTJPY1qHjwgF1J2GmztS63lEkwfwV7jvfJuKE1kFUlb41PzeR6tts
 jFADQ
X-Gm-Gg: AfdE7cmVC7m6IPzpEyOQ+jtfrvlh/3oT+O4bU/KByr8kc6S1cnz0bNyYTxYL+QCFSyX
 q7fUwoHpUFO4gDUwdWKOXNJHhfo9RGjvcz9McsdIomZMa9hks831vHNo9WT7tVrXkesopb6O6/t
 rkuJmgyAUAUp9dbnTF6rtUlAldcf4sIZ4QHd/2neO5W9/VqR4o5LG/rtWNByZumasXQ6BhnIH0l
 igtDPnfmT2ls1eViiBhrrB9UCfI4M7fBUj2mdz6du9VTcX9aGT8wFGbF6ShXFOD9mhj4tdWXp8X
 Y/o0uH4gchlFxg1MfqbgVsPxLIQ5bb2hBQ5wjqu/gnylfs4nRqlFGqQf6SweKDvbV+kP50wp/KN
 HIrfMgK/fILrtI/cglCXR7BoVXhKM1AyVYfbddJ6ax8IqJP7NQBNpWh1GQvueFB0XCa4jsJ8VBS
 SOMWn5s54=
X-Received: by 2002:a17:90b:5288:b0:38e:3542:212 with SMTP id
 98e67ed59e1d1-38e4b4462f1mr4681781a91.13.1784330592995; 
 Fri, 17 Jul 2026 16:23:12 -0700 (PDT)
Received: from stoup.. ([32.140.233.50]) by smtp.gmail.com with ESMTPSA id
 a92af1059eb24-13ce2a18a47sm8186261c88.8.2026.07.17.16.23.12
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 17 Jul 2026 16:23:12 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org
Subject: [PATCH 03/17] target/arm: Move helper_dc_zva to mte_helper.c
Date: Fri, 17 Jul 2026 16:22:51 -0700
Message-ID: <20260717232306.378988-5-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260717232306.378988-1-richard.henderson@linaro.org>
References: <20260717232306.378988-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::102d;
 envelope-from=richard.henderson@linaro.org; helo=mail-pj1-x102d.google.com
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

Slightly odd, perhaps, but there are 3 MTE variations of DC_ZVA
and this is the easiest way to share code.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/arm/tcg/helper-a64.c | 50 ------------------------------------
 target/arm/tcg/mte_helper.c | 51 +++++++++++++++++++++++++++++++++++++
 2 files changed, 51 insertions(+), 50 deletions(-)

diff --git a/target/arm/tcg/helper-a64.c b/target/arm/tcg/helper-a64.c
index 05ab9ab6d3..63ef6d90ec 100644
--- a/target/arm/tcg/helper-a64.c
+++ b/target/arm/tcg/helper-a64.c
@@ -786,56 +786,6 @@ illegal_return:
 }
 #endif /* !CONFIG_USER_ONLY */
 
-void HELPER(dc_zva)(CPUARMState *env, uint64_t vaddr_in)
-{
-    uintptr_t ra = GETPC();
-
-    /*
-     * Implement DC ZVA, which zeroes a fixed-length block of memory.
-     * Note that we do not implement the (architecturally mandated)
-     * alignment fault for attempts to use this on Device memory
-     * (which matches the usual QEMU behaviour of not implementing either
-     * alignment faults or any memory attribute handling).
-     */
-    int blocklen = 4 << get_dczid_bs(env_archcpu(env));
-    uint64_t vaddr = vaddr_in & ~(blocklen - 1);
-    int mmu_idx = arm_env_mmu_index(env);
-    void *mem;
-
-    /*
-     * Trapless lookup.  In addition to actual invalid page, may
-     * return NULL for I/O, watchpoints, clean pages, etc.
-     */
-    mem = tlb_vaddr_to_host(env, vaddr, MMU_DATA_STORE, mmu_idx);
-
-#ifndef CONFIG_USER_ONLY
-    if (unlikely(!mem)) {
-        /*
-         * Trap if accessing an invalid page.  DC_ZVA requires that we supply
-         * the original pointer for an invalid page.  But watchpoints require
-         * that we probe the actual space.  So do both.
-         */
-        (void) probe_write(env, vaddr_in, 1, mmu_idx, ra);
-        mem = probe_write(env, vaddr, blocklen, mmu_idx, ra);
-
-        if (unlikely(!mem)) {
-            /*
-             * The only remaining reason for mem == NULL is I/O.
-             * Just do a series of byte writes as the architecture demands.
-             */
-            for (int i = 0; i < blocklen; i++) {
-                cpu_stb_mmuidx_ra(env, vaddr + i, 0, mmu_idx, ra);
-            }
-            return;
-        }
-    }
-#endif
-
-    set_helper_retaddr(ra);
-    memset(mem, 0, blocklen);
-    clear_helper_retaddr();
-}
-
 void HELPER(arm_unaligned_access)(CPUARMState *env, uint64_t addr,
                                   uint32_t access_type, uint32_t mmu_idx)
 {
diff --git a/target/arm/tcg/mte_helper.c b/target/arm/tcg/mte_helper.c
index ad4ad5b4cc..993aba5df4 100644
--- a/target/arm/tcg/mte_helper.c
+++ b/target/arm/tcg/mte_helper.c
@@ -32,6 +32,7 @@
 #endif
 #include "accel/tcg/cpu-ldst.h"
 #include "accel/tcg/probe.h"
+#include "accel/tcg/helper-retaddr.h"
 #include "helper-a64.h"
 #include "exec/tlb-flags.h"
 #include "accel/tcg/cpu-ops.h"
@@ -1017,6 +1018,56 @@ bool mte_probe(CPUARMState *env, uint32_t desc, uint64_t ptr)
     return ret != 0;
 }
 
+void HELPER(dc_zva)(CPUARMState *env, uint64_t vaddr_in)
+{
+    uintptr_t ra = GETPC();
+
+    /*
+     * Implement DC ZVA, which zeroes a fixed-length block of memory.
+     * Note that we do not implement the (architecturally mandated)
+     * alignment fault for attempts to use this on Device memory
+     * (which matches the usual QEMU behaviour of not implementing either
+     * alignment faults or any memory attribute handling).
+     */
+    int blocklen = 4 << get_dczid_bs(env_archcpu(env));
+    uint64_t vaddr = vaddr_in & ~(blocklen - 1);
+    int mmu_idx = arm_env_mmu_index(env);
+    void *mem;
+
+    /*
+     * Trapless lookup.  In addition to actual invalid page, may
+     * return NULL for I/O, watchpoints, clean pages, etc.
+     */
+    mem = tlb_vaddr_to_host(env, vaddr, MMU_DATA_STORE, mmu_idx);
+
+#ifndef CONFIG_USER_ONLY
+    if (unlikely(!mem)) {
+        /*
+         * Trap if accessing an invalid page.  DC_ZVA requires that we supply
+         * the original pointer for an invalid page.  But watchpoints require
+         * that we probe the actual space.  So do both.
+         */
+        (void) probe_write(env, vaddr_in, 1, mmu_idx, ra);
+        mem = probe_write(env, vaddr, blocklen, mmu_idx, ra);
+
+        if (unlikely(!mem)) {
+            /*
+             * The only remaining reason for mem == NULL is I/O.
+             * Just do a series of byte writes as the architecture demands.
+             */
+            for (int i = 0; i < blocklen; i++) {
+                cpu_stb_mmuidx_ra(env, vaddr + i, 0, mmu_idx, ra);
+            }
+            return;
+        }
+    }
+#endif
+
+    set_helper_retaddr(ra);
+    memset(mem, 0, blocklen);
+    clear_helper_retaddr();
+}
+
 /*
  * Perform an MTE checked access for DC_ZVA.
  */
-- 
2.43.0


