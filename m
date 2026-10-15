Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 29455CC6B30
	for <qemu-devel@archiver.kernel.org>; Thu, 15 Oct 2026 10:34:05 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xHIkr-0002Cq-CK; Thu, 15 Oct 2026 06:32:11 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eblot.ml@gmail.com>)
 id 1xHIh8-0007Wz-GY
 for qemu-devel@nongnu.org; Thu, 15 Oct 2026 06:28:22 -0400
Received: from mail-wr1-f53.google.com ([209.85.221.53])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <eblot.ml@gmail.com>)
 id 1xHIh5-0004Hk-U5
 for qemu-devel@nongnu.org; Thu, 15 Oct 2026 06:28:17 -0400
Received: by mail-wr1-f53.google.com with SMTP id
 ffacd0b85a97d-48afcfc4bf5so294129f8f.1
 for <qemu-devel@nongnu.org>; Thu, 15 Oct 2026 03:28:07 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792060087; x=1792664887;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=DeiJYZqRfQOfLFJzRerKdRRjmQabvVc3EFQMHa8VS4A=;
 b=Ng8FicfOys3R3GtYEX7D9OHo6VQ6MMMDKx4M+saRmMZS/9RlFnz2ZkFZrBKWu6EjMS
 HrAYil0/AZ5JT7bwdKVj1Ld9VVq3lsC+dydpuW3yozf+AZZKWCTgSv3f73E8TA1ovW4x
 XfrwY1zTkw/+oui2fbv/tgHopBNszHMX41LknCRDVcIkOW+4YC701HWNGlXUti+OS6fm
 WsGbZNMr0P0FSdJwOVxCATdltxWHnmM4MH3+DEjlSkuKMpS8uWy46A1MqOMFEmyZ+f6v
 mED1lUUu1GTAI95WVEOidhRuOK4Ybo7WuUEu5VxCZ3dtSzZoduAt+lTeDZo+uwBYa+5x
 6Hag==
X-Gm-Message-State: AFq9FYJxncnB5DMjnvDLdYMs1skBNUS8ZTJv/Xx7AgXZERmXtwmF3RbD
 UDnI/pmNuUVYxcSWBgKM6ANYRokaakzuvyUKXH9zoNyL5AVs7vwTcCVcD0WIGA==
X-Gm-Gg: AYBFou25jgUxA9wLX2aEjgRopG0py3A3V1v5n7Dvno9DJib+nTa8+dc7OJLtpVdRTvt
 UXbrixZUY/tMV3g9WRm+jeKe7LVGowJy7ikgRW/XKxBgY2+DqjKUOLMTTrTiwMDh4D21kHi3gtJ
 OdvldomRxvBaLExuw+GYJoUW1SuAGoJLDp3xj4ej/A72+vOKqLw8Vp2QBZZ/LNxjBW9uo3G9Vhj
 3Mcawrjv3ITXpjVtluu83j+F1Y8rcTdudi04k0pHeErHd8+3ND55fk4rPC17gLiDDXeirnBW7iq
 5HFMQNYu5T06cA289HaDdxvxMWQ9O1NAuthYiFZBSpJ4RJcDRPOtCVuEC1wmlgyBBCQr3xfku+5
 IV604/B8O5qJntyFbPvHJld2N5eJkJ58TG96OmOGfkUeF6jlLZdReHpD6vjaxnYUdu/y8/Vt3Xz
 4+pJ8vXjrUPxxycmD6pswL39qrbiOwqiqeCtM9Wdl8+S7oZQxpups3n56zRDAu3nFm5R/JmObfM
 tKm/l/ZWlVrAYF9QClDcY04mk5yxirlTI+HjElfDVZgtWg=
X-Received: by 2002:adf:e183:0:b0:487:490:8391 with SMTP id
 ffacd0b85a97d-48dbaadd94cmr36059030f8f.16.1792060086746; 
 Thu, 15 Oct 2026 03:28:06 -0700 (PDT)
