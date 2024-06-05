Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EF4B8C27C52
	for <qemu-devel@archiver.kernel.org>; Wed,  5 Jun 2024 06:33:59 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sEkC7-0000qg-2z; Wed, 05 Jun 2024 02:32:23 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <frank.chang@sifive.com>)
 id 1sEkC1-0000pG-Ln
 for qemu-devel@nongnu.org; Wed, 05 Jun 2024 02:32:18 -0400
Received: from mail-pl1-x62c.google.com ([2607:f8b0:4864:20::62c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <frank.chang@sifive.com>)
 id 1sEkBz-0007Cf-S4
 for qemu-devel@nongnu.org; Wed, 05 Jun 2024 02:32:17 -0400
Received: by mail-pl1-x62c.google.com with SMTP id
 d9443c01a7336-1f67fa9cd73so4190415ad.0
 for <qemu-devel@nongnu.org>; Tue, 04 Jun 2024 23:32:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sifive.com; s=google; t=1717569133; x=1718173933; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=zVOTR43HcgbvIn3YleZS8zeRjL9HK8Z6y/SKuVXGXbk=;
 b=BVi1qQz9JGQqF27zdMv0btznSeijszwUTdzK2pMs9DZeelwUAQKVOOUT4Vpt2ClfV1
 M2VsMi1dwUfl1MCQKM3Y+qg069BHhnPh92mxreB53D1z8Sk+3g3ecxNZdxfvcJeW/Otv
 QwX7j8jLQ0lLzZyJ9nJQC7dGx1Z4S+u8WxNWG/R1RhV1/od2CWWZxOV6nWKoQezPj5CH
 NYb5I0DYrG2iOCoEiXAXAIIl4M01Y+LWrVehtHixFD3ZMATfJ1nYNXDHmFtn2ln6fcoW
 adMFsujl11L+D2DFrv7KGrKuPLlG8bKWd5q/HsSyAJX+16PVQszuzBhQiQ7wjOzFH+FR
 FjhA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1717569133; x=1718173933;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=zVOTR43HcgbvIn3YleZS8zeRjL9HK8Z6y/SKuVXGXbk=;
 b=p9cXbPYo3lNQlCInvpqlC+Wqd6Hz/jtmSsqJQu9NPwFC8XS/nF+NSZDJisEFCzqQNT
 gNXAA8b6st9GeZLw6nmQ8hI76UKyotPyCcbFMq1seXwVjNyPzI8Jq/MxXNiPwRhyUBJg
 ag/w7ptQ6/99FoFse2wr3zy5Z1xz1gX1f5WTCbrKyda6xdZmJHP1pt+r+wmXMMK2HFtD
 KEve+SWotDc1kWZ5IKLAlJEfuTa3TRPoFZD9fwW97ViF9xL7ozWUqnEbLhqjb/D0nSvZ
 WYwkleaLPln5rsYPo4boYAZ/Q+BrpEH1meY/UOqEVw5FWEaz+7ZqCjLrSyeHRvWj26C7
 uT+A==
X-Gm-Message-State: AOJu0YzyhJIncgfA7ucUW+Nl5haCC0/oBwlTw3YbKOAfUffGQZ/1E0wr
 OxPqWjiyjA5QwWrK51uF+gci/LjG/HDobsK4nbbzaiTjwd7yTO+8hOOZRZ1dGvo86wwMjrW4vUs
 DTD958vyWeSZwED+n6j5KTdAGBLbjZOCSojcUu45/Bbnaz08xJXBBl06pM5W096DvgDJ2CXL435
 rzW63ryqG7CCxS/auy7tsYTzyjwl9kZlNpmY/ku0ZrXQ==
X-Google-Smtp-Source: AGHT+IEM+Gn58yeWZDynkvg5cbZfpbNpqtUTvrLZFok2XkiYm98pqR8D85wJv+jkVfQw9xb5IU6eQw==
X-Received: by 2002:a17:902:ea07:b0:1f6:87f:1156 with SMTP id
 d9443c01a7336-1f6a55b363fmr26563995ad.0.1717569132831; 
 Tue, 04 Jun 2024 23:32:12 -0700 (PDT)
Received: from hsinchu16.internal.sifive.com
 (59-124-168-89.hinet-ip.hinet.net. [59.124.168.89])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-1f632356c84sm94819725ad.76.2024.06.04.23.32.10
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 04 Jun 2024 23:32:12 -0700 (PDT)
From: frank.chang@sifive.com
To: qemu-devel@nongnu.org
Cc: Palmer Dabbelt <palmer@dabbelt.com>,
 Alistair Francis <alistair.francis@wdc.com>, Bin Meng <bmeng.cn@gmail.com>,
 Weiwei Li <liwei1518@gmail.com>,
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>,
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>,
 qemu-riscv@nongnu.org (open list:RISC-V TCG CPUs),
 Frank Chang <frank.chang@sifive.com>
Subject: [PATCH RESEND 2/6] target/riscv: Introduce extension implied rule
 helpers
Date: Wed,  5 Jun 2024 14:31:50 +0800
Message-ID: <20240605063154.31298-3-frank.chang@sifive.com>
X-Mailer: git-send-email 2.43.2
In-Reply-To: <20240605063154.31298-1-frank.chang@sifive.com>
References: <20240605063154.31298-1-frank.chang@sifive.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62c;
 envelope-from=frank.chang@sifive.com; helo=mail-pl1-x62c.google.com
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
---
 target/riscv/tcg/tcg-cpu.c | 89 ++++++++++++++++++++++++++++++++++++++
 1 file changed, 89 insertions(+)

diff --git a/target/riscv/tcg/tcg-cpu.c b/target/riscv/tcg/tcg-cpu.c
index 683f604d9f..899d605d36 100644
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
@@ -833,11 +836,95 @@ static void riscv_cpu_validate_profiles(RISCVCPU *cpu)
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
+    target_ulong hartid = 0;
+    int i;
+
+#if !defined(CONFIG_USER_ONLY)
+    hartid = env->mhartid;
+#endif
+
+    if (!(rule->enabled & BIT_ULL(hartid))) {
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
+        rule->enabled |= BIT_ULL(hartid);
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
@@ -1343,6 +1430,8 @@ static void riscv_tcg_cpu_instance_init(CPUState *cs)
 
     misa_ext_user_opts = g_hash_table_new(NULL, g_direct_equal);
     multi_ext_user_opts = g_hash_table_new(NULL, g_direct_equal);
+    misa_implied_rules = g_hash_table_new(NULL, g_direct_equal);
+    ext_implied_rules = g_hash_table_new(NULL, g_direct_equal);
     riscv_cpu_add_user_properties(obj);
 
     if (riscv_cpu_has_max_extensions(obj)) {
-- 
2.43.2


