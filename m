Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 09E44C3DA63
	for <qemu-devel@archiver.kernel.org>; Tue, 23 Jul 2024 23:33:01 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sWOy6-0002tq-DK; Tue, 23 Jul 2024 19:30:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <atishp@rivosinc.com>)
 id 1sWOxw-0002Km-0d
 for qemu-devel@nongnu.org; Tue, 23 Jul 2024 19:30:45 -0400
Received: from mail-pj1-x102e.google.com ([2607:f8b0:4864:20::102e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <atishp@rivosinc.com>)
 id 1sWOxp-0007y6-Ml
 for qemu-devel@nongnu.org; Tue, 23 Jul 2024 19:30:42 -0400
Received: by mail-pj1-x102e.google.com with SMTP id
 98e67ed59e1d1-2cb55418470so3136392a91.1
 for <qemu-devel@nongnu.org>; Tue, 23 Jul 2024 16:30:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=rivosinc-com.20230601.gappssmtp.com; s=20230601; t=1721777433; x=1722382233;
 darn=nongnu.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=RA26pTTCCGZrMwpdrKiBc0SSPwJQN39A/vQ5CD8f/Ik=;
 b=IsXdODkZs+yOIsfGsqt7uOkaOyYQHPUsANbmCuMfsBV+aM9BFtCbyv+EYZjatefluq
 peMbmq1bhVsrMsLyXsYvbf0KgEd6AIivmeAE1Is57BP0trGxLD9ImFvONb1HVN3l3341
 PZO3IyFvALo3sqQBMMu0raAMUmT7QM/AaM0N+vpgEeZtdiU1Xqe89z+Z6Ya79bSIlNzD
 mvJLHRSHfLZdFoUwiQxd8MiidZ+WD47s2v7BivDaqWUE7jk1SXDLq/O42K151nyvSYyV
 35okYqAR9zDWjsuKaoz1SL4f3+BnlSYIhw6rTqcvp2cRx0Ps+KmXQWtvdee9h3t6vEnD
 oyHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1721777433; x=1722382233;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=RA26pTTCCGZrMwpdrKiBc0SSPwJQN39A/vQ5CD8f/Ik=;
 b=nlwexpekOzOYkJ/qm3UjKh0Xb7eL9YTYu9zYs0LjbvtYzyHl2uZDQ7kiUODXNBYbHY
 wOEQvfi5fwO2EzvIvFrOmonCdS/snNb3hi13BVTjF9BSpoHSLT+mqZDokr+tshOE5f9Z
 jL017+q7ykNQTXC35oqcq7m00utIqs2zuldNOqkzYkRJDSWoK65Q9elhTRzM3ALYgoI3
 wgfNn4wPCV4FtxbFvE6EFYEhaShqY7ZvA65zY58cDKvI1mkbOgWpW6hKAcd4+KI7qq6a
 ip8J9vAKy6oBlqN2nhOXFJtp6iw7SSu+j92+EN/39+QJurZ4lfsDXQlw6N8INASzmozG
 z/qA==
X-Forwarded-Encrypted: i=1;
 AJvYcCVJkUPvR2Zj7GAEqqB5VqI1LXIVKAVJRyIb3YBdj3XgJ+Cy/PfivU9gS9fsrNU9eMM1qIPXA7xTLvKfOp7Z2zykMGXVLRQ=
X-Gm-Message-State: AOJu0YwwOomc/J0FNROIfW0V/BUcE3gdu5fFxburQ6uEIjPFVOi8a0vw
 j/b87+zd6IXryQJPjHO4WPh6VlLBcJT3X8xx6v2PioBjmeTDKUX8xuoCYoxrD/0=
X-Google-Smtp-Source: AGHT+IFn6T8UUPLvJ8lAom0orLgIB6YlSSvE4DjPyecnjT5NqeUo8OINB5Byiv45uhr9LJFHlGXzzQ==
X-Received: by 2002:a17:90b:390e:b0:2c9:8b33:3197 with SMTP id
 98e67ed59e1d1-2cdae35852fmr1368962a91.10.1721777432784; 
 Tue, 23 Jul 2024 16:30:32 -0700 (PDT)
Received: from atishp.ba.rivosinc.com ([64.71.180.162])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-2cdb74e894csm179217a91.41.2024.07.23.16.30.31
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 23 Jul 2024 16:30:32 -0700 (PDT)
From: Atish Patra <atishp@rivosinc.com>
Date: Tue, 23 Jul 2024 16:30:08 -0700
Subject: [PATCH v2 11/13] target/riscv: Repurpose the implied rule
 startergy
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240723-counter_delegation-v2-11-c4170a5348ca@rivosinc.com>
References: <20240723-counter_delegation-v2-0-c4170a5348ca@rivosinc.com>
In-Reply-To: <20240723-counter_delegation-v2-0-c4170a5348ca@rivosinc.com>
To: qemu-riscv@nongnu.org, qemu-devel@nongnu.org
Cc: palmer@dabbelt.com, liwei1518@gmail.com, zhiwei_liu@linux.alibaba.com, 
 bin.meng@windriver.com, dbarboza@ventanamicro.com, alistair.francis@wdc.com
X-Mailer: b4 0.15-dev-13183
Received-SPF: pass client-ip=2607:f8b0:4864:20::102e;
 envelope-from=atishp@rivosinc.com; helo=mail-pj1-x102e.google.com
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

The current infrastructure for implied ISA extension enabling can
be used for other cases where a particular ISA is dependant on
multiple other ISA extension to enable all the features.

Rename the implied rule functions/data structures to accomodate that.

Signed-off-by: Atish Patra <atishp@rivosinc.com>
---
 target/riscv/tcg/tcg-cpu.c | 32 ++++++++++++++++----------------
 1 file changed, 16 insertions(+), 16 deletions(-)

diff --git a/target/riscv/tcg/tcg-cpu.c b/target/riscv/tcg/tcg-cpu.c
index d78d5960cf30..1c9a87029423 100644
--- a/target/riscv/tcg/tcg-cpu.c
+++ b/target/riscv/tcg/tcg-cpu.c
@@ -40,7 +40,7 @@
 static GHashTable *multi_ext_user_opts;
 static GHashTable *misa_ext_user_opts;
 
-static GHashTable *multi_ext_implied_rules;
+static GHashTable *multi_ext_enabling_rules;
 static GHashTable *misa_ext_implied_rules;
 
 static bool cpu_cfg_ext_is_user_set(uint32_t ext_offset)
@@ -730,7 +730,7 @@ static void riscv_cpu_validate_profiles(RISCVCPU *cpu)
     }
 }
 
