Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 85EF5C41513
	for <qemu-devel@archiver.kernel.org>; Thu, 11 Jul 2024 22:34:32 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sS2KL-0000ls-GK; Thu, 11 Jul 2024 18:31:49 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <atishp@rivosinc.com>)
 id 1sS2KH-0000Ve-Ac
 for qemu-devel@nongnu.org; Thu, 11 Jul 2024 18:31:45 -0400
Received: from mail-pl1-x62e.google.com ([2607:f8b0:4864:20::62e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <atishp@rivosinc.com>)
 id 1sS2KE-0001c8-11
 for qemu-devel@nongnu.org; Thu, 11 Jul 2024 18:31:45 -0400
Received: by mail-pl1-x62e.google.com with SMTP id
 d9443c01a7336-1fa2ea1c443so11616345ad.0
 for <qemu-devel@nongnu.org>; Thu, 11 Jul 2024 15:31:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=rivosinc-com.20230601.gappssmtp.com; s=20230601; t=1720737100; x=1721341900;
 darn=nongnu.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=d+QUQc3iXZEVEVIVl6NZKcjOld/tcTt/NozeZylg4fc=;
 b=oSobJPxC5CxNNN+VhL6bYGzKrLDB3xX5CBxq+77snOiZY1bS0q2WNtcf+IZbv9xzgy
 BF78UwWBa/UrlxMEqhu3OrZJre/osFxGxCK7YnxmP/LC2qxxM610/yqTJjVw1fM9eAbZ
 5+wH7yGcL/lK9JSRBtYQN580FRoPOAZ/1eUSm8WHp8URfQJFSrrwXlcoewe+cZ5mMjW5
 xVI4wajVyj8S1tzKCSwmEPuOKqb/i5Yc5Mma8tO2WZRxWKTQxPEg6cKVDP+JNX5sHar8
 0JEmla5gtJOg6u3bgtxgLDhzcEGAjRGnOw96yA88yN1NxqfcFNv8kDUeAcsszJPEG8Fw
 fbwQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1720737100; x=1721341900;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=d+QUQc3iXZEVEVIVl6NZKcjOld/tcTt/NozeZylg4fc=;
 b=fqlp8JkQqGh7hqGgR+R7pBL4bsY4j/4uhk88uNE2BVkpQnLodVQDgWeDwcg5OtJJoQ
 /MkKtb3Y2EuXVei0/M8MkXaTkU6c9FDMnm+zrG093Z4F1dTfutAe5CJkf1kDWnQqpUbW
 m6RZf4lN85MJbZALrn/u4t0Lt25mqELtG0xD/k5e90VpXY0N0Ji/N+bwPmibLAjFekot
 9V6RKgq06o5YQmPBsiCHyvAnsCILrpuodDPE2Od8hfAJZbhRcdgjtCrX9UbGRKq7OGe9
 64zsx0KZ30uOFDzXKZu/8tYx8OTjS4Y/eHc6FbNu1gzQFzr8VBbo5bOfqmLRDxbTsPPO
 chXQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCXjq5l4lJhcdX8o4gx+ug2zXEDPihaFk8xe/FIEGsyOZg/WufV5XTODpGiarAgbhWqbxk5rxrtRw3PMYLcBcveKBgbQqLM=
X-Gm-Message-State: AOJu0YzQWVUs/hwWSVXA0Z/5ut216+zQNdjLeLRYvkncSN9U4h1FP02N
 DbDVY/qkS2l64Hrhjug7Iz3uAsCfqf6e+xWSAG/kujk/1a3Mz7hS1XyJpP0vWMQ=
X-Google-Smtp-Source: AGHT+IEOoXVJeJc7f5fcq3yboFy8ukyCvQ8GmQRBjJl/wq4/txAOf0uKXS0AI04L5sRg5Cc6HG6TLA==
X-Received: by 2002:a17:902:d2d0:b0:1fb:8c35:6023 with SMTP id
 d9443c01a7336-1fbb6cdbdfamr94265615ad.11.1720737100595; 
 Thu, 11 Jul 2024 15:31:40 -0700 (PDT)
Received: from atishp.ba.rivosinc.com ([64.71.180.162])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-1fbb6b34ca2sm55161565ad.53.2024.07.11.15.31.39
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 11 Jul 2024 15:31:40 -0700 (PDT)
From: Atish Patra <atishp@rivosinc.com>
Date: Thu, 11 Jul 2024 15:31:10 -0700
Subject: [PATCH v8 07/13] target/riscv: Implement privilege mode filtering
 for cycle/instret
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240711-smcntrpmf_v7-v8-7-b7c38ae7b263@rivosinc.com>
References: <20240711-smcntrpmf_v7-v8-0-b7c38ae7b263@rivosinc.com>
In-Reply-To: <20240711-smcntrpmf_v7-v8-0-b7c38ae7b263@rivosinc.com>
To: qemu-riscv@nongnu.org, qemu-devel@nongnu.org
Cc: palmer@dabbelt.com, liwei1518@gmail.com, zhiwei_liu@linux.alibaba.com, 
 bin.meng@windriver.com, dbarboza@ventanamicro.com, alistair.francis@wdc.com
X-Mailer: b4 0.15-dev-13183
Received-SPF: pass client-ip=2607:f8b0:4864:20::62e;
 envelope-from=atishp@rivosinc.com; helo=mail-pl1-x62e.google.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
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

Privilege mode filtering can also be emulated for cycle/instret by
tracking host_ticks/icount during each privilege mode switch. This
patch implements that for both cycle/instret and mhpmcounters. The
first one requires Smcntrpmf while the other one requires Sscofpmf
to be enabled.

The cycle/instret are still computed using host ticks when icount
is not enabled. Otherwise, they are computed using raw icount which
is more accurate in icount mode.

Co-Developed-by: Rajnesh Kanwal <rkanwal@rivosinc.com>
Signed-off-by: Rajnesh Kanwal <rkanwal@rivosinc.com>
Reviewed-by: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
Acked-by: Alistair Francis <alistair.francis@wdc.com>
Signed-off-by: Atish Patra <atishp@rivosinc.com>
---
 target/riscv/cpu.h        |  11 +++++
 target/riscv/cpu_helper.c |   9 +++-
 target/riscv/csr.c        | 117 ++++++++++++++++++++++++++++++++--------------
 target/riscv/pmu.c        |  92 ++++++++++++++++++++++++++++++++++++
 target/riscv/pmu.h        |   2 +
 5 files changed, 194 insertions(+), 37 deletions(-)

diff --git a/target/riscv/cpu.h b/target/riscv/cpu.h
index c5d289e5f4b9..d56d640b06be 100644
--- a/target/riscv/cpu.h
+++ b/target/riscv/cpu.h
@@ -158,6 +158,15 @@ typedef struct PMUCTRState {
     target_ulong irq_overflow_left;
 } PMUCTRState;
 
+typedef struct PMUFixedCtrState {
+        /* Track cycle and icount for each privilege mode */
+        uint64_t counter[4];
+        uint64_t counter_prev[4];
+        /* Track cycle and icount for each privilege mode when V = 1*/
+        uint64_t counter_virt[2];
+        uint64_t counter_virt_prev[2];
+} PMUFixedCtrState;
+
 struct CPUArchState {
     target_ulong gpr[32];
     target_ulong gprh[32]; /* 64 top bits of the 128-bit registers */
@@ -354,6 +363,8 @@ struct CPUArchState {
     /* PMU event selector configured values for RV32 */
     target_ulong mhpmeventh_val[RV_MAX_MHPMEVENTS];
 
+    PMUFixedCtrState pmu_fixed_ctrs[2];
+
     target_ulong sscratch;
     target_ulong mscratch;
 
diff --git a/target/riscv/cpu_helper.c b/target/riscv/cpu_helper.c
index 10d3fdaed376..395a1d914061 100644
--- a/target/riscv/cpu_helper.c
+++ b/target/riscv/cpu_helper.c
@@ -695,9 +695,14 @@ void riscv_cpu_set_mode(CPURISCVState *env, target_ulong newpriv, bool virt_en)
 {
     g_assert(newpriv <= PRV_M && newpriv != PRV_RESERVED);
 
-    if (icount_enabled() && newpriv != env->priv) {
-        riscv_itrigger_update_priv(env);
+    if (newpriv != env->priv || env->virt_enabled != virt_en) {
+        if (icount_enabled()) {
+            riscv_itrigger_update_priv(env);
+        }
+
+        riscv_pmu_update_fixed_ctrs(env, newpriv, virt_en);
     }
+
     /* tlb_flush is unnecessary as mode is contained in mmu_idx */
     env->priv = newpriv;
     env->xl = cpu_recompute_xl(env);
diff --git a/target/riscv/csr.c b/target/riscv/csr.c
index 121996edab4b..53f1a7ff00db 100644
--- a/target/riscv/csr.c
+++ b/target/riscv/csr.c
@@ -787,36 +787,16 @@ static RISCVException write_vcsr(CPURISCVState *env, int csrno,
     return RISCV_EXCP_NONE;
 }
 
+#if defined(CONFIG_USER_ONLY)
 /* User Timers and Counters */
-static target_ulong get_ticks(bool shift, bool instructions)
+static target_ulong get_ticks(bool shift)
 {
-    int64_t val;
-    target_ulong result;
-
-#if !defined(CONFIG_USER_ONLY)
-    if (icount_enabled()) {
-        if (instructions) {
-            val = icount_get_raw();
-        } else {
-            val = icount_get();
-        }
-    } else {
-        val = cpu_get_host_ticks();
-    }
-#else
-    val = cpu_get_host_ticks();
-#endif
-
-    if (shift) {
-        result = val >> 32;
-    } else {
-        result = val;
-    }
+    int64_t val = cpu_get_host_ticks();
+    target_ulong result = shift ? val >> 32 : val;
 
     return result;
 }
 
-#if defined(CONFIG_USER_ONLY)
 static RISCVException read_time(CPURISCVState *env, int csrno,
                                 target_ulong *val)
 {
@@ -834,14 +814,14 @@ static RISCVException read_timeh(CPURISCVState *env, int csrno,
 static RISCVException read_hpmcounter(CPURISCVState *env, int csrno,
                                       target_ulong *val)
 {
-    *val = get_ticks(false, (csrno == CSR_INSTRET));
+    *val = get_ticks(false);
     return RISCV_EXCP_NONE;
 }
 
 static RISCVException read_hpmcounterh(CPURISCVState *env, int csrno,
                                        target_ulong *val)
 {
-    *val = get_ticks(true, (csrno == CSR_INSTRETH));
+    *val = get_ticks(true);
     return RISCV_EXCP_NONE;
 }
 
@@ -1025,17 +1005,82 @@ static RISCVException write_mhpmeventh(CPURISCVState *env, int csrno,
     return RISCV_EXCP_NONE;
 }
 
+static target_ulong riscv_pmu_ctr_get_fixed_counters_val(CPURISCVState *env,
+                                                         int counter_idx,
+                                                         bool upper_half)
+{
+    int inst = riscv_pmu_ctr_monitor_instructions(env, counter_idx);
+    uint64_t *counter_arr_virt = env->pmu_fixed_ctrs[inst].counter_virt;
+    uint64_t *counter_arr = env->pmu_fixed_ctrs[inst].counter;
+    target_ulong result = 0;
+    uint64_t curr_val = 0;
+    uint64_t cfg_val = 0;
+
+    if (counter_idx == 0) {
+        cfg_val = upper_half ? ((uint64_t)env->mcyclecfgh << 32) :
+                  env->mcyclecfg;
+    } else if (counter_idx == 2) {
+        cfg_val = upper_half ? ((uint64_t)env->minstretcfgh << 32) :
+                  env->minstretcfg;
+    } else {
+        cfg_val = upper_half ?
+                  ((uint64_t)env->mhpmeventh_val[counter_idx] << 32) :
+                  env->mhpmevent_val[counter_idx];
+        cfg_val &= MHPMEVENT_FILTER_MASK;
+    }
+
+    if (!cfg_val) {
+        if (icount_enabled()) {
+                curr_val = inst ? icount_get_raw() : icount_get();
+        } else {
+            curr_val = cpu_get_host_ticks();
+        }
+
+        goto done;
+    }
+
+    if (!(cfg_val & MCYCLECFG_BIT_MINH)) {
+        curr_val += counter_arr[PRV_M];
+    }
+
+    if (!(cfg_val & MCYCLECFG_BIT_SINH)) {
+        curr_val += counter_arr[PRV_S];
+    }
+
+    if (!(cfg_val & MCYCLECFG_BIT_UINH)) {
+        curr_val += counter_arr[PRV_U];
+    }
+
+    if (!(cfg_val & MCYCLECFG_BIT_VSINH)) {
+        curr_val += counter_arr_virt[PRV_S];
+    }
+
+    if (!(cfg_val & MCYCLECFG_BIT_VUINH)) {
+        curr_val += counter_arr_virt[PRV_U];
+    }
+
+done:
+    if (riscv_cpu_mxl(env) == MXL_RV32) {
+        result = upper_half ? curr_val >> 32 : curr_val;
+    } else {
+        result = curr_val;
+    }
+
+    return result;
+}
+
 static RISCVException write_mhpmcounter(CPURISCVState *env, int csrno,
                                         target_ulong val)
 {
     int ctr_idx = csrno - CSR_MCYCLE;
     PMUCTRState *counter = &env->pmu_ctrs[ctr_idx];
     uint64_t mhpmctr_val = val;
-    bool instr = riscv_pmu_ctr_monitor_instructions(env, ctr_idx);
 
     counter->mhpmcounter_val = val;
-    if (riscv_pmu_ctr_monitor_cycles(env, ctr_idx) || instr) {
-        counter->mhpmcounter_prev = get_ticks(false, instr);
+    if (riscv_pmu_ctr_monitor_cycles(env, ctr_idx) ||
+        riscv_pmu_ctr_monitor_instructions(env, ctr_idx)) {
+        counter->mhpmcounter_prev = riscv_pmu_ctr_get_fixed_counters_val(env,
+                                                                ctr_idx, false);
         if (ctr_idx > 2) {
             if (riscv_cpu_mxl(env) == MXL_RV32) {
                 mhpmctr_val = mhpmctr_val |
@@ -1058,12 +1103,13 @@ static RISCVException write_mhpmcounterh(CPURISCVState *env, int csrno,
     PMUCTRState *counter = &env->pmu_ctrs[ctr_idx];
     uint64_t mhpmctr_val = counter->mhpmcounter_val;
     uint64_t mhpmctrh_val = val;
-    bool instr = riscv_pmu_ctr_monitor_instructions(env, ctr_idx);
 
     counter->mhpmcounterh_val = val;
     mhpmctr_val = mhpmctr_val | (mhpmctrh_val << 32);
-    if (riscv_pmu_ctr_monitor_cycles(env, ctr_idx) || instr) {
-        counter->mhpmcounterh_prev = get_ticks(true, instr);
+    if (riscv_pmu_ctr_monitor_cycles(env, ctr_idx) ||
+        riscv_pmu_ctr_monitor_instructions(env, ctr_idx)) {
+        counter->mhpmcounterh_prev = riscv_pmu_ctr_get_fixed_counters_val(env,
+                                                                 ctr_idx, true);
         if (ctr_idx > 2) {
             riscv_pmu_setup_timer(env, mhpmctr_val, ctr_idx);
         }
@@ -1082,7 +1128,6 @@ static RISCVException riscv_pmu_read_ctr(CPURISCVState *env, target_ulong *val,
                                          counter->mhpmcounter_prev;
     target_ulong ctr_val = upper_half ? counter->mhpmcounterh_val :
                                         counter->mhpmcounter_val;
-    bool instr = riscv_pmu_ctr_monitor_instructions(env, ctr_idx);
 
     if (get_field(env->mcountinhibit, BIT(ctr_idx))) {
         /*
@@ -1103,8 +1148,10 @@ static RISCVException riscv_pmu_read_ctr(CPURISCVState *env, target_ulong *val,
      * The kernel computes the perf delta by subtracting the current value from
      * the value it initialized previously (ctr_val).
      */
-    if (riscv_pmu_ctr_monitor_cycles(env, ctr_idx) || instr) {
-        *val = get_ticks(upper_half, instr) - ctr_prev + ctr_val;
+    if (riscv_pmu_ctr_monitor_cycles(env, ctr_idx) ||
+        riscv_pmu_ctr_monitor_instructions(env, ctr_idx)) {
+        *val = riscv_pmu_ctr_get_fixed_counters_val(env, ctr_idx, upper_half) -
+                                                    ctr_prev + ctr_val;
     } else {
         *val = ctr_val;
     }
diff --git a/target/riscv/pmu.c b/target/riscv/pmu.c
index 0e7d58b8a5c2..ac648cff8d7c 100644
--- a/target/riscv/pmu.c
+++ b/target/riscv/pmu.c
@@ -19,6 +19,7 @@
 #include "qemu/osdep.h"
 #include "qemu/log.h"
 #include "qemu/error-report.h"
+#include "qemu/timer.h"
 #include "cpu.h"
 #include "pmu.h"
 #include "sysemu/cpu-timers.h"
@@ -176,6 +177,97 @@ static int riscv_pmu_incr_ctr_rv64(RISCVCPU *cpu, uint32_t ctr_idx)
     return 0;
 }
 
+/*
+ * Information needed to update counters:
+ *  new_priv, new_virt: To correctly save starting snapshot for the newly
+ *                      started mode. Look at array being indexed with newprv.
+ *  old_priv, old_virt: To correctly select previous snapshot for old priv
+ *                      and compute delta. Also to select correct counter
+ *                      to inc. Look at arrays being indexed with env->priv.
+ *
+ *  To avoid the complexity of calling this function, we assume that
+ *  env->priv and env->virt_enabled contain old priv and old virt and
+ *  new priv and new virt values are passed in as arguments.
+ */
+static void riscv_pmu_icount_update_priv(CPURISCVState *env,
+                                         target_ulong newpriv, bool new_virt)
+{
+    uint64_t *snapshot_prev, *snapshot_new;
+    uint64_t current_icount;
+    uint64_t *counter_arr;
+    uint64_t delta;
+
+    if (icount_enabled()) {
+        current_icount = icount_get_raw();
+    } else {
+        current_icount = cpu_get_host_ticks();
+    }
+
+    if (env->virt_enabled) {
+        counter_arr = env->pmu_fixed_ctrs[1].counter_virt;
+        snapshot_prev = env->pmu_fixed_ctrs[1].counter_virt_prev;
+    } else {
+        counter_arr = env->pmu_fixed_ctrs[1].counter;
+        snapshot_prev = env->pmu_fixed_ctrs[1].counter_prev;
+    }
+
+    if (new_virt) {
+        snapshot_new = env->pmu_fixed_ctrs[1].counter_virt_prev;
+    } else {
+        snapshot_new = env->pmu_fixed_ctrs[1].counter_prev;
+    }
+
+     /*
+      * new_priv can be same as env->priv. So we need to calculate
+      * delta first before updating snapshot_new[new_priv].
+      */
+    delta = current_icount - snapshot_prev[env->priv];
+    snapshot_new[newpriv] = current_icount;
+
+    counter_arr[env->priv] += delta;
+}
+
+static void riscv_pmu_cycle_update_priv(CPURISCVState *env,
+                                        target_ulong newpriv, bool new_virt)
+{
+    uint64_t *snapshot_prev, *snapshot_new;
+    uint64_t current_ticks;
+    uint64_t *counter_arr;
+    uint64_t delta;
+
+    if (icount_enabled()) {
+        current_ticks = icount_get();
+    } else {
+        current_ticks = cpu_get_host_ticks();
+    }
+
+    if (env->virt_enabled) {
+        counter_arr = env->pmu_fixed_ctrs[0].counter_virt;
+        snapshot_prev = env->pmu_fixed_ctrs[0].counter_virt_prev;
+    } else {
+        counter_arr = env->pmu_fixed_ctrs[0].counter;
+        snapshot_prev = env->pmu_fixed_ctrs[0].counter_prev;
+    }
+
+    if (new_virt) {
+        snapshot_new = env->pmu_fixed_ctrs[0].counter_virt_prev;
+    } else {
+        snapshot_new = env->pmu_fixed_ctrs[0].counter_prev;
+    }
+
+    delta = current_ticks - snapshot_prev[env->priv];
+    snapshot_new[newpriv] = current_ticks;
+
+    counter_arr[env->priv] += delta;
+}
+
+void riscv_pmu_update_fixed_ctrs(CPURISCVState *env, target_ulong newpriv,
+                                 bool new_virt)
+{
+    riscv_pmu_cycle_update_priv(env, newpriv, new_virt);
+    riscv_pmu_icount_update_priv(env, newpriv, new_virt);
+}
+
 int riscv_pmu_incr_ctr(RISCVCPU *cpu, enum riscv_pmu_event_idx event_idx)
 {
     uint32_t ctr_idx;
diff --git a/target/riscv/pmu.h b/target/riscv/pmu.h
index 7c0ad661e050..ca40cfeed647 100644
--- a/target/riscv/pmu.h
+++ b/target/riscv/pmu.h
@@ -34,5 +34,7 @@ int riscv_pmu_incr_ctr(RISCVCPU *cpu, enum riscv_pmu_event_idx event_idx);
 void riscv_pmu_generate_fdt_node(void *fdt, uint32_t cmask, char *pmu_name);
 int riscv_pmu_setup_timer(CPURISCVState *env, uint64_t value,
                           uint32_t ctr_idx);
+void riscv_pmu_update_fixed_ctrs(CPURISCVState *env, target_ulong newpriv,
+                                 bool new_virt);
 
 #endif /* RISCV_PMU_H */

-- 
2.34.1


