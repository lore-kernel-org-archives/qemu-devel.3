Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CDDF0CA9EDD
	for <qemu-devel@archiver.kernel.org>; Mon, 12 Oct 2026 15:01:46 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xGHX6-0003Ok-CE; Mon, 12 Oct 2026 11:01:44 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eblot.ml@gmail.com>)
 id 1xGHX3-0003N7-KI
 for qemu-devel@nongnu.org; Mon, 12 Oct 2026 11:01:41 -0400
Received: from mail-wm1-f41.google.com ([209.85.128.41])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <eblot.ml@gmail.com>)
 id 1xGHX1-0006BS-CY
 for qemu-devel@nongnu.org; Mon, 12 Oct 2026 11:01:41 -0400
Received: by mail-wm1-f41.google.com with SMTP id
 5b1f17b1804b1-4a1635f7c89so20348995e9.2
 for <qemu-devel@nongnu.org>; Mon, 12 Oct 2026 08:01:39 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1791817298; x=1792422098;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=Iynoh3aT8safdUE3BTc0b1k07T2hDRDq8XUc5yS3tkk=;
 b=FxHnLk+et8TmUbNkBTpxlU+PKjezMAmsl0u8qzKgtNCz+nUZEnkG2bVeaN2fyzj/Tk
 rLHX8uDqn24BViRQFWQYN/82RZ9FtV0A6zRuQImyhNKYXjI6+VhGfbEGQU57yKJziCSi
 lxaem6KGrEgGtaMiyevdLr5ksCkm15htTScFT872bxvhsuVmRA/GeKHsLcey+srjtPOD
 5/HKdNuLoEyT5Hkit74mmyWNRG9Mph5y0bmy4Uu3sFVtfetU+98ayHb+FY9hDl2w8vSi
 GyRLklzI49vdqVBEhFqSAMJun3xiL7/F4rYEp5yNNZGr/raNRvJ2ro97XkIqLK8mfjMW
 5HtQ==
X-Gm-Message-State: AFq9FYLIFOsz2bEbPRtLwmBim1fqodJBCRhCrJzG04stiGzcvAUAH5j3
 LRS6tfNPFCmEz9i121cZT6uwhPrh9zwkEGJW0if+NjPxZvQlLQ4F+ZTpbefd3hWc
X-Gm-Gg: AYBFou0+rfRB9M8La+letBIjl1ffQk7/1RdwklpEj0wrBnZTk8vLqi8qt0wcrC3zTzJ
 31x2pi2YvXI753XURRKKAh+d9OHO8d1nvZlGE2t0GKU8DNOlgfo4c0u9IzT6QK7jRfgZ6KosXK2
 UhNomuYRV4Wzw3eQVn3XkhU87sYMJgky3cNb2yVHOYuWQPkNQlQB7lM9wQZ0Vt1Dycr2wWAeGLD
 hv3l8BWMjYl7rw3A2O5TB8YtIiE0E9+oi1qAY9rlPMutd97g5rxdNpYRsgXtCksUyVIYboZoVMA
 SNN5eOB5vQAH1Nt0lGjU6f+cVlXOVMZr3d5KJ+AU7MoizQ7M4a5m9J9NOQphGMt6L195y0akUMi
 Aic5KH+RWs4QO+tPcUwg56/sog8aOain+mzuDYzM9T7jtjcT+yjqmjnlK+iIwzv0IcwEzrbdZIO
 +f6usJPaNNOcd/3mbfrCg4sB+UNhUrviiKaAsDr7xt8hwsLVh4Mcz5CtG7BNrccFZrufxolgR+3
 FzMx8GhInpKyAJGD2oKADB8n0MrnYuBveAwAybhDGyXaQ==
X-Received: by 2002:a05:600c:8214:b0:4a1:6425:be69 with SMTP id
 5b1f17b1804b1-4a18e4b4db8mr183059115e9.17.1791817297761; 
 Mon, 12 Oct 2026 08:01:37 -0700 (PDT)
