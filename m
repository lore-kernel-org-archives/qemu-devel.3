Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 432C3EA8543
	for <qemu-devel@archiver.kernel.org>; Sun,  8 Mar 2026 22:37:12 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vzMk4-00053d-R5; Sun, 08 Mar 2026 18:36:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vzMjv-0004Vs-Qc
 for qemu-devel@nongnu.org; Sun, 08 Mar 2026 18:36:50 -0400
Received: from mail-wr1-x430.google.com ([2a00:1450:4864:20::430])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vzMjr-0003QO-Kk
 for qemu-devel@nongnu.org; Sun, 08 Mar 2026 18:36:47 -0400
Received: by mail-wr1-x430.google.com with SMTP id
 ffacd0b85a97d-439ce3605ecso2640170f8f.0
 for <qemu-devel@nongnu.org>; Sun, 08 Mar 2026 15:36:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1773009392; x=1773614192; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=MMpo2dVbblEgNJoHcFyCWBR/CdBXrRHvlyFTaz/KWjc=;
 b=O7KcRPieXJJbQy8N3unT0SkdKGM1gqQEsoI18eeLys+1u/JQYyECteB37pYOnMRbvL
 pikBOntgDlmmqG47+2ZhqZDmEMv33rWlqi38HXIv+Bp7BrrVf2GHq7kOlH4ozAGN5SAK
 K3GbpNuUFqsCjtXu9blr44l0NdUP6d9LlqpmaPnf0vsD0/hmANNUbTjdWQ46H2MhdYE+
 TACv7Lecp9EVa4sp5+Z5Ic28+gWysZWWeqgh95YaMGtwSsLTl3WGkAr+1wYooK36yKw4
 /U6WbOkOhf/3IHgYtc51YzioVHmfEHNcYtGQDpSOiQWmLYz5dLQv5p0k7P1lrYeVOfGh
 J3kA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1773009392; x=1773614192;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=MMpo2dVbblEgNJoHcFyCWBR/CdBXrRHvlyFTaz/KWjc=;
 b=ZPQ93a2aS/L1AQEQ/PZyzS9tlOuKlzH9oQD2veWj8Jd39f1D8lKxp9082gPoQjLcD2
 U3u+arlwqT1QrcdDaD6dLBMkksOYYrsUI8nS2o71npLiOGfjzfMyJDyjEQsdZfpEfe/R
 bjQSgpfBpO9B7dOhqqmLw8EkrmsQL8A3KFe1GMaYT784nDduvDKbLeMQnCg1yHWT8MUC
 ZqlmzOhHFiQXCedDxA+jbx7Qs1Bh2Yy9NzYtoVMtAEYRifH8azmxtDwMvNVSG6r0uDjJ
 E/lmZVvHqJiS+yh+boFUEHrshbpixjnMnSln8RdnUGnn12m5HmYWWJti42h5JrbDele6
 jTfw==
X-Gm-Message-State: AOJu0Yxtxp++OAnInTTZ3Yo8LEgbd14ziO41wzmGORaCYDWFe+YcTIwV
 GOlBekOyQrFXCfKjvDuFW/lLEBmT8WXkDX7qgKf5AaRne5nLB/xnC9C10KdF1IthDiaHpikfmBP
 m6I/BH+k=
X-Gm-Gg: ATEYQzztOGloNDAMdU0i+P3OlyIjfuyiXCZIpbHEkygHfnwcjkvW/q2s5gFBr4HgW1o
 ecARdVt9Dw5JAbVa0RHF/wenBIN6l+r167EKegupYHTWJ5WcAfzqNY9QWroA76Qri5fIDQwH+Af
 Y4F7XyKz9lg1oKTbCFnHfSLKFQs3wxNnv0WtuxeuLuSf3G254/+2SMavfTEsh6SxM7nRi5ufEtx
 XoAVIaQHIBwn+sMhE0OYIdaxuvJgis0Lgk/1QEZozeqK3IuEoGpzvbOyve/1Iy5+/prXAs27WpT
 EcD6ZSEwlC8E2IddcqCQuDIIQBdwqEYNuUoiOFzMMK6AXyvy+3Bq7qcOVFNroJavl2d0r9f30Bf
 eHU6dYLusLgxWoyWGwPnhgo4XQAG5I/yGpwQli6UF3h3avVsdfX3mD2WOYrrRZfF5ptFE1typNh
 84qVIxkLDxPP6OSxrGGAtJuj4/oCIvg7HistL5T3/vjpVgcwWQJZykCt6BwBkr7GqVCjQewWB9F
 ww35g==
X-Received: by 2002:a05:6000:1865:b0:439:bcab:405e with SMTP id
 ffacd0b85a97d-439da885f29mr15824547f8f.35.1773009392171; 
 Sun, 08 Mar 2026 15:36:32 -0700 (PDT)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-439dadac2a7sm21165650f8f.15.2026.03.08.15.36.31
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Sun, 08 Mar 2026 15:36:31 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 17/49] ati-vga: Fix framebuffer mapping by using
 hardware-correct aperture sizes
Date: Sun,  8 Mar 2026 23:34:01 +0100
Message-ID: <20260308223433.25503-18-philmd@linaro.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260308223433.25503-1-philmd@linaro.org>
References: <20260308223433.25503-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::430;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x430.google.com
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

From: Chad Jablonski <chad@jablonski.xyz>

Rage 128 cards always request 64MB for their linear (framebuffer)
aperture and R100 cards always request 128MB. This is regardless
of the amount of physical VRAM on the board. The following are results
from real hardware tests:

