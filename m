Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 17DDBC4345F
	for <qemu-devel@archiver.kernel.org>; Fri, 19 Apr 2024 18:32:44 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rxt1l-0004em-8F; Fri, 19 Apr 2024 14:32:01 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dorjoychy111@gmail.com>)
 id 1rxt1e-0004cj-6Y
 for qemu-devel@nongnu.org; Fri, 19 Apr 2024 14:31:58 -0400
Received: from mail-pf1-x434.google.com ([2607:f8b0:4864:20::434])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <dorjoychy111@gmail.com>)
 id 1rxt1b-0006vp-Ro
 for qemu-devel@nongnu.org; Fri, 19 Apr 2024 14:31:53 -0400
Received: by mail-pf1-x434.google.com with SMTP id
 d2e1a72fcca58-6eff2be3b33so2276047b3a.2
 for <qemu-devel@nongnu.org>; Fri, 19 Apr 2024 11:31:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1713551505; x=1714156305; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=EYyrvnlUjvt2kEOB2soFLgTGCQVq2lt5b64oZ27QOVo=;
 b=LUMV0i2ZCvH7lBNzf4o9cTjPaufGLfAQvvLJ4WQgQ2Pk9ypwe0UX06gzFw+5tySn3P
 EJVTOvZeFref+5EIa/ch8Jz09fmTZcOQshHCAvD6CM2tY5I4gg62y6p56/QCvpREHdT+
 HojsYkJ7DfC2JpLkouCCaRaTH8B/TXcJWtWEGAyjZfKI2XRZ3UZPFpZ9PzMoDNzakXeD
 V/Weyr/6s9pz5H6DPrqGtYQg8ygcO02cEk9YJPRQX7NVTId12e9IjIFS0tXatNMIsuv+
 8R0zcJYIYFWg/yn1/d9rdFRkv93IbxirL7TB6DBGXbuKnPbwA5esRWBrtJ0vSQQIoKqI
 iHug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1713551505; x=1714156305;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=EYyrvnlUjvt2kEOB2soFLgTGCQVq2lt5b64oZ27QOVo=;
 b=JwCcpsxta44v0OBYPDnUetCmlDFVigbUM6UfElLljWsg3VD7SHNO/GH3AIks806Fmo
 mA3uLIkywC5KkZM9xEC5jGvuoIshtaJdYeC3a1PdoRguEH7weyewmdbNTZA9+Hng/nG6
 aey5nMkXKpiY6afgxw3UFzU6s0kHgMDP1wbnwlbv9T4gzv6x1CMa7cRqwVuZcUS090yz
 NYTXE4L9tzefuN/QGXTiopl5Jw/MgPNk1MT0cEbV130L+SeGHriqjVJOdpAZcJ9GzYSJ
 pLUeNV7RUvZ337OFk8fJcxQwfdqINGiV6k07NN5OL6uqHGO3eoUiB79acvYF5HQl4COM
 DHDQ==
X-Gm-Message-State: AOJu0YzOLbf9YfrSwOj/kovzNVmH49SuAJ1hkJpQ6WXDgUD+Ri5RYqd8
 bmU2HqLBANFnF27yKJgCx0SJY+Bav9B1e/80zyklDIsnShbAbguK99GG4Q==
X-Google-Smtp-Source: AGHT+IFFWRxBMwtIiwv3hvPfP2PqLWy8PiVeNCvAjmeYpLWtHbfE1tGc/HKWyJbtX7lyU2QLt0RZ9A==
X-Received: by 2002:a05:6a00:22c3:b0:6ec:da6c:fc2d with SMTP id
 f3-20020a056a0022c300b006ecda6cfc2dmr3378783pfj.23.1713551504987; 
 Fri, 19 Apr 2024 11:31:44 -0700 (PDT)