Received: from localhost (89-93-216-19.hfc.dyn.abo.bbox.fr. [89.93.216.19])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-48db9acf092sm19901459f8f.45.2026.10.12.08.01.37
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 12 Oct 2026 08:01:37 -0700 (PDT)
Date: Mon, 12 Oct 2026 16:32:02 +0200
Subject: [PATCH v2 09/50] hw: ds1338: use the TYPE_DS1338 constant instead
 of the "ds1338" string
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261012-bmc-minerva-v2-9-4c3dff084ec9@free.fr>
References: <20261012-bmc-minerva-v2-0-4c3dff084ec9@free.fr>
In-Reply-To: <20261012-bmc-minerva-v2-0-4c3dff084ec9@free.fr>
To: qemu-devel@nongnu.org
Cc: =?utf-8?q?C=C3=A9dric_Le_Goater?= <clg@kaod.org>, 
 Peter Maydell <peter.maydell@linaro.org>, 
 Steven Lee <steven_lee@aspeedtech.com>, Troy Lee <leetroy@gmail.com>, 
 Jamin Lin <jamin_lin@aspeedtech.com>, Kane Chen <kane_chen@aspeedtech.com>, 
 Andrew Jeffery <andrew@codeconstruct.com.au>, Joel Stanley <joel@jms.id.au>, 
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>, qemu-arm@nongnu.org, 
 Patrick Leis <venture@google.com>, Fabiano Rosas <farosas@suse.de>, 
 Laurent Vivier <lvivier@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, 
 qemu-ppc@nongnu.org, qemu-riscv@nongnu.org, 
 =?utf-8?q?Philippe_Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>, 
 Emmanuel Blot <emmanuel.blot@free.fr>
X-Mailer: b4 0.16.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1791815520; l=11014;
 i=emmanuel.blot@free.fr; s=20260602; h=from:subject:message-id;
 bh=nCUROmiWn21T4uywY6NVMgmTsZ/FiAbd7U88DkRkIr8=;
 b=riaJWxAq4E2O+Ib7K64FaFNAvMaA4yQ1xBNocaLbRt9w55A9ljl3/bEp75lWJAA03DaDSvYo/
 EHNGcK1Q+6WA4M4TyBps59A+R6M6ehyNmzVfOsFI1gKIxjS4rHsgD2/
X-Developer-Key: i=emmanuel.blot@free.fr; a=ed25519;
 pk=0qFrZ21FAAN8OfVsSoVcCFTk/NMYOWzxJz4paSAVm0g=
Received-SPF: pass client-ip=209.85.128.41; envelope-from=eblot.ml@gmail.com;
 helo=mail-wm1-f41.google.com
X-Spam_score_int: -15
X-Spam_score: -1.6
X-Spam_bar: -
X-Spam_report: (-1.6 / 5.0 requ) BAYES_00=-1.9,
 FREEMAIL_FORGED_FROMDOMAIN=0.001, FREEMAIL_FROM=0.001,
 HEADER_FROM_DIFFERENT_DOMAINS=0.25, RCVD_IN_DNSWL_NONE=-0.0001,
 RCVD_IN_MSPIKE_H2=0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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
Reply-to:  Emmanuel Blot <emmanuel.blot@free.fr>
From:  Emmanuel Blot via qemu development <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

Now that TYPE_DS1338 is exposed by include/hw/rtc/ds1338.h, use it in
the machines that instantiate the RTC by its raw type name string.

No functional change.

Signed-off-by: Emmanuel Blot <emmanuel.blot@free.fr>
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
index e2350e5b6c..185185f0bb 100644
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
index c75898cc6d..051e072c5a 100644
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
index 340a74408b..87f90ed361 100644
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
index 5a7e49d6cc..dc0248422d 100644
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
index 26ddb67347..c69065846c 100644
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
index 6fa606c047..0e746055a2 100644
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
index 4f2b396f6f..b15d932086 100644
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
index ac2aef740a..b0935683e2 100644
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
index ceba0331b0..4cdf939511 100644
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
index f94bf96599..737cd21c27 100644
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
index 1876882a04..469cef9d2f 100644
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
index 8a219afef7..910713c6bb 100644
--- a/hw/riscv/tt_atlantis.c
+++ b/hw/riscv/tt_atlantis.c
@@ -27,6 +27,7 @@
 #include "hw/char/serial-mm.h"
 #include "hw/intc/riscv_aclint.h"
 #include "hw/misc/unimp.h"
+#include "hw/rtc/ds1338.h"
 
 #include "system/system.h"
 #include "system/device_tree.h"
@@ -657,7 +658,7 @@ static void tt_atlantis_machine_init(MachineState *machine)
     qdev_realize(DEVICE(&ams->soc), NULL, &error_fatal);
 
     /* I2C peripherals: qemu specific */
-    i2c_slave_create_simple(i2c_get_bus(s, 0), "ds1338", 0x6f);
+    i2c_slave_create_simple(i2c_get_bus(s, 0), TYPE_DS1338, 0x6f);
     i2c_slave_create_simple(i2c_get_bus(s, 4), "tmp105", 0x48);
 
     /* Load or create device tree */

-- 
2.50.1


