Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 80119103E18B
	for <qemu-devel@archiver.kernel.org>; Wed, 18 Mar 2026 14:15:38 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w2rgF-0006yj-Sy; Wed, 18 Mar 2026 10:15:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vikingtc4@gmail.com>)
 id 1w2rgE-0006yS-Mt
 for qemu-devel@nongnu.org; Wed, 18 Mar 2026 10:15:26 -0400
Received: from mail-pf1-x42a.google.com ([2607:f8b0:4864:20::42a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <vikingtc4@gmail.com>)
 id 1w2rgC-0005zC-Tp
 for qemu-devel@nongnu.org; Wed, 18 Mar 2026 10:15:26 -0400
Received: by mail-pf1-x42a.google.com with SMTP id
 d2e1a72fcca58-829759ca646so4184098b3a.2
 for <qemu-devel@nongnu.org>; Wed, 18 Mar 2026 07:15:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1773843323; x=1774448123; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=0JwfkhT9sSlS9UqhjPbzhhn/aYQKLtUB2y+zwcN3UPM=;
 b=dPDbyJ8FXP+9PMx1GohxCvh4/hMmMwJGBf/C6j65FIDJvA22qpDupWREIIkbbZlL/p
 VF9/yskaGwgoXEQHFQb7Pkap+9ncE4mNXCYt4TrJYewnPZzXmoDkfHmxSId7VvW/yGFZ
 own503XP1AxZ2EzON+Q2fr/LG5FRGSeb0absY/aGrXWrteWSAluUsouefzeG9iH0q8D6
 F/Cz06uYUe6DTdP9ugr5Lk/Yx36MT+9+SpJxFDaBv1qtZRtfx/iEtDJ6AML36xznfWHG
 L0hUgsf859NBAtKjUCXd95nX5x5C+3LrDIP/c+Bs58Ek4UBjGiOGTOWkindjPokFgTEt
 84aQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1773843323; x=1774448123;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=0JwfkhT9sSlS9UqhjPbzhhn/aYQKLtUB2y+zwcN3UPM=;
 b=ZHPe/AuVbrejtSzdzNPzra+k9lGWjrDB4BLLK24grTq/xbJaZBfhT+ALRSh1peKOxR
 /1odMLj1g63CbSLZuL8pVMk/5uofaRK0pI/1A+6GzJ4i5UYe4A+o4WIfaIED4XSVqL48
 youTplqaUvttqwh3Oxz4gOpTQuNaszkoRgIuaxhGEAPhp1rjC9aolQUTghjUAFZBx3SF
 9CP7EnvIk1dhfbxJi8GzLkKgGwrjpUQMnr0nHEG+uCAt2GB5WlooKChsU3EEGE0o5O9G
 eS0gRYP8ukZWez/hOO4vyuwECqL/JYUUERlVGAnZTrcTWl/uy5+xE8Uhg8fGWfAD0M8g
 FRgA==
X-Gm-Message-State: AOJu0YxyljMNPx1zBEpVmtzvGwcaYzamCXLVez47kpMoouD+w96Mq2Le
 D3gZlx5SKcRy42Va1TuWeCmSPsIpVTh554mg/h7XlpJkBbxejoNt5pq8F16plG41GYY=
X-Gm-Gg: ATEYQzzvcytNWfCj4eVzgYR1d3EJIDydUQIkUVtNIAdVAuexj0Sl0++kbdgp9FqXR1F
 BtNsU1Nlt1xHgqLOndYzbZeDT6X+gsSBQB1kdonavayIAg20YQvQtIcsjwCt3fSoM5QdKidGhd0
 nIZNOpN9ySVlTN285Mhp5M0kfWewJteWqBCMDXYSiqmpHXIPtARb62nUX3FPxuzfEPb9ilJUjj9
 7En0cEwy5wH3VCFozHubqObOfnuH/tEMxQybUyUrCTqRMQDu/noqIpjFKqivvoq4BxlMK1T7DLp
 xGZQ3BXXI1CDaGo63CGrIKh6iMp/HXBIokd0N582uIgpMZTbX5cfVJEUfiyD4DixWoJU7XzIuwz
 BP8xGsquyzjnpeEb+dFnvO0PehcjFgGDFZQNSiWNtLgYCtCJGF71i1Ngzh6rSbD2I3r1oWiw3qY
 soulHkAxDCqjLhOWoSuug77tgpGQ53kwkteq84/gBCB3XU0lyzsgzCmP9P9bfU0qOm2Ww2iw4g4
 SVT3v64Bg==
X-Received: by 2002:a05:6a00:91de:b0:82a:6dc5:4e0c with SMTP id
 d2e1a72fcca58-82a6dc55684mr2327856b3a.27.1773843322630; 
 Wed, 18 Mar 2026 07:15:22 -0700 (PDT)
Received: from trieu2-huynh-trieuhpn-ubuntu24.bee-live.svc.cluster.local
 ([27.122.242.65]) by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-82a6af06bd7sm2927272b3a.0.2026.03.18.07.15.20
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 18 Mar 2026 07:15:22 -0700 (PDT)
From: Trieu Huynh <vikingtc4@gmail.com>
To: qemu-devel@nongnu.org
Cc: Trieu Huynh <vikingtc4@gmail.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Helge Deller <deller@gmx.de>, Thomas Huth <th.huth+qemu@posteo.eu>,
 Laurent Vivier <laurent@vivier.eu>,
 "Edgar E. Iglesias" <edgar.iglesias@gmail.com>
Subject: [PATCH v3 1/4] hw/core/loader: fix error handling for
 load_image_targphys callers
Date: Wed, 18 Mar 2026 23:14:10 +0900
Message-ID: <20260318141415.8538-2-vikingtc4@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260318141415.8538-1-vikingtc4@gmail.com>
References: <20260318141415.8538-1-vikingtc4@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::42a;
 envelope-from=vikingtc4@gmail.com; helo=mail-pf1-x42a.google.com
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

Use QEMU's Error API to handle load_image_targphys() failures
consistently across callers.

- Use &error_fatal for callers that previously passed NULL, ensuring
the process exits early on failure instead of continuing in an invalid
state.
- No functional changes.

Resolves: https://gitlab.com/qemu-project/qemu/-/issues/413
Signed-off-by: Trieu Huynh <vikingtc4@gmail.com>
---
 hw/alpha/dp264.c     |  2 +-
 hw/hppa/machine.c    |  2 +-
 hw/m68k/next-cube.c  | 11 +++++++++--
 hw/m68k/q800.c       |  2 +-
 hw/m68k/virt.c       |  2 +-
 hw/microblaze/boot.c |  3 ++-
 6 files changed, 15 insertions(+), 7 deletions(-)

diff --git a/hw/alpha/dp264.c b/hw/alpha/dp264.c
index 98219f0456..2ab3c14747 100644
--- a/hw/alpha/dp264.c
+++ b/hw/alpha/dp264.c
@@ -190,7 +190,7 @@ static void clipper_init(MachineState *machine)
             /* Put the initrd image as high in memory as possible.  */
             initrd_base = (ram_size - initrd_size) & TARGET_PAGE_MASK;
             load_image_targphys(initrd_filename, initrd_base,
-                                ram_size - initrd_base, NULL);
+                                ram_size - initrd_base, &error_fatal);
 
             address_space_stq_le(&address_space_memory, param_offset + 0x100,
                                  initrd_base + 0xfffffc0000000000ULL,
diff --git a/hw/hppa/machine.c b/hw/hppa/machine.c
index ec63dc1297..99a4c22c73 100644
--- a/hw/hppa/machine.c
+++ b/hw/hppa/machine.c
@@ -507,7 +507,7 @@ static void machine_HP_common_init_tail(MachineState *machine, PCIBus *pci_bus,
             }
 
             load_image_targphys(initrd_filename, initrd_base, initrd_size,
-                                NULL);
+                                &error_fatal);
             cpu[0]->env.initrd_base = initrd_base;
             cpu[0]->env.initrd_end  = initrd_base + initrd_size;
         }
