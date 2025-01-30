Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 82A1AC02193
	for <qemu-devel@archiver.kernel.org>; Thu, 30 Jan 2025 18:27:26 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tdZFq-0004k5-VP; Thu, 30 Jan 2025 13:27:07 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tdZFk-0004JM-G9
 for qemu-devel@nongnu.org; Thu, 30 Jan 2025 13:27:00 -0500
Received: from mail-wr1-x429.google.com ([2a00:1450:4864:20::429])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tdZFi-0001Pl-Qu
 for qemu-devel@nongnu.org; Thu, 30 Jan 2025 13:27:00 -0500
Received: by mail-wr1-x429.google.com with SMTP id
 ffacd0b85a97d-3863703258fso1477683f8f.1
 for <qemu-devel@nongnu.org>; Thu, 30 Jan 2025 10:26:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1738261617; x=1738866417; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=DSiba+A4z/eFTmtOIndcY8wTtwzH+kBQH69a+P0DCPY=;
 b=Is6RaXYmMp71qie+yOf7R8BfthnVaaHJRNpYa1p0NjSuYDXlAHNDpNSjZVPfL8pN9W
 W8PphtdBgZ22aowP+qbgU16Klxvb4Q0hEyheN9wLgO5eq9PVxF1EGvV4SoOziK0kUjLJ
 LomGEjMmKE/epAGqUtC+0IukDaRb3Fb14Syd/3ghbGOQK0FEH85try86Q+ge5ODmCTzW
 ZRq1nrL1o5LNi7oHHzp2NyuFmDz0x4iZM529CR6lre12G+/mIOMi72MCOy/9en+9fmTX
 ONlsuHixJtzI1UkW23egAlw8seiIscKMO58rpCV/DL/nBNzW5r15IjSIhGM/L96HxkfC
 UG9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1738261617; x=1738866417;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=DSiba+A4z/eFTmtOIndcY8wTtwzH+kBQH69a+P0DCPY=;
 b=APXC/LH6jU2W33ZDkKkpIl9jLDW58NC4cSVOkzTnmlre1CuYcLuvucltr/ZSdGOZqK
 1tfnVWyXJoWd5kRL1M+3EwWAd7L3jGZ7zU4lk+TG/D8BjULCZR9hxe7NjFUj+g+boscc
 i9ijFdXxZQbww3zIPgC2Ff6KFo1ajCDkT73oNrq5/HcIoxw72zdXUTSoCsvJsBdDeyWv
 hHYdwrZYuuH4jNBghTjfSmkmUuDQJXZlZheDRJSZs4HZdoGX0ZDbzG6PfSiqUHBsZUpq
 fWmvy4JDL4Kz3+p+31hruFhJMXNhtV0hDVfRUe1sQogiW/KbCKB42MBAdWqs4QJR58/O
 Yn+w==
X-Gm-Message-State: AOJu0YyW7J0JeRIpZiCHBovfSX+yIcRBoIlYpvS26bzYsUwIQUIePCGw
 ohS6PxSRYl01aqx8qwEvdo4evhvDdY361oyN409I4nL/+H3jMWei8avOSaap+JGp2AFoqDxwnT3
 FM5I=
X-Gm-Gg: ASbGncu9ZBOCAJ1It28DI9FXNvMX864WpN+QFMek4OsH7ZL73VX5Zk25cjbviwK705P
 KzxFTYBMM099AmxgR0E70C8agx+c1KMqYaElZSoKtqX2wbbdq87xPW4wHkr68yXcbvrRtG15Okq
 DQCMsjLRPb1KbjdqUnYhuf5X/DJPpcFX0gKFrDcIQt1CDMY/qo9H6nI7GHRF+P3xYeI8AUXSeoi
 6pz653vAPJraOrs6f/ERmlt9+51BZA/puFokAC+mV/orFPfNTeJl/4xmgis6RrZbQKY7pwu1bMb
 vi+KBP24sR8ojiJPCHmJt7IM2d3G9evAJXjLChMRxp9kFEjaQcRpnXJkcKkePtVEIg==
