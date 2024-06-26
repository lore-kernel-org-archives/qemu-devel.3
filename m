Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AA826C30659
	for <qemu-devel@archiver.kernel.org>; Thu, 27 Jun 2024 00:01:25 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sMcWP-0007qi-Dn; Wed, 26 Jun 2024 19:57:53 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <atishp@rivosinc.com>)
 id 1sMcWM-0007o1-5Y
 for qemu-devel@nongnu.org; Wed, 26 Jun 2024 19:57:50 -0400
Received: from mail-pl1-x632.google.com ([2607:f8b0:4864:20::632])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <atishp@rivosinc.com>)
 id 1sMcWK-0005Y9-BC
 for qemu-devel@nongnu.org; Wed, 26 Jun 2024 19:57:49 -0400
Received: by mail-pl1-x632.google.com with SMTP id
 d9443c01a7336-1f9a78c6c5dso57000745ad.1
 for <qemu-devel@nongnu.org>; Wed, 26 Jun 2024 16:57:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=rivosinc-com.20230601.gappssmtp.com; s=20230601; t=1719446267; x=1720051067;
 darn=nongnu.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=z+xq4MaVCyGPtCT3I9EtIqPDhGf+/u6LMxxHtdn+yrc=;
 b=XzfCAmlAqdqO8sOTzqfEXzhpq+G0hfruK6gSk45p2Muov+BruSvvCnDt0VpctNsgAp
 nUYK9p/bRTinlx6fTU/x/O6oLHOvaFaj17tNv+96l13P7BRn/TG4GaDFF9Hef64shOLj
 FOcj7M0+qbZU7u4QkWLVr3E7qrOdHhw3TO5iAAIURC3QkxPqaq837Rj2olq6J2016dby
 m3pArJZD8uaLKLNfgUDx0Hded8pKX/z+OJqQ+g7GUrRNpLugfQCOOQMVogVs0gtk+lwt
 RXyk+cKuuizByIy3I5lm1VskJ1figj6jSmYJV/baT0QFmkZOL/aerbgTjPd2CSXFpEdH
 o2Hw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1719446267; x=1720051067;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=z+xq4MaVCyGPtCT3I9EtIqPDhGf+/u6LMxxHtdn+yrc=;
 b=ChocA8ugwo5+dcF4dL51bH+lVkbMTAMFLluBxHjz5SeGr6TpAjnyfYKdTimx2xOMbC
 lUJF1DDBCt/cBAfLfuoOwZi1B+TZRu0+OBeKZeU23IXH8pPabG7Lz9Dr+sIqoazIEBIX
 bOgXSAJV+VN5NLlhXdUAkpb8nqsLalxMlz5yb5uIJ0OIRUKbdPW3ZtHd7wK8b5KXEjjH
 1ZpWlJJFijdXR6Q4fUFkeTxQiXfG1TXJpgNFo6S/b5sK3CVVBNdFymWsCGuqkxOkkcvQ
 0lPCXL/d0K/fkws4cMIj+8YQfcpNH2FABNEEWnyvw40lM9zxdEUN+635LOxJVAKn6yG5
 OAGA==
X-Forwarded-Encrypted: i=1;
 AJvYcCXB7ZSEhZ/BYWSVEr3HFpiAKWxrMmHAYRu1p7eJ1y+QrsvOetdSG35JYjgBX+Jw1dCi8MoZLPYWBA7SKh86yOqD/HHQMfU=
X-Gm-Message-State: AOJu0YzqnPt03r9W8Zx03dTc1F9eFvfOYF8r3AZTJRk+LfyDOHfRJXHf
 JUKpERNph8UTIHttIP1+xd15GmvYqgLS10ODe5lei4huK8Fkfl6+60ryURGW+XI=
X-Google-Smtp-Source: AGHT+IFd0kvcg70ASNvT9W/l4oS7i8oziE9iPNdCy+gbqCxLMApNC6T8bFmiKQRbbm4pL17EYMFVHg==
X-Received: by 2002:a17:902:f54c:b0:1fa:ff8:e66e with SMTP id
 d9443c01a7336-1fa23f1f418mr137801435ad.59.1719446267050; 
 Wed, 26 Jun 2024 16:57:47 -0700 (PDT)
Received: from atishp.ba.rivosinc.com ([64.71.180.162])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-1faac998398sm630965ad.225.2024.06.26.16.57.46
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 26 Jun 2024 16:57:46 -0700 (PDT)
From: Atish Patra <atishp@rivosinc.com>
Date: Wed, 26 Jun 2024 16:57:29 -0700
Subject: [PATCH v7 09/11] target/riscv: Start counters from both
 mhpmcounter and mcountinhibit
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240626-smcntrpmf_v7-v7-9-bb0f10af7fa9@rivosinc.com>
References: <20240626-smcntrpmf_v7-v7-0-bb0f10af7fa9@rivosinc.com>
In-Reply-To: <20240626-smcntrpmf_v7-v7-0-bb0f10af7fa9@rivosinc.com>
To: qemu-riscv@nongnu.org, qemu-devel@nongnu.org
Cc: Rajnesh Kanwal <rkanwal@rivosinc.com>, 
 Atish Patra <atishp@rivosinc.com>, palmer@dabbelt.com, liwei1518@gmail.com, 
 zhiwei_liu@linux.alibaba.com, bin.meng@windriver.com, 
 dbarboza@ventanamicro.com, alistair.francis@wdc.com
X-Mailer: b4 0.15-dev-13183
Received-SPF: pass client-ip=2607:f8b0:4864:20::632;
 envelope-from=atishp@rivosinc.com; helo=mail-pl1-x632.google.com
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
---
 target/riscv/csr.c | 75 ++++++++++++++++++++++++++++++++++++++----------------
 target/riscv/pmu.c |  3 +--
 2 files changed, 54 insertions(+), 24 deletions(-)

diff --git a/target/riscv/csr.c b/target/riscv/csr.c
index 6c1a884eec82..150e02f080ec 100644
--- a/target/riscv/csr.c
+++ b/target/riscv/csr.c
@@ -1008,8 +1008,9 @@ static RISCVException write_mhpmcounter(CPURISCVState *env, int csrno,
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
@@ -1037,8 +1038,9 @@ static RISCVException write_mhpmcounterh(CPURISCVState *env, int csrno,
 
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
@@ -2101,31 +2103,60 @@ static RISCVException write_mcountinhibit(CPURISCVState *env, int csrno,
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
index ac648cff8d7c..63420d9f3679 100644
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
2.34.1


