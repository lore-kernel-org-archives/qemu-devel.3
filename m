Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 87579C43458
	for <qemu-devel@archiver.kernel.org>; Fri, 10 Jul 2026 20:56:14 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wiIG9-0002rr-Qg; Fri, 10 Jul 2026 16:55:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wiIFB-0001iI-92
 for qemu-devel@nongnu.org; Fri, 10 Jul 2026 16:54:45 -0400
Received: from mail-pf1-x433.google.com ([2607:f8b0:4864:20::433])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wiIEt-0000o3-Hw
 for qemu-devel@nongnu.org; Fri, 10 Jul 2026 16:54:42 -0400
Received: by mail-pf1-x433.google.com with SMTP id
 d2e1a72fcca58-8487de17abaso64973b3a.0
 for <qemu-devel@nongnu.org>; Fri, 10 Jul 2026 13:54:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1783716866; x=1784321666; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=42co0mDh6L6bESb0gXu2fwgy0JNlrBbKeAp5pQJcyYg=;
 b=QYcjrWVsmGNOaZyexlRGPM63edToLwwkGJr689pJYbXCgtBzUecg/JjxbZcPCn21hQ
 ZUX9tRd2iF3qbn/iVj3TO5Gxc6OgLIJlQV83VWfPSrM8VJ0iHmhBuHWHKhILIxbHGUVL
 RdUCgeI475FUCQIorEjVtOMgbsU5IAKQzfZV2FB4O8TdaNnJhsf9fewn3krBY00BbNIg
 KUEZ0YP9V+IBwW0aGVeGzWHWwxeUQq93YciTQh+vi7Y+mY4mcRJ6F5baqj7gCzu4yi5b
 LdibzRUM4FoALBmmeyCafqOVN/pv7DX8U4jmLH7SYGvHU+cp3vbIynm/VRJn7IbgFa9F
 jNtA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1783716866; x=1784321666;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=42co0mDh6L6bESb0gXu2fwgy0JNlrBbKeAp5pQJcyYg=;
 b=sPyEa4bgO0UMME4CkjY9uuj6ZRa27ZmVR/jp4FgWw5L6qGGFdmJcC72aTFBYu6KTEE
 OrZvcBOIHxt+ytZJSdnd0CSlSX9Vh+c5lfec9nyDjnwQnhfSb+bOK6Miw4Dfqkf3Np5Q
 W0e0wBhizxwPBoQQiOcGtuE3xw3A66dGN3N+SbvOjea/E3Wy2Gq9aatBf6fEqisX6NHG
 0X0EnxuwFqenzPEptCgZ/Z/AihhmgqzHpY9+cYxDGgmY760JTMXohcKW1wVHwgq0ham4
 x5edNB2opDd808Or7izituSoJBMv3SlMdi/O3FRHi9wnEAxXCdJ6gAzsD862UHabi8j/
 M+uQ==
X-Gm-Message-State: AOJu0Yys+TTKzHaZPhVjxDe4ZWDoyf0jo0ZUPnCYWRtbaWvpuyIaFBPk
 IJMkAo8CHE4F20vrrgnkK+ZikT42Sp1o++jHAKz/Dwn1ilPsVXvuu8eYi5IxglEqOIjpCGe1LaC
 Q8Bo5
X-Gm-Gg: AfdE7cmhcZlNY2jjkmUgkucQYbpPCS+ybQZFovw+B6HhY23mP9m07yOKvG0tHoOnx+f
 1IMMlWVk3ZeZ46FEdctneqbcngOziFUBrKBsVS1Nz2O1N86GCt76crEwPGHEccNg53ocxHJ05VW
 Rd1RZ9pXMdBwHI/U91wHGXCkdlqT3MzsVqeDNmnorTWfFMwd3DsHDWXRibOiGVJi8i1cbokEDLy
 77l6WzZ0yBXpTBmT+rUrKC2SnrEQgENN/KW1jeGyU5uMX00fphypNonTtHPOHS6jElvmZsdLx+k
 9bt+PMYYk1h5XRLzBDNcpp5ChrgVzVYoqdc1Ca4nNE3Osuyi5BT2KOwRBLqustT+OimWK0r2i7I
 PSQ1h46XA6zOdnrDMgHKoBEebhqs+LD66QyWzv11ASFoG46s2ie+YTz4A7Jf/eoEv+VMryNIVbI
 tdbq/NOTeSCmcBA81I6w==
