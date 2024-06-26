Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DE3A3C27C4F
	for <qemu-devel@archiver.kernel.org>; Thu, 27 Jun 2024 00:02:38 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sMcWQ-0007sJ-93; Wed, 26 Jun 2024 19:57:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <atishp@rivosinc.com>)
 id 1sMcWN-0007oX-Fh
 for qemu-devel@nongnu.org; Wed, 26 Jun 2024 19:57:51 -0400
Received: from mail-pl1-x633.google.com ([2607:f8b0:4864:20::633])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <atishp@rivosinc.com>)
 id 1sMcWL-0005Yi-M6
 for qemu-devel@nongnu.org; Wed, 26 Jun 2024 19:57:51 -0400
Received: by mail-pl1-x633.google.com with SMTP id
 d9443c01a7336-1f9fb3ca81bso34477885ad.3
 for <qemu-devel@nongnu.org>; Wed, 26 Jun 2024 16:57:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=rivosinc-com.20230601.gappssmtp.com; s=20230601; t=1719446268; x=1720051068;
 darn=nongnu.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=kiOuZnxKZgHhsg3YblTGvooYdJTV4Rbl81y1fHSr2eM=;
 b=tUdfbe/f9WdMFlskRyghNS3Tp//7RBCrCcbiLqqE16oxipDJllUYgNl+XPfBjAJVhc
 X5fLUyv0U0VHyIguC4cE0nf1j72BHmrPFKW5Xwjl7AGguJU0DyHNrbW9JiUB47H4pxx/
 O9FYOyiTa27mOoy2h5bRJxkWtUFNBQUDZRZDWdfsOrd1fZdXm0pleVyKuT7HqWZs7Y8y
 5zFef9fYuE3aZBbdKGfMGt6nSLlqgZjkVve3YAgtCZgt/dxA9wlFFZM5Ax6OoBD6uiMQ
 f2r6hns/z8q+fZzpq+6eTjpjkdJsHJ2ThJkq13hcTpcFyihngWrfTbSgcYIG5r0ee/Nc
 Xxdw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1719446268; x=1720051068;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=kiOuZnxKZgHhsg3YblTGvooYdJTV4Rbl81y1fHSr2eM=;
 b=BURLgTfIoqDGgy6w2tT+0JeYo/MhS4sPYdtzDPt8SsmFW325xI4oJ0P3jYvrAZOrKR
 fQkbAbZTn0hIpMu6rBNA3THtRIHteo6Nh9e/jFADuwtcrzU2HvfrDpsWpIF23+Ag2Kes
 U9gMGvorWjbx8WYfx7BonC/BXBSoafMOchTl6OZohIJ/FvxKSvSTJ+WjNJIKWykGa2yk
 mqnpu2DKAwjdGhMa4YBiUOq42UVd4ulh2CG4gbSIKSRJsiCELIyUREjFOXLp3gpHjjsa
 UYuQlx4HuAq58uWr++1Sa4BdgiG7R3pxWPcV1c/I6cEORBSII4ZhCbqvngbWmy57BeEp
 o97g==
X-Forwarded-Encrypted: i=1;
 AJvYcCXZs+wkPKxGOADdNZaKz1XXuvq/SKNABCNePD+g//BYxI061aD1ELrbnjMnMRExm1eYakvzWKP76aYbA+YtrxYNhpgxBFA=
X-Gm-Message-State: AOJu0Yx9M7PZayVSx4hYVANaL0Y1A1IBAvTO4o5dZ75zCKrPji7uinGC
 kuqdVQEw8oUVK2ldZTCAi6JfSUv/ifC5XMRLdhvNzT6ro5Nxf/xAxKx0NleRQ6k=
X-Google-Smtp-Source: AGHT+IFodJke1JEzJOOMbifMJciKbP3HHJLigaXz1PvkZrzT7gaDnD4ZoBn3/Ul5c+PkZzAcUcZrCg==
X-Received: by 2002:a17:902:cecc:b0:1f9:ab2c:e458 with SMTP id
 d9443c01a7336-1fa23fd8c26mr119228885ad.31.1719446268271; 
 Wed, 26 Jun 2024 16:57:48 -0700 (PDT)
