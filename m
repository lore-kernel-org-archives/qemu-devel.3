Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B7273C624D6
	for <qemu-devel@archiver.kernel.org>; Tue,  1 Sep 2026 13:19:26 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x1ONF-00015V-PW; Tue, 01 Sep 2026 09:18:01 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1x1OND-00013X-Nm
 for qemu-devel@nongnu.org; Tue, 01 Sep 2026 09:17:59 -0400
Received: from mail-ej1-x634.google.com ([2a00:1450:4864:20::634])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1x1ONB-0007CD-5J
 for qemu-devel@nongnu.org; Tue, 01 Sep 2026 09:17:59 -0400
Received: by mail-ej1-x634.google.com with SMTP id
 a640c23a62f3a-c25099bb1fbso112347566b.3
 for <qemu-devel@nongnu.org>; Tue, 01 Sep 2026 06:17:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1788268676; x=1788873476; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=41aOYwEmxEY+ih6nzgTb1fdt/eug0W6vpSXSxjKWKr8=;
 b=Vvapc+8Fih4jZtS3TyM/zaUaQCoDYneDODEV5Ktx2WSPgXer37IDoGNDAxuKqaktpV
 wpeXhtzQiYIgDtKjynyffJouBXpJ7c9Iw2t3mBEF0uNTJ/NVjG3Mf9IudnS1p+oBOYAc
 fn0LfbbFp3DOYPs3Wd+q+1q29xzqy16SDb1zFsQCe8weNcPQHPyzRv93qPnEO0AzGsA0
 Cb7U5IV2ftI3oEUAXKW1BlV/MhSjWvxiXq013HfJiTMf8do7cc/KBslfY4lgs7ssk3YE
 UeYN3O9FBIKrp95U077QKkZ0anOvzm9s3NPUs2tqX9x2s1TtRpLSFiZhfTQooPNKXylV
 NStA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1788268676; x=1788873476;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=41aOYwEmxEY+ih6nzgTb1fdt/eug0W6vpSXSxjKWKr8=;
 b=GGVrRco5ByqCVgHCS10Ya45IwNqZPU9xV0UCYJyT+ygcIApU19d54dsQ2/ysRCfh5G
 m20iHyXlZNN7+6o8m7RjSmXGWScYTy6/MB2yxt8fswTxC+1vs6E+TImGjI1ZRsUB+82N
 S7+WtpKVxrRVHVBWsfQbt92Lm+BMgSvoZMY0XAoX7/loVjIqP6ZtHx6ssgRg753WgvDX
 HHBP42j07YDEjF25yRCWHUECIie6lti7pWnIlFGWR2Y8wQ/xNdpPg+QyPnqDCPV31tV8
 EhVcNMU5PzZ6V0kq/Nhqxc4INRLKBHqxvy9j+G51+w6PJegtiEskEwlKhPRcOkYAYnRk
 93LA==
X-Gm-Message-State: AFuF++niezlPK89eOGcDDU3fZQXNBZ5XbuUZ9cSSreHMtYLma7R73NZN
 6iCiHSAZaCVzeD3TY8GiHy1rpvbvzxC3lqbjfaJ89gtwMrZVAxmjx3DQOTFq9ZzC+R2vZ15VBnQ
 Ru21F/dY=
X-Gm-Gg: AR+sD131MOxGXEhNTp+ZyCN/FT7CoqP3VqjCSWbG5LXVuslmTkpK+5RijnnRu+NTAaN
 pz7pGXqpRuySH79C6Cg6eq8NJopciARkwPGrEDf4fAti2yezDVnwik/YLYm9RXaAW1+cohad3WZ
 qe54z/tZNBt0zbdQiGyMokVK6Z6CvYKujkcuFTKzWAuc59/vkgeCTU7gREkoq5rc0lrf9MU+qtn
 BOLuS8H66R9pSr1NttiweozTqDtrxiQGY9Yag6f9SKX6srdh1BzoOZ6Anem060vyV6UWRJ5LG5R
 XYAAihkC+clFPFS+Hj17cOIiR8OJJUi7tcj4hDuByKzG4us3RHpicf35n2d7KRdkYWKzzJ6Jdoh
 5eA8TReQX+twDFlEJ2FEGvG3B4Xji3b62Edc7j0rwsqoq8cT1dhLPhRiBh2CG+Wwq48AfZcDvDe
 rWuWbbzB1xVr/IbqhNByeWzA1H4KaisMEiOOIDquBv78gUQTAZIxKFFB/1Vfy20ChbaJZ7HQSZH
 5pGcN1rzl+alXmvT//thFoDmeE9vf1CYW2McownKhQtNx2KpsR7EyfK3CAcOfUDIkdSeA==
X-Received: by 2002:a17:907:9811:b0:c25:10a:4020 with SMTP id
 a640c23a62f3a-c255716497dmr1873922866b.16.1788268675406; 
 Tue, 01 Sep 2026 06:17:55 -0700 (PDT)
Received: from lanath.. (wildly.archaic.org.uk. [81.2.115.145])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-c255ee2853dsm617907466b.18.2026.09.01.06.17.54
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 01 Sep 2026 06:17:54 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 21/58] hw/arm/mps2-tz.c add Arm mps3-an555 board
Date: Tue,  1 Sep 2026 14:16:55 +0100
Message-ID: <20260901131732.2263947-22-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260901131732.2263947-1-peter.maydell@linaro.org>
References: <20260901131732.2263947-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::634;
 envelope-from=peter.maydell@linaro.org; helo=mail-ej1-x634.google.com
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

From: Simon Xu <simonxhy0404@gmail.com>