Received: from localhost (89-93-216-19.hfc.dyn.abo.bbox.fr. [89.93.216.19])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-48defca4013sm7991892f8f.9.2026.10.15.03.28.05
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 15 Oct 2026 03:28:05 -0700 (PDT)
Date: Thu, 15 Oct 2026 11:28:22 +0200
Subject: [PATCH v3 35/50] tests/qtest: ina230: cover the ALERT limit
 functions and CVRF
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261015-bmc-minerva-v3-35-7d50c8a108e5@free.fr>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1792056476; l=4653;
 i=emmanuel.blot@free.fr; s=20260602; h=from:subject:message-id;
 bh=yU/ASNKVFYSLSDsLa8e4k+jfJS9UQPvsF84TMUUNANI=;
 b=mW/MkKLeExb8M8KGFcDd1/j4J97gFuC34cY/of1JY6SBJPy+fjJJfY/MFiBWYEoPI+XGskp70
 j09WvOTLc9OCkdzxrXgb98AGPzJJlICTMZFGDhN+sKbioZf+BIGr6eJ
X-Developer-Key: i=emmanuel.blot@free.fr; a=ed25519;
 pk=0qFrZ21FAAN8OfVsSoVcCFTk/NMYOWzxJz4paSAVm0g=
Received-SPF: pass client-ip=209.85.221.53; envelope-from=eblot.ml@gmail.com;
 helo=mail-wr1-f53.google.com
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

Cover the shunt/bus/power alert-limit functions, the alert latch
behaviour and the conversion-ready flag.

Reviewed-by: Glenn Miles <milesg@linux.ibm.com>
Signed-off-by: Emmanuel Blot <emmanuel.blot@free.fr>
---
 tests/qtest/ina230-test.c | 97 +++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 97 insertions(+)

diff --git a/tests/qtest/ina230-test.c b/tests/qtest/ina230-test.c
index b01f9445d1..1c55028fcb 100644
--- a/tests/qtest/ina230-test.c
+++ b/tests/qtest/ina230-test.c
@@ -215,6 +215,98 @@ static void test_edges_overflow(void *obj, void *data, QGuestAllocator *alloc)
     g_assert_cmphex(i2c_get16(dev, REG_MASK_ENABLE) & ME_OVF, ==, ME_OVF);
 }
 
