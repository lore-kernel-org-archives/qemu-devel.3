Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 61B15C982C1
	for <qemu-devel@archiver.kernel.org>; Thu, 17 Sep 2026 08:27:21 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x77S3-0001z1-3J; Thu, 17 Sep 2026 04:26:40 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1x77Rt-0001y4-In
 for qemu-devel@nongnu.org; Thu, 17 Sep 2026 04:26:29 -0400
Received: from mail-pj2-x0f.google.com ([2607:f8b0:4864:39::f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1x77Rp-0002vp-MY
 for qemu-devel@nongnu.org; Thu, 17 Sep 2026 04:26:29 -0400
Received: by mail-pj2-x0f.google.com with SMTP id
 d9443c01a7336-2dd88a115c1so5864285ad.3
 for <qemu-devel@nongnu.org>; Thu, 17 Sep 2026 01:26:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1789633583; x=1790238383; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=gPX5EBK1/0IuVMAfMbD5bOc3n7+JoD6VEvdWx9oeki0=;
 b=Ekirf1NKzzHbkJLXQ4km2ZzeyYGXWsfWws1QSX7kWNvjJ7/GLtpVVmRRNVXWT0O67v
 1nbFUbJlLpwmX0FbM9yk/YccnYXIvUytwgufKezuc3U3bdCRR178oKsaLljbK4SxJNr7
 ApMmpX8ZGaV4n1uVJW+fIl59tjE8+mrieb3zeeJJI8ZOyydRgrMCDCwzk7ArGSZDnB3h
 S4YvH7HURj2UBdd+YqgpQNn/haROlbBe9dy43kXwRB7fgW2+WxynBFIMeiPfjtHU1/IP
 wAKQz3MfxUMzzVP/Vqmo7eoJM9ssI1wFwqapE7ArsUDaaa/1BWNLURTsxUezzgrQ/tfo
 EObA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1789633583; x=1790238383;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=gPX5EBK1/0IuVMAfMbD5bOc3n7+JoD6VEvdWx9oeki0=;
 b=RSMCeBuzc4bLwxqciu9swHM2FVsu16HTay7U5Q5h0Pjr9ysm9hKo2dsGJ1WVyLUcRE
 +/cPDllnCweV5iD2diFWt7QCqCzVGiRLNaWXYl39Tlc0BFmqdOQyd5uyHhkiv2dPrQMu
 pRIn031XYloPN/fK9EHt/DXFTkFDD4aLUIBftZ2HlBqmGt0ia9hDL1M9584JZW4kMrrJ
 VASBSLNXBUwVizMqtOm3rcx8ZnsgPtAtiD6qQZpGJWLT/hDPI1rKZy/owmbKZcHVJ0OQ
 56uszotF6XfywcKjFLzgIraDOuljTyaTlV8bdIgFfORmMUXxyrToqhK/EQrndvImRu3s
 ykfA==
X-Gm-Message-State: AFuF++kLEFWonfRRHnZrNjwrB/2eK5rvdYaietyn5V1rQ3f7BpJtFbD6
 4WQSdRdSYp8+umhG4lH05KwHvz1/3/fFrlxYMvWbwKr/riCxGj7N5pJ5if1IamNafBGl9GYYwgk
 LqugdZ5s=
X-Gm-Gg: AYBFou0tc9Vx0ok/tNYZ+oeQp5ogoNysQkdZnFPodJ2qDf35hhkR29EC2T1Apgukb5B
 dIhjKQlN6yqeOu14qeXcTJhHB/pgd2orbGK34PujEYpPA7WtfY9dDf3kFXu1vyChMXdcrzWJ2AJ
 424HqQ/JUJnDSowm8U72v27GOjrPKjUUcpUEYgsyixHDbjVniI+crrQ9g7nVkZ1R4Qtes6WbbNw
 ur8r/lPrZhqYWQWS0vLR4OPyYO/WVf1tlGqFWapdTIdcgUzsqZDpowpFNym1iOk8IPWGEzUc6c5
 xcobrA2J9wm74kpNw3sSpf9TFi6gLcAqDDcZpGuYEVPmpCOS9NHsjVJ0JchnkF4VcUQY6InMutJ
 SKgZRjOgiMijo9lIAwAOUCkJqOE4J8ZumAhBTndwV22usHNQV0FoDqtK87fkzYuhDTn89twR/0i
 CBbKaQECjiyEcn1Zca5sKpqOn05HswhiaLnG5HcXQ5DK6CGV38Dxa+c5FAdzGInSr9Gvbq1Cc1/
 sJMpVc=
X-Received: by 2002:a17:90b:390d:b0:39d:f66e:1720 with SMTP id
 98e67ed59e1d1-39e1e4907e8mr18568364a91.13.1789633583124; 
 Thu, 17 Sep 2026 01:26:23 -0700 (PDT)
Received: from stoup ([2603:800c:7900:ed00:325f:1938:d075:8c13])
 by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-33bf5ac978esm13484357eec.18.2026.09.17.01.26.22
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 17 Sep 2026 01:26:22 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: mattst88@gmail.com
Subject: [PATCH v6 2/2] accel/tcg: fold the dynamic cflags into
 CPUState::tcg_cflags
Date: Wed, 16 Sep 2026 22:26:18 -1000
Message-ID: <20260917082618.1076988-3-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260917082618.1076988-1-richard.henderson@linaro.org>
References: <20260917082618.1076988-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:39::f;
 envelope-from=richard.henderson@linaro.org; helo=mail-pj2-x0f.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_NONE=0.001,
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

From: Matt Turner <mattst88@gmail.com>

curr_cflags() is called once per TB dispatch, from helper_lookup_tb_ptr()
and from the cpu_exec() loop. It recomputes the same value every time:

    uint32_t cflags = cpu->tcg_cflags;
    if (unlikely(cpu_single_stepping(cpu))) { ... }
    else if (qatomic_read(&one_insn_per_tb)) { ... }
    else if (qemu_loglevel_mask(CPU_LOG_TB_NOCHAIN)) { ... }

That is three loads and three branches on the hottest path in the
interpreter, for state that changes only when gdb enables single-step,
when one-insn-per-tb is toggled, or when the log mask changes.

None of the three has to be sampled at dispatch time. Fold each into
CPUState::tcg_cflags where it changes and curr_cflags() becomes a single
load of a field that TB lookup has to read anyway.

The derived bits -- CF_COUNT_MASK, CF_NO_GOTO_TB, CF_NO_GOTO_PTR and
CF_SINGLE_STEP -- are never set by tcg_cflags_set(), so tcg_update_cflags()
can recompute them in place without disturbing the rest, and conversely
tcg_cflags_set() ORs in its bits without disturbing them.

There are three places to call it:

  - tcg_exec_realizefn(), so that a CPU created after the command line has
    been parsed starts out with the right value. This covers user-only,
    where tcg_cpu_init_cflags() is not reached. linux-user's cpu_copy()
    copies tcg_cflags wholesale, so a cloned thread inherits it.

  - cpu_single_step(), which changes one CPU.  gdb is the only caller that
    matters; in system mode it runs with the vCPUs stopped, and in user mode
    gdb_continue_partial() can reach a thread that is still running, because
    gdb_handlesig() stops only the thread that trapped. That is exactly the
    plain cross-thread store to another CPU's CPUState that
    cpu->singlestep_flags already was, read back by that CPU through
    cpu_single_stepping() in curr_cflags(). This patch changes which field
    carries it, not who writes it or how.

  - hmp_one_insn_per_tb() and hmp_log(), which change every CPU while the
    vCPUs are running, so the update is queued with async_run_on_cpu() and
    each CPU writes its own cflags from its own thread. The command line
    spellings of those two settings need nothing: they are parsed before
    any CPU is realized, so tcg_exec_realizefn() picks them up.

Measured with qemu-alpha running an emulated alpha gcc 16.2.0 compiling
the SQLite 3.45.1 amalgamation (255k lines, -O2) on an x86-64 host, in a
build configured with --enable-lto:

    before: 1,646,994,254,249 instructions
    after:  1,562,204,796,597 instructions   -5.15%

That workload issues 8.4 billion dispatches, so the per-call saving is
small but the aggregate is not. The emulated compiler produces
byte-identical output before and after.

Wall clock does not move: 133.19s to 132.58s, a 0.46% difference against a
run-to-run spread larger than that. The removed work is a few predictable
loads and branches that the host executes largely in parallel with the
surrounding dispatch, so this patch is worth taking for the instruction
count and for what it enables, not for a time saving that can be measured
on its own.

v4: Update the cflags from the HMP handlers for 'log' and 'one-insn-per-tb'
    rather than from qemu_set_log_internal() and the accelerator property
    setter. Those are the paths that reach a running vCPU, and the monitor
    is the only thing that does. Suggested by Richard Henderson.

v4: Queue the per-CPU update with async_run_on_cpu() rather than
    async_safe_run_on_cpu(). Halting the other vCPUs buys nothing: the
    queued work already runs on the owning CPU's own thread. Suggested by
    Alex Bennee, who also asked whether there are cross-vCPU updates of
    tcg_cflags at all. With this change the monitor path has none: the
    only remaining writer from another thread is cpu_single_step(), above,
    which is neither new nor made worse here.

v4: Move the stub to accel/stubs/, which is where the other accelerator
    stubs live.

Signed-off-by: Matt Turner <mattst88@gmail.com>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <20260901034808.3524945-2-mattst88@gmail.com>
---
 accel/tcg/internal-common.h | 11 +++++++++--
 include/system/tcg.h        | 12 ++++++++++++
 accel/tcg/cpu-exec-common.c | 33 ++++++++++++++++++++++++++++++---
 accel/tcg/cpu-exec.c        |  3 +++
 accel/tcg/tcg-accel-ops.c   |  2 ++
 cpu-target.c                |  5 ++++-
 monitor/hmp-cmds.c          |  7 +++++++
 system/runstate-hmp-cmds.c  | 18 ++++++++++++------
 8 files changed, 79 insertions(+), 12 deletions(-)

diff --git a/accel/tcg/internal-common.h b/accel/tcg/internal-common.h
index 9e7be2d78df..853d1b51eeb 100644
--- a/accel/tcg/internal-common.h
+++ b/accel/tcg/internal-common.h
@@ -69,8 +69,15 @@ void tlb_destroy(CPUState *cpu);
 bool tcg_exec_realizefn(CPUState *cpu, Error **errp);
 void tcg_exec_unrealizefn(CPUState *cpu);
 
-/* current cflags for hashing/comparison */
-uint32_t curr_cflags(CPUState *cpu);
+/*
+ * Current cflags for hashing/comparison.  Everything that feeds into the
+ * value is folded into CPUState::tcg_cflags when it changes, by
+ * tcg_update_cflags(), so that TB dispatch only has to load it.
+ */
+static inline uint32_t curr_cflags(CPUState *cpu)
+{
+    return cpu->tcg_cflags;
+}
 
 void tb_check_watchpoint(CPUState *cpu, uintptr_t retaddr);
 
diff --git a/include/system/tcg.h b/include/system/tcg.h
index 7622dcea302..2c2dbc753b3 100644
--- a/include/system/tcg.h
+++ b/include/system/tcg.h
@@ -17,6 +17,18 @@ extern bool tcg_allowed;
 #define tcg_enabled() 0
 #endif
 
+/*
+ * Recompute the parts of CPUState::tcg_cflags that TB dispatch consumes but
+ * tcg_cflags_set() does not provide: gdb single-step, one-insn-per-tb and
+ * the CPU_LOG_TB_NOCHAIN log flag.  Call whenever one of those changes.
+ *
+ * tcg_update_cflags() updates one CPU and must be called from that CPU's
+ * thread, or with it stopped.  tcg_update_all_cflags() updates every CPU
+ * and is safe to call from the monitor while the vCPUs run.
+ */
+void tcg_update_cflags(CPUState *cpu);
+void tcg_update_all_cflags(void);
+
 /**
  * qemu_tcg_mttcg_enabled:
  * Check whether we are running MultiThread TCG or not.
diff --git a/accel/tcg/cpu-exec-common.c b/accel/tcg/cpu-exec-common.c
index 44e84344f3b..9f3517f36b6 100644
--- a/accel/tcg/cpu-exec-common.c
+++ b/accel/tcg/cpu-exec-common.c
@@ -36,9 +36,16 @@ void tcg_cflags_set(CPUState *cpu, uint32_t flags)
     cpu->tcg_cflags |= flags;
 }
 
-uint32_t curr_cflags(CPUState *cpu)
+/*
+ * The bits of CPUState::tcg_cflags that tcg_cflags_set() never sets, because
+ * they are derived from gdb single-step, one-insn-per-tb and -d nochain.
+ */
+#define CF_DERIVED  (CF_COUNT_MASK | CF_NO_GOTO_TB | CF_NO_GOTO_PTR | \
+                     CF_SINGLE_STEP)
+
+void tcg_update_cflags(CPUState *cpu)
 {
-    uint32_t cflags = cpu->tcg_cflags;
+    uint32_t cflags = cpu->tcg_cflags & ~CF_DERIVED;
 
     /*
      * Record gdb single-step.  We should be exiting the TB by raising
@@ -55,7 +62,27 @@ uint32_t curr_cflags(CPUState *cpu)
         cflags |= CF_NO_GOTO_TB;
     }
 
-    return cflags;
+    cpu->tcg_cflags = cflags;
+}
+
+static void tcg_update_cflags_work(CPUState *cpu, run_on_cpu_data data)
+{
+    tcg_update_cflags(cpu);
+}
+
+void tcg_update_all_cflags(void)
+{
+    CPUState *cpu;
+
+    /*
+     * one-insn-per-tb and -d nochain can both be changed from the monitor
+     * while the vCPUs are running.  Queue the update onto each CPU rather
+     * than writing tcg_cflags from here, so that the field is only ever
+     * written by the CPU that owns it.
+     */
+    CPU_FOREACH(cpu) {
+        async_run_on_cpu(cpu, tcg_update_cflags_work, RUN_ON_CPU_NULL);
+    }
 }
 
 /* exit the current TB, but without causing any exception to be raised */
diff --git a/accel/tcg/cpu-exec.c b/accel/tcg/cpu-exec.c
index 46b723cb734..5226cfb7650 100644
--- a/accel/tcg/cpu-exec.c
+++ b/accel/tcg/cpu-exec.c
@@ -1071,6 +1071,9 @@ bool tcg_exec_realizefn(CPUState *cpu, Error **errp)
         tcg_target_initialized = true;
     }
 
