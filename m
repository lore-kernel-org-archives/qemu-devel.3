Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F038606A32E
	for <qemu-devel@archiver.kernel.org>; Thu,  5 Nov 2026 09:16:28 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xOtZZ-00006f-PV; Thu, 05 Nov 2026 04:15:53 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eblot.ml@gmail.com>)
 id 1xOtYe-00066A-Md
 for qemu-devel@nongnu.org; Thu, 05 Nov 2026 04:14:58 -0500
Received: from mail-pf1-f170.google.com ([209.85.210.170])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <eblot.ml@gmail.com>)
 id 1xOtYc-0005WC-JO
 for qemu-devel@nongnu.org; Thu, 05 Nov 2026 04:14:56 -0500
Received: by mail-pf1-f170.google.com with SMTP id
 d2e1a72fcca58-8a064fac8cbso1292427b3a.1
 for <qemu-devel@nongnu.org>; Thu, 05 Nov 2026 01:14:54 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793870093; x=1794474893;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=WqbZUjEcz/I/D1nVZz+I6I8/ReCtwIeQack+dKdCEoE=;
 b=plYLVOgvIYDPf9hl2MC5WXPVEqoq1zpj1R48k6Anko1724G3P3s1Byq9Y7S2XaSaoV
 j1W0VEpT/17dpC/dEVdRvjoBYMujbyRR7ssuc8JmwkZCwGQTkW0IHb0D1emUhjYU0Nl3
 /KPxY4pOk1mIZR3bVddROchHh01zkxYlP2vQSjMAaLH9v1uGbL2tc+tnm/+j0rkdESXL
 9KH3EV2HyBBg8wzy6wumA0LGsmSSLlZ3wzEfCvre/J65CBpABwiHoeKOz4BBiIigc2zv
 z1dmI2J/RJCU7P54qhx/85XPtG2kF+NsCiUoV55TYT4Qq9h/rMPx+Z3DNKewHbMrEF9C
 uMtA==
X-Gm-Message-State: APuU4Z+MGVetF7Vnv5Jumak8Vx9sKnvMEzFtslkhu1WNgpCNIhl67TOX
 wktVRa8QBtbaN6OUPL/CtzTnzw01Ffv+a9/BTpqDiJ9mfW+WXx/QOdrnBuY9RgOL21Q=
X-Gm-Gg: AYBFou2uGKwZ5Deu8C3mQ8TmFPna+26JEFrmxclsbwBy2wp0zmD12QNYgPJ9Ajswggu
 BpGhcUOFvD9nO1zstUnAVzlbySCNUcq3S6YuCMOzoXczwONia/D6z0T6fQgwpEoyIUmlJHlgbgc
 T95isQryeTV8AKp208o7pHqlXdQ5zNB8Q4ZhZWRTVwYyStAPl+9kXdgtJQK+WQYHkgWYvmv4jiH
 Ps32vPCqhtiQrVqfbLX7sxxA0f80GNIC2Fp20rLfdEKqI/3QS0dqixtH5Z/gDE2cmmyv89A13Uw
 D886vCPslJJSNuoqeCivBdLamdBBSyIZTp1XzHlORbd3NEDIKftGf9U4rEZm62a/28krUWOb+ZP
 K9gjDraf93sC5YMcuB01qBAYOSREL+IbBhVp3eSCSGPVh3p+w9+mHXSqRv4PmmR9Ca+4jVKkdyE
 UH9WpqEjLVaGd2Xll3KGV2JNhSGA8BFIT0Oy09Y33AJSFBgQgCnjZfUMh5qWMDIs0t8gCTySRS4
 PnV2GPJsOykAg42ECMEI/mEcC5YPxVopn+g9xIf1QN3Qj+zOTdfkF+SSedXRXEYbHsbBDxTW7fu
 CKNNx/8FLoaOM+yze9zMmw7JVp4aK23C41QqLID5UxX6qTdSC5OTMktG7df7lUa8m3R0po3/tCM
 JJVp6gS/oUtPUeLGm3RWSx/3bEX8=
X-Received: by 2002:a05:6a21:150c:b0:3de:557e:5ea6 with SMTP id
 adf61e73a8af0-3e9289859d6mr15607994637.27.1793870093106; 
 Thu, 05 Nov 2026 01:14:53 -0800 (PST)
