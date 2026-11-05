Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6BBDB606A326
	for <qemu-devel@archiver.kernel.org>; Thu,  5 Nov 2026 09:15:58 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xOtZT-00088D-Qw; Thu, 05 Nov 2026 04:15:48 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eblot.ml@gmail.com>)
 id 1xOtZ3-0006IK-0Q
 for qemu-devel@nongnu.org; Thu, 05 Nov 2026 04:15:21 -0500
Received: from mail-pf1-f172.google.com ([209.85.210.172])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <eblot.ml@gmail.com>)
 id 1xOtZ0-0005jN-Vd
 for qemu-devel@nongnu.org; Thu, 05 Nov 2026 04:15:20 -0500
Received: by mail-pf1-f172.google.com with SMTP id
 d2e1a72fcca58-8a05effaf8dso1033882b3a.2
 for <qemu-devel@nongnu.org>; Thu, 05 Nov 2026 01:15:17 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793870116; x=1794474916;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=fK1yTBZ+R4UZ9jGLZP5etFoRte2w8wAdC3Wr5b6SMuI=;
 b=Bp1rlkOihCdaGOJ8F6UtAoyCKl1NIsdK02HEVNNnAEIBBr7pZDPJp2QXr4YsGQmf41
 dvtWI1o8haEFUZSmB8wnoOkrLo/TDvvcJ6Q6gK0cklLJ1ONK3cxpmRGHdouCm8wX4LHb
 Wku6WqfMQwRcoiWAWXCZyB3eFxu/cfwnR2xrwutGLnQ2b1cWtCKmqznkP8uJRXVKTKKN
 ESoUm+hrzNktuGdGGrNbN2tf+YvOz0T7cYOyMKjW39jqQ4zbr8ct0FLjTvECE58l6MEw
 14eMMzQ1yMEN/0Jh/Wb22MzjVSAQzSR210YkYSTgGoklf5QdGVLoi8AW8fRR5Be9L4nE
 cX2w==
X-Gm-Message-State: APuU4Z+Da09zT6kMMcCsg7huwy6Ib8OsvbFqwP6ZRvSnmi1NnuVOfbdT
 1jISwErLd9BkkIVJRhZ3Qr4kiws43hSiGef64ThDnisMTLTy9s3OSLXmkARkDIx1frw=
X-Gm-Gg: AYBFou1eDmPSH4hIzTVL6f+eXdYkzq+YprgDZwzACOiAIAo1EPlLztkJZMHTJyhpOTS
 DSCOZxEIWtL8LLgIbMVhUJ9tHQkwW9SkjVuZDyd0QHrIS1zPl0qgt8zQMrTUaKqeUu3L65jhFS7
 04lcjqN1hiAIFwJo7DKinlTw7/XVb/FZnZxewpT8pLBlb1weAGCwIR2Zuey9wl8xLQ1bJxCw7zY
 NrnbtfG0qsyO974aytL8qUkwwM1e8IWWP05lN8rdMWYH7Uwl68249MwQ87qRzLnXzDtbHIrVQYc
 Mf9CaUy2CkGFe5emPHOro9OIE3lrAgqYIL3wqCEbV1ab26AArnzpDdCmw5N1yfnRgAHaNtWmX1v
 wc5ZaZWeQ9nkoCIzgdSTqC1D7lyJ8JKCF8q3Lerkw1HbzTcX0cDVAZEwF7ytWwofASdfIDXW7t6
 sS2CgpoKA8BrCQdI/I0r2B+dG3a+YqqdKPtpcwxsxx0uKInuKuPoPtH0HRNnKzRdJxOb2OdnX+W
 Y2V9sV4rguEtjPTtx7sJnlwB/a28jhKDTl8eCan4qv50Cow9f30YmO9gPGwY6EjBEkNBrbsaF6n
 SWQFtVwcNqb2ZJto5ZxYHWHWDib0wNUhVQLWmQRDxr0GUyEk33Xq2JaFY5InAxCixp/jP6Eu373
 /bMIPoQ==
X-Received: by 2002:a05:6a21:2982:b0:3dd:a197:edf4 with SMTP id
 adf61e73a8af0-3e928e21c8dmr17241587637.67.1793870116287; 
 Thu, 05 Nov 2026 01:15:16 -0800 (PST)
Received: from localhost (118-163-122-149.hinet-ip.hinet.net.
 [118.163.122.149]) by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-8b09bb47f6bsm1855235b3a.47.2026.11.05.01.15.15
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 05 Nov 2026 01:15:15 -0800 (PST)
Date: Thu, 05 Nov 2026 17:13:05 +0800
Subject: [PATCH 13/16] tests/qtest: ina238: cover the injection-property limits
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261105-sensor-ina23x-v1-13-5433ed104990@free.fr>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1793869976; l=5375;
 i=emmanuel.blot@free.fr; s=20260602; h=from:subject:message-id;
 bh=cK0KtEZakGGTiCMBuvt6S8R0Yj1qS5lBpstYZd6Z9WY=;
 b=3I3AwO0zF12w7UYNrVfmBdodPaNw4hI0q3yY25WAsMToiVcAydsa27HzqHe3oQAHs/Mkgr/Rf
 s/phemzgpTvDMDN0MjvHr/c7gh5hWbiUZxBUJRIWQPzBStc3q2utjht
X-Developer-Key: i=emmanuel.blot@free.fr; a=ed25519;
 pk=0qFrZ21FAAN8OfVsSoVcCFTk/NMYOWzxJz4paSAVm0g=
Received-SPF: pass client-ip=209.85.210.172; envelope-from=eblot.ml@gmail.com;
 helo=mail-pf1-f172.google.com
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