+/* Shunt over-limit alert (transparent mode) sets the AFF flag */
+static void test_alert_shunt_over(void *obj, void *data,
+                                  QGuestAllocator *alloc)
+{
+    QI2CDevice *dev = (QI2CDevice *)obj;
+
+    i2c_set16(dev, REG_CONFIG, CONFIG_RST);
+
+    i2c_set16(dev, REG_ALERT_LIMIT, 0x1000);
+    i2c_set16(dev, REG_MASK_ENABLE, ME_SOL);
+
+    qmp_ina230_set("shunt-voltage", 2500000);
+    g_assert_cmphex(i2c_get16(dev, REG_MASK_ENABLE) & ME_AFF, ==, 0);
+
+    qmp_ina230_set("shunt-voltage", 20000000);
+    g_assert_cmphex(i2c_get16(dev, REG_MASK_ENABLE) & ME_AFF, ==, ME_AFF);
+
+    qmp_ina230_set("shunt-voltage", 2500000);
+    g_assert_cmphex(i2c_get16(dev, REG_MASK_ENABLE) & ME_AFF, ==, 0);
+}
+
+/* Latch mode holds the alert until the Mask/Enable register is read */
+static void test_alert_latch(void *obj, void *data, QGuestAllocator *alloc)
+{
+    QI2CDevice *dev = (QI2CDevice *)obj;
+    uint16_t me;
+
+    i2c_set16(dev, REG_CONFIG, CONFIG_RST);
+
+    i2c_set16(dev, REG_ALERT_LIMIT, 0x1000);
+    i2c_set16(dev, REG_MASK_ENABLE, ME_SOL | ME_LEN);
+
+    qmp_ina230_set("shunt-voltage", 20000000);
+    qmp_ina230_set("shunt-voltage", 2500000);
+
+    me = i2c_get16(dev, REG_MASK_ENABLE);
+    g_assert_cmphex(me & ME_AFF, ==, ME_AFF);
+
+    g_assert_cmphex(i2c_get16(dev, REG_MASK_ENABLE) & ME_AFF, ==, 0);
+}
+
+/* Bus over-limit alert */
+static void test_alert_bus(void *obj, void *data, QGuestAllocator *alloc)
+{
+    QI2CDevice *dev = (QI2CDevice *)obj;
+
+    i2c_set16(dev, REG_CONFIG, CONFIG_RST);
+
+    i2c_set16(dev, REG_ALERT_LIMIT, 0x2000);
+    i2c_set16(dev, REG_MASK_ENABLE, ME_BOL);
+
+    qmp_ina230_set("bus-voltage", 5000000);
+    g_assert_cmphex(i2c_get16(dev, REG_MASK_ENABLE) & ME_AFF, ==, 0);
+
+    qmp_ina230_set("bus-voltage", 12000000);
+    g_assert_cmphex(i2c_get16(dev, REG_MASK_ENABLE) & ME_AFF, ==, ME_AFF);
+}
+
+/* Power over-limit alert */
+static void test_alert_power(void *obj, void *data, QGuestAllocator *alloc)
+{
+    QI2CDevice *dev = (QI2CDevice *)obj;
+
+    i2c_set16(dev, REG_CONFIG, CONFIG_RST);
+
+    qmp_ina230_set("shunt-voltage", 20000000);
+    qmp_ina230_set("bus-voltage", 11980000);
+    i2c_set16(dev, REG_CALIBRATION, 0x0A00);
+
+    i2c_set16(dev, REG_ALERT_LIMIT, 0x1000);
+    i2c_set16(dev, REG_MASK_ENABLE, ME_POL);
+    g_assert_cmphex(i2c_get16(dev, REG_MASK_ENABLE) & ME_AFF, ==, ME_AFF);
+
+    i2c_set16(dev, REG_ALERT_LIMIT, 0x2000);
+    g_assert_cmphex(i2c_get16(dev, REG_MASK_ENABLE) & ME_AFF, ==, 0);
+}
+
+/* Conversion Ready Flag: set on conversion, cleared by reading Mask/Enable */
+static void test_cvrf(void *obj, void *data, QGuestAllocator *alloc)
+{
+    QI2CDevice *dev = (QI2CDevice *)obj;
+
+    i2c_set16(dev, REG_CONFIG, CONFIG_RST);
+
+    /* A conversion (triggered by injection) sets CVRF */
+    qmp_ina230_set("shunt-voltage", 20000000);
+    g_assert_cmphex(i2c_get16(dev, REG_MASK_ENABLE) & ME_CVRF, ==, ME_CVRF);
+
+    /* The previous read cleared CVRF; no conversion since, so it stays clear */
+    g_assert_cmphex(i2c_get16(dev, REG_MASK_ENABLE) & ME_CVRF, ==, 0);
+}
+
 static void ina230_register_nodes(void)
 {
     QOSGraphEdgeOptions opts = {
@@ -235,5 +327,10 @@ static void ina230_register_nodes(void)
     qos_add_test("power", "ina230", test_power, NULL);
     qos_add_test("zero-cal", "ina230", test_zero_cal, NULL);
     qos_add_test("edges-overflow", "ina230", test_edges_overflow, NULL);
+    qos_add_test("alert-shunt-over", "ina230", test_alert_shunt_over, NULL);
+    qos_add_test("alert-latch", "ina230", test_alert_latch, NULL);
+    qos_add_test("alert-bus", "ina230", test_alert_bus, NULL);
+    qos_add_test("alert-power", "ina230", test_alert_power, NULL);
+    qos_add_test("cvrf", "ina230", test_cvrf, NULL);
 }
 libqos_init(ina230_register_nodes);

-- 
2.53.0-Meta


