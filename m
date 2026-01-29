Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 286ADD61017
	for <qemu-devel@archiver.kernel.org>; Thu, 29 Jan 2026 13:43:25 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vlSAA-0001oX-3A; Thu, 29 Jan 2026 08:34:22 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vlS98-0000G9-3Z
 for qemu-devel@nongnu.org; Thu, 29 Jan 2026 08:33:22 -0500
Received: from mail-wr1-x435.google.com ([2a00:1450:4864:20::435])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vlS94-0002co-5k
 for qemu-devel@nongnu.org; Thu, 29 Jan 2026 08:33:17 -0500
Received: by mail-wr1-x435.google.com with SMTP id
 ffacd0b85a97d-432755545fcso752772f8f.1
 for <qemu-devel@nongnu.org>; Thu, 29 Jan 2026 05:33:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1769693591; x=1770298391; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=apOZMf0tEn3rJJPrSfMcVgYQ3RZZMtDVtwPqX5t6dIc=;
 b=zcJ6YLxipDwzdZdCtToJ6GlOD3UcLF9huU0jCo1X+nBh9JRK77nzDFtDKWSENANhgv
 ZG2MUiieMLE1nUzcXpr5s10TjSKIhEE6j8/OUVxIz9mG+i8KIoaYJcbffpHSImWoyzPD
 +joDBCBx9dEo2TwOnKQxDxxudGHnB0Q5QyncTj5pMIEwVJOVf76coZ2SIk79HIKqVmd/
 5rFWQI5M3KYb+W4G94y7MTm0sEp3ut3hskOwgh9RDvgwCnjjEnhoalKMkP93Pv/k8yjB
 kesNx+WXvfRKF2oLSLM2uqO+Foe3tUzV1VMaztHMncn59SrV98ESX/g5n10zO2NsECOQ
 K/LA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1769693591; x=1770298391;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=apOZMf0tEn3rJJPrSfMcVgYQ3RZZMtDVtwPqX5t6dIc=;
 b=w4cV/C6yHauKYqRFgoEeHKoYN36p0nHpdlGyAI4tHQWprFJ5opsK/PrkpVqjlwool1
 leqba5EYaUQAtR49lmciuAV4bQFyrQueudzNEJjBh3y5i6TSNY+0CuVMOND3Q59Bhjrn
 t6IvG4OJhFTddoSeL7+kHg6rvTCHIGlE0/F9fC07xSk24ZuWzsoZZldgmrHfu4ab4ZbX
 BM3Lf07VfKCR98+qzFKY1tm2QFOSMRnlOihy3+VPADiPNZJEh0olgaMmlS4nIyW7Km7x
 npcKlXK1cJQB0OiMJMGfFX/Pq7xnc0LBdrT1hAWbBppdzL7sopWhuWkjFGkzIYOkOAki
 WVNA==
X-Gm-Message-State: AOJu0YwhYNxxKWky9jB3fq1BlJt7aG1Hy8N3BCEItUrhNKTjGY0HqbCN
 XuOYLwLaG0QE21GTpvjkjfTtkwHdurDBCaT7flNXGYz5S7nrJmXSHdnttQuju+e+BYkeH2XUV2T
 XkYFTEWg=
X-Gm-Gg: AZuq6aIOf8AzPcVd0kxv5lVU0BjSxHX9Xw8y2aaZiqEaoGGlN6UaKsfwZjM1k4csGCT
 xzktzxhwG4x8CyhvkvaS++L/Wt5BpclZmc3K35Fk0g+amdMEzY3tWktiSG79qQwKZwvmDXphI0C
 Y8rBK4sKEBcfD/I27cg8fxCNpAU9/W9oqHgly3xd8oN5nm5eb1wxZzkNVqd6qxWddw3G2zfUemT
 ZBbINBG2ch3Pbw5yH+SBbkyyF0Fk/jvh29myuMP0zEo7fV3XwruEMlb7imVFDjdd4xj3Bxb1038
 WOH0Pfvf6t9ZC8yKNZxZp0mF4h3Xle4vStjoUZzJcRVZ2dBk2b5n+oD3h6FETjNJgKJyLlP8vOU
 UIImWMFKbLC1ipqoXZj4Cv7YmNAJi7s85737/vgbwDQDuv6gcXH2SfsIRikpqPBbdZ9/N+jqtuB
 svu19xhfO4n63R09/6zS+u1dA9899SVZ5ciUJ3tna8slHyVGbBu8lM+DFi/1av
X-Received: by 2002:a05:6000:2401:b0:435:97b2:a9b with SMTP id
 ffacd0b85a97d-435dd1c0cb9mr12196567f8f.37.1769693591265; 
 Thu, 29 Jan 2026 05:33:11 -0800 (PST)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-435e1322f40sm14195715f8f.34.2026.01.29.05.33.10
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Thu, 29 Jan 2026 05:33:10 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>, qemu-riscv@nongnu.org,
 Richard Henderson <richard.henderson@linaro.org>, qemu-ppc@nongnu.org,
 "Dr. David Alan Gilbert" <dave@treblig.org>
Subject: [PATCH v4 4/9] monitor: Reduce target-specific methods
Date: Thu, 29 Jan 2026 14:32:36 +0100
Message-ID: <20260129133241.35990-5-philmd@linaro.org>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260129133241.35990-1-philmd@linaro.org>
References: <20260129133241.35990-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::435;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x435.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

