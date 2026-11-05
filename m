Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B800B606A326
	for <qemu-devel@archiver.kernel.org>; Thu,  5 Nov 2026 09:16:17 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xOtZP-0007Ve-5N; Thu, 05 Nov 2026 04:15:43 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eblot.ml@gmail.com>)
 id 1xOtYm-0006B8-Vs
 for qemu-devel@nongnu.org; Thu, 05 Nov 2026 04:15:07 -0500
Received: from mail-pj1-f50.google.com ([209.85.216.50])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <eblot.ml@gmail.com>)
 id 1xOtYk-0005Ww-84
 for qemu-devel@nongnu.org; Thu, 05 Nov 2026 04:15:03 -0500
Received: by mail-pj1-f50.google.com with SMTP id
 98e67ed59e1d1-3b0bbdeae06so207337a91.1
 for <qemu-devel@nongnu.org>; Thu, 05 Nov 2026 01:15:01 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793870100; x=1794474900;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=fQuO1OoAvVLPWqu+N7yVLkIN0/A7JAcl4F1lEKElbWw=;
 b=m+LbgXu90KwR/Gn/xfahVfTXwY1DobFXb12F8OaYMPgEarcU2RlULDo6HTV7PegXV4
 RW3LwbJW7rqzxRpNrLxMTLaD6kAz8GPjeU8YX+a/1NSVADK48w2WSElJ+uuxh9Cscfw0
 jklSG5/2oRch2Dxc7neoW/48hE5r9DUht1BYuDOgijb0d2UwGA3UmhC3DsDj3xW01Szc
 HT958OLlKxTCbYihOC1RL5mQwy7GruPEiDk/uFIXSpf/Mydt8lF/T9TvnBDC5rdNW5Y+
 jI2HP2NIdo0b0+ttgWVjHdBEAjA5Gx3VivsjUNJeCQPdD17U9TJZHhhxWvDSuq/1adzQ
 eJqA==
X-Gm-Message-State: APuU4Z/e/+QAAa6C5ScV+BNVOFSGYotBidQgZbmInG3g3Qst9gHpf8uA
 IhW+SS04i4PT3kFEsse0/X8Y/EpxvGNrXMgcR5tUZhQyWpYbNxNmuWFde7Dd4QDZd48=
X-Gm-Gg: AYBFou3HCCG13b/yemjtP0+lNh44C7OqOOPa3VzHAHtWD7hzDncSjIsSYYRIfqiF8xi
 Ac+8w3AaCNFF7uA4sqvEBBwPr4Ijoz2z6tRQSvna+OF6j76kXOTiT1FP4Xv8BfiTOv8EqPYz1IH
 11ocNRDANEcdnde1sZMJi7l7sZ7rHspBsi8K0+8lkP2HUgtCGQYk0WNCIbRDOFgrm7fhS0b/ylW
 /VCzICuZ2Z7nlX0u4DWejso4rgndDl1vcSeqtGB7srvFFSgzFPPm8vlaLTaCYSUU6wA1R+AaQ+q
 GnYptXj+ze8GVoiB++bTFrrWLVlDIx31iSGoLweLvixSaepqWYpj8fURTShkSdueHE2w+qDT4Km
 0ggXE2oE+tBf1Zn8MlzYskHox2bJltCqfgWzzpRb6ZyhNVOstDvWY8G2d0X+SBfvovwYYaaNbR+
 hFhvz5AKoLuyNR8Ny49jeQ9I+SG8hvgn68qadCKRvnGVtgxfpTYNxaKxJIjnVjMCO3SGfH9f3kX
 ZmuALlrSampVqwCrADTYQlTJpUeoxq3mSHek3xnUNvTJ2Vqvj8bhjn6c1I42OvFy8zkVf8hYC4w
 2LDvDgBD9ApJfbFDuQFemO6xilef2M5Q8Xw//AK7cHiXkqLxlHOyvryfsci1TwFlbQSdyIMH+Bo
 0599rLA==
X-Received: by 2002:a17:90b:118a:b0:3b0:9e2c:9b61 with SMTP id
 98e67ed59e1d1-3b09e2c9eecmr2216016a91.35.1793870100402; 
 Thu, 05 Nov 2026 01:15:00 -0800 (PST)
Received: from localhost (118-163-122-149.hinet-ip.hinet.net.
 [118.163.122.149]) by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-3b0b312ccf1sm3043518a91.4.2026.11.05.01.14.59
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 05 Nov 2026 01:14:59 -0800 (PST)
Date: Thu, 05 Nov 2026 17:13:03 +0800
Subject: [PATCH 11/16] tests/qtest: ina238: cover voltage/temperature
 injection and derivation
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261105-sensor-ina23x-v1-11-5433ed104990@free.fr>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1793869976; l=7015;
 i=emmanuel.blot@free.fr; s=20260602; h=from:subject:message-id;
 bh=NE+vwOg7NY0/COEtyB9HSra4PfJKCB6NE5KYmmh/nfk=;
 b=Fs3wWegfLLwDAU3NHPRcZhE+VmtOFF39kClfRHdO9X9H1nFI+ba3LKhIEH4FqXRXBkRzIyg14
 CgqbvxoAprbBZAaxfKOVyKsJxz8/5lk/RvnWbYkwozMsbFJxtjJgiav