Received: from localhost.localdomain ([103.197.153.228])
 by smtp.gmail.com with ESMTPSA id
 r18-20020aa79892000000b006ed0c9751d0sm3641788pfl.98.2024.04.19.11.31.42
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 19 Apr 2024 11:31:44 -0700 (PDT)
From: Dorjoy Chowdhury <dorjoychy111@gmail.com>
To: qemu-devel@nongnu.org
Cc: peter.maydell@linaro.org
Subject: [PATCH] target/arm: fix MPIDR value for ARM CPUs with SMT
Date: Sat, 20 Apr 2024 00:31:35 +0600
Message-Id: <20240419183135.12276-1-dorjoychy111@gmail.com>
X-Mailer: git-send-email 2.39.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::434;
 envelope-from=dorjoychy111@gmail.com; helo=mail-pf1-x434.google.com
X-Spam_score_int: 15
X-Spam_score: 1.5
X-Spam_bar: +
X-Spam_report: (1.5 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1, DKIM_VALID=-0.1,
 DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_ENVFROM_END_DIGIT=0.25,
 FREEMAIL_FROM=0.001, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_SBL_CSS=3.335,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

Some ARM CPUs advertise themselves as SMT by having the MT[24] bit set
to 1 in the MPIDR register. These CPUs have the thread id in Aff0[7:0]
bits, CPU id in Aff1[15:8] bits and cluster id in Aff2[23:16] bits in
MPIDR.

On the other hand, ARM CPUs without SMT have the MT[24] bit set to 0,
CPU id in Aff0[7:0] bits and cluster id in Aff1[15:8] bits in MPIDR.

The mpidr_read_val() function always reported non-SMT i.e., MT=0 style
MPIDR value which means it was wrong for the following CPUs with SMT
supported by QEMU:
    - cortex-a55
    - cortex-a76
    - cortex-a710
    - neoverse-v1
    - neoverse-n1
    - neoverse-n2

Resolves: https://gitlab.com/qemu-project/qemu/-/issues/1608
Signed-off-by: Dorjoy Chowdhury <dorjoychy111@gmail.com>
---
 hw/arm/npcm7xx.c       |  2 +-
 hw/arm/sbsa-ref.c      | 21 ++++++++++++++++-----
 hw/arm/virt.c          | 18 +++++++++++++++---
 target/arm/cpu.c       | 14 ++++++++++++--
 target/arm/cpu.h       |  5 ++++-
 target/arm/helper.c    |  4 ++++
 target/arm/tcg/cpu64.c | 12 ++++++++++++
 7 files changed, 64 insertions(+), 12 deletions(-)

diff --git a/hw/arm/npcm7xx.c b/hw/arm/npcm7xx.c
index cc68b5d8f1..9d5dcf1a3f 100644
--- a/hw/arm/npcm7xx.c
+++ b/hw/arm/npcm7xx.c
@@ -487,7 +487,7 @@ static void npcm7xx_realize(DeviceState *dev, Error **errp)
     /* CPUs */
     for (i = 0; i < nc->num_cpus; i++) {
         object_property_set_int(OBJECT(&s->cpu[i]), "mp-affinity",
-                                arm_build_mp_affinity(i, NPCM7XX_MAX_NUM_CPUS),
+                                arm_build_mp_affinity(ARM_CPU(&s->cpu[i]), i, NPCM7XX_MAX_NUM_CPUS),
                                 &error_abort);
         object_property_set_int(OBJECT(&s->cpu[i]), "reset-cbar",
                                 NPCM7XX_GIC_CPU_IF_ADDR, &error_abort);
diff --git a/hw/arm/sbsa-ref.c b/hw/arm/sbsa-ref.c
index f5709d6c14..dd42788f23 100644
--- a/hw/arm/sbsa-ref.c
+++ b/hw/arm/sbsa-ref.c
@@ -147,10 +147,10 @@ static const int sbsa_ref_irqmap[] = {
     [SBSA_GWDT_WS0] = 16,
 };
 
-static uint64_t sbsa_ref_cpu_mp_affinity(SBSAMachineState *sms, int idx)
+static uint64_t sbsa_ref_cpu_mp_affinity(ARMCPU *cpu, int idx)
 {
     uint8_t clustersz = ARM_DEFAULT_CPUS_PER_CLUSTER;
-    return arm_build_mp_affinity(idx, clustersz);
+    return arm_build_mp_affinity(cpu, idx, clustersz);
 }
 
 static void sbsa_fdt_add_gic_node(SBSAMachineState *sms)
@@ -254,7 +254,7 @@ static void create_fdt(SBSAMachineState *sms)
         char *nodename = g_strdup_printf("/cpus/cpu@%d", cpu);
         ARMCPU *armcpu = ARM_CPU(qemu_get_cpu(cpu));
         CPUState *cs = CPU(armcpu);
-        uint64_t mpidr = sbsa_ref_cpu_mp_affinity(sms, cpu);
+        uint64_t mpidr = sbsa_ref_cpu_mp_affinity(armcpu, cpu);
 
         qemu_fdt_add_subnode(sms->fdt, nodename);
         qemu_fdt_setprop_u64(sms->fdt, nodename, "reg", mpidr);
@@ -816,8 +816,9 @@ static void sbsa_ref_init(MachineState *machine)
 static const CPUArchIdList *sbsa_ref_possible_cpu_arch_ids(MachineState *ms)
 {
     unsigned int max_cpus = ms->smp.max_cpus;
-    SBSAMachineState *sms = SBSA_MACHINE(ms);
     int n;
+    Object *cpuobj;
+    ARMCPU *armcpu;
 
     if (ms->possible_cpus) {
         assert(ms->possible_cpus->len == max_cpus);
@@ -827,13 +828,23 @@ static const CPUArchIdList *sbsa_ref_possible_cpu_arch_ids(MachineState *ms)
     ms->possible_cpus = g_malloc0(sizeof(CPUArchIdList) +
                                   sizeof(CPUArchId) * max_cpus);
     ms->possible_cpus->len = max_cpus;
+
+    /*
+     * Instantiate a temporary CPU object to build mp_affinity
+     * of the possible CPUs.
+     */
+    cpuobj = object_new(ms->cpu_type);
+    armcpu = ARM_CPU(cpuobj);
+
     for (n = 0; n < ms->possible_cpus->len; n++) {
         ms->possible_cpus->cpus[n].type = ms->cpu_type;
         ms->possible_cpus->cpus[n].arch_id =
-            sbsa_ref_cpu_mp_affinity(sms, n);
+            sbsa_ref_cpu_mp_affinity(armcpu, n);
         ms->possible_cpus->cpus[n].props.has_thread_id = true;
         ms->possible_cpus->cpus[n].props.thread_id = n;
     }
+
+    object_unref(cpuobj);
     return ms->possible_cpus;
 }
 
diff --git a/hw/arm/virt.c b/hw/arm/virt.c
index a9a913aead..fe6d13c08f 100644
--- a/hw/arm/virt.c
+++ b/hw/arm/virt.c
@@ -1703,7 +1703,7 @@ void virt_machine_done(Notifier *notifier, void *data)
     virt_build_smbios(vms);
 }
 
-static uint64_t virt_cpu_mp_affinity(VirtMachineState *vms, int idx)
+static uint64_t virt_cpu_mp_affinity(VirtMachineState *vms, ARMCPU *cpu, int idx)
 {
     uint8_t clustersz = ARM_DEFAULT_CPUS_PER_CLUSTER;
     VirtMachineClass *vmc = VIRT_MACHINE_GET_CLASS(vms);
@@ -1723,7 +1723,7 @@ static uint64_t virt_cpu_mp_affinity(VirtMachineState *vms, int idx)
             clustersz = GICV3_TARGETLIST_BITS;
         }
     }
-    return arm_build_mp_affinity(idx, clustersz);
+    return arm_build_mp_affinity(cpu, idx, clustersz);
 }
 
 static inline bool *virt_get_high_memmap_enabled(VirtMachineState *vms,
@@ -2683,6 +2683,8 @@ static const CPUArchIdList *virt_possible_cpu_arch_ids(MachineState *ms)
     unsigned int max_cpus = ms->smp.max_cpus;
     VirtMachineState *vms = VIRT_MACHINE(ms);
     MachineClass *mc = MACHINE_GET_CLASS(vms);
+    Object *cpuobj;
+    ARMCPU *armcpu;
 
     if (ms->possible_cpus) {
         assert(ms->possible_cpus->len == max_cpus);
@@ -2692,10 +2694,18 @@ static const CPUArchIdList *virt_possible_cpu_arch_ids(MachineState *ms)
     ms->possible_cpus = g_malloc0(sizeof(CPUArchIdList) +
                                   sizeof(CPUArchId) * max_cpus);
     ms->possible_cpus->len = max_cpus;
+
+    /*
+     * Instantiate a temporary CPU object to build mp_affinity
+     * of the possible CPUs.
+     */
+    cpuobj = object_new(ms->cpu_type);
+    armcpu = ARM_CPU(cpuobj);
+
     for (n = 0; n < ms->possible_cpus->len; n++) {
         ms->possible_cpus->cpus[n].type = ms->cpu_type;
         ms->possible_cpus->cpus[n].arch_id =
-            virt_cpu_mp_affinity(vms, n);
+            virt_cpu_mp_affinity(vms, armcpu, n);
 
         assert(!mc->smp_props.dies_supported);
         ms->possible_cpus->cpus[n].props.has_socket_id = true;
@@ -2711,6 +2721,8 @@ static const CPUArchIdList *virt_possible_cpu_arch_ids(MachineState *ms)
         ms->possible_cpus->cpus[n].props.thread_id =
             n % ms->smp.threads;
     }
+
+    object_unref(cpuobj);
     return ms->possible_cpus;
 }
 
diff --git a/target/arm/cpu.c b/target/arm/cpu.c
index ab8d007a86..34ee98f5f9 100644
--- a/target/arm/cpu.c
+++ b/target/arm/cpu.c
@@ -1314,8 +1314,18 @@ static void arm_cpu_dump_state(CPUState *cs, FILE *f, int flags)
     }
 }
 
