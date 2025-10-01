Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C7B4CCAC5B8
	for <qemu-devel@archiver.kernel.org>; Wed,  1 Oct 2025 01:15:54 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v3lFR-0005Kv-Ge; Tue, 30 Sep 2025 21:03:13 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <salil.mehta@opnsrc.net>)
 id 1v3lFM-0005JI-D9
 for qemu-devel@nongnu.org; Tue, 30 Sep 2025 21:03:08 -0400
Received: from mail-wr1-x42e.google.com ([2a00:1450:4864:20::42e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <salil.mehta@opnsrc.net>)
 id 1v3lEv-00083i-CR
 for qemu-devel@nongnu.org; Tue, 30 Sep 2025 21:03:07 -0400
Received: by mail-wr1-x42e.google.com with SMTP id
 ffacd0b85a97d-3f44000626bso3995492f8f.3
 for <qemu-devel@nongnu.org>; Tue, 30 Sep 2025 18:02:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=opnsrc.net; s=google; t=1759280556; x=1759885356; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=a+LKVy+uEs1gyTpMUsvOiaFbfXh40S7aK551rrhdKmI=;
 b=hbhbNi2PG29T2NPRYvevo83wjbDO1Hz663MrMOE9MausRRdXvMNWrW+PySIhEeMybs
 EpeFLu9g0GpZPQtyn0WcM0WDkwu+3II8ecFyq9rKnJqxPdDacVFAruiqLqFDIaEfhA9N
 ITy1udYdaP0k6BaRf8puJHuWGUwryvcRUOtjskcR3RbaFJ0T49/qr04geZ4OGd+1/Bj3
 /uRjU//bkpwUoBZAP+hQvwWnVsCmSIhQXIuoGi/3m5RDm1u/7wpbeaKPo/+BoKsUMTtb
 dZ1TqyWA6hg5xIAiZdOxVj1oM8mYEAr1rEZPo3yUPD5k7glkB4kLxxZ5zNW/iABu1BcU
 SGmQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1759280556; x=1759885356;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=a+LKVy+uEs1gyTpMUsvOiaFbfXh40S7aK551rrhdKmI=;
 b=NtekZKZFa3cNMo0kDic8jmZbvVd3LapW/rLqzoVVaQfjnnlsnFZv/jrz+rKmHqixH9
 XwyB+RSekYxRmYeKLMTkg1WXGVQ+T28sGPTigsim6VyBIcIyGwTL8n08ztfNgNkcdZWV
 ereayy9yL7mqaKEcBTH9P4UzdEl/apwYnKGBwIgvxQJJq4BwtHr7zb1tFpiE/HWMPcwo
 MRj1XKR6rjGmc/BTSTDGRsO3n6+n0Fg034McwV0x/RcbDSeml8gJSmSfwsVLnOufWOcb
 i6SbB4z3W0HGSOSFxFTe0WtjsV08tjZkfjEuluKx3eHREqwyi3+2xpAGOMJQVoMDh0m2
 U3Aw==
X-Gm-Message-State: AOJu0YzIBs2NpyEB7UkdlShT1/Gty2A5rifDW9llNM19MCajSWwK6/hG
 hsugMpDn5P9u3VJIa7q68FHttaehZCioQvS/cedm/tsl9fwNkkCUiqjtJDuPhR4SGWYjRNSv/g/
 e4iniT4RslA==
X-Gm-Gg: ASbGncsLvOBLor/6ZfcfPRfF0fOUfqoNx5xTUyqhcyGPmYjyiB7FMJtkqwYu/NACRiv
 WzmXm0ey1lCDeGF+nMOmm0BaeJGqpdshGDS+M6FBSs/VS5kTYiB3zmc6Z62neJP3KiEBz/13SvK
 Ehiob034fKjRDu6i0o0trb0UeaqEMFyKGgB4FpT5LpFTCn7uqxV5QSDq3aiKarqPv4KrudyOYqE
 EmbNeAZ8DjmEXzwDeB/vdGrU4lFkwTyT0CbivAS5bzIbGUjI6dVFresuiARHeXhmg0GZLXO8thp
 lxskY1zTyGm9QPK0JOQS1FIMe1WtcBtkl5fXT1EitkK2dJW4sDSu4lpZtqToTDv0lvuPxBCUUuU
 dD+Yorkv1VpMg10rSe/LN1KNiDVbf12l3xAwfPCwSO+WetD4g6rdKxqPxA8fWVboPbNJ/Pqol7g
 BszgMB6USTtwb4PqJz0MrkLZ6hRPetBA5KgUKiSzeKhc0=
X-Google-Smtp-Source: AGHT+IGIOt/MFONJUAOMgOm5H0GxVTM3YTOfkE8m8l8GQdsR9nUtBneNaBYLZrxSvSmST42T3XP8Aw==
X-Received: by 2002:a05:6000:430a:b0:3eb:f3de:1a87 with SMTP id
 ffacd0b85a97d-42557820cbdmr1157560f8f.56.1759280555752; 
 Tue, 30 Sep 2025 18:02:35 -0700 (PDT)
Received: from localhost.localdomain ([90.209.204.182])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-40fb985e080sm24587426f8f.24.2025.09.30.18.02.34
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 30 Sep 2025 18:02:35 -0700 (PDT)
From: salil.mehta@opnsrc.net
To: qemu-devel@nongnu.org,
	qemu-arm@nongnu.org,
	mst@redhat.com
Cc: salil.mehta@huawei.com, maz@kernel.org, jean-philippe@linaro.org,
 jonathan.cameron@huawei.com, lpieralisi@kernel.org,
 peter.maydell@linaro.org, richard.henderson@linaro.org,
 imammedo@redhat.com, armbru@redhat.com, andrew.jones@linux.dev,
 david@redhat.com, philmd@linaro.org, eric.auger@redhat.com,
 will@kernel.org, ardb@kernel.org, oliver.upton@linux.dev,
 pbonzini@redhat.com, gshan@redhat.com, rafael@kernel.org,
 borntraeger@linux.ibm.com, alex.bennee@linaro.org,
 gustavo.romero@linaro.org, npiggin@gmail.com, harshpb@linux.ibm.com,
 linux@armlinux.org.uk, darren@os.amperecomputing.com,
 ilkka@os.amperecomputing.com, vishnu@os.amperecomputing.com,
 gankulkarni@os.amperecomputing.com, karl.heubaum@oracle.com,
 miguel.luis@oracle.com, salil.mehta@opnsrc.net, zhukeqian1@huawei.com,
 wangxiongfeng2@huawei.com, wangyanan55@huawei.com, wangzhou1@hisilicon.com,
 linuxarm@huawei.com, jiakernel2@gmail.com, maobibo@loongson.cn,
 lixianglai@loongson.cn, shahuang@redhat.com, zhao1.liu@intel.com
Subject: [PATCH RFC V6 10/24] arm/virt: Init PMU at host for all present vCPUs
Date: Wed,  1 Oct 2025 01:01:13 +0000
Message-Id: <20251001010127.3092631-11-salil.mehta@opnsrc.net>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20251001010127.3092631-1-salil.mehta@opnsrc.net>
References: <20251001010127.3092631-1-salil.mehta@opnsrc.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42e;
 envelope-from=salil.mehta@opnsrc.net; helo=mail-wr1-x42e.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 T_SPF_TEMPERROR=0.01 autolearn=ham autolearn_force=no
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

From: Salil Mehta <salil.mehta@huawei.com>

ARM architecture requires that all CPUs which form part of the VM must
expose identical feature sets and consistent system components at creation
time. This includes the Performance Monitoring Unit (PMU). If only the boot
CPUs had their PMU state initialized, the remaining CPUs defined by
`smp.disabled_cpus` would not match this architectural requirement, leading
to inconsistencies and guest misbehavior.

To comply with this constraint, PMU initialization must cover the entire set
of present vCPUs:

    present = smp.cpus + smp.disabled_cpus

CPUs outside this set (`smp.max_cpus - present`) are not considered part of
the machine at creation and are therefore not initialized.

Co-developed-by: Keqian Zhu <zhukeqian1@huawei.com>
Signed-off-by: Keqian Zhu <zhukeqian1@huawei.com>
Signed-off-by: Salil Mehta <salil.mehta@huawei.com>
---
 hw/arm/virt.c         | 13 +++++++---
 include/hw/arm/virt.h |  1 +
 include/hw/core/cpu.h | 57 +++++++++++++++++++++++++++++++++++++++++++
 3 files changed, 67 insertions(+), 4 deletions(-)

diff --git a/hw/arm/virt.c b/hw/arm/virt.c
index ee09aa19bd..3980f553db 100644
--- a/hw/arm/virt.c
+++ b/hw/arm/virt.c
@@ -2087,12 +2087,13 @@ static void finalize_gic_version(VirtMachineState *vms)
 static void virt_post_cpus_gic_realized(VirtMachineState *vms,
                                         MemoryRegion *sysmem)
 {
+    CPUArchIdList *possible_cpus = vms->parent.possible_cpus;
     int max_cpus = MACHINE(vms)->smp.max_cpus;
-    bool aarch64, pmu, steal_time;
+    bool aarch64, steal_time;
     CPUState *cpu;
 
     aarch64 = object_property_get_bool(OBJECT(first_cpu), "aarch64", NULL);
-    pmu = object_property_get_bool(OBJECT(first_cpu), "pmu", NULL);
+    vms->pmu = object_property_get_bool(OBJECT(first_cpu), "pmu", NULL);
     steal_time = object_property_get_bool(OBJECT(first_cpu),
                                           "kvm-steal-time", NULL);
 
@@ -2123,8 +2124,12 @@ static void virt_post_cpus_gic_realized(VirtMachineState *vms,
             exit(1);
         }
 
-        CPU_FOREACH(cpu) {
-            if (pmu) {
+        CPU_FOREACH_POSSIBLE(cpu, possible_cpus) {
+            if (!cpu) {
+                continue;
+            }
+
+            if (vms->pmu) {
                 assert(arm_feature(&ARM_CPU(cpu)->env, ARM_FEATURE_PMU));
                 if (kvm_irqchip_in_kernel()) {
                     kvm_arm_pmu_set_irq(ARM_CPU(cpu), VIRTUAL_PMU_IRQ);
diff --git a/include/hw/arm/virt.h b/include/hw/arm/virt.h
index ace4154cc6..02cc311452 100644
--- a/include/hw/arm/virt.h
+++ b/include/hw/arm/virt.h
@@ -154,6 +154,7 @@ struct VirtMachineState {
     bool mte;
     bool dtb_randomness;
     bool second_ns_uart_present;
+    bool pmu;
     OnOffAuto acpi;
     VirtGICType gic_version;
     VirtIOMMUType iommu;
diff --git a/include/hw/core/cpu.h b/include/hw/core/cpu.h
index 5eaf41a566..2ee202a8a5 100644
--- a/include/hw/core/cpu.h
+++ b/include/hw/core/cpu.h
@@ -602,6 +602,63 @@ extern CPUTailQ cpus_queue;
 #define CPU_FOREACH_SAFE(cpu, next_cpu) \
     QTAILQ_FOREACH_SAFE_RCU(cpu, &cpus_queue, node, next_cpu)
 
+
+/**
+ * CPU_FOREACH_POSSIBLE(cpu_, archid_list_)
+ *
+ * Iterate over all entries in a CPUArchIdList, assigning each entry’s
+ * CPUState* to @cpu_. This hides the loop index and reads like a normal
+ * C for-loop.
+ *
+ * A CPUArchIdList represents the set of *possible* CPUs for a machine.
+ * Each entry contains:
+ *   - @cpu:        CPUState pointer, or NULL if not realized yet
+ *   - @arch_id:    architecture-specific identifier (e.g. MPIDR)
+ *   - @vcpus_count: number of vCPUs represented (usually 1)
+ *
+ * The list models *possible* CPUs: it includes (a) currently plugged vCPUs
+ * made available through hotplug, (b) present (and perhaps visible to OSPM)
+ * but kept ACPI-disabled vCPUs, and (c) reserved slots for CPUs that may be
+ * created in the future. This supports co-existence of hotpluggable and
+ * admin-disabled vCPUs if architectures permit.
+ *
+ * Example:
+ *
+ *   CPUArchIdList *alist = machine_possible_cpus(ms);
+ *   CPUState *cpu;
+ *
+ *   CPU_FOREACH_POSSIBLE(cpu, alist) {
+ *       if (!cpu) {
+ *           continue; // reserved slot for hotplug case
+ *       }
+ *
+ *       < Do Something >
+ *   }
+ *
+ * Expanded equivalent:
+ *
+ *   for (int __cpu_idx = 0; alist && __cpu_idx < alist->len; __cpu_idx++) {
+ *       if ((cpu = alist->cpus[__cpu_idx].cpu, 1)) {
+ *           if (!cpu) {
+ *               continue;
+ *           }
+ *
+ *           < Do Something >
+ *       }
+ *   }
+ *
+ * Notes:
+ *   - Callers must check @cpu for NULL when filtering unplugged CPUs.
+ *   - Mirrors the style of CPU_FOREACH(), but iterates all *possible* CPUs
+ *     (plugged, ACPI-disabled, and reserved slots) rather than only present
+ *     and enabled vCPUs.
+ */
+#define CPU_FOREACH_POSSIBLE(cpu_, archid_list_) \
+    for (int __cpu_idx = 0; \
+         (archid_list_) && __cpu_idx < (archid_list_)->len; \
+         __cpu_idx++) \
+        if (((cpu_) = (archid_list_)->cpus[__cpu_idx].cpu, 1))
+
 extern __thread CPUState *current_cpu;
 
 /**
-- 
2.34.1


