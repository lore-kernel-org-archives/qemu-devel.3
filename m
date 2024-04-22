Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9E5CBC10F15
	for <qemu-devel@archiver.kernel.org>; Mon, 22 Apr 2024 20:07:44 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ryzw8-0007Tb-94; Mon, 22 Apr 2024 16:06:48 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <shentey@gmail.com>) id 1ryzw4-0007TI-Vz
 for qemu-devel@nongnu.org; Mon, 22 Apr 2024 16:06:45 -0400
Received: from mail-lf1-x132.google.com ([2a00:1450:4864:20::132])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <shentey@gmail.com>) id 1ryzw3-0004i3-5t
 for qemu-devel@nongnu.org; Mon, 22 Apr 2024 16:06:44 -0400
Received: by mail-lf1-x132.google.com with SMTP id
 2adb3069b0e04-518a3e0d2ecso7238032e87.3
 for <qemu-devel@nongnu.org>; Mon, 22 Apr 2024 13:06:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1713816400; x=1714421200; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=PuRE8lv8XMhRFudEtOkTIi3D71/1B4iCJia6S9gyhAM=;
 b=RaBcF6JbwmesWsc70J66Amq4EqW6n1EH3HkWe/Nbd+qxwHZSKJMsLjjzEWcQkgwYa5
 j4OzQKKvmnBPdAUX60D2vS1VBmnb0RSRFNf4+qjR4BScyTYCsX3wu5sq4ZXeFMoxQBpK
 0bFYbW76MP7+C4nUMpV975NNDrH2Uv5+Mv30Dq8WphP+zQIJE9J5oe1rpPmm8X82aZ88
 p5XcIohwqTW9jZw0TW1CS9/GtzVCwzEoGfcZWcMOPFg22/YU57cPUzW4I4Djw1v+7Ukp
 JdSKukvOFYqjrGbMVYaYCXzfkjX+H2U8bKqMwG+6PWeiKTu13TDbIJxO0Echg21QZPuX
 hOiA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1713816400; x=1714421200;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=PuRE8lv8XMhRFudEtOkTIi3D71/1B4iCJia6S9gyhAM=;
 b=jh7C1tZR1P2Or9rhloQkp6xkljG9xqJSHh1H8WYKaJnjHpQTbu3kGgs/D0aZir7snC
 n+rAoOZEQcO2OHZ89Vnl1h29zCYH5BqCHe5zMeu9sQICFLgxtrdDFn0ugdOOg1NiKAfP
 vszqO7NO/n56z9EwqG0E3PuM7gEyuwf8gZqwOEGtj85T/gX/Hu0Cm40nZApejjMJtrOq
 rhTafBWwqsjYYppJrDBu3PCBRjthpaM5EcPmK93RBxYMMbjx6Y2upo3SntxRg2ajITFh
 1W2aPKIf/rL0abDYgg4XY7KBRPuLBJ0WvCl54KaB/LWIUA7gRgyZ7f9/VDOIzyVpb/Lj
 oENQ==
X-Gm-Message-State: AOJu0Yw92IRFVBx3ZqvpbTacU/cfkqqQmgxrXQV9mb+6A+aFhrK5FQSL
 NHNnThtfXkGIh69pAdSwmz5p3+JevsrGnhEGFZYsijN9qC8sXR9lJiUOKw==
X-Google-Smtp-Source: AGHT+IG8PPgbvm8dHQQs8xUFYYvwr0/Kpj+ec6lTKs0tZIJc+wcvaidF8k1cvmlzYhxhlyqdl0ECyQ==
X-Received: by 2002:ac2:5e8c:0:b0:519:6402:d19e with SMTP id
 b12-20020ac25e8c000000b005196402d19emr8470842lfq.68.1713816400149; 
 Mon, 22 Apr 2024 13:06:40 -0700 (PDT)
Received: from Provence.localdomain
 (dynamic-077-188-098-082.77.188.pool.telefonica.de. [77.188.98.82])
 by smtp.gmail.com with ESMTPSA id
 z2-20020a17090665c200b00a55bbc4fd16sm1209230ejn.48.2024.04.22.13.06.38
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 22 Apr 2024 13:06:39 -0700 (PDT)
From: Bernhard Beschow <shentey@gmail.com>
To: qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Eduardo Habkost <eduardo@habkost.net>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Bernhard Beschow <shentey@gmail.com>
Subject: [PATCH 4/4] hw/i386: Consolidate isa-bios creation
Date: Mon, 22 Apr 2024 22:06:25 +0200
Message-ID: <20240422200625.2768-5-shentey@gmail.com>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240422200625.2768-1-shentey@gmail.com>
References: <20240422200625.2768-1-shentey@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::132;
 envelope-from=shentey@gmail.com; helo=mail-lf1-x132.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
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

Now that the -bios and -pflash code paths work the same it is possible to have a
common implementation.

While at it convert the magic number 0x100000 (== 1MiB) to increase readability.

Signed-off-by: Bernhard Beschow <shentey@gmail.com>
---
 include/hw/i386/x86.h |  2 ++
 hw/i386/pc_sysfw.c    | 28 ++++------------------------
 hw/i386/x86.c         | 29 ++++++++++++++++++-----------
 3 files changed, 24 insertions(+), 35 deletions(-)

