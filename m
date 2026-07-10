Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3FBF1C44506
	for <qemu-devel@archiver.kernel.org>; Fri, 10 Jul 2026 21:02:27 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wiIK2-0001sD-LW; Fri, 10 Jul 2026 16:59:46 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wiIIH-0000el-V4
 for qemu-devel@nongnu.org; Fri, 10 Jul 2026 16:57:58 -0400
Received: from mail-pj1-x1029.google.com ([2607:f8b0:4864:20::1029])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wiII9-0001se-8L
 for qemu-devel@nongnu.org; Fri, 10 Jul 2026 16:57:57 -0400
Received: by mail-pj1-x1029.google.com with SMTP id
 98e67ed59e1d1-38d489b6b71so1141579a91.0
 for <qemu-devel@nongnu.org>; Fri, 10 Jul 2026 13:57:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1783717067; x=1784321867; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=FJD0bozxsAaU8VxtEpxfjjLduhuIEtavECVR9Kha1MU=;
 b=rRJfzR5dQgokgJH1nmNtVoZQ47y3BR3+qvWWHZvyGq45Dfmc+Yy3ohGUB8WQe+Z/vA
 tHr3/3f7KgFC8GDrNUvHhZu0doHfO4HhvjIQ2rvMUU23BdPrKBSJldnkH10/oPb1bRcs
 DxJcVDWseIEy8qiYpnZoiKhFzsu5ToG6gRxbISNWonEHG13X+ONc8fCELOzsoWzyzdnd
 lRto5c039h5/dO3sGDd5u40vgwURganF/+dv+kvciByxyuEAC7VpZzYw6iSoQlyV8imY
 CALmR673xGX/Dt2SBPU6Y++K+q0i8burVLbmf/rMQ6XsbIFYnS4r9RVWOX525ap7kmNq
 wjAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1783717067; x=1784321867;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=FJD0bozxsAaU8VxtEpxfjjLduhuIEtavECVR9Kha1MU=;
 b=aQjDsduUa6T50pDNDNQQLgWOT+mkKA/J1M57/ktPA47EAOEl5TxjYayQ6mK3g1/qcR
 Mw0Q/IHp/JsOXcQndna9WLTVKQlUJIejzBT3NHwJ554Qzqx1cxLLw91+3VexQNFq87c0
 GNy6oA+ze/9c21nDh0h2Q9CIl51CmNxxpKGlHbd1C3ivFz11czGRcLD2Cdj9gk/a0KBA
 AsnJzrTl83xlOsOPL7R68+US5t52Q2xKyAFzvjGSnNSIF9G3fxE6fqOJQs3PqgN74y1l
 8p9OzjWHu5L3w134KxgltKO35lw/JMGUhwL2X0svg81NkayNW6CHMVY/2giSXBEU5rgZ
 dVgA==
X-Gm-Message-State: AOJu0Yy3/7oLNd1FNVVN5Jn/Z7qI6iSyxsa6Rqc9LpRqLN5W1JqZF164
 9Fig0uagXiZxPd4BHnUewvjK69kPPnFbdfhmYgWH7P26w+UR92hiDgzzX5ilT7ZOgD55Km0DOvD
 V11Ty
X-Gm-Gg: AfdE7cnQYuq2ShiQZrE+lko+y7ZCLVeUwc+Zet6DT66TDehCcNEi2xKxX4Dakp65+jS
 dZtFJeY3secZweQqlhvS+r/KsrJs1KuZLzh6q3CspVASe3rZbu4tHvOTFiiEqRJn+DREG2v3Rur
 Sz4WrL9ECOWqDKyaTD39isTvks7Nm99GgAnnylexB4oysBT1zmZvLhTZs2p8h2nAPPy7TQXS1MX
 Jl31AQd1hexMUI1eDYDnKui9E1LXu09XcwxkKLlkLsQxmRN340znvS4m1sYvxlKMFxNS/C6dLY3
 qR3BQFNevKYSXXKFUGKVCDvfqRv3qIu/riSWePMdDkBVipkuwNOyPor9Wo1v2RuPLbmjh93xSAD
 8mqXLBVzOrGiUnOXHRkE0f50ZS+eXWpeAxQgn4lfnseOf11+vacYz0i9vsctgPv/4YDcwjRJ9ae
 SKxkOuapPLjGUBExquTQ==
X-Received: by 2002:a17:90b:510f:b0:37e:a09:2640 with SMTP id
 98e67ed59e1d1-38dc761aba3mr531684a91.7.1783717067270; 
 Fri, 10 Jul 2026 13:57:47 -0700 (PDT)
