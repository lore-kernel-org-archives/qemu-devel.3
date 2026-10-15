Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 66FF9CC6B30
	for <qemu-devel@archiver.kernel.org>; Thu, 15 Oct 2026 10:33:06 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xHIlh-0005RL-KR; Thu, 15 Oct 2026 06:33:01 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eblot.ml@gmail.com>)
 id 1xHIi3-0008BP-8X
 for qemu-devel@nongnu.org; Thu, 15 Oct 2026 06:29:16 -0400
Received: from mail-wr1-f46.google.com ([209.85.221.46])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <eblot.ml@gmail.com>)
 id 1xHIi0-0004X8-ME
 for qemu-devel@nongnu.org; Thu, 15 Oct 2026 06:29:14 -0400
Received: by mail-wr1-f46.google.com with SMTP id
 ffacd0b85a97d-48c5358fc28so200984f8f.0
 for <qemu-devel@nongnu.org>; Thu, 15 Oct 2026 03:29:12 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792060151; x=1792664951;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=fK1yTBZ+R4UZ9jGLZP5etFoRte2w8wAdC3Wr5b6SMuI=;
 b=f2r0mWLZBqq0VGHSqp0/mCKrl1CyL/isL6BPrUMmhOzw4Rp5sBoydcWfVKb9d0Cdrb
 H1fv6lrBoWmvzc1RDBbo2ksP2ts69qL4sGImKyHlmiYW5h0U5LDzYDbTQOMHCC4pqH6C
 +fh0HeZasndPsLpCKu2WA+h2Y/J/+SK86SkT2xBY2zSW5H8hYMLT+iiEX9pg63p8+unV
 vb8d+2KTxWs8/l7KWSrSD2xlWJd95tiigYKRQgDbUSr726/lFhHdslB117RqJ8JvcZWK
 8laF5Ih+rll8ILbHG9nfApkyXG9X5vSBBJp6mD6S4E/+52sMwsEv7WftJx1/JvBqr2gv
 Gu3w==
X-Gm-Message-State: AFq9FYISfCnURIymLrvOEYuc1W7HVjIXDSXGdWQUfoLqOE5BCuiEIZdr
 z6Rg/4TlgojmONwwPeFNwgUhK0LQEKLODO17CtA4ugpdmaXx3v2monNn/NTzUw==
X-Gm-Gg: AYBFou3OcJP0meb9cr12ePnpx2mLt+FPt0WASqEzH2rshgwfLENjQBG5wwoEiqBhacp
 XXEedAQSBWdZ54ZH9fsAWZniB3Dh7ah3py4WZ2QOuLLXu5skXFIHNg6zV5c9brez7JRuj7IPb5y
 AsYlMrrB5VILGl1BMGcxC2HMK5Z/R8JV1dts/1J4gt9CSUcR4f3Vf6ncx17Slg8l+iswCItunLv
 MKfT5AHYYMW5vZVfvECbqQtA5OtdE0IFoY4pT5ztdFS1LZ3tqlnH2SSJtcGmcN4LKykv9afVqoP
 OlxIuypXBtxS7O5m2k8ySbSseYSeJt9Enj7jaPlSt66+Ir5/vD6kz74E+WbcjpNkacu5B+USIHV
 o8HVCVZmKs92OQ4hriYtGo20XxYNS5cEUtlQB5kAAXhhK3dB5xE/TXjEpAXNkx4Ifu2wpaNHI/9
 oloA9/xOBFtr8ZUEGToVBbLEfaL3J4UD1WUgI8prbB2oBVQmLYbVBRN9+H2hyhaOzUCrEVC7MxZ
 ALMvKilNl8aLb9X7l1WZ++4TVp5zeSnbvGf24ilVosxFbzypx5olFmY
X-Received: by 2002:adf:e005:0:20b0:487:2443:7526 with SMTP id
 ffacd0b85a97d-48dbacf6f1fmr26735193f8f.55.1792060151095; 
 Thu, 15 Oct 2026 03:29:11 -0700 (PDT)
