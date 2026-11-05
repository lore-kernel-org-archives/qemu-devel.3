Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DFCC2606A32E
	for <qemu-devel@archiver.kernel.org>; Thu,  5 Nov 2026 09:30:34 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xOtmn-0000Ch-Ab; Thu, 05 Nov 2026 04:29:33 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eblot.ml@gmail.com>)
 id 1xOtml-00006V-E5
 for qemu-devel@nongnu.org; Thu, 05 Nov 2026 04:29:31 -0500
Received: from mail-pj1-f53.google.com ([209.85.216.53])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <eblot.ml@gmail.com>)
 id 1xOtmj-000729-3c
 for qemu-devel@nongnu.org; Thu, 05 Nov 2026 04:29:30 -0500
Received: by mail-pj1-f53.google.com with SMTP id
 98e67ed59e1d1-3b0afe09854so402490a91.3
 for <qemu-devel@nongnu.org>; Thu, 05 Nov 2026 01:29:28 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793870967; x=1794475767;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=ZT03pXOUyF1VnCcltW3we9XEJr4ijAWCTIBb53nAbTQ=;
 b=hYGeAeV2MF+mv7hbbw9W67DE0N8mSxHz0Gi+JKVN7+6JXPyqscaj1O9UkFh9SaOuyp
 NbeuI3p6+ltUInI/cFQEwsSMWpBi6iXqSAcXcfA2TZqMpAavrWRLvpa2iksakv/OZ4Ao
 iksMI8gdkENJQFZQiNf0i7GQqBdU7/WGYVpMI24kMOfPDInNFZ2nuCo/970DrOW0bFP0
 a2oJ2ITTt57RjlyHbP77t5kv/ONRTwQKMO2BHnf1NUxHbU/qyOU8JJETnuq5v3JRGMEm
 JT+3K761NRuleOTeYaB497Y/p0YWWkNByNbawzLaEh6LUG+BsC5uNhtx/FjtbYHDRqwy
 lCbQ==
X-Gm-Message-State: APuU4Z9k2dmttpWJ/amrh0R0jlTXX/RXL2DEU4rzDu2OvboN4c+n7BD9
 G5fPDWkMiYJqdZVjasveKWROb8Nyh486KsaeOxGMUqCzkTwM2RBhqtSiuWPKEDU+i8E=
X-Gm-Gg: AYBFou3oZpW4CtefqclVVm4vZfwjxS98HxBNHIb2ME/rEOkY4VWkIaMDlH61wBYo7h8
 XAPbjbCJp7iD5Qu0wkC6pWrhTsPaUHP+oExilD4ELy5uFAdZ5wa8KzW/AWHLKziqDrqYXemGNvw
 RJ1qLpbX1dAXTUP9pqq8adxYSHttOQQgpGp6ZRKaz4QEMoGd0iQNpGk/1c+tVeqsE/nW9oLODLL
 CIjykRdt6sDklDzqqT8PP++gBqi52b+HK/AaflnZvvcs1ynKXXFIZusSrVapdQgbdmAhQTq/YF9
 oQPL2sO1sqhz7Tbu6dvA8ir4dAYVMJeQNSTsLQWYGq9xUhqkPzFl02BnlGsqdoOEBIrJoH9U21Q
 LaC6sFw0Z345xvw4GBJ5gbbOnFaEP5kH9g+jS3E3wsbpu7jJjjWKwpnRdCLrCzIWoeyCkOM5Aw3
 U5sgF15uuygzshOgwimuHdNNcKH/cRzEnCm9H8zepSa++ZS8kh/kLV7ijqoWALSzwXA/wOwAsXo
 xO9Cvqdwp5H29fU3Jw2sf/1Jd37X6nl4sIdURLzOZexUVBBohIwc8YYPAoEpezYHqRcYzo+a9TZ
 qnTzrxpeUuwgpnslIERPrr3aO4g4UhRAk/xmCHyBE0qM2VLz7Zx/4M2hs0Yf6Oqp86ySaKCU3Ye
 F
X-Received: by 2002:a17:90a:f985:b0:3ae:a531:4e73 with SMTP id
 98e67ed59e1d1-3aea5314ea6mr9070611a91.7.1793870967209; 
 Thu, 05 Nov 2026 01:29:27 -0800 (PST)