+    /* Pick up one-insn-per-tb and -d nochain from the command line. */
+    tcg_update_cflags(cpu);
+
     cpu->tb_jmp_cache = g_new0(CPUJumpCache, 1);
     tlb_init(cpu);
 #ifndef CONFIG_USER_ONLY
diff --git a/accel/tcg/tcg-accel-ops.c b/accel/tcg/tcg-accel-ops.c
index 9c3d2214162..2e50df20c18 100644
--- a/accel/tcg/tcg-accel-ops.c
+++ b/accel/tcg/tcg-accel-ops.c
@@ -48,6 +48,7 @@
 #include "tcg-accel-ops-mttcg.h"
 #include "tcg-accel-ops-rr.h"
 #include "tcg-accel-ops-icount.h"
+#include "internal-common.h"
 
 /* common functionality among all TCG variants */
 
@@ -222,6 +223,7 @@ static void tcg_accel_ops_init(AccelClass *ac)
     ops->insert_gdbstub_breakpoint = tcg_insert_gdbstub_breakpoint;
     ops->remove_gdbstub_breakpoint = tcg_remove_gdbstub_breakpoint;
     ops->remove_all_gdbstub_breakpoints = tcg_remove_all_gdbstub_breakpoints;
+    ops->update_guest_debug = tcg_update_cflags;
 }
 
 static void tcg_accel_ops_class_init(ObjectClass *oc, const void *data)