X-Received: by 2002:a05:6a00:4109:b0:848:5010:ad63 with SMTP id
 d2e1a72fcca58-848898317eemr446126b3a.62.1783716865950; 
 Fri, 10 Jul 2026 13:54:25 -0700 (PDT)
Received: from stoup.. ([71.212.146.49]) by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-847f6d76106sm10780574b3a.40.2026.07.10.13.54.24
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 10 Jul 2026 13:54:25 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org, qemu-ppc@nongnu.org, qemu-riscv@nongnu.org,
 qemu-s390x@nongnu.org, jcmvbkbc@gmail.com
Subject: [PATCH v3 21/51] exec/breakpoint: Return the new wp from
 cpu_watchpoint_insert
Date: Fri, 10 Jul 2026 13:53:31 -0700
Message-ID: <20260710205401.836304-22-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260710205401.836304-1-richard.henderson@linaro.org>
References: <20260710205401.836304-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::433;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x433.google.com
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

The cpu_watchpoint_insert function cannot fail, so the error
return value isn't actually used.  Instead of returning the
new watchpoint by reference, return it directly.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 include/exec/breakpoint.h           |  5 ++---
 accel/tcg/tcg-accel-ops.c           |  9 ++-------
 accel/tcg/user-exec-stub.c          |  7 +++----
 system/watchpoint.c                 | 11 +++--------
 target/arm/tcg/debug.c              |  4 ++--
 target/i386/tcg/system/bpt_helper.c | 20 ++++++++------------
 target/ppc/cpu.c                    |  4 ++--
 target/riscv/debug.c                | 28 +++++++++-------------------
 target/s390x/tcg/debug.c            | 10 +++++-----
 target/xtensa/dbg_helper.c          | 10 +++-------
 10 files changed, 39 insertions(+), 69 deletions(-)

diff --git a/include/exec/breakpoint.h b/include/exec/breakpoint.h
index 95aa4f5933..60fda8dbb7 100644
--- a/include/exec/breakpoint.h
+++ b/include/exec/breakpoint.h
@@ -49,9 +49,8 @@ void cpu_breakpoint_remove_by_ref(CPUState *cpu, CPUBreakpoint *breakpoint);
 void cpu_breakpoint_remove_all(CPUState *cpu, BreakpointFlags mask);
 bool cpu_breakpoint_test(CPUState *cpu, vaddr pc, BreakpointFlags mask);
 
-int cpu_watchpoint_insert(CPUState *cpu, vaddr addr, vaddr len,
-                          BreakpointFlags flags, unsigned id,
-                          CPUWatchpoint **watchpoint);
+CPUWatchpoint *cpu_watchpoint_insert(CPUState *cpu, vaddr addr, vaddr len,
+                                     BreakpointFlags flags, unsigned id);
 int cpu_watchpoint_remove(CPUState *cpu, vaddr addr,
                           vaddr len, BreakpointFlags flags);
 void cpu_watchpoint_remove_by_ref(CPUState *cpu, CPUWatchpoint *watchpoint);
