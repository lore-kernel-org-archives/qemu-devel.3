Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AA2F1C27C4F
	for <qemu-devel@archiver.kernel.org>; Sun, 16 Jun 2024 02:48:43 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sIfvK-0007P6-81; Sat, 15 Jun 2024 22:47:18 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <frank.chang@sifive.com>)
 id 1sIfvF-0007NM-JM
 for qemu-devel@nongnu.org; Sat, 15 Jun 2024 22:47:17 -0400
Received: from mail-pl1-x634.google.com ([2607:f8b0:4864:20::634])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <frank.chang@sifive.com>)
 id 1sIfvD-0001hW-UZ
 for qemu-devel@nongnu.org; Sat, 15 Jun 2024 22:47:13 -0400
Received: by mail-pl1-x634.google.com with SMTP id
 d9443c01a7336-1f480624d10so28588435ad.1
 for <qemu-devel@nongnu.org>; Sat, 15 Jun 2024 19:47:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sifive.com; s=google; t=1718506030; x=1719110830; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=LwRAet0mSxwn7I1Ml7pPtqRUk6TOfkcuiooaSBrc9bc=;
 b=TZIjMHr6gK/0X7VuaT7u6TjtPA+zWSTRV2QDToikjO8scBaDCuzpovmZ9GCGte5Fy/
 zf91oWU2FSl6EDNVCKFtAM9vk89EfTc4Djl+FNDKNqkpOFkwoYH5FBJUjsUu1CO2ueSz
 k2t+M92x0zx32OX3LGxPxH5dYPnqYKzOLd67XOJppnWZuMQMhcAkJNxg1OLz3JYfgst1
 g9TkGBqcaIQUzA2JLadQBuGIqShrWNprFZwqd4x4chquatXTSRFGHRXkDrI/Q4w6LRUE
 qYVf78Fdf0ULMQZg72tBi5zR4sHm9wjKyzEOpB3cuR1JRwvjJaG8ne3RP0ByUCs1BDG5
 saGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1718506030; x=1719110830;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=LwRAet0mSxwn7I1Ml7pPtqRUk6TOfkcuiooaSBrc9bc=;
 b=G6Y6NsfSuK2B9apw1MZ8/vW4LrIVKCAY82Vm6TcaLu1RXFEETJf+Y7wYf/wiRynHaL
 JpEkvK6WI2ZrEsHlUAvQ+DHhbFReKcTlemaVwxZXNhd4bwLiXmWDjbrT9/ZRFwSnr2ey
 M2ftxrJGE2tWM9tqkZfkk2pwJzTDKoBks6X/+uNJUw/M9/ZvdhTFtkuAPBQ7BM1/MPN5
 ktvmN3s0/+BmSjczWj2Un8b68Rxb54nOMi3T6897ZRcs1Z/yfT2cVQ/YYvvhzzukH5jX
 UXAkJrpoc/RJ7xLUL7iBdUHbm6RsW8+xdWo/pwToFv27MQZWjKV3W6hLpK7usHwWnxaz
 8aTA==
X-Gm-Message-State: AOJu0YxaeVPpZIO+PGxuSUVuGaxjhGBZjDXC3iQyEn32NLIf6wFm0eid
 MZulIbnRkXFquqospabt0kJY1DK8eKx3gKWYdySe9Hf1Zr+VvmZbFgfw3wuHMpS0AHKzm9ztkY5
 S/TD/5Qezw7YgnBlb93NTnVOBUrQHw1GJ5/eZL5EgfAgLWVqezUxS/tFQl/g+KyioYb8oBIg/cA
 ElOBwMu9JJK1Z8oX5A34+BCsNKhZJ4ye1gVLDUyFE=
X-Google-Smtp-Source: AGHT+IF/vCFYU/v2WIebT7m51cTFH2hbWo7OVrqdOAnfFq9PZAwq4QPJZSYfDLjHHOQN2nrQdpVjBQ==
X-Received: by 2002:a17:902:c943:b0:1f6:efd9:bec4 with SMTP id
 d9443c01a7336-1f8625cf93bmr87046655ad.19.1718506029564; 
 Sat, 15 Jun 2024 19:47:09 -0700 (PDT)