Received: from localhost (89-93-216-19.hfc.dyn.abo.bbox.fr. [89.93.216.19])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-48df3a25b41sm3925112f8f.46.2026.10.15.03.29.10
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 15 Oct 2026 03:29:10 -0700 (PDT)
Date: Thu, 15 Oct 2026 11:28:31 +0200
Subject: [PATCH v3 44/50] tests/qtest: ina238: cover the injection-property
 limits
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261015-bmc-minerva-v3-44-7d50c8a108e5@free.fr>
References: <20261015-bmc-minerva-v3-0-7d50c8a108e5@free.fr>
In-Reply-To: <20261015-bmc-minerva-v3-0-7d50c8a108e5@free.fr>
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
 Emmanuel Blot <emmanuel.blot@free.fr>, Glenn Miles <milesg@linux.ibm.com>
X-Mailer: b4 0.16.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1792056477; l=5375;
 i=emmanuel.blot@free.fr; s=20260602; h=from:subject:message-id;
 bh=cK0KtEZakGGTiCMBuvt6S8R0Yj1qS5lBpstYZd6Z9WY=;
 b=Hs8Q/rUHke2aLNfzWDp7o3ZAqeNrgh6w3ivLdfsiGOksNKtafg9nYYzCQuDEKZndE0VOMw9r2
 bs6qfss/69lBY8Y1MH/mEpQR2CHC4fFC6Ks77aA7Xkm62R2/q3pT/2l
X-Developer-Key: i=emmanuel.blot@free.fr; a=ed25519;
 pk=0qFrZ21FAAN8OfVsSoVcCFTk/NMYOWzxJz4paSAVm0g=
Received-SPF: pass client-ip=209.85.221.46; envelope-from=eblot.ml@gmail.com;
 helo=mail-wr1-f46.google.com
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

Verify that the extremes of the shunt-voltage, bus-voltage and
die-temperature injection ranges round-trip through the QOM property
without truncation or wraparound, and that values just outside are
rejected rather than silently wrapped.

Reviewed-by: Glenn Miles <milesg@linux.ibm.com>
Signed-off-by: Emmanuel Blot <emmanuel.blot@free.fr>
---
 tests/qtest/ina238-test.c | 84 +++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 84 insertions(+)

diff --git a/tests/qtest/ina238-test.c b/tests/qtest/ina238-test.c
index 08813377c9..74912424c0 100644
--- a/tests/qtest/ina238-test.c
+++ b/tests/qtest/ina238-test.c
@@ -67,6 +67,13 @@
 #define MANUFACTURER_ID_VAL 0x5449
 #define DEVICE_ID_VAL       0x2381
 
+/* Injection-property limits (see ina238.c) */
+#define SHUNT_MIN_NV        (-163840000) /* -32768 * 5 uV  */
+#define SHUNT_MAX_NV        163835000    /*  32767 * 5 uV  */
+#define BUS_MAX_UV          85000000     /* 27200 * 3.125 mV */
+#define TEMP_MIN_MC         (-40000)     /*  -320 * 125 m-degC */
+#define TEMP_MAX_MC         125000       /*  1000 * 125 m-degC */
+
 /* Read the 24-bit POWER register (MSB first) */
 static uint32_t i2c_get24(QI2CDevice *dev, uint8_t reg)
 {
@@ -103,6 +110,18 @@ static int qmp_ina238_get(const char *property)
     return ret;
 }
 
+/* A qom-set expected to be rejected (value outside the supported range) */
+static void qmp_ina238_set_fail(const char *property, int64_t value)
+{
+    QDict *resp;
+
+    resp = qmp("{ 'execute': 'qom-set', 'arguments':"
+               " { 'path': %s, 'property': %s, 'value': %lld } }",
+               INA238_TEST_ID, property, (long long)value);
+    g_assert(qdict_haskey(resp, "error"));
+    qobject_unref(resp);
+}
+
 /* Power-on-reset default values and the ID registers */
 static void test_defaults(void *obj, void *data, QGuestAllocator *alloc)
 {
@@ -443,6 +462,68 @@ static void test_cnvrf(void *obj, void *data, QGuestAllocator *alloc)
     g_assert_cmphex(i2c_get16(dev, REG_DIAG_ALRT) & DIAG_CNVRF, ==, 0);
 }
 
