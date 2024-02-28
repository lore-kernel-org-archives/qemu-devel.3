Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2E41CC54E55
	for <qemu-devel@archiver.kernel.org>; Wed, 28 Feb 2024 18:52:39 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rfP27-0000p0-Sj; Wed, 28 Feb 2024 13:51:59 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <atishp@rivosinc.com>)
 id 1rfP26-0000nW-4F
 for qemu-devel@nongnu.org; Wed, 28 Feb 2024 13:51:58 -0500
Received: from mail-pf1-x429.google.com ([2607:f8b0:4864:20::429])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <atishp@rivosinc.com>)
 id 1rfP24-0006vR-1Z
 for qemu-devel@nongnu.org; Wed, 28 Feb 2024 13:51:57 -0500
Received: by mail-pf1-x429.google.com with SMTP id
 d2e1a72fcca58-6e53f3f1f82so2416705b3a.2
 for <qemu-devel@nongnu.org>; Wed, 28 Feb 2024 10:51:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=rivosinc-com.20230601.gappssmtp.com; s=20230601; t=1709146315; x=1709751115;
 darn=nongnu.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=zdUD+txtqm8gMk/o0WJ1znx2d26DxFyOwNv4Rjb9sNI=;
 b=xvz07JbQ9rTI7LkbLK7vZ/a2gD0TO7aSm94spcUIobmSNpdHlpRIa74w26ex5czEh7
 KRHX6Civ0sIUcPmxi0FYeB7dIvbXXy5C4vsWs6OobNm0A01bVyCHhgC1Sg/GN/pcXJgz
 FtzBJIFU+hKyr6F8KsR2rZgsLk7zD3s6793qlZ/eBMlKxu0wjYOU4AIatHgAHcuoAFmy
 UXQ7as0VdCPeKlZV4BAmkP0ioZf7HFDd1H7JGzwhyzgy67eDgH6sV73h3Z84U0zTxEC6
 C+RH1qAt7d/S391E4SBeZhzIhVRZrFn1xNBPzncHBonk6A2E6GGV8TcO4TSC38g/+Pnw
 v0eg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1709146315; x=1709751115;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=zdUD+txtqm8gMk/o0WJ1znx2d26DxFyOwNv4Rjb9sNI=;
 b=AC7UlpnFrOnfbRhHlxebIaVmZkooT4PmepPGHorNtoQKaliGtmaUPQ8Yf524kQXobB
 wEs/3Pup0iGcM6sSwej8gJSgrxHBX8WcI6HoNJBeakMJjyirONw6182RVQya4zzavCiu
 twNlqrxn3oImK/wSwoawwXU6B6TbOHmmiHOpU54ytxKbA7Fmzdf06lg5PH9lUe18Tg7e
 QolskC02VQi3vsB33R6XyoqrnbvOoM0ABfNDYEf6OEkA/wB7dMkPi+/vXUHbOLvYd0ij
 t25a2ER9kcQisnqykHPoceisK6wFIws/5A6DdPNA1TDGbvMY9iPKb1d3edM751+JIgWX
 RB5A==
X-Forwarded-Encrypted: i=1;
 AJvYcCXykZRjk8Ph1MutZBAcUqHYmkzuYDWIhSIE6fuFeROrfKohjME5GMNSo0ik40c4i2mNc1FvIWnDsR27hZ0VhhdXcFxj3w8=
X-Gm-Message-State: AOJu0YwA+sHYWatKTF30oA9JYgBHcJIkrcZ+Utbfl93ToaDBtxcPmBUH
 zZ8NOC0v9SuGyM6gx976N63fwXu0gY11iiymhSsBXPV6C+DhofGj3HPPHf0ZyctfuKm52d6gkY7
 /
X-Google-Smtp-Source: AGHT+IEZcgWEZkpxMvfEUrRyCgUk3zRTKn4j32a7pVpHIIR9c55Pks+X67oEzKHcg5TmmlZznBSpJA==
X-Received: by 2002:a05:6a00:17a6:b0:6e5:5425:d914 with SMTP id
 s38-20020a056a0017a600b006e55425d914mr28825pfg.2.1709146314738; 
 Wed, 28 Feb 2024 10:51:54 -0800 (PST)
