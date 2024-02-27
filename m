Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 035F7C48BF6
	for <qemu-devel@archiver.kernel.org>; Tue, 27 Feb 2024 02:31:43 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1renF1-0002xv-I5; Mon, 26 Feb 2024 21:30:47 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <maobibo@loongson.cn>)
 id 1renEz-0002xU-BG
 for qemu-devel@nongnu.org; Mon, 26 Feb 2024 21:30:45 -0500
Received: from mail.loongson.cn ([114.242.206.163])
 by eggs.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <maobibo@loongson.cn>) id 1renEw-0002PV-LL
 for qemu-devel@nongnu.org; Mon, 26 Feb 2024 21:30:45 -0500
Received: from loongson.cn (unknown [10.2.5.213])
 by gateway (Coremail) with SMTP id _____8BxTOlLSd1l+88RAA--.35368S3;
 Tue, 27 Feb 2024 10:30:35 +0800 (CST)
Received: from localhost.localdomain (unknown [10.2.5.213])
 by localhost.localdomain (Coremail) with SMTP id
 AQAAf8Cxbs1HSd1lRvhGAA--.54308S3; 
 Tue, 27 Feb 2024 10:30:33 +0800 (CST)
From: Bibo Mao <maobibo@loongson.cn>
To: Song Gao <gaosong@loongson.cn>, Peter Xu <peterx@redhat.com>,
 Fabiano Rosas <farosas@suse.de>, Laurent Vivier <lvivier@redhat.com>,
 Thomas Huth <thuth@redhat.com>
Cc: qemu-devel@nongnu.org
Subject: [PATCH v2 1/5] hw/loongarch: Rename LOONGARCH_MACHINE with
 VIRT_MACHINE.
Date: Tue, 27 Feb 2024 10:30:27 +0800
Message-Id: <20240227023031.3299067-2-maobibo@loongson.cn>
X-Mailer: git-send-email 2.39.3
In-Reply-To: <20240227023031.3299067-1-maobibo@loongson.cn>
References: <20240227023031.3299067-1-maobibo@loongson.cn>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: AQAAf8Cxbs1HSd1lRvhGAA--.54308S3
X-CM-SenderInfo: xpdruxter6z05rqj20fqof0/
X-Coremail-Antispam: 1Uk129KBj93XoWxuw4kZFW7WF18Zw4Dur47ZFc_yoWxKr1fpF
 WDZF1kZr18Xrna93s7G3s8uF10yr4xCa42van7tr40kayDuryUGrW8C390yF1DA34DJF10
 vwn5Cw4xXF1fJrXCm3ZEXasCq-sJn29KB7ZKAUJUUUUU529EdanIXcx71UUUUU7KY7ZEXa
 sCq-sGcSsGvfJ3Ic02F40EFcxC0VAKzVAqx4xG6I80ebIjqfuFe4nvWSU5nxnvy29KBjDU
 0xBIdaVrnRJUUUk0b4IE77IF4wAFF20E14v26r1j6r4UM7CY07I20VC2zVCF04k26cxKx2
 IYs7xG6rWj6s0DM7CIcVAFz4kK6r106r15M28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48v
 e4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_JFI_Gr1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI
 0_Gr0_Cr1l84ACjcxK6I8E87Iv67AKxVWxJVW8Jr1l84ACjcxK6I8E87Iv6xkF7I0E14v2
 6r4j6r4UJwAS0I0E0xvYzxvE52x082IY62kv0487Mc804VCY07AIYIkI8VC2zVCFFI0UMc
 02F40EFcxC0VAKzVAqx4xG6I80ewAv7VC0I7IYx2IY67AKxVWUXVWUAwAv7VC2z280aVAF
 wI0_Jr0_Gr1lOx8S6xCaFVCjc4AY6r1j6r4UM4x0Y48IcxkI7VAKI48JMxAIw28IcxkI7V
 AKI48JMxC20s026xCaFVCjc4AY6r1j6r4UMI8I3I0E5I8CrVAFwI0_Jr0_Jr4lx2IqxVCj
 r7xvwVAFwI0_JrI_JrWlx4CE17CEb7AF67AKxVWUAVWUtwCIc40Y0x0EwIxGrwCI42IY6x
 IIjxv20xvE14v26r1j6r1xMIIF0xvE2Ix0cI8IcVCY1x0267AKxVWUJVW8JwCI42IY6xAI
 w20EY4v20xvaj40_Jr0_JF4lIxAIcVC2z280aVAFwI0_Jr0_Gr1lIxAIcVC2z280aVCY1x
 0267AKxVWUJVW8JbIYCTnIWIevJa73UjIFyTuYvjxU7XTmDUUUU
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
LOONGARCH_MACHINE is confused, rename it with VIRT_MACHINE. Machine name
about Other real hw boards can be added in future.

Signed-off-by: Bibo Mao <maobibo@loongson.cn>
---
 hw/loongarch/acpi-build.c   |  8 ++++----
 hw/loongarch/virt.c         | 19 +++++++++----------
 include/hw/loongarch/virt.h |  4 ++--
 3 files changed, 15 insertions(+), 16 deletions(-)

