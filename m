Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5EC9AC48BC4
	for <qemu-devel@archiver.kernel.org>; Tue, 20 Feb 2024 12:42:53 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rcPRU-0003CI-3m; Tue, 20 Feb 2024 07:41:48 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <maobibo@loongson.cn>)
 id 1rcPRO-0003A9-9i
 for qemu-devel@nongnu.org; Tue, 20 Feb 2024 07:41:42 -0500
Received: from mail.loongson.cn ([114.242.206.163])
 by eggs.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <maobibo@loongson.cn>) id 1rcPRI-0000D8-7k
 for qemu-devel@nongnu.org; Tue, 20 Feb 2024 07:41:42 -0500
Received: from loongson.cn (unknown [10.2.5.213])
 by gateway (Coremail) with SMTP id _____8Axz+v4ndRlNT8PAA--.39974S3;
 Tue, 20 Feb 2024 20:41:28 +0800 (CST)
Received: from localhost.localdomain (unknown [10.2.5.213])
 by localhost.localdomain (Coremail) with SMTP id
 AQAAf8CxPs_3ndRl5MM8AA--.25558S3; 
 Tue, 20 Feb 2024 20:41:27 +0800 (CST)
From: Bibo Mao <maobibo@loongson.cn>
To: Song Gao <gaosong@loongson.cn>, Peter Xu <peterx@redhat.com>,
 Fabiano Rosas <farosas@suse.de>, Thomas Huth <thuth@redhat.com>,
 Laurent Vivier <lvivier@redhat.com>
Cc: qemu-devel@nongnu.org
Subject: [PATCH 1/5] hw/loongarch: Rename LOONGARCH_MACHINE with VIRT_MACHINE.
Date: Tue, 20 Feb 2024 20:41:22 +0800
Message-Id: <20240220124126.1164081-2-maobibo@loongson.cn>
X-Mailer: git-send-email 2.39.3
In-Reply-To: <20240220124126.1164081-1-maobibo@loongson.cn>
References: <20240220124126.1164081-1-maobibo@loongson.cn>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: AQAAf8CxPs_3ndRl5MM8AA--.25558S3
X-CM-SenderInfo: xpdruxter6z05rqj20fqof0/
X-Coremail-Antispam: 1Uk129KBj93XoW3Jw47tr18uFWrtrWDWrWkZrc_yoWxtw4DpF
 WDAF1kZr18Xrn3uwn7G3s8uF18Ar4xCa42van7tr40ka4DuryUGrW8C3yYyF1DA34DJF10
 vwn5Cw47X3WfJrXCm3ZEXasCq-sJn29KB7ZKAUJUUUUU529EdanIXcx71UUUUU7KY7ZEXa
 sCq-sGcSsGvfJ3Ic02F40EFcxC0VAKzVAqx4xG6I80ebIjqfuFe4nvWSU5nxnvy29KBjDU
 0xBIdaVrnRJUUUkFb4IE77IF4wAFF20E14v26r1j6r4UM7CY07I20VC2zVCF04k26cxKx2
 IYs7xG6rWj6s0DM7CIcVAFz4kK6r1Y6r17M28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48v
 e4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Jr0_JF4l84ACjcxK6xIIjxv20xvEc7CjxVAFwI
 0_Jr0_Gr1l84ACjcxK6I8E87Iv67AKxVW8Jr0_Cr1UM28EF7xvwVC2z280aVCY1x0267AK
 xVW8Jr0_Cr1UM2AIxVAIcxkEcVAq07x20xvEncxIr21l57IF6xkI12xvs2x26I8E6xACxx
 1l5I8CrVACY4xI64kE6c02F40Ex7xfMcIj6xIIjxv20xvE14v26r1Y6r17McIj6I8E87Iv
 67AKxVWUJVW8JwAm72CE4IkC6x0Yz7v_Jr0_Gr1lF7xvr2IYc2Ij64vIr41l42xK82IYc2
 Ij64vIr41l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1lx2IqxVAqx4xG67AKxVWUJVWUGwC20s02
 6x8GjcxK67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r126r1DMIIYrxkI7VAKI48JMIIF0x
 vE2Ix0cI8IcVAFwI0_Jr0_JF4lIxAIcVC0I7IYx2IY6xkF7I0E14v26r1j6r4UMIIF0xvE
 42xK8VAvwI8IcIk0rVWUJVWUCwCI42IY6I8E87Iv67AKxVWUJVW8JwCI42IY6I8E87Iv6x
 kF7I0E14v26r1j6r4UYxBIdaVFxhVjvjDU0xZFpf9x07j1WlkUUUUU=
Received-SPF: pass client-ip=114.242.206.163; envelope-from=maobibo@loongson.cn;
 helo=mail.loongson.cn
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, SPF_HELO_NONE=0.001,
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

