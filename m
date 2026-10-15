Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 87BD2CC6B33
	for <qemu-devel@archiver.kernel.org>; Thu, 15 Oct 2026 10:36:35 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xHIld-00055Q-GD; Thu, 15 Oct 2026 06:32:57 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eblot.ml@gmail.com>)
 id 1xHIiM-0008PB-Rh
 for qemu-devel@nongnu.org; Thu, 15 Oct 2026 06:29:36 -0400
Received: from mail-wr1-f41.google.com ([209.85.221.41])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <eblot.ml@gmail.com>)
 id 1xHIiJ-0004bL-JR
 for qemu-devel@nongnu.org; Thu, 15 Oct 2026 06:29:34 -0400
Received: by mail-wr1-f41.google.com with SMTP id
 ffacd0b85a97d-48afcd7ba9bso2848500f8f.3
 for <qemu-devel@nongnu.org>; Thu, 15 Oct 2026 03:29:31 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792060170; x=1792664970;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=GgVTUxuGD9oTRYIDiMSJ0REbd9D3oR+ntYCQl5qLzoc=;
 b=MnBbEpCuhSGZptIu+xE/yrcH5qYQnYLjblOjwfBrOr/0kAY+nkfU2dfBw6hySiQweY
 QQAS1aHrdk29hTqG5d3nwO/Qm5ylXN1I+uMjD0+9P8vK8pbvXcRbuFVWHF5k0G0r63kV
 Ze/e/MeRRKb3x7ddLJ58BKaY0hokoHD/yKk/JAsZBIdImPG0I8zR10oX/ZZiGN5Nhmp8
 0MLX0PTRLzQZIk6ui3LquRnqP/XP/3NH4qAVeAh+g5KDeIDR670savfwCc8j0b0D5pgR
 vvTlYlqt58l2VsNr0ljuds4g0XasEuTowP1L0qJ1CQgNPzefz3+QuKU5yHROj4J3je4m
 4Trw==
X-Gm-Message-State: AFq9FYKTELHf3O1RrwjLR6vQzo3VvHumvvhegsPViaLawfC1YPIvISAl
 M/af+dEtxJz2RxwC0qXgsP+h3sY3kz3PHcybu0Y87oC/3m4therEG/SZdpEbpQ==
X-Gm-Gg: AYBFou2DFF7evdlFY0GGC36RdQs6nyTSZFG0cCoQRoWAAwhcFocpAvLpDccGJGS+NCQ
 8R6ryYOiL1JGribK5MgcEuNJOvhuAIZC9F5lPCeuqYBTp0mxz9nOpIcJ1IijeoYq0CvtgJxWoYY
 td9NarZOBA22EPs80QVirj4s/4UsxyCQ6yh/mhq6rCOXCprd4ugHqnJGBhss7lFdtv2A1c2+VGQ
 in3NYrll9ID5Ucejy//Bv9H4bTgUrQBHDyuxDrj/SSrYlX+VHXNK9OkEcyg6SuzH9XBbhAaVSMy
 Q7E8ap0Smp2z4iLOFkZM3ELYQlwvQ+jQhalLO9ciLh4a6VxSdrBEYDlHi/C7zLUyewB1sHtnBRq
 LKQ/lPd22GjmubAJ7U+bE4DyXBm/D4wHCN8yU6mGd799/bwxx+fKf03niNyOSdKfIE9I3djakeh
 rkP6Zdy8atY7i8czW+pWglY6LBASOVWSOXNaBWVoeZujeyIjNJK9BlcVQHpg0Qak9xOa76eE8sH
 9ulawwOnQfqMWd7Poq1VIr7TWK0ivBSRdEUNgsI6GJo6A==
X-Received: by 2002:adf:e009:0:10b0:48c:7dac:8957 with SMTP id
 ffacd0b85a97d-48dbacda6b7mr26548472f8f.32.1792060169949; 
 Thu, 15 Oct 2026 03:29:29 -0700 (PDT)
Received: from localhost (89-93-216-19.hfc.dyn.abo.bbox.fr. [89.93.216.19])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-48df3cbb78asm4380945f8f.48.2026.10.15.03.29.29
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 15 Oct 2026 03:29:29 -0700 (PDT)
Date: Thu, 15 Oct 2026 11:28:34 +0200
Subject: [PATCH v3 47/50] tests/qtest: ina238: cover a cleared calibration
 per channel
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261015-bmc-minerva-v3-47-7d50c8a108e5@free.fr>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1792056477; l=4102;
 i=emmanuel.blot@free.fr; s=20260602; h=from:subject:message-id;
 bh=2gZSb8/zG9OIbMPLJl7bRBev6cgnZtrY0rkeYgdq44I=;
 b=wNIc+sVHCxAllJTqaogpZtOhqWDui41nSrmTwkeit3qftZL+w+Lh3IRGHnvq+HUl4OejmKpUx
 NBiSh83jIlQC+gRWDzSUqwbYkXncwCvzgZw0cCxOpv7Yssyman1hCBj
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

Verify that without a calibration value the current and power
registers read zero, whichever channels the mode converts.

