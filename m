Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ED1D1E7FDD8
	for <qemu-devel@archiver.kernel.org>; Mon,  2 Feb 2026 21:23:18 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vn1Nj-0005i3-Nb; Mon, 02 Feb 2026 16:22:51 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vn1NA-00059g-Fw
 for qemu-devel@nongnu.org; Mon, 02 Feb 2026 16:22:20 -0500
Received: from mail-wm1-x335.google.com ([2a00:1450:4864:20::335])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vn1N8-0007jk-UP
 for qemu-devel@nongnu.org; Mon, 02 Feb 2026 16:22:16 -0500
Received: by mail-wm1-x335.google.com with SMTP id
 5b1f17b1804b1-482f454be5bso1326725e9.0
 for <qemu-devel@nongnu.org>; Mon, 02 Feb 2026 13:22:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1770067333; x=1770672133; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=LGPgOWqY6NlYrVCwUyVSsX2YgvOrDGLMDph16Mc2NKE=;
 b=Y8DzaG0wG+rDWKl5nAjG5qt1MJjKn/QjEKYI8vdDes1JCNqyLxjytGeLZKLJIsSl1f
 lpuMr+qFEwnw5fxvbT+1+nH37dGbdbYLIFgVrYkj5oo+OGS1yE49WHET6r82laZ6R4mB
 fvNxeNeGNNhk2knHqsSmvQ2ES8ANJEVUTioIf3w9lD7ZEdDCbWWw1DuOOHyl5jRBlS2U
 hB/teHTqTiWQCZLUjPzvbQcAef/9qFY3xSZiA1tVLhb0U5BfIOVlZ8lHrG+4WVxMtDSz
 TakrRrZtwSp1ZU8Vu67zgha8D6f0TJPLDduW+eoN7xeR/l4m8muhy6fXIcH/RcfaR9aK
 CSSA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1770067333; x=1770672133;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=LGPgOWqY6NlYrVCwUyVSsX2YgvOrDGLMDph16Mc2NKE=;
 b=ItKVlxXMpwRnHsrolHX4Pb7cdJ98Orud/w3gwomz/0m4RNU6F2d+8hzQoozv46ksVD
 1BJby8aRogN63xaCFPeOYicfqzY8YDzY/ABjcvrVdkSo4rNhDEK5wD9Lh6Ov4xRUgnHp
 PJj2RMonO5ynZynlfJsETJOxASVJ2s7paSNjOr2xrAxoVWPchor22WXwsF/ZVoiK0bwB
 kj3AhWaDJ5rzAishV9k5Q2/wMPQz4DE1zSTOOnn+MW2NHj0TPyenur0a8EIUQoV6M8Pa
 joEauN/Y6cDok+uaKwQj25TGpfB/uy93iM69WfMfQJkA8/QnHj1gh7tQIwvbnmxw7Si6
 MMug==
X-Gm-Message-State: AOJu0YzDJlQECveP+y1bP8/zZv6Mrws+9O9ZOmakTwOpqBtr4fzzWSCR
 18mYBcact70/uznw70cm3WJwxyjLhGbsOucaILD6HFVlveoyvhN5pl4seUtD2WOAi2VmnexnKeH
 EQ24/XI8=
X-Gm-Gg: AZuq6aJ6Jw3Nqm7o1IxHgATNTcT8XRUxonetTUkh9D0DA1w+lSUYtPDEXek0B1Rnjrv
 xCVJR9CxHr0J8gGSQgiFBrcRQLaROrm9u1y7xsXzk1pk5ejsfv3UEN8Qyq387P544Y4HYZ4gKpX
 wh2DyTIsXOmEVKNJczv3/nrdBoGfuGIDlDc0khnoGRgZReQ3yD4w6hSHgqRh/6Q1h2uLDDOScpx
 +pn6ErWuC+91UIG0VOvldEZ7dCeNq2bDrz3bT3IetfpEZb1UZzPR2eeROZ098ccVtEpmanJeZeG
 /Ak0pRn3qa25Kj9zkbg1vylMxl2mDpkRZ2xm3i38A5tnWIRbISKoT/BoNRoIom7fks39rBxU0xo
 qUD/JtSfSuHGe3MV1qTIsCbY3Wr64LxHveqHgBgaiGNK8wmoxoqwFuenFixlZ47TSF53vnup2Qr
 7iYuByfXCOhuOVDxCDnsyx2F1Ipob28TECrk+tjq505p9m/K2/txkyDrp46nT1
X-Received: by 2002:a05:600c:6303:b0:47e:e59c:67c5 with SMTP id
 5b1f17b1804b1-4830513aed8mr15509575e9.8.1770067333141; 
 Mon, 02 Feb 2026 13:22:13 -0800 (PST)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-48305133689sm14003955e9.12.2026.02.02.13.22.12
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Mon, 02 Feb 2026 13:22:12 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 16/16] monitor: Reduce target-specific methods
Date: Mon,  2 Feb 2026 22:20:19 +0100
Message-ID: <20260202212019.94205-17-philmd@linaro.org>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260202212019.94205-1-philmd@linaro.org>
References: <20260202212019.94205-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::335;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x335.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
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

The following methods don't use target-specific code anymore:
- hmp_compare_cmd()
- monitor_register_hmp()
- monitor_register_hmp_info_hrt()
Move them to hmp.c which is target-agnostic, being built once.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Dr. David Alan Gilbert <dave@treblig.org>
Message-Id: <20260129164039.58472-5-philmd@linaro.org>
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