-uint64_t arm_build_mp_affinity(int idx, uint8_t clustersz)
+uint64_t arm_build_mp_affinity(ARMCPU *cpu, int idx, uint8_t clustersz)
 {
+    if (cpu->has_smt) {
+        /*
+         * Right now, the ARM CPUs with SMT supported by QEMU only have
+         * one thread per core. So Aff0 is always 0.
+         */
+        uint32_t Aff2 = idx / clustersz;
+        uint32_t Aff1 = idx % clustersz;
+        uint32_t Aff0 = 0;
+        return (Aff2 << ARM_AFF2_SHIFT) | (Aff1 << ARM_AFF1_SHIFT) | Aff0;
+    }
     uint32_t Aff1 = idx / clustersz;
     uint32_t Aff0 = idx % clustersz;
     return (Aff1 << ARM_AFF1_SHIFT) | Aff0;
@@ -2136,7 +2146,7 @@ static void arm_cpu_realizefn(DeviceState *dev, Error **errp)
      * so these bits always RAZ.
      */
     if (cpu->mp_affinity == ARM64_AFFINITY_INVALID) {
-        cpu->mp_affinity = arm_build_mp_affinity(cs->cpu_index,
+        cpu->mp_affinity = arm_build_mp_affinity(cpu, cs->cpu_index,
                                                  ARM_DEFAULT_CPUS_PER_CLUSTER);
     }
 
diff --git a/target/arm/cpu.h b/target/arm/cpu.h
index bc0c84873f..57343c7e24 100644
--- a/target/arm/cpu.h
+++ b/target/arm/cpu.h
@@ -948,6 +948,9 @@ struct ArchCPU {
     /* Uniprocessor system with MP extensions */
     bool mp_is_up;
 
+    /* Arm cores with SMT support */
+    bool has_smt;
+
     /* True if we tried kvm_arm_host_cpu_features() during CPU instance_init
      * and the probe failed (so we need to report the error in realize)
      */
@@ -1140,7 +1143,7 @@ void arm_cpu_post_init(Object *obj);
     (ARM_AFF0_MASK | ARM_AFF1_MASK | ARM_AFF2_MASK | ARM_AFF3_MASK)
 #define ARM64_AFFINITY_INVALID (~ARM64_AFFINITY_MASK)
 
-uint64_t arm_build_mp_affinity(int idx, uint8_t clustersz);
+uint64_t arm_build_mp_affinity(ARMCPU *cpu, int idx, uint8_t clustersz);
 
 #ifndef CONFIG_USER_ONLY
 extern const VMStateDescription vmstate_arm_cpu;
diff --git a/target/arm/helper.c b/target/arm/helper.c
index a620481d7c..3e09bc950b 100644
--- a/target/arm/helper.c
+++ b/target/arm/helper.c
@@ -4676,6 +4676,10 @@ static uint64_t mpidr_read_val(CPUARMState *env)
             mpidr |= (1u << 30);
         }
     }
+
+    if (cpu->has_smt) {
+        mpidr |= (1U << 24);
+    }
     return mpidr;
 }
 