diff --git a/accel/tcg/tcg-accel-ops.c b/accel/tcg/tcg-accel-ops.c
index 4dee5ea57f..79289bf7b2 100644
--- a/accel/tcg/tcg-accel-ops.c
+++ b/accel/tcg/tcg-accel-ops.c
@@ -131,7 +131,6 @@ static int tcg_insert_gdbstub_breakpoint(CPUState *cs, GdbBreakpointType type,
                                          vaddr addr, vaddr len)
 {
     CPUState *cpu;
-    int err = 0;
 
     switch (type) {
     case GDB_BREAKPOINT_SW:
@@ -147,13 +146,9 @@ static int tcg_insert_gdbstub_breakpoint(CPUState *cs, GdbBreakpointType type,
             return -EINVAL;
         }
         CPU_FOREACH(cpu) {
-            err = cpu_watchpoint_insert(cpu, addr, len,
-                                        xlat_gdb_type(cpu, type), 0, NULL);
-            if (err) {
-                break;
-            }
+            cpu_watchpoint_insert(cpu, addr, len, xlat_gdb_type(cpu, type), 0);
         }
-        return err;
+        return 0;
     default:
         return -ENOSYS;
     }
diff --git a/accel/tcg/user-exec-stub.c b/accel/tcg/user-exec-stub.c
index 42e4861868..bf8b7113b8 100644
--- a/accel/tcg/user-exec-stub.c
+++ b/accel/tcg/user-exec-stub.c
@@ -21,11 +21,10 @@ void cpu_exec_reset_hold(CPUState *cpu)
 {
 }
 
-int cpu_watchpoint_insert(CPUState *cpu, vaddr addr, vaddr len,
-                          BreakpointFlags flags, unsigned id,
-                          CPUWatchpoint **watchpoint)
+CPUWatchpoint *cpu_watchpoint_insert(CPUState *cpu, vaddr addr, vaddr len,
+                                     BreakpointFlags flags, unsigned id)
 {
-    return -ENOSYS;
+    g_assert_not_reached();
 }
 
 int cpu_watchpoint_remove(CPUState *cpu, vaddr addr,
diff --git a/system/watchpoint.c b/system/watchpoint.c
index 01cf0f61a8..183b194403 100644
--- a/system/watchpoint.c
+++ b/system/watchpoint.c
@@ -24,9 +24,8 @@
 #include "hw/core/cpu.h"
 
 /* Add a watchpoint.  */
-int cpu_watchpoint_insert(CPUState *cpu, vaddr addr, vaddr len,
-                          BreakpointFlags flags, unsigned id,
-                          CPUWatchpoint **watchpoint)
+CPUWatchpoint *cpu_watchpoint_insert(CPUState *cpu, vaddr addr, vaddr len,
+                                     BreakpointFlags flags, unsigned id)
 {
     CPUWatchpoint *wp;
     vaddr last = addr + len - 1;
@@ -49,11 +48,7 @@ int cpu_watchpoint_insert(CPUState *cpu, vaddr addr, vaddr len,
     } else {
         tlb_flush(cpu);
     }
-
-    if (watchpoint) {
-        *watchpoint = wp;
-    }
-    return 0;
+    return wp;
 }
 
 /* Remove a specific watchpoint.  */
diff --git a/target/arm/tcg/debug.c b/target/arm/tcg/debug.c
index 2c73ca1080..e75fd39fb6 100644
--- a/target/arm/tcg/debug.c
+++ b/target/arm/tcg/debug.c
@@ -581,8 +581,8 @@ void hw_watchpoint_update(ARMCPU *cpu, int n)
         wvr += basstart;
     }
 
-    cpu_watchpoint_insert(CPU(cpu), wvr, len, flags, n,
-                          &env->cpu_watchpoint[n]);
+    env->cpu_watchpoint[n] = cpu_watchpoint_insert(CPU(cpu), wvr, len,
+                                                   flags, n);
 }
 
 void hw_watchpoint_update_all(ARMCPU *cpu)
diff --git a/target/i386/tcg/system/bpt_helper.c b/target/i386/tcg/system/bpt_helper.c
index 23f2d05126..c0c63e3e89 100644
--- a/target/i386/tcg/system/bpt_helper.c
+++ b/target/i386/tcg/system/bpt_helper.c
@@ -57,7 +57,6 @@ static int hw_breakpoint_insert(CPUX86State *env, int index)
     CPUState *cs = env_cpu(env);
     target_ulong dr7 = env->dr[7];
     target_ulong drN = env->dr[index];
