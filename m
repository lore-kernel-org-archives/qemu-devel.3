Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 380F6606A326
	for <qemu-devel@archiver.kernel.org>; Thu,  5 Nov 2026 09:14:50 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xOtYG-0005So-Ke; Thu, 05 Nov 2026 04:14:34 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eblot.ml@gmail.com>)
 id 1xOtXl-00056o-On
 for qemu-devel@nongnu.org; Thu, 05 Nov 2026 04:14:06 -0500
Received: from mail-pl1-f171.google.com ([209.85.214.171])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <eblot.ml@gmail.com>)
 id 1xOtXj-0005Qe-Ms
 for qemu-devel@nongnu.org; Thu, 05 Nov 2026 04:14:01 -0500
Received: by mail-pl1-f171.google.com with SMTP id
 d9443c01a7336-2ed2b4348fcso1393975ad.2
 for <qemu-devel@nongnu.org>; Thu, 05 Nov 2026 01:13:59 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793870038; x=1794474838;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=YHMfEpRBCghPOlLiattQp/tdJSULFxB9dFeHDoCkMiY=;
 b=QEap/T3kHmPGPXZ9PvQ1Iqz8fSUbk33mkVweyXR4tBM0LMp5swdODwO+yYkCcl9qTf
 Z6WJzpQhvldRPK18MCR5chfDinjKFxt6/8mW3sDvpc8v2KWcBL31eldzmT2oLdc8mDs8
 plup/KM3xIHWY6mj1W44arSalpCQRUZIcWGVX74IjLFmv9qUejf+ibEKVoSIvDsV+elR
 1Avgu0knrnaOW7WIRuBmUJw1r8G+2+lCVqAvRp8rr54JFtLVub/sb7+af+zOTQ71aGf+
 ZciMtAolrtm1FdbP/Afj9WTD2ALQsH9Q9QFb2YNE2SCvTo4MBKslsC3+rsk48NuUM8Ci
 i5VA==
X-Gm-Message-State: APuU4Z+rLYGuUoIbANJxutCM7f6j5OQGYUdx4a7E6LD2JL3FbLJO8QqF
 wtacyvOlMuatLJg7RAjpWyfH+FE8Y7NCcb26eqkVu18k6X2Dez8ngFtglTWq711tcp8=
X-Gm-Gg: AYBFou1y3Veupx5m0tC2ypPAq/tK8W+d/R7KV1wqfu4l3FflliYUaj/pxdRFQHyXKY+
 AEiXaZtik6tWsaDMo35ll7ggMsZvpsblO6Z5cmUTZSsyeQLoop1/RTbwMztMCHhxb2XMJihvkKS
 hjYz5LEQ0a/uTfAXKPdwuZw4eOh+uL6ulCKdMTPh7OANuQ1BC3QTqY0wuRmEEjJ3OsWs8ncmDWs
 ceh69tlSvdgYMFv2LF284EwVBD9SKwZCOcIfxwgDu1Yw5KGynnOOxD91JYSR0GZRIq8sv8gJ0eN
 m0Uwn1BTlL1qeL+98oF3d4pjFSlsvKP0xAXEAQXOCN350bnXTcRuQVihBREOQFgsJ0G1o0NMHvX
 ByAEwqoovTZjpnSF6e+K9zRG7eNCdpOUlZiCUT1QeL6I8PfvM3ZJowGCvUPOxc3BnOW+rVRpgI9
 VaB1opd7azsJRXZDNAQpxwLo6EdrVWZj9RRY1IzOHmqPZr3WlPChknDvcOkCWZabS4ow2xqrsUm
 hrru22PONoyhwUGFHnnEpHBWvCj5ArfmLpSX+ZCIctW2/RZ724iixOuwYjFG7zUMG68vK8hZ3NS
 aM1pOlBRBi2IePuhwwTZZb/8XMCmp74Vjm1fSo2B/jHtVuEKbOOWYkIRuhTadb03pRLnKsA4aJk
 S7FGT1A==
X-Received: by 2002:a17:903:1c7:b0:2ed:1e4e:cf3e with SMTP id
 d9443c01a7336-2ed1e4ecf92mr26026975ad.29.1793870038170; 
 Thu, 05 Nov 2026 01:13:58 -0800 (PST)