Received: from atishp.ba.rivosinc.com ([64.71.180.162])
 by smtp.gmail.com with ESMTPSA id
 o20-20020a635d54000000b005dbed0ffb10sm49562pgm.83.2024.02.28.10.51.53
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 28 Feb 2024 10:51:54 -0800 (PST)
From: Atish Patra <atishp@rivosinc.com>
To: 
Cc: Daniel Henrique Barboza <dbarboza@ventanamicro.com>,
 Atish Patra <atishp@rivosinc.com>,
 Alistair Francis <alistair.francis@wdc.com>,
 Bin Meng <bin.meng@windriver.com>,
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>,
 Palmer Dabbelt <palmer@dabbelt.com>, qemu-devel@nongnu.org,
 qemu-riscv@nongnu.org, Weiwei Li <liwei1518@gmail.com>,
 kaiwenxue1@gmail.com
Subject: [PATCH v5 5/5] target/riscv: Implement privilege mode filtering for
 cycle/instret
Date: Wed, 28 Feb 2024 10:51:16 -0800
Message-Id: <20240228185116.1321730-6-atishp@rivosinc.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240228185116.1321730-1-atishp@rivosinc.com>
References: <20240228185116.1321730-1-atishp@rivosinc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::429;
 envelope-from=atishp@rivosinc.com; helo=mail-pf1-x429.google.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001, T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

Reviewed-by: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
Signed-off-by: Atish Patra <atishp@rivosinc.com>
---
 target/riscv/cpu.h        | 11 +++++
 target/riscv/cpu_bits.h   |  5 ++
 target/riscv/cpu_helper.c | 17 ++++++-
 target/riscv/csr.c        | 96 ++++++++++++++++++++++++++++++---------
 target/riscv/pmu.c        | 64 ++++++++++++++++++++++++++
 target/riscv/pmu.h        |  2 +
 6 files changed, 171 insertions(+), 24 deletions(-)

