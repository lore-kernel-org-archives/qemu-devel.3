Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1BF4CCD4F35
	for <qemu-devel@archiver.kernel.org>; Thu, 13 Nov 2025 01:31:07 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vJMAo-0006XH-B3; Wed, 12 Nov 2025 20:30:56 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <liu.xuemei1@zte.com.cn>)
 id 1vJMAX-0006PU-89; Wed, 12 Nov 2025 20:30:39 -0500
Received: from mxhk.zte.com.cn ([160.30.148.34])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <liu.xuemei1@zte.com.cn>)
 id 1vJMAV-000099-6J; Wed, 12 Nov 2025 20:30:36 -0500
Received: from mse-fl2.zte.com.cn (unknown [10.5.228.133])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mxhk.zte.com.cn (FangMail) with ESMTPS id 4d6N4l4X9lz5PM38;
 Thu, 13 Nov 2025 09:30:31 +0800 (CST)
Received: from xaxapp02.zte.com.cn ([10.88.97.241])
 by mse-fl2.zte.com.cn with SMTP id 5AD1ULIb026817;
 Thu, 13 Nov 2025 09:30:21 +0800 (+08)
 (envelope-from liu.xuemei1@zte.com.cn)
Received: from mapi (xaxapp05[null]) by mapi (Zmail) with MAPI id mid32;
 Thu, 13 Nov 2025 09:30:22 +0800 (CST)
Date: Thu, 13 Nov 2025 09:30:22 +0800 (CST)
X-Zmail-TransId: 2afc691534aee24-83171
X-Mailer: Zmail v1.0
Message-ID: <20251113093022673gxIvC2wmdHDBY2Sq0_AUm@zte.com.cn>
In-Reply-To: <2025111309270952219AjKpVEnbJXB7fcGTE4g@zte.com.cn>
References: 2025111309270952219AjKpVEnbJXB7fcGTE4g@zte.com.cn
Mime-Version: 1.0
From: <liu.xuemei1@zte.com.cn>
To: <imammedo@redhat.com>, <alistair.francis@wdc.com>,
 <dbarboza@ventanamicro.com>, <sunilvl@ventanamicro.com>,
 <anisinha@redhat.com>
Cc: <pbonzini@redhat.com>, <palmer@dabbelt.com>, <liwei1518@gmail.com>,
 <zhiwei_liu@linux.alibaba.com>, <mst@redhat.com>,
 <qemu-devel@nongnu.org>, <qemu-riscv@nongnu.org>, <liu.xuemei1@zte.com.cn>
Subject: =?UTF-8?B?W1BBVENIIHY0IFJFU0VORCAxLzJdIGh3L3Jpc2N2L3ZpcnQ6IEFkZCBhY3BpIGdlZCBhbmQgcG93ZXJkb3duCgogc3VwcG9ydA==?=
Content-Type: text/plain;
	charset="UTF-8"
X-MAIL: mse-fl2.zte.com.cn 5AD1ULIb026817
X-TLS: YES
X-SPF-DOMAIN: zte.com.cn
X-ENVELOPE-SENDER: liu.xuemei1@zte.com.cn
X-SPF: None
X-SOURCE-IP: 10.5.228.133 unknown Thu, 13 Nov 2025 09:30:31 +0800
X-Fangmail-Anti-Spam-Filtered: true
X-Fangmail-MID-QID: 691534B7.001/4d6N4l4X9lz5PM38
Received-SPF: pass client-ip=160.30.148.34;
 envelope-from=liu.xuemei1@zte.com.cn; helo=mxhk.zte.com.cn
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, CTE_8BIT_MISMATCH=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 UNPARSEABLE_RELAY=0.001 autolearn=ham autolearn_force=no
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

From: Xuemei Liu <liu.xuemei1@zte.com.cn>

This adds powerdown support by implementing the ACPI GED.

