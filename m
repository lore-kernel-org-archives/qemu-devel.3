Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9398ED5AE6A
	for <qemu-devel@archiver.kernel.org>; Thu,  7 Nov 2024 06:32:56 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t8w3i-0005My-76; Thu, 07 Nov 2024 01:31:58 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jim.shu@sifive.com>)
 id 1t8w3Y-0005MH-SA
 for qemu-devel@nongnu.org; Thu, 07 Nov 2024 01:31:48 -0500
Received: from mail-pj1-x1033.google.com ([2607:f8b0:4864:20::1033])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <jim.shu@sifive.com>)
 id 1t8w3W-0007qV-4O
 for qemu-devel@nongnu.org; Thu, 07 Nov 2024 01:31:48 -0500
Received: by mail-pj1-x1033.google.com with SMTP id
 98e67ed59e1d1-2e2eb9dde40so492874a91.0
 for <qemu-devel@nongnu.org>; Wed, 06 Nov 2024 22:31:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sifive.com; s=google; t=1730961104; x=1731565904; darn=nongnu.org;
 h=references:in-reply-to:message-id:date:subject:cc:to:from:from:to
 :cc:subject:date:message-id:reply-to;
 bh=LRh+kadq7Arou0CTyZ7Il6Vlyy7+excVt2m13uei05Q=;
 b=ZrUZZXJF9kW6OCBtBzaQWdj2/SYuKUc+98ldikko0EtkbO1y7AJ+AmD0JmWQmr+9jn
 afTcMVtUSrEtG2yMHrVP4Id8NKdXrlYKDj2z9tRXeWwefs9mgUyrG4bJqkLTQLuhSkKw
 6DprurG+z+rBrUIT9/LcDPdKQcV1cyQohASS5Ad1D8ODpuE6GZVHgQto1eWPCgURIYV6
 /hm0ONu6c6ek8GuTEf8EeXPrQDn4HMprz9FxD6cPe+fw8uq7vABsTSLSA11Q3dFECyxn
 dj917r32YQ+39bFnP+PU867AhWggCC+qgQ5F124r03I5/EiGBhsu5sG2hmYlysOaEBHb
 mbhg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1730961104; x=1731565904;
 h=references:in-reply-to:message-id:date:subject:cc:to:from
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=LRh+kadq7Arou0CTyZ7Il6Vlyy7+excVt2m13uei05Q=;
 b=tPrZ5VvzZDrqjL9onGEJqTgFrQj7qt9iZEx6zn7Qy37YlTBfcL4Vjxa+rzx8dZ8C+d
 DXjDLm7NcoIFzDY/8tRL6LvgC7vKzD7914IVPlwZ26dTD4y/j/ropXFHI9IZ2BuKE7Q4
 5ko7uagCG6ywPouz8mRmMIdz4NpJWq/CuFdsTjNsIqRCl5aFgG7KRv5TPjP2lctYVg2l
 Zv+zi9NuS779azKz5srGrWryOgvnjfvqs+GCDjys5hVuMtxLWiAn/bA3udvkhFu4BPdz
 zgF3FyPvuH3OTJRElIxjtcDCc8hcyb8hb8QT/b6bAAwfcWokfKEYBTn4Xg7pDcjQY2Of
 fvwA==
X-Gm-Message-State: AOJu0YzQmD7uI7vl7F2WPrPQtSptvMFqvFWMVfvg22g4qRSx5mbD+GYe
 kzJiHPAVoznTrFzK9rcURXQeNtIroEhHAxFS5ioisIx1xAGPkJPqHVLVL0YzM/jbYX6mth5jWWP
 dIYvTeLGTlix4kKhNxgi4z1oqPXtvRWT8fOZRW/T+37mcCyebUanJAQEANDD8cvRELFVor33ZR2
 nL5YF0b7l2xDgdPuzXryx692/bKt8wkpoihg==
X-Google-Smtp-Source: AGHT+IFtPMkOepw0VL9lpjOX2ShLXOhUQWlESznjE8J8RG5GPwwqvdYAxMusMoRt3Macy+bvjWphcQ==
X-Received: by 2002:a17:90b:3c01:b0:2e2:d821:1b78 with SMTP id
 98e67ed59e1d1-2e9aaa83c1emr65529a91.0.1730961104161; 
 Wed, 06 Nov 2024 22:31:44 -0800 (PST)
