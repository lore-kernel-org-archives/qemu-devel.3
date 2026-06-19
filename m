Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AF528CD98E6
	for <qemu-devel@archiver.kernel.org>; Fri, 19 Jun 2026 04:51:32 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1waRAY-0008PU-23; Fri, 19 Jun 2026 00:49:30 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <joel.stan@gmail.com>)
 id 1waRAK-0008Ld-9r
 for qemu-devel@nongnu.org; Fri, 19 Jun 2026 00:49:20 -0400
Received: from mail-pf1-x42e.google.com ([2607:f8b0:4864:20::42e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <joel.stan@gmail.com>)
 id 1waRAF-0005IG-EK
 for qemu-devel@nongnu.org; Fri, 19 Jun 2026 00:49:14 -0400
Received: by mail-pf1-x42e.google.com with SMTP id
 d2e1a72fcca58-842307472d4so748341b3a.0
 for <qemu-devel@nongnu.org>; Thu, 18 Jun 2026 21:49:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1781844550; x=1782449350; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:sender:from:to:cc:subject:date
 :message-id:reply-to;
 bh=pofCvfmJXowL3+y4/abJP1laSmSScTxPpd7HSYJEGzg=;
 b=kaarHmYv9By2mxMuF+DRhxe0xneIvrNjMQa5kAO1vAGupCUXvy3a4EyZWmCo2r183+
 xFLqlxLiFE3HrxKDHopo7RovNAVzah1hmo7bkE+8BLp9/NxF9zTw5daWNdzrBgXsPHXt
 OyWiH7cnVI3N6fNLrNhDKP+J1WdrHrVFqFurVkCzthblofQkvIGVjnOxtpBUVLj1z77Z
 HYlwbuKgARTHxxw4m8fwISd7GTOHGn5jH8pi+rtFG5wHUvQm0yv5HRg23OrF2j1RUCuN
 mMNx4efvGoUc2M3kc8BNL5q9M8eNCPDMhPqGQi3xWV8CP3NJBXzhtNtqlUz+8HJMPzJ7
 W9xg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1781844550; x=1782449350;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:sender:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=pofCvfmJXowL3+y4/abJP1laSmSScTxPpd7HSYJEGzg=;
 b=ZUowjtod3Cf1uuwKlkQV/m+xY7CQsgJ6wI0fvYXQiu3a+KjiBF99IV6coxV/fxpnTz
 TXjWOKzmhLax/AmYxNkL9LLAuH9QOAEf3I6ipyYT3GVvyC/x+GuFgyWFq3Jsf+vD2IcY
 3qJTbuZP80lqUcrwIU69r45XncaKnP/RA5CyZ7eeJltX3tZW0zinqF50jRivEATaubcE
 QbbBPDqornfdY+Ygd48Y6Qk/wtKcelF/fwZSo+ozFyHgfBZAEF/L1zUaYmcrfzI7mZHP
 ShbfkyvxUV7YDWomVQb8dvXkOTmZD37YXpi7/WMA+V1PMlwI4uppSsa8tV+y4TiP1lds
 GCWw==
X-Forwarded-Encrypted: i=1;
 AFNElJ8jc6vlSSFOGs4t4tGq6BHWtZhsAj2+hG26f0KJkBLsxwTtmPmVvoN7Oc0t7wx5/PVwUClr+r48C+q/@nongnu.org
X-Gm-Message-State: AOJu0YyYpXEniEwbW+oifkDSgfqUhdHY2Py7G/Bwg/zp5rf05Hku7vJ2
 Y8gYlmHvKthd9qmirFhS+ZdCkV02bxcRAM2xjvM8TdbcSDbs65p6kRuE
X-Gm-Gg: AfdE7cmi1eZz9908aIfZcBHL0zSd4sYYIfEpBZYHFnKDdOegaoZ0O11l28kikkJNcsH
 AX6awOThmE0+b5zjSuOmrQ/JbHaQegXNJSLt/dT3tPQUK4uHI2Lu6w3yYADk/oxLAHj2qafFfAD
 n1ZToRzq4fBlhP9Y2z9M2UNynhH4/CuD+vh/RxNnfCz0N5w5YboLxfH00tE/xI2hPyceAKnDU/4
 sTVZ6/cuZaUuOQHaXMHyOdqHniXDbfwp2I4uSovEfM6mXLEdXG+X0N02Kpj2HJKR2wetF0pG8bl
 sdzvTezYAYF73XaCykOCNqcnAODi09nfAJ4AnjuiQQct1sXevj6cTvWKWrC0Z7aXpqgkY3mNkud
 aUAZyEyK/bf/5xkrK0ugEx7uYmxcep24JLlDWEx3CJX7w5tvZfi/2oLp7W9HWUsYEwI8BxCS9n1
 zynePmKELCXok76sXV3w6sqsFUI+5G2CoiybGW1PajHp6eZWBVaJWyjHYTQ23vgosc3OR6JCdnF
 xO8uEX51Aopi94v3EvqhtguCSVLs3vUAlG8hISD2w==
X-Received: by 2002:a05:6a00:1d97:b0:842:2cda:7a9c with SMTP id
 d2e1a72fcca58-84550877479mr2063554b3a.29.1781844549674; 
 Thu, 18 Jun 2026 21:49:09 -0700 (PDT)
Received: from donnager-debian.. ([144.6.172.18])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-8455363da44sm870141b3a.8.2026.06.18.21.49.05
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 18 Jun 2026 21:49:09 -0700 (PDT)
From: Joel Stanley <joel@jms.id.au>
To: Alistair Francis <alistair.francis@wdc.com>,
	qemu-devel@nongnu.org
Cc: Nicholas Piggin <npiggin@gmail.com>,
 Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@mailo.com>,
 Chris Rauer <crauer@google.com>, Alano Song <alanosong@163.com>,
 Michael Ellerman <mpe@kernel.org>, Joel Stanley <jms@oss.tenstorrent.com>,
 Anirudh Srinivasan <asrinivasan@oss.tenstorrent.com>,
 Portia Stephens <portias@oss.tenstorrent.com>, qemu-riscv@nongnu.org
Subject: [PATCH v9 02/12] hw/riscv/boot: Account for discontiguous memory when
 loading firmware
Date: Fri, 19 Jun 2026 14:18:26 +0930
Message-ID: <20260619044838.1054677-3-joel@jms.id.au>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260619044838.1054677-1-joel@jms.id.au>
References: <20260619044838.1054677-1-joel@jms.id.au>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::42e;
 envelope-from=joel.stan@gmail.com; helo=mail-pf1-x42e.google.com
X-Spam_score_int: -16
X-Spam_score: -1.7
X-Spam_bar: -
X-Spam_report: (-1.7 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FORGED_FROMDOMAIN=0.001,
 FREEMAIL_FROM=0.001, HEADER_FROM_DIFFERENT_DOMAINS=0.249,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

From: Nicholas Piggin <npiggin@gmail.com>

This loads firmware into the first (low) memory range,
accounting for machines having discontiguous memory regions.

Reviewed-by: Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>
Reviewed-by: Alistair Francis <alistair.francis@wdc.com>
Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
Signed-off-by: Joel Stanley <joel@jms.id.au>
---
 include/hw/riscv/boot.h    |  5 ++++-
 hw/riscv/boot.c            | 18 ++++++++++++------
 hw/riscv/k230.c            |  8 ++++++--
 hw/riscv/microchip_pfsoc.c |  8 ++++++--
 hw/riscv/opentitan.c       |  6 ++++--
 hw/riscv/shakti_c.c        |  6 +++++-
 hw/riscv/sifive_u.c        |  6 ++++--
 hw/riscv/spike.c           |  6 ++++--
 hw/riscv/virt.c            |  7 ++++---
 hw/riscv/xiangshan_kmh.c   |  6 +++++-
 10 files changed, 54 insertions(+), 22 deletions(-)

diff --git a/include/hw/riscv/boot.h b/include/hw/riscv/boot.h
index 69c99a149613..4e7bd9a225ef 100644
--- a/include/hw/riscv/boot.h
+++ b/include/hw/riscv/boot.h
@@ -53,13 +53,16 @@ void riscv_boot_info_init_discontig_mem(RISCVBootInfo *info,
 vaddr riscv_calc_kernel_start_addr(RISCVBootInfo *info,
                                    hwaddr firmware_end_addr);
 hwaddr riscv_find_and_load_firmware(MachineState *machine,
+                                    RISCVBootInfo *info,
                                     const char *default_machine_firmware,
                                     hwaddr *firmware_load_addr,
                                     symbol_fn_t sym_cb);
 const char *riscv_default_firmware_name(RISCVHartArrayState *harts);
 char *riscv_find_firmware(const char *firmware_filename,
                           const char *default_machine_firmware);
-hwaddr riscv_load_firmware(const char *firmware_filename,
+hwaddr riscv_load_firmware(MachineState *machine,
+                           const RISCVBootInfo *info,
+                           const char *firmware_filename,
                            hwaddr *firmware_load_addr,
                            symbol_fn_t sym_cb);
 void riscv_load_kernel(MachineState *machine,
diff --git a/hw/riscv/boot.c b/hw/riscv/boot.c
index c8418f83f480..5e2dfa091a13 100644
--- a/hw/riscv/boot.c
+++ b/hw/riscv/boot.c
@@ -151,6 +151,7 @@ char *riscv_find_firmware(const char *firmware_filename,
 }
 
 hwaddr riscv_find_and_load_firmware(MachineState *machine,
+                                    RISCVBootInfo *info,
                                     const char *default_machine_firmware,
                                     hwaddr *firmware_load_addr,
                                     symbol_fn_t sym_cb)
@@ -163,7 +164,8 @@ hwaddr riscv_find_and_load_firmware(MachineState *machine,
 
     if (firmware_filename) {
         /* If not "none" load the firmware */
-        firmware_end_addr = riscv_load_firmware(firmware_filename,
+        firmware_end_addr = riscv_load_firmware(machine, info,
+                                                firmware_filename,
                                                 firmware_load_addr, sym_cb);
         g_free(firmware_filename);
     }
@@ -171,10 +173,13 @@ hwaddr riscv_find_and_load_firmware(MachineState *machine,
     return firmware_end_addr;
 }
 
-hwaddr riscv_load_firmware(const char *firmware_filename,
+hwaddr riscv_load_firmware(MachineState *machine,
+                           const RISCVBootInfo *info,
+                           const char *firmware_filename,
                            hwaddr *firmware_load_addr,
                            symbol_fn_t sym_cb)
 {
+    uint64_t mem_size = info->ram_low_size ?: machine->ram_size;
     uint64_t firmware_entry, firmware_end;
     ssize_t firmware_size;
 
@@ -203,7 +208,7 @@ hwaddr riscv_load_firmware(const char *firmware_filename,
 
     firmware_size = load_image_targphys_as(firmware_filename,
                                            *firmware_load_addr,
-                                           current_machine->ram_size, NULL,
+                                           mem_size, NULL,
                                            NULL);
 
     if (firmware_size > 0) {
@@ -218,7 +223,7 @@ hwaddr riscv_load_firmware(const char *firmware_filename,
 static void riscv_load_initrd(MachineState *machine, RISCVBootInfo *info)
 {
     const char *filename = machine->initrd_filename;
-    uint64_t mem_size = machine->ram_size;
+    uint64_t mem_size = info->ram_low_size ?: machine->ram_size;
     void *fdt = machine->fdt;
     hwaddr start, end;
     ssize_t size;
@@ -264,6 +269,7 @@ void riscv_load_kernel(MachineState *machine,
                        bool load_initrd,
                        symbol_fn_t sym_cb)
 {
+    uint64_t mem_size = info->ram_low_size ?: machine->ram_size;
     const char *kernel_filename = machine->kernel_filename;
     ssize_t kernel_size;
     void *fdt = machine->fdt;
@@ -295,7 +301,7 @@ void riscv_load_kernel(MachineState *machine,
     }
 
     kernel_size = load_image_targphys_as(kernel_filename, kernel_start_addr,
-                                         current_machine->ram_size, NULL, NULL);
+                                         mem_size, NULL, NULL);
     if (kernel_size > 0) {
         info->kernel_size = kernel_size;
         info->image_low_addr = kernel_start_addr;
@@ -391,7 +397,7 @@ uint64_t riscv_compute_fdt_addr(hwaddr dram_base, hwaddr dram_size,
     dtb_start = QEMU_ALIGN_DOWN(temp - fdtsize, 2 * MiB);
 
     if (dtb_start_limit && (dtb_start < dtb_start_limit)) {
-        error_report("No enough memory to place DTB after kernel/initrd");
+        error_report("Not enough memory to place DTB after kernel/initrd");
         exit(1);
     }
 
diff --git a/hw/riscv/k230.c b/hw/riscv/k230.c
index 502281c52cff..656f28190cd0 100644
--- a/hw/riscv/k230.c
+++ b/hw/riscv/k230.c
@@ -424,7 +424,8 @@ static void k230_direct_boot(K230MachineState *s, MachineState *machine)
 
     riscv_load_fdt(K230_DIRECT_DTB_ADDR, machine->fdt);
 
-    firmware_end_addr = riscv_find_and_load_firmware(machine, firmware_name,
+    firmware_end_addr = riscv_find_and_load_firmware(machine, &boot_info,
+                                                     firmware_name,
                                                      &start_addr, NULL);
     if (firmware_end_addr > K230_DIRECT_KERNEL_ADDR) {
         error_report("K230 firmware overlaps kernel address 0x%x",
@@ -442,13 +443,16 @@ static void k230_firmware_boot(K230MachineState *s, MachineState *machine)
 {
     const char *firmware_name = riscv_default_firmware_name(&s->soc.c908_cpu);
     hwaddr start_addr = memmap[K230_DEV_DDRC].base;
+    RISCVBootInfo boot_info = {0};
 
     if (machine->dtb || (machine->kernel_cmdline && *machine->kernel_cmdline)) {
         error_report("K230 firmware boot does not support -dtb or -append");
         exit(EXIT_FAILURE);
     }
 
-    riscv_find_and_load_firmware(machine, firmware_name, &start_addr, NULL);
+    riscv_boot_info_init(&boot_info, &s->soc.c908_cpu);
+    riscv_find_and_load_firmware(machine, &boot_info, firmware_name,
+                                 &start_addr, NULL);
 
     riscv_setup_rom_reset_vec(machine, &s->soc.c908_cpu, start_addr,
                               memmap[K230_DEV_BOOTROM].base,
diff --git a/hw/riscv/microchip_pfsoc.c b/hw/riscv/microchip_pfsoc.c
index 5e48a2970838..4017129c8304 100644
--- a/hw/riscv/microchip_pfsoc.c
+++ b/hw/riscv/microchip_pfsoc.c
@@ -619,18 +619,22 @@ static void microchip_icicle_kit_machine_init(MachineState *machine)
         firmware_load_addr = RESET_VECTOR;
     }
 
+    riscv_boot_info_init_discontig_mem(&boot_info, &s->soc.u_cpus,
+                                       memmap[MICROCHIP_PFSOC_DRAM_LO].base,
+                                       mem_low_size);
+
     /* Load the firmware if necessary */
     firmware_end_addr = firmware_load_addr;
     if (firmware_name) {
         char *filename = riscv_find_firmware(firmware_name, NULL);
         if (filename) {
-            firmware_end_addr = riscv_load_firmware(filename,
+            firmware_end_addr = riscv_load_firmware(machine, &boot_info,
+                                                    filename,
                                                     &firmware_load_addr, NULL);
             g_free(filename);
         }
     }
 
-    riscv_boot_info_init(&boot_info, &s->soc.u_cpus);
     if (machine->kernel_filename) {
         kernel_start_addr = riscv_calc_kernel_start_addr(&boot_info,
                                                          firmware_end_addr);
diff --git a/hw/riscv/opentitan.c b/hw/riscv/opentitan.c
index c8b2f028f237..5b2f33d5acac 100644
--- a/hw/riscv/opentitan.c
+++ b/hw/riscv/opentitan.c
@@ -100,12 +100,14 @@ static void opentitan_machine_init(MachineState *machine)
     memory_region_add_subregion(sys_mem,
         memmap[IBEX_DEV_RAM].base, machine->ram);
 
+    riscv_boot_info_init(&boot_info, &s->soc.cpus);
+
     if (machine->firmware) {
         hwaddr firmware_load_addr = memmap[IBEX_DEV_RAM].base;
-        riscv_load_firmware(machine->firmware, &firmware_load_addr, NULL);
+        riscv_load_firmware(machine, &boot_info, machine->firmware,
+                            &firmware_load_addr, NULL);
     }
 
-    riscv_boot_info_init(&boot_info, &s->soc.cpus);
     if (machine->kernel_filename) {
         riscv_load_kernel(machine, &boot_info,
                           memmap[IBEX_DEV_RAM].base,
diff --git a/hw/riscv/shakti_c.c b/hw/riscv/shakti_c.c
index b1823a312508..835b1f879b7f 100644
--- a/hw/riscv/shakti_c.c
+++ b/hw/riscv/shakti_c.c
@@ -46,6 +46,7 @@ static void shakti_c_machine_state_init(MachineState *mstate)
 {
     ShaktiCMachineState *sms = RISCV_SHAKTI_MACHINE(mstate);
     MemoryRegion *system_memory = get_system_memory();
+    RISCVBootInfo boot_info;
     hwaddr firmware_load_addr = shakti_c_memmap[SHAKTI_C_RAM].base;
 
     /* Initialize SoC */
@@ -58,8 +59,11 @@ static void shakti_c_machine_state_init(MachineState *mstate)
                                 shakti_c_memmap[SHAKTI_C_RAM].base,
                                 mstate->ram);
 
+    riscv_boot_info_init(&boot_info, &sms->soc.cpus);
+
     if (mstate->firmware) {
-        riscv_load_firmware(mstate->firmware, &firmware_load_addr, NULL);
+        riscv_load_firmware(mstate, &boot_info, mstate->firmware,
+                            &firmware_load_addr, NULL);
     }
 
     /* ROM reset vector */
diff --git a/hw/riscv/sifive_u.c b/hw/riscv/sifive_u.c
index 0c6e4204cbfd..ef3cc0ca4612 100644
--- a/hw/riscv/sifive_u.c
+++ b/hw/riscv/sifive_u.c
@@ -540,11 +540,13 @@ static void sifive_u_machine_init(MachineState *machine)
         break;
     }
 
+    riscv_boot_info_init(&boot_info, &s->soc.u_cpus);
+
     firmware_name = riscv_default_firmware_name(&s->soc.u_cpus);
-    firmware_end_addr = riscv_find_and_load_firmware(machine, firmware_name,
+    firmware_end_addr = riscv_find_and_load_firmware(machine, &boot_info,
+                                                     firmware_name,
                                                      &start_addr, NULL);
 
-    riscv_boot_info_init(&boot_info, &s->soc.u_cpus);
     if (machine->kernel_filename) {
         kernel_start_addr = riscv_calc_kernel_start_addr(&boot_info,
                                                          firmware_end_addr);
diff --git a/hw/riscv/spike.c b/hw/riscv/spike.c
index 4e60724c147f..9fde0faf39db 100644
--- a/hw/riscv/spike.c
+++ b/hw/riscv/spike.c
@@ -205,9 +205,12 @@ static void spike_board_init(MachineState *machine)
         }
     }
 
+    riscv_boot_info_init(&boot_info, &s->soc[0]);
+
     /* Load firmware */
     if (firmware_name) {
-        firmware_end_addr = riscv_load_firmware(firmware_name,
+        firmware_end_addr = riscv_load_firmware(machine, &boot_info,
+                                                firmware_name,
                                                 &firmware_load_addr,
                                                 htif_symbol_callback);
         g_free(firmware_name);
@@ -217,7 +220,6 @@ static void spike_board_init(MachineState *machine)
     create_fdt(s, memmap, riscv_is_32bit(&s->soc[0]), htif_custom_base);
 
     /* Load kernel */
-    riscv_boot_info_init(&boot_info, &s->soc[0]);
     if (machine->kernel_filename) {
         kernel_start_addr = riscv_calc_kernel_start_addr(&boot_info,
                                                          firmware_end_addr);
diff --git a/hw/riscv/virt.c b/hw/riscv/virt.c
index 33775a61fd95..3b716509c448 100644
--- a/hw/riscv/virt.c
+++ b/hw/riscv/virt.c
@@ -1327,7 +1327,10 @@ static void virt_machine_done(Notifier *notifier, void *data)
         }
     }
 
-    firmware_end_addr = riscv_find_and_load_firmware(machine, firmware_name,
+    riscv_boot_info_init(&boot_info, &s->soc[0]);
+
+    firmware_end_addr = riscv_find_and_load_firmware(machine, &boot_info,
+                                                     firmware_name,
                                                      &start_addr, NULL);
 
     pflash_blk0 = pflash_cfi01_get_blk(s->flash[0]);
@@ -1350,8 +1353,6 @@ static void virt_machine_done(Notifier *notifier, void *data)
         }
     }
 
-    riscv_boot_info_init(&boot_info, &s->soc[0]);
-
     if (machine->kernel_filename && !kernel_entry) {
         kernel_start_addr = riscv_calc_kernel_start_addr(&boot_info,
                                                          firmware_end_addr);
diff --git a/hw/riscv/xiangshan_kmh.c b/hw/riscv/xiangshan_kmh.c
index 76417ba7aba1..384624d69ad5 100644
--- a/hw/riscv/xiangshan_kmh.c
+++ b/hw/riscv/xiangshan_kmh.c
@@ -167,6 +167,7 @@ static void xiangshan_kmh_machine_init(MachineState *machine)
     const MemMapEntry *memmap = xiangshan_kmh_memmap;
     MemoryRegion *system_memory = get_system_memory();
     hwaddr start_addr = memmap[XIANGSHAN_KMH_DRAM].base;
+    RISCVBootInfo boot_info;
 
     /* Initialize SoC */
     object_initialize_child(OBJECT(machine), "soc", &s->soc,
@@ -178,13 +179,16 @@ static void xiangshan_kmh_machine_init(MachineState *machine)
                                 memmap[XIANGSHAN_KMH_DRAM].base,
                                 machine->ram);
 
+    riscv_boot_info_init(&boot_info, &s->soc.cpus);
+
     /* ROM reset vector */
     riscv_setup_rom_reset_vec(machine, &s->soc.cpus,
                               start_addr,
                               memmap[XIANGSHAN_KMH_ROM].base,
                               memmap[XIANGSHAN_KMH_ROM].size, 0, 0);
     if (machine->firmware) {
-        riscv_load_firmware(machine->firmware, &start_addr, NULL);
+        riscv_load_firmware(machine, &boot_info, machine->firmware,
+                            &start_addr, NULL);
     }
 
     /* Note: dtb has been integrated into firmware(OpenSBI) when compiling */
-- 
2.47.3


