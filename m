Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E4107FD4F17
	for <qemu-devel@archiver.kernel.org>; Tue, 10 Mar 2026 18:32:17 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w01s8-000220-6n; Tue, 10 Mar 2026 14:32:00 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vikingtc4@gmail.com>)
 id 1w01s5-00021Y-Ft
 for qemu-devel@nongnu.org; Tue, 10 Mar 2026 14:31:57 -0400
Received: from mail-pl1-x635.google.com ([2607:f8b0:4864:20::635])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <vikingtc4@gmail.com>)
 id 1w01s2-0007gI-Fp
 for qemu-devel@nongnu.org; Tue, 10 Mar 2026 14:31:57 -0400
Received: by mail-pl1-x635.google.com with SMTP id
 d9443c01a7336-2ae8177446fso33555605ad.0
 for <qemu-devel@nongnu.org>; Tue, 10 Mar 2026 11:31:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1773167513; x=1773772313; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=GG2Gexo+Btb5AB7rJ+bn7lp3VSbZ/BJr46AUU3D8uIU=;
 b=nqN4272mUYb9QeSWer6KfEFiUaCpVijtzcStlt6oySs275kEQvb+rlzeVY1G66MUV5
 lm46Yg50/no3U+hzrrwGM7y+EvcAXmkveQUStKK2lghFEUpdJ7VivshhTOG9KxNqGn0n
 A1ghWdFf3C30qvfvZRbzm/bod407+ky2PuFpUGhk80Qb/QPHjCj61CFNCHVGwZbi+P3b
 08KVXcc/ZA4LykVVnERmFrqUWRE7Wsnpv21TSxeRT8IS6XiiTcMmBUM5Tom58AtKVFYN
 DI11R5JRB+IBef/1wLVm1CxxeUHtxJUGtkEWkHPD/h8C8BxBgI1m+thNnp1ukV/JfNOi
 9Tog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1773167513; x=1773772313;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=GG2Gexo+Btb5AB7rJ+bn7lp3VSbZ/BJr46AUU3D8uIU=;
 b=cVK719yHfmBx+PoKf+N8h0t/oJN90RdlXThBraQOuaM3v1807K//JDXwB4Pe/jZkFu
 QeloEBFhpJaGIRFMNAeTALTYJH0HHvFk1uSQDW3P3H1IHzfP6S+ZMecpCquWNysepFsB
 9IMY3WojsGAxjLGZhNLpjLrZn5dBd8IpmpXhW5upzbSKnhXoMXBqPTm6q0OYcpEPiXFf
 PjIB0LkOYompP377INCoNZmSzObB20P8EA4sntImM1uhHjKo+lYe54xM8NtVSWfIE9Ho
 oQ7aMXltKH8MSSKOh/dnQqwpRaau5tVhHGQZ6wVfp3MPPDOalNz1HbpAOfb46OEpHJ8T
 9VFQ==
X-Gm-Message-State: AOJu0Yw7Ey1WCPQMBnOF4BNISfkDl/dWTDgQkpCiDY4I15vYX9kCVmFW
 eEZfjQ9WTCgN+QjHNx/4JCu6dU7XS79sRosM6K2POFTL05xGLdN94eB9m9Fo2O0JmSrnjA==
X-Gm-Gg: ATEYQzyFjj3vncaxx2EgbkjIIrJmEX2u1e6AhDTCuLjE2+FmE1m7qhwJof4d8kRx3UI
 bO1cq8hbh4mzMCSey3iiD9aZvrt7jMu+eSTmqlPeRWNd1j/6IZ+po0SN+175Fplg7YM0BETpnjX
 PMf1zAIVK72tBwMnQ0SzzK7iU9X5OHiEvfCQkxkIOlKItcvmUjjD058PzvJVjRTcTnsI6hTPQVP
 3/YfsSGiMo1gpP/ryvi4eQ34gsBjw5f9qrxsOE9em+zAolz1SmoOV5ggtOr0YlAF5BoBy6gZ/3s
 RZAmnoXE/qmyGIZrcbXeJRj8HNWluZHuGCkHgdu/1o4RnPJKrf1HKYNQ15wYJe3+N8Qy0m36pC3
 JkD18F4nwIRHqMHIjUzYmEfeC8gkEJZlHOknM+MtumJs1Zlk5pv2/ysGOW37nUs/8bHkg9tyqMS
 N3VycKi/fFRT9uVRLSfcaAGnLy1eRtEpzu79o1nXO3Lu130A==
