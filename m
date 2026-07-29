Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2F962C53200
	for <qemu-devel@archiver.kernel.org>; Wed, 29 Jul 2026 23:15:01 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wpDT1-0007Bh-Ls; Wed, 29 Jul 2026 19:13:39 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from
 <3HYlqagYKCjQjYjkihWeeWbU.SecgUck-TUlUbdedWdk.ehW@flex--titusr.bounces.google.com>)
 id 1wpDSz-0007AY-UC
 for qemu-devel@nongnu.org; Wed, 29 Jul 2026 19:13:37 -0400
Received: from mail-pl1-x647.google.com ([2607:f8b0:4864:20::647])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from
 <3HYlqagYKCjQjYjkihWeeWbU.SecgUck-TUlUbdedWdk.ehW@flex--titusr.bounces.google.com>)
 id 1wpDSx-0007Ia-Vv
 for qemu-devel@nongnu.org; Wed, 29 Jul 2026 19:13:37 -0400
Received: by mail-pl1-x647.google.com with SMTP id
 d9443c01a7336-2cc5faecf01so31069435ad.1
 for <qemu-devel@nongnu.org>; Wed, 29 Jul 2026 16:13:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=google.com; s=20251104; t=1785366814; x=1785971614; darn=nongnu.org;
 h=content-type:cc:to:from:subject:message-id:references:mime-version
 :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=6e32ecauHw/VcmLw//niI9ZF67yHhYPBOSWtJHmDDNE=;
 b=B5JhE4Yx98HRvX9zV5PGFpNfJyukAPuu3hVbNll+axg9ZRTiMnLvhte25HXOpHsEG7
 HGf7UkrO7BnenqLMMdXoq1uKpk9INZYlod8wdIVlHdpqnPmk+xXbsRaIjtFD6onP799x
 uMkNVU7uASzOZKdihvnXIsDLfpnmJO2MjpIj6TBSeKZsR+4e180i/khFgholRFMi78q1
 Umiym790XQOSSenJ86IavHEv3dn4aWG/4peYjcLM/B7Mi3TXIj5/JCDQgzEswKBUpoQn
 wZnzQk7b4Xba3kexdRr+0rK/IO+cfN4J81JjhjboBBlwusiq1/nU5Rg/BkPT1mqo2/5x
 DaCw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1785366814; x=1785971614;
 h=content-type:cc:to:from:subject:message-id:references:mime-version
 :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=6e32ecauHw/VcmLw//niI9ZF67yHhYPBOSWtJHmDDNE=;
 b=EMgQL9HgDDH9szI7M8UHBWYe+VO5xHG3aMN9UN/2bojrEHkmKEEUpbyCsopgS6CfOt
 xaUn0ONIvqFWMU4zeya8vDiPZwf36xkrlesrwXaow2xtk7gTLwmFwVO4x24VPyaLbzOV
 TB4UmaVY+kgesxFgJNWGhWKvDg9IgrLGMMMAdD3Xwdyjfek9/jN2gEisMv9vRcO+bJOv
 PyDnMs8SvtqgylfZ4Ha7kwupfqBsBF7A1iUfZ7PD0VHbmO2nvz6CAhlYYXLPUW7sbskG
 +5bktOW7zy3E5PePbXxkqXBgi/U5+MI+pEFU9WImoBLVc6jQ/2l7pXQwFAIFa1z+TPL7
 YT7w==
X-Forwarded-Encrypted: i=1;
 AHgh+RpdOtrw/V42conh1mC/xZj6m5+43KZfHVx6HPAG2gQdAylnz7Vu6d8kqbOX/zgoD3ddb1d7XvTkYc6m@nongnu.org
X-Gm-Message-State: AOJu0YxUYjgX9zFB4lOJWgK/YJfyBQVE/K3rXl/b+n0jeiWvMGHqLLqz
 V/FxffOpfIUYvBOAfix4o7GM4UISmYuU8bk65vlBlRTkLVf/Kf93Ts8nOhWEjhx+/MxckuH7WNN
 pueTsLg==
