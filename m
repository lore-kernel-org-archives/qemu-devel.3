Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F0F11606A31B
	for <qemu-devel@archiver.kernel.org>; Thu,  5 Nov 2026 09:14:54 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xOtY5-00059o-7F; Thu, 05 Nov 2026 04:14:22 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eblot.ml@gmail.com>)
 id 1xOtXe-000555-Kg
 for qemu-devel@nongnu.org; Thu, 05 Nov 2026 04:13:57 -0500
Received: from mail-pg1-f181.google.com ([209.85.215.181])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <eblot.ml@gmail.com>)
 id 1xOtXc-0005Q8-4c
 for qemu-devel@nongnu.org; Thu, 05 Nov 2026 04:13:54 -0500
Received: by mail-pg1-f181.google.com with SMTP id
 41be03b00d2f7-cd62c570b5dso1085927a12.2
 for <qemu-devel@nongnu.org>; Thu, 05 Nov 2026 01:13:51 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793870030; x=1794474830;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=9a8tVmiMXzx1D2s3RdJddbAUFJlNjdVF7U3oIP6iTDE=;
 b=m7HCk+VwHABv1m0zjkfJCD2Pvnaqr+iPlevUkI0M1XJS2AQzBragnOIcs/Dbrvo0RK
 Lw8R4QSLtXmhNtsFwYh/IEg1zyPhtltJNrOaTV70QOO/Ky5df2XHQoZXgJ+J9u6emMpE
 +zo8MCEW/RKV1WNNrv7vQrp9v+E82/LxqGOdp6Mwf1wEfWnhjr8X98Z2C/CDGW9oJ3Hy
 EMLU+Gt/335svUYOynTjo5BYN39YZdD2NCEiY6k0Bmtoquf7HHtLgjMaZBULLa1+AiSW
 Kjf/SWIdfuQV4YtyKTNkNUrOC8LU+Biihc++bGJIFpFI+qt/qXAKqxQOWgbWM4mChgnT
 jTmg==
X-Gm-Message-State: APuU4Z+6Ax0F9oOCbiDE8i8SIo2ntmioLmzHeFC4BQyH5PYPftrO/r1A
 y9e4RouRwXmy7PAni8SdcPyrt/9bcpb6xqTqv+3EIF5wREzsLJLFSAnjb7mvsMTqu8A=
X-Gm-Gg: AYBFou2QCy/b5QAnjYUA16K63OorGOdEtjzwwGmKwLtWAJ10LEvB8uLk/c+MXGzUWGD
 lP8VVN6sILvXrRYiVSElgMIt+EHQPJB5hpta3dpDH+6onDcN/1dCxAKN1d4Rek2DIsHAI/az+RG
 vpB1p2wcF/ZE99YviFwY+2VbsOR1G/Ow+j+5zR5ynp25mogzzE74QXCVrLjzGBfdvHoPx9rTZES
 B5wl/7zTqxpzU8RK/ZkZxFi34yg2y/jkx+IzdOqLcKdRnfWjRHRbZELY3QZB/+dnn+eLdyT2RyL
 00p7TsvU6qTTNm8x5cJJzjP/YjcCb1Pc7RpINg1xAHUBeHm+0hhfo0adJoZiRrywsJAxDBsfJGM
 HHyIXjiRS1k5Z0b1GgRL0J4b0yTVz2VOEKg2adQGnT+F4b71h0DF5hsVgMfy+spAmbOW48Npy4x
 hccaZPSSh1Z3Clc50FdJ1kJQggSqyLKm9EJPC/0Lg9iifg2Y8PUupjROIoue7lLOvkc9r+Y8e7e
 061I/ihiNveaq69fKW/UrzJBroYgySa5lXVgnZgDFBDa2wMRv+J9snl6NuBiWyeUo1X9xPnW2FW
 tvWUZ10cPQrirTZ/C617h5Xj15PZDnLBjLujYo4xJgiGYhSjB4LHdqtungJ7ElHb/7l/L0CIcxW
 vn6rhUw==
X-Received: by 2002:a17:90b:4b92:b0:3ac:86a0:5766 with SMTP id
 98e67ed59e1d1-3ae897fb684mr15264726a91.63.1793870030247; 
 Thu, 05 Nov 2026 01:13:50 -0800 (PST)
Received: from localhost (118-163-122-149.hinet-ip.hinet.net.
 [118.163.122.149]) by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-cdb46443d6esm1974481a12.2.2026.11.05.01.13.49
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 05 Nov 2026 01:13:49 -0800 (PST)
Date: Thu, 05 Nov 2026 17:12:54 +0800
Subject: [PATCH 02/16] tests/qtest: ina230: add current/voltage/power
 monitor test
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261105-sensor-ina23x-v1-2-5433ed104990@free.fr>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1793869975; l=5246;
 i=emmanuel.blot@free.fr; s=20260602; h=from:subject:message-id;
 bh=s1nFTgdA+hlQv/WxtG23fzT50LLyFvY6GqK1Nb3vghE=;
 b=xDzh4GbA/5pPwhR2rS4DsL4+FFCA28MW9O13VeNBGr5rQejM0UrxfOBKCJiHsWzRcGAWORd6r
 sREMVFbgRoCBIdT/CIUckKYTdkVkukxFBIOVRZ2yJ+XCpTNLn3jYXkS
X-Developer-Key: i=emmanuel.blot@free.fr; a=ed25519;
 pk=0qFrZ21FAAN8OfVsSoVcCFTk/NMYOWzxJz4paSAVm0g=
Received-SPF: pass client-ip=209.85.215.181; envelope-from=eblot.ml@gmail.com;
 helo=mail-pg1-f181.google.com
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

Introduce the INA230 qtest: the qgraph node and the register map. Cover
the power-on-reset defaults and Die ID, the software reset, and the
Configuration register write mask. The QMP voltage-injection helpers
arrive with the following commit that exercises them.

Reviewed-by: Glenn Miles <milesg@linux.ibm.com>
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
index ff4bf9528a..bfebe136ef 100644
--- a/tests/qtest/meson.build
+++ b/tests/qtest/meson.build
@@ -338,6 +338,7 @@ qos_test_ss.add(
   'e1000-test.c',
   'eepro100-test.c',
   'es1370-test.c',
+  'ina230-test.c',
   'lsm303dlhc-mag-test.c',
   'isl_pmbus_vr-test.c',
   'max34451-test.c',

-- 
2.53.0-Meta