Received: from hsinchu26.internal.sifive.com
 (59-124-168-89.hinet-ip.hinet.net. [59.124.168.89])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-21177dc7cf8sm4995665ad.34.2024.11.06.22.31.42
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 06 Nov 2024 22:31:43 -0800 (PST)
From: Jim Shu <jim.shu@sifive.com>
To: qemu-devel@nongnu.org,
	qemu-riscv@nongnu.org
Cc: Palmer Dabbelt <palmer@dabbelt.com>,
 Alistair Francis <alistair.francis@wdc.com>, Bin Meng <bmeng.cn@gmail.com>,
 Weiwei Li <liwei1518@gmail.com>,
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>,
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>, Jim Shu <jim.shu@sifive.com>
Subject: [PATCH v2 2/3] hw/riscv: Add a new struct RISCVBootInfo
Date: Thu,  7 Nov 2024 14:31:32 +0800
Message-Id: <20241107063133.28339-3-jim.shu@sifive.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20241107063133.28339-1-jim.shu@sifive.com>
References: <20241107063133.28339-1-jim.shu@sifive.com>
Received-SPF: pass client-ip=2607:f8b0:4864:20::1033;
 envelope-from=jim.shu@sifive.com; helo=mail-pj1-x1033.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
 hw/riscv/boot.c                    | 66 ++++++++++++++++++------------
 hw/riscv/microchip_pfsoc.c         | 11 ++---
 hw/riscv/opentitan.c               |  4 +-
 hw/riscv/sifive_e.c                |  4 +-
 hw/riscv/sifive_u.c                | 12 +++---
 hw/riscv/spike.c                   | 12 +++---
 hw/riscv/virt.c                    | 13 +++---
 include/hw/riscv/boot.h            | 25 +++++++----
 include/hw/riscv/microchip_pfsoc.h |  2 +
 include/hw/riscv/opentitan.h       |  2 +
 include/hw/riscv/sifive_e.h        |  2 +
 include/hw/riscv/sifive_u.h        |  2 +
 include/hw/riscv/spike.h           |  2 +
 include/hw/riscv/virt.h            |  2 +
 14 files changed, 97 insertions(+), 62 deletions(-)

diff --git a/hw/riscv/boot.c b/hw/riscv/boot.c
index 4e4e106a2b..e5bd54bd73 100644
--- a/hw/riscv/boot.c
+++ b/hw/riscv/boot.c
@@ -67,9 +67,16 @@ char *riscv_plic_hart_config_string(int hart_count)
     return g_strjoinv(",", (char **)vals);
 }
 