diff --git a/hw/loongarch/acpi-build.c b/hw/loongarch/acpi-build.c
index e5ab1080af..72322cdb1e 100644
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
@@ -391,7 +391,7 @@ static void
 build_dsdt(GArray *table_data, BIOSLinker *linker, MachineState *machine)
 {
     Aml *dsdt, *scope, *pkg;
-    LoongArchMachineState *lams = LOONGARCH_MACHINE(machine);
+    LoongArchMachineState *lams = VIRT_MACHINE(machine);
     AcpiTable table = { .sig = "DSDT", .rev = 1, .oem_id = lams->oem_id,
                         .oem_table_id = lams->oem_table_id };
 
@@ -421,7 +421,7 @@ build_dsdt(GArray *table_data, BIOSLinker *linker, MachineState *machine)
 
 static void acpi_build(AcpiBuildTables *tables, MachineState *machine)
 {
-    LoongArchMachineState *lams = LOONGARCH_MACHINE(machine);
+    LoongArchMachineState *lams = VIRT_MACHINE(machine);
     GArray *table_offsets;
     AcpiFadtData fadt_data;
     unsigned facs, rsdt, dsdt;
diff --git a/hw/loongarch/virt.c b/hw/loongarch/virt.c
index 1e98d8bda5..0d4ea57e5b 100644
--- a/hw/loongarch/virt.c
+++ b/hw/loongarch/virt.c
@@ -823,7 +823,7 @@ static void loongarch_init(MachineState *machine)
     ram_addr_t ram_size = machine->ram_size;
     uint64_t highram_size = 0, phyAddr = 0;
     MemoryRegion *address_space_mem = get_system_memory();
-    LoongArchMachineState *lams = LOONGARCH_MACHINE(machine);
+    LoongArchMachineState *lams = VIRT_MACHINE(machine);
     int nb_numa_nodes = machine->numa_state->num_nodes;
     NodeInfo *numa_info = machine->numa_state->nodes;
     int i;
@@ -990,7 +990,7 @@ bool loongarch_is_acpi_enabled(LoongArchMachineState *lams)
 static void loongarch_get_acpi(Object *obj, Visitor *v, const char *name,
                                void *opaque, Error **errp)
 {
-    LoongArchMachineState *lams = LOONGARCH_MACHINE(obj);
+    LoongArchMachineState *lams = VIRT_MACHINE(obj);
     OnOffAuto acpi = lams->acpi;
 
     visit_type_OnOffAuto(v, name, &acpi, errp);
@@ -999,14 +999,14 @@ static void loongarch_get_acpi(Object *obj, Visitor *v, const char *name,
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
@@ -1038,7 +1038,7 @@ static void virt_machine_device_pre_plug(HotplugHandler *hotplug_dev,
 static void virt_mem_unplug_request(HotplugHandler *hotplug_dev,
                                      DeviceState *dev, Error **errp)
 {
-    LoongArchMachineState *lams = LOONGARCH_MACHINE(hotplug_dev);
+    LoongArchMachineState *lams = VIRT_MACHINE(hotplug_dev);
 
     /* the acpi ged is always exist */
     hotplug_handler_unplug_request(HOTPLUG_HANDLER(lams->acpi_ged), dev,
@@ -1056,7 +1056,7 @@ static void virt_machine_device_unplug_request(HotplugHandler *hotplug_dev,
 static void virt_mem_unplug(HotplugHandler *hotplug_dev,
                              DeviceState *dev, Error **errp)
 {
-    LoongArchMachineState *lams = LOONGARCH_MACHINE(hotplug_dev);
+    LoongArchMachineState *lams = VIRT_MACHINE(hotplug_dev);
 
     hotplug_handler_unplug(HOTPLUG_HANDLER(lams->acpi_ged), dev, errp);
     pc_dimm_unplug(PC_DIMM(dev), MACHINE(lams));
@@ -1074,7 +1074,7 @@ static void virt_machine_device_unplug(HotplugHandler *hotplug_dev,
 static void virt_mem_plug(HotplugHandler *hotplug_dev,
                              DeviceState *dev, Error **errp)
 {
-    LoongArchMachineState *lams = LOONGARCH_MACHINE(hotplug_dev);
+    LoongArchMachineState *lams = VIRT_MACHINE(hotplug_dev);
 
     pc_dimm_plug(PC_DIMM(dev), MACHINE(lams));
     hotplug_handler_plug(HOTPLUG_HANDLER(lams->acpi_ged),
@@ -1084,7 +1084,7 @@ static void virt_mem_plug(HotplugHandler *hotplug_dev,
 static void loongarch_machine_device_plug_cb(HotplugHandler *hotplug_dev,
                                         DeviceState *dev, Error **errp)
 {
-    LoongArchMachineState *lams = LOONGARCH_MACHINE(hotplug_dev);
+    LoongArchMachineState *lams = VIRT_MACHINE(hotplug_dev);
     MachineClass *mc = MACHINE_GET_CLASS(lams);
 
     if (device_is_dynamic_sysbus(mc, dev)) {
@@ -1166,7 +1166,6 @@ static void loongarch_class_init(ObjectClass *oc, void *data)
     MachineClass *mc = MACHINE_CLASS(oc);
     HotplugHandlerClass *hc = HOTPLUG_HANDLER_CLASS(oc);
 
-    mc->desc = "Loongson-3A5000 LS7A1000 machine";
     mc->init = loongarch_init;
     mc->default_ram_size = 1 * GiB;
     mc->default_cpu_type = LOONGARCH_CPU_TYPE_NAME("la464");
@@ -1203,7 +1202,7 @@ static void loongarch_class_init(ObjectClass *oc, void *data)
 
 static const TypeInfo loongarch_machine_types[] = {
     {
-        .name           = TYPE_LOONGARCH_MACHINE,
+        .name           = TYPE_VIRT_MACHINE,
         .parent         = TYPE_MACHINE,
         .instance_size  = sizeof(LoongArchMachineState),
         .class_init     = loongarch_class_init,
diff --git a/include/hw/loongarch/virt.h b/include/hw/loongarch/virt.h
index 252f7df7f4..d9c7050340 100644
--- a/include/hw/loongarch/virt.h
+++ b/include/hw/loongarch/virt.h
@@ -57,8 +57,8 @@ struct LoongArchMachineState {
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


