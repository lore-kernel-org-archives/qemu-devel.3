Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 067301093193
	for <qemu-devel@archiver.kernel.org>; Fri, 20 Mar 2026 09:12:07 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w3Vsv-00078S-Cs; Fri, 20 Mar 2026 05:11:14 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1w3Vsk-00073k-05
 for qemu-devel@nongnu.org; Fri, 20 Mar 2026 05:11:06 -0400
Received: from mail-wm1-x330.google.com ([2a00:1450:4864:20::330])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1w3Vsg-0003gD-Qb
 for qemu-devel@nongnu.org; Fri, 20 Mar 2026 05:11:01 -0400
Received: by mail-wm1-x330.google.com with SMTP id
 5b1f17b1804b1-486ff3a0fc1so3641395e9.2
 for <qemu-devel@nongnu.org>; Fri, 20 Mar 2026 02:10:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1773997857; x=1774602657; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=XdKq1U5rW3dRPvw71lLGhSrUWkJgSl5smUUmGKvqjzo=;
 b=HU2i2bDI1fQyeu2EuJiIx/l+RO01sOWpI1RiRzwprdYEby3yur+KCq+mr3YKq7Ke6C
 fqqOgxG8VjgZESzVeBH70nwNkPlJBdGEzQKWWJbhm8yp2ed/FMuXHzc7CLpz38bQ7Up7
 QlfHHiqbmGOZt5lcZhZkDGLNRc4tvou8+wTiOsgOwvKPeXxH+34pXScmhryqJYgq3Rsg
 Vj7Tn7tecK6SoMa7Di4woFbqTrdwk3sE0uLpoVlKwmAXWCnmJAX0NfBuyheJ3/eEAvV2
 n/dOMMw+Ib2pgSn/dBizLFO+RBwA0o+LqEch1TUgaEQN8F0uxsRLCuLUVAiEh8FB7O6Z
 xAUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1773997857; x=1774602657;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=XdKq1U5rW3dRPvw71lLGhSrUWkJgSl5smUUmGKvqjzo=;
 b=HMO/Xujdzy53K0tUCrAPd+f77CbpjLWC+GdoE9UWTqHNLjqqe7MzTu55xMIL0OoNs2
 aYc9a4oNre53oxCLOkZCOnI844L4pVXDMu4W7+85HqEBd0UVD06gHESWhAQPSFUcq7jL
 VNYJ6DNVCw7TLH0Hu9bLBFhK7R4jWho6DtPWeOefDDxyu3ja3BPBku/Hm8oIW1xEuAzv
 oJCXa+vnft2QNtDn2es1CU/GqbDqWFHuec0IJVFiXck37B/HzFcO+/F/n4Blvh5zr1ly
 EaFE44CQ+aMVwm9ys0tbLFm7WCMptBYN/DuBFWVlQo1x8/1qBuM6Q76Krebf0GySUznI
 Hodw==
X-Gm-Message-State: AOJu0YxtrUWDp6MmKcXjVYSJENQ8QsGqmepb+sz8OAeGEhTMXOsE8ZOq
 AA9Su+FfKjSvcgcQOYFeLe2gvy+jZaakVGxDbLPCfZ2qxX5HWd6OWj2QQ52F2NUGBFLpheCEZW0
 Nc4HiGSU=
X-Gm-Gg: ATEYQzxQyLLauJwEqarLSEN5Ekp1BOAGIk6yBTNGMbgxs91y+Q6RgteUxuor7MFGvmJ
 c9Hxoj7xaj7/TKpRu86of7W51rPzYhH0rdnRk8qMLyqSl8cXyZajo7ywxV8WTNC3+3CJvSKau+l
 txWViTeIqpGcPk54NDO9mqzefkMqqU7sWZkLuJ2CipN7mueYd3YOTFDNcuEO64BHHLwpaCi9xMG
 OG8Es5RIVJYnJRZlUYNbqtdTgKgCaEILy76AbWLVuxbAYVZ5qxRqfjRLlqJD3OrcbSBd/Zwvghp
 oX8rjSJysVfpWDfvta5olq/IPgY2qbwiDwYhV3C+6ay0A4OZIE6Oj20/pfzHjdcIM1qzcyq8BFM
 89fpLRTpkz15hyGX6+JtAN37MukoFH/F7idohzRqMfkVwfUghUiLLB0V7ewKAV3BVaYUnv9V9sr
 SRqjsb5wb9cn1S7CuzgK1jWx/7EqIBuARhFRcvWIYe9YLRCOX5mZOSzNhaGByYrmz49dmOt8ro
X-Received: by 2002:a05:600c:548e:b0:47e:e2ec:9947 with SMTP id
 5b1f17b1804b1-486ff029336mr31658215e9.33.1773997856588; 
 Fri, 20 Mar 2026 02:10:56 -0700 (PDT)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-486fe7dc4a2sm53051385e9.5.2026.03.20.02.10.55
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Fri, 20 Mar 2026 02:10:55 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Daniel Henrique Barboza <dbarboza@ventanamicro.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 Artyom Tarasenko <atar4qemu@gmail.com>,
 "Dr. David Alan Gilbert" <dave@treblig.org>,
 Richard Henderson <richard.henderson@linaro.org>,
 Markus Armbruster <armbru@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH-for-11.1 v6 5/6] monitor: Reduce target-specific methods
 further
Date: Fri, 20 Mar 2026 10:10:17 +0100
Message-ID: <20260320091019.59902-6-philmd@linaro.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260320091019.59902-1-philmd@linaro.org>
References: <20260320091019.59902-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::330;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x330.google.com
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
index 5e9f1b0db5b..a3306b69c93 100644
--- a/monitor/hmp-target.c
+++ b/monitor/hmp-target.c
@@ -23,7 +23,6 @@
  */
 
 #include "qemu/osdep.h"
-#include "qemu/target-info.h"
 #include "monitor-internal.h"
 #include "monitor/qdev.h"
 #include "net/slirp.h"
@@ -60,44 +59,6 @@ HMPCommand *hmp_cmds_for_target(bool info_command)
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
index 0e5913fabb1..1d645090667 100644
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
+int get_monitor_def(Monitor *mon, int64_t *pval, const char *name)
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
+    for(; md->name != NULL; md++) {
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


