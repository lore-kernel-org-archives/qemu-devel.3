Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3EB9AC2A074
	for <qemu-devel@archiver.kernel.org>; Mon,  5 Jan 2026 03:20:35 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vcb81-0001UY-4Y; Sun, 04 Jan 2026 22:19:33 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jamin_lin@aspeedtech.com>)
 id 1vcb7y-0001TE-Ld; Sun, 04 Jan 2026 22:19:30 -0500
Received: from mail.aspeedtech.com ([211.20.114.72] helo=TWMBX01.aspeed.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jamin_lin@aspeedtech.com>)
 id 1vcb7x-0005mh-9p; Sun, 04 Jan 2026 22:19:30 -0500
Received: from TWMBX01.aspeed.com (192.168.0.62) by TWMBX01.aspeed.com
 (192.168.0.62) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1748.10; Mon, 5 Jan
 2026 11:19:17 +0800
Received: from mail.aspeedtech.com (192.168.10.10) by TWMBX01.aspeed.com
 (192.168.0.62) with Microsoft SMTP Server id 15.2.1748.10 via Frontend
 Transport; Mon, 5 Jan 2026 11:19:17 +0800
To: =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>, Peter Maydell
 <peter.maydell@linaro.org>, Steven Lee <steven_lee@aspeedtech.com>, Troy Lee
 <leetroy@gmail.com>, Andrew Jeffery <andrew@codeconstruct.com.au>, "Joel
 Stanley" <joel@jms.id.au>, "open list:ASPEED BMCs" <qemu-arm@nongnu.org>,
 "open list:All patches CC here" <qemu-devel@nongnu.org>
CC: <jamin_lin@aspeedtech.com>, <troy_lee@aspeedtech.com>,
 <kane_chen@aspeedtech.com>
Subject: [PATCH v1 1/1] hw/intc/aspeed: Remove GIC 128 - 136
Date: Mon, 5 Jan 2026 11:19:14 +0800
Message-ID: <20260105031916.1767210-2-jamin_lin@aspeedtech.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260105031916.1767210-1-jamin_lin@aspeedtech.com>
References: <20260105031916.1767210-1-jamin_lin@aspeedtech.com>
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

The GIC interrupts 128 - 136 were only used by the AST2700 A0 SoC.
Since the AST2700 A0 has been deprecated, these interrupt
definitions are no longer needed. This commit removes them to
clean up the codebase.

Signed-off-by: Jamin Lin <jamin_lin@aspeedtech.com>
---
 hw/arm/aspeed_ast27x0.c | 17 -----------------
 hw/intc/aspeed_intc.c   |  2 +-
 2 files changed, 1 insertion(+), 18 deletions(-)

diff --git a/hw/arm/aspeed_ast27x0.c b/hw/arm/aspeed_ast27x0.c
index 52e509afd5..d17f446661 100644
--- a/hw/arm/aspeed_ast27x0.c
+++ b/hw/arm/aspeed_ast27x0.c
@@ -207,7 +207,6 @@ static const int ast2700_gic197_intcmap[] = {
     [ASPEED_DEV_PECI]      = 4,
 };
 
-/* GICINT 128 ~ 136 */
 /* GICINT 192 ~ 201 */
 struct gic_intc_irq_info {
     int irq;
@@ -227,15 +226,6 @@ static const struct gic_intc_irq_info ast2700_gic_intcmap[] = {
     {199, 1, 7, NULL},
     {200, 1, 8, NULL},
     {201, 1, 9, NULL},
-    {128, 0, 1, ast2700_gic192_intcmap},
-    {129, 0, 2, NULL},
-    {130, 0, 3, ast2700_gic194_intcmap},
-    {131, 0, 4, ast2700_gic195_intcmap},
-    {132, 0, 5, ast2700_gic196_intcmap},
-    {133, 0, 6, ast2700_gic197_intcmap},
-    {134, 0, 7, NULL},
-    {135, 0, 8, NULL},
-    {136, 0, 9, NULL},
 };
 
 static qemu_irq aspeed_soc_ast2700_get_irq(AspeedSoCState *s, int dev)
@@ -893,13 +883,6 @@ static void aspeed_soc_ast2700_realize(DeviceState *dev, Error **errp)
         /*
          * The AST2700 I2C controller has one source INTC per bus.
          *
-         * For AST2700 A0:
-         * I2C bus interrupts are connected to the OR gate from bit 0 to bit
-         * 15, and the OR gate output pin is connected to the input pin of
-         * GICINT130 of INTC (CPU Die). Then, the output pin is connected to
-         * the GIC.
-         *
-         * For AST2700 A1:
          * I2C bus interrupts are connected to the OR gate from bit 0 to bit
          * 15, and the OR gate output pin is connected to the input pin of
          * GICINT194 of INTCIO (IO Die). Then, the output pin is connected
diff --git a/hw/intc/aspeed_intc.c b/hw/intc/aspeed_intc.c
index 1702cb87dc..77fae39205 100644
--- a/hw/intc/aspeed_intc.c
+++ b/hw/intc/aspeed_intc.c
@@ -778,7 +778,7 @@ static void aspeed_2700_intc_class_init(ObjectClass *klass, const void *data)
 
     dc->desc = "ASPEED 2700 INTC Controller";
     aic->num_lines = 32;
-    aic->num_inpins = 10;
+    aic->num_inpins = 1;
     aic->num_outpins = 10;
     aic->mem_size = 0x4000;
     aic->nr_regs = 0xB08 >> 2;
-- 
2.43.0