+/* Shunt-voltage injection limits */
+static void test_shunt_limits(void *obj, void *data, QGuestAllocator *alloc)
+{
+    QI2CDevice *dev = (QI2CDevice *)obj;
+
+    i2c_set16(dev, REG_CONFIG, CONFIG_RST);
+
+    qmp_ina238_set("shunt-voltage", SHUNT_MAX_NV);
+    g_assert_cmphex(i2c_get16(dev, REG_VSHUNT), ==, 0x7FFF);
+    g_assert_cmpint(qmp_ina238_get("shunt-voltage"), ==, SHUNT_MAX_NV);
+
+    qmp_ina238_set("shunt-voltage", SHUNT_MIN_NV);
+    g_assert_cmphex(i2c_get16(dev, REG_VSHUNT), ==, 0x8000);
+    g_assert_cmpint(qmp_ina238_get("shunt-voltage"), ==, SHUNT_MIN_NV);
+
+    qmp_ina238_set_fail("shunt-voltage", (int64_t)SHUNT_MAX_NV + 1);
+    qmp_ina238_set_fail("shunt-voltage", (int64_t)SHUNT_MIN_NV - 1);
+    g_assert_cmpint(qmp_ina238_get("shunt-voltage"), ==, SHUNT_MIN_NV);
+    g_assert_cmphex(i2c_get16(dev, REG_VSHUNT), ==, 0x8000);
+}
+
+/* Bus-voltage injection limits */
+static void test_bus_limits(void *obj, void *data, QGuestAllocator *alloc)
+{
+    QI2CDevice *dev = (QI2CDevice *)obj;
+
+    i2c_set16(dev, REG_CONFIG, CONFIG_RST);
+
+    qmp_ina238_set("bus-voltage", 0);
+    g_assert_cmphex(i2c_get16(dev, REG_VBUS), ==, 0x0000);
+
+    qmp_ina238_set("bus-voltage", BUS_MAX_UV);
+    g_assert_cmphex(i2c_get16(dev, REG_VBUS), ==, 0x6A40);
+    g_assert_cmpint(qmp_ina238_get("bus-voltage"), ==, BUS_MAX_UV);
+
+    qmp_ina238_set_fail("bus-voltage", (int64_t)BUS_MAX_UV + 1);
+    qmp_ina238_set_fail("bus-voltage", -1);
+    g_assert_cmpint(qmp_ina238_get("bus-voltage"), ==, BUS_MAX_UV);
+    g_assert_cmphex(i2c_get16(dev, REG_VBUS), ==, 0x6A40);
+}
+
+/* Die-temperature injection limits */
+static void test_temp_limits(void *obj, void *data, QGuestAllocator *alloc)
+{
+    QI2CDevice *dev = (QI2CDevice *)obj;
+
+    i2c_set16(dev, REG_CONFIG, CONFIG_RST);
+
+    qmp_ina238_set("die-temperature", TEMP_MAX_MC);
+    g_assert_cmphex(i2c_get16(dev, REG_DIETEMP), ==, 0x3E80);
+    g_assert_cmpint(qmp_ina238_get("die-temperature"), ==, TEMP_MAX_MC);
+
+    qmp_ina238_set("die-temperature", TEMP_MIN_MC);
+    g_assert_cmphex(i2c_get16(dev, REG_DIETEMP), ==, 0xEC00);
+    g_assert_cmpint(qmp_ina238_get("die-temperature"), ==, TEMP_MIN_MC);
+
+    qmp_ina238_set_fail("die-temperature", (int64_t)TEMP_MAX_MC + 1);
+    qmp_ina238_set_fail("die-temperature", (int64_t)TEMP_MIN_MC - 1);
+    g_assert_cmpint(qmp_ina238_get("die-temperature"), ==, TEMP_MIN_MC);
+    g_assert_cmphex(i2c_get16(dev, REG_DIETEMP), ==, 0xEC00);
+}
+
 static void ina238_register_nodes(void)
 {
     QOSGraphEdgeOptions opts = {
@@ -459,6 +540,9 @@ static void ina238_register_nodes(void)
     qos_add_test("shunt-injection", "ina238", test_shunt_injection, NULL);
     qos_add_test("bus-injection", "ina238", test_bus_injection, NULL);
     qos_add_test("temp-injection", "ina238", test_temp_injection, NULL);
+    qos_add_test("shunt-limits", "ina238", test_shunt_limits, NULL);
+    qos_add_test("bus-limits", "ina238", test_bus_limits, NULL);
+    qos_add_test("temp-limits", "ina238", test_temp_limits, NULL);
     qos_add_test("calibration-current", "ina238", test_calibration_current,
                  NULL);
     qos_add_test("power", "ina238", test_power, NULL);

-- 
2.53.0-Meta