The following methods don't use target-specific code anymore:
- hmp_compare_cmd()
- monitor_register_hmp()
- monitor_register_hmp_info_hrt()
Move them to hmp.c which is target-agnostic, being built once.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Dr. David Alan Gilbert <dave@treblig.org>
---
 monitor/hmp-target.c | 57 --------------------------------------------
 monitor/hmp.c        | 55 ++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 55 insertions(+), 57 deletions(-)

diff --git a/monitor/hmp-target.c b/monitor/hmp-target.c
index 59c60d13b52..420969bd6eb 100644
--- a/monitor/hmp-target.c
+++ b/monitor/hmp-target.c
@@ -33,8 +33,6 @@
 #include "qapi/qapi-commands-control.h"
 #include "qapi/qapi-commands-misc.h"
 #include "qapi/qapi-commands-machine.h"
-#include "qapi/error.h"
-#include "qemu/cutils.h"
 
 #if defined(TARGET_S390X)
 #include "hw/s390x/storage-keys.h"
@@ -44,29 +42,6 @@
 /* Make devices configuration available for use in hmp-commands*.hx templates */
 #include CONFIG_DEVICES
 
-/**
- * Is @name in the '|' separated list of names @list?
- */
-int hmp_compare_cmd(const char *name, const char *list)
-{
-    const char *p, *pstart;
-    int len;
-    len = strlen(name);
-    p = list;
-    for (;;) {
-        pstart = p;
-        p = qemu_strchrnul(p, '|');
-        if ((p - pstart) == len && !memcmp(pstart, name, len)) {
-            return 1;
-        }
-        if (*p == '\0') {
-            break;
-        }
-        p++;
-    }
-    return 0;
-}
-
 /* Please update hmp-commands.hx when adding or changing commands */
 static HMPCommand hmp_info_cmds[] = {
 #include "hmp-commands-info.h"
@@ -147,35 +122,3 @@ static void __attribute__((__constructor__)) sortcmdlist(void)
           sizeof(*hmp_info_cmds),
           compare_mon_cmd);
 }
-
-void monitor_register_hmp(const char *name, bool info,
-                          void (*cmd)(Monitor *mon, const QDict *qdict))
-{
-    HMPCommand *table = hmp_cmds_for_target(info);
-
-    while (table->name != NULL) {
-        if (strcmp(table->name, name) == 0) {
-            g_assert(table->cmd == NULL && table->cmd_info_hrt == NULL);
-            table->cmd = cmd;
-            return;
-        }
-        table++;
-    }
-    g_assert_not_reached();
-}
-
-void monitor_register_hmp_info_hrt(const char *name,
-                                   HumanReadableText *(*handler)(Error **errp))
-{
-    HMPCommand *table = hmp_cmds_for_target(true);
-
-    while (table->name != NULL) {
-        if (strcmp(table->name, name) == 0) {
-            g_assert(table->cmd == NULL && table->cmd_info_hrt == NULL);
-            table->cmd_info_hrt = handler;
-            return;
-        }
-        table++;
-    }
-    g_assert_not_reached();
-}
diff --git a/monitor/hmp.c b/monitor/hmp.c
index 17e5756986f..0a5bbf82197 100644
--- a/monitor/hmp.c
+++ b/monitor/hmp.c
@@ -1497,3 +1497,58 @@ void monitor_init_hmp(Chardev *chr, bool use_readline, Error **errp)
                              monitor_event, NULL, &mon->common, NULL, true);
     monitor_list_append(&mon->common);
 }
+
+/**
+ * Is @name in the '|' separated list of names @list?
+ */
+int hmp_compare_cmd(const char *name, const char *list)
+{
+    const char *p, *pstart;
+    int len;
+    len = strlen(name);
+    p = list;
+    for (;;) {
+        pstart = p;
+        p = qemu_strchrnul(p, '|');
+        if ((p - pstart) == len && !memcmp(pstart, name, len)) {
+            return 1;
+        }
+        if (*p == '\0') {
+            break;
+        }
+        p++;
+    }
+    return 0;
+}
+
+void monitor_register_hmp(const char *name, bool info,
+                          void (*cmd)(Monitor *mon, const QDict *qdict))
+{
+    HMPCommand *table = hmp_cmds_for_target(info);
+
+    while (table->name != NULL) {
+        if (strcmp(table->name, name) == 0) {
+            g_assert(table->cmd == NULL && table->cmd_info_hrt == NULL);
+            table->cmd = cmd;
+            return;
+        }
+        table++;
+    }
+    g_assert_not_reached();
+}
+
+void monitor_register_hmp_info_hrt(const char *name,
+                                   HumanReadableText *(*handler)(Error **errp))
+{
+    HMPCommand *table = hmp_cmds_for_target(true);
+
+    while (table->name != NULL) {
+        if (strcmp(table->name, name) == 0) {
+            g_assert(table->cmd == NULL && table->cmd_info_hrt == NULL);
+            table->cmd_info_hrt = handler;
+            return;
+        }
+        table++;
+    }
+    g_assert_not_reached();
+}
-- 
2.52.0


