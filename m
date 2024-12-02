Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AF2CEE69E8B
	for <qemu-devel@archiver.kernel.org>; Mon,  2 Dec 2024 19:42:59 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tICJ5-00066t-Vy; Mon, 02 Dec 2024 14:42:08 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <neither@nut.email>) id 1tICIz-00065o-CA
 for qemu-devel@nongnu.org; Mon, 02 Dec 2024 14:42:01 -0500
Received: from mailgate02.uberspace.is ([185.26.156.114])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <neither@nut.email>) id 1tICIw-0005tG-Fk
 for qemu-devel@nongnu.org; Mon, 02 Dec 2024 14:42:01 -0500
Received: from skiff.uberspace.de (skiff.uberspace.de [185.26.156.131])
 by mailgate02.uberspace.is (Postfix) with ESMTPS id EDA3A180C05
 for <qemu-devel@nongnu.org>; Mon,  2 Dec 2024 20:41:54 +0100 (CET)
Received: (qmail 24777 invoked by uid 990); 2 Dec 2024 19:41:54 -0000
Authentication-Results: skiff.uberspace.de;
	auth=pass (plain)
Received: from unknown (HELO unkown) (::1)
 by skiff.uberspace.de (Haraka/3.0.1) with ESMTPSA;
 Mon, 02 Dec 2024 20:41:54 +0100
From: Julian Ganz <neither@nut.email>
To: qemu-devel@nongnu.org
Cc: Julian Ganz <neither@nut.email>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Alexandre Iooss <erdnaxe@crans.org>,
 Mahmoud Mandour <ma.mandourr@gmail.com>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>
Subject: [RFC PATCH v3 11/11] tests: add plugin asserting correctness of
 discon event's to_pc
Date: Mon,  2 Dec 2024 20:41:37 +0100
Message-ID: <36d316bf3e8b0aca778c5e8d1acde39a7f361946.1733063076.git.neither@nut.email>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <cover.1733063076.git.neither@nut.email>
References: <cover.1733063076.git.neither@nut.email>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Bar: ----
X-Rspamd-Report: REPLY(-4) SUSPICIOUS_RECIPS(1.5) MID_CONTAINS_FROM(1)
 MIME_GOOD(-0.1) BAYES_HAM(-2.999999) R_MISSING_CHARSET(0.5)
X-Rspamd-Score: -4.099999
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=nut.email; s=uberspace;
 h=from:to:cc:subject:date;
 bh=QtNoualSp5HK6fG+v1BpfCUxVztYUqkQxOY+K+yjyko=;
 b=CG74BC7/MzXp7v0ggJFuEg1UG+J9u58DLlQhXqDVmS9ZK82LLgejy6kWi7It27WoNtSpJ5cQE2
 eNuVUuN40Zo2Y/VdxSaHF59mgnm1AJwPrP/uB9fmdDX0R9MnLiThdeOLolnMXKouoHvhvnpOQDHZ
 o5Um+PrQMx97rmGAaEFYtMUPa7uGSmWKFppCC1Ea8ejXLv894KGn0fVpzBMKps2f3Oi2ihwKAsLy
 LhjtnaC+xHUnzqvE8CsU8iH3pyQoi7lYB16Glip9HCzxxA051ATF4iVG7VZBuHIwpaN2QHDD85S5
 lrtY3pErn77TymZVkAZSRna0Vzuk8BxXSbJi9rDRM0IQb7Zuw1RDp/qGHbfITPKLXQzUqVWkTEWP
 roxnBoELl9HOHqn9Q+l2QNWnVFGV9iS2nvFjDvqe4trlOYvCu0guqslC3xCeFyqwN45O9pIKtaLm
 BF2qGVEGL7yWO4EC1gs9WEi/eg1KW0T54wbhAmhJjSZN8kW6MTpRDj/kJwZGTXnZ6wnHr3lSEu/c
 LhA428EQwSIePTA/dQo2O5ezeZ9UWelCKY1anDjip1s7to8BCVaAF+6wpEAfoNjONPVcnjkRGNix
 SwyhNygbFbH5nEi7d+Rt5ju1pmB07bVQTsrpxD6eX52bxy4OqbEmIbLkYZPgApbwO0Fls53wXU3E
 c=
Received-SPF: pass client-ip=185.26.156.114; envelope-from=neither@nut.email;
 helo=mailgate02.uberspace.is
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

We recently introduced plugin API for the registration of callbacks for
discontinuity events, specifically for interrupts, exceptions and host
call events. The callback receives, among other information, the VCPU
index and the PC after the event. This change introduces a test plugin
asserting that particular behaviour.
---
 tests/tcg/plugins/discons.c   | 95 +++++++++++++++++++++++++++++++++++
 tests/tcg/plugins/meson.build |  2 +-
 2 files changed, 96 insertions(+), 1 deletion(-)
 create mode 100644 tests/tcg/plugins/discons.c

