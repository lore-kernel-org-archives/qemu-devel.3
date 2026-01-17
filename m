Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0C699C98315
	for <qemu-devel@archiver.kernel.org>; Sat, 17 Jan 2026 16:32:33 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vh9BT-0003gj-SI; Sat, 17 Jan 2026 11:29:55 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vh9BR-0003cF-JA
 for qemu-devel@nongnu.org; Sat, 17 Jan 2026 11:29:53 -0500
Received: from mail-wr1-x433.google.com ([2a00:1450:4864:20::433])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vh9BP-0006Fh-Sb
 for qemu-devel@nongnu.org; Sat, 17 Jan 2026 11:29:53 -0500
Received: by mail-wr1-x433.google.com with SMTP id
 ffacd0b85a97d-431048c4068so1675568f8f.1
 for <qemu-devel@nongnu.org>; Sat, 17 Jan 2026 08:29:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1768667390; x=1769272190; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=VE48XhslujFFPaSi8GGvuDBQGKWSJZ383NSYBz4qQHI=;
 b=jUoCImypK8gVWmReFJoQK0cbADwXsqqK/qLBFUo8PB2i/rmXeWYR1XhkbV7nkeV6vu
 9sWp6efaKjN1OC9U5EqoOxTjTBd+RuKPqtlB1/oI/ingfdfKCnoo3UwkpSKvAXpHZlMO
 BIzA8xK3VwZqYwrBLw4h3Y14rO/YVWP8uJYXlqZ5X8qOvtPcU5NUzNR+pAUY/+PkOUiu
 RbPaSBXNV4XhO3bd6H9Fn2BsgTaiHfOeBwxsIyOncb1CDwo+Zds06zD+FpovBwVSEdFr
 X7xYSzoCH/Ch8IKMzzJVk/h0bDJdgaTFbRJ861/KbvGmSbPs7fCJljs9qC5PMRYApT4E
 /Ebg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1768667390; x=1769272190;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=VE48XhslujFFPaSi8GGvuDBQGKWSJZ383NSYBz4qQHI=;
 b=OP3MgoDrHqXKHO7+/ypdUhDUhvwopdg6NcJ0iIUL3g1KGLQK3FMQ5wyQoiLGwJYSMI
 QzCLqGNQ/3KpJNlCNQ4ZM9xLHIyBwnMbJRTE5dkegf6nvliSrAeQ14SrqtofBhmpgCCD
 rm2mWpdPUNXCGg+lu6kEYp0nU1YcuvQ7eGcF0UiUJwiqxhu4I1G0s4Uot5le/VTh0NiT
 CcaQRIeB/fzjfFPmpcqEOX/GJPMZsH6Z2iJ/J8dhEv43eQABGWtrQx0hm5Ngh4SOTFEG
 uyt5TX65SkKN8YzRG3qACsck60i+KfN6/qdBcBiGPc0yKhFpZdQSratoUncdb8DbTqhL
 6/2A==
X-Gm-Message-State: AOJu0YxFLdZejRJNupz3pQ9+KA/Ma/hzw1hAa8JG/fMPz8Dhr541k3M+
 +H6RxVZAMgxV8yjpTXC91ZUY7YfeSqi8YuS5vnkrdUjFgo8HcdAaIxiQwNVrR1aeAR6CgKKZL0X
 AFbgQKq8=
X-Gm-Gg: AY/fxX6WqgcyNZllrHvlYbvNKaoVwgOyben3AKo/HHCu4+h53L68lKj0HwuZM60kzCY
 F5mNDoyUlIMxU1T+b3MPnbXjnoq1mlaXHcejqea+oS9n93tpXehsNVM/ezwD2rV1CArIdFGSPzZ
 UVGIIgD8VSb3WhK/iPCP/UYPKD9MA6J9CNuL52vfUJWbnk15Y/dUQ/qsKHneZ4yMw1H3YIPKfkh
 nq1nReL8SLC7A92uMJuNQ+8kuddl7rV9EjWhdbNrIdZRKBboZsIf1JbNzDDOo4b8mmrGZh8BWdx
 wX98UaMEiPv8k9zGbXBPu6XVf958V8uR29MtE692Ldq5/zVANsl+l4k8pSHyEBG6hnSs8COuSgQ
 SkhKHTL0zbLxjbRT5eXbEVm9xVArYZwh/5GoUVxAoSBAA3h2YqXynCOoZQCzsQdDgE+jDJHZk2h
 UN3bZyPd8mPFxXDFncA+FWNPB1/NwHGm5rWbOcR0IO+OGR/em/C9jygFG8LjsH
X-Received: by 2002:a05:6000:2dc9:b0:430:2773:84d6 with SMTP id
 ffacd0b85a97d-435695652f7mr8157855f8f.24.1768667389858; 
 Sat, 17 Jan 2026 08:29:49 -0800 (PST)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-4356999824csm11693454f8f.39.2026.01.17.08.29.48
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Sat, 17 Jan 2026 08:29:49 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Richard Henderson <richard.henderson@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 "Dr. David Alan Gilbert" <dave@treblig.org>,
 Markus Armbruster <armbru@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH v2 3/8] monitor: Reduce target-specific methods
Date: Sat, 17 Jan 2026 17:29:21 +0100
Message-ID: <20260117162926.74225-4-philmd@linaro.org>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260117162926.74225-1-philmd@linaro.org>
References: <20260117162926.74225-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::433;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x433.google.com
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


