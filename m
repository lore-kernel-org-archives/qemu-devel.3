Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F2DE6C3ABB0
	for <qemu-devel@archiver.kernel.org>; Sun,  4 May 2025 21:59:18 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uBhLJ-0007Ox-0x; Sun, 04 May 2025 17:57:49 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <gustavo.romero@linaro.org>)
 id 1uBhLH-0007Nq-C6
 for qemu-devel@nongnu.org; Sun, 04 May 2025 17:57:47 -0400
Received: from mail-pl1-x62e.google.com ([2607:f8b0:4864:20::62e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <gustavo.romero@linaro.org>)
 id 1uBhLF-0005Ac-HI
 for qemu-devel@nongnu.org; Sun, 04 May 2025 17:57:47 -0400
Received: by mail-pl1-x62e.google.com with SMTP id
 d9443c01a7336-22c33e5013aso38879885ad.0
 for <qemu-devel@nongnu.org>; Sun, 04 May 2025 14:57:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1746395864; x=1747000664; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=Fwa6vL14YZTfst2loVGLMHYQVKFZcNKU8l3yQjztZTQ=;
 b=pmJUQiSxXFsAnEGLrouWwFlwbX9g9bL3IecR4U385nF7NIRq9j/1+bMFlKldGAdAIC
 p3q8ZR40xVqogHJF4TqR5ztfqsFB5FprYRl6q5olQcjQQgoh7tPF4yOqJmGgzlr1+c9G
 lCT3i9sUhTvXG2QGCG65lBpMGEj2ctoa/JLNv3nv7620RNimSHSETbZheayU404YSO1I
 7P8UgCokiPw9TtZ4NGirTwZwAcecnbLsgBSeHw8zk6EDGh6LZB/zUEVVLtRyiMHBvyZ8
 rM7KAM1Jnz1MSS2gRmP2s+IFGXaFOROQBqCgS0mPm+Ao/DN0APTE/XgjmZ6gfZ9wWV/W
 x1PQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1746395864; x=1747000664;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=Fwa6vL14YZTfst2loVGLMHYQVKFZcNKU8l3yQjztZTQ=;
 b=ZBqtGuoILqRYpBcDWz3o2qYSSKY5IXiIT1Vyoi5RHZEqsIaQRzqgxzPwmk3smF6iXP
 IN+ajwuA8JjcJL6tdJlpAwcThxDwJnV8AFDZcAkSJQDseWe1zXKqyN70j9cGpg+df6IB
 JsRe2m8P4JSKYosVLR1yOcRvOwHpYGRtNk+oHFv6GAbazL+fcGgOB/tWYzzK3P3FbYsJ
 umS57hoK3Wq0Ze32IQeIXkvpKZqhqNw6Y+HTyVSKeIdu5h7WiFiHXVDkg7Asu8avxC0b
 lGMTCt0i5etVbvu0VtPd3fmRaXVusLEBJ00WwG+mLywpCKyN3RIyTlhCaA8o0vBLi76c
 KxQg==
X-Gm-Message-State: AOJu0Yw7JyVjbDq0g2C9VKBi1xT95/qO7046zmJGq+1pMflgeacZ/FaG
 1/XFz2niWm9L3V7Kybg3C/wb8leuaU8UeN80XwYIb12r9DFtnHXuiEpEekuYxgHSdQjmVdJr8MB
 pelU=
X-Gm-Gg: ASbGncsAROQnTZSPaR2W0gb75GRFamjGw46Ny2P7SNDzze4T3mM/ojI5Lx5UwT1ZMdo
 frhpBsmdbUx+dzfOSGL6m1xXwyuUp7zSWjZBoflS1njifQjozUygCcc7NwqINu6nQ918mteMnVa
 AVOGGogB163EE7trAa2mupgLGfITVQ4Q9rRZS9BB/7vFq5q1H2X+mc8XgLbGBrqt2rwSGH5qgZg
 QR6dg6Ye1pANRiL+iSyN54xUOOle0mcbqcZM05jXh2qfbmDqPvsqeOyUCnH53UV303z5wQEdek1
 qT3/4DJpqvzjXxJv3iRqBedp/x96zQLoA/KPrAxuFfyrrbHh
X-Google-Smtp-Source: AGHT+IGQT6GPAkKoXGz9SNSn4/Ag1yM9bhq9courAlNnN3GPAxPb4sdccxa10oDnwKBUwHRRrLTVag==
X-Received: by 2002:a17:903:2b0c:b0:21f:2ded:76ea with SMTP id
 d9443c01a7336-22e1eae4269mr91622705ad.36.1746395863786; 
 Sun, 04 May 2025 14:57:43 -0700 (PDT)
Received: from gromero0.. ([200.150.181.215]) by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-22e152204fesm41664875ad.137.2025.05.04.14.57.41
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 04 May 2025 14:57:43 -0700 (PDT)
From: Gustavo Romero <gustavo.romero@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-trivial@nongnu.org, philmd@linaro.org, alex.bennee@linaro.org,
 gustavo.romero@linaro.org
Subject: [PATCH] hw/pci/pci.c: Turn DPRINTF into trace events
Date: Sun,  4 May 2025 21:56:30 +0000
Message-Id: <20250504215639.54860-2-gustavo.romero@linaro.org>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62e;
 envelope-from=gustavo.romero@linaro.org; helo=mail-pl1-x62e.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

Remove PCI_DPRINTF() macro and use trace events instead.

Signed-off-by: Gustavo Romero <gustavo.romero@linaro.org>
---
 hw/pci/pci.c        | 19 ++++++-------------
 hw/pci/trace-events |  4 ++++
 2 files changed, 10 insertions(+), 13 deletions(-)

diff --git a/hw/pci/pci.c b/hw/pci/pci.c
index fe38c4c028..352b3d12c8 100644
--- a/hw/pci/pci.c
+++ b/hw/pci/pci.c
@@ -54,13 +54,6 @@
 #include "hw/xen/xen.h"
 #include "hw/i386/kvm/xen_evtchn.h"
 
-//#define DEBUG_PCI
-#ifdef DEBUG_PCI
-# define PCI_DPRINTF(format, ...)       printf(format, ## __VA_ARGS__)
-#else
-# define PCI_DPRINTF(format, ...)       do { } while (0)
-#endif
-
 bool pci_available = true;
 
 static char *pcibus_get_dev_path(DeviceState *dev);
@@ -2439,12 +2432,12 @@ static void pci_patch_ids(PCIDevice *pdev, uint8_t *ptr, uint32_t size)
     /* Only a valid rom will be patched. */
     rom_magic = pci_get_word(ptr);
     if (rom_magic != 0xaa55) {
-        PCI_DPRINTF("Bad ROM magic %04x\n", rom_magic);
+        trace_pci_bad_rom_magic(rom_magic, 0xaa55);
         return;
     }
     pcir_offset = pci_get_word(ptr + 0x18);
     if (pcir_offset + 8 >= size || memcmp(ptr + pcir_offset, "PCIR", 4)) {
-        PCI_DPRINTF("Bad PCIR offset 0x%x or signature\n", pcir_offset);
+        trace_pci_bad_pcir_offset(pcir_offset);
         return;
     }
 
@@ -2453,8 +2446,8 @@ static void pci_patch_ids(PCIDevice *pdev, uint8_t *ptr, uint32_t size)
     rom_vendor_id = pci_get_word(ptr + pcir_offset + 4);
     rom_device_id = pci_get_word(ptr + pcir_offset + 6);
 
-    PCI_DPRINTF("%s: ROM id %04x%04x / PCI id %04x%04x\n", pdev->romfile,
-                vendor_id, device_id, rom_vendor_id, rom_device_id);
+    trace_pci_rom_and_pci_ids(pdev->romfile, vendor_id, device_id,
+                              rom_vendor_id, rom_device_id);
 
     checksum = ptr[6];
 
@@ -2462,7 +2455,7 @@ static void pci_patch_ids(PCIDevice *pdev, uint8_t *ptr, uint32_t size)
         /* Patch vendor id and checksum (at offset 6 for etherboot roms). */
         checksum += (uint8_t)rom_vendor_id + (uint8_t)(rom_vendor_id >> 8);
         checksum -= (uint8_t)vendor_id + (uint8_t)(vendor_id >> 8);
-        PCI_DPRINTF("ROM checksum %02x / %02x\n", ptr[6], checksum);
+        trace_pci_rom_checksum_change(ptr[6], checksum);
         ptr[6] = checksum;
         pci_set_word(ptr + pcir_offset + 4, vendor_id);
     }
