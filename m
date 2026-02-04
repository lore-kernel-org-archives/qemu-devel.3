Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4BAA0E95375
	for <qemu-devel@archiver.kernel.org>; Wed,  4 Feb 2026 10:35:02 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vnaCr-0003yE-4D; Wed, 04 Feb 2026 05:33:57 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1vnaCA-0002iP-MF
 for qemu-devel@nongnu.org; Wed, 04 Feb 2026 05:33:15 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1vnaC8-0004E7-FF
 for qemu-devel@nongnu.org; Wed, 04 Feb 2026 05:33:13 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1770201191;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=0eFcpqgjedIMkoHQ51JuwO3iS8I5PR9YBXqb5Ny/aGI=;
 b=cd2H5Bxz+or6pafbX+2UC91Q0Zh7MQsQRvnIOjyY8sbs5hWJYFAS/1Cqv04ZlvAmrR2KnP
 ucmSs2Gy1GPiXzbMAbyW6e84O6iPNATDbK/LxfBn0WPYXnmF3+ojXsBWYJpC/7eQeskgb8
 pMA5GgaAz2ley/WubFy0znbDFyPmAmk=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-226-a0XDDQ4NNqu5hnwAB9v-Iw-1; Wed,
 04 Feb 2026 05:33:08 -0500
X-MC-Unique: a0XDDQ4NNqu5hnwAB9v-Iw-1
X-Mimecast-MFC-AGG-ID: a0XDDQ4NNqu5hnwAB9v-Iw_1770201187
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 92CA51800473; Wed,  4 Feb 2026 10:33:07 +0000 (UTC)
Received: from corto.redhat.com (unknown [10.45.224.44])
 by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id C2D3D18003F6; Wed,  4 Feb 2026 10:33:05 +0000 (UTC)
From: =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>
To: qemu-arm@nongnu.org,
	qemu-devel@nongnu.org
Cc: Kane Chen <kane_chen@aspeedtech.com>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>,
 Nabih Estefan <nabihestefan@google.com>
Subject: [PULL 41/45] hw/arm/aspeed: Model AST1700 I3C block as unimplemented
 device
Date: Wed,  4 Feb 2026 11:31:32 +0100
Message-ID: <20260204103136.1795455-42-clg@redhat.com>
In-Reply-To: <20260204103136.1795455-1-clg@redhat.com>
References: <20260204103136.1795455-1-clg@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93
Received-SPF: pass client-ip=170.10.133.124; envelope-from=clg@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

From: Kane Chen <kane_chen@aspeedtech.com>

AST1700 exposes more I3C buses than the current dummy I3C model
provides. When Linux probes the I3C devices on AST1700 this mismatch
can trigger a kernel panic. Model the I3C block as an unimplemented
device to make the missing functionality explicit and avoid unexpected
side effects.

This wires up the I3C interrupt lines for the IO expanders and adds the
corresponding device entries for the AST1700 model.

No functional I3C emulation is provided yet; this only prevents crashes and
documents the missing piece.

Signed-off-by: Kane-Chen-AS <kane_chen@aspeedtech.com>
Reviewed-by: Cédric Le Goater <clg@redhat.com>
Reviewed-by: Nabih Estefan <nabihestefan@google.com>
Tested-by: Nabih Estefan <nabihestefan@google.com>
Link: https://lore.kernel.org/qemu-devel/20260204082113.3955407-19-kane_chen@aspeedtech.com
Signed-off-by: Cédric Le Goater <clg@redhat.com>
---
 include/hw/arm/aspeed_ast1700.h |  3 +++
 include/hw/arm/aspeed_soc.h     |  2 ++
 hw/arm/aspeed_ast1700.c         | 15 +++++++++++++++
 hw/arm/aspeed_ast27x0.c         | 18 ++++++++++++++++--
 4 files changed, 36 insertions(+), 2 deletions(-)

diff --git a/include/hw/arm/aspeed_ast1700.h b/include/hw/arm/aspeed_ast1700.h
index b5cb0a901086..f7bd4e8650ba 100644
--- a/include/hw/arm/aspeed_ast1700.h
+++ b/include/hw/arm/aspeed_ast1700.h
@@ -19,6 +19,7 @@
 #include "hw/ssi/aspeed_smc.h"
 #include "hw/watchdog/wdt_aspeed.h"
 #include "hw/char/serial-mm.h"
+#include "hw/misc/unimp.h"
 
 #define AST1700_SGPIO_NUM            2
 #define AST1700_WDT_NUM              9
@@ -46,6 +47,8 @@ struct AspeedAST1700SoCState {
     AspeedI2CState i2c;
     AspeedPWMState pwm;
     AspeedWDTState wdt[AST1700_WDT_NUM];
+
+    UnimplementedDeviceState i3c;
 };
 
 #endif /* ASPEED_AST1700_H */
diff --git a/include/hw/arm/aspeed_soc.h b/include/hw/arm/aspeed_soc.h
index 4ea252104137..b185b0418678 100644
--- a/include/hw/arm/aspeed_soc.h
+++ b/include/hw/arm/aspeed_soc.h
@@ -294,6 +294,8 @@ enum {
     ASPEED_DEV_IOEXP1_I2C,
     ASPEED_DEV_IOEXP0_INTCIO,
     ASPEED_DEV_IOEXP1_INTCIO,
+    ASPEED_DEV_IOEXP0_I3C,
+    ASPEED_DEV_IOEXP1_I3C,
 };
 
 const char *aspeed_soc_cpu_type(const char * const *valid_cpu_types);
