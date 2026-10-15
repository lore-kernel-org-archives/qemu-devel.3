Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 754EDCC6B39
	for <qemu-devel@archiver.kernel.org>; Thu, 15 Oct 2026 15:16:25 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xHN7R-0007bC-VP; Thu, 15 Oct 2026 11:11:46 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eblot.ml@gmail.com>)
 id 1xHN7H-0007Uv-J6
 for qemu-devel@nongnu.org; Thu, 15 Oct 2026 11:11:36 -0400
Received: from mail-wm1-f46.google.com ([209.85.128.46])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <eblot.ml@gmail.com>)
 id 1xHN7F-0001nz-8v
 for qemu-devel@nongnu.org; Thu, 15 Oct 2026 11:11:35 -0400
Received: by mail-wm1-f46.google.com with SMTP id
 5b1f17b1804b1-4a061a13884so45457365e9.3
 for <qemu-devel@nongnu.org>; Thu, 15 Oct 2026 08:11:32 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792077092; x=1792681892;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=vymNcviCs9C76UCnlkWMOWZQKyzqiBj8ztjQDyyYQSA=;
 b=s5HLzK5CqIwwb8NGUCFeKr/TTBB0GWeBpt53kaNylEvJlO7QX1yP7wHXKbxwVrSIAd
 LWDskZi2+FbKN/1wmgakvOIPt88qTbI49Vi0O8xcOf3ulWFKRp/9FXcdI0RMe6kludmI
 TcqkYUScy+DFKS3uBA7SsT+l39a03MlKRphAanpJOrmDV0pJIH+ext96VKrO4UcBR1D8
 f32AERJPUJBxFFvY6GV4kxQS9knRaHcrtKFzLcRUsqs1X3fN77gzy3pdxOANcJVDt/VY
 XZQt6iOUoWiC9dH0RyOFhGm/662NadQf/bEYJCdgLLy/8jbdbfiedZOE3FuacBcsitoP
 znBw==
X-Gm-Message-State: AFq9FYK+aGzuxiFQx6MBKQA9qlSHdDt67WXu212ilKZ6CgagHd9FRDL2
 +sxu4HYIMs6ik6l2wVLC3UUo71R0rfv5lxEHys1sfSyWM2LZ/KICXLiytbOHuw==
X-Gm-Gg: AYBFou1tbcO+7FHYk51PlkfIldtby0pneXIeH4ajpFaRurUZmI6VS8dWWhRDNtWFIs9
 oqD/xw/0etaVjCfiwwRXX7OwnWaXm7hBLqpJIIxRdoxfSI5GoCPWPwUufdnTCN6wiT3DLAb9lVA
 ulJw8ZjncX7HqrURS8GorSwIFwTYvgTJARFLkNvTzalazCVl15+AiBsq+1ITecVdlYVUFoX+74S
 cYH8zoT9LGeAz3lgkh77YuGAIHamhk0sVCUaRSK1XkmAh8jRBFRM7nihQ+c07n52FrQQc5Qv8zF
 cYIetGdEuoUoKe6XGbYlyPV9G0L6qdgdq8eSrAjp1OFAHmQPG4pZCt5KPvZqt/aneRk+NUx1uSi
 bOw0J9rgA9Joqp0lu50XIHWf2gH4g/Ht6gxnq2NZxhEXHWHFXqizXgd8noY5hCnTHlRkTHt4Gm9
 lS2qbzan2NDVepUUbscCS5qMtdEGITTP5hcDuhfZqDReljjdIeY2ktGZr7u4XR6qXTSrc2KsKNv
 eN0l1vgHwF0UjieGJW2rNnNtkLMbr6VhnV+gmR5XrU+hw==
X-Received: by 2002:a05:600c:64c7:b0:49f:ff32:803c with SMTP id
 5b1f17b1804b1-4a18e49c536mr369904345e9.16.1792077091745; 
 Thu, 15 Oct 2026 08:11:31 -0700 (PDT)
Received: from localhost (89-93-216-19.hfc.dyn.abo.bbox.fr. [89.93.216.19])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4a1bd98637asm80462195e9.8.2026.10.15.08.11.30
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 15 Oct 2026 08:11:31 -0700 (PDT)
Date: Thu, 15 Oct 2026 13:57:50 +0200
Subject: [PATCH 12/22] tests/qtest: tmp421: cover device IDs and reset defaults
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261015-bmc-clemente-v1-12-bf591886b5b6@free.fr>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1792065465; l=3934;
 i=emmanuel.blot@free.fr; s=20260602; h=from:subject:message-id;
 bh=IzbVRRFlc2F+EENA5Eeve7GOfuWQMxnkPz/QJ9eQ9pc=;
 b=+F3cC/u6H9MkOpw3an+HRKIVd1++pnltZx/Q0cdcBpfeIXFqteWWr2YZBBsyrrpcwYEE8NzVH
 IxL/ZwIcUgiADAwBYsYk+pie8xwU2cE4ZUxk/6MxIg1Q/Qo4bZJLyMP
X-Developer-Key: i=emmanuel.blot@free.fr; a=ed25519;
 pk=0qFrZ21FAAN8OfVsSoVcCFTk/NMYOWzxJz4paSAVm0g=
