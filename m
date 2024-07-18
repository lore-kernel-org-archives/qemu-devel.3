Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5C221C3DA5D
	for <qemu-devel@archiver.kernel.org>; Thu, 18 Jul 2024 02:12:18 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sUGcH-0008FL-Uf; Wed, 17 Jul 2024 22:11:34 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1sUGcF-0007zu-3J
 for qemu-devel@nongnu.org; Wed, 17 Jul 2024 22:11:31 -0400
Received: from mail-pg1-x52f.google.com ([2607:f8b0:4864:20::52f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1sUGcC-0003WF-HF
 for qemu-devel@nongnu.org; Wed, 17 Jul 2024 22:11:30 -0400
Received: by mail-pg1-x52f.google.com with SMTP id
 41be03b00d2f7-76cb5b6b3e4so171958a12.1
 for <qemu-devel@nongnu.org>; Wed, 17 Jul 2024 19:11:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1721268687; x=1721873487; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=xicpGGMfMO3Whly8VKJHDTLwnwM8vY9zbC8Y4IXrE+w=;
 b=WiWEMyp73oiN5WnGjQYgrXEjnIdXTBUripvGKBIEz20CQh2D9Sy9m/n1bZDsuOKFqt
 cl64vWFBrt5geKy83NWlTGlW4UbDeoeCYhLZcMQtt03oubqrYvGyZCKOuXEefTtovPiu
 t0iCB+13K7O/RgYhpjP08qQeI/pj/7siOAKwN9d56XQ8NeqZzXj5OD3/r5AxhOGBhspU
 7jsiMS6TUZln6bmzBhI4e+e1wNSwszKjD5OKY7CZk1ybWVQ6AMubdC9vrtesLmouX9O2
 pjStJCMCvufUdUcyh+nLOfOCWx0at00UPSaSuPVNp3EfTGlgc/DC+Vy3Dz9cY43ArBxR
 C0Cg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1721268687; x=1721873487;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=xicpGGMfMO3Whly8VKJHDTLwnwM8vY9zbC8Y4IXrE+w=;
 b=cwJf9wEoIebgQZwK1UQ3mDvT8FxvlozNoJ7sma84mvJV5JM1qN4XX1POJz1GZilHVp
 Bq0A52jLHCdlO+S6dKjZUcjCjDiBM8ZINu527ujrRbxkjnK8IBXy+P8/WVj4dlIu+9xI
 9CF3j9mC0BAJADFyOE8ai0y17m8a+0s19ThJh6e6J2Nx2dal1zcQlWeW1cR+5m/zkxl2
 ACZrH+rYe25W+LRhcuaf8mhKb36TvaXKeGa7Ar3EnNFL+rwh9nGqHE8XQ+yA6w2ajuE6
 QR++iyccWwbLvlAU5ASI1ZIhxOTEe/hGkgmz4lxjpjqAN3QvOfVdw7w8r8lLjL2+SnJg
 eXSg==
X-Gm-Message-State: AOJu0YxHyyPoxWY+lwFbw4ve9YN+fdeHBw+K8wuGgiGpniGw/RDnvrDE
 pMTjw+88PTY2iYYXcztly5d7wsnsIXPb63Um3oO83d58YlxKOKTAC9azefSF
X-Google-Smtp-Source: AGHT+IHCZTs0rRIQLbpYO9FtYNs5aTFnK+YVOiCABgx2sw91R/Jl4jrSy8OjufzUylL0bifm24n+4Q==
X-Received: by 2002:a05:6a21:32a9:b0:1c2:8904:14c2 with SMTP id
 adf61e73a8af0-1c3fdddcbaemr4514838637.37.1721268686804; 
 Wed, 17 Jul 2024 19:11:26 -0700 (PDT)
Received: from toolbox.alistair23.me
 (2403-580b-97e8-0-82ce-f179-8a79-69f4.ip6.aussiebb.net.
 [2403:580b:97e8:0:82ce:f179:8a79:69f4])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-1fc0bba949bsm81999385ad.69.2024.07.17.19.11.23
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 17 Jul 2024 19:11:26 -0700 (PDT)
From: Alistair Francis <alistair23@gmail.com>
X-Google-Original-From: Alistair Francis <alistair.francis@wdc.com>
To: qemu-devel@nongnu.org
Cc: alistair23@gmail.com, Atish Patra <atishp@rivosinc.com>,
 Rajnesh Kanwal <rkanwal@rivosinc.com>,
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>,
 Alistair Francis <alistair.francis@wdc.com>
Subject: [PULL 21/30] target/riscv: Implement privilege mode filtering for
 cycle/instret
Date: Thu, 18 Jul 2024 12:10:03 +1000
Message-ID: <20240718021012.2057986-22-alistair.francis@wdc.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240718021012.2057986-1-alistair.francis@wdc.com>
References: <20240718021012.2057986-1-alistair.francis@wdc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::52f;
 envelope-from=alistair23@gmail.com; helo=mail-pg1-x52f.google.com
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

From: Atish Patra <atishp@rivosinc.com>

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
Message-ID: <20240711-smcntrpmf_v7-v8-7-b7c38ae7b263@rivosinc.com>
Signed-off-by: Alistair Francis <alistair.francis@wdc.com>
---
 target/riscv/cpu.h        |  11 ++++
 target/riscv/pmu.h        |   2 +
 target/riscv/cpu_helper.c |   9 ++-
 target/riscv/csr.c        | 117 ++++++++++++++++++++++++++------------
 target/riscv/pmu.c        |  92 ++++++++++++++++++++++++++++++
 5 files changed, 194 insertions(+), 37 deletions(-)

diff --git a/target/riscv/cpu.h b/target/riscv/cpu.h
index 980e2154cd..f515ad072b 100644
--- a/target/riscv/cpu.h
+++ b/target/riscv/cpu.h
@@ -181,6 +181,15 @@ typedef struct PMUCTRState {
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
@@ -377,6 +386,8 @@ struct CPUArchState {
     /* PMU event selector configured values for RV32 */
     target_ulong mhpmeventh_val[RV_MAX_MHPMEVENTS];
 
+    PMUFixedCtrState pmu_fixed_ctrs[2];
+
     target_ulong sscratch;
     target_ulong mscratch;
 
diff --git a/target/riscv/pmu.h b/target/riscv/pmu.h
index 7c0ad661e0..ca40cfeed6 100644
--- a/target/riscv/pmu.h
+++ b/target/riscv/pmu.h
@@ -34,5 +34,7 @@ int riscv_pmu_incr_ctr(RISCVCPU *cpu, enum riscv_pmu_event_idx event_idx);
 void riscv_pmu_generate_fdt_node(void *fdt, uint32_t cmask, char *pmu_name);
 int riscv_pmu_setup_timer(CPURISCVState *env, uint64_t value,
                           uint32_t ctr_idx);
+void riscv_pmu_update_fixed_ctrs(CPURISCVState *env, target_ulong newpriv,
+                                 bool new_virt);
 
 #endif /* RISCV_PMU_H */
diff --git a/target/riscv/cpu_helper.c b/target/riscv/cpu_helper.c
index 10d3fdaed3..395a1d9140 100644
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
index 364583dc03..85d3f0aa3f 100644
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
index 0e7d58b8a5..ac648cff8d 100644
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
-- 
2.45.2


