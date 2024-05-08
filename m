Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7B4C5C04FFE
	for <qemu-devel@archiver.kernel.org>; Wed,  8 May 2024 22:16:01 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s4pZT-0006Wt-Qm; Wed, 08 May 2024 18:15:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1s4pZR-0006WV-Ha
 for qemu-devel@nongnu.org; Wed, 08 May 2024 18:15:29 -0400
Received: from mail-wm1-x331.google.com ([2a00:1450:4864:20::331])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1s4pZP-0003jK-OD
 for qemu-devel@nongnu.org; Wed, 08 May 2024 18:15:29 -0400
Received: by mail-wm1-x331.google.com with SMTP id
 5b1f17b1804b1-41b782405d5so2799305e9.2
 for <qemu-devel@nongnu.org>; Wed, 08 May 2024 15:15:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1715206526; x=1715811326; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=8mkrQbTSDfr6usqNAQCgkl4RFyC7PF3bv4H4UAYJ3WU=;
 b=XBgHEMu/3A0Picc9eb2FRA925ew+GAwNkOXWpsxlRh22oCDyYmR0SUmyTDAzdxs1A4
 u3FdNuebcy4NZzcsumfmBzr1nlKIfwDqMJ0/ji4dV2SqHQuEF4Wt1QwPDirVE3HmQQlb
 owQ9GhMZH0voj8m3zE0gX9D8QnvNC6LmHIp/4Xxx47GhfJ6MaBdQTIwj7DOY6JuFn76M
 0Z3inD1YWVwjGzXnHn3s7N6APG50G78Dm3hGEog+kM6dS8Sf1y2Fe74zTNF3QCA/lzur
 iDcmkqbEWZtM4LmFzIGdcMf+A28eq0DSBHIJUMEl7Om9/5HDZzHlt9G63wOVSYYegcjm
 6euQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1715206526; x=1715811326;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=8mkrQbTSDfr6usqNAQCgkl4RFyC7PF3bv4H4UAYJ3WU=;
 b=MvdDD2CEfQdqTI4Q59K05X3kXFc01KVEC4K6AtiUcXoEJKma12CvCfrNjtx6oyyUK3
 KYbHw2nIoDBNsSTWFBUiSSdCR4FuFBaMe8tjPFmhtjlYorE/QHoCrbqRFLN2JoCvoaDe
 kJ/+Br3hLmLUD+qffn9bZzVuIIKswEDkBNje8nArr49PdzgTCIoqHvc9AtZ3qA5NezWM
 s8zrRvg9QU7jBeFqIzld6rb+0vdU9DdYlf02ayFCDeQR5lqtYwxOcdANWsGxt8234dZS
 p28jEBjCrVr8HbYtLZFcTEnENSl8q7vIQSsbF6DM62e3lZCmhX8i8WrkPKK0Cd76htmm
 zP1Q==
X-Gm-Message-State: AOJu0Yzs5PlJdWcHRdak2e0CbSIyZLJxD/y+sZF6mMshHPdIw3h28mP+
 BhR29WiieYrNxUzy3Mv2HaDysXLPHbX85nvWYOUGA0pLOkdtvFNnMqU22QLTz8jnbJPAriFYCd4
 5
X-Google-Smtp-Source: AGHT+IE9C9Z/Llp8JWcsA0bT1jyvom8cCo0Ixg9iHkE6iWhQAXM8/xtBhKL3rfr44IsReSsaIyBFfA==
X-Received: by 2002:a05:600c:1f81:b0:419:a3f:f4f6 with SMTP id
 5b1f17b1804b1-41f71302dbdmr33632955e9.8.1715206526068; 
 Wed, 08 May 2024 15:15:26 -0700 (PDT)
Received: from m1x-phil.lan (sar95-h02-176-184-10-250.dsl.sta.abo.bbox.fr.
 [176.184.10.250]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3502b8a7884sm10068f8f.57.2024.05.08.15.15.24
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Wed, 08 May 2024 15:15:25 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Bernhard Beschow <shentey@gmail.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PULL v2 14/28] hw/i386/x86: Don't leak "isa-bios" memory regions
Date: Thu,  9 May 2024 00:15:16 +0200
Message-ID: <20240508221518.72350-2-philmd@linaro.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20240508221518.72350-1-philmd@linaro.org>
References: <20240508221518.72350-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::331;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x331.google.com
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

From: Bernhard Beschow <shentey@gmail.com>

Fix the leaking in x86_bios_rom_init() and pc_isa_bios_init() by adding an
"isa_bios" attribute to X86MachineState.

Suggested-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Signed-off-by: Bernhard Beschow <shentey@gmail.com>
Message-ID: <20240508175507.22270-4-shentey@gmail.com>
Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 include/hw/i386/x86.h | 7 +++++++
 hw/i386/pc_sysfw.c    | 7 +++----
 hw/i386/x86.c         | 9 ++++-----
 3 files changed, 14 insertions(+), 9 deletions(-)

