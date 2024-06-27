Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 54E85C2BD09
	for <qemu-devel@archiver.kernel.org>; Thu, 27 Jun 2024 10:04:55 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sMlxl-0007U8-EO; Thu, 27 Jun 2024 06:02:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1sMlxX-00073Q-Bi
 for qemu-devel@nongnu.org; Thu, 27 Jun 2024 06:02:33 -0400
Received: from mail-pf1-x436.google.com ([2607:f8b0:4864:20::436])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1sMlxU-00029E-EF
 for qemu-devel@nongnu.org; Thu, 27 Jun 2024 06:02:30 -0400
Received: by mail-pf1-x436.google.com with SMTP id
 d2e1a72fcca58-7041053c0fdso4624129b3a.3
 for <qemu-devel@nongnu.org>; Thu, 27 Jun 2024 03:02:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1719482546; x=1720087346; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=OSFAAtkK04aUf0dxdh06bjVR315nH132+u1Sn1Pe3ZU=;
 b=VZdiLPZ7xdVbAcMocFvXmjmt98lhVH7VB4Ez5DET8fS97evr2TgeyedHdYsBjM2ROj
 kL0eSfKi/QsbFAFyQFSa7pxZrO6pqwjwF6ZUVbgOvJnhDlV23+UOolHX6GrbDLk17v3W
 wbQ4CN6deYHnrY3ISyuFZtsgHYdShTsxNxU7un793wQaGxJL+xaGF/et/VakRFmhnN91
 IS8/bRYoAcMERayfXV+AAkHK8/SdaMeLaEGhlsdqhpwqHKfdrvnCfIae3JBtHIuNq0MG
 iwEpDxwmWj6pvQfvblp/qIjBiM88CP3GRjviqfRNA/ZL9GpaGrLzgEB1PGblIn25OPI5
 PFmA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1719482546; x=1720087346;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=OSFAAtkK04aUf0dxdh06bjVR315nH132+u1Sn1Pe3ZU=;
 b=G3OywOD///UZWDt9KnO/BQ8HNNZkN4mKt+IjO7vgkKzpHYtebeQcnMvv9SMToqJXiX
 3OrkdNOpWlvzG9DZ0M3eRaEIHPKRly3KQR+5SIj02K+g/LagAQh19vmCAv2g9OYN//ud
 aM1anostwGS0b4YXWFNpVuDgpIIFXVLJ8BXnp4zGu5jLJvRrrECz6fKt4Tcg7r1qjTdX
 Ti34F6X2y2xr5iV2aiamP4eTq9pJdhVX1P5DUvaBgRUYZPsEhoiAqECDP9kKs2scyOtU
 fe0Fv+9n6WC0ovWWlFPz/LJTsm2UNjH+VbW7be3CmXjV4D1ICvERth5EsLd5kSgbLSqt
 xcHg==
X-Gm-Message-State: AOJu0YyNWdqXs4YYKNar+a6AZp8ftqrED+VozDa0Hqm34GiVhOlP9Qa7
 HGIRzqZ89z1kp4LiOw3ws+Dxr8SK0UiVXnysmoAqKsGnKq4OTyDLPcpPgp/q
X-Google-Smtp-Source: AGHT+IHyoOLGVL3sT60nT6pbfROBT3jUwBAEqpogpcc9ozdxI9JIqMG1m7nplZiwhF+KfR3/4nKyLw==
X-Received: by 2002:aa7:8614:0:b0:706:73bc:50b7 with SMTP id
 d2e1a72fcca58-706745b42fdmr11789387b3a.16.1719482545664; 
 Thu, 27 Jun 2024 03:02:25 -0700 (PDT)
Received: from toolbox.alistair23.me
 (2403-580b-97e8-0-82ce-f179-8a79-69f4.ip6.aussiebb.net.
 [2403:580b:97e8:0:82ce:f179:8a79:69f4])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-706b4a07326sm932431b3a.111.2024.06.27.03.02.22
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 27 Jun 2024 03:02:25 -0700 (PDT)
From: Alistair Francis <alistair23@gmail.com>
X-Google-Original-From: Alistair Francis <alistair.francis@wdc.com>
To: qemu-devel@nongnu.org
Cc: alistair23@gmail.com, Frank Chang <frank.chang@sifive.com>,
 Jerry Zhang Jian <jerry.zhangjian@sifive.com>,
 Max Chou <max.chou@sifive.com>,
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>,
 Alistair Francis <alistair.francis@wdc.com>
