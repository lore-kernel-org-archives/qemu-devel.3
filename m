Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9085DE776C4
	for <qemu-devel@archiver.kernel.org>; Wed, 24 Dec 2025 16:27:11 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vYRhU-0007Wa-7y; Wed, 24 Dec 2025 11:27:00 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vYRhS-0007Vr-6R
 for qemu-devel@nongnu.org; Wed, 24 Dec 2025 11:26:58 -0500
Received: from mail-wm1-x333.google.com ([2a00:1450:4864:20::333])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vYRhQ-0003Yb-1n
 for qemu-devel@nongnu.org; Wed, 24 Dec 2025 11:26:57 -0500
Received: by mail-wm1-x333.google.com with SMTP id
 5b1f17b1804b1-47d182a8c6cso25919275e9.1
 for <qemu-devel@nongnu.org>; Wed, 24 Dec 2025 08:26:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1766593614; x=1767198414; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=7rsuCWPKZHNnj/q3k9BZ8VH5K66mbplpSJozKaVMHEw=;
 b=seIJ1UpWQcIECA1tGMv8+TJkg4eQcD6/tkkvJT+XHm3Yqb6Z0InuVbfXE3BwMxIwaP
 V1UdRHOIdP6gB30PChKE7i3O2mi0wjhrhflBoWeI1rVmI36bBJcFQxeccg+h5QqdeFyC
 rLE0Skh5h82wNeyCG+8x7DvdezmRjX1FSyVdx2Mn2mqLyyjzd5kO+lJdJqWGkFbodZD3
 pYkWg32IJ6G3YPK27s8qI4JXq9Wq/DhhXu0NOJqroIB13cxVQZTu4ezl6JzIlKYX5cY7
 31YhlT6j2k9J5ZEPS11sOpqpi/m9/Vjs4U383otCGbz0IB2fLgk4AiVEDhB+hECzki30
 EgDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1766593614; x=1767198414;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=7rsuCWPKZHNnj/q3k9BZ8VH5K66mbplpSJozKaVMHEw=;
 b=dHSPQcSX+xxr7PrdoeUt+d4Ah6jAcSE3jOK5cesPCg0QQMjKFPsucPyI+3DpfhtwAz
 rKr9UoAc2Ax4tclsiI7rYMJLZ5NZmOueAdNOUXDGz+ms7UvfLH5xPDZz/Z+IKzAdIcWk
 DPAQstAokB5JTU2CJyufOLLR8RB/vrIy5BdarF13usrAZ7j2ICDLAKq9PMq7h0ZIew1u
 rO8cg1oUWuk6el4RLYdmn9rSKdhX7YES5IbJJT56xI4XWDvehtlzje8Mny/FnLPV7vjD
 2M0tsJ7EyF1TzgytTT/H8we369nGnpghzr1OIr0ZnTO2b4izh9gm/pDt7vNaAvWXCsvk
 mZ0w==
X-Gm-Message-State: AOJu0YwrTGjIShpjS3VDpC6gdvmyOEYAAPD7m2ZKRoyZ5HH0SNU6VuHe
 NfRAUcrkbCfP1ei8eTiABPNQuy7J761iO83gsgNnZf7R+gDnIkDSVGt0E9UC25IWFtubYuJitiW
 dCFfrTmk=
X-Gm-Gg: AY/fxX59igR5o9xiEybSQfgmdrU4utXFjonNxmN/CZU4XToRUJscQDx8J+XEStl9ai6
 rI/tGPmFAWNrHTmHs7EtisFBb0/SxrqsPYy3RYmTkSmmHmuoSZZvAqLkLcBRuPMMYfJqracs+KQ
 1szpwX71LV7wO5e0EdWB1y272wMR7pr0tVsjbAhq//uzwqujkOg7hHiZMTcJyCj4pgaGyr/fw7p
 npHTS74WDeblSnbA1KYCeFE7tbxRoSwXuMxlozVhevTUEvAMRy7tSyaUzhOevUABohkZeDVdeu5
 O7brer2YqNryKZiktU0pUxIbqvXMWXMMr2p6HWi/vvQpFQuYv0544B3rzXmJjYxDJSm5mty3MN8
 s1Nqzl3nv9mLTijbw4QzBo7/8qGwMbAFVCc9CNmphkhj7zT6XycezuHuTuIUR7qmZlpIXbGDztB
 oVP1zVXBE6kG/0i6YsavfSKbXULyiJMSRslOHMhFJnGhJVVvt2fXMBDNw=