-target_ulong riscv_calc_kernel_start_addr(RISCVHartArrayState *harts,
+void riscv_boot_info_init(RISCVBootInfo *info, RISCVHartArrayState *harts)
+{
+    info->kernel_size = 0;
+    info->initrd_size = 0;
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
@@ -175,7 +182,7 @@ target_ulong riscv_load_firmware(const char *firmware_filename,
     exit(1);
 }
 
-static void riscv_load_initrd(MachineState *machine, uint64_t kernel_entry)
+static void riscv_load_initrd(MachineState *machine, RISCVBootInfo *info)
 {
     const char *filename = machine->initrd_filename;
     uint64_t mem_size = machine->ram_size;
@@ -196,7 +203,7 @@ static void riscv_load_initrd(MachineState *machine, uint64_t kernel_entry)
      * halfway into RAM, and for boards with 1GB of RAM or more we put
      * the initrd at 512MB.
      */
-    start = kernel_entry + MIN(mem_size / 2, 512 * MiB);
+    start = info->image_low_addr + MIN(mem_size / 2, 512 * MiB);
 
     size = load_ramdisk(filename, start, mem_size - start);
     if (size == -1) {
@@ -215,14 +222,14 @@ static void riscv_load_initrd(MachineState *machine, uint64_t kernel_entry)
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
@@ -234,21 +241,28 @@ target_ulong riscv_load_kernel(MachineState *machine,
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
 
@@ -257,23 +271,21 @@ target_ulong riscv_load_kernel(MachineState *machine,
 
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
@@ -293,7 +305,7 @@ out:
  * The FDT is fdt_packed() during the calculation.
  */
 uint64_t riscv_compute_fdt_addr(hwaddr dram_base, hwaddr dram_size,
-                                MachineState *ms, RISCVHartArrayState *harts)
+                                MachineState *ms, RISCVBootInfo *info)
 {
     int ret = fdt_pack(ms->fdt);
     hwaddr dram_end, temp;
@@ -321,7 +333,7 @@ uint64_t riscv_compute_fdt_addr(hwaddr dram_base, hwaddr dram_size,
      * Thus, put it at an 2MB aligned address that less than fdt size from the
      * end of dram or 3GB whichever is lesser.
      */
-    if (!riscv_is_32bit(harts)) {
+    if (!info->is_32bit) {
         temp = dram_end;
     } else {
         temp = (dram_base < 3072 * MiB) ? MIN(dram_end, 3072 * MiB) : dram_end;
diff --git a/hw/riscv/microchip_pfsoc.c b/hw/riscv/microchip_pfsoc.c
index ba8b0a2c26..1fade7988a 100644
--- a/hw/riscv/microchip_pfsoc.c
+++ b/hw/riscv/microchip_pfsoc.c
@@ -46,7 +46,6 @@
 #include "hw/cpu/cluster.h"
 #include "target/riscv/cpu.h"
 #include "hw/misc/unimp.h"
-#include "hw/riscv/boot.h"
 #include "hw/riscv/riscv_hart.h"
 #include "hw/riscv/microchip_pfsoc.h"
 #include "hw/intc/riscv_aclint.h"
@@ -615,17 +614,19 @@ static void microchip_icicle_kit_machine_init(MachineState *machine)
     firmware_end_addr = riscv_find_and_load_firmware(machine, firmware_name,
                                                      &firmware_load_addr, NULL);
 
+    riscv_boot_info_init(&s->soc.boot_info, &s->soc.u_cpus);
     if (kernel_as_payload) {
-        kernel_start_addr = riscv_calc_kernel_start_addr(&s->soc.u_cpus,
+        kernel_start_addr = riscv_calc_kernel_start_addr(&s->soc.boot_info,
                                                          firmware_end_addr);
 
-        kernel_entry = riscv_load_kernel(machine, &s->soc.u_cpus,
-                                         kernel_start_addr, true, NULL);
+        riscv_load_kernel(machine, &s->soc.boot_info, kernel_start_addr,
+                          true, NULL);
+        kernel_entry = s->soc.boot_info.image_low_addr;
 
         /* Compute the fdt load address in dram */
         fdt_load_addr = riscv_compute_fdt_addr(memmap[MICROCHIP_PFSOC_DRAM_LO].base,
                                                memmap[MICROCHIP_PFSOC_DRAM_LO].size,
-                                               machine, &s->soc.u_cpus);
+                                               machine, &s->soc.boot_info);
         riscv_load_fdt(fdt_load_addr, machine->fdt);
 
         /* Load the reset vector */
diff --git a/hw/riscv/opentitan.c b/hw/riscv/opentitan.c
index e2830e9dc2..8478807f09 100644
--- a/hw/riscv/opentitan.c
+++ b/hw/riscv/opentitan.c
@@ -25,7 +25,6 @@
 #include "qemu/error-report.h"
 #include "hw/boards.h"
 #include "hw/misc/unimp.h"
-#include "hw/riscv/boot.h"
 #include "qemu/units.h"
 #include "sysemu/sysemu.h"
 
@@ -102,8 +101,9 @@ static void opentitan_machine_init(MachineState *machine)
         riscv_load_firmware(machine->firmware, &firmware_load_addr, NULL);
     }
 
+    riscv_boot_info_init(&s->soc.boot_info, &s->soc.cpus);
     if (machine->kernel_filename) {
-        riscv_load_kernel(machine, &s->soc.cpus,
+        riscv_load_kernel(machine, &s->soc.boot_info,
                           memmap[IBEX_DEV_RAM].base,
                           false, NULL);
     }
diff --git a/hw/riscv/sifive_e.c b/hw/riscv/sifive_e.c
index 5a1959f2a9..fbc330ef51 100644
--- a/hw/riscv/sifive_e.c
+++ b/hw/riscv/sifive_e.c
@@ -39,7 +39,6 @@
 #include "target/riscv/cpu.h"
 #include "hw/riscv/riscv_hart.h"
 #include "hw/riscv/sifive_e.h"
-#include "hw/riscv/boot.h"
 #include "hw/char/sifive_uart.h"
 #include "hw/intc/riscv_aclint.h"
 #include "hw/intc/sifive_plic.h"
@@ -113,8 +112,9 @@ static void sifive_e_machine_init(MachineState *machine)
     rom_add_blob_fixed_as("mrom.reset", reset_vec, sizeof(reset_vec),
                           memmap[SIFIVE_E_DEV_MROM].base, &address_space_memory);
 
+    riscv_boot_info_init(&s->soc.boot_info, &s->soc.cpus);
     if (machine->kernel_filename) {
-        riscv_load_kernel(machine, &s->soc.cpus,
+        riscv_load_kernel(machine, &s->soc.boot_info,
                           memmap[SIFIVE_E_DEV_DTIM].base,
                           false, NULL);
     }
diff --git a/hw/riscv/sifive_u.c b/hw/riscv/sifive_u.c
index 05467e833a..c7fe2eaba0 100644
--- a/hw/riscv/sifive_u.c
+++ b/hw/riscv/sifive_u.c
@@ -50,7 +50,6 @@
 #include "target/riscv/cpu.h"
 #include "hw/riscv/riscv_hart.h"
 #include "hw/riscv/sifive_u.h"
-#include "hw/riscv/boot.h"
 #include "hw/char/sifive_uart.h"
 #include "hw/intc/riscv_aclint.h"
 #include "hw/intc/sifive_plic.h"
@@ -590,12 +589,13 @@ static void sifive_u_machine_init(MachineState *machine)
     firmware_end_addr = riscv_find_and_load_firmware(machine, firmware_name,
                                                      &start_addr, NULL);
 
+    riscv_boot_info_init(&s->soc.boot_info, &s->soc.u_cpus);
     if (machine->kernel_filename) {
-        kernel_start_addr = riscv_calc_kernel_start_addr(&s->soc.u_cpus,
+        kernel_start_addr = riscv_calc_kernel_start_addr(&s->soc.boot_info,
                                                          firmware_end_addr);
-
-        kernel_entry = riscv_load_kernel(machine, &s->soc.u_cpus,
-                                         kernel_start_addr, true, NULL);
+        riscv_load_kernel(machine, &s->soc.boot_info, kernel_start_addr,
+                          true, NULL);
+        kernel_entry = s->soc.boot_info.image_low_addr;
     } else {
        /*
         * If dynamic firmware is used, it doesn't know where is the next mode
@@ -606,7 +606,7 @@ static void sifive_u_machine_init(MachineState *machine)
 
     fdt_load_addr = riscv_compute_fdt_addr(memmap[SIFIVE_U_DEV_DRAM].base,
                                            memmap[SIFIVE_U_DEV_DRAM].size,
-                                           machine, &s->soc.u_cpus);
+                                           machine, &s->soc.boot_info);
     riscv_load_fdt(fdt_load_addr, machine->fdt);
 
     if (!riscv_is_32bit(&s->soc.u_cpus)) {
diff --git a/hw/riscv/spike.c b/hw/riscv/spike.c
index acd7ab1ae1..9bd4c23c53 100644
--- a/hw/riscv/spike.c
+++ b/hw/riscv/spike.c
@@ -31,7 +31,6 @@
 #include "target/riscv/cpu.h"
 #include "hw/riscv/riscv_hart.h"
 #include "hw/riscv/spike.h"
-#include "hw/riscv/boot.h"
 #include "hw/riscv/numa.h"
 #include "hw/char/riscv_htif.h"
 #include "hw/intc/riscv_aclint.h"
@@ -300,13 +299,14 @@ static void spike_board_init(MachineState *machine)
     create_fdt(s, memmap, riscv_is_32bit(&s->soc[0]), htif_custom_base);
 
     /* Load kernel */
+    riscv_boot_info_init(&s->boot_info, &s->soc[0]);
     if (machine->kernel_filename) {
-        kernel_start_addr = riscv_calc_kernel_start_addr(&s->soc[0],
+        kernel_start_addr = riscv_calc_kernel_start_addr(&s->boot_info,
                                                          firmware_end_addr);
 
-        kernel_entry = riscv_load_kernel(machine, &s->soc[0],
-                                         kernel_start_addr,
-                                         true, htif_symbol_callback);
+        riscv_load_kernel(machine, &s->boot_info, kernel_start_addr,
+                          true, htif_symbol_callback);
+        kernel_entry = s->boot_info.image_low_addr;
     } else {
        /*
         * If dynamic firmware is used, it doesn't know where is the next mode
@@ -317,7 +317,7 @@ static void spike_board_init(MachineState *machine)
 
     fdt_load_addr = riscv_compute_fdt_addr(memmap[SPIKE_DRAM].base,
                                            memmap[SPIKE_DRAM].size,
-                                           machine, &s->soc[0]);
+                                           machine, &s->boot_info);
     riscv_load_fdt(fdt_load_addr, machine->fdt);
 
     /* load the reset vector */
diff --git a/hw/riscv/virt.c b/hw/riscv/virt.c
index 761bce3304..40d2f8f8de 100644
--- a/hw/riscv/virt.c
+++ b/hw/riscv/virt.c
@@ -34,7 +34,6 @@
 #include "hw/riscv/riscv_hart.h"
 #include "hw/riscv/iommu.h"
 #include "hw/riscv/virt.h"
-#include "hw/riscv/boot.h"
 #include "hw/riscv/numa.h"
 #include "kvm/kvm_riscv.h"
 #include "hw/firmware/smbios.h"
@@ -1414,17 +1413,19 @@ static void virt_machine_done(Notifier *notifier, void *data)
         }
     }
 
+    riscv_boot_info_init(&s->boot_info, &s->soc[0]);
+
     if (machine->kernel_filename && !kernel_entry) {
-        kernel_start_addr = riscv_calc_kernel_start_addr(&s->soc[0],
+        kernel_start_addr = riscv_calc_kernel_start_addr(&s->boot_info,
                                                          firmware_end_addr);
-
-        kernel_entry = riscv_load_kernel(machine, &s->soc[0],
-                                         kernel_start_addr, true, NULL);
+        riscv_load_kernel(machine, &s->boot_info, kernel_start_addr,
+                          true, NULL);
+        kernel_entry = s->boot_info.image_low_addr;
     }
 
     fdt_load_addr = riscv_compute_fdt_addr(memmap[VIRT_DRAM].base,
                                            memmap[VIRT_DRAM].size,
-                                           machine, &s->soc[0]);
+                                           machine, &s->boot_info);
     riscv_load_fdt(fdt_load_addr, machine->fdt);
 
     /* load the reset vector */
diff --git a/include/hw/riscv/boot.h b/include/hw/riscv/boot.h
index 34a80c5ff4..719ee1fe5f 100644
--- a/include/hw/riscv/boot.h
+++ b/include/hw/riscv/boot.h
@@ -27,11 +27,20 @@
 #define RISCV32_BIOS_BIN    "opensbi-riscv32-generic-fw_dynamic.bin"
 #define RISCV64_BIOS_BIN    "opensbi-riscv64-generic-fw_dynamic.bin"
 
+typedef struct RISCVBootInfo {
+    ssize_t kernel_size;
+    uint64_t image_low_addr;
+    uint64_t image_high_addr;
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
diff --git a/include/hw/riscv/microchip_pfsoc.h b/include/hw/riscv/microchip_pfsoc.h
index daef086da6..2b774ff977 100644
--- a/include/hw/riscv/microchip_pfsoc.h
+++ b/include/hw/riscv/microchip_pfsoc.h
@@ -32,6 +32,7 @@
 #include "hw/net/cadence_gem.h"
 #include "hw/sd/cadence_sdhci.h"
 #include "hw/riscv/riscv_hart.h"
+#include "hw/riscv/boot.h"
 
 typedef struct MicrochipPFSoCState {
     /*< private >*/
@@ -56,6 +57,7 @@ typedef struct MicrochipPFSoCState {
     CadenceGEMState gem0;
     CadenceGEMState gem1;
     CadenceSDHCIState sdhci;
+    RISCVBootInfo boot_info;
 } MicrochipPFSoCState;
 
 #define TYPE_MICROCHIP_PFSOC    "microchip.pfsoc"
diff --git a/include/hw/riscv/opentitan.h b/include/hw/riscv/opentitan.h
index 609473d07b..f9bc4b2f82 100644
--- a/include/hw/riscv/opentitan.h
+++ b/include/hw/riscv/opentitan.h
@@ -26,6 +26,7 @@
 #include "hw/ssi/ibex_spi_host.h"
 #include "hw/boards.h"
 #include "qom/object.h"
+#include "hw/riscv/boot.h"
 
 #define TYPE_RISCV_IBEX_SOC "riscv.lowrisc.ibex.soc"
 OBJECT_DECLARE_SIMPLE_TYPE(LowRISCIbexSoCState, RISCV_IBEX_SOC)
@@ -46,6 +47,7 @@ struct LowRISCIbexSoCState {
     IbexUartState uart;
     IbexTimerState timer;
     IbexSPIHostState spi_host[OPENTITAN_NUM_SPI_HOSTS];
+    RISCVBootInfo boot_info;
 
     uint32_t resetvec;
 
diff --git a/include/hw/riscv/sifive_e.h b/include/hw/riscv/sifive_e.h
index 31180a680e..d2b7f16ad1 100644
--- a/include/hw/riscv/sifive_e.h
+++ b/include/hw/riscv/sifive_e.h
@@ -24,6 +24,7 @@
 #include "hw/gpio/sifive_gpio.h"
 #include "hw/misc/sifive_e_aon.h"
 #include "hw/boards.h"
+#include "hw/riscv/boot.h"
 
 #define TYPE_RISCV_E_SOC "riscv.sifive.e.soc"
 #define RISCV_E_SOC(obj) \
@@ -40,6 +41,7 @@ typedef struct SiFiveESoCState {
     SIFIVEGPIOState gpio;
     MemoryRegion xip_mem;
     MemoryRegion mask_rom;
+    RISCVBootInfo boot_info;
 } SiFiveESoCState;
 
 typedef struct SiFiveEState {
diff --git a/include/hw/riscv/sifive_u.h b/include/hw/riscv/sifive_u.h
index 0696f85942..2a183df89b 100644
--- a/include/hw/riscv/sifive_u.h
+++ b/include/hw/riscv/sifive_u.h
@@ -30,6 +30,7 @@
 #include "hw/misc/sifive_u_prci.h"
 #include "hw/ssi/sifive_spi.h"
 #include "hw/timer/sifive_pwm.h"
+#include "hw/riscv/boot.h"
 
 #define TYPE_RISCV_U_SOC "riscv.sifive.u.soc"
 #define RISCV_U_SOC(obj) \
@@ -53,6 +54,7 @@ typedef struct SiFiveUSoCState {
     SiFiveSPIState spi2;
     CadenceGEMState gem;
     SiFivePwmState pwm[2];
+    RISCVBootInfo boot_info;
 
     uint32_t serial;
     char *cpu_type;
diff --git a/include/hw/riscv/spike.h b/include/hw/riscv/spike.h
index 0c2a223763..f37b7e0381 100644
--- a/include/hw/riscv/spike.h
+++ b/include/hw/riscv/spike.h
@@ -22,6 +22,7 @@
 #include "hw/boards.h"
 #include "hw/riscv/riscv_hart.h"
 #include "hw/sysbus.h"
+#include "hw/riscv/boot.h"
 
 #define SPIKE_CPUS_MAX 8
 #define SPIKE_SOCKETS_MAX 8
@@ -37,6 +38,7 @@ struct SpikeState {
 
     /*< public >*/
     RISCVHartArrayState soc[SPIKE_SOCKETS_MAX];
+    RISCVBootInfo boot_info;
 };
 
 enum {
diff --git a/include/hw/riscv/virt.h b/include/hw/riscv/virt.h
index c0dc41ff9a..82a485145f 100644
--- a/include/hw/riscv/virt.h
+++ b/include/hw/riscv/virt.h
@@ -24,6 +24,7 @@
 #include "hw/sysbus.h"
 #include "hw/block/flash.h"
 #include "hw/intc/riscv_imsic.h"
+#include "hw/riscv/boot.h"
 
 #define VIRT_CPUS_MAX_BITS             9
 #define VIRT_CPUS_MAX                  (1 << VIRT_CPUS_MAX_BITS)
@@ -52,6 +53,7 @@ struct RISCVVirtState {
     DeviceState *irqchip[VIRT_SOCKETS_MAX];
     PFlashCFI01 *flash[2];
     FWCfgState *fw_cfg;
+    RISCVBootInfo boot_info;
 
     int fdt_size;
     bool have_aclint;
-- 
2.17.1


