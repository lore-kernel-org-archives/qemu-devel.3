Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B4E2606A326
	for <qemu-devel@archiver.kernel.org>; Thu,  5 Nov 2026 09:30:47 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xOtmZ-0007t3-Pq; Thu, 05 Nov 2026 04:29:20 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eblot.ml@gmail.com>)
 id 1xOtmX-0007o5-1J
 for qemu-devel@nongnu.org; Thu, 05 Nov 2026 04:29:17 -0500
Received: from mail-pg1-f174.google.com ([209.85.215.174])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <eblot.ml@gmail.com>)
 id 1xOtmU-0006zY-7c
 for qemu-devel@nongnu.org; Thu, 05 Nov 2026 04:29:16 -0500
Received: by mail-pg1-f174.google.com with SMTP id
 41be03b00d2f7-cdab6ae1ee9so752899a12.1
 for <qemu-devel@nongnu.org>; Thu, 05 Nov 2026 01:29:13 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793870953; x=1794475753;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=h4Ea09lpKBE0ZuFBlZjAhUPH2YdoO9oGD+k3joTrPS8=;
 b=bODKfHbEjPcnld/TyIcTIydAu1n7X1kbtiCm18++KHi69debHPYb431sWU2BBu30wY
 1lq5dXpfv2y8HZZ/678d4gSF+qsC5+KKW+zvU+JUa1ZUCl+PVMHnFt19PkLz5TxNNnHn
 FqUN+He1DHcD6QVMdsNjstM6UPV7M4GY86M3Dh+Yzb1jLI7w4fdvjoga/m5r0wOi5cdA
 o8+KzlEhy4V8Zd0hBG1lBNOCBtjh+OuEBdiJNUdVpy81FjJ4AMrLAUq0ldXxn5LTaEK/
 f2jA6E3Uw/w+8wcQXCTQZLHoJ7Qn+JpkcHJd4OFBYBM/CwZYoLgMYtbhMiOU5aTFp38D
 ULyw==
X-Gm-Message-State: APuU4Z/hRGSoFN/7zfNYLKv02qtsYUFQhJlHafG1dnekHbtaB0bHZ1PB
 98WnaYOvJTEfZGMjiMAIZHS4+1eVoIVKCt/ILJKcVBa8/D1kXJOpdMRek8apJ993Q10=
X-Gm-Gg: AYBFou0YfJYIkmt6GC3L/FAowwPQDxwYuyjWIE62Gqnydkbaf3BCMw2FgAd5rhohV7R
 WYr/SMTleWmMH/J3JciMVH/Rz/Nn7ln3iURdMXKZf2C9aENgBl1TATYfrMGKeTI8xT6QccPd4j9
 KUDXHNpEvjuwv4CgXmtycGu6Dmpw0k61YaSMZSEFBP3rgEOw2v3nw7yN4AXCoPSmBqX2BgKGhBo
 BX61RXqT4zC6DjeV0ZckgPLpPyXVxFRV5fee5UC3xwz1Vt01bmbj/qVRkuqCucpxBExrNotmawm
 f/GYdZmvyJnIQWKD9pTaWIJAA7dAb6A2Vv23sKkseeKmvDR9LPaFGSIJZrZIpMg7fzDjBF2mj2a
 STszVkv9rPb8SAjk8wt58wU47PagEm4Ob41ZQTwFpXhHTusfv86187zZpewgjm7tZyNLkhgRWaE
 OogRoNb0h/1csbivADqIdvJa3ehz3Wb7U2BENACm4G6NfULbEk5Ti4EmMlixFrpqTsPXGTWQWWe
 u5gW+Iz6w1ChNBZuoMzEbriQu2+lcsiSojHmYORJqpQI/ETy/6DljJHMme64n56wNaPcSlaa6Uf
 Sg3Bd0inCoozhVtBYXpCAZa+EtA6gnQEq2lfEP8wZDnZci752d6kY73mur48oIJBWidh1+5MUgM
 D
X-Received: by 2002:a17:90b:5487:b0:3ac:adce:60ad with SMTP id
 98e67ed59e1d1-3ae89775250mr13176599a91.22.1793870952592; 
 Thu, 05 Nov 2026 01:29:12 -0800 (PST)
