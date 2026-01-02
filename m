Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EC7D5FA3727
	for <qemu-devel@archiver.kernel.org>; Fri,  2 Jan 2026 09:09:07 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vbb8f-0006rN-Ae; Fri, 02 Jan 2026 04:08:05 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jamin_lin@aspeedtech.com>)
 id 1vbb8b-0006od-E9; Fri, 02 Jan 2026 04:08:02 -0500
Received: from mail.aspeedtech.com ([211.20.114.72] helo=TWMBX01.aspeed.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jamin_lin@aspeedtech.com>)
 id 1vbb8Y-0003of-Kn; Fri, 02 Jan 2026 04:08:00 -0500
Received: from TWMBX01.aspeed.com (192.168.0.62) by TWMBX01.aspeed.com
 (192.168.0.62) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1748.10; Fri, 2 Jan
 2026 17:07:46 +0800
Received: from mail.aspeedtech.com (192.168.10.10) by TWMBX01.aspeed.com
 (192.168.0.62) with Microsoft SMTP Server id 15.2.1748.10 via Frontend
 Transport; Fri, 2 Jan 2026 17:07:46 +0800
To: =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>, Peter Maydell
 <peter.maydell@linaro.org>, Steven Lee <steven_lee@aspeedtech.com>, Troy Lee
 <leetroy@gmail.com>, Andrew Jeffery <andrew@codeconstruct.com.au>, "Joel
 Stanley" <joel@jms.id.au>, "open list:ASPEED BMCs" <qemu-arm@nongnu.org>,
 "open list:All patches CC here" <qemu-devel@nongnu.org>
CC: <jamin_lin@aspeedtech.com>, <troy_lee@aspeedtech.com>,
 <kane_chen@aspeedtech.com>
Subject: [PATCH v1 1/3] hw/intc/aspeed: Remove SSP 128 - 138
Date: Fri, 2 Jan 2026 17:07:43 +0800
Message-ID: <20260102090746.1130033-2-jamin_lin@aspeedtech.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260102090746.1130033-1-jamin_lin@aspeedtech.com>
References: <20260102090746.1130033-1-jamin_lin@aspeedtech.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Received-SPF: pass client-ip=211.20.114.72;
 envelope-from=jamin_lin@aspeedtech.com; helo=TWMBX01.aspeed.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_FAIL=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
Reply-to:  Jamin Lin <jamin_lin@aspeedtech.com>
From:  Jamin Lin via <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

The SSP interrupts 128 - 138 were only used by the AST2700 A0 SoC.
Since the AST2700 A0 has been deprecated, these interrupt
definitions are no longer needed. This commit removes them to
clean up the codebase.

Signed-off-by: Jamin Lin <jamin_lin@aspeedtech.com>
---
 hw/arm/aspeed_ast27x0-ssp.c | 13 ++-------
 hw/intc/aspeed_intc.c       | 55 ++-----------------------------------
 2 files changed, 4 insertions(+), 64 deletions(-)

diff --git a/hw/arm/aspeed_ast27x0-ssp.c b/hw/arm/aspeed_ast27x0-ssp.c
index 04d3705659..cee937b37e 100644
--- a/hw/arm/aspeed_ast27x0-ssp.c
+++ b/hw/arm/aspeed_ast27x0-ssp.c
@@ -62,7 +62,7 @@ static const int aspeed_soc_ast27x0ssp_irqmap[] = {
 };
 
 /* SSPINT 164 */
