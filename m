Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B4527CA1009
	for <qemu-devel@archiver.kernel.org>; Wed,  3 Sep 2025 15:55:29 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1utpoW-0000Yh-ER; Wed, 03 Sep 2025 11:54:24 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from
 <3qGS4aAwKCp8M9AHGDRSDE9MFNNFKD.BNLPDLT-CDUDKMNMFMT.NQF@flex--nabihestefan.bounces.google.com>)
 id 1utpoU-0000YK-OS
 for qemu-devel@nongnu.org; Wed, 03 Sep 2025 11:54:22 -0400
Received: from mail-pl1-x649.google.com ([2607:f8b0:4864:20::649])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from
 <3qGS4aAwKCp8M9AHGDRSDE9MFNNFKD.BNLPDLT-CDUDKMNMFMT.NQF@flex--nabihestefan.bounces.google.com>)
 id 1utpoR-0006Rf-Lf
 for qemu-devel@nongnu.org; Wed, 03 Sep 2025 11:54:22 -0400
Received: by mail-pl1-x649.google.com with SMTP id
 d9443c01a7336-248fbfc35ddso1075785ad.3
 for <qemu-devel@nongnu.org>; Wed, 03 Sep 2025 08:54:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=google.com; s=20230601; t=1756914856; x=1757519656; darn=nongnu.org;
 h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
 :date:message-id:reply-to;
 bh=1rd71rxQlwI1xqkRgVqtsHxoEBZ4WKa9I8G7GAvnAcY=;
 b=R5IEZPPqcWGcmsrpEOD68cLLVizLHSNykhBQSXq+9cN5RJ0h4g0CBGww9R2T2hHLqn
 CQM9dR7X9d46OK8ZJ8PrLNjPWZ1ylRhwT4YZOxCmtqAS/Y5+2HUa5KqQAmjbjXZDN+zZ
 LGqK+6vTPCFbd/+H/EVZRZd12hz1n0+Ury5IlIuyoNnmL0qRBx3BoLUA2Q+fDDmBvNAF
 v7gjsRDTgnd7RkVLY/rJKoq7YoxZQ2R6nMlgExOSSWHfJUOF4+nS3k3mKx0oBoStC5YZ
 LbU2fSJNNYIqjNCiBy4e21U+6gDQCXwdL9N0YsvKSUdphLJECgLQTjSfAjR29Jt/NSaX
 62hQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1756914856; x=1757519656;
 h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
 :from:to:cc:subject:date:message-id:reply-to;
 bh=1rd71rxQlwI1xqkRgVqtsHxoEBZ4WKa9I8G7GAvnAcY=;
 b=HxFk8DFlCcEyTFKo8Z6x150PYvjgCDXG560MLEZgXCiXxv+ry9g9fxqw/9dqJOSELI
 PLcFhAZWcJV+HkNgezqjNMp4BsydjcEHyPIryAwsyb7ssu2tVVfRS2BS9YSrIK8LJA8u
 z0lDKFk/yR6lE25CT4TSElgfX/IuxZFb2DSKRaRSWNqZGkNQWHTcsO7fPB+aalhJuv2G
 phzahKZwpj+8Z1puWhD6fotOomkIkoltihmOiKbxa8nMTFCkE5/EqqMYTtQKaIlkh6k1
 hdOlNB41xrVbuQsIaliyunnNKbmzhc2MddIsDZf80w19ea4x0XC9J+IrbSDF0+N+NIgb
 Ok1Q==
X-Gm-Message-State: AOJu0YyFdmWGo8/1acPDKNk/z2ZFYMLhYRDi7QIZdeuJSQdHG65ongpW
 g+pvp9H7gusU8dWdMRwEcIw8wqa2fyCOodOkULmCWHJm5yq1iZqoeeB/rw+5G0MQ+IaX0C3mzQg
 DUCBo/1nRYyK6ROV257QRlJTk99v65EnT+ckjzxS6olnCOQ/A+cFqrtVuHRo0BHp9nTFH7xYBRN
 jnxwy/BtpTAWtLCd2LOH4WC7+Dkf1ZsPhiS0+MXrZwkzVATDgIWC3+9bMTWkwQ8StrPr4=
