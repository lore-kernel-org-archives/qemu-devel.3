Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0DFB6F483CC
	for <qemu-devel@archiver.kernel.org>; Mon, 23 Mar 2026 16:55:34 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w4iYV-0007cV-66; Mon, 23 Mar 2026 12:55:09 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1w4iYF-0007BR-1C
 for qemu-devel@nongnu.org; Mon, 23 Mar 2026 12:54:53 -0400
Received: from mail-wr1-x430.google.com ([2a00:1450:4864:20::430])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1w4iYD-0000ho-C1
 for qemu-devel@nongnu.org; Mon, 23 Mar 2026 12:54:50 -0400
Received: by mail-wr1-x430.google.com with SMTP id
 ffacd0b85a97d-43b4915161fso2980654f8f.2
 for <qemu-devel@nongnu.org>; Mon, 23 Mar 2026 09:54:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1774284888; x=1774889688; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=IGYqU3ik62yXVGE06qRNfUGhoVhIyvTvdlVgMfT2A0o=;
 b=iSWhXlGxXMjOae/W14wQYDVkHnoEwB+6QX4erKsVGitk5mRqNtVCxMQmTXp8+0j+94
 R3jbCihWoiw+t7obUL2XNaEno+RGJzwyTm30leZTgsYUr8pLUYE4jN7X5Bl55xdDU82B
 DTW/rOA+Q10wt3mw2iFftsTISftez2/mKU9wI5MQV7vlh/HuIl3IYy6Wwe+UcjG+DezE
 Iu21uiaowsg7hmNzOMTJUNr5SexuVAB5DU/hAC+ACTvMglnMop39NJWVWPzxgu1v9NXO
 HHdGljTOKiPJOhTJ6G5t85WNu6LBNyi1pX3Se4IzayN4XMardSqz2GsOOBroZRTK/bNE
 yCDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1774284888; x=1774889688;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=IGYqU3ik62yXVGE06qRNfUGhoVhIyvTvdlVgMfT2A0o=;
 b=d1JssDbfTJ6mLFZkn98xuCWlXVB/o53/0BobylfHfyLMK0c/1yB3MxDHaLpGfjJIyz
 cG7k8Uj4mm8PpQCs/Uuv+tuQJPwZc/iv198fIL4tijcchtvz5wApf4gGSqSoZMT+3NKi
 t59IUuC/V68jQjk2FDS7XuHGWGoTLTWFUEfulgzeIC2kr8jkGhBCK3LKuFBxDjUJYfDa
 l9mS+WUdZ3rAIft5O+nV2/zn8vpED+qco7krCzSvsa4XzXWhE7HqfKwdIwQpx+U65Qu1
 vy0amST9ZDGm1bgo0oy4unRAH+fjCDB7d8aJK2vDW5yUplyVATSNspgfsDukEfJaBvO4
 MXKg==
X-Gm-Message-State: AOJu0YylWLaGKMjjyrsJKyqp86Pnwm/x9jV9Fh/aCS3klb3mvSmGvCC0
 5doBvrrDIGT5jsET4gGiiesOy74ddlcw6fV41q7gF2y+lcYBzL4XIdzagCP/vN6iOQUL/gu3I9B
 3jGkO0/Y=
X-Gm-Gg: ATEYQzwVTsOqI+jf3ssH0YidMcAzkvO0K8IHnQ1POlaV9X3iUgRkk/ZPyW2hCnhk6hq
 JZbcKSVlAHnhvQAovdPBqWV5pJBHIoSrNBZXNzf6lmbyrxUJURT6+cIqbz+AfzFxbw1xQs/2GmZ
 iTi+aJUfxgHB5UYJ9r5JiN0ZIn4qyU1hhyydXqMJKoOkXAsjnyMO6wYce3ezIpdRxd85Fj9K3Nv
 93iAi6Op0rzp9h8z3wAomosb1QkPa337XeB5oo56Hj8tUVGwK5tvFctrKxedtOdDqhO6Knrww3P
 4ovtTlC1yyXSNgbWf09MCjc+O9amkzo1BEBqEJxU8vVsYVeAzbijWNrSHB3eciAvE4vZ0pI7X8V
 T7TKeo5ax/pUyHrIE2z0RkdZRrtzzOZ5iQl43dPua7qHDKYOxwCLwRb9yh2zb9gYfOqaDdMp1nA
 4HjxdwkLAG2qX2gSqGOmwyOicAGTTbPf61sDfl8WDEg+tsBTSm4+R5UFvBnIz+WQ34ypS0ObSRi
 CYJUw+G/bE=
X-Received: by 2002:a05:600c:828d:b0:47e:e48b:506d with SMTP id
 5b1f17b1804b1-486ff0291ccmr184531675e9.16.1774284887528; 
 Mon, 23 Mar 2026 09:54:47 -0700 (PDT)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-486fe889652sm119053275e9.2.2026.03.23.09.54.46
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Mon, 23 Mar 2026 09:54:47 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 22/27] ati-vga: Add work around for fuloong2e
Date: Mon, 23 Mar 2026 17:52:13 +0100
Message-ID: <20260323165218.96607-23-philmd@linaro.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260323165218.96607-1-philmd@linaro.org>
References: <20260323165218.96607-1-philmd@linaro.org>
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

