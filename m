Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F1619606A31B
	for <qemu-devel@archiver.kernel.org>; Thu,  5 Nov 2026 09:30:19 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xOtmg-0008EL-GN; Thu, 05 Nov 2026 04:29:26 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eblot.ml@gmail.com>)
 id 1xOtmd-00084w-Ko
 for qemu-devel@nongnu.org; Thu, 05 Nov 2026 04:29:23 -0500
Received: from mail-pf1-f170.google.com ([209.85.210.170])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <eblot.ml@gmail.com>)
 id 1xOtmb-00071Z-KC
 for qemu-devel@nongnu.org; Thu, 05 Nov 2026 04:29:23 -0500
Received: by mail-pf1-f170.google.com with SMTP id
 d2e1a72fcca58-8a06e79e152so1000079b3a.0
 for <qemu-devel@nongnu.org>; Thu, 05 Nov 2026 01:29:21 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793870960; x=1794475760;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=Rkg/rRagot7XXlFirwrvwK6gw3R8aZjpi8YcEvfRzRk=;
 b=k8fK3iGkqEgntE5eyJ5BsqLFeO8Mzz6jEzH5bvdIVYqmrlpWp0gTDQxeUTfmDJ4xqT
 /KG2k2+xY8ShMorLL4V+GxhXNisaR2Pf/VtU9T6lPFe1OT65mgFEz4/EIitwbcX8fBUa
 zas7x8YwOaQ9Qhe6sOvKAqU5aCdXt3GD7Vq5mODDzHWOHtsGhF6tRDb6MqA6hDCzCl7M
 HzxPd2mHyGnA9zbV5oRiyd9GWI4V3Y9K6yszkRazF2lcvXM8Er1zv3j72iDJmV0Cc+Hx
 XAsxhyP1tjNpVBIJg0/ifXNL4sbdx0oi/guEMF8zCf8wAAZbmtrZHIofZFwTZIkgEoHx
 idwA==
X-Gm-Message-State: APuU4Z8pIYzXq5jPi7xtSBxS4NrfuVD6bklIIkixzQXb2kt3TEbFnu40
 aky0lz9DZbxzlaRgQGKEI59UAkXN9x/gVk78HnVJwOjbWXRmF/AoqpfSQ8nr5A1t3Zk=
X-Gm-Gg: AYBFou1dCFYL2V9MitrhLKvBmdgqKlk+h9YqXzCVyMqNMNg3rZG2A9xh/boGLj3k2Q7
 HHcyhpSZ1W2hSvh+DWNaX6ek0XuFMQWkeD3oZz4eOB1UrDmZHQo5JmOHQmIoBy7eebn7fcWGzG6
 VS2ZVBD0AmTgHUVleTq/VJouSr9x+aftQVcMamVl6CcMPt6ZMM1AHtHgn90rwAALJJHTw9Afqp6
 oQArxHnDqkR65b7ay1NU4HdET6p5EQQKNiKBHzocwGaXK8LpHVKYZGYhQchg0R9B5AOflF1JitG
 jbpnJ8L0hLg0K8vBQJAmfbEzMwuaHKTdSpPDc+/y6uqXA15a7TFRC3VJfPeJ8rTH7DtHTSyde5I
 JId0TGHSMSUPcYR0zNzqLoXIngjmeSLKepe1GSe2x0LduRDY0Y7PTmtdGllwjuhQRSWxZcXkmCt
 4GhTiyBJq9vXPfPMCY/hFgWjzgmYOx4Aj0saZoMnsX3HD+C7r4wX3qj2mKTkAOBHrCwbMoCafVA
 1/MsCpmPlX3Y8FkZyw+OUuPNBN+iQ2tYnL9DuYsnmNWatcKklyLd+fnNGP6u5sfYiKswBGXEZZr
 5kqEUEmyTOeNH8HBJzJiKhmB8iSmeJV/CW2vy1izq34zWJQvsMTcRCNOgT3YxB0/QBQEJdgSzIj
 v
X-Received: by 2002:a05:6a20:914b:b0:3e2:9470:5303 with SMTP id
 adf61e73a8af0-3e928953948mr15587729637.15.1793870960156; 
 Thu, 05 Nov 2026 01:29:20 -0800 (PST)
Received: from localhost (118-163-122-149.hinet-ip.hinet.net.
 [118.163.122.149]) by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-cdb46972143sm1876427a12.22.2026.11.05.01.29.19
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 05 Nov 2026 01:29:19 -0800 (PST)
Date: Thu, 05 Nov 2026 17:25:51 +0800
Subject: [PATCH 12/16] tests/qtest: tmp421: cover device IDs and reset defaults
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261105-sensor-tmp421-v1-12-c46853f5e1f0@free.fr>
References: <20261105-sensor-tmp421-v1-0-c46853f5e1f0@free.fr>
In-Reply-To: <20261105-sensor-tmp421-v1-0-c46853f5e1f0@free.fr>
To: qemu-devel@nongnu.org
Cc: =?utf-8?q?C=C3=A9dric_Le_Goater?= <clg@kaod.org>, eblot@meta.com, 
 =?utf-8?q?Philippe_Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>, 
 Peter Maydell <peter.maydell@linaro.org>, 
 Jamin Lin <jamin_lin@aspeedtech.com>, Kane Chen <kane_chen@aspeedtech.com>, 
 qemu-arm@nongnu.org, Fabiano Rosas <farosas@suse.de>, 
 Laurent Vivier <lvivier@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, 
 Emmanuel Blot <emmanuel.blot@free.fr>
X-Mailer: b4 0.16.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1793870743; l=3934;
 i=emmanuel.blot@free.fr; s=20260602; h=from:subject:message-id;
 bh=rxzfEVZP/N2hZ9sXIJbALDO+kJ3vIfs6oxJpOT9g+40=;
 b=CjZmLeymN9+6smjAB5NAwSTqQfkV6P1WzVKZqj/oXAaYp+TtJ2JtqSooGa2dGXWzLQlurKQtY
 bro46l0JJNCDQzrO126cHR2otdlC1KBzwmgu6lGAsdklxyCSLhMNwq/
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
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Add a qgraph test that instantiates each variant and checks the
manufacturer and device identification bytes and the reset values of
the configuration and conversion-rate registers.

Signed-off-by: Emmanuel Blot <emmanuel.blot@free.fr>
---
 tests/qtest/meson.build   |  1 +
 tests/qtest/tmp421-test.c | 84 +++++++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 85 insertions(+)

diff --git a/tests/qtest/meson.build b/tests/qtest/meson.build
index ff4bf9528a..5c82fdb22c 100644
--- a/tests/qtest/meson.build
+++ b/tests/qtest/meson.build
@@ -355,6 +355,7 @@ qos_test_ss.add(
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


