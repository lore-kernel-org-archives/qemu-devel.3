Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2305A1125865
	for <qemu-devel@archiver.kernel.org>; Wed, 11 Mar 2026 18:35:45 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w0OOj-0004ip-GS; Wed, 11 Mar 2026 14:35:09 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vikingtc4@gmail.com>)
 id 1w0OOh-0004fB-Gs
 for qemu-devel@nongnu.org; Wed, 11 Mar 2026 14:35:07 -0400
Received: from mail-pl1-x634.google.com ([2607:f8b0:4864:20::634])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <vikingtc4@gmail.com>)
 id 1w0OOf-0000iT-IG
 for qemu-devel@nongnu.org; Wed, 11 Mar 2026 14:35:07 -0400
Received: by mail-pl1-x634.google.com with SMTP id
 d9443c01a7336-2ae5423b02aso1930725ad.1
 for <qemu-devel@nongnu.org>; Wed, 11 Mar 2026 11:35:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1773254104; x=1773858904; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=z5KdpHl8lQZVz4X9aIb/yvs6ATdm7ngkD8mEgd4aj+s=;
 b=iUYIL58ChtIOgQpO8LeyYa2K/FDuK61e1rPoxKMujcG8a0H1T/sL61S+xqFwyZbxNO
 RXOvvb7RsnFfNQV2lgNXYCM1IuNfF0T9rO4bGxaCSsh9ifPlDnErGqoLorabk4QXWx6Q
 8iZws2NbbXdM0lcdEa/bDBsvcNjLciRQyJUde0ousylxNTFEN2NcNEsVR8V8wLNETJoe
 edALXsIuZM0Y5Eb8nb6KszNx3JaAJuVTty5fXsWp31QcHr2pU9Tis6TN4wZEraigEHZJ
 UlmYlq7UVUVYoUJrE20dI/KiVGBpbAZLYes/aQ+XKbdscnoPncL964nxx1fbeIudN3po
 p6Iw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1773254104; x=1773858904;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=z5KdpHl8lQZVz4X9aIb/yvs6ATdm7ngkD8mEgd4aj+s=;
 b=DJrFvRW60JplAaUP6BmlePBU9ZN8NcXQcFJg7AYRVkejSYFU6M/eDvJU6XgPg+Xb2T
 XqRpUYKpijgnUwX6WFkthoutgz3/DC7hh7LtIu+ElVfvKmPJgL2Ik9Bm82nAoDfK9qRI
 tgeeWa1ajswhhDBepVm3GQu4BbSnTbI67/k9UK15hpLv6bUM2lK4F376crPdeQB28MOJ
 tjrrwK7+73edURVXwuswdV9boKlv8K722tUxIYmS8Y4zHTtcf46vC3+Ttkubp/rfV3Dg
 k2SiTamyLp9BVjcdRz8UZ8lY+KNoEaTwaYqezOKSGaZ0Sh3hslP5Bac/MFVX/mMh1bI+
 rzWQ==
X-Gm-Message-State: AOJu0YzPFKgXVA16BsTwWBzH5o1YbSaRu/BgaHeZ9Ea3F+5NnacMG7dL
 YxwHmJnYG+7xVEfCwHqZgJ7KdTPWP8sweqcGZz+CA8xdHm6Jr7c6EU81K77XqCsnKwNi4g==
X-Gm-Gg: ATEYQzykTWTlveLUGfU8HsM4jrhiwFJJq6P5fVWrKz4EIwH1AQGbW3URDRei4s8oMtm
 1xP+9hkE95MunWoTUthfvGjkKxLG5bZFZxDrJSFJJW8NSKWNiS+SX+vZycGaD30kkD7xC6HgTox
 TlOhExmJ4pPkVmfBM6jaWNjLMeuxbJu9IX+km3EjJQj99VVbWjD37bwSRe/hb5N4swkdBfl6/wl
 mCDxj/fhuAbEZ/SBsPQIt/fR4mzFL8MXHDz/chgGRVPnqRwTTzID0tsJJ+r7QIYLpEkdMziEpx9
 Ekdfoe1lnzhCHCvHvhGscSKbXoJOGSLCpVBTr2xHyO68chc92wGvUnlDQGz/A/1Iy1NRkY+fMiY
 sLd7hcg4z52E+rWiAduJjjsYzM69V/U1geQaelOx4hQprDFwQOd0NxJiftAxA3EF78Dl7qaU1Uz
 v856DZo305JbTytvL3tpyUu8MUxOljKcQpjXYbD4Yw7UldBw==
X-Received: by 2002:a17:903:2348:b0:2ae:4150:3125 with SMTP id
 d9443c01a7336-2aeae7dfcfdmr36539825ad.17.1773254103631; 
 Wed, 11 Mar 2026 11:35:03 -0700 (PDT)
Received: from localhost.localdomain ([123.19.166.13])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2aeae222e2fsm42124115ad.2.2026.03.11.11.35.01
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 11 Mar 2026 11:35:03 -0700 (PDT)
From: Trieu Huynh <vikingtc4@gmail.com>
X-Google-Original-From: Trieu Huynh <viking4@gmail.com>
To: qemu-devel@nongnu.org
Cc: Trieu Huynh <vikingtc4@gmail.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Helge Deller <deller@gmx.de>, Thomas Huth <th.huth+qemu@posteo.eu>,
 Laurent Vivier <laurent@vivier.eu>,
 "Edgar E. Iglesias" <edgar.iglesias@gmail.com>
Subject: [PATCH v2 1/4] hw/core/loader: fix error handling for
 load_image_targphys callers
Date: Thu, 12 Mar 2026 01:34:27 +0700
Message-ID: <20260311183432.214960-2-viking4@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260311183432.214960-1-viking4@gmail.com>
References: <20260311183432.214960-1-viking4@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::634;
 envelope-from=vikingtc4@gmail.com; helo=mail-pl1-x634.google.com
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

Use QEMU's Error API to handle load_image_targphys() failures
consistently across callers.

- Use &error_fatal for callers that previously passed NULL, ensuring
the process exits early on failure instead of continuing in an invalid
state.
- No functional changes.

Resolves: https://gitlab.com/qemu-project/qemu/-/issues/413
Signed-off-by: Trieu Huynh <vikingtc4@gmail.com>

---
v2:
- Use &error_fatal instead of manual return value checks.
- Remove redundant checks for ppc callers that already use
&error_fatal.
- Note: This replaces the "ret < 0" approach proposed in v1.
---
 hw/alpha/dp264.c     | 2 +-
 hw/hppa/machine.c    | 2 +-
 hw/m68k/next-cube.c  | 2 +-
 hw/m68k/q800.c       | 2 +-
 hw/m68k/virt.c       | 2 +-
 hw/microblaze/boot.c | 3 ++-
 6 files changed, 7 insertions(+), 6 deletions(-)

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
index 26177c7b86..4bc8e72f3e 100644
--- a/hw/m68k/next-cube.c
+++ b/hw/m68k/next-cube.c
@@ -1326,7 +1326,7 @@ static void next_cube_init(MachineState *machine)
     memory_region_init_alias(&m->rom2, NULL, "next.rom2", &m->rom, 0x0,
                              0x20000);
     memory_region_add_subregion(sysmem, 0x0, &m->rom2);
-    if (load_image_targphys(bios_name, 0x01000000, 0x20000, NULL) < 8) {
+    if (load_image_targphys(bios_name, 0x01000000, 0x20000, &error_fatal) < 8) {
         if (!qtest_enabled()) {
             error_report("Failed to load firmware '%s'.", bios_name);
         }
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


