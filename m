Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6D12EC25B4F
	for <qemu-devel@archiver.kernel.org>; Wed,  8 May 2024 22:15:58 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s4pZb-0006bU-K7; Wed, 08 May 2024 18:15:40 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1s4pZX-0006b5-MV
 for qemu-devel@nongnu.org; Wed, 08 May 2024 18:15:37 -0400
Received: from mail-wm1-x32a.google.com ([2a00:1450:4864:20::32a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1s4pZV-0003ke-Vy
 for qemu-devel@nongnu.org; Wed, 08 May 2024 18:15:35 -0400
Received: by mail-wm1-x32a.google.com with SMTP id
 5b1f17b1804b1-41b79450f8cso1624485e9.3
 for <qemu-devel@nongnu.org>; Wed, 08 May 2024 15:15:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1715206531; x=1715811331; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=7whZLzg21d/liml4UNZ34ou/FOI3IC4dYsrPvQ2r0tc=;
 b=P4IBk4l7tT993IicnohPjhkY1kfl0f+uBRvxzeNyCBH7BmVof/CA7U7hVzpwPKIsjr
 gnIZIPCPql7zD6GIvv6EzhzwhZfL+DPhs+9lD92/DATH7KNXIign0CSvD7jz2CaSy/fc
 DgAcYUSeLgwWwZTnd2OfFmU4fE+rG1yrHsznOTgqygFQINKAv+oefR/smK+cZQLWTjNW
 Vg7RJhzC0aZf6OMlq3BfflUx4cOWocVhs2pxQi+LFbq0AEa6/0Wi8vJvep/qdDte5cYn
 R3W4ve3S0qYWMpJjamsx9mnnjjjIa4OIhTJRmcbKfVl79lDtiAXc7q0RfZvlMqAh+qxF
 mJPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1715206531; x=1715811331;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=7whZLzg21d/liml4UNZ34ou/FOI3IC4dYsrPvQ2r0tc=;
 b=gRaOTuSsdUWVfZieE91pd10dobPnd/JXgp2+Euc9kaMiVU52RQN4hj93c8R1T6hEJF
 urOC6yyVqg2ydc9nMV9aNhX3s8noYy9BJP0IlLUMnAxnDAFSsT7ss0BiB1+UcurPgDV7
 BioEofDhjBVxLGeCBANBc0QnlP1JjZsBlWuNtx3ATWTaEW9SaCtJFYohXxT04EFE5wr6
 GN1uwrYmsnjJzwUJi3kgogJ1kE28WzFRPjpyLdNjgQP8SZ1cqaxM4ihUsyiyN95hk5QC
 ak8c3hPC1W4IjItZ/ZSjwkw4hThPohv+yEtBrBbTtU/f5hicRijiPoRRgOr3FMyVgeta
 h6KQ==
X-Gm-Message-State: AOJu0YwLUz7T+/KkCqQlleybwWsufRy1kOAYwtt99ILw8Xk4cRuzCApD
 76Y+auuY9ueh2p4iBeIIsCfImd5FD5xUz93GF9doqaQq+MHNEKRKO+CM7DGPUYWiemNEzwMYDQp
 I
X-Google-Smtp-Source: AGHT+IF5uribdVMGvTLjDilieqVEW2GJrYmjne9iafGd5eRDxqOg5cXmVE4IPAxwPtKd5dPFp/81Mw==
X-Received: by 2002:a05:600c:3b22:b0:41b:55b1:6cfc with SMTP id
 5b1f17b1804b1-41f71cc14famr27983225e9.1.1715206531458; 
 Wed, 08 May 2024 15:15:31 -0700 (PDT)
Received: from m1x-phil.lan (sar95-h02-176-184-10-250.dsl.sta.abo.bbox.fr.
 [176.184.10.250]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-41f87c254bfsm36821865e9.17.2024.05.08.15.15.30
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Wed, 08 May 2024 15:15:31 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Bernhard Beschow <shentey@gmail.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PULL v2 15/28] hw/i386/x86: Don't leak "pc.bios" memory region
Date: Thu,  9 May 2024 00:15:17 +0200
Message-ID: <20240508221518.72350-3-philmd@linaro.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20240508221518.72350-1-philmd@linaro.org>
References: <20240508221518.72350-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32a;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x32a.google.com
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

Fix the leaking in x86_bios_rom_init() by adding a "bios" attribute to
X86MachineState. Note that it is only used in the -bios case.

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Signed-off-by: Bernhard Beschow <shentey@gmail.com>
Message-ID: <20240508175507.22270-5-shentey@gmail.com>
Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 include/hw/i386/x86.h |  6 ++++++
 hw/i386/x86.c         | 13 ++++++-------
 2 files changed, 12 insertions(+), 7 deletions(-)

diff --git a/include/hw/i386/x86.h b/include/hw/i386/x86.h
index a07de79167..55c6809ae0 100644
--- a/include/hw/i386/x86.h
+++ b/include/hw/i386/x86.h
@@ -53,6 +53,12 @@ struct X86MachineState {
     GMappedFile *initrd_mapped_file;
     HotplugHandler *acpi_dev;
 
+    /*
+     * Map the whole BIOS just underneath the 4 GiB address boundary. Only used
+     * in the ROM (-bios) case.
+     */
+    MemoryRegion bios;
+
     /*
      * Map the upper 128 KiB of the BIOS just underneath the 1 MiB address
      * boundary.
diff --git a/hw/i386/x86.c b/hw/i386/x86.c
index 457e8a34a5..29167de97d 100644
--- a/hw/i386/x86.c
+++ b/hw/i386/x86.c
@@ -1133,7 +1133,6 @@ void x86_bios_rom_init(X86MachineState *x86ms, const char *default_firmware,
 {
     const char *bios_name;
     char *filename;
-    MemoryRegion *bios;
     int bios_size, isa_bios_size;
     ssize_t ret;
 
@@ -1149,8 +1148,8 @@ void x86_bios_rom_init(X86MachineState *x86ms, const char *default_firmware,
         (bios_size % 65536) != 0) {
         goto bios_error;
     }
-    bios = g_malloc(sizeof(*bios));
-    memory_region_init_ram(bios, NULL, "pc.bios", bios_size, &error_fatal);
+    memory_region_init_ram(&x86ms->bios, NULL, "pc.bios", bios_size,
+                           &error_fatal);
     if (sev_enabled()) {
         /*
          * The concept of a "reset" simply doesn't exist for
@@ -1159,11 +1158,11 @@ void x86_bios_rom_init(X86MachineState *x86ms, const char *default_firmware,
          * the firmware as rom to properly re-initialize on reset.
          * Just go for a straight file load instead.
          */
-        void *ptr = memory_region_get_ram_ptr(bios);
+        void *ptr = memory_region_get_ram_ptr(&x86ms->bios);
         load_image_size(filename, ptr, bios_size);
         x86_firmware_configure(ptr, bios_size);
     } else {
-        memory_region_set_readonly(bios, !isapc_ram_fw);
+        memory_region_set_readonly(&x86ms->bios, !isapc_ram_fw);
         ret = rom_add_file_fixed(bios_name, (uint32_t)(-bios_size), -1);
         if (ret != 0) {
             goto bios_error;
@@ -1173,7 +1172,7 @@ void x86_bios_rom_init(X86MachineState *x86ms, const char *default_firmware,
 
     /* map the last 128KB of the BIOS in ISA space */
     isa_bios_size = MIN(bios_size, 128 * KiB);
-    memory_region_init_alias(&x86ms->isa_bios, NULL, "isa-bios", bios,
+    memory_region_init_alias(&x86ms->isa_bios, NULL, "isa-bios", &x86ms->bios,
                              bios_size - isa_bios_size, isa_bios_size);
     memory_region_add_subregion_overlap(rom_memory,
                                         0x100000 - isa_bios_size,
@@ -1184,7 +1183,7 @@ void x86_bios_rom_init(X86MachineState *x86ms, const char *default_firmware,
     /* map all the bios at the top of memory */
     memory_region_add_subregion(rom_memory,
                                 (uint32_t)(-bios_size),
-                                bios);
+                                &x86ms->bios);
     return;
 
 bios_error:
-- 
2.41.0