diff --git a/tests/tcg/plugins/discons.c b/tests/tcg/plugins/discons.c
new file mode 100644
index 0000000000..54e52f563a
--- /dev/null
+++ b/tests/tcg/plugins/discons.c
@@ -0,0 +1,95 @@
+/*
+ * Copyright (C) 2024, Julian Ganz <neither@nut.email>
+ *
+ * License: GNU GPL, version 2 or later.
+ *   See the COPYING file in the top-level directory.
+ */
+#include <stdio.h>
+
+#include <qemu-plugin.h>
+
+QEMU_PLUGIN_EXPORT int qemu_plugin_version = QEMU_PLUGIN_VERSION;
+
+struct cpu_state {
+    uint64_t next_pc;
+    bool has_next;
+};
+
+static struct qemu_plugin_scoreboard *states;
+
+static bool abort_on_mismatch;
+
+static void vcpu_discon(qemu_plugin_id_t id, unsigned int vcpu_index,
+                        enum qemu_plugin_discon_type type, uint64_t from_pc,
+                        uint64_t to_pc)
+{
+    struct cpu_state *state = qemu_plugin_scoreboard_find(states, vcpu_index);
+    state->next_pc = to_pc;
+    state->has_next = true;
+}
+
+static void insn_exec(unsigned int vcpu_index, void *userdata)
+{
+    struct cpu_state *state = qemu_plugin_scoreboard_find(states, vcpu_index);
+    uint64_t pc = (uint64_t) userdata;
+    GString* report;
+
+    if (state->has_next) {
+        if (state->next_pc != pc) {
+            report = g_string_new("Trap target PC mismatch\n");
+            g_string_append_printf(report,
+                                   "Expected:    %"PRIx64"\nEncountered: %"
+                                   PRIx64"\n",
+                                   state->next_pc, pc);
+            qemu_plugin_outs(report->str);
+            if (abort_on_mismatch) {
+                g_abort();
+            }
+            g_string_free(report, true);
+        }
+        state->has_next = false;
+    }
+}
+
+static void vcpu_tb_trans(qemu_plugin_id_t id, struct qemu_plugin_tb *tb)
+{
+    size_t i;
+    size_t n_insns = qemu_plugin_tb_n_insns(tb);
+
+    for (i = 0; i < n_insns; i++) {
+        struct qemu_plugin_insn * insn = qemu_plugin_tb_get_insn(tb, i);
+        uint64_t pc = qemu_plugin_insn_vaddr(insn);
+        qemu_plugin_register_vcpu_insn_exec_cb(insn, insn_exec,
+                                               QEMU_PLUGIN_CB_NO_REGS,
+                                               (void*) pc);
+    }
+}
+
+QEMU_PLUGIN_EXPORT int qemu_plugin_install(qemu_plugin_id_t id,
+                                           const qemu_info_t *info,
+                                           int argc, char **argv)
+{
+    int i;
+
+    for (i = 0; i < argc; i++) {
+        char *opt = argv[i];
+        g_auto(GStrv) tokens = g_strsplit(opt, "=", 2);
+        if (g_strcmp0(tokens[0], "abort") == 0) {
+            if (!qemu_plugin_bool_parse(tokens[0], tokens[1], &abort_on_mismatch)) {
+                fprintf(stderr, "boolean argument parsing failed: %s\n", opt);
+                return -1;
+            }
+        } else {
+            fprintf(stderr, "option parsing failed: %s\n", opt);
+            return -1;
+        }
+    }
+
+    states = qemu_plugin_scoreboard_new(sizeof(struct cpu_state));
+
+    qemu_plugin_register_vcpu_discon_cb(id, QEMU_PLUGIN_DISCON_ALL,
+                                        vcpu_discon);
+    qemu_plugin_register_vcpu_tb_trans_cb(id, vcpu_tb_trans);
+
+    return 0;
+}
diff --git a/tests/tcg/plugins/meson.build b/tests/tcg/plugins/meson.build
index f847849b1b..f057238da1 100644
--- a/tests/tcg/plugins/meson.build
+++ b/tests/tcg/plugins/meson.build
@@ -1,6 +1,6 @@
 t = []
 if get_option('plugins')
-  foreach i : ['bb', 'empty', 'inline', 'insn', 'mem', 'syscall']
+  foreach i : ['bb', 'discons', 'empty', 'inline', 'insn', 'mem', 'syscall']
     if host_os == 'windows'
       t += shared_module(i, files(i + '.c') + '../../../contrib/plugins/win32_linker.c',
                         include_directories: '../../../include/qemu',
-- 
2.45.2