Received: from localhost (118-163-122-149.hinet-ip.hinet.net.
 [118.163.122.149]) by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2ed091b5267sm15675255ad.62.2026.11.05.01.13.57
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 05 Nov 2026 01:13:57 -0800 (PST)
Date: Thu, 05 Nov 2026 17:12:55 +0800
Subject: [PATCH 03/16] tests/qtest: ina230: cover voltage injection and
 power derivation
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261105-sensor-ina23x-v1-3-5433ed104990@free.fr>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1793869975; l=5805;
 i=emmanuel.blot@free.fr; s=20260602; h=from:subject:message-id;
 bh=NCCZ3C0XT97Dof+ZcjxjWcN4sAhVvyKJXvbHGJ+/418=;
 b=ah1xyy0TKPIP1tY6f2ghQ1O4CkmAD/cIokJ2o5Lttmb5M/7CTt2H3JMCwpsIakM6A1vVl1E3v
 O4gjYBszuT5BQeE+KJ+D3MUiLecZi7Lmopr/vOwztx+U9BeuI3CxL+K
X-Developer-Key: i=emmanuel.blot@free.fr; a=ed25519;
 pk=0qFrZ21FAAN8OfVsSoVcCFTk/NMYOWzxJz4paSAVm0g=
Received-SPF: pass client-ip=209.85.214.171; envelope-from=eblot.ml@gmail.com;
 helo=mail-pl1-f171.google.com
X-Spam_score_int: -15
X-Spam_score: -1.6
X-Spam_bar: -
X-Spam_report: (-1.6 / 5.0 requ) BAYES_00=-1.9,
 FREEMAIL_FORGED_FROMDOMAIN=0.001, FREEMAIL_FROM=0.001,
 HEADER_FROM_DIFFERENT_DOMAINS=0.249, RCVD_IN_DNSWL_NONE=-0.0001,
 RCVD_IN_MSPIKE_H2=0.001, SPF_HELO_NONE=0.001,
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

Cover the shunt- and bus-voltage injection properties and the current
and power values the device derives from them through the Calibration
register, including the zero-calibration case and the clamp/overflow
edges.

Reviewed-by: Glenn Miles <milesg@linux.ibm.com>
Signed-off-by: Emmanuel Blot <emmanuel.blot@free.fr>
---
 tests/qtest/ina230-test.c | 124 ++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 124 insertions(+)

diff --git a/tests/qtest/ina230-test.c b/tests/qtest/ina230-test.c
index f7aefd2d97..b01f9445d1 100644
--- a/tests/qtest/ina230-test.c
+++ b/tests/qtest/ina230-test.c
@@ -49,6 +49,33 @@
 
 #define DIE_ID_VAL          0x2310
 
+/* QMP helpers for injecting the physical inputs */
+
+static void qmp_ina230_set(const char *property, int value)
+{
+    QDict *resp;
+
+    resp = qmp("{ 'execute': 'qom-set', 'arguments':"
+               " { 'path': %s, 'property': %s, 'value': %d } }",
+               INA230_TEST_ID, property, value);
+    g_assert(qdict_haskey(resp, "return"));
+    qobject_unref(resp);
+}
+
+static int qmp_ina230_get(const char *property)
+{
+    QDict *resp;
+    int ret;
+
+    resp = qmp("{ 'execute': 'qom-get', 'arguments':"
+               " { 'path': %s, 'property': %s } }",
+               INA230_TEST_ID, property);
+    g_assert(qdict_haskey(resp, "return"));
+    ret = qdict_get_int(resp, "return");
+    qobject_unref(resp);
+    return ret;
+}
+
 /* Power-on-reset default values and the Die ID */
 static void test_defaults(void *obj, void *data, QGuestAllocator *alloc)
 {
@@ -98,6 +125,96 @@ static void test_config_wmask(void *obj, void *data, QGuestAllocator *alloc)
     g_assert_cmphex(i2c_get16(dev, REG_CONFIG), ==, 0x7FFF);
 }
 
