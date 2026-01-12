Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A5689CF45D7
	for <qemu-devel@archiver.kernel.org>; Mon, 12 Jan 2026 22:55:23 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vfQoE-0000Q0-BI; Mon, 12 Jan 2026 17:54:50 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vfQoC-0008OA-BF
 for qemu-devel@nongnu.org; Mon, 12 Jan 2026 17:54:48 -0500
Received: from mail-wm1-x330.google.com ([2a00:1450:4864:20::330])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vfQo9-0003nl-Vr
 for qemu-devel@nongnu.org; Mon, 12 Jan 2026 17:54:48 -0500
Received: by mail-wm1-x330.google.com with SMTP id
 5b1f17b1804b1-4779cb0a33fso74412635e9.0
 for <qemu-devel@nongnu.org>; Mon, 12 Jan 2026 14:54:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1768258484; x=1768863284; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=lDveikpmJWnoOd0J2qx9fFPcZSfFPmvU05Qg28oFJLM=;
 b=uVNfqrSfASI4WOgjDK7xAQX2bun00kCyIBrgoIF/EWqFtGwn4svlbFWdQHBMbh/H5n
 7AbQGxww2yg5mOSt8h7NrrFYHte10cUZkO2CsV6+Kg9pAuKPTWflqAJpgye78sfqhImt
 QsysDDVJuQcBpNtonby1Bmqs42Y4XXS/ivhvRQEYkUOnuH4ZrvDNBWiD15fHCkjXB4oV
 JK3ODJJZqYYULwA3xiCoKNsbsfZwHP7OPWzVwrmDRBkk2C1mAg9Vl+FBXrQ7EgdMgX2j
 1I0j/MGAWyGFsDDfkZhMChA0/2Jhr7vl1wbFd/rx8TUBoAAqNv47DTfXIXXr4ctGyAx6
 jwZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1768258484; x=1768863284;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=lDveikpmJWnoOd0J2qx9fFPcZSfFPmvU05Qg28oFJLM=;
 b=PQcEA6b9Lg/jMFzS2v4g+uBT223v2g2tWUs00yS0SK6jYCl5B+iT7j8KiNwIjLbO3K
 6KfL16fQ8qTlUKjJVhEefBUSJwYF7dsk0gn7Vvi6yfVDtzzgqTJwBg2clDsHC9++DwNo
 mMomjt33ohRZN8iy4cLQJu91431hRA5yiMzkBrWlBUEJmNRpWEyCyoZfekhHI7A2LWuz
 xoQm4JIg8YhKi+a90YVbR9do4E1OKLyvRcgUDq6dIR8EhJHXQpPXz1ushRSWMnjZl3SR
 XscXgIZ6garv/8WBwY3bofMmwQOR32AnsChskG+KPGYVkpM6Uf0tuV2vYlEoWMuXfuDC
 EdrA==
X-Gm-Message-State: AOJu0Yz5bOghIVhMFxmk7du/LW8VauZDWkwNQhL+bW0KVxTZ6FFGXRCW
 ZOUVJvXP0B2u0SnB+1fEykshdWFHWAhr+b8x3i6+0zX4AkXRhnw4N5RS0jTOhXclPZPIpFvWuiq
 J1cCSOpg=
X-Gm-Gg: AY/fxX69XCRjgl2tab0/wx87ZrM/rmV9EdCFThb7jr4ro81SKyIqHJNsEuX2GMBoEzH
 gm7U5SiSfNLq5gGAuLxrlJ7V3o2qcSgn0hHbROLiHvzMtlLbTuqreiHHVwrNeNcSKh6XwdnsrKc
 DRRsp11fzLQ3JxWbDCRn80uuFrtMJ1UBZosvaIhYH711ekRzcDWQsQzpxGhG+mAQJ/Yosgiwmaq
 EockoXbRW3yFKqcr0scXNWg3+mx/s8PaUtHHvKwRiQnhh4UXg91SAoex1l0PGrqNuE2xautlu0c
 JHM6yVubhRtvje35Wke1bQ/nxEEfJaxFsDXKqcTvlb+IcN4i/nKFTqRWZfxOU4zZUi8SLSWtv0x
 SsemfM2CKrJMPllxhVO2oLy/6ecREiZbRtNDgbTBSYwY+ccCTDNPZ9EpVntxpwSGojAWawlBrT8
 QBL6ipeEI4nLki9EBPbf++wevkrNBJJ2GQZJrI6iB7Mme74TA2kMGbSIMefnO4
X-Google-Smtp-Source: AGHT+IFNZzi3zqvoKkbtzCmjb71L06gs1wiscON5H0oK5hWB/2NNp8cRO+TS4hSquB3QPASq3MY9Uw==
X-Received: by 2002:a05:600c:3493:b0:477:a54a:acba with SMTP id
 5b1f17b1804b1-47d84b33b86mr237748015e9.17.1768258483950; 
 Mon, 12 Jan 2026 14:54:43 -0800 (PST)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-47eda10285fsm1189925e9.9.2026.01.12.14.54.43
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Mon, 12 Jan 2026 14:54:43 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 50/61] hw/sparc: Mark SPARC-specific peripherals as big-endian
Date: Mon, 12 Jan 2026 23:48:45 +0100
Message-ID: <20260112224857.42068-51-philmd@linaro.org>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260112224857.42068-1-philmd@linaro.org>
References: <20260112224857.42068-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::330;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x330.google.com
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

These devices are only used by the SPARC target, which is
only built as big-endian. Therefore the DEVICE_NATIVE_ENDIAN
definition expand to DEVICE_BIG_ENDIAN (besides, the
DEVICE_LITTLE_ENDIAN case isn't tested). Simplify directly
using DEVICE_BIG_ENDIAN.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <20251224162642.90857-2-philmd@linaro.org>
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
index bcf98160ec3..7844b5b6c90 100644
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
index 92f534552ee..d828c3fd3d4 100644
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
index 59d66d3d4b8..568d6048a63 100644
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
index 7cba3e25a78..36cad82abdf 100644
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
index 5b770599865..a5dc35e7bbf 100644
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
index d860ec15d88..050be4d462f 100644
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
index 640d8e2baa6..c7bf38acd74 100644
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
index dd1be7d698e..0243ea52df3 100644
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
index 49be827c458..3df7d82b8c4 100644
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
index 675b6cd5bd6..3a586adf02d 100644
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
index 099ab6c5866..54998981dbd 100644
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
index 71696a4b615..4a3e227fbab 100644
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


