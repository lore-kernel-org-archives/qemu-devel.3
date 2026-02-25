Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0300CFD45F1
	for <qemu-devel@archiver.kernel.org>; Wed, 25 Feb 2026 23:16:48 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vvO7U-0007lw-Eq; Wed, 25 Feb 2026 18:16:42 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vvO6c-0006sp-HA
 for qemu-devel@nongnu.org; Wed, 25 Feb 2026 18:15:50 -0500
Received: from mail-wm1-x335.google.com ([2a00:1450:4864:20::335])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vvO6a-0002nu-A2
 for qemu-devel@nongnu.org; Wed, 25 Feb 2026 18:15:46 -0500
Received: by mail-wm1-x335.google.com with SMTP id
 5b1f17b1804b1-4836f363ad2so3051285e9.1
 for <qemu-devel@nongnu.org>; Wed, 25 Feb 2026 15:15:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1772061342; x=1772666142; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=NGQ7lLB0920PRZOLFmWc26SlHIRfD26FcVLJos8aUeA=;
 b=QsCRIMJsHU8wlbRjSllNsb4XC4kOvHkUjeHWw7t8govXxTAQ4pMh6EyYDfMw/bH+z/
 wrFnwOfOUTAd7Z8TAFUMtP35HD+9BjSXBUjGdfzWw+kIzgyZYEcNII26zlQ58gY9YKqm
 3GgM7EZ93Vbpvl2hOwMBeKoBOkafgfdhlzskhGKd0YBFuOyb0ERjLeY8akNqC1gy25kv
 Jkty7+80jYAZa+nJ3ScwK3ppFn8K4Pd6oEOc8QRT6fDkEPSxHeJE5piMzLu9hImhJzU+
 17oiaRE658imCMIpgvtTYjpaYJChH56lsYQlKmTz0H7jmCBDwQeyd1GAd0k0Gx5uNYL/
 +SDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1772061342; x=1772666142;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=NGQ7lLB0920PRZOLFmWc26SlHIRfD26FcVLJos8aUeA=;
 b=jPDzoQutW9Iz7pf9iApXGakM4gOyDOoogjoFB5kQeClueJbzcbQDRsOQDrtPJxAV4Z
 7tL4o22e85aWsIcOqSFBimdr6BJqgukyU3p//ZCPtNcmjEcAdg+EjZ4ZnvjPksbvx1oj
 4qHUPADhev+OEBufbEeoXuQoW5eGGrnTyl/ZloQp7YA1hEI23PyS+kLVp4D9ovkAol0e
 Jz/NCM36LBoGMugP3R59+CxTkV8ha60YcTuSF4oSS6wmorb+yiGnGuoIZVYiPdZKeKj+
 fQlUQ2T/nv9KL/wmt1oYTkeWtWIsjYtra5KemMzNokWs4OOVequ+x8+/JOwy1SbnKsit
 fCiw==
X-Gm-Message-State: AOJu0YyRK8qDYcvhULoVwT9GfdySf9HAxSh4QoKLh9IJ1bmxaeyd7Hhr
 +qufHewBUULplaAIUKKvzW4NvOc49iGVn+aX6RAVbXku6i58LDf6flxZ54QUqeJM0E48pt5HEI4
 o6fuJVFc=
X-Gm-Gg: ATEYQzwdzW53bIf2L6Xn8Q6ppCVrpJFcPBqmhjRrriFZ0wzHRKNP0GnI72q3w2JGNAp
 8vZkYQCkqC2D21MNgsjOeY4ALqK5vL4DLOAME0fMqOs4a118wf5Eic+LbOgPYPi+6uW0WG6w4Yu
 An7kKli4qpWUynouh5OOL93QbUvv/xAz6lqy1j3fe4CXf6SxVAvNE7nLGQB8hZ3VU/CGB5rz14v
 kcxGSleV2n0FP8M4EWrPyzv9H36O5OpyL62z6xrea9q1EILGWOmU+nn3/PMUMgmeIzDwFhKpkSb
 1G8hp1n51sh0OrcB53BS3e7n0q2+NSIGS1Wdas5H+D6ht6QABzWsUoBQ5FSM8xC9aI6udaFRfK1
 jNFn2n6xM76E49G8qZ2/1f4VtJrQSKfrDLlvVUjkoO0efp5xQr4t+rVzn8+uom0XNWSEpyBChzx
 CxsIwiLCCpV5xfkR49VYLvhfEx15KxNa4p2/AlBydsAOd++xQZ2hCnG45c/QU+m8ys+spTljX3
