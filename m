Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C42C6EE644E
	for <qemu-devel@archiver.kernel.org>; Thu, 12 Sep 2024 05:41:06 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1socST-0005l7-OY; Thu, 12 Sep 2024 01:33:36 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1socRL-0000iY-2Y
 for qemu-devel@nongnu.org; Thu, 12 Sep 2024 01:32:31 -0400
Received: from mail-pg1-x536.google.com ([2607:f8b0:4864:20::536])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1socRI-0003BS-9K
 for qemu-devel@nongnu.org; Thu, 12 Sep 2024 01:32:22 -0400
Received: by mail-pg1-x536.google.com with SMTP id
 41be03b00d2f7-7d50b3a924bso227732a12.0
 for <qemu-devel@nongnu.org>; Wed, 11 Sep 2024 22:32:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1726119139; x=1726723939; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=UefArdR4LpqgzKnpldqKOmOZkzLrdIAn+UhHLQmgqqU=;
 b=UuFsntjDKrV+CraBzMt2my9HaHXsUjvC+IVy3gfvg0B7Vq8eCx8zsj10CutTcEblBO
 93YHYZP8nz5+fdik/GmFFQYV+Z9jRVfSYmvMvJLTQE0gKwnFWuqs7Q7TWBJ3qvmeDAkd
 SiujG3m18tVoX7kE7EctkYxthD8jsIt5pH5x7N+NfXcHppV5rSl6Q8kPzGpYB/7Rz2vW
 FyPMijvIxYOTrALAU81AJmWe7sG6DlQkOPQKFijEFyXL7eAddfUjHIs5PO0jyQqkZFjZ
 OwbxmGYr/GU8SpYVOW8mj6h3Wtnge217Un/Y+GbC2mQOv84ddIoNvZYklDYuD7mjxD5O
 dMEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1726119139; x=1726723939;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=UefArdR4LpqgzKnpldqKOmOZkzLrdIAn+UhHLQmgqqU=;
 b=ZdlaZQTQniDqTYOgL8vsXaBMOq3+FBJ2dKxRQEUy9Bfv901UxRfpXYxYcQBhIJ4BEI
 szPprvkIldaH/iU7M8/qA1kC4abosVFadO7+GhGmCPPdUhPI+/ZlcZLe3EZvFnmjGyqb
 7IxJHOJdoXy9vhjWBywcn73Cn8dPf+bb7m5eA8fZb1zXonlmt16QGXleWDW/K7dG5+78
 Yi2cEC2Qqy/g+ZbWHlEqKwuK8ZeQPKeoB+AfPRncm/QKBynj5UHOztR/XqgYi09z1foG
 tT8tWYIWPCA+1nf+T4/QXRlA4yvQro/yo+qZaNGkDttxJNHepomgc0NBU2mPhOA5hkSn
 LLig==
X-Gm-Message-State: AOJu0YwZajcta5J8pTm1EFLxisxsKd2jjJH+uK72uQvSR7CiXHRPTUcE
 f+21sMp9h5QLqBMTBlsp4tacgPESscCXofPe5kIYOEhCXFPZhY0mxCVRUA==
X-Google-Smtp-Source: AGHT+IESiYOArJ/J27v5x/MEFjyyiZ9A+X6VFHcXpzgvv+fp2gNjNx3/99F+n/q6chtwRUNzUFJlTg==
X-Received: by 2002:a05:6a21:478b:b0:1cf:334d:ffae with SMTP id
 adf61e73a8af0-1cf761e59b8mr2020650637.32.1726119138595; 
 Wed, 11 Sep 2024 22:32:18 -0700 (PDT)
Received: from toolbox.alistair23.me
 (2403-580b-97e8-0-82ce-f179-8a79-69f4.ip6.aussiebb.net.
 [2403:580b:97e8:0:82ce:f179:8a79:69f4])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-71908fc8fdesm3833034b3a.1.2024.09.11.22.32.16
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 11 Sep 2024 22:32:18 -0700 (PDT)
From: Alistair Francis <alistair23@gmail.com>
X-Google-Original-From: Alistair Francis <alistair.francis@wdc.com>
To: qemu-devel@nongnu.org
Cc: alistair23@gmail.com, Samuel Holland <samuel.holland@sifive.com>,
 Alistair Francis <alistair.francis@wdc.com>
Subject: [PULL 43/47] hw/riscv: Respect firmware ELF entry point
Date: Thu, 12 Sep 2024 15:29:48 +1000
Message-ID: <20240912052953.2552501-44-alistair.francis@wdc.com>
X-Mailer: git-send-email 2.46.0
In-Reply-To: <20240912052953.2552501-1-alistair.francis@wdc.com>
References: <20240912052953.2552501-1-alistair.francis@wdc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::536;
 envelope-from=alistair23@gmail.com; helo=mail-pg1-x536.google.com
X-Spam_score_int: -17
X-Spam_score: -1.8
X-Spam_bar: -
X-Spam_report: (-1.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FREEMAIL_ENVFROM_END_DIGIT=0.25, FREEMAIL_FROM=0.001,
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

From: Samuel Holland <samuel.holland@sifive.com>

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
Reviewed-by: Alistair Francis <alistair.francis@wdc.com>
Message-ID: <20240817002651.3209701-1-samuel.holland@sifive.com>
Signed-off-by: Alistair Francis <alistair.francis@wdc.com>
---
 include/hw/riscv/boot.h    |  4 ++--
 hw/riscv/boot.c            | 11 ++++++-----
 hw/riscv/microchip_pfsoc.c |  2 +-
 hw/riscv/opentitan.c       |  3 ++-
 hw/riscv/shakti_c.c        | 13 ++++++-------
 hw/riscv/sifive_u.c        |  4 ++--
 hw/riscv/spike.c           |  5 +++--
 hw/riscv/virt.c            |  4 ++--
 8 files changed, 24 insertions(+), 22 deletions(-)

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
index 63d553ac98..1d32b4b0f3 100644
--- a/hw/riscv/virt.c
+++ b/hw/riscv/virt.c
@@ -1360,7 +1360,7 @@ static void virt_machine_done(Notifier *notifier, void *data)
                                      machine_done);
     const MemMapEntry *memmap = virt_memmap;
     MachineState *machine = MACHINE(s);
-    target_ulong start_addr = memmap[VIRT_DRAM].base;
+    hwaddr start_addr = memmap[VIRT_DRAM].base;
     target_ulong firmware_end_addr, kernel_start_addr;
     const char *firmware_name = riscv_default_firmware_name(&s->soc[0]);
     uint64_t fdt_load_addr;
@@ -1392,7 +1392,7 @@ static void virt_machine_done(Notifier *notifier, void *data)
     }
 
     firmware_end_addr = riscv_find_and_load_firmware(machine, firmware_name,
-                                                     start_addr, NULL);
+                                                     &start_addr, NULL);
 
     pflash_blk0 = pflash_cfi01_get_blk(s->flash[0]);
     if (pflash_blk0) {
-- 
2.46.0


