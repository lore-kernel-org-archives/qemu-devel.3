Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5AF3ACCF9F8
	for <qemu-devel@archiver.kernel.org>; Wed,  5 Nov 2025 04:01:35 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vGUh2-0008UR-05; Tue, 04 Nov 2025 23:00:20 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kane_chen@aspeedtech.com>)
 id 1vGUgz-0008Tb-Ls; Tue, 04 Nov 2025 23:00:17 -0500
Received: from mail.aspeedtech.com ([211.20.114.72] helo=TWMBX01.aspeed.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kane_chen@aspeedtech.com>)
 id 1vGUgy-0000YI-6V; Tue, 04 Nov 2025 23:00:17 -0500
Received: from TWMBX01.aspeed.com (192.168.0.62) by TWMBX01.aspeed.com
 (192.168.0.62) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1748.10; Wed, 5 Nov
 2025 11:59:05 +0800
Received: from mail.aspeedtech.com (192.168.10.10) by TWMBX01.aspeed.com
 (192.168.0.62) with Microsoft SMTP Server id 15.2.1748.10 via Frontend
 Transport; Wed, 5 Nov 2025 11:59:05 +0800
To: =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>, Peter Maydell
 <peter.maydell@linaro.org>, Steven Lee <steven_lee@aspeedtech.com>, Troy Lee
 <leetroy@gmail.com>, Jamin Lin <jamin_lin@aspeedtech.com>, Andrew Jeffery
 <andrew@codeconstruct.com.au>, Joel Stanley <joel@jms.id.au>, "open
 list:ASPEED BMCs" <qemu-arm@nongnu.org>, "open list:All patches CC here"
 <qemu-devel@nongnu.org>
CC: <troy_lee@aspeedtech.com>, Kane-Chen-AS <kane_chen@aspeedtech.com>
Subject: [PATCH v2 17/17] hw/arm/aspeed: Model AST1700 PWM block as
 unimplemented device
Date: Wed, 5 Nov 2025 11:58:55 +0800
Message-ID: <20251105035859.3709907-18-kane_chen@aspeedtech.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20251105035859.3709907-1-kane_chen@aspeedtech.com>
References: <20251105035859.3709907-1-kane_chen@aspeedtech.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Received-SPF: pass client-ip=211.20.114.72;
 envelope-from=kane_chen@aspeedtech.com; helo=TWMBX01.aspeed.com
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
Reply-to:  Kane Chen <kane_chen@aspeedtech.com>
From:  Kane Chen via <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

From: Kane-Chen-AS <kane_chen@aspeedtech.com>

AST1700 includes an PWM block, but QEMU has no functional model for
aspeed product yet. Expose it as an unimplemented device so the
address space is reserved and the missing functionality is explicit
to users/guests.

Signed-off-by: Kane-Chen-AS <kane_chen@aspeedtech.com>
---
 include/hw/misc/aspeed_ast1700.h |  1 +
 hw/misc/aspeed_ast1700.c         | 16 ++++++++++++++++
 2 files changed, 17 insertions(+)

diff --git a/include/hw/misc/aspeed_ast1700.h b/include/hw/misc/aspeed_ast1700.h
index 8ada3a7775..9d432a7db0 100644
--- a/include/hw/misc/aspeed_ast1700.h
+++ b/include/hw/misc/aspeed_ast1700.h
@@ -45,6 +45,7 @@ struct AspeedAST1700SoCState {
 
     UnimplementedDeviceState i3c;
     UnimplementedDeviceState sgpiom;
+    UnimplementedDeviceState pwm;
 };
 
 #endif /* ASPEED_AST1700_H */
diff --git a/hw/misc/aspeed_ast1700.c b/hw/misc/aspeed_ast1700.c
index 66a5f21d27..3d9a920a7a 100644
--- a/hw/misc/aspeed_ast1700.c
+++ b/hw/misc/aspeed_ast1700.c
@@ -20,9 +20,11 @@
 #define AST1700_SOC_SRAM_SIZE        0x00040000
 #define AST1700_SOC_I3C_SIZE         0x00010000
 #define AST1700_SOC_SGPIOM_SIZE      0x00002000
+#define AST1700_SOC_PWM_SIZE         0x00000200
 
 enum {
     ASPEED_AST1700_DEV_SPI0,
+    ASPEED_AST1700_DEV_PWM,
     ASPEED_AST1700_DEV_SRAM,
     ASPEED_AST1700_DEV_ADC,
     ASPEED_AST1700_DEV_SCU,
@@ -38,6 +40,7 @@ enum {
 
 static const hwaddr aspeed_ast1700_io_memmap[] = {
     [ASPEED_AST1700_DEV_SPI0]      =  0x00030000,
+    [ASPEED_AST1700_DEV_PWM]       =  0x000C0000,
     [ASPEED_AST1700_DEV_SRAM]      =  0x00BC0000,
     [ASPEED_AST1700_DEV_ADC]       =  0x00C00000,
     [ASPEED_AST1700_DEV_SCU]       =  0x00C02000,
@@ -174,6 +177,15 @@ static void aspeed_ast1700_realize(DeviceState *dev, Error **errp)
                         sysbus_mmio_get_region(SYS_BUS_DEVICE(&s->sgpiom), 0),
                         -1000);
 
+    /* PWM */
+    qdev_prop_set_string(DEVICE(&s->pwm), "name", "ioexp-pwm");
+    qdev_prop_set_uint64(DEVICE(&s->pwm), "size", AST1700_SOC_PWM_SIZE);
+    sysbus_realize(SYS_BUS_DEVICE(&s->pwm), errp);
+    memory_region_add_subregion_overlap(&s->iomem,
+                        aspeed_ast1700_io_memmap[ASPEED_AST1700_DEV_PWM],
+                        sysbus_mmio_get_region(SYS_BUS_DEVICE(&s->pwm), 0),
+                        -1000);
+
     /* WDT */
     for (i = 0; i < AST1700_WDT_NUM; i++) {
         AspeedWDTClass *awc = ASPEED_WDT_GET_CLASS(&s->wdt[i]);
@@ -241,6 +253,10 @@ static void aspeed_ast1700_instance_init(Object *obj)
     object_initialize_child(obj, "ioexp-sgpiom[*]", &s->sgpiom,
                             TYPE_UNIMPLEMENTED_DEVICE);
 
+    /* PWM */
+    object_initialize_child(obj, "ioexp-pwm", &s->pwm,
+                            TYPE_UNIMPLEMENTED_DEVICE);
+
     /* WDT */
     for (i = 0; i < AST1700_WDT_NUM; i++) {
         snprintf(typename, sizeof(typename), "aspeed.wdt-%s", socname);
-- 
2.43.0


