Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C3CD2CCD184
	for <qemu-devel@archiver.kernel.org>; Tue, 21 Oct 2025 16:23:08 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vBF7S-0004RB-S1; Tue, 21 Oct 2025 12:21:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jim.shu@sifive.com>)
 id 1vBF7C-0004Mw-TA
 for qemu-devel@nongnu.org; Tue, 21 Oct 2025 12:21:39 -0400
Received: from mail-pf1-x42c.google.com ([2607:f8b0:4864:20::42c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <jim.shu@sifive.com>)
 id 1vBF7A-0002Yp-CD
 for qemu-devel@nongnu.org; Tue, 21 Oct 2025 12:21:38 -0400
Received: by mail-pf1-x42c.google.com with SMTP id
 d2e1a72fcca58-7a226a0798cso3739593b3a.2
 for <qemu-devel@nongnu.org>; Tue, 21 Oct 2025 09:21:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sifive.com; s=google; t=1761063684; x=1761668484; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=huFZTWwE5EwrZvuArHryWgwrJYSVhUlfOJjgqhChV0Q=;
 b=S2eO2FO9UAWNYZoFWrPp8lAnPxiSpcazWzVqDy6KNP8g3kBUBChlqbwzNSSINNeSgh
 ZW1j1Cbi23H0pbyYjOvxtp2hdgpCpeV1yHsABlDrs59gBxmIMtuLC1ZYkUethEyjuEgT
 oPpEajvDJJ7IsgCS/54osVFNu6hIyur/Q81VrfHvNu19ciX/Rb0S3AWPMX5ONT7kr6z4
 d9F9v5ku/MTUU2LLMqc1FDrdSK8QU/bO6w7SY8gqjLrkb7vRT8nUxjasKs8AY/zS8IOo
 o34N0m/6duvr4lf1p6MR7O/Byno+NYgZzvwrQO9FdvezaRvJU00NFcObPPySTkL7+UgN
 ip0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1761063684; x=1761668484;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=huFZTWwE5EwrZvuArHryWgwrJYSVhUlfOJjgqhChV0Q=;
 b=wF5fw6tZKi9TKIi6SaHZSulSzg1dfLKsi8YTA2Ie3kmewHKLzluxJ2Ny1CBrD8uvc2
 GfiDwxnCmDR2Qt5BV9iqGk2qpve6eFeIelCybKKIShK519wutZtGEZnUkYBuZViOngzj
 aShCLz5QwO+s6fhS6bpQ/BdntgjBFELFsrFF8d6RQjz6HQSdZiuL3Dx/Bn01C/S4CUj7
 uXEX5Iuc1S642Gk5N9JGy0XoH2XT2h+O9dp1oLbwyWvVmOzY6kWxj0mzE0AtJR06EvYS
 caOuXUjRu511HAPFypuvaRYuK2RbahBIxbgqRhpZ6gWdLwo24m6PUBx664yMxgV2dh0Z
 v6MA==
X-Gm-Message-State: AOJu0Yw2tbkjFEbLAqq9VT1A4S52EOdrCsRcZzYaIykrn7n+nQUyterq
 LDIkcs+NdavXXUvhcQAdcpHp4q+BP9UdlIrY0p+7i6VIiuYPYMaFvgrUyUzF6J2CRenLTQIkQ8u
 QdW0ml5AioYwgWih4NK7of0N/YkY7mOjSwRw9WxgJ7SYCgzQ5nV/J6v3mq4jNO4p6MH4PuaDbWQ
 4NLHsgYXmIq9B9Ez9Lm5VvWLkaMVtwllXAabE/kA==
X-Gm-Gg: ASbGncvCGYO/jx1hbr5vakipWczm7ZKq+ya8GGPD1LorPMnZr9ByCRygeVwBq7AXSn7
 QkL/05L0aeWVAkBX4l3MIczzJxh9poO2nTHxmjwszyez0+WoFoj+hT2TLPdJMQnZITDYbiyjUSw
 h4Fqx4k2wVt4tmT+5GPTMfNhdgml3axKbrB91esQVP9ca/FxPDSVih2ORvjN1z0T9lPvqIya30N
 gUv3N66jUWHCYG9k0TfGl13OPMA8NXbpKcnQ/oL28ytha6aHfvjmSTy3JMABkVglBhktGsp4msB
 4x+PR+D7pQW8cjWyKBbFdpB+L/gHbnpPiHxRqnBoDhP6Z6Yo1xHCx0eKFasvC124KR/t1MtVpGp
 iyA06ElAAZNVvZ2wGCZJqgWCxOPN62IZ2s3nAHzQ/lRN0i6+VtVT0YBmf8JETsSFSz5HkEbnmJl
 Xo06LDbtErR58hQhoPpT3cQm0HxzFEQJT9
X-Google-Smtp-Source: AGHT+IHhFy4VzDWfZbtCM8KJZ28J/tgadcBeZJVWAvN3f7fNgI/ocOd1dPXKv27sG96lzMYFu3e6jA==
X-Received: by 2002:a05:6a20:3945:b0:334:a15f:8d2d with SMTP id
 adf61e73a8af0-334a8629db6mr21085726637.44.1761063684189; 
 Tue, 21 Oct 2025 09:21:24 -0700 (PDT)
Received: from hsinchu26.internal.sifive.com ([210.176.154.34])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-7a23011088fsm11720280b3a.65.2025.10.21.09.21.22
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 21 Oct 2025 09:21:23 -0700 (PDT)
From: Jim Shu <jim.shu@sifive.com>
To: qemu-devel@nongnu.org,
	qemu-riscv@nongnu.org
Cc: Daniel Henrique Barboza <dbarboza@ventanamicro.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Palmer Dabbelt <palmer@dabbelt.com>,
 Alistair Francis <alistair.francis@wdc.com>,
 Weiwei Li <liwei1518@gmail.com>, Liu Zhiwei <zhiwei_liu@linux.alibaba.com>,
 Jim Shu <jim.shu@sifive.com>
Subject: [PATCH v3 18/18] hw/riscv: virt: Add WorldGuard support
Date: Wed, 22 Oct 2025 00:21:08 +0800
Message-ID: <20251021162108.585468-4-jim.shu@sifive.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20251021155548.584543-1-jim.shu@sifive.com>
References: <20251021155548.584543-1-jim.shu@sifive.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::42c;
 envelope-from=jim.shu@sifive.com; helo=mail-pf1-x42c.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
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

* Add 'wg=on' option to enable RISC-V WorldGuard
* Add wgChecker to protect several resources:
  DRAM, FLASH, UART.

Signed-off-by: Jim Shu <jim.shu@sifive.com>
---
 docs/system/riscv/virt.rst |  20 +++++
 hw/riscv/Kconfig           |   1 +
 hw/riscv/virt.c            | 165 ++++++++++++++++++++++++++++++++++++-
 include/hw/riscv/virt.h    |  15 +++-
 4 files changed, 197 insertions(+), 4 deletions(-)

diff --git a/docs/system/riscv/virt.rst b/docs/system/riscv/virt.rst
index 60850970ce..eef1233350 100644
--- a/docs/system/riscv/virt.rst
+++ b/docs/system/riscv/virt.rst
@@ -146,6 +146,26 @@ The following machine-specific options are supported:
 
   Enables the riscv-iommu-sys platform device. Defaults to 'off'.
 
+- wg=[on|off]
+
+  When this option is "on", RISC-V WorldGuard will be enabled in the system
+  to provide the isolation of multiple worlds. RISC-V HARTs will enable WG
+  extensions to have WID in memory transaction. wgCheckers in front of RAMs
+  and device MMIO will be enabled to provide the access control of resources
+  if the transaction contains WID. When not specified, this option is assumed
+  to be "off".
+
+  The WG configuration of virt machine includes 4 worlds. For WG configuration
+  of CPUs, the M-mode WID of CPU (``mwid``) is set to the largest WID number,
+  and the authorized WID list of CPU (``mwidlist``) includes all WIDs. We can
+  modify the configuration of all CPUs via ``x-mwid`` and ``x-mwidlist``
+  CPU options. There are 3 wgCheckers in the virt machine, which separately
+  protects DRAM, FLASH, and UART. Default WG configuration on the virt machine
+  is enough to run the demo of dual OSes in the different worlds. For example,
+  running both Linux kernel and Secure OS (e.g. OP-TEE) in it's own world.
+
+  This option is restricted to the TCG accelerator.
+
 Running Linux kernel
 --------------------
 
diff --git a/hw/riscv/Kconfig b/hw/riscv/Kconfig
index fc9c35bd98..d47e347b0f 100644
--- a/hw/riscv/Kconfig
+++ b/hw/riscv/Kconfig
@@ -68,6 +68,7 @@ config RISCV_VIRT
     select PLATFORM_BUS
     select ACPI
     select ACPI_PCI
+    select RISCV_WORLDGUARD
 
 config SHAKTI_C
     bool
diff --git a/hw/riscv/virt.c b/hw/riscv/virt.c
index 47e573f85a..25dfa8a55e 100644
--- a/hw/riscv/virt.c
+++ b/hw/riscv/virt.c
@@ -58,6 +58,7 @@
 #include "qapi/qapi-visit-common.h"
 #include "hw/virtio/virtio-iommu.h"
 #include "hw/uefi/var-service-api.h"
+#include "hw/misc/riscv_worldguard.h"
 
 /* KVM AIA only supports APLIC MSI. APLIC Wired is always emulated by QEMU. */
 static bool virt_use_kvm_aia_aplic_imsic(RISCVVirtAIAType aia_type)
@@ -89,6 +90,9 @@ static const MemMapEntry virt_memmap[] = {
     [VIRT_PCIE_PIO] =     {  0x3000000,       0x10000 },
     [VIRT_IOMMU_SYS] =    {  0x3010000,        0x1000 },
     [VIRT_PLATFORM_BUS] = {  0x4000000,     0x2000000 },
+    [VIRT_WGC_DRAM] =     {  0x6000000,        0x1000 },
+    [VIRT_WGC_FLASH] =    {  0x6001000,        0x1000 },
+    [VIRT_WGC_UART] =     {  0x6002000,        0x1000 },
     [VIRT_PLIC] =         {  0xc000000, VIRT_PLIC_SIZE(VIRT_CPUS_MAX * 2) },
     [VIRT_APLIC_M] =      {  0xc000000, APLIC_SIZE(VIRT_CPUS_MAX) },
     [VIRT_APLIC_S] =      {  0xd000000, APLIC_SIZE(VIRT_CPUS_MAX) },
@@ -114,6 +118,38 @@ static MemMapEntry virt_high_pcie_memmap;
 
 #define VIRT_FLASH_SECTOR_SIZE (256 * KiB)
 
+/* wgChecker helpers */
+typedef struct WGCInfo {
+    int memmap_idx;
+    uint32_t irq_num;
+    uint32_t slot_count;
+
+    int num_of_child;
+    MemoryRegion *c_region[WGC_NUM_REGIONS];
+    uint64_t c_offset[WGC_NUM_REGIONS];
+} WGCInfo;
+
+enum {
+    WGC_DRAM,
+    WGC_FLASH,
+    WGC_UART,
+    WGC_NUM,
+};
+
+static WGCInfo virt_wgcinfo[] = {
+    [WGC_DRAM]  = { VIRT_WGC_DRAM, WGC_DRAM_IRQ, 16 },
+    [WGC_FLASH] = { VIRT_WGC_FLASH, WGC_FLASH_IRQ, 16 },
+    [WGC_UART]  = { VIRT_WGC_UART, WGC_UART_IRQ, 1 },
+};
+
+static void wgc_append_child(WGCInfo *info, MemoryRegion *region,
+                             uint64_t offset)
+{
+    info->c_region[info->num_of_child] = region;
+    info->c_offset[info->num_of_child] = offset;
+    info->num_of_child += 1;
+}
+
 static PFlashCFI01 *virt_flash_create1(RISCVVirtState *s,
                                        const char *name,
                                        const char *alias_prop_name)
@@ -164,7 +200,8 @@ static void virt_flash_map1(PFlashCFI01 *flash,
 }
 
 static void virt_flash_map(RISCVVirtState *s,
-                           MemoryRegion *sysmem)
+                           MemoryRegion *sysmem,
+                           WGCInfo *info)
 {
     hwaddr flashsize = s->memmap[VIRT_FLASH].size / 2;
     hwaddr flashbase = s->memmap[VIRT_FLASH].base;
@@ -173,6 +210,15 @@ static void virt_flash_map(RISCVVirtState *s,
                     sysmem);
     virt_flash_map1(s->flash[1], flashbase + flashsize, flashsize,
                     sysmem);
+
+    if (info) {
+        wgc_append_child(info,
+                         sysbus_mmio_get_region(SYS_BUS_DEVICE(s->flash[0]), 0),
+                         flashbase);
+        wgc_append_child(info,
+                         sysbus_mmio_get_region(SYS_BUS_DEVICE(s->flash[1]), 0),
+                         flashbase + flashsize);
+    }
 }
 
 static void create_pcie_irq_map(RISCVVirtState *s, void *fdt, char *nodename,
@@ -1428,6 +1474,72 @@ static void virt_build_smbios(RISCVVirtState *s)
     }
 }
 
