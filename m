Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A7AEAC61DD6
	for <qemu-devel@archiver.kernel.org>; Tue,  1 Sep 2026 03:50:50 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x1FUR-0000aS-87; Mon, 31 Aug 2026 23:48:51 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mattst88@gmail.com>)
 id 1x1FUP-0000Zv-1m
 for qemu-devel@nongnu.org; Mon, 31 Aug 2026 23:48:49 -0400
Received: from mail-yw1-x112b.google.com ([2607:f8b0:4864:20::112b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <mattst88@gmail.com>)
 id 1x1FUM-0004Kt-8V
 for qemu-devel@nongnu.org; Mon, 31 Aug 2026 23:48:48 -0400
Received: by mail-yw1-x112b.google.com with SMTP id
 00721157ae682-857ff9fef54so5066407b3.1
 for <qemu-devel@nongnu.org>; Mon, 31 Aug 2026 20:48:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1788234525; x=1788839325; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=w7dxb1OJU0LPOmKMjovKdzBr/gV3Lga/pfQME9xMvpA=;
 b=So9zQronuqkg9pZrgHRcfUK6jy0VW8/Au5oMH/lN8YQ/0JMtgHu/zHJy4p7nEWgthP
 GrHUGNGnudZ7Mx7BlF7p9d6NuoODdzkHGfLLIdIWr0CpDFLWUIWUmMtuDvEq04gPerPs
 N0kPA31ZGIzqYIxN6krCQUOgb5et4mwbdKSD7qhCvNRXWakAO5FT7yJhcMtFHsmXtwA7
 VAEnTiQeRqqVQ7BHIxfURnv7PlC2eZPbX6uh1GaGcPvH/8JyRfw8qLOVO69WZFwssIJ3
 v/J2nTaemEszjgmR13AdGIVkFJF0IfiRWehFZPZT4CifzBRizFVTRbUYkH9He/oxGgX/
 +Obg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1788234525; x=1788839325;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=w7dxb1OJU0LPOmKMjovKdzBr/gV3Lga/pfQME9xMvpA=;
 b=lH9+MogKZ3x/IjELSG/rZl5o2Mt9+LjKW8X0UOPo4AZQ1yVW9sRVKpLWc3DSAs07rp
 4zXPtYAUl2OSxxZLslxfGfWeqXP+XWuZMTwohfFO/fEsEAfHpLUGAaVvXcY7rLvhycJy
 96mWe7Zy4Qs1ZSC4ByGenVANAUfo4p6O8rxVsNDpHeyBSHsR3S/sTZbA+d9BgK3DQFkf
 bx33ht7iq3kGlV3A4ZcQXO5dqOVgVQwzhBVINPyi0Kk+SvtU4ck7jIFckv+n77X1Wq3E
 CZzLC+3ueI4nPh7pseEymZWf7YChyvBi8/0mICgZSQdOy/tc42dZEr9E+wJiqQKh7rL1
 xhmw==
X-Gm-Message-State: AFuF++mY+LesjP2BnVPsSaVxmuJBlmV3uhbiyd+MJylK+XUbKS4Fject
 QNQRSoUnMek8r6KdzWdGnDUKfgnlnb/CqpyhrgQahAczUHTGF7DqHTbskBXgUg==
X-Gm-Gg: AYBFou2dFt4WLRNStJpTzRYODPV8Nm5COEl4at/n9+O+UBAnToe13htkgdRWD+XNuGg
 phpdqIGS/hjisaZNE8g4SpocgiQf1X7N2bmHhMSHt3C0ap575N6LtGbdTUOtE5BmMXab8xhmbap
 P9H/iq+Yg8z6WsHMlBj5NvJFlmtqGeFsWfF5pGwh/YNVnKAFxTluh1ux8aIVO/P4Bb9+xdUq/kM
 cQ3XBFWEBgpcHS5DeDDllsOrQWe9Nt61Cfi2r0e4qMocpJLkgGIBno+ckzH4jqASpc21vwW38sO
 TsNtNO1TTgrxZfhlPY1TC1/k/JSRKmkZRiA5sh3ENpOXHYfDF0vOTF+hz6Jt8DOH0PzTNHMVabm
 TAt4te+FlTf9oceOlZvmT5S+r6egvIsRhFX8Z1U/N8WomHPS0y0nu6yIyn4tLHGoHJEQpfAAFfD
 BimvagkGUmDzz8U8RL+c4P5m0BIaEnpNbAljam/0aCZRKVwFwzgZqj5pCpeqbvlngFQn71kMjoZ
 dfs/W6sPwAJmnWPiXjH2GPwRDu72GWKFvE16+1NNQ==
X-Received: by 2002:a05:690c:309:b0:864:a8f4:faf0 with SMTP id
 00721157ae682-864a8f521femr59318437b3.10.1788234524422; 
 Mon, 31 Aug 2026 20:48:44 -0700 (PDT)
Received: from localhost (107-220-129-194.lightspeed.chrlnc.sbcglobal.net.
 [107.220.129.194]) by smtp.gmail.com with ESMTPSA id
 00721157ae682-86326649752sm41728887b3.3.2026.08.31.20.48.42
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 31 Aug 2026 20:48:43 -0700 (PDT)
From: Matt Turner <mattst88@gmail.com>
To: qemu-devel@nongnu.org
Cc: richard.henderson@linaro.org, pbonzini@redhat.com, philmd@oss.qualcomm.com,
 alex.bennee@linaro.org, zhao1.liu@intel.com,
 Matt Turner <mattst88@gmail.com>
Subject: [PATCH v5 1/9] accel/tcg: fold the dynamic cflags into
 CPUState::tcg_cflags
Date: Mon, 31 Aug 2026 23:48:00 -0400
Message-ID: <20260901034808.3524945-2-mattst88@gmail.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260901034808.3524945-1-mattst88@gmail.com>
References: <20260827050241.3713332-1-mattst88@gmail.com>
 <20260901034808.3524945-1-mattst88@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::112b;
 envelope-from=mattst88@gmail.com; helo=mail-yw1-x112b.google.com
X-Spam_score_int: -17
X-Spam_score: -1.8
X-Spam_bar: -
X-Spam_report: (-1.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FREEMAIL_ENVFROM_END_DIGIT=0.25, FREEMAIL_FROM=0.001,
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
---
 accel/stubs/meson.build     |  1 +
 accel/stubs/tcg-stub.c      | 16 ++++++++++++++++
 accel/tcg/cpu-exec-common.c | 33 ++++++++++++++++++++++++++++++---
 accel/tcg/cpu-exec.c        |  3 +++
 accel/tcg/internal-common.h | 11 +++++++++--
 cpu-target.c                |  3 +++
 include/system/tcg.h        | 12 ++++++++++++
 monitor/hmp-cmds.c          |  5 +++++
 system/runstate-hmp-cmds.c  |  4 ++++
 9 files changed, 83 insertions(+), 5 deletions(-)
 create mode 100644 accel/stubs/tcg-stub.c

diff --git ./accel/stubs/meson.build ./accel/stubs/meson.build
index 7c6d7ad943..ccad583e64 100644
--- ./accel/stubs/meson.build
+++ ./accel/stubs/meson.build
@@ -4,6 +4,7 @@ stub_ss.add(files(
   'nitro-stub.c',
   'mshv-stub.c',
   'nvmm-stub.c',
+  'tcg-stub.c',
   'whpx-stub.c',
   'xen-stub.c',
 ))
diff --git ./accel/stubs/tcg-stub.c ./accel/stubs/tcg-stub.c
new file mode 100644
index 0000000000..f9e1bd22d6
--- /dev/null
+++ ./accel/stubs/tcg-stub.c
@@ -0,0 +1,16 @@
+/*
+ * Stubs for the TCG entry points in system/tcg.h, for binaries that link
+ * cpu-target.c or the HMP command handlers but not TCG.
+ *
+ * SPDX-License-Identifier: GPL-2.0-or-later
+ */
+#include "qemu/osdep.h"
+#include "system/tcg.h"
+
+void tcg_update_cflags(CPUState *cpu)
+{
+}
+
+void tcg_update_all_cflags(void)
+{
+}
diff --git ./accel/tcg/cpu-exec-common.c ./accel/tcg/cpu-exec-common.c
index 44e84344f3..9f3517f36b 100644
--- ./accel/tcg/cpu-exec-common.c
+++ ./accel/tcg/cpu-exec-common.c
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
diff --git ./accel/tcg/cpu-exec.c ./accel/tcg/cpu-exec.c
index 257211235d..148e0f583e 100644
--- ./accel/tcg/cpu-exec.c
+++ ./accel/tcg/cpu-exec.c
@@ -1068,6 +1068,9 @@ bool tcg_exec_realizefn(CPUState *cpu, Error **errp)
         tcg_target_initialized = true;
     }
 
+    /* Pick up one-insn-per-tb and -d nochain from the command line. */
+    tcg_update_cflags(cpu);
+
     cpu->tb_jmp_cache = g_new0(CPUJumpCache, 1);
     tlb_init(cpu);
 #ifndef CONFIG_USER_ONLY
diff --git ./accel/tcg/internal-common.h ./accel/tcg/internal-common.h
index 9e7be2d78d..853d1b51ee 100644
--- ./accel/tcg/internal-common.h
+++ ./accel/tcg/internal-common.h
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
 
diff --git ./cpu-target.c ./cpu-target.c
index 4783845c9b..50be591acf 100644
--- ./cpu-target.c
+++ ./cpu-target.c
@@ -24,6 +24,7 @@
 #include "exec/replay-core.h"
 #include "exec/log.h"
 #include "hw/core/cpu.h"
+#include "system/tcg.h"
 #include "trace/trace-root.h"
 
 /* enable or disable single step mode. EXCP_DEBUG is returned by the
@@ -35,6 +36,8 @@ void cpu_single_step(CPUState *cpu, unsigned flags)
                                           cpu->singlestep_flags, flags);
         cpu->singlestep_flags = flags;
 
+        tcg_update_cflags(cpu);
+
 #if !defined(CONFIG_USER_ONLY)
         const AccelOpsClass *ops = cpus_get_accel();
         if (ops->update_guest_debug) {
diff --git ./include/system/tcg.h ./include/system/tcg.h
index 7622dcea30..2c2dbc753b 100644
--- ./include/system/tcg.h
+++ ./include/system/tcg.h
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
diff --git ./monitor/hmp-cmds.c ./monitor/hmp-cmds.c
index 4e8d996dbb..b83551ea54 100644
--- ./monitor/hmp-cmds.c
+++ ./monitor/hmp-cmds.c
@@ -39,6 +39,7 @@
 #include "system/hw_accel.h"
 #include "system/memory.h"
 #include "system/system.h"
+#include "system/tcg.h"
 #include "disas/disas.h"
 
 /* Please update hmp-commands.hx when adding or changing commands */
@@ -335,7 +336,11 @@ void hmp_log(Monitor *mon, const QDict *qdict)
 
     if (!qemu_set_log(mask, &err)) {
         error_report_err(err);
+        return;
     }
+
+    /* CPU_LOG_TB_NOCHAIN feeds into the per-CPU cflags. */
+    tcg_update_all_cflags();
 }
 
 void hmp_gdbserver(Monitor *mon, const QDict *qdict)
diff --git ./system/runstate-hmp-cmds.c ./system/runstate-hmp-cmds.c
index 02d1d42bf3..86754a37f8 100644
--- ./system/runstate-hmp-cmds.c
+++ ./system/runstate-hmp-cmds.c
@@ -22,6 +22,7 @@
 #include "qapi/qapi-commands-run-state.h"
 #include "qobject/qdict.h"
 #include "qemu/accel.h"
+#include "system/tcg.h"
 
 void hmp_info_status(Monitor *mon, const QDict *qdict)
 {
@@ -64,6 +65,9 @@ void hmp_one_insn_per_tb(Monitor *mon, const QDict *qdict)
     /* If the property exists then setting it can never fail */
     object_property_set_bool(OBJECT(accel), "one-insn-per-tb",
                              newval, &error_abort);
+
+    /* one-insn-per-tb feeds into the per-CPU cflags. */
+    tcg_update_all_cflags();
 }
 
 void hmp_watchdog_action(Monitor *mon, const QDict *qdict)
-- 
2.54.0


