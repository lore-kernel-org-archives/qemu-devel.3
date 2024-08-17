Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2802FC531DF
	for <qemu-devel@archiver.kernel.org>; Sat, 17 Aug 2024 00:55:42 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sf7iV-0005SQ-Ut; Fri, 16 Aug 2024 20:54:51 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <samuel.holland@sifive.com>)
 id 1sf7HY-00056W-EI
 for qemu-devel@nongnu.org; Fri, 16 Aug 2024 20:27:00 -0400
Received: from mail-oa1-x32.google.com ([2001:4860:4864:20::32])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <samuel.holland@sifive.com>)
 id 1sf7HW-0005OL-IF
 for qemu-devel@nongnu.org; Fri, 16 Aug 2024 20:27:00 -0400
Received: by mail-oa1-x32.google.com with SMTP id
 586e51a60fabf-267b7ef154aso1714818fac.0
 for <qemu-devel@nongnu.org>; Fri, 16 Aug 2024 17:26:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sifive.com; s=google; t=1723854413; x=1724459213; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=6mBzLqL6MdSQlxiCxzjBTnD6Jwm1kjbNkQm4sK+PO4k=;
 b=VMgLuG5CyyrPo6XoJe4rK66cPYDSBT1jDotjKI4y65SXpE2rCorpvC3+Nxf5fkBVm3
 2CTo40uD+KCK3DCwg6ND69LCHcG2vBNDZc7uMCXFqQcjgqm0+8g7xdlU/W1/KEHOWjqO
 Br2cAWkHCzrl2IKwNVqzi6a38tnCJ8Hy1aQNl5Ap/bkDMQ1gd7TcX9JUVsS2QgemITHe
 PKLERp5Fg2bl9SsJujD0tgwWEi+RaGeNYqVtNv5iGzCPRwRjZQPAgbnKhPMfl73LQpVS
 Yv/Dol2ksunyThqF28IAHmmjrBKMBQkQ1AeWrvyjf7ll78dqtzeTlUI0+v2qS4ThPOeZ
 SRew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1723854413; x=1724459213;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=6mBzLqL6MdSQlxiCxzjBTnD6Jwm1kjbNkQm4sK+PO4k=;
 b=wt6pUgf4Eegok0Vg0ldCQV+KwwABm2hzIY6+o+uF3ESxEHwHLiWQ3w/6ZdwPDF5035
 sC48V+XIgOMRYGFXE2rQOlv0cqTcjuB85gO+wF2xrrKHUyjFMRpQS1CUfvtokbt7lx0D
 fYZ0X857KIFR1OuxJGtzW8kHbLNJblUuVrb3WoIVwGKFb3htA5hMny8Rc8Mtn+0Arz+3
 NqebPLvmkwa89yCpm6w4NOpoadYKvbzkMqKckN2m0KNaItYew9gE0YFiTob1LI7lsBaP
 NOAzLbPWaQpWQjfOGbBDr1XL0PJHQEjF9hBYYBKM1w0KXqSbyUZZj+Fkg9tdmJHStDqf
 i4ew==
X-Forwarded-Encrypted: i=1;
 AJvYcCU8owVh+gXgchkkCYPIAtJg4AXQ8P/inzUkNDoPtaKSPRFgIuCwD0/Jpi2bi3TWhlQ82T9j1GS3Art/+RH1agiGkIhCREA=
X-Gm-Message-State: AOJu0Yxbgj3A5OqeR2aLngPs9VJINJAJp64qQT+pvISxVrVdHzvkNTp7
 61Wn/h/sUiW7rFx6dnI3tpzwEHrRKJO0NtnS7tuPEAPGuRHHwurS2zuEHKEL6UQ=
X-Google-Smtp-Source: AGHT+IHmDwGcwfB5GaS4fg2IwtZxaPZPIEhKGxGi0+Xi8AJ3N7CsYZ8GItDdWoR5ZRK2Et1sXhgbkg==
X-Received: by 2002:a05:6870:6387:b0:268:952b:d2a4 with SMTP id
 586e51a60fabf-270341e0c73mr1301704fac.32.1723854413580; 
 Fri, 16 Aug 2024 17:26:53 -0700 (PDT)