X-Received: from dybkb41.prod.google.com
 ([2002:a05:7301:38a9:b0:314:f46f:997e])
 (user=titusr job=prod-delivery.src-stubby-dispatcher) by
 2002:a17:903:8c6:b0:2c9:97a7:3289
 with SMTP id d9443c01a7336-2d035d024efmr2770375ad.43.1785366813686; Wed, 29
 Jul 2026 16:13:33 -0700 (PDT)
Date: Wed, 29 Jul 2026 23:13:20 +0000
In-Reply-To: <20260729231325.3808993-1-titusr@google.com>
Mime-Version: 1.0
References: <20260729231325.3808993-1-titusr@google.com>
X-Mailer: git-send-email 2.55.0.508.g3f0d502094-goog
Message-ID: <20260729231325.3808993-6-titusr@google.com>
Subject: [PATCH 5/8] hw/sensor: switch adm1266 to millivolts vout
From: Titus Rwantare <titusr@google.com>
To: peter.maydell@linaro.org
Cc: qemu-arm@nongnu.org, qemu-devel@nongnu.org, kfting@nuvoton.com, 
 imaginos32@gmail.com, wuhaotsh@google.com, philmd@mailo.com, 
 fanjason@google.com, Titus Rwantare <titusr@google.com>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::647;
 envelope-from=3HYlqagYKCjQjYjkihWeeWbU.SecgUck-TUlUbdedWdk.ehW@flex--titusr.bounces.google.com;
 helo=mail-pl1-x647.google.com
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
List-Id: qemu development <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

Enables storing fractional voltages for the ADM1266 over QMP

Signed-off-by: Titus Rwantare <titusr@google.com>
---
 hw/sensor/adm1266.c        |  27 ++++---
 tests/qtest/adm1266-test.c | 150 +++++++++++++++++++++++++++++++++++++
 2 files changed, 167 insertions(+), 10 deletions(-)

