Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0D623FA3728
	for <qemu-devel@archiver.kernel.org>; Fri,  2 Jan 2026 09:09:08 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vbb8i-0006wR-KA; Fri, 02 Jan 2026 04:08:08 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jamin_lin@aspeedtech.com>)
 id 1vbb8f-0006rL-1U; Fri, 02 Jan 2026 04:08:05 -0500
Received: from mail.aspeedtech.com ([211.20.114.72] helo=TWMBX01.aspeed.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jamin_lin@aspeedtech.com>)
 id 1vbb8c-0003of-Rz; Fri, 02 Jan 2026 04:08:04 -0500
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
Subject: [PATCH v1 2/3] hw/intc/aspeed: Remove TSP 128 - 138
Date: Fri, 2 Jan 2026 17:07:44 +0800
Message-ID: <20260102090746.1130033-3-jamin_lin@aspeedtech.com>
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
 hw/arm/aspeed_ast27x0-tsp.c | 13 ++-------
 hw/intc/aspeed_intc.c       | 55 ++-----------------------------------
 2 files changed, 4 insertions(+), 64 deletions(-)

diff --git a/hw/arm/aspeed_ast27x0-tsp.c b/hw/arm/aspeed_ast27x0-tsp.c
index f40c70fea5..9c11c016ca 100644
--- a/hw/arm/aspeed_ast27x0-tsp.c
+++ b/hw/arm/aspeed_ast27x0-tsp.c
@@ -62,7 +62,7 @@ static const int aspeed_soc_ast27x0tsp_irqmap[] = {
 };
 
 /* TSPINT 164 */