From: BALATON Zoltan <balaton@eik.bme.hu>

With the linear aperture size fixed to match real card fuloong2e no
longer works due to running out of PCI memory because only one PCI bus
is emulated on that machine. Add a property to allow fuloong2e to set
a smaller linear aperture size to work around that problem until the
machine model is improved.

Signed-off-by: BALATON Zoltan <balaton@eik.bme.hu>
Reviewed-by: Chad Jablonski <chad@jablonski.xyz>
Message-ID: <47cbdc7ad2291f22467f9fc86e7287eb8983c927.1774110169.git.balaton@eik.bme.hu>
Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 hw/display/ati_int.h |  1 +
 hw/display/ati.c     | 17 +++++++++++++----
 hw/mips/fuloong2e.c  |  1 +
 3 files changed, 15 insertions(+), 4 deletions(-)

diff --git a/hw/display/ati_int.h b/hw/display/ati_int.h
index 21b74511e08..0c48934d33b 100644
--- a/hw/display/ati_int.h
+++ b/hw/display/ati_int.h
@@ -119,6 +119,7 @@ struct ATIVGAState {
     QEMUTimer vblank_timer;
     bitbang_i2c_interface bbi2c;
     I2CDDCState i2cddc;
+    uint64_t linear_aper_sz;
     MemoryRegion linear_aper;
     MemoryRegion io;
     MemoryRegion mm;
diff --git a/hw/display/ati.c b/hw/display/ati.c
index a070f7af296..f74dd1efc0b 100644
--- a/hw/display/ati.c
+++ b/hw/display/ati.c
@@ -1059,7 +1059,6 @@ static void ati_vga_realize(PCIDevice *dev, Error **errp)
     ATIVGAState *s = ATI_VGA(dev);
     VGACommonState *vga = &s->vga;
     I2CBus *i2cbus;
-    uint64_t aper_size;
 
 #ifndef CONFIG_PIXMAN
     if (s->use_pixman != 0) {
@@ -1123,10 +1122,19 @@ static void ati_vga_realize(PCIDevice *dev, Error **errp)
      * Rage128 the upper half of the aperture is reserved for an AGP
      * window (which we do not emulate.)
      */
-    aper_size = s->dev_id == PCI_DEVICE_ID_ATI_RAGE128_PF ?
-                ATI_RAGE128_LINEAR_APER_SIZE : ATI_R100_LINEAR_APER_SIZE;
+    if (!s->linear_aper_sz) {
+        if (s->dev_id == PCI_DEVICE_ID_ATI_RAGE128_PF) {
+            s->linear_aper_sz = ATI_RAGE128_LINEAR_APER_SIZE;
+        } else {
+            s->linear_aper_sz = ATI_R100_LINEAR_APER_SIZE;
+        }
+    }
+    if (s->linear_aper_sz < 16 * MiB) {
+        error_setg(errp, "x-linear-aper-size is too small (minimum 16 MiB)");
+        return;
+    }
     memory_region_init(&s->linear_aper, OBJECT(dev), "ati-linear-aperture0",
-                       aper_size);
+                       s->linear_aper_sz);
     memory_region_add_subregion(&s->linear_aper, 0, &vga->vram);
 
     pci_register_bar(dev, 0, PCI_BASE_ADDRESS_MEM_PREFETCH, &s->linear_aper);
@@ -1171,6 +1179,7 @@ static const Property ati_vga_properties[] = {
     DEFINE_PROP_BOOL("guest_hwcursor", ATIVGAState, cursor_guest_mode, false),
     /* this is a debug option, prefer PROP_UINT over PROP_BIT for simplicity */
     DEFINE_PROP_UINT8("x-pixman", ATIVGAState, use_pixman, DEFAULT_X_PIXMAN),
+    DEFINE_PROP_UINT64("x-linear-aper-size", ATIVGAState, linear_aper_sz, 0),
     DEFINE_EDID_PROPERTIES(ATIVGAState, i2cddc.edid_info),
 };
 
diff --git a/hw/mips/fuloong2e.c b/hw/mips/fuloong2e.c
index d0efe36f7ce..72ad4507dfa 100644
--- a/hw/mips/fuloong2e.c
+++ b/hw/mips/fuloong2e.c
@@ -316,6 +316,7 @@ static void mips_fuloong2e_init(MachineState *machine)
         dev = DEVICE(pci_dev);
         qdev_prop_set_uint32(dev, "vgamem_mb", 16);
         qdev_prop_set_uint16(dev, "x-device-id", 0x5159);
+        qdev_prop_set_uint64(dev, "x-linear-aper-size", 16 * MiB);
         pci_realize_and_unref(pci_dev, pci_bus, &error_fatal);
     }
 
-- 
2.53.0