+/* Shunt voltage register, including two's-complement negatives */
+static void test_shunt_injection(void *obj, void *data, QGuestAllocator *alloc)
+{
+    QI2CDevice *dev = (QI2CDevice *)obj;
+
+    qmp_ina230_set("shunt-voltage", 20000000);
+    g_assert_cmphex(i2c_get16(dev, REG_SHUNT), ==, 0x1F40);
+
+    qmp_ina230_set("shunt-voltage", -80000000);
+    g_assert_cmphex(i2c_get16(dev, REG_SHUNT), ==, 0x8300);
+
+    g_assert_cmpint(qmp_ina230_get("shunt-voltage"), ==, -80000000);
+}
+
+/* Bus voltage register */
+static void test_bus_injection(void *obj, void *data, QGuestAllocator *alloc)
+{
+    QI2CDevice *dev = (QI2CDevice *)obj;
+
+    qmp_ina230_set("bus-voltage", 12000000);
+    g_assert_cmphex(i2c_get16(dev, REG_BUS), ==, 0x2580);
+
+    qmp_ina230_set("bus-voltage", 11980000);
+    g_assert_cmphex(i2c_get16(dev, REG_BUS), ==, 0x2570);
+}
+
+/* Calibration-derived current, using the datasheet worked example */
+static void test_calibration_current(void *obj, void *data,
+                                     QGuestAllocator *alloc)
+{
+    QI2CDevice *dev = (QI2CDevice *)obj;
+
+    i2c_set16(dev, REG_CONFIG, CONFIG_RST);
+
+    qmp_ina230_set("shunt-voltage", 20000000);
+    g_assert_cmphex(i2c_get16(dev, REG_CURRENT), ==, 0x0000);
+
+    i2c_set16(dev, REG_CALIBRATION, 0x0A00);
+    g_assert_cmphex(i2c_get16(dev, REG_CURRENT), ==, 0x2710);
+}
+
+/* Calibration-derived power, using the datasheet worked example */
+static void test_power(void *obj, void *data, QGuestAllocator *alloc)
+{
+    QI2CDevice *dev = (QI2CDevice *)obj;
+
+    i2c_set16(dev, REG_CONFIG, CONFIG_RST);
+
+    qmp_ina230_set("shunt-voltage", 20000000);
+    qmp_ina230_set("bus-voltage", 11980000);
+    i2c_set16(dev, REG_CALIBRATION, 0x0A00);
+
+    g_assert_cmphex(i2c_get16(dev, REG_POWER), ==, 0x12B8);
+}
+
+/* With Calibration == 0 the Current and Power registers stay at zero */
+static void test_zero_cal(void *obj, void *data, QGuestAllocator *alloc)
+{
+    QI2CDevice *dev = (QI2CDevice *)obj;
+
+    i2c_set16(dev, REG_CONFIG, CONFIG_RST);
+
+    qmp_ina230_set("shunt-voltage", 20000000);
+    qmp_ina230_set("bus-voltage", 11980000);
+
+    g_assert_cmphex(i2c_get16(dev, REG_CURRENT), ==, 0x0000);
+    g_assert_cmphex(i2c_get16(dev, REG_POWER), ==, 0x0000);
+}
+
+/* Clamping at full scale and the OVF (math overflow) flag */
+static void test_edges_overflow(void *obj, void *data, QGuestAllocator *alloc)
+{
+    QI2CDevice *dev = (QI2CDevice *)obj;
+
+    i2c_set16(dev, REG_CONFIG, CONFIG_RST);
+
+    qmp_ina230_set("shunt-voltage", 81917500);
+    g_assert_cmphex(i2c_get16(dev, REG_SHUNT), ==, 0x7FFF);
+    qmp_ina230_set("shunt-voltage", -81920000);
+    g_assert_cmphex(i2c_get16(dev, REG_SHUNT), ==, 0x8000);
+
+    qmp_ina230_set("bus-voltage", 36000000);
+    g_assert_cmphex(i2c_get16(dev, REG_BUS), ==, 0x7080);
+
+    qmp_ina230_set("shunt-voltage", 20000000);
+    i2c_set16(dev, REG_CALIBRATION, 0x7FFF);
+    g_assert_cmphex(i2c_get16(dev, REG_CURRENT), ==, 0x7FFF);
+    g_assert_cmphex(i2c_get16(dev, REG_MASK_ENABLE) & ME_OVF, ==, ME_OVF);
+}
+
 static void ina230_register_nodes(void)
 {
     QOSGraphEdgeOptions opts = {
@@ -111,5 +228,12 @@ static void ina230_register_nodes(void)
     qos_add_test("defaults", "ina230", test_defaults, NULL);
     qos_add_test("soft-reset", "ina230", test_soft_reset, NULL);
     qos_add_test("config-wmask", "ina230", test_config_wmask, NULL);
+    qos_add_test("shunt-injection", "ina230", test_shunt_injection, NULL);
+    qos_add_test("bus-injection", "ina230", test_bus_injection, NULL);
+    qos_add_test("calibration-current", "ina230", test_calibration_current,
+                 NULL);
+    qos_add_test("power", "ina230", test_power, NULL);
+    qos_add_test("zero-cal", "ina230", test_zero_cal, NULL);
+    qos_add_test("edges-overflow", "ina230", test_edges_overflow, NULL);
 }
 libqos_init(ina230_register_nodes);

-- 
2.53.0-Meta