-    int err = 0;
 
     switch (hw_breakpoint_type(dr7, index)) {
     case DR7_TYPE_BP_INST:
@@ -73,25 +72,22 @@ static int hw_breakpoint_insert(CPUX86State *env, int index)
 
     case DR7_TYPE_DATA_WR:
         if (hw_breakpoint_enabled(dr7, index)) {
-            err = cpu_watchpoint_insert(cs, drN,
-                                        hw_breakpoint_len(dr7, index),
-                                        BP_CPU | BP_MEM_WRITE, index,
-                                        &env->cpu_watchpoint[index]);
+            env->cpu_watchpoint[index] =
+                cpu_watchpoint_insert(cs, drN,
+                                      hw_breakpoint_len(dr7, index),
+                                      BP_CPU | BP_MEM_WRITE, index);
         }
         break;
 
     case DR7_TYPE_DATA_RW:
         if (hw_breakpoint_enabled(dr7, index)) {
-            err = cpu_watchpoint_insert(cs, drN,
-                                        hw_breakpoint_len(dr7, index),
-                                        BP_CPU | BP_MEM_ACCESS, index,
-                                        &env->cpu_watchpoint[index]);
+            env->cpu_watchpoint[index] =
+                cpu_watchpoint_insert(cs, drN,
+                                      hw_breakpoint_len(dr7, index),
+                                      BP_CPU | BP_MEM_ACCESS, index);
         }
         break;
     }
-    if (err) {
-        env->cpu_breakpoint[index] = NULL;
-    }
     return 0;
 }
 
diff --git a/target/ppc/cpu.c b/target/ppc/cpu.c
index a25c8ae2f1..fbd199c08d 100644
--- a/target/ppc/cpu.c
+++ b/target/ppc/cpu.c
@@ -171,8 +171,8 @@ void ppc_update_daw(CPUPPCState *env, int rid)
         flags |= BP_MEM_WRITE;
     }
 
-    cpu_watchpoint_insert(cs, deaw, len, flags, rid,
-                          &env->dawr_watchpoint[rid]);
+    env->dawr_watchpoint[rid] =
+        cpu_watchpoint_insert(cs, deaw, len, flags, rid);
 }
 
 void ppc_store_dawr0(CPUPPCState *env, target_ulong val)
diff --git a/target/riscv/debug.c b/target/riscv/debug.c
index d6bba24c81..6777f1a905 100644
--- a/target/riscv/debug.c
+++ b/target/riscv/debug.c
@@ -481,7 +481,6 @@ static void type2_breakpoint_insert(CPURISCVState *env, target_ulong index)
     bool enabled = type2_breakpoint_enabled(ctrl);
     CPUState *cs = env_cpu(env);
     BreakpointFlags flags = BP_CPU | BP_STOP_BEFORE_ACCESS;
-    uint32_t size, def_size;
 
     if (!enabled) {
         return;
@@ -499,16 +498,12 @@ static void type2_breakpoint_insert(CPURISCVState *env, target_ulong index)
     }
 
     if (flags & BP_MEM_ACCESS) {
-        size = type2_breakpoint_size(env, ctrl);
-        if (size != 0) {
-            cpu_watchpoint_insert(cs, addr, size, flags, index,
-                                  &env->cpu_watchpoint[index]);
-        } else {
-            def_size = riscv_cpu_mxl(env) == MXL_RV64 ? 8 : 4;
-
-            cpu_watchpoint_insert(cs, addr, def_size, flags, index,
-                                  &env->cpu_watchpoint[index]);
+        uint32_t size = type2_breakpoint_size(env, ctrl);
+        if (size == 0) {
+            size = riscv_cpu_mxl(env) == MXL_RV64 ? 8 : 4;
         }
+        env->cpu_watchpoint[index] =
+            cpu_watchpoint_insert(cs, addr, size, flags, index);
     }
 }
 
