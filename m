Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 56EED606A31A
	for <qemu-devel@archiver.kernel.org>; Sat, 31 Oct 2026 07:01:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=VPxoFTpw
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xN35U-0006Qw-V1; Sat, 31 Oct 2026 03:01:13 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1xN349-0003KE-KR
 for qemu-devel@nongnu.org; Sat, 31 Oct 2026 02:59:54 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1xN344-0002wz-Lb
 for qemu-devel@nongnu.org; Sat, 31 Oct 2026 02:59:47 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1793429982;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=xZezqNUnbMt6uGn7gv32wIaLFsOrCgBAru2znCvl4RE=;
 b=VPxoFTpwX8jhr5g2Yndikh3JKkTt/BQYNI1p+2kwcwRV9Q7otTyo7Hj5YmYMpAmGAvu/92
 btRqPFIv0ktx5N0Q/U7qEtItLsexGFUu0hKQ7SdYfUGZG3778xAauqPY26E2m+Iwlclkmv
 JUWNLCt/9sdEJSQ7v+gWlMRD5YVBM3Y=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-74-yxCSPcE7OqK0DOuyEFWbzw-1; Sat,
 31 Oct 2026 02:59:38 -0400
X-MC-Unique: yxCSPcE7OqK0DOuyEFWbzw-1
X-Mimecast-MFC-AGG-ID: yxCSPcE7OqK0DOuyEFWbzw_1793429977
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 8E0741956089; Sat, 31 Oct 2026 06:59:37 +0000 (UTC)
Received: from circe.redhat.com (unknown [10.44.32.2])
 by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id AC4B51800765; Sat, 31 Oct 2026 06:59:35 +0000 (UTC)
From: =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>
To: qemu-arm@nongnu.org,
	qemu-devel@nongnu.org
Cc: Emmanuel Blot <emmanuel.blot@free.fr>, Jamin Lin <jaminlin1207@gmail.com>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>,
 Bernhard Beschow <sgentey@gmail.com>
Subject: [PULL 31/34] hw: ds1338: use the TYPE_DS1338 constant instead of the
 "ds1338" string