X-Received: by 2002:a17:902:d48b:b0:2a9:5e25:46f6 with SMTP id
 d9443c01a7336-2ae82442c8dmr151595215ad.17.1773167512772; 
 Tue, 10 Mar 2026 11:31:52 -0700 (PDT)
Received: from localhost.localdomain ([123.19.166.13])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2ae840b2e9dsm209437015ad.85.2026.03.10.11.31.47
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 10 Mar 2026 11:31:52 -0700 (PDT)
From: Trieu Huynh <vikingtc4@gmail.com>
X-Google-Original-From: Trieu Huynh <viking4@gmail.com>
To: qemu-devel@nongnu.org
Cc: Trieu Huynh <vikingtc4@gmail.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Helge Deller <deller@gmx.de>, Thomas Huth <huth@tuxfamily.org>,
 Laurent Vivier <laurent@vivier.eu>,
 "Edgar E. Iglesias" <edgar.iglesias@gmail.com>,
 BALATON Zoltan <balaton@eik.bme.hu>, Bernhard Beschow <shentey@gmail.com>,
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
 Nicholas Piggin <npiggin@gmail.com>, Aditya Gupta <adityag@linux.ibm.com>,
 Glenn Miles <milesg@linux.ibm.com>,
 =?UTF-8?q?Herv=C3=A9=20Poussineau?= <hpoussin@reactos.org>,
 Harsh Prateek Bora <harshpb@linux.ibm.com>, qemu-ppc@nongnu.org
Subject: [PATCH 1/4] hw/core/loader: fix error handling for
 load_image_targphys callers
Date: Wed, 11 Mar 2026 01:27:57 +0700
Message-ID: <20260310182801.196443-2-viking4@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260310182801.196443-1-viking4@gmail.com>
References: <20260310182801.196443-1-viking4@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::635;
 envelope-from=vikingtc4@gmail.com; helo=mail-pl1-x635.google.com