X-Received: by 2002:a05:600c:3e05:b0:483:6fc6:1e20 with SMTP id
 5b1f17b1804b1-483a95b5410mr298016075e9.9.1772061341984; 
 Wed, 25 Feb 2026 15:15:41 -0800 (PST)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-483c3b44207sm4134555e9.7.2026.02.25.15.15.41
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Wed, 25 Feb 2026 15:15:41 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 13/70] target/riscv: Extract monitor-related code to monitor.c
Date: Thu, 26 Feb 2026 00:13:13 +0100
Message-ID: <20260225231411.96482-14-philmd@linaro.org>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260225231411.96482-1-philmd@linaro.org>
References: <20260225231411.96482-1-philmd@linaro.org>
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

Keep riscv-qmp-cmds.c for QMP, use monitor.c for HMP.

Reviewed-by: Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>
Reviewed-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Message-ID: <20260219191955.83815-7-philmd@linaro.org>
---
 target/riscv/monitor.c        | 148 +++++++++++++++++++++++++++++++++
 target/riscv/riscv-qmp-cmds.c | 150 ----------------------------------
 2 files changed, 148 insertions(+), 150 deletions(-)

diff --git a/target/riscv/monitor.c b/target/riscv/monitor.c
index 478fd392ac6..ccb7eb44d02 100644
--- a/target/riscv/monitor.c
+++ b/target/riscv/monitor.c
@@ -19,6 +19,8 @@
  */
 
 #include "qemu/osdep.h"
+#include "qemu/ctype.h"
+#include "qemu/qemu-print.h"
 #include "cpu.h"
 #include "cpu_bits.h"
 #include "monitor/monitor.h"
@@ -241,3 +243,149 @@ void hmp_info_mem(Monitor *mon, const QDict *qdict)
 
     mem_info_svxx(mon, env);
 }
