Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4FD75C3DA5D
	for <qemu-devel@archiver.kernel.org>; Thu, 18 Jul 2024 02:14:54 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sUGd1-0003DU-FP; Wed, 17 Jul 2024 22:12:19 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1sUGcN-0000S6-Og
 for qemu-devel@nongnu.org; Wed, 17 Jul 2024 22:11:43 -0400
Received: from mail-pl1-x62b.google.com ([2607:f8b0:4864:20::62b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1sUGcL-0003Y2-LY
 for qemu-devel@nongnu.org; Wed, 17 Jul 2024 22:11:39 -0400
Received: by mail-pl1-x62b.google.com with SMTP id
 d9443c01a7336-1fc49c1f3e5so3127705ad.1
 for <qemu-devel@nongnu.org>; Wed, 17 Jul 2024 19:11:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1721268696; x=1721873496; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=E8cWbKkT7M84MGGAu2FLVm64KRcLw5vpyDYslYBj4tE=;
 b=NnCYTEu4pSC9X2bicFdYNo6ShW8jpKuDbGhTe6wj89L2Q05M7m5W/z4F8Lm/QS0LUU
 o07viCfjeyJzo5e9Ak1wLGWhzkB+8Zah0VwzELSMrSMhiJlhVSW17z6HSNgulhPA2nEy
 nRqkbrnlnQITcHWAOSZ61wyMY75yXsv888rD3mnc8U+hER4p7hujhxjQGLVX7bVnhQAj
 Pdhn7Ml+CaTgIKSGhxrzz+kxMyzF88RBdoIYDDaGY78FSThWCTclu5siCt2n8Q33A1Te
 Tryj8MPZvYOgL3Zr3bqg/5wVs+b/Zocf+SujfuKFZxADjbsgubqYw2ZvVq7e6jtHSisJ
 8xYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1721268696; x=1721873496;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=E8cWbKkT7M84MGGAu2FLVm64KRcLw5vpyDYslYBj4tE=;
 b=djRI3MkmOGLuLi2OuX1y9hMJAB9vz1pr8IqoCoWhteQLxwOXGOY3VQCnIxeCltoAvR
 cssAUF1CnRFb/E8rUzEFCM7uBd4W8UtMzJtLuUKTikJ/lpbPYaCpgLeV3O/ntpd5G2jk
 jUwu+fPDq6hpbcrbE9FS+zt3iCfi30GhK1RX73oORpDXdqFys7J3yxbl9+eETVfuuDuv
 bRQBi60GhSfmtSkRD0Ftpl/XqLf8KP7N87+ed3hgfPldYcUu/q4FpeRmseYHxtinDQqS
 K968zUXnkaDiKuI54pbx8alsR6xEIzgIr1wgMnCrxqD5eC4BZ3hdOG7G/vzL/f6RaGsE
 gMxw==
X-Gm-Message-State: AOJu0YzN+3pK1b5ZGKUdphtNpRcYc3nAECaCohaNo+AZ5WqEthomd4Qm
 cQkPDf1Xl+RundTQYBUjLHEBy5YHy5AYMtj33hqfr+wpBQOhlzEDqSn6NUU8
X-Google-Smtp-Source: AGHT+IGmSpFJZhzDezMU4xo0dalYdR5wapFOpxhZFivPHcluNSXFNOyCNdNvXtuPt893/eHHULcO2A==
X-Received: by 2002:a17:902:ea04:b0:1fb:9a83:4496 with SMTP id
 d9443c01a7336-1fc4e11f2e5mr31108875ad.2.1721268695773; 
 Wed, 17 Jul 2024 19:11:35 -0700 (PDT)
Received: from toolbox.alistair23.me
 (2403-580b-97e8-0-82ce-f179-8a79-69f4.ip6.aussiebb.net.
 [2403:580b:97e8:0:82ce:f179:8a79:69f4])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-1fc0bba949bsm81999385ad.69.2024.07.17.19.11.33
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 17 Jul 2024 19:11:35 -0700 (PDT)
From: Alistair Francis <alistair23@gmail.com>
X-Google-Original-From: Alistair Francis <alistair.francis@wdc.com>
To: qemu-devel@nongnu.org
Cc: alistair23@gmail.com, Rajnesh Kanwal <rkanwal@rivosinc.com>,
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>,
 Alistair Francis <alistair.francis@wdc.com>
Subject: [PULL 24/30] target/riscv: Start counters from both mhpmcounter and
 mcountinhibit
Date: Thu, 18 Jul 2024 12:10:06 +1000
Message-ID: <20240718021012.2057986-25-alistair.francis@wdc.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240718021012.2057986-1-alistair.francis@wdc.com>
References: <20240718021012.2057986-1-alistair.francis@wdc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62b;
 envelope-from=alistair23@gmail.com; helo=mail-pl1-x62b.google.com
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

From: Rajnesh Kanwal <rkanwal@rivosinc.com>

Currently we start timer counter from write_mhpmcounter path only
without checking for mcountinhibit bit. This changes adds mcountinhibit
check and also programs the counter from write_mcountinhibit as well.

When a counter is stopped using mcountinhibit we simply update
the value of the counter based on current host ticks and save
it for future reads.

We don't need to disable running timer as pmu_timer_trigger_irq
will discard the interrupt if the counter has been inhibited.

Signed-off-by: Rajnesh Kanwal <rkanwal@rivosinc.com>
Reviewed-by: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
Message-ID: <20240711-smcntrpmf_v7-v8-10-b7c38ae7b263@rivosinc.com>
Signed-off-by: Alistair Francis <alistair.francis@wdc.com>
---
 target/riscv/csr.c | 75 ++++++++++++++++++++++++++++++++--------------
 target/riscv/pmu.c |  3 +-
 2 files changed, 54 insertions(+), 24 deletions(-)

diff --git a/target/riscv/csr.c b/target/riscv/csr.c
index d6c5b73afd..bb6ac33ac2 100644
--- a/target/riscv/csr.c
+++ b/target/riscv/csr.c
@@ -1077,8 +1077,9 @@ static RISCVException write_mhpmcounter(CPURISCVState *env, int csrno,
     uint64_t mhpmctr_val = val;
 
     counter->mhpmcounter_val = val;
-    if (riscv_pmu_ctr_monitor_cycles(env, ctr_idx) ||
-        riscv_pmu_ctr_monitor_instructions(env, ctr_idx)) {
+    if (!get_field(env->mcountinhibit, BIT(ctr_idx)) &&
+        (riscv_pmu_ctr_monitor_cycles(env, ctr_idx) ||
+         riscv_pmu_ctr_monitor_instructions(env, ctr_idx))) {
         counter->mhpmcounter_prev = riscv_pmu_ctr_get_fixed_counters_val(env,
                                                                 ctr_idx, false);
         if (ctr_idx > 2) {
@@ -1106,8 +1107,9 @@ static RISCVException write_mhpmcounterh(CPURISCVState *env, int csrno,
 
     counter->mhpmcounterh_val = val;
     mhpmctr_val = mhpmctr_val | (mhpmctrh_val << 32);
-    if (riscv_pmu_ctr_monitor_cycles(env, ctr_idx) ||
-        riscv_pmu_ctr_monitor_instructions(env, ctr_idx)) {
+    if (!get_field(env->mcountinhibit, BIT(ctr_idx)) &&
+        (riscv_pmu_ctr_monitor_cycles(env, ctr_idx) ||
+         riscv_pmu_ctr_monitor_instructions(env, ctr_idx))) {
         counter->mhpmcounterh_prev = riscv_pmu_ctr_get_fixed_counters_val(env,
                                                                  ctr_idx, true);
         if (ctr_idx > 2) {
@@ -2170,31 +2172,60 @@ static RISCVException write_mcountinhibit(CPURISCVState *env, int csrno,
     int cidx;
     PMUCTRState *counter;
     RISCVCPU *cpu = env_archcpu(env);
+    uint32_t present_ctrs = cpu->pmu_avail_ctrs | COUNTEREN_CY | COUNTEREN_IR;
+    target_ulong updated_ctrs = (env->mcountinhibit ^ val) & present_ctrs;
+    uint64_t mhpmctr_val, prev_count, curr_count;
 
     /* WARL register - disable unavailable counters; TM bit is always 0 */
-    env->mcountinhibit =
-        val & (cpu->pmu_avail_ctrs | COUNTEREN_CY | COUNTEREN_IR);
+    env->mcountinhibit = val & present_ctrs;
 
     /* Check if any other counter is also monitoring cycles/instructions */
     for (cidx = 0; cidx < RV_MAX_MHPMCOUNTERS; cidx++) {
-            counter = &env->pmu_ctrs[cidx];
-        if (get_field(env->mcountinhibit, BIT(cidx)) && (val & BIT(cidx))) {
-            /*
-             * Update the counter value for cycle/instret as we can't stop the
-             * host ticks. But we should show the current value at this moment.
-             */
-            if (riscv_pmu_ctr_monitor_cycles(env, cidx) ||
-                riscv_pmu_ctr_monitor_instructions(env, cidx)) {
-                counter->mhpmcounter_val =
-                    riscv_pmu_ctr_get_fixed_counters_val(env, cidx, false) -
-                                           counter->mhpmcounter_prev +
-                                           counter->mhpmcounter_val;
+        if (!(updated_ctrs & BIT(cidx)) ||
+            (!riscv_pmu_ctr_monitor_cycles(env, cidx) &&
+            !riscv_pmu_ctr_monitor_instructions(env, cidx))) {
+            continue;
+        }
+
+        counter = &env->pmu_ctrs[cidx];
+
+        if (!get_field(env->mcountinhibit, BIT(cidx))) {
+            counter->mhpmcounter_prev =
+                riscv_pmu_ctr_get_fixed_counters_val(env, cidx, false);
+            if (riscv_cpu_mxl(env) == MXL_RV32) {
+                counter->mhpmcounterh_prev =
+                    riscv_pmu_ctr_get_fixed_counters_val(env, cidx, true);
+            }
+
+            if (cidx > 2) {
+                mhpmctr_val = counter->mhpmcounter_val;
                 if (riscv_cpu_mxl(env) == MXL_RV32) {
-                    counter->mhpmcounterh_val =
-                        riscv_pmu_ctr_get_fixed_counters_val(env, cidx, true) -
-                                                counter->mhpmcounterh_prev +
-                                                counter->mhpmcounterh_val;
+                    mhpmctr_val = mhpmctr_val |
+                            ((uint64_t)counter->mhpmcounterh_val << 32);
                 }
+                riscv_pmu_setup_timer(env, mhpmctr_val, cidx);
+            }
+        } else {
+            curr_count = riscv_pmu_ctr_get_fixed_counters_val(env, cidx, false);
+
+            mhpmctr_val = counter->mhpmcounter_val;
+            prev_count = counter->mhpmcounter_prev;
+            if (riscv_cpu_mxl(env) == MXL_RV32) {
+                uint64_t tmp =
+                    riscv_pmu_ctr_get_fixed_counters_val(env, cidx, true);
+
+                curr_count = curr_count | (tmp << 32);
+                mhpmctr_val = mhpmctr_val |
+                    ((uint64_t)counter->mhpmcounterh_val << 32);
+                prev_count = prev_count |
+                    ((uint64_t)counter->mhpmcounterh_prev << 32);
+            }
+
+            /* Adjust the counter for later reads. */
+            mhpmctr_val = curr_count - prev_count + mhpmctr_val;
+            counter->mhpmcounter_val = mhpmctr_val;
+            if (riscv_cpu_mxl(env) == MXL_RV32) {
+                counter->mhpmcounterh_val = mhpmctr_val >> 32;
             }
         }
     }
diff --git a/target/riscv/pmu.c b/target/riscv/pmu.c
index ac648cff8d..63420d9f36 100644
--- a/target/riscv/pmu.c
+++ b/target/riscv/pmu.c
@@ -285,8 +285,7 @@ int riscv_pmu_incr_ctr(RISCVCPU *cpu, enum riscv_pmu_event_idx event_idx)
     }
 
     ctr_idx = GPOINTER_TO_UINT(value);
-    if (!riscv_pmu_counter_enabled(cpu, ctr_idx) ||
-        get_field(env->mcountinhibit, BIT(ctr_idx))) {
+    if (!riscv_pmu_counter_enabled(cpu, ctr_idx)) {
         return -1;
     }
 
-- 
2.45.2