X-Spam_score_int: 15
X-Spam_score: 1.5
X-Spam_bar: +
X-Spam_report: (1.5 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1, DKIM_VALID=-0.1,
 DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_ENVFROM_END_DIGIT=0.25,
 FREEMAIL_FROM=0.001, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_SBL_CSS=3.335,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

From: Trieu Huynh <vikingtc4@gmail.com>

Check return value of load_image_targphys() and return early on
failure instead of continuing with invalid state.
- Use ret < 0 to handle negative return value.
- No functional changes.

Resolves: https://gitlab.com/qemu-project/qemu/-/issues/413
Signed-off-by: Trieu Huynh <vikingtc4@gmail.com>
---
 hw/alpha/dp264.c       |  8 ++++++--
 hw/hppa/machine.c      |  7 +++++--
 hw/m68k/next-cube.c    |  9 ++++++++-
 hw/m68k/q800.c         |  7 +++++--
 hw/m68k/virt.c         |  7 +++++--
 hw/microblaze/boot.c   |  4 ++++
 hw/ppc/amigaone.c      |  9 +++++++++
 hw/ppc/e500.c          | 10 ++++++++++
 hw/ppc/mac_newworld.c  | 10 ++++++++++
 hw/ppc/mac_oldworld.c  | 10 ++++++++++
 hw/ppc/pegasos.c       |  5 +++++
 hw/ppc/pnv.c           | 20 ++++++++++++++++----
 hw/ppc/ppc440_bamboo.c |  4 ++++
 hw/ppc/prep.c          | 10 ++++++++++
 hw/ppc/sam460ex.c      |  5 +++++
 hw/ppc/spapr.c         |  8 ++++++++
 hw/ppc/virtex_ml507.c  |  9 +++++++++
 17 files changed, 129 insertions(+), 13 deletions(-)

diff --git a/hw/alpha/dp264.c b/hw/alpha/dp264.c
index 98219f0456..830d14a509 100644
--- a/hw/alpha/dp264.c
+++ b/hw/alpha/dp264.c
@@ -189,8 +189,12 @@ static void clipper_init(MachineState *machine)
 
             /* Put the initrd image as high in memory as possible.  */
             initrd_base = (ram_size - initrd_size) & TARGET_PAGE_MASK;
-            load_image_targphys(initrd_filename, initrd_base,
-                                ram_size - initrd_base, NULL);
+            if (load_image_targphys(initrd_filename, initrd_base,
+                                ram_size - initrd_base, NULL) < 0) {
+                error_report("could not load initrd '%s'",
+                             initrd_filename);
+                exit(1);
+            }
 
             address_space_stq_le(&address_space_memory, param_offset + 0x100,
                                  initrd_base + 0xfffffc0000000000ULL,
diff --git a/hw/hppa/machine.c b/hw/hppa/machine.c
index f55e84529f..0bf3bccb07 100644
--- a/hw/hppa/machine.c
+++ b/hw/hppa/machine.c
@@ -507,8 +507,11 @@ static void machine_HP_common_init_tail(MachineState *machine, PCIBus *pci_bus,
                 exit(1);
             }
 
-            load_image_targphys(initrd_filename, initrd_base, initrd_size,
-                                NULL);
+            if (load_image_targphys(initrd_filename, initrd_base, initrd_size,
+                                NULL) < 0) {
+                error_report("Could not load initrd '%s'", initrd_filename);
+                exit(1);
+            }
             cpu[0]->env.initrd_base = initrd_base;
             cpu[0]->env.initrd_end  = initrd_base + initrd_size;
         }
diff --git a/hw/m68k/next-cube.c b/hw/m68k/next-cube.c
index 26177c7b86..77a88d1dde 100644
--- a/hw/m68k/next-cube.c
+++ b/hw/m68k/next-cube.c
@@ -1326,7 +1326,14 @@ static void next_cube_init(MachineState *machine)
     memory_region_init_alias(&m->rom2, NULL, "next.rom2", &m->rom, 0x0,
                              0x20000);
     memory_region_add_subregion(sysmem, 0x0, &m->rom2);
-    if (load_image_targphys(bios_name, 0x01000000, 0x20000, NULL) < 8) {
+    int bios_size = 0;
+    bios_size = load_image_targphys(bios_name, 0x01000000, 0x20000, NULL);
+    if (bios_size <  0) {
+        /* Shoud report failure and exit regardless of qtest enabled or not */
+        error_report("Failed to load firmware (bios size < 0) '%s'.",
+                     bios_name);
+        exit(1);
+    } else if (bios_size < 8) {
         if (!qtest_enabled()) {
             error_report("Failed to load firmware '%s'.", bios_name);
         }
diff --git a/hw/m68k/q800.c b/hw/m68k/q800.c
index ded531394e..3266617ad7 100644
--- a/hw/m68k/q800.c
+++ b/hw/m68k/q800.c
@@ -632,8 +632,11 @@ static void q800_machine_init(MachineState *machine)
             }
 
             initrd_base = (ram_size - initrd_size) & TARGET_PAGE_MASK;
-            load_image_targphys(initrd_filename, initrd_base,
-                                ram_size - initrd_base, NULL);
+            if (load_image_targphys(initrd_filename, initrd_base,
+                                ram_size - initrd_base, NULL) < 0) {
+                error_report("Could not load initrd '%s'", initrd_filename);
+                exit(1);
+            }
             BOOTINFO2(param_ptr, BI_RAMDISK, initrd_base,
                       initrd_size);
         } else {
diff --git a/hw/m68k/virt.c b/hw/m68k/virt.c
index e67900c727..90f52f26e5 100644
--- a/hw/m68k/virt.c
+++ b/hw/m68k/virt.c
@@ -291,8 +291,11 @@ static void virt_init(MachineState *machine)
             }
 
             initrd_base = (ram_size - initrd_size) & TARGET_PAGE_MASK;
-            load_image_targphys(initrd_filename, initrd_base,
-                                ram_size - initrd_base, NULL);
+            if (load_image_targphys(initrd_filename, initrd_base,
+                                ram_size - initrd_base, NULL) < 0) {
+                error_report("Could not load initrd '%s'", initrd_filename);
+                exit(1);
+            }
             BOOTINFO2(param_ptr, BI_RAMDISK, initrd_base,
                       initrd_size);
         } else {
diff --git a/hw/microblaze/boot.c b/hw/microblaze/boot.c
index a6f9ebab90..9fa8885dd3 100644
--- a/hw/microblaze/boot.c
+++ b/hw/microblaze/boot.c
@@ -172,6 +172,10 @@ void microblaze_load_kernel(MicroBlazeCPU *cpu, bool is_little_endian,
         if (kernel_size < 0) {
             kernel_size = load_image_targphys(kernel_filename, ddr_base,
                                               ramsize, NULL);
+            if (kernel_size < 0) {
+                error_report("could not load kernel '%s'", kernel_filename);
+                exit(EXIT_FAILURE);
+            }
             boot_info.bootstrap_pc = ddr_base;
             high = (ddr_base + kernel_size + 3) & ~3;
         }
diff --git a/hw/ppc/amigaone.c b/hw/ppc/amigaone.c
index 8074713fbe..bb5e712c1b 100644
--- a/hw/ppc/amigaone.c
+++ b/hw/ppc/amigaone.c
@@ -326,6 +326,10 @@ static void amigaone_init(MachineState *machine)
             exit(1);
         }
         sz = load_image_targphys(filename, PROM_ADDR, PROM_SIZE, &error_fatal);
+        if (sz < 0) {
+            error_report("Could not load firmware '%s'", filename);
+            exit(1);
+        }
     }
 
     /* Articia S */