diff --git a/cpu-target.c b/cpu-target.c
index 4783845c9bf..9bd1605e831 100644
--- a/cpu-target.c
+++ b/cpu-target.c
@@ -24,6 +24,7 @@
 #include "exec/replay-core.h"
 #include "exec/log.h"
 #include "hw/core/cpu.h"
+#include "system/tcg.h"
 #include "trace/trace-root.h"
 
 /* enable or disable single step mode. EXCP_DEBUG is returned by the
@@ -35,7 +36,9 @@ void cpu_single_step(CPUState *cpu, unsigned flags)
                                           cpu->singlestep_flags, flags);
         cpu->singlestep_flags = flags;
 
-#if !defined(CONFIG_USER_ONLY)
+#ifdef CONFIG_USER_ONLY
+        tcg_update_cflags(cpu);
+#else
         const AccelOpsClass *ops = cpus_get_accel();
         if (ops->update_guest_debug) {
             ops->update_guest_debug(cpu);
diff --git a/monitor/hmp-cmds.c b/monitor/hmp-cmds.c
index 91701ddf331..9b1b94f8ea9 100644
--- a/monitor/hmp-cmds.c
+++ b/monitor/hmp-cmds.c
@@ -40,6 +40,7 @@
 #include "system/hw_accel.h"
 #include "system/memory.h"
 #include "system/system.h"
+#include "system/tcg.h"
 #include "disas/disas.h"
 
 /* Please update hmp-commands.hx when adding or changing commands */