X-Google-Smtp-Source: AGHT+IHPXeUxXPiJEmZ1ZWUQ07iEHs7Er12VLYScLpZSb8JUMfPWww+rGP0/ZwtI7OqIinJtfU9sfQ==
X-Received: by 2002:a5d:5984:0:b0:385:f64e:f177 with SMTP id
 ffacd0b85a97d-38c5a971e63mr3222499f8f.11.1738261617141; 
 Thu, 30 Jan 2025 10:26:57 -0800 (PST)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-38c5c122539sm2730881f8f.46.2025.01.30.10.26.54
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Thu, 30 Jan 2025 10:26:56 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: "Edgar E. Iglesias" <edgar.iglesias@gmail.com>,
 Rob Herring <robh@kernel.org>, qemu-arm@nongnu.org,
 Peter Maydell <peter.maydell@linaro.org>,
 Alistair Francis <alistair@alistair23.me>,
 Igor Mitsyanko <i.mitsyanko@gmail.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH 7/8] hw/arm/highbank: Explicit number of GIC external IRQs
Date: Thu, 30 Jan 2025 19:24:40 +0100
Message-ID: <20250130182441.40480-8-philmd@linaro.org>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250130182441.40480-1-philmd@linaro.org>
References: <20250130182441.40480-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::429;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x429.google.com
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

When not specified, Cortex-A9MP configures its GIC with 64 external
IRQs, (see commit a32134aad89 "arm:make the number of GIC interrupts
configurable"), and Cortex-15MP to 128 (see commit  528622421eb
"hw/cpu/a15mpcore: Correct default value for num-irq").
The Caldexa Highbank board however expects a fixed set of 128
interrupts (see the fixed IRQ length when this board was added in
commit 2488514cef2 ("arm: SoC model for Calxeda Highbank"). Add the
GIC_EXT_IRQS definition (with a comment) to make that explicit.

Except explicitly setting a property value to its same implicit
value, there is no logical change intended.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 hw/arm/highbank.c | 15 +++++++++++----
 1 file changed, 11 insertions(+), 4 deletions(-)

diff --git a/hw/arm/highbank.c b/hw/arm/highbank.c
index 495704d9726..d59f20b88e0 100644
--- a/hw/arm/highbank.c
+++ b/hw/arm/highbank.c
@@ -45,7 +45,14 @@
 #define MVBAR_ADDR              0x200
 #define BOARD_SETUP_ADDR        (MVBAR_ADDR + 8 * sizeof(uint32_t))
 
-#define NIRQ_GIC                160
+/*
+ * The Cortex-A9MP/A15MP may have anything from 0 to 224 external interrupt
+ * IRQ lines (with another 32 internal). We default to 128+32, which
+ * is the number provided by the Cortex-A15MP test chip in the
+ * Versatile Express A15 development board.
+ * Other boards may differ and should set this property appropriately.
+ */
+#define GIC_EXT_IRQS            128
 
 /* Board init.  */
 
@@ -180,7 +187,7 @@ static void calxeda_init(MachineState *machine, enum cxmachines machine_id)
 {
     DeviceState *dev = NULL;
     SysBusDevice *busdev;
-    qemu_irq pic[128];
+    qemu_irq pic[GIC_EXT_IRQS];
     int n;
     unsigned int smp_cpus = machine->smp.cpus;
     qemu_irq cpu_irq[4];
@@ -260,7 +267,7 @@ static void calxeda_init(MachineState *machine, enum cxmachines machine_id)
         break;
     }
     qdev_prop_set_uint32(dev, "num-cpu", smp_cpus);
-    qdev_prop_set_uint32(dev, "num-irq", NIRQ_GIC);
+    qdev_prop_set_uint32(dev, "num-irq", GIC_EXT_IRQS + GIC_INTERNAL);
     busdev = SYS_BUS_DEVICE(dev);
     sysbus_realize_and_unref(busdev, &error_fatal);
     sysbus_mmio_map(busdev, 0, MPCORE_PERIPHBASE);
@@ -271,7 +278,7 @@ static void calxeda_init(MachineState *machine, enum cxmachines machine_id)
         sysbus_connect_irq(busdev, n + 3 * smp_cpus, cpu_vfiq[n]);
     }
 
-    for (n = 0; n < 128; n++) {
+    for (n = 0; n < GIC_EXT_IRQS; n++) {
         pic[n] = qdev_get_gpio_in(dev, n);
     }
 
-- 
2.47.1