On LoongArch system, there is only virt machine type now, name
LOONGARCH_MACHINE is confused, rename it with VIRT_MACHINE. Name
about Other real hw boards can be added in future.

Signed-off-by: Bibo Mao <maobibo@loongson.cn>
---
 hw/loongarch/acpi-build.c   |  8 ++++----
 hw/loongarch/virt.c         | 19 +++++++++----------
 include/hw/loongarch/virt.h |  4 ++--
 3 files changed, 15 insertions(+), 16 deletions(-)

diff --git a/hw/loongarch/acpi-build.c b/hw/loongarch/acpi-build.c
index a1c4198741..a2f1d6daf7 100644
--- a/hw/loongarch/acpi-build.c
+++ b/hw/loongarch/acpi-build.c
@@ -167,7 +167,7 @@ build_srat(GArray *table_data, BIOSLinker *linker, MachineState *machine)
     int i, arch_id, node_id;
     uint64_t mem_len, mem_base;
     int nb_numa_nodes = machine->numa_state->num_nodes;
-    LoongArchMachineState *lams = LOONGARCH_MACHINE(machine);
+    LoongArchMachineState *lams = VIRT_MACHINE(machine);
     MachineClass *mc = MACHINE_GET_CLASS(lams);
     const CPUArchIdList *arch_ids = mc->possible_cpu_arch_ids(machine);
     AcpiTable table = { .sig = "SRAT", .rev = 1, .oem_id = lams->oem_id,
@@ -279,7 +279,7 @@ static void
 build_la_ged_aml(Aml *dsdt, MachineState *machine)
 {
     uint32_t event;
-    LoongArchMachineState *lams = LOONGARCH_MACHINE(machine);
+    LoongArchMachineState *lams = VIRT_MACHINE(machine);
 
     build_ged_aml(dsdt, "\\_SB."GED_DEVICE,
                   HOTPLUG_HANDLER(lams->acpi_ged),
@@ -368,7 +368,7 @@ static void
 build_dsdt(GArray *table_data, BIOSLinker *linker, MachineState *machine)
 {
     Aml *dsdt, *scope, *pkg;
-    LoongArchMachineState *lams = LOONGARCH_MACHINE(machine);
+    LoongArchMachineState *lams = VIRT_MACHINE(machine);
     AcpiTable table = { .sig = "DSDT", .rev = 1, .oem_id = lams->oem_id,
                         .oem_table_id = lams->oem_table_id };
 
@@ -398,7 +398,7 @@ build_dsdt(GArray *table_data, BIOSLinker *linker, MachineState *machine)
 
 static void acpi_build(AcpiBuildTables *tables, MachineState *machine)
 {
-    LoongArchMachineState *lams = LOONGARCH_MACHINE(machine);
+    LoongArchMachineState *lams = VIRT_MACHINE(machine);
     GArray *table_offsets;
     AcpiFadtData fadt_data;
     unsigned facs, rsdt, dsdt;
diff --git a/hw/loongarch/virt.c b/hw/loongarch/virt.c
index 0ad7d8c887..02391baadd 100644
--- a/hw/loongarch/virt.c
+++ b/hw/loongarch/virt.c
@@ -774,7 +774,7 @@ static void loongarch_init(MachineState *machine)
     ram_addr_t ram_size = machine->ram_size;
     uint64_t highram_size = 0, phyAddr = 0;
     MemoryRegion *address_space_mem = get_system_memory();
-    LoongArchMachineState *lams = LOONGARCH_MACHINE(machine);
+    LoongArchMachineState *lams = VIRT_MACHINE(machine);
     int nb_numa_nodes = machine->numa_state->num_nodes;
     NodeInfo *numa_info = machine->numa_state->nodes;
     int i;
@@ -941,7 +941,7 @@ bool loongarch_is_acpi_enabled(LoongArchMachineState *lams)
 static void loongarch_get_acpi(Object *obj, Visitor *v, const char *name,
                                void *opaque, Error **errp)
 {
-    LoongArchMachineState *lams = LOONGARCH_MACHINE(obj);
+    LoongArchMachineState *lams = VIRT_MACHINE(obj);
     OnOffAuto acpi = lams->acpi;
 
     visit_type_OnOffAuto(v, name, &acpi, errp);
@@ -950,14 +950,14 @@ static void loongarch_get_acpi(Object *obj, Visitor *v, const char *name,
 static void loongarch_set_acpi(Object *obj, Visitor *v, const char *name,
                                void *opaque, Error **errp)
 {
-    LoongArchMachineState *lams = LOONGARCH_MACHINE(obj);
+    LoongArchMachineState *lams = VIRT_MACHINE(obj);
 
     visit_type_OnOffAuto(v, name, &lams->acpi, errp);
 }
 
 static void loongarch_machine_initfn(Object *obj)
 {
-    LoongArchMachineState *lams = LOONGARCH_MACHINE(obj);
+    LoongArchMachineState *lams = VIRT_MACHINE(obj);
 
     lams->acpi = ON_OFF_AUTO_AUTO;
     lams->oem_id = g_strndup(ACPI_BUILD_APPNAME6, 6);
@@ -989,7 +989,7 @@ static void virt_machine_device_pre_plug(HotplugHandler *hotplug_dev,
 static void virt_mem_unplug_request(HotplugHandler *hotplug_dev,
                                      DeviceState *dev, Error **errp)
 {
-    LoongArchMachineState *lams = LOONGARCH_MACHINE(hotplug_dev);
+    LoongArchMachineState *lams = VIRT_MACHINE(hotplug_dev);
 
     /* the acpi ged is always exist */
     hotplug_handler_unplug_request(HOTPLUG_HANDLER(lams->acpi_ged), dev,
@@ -1007,7 +1007,7 @@ static void virt_machine_device_unplug_request(HotplugHandler *hotplug_dev,
 static void virt_mem_unplug(HotplugHandler *hotplug_dev,
                              DeviceState *dev, Error **errp)
 {
-    LoongArchMachineState *lams = LOONGARCH_MACHINE(hotplug_dev);
+    LoongArchMachineState *lams = VIRT_MACHINE(hotplug_dev);
 
     hotplug_handler_unplug(HOTPLUG_HANDLER(lams->acpi_ged), dev, errp);
     pc_dimm_unplug(PC_DIMM(dev), MACHINE(lams));
@@ -1025,7 +1025,7 @@ static void virt_machine_device_unplug(HotplugHandler *hotplug_dev,
 static void virt_mem_plug(HotplugHandler *hotplug_dev,
                              DeviceState *dev, Error **errp)
 {
-    LoongArchMachineState *lams = LOONGARCH_MACHINE(hotplug_dev);
+    LoongArchMachineState *lams = VIRT_MACHINE(hotplug_dev);
 
     pc_dimm_plug(PC_DIMM(dev), MACHINE(lams));
     hotplug_handler_plug(HOTPLUG_HANDLER(lams->acpi_ged),
@@ -1035,7 +1035,7 @@ static void virt_mem_plug(HotplugHandler *hotplug_dev,
 static void loongarch_machine_device_plug_cb(HotplugHandler *hotplug_dev,
                                         DeviceState *dev, Error **errp)
 {
-    LoongArchMachineState *lams = LOONGARCH_MACHINE(hotplug_dev);
+    LoongArchMachineState *lams = VIRT_MACHINE(hotplug_dev);
     MachineClass *mc = MACHINE_GET_CLASS(lams);
 
     if (device_is_dynamic_sysbus(mc, dev)) {
@@ -1117,7 +1117,6 @@ static void loongarch_class_init(ObjectClass *oc, void *data)
     MachineClass *mc = MACHINE_CLASS(oc);
     HotplugHandlerClass *hc = HOTPLUG_HANDLER_CLASS(oc);
 
-    mc->desc = "Loongson-3A5000 LS7A1000 machine";
     mc->init = loongarch_init;
     mc->default_ram_size = 1 * GiB;
     mc->default_cpu_type = LOONGARCH_CPU_TYPE_NAME("la464");
@@ -1154,7 +1153,7 @@ static void loongarch_class_init(ObjectClass *oc, void *data)
 
 static const TypeInfo loongarch_machine_types[] = {
     {
-        .name           = TYPE_LOONGARCH_MACHINE,
+        .name           = TYPE_VIRT_MACHINE,
         .parent         = TYPE_MACHINE,
         .instance_size  = sizeof(LoongArchMachineState),
         .class_init     = loongarch_class_init,
diff --git a/include/hw/loongarch/virt.h b/include/hw/loongarch/virt.h
index 6ef9a92394..846e83be05 100644
--- a/include/hw/loongarch/virt.h
+++ b/include/hw/loongarch/virt.h
@@ -55,8 +55,8 @@ struct LoongArchMachineState {
     AddressSpace as_iocsr;
 };
 
-#define TYPE_LOONGARCH_MACHINE  MACHINE_TYPE_NAME("virt")
-OBJECT_DECLARE_SIMPLE_TYPE(LoongArchMachineState, LOONGARCH_MACHINE)
+#define TYPE_VIRT_MACHINE  MACHINE_TYPE_NAME("virt")
+OBJECT_DECLARE_SIMPLE_TYPE(LoongArchMachineState, VIRT_MACHINE)
 bool loongarch_is_acpi_enabled(LoongArchMachineState *lams);
 void loongarch_acpi_setup(LoongArchMachineState *lams);
 #endif
-- 
2.39.3