Subject: [PULL 25/32] target/riscv: Introduce extension implied rule helpers
Date: Thu, 27 Jun 2024 20:00:46 +1000
Message-ID: <20240627100053.150937-26-alistair.francis@wdc.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240627100053.150937-1-alistair.francis@wdc.com>
References: <20240627100053.150937-1-alistair.francis@wdc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::436;
 envelope-from=alistair23@gmail.com; helo=mail-pf1-x436.google.com
X-Spam_score_int: -17
X-Spam_score: -1.8
X-Spam_bar: -
X-Spam_report: (-1.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FREEMAIL_ENVFROM_END_DIGIT=0.25, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
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

From: Frank Chang <frank.chang@sifive.com>

Introduce helpers to enable the extensions based on the implied rules.
The implied extensions are enabled recursively, so we don't have to
expand all of them manually. This also eliminates the old-fashioned
ordering requirement. For example, Zvksg implies Zvks, Zvks implies
Zvksed, etc., removing the need to check the implied rules of Zvksg
before Zvks.

Signed-off-by: Frank Chang <frank.chang@sifive.com>
Reviewed-by: Jerry Zhang Jian <jerry.zhangjian@sifive.com>
Tested-by: Max Chou <max.chou@sifive.com>
Reviewed-by: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
Message-ID: <20240625114629.27793-3-frank.chang@sifive.com>
Signed-off-by: Alistair Francis <alistair.francis@wdc.com>
---
 target/riscv/tcg/tcg-cpu.c | 121 +++++++++++++++++++++++++++++++++++++
 1 file changed, 121 insertions(+)

diff --git a/target/riscv/tcg/tcg-cpu.c b/target/riscv/tcg/tcg-cpu.c
index eb6f7b9d12..1a3aef5bff 100644
--- a/target/riscv/tcg/tcg-cpu.c
+++ b/target/riscv/tcg/tcg-cpu.c
@@ -31,11 +31,17 @@
 #include "hw/core/accel-cpu.h"
 #include "hw/core/tcg-cpu-ops.h"
 #include "tcg/tcg.h"
+#ifndef CONFIG_USER_ONLY
+#include "hw/boards.h"
+#endif
 
 /* Hash that stores user set extensions */
 static GHashTable *multi_ext_user_opts;
 static GHashTable *misa_ext_user_opts;
 
+static GHashTable *multi_ext_implied_rules;
+static GHashTable *misa_ext_implied_rules;
+
 static bool cpu_cfg_ext_is_user_set(uint32_t ext_offset)
 {
     return g_hash_table_contains(multi_ext_user_opts,
@@ -836,11 +842,117 @@ static void riscv_cpu_validate_profiles(RISCVCPU *cpu)
     }
 }
 
+static void riscv_cpu_init_implied_exts_rules(void)
+{
+    RISCVCPUImpliedExtsRule *rule;
+#ifndef CONFIG_USER_ONLY
+    MachineState *ms = MACHINE(qdev_get_machine());
+#endif
+    static bool initialized;
+    int i;
+
+    /* Implied rules only need to be initialized once. */
+    if (initialized) {
+        return;
+    }
+
+    for (i = 0; (rule = riscv_misa_ext_implied_rules[i]); i++) {
+#ifndef CONFIG_USER_ONLY
+        rule->enabled = bitmap_new(ms->smp.cpus);
+#endif
+        g_hash_table_insert(misa_ext_implied_rules,
+                            GUINT_TO_POINTER(rule->ext), (gpointer)rule);
+    }
+
+    for (i = 0; (rule = riscv_multi_ext_implied_rules[i]); i++) {
+#ifndef CONFIG_USER_ONLY
+        rule->enabled = bitmap_new(ms->smp.cpus);
+#endif
+        g_hash_table_insert(multi_ext_implied_rules,
+                            GUINT_TO_POINTER(rule->ext), (gpointer)rule);
+    }
+
+    initialized = true;
+}
+
+static void cpu_enable_implied_rule(RISCVCPU *cpu,
+                                    RISCVCPUImpliedExtsRule *rule)
+{
+    CPURISCVState *env = &cpu->env;
+    RISCVCPUImpliedExtsRule *ir;
+    bool enabled = false;
+    int i;
+
+#ifndef CONFIG_USER_ONLY
+    enabled = test_bit(cpu->env.mhartid, rule->enabled);
+#endif
+
+    if (!enabled) {
+        /* Enable the implied MISAs. */
+        if (rule->implied_misa_exts) {
+            riscv_cpu_set_misa_ext(env,
+                                   env->misa_ext | rule->implied_misa_exts);
+
+            for (i = 0; misa_bits[i] != 0; i++) {
+                if (rule->implied_misa_exts & misa_bits[i]) {
+                    ir = g_hash_table_lookup(misa_ext_implied_rules,
+                                             GUINT_TO_POINTER(misa_bits[i]));
+
+                    if (ir) {
+                        cpu_enable_implied_rule(cpu, ir);
+                    }
+                }
+            }
+        }
+
+        /* Enable the implied extensions. */
+        for (i = 0;
+             rule->implied_multi_exts[i] != RISCV_IMPLIED_EXTS_RULE_END; i++) {
+            cpu_cfg_ext_auto_update(cpu, rule->implied_multi_exts[i], true);
+
+            ir = g_hash_table_lookup(multi_ext_implied_rules,
+                                     GUINT_TO_POINTER(
+                                         rule->implied_multi_exts[i]));
+
+            if (ir) {
+                cpu_enable_implied_rule(cpu, ir);
+            }
+        }
+
+#ifndef CONFIG_USER_ONLY
+        bitmap_set(rule->enabled, cpu->env.mhartid, 1);
+#endif
+    }
+}
+
+static void riscv_cpu_enable_implied_rules(RISCVCPU *cpu)
+{
+    RISCVCPUImpliedExtsRule *rule;
+    int i;
+
+    /* Enable the implied MISAs. */
+    for (i = 0; (rule = riscv_misa_ext_implied_rules[i]); i++) {
+        if (riscv_has_ext(&cpu->env, rule->ext)) {
+            cpu_enable_implied_rule(cpu, rule);
+        }
+    }
+
+    /* Enable the implied extensions. */
+    for (i = 0; (rule = riscv_multi_ext_implied_rules[i]); i++) {
+        if (isa_ext_is_enabled(cpu, rule->ext)) {
+            cpu_enable_implied_rule(cpu, rule);
+        }
+    }
+}
+
 void riscv_tcg_cpu_finalize_features(RISCVCPU *cpu, Error **errp)
 {
     CPURISCVState *env = &cpu->env;
     Error *local_err = NULL;
 
+    riscv_cpu_init_implied_exts_rules();
+    riscv_cpu_enable_implied_rules(cpu);
+
     riscv_cpu_validate_misa_priv(env, &local_err);
     if (local_err != NULL) {
         error_propagate(errp, local_err);
@@ -1346,6 +1458,15 @@ static void riscv_tcg_cpu_instance_init(CPUState *cs)
 
     misa_ext_user_opts = g_hash_table_new(NULL, g_direct_equal);
     multi_ext_user_opts = g_hash_table_new(NULL, g_direct_equal);
+
+    if (!misa_ext_implied_rules) {
+        misa_ext_implied_rules = g_hash_table_new(NULL, g_direct_equal);
+    }
+
+    if (!multi_ext_implied_rules) {
+        multi_ext_implied_rules = g_hash_table_new(NULL, g_direct_equal);
+    }
+
     riscv_cpu_add_user_properties(obj);
 
     if (riscv_cpu_has_max_extensions(obj)) {
-- 
2.45.2