Received: from hsinchu16.internal.sifive.com
 (59-124-168-89.hinet-ip.hinet.net. [59.124.168.89])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-1f855e7ca78sm56258705ad.106.2024.06.15.19.47.07
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 15 Jun 2024 19:47:09 -0700 (PDT)
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
Subject: [PATCH v2 2/6] target/riscv: Introduce extension implied rule helpers
Date: Sun, 16 Jun 2024 10:46:53 +0800
Message-ID: <20240616024657.17948-3-frank.chang@sifive.com>
X-Mailer: git-send-email 2.43.2
In-Reply-To: <20240616024657.17948-1-frank.chang@sifive.com>
References: <20240616024657.17948-1-frank.chang@sifive.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::634;
 envelope-from=frank.chang@sifive.com; helo=mail-pl1-x634.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=unavailable autolearn_force=no
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
---
 target/riscv/tcg/tcg-cpu.c | 91 ++++++++++++++++++++++++++++++++++++++
 1 file changed, 91 insertions(+)

diff --git a/target/riscv/tcg/tcg-cpu.c b/target/riscv/tcg/tcg-cpu.c
index eb6f7b9d12..f8d6371764 100644
--- a/target/riscv/tcg/tcg-cpu.c
+++ b/target/riscv/tcg/tcg-cpu.c
@@ -36,6 +36,9 @@
 static GHashTable *multi_ext_user_opts;
 static GHashTable *misa_ext_user_opts;
 
+static GHashTable *misa_implied_rules;
+static GHashTable *ext_implied_rules;
+
 static bool cpu_cfg_ext_is_user_set(uint32_t ext_offset)
 {
     return g_hash_table_contains(multi_ext_user_opts,
@@ -836,11 +839,97 @@ static void riscv_cpu_validate_profiles(RISCVCPU *cpu)
     }
 }
 
+static void riscv_cpu_init_implied_exts_rules(void)
+{
+    RISCVCPUImpliedExtsRule *rule;
+    int i;
+
+    for (i = 0; (rule = riscv_misa_implied_rules[i]); i++) {
+        g_hash_table_insert(misa_implied_rules, GUINT_TO_POINTER(rule->ext),
+                            (gpointer)rule);
+    }
+
+    for (i = 0; (rule = riscv_ext_implied_rules[i]); i++) {
+        g_hash_table_insert(ext_implied_rules, GUINT_TO_POINTER(rule->ext),
+                            (gpointer)rule);
+    }
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
+    enabled = qatomic_read(&rule->enabled) & BIT_ULL(cpu->env.mhartid);
+#endif
+
+    if (!enabled) {
+        /* Enable the implied MISAs. */
+        if (rule->implied_misas) {
+            riscv_cpu_set_misa_ext(env, env->misa_ext | rule->implied_misas);
+
+            for (i = 0; misa_bits[i] != 0; i++) {
+                if (rule->implied_misas & misa_bits[i]) {
+                    ir = g_hash_table_lookup(misa_implied_rules,
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
+        for (i = 0; rule->implied_exts[i] != RISCV_IMPLIED_EXTS_RULE_END; i++) {
+            cpu_cfg_ext_auto_update(cpu, rule->implied_exts[i], true);
+
+            ir = g_hash_table_lookup(ext_implied_rules,
+                                     GUINT_TO_POINTER(rule->implied_exts[i]));
+
+            if (ir) {
+                cpu_enable_implied_rule(cpu, ir);
+            }
+        }
+
+#ifndef CONFIG_USER_ONLY
+        qatomic_or(&rule->enabled, BIT_ULL(cpu->env.mhartid));
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
+    for (i = 0; (rule = riscv_misa_implied_rules[i]); i++) {
+        if (riscv_has_ext(&cpu->env, rule->ext)) {
+            cpu_enable_implied_rule(cpu, rule);
+        }
+    }
+
+    /* Enable the implied extensions. */
+    for (i = 0; (rule = riscv_ext_implied_rules[i]); i++) {
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
@@ -1346,6 +1435,8 @@ static void riscv_tcg_cpu_instance_init(CPUState *cs)
 
     misa_ext_user_opts = g_hash_table_new(NULL, g_direct_equal);
     multi_ext_user_opts = g_hash_table_new(NULL, g_direct_equal);
+    misa_implied_rules = g_hash_table_new(NULL, g_direct_equal);
+    ext_implied_rules = g_hash_table_new(NULL, g_direct_equal);
     riscv_cpu_add_user_properties(obj);
 
     if (riscv_cpu_has_max_extensions(obj)) {
-- 
2.43.2