X-Google-Smtp-Source: AGHT+IHhDiv7CgJAO5kNI97MVNcAvWfbW4LUY754xzCyCjh8RgBF7QsUY9EzaXBtk06tNHYD1ARMRQ==
X-Received: by 2002:a05:600c:4447:b0:477:9a28:b0a4 with SMTP id
 5b1f17b1804b1-47d194c6a2fmr170662365e9.0.1766593613994; 
 Wed, 24 Dec 2025 08:26:53 -0800 (PST)
Received: from localhost.localdomain (188.171.88.92.rev.sfr.net.
 [92.88.171.188]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-47d19346d33sm310400775e9.3.2025.12.24.08.26.52
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Wed, 24 Dec 2025 08:26:53 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Gerd Hoffmann <kraxel@redhat.com>,
 =?UTF-8?q?Cl=C3=A9ment=20Chigot?= <chigot@adacore.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Anton Johansson <anjo@rev.ng>,
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 Artyom Tarasenko <atar4qemu@gmail.com>, Laurent Vivier <laurent@vivier.eu>,
 Manos Pitsidianakis <manos.pitsidianakis@linaro.org>,
 Frederic Konrad <konrad.frederic@yahoo.fr>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH v3 1/9] hw/sparc: Mark SPARC-specific peripherals as big-endian
Date: Wed, 24 Dec 2025 17:26:33 +0100
Message-ID: <20251224162642.90857-2-philmd@linaro.org>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20251224162642.90857-1-philmd@linaro.org>
References: <20251224162642.90857-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::333;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x333.google.com
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