@@ -411,6 +415,11 @@ static void amigaone_init(MachineState *machine)
         loadaddr = MAX(loadaddr, INITRD_MIN_ADDR);
         sz = load_image_targphys(machine->initrd_filename, loadaddr,
                                  bi->bd_info - loadaddr, &error_fatal);
+        if (sz < 0) {
+            error_report("Could not load initrd '%s'",
+                         machine->initrd_filename);
+            exit(1);
+        }
         bi->initrd_start = loadaddr;
         bi->initrd_end = loadaddr + sz;
     }
diff --git a/hw/ppc/e500.c b/hw/ppc/e500.c
index d6ca2e8563..3117a05b59 100644
--- a/hw/ppc/e500.c
+++ b/hw/ppc/e500.c
@@ -1221,6 +1221,11 @@ void ppce500_init(MachineState *machine)
         kernel_size = load_image_targphys(machine->kernel_filename,
                                       cur_base, machine->ram_size - cur_base,
                                       &error_fatal);
+        if (kernel_size < 0) {
+            error_report("Could not load kernel '%s'",
+                         machine->kernel_filename);
+            exit(1);
+        }
         cur_base += kernel_size;
     }
 
@@ -1230,6 +1235,11 @@ void ppce500_init(MachineState *machine)
         initrd_size = load_image_targphys(machine->initrd_filename, initrd_base,
                                           machine->ram_size - initrd_base,
                                           &error_fatal);
+        if (initrd_size < 0) {
+            error_report("Could not load initrd '%s'",
+                         machine->initrd_filename);
+            exit(1);
+        }
         cur_base = initrd_base + initrd_size;
     }
 
diff --git a/hw/ppc/mac_newworld.c b/hw/ppc/mac_newworld.c
index 3680d96ed3..5e9556af33 100644
--- a/hw/ppc/mac_newworld.c
+++ b/hw/ppc/mac_newworld.c
@@ -213,6 +213,11 @@ static void ppc_core99_init(MachineState *machine)
                                               kernel_base,
                                               machine->ram_size - kernel_base,
                                               &error_fatal);
+            if (kernel_size < 0) {
+                error_report("Could not load kernel '%s'",
+                             machine->kernel_filename);
+                exit(1);
+            }
         }
         /* load initrd */
         if (machine->initrd_filename) {
@@ -221,6 +226,11 @@ static void ppc_core99_init(MachineState *machine)
                                               initrd_base,
                                               machine->ram_size - initrd_base,
                                               &error_fatal);
+            if (initrd_size < 0) {
+                error_report("Could not load initrd '%s'",
+                             machine->initrd_filename);
+                exit(1);
+            }
             cmdline_base = TARGET_PAGE_ALIGN(initrd_base + initrd_size);
         } else {
             cmdline_base = TARGET_PAGE_ALIGN(kernel_base + kernel_size + KERNEL_GAP);
diff --git a/hw/ppc/mac_oldworld.c b/hw/ppc/mac_oldworld.c
index 24d9f2e3d5..fdbbfed52a 100644
--- a/hw/ppc/mac_oldworld.c
+++ b/hw/ppc/mac_oldworld.c
@@ -169,6 +169,11 @@ static void ppc_heathrow_init(MachineState *machine)
                                               kernel_base,
                                               machine->ram_size - kernel_base,
                                               &error_fatal);
