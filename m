Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 273A2C98327
	for <qemu-devel@archiver.kernel.org>; Sat, 17 Jan 2026 16:33:33 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vh9Bv-0004lY-95; Sat, 17 Jan 2026 11:30:23 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vh9Bt-0004hF-6D
 for qemu-devel@nongnu.org; Sat, 17 Jan 2026 11:30:21 -0500
Received: from mail-wr1-x434.google.com ([2a00:1450:4864:20::434])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vh9Br-0006VJ-Di
 for qemu-devel@nongnu.org; Sat, 17 Jan 2026 11:30:20 -0500
Received: by mail-wr1-x434.google.com with SMTP id
 ffacd0b85a97d-432755545fcso1675195f8f.1
 for <qemu-devel@nongnu.org>; Sat, 17 Jan 2026 08:30:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1768667418; x=1769272218; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=7KLPgnY4z2NoWwJMvMcqVp296qKYfzOFpZGS8HjN6AQ=;
 b=Unb3pzZO9xRWopolSM0te4OnMEzMxsE+L+EgmcRsaBBHBT8PlP8O0yvvuqYULiCTZ9
 al+vtEqqwJ/6qxdgGUaTM9+08UW/dETaPLt1vfc/ExxC45Dz4cfNB0XUxlrle3P8SLVc
 EJImNG899Te4DN7C/s3nY9BCisgYSP6+ZKsW9l4V6n23rfE15xFYODPmLniKuP6YCsOk
 tVvNt/G2PfVh8GyOw+MtXo/od6RwIpzSWSeucP1q4wBDJP/52cNQQjiJykJA/Ptktbtd
 nXte7nUvcp+rVakgfjMz3wvihPPRVFmlDB3JA0FH6SMoTYkTabuSeh5vd75rkM3Adrjp
 Wbbw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1768667418; x=1769272218;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=7KLPgnY4z2NoWwJMvMcqVp296qKYfzOFpZGS8HjN6AQ=;
 b=QAWAXDeLJn4MYCO9uLSQExZ8iUcQ18cfobwNHBuypPn7Nx3uAELIhZ0poLJYuBVlNY
 e0gI5QBKpKPx0xF2UFygm222uY8T8ErP3Y3K+f9Ytw5+Rg07AMhQo2vs1K0FtkUa3aES
 TA9dG3jb/Gb8VyhsJNktDH3jEmmkfQm7qfWyTzPQVxYdUwzAzhqEozJyh9Wm9vqb5j71
 4TmfwSaDiPZ+/aOnkMu4SJkC9z05VKLfZfVPhn2o7oMwmqCb+pX9GWAr/KeZ6nRL7Qpr
 mA9IiDNIBv3jLUPjO5YYEM0hit0b4NnWwMjesH6vzBZpRLRQwr4v/aF6QWzDvR75CA9N
 ga6g==
X-Gm-Message-State: AOJu0Yz+4/hqNpjNgO4VZEqc4qOW5elYJjjVbUT/qMu3cUe9Z3hdkSos
 9/7gThzcBn9mUOQOg145wbGzv/V5Lui80VJhkcutcx8JgcQJ8leHrDO1nsonFQ1Ipbiq1z77DUg
 xWMhU4kA=
X-Gm-Gg: AY/fxX5UzKShTgcEkUvuo/5YRR4+PB1HgyxHILnVljJCn5dh4sCEBymGF+fopY9wjNz
 h60hrTGcAh0G7pecUQpeQYSFKq/IyTmLPvaIXbRYHcmOT9D0nCTGzusYP00VHUCm+F3BVzMREU3
 LVAwJcx0QeLSXtG5IZpHdyNl9tGeIUUSBsmQUw3jwCcBpeOnYlQXy3XxmR7zOd1ASHT/gq4cCco
 gsSDL49RPZsnxfl+/GfUkD62ix0Q0rDTzRh3HrXMIdAJVcTZzg3XZl2F69WK01OfkuVlULqlnCT
 vi703TLnd/h/QuH4qd5KAabHH4MtSdfB7md+UgfqyCc8KdrR2fW2bZX3fA08MeunZImH66qpEvz
 kMqo14jXYlFnlYcVImfk+3OpIMVwk6gcaYlUNoavEXHy7V+csAY+MGZoI8idnjkEeOmsEPLTvpA
 v0oRWmKlK3dmMAaV3s5VKkGFO9zQH0fBbyR6/j8hj6+50D1pza3duDx2GMQERI
X-Received: by 2002:a05:6000:2584:b0:431:b1e:7ff9 with SMTP id
 ffacd0b85a97d-43569bd2ab0mr6476114f8f.59.1768667417672; 
 Sat, 17 Jan 2026 08:30:17 -0800 (PST)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-4356996cf58sm11904030f8f.22.2026.01.17.08.30.16
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Sat, 17 Jan 2026 08:30:17 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Richard Henderson <richard.henderson@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 "Dr. David Alan Gilbert" <dave@treblig.org>,
 Markus Armbruster <armbru@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH v2 7/8] monitor: Reduce target-specific methods further
Date: Sat, 17 Jan 2026 17:29:25 +0100
Message-ID: <20260117162926.74225-8-philmd@linaro.org>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260117162926.74225-1-philmd@linaro.org>
References: <20260117162926.74225-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::434;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x434.google.com
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
index 01be0a0b426..a3306b69c93 100644
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
-                case MD_TLONG:
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
index eee8b7e964e..82d2bbdf77d 100644
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
+                case MD_I32:
+                    *pval = *(uint32_t *)ptr;
+                    break;
+                case MD_TLONG:
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