Co-authored-by: Björn Töpel <bjorn@rivosinc.com>
Signed-off-by: Xuemei Liu <liu.xuemei1@zte.com.cn>
---
 hw/riscv/Kconfig                            |  1 +
 hw/riscv/virt-acpi-build.c                  | 10 ++++++
 hw/riscv/virt.c                             | 35 +++++++++++++++++++++
 include/hw/riscv/virt.h                     |  4 +++
 tests/qtest/bios-tables-test-allowed-diff.h |  1 +
 5 files changed, 51 insertions(+)

diff --git a/hw/riscv/Kconfig b/hw/riscv/Kconfig
index fc9c35bd98..f89a6e3672 100644
--- a/hw/riscv/Kconfig
+++ b/hw/riscv/Kconfig
@@ -68,6 +68,7 @@ config RISCV_VIRT
     select PLATFORM_BUS
     select ACPI
     select ACPI_PCI
+    select ACPI_HW_REDUCED

 config SHAKTI_C
     bool
diff --git a/hw/riscv/virt-acpi-build.c b/hw/riscv/virt-acpi-build.c
index f1406cb683..64fd8aa426 100644
--- a/hw/riscv/virt-acpi-build.c
+++ b/hw/riscv/virt-acpi-build.c
@@ -27,6 +27,7 @@
 #include "hw/acpi/acpi-defs.h"
 #include "hw/acpi/acpi.h"
 #include "hw/acpi/aml-build.h"
+#include "hw/acpi/generic_event_device.h"
 #include "hw/acpi/pci.h"
 #include "hw/acpi/utils.h"
 #include "hw/intc/riscv_aclint.h"
@@ -498,6 +499,15 @@ static void build_dsdt(GArray *table_data,
         acpi_dsdt_add_gpex_host(scope, PCIE_IRQ + VIRT_IRQCHIP_NUM_SOURCES * 2);
     }

+    if (s->acpi_ged) {
+        build_ged_aml(scope, "\\_SB."GED_DEVICE,
+                      HOTPLUG_HANDLER(s->acpi_ged),
+                      ACPI_GED_IRQ, AML_SYSTEM_MEMORY,
+                      s->memmap[VIRT_ACPI_GED].base);
+    }
+
+    acpi_dsdt_add_power_button(scope);
+
     aml_append(dsdt, scope);

     /* copy AML table into ACPI tables blob and patch header there */
diff --git a/hw/riscv/virt.c b/hw/riscv/virt.c
index 17909206c7..a853184105 100644
--- a/hw/riscv/virt.c
+++ b/hw/riscv/virt.c
@@ -51,10 +51,12 @@
 #include "system/kvm.h"
 #include "system/tpm.h"
 #include "system/qtest.h"
+#include "system/runstate.h"
 #include "hw/pci/pci.h"
 #include "hw/pci-host/gpex.h"
 #include "hw/display/ramfb.h"
 #include "hw/acpi/aml-build.h"
+#include "hw/acpi/generic_event_device.h"
 #include "qapi/qapi-visit-common.h"
 #include "hw/virtio/virtio-iommu.h"
 #include "hw/uefi/var-service-api.h"
@@ -95,6 +97,7 @@ static const MemMapEntry virt_memmap[] = {
     [VIRT_UART0] =        { 0x10000000,         0x100 },
     [VIRT_VIRTIO] =       { 0x10001000,        0x1000 },
     [VIRT_FW_CFG] =       { 0x10100000,          0x18 },
+    [VIRT_ACPI_GED] =     { 0x10101000, ACPI_GED_EVT_SEL_LEN },
     [VIRT_FLASH] =        { 0x20000000,     0x4000000 },
     [VIRT_IMSIC_M] =      { 0x24000000, VIRT_IMSIC_MAX_SIZE },
     [VIRT_IMSIC_S] =      { 0x28000000, VIRT_IMSIC_MAX_SIZE },
@@ -1270,6 +1273,22 @@ static inline DeviceState *gpex_pcie_init(MemoryRegion *sys_mem,
     return dev;
 }

+static DeviceState *create_acpi_ged(RISCVVirtState *s, DeviceState *irqchip)
+{
+    DeviceState *dev;
+    uint32_t event = ACPI_GED_PWR_DOWN_EVT;
+
+    dev = qdev_new(TYPE_ACPI_GED);
+    qdev_prop_set_uint32(dev, "ged-event", event);
+    sysbus_realize_and_unref(SYS_BUS_DEVICE(dev), &error_fatal);
+
+    sysbus_mmio_map(SYS_BUS_DEVICE(dev), 0, s->memmap[VIRT_ACPI_GED].base);
+    sysbus_connect_irq(SYS_BUS_DEVICE(dev), 0,
+                       qdev_get_gpio_in(irqchip, ACPI_GED_IRQ));
+
+    return dev;
+}
+
 static FWCfgState *create_fw_cfg(const MachineState *ms, hwaddr base)
 {
     FWCfgState *fw_cfg;
@@ -1428,6 +1447,14 @@ static void virt_build_smbios(RISCVVirtState *s)
     }
 }