+            if (kernel_size < 0) {
+                error_report("Could not load kernel '%s'",
+                             machine->kernel_filename);
+                exit(1);
+            }
         }
         /* load initrd */
         if (machine->initrd_filename) {
@@ -178,6 +183,11 @@ static void ppc_heathrow_init(MachineState *machine)
                                               initrd_base,
                                               machine->ram_size - initrd_base,
                                               &error_fatal);
+            if (initrd_size < 0) {
+                error_report("Could not load initrd '%s'",
+                             machine->initrd_filename);
+                exit(1);
+            }
             cmdline_base = TARGET_PAGE_ALIGN(initrd_base + initrd_size);
         } else {
             cmdline_base = TARGET_PAGE_ALIGN(kernel_base + kernel_size + KERNEL_GAP);
diff --git a/hw/ppc/pegasos.c b/hw/ppc/pegasos.c
index ac9fc5a654..0f03691f52 100644
--- a/hw/ppc/pegasos.c
+++ b/hw/ppc/pegasos.c
@@ -304,6 +304,11 @@ static void pegasos_init(MachineState *machine)
         pm->initrd_addr = MAX(pm->initrd_addr, INITRD_MIN_ADDR);
         sz = load_image_targphys(machine->initrd_filename, pm->initrd_addr,
                             machine->ram_size - pm->initrd_addr, &error_fatal);
+        if (sz < 0) {
+            error_report("Could not load initrd '%s'",
+                         machine->initrd_filename);
+            exit(1);
+        }
         pm->initrd_size = sz;
     }
 
diff --git a/hw/ppc/pnv.c b/hw/ppc/pnv.c
index 1513575b8f..aecffb211b 100644
--- a/hw/ppc/pnv.c
+++ b/hw/ppc/pnv.c
@@ -1068,14 +1068,21 @@ static void pnv_init(MachineState *machine)
         exit(1);
     }
 
-    load_image_targphys(fw_filename, pnv->fw_load_addr, FW_MAX_SIZE,
-                        &error_fatal);
+    if (load_image_targphys(fw_filename, pnv->fw_load_addr, FW_MAX_SIZE,
+                        &error_fatal) < 0) {
+        error_report("Could not load OPAL firmware '%s'", fw_filename);
+        exit(1);
+    }
     g_free(fw_filename);
 
     /* load kernel */
     if (machine->kernel_filename) {
-        load_image_targphys(machine->kernel_filename,
-                            KERNEL_LOAD_ADDR, KERNEL_MAX_SIZE, &error_fatal);
+        if (load_image_targphys(machine->kernel_filename,
+                        KERNEL_LOAD_ADDR, KERNEL_MAX_SIZE, &error_fatal) < 0) {
+            error_report("Could not load kernel '%s'",
+                         machine->kernel_filename);
+            exit(1);
+        }
     }
 
     /* load initrd */
@@ -1084,6 +1091,11 @@ static void pnv_init(MachineState *machine)
         pnv->initrd_size = load_image_targphys(machine->initrd_filename,
                                                pnv->initrd_base,
                                                INITRD_MAX_SIZE, &error_fatal);
+        if (pnv->initrd_size < 0) {
+            error_report("Could not load initrd '%s'",
+                         machine->initrd_filename);
+            exit(1);
+        }
     }
 
     /* load dtb if passed */
diff --git a/hw/ppc/ppc440_bamboo.c b/hw/ppc/ppc440_bamboo.c
index 2dde008b0e..b9c30d8929 100644
--- a/hw/ppc/ppc440_bamboo.c
+++ b/hw/ppc/ppc440_bamboo.c
@@ -244,6 +244,10 @@ static void bamboo_init(MachineState *machine)
         initrd_size = load_image_targphys(initrd_filename, RAMDISK_ADDR,
                                           machine->ram_size - RAMDISK_ADDR,
                                           &error_fatal);
+        if (initrd_size < 0) {
+            error_report("Could not load initrd '%s'", initrd_filename);
+            exit(1);
+        }
     }
 
     /* If we're loading a kernel directly, we must load the device tree too. */