@@ -340,6 +341,12 @@ void hmp_log(MonitorHMP *hmp, const QDict *qdict)
 
     if (!qemu_set_log(mask, &err)) {
         error_report_err(err);
+        return;
+    }
+
+    /* CPU_LOG_TB_NOCHAIN feeds into the per-CPU cflags. */
+    if (tcg_enabled()) {
+        tcg_update_all_cflags();
     }
 }
 
diff --git a/system/runstate-hmp-cmds.c b/system/runstate-hmp-cmds.c
index ad70b53f8ab..eb34d14d062 100644
--- a/system/runstate-hmp-cmds.c
+++ b/system/runstate-hmp-cmds.c
@@ -22,6 +22,7 @@
 #include "qapi/qapi-commands-run-state.h"
 #include "qobject/qdict.h"
 #include "qemu/accel.h"
+#include "system/tcg.h"
 
 void hmp_info_status(MonitorHMP *hmp, const QDict *qdict)
 {
@@ -43,16 +44,17 @@ void hmp_info_status(MonitorHMP *hmp, const QDict *qdict)
 
 void hmp_one_insn_per_tb(MonitorHMP *hmp, const QDict *qdict)
 {
-    const char *option = qdict_get_try_str(qdict, "option");
-    AccelState *accel = current_accel();
+    const char *option;
+    AccelState *accel;
     bool newval;
 
-    if (!object_property_find(OBJECT(accel), "one-insn-per-tb")) {
-        monitor_hmp_printf(hmp,
-                           "This accelerator does not support setting one-insn-per-tb\n");
+    if (!tcg_enabled()) {
+        monitor_hmp_printf(hmp, "This accelerator does not support "
+                           "setting one-insn-per-tb\n");
         return;
     }
 
+    option = qdict_get_try_str(qdict, "option");
     if (!option || !strcmp(option, "on")) {
         newval = true;
     } else if (!strcmp(option, "off")) {
@@ -61,9 +63,13 @@ void hmp_one_insn_per_tb(MonitorHMP *hmp, const QDict *qdict)
         monitor_hmp_printf(hmp, "unexpected option %s\n", option);
         return;
     }
-    /* If the property exists then setting it can never fail */
+
+    accel = current_accel();
     object_property_set_bool(OBJECT(accel), "one-insn-per-tb",
                              newval, &error_abort);
+
+    /* one-insn-per-tb feeds into the per-CPU cflags. */
+    tcg_update_all_cflags();
 }
 
 void hmp_watchdog_action(MonitorHMP *hmp, const QDict *qdict)
-- 
2.53.0