Received: from stoup.. ([71.212.146.49]) by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-38a58792cdasm3256221a91.16.2026.07.10.13.57.46
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 10 Jul 2026 13:57:46 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org, qemu-ppc@nongnu.org, qemu-riscv@nongnu.org,
 qemu-s390x@nongnu.org, jcmvbkbc@gmail.com
Subject: [PATCH v3 43/51] target/arm: Simplify v6 watchpoints
Date: Fri, 10 Jul 2026 13:53:53 -0700
Message-ID: <20260710205401.836304-44-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260710205401.836304-1-richard.henderson@linaro.org>
References: <20260710205401.836304-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::1029;
 envelope-from=richard.henderson@linaro.org; helo=mail-pj1-x1029.google.com
X-Spam_score_int: 4
X-Spam_score: 0.4
X-Spam_bar: /
X-Spam_report: (0.4 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1, DKIM_VALID=-0.1,
 DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_DNSWL_NONE=-0.0001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 SUSPICIOUS_RECIPS=2.51 autolearn=no autolearn_force=no
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

Rather than use arm_adjust_watchpoint_address, delay the
interpretation of BAS until the check_watchpoint hook so
that we use the current value of SCTLR.B.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/arm/internals.h    |   5 --
 target/arm/cpu.c          |   1 -
 target/arm/debug_helper.c |  12 +++
 target/arm/tcg/cpu-v7m.c  |   1 -
 target/arm/tcg/debug.c    | 159 ++++++++++++++++++++++++--------------
 5 files changed, 114 insertions(+), 64 deletions(-)

diff --git a/target/arm/internals.h b/target/arm/internals.h
index 9deb7a6e22..4446adb896 100644
--- a/target/arm/internals.h
+++ b/target/arm/internals.h
@@ -694,11 +694,6 @@ bool arm_debug_check_breakpoint(CPUState *cs, CPUBreakpoint *bp);
 /* Callback function for checking if a watchpoint should trigger. */
 bool arm_debug_check_watchpoint(CPUState *cs, CPUBreakpoint *wp);
 
-/* Adjust addresses (in BE32 mode) before testing against watchpoint
- * addresses.
- */
-vaddr arm_adjust_watchpoint_address(CPUState *cs, vaddr addr, int len);
-
 /* Callback function for when a watchpoint or breakpoint triggers. */
 void arm_debug_excp_handler(CPUState *cs, CPUBreakpoint *hit);
 
diff --git a/target/arm/cpu.c b/target/arm/cpu.c
index 787e4dc7ab..e06fbb903a 100644
--- a/target/arm/cpu.c
+++ b/target/arm/cpu.c
@@ -2609,7 +2609,6 @@ static const TCGCPUOps arm_tcg_ops = {
     .do_interrupt = arm_cpu_do_interrupt,
     .do_transaction_failed = arm_cpu_do_transaction_failed,
     .do_unaligned_access = arm_cpu_do_unaligned_access,
-    .adjust_watchpoint_address = arm_adjust_watchpoint_address,
     .debug_check_watchpoint = arm_debug_check_watchpoint,
     .debug_check_breakpoint = arm_debug_check_breakpoint,
 #endif /* !CONFIG_USER_ONLY */
diff --git a/target/arm/debug_helper.c b/target/arm/debug_helper.c
index 2c3a56c7d5..086043cf5e 100644
--- a/target/arm/debug_helper.c
+++ b/target/arm/debug_helper.c
@@ -362,6 +362,18 @@ static void dbgwcr_write(CPUARMState *env, const ARMCPRegInfo *ri,
     ARMCPU *cpu = env_archcpu(env);
     int i = ri->crm;
 
+    /*
+     * Bits [7:4] of BAS are RAZ/WI if an 8-bit field is not supported.
+     * This is always true of v6 debug.
+     * As an IMPLEMENTATION DEFINED choice, we always implement the 8-bit
+     * field with ARMv7 cpus.
+     * This is never true of v8 debug.
+     * The Linux kernel will probe for 4 or 8-bit by writing all 1's.
+     */
+    if (!arm_feature(env, ARM_FEATURE_V7)) {
+        value &= ~FIELD_DP64(0, DBGWCR, BAS, 0xf0);
+    }
+
     raw_write(env, ri, value);
     if (tcg_enabled()) {
         hw_watchpoint_update(cpu, i);
diff --git a/target/arm/tcg/cpu-v7m.c b/target/arm/tcg/cpu-v7m.c
index dc249ce1f1..b7e5623c59 100644
--- a/target/arm/tcg/cpu-v7m.c
+++ b/target/arm/tcg/cpu-v7m.c
@@ -262,7 +262,6 @@ static const TCGCPUOps arm_v7m_tcg_ops = {
     .do_interrupt = arm_v7m_cpu_do_interrupt,
     .do_transaction_failed = arm_cpu_do_transaction_failed,
     .do_unaligned_access = arm_cpu_do_unaligned_access,
-    .adjust_watchpoint_address = arm_adjust_watchpoint_address,
     .debug_check_watchpoint = arm_debug_check_watchpoint,
     .debug_check_breakpoint = arm_debug_check_breakpoint,
 #endif /* !CONFIG_USER_ONLY */
diff --git a/target/arm/tcg/debug.c b/target/arm/tcg/debug.c
index d705f7aef2..1dec39c0bf 100644
--- a/target/arm/tcg/debug.c
+++ b/target/arm/tcg/debug.c
@@ -365,6 +365,31 @@ bool arm_debug_check_breakpoint(CPUState *cs, CPUBreakpoint *bp)
     return bp_wp_matches(cpu, env->cp15.dbgbcr[bp->id], arm_current_el(env));
 }
 
+static bool arm_debug_check_watchpoint_v6(CPUARMState *env, CPUBreakpoint *wp)
+{
+    uint32_t wcr = env->cp15.dbgwcr[wp->id];
+    uint32_t bas = FIELD_EX64(wcr, DBGWCR, BAS) & 0xf;
+
+    /* Create a mask of the bytes touched by the access. */
+    uint32_t hitlen = wp->hitlast - wp->hitaddr + 1;
+    uint32_t hitmask = MAKE_64BIT_MASK(wp->hitaddr & 3, hitlen);
+
+    /* With BE-32, the interpretation of BAS is inverted.  */
+    if (arm_sctlr_b(env)) {
+        bas = revbit8(bas) >> 4;
+    }
+
+    hitmask &= bas;
+    if (!hitmask) {
+        return false;
+    }
+
+    /* Update hit to the first byte matched. */
+    wp->hitaddr = wp->itree.start + ctz32(hitmask);
+    wp->hitlast = wp->hitaddr;
+    return true;
+}
+
 bool arm_debug_check_watchpoint(CPUState *cs, CPUBreakpoint *wp)
 {
     /*
@@ -380,7 +405,13 @@ bool arm_debug_check_watchpoint(CPUState *cs, CPUBreakpoint *wp)
      */
     int access_el = wp->hitattrs.user ? 0 : arm_current_el(env);
 
-    return bp_wp_matches(cpu, env->cp15.dbgwcr[wp->id], access_el);
+    /*
+     * For ARM v6, we need to validate the address match.
+     * After that, everyone needs to validate linked watchpoints.
+     */
+    return ((arm_feature(env, ARM_FEATURE_V7) ||
+             arm_debug_check_watchpoint_v6(env, wp)) &&
+            bp_wp_matches(cpu, env->cp15.dbgwcr[wp->id], access_el));
 }
 
 /*
@@ -481,46 +512,44 @@ void HELPER(exception_swstep)(CPUARMState *env, uint32_t syndrome)
     raise_exception_debug(env, EXCP_UDEF, syndrome);
 }
 
-void hw_watchpoint_update(ARMCPU *cpu, int n)
+static void hw_watchpoint_update_v6(ARMCPU *cpu, int n, BreakpointFlags flags)
+{
+    /*
+     * With v6:
+     * - MASK does not exist,
+     * - BAS is 4 bits,
+     * - non-consecutive BAS bits are not yet deprecated,
+     * - BE-32 is supported, affecting interpretation of BAS.
+     * Install a 4 byte aligned watchpoint now and defer checking
+     * of the BAS bits until breakpoint hit.
+     */
+    CPUARMState *env = &cpu->env;
+    uint32_t wvr = env->cp15.dbgwvr[n] & ~3;
+    uint32_t wcr = env->cp15.dbgwcr[n];
+    uint32_t bas = FIELD_EX64(wcr, DBGWCR, BAS) & 0xf;
+
+    if (bas == 0) {
+        /* This must act as if the watchpoint is disabled */
+        return;
+    }
+
+    env->cpu_watchpoint[n] = cpu_watchpoint_insert(CPU(cpu), wvr, 4,
+                                                   flags, n);
+}
+
+static void hw_watchpoint_update_v7(ARMCPU *cpu, int n, BreakpointFlags flags)
 {
     CPUARMState *env = &cpu->env;
     vaddr len = 0;
     vaddr wvr = env->cp15.dbgwvr[n];
     uint64_t wcr = env->cp15.dbgwcr[n];
-    int mask;
-    BreakpointFlags flags = BP_CPU | BP_STOP_BEFORE_ACCESS;
-
-    if (env->cpu_watchpoint[n]) {
-        cpu_watchpoint_remove_by_ref(CPU(cpu), env->cpu_watchpoint[n]);
-        env->cpu_watchpoint[n] = NULL;
-    }
-
-    if (!FIELD_EX64(wcr, DBGWCR, E)) {
-        /* E bit clear : watchpoint disabled */
-        return;
-    }
-
-    switch (FIELD_EX64(wcr, DBGWCR, LSC)) {
-    case 0:
-        /* LSC 00 is reserved and must behave as if the wp is disabled */
-        return;
-    case 1:
-        flags |= BP_MEM_READ;
-        break;
-    case 2:
-        flags |= BP_MEM_WRITE;
-        break;
-    case 3:
-        flags |= BP_MEM_ACCESS;
-        break;
-    }
+    int mask = FIELD_EX64(wcr, DBGWCR, MASK);
 
     /*
      * Attempts to use both MASK and BAS fields simultaneously are
      * CONSTRAINED UNPREDICTABLE; we opt to ignore BAS in this case,
      * thus generating a watchpoint for every byte in the masked region.
      */
-    mask = FIELD_EX64(wcr, DBGWCR, MASK);
     if (mask == 1 || mask == 2) {
         /*
          * Reserved values of MASK; we must act as if the mask value was
@@ -570,6 +599,49 @@ void hw_watchpoint_update(ARMCPU *cpu, int n)
                                                    flags, n);
 }
 
+void hw_watchpoint_update(ARMCPU *cpu, int n)
+{
+    CPUARMState *env = &cpu->env;
+    uint64_t wcr = env->cp15.dbgwcr[n];
+    int flags = BP_CPU | BP_STOP_BEFORE_ACCESS;
+
+    if (env->cpu_watchpoint[n]) {
+        cpu_watchpoint_remove_by_ref(CPU(cpu), env->cpu_watchpoint[n]);
+        env->cpu_watchpoint[n] = NULL;
+    }
+
+    if (!FIELD_EX64(wcr, DBGWCR, E)) {
+        /* E bit clear : watchpoint disabled */
+        return;
+    }
+
+    switch (FIELD_EX64(wcr, DBGWCR, LSC)) {
+    case 0:
+        /* LSC 00 is reserved and must behave as if the wp is disabled */
+        return;
+    case 1:
+        flags |= BP_MEM_READ;
+        break;
+    case 2:
+        flags |= BP_MEM_WRITE;
+        break;
+    case 3:
+        flags |= BP_MEM_ACCESS;
+        break;
+    }
+
+    /*
+     * ARM v6 debug.  The AArch32 DBGDIDR register is deprecated
+     * under certain v8 conditions, and ID_DFR0 doesn't exist pre-v7.
+     * Cut the proverbial knot by checking cpu features.
+     */
+    if (arm_feature(env, ARM_FEATURE_V7)) {
+        hw_watchpoint_update_v7(cpu, n, flags);
+    } else {
+        hw_watchpoint_update_v6(cpu, n, flags);
+    }
+}
+
 void hw_watchpoint_update_all(ARMCPU *cpu)
 {
     int i;
@@ -689,30 +761,3 @@ void hw_breakpoint_update_all(ARMCPU *cpu)
         hw_breakpoint_update(cpu, i);
     }
 }
-
-#if !defined(CONFIG_USER_ONLY)
-
-vaddr arm_adjust_watchpoint_address(CPUState *cs, vaddr addr, int len)
-{
-    ARMCPU *cpu = ARM_CPU(cs);
-    CPUARMState *env = &cpu->env;
-
-    /*
-     * In BE32 system mode, target memory is stored byteswapped (on a
-     * little-endian host system), and by the time we reach here (via an
-     * opcode helper) the addresses of subword accesses have been adjusted
-     * to account for that, which means that watchpoints will not match.
-     * Undo the adjustment here.
-     */
-    if (arm_sctlr_b(env)) {
-        if (len == 1) {
-            addr ^= 3;
-        } else if (len == 2) {
-            addr ^= 2;
-        }
-    }
-
-    return addr;
-}
-
-#endif /* !CONFIG_USER_ONLY */
-- 
2.43.0