Add mps3-an555 board modeled after the existing mps3-an547 board.
Add UnimplementedDeivceState for timing adapters and qspi controllers
in MPS2TZMachineState.

Changes in AN555:
Timing adapters in APB PPC EX0 instead of MPC.
Additional QSPI controllers in AHB PPC EX0.
Additional AHB PPC EX1 with DMA.
Create standalone unimplemented devices for MPC instead of timing adapters.
Set fpgaio_has_gpioalt2 to true.

Include documentation for SSE-310 and mps3-an555.

Arm mps3-an555 TRM: https://developer.arm.com/documentation/107642/latest/

As our M85 model doesn't yet have PACBTI, note this omission
in the documentation of where we deviate from the real AN555.

Reviewed-by: Owen Giles <owen.giles@hpe.com>
Reviewed-by: Robert Elliott <elliott@hpe.com>
Signed-off-by: Simon Xu <simonxhy0404@gmail.com>
Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
Message-Id: <20260805153005.9989-9-simonxhy0404@gmail.com>
[PMM: added doc note about PACBTI]
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 docs/system/arm/mps2.rst |   7 +-
 hw/arm/mps2-tz.c         | 156 ++++++++++++++++++++++++++++++++++++++-
 2 files changed, 157 insertions(+), 6 deletions(-)

diff --git a/docs/system/arm/mps2.rst b/docs/system/arm/mps2.rst
index a305935cc49..24f6fe4fdbf 100644
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
 
@@ -66,6 +68,7 @@ Differences between QEMU and real hardware:
   held in halt via the initial SCC CFG_REG0 register setting. You can
   create the second CPU with ``-smp 2``; both CPUs will then start
   execution immediately on startup.
+- AN555 provides a Cortex-M85 without the PACBTI extension
 
 Note that for the AN536 the first UART is accessible only by
 CPU0, and the second UART is accessible only by CPU1. The
diff --git a/hw/arm/mps2-tz.c b/hw/arm/mps2-tz.c
index 79f53a0d09e..41dfb185353 100644
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
@@ -154,6 +163,8 @@ struct MPS2TZMachineState {
     UnimplementedDeviceState gfx;
     UnimplementedDeviceState cldc;
     UnimplementedDeviceState usb;
+    UnimplementedDeviceState ta[3]; /* timing adatper */
+    UnimplementedDeviceState qspi_controller[3];
     PL031State rtc;
     PL080State dma[4];
     TZMSC msc[4];
@@ -174,6 +185,7 @@ struct MPS2TZMachineState {
 #define TYPE_MPS2TZ_AN521_MACHINE MACHINE_TYPE_NAME("mps2-an521")
 #define TYPE_MPS3TZ_AN524_MACHINE MACHINE_TYPE_NAME("mps3-an524")
 #define TYPE_MPS3TZ_AN547_MACHINE MACHINE_TYPE_NAME("mps3-an547")
+#define TYPE_MPS3TZ_AN555_MACHINE MACHINE_TYPE_NAME("mps3-an555")
 
 OBJECT_DECLARE_TYPE(MPS2TZMachineState, MPS2TZMachineClass, MPS2TZ_MACHINE)
 
@@ -208,6 +220,15 @@ static const uint32_t an524_oscclk[] = {
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
@@ -1030,7 +1051,6 @@ static void mps2tz_common_init(MachineState *machine)
                 { "uart3", make_uart, &mms->uart[3], 0x41306000, 0x1000, { 38, 39, 45 } },
                 { "uart4", make_uart, &mms->uart[4], 0x41307000, 0x1000, { 40, 41, 46 } },
                 { "uart5", make_uart, &mms->uart[5], 0x41308000, 0x1000, { 124, 125, 126 } },
-
                 { /* port 9 reserved */ },
                 { "clcd", make_unimp_dev, &mms->cldc, 0x4130a000, 0x1000 },
                 { "rtc", make_rtc, &mms->rtc, 0x4130b000, 0x1000 },
@@ -1097,7 +1117,6 @@ static void mps2tz_common_init(MachineState *machine)
                 { "uart3", make_uart, &mms->uart[3], 0x49306000, 0x1000, { 39, 40, 46 } },
                 { "uart4", make_uart, &mms->uart[4], 0x49307000, 0x1000, { 41, 42, 47 } },
                 { "uart5", make_uart, &mms->uart[5], 0x49308000, 0x1000, { 125, 126, 127 } },
-
                 { /* port 9 reserved */ },
                 { "clcd", make_unimp_dev, &mms->cldc, 0x4930a000, 0x1000 },
                 { "rtc", make_rtc, &mms->rtc, 0x4930b000, 0x1000 },
@@ -1126,6 +1145,81 @@ static void mps2tz_common_init(MachineState *machine)
         },
     };
 
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
+            },
+        },
+    };
+
     switch (mmc->fpga_type) {
     case FPGA_AN505:
     case FPGA_AN521:
@@ -1140,6 +1234,10 @@ static void mps2tz_common_init(MachineState *machine)
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
@@ -1223,6 +1321,12 @@ static void mps2tz_common_init(MachineState *machine)
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
@@ -1474,6 +1578,42 @@ static void mps3tz_an547_class_init(ObjectClass *oc, const void *data)
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
+    mmc->fpgaio_has_gpioalt2 = true;
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
@@ -1515,6 +1655,13 @@ static const TypeInfo mps3tz_an547_info = {
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
@@ -1522,6 +1669,7 @@ static void mps2tz_machine_init(void)
     type_register_static(&mps2tz_an521_info);
     type_register_static(&mps3tz_an524_info);
     type_register_static(&mps3tz_an547_info);
+    type_register_static(&mps3tz_an555_info);
 }
 
 type_init(mps2tz_machine_init);
-- 
2.43.0


