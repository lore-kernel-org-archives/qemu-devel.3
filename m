Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A7368E69E81
	for <qemu-devel@archiver.kernel.org>; Mon,  2 Dec 2024 19:28:16 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tIC4v-0005jM-LZ; Mon, 02 Dec 2024 14:27:31 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <neither@nut.email>) id 1tIC4p-0005iP-Gv
 for qemu-devel@nongnu.org; Mon, 02 Dec 2024 14:27:24 -0500
Received: from mailgate02.uberspace.is ([2a00:d0c0:200:0:1c7b:a6ff:fee0:8ea4])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <neither@nut.email>) id 1tIC4n-0001vh-LR
 for qemu-devel@nongnu.org; Mon, 02 Dec 2024 14:27:23 -0500
Received: from skiff.uberspace.de (skiff.uberspace.de [185.26.156.131])
 by mailgate02.uberspace.is (Postfix) with ESMTPS id 848321809F2
 for <qemu-devel@nongnu.org>; Mon,  2 Dec 2024 20:27:13 +0100 (CET)
Received: (qmail 7147 invoked by uid 990); 2 Dec 2024 19:27:13 -0000
Authentication-Results: skiff.uberspace.de;
	auth=pass (plain)
Received: from unknown (HELO unkown) (::1)
 by skiff.uberspace.de (Haraka/3.0.1) with ESMTPSA;
 Mon, 02 Dec 2024 20:27:13 +0100
From: Julian Ganz <neither@nut.email>
To: qemu-devel@nongnu.org
Cc: Julian Ganz <neither@nut.email>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Alexandre Iooss <erdnaxe@crans.org>,
 Mahmoud Mandour <ma.mandourr@gmail.com>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>
Subject: [RFC PATCH v3 04/11] contrib/plugins: add plugin showcasing new
 dicontinuity related API
Date: Mon,  2 Dec 2024 20:26:45 +0100
Message-ID: <fa02142d349ceb6c95e80301a7f5c57ae5df6329.1733063076.git.neither@nut.email>
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
 bh=g9B6AqNiMy12KKOQEL7zgcI6TA//xAnrob0uJmdHo/Y=;
 b=eXchSWQUltJXuL/BJ/8EBNxJYKN4f4DxMv7RtVY06hGkxm/7AI1Nngn1WZRjpex4bKslfxVHNI
 pVJySXWxT1twdxJIigguWPS4O2cXfmvTffV8crBi7Uz7SixOAmC5FarTSbcNO/n4Li+mq3FCxtTt
 aZgXND99w7s7ZKCtKHAnoQ7p7XBZUAqqpEj1r9ZrWAMEcPlsCKmjpAF2FIbEYIsiQ7/xOtLmw987
 w5eFD6wamcNLvd6HUC8cHCYkQVBg1NDUuPUOeCiTsaXmvos7rdwx1uXxaaU5qGZ0D7xgQCMGyxUI
 r1A8nW6u2y8Flu3WJaQC5fs/haf2GocNuW1bdJHxSG7U1gNAUn+4T9+zsSPg8zkBwXLM/Bgt/lIU
 fZSJTIR4+7uCQphWVjDSNXIAVxL/hQUc3ThC8Pi00uhZbIfojwmFthQ04RChLAiGpzAd0UFF1c9N
 8p7XHZbndq/5QW4BDvvpp8C3DBbJXo6mVQwHiYwyrklaQPgjsvsr076xfdc6POCxPcZCv87WkWiH
 5NyeSjr55+vNJ3J6yMA5oJnnsPddO17a4YYh4drG0XrQ2B6JXjPoUTXIfK6z+NZvag0V0nvwWyI8
 9y1Fcm/fFVinmmasVus5sjl9VL8Ej2ffsjuK3HTJy5dPxr4UiAjSjf5oKmayTLK/ToU0FEFuCJ1d
 0=
Received-SPF: pass client-ip=2a00:d0c0:200:0:1c7b:a6ff:fee0:8ea4;
 envelope-from=neither@nut.email; helo=mailgate02.uberspace.is
X-Spam_score_int: -10
X-Spam_score: -1.1
X-Spam_bar: -
X-Spam_report: (-1.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, NEW_PRODUCTS=1,
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
---
 contrib/plugins/meson.build |  3 +-
 contrib/plugins/traps.c     | 96 +++++++++++++++++++++++++++++++++++++
 2 files changed, 98 insertions(+), 1 deletion(-)
 create mode 100644 contrib/plugins/traps.c

diff --git a/contrib/plugins/meson.build b/contrib/plugins/meson.build
index 63a32c2b4f..9a3015e1c1 100644
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
index 0000000000..ecd4beac5f
--- /dev/null
+++ b/contrib/plugins/traps.c
@@ -0,0 +1,96 @@
+/*
+ * Copyright (C) 2024, Julian Ganz <neither@nut.email>
+ *
+ * Traps - count traps
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
+    TrapCounters* rec = qemu_plugin_scoreboard_find(traps, vcpu_index);
+    rec->active = true;
+}
+
+static void vcpu_discon(qemu_plugin_id_t id, unsigned int vcpu_index,
+                        enum qemu_plugin_discon_type type, uint64_t from_pc,
+                        uint64_t to_pc)
+{
+    TrapCounters* rec = qemu_plugin_scoreboard_find(traps, vcpu_index);
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
+        /* unreachable */
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
+    qemu_plugin_register_vcpu_discon_cb(id, QEMU_PLUGIN_DISCON_TRAPS,
+                                        vcpu_discon);
+
+    qemu_plugin_register_atexit_cb(id, plugin_exit, NULL);
+
+    return 0;
+}
-- 
2.45.2


