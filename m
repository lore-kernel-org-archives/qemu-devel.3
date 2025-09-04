Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 65930CA1013
	for <qemu-devel@archiver.kernel.org>; Thu,  4 Sep 2025 20:52:27 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uuGrw-0003RW-C4; Thu, 04 Sep 2025 16:47:44 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <neither@nut.email>) id 1uuGrr-0003Q8-7M
 for qemu-devel@nongnu.org; Thu, 04 Sep 2025 16:47:39 -0400
Received: from mailgate01.uberspace.is ([95.143.172.20])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <neither@nut.email>) id 1uuGrj-0000gm-Nr
 for qemu-devel@nongnu.org; Thu, 04 Sep 2025 16:47:38 -0400
Received: from skiff.uberspace.de (skiff.uberspace.de [185.26.156.131])
 by mailgate01.uberspace.is (Postfix) with ESMTPS id 80CFC60C0C
 for <qemu-devel@nongnu.org>; Thu,  4 Sep 2025 22:47:20 +0200 (CEST)
Received: (qmail 32561 invoked by uid 990); 4 Sep 2025 20:47:20 -0000
Authentication-Results: skiff.uberspace.de;
	auth=pass (plain)
Received: from unknown (HELO unkown) (::1)
 by skiff.uberspace.de (Haraka/3.0.1) with ESMTPSA;
 Thu, 04 Sep 2025 22:47:20 +0200
From: Julian Ganz <neither@nut.email>
To: qemu-devel@nongnu.org
Cc: Julian Ganz <neither@nut.email>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Alexandre Iooss <erdnaxe@crans.org>,
 Mahmoud Mandour <ma.mandourr@gmail.com>
Subject: [PATCH v6 04/25] contrib/plugins: add plugin showcasing new
 dicontinuity related API
Date: Thu,  4 Sep 2025 22:46:41 +0200
Message-ID: <084ccb18733dbacb68a8a107ff10ae0f96045772.1757018626.git.neither@nut.email>
X-Mailer: git-send-email 2.49.1
In-Reply-To: <cover.1757018626.git.neither@nut.email>
References: <cover.1757018626.git.neither@nut.email>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Bar: ----
X-Rspamd-Report: REPLY(-4) SUSPICIOUS_RECIPS(1.5) MID_CONTAINS_FROM(1)
 MIME_GOOD(-0.1) BAYES_HAM(-2.999999) R_MISSING_CHARSET(0.5)
X-Rspamd-Score: -4.099999
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=nut.email; s=uberspace;
 h=from:to:cc:subject:date;
 bh=wqGaQOoNh2xzOYJ7EncGsJB5XEOWy/xryA/rfjKxSzE=;
 b=n7tzaE22TpUI10G5A806ttehBh+s4pHPDQT947hiMGksLHaJVcHwK7MI3/gZm2VgDQ4kXVdrxs
 HnRSjAzAluG1tncDO+Y1p8LMfmsEWck3+NRTod7R8Pt9rP+4A0x+RPnCRWCn+2dFWOU/wuKZ62HI
 D6oih0Jh8rYTgn1m4BRjMCErMYkJt7gYarCYFq9jXYS57PlUoGmA4YCbEOE+kJxZH114Ku1+FJpa
 v1F4Fn/5y8GUrT94St6tl7/3H9/q8WHwqgiuDlqxfpbOP9b1bMexJtHf/9+XzunCg7xm0jaSl/Y3
 cefSb4LJvSUpDX7E5VFPiVHa6u5vCGu07nkJAdCSJeahuG5Ps/SklVVupGtHyPthY27l3Pq1JvfY
 4DnB771779ugB8Bv+KCCFMcJM04wrkPOvvBBxJZJrsV2AU5z5iilk59uWmg80Jpk5BzkCpgQf4ud
 SkTLboWeahzpRHn2kyoVoWfmiFDdvrH3JM6FaDAPTcYDRmYLM/Y20gNH8bgAgZSlBlBJ1GMBVTWu
 3vdRL1V+IS6ofrdKSmZ4uFZQi4CzpYJ5WeCUMMV8jWb8rLB8664kB6AyigmERH1G5qJSbCKChTof
 96N9gPrslitWoC6z7dWZOr7ZNAYqJjK9bNmkLZl8PSdnDVKVzYL6pT9uiTsms/Vi9qnvTJfTofGC
 U=
Received-SPF: pass client-ip=95.143.172.20; envelope-from=neither@nut.email;
 helo=mailgate01.uberspace.is
