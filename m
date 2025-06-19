Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DA92AC7115A
	for <qemu-devel@archiver.kernel.org>; Thu, 19 Jun 2025 15:15:53 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uSGyv-0001UV-Tm; Thu, 19 Jun 2025 11:15:13 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <patrick@stwcx.xyz>)
 id 1uSGyp-0001R8-Ls; Thu, 19 Jun 2025 11:15:07 -0400
Received: from fout-a1-smtp.messagingengine.com ([103.168.172.144])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <patrick@stwcx.xyz>)
 id 1uSGym-0001Yf-JL; Thu, 19 Jun 2025 11:15:07 -0400
Received: from phl-compute-08.internal (phl-compute-08.phl.internal
 [10.202.2.48])
 by mailfout.phl.internal (Postfix) with ESMTP id AF29D13804AC;
 Thu, 19 Jun 2025 11:15:02 -0400 (EDT)
Received: from phl-mailfrontend-02 ([10.202.2.163])
 by phl-compute-08.internal (MEProxy); Thu, 19 Jun 2025 11:15:02 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=stwcx.xyz; h=cc
 :cc:content-transfer-encoding:content-type:date:date:from:from
 :in-reply-to:message-id:mime-version:reply-to:subject:subject:to
 :to; s=fm3; t=1750346102; x=1750432502; bh=QvcUB4yUJB1SD6RVv0eDS
 rRzlaQqRFyfQFi2+P2SIpg=; b=WHQYrBxrSxsFaLa7JZyG3xkpUMV7c49nW70Ac
 Y2hOrZQe6SObNwl542n9d6ePHYuiJUVR4/vgY7jP31kpO9mHeRpzJdIV/pUMUr3A
 zYEej1d4GBnIwIFImtIzANttMy8QRlFd1Murwx5Pyye0+11yNNVi6BHYwNmxXfgQ
 88CrFaFLZrrkHb097Nt8V/m6N1mRZZ/7ehnb6la47IX0XqZzwOtK6Zu9ec91Et+0
 ZIo6EG+Ilf5Vg3lxnSMBbqCFt66LGO2BaAqVAw8pLLBrZQSah7Fwt9EpBBgMLtr5
 hmPHlK6VC0Q6hpxP0N8DngBL713ez+jIhn62mmjXMDVvrG2mw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:cc:content-transfer-encoding
 :content-type:date:date:feedback-id:feedback-id:from:from
 :in-reply-to:message-id:mime-version:reply-to:subject:subject:to
 :to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
 1750346102; x=1750432502; bh=QvcUB4yUJB1SD6RVv0eDSrRzlaQqRFyfQFi
 2+P2SIpg=; b=m6j8UvtHZCo3ywfOzIz9c/Jd5seZeXh/CculX82qCAUkNyAujf0
 hvVFnwBL2IF53MN77/v8sgUQkqqN4+QfjWgIVdj8YIltCvX4wXIPjCAbmpZRfcJO
 dXTnlpaW5pIh2DFv9x0j+5U/zLTUnCLenQFCovrNurQooq/7ZUPjr84uT8YykzSG
 h7rJ/N0Rsb4DwMt22d69FpWj2l6Y9kCPmKwMJyE3U/CEO1W5MchgBZyyLjZ3eMJb
 OjkPStzX//PEjpOcyPxhatN+w4vr/hbP/Ooz6VCt2IvRJGmbJAdAqAVKWxWxB/7G
 kC3SPuxqNCM1dIGY6dRzE9x0KdN4EN1WmGg==
X-ME-Sender: <xms:dClUaNstDNi1Txps78RVRAbboVu7MrHyHO3WuopokW22vgCsxvm-Vw>
 <xme:dClUaGdkPGZBKGilNCxOoPjqhevma31PBkAjkk4bK59C6QG7v-aR9gr7gwT1QGOBa
 3p7HC51Tbyjopehvhg>