+
+/*
+ * We have way too many potential CSRs and regs being added
+ * regularly to register them in a static array.
+ *
+ * Declare an empty array instead, making get_monitor_def() use
+ * the target_get_monitor_def() API directly.
+ */
+const MonitorDef monitor_defs[] = { { } };
+const MonitorDef *target_monitor_defs(void)
+{
+    return monitor_defs;
+}
+
+static bool reg_is_ulong_integer(CPURISCVState *env, const char *name,
+                                 target_ulong *val, bool is_gprh)
+{
+    const char * const *reg_names;
+    target_ulong *vals;
+
+    if (is_gprh) {
+        reg_names = riscv_int_regnamesh;
+        vals = env->gprh;
+    } else {
+        reg_names = riscv_int_regnames;
+        vals = env->gpr;
+    }
+
+    for (int i = 0; i < 32; i++) {
+        g_auto(GStrv) reg_name = g_strsplit(reg_names[i], "/", 2);
+
+        g_assert(reg_name[0]);
+        g_assert(reg_name[1]);
+
+        if (g_ascii_strcasecmp(reg_name[0], name) == 0 ||
+            g_ascii_strcasecmp(reg_name[1], name) == 0) {
+            *val = vals[i];
+            return true;
+        }
+    }
+
+    return false;
+}
+
+static bool reg_is_u64_fpu(CPURISCVState *env, const char *name, uint64_t *val)
+{
+    if (qemu_tolower(name[0]) != 'f') {
+        return false;
+    }
+
+    for (int i = 0; i < 32; i++) {
+        g_auto(GStrv) reg_name = g_strsplit(riscv_fpr_regnames[i], "/", 2);
+
+        g_assert(reg_name[0]);
+        g_assert(reg_name[1]);
+
+        if (g_ascii_strcasecmp(reg_name[0], name) == 0 ||
+            g_ascii_strcasecmp(reg_name[1], name) == 0) {
+            *val = env->fpr[i];
+            return true;
+        }
+    }
+
+    return false;
+}
+
+static bool reg_is_vreg(const char *name)
+{
+    if (qemu_tolower(name[0]) != 'v' || strlen(name) > 3) {
+        return false;
+    }
+
+    for (int i = 0; i < 32; i++) {
+        if (strcasecmp(name, riscv_rvv_regnames[i]) == 0) {
+            return true;
+        }
+    }
+
+    return false;
+}
+
+int target_get_monitor_def(CPUState *cs, const char *name, uint64_t *pval)
+{
+    CPURISCVState *env = &RISCV_CPU(cs)->env;
+    target_ulong val = 0;
+    uint64_t val64 = 0;
+    int i;
+
+    if (reg_is_ulong_integer(env, name, &val, false) ||
+        reg_is_ulong_integer(env, name, &val, true)) {
+        *pval = val;
+        return 0;
+    }
+
+    if (reg_is_u64_fpu(env, name, &val64)) {
+        *pval = val64;
+        return 0;
+    }
+
+    if (reg_is_vreg(name)) {
+        if (!riscv_cpu_cfg(env)->ext_zve32x) {
+            return -EINVAL;
+        }
+
+        qemu_printf("Unable to print the value of vector "
+                    "vreg '%s' from this API\n", name);
+
+        /*
+         * We're returning 0 because returning -EINVAL triggers
+         * an 'unknown register' message in exp_unary() later,
+         * which feels ankward after our own error message.
+         */
+        *pval = 0;
+        return 0;
+    }
+
+    for (i = 0; i < ARRAY_SIZE(csr_ops); i++) {
+        RISCVException res;
+        int csrno = i;
+
+        /*
+         * Early skip when possible since we're going
+         * through a lot of NULL entries.
+         */
+        if (csr_ops[csrno].predicate == NULL) {
+            continue;
+        }
+
+        if (strcasecmp(csr_ops[csrno].name, name) != 0) {
+            continue;
+        }
+
+        res = riscv_csrrw_debug(env, csrno, &val, 0, 0);
+
+        /*
+         * Rely on the smode, hmode, etc, predicates within csr.c
+         * to do the filtering of the registers that are present.
+         */
+        if (res == RISCV_EXCP_NONE) {
+            *pval = val;
+            return 0;
+        }
+    }
+
+    return -EINVAL;
+}
diff --git a/target/riscv/riscv-qmp-cmds.c b/target/riscv/riscv-qmp-cmds.c
index d5e9bec0f86..8a1856c50e0 100644
--- a/target/riscv/riscv-qmp-cmds.c
+++ b/target/riscv/riscv-qmp-cmds.c
@@ -31,10 +31,6 @@
 #include "qapi/qobject-input-visitor.h"
 #include "qapi/visitor.h"
 #include "qom/qom-qobject.h"
-#include "qemu/ctype.h"
-#include "qemu/qemu-print.h"
-#include "monitor/hmp.h"
-#include "monitor/hmp-target.h"
 #include "system/kvm.h"
 #include "system/tcg.h"
 #include "cpu-qom.h"
@@ -244,149 +240,3 @@ CpuModelExpansionInfo *qmp_query_cpu_model_expansion(CpuModelExpansionType type,
 
     return expansion_info;
 }