Received: from localhost (118-163-122-149.hinet-ip.hinet.net.
 [118.163.122.149]) by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-3b0b323cd3csm2983912a91.3.2026.11.05.01.29.26
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 05 Nov 2026 01:29:26 -0800 (PST)
Date: Thu, 05 Nov 2026 17:25:52 +0800
Subject: [PATCH 13/16] tests/qtest: tmp421: cover temperature encoding and
 range
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261105-sensor-tmp421-v1-13-c46853f5e1f0@free.fr>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1793870743; l=6462;
 i=emmanuel.blot@free.fr; s=20260602; h=from:subject:message-id;
 bh=AEzQURKuJZlDUat8fg72pNeAc6ypqWG6k7Vbs2+CVL0=;
 b=OPBbQ74oGGc322PyTEZjkQ7TNfNv6htJOeopnXsBYhkXkkpqOh0EEER9Bk6RAYQLDnJlHDTBZ
 V/g3aLfgo8TCBDzYc982KlrB64zGF4wZFM1T8vkfJghct5UrdZA8ZZS
X-Developer-Key: i=emmanuel.blot@free.fr; a=ed25519;
 pk=0qFrZ21FAAN8OfVsSoVcCFTk/NMYOWzxJz4paSAVm0g=
Received-SPF: pass client-ip=209.85.216.53; envelope-from=eblot.ml@gmail.com;
 helo=mail-pj1-f53.google.com
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

Set a temperature over QMP and read it back through the two-byte and
single-byte register paths, checking the fixed-point encoding and the
extended-range offset. A second case pins the saturation: a temperature
the standard range cannot express reads back clamped, without harming
the measurement itself.

Signed-off-by: Emmanuel Blot <emmanuel.blot@free.fr>
---
 tests/qtest/tmp421-test.c | 102 ++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 102 insertions(+)

diff --git a/tests/qtest/tmp421-test.c b/tests/qtest/tmp421-test.c
index 2307e5f603..390f17b6b2 100644
--- a/tests/qtest/tmp421-test.c
+++ b/tests/qtest/tmp421-test.c
@@ -18,9 +18,13 @@
  * shared with the model, so the test states the values it expects
  * independently of the implementation it is checking.
  */
+#define TMP421_TEMP_MSB0                0x00
 #define TMP421_CONFIG_REG_1             0x09
+#define    TMP421_CONFIG_RANGE            (1 << 2)
 #define TMP421_CONFIG_REG_2             0x0A
 #define TMP421_CONVERSION_RATE_REG      0x0B
+#define TMP421_TEMP_LSB0                0x10
+#define TMP421_RESET                    0xFC
 #define TMP421_MANUFACTURER_ID_REG      0xFE
 #define TMP421_DEVICE_ID_REG            0xFF
 #define TMP421_MANUFACTURER_ID          0x55
@@ -44,6 +48,36 @@ static const TMP421Variant tmp421_variant = { TMP421_TEST_ID, 0x21, 0x1c, 2 };
 static const TMP421Variant tmp422_variant = { TMP422_TEST_ID, 0x22, 0x3c, 3 };
 static const TMP421Variant tmp423_variant = { TMP423_TEST_ID, 0x23, 0x7c, 4 };
 
+static QDict *qmp_get_temperature(const char *id, unsigned channel)
+{
+    g_autofree char *prop = g_strdup_printf("temperature%u", channel);
+
+    return qmp("{ 'execute': 'qom-get', 'arguments': { 'path': %s, "
+               "'property': %s } }", id, prop);
+}
+
+static int get_temperature(const char *id, unsigned channel)
+{
+    QDict *response = qmp_get_temperature(id, channel);
+    int ret;
+
+    g_assert(qdict_haskey(response, "return"));
+    ret = qdict_get_int(response, "return");
+    qobject_unref(response);
+    return ret;
+}
+
+static void set_temperature(const char *id, unsigned channel, int value)
+{
+    g_autofree char *prop = g_strdup_printf("temperature%u", channel);
+    QDict *response;
+
+    response = qmp("{ 'execute': 'qom-set', 'arguments': { 'path': %s, "
+                   "'property': %s, 'value': %d } }", id, prop, value);
+    g_assert(qdict_haskey(response, "return"));
+    qobject_unref(response);
+}
+
 static void test_ids(void *obj, void *data, QGuestAllocator *alloc)
 {
     const TMP421Variant *var = data;
@@ -58,6 +92,70 @@ static void test_ids(void *obj, void *data, QGuestAllocator *alloc)
     g_assert_cmphex(i2c_get8(i2cdev, TMP421_CONVERSION_RATE_REG), ==, 0x07);
 }
 
