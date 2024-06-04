Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 16D49C27C53
	for <qemu-devel@archiver.kernel.org>; Tue,  4 Jun 2024 06:49:29 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sENxZ-0000SE-DD; Tue, 04 Jun 2024 02:47:53 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1sENw5-0004vP-B4
 for qemu-devel@nongnu.org; Tue, 04 Jun 2024 02:46:22 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1sENw2-0007ex-V5
 for qemu-devel@nongnu.org; Tue, 04 Jun 2024 02:46:21 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1717483578;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=/X80aa+kiFbSRDqQh6cNU/i3xHWccd9vQvylfLP0Pq4=;
 b=DypvTpz4R+ESuz7aFqQIKi5u/UV3ezgwsUSUZNO51IlCXWmr6card/xH0cAHKs1zwKnzk8
 QoqPmLn/mq2uzOkBVhUGuCah/BQvDvukv9nT0IfoshtfQQyX8/k0E1yF9gm/dHzdfaCW9M
 7W34GtyrrNxQteeM42j1zC2TyCRglkA=
Received: from mail-ed1-f71.google.com (mail-ed1-f71.google.com
 [209.85.208.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-128-H3k53xJmOAiZb3DkpB1-WQ-1; Tue, 04 Jun 2024 02:46:16 -0400
X-MC-Unique: H3k53xJmOAiZb3DkpB1-WQ-1
Received: by mail-ed1-f71.google.com with SMTP id
 4fb4d7f45d1cf-579c69260bbso1661620a12.0
 for <qemu-devel@nongnu.org>; Mon, 03 Jun 2024 23:46:16 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1717483574; x=1718088374;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=/X80aa+kiFbSRDqQh6cNU/i3xHWccd9vQvylfLP0Pq4=;
 b=nNpJm7a+DZS0hVUGPyKHC7BWpuhtNgPDjuQAvZUro8qiUKlB6btMcuhAOXlQyAAz13
 6n3lVtsDJAoZkt0r+Lx7zJqwPb49ZB/dRz58pBkn84kiZ75sCi83QanNmp7l67bMqJLx
 0x7kF4L+DQXpiaElTQfiRcFvP9FCYxtr2MNlh2G8mqr+7o+6B9svCKAHxgm9hnmx7v2W
 dXCG7CbyuwNNBsYvvDRBCL6w2PggnatWP0gTu131gi6V9NBKh2BAcPU/byk4gNzCCIhY
 BEIqQKQW2m7/UUhuaDl+0RWkBbv+0zo/cOwjAEMGXqtpEhtEA1L3nafWmMWN0JwS3Hln
 Dzmw==
X-Gm-Message-State: AOJu0YzuHkcXSD5xS9EPQ77ysWYTVYiy4n0e3tn63Dy95G2vJjCuF+IA
 iObQkklk+qyE8rJyT0Ko5eef7TL1ILKX6T0Rtai93Kw6u9C2QlstzpSl1SWLVXWHL1bcB/57YSf
 HaNKs8qQlF0Shf3S+zf8RnlDfVJZN+NxoSbCQQeg9JNrit1XgZvDDSWeCaRsQ77l+npZDyEaWib
 YP7PvTZk/rfAg60+bFBBHyquddhnPnkfngRITD
X-Received: by 2002:a17:906:3285:b0:a67:403a:4bf7 with SMTP id
 a640c23a62f3a-a682022f933mr897204766b.26.1717483574707; 
 Mon, 03 Jun 2024 23:46:14 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEFhZZ3IAIa1VY2AK974K/c76EJgSIV6kg8wrA+8gChW6UPanqzZKiaAGTjXpHifjvpPnKmBA==
X-Received: by 2002:a17:906:3285:b0:a67:403a:4bf7 with SMTP id
 a640c23a62f3a-a682022f933mr897203666b.26.1717483574389; 
 Mon, 03 Jun 2024 23:46:14 -0700 (PDT)
Received: from avogadro.local ([151.81.115.112])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-a68b5e8b0fasm441448066b.214.2024.06.03.23.46.13
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 03 Jun 2024 23:46:14 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: Michael Roth <michael.roth@amd.com>,
	Pankaj Gupta <pankaj.gupta@amd.com>
Subject: [PULL 44/45] hw/i386/sev: Use guest_memfd for legacy ROMs
Date: Tue,  4 Jun 2024 08:44:08 +0200
Message-ID: <20240604064409.957105-45-pbonzini@redhat.com>
X-Mailer: git-send-email 2.45.1
In-Reply-To: <20240604064409.957105-1-pbonzini@redhat.com>
References: <20240604064409.957105-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

From: Michael Roth <michael.roth@amd.com>

Current SNP guest kernels will attempt to access these regions with
with C-bit set, so guest_memfd is needed to handle that. Otherwise,
kvm_convert_memory() will fail when the guest kernel tries to access it
and QEMU attempts to call KVM_SET_MEMORY_ATTRIBUTES to set these ranges
to private.

Whether guests should actually try to access ROM regions in this way (or
need to deal with legacy ROM regions at all), is a separate issue to be
addressed on kernel side, but current SNP guest kernels will exhibit
this behavior and so this handling is needed to allow QEMU to continue
running existing SNP guest kernels.

Signed-off-by: Michael Roth <michael.roth@amd.com>
[pankaj: Added sev_snp_enabled() check]
Signed-off-by: Pankaj Gupta <pankaj.gupta@amd.com>
Message-ID: <20240530111643.1091816-28-pankaj.gupta@amd.com>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 hw/i386/pc.c       | 14 ++++++++++----
 hw/i386/pc_sysfw.c | 19 +++++++++++++------
 2 files changed, 23 insertions(+), 10 deletions(-)

diff --git a/hw/i386/pc.c b/hw/i386/pc.c
index 7b638da7aaa..0469af00a78 100644
--- a/hw/i386/pc.c
+++ b/hw/i386/pc.c
@@ -62,6 +62,7 @@
 #include "hw/mem/memory-device.h"
 #include "e820_memory_layout.h"
 #include "trace.h"
+#include "sev.h"
 #include CONFIG_DEVICES
 
 #ifdef CONFIG_XEN_EMU
@@ -1022,10 +1023,15 @@ void pc_memory_init(PCMachineState *pcms,
     pc_system_firmware_init(pcms, rom_memory);
 
     option_rom_mr = g_malloc(sizeof(*option_rom_mr));
-    memory_region_init_ram(option_rom_mr, NULL, "pc.rom", PC_ROM_SIZE,
-                           &error_fatal);
-    if (pcmc->pci_enabled) {
-        memory_region_set_readonly(option_rom_mr, true);
+    if (machine_require_guest_memfd(machine)) {
+        memory_region_init_ram_guest_memfd(option_rom_mr, NULL, "pc.rom",
+                                           PC_ROM_SIZE, &error_fatal);
+    } else {
+        memory_region_init_ram(option_rom_mr, NULL, "pc.rom", PC_ROM_SIZE,
+                               &error_fatal);
+        if (pcmc->pci_enabled) {
+            memory_region_set_readonly(option_rom_mr, true);
+        }
     }
     memory_region_add_subregion_overlap(rom_memory,
                                         PC_ROM_MIN_VGA,
diff --git a/hw/i386/pc_sysfw.c b/hw/i386/pc_sysfw.c
index 7cdbafc8d22..ef80281d28b 100644
--- a/hw/i386/pc_sysfw.c
+++ b/hw/i386/pc_sysfw.c
@@ -40,8 +40,8 @@
 
 #define FLASH_SECTOR_SIZE 4096
 
-static void pc_isa_bios_init(MemoryRegion *isa_bios, MemoryRegion *rom_memory,
-                             MemoryRegion *flash_mem)
+static void pc_isa_bios_init(PCMachineState *pcms, MemoryRegion *isa_bios,
+                             MemoryRegion *rom_memory, MemoryRegion *flash_mem)
 {
     int isa_bios_size;
     uint64_t flash_size;
@@ -51,8 +51,13 @@ static void pc_isa_bios_init(MemoryRegion *isa_bios, MemoryRegion *rom_memory,
 
     /* map the last 128KB of the BIOS in ISA space */
     isa_bios_size = MIN(flash_size, 128 * KiB);
-    memory_region_init_ram(isa_bios, NULL, "isa-bios", isa_bios_size,
-                           &error_fatal);
+    if (machine_require_guest_memfd(MACHINE(pcms))) {
+        memory_region_init_ram_guest_memfd(isa_bios, NULL, "isa-bios",
+                                           isa_bios_size, &error_fatal);
+    } else {
+        memory_region_init_ram(isa_bios, NULL, "isa-bios", isa_bios_size,
+                               &error_fatal);
+    }
     memory_region_add_subregion_overlap(rom_memory,
                                         0x100000 - isa_bios_size,
                                         isa_bios,
@@ -65,7 +70,9 @@ static void pc_isa_bios_init(MemoryRegion *isa_bios, MemoryRegion *rom_memory,
            ((uint8_t*)flash_ptr) + (flash_size - isa_bios_size),
            isa_bios_size);
 
-    memory_region_set_readonly(isa_bios, true);
+    if (!machine_require_guest_memfd(current_machine)) {
+        memory_region_set_readonly(isa_bios, true);
+    }
 }
 
 static PFlashCFI01 *pc_pflash_create(PCMachineState *pcms,
@@ -191,7 +198,7 @@ static void pc_system_flash_map(PCMachineState *pcms,
                 x86_isa_bios_init(&x86ms->isa_bios, rom_memory, flash_mem,
                                   true);
             } else {
-                pc_isa_bios_init(&x86ms->isa_bios, rom_memory, flash_mem);
+                pc_isa_bios_init(pcms, &x86ms->isa_bios, rom_memory, flash_mem);
             }
 
             /* Encrypt the pflash boot ROM */
-- 
2.45.1


