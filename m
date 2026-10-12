Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8632ECA9ED1
	for <qemu-devel@archiver.kernel.org>; Mon, 12 Oct 2026 15:29:28 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xGHxo-00053g-RE; Mon, 12 Oct 2026 11:29:20 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eblot.ml@gmail.com>)
 id 1xGHxn-00053B-CX
 for qemu-devel@nongnu.org; Mon, 12 Oct 2026 11:29:19 -0400
Received: from mail-wr1-f41.google.com ([209.85.221.41])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <eblot.ml@gmail.com>)
 id 1xGHxl-0001xh-LK
 for qemu-devel@nongnu.org; Mon, 12 Oct 2026 11:29:19 -0400
Received: by mail-wr1-f41.google.com with SMTP id
 ffacd0b85a97d-48afe0081a6so1390675f8f.2
 for <qemu-devel@nongnu.org>; Mon, 12 Oct 2026 08:29:16 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1791818956; x=1792423756;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=tT25q+kAs26amHD55A44HNQvdNP+ZXuCq/4WXpNirRE=;
 b=hanFetzrsxSdv1XCa/oQN0D2x6M9BzrA767vIO6ox0nvO8NScY6PE887KKmtO/TEQn
 3F32qIjU9Ln/+/t2Jqrtc+NJ5rlQo50MXQG7jCCL0nf3gyT9hK0HjRbBM8Ec1deFEnk9
 gJyB6XuJ7YAaAjrhuwodkZn5eUSYFIEfhedad5sX6JdxJrEk5F3dktTA5A1CCGL+AY3L
 SeqskYi4wLW/C+C94cxpAzqp+tylytEo8D3H3wgpFxBjW+0aibUn+ycokbujGbEUiGcW
 /OXMynbzLG0Q4QVX7vDozOvSLAVzgZToYq5ZK+jkYctb7mLi14b8NYX4YNTA0tJTcMJW
 3efQ==
X-Gm-Message-State: AFq9FYKCMk6wDxhRfF//6k+BfqzZJ+k/zkK6y4ljXs5UwyG/L3Onjrk4
 cT12YVJ+vP2iQ1X2yV+z8MD0ccq8WZ/dRjjclrlr02AUJotdbbWpGhDy5lzce4Ok
X-Gm-Gg: AYBFou1MWdAS2IrhdayakqZGlOFxV5Vm/CUicGMjfebE34kSPEAAL0R/sE8Drevd5kT
 S1PIce1S9jk4LnPFp8IAIf/+iaD6BAuzqVxrf+9vEWUKJ3MAaCH2oiRVuI44uHv0xeaide95NXW
 Hfy03h1IHEfSkRL+LKYhdT+L8AoA2hCp9iVUN4bL3QZtr15Y4EdG9TqmSv5pS8bFLKcfdMKXm9V
 6ckYUvSpRRdesdweOLrbOuFcUhZI5t2YM5kqTUMLf5alKgcjJZOz0noZ62IxDbV/EyU+8wzrmcT
 U+9wkaP/CL+DhGlU2YkFkwT0oXMAJ94y5FP4WYDP6dlvHl4aJ/YwuK41HwfGJXpLOebkyP26L/L
 Wqat/kZW4zoayf43Zgl2Y9V6hrSP+3BDSJXeZX+71SiTnYbNNuXvgIReI+n27M1P6KyQybrLzXr
 bQy5Im7woLmPzDA5asdU5+H+cv8ajuGtdHfNKOdMz0P4k/HWGJkwAY8j+kXjW3rF4LNPkLf31sd
 S3KldQsKDQuopX4DeNgCPdY9haRJ9hAvJolYyArDT3AkA==
X-Received: by 2002:a05:600c:4689:b0:4a0:1cfd:321 with SMTP id
 5b1f17b1804b1-4a18e4a9b31mr206769825e9.12.1791818955589; 
 Mon, 12 Oct 2026 08:29:15 -0700 (PDT)
Received: from localhost (89-93-216-19.hfc.dyn.abo.bbox.fr. [89.93.216.19])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4a18be96549sm412198175e9.6.2026.10.12.08.29.14
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 12 Oct 2026 08:29:14 -0700 (PDT)
Date: Mon, 12 Oct 2026 16:32:29 +0200
Subject: [PATCH v2 36/50] tests/qtest: ina230: cover the injection-property
 limits
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261012-bmc-minerva-v2-36-4c3dff084ec9@free.fr>
References: <20261012-bmc-minerva-v2-0-4c3dff084ec9@free.fr>
In-Reply-To: <20261012-bmc-minerva-v2-0-4c3dff084ec9@free.fr>
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
X-Mailer: b4 0.16.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1791815521; l=4015;
 i=emmanuel.blot@free.fr; s=20260602; h=from:subject:message-id;
 bh=wQmdLPHBw+ci32U6sjobS3P/cDhoGbED08CSbaHRchk=;
 b=ULt1AFcU9DxFHXJ8AO/WqFOV1c/kzM1HuvBVB9jjlltna8IL1WYAGKBhqrT4nxsaL5rUnaqhy
 INMx42npWwSDmSQzBatjaKyfm6Ff6+ltj3emotsR+wJFudx/vR7TFCr
X-Developer-Key: i=emmanuel.blot@free.fr; a=ed25519;
 pk=0qFrZ21FAAN8OfVsSoVcCFTk/NMYOWzxJz4paSAVm0g=
