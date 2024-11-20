Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 75D9DD711B4
	for <qemu-devel@archiver.kernel.org>; Wed, 20 Nov 2024 15:40:46 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tDmo6-0003cI-3v; Wed, 20 Nov 2024 10:39:54 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jim.shu@sifive.com>)
 id 1tDmo4-0003br-K5
 for qemu-devel@nongnu.org; Wed, 20 Nov 2024 10:39:52 -0500
Received: from mail-pf1-x42c.google.com ([2607:f8b0:4864:20::42c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <jim.shu@sifive.com>)
 id 1tDmo0-0005yl-V7
 for qemu-devel@nongnu.org; Wed, 20 Nov 2024 10:39:52 -0500
Received: by mail-pf1-x42c.google.com with SMTP id
 d2e1a72fcca58-71e681bc315so826794b3a.0
 for <qemu-devel@nongnu.org>; Wed, 20 Nov 2024 07:39:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sifive.com; s=google; t=1732117187; x=1732721987; darn=nongnu.org;
 h=references:in-reply-to:message-id:date:subject:cc:to:from:from:to
 :cc:subject:date:message-id:reply-to;
 bh=ghtiMfgdfdpzQLl0RmLoJwkUG2jk+Of0KC68GzXFYQE=;
 b=jFp8CPIrBNE1W5AQjGKlG0b+XGrQl21XyYlbDc1+lMBAbs18d6oRqZ6g3S9vO/uycB
 w2MrFA4TzKILGmy3u4/tuTQlbv9atgSidUCe5bZUZfxafiZBsPRQOPZkBE/rMgV9uB5g
 RVV4XGUGlY+FLh/lOi1HPlUsWx3TsFQVr+UwWrESHXGAPKVZiNuP8gbFUlQw4UhELH2Z
 QzvysJTjCaCvnZdP1aOF4ijOeQ3kwpLVR6hoKqX5+NjqMMGzo7P7CAl5HGMAKJUi/AVh
 cIqYxjqb3DAanLlkdh1SFo7QBeRVwUBsnptpaoWgp3mjTcI5Si0ZygR2mmK976P9HxCx
 VLLA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1732117187; x=1732721987;
 h=references:in-reply-to:message-id:date:subject:cc:to:from
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=ghtiMfgdfdpzQLl0RmLoJwkUG2jk+Of0KC68GzXFYQE=;
 b=elyzUysYQwf/2rcRDdh8oGPjJ/p/HXA4HlaSRKaT3E6rddM8GaU3KBxImmgOD75IHT
 Po1cam/JR3hQ+6u8ofLcgbSOQpAhojqYvUFgCeFbZzXUhZ32+F7syzIIrjqduOUFhJ6u
 6nFyxmAkPU1RZ4rdhlLBqdRoKOpDh9LLmTu00r5Tuj17a3Kx3g+Be4iai8GJ1xQjjUWa
 pwlTVZOBrAY4PSHTLA6x0a5YDuBdCD23ixcvWMHbOSWQSDMGjwSnNeSWjwGF0yagcECO
 DsPG+8dbIg+p2NLq9Syeo4+BiU+mDJDuJcdwp8ehdvM8psoXZ+KbqPYiwIwSpHB4Dhcf
 dIoQ==
X-Gm-Message-State: AOJu0YyIjM9v5cTYfO8/O7q2QoejxzPHcq+J8Gy2an7vXnuie/JMxH2L
 PnqchTpZ4sOxFd8rbK0TA7Y7hPQLekMwWZ60ruqa4Sw6AJHDMrNg9MmQ1rNNZ9eVOXLYUPghE+P
 TaZ0nGzzH0ZBlKFVCycleZEC3+zM46rRDenLIJOv6jBI8yctAqh2nU5lVTSKR0G2R8ns3JHI9Wi
 E78hjLo2S4gIMtGnd6V6RTSSdMODMsWoPomo0j
X-Google-Smtp-Source: AGHT+IHG8vK+leHSclb5hhEU/uOSE05pO7WO+2CMI8y3Q3tEDlQ6gAT5w6X85/vJKObshB6VOUk5jQ==
X-Received: by 2002:a05:6a00:1393:b0:724:67c6:99de with SMTP id
 d2e1a72fcca58-724af97a50amr13321473b3a.12.1732117185370; 
 Wed, 20 Nov 2024 07:39:45 -0800 (PST)
Received: from hsinchu26.internal.sifive.com
 (59-124-168-89.hinet-ip.hinet.net. [59.124.168.89])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-724bef8da6asm1838903b3a.123.2024.11.20.07.39.43
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 20 Nov 2024 07:39:45 -0800 (PST)
From: Jim Shu <jim.shu@sifive.com>
To: qemu-devel@nongnu.org,
	qemu-riscv@nongnu.org
Cc: Palmer Dabbelt <palmer@dabbelt.com>,
 Alistair Francis <alistair.francis@wdc.com>, Bin Meng <bmeng.cn@gmail.com>,
 Weiwei Li <liwei1518@gmail.com>,
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>,
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>, Jim Shu <jim.shu@sifive.com>
Subject: [PATCH v4 2/3] hw/riscv: Add a new struct RISCVBootInfo
Date: Wed, 20 Nov 2024 23:39:34 +0800
Message-Id: <20241120153935.24706-3-jim.shu@sifive.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20241120153935.24706-1-jim.shu@sifive.com>
References: <20241120153935.24706-1-jim.shu@sifive.com>
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

Add a new struct RISCVBootInfo to sync boot information between multiple
boot functions.

Signed-off-by: Jim Shu <jim.shu@sifive.com>
---
 hw/riscv/boot.c            | 65 ++++++++++++++++++++++----------------
 hw/riscv/microchip_pfsoc.c | 11 ++++---
 hw/riscv/opentitan.c       |  4 ++-
 hw/riscv/sifive_e.c        |  4 ++-
 hw/riscv/sifive_u.c        | 12 ++++---
 hw/riscv/spike.c           | 12 ++++---
 hw/riscv/virt.c            | 13 +++++---
 include/hw/riscv/boot.h    | 25 ++++++++++-----
 8 files changed, 90 insertions(+), 56 deletions(-)

diff --git a/hw/riscv/boot.c b/hw/riscv/boot.c
index d36d3a7104..81d27f935e 100644
--- a/hw/riscv/boot.c
+++ b/hw/riscv/boot.c
@@ -67,9 +67,15 @@ char *riscv_plic_hart_config_string(int hart_count)
     return g_strjoinv(",", (char **)vals);
 }
 
