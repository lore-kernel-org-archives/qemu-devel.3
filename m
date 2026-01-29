Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A6CD8D3F09D
	for <qemu-devel@archiver.kernel.org>; Thu, 29 Jan 2026 16:42:08 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vlV54-0000rL-6X; Thu, 29 Jan 2026 11:41:18 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vlV50-0000pC-Fa
 for qemu-devel@nongnu.org; Thu, 29 Jan 2026 11:41:14 -0500
Received: from mail-wr1-x435.google.com ([2a00:1450:4864:20::435])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vlV4w-0005DA-CL
 for qemu-devel@nongnu.org; Thu, 29 Jan 2026 11:41:13 -0500
Received: by mail-wr1-x435.google.com with SMTP id
 ffacd0b85a97d-430f3ef2d37so1021124f8f.3
 for <qemu-devel@nongnu.org>; Thu, 29 Jan 2026 08:41:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1769704868; x=1770309668; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=apOZMf0tEn3rJJPrSfMcVgYQ3RZZMtDVtwPqX5t6dIc=;
 b=nSTtIq5mI2EdcNH4EX/maPJ6OlioUUB7Z1Xq8uUOhZZw4lGMKzkOHYhy7sO3zDZhLG
 zoZfPKLC497RO5g2qbdO7Rr6emgQhw038YnA9DUUX+C7qsvKLrhoSon6QsrnmPDz8ZN3
 jGWWawK8CjYKoeb2f964D143MzAF6trorMRIPfE//lVH6atYvlbp/WxXS2JsB0cwBXGm
 CXggFqdFqtYpvB40j0tazKoX3WfvnyyESil5CM4ew82uAfzWBP7cTxrP/5SussPBa/VX
 edCUk9rr8Rqb6MR21EEwODZWMlCvTmhHtdDMG+/VljwDYtIU3X4ywEQ4Jy1Hlnv+e/gd
 uRvQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1769704868; x=1770309668;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=apOZMf0tEn3rJJPrSfMcVgYQ3RZZMtDVtwPqX5t6dIc=;
 b=cdT+Mqtf1On1dCbKvKwaXHk3miCKWR1D2GBBlj0fx1l8BUgoHGReAVa0kJI9rYr6hB
 pBd6k5mBje3Zeb0lMov0X8/yaOvnVKpxMVOLmsZYVzMCFoOVLdK6kjoo619+oi3wpig7
 KKrbyfjgouZKNdWvFItg+R01Gzcx1Xaw6jLtDol5uuQ2+heUzuP5fhDFxNlzEPLzWYjf
 nduxxS2qe6XApu3iDzbFwTUb4+Fo4MSjSRzGsZsRWb1sgcXLTDVq7NHN+QKHfbjVXrse
 OFpEv6vK9qsEHPicnmQjnOjNZIxFtW/6vVD72Kc0HWU0WYbdx7zfLSBqcVX7LQqJCla8
 y/ng==
X-Gm-Message-State: AOJu0YyGJUBLpaYnkZeRWaAeS7IjYGyO4sFAd1c2fi4s9nILqJTabQqs
 ZXeJ1Z8LeQYIHUXL8upOsRjNXNrD51WEMdZaficR1CXBcVxxWx7ImjukuzcZ9ALUK2ITBj0BN+K
 pduugSV0=
X-Gm-Gg: AZuq6aID1coWJNKwMgYuXbkRoOLSfngX7HDsFb2+BbjGQ9qbTA8OdL4SwRyA6kJu+YM
 SHUXUT4VxTCdbF5On42+ODa92k/UOuq6VNCWx5R5yro8T4nSgZvYieS9MIG3zEpaYMejNBKT5LS
 JsAwZUpYsx6lFdTTfKXm6xF/LSJoVT+6OSN5KdqojFn7ZMyWJDelc8KhBtxAAsgxeprV+hZ/8MQ
 +AHEUL4TTSJAjKnBCgFR4uHIv/QJ9cdAdzCNiSJVwS8sB/lOqljGjQUJmGRgLa0qkBDJ7zoLBCV
 UCmqtcmpLmJ4MxN2JVQWJVuG5RYM5n1DlLQFc2LUoYLlAWCfowRj4fM6HDhjUxwgWQevsjjJMMf
 LYfymG99Ezngg5bvbPmoMhQD7/xQW/XHUr0jCJIE+QkKQgHB0JyO2C+AMD6XWOrlWAbxz3YE0Mu
 O3yrJaPjCsZZmKnzDL1ijHDpfPg3/oNa6nOmEkVfVHK8feS2cQvd/kSn6W/jpqDXGBov/y0IQ=
X-Received: by 2002:a05:6000:3112:b0:435:db9b:5882 with SMTP id
 ffacd0b85a97d-435f3a62eefmr264688f8f.6.1769704867997; 
 Thu, 29 Jan 2026 08:41:07 -0800 (PST)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-435e10edfe7sm15267011f8f.14.2026.01.29.08.41.07
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Thu, 29 Jan 2026 08:41:07 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: "Dr. David Alan Gilbert" <dave@treblig.org>,
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>, qemu-riscv@nongnu.org,
 Richard Henderson <richard.henderson@linaro.org>, qemu-ppc@nongnu.org
Subject: [PATCH v5 4/9] monitor: Reduce target-specific methods
Date: Thu, 29 Jan 2026 17:40:33 +0100
Message-ID: <20260129164039.58472-5-philmd@linaro.org>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260129164039.58472-1-philmd@linaro.org>
References: <20260129164039.58472-1-philmd@linaro.org>
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