Received: from localhost (118-163-122-149.hinet-ip.hinet.net.
 [118.163.122.149]) by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-3b0b31f8804sm3046335a91.17.2026.11.05.01.29.12
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 05 Nov 2026 01:29:12 -0800 (PST)
Date: Thu, 05 Nov 2026 17:25:50 +0800
Subject: [PATCH 11/16] hw/arm/aspeed: use the TMP421 type-name macros
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261105-sensor-tmp421-v1-11-c46853f5e1f0@free.fr>
References: <20261105-sensor-tmp421-v1-0-c46853f5e1f0@free.fr>
In-Reply-To: <20261105-sensor-tmp421-v1-0-c46853f5e1f0@free.fr>
To: qemu-devel@nongnu.org
Cc: =?utf-8?q?C=C3=A9dric_Le_Goater?= <clg@kaod.org>, eblot@meta.com, 
 =?utf-8?q?Philippe_Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>, 
 Peter Maydell <peter.maydell@linaro.org>, 
 Jamin Lin <jamin_lin@aspeedtech.com>, Kane Chen <kane_chen@aspeedtech.com>, 
 qemu-arm@nongnu.org, Fabiano Rosas <farosas@suse.de>, 
 Laurent Vivier <lvivier@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, 
 Emmanuel Blot <emmanuel.blot@free.fr>, Jamin Lin <jaminlin1207@gmail.com>
X-Mailer: b4 0.16.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1793870743; l=11926;
 i=emmanuel.blot@free.fr; s=20260602; h=from:subject:message-id;
 bh=4oZwEz5iz9ajkWq5VlThdY36odDZrC08EIwReCORXA8=;
 b=aUbpPtP64o7T7w80ldbS8eQ4uR960h1yWAe0UwO9dz3xQ3dezY9CJXZSlpFarbNuPsAuzjEy8
 qR5MU5vpIuDATOqwwN6nI0m8fgkYjMsTrgJY2xR/oqADJ8Q/GkSXwYx
X-Developer-Key: i=emmanuel.blot@free.fr; a=ed25519;
 pk=0qFrZ21FAAN8OfVsSoVcCFTk/NMYOWzxJz4paSAVm0g=
Received-SPF: pass client-ip=209.85.215.174; envelope-from=eblot.ml@gmail.com;
 helo=mail-pg1-f174.google.com
X-Spam_score_int: -15
X-Spam_score: -1.6
X-Spam_bar: -
X-Spam_report: (-1.6 / 5.0 requ) BAYES_00=-1.9,
 FREEMAIL_FORGED_FROMDOMAIN=0.001, FREEMAIL_FROM=0.001,
 HEADER_FROM_DIFFERENT_DOMAINS=0.249, RCVD_IN_DNSWL_NONE=-0.0001,
 RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001, SPF_HELO_NONE=0.001,
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
Reply-to:  Emmanuel Blot <emmanuel.blot@free.fr>
From:  Emmanuel Blot via qemu development <qemu-devel@nongnu.org>
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
X-Spam-Status: No, score=-17.0 required=3.0 tests=BAYES_00,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,SPF_PASS,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Include the new tmp421.h and refer to the sensor variants through
TYPE_TMP421/TYPE_TMP422/TYPE_TMP423 instead of open-coded string
literals and per-board local defines.

Reviewed-by: Jamin Lin <jaminlin1207@gmail.com>
Signed-off-by: Emmanuel Blot <emmanuel.blot@free.fr>
---
 hw/arm/aspeed_ast2400_palmetto.c          |  3 ++-
 hw/arm/aspeed_ast2400_supermicrox11.c     |  3 ++-
 hw/arm/aspeed_ast2500_supermicro-x11spi.c |  3 ++-
 hw/arm/aspeed_ast2500_tiogapass.c         | 10 +++++++---
 hw/arm/aspeed_ast2500_witherspoon.c       |  7 +++++--
 hw/arm/aspeed_ast2500_yosemitev2.c        | 10 +++++++---
 hw/arm/aspeed_ast2600_bletchley.c         |  3 +--
 hw/arm/aspeed_ast2600_catalina.c          |  3 +--
 hw/arm/aspeed_ast2600_fby35.c             |  2 +-
 hw/arm/aspeed_ast2600_fuji.c              |  3 +--
 hw/arm/aspeed_ast2600_rainier.c           | 13 +++++++++----
 11 files changed, 38 insertions(+), 22 deletions(-)