X-Google-Smtp-Source: AGHT+IGoiXqYqBkI3AqpbLTKBzjAICHUQQTHRcy+Y0OLXDWW0CYnCmZAo7RzPf/MRhHsfUHlxGH7QHvh4DUtzSeaCBY=
X-Received: from plat13.prod.google.com ([2002:a17:902:e1cd:b0:24c:b6df:675e])
 (user=nabihestefan job=prod-delivery.src-stubby-dispatcher) by
 2002:a17:903:32d2:b0:248:f2f0:391c with SMTP id
 d9443c01a7336-249448e41d9mr201292545ad.23.1756914856337; 
 Wed, 03 Sep 2025 08:54:16 -0700 (PDT)
Date: Wed,  3 Sep 2025 15:54:10 +0000
Mime-Version: 1.0
X-Mailer: git-send-email 2.51.0.355.g5224444f11-goog
Message-ID: <20250903155410.1910145-1-nabihestefan@google.com>
Subject: [PATCH v3] hw/sensor: added MAX16600 device model
From: Nabih Estefan <nabihestefan@google.com>
To: qemu-devel@nongnu.org
Cc: pbonzini@redhat.com, peter.maydell@linaro.org, philmd@linaro.org, 
 farosas@suse.de, lvivier@redhat.com, qemu-arm@nongnu.org, 
 Shengtan Mao <stmao@google.com>, Titus Rwantare <titusr@google.com>, 
 Nabih Estefan <nabihestefan@google.com>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::649;
 envelope-from=3qGS4aAwKCp8M9AHGDRSDE9MFNNFKD.BNLPDLT-CDUDKMNMFMT.NQF@flex--nabihestefan.bounces.google.com;
 helo=mail-pl1-x649.google.com
