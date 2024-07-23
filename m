Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 73757C3DA64
	for <qemu-devel@archiver.kernel.org>; Tue, 23 Jul 2024 23:32:52 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sWOy7-0002yJ-Di; Tue, 23 Jul 2024 19:30:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <atishp@rivosinc.com>)
 id 1sWOxz-0002Tt-U2
 for qemu-devel@nongnu.org; Tue, 23 Jul 2024 19:30:47 -0400
Received: from mail-pj1-x1029.google.com ([2607:f8b0:4864:20::1029])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <atishp@rivosinc.com>)
 id 1sWOxr-0007zF-Mo
 for qemu-devel@nongnu.org; Tue, 23 Jul 2024 19:30:43 -0400
Received: by mail-pj1-x1029.google.com with SMTP id
 98e67ed59e1d1-2cb5243766dso3597476a91.0
 for <qemu-devel@nongnu.org>; Tue, 23 Jul 2024 16:30:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=rivosinc-com.20230601.gappssmtp.com; s=20230601; t=1721777437; x=1722382237;
 darn=nongnu.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=8g3egpPSQQCB4Jzut23yj1uXHYNkJTWfJCb9u6Ykb48=;
 b=BwXSjbXAXBx+ee0YqPviF7GoXGbJGZwnzlHtbjG3DgT3TT4w43AUfRwAa68OHx4rVD
 FoafECMyKihPatUBZQTPmJVok4O18rR/l8Wbzj8FQ0XvgNpjxqgnkTBPhQ9fJx0Lhi5t
 sl5/Qd4jsZxtbcdYgRCzXF8BW1B2ctHw0QbSEv5z04p1Bd3dW5+etgZ7jpdiR0r5wiX+
 /5jgOtLPksBkKw+2649h68z0P6/fRWYP7eBcUoiISILI7PyTE2OXYN5RRa3ZtOGf6gio
 xGAKo6iP7JxrSm/oS13O7bBswbcjNF4c4Z8Jg/zZc2yMlqJUGmU+PWY1ww3R131bICoj
 snwA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1721777437; x=1722382237;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=8g3egpPSQQCB4Jzut23yj1uXHYNkJTWfJCb9u6Ykb48=;
 b=AwrmE4E7fsxZKJkjsphLrAgXLf5WnmTUfqLWrwr6vEv9PMA+Y8vuk+uIlG1hTjN56W
 ZZMJ/m2TRVg8Sool6R2DtJoU6qIzRxYzWO5Tkm8LmCn3m5Fri564czJKiO4aPyvcLALD
 AV/KLHanLJ7icPEyCOEJztMS8D8ujUi83UitqANmQlaoLUuUBbI2KC/yy/BIlzBUa+3X
 1C3t+MMDOGsDkulvqyYcGHA9WzC1BzgweoEeAXcjKhkBXZAV3FL/55QKcdgHlV/wG1O6
 MugyQJ6gWU2H3g+sBAoEQvfYFMBXZlgTjeRzoXz6FhgWmiEKc93z214HivEz/n938x6n
 X6vg==
X-Forwarded-Encrypted: i=1;
 AJvYcCWGqtkNxdOU2HSKe6uc7uE2Zs1xRQyUVXT3YBHCGu4+nfY/awJDAILPadZczgfFEQ1ekefT3fAvtXi6H3yaHbfS0ck1gF0=
X-Gm-Message-State: AOJu0YwLkYk6nbezE0bY8PCcVlB8x+gbuFnrHzgOk2JSS6t0ArOByJuw
 oDxaJt4hrERYHtXo06S5J+Zw75z+y+zoImS/rI6zX8iQmQIWKCuIyy5rV97EP958j2lxWbbEvEg
 v
X-Google-Smtp-Source: AGHT+IHpOiDxe5VD8grEVKf0ieVZookbXdlomlpuMXrUs3iJpeqcWgNUeQ2jb0KHLHpKiVed0Q3AGg==
X-Received: by 2002:a17:90b:494:b0:2c9:6d07:18f4 with SMTP id
 98e67ed59e1d1-2cdb51bc73fmr614420a91.35.1721777434217; 
 Tue, 23 Jul 2024 16:30:34 -0700 (PDT)