Received: from sw06.internal.sifive.com ([4.53.31.132])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-7127aef5457sm3152654b3a.127.2024.08.16.17.26.52
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 16 Aug 2024 17:26:53 -0700 (PDT)
From: Samuel Holland <samuel.holland@sifive.com>
To: qemu-riscv@nongnu.org
Cc: Samuel Holland <samuel.holland@sifive.com>,
 Alistair Francis <alistair.francis@wdc.com>, Bin Meng <bmeng.cn@gmail.com>,
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>,
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>,
 Palmer Dabbelt <palmer@dabbelt.com>, Vijai Kumar K <vijai@behindbytes.com>,
 Weiwei Li <liwei1518@gmail.com>, qemu-devel@nongnu.org
Subject: [PATCH] hw/riscv: Respect firmware ELF entry point
Date: Fri, 16 Aug 2024 17:25:02 -0700
Message-ID: <20240817002651.3209701-1-samuel.holland@sifive.com>
X-Mailer: git-send-email 2.45.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2001:4860:4864:20::32;
 envelope-from=samuel.holland@sifive.com; helo=mail-oa1-x32.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=unavailable autolearn_force=no
X-Spam_action: no action
X-Mailman-Approved-At: Fri, 16 Aug 2024 20:54:48 -0400
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

When riscv_load_firmware() loads an ELF, the ELF segment addresses are
used, not the passed-in firmware_load_addr. The machine models assume
the firmware entry point is what they provided for firmware_load_addr,
and use that address to generate the boot ROM, so if the ELF is linked
at any other address, the boot ROM will jump to empty memory.

Pass back the ELF entry point to use when generating the boot ROM, so
the boot ROM can jump to firmware loaded anywhere in RAM. For example,
on the virt machine, this allows using an OpenSBI fw_dynamic.elf built
with FW_TEXT_START values other than 0x80000000.

Signed-off-by: Samuel Holland <samuel.holland@sifive.com>
---

 hw/riscv/boot.c            | 11 ++++++-----
 hw/riscv/microchip_pfsoc.c |  2 +-
 hw/riscv/opentitan.c       |  3 ++-
 hw/riscv/shakti_c.c        | 13 ++++++-------
 hw/riscv/sifive_u.c        |  4 ++--
 hw/riscv/spike.c           |  5 +++--
 hw/riscv/virt.c            |  4 ++--
 include/hw/riscv/boot.h    |  4 ++--
 8 files changed, 24 insertions(+), 22 deletions(-)