@@ -606,7 +601,6 @@ static void type6_breakpoint_insert(CPURISCVState *env, target_ulong index)
     bool enabled = type6_breakpoint_enabled(ctrl);
     CPUState *cs = env_cpu(env);
     BreakpointFlags flags = BP_CPU | BP_STOP_BEFORE_ACCESS;
-    uint32_t size;
 
     if (!enabled) {
         return;
@@ -625,14 +619,10 @@ static void type6_breakpoint_insert(CPURISCVState *env, target_ulong index)
     }
 
     if (flags & BP_MEM_ACCESS) {
-        size = extract32(ctrl, 16, 4);
-        if (size != 0) {
-            cpu_watchpoint_insert(cs, addr, size, flags, index,
-                                  &env->cpu_watchpoint[index]);
-        } else {
-            cpu_watchpoint_insert(cs, addr, 8, flags, index,
-                                  &env->cpu_watchpoint[index]);
-        }
+        uint32_t size = extract32(ctrl, 16, 4) ? : 8;
+
+        env->cpu_watchpoint[index] =
+            cpu_watchpoint_insert(cs, addr, size, flags, index);
     }
 }
 
diff --git a/target/s390x/tcg/debug.c b/target/s390x/tcg/debug.c
index 25968d9a3c..bd30b85ada 100644
--- a/target/s390x/tcg/debug.c
+++ b/target/s390x/tcg/debug.c
@@ -34,18 +34,18 @@ void s390_cpu_recompute_watchpoints(CPUState *cs)
     if (env->cregs[10] == 0 && env->cregs[11] == -1LL) {
         /* We can't create a watchoint spanning the whole memory range, so
            split it in two parts.   */
-        cpu_watchpoint_insert(cs, 0, 1ULL << 63, wp_flags, 0, NULL);
-        cpu_watchpoint_insert(cs, 1ULL << 63, 1ULL << 63, wp_flags, 0, NULL);
+        cpu_watchpoint_insert(cs, 0, 1ULL << 63, wp_flags, 0);
+        cpu_watchpoint_insert(cs, 1ULL << 63, 1ULL << 63, wp_flags, 0);
     } else if (env->cregs[10] > env->cregs[11]) {
         /* The address range loops, create two watchpoints.  */
         cpu_watchpoint_insert(cs, env->cregs[10], -env->cregs[10],
-                              wp_flags, 0, NULL);
-        cpu_watchpoint_insert(cs, 0, env->cregs[11] + 1, wp_flags, 0, NULL);
+                              wp_flags, 0);
+        cpu_watchpoint_insert(cs, 0, env->cregs[11] + 1, wp_flags, 0);
     } else {
         /* Default case, create a single watchpoint.  */
         cpu_watchpoint_insert(cs, env->cregs[10],
                               env->cregs[11] - env->cregs[10] + 1,
-                              wp_flags, 0, NULL);
+                              wp_flags, 0);
     }
 }
 
diff --git a/target/xtensa/dbg_helper.c b/target/xtensa/dbg_helper.c
index 9df0c519b3..ae3791ac23 100644
--- a/target/xtensa/dbg_helper.c
+++ b/target/xtensa/dbg_helper.c
@@ -97,13 +97,9 @@ static void set_dbreak(CPUXtensaState *env, unsigned i, uint32_t dbreaka,
         /* cut mask after the first zero bit */
         mask = 0xffffffff << (32 - clo32(mask));
     }
-    if (cpu_watchpoint_insert(cs, dbreaka & mask, ~mask + 1,
-                              flags, i, &env->cpu_watchpoint[i])) {
-        env->cpu_watchpoint[i] = NULL;
-        qemu_log_mask(LOG_GUEST_ERROR,
-                      "Failed to set data breakpoint at 0x%08x/%d\n",
-                      dbreaka & mask, ~mask + 1);
-    }
+
+    env->cpu_watchpoint[i] =
+        cpu_watchpoint_insert(cs, dbreaka & mask, ~mask + 1, flags, i);
 }
 
 void HELPER(wsr_dbreaka)(CPUXtensaState *env, uint32_t i, uint32_t v)
-- 
2.43.0


