Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 59AE4CA9EC5
	for <qemu-devel@archiver.kernel.org>; Mon, 12 Oct 2026 15:26:30 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xGHur-00038Z-97; Mon, 12 Oct 2026 11:26:18 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eblot.ml@gmail.com>)
 id 1xGHup-00037D-EL
 for qemu-devel@nongnu.org; Mon, 12 Oct 2026 11:26:15 -0400
Received: from mail-wm1-f43.google.com ([209.85.128.43])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <eblot.ml@gmail.com>)
 id 1xGHum-0001fv-MS
 for qemu-devel@nongnu.org; Mon, 12 Oct 2026 11:26:15 -0400
Received: by mail-wm1-f43.google.com with SMTP id
 5b1f17b1804b1-49d05d51553so13125835e9.2
 for <qemu-devel@nongnu.org>; Mon, 12 Oct 2026 08:26:12 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1791818771; x=1792423571;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=pVFmeSSk5C2LeCsDwy5d1Hb10DQrqE+ifqDeBxV7YtE=;
 b=Qd7l2CzKq2fC87TR20KEYELRb6IcM2p1i/4Ud+J5QX5DKN5VUlCO8BoyYq2dTBGkTI
 ZxMHiN3/y/B7BX4RKFvnmxupRRYzKN1l6V0yicvgK5o4lKRanWUmg0rGBisKGPITaBHs
 dBu8AiX1So3SqIkhtah07bOkDTABttmlkw9feXLXhnkw/x3LWFamTkx9CvtwT7WiZEMC
 mOlXewfYNdOtaOARmMeGwEW101+VQSnJI04le6JJH3xMc8qqhH6qkwFhx9lB4X0qP6/G
 7iE1hOc2j/mNiYs3VdOasQleGr5EyGQ8snWzLR46FJEf5TembaPlvMcZFByM46lPxlT+
 GlzQ==
X-Gm-Message-State: AFq9FYItLeHVfOZlUgvWOWHO28t//OHBxt4UzvTqYlUCOkibMP6qpAyI
 rpqtf2UhVSqTp/IkMU8VhZ22pYCo6SZpxWLcbSWs02yosxw96RRda08ja7JXIEiL
X-Gm-Gg: AYBFou01pdWBNP+1Y9iiuzj0Yxe7F2rgDa7cFPHEZQKB1zfT4nnLJva/lHJMr5BI98D
 yJIr6fBCcqiXdW/hkYMBsOJ0BIBZdRdzYhG1HmZpD74alUrzzAHn5pI9m+Cn/oHFgu/dX2YokVa
 16Cygv6RlvQQVGU0/dC3QNXsS2TDhOlWPsoEs1XblvEd0lclwe9ExIIUx9CKhvBwZ3gREhJVWon
 lzZGeM1Xi4FXdDuDSFpjvO4u2nSY10oN1eWpuIL9bUJ7GDkx3ldEXo3Nx0p13aoN4Amql9yyZvT
 mc9ElOXBVu0LeilYqHd3hMqK0P+/KQe5ewv4FBvdT7ros7SGOfJ8ivkG5w0bdiDBCR09Kwupkym
 EuBndYsqayZF5W6wbZceF7ZZ3J+TXhduUhEX/20sgYBtztyXt7Qj3fSI43RqSf6/2/SC5BtqPIC
 47zCK0bV7HbjHem0YG2KpjYWos9zYvLimmObckaUK/h3LhbJBhw3Tt6n15kZWNrFDqzcZFmG3j+
 Zy54iIpdNCJId/fT3t5fUcqv/cL9NRLRIpG4N02A9DZaA==
X-Received: by 2002:a05:600c:609a:b0:4a1:717b:7976 with SMTP id
 5b1f17b1804b1-4a18e4b15e5mr186600595e9.35.1791818771028; 
 Mon, 12 Oct 2026 08:26:11 -0700 (PDT)