Received: from atishp.ba.rivosinc.com ([64.71.180.162])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-2cdb74e894csm179217a91.41.2024.07.23.16.30.32
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 23 Jul 2024 16:30:33 -0700 (PDT)
From: Atish Patra <atishp@rivosinc.com>
Date: Tue, 23 Jul 2024 16:30:09 -0700
Subject: [PATCH v2 12/13] target/riscv: Add a preferred ISA extension rule
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240723-counter_delegation-v2-12-c4170a5348ca@rivosinc.com>
References: <20240723-counter_delegation-v2-0-c4170a5348ca@rivosinc.com>
In-Reply-To: <20240723-counter_delegation-v2-0-c4170a5348ca@rivosinc.com>
To: qemu-riscv@nongnu.org, qemu-devel@nongnu.org
Cc: palmer@dabbelt.com, liwei1518@gmail.com, zhiwei_liu@linux.alibaba.com, 
 bin.meng@windriver.com, dbarboza@ventanamicro.com, alistair.francis@wdc.com
X-Mailer: b4 0.15-dev-13183
Received-SPF: pass client-ip=2607:f8b0:4864:20::1029;
 envelope-from=atishp@rivosinc.com; helo=mail-pj1-x1029.google.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

In addition to the implied rule, a preferred rule will be useful
where an ISA extension may require a list of ISA extension to be
enabled to use all the features defined in that extension. All
these extensions may not be implied in the ISA.

This patch just introduces a new preferred rule which allows
to enable multiple extensions together without burdening the qemu
commandline user.

Signed-off-by: Atish Patra <atishp@rivosinc.com>
---
 target/riscv/cpu.c         |  4 ++++
 target/riscv/cpu.h         | 17 ++++++++++++++
 target/riscv/tcg/tcg-cpu.c | 57 ++++++++++++++++++++++++++++++++++++++++------
 3 files changed, 71 insertions(+), 7 deletions(-)

diff --git a/target/riscv/cpu.c b/target/riscv/cpu.c
index 393d1d67120e..22ba43c7ff2a 100644
--- a/target/riscv/cpu.c
+++ b/target/riscv/cpu.c
@@ -2665,6 +2665,10 @@ RISCVCPUImpliedExtsRule *riscv_multi_ext_implied_rules[] = {
     NULL
 };
 
+RISCVCPUPreferredExtsRule *riscv_multi_ext_preferred_rules[] = {
+    NULL
+};
+
 static Property riscv_cpu_properties[] = {
     DEFINE_PROP_BOOL("debug", RISCVCPU, cfg.debug, true),
 
diff --git a/target/riscv/cpu.h b/target/riscv/cpu.h
index af25550a4a54..d775866344f5 100644
--- a/target/riscv/cpu.h
+++ b/target/riscv/cpu.h
@@ -142,10 +142,27 @@ typedef struct riscv_cpu_implied_exts_rule {
     const uint32_t implied_multi_exts[];
 } RISCVCPUImpliedExtsRule;
 
+typedef struct riscv_cpu_preferred_exts_rule {
+#ifndef CONFIG_USER_ONLY
+    /*
+     * Bitmask indicates the rule enabled status for the harts.
+     * This enhancement is only available in system-mode QEMU,
+     * as we don't have a good way (e.g. mhartid) to distinguish
+     * the SMP cores in user-mode QEMU.
+     */
+    unsigned long *enabled;
+#endif
+    /* multi extension offset. */
+    const uint32_t ext;
+    const uint32_t preferred_multi_exts[];
+} RISCVCPUPreferredExtsRule;
+
 extern RISCVCPUImpliedExtsRule *riscv_misa_ext_implied_rules[];
 extern RISCVCPUImpliedExtsRule *riscv_multi_ext_implied_rules[];
+extern RISCVCPUPreferredExtsRule *riscv_multi_ext_preferred_rules[];
 
 #define RISCV_IMPLIED_EXTS_RULE_END -1
+#define RISCV_PREFRRED_EXTS_RULE_END RISCV_IMPLIED_EXTS_RULE_END
 
 #define MMU_USER_IDX 3
 
diff --git a/target/riscv/tcg/tcg-cpu.c b/target/riscv/tcg/tcg-cpu.c
index 1c9a87029423..d8f74720815a 100644
--- a/target/riscv/tcg/tcg-cpu.c
+++ b/target/riscv/tcg/tcg-cpu.c
@@ -32,6 +32,7 @@
 #include "hw/core/accel-cpu.h"
 #include "hw/core/tcg-cpu-ops.h"
 #include "tcg/tcg.h"
+#include <stdio.h>
 #ifndef CONFIG_USER_ONLY
 #include "hw/boards.h"
 #endif
@@ -733,6 +734,7 @@ static void riscv_cpu_validate_profiles(RISCVCPU *cpu)
 static void riscv_cpu_init_ext_rules(void)
 {
     RISCVCPUImpliedExtsRule *rule;
+    RISCVCPUPreferredExtsRule *prule;
 #ifndef CONFIG_USER_ONLY
     MachineState *ms = MACHINE(qdev_get_machine());
 #endif
@@ -760,22 +762,40 @@ static void riscv_cpu_init_ext_rules(void)
                             GUINT_TO_POINTER(rule->ext), (gpointer)rule);
     }
 
