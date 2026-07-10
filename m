Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 294A0C43458
	for <qemu-devel@archiver.kernel.org>; Fri, 10 Jul 2026 21:03:23 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wiIGZ-0003rS-9A; Fri, 10 Jul 2026 16:56:11 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wiIFE-0001mj-PV
 for qemu-devel@nongnu.org; Fri, 10 Jul 2026 16:54:48 -0400
Received: from mail-pf1-x429.google.com ([2607:f8b0:4864:20::429])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wiIEx-0000t6-JB
 for qemu-devel@nongnu.org; Fri, 10 Jul 2026 16:54:48 -0400
Received: by mail-pf1-x429.google.com with SMTP id
 d2e1a72fcca58-8487b7b4066so999501b3a.1
 for <qemu-devel@nongnu.org>; Fri, 10 Jul 2026 13:54:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1783716870; x=1784321670; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=UDGpOdZ6GdN/8EqvNC20wChll1UX5UfZiUxtmOMrgDk=;
 b=MvlW9wWMAqWYzW0ZgPcovvfmjuNHqYV6Z2iyW1SHeDpqpCuyWWsU+/hdSSE4WKchTx
 Wyn+U4Zgvn9IM8p8UVqvwvPshpVc4XKsuOnihs+C5DzNMT6NOZdKcP0GbwAyu0ucP1ei
 vqzauRGrdytZjhx9kzcLAFSJb+SW/Jvk3n0n6qM3da9Syy8pDJ409CdjDY4HpawJqcAq
 TFRrZn5AMgVy+ybcHseYXYQLUxvccamSRa56EM3tH9XVBF5ioer4aHM/TN9Tb0wps7Dk
 N0aqAMkydBIRNvKm+evtmA1S6ZLu/V8biggNHYxqS8e1ymE4vLJYEKou7vh1SLUAWaxi
 tp5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1783716870; x=1784321670;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=UDGpOdZ6GdN/8EqvNC20wChll1UX5UfZiUxtmOMrgDk=;
 b=TOkzQ2tSYxUR6ciVXYG3gNZYOiB8mQZVwPaaf7Y99BssB9N4GpS1ai2izf3apP88Sq
 0awGpyobrX95vPjRwUG2L3JdfjOuac8mZm74xXfzaggrCfE9zvO7A1pfGqljWvzjIMLu
 Qfm8JTSq2b5RrU1mMGkJrNQu/aY7erel7mjmo5OltbUX1TfSgi7LmfFKbIkBrhdsvJtL
 OebbVg20uBm45/XcwRpAEYT4rMj/lUAdHWtGfV8cA0vp8DYXZRDCpk0zYO6W939SxcTD
 S1wVndXFoRbklFM9BZ6Fl5x5fazCHD/OM2BWfrXmqkOFWbkzxH4NpWQKspVOY0HC0HLi
 YNIg==
X-Gm-Message-State: AOJu0YwqhdYjD7kkDXxBhytYc+hudciqdNapkv4Gludbyd1fA64Bgwb1
 w3Aaofo71UmZXQpzDETa9zE1KDLE7645F5a5b/QkixK/ZvYVUNWbohAj9ckzrlI+HRrNWHl9v7j
 twGRI
X-Gm-Gg: AfdE7clPW+A62imv2M68HuYdyTt0NfUzkpUdL6Q8vbmQcO/czeoIph0WB8nxOwwk2bM
 BWqL1FegIvC9DccweLTVPfaNoQlaeuWvvmpcpVL5vkH8csZy0GMqYSU3zLcW+JHxPq5T//Qup3X
 lEv0VGNt307Sxq2IXGLHBf8MG0uR2ig7fB2CLZ2hoF5xhE6oqR84hSzv/KI3L1BmsiQKIXfGU/a
 fsc9efPg9vwInO8Tdzo4QVJ/OTHh4C4+ZXlZmaE1cUVfY9sP4PpDkQ8khfJ9l+Nc628myE7+9QV
 0Bp1PPoEDGORL7kSEgmM3XeAsd0cyJT8K7nWiGnGkuwiPwwj04cak2G0h3GbniWMMjMAvk4uucX
 X4iZwuBMupxQFwZktfmth3/ApzOY311xDoJqPz7OYzGvgTnNobX1Vy0Cv+ywFK+m1Zj17B/3SYR
 N+LpW9aG7w6XiVpBruSA==