Received-SPF: pass client-ip=209.85.221.41; envelope-from=eblot.ml@gmail.com;
 helo=mail-wr1-f41.google.com
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

Verify that the extremes of the shunt- and bus-voltage injection ranges
round-trip through the QOM property without truncation or wraparound,
and that values just outside are rejected rather than silently wrapped.

Signed-off-by: Emmanuel Blot <emmanuel.blot@free.fr>
---
 tests/qtest/ina230-test.c | 59 +++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 59 insertions(+)

diff --git a/tests/qtest/ina230-test.c b/tests/qtest/ina230-test.c
index 1c55028fcb..36c899efee 100644
--- a/tests/qtest/ina230-test.c
+++ b/tests/qtest/ina230-test.c
@@ -47,6 +47,11 @@
 #define SHUNT_LSB_NV        2500
 #define BUS_LSB_UV          1250
 
+/* Injection-property limits (see ina230.c) */
+#define SHUNT_MIN_NV        (-81920000)
+#define SHUNT_MAX_NV        81917500
+#define BUS_MAX_UV          36000000
+
 #define DIE_ID_VAL          0x2310
 
 /* QMP helpers for injecting the physical inputs */
@@ -76,6 +81,18 @@ static int qmp_ina230_get(const char *property)
     return ret;
 }
 
+/* A qom-set expected to be rejected (value outside the supported range) */
+static void qmp_ina230_set_fail(const char *property, int64_t value)
+{
+    QDict *resp;
+
+    resp = qmp("{ 'execute': 'qom-set', 'arguments':"
+               " { 'path': %s, 'property': %s, 'value': %lld } }",
+               INA230_TEST_ID, property, (long long)value);
+    g_assert(qdict_haskey(resp, "error"));
+    qobject_unref(resp);
+}
+
 /* Power-on-reset default values and the Die ID */
 static void test_defaults(void *obj, void *data, QGuestAllocator *alloc)
 {
@@ -307,6 +324,46 @@ static void test_cvrf(void *obj, void *data, QGuestAllocator *alloc)
     g_assert_cmphex(i2c_get16(dev, REG_MASK_ENABLE) & ME_CVRF, ==, 0);
 }
 
+/* Shunt-voltage injection limits */
+static void test_shunt_limits(void *obj, void *data, QGuestAllocator *alloc)
+{
+    QI2CDevice *dev = (QI2CDevice *)obj;
+
+    i2c_set16(dev, REG_CONFIG, CONFIG_RST);
+
+    qmp_ina230_set("shunt-voltage", SHUNT_MAX_NV);
+    g_assert_cmphex(i2c_get16(dev, REG_SHUNT), ==, 0x7FFF);
+    g_assert_cmpint(qmp_ina230_get("shunt-voltage"), ==, SHUNT_MAX_NV);
+
+    qmp_ina230_set("shunt-voltage", SHUNT_MIN_NV);
+    g_assert_cmphex(i2c_get16(dev, REG_SHUNT), ==, 0x8000);
+    g_assert_cmpint(qmp_ina230_get("shunt-voltage"), ==, SHUNT_MIN_NV);
+
+    qmp_ina230_set_fail("shunt-voltage", (int64_t)SHUNT_MAX_NV + 1);
+    qmp_ina230_set_fail("shunt-voltage", (int64_t)SHUNT_MIN_NV - 1);
+    g_assert_cmpint(qmp_ina230_get("shunt-voltage"), ==, SHUNT_MIN_NV);
+    g_assert_cmphex(i2c_get16(dev, REG_SHUNT), ==, 0x8000);
+}
+
+/* Bus-voltage injection limits. */
+static void test_bus_limits(void *obj, void *data, QGuestAllocator *alloc)
+{
+    QI2CDevice *dev = (QI2CDevice *)obj;
+
+    i2c_set16(dev, REG_CONFIG, CONFIG_RST);
+
+    qmp_ina230_set("bus-voltage", 0);
+    g_assert_cmphex(i2c_get16(dev, REG_BUS), ==, 0x0000);
+
+    qmp_ina230_set("bus-voltage", BUS_MAX_UV);
+    g_assert_cmphex(i2c_get16(dev, REG_BUS), ==, 0x7080);
+    g_assert_cmpint(qmp_ina230_get("bus-voltage"), ==, BUS_MAX_UV);
+
+    qmp_ina230_set_fail("bus-voltage", (int64_t)BUS_MAX_UV + 1);
+    qmp_ina230_set_fail("bus-voltage", -1);
+    g_assert_cmpint(qmp_ina230_get("bus-voltage"), ==, BUS_MAX_UV);
+}
+
 static void ina230_register_nodes(void)
 {
     QOSGraphEdgeOptions opts = {
@@ -322,6 +379,8 @@ static void ina230_register_nodes(void)
     qos_add_test("config-wmask", "ina230", test_config_wmask, NULL);
     qos_add_test("shunt-injection", "ina230", test_shunt_injection, NULL);
     qos_add_test("bus-injection", "ina230", test_bus_injection, NULL);
+    qos_add_test("shunt-limits", "ina230", test_shunt_limits, NULL);
+    qos_add_test("bus-limits", "ina230", test_bus_limits, NULL);
     qos_add_test("calibration-current", "ina230", test_calibration_current,
                  NULL);
     qos_add_test("power", "ina230", test_power, NULL);

-- 
2.50.1


