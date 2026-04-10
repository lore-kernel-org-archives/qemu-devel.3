Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 690AAF45A0E
	for <qemu-devel@archiver.kernel.org>; Fri, 10 Apr 2026 19:54:55 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wBHvO-000089-HE; Fri, 10 Apr 2026 15:53:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1wBHvM-00006X-K2
 for qemu-devel@nongnu.org; Fri, 10 Apr 2026 15:53:52 -0400
Received: from mail-wm1-x331.google.com ([2a00:1450:4864:20::331])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1wBHvJ-0000l0-Dh
 for qemu-devel@nongnu.org; Fri, 10 Apr 2026 15:53:52 -0400
Received: by mail-wm1-x331.google.com with SMTP id
 5b1f17b1804b1-488d2079582so21379415e9.2
 for <qemu-devel@nongnu.org>; Fri, 10 Apr 2026 12:53:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1775850828; x=1776455628; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=laXD0bHOFLR+f7DqrbhiNwPQxGkoCRCAaO6RrZRP8L8=;
 b=GUMEgppa47NcUYh8fYDR+6RaXR238rb5oZB6jvJP+/1v0jP9xHu+OWIfyBdRHJ6KPJ
 Nb14n72Wjqhc00P1w23KgGAHtBC8NCRyczBfrnKIMonrJbW/+gwlpnQIXfAASAoWa74p
 i7IRhTICx/UMPFIdaA21DPA2aMtjn3XVpgQb8GY5O36uEXhJCEjoiiaq6XuQ2XcjleKl
 Et9Uu8luGD1rGWSTsJJKPvzzOWefkk+26RCKRGLDHroHhGK8lpWw/+PguBW5RNukpn+M
 25ovuQZ5m2ulGnXJCYMiIkaNwojtiiYoFAqI95VC3DAnN5mGLjzcghRXVk+VXUCZT5Mm
 ajsQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1775850828; x=1776455628;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=laXD0bHOFLR+f7DqrbhiNwPQxGkoCRCAaO6RrZRP8L8=;
 b=efRj5yX+0lBIAgC9FO/SOsfVACEDpughCi3M2lMA7d6cet/ATMoQ75ozH9y5Xh3kAa
 FqruDvbTIwcky++qII/91+xJnqzkWrrHz78U+fGQRLvULu3EPkrBHIh/KPOeRBKenOHU
 xo6CXDvSVtp8B2XFCRcMEJnazd2CY3VLS1ecasPNbq5KQUVMveR2xLb54CgxZcWofS5F
 btsi+J5OKEiJ/D/mZsV3MMVsLJHhWbvvwFWpWaaUhmD+8TOMV4VzvGXWMxGZibFhyPaQ
 rN+4wRakIh5w87kZgxBbVSZDpCrQqPSdjvhFvKj7gwOrCP8bUQAZTFjzMpoK0VPudd0U
 s2aA==
X-Gm-Message-State: AOJu0YxaWvLTn/5oQ6WHWF5qvItqX4OyGTA4WOMC7P4q/WbjogwhL1Kq
 0+yvU7qzqd5tuf15bY2isw13xmih+I49MRIPHPgayawFpFz4xNUKr+4pc6cGz2c5BRVm+NMUS3y
 iMFZGqzU=
X-Gm-Gg: AeBDieuBv6yrBMvw/ULw08fjgoWBRGb41gbvImFkQoqJrArEo0lFg52rR913FmRVfG7
 anTXHum1LQkGhFTmFYWW9DG7ULk3SUVVFhVr5xRa3Z4LC9vM2wpLNo58wBJkh0HZKCuTICowDOR
 jQOA63JvmRPRky0D7rW6AlmxsphCB0uN3gF51wLLcuCvdOdgCOm8qfZ2G1P31yC8FUDbuUOvWrm
 r0o4/3tQw5NAaSBkDcb5laJbr0nkOHiu1mkPcf+NoDhXemKWhDXCef1O4rjZx9CgBN0co66tLqA
 8dqIjxsvoCUW/uc37SKNnxkitEvMk3BGu+dlKzUelZLlKj5KBOHPaEgLgAJBGITAm8+3re5Knje
 aHgR4Asnsf+R52LqCQPNu99FOaqBzjtGzMaCTqTa0l/6pXmRjzv1Q9fFPJw23AcI5uJmQuGS2zD
 C1xUpMgEMVdc3sy91FaHVoTn8t1fM1MGc1XCNDKA+p1b6Cz6ZChSZ1nopz/8H+P1T7J33fYKTk
X-Received: by 2002:a05:600c:a411:b0:488:af48:af11 with SMTP id
 5b1f17b1804b1-488d67c749emr47503115e9.1.1775850827230; 
 Fri, 10 Apr 2026 12:53:47 -0700 (PDT)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-488d681ea59sm28031745e9.14.2026.04.10.12.53.46
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Fri, 10 Apr 2026 12:53:46 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Richard Henderson <richard.henderson@linaro.org>,
 "Dr. David Alan Gilbert" <dave@treblig.org>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>, qemu-riscv@nongnu.org,
 Markus Armbruster <armbru@redhat.com>, qemu-s390x@nongnu.org,
 kvm@vger.kernel.org, qemu-ppc@nongnu.org,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH v2 03/27] monitor: Reduce target-specific methods further