diff --git a/include/hw/i386/x86.h b/include/hw/i386/x86.h
index cb07618d19..a07de79167 100644
--- a/include/hw/i386/x86.h
+++ b/include/hw/i386/x86.h
@@ -18,6 +18,7 @@
 #define HW_I386_X86_H
 
 #include "exec/hwaddr.h"
+#include "exec/memory.h"
 
 #include "hw/boards.h"
 #include "hw/intc/ioapic.h"
@@ -52,6 +53,12 @@ struct X86MachineState {
     GMappedFile *initrd_mapped_file;
     HotplugHandler *acpi_dev;
 
+    /*
+     * Map the upper 128 KiB of the BIOS just underneath the 1 MiB address
+     * boundary.
+     */
+    MemoryRegion isa_bios;
+
     /* RAM information (sizes, addresses, configuration): */
     ram_addr_t below_4g_mem_size, above_4g_mem_size;
 
diff --git a/hw/i386/pc_sysfw.c b/hw/i386/pc_sysfw.c
index 59c7a81692..82d37cb376 100644
--- a/hw/i386/pc_sysfw.c
+++ b/hw/i386/pc_sysfw.c
@@ -40,11 +40,10 @@
 
 #define FLASH_SECTOR_SIZE 4096
 
-static void pc_isa_bios_init(MemoryRegion *rom_memory,
+static void pc_isa_bios_init(MemoryRegion *isa_bios, MemoryRegion *rom_memory,
                              MemoryRegion *flash_mem)
 {
     int isa_bios_size;
-    MemoryRegion *isa_bios;
     uint64_t flash_size;
     void *flash_ptr, *isa_bios_ptr;
 
@@ -52,7 +51,6 @@ static void pc_isa_bios_init(MemoryRegion *rom_memory,
 
     /* map the last 128KB of the BIOS in ISA space */
     isa_bios_size = MIN(flash_size, 128 * KiB);
-    isa_bios = g_malloc(sizeof(*isa_bios));
     memory_region_init_ram(isa_bios, NULL, "isa-bios", isa_bios_size,
                            &error_fatal);
     memory_region_add_subregion_overlap(rom_memory,
@@ -136,6 +134,7 @@ void pc_system_flash_cleanup_unused(PCMachineState *pcms)
 static void pc_system_flash_map(PCMachineState *pcms,
                                 MemoryRegion *rom_memory)
 {
+    X86MachineState *x86ms = X86_MACHINE(pcms);
     hwaddr total_size = 0;
     int i;
     BlockBackend *blk;
@@ -185,7 +184,7 @@ static void pc_system_flash_map(PCMachineState *pcms,
 
         if (i == 0) {
             flash_mem = pflash_cfi01_get_memory(system_flash);
-            pc_isa_bios_init(rom_memory, flash_mem);
+            pc_isa_bios_init(&x86ms->isa_bios, rom_memory, flash_mem);
 
             /* Encrypt the pflash boot ROM */
             if (sev_enabled()) {
diff --git a/hw/i386/x86.c b/hw/i386/x86.c
index 6d3c72f124..457e8a34a5 100644
--- a/hw/i386/x86.c
+++ b/hw/i386/x86.c
@@ -1133,7 +1133,7 @@ void x86_bios_rom_init(X86MachineState *x86ms, const char *default_firmware,
 {
     const char *bios_name;
     char *filename;
-    MemoryRegion *bios, *isa_bios;
+    MemoryRegion *bios;
     int bios_size, isa_bios_size;
     ssize_t ret;
 
@@ -1173,14 +1173,13 @@ void x86_bios_rom_init(X86MachineState *x86ms, const char *default_firmware,
 
     /* map the last 128KB of the BIOS in ISA space */
     isa_bios_size = MIN(bios_size, 128 * KiB);
-    isa_bios = g_malloc(sizeof(*isa_bios));
-    memory_region_init_alias(isa_bios, NULL, "isa-bios", bios,
+    memory_region_init_alias(&x86ms->isa_bios, NULL, "isa-bios", bios,
                              bios_size - isa_bios_size, isa_bios_size);
     memory_region_add_subregion_overlap(rom_memory,
                                         0x100000 - isa_bios_size,
-                                        isa_bios,
+                                        &x86ms->isa_bios,
                                         1);
-    memory_region_set_readonly(isa_bios, !isapc_ram_fw);
+    memory_region_set_readonly(&x86ms->isa_bios, !isapc_ram_fw);
 
     /* map all the bios at the top of memory */
     memory_region_add_subregion(rom_memory,
-- 
2.41.0