Received: from localhost (118-163-122-149.hinet-ip.hinet.net.
 [118.163.122.149]) by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-cdb46972143sm1863673a12.22.2026.11.05.01.14.50
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 05 Nov 2026 01:14:51 -0800 (PST)
Date: Thu, 05 Nov 2026 17:13:02 +0800
Subject: [PATCH 10/16] tests/qtest: ina238: add current/voltage/power
 monitor test
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261105-sensor-ina23x-v1-10-5433ed104990@free.fr>
References: <20261105-sensor-ina23x-v1-0-5433ed104990@free.fr>
In-Reply-To: <20261105-sensor-ina23x-v1-0-5433ed104990@free.fr>
To: qemu-devel@nongnu.org
Cc: =?utf-8?q?C=C3=A9dric_Le_Goater?= <clg@kaod.org>, eblot@meta.com, 
 Paolo Bonzini <pbonzini@redhat.com>, 
 Peter Maydell <peter.maydell@linaro.org>, 
 =?utf-8?q?Philippe_Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>, 
 qemu-arm@nongnu.org, Fabiano Rosas <farosas@suse.de>, 
 Laurent Vivier <lvivier@redhat.com>, Emmanuel Blot <emmanuel.blot@free.fr>, 
 Glenn Miles <milesg@linux.ibm.com>
X-Mailer: b4 0.16.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1793869976; l=7751;
 i=emmanuel.blot@free.fr; s=20260602; h=from:subject:message-id;
 bh=rF9YxoN8ES1gaJVSzaclqYjGbIV9qLP30Q9j6d+MnNc=;
 b=5r4TWHTWowFiz+3zBq4OpO6zgxzG4YzMfl2xXD1P94CTTfbfOmc+LYy0dk0m8/DC2SonSnRFX
 A7hM2MjcT4wAf80gC4101HO+QZrfc7a4YVFx20UM976ubTyogPiZe/+
X-Developer-Key: i=emmanuel.blot@free.fr; a=ed25519;
 pk=0qFrZ21FAAN8OfVsSoVcCFTk/NMYOWzxJz4paSAVm0g=
Received-SPF: pass client-ip=209.85.210.170; envelope-from=eblot.ml@gmail.com;
 helo=mail-pf1-f170.google.com
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
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Introduce the INA238 qtest: the qgraph node, the QMP injection helpers
and the register map. Cover the reset defaults, the software reset, and
the Configuration register write mask.

Reviewed-by: Glenn Miles <milesg@linux.ibm.com>
Signed-off-by: Emmanuel Blot <emmanuel.blot@free.fr>
---
 tests/qtest/ina238-test.c | 177 ++++++++++++++++++++++++++++++++++++++++++++++
 tests/qtest/meson.build   |   1 +
 2 files changed, 178 insertions(+)

