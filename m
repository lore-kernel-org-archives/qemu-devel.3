Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 03211CCF2E7
	for <qemu-devel@archiver.kernel.org>; Mon, 19 Jan 2026 11:04:57 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vhn3c-0007IP-IV; Mon, 19 Jan 2026 06:04:28 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vhn3a-0007Dj-Eo
 for qemu-devel@nongnu.org; Mon, 19 Jan 2026 06:04:26 -0500
Received: from mail-wr1-x436.google.com ([2a00:1450:4864:20::436])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vhn3Y-0006ZP-Io
 for qemu-devel@nongnu.org; Mon, 19 Jan 2026 06:04:26 -0500
Received: by mail-wr1-x436.google.com with SMTP id
 ffacd0b85a97d-42fbbc3df8fso2120784f8f.2
 for <qemu-devel@nongnu.org>; Mon, 19 Jan 2026 03:04:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1768820663; x=1769425463; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=apOZMf0tEn3rJJPrSfMcVgYQ3RZZMtDVtwPqX5t6dIc=;
 b=RsOBiFDk77TNCR35oaHkp0D4TwL96cEQaEMwTcqeRj95xO1humRsQ8hFzXnyyadSTl
 yF/TDE4TcZ8b9wTnWCfkgM0JgoBvRD6BMpCn38IQTdjnzX4eIfBsW0/zlrgGwxjoK5Wg
 W1ScjY2DQTfpE5IXRJiHzXuRfeE368+0jMcQVKXvzamnABxmcGzU6DIGnxN2hOVt64Z2
 JXZrQlxxOiq1xFyzr74YVQTL2ZD9Hq61c3/j5dvQtq72Yx8m1V+xoh5Q+CPoWF21q9Md
 sHNuK5BGEM9uMXoXdnNv2Tn40FBNmrqG8LK/Gs0SWhBPG5EIk6zD8yiukA5kRHfB9uWO
 uWQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1768820663; x=1769425463;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=apOZMf0tEn3rJJPrSfMcVgYQ3RZZMtDVtwPqX5t6dIc=;
 b=vayzZf9IPZ3+mdwHhUKnXz/apR5sl7zrjmaIFjB6W42ymDJhjd2GXb3+k48i7GBCXa
 EYNJYQS4BJAZ+z44w/qINqjm2jHR3sQ6VjOMZVsKf1snMwRlQCvQZeS8PprWXszW2DUI
 KY9/g2uOp1VsGZaD3k8XaplNyPwcJbK5Uef0g9gQwE71f2orZhjTjzzD+1rmS97G7TkR
 WT+b9W05ckSeE2dkAHvhufGIRGLSDp2jzR04W4JcgGyXnkBSyyKBFnY9C2OOJ8MHnrqs
 KfrkrPNQHjWdqMuvZHxsPeuiMrb3qI5Gmaex1Ie8UXnFud/IC0NmJdkMenrFrDE6+AFa
 jbgw==
X-Gm-Message-State: AOJu0YzLrfenZjYYwnE0/IxOf8/7EFt3KRA7quOKzFzP9mnPF6fKTznZ
 kesqD9WjiuJeYq1BkT+frWadFSeJ9Bu9Ox2r+yzvpSyqld6XT28SRIYWvlvzD3+IlkfF7RXm//x
 NQLD/anU=
X-Gm-Gg: AZuq6aLsgKFkaCjVLVbnMM6G5EPtewxIQ3fqsUyLuggCBYlwn/o3N9yE4lR/BotdBHv
 Pmf9xdndvHybJeEQ1p4dRG56FDBGv1gj164Iq2mKrffGl7IUjnNExF1QgKWx3fvpmGbAb3m+iZk
 yGLerlWRRaW8yhlRDkItIYOkE1EkM11tfQPy93KxoYwrdIFTKC9edANoEOZ142b+8mWQLHHtp/p
 4bgu70Uly4Fctor7pDAipJvjyXF9tjeLwyx+x1R6XNqTrbUxA0IitLyhOX1UMaRVmwx+nGPK10B
 HmWqoGIQVKEEAqM2u3i7j91T9irM4JFBd+OUUKJhHRO3DSeJ619Pwv1mfQfhc+UlDUYM/Sx6BF6
 kaqHLxB22/+vE8gQ8qvOEWLLoy4MNnp1u6Usw6XIK8UYrAH/Tg8POTZIzLV2ZDQp3iSZPCRr04r
 RqdM/DjXiEYyyRYnjyiV0wsnBSMjUp6F8r8FTR0pdJtDAdha6qJ0HSd/E8ut/I
X-Received: by 2002:a05:6000:2988:10b0:431:808:2d32 with SMTP id
 ffacd0b85a97d-43569972f16mr9422436f8f.7.1768820662670; 
 Mon, 19 Jan 2026 03:04:22 -0800 (PST)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-43569921da2sm22462140f8f.1.2026.01.19.03.04.21
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Mon, 19 Jan 2026 03:04:22 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Markus Armbruster <armbru@redhat.com>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 "Dr. David Alan Gilbert" <dave@treblig.org>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>
Subject: [PATCH v3 3/8] monitor: Reduce target-specific methods
Date: Mon, 19 Jan 2026 12:03:53 +0100
Message-ID: <20260119110358.66821-4-philmd@linaro.org>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260119110358.66821-1-philmd@linaro.org>
References: <20260119110358.66821-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::436;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x436.google.com
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


