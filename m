Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1C72BC3ABC9
	for <qemu-devel@archiver.kernel.org>; Thu,  8 May 2025 22:46:11 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uD9zZ-0001tj-M9; Thu, 08 May 2025 18:45:25 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from
 <3_zMdaAwKCiQNABIHESTEFANGOOGLE.COMQEMU-DEVELNONGNU.ORG@flex--nabihestefan.bounces.google.com>)
 id 1uD9zX-0001tP-Mt
 for qemu-devel@nongnu.org; Thu, 08 May 2025 18:45:23 -0400
Received: from mail-pg1-x54a.google.com ([2607:f8b0:4864:20::54a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from
 <3_zMdaAwKCiQNABIHESTEFANGOOGLE.COMQEMU-DEVELNONGNU.ORG@flex--nabihestefan.bounces.google.com>)
 id 1uD9zV-00060g-PB
 for qemu-devel@nongnu.org; Thu, 08 May 2025 18:45:23 -0400
Received: by mail-pg1-x54a.google.com with SMTP id
 41be03b00d2f7-b115383fcecso908029a12.1
 for <qemu-devel@nongnu.org>; Thu, 08 May 2025 15:45:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=google.com; s=20230601; t=1746744319; x=1747349119; darn=nongnu.org;
 h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
 :date:from:to:cc:subject:date:message-id:reply-to;
 bh=iPhyc5RnomaCnosM779271Ijb1GRqVeoX1PThq56qjo=;
 b=Nv1PcGQyo4oilBjqMfanTJZoXZku0NLgHddZt5XZpCrv/h8mSUOhG2T3V8R+XiK0rA
 dSkdzKEXkG3YIcLR68j2eVmhsoOOu+ZbqO5RybutkFmDjrKAiouA79CgDhFFshJbH9PF
 8sP2/ZN/uPTe84eYNQyBH0yaDXlanWJu/e1olUkMy1PkTVarm1X6KrmxK/qmD0WMeuME
 EFxJpg1RaV+XxzYS2s60Xyt/caXVxjzBKiKS0xVfsf9eJmoqoEJzdbfa74aOtXXWN0Ev
 8mPqqaT7N6K3TqzuzRlcacQLx9VTDI4EBcRfQXnPE8vAQXIWF0PcgqZ4l0nbRHGAU+Sh
 Kbmw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1746744319; x=1747349119;
 h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
 :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=iPhyc5RnomaCnosM779271Ijb1GRqVeoX1PThq56qjo=;
 b=rR0xqmKLDEDFwFb9io/NPsfcTj1ajEADsVK2RlniQilD4/WwQpD2FPeeESmc6kLIeC
 s6ZwfpY4b/TDEVW3IsPX6byAEIokR+CGVgX7k6Op9BjG1JzEm1XsxV1P8qeAssxkQ2AK
 e7L+CAEGNcxJ/3W/R9U5MqVicQY1Aqfur45o+oOxeKsjf7+Wc1mIQOu4UbWQGoSRXn+6
 eIYhm2mkRqH+6MU14L2xRqreLmmS2nTqN3kzDW6pk/ectoORVqWeqF+YAeqms2LPecVM
 0vJek0M5Y4kyqV5fEzYXHXJAiIo43qeLlDc52VcI60/QP5m1hTqRHNjzzReG7Q15L1Xp
 hhzQ==
X-Gm-Message-State: AOJu0YxdwMmDbhzjFH4/8b7e9tyHpgptX6RSFsz1/JqNDc0goYZJW4EO
 sl5CCuTRqMOMP5dq1aVzrn3zqaGWpBPemc+ioGOUM6asdiTstXqB8fmhBTzT/OELRQXcF5ng1aW
 6ohpkCfXTzaC/THB6J96cMWMD9Aw5+/8UcJT4wirI+kxds/OmpJp9KNAwO2FeK0gVVzJPLIey4r
 VwlTdGzpcusHjAm227aKvrJ2I1XHyJYoKwNSeLcCPQwrY3ZzPKuyRVe8be25FsrJg=
X-Google-Smtp-Source: AGHT+IEF5h2dGMRSFB/3qt1MWY/CT6+09vIORKHY5GfqLKOfkuEu2ik60AX2rn5BrQmN0PMtDJlb2l5G5nna2AvsRNc=
X-Received: from pgbdo14.prod.google.com ([2002:a05:6a02:e8e:b0:b14:9a53:2226])
 (user=nabihestefan job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:6a20:d48d:b0:1ee:c7c8:ca4 with SMTP id
 adf61e73a8af0-215abc730d9mr1433032637.36.1746744319421; 
 Thu, 08 May 2025 15:45:19 -0700 (PDT)
Date: Thu,  8 May 2025 22:45:14 +0000
In-Reply-To: <20250508224514.805456-1-nabihestefan@google.com>
Mime-Version: 1.0
References: <20250508224514.805456-1-nabihestefan@google.com>
X-Mailer: git-send-email 2.49.0.1015.ga840276032-goog
Message-ID: <20250508224514.805456-3-nabihestefan@google.com>
Subject: [PATCH 2/2] gdbstub: Apply breakpoints only to the selected PID
From: Nabih Estefan <nabihestefan@google.com>
To: qemu-devel@nongnu.org
Cc: richard.henderson@linaro.org, pbonzini@redhat.com, alex.bennee@linaro.org, 
 philmd@linaro.org, Roque Arcudia Hernandez <roqueh@google.com>, 
 Nabih Estefan <nabihestefan@google.com>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::54a;
 envelope-from=3_zMdaAwKCiQNABIHESTEFANGOOGLE.COMQEMU-DEVELNONGNU.ORG@flex--nabihestefan.bounces.google.com;
 helo=mail-pg1-x54a.google.com
X-Spam_score_int: -100
X-Spam_score: -10.1
X-Spam_bar: ----------
X-Spam_report: (-10.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_MED=-0.499,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 USER_IN_DEF_DKIM_WL=-7.5 autolearn=ham autolearn_force=no
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

From: Roque Arcudia Hernandez <roqueh@google.com>

In the context of using the remote gdb with multiple
processes/inferiors (multi cluster machine) a given breakpoint will
target an specific inferior. Current implementation of
tcg_insert_breakpoint and tcg_remove_breakpoint apply a given
breakpoint to all the cpus available in the system.

This is not how gdb expects the remote protocol to behave. If we
refer to the current source of gdb, in the function
remote_target::insert_breakpoint in the file gdb/remote.c we can see
the intention to have the right process selected before breakpoint
insertion:

int
remote_target::insert_breakpoint (struct gdbarch *gdbarch,
                                  struct bp_target_info *bp_tgt)
{
...
  /* Make sure the remote is pointing at the right process, if
     necessary.  */
  if (!gdbarch_has_global_breakpoints (current_inferior ()->arch ()))
    set_general_process ();
...
}

Since most platforms do not have global breakpoints, this typically
will result in an 'Hg' Packet sent before 'z/Z', if gdb is not
pointing to the desired process.

For instance this is a concrete example obtained with a trace dump:

gdbstub_io_command Received: Hgp2.2
gdbstub_io_command Received: Z0,4000ded0,4

Only the CPUs associated with the selected process ID should insert
or remove the breakpoint. It is important to apply it to all the CPUs
in the process ID regardless of the particular thread selected by the
'Hg' packet because even in the case of a thread specific breakpoint.
A breakpoint on a specific thread is treated as a conditional break
similar to a 'break if'. This can be read in the code and comments of
function bpstat_check_breakpoint_conditions in the file
gdb/breakpoint.c

/* For breakpoints that are currently marked as telling gdb to stop,
   check conditions (condition proper, frame, thread and ignore count)
   of breakpoint referred to by BS.  If we should not stop for this
   breakpoint, set BS->stop to 0.  */

static void
bpstat_check_breakpoint_conditions (bpstat *bs, thread_info *thread)

The patch needs to expose the currently private function
gdb_get_cpu_pid to the TCG and also expose the value of
gdbserver_state.multiprocess. The PID filtering will only be
applicable to multiprocess gdb because the PIDs are only defined in
that context.

Signed-off-by: Roque Arcudia Hernandez <roqueh@google.com>
Signed-off-by: Nabih Estefan <nabihestefan@google.com>
---
 accel/tcg/tcg-accel-ops.c | 37 +++++++++++++++++++++++--------------
 gdbstub/gdbstub.c         |  6 ++++++
 include/exec/gdbstub.h    | 12 ++++++++++++
 3 files changed, 41 insertions(+), 14 deletions(-)

diff --git a/accel/tcg/tcg-accel-ops.c b/accel/tcg/tcg-accel-ops.c
index b24d6a7562..aca476cdf5 100644
--- a/accel/tcg/tcg-accel-ops.c
+++ b/accel/tcg/tcg-accel-ops.c
@@ -34,6 +34,7 @@
 #include "qemu/guest-random.h"
 #include "qemu/timer.h"
 #include "exec/cputlb.h"
+#include "exec/gdbstub.h"
 #include "exec/hwaddr.h"
 #include "exec/tb-flush.h"
 #include "exec/translation-block.h"
@@ -139,9 +140,11 @@ static int tcg_insert_breakpoint(CPUState *cs, int type, vaddr addr, vaddr len)
     case GDB_BREAKPOINT_SW:
     case GDB_BREAKPOINT_HW:
         CPU_FOREACH(cpu) {
-            err = cpu_breakpoint_insert(cpu, addr, BP_GDB, NULL);
-            if (err) {
-                break;
+            if (gdb_cpu_in_source_group(cs, cpu)) {
+                err = cpu_breakpoint_insert(cpu, addr, BP_GDB, NULL);
+                if (err) {
+                    break;
+                }
             }
         }
         return err;
@@ -149,10 +152,12 @@ static int tcg_insert_breakpoint(CPUState *cs, int type, vaddr addr, vaddr len)
     case GDB_WATCHPOINT_READ:
     case GDB_WATCHPOINT_ACCESS:
         CPU_FOREACH(cpu) {
-            err = cpu_watchpoint_insert(cpu, addr, len,
-                                        xlat_gdb_type(cpu, type), NULL);
-            if (err) {
-                break;
+            if (gdb_cpu_in_source_group(cs, cpu)) {
+                err = cpu_watchpoint_insert(cpu, addr, len,
+                                            xlat_gdb_type(cpu, type), NULL);
+                if (err) {
+                    break;
+                }
             }
         }
         return err;
@@ -170,9 +175,11 @@ static int tcg_remove_breakpoint(CPUState *cs, int type, vaddr addr, vaddr len)
     case GDB_BREAKPOINT_SW:
     case GDB_BREAKPOINT_HW:
         CPU_FOREACH(cpu) {
-            err = cpu_breakpoint_remove(cpu, addr, BP_GDB);
-            if (err) {
-                break;
+            if (gdb_cpu_in_source_group(cs, cpu)) {
+                err = cpu_breakpoint_remove(cpu, addr, BP_GDB);
+                if (err) {
+                    break;
+                }
             }
         }
         return err;
@@ -180,10 +187,12 @@ static int tcg_remove_breakpoint(CPUState *cs, int type, vaddr addr, vaddr len)
     case GDB_WATCHPOINT_READ:
     case GDB_WATCHPOINT_ACCESS:
         CPU_FOREACH(cpu) {
-            err = cpu_watchpoint_remove(cpu, addr, len,
-                                        xlat_gdb_type(cpu, type));
-            if (err) {
-                break;
+            if (gdb_cpu_in_source_group(cs, cpu)) {
+                err = cpu_watchpoint_remove(cpu, addr, len,
+                                            xlat_gdb_type(cpu, type));
+                if (err) {
+                    break;
+                }
             }
         }
         return err;
diff --git a/gdbstub/gdbstub.c b/gdbstub/gdbstub.c
index 0e2e10fbaa..652e0e768f 100644
--- a/gdbstub/gdbstub.c
+++ b/gdbstub/gdbstub.c
@@ -492,6 +492,12 @@ const GDBFeature *gdb_find_static_feature(const char *xmlname)
     g_assert_not_reached();
 }
 
+bool gdb_cpu_in_source_group(CPUState *cs, CPUState *cpu)
+{
+    return !gdbserver_state.multiprocess ||
+           (gdb_get_cpu_pid(cs) == gdb_get_cpu_pid(cpu));
+}
+
 GArray *gdb_get_register_list(CPUState *cpu)
 {
     GArray *results = g_array_new(true, true, sizeof(GDBRegDesc));
diff --git a/include/exec/gdbstub.h b/include/exec/gdbstub.h
index 0675b0b646..f92641793c 100644
--- a/include/exec/gdbstub.h
+++ b/include/exec/gdbstub.h
@@ -114,6 +114,18 @@ void gdb_feature_builder_end(const GDBFeatureBuilder *builder);
  */
 const GDBFeature *gdb_find_static_feature(const char *xmlname);
 
+/**
+ * Tests if the CPUs belong to the same group for the purposes of breakpoint
+ * insertion and deletion when running multiprocesses gdb. The test is only
+ * valid for multiprocess gdb and should not affect the insertion or deletion of
+ * breakpoints when we are not running in that mode.
+ * @cs: The CPU used as reference
+ * @cpu: The CPU to test
+ *
+ * Return: True if they belong to the same group or it is not a multiprocess gdb
+ */
+bool gdb_cpu_in_source_group(CPUState *cs, CPUState *cpu);
+
 /**
  * gdb_read_register() - Read a register associated with a CPU.
  * @cpu: The CPU associated with the register.
-- 
2.49.0.1015.ga840276032-goog