-static const int ast2700_tsp132_tsp164_intcmap[] = {
+static const int ast2700_tsp164_intcmap[] = {
     [ASPEED_DEV_UART0]     = 7,
     [ASPEED_DEV_UART1]     = 8,
     [ASPEED_DEV_UART2]     = 9,
@@ -89,21 +89,12 @@ static struct nvic_intc_irq_info ast2700_tsp_intcmap[] = {
     {161, 1, 1, NULL},
     {162, 1, 2, NULL},
     {163, 1, 3, NULL},
-    {164, 1, 4, ast2700_tsp132_tsp164_intcmap},
+    {164, 1, 4, ast2700_tsp164_intcmap},
     {165, 1, 5, NULL},
     {166, 1, 6, NULL},
     {167, 1, 7, NULL},
     {168, 1, 8, NULL},
     {169, 1, 9, NULL},
-    {128, 0, 1, NULL},
-    {129, 0, 2, NULL},
-    {130, 0, 3, NULL},
-    {131, 0, 4, NULL},
-    {132, 0, 5, ast2700_tsp132_tsp164_intcmap},
-    {133, 0, 6, NULL},
-    {134, 0, 7, NULL},
-    {135, 0, 8, NULL},
-    {136, 0, 9, NULL},
 };
 
 static qemu_irq aspeed_soc_ast27x0tsp_get_irq(AspeedCoprocessorState *s,
diff --git a/hw/intc/aspeed_intc.c b/hw/intc/aspeed_intc.c
index 305458d6d4..1702cb87dc 100644
--- a/hw/intc/aspeed_intc.c
+++ b/hw/intc/aspeed_intc.c
@@ -69,28 +69,6 @@ REG32(SSPINT165_STATUS,     0x1D4)
 /*
  * TSP INTC Registers
  */
-REG32(TSPINT128_EN,             0x3000)
-REG32(TSPINT128_STATUS,         0x3004)
-REG32(TSPINT129_EN,             0x3100)
-REG32(TSPINT129_STATUS,         0x3104)
-REG32(TSPINT130_EN,             0x3200)
-REG32(TSPINT130_STATUS,         0x3204)
-REG32(TSPINT131_EN,             0x3300)
-REG32(TSPINT131_STATUS,         0x3304)
-REG32(TSPINT132_EN,             0x3400)
-REG32(TSPINT132_STATUS,         0x3404)
-REG32(TSPINT133_EN,             0x3500)
-REG32(TSPINT133_STATUS,         0x3504)
-REG32(TSPINT134_EN,             0x3600)
-REG32(TSPINT134_STATUS,         0x3604)
-REG32(TSPINT135_EN,             0x3700)
-REG32(TSPINT135_STATUS,         0x3704)
-REG32(TSPINT136_EN,             0x3800)
-REG32(TSPINT136_STATUS,         0x3804)
-REG32(TSPINT137_EN,             0x3900)
-REG32(TSPINT137_STATUS,         0x3904)
-REG32(TSPINT138_EN,             0x3A00)
-REG32(TSPINT138_STATUS,         0x3A04)
 REG32(TSPINT160_169_EN,         0x3B00)
 REG32(TSPINT160_169_STATUS,     0x3B04)
 
@@ -511,29 +489,9 @@ static void aspeed_tsp_intc_write(void *opaque, hwaddr offset, uint64_t data,
     trace_aspeed_intc_write(name, offset, size, data);
 
     switch (reg) {
-    case R_TSPINT128_EN:
-    case R_TSPINT129_EN:
-    case R_TSPINT130_EN:
-    case R_TSPINT131_EN:
-    case R_TSPINT132_EN:
-    case R_TSPINT133_EN:
-    case R_TSPINT134_EN:
-    case R_TSPINT135_EN:
-    case R_TSPINT136_EN:
     case R_TSPINT160_169_EN:
         aspeed_intc_enable_handler(s, offset, data);
         break;
-    case R_TSPINT128_STATUS:
-    case R_TSPINT129_STATUS:
-    case R_TSPINT130_STATUS:
-    case R_TSPINT131_STATUS:
-    case R_TSPINT132_STATUS:
-    case R_TSPINT133_STATUS:
-    case R_TSPINT134_STATUS:
-    case R_TSPINT135_STATUS:
-    case R_TSPINT136_STATUS:
-        aspeed_intc_status_handler(s, offset, data);
-        break;
     case R_TSPINT160_169_STATUS:
         aspeed_intc_status_handler_multi_outpins(s, offset, data);
         break;
@@ -929,15 +887,6 @@ static const TypeInfo aspeed_2700ssp_intcio_info = {
 
 static AspeedINTCIRQ aspeed_2700tsp_intc_irqs[ASPEED_INTC_MAX_INPINS] = {
     {0, 0, 10, R_TSPINT160_169_EN, R_TSPINT160_169_STATUS},
-    {1, 10, 1, R_TSPINT128_EN, R_TSPINT128_STATUS},
-    {2, 11, 1, R_TSPINT129_EN, R_TSPINT129_STATUS},
-    {3, 12, 1, R_TSPINT130_EN, R_TSPINT130_STATUS},
-    {4, 13, 1, R_TSPINT131_EN, R_TSPINT131_STATUS},
-    {5, 14, 1, R_TSPINT132_EN, R_TSPINT132_STATUS},
-    {6, 15, 1, R_TSPINT133_EN, R_TSPINT133_STATUS},
-    {7, 16, 1, R_TSPINT134_EN, R_TSPINT134_STATUS},
-    {8, 17, 1, R_TSPINT135_EN, R_TSPINT135_STATUS},
-    {9, 18, 1, R_TSPINT136_EN, R_TSPINT136_STATUS},
 };
 
 static void aspeed_2700tsp_intc_class_init(ObjectClass *klass, const void *data)
@@ -947,8 +896,8 @@ static void aspeed_2700tsp_intc_class_init(ObjectClass *klass, const void *data)
 
     dc->desc = "ASPEED 2700 TSP INTC Controller";
     aic->num_lines = 32;
-    aic->num_inpins = 10;
-    aic->num_outpins = 19;
+    aic->num_inpins = 1;
+    aic->num_outpins = 10;
     aic->mem_size = 0x4000;
     aic->nr_regs = 0x3B08 >> 2;
     aic->reg_offset = 0;
-- 
2.43.0


