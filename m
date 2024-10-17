Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 90244D374A9
	for <qemu-devel@archiver.kernel.org>; Thu, 17 Oct 2024 15:39:00 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t1SZm-00018z-DO; Thu, 17 Oct 2024 11:38:10 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from
 <3Wy8RZwYKCj4wtvzjmlttlqj.htrvjrz-ij0jqstslsz.twl@flex--roqueh.bounces.google.com>)
 id 1t1SZk-00018a-6o
 for qemu-devel@nongnu.org; Thu, 17 Oct 2024 11:38:08 -0400
Received: from mail-yw1-x114a.google.com ([2607:f8b0:4864:20::114a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from
 <3Wy8RZwYKCj4wtvzjmlttlqj.htrvjrz-ij0jqstslsz.twl@flex--roqueh.bounces.google.com>)
 id 1t1SZi-000418-DY
 for qemu-devel@nongnu.org; Thu, 17 Oct 2024 11:38:07 -0400
Received: by mail-yw1-x114a.google.com with SMTP id
 00721157ae682-6e35bdb6a31so22021997b3.1
 for <qemu-devel@nongnu.org>; Thu, 17 Oct 2024 08:38:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=google.com; s=20230601; t=1729179483; x=1729784283; darn=nongnu.org;
 h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
 :date:from:to:cc:subject:date:message-id:reply-to;
 bh=uazllHnYR//8lstmYQDMn8yagtfbgXROiQHILjCVORE=;
 b=0kESykSdS1mozPnopVePnwhSZrk1ODiCSwC0ogTlFMWH5YhbDMSwmW2OVOc/MX3BwP
 F6RCVkoWp0DMKCv8DY86YeSckX3nNQdZSy2PC1QFra89VamfScKicE3NVqRdy66gABJs
 3pPPOht5devXpP1sIhPq/N5nj0pBXzD3QhX7snCXMUEwWl6OBhk19h4IdeDtLTJIWf5Y
 VzYUT13m4/gG+jgBbt8265BU1Uf7y/Pf5zEOSvpd1kcVSr0AHiMDNb+ZS9c0uoXIdqkH
 IFN7ImDY/7jdOb8fUXp4yvYQi+TlkgOf2gqfB68S5mK8wsaNO5hSpstyNpK6z7mfXx8H
 XGPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1729179483; x=1729784283;
 h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
 :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=uazllHnYR//8lstmYQDMn8yagtfbgXROiQHILjCVORE=;
 b=ambnu1hRs0DjcH0BPC0HkeeDOJPABztLWy7L8Rjehv3iCgvajH8cTmzKX+i3hcQrua
 HtrfUvY7dwLjphy/xnkMA1Qajyb02IQMJ3P44/wo9ZQTVOd6FU1H4Wzwk7LG4hruPGZY
 4Y//FnfBPYsbC8d/yq7vgrzozluSvmmSjvQEBm5SjmhnjcgoSLqzkgt6gMbBdr3lquAR
 nq+HVBkicda74cgRZynjzEv1vom4hj7bJCg/98sU1rZSDaaxxUzZtZiVq1/5FHbNoqFI
 mpcbYwsQVLDsdQwmQnbjEVkKe7PmTM3sEBpE4s5QdbA1458oYSHlIi1KR3cdFp5b8lTr
 GyFw==
X-Gm-Message-State: AOJu0YzS8wmtsMYXyiZIJesSCeJc/Dms4PabaRuO1UV5ID1g8gD4chKn
 qApTG1k1+YB8d3y8WEw4RcnnoqxSHc6Eo50tyUhHAnzl5ziN1gWXznJ4/JobpuJuIMRZLnt5I29
 hMw==
X-Google-Smtp-Source: AGHT+IHYRXNn2p4e1diqEZl73Fw9hDwyj7qd2OQmswJBomeH2tRbfBAr9sRgID3mW2j+5e2z7PWph8aj+dI=
X-Received: from roqueh-desktop.svl.corp.google.com
 ([2a00:79e0:2e5b:9:1adf:42eb:8cf9:56e9])
 (user=roqueh job=sendgmr) by 2002:a05:690c:3087:b0:6e3:8cf8:7b7 with SMTP id
 00721157ae682-6e3d41ff049mr103667b3.8.1729179483595; Thu, 17 Oct 2024
 08:38:03 -0700 (PDT)
Date: Thu, 17 Oct 2024 08:37:45 -0700
In-Reply-To: <20241017153745.509978-1-roqueh@google.com>
Mime-Version: 1.0
References: <20241017153745.509978-1-roqueh@google.com>
X-Mailer: git-send-email 2.47.0.rc1.288.g06298d1525-goog
Message-ID: <20241017153745.509978-3-roqueh@google.com>
Subject: [PATCH v2 2/2] gdbstub: Apply breakpoints only to the relevant CPUs
From: Roque Arcudia Hernandez <roqueh@google.com>
To: richard.henderson@linaro.org, pbonzini@redhat.com, alex.bennee@linaro.org, 
 philmd@linaro.org, slongfield@google.com, komlodi@google.com
Cc: qemu-devel@nongnu.org, Roque Arcudia Hernandez <roqueh@google.com>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::114a;
 envelope-from=3Wy8RZwYKCj4wtvzjmlttlqj.htrvjrz-ij0jqstslsz.twl@flex--roqueh.bounces.google.com;
 helo=mail-yw1-x114a.google.com
X-Spam_score_int: -95
X-Spam_score: -9.6
X-Spam_bar: ---------
X-Spam_report: (-9.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_MED=-0.001,
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

The patch creates a function to identify the CPUs that should be
affected by the breakpoint insertion/deletion operations based on the
thread-id sent in the last 'Hg' packet. When multiprocess gdb is not
used it falls back to applying the breakpoints to all cpus.

Signed-off-by: Roque Arcudia Hernandez <roqueh@google.com>
---
 accel/tcg/tcg-accel-ops.c | 37 +++++++++++++++++++++++--------------
 gdbstub/gdbstub.c         |  6 ++++++
 include/exec/gdbstub.h    | 12 ++++++++++++
 3 files changed, 41 insertions(+), 14 deletions(-)

diff --git a/accel/tcg/tcg-accel-ops.c b/accel/tcg/tcg-accel-ops.c
index 3c19e68a79..e0f674b335 100644
--- a/accel/tcg/tcg-accel-ops.c
+++ b/accel/tcg/tcg-accel-ops.c
@@ -33,6 +33,7 @@
 #include "qemu/guest-random.h"
 #include "qemu/timer.h"
 #include "exec/exec-all.h"
+#include "exec/gdbstub.h"
 #include "exec/hwaddr.h"
 #include "exec/tb-flush.h"
 #include "gdbstub/enums.h"
@@ -137,9 +138,11 @@ static int tcg_insert_breakpoint(CPUState *cs, int type, vaddr addr, vaddr len)
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
@@ -147,10 +150,12 @@ static int tcg_insert_breakpoint(CPUState *cs, int type, vaddr addr, vaddr len)
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
@@ -168,9 +173,11 @@ static int tcg_remove_breakpoint(CPUState *cs, int type, vaddr addr, vaddr len)
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
@@ -178,10 +185,12 @@ static int tcg_remove_breakpoint(CPUState *cs, int type, vaddr addr, vaddr len)
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
index 64ad81e53f..7649301f7f 100644
--- a/gdbstub/gdbstub.c
+++ b/gdbstub/gdbstub.c
@@ -493,6 +493,12 @@ const GDBFeature *gdb_find_static_feature(const char *xmlname)
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
index d73f424f56..46e5aa51c6 100644
--- a/include/exec/gdbstub.h
+++ b/include/exec/gdbstub.h
@@ -108,6 +108,18 @@ void gdb_feature_builder_end(const GDBFeatureBuilder *builder);
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
2.47.0.rc1.288.g06298d1525-goog


