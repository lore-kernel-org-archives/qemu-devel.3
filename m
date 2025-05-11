Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1E76EC3ABCB
	for <qemu-devel@archiver.kernel.org>; Sun, 11 May 2025 13:18:12 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uE6WD-0006Q8-9q; Sun, 11 May 2025 09:15:01 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <neither@nut.email>) id 1uE6WA-0006P7-Ko
 for qemu-devel@nongnu.org; Sun, 11 May 2025 09:14:58 -0400
Received: from mailgate02.uberspace.is ([2a00:d0c0:200:0:1c7b:a6ff:fee0:8ea4])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <neither@nut.email>) id 1uE6W8-0006mL-Dc
 for qemu-devel@nongnu.org; Sun, 11 May 2025 09:14:58 -0400
Received: from skiff.uberspace.de (skiff.uberspace.de [185.26.156.131])
 by mailgate02.uberspace.is (Postfix) with ESMTPS id 75463180057
 for <qemu-devel@nongnu.org>; Sun, 11 May 2025 15:14:47 +0200 (CEST)
Received: (qmail 25958 invoked by uid 990); 11 May 2025 13:14:47 -0000
Authentication-Results: skiff.uberspace.de;
	auth=pass (plain)
Received: from unknown (HELO unkown) (::1)
 by skiff.uberspace.de (Haraka/3.0.1) with ESMTPSA;
 Sun, 11 May 2025 15:14:47 +0200
From: Julian Ganz <neither@nut.email>
To: qemu-devel@nongnu.org
Cc: Julian Ganz <neither@nut.email>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Alexandre Iooss <erdnaxe@crans.org>,
 Mahmoud Mandour <ma.mandourr@gmail.com>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>
Subject: [PATCH v4 04/23] contrib/plugins: add plugin showcasing new
 dicontinuity related API
Date: Sun, 11 May 2025 15:13:56 +0200
Message-ID: <4ed6d35c186719fd20d4abe5c73b80b0901a96fa.1746968215.git.neither@nut.email>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <cover.1746968215.git.neither@nut.email>
References: <cover.1746968215.git.neither@nut.email>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Bar: ----
X-Rspamd-Report: REPLY(-4) SUSPICIOUS_RECIPS(1.5) MID_CONTAINS_FROM(1)
 MIME_GOOD(-0.1) BAYES_HAM(-3) R_MISSING_CHARSET(0.5)
X-Rspamd-Score: -4.1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=nut.email; s=uberspace;
 h=from:to:cc:subject:date;
 bh=7wLwP/GmvMZE+Nx/zxGdT34rel9HqnYnj6QSDKPryA4=;
 b=jWAhDfKN5N8fFugm/hEoIt5X5khi8VoNowGXVNs0u7Ul37gddrWJl3KiqROSfbQ/Ka+5yKO+l+
 zrjV6BB8p9zmlD2CTNRnE7Y8R7aYs4/asZswBUSpldmOvwEPADVZ+51eWPlOrV7ZOxSoPDoUVgUe
 jc/fRYx+5XPjsCmSS3oy8MBiEOOLdtJoLGsLMzui7wfm/GPaIi5Ffg30wexWEvlQVXpo0dtb0lIn
 GCJSTnD2BbkdTTOpKYfiUqvUU5Wbu/wFakxnS0Lzq+8+jM616Fby0Vj9TlWxURU8eulDeLaU9V0d
 at7h2HQojvDbrnNDyMHN2YAVRr8pxnWL7WMiYJpV52Qb5ReC9yP6t943KMHIiYmhXX/3bteYPWOY
 T/qxiwO4rXtC9mqWuu3M+RPFxIo5BT6FSa+KzkX4V4TfQi6G4Z0TBGnUzsTmLSt4/DKnhoZzCNXU
 g/UtcLy/pkBKZoioW6ivN/GM4WOEM7hrAY41ykajq3Q5U8mwfdRvCeHMqprGW1Lct9JD3auI9b9a
 sVixz2xSUZR2eS2CIlcPdlqeagjeE38tJ5ZD14yWvDccwQ6rpuI5YSNlWZijiILEHQfZ6WMG83fR
 +XU1q49SgVMttp5voHqGdj//34jrQ2wvsWAMsGFBfIGMFcDSG4uhToSVCSvN6FZ+mKOU2aKKVv7H
 Q=
Received-SPF: pass client-ip=2a00:d0c0:200:0:1c7b:a6ff:fee0:8ea4;
 envelope-from=neither@nut.email; helo=mailgate02.uberspace.is
X-Spam_score_int: -8
X-Spam_score: -0.9
X-Spam_bar: /
X-Spam_report: (-0.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, NEW_PRODUCTS=1.249,
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

Signed-off-by: Julian Ganz <neither@nut.email>
---
 contrib/plugins/meson.build |   3 +-
 contrib/plugins/traps.c     | 100 ++++++++++++++++++++++++++++++++++++
 docs/about/emulation.rst    |   8 +++
 3 files changed, 110 insertions(+), 1 deletion(-)
 create mode 100644 contrib/plugins/traps.c

diff --git a/contrib/plugins/meson.build b/contrib/plugins/meson.build
index fa8a426c8b..327b48c888 100644
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
index 0000000000..5fa5a853ee
--- /dev/null
+++ b/contrib/plugins/traps.c
@@ -0,0 +1,100 @@
+/*
+ * Copyright (C) 2025, Julian Ganz <neither@nut.email>
+ *
+ * Traps - count traps
+ *
+ * Count the number of interrupts (asyncronous events), exceptions (synchronous
+ * events) and host calls (e.g. semihosting) per cpu and report those counts on
+ * exit.
+ *
+ * License: GNU GPL, version 2 or later.
+ *   See the COPYING file in the top-level directory.
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
+    bool active;
+} TrapCounters;
+
+static struct qemu_plugin_scoreboard *traps;
+static size_t max_vcpus;
+
+static void vcpu_init(qemu_plugin_id_t id, unsigned int vcpu_index)
+{
+    TrapCounters *rec = qemu_plugin_scoreboard_find(traps, vcpu_index);
+    rec->active = true;
+}
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
+    int vcpu;
+
+    for (vcpu = 0; vcpu < max_vcpus; vcpu++) {
+        TrapCounters *rec = qemu_plugin_scoreboard_find(traps, vcpu);
+        if (rec->active) {
+            g_string_append_printf(report,
+                                   "% 4d, % 10"PRId64", % 10"PRId64", % 10"
+                                   PRId64"\n",
+                                   vcpu,
+                                   rec->interrupts, rec->exceptions,
+                                   rec->hostcalls);
+        }
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
+    max_vcpus = info->system.max_vcpus;
+    traps = qemu_plugin_scoreboard_new(sizeof(TrapCounters));
+    qemu_plugin_register_vcpu_init_cb(id, vcpu_init);
+    qemu_plugin_vcpu_for_each(id, vcpu_init);
+
+    qemu_plugin_register_vcpu_discon_cb(id, QEMU_PLUGIN_DISCON_ALL,
+                                        vcpu_discon);
+
+    qemu_plugin_register_atexit_cb(id, plugin_exit, NULL);
+
+    return 0;
+}
diff --git a/docs/about/emulation.rst b/docs/about/emulation.rst
index a72591ee4d..f985fce8ec 100644
--- a/docs/about/emulation.rst
+++ b/docs/about/emulation.rst
@@ -812,6 +812,14 @@ This plugin can limit the number of Instructions Per Second that are executed::
     - Maximum number of instructions per cpu that can be executed in one second.
       The plugin will sleep when the given number of instructions is reached.
 
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
2.49.0


