Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 613EACA9EDD
	for <qemu-devel@archiver.kernel.org>; Mon, 12 Oct 2026 15:34:33 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xGI2n-0008Km-VJ; Mon, 12 Oct 2026 11:34:30 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eblot.ml@gmail.com>)
 id 1xGI2m-0008Ie-L2
 for qemu-devel@nongnu.org; Mon, 12 Oct 2026 11:34:28 -0400
Received: from mail-wm1-f48.google.com ([209.85.128.48])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <eblot.ml@gmail.com>)
 id 1xGI2j-0002wl-2s
 for qemu-devel@nongnu.org; Mon, 12 Oct 2026 11:34:28 -0400
Received: by mail-wm1-f48.google.com with SMTP id
 5b1f17b1804b1-4a16c1608faso26873855e9.0
 for <qemu-devel@nongnu.org>; Mon, 12 Oct 2026 08:34:24 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1791819263; x=1792424063;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=9m6xeuXDGuPCKQgTcqEoBMjzYqVoeLEW2xyy05z+8Wk=;
 b=Xg7QiqCFUNX1qRGkZ9ZJKmKMteEp1BMQkXDHfpU1Qu+xe1Da4LJyydp2trBSuSruG1
 VvHkoDwYQyDM3/69G5sbYKS51htgN5LdiHqYxLfTWdRrMi+JmsX3yymnDbXulLhNd1QP
 7L/7IrzcI2YDx3Z6vViXbKfIXx4G2TzBnB+Gz14YFpVXb17rMMy7CiAd2FE9hSIVWFQh
 a6AZI7S7LpCi4pHveGyLC7cKV4lEVNRsv43L5SPqmUNOrgSjzPbwy6o4l9iRadlAJWC3
 hXxAJrW9Keq3zEoy7nAMLxQkkStrUCpGUApfEAv0q+4LwoqcLMJG82FakQ2RSRx/gCbF
 NtKg==
X-Gm-Message-State: AFq9FYJ3S4TTUVRxk2N+4KSMUvEBlGLmkBoGif851HRaX6L3qQbiLRkM
 +xYOySjkHM4I/i4Xty3h9P1W6IyqZAXtxZfZH7Fi7P7qofyXUFmcKo7wriaGa1Dw
X-Gm-Gg: AYBFou2aUcC14CH9TiOe++ljJ/uD12Gb2vBK+Jfy6B+L547bwh929j/t4H/LiOVfoCq
 J3rPkwlfNCT0gWd4i6bbFdNHPWInmE/9IFMRHdRWfvgsmE1ry1RmU4tUePgS86kCzXLZJTutQWn
 KRF+EpXd+vFBLMP/g2bSyBabOq+p0hdQ68d50mbrtn4tGe9dvgUyNpBZizlKan1q+vdviAY9oT/
 bieQNFETonmQ0iZ7TluRkABpJjR7Oquzs/qOPHzwCsx3Xl1layCE5dXpzajoO5UPbqTfRgpcZ7V
 qtD0SfrrvuLaY84xYyWl/sKV5SS0GU3ZF2nMaNOaSklUTggIJmaWdFurYCJxXl6usCkoRTh7z7I
 0Z7EZXxqpqsHg8nlKIyW2NeTjI/nUGk3YstIxE8rPPLtTghF5mvx+iic81JlczKu9GVYMvpHXHc
 9wsBKSlhhXqojKHHY4XZhFiilwE7BqbSJl+jEVwYu/VfrOvjWBi1WbTnT3se4f1CT2/4dlEzoVU
 tIQJXUHYRDcxloN/8ol68BHcHgRACucFBEbRs6IOL8zFw==
X-Received: by 2002:a05:600c:4708:b0:4a1:88df:8a2a with SMTP id
 5b1f17b1804b1-4a18e4a6ea5mr193790435e9.13.1791819263182; 
 Mon, 12 Oct 2026 08:34:23 -0700 (PDT)
Received: from localhost (89-93-216-19.hfc.dyn.abo.bbox.fr. [89.93.216.19])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4a18e49792bsm476339065e9.4.2026.10.12.08.34.22
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 12 Oct 2026 08:34:22 -0700 (PDT)
Date: Mon, 12 Oct 2026 16:32:34 +0200
Subject: [PATCH v2 41/50] tests/qtest: ina238: add current/voltage/power
 monitor test
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261012-bmc-minerva-v2-41-4c3dff084ec9@free.fr>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1791815521; l=7697;
 i=emmanuel.blot@free.fr; s=20260602; h=from:subject:message-id;
 bh=bGeHvwJFYqhFeLZQKGrvAYOCIAIYNERh3xZiVrwzj4k=;
 b=yc0I4Rkt3OiJIOFuJrjZgxVoq3FSjtJUDVZ3CEpxdlfIlSj8EhkVgO3neVBBaA8v9vhblx7+Y
 +FMJLlQ/vnrAPFDn/s/xgxuomQfYjOYdV2warZv5jg4hgo6KE7aAVLs
X-Developer-Key: i=emmanuel.blot@free.fr; a=ed25519;
 pk=0qFrZ21FAAN8OfVsSoVcCFTk/NMYOWzxJz4paSAVm0g=
Received-SPF: pass client-ip=209.85.128.48; envelope-from=eblot.ml@gmail.com;
 helo=mail-wm1-f48.google.com
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

Introduce the INA238 qtest: the qgraph node, the QMP injection helpers
and the register map. Cover the reset defaults, the software reset, and
the Configuration register write mask.

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
index e413a0cc75..7005509d4d 100644
--- a/tests/qtest/meson.build
+++ b/tests/qtest/meson.build
@@ -331,6 +331,7 @@ qos_test_ss.add(
   'eepro100-test.c',
   'es1370-test.c',
   'ina230-test.c',
+  'ina238-test.c',
   'lsm303dlhc-mag-test.c',
   'isl_pmbus_vr-test.c',
   'max34451-test.c',

-- 
2.50.1


