Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 56D36FC590F
	for <qemu-devel@archiver.kernel.org>; Thu, 26 Feb 2026 09:07:55 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vvXL9-0005LI-JL; Thu, 26 Feb 2026 04:07:23 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1vvXL8-0005L1-8w
 for qemu-devel@nongnu.org; Thu, 26 Feb 2026 04:07:22 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1vvXL3-0000s7-Tt
 for qemu-devel@nongnu.org; Thu, 26 Feb 2026 04:07:20 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1772096835;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding;
 bh=2BcZjZzCJD0GbyEgv+eejXfATABCv2Fa4hvJR3BWcp0=;
 b=MvK3CimeEafK+DPHWUlwgqZjd1HFftsHVcTImbzikUMoJlT9Q5bI4EHGQytcBFYMsbqvHV
 mUoI9w+XCvRIo8xDR+FBKf/wBhOHWSoBPe0pqDSwvl3yMBue09peQBrlNP/rZl4mAOyxzq
 UKn/0IzKORnKqUTKIAUVuwi7k3L4oJY=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-465-5yBA87gIPZqR4JiPQLKA4A-1; Thu,
 26 Feb 2026 04:07:11 -0500
X-MC-Unique: 5yBA87gIPZqR4JiPQLKA4A-1
X-Mimecast-MFC-AGG-ID: 5yBA87gIPZqR4JiPQLKA4A_1772096830
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 51D391800473; Thu, 26 Feb 2026 09:07:10 +0000 (UTC)
Received: from thuth-p1g4.redhat.com (unknown [10.45.225.23])
 by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 1D1161800348; Thu, 26 Feb 2026 09:07:06 +0000 (UTC)
From: Thomas Huth <thuth@redhat.com>
To: Peter Maydell <peter.maydell@linaro.org>, qemu-devel@nongnu.org,
 Rob Herring <robh@kernel.org>
Cc: qemu-arm@nongnu.org,
	Pierrick Bouvier <pierrick.bouvier@linaro.org>
