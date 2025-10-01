Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1CAB1CCA470
	for <qemu-devel@archiver.kernel.org>; Wed,  1 Oct 2025 01:06:41 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v3lFi-0005Pk-Lj; Tue, 30 Sep 2025 21:03:33 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <salil.mehta@opnsrc.net>)
 id 1v3lFY-0005Me-B1
 for qemu-devel@nongnu.org; Tue, 30 Sep 2025 21:03:20 -0400
Received: from mail-wr1-x42c.google.com ([2a00:1450:4864:20::42c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <salil.mehta@opnsrc.net>)
 id 1v3lEy-00084U-UV
 for qemu-devel@nongnu.org; Tue, 30 Sep 2025 21:03:20 -0400
Received: by mail-wr1-x42c.google.com with SMTP id
 ffacd0b85a97d-3ece0e4c5faso5385960f8f.1
 for <qemu-devel@nongnu.org>; Tue, 30 Sep 2025 18:02:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=opnsrc.net; s=google; t=1759280558; x=1759885358; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=AIp1fTDpYUODV+o3H7vcfIGfQr/6T5pDk40yx4w9U+c=;
 b=QZno1tdt4viyyeratTyfGlK0oYCqKDssUHCNjoA88f80xrm2HA4Y/zXw1mjqFaCIch
 2zg/wBOAU+29e5A8FR/0MpyvkSSHkovTV2POe8xQfWYkLbxG2oY8rdb9D016+aTy9h9m
 ywdhyeeg5BS4utJ3ZmFS69xaiEsOpTCWhXflCqo9f61ViXRg2kvrT+S0DwymhgpcBm/p
 2161sUt8KwwQDCQserGUqN3fWjDtYtMyFBm0WxTc9JU3BpX9W1XQshP7Aq6UeKPlj/Cy
 AXkNozTA6+5Vh2m4t22SDR7Z/EZsnPkzmQntjFmK/te6SuVuJ7lvIXH8oME15nLkTc1B
 GOdQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1759280558; x=1759885358;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=AIp1fTDpYUODV+o3H7vcfIGfQr/6T5pDk40yx4w9U+c=;
 b=BHqnv3S6MCyRoEvC5xBETr/PfXf0uiN1Uc4utFVosnCxZuknWdELWo4dk25Dco6Z16
 PDV65CQZ2oddC99Az4YpIpcmlRNjzsROj1/RaBgtdaoFZIPepu7WZkxV6CQJD3mspACg
 7hPW762rcf+15IrO4ze+pvJjR8EXBjmOAdwVvlPPaOlHXM0wkCzsvmSg07E/tNnHeral
 SIt3hgoZ3s5eXk37FDR0S2mGUBkpsAMCo2lKASHHEn94lqgYL2TgVnCONYLWeAI5gmxS
 ngAMCTHVEbzQvnup2xEIxfKGE7zlCqXQ60WpoWsN6HgI2GwBxs+oWK9iMG2YXnIgJjkt
 SDmg==
X-Gm-Message-State: AOJu0YwmnACFDTnaX8oGJASGiIpsfg9DWoF1kqxkWPwK7cLao+FurEj4
 84cIOPxRTkEvQSPjwBQ3BBhEK7hg8cCP5Qa2tKB6kdYM/9QqyJOMzeclOv7a6piIwTacf4zua1j
 QNFHbsRVRhA==
X-Gm-Gg: ASbGncvNBiqZAEaUWsWR3qwN3thtRVt5B3sdSetjWgWDnAdD17GbyQs/dokalhoy8gf
 bQyb8kHVQydePF29M+xaifwlYVjaYNjEA7PR196nDb4YUU18m8xlS3U4gKIutnt3ugAweR65Nhs
 bSgWL/3tyJ6Dmpl4ckoPCBGVKszMqgIRxu9WstgVYU638xx0NiDvJqRUA+EUFLAoUfnmS0L+QJQ
 Bw2cE1a+0rop2ijgcz95oY7kodVNTJSmiOUpXJrPmf/U8Jn893EQQAdqQiUX9gh9k5JoWZEGyBr
 oiG+zNQgS8r9RE2BszOVBvXCbDWc8/w2srx/8oICYDgbNG9J/8JV/KrfJkKu0tximsMOJGwNIag
 SjgvPq6JZaCFDJPHv9P57vt/WZeAwNqiQlgRkzorU9xP2GG6gdFr8as4KBq8dMXp2ZYIrUOu0My
 VO9++w7PMCN7+YN12JomCU63lVhcv7RJvyb1giEVRix84=
X-Google-Smtp-Source: AGHT+IHFSLI7/UdL6eC6mrr3Se5gLK2/8fPG8GzP/SKGovwybfxzCRv6ENVVmMVAr4Fr3OU7PXKjdQ==
X-Received: by 2002:a05:6000:22c3:b0:3ee:114f:f88f with SMTP id
 ffacd0b85a97d-4255782044bmr1069193f8f.59.1759280558171; 
 Tue, 30 Sep 2025 18:02:38 -0700 (PDT)
Received: from localhost.localdomain ([90.209.204.182])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-40fb985e080sm24587426f8f.24.2025.09.30.18.02.35
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 30 Sep 2025 18:02:37 -0700 (PDT)
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
Subject: [PATCH RFC V6 11/24] hw/arm/acpi: MADT change to size the guest with
 possible vCPUs
Date: Wed,  1 Oct 2025 01:01:14 +0000
Message-Id: <20251001010127.3092631-12-salil.mehta@opnsrc.net>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20251001010127.3092631-1-salil.mehta@opnsrc.net>
References: <20251001010127.3092631-1-salil.mehta@opnsrc.net>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42c;
 envelope-from=salil.mehta@opnsrc.net; helo=mail-wr1-x42c.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_PASS=-0.001,
 T_SPF_HELO_TEMPERROR=0.01 autolearn=unavailable autolearn_force=no
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

When QEMU builds the MADT table, modifications are needed to include information
about possible vCPUs that are exposed as ACPI-disabled (i.e., `_STA.Enabled=0`).
This new information will help the guest kernel pre-size its resources during
boot time. Pre-sizing based on possible vCPUs will facilitate the future
hot-plugging of the currently disabled vCPUs.

Additionally, this change addresses updates to the ACPI MADT GIC CPU interface
flags, as introduced in the UEFI ACPI 6.5 specification [1]. These updates
enable deferred virtual CPU onlining in the guest kernel.

Reference:
[1] 5.2.12.14. GIC CPU Interface (GICC) Structure (Table 5.37 GICC CPU Interface Flags)
    Link: https://uefi.org/specs/ACPI/6.5/05_ACPI_Software_Programming_Model.html#gic-cpu-interface-gicc-structure

Co-developed-by: Keqian Zhu <zhukeqian1@huawei.com>
Signed-off-by: Keqian Zhu <zhukeqian1@huawei.com>
Signed-off-by: Salil Mehta <salil.mehta@huawei.com>
---
 hw/arm/virt-acpi-build.c | 40 ++++++++++++++++++++++++++++++++++------
 hw/core/machine.c        | 14 ++++++++++++++
 include/hw/boards.h      | 20 ++++++++++++++++++++
 3 files changed, 68 insertions(+), 6 deletions(-)

diff --git a/hw/arm/virt-acpi-build.c b/hw/arm/virt-acpi-build.c
index b01fc4f8ef..7c24dd6369 100644
--- a/hw/arm/virt-acpi-build.c
+++ b/hw/arm/virt-acpi-build.c
@@ -760,6 +760,32 @@ static void build_append_gicr(GArray *table_data, uint64_t base, uint32_t size)
     build_append_int_noprefix(table_data, size, 4); /* Discovery Range Length */
 }
 
