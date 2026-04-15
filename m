Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2861DFA0C39
	for <qemu-devel@archiver.kernel.org>; Wed, 15 Apr 2026 06:49:57 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wCu3f-0001Lj-HR; Wed, 15 Apr 2026 02:49:07 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <joel.stan@gmail.com>)
 id 1wCu3Z-0001L7-JA
 for qemu-devel@nongnu.org; Wed, 15 Apr 2026 02:49:01 -0400
Received: from mail-pl1-x62c.google.com ([2607:f8b0:4864:20::62c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <joel.stan@gmail.com>)
 id 1wCu3X-0001jD-J8
 for qemu-devel@nongnu.org; Wed, 15 Apr 2026 02:49:01 -0400
Received: by mail-pl1-x62c.google.com with SMTP id
 d9443c01a7336-2b458ca2296so21993605ad.0
 for <qemu-devel@nongnu.org>; Tue, 14 Apr 2026 23:48:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1776235738; x=1776840538; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:sender:from:to:cc:subject:date
 :message-id:reply-to;
 bh=5jqHbQAJgOLFfH+lIAe1p8AZM4s9fk2mY9wDuXakszk=;
 b=aUT3+fWwMLVWTtHkpevSUWUcP88/QJqmahPsV1lD8qmxfTxg4m2/wbmJbTyRb+cfED
 RHD+Fg+pVS1NNH1ji3Zt0susv2y9l+Zh7oyFGU084CIzZYMK8t1yrmFjc8bZFFuHo1Ee
 3g5Zjms2ntQQPVlJ8U2gw9z1MGMeMO2qxUHyA+0eU9xs6wNrIK8pnVbog1X3DDGyOYMJ
 2jHWC+UpTDR+o/2QmWATE8ytZC3uw+HpHtCh8Mq53Z9hUX6P6pvVD44nhtdWmqdbuzDH
 KBm+hSopzcsy0QivMAwdU+8cxfSGH44IPGojGyoUsyACjttP/sFNAT5liarb+SL7sw2P
 +tzw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1776235738; x=1776840538;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:sender:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=5jqHbQAJgOLFfH+lIAe1p8AZM4s9fk2mY9wDuXakszk=;
 b=GWGlpaTBrp3n3AJS3MLuvK32JWg+GKmkNpJLDl/MiBpxGt2oji+Wn1svZkB5afBnX1
 zygYrTVbaBkUnlnU0HiqbIsNb2rDzIMfN5DieGcEXqj7VCepnvjCjdxPhk2DUu82TZFG
 O1JOcl1Opp7K42pno4HqkpBFxyCJodcleQyzrKtcnmxHguTba83NEDPwofj21a2u/a68
 bcvsJTOfPzOFLdaTgPYtENE0eHNTg9cA7z6bzvM7lVXrXAkAivQkjX8lIiI11808SWbj
 qkDqT86Q9+FaJzFgx+yn86Q0XK5ai21Nvu4jmg1YI91Cq7GdFabbO3dslxkxwDyj4DUK
 DzEQ==
X-Forwarded-Encrypted: i=1;
 AFNElJ9m5lTAVIpHqApGnHz9IaBzp6rJXk9WiokdJd0S+h/Pq1Jbj+Lg1BLLqAvAufyJkoX2KA90rK1pk1G6@nongnu.org
X-Gm-Message-State: AOJu0Yzk7tUgqkMD73maFaprx1eqJ5KIwuYdFHeoJ/qkfyDZWxG4e9LK
 C4yP6MafqLa6HOAw4962LA6pO4quv7u1w1no46vVzaB0ud6TEn+8r0Bs
X-Gm-Gg: AeBDievysegd+Bdz8snF/OeZmLR1Vs7kmkv6s4rmkXhGB/9UtAAphaxvT1m09jTZF/k
 7EdUWZUmB0x6gwXhXXGRvbBPsq9dZlx0lk+3m3j2ujD6hBCJtzMe7qM+OJPMJXlENDXutmNiux3
 ZjbL7JVjUjehJjxwB2FjF9pGx4LV9yhF7BhK1aQYSpJhHQAhf0yPbmdR5OMLlrqDKi+u0Eo+Ra/
 GJ05TYGuJQJkhH03IKThmXDPSlNcWbT5LWmX/nuOY62UGequjEe5ZdRW57LhJhN1jWJMk7qJk8i
 McNQ557PeCidBaOhyspyF3SXTUIMCDyWR6J5vBUj/0XFHxgRTdV32SvCcCSm81T3a+cCHtw+LrJ
 etDJH5CCm26eqeTB9RQNCm+1I3llnaogK7ib7uDkiFPJM5fmRmF7J8hxGLQI049lB39Su3VQVVl
 oUdK/3khFEWg77A/roYEjCqM1Dh6nj8PfsZmRJ3sc6Nb/v4poz6L/IkD3Q8BjluY68cy/EQ4w5H
 VnyfXar+EUm2MkwGOMgiw==
X-Received: by 2002:a17:902:7d92:b0:2b0:c90f:449c with SMTP id
 d9443c01a7336-2b2d593735emr136464805ad.9.1776235738070; 
 Tue, 14 Apr 2026 23:48:58 -0700 (PDT)
Received: from donnager-debian.. ([45.124.203.19])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2b478142565sm10353195ad.37.2026.04.14.23.48.53
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 14 Apr 2026 23:48:57 -0700 (PDT)
From: Joel Stanley <joel@jms.id.au>
To: Alistair Francis <alistair.francis@wdc.com>,
 Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>,
 qemu-devel@nongnu.org
Cc: Nicholas Piggin <npiggin@gmail.com>, Weiwei Li <liwei1518@gmail.com>,
 Michael Ellerman <mpe@oss.tenstorrent.com>,
 Joel Stanley <jms@oss.tenstorrent.com>,
 Nick Piggin <npiggin@oss.tenstorrent.com>,
 Anirudh Srinivasan <asrinivasan@oss.tenstorrent.com>, qemu-riscv@nongnu.org
Subject: [PATCH v2 2/4] hw/riscv/boot: Account for discontiguous memory when
 loading firmware
Date: Wed, 15 Apr 2026 16:48:34 +1000
Message-ID: <20260415064838.652297-3-joel@jms.id.au>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260415064838.652297-1-joel@jms.id.au>
References: <20260415064838.652297-1-joel@jms.id.au>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62c;
 envelope-from=joel.stan@gmail.com; helo=mail-pl1-x62c.google.com
X-Spam_score_int: -17
X-Spam_score: -1.8
X-Spam_bar: -
X-Spam_report: (-1.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FORGED_FROMDOMAIN=0.001,
 FREEMAIL_FROM=0.001, HEADER_FROM_DIFFERENT_DOMAINS=0.248,
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

Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
Reviewed-by: Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>
Signed-off-by: Joel Stanley <joel@jms.id.au>
---
 include/hw/riscv/boot.h    |  5 ++++-
 hw/riscv/boot.c            | 18 ++++++++++++------
 hw/riscv/microchip_pfsoc.c |  6 ++++--
 hw/riscv/opentitan.c       |  6 ++++--
 hw/riscv/shakti_c.c        |  6 +++++-
 hw/riscv/sifive_u.c        |  3 ++-
 hw/riscv/spike.c           |  6 ++++--
 hw/riscv/virt.c            |  7 ++++---
 hw/riscv/xiangshan_kmh.c   |  6 +++++-
 9 files changed, 44 insertions(+), 19 deletions(-)

diff --git a/include/hw/riscv/boot.h b/include/hw/riscv/boot.h
index 115e3222174f..fb90bf12399e 100644
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
+                           RISCVBootInfo *info,
+                           const char *firmware_filename,
                            hwaddr *firmware_load_addr,
                            symbol_fn_t sym_cb);
 void riscv_load_kernel(MachineState *machine,
diff --git a/hw/riscv/boot.c b/hw/riscv/boot.c
index 9babb85b0458..f3857e984240 100644
--- a/hw/riscv/boot.c
+++ b/hw/riscv/boot.c
@@ -145,6 +145,7 @@ char *riscv_find_firmware(const char *firmware_filename,
 }
 
 hwaddr riscv_find_and_load_firmware(MachineState *machine,
+                                    RISCVBootInfo *info,
                                     const char *default_machine_firmware,
                                     hwaddr *firmware_load_addr,
                                     symbol_fn_t sym_cb)
@@ -157,7 +158,8 @@ hwaddr riscv_find_and_load_firmware(MachineState *machine,
 
     if (firmware_filename) {
         /* If not "none" load the firmware */
-        firmware_end_addr = riscv_load_firmware(firmware_filename,
+        firmware_end_addr = riscv_load_firmware(machine, info,
+                                                firmware_filename,
                                                 firmware_load_addr, sym_cb);
         g_free(firmware_filename);
     }
@@ -165,10 +167,13 @@ hwaddr riscv_find_and_load_firmware(MachineState *machine,
     return firmware_end_addr;
 }
 
-hwaddr riscv_load_firmware(const char *firmware_filename,
+hwaddr riscv_load_firmware(MachineState *machine,
+                           RISCVBootInfo *info,
+                           const char *firmware_filename,
                            hwaddr *firmware_load_addr,
                            symbol_fn_t sym_cb)
 {
+    uint64_t mem_size = info->ram_low_size ?: machine->ram_size;
     uint64_t firmware_entry, firmware_end;
     ssize_t firmware_size;
 
@@ -183,7 +188,7 @@ hwaddr riscv_load_firmware(const char *firmware_filename,
 
     firmware_size = load_image_targphys_as(firmware_filename,
                                            *firmware_load_addr,
-                                           current_machine->ram_size, NULL,
+                                           mem_size, NULL,
                                            NULL);
 
     if (firmware_size > 0) {
@@ -197,7 +202,7 @@ hwaddr riscv_load_firmware(const char *firmware_filename,
 static void riscv_load_initrd(MachineState *machine, RISCVBootInfo *info)
 {
     const char *filename = machine->initrd_filename;
-    uint64_t mem_size = machine->ram_size;
+    uint64_t mem_size = info->ram_low_size ?: machine->ram_size;
     void *fdt = machine->fdt;
     hwaddr start, end;
     ssize_t size;
@@ -243,6 +248,7 @@ void riscv_load_kernel(MachineState *machine,
                        bool load_initrd,
                        symbol_fn_t sym_cb)
 {
+    uint64_t mem_size = info->ram_low_size ?: machine->ram_size;
     const char *kernel_filename = machine->kernel_filename;
     ssize_t kernel_size;
     void *fdt = machine->fdt;
@@ -274,7 +280,7 @@ void riscv_load_kernel(MachineState *machine,
     }
 
     kernel_size = load_image_targphys_as(kernel_filename, kernel_start_addr,
-                                         current_machine->ram_size, NULL, NULL);
+                                         mem_size, NULL, NULL);
     if (kernel_size > 0) {
         info->kernel_size = kernel_size;
         info->image_low_addr = kernel_start_addr;
@@ -370,7 +376,7 @@ uint64_t riscv_compute_fdt_addr(hwaddr dram_base, hwaddr dram_size,
     dtb_start = QEMU_ALIGN_DOWN(temp - fdtsize, 2 * MiB);
 
     if (dtb_start_limit && (dtb_start < dtb_start_limit)) {
-        error_report("No enough memory to place DTB after kernel/initrd");
+        error_report("Not enough memory to place DTB after kernel/initrd");
         exit(1);
     }
 
diff --git a/hw/riscv/microchip_pfsoc.c b/hw/riscv/microchip_pfsoc.c
index 743f31f00578..1d1ddb05a882 100644
--- a/hw/riscv/microchip_pfsoc.c
+++ b/hw/riscv/microchip_pfsoc.c
@@ -618,18 +618,20 @@ static void microchip_icicle_kit_machine_init(MachineState *machine)
         firmware_load_addr = RESET_VECTOR;
     }
 
+    riscv_boot_info_init(&boot_info, &s->soc.u_cpus);
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
index 309125e854bc..8cd660dd4154 100644
--- a/hw/riscv/opentitan.c
+++ b/hw/riscv/opentitan.c
@@ -99,12 +99,14 @@ static void opentitan_machine_init(MachineState *machine)
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
index 49a39b30212d..eb720d9cdf5d 100644
--- a/hw/riscv/shakti_c.c
+++ b/hw/riscv/shakti_c.c
@@ -45,6 +45,7 @@ static void shakti_c_machine_state_init(MachineState *mstate)
 {
     ShaktiCMachineState *sms = RISCV_SHAKTI_MACHINE(mstate);
     MemoryRegion *system_memory = get_system_memory();
+    RISCVBootInfo boot_info;
     hwaddr firmware_load_addr = shakti_c_memmap[SHAKTI_C_RAM].base;
 
     /* Initialize SoC */
@@ -57,8 +58,11 @@ static void shakti_c_machine_state_init(MachineState *mstate)
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
index 7ec67b256514..4c526f73edf6 100644
--- a/hw/riscv/sifive_u.c
+++ b/hw/riscv/sifive_u.c
@@ -590,7 +590,8 @@ static void sifive_u_machine_init(MachineState *machine)
     }
 
     firmware_name = riscv_default_firmware_name(&s->soc.u_cpus);
-    firmware_end_addr = riscv_find_and_load_firmware(machine, firmware_name,
+    firmware_end_addr = riscv_find_and_load_firmware(machine, &boot_info,
+                                                     firmware_name,
                                                      &start_addr, NULL);
 
     riscv_boot_info_init(&boot_info, &s->soc.u_cpus);
diff --git a/hw/riscv/spike.c b/hw/riscv/spike.c
index 35c696f891d8..6ee915a8ba4e 100644
--- a/hw/riscv/spike.c
+++ b/hw/riscv/spike.c
@@ -281,9 +281,12 @@ static void spike_board_init(MachineState *machine)
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
@@ -293,7 +296,6 @@ static void spike_board_init(MachineState *machine)
     create_fdt(s, memmap, riscv_is_32bit(&s->soc[0]), htif_custom_base);
 
     /* Load kernel */
-    riscv_boot_info_init(&boot_info, &s->soc[0]);
     if (machine->kernel_filename) {
         kernel_start_addr = riscv_calc_kernel_start_addr(&boot_info,
                                                          firmware_end_addr);
diff --git a/hw/riscv/virt.c b/hw/riscv/virt.c
index a1c323e66dfd..4501d5581b62 100644
--- a/hw/riscv/virt.c
+++ b/hw/riscv/virt.c
@@ -1457,7 +1457,10 @@ static void virt_machine_done(Notifier *notifier, void *data)
         }
     }
 
-    firmware_end_addr = riscv_find_and_load_firmware(machine, firmware_name,
+    riscv_boot_info_init(&boot_info, &s->soc[0]);
+
+    firmware_end_addr = riscv_find_and_load_firmware(machine, &boot_info,
+                                                     firmware_name,
                                                      &start_addr, NULL);
 
     pflash_blk0 = pflash_cfi01_get_blk(s->flash[0]);
@@ -1480,8 +1483,6 @@ static void virt_machine_done(Notifier *notifier, void *data)
         }
     }
 
-    riscv_boot_info_init(&boot_info, &s->soc[0]);
-
     if (machine->kernel_filename && !kernel_entry) {
         kernel_start_addr = riscv_calc_kernel_start_addr(&boot_info,
                                                          firmware_end_addr);
diff --git a/hw/riscv/xiangshan_kmh.c b/hw/riscv/xiangshan_kmh.c
index 436e51c1c593..247a0b5d1f21 100644
--- a/hw/riscv/xiangshan_kmh.c
+++ b/hw/riscv/xiangshan_kmh.c
@@ -166,6 +166,7 @@ static void xiangshan_kmh_machine_init(MachineState *machine)
     const MemMapEntry *memmap = xiangshan_kmh_memmap;
     MemoryRegion *system_memory = get_system_memory();
     hwaddr start_addr = memmap[XIANGSHAN_KMH_DRAM].base;
+    RISCVBootInfo boot_info;
 
     /* Initialize SoC */
     object_initialize_child(OBJECT(machine), "soc", &s->soc,
@@ -177,13 +178,16 @@ static void xiangshan_kmh_machine_init(MachineState *machine)
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