diff --git a/hw/arm/aspeed_ast1700.c b/hw/arm/aspeed_ast1700.c
index 174186964eb6..e90302c11bcd 100644
--- a/hw/arm/aspeed_ast1700.c
+++ b/hw/arm/aspeed_ast1700.c
@@ -15,6 +15,7 @@
 
 #define AST2700_SOC_LTPI_SIZE        0x01000000
 #define AST1700_SOC_SRAM_SIZE        0x00040000
+#define AST1700_SOC_I3C_SIZE         0x00010000
 
 enum {
     ASPEED_AST1700_DEV_SPI0,
@@ -26,6 +27,7 @@ enum {
     ASPEED_AST1700_DEV_SGPIOM0,
     ASPEED_AST1700_DEV_SGPIOM1,
     ASPEED_AST1700_DEV_I2C,
+    ASPEED_AST1700_DEV_I3C,
     ASPEED_AST1700_DEV_UART12,
     ASPEED_AST1700_DEV_LTPI_CTRL,
     ASPEED_AST1700_DEV_WDT,
@@ -42,6 +44,7 @@ static const hwaddr aspeed_ast1700_io_memmap[] = {
     [ASPEED_AST1700_DEV_SGPIOM0]   =  0x00C0C000,
     [ASPEED_AST1700_DEV_SGPIOM1]   =  0x00C0D000,
     [ASPEED_AST1700_DEV_I2C]       =  0x00C0F000,
+    [ASPEED_AST1700_DEV_I3C]       =  0x00C20000,
     [ASPEED_AST1700_DEV_UART12]    =  0x00C33B00,
     [ASPEED_AST1700_DEV_LTPI_CTRL] =  0x00C34000,
     [ASPEED_AST1700_DEV_WDT]       =  0x00C37000,
@@ -178,6 +181,14 @@ static void aspeed_ast1700_realize(DeviceState *dev, Error **errp)
                         sysbus_mmio_get_region(SYS_BUS_DEVICE(&s->wdt[i]), 0));
     }
 
+    /* I3C */
+    qdev_prop_set_string(DEVICE(&s->i3c), "name", "ioexp-i3c");
+    qdev_prop_set_uint64(DEVICE(&s->i3c), "size", AST1700_SOC_I3C_SIZE);
+    sysbus_realize(SYS_BUS_DEVICE(&s->i3c), errp);
+    memory_region_add_subregion_overlap(&s->iomem,
+                        aspeed_ast1700_io_memmap[ASPEED_AST1700_DEV_I3C],
+                        sysbus_mmio_get_region(SYS_BUS_DEVICE(&s->i3c), 0),
+                        -1000);
 }
 
 static void aspeed_ast1700_instance_init(Object *obj)
@@ -227,6 +238,10 @@ static void aspeed_ast1700_instance_init(Object *obj)
                                 &s->wdt[i], "aspeed.wdt-ast2700");
     }
 
+    /* I3C */
+    object_initialize_child(obj, "ioexp-i3c", &s->i3c,
+                            TYPE_UNIMPLEMENTED_DEVICE);
+
     return;
 }
 
diff --git a/hw/arm/aspeed_ast27x0.c b/hw/arm/aspeed_ast27x0.c
index 8242258df442..d3b305fa7a1a 100644
--- a/hw/arm/aspeed_ast27x0.c
+++ b/hw/arm/aspeed_ast27x0.c
@@ -158,7 +158,9 @@ static const int aspeed_soc_ast2700a1_irqmap[] = {
     [ASPEED_DEV_PECI]      = 197,
     [ASPEED_DEV_SDHCI]     = 197,
     [ASPEED_DEV_IOEXP0_I2C] = 198,
+    [ASPEED_DEV_IOEXP0_I3C] = 199,
     [ASPEED_DEV_IOEXP1_I2C] = 200,
+    [ASPEED_DEV_IOEXP1_I3C] = 201,
 };
 
 /* GICINT 192 */
@@ -221,12 +223,24 @@ static const int ast2700_gic198_intcmap[] = {
     [ASPEED_DEV_IOEXP0_I2C]       = 0, /* 0 - 15 */
 };
 
+/* Primary AST1700 Interrupts */
+/* A1: GINTC 199 */
+static const int ast2700_gic199_intcmap[] = {
+    [ASPEED_DEV_IOEXP0_I3C]       = 0, /* 0 - 15 */
+};
+
 /* Secondary AST1700 Interrupts */
 /* A1: GINTC 200 */
 static const int ast2700_gic200_intcmap[] = {
     [ASPEED_DEV_IOEXP1_I2C]       = 0, /* 0 - 15 */
 };
 
+/* Secondary AST1700 Interrupts */
+/* A1: GINTC 201 */
+static const int ast2700_gic201_intcmap[] = {
+    [ASPEED_DEV_IOEXP1_I3C]       = 0, /* 0 - 15 */
+};
+
 /* GICINT 192 ~ 201 */
 struct gic_intc_irq_info {
     int irq;
@@ -243,9 +257,9 @@ static const struct gic_intc_irq_info ast2700_gic_intcmap[] = {
     {196, 1, 4, ast2700_gic196_intcmap},
     {197, 1, 5, ast2700_gic197_intcmap},
     {198, 2, 0, ast2700_gic198_intcmap},
-    {199, 1, 7, NULL},
+    {199, 2, 1, ast2700_gic199_intcmap},
     {200, 3, 0, ast2700_gic200_intcmap},
-    {201, 1, 9, NULL},
+    {201, 3, 1, ast2700_gic201_intcmap},
 };
 
 static qemu_irq aspeed_soc_ast2700_get_irq(AspeedSoCState *s, int dev)
-- 
2.52.0


