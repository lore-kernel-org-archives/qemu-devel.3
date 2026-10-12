Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0B863CA9ED1
	for <qemu-devel@archiver.kernel.org>; Mon, 12 Oct 2026 15:28:05 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xGHw0-0003pH-SE; Mon, 12 Oct 2026 11:27:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eblot.ml@gmail.com>)
 id 1xGHvs-0003mt-0U
 for qemu-devel@nongnu.org; Mon, 12 Oct 2026 11:27:21 -0400
Received: from mail-wr1-f48.google.com ([209.85.221.48])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <eblot.ml@gmail.com>)
 id 1xGHvo-0001mD-1Y
 for qemu-devel@nongnu.org; Mon, 12 Oct 2026 11:27:18 -0400
Received: by mail-wr1-f48.google.com with SMTP id
 ffacd0b85a97d-486e70f2457so886750f8f.2
 for <qemu-devel@nongnu.org>; Mon, 12 Oct 2026 08:27:14 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1791818833; x=1792423633;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=yMnW4a8crPYO2wOiMAzPMEvePpA+mW750LYZ6d0wg08=;
 b=OhteZuqp/p1tHg3+FexD6jjfZC9sshjQFCWV7ugtzOOVPNtK1yGIUEaZ7jB7ge/ypx
 Rs/J/zkIUVXgX7kfpitXaCmbkreoBodOMEfNsoakQZaFZ/c6y1o5fKGdwWWfOuK3gGsE
 P4wrUseAWjbrf0r+Xhwvv+GQrZjlBnvJrETPyBo/2FxtcwLBak2DHl4SS5eF/FrOo7eg
 tTLo5FhLzYrLVOkJyVQ8KwK/XZ0FZlJkvv4qKnT39aIph/DQW0WMWB18HOR/chBLr20A
 HPeTf2t5Epduf1Qug9iENERpQPvn/MYtsttCjUNDDlpPCcDQnW7+1LymvkholSk1SSiq
 c83A==
X-Gm-Message-State: AFq9FYJ7U5q+1HvIDrqVsNz7nbNtajD3fcMNDX+1lq6WKUecqAReNMcw
 rxvexk94U8yNcske8rEah+Aq55OiPZAoZJbEFf1irz6iGLOOQZcE3UPpbwrskwfY
X-Gm-Gg: AYBFou04beOskljMrLuzutJQ9QdtCx+EXUhfmxqZXyiRNLExmmnRTFNufZeBoMbICCx
 wH259htqXMMBlKqYQn5Fr9p5jFuF4994n4H4WmaTOSjC9ANRUTVqKoiMrDI2J9vFCWW7IUuZFw7
 zrWa4qsg3jWdNDapnlVjEI99zvFaNYcZuN58sf0i9D3N7q8QZN1B4iGYUXmprlhj2CAoF6ZtRrb
 wTzI6wHYwxxyCnM+JYwYRQ93Ea5FA5NNyIngupuIRtEpdjiJiYkYf1RPmZqkqAX4ejEwF9ESQKA
 /xh6ZLexM7C6hhdbDf7lOsoYGDgz5lyDlTuHqwCt7Y25+w2Ysi2iZRitogq8mMS7TKbK+zt2XxL
 3d2mpPvzqGT1wP29zA7V9dJ7n/PS+hcjMBsq2k0GJ8l7Xw3OluL8QDf2pl3BGLINWdcJU+hgd+2
 5f9Eb6wxc1eIxNx9FM2wTekC7blYa18OOJed3ZVU99Rbqr1aorLCayr0cQF6kBxKluNjEzdCr6b
 kFZZxZ3utI2AJ88OOASzrih8ImXucpKaOJWkI2uyBiWBw==
X-Received: by 2002:adf:f341:0:b0:487:197a:5c1f with SMTP id
 ffacd0b85a97d-48dbaae84e0mr14930321f8f.49.1791818832771; 
 Mon, 12 Oct 2026 08:27:12 -0700 (PDT)
Received: from localhost (89-93-216-19.hfc.dyn.abo.bbox.fr. [89.93.216.19])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-48de0bd733fsm21996f8f.58.2026.10.12.08.27.11
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 12 Oct 2026 08:27:12 -0700 (PDT)
Date: Mon, 12 Oct 2026 16:32:27 +0200
Subject: [PATCH v2 34/50] tests/qtest: ina230: cover voltage injection and
 power derivation
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261012-bmc-minerva-v2-34-4c3dff084ec9@free.fr>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1791815521; l=5751;
 i=emmanuel.blot@free.fr; s=20260602; h=from:subject:message-id;
 bh=Lxa/vLTiqltAne2a9oGEC4v4uDweYMzTuPg2HL1aV2c=;
 b=qlM2sMAwtWBpe7RscPECgWxplCp5Dir6hNCtOQM4g5waAub3h+xyXuVvKg5qB4o2bJsPFZExO
 JeufTS4x2rNDXRK29THBkdLWGuYJux4qfT4d4XyUflzmQoUigIGGwpq
X-Developer-Key: i=emmanuel.blot@free.fr; a=ed25519;
 pk=0qFrZ21FAAN8OfVsSoVcCFTk/NMYOWzxJz4paSAVm0g=
Received-SPF: pass client-ip=209.85.221.48; envelope-from=eblot.ml@gmail.com;
 helo=mail-wr1-f48.google.com
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

Cover the shunt- and bus-voltage injection properties and the current
and power values the device derives from them through the Calibration
register, including the zero-calibration case and the clamp/overflow
edges.

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
2.50.1