+static void test_temperature(void *obj, void *data, QGuestAllocator *alloc)
+{
+    QI2CDevice *i2cdev = obj;
+
+    /* A whole degree lands on a whole register value, fraction cleared. */
+    set_temperature(TMP421_TEST_ID, 0, 25000);
+    g_assert_cmphex(i2c_get16(i2cdev, TMP421_TEMP_MSB0), ==, 0x1900);
+
+    /* The standard range is two's complement below 0 C. */
+    set_temperature(TMP421_TEST_ID, 0, -25000);
+    g_assert_cmphex(i2c_get16(i2cdev, TMP421_TEMP_MSB0), ==, 0xE700);
+
+    /* A temperature the register form represents exactly. */
+    set_temperature(TMP421_TEST_ID, 0, 25063);
+    g_assert_cmpint(get_temperature(TMP421_TEST_ID, 0), ==, 25063);
+    g_assert_cmphex(i2c_get16(i2cdev, TMP421_TEMP_MSB0), ==, 0x1910);
+
+    /* A lone low-byte read returns the same conversion as the pair. */
+    g_assert_cmphex(i2c_get8(i2cdev, TMP421_TEMP_LSB0), ==, 0x10);
+
+    /* Extended range encodes the same measurement with a +64 C offset. */
+    i2c_set8(i2cdev, TMP421_CONFIG_REG_1, TMP421_CONFIG_RANGE);
+    set_temperature(TMP421_TEST_ID, 0, 25063);
+    g_assert_cmphex(i2c_get16(i2cdev, TMP421_TEMP_MSB0), ==, 0x5910);
+
+    /* Leaving it, whether by a write or a reset, reports the same value */
+    i2c_set8(i2cdev, TMP421_CONFIG_REG_1, 0);
+    g_assert_cmpint(get_temperature(TMP421_TEST_ID, 0), ==, 25063);
+    g_assert_cmphex(i2c_get16(i2cdev, TMP421_TEMP_MSB0), ==, 0x1910);
+
+    i2c_set8(i2cdev, TMP421_CONFIG_REG_1, TMP421_CONFIG_RANGE);
+    g_assert_cmphex(i2c_get16(i2cdev, TMP421_TEMP_MSB0), ==, 0x5910);
+    i2c_set8(i2cdev, TMP421_RESET, 0);
+    g_assert_cmpint(get_temperature(TMP421_TEST_ID, 0), ==, 25063);
+    g_assert_cmphex(i2c_get16(i2cdev, TMP421_TEMP_MSB0), ==, 0x1910);
+
+    /* The extended range is unsigned: it reaches past +64 C (Table 1). */
+    i2c_set8(i2cdev, TMP421_CONFIG_REG_1, TMP421_CONFIG_RANGE);
+    set_temperature(TMP421_TEST_ID, 0, 100063);
+    g_assert_cmphex(i2c_get16(i2cdev, TMP421_TEMP_MSB0), ==, 0xA410);
+}
+
+/*
+ * A temperature the standard range cannot express saturates at +127 C (7Fh)
+ * instead of wrapping, and the extended range still reports it in full: the
+ * range picks an encoding, it does not alter the measurement.
+ */
+static void test_range_saturation(void *obj, void *data,
+                                  QGuestAllocator *alloc)
+{
+    QI2CDevice *i2cdev = obj;
+
+    i2c_set8(i2cdev, TMP421_CONFIG_REG_1, TMP421_CONFIG_RANGE);
+    set_temperature(TMP421_TEST_ID, 0, 149938);
+    g_assert_cmphex(i2c_get16(i2cdev, TMP421_TEMP_MSB0), ==, 0xD5F0);
+
+    i2c_set8(i2cdev, TMP421_CONFIG_REG_1, 0);
+    g_assert_cmphex(i2c_get16(i2cdev, TMP421_TEMP_MSB0), ==, 0x7FF0);
+    g_assert_cmpint(get_temperature(TMP421_TEST_ID, 0), ==, 149938);
+
+    i2c_set8(i2cdev, TMP421_CONFIG_REG_1, TMP421_CONFIG_RANGE);
+    g_assert_cmphex(i2c_get16(i2cdev, TMP421_TEMP_MSB0), ==, 0xD5F0);
+}
+
 static void tmp421_register_node(const TMP421Variant *var, const char *type,
                                  uint8_t addr)
 {
@@ -79,6 +177,10 @@ static void tmp421_register_nodes(void)
     tmp421_register_node(&tmp421_variant, "tmp421", 0x4c);
     tmp421_register_node(&tmp422_variant, "tmp422", 0x4d);
     tmp421_register_node(&tmp423_variant, "tmp423", 0x4e);
+
+    /* Temperature encoding is variant-independent; exercise it once. */
+    qos_add_test("temperature", "tmp421", test_temperature, NULL);
+    qos_add_test("range-saturation", "tmp421", test_range_saturation, NULL);
 }
 
 libqos_init(tmp421_register_nodes);

-- 
2.53.0-Meta


