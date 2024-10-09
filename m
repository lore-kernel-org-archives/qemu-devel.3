Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6BF73CED611
	for <qemu-devel@archiver.kernel.org>; Wed,  9 Oct 2024 23:10:21 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1syfny-0006qy-H2; Wed, 09 Oct 2024 19:09:18 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <atishp@rivosinc.com>)
 id 1syfnu-0006pV-SZ
 for qemu-devel@nongnu.org; Wed, 09 Oct 2024 19:09:15 -0400
Received: from mail-pj1-x102a.google.com ([2607:f8b0:4864:20::102a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <atishp@rivosinc.com>)
 id 1syfns-0000jw-Me
 for qemu-devel@nongnu.org; Wed, 09 Oct 2024 19:09:14 -0400
Received: by mail-pj1-x102a.google.com with SMTP id
 98e67ed59e1d1-2e0894f1b14so292335a91.1
 for <qemu-devel@nongnu.org>; Wed, 09 Oct 2024 16:09:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=rivosinc-com.20230601.gappssmtp.com; s=20230601; t=1728515351; x=1729120151;
 darn=nongnu.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=dyOp9jYFmTEOq1ccHJ4A30zX+4VSYUpSqUZ/7CBa0Vk=;
 b=nGdC4CcUX0YSIAwkEmb5ymEPbgI7324HGgxRCLILRn7b9AXhcBw2rQ6lVqw9TCj7Pz
 5BZPcYuxQaAyHnqc7k9RW68t+Daiv1hZm94qoBR8wxuc1RZmHtpi2kydxugqT9pa26MZ
 6LsNTHS8TCkM1rs6Av+4sBNwTeCQYNNGUFd3bEpxlGcCGzrxlbOIrxKDGxsf2zYfsBFJ
 XXc5KTzfbv3oxHFQ8uo5AhQ2WQbOate5CAdC5cuKPBRhx2IQ8r1qa/SvhgYMEV+6q5Yc
 pTtz/8kbhSxnIlVheU3WfKEN3ASTnm1U5VuuEWTK9BFjQ7sLYDqWhCBPYNfAEjhD9bmJ
 fgcg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1728515351; x=1729120151;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=dyOp9jYFmTEOq1ccHJ4A30zX+4VSYUpSqUZ/7CBa0Vk=;
 b=gKLU1WhHqMw1vF33IE01MO9WTnDkNNqqEgKbqW/B2kLDQNlSRvW/8oAJfmkIy0B5zp
 0vvt7gGmCJtoI3Uk1cyoWGHEubhxh8ywoyfXg1GI/yNqetIFdew0wFZInb5kQD50wl3E
 UlWx3YPr7ebh4sJfjjIzOadnDObfRRTE9O4PqjgWxZ9Gd/qNwe8tABzUWxnPwTqnZNWf
 ExVXZA73ytXQS2itIEBCmti8BWrIYF/kO2qirZvzyUSn0+rwZyuG6QxBf9ebgeht/C+G
 Ci0aStJjbbJpCQyGSM5J3OS2rbamuTUbxNQHYThYT47a4YR56CZADTuhowf66PnpROAu
 zCVQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCWMkG5Hdop/Qd/ulnD8+dZyJ+ju1283VZGkTEJ21du0pnU5Lq1MkiIwcllQqBwObRphOgknUW6bwS/e@nongnu.org
X-Gm-Message-State: AOJu0YyOIv2engLmbZwU0qayxB+NiVqhkKh1YxE1zy7rpCRdIBg9tzda
 UZ4Fm2pgfuZDuMxEklkdyKtXRb9EB/pu5t9SM+WwJLIKyAth42pyoMBIgYR1fGs=
X-Google-Smtp-Source: AGHT+IF8LOxp0uJmGOg1BDCJF7X/4SmgLy8ilI5NOphEPG67UT33ytrK1ZVueBsPwb438U+LMOe8ow==
X-Received: by 2002:a17:90a:5e45:b0:2e2:9077:a3b4 with SMTP id
 98e67ed59e1d1-2e2a21da8c6mr4833072a91.7.1728515351169; 
 Wed, 09 Oct 2024 16:09:11 -0700 (PDT)
Received: from atishp.ba.rivosinc.com ([64.71.180.162])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-2e2a55f9855sm2271902a91.2.2024.10.09.16.09.10
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 09 Oct 2024 16:09:10 -0700 (PDT)
From: Atish Patra <atishp@rivosinc.com>
Date: Wed, 09 Oct 2024 16:09:05 -0700
Subject: [PATCH RFC 07/10] hw/riscv/virt.c : Disassociate virt PMU events
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241009-pmu_event_machine-v1-7-dcbd7a60e3ba@rivosinc.com>
References: <20241009-pmu_event_machine-v1-0-dcbd7a60e3ba@rivosinc.com>
In-Reply-To: <20241009-pmu_event_machine-v1-0-dcbd7a60e3ba@rivosinc.com>
To: qemu-riscv@nongnu.org, qemu-devel@nongnu.org
Cc: alexei.filippov@syntacore.com, Atish Patra <atishp@rivosinc.com>, 
 palmer@dabbelt.com, liwei1518@gmail.com, zhiwei_liu@linux.alibaba.com, 
 bin.meng@windriver.com, dbarboza@ventanamicro.com, alistair.francis@wdc.com
X-Mailer: b4 0.15-dev-13183
Received-SPF: pass client-ip=2607:f8b0:4864:20::102a;
 envelope-from=atishp@rivosinc.com; helo=mail-pj1-x102a.google.com
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

The virt PMU related implemention should belong to virt
machine file rather than common pmu.c which can be used
for other implementations.

Make pmu.c generic by moving all the virt PMU event related
structures to it's appropriate place.

Signed-off-by: Atish Patra <atishp@rivosinc.com>
---
 hw/riscv/virt.c    | 81 ++++++++++++++++++++++++++++++++++++++++++++++++++++++
 target/riscv/pmu.c | 73 ++++++++++++++++++++++++++++++------------------
 2 files changed, 128 insertions(+), 26 deletions(-)

diff --git a/hw/riscv/virt.c b/hw/riscv/virt.c
index ee3129f3b314..ffda6d65d673 100644
--- a/hw/riscv/virt.c
+++ b/hw/riscv/virt.c
@@ -56,6 +56,61 @@
 #include "qapi/qapi-visit-common.h"
 #include "hw/virtio/virtio-iommu.h"
 
+static PMUEventInfo pmu_events_arr[] = {
+    {
+        .event_id = VIRT_PMU_EVENT_HW_CPU_CYCLES,
+        .counter_mask = 0x01,
+    },
+    {
+        .event_id = VIRT_PMU_EVENT_HW_INSTRUCTIONS,
+        .counter_mask = 0x04,
+    },
+    {
+        .event_id = VIRT_PMU_EVENT_CACHE_DTLB_READ_MISS,
+        .counter_mask = 0,
+    },
+    {
+        .event_id = VIRT_PMU_EVENT_CACHE_DTLB_WRITE_MISS,
+        .counter_mask = 0,
+    },
+    {
+        .event_id = VIRT_PMU_EVENT_CACHE_ITLB_PREFETCH_MISS,
+        .counter_mask = 0,
+    },
+};
+
+static inline uint64_t virt_pmu_get_cycle_event_id(RISCVCPU *cpu)
+{
+    return VIRT_PMU_EVENT_HW_CPU_CYCLES;
+}
+
+static inline uint64_t virt_pmu_get_instret_event_id(RISCVCPU *cpu)
+{
+    return VIRT_PMU_EVENT_HW_INSTRUCTIONS;
+}
+
+static uint64_t virt_pmu_get_tlb_event_id(RISCVCPU *cpu,
+                                          MMUAccessType access_type)
+{
+    uint64_t tlb_event_type = ULONG_MAX;
+
+    switch (access_type) {
+    case MMU_INST_FETCH:
+        tlb_event_type = VIRT_PMU_EVENT_CACHE_ITLB_PREFETCH_MISS;
+        break;
+    case MMU_DATA_LOAD:
+        tlb_event_type = VIRT_PMU_EVENT_CACHE_DTLB_READ_MISS;
+        break;
+    case MMU_DATA_STORE:
+        tlb_event_type = VIRT_PMU_EVENT_CACHE_DTLB_WRITE_MISS;
+        break;
+    default:
+        break;
+    }
+
+    return tlb_event_type;
+}
+
 /* KVM AIA only supports APLIC MSI. APLIC Wired is always emulated by QEMU. */
 static bool virt_use_kvm_aia(RISCVVirtState *s)
 {
@@ -710,6 +765,29 @@ static void create_fdt_socket_aplic(RISCVVirtState *s,
     aplic_phandles[socket] = aplic_s_phandle;
 }
 
+static void virt_pmu_events_init(RISCVVirtState *s)
+{
+    int cpu, socket, i;
+    MachineState *ms = MACHINE(s);
+    int num_sockets = riscv_socket_count(ms);
+    RISCVCPU *hart;
+
+    for (socket = 0 ; socket < num_sockets; socket++) {
+        for (cpu = s->soc[socket].num_harts - 1; cpu >= 0; cpu--) {
+            hart = &s->soc[socket].harts[cpu];
+            hart->env.num_pmu_events = 5;
+            /* All hpmcounters can monitor all supported events */
+            for (i = 0; i < ARRAY_SIZE(pmu_events_arr); i++) {
+                pmu_events_arr[i].counter_mask |= hart->cfg.pmu_mask;
+            }
+            hart->env.pmu_events = pmu_events_arr;
+            hart->env.pmu_efuncs.get_cycle_id = virt_pmu_get_cycle_event_id;
+            hart->env.pmu_efuncs.get_intstret_id = virt_pmu_get_instret_event_id;
+            hart->env.pmu_efuncs.get_tlb_access_id = virt_pmu_get_tlb_event_id;
+        }
+    }
+}
+
 static void create_fdt_pmu(RISCVVirtState *s)
 {
     g_autofree char *pmu_name = g_strdup_printf("/pmu");
@@ -1614,6 +1692,9 @@ static void virt_machine_init(MachineState *machine)
     }
     virt_flash_map(s, system_memory);
 
+    /* Setup the PMU Event details. This must happen before fdt setup */
+    virt_pmu_events_init(s);
+
     /* load/create device tree */
     if (machine->dtb) {
         machine->fdt = load_device_tree(machine->dtb, &s->fdt_size);
diff --git a/target/riscv/pmu.c b/target/riscv/pmu.c
index c436b08d1043..3235388c66e4 100644
--- a/target/riscv/pmu.c
+++ b/target/riscv/pmu.c
@@ -304,7 +304,8 @@ int riscv_pmu_incr_ctr(RISCVCPU *cpu, enum virt_pmu_event_idx event_idx)
 bool riscv_pmu_ctr_monitor_instructions(CPURISCVState *env,
                                         uint32_t target_ctr)
 {
-    RISCVCPU *cpu;
+    uint64_t event_idx = ULONG_MAX;
+    RISCVCPU *cpu = env_archcpu(env);
     uint32_t ctr_idx;
 
     /* Fixed instret counter */
@@ -312,9 +313,15 @@ bool riscv_pmu_ctr_monitor_instructions(CPURISCVState *env,
         return true;
     }
 
-    cpu = env_archcpu(env);
-    if (!riscv_pmu_htable_lookup(cpu, VIRT_PMU_EVENT_HW_INSTRUCTIONS,
-                                 &ctr_idx)) {
+    if (env->pmu_efuncs.get_intstret_id) {
+        event_idx = env->pmu_efuncs.get_intstret_id(cpu);
+    }
+
+    if (event_idx == ULONG_MAX) {
+        return false;
+    }
+
+    if (!riscv_pmu_htable_lookup(cpu, event_idx, &ctr_idx)) {
         return false;
     }
 
@@ -323,7 +330,8 @@ bool riscv_pmu_ctr_monitor_instructions(CPURISCVState *env,
 
 bool riscv_pmu_ctr_monitor_cycles(CPURISCVState *env, uint32_t target_ctr)
 {
-    RISCVCPU *cpu;
+    uint64_t event_idx = ULONG_MAX;
+    RISCVCPU *cpu = env_archcpu(env);
     uint32_t ctr_idx;
 
     /* Fixed mcycle counter */
@@ -331,9 +339,15 @@ bool riscv_pmu_ctr_monitor_cycles(CPURISCVState *env, uint32_t target_ctr)
         return true;
     }
 
-    cpu = env_archcpu(env);
-    if (!riscv_pmu_htable_lookup(cpu, VIRT_PMU_EVENT_HW_CPU_CYCLES,
-                                &ctr_idx)) {
+    if (env->pmu_efuncs.get_cycle_id) {
+        event_idx = env->pmu_efuncs.get_cycle_id(cpu);
+    }
+
+    if (event_idx == ULONG_MAX) {
+        return false;
+    }
+
+    if (!riscv_pmu_htable_lookup(cpu, event_idx, &ctr_idx)) {
         return false;
     }
 
@@ -366,6 +380,8 @@ int riscv_pmu_update_event_map(CPURISCVState *env, uint64_t value,
     RISCVCPU *cpu = env_archcpu(env);
     uint32_t mapped_ctr_idx;
     gint64 *eid_ptr;
+    bool valid_event = false;
+    int i;
 
     if (!riscv_pmu_counter_valid(cpu, ctr_idx) || !cpu->pmu_event_ctr_map) {
         return -1;
@@ -389,15 +405,14 @@ int riscv_pmu_update_event_map(CPURISCVState *env, uint64_t value,
         return 0;
     }
 
-    switch (event_idx) {
-    case VIRT_PMU_EVENT_HW_CPU_CYCLES:
-    case VIRT_PMU_EVENT_HW_INSTRUCTIONS:
-    case VIRT_PMU_EVENT_CACHE_DTLB_READ_MISS:
-    case VIRT_PMU_EVENT_CACHE_DTLB_WRITE_MISS:
-    case VIRT_PMU_EVENT_CACHE_ITLB_PREFETCH_MISS:
-        break;
-    default:
-        /* We don't support any raw events right now */
+    for (i = 0; i < env->num_pmu_events; i++) {
+        if (event_idx == env->pmu_events[i].event_id) {
+            valid_event = true;
+            break;
+        }
+    }
+
+    if (!valid_event) {
         return -1;
     }
     eid_ptr = g_new(gint64, 1);
@@ -447,8 +462,7 @@ static bool pmu_hpmevent_set_of_if_clear(CPURISCVState *env, uint32_t ctr_idx)
     return false;
 }
 
-static void pmu_timer_trigger_irq(RISCVCPU *cpu,
-                                  enum virt_pmu_event_idx evt_idx)
+static void pmu_timer_trigger_irq(RISCVCPU *cpu, uint64_t evt_idx)
 {
     uint32_t ctr_idx;
     CPURISCVState *env = &cpu->env;
@@ -457,11 +471,6 @@ static void pmu_timer_trigger_irq(RISCVCPU *cpu,
     uint64_t curr_ctr_val, curr_ctrh_val;
     uint64_t ctr_val;
 
-    if (evt_idx != VIRT_PMU_EVENT_HW_CPU_CYCLES &&
-        evt_idx != VIRT_PMU_EVENT_HW_INSTRUCTIONS) {
-        return;
-    }
-
     if (!riscv_pmu_htable_lookup(cpu, evt_idx, &ctr_idx)) {
         return;
     }
@@ -515,10 +524,22 @@ static void pmu_timer_trigger_irq(RISCVCPU *cpu,
 void riscv_pmu_timer_cb(void *priv)
 {
     RISCVCPU *cpu = priv;
+    uint64_t event_idx;
+    CPURISCVState *env = &cpu->env;
 
     /* Timer event was triggered only for these events */
-    pmu_timer_trigger_irq(cpu, VIRT_PMU_EVENT_HW_CPU_CYCLES);
-    pmu_timer_trigger_irq(cpu, VIRT_PMU_EVENT_HW_INSTRUCTIONS);
+    if (env->pmu_efuncs.get_cycle_id) {
+        event_idx = env->pmu_efuncs.get_cycle_id(cpu);
+        if (event_idx != ULONG_MAX) {
+            pmu_timer_trigger_irq(cpu, event_idx);
+        }
+    }
+    if (env->pmu_efuncs.get_intstret_id) {
+        event_idx = env->pmu_efuncs.get_intstret_id(cpu);
+        if (event_idx != ULONG_MAX) {
+            pmu_timer_trigger_irq(cpu, event_idx);
+        }
+    }
 }
 
 int riscv_pmu_setup_timer(CPURISCVState *env, uint64_t value, uint32_t ctr_idx)

-- 
2.34.1