X-Received: by 2002:a05:6a00:408f:b0:848:51b3:f3af with SMTP id
 d2e1a72fcca58-848896dd4dcmr476718b3a.36.1783716869975; 
 Fri, 10 Jul 2026 13:54:29 -0700 (PDT)
Received: from stoup.. ([71.212.146.49]) by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-847f6d76106sm10780574b3a.40.2026.07.10.13.54.29
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 10 Jul 2026 13:54:29 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org, qemu-ppc@nongnu.org, qemu-riscv@nongnu.org,
 qemu-s390x@nongnu.org, jcmvbkbc@gmail.com
Subject: [PATCH v3 25/51] exec/breakpoint: Merge CPUBreakpoint and
 CPUWatchpoint
Date: Fri, 10 Jul 2026 13:53:35 -0700
Message-ID: <20260710205401.836304-26-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260710205401.836304-1-richard.henderson@linaro.org>
References: <20260710205401.836304-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::429;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x429.google.com
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

Drop the CPUBreakpoint structure and rename
CPUWatchpoint to CPUBreakpoint.

Mechanical change to adjust all uses.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 include/accel/tcg/cpu-ops.h  |  2 +-
 include/exec/breakpoint.h    | 10 ++--------
 include/hw/core/cpu.h        |  2 +-
 include/qemu/typedefs.h      |  1 -
 target/arm/cpu.h             |  2 +-
 target/arm/internals.h       |  8 ++++----
 target/i386/cpu.h            |  2 +-
 target/ppc/cpu.h             |  2 +-
 target/ppc/internal.h        |  2 +-
 target/riscv/cpu.h           |  2 +-
 target/riscv/debug.h         |  2 +-
 target/xtensa/cpu.h          |  2 +-
 accel/tcg/cpu-exec.c         |  2 +-
 accel/tcg/user-exec-stub.c   |  4 ++--
 accel/tcg/watchpoint.c       |  8 ++++----
 system/watchpoint.c          | 12 ++++++------
 target/arm/hvf/hvf.c         |  2 +-
 target/arm/hyp_gdbstub.c     |  2 +-
 target/arm/kvm.c             |  2 +-
 target/arm/tcg/debug.c       |  4 ++--
 target/i386/kvm/kvm.c        |  2 +-
 target/ppc/kvm.c             |  2 +-
 target/ppc/tcg-excp_helper.c |  2 +-
 target/riscv/debug.c         |  4 ++--
 target/s390x/kvm/kvm.c       |  2 +-
 target/s390x/tcg/debug.c     |  2 +-
 26 files changed, 40 insertions(+), 47 deletions(-)