diff --git a/include/hw/i386/x86.h b/include/hw/i386/x86.h
index 4dc30dcb4d..8e6ba4a726 100644
--- a/include/hw/i386/x86.h
+++ b/include/hw/i386/x86.h
@@ -116,6 +116,8 @@ void x86_cpu_unplug_request_cb(HotplugHandler *hotplug_dev,
 void x86_cpu_unplug_cb(HotplugHandler *hotplug_dev,
                        DeviceState *dev, Error **errp);
 
+void x86_isa_bios_init(MemoryRegion *rom_memory, MemoryRegion *bios,
+                       bool isapc_ram_fw);
 void x86_bios_rom_init(MachineState *ms, const char *default_firmware,
                        MemoryRegion *rom_memory, bool isapc_ram_fw);
 
diff --git a/hw/i386/pc_sysfw.c b/hw/i386/pc_sysfw.c
index 6e89671c26..e529182b48 100644
--- a/hw/i386/pc_sysfw.c
+++ b/hw/i386/pc_sysfw.c
@@ -28,7 +28,6 @@
 #include "sysemu/block-backend.h"
 #include "qemu/error-report.h"
 #include "qemu/option.h"
-#include "qemu/units.h"
 #include "hw/sysbus.h"
 #include "hw/i386/x86.h"
 #include "hw/i386/pc.h"
@@ -40,27 +39,6 @@
 
 #define FLASH_SECTOR_SIZE 4096
 
-static void pc_isa_bios_init(MemoryRegion *rom_memory,
-                             MemoryRegion *flash_mem)
-{
-    int isa_bios_size;
-    MemoryRegion *isa_bios;
-    uint64_t flash_size;
-
-    flash_size = memory_region_size(flash_mem);
-
-    /* map the last 128KB of the BIOS in ISA space */
-    isa_bios_size = MIN(flash_size, 128 * KiB);
-    isa_bios = g_malloc(sizeof(*isa_bios));
-    memory_region_init_alias(isa_bios, NULL, "isa-bios", flash_mem,
-                             flash_size - isa_bios_size, isa_bios_size);
-    memory_region_add_subregion_overlap(rom_memory,
-                                        0x100000 - isa_bios_size,
-                                        isa_bios,
-                                        1);
-    memory_region_set_readonly(isa_bios, true);
-}
-
 static PFlashCFI01 *pc_pflash_create(PCMachineState *pcms,
                                      const char *name,
                                      const char *alias_prop_name)
@@ -121,7 +99,7 @@ void pc_system_flash_cleanup_unused(PCMachineState *pcms)
  * pcms->max_fw_size.
  *
  * If pcms->flash[0] has a block backend, its memory is passed to
- * pc_isa_bios_init().  Merging several flash devices for isa-bios is
+ * x86_isa_bios_init(). Merging several flash devices for isa-bios is
  * not supported.
  */
 static void pc_system_flash_map(PCMachineState *pcms,
@@ -176,7 +154,9 @@ static void pc_system_flash_map(PCMachineState *pcms,
 
         if (i == 0) {
             flash_mem = pflash_cfi01_get_memory(system_flash);
-            pc_isa_bios_init(rom_memory, flash_mem);
+
+            /* Map the last 128KB of the BIOS in ISA space */
+            x86_isa_bios_init(rom_memory, flash_mem, false);
 
             /* Encrypt the pflash boot ROM */
             if (sev_enabled()) {
diff --git a/hw/i386/x86.c b/hw/i386/x86.c
index 32cd22a4a8..7366b0cee4 100644
--- a/hw/i386/x86.c
+++ b/hw/i386/x86.c
@@ -1136,13 +1136,28 @@ void x86_load_linux(X86MachineState *x86ms,
     nb_option_roms++;
 }
 
+void x86_isa_bios_init(MemoryRegion *rom_memory, MemoryRegion *bios,
+                       bool isapc_ram_fw)
+{
+    int bios_size = memory_region_size(bios);
+    int isa_bios_size = MIN(bios_size, 128 * KiB);
+    MemoryRegion *isa_bios;
+
+    isa_bios = g_malloc(sizeof(*isa_bios));
+    memory_region_init_alias(isa_bios, NULL, "isa-bios", bios,
+                             bios_size - isa_bios_size, isa_bios_size);
+    memory_region_add_subregion_overlap(rom_memory, 1 * MiB - isa_bios_size,
+                                        isa_bios, 1);
+    memory_region_set_readonly(isa_bios, !isapc_ram_fw);
+}
+
 void x86_bios_rom_init(MachineState *ms, const char *default_firmware,
                        MemoryRegion *rom_memory, bool isapc_ram_fw)
 {
     const char *bios_name;
     char *filename;
-    MemoryRegion *bios, *isa_bios;
-    int bios_size, isa_bios_size;
+    MemoryRegion *bios;
+    int bios_size;
     ssize_t ret;
 
     /* BIOS load */
@@ -1180,15 +1195,7 @@ void x86_bios_rom_init(MachineState *ms, const char *default_firmware,
     g_free(filename);
 
     /* map the last 128KB of the BIOS in ISA space */
-    isa_bios_size = MIN(bios_size, 128 * KiB);
-    isa_bios = g_malloc(sizeof(*isa_bios));
-    memory_region_init_alias(isa_bios, NULL, "isa-bios", bios,
-                             bios_size - isa_bios_size, isa_bios_size);
-    memory_region_add_subregion_overlap(rom_memory,
-                                        0x100000 - isa_bios_size,
-                                        isa_bios,
-                                        1);
-    memory_region_set_readonly(isa_bios, !isapc_ram_fw);
+    x86_isa_bios_init(rom_memory, bios, isapc_ram_fw);
 
     /* map all the bios at the top of memory */
     memory_region_add_subregion(rom_memory,
-- 
2.44.0