diff --git a/hw/arm/aspeed_ast2400_palmetto.c b/hw/arm/aspeed_ast2400_palmetto.c
index 185185f0bb..7b165394c2 100644
--- a/hw/arm/aspeed_ast2400_palmetto.c
+++ b/hw/arm/aspeed_ast2400_palmetto.c
@@ -12,6 +12,7 @@
 #include "hw/arm/aspeed_soc.h"
 #include "hw/i2c/smbus_eeprom.h"
 #include "hw/rtc/ds1338.h"
+#include "hw/sensor/tmp421.h"
 
 /* Palmetto hardware value: 0x120CE416 */
 #define PALMETTO_BMC_HW_STRAP1 (                                        \
@@ -45,7 +46,7 @@ static void palmetto_bmc_i2c_init(AspeedMachineState *bmc)
 
     /* add a TMP423 temperature sensor */
     dev = DEVICE(i2c_slave_create_simple(aspeed_i2c_get_bus(&soc->i2c, 2),
-                                         "tmp423", 0x4c));
+                                         TYPE_TMP423, 0x4c));
     object_property_set_int(OBJECT(dev), "temperature0", 31000, &error_abort);
     object_property_set_int(OBJECT(dev), "temperature1", 28000, &error_abort);
     object_property_set_int(OBJECT(dev), "temperature2", 20000, &error_abort);
diff --git a/hw/arm/aspeed_ast2400_supermicrox11.c b/hw/arm/aspeed_ast2400_supermicrox11.c
index 051e072c5a..fd2fda9290 100644
--- a/hw/arm/aspeed_ast2400_supermicrox11.c
+++ b/hw/arm/aspeed_ast2400_supermicrox11.c
@@ -12,6 +12,7 @@
 #include "hw/arm/aspeed_soc.h"
 #include "hw/i2c/smbus_eeprom.h"
 #include "hw/rtc/ds1338.h"
+#include "hw/sensor/tmp421.h"
 
 /* TODO: Find the actual hardware value */
 #define SUPERMICROX11_BMC_HW_STRAP1 (                                   \
@@ -45,7 +46,7 @@ static void supermicrox11_bmc_i2c_init(AspeedMachineState *bmc)
 
     /* add a TMP423 temperature sensor */
     dev = DEVICE(i2c_slave_create_simple(aspeed_i2c_get_bus(&soc->i2c, 2),
-                                         "tmp423", 0x4c));
+                                         TYPE_TMP423, 0x4c));
     object_property_set_int(OBJECT(dev), "temperature0", 31000, &error_abort);
     object_property_set_int(OBJECT(dev), "temperature1", 28000, &error_abort);
     object_property_set_int(OBJECT(dev), "temperature2", 20000, &error_abort);
diff --git a/hw/arm/aspeed_ast2500_supermicro-x11spi.c b/hw/arm/aspeed_ast2500_supermicro-x11spi.c
index dc0248422d..1ea61348f6 100644
--- a/hw/arm/aspeed_ast2500_supermicro-x11spi.c
+++ b/hw/arm/aspeed_ast2500_supermicro-x11spi.c
@@ -12,6 +12,7 @@
 #include "hw/arm/aspeed_soc.h"
 #include "hw/i2c/smbus_eeprom.h"
 #include "hw/rtc/ds1338.h"
+#include "hw/sensor/tmp421.h"
 
 /* TODO: Find the actual hardware value */
 #define SUPERMICRO_X11SPI_BMC_HW_STRAP1 (                               \
