Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 299F4E8383F
	for <qemu-devel@archiver.kernel.org>; Mon, 16 Feb 2026 22:53:53 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vs7T6-0002jv-AM; Mon, 16 Feb 2026 17:53:28 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vs7T4-0002jJ-RM
 for qemu-devel@nongnu.org; Mon, 16 Feb 2026 17:53:26 -0500
Received: from mail-wm1-x32d.google.com ([2a00:1450:4864:20::32d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vs7T3-0006Y8-6S
 for qemu-devel@nongnu.org; Mon, 16 Feb 2026 17:53:26 -0500
Received: by mail-wm1-x32d.google.com with SMTP id
 5b1f17b1804b1-483770e0b25so31191095e9.0
 for <qemu-devel@nongnu.org>; Mon, 16 Feb 2026 14:53:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1771282403; x=1771887203; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=vJoFwYWGmCgQKszD1zzpvRarXGHFGfsi9ungJP2eo5s=;
 b=J4kdCcNAJ7BxpaTIWncQRh/9nxFU2g4E18+Tf1PC25V5g2UYd6mBVyHpEzAmUMPGq1
 7ju1uPsrVXyV+MJXXi8TtC0V/K4erEOqlVo6DSOzjydVyQl6/+JQj0Zj96Awe7QMuRHI
 cYvXardVSzYHMgLh37QEX6L5FY885LE0puii/4ZZ9+Cm7rsvtEsPRV8rub2CBm9U6t8i
 EZ25Egx/G0SsqM9DXJmwoB3fdtx3tU/iWA8lEMsVnNECL+RZoDIpuxcPzsFUDndmQKgI
 leCr1hN5IGtaSdIKfNxG1J914+uNho/IU0tG4DBfS6jmeLQdrkzx5yGj1dytiAtg1LsU
 d4jA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1771282403; x=1771887203;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=vJoFwYWGmCgQKszD1zzpvRarXGHFGfsi9ungJP2eo5s=;
 b=b2x1BNhdLEHeJl0DEmtnFIU7S7tppe8Neb3kZpxZOh67tsg1n4lHTt7aMXqUdC8hTf
 FILc5zhCWEIbLpUNynhuv0wVMTQCcPP9GWefytoltSLxfsNIsLi+tSQdP6p4FsFnRpK+
 XlQ8u/I3dfkE38Eqe4zgDjhGyY3kbCl6tqCxWt+NnuDdfBI3poVyrP4/85YJayiFAFDK
 FeTrrWH5TzundGu73ANnkUjvGJ7tK4MV0hs27RNlmp4SzokHJljgB/XKsVz+Nib1JD5T
 oUPmL0I6ic97d/edIXNUHCVREWEabwNo15vuNpEDYncLyLdkXoHxbhxCmcwB7tKuEG6y
 ZcUQ==
X-Gm-Message-State: AOJu0YzsMAEXsedO6mpgHfaLSslmBkmfPwIpzI2FV+uuNDWNz9l3H0u+
 UbhMLy1pd6QAK+UKk6ul7Fny0TdD2pHVd1ODpOeVGNF37XZsxSLfBUsHNLrh8JDUogqWA7WgTKu
 aXdUVL2Q=
X-Gm-Gg: AZuq6aI31Gb/YEIKHHoIA4CA+wNqsh5jFcIymZaDndaT5pAIlwOhdFrFxUR5JSSsRI4
 UOVzFZbEbrgciVIJJ6dQ1oOAKbMaameCrFot0qVeJDb6NMQCQr0j1qzz/IrWJ7CrZ1l1pOM6/fk
 bRE/ydpjy7uTH8K2aVLH5fyOAnPkj7pI6EzxJX7m6tLJ0ThMqz0V5/YEWFkpSCFOaD+BW6VlRca
 8liEUChleveDfv6+Rycde+d9WuronEwNjhcGD87rekIyA0KNKifEhqkd1FXMuljOhwEX9DxBbg7
 0D8B+FtlPsHyEIYYHGQKs3ySLthMCc5GavIhmGr0dvU2AkJulr5IP9V8uNeEaZsB/dYoao8s07v
 d+DjJQ4K0IJyp3e96TwgVRMx2fE6abfWqc9QSCy2vmLv06FNDzQTWEmpnByNHamg4uJyVbkLRke
 YvoG1AV/iZDC4pGseTmdcUYz+fZ88ifv1hToTYwzwf05V7VFeaCv243UXxWVYhTYH55XVjvRKTn
 EwiPTgWdlw=
X-Received: by 2002:a05:600c:c0ca:b0:483:78c5:d743 with SMTP id
 5b1f17b1804b1-48378c5d9fcmr134497795e9.28.1771282403164; 
 Mon, 16 Feb 2026 14:53:23 -0800 (PST)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4834d82a4c4sm762581625e9.10.2026.02.16.14.53.21
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Mon, 16 Feb 2026 14:53:22 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Laurent Vivier <laurent@vivier.eu>,
 "Dr. David Alan Gilbert" <dave@treblig.org>,
 Nicholas Piggin <npiggin@gmail.com>, Chinmay Rath <rathc@linux.ibm.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Zhao Liu <zhao1.liu@intel.com>,
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 Artyom Tarasenko <atar4qemu@gmail.com>,
 Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>,
 Gustavo Romero <gustavo.romero@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>, unisono@quyllur.org,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-ppc@nongnu.org
Subject: [PATCH 07/11] monitor/hmp: Handle gdb-xml exposed registers via
 gdb_get_register()
Date: Mon, 16 Feb 2026 23:52:23 +0100
Message-ID: <20260216225228.53959-8-philmd@linaro.org>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260216225228.53959-1-philmd@linaro.org>
References: <20260216225228.53959-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32d;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x32d.google.com
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

Implement the gdb_get_register() helper and call it before the
regular get_monitor_def() one. Registers is exposed via the
GDB XML files will be directly handled, possibily allowing new
registers added to XML files to be automatically accessible in
QEMU monitor. All targets having GDB XML files can now be used
within the monitor.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 monitor/hmp.c | 49 ++++++++++++++++++++++++++++++++++++++++++++++---
 1 file changed, 46 insertions(+), 3 deletions(-)

diff --git a/monitor/hmp.c b/monitor/hmp.c
index 0a5bbf82197..0e5913fabb1 100644
--- a/monitor/hmp.c
+++ b/monitor/hmp.c
@@ -27,14 +27,18 @@
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
 #include "qemu/log.h"
 #include "qemu/option.h"
+#include "qemu/target-info.h"
 #include "qemu/units.h"
+#include "exec/gdbstub.h"
 #include "system/block-backend.h"
 #include "trace.h"
 
@@ -306,6 +310,46 @@ void hmp_help_cmd(Monitor *mon, const char *name)
     free_cmdline_args(args, nb_args);
 }
 
+/*
+ * Set @pval to the value in the register identified by @name.
+ * return %true if the register is found, %false otherwise.
+ */
+static bool gdb_get_register(Monitor *mon, int64_t *pval, const char *name)
+{
+    g_autoptr(GArray) regs = NULL;
+    CPUState *cs = mon_get_cpu(mon);
+
+    if (cs == NULL) {
+        return false;
+    }
+
+    regs = gdb_get_register_list(cs);
+
+    for (int i = 0; i < regs->len; i++) {
+        GDBRegDesc *reg = &g_array_index(regs, GDBRegDesc, i);
+        g_autoptr(GByteArray) buf = NULL;
+        int reg_size;
+
+        if (!reg->name || g_strcmp0(name, reg->name)) {
+            continue;
+        }
+
+        buf = g_byte_array_new();
+        reg_size = gdb_read_register(cs, buf, reg->gdb_reg);
+        if (reg_size > sizeof(*pval)) {
+            return false;
+        }
+
+        if (target_big_endian()) {
+            *pval = ldn_be_p(buf->data, reg_size);
+        } else {
+            *pval = ldn_le_p(buf->data, reg_size);
+        }
+        return true;
+    }
+    return false;
+}
+
 /*******************************************************************/
 
 static const char *pch;
@@ -338,7 +382,6 @@ static int64_t expr_unary(Monitor *mon)
 {
     int64_t n;
     char *p;
-    int ret;
 
     switch (*pch) {
     case '+':
@@ -393,8 +436,8 @@ static int64_t expr_unary(Monitor *mon)
                 pch++;
             }
             *q = 0;
-            ret = get_monitor_def(mon, &reg, buf);
-            if (ret < 0) {
+            if (!gdb_get_register(mon, &reg, buf)
+                && get_monitor_def(mon, &reg, buf) < 0) {
                 expr_error(mon, "unknown register");
             }
             n = reg;
-- 
2.52.0