Received: from localhost (89-93-216-19.hfc.dyn.abo.bbox.fr. [89.93.216.19])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4a18bf15691sm289125915e9.6.2026.10.12.08.26.10
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 12 Oct 2026 08:26:10 -0700 (PDT)
Date: Mon, 12 Oct 2026 16:32:26 +0200
Subject: [PATCH v2 33/50] tests/qtest: ina230: add current/voltage/power
 monitor test
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261012-bmc-minerva-v2-33-4c3dff084ec9@free.fr>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1791815521; l=5192;
 i=emmanuel.blot@free.fr; s=20260602; h=from:subject:message-id;
 bh=Ib67K8NIh73SBMHYK5G4nxgo3VsZ3kwz+ZvqDd0gy4M=;
 b=fjk5O0otE4oaEmTS3m5QV0lG+/HIf2v5H+JUTjA+FVRi42K7HfS+A7iGYqNx5eKBi9c+RNFzV
 6ZMvPlcVux9A39rFOfuVDg3LcdDyc6bvA9zhHOeBVc8KzqsnjDDAxDH
X-Developer-Key: i=emmanuel.blot@free.fr; a=ed25519;
 pk=0qFrZ21FAAN8OfVsSoVcCFTk/NMYOWzxJz4paSAVm0g=
Received-SPF: pass client-ip=209.85.128.43; envelope-from=eblot.ml@gmail.com;
 helo=mail-wm1-f43.google.com
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

Introduce the INA230 qtest: the qgraph node and the register map. Cover
the power-on-reset defaults and Die ID, the software reset, and the
Configuration register write mask. The QMP voltage-injection helpers
arrive with the following commit that exercises them.

Signed-off-by: Emmanuel Blot <emmanuel.blot@free.fr>
---
 tests/qtest/ina230-test.c | 115 ++++++++++++++++++++++++++++++++++++++++++++++
 tests/qtest/meson.build   |   1 +
 2 files changed, 116 insertions(+)

