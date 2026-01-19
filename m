Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 57B81CCF2DF
	for <qemu-devel@archiver.kernel.org>; Mon, 19 Jan 2026 11:05:44 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vhn4U-0000KU-6R; Mon, 19 Jan 2026 06:05:24 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vhn4B-0008Qy-7R
 for qemu-devel@nongnu.org; Mon, 19 Jan 2026 06:05:06 -0500
Received: from mail-wm1-x334.google.com ([2a00:1450:4864:20::334])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vhn49-0006fT-1E
 for qemu-devel@nongnu.org; Mon, 19 Jan 2026 06:05:02 -0500
Received: by mail-wm1-x334.google.com with SMTP id
 5b1f17b1804b1-47d63594f7eso28251585e9.0
 for <qemu-devel@nongnu.org>; Mon, 19 Jan 2026 03:05:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1768820699; x=1769425499; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=3VIB+OpBInAaNY2pTDrwIlQ5aTfArsqavUF/QiPi1mg=;
 b=XrXWFq9u867jCH2ItBg5gipTWmBvYiVwqomfioEBFh4NzqjBrm3kC5EBF4i5npS57J
 yhOyheKS1IEatFtLlrWmZYb77+qX9o9/lp6brGhANojwLTO76iIOEOhSE7AkFGZCm6N5
 V1ElP1UJ9uFeNUaT96XkStQreemKy5ZTp0Zd/m/UGnnIeNFwBnrIe43Mo5b+JDsgsHiF
 QLHlU+zxjwXn0cgmJQQOfhEUPlKyU2PfRM9DHMI8GbGeSN94lBATyt2YcooElysk3ax4
 zM0XMOE92qTNOQlqwl7oaKom3cjh8riGdJMXPROFa7D+2ud0tCa415PMrvZ/u+AK8E2l
 F4RA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1768820699; x=1769425499;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=3VIB+OpBInAaNY2pTDrwIlQ5aTfArsqavUF/QiPi1mg=;
 b=RedSelD9+75bNpJ7J7bQ3A5/0s0183let6B9st9TTk2Sr4b9m4r9OUQucufgyWTrKQ
 P9hyniHU1HXK9clUHCElpJsJBpu1d6ce4DpOn1qgIeIoWbYMH6OeUpjChk/Bknw3RAHf
 HMx+l2sjfgKHMKS1dSeSRiCFG5dVxzh1ZbYp+anACRPnEiFG+cClnaTh8QXewE8ez73A
 X9uqsAEF4STjllyHOEtm/5xHLVm71gUT4IzmYlx0srYABnXQ72C2agrmSOrYsEIeO4lx
 sZVqZQtQZI7AQTswh3jz4WxK8z/NxS/WCPZr4CtohfONOrlpfx502pCnbN/FCTgPSbGx
 OMlw==
X-Gm-Message-State: AOJu0YzUDMctS/YOo14RkxP1rEk+R5XteRqDukudZ1PvuqOHE/m2OX64
 IYFxW9SVNVMh0XHWLotxCRYQRjROFMXD9MxqVsZtiyBjUiwF5ZGcqnW/aDGd0uLsKs023MyOoib
 FhgxObng=
X-Gm-Gg: AY/fxX6DrbT6XnZTX1gbq8RfiOcVttrIbrKUkOnbt9xISHGRefAUWRp4cYF+HwyFnLP
 5Oieu0ZCtBvQWx2+6Kj+nf7BEs3e+3s1ZNjYZWdaOdjtxQiEeErOMoLOMUodUKB37Z35nMv5tLi
 mgCPrzt3jVEfNxJQfHxbhGShg5fh7G912YRmt4BKphvX7115WJmLY0a1WeXY5qAqLkR/bqP+Ndj
 0XuJGz6ACYX/zts4KZDLF+Z5vJTYXtn+6wbjaORzhRylECIsm6zIaHrCeXURPE4teuVS3Jd7J9i
 oQVTqCgGEp5cxu+J84z+k8neq5LR+7LnazZY3AYDOxD9ETOqNU6DDIIsiwDFEwJnejuq3T2yR3g
 EoaA0HzsLO3BS1wsMRKcxoJK2Xvb7eszjTTu1eEpw7EHxXpQ00w0kL5kWX11V/VkHplW3qG+w+M
 AFgeV1EbTXlSEz7d3ye9o8hhbtBJViNa16uEYvaRBiksUyvyCy+evwjEpQUvig
X-Received: by 2002:a05:600c:4e4e:b0:477:7725:c16a with SMTP id
 5b1f17b1804b1-4801e30b74emr142538355e9.10.1768820692550; 
 Mon, 19 Jan 2026 03:04:52 -0800 (PST)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-4356999824csm22360981f8f.39.2026.01.19.03.04.51
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Mon, 19 Jan 2026 03:04:52 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Markus Armbruster <armbru@redhat.com>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 "Dr. David Alan Gilbert" <dave@treblig.org>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>
Subject: [PATCH v3 7/8] monitor: Reduce target-specific methods further
Date: Mon, 19 Jan 2026 12:03:57 +0100
Message-ID: <20260119110358.66821-8-philmd@linaro.org>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260119110358.66821-1-philmd@linaro.org>
References: <20260119110358.66821-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::334;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x334.google.com
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

get_monitor_def() doesn't use any target-specific declaration
anymore, move it to hmp.c to compile it once.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Dr. David Alan Gilbert <dave@treblig.org>
---
 monitor/monitor-internal.h |  1 -
 monitor/hmp-target.c       | 49 -----------------------------------
 monitor/hmp.c              | 52 ++++++++++++++++++++++++++++++++++++++
 3 files changed, 52 insertions(+), 50 deletions(-)