Date: Sat, 31 Oct 2026 07:58:20 +0100
Message-ID: <20261031065823.191966-32-clg@redhat.com>
In-Reply-To: <20261031065823.191966-1-clg@redhat.com>
References: <20261031065823.191966-1-clg@redhat.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111
Received-SPF: pass client-ip=170.10.133.124; envelope-from=clg@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: 5
X-Spam_score: 0.5
X-Spam_bar: /
X-Spam_report: (0.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_SBL_CSS=3.335, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,
	SPF_PASS autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

From: Emmanuel Blot <emmanuel.blot@free.fr>

Now that TYPE_DS1338 is exposed by include/hw/rtc/ds1338.h, use it in
the machines that instantiate the RTC by its raw type name string.

No functional change.

Reviewed-by: Jamin Lin <jaminlin1207@gmail.com>
Reviewed-by: Cédric Le Goater <clg@redhat.com>
Acked-by: Bernhard Beschow <sgentey@gmail.com>
Signed-off-by: Emmanuel Blot <emmanuel.blot@free.fr>
Link: https://lore.kernel.org/qemu-devel/20261015-bmc-minerva-v3-9-7d50c8a108e5@free.fr
Signed-off-by: Cédric Le Goater <clg@redhat.com>
---
 hw/arm/aspeed_ast2400_palmetto.c          | 4 +++-
 hw/arm/aspeed_ast2400_supermicrox11.c     | 4 +++-
 hw/arm/aspeed_ast2500_romulus.c           | 4 +++-
 hw/arm/aspeed_ast2500_supermicro-x11spi.c | 4 +++-
 hw/arm/aspeed_ast2500_witherspoon.c       | 4 +++-
 hw/arm/aspeed_ast2600_bletchley.c         | 3 ++-
 hw/arm/aspeed_ast2600_catalina.c          | 2 +-
 hw/arm/aspeed_ast2600_sanmiguel.c         | 3 +--
 hw/arm/realview.c                         | 3 ++-
 hw/arm/versatilepb.c                      | 3 ++-
 hw/ppc/e500.c                             | 3 ++-
 hw/riscv/tt_atlantis.c                    | 3 ++-
 12 files changed, 27 insertions(+), 13 deletions(-)

diff --git a/hw/arm/aspeed_ast2400_palmetto.c b/hw/arm/aspeed_ast2400_palmetto.c
index e2350e5b6ca6..185185f0bb46 100644
--- a/hw/arm/aspeed_ast2400_palmetto.c
+++ b/hw/arm/aspeed_ast2400_palmetto.c
@@ -11,6 +11,7 @@
 #include "hw/arm/aspeed.h"
 #include "hw/arm/aspeed_soc.h"
 #include "hw/i2c/smbus_eeprom.h"
+#include "hw/rtc/ds1338.h"
 
 /* Palmetto hardware value: 0x120CE416 */
 #define PALMETTO_BMC_HW_STRAP1 (                                        \
@@ -36,7 +37,8 @@ static void palmetto_bmc_i2c_init(AspeedMachineState *bmc)
      * The palmetto platform expects a ds3231 RTC but a ds1338 is
      * enough to provide basic RTC features. Alarms will be missing
      */
-    i2c_slave_create_simple(aspeed_i2c_get_bus(&soc->i2c, 0), "ds1338", 0x68);
+    i2c_slave_create_simple(aspeed_i2c_get_bus(&soc->i2c, 0), TYPE_DS1338,
+                            0x68);
 
     smbus_eeprom_init_one(aspeed_i2c_get_bus(&soc->i2c, 0), 0x50,
                           eeprom_buf);
diff --git a/hw/arm/aspeed_ast2400_supermicrox11.c b/hw/arm/aspeed_ast2400_supermicrox11.c
index c75898cc6d1a..051e072c5a05 100644
--- a/hw/arm/aspeed_ast2400_supermicrox11.c
+++ b/hw/arm/aspeed_ast2400_supermicrox11.c
@@ -11,6 +11,7 @@
 #include "hw/arm/aspeed.h"
 #include "hw/arm/aspeed_soc.h"
 #include "hw/i2c/smbus_eeprom.h"
+#include "hw/rtc/ds1338.h"
 
 /* TODO: Find the actual hardware value */
 #define SUPERMICROX11_BMC_HW_STRAP1 (                                   \
@@ -36,7 +37,8 @@ static void supermicrox11_bmc_i2c_init(AspeedMachineState *bmc)
      * The palmetto platform expects a ds3231 RTC but a ds1338 is
      * enough to provide basic RTC features. Alarms will be missing
      */
-    i2c_slave_create_simple(aspeed_i2c_get_bus(&soc->i2c, 0), "ds1338", 0x68);
+    i2c_slave_create_simple(aspeed_i2c_get_bus(&soc->i2c, 0), TYPE_DS1338,
+                            0x68);
 
     smbus_eeprom_init_one(aspeed_i2c_get_bus(&soc->i2c, 0), 0x50,
                           eeprom_buf);
diff --git a/hw/arm/aspeed_ast2500_romulus.c b/hw/arm/aspeed_ast2500_romulus.c
index 340a74408b62..87f90ed361c3 100644
--- a/hw/arm/aspeed_ast2500_romulus.c
+++ b/hw/arm/aspeed_ast2500_romulus.c
@@ -10,6 +10,7 @@
 #include "qapi/error.h"
 #include "hw/arm/aspeed.h"
 #include "hw/arm/aspeed_soc.h"
+#include "hw/rtc/ds1338.h"
 
 /* Romulus hardware value: 0xF10AD206 */
 #define ROMULUS_BMC_HW_STRAP1 (                                         \
@@ -29,7 +30,8 @@ static void romulus_bmc_i2c_init(AspeedMachineState *bmc)
      * The romulus board expects Epson RX8900 I2C RTC but a ds1338 is
      * good enough
      */
-    i2c_slave_create_simple(aspeed_i2c_get_bus(&soc->i2c, 11), "ds1338", 0x32);
+    i2c_slave_create_simple(aspeed_i2c_get_bus(&soc->i2c, 11), TYPE_DS1338,
+                            0x32);
 }
 
 static void aspeed_machine_romulus_class_init(ObjectClass *oc,
diff --git a/hw/arm/aspeed_ast2500_supermicro-x11spi.c b/hw/arm/aspeed_ast2500_supermicro-x11spi.c
index 5a7e49d6ccdb..dc0248422d43 100644
--- a/hw/arm/aspeed_ast2500_supermicro-x11spi.c
+++ b/hw/arm/aspeed_ast2500_supermicro-x11spi.c
@@ -11,6 +11,7 @@
 #include "hw/arm/aspeed.h"
 #include "hw/arm/aspeed_soc.h"
 #include "hw/i2c/smbus_eeprom.h"
+#include "hw/rtc/ds1338.h"
 
 /* TODO: Find the actual hardware value */
 #define SUPERMICRO_X11SPI_BMC_HW_STRAP1 (                               \
@@ -32,7 +33,8 @@ static void supermicro_x11spi_bmc_i2c_init(AspeedMachineState *bmc)
      * The palmetto platform expects a ds3231 RTC but a ds1338 is
      * enough to provide basic RTC features. Alarms will be missing
      */
-    i2c_slave_create_simple(aspeed_i2c_get_bus(&soc->i2c, 0), "ds1338", 0x68);
+    i2c_slave_create_simple(aspeed_i2c_get_bus(&soc->i2c, 0), TYPE_DS1338,
+                            0x68);
 
     smbus_eeprom_init_one(aspeed_i2c_get_bus(&soc->i2c, 0), 0x50,
                           eeprom_buf);
diff --git a/hw/arm/aspeed_ast2500_witherspoon.c b/hw/arm/aspeed_ast2500_witherspoon.c
index 26ddb6734702..c69065846c24 100644
--- a/hw/arm/aspeed_ast2500_witherspoon.c
+++ b/hw/arm/aspeed_ast2500_witherspoon.c
@@ -14,6 +14,7 @@
 #include "hw/sensor/tmp105.h"
 #include "hw/i2c/smbus_eeprom.h"
 #include "hw/gpio/pca9552.h"
+#include "hw/rtc/ds1338.h"
 
 /* Witherspoon hardware value: 0xF10AD216 */
 #define WITHERSPOON_BMC_HW_STRAP1 (                                     \
@@ -70,7 +71,8 @@ static void witherspoon_bmc_i2c_init(AspeedMachineState *bmc)
      * The witherspoon board expects Epson RX8900 I2C RTC but a ds1338 is
      * good enough
      */
-    i2c_slave_create_simple(aspeed_i2c_get_bus(&soc->i2c, 11), "ds1338", 0x32);
+    i2c_slave_create_simple(aspeed_i2c_get_bus(&soc->i2c, 11), TYPE_DS1338,
+                            0x32);
 
     smbus_eeprom_init_one(aspeed_i2c_get_bus(&soc->i2c, 11), 0x51,
                           eeprom_buf);
diff --git a/hw/arm/aspeed_ast2600_bletchley.c b/hw/arm/aspeed_ast2600_bletchley.c
index 6fa606c047e6..0e746055a218 100644
--- a/hw/arm/aspeed_ast2600_bletchley.c
+++ b/hw/arm/aspeed_ast2600_bletchley.c
@@ -12,6 +12,7 @@
 #include "hw/arm/aspeed_soc.h"
 #include "hw/gpio/pca9552.h"
 #include "hw/nvram/eeprom_at24c.h"
+#include "hw/rtc/ds1338.h"
 
 #define TYPE_TMP421 "tmp421"
 /* Bletchley hardware value */
@@ -44,7 +45,7 @@ static void bletchley_bmc_i2c_init(AspeedMachineState *bmc)
     /* Bus 6 */
     at24c_eeprom_init(i2c[6], 0x56, 65536);
     /* Missing model: nxp,pcf85263 @ 0x51 , but ds1338 works enough */
-    i2c_slave_create_simple(i2c[6], "ds1338", 0x51);
+    i2c_slave_create_simple(i2c[6], TYPE_DS1338, 0x51);
 
 
     /* Bus 7 */
diff --git a/hw/arm/aspeed_ast2600_catalina.c b/hw/arm/aspeed_ast2600_catalina.c
index 4f2b396f6f0c..b15d932086cf 100644
--- a/hw/arm/aspeed_ast2600_catalina.c
+++ b/hw/arm/aspeed_ast2600_catalina.c
@@ -14,6 +14,7 @@
 #include "hw/gpio/pca9552.h"
 #include "hw/gpio/pca9554.h"
 #include "hw/nvram/eeprom_at24c.h"
+#include "hw/rtc/ds1338.h"
 #include "hw/sensor/tmp105.h"
 
 /* Catalina hardware value */
@@ -22,7 +23,6 @@
 #define CATALINA_BMC_RAM_SIZE (2 * GiB)
 
 #define TYPE_TMP421 "tmp421"
-#define TYPE_DS1338 "ds1338"
 
 /*
  * "BMC Storage Module" FRU data.  Generated with frugen.
diff --git a/hw/arm/aspeed_ast2600_sanmiguel.c b/hw/arm/aspeed_ast2600_sanmiguel.c
index ac2aef740ad0..b0935683e2fc 100644
--- a/hw/arm/aspeed_ast2600_sanmiguel.c
+++ b/hw/arm/aspeed_ast2600_sanmiguel.c
@@ -13,6 +13,7 @@
 #include "hw/gpio/pca9552.h"
 #include "hw/gpio/pca9554.h"
 #include "hw/nvram/eeprom_at24c.h"
+#include "hw/rtc/ds1338.h"
 #include "hw/sensor/tmp105.h"
 
 /* SanMiguel hardware values */
@@ -20,8 +21,6 @@
 #define SANMIGUEL_BMC_HW_STRAP2 0x00000000
 #define SANMIGUEL_BMC_RAM_SIZE (2 * GiB)
 
-#define TYPE_DS1338 "ds1338"
-
 /*
  * "Front IO" FRU data. Generated with frugen.
  *
diff --git a/hw/arm/realview.c b/hw/arm/realview.c
index ceba0331b08c..4cdf939511d1 100644
--- a/hw/arm/realview.c
+++ b/hw/arm/realview.c
@@ -28,6 +28,7 @@
 #include "hw/intc/realview_gic.h"
 #include "hw/core/irq.h"
 #include "hw/i2c/arm_sbcon_i2c.h"
+#include "hw/rtc/ds1338.h"
 #include "hw/sd/sd.h"
 #include "target/arm/cpu-qom.h"
 
@@ -323,7 +324,7 @@ static void realview_init(MachineState *machine,
 
     dev = sysbus_create_simple(TYPE_ARM_SBCON_I2C, 0x10002000, NULL);
     i2c = (I2CBus *)qdev_get_child_bus(dev, "i2c");
-    i2c_slave_create_simple(i2c, "ds1338", 0x68);
+    i2c_slave_create_simple(i2c, TYPE_DS1338, 0x68);
 
     /* Memory map for RealView Emulation Baseboard:  */
     /* 0x10000000 System registers.  */
diff --git a/hw/arm/versatilepb.c b/hw/arm/versatilepb.c
index f94bf96599e0..737cd21c27f7 100644
--- a/hw/arm/versatilepb.c
+++ b/hw/arm/versatilepb.c
@@ -18,6 +18,7 @@
 #include "hw/pci/pci.h"
 #include "hw/i2c/i2c.h"
 #include "hw/i2c/arm_sbcon_i2c.h"
+#include "hw/rtc/ds1338.h"
 #include "hw/core/irq.h"
 #include "hw/core/boards.h"
 #include "hw/block/flash.h"
@@ -346,7 +347,7 @@ static void versatile_init(MachineState *machine, int board_id)
 
     dev = sysbus_create_simple(TYPE_ARM_SBCON_I2C, 0x10002000, NULL);
     i2c = (I2CBus *)qdev_get_child_bus(dev, "i2c");
-    i2c_slave_create_simple(i2c, "ds1338", 0x68);
+    i2c_slave_create_simple(i2c, TYPE_DS1338, 0x68);
 
     /* Add PL041 AACI Interface to the LM4549 codec */
     pl041 = qdev_new("pl041");
diff --git a/hw/ppc/e500.c b/hw/ppc/e500.c
index 1876882a0407..469cef9d2f61 100644
--- a/hw/ppc/e500.c
+++ b/hw/ppc/e500.c
@@ -50,6 +50,7 @@
 #include "hw/core/platform-bus.h"
 #include "hw/net/fsl_etsec/etsec.h"
 #include "hw/i2c/i2c.h"
+#include "hw/rtc/ds1338.h"
 #include "hw/core/irq.h"
 #include "hw/sd/sdhci.h"
 #include "hw/misc/unimp.h"
@@ -1025,7 +1026,7 @@ void ppce500_init(MachineState *machine)
     memory_region_add_subregion(ccsr_addr_space, MPC8544_I2C_REGS_OFFSET,
                                 sysbus_mmio_get_region(s, 0));
     i2c = I2C_BUS(qdev_get_child_bus(dev, "i2c"));
-    i2c_slave_create_simple(i2c, "ds1338", RTC_REGS_OFFSET);
+    i2c_slave_create_simple(i2c, TYPE_DS1338, RTC_REGS_OFFSET);
 
     /* eSDHC */
     if (pmc->has_esdhc) {
diff --git a/hw/riscv/tt_atlantis.c b/hw/riscv/tt_atlantis.c
index 311de64eda55..df89a525433d 100644
--- a/hw/riscv/tt_atlantis.c
+++ b/hw/riscv/tt_atlantis.c
@@ -27,6 +27,7 @@
 #include "hw/char/dw8250.h"
 #include "hw/intc/riscv_aclint.h"
 #include "hw/misc/tt_atlantis_prcm.h"
+#include "hw/rtc/ds1338.h"
 
 #include "system/system.h"
 #include "system/device_tree.h"
@@ -768,7 +769,7 @@ static void tt_atlantis_machine_init(MachineState *machine)
     qdev_realize(DEVICE(&ams->soc), NULL, &error_fatal);
 
     /* I2C peripherals: qemu specific */
-    i2c_slave_create_simple(i2c_get_bus(s, 0), "ds1338", 0x6f);
+    i2c_slave_create_simple(i2c_get_bus(s, 0), TYPE_DS1338, 0x6f);
     i2c_slave_create_simple(i2c_get_bus(s, 4), "tmp105", 0x48);
 
     /* Load or create device tree */
-- 
2.56.0


