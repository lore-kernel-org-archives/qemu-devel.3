Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1252BC27C53
	for <qemu-devel@archiver.kernel.org>; Wed, 12 Jun 2024 08:18:13 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sHJ9V-0005nL-Fg; Wed, 12 Jun 2024 04:16:17 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jim.shu@sifive.com>)
 id 1sHJ9U-0005eA-4i
 for qemu-devel@nongnu.org; Wed, 12 Jun 2024 04:16:16 -0400
Received: from mail-pl1-x630.google.com ([2607:f8b0:4864:20::630])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <jim.shu@sifive.com>)
 id 1sHJ9P-0006qm-Ar
 for qemu-devel@nongnu.org; Wed, 12 Jun 2024 04:16:15 -0400
Received: by mail-pl1-x630.google.com with SMTP id
 d9443c01a7336-1f70131063cso16961535ad.2
 for <qemu-devel@nongnu.org>; Wed, 12 Jun 2024 01:16:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sifive.com; s=google; t=1718180169; x=1718784969; darn=nongnu.org;
 h=references:in-reply-to:message-id:date:subject:cc:to:from:from:to
 :cc:subject:date:message-id:reply-to;
 bh=7Zs56IfQW4V8sqUEW1KobOHNpim94d18CajV+uj3sek=;
 b=iU64JaUXOpMTAeRp3dYWTrEaWAPX9MxC/5KwT9aQFYKYeUyR0x9FjvYhH+N/tbXcFC
 KJjBHzIR8c1YGSDbrVsx/zobqZhoVQQdkWfNYAiRkxeZRwqALZduk4GESaQM5BkCVwd8
 nkXzO567aml6DK9B3ABS8i+wRtjRD6gs1NO/GORqfwPwKDwifwvy17MBwPPFnDt4E7P/
 FyZ2RvmTSLnm2QS1y9ncXoQJAGxX67IutFKATEP6Xoi3+Gc1Fhd7U2RDsp8IHcjbIE5H
 kWq5LFIaor+lHNJTQbHqobHWXIIrGf01HhmLR4jFeb94WdzrKLOLjmqn1zHIpn4q+Hu1
 wbFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1718180169; x=1718784969;
 h=references:in-reply-to:message-id:date:subject:cc:to:from
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=7Zs56IfQW4V8sqUEW1KobOHNpim94d18CajV+uj3sek=;
 b=JczqtIUIrvhsjqDR4L7u5r0MXPDh0HzK+ciiGflFMIDa2mKmWYwUpI/InwhJZFnqnU
 EO3zMZ7OZRolCbdV0xr+pA2liVmJF/Wy8MgRNxeXc8jPJCmwhqtW+euOPpaaH1j5tFpW
 UvWhU0QPOT+lxFan2XjLw7QiFxJjYgcDSiWHEH9GHR9TVPT9zgtEJpka1pWlZDq1utwB
 yxEAx+YgjwEka1zV6TohxmXdJEy+AEOYgc/i0NdtzInuFn20HoRwYLvTEuCYz10Dwnke
 uofXaBFxXmTFYL+FoXghT3MNIABRWV5cRYd0UET6IDqPfd6h/brFInw28WoGvqQkbwRQ
 rgWQ==
X-Gm-Message-State: AOJu0Ywqb0qA/zecvr1Z4/bqC0Odq6Do3smg5LZK4zUnxbs6Tf1LKkKh
 xY0wQhddn6AnKr1pfBIDv1jpsjbbNutnUkieQtynd3WnwFpyY6kmAIvE+fv+MNgSMwtF04inuKT
 US69mz02fnDXi6zaX2ZKe2rCWk1bqDGn72bKojrmBgPX1uCU8vlXjiHWq2JU769dYPcdoaJa4kp
 PkpF+Ml4FtnY6P3J0jGzgQxMDWECmLAGTd/LuFUKNirw==
X-Google-Smtp-Source: AGHT+IFZI0uD97KN8S3AD0WaGGdqs9bMHQ35x0UNs/HsiXiPw2iJARhoCvv/DnkcypVwlwTRn0BWFQ==
X-Received: by 2002:a17:903:2283:b0:1f7:187f:cb5a with SMTP id
 d9443c01a7336-1f83b565eb1mr12729405ad.11.1718180168578; 
 Wed, 12 Jun 2024 01:16:08 -0700 (PDT)