diff --git a/tests/qtest/ina230-test.c b/tests/qtest/ina230-test.c
new file mode 100644
index 0000000000..f7aefd2d97
--- /dev/null
+++ b/tests/qtest/ina230-test.c
@@ -0,0 +1,115 @@
+/*
+ * QTest testcase for the INA230 current/voltage/power monitor
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
+#define INA230_TEST_ID      "ina230-test"
+#define INA230_TEST_ADDR    0x40
+
+/* Register pointer addresses */
+#define REG_CONFIG          0x00
+#define REG_SHUNT           0x01
+#define REG_BUS             0x02
+#define REG_POWER           0x03
+#define REG_CURRENT         0x04
+#define REG_CALIBRATION     0x05
+#define REG_MASK_ENABLE     0x06
+#define REG_ALERT_LIMIT     0x07
+#define REG_DIE_ID          0xFF
+
+/* Configuration register bits */
+#define CONFIG_POR          0x4127
+#define CONFIG_RST          0x8000
+
+/* Mask/Enable register bits */
+#define ME_LEN              0x0001
+#define ME_APOL             0x0002
+#define ME_OVF              0x0004
+#define ME_CVRF             0x0008
+#define ME_AFF              0x0010
+#define ME_CNVR             0x0400
+#define ME_POL              0x0800
+#define ME_BUL              0x1000
+#define ME_BOL              0x2000
+#define ME_SUL              0x4000
+#define ME_SOL              0x8000
+
+/* Injected-input scaling (datasheet fixed LSBs) */
+#define SHUNT_LSB_NV        2500
+#define BUS_LSB_UV          1250
+
+#define DIE_ID_VAL          0x2310
+
+/* Power-on-reset default values and the Die ID */
+static void test_defaults(void *obj, void *data, QGuestAllocator *alloc)
+{
+    QI2CDevice *dev = (QI2CDevice *)obj;
+
+    g_assert_cmphex(i2c_get16(dev, REG_CONFIG), ==, CONFIG_POR);
+    g_assert_cmphex(i2c_get16(dev, REG_SHUNT), ==, 0x0000);
+    g_assert_cmphex(i2c_get16(dev, REG_BUS), ==, 0x0000);
+    g_assert_cmphex(i2c_get16(dev, REG_POWER), ==, 0x0000);
+    g_assert_cmphex(i2c_get16(dev, REG_CURRENT), ==, 0x0000);
+    g_assert_cmphex(i2c_get16(dev, REG_CALIBRATION), ==, 0x0000);
+    g_assert_cmphex(i2c_get16(dev, REG_MASK_ENABLE), ==, 0x0000);
+    g_assert_cmphex(i2c_get16(dev, REG_ALERT_LIMIT), ==, 0x0000);
+    g_assert_cmphex(i2c_get16(dev, REG_DIE_ID), ==, DIE_ID_VAL);
+}
+
+/* Software reset via the Configuration RST bit */
+static void test_soft_reset(void *obj, void *data, QGuestAllocator *alloc)
+{
+    QI2CDevice *dev = (QI2CDevice *)obj;
+
+    i2c_set16(dev, REG_CALIBRATION, 0x1234);
+    i2c_set16(dev, REG_MASK_ENABLE, ME_SOL);
+    i2c_set16(dev, REG_ALERT_LIMIT, 0x0500);
+
+    g_assert_cmphex(i2c_get16(dev, REG_CALIBRATION), ==, 0x1234);
+    g_assert_cmphex(i2c_get16(dev, REG_ALERT_LIMIT), ==, 0x0500);
+
+    i2c_set16(dev, REG_CONFIG, CONFIG_RST);
+
+    g_assert_cmphex(i2c_get16(dev, REG_CONFIG), ==, CONFIG_POR);
+    g_assert_cmphex(i2c_get16(dev, REG_CALIBRATION), ==, 0x0000);
+    g_assert_cmphex(i2c_get16(dev, REG_MASK_ENABLE), ==, 0x0000);
+    g_assert_cmphex(i2c_get16(dev, REG_ALERT_LIMIT), ==, 0x0000);
+}
+
+/* Every bit except the self-clearing RST is writable and reads back */
+static void test_config_wmask(void *obj, void *data, QGuestAllocator *alloc)
+{
+    QI2CDevice *dev = (QI2CDevice *)obj;
+
+    /* Reserved bits are not forced: the guest value is retained */
+    i2c_set16(dev, REG_CONFIG, 0x0007);
+    g_assert_cmphex(i2c_get16(dev, REG_CONFIG), ==, 0x0007);
+
+    i2c_set16(dev, REG_CONFIG, 0x7FFF);
+    g_assert_cmphex(i2c_get16(dev, REG_CONFIG), ==, 0x7FFF);
+}
+
+static void ina230_register_nodes(void)
+{
+    QOSGraphEdgeOptions opts = {
+        .extra_device_opts = "id=" INA230_TEST_ID ",address=0x40"
+    };
+    add_qi2c_address(&opts, &(QI2CAddress) { INA230_TEST_ADDR });
+
+    qos_node_create_driver("ina230", i2c_device_create);
+    qos_node_consumes("ina230", "i2c-bus", &opts);
+
+    qos_add_test("defaults", "ina230", test_defaults, NULL);
+    qos_add_test("soft-reset", "ina230", test_soft_reset, NULL);
+    qos_add_test("config-wmask", "ina230", test_config_wmask, NULL);
+}
+libqos_init(ina230_register_nodes);
diff --git a/tests/qtest/meson.build b/tests/qtest/meson.build
index e23eb9bbca..e413a0cc75 100644
--- a/tests/qtest/meson.build
+++ b/tests/qtest/meson.build
@@ -330,6 +330,7 @@ qos_test_ss.add(
   'e1000-test.c',
   'eepro100-test.c',
   'es1370-test.c',
+  'ina230-test.c',
   'lsm303dlhc-mag-test.c',
   'isl_pmbus_vr-test.c',
   'max34451-test.c',

-- 
2.50.1