X-Developer-Key: i=emmanuel.blot@free.fr; a=ed25519;
 pk=0qFrZ21FAAN8OfVsSoVcCFTk/NMYOWzxJz4paSAVm0g=
Received-SPF: pass client-ip=209.85.216.50; envelope-from=eblot.ml@gmail.com;
 helo=mail-pj1-f50.google.com
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

Cover the shunt-, bus- and die-temperature injection properties and the
current and power values derived through the Shunt Calibration register,
including the zero-calibration case, the ADCRANGE rescaling and the
clamp/overflow edges.

Reviewed-by: Glenn Miles <milesg@linux.ibm.com>
Signed-off-by: Emmanuel Blot <emmanuel.blot@free.fr>
---
 tests/qtest/ina238-test.c | 156 ++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 156 insertions(+)

diff --git a/tests/qtest/ina238-test.c b/tests/qtest/ina238-test.c
index 6e59ed30b5..693139f988 100644
--- a/tests/qtest/ina238-test.c
+++ b/tests/qtest/ina238-test.c
@@ -89,6 +89,20 @@ static void qmp_ina238_set(const char *property, int value)
     qobject_unref(resp);
 }
 
+static int qmp_ina238_get(const char *property)
+{
+    QDict *resp;
+    int ret;
+
+    resp = qmp("{ 'execute': 'qom-get', 'arguments':"
+               " { 'path': %s, 'property': %s } }",
+               INA238_TEST_ID, property);
+    g_assert(qdict_haskey(resp, "return"));
+    ret = qdict_get_int(resp, "return");
+    qobject_unref(resp);
+    return ret;
+}
+
 /* Power-on-reset default values and the ID registers */
 static void test_defaults(void *obj, void *data, QGuestAllocator *alloc)
 {
@@ -160,6 +174,139 @@ static void test_config_wmask(void *obj, void *data, QGuestAllocator *alloc)
     g_assert_cmphex(i2c_get16(dev, REG_CONFIG), ==, CONFIG_POR);
 }
 