+static uint32_t virt_acpi_get_gicc_flags(CPUState *cpu)
+{
+    MachineClass *mc = MACHINE_GET_CLASS(qdev_get_machine());
+    const uint32_t GICC_FLAG_ENABLED = BIT(0);
+    const uint32_t GICC_FLAG_ONLINE_CAPABLE = BIT(3);
+
+    /* ARM architecture does not support vCPU hotplug yet */
+    if (!cpu) {
+        return 0;
+    }
+
+    /*
+     * If the machine does not support online-capable CPUs, report the GICC as
+     * 'enabled' only.
+     */
+    if (!mc->has_online_capable_cpus) {
+        return GICC_FLAG_ENABLED;
+    }
+
+    /*
+     * ACPI 6.5, 5.2.12.14 (GICC): mark the boot CPU 'enabled' and all others
+     * 'online-capable'.
+     */
+    return (cpu == first_cpu) ? GICC_FLAG_ENABLED : GICC_FLAG_ONLINE_CAPABLE;
+}
+
 static void
 build_madt(GArray *table_data, BIOSLinker *linker, VirtMachineState *vms)
 {
@@ -785,12 +811,14 @@ build_madt(GArray *table_data, BIOSLinker *linker, VirtMachineState *vms)
     build_append_int_noprefix(table_data, vms->gic_version, 1);
     build_append_int_noprefix(table_data, 0, 3);   /* Reserved */
 
-    for (i = 0; i < MACHINE(vms)->smp.cpus; i++) {
-        ARMCPU *armcpu = ARM_CPU(qemu_get_cpu(i));
+    for (i = 0; i < MACHINE(vms)->smp.max_cpus; i++) {
+        CPUState *cpu = machine_get_possible_cpu(i);
         uint64_t physical_base_address = 0, gich = 0, gicv = 0;
         uint32_t vgic_interrupt = vms->virt ? ARCH_GIC_MAINT_IRQ : 0;
-        uint32_t pmu_interrupt = arm_feature(&armcpu->env, ARM_FEATURE_PMU) ?
-                                             VIRTUAL_PMU_IRQ : 0;
+        uint32_t pmu_interrupt = vms->pmu ? VIRTUAL_PMU_IRQ : 0;
+        CPUArchId *archid = machine_get_possible_cpu_arch_id(i);
+        uint32_t flags = virt_acpi_get_gicc_flags(cpu);
+        uint64_t mpidr = archid->arch_id;
 
         if (vms->gic_version == VIRT_GIC_VERSION_2) {
             physical_base_address = memmap[VIRT_GIC_CPU].base;
@@ -805,7 +833,7 @@ build_madt(GArray *table_data, BIOSLinker *linker, VirtMachineState *vms)
         build_append_int_noprefix(table_data, i, 4);    /* GIC ID */
         build_append_int_noprefix(table_data, i, 4);    /* ACPI Processor UID */
         /* Flags */
-        build_append_int_noprefix(table_data, 1, 4);    /* Enabled */
+        build_append_int_noprefix(table_data, flags, 4);
         /* Parking Protocol Version */
         build_append_int_noprefix(table_data, 0, 4);
         /* Performance Interrupt GSIV */
@@ -819,7 +847,7 @@ build_madt(GArray *table_data, BIOSLinker *linker, VirtMachineState *vms)
         build_append_int_noprefix(table_data, vgic_interrupt, 4);
         build_append_int_noprefix(table_data, 0, 8);    /* GICR Base Address*/
         /* MPIDR */
-        build_append_int_noprefix(table_data, arm_cpu_mp_affinity(armcpu), 8);
+        build_append_int_noprefix(table_data, mpidr, 8);
         /* Processor Power Efficiency Class */
         build_append_int_noprefix(table_data, 0, 1);
         /* Reserved */
diff --git a/hw/core/machine.c b/hw/core/machine.c
index 69d5632464..65388d859a 100644
--- a/hw/core/machine.c
+++ b/hw/core/machine.c
@@ -1383,6 +1383,20 @@ CPUState *machine_get_possible_cpu(int64_t cpu_index)
     return NULL;
 }
 
+CPUArchId *machine_get_possible_cpu_arch_id(int64_t cpu_index)
+{
+    MachineState *ms = MACHINE(qdev_get_machine());
+    CPUArchIdList *possible_cpus = ms->possible_cpus;
+
+    for (int i = 0; i < possible_cpus->len; i++) {
+        if (possible_cpus->cpus[i].cpu &&
+            possible_cpus->cpus[i].cpu->cpu_index == cpu_index) {
+            return &possible_cpus->cpus[i];
+        }
+    }
+    return NULL;
+}
+
 static char *cpu_slot_to_string(const CPUArchId *cpu)
 {
     GString *s = g_string_new(NULL);
diff --git a/include/hw/boards.h b/include/hw/boards.h
index 3ff77a8b3a..fe51ca58bf 100644
--- a/include/hw/boards.h
+++ b/include/hw/boards.h
@@ -461,6 +461,26 @@ struct MachineState {
     bool acpi_spcr_enabled;
 };
 
+/*
+ * machine_get_possible_cpu_arch_id:
+ * @cpu_index: logical cpu_index to search for
+ *
+ * Return a pointer to the CPUArchId entry matching the given @cpu_index
+ * in the current machine's MachineState. The possible_cpus array holds
+ * the full set of CPUs that the machine could support, including those
+ * that may be created as disabled or taken offline.
+ *
+ * The slot index in ms->possible_cpus[] is always sequential, but the
+ * logical cpu_index values are assigned by QEMU and may or may not be
+ * sequential depending on the implementation of a particular machine.
+ * Direct indexing by cpu_index is therefore unsafe in general. This
+ * helper performs a linear search of the possible_cpus array to find
+ * the matching entry.
+ *
+ * Returns: pointer to the matching CPUArchId, or NULL if not found.
+ */
+CPUArchId *machine_get_possible_cpu_arch_id(int64_t cpu_index);
+
 /*
  * The macros which follow are intended to facilitate the
  * definition of versioned machine types, using a somewhat
-- 
2.34.1


