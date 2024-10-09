Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8C010CED611
	for <qemu-devel@archiver.kernel.org>; Wed,  9 Oct 2024 23:11:18 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1syfnx-0006qB-34; Wed, 09 Oct 2024 19:09:17 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <atishp@rivosinc.com>)
 id 1syfnq-0006mq-KB
 for qemu-devel@nongnu.org; Wed, 09 Oct 2024 19:09:10 -0400
Received: from mail-pg1-x52e.google.com ([2607:f8b0:4864:20::52e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <atishp@rivosinc.com>)
 id 1syfnm-0000hK-W3
 for qemu-devel@nongnu.org; Wed, 09 Oct 2024 19:09:09 -0400
Received: by mail-pg1-x52e.google.com with SMTP id
 41be03b00d2f7-7d4fa972cbeso229077a12.2
 for <qemu-devel@nongnu.org>; Wed, 09 Oct 2024 16:09:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=rivosinc-com.20230601.gappssmtp.com; s=20230601; t=1728515345; x=1729120145;
 darn=nongnu.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=NNIhf0diuxJoxU55DlT10sYTiHd5YymT+dpY9nybit0=;
 b=Gc+YF8CUq+a2FCH5aCppKsio4bIi9lxIh/cZ/ZjD8RQYdsKPQT0I8anbUoK4ZqN5Jd
 eVux7N4H10h8QpuhATaIGk+TmQ/YE7lEDE1N4ZFxv8MFZr8f9B3zcR7O6wqoFIH8pH12
 WVpIta1DjoQGfHQiZF9WLTgOt4jjN8AYQPIQv7u/3SU0YU1PpS3JbX//l6wukadWJYgW
 KemYjNyzsv2GGH79YuluAheV3GLJs7bNnmwu5UtlUGi0/stFeL+wfgsZCQm+nO1elxRG
 3PQhtA++78NIZUmzolOc2REqvSmHwimKJqXHyz/IJUpojnM3Pdq689HMcqit4Cx9QaE2
 EVQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1728515345; x=1729120145;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=NNIhf0diuxJoxU55DlT10sYTiHd5YymT+dpY9nybit0=;
 b=DxtZLR4r4BWcK71kvmsgDgKiKn3yENrHAFWP5nYoviZQTW9bk+BIEpIc0qkaia4s+O
 YAlpkFkI9RgxWh+543RDzXrGL0LwBHgWAmQXhZoO1HtGhzMQQsvRG0g1kttIcU0mvHXW
 mRodD2KGoaZtp4X3yA8feU0f5l8hIUcPnerKqG8IJjLVBeAyUJ+pOqyw92K9J0J9GePJ
 eBwfjeq3hAon3FW2z3XzNQsDx9CeLrJwXsS3KWt+5dLLl827PJuDAaDIHYgvRGoftITY
 yl40DNayRfe5Z2bz21kbaKpZGoJbkKKMe9hNC1vDGjL77oygJhp/m73duuOy2nwRivTb
 cxwA==
X-Forwarded-Encrypted: i=1;
 AJvYcCV/pdsJY9mxPvrHIaXtyGkHZkd7hewNulgOwuRmYEjC7bHBeErChdagJZqxzz2NhPD7XbqZWdSaW9XH@nongnu.org
X-Gm-Message-State: AOJu0YypJeQ/WmJVeKhUZrkaf3HhOItBRuBPLlvdPacBak7o6WUX2rb5
 +RuEbZGC10YkhBL3tjtgVWzFUew9kw2vcnnGGlNmgPu+SZwOlV45Sc/ZvHzf9og=
X-Google-Smtp-Source: AGHT+IFea4CgrpfVTe+vtoV4SsGXoIxJb8yb9BeH13wks42l4w6F9PH7op1cQSwDGzsjpQ27qF0BAA==
X-Received: by 2002:a17:90a:70ca:b0:2e2:c98e:c33f with SMTP id
 98e67ed59e1d1-2e2c98ec41cmr1335161a91.1.1728515345677; 
 Wed, 09 Oct 2024 16:09:05 -0700 (PDT)
Received: from atishp.ba.rivosinc.com ([64.71.180.162])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-2e2a55f9855sm2271902a91.2.2024.10.09.16.09.04
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 09 Oct 2024 16:09:05 -0700 (PDT)
From: Atish Patra <atishp@rivosinc.com>
Date: Wed, 09 Oct 2024 16:09:00 -0700
Subject: [PATCH RFC 02/10] target/riscv: Introduce helper functions for pmu
 hashtable lookup
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241009-pmu_event_machine-v1-2-dcbd7a60e3ba@rivosinc.com>
References: <20241009-pmu_event_machine-v1-0-dcbd7a60e3ba@rivosinc.com>
In-Reply-To: <20241009-pmu_event_machine-v1-0-dcbd7a60e3ba@rivosinc.com>
To: qemu-riscv@nongnu.org, qemu-devel@nongnu.org
Cc: alexei.filippov@syntacore.com, Atish Patra <atishp@rivosinc.com>, 
 palmer@dabbelt.com, liwei1518@gmail.com, zhiwei_liu@linux.alibaba.com, 
 bin.meng@windriver.com, dbarboza@ventanamicro.com, alistair.francis@wdc.com
X-Mailer: b4 0.15-dev-13183
Received-SPF: pass client-ip=2607:f8b0:4864:20::52e;
 envelope-from=atishp@rivosinc.com; helo=mail-pg1-x52e.google.com
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

The pmu implementation requires hashtable lookup operation sprinkled
through the file. Add a helper function that allows to consolidate
the implementation and extend it in the future easily.

Signed-off-by: Atish Patra <atishp@rivosinc.com>
---
 target/riscv/pmu.c | 56 ++++++++++++++++++++++++++----------------------------
 1 file changed, 27 insertions(+), 29 deletions(-)

diff --git a/target/riscv/pmu.c b/target/riscv/pmu.c
index e05ab067d2f2..a88c321a6cad 100644
--- a/target/riscv/pmu.c
+++ b/target/riscv/pmu.c
@@ -265,6 +265,21 @@ static void riscv_pmu_cycle_update_priv(CPURISCVState *env,
     counter_arr[env->priv] += delta;
 }
 
+static bool riscv_pmu_htable_lookup(RISCVCPU *cpu, uint32_t key,
+                                    uint32_t *value)
+{
+    GHashTable *table = cpu->pmu_event_ctr_map;
+    gpointer val_ptr;
+
+    val_ptr = g_hash_table_lookup(table, GUINT_TO_POINTER(key));
+    if (!val_ptr) {
+        return false;
+    }
+
+    *value = GPOINTER_TO_UINT(val_ptr);
+    return true;
+}
+
 void riscv_pmu_update_fixed_ctrs(CPURISCVState *env, target_ulong newpriv,
                                  bool new_virt)
 {
@@ -277,18 +292,15 @@ int riscv_pmu_incr_ctr(RISCVCPU *cpu, enum riscv_pmu_event_idx event_idx)
     uint32_t ctr_idx;
     int ret;
     CPURISCVState *env = &cpu->env;
-    gpointer value;
 
     if (!cpu->cfg.pmu_mask) {
         return 0;
     }
-    value = g_hash_table_lookup(cpu->pmu_event_ctr_map,
-                                GUINT_TO_POINTER(event_idx));
-    if (!value) {
+
+    if (!riscv_pmu_htable_lookup(cpu, event_idx, &ctr_idx)) {
         return -1;
     }
 
-    ctr_idx = GPOINTER_TO_UINT(value);
     if (!riscv_pmu_counter_enabled(cpu, ctr_idx)) {
         return -1;
     }
@@ -306,7 +318,6 @@ bool riscv_pmu_ctr_monitor_instructions(CPURISCVState *env,
                                         uint32_t target_ctr)
 {
     RISCVCPU *cpu;
-    uint32_t event_idx;
     uint32_t ctr_idx;
 
     /* Fixed instret counter */
@@ -315,14 +326,8 @@ bool riscv_pmu_ctr_monitor_instructions(CPURISCVState *env,
     }
 
     cpu = env_archcpu(env);
-    if (!cpu->pmu_event_ctr_map) {
-        return false;
-    }
-
-    event_idx = RISCV_PMU_EVENT_HW_INSTRUCTIONS;
-    ctr_idx = GPOINTER_TO_UINT(g_hash_table_lookup(cpu->pmu_event_ctr_map,
-                               GUINT_TO_POINTER(event_idx)));
-    if (!ctr_idx) {
+    if (!riscv_pmu_htable_lookup(cpu, RISCV_PMU_EVENT_HW_INSTRUCTIONS,
+                                 &ctr_idx)) {
         return false;
     }
 
@@ -332,7 +337,6 @@ bool riscv_pmu_ctr_monitor_instructions(CPURISCVState *env,
 bool riscv_pmu_ctr_monitor_cycles(CPURISCVState *env, uint32_t target_ctr)
 {
     RISCVCPU *cpu;
-    uint32_t event_idx;
     uint32_t ctr_idx;
 
     /* Fixed mcycle counter */
@@ -341,16 +345,8 @@ bool riscv_pmu_ctr_monitor_cycles(CPURISCVState *env, uint32_t target_ctr)
     }
 
     cpu = env_archcpu(env);
-    if (!cpu->pmu_event_ctr_map) {
-        return false;
-    }
-
-    event_idx = RISCV_PMU_EVENT_HW_CPU_CYCLES;
-    ctr_idx = GPOINTER_TO_UINT(g_hash_table_lookup(cpu->pmu_event_ctr_map,
-                               GUINT_TO_POINTER(event_idx)));
-
-    /* Counter zero is not used for event_ctr_map */
-    if (!ctr_idx) {
+    if (!riscv_pmu_htable_lookup(cpu, RISCV_PMU_EVENT_HW_CPU_CYCLES,
+                                &ctr_idx)) {
         return false;
     }
 
@@ -381,6 +377,7 @@ int riscv_pmu_update_event_map(CPURISCVState *env, uint64_t value,
 {
     uint32_t event_idx;
     RISCVCPU *cpu = env_archcpu(env);
+    uint32_t mapped_ctr_idx;
 
     if (!riscv_pmu_counter_valid(cpu, ctr_idx) || !cpu->pmu_event_ctr_map) {
         return -1;
@@ -398,8 +395,7 @@ int riscv_pmu_update_event_map(CPURISCVState *env, uint64_t value,
     }
 
     event_idx = value & MHPMEVENT_IDX_MASK;
-    if (g_hash_table_lookup(cpu->pmu_event_ctr_map,
-                            GUINT_TO_POINTER(event_idx))) {
+    if (riscv_pmu_htable_lookup(cpu, event_idx, &mapped_ctr_idx)) {
         return 0;
     }
 
@@ -472,8 +468,10 @@ static void pmu_timer_trigger_irq(RISCVCPU *cpu,
         return;
     }
 
-    ctr_idx = GPOINTER_TO_UINT(g_hash_table_lookup(cpu->pmu_event_ctr_map,
-                               GUINT_TO_POINTER(evt_idx)));
+    if (!riscv_pmu_htable_lookup(cpu, evt_idx, &ctr_idx)) {
+        return;
+    }
+
     if (!riscv_pmu_counter_enabled(cpu, ctr_idx)) {
         return;
     }

-- 
2.34.1