diff --git a/include/accel/tcg/cpu-ops.h b/include/accel/tcg/cpu-ops.h
index 3988bef520..2dde42cf29 100644
--- a/include/accel/tcg/cpu-ops.h
+++ b/include/accel/tcg/cpu-ops.h
@@ -258,7 +258,7 @@ struct TCGCPUOps {
      * @debug_check_watchpoint: return true if the architectural
      * watchpoint whose address has matched should really fire.
      */
-    bool (*debug_check_watchpoint)(CPUState *cpu, CPUWatchpoint *wp);
+    bool (*debug_check_watchpoint)(CPUState *cpu, CPUBreakpoint *wp);
 
     /**
      * @debug_check_breakpoint: return true if the architectural
diff --git a/include/exec/breakpoint.h b/include/exec/breakpoint.h
index fe6dd02bdf..e9b77081e7 100644
--- a/include/exec/breakpoint.h
+++ b/include/exec/breakpoint.h
@@ -29,12 +29,6 @@ typedef uint32_t BreakpointFlags;
 #define BP_WATCHPOINT_HIT       (BP_MEM_ACCESS << BP_HIT_SHIFT)
 
 struct CPUBreakpoint {
-    IntervalTreeNode itree;     /* start == last == pc */
-    BreakpointFlags flags;
-    unsigned id;
-};
-
-struct CPUWatchpoint {
     IntervalTreeNode itree;
     vaddr hitaddr;
     vaddr hitlast;
@@ -50,11 +44,11 @@ void cpu_breakpoint_remove_by_ref(CPUState *cpu, CPUBreakpoint *breakpoint);
 void cpu_breakpoint_remove_all(CPUState *cpu, BreakpointFlags mask);
 bool cpu_breakpoint_test(CPUState *cpu, vaddr pc, BreakpointFlags mask);
 
-CPUWatchpoint *cpu_watchpoint_insert(CPUState *cpu, vaddr addr, vaddr len,
+CPUBreakpoint *cpu_watchpoint_insert(CPUState *cpu, vaddr addr, vaddr len,
                                      BreakpointFlags flags, unsigned id);
 int cpu_watchpoint_remove(CPUState *cpu, vaddr addr,
                           vaddr len, BreakpointFlags flags);
-void cpu_watchpoint_remove_by_ref(CPUState *cpu, CPUWatchpoint *watchpoint);
+void cpu_watchpoint_remove_by_ref(CPUState *cpu, CPUBreakpoint *watchpoint);
 void cpu_watchpoint_remove_all(CPUState *cpu, BreakpointFlags mask);
 
 #endif
diff --git a/include/hw/core/cpu.h b/include/hw/core/cpu.h
index 7e19ea418d..3986e43f84 100644
--- a/include/hw/core/cpu.h
+++ b/include/hw/core/cpu.h
@@ -526,7 +526,7 @@ struct CPUState {
     /* ice debug support */
     IntervalTreeRoot breakpoints;
     IntervalTreeRoot watchpoints;
-    CPUWatchpoint *watchpoint_hit;
+    CPUBreakpoint *watchpoint_hit;
 
     void *opaque;
 
diff --git a/include/qemu/typedefs.h b/include/qemu/typedefs.h
index 919fe8ebff..4c69bf7760 100644
--- a/include/qemu/typedefs.h
+++ b/include/qemu/typedefs.h
@@ -43,7 +43,6 @@ typedef struct CPUBreakpoint CPUBreakpoint;
 typedef struct CPUPluginState CPUPluginState;
 typedef struct CPUState CPUState;
 typedef struct CPUTLBEntryFull CPUTLBEntryFull;
-typedef struct CPUWatchpoint CPUWatchpoint;
 typedef struct DeviceState DeviceState;
 typedef struct DirtyBitmapSnapshot DirtyBitmapSnapshot;
 typedef struct DisasContextBase DisasContextBase;
diff --git a/target/arm/cpu.h b/target/arm/cpu.h
index f0b4599d7a..8f2e707d2f 100644
--- a/target/arm/cpu.h
+++ b/target/arm/cpu.h
@@ -755,7 +755,7 @@ typedef struct CPUArchState {
     } za_state;
 
     CPUBreakpoint *cpu_breakpoint[16];
-    CPUWatchpoint *cpu_watchpoint[16];
+    CPUBreakpoint *cpu_watchpoint[16];
 
     /* Optional fault info across tlb lookup. */
     ARMMMUFaultInfo *tlb_fi;
diff --git a/target/arm/internals.h b/target/arm/internals.h
index 95f32ad308..9d022245a2 100644
--- a/target/arm/internals.h
+++ b/target/arm/internals.h
@@ -692,7 +692,7 @@ void hw_breakpoint_update_all(ARMCPU *cpu);
 bool arm_debug_check_breakpoint(CPUState *cs, CPUBreakpoint *bp);
 
 /* Callback function for checking if a watchpoint should trigger. */
-bool arm_debug_check_watchpoint(CPUState *cs, CPUWatchpoint *wp);
+bool arm_debug_check_watchpoint(CPUState *cs, CPUBreakpoint *wp);
 
 /* Adjust addresses (in BE32 mode) before testing against watchpoint
  * addresses.
@@ -1953,13 +1953,13 @@ typedef struct {
 /*
  * The watchpoint registers can cover more area than the requested
  * watchpoint so we need to store the additional information
- * somewhere. We also need to supply a CPUWatchpoint to the GDB stub
+ * somewhere. We also need to supply a CPUBreakpoint to the GDB stub
  * when the watchpoint is hit.
  */
 typedef struct {
     uint64_t wcr;
     uint64_t wvr;
-    CPUWatchpoint details;
+    CPUBreakpoint details;
 } HWWatchpoint;
 
 /* Maximum and current break/watch point counts */
@@ -1975,7 +1975,7 @@ bool find_hw_breakpoint(CPUState *cpu, vaddr pc);
 int insert_hw_breakpoint(vaddr pc);
 int delete_hw_breakpoint(vaddr pc);
 
-CPUWatchpoint *find_hw_watchpoint(CPUState *cpu, vaddr addr);
+CPUBreakpoint *find_hw_watchpoint(CPUState *cpu, vaddr addr);
 int insert_gdbstub_hw_watchpoint(vaddr addr, vaddr len, GdbBreakpointType type);
 int delete_gdbstub_hw_watchpoint(vaddr addr, vaddr len, GdbBreakpointType type);
 
diff --git a/target/i386/cpu.h b/target/i386/cpu.h
index 9dbfa7c9b9..efff7b97f7 100644
--- a/target/i386/cpu.h
+++ b/target/i386/cpu.h
@@ -2186,7 +2186,7 @@ typedef struct CPUArchState {
     target_ulong dr[8]; /* debug registers; note dr4 and dr5 are unused */
     union {
         CPUBreakpoint *cpu_breakpoint[4];
-        CPUWatchpoint *cpu_watchpoint[4];
+        CPUBreakpoint *cpu_watchpoint[4];
     }; /* break/watchpoints for dr[0..3] */
     int old_exception;  /* exception in flight */
 
diff --git a/target/ppc/cpu.h b/target/ppc/cpu.h
index bda8ad16ad..44018be684 100644
--- a/target/ppc/cpu.h
+++ b/target/ppc/cpu.h
@@ -1321,7 +1321,7 @@ struct CPUArchState {
 #if defined(TARGET_PPC64)
     ppc_slb_t slb[MAX_SLB_ENTRIES]; /* PowerPC 64 SLB area */
     CPUBreakpoint *ciabr_breakpoint;
-    CPUWatchpoint *dawr_watchpoint[2];
+    CPUBreakpoint *dawr_watchpoint[2];
 #endif
     target_ulong sr[32];   /* segment registers */
     uint32_t nb_BATs;      /* number of BATs */
diff --git a/target/ppc/internal.h b/target/ppc/internal.h
index ec057afa92..80f4195378 100644
--- a/target/ppc/internal.h
+++ b/target/ppc/internal.h
@@ -305,7 +305,7 @@ void ppc_cpu_do_transaction_failed(CPUState *cs, hwaddr physaddr,
                                    MemTxResult response, uintptr_t retaddr);
 void ppc_cpu_debug_excp_handler(CPUState *cs);
 bool ppc_cpu_debug_check_breakpoint(CPUState *cs, CPUBreakpoint *bp);
-bool ppc_cpu_debug_check_watchpoint(CPUState *cs, CPUWatchpoint *wp);
+bool ppc_cpu_debug_check_watchpoint(CPUState *cs, CPUBreakpoint *wp);
 
 G_NORETURN void powerpc_checkstop(CPUPPCState *env, const char *reason);
 void powerpc_excp(PowerPCCPU *cpu, int excp);
diff --git a/target/riscv/cpu.h b/target/riscv/cpu.h
index 9cd38d10a3..a48bf61576 100644
--- a/target/riscv/cpu.h
+++ b/target/riscv/cpu.h
@@ -492,7 +492,7 @@ struct CPUArchState {
     uint64_t *tdata2;
     uint64_t *tdata3;
     CPUBreakpoint **cpu_breakpoint;
-    CPUWatchpoint **cpu_watchpoint;
+    CPUBreakpoint **cpu_watchpoint;
     QEMUTimer **itrigger_timer;
     int64_t last_icount;
     bool itrigger_enabled;
diff --git a/target/riscv/debug.h b/target/riscv/debug.h
index 8eb9eccd4c..f5234ff763 100644
--- a/target/riscv/debug.h
+++ b/target/riscv/debug.h
@@ -145,7 +145,7 @@ target_ulong tinfo_csr_read(CPURISCVState *env);
 
 void riscv_cpu_debug_excp_handler(CPUState *cs);
 bool riscv_cpu_debug_check_breakpoint(CPUState *cs, CPUBreakpoint *bp);
-bool riscv_cpu_debug_check_watchpoint(CPUState *cs, CPUWatchpoint *wp);
+bool riscv_cpu_debug_check_watchpoint(CPUState *cs, CPUBreakpoint *wp);
 
 void riscv_trigger_realize(CPURISCVState *env);
 void riscv_trigger_unrealize(CPURISCVState *env);
diff --git a/target/xtensa/cpu.h b/target/xtensa/cpu.h
index 590371c4dc..c256ab3cc8 100644
--- a/target/xtensa/cpu.h
+++ b/target/xtensa/cpu.h
@@ -545,7 +545,7 @@ struct CPUArchState {
     unsigned static_vectors;
 
     /* Watchpoints for DBREAK registers */
-    CPUWatchpoint *cpu_watchpoint[MAX_NDBREAK];
+    CPUBreakpoint *cpu_watchpoint[MAX_NDBREAK];
     /* Breakpoints for IBREAK registers */
     CPUBreakpoint *cpu_breakpoint[MAX_NIBREAK];
 };
diff --git a/accel/tcg/cpu-exec.c b/accel/tcg/cpu-exec.c
index ab299387e3..86ce902c34 100644
--- a/accel/tcg/cpu-exec.c
+++ b/accel/tcg/cpu-exec.c
@@ -686,7 +686,7 @@ static inline void cpu_handle_debug_exception(CPUState *cpu)
 
     for (n = interval_tree_iter_first(&cpu->watchpoints, 0, -1); n;
          n = interval_tree_iter_next(n, 0, -1)) {
-        CPUWatchpoint *wp = container_of(n, CPUWatchpoint, itree);
+        CPUBreakpoint *wp = container_of(n, CPUBreakpoint, itree);
         if (wp != cpu->watchpoint_hit) {
             wp->flags &= ~BP_WATCHPOINT_HIT;
         }
diff --git a/accel/tcg/user-exec-stub.c b/accel/tcg/user-exec-stub.c
index bf8b7113b8..c45e31e2fa 100644
--- a/accel/tcg/user-exec-stub.c
+++ b/accel/tcg/user-exec-stub.c
@@ -21,7 +21,7 @@ void cpu_exec_reset_hold(CPUState *cpu)
 {
 }
 
-CPUWatchpoint *cpu_watchpoint_insert(CPUState *cpu, vaddr addr, vaddr len,
+CPUBreakpoint *cpu_watchpoint_insert(CPUState *cpu, vaddr addr, vaddr len,
                                      BreakpointFlags flags, unsigned id)
 {
     g_assert_not_reached();
@@ -33,7 +33,7 @@ int cpu_watchpoint_remove(CPUState *cpu, vaddr addr,
     return -ENOSYS;
 }
 
-void cpu_watchpoint_remove_by_ref(CPUState *cpu, CPUWatchpoint *wp)
+void cpu_watchpoint_remove_by_ref(CPUState *cpu, CPUBreakpoint *wp)
 {
 }
 
diff --git a/accel/tcg/watchpoint.c b/accel/tcg/watchpoint.c
index edd1d5708b..bf4c46c393 100644
--- a/accel/tcg/watchpoint.c
+++ b/accel/tcg/watchpoint.c
@@ -40,7 +40,7 @@ BreakpointFlags cpu_watchpoint_address_matches(CPUState *cpu,
 
     for (n = interval_tree_iter_first(&cpu->watchpoints, addr, last); n;
          n = interval_tree_iter_next(n, addr, last)) {
-        CPUWatchpoint *wp = container_of(n, CPUWatchpoint, itree);
+        CPUBreakpoint *wp = container_of(n, CPUBreakpoint, itree);
         ret |= wp->flags;
     }
     return ret;
@@ -52,7 +52,7 @@ void cpu_check_watchpoint(CPUState *cpu, vaddr addr, vaddr len,
 {
     vaddr last = addr + len - 1;
     IntervalTreeNode *n;
-    CPUWatchpoint *found_wp = NULL;
+    CPUBreakpoint *found_wp = NULL;
     bool have_cpu_wp = false;
 
     assert(tcg_enabled());
@@ -78,7 +78,7 @@ void cpu_check_watchpoint(CPUState *cpu, vaddr addr, vaddr len,
 
     for (n = interval_tree_iter_first(&cpu->watchpoints, addr, last); n;
          n = interval_tree_iter_next(n, addr, last)) {
-        CPUWatchpoint *wp = container_of(n, CPUWatchpoint, itree);
+        CPUBreakpoint *wp = container_of(n, CPUBreakpoint, itree);
 
         if (wp->flags & flags) {
             /*
@@ -104,7 +104,7 @@ void cpu_check_watchpoint(CPUState *cpu, vaddr addr, vaddr len,
 
         for (n = interval_tree_iter_first(&cpu->watchpoints, addr, last); n;
              n = interval_tree_iter_next(n, addr, last)) {
-            CPUWatchpoint *wp = container_of(n, CPUWatchpoint, itree);
+            CPUBreakpoint *wp = container_of(n, CPUBreakpoint, itree);
 
             if ((wp->flags & BP_CPU) && (wp->flags & flags)) {
                 wp->flags &= ~BP_WATCHPOINT_HIT;
diff --git a/system/watchpoint.c b/system/watchpoint.c
index fbaebba7cf..35cb3bdaec 100644
--- a/system/watchpoint.c
+++ b/system/watchpoint.c
@@ -24,10 +24,10 @@
 #include "hw/core/cpu.h"
 
 /* Add a watchpoint.  */
-CPUWatchpoint *cpu_watchpoint_insert(CPUState *cpu, vaddr addr, vaddr len,
+CPUBreakpoint *cpu_watchpoint_insert(CPUState *cpu, vaddr addr, vaddr len,
                                      BreakpointFlags flags, unsigned id)
 {
-    CPUWatchpoint *wp;
+    CPUBreakpoint *wp;
     vaddr last = addr + len - 1;
     vaddr in_page;
 
@@ -37,7 +37,7 @@ CPUWatchpoint *cpu_watchpoint_insert(CPUState *cpu, vaddr addr, vaddr len,
     assert(ctpop32(flags & BP_ANY) == 1);
     assert(!(flags & ~(BP_ANY | BP_MEM_ACCESS | BP_STOP_BEFORE_ACCESS)));
 
-    wp = g_new0(CPUWatchpoint, 1);
+    wp = g_new0(CPUBreakpoint, 1);
 
     wp->itree.start = addr;
     wp->itree.last = last;
@@ -63,7 +63,7 @@ int cpu_watchpoint_remove(CPUState *cpu, vaddr addr, vaddr len,
 
     for (n = interval_tree_iter_first(&cpu->watchpoints, addr, addr); n;
          n = interval_tree_iter_next(n, addr, addr)) {
-        CPUWatchpoint *wp = container_of(n, CPUWatchpoint, itree);
+        CPUBreakpoint *wp = container_of(n, CPUBreakpoint, itree);
 
         if (addr == wp->itree.start &&
             last == wp->itree.last &&
@@ -76,7 +76,7 @@ int cpu_watchpoint_remove(CPUState *cpu, vaddr addr, vaddr len,
 }
 
 /* Remove a specific watchpoint by reference.  */
-void cpu_watchpoint_remove_by_ref(CPUState *cpu, CPUWatchpoint *watchpoint)
+void cpu_watchpoint_remove_by_ref(CPUState *cpu, CPUBreakpoint *watchpoint)
 {
     interval_tree_remove(&watchpoint->itree, &cpu->watchpoints);
     tlb_flush_page(cpu, watchpoint->itree.start);
@@ -89,7 +89,7 @@ void cpu_watchpoint_remove_all(CPUState *cpu, BreakpointFlags mask)
     IntervalTreeNode *n = interval_tree_iter_first(&cpu->watchpoints, 0, -1);
 
     while (n) {
-        CPUWatchpoint *wp = container_of(n, CPUWatchpoint, itree);
+        CPUBreakpoint *wp = container_of(n, CPUBreakpoint, itree);
 
         n = interval_tree_iter_next(n, 0, -1);
         if (wp->flags & mask) {
diff --git a/target/arm/hvf/hvf.c b/target/arm/hvf/hvf.c
index 70edb2f219..32e5f43ee3 100644
--- a/target/arm/hvf/hvf.c
+++ b/target/arm/hvf/hvf.c
@@ -2370,7 +2370,7 @@ static int hvf_handle_exception(CPUState *cpu, hv_vcpu_exit_exception_t *excp)
 
         cpu_synchronize_state(cpu);
 
-        CPUWatchpoint *wp =
+        CPUBreakpoint *wp =
             find_hw_watchpoint(cpu, excp->virtual_address);
         if (!wp) {
             error_report("EXCP_DEBUG but unknown hw watchpoint");
diff --git a/target/arm/hyp_gdbstub.c b/target/arm/hyp_gdbstub.c
index 8dd1fbd440..7f053c5b0e 100644
--- a/target/arm/hyp_gdbstub.c
+++ b/target/arm/hyp_gdbstub.c
@@ -240,7 +240,7 @@ bool find_hw_breakpoint(CPUState *cpu, vaddr pc)
     return false;
 }
 
-CPUWatchpoint *find_hw_watchpoint(CPUState *cpu, vaddr addr)
+CPUBreakpoint *find_hw_watchpoint(CPUState *cpu, vaddr addr)
 {
     int i;
 
diff --git a/target/arm/kvm.c b/target/arm/kvm.c
index ebe4ecbb77..c2f921095a 100644
--- a/target/arm/kvm.c
+++ b/target/arm/kvm.c
@@ -1517,7 +1517,7 @@ static bool kvm_arm_handle_debug(ARMCPU *cpu,
         break;
     case EC_WATCHPOINT:
     {
-        CPUWatchpoint *wp = find_hw_watchpoint(cs, debug_exit->far);
+        CPUBreakpoint *wp = find_hw_watchpoint(cs, debug_exit->far);
         if (wp) {
             wp->hitaddr = debug_exit->far;
             cs->watchpoint_hit = wp;
diff --git a/target/arm/tcg/debug.c b/target/arm/tcg/debug.c
index e75fd39fb6..293907fdaf 100644
--- a/target/arm/tcg/debug.c
+++ b/target/arm/tcg/debug.c
@@ -365,7 +365,7 @@ bool arm_debug_check_breakpoint(CPUState *cs, CPUBreakpoint *bp)
     return bp_wp_matches(cpu, env->cp15.dbgbcr[bp->id], arm_current_el(env));
 }
 
-bool arm_debug_check_watchpoint(CPUState *cs, CPUWatchpoint *wp)
+bool arm_debug_check_watchpoint(CPUState *cs, CPUBreakpoint *wp)
 {
     /*
      * Called by core code when a CPU watchpoint fires; need to check if this
@@ -422,7 +422,7 @@ void arm_debug_excp_handler(CPUState *cs)
      */
     ARMCPU *cpu = ARM_CPU(cs);
     CPUARMState *env = &cpu->env;
-    CPUWatchpoint *wp_hit = cs->watchpoint_hit;
+    CPUBreakpoint *wp_hit = cs->watchpoint_hit;
 
     if (wp_hit) {
         if (wp_hit->flags & BP_CPU) {
diff --git a/target/i386/kvm/kvm.c b/target/i386/kvm/kvm.c
index 51ff5cd767..2e1ecb1c83 100644
--- a/target/i386/kvm/kvm.c
+++ b/target/i386/kvm/kvm.c
@@ -6239,7 +6239,7 @@ void kvm_arch_remove_all_gdbstub_hw_breakpoints(void)
     nb_hw_breakpoint = 0;
 }
 
-static CPUWatchpoint hw_watchpoint;
+static CPUBreakpoint hw_watchpoint;
 
 static int kvm_handle_debug(X86CPU *cpu,
                             struct kvm_debug_exit_arch *arch_info)
diff --git a/target/ppc/kvm.c b/target/ppc/kvm.c
index 2a98ed89c8..f161ba6415 100644
--- a/target/ppc/kvm.c
+++ b/target/ppc/kvm.c
@@ -459,7 +459,7 @@ static struct HWBreakpoint {
     GdbBreakpointType type;
 } hw_debug_points[MAX_HW_BKPTS];
 
-static CPUWatchpoint hw_watchpoint;
+static CPUBreakpoint hw_watchpoint;
 
 /* Default there is no breakpoint and watchpoint supported */
 static int max_hw_breakpoint;
diff --git a/target/ppc/tcg-excp_helper.c b/target/ppc/tcg-excp_helper.c
index eb78a6a104..12785dc161 100644
--- a/target/ppc/tcg-excp_helper.c
+++ b/target/ppc/tcg-excp_helper.c
@@ -358,7 +358,7 @@ bool ppc_cpu_debug_check_breakpoint(CPUState *cs, CPUBreakpoint *bp)
     return false;
 }
 
-bool ppc_cpu_debug_check_watchpoint(CPUState *cs, CPUWatchpoint *wp)
+bool ppc_cpu_debug_check_watchpoint(CPUState *cs, CPUBreakpoint *wp)
 {
 #if defined(TARGET_PPC64)
     CPUPPCState *env = cpu_env(cs);
diff --git a/target/riscv/debug.c b/target/riscv/debug.c
index 6777f1a905..958c534f4f 100644
--- a/target/riscv/debug.c
+++ b/target/riscv/debug.c
@@ -945,7 +945,7 @@ bool riscv_cpu_debug_check_breakpoint(CPUState *cs, CPUBreakpoint *bp)
     return false;
 }
 
-bool riscv_cpu_debug_check_watchpoint(CPUState *cs, CPUWatchpoint *wp)
+bool riscv_cpu_debug_check_watchpoint(CPUState *cs, CPUBreakpoint *wp)
 {
     RISCVCPU *cpu = RISCV_CPU(cs);
     CPURISCVState *env = &cpu->env;
@@ -970,7 +970,7 @@ void riscv_trigger_realize(CPURISCVState *env)
     env->tdata2 = g_new0(uint64_t, env->num_triggers);
     env->tdata3 = g_new0(uint64_t, env->num_triggers);
     env->cpu_breakpoint = g_new0(CPUBreakpoint *, env->num_triggers);
-    env->cpu_watchpoint = g_new0(CPUWatchpoint *, env->num_triggers);
+    env->cpu_watchpoint = g_new0(CPUBreakpoint *, env->num_triggers);
     env->itrigger_timer = g_new0(QEMUTimer *, env->num_triggers);
 
     for (i = 0; i < env->num_triggers; i++) {
diff --git a/target/s390x/kvm/kvm.c b/target/s390x/kvm/kvm.c
index 89e90a84ec..b75dab5f3c 100644
--- a/target/s390x/kvm/kvm.c
+++ b/target/s390x/kvm/kvm.c
@@ -130,7 +130,7 @@
  */
 #define KVM_SLOT_MAX_BYTES (4UL * TiB)
 
-static CPUWatchpoint hw_watchpoint;
+static CPUBreakpoint hw_watchpoint;
 /*
  * We don't use a list because this structure is also used to transmit the
  * hardware breakpoints to the kernel.
diff --git a/target/s390x/tcg/debug.c b/target/s390x/tcg/debug.c
index bd30b85ada..9e724bb262 100644
--- a/target/s390x/tcg/debug.c
+++ b/target/s390x/tcg/debug.c
@@ -52,7 +52,7 @@ void s390_cpu_recompute_watchpoints(CPUState *cs)
 void s390x_cpu_debug_excp_handler(CPUState *cs)
 {
     CPUS390XState *env = cpu_env(cs);
-    CPUWatchpoint *wp_hit = cs->watchpoint_hit;
+    CPUBreakpoint *wp_hit = cs->watchpoint_hit;
 
     if (wp_hit && wp_hit->flags & BP_CPU) {
         /*
-- 
2.43.0


