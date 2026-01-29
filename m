Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 069E1D358D6
	for <qemu-devel@archiver.kernel.org>; Thu, 29 Jan 2026 16:42:07 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vlV5S-0001ge-6H; Thu, 29 Jan 2026 11:41:42 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vlV5P-0001WD-OA
 for qemu-devel@nongnu.org; Thu, 29 Jan 2026 11:41:40 -0500
Received: from mail-wm1-x335.google.com ([2a00:1450:4864:20::335])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vlV5M-0005Ls-Ow
 for qemu-devel@nongnu.org; Thu, 29 Jan 2026 11:41:39 -0500
Received: by mail-wm1-x335.google.com with SMTP id
 5b1f17b1804b1-47ee3a63300so12115135e9.2
 for <qemu-devel@nongnu.org>; Thu, 29 Jan 2026 08:41:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1769704895; x=1770309695; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=TGK+LI5OV6mWFPj78RfCGcDXkjf/Lbx4vCU4mtQCOqM=;
 b=bwKlAAa+QM9rravqGs4+d5OkPEI8/H6fqdbrXMLpgLRTWbasC/OnZ14UIHP4HJcW/W
 UfWjksDL4qw0IgFGOR+niOvX0NJ6XJxpv7VgdZHgqk2H2cLS072DEu1hYsmZCHWJlfek
 QFdC0czGANCHEWNFRBfywWakhPL43lo7MyN/rcMIp29GxzqEbd0P1ieI5TVCCKIQuG6f
 mpHm0dpM4f7NWtFJl6XRYJVFeT3uLDdGbLmgZtbkG20xu8rGIvC+F/AfxikXyLbbKvqq
 6o6bqtLolHZ7g5aKJYvXoA8H0UuDoE7qDcqLNpVcy9m0i44K5Y5a6tvAGN1pULriJYTK
 +N/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1769704895; x=1770309695;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=TGK+LI5OV6mWFPj78RfCGcDXkjf/Lbx4vCU4mtQCOqM=;
 b=ZnH8fsPwjEa+jqc0XNkqgIDUflW2owi+46rKjXJk8E3+r2NMIIGGIEDBsobLVfbZxg
 gE2BShAXZkX2fsJj8BgRWfZM35GbdJRWVWKLoCN6/QlQZDfrwrQnGRMs/liSyIimV6mW
 uMW4lKb2ra77xRA+UTuNL6UHhhXjG4rdVMgHkJBgl53rg26fBxGh9xtb/F0FeXfo3xMK
 Ml3BPwJC75R6DY0SMllgeJnhxU3EOS5Tb6ZNzC1G2c4wmWOxcZzXZDtvohadtkGGUlOk
 jESCCFJdExbIRVA1B/KhGdqhH75jNyEz8KDIr82ylDrfcQdKIX1bJ9SehGwMxiWxuhu/
 VI8Q==
X-Gm-Message-State: AOJu0YwbkTxWzWa4aT/BcVh65QhDm2HN9+dg3Qx9x4kt7m4z9OF/bxEm
 Wve9d5I5CWXi48jZ5WeBXiSQn25N2P/eqUN1M2O+PUiu/tMDDfqN0UXTH0iT5mvPBJ6qPhQpq/i
 hiDHTqps=
X-Gm-Gg: AZuq6aLE3SyHgerRfxpS6RzcITJwTsOyB+OHDoaLUUCIPfzJf66mU/ZOcJAbgL0eNjI
 sdM3lzITIQ7nJxUBHrQfob91R9ZwwSwYmNpPcRTLtRNdla7+kPfNqOVKYpLD+qosLEIW7o10aeJ
 vr1I0Li/AgPJmqZ9fYKkXvtv1Fm/TMG5P8/UbwHyNyylQNbQLff4qXtMeF00ksXNUkYakC47ZAQ
 LVXrmBZTeaIcO7B8sXlURyWXaisIToZhAx0423PdshEchVEaMbmQso6lhPJRcRrK/htOr6JvWGF
 ywoRUTgjf9xCXAqecN8+wxOfVJzzCkt9TBQZNFmktZydXtIYELSHgWTgKRYqGKsMvVcUtBKIccW
 yG3PhdiGo22ule/bTjKBL2YM3NBWPANV8eCoxZmp6sy6JjFEMtQBl+7uS5q7fsPDysiokLAO2ss
 BF8E9miOnZyEffkelQBs7EtjGGhPDlwg9FoKOShJLIfmDOkAC8jXNjVOCjzGqA
X-Received: by 2002:a05:600c:6989:b0:477:6374:6347 with SMTP id
 5b1f17b1804b1-48069c5a2bcmr127602175e9.22.1769704894952; 
 Thu, 29 Jan 2026 08:41:34 -0800 (PST)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-435e131ce58sm15512664f8f.20.2026.01.29.08.41.34
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Thu, 29 Jan 2026 08:41:34 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: "Dr. David Alan Gilbert" <dave@treblig.org>,
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>, qemu-riscv@nongnu.org,
 Richard Henderson <richard.henderson@linaro.org>, qemu-ppc@nongnu.org
Subject: [PATCH v5 8/9] monitor: Reduce target-specific methods further
Date: Thu, 29 Jan 2026 17:40:37 +0100
Message-ID: <20260129164039.58472-9-philmd@linaro.org>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260129164039.58472-1-philmd@linaro.org>
References: <20260129164039.58472-1-philmd@linaro.org>
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
index 4472c122108..a3306b69c93 100644
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
-                case MD_U32:
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
index eee8b7e964e..bd6a097dda0 100644
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
+    for (; md->name != NULL; md++) {
+        if (hmp_compare_cmd(name, md->name)) {
+            if (md->get_value) {
+                *pval = md->get_value(mon, md, md->offset);
+            } else {
+                CPUArchState *env = mon_get_cpu_env(mon);
+                void *ptr = (uint8_t *)env + md->offset;
+
+                switch (md->type) {
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


