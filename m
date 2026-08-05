Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 21C08C55174
	for <qemu-devel@archiver.kernel.org>; Wed,  5 Aug 2026 15:33:02 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wrdZg-0005rZ-N8; Wed, 05 Aug 2026 11:30:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <simonxhy0404@gmail.com>)
 id 1wrdZZ-0005pn-S6
 for qemu-devel@nongnu.org; Wed, 05 Aug 2026 11:30:27 -0400
Received: from mail-oi1-x22a.google.com ([2607:f8b0:4864:20::22a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <simonxhy0404@gmail.com>)
 id 1wrdZT-0007eT-On
 for qemu-devel@nongnu.org; Wed, 05 Aug 2026 11:30:23 -0400
Received: by mail-oi1-x22a.google.com with SMTP id
 5614622812f47-4a4c6081f9fso373387b6e.3
 for <qemu-devel@nongnu.org>; Wed, 05 Aug 2026 08:30:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1785943818; x=1786548618; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=ohcG8pgswlTjm53uOt+LoCB/5w9mw1ixcb2ML+/YikM=;
 b=A1m4VbeSca9RcAWeW0h594eaUfEPykX6rJb4PuqohUQneaAamLRzxyzWT1CLFl+f/Z
 8SjH1y2NsxRGV9hFLTWsONF4MrooSxEXmg5YRYcr9EhHl4Baf8mqHVnmpgoVrxbpL1hK
 kg2hZ/Jp5wJoBNAAVF0nqC3EO2c4D3NLBcWv1hksERPHgEF2dV/u3AGk+N451Mqo14Np
 4knLWBeOgqob/EKcMZe0tCs7U3y9XlOM/JTUPEJYBS/Viu2n0EatBS0PJUYaQgGRMcN1
 /rUR3fsJUsGhnjnfudhLO5WvYrMYyIU65V7p9HJ5sJot4cwMevWh4NGKc4yTfk3teouO
 qo0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1785943818; x=1786548618;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=ohcG8pgswlTjm53uOt+LoCB/5w9mw1ixcb2ML+/YikM=;
 b=iARwlkpJM3gsKLLz9qH4eay66UYQ6EUDEJhKNMBkhPXHIlmhVvjSlpZk2et1j9Jgnb
 5HOyP1D5QghCbY/lG0pnZitLY1QLw0H/nxlBRcZrq1k38uJ6gMPINn4VT3FKDlLBB5af
 a0Z33dwJSBkOEET3OSC8fcVgWRq2od1AihlxE7LmGJUunXiE2ud0/yjSAD4knQgisKx4
 Bt9SeX93Ce0LdQ7KcgnsBgWATAct7HFvzejWh5QCsHzOQVK4YhZjTMjoDayDdLveyyyY
 jx9S+b8cdPRnBfj0jwbzSehaZAHj7XVBxPCriLNG/dSzjlWLr01xauUfmYF2nwxHBD58
 5oIw==
X-Gm-Message-State: AOJu0YzY1s0Qpp5zw7/mTi7hMu3Z9qg2LvwksrrK3Si8hAdycJi/7cZk
 peAlQWRSNLFdTmPB3O7s6Tep9JsyrgFjnAnyGPNwC4Zzk+nu+a2xRb4TrCEcOXaw
X-Gm-Gg: AR+sD10+eHtU3DRfof1jBzgeGi3vJeEyBhMlACWvIrWcOFjXNQCftBr2pKtu+oc6NlI
 lDnjn9R7zFnePydxJ2c3gV0q4P3XjEhzijK227JeSHChZyGM5L/gfhG7cgDww1gdXKvYH7FDVnH
 UlSwBHk1QRvkkgDFp7DocsOosLhD3SDGaoBNnoWP1QPg3c8BL0lDD11fzU6wjzODktkRnyr9yI3
 2qxYeWLIVHiaNLAdizwypNthjHKk5nEwLm6XSrfktQC3ZZ3bo7CGil9i/oLMRj8EUI6nxyTRDkl
 fkFzUFkrTgo1LZlMI3Bcd9V7CAEyKkMdlzGvcBf7k/fv4blPVGTVGLy33ElN1TN1CQEvjOrXzvX
 lzZID3qoLwvThza0JdGHHgAb9d6jJ/lT3AVDn1x/3aRzP2ekEGOi1uCHuJ4Vwq+P92X2bTMIs3t
 xItm9VEkNXnVv1Xzi3ejo8C4h8uXwG4y1aabWM2YKENzVHdI+eVydZiP7d7ndNgMBindKnm72ER
 LblfXn63MvI0oT9Gm9DNhU=
X-Received: by 2002:a05:6808:1919:b0:495:d7ec:b6be with SMTP id
 5614622812f47-4afae193bedmr4734324b6e.18.1785943817591; 
 Wed, 05 Aug 2026 08:30:17 -0700 (PDT)
Received: from HPE-2MQ6131DV6.ams.hpecorp.net ([170.85.99.9])
 by smtp.gmail.com with ESMTPSA id
 5614622812f47-4afae75ce1bsm2185614b6e.15.2026.08.05.08.30.16
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 05 Aug 2026 08:30:17 -0700 (PDT)
From: Simon Xu <simonxhy0404@gmail.com>
To: qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org, Owen Giles <owen.giles@hpe.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 Robert Elliott <elliott@hpe.com>, Simon Xu <simonxhy0404@gmail.com>
Subject: [PATCH v2 8/9] hw/arm/mps2-tz.c add Arm mps3-an555 board
Date: Wed,  5 Aug 2026 10:30:04 -0500
Message-ID: <20260805153005.9989-9-simonxhy0404@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260805153005.9989-1-simonxhy0404@gmail.com>
References: <20260805153005.9989-1-simonxhy0404@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::22a;
 envelope-from=simonxhy0404@gmail.com; helo=mail-oi1-x22a.google.com
X-Spam_score_int: -17
X-Spam_score: -1.8
X-Spam_bar: -
X-Spam_report: (-1.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FREEMAIL_ENVFROM_END_DIGIT=0.25, FREEMAIL_FROM=0.001,
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

Add mps3-an555 board modeled after the existing mps3-an547 board.
Add UnimplementedDeivceState for timing adapters and qspi controllers
in MPS2TZMachineState.

Changes in AN555:
Timing adapters in APB PPC EX0 instead of MPC.
Additional QSPI controllers in AHB PPC EX0.
Additional AHB PPC EX1 with DMA.
Create standalone unimplemented devices for MPC instead of timing adapters.

Include documentation for SSE-310 and mps3-an555.

Arm mps3-an555 TRM: https://developer.arm.com/documentation/107642/latest/

Reviewed-by: Owen Giles <owen.giles@hpe.com>
Reviewed-by: Robert Elliott <elliott@hpe.com>
Signed-off-by: Simon Xu <simonxhy0404@gmail.com>
---
v1 -> v2
	Move board and application note documentation locations
	Revert MPS2TZ_NUMIRQ_MAX to 96 from 100
	Fix timing adapter and MPC creation location
	Add QSPI controller to AHB PPC EX0
	Add GPIOALT2 register to FPGAIO block in next patch
---
 docs/system/arm/mps2.rst |   6 +-
 hw/arm/mps2-tz.c         | 153 ++++++++++++++++++++++++++++++++++++++-
 2 files changed, 154 insertions(+), 5 deletions(-)

diff --git a/docs/system/arm/mps2.rst b/docs/system/arm/mps2.rst
index a305935cc4..489a8b0fa7 100644
--- a/docs/system/arm/mps2.rst
+++ b/docs/system/arm/mps2.rst
@@ -1,5 +1,5 @@
-Arm MPS2 and MPS3 boards (``mps2-an385``, ``mps2-an386``, ``mps2-an500``, ``mps2-an505``, ``mps2-an511``, ``mps2-an521``, ``mps3-an524``, ``mps3-an536``, ``mps3-an547``)
-=========================================================================================================================================================================
+Arm MPS2 and MPS3 boards (``mps2-an385``, ``mps2-an386``, ``mps2-an500``, ``mps2-an505``, ``mps2-an511``, ``mps2-an521``, ``mps3-an524``, ``mps3-an536``, ``mps3-an547``, ``mps3-an555``)
+=========================================================================================================================================================================================
 
 These board models use Arm M-profile or R-profile CPUs.
 
@@ -31,6 +31,8 @@ FPGA images using M-profile CPUs:
   Dual Cortex-M33 on an MPS3, as documented in Arm Application Note AN524
 ``mps3-an547``
   Cortex-M55 on an MPS3, as documented in Arm Application Note AN547
+``mps3-an555``
+  Cortex-M85 on an MPS3, as documented in Arm Application Note AN555
 
 FPGA images using R-profile CPUs:
 
diff --git a/hw/arm/mps2-tz.c b/hw/arm/mps2-tz.c
index f101c1b7c3..2cb461ca71 100644
--- a/hw/arm/mps2-tz.c
+++ b/hw/arm/mps2-tz.c
@@ -1,5 +1,5 @@
 /*
- * ARM V2M MPS2 board emulation, trustzone aware FPGA images
+ * Arm V2M MPS2 and MPS3 board emulation, trustzone aware FPGA images
  *
  * Copyright (c) 2017 Linaro Limited
  * Written by Peter Maydell
@@ -18,13 +18,17 @@
  *  "mps2-an521" -- Dual Cortex-M33 as documented in Application Note AN521
  *  "mps2-an524" -- Dual Cortex-M33 as documented in Application Note AN524
  *  "mps2-an547" -- Single Cortex-M55 as documented in Application Note AN547
+ *  "mps3-an555" -- Single Cortex-M85 as documented in Application Note AN555
  *
  * Links to the TRM for the board itself and to the various Application
  * Notes which document the FPGA images can be found here:
  * https://developer.arm.com/products/system-design/development-boards/fpga-prototyping-boards/mps2
  *
- * Board TRM:
+ * MPS2 and MPS2+ Board TRM:
  * https://developer.arm.com/documentation/100112/latest/
+ * MPS3 Board TRM:
+ * https://developer.arm.com/documentation/100765/latest/
+ * 
  * Application Note AN505:
  * https://developer.arm.com/documentation/dai0505/latest/
  * Application Note AN521:
@@ -33,6 +37,8 @@
  * https://developer.arm.com/documentation/dai0524/latest/
  * Application Note AN547:
  * https://developer.arm.com/documentation/dai0547/latest/
+ * Application Note AN555:
+ * https://developer.arm.com/documentation/107642/latest/
  *
  * The AN505 defers to the Cortex-M33 processor ARMv8M IoT Kit FVP User Guide
  * (ARM ECM0601256) for the details of some of the device layout:
@@ -42,6 +48,8 @@
  *  https://developer.arm.com/documentation/101104/latest/
  * and the AN547 uses the SSE-300, whose layout is in the SSE-300 TRM:
  *  https://developer.arm.com/documentation/101773/latest/
+ * and the AN555 uses the SSE-310, whose layout is in the SSE-310 TRM:
+ *  https://developer.arm.com/documentation/102778/latest/
  */
 
 #include "qemu/osdep.h"
@@ -85,6 +93,7 @@ typedef enum MPS2TZFPGAType {
     FPGA_AN521,
     FPGA_AN524,
     FPGA_AN547,
+    FPGA_AN555,
 } MPS2TZFPGAType;
 
 /*
@@ -153,6 +162,8 @@ struct MPS2TZMachineState {
     UnimplementedDeviceState gfx;
     UnimplementedDeviceState cldc;
     UnimplementedDeviceState usb;
+    UnimplementedDeviceState ta[3]; /* timing adatper */
+    UnimplementedDeviceState qspi_controller[3];
     PL031State rtc;
     PL080State dma[4];
     TZMSC msc[4];
@@ -173,6 +184,7 @@ struct MPS2TZMachineState {
 #define TYPE_MPS2TZ_AN521_MACHINE MACHINE_TYPE_NAME("mps2-an521")
 #define TYPE_MPS3TZ_AN524_MACHINE MACHINE_TYPE_NAME("mps3-an524")
 #define TYPE_MPS3TZ_AN547_MACHINE MACHINE_TYPE_NAME("mps3-an547")
+#define TYPE_MPS3TZ_AN555_MACHINE MACHINE_TYPE_NAME("mps3-an555")
 
 OBJECT_DECLARE_TYPE(MPS2TZMachineState, MPS2TZMachineClass, MPS2TZ_MACHINE)
 
@@ -207,6 +219,15 @@ static const uint32_t an524_oscclk[] = {
     23750000,
 };
 
+static const uint32_t an555_oscclk[] = {
+    24000000,
+    25000000,
+    30000000,
+    50000000,
+    24576000,
+    23750000,
+};
+
 static const RAMInfo an505_raminfo[] = { {
         .name = "ssram-0",
         .base = 0x00000000,
@@ -1028,7 +1049,6 @@ static void mps2tz_common_init(MachineState *machine)
                 { "uart3", make_uart, &mms->uart[3], 0x41306000, 0x1000, { 38, 39, 45 } },
                 { "uart4", make_uart, &mms->uart[4], 0x41307000, 0x1000, { 40, 41, 46 } },
                 { "uart5", make_uart, &mms->uart[5], 0x41308000, 0x1000, { 124, 125, 126 } },
-
                 { /* port 9 reserved */ },
                 { "clcd", make_unimp_dev, &mms->cldc, 0x4130a000, 0x1000 },
                 { "rtc", make_rtc, &mms->rtc, 0x4130b000, 0x1000 },
@@ -1082,7 +1102,63 @@ static void mps2tz_common_init(MachineState *machine)
                 { "uart3", make_uart, &mms->uart[3], 0x49306000, 0x1000, { 39, 40, 46 } },
                 { "uart4", make_uart, &mms->uart[4], 0x49307000, 0x1000, { 41, 42, 47 } },
                 { "uart5", make_uart, &mms->uart[5], 0x49308000, 0x1000, { 125, 126, 127 } },
+                { /* port 9 reserved */ },
+                { "clcd", make_unimp_dev, &mms->cldc, 0x4930a000, 0x1000 },
+                { "rtc", make_rtc, &mms->rtc, 0x4930b000, 0x1000 },
+            },
+        }, {
+            .name = "ahb_ppcexp0",
+            .ports = {
+                { "gpio0", make_unimp_dev, &mms->gpio[0], 0x41100000, 0x1000 },
+                { "gpio1", make_unimp_dev, &mms->gpio[1], 0x41101000, 0x1000 },
+                { "gpio2", make_unimp_dev, &mms->gpio[2], 0x41102000, 0x1000 },
+                { "gpio3", make_unimp_dev, &mms->gpio[3], 0x41103000, 0x1000 },
+                { /* port 4 USER AHB interface 0 */ },
+                { /* port 5 USER AHB interface 1 */ },
+                { /* port 6 USER AHB interface 2 */ },
+                { /* port 7 USER AHB interface 3 */ },
+                { "eth-usb", make_eth_usb, NULL, 0x41400000, 0x200000, { 49 } },
+            },
+        },
+    };
 
+    const PPCInfo an555_ppcs[] = { {
+            .name = "apb_ppcexp0",
+            .ports = {
+                { "sram-timing-adapter", make_unimp_dev, &mms->ta[0], 0x41700000, 0x1000 },
+                { "qspi-timing-adapter", make_unimp_dev, &mms->ta[1], 0x41701000, 0x1000 },
+                { "ddr4-timing-adapter", make_unimp_dev, &mms->ta[2], 0x41702000, 0x1000 },
+            },
+        }, {
+            .name = "apb_ppcexp1",
+            .ports = {
+                { "i2c0", make_i2c, &mms->i2c[0], 0x49200000, 0x1000, {},
+                  { .i2c_internal = true /* touchscreen */ } },
+                { "i2c1", make_i2c, &mms->i2c[1], 0x49201000, 0x1000, {},
+                  { .i2c_internal = true /* audio conf */ } },
+                { "spi0", make_spi, &mms->spi[0], 0x49202000, 0x1000, { 53 } },
+                { "spi1", make_spi, &mms->spi[1], 0x49203000, 0x1000, { 54 } },
+                { "spi2", make_spi, &mms->spi[2], 0x49204000, 0x1000, { 55 } },
+                { "i2c2", make_i2c, &mms->i2c[2], 0x49205000, 0x1000, {},
+                  { .i2c_internal = false /* shield 0 */ } },
+                { "i2c3", make_i2c, &mms->i2c[3], 0x49206000, 0x1000, {},
+                  { .i2c_internal = false /* shield 1 */ } },
+                { /* port 7 reserved */ },
+                { "i2c4", make_i2c, &mms->i2c[4], 0x49208000, 0x1000, {},
+                  { .i2c_internal = true /* DDR4 EEPROM */ } },
+            },
+        }, {
+            .name = "apb_ppcexp2",
+            .ports = {
+                { "scc", make_scc, &mms->scc, 0x49300000, 0x1000 },
+                { "i2s-audio", make_unimp_dev, &mms->i2s_audio, 0x49301000, 0x1000 },
+                { "fpgaio", make_fpgaio, &mms->fpgaio, 0x49302000, 0x1000 },
+                { "uart0", make_uart, &mms->uart[0], 0x49303000, 0x1000, { 33, 34, 43 } },
+                { "uart1", make_uart, &mms->uart[1], 0x49304000, 0x1000, { 35, 36, 44 } },
+                { "uart2", make_uart, &mms->uart[2], 0x49305000, 0x1000, { 37, 38, 45 } },
+                { "uart3", make_uart, &mms->uart[3], 0x49306000, 0x1000, { 39, 40, 46 } },
+                { "uart4", make_uart, &mms->uart[4], 0x49307000, 0x1000, { 41, 42, 47 } },
+                { "uart5", make_uart, &mms->uart[5], 0x49308000, 0x1000, { 125, 126, 127 } },
                 { /* port 9 reserved */ },
                 { "clcd", make_unimp_dev, &mms->cldc, 0x4930a000, 0x1000 },
                 { "rtc", make_rtc, &mms->rtc, 0x4930b000, 0x1000 },
@@ -1099,6 +1175,24 @@ static void mps2tz_common_init(MachineState *machine)
                 { /* port 6 USER AHB interface 2 */ },
                 { /* port 7 USER AHB interface 3 */ },
                 { "eth-usb", make_eth_usb, NULL, 0x41400000, 0x200000, { 49 } },
+                { /* port 9 reserved */ },
+                { /* port 10 reserved */ },
+                { /* port 11 reserved */ },
+                { /* port 12 reserved */ },
+                { "qspi-controller0", make_unimp_dev, &mms->qspi_controller[0],
+                  0x41800000, 0x1000 },
+                { "qspi-controller1", make_unimp_dev, &mms->qspi_controller[1],
+                  0x41801000, 0x1000 },
+                { "qspi-controller2", make_unimp_dev, &mms->qspi_controller[2],
+                  0x41802000, 0x1000 },
+            },
+        }, {
+            .name = "ahb_ppcexp1",
+            .ports = {
+                { "dma0", make_dma, &mms->dma[0], 0x41200000, 0x1000, { 59, 57, 58 } },
+                { "dma1", make_dma, &mms->dma[1], 0x41201000, 0x1000, { 62, 60, 61 } },
+                { "dma2", make_dma, &mms->dma[2], 0x41202000, 0x1000, { 65, 63, 64 } },
+                { "dma3", make_dma, &mms->dma[3], 0x41203000, 0x1000, { 68, 66, 67 } },
             },
         },
     };
@@ -1117,6 +1211,10 @@ static void mps2tz_common_init(MachineState *machine)
         ppcs = an547_ppcs;
         num_ppcs = ARRAY_SIZE(an547_ppcs);
         break;
+    case FPGA_AN555:
+        ppcs = an555_ppcs;
+        num_ppcs = ARRAY_SIZE(an555_ppcs);
+        break;
     default:
         g_assert_not_reached();
     }
@@ -1200,6 +1298,12 @@ static void mps2tz_common_init(MachineState *machine)
         create_unimplemented_device("U55 timing adapter 1", 0x48103000, 0x1000);
     }
 