diff --git a/target/arm/tcg/cpu64.c b/target/arm/tcg/cpu64.c
index 9f7a9f3d2c..8807809842 100644
--- a/target/arm/tcg/cpu64.c
+++ b/target/arm/tcg/cpu64.c
@@ -289,6 +289,8 @@ static void aarch64_a55_initfn(Object *obj)
 
     /* From D5.4 AArch64 PMU register summary */
     cpu->isar.reset_pmcr_el0 = 0x410b3000;
+
+    cpu->has_smt = true;
 }
 
 static void aarch64_a72_initfn(Object *obj)
@@ -413,6 +415,8 @@ static void aarch64_a76_initfn(Object *obj)
 
     /* From D5.1 AArch64 PMU register summary */
     cpu->isar.reset_pmcr_el0 = 0x410b3000;
+
+    cpu->has_smt = true;
 }
 
 static void aarch64_a64fx_initfn(Object *obj)
@@ -652,6 +656,8 @@ static void aarch64_neoverse_n1_initfn(Object *obj)
     /* From D5.1 AArch64 PMU register summary */
     cpu->isar.reset_pmcr_el0 = 0x410c3000;
 
+    cpu->has_smt = true;
+
     define_neoverse_n1_cp_reginfo(cpu);
 }
 
@@ -740,6 +746,8 @@ static void aarch64_neoverse_v1_initfn(Object *obj)
     /* From 5.5.1 AArch64 PMU register summary */
     cpu->isar.reset_pmcr_el0 = 0x41213000;
 
+    cpu->has_smt = true;
+
     define_neoverse_v1_cp_reginfo(cpu);
 
     aarch64_add_pauth_properties(obj);
@@ -958,6 +966,8 @@ static void aarch64_a710_initfn(Object *obj)
     /* FIXME: Not documented -- copied from neoverse-v1 */
     cpu->reset_sctlr = 0x30c50838;
 
+    cpu->has_smt = true;
+
     define_arm_cp_regs(cpu, cortex_a710_cp_reginfo);
 
     aarch64_add_pauth_properties(obj);
@@ -1055,6 +1065,8 @@ static void aarch64_neoverse_n2_initfn(Object *obj)
     /* FIXME: Not documented -- copied from neoverse-v1 */
     cpu->reset_sctlr = 0x30c50838;
 
+    cpu->has_smt = true;
+
     /*
      * The Neoverse N2 has all of the Cortex-A710 IMPDEF registers,
      * and a few more RNG related ones.
-- 
2.39.2


