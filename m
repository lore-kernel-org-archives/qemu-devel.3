Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2C275CCA462
	for <qemu-devel@archiver.kernel.org>; Thu, 15 Oct 2026 15:12:43 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xHN7D-0007Kc-G7; Thu, 15 Oct 2026 11:11:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eblot.ml@gmail.com>)
 id 1xHN7B-0007He-N3
 for qemu-devel@nongnu.org; Thu, 15 Oct 2026 11:11:29 -0400
Received: from mail-wm1-f51.google.com ([209.85.128.51])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <eblot.ml@gmail.com>)
 id 1xHN78-0001lB-Gf
 for qemu-devel@nongnu.org; Thu, 15 Oct 2026 11:11:29 -0400
Received: by mail-wm1-f51.google.com with SMTP id
 5b1f17b1804b1-4a018792ab3so43975585e9.0
 for <qemu-devel@nongnu.org>; Thu, 15 Oct 2026 08:11:26 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792077085; x=1792681885;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=174P2+r/v6oMnNkGCAQKO8WuiRU63QW9ctJQj0TLd14=;
 b=XUfgtrDfpASfJTSNSYcXFQao97Ez3oyLjkKM1nDkdqNmGA9RXE/L3k7fTxjoVeNCrs
 YTqbYmR1xdMoQckJHOfB8pKKciM3ubk9xZEvcAVMFdstYUzl/CTSWHnPNKj/UdELS742
 DoFbetwnkaB7wRUxt7G0kl+TLwr7OCIguhL7vGITdWU1dsfCQhskTi6X+FanzYx5YW/j
 OlIvkjPJ1YBB1moPy40ezS7zuCho38S8c5WfEc2is5vXpzUsEoBg9//xWsHPXeijs/mp
 03Cm16lZQRrgygexwcTConZQJZHPfa0Irc67ZjGYCVB49Xm4I2visJVFgC6HXpTExSTQ
 0uPg==
X-Gm-Message-State: AFq9FYIHybZ2MmXZ0ZqBQ7fKLexAkFjezb3ZmwfZbWjFWw4jI6vKS/2I
 18ikIVtEEY+Rifgt6ihVriwledov1KbmqMIa/SXE9wpw0qVsBt+aTK8ahEdQYg==
X-Gm-Gg: AYBFou3Z5/YGdyuSLAqiVtKVBo6763h2EGm60CyVU9zvS/NKc6quV2NbICApWI/DgiD
 aFwVf9SEXIwnk5Wgs8DO1mB2yoWGhMcKbaRXG6bBkz5gGjS3Gr4hJgZ7rhtdBSbC00tl0M8V7pg
 C1vzDNOOk0cvSqRYu8Wswbrd7FiI/7bZAxWqmGVxsvmICdh7PGOOKUtR7m1AAadmG6ThiZsoxL8
 siiXDWmqC/wzGSsVTRNAt366MI6JFmah1Vq/xHw4xcxEd4GvzGdaAe1L9R8gbMQYCRFKeu53INq
 2/FuoWI3PA7Gt+zxXrTRm/0Owq6GAEHFq5D+sydvPde0eYsVxD5em8bDPACGQsBDaH5eX+IOtva
 kltX0kjA2fQll8OxvDwYvKeqItCOYr19l5FkUuY8RSxU4e/tgyLexVzQZ46/5NirsnYCQnPs93/
 +ef74MpSAUqVk+p49YEPY+la2FSxO6gQC5d0ZVXFskL1v32Xe71tqMa1Xgbt/m5kA8DbwtiyTSq
 b58I+tQ52/bv92cj0Gjbm5d+iAJ5Rh1q93ZWtnV1Nyb5A==
X-Received: by 2002:a05:600c:6749:b0:4a0:1a7f:2abf with SMTP id
 5b1f17b1804b1-4a18e49d633mr384520705e9.7.1792077084933; 
 Thu, 15 Oct 2026 08:11:24 -0700 (PDT)
Received: from localhost (89-93-216-19.hfc.dyn.abo.bbox.fr. [89.93.216.19])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4a1bd98637asm80447505e9.8.2026.10.15.08.11.18
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 15 Oct 2026 08:11:20 -0700 (PDT)
Date: Thu, 15 Oct 2026 13:57:49 +0200
Subject: [PATCH 11/22] hw/arm/aspeed: use the TMP421 type-name macros
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261015-bmc-clemente-v1-11-bf591886b5b6@free.fr>
References: <20261015-bmc-clemente-v1-0-bf591886b5b6@free.fr>
In-Reply-To: <20261015-bmc-clemente-v1-0-bf591886b5b6@free.fr>
To: qemu-devel@nongnu.org
Cc: =?utf-8?q?Philippe_Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>, 
 =?utf-8?q?C=C3=A9dric_Le_Goater?= <clg@kaod.org>, 
 Peter Maydell <peter.maydell@linaro.org>, 
 Steven Lee <steven_lee@aspeedtech.com>, Troy Lee <leetroy@gmail.com>, 
 Jamin Lin <jamin_lin@aspeedtech.com>, Kane Chen <kane_chen@aspeedtech.com>, 
 Andrew Jeffery <andrew@codeconstruct.com.au>, Joel Stanley <joel@jms.id.au>, 
 qemu-arm@nongnu.org, Fabiano Rosas <farosas@suse.de>, 
 Laurent Vivier <lvivier@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, 
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>, 
 Emmanuel Blot <emmanuel.blot@free.fr>
X-Mailer: b4 0.16.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1792065465; l=11877;
 i=emmanuel.blot@free.fr; s=20260602; h=from:subject:message-id;
 bh=AEPhqDqJmrBwOAvfk44breSxS4/rhsDd7PB3uTZuSRk=;
 b=mCSqJjzbWCo+VzX9PF5BUp1xmJZRo884HH2X6yZl6j0DMMAbhP2vR86S67njze4Pz9oH1iHk0
 T48qs4YDznBAk9ivYCP1/eDPSD/VyKyWFOCrZqJFRhEL0kYSwd4eqfq
X-Developer-Key: i=emmanuel.blot@free.fr; a=ed25519;
 pk=0qFrZ21FAAN8OfVsSoVcCFTk/NMYOWzxJz4paSAVm0g=
Received-SPF: pass client-ip=209.85.128.51; envelope-from=eblot.ml@gmail.com;
 helo=mail-wm1-f51.google.com
X-Spam_score_int: 0
X-Spam_score: -0.1
X-Spam_bar: /
X-Spam_report: (-0.1 / 5.0 requ) BAYES_00=-1.9, DATE_IN_PAST_03_06=1.592,
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

Include the new tmp421.h and refer to the sensor variants through
TYPE_TMP421/TYPE_TMP422/TYPE_TMP423 instead of open-coded string
literals and per-board local defines.

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


