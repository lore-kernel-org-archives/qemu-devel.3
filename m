Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E79BFC79FA0
	for <qemu-devel@archiver.kernel.org>; Mon,  7 Sep 2026 16:50:39 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x3cYE-0001P8-KQ; Mon, 07 Sep 2026 12:50:34 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eblot.ml@gmail.com>)
 id 1x3cYC-0001HO-1f
 for qemu-devel@nongnu.org; Mon, 07 Sep 2026 12:50:32 -0400
Received: from mail-wm2-f12.google.com ([74.125.225.140])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <eblot.ml@gmail.com>)
 id 1x3cY8-0004e2-Ob
 for qemu-devel@nongnu.org; Mon, 07 Sep 2026 12:50:31 -0400
Received: by mail-wm2-f12.google.com with SMTP id
 5b1f17b1804b1-49b912e2406so1843755e9.1
 for <qemu-devel@nongnu.org>; Mon, 07 Sep 2026 09:50:28 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1788799827; x=1789404627;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=Y4/EWXwVZHFeb0TeRF3loH9mbV6+hvbfIMyoc45VomA=;
 b=ccofR/sHqnYteTqIqfDEAPjsvEkdP3nsY+C3IV8DQZ68TYLoyJNrvrmVgD6M6mUhAr
 vRUpgUskUJ86YyGShaOHXcMvb84FbJ60gr9jwyxirhXkO/BycvnMMm727FIGrKy5q5Dq
 cvcAT45Q9WozcT3oBjxGIJZhnA3q03jImQd4voCjbR3a1n4ZKbFfh3B9G9Sm7tK1WJAR
 fkmw2/DpvLF+RVnBilBcdrqjPbSiPrYuGxEVNuz+wPq6SJ0ynvn9ETaINaJK4euDCXos
 4F4g/s8etQ+IX+YX5J2U3OIcYdxVKA5XbTCfQJ7M6bkhQMnIAaEnZEQEXldc8qjeHUEZ
 yxLw==
X-Gm-Message-State: AFuF++nO67HdPZtZdODf/f3F1jNtkjlc2XKrpiEHf3oL9WBmELh5UosK
 wY//WuPrgXbUZEinbATMA+uX8eU7/5/5rSAXdv0WXPWDEzZnwPRZ9PKMpz1NR0pU
X-Gm-Gg: AYBFou0FWqrZ+l3HYDhVlsyuY8L6hedhesmeINybUUgItq6/RUBQM95ls8jxKRwpN+j
 4sl+QBKGr+h4hejciQEhgRzqhFwrV7cYnlkqCCaOcj4eyV4iJYIhxegHv8Ao3B0MGwahkvZ3Uid
 /la8cW6pdGn9zUcDpRCe2GqdCCAgW9j/mbqbW02n2tJAGM+TgdvZHGQD3KBN80mb1CTvCsqv95b
 Cbpa6vig5fH8bmAsgsnaIYoL9JDFp+JHWZvViyJ295U8cyrc0THKE8E3DmE7fLW1VHK8bX+x63S
 wWaLbo9rHVRPBsg+8gArBGvt/oQ1G0AmokpSHFwkDGa1CK3uwqxIrtPAv/NuCb3u4xuo6YBul+D
 G1iLmjPElwxj2LMBjVmabBSNoPhuMUpFft1XPZQ5B3TWrXv9sV+xrwiHuc4K9rEp9LCmZsqutlI
 Y1EirqKoEjtz3mtTj6RWpLRBaoXYhL8PoRA0xwO4h+Ro98aUJwuYrJe4oZA0D/5lYX7mWGMcHox
 k9lDO/51xD0ROIqgLBgnMy/9UqEzu8aixM=
X-Received: by 2002:a05:600c:3b12:b0:49c:f13e:e50 with SMTP id
 5b1f17b1804b1-49d1757e82emr22400645e9.13.1788799827059; 
 Mon, 07 Sep 2026 09:50:27 -0700 (PDT)
Received: from localhost (89-93-216-19.hfc.dyn.abo.bbox.fr. [89.93.216.19])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-485883c81c3sm30056619f8f.26.2026.09.07.09.50.26
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 07 Sep 2026 09:50:26 -0700 (PDT)
Date: Mon, 07 Sep 2026 18:42:31 +0200
Subject: [PATCH 41/50] tests/qtest: ina238: add current/voltage/power
 monitor test
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260907-bmc-minerva-v1-41-0d83ad610c3b@free.fr>
References: <20260907-bmc-minerva-v1-0-0d83ad610c3b@free.fr>
In-Reply-To: <20260907-bmc-minerva-v1-0-0d83ad610c3b@free.fr>
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
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1788799322; l=7697;
 i=emmanuel.blot@free.fr; s=20260602; h=from:subject:message-id;
 bh=R7atkOfm5/+oNgxmz1EowDUDSQA0iEyPwZTQOrFjeQw=;
 b=YlNzAknN7XRB9BtjfG4UXir3DAHB08Vu8q1xMQetq4wSMkSwUr5PsO/hkU6TPVtZnHx9y1u5P
 Zw34wieqrpIBfsuJnig4KRl+2jl3a8enGUyUXyiG6R8738aqMx1rkYn
X-Developer-Key: i=emmanuel.blot@free.fr; a=ed25519;
 pk=0qFrZ21FAAN8OfVsSoVcCFTk/NMYOWzxJz4paSAVm0g=
Received-SPF: pass client-ip=74.125.225.140; envelope-from=eblot.ml@gmail.com;
 helo=mail-wm2-f12.google.com
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
index 97480d92aa..e941d78194 100644
--- a/tests/qtest/meson.build
+++ b/tests/qtest/meson.build
@@ -325,6 +325,7 @@ qos_test_ss.add(
   'eepro100-test.c',
   'es1370-test.c',
   'ina230-test.c',
+  'ina238-test.c',
   'lsm303dlhc-mag-test.c',
   'isl_pmbus_vr-test.c',
   'max34451-test.c',

-- 
2.50.1


