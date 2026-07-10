Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A765EC44506
	for <qemu-devel@archiver.kernel.org>; Fri, 10 Jul 2026 21:01:22 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wiIKa-0004Ur-4m; Fri, 10 Jul 2026 17:00:29 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wiIIX-0000zJ-Ev
 for qemu-devel@nongnu.org; Fri, 10 Jul 2026 16:58:20 -0400
Received: from mail-pj1-x102b.google.com ([2607:f8b0:4864:20::102b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wiIIF-0001zm-JP
 for qemu-devel@nongnu.org; Fri, 10 Jul 2026 16:58:10 -0400
Received: by mail-pj1-x102b.google.com with SMTP id
 98e67ed59e1d1-380cda7f00cso1358436a91.0
 for <qemu-devel@nongnu.org>; Fri, 10 Jul 2026 13:57:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1783717074; x=1784321874; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=SJXo9dmPwlA/s00enjuVhcLjfiAYT7fqyYmVJu+OMt4=;
 b=K5rpq/B7qOozw+3LyARG7aVdg+i++z8drWKqrOnusvtfXBksMvnX4qRuCP+3M3ziHQ
 GpyCYF5ph08IF0YkwSCkdf/d6XYVE9nzyCZ+sS5hsPLkA79lGIZY/B7kPDgLG/MKmtxR
 sMCy6XBr/mtc2giDA8VdmpyQ5ie7L9SplNP5nF0ruqBu/jEQjKTxcLNtrNtQK5icf7KH
 Y88/dKMSbVuXkQzjvynJZOLaQQMmoQashCxAWMx2R3ozCF/riOk+zhc/+NTrLQBqRQk5
 OPom8YWCg3McWSLo56uu0tjLikPd+ilNijuBvNC5ISrxab681OaExrw2u6C0sCWn1AnF
 O+6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1783717074; x=1784321874;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=SJXo9dmPwlA/s00enjuVhcLjfiAYT7fqyYmVJu+OMt4=;
 b=dpi/iO/YHbOFN9GErCOaTTGL9B5iobsn1GfzJGwFx/gRMrK6L3dnzSL6fSfSf4uksw
 ICOcJRTVjbALQflCtibFQKnE0qCHdNuHnOkSKuN0uYgYKBWobPDhwfj/ws2RJLGclpgu
 J//z/yvW1S2BYsZqWYKp5hBLWruCXb3q/Lh8TYBw5E96FXEaqmrdu3hKRFXDdKvcJOuh
 2LM0uQcOo+MFC794msElo+G0kgzNDw6tHq7nQXWPO6h4XT7YUwBjvCE7+uTh0QirTXSb
 xzx5DfGlv9cr+OyBn6xftNs0MTaG7RzdvrTlMju0ydYXewagdSrXclzYcdYh3GRzsHNA
 lQyQ==
X-Gm-Message-State: AOJu0YwvmgYos9A0mUcWvENg0ydWjTtZrrp8tPiFxx+AN0wPHL0Uxfcm
 ScA1bqoAKv0SxHRdvv3xfA3PeEa2Q12NFa4b1qMQgzTWuw2wPjiu16+2VRwcUQiukN1aqlJf9Uo
 6EiVr
X-Gm-Gg: AfdE7clb4ECOk2cGtGl4hQ4DD1+XU1hLLS0GAk7LDFiNM1+y/7kC1M5qHQM0qBY6I8T
 wss4uaVrIo4q+Tin1GjGS34ME1aQ1WQQSlHA3ES58o7jm5K3IhhdV7wbOMnajVMiGJ9BVR3831F
 uYbd25MMA0LWXXzCIOZ0aeZt94Fqnej9TxlEiNaLJN9yVm2zc2xL3BP3rDj25OvEoea5feD+QCS
 pmkyt71eYhzuNdnnHtpWb/URsTv6UFAF6SsXurKle7gROV4dYlShVcFrZvUUaBUYTAiNpft9lWJ
 hLZJ7aUJnkeAY44XF5hnJXfI8DmNZZkbQpvvUe6+S5pMTGjrY5/T2F9ezxYBPTPEA+FUhoI7KGn
 IL1tklzSan0F6+2VWJr0XmnKmxElQTKToLYTH2g1G6+p4zkrPzyDtgFEzHj/+Zkue8TSsHqYghl
 CQQVPE1Ag8DXcuhDIqPw==
X-Received: by 2002:a17:90b:2d08:b0:37f:9cdf:f03e with SMTP id
 98e67ed59e1d1-38dc7b967b8mr427558a91.33.1783717073751; 
 Fri, 10 Jul 2026 13:57:53 -0700 (PDT)
Received: from stoup.. ([71.212.146.49]) by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-38a58792cdasm3256221a91.16.2026.07.10.13.57.53
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 10 Jul 2026 13:57:53 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org, qemu-ppc@nongnu.org, qemu-riscv@nongnu.org,
 qemu-s390x@nongnu.org, jcmvbkbc@gmail.com
Subject: [PATCH v3 51/51] accel/tcg: Change cpu_watchpoint_insert to use
 addr/last
Date: Fri, 10 Jul 2026 13:54:01 -0700
Message-ID: <20260710205401.836304-52-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260710205401.836304-1-richard.henderson@linaro.org>
References: <20260710205401.836304-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::102b;
 envelope-from=richard.henderson@linaro.org; helo=mail-pj1-x102b.google.com
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

Plugs a hole in the API by which one cannot watch the entire
address space with one range.  Eliminates a workaround in
s390x where we used 2 watchpoints for exactly that.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 include/exec/breakpoint.h           |  2 +-
 accel/tcg/tcg-accel-ops.c           |  7 +++++--
 accel/tcg/user-exec-stub.c          |  2 +-
 system/watchpoint.c                 |  4 +---
 target/arm/tcg/debug.c              | 10 +++++-----
 target/i386/tcg/system/bpt_helper.c |  4 ++--
 target/ppc/cpu.c                    |  2 +-
 target/riscv/debug.c                |  4 ++--
 target/s390x/tcg/debug.c            | 16 ++++------------
 9 files changed, 22 insertions(+), 29 deletions(-)

diff --git a/include/exec/breakpoint.h b/include/exec/breakpoint.h
index e9b77081e7..79a1453a45 100644
--- a/include/exec/breakpoint.h
+++ b/include/exec/breakpoint.h
@@ -44,7 +44,7 @@ void cpu_breakpoint_remove_by_ref(CPUState *cpu, CPUBreakpoint *breakpoint);
 void cpu_breakpoint_remove_all(CPUState *cpu, BreakpointFlags mask);
 bool cpu_breakpoint_test(CPUState *cpu, vaddr pc, BreakpointFlags mask);
 
-CPUBreakpoint *cpu_watchpoint_insert(CPUState *cpu, vaddr addr, vaddr len,
+CPUBreakpoint *cpu_watchpoint_insert(CPUState *cpu, vaddr first, vaddr last,
                                      BreakpointFlags flags, unsigned id);
 int cpu_watchpoint_remove(CPUState *cpu, vaddr addr,
                           vaddr len, BreakpointFlags flags);
diff --git a/accel/tcg/tcg-accel-ops.c b/accel/tcg/tcg-accel-ops.c
index 79289bf7b2..fd14459f7d 100644
--- a/accel/tcg/tcg-accel-ops.c
+++ b/accel/tcg/tcg-accel-ops.c
@@ -131,6 +131,7 @@ static int tcg_insert_gdbstub_breakpoint(CPUState *cs, GdbBreakpointType type,
                                          vaddr addr, vaddr len)
 {
     CPUState *cpu;
+    vaddr last;
 
     switch (type) {
     case GDB_BREAKPOINT_SW:
@@ -142,11 +143,13 @@ static int tcg_insert_gdbstub_breakpoint(CPUState *cs, GdbBreakpointType type,
     case GDB_WATCHPOINT_WRITE:
     case GDB_WATCHPOINT_READ:
     case GDB_WATCHPOINT_ACCESS:
-        if (len == 0 || addr + (len - 1) < addr) {
+        last = addr + (len - 1);
+        if (len == 0 || last < addr) {
             return -EINVAL;
         }
         CPU_FOREACH(cpu) {
-            cpu_watchpoint_insert(cpu, addr, len, xlat_gdb_type(cpu, type), 0);
+            cpu_watchpoint_insert(cpu, addr, last,
+                                  xlat_gdb_type(cpu, type), 0);
         }
         return 0;
     default:
diff --git a/accel/tcg/user-exec-stub.c b/accel/tcg/user-exec-stub.c
index c45e31e2fa..a989aeaa60 100644
--- a/accel/tcg/user-exec-stub.c
+++ b/accel/tcg/user-exec-stub.c
@@ -21,7 +21,7 @@ void cpu_exec_reset_hold(CPUState *cpu)
 {
 }
 
-CPUBreakpoint *cpu_watchpoint_insert(CPUState *cpu, vaddr addr, vaddr len,
+CPUBreakpoint *cpu_watchpoint_insert(CPUState *cpu, vaddr addr, vaddr last,
                                      BreakpointFlags flags, unsigned id)
 {
     g_assert_not_reached();
diff --git a/system/watchpoint.c b/system/watchpoint.c
index fe7e0ac59f..cb9f41269c 100644
--- a/system/watchpoint.c
+++ b/system/watchpoint.c
@@ -24,13 +24,11 @@
 #include "hw/core/cpu.h"
 
 /* Add a watchpoint.  */
-CPUBreakpoint *cpu_watchpoint_insert(CPUState *cpu, vaddr addr, vaddr len,
+CPUBreakpoint *cpu_watchpoint_insert(CPUState *cpu, vaddr addr, vaddr last,
                                      BreakpointFlags flags, unsigned id)
 {
     CPUBreakpoint *wp;
-    vaddr last = addr + len - 1;
 
-    assert(len != 0);
     assert(last >= addr);
     assert(flags & BP_MEM_ACCESS);
     assert(ctpop32(flags & BP_ANY) == 1);
diff --git a/target/arm/tcg/debug.c b/target/arm/tcg/debug.c
index 1dec39c0bf..b3e7df7876 100644
--- a/target/arm/tcg/debug.c
+++ b/target/arm/tcg/debug.c
@@ -524,7 +524,7 @@ static void hw_watchpoint_update_v6(ARMCPU *cpu, int n, BreakpointFlags flags)
      * of the BAS bits until breakpoint hit.
      */
     CPUARMState *env = &cpu->env;
-    uint32_t wvr = env->cp15.dbgwvr[n] & ~3;
+    uint32_t wvr = env->cp15.dbgwvr[n];
     uint32_t wcr = env->cp15.dbgwcr[n];
     uint32_t bas = FIELD_EX64(wcr, DBGWCR, BAS) & 0xf;
 
@@ -533,8 +533,8 @@ static void hw_watchpoint_update_v6(ARMCPU *cpu, int n, BreakpointFlags flags)
         return;
     }
 
-    env->cpu_watchpoint[n] = cpu_watchpoint_insert(CPU(cpu), wvr, 4,
-                                                   flags, n);
+    env->cpu_watchpoint[n] =
+        cpu_watchpoint_insert(CPU(cpu), wvr & ~3, wvr | 3, flags, n);
 }
 
 static void hw_watchpoint_update_v7(ARMCPU *cpu, int n, BreakpointFlags flags)
@@ -595,8 +595,8 @@ static void hw_watchpoint_update_v7(ARMCPU *cpu, int n, BreakpointFlags flags)
         wvr += basstart;
     }
 
-    env->cpu_watchpoint[n] = cpu_watchpoint_insert(CPU(cpu), wvr, len,
-                                                   flags, n);
+    env->cpu_watchpoint[n] =
+        cpu_watchpoint_insert(CPU(cpu), wvr, wvr + len - 1, flags, n);
 }
 
 void hw_watchpoint_update(ARMCPU *cpu, int n)
diff --git a/target/i386/tcg/system/bpt_helper.c b/target/i386/tcg/system/bpt_helper.c
index 86562fc946..3307b2f52e 100644
--- a/target/i386/tcg/system/bpt_helper.c
+++ b/target/i386/tcg/system/bpt_helper.c
@@ -74,7 +74,7 @@ static int hw_breakpoint_insert(CPUX86State *env, int index)
         if (hw_breakpoint_enabled(dr7, index)) {
             env->cpu_watchpoint[index] =
                 cpu_watchpoint_insert(cs, drN,
-                                      hw_breakpoint_len(dr7, index),
+                                      drN + hw_breakpoint_len(dr7, index) - 1,
                                       BP_CPU | BP_MEM_WRITE, index);
         }
         break;
@@ -83,7 +83,7 @@ static int hw_breakpoint_insert(CPUX86State *env, int index)
         if (hw_breakpoint_enabled(dr7, index)) {
             env->cpu_watchpoint[index] =
                 cpu_watchpoint_insert(cs, drN,
-                                      hw_breakpoint_len(dr7, index),
+                                      drN + hw_breakpoint_len(dr7, index) - 1,
                                       BP_CPU | BP_MEM_ACCESS, index);
         }
         break;
diff --git a/target/ppc/cpu.c b/target/ppc/cpu.c
index fbd199c08d..f153d2fece 100644
--- a/target/ppc/cpu.c
+++ b/target/ppc/cpu.c
@@ -172,7 +172,7 @@ void ppc_update_daw(CPUPPCState *env, int rid)
     }
 
     env->dawr_watchpoint[rid] =
-        cpu_watchpoint_insert(cs, deaw, len, flags, rid);
+        cpu_watchpoint_insert(cs, deaw, deaw + len - 1, flags, rid);
 }
 
 void ppc_store_dawr0(CPUPPCState *env, target_ulong val)
diff --git a/target/riscv/debug.c b/target/riscv/debug.c
index 803418f390..0995ad157c 100644
--- a/target/riscv/debug.c
+++ b/target/riscv/debug.c
@@ -503,7 +503,7 @@ static void type2_breakpoint_insert(CPURISCVState *env, target_ulong index)
             size = riscv_cpu_mxl(env) == MXL_RV64 ? 8 : 4;
         }
         env->cpu_watchpoint[index] =
-            cpu_watchpoint_insert(cs, addr, size, flags, index);
+            cpu_watchpoint_insert(cs, addr, addr + size - 1, flags, index);
     }
 }
 
@@ -622,7 +622,7 @@ static void type6_breakpoint_insert(CPURISCVState *env, target_ulong index)
         uint32_t size = extract32(ctrl, 16, 4) ? : 8;
 
         env->cpu_watchpoint[index] =
-            cpu_watchpoint_insert(cs, addr, size, flags, index);
+            cpu_watchpoint_insert(cs, addr, addr + size - 1, flags, index);
     }
 }
 