Card                              VRAM    PCI BAR0   CONFIG_MEMSIZE  CONFIG_APER_SIZE  AGP_APER_OFFSET
-----------------------           ----    --------   --------------  ----------------  ---------------
Rage 128 Pro Ultra TF             32MB     64MB       0x02000000      0x02000000        0x02000000
Rage 128 RF/SG AGP                16MB     64MB       0x01000000      0x02000000        0x02000000
Radeon R100 QD [Radeon 7200]      64MB    128MB       0x04000000      0x04000000        N/A
Radeon RV100 QY [Radeon 7000/VE]  32MB    128MB       0x02000000      0x04000000        N/A

Previously the linear aperture (BAR0) would match the VRAM size.
This discrepancy caused issues with the X.org and XFree86 r128 drivers.
These drivers apply a mask of 0xfc000000 (2^26 = 64MB) to the linear
aperture address. If that address is not on a 64MB boundary the
framebuffer points to an incorrect memory location.

Testing shows that the Radeon R100 also has a BAR0 larger than VRAM
(128MB in this case) and the X.org radeon driver also masks to 64MB.

For Rage 128, CONFIG_APER_SIZE also differs from the previous value and
the behavior stated in the documentation. The Rage 128 register guide
states that it should contain the size of the VRAM + AGP memory. The cards
tested above show that this isn't the case. These tests also included
enabling/disabling AGP with 8MB of memory. It didn't change the
contents of CONFIG_APER_SIZE.

For both Rage 128 and R100 the CONFIG_APER_SIZE is half of the PCI BAR0 size.

Signed-off-by: Chad Jablonski <chad@jablonski.xyz>
Reviewed-by: BALATON Zoltan <balaton@eik.bme.hu>
Message-ID: <20260303024730.1489136-2-chad@jablonski.xyz>
Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 hw/display/ati_int.h |  5 +++++
 hw/display/ati.c     | 16 ++++++++++++++--
 2 files changed, 19 insertions(+), 2 deletions(-)

diff --git a/hw/display/ati_int.h b/hw/display/ati_int.h
index f5a47b82b08..708cc1dd3a3 100644
--- a/hw/display/ati_int.h
+++ b/hw/display/ati_int.h
@@ -10,6 +10,7 @@
 #define ATI_INT_H
 
 #include "qemu/timer.h"
+#include "qemu/units.h"
 #include "hw/pci/pci_device.h"
 #include "hw/i2c/bitbang_i2c.h"
 #include "vga_int.h"
@@ -29,6 +30,9 @@
 /* Radeon RV100 (VE) */
 #define PCI_DEVICE_ID_ATI_RADEON_QY 0x5159
 
+#define ATI_RAGE128_LINEAR_APER_SIZE (64 * MiB)
+#define ATI_R100_LINEAR_APER_SIZE (128 * MiB)
+
 #define TYPE_ATI_VGA "ati-vga"
 OBJECT_DECLARE_SIMPLE_TYPE(ATIVGAState, ATI_VGA)
 
@@ -97,6 +101,7 @@ struct ATIVGAState {
     QEMUCursor *cursor;
     QEMUTimer vblank_timer;
     bitbang_i2c_interface bbi2c;
+    MemoryRegion linear_aper;
     MemoryRegion io;
     MemoryRegion mm;
     ATIVGARegs regs;
diff --git a/hw/display/ati.c b/hw/display/ati.c
index e9c3ad2cd15..8438a77de04 100644
--- a/hw/display/ati.c
+++ b/hw/display/ati.c
@@ -361,7 +361,7 @@ static uint64_t ati_mm_read(void *opaque, hwaddr addr, unsigned int size)
                                       PCI_BASE_ADDRESS_0, size) & 0xfffffff0;
         break;
     case CONFIG_APER_SIZE:
-        val = s->vga.vram_size / 2;
+        val = memory_region_size(&s->linear_aper) / 2;
         break;
     case CONFIG_REG_1_BASE:
         val = pci_default_read_config(&s->dev,
@@ -952,6 +952,7 @@ static void ati_vga_realize(PCIDevice *dev, Error **errp)
 {
     ATIVGAState *s = ATI_VGA(dev);
     VGACommonState *vga = &s->vga;
+    uint64_t aper_size;
 
 #ifndef CONFIG_PIXMAN
     if (s->use_pixman != 0) {
@@ -1011,7 +1012,18 @@ static void ati_vga_realize(PCIDevice *dev, Error **errp)
     /* io space is alias to beginning of mmregs */
     memory_region_init_alias(&s->io, OBJECT(s), "ati.io", &s->mm, 0, 0x100);
 
-    pci_register_bar(dev, 0, PCI_BASE_ADDRESS_MEM_PREFETCH, &vga->vram);
+    /*
+     * The framebuffer is at the beginning of the linear aperture. For
+     * Rage128 the upper half of the aperture is reserved for an AGP
+     * window (which we do not emulate.)
+     */
+    aper_size = s->dev_id == PCI_DEVICE_ID_ATI_RAGE128_PF ?
+                ATI_RAGE128_LINEAR_APER_SIZE : ATI_R100_LINEAR_APER_SIZE;
+    memory_region_init(&s->linear_aper, OBJECT(dev), "ati-linear-aperture0",
+                       aper_size);
+    memory_region_add_subregion(&s->linear_aper, 0, &vga->vram);
+
+    pci_register_bar(dev, 0, PCI_BASE_ADDRESS_MEM_PREFETCH, &s->linear_aper);
     pci_register_bar(dev, 1, PCI_BASE_ADDRESS_SPACE_IO, &s->io);
     pci_register_bar(dev, 2, PCI_BASE_ADDRESS_SPACE_MEMORY, &s->mm);
 
-- 
2.53.0