@@ -2471,7 +2464,7 @@ static void pci_patch_ids(PCIDevice *pdev, uint8_t *ptr, uint32_t size)
         /* Patch device id and checksum (at offset 6 for etherboot roms). */
         checksum += (uint8_t)rom_device_id + (uint8_t)(rom_device_id >> 8);
         checksum -= (uint8_t)device_id + (uint8_t)(device_id >> 8);
-        PCI_DPRINTF("ROM checksum %02x / %02x\n", ptr[6], checksum);
+        trace_pci_rom_checksum_change(ptr[6], checksum);
         ptr[6] = checksum;
         pci_set_word(ptr + pcir_offset + 6, device_id);
     }
diff --git a/hw/pci/trace-events b/hw/pci/trace-events
index 6a9968962f..02c80d3ec8 100644
--- a/hw/pci/trace-events
+++ b/hw/pci/trace-events
@@ -6,6 +6,10 @@ pci_pm_transition(const char *dev, uint32_t bus, uint32_t slot, uint32_t func, u
 pci_update_mappings_del(const char *dev, uint32_t bus, uint32_t slot, uint32_t func, int bar, uint64_t addr, uint64_t size) "%s %02x:%02x.%x %d,0x%"PRIx64"+0x%"PRIx64
 pci_update_mappings_add(const char *dev, uint32_t bus, uint32_t slot, uint32_t func, int bar, uint64_t addr, uint64_t size) "%s %02x:%02x.%x %d,0x%"PRIx64"+0x%"PRIx64
 pci_route_irq(int dev_irq, const char *dev_path, int parent_irq, const char *parent_path) "IRQ %d @%s -> IRQ %d @%s"
+pci_bad_rom_magic(uint16_t bad_rom_magic, uint16_t good_rom_magic) "Bad ROM magic number: %04"PRIX16". Should be: %04"PRIX16
+pci_bad_pcir_offset(uint16_t pcir_offset) "Bad PCIR offset 0x%"PRIx16" or signature"
+pci_rom_and_pci_ids(char *romfile, uint16_t vendor_id, uint16_t device_id, uint16_t rom_vendor_id, uint16_t rom_device_id) "%s: ROM ID %04"PRIx16":%04"PRIx16" | PCI ID %04"PRIx16":%04"PRIx16
+pci_rom_checksum_change(uint8_t old_checksum, uint8_t new_checksum) "ROM checksum changed from %02"PRIx8" to %02"PRIx8
 
 # pci_host.c
 pci_cfg_read(const char *dev, uint32_t bus, uint32_t slot, uint32_t func, unsigned offs, unsigned val) "%s %02x:%02x.%x @0x%x -> 0x%x"
-- 
2.34.1


