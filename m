Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1706E606A31E
	for <qemu-devel@archiver.kernel.org>; Mon, 26 Oct 2026 21:30:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=jK12X0D8
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xLSG4-0001MQ-Rb; Mon, 26 Oct 2026 17:29:33 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <gessingate@gmail.com>)
 id 1xLSFt-0001KP-IU
 for qemu-devel@nongnu.org; Mon, 26 Oct 2026 17:29:22 -0400
Received: from mail-qv1-xf2e.google.com ([2607:f8b0:4864:20::f2e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <gessingate@gmail.com>)
 id 1xLSFr-000770-F2
 for qemu-devel@nongnu.org; Mon, 26 Oct 2026 17:29:21 -0400
Received: by mail-qv1-xf2e.google.com with SMTP id
 6a1803df08f44-91ba8fcc684so33768156d6.3
 for <qemu-devel@nongnu.org>; Mon, 26 Oct 2026 14:29:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1793050157; x=1793654957; darn=nongnu.org;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=0BhjENSauWXlW62xq7ioTFOG46PQVmIe16xAY1O6AHU=;
 b=jK12X0D8J9IA5pD+QGs8ywjo7oM/Auy/Er2LZ5x/fT1hL9C5sikv+z8YoTdy8mg9y/
 ty/YxOB96ZCZVs9TJwSQ8VG7X+T2ncj9RExkE0xyp9pggQncYKE4UmVGeEW7xwKJX177
 IH3j8QTLBFJCmQNf9wJdU1qteAbjQbB0epXUJ+ll6Ard4xneoZNHc5xFoWQRUiOxbaN8
 DXGq5E2ZOgn7+G5jXV0eaiCEjsKyDU2JXWvpiawlZBlYCaFuXmScF4lazlkWCyQkdn4k
 Q16erOa6Qn7RD6SuzVkhHu03c+q4bG54q+P0+bKUE+TCA5QKQgEHlaCpYcakFGCNHqKp
 eDCQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793050157; x=1793654957;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=0BhjENSauWXlW62xq7ioTFOG46PQVmIe16xAY1O6AHU=;
 b=L98nKvITcIxXHhcarGT4FJehRLqW6vLFbNpsea65nvZ4CJjT3KjI3gGiobOQLu4Zc6
 ByFdoukoJl+BzACznZSgWtT27FPZZ6LmjagQ/RCqYN7tHT4yRfcS30+4Vnz2IYXms3Ev
 1YMGAi932qa2YRYPWOwc+BFSjGy2YniomCQtet7Jq6/ypIlqVGBBPXxGDT2l85zZMYGx
 b+8LHY5x9rS3RASn2TJJ8QUo73A+zMKNMKvqr0ZG8eafrsdobCKLso/duXiZS71JrOkK
 WMS43+yNTDV6mtjLo7vbKD/wSqL1eLCV/BKdm15YYywkJ0XYcDc6hpJQy2L4lACpVT07
 QHXA==
X-Gm-Message-State: AFq9FYKCBQao9Yl+FXlnHS8LpD5njX0qKFnqitWyJH0ar/IB4dj/bf+5
 jal18cx1skRbhXx0POn4Vy6VCnF4ZXtlKjLEZk5SoTfF9E2kFhDh0s2h
X-Gm-Gg: AYBFou0C2ULScwjKQE2zgVSiTOW/5VNR738DBdqiqIe43sOkZrWtsex2dGCQuOZa1pK
 ft+C9p+YWZExJxxVOvTXklANuqu4yN1GWty1M2SXHaGng9dK7Lt421gcgCJT0Cgpn6H3xXzq5wv
 EX1W7BquNjmhVgMJupufhwXMhcJaDxyi9tAPEJHu5Rsi/l2d0/3gvthJ8pA98DuxrdzT+eKAyE8
 L8An2icqCa3Tqi2OiNlplz/XaWqLsbvPDRksl9btHotcmKM5p/9TTMGGKILm4Qp+UHdgKZ43aIP
 z0tBfjXRtj7VlBH2s9ShzJAWavZk/iNwkb0EWfLoqHw23ZVonuHi8VfapifyhEKHo253aYYhXWf
 0B5rS82jzQ8M2CypS2WNxDo7FXJ8UZTrqf93UdtXNgO/2LH/X92Nrhq2WpqnHLoX8Mzb/eBNLId
 h206pXHvvjP4CDgx/GNKO9POEHY9aFc5PbTdCPykqHHKBRjHS8d2bzfJiofJ7akcqWDL+K7i/Tn
 /Zenf5LlwvX4xsh1AdfkFR7uEFH593e7jWUD+HmgHT4ehAmED33G3vbrcCHbKqG2hyI2bjx4FAf
 Oan+A3fJls0lA88=
X-Received: by 2002:ad4:5d67:0:b0:91b:ede9:b02b with SMTP id
 6a1803df08f44-91c48ea73a4mr136609296d6.45.1793050156792; 
 Mon, 26 Oct 2026 14:29:16 -0700 (PDT)
Received: from [127.0.1.1] (95-24-99-141.broadband.corbina.ru. [95.24.99.141])
 by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-91c47c6f3bcsm85206376d6.29.2026.10.26.14.29.14
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 26 Oct 2026 14:29:16 -0700 (PDT)
From: Timur Maksimov <gessingate@gmail.com>
Date: Tue, 27 Oct 2026 00:28:37 +0300
Subject: [PATCH 1/6] hw/i2c: add dummy device
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261027-aspeed-i2c-nonpkt-fix-v1-1-076cdde514f8@gmail.com>
References: <20261027-aspeed-i2c-nonpkt-fix-v1-0-076cdde514f8@gmail.com>
In-Reply-To: <20261027-aspeed-i2c-nonpkt-fix-v1-0-076cdde514f8@gmail.com>
To: qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>, 
 =?utf-8?q?C=C3=A9dric_Le_Goater?= <clg@kaod.org>, 
 Peter Maydell <peter.maydell@linaro.org>, 
 Jamin Lin <jamin_lin@aspeedtech.com>, Kane Chen <kane_chen@aspeedtech.com>, 
 qemu-arm@nongnu.org, Fabiano Rosas <farosas@suse.de>, 
 Laurent Vivier <lvivier@redhat.com>, Timur Maksimov <gessingate@gmail.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1793050151; l=6342;
 i=gessingate@gmail.com; s=20261022; h=from:subject:message-id;
 bh=NXOAnSkiqUuZY0rVL0LaTT0v2OlCdWCNC8YDp5Fu4fU=;
 b=TkSdjA04K9FN+fVhLND1QQLwv52wuH5JcHUCmafQsi+B1ORnP0wuUmN/3c6q5dd8vTe0L+5Ne
 DL8g8cY15JFA/Cg/+mNMI7saz8t42ZtNUS34bpSj8jzBGISi3pcAsK5
X-Developer-Key: i=gessingate@gmail.com; a=ed25519;
 pk=xF4NKIzSbKMdte17nQ66S/q9m/A2gu6GiEWc8ZnyJmo=
Received-SPF: pass client-ip=2607:f8b0:4864:20::f2e;
 envelope-from=gessingate@gmail.com; helo=mail-qv1-xf2e.google.com
X-Spam_score_int: -10
X-Spam_score: -1.1
X-Spam_bar: -
X-Spam_report: (-1.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FORGED_GMAIL_RCVD=1,
 FREEMAIL_FROM=0.001, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
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
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
X-Spam-Status: No, score=-14.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FORGED_GMAIL_RCVD,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Simple I2C device with QOM properties to access a transmit buffer.
Can be used for testing or prototyping.

Signed-off-by: Timur Maksimov <gessingate@gmail.com>
---
 hw/i2c/Kconfig            |   5 ++
 hw/i2c/i2c-dummy-device.c | 168 ++++++++++++++++++++++++++++++++++++++++++++++
 hw/i2c/meson.build        |   3 +-
 3 files changed, 175 insertions(+), 1 deletion(-)

diff --git a/hw/i2c/Kconfig b/hw/i2c/Kconfig
index 0766130b59..04912671db 100644
--- a/hw/i2c/Kconfig
+++ b/hw/i2c/Kconfig
@@ -6,6 +6,11 @@ config I2C_DEVICES
     # to any board's i2c bus
     bool
 
+config I2C_DUMMY_DEVICE
+    bool
+    default y if TEST_DEVICES
+    depends on I2C
+
 config SMBUS
     bool
     select I2C
diff --git a/hw/i2c/i2c-dummy-device.c b/hw/i2c/i2c-dummy-device.c
new file mode 100644
index 0000000000..645525a572
--- /dev/null
+++ b/hw/i2c/i2c-dummy-device.c
@@ -0,0 +1,168 @@
+/*
+ * QEMU I2C Dummy Device
+ *
+ * Copyright (c) 2026 Timur Maksimov <gessingate@gmail.com>
+ *
+ * SPDX-License-Identifier: GPL-2.0-or-later
+ */
+
+#include "qemu/osdep.h"
+#include "hw/i2c/i2c.h"
+#include "hw/core/qdev-properties.h"
+#include "migration/vmstate.h"
+
+#define TYPE_I2C_DUMMY_DEVICE "i2c-dummy-device"
+OBJECT_DECLARE_SIMPLE_TYPE(I2CDummyDeviceState, I2C_DUMMY_DEVICE)
+
+#define I2C_DUMMY_ARRAY_SIZE 64
+
+struct I2CDummyDeviceState {
+    I2CSlave parent_obj;
+
+    uint8_t tx[I2C_DUMMY_ARRAY_SIZE];
+    uint8_t rx[I2C_DUMMY_ARRAY_SIZE];
+
+    uint8_t tx_pos;
+    uint8_t rx_pos;
+    uint8_t event;
+};
+
+static void i2c_dummy_device_reset(DeviceState *dev)
+{
+    I2CDummyDeviceState *s = I2C_DUMMY_DEVICE(dev);
+
+    s->tx_pos = 0;
+    s->rx_pos = 0;
+    s->event = I2C_FINISH;
+    memset(s->tx, 0, sizeof s->tx);
+    /* Don't reset rx as it is a readonly parameter for the model */
+}
+
+static int i2c_dummy_device_event(I2CSlave *i2c, enum i2c_event event)
+{
+    I2CDummyDeviceState *s = I2C_DUMMY_DEVICE(i2c);
+
+    switch (event) {
+    case I2C_START_SEND:
+        s->tx_pos = 0;
+        break;
+
+    case I2C_START_RECV:
+        s->rx_pos = 0;
+        break;
+
+    default:
+        break;
+    }
+
+    s->event = event;
+    return 0;
+}
+
+static int i2c_dummy_device_send(I2CSlave *i2c, uint8_t data)
+{
+    I2CDummyDeviceState *s = I2C_DUMMY_DEVICE(i2c);
+
+    if (s->tx_pos >= I2C_DUMMY_ARRAY_SIZE) {
+        /*
+         * The TX buffer is full. NACK the byte.
+         */
+        return 1;
+    }
+
+    if (s->event == I2C_START_SEND) {
+        s->tx[s->tx_pos++] = data;
+    }
+
+    return 0;
+}
+
+static uint8_t i2c_dummy_device_recv(I2CSlave *i2c)
+{
+    I2CDummyDeviceState *s = I2C_DUMMY_DEVICE(i2c);
+
+    if (s->rx_pos >= I2C_DUMMY_ARRAY_SIZE || s->event != I2C_START_RECV) {
+        /*
+         * There is no more data available.
+         */
+        return 0xff;
+    }
+
+    return s->rx[s->rx_pos++];
+}
+
+static void i2c_dummy_device_init(Object *obj)
+{
+    I2CDummyDeviceState *s = I2C_DUMMY_DEVICE(obj);
+
+    for (int i = 0; i < I2C_DUMMY_ARRAY_SIZE; i++) {
+        g_autofree char *name = g_strdup_printf("tx[%d]", i);
+
+        object_property_add_uint8_ptr(
+            obj, name, &s->tx[i],
+            OBJ_PROP_FLAG_READWRITE);
+    }
+
+    for (int i = 0; i < I2C_DUMMY_ARRAY_SIZE; i++) {
+        g_autofree char *name = g_strdup_printf("rx[%d]", i);
+
+        object_property_add_uint8_ptr(
+            obj, name, &s->rx[i],
+            OBJ_PROP_FLAG_READWRITE);
+    }
+
+    object_property_add_uint8_ptr(
+            obj, "tx-pos", &s->tx_pos,
+            OBJ_PROP_FLAG_READWRITE);
+    object_property_add_uint8_ptr(
+            obj, "rx-pos", &s->rx_pos,
+            OBJ_PROP_FLAG_READWRITE);
+}
+
+static const VMStateDescription vmstate_i2c_dummy_device = {
+    .name = TYPE_I2C_DUMMY_DEVICE,
+    .version_id = 1,
+    .minimum_version_id = 1,
+
+    .fields = (const VMStateField[]) {
+        VMSTATE_I2C_SLAVE(parent_obj, I2CDummyDeviceState),
+
+        VMSTATE_UINT8_ARRAY(tx, I2CDummyDeviceState,
+                            I2C_DUMMY_ARRAY_SIZE),
+
+        VMSTATE_UINT8_ARRAY(rx, I2CDummyDeviceState,
+                            I2C_DUMMY_ARRAY_SIZE),
+
+        VMSTATE_UINT8(tx_pos, I2CDummyDeviceState),
+        VMSTATE_UINT8(rx_pos, I2CDummyDeviceState),
+        VMSTATE_UINT8(event, I2CDummyDeviceState),
+
+        VMSTATE_END_OF_LIST()
+    },
+};
+
+static void i2c_dummy_device_class_init(ObjectClass *klass, const void *data)
+{
+    DeviceClass *dc = DEVICE_CLASS(klass);
+    I2CSlaveClass *isc = I2C_SLAVE_CLASS(klass);
+
+    device_class_set_legacy_reset(dc, i2c_dummy_device_reset);
+
+    dc->vmsd = &vmstate_i2c_dummy_device;
+
+    isc->event = i2c_dummy_device_event;
+    isc->send = i2c_dummy_device_send;
+    isc->recv = i2c_dummy_device_recv;
+}
+
+static const TypeInfo i2c_dummy_device_info[] = {
+    {
+        .name = TYPE_I2C_DUMMY_DEVICE,
+        .parent = TYPE_I2C_SLAVE,
+        .instance_size = sizeof(I2CDummyDeviceState),
+        .instance_init = i2c_dummy_device_init,
+        .class_init = i2c_dummy_device_class_init,
+    }
+};
+
+DEFINE_TYPES(i2c_dummy_device_info)
diff --git a/hw/i2c/meson.build b/hw/i2c/meson.build
index 88aea35662..4695cbcd28 100644
--- a/hw/i2c/meson.build
+++ b/hw/i2c/meson.build
@@ -1,5 +1,5 @@
 i2c_ss = ss.source_set()
-i2c_ss.add(when: 'CONFIG_I2C', if_true: files('core.c'))
+i2c_ss.add(when: 'CONFIG_I2C', if_true: files('core.c', 'i2c-dummy-device.c'))
 i2c_ss.add(when: 'CONFIG_SMBUS', if_true: files('smbus_slave.c', 'smbus_master.c'))
 i2c_ss.add(when: 'CONFIG_ACPI_SMBUS', if_true: files('pm_smbus.c'))
 i2c_ss.add(when: 'CONFIG_ACPI_ICH9', if_true: files('smbus_ich9.c'))
@@ -19,4 +19,5 @@ i2c_ss.add(when: 'CONFIG_PPC4XX', if_true: files('ppc4xx_i2c.c'))
 i2c_ss.add(when: 'CONFIG_PCA954X', if_true: files('i2c_mux_pca954x.c'))
 i2c_ss.add(when: 'CONFIG_PMBUS', if_true: files('pmbus_device.c'))
 i2c_ss.add(when: 'CONFIG_BCM2835_I2C', if_true: files('bcm2835_i2c.c'))
+i2c_ss.add(when: 'CONFIG_I2C_DUMMY_DEVICE', if_true: files('i2c-dummy-device.c'))
 system_ss.add_all(when: 'CONFIG_I2C', if_true: i2c_ss)

-- 
2.53.0