X-ME-Received: <xmr:dClUaAyiP6LnQBsvUJrEf8jzbz1NBy_RBzXHzx6nWQ1Bor9Y0JT6XYmQlRw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtddvgdehkeehucetufdoteggodetrfdotf
 fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceurghi
 lhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnegfrhhluc
 fvnfffucdlfeehmdenucfjughrpefhvfevufffkffoggfgsedtkeertdertddtnecuhfhr
 ohhmpefrrghtrhhitghkucghihhllhhirghmshcuoehprghtrhhitghksehsthiftgigrd
 ighiiiqeenucggtffrrghtthgvrhhnpedttdevtdegfefggeeuheekgfevkefgteehhedv
 tdekkeefiedutdfhtdffgffhhfenucffohhmrghinhepghhithhhuhgsrdgtohhmnecuve
 hluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepphgrthhrihgt
 khesshhtfigtgidrgiihiidpnhgspghrtghpthhtohepuddupdhmohguvgepshhmthhpoh
 huthdprhgtphhtthhopehpsghonhiiihhnihesrhgvughhrghtrdgtohhmpdhrtghpthht
 ohepphgvthgvrhdrmhgrhiguvghllheslhhinhgrrhhordhorhhgpdhrtghpthhtoheptg
 hlgheskhgrohgurdhorhhgpdhrtghpthhtohepshhtvghvvghnpghlvggvsegrshhpvggv
 ughtvggthhdrtghomhdprhgtphhtthhopehlvggvthhrohihsehgmhgrihhlrdgtohhmpd
 hrtghpthhtohepjhgrmhhinhgplhhinhesrghsphgvvgguthgvtghhrdgtohhmpdhrtghp
 thhtoheprghnughrvgifsegtohguvggtohhnshhtrhhutghtrdgtohhmrdgruhdprhgtph
 htthhopehjohgvlhesjhhmshdrihgurdgruhdprhgtphhtthhopehprghtrhhitghksehs
 thiftgigrdighiii
X-ME-Proxy: <xmx:dClUaEMzolBB-DS1gr_sQSnf329RAhxr1bTZsTVkhFYHGFjDoaQ70A>
 <xmx:dClUaN_JJae4LGv9pF22FioiTQSTGHBnArfyCBFCOMi7ENvgm_exvw>
 <xmx:dClUaEXq7xrMb3oDdw-q37-nI3evSW5By5vRjP3AZGcWjI6GQgTNsg>
 <xmx:dClUaOdO2kSRpBgkLAxsc8JSxvTcxQRPO6iIW4h-1ltLnzkOOKnpwQ>
 <xmx:dilUaHjFTqBUdBCsJZqIjjJ6hic7WRv5CpFHzck7F7lzoXeloGhCIxFF>
Feedback-ID: i68a1478a:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 19 Jun 2025 11:14:59 -0400 (EDT)
From: Patrick Williams <patrick@stwcx.xyz>
To: Paolo Bonzini <pbonzini@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>,
 Steven Lee <steven_lee@aspeedtech.com>, Troy Lee <leetroy@gmail.com>,
 Jamin Lin <jamin_lin@aspeedtech.com>,
 Andrew Jeffery <andrew@codeconstruct.com.au>, Joel Stanley <joel@jms.id.au>
Cc: Patrick Williams <patrick@stwcx.xyz>, qemu-arm@nongnu.org,
 qemu-devel@nongnu.org
Subject: [PATCH v2] hw/arm/aspeed: add Catalina machine type
Date: Thu, 19 Jun 2025 11:14:58 -0400
Message-ID: <20250619151458.2831859-1-patrick@stwcx.xyz>
X-Mailer: git-send-email 2.49.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=103.168.172.144; envelope-from=patrick@stwcx.xyz;
 helo=fout-a1-smtp.messagingengine.com