X-Spam_score_int: -7
X-Spam_score: -0.8
X-Spam_bar: /
X-Spam_report: (-0.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, NEW_PRODUCTS=1.249,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

We recently introduced new plugin API for registration of discontinuity
related callbacks. This change introduces a minimal plugin showcasing
the new API. It simply counts the occurances of interrupts, exceptions
and host calls per CPU and reports the counts when exitting.

Reviewed-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
Signed-off-by: Julian Ganz <neither@nut.email>
---
 contrib/plugins/meson.build |  3 +-
 contrib/plugins/traps.c     | 84 +++++++++++++++++++++++++++++++++++++
 docs/about/emulation.rst    |  8 ++++
 3 files changed, 94 insertions(+), 1 deletion(-)
 create mode 100644 contrib/plugins/traps.c

diff --git a/contrib/plugins/meson.build b/contrib/plugins/meson.build
index 1876bc7843..85d3520f0c 100644
--- a/contrib/plugins/meson.build
+++ b/contrib/plugins/meson.build
@@ -1,5 +1,6 @@
 contrib_plugins = ['bbv', 'cache', 'cflow', 'drcov', 'execlog', 'hotblocks',
-                   'hotpages', 'howvec', 'hwprofile', 'ips', 'stoptrigger']
+                   'hotpages', 'howvec', 'hwprofile', 'ips', 'stoptrigger',
+                   'traps']
 if host_os != 'windows'
   # lockstep uses socket.h
   contrib_plugins += 'lockstep'
diff --git a/contrib/plugins/traps.c b/contrib/plugins/traps.c
new file mode 100644
index 0000000000..c8672d8b1b
--- /dev/null
+++ b/contrib/plugins/traps.c
@@ -0,0 +1,84 @@
+/*
+ * SPDX-License-Identifier: GPL-2.0-or-later
+ * Copyright (C) 2025, Julian Ganz <neither@nut.email>
+ *
+ * Traps - count traps
+ *
+ * Count the number of interrupts (asyncronous events), exceptions (synchronous
+ * events) and host calls (e.g. semihosting) per cpu and report those counts on
+ * exit.
+ */
+
+#include <stdio.h>
+
+#include <qemu-plugin.h>
+
+QEMU_PLUGIN_EXPORT int qemu_plugin_version = QEMU_PLUGIN_VERSION;
+
+typedef struct {
+    uint64_t interrupts;
+    uint64_t exceptions;
+    uint64_t hostcalls;
+} TrapCounters;
+
+static struct qemu_plugin_scoreboard *traps;
+
+static void vcpu_discon(qemu_plugin_id_t id, unsigned int vcpu_index,
+                        enum qemu_plugin_discon_type type, uint64_t from_pc,
+                        uint64_t to_pc)
+{
+    TrapCounters *rec = qemu_plugin_scoreboard_find(traps, vcpu_index);
+    switch (type) {
+    case QEMU_PLUGIN_DISCON_INTERRUPT:
+        rec->interrupts++;
+        break;
+    case QEMU_PLUGIN_DISCON_EXCEPTION:
+        rec->exceptions++;
+        break;
+    case QEMU_PLUGIN_DISCON_HOSTCALL:
+        rec->hostcalls++;
+        break;
+    default:
+        g_assert_not_reached();
+        break;
+    }
+}
+
+static void plugin_exit(qemu_plugin_id_t id, void *p)
+{
+    g_autoptr(GString) report;
+    report = g_string_new("VCPU, interrupts, exceptions, hostcalls\n");
+    int max_vcpus = qemu_plugin_num_vcpus();
+    int vcpu;
+
+    for (vcpu = 0; vcpu < max_vcpus; vcpu++) {
+        TrapCounters *rec = qemu_plugin_scoreboard_find(traps, vcpu);
+        g_string_append_printf(report,
+                               "% 4d, % 10"PRId64", % 10"PRId64", % 10"PRId64
+                               "\n", vcpu, rec->interrupts, rec->exceptions,
+                               rec->hostcalls);
+    }
+
+    qemu_plugin_outs(report->str);
+    qemu_plugin_scoreboard_free(traps);
+}
+
+QEMU_PLUGIN_EXPORT
+int qemu_plugin_install(qemu_plugin_id_t id, const qemu_info_t *info,
+                        int argc, char **argv)
+{
+    if (!info->system_emulation) {
+        fputs("trap plugin can only be used in system emulation mode.\n",
+              stderr);
+        return -1;
+    }
+
+    traps = qemu_plugin_scoreboard_new(sizeof(TrapCounters));
+
+    qemu_plugin_register_vcpu_discon_cb(id, QEMU_PLUGIN_DISCON_ALL,
+                                        vcpu_discon);
+
+    qemu_plugin_register_atexit_cb(id, plugin_exit, NULL);
+
+    return 0;
+}
diff --git a/docs/about/emulation.rst b/docs/about/emulation.rst
index 456d01d5b0..fb99563c04 100644
--- a/docs/about/emulation.rst
+++ b/docs/about/emulation.rst
@@ -816,6 +816,14 @@ This plugin can limit the number of Instructions Per Second that are executed::
       The lower the number the more accurate time will be, but the less efficient the plugin.
       Defaults to ips/10
 
+Count traps
+...........
+
+``contrib/plugins/traps.c``
+
+This plugin counts the number of interrupts (asyncronous events), exceptions
+(synchronous events) and host calls (e.g. semihosting) per cpu.
+
 Other emulation features
 ------------------------
 
-- 
2.49.1


