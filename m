Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A3B89CA0FFD
	for <qemu-devel@archiver.kernel.org>; Mon,  1 Sep 2025 04:23:38 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1usw3n-0006gk-TK; Mon, 01 Sep 2025 00:22:28 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jamin_lin@aspeedtech.com>)
 id 1usvqE-0002mJ-7V; Mon, 01 Sep 2025 00:08:26 -0400
Received: from mail.aspeedtech.com ([211.20.114.72] helo=TWMBX01.aspeed.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jamin_lin@aspeedtech.com>)
 id 1usvqC-000862-Hv; Mon, 01 Sep 2025 00:08:25 -0400
Received: from TWMBX01.aspeed.com (192.168.0.62) by TWMBX01.aspeed.com
 (192.168.0.62) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1748.10; Mon, 1 Sep
 2025 12:08:09 +0800
Received: from mail.aspeedtech.com (192.168.10.10) by TWMBX01.aspeed.com
 (192.168.0.62) with Microsoft SMTP Server id 15.2.1748.10 via Frontend
 Transport; Mon, 1 Sep 2025 12:08:09 +0800
To: "reviewer:Incompatible changes" <devel@lists.libvirt.org>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>, Peter Maydell
 <peter.maydell@linaro.org>, Steven Lee <steven_lee@aspeedtech.com>, Troy Lee
 <leetroy@gmail.com>, Andrew Jeffery <andrew@codeconstruct.com.au>, "Joel
 Stanley" <joel@jms.id.au>, "open list:All patches CC here"
 <qemu-devel@nongnu.org>, "open list:ASPEED BMCs" <qemu-arm@nongnu.org>
CC: <jamin_lin@aspeedtech.com>, <troy_lee@aspeedtech.com>,
 <kane_chen@aspeedtech.com>
Subject: [PATCH v1 2/4] hw/arm/aspeed_ast27x0: Remove ast2700-a0 SOC
Date: Mon, 1 Sep 2025 12:08:05 +0800
Message-ID: <20250901040808.1454742-3-jamin_lin@aspeedtech.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250901040808.1454742-1-jamin_lin@aspeedtech.com>
References: <20250901040808.1454742-1-jamin_lin@aspeedtech.com>
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

The ast2700-a1 SOC represented the first revision of the AST2700 and
was intended as an early engineering sample rather than a production
platform. A newer revision, A1, is now supported, and the ast2700-a1
SOC should replace the older A0 version.

Signed-off-by: Jamin Lin <jamin_lin@aspeedtech.com>
---
 hw/arm/aspeed_ast27x0.c | 81 -----------------------------------------
 1 file changed, 81 deletions(-)