X-Spam_score_int: 17
X-Spam_score: 1.7
X-Spam_bar: +
X-Spam_report: (1.7 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1, DKIM_VALID=-0.1,
 DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FROM_SUSPICIOUS_NTLD=0.499,
 FROM_SUSPICIOUS_NTLD_FP=1.999, PDS_OTHER_BAD_TLD=1.999, RCVD_IN_DNSWL_LOW=-0.7,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=no autolearn_force=no
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

Add the 'catalina-bmc' machine type based on the kernel DTS[1] as of
6.16-rc2.  The i2c model is as complete as the current QEMU models
support, but in some cases I substituted devices that are close enough
for present functionality.  Strap registers are were verified with
hardware.

This has been tested with an openbmc image built from [2].

Add a functional test in line with Bletchley, pointing at an image
obtained from the OpenBMC Jenkins server.

[1]: https://github.com/torvalds/linux/blob/v6.16-rc2/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-catalina.dts
[2]: https://github.com/openbmc/openbmc/commit/5bc73ec261f981d5e586bda5ac78eb0cbd5f92b0

Signed-off-by: Patrick Williams <patrick@stwcx.xyz>
---
 hw/arm/Kconfig                               |   1 +
 hw/arm/aspeed.c                              | 200 +++++++++++++++++++
 tests/functional/meson.build                 |   2 +
 tests/functional/test_arm_aspeed_catalina.py |  25 +++
 4 files changed, 228 insertions(+)
 create mode 100755 tests/functional/test_arm_aspeed_catalina.py

diff --git a/hw/arm/Kconfig b/hw/arm/Kconfig
index f543d944c3..6ea86534d5 100644
--- a/hw/arm/Kconfig
+++ b/hw/arm/Kconfig
@@ -532,6 +532,7 @@ config ASPEED_SOC
     select I2C
     select DPS310
     select PCA9552
+    select PCA9554
     select SERIAL_MM
     select SMBUS_EEPROM
     select PCA954X
diff --git a/hw/arm/aspeed.c b/hw/arm/aspeed.c
index d0b333646e..b0965ef8a0 100644
--- a/hw/arm/aspeed.c
+++ b/hw/arm/aspeed.c
@@ -19,6 +19,7 @@
 #include "hw/i2c/i2c_mux_pca954x.h"
 #include "hw/i2c/smbus_eeprom.h"
 #include "hw/gpio/pca9552.h"
+#include "hw/gpio/pca9554.h"
 #include "hw/nvram/eeprom_at24c.h"
 #include "hw/sensor/tmp105.h"
 #include "hw/misc/led.h"
@@ -1003,6 +1004,180 @@ static void fuji_bmc_i2c_init(AspeedMachineState *bmc)
 }
 
 #define TYPE_TMP421 "tmp421"