+    if (mmc->fpga_type == FPGA_AN555) {
+        create_unimplemented_device("SRAM MPC", 0x57000000, 0x1000);
+        create_unimplemented_device("QSPI MPC", 0x57001000, 0x1000);
+        create_unimplemented_device("DDR4 MPC", 0x57002000, 0x1000);
+    }
+
     create_non_mpc_ram(mms);
 
     if (mmc->fpga_type == FPGA_AN524) {
@@ -1447,6 +1551,41 @@ static void mps3tz_an547_class_init(ObjectClass *oc, const void *data)
     mps2tz_set_default_ram_info(mmc);
 }
 
+static void mps3tz_an555_class_init(ObjectClass *oc, const void *data)
+{
+    MachineClass *mc = MACHINE_CLASS(oc);
+    MPS2TZMachineClass *mmc = MPS2TZ_MACHINE_CLASS(oc);
+    static const char * const valid_cpu_types[] = {
+        ARM_CPU_TYPE_NAME("cortex-m85"),
+        NULL
+    };
+
+    mc->desc = "ARM MPS3 with AN555 FPGA image for Cortex-M85";
+    mc->default_cpus = 1;
+    mc->min_cpus = mc->default_cpus;
+    mc->max_cpus = mc->default_cpus;
+    mmc->fpga_type = FPGA_AN555;
+    mc->default_cpu_type = ARM_CPU_TYPE_NAME("cortex-m85");
+    mc->valid_cpu_types = valid_cpu_types;
+    mmc->scc_id = 0x41055551;
+    mmc->sysclk_frq = 25 * 1000 * 1000; /* 25MHz */
+    mmc->apb_periph_frq = 25 * 1000 * 1000; /* 25MHz */
+    mmc->oscclk = an555_oscclk;
+    mmc->len_oscclk = ARRAY_SIZE(an555_oscclk);
+    mmc->fpgaio_num_leds = 10;
+    mmc->fpgaio_has_switches = true;
+    mmc->fpgaio_has_dbgctrl = true;
+    mmc->numirq = 96;
+    mmc->uart_overflow_irq = 48;
+    mmc->init_svtor = 0x00000000;
+    mmc->cpu0_mpu_s = mmc->cpu0_mpu_ns = 8;
+    mmc->sram_addr_width = 21;
+    mmc->raminfo = an547_raminfo; /* same as AN547*/
+    mmc->armsse_type = TYPE_SSE310;
+    mmc->boot_ram_size = 512 * KiB;
+    mps2tz_set_default_ram_info(mmc);
+}
+
 static const TypeInfo mps2tz_info = {
     .name = TYPE_MPS2TZ_MACHINE,
     .parent = TYPE_MACHINE,
@@ -1488,6 +1627,13 @@ static const TypeInfo mps3tz_an547_info = {
     .interfaces = arm_machine_interfaces,
 };
 
+static const TypeInfo mps3tz_an555_info = {
+    .name = TYPE_MPS3TZ_AN555_MACHINE,
+    .parent = TYPE_MPS2TZ_MACHINE,
+    .class_init = mps3tz_an555_class_init,
+    .interfaces = arm_machine_interfaces,
+};
+
 static void mps2tz_machine_init(void)
 {
     type_register_static(&mps2tz_info);
@@ -1495,6 +1641,7 @@ static void mps2tz_machine_init(void)
     type_register_static(&mps2tz_an521_info);
     type_register_static(&mps3tz_an524_info);
     type_register_static(&mps3tz_an547_info);
+    type_register_static(&mps3tz_an555_info);
 }
 
 type_init(mps2tz_machine_init);
-- 
2.53.0


