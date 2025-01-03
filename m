Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5D35CE7718F
	for <qemu-devel@archiver.kernel.org>; Fri,  3 Jan 2025 06:46:30 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tTbR4-0003z3-So; Fri, 03 Jan 2025 01:45:31 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <maobibo@loongson.cn>)
 id 1tTbR1-0003yO-Fe
 for qemu-devel@nongnu.org; Fri, 03 Jan 2025 01:45:27 -0500
Received: from mail.loongson.cn ([114.242.206.163])
 by eggs.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <maobibo@loongson.cn>) id 1tTbQy-0004l2-Nv
 for qemu-devel@nongnu.org; Fri, 03 Jan 2025 01:45:27 -0500
Received: from loongson.cn (unknown [10.2.5.213])
 by gateway (Coremail) with SMTP id _____8Bx3658h3dnI4RdAA--.13196S3;
 Fri, 03 Jan 2025 14:45:16 +0800 (CST)
Received: from localhost.localdomain (unknown [10.2.5.213])
 by front1 (Coremail) with SMTP id qMiowMCx78d6h3dngDMSAA--.19342S2;
 Fri, 03 Jan 2025 14:45:14 +0800 (CST)
From: Bibo Mao <maobibo@loongson.cn>
To: Song Gao <gaosong@loongson.cn>
Cc: Jiaxun Yang <jiaxun.yang@flygoat.com>,
	qemu-devel@nongnu.org
Subject: [PATCH] hw/loongarch/virt: Checkpatch cleanup
Date: Fri,  3 Jan 2025 14:45:14 +0800
Message-Id: <20250103064514.2660438-1-maobibo@loongson.cn>
X-Mailer: git-send-email 2.39.3
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: qMiowMCx78d6h3dngDMSAA--.19342S2
X-CM-SenderInfo: xpdruxter6z05rqj20fqof0/
X-Coremail-Antispam: 1Uk129KBjDUn29KB7ZKAUJUUUUU529EdanIXcx71UUUUU7KY7
 ZEXasCq-sGcSsGvfJ3UbIjqfuFe4nvWSU5nxnvy29KBjDU0xBIdaVrnUUvcSsGvfC2Kfnx
 nUUI43ZEXa7xR_UUUUUUUUU==
Received-SPF: pass client-ip=114.242.206.163; envelope-from=maobibo@loongson.cn;
 helo=mail.loongson.cn
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

Code cleanup with directory hw/loongarch/, removing errors from
command "scripts/checkpatch.pl hw/loongarch/*"

Signed-off-by: Bibo Mao <maobibo@loongson.cn>
---
 hw/loongarch/acpi-build.c |  3 ++-
 hw/loongarch/boot.c       |  4 ++--
 hw/loongarch/virt.c       | 10 ++++++----
 3 files changed, 10 insertions(+), 7 deletions(-)

diff --git a/hw/loongarch/acpi-build.c b/hw/loongarch/acpi-build.c
index 9eb5fb68bf..fdd62acf7e 100644
--- a/hw/loongarch/acpi-build.c
+++ b/hw/loongarch/acpi-build.c
@@ -456,8 +456,9 @@ build_dsdt(GArray *table_data, BIOSLinker *linker, MachineState *machine)
 
     acpi_table_begin(&table, table_data);
     dsdt = init_aml_allocator();
-    for (i = 0; i < VIRT_UART_COUNT; i++)
+    for (i = 0; i < VIRT_UART_COUNT; i++) {
         build_uart_device_aml(dsdt, i);
+    }
     build_pci_device_aml(dsdt, lvms);
     build_la_ged_aml(dsdt, machine);
     build_flash_aml(dsdt, lvms);
diff --git a/hw/loongarch/boot.c b/hw/loongarch/boot.c
index 48154cdce6..daf582c8a3 100644
--- a/hw/loongarch/boot.c
+++ b/hw/loongarch/boot.c
@@ -223,7 +223,7 @@ static void reset_load_elf(void *opaque)
 
     cpu_reset(CPU(cpu));
     if (env->load_elf) {
-	if (cpu == LOONGARCH_CPU(first_cpu)) {
+        if (cpu == LOONGARCH_CPU(first_cpu)) {
             env->gpr[4] = env->boot_info->a0;
             env->gpr[5] = env->boot_info->a1;
             env->gpr[6] = env->boot_info->a2;
@@ -285,7 +285,7 @@ static void loongarch_direct_kernel_boot(struct loongarch_boot_info *info)
     if (info->kernel_filename) {
         kernel_addr = load_kernel_info(info);
     } else {
-        if(!qtest_enabled()) {
+        if (!qtest_enabled()) {
             warn_report("No kernel provided, booting from flash drive.");
         }
     }
diff --git a/hw/loongarch/virt.c b/hw/loongarch/virt.c
index 99594a13a0..62ceacb930 100644
--- a/hw/loongarch/virt.c
+++ b/hw/loongarch/virt.c
@@ -331,8 +331,9 @@ static void fdt_add_uart_node(LoongArchVirtMachineState *lvms,
     qemu_fdt_setprop_string(ms->fdt, nodename, "compatible", "ns16550a");
     qemu_fdt_setprop_cells(ms->fdt, nodename, "reg", 0x0, base, 0x0, size);
     qemu_fdt_setprop_cell(ms->fdt, nodename, "clock-frequency", 100000000);
-    if (chosen)
+    if (chosen) {
         qemu_fdt_setprop_string(ms->fdt, "/chosen", "stdout-path", nodename);
+    }
     qemu_fdt_setprop_cells(ms->fdt, nodename, "interrupts", irq, 0x4);
     qemu_fdt_setprop_cell(ms->fdt, nodename, "interrupt-parent",
                           *pch_pic_phandle);
@@ -452,7 +453,7 @@ static void fdt_add_pcie_irq_map_node(const LoongArchVirtMachineState *lvms,
 {
     int pin, dev;
     uint32_t irq_map_stride = 0;
-    uint32_t full_irq_map[GPEX_NUM_IRQS *GPEX_NUM_IRQS * 10] = {};
+    uint32_t full_irq_map[GPEX_NUM_IRQS * GPEX_NUM_IRQS * 10] = {};
     uint32_t *irq_map = full_irq_map;
     const MachineState *ms = MACHINE(lvms);
 
@@ -815,7 +816,7 @@ static void virt_devices_init(DeviceState *pch_pic,
      * Create uart fdt node in reverse order so that they appear
      * in the finished device tree lowest address first
      */
-    for (i = VIRT_UART_COUNT; i --> 0;) {
+    for (i = VIRT_UART_COUNT; i-- > 0;) {
         hwaddr base = VIRT_UART_BASE + i * VIRT_UART_SIZE;
         int irq = VIRT_UART_IRQ + i - VIRT_GSI_BASE;
         serial_mm_init(get_system_memory(), base, 0,
@@ -1176,8 +1177,9 @@ static void fw_cfg_add_memory(MachineState *ms)
         size = ram_size - numa_info[0].node_mem;
     }
 
-   if (size)
+    if (size) {
         memmap_add_entry(base, size, 1);
+    }
 }
 
 static void virt_init(MachineState *machine)

base-commit: 2b7a80e07a29074530a0ebc8005a418ee07b1faf
-- 
2.39.3


