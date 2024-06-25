Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CF6D4C2BBCA
	for <qemu-devel@archiver.kernel.org>; Tue, 25 Jun 2024 11:47:47 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sM4da-00080u-Eo; Tue, 25 Jun 2024 07:47:03 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <frank.chang@sifive.com>)
 id 1sM4dW-0007zQ-5M
 for qemu-devel@nongnu.org; Tue, 25 Jun 2024 07:46:58 -0400
Received: from mail-pl1-x629.google.com ([2607:f8b0:4864:20::629])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <frank.chang@sifive.com>)
 id 1sM4dU-0000br-CE
 for qemu-devel@nongnu.org; Tue, 25 Jun 2024 07:46:57 -0400
Received: by mail-pl1-x629.google.com with SMTP id
 d9443c01a7336-1f47f07acd3so44296975ad.0
 for <qemu-devel@nongnu.org>; Tue, 25 Jun 2024 04:46:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sifive.com; s=google; t=1719316014; x=1719920814; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Lg8MxT2h6w0U7cvVpXZNAg3eMePk9LI4d9l/QDEEcJo=;
 b=Npvcvly/O1kDnXLeWwrBzrGT0KFZseOnkK51K0YpXyFBtN9uryaQ8FOzhwLxCxT5n7
 /FZAxLOAFIirieSCPPmXftOvmrFUjYji/Dl4v4mfx60/qmsTkLjmymaleEPJMFKvjkcY
 zaxxif2BPaMZdS39xrsD7sQfSxb0A94GkkWNF+x7W/A4EY3ItkHFrWrRONUZdBxukvZD
 MXSYNq3Q/7Yx9aCCaQ88D3rCwE9XoYcqxZfgvYybOygTdnavsQ65JzfgrAcydWyj23ni
 t796Sl8mLmKPQOmewgl8RjJA2U58FTW2hWxdImatjeHAFtGrvTH291cHLekHFSAFPKUU
 iPJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1719316014; x=1719920814;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Lg8MxT2h6w0U7cvVpXZNAg3eMePk9LI4d9l/QDEEcJo=;
 b=MbLzCqPVCVC11GKNzKymIJWxp2Jby3zjfibjGJbDj5z5+4279e/fGUQRF+wLDIKVDg
 pbyXrphs2c6cHBZazWvsQg3HJihSkQ+9oe1mJ6m/8CrDcacp48qlzrzgVvpWyL7CTKHC
 4d6o596EYJNj+S771PL98uSshw6v2XQSY3BW2tJkeG1nNE1UCTUAuIzG06wruedAhXN8
 EV80IPdEmsfREkRa5+gMaE6qj++CEMGCtwCZWPuiTR0DBZRYMzCHkULubvzG7Ui2c5MH
 BXhNukNjL0B1YAyv4dF8IPQ1pgg4PY+HAQtV8gxkc4KklsaYcnNadK1kH0Q3vFbORPK7
 JTXQ==
X-Gm-Message-State: AOJu0YyGIiiMzMoHHsi+3ip515duD0R78XJ3dQeGZDt9f2i41NUjznGP
 q1sFPrZ+n+A4WtirjRpbSwkkkGYoYdDJfzjU945kILIGeK59PKteyclwuTKabsUMZSw9qsNVmDX
 TxmYR3KV6vrlXxSh7hkC6UUJpzV6txsxesejVgzHgme+UOZCrBMmfpTtW+y2OcqQeJR5P+u9HZg
 uAKK/lcPyWQ41UpaO3fjGERER9OVIC0rraaB25rAv/1e3M
X-Google-Smtp-Source: AGHT+IEOxT/XJTa+NTqDPIcygySFt9QDuEkRZ4vwFNgbMK7UCbykKJ/FkvwtRdPxiGJEn7LmVarwKQ==
X-Received: by 2002:a17:903:41c8:b0:1f9:f1e1:da72 with SMTP id
 d9443c01a7336-1fa1d68bf60mr95506505ad.63.1719316014424; 
 Tue, 25 Jun 2024 04:46:54 -0700 (PDT)
Received: from hsinchu16.internal.sifive.com
 (59-124-168-89.hinet-ip.hinet.net. [59.124.168.89])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-1f9eb321d4esm79472325ad.67.2024.06.25.04.46.52
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 25 Jun 2024 04:46:54 -0700 (PDT)
From: frank.chang@sifive.com
To: qemu-devel@nongnu.org
Cc: Palmer Dabbelt <palmer@dabbelt.com>,
 Alistair Francis <alistair.francis@wdc.com>, Bin Meng <bmeng.cn@gmail.com>,
 Weiwei Li <liwei1518@gmail.com>,
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>,
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>,
 qemu-riscv@nongnu.org (open list:RISC-V TCG CPUs),
 Frank Chang <frank.chang@sifive.com>,
 Jerry Zhang Jian <jerry.zhangjian@sifive.com>,
 Max Chou <max.chou@sifive.com>
Subject: [PATCH v3 2/6] target/riscv: Introduce extension implied rule helpers
Date: Tue, 25 Jun 2024 19:46:25 +0800
Message-ID: <20240625114629.27793-3-frank.chang@sifive.com>
X-Mailer: git-send-email 2.43.2
In-Reply-To: <20240625114629.27793-1-frank.chang@sifive.com>
References: <20240625114629.27793-1-frank.chang@sifive.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::629;
 envelope-from=frank.chang@sifive.com; helo=mail-pl1-x629.google.com
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
2.43.2