Received: from atishp.ba.rivosinc.com ([64.71.180.162])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-1faac998398sm630965ad.225.2024.06.26.16.57.47
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 26 Jun 2024 16:57:47 -0700 (PDT)
From: Atish Patra <atishp@rivosinc.com>
Date: Wed, 26 Jun 2024 16:57:30 -0700
Subject: [PATCH v7 10/11] target/riscv: More accurately model priv mode
 filtering.
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240626-smcntrpmf_v7-v7-10-bb0f10af7fa9@rivosinc.com>
References: <20240626-smcntrpmf_v7-v7-0-bb0f10af7fa9@rivosinc.com>
In-Reply-To: <20240626-smcntrpmf_v7-v7-0-bb0f10af7fa9@rivosinc.com>
To: qemu-riscv@nongnu.org, qemu-devel@nongnu.org
Cc: Rajnesh Kanwal <rkanwal@rivosinc.com>, 
 Atish Patra <atishp@rivosinc.com>, palmer@dabbelt.com, liwei1518@gmail.com, 
 zhiwei_liu@linux.alibaba.com, bin.meng@windriver.com, 
 dbarboza@ventanamicro.com, alistair.francis@wdc.com
X-Mailer: b4 0.15-dev-13183
Received-SPF: pass client-ip=2607:f8b0:4864:20::633;
 envelope-from=atishp@rivosinc.com; helo=mail-pl1-x633.google.com
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

In case of programmable counters configured to count inst/cycles
we often end-up with counter not incrementing at all from kernel's
perspective.

For example:
- Kernel configures hpm3 to count instructions and sets hpmcounter
  to -10000 and all modes except U mode are inhibited.
- In QEMU we configure a timer to expire after ~10000 instructions.
- Problem is, it's often the case that kernel might not even schedule
  Umode task and we hit the timer callback in QEMU.
- In the timer callback we inject the interrupt into kernel, kernel
  runs the handler and reads hpmcounter3 value.
- Given QEMU maintains individual counters to count for each privilege
  mode, and given umode never ran, the umode counter didn't increment
  and QEMU returns same value as was programmed by the kernel when
  starting the counter.