+static void virt_powerdown_req(Notifier *notifier, void *opaque)
+{
+    RISCVVirtState *s;
+
+    s = container_of(notifier, RISCVVirtState, powerdown_notifier);
+    acpi_send_event(s->acpi_ged, ACPI_POWER_DOWN_STATUS);
+}
+
 static void virt_machine_done(Notifier *notifier, void *data)
 {
     RISCVVirtState *s = container_of(notifier, RISCVVirtState,
@@ -1701,6 +1728,11 @@ static void virt_machine_init(MachineState *machine)

     create_platform_bus(s, mmio_irqchip);

+    /* acpi ged */
+    if (virt_is_acpi_enabled(s)) {
+        s->acpi_ged = create_acpi_ged(s, mmio_irqchip);
+    }
+
     serial_mm_init(system_memory, s->memmap[VIRT_UART0].base,
         0, qdev_get_gpio_in(mmio_irqchip, UART0_IRQ), 399193,
         serial_hd(0), DEVICE_LITTLE_ENDIAN);
@@ -1742,6 +1774,9 @@ static void virt_machine_init(MachineState *machine)
         sysbus_realize_and_unref(SYS_BUS_DEVICE(iommu_sys), &error_fatal);
     }

+    s->powerdown_notifier.notify = virt_powerdown_req;
+    qemu_register_powerdown_notifier(&s->powerdown_notifier);
+
     s->machine_done.notify = virt_machine_done;
     qemu_add_machine_init_done_notifier(&s->machine_done);
 }
diff --git a/include/hw/riscv/virt.h b/include/hw/riscv/virt.h
index 7b4c2c8b7d..9422b45d0c 100644
--- a/include/hw/riscv/virt.h
+++ b/include/hw/riscv/virt.h
@@ -47,6 +47,8 @@ struct RISCVVirtState {

     /*< public >*/
     Notifier machine_done;
+    Notifier powerdown_notifier;
+    DeviceState *acpi_ged;
     DeviceState *platform_bus_dev;
     RISCVHartArrayState soc[VIRT_SOCKETS_MAX];
     DeviceState *irqchip[VIRT_SOCKETS_MAX];
@@ -88,9 +90,11 @@ enum {
     VIRT_PLATFORM_BUS,
     VIRT_PCIE_ECAM,
     VIRT_IOMMU_SYS,
+    VIRT_ACPI_GED,
 };

 enum {
+    ACPI_GED_IRQ = 9,
     UART0_IRQ = 10,
     RTC_IRQ = 11,
     VIRTIO_IRQ = 1, /* 1 to 8 */
diff --git a/tests/qtest/bios-tables-test-allowed-diff.h b/tests/qtest/bios-tables-test-allowed-diff.h
index dfb8523c8b..8e85fcdee9 100644
--- a/tests/qtest/bios-tables-test-allowed-diff.h
+++ b/tests/qtest/bios-tables-test-allowed-diff.h
@@ -1 +1,2 @@
 /* List of comma-separated changed AML files to ignore */
+"tests/data/acpi/riscv64/virt/DSDT",
-- 
2.27.0