diff --git a/hw/arm/aspeed_ast27x0.c b/hw/arm/aspeed_ast27x0.c
index 6aa3841b69..2e47e2f860 100644
--- a/hw/arm/aspeed_ast27x0.c
+++ b/hw/arm/aspeed_ast27x0.c
@@ -89,54 +89,6 @@ static const hwaddr aspeed_soc_ast2700_memmap[] = {
 #define AST2700_MAX_IRQ 256
 
 /* Shared Peripheral Interrupt values below are offset by -32 from datasheet */
-static const int aspeed_soc_ast2700a0_irqmap[] = {
-    [ASPEED_DEV_SDMC]      = 0,
-    [ASPEED_DEV_HACE]      = 4,
-    [ASPEED_DEV_XDMA]      = 5,
-    [ASPEED_DEV_UART4]     = 8,
-    [ASPEED_DEV_SCU]       = 12,
-    [ASPEED_DEV_RTC]       = 13,
-    [ASPEED_DEV_EMMC]      = 15,
-    [ASPEED_DEV_TIMER1]    = 16,
-    [ASPEED_DEV_TIMER2]    = 17,
-    [ASPEED_DEV_TIMER3]    = 18,
-    [ASPEED_DEV_TIMER4]    = 19,
-    [ASPEED_DEV_TIMER5]    = 20,
-    [ASPEED_DEV_TIMER6]    = 21,
-    [ASPEED_DEV_TIMER7]    = 22,
-    [ASPEED_DEV_TIMER8]    = 23,
-    [ASPEED_DEV_DP]        = 28,
-    [ASPEED_DEV_EHCI1]     = 33,
-    [ASPEED_DEV_EHCI2]     = 37,
-    [ASPEED_DEV_LPC]       = 128,
-    [ASPEED_DEV_IBT]       = 128,
-    [ASPEED_DEV_KCS]       = 128,
-    [ASPEED_DEV_ADC]       = 130,
-    [ASPEED_DEV_GPIO]      = 130,
-    [ASPEED_DEV_I2C]       = 130,
-    [ASPEED_DEV_FMC]       = 131,
-    [ASPEED_DEV_WDT]       = 131,
-    [ASPEED_DEV_PWM]       = 131,
-    [ASPEED_DEV_I3C]       = 131,
-    [ASPEED_DEV_UART0]     = 132,
-    [ASPEED_DEV_UART1]     = 132,
-    [ASPEED_DEV_UART2]     = 132,
-    [ASPEED_DEV_UART3]     = 132,
-    [ASPEED_DEV_UART5]     = 132,
-    [ASPEED_DEV_UART6]     = 132,
-    [ASPEED_DEV_UART7]     = 132,
-    [ASPEED_DEV_UART8]     = 132,
-    [ASPEED_DEV_UART9]     = 132,
-    [ASPEED_DEV_UART10]    = 132,
-    [ASPEED_DEV_UART11]    = 132,
-    [ASPEED_DEV_UART12]    = 132,
-    [ASPEED_DEV_ETH1]      = 132,
-    [ASPEED_DEV_ETH2]      = 132,
-    [ASPEED_DEV_ETH3]      = 132,
-    [ASPEED_DEV_PECI]      = 133,
-    [ASPEED_DEV_SDHCI]     = 133,
-};
-
 static const int aspeed_soc_ast2700a1_irqmap[] = {
     [ASPEED_DEV_SDMC]      = 0,
     [ASPEED_DEV_HACE]      = 4,
@@ -958,34 +910,6 @@ static void aspeed_soc_ast2700_realize(DeviceState *dev, Error **errp)
                                   AST2700_SOC_IOMEM_SIZE);
 }
 
-static void aspeed_soc_ast2700a0_class_init(ObjectClass *oc, const void *data)
-{
-    static const char * const valid_cpu_types[] = {
-        ARM_CPU_TYPE_NAME("cortex-a35"),
-        NULL
-    };
-    DeviceClass *dc = DEVICE_CLASS(oc);
-    AspeedSoCClass *sc = ASPEED_SOC_CLASS(oc);
-
-    /* Reason: The Aspeed SoC can only be instantiated from a board */
-    dc->user_creatable = false;
-    dc->realize      = aspeed_soc_ast2700_realize;
-
-    sc->valid_cpu_types = valid_cpu_types;
-    sc->silicon_rev  = AST2700_A0_SILICON_REV;
-    sc->sram_size    = 0x20000;
-    sc->spis_num     = 3;
-    sc->ehcis_num    = 2;
-    sc->wdts_num     = 8;
-    sc->macs_num     = 1;
-    sc->uarts_num    = 13;
-    sc->num_cpus     = 4;
-    sc->uarts_base   = ASPEED_DEV_UART0;
-    sc->irqmap       = aspeed_soc_ast2700a0_irqmap;
-    sc->memmap       = aspeed_soc_ast2700_memmap;
-    sc->get_irq      = aspeed_soc_ast2700_get_irq;
-}
-
 static void aspeed_soc_ast2700a1_class_init(ObjectClass *oc, const void *data)
 {
     static const char * const valid_cpu_types[] = {
@@ -1020,11 +944,6 @@ static const TypeInfo aspeed_soc_ast27x0_types[] = {
         .parent         = TYPE_ASPEED_SOC,
         .instance_size  = sizeof(Aspeed27x0SoCState),
         .abstract       = true,
-    }, {
-        .name           = "ast2700-a0",
-        .parent         = TYPE_ASPEED27X0_SOC,
-        .instance_init  = aspeed_soc_ast2700_init,
-        .class_init     = aspeed_soc_ast2700a0_class_init,
     },
     {
         .name           = "ast2700-a1",
-- 
2.43.0