+#define TYPE_DS1338 "ds1338"
+
+/* Catalina hardware value */
+#define CATALINA_BMC_HW_STRAP1 0x00002002
+#define CATALINA_BMC_HW_STRAP2 0x00000800
+
+#define CATALINA_BMC_RAM_SIZE ASPEED_RAM_SIZE(2 * GiB)
+
+static void catalina_bmc_i2c_init(AspeedMachineState *bmc)
+{
+    /* Reference from v6.16-rc2 aspeed-bmc-facebook-catalina.dts */
+
+    AspeedSoCState *soc = bmc->soc;
+    I2CBus *i2c[16] = {};
+    I2CSlave *i2c_mux;
+
+    /* busses 0-15 are all used. */
+    for (int i = 0; i < ARRAY_SIZE(i2c); i++) {
+        i2c[i] = aspeed_i2c_get_bus(&soc->i2c, i);
+    }
+
+    /* &i2c0 */
+    /* i2c-mux@71 (PCA9546) on i2c0 */
+    i2c_slave_create_simple(i2c[0], TYPE_PCA9546, 0x71);
+
+    /* i2c-mux@72 (PCA9546) on i2c0 */
+    i2c_mux = i2c_slave_create_simple(i2c[0], TYPE_PCA9546, 0x72);
+
+    /* i2c0mux1ch1 */
+    /* io_expander7 - pca9535@20 */
+    i2c_slave_create_simple(pca954x_i2c_get_bus(i2c_mux, 1),
+                            TYPE_PCA9552, 0x20);
+    /* eeprom@50 */
+    at24c_eeprom_init(pca954x_i2c_get_bus(i2c_mux, 1), 0x50, 8 * KiB);
+
+    /* i2c-mux@73 (PCA9546) on i2c0 */
+    i2c_slave_create_simple(i2c[0], TYPE_PCA9546, 0x73);
+
+    /* i2c-mux@75 (PCA9546) on i2c0 */
+    i2c_slave_create_simple(i2c[0], TYPE_PCA9546, 0x75);
+
+    /* i2c-mux@76 (PCA9546) on i2c0 */
+    i2c_mux = i2c_slave_create_simple(i2c[0], TYPE_PCA9546, 0x76);
+
+    /* i2c0mux4ch1 */
+    /* io_expander8 - pca9535@21 */
+    i2c_slave_create_simple(pca954x_i2c_get_bus(i2c_mux, 1),
+                            TYPE_PCA9552, 0x21);
+    /* eeprom@50 */
+    at24c_eeprom_init(pca954x_i2c_get_bus(i2c_mux, 1), 0x50, 8 * KiB);
+
+    /* i2c-mux@77 (PCA9546) on i2c0 */
+    i2c_slave_create_simple(i2c[0], TYPE_PCA9546, 0x77);
+
+
+    /* &i2c1 */
+    /* i2c-mux@70 (PCA9548) on i2c1 */
+    i2c_mux = i2c_slave_create_simple(i2c[1], TYPE_PCA9548, 0x70);
+    /* i2c1mux0ch0 */
+    /* ina238@41 - no model */
+    /* ina238@42 - no model */
+    /* ina238@44 - no model */
+    /* i2c1mux0ch1 */
+    /* ina238@41 - no model */
+    /* ina238@43 - no model */
+    /* i2c1mux0ch4 */
+    /* ltc4287@42 - no model */
+    /* ltc4287@43 - no model */
+
+    /* i2c1mux0ch5 */
+    /* eeprom@54 */
+    at24c_eeprom_init(pca954x_i2c_get_bus(i2c_mux, 5), 0x54, 8 * KiB);
+    /* tpm75@4f */
+    i2c_slave_create_simple(pca954x_i2c_get_bus(i2c_mux, 5), TYPE_TMP75, 0x4f);
+
+    /* i2c1mux0ch6 */
+    /* io_expander5 - pca9554@27 */
+    i2c_slave_create_simple(pca954x_i2c_get_bus(i2c_mux, 6),
+                            TYPE_PCA9554, 0x27);
+    /* io_expander6 - pca9555@25 */
+    i2c_slave_create_simple(pca954x_i2c_get_bus(i2c_mux, 6),
+                            TYPE_PCA9552, 0x25);
+    /* eeprom@51 */
+    at24c_eeprom_init(pca954x_i2c_get_bus(i2c_mux, 6), 0x51, 8 * KiB);
+
+    /* i2c1mux0ch7 */
+    /* eeprom@53 */
+    at24c_eeprom_init(pca954x_i2c_get_bus(i2c_mux, 7), 0x53, 8 * KiB);
+    /* temperature-sensor@4b - tmp75 */
+    i2c_slave_create_simple(pca954x_i2c_get_bus(i2c_mux, 7), TYPE_TMP75, 0x4b);
+
+    /* &i2c2 */
+    /* io_expander0 - pca9555@20 */
+    i2c_slave_create_simple(i2c[2], TYPE_PCA9552, 0x20);
+    /* io_expander0 - pca9555@21 */
+    i2c_slave_create_simple(i2c[2], TYPE_PCA9552, 0x21);
+    /* io_expander0 - pca9555@27 */
+    i2c_slave_create_simple(i2c[2], TYPE_PCA9552, 0x27);
+    /* eeprom@50 */
+    at24c_eeprom_init(i2c[2], 0x50, 8 * KiB);
+    /* eeprom@51 */
+    at24c_eeprom_init(i2c[2], 0x51, 8 * KiB);
+
+    /* &i2c5 */
+    /* i2c-mux@70 (PCA9548) on i2c5 */
+    i2c_mux = i2c_slave_create_simple(i2c[5], TYPE_PCA9548, 0x70);
+    /* i2c5mux0ch6 */
+    /* eeprom@52 */
+    at24c_eeprom_init(pca954x_i2c_get_bus(i2c_mux, 6), 0x52, 8 * KiB);
+    /* i2c5mux0ch7 */
+    /* ina230@40 - no model */
+    /* ina230@41 - no model */
+    /* ina230@44 - no model */
+    /* ina230@45 - no model */
+
+    /* &i2c6 */
+    /* io_expander3 - pca9555@21 */
+    i2c_slave_create_simple(i2c[6], TYPE_PCA9552, 0x21);
+    /* rtc@6f - nct3018y */
+    i2c_slave_create_simple(i2c[6], TYPE_DS1338, 0x6f);
+
+    /* &i2c9 */
+    /* io_expander4 - pca9555@4f */
+    i2c_slave_create_simple(i2c[9], TYPE_PCA9552, 0x4f);
+    /* temperature-sensor@4b - tpm75 */
+    i2c_slave_create_simple(i2c[9], TYPE_TMP75, 0x4b);
+    /* eeprom@50 */
+    at24c_eeprom_init(i2c[9], 0x50, 8 * KiB);
+    /* eeprom@56 */
+    at24c_eeprom_init(i2c[9], 0x56, 8 * KiB);
+
+    /* &i2c10 */
+    /* temperature-sensor@1f - tpm421 */
+    i2c_slave_create_simple(i2c[10], TYPE_TMP421, 0x1f);
+    /* eeprom@50 */
+    at24c_eeprom_init(i2c[10], 0x50, 8 * KiB);
+
+    /* &i2c11 */
+    /* ssif-bmc@10 - no model */
+
+    /* &i2c12 */
+    /* eeprom@50 */
+    at24c_eeprom_init(i2c[12], 0x50, 8 * KiB);
+
+    /* &i2c13 */
+    /* eeprom@50 */
+    at24c_eeprom_init(i2c[13], 0x50, 8 * KiB);
+    /* eeprom@54 */
+    at24c_eeprom_init(i2c[13], 0x54, 256);
+    /* eeprom@55 */
+    at24c_eeprom_init(i2c[13], 0x55, 256);
+    /* eeprom@57 */
+    at24c_eeprom_init(i2c[13], 0x57, 256);
+
+    /* &i2c14 */
+    /* io_expander9 - pca9555@10 */
+    i2c_slave_create_simple(i2c[14], TYPE_PCA9552, 0x10);
+    /* io_expander10 - pca9555@11 */
+    i2c_slave_create_simple(i2c[14], TYPE_PCA9552, 0x11);
+    /* io_expander11 - pca9555@12 */
+    i2c_slave_create_simple(i2c[14], TYPE_PCA9552, 0x12);
+    /* io_expander12 - pca9555@13 */
+    i2c_slave_create_simple(i2c[14], TYPE_PCA9552, 0x13);
+    /* io_expander13 - pca9555@14 */
+    i2c_slave_create_simple(i2c[14], TYPE_PCA9552, 0x14);
+    /* io_expander14 - pca9555@15 */
+    i2c_slave_create_simple(i2c[14], TYPE_PCA9552, 0x15);
+
+    /* &i2c15 */
+    /* temperature-sensor@1f - tmp421 */
+    i2c_slave_create_simple(i2c[15], TYPE_TMP421, 0x1f);
+    /* eeprom@52 */
+    at24c_eeprom_init(i2c[15], 0x52, 8 * KiB);
+}
 
 static void bletchley_bmc_i2c_init(AspeedMachineState *bmc)
 {
@@ -1585,6 +1760,27 @@ static void aspeed_machine_bletchley_class_init(ObjectClass *oc,
     aspeed_machine_class_init_cpus_defaults(mc);
 }
 
+static void aspeed_machine_catalina_class_init(ObjectClass *oc,
+                                               const void *data)
+{
+    MachineClass *mc = MACHINE_CLASS(oc);
+    AspeedMachineClass *amc = ASPEED_MACHINE_CLASS(oc);
+
+    mc->desc       = "Facebook Catalina BMC (Cortex-A7)";
+    amc->soc_name  = "ast2600-a3";
+    amc->hw_strap1 = CATALINA_BMC_HW_STRAP1;
+    amc->hw_strap2 = CATALINA_BMC_HW_STRAP2;
+    amc->fmc_model = "w25q01jvq";
+    amc->spi_model = NULL;
+    amc->num_cs    = 2;
+    amc->macs_mask = ASPEED_MAC2_ON;
+    amc->i2c_init  = catalina_bmc_i2c_init;
+    mc->auto_create_sdcard = true;
+    mc->default_ram_size = CATALINA_BMC_RAM_SIZE;
+    aspeed_machine_class_init_cpus_defaults(mc);
+    aspeed_machine_ast2600_class_emmc_init(oc);
+}
+
 static void fby35_reset(MachineState *state, ResetType type)
 {
     AspeedMachineState *bmc = ASPEED_MACHINE(state);
@@ -1877,6 +2073,10 @@ static const TypeInfo aspeed_machine_types[] = {
         .name          = MACHINE_TYPE_NAME("bletchley-bmc"),
         .parent        = TYPE_ASPEED_MACHINE,
         .class_init    = aspeed_machine_bletchley_class_init,
+    }, {
+        .name          = MACHINE_TYPE_NAME("catalina-bmc"),
+        .parent        = TYPE_ASPEED_MACHINE,
+        .class_init    = aspeed_machine_catalina_class_init,
     }, {
         .name          = MACHINE_TYPE_NAME("fby35-bmc"),
         .parent        = MACHINE_TYPE_NAME("ast2600-evb"),
diff --git a/tests/functional/meson.build b/tests/functional/meson.build
index e9f19d54a2..11c32a8529 100644
--- a/tests/functional/meson.build
+++ b/tests/functional/meson.build
@@ -31,6 +31,7 @@ test_timeouts = {
   'arm_aspeed_ast2500' : 720,
   'arm_aspeed_ast2600' : 1200,
   'arm_aspeed_bletchley' : 480,
+  'arm_aspeed_catalina' : 480,
   'arm_aspeed_rainier' : 480,
   'arm_bpim2u' : 500,
   'arm_collie' : 180,
@@ -124,6 +125,7 @@ tests_arm_system_thorough = [
   'arm_aspeed_ast2500',
   'arm_aspeed_ast2600',
   'arm_aspeed_bletchley',
+  'arm_aspeed_catalina',
   'arm_aspeed_rainier',
   'arm_bpim2u',
   'arm_canona1100',
diff --git a/tests/functional/test_arm_aspeed_catalina.py b/tests/functional/test_arm_aspeed_catalina.py
new file mode 100755
index 0000000000..dc2f24e7b4
--- /dev/null
+++ b/tests/functional/test_arm_aspeed_catalina.py
@@ -0,0 +1,25 @@
+#!/usr/bin/env python3
+#
+# Functional test that boots the ASPEED machines
+#
+# SPDX-License-Identifier: GPL-2.0-or-later
+
+from qemu_test import Asset
+from aspeed import AspeedTest
+
+
+class CatalinaMachine(AspeedTest):
+
+    ASSET_CATALINA_FLASH = Asset(
+        'https://github.com/legoater/qemu-aspeed-boot/raw/a866feb5ef81245b4827a214584bf6bcc72939f6/images/catalina-bmc/obmc-phosphor-image-catalina-20250619123021.static.mtd.xz',
+        '287402e1ba021991e06be1d098f509444a02a3d81a73a932f66528b159e864f9')
+
+    def test_arm_ast2600_catalina_openbmc(self):
+        image_path = self.uncompress(self.ASSET_CATALINA_FLASH)
+
+        self.do_test_arm_aspeed_openbmc('catalina-bmc', image=image_path,
+                                        uboot='2019.04', cpu_id='0xf00',
+                                        soc='AST2600 rev A3')
+
+if __name__ == '__main__':
+    AspeedTest.main()
-- 
2.49.0