diff --git a/tests/qtest/ina238-test.c b/tests/qtest/ina238-test.c
new file mode 100644
index 0000000000..6e59ed30b5
--- /dev/null
+++ b/tests/qtest/ina238-test.c
@@ -0,0 +1,177 @@
+/*
+ * QTest testcase for the INA238 current/voltage/power monitor
+ *
+ * Copyright (c) 2026 Meta Platforms, Inc. and affiliates.
+ *
+ * SPDX-License-Identifier: GPL-2.0-or-later
+ */
+
+#include "qemu/osdep.h"
+#include "libqos/i2c.h"
+#include "libqos/qgraph.h"
+#include "libqtest-single.h"
+#include "qobject/qdict.h"
+
+#define INA238_TEST_ID      "ina238-test"
+#define INA238_TEST_ADDR    0x40
+
+/* Register pointer addresses */
+#define REG_CONFIG          0x00
+#define REG_ADC_CONFIG      0x01
+#define REG_SHUNT_CAL       0x02
+#define REG_VSHUNT          0x04
+#define REG_VBUS            0x05
+#define REG_DIETEMP         0x06
+#define REG_CURRENT         0x07
+#define REG_POWER           0x08
+#define REG_DIAG_ALRT       0x0B
+#define REG_SOVL            0x0C
+#define REG_SUVL            0x0D
+#define REG_BOVL            0x0E
+#define REG_BUVL            0x0F
+#define REG_TEMP_LIMIT      0x10
+#define REG_PWR_LIMIT       0x11
+#define REG_MANUFACTURER_ID 0x3E
+#define REG_DEVICE_ID       0x3F
+
+/* Configuration register bits */
+#define CONFIG_RST          0x8000
+#define CONFIG_ADCRANGE     0x0010
+
+/* DIAG_ALRT register bits */
+#define DIAG_MEMSTAT        0x0001
+#define DIAG_CNVRF          0x0002
+#define DIAG_POL            0x0004
+#define DIAG_BUSUL          0x0008
+#define DIAG_BUSOL          0x0010
+#define DIAG_SHNTUL         0x0020
+#define DIAG_SHNTOL         0x0040
+#define DIAG_TMPOL          0x0080
+#define DIAG_MATHOF         0x0200
+#define DIAG_APOL           0x1000
+#define DIAG_SLOWALERT      0x2000
+#define DIAG_CNVR           0x4000
+#define DIAG_ALATCH         0x8000
+
+/* Reset values */
+#define CONFIG_POR          0x0000
+#define ADC_CONFIG_POR      0xFB68
+#define SHUNT_CAL_POR       0x1000
+#define DIAG_ALRT_POR       0x0001
+#define SOVL_POR            0x7FFF
+#define SUVL_POR            0x8000
+#define BOVL_POR            0x7FFF
+#define BUVL_POR            0x0000
+#define TEMP_LIMIT_POR      0x7FF0
+#define PWR_LIMIT_POR       0xFFFF
+#define MANUFACTURER_ID_VAL 0x5449
+#define DEVICE_ID_VAL       0x2381
+
+/* Read the 24-bit POWER register (MSB first) */
+static uint32_t i2c_get24(QI2CDevice *dev, uint8_t reg)
+{
+    uint8_t resp[3];
+
+    i2c_read_block(dev, reg, resp, sizeof(resp));
+    return (resp[0] << 16) | (resp[1] << 8) | resp[2];
+}
+
+/* QMP helpers for injecting the physical inputs */
+
+static void qmp_ina238_set(const char *property, int value)
+{
+    QDict *resp;
+
+    resp = qmp("{ 'execute': 'qom-set', 'arguments':"
+               " { 'path': %s, 'property': %s, 'value': %d } }",
+               INA238_TEST_ID, property, value);
+    g_assert(qdict_haskey(resp, "return"));
+    qobject_unref(resp);
+}
+
+/* Power-on-reset default values and the ID registers */
+static void test_defaults(void *obj, void *data, QGuestAllocator *alloc)
+{
+    QI2CDevice *dev = (QI2CDevice *)obj;
+
+    g_assert_cmphex(i2c_get16(dev, REG_CONFIG), ==, CONFIG_POR);
+    g_assert_cmphex(i2c_get16(dev, REG_ADC_CONFIG), ==, ADC_CONFIG_POR);
+    g_assert_cmphex(i2c_get16(dev, REG_SHUNT_CAL), ==, SHUNT_CAL_POR);
+    g_assert_cmphex(i2c_get16(dev, REG_VSHUNT), ==, 0x0000);
+    g_assert_cmphex(i2c_get16(dev, REG_VBUS), ==, 0x0000);
+    g_assert_cmphex(i2c_get16(dev, REG_DIETEMP), ==, 0x0000);
+    g_assert_cmphex(i2c_get16(dev, REG_CURRENT), ==, 0x0000);
+    g_assert_cmphex(i2c_get24(dev, REG_POWER), ==, 0x000000);
+    g_assert_cmphex(i2c_get16(dev, REG_DIAG_ALRT), ==, DIAG_ALRT_POR);
+    g_assert_cmphex(i2c_get16(dev, REG_SOVL), ==, SOVL_POR);
+    g_assert_cmphex(i2c_get16(dev, REG_SUVL), ==, SUVL_POR);
+    g_assert_cmphex(i2c_get16(dev, REG_BOVL), ==, BOVL_POR);
+    g_assert_cmphex(i2c_get16(dev, REG_BUVL), ==, BUVL_POR);
+    g_assert_cmphex(i2c_get16(dev, REG_TEMP_LIMIT), ==, TEMP_LIMIT_POR);
+    g_assert_cmphex(i2c_get16(dev, REG_PWR_LIMIT), ==, PWR_LIMIT_POR);
+    g_assert_cmphex(i2c_get16(dev, REG_MANUFACTURER_ID), ==,
+                    MANUFACTURER_ID_VAL);
+    g_assert_cmphex(i2c_get16(dev, REG_DEVICE_ID), ==, DEVICE_ID_VAL);
+}
+
+/* Software reset via the Configuration RST bit */
+static void test_soft_reset(void *obj, void *data, QGuestAllocator *alloc)
+{
+    QI2CDevice *dev = (QI2CDevice *)obj;
+
+    i2c_set16(dev, REG_SHUNT_CAL, 0x1234);
+    i2c_set16(dev, REG_SOVL, 0x0500);
+    i2c_set16(dev, REG_TEMP_LIMIT, 0x0A00);
+    i2c_set16(dev, REG_DIAG_ALRT, DIAG_ALATCH);
+
+    qmp_ina238_set("shunt-voltage", 97200000);
+    qmp_ina238_set("bus-voltage", 48000000);
+    qmp_ina238_set("die-temperature", 25000);
+
+    g_assert_cmphex(i2c_get16(dev, REG_SHUNT_CAL), ==, 0x1234);
+    g_assert_cmphex(i2c_get16(dev, REG_SOVL), ==, 0x0500);
+    g_assert_cmphex(i2c_get16(dev, REG_VSHUNT), ==, 0x4BF0);
+    g_assert_cmpuint(i2c_get16(dev, REG_CURRENT), !=, 0);
+
+    i2c_set16(dev, REG_CONFIG, CONFIG_RST);
+
+    g_assert_cmphex(i2c_get16(dev, REG_CONFIG), ==, CONFIG_POR);
+    g_assert_cmphex(i2c_get16(dev, REG_SHUNT_CAL), ==, SHUNT_CAL_POR);
+    g_assert_cmphex(i2c_get16(dev, REG_SOVL), ==, SOVL_POR);
+    g_assert_cmphex(i2c_get16(dev, REG_TEMP_LIMIT), ==, TEMP_LIMIT_POR);
+    g_assert_cmphex(i2c_get16(dev, REG_DIAG_ALRT), ==, DIAG_ALRT_POR);
+
+    g_assert_cmphex(i2c_get16(dev, REG_VSHUNT), ==, 0x0000);
+    g_assert_cmphex(i2c_get16(dev, REG_VBUS), ==, 0x0000);
+    g_assert_cmphex(i2c_get16(dev, REG_DIETEMP), ==, 0x0000);
+    g_assert_cmphex(i2c_get16(dev, REG_CURRENT), ==, 0x0000);
+    g_assert_cmpuint(i2c_get24(dev, REG_POWER), ==, 0);
+}
+
+/* CONFIG keeps only the writable ADCRANGE/CONVDLY bits and self-clears RST */
+static void test_config_wmask(void *obj, void *data, QGuestAllocator *alloc)
+{
+    QI2CDevice *dev = (QI2CDevice *)obj;
+
+    i2c_set16(dev, REG_CONFIG, CONFIG_ADCRANGE | 0x0040);
+    g_assert_cmphex(i2c_get16(dev, REG_CONFIG), ==, CONFIG_ADCRANGE | 0x0040);
+
+    i2c_set16(dev, REG_CONFIG, CONFIG_RST);
+    g_assert_cmphex(i2c_get16(dev, REG_CONFIG), ==, CONFIG_POR);
+}
+
+static void ina238_register_nodes(void)
+{
+    QOSGraphEdgeOptions opts = {
+        .extra_device_opts = "id=" INA238_TEST_ID ",address=0x40"
+    };
+    add_qi2c_address(&opts, &(QI2CAddress) { INA238_TEST_ADDR });
+
+    qos_node_create_driver("ina238", i2c_device_create);
+    qos_node_consumes("ina238", "i2c-bus", &opts);
+
+    qos_add_test("defaults", "ina238", test_defaults, NULL);
+    qos_add_test("soft-reset", "ina238", test_soft_reset, NULL);
+    qos_add_test("config-wmask", "ina238", test_config_wmask, NULL);
+}
+libqos_init(ina238_register_nodes);
diff --git a/tests/qtest/meson.build b/tests/qtest/meson.build
index bfebe136ef..9b8e2521bf 100644
--- a/tests/qtest/meson.build
+++ b/tests/qtest/meson.build
@@ -339,6 +339,7 @@ qos_test_ss.add(
   'eepro100-test.c',
   'es1370-test.c',
   'ina230-test.c',
+  'ina238-test.c',
   'lsm303dlhc-mag-test.c',
   'isl_pmbus_vr-test.c',
   'max34451-test.c',

-- 
2.53.0-Meta


