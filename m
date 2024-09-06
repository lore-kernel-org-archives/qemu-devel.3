Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DD4B8E6FE49
	for <qemu-devel@archiver.kernel.org>; Fri,  6 Sep 2024 22:56:10 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1smhrA-0006rr-Me; Fri, 06 Sep 2024 18:55:08 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from
 <3SIjbZgYKCgUwtvzjmlttlqj.htrvjrz-ij0jqstslsz.twl@flex--roqueh.bounces.google.com>)
 id 1smhr9-0006mj-F7
 for qemu-devel@nongnu.org; Fri, 06 Sep 2024 18:55:07 -0400
Received: from mail-yw1-x114a.google.com ([2607:f8b0:4864:20::114a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from
 <3SIjbZgYKCgUwtvzjmlttlqj.htrvjrz-ij0jqstslsz.twl@flex--roqueh.bounces.google.com>)
 id 1smhr7-0005fV-Ia
 for qemu-devel@nongnu.org; Fri, 06 Sep 2024 18:55:07 -0400
Received: by mail-yw1-x114a.google.com with SMTP id
 00721157ae682-6d475205628so86672877b3.0
 for <qemu-devel@nongnu.org>; Fri, 06 Sep 2024 15:55:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=google.com; s=20230601; t=1725663304; x=1726268104; darn=nongnu.org;
 h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
 :date:from:to:cc:subject:date:message-id:reply-to;
 bh=nsx3K+Q5vkcw0I1VEsx1ERdK9PHye/j2Qc1UcP0pHjg=;
 b=xC6gYxB4exHlPBfZ71AwSMCC95du3CMPb5NfiYojPh+eRK15Ze/onxBRFCExTkqyIj
 mdAG/8YtrBuvbvdg7IAZNjkjKixg9lYRCuJFYTG4VJ+hx4wBJzJ+GbA9O6Hd0DsGytME
 rloTFIECmgewHSmop4NUzvd9MZhcbVfHsb2Y4sYD2U+wtwz9/k19HLrLgaB8B/CPO200
 FJ1gMhpHQU85XDJwIXzT5IQMrIqoDVOGP4bp7MSgpCdHBKE6jfiPIjFMY2iCwl8o+5Ut
 kAs37FfcRN+h6z+owe4eEioaWaWZLoS6UwxLs6qw3MX7bDMVVYSGHLmnIV+ryJbni+Ha
 KNBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1725663304; x=1726268104;
 h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
 :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=nsx3K+Q5vkcw0I1VEsx1ERdK9PHye/j2Qc1UcP0pHjg=;
 b=f3jpjAFyh+W3tIho1zU7BnvBfjzV4DQrHQf05eTIcaEyZM2642381383QbPXiSg/lX
 3QsSmRf9r24nIp76Glwio6Ya/nLB8ZIJzOd2z8hL96Oor5IjofaSOkfrEOWVTa3c3OQ0
 oC6cuk38He9hZQBQUhGlVM9ESqM5MMP8JMhg1OHW1ElIwdEOjVrgs8dqQxIRtLPXcla9
 xWeAZ+o9/g1K7Q8UfmcJIfO+fuUMYKIGv8hLMRbrMs4PIZYzwFeCGMIIsTGfJG0F+4ga
 NWXIKX1WnSglVDxAG3lCljhhsG0yMxnGumhz9JkhvCiLb92c0GgYPWOBuPnTsPb1qqrp
 2ocg==
X-Gm-Message-State: AOJu0YzfP/EzdrdfURqJVBwN0owEYJE8JA0Ov8WYedwN43IAVKAhBQZn
 1KPaSD5WmuK54RmlPGW8XzhzfmJEBIaHLrsiRAhTuEbh8KVOLa/wbf7svL7mts7ACVaBIrltYAL
 Bgg==
X-Google-Smtp-Source: AGHT+IGlx6HfVmML0dB8+Ky8n5zXmOu5pd9zFyp5hfcLRNFvcDxvWC2HqY1+ZRSnTiIrUR72yisQ2qKZd5g=
X-Received: from roqueh-desktop.svl.corp.google.com
 ([2620:15c:2a3:200:81f3:7a35:4574:5dc])
 (user=roqueh job=sendgmr) by 2002:a05:690c:610d:b0:6b2:6cd4:7f9a with SMTP id
 00721157ae682-6db4526b0f6mr2260267b3.8.1725663304169; Fri, 06 Sep 2024
 15:55:04 -0700 (PDT)
Date: Fri,  6 Sep 2024 15:54:51 -0700
In-Reply-To: <20240906225451.1039718-1-roqueh@google.com>
Mime-Version: 1.0
References: <20240906225451.1039718-1-roqueh@google.com>
X-Mailer: git-send-email 2.46.0.469.g59c65b2a67-goog
Message-ID: <20240906225451.1039718-3-roqueh@google.com>
Subject: [PATCH 2/2] gdbstub: Apply breakpoints only to the selected PID
From: Roque Arcudia Hernandez <roqueh@google.com>
To: richard.henderson@linaro.org, pbonzini@redhat.com, alex.bennee@linaro.org, 
 philmd@linaro.org, slongfield@google.com, komlodi@google.com
Cc: qemu-devel@nongnu.org, Roque Arcudia Hernandez <roqueh@google.com>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::114a;
 envelope-from=3SIjbZgYKCgUwtvzjmlttlqj.htrvjrz-ij0jqstslsz.twl@flex--roqueh.bounces.google.com;
 helo=mail-yw1-x114a.google.com
X-Spam_score_int: -95
X-Spam_score: -9.6
X-Spam_bar: ---------
X-Spam_report: (-9.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_MED=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01,
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

The patch needs to expose the currently private function
gdb_get_cpu_pid to the TCG and also expose the value of
gdbserver_state.multiprocess. The PID filtering will only be
applicable to multiprocess gdb because the PIDs are only defined in
that context.

Google-Bug-Id: 355027002
Signed-off-by: Roque Arcudia Hernandez <roqueh@google.com>
---
 accel/tcg/tcg-accel-ops.c | 15 +++++++++++++++
 gdbstub/gdbstub.c         |  7 ++++++-
 include/exec/gdbstub.h    | 15 +++++++++++++++
 3 files changed, 36 insertions(+), 1 deletion(-)

diff --git a/accel/tcg/tcg-accel-ops.c b/accel/tcg/tcg-accel-ops.c
index 3c19e68a79..557091c15e 100644
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
@@ -132,11 +133,15 @@ static int tcg_insert_breakpoint(CPUState *cs, int type, vaddr addr, vaddr len)
 {
     CPUState *cpu;
     int err = 0;
+    bool match_pid = gdb_is_multiprocess();
 
     switch (type) {
     case GDB_BREAKPOINT_SW:
     case GDB_BREAKPOINT_HW:
         CPU_FOREACH(cpu) {
+            if (match_pid && gdb_get_cpu_pid(cpu) != gdb_get_cpu_pid(cs)) {
+                continue;
+            }
             err = cpu_breakpoint_insert(cpu, addr, BP_GDB, NULL);
             if (err) {
                 break;
@@ -147,6 +152,9 @@ static int tcg_insert_breakpoint(CPUState *cs, int type, vaddr addr, vaddr len)
     case GDB_WATCHPOINT_READ:
     case GDB_WATCHPOINT_ACCESS:
         CPU_FOREACH(cpu) {
+            if (match_pid && gdb_get_cpu_pid(cpu) != gdb_get_cpu_pid(cs)) {
+                continue;
+            }
             err = cpu_watchpoint_insert(cpu, addr, len,
                                         xlat_gdb_type(cpu, type), NULL);
             if (err) {
@@ -163,11 +171,15 @@ static int tcg_remove_breakpoint(CPUState *cs, int type, vaddr addr, vaddr len)
 {
     CPUState *cpu;
     int err = 0;
+    bool match_pid = gdb_is_multiprocess();
 
     switch (type) {
     case GDB_BREAKPOINT_SW:
     case GDB_BREAKPOINT_HW:
         CPU_FOREACH(cpu) {
+            if (match_pid && gdb_get_cpu_pid(cpu) != gdb_get_cpu_pid(cs)) {
+                continue;
+            }
             err = cpu_breakpoint_remove(cpu, addr, BP_GDB);
             if (err) {
                 break;
@@ -178,6 +190,9 @@ static int tcg_remove_breakpoint(CPUState *cs, int type, vaddr addr, vaddr len)
     case GDB_WATCHPOINT_READ:
     case GDB_WATCHPOINT_ACCESS:
         CPU_FOREACH(cpu) {
+            if (match_pid && gdb_get_cpu_pid(cpu) != gdb_get_cpu_pid(cs)) {
+                continue;
+            }
             err = cpu_watchpoint_remove(cpu, addr, len,
                                         xlat_gdb_type(cpu, type));
             if (err) {
diff --git a/gdbstub/gdbstub.c b/gdbstub/gdbstub.c
index 98574eba68..628e599692 100644
--- a/gdbstub/gdbstub.c
+++ b/gdbstub/gdbstub.c
@@ -199,7 +199,12 @@ void gdb_memtox(GString *buf, const char *mem, int len)
     }
 }
 
-static uint32_t gdb_get_cpu_pid(CPUState *cpu)
+bool gdb_is_multiprocess(void)
+{
+    return gdbserver_state.multiprocess;
+}
+
+uint32_t gdb_get_cpu_pid(CPUState *cpu)
 {
 #ifdef CONFIG_USER_ONLY
     return getpid();
diff --git a/include/exec/gdbstub.h b/include/exec/gdbstub.h
index d73f424f56..a7c95d215b 100644
--- a/include/exec/gdbstub.h
+++ b/include/exec/gdbstub.h
@@ -138,6 +138,21 @@ GArray *gdb_get_register_list(CPUState *cpu);
 
 void gdb_set_stop_cpu(CPUState *cpu);
 
+/**
+ * gdb_get_cpu_pid() - Get the PID assigned to a CPU
+ * @cpu - the CPU to query
+ *
+ * Return: The PID associated with the cpu
+ */
+uint32_t gdb_get_cpu_pid(CPUState *cpu);
+
+/**
+ * gdb_is_multiprocess() - Tells if the gdb server supports multiple processes
+ *
+ * Return: True if supported
+ */
+bool gdb_is_multiprocess(void);
+
 /* in gdbstub-xml.c, generated by scripts/feature_to_c.py */
 extern const GDBFeature gdb_static_features[];
 
-- 
2.46.0.469.g59c65b2a67-goog