diff --git a/hw/m68k/next-cube.c b/hw/m68k/next-cube.c
index 26177c7b86..4bfe5bcf56 100644
--- a/hw/m68k/next-cube.c
+++ b/hw/m68k/next-cube.c
@@ -1326,9 +1326,16 @@ static void next_cube_init(MachineState *machine)
     memory_region_init_alias(&m->rom2, NULL, "next.rom2", &m->rom, 0x0,
                              0x20000);
     memory_region_add_subregion(sysmem, 0x0, &m->rom2);
-    if (load_image_targphys(bios_name, 0x01000000, 0x20000, NULL) < 8) {
+    Error *local_err = NULL;
+    if (load_image_targphys(bios_name, 0x01000000, 0x20000, &local_err) < 8) {
         if (!qtest_enabled()) {
-            error_report("Failed to load firmware '%s'.", bios_name);
+            if (local_err) {
+                error_report_err(local_err);
+            } else {
+                error_report("Firmware image '%s' is too short.", bios_name);
+            }
+        } else {
+            error_free(local_err);
         }
     } else {
         uint8_t *ptr;
diff --git a/hw/m68k/q800.c b/hw/m68k/q800.c
index ded531394e..c0d78eb7d7 100644
--- a/hw/m68k/q800.c
+++ b/hw/m68k/q800.c
@@ -633,7 +633,7 @@ static void q800_machine_init(MachineState *machine)
 
             initrd_base = (ram_size - initrd_size) & TARGET_PAGE_MASK;
             load_image_targphys(initrd_filename, initrd_base,
-                                ram_size - initrd_base, NULL);
+                                ram_size - initrd_base, &error_fatal);
             BOOTINFO2(param_ptr, BI_RAMDISK, initrd_base,
                       initrd_size);
         } else {
diff --git a/hw/m68k/virt.c b/hw/m68k/virt.c
index e67900c727..ffe6e23415 100644
--- a/hw/m68k/virt.c
+++ b/hw/m68k/virt.c
@@ -292,7 +292,7 @@ static void virt_init(MachineState *machine)
 
             initrd_base = (ram_size - initrd_size) & TARGET_PAGE_MASK;
             load_image_targphys(initrd_filename, initrd_base,
-                                ram_size - initrd_base, NULL);
+                                ram_size - initrd_base, &error_fatal);
             BOOTINFO2(param_ptr, BI_RAMDISK, initrd_base,
                       initrd_size);
         } else {
diff --git a/hw/microblaze/boot.c b/hw/microblaze/boot.c
index a6f9ebab90..4ad5ffd34b 100644
--- a/hw/microblaze/boot.c
+++ b/hw/microblaze/boot.c
@@ -38,6 +38,7 @@
 #include "hw/core/loader.h"
 #include "elf.h"
 #include "qemu/cutils.h"
+#include "qapi/error.h"
 
 #include "boot.h"
 
@@ -171,7 +172,7 @@ void microblaze_load_kernel(MicroBlazeCPU *cpu, bool is_little_endian,
         /* Not an ELF image nor an u-boot image, try a RAW image.  */
         if (kernel_size < 0) {
             kernel_size = load_image_targphys(kernel_filename, ddr_base,
-                                              ramsize, NULL);
+                                              ramsize, &error_fatal);
             boot_info.bootstrap_pc = ddr_base;
             high = (ddr_base + kernel_size + 3) & ~3;
         }
-- 
2.43.0