X-Spam_score_int: -94
X-Spam_score: -9.5
X-Spam_bar: ---------
X-Spam_report: (-9.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_MED=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FUZZY_MILLION=0.1, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001, USER_IN_DEF_DKIM_WL=-7.5 autolearn=ham autolearn_force=no
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

From: Shengtan Mao <stmao@google.com>

Signed-off-by: Shengtan Mao <stmao@google.com>
Signed-off-by: Titus Rwantare <titusr@google.com>
Signed-off-by: Nabih Estefan <nabihestefan@google.com>
---
 hw/arm/Kconfig               |   1 +
 hw/sensor/Kconfig            |   4 +
 hw/sensor/max16600.c         | 197 ++++++++++++++++++++++++++++
 hw/sensor/meson.build        |   1 +
 include/hw/sensor/max16600.h |  46 +++++++
 tests/qtest/max16600-test.c  | 241 +++++++++++++++++++++++++++++++++++
 tests/qtest/meson.build      |   1 +
 7 files changed, 491 insertions(+)
 create mode 100644 hw/sensor/max16600.c
 create mode 100644 include/hw/sensor/max16600.h
 create mode 100644 tests/qtest/max16600-test.c

diff --git a/hw/arm/Kconfig b/hw/arm/Kconfig
index 2aa4b5d778..4ab0a93ba6 100644
--- a/hw/arm/Kconfig
+++ b/hw/arm/Kconfig
@@ -480,6 +480,7 @@ config NPCM7XX
     select AT24C  # EEPROM
     select MAX34451
     select ISL_PMBUS_VR
+    select MAX_16600
     select PL310  # cache controller
     select PMBUS
     select SERIAL_MM
diff --git a/hw/sensor/Kconfig b/hw/sensor/Kconfig
index bc6331b4ab..ef7b3262a8 100644
--- a/hw/sensor/Kconfig
+++ b/hw/sensor/Kconfig
@@ -43,3 +43,7 @@ config ISL_PMBUS_VR
 config MAX31785
     bool
     depends on PMBUS
+
+config MAX_16600
+    bool
+    depends on I2C
diff --git a/hw/sensor/max16600.c b/hw/sensor/max16600.c
new file mode 100644
index 0000000000..1941391dab
--- /dev/null
+++ b/hw/sensor/max16600.c
@@ -0,0 +1,197 @@
+/*
+ * MAX16600 VR13.HC Dual-Output Voltage Regulator Chipset
+ *
+ * SPDX-License-Identifier: GPL-2.0-or-later
+ *
+ * Copyright 2025 Google LLC
+ */
+
+#include "qemu/osdep.h"
+#include "hw/i2c/pmbus_device.h"
+#include "qapi/visitor.h"
+#include "qemu/log.h"
+#include "hw/sensor/max16600.h"
+
+static uint8_t max16600_read_byte(PMBusDevice *pmdev)
+{
+    MAX16600State *s = MAX16600(pmdev);
+
+    switch (pmdev->code) {
+    case PMBUS_IC_DEVICE_ID:
+        pmbus_send_string(pmdev, s->ic_device_id);
+        break;
+
+    case MAX16600_PHASE_ID:
+        pmbus_send8(pmdev, s->phase_id);
+        break;
+
+    default:
+        qemu_log_mask(LOG_GUEST_ERROR,
+                      "%s: reading from unsupported register: 0x%02x\n",
+                      __func__, pmdev->code);
+        break;
+    }
+    return 0xFF;
+}
+
+static int max16600_write_data(PMBusDevice *pmdev, const uint8_t *buf,
+                               uint8_t len)
+{
+    qemu_log_mask(LOG_GUEST_ERROR,
+                  "%s: write to unsupported register: 0x%02x\n", __func__,
+                  pmdev->code);
+    return 0xFF;
+}
+
+static void max16600_exit_reset(Object *obj, ResetType type)
+{
+    PMBusDevice *pmdev = PMBUS_DEVICE(obj);
+    MAX16600State *s = MAX16600(obj);
+
+    pmdev->capability = MAX16600_CAPABILITY_DEFAULT;
+    pmdev->page = 0;
+
+    pmdev->pages[0].operation = MAX16600_OPERATION_DEFAULT;
+    pmdev->pages[0].on_off_config = MAX16600_ON_OFF_CONFIG_DEFAULT;
+    pmdev->pages[0].vout_mode = MAX16600_VOUT_MODE_DEFAULT;
+
+    pmdev->pages[0].read_vin =
+        pmbus_data2linear_mode(MAX16600_READ_VIN_DEFAULT, max16600_exp.vin);
+    pmdev->pages[0].read_iin =
+        pmbus_data2linear_mode(MAX16600_READ_IIN_DEFAULT, max16600_exp.iin);
+    pmdev->pages[0].read_pin =
+        pmbus_data2linear_mode(MAX16600_READ_PIN_DEFAULT, max16600_exp.pin);
+    pmdev->pages[0].read_vout = MAX16600_READ_VOUT_DEFAULT;
+    pmdev->pages[0].read_iout =
+        pmbus_data2linear_mode(MAX16600_READ_IOUT_DEFAULT, max16600_exp.iout);
+    pmdev->pages[0].read_pout =
+        pmbus_data2linear_mode(MAX16600_READ_PIN_DEFAULT, max16600_exp.pout);
+    pmdev->pages[0].read_temperature_1 =
+        pmbus_data2linear_mode(MAX16600_READ_TEMP_DEFAULT, max16600_exp.temp);
+
+    s->ic_device_id = "MAX16601";
+    s->phase_id = MAX16600_PHASE_ID_DEFAULT;
+}
+
+static void max16600_get(Object *obj, Visitor *v, const char *name,
+                         void *opaque, Error **errp)
+{
+    uint16_t value;
+
+    if (strcmp(name, "vin") == 0) {
+        value = pmbus_linear_mode2data(*(uint16_t *)opaque, max16600_exp.vin);
+    } else if (strcmp(name, "iin") == 0) {
+        value = pmbus_linear_mode2data(*(uint16_t *)opaque, max16600_exp.iin);
+    } else if (strcmp(name, "pin") == 0) {
+        value = pmbus_linear_mode2data(*(uint16_t *)opaque, max16600_exp.pin);
+    } else if (strcmp(name, "iout") == 0) {
+        value = pmbus_linear_mode2data(*(uint16_t *)opaque, max16600_exp.iout);
+    } else if (strcmp(name, "pout") == 0) {
+        value = pmbus_linear_mode2data(*(uint16_t *)opaque, max16600_exp.pout);
+    } else if (strcmp(name, "temperature") == 0) {
+        value = pmbus_linear_mode2data(*(uint16_t *)opaque, max16600_exp.temp);
+    } else {
+        value = *(uint16_t *)opaque;
+    }
+
+    /* scale to milli-units */
+    if (strcmp(name, "pout") != 0 && strcmp(name, "pin") != 0) {
+        value *= 1000;
+    }
+
+    visit_type_uint16(v, name, &value, errp);
+}
+
+static void max16600_set(Object *obj, Visitor *v, const char *name,
+                         void *opaque, Error **errp)
+{
+    PMBusDevice *pmdev = PMBUS_DEVICE(obj);
+    uint16_t *internal = opaque;
+    uint16_t value;
+    if (!visit_type_uint16(v, name, &value, errp)) {
+        return;
+    }
+
+    /* inputs match kernel driver which scales to milliunits except power */
+    if (strcmp(name, "pout") != 0 && strcmp(name, "pin") != 0) {
+        value /= 1000;
+    }
+
+    if (strcmp(name, "vin") == 0) {
+        *internal = pmbus_data2linear_mode(value, max16600_exp.vin);
+    } else if (strcmp(name, "iin") == 0) {
+        *internal = pmbus_data2linear_mode(value, max16600_exp.iin);
+    } else if (strcmp(name, "pin") == 0) {
+        *internal = pmbus_data2linear_mode(value, max16600_exp.pin);
+    } else if (strcmp(name, "iout") == 0) {
+        *internal = pmbus_data2linear_mode(value, max16600_exp.iout);
+    } else if (strcmp(name, "pout") == 0) {
+        *internal = pmbus_data2linear_mode(value, max16600_exp.pout);
+    } else if (strcmp(name, "temperature") == 0) {
+        *internal = pmbus_data2linear_mode(value, max16600_exp.temp);
+    } else {
+        *internal = value;
+    }
+
+    pmbus_check_limits(pmdev);
+}
+
+static void max16600_init(Object *obj)
+{
+    PMBusDevice *pmdev = PMBUS_DEVICE(obj);
+    uint64_t flags = PB_HAS_VOUT_MODE | PB_HAS_VIN | PB_HAS_IIN | PB_HAS_PIN |
+                     PB_HAS_IOUT | PB_HAS_POUT | PB_HAS_VOUT |
+                     PB_HAS_TEMPERATURE | PB_HAS_MFR_INFO;
+    pmbus_page_config(pmdev, 0, flags);
+
+    object_property_add(obj, "vin", "uint16", max16600_get, max16600_set, NULL,
+                        &pmdev->pages[0].read_vin);
+
+    object_property_add(obj, "iin", "uint16", max16600_get, max16600_set, NULL,
+                        &pmdev->pages[0].read_iin);
+
+    object_property_add(obj, "pin", "uint16", max16600_get, max16600_set, NULL,
+                        &pmdev->pages[0].read_pin);
+
+    object_property_add(obj, "vout", "uint16", max16600_get, max16600_set,
+                        NULL, &pmdev->pages[0].read_vout);
+
+    object_property_add(obj, "iout", "uint16", max16600_get, max16600_set,
+                        NULL, &pmdev->pages[0].read_iout);
+
+    object_property_add(obj, "pout", "uint16", max16600_get, max16600_set,
+                        NULL, &pmdev->pages[0].read_pout);
+
+    object_property_add(obj, "temperature", "uint16",
+                        max16600_get, max16600_set,
+                        NULL, &pmdev->pages[0].read_temperature_1);
+}
+
+static void max16600_class_init(ObjectClass *klass, const void *data)
+{
+    ResettableClass *rc = RESETTABLE_CLASS(klass);
+    DeviceClass *dc = DEVICE_CLASS(klass);
+    PMBusDeviceClass *k = PMBUS_DEVICE_CLASS(klass);
+
+    dc->desc = "MAX16600 Dual-Output Voltage Regulator";
+    k->write_data = max16600_write_data;
+    k->receive_byte = max16600_read_byte;
+    k->device_num_pages = 1;
+
+    rc->phases.exit = max16600_exit_reset;
+}
+
+static const TypeInfo max16600_info = {
+    .name = TYPE_MAX16600,
+    .parent = TYPE_PMBUS_DEVICE,
+    .instance_size = sizeof(MAX16600State),
+    .instance_init = max16600_init,
+    .class_init = max16600_class_init,
+};
+
+static void max16600_register_types(void)
+{
+    type_register_static(&max16600_info);
+}
+
+type_init(max16600_register_types)
diff --git a/hw/sensor/meson.build b/hw/sensor/meson.build
index 420fdc3359..85c2c73c99 100644
--- a/hw/sensor/meson.build
+++ b/hw/sensor/meson.build
@@ -8,3 +8,4 @@ system_ss.add(when: 'CONFIG_MAX34451', if_true: files('max34451.c'))
 system_ss.add(when: 'CONFIG_LSM303DLHC_MAG', if_true: files('lsm303dlhc_mag.c'))
 system_ss.add(when: 'CONFIG_ISL_PMBUS_VR', if_true: files('isl_pmbus_vr.c'))
 system_ss.add(when: 'CONFIG_MAX31785', if_true: files('max31785.c'))
+system_ss.add(when: 'CONFIG_MAX_16600', if_true: files('max16600.c'))
diff --git a/include/hw/sensor/max16600.h b/include/hw/sensor/max16600.h
new file mode 100644
index 0000000000..a8cd0a5d4b
--- /dev/null
+++ b/include/hw/sensor/max16600.h
@@ -0,0 +1,46 @@
+/*
+ * MAX16600 VR13.HC Dual-Output Voltage Regulator Chipset
+ *
+ * SPDX-License-Identifier: GPL-2.0-or-later
+ *
+ * Copyright 2025 Google LLC
+ */
+
+#include "hw/i2c/pmbus_device.h"
+
+#define TYPE_MAX16600 "max16600"
+#define MAX16600(obj) OBJECT_CHECK(MAX16600State, (obj), TYPE_MAX16600)
+
+#define MAX16600_PHASE_ID       0xF3
+/*
+ * Packet error checking capability is disabled.
+ * Pending QEMU support
+ */
+#define MAX16600_CAPABILITY_DEFAULT 0x30
+#define MAX16600_OPERATION_DEFAULT 0x88
+#define MAX16600_ON_OFF_CONFIG_DEFAULT 0x17
+#define MAX16600_VOUT_MODE_DEFAULT 0x22
+#define MAX16600_PHASE_ID_DEFAULT 0x80
+
+#define MAX16600_READ_VIN_DEFAULT 5    /* Volts */
+#define MAX16600_READ_IIN_DEFAULT 3    /* Amps */
+#define MAX16600_READ_PIN_DEFAULT 100  /* Watts */
+#define MAX16600_READ_VOUT_DEFAULT 5   /* Volts */
+#define MAX16600_READ_IOUT_DEFAULT 3   /* Amps */
+#define MAX16600_READ_POUT_DEFAULT 100 /* Watts */
+#define MAX16600_READ_TEMP_DEFAULT 40  /* Celsius */
+
+typedef struct MAX16600State {
+    PMBusDevice parent;
+    const char *ic_device_id;
+    uint8_t phase_id;
+} MAX16600State;
+
+/*
+ * determines the exponents used in linear conversion for CORE
+ * (iin, pin) may be (-4, 0) or (-3, 1)
+ * iout may be -2, -1, 0, 1
+ */
+static const struct {
+    int vin, iin, pin, iout, pout, temp;
+} max16600_exp = {-6, -4, 0, -2, -1, 0};
diff --git a/tests/qtest/max16600-test.c b/tests/qtest/max16600-test.c
new file mode 100644
index 0000000000..bad5da7989
--- /dev/null
+++ b/tests/qtest/max16600-test.c
@@ -0,0 +1,241 @@
+/*
+ * QTest for the MAX16600 VR13.HC Dual-Output Voltage Regulator Chipset
+ *
+ * SPDX-License-Identifier: GPL-2.0-or-later
+ *
+ * Copyright 2025 Google LLC
+ */
+
+#include "qemu/osdep.h"
+#include "hw/i2c/pmbus_device.h"
+#include "hw/sensor/max16600.h"
+#include "libqtest-single.h"
+#include "libqos/qgraph.h"
+#include "libqos/i2c.h"
+#include "qobject/qdict.h"
+#include "qobject/qnum.h"
+#include "qemu/bitops.h"
+
+#define TEST_ID "max16600-test"
+#define TEST_ADDR (0x61)
+
+uint16_t pmbus_linear_mode2data(uint16_t value, int exp)
+{
+    /* D = L * 2^e */
+    if (exp < 0) {
+        return value >> (-exp);
+    }
+    return value << exp;
+}
+
+static uint16_t qmp_max16600_get(const char *id, const char *property)
+{
+    QDict *response;
+    uint64_t ret;
+
+    response = qmp("{ 'execute': 'qom-get', 'arguments': { 'path': %s, "
+                   "'property': %s } }",
+                   id, property);
+    g_assert(qdict_haskey(response, "return"));
+    ret = qnum_get_uint(qobject_to(QNum, qdict_get(response, "return")));
+    qobject_unref(response);
+    return ret;
+}
+
+static void qmp_max16600_set(const char *id, const char *property,
+                             uint16_t value)
+{
+    QDict *response;
+
+    response = qmp("{ 'execute': 'qom-set', 'arguments': { 'path': %s, "
+                   "'property': %s, 'value': %u } }",
+                   id, property, value);
+    g_assert(qdict_haskey(response, "return"));
+    qobject_unref(response);
+}
+
+static uint16_t max16600_i2c_get16(QI2CDevice *i2cdev, uint8_t reg)
+{
+    uint8_t resp[2];
+    i2c_read_block(i2cdev, reg, resp, sizeof(resp));
+    return (resp[1] << 8) | resp[0];
+}
+
+static void max16600_i2c_set16(QI2CDevice *i2cdev, uint8_t reg, uint16_t value)
+{
+    uint8_t data[2];
+
+    data[0] = value & 255;
+    data[1] = value >> 8;
+    i2c_write_block(i2cdev, reg, data, sizeof(data));
+}
+
+/* test default values */
+static void test_defaults(void *obj, void *data, QGuestAllocator *alloc)
+{
+    uint16_t i2c_value, value;
+    QI2CDevice *i2cdev = (QI2CDevice *)obj;
+
+    i2c_value = i2c_get8(i2cdev, PMBUS_CAPABILITY);
+    g_assert_cmphex(i2c_value, ==, MAX16600_CAPABILITY_DEFAULT);
+
+    i2c_value = i2c_get8(i2cdev, PMBUS_OPERATION);
+    g_assert_cmphex(i2c_value, ==, MAX16600_OPERATION_DEFAULT);
+
+    i2c_value = i2c_get8(i2cdev, PMBUS_ON_OFF_CONFIG);
+    g_assert_cmphex(i2c_value, ==, MAX16600_ON_OFF_CONFIG_DEFAULT);
+
+    i2c_value = i2c_get8(i2cdev, PMBUS_VOUT_MODE);
+    g_assert_cmphex(i2c_value, ==, MAX16600_VOUT_MODE_DEFAULT);
+
+    value = qmp_max16600_get(TEST_ID, "vin") / 1000;
+    g_assert_cmpuint(value, ==, MAX16600_READ_VIN_DEFAULT);
+
+    value = qmp_max16600_get(TEST_ID, "iin") / 1000;
+    g_assert_cmpuint(value, ==, MAX16600_READ_IIN_DEFAULT);
+
+    value = qmp_max16600_get(TEST_ID, "pin");
+    g_assert_cmpuint(value, ==, MAX16600_READ_PIN_DEFAULT);
+
+    value = qmp_max16600_get(TEST_ID, "vout") / 1000;
+    g_assert_cmpuint(value, ==, MAX16600_READ_VOUT_DEFAULT);
+
+    value = qmp_max16600_get(TEST_ID, "iout") / 1000;
+    g_assert_cmpuint(value, ==, MAX16600_READ_IOUT_DEFAULT);
+
+    value = qmp_max16600_get(TEST_ID, "pout");
+    g_assert_cmpuint(value, ==, MAX16600_READ_POUT_DEFAULT);
+
+    value = qmp_max16600_get(TEST_ID, "temperature") / 1000;
+    g_assert_cmpuint(value, ==, MAX16600_READ_TEMP_DEFAULT);
+}
+
+/* test qmp access */
+static void test_tx_rx(void *obj, void *data, QGuestAllocator *alloc)
+{
+    uint16_t value, i2c_value;
+    QI2CDevice *i2cdev = (QI2CDevice *)obj;
+
+    qmp_max16600_set(TEST_ID, "vin", 2000);
+    value = qmp_max16600_get(TEST_ID, "vin") / 1000;
+    i2c_value = max16600_i2c_get16(i2cdev, PMBUS_READ_VIN);
+    i2c_value = pmbus_linear_mode2data(i2c_value, max16600_exp.vin);
+    g_assert_cmpuint(value, ==, i2c_value);
+
+    qmp_max16600_set(TEST_ID, "iin", 3000);
+    value = qmp_max16600_get(TEST_ID, "iin") / 1000;
+    i2c_value = max16600_i2c_get16(i2cdev, PMBUS_READ_IIN);
+    i2c_value = pmbus_linear_mode2data(i2c_value, max16600_exp.iin);
+    g_assert_cmpuint(value, ==, i2c_value);
+
+    qmp_max16600_set(TEST_ID, "pin", 4);
+    value = qmp_max16600_get(TEST_ID, "pin");
+    i2c_value = max16600_i2c_get16(i2cdev, PMBUS_READ_PIN);
+    i2c_value = pmbus_linear_mode2data(i2c_value, max16600_exp.pin);
+    g_assert_cmpuint(value, ==, i2c_value);
+
+    qmp_max16600_set(TEST_ID, "vout", 5000);
+    value = qmp_max16600_get(TEST_ID, "vout") / 1000;
+    i2c_value = max16600_i2c_get16(i2cdev, PMBUS_READ_VOUT);
+    g_assert_cmpuint(value, ==, i2c_value);
+
+    qmp_max16600_set(TEST_ID, "iout", 6000);
+    value = qmp_max16600_get(TEST_ID, "iout") / 1000;
+    i2c_value = max16600_i2c_get16(i2cdev, PMBUS_READ_IOUT);
+    i2c_value = pmbus_linear_mode2data(i2c_value, max16600_exp.iout);
+    g_assert_cmpuint(value, ==, i2c_value);
+
+    qmp_max16600_set(TEST_ID, "pout", 7);
+    value = qmp_max16600_get(TEST_ID, "pout");
+    i2c_value = max16600_i2c_get16(i2cdev, PMBUS_READ_POUT);
+    i2c_value = pmbus_linear_mode2data(i2c_value, max16600_exp.pout);
+    g_assert_cmpuint(value, ==, i2c_value);
+
+    qmp_max16600_set(TEST_ID, "temperature", 8000);
+    value = qmp_max16600_get(TEST_ID, "temperature") / 1000;
+    i2c_value = max16600_i2c_get16(i2cdev, PMBUS_READ_TEMPERATURE_1);
+    i2c_value = pmbus_linear_mode2data(i2c_value, max16600_exp.temp);
+    g_assert_cmpuint(value, ==, i2c_value);
+}
+
+/* test r/w registers */
+static void test_rw_regs(void *obj, void *data, QGuestAllocator *alloc)
+{
+    uint16_t i2c_value;
+    QI2CDevice *i2cdev = (QI2CDevice *)obj;
+
+    max16600_i2c_set16(i2cdev, PMBUS_OPERATION, 0xA);
+    i2c_value = i2c_get8(i2cdev, PMBUS_OPERATION);
+    g_assert_cmphex(i2c_value, ==, 0xA);
+
+    max16600_i2c_set16(i2cdev, PMBUS_ON_OFF_CONFIG, 0xB);
+    i2c_value = i2c_get8(i2cdev, PMBUS_ON_OFF_CONFIG);
+    g_assert_cmphex(i2c_value, ==, 0xB);
+
+    max16600_i2c_set16(i2cdev, PMBUS_VOUT_MODE, 0xC);
+    i2c_value = i2c_get8(i2cdev, PMBUS_VOUT_MODE);
+    g_assert_cmphex(i2c_value, ==, 0xC);
+}
+
+/* test read-only registers */
+static void test_ro_regs(void *obj, void *data, QGuestAllocator *alloc)
+{
+    uint16_t i2c_init_value, i2c_value;
+    QI2CDevice *i2cdev = (QI2CDevice *)obj;
+
+    i2c_init_value = i2c_get8(i2cdev, PMBUS_CAPABILITY);
+    max16600_i2c_set16(i2cdev, PMBUS_CAPABILITY, 0xD);
+    i2c_value = i2c_get8(i2cdev, PMBUS_CAPABILITY);
+    g_assert_cmphex(i2c_init_value, ==, i2c_value);
+
+    i2c_init_value = max16600_i2c_get16(i2cdev, PMBUS_READ_VIN);
+    max16600_i2c_set16(i2cdev, PMBUS_READ_VIN, 0x1234);
+    i2c_value = max16600_i2c_get16(i2cdev, PMBUS_READ_VIN);
+    g_assert_cmphex(i2c_init_value, ==, i2c_value);
+
+    i2c_init_value = max16600_i2c_get16(i2cdev, PMBUS_READ_IIN);
+    max16600_i2c_set16(i2cdev, PMBUS_READ_IIN, 0x2234);
+    i2c_value = max16600_i2c_get16(i2cdev, PMBUS_READ_IIN);
+    g_assert_cmphex(i2c_init_value, ==, i2c_value);
+
+    i2c_init_value = max16600_i2c_get16(i2cdev, PMBUS_READ_PIN);
+    max16600_i2c_set16(i2cdev, PMBUS_READ_PIN, 0x3234);
+    i2c_value = max16600_i2c_get16(i2cdev, PMBUS_READ_PIN);
+    g_assert_cmphex(i2c_init_value, ==, i2c_value);
+
+    i2c_init_value = max16600_i2c_get16(i2cdev, PMBUS_READ_VOUT);
+    max16600_i2c_set16(i2cdev, PMBUS_READ_VOUT, 0x4234);
+    i2c_value = max16600_i2c_get16(i2cdev, PMBUS_READ_VOUT);
+    g_assert_cmphex(i2c_init_value, ==, i2c_value);
+
+    i2c_init_value = max16600_i2c_get16(i2cdev, PMBUS_READ_IOUT);
+    max16600_i2c_set16(i2cdev, PMBUS_READ_IOUT, 0x5235);
+    i2c_value = max16600_i2c_get16(i2cdev, PMBUS_READ_IOUT);
+    g_assert_cmphex(i2c_init_value, ==, i2c_value);
+
+    i2c_init_value = max16600_i2c_get16(i2cdev, PMBUS_READ_POUT);
+    max16600_i2c_set16(i2cdev, PMBUS_READ_POUT, 0x6234);
+    i2c_value = max16600_i2c_get16(i2cdev, PMBUS_READ_POUT);
+    g_assert_cmphex(i2c_init_value, ==, i2c_value);
+
+    i2c_init_value = max16600_i2c_get16(i2cdev, PMBUS_READ_TEMPERATURE_1);
+    max16600_i2c_set16(i2cdev, PMBUS_READ_TEMPERATURE_1, 0x7236);
+    i2c_value = max16600_i2c_get16(i2cdev, PMBUS_READ_TEMPERATURE_1);
+    g_assert_cmphex(i2c_init_value, ==, i2c_value);
+}
+
+static void max16600_register_nodes(void)
+{
+    QOSGraphEdgeOptions opts = {.extra_device_opts =
+                                    "id=" TEST_ID ",address=0x61"};
+    add_qi2c_address(&opts, &(QI2CAddress){TEST_ADDR});
+
+    qos_node_create_driver("max16600", i2c_device_create);
+    qos_node_consumes("max16600", "i2c-bus", &opts);
+
+    qos_add_test("test_defaults", "max16600", test_defaults, NULL);
+    qos_add_test("test_tx_rx", "max16600", test_tx_rx, NULL);
+    qos_add_test("test_rw_regs", "max16600", test_rw_regs, NULL);
+    qos_add_test("test_ro_regs", "max16600", test_ro_regs, NULL);
+}
+libqos_init(max16600_register_nodes);
diff --git a/tests/qtest/meson.build b/tests/qtest/meson.build
index 669d07c06b..459cf41985 100644
--- a/tests/qtest/meson.build
+++ b/tests/qtest/meson.build
@@ -295,6 +295,7 @@ qos_test_ss.add(
   'es1370-test.c',
   'lsm303dlhc-mag-test.c',
   'isl_pmbus_vr-test.c',
+  'max16600-test.c',
   'max34451-test.c',
   'megasas-test.c',
   'ne2000-test.c',
-- 
2.51.0.355.g5224444f11-goog