Reviewed-by: Glenn Miles <milesg@linux.ibm.com>
Signed-off-by: Emmanuel Blot <emmanuel.blot@free.fr>
---
 tests/qtest/ina238-test.c | 48 +++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 48 insertions(+)

diff --git a/tests/qtest/ina238-test.c b/tests/qtest/ina238-test.c
index e7dd50a822..4e4146461c 100644
--- a/tests/qtest/ina238-test.c
+++ b/tests/qtest/ina238-test.c
@@ -282,6 +282,30 @@ static void test_zero_cal(void *obj, void *data, QGuestAllocator *alloc)
     g_assert_cmpuint(i2c_get24(dev, REG_POWER), ==, 0);
 }
 
+/* Clearing SHUNT_CAL zeroes both derived registers in any mode */
+static void test_zero_cal_channels(void *obj, void *data,
+                                   QGuestAllocator *alloc)
+{
+    QI2CDevice *dev = (QI2CDevice *)obj;
+    static const uint16_t modes[] = { 0x9000, 0xA000, 0xF000 };
+    size_t idx;
+
+    for (idx = 0; idx < ARRAY_SIZE(modes); idx++) {
+        i2c_set16(dev, REG_CONFIG, CONFIG_RST);
+        i2c_set16(dev, REG_SHUNT_CAL, 0x0FD2);
+        qmp_ina238_set("shunt-voltage", 97200000);
+        qmp_ina238_set("bus-voltage", 48000000);
+        g_assert_cmphex(i2c_get16(dev, REG_CURRENT), !=, 0x0000);
+        g_assert_cmpuint(i2c_get24(dev, REG_POWER), !=, 0);
+
+        i2c_set16(dev, REG_ADC_CONFIG, modes[idx]);
+        i2c_set16(dev, REG_SHUNT_CAL, 0x0000);
+
+        g_assert_cmphex(i2c_get16(dev, REG_CURRENT), ==, 0x0000);
+        g_assert_cmpuint(i2c_get24(dev, REG_POWER), ==, 0);
+    }
+}
+
 /* ADCRANGE changes the shunt LSB, not the current divisor. */
 static void test_adcrange(void *obj, void *data, QGuestAllocator *alloc)
 {
@@ -458,6 +482,27 @@ static void test_alert_power(void *obj, void *data, QGuestAllocator *alloc)
     g_assert_cmphex(i2c_get16(dev, REG_DIAG_ALRT) & DIAG_POL, ==, 0);
 }
 
+/* Clearing SHUNT_CAL drops the power alert with the power reading */
+static void test_alert_power_zero_cal(void *obj, void *data,
+                                      QGuestAllocator *alloc)
+{
+    QI2CDevice *dev = (QI2CDevice *)obj;
+
+    i2c_set16(dev, REG_CONFIG, CONFIG_RST);
+    qmp_ina238_set("shunt-voltage", 97200000);
+    qmp_ina238_set("bus-voltage", 48000000);
+    i2c_set16(dev, REG_SHUNT_CAL, 0x0FD2);
+    i2c_set16(dev, REG_PWR_LIMIT, 0x0100);
+    g_assert_cmphex(i2c_get16(dev, REG_DIAG_ALRT) & DIAG_POL, ==, DIAG_POL);
+
+    /* Continuous shunt-only: the power register is not reconverted. */
+    i2c_set16(dev, REG_ADC_CONFIG, 0xA000);
+    i2c_set16(dev, REG_SHUNT_CAL, 0x0000);
+
+    g_assert_cmpuint(i2c_get24(dev, REG_POWER), ==, 0);
+    g_assert_cmphex(i2c_get16(dev, REG_DIAG_ALRT) & DIAG_POL, ==, 0);
+}
+
 /* Two thresholds crossed at once are reported simultaneously (multi-alert) */
 static void test_alert_multi(void *obj, void *data, QGuestAllocator *alloc)
 {
@@ -733,6 +778,7 @@ static void ina238_register_nodes(void)
                  NULL);
     qos_add_test("power", "ina238", test_power, NULL);
     qos_add_test("zero-cal", "ina238", test_zero_cal, NULL);
+    qos_add_test("zero-cal-channels", "ina238", test_zero_cal_channels, NULL);
     qos_add_test("adcrange", "ina238", test_adcrange, NULL);
     qos_add_test("mode-shutdown", "ina238", test_mode_shutdown, NULL);
     qos_add_test("mode-triggered", "ina238", test_mode_triggered, NULL);
@@ -742,6 +788,8 @@ static void ina238_register_nodes(void)
     qos_add_test("alert-bus", "ina238", test_alert_bus, NULL);
     qos_add_test("alert-temp", "ina238", test_alert_temp, NULL);
     qos_add_test("alert-power", "ina238", test_alert_power, NULL);
+    qos_add_test("alert-power-zero-cal", "ina238", test_alert_power_zero_cal,
+                 NULL);
     qos_add_test("alert-multi", "ina238", test_alert_multi, NULL);
     qos_add_test("alert-latch", "ina238", test_alert_latch, NULL);
     qos_add_test("alert-latch-persist", "ina238", test_alert_latch_persist,

-- 
2.53.0-Meta


