Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 07E2AC79FA0
	for <qemu-devel@archiver.kernel.org>; Mon,  7 Sep 2026 16:51:39 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x3cYm-0002Us-E4; Mon, 07 Sep 2026 12:51:08 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eblot.ml@gmail.com>)
 id 1x3cYi-0002FA-Em
 for qemu-devel@nongnu.org; Mon, 07 Sep 2026 12:51:05 -0400
Received: from mail-wm1-f42.google.com ([209.85.128.42])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <eblot.ml@gmail.com>)
 id 1x3cYg-0004lf-Ht
 for qemu-devel@nongnu.org; Mon, 07 Sep 2026 12:51:04 -0400
Received: by mail-wm1-f42.google.com with SMTP id
 5b1f17b1804b1-49557167508so45566515e9.1
 for <qemu-devel@nongnu.org>; Mon, 07 Sep 2026 09:51:02 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1788799861; x=1789404661;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=Fhp3wv+1ffAiyOIOMf1hqrOLyXTWHsYqm0QrDErev70=;
 b=l67D6hCYmIfV2Z8xLsO033pONJXa1peN5KkZbofINV6dik3w84gE7CLV8R3G7Rlthw
 6bhi1OZZ2olv/I5uKBReLf99kwraZgLLGXLPf1ZrXYf5cnkEsRUBIqlDGEJAsmBVfJrF
 6h4MhONZ7eoXzgB5bLRaYjDemsyHtpUuRzU784J1v4VfnG+HkcZ6WW91trFyZKEcRhul
 dMIQaB8R3pN94UxR0oor72R8o12dg92hHYVJFbjK0Kbnt53W+PikRDbSDMuekK7FOYRP
 NZMNtMgVLUjBqKI+d5r7D5j/K8kuGZ0XbizbySryQ3sB1MA63QfCkj47tO5estEk3gDs
 ek8g==
X-Gm-Message-State: AFuF++kANG1f9CFRZcozl9JhCCCeuzpgxCyjuMpKd4zzLy1pzk0GM43g
 9j19kz+haJo5k4PZKzBQlTQZw1Z1SRHg07y14jVBnjYjCW06CP04bcnWSl+wWA6o
X-Gm-Gg: AYBFou2BsU8rjQ/HUoIZ9RWEF1hBVZaEBw+1seG6mOGv/U7BUnp+wp6FnRgeeyNce3U
 ArOED/glfGZXs3e993RmE5dHSCsM3jDYP2fH73d8LyjvDM1TCfbQct98n9mBr7TnpydFodSo5/H
 zIPrYHJnhMAbR7JwNBuGuy8ZRYZOD/mC4rRtIn+NfNYLrvoP2q5dTTRBq4+whO96xi+gBgczSXI
 znRP+eVPG5GCqSliB3IandBkHu65Wski9/WC4fxwOE+tgWGVaddLHVtzlLaw9TwxuODTtc542M4
 SBaKZDdK4UgLKkUp2KnkyjREOkFdcRrJkJPMGvrbd41YV5RK7SSmZc/rAWiv1Lk4hfB3o/Ga8vL
 tXe6DfmFFw2k62+LaCzCyZ8cWPEss2tGFK5KLi3aIld0p6AjYsRl2TxHDtT0DP+/bQcsDE/FCof
 60lnEPvoioOr+B78Q+svwqrL/nciiV4067OlPr4fEX4qSp3FSi16ZjD3ms+o+uUDRsf39w4L4tR
 4ZNRmXjlvFMluhgVDc0NCdT96LK2+F0Abc=
X-Received: by 2002:a05:600c:8b6d:b0:499:a277:e8b5 with SMTP id
 5b1f17b1804b1-49cf7fdd67emr472184325e9.3.1788799860933; 
 Mon, 07 Sep 2026 09:51:00 -0700 (PDT)
Received: from localhost (89-93-216-19.hfc.dyn.abo.bbox.fr. [89.93.216.19])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-49cee6023edsm395323705e9.7.2026.09.07.09.51.00
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 07 Sep 2026 09:51:00 -0700 (PDT)
Date: Mon, 07 Sep 2026 18:42:34 +0200
Subject: [PATCH 44/50] tests/qtest: ina238: cover the injection-property limits
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260907-bmc-minerva-v1-44-0d83ad610c3b@free.fr>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1788799322; l=5321;
 i=emmanuel.blot@free.fr; s=20260602; h=from:subject:message-id;
 bh=JgwMXMS8XORDALoqQbGBJ4suPCUY8Bpl7Mu6Xt66s/I=;
 b=ghdomYm5NbgxW+l57AwahoI9RVFSmUDme67jUzTWHLJzgUwbqOm45fAOnxeMz/Ja9IjJJ1O9w
 kSJl1kETiLUDXT92RbEcfoxMFK1LF+oMprgCFvcfRfUj4ytZ8rw9asR
X-Developer-Key: i=emmanuel.blot@free.fr; a=ed25519;
 pk=0qFrZ21FAAN8OfVsSoVcCFTk/NMYOWzxJz4paSAVm0g=
Received-SPF: pass client-ip=209.85.128.42; envelope-from=eblot.ml@gmail.com;
 helo=mail-wm1-f42.google.com
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
2.50.1