-target_ulong riscv_calc_kernel_start_addr(RISCVHartArrayState *harts,
+void riscv_boot_info_init(RISCVBootInfo *info, RISCVHartArrayState *harts)
+{
+    info->kernel_size = 0;
+    info->is_32bit = riscv_is_32bit(harts);
+}
+
+target_ulong riscv_calc_kernel_start_addr(RISCVBootInfo *info,
                                           target_ulong firmware_end_addr) {
-    if (riscv_is_32bit(harts)) {
+    if (info->is_32bit) {
         return QEMU_ALIGN_UP(firmware_end_addr, 4 * MiB);
     } else {
         return QEMU_ALIGN_UP(firmware_end_addr, 2 * MiB);
@@ -175,7 +181,7 @@ target_ulong riscv_load_firmware(const char *firmware_filename,
     exit(1);
 }
 
-static void riscv_load_initrd(MachineState *machine, uint64_t kernel_entry)
+static void riscv_load_initrd(MachineState *machine, RISCVBootInfo *info)
 {
     const char *filename = machine->initrd_filename;
     uint64_t mem_size = machine->ram_size;
@@ -196,7 +202,7 @@ static void riscv_load_initrd(MachineState *machine, uint64_t kernel_entry)
      * halfway into RAM, and for boards with 1GB of RAM or more we put
      * the initrd at 512MB.
      */
-    start = kernel_entry + MIN(mem_size / 2, 512 * MiB);
+    start = info->image_low_addr + MIN(mem_size / 2, 512 * MiB);
 
     size = load_ramdisk(filename, start, mem_size - start);
     if (size == -1) {
@@ -215,14 +221,14 @@ static void riscv_load_initrd(MachineState *machine, uint64_t kernel_entry)
     }
 }
 
-target_ulong riscv_load_kernel(MachineState *machine,
-                               RISCVHartArrayState *harts,
-                               target_ulong kernel_start_addr,
-                               bool load_initrd,
-                               symbol_fn_t sym_cb)
+void riscv_load_kernel(MachineState *machine,
+                       RISCVBootInfo *info,
+                       target_ulong kernel_start_addr,
+                       bool load_initrd,
+                       symbol_fn_t sym_cb)
 {
     const char *kernel_filename = machine->kernel_filename;
-    uint64_t kernel_load_base, kernel_entry;
+    ssize_t kernel_size;
     void *fdt = machine->fdt;
 
     g_assert(kernel_filename != NULL);
@@ -234,21 +240,28 @@ target_ulong riscv_load_kernel(MachineState *machine,
      * the (expected) load address load address. This allows kernels to have
      * separate SBI and ELF entry points (used by FreeBSD, for example).
      */
-    if (load_elf_ram_sym(kernel_filename, NULL, NULL, NULL,
-                         NULL, &kernel_load_base, NULL, NULL, 0,
-                         EM_RISCV, 1, 0, NULL, true, sym_cb) > 0) {
-        kernel_entry = kernel_load_base;
+    kernel_size = load_elf_ram_sym(kernel_filename, NULL, NULL, NULL, NULL,
+                                   &info->image_low_addr, &info->image_high_addr,
+                                   NULL, 0, EM_RISCV, 1, 0, NULL, true, sym_cb);
+    if (kernel_size > 0) {
+        info->kernel_size = kernel_size;
         goto out;
     }
 
-    if (load_uimage_as(kernel_filename, &kernel_entry, NULL, NULL,
-                       NULL, NULL, NULL) > 0) {
+    kernel_size = load_uimage_as(kernel_filename, &info->image_low_addr,
+                                 NULL, NULL, NULL, NULL, NULL);
+    if (kernel_size > 0) {
+        info->kernel_size = kernel_size;
+        info->image_high_addr = info->image_low_addr + kernel_size;
         goto out;
     }
 
-    if (load_image_targphys_as(kernel_filename, kernel_start_addr,
-                               current_machine->ram_size, NULL) > 0) {
-        kernel_entry = kernel_start_addr;
+    kernel_size = load_image_targphys_as(kernel_filename, kernel_start_addr,
+                                         current_machine->ram_size, NULL);
+    if (kernel_size > 0) {
+        info->kernel_size = kernel_size;
+        info->image_low_addr = kernel_start_addr;
+        info->image_high_addr = info->image_low_addr + kernel_size;
         goto out;
     }
 
@@ -257,23 +270,21 @@ target_ulong riscv_load_kernel(MachineState *machine,
 
 out:
     /*
-     * For 32 bit CPUs 'kernel_entry' can be sign-extended by
+     * For 32 bit CPUs 'image_low_addr' can be sign-extended by
      * load_elf_ram_sym().
      */
-    if (riscv_is_32bit(harts)) {
-        kernel_entry = extract64(kernel_entry, 0, 32);
+    if (info->is_32bit) {
+        info->image_low_addr = extract64(info->image_low_addr, 0, 32);
     }
 
     if (load_initrd && machine->initrd_filename) {
-        riscv_load_initrd(machine, kernel_entry);
+        riscv_load_initrd(machine, info);
     }
 
     if (fdt && machine->kernel_cmdline && *machine->kernel_cmdline) {
         qemu_fdt_setprop_string(fdt, "/chosen", "bootargs",
                                 machine->kernel_cmdline);
     }
-
-    return kernel_entry;
 }
 
 /*
@@ -293,7 +304,7 @@ out:
  * The FDT is fdt_packed() during the calculation.
  */
 uint64_t riscv_compute_fdt_addr(hwaddr dram_base, hwaddr dram_size,
-                                MachineState *ms, RISCVHartArrayState *harts)
+                                MachineState *ms, RISCVBootInfo *info)
 {
     int ret = fdt_pack(ms->fdt);
     hwaddr dram_end, temp;
@@ -321,7 +332,7 @@ uint64_t riscv_compute_fdt_addr(hwaddr dram_base, hwaddr dram_size,
      * Thus, put it near to the end of dram in RV64, and put it near to the end
      * of dram or 3GB whichever is lesser in RV32.
      */
-    if (!riscv_is_32bit(harts)) {
+    if (!info->is_32bit) {
         temp = dram_end;
     } else {
         temp = (dram_base < 3072 * MiB) ? MIN(dram_end, 3072 * MiB) : dram_end;
diff --git a/hw/riscv/microchip_pfsoc.c b/hw/riscv/microchip_pfsoc.c
index ba8b0a2c26..a302965b6d 100644
--- a/hw/riscv/microchip_pfsoc.c
+++ b/hw/riscv/microchip_pfsoc.c
@@ -521,6 +521,7 @@ static void microchip_icicle_kit_machine_init(MachineState *machine)
     uint64_t kernel_entry;
     uint64_t fdt_load_addr;
     DriveInfo *dinfo = drive_get(IF_SD, 0, 0);
+    RISCVBootInfo boot_info;
 
     /* Sanity check on RAM size */
     if (machine->ram_size < mc->default_ram_size) {
@@ -615,17 +616,19 @@ static void microchip_icicle_kit_machine_init(MachineState *machine)
     firmware_end_addr = riscv_find_and_load_firmware(machine, firmware_name,
                                                      &firmware_load_addr, NULL);
 
+    riscv_boot_info_init(&boot_info, &s->soc.u_cpus);
     if (kernel_as_payload) {
-        kernel_start_addr = riscv_calc_kernel_start_addr(&s->soc.u_cpus,
+        kernel_start_addr = riscv_calc_kernel_start_addr(&boot_info,
                                                          firmware_end_addr);
 
-        kernel_entry = riscv_load_kernel(machine, &s->soc.u_cpus,
-                                         kernel_start_addr, true, NULL);
+        riscv_load_kernel(machine, &boot_info, kernel_start_addr,
+                          true, NULL);
+        kernel_entry = boot_info.image_low_addr;
 
         /* Compute the fdt load address in dram */
         fdt_load_addr = riscv_compute_fdt_addr(memmap[MICROCHIP_PFSOC_DRAM_LO].base,
                                                memmap[MICROCHIP_PFSOC_DRAM_LO].size,
-                                               machine, &s->soc.u_cpus);
+                                               machine, &boot_info);
         riscv_load_fdt(fdt_load_addr, machine->fdt);
 
         /* Load the reset vector */
diff --git a/hw/riscv/opentitan.c b/hw/riscv/opentitan.c
index e2830e9dc2..57f899464b 100644
--- a/hw/riscv/opentitan.c
+++ b/hw/riscv/opentitan.c
@@ -81,6 +81,7 @@ static void opentitan_machine_init(MachineState *machine)
     OpenTitanState *s = OPENTITAN_MACHINE(machine);
     const MemMapEntry *memmap = ibex_memmap;
     MemoryRegion *sys_mem = get_system_memory();
+    RISCVBootInfo boot_info;
 
     if (machine->ram_size != mc->default_ram_size) {
         char *sz = size_to_str(mc->default_ram_size);
@@ -102,8 +103,9 @@ static void opentitan_machine_init(MachineState *machine)
         riscv_load_firmware(machine->firmware, &firmware_load_addr, NULL);
     }
 
+    riscv_boot_info_init(&boot_info, &s->soc.cpus);
     if (machine->kernel_filename) {
-        riscv_load_kernel(machine, &s->soc.cpus,
+        riscv_load_kernel(machine, &boot_info,
                           memmap[IBEX_DEV_RAM].base,
                           false, NULL);
     }
diff --git a/hw/riscv/sifive_e.c b/hw/riscv/sifive_e.c
index 5a1959f2a9..ebcd33ab95 100644
--- a/hw/riscv/sifive_e.c
+++ b/hw/riscv/sifive_e.c
@@ -78,6 +78,7 @@ static void sifive_e_machine_init(MachineState *machine)
     SiFiveEState *s = RISCV_E_MACHINE(machine);
     MemoryRegion *sys_mem = get_system_memory();
     int i;
+    RISCVBootInfo boot_info;
 
     if (machine->ram_size != mc->default_ram_size) {
         char *sz = size_to_str(mc->default_ram_size);
@@ -113,8 +114,9 @@ static void sifive_e_machine_init(MachineState *machine)
     rom_add_blob_fixed_as("mrom.reset", reset_vec, sizeof(reset_vec),
                           memmap[SIFIVE_E_DEV_MROM].base, &address_space_memory);
 
+    riscv_boot_info_init(&boot_info, &s->soc.cpus);
     if (machine->kernel_filename) {
-        riscv_load_kernel(machine, &s->soc.cpus,
+        riscv_load_kernel(machine, &boot_info,
                           memmap[SIFIVE_E_DEV_DTIM].base,
                           false, NULL);
     }
diff --git a/hw/riscv/sifive_u.c b/hw/riscv/sifive_u.c
index 05467e833a..0a77faaf6e 100644
--- a/hw/riscv/sifive_u.c
+++ b/hw/riscv/sifive_u.c
@@ -525,6 +525,7 @@ static void sifive_u_machine_init(MachineState *machine)
     BlockBackend *blk;
     DeviceState *flash_dev, *sd_dev, *card_dev;
     qemu_irq flash_cs, sd_cs;
+    RISCVBootInfo boot_info;
 
     /* Initialize SoC */
     object_initialize_child(OBJECT(machine), "soc", &s->soc, TYPE_RISCV_U_SOC);
@@ -590,12 +591,13 @@ static void sifive_u_machine_init(MachineState *machine)
     firmware_end_addr = riscv_find_and_load_firmware(machine, firmware_name,
                                                      &start_addr, NULL);
 
+    riscv_boot_info_init(&boot_info, &s->soc.u_cpus);
     if (machine->kernel_filename) {
-        kernel_start_addr = riscv_calc_kernel_start_addr(&s->soc.u_cpus,
+        kernel_start_addr = riscv_calc_kernel_start_addr(&boot_info,
                                                          firmware_end_addr);
-
-        kernel_entry = riscv_load_kernel(machine, &s->soc.u_cpus,
-                                         kernel_start_addr, true, NULL);
+        riscv_load_kernel(machine, &boot_info, kernel_start_addr,
+                          true, NULL);
+        kernel_entry = boot_info.image_low_addr;
     } else {
        /*
         * If dynamic firmware is used, it doesn't know where is the next mode
@@ -606,7 +608,7 @@ static void sifive_u_machine_init(MachineState *machine)
 
     fdt_load_addr = riscv_compute_fdt_addr(memmap[SIFIVE_U_DEV_DRAM].base,
                                            memmap[SIFIVE_U_DEV_DRAM].size,
-                                           machine, &s->soc.u_cpus);
+                                           machine, &boot_info);
     riscv_load_fdt(fdt_load_addr, machine->fdt);
 
     if (!riscv_is_32bit(&s->soc.u_cpus)) {
diff --git a/hw/riscv/spike.c b/hw/riscv/spike.c
index acd7ab1ae1..c3ad16d316 100644
--- a/hw/riscv/spike.c
+++ b/hw/riscv/spike.c
@@ -206,6 +206,7 @@ static void spike_board_init(MachineState *machine)
     char *soc_name;
     int i, base_hartid, hart_count;
     bool htif_custom_base = false;
+    RISCVBootInfo boot_info;
 
     /* Check socket count limit */
     if (SPIKE_SOCKETS_MAX < riscv_socket_count(machine)) {
@@ -300,13 +301,14 @@ static void spike_board_init(MachineState *machine)
     create_fdt(s, memmap, riscv_is_32bit(&s->soc[0]), htif_custom_base);
 
     /* Load kernel */
+    riscv_boot_info_init(&boot_info, &s->soc[0]);
     if (machine->kernel_filename) {
-        kernel_start_addr = riscv_calc_kernel_start_addr(&s->soc[0],
+        kernel_start_addr = riscv_calc_kernel_start_addr(&boot_info,
                                                          firmware_end_addr);
 
-        kernel_entry = riscv_load_kernel(machine, &s->soc[0],
-                                         kernel_start_addr,
-                                         true, htif_symbol_callback);
+        riscv_load_kernel(machine, &boot_info, kernel_start_addr,
+                          true, htif_symbol_callback);
+        kernel_entry = boot_info.image_low_addr;
     } else {
        /*
         * If dynamic firmware is used, it doesn't know where is the next mode
@@ -317,7 +319,7 @@ static void spike_board_init(MachineState *machine)
 
     fdt_load_addr = riscv_compute_fdt_addr(memmap[SPIKE_DRAM].base,
                                            memmap[SPIKE_DRAM].size,
-                                           machine, &s->soc[0]);
+                                           machine, &boot_info);
     riscv_load_fdt(fdt_load_addr, machine->fdt);
 
     /* load the reset vector */
diff --git a/hw/riscv/virt.c b/hw/riscv/virt.c
index 761bce3304..9190d1c3aa 100644
--- a/hw/riscv/virt.c
+++ b/hw/riscv/virt.c
@@ -1366,6 +1366,7 @@ static void virt_machine_done(Notifier *notifier, void *data)
     uint64_t fdt_load_addr;
     uint64_t kernel_entry = 0;
     BlockBackend *pflash_blk0;
+    RISCVBootInfo boot_info;
 
     /*
      * An user provided dtb must include everything, including
@@ -1414,17 +1415,19 @@ static void virt_machine_done(Notifier *notifier, void *data)
         }
     }
 
+    riscv_boot_info_init(&boot_info, &s->soc[0]);
+
     if (machine->kernel_filename && !kernel_entry) {
-        kernel_start_addr = riscv_calc_kernel_start_addr(&s->soc[0],
+        kernel_start_addr = riscv_calc_kernel_start_addr(&boot_info,
                                                          firmware_end_addr);
-
-        kernel_entry = riscv_load_kernel(machine, &s->soc[0],
-                                         kernel_start_addr, true, NULL);
+        riscv_load_kernel(machine, &boot_info, kernel_start_addr,
+                          true, NULL);
+        kernel_entry = boot_info.image_low_addr;
     }
 
     fdt_load_addr = riscv_compute_fdt_addr(memmap[VIRT_DRAM].base,
                                            memmap[VIRT_DRAM].size,
-                                           machine, &s->soc[0]);
+                                           machine, &boot_info);
     riscv_load_fdt(fdt_load_addr, machine->fdt);
 
     /* load the reset vector */
diff --git a/include/hw/riscv/boot.h b/include/hw/riscv/boot.h
index 34a80c5ff4..06b51ed086 100644
--- a/include/hw/riscv/boot.h
+++ b/include/hw/riscv/boot.h
@@ -27,11 +27,20 @@
 #define RISCV32_BIOS_BIN    "opensbi-riscv32-generic-fw_dynamic.bin"
 #define RISCV64_BIOS_BIN    "opensbi-riscv64-generic-fw_dynamic.bin"
 
+typedef struct RISCVBootInfo {
+    ssize_t kernel_size;
+    hwaddr image_low_addr;
+    hwaddr image_high_addr;
+
+    bool is_32bit;
+} RISCVBootInfo;
+
 bool riscv_is_32bit(RISCVHartArrayState *harts);
 
 char *riscv_plic_hart_config_string(int hart_count);
 
-target_ulong riscv_calc_kernel_start_addr(RISCVHartArrayState *harts,
+void riscv_boot_info_init(RISCVBootInfo *info, RISCVHartArrayState *harts);
+target_ulong riscv_calc_kernel_start_addr(RISCVBootInfo *info,
                                           target_ulong firmware_end_addr);
 target_ulong riscv_find_and_load_firmware(MachineState *machine,
                                           const char *default_machine_firmware,
@@ -43,13 +52,13 @@ char *riscv_find_firmware(const char *firmware_filename,
 target_ulong riscv_load_firmware(const char *firmware_filename,
                                  hwaddr *firmware_load_addr,
                                  symbol_fn_t sym_cb);
-target_ulong riscv_load_kernel(MachineState *machine,
-                               RISCVHartArrayState *harts,
-                               target_ulong firmware_end_addr,
-                               bool load_initrd,
-                               symbol_fn_t sym_cb);
-uint64_t riscv_compute_fdt_addr(hwaddr dram_start, uint64_t dram_size,
-                                MachineState *ms, RISCVHartArrayState *harts);
+void riscv_load_kernel(MachineState *machine,
+                       RISCVBootInfo *info,
+                       target_ulong kernel_start_addr,
+                       bool load_initrd,
+                       symbol_fn_t sym_cb);
+uint64_t riscv_compute_fdt_addr(hwaddr dram_base, hwaddr dram_size,
+                                MachineState *ms, RISCVBootInfo *info);
 void riscv_load_fdt(hwaddr fdt_addr, void *fdt);
 void riscv_setup_rom_reset_vec(MachineState *machine, RISCVHartArrayState *harts,
                                hwaddr saddr,
-- 
2.17.1