diff --git a/hw/ppc/prep.c b/hw/ppc/prep.c
index e973b34099..172a4afd71 100644
--- a/hw/ppc/prep.c
+++ b/hw/ppc/prep.c
@@ -382,6 +382,11 @@ static void ibm_40p_init(MachineState *machine)
                                           kernel_base,
                                           machine->ram_size - kernel_base,
                                           &error_fatal);
+        if (kernel_size < 0) {
+            error_report("Could not load kernel '%s'",
+                         machine->kernel_filename);
+            exit(1);
+        }
         fw_cfg_add_i32(fw_cfg, FW_CFG_KERNEL_ADDR, kernel_base);
         fw_cfg_add_i32(fw_cfg, FW_CFG_KERNEL_SIZE, kernel_size);
         /* load initrd */
@@ -391,6 +396,11 @@ static void ibm_40p_init(MachineState *machine)
                                               initrd_base,
                                               machine->ram_size - initrd_base,
                                               &error_fatal);
+            if (initrd_size < 0) {
+                error_report("Could not load initrd '%s'",
+                             machine->initrd_filename);
+                exit(1);
+            }
             fw_cfg_add_i32(fw_cfg, FW_CFG_INITRD_ADDR, initrd_base);
             fw_cfg_add_i32(fw_cfg, FW_CFG_INITRD_SIZE, initrd_size);
         }
diff --git a/hw/ppc/sam460ex.c b/hw/ppc/sam460ex.c
index b13dd224ba..0747555bc8 100644
--- a/hw/ppc/sam460ex.c
+++ b/hw/ppc/sam460ex.c
@@ -493,6 +493,11 @@ static void sam460ex_init(MachineState *machine)
                                           RAMDISK_ADDR,
                                           machine->ram_size - RAMDISK_ADDR,
                                           &error_fatal);
+        if (initrd_size < 0) {
+            error_report("Could not load initrd '%s'",
+                         machine->initrd_filename);
+            exit(1);
+        }
     }
 
     /* If we're loading a kernel directly, we must load the device tree too. */
diff --git a/hw/ppc/spapr.c b/hw/ppc/spapr.c
index 0ab39dfea6..7ab6a47c5b 100644
--- a/hw/ppc/spapr.c
+++ b/hw/ppc/spapr.c
@@ -2865,6 +2865,10 @@ static void spapr_machine_init(MachineState *machine)
         exit(1);
     }
     fw_size = load_image_targphys(filename, 0, FW_MAX_SIZE, &error_fatal);
+    if (fw_size < 0) {
+        error_report("Could not load LPAR firmware '%s'", filename);
+        exit(1);
+    }
 
     /*
      * if Secure VM (PEF) support is configured, then initialize it
@@ -3124,6 +3128,10 @@ static void spapr_machine_init(MachineState *machine)
                                                 spapr->initrd_base,
                                                 load_limit - spapr->initrd_base,
                                                 &error_fatal);
+            if (spapr->initrd_size < 0) {
+                error_report("Could not load initrd '%s'", initrd_filename);
+                exit(1);
+            }
         }
     }
 
diff --git a/hw/ppc/virtex_ml507.c b/hw/ppc/virtex_ml507.c
index 51b3d7d712..b125561dd6 100644
--- a/hw/ppc/virtex_ml507.c
+++ b/hw/ppc/virtex_ml507.c
@@ -255,6 +255,10 @@ static void virtex_init(MachineState *machine)
             kernel_size = load_image_targphys(kernel_filename,
                                               boot_offset,
                                               machine->ram_size, &error_fatal);
+            if (kernel_size < 0) {
+                error_report("could not load kernel '%s'", kernel_filename);
+                exit(1);
+            }
             boot_info.bootstrap_pc = boot_offset;
             high = boot_info.bootstrap_pc + kernel_size + 8192;
         }
@@ -267,6 +271,11 @@ static void virtex_init(MachineState *machine)
             initrd_size = load_image_targphys(machine->initrd_filename,
                                               high, machine->ram_size - high,
                                               &error_fatal);
+            if (initrd_size < 0) {
+                error_report("could not load initrd '%s'",
+                             machine->initrd_filename);
+                exit(1);
+            }
             high = ROUND_UP(high + initrd_size, 4);
         }
 
-- 
2.43.0