+    for (i = 0; (prule = riscv_multi_ext_preferred_rules[i]); i++) {
+#ifndef CONFIG_USER_ONLY
+        prule->enabled = bitmap_new(ms->smp.cpus);
+#endif
+        g_hash_table_insert(multi_ext_enabling_rules,
+                            GUINT_TO_POINTER(prule->ext), (gpointer)prule);
+    }
+
     initialized = true;
 }
 
 static void cpu_enable_ext_rule(RISCVCPU *cpu,
-                                    RISCVCPUImpliedExtsRule *rule)
+                                RISCVCPUImpliedExtsRule *rule,
+                                RISCVCPUPreferredExtsRule *prule)
 {
     CPURISCVState *env = &cpu->env;
     RISCVCPUImpliedExtsRule *ir;
+    RISCVCPUPreferredExtsRule *pr;
     bool enabled = false;
     int i;
 
 #ifndef CONFIG_USER_ONLY
-    enabled = test_bit(cpu->env.mhartid, rule->enabled);
+    if (rule) {
+        enabled = test_bit(cpu->env.mhartid, rule->enabled);
+    } else if (prule) {
+        enabled = test_bit(cpu->env.mhartid, prule->enabled);
+    } else {
+        return;
+    }
 #endif
+    if (enabled)
+        return;
 
-    if (!enabled) {
+    if (rule) {
         /* Enable the implied MISAs. */
         if (rule->implied_misa_exts) {
             riscv_cpu_set_misa_ext(env,
@@ -787,7 +807,7 @@ static void cpu_enable_ext_rule(RISCVCPU *cpu,
                                              GUINT_TO_POINTER(misa_bits[i]));
 
                     if (ir) {
-                        cpu_enable_ext_rule(cpu, ir);
+                        cpu_enable_ext_rule(cpu, ir, NULL);
                     }
                 }
             }
@@ -803,12 +823,27 @@ static void cpu_enable_ext_rule(RISCVCPU *cpu,
                                             rule->implied_multi_exts[i]));
 
             if (ir) {
-                cpu_enable_ext_rule(cpu, ir);
+                cpu_enable_ext_rule(cpu, ir, NULL);
             }
         }
 
 #ifndef CONFIG_USER_ONLY
         bitmap_set(rule->enabled, cpu->env.mhartid, 1);
+#endif
+    } else if (prule) {
+        /* Enable the preferred extensions. */
+        for (i = 0;
+          prule->preferred_multi_exts[i] != RISCV_PREFRRED_EXTS_RULE_END; i++) {
+            cpu_cfg_ext_auto_update(cpu, prule->preferred_multi_exts[i], true);
+            pr = g_hash_table_lookup(multi_ext_enabling_rules,
+                                     GUINT_TO_POINTER(
+                                     prule->preferred_multi_exts[i]));
+            if (pr) {
+                cpu_enable_ext_rule(cpu, NULL, prule);
+            }
+        }
+#ifndef CONFIG_USER_ONLY
+        bitmap_set(prule->enabled, cpu->env.mhartid, 1);
 #endif
     }
 }
@@ -847,6 +882,7 @@ static void cpu_enable_zc_implied_rules(RISCVCPU *cpu)
 static void riscv_cpu_enable_ext_rules(RISCVCPU *cpu)
 {
     RISCVCPUImpliedExtsRule *rule;
+    RISCVCPUPreferredExtsRule *prule;
     int i;
 
     /* Enable the implied extensions for Zc. */
@@ -855,14 +891,21 @@ static void riscv_cpu_enable_ext_rules(RISCVCPU *cpu)
     /* Enable the implied MISAs. */
     for (i = 0; (rule = riscv_misa_ext_implied_rules[i]); i++) {
         if (riscv_has_ext(&cpu->env, rule->ext)) {
-            cpu_enable_ext_rule(cpu, rule);
+            cpu_enable_ext_rule(cpu, rule, NULL);
         }
     }
 
     /* Enable the implied extensions. */
     for (i = 0; (rule = riscv_multi_ext_implied_rules[i]); i++) {
         if (isa_ext_is_enabled(cpu, rule->ext)) {
-            cpu_enable_ext_rule(cpu, rule);
+            cpu_enable_ext_rule(cpu, rule, NULL);
+        }
+    }
+
+    /* Enable the preferred extensions. */
+    for (i = 0; (prule = riscv_multi_ext_preferred_rules[i]); i++) {
+        if (isa_ext_is_enabled(cpu, prule->ext)) {
+            cpu_enable_ext_rule(cpu, NULL, prule);
         }
     }
 }

-- 
2.34.1