These devices are only used by the SPARC target, which is
only built as big-endian. Therefore the DEVICE_NATIVE_ENDIAN
definition expand to DEVICE_BIG_ENDIAN (besides, the
DEVICE_LITTLE_ENDIAN case isn't tested). Simplify directly
using DEVICE_BIG_ENDIAN.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 hw/audio/cs4231.c        |  2 +-
 hw/char/grlib_apbuart.c  |  2 +-
 hw/display/cg3.c         |  2 +-
 hw/display/tcx.c         | 14 +++++++-------
 hw/dma/sparc32_dma.c     |  2 +-
 hw/intc/grlib_irqmp.c    |  2 +-
 hw/intc/slavio_intctl.c  |  4 ++--
 hw/misc/eccmemctl.c      |  2 +-
 hw/misc/slavio_misc.c    | 16 ++++++++--------
 hw/rtc/sun4v-rtc.c       |  2 +-
 hw/timer/grlib_gptimer.c |  2 +-
 hw/timer/slavio_timer.c  |  2 +-
 12 files changed, 26 insertions(+), 26 deletions(-)

diff --git a/hw/audio/cs4231.c b/hw/audio/cs4231.c
index 97cceb44d86..498cd2da704 100644
--- a/hw/audio/cs4231.c
+++ b/hw/audio/cs4231.c
@@ -135,7 +135,7 @@ static void cs_mem_write(void *opaque, hwaddr addr,
 static const MemoryRegionOps cs_mem_ops = {
     .read = cs_mem_read,
     .write = cs_mem_write,
-    .endianness = DEVICE_NATIVE_ENDIAN,
+    .endianness = DEVICE_BIG_ENDIAN,
 };
 
 static const VMStateDescription vmstate_cs4231 = {
diff --git a/hw/char/grlib_apbuart.c b/hw/char/grlib_apbuart.c
index b2d5a40bb4d..b9dafdc3e65 100644
--- a/hw/char/grlib_apbuart.c
+++ b/hw/char/grlib_apbuart.c
@@ -242,7 +242,7 @@ static void grlib_apbuart_write(void *opaque, hwaddr addr,
 static const MemoryRegionOps grlib_apbuart_ops = {
     .write      = grlib_apbuart_write,
     .read       = grlib_apbuart_read,
-    .endianness = DEVICE_NATIVE_ENDIAN,
+    .endianness = DEVICE_BIG_ENDIAN,
 };
 
 static void grlib_apbuart_realize(DeviceState *dev, Error **errp)
diff --git a/hw/display/cg3.c b/hw/display/cg3.c
index daeef152174..ca04f0c9549 100644
--- a/hw/display/cg3.c
+++ b/hw/display/cg3.c
@@ -265,7 +265,7 @@ static void cg3_reg_write(void *opaque, hwaddr addr, uint64_t val,
 static const MemoryRegionOps cg3_reg_ops = {
     .read = cg3_reg_read,
     .write = cg3_reg_write,
-    .endianness = DEVICE_NATIVE_ENDIAN,
+    .endianness = DEVICE_BIG_ENDIAN,
     .valid = {
         .min_access_size = 1,
         .max_access_size = 4,
diff --git a/hw/display/tcx.c b/hw/display/tcx.c
index 4853c5e1424..ba31d9bf29b 100644
--- a/hw/display/tcx.c
+++ b/hw/display/tcx.c
@@ -452,7 +452,7 @@ static void tcx_dac_writel(void *opaque, hwaddr addr, uint64_t val,
 static const MemoryRegionOps tcx_dac_ops = {
     .read = tcx_dac_readl,
     .write = tcx_dac_writel,
-    .endianness = DEVICE_NATIVE_ENDIAN,
+    .endianness = DEVICE_BIG_ENDIAN,
     .valid = {
         .min_access_size = 4,
         .max_access_size = 4,
@@ -533,7 +533,7 @@ static void tcx_rstip_writel(void *opaque, hwaddr addr,
 static const MemoryRegionOps tcx_stip_ops = {
     .read = tcx_stip_readl,
     .write = tcx_stip_writel,
-    .endianness = DEVICE_NATIVE_ENDIAN,
+    .endianness = DEVICE_BIG_ENDIAN,
     .impl = {
         .min_access_size = 4,
         .max_access_size = 4,
@@ -547,7 +547,7 @@ static const MemoryRegionOps tcx_stip_ops = {
 static const MemoryRegionOps tcx_rstip_ops = {
     .read = tcx_stip_readl,
     .write = tcx_rstip_writel,
-    .endianness = DEVICE_NATIVE_ENDIAN,
+    .endianness = DEVICE_BIG_ENDIAN,
     .impl = {
         .min_access_size = 4,
         .max_access_size = 4,
@@ -633,7 +633,7 @@ static void tcx_rblit_writel(void *opaque, hwaddr addr,
 static const MemoryRegionOps tcx_blit_ops = {
     .read = tcx_blit_readl,
     .write = tcx_blit_writel,
-    .endianness = DEVICE_NATIVE_ENDIAN,
+    .endianness = DEVICE_BIG_ENDIAN,
     .impl = {
         .min_access_size = 4,
         .max_access_size = 4,
@@ -647,7 +647,7 @@ static const MemoryRegionOps tcx_blit_ops = {
 static const MemoryRegionOps tcx_rblit_ops = {
     .read = tcx_blit_readl,
     .write = tcx_rblit_writel,
-    .endianness = DEVICE_NATIVE_ENDIAN,
+    .endianness = DEVICE_BIG_ENDIAN,
     .impl = {
         .min_access_size = 4,
         .max_access_size = 4,
@@ -713,7 +713,7 @@ static void tcx_thc_writel(void *opaque, hwaddr addr,
 static const MemoryRegionOps tcx_thc_ops = {
     .read = tcx_thc_readl,
     .write = tcx_thc_writel,
-    .endianness = DEVICE_NATIVE_ENDIAN,
+    .endianness = DEVICE_BIG_ENDIAN,
     .valid = {
         .min_access_size = 4,
         .max_access_size = 4,
@@ -734,7 +734,7 @@ static void tcx_dummy_writel(void *opaque, hwaddr addr,
 static const MemoryRegionOps tcx_dummy_ops = {
     .read = tcx_dummy_readl,
     .write = tcx_dummy_writel,
-    .endianness = DEVICE_NATIVE_ENDIAN,
+    .endianness = DEVICE_BIG_ENDIAN,
     .valid = {
         .min_access_size = 4,
         .max_access_size = 4,
diff --git a/hw/dma/sparc32_dma.c b/hw/dma/sparc32_dma.c
index 60c23b69e5c..2b6836b55ec 100644
--- a/hw/dma/sparc32_dma.c
+++ b/hw/dma/sparc32_dma.c
@@ -230,7 +230,7 @@ static void dma_mem_write(void *opaque, hwaddr addr,
 static const MemoryRegionOps dma_mem_ops = {
     .read = dma_mem_read,
     .write = dma_mem_write,
-    .endianness = DEVICE_NATIVE_ENDIAN,
+    .endianness = DEVICE_BIG_ENDIAN,
     .valid = {
         .min_access_size = 4,
         .max_access_size = 4,
diff --git a/hw/intc/grlib_irqmp.c b/hw/intc/grlib_irqmp.c
index e0f26466ba3..454f25b185c 100644
--- a/hw/intc/grlib_irqmp.c
+++ b/hw/intc/grlib_irqmp.c
@@ -330,7 +330,7 @@ static void grlib_irqmp_write(void *opaque, hwaddr addr,
 static const MemoryRegionOps grlib_irqmp_ops = {
     .read = grlib_irqmp_read,
     .write = grlib_irqmp_write,
-    .endianness = DEVICE_NATIVE_ENDIAN,
+    .endianness = DEVICE_BIG_ENDIAN,
     .valid = {
         .min_access_size = 4,
         .max_access_size = 4,
diff --git a/hw/intc/slavio_intctl.c b/hw/intc/slavio_intctl.c
index 00b80bb177c..6a7be888f24 100644
--- a/hw/intc/slavio_intctl.c
+++ b/hw/intc/slavio_intctl.c
@@ -135,7 +135,7 @@ static void slavio_intctl_mem_writel(void *opaque, hwaddr addr,
 static const MemoryRegionOps slavio_intctl_mem_ops = {
     .read = slavio_intctl_mem_readl,
     .write = slavio_intctl_mem_writel,
-    .endianness = DEVICE_NATIVE_ENDIAN,
+    .endianness = DEVICE_BIG_ENDIAN,
     .valid = {
         .min_access_size = 4,
         .max_access_size = 4,
@@ -205,7 +205,7 @@ static void slavio_intctlm_mem_writel(void *opaque, hwaddr addr,
 static const MemoryRegionOps slavio_intctlm_mem_ops = {
     .read = slavio_intctlm_mem_readl,
     .write = slavio_intctlm_mem_writel,
-    .endianness = DEVICE_NATIVE_ENDIAN,
+    .endianness = DEVICE_BIG_ENDIAN,
     .valid = {
         .min_access_size = 4,
         .max_access_size = 4,
diff --git a/hw/misc/eccmemctl.c b/hw/misc/eccmemctl.c
index 81fc536131c..4af106dcaa0 100644
--- a/hw/misc/eccmemctl.c
+++ b/hw/misc/eccmemctl.c
@@ -232,7 +232,7 @@ static uint64_t ecc_mem_read(void *opaque, hwaddr addr,
 static const MemoryRegionOps ecc_mem_ops = {
     .read = ecc_mem_read,
     .write = ecc_mem_write,
-    .endianness = DEVICE_NATIVE_ENDIAN,
+    .endianness = DEVICE_BIG_ENDIAN,
     .valid = {
         .min_access_size = 4,
         .max_access_size = 4,
diff --git a/hw/misc/slavio_misc.c b/hw/misc/slavio_misc.c
index a034df3592f..aaca89de734 100644
--- a/hw/misc/slavio_misc.c
+++ b/hw/misc/slavio_misc.c
@@ -147,7 +147,7 @@ static uint64_t slavio_cfg_mem_readb(void *opaque, hwaddr addr,
 static const MemoryRegionOps slavio_cfg_mem_ops = {
     .read = slavio_cfg_mem_readb,
     .write = slavio_cfg_mem_writeb,
-    .endianness = DEVICE_NATIVE_ENDIAN,
+    .endianness = DEVICE_BIG_ENDIAN,
     .valid = {
         .min_access_size = 1,
         .max_access_size = 1,
@@ -177,7 +177,7 @@ static uint64_t slavio_diag_mem_readb(void *opaque, hwaddr addr,
 static const MemoryRegionOps slavio_diag_mem_ops = {
     .read = slavio_diag_mem_readb,
     .write = slavio_diag_mem_writeb,
-    .endianness = DEVICE_NATIVE_ENDIAN,
+    .endianness = DEVICE_BIG_ENDIAN,
     .valid = {
         .min_access_size = 1,
         .max_access_size = 1,
@@ -207,7 +207,7 @@ static uint64_t slavio_mdm_mem_readb(void *opaque, hwaddr addr,
 static const MemoryRegionOps slavio_mdm_mem_ops = {
     .read = slavio_mdm_mem_readb,
     .write = slavio_mdm_mem_writeb,
-    .endianness = DEVICE_NATIVE_ENDIAN,
+    .endianness = DEVICE_BIG_ENDIAN,
     .valid = {
         .min_access_size = 1,
         .max_access_size = 1,
@@ -245,7 +245,7 @@ static uint64_t slavio_aux1_mem_readb(void *opaque, hwaddr addr,
 static const MemoryRegionOps slavio_aux1_mem_ops = {
     .read = slavio_aux1_mem_readb,
     .write = slavio_aux1_mem_writeb,
-    .endianness = DEVICE_NATIVE_ENDIAN,
+    .endianness = DEVICE_BIG_ENDIAN,
     .valid = {
         .min_access_size = 1,
         .max_access_size = 1,
@@ -282,7 +282,7 @@ static uint64_t slavio_aux2_mem_readb(void *opaque, hwaddr addr,
 static const MemoryRegionOps slavio_aux2_mem_ops = {
     .read = slavio_aux2_mem_readb,
     .write = slavio_aux2_mem_writeb,
-    .endianness = DEVICE_NATIVE_ENDIAN,
+    .endianness = DEVICE_BIG_ENDIAN,
     .valid = {
         .min_access_size = 1,
         .max_access_size = 1,
@@ -310,7 +310,7 @@ static uint64_t apc_mem_readb(void *opaque, hwaddr addr,
 static const MemoryRegionOps apc_mem_ops = {
     .read = apc_mem_readb,
     .write = apc_mem_writeb,
-    .endianness = DEVICE_NATIVE_ENDIAN,
+    .endianness = DEVICE_BIG_ENDIAN,
     .valid = {
         .min_access_size = 1,
         .max_access_size = 1,
@@ -355,7 +355,7 @@ static void slavio_sysctrl_mem_writel(void *opaque, hwaddr addr,
 static const MemoryRegionOps slavio_sysctrl_mem_ops = {
     .read = slavio_sysctrl_mem_readl,
     .write = slavio_sysctrl_mem_writel,
-    .endianness = DEVICE_NATIVE_ENDIAN,
+    .endianness = DEVICE_BIG_ENDIAN,
     .valid = {
         .min_access_size = 4,
         .max_access_size = 4,
@@ -397,7 +397,7 @@ static void slavio_led_mem_writew(void *opaque, hwaddr addr,
 static const MemoryRegionOps slavio_led_mem_ops = {
     .read = slavio_led_mem_readw,
     .write = slavio_led_mem_writew,
-    .endianness = DEVICE_NATIVE_ENDIAN,
+    .endianness = DEVICE_BIG_ENDIAN,
     .valid = {
         .min_access_size = 2,
         .max_access_size = 2,
diff --git a/hw/rtc/sun4v-rtc.c b/hw/rtc/sun4v-rtc.c
index 29e24ef6bed..e9e66c2b7c5 100644
--- a/hw/rtc/sun4v-rtc.c
+++ b/hw/rtc/sun4v-rtc.c
@@ -49,7 +49,7 @@ static void sun4v_rtc_write(void *opaque, hwaddr addr,
 static const MemoryRegionOps sun4v_rtc_ops = {
     .read = sun4v_rtc_read,
     .write = sun4v_rtc_write,
-    .endianness = DEVICE_NATIVE_ENDIAN,
+    .endianness = DEVICE_BIG_ENDIAN,
 };
 
 void sun4v_rtc_init(hwaddr addr)
diff --git a/hw/timer/grlib_gptimer.c b/hw/timer/grlib_gptimer.c
index 0e06fa09e99..dfe9264468c 100644
--- a/hw/timer/grlib_gptimer.c
+++ b/hw/timer/grlib_gptimer.c
@@ -332,7 +332,7 @@ static void grlib_gptimer_write(void *opaque, hwaddr addr,
 static const MemoryRegionOps grlib_gptimer_ops = {
     .read = grlib_gptimer_read,
     .write = grlib_gptimer_write,
-    .endianness = DEVICE_NATIVE_ENDIAN,
+    .endianness = DEVICE_BIG_ENDIAN,
     .valid = {
         .min_access_size = 4,
         .max_access_size = 4,
diff --git a/hw/timer/slavio_timer.c b/hw/timer/slavio_timer.c
index 3e071fbdb4c..81e6e55415d 100644
--- a/hw/timer/slavio_timer.c
+++ b/hw/timer/slavio_timer.c
@@ -329,7 +329,7 @@ static void slavio_timer_mem_writel(void *opaque, hwaddr addr,
 static const MemoryRegionOps slavio_timer_mem_ops = {
     .read = slavio_timer_mem_readl,
     .write = slavio_timer_mem_writel,
-    .endianness = DEVICE_NATIVE_ENDIAN,
+    .endianness = DEVICE_BIG_ENDIAN,
     .valid = {
         .min_access_size = 4,
         .max_access_size = 8,
-- 
2.52.0