Subject: [PATCH] hw/arm: Remove the deprecated "highbank" and "midway" machines
Date: Thu, 26 Feb 2026 10:07:04 +0100
Message-ID: <20260226090704.27699-1-thuth@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93
Received-SPF: pass client-ip=170.10.129.124; envelope-from=thuth@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -5
X-Spam_score: -0.6
X-Spam_bar: /
X-Spam_report: (-0.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.734, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.78,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=no autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

From: Thomas Huth <thuth@redhat.com>

These machines have been marked as deprecated two releases ago,
and so far nobody complained that they are still useful, so it's
time to remove these now.

Signed-off-by: Thomas Huth <thuth@redhat.com>
---
 MAINTAINERS                             |   9 -
 docs/about/deprecated.rst               |   7 -
 docs/about/removed-features.rst         |   7 +
 docs/system/arm/highbank.rst            |  19 --
 docs/system/target-arm.rst              |   1 -
 configs/devices/arm-softmmu/default.mak |   1 -
 hw/arm/highbank.c                       | 404 ------------------------
 hw/arm/Kconfig                          |  16 -
 hw/arm/meson.build                      |   1 -
 9 files changed, 7 insertions(+), 458 deletions(-)
 delete mode 100644 docs/system/arm/highbank.rst
 delete mode 100644 hw/arm/highbank.c

diff --git a/MAINTAINERS b/MAINTAINERS
index 233d2a5e71f..c7cec413cf0 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -817,15 +817,6 @@ F: include/hw/*/exynos*
 F: docs/system/arm/exynos.rst
 F: tests/functional/arm/test_smdkc210.py
 
-Calxeda Highbank
-M: Rob Herring <robh@kernel.org>
-M: Peter Maydell <peter.maydell@linaro.org>
-L: qemu-arm@nongnu.org
-S: Odd Fixes
-F: hw/arm/highbank.c
-F: hw/net/xgmac.c
-F: docs/system/arm/highbank.rst
-
 Canon DIGIC
 M: Antony Pavlov <antonynpavlov@gmail.com>
 M: Peter Maydell <peter.maydell@linaro.org>
diff --git a/docs/about/deprecated.rst b/docs/about/deprecated.rst
index 1d5c4f3707c..f95d798731f 100644
--- a/docs/about/deprecated.rst
+++ b/docs/about/deprecated.rst
@@ -293,13 +293,6 @@ they want to use and avoids confusion.  Existing users of the ``spike``
 machine must ensure that they're setting the ``spike`` machine in the
 command line (``-M spike``).
 
-Arm ``highbank`` and ``midway`` machines (since 10.1)
-'''''''''''''''''''''''''''''''''''''''''''''''''''''
-
-There are no known users left for these machines (if you still use it,
-please write a mail to the qemu-devel mailing list). If you just want to
-boot a Cortex-A15 or Cortex-A9 Linux, use the ``virt`` machine instead.
-
 
 System emulator binaries
 ------------------------
diff --git a/docs/about/removed-features.rst b/docs/about/removed-features.rst
index 41bec8b8e38..1282a82391e 100644
--- a/docs/about/removed-features.rst
+++ b/docs/about/removed-features.rst
@@ -1180,6 +1180,13 @@ and serves as the initial engineering sample rather than a production version.
 A newer revision, A1, is now supported, and the ``ast2700a1-evb`` should
 replace the older A0 version.
 
+Arm ``highbank`` and ``midway`` machines (removed in 11.0)
+''''''''''''''''''''''''''''''''''''''''''''''''''''''''''
+
+There were no known users left for these machines. If you just want to
+boot a Cortex-A15 or Cortex-A9 Linux, use the ``virt`` machine instead.
+
+
 linux-user mode CPUs
 --------------------
 
diff --git a/docs/system/arm/highbank.rst b/docs/system/arm/highbank.rst
deleted file mode 100644
index bb4965b367f..00000000000
--- a/docs/system/arm/highbank.rst
+++ /dev/null
@@ -1,19 +0,0 @@
-Calxeda Highbank and Midway (``highbank``, ``midway``)
-======================================================
-
-``highbank`` is a model of the Calxeda Highbank (ECX-1000) system,
-which has four Cortex-A9 cores.
-
-``midway`` is a model of the Calxeda Midway (ECX-2000) system,
-which has four Cortex-A15 cores.
-
-Emulated devices:
-
-- L2x0 cache controller
-- SP804 dual timer
-- PL011 UART
-- PL061 GPIOs
-- PL031 RTC
-- PL022 synchronous serial port controller
-- AHCI
-- XGMAC ethernet controllers
diff --git a/docs/system/target-arm.rst b/docs/system/target-arm.rst
index a96d1867df1..89f7b77313f 100644
--- a/docs/system/target-arm.rst
+++ b/docs/system/target-arm.rst
@@ -83,7 +83,6 @@ Board-specific documentation
    arm/bananapi_m2u.rst
    arm/b-l475e-iot01a.rst
    arm/sabrelite
-   arm/highbank
    arm/digic
    arm/cubieboard
    arm/emcraft-sf2
diff --git a/configs/devices/arm-softmmu/default.mak b/configs/devices/arm-softmmu/default.mak
index 57ef1b8a702..71cf1645110 100644
--- a/configs/devices/arm-softmmu/default.mak
+++ b/configs/devices/arm-softmmu/default.mak
@@ -12,7 +12,6 @@
 # keep out of the build.
 # CONFIG_CUBIEBOARD=n
 # CONFIG_EXYNOS4=n
-# CONFIG_HIGHBANK=n
 # CONFIG_INTEGRATOR=n
 # CONFIG_FSL_IMX31=n
 # CONFIG_MUSICPAL=n
diff --git a/hw/arm/highbank.c b/hw/arm/highbank.c
deleted file mode 100644
index 92d497999c0..00000000000
--- a/hw/arm/highbank.c
+++ /dev/null
@@ -1,404 +0,0 @@
-/*
- * Calxeda Highbank SoC emulation
- *
- * Copyright (c) 2010-2012 Calxeda
- *
- * This program is free software; you can redistribute it and/or modify it
- * under the terms and conditions of the GNU General Public License,
- * version 2 or later, as published by the Free Software Foundation.
- *
- * This program is distributed in the hope it will be useful, but WITHOUT
- * ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or
- * FITNESS FOR A PARTICULAR PURPOSE.  See the GNU General Public License for
- * more details.
- *
- * You should have received a copy of the GNU General Public License along with
- * this program.  If not, see <http://www.gnu.org/licenses/>.
- *
- */
-
-#include "qemu/osdep.h"
-#include "qemu/datadir.h"
-#include "qapi/error.h"
-#include "hw/core/sysbus.h"
-#include "migration/vmstate.h"
-#include "hw/arm/boot.h"
-#include "hw/arm/machines-qom.h"
-#include "hw/core/loader.h"
-#include "net/net.h"
-#include "system/runstate.h"
-#include "system/system.h"
-#include "hw/core/boards.h"
-#include "qemu/error-report.h"
-#include "hw/char/pl011.h"
-#include "hw/ide/ahci-sysbus.h"
-#include "hw/cpu/a9mpcore.h"
-#include "hw/cpu/a15mpcore.h"
-#include "qemu/log.h"
-#include "qom/object.h"
-#include "cpu.h"
-#include "target/arm/cpu-qom.h"
-
-#define SMP_BOOT_ADDR           0x100
-#define SMP_BOOT_REG            0x40
-#define MPCORE_PERIPHBASE       0xfff10000
-
-#define MVBAR_ADDR              0x200
-#define BOARD_SETUP_ADDR        (MVBAR_ADDR + 8 * sizeof(uint32_t))
-
-#define GIC_EXT_IRQS            128 /* EnergyCore ECX-1000 & ECX-2000 */
-
-/* Board init.  */
-
-#define NUM_REGS      0x200
-static void hb_regs_write(void *opaque, hwaddr offset,
-                          uint64_t value, unsigned size)
-{
-    uint32_t *regs = opaque;
-
-    if (offset == 0xf00) {
-        if (value == 1 || value == 2) {
-            qemu_system_reset_request(SHUTDOWN_CAUSE_GUEST_RESET);
-        } else if (value == 3) {
-            qemu_system_shutdown_request(SHUTDOWN_CAUSE_GUEST_SHUTDOWN);
-        }
-    }
-
-    if (offset / 4 >= NUM_REGS) {
-        qemu_log_mask(LOG_GUEST_ERROR,
-                  "highbank: bad write offset 0x%" HWADDR_PRIx "\n", offset);
-        return;
-    }
-    regs[offset / 4] = value;
-}
-
-static uint64_t hb_regs_read(void *opaque, hwaddr offset,
-                             unsigned size)
-{
-    uint32_t value;
-    uint32_t *regs = opaque;
-
-    if (offset / 4 >= NUM_REGS) {
-        qemu_log_mask(LOG_GUEST_ERROR,
-                  "highbank: bad read offset 0x%" HWADDR_PRIx "\n", offset);
-        return 0;
-    }
-    value = regs[offset / 4];
-
-    if ((offset == 0x100) || (offset == 0x108) || (offset == 0x10C)) {
-        value |= 0x30000000;
-    }
-
-    return value;
-}
-
-static const MemoryRegionOps hb_mem_ops = {
-    .read = hb_regs_read,
-    .write = hb_regs_write,
-    .endianness = DEVICE_NATIVE_ENDIAN,
-};
-
-#define TYPE_HIGHBANK_REGISTERS "highbank-regs"
-OBJECT_DECLARE_SIMPLE_TYPE(HighbankRegsState, HIGHBANK_REGISTERS)
-
-struct HighbankRegsState {
-    /*< private >*/
-    SysBusDevice parent_obj;
-    /*< public >*/
-
-    MemoryRegion iomem;
-    uint32_t regs[NUM_REGS];
-};
-
-static const VMStateDescription vmstate_highbank_regs = {
-    .name = "highbank-regs",
-    .version_id = 0,
-    .minimum_version_id = 0,
-    .fields = (const VMStateField[]) {
-        VMSTATE_UINT32_ARRAY(regs, HighbankRegsState, NUM_REGS),
-        VMSTATE_END_OF_LIST(),
-    },
-};
-
-static void highbank_regs_reset(DeviceState *dev)
-{
-    HighbankRegsState *s = HIGHBANK_REGISTERS(dev);
-
-    s->regs[0x40] = 0x05F20121;
-    s->regs[0x41] = 0x2;
-    s->regs[0x42] = 0x05F30121;
-    s->regs[0x43] = 0x05F40121;
-}
-
-static void highbank_regs_init(Object *obj)
-{
-    HighbankRegsState *s = HIGHBANK_REGISTERS(obj);
-    SysBusDevice *dev = SYS_BUS_DEVICE(obj);
-
-    memory_region_init_io(&s->iomem, obj, &hb_mem_ops, s->regs,
-                          "highbank_regs", 0x1000);
-    sysbus_init_mmio(dev, &s->iomem);
-}
-
-static void highbank_regs_class_init(ObjectClass *klass, const void *data)
-{
-    DeviceClass *dc = DEVICE_CLASS(klass);
-
-    dc->desc = "Calxeda Highbank registers";
-    dc->vmsd = &vmstate_highbank_regs;
-    device_class_set_legacy_reset(dc, highbank_regs_reset);
-}
-
-static const TypeInfo highbank_regs_info = {
-    .name          = TYPE_HIGHBANK_REGISTERS,
-    .parent        = TYPE_SYS_BUS_DEVICE,
-    .instance_size = sizeof(HighbankRegsState),
-    .instance_init = highbank_regs_init,
-    .class_init    = highbank_regs_class_init,
-};
-
-static void highbank_regs_register_types(void)
-{
-    type_register_static(&highbank_regs_info);
-}
-
-type_init(highbank_regs_register_types)
-
-static struct arm_boot_info highbank_binfo;
-
-enum cxmachines {
-    CALXEDA_HIGHBANK,
-    CALXEDA_MIDWAY,
-};
-
-/* ram_size must be set to match the upper bound of memory in the
- * device tree (linux/arch/arm/boot/dts/highbank.dts), which is
- * normally 0xff900000 or -m 4089. When running this board on a
- * 32-bit host, set the reg value of memory to 0xf7ff00000 in the
- * device tree and pass -m 2047 to QEMU.
- */
-static void calxeda_init(MachineState *machine, enum cxmachines machine_id)
-{
-    DeviceState *dev = NULL;
-    SysBusDevice *busdev;
-    qemu_irq pic[GIC_EXT_IRQS];
-    int n;
-    unsigned int smp_cpus = machine->smp.cpus;
-    qemu_irq cpu_irq[4];
-    qemu_irq cpu_fiq[4];
-    qemu_irq cpu_virq[4];
-    qemu_irq cpu_vfiq[4];
-    MemoryRegion *sysram;
-    MemoryRegion *sysmem;
-    char *sysboot_filename;
-
-    switch (machine_id) {
-    case CALXEDA_HIGHBANK:
-        machine->cpu_type = ARM_CPU_TYPE_NAME("cortex-a9");
-        break;
-    case CALXEDA_MIDWAY:
-        machine->cpu_type = ARM_CPU_TYPE_NAME("cortex-a15");
-        break;
-    default:
-        g_assert_not_reached();
-    }
-
-    for (n = 0; n < smp_cpus; n++) {
-        Object *cpuobj;
-        ARMCPU *cpu;
-
-        cpuobj = object_new(machine->cpu_type);
-        cpu = ARM_CPU(cpuobj);
-
-        object_property_add_child(OBJECT(machine), "cpu[*]", cpuobj);
-        object_property_set_int(cpuobj, "psci-conduit", QEMU_PSCI_CONDUIT_SMC,
-                                &error_abort);
-
-        if (object_property_find(cpuobj, "reset-cbar")) {
-            object_property_set_int(cpuobj, "reset-cbar", MPCORE_PERIPHBASE,
-                                    &error_abort);
-        }
-        qdev_realize(DEVICE(cpuobj), NULL, &error_fatal);
-        cpu_irq[n] = qdev_get_gpio_in(DEVICE(cpu), ARM_CPU_IRQ);
-        cpu_fiq[n] = qdev_get_gpio_in(DEVICE(cpu), ARM_CPU_FIQ);
-        cpu_virq[n] = qdev_get_gpio_in(DEVICE(cpu), ARM_CPU_VIRQ);
-        cpu_vfiq[n] = qdev_get_gpio_in(DEVICE(cpu), ARM_CPU_VFIQ);
-    }
-
-    sysmem = get_system_memory();
-    /* SDRAM at address zero.  */
-    memory_region_add_subregion(sysmem, 0, machine->ram);
-
-    sysram = g_new(MemoryRegion, 1);
-    memory_region_init_ram(sysram, NULL, "highbank.sysram", 0x8000,
-                           &error_fatal);
-    memory_region_add_subregion(sysmem, 0xfff88000, sysram);
-    if (machine->firmware != NULL) {
-        sysboot_filename = qemu_find_file(QEMU_FILE_TYPE_BIOS, machine->firmware);
-        if (sysboot_filename != NULL) {
-            if (load_image_targphys(sysboot_filename, 0xfff88000, 0x8000,
-                                    NULL) < 0) {
-                error_report("Unable to load %s", machine->firmware);
-                exit(1);
-            }
-            g_free(sysboot_filename);
-        } else {
-            error_report("Unable to find %s", machine->firmware);
-            exit(1);
-        }
-    }
-
-    switch (machine_id) {
-    case CALXEDA_HIGHBANK:
-        dev = qdev_new("l2x0");
-        busdev = SYS_BUS_DEVICE(dev);
-        sysbus_realize_and_unref(busdev, &error_fatal);
-        sysbus_mmio_map(busdev, 0, 0xfff12000);
-
-        dev = qdev_new(TYPE_A9MPCORE_PRIV);
-        break;
-    case CALXEDA_MIDWAY:
-        dev = qdev_new(TYPE_A15MPCORE_PRIV);
-        break;
-    }
-    qdev_prop_set_uint32(dev, "num-cpu", smp_cpus);
-    qdev_prop_set_uint32(dev, "num-irq", GIC_EXT_IRQS + GIC_INTERNAL);
-    busdev = SYS_BUS_DEVICE(dev);
-    sysbus_realize_and_unref(busdev, &error_fatal);
-    sysbus_mmio_map(busdev, 0, MPCORE_PERIPHBASE);
-    for (n = 0; n < smp_cpus; n++) {
-        sysbus_connect_irq(busdev, n, cpu_irq[n]);
-        sysbus_connect_irq(busdev, n + smp_cpus, cpu_fiq[n]);
-        sysbus_connect_irq(busdev, n + 2 * smp_cpus, cpu_virq[n]);
-        sysbus_connect_irq(busdev, n + 3 * smp_cpus, cpu_vfiq[n]);
-    }
-
-    for (n = 0; n < GIC_EXT_IRQS; n++) {
-        pic[n] = qdev_get_gpio_in(dev, n);
-    }
-
-    dev = qdev_new("sp804");
-    qdev_prop_set_uint32(dev, "freq0", 150000000);
-    qdev_prop_set_uint32(dev, "freq1", 150000000);
-    busdev = SYS_BUS_DEVICE(dev);
-    sysbus_realize_and_unref(busdev, &error_fatal);
-    sysbus_mmio_map(busdev, 0, 0xfff34000);
-    sysbus_connect_irq(busdev, 0, pic[18]);
-    pl011_create(0xfff36000, pic[20], serial_hd(0));
-
-    dev = qdev_new(TYPE_HIGHBANK_REGISTERS);
-    busdev = SYS_BUS_DEVICE(dev);
-    sysbus_realize_and_unref(busdev, &error_fatal);
-    sysbus_mmio_map(busdev, 0, 0xfff3c000);
-
-    sysbus_create_simple("pl061", 0xfff30000, pic[14]);
-    sysbus_create_simple("pl061", 0xfff31000, pic[15]);
-    sysbus_create_simple("pl061", 0xfff32000, pic[16]);
-    sysbus_create_simple("pl061", 0xfff33000, pic[17]);
-    sysbus_create_simple("pl031", 0xfff35000, pic[19]);
-    sysbus_create_simple("pl022", 0xfff39000, pic[23]);
-
-    sysbus_create_simple(TYPE_SYSBUS_AHCI, 0xffe08000, pic[83]);
-
-    dev = qemu_create_nic_device("xgmac", true, NULL);
-    if (dev) {
-        sysbus_realize_and_unref(SYS_BUS_DEVICE(dev), &error_fatal);
-        sysbus_mmio_map(SYS_BUS_DEVICE(dev), 0, 0xfff50000);
-        sysbus_connect_irq(SYS_BUS_DEVICE(dev), 0, pic[77]);
-        sysbus_connect_irq(SYS_BUS_DEVICE(dev), 1, pic[78]);
-        sysbus_connect_irq(SYS_BUS_DEVICE(dev), 2, pic[79]);
-    }
-
-    dev = qemu_create_nic_device("xgmac", true, NULL);
-    if (dev) {
-        sysbus_realize_and_unref(SYS_BUS_DEVICE(dev), &error_fatal);
-        sysbus_mmio_map(SYS_BUS_DEVICE(dev), 0, 0xfff51000);
-        sysbus_connect_irq(SYS_BUS_DEVICE(dev), 0, pic[80]);
-        sysbus_connect_irq(SYS_BUS_DEVICE(dev), 1, pic[81]);
-        sysbus_connect_irq(SYS_BUS_DEVICE(dev), 2, pic[82]);
-    }
-
-    /* TODO create and connect IDE devices for ide_drive_get() */
-
-    highbank_binfo.ram_size = machine->ram_size;
-    /* highbank requires a dtb in order to boot, and the dtb will override
-     * the board ID. The following value is ignored, so set it to -1 to be
-     * clear that the value is meaningless.
-     */
-    highbank_binfo.board_id = -1;
-    highbank_binfo.loader_start = 0;
-    highbank_binfo.board_setup_addr = BOARD_SETUP_ADDR;
-    highbank_binfo.psci_conduit = QEMU_PSCI_CONDUIT_SMC;
-
-    arm_load_kernel(ARM_CPU(first_cpu), machine, &highbank_binfo);
-}
-
-static void highbank_init(MachineState *machine)
-{
-    calxeda_init(machine, CALXEDA_HIGHBANK);
-}
-
-static void midway_init(MachineState *machine)
-{
-    calxeda_init(machine, CALXEDA_MIDWAY);
-}
-
-static void highbank_class_init(ObjectClass *oc, const void *data)
-{
-    static const char * const valid_cpu_types[] = {
-        ARM_CPU_TYPE_NAME("cortex-a9"),
-        NULL
-    };
-    MachineClass *mc = MACHINE_CLASS(oc);
-
-    mc->desc = "Calxeda Highbank (ECX-1000)";
-    mc->init = highbank_init;
-    mc->valid_cpu_types = valid_cpu_types;
-    mc->block_default_type = IF_IDE;
-    mc->units_per_default_bus = 1;
-    mc->max_cpus = 4;
-    mc->ignore_memory_transaction_failures = true;
-    mc->default_ram_id = "highbank.dram";
-    mc->deprecation_reason = "no known users left for this machine";
-}
-
-static const TypeInfo highbank_type = {
-    .name = MACHINE_TYPE_NAME("highbank"),
-    .parent = TYPE_MACHINE,
-    .class_init = highbank_class_init,
-    .interfaces = arm_machine_interfaces,
-};
-
-static void midway_class_init(ObjectClass *oc, const void *data)
-{
-    static const char * const valid_cpu_types[] = {
-        ARM_CPU_TYPE_NAME("cortex-a15"),
-        NULL
-    };
-    MachineClass *mc = MACHINE_CLASS(oc);
-
-    mc->desc = "Calxeda Midway (ECX-2000)";
-    mc->init = midway_init;
-    mc->valid_cpu_types = valid_cpu_types;
-    mc->block_default_type = IF_IDE;
-    mc->units_per_default_bus = 1;
-    mc->max_cpus = 4;
-    mc->ignore_memory_transaction_failures = true;
-    mc->default_ram_id = "highbank.dram";
-    mc->deprecation_reason = "no known users left for this machine";
-}
-
-static const TypeInfo midway_type = {
-    .name = MACHINE_TYPE_NAME("midway"),
-    .parent = TYPE_MACHINE,
-    .class_init = midway_class_init,
-    .interfaces = arm_machine_interfaces,
-};
-
-static void calxeda_machines_init(void)
-{
-    type_register_static(&highbank_type);
-    type_register_static(&midway_type);
-}
-
-type_init(calxeda_machines_init)
diff --git a/hw/arm/Kconfig b/hw/arm/Kconfig
index c66c452737e..45fe8575fb8 100644
--- a/hw/arm/Kconfig
+++ b/hw/arm/Kconfig
@@ -64,22 +64,6 @@ config EXYNOS4
     select USB_EHCI_SYSBUS
     select OR_IRQ
 
-config HIGHBANK
-    bool
-    default y
-    depends on TCG && ARM
-    select A9MPCORE
-    select A15MPCORE
-    select AHCI_SYSBUS
-    select ARM_TIMER # sp804
-    select ARM_V7M
-    select PL011 # UART
-    select PL022 # SPI
-    select PL031 # RTC
-    select PL061 # GPIO
-    select PL310 # cache controller
-    select XGMAC # ethernet
-
 config INTEGRATOR
     bool
     default y
diff --git a/hw/arm/meson.build b/hw/arm/meson.build
index 47cdc51d135..b187b946f04 100644
--- a/hw/arm/meson.build
+++ b/hw/arm/meson.build
@@ -4,7 +4,6 @@ arm_common_ss.add(when: 'CONFIG_ARM_VIRT', if_true: files('virt.c'))
 arm_common_ss.add(when: 'CONFIG_ACPI', if_true: files('virt-acpi-build.c'))
 arm_common_ss.add(when: 'CONFIG_DIGIC', if_true: files('digic_boards.c'))
 arm_common_ss.add(when: 'CONFIG_EMCRAFT_SF2', if_true: files('msf2-som.c'))
-arm_common_ss.add(when: 'CONFIG_HIGHBANK', if_true: files('highbank.c'))
 arm_common_ss.add(when: 'CONFIG_INTEGRATOR', if_true: files('integratorcp.c'))
 arm_common_ss.add(when: 'CONFIG_MICROBIT', if_true: files('microbit.c'))
 arm_common_ss.add(when: 'CONFIG_MPS3R', if_true: files('mps3r.c'))
-- 
2.53.0