@@ -41,7 +42,7 @@ static void supermicro_x11spi_bmc_i2c_init(AspeedMachineState *bmc)
 
     /* add a TMP423 temperature sensor */
     dev = DEVICE(i2c_slave_create_simple(aspeed_i2c_get_bus(&soc->i2c, 2),
-                                         "tmp423", 0x4c));
+                                         TYPE_TMP423, 0x4c));
     object_property_set_int(OBJECT(dev), "temperature0", 31000, &error_abort);
     object_property_set_int(OBJECT(dev), "temperature1", 28000, &error_abort);
     object_property_set_int(OBJECT(dev), "temperature2", 20000, &error_abort);
diff --git a/hw/arm/aspeed_ast2500_tiogapass.c b/hw/arm/aspeed_ast2500_tiogapass.c
index 6cb567526c..5433198abd 100644
--- a/hw/arm/aspeed_ast2500_tiogapass.c
+++ b/hw/arm/aspeed_ast2500_tiogapass.c
@@ -11,6 +11,7 @@
 #include "hw/arm/aspeed.h"
 #include "hw/arm/aspeed_soc.h"
 #include "hw/nvram/eeprom_at24c.h"
+#include "hw/sensor/tmp421.h"
 
 /* value: 0xF100C2E6 */
 #define TIOGAPASS_BMC_HW_STRAP1 ((                                        \
@@ -54,9 +55,12 @@ static void tiogapass_bmc_i2c_init(AspeedMachineState *bmc)
     at24c_eeprom_init_rom(aspeed_i2c_get_bus(&soc->i2c, 6), 0x54, 128 * KiB,
                           tiogapass_bmc_fruid, tiogapass_bmc_fruid_len);
     /* TMP421 */
-    i2c_slave_create_simple(aspeed_i2c_get_bus(&soc->i2c, 8), "tmp421", 0x1f);
-    i2c_slave_create_simple(aspeed_i2c_get_bus(&soc->i2c, 6), "tmp421", 0x4f);
-    i2c_slave_create_simple(aspeed_i2c_get_bus(&soc->i2c, 6), "tmp421", 0x4e);
+    i2c_slave_create_simple(aspeed_i2c_get_bus(&soc->i2c, 8),
+                            TYPE_TMP421, 0x1f);
+    i2c_slave_create_simple(aspeed_i2c_get_bus(&soc->i2c, 6),
+                            TYPE_TMP421, 0x4f);
+    i2c_slave_create_simple(aspeed_i2c_get_bus(&soc->i2c, 6),
+                            TYPE_TMP421, 0x4e);
 }
 
 static void aspeed_machine_tiogapass_class_init(ObjectClass *oc,
diff --git a/hw/arm/aspeed_ast2500_witherspoon.c b/hw/arm/aspeed_ast2500_witherspoon.c
index c69065846c..385deb2154 100644
--- a/hw/arm/aspeed_ast2500_witherspoon.c
+++ b/hw/arm/aspeed_ast2500_witherspoon.c
@@ -12,6 +12,7 @@
 #include "hw/arm/aspeed_soc.h"
 #include "hw/misc/led.h"
 #include "hw/sensor/tmp105.h"
+#include "hw/sensor/tmp421.h"
 #include "hw/i2c/smbus_eeprom.h"
 #include "hw/gpio/pca9552.h"
 #include "hw/rtc/ds1338.h"
@@ -60,8 +61,10 @@ static void witherspoon_bmc_i2c_init(AspeedMachineState *bmc)
     }
     i2c_slave_create_simple(aspeed_i2c_get_bus(&soc->i2c, 3), "dps310", 0x76);
     i2c_slave_create_simple(aspeed_i2c_get_bus(&soc->i2c, 3), "max31785", 0x52);