diff --git a/hw/riscv/boot.c b/hw/riscv/boot.c
index 47281ca853..9115ecd91f 100644
--- a/hw/riscv/boot.c
+++ b/hw/riscv/boot.c
@@ -128,11 +128,11 @@ char *riscv_find_firmware(const char *firmware_filename,
 
 target_ulong riscv_find_and_load_firmware(MachineState *machine,
                                           const char *default_machine_firmware,
-                                          hwaddr firmware_load_addr,
+                                          hwaddr *firmware_load_addr,
                                           symbol_fn_t sym_cb)
 {
     char *firmware_filename;
-    target_ulong firmware_end_addr = firmware_load_addr;
+    target_ulong firmware_end_addr = *firmware_load_addr;
 
     firmware_filename = riscv_find_firmware(machine->firmware,
                                             default_machine_firmware);
@@ -148,7 +148,7 @@ target_ulong riscv_find_and_load_firmware(MachineState *machine,
 }
 
 target_ulong riscv_load_firmware(const char *firmware_filename,
-                                 hwaddr firmware_load_addr,
+                                 hwaddr *firmware_load_addr,
                                  symbol_fn_t sym_cb)
 {
     uint64_t firmware_entry, firmware_end;
@@ -159,15 +159,16 @@ target_ulong riscv_load_firmware(const char *firmware_filename,
     if (load_elf_ram_sym(firmware_filename, NULL, NULL, NULL,
                          &firmware_entry, NULL, &firmware_end, NULL,
                          0, EM_RISCV, 1, 0, NULL, true, sym_cb) > 0) {
+        *firmware_load_addr = firmware_entry;
         return firmware_end;
     }
 
     firmware_size = load_image_targphys_as(firmware_filename,
-                                           firmware_load_addr,
+                                           *firmware_load_addr,
                                            current_machine->ram_size, NULL);
 
     if (firmware_size > 0) {
-        return firmware_load_addr + firmware_size;
+        return *firmware_load_addr + firmware_size;
     }
 
     error_report("could not load firmware '%s'", firmware_filename);
diff --git a/hw/riscv/microchip_pfsoc.c b/hw/riscv/microchip_pfsoc.c
index 7725dfbde5..f9a3b43d2e 100644
--- a/hw/riscv/microchip_pfsoc.c
+++ b/hw/riscv/microchip_pfsoc.c
@@ -613,7 +613,7 @@ static void microchip_icicle_kit_machine_init(MachineState *machine)
 
     /* Load the firmware */
     firmware_end_addr = riscv_find_and_load_firmware(machine, firmware_name,
-                                                     firmware_load_addr, NULL);
+                                                     &firmware_load_addr, NULL);
 
     if (kernel_as_payload) {
         kernel_start_addr = riscv_calc_kernel_start_addr(&s->soc.u_cpus,
diff --git a/hw/riscv/opentitan.c b/hw/riscv/opentitan.c
index 436503f1ba..e2830e9dc2 100644
--- a/hw/riscv/opentitan.c
+++ b/hw/riscv/opentitan.c
@@ -98,7 +98,8 @@ static void opentitan_machine_init(MachineState *machine)
         memmap[IBEX_DEV_RAM].base, machine->ram);
 
     if (machine->firmware) {
-        riscv_load_firmware(machine->firmware, memmap[IBEX_DEV_RAM].base, NULL);
+        hwaddr firmware_load_addr = memmap[IBEX_DEV_RAM].base;
+        riscv_load_firmware(machine->firmware, &firmware_load_addr, NULL);
     }
 
     if (machine->kernel_filename) {
diff --git a/hw/riscv/shakti_c.c b/hw/riscv/shakti_c.c
index 3888034c2b..2dccc1eff2 100644
--- a/hw/riscv/shakti_c.c
+++ b/hw/riscv/shakti_c.c
@@ -45,6 +45,7 @@ static void shakti_c_machine_state_init(MachineState *mstate)
 {
     ShaktiCMachineState *sms = RISCV_SHAKTI_MACHINE(mstate);
     MemoryRegion *system_memory = get_system_memory();
+    hwaddr firmware_load_addr = shakti_c_memmap[SHAKTI_C_RAM].base;
 
     /* Initialize SoC */
     object_initialize_child(OBJECT(mstate), "soc", &sms->soc,
@@ -56,16 +57,14 @@ static void shakti_c_machine_state_init(MachineState *mstate)
                                 shakti_c_memmap[SHAKTI_C_RAM].base,
                                 mstate->ram);
 
+    if (mstate->firmware) {
+        riscv_load_firmware(mstate->firmware, &firmware_load_addr, NULL);
+    }
+
     /* ROM reset vector */
-    riscv_setup_rom_reset_vec(mstate, &sms->soc.cpus,
-                              shakti_c_memmap[SHAKTI_C_RAM].base,
+    riscv_setup_rom_reset_vec(mstate, &sms->soc.cpus, firmware_load_addr,
                               shakti_c_memmap[SHAKTI_C_ROM].base,
                               shakti_c_memmap[SHAKTI_C_ROM].size, 0, 0);
-    if (mstate->firmware) {
-        riscv_load_firmware(mstate->firmware,
-                            shakti_c_memmap[SHAKTI_C_RAM].base,
-                            NULL);
-    }
 }
 
 static void shakti_c_machine_instance_init(Object *obj)
diff --git a/hw/riscv/sifive_u.c b/hw/riscv/sifive_u.c
index af5f923f54..35a689309d 100644
--- a/hw/riscv/sifive_u.c
+++ b/hw/riscv/sifive_u.c
@@ -515,7 +515,7 @@ static void sifive_u_machine_init(MachineState *machine)
     SiFiveUState *s = RISCV_U_MACHINE(machine);
     MemoryRegion *system_memory = get_system_memory();
     MemoryRegion *flash0 = g_new(MemoryRegion, 1);
-    target_ulong start_addr = memmap[SIFIVE_U_DEV_DRAM].base;
+    hwaddr start_addr = memmap[SIFIVE_U_DEV_DRAM].base;
     target_ulong firmware_end_addr, kernel_start_addr;
     const char *firmware_name;
     uint32_t start_addr_hi32 = 0x00000000;
@@ -589,7 +589,7 @@ static void sifive_u_machine_init(MachineState *machine)
 
     firmware_name = riscv_default_firmware_name(&s->soc.u_cpus);
     firmware_end_addr = riscv_find_and_load_firmware(machine, firmware_name,
-                                                     start_addr, NULL);
+                                                     &start_addr, NULL);
 
     if (machine->kernel_filename) {
         kernel_start_addr = riscv_calc_kernel_start_addr(&s->soc.u_cpus,
diff --git a/hw/riscv/spike.c b/hw/riscv/spike.c
index 64074395bc..fceb91d946 100644
--- a/hw/riscv/spike.c
+++ b/hw/riscv/spike.c
@@ -198,6 +198,7 @@ static void spike_board_init(MachineState *machine)
     MemoryRegion *system_memory = get_system_memory();
     MemoryRegion *mask_rom = g_new(MemoryRegion, 1);
     target_ulong firmware_end_addr = memmap[SPIKE_DRAM].base;
+    hwaddr firmware_load_addr = memmap[SPIKE_DRAM].base;
     target_ulong kernel_start_addr;
     char *firmware_name;
     uint32_t fdt_load_addr;
@@ -290,7 +291,7 @@ static void spike_board_init(MachineState *machine)
     /* Load firmware */
     if (firmware_name) {
         firmware_end_addr = riscv_load_firmware(firmware_name,
-                                                memmap[SPIKE_DRAM].base,
+                                                &firmware_load_addr,
                                                 htif_symbol_callback);
         g_free(firmware_name);
     }
@@ -320,7 +321,7 @@ static void spike_board_init(MachineState *machine)
     riscv_load_fdt(fdt_load_addr, machine->fdt);
 
     /* load the reset vector */
-    riscv_setup_rom_reset_vec(machine, &s->soc[0], memmap[SPIKE_DRAM].base,
+    riscv_setup_rom_reset_vec(machine, &s->soc[0], firmware_load_addr,
                               memmap[SPIKE_MROM].base,
                               memmap[SPIKE_MROM].size, kernel_entry,
                               fdt_load_addr);
diff --git a/hw/riscv/virt.c b/hw/riscv/virt.c
index 9981e0f6c9..aef5e284a7 100644
--- a/hw/riscv/virt.c
+++ b/hw/riscv/virt.c
@@ -1336,7 +1336,7 @@ static void virt_machine_done(Notifier *notifier, void *data)
                                      machine_done);
     const MemMapEntry *memmap = virt_memmap;
     MachineState *machine = MACHINE(s);
-    target_ulong start_addr = memmap[VIRT_DRAM].base;
+    hwaddr start_addr = memmap[VIRT_DRAM].base;
     target_ulong firmware_end_addr, kernel_start_addr;
     const char *firmware_name = riscv_default_firmware_name(&s->soc[0]);
     uint64_t fdt_load_addr;
@@ -1368,7 +1368,7 @@ static void virt_machine_done(Notifier *notifier, void *data)
     }
 
     firmware_end_addr = riscv_find_and_load_firmware(machine, firmware_name,
-                                                     start_addr, NULL);
+                                                     &start_addr, NULL);
 
     pflash_blk0 = pflash_cfi01_get_blk(s->flash[0]);
     if (pflash_blk0) {
diff --git a/include/hw/riscv/boot.h b/include/hw/riscv/boot.h
index a2e4ae9cb0..18bfe9f7bf 100644
--- a/include/hw/riscv/boot.h
+++ b/include/hw/riscv/boot.h
@@ -35,13 +35,13 @@ target_ulong riscv_calc_kernel_start_addr(RISCVHartArrayState *harts,
                                           target_ulong firmware_end_addr);
 target_ulong riscv_find_and_load_firmware(MachineState *machine,
                                           const char *default_machine_firmware,
-                                          hwaddr firmware_load_addr,
+                                          hwaddr *firmware_load_addr,
                                           symbol_fn_t sym_cb);
 const char *riscv_default_firmware_name(RISCVHartArrayState *harts);
 char *riscv_find_firmware(const char *firmware_filename,
                           const char *default_machine_firmware);
 target_ulong riscv_load_firmware(const char *firmware_filename,
-                                 hwaddr firmware_load_addr,
+                                 hwaddr *firmware_load_addr,
                                  symbol_fn_t sym_cb);
 target_ulong riscv_load_kernel(MachineState *machine,
                                RISCVHartArrayState *harts,
-- 
2.45.1