-static const int ast2700_ssp132_ssp164_intcmap[] = {
+static const int ast2700_ssp164_intcmap[] = {
     [ASPEED_DEV_UART0]     = 7,
     [ASPEED_DEV_UART1]     = 8,
     [ASPEED_DEV_UART2]     = 9,
@@ -89,21 +89,12 @@ static struct nvic_intc_irq_info ast2700_ssp_intcmap[] = {
     {161, 1, 1, NULL},
     {162, 1, 2, NULL},
     {163, 1, 3, NULL},
-    {164, 1, 4, ast2700_ssp132_ssp164_intcmap},
+    {164, 1, 4, ast2700_ssp164_intcmap},
     {165, 1, 5, NULL},
     {166, 1, 6, NULL},
     {167, 1, 7, NULL},
     {168, 1, 8, NULL},
     {169, 1, 9, NULL},
-    {128, 0, 1, NULL},
-    {129, 0, 2, NULL},
-    {130, 0, 3, NULL},
-    {131, 0, 4, NULL},
-    {132, 0, 5, ast2700_ssp132_ssp164_intcmap},
-    {133, 0, 6, NULL},
-    {134, 0, 7, NULL},
-    {135, 0, 8, NULL},
-    {136, 0, 9, NULL},
 };
 
 static qemu_irq aspeed_soc_ast27x0ssp_get_irq(AspeedCoprocessorState *s,
diff --git a/hw/intc/aspeed_intc.c b/hw/intc/aspeed_intc.c
index 606bde65bb..305458d6d4 100644
--- a/hw/intc/aspeed_intc.c
+++ b/hw/intc/aspeed_intc.c
@@ -47,28 +47,6 @@ REG32(GICINT197_STATUS,     0x54)
 /*
  * SSP INTC Registers
  */
-REG32(SSPINT128_EN,             0x2000)
-REG32(SSPINT128_STATUS,         0x2004)
-REG32(SSPINT129_EN,             0x2100)
-REG32(SSPINT129_STATUS,         0x2104)
-REG32(SSPINT130_EN,             0x2200)
-REG32(SSPINT130_STATUS,         0x2204)
-REG32(SSPINT131_EN,             0x2300)
-REG32(SSPINT131_STATUS,         0x2304)
-REG32(SSPINT132_EN,             0x2400)
-REG32(SSPINT132_STATUS,         0x2404)
-REG32(SSPINT133_EN,             0x2500)
-REG32(SSPINT133_STATUS,         0x2504)
-REG32(SSPINT134_EN,             0x2600)
-REG32(SSPINT134_STATUS,         0x2604)
-REG32(SSPINT135_EN,             0x2700)
-REG32(SSPINT135_STATUS,         0x2704)
-REG32(SSPINT136_EN,             0x2800)
-REG32(SSPINT136_STATUS,         0x2804)
-REG32(SSPINT137_EN,             0x2900)
-REG32(SSPINT137_STATUS,         0x2904)
-REG32(SSPINT138_EN,             0x2A00)
-REG32(SSPINT138_STATUS,         0x2A04)
 REG32(SSPINT160_169_EN,         0x2B00)
 REG32(SSPINT160_169_STATUS,     0x2B04)
 
@@ -511,29 +489,9 @@ static void aspeed_ssp_intc_write(void *opaque, hwaddr offset, uint64_t data,
     trace_aspeed_intc_write(name, offset, size, data);
 
     switch (reg) {
-    case R_SSPINT128_EN:
-    case R_SSPINT129_EN:
-    case R_SSPINT130_EN:
-    case R_SSPINT131_EN:
-    case R_SSPINT132_EN:
-    case R_SSPINT133_EN:
-    case R_SSPINT134_EN:
-    case R_SSPINT135_EN:
-    case R_SSPINT136_EN:
     case R_SSPINT160_169_EN:
         aspeed_intc_enable_handler(s, offset, data);
         break;
-    case R_SSPINT128_STATUS:
-    case R_SSPINT129_STATUS:
-    case R_SSPINT130_STATUS:
-    case R_SSPINT131_STATUS:
-    case R_SSPINT132_STATUS:
-    case R_SSPINT133_STATUS:
-    case R_SSPINT134_STATUS:
-    case R_SSPINT135_STATUS:
-    case R_SSPINT136_STATUS:
-        aspeed_intc_status_handler(s, offset, data);
-        break;
     case R_SSPINT160_169_STATUS:
         aspeed_intc_status_handler_multi_outpins(s, offset, data);
         break;
@@ -911,15 +869,6 @@ static const TypeInfo aspeed_2700_intcio_info = {
 
 static AspeedINTCIRQ aspeed_2700ssp_intc_irqs[ASPEED_INTC_MAX_INPINS] = {
     {0, 0, 10, R_SSPINT160_169_EN, R_SSPINT160_169_STATUS},
-    {1, 10, 1, R_SSPINT128_EN, R_SSPINT128_STATUS},
-    {2, 11, 1, R_SSPINT129_EN, R_SSPINT129_STATUS},
-    {3, 12, 1, R_SSPINT130_EN, R_SSPINT130_STATUS},
-    {4, 13, 1, R_SSPINT131_EN, R_SSPINT131_STATUS},
-    {5, 14, 1, R_SSPINT132_EN, R_SSPINT132_STATUS},
-    {6, 15, 1, R_SSPINT133_EN, R_SSPINT133_STATUS},
-    {7, 16, 1, R_SSPINT134_EN, R_SSPINT134_STATUS},
-    {8, 17, 1, R_SSPINT135_EN, R_SSPINT135_STATUS},
-    {9, 18, 1, R_SSPINT136_EN, R_SSPINT136_STATUS},
 };
 
 static void aspeed_2700ssp_intc_class_init(ObjectClass *klass, const void *data)
@@ -929,8 +878,8 @@ static void aspeed_2700ssp_intc_class_init(ObjectClass *klass, const void *data)
 
     dc->desc = "ASPEED 2700 SSP INTC Controller";
     aic->num_lines = 32;
-    aic->num_inpins = 10;
-    aic->num_outpins = 19;
+    aic->num_inpins = 1;
+    aic->num_outpins = 10;
     aic->mem_size = 0x4000;
     aic->nr_regs = 0x2B08 >> 2;
     aic->reg_offset = 0x0;
-- 
2.43.0