-    i2c_slave_create_simple(aspeed_i2c_get_bus(&soc->i2c, 4), "tmp423", 0x4c);
-    i2c_slave_create_simple(aspeed_i2c_get_bus(&soc->i2c, 5), "tmp423", 0x4c);
+    i2c_slave_create_simple(aspeed_i2c_get_bus(&soc->i2c, 4),
+                            TYPE_TMP423, 0x4c);
+    i2c_slave_create_simple(aspeed_i2c_get_bus(&soc->i2c, 5),
+                            TYPE_TMP423, 0x4c);
 
     /* The Witherspoon expects a TMP275 but a TMP105 is compatible */
     i2c_slave_create_simple(aspeed_i2c_get_bus(&soc->i2c, 9), TYPE_TMP105,
diff --git a/hw/arm/aspeed_ast2500_yosemitev2.c b/hw/arm/aspeed_ast2500_yosemitev2.c
index 3ba1ed5f6f..3dd0d37175 100644
--- a/hw/arm/aspeed_ast2500_yosemitev2.c
+++ b/hw/arm/aspeed_ast2500_yosemitev2.c
@@ -11,6 +11,7 @@
 #include "hw/arm/aspeed.h"
 #include "hw/arm/aspeed_soc.h"
 #include "hw/nvram/eeprom_at24c.h"
+#include "hw/sensor/tmp421.h"
 
 /* value: 0xF100C2E6 */
 #define YOSEMITEV2_BMC_HW_STRAP1 ((                                        \
@@ -54,9 +55,12 @@ static void yosemitev2_bmc_i2c_init(AspeedMachineState *bmc)
     at24c_eeprom_init_rom(aspeed_i2c_get_bus(&soc->i2c, 8), 0x51, 128 * KiB,
                           yosemitev2_bmc_fruid, yosemitev2_bmc_fruid_len);
     /* TMP421 */
-    i2c_slave_create_simple(aspeed_i2c_get_bus(&soc->i2c, 11), "tmp421", 0x1f);
-    i2c_slave_create_simple(aspeed_i2c_get_bus(&soc->i2c, 9), "tmp421", 0x4e);
-    i2c_slave_create_simple(aspeed_i2c_get_bus(&soc->i2c, 9), "tmp421", 0x4f);
+    i2c_slave_create_simple(aspeed_i2c_get_bus(&soc->i2c, 11),
+                            TYPE_TMP421, 0x1f);
+    i2c_slave_create_simple(aspeed_i2c_get_bus(&soc->i2c, 9),
+                            TYPE_TMP421, 0x4e);
+    i2c_slave_create_simple(aspeed_i2c_get_bus(&soc->i2c, 9),
+                            TYPE_TMP421, 0x4f);
 
 }
 
diff --git a/hw/arm/aspeed_ast2600_bletchley.c b/hw/arm/aspeed_ast2600_bletchley.c
index 0e746055a2..536e910229 100644
--- a/hw/arm/aspeed_ast2600_bletchley.c
+++ b/hw/arm/aspeed_ast2600_bletchley.c
@@ -13,8 +13,7 @@
 #include "hw/gpio/pca9552.h"
 #include "hw/nvram/eeprom_at24c.h"
 #include "hw/rtc/ds1338.h"
-
-#define TYPE_TMP421 "tmp421"
+#include "hw/sensor/tmp421.h"
 /* Bletchley hardware value */
 #define BLETCHLEY_BMC_HW_STRAP1 0x00002000
 #define BLETCHLEY_BMC_HW_STRAP2 0x00000801
diff --git a/hw/arm/aspeed_ast2600_catalina.c b/hw/arm/aspeed_ast2600_catalina.c
index b15d932086..13dca7a846 100644
--- a/hw/arm/aspeed_ast2600_catalina.c
+++ b/hw/arm/aspeed_ast2600_catalina.c
@@ -16,14 +16,13 @@
 #include "hw/nvram/eeprom_at24c.h"
 #include "hw/rtc/ds1338.h"
 #include "hw/sensor/tmp105.h"
+#include "hw/sensor/tmp421.h"
 
 /* Catalina hardware value */
 #define CATALINA_BMC_HW_STRAP1 0x00002002
 #define CATALINA_BMC_HW_STRAP2 0x00000800
 #define CATALINA_BMC_RAM_SIZE (2 * GiB)
 