-static void riscv_cpu_init_implied_exts_rules(void)
+static void riscv_cpu_init_ext_rules(void)
 {
     RISCVCPUImpliedExtsRule *rule;
 #ifndef CONFIG_USER_ONLY
@@ -756,14 +756,14 @@ static void riscv_cpu_init_implied_exts_rules(void)
 #ifndef CONFIG_USER_ONLY
         rule->enabled = bitmap_new(ms->smp.cpus);
 #endif
-        g_hash_table_insert(multi_ext_implied_rules,
+        g_hash_table_insert(multi_ext_enabling_rules,
                             GUINT_TO_POINTER(rule->ext), (gpointer)rule);
     }
 
     initialized = true;
 }
 
-static void cpu_enable_implied_rule(RISCVCPU *cpu,
+static void cpu_enable_ext_rule(RISCVCPU *cpu,
                                     RISCVCPUImpliedExtsRule *rule)
 {
     CPURISCVState *env = &cpu->env;
@@ -787,7 +787,7 @@ static void cpu_enable_implied_rule(RISCVCPU *cpu,
                                              GUINT_TO_POINTER(misa_bits[i]));
 
                     if (ir) {
-                        cpu_enable_implied_rule(cpu, ir);
+                        cpu_enable_ext_rule(cpu, ir);
                     }
                 }
             }
@@ -798,12 +798,12 @@ static void cpu_enable_implied_rule(RISCVCPU *cpu,
              rule->implied_multi_exts[i] != RISCV_IMPLIED_EXTS_RULE_END; i++) {
             cpu_cfg_ext_auto_update(cpu, rule->implied_multi_exts[i], true);
 
-            ir = g_hash_table_lookup(multi_ext_implied_rules,
-                                     GUINT_TO_POINTER(
-                                         rule->implied_multi_exts[i]));
+                ir = g_hash_table_lookup(multi_ext_enabling_rules,
+                                        GUINT_TO_POINTER(
+                                            rule->implied_multi_exts[i]));
 
             if (ir) {
-                cpu_enable_implied_rule(cpu, ir);
+                cpu_enable_ext_rule(cpu, ir);
             }
         }
 
@@ -844,7 +844,7 @@ static void cpu_enable_zc_implied_rules(RISCVCPU *cpu)
     }
 }
 
-static void riscv_cpu_enable_implied_rules(RISCVCPU *cpu)
+static void riscv_cpu_enable_ext_rules(RISCVCPU *cpu)
 {
     RISCVCPUImpliedExtsRule *rule;
     int i;
@@ -855,14 +855,14 @@ static void riscv_cpu_enable_implied_rules(RISCVCPU *cpu)
     /* Enable the implied MISAs. */
     for (i = 0; (rule = riscv_misa_ext_implied_rules[i]); i++) {
         if (riscv_has_ext(&cpu->env, rule->ext)) {
-            cpu_enable_implied_rule(cpu, rule);
+            cpu_enable_ext_rule(cpu, rule);
         }
     }
 
     /* Enable the implied extensions. */
     for (i = 0; (rule = riscv_multi_ext_implied_rules[i]); i++) {
         if (isa_ext_is_enabled(cpu, rule->ext)) {
-            cpu_enable_implied_rule(cpu, rule);
+            cpu_enable_ext_rule(cpu, rule);
         }
     }
 }
@@ -872,8 +872,8 @@ void riscv_tcg_cpu_finalize_features(RISCVCPU *cpu, Error **errp)
     CPURISCVState *env = &cpu->env;
     Error *local_err = NULL;
 
-    riscv_cpu_init_implied_exts_rules();
-    riscv_cpu_enable_implied_rules(cpu);
+    riscv_cpu_init_ext_rules();
+    riscv_cpu_enable_ext_rules(cpu);
 
     riscv_cpu_validate_misa_priv(env, &local_err);
     if (local_err != NULL) {
@@ -1385,8 +1385,8 @@ static void riscv_tcg_cpu_instance_init(CPUState *cs)
         misa_ext_implied_rules = g_hash_table_new(NULL, g_direct_equal);
     }
 
-    if (!multi_ext_implied_rules) {
-        multi_ext_implied_rules = g_hash_table_new(NULL, g_direct_equal);
+    if (!multi_ext_enabling_rules) {
+        multi_ext_enabling_rules = g_hash_table_new(NULL, g_direct_equal);
     }
 
     riscv_cpu_add_user_properties(obj);

-- 
2.34.1


