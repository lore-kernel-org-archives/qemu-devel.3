Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A5E50C369AB
	for <qemu-devel@archiver.kernel.org>; Tue, 15 Apr 2025 08:21:08 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u4bSr-0002WY-BN; Tue, 15 Apr 2025 04:16:18 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jim.shu@sifive.com>)
 id 1u4bR5-0002Sm-Un
 for qemu-devel@nongnu.org; Tue, 15 Apr 2025 04:14:29 -0400
Received: from mail-pl1-x630.google.com ([2607:f8b0:4864:20::630])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <jim.shu@sifive.com>)
 id 1u4bR3-00028S-Dr
 for qemu-devel@nongnu.org; Tue, 15 Apr 2025 04:14:27 -0400
Received: by mail-pl1-x630.google.com with SMTP id
 d9443c01a7336-224191d92e4so50382805ad.3
 for <qemu-devel@nongnu.org>; Tue, 15 Apr 2025 01:14:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sifive.com; s=google; t=1744704864; x=1745309664; darn=nongnu.org;
 h=references:in-reply-to:message-id:date:subject:cc:to:from:from:to
 :cc:subject:date:message-id:reply-to;
 bh=mEHD4jqnQyx5yEVuX/6t/quqlcTWATx7qTJMr+KrQBg=;
 b=b/2/dB8tns3EJp8BQ+NbOSBaMobiTtQDmOFMzasQGpG3yCcvZNcwQ0kcqcHSQft4EL
 v6Qa2ThaC+Be51kEUWXZpzOLyjwulLqrTyEGWtfaWhc8+lfCwQkP1iMP7qKEVhPDzmIY
 MS0GavGgcoECumTL/sDOBpBsKNDyAq6qlNqmk5DJr682emOpoFM8EczN44bUYEcbCT2K
 9GjriDDf22nUDbg6V1F0ZwSH8vXvvc40wuLgj59rOTUG/6AkgALROlk2OudWYUaAKTkS
 g/r9ukNG9iygC7nxG8U3od7PoAYHqD5+B0kxRqjMnKmiv6IkVsThhDpn3F9VkQbmQZ62
 Pxbw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1744704864; x=1745309664;
 h=references:in-reply-to:message-id:date:subject:cc:to:from
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=mEHD4jqnQyx5yEVuX/6t/quqlcTWATx7qTJMr+KrQBg=;
 b=buJXNVwVWV8bUmJvPz57vXkPnzrLrDdpG1GSYidTrWuDj+5tutL9kGGDHBCTxwI5vU
 h6Yz1l9RMNvtYYkcQC3ln3xg4CtSf92GXo+Hz65qIg9zjkQ59WULho7nJfnDx+hXcVvR
 5L+bipel+KH7oqyLQsregB3xmyYUI0AMboe7l17B2fn5y6LfkggPkLQjYEqGNeS657OT
 MO7f878cJtmgX1vBR5VPj8AMeCcoRpZ6LUXmY3V/5yHT1msW5eHYLonIJEvtUUvMDExz
 +rovVEET3lOX0pn15lxqjOslEd1s+pzn8t146mtSotr/FT/m9VGzlfl1IRQNCOp92RF7
 gDaw==
X-Gm-Message-State: AOJu0YwLtN7XnTXAHbg6CtgCb0IxZOTPFf3E8vNXoheixruGhEhueS+E
 xXgNM+wXGbLpKF6QmLS+qLd76krtKOSSAfQBYKfTItPr/Q5QQUBgy3G8lYI/OajDgFXxDvGf7+X
 l3/UwpOE3P8Gqe23OH+Lw7kFpmnYst4g6ghcUwhW93pY4mzPmChZWTRn5ONB3Paql9kvxT1htEj
 agQCLv3AnLvDGWTcFxME/xmFN9oKTKe8Q6Wg==
X-Gm-Gg: ASbGncsnsl7GaoSInMc/JuIXBYZqlmjdXV4SzxUGeeLHj4SQqmB23OX+xA9gCoxpvcF
 kQcn4naKzKe1wkGPY24NQ/RsHm1zoilU6q1Bk9pt689hdNk60Nkxg1q/wYr9gYW6d5U1AT3Gh0b
 MhPRF4NOmspTqaWdqjRZpfA/ncDT2vshMXF7jDHh09wUx6b5ubzq+J8WB2MyHEUOT/ALRgSwKVr
 diLgCpkI6XO2DjjMuGW8vNaCNkqAokhn58ZtOvBnYbV6/kA6w4A5W5wAxqOwyeN+Uzrb0ekTQg8
 gX9I0zimgBOPVRAucBxyRIUvm7gFvM5jFuwfKiV8UK+je0lT0jVx021O/5JbfU0=
X-Google-Smtp-Source: AGHT+IG/dypEZsLi0EK8J0/rvTSc+51CbkW3LoLi14+8Tu+6+xVO7qZnxOuuvb9SniROnu+2mc+AUg==
X-Received: by 2002:a17:902:c40b:b0:223:88af:2c30 with SMTP id
 d9443c01a7336-22bea4b3c03mr172146135ad.16.1744704863348; 
 Tue, 15 Apr 2025 01:14:23 -0700 (PDT)
Received: from hsinchu26.internal.sifive.com ([210.176.154.34])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-22ac7c95cd1sm111082335ad.150.2025.04.15.01.14.17
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 15 Apr 2025 01:14:22 -0700 (PDT)
From: Jim Shu <jim.shu@sifive.com>
To: qemu-devel@nongnu.org,
	qemu-riscv@nongnu.org