diff --git a/target/s390x/tcg/debug.c b/target/s390x/tcg/debug.c
index ef0d953e01..22f75fd3a5 100644
--- a/target/s390x/tcg/debug.c
+++ b/target/s390x/tcg/debug.c
@@ -31,21 +31,13 @@ void s390_cpu_recompute_watchpoints(CPUState *cs)
         return;
     }
 
-    if (env->cregs[10] == 0 && env->cregs[11] == -1LL) {
-        /* We can't create a watchoint spanning the whole memory range, so
-           split it in two parts.   */
-        cpu_watchpoint_insert(cs, 0, 1ULL << 63, wp_flags, 0);
-        cpu_watchpoint_insert(cs, 1ULL << 63, 1ULL << 63, wp_flags, 0);
-    } else if (env->cregs[10] > env->cregs[11]) {
+    if (env->cregs[10] > env->cregs[11]) {
         /* The address range loops, create two watchpoints.  */
-        cpu_watchpoint_insert(cs, env->cregs[10], -env->cregs[10],
-                              wp_flags, 0);
-        cpu_watchpoint_insert(cs, 0, env->cregs[11] + 1, wp_flags, 0);
+        cpu_watchpoint_insert(cs, env->cregs[10], -1, wp_flags, 0);
+        cpu_watchpoint_insert(cs, 0, env->cregs[11], wp_flags, 0);
     } else {
         /* Default case, create a single watchpoint.  */
-        cpu_watchpoint_insert(cs, env->cregs[10],
-                              env->cregs[11] - env->cregs[10] + 1,
-                              wp_flags, 0);
+        cpu_watchpoint_insert(cs, env->cregs[10], env->cregs[11], wp_flags, 0);
     }
 }
 
-- 
2.43.0