Received: from hsinchu26.internal.sifive.com
 (59-124-168-89.hinet-ip.hinet.net. [59.124.168.89])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-1f8393e8e53sm11363875ad.16.2024.06.12.01.16.03
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 12 Jun 2024 01:16:08 -0700 (PDT)
From: Jim Shu <jim.shu@sifive.com>
To: qemu-devel@nongnu.org,
	qemu-riscv@nongnu.org
Cc: Richard Henderson <richard.henderson@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>, Palmer Dabbelt <palmer@dabbelt.com>,
 Alistair Francis <alistair.francis@wdc.com>, Bin Meng <bmeng.cn@gmail.com>,
 Weiwei Li <liwei1518@gmail.com>,
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>,
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>,
 Eduardo Habkost <eduardo@habkost.net>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Yanan Wang <wangyanan55@huawei.com>, Peter Xu <peterx@redhat.com>,
 David Hildenbrand <david@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 Michael Rolnik <mrolnik@gmail.com>,
 "Edgar E. Iglesias" <edgar.iglesias@gmail.com>,
 Song Gao <gaosong@loongson.cn>, Laurent Vivier <laurent@vivier.eu>,
 Aurelien Jarno <aurelien@aurel32.net>,
 Jiaxun Yang <jiaxun.yang@flygoat.com>,
 Aleksandar Rikalo <arikalo@gmail.com>, Stafford Horne <shorne@gmail.com>,
 Nicholas Piggin <npiggin@gmail.com>,
 Yoshinori Sato <ysato@users.sourceforge.jp>,
 Ilya Leoshkevich <iii@linux.ibm.com>, Thomas Huth <thuth@redhat.com>,
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
 Artyom Tarasenko <atar4qemu@gmail.com>,
 Bastian Koppelmann <kbastian@mail.uni-paderborn.de>,
 Max Filippov <jcmvbkbc@gmail.com>,
 qemu-arm@nongnu.org (open list:ARM TCG CPUs),
 qemu-ppc@nongnu.org (open list:PowerPC TCG CPUs),
 qemu-s390x@nongnu.org (open list:S390 TCG CPUs),
 Jim Shu <jim.shu@sifive.com>
Subject: [RFC PATCH 16/16] hw/riscv: virt: Add WorldGuard support
Date: Wed, 12 Jun 2024 16:14:16 +0800
Message-Id: <20240612081416.29704-17-jim.shu@sifive.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20240612081416.29704-1-jim.shu@sifive.com>
References: <20240612081416.29704-1-jim.shu@sifive.com>
Received-SPF: pass client-ip=2607:f8b0:4864:20::630;
 envelope-from=jim.shu@sifive.com; helo=mail-pl1-x630.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=unavailable autolearn_force=no
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
 docs/system/riscv/virt.rst |  10 +++
 hw/riscv/Kconfig           |   1 +
 hw/riscv/virt.c            | 163 ++++++++++++++++++++++++++++++++++++-
 include/hw/riscv/virt.h    |  17 +++-
 4 files changed, 186 insertions(+), 5 deletions(-)

diff --git a/docs/system/riscv/virt.rst b/docs/system/riscv/virt.rst
index 9a06f95a34..2d2992dc34 100644
--- a/docs/system/riscv/virt.rst
+++ b/docs/system/riscv/virt.rst
@@ -116,6 +116,16 @@ The following machine-specific options are supported:
   having AIA IMSIC (i.e. "aia=aplic-imsic" selected). When not specified,
   the default number of per-HART VS-level AIA IMSIC pages is 0.
 
+- wg=[on|off]
+
+  When this option is "on", RISC-V WorldGuard will be enabled in the system
+  to provide the isolation of multiple worlds. RISC-V HARTS will enable WG
+  extensions to have WID in memory transaction. wgCheckers in front of RAMs
+  and device MMIO will be enabled to provide the access control of resources
+  if the transaction contains WID. When not specified, this option is assumed
+  to be "off".
+  This option is restricted to the TCG accelerator.
+
 Running Linux kernel
 --------------------
 