diff --git a/monitor/monitor-internal.h b/monitor/monitor-internal.h
index 8dc88963630..3ecd394ecf6 100644
--- a/monitor/monitor-internal.h
+++ b/monitor/monitor-internal.h
@@ -181,7 +181,6 @@ void monitor_data_destroy_qmp(MonitorQMP *mon);
 void coroutine_fn monitor_qmp_dispatcher_co(void *data);
 void qmp_dispatcher_co_wake(void);
 
-int get_monitor_def(Monitor *mon, uint64_t *pval, const char *name);
 void handle_hmp_command(MonitorHMP *mon, const char *cmdline);
 int hmp_compare_cmd(const char *name, const char *list);
 
diff --git a/monitor/hmp-target.c b/monitor/hmp-target.c
index 257605a1c96..a3306b69c93 100644
--- a/monitor/hmp-target.c
+++ b/monitor/hmp-target.c
@@ -23,7 +23,6 @@
  */
 
 #include "qemu/osdep.h"
-#include "qemu/bswap.h"
 #include "monitor-internal.h"
 #include "monitor/qdev.h"
 #include "net/slirp.h"
@@ -60,54 +59,6 @@ HMPCommand *hmp_cmds_for_target(bool info_command)
     return info_command ? hmp_info_cmds : hmp_cmds;
 }
 
-/*
- * Set @pval to the value in the register identified by @name.
- * return 0 if OK, -1 if not found
- */
-int get_monitor_def(Monitor *mon, uint64_t *pval, const char *name)
-{
-    const unsigned length = target_long_bits() / 8;
-    const MonitorDef *md = target_monitor_defs();
-    CPUState *cs = mon_get_cpu(mon);
-    uint64_t tmp = 0;
-    int ret;
-
-    if (cs == NULL || md == NULL) {
-        return -1;
-    }
-
-    for(; md->name != NULL; md++) {
-        if (hmp_compare_cmd(name, md->name)) {
-            if (md->get_value) {
-                *pval = md->get_value(mon, md, md->offset);
-            } else {
-                CPUArchState *env = mon_get_cpu_env(mon);
-                void *ptr = (uint8_t *)env + md->offset;
-
-                switch(md->type) {
-                case MD_I32:
-                    *pval = *(uint32_t *)ptr;
-                    break;
-                case MD_TULONG:
-                    *pval = ldn_he_p(ptr, length);
-                    break;
-                default:
-                    *pval = 0;
-                    break;
-                }
-            }
-            return 0;
-        }
-    }
-
-    ret = target_get_monitor_def(cs, name, &tmp);
-    if (!ret) {
-        *pval = ldn_he_p(&tmp, length);
-    }
-
-    return ret;
-}
-
 static int
 compare_mon_cmd(const void *a, const void *b)
 {
diff --git a/monitor/hmp.c b/monitor/hmp.c
index eee8b7e964e..36e58c54670 100644
--- a/monitor/hmp.c
+++ b/monitor/hmp.c
@@ -27,8 +27,10 @@
 #include "hw/core/qdev.h"
 #include "monitor-internal.h"
 #include "monitor/hmp.h"
+#include "monitor/hmp-target.h"
 #include "qobject/qdict.h"
 #include "qobject/qnum.h"
+#include "qemu/bswap.h"
 #include "qemu/config-file.h"
 #include "qemu/ctype.h"
 #include "qemu/cutils.h"
@@ -311,6 +313,8 @@ void hmp_help_cmd(Monitor *mon, const char *name)
 static const char *pch;
 static sigjmp_buf expr_env;
 
+static int get_monitor_def(Monitor *mon, uint64_t *pval, const char *name);
+
 static G_NORETURN G_GNUC_PRINTF(2, 3)
 void expr_error(Monitor *mon, const char *fmt, ...)
 {
@@ -1552,3 +1556,51 @@ void monitor_register_hmp_info_hrt(const char *name,
     }
     g_assert_not_reached();
 }
+
+/*
+ * Set @pval to the value in the register identified by @name.
+ * return 0 if OK, -1 if not found
+ */
+static int get_monitor_def(Monitor *mon, uint64_t *pval, const char *name)
+{
+    const unsigned length = target_long_bits() / 8;
+    const MonitorDef *md = target_monitor_defs();
+    CPUState *cs = mon_get_cpu(mon);
+    uint64_t tmp = 0;
+    int ret;
+
+    if (cs == NULL || md == NULL) {
+        return -1;
+    }
+
+    for(; md->name != NULL; md++) {
+        if (hmp_compare_cmd(name, md->name)) {
+            if (md->get_value) {
+                *pval = md->get_value(mon, md, md->offset);
+            } else {
+                CPUArchState *env = mon_get_cpu_env(mon);
+                void *ptr = (uint8_t *)env + md->offset;
+
+                switch(md->type) {
+                case MD_U32:
+                    *pval = *(uint32_t *)ptr;
+                    break;
+                case MD_TULONG:
+                    *pval = ldn_he_p(ptr, length);
+                    break;
+                default:
+                    *pval = 0;
+                    break;
+                }
+            }
+            return 0;
+        }
+    }
+
+    ret = target_get_monitor_def(cs, name, &tmp);
+    if (!ret) {
+        *pval = ldn_he_p(&tmp, length);
+    }
+
+    return ret;
+}
-- 
2.52.0