Date: Fri, 10 Apr 2026 21:52:57 +0200
Message-ID: <20260410195323.17937-4-philmd@linaro.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260410195323.17937-1-philmd@linaro.org>
References: <20260410195323.17937-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::331;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x331.google.com
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
 monitor/hmp-target.c       | 39 -------------------------------------
 monitor/hmp.c              | 40 ++++++++++++++++++++++++++++++++++++++
 3 files changed, 40 insertions(+), 40 deletions(-)

diff --git a/monitor/monitor-internal.h b/monitor/monitor-internal.h
index feca111ae31..3ecd394ecf6 100644
--- a/monitor/monitor-internal.h
+++ b/monitor/monitor-internal.h
@@ -181,7 +181,6 @@ void monitor_data_destroy_qmp(MonitorQMP *mon);
 void coroutine_fn monitor_qmp_dispatcher_co(void *data);
 void qmp_dispatcher_co_wake(void);
 
-int get_monitor_def(Monitor *mon, int64_t *pval, const char *name);
 void handle_hmp_command(MonitorHMP *mon, const char *cmdline);
 int hmp_compare_cmd(const char *name, const char *list);
 
diff --git a/monitor/hmp-target.c b/monitor/hmp-target.c
index b9b79e8e927..c840ae5f0a2 100644
--- a/monitor/hmp-target.c
+++ b/monitor/hmp-target.c
@@ -23,7 +23,6 @@
  */
 
 #include "qemu/osdep.h"
-#include "qemu/target-info.h"
 #include "monitor-internal.h"
 #include "monitor/qdev.h"
 #include "net/slirp.h"
@@ -61,44 +60,6 @@ HMPCommand *hmp_cmds_for_target(bool info_command)
     return info_command ? hmp_info_cmds : hmp_cmds;
 }
 
-/*
- * Set @pval to the value in the register identified by @name.
- * return 0 if OK, -1 if not found
- */
-int get_monitor_def(Monitor *mon, int64_t *pval, const char *name)
-{
-    const MonitorDef *md = target_monitor_defs();
-    CPUState *cs = mon_get_cpu(mon);
-    void *ptr;
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
-                int64_t val = md->get_value(mon, md, md->offset);
-                *pval = target_long_bits() == 32 ? (int32_t)val : val;
-            } else {
-                CPUArchState *env = mon_get_cpu_env(mon);
-                ptr = (uint8_t *)env + md->offset;
-                *pval = *(int32_t *)ptr;
-            }
-            return 0;
-        }
-    }
-
-    ret = target_get_monitor_def(cs, name, &tmp);
-    if (!ret) {
-        *pval = target_long_bits() == 32 ? (int32_t)tmp : tmp;
-    }
-
-    return ret;
-}
-
 static int
 compare_mon_cmd(const void *a, const void *b)
 {
diff --git a/monitor/hmp.c b/monitor/hmp.c
index 0e5913fabb1..20ba1e62988 100644
--- a/monitor/hmp.c
+++ b/monitor/hmp.c
@@ -355,6 +355,8 @@ static bool gdb_get_register(Monitor *mon, int64_t *pval, const char *name)
 static const char *pch;
 static sigjmp_buf expr_env;
 
+static int get_monitor_def(Monitor *mon, int64_t *pval, const char *name);
+
 static G_NORETURN G_GNUC_PRINTF(2, 3)
 void expr_error(Monitor *mon, const char *fmt, ...)
 {
@@ -1595,3 +1597,41 @@ void monitor_register_hmp_info_hrt(const char *name,
     }
     g_assert_not_reached();
 }
+
+/*
+ * Set @pval to the value in the register identified by @name.
+ * return 0 if OK, -1 if not found
+ */
+static int get_monitor_def(Monitor *mon, int64_t *pval, const char *name)
+{
+    const MonitorDef *md = target_monitor_defs();
+    CPUState *cs = mon_get_cpu(mon);
+    void *ptr;
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
+                int64_t val = md->get_value(mon, md, md->offset);
+                *pval = target_long_bits() == 32 ? (int32_t)val : val;
+            } else {
+                CPUArchState *env = mon_get_cpu_env(mon);
+                ptr = (uint8_t *)env + md->offset;
+                *pval = *(int32_t *)ptr;
+            }
+            return 0;
+        }
+    }
+
+    ret = target_get_monitor_def(cs, name, &tmp);
+    if (!ret) {
+        *pval = target_long_bits() == 32 ? (int32_t)tmp : tmp;
+    }
+
+    return ret;
+}
-- 
2.53.0