- Kernel checks for overflow using previous and current value of the
  counter and reprograms the counter given there wasn't an overflow
  as per the counter value. (Which itself is a problem. We have QEMU
  telling kernel that counter3 overflowed but the counter value
  returned by QEMU doesn't seem to reflect that.).

This change makes sure that timer is reprogrammed from the handler
if the counter didn't overflow based on the counter value.

Second, this change makes sure that whenever the counter is read,
it's value is updated to reflect the latest count.

Signed-off-by: Rajnesh Kanwal <rkanwal@rivosinc.com>
---
 target/riscv/csr.c |  5 ++++-
 target/riscv/pmu.c | 30 +++++++++++++++++++++++++++---
 target/riscv/pmu.h |  2 ++
 3 files changed, 33 insertions(+), 4 deletions(-)

diff --git a/target/riscv/csr.c b/target/riscv/csr.c
index 150e02f080ec..91172b90e000 100644
--- a/target/riscv/csr.c
+++ b/target/riscv/csr.c
@@ -970,6 +970,9 @@ static target_ulong riscv_pmu_ctr_get_fixed_counters_val(CPURISCVState *env,
         goto done;
     }
 
+    /* Update counter before reading. */
+    riscv_pmu_update_fixed_ctrs(env, env->priv, env->virt_enabled);
+
     if (!(cfg_val & MCYCLECFG_BIT_MINH)) {
         curr_val += counter_arr[PRV_M];
     }
@@ -1053,7 +1056,7 @@ static RISCVException write_mhpmcounterh(CPURISCVState *env, int csrno,
     return RISCV_EXCP_NONE;
 }
 
-static RISCVException riscv_pmu_read_ctr(CPURISCVState *env, target_ulong *val,
+RISCVException riscv_pmu_read_ctr(CPURISCVState *env, target_ulong *val,
                                          bool upper_half, uint32_t ctr_idx)
 {
     PMUCTRState *counter = &env->pmu_ctrs[ctr_idx];
diff --git a/target/riscv/pmu.c b/target/riscv/pmu.c
index 63420d9f3679..a4729f6c53bb 100644
--- a/target/riscv/pmu.c
+++ b/target/riscv/pmu.c
@@ -425,6 +425,8 @@ static void pmu_timer_trigger_irq(RISCVCPU *cpu,
     target_ulong *mhpmevent_val;
     uint64_t of_bit_mask;
     int64_t irq_trigger_at;
+    uint64_t curr_ctr_val, curr_ctrh_val;
+    uint64_t ctr_val;
 
     if (evt_idx != RISCV_PMU_EVENT_HW_CPU_CYCLES &&
         evt_idx != RISCV_PMU_EVENT_HW_INSTRUCTIONS) {
@@ -454,6 +456,26 @@ static void pmu_timer_trigger_irq(RISCVCPU *cpu,
         return;
     }
 
+    riscv_pmu_read_ctr(env, (target_ulong *)&curr_ctr_val, false, ctr_idx);
+    ctr_val = counter->mhpmcounter_val;
+    if (riscv_cpu_mxl(env) == MXL_RV32) {
+        riscv_pmu_read_ctr(env, (target_ulong *)&curr_ctrh_val, true, ctr_idx);
+        curr_ctr_val = curr_ctr_val | (curr_ctrh_val << 32);
+        ctr_val = ctr_val |
+                ((uint64_t)counter->mhpmcounterh_val << 32);
+    }
+
+    /*
+     * We can not accommodate for inhibited modes when setting up timer. Check
+     * if the counter has actually overflowed or not by comparing current
+     * counter value (accommodated for inhibited modes) with software written
+     * counter value.
+     */
+    if (curr_ctr_val >= ctr_val) {
+        riscv_pmu_setup_timer(env, curr_ctr_val, ctr_idx);
+        return;
+    }
+
     if (cpu->pmu_avail_ctrs & BIT(ctr_idx)) {
         /* Generate interrupt only if OF bit is clear */
         if (!(*mhpmevent_val & of_bit_mask)) {
@@ -475,7 +497,7 @@ void riscv_pmu_timer_cb(void *priv)
 
 int riscv_pmu_setup_timer(CPURISCVState *env, uint64_t value, uint32_t ctr_idx)
 {
-    uint64_t overflow_delta, overflow_at;
+    uint64_t overflow_delta, overflow_at, curr_ns;
     int64_t overflow_ns, overflow_left = 0;
     RISCVCPU *cpu = env_archcpu(env);
     PMUCTRState *counter = &env->pmu_ctrs[ctr_idx];
@@ -506,8 +528,10 @@ int riscv_pmu_setup_timer(CPURISCVState *env, uint64_t value, uint32_t ctr_idx)
     } else {
         return -1;
     }
-    overflow_at = (uint64_t)qemu_clock_get_ns(QEMU_CLOCK_VIRTUAL) +
-                  overflow_ns;
+    curr_ns = (uint64_t)qemu_clock_get_ns(QEMU_CLOCK_VIRTUAL);
+    overflow_at =  curr_ns + overflow_ns;
+    if (overflow_at <= curr_ns)
+        overflow_at = UINT64_MAX;
 
     if (overflow_at > INT64_MAX) {
         overflow_left += overflow_at - INT64_MAX;
diff --git a/target/riscv/pmu.h b/target/riscv/pmu.h
index ca40cfeed647..3853d0e2629e 100644
--- a/target/riscv/pmu.h
+++ b/target/riscv/pmu.h
@@ -36,5 +36,7 @@ int riscv_pmu_setup_timer(CPURISCVState *env, uint64_t value,
                           uint32_t ctr_idx);
 void riscv_pmu_update_fixed_ctrs(CPURISCVState *env, target_ulong newpriv,
                                  bool new_virt);
+RISCVException riscv_pmu_read_ctr(CPURISCVState *env, target_ulong *val,
+                                  bool upper_half, uint32_t ctr_idx);
 
 #endif /* RISCV_PMU_H */

-- 
2.34.1