Cc: Richard Henderson <richard.henderson@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>, Palmer Dabbelt <palmer@dabbelt.com>,
 Alistair Francis <alistair.francis@wdc.com>,
 Weiwei Li <liwei1518@gmail.com>,
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>,
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>,
 Eduardo Habkost <eduardo@habkost.net>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Yanan Wang <wangyanan55@huawei.com>, Zhao Liu <zhao1.liu@intel.com>,
 Peter Xu <peterx@redhat.com>, David Hildenbrand <david@redhat.com>,
 Michael Rolnik <mrolnik@gmail.com>, Helge Deller <deller@gmx.de>,
 Song Gao <gaosong@loongson.cn>, Laurent Vivier <laurent@vivier.eu>,
 "Edgar E. Iglesias" <edgar.iglesias@gmail.com>,
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
 qemu-ppc@nongnu.org (open list:PowerPC TCG CPUs),
 qemu-s390x@nongnu.org (open list:S390 TCG CPUs),
 Jim Shu <jim.shu@sifive.com>
Subject: [PATCH 17/17] hw/riscv: virt: Add WorldGuard support
Date: Tue, 15 Apr 2025 16:12:31 +0800
Message-Id: <20250415081231.21186-18-jim.shu@sifive.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20250415081231.21186-1-jim.shu@sifive.com>
References: <20250415081231.21186-1-jim.shu@sifive.com>
Received-SPF: pass client-ip=2607:f8b0:4864:20::630;
 envelope-from=jim.shu@sifive.com; helo=mail-pl1-x630.google.com
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
 hw/riscv/virt.c            | 163 ++++++++++++++++++++++++++++++++++++-
 include/hw/riscv/virt.h    |  15 +++-
 4 files changed, 195 insertions(+), 4 deletions(-)

diff --git a/docs/system/riscv/virt.rst b/docs/system/riscv/virt.rst
index 60850970ce..d2bc65f71c 100644
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
+  of CPUs, the M-mode WID of CPU (`mwid`) is set to the largest WID number,
+  and the authorized WID list of CPU (`mwidlist`) includes all WIDs. We can
+  modify the configuration of all CPUs via `x-mwid` and `x-mwidlist`
+  CPU options. There are 3 wgCheckers in the virt machine, which seperately
+  protects DRAM, FLASH, and UART. Default WG configuration on the virt machine
+  is enough to run the demo of dual OSes in the different worlds. For example,
+  running both Linux kernel and Secure OS (e.g. OP-TEE) in it's own world.
+
+  This option is restricted to the TCG accelerator.
+
 Running Linux kernel
 --------------------
 
diff --git a/hw/riscv/Kconfig b/hw/riscv/Kconfig
index e6a0ac1fa1..5c3e7b3479 100644
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
index e517002fdf..da873bc8b8 100644
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
     hwaddr flashsize = virt_memmap[VIRT_FLASH].size / 2;
     hwaddr flashbase = virt_memmap[VIRT_FLASH].base;
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
@@ -1426,6 +1472,71 @@ static void virt_build_smbios(RISCVVirtState *s)
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
@@ -1527,10 +1638,12 @@ static void virt_machine_done(Notifier *notifier, void *data)
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
 
@@ -1546,6 +1659,11 @@ static void virt_machine_init(MachineState *machine)
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
@@ -1673,6 +1791,10 @@ static void virt_machine_init(MachineState *machine)
     memory_region_add_subregion(system_memory, memmap[VIRT_DRAM].base,
         machine->ram);
 
+    if (tcg_enabled() && s->have_wg) {
+        wgc_append_child(&wgcinfo[WGC_DRAM], machine->ram, memmap[VIRT_DRAM].base);
+    }
+
     /* boot rom */
     memory_region_init_rom(mask_rom, NULL, "riscv_virt_board.mrom",
                            memmap[VIRT_MROM].size, &error_fatal);
@@ -1700,10 +1822,16 @@ static void virt_machine_init(MachineState *machine)
 
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
 
@@ -1712,7 +1840,16 @@ static void virt_machine_init(MachineState *machine)
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
@@ -1757,6 +1894,20 @@ static void virt_machine_instance_init(Object *obj)
     s->iommu_sys = ON_OFF_AUTO_AUTO;
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
@@ -1977,6 +2128,12 @@ static void virt_machine_class_init(ObjectClass *oc, void *data)
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
index 48a14bea2e..3a631a6a23 100644
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
@@ -87,11 +88,17 @@ enum {
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
@@ -102,7 +109,7 @@ enum {
 #define VIRT_PLATFORM_BUS_NUM_IRQS 32
 
 #define VIRT_IRQCHIP_NUM_MSIS 255
-#define VIRT_IRQCHIP_NUM_SOURCES 96
+#define VIRT_IRQCHIP_NUM_SOURCES 128
 #define VIRT_IRQCHIP_NUM_PRIO_BITS 3
 #define VIRT_IRQCHIP_MAX_GUESTS_BITS 3
 #define VIRT_IRQCHIP_MAX_GUESTS ((1U << VIRT_IRQCHIP_MAX_GUESTS_BITS) - 1U)
@@ -158,4 +165,10 @@ uint32_t imsic_num_bits(uint32_t count);
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