+/* Shunt voltage register */
+static void test_shunt_injection(void *obj, void *data, QGuestAllocator *alloc)
+{
+    QI2CDevice *dev = (QI2CDevice *)obj;
+
+    i2c_set16(dev, REG_CONFIG, CONFIG_RST);
+
+    qmp_ina238_set("shunt-voltage", 97200000);
+    g_assert_cmphex(i2c_get16(dev, REG_VSHUNT), ==, 0x4BF0);
+
+    qmp_ina238_set("shunt-voltage", -80000000);
+    g_assert_cmphex(i2c_get16(dev, REG_VSHUNT), ==, 0xC180);
+
+    g_assert_cmpint(qmp_ina238_get("shunt-voltage"), ==, -80000000);
+}
+
+/* Bus voltage register */
+static void test_bus_injection(void *obj, void *data, QGuestAllocator *alloc)
+{
+    QI2CDevice *dev = (QI2CDevice *)obj;
+
+    i2c_set16(dev, REG_CONFIG, CONFIG_RST);
+
+    qmp_ina238_set("bus-voltage", 48000000);
+    g_assert_cmphex(i2c_get16(dev, REG_VBUS), ==, 0x3C00);
+
+    qmp_ina238_set("bus-voltage", 12000000);
+    g_assert_cmphex(i2c_get16(dev, REG_VBUS), ==, 0x0F00);
+}
+
+/* Die temperature register */
+static void test_temp_injection(void *obj, void *data, QGuestAllocator *alloc)
+{
+    QI2CDevice *dev = (QI2CDevice *)obj;
+
+    i2c_set16(dev, REG_CONFIG, CONFIG_RST);
+
+    qmp_ina238_set("die-temperature", 25000);
+    g_assert_cmphex(i2c_get16(dev, REG_DIETEMP), ==, 0x0C80);
+
+    qmp_ina238_set("die-temperature", -25000);
+    g_assert_cmphex(i2c_get16(dev, REG_DIETEMP), ==, 0xF380);
+
+    g_assert_cmpint(qmp_ina238_get("die-temperature"), ==, -25000);
+}
+
+/* Calibration-derived current */
+static void test_calibration_current(void *obj, void *data,
+                                     QGuestAllocator *alloc)
+{
+    QI2CDevice *dev = (QI2CDevice *)obj;
+
+    i2c_set16(dev, REG_CONFIG, CONFIG_RST);
+    qmp_ina238_set("shunt-voltage", 97200000);
+
+    i2c_set16(dev, REG_SHUNT_CAL, 0x0000);
+    g_assert_cmphex(i2c_get16(dev, REG_CURRENT), ==, 0x0000);
+
+    i2c_set16(dev, REG_SHUNT_CAL, 0x0FD2);
+    g_assert_cmphex(i2c_get16(dev, REG_CURRENT), ==, 0x4CCC);
+}
+
+/* Calibration-derived power */
+static void test_power(void *obj, void *data, QGuestAllocator *alloc)
+{
+    QI2CDevice *dev = (QI2CDevice *)obj;
+
+    i2c_set16(dev, REG_CONFIG, CONFIG_RST);
+    qmp_ina238_set("shunt-voltage", 97200000);
+    qmp_ina238_set("bus-voltage", 48000000);
+    i2c_set16(dev, REG_SHUNT_CAL, 0x0FD2);
+
+    g_assert_cmpuint(i2c_get24(dev, REG_POWER), ==, 4718400);
+}
+
+/* With SHUNT_CAL == 0 the current and power registers stay zero */
+static void test_zero_cal(void *obj, void *data, QGuestAllocator *alloc)
+{
+    QI2CDevice *dev = (QI2CDevice *)obj;
+
+    i2c_set16(dev, REG_CONFIG, CONFIG_RST);
+    i2c_set16(dev, REG_SHUNT_CAL, 0x0000);
+    qmp_ina238_set("shunt-voltage", 97200000);
+    qmp_ina238_set("bus-voltage", 48000000);
+
+    g_assert_cmphex(i2c_get16(dev, REG_CURRENT), ==, 0x0000);
+    g_assert_cmpuint(i2c_get24(dev, REG_POWER), ==, 0);
+}
+
+/* ADCRANGE changes the shunt LSB, not the current divisor. */
+static void test_adcrange(void *obj, void *data, QGuestAllocator *alloc)
+{
+    QI2CDevice *dev = (QI2CDevice *)obj;
+
+    i2c_set16(dev, REG_CONFIG, CONFIG_RST);
+
+    qmp_ina238_set("shunt-voltage", 20000000);
+    g_assert_cmphex(i2c_get16(dev, REG_VSHUNT), ==, 0x0FA0);
+
+    i2c_set16(dev, REG_SHUNT_CAL, 0x0800);
+    g_assert_cmphex(i2c_get16(dev, REG_CURRENT), ==, 0x1F40);
+
+    i2c_set16(dev, REG_CONFIG, CONFIG_ADCRANGE);
+    g_assert_cmphex(i2c_get16(dev, REG_VSHUNT), ==, 0x3E80);
+
+    g_assert_cmphex(i2c_get16(dev, REG_CURRENT), ==, 0x7D00);
+
+    i2c_set16(dev, REG_SHUNT_CAL, 0x2000);
+    g_assert_cmphex(i2c_get16(dev, REG_CURRENT), ==, 0x1F40);
+}
+
+/* Clamping at full scale and the MATHOF flag */
+static void test_overflow(void *obj, void *data, QGuestAllocator *alloc)
+{
+    QI2CDevice *dev = (QI2CDevice *)obj;
+
+    i2c_set16(dev, REG_CONFIG, CONFIG_RST);
+
+    i2c_set16(dev, REG_CONFIG, CONFIG_ADCRANGE);
+    qmp_ina238_set("shunt-voltage", 97200000);
+    g_assert_cmphex(i2c_get16(dev, REG_VSHUNT), ==, 0x7FFF);
+    qmp_ina238_set("shunt-voltage", -97200000);
+    g_assert_cmphex(i2c_get16(dev, REG_VSHUNT), ==, 0x8000);
+
+    i2c_set16(dev, REG_CONFIG, CONFIG_POR);
+    qmp_ina238_set("shunt-voltage", 163835000);
+    i2c_set16(dev, REG_SHUNT_CAL, 0x0001);
+    g_assert_cmphex(i2c_get16(dev, REG_CURRENT), ==, 0x7FFF);
+    g_assert_cmphex(i2c_get16(dev, REG_DIAG_ALRT) & DIAG_MATHOF, ==,
+                    DIAG_MATHOF);
+}
+
+/* Shunt over-limit alert (transparent mode) */
 static void ina238_register_nodes(void)
 {
     QOSGraphEdgeOptions opts = {
@@ -173,5 +320,14 @@ static void ina238_register_nodes(void)
     qos_add_test("defaults", "ina238", test_defaults, NULL);
     qos_add_test("soft-reset", "ina238", test_soft_reset, NULL);
     qos_add_test("config-wmask", "ina238", test_config_wmask, NULL);
+    qos_add_test("shunt-injection", "ina238", test_shunt_injection, NULL);
+    qos_add_test("bus-injection", "ina238", test_bus_injection, NULL);
+    qos_add_test("temp-injection", "ina238", test_temp_injection, NULL);
+    qos_add_test("calibration-current", "ina238", test_calibration_current,
+                 NULL);
+    qos_add_test("power", "ina238", test_power, NULL);
+    qos_add_test("zero-cal", "ina238", test_zero_cal, NULL);
+    qos_add_test("adcrange", "ina238", test_adcrange, NULL);
+    qos_add_test("overflow", "ina238", test_overflow, NULL);
 }
 libqos_init(ina238_register_nodes);

-- 
2.53.0-Meta