Received-SPF: pass client-ip=209.85.128.46; envelope-from=eblot.ml@gmail.com;
 helo=mail-wm1-f46.google.com
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

Add a qgraph test that instantiates each variant and checks the
manufacturer and device identification bytes and the reset values of
the configuration and conversion-rate registers.

Signed-off-by: Emmanuel Blot <emmanuel.blot@free.fr>
---
 tests/qtest/meson.build   |  1 +
 tests/qtest/tmp421-test.c | 84 +++++++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 85 insertions(+)

diff --git a/tests/qtest/meson.build b/tests/qtest/meson.build
index 7005509d4d..5042ae52b2 100644
--- a/tests/qtest/meson.build
+++ b/tests/qtest/meson.build
@@ -349,6 +349,7 @@ qos_test_ss.add(
   'sdhci-test.c',
   'spapr-phb-test.c',
   'tmp105-test.c',
+  'tmp421-test.c',
   'emc141x-test.c',
   'usb-hcd-ohci-test.c',
   'virtio-test.c',
diff --git a/tests/qtest/tmp421-test.c b/tests/qtest/tmp421-test.c
new file mode 100644
index 0000000000..2307e5f603
--- /dev/null
+++ b/tests/qtest/tmp421-test.c
@@ -0,0 +1,84 @@
+/*
+ * QTest testcase for the TMP421/TMP422/TMP423 temperature sensor
+ *
+ * Copyright (c) 2026 Meta Platforms, Inc. and affiliates.
+ *
+ * SPDX-License-Identifier: GPL-2.0-or-later
+ */
+
+#include "qemu/osdep.h"
+
+#include "libqtest-single.h"
+#include "libqos/qgraph.h"
+#include "libqos/i2c.h"
+#include "qobject/qdict.h"
+
+/*
+ * TMP421 register map, per the datasheet. Kept here rather than
+ * shared with the model, so the test states the values it expects
+ * independently of the implementation it is checking.
+ */
+#define TMP421_CONFIG_REG_1             0x09
+#define TMP421_CONFIG_REG_2             0x0A
+#define TMP421_CONVERSION_RATE_REG      0x0B
+#define TMP421_MANUFACTURER_ID_REG      0xFE
+#define TMP421_DEVICE_ID_REG            0xFF
+#define TMP421_MANUFACTURER_ID          0x55
+
+#define TMP421_TEST_ID   "tmp421-test"
+#define TMP422_TEST_ID   "tmp422-test"
+#define TMP423_TEST_ID   "tmp423-test"
+
+/*
+ * Per-variant expectations, passed as the qos test payload so a single test
+ * body can cover all three parts.
+ */
+typedef struct TMP421Variant {
+    const char *id;
+    uint8_t device_id;
+    uint8_t config2_reset;
+    unsigned nchannels;
+} TMP421Variant;
+
+static const TMP421Variant tmp421_variant = { TMP421_TEST_ID, 0x21, 0x1c, 2 };
+static const TMP421Variant tmp422_variant = { TMP422_TEST_ID, 0x22, 0x3c, 3 };
+static const TMP421Variant tmp423_variant = { TMP423_TEST_ID, 0x23, 0x7c, 4 };
+
+static void test_ids(void *obj, void *data, QGuestAllocator *alloc)
+{
+    const TMP421Variant *var = data;
+    QI2CDevice *i2cdev = obj;
+
+    g_assert_cmphex(i2c_get8(i2cdev, TMP421_MANUFACTURER_ID_REG), ==,
+                    TMP421_MANUFACTURER_ID);
+    g_assert_cmphex(i2c_get8(i2cdev, TMP421_DEVICE_ID_REG), ==, var->device_id);
+    g_assert_cmphex(i2c_get8(i2cdev, TMP421_CONFIG_REG_1), ==, 0);
+    g_assert_cmphex(i2c_get8(i2cdev, TMP421_CONFIG_REG_2), ==,
+                    var->config2_reset);
+    g_assert_cmphex(i2c_get8(i2cdev, TMP421_CONVERSION_RATE_REG), ==, 0x07);
+}
+
+static void tmp421_register_node(const TMP421Variant *var, const char *type,
+                                 uint8_t addr)
+{
+    QOSGraphEdgeOptions opts = {
+        .extra_device_opts = g_strdup_printf("id=%s,address=0x%02x",
+                                             var->id, addr),
+    };
+
+    add_qi2c_address(&opts, &(QI2CAddress) { addr });
+    qos_node_create_driver(type, i2c_device_create);
+    qos_node_consumes(type, "i2c-bus", &opts);
+
+    qos_add_test("ids", type, test_ids,
+                 &(QOSGraphTestOptions) { .arg = (void *)var });
+}
+
+static void tmp421_register_nodes(void)
+{
+    tmp421_register_node(&tmp421_variant, "tmp421", 0x4c);
+    tmp421_register_node(&tmp422_variant, "tmp422", 0x4d);
+    tmp421_register_node(&tmp423_variant, "tmp423", 0x4e);
+}
+
+libqos_init(tmp421_register_nodes);

-- 
2.53.0-Meta