diff --git a/hw/riscv/Kconfig b/hw/riscv/Kconfig
index a2030e3a6f..7804fdbb7a 100644
--- a/hw/riscv/Kconfig
+++ b/hw/riscv/Kconfig
@@ -56,6 +56,7 @@ config RISCV_VIRT
     select PLATFORM_BUS
     select ACPI
     select ACPI_PCI
+    select RISCV_WORLDGUARD
 
 config SHAKTI_C
     bool
diff --git a/hw/riscv/virt.c b/hw/riscv/virt.c
index 4fdb660525..eed49ebd02 100644
--- a/hw/riscv/virt.c
+++ b/hw/riscv/virt.c
@@ -55,6 +55,7 @@
 #include "hw/acpi/aml-build.h"
 #include "qapi/qapi-visit-common.h"
 #include "hw/virtio/virtio-iommu.h"
+#include "hw/misc/riscv_worldguard.h"
 
 /* KVM AIA only supports APLIC MSI. APLIC Wired is always emulated by QEMU. */
 static bool virt_use_kvm_aia(RISCVVirtState *s)
@@ -76,6 +77,9 @@ static const MemMapEntry virt_memmap[] = {
     [VIRT_ACLINT_SSWI] =  {  0x2F00000,        0x4000 },
     [VIRT_PCIE_PIO] =     {  0x3000000,       0x10000 },
     [VIRT_PLATFORM_BUS] = {  0x4000000,     0x2000000 },
+    [VIRT_WGC_DRAM] =     {  0x6000000,        0x1000 },
+    [VIRT_WGC_FLASH] =    {  0x6001000,        0x1000 },
+    [VIRT_WGC_UART] =     {  0x6002000,        0x1000 },
     [VIRT_PLIC] =         {  0xc000000, VIRT_PLIC_SIZE(VIRT_CPUS_MAX * 2) },
     [VIRT_APLIC_M] =      {  0xc000000, APLIC_SIZE(VIRT_CPUS_MAX) },
     [VIRT_APLIC_S] =      {  0xd000000, APLIC_SIZE(VIRT_CPUS_MAX) },
@@ -101,6 +105,38 @@ static MemMapEntry virt_high_pcie_memmap;
 
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
@@ -151,7 +187,8 @@ static void virt_flash_map1(PFlashCFI01 *flash,
 }
 
 static void virt_flash_map(RISCVVirtState *s,
-                           MemoryRegion *sysmem)
+                           MemoryRegion *sysmem,
+                           WGCInfo *info)
 {
     hwaddr flashsize = virt_memmap[VIRT_FLASH].size / 2;
     hwaddr flashbase = virt_memmap[VIRT_FLASH].base;
@@ -160,6 +197,15 @@ static void virt_flash_map(RISCVVirtState *s,
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
@@ -1303,6 +1349,71 @@ static void virt_build_smbios(RISCVVirtState *s)
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
+    for (int i=0; i<info->num_of_child; i++) {
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
+    for (int i=0; i<info->num_of_child; i++) {
+        upstream_mr = sysbus_mmio_get_region(SYS_BUS_DEVICE(wgc), i+1);
+        g_assert(upstream_mr);
+        memory_region_add_subregion(system_memory, info->c_offset[i], upstream_mr);
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
+    for (int i=0; i<wgc_num; i++) {
+        create_wgc(&wgcinfo[i], DEVICE(irqchip));
+    }
+}
+
 static void virt_machine_done(Notifier *notifier, void *data)
 {
     RISCVVirtState *s = container_of(notifier, RISCVVirtState,
@@ -1401,10 +1512,12 @@ static void virt_machine_done(Notifier *notifier, void *data)
 static void virt_machine_init(MachineState *machine)
 {
     const MemMapEntry *memmap = virt_memmap;
+    WGCInfo *wgcinfo = virt_wgcinfo;
     RISCVVirtState *s = RISCV_VIRT_MACHINE(machine);
     MemoryRegion *system_memory = get_system_memory();
     MemoryRegion *mask_rom = g_new(MemoryRegion, 1);
     DeviceState *mmio_irqchip, *virtio_irqchip, *pcie_irqchip;
+    SerialMM *uart;
     int i, base_hartid, hart_count;
     int socket_count = riscv_socket_count(machine);
 
@@ -1420,6 +1533,11 @@ static void virt_machine_init(MachineState *machine)
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
@@ -1547,6 +1665,10 @@ static void virt_machine_init(MachineState *machine)
     memory_region_add_subregion(system_memory, memmap[VIRT_DRAM].base,
         machine->ram);
 
+    if (tcg_enabled() && s->have_wg) {
+        wgc_append_child(&wgcinfo[WGC_DRAM], machine->ram, memmap[VIRT_DRAM].base);
+    }
+
     /* boot rom */
     memory_region_init_rom(mask_rom, NULL, "riscv_virt_board.mrom",
                            memmap[VIRT_MROM].size, &error_fatal);
@@ -1574,10 +1696,16 @@ static void virt_machine_init(MachineState *machine)
 
     create_platform_bus(s, mmio_irqchip);
 
-    serial_mm_init(system_memory, memmap[VIRT_UART0].base,
+    uart = serial_mm_init(system_memory, memmap[VIRT_UART0].base,
         0, qdev_get_gpio_in(mmio_irqchip, UART0_IRQ), 399193,
         serial_hd(0), DEVICE_LITTLE_ENDIAN);
 
+    if (tcg_enabled() && s->have_wg) {
+        wgc_append_child(&wgcinfo[WGC_UART],
+                         sysbus_mmio_get_region(SYS_BUS_DEVICE(uart), 0),
+                         memmap[VIRT_UART0].base);
+    }
+
     sysbus_create_simple("goldfish_rtc", memmap[VIRT_RTC].base,
         qdev_get_gpio_in(mmio_irqchip, RTC_IRQ));
 
@@ -1586,7 +1714,16 @@ static void virt_machine_init(MachineState *machine)
         pflash_cfi01_legacy_drive(s->flash[i],
                                   drive_get(IF_PFLASH, 0, i));
     }
-    virt_flash_map(s, system_memory);
+
+    if (tcg_enabled() && s->have_wg) {
+        virt_flash_map(s, system_memory, &wgcinfo[WGC_FLASH]);
+    } else {
+        virt_flash_map(s, system_memory, NULL);
+    }
+
+    if (tcg_enabled() && s->have_wg) {
+        virt_create_worldguard(wgcinfo, WGC_NUM, mmio_irqchip);
+    }
 
     /* load/create device tree */
     if (machine->dtb) {
@@ -1614,6 +1751,20 @@ static void virt_machine_instance_init(Object *obj)
     s->acpi = ON_OFF_AUTO_AUTO;
 }
 
+static bool virt_get_wg(Object *obj, Error **errp)
+{
+    RISCVVirtState *s = RISCV_VIRT_MACHINE(obj);
+
+    return s->have_wg;
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
@@ -1794,6 +1945,12 @@ static void virt_machine_class_init(ObjectClass *oc, void *data)
                               NULL, NULL);
     object_class_property_set_description(oc, "acpi",
                                           "Enable ACPI");
+
+    object_class_property_add_bool(oc, "wg", virt_get_wg,
+                                   virt_set_wg);
+    object_class_property_set_description(oc, "wg",
+                                              "Set on/off to enable/disable the "
+                                              "RISC-V WorldGuard.");
 }
 
 static const TypeInfo virt_machine_typeinfo = {
diff --git a/include/hw/riscv/virt.h b/include/hw/riscv/virt.h
index 3db839160f..4d78702daf 100644
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
@@ -84,12 +85,18 @@ enum {
     VIRT_PCIE_MMIO,
     VIRT_PCIE_PIO,
     VIRT_PLATFORM_BUS,
-    VIRT_PCIE_ECAM
+    VIRT_PCIE_ECAM,
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
@@ -99,7 +106,7 @@ enum {
 #define VIRT_PLATFORM_BUS_NUM_IRQS 32
 
 #define VIRT_IRQCHIP_NUM_MSIS 255
-#define VIRT_IRQCHIP_NUM_SOURCES 96
+#define VIRT_IRQCHIP_NUM_SOURCES 128
 #define VIRT_IRQCHIP_NUM_PRIO_BITS 3
 #define VIRT_IRQCHIP_MAX_GUESTS_BITS 3
 #define VIRT_IRQCHIP_MAX_GUESTS ((1U << VIRT_IRQCHIP_MAX_GUESTS_BITS) - 1U)
@@ -153,4 +160,10 @@ uint32_t imsic_num_bits(uint32_t count);
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
2.17.1