diff --git a/target/riscv/cpu.h b/target/riscv/cpu.h
index 174e8ba8e847..9e21d7f7d635 100644
--- a/target/riscv/cpu.h
+++ b/target/riscv/cpu.h
@@ -157,6 +157,15 @@ typedef struct PMUCTRState {
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
@@ -353,6 +362,8 @@ struct CPUArchState {
     /* PMU event selector configured values for RV32 */
     target_ulong mhpmeventh_val[RV_MAX_MHPMEVENTS];
 
+    PMUFixedCtrState pmu_fixed_ctrs[2];
+
     target_ulong sscratch;
     target_ulong mscratch;
 
diff --git a/target/riscv/cpu_bits.h b/target/riscv/cpu_bits.h
index e866c60a400c..5fe349e313dc 100644
--- a/target/riscv/cpu_bits.h
+++ b/target/riscv/cpu_bits.h
@@ -920,6 +920,11 @@ typedef enum RISCVException {
 #define MHPMEVENT_BIT_VUINH                BIT_ULL(58)
 #define MHPMEVENTH_BIT_VUINH               BIT(26)
 
+#define MHPMEVENT_FILTER_MASK              (MHPMEVENT_BIT_MINH  | \
+                                            MHPMEVENT_BIT_SINH  | \
+                                            MHPMEVENT_BIT_UINH  | \
+                                            MHPMEVENT_BIT_VSINH | \
+                                            MHPMEVENT_BIT_VUINH)
 #define MHPMEVENT_SSCOF_MASK               _ULL(0xFFFF000000000000)
 #define MHPMEVENT_IDX_MASK                 0xFFFFF
 #define MHPMEVENT_SSCOF_RESVD              16
diff --git a/target/riscv/cpu_helper.c b/target/riscv/cpu_helper.c
index d462d95ee165..33965d843d46 100644
--- a/target/riscv/cpu_helper.c
+++ b/target/riscv/cpu_helper.c
@@ -718,8 +718,21 @@ void riscv_cpu_set_mode(CPURISCVState *env, target_ulong newpriv)
 {
     g_assert(newpriv <= PRV_M && newpriv != PRV_RESERVED);
 
-    if (icount_enabled() && newpriv != env->priv) {
-        riscv_itrigger_update_priv(env);
+    /*
+     * Invoke cycle/instret update between priv mode changes or
+     * VS->HS mode transition is SPV bit must be set
+     * HS->VS mode transition where virt_enabled must be set
+     * In both cases, priv will S mode only.
+     */
+    if (newpriv != env->priv ||
+       (env->priv == PRV_S && newpriv == PRV_S &&
+        (env->virt_enabled || get_field(env->hstatus, HSTATUS_SPV)))) {
+        if (icount_enabled()) {
+            riscv_itrigger_update_priv(env);
+            riscv_pmu_icount_update_priv(env, newpriv);
+        } else {
+            riscv_pmu_cycle_update_priv(env, newpriv);
+        }
     }
     /* tlb_flush is unnecessary as mode is contained in mmu_idx */
     env->priv = newpriv;
diff --git a/target/riscv/csr.c b/target/riscv/csr.c
index ff9bac537593..482e212c5f74 100644
--- a/target/riscv/csr.c
+++ b/target/riscv/csr.c
@@ -788,32 +788,16 @@ static RISCVException write_vcsr(CPURISCVState *env, int csrno,
     return RISCV_EXCP_NONE;
 }
 
+#if defined(CONFIG_USER_ONLY)
 /* User Timers and Counters */
 static target_ulong get_ticks(bool shift)
 {
-    int64_t val;
-    target_ulong result;
-
-#if !defined(CONFIG_USER_ONLY)
-    if (icount_enabled()) {
-        val = icount_get();
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
@@ -952,6 +936,71 @@ static RISCVException write_mhpmeventh(CPURISCVState *env, int csrno,
     return RISCV_EXCP_NONE;
 }
 
+static target_ulong riscv_pmu_ctr_get_fixed_counters_val(CPURISCVState *env,
+                                                         int counter_idx,
+                                                         bool upper_half)
+{
+    uint64_t curr_val = 0;
+    target_ulong result = 0;
+    uint64_t *counter_arr = icount_enabled() ? env->pmu_fixed_ctrs[1].counter :
+                            env->pmu_fixed_ctrs[0].counter;
+    uint64_t *counter_arr_virt = icount_enabled() ?
+                                 env->pmu_fixed_ctrs[1].counter_virt :
+                                 env->pmu_fixed_ctrs[0].counter_virt;
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
+            curr_val = icount_get_raw();
+        } else {
+            curr_val = cpu_get_host_ticks();
+        }
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
@@ -962,7 +1011,8 @@ static RISCVException write_mhpmcounter(CPURISCVState *env, int csrno,
     counter->mhpmcounter_val = val;
     if (riscv_pmu_ctr_monitor_cycles(env, ctr_idx) ||
         riscv_pmu_ctr_monitor_instructions(env, ctr_idx)) {
-        counter->mhpmcounter_prev = get_ticks(false);
+        counter->mhpmcounter_prev = riscv_pmu_ctr_get_fixed_counters_val(env,
+                                                                ctr_idx, false);
         if (ctr_idx > 2) {
             if (riscv_cpu_mxl(env) == MXL_RV32) {
                 mhpmctr_val = mhpmctr_val |
@@ -990,7 +1040,8 @@ static RISCVException write_mhpmcounterh(CPURISCVState *env, int csrno,
     mhpmctr_val = mhpmctr_val | (mhpmctrh_val << 32);
     if (riscv_pmu_ctr_monitor_cycles(env, ctr_idx) ||
         riscv_pmu_ctr_monitor_instructions(env, ctr_idx)) {
-        counter->mhpmcounterh_prev = get_ticks(true);
+        counter->mhpmcounterh_prev = riscv_pmu_ctr_get_fixed_counters_val(env,
+                                                                 ctr_idx, true);
         if (ctr_idx > 2) {
             riscv_pmu_setup_timer(env, mhpmctr_val, ctr_idx);
         }
@@ -1031,7 +1082,8 @@ static RISCVException riscv_pmu_read_ctr(CPURISCVState *env, target_ulong *val,
      */
     if (riscv_pmu_ctr_monitor_cycles(env, ctr_idx) ||
         riscv_pmu_ctr_monitor_instructions(env, ctr_idx)) {
-        *val = get_ticks(upper_half) - ctr_prev + ctr_val;
+        *val = riscv_pmu_ctr_get_fixed_counters_val(env, ctr_idx, upper_half) -
+                                                    ctr_prev + ctr_val;
     } else {
         *val = ctr_val;
     }
diff --git a/target/riscv/pmu.c b/target/riscv/pmu.c
index 0e7d58b8a5c2..37309ff64cb6 100644
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
@@ -176,6 +177,69 @@ static int riscv_pmu_incr_ctr_rv64(RISCVCPU *cpu, uint32_t ctr_idx)
     return 0;
 }
 
+void riscv_pmu_icount_update_priv(CPURISCVState *env, target_ulong newpriv)
+{
+    uint64_t delta;
+    uint64_t *counter_arr;
+    uint64_t *counter_arr_prev;
+    uint64_t current_icount = icount_get_raw();
+
+    if (env->virt_enabled) {
+        counter_arr = env->pmu_fixed_ctrs[1].counter_virt;
+        counter_arr_prev = env->pmu_fixed_ctrs[1].counter_virt_prev;
+    } else {
+        counter_arr = env->pmu_fixed_ctrs[1].counter;
+        counter_arr_prev = env->pmu_fixed_ctrs[1].counter_prev;
+    }
+
+    if (newpriv != env->priv) {
+        delta = current_icount - counter_arr_prev[env->priv];
+        counter_arr_prev[newpriv] = current_icount;
+    } else {
+        delta = current_icount - counter_arr_prev[env->priv];
+        if (env->virt_enabled) {
+            /* HS->VS transition.The previous value should correspond to HS. */
+            env->pmu_fixed_ctrs[1].counter_prev[PRV_S] = current_icount;
+        } else if (get_field(env->hstatus, HSTATUS_SPV)) {
+            /* VS->HS transition.The previous value should correspond to VS. */
+            env->pmu_fixed_ctrs[1].counter_virt_prev[PRV_S] = current_icount;
+        }
+   }
+
+    counter_arr[env->priv] += delta;
+}
+
+void riscv_pmu_cycle_update_priv(CPURISCVState *env, target_ulong newpriv)
+{
+    uint64_t delta;
+    uint64_t *counter_arr;
+    uint64_t *counter_arr_prev;
+    uint64_t current_host_ticks = cpu_get_host_ticks();
+
+    if (env->virt_enabled) {
+        counter_arr = env->pmu_fixed_ctrs[0].counter_virt;
+        counter_arr_prev = env->pmu_fixed_ctrs[0].counter_virt_prev;
+    } else {
+        counter_arr = env->pmu_fixed_ctrs[0].counter;
+        counter_arr_prev = env->pmu_fixed_ctrs[0].counter_prev;
+    }
+
+    if (newpriv != env->priv) {
+        delta = current_host_ticks - counter_arr_prev[env->priv];
+        counter_arr_prev[newpriv] = current_host_ticks;
+    } else {
+        delta = current_host_ticks - counter_arr_prev[env->priv];
+        if (env->virt_enabled) {
+            env->pmu_fixed_ctrs[0].counter_prev[PRV_S] = current_host_ticks;
+        } else if (get_field(env->hstatus, HSTATUS_SPV)) {
+            env->pmu_fixed_ctrs[0].counter_virt_prev[PRV_S] =
+            current_host_ticks;
+        }
+   }
+
+    counter_arr[env->priv] += delta;
+}
+
 int riscv_pmu_incr_ctr(RISCVCPU *cpu, enum riscv_pmu_event_idx event_idx)
 {
     uint32_t ctr_idx;
diff --git a/target/riscv/pmu.h b/target/riscv/pmu.h
index 505fc850d38e..50de6031a730 100644
--- a/target/riscv/pmu.h
+++ b/target/riscv/pmu.h
@@ -31,3 +31,5 @@ int riscv_pmu_incr_ctr(RISCVCPU *cpu, enum riscv_pmu_event_idx event_idx);
 void riscv_pmu_generate_fdt_node(void *fdt, uint32_t cmask, char *pmu_name);
 int riscv_pmu_setup_timer(CPURISCVState *env, uint64_t value,
                           uint32_t ctr_idx);
+void riscv_pmu_icount_update_priv(CPURISCVState *env, target_ulong newpriv);
+void riscv_pmu_cycle_update_priv(CPURISCVState *env, target_ulong newpriv);
-- 
2.34.1