-#define TYPE_TMP421 "tmp421"
-
 /*
  * "BMC Storage Module" FRU data.  Generated with frugen.
  *
diff --git a/hw/arm/aspeed_ast2600_fby35.c b/hw/arm/aspeed_ast2600_fby35.c
index 28c9c143d8..25f39d5135 100644
--- a/hw/arm/aspeed_ast2600_fby35.c
+++ b/hw/arm/aspeed_ast2600_fby35.c
@@ -12,10 +12,10 @@
 #include "hw/arm/aspeed_soc.h"
 #include "hw/nvram/eeprom_at24c.h"
 #include "hw/sensor/tmp105.h"
+#include "hw/sensor/tmp421.h"
 #include "system/reset.h"
 
 #define TYPE_LM75 TYPE_TMP105
-#define TYPE_TMP421 "tmp421"
 #define FBY35_BMC_RAM_SIZE (2 * GiB)
 
 static const uint8_t fby35_nic_fruid[] = {
diff --git a/hw/arm/aspeed_ast2600_fuji.c b/hw/arm/aspeed_ast2600_fuji.c
index 08d809b2fd..526494ecfe 100644
--- a/hw/arm/aspeed_ast2600_fuji.c
+++ b/hw/arm/aspeed_ast2600_fuji.c
@@ -12,10 +12,9 @@
 #include "hw/arm/aspeed_soc.h"
 #include "hw/i2c/i2c_mux_pca954x.h"
 #include "hw/sensor/tmp105.h"
+#include "hw/sensor/tmp421.h"
 #include "hw/nvram/eeprom_at24c.h"
 
-#define TYPE_TMP422 "tmp422"
-
 /* Fuji hardware value */
 #define FUJI_BMC_HW_STRAP1    0x00000000
 #define FUJI_BMC_HW_STRAP2    0x00000000
diff --git a/hw/arm/aspeed_ast2600_rainier.c b/hw/arm/aspeed_ast2600_rainier.c
index 43a8f01a9e..bdbc78aee7 100644
--- a/hw/arm/aspeed_ast2600_rainier.c
+++ b/hw/arm/aspeed_ast2600_rainier.c
@@ -13,6 +13,7 @@
 #include "hw/nvram/eeprom_at24c.h"
 #include "hw/i2c/i2c_mux_pca954x.h"
 #include "hw/sensor/tmp105.h"
+#include "hw/sensor/tmp421.h"
 
 /* Rainier hardware value: (QEMU prototype) */
 #define RAINIER_BMC_HW_STRAP1 (0x00422016 | SCU_AST2600_HW_STRAP_BOOT_SRC_EMMC)
@@ -137,12 +138,16 @@ static void rainier_bmc_i2c_init(AspeedMachineState *bmc)
     /* Bus 8: ucd90320@b */
     /* Bus 8: ucd90320@c */
 
-    i2c_slave_create_simple(aspeed_i2c_get_bus(&soc->i2c, 9), "tmp423", 0x4c);
-    i2c_slave_create_simple(aspeed_i2c_get_bus(&soc->i2c, 9), "tmp423", 0x4d);
+    i2c_slave_create_simple(aspeed_i2c_get_bus(&soc->i2c, 9),
+                            TYPE_TMP423, 0x4c);
+    i2c_slave_create_simple(aspeed_i2c_get_bus(&soc->i2c, 9),
+                            TYPE_TMP423, 0x4d);
     at24c_eeprom_init(aspeed_i2c_get_bus(&soc->i2c, 9), 0x50, 128 * KiB);
 
-    i2c_slave_create_simple(aspeed_i2c_get_bus(&soc->i2c, 10), "tmp423", 0x4c);
-    i2c_slave_create_simple(aspeed_i2c_get_bus(&soc->i2c, 10), "tmp423", 0x4d);
+    i2c_slave_create_simple(aspeed_i2c_get_bus(&soc->i2c, 10),
+                            TYPE_TMP423, 0x4c);
+    i2c_slave_create_simple(aspeed_i2c_get_bus(&soc->i2c, 10),
+                            TYPE_TMP423, 0x4d);
     at24c_eeprom_init(aspeed_i2c_get_bus(&soc->i2c, 10), 0x50, 128 * KiB);
 
     i2c_slave_create_simple(aspeed_i2c_get_bus(&soc->i2c, 11), TYPE_TMP105,

-- 
2.53.0-Meta