-
-/*
- * We have way too many potential CSRs and regs being added
- * regularly to register them in a static array.
- *
- * Declare an empty array instead, making get_monitor_def() use
- * the target_get_monitor_def() API directly.
- */
-const MonitorDef monitor_defs[] = { { } };
-const MonitorDef *target_monitor_defs(void)
-{
-    return monitor_defs;
-}
-
-static bool reg_is_ulong_integer(CPURISCVState *env, const char *name,
-                                 target_ulong *val, bool is_gprh)
-{
-    const char * const *reg_names;
-    target_ulong *vals;
-
-    if (is_gprh) {
-        reg_names = riscv_int_regnamesh;
-        vals = env->gprh;
-    } else {
-        reg_names = riscv_int_regnames;
-        vals = env->gpr;
-    }
-
-    for (int i = 0; i < 32; i++) {
-        g_auto(GStrv) reg_name = g_strsplit(reg_names[i], "/", 2);
-
-        g_assert(reg_name[0]);
-        g_assert(reg_name[1]);
-
-        if (g_ascii_strcasecmp(reg_name[0], name) == 0 ||
-            g_ascii_strcasecmp(reg_name[1], name) == 0) {
-            *val = vals[i];
-            return true;
-        }
-    }
-
-    return false;
-}
-
-static bool reg_is_u64_fpu(CPURISCVState *env, const char *name, uint64_t *val)
-{
-    if (qemu_tolower(name[0]) != 'f') {
-        return false;
-    }
-
-    for (int i = 0; i < 32; i++) {
-        g_auto(GStrv) reg_name = g_strsplit(riscv_fpr_regnames[i], "/", 2);
-
-        g_assert(reg_name[0]);
-        g_assert(reg_name[1]);
-
-        if (g_ascii_strcasecmp(reg_name[0], name) == 0 ||
-            g_ascii_strcasecmp(reg_name[1], name) == 0) {
-            *val = env->fpr[i];
-            return true;
-        }
-    }
-
-    return false;
-}
-
-static bool reg_is_vreg(const char *name)
-{
-    if (qemu_tolower(name[0]) != 'v' || strlen(name) > 3) {
-        return false;
-    }
-
-    for (int i = 0; i < 32; i++) {
-        if (strcasecmp(name, riscv_rvv_regnames[i]) == 0) {
-            return true;
-        }
-    }
-
-    return false;
-}
-
-int target_get_monitor_def(CPUState *cs, const char *name, uint64_t *pval)
-{
-    CPURISCVState *env = &RISCV_CPU(cs)->env;
-    target_ulong val = 0;
-    uint64_t val64 = 0;
-    int i;
-
-    if (reg_is_ulong_integer(env, name, &val, false) ||
-        reg_is_ulong_integer(env, name, &val, true)) {
-        *pval = val;
-        return 0;
-    }
-
-    if (reg_is_u64_fpu(env, name, &val64)) {
-        *pval = val64;
-        return 0;
-    }
-
-    if (reg_is_vreg(name)) {
-        if (!riscv_cpu_cfg(env)->ext_zve32x) {
-            return -EINVAL;
-        }
-
-        qemu_printf("Unable to print the value of vector "
-                    "vreg '%s' from this API\n", name);
-
-        /*
-         * We're returning 0 because returning -EINVAL triggers
-         * an 'unknown register' message in exp_unary() later,
-         * which feels ankward after our own error message.
-         */
-        *pval = 0;
-        return 0;
-    }
-
-    for (i = 0; i < ARRAY_SIZE(csr_ops); i++) {
-        RISCVException res;
-        int csrno = i;
-
-        /*
-         * Early skip when possible since we're going
-         * through a lot of NULL entries.
-         */
-        if (csr_ops[csrno].predicate == NULL) {
-            continue;
-        }
-
-        if (strcasecmp(csr_ops[csrno].name, name) != 0) {
-            continue;
-        }
-
-        res = riscv_csrrw_debug(env, csrno, &val, 0, 0);
-
-        /*
-         * Rely on the smode, hmode, etc, predicates within csr.c
-         * to do the filtering of the registers that are present.
-         */
-        if (res == RISCV_EXCP_NONE) {
-            *pval = val;
-            return 0;
-        }
-    }
-
-    return -EINVAL;
-}
-- 
2.52.0