+static DeviceState *create_wgc(WGCInfo *info, DeviceState *irqchip)
+{
+    MemoryRegion *system_memory = get_system_memory();
+    DeviceState *wgc;
+    MemoryRegion *upstream_mr, *downstream_mr;
+    qemu_irq irq = qdev_get_gpio_in(irqchip, info->irq_num);
+    hwaddr base, size;
+
+    /* Unmap downstream_mr from system_memory if it is already mapped. */
+    for (int i = 0; i < info->num_of_child; i++) {
+        downstream_mr = info->c_region[i];
+
+        g_assert(downstream_mr);
+        if (downstream_mr->container == system_memory) {
+            memory_region_del_subregion(system_memory, downstream_mr);
+        }
+
+        /*
+         * Clear the offset of downstream_mr, so we could correctly do
+         * address_space_init() to it in wgchecker.
+         */
+        memory_region_set_address(downstream_mr, 0);
+    }
+
+    base = virt_memmap[info->memmap_idx].base;
+    size = virt_memmap[info->memmap_idx].size;
+
+    wgc = riscv_wgchecker_create(
+        base, size, irq, info->slot_count, 0, 0,
+        info->num_of_child, info->c_region, info->c_offset, 0, NULL);
+
+    /* Map upstream_mr to system_memory */
+    for (int i = 0; i < info->num_of_child; i++) {
+        upstream_mr = sysbus_mmio_get_region(SYS_BUS_DEVICE(wgc), i + 1);
+        g_assert(upstream_mr);
+        memory_region_add_subregion(system_memory, info->c_offset[i],
+                                    upstream_mr);
+    }
+
+    return wgc;
+}
+
+static void virt_create_worldguard(WGCInfo *wgcinfo, int wgc_num,
+                                   DeviceState *irqchip)
+{
+    CPUState *cpu;
+
+    /* Global WG config */
+    riscv_worldguard_create(VIRT_WG_NWORLDS,
+                            VIRT_WG_TRUSTEDWID,
+                            VIRT_WG_HWBYPASS,
+                            VIRT_WG_TZCOMPAT);
+
+    /* Enable WG extension of each CPU */
+    CPU_FOREACH(cpu) {
+        CPURISCVState *env = cpu ? cpu_env(cpu) : NULL;
+
+        riscv_worldguard_apply_cpu(env->mhartid);
+    }
+
+    /* Create all wgChecker devices */
+    for (int i = 0; i < wgc_num; i++) {
+        create_wgc(&wgcinfo[i], DEVICE(irqchip));
+    }
+}
+
 static void virt_machine_done(Notifier *notifier, void *data)
 {
     RISCVVirtState *s = container_of(notifier, RISCVVirtState,
@@ -1527,10 +1639,12 @@ static void virt_machine_done(Notifier *notifier, void *data)
 
 static void virt_machine_init(MachineState *machine)
 {
+    WGCInfo *wgcinfo = virt_wgcinfo;
     RISCVVirtState *s = RISCV_VIRT_MACHINE(machine);
     MemoryRegion *system_memory = get_system_memory();
     MemoryRegion *mask_rom = g_new(MemoryRegion, 1);
     DeviceState *mmio_irqchip, *virtio_irqchip, *pcie_irqchip;
+    SerialMM *uart;
     int i, base_hartid, hart_count;
     int socket_count = riscv_socket_count(machine);
 
@@ -1548,6 +1662,11 @@ static void virt_machine_init(MachineState *machine)
         exit(1);
     }
 
+    if (!tcg_enabled() && s->have_wg) {
+        error_report("'wg' is only available with TCG acceleration");
+        exit(1);
+    }
+
     /* Initialize sockets */
     mmio_irqchip = virtio_irqchip = pcie_irqchip = NULL;
     for (i = 0; i < socket_count; i++) {
@@ -1674,6 +1793,11 @@ static void virt_machine_init(MachineState *machine)
     memory_region_add_subregion(system_memory, s->memmap[VIRT_DRAM].base,
                                 machine->ram);
 
+    if (object_property_get_bool(OBJECT(s), "wg", NULL)) {
+        wgc_append_child(&wgcinfo[WGC_DRAM], machine->ram,
+                         s->memmap[VIRT_DRAM].base);
+    }
+
     /* boot rom */
     memory_region_init_rom(mask_rom, NULL, "riscv_virt_board.mrom",
                            s->memmap[VIRT_MROM].size, &error_fatal);
@@ -1701,10 +1825,16 @@ static void virt_machine_init(MachineState *machine)
 
     create_platform_bus(s, mmio_irqchip);
 
-    serial_mm_init(system_memory, s->memmap[VIRT_UART0].base,
+    uart = serial_mm_init(system_memory, s->memmap[VIRT_UART0].base,
         0, qdev_get_gpio_in(mmio_irqchip, UART0_IRQ), 399193,
         serial_hd(0), DEVICE_LITTLE_ENDIAN);
 
+    if (object_property_get_bool(OBJECT(s), "wg", NULL)) {
+        wgc_append_child(&wgcinfo[WGC_UART],
+                         sysbus_mmio_get_region(SYS_BUS_DEVICE(uart), 0),
+                         s->memmap[VIRT_UART0].base);
+    }
+
     sysbus_create_simple("goldfish_rtc", s->memmap[VIRT_RTC].base,
         qdev_get_gpio_in(mmio_irqchip, RTC_IRQ));
 
@@ -1713,7 +1843,16 @@ static void virt_machine_init(MachineState *machine)
         pflash_cfi01_legacy_drive(s->flash[i],
                                   drive_get(IF_PFLASH, 0, i));
     }
-    virt_flash_map(s, system_memory);
+
+    if (object_property_get_bool(OBJECT(s), "wg", NULL)) {
+        virt_flash_map(s, system_memory, &wgcinfo[WGC_FLASH]);
+    } else {
+        virt_flash_map(s, system_memory, NULL);
+    }
+
+    if (object_property_get_bool(OBJECT(s), "wg", NULL)) {
+        virt_create_worldguard(wgcinfo, WGC_NUM, mmio_irqchip);
+    }
 
     /* load/create device tree */
     if (machine->dtb) {
@@ -1758,6 +1897,20 @@ static void virt_machine_instance_init(Object *obj)
     s->iommu_sys = ON_OFF_AUTO_AUTO;
 }
 
+static bool virt_get_wg(Object *obj, Error **errp)
+{
+    RISCVVirtState *s = RISCV_VIRT_MACHINE(obj);
+
+    return tcg_enabled() && s->have_wg;
+}
+
+static void virt_set_wg(Object *obj, bool value, Error **errp)
+{
+    RISCVVirtState *s = RISCV_VIRT_MACHINE(obj);
+
+    s->have_wg = value;
+}
+
 static char *virt_get_aia_guests(Object *obj, Error **errp)
 {
     RISCVVirtState *s = RISCV_VIRT_MACHINE(obj);
@@ -1978,6 +2131,12 @@ static void virt_machine_class_init(ObjectClass *oc, const void *data)
                               NULL, NULL);
     object_class_property_set_description(oc, "iommu-sys",
                                           "Enable IOMMU platform device");
+
+    object_class_property_add_bool(oc, "wg", virt_get_wg,
+                                   virt_set_wg);
+    object_class_property_set_description(oc, "wg",
+                                              "Set on/off to enable/disable the "
+                                              "RISC-V WorldGuard.");
 }
 
 static const TypeInfo virt_machine_typeinfo = {
diff --git a/include/hw/riscv/virt.h b/include/hw/riscv/virt.h
index 7b4c2c8b7d..63be60b8a2 100644
--- a/include/hw/riscv/virt.h
+++ b/include/hw/riscv/virt.h
@@ -57,6 +57,7 @@ struct RISCVVirtState {
     bool have_aclint;
     RISCVVirtAIAType aia_type;
     int aia_guests;
+    bool have_wg;
     char *oem_id;
     char *oem_table_id;
     OnOffAuto acpi;
@@ -88,11 +89,17 @@ enum {
     VIRT_PLATFORM_BUS,
     VIRT_PCIE_ECAM,
     VIRT_IOMMU_SYS,
+    VIRT_WGC_DRAM,
+    VIRT_WGC_FLASH,
+    VIRT_WGC_UART
 };
 
 enum {
     UART0_IRQ = 10,
     RTC_IRQ = 11,
+    WGC_DRAM_IRQ = 15,
+    WGC_FLASH_IRQ = 16,
+    WGC_UART_IRQ = 17,
     VIRTIO_IRQ = 1, /* 1 to 8 */
     VIRTIO_COUNT = 8,
     PCIE_IRQ = 0x20, /* 32 to 35 */
@@ -103,7 +110,7 @@ enum {
 #define VIRT_PLATFORM_BUS_NUM_IRQS 32
 
 #define VIRT_IRQCHIP_NUM_MSIS 255
-#define VIRT_IRQCHIP_NUM_SOURCES 96
+#define VIRT_IRQCHIP_NUM_SOURCES 128
 #define VIRT_IRQCHIP_NUM_PRIO_BITS 3
 #define VIRT_IRQCHIP_MAX_GUESTS_BITS 3
 #define VIRT_IRQCHIP_MAX_GUESTS ((1U << VIRT_IRQCHIP_MAX_GUESTS_BITS) - 1U)
@@ -159,4 +166,10 @@ uint32_t imsic_num_bits(uint32_t count);
 #error "Can't accommodate all IMSIC groups in address space"
 #endif
 
+/* WorldGuard */
+#define VIRT_WG_NWORLDS         4
+#define VIRT_WG_TRUSTEDWID      3
+#define VIRT_WG_HWBYPASS        true
+#define VIRT_WG_TZCOMPAT        false
+
 #endif
-- 
2.43.0