diff --git a/hw/sensor/adm1266.c b/hw/sensor/adm1266.c
index 2979557309..80960dc1c4 100644
--- a/hw/sensor/adm1266.c
+++ b/hw/sensor/adm1266.c
@@ -263,32 +263,39 @@ static int adm1266_write_data(PMBusDevice *pmdev, const uint8_t *buf,
 static void adm1266_get(Object *obj, Visitor *v, const char *name, void *opaque,
                         Error **errp)
 {
-    uint16_t value;
+    uint32_t value, index;
     PMBusDevice *pmdev = PMBUS_DEVICE(obj);
     PMBusVoutMode *mode = (PMBusVoutMode *)&pmdev->pages[0].vout_mode;
 
-    if (strcmp(name, "vout") == 0) {
-        value = pmbus_linear_mode2data(*(uint16_t *)opaque, mode->exp);
+    if (strncmp(name, "vout[", 5) == 0) {
+        sscanf(name, "vout[%u]", &index);
+        mode = (PMBusVoutMode *)&pmdev->pages[index].vout_mode;
+        value = pmbus_linear_mode2milliunits(*(uint16_t *)opaque, mode->exp);
     } else {
         value = *(uint16_t *)opaque;
     }
 
-    visit_type_uint16(v, name, &value, errp);
+    visit_type_uint32(v, name, &value, errp);
 }
 
 static void adm1266_set(Object *obj, Visitor *v, const char *name, void *opaque,
                         Error **errp)
 {
     uint16_t *internal = opaque;
-    uint16_t value;
+    uint32_t value, index;
     PMBusDevice *pmdev = PMBUS_DEVICE(obj);
-    PMBusVoutMode *mode = (PMBusVoutMode *)&pmdev->pages[0].vout_mode;
+    PMBusVoutMode *mode;
 
-    if (!visit_type_uint16(v, name, &value, errp)) {
+    if (!visit_type_uint32(v, name, &value, errp)) {
         return;
     }
-
-    *internal = pmbus_data2linear_mode(value, mode->exp);
+    if (strncmp(name, "vout[", 5) == 0) {
+        sscanf(name, "vout[%u]", &index);
+        mode = (PMBusVoutMode *)&pmdev->pages[index].vout_mode;
+        *internal = pmbus_milliunits2linear_mode(value, mode->exp);
+    } else {
+        *internal = value;
+    }
     pmbus_check_limits(pmdev);
 }
 
@@ -311,7 +318,7 @@ static void adm1266_init(Object *obj)
     for (int i = 0; i < ADM1266_NUM_PAGES; i++) {
         pmbus_page_config(pmdev, i, flags);
 
-        object_property_add(obj, "vout[*]", "uint16",
+        object_property_add(obj, "vout[*]", "uint32",
                             adm1266_get,
                             adm1266_set, NULL, &pmdev->pages[i].read_vout);
     }
diff --git a/tests/qtest/adm1266-test.c b/tests/qtest/adm1266-test.c
index fa8bbc5795..fd3d8079b6 100644
--- a/tests/qtest/adm1266-test.c
+++ b/tests/qtest/adm1266-test.c
@@ -16,6 +16,7 @@
 #include "qobject/qdict.h"
 #include "qobject/qnum.h"
 #include "qemu/bitops.h"
+#include "qemu/bswap.h"
 
 #define TEST_ID "adm1266-test"
 #define TEST_ADDR (0x12)
@@ -45,6 +46,57 @@
 #define TEST_STRING_B                           "b sample"
 #define TEST_STRING_C                           "rev c"
 
+#define ADM1266_NUM_PAGES                       17
+#define ADM1266_MAX_VALUE                       65535000
+
+typedef union {
+    uint8_t raw;
+    PMBusVoutMode mode;
+} ADM1266VoutMode;
+
+static uint32_t qmp_adm1266_get(const char *id, const char *property)
+{
+    QDict *response;
+    uint32_t ret;
+    response = qmp("{ 'execute': 'qom-get', 'arguments': { 'path': %s, "
+                   "'property': %s } }", id, property);
+    g_assert(qdict_haskey(response, "return"));
+    ret = qnum_get_uint(qobject_to(QNum, qdict_get(response, "return")));
+    qobject_unref(response);
+    return ret;
+}
+
+static void qmp_adm1266_set(const char *id,
+                             const char *property,
+                             uint32_t value)
+{
+    QDict *response;
+
+    response = qmp("{ 'execute': 'qom-set', 'arguments': { 'path': %s, "
+                   "'property': %s, 'value': %u } }",
+                   id, property, value);
+    g_assert(qdict_haskey(response, "return"));
+}
+
+static uint64_t adm1266_linear_mode2milliunits(uint16_t value, int exp)
+{
+    /* D = L * 2^e */
+    uint64_t val = value;
+    uint64_t ret;
+
+    if (exp < 0) {
+        ret = DIV_ROUND_CLOSEST((val * 1000), 1ULL << (-exp));
+    } else {
+        ret = (val << exp) * 1000;
+    }
+
+    if (ret > UINT32_MAX) {
+        return UINT32_MAX;
+    }
+
+    return ret;
+}
+
 static void compare_string(QI2CDevice *i2cdev, uint8_t reg,
                            const char *test_str)
 {
@@ -67,6 +119,98 @@ static void write_and_compare_string(QI2CDevice *i2cdev, uint8_t reg,
     compare_string(i2cdev, reg, test_str);
 }
 
+static void test_vout_milliunits(void *obj, void *data, QGuestAllocator *alloc)
+{
+    uint16_t i2c_value, value;
+    uint64_t i2c_milliunits;
+    QI2CDevice *i2cdev = (QI2CDevice *)obj;
+    char *path;
+    ADM1266VoutMode m;
+
+    /* set a different value in millivolts for each page */
+    for (int i = 0; i < ADM1266_NUM_PAGES; i++) {
+        path = g_strdup_printf("vout[%d]", i);
+        qmp_adm1266_set(TEST_ID, path, (1000 * (i + 1)));
+    }
+
+    for (int i = 0; i < ADM1266_NUM_PAGES; i++) {
+        i2c_set8(i2cdev, PMBUS_PAGE, i);
+
+        m.raw = i2c_get8(i2cdev, PMBUS_VOUT_MODE);
+        i2c_value = bswap16(i2c_get16(i2cdev, PMBUS_READ_VOUT));
+        i2c_milliunits = adm1266_linear_mode2milliunits(i2c_value, m.mode.exp);
+        g_assert_cmpuint(i2c_milliunits, ==, (1000 * (i + 1)));
+
+        path = g_strdup_printf("vout[%d]", i);
+        value = qmp_adm1266_get(TEST_ID, path);
+        g_assert_cmpuint(value, ==, (1000 * (i + 1)));
+    }
+}
+
+/*
+ * Note that the exponent determines the dynamic range, large exponents can not
+ * be used with values that need to be incremented in small steps
+ */
+static void test_vout_mode_exponent(void *obj, void *data,
+                                    QGuestAllocator *alloc)
+{
+    uint16_t i2c_value, value, expected;
+    uint64_t i2c_milliunits;
+    QI2CDevice *i2cdev = (QI2CDevice *)obj;
+    ADM1266VoutMode m;
+    char *path;
+
+    /* set a different exponent per page and a different value */
+    for (int i = 0; i < ADM1266_NUM_PAGES; i++) {
+        i2c_set8(i2cdev, PMBUS_PAGE, i);
+        expected = 1000 * (i * 2);
+        m.mode.exp = i - 14;
+        i2c_set8(i2cdev, PMBUS_VOUT_MODE, m.raw);
+        path = g_strdup_printf("vout[%d]", i);
+        qmp_adm1266_set(TEST_ID, path, expected);
+    }
+
+    for (int i = 0; i < ADM1266_NUM_PAGES; i++) {
+        i2c_set8(i2cdev, PMBUS_PAGE, i);
+        expected = 1000 * (i * 2);
+        /* check correct value from i2c*/
+        m.raw = i2c_get8(i2cdev, PMBUS_VOUT_MODE);
+        i2c_value = bswap16(i2c_get16(i2cdev, PMBUS_READ_VOUT));
+        i2c_milliunits = adm1266_linear_mode2milliunits(i2c_value, m.mode.exp);
+        g_assert_cmpuint(i2c_milliunits, ==, expected);
+
+        /* check correct value from qmp*/
+        path = g_strdup_printf("vout[%d]", i);
+        value = qmp_adm1266_get(TEST_ID, path);
+        g_assert_cmpuint(value, ==, expected);
+    }
+}
+
+static void test_vout_clamp_to_max(void *obj, void *data,
+                                   QGuestAllocator *alloc)
+{
+    uint16_t i2c_value;
+    uint32_t value;
+    QI2CDevice *i2cdev = (QI2CDevice *)obj;
+    char *path;
+
+    for (int i = 0; i < ADM1266_NUM_PAGES; i++) {
+        path = g_strdup_printf("vout[%d]", i);
+        qmp_adm1266_set(TEST_ID, path, 90000000);
+    }
+
+    for (int i = 0; i < ADM1266_NUM_PAGES; i++) {
+        i2c_set8(i2cdev, PMBUS_PAGE, i);
+
+        i2c_value = bswap16(i2c_get16(i2cdev, PMBUS_READ_VOUT));
+        g_assert_cmpuint(i2c_value, ==, UINT16_MAX);
+
+        path = g_strdup_printf("vout[%d]", i);
+        value = qmp_adm1266_get(TEST_ID, path);
+        g_assert_cmpuint(value, ==, ADM1266_MAX_VALUE);
+    }
+}
+
 static void test_defaults(void *obj, void *data, QGuestAllocator *alloc)
 {
     uint16_t i2c_value;
@@ -128,6 +272,12 @@ static void adm1266_register_nodes(void)
     qos_add_test("test_defaults", "adm1266", test_defaults, NULL);
     qos_add_test("test_partial_reads", "adm1266", test_partial_reads, NULL);
     qos_add_test("test_rw_regs", "adm1266", test_rw_regs, NULL);
+    qos_add_test("test_vout_milliunits", "adm1266",
+                    test_vout_milliunits, NULL);
+    qos_add_test("test_vout_mode_exponent", "adm1266",
+                    test_vout_mode_exponent, NULL);
+    qos_add_test("test_vout_clamp_to_max", "adm1266",
+                    test_vout_clamp_to_max, NULL);
 }
 
 libqos_init(adm1266_register_nodes);
-- 
2.55.0.508.g3f0d502094-goog


