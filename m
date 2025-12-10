Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C9856D3E783
	for <qemu-devel@archiver.kernel.org>; Wed, 10 Dec 2025 23:31:27 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vTTcy-00049Q-OW; Wed, 10 Dec 2025 18:29:50 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from
 <3ZAI6aQYKCqEZVCJOaHPPHMF.DPNRFNV-EFWFMOPOHOV.PSH@flex--yubinz.bounces.google.com>)
 id 1vTTcw-00048E-E4
 for qemu-devel@nongnu.org; Wed, 10 Dec 2025 18:29:46 -0500
Received: from mail-pg1-x54a.google.com ([2607:f8b0:4864:20::54a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from
 <3ZAI6aQYKCqEZVCJOaHPPHMF.DPNRFNV-EFWFMOPOHOV.PSH@flex--yubinz.bounces.google.com>)
 id 1vTTct-0005ie-SC
 for qemu-devel@nongnu.org; Wed, 10 Dec 2025 18:29:45 -0500
Received: by mail-pg1-x54a.google.com with SMTP id
 41be03b00d2f7-c0bead25feeso294560a12.0
 for <qemu-devel@nongnu.org>; Wed, 10 Dec 2025 15:29:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=google.com; s=20230601; t=1765409381; x=1766014181; darn=nongnu.org;
 h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
 :date:from:to:cc:subject:date:message-id:reply-to;
 bh=rHDieZbLHiYnj98/qORFPZurA2OWE7iBD9cPzEH+Dlw=;
 b=qW0eUJ/9U2Cng7fshZzExROpVD+VWyS0+i6ZA1S8QgDuWfOZ253UYS2Fn3xUQsa/Al
 YbYA/7rZU3p1CvVPIKopadHkqHYwp9kO+f2tS3w3DfA0Y5krahdc0VNcCEhjU4zh7+tg
 eHQTg2Gp3om2LQg05tack3HYlbZMYyNXhDge6M2ENiGrW9Aj1bOxHgKOjDJ9fCCS/Yax
 prZL9E6ftB0saXyd8lEGyC6KL5RNkrDrOXjd+dDEkQmCJckisHa/ZvXoQWeIMpQsJRJ+
 e7EUSazN+i2zTbMYIbEuxFYJA/BXgZtcpN0q1y8o8xwfX85KTc/bDO7wZxDhrUjHE3fL
 Y2LA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1765409381; x=1766014181;
 h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
 :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=rHDieZbLHiYnj98/qORFPZurA2OWE7iBD9cPzEH+Dlw=;
 b=oJS9SAlSQ1m5JRTSdJICLxwcDii0/Otzzr5197SAuFiBVW0SwS8L0+38NBq806IcEG
 6wglUr07rts053iGacyh3Lh6qvoaE6S4rshSY1r4n43uuJ/ueCW6iTaz3g3nmj8sgF9A
 2sW41WtS3G8ulOWqGi1UMj6DYwcrZQtzTD8jP6y3ASNVqjV9kC+yK0ffvWVGsjA+WMY1
 AmZCvS8Xp+7Szx2GadEccEgYCU6rf7vbq8VuLG24zLG6rTWBMpD9c0gEFLWGZQvx8BwC
 QXPVdHUSGW6X1Ld4FAD/zewAeHqU76q72BHCWzEcpFr25420S865hqDhkY4xyycBTw8U
 5UnQ==
X-Gm-Message-State: AOJu0Yyw28FmZHFHq0EO8OPSCAbjexxgMWEB2ImOpamtPPdiCYb6i1kx
 ccX/074BM55GdxOMyMmAR0N6HWAuvj5depA5y0TUe4OfHF3DoL+iQ5s0JXn6UDf/O4sqYJ5bHz5
 SvjQmj+BqCdZQ0UooKeQK7qljfNJZv4IJVCad+F+vyD+zj2HzUtINlNPNATA/YdbhSF4vPQIUCK
 S29sU+BEnjD0d2Z1lvi9XINbCSUsCr8G+RTlA=
X-Google-Smtp-Source: AGHT+IEL/IhlkELZonhzWn2r5xauTVadk1P/NM39jdyUjVUzYRXP0WE0ZVT9aDwGbQW9DU0mSpyy+Cyme94=
X-Received: from dlbcq18.prod.google.com
 ([2002:a05:7022:2492:b0:11d:cf4c:62ab])
 (user=yubinz job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:7022:78f:b0:119:e55a:9c06
 with SMTP id a92af1059eb24-11f296d74cbmr3308649c88.34.1765409380954; Wed, 10
 Dec 2025 15:29:40 -0800 (PST)
Date: Wed, 10 Dec 2025 23:29:15 +0000
In-Reply-To: <20251210-aspeed-sgpio-v3-0-eb8b0cf3dd51@google.com>
Mime-Version: 1.0
References: <20251210-aspeed-sgpio-v3-0-eb8b0cf3dd51@google.com>
X-Mailer: b4 0.14.2
Message-ID: <20251210-aspeed-sgpio-v3-4-eb8b0cf3dd51@google.com>
Subject: [PATCH v3 4/6] hw/arm/aspeed_soc: Update Aspeed SoC to support two
 SGPIO controllers
From: Yubin Zou <yubinz@google.com>
To: qemu-devel@nongnu.org
Cc: "=?utf-8?q?C=C3=A9dric_Le_Goater?=" <clg@kaod.org>,
 Peter Maydell <peter.maydell@linaro.org>, 
 Steven Lee <steven_lee@aspeedtech.com>, Troy Lee <leetroy@gmail.com>, 
 Jamin Lin <jamin_lin@aspeedtech.com>,
 Andrew Jeffery <andrew@codeconstruct.com.au>, 
 Joel Stanley <joel@jms.id.au>, Fabiano Rosas <farosas@suse.de>,
 Laurent Vivier <lvivier@redhat.com>, 
 Paolo Bonzini <pbonzini@redhat.com>, Kane-Chen-AS <kane_chen@aspeedtech.com>, 
 Nabih Estefan <nabihestefan@google.com>, qemu-arm@nongnu.org, 
 Yubin Zou <yubinz@google.com>
Content-Type: text/plain; charset="utf-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::54a;
 envelope-from=3ZAI6aQYKCqEZVCJOaHPPHMF.DPNRFNV-EFWFMOPOHOV.PSH@flex--yubinz.bounces.google.com;
 helo=mail-pg1-x54a.google.com
X-Spam_score_int: -95
X-Spam_score: -9.6
X-Spam_bar: ---------
X-Spam_report: (-9.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_MED=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 USER_IN_DEF_DKIM_WL=-7.5 autolearn=unavailable autolearn_force=no
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

This commit updates the Aspeed SoC model to support two SGPIO
controllers, reflecting the hardware capabilities of the AST2700

The memory map and interrupt map are updated to include entries for
two SGPIO controllers (SGPIOM0 and SGPIOM1). This change is a
prerequisite for the full implementation of the SGPIO device model.

Signed-off-by: Yubin Zou <yubinz@google.com>
---
 include/hw/arm/aspeed_soc.h |  8 ++++++--
 hw/arm/aspeed_ast10x0.c     |  6 +++---
 hw/arm/aspeed_ast27x0.c     | 10 ++++++++++
 3 files changed, 19 insertions(+), 5 deletions(-)

diff --git a/include/hw/arm/aspeed_soc.h b/include/hw/arm/aspeed_soc.h
index 4b8e599f1a53bfb2e4d3196d5495cd316f799354..18ff961a38508c5df83b46e187f732d736443f20 100644
--- a/include/hw/arm/aspeed_soc.h
+++ b/include/hw/arm/aspeed_soc.h
@@ -32,6 +32,7 @@
 #include "hw/net/ftgmac100.h"
 #include "target/arm/cpu.h"
 #include "hw/gpio/aspeed_gpio.h"
+#include "hw/gpio/aspeed_sgpio.h"
 #include "hw/sd/aspeed_sdhci.h"
 #include "hw/usb/hcd-ehci.h"
 #include "qom/object.h"
@@ -46,6 +47,7 @@
 #define VBOOTROM_FILE_NAME  "ast27x0_bootrom.bin"
 
 #define ASPEED_SPIS_NUM  3
+#define ASPEED_SGPIO_NUM 2
 #define ASPEED_EHCIS_NUM 4
 #define ASPEED_WDTS_NUM  8
 #define ASPEED_CPUS_NUM  4
@@ -89,6 +91,7 @@ struct AspeedSoCState {
     AspeedMiiState mii[ASPEED_MACS_NUM];
     AspeedGPIOState gpio;
     AspeedGPIOState gpio_1_8v;
+    AspeedSGPIOState sgpiom[ASPEED_SGPIO_NUM];
     AspeedSDHCIState sdhci;
     AspeedSDHCIState emmc;
     AspeedLPCState lpc;
@@ -106,7 +109,6 @@ struct AspeedSoCState {
     UnimplementedDeviceState pwm;
     UnimplementedDeviceState espi;
     UnimplementedDeviceState udc;
-    UnimplementedDeviceState sgpiom;
     UnimplementedDeviceState ltpi;
     UnimplementedDeviceState jtag[ASPEED_JTAG_NUM];
     AspeedAPB2OPBState fsi[2];
@@ -166,6 +168,7 @@ struct AspeedSoCClass {
     uint64_t secsram_size;
     int pcie_num;
     int spis_num;
+    int sgpio_num;
     int ehcis_num;
     int wdts_num;
     int macs_num;
@@ -221,6 +224,8 @@ enum {
     ASPEED_DEV_SDHCI,
     ASPEED_DEV_GPIO,
     ASPEED_DEV_GPIO_1_8V,
+    ASPEED_DEV_SGPIOM0,
+    ASPEED_DEV_SGPIOM1,
     ASPEED_DEV_RTC,
     ASPEED_DEV_TIMER1,
     ASPEED_DEV_TIMER2,
@@ -263,7 +268,6 @@ enum {
     ASPEED_DEV_I3C,
     ASPEED_DEV_ESPI,
     ASPEED_DEV_UDC,
-    ASPEED_DEV_SGPIOM,
     ASPEED_DEV_JTAG0,
     ASPEED_DEV_JTAG1,
     ASPEED_DEV_FSI1,
diff --git a/hw/arm/aspeed_ast10x0.c b/hw/arm/aspeed_ast10x0.c
index 7f49c13391be0b923e317409a0fccfa741f5e658..c141cc080422579ca6b6965369d84dfbe416247b 100644
--- a/hw/arm/aspeed_ast10x0.c
+++ b/hw/arm/aspeed_ast10x0.c
@@ -36,7 +36,7 @@ static const hwaddr aspeed_soc_ast1030_memmap[] = {
     [ASPEED_DEV_ESPI]      = 0x7E6EE000,
     [ASPEED_DEV_SBC]       = 0x7E6F2000,
     [ASPEED_DEV_GPIO]      = 0x7E780000,
-    [ASPEED_DEV_SGPIOM]    = 0x7E780500,
+    [ASPEED_DEV_SGPIOM0]   = 0x7E780500,
     [ASPEED_DEV_TIMER1]    = 0x7E782000,
     [ASPEED_DEV_UART1]     = 0x7E783000,
     [ASPEED_DEV_UART2]     = 0x7E78D000,
@@ -94,7 +94,7 @@ static const int aspeed_soc_ast1030_irqmap[] = {
     [ASPEED_DEV_I2C]       = 110, /* 110 ~ 123 */
     [ASPEED_DEV_KCS]       = 138, /* 138 -> 142 */
     [ASPEED_DEV_UDC]       = 9,
-    [ASPEED_DEV_SGPIOM]    = 51,
+    [ASPEED_DEV_SGPIOM0]   = 51,
     [ASPEED_DEV_JTAG0]     = 27,
     [ASPEED_DEV_JTAG1]     = 53,
 };
@@ -427,7 +427,7 @@ static void aspeed_soc_ast1030_realize(DeviceState *dev_soc, Error **errp)
                                   sc->memmap[ASPEED_DEV_UDC], 0x1000);
     aspeed_mmio_map_unimplemented(s->memory, SYS_BUS_DEVICE(&s->sgpiom),
                                   "aspeed.sgpiom",
-                                  sc->memmap[ASPEED_DEV_SGPIOM], 0x100);
+                                  sc->memmap[ASPEED_DEV_SGPIOM0], 0x100);
 
     aspeed_mmio_map_unimplemented(s->memory, SYS_BUS_DEVICE(&s->jtag[0]),
                                   "aspeed.jtag",
diff --git a/hw/arm/aspeed_ast27x0.c b/hw/arm/aspeed_ast27x0.c
index c484bcd4e22fb49faf9c16992ae2cdfd6cd82da4..e5f04bd16e80696e41005d9062a6df6d060b8088 100644
--- a/hw/arm/aspeed_ast27x0.c
+++ b/hw/arm/aspeed_ast27x0.c
@@ -69,6 +69,8 @@ static const hwaddr aspeed_soc_ast2700_memmap[] = {
     [ASPEED_DEV_ADC]       =  0x14C00000,
     [ASPEED_DEV_SCUIO]     =  0x14C02000,
     [ASPEED_DEV_GPIO]      =  0x14C0B000,
+    [ASPEED_DEV_SGPIOM0]   =  0x14C0C000,
+    [ASPEED_DEV_SGPIOM1]   =  0x14C0D000,
     [ASPEED_DEV_I2C]       =  0x14C0F000,
     [ASPEED_DEV_INTCIO]    =  0x14C18000,
     [ASPEED_DEV_PCIE_PHY2] =  0x14C1C000,
@@ -122,6 +124,8 @@ static const int aspeed_soc_ast2700a0_irqmap[] = {
     [ASPEED_DEV_KCS]       = 128,
     [ASPEED_DEV_ADC]       = 130,
     [ASPEED_DEV_GPIO]      = 130,
+    [ASPEED_DEV_SGPIOM0]   = 130,
+    [ASPEED_DEV_SGPIOM1]   = 130,
     [ASPEED_DEV_I2C]       = 130,
     [ASPEED_DEV_FMC]       = 131,
     [ASPEED_DEV_WDT]       = 131,
@@ -173,6 +177,8 @@ static const int aspeed_soc_ast2700a1_irqmap[] = {
     [ASPEED_DEV_I2C]       = 194,
     [ASPEED_DEV_ADC]       = 194,
     [ASPEED_DEV_GPIO]      = 194,
+    [ASPEED_DEV_SGPIOM0]   = 194,
+    [ASPEED_DEV_SGPIOM1]   = 194,
     [ASPEED_DEV_FMC]       = 195,
     [ASPEED_DEV_WDT]       = 195,
     [ASPEED_DEV_PWM]       = 195,
@@ -214,6 +220,8 @@ static const int ast2700_gic130_gic194_intcmap[] = {
     [ASPEED_DEV_I2C]        = 0,
     [ASPEED_DEV_ADC]        = 16,
     [ASPEED_DEV_GPIO]       = 18,
+    [ASPEED_DEV_SGPIOM0]    = 21,
+    [ASPEED_DEV_SGPIOM1]    = 24,
 };
 
 /* GICINT 131 */
@@ -1061,6 +1069,7 @@ static void aspeed_soc_ast2700a0_class_init(ObjectClass *oc, const void *data)
     sc->sram_size    = 0x20000;
     sc->pcie_num     = 0;
     sc->spis_num     = 3;
+    sc->sgpio_num    = 2;
     sc->ehcis_num    = 2;
     sc->wdts_num     = 8;
     sc->macs_num     = 1;
@@ -1089,6 +1098,7 @@ static void aspeed_soc_ast2700a1_class_init(ObjectClass *oc, const void *data)
     sc->sram_size    = 0x20000;
     sc->pcie_num     = 3;
     sc->spis_num     = 3;
+    sc->sgpio_num    = 2;
     sc->ehcis_num    = 4;
     sc->wdts_num     = 8;
     sc->macs_num     = 3;

-- 
2.52.0.239.gd5f0c6e74e-goog


