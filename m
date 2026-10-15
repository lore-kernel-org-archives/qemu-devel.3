Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6CDB9CC6B30
	for <qemu-devel@archiver.kernel.org>; Thu, 15 Oct 2026 10:33:27 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xHIlb-0004rM-Gn; Thu, 15 Oct 2026 06:32:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eblot.ml@gmail.com>)
 id 1xHIhx-00081z-HB
 for qemu-devel@nongnu.org; Thu, 15 Oct 2026 06:29:11 -0400
Received: from mail-wm1-f47.google.com ([209.85.128.47])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <eblot.ml@gmail.com>)
 id 1xHIhu-0004VF-7q
 for qemu-devel@nongnu.org; Thu, 15 Oct 2026 06:29:08 -0400
Received: by mail-wm1-f47.google.com with SMTP id
 5b1f17b1804b1-4a1635f7c89so19431235e9.2
 for <qemu-devel@nongnu.org>; Thu, 15 Oct 2026 03:29:05 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792060145; x=1792664945;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=dLcH89Q+3v52wJ3aHqyuR198A/y0zPJ5UzMGy5C22Zs=;
 b=rlFTzbjJ63C7I+AqONAVNyu4XgX0xGQKhc5uwdpu8WjneaGAfdmqavmRlDSLQZ3VTE
 4c3uCQUjNS9/bS2cpmUpTk3UefzwO9qxWhjeoruziQhFlXIf5ZUFZiHOPZyxXvrTlUT/
 gi5mNO8LTnZEvgvfJHT5Mfg34TEzRL/V3/9bw0a3L9R7VATocRpkK2v9fiJqMyMabptR
 PlPonxy71Ee97dgaF45Hmo997fKmZVpok8SJtAcwe0TASweNUl1jFGJYdgYOqcDA+JPO
 KkeNr8KXK3Tzd9C63qBPkRGEMEpDz/MNUIEQTcemZOnRtW573+M4b04CiiDF//F74Tq4
 atqA==
X-Gm-Message-State: AFq9FYKGMw2VSj4AVVvMKgjl4YpT41M+PFSlm5pfSqR/5TcQFSDGMX/w
 LvVlpN4B/fw8XWClPCdinKT2baxWDyKPOm0xrTBgWHUcQKysK72q4JP0009EIg==
X-Gm-Gg: AYBFou1CK5nRK7mizSeQaqa1uvEPdDZQRZWdf4RLn3PW6c02DGAnmFNieIMJ0kDNZ1K
 tWuk3jD8Qn9BNNydjCuU+rhTKsZsiYYzC4bFNDV0vs3OWPunpPj5DmufAh+vYdJNf0bp3Lnfhu5
 K2t55MZNbv45CrATnc7pjJR3NIDg4d/fmrzvydUxyd9AIGl6xm0qFBqZzK3hyt6tdSnDHah/an+
 MP2jbXYQ8mg14/fY7nYrJAIyKT1gUB4KDGdDtDZ6puU/xM0v7JxcBz1/gMdoVk/f1+Gyg6152M8
 SpXHrtjkF8icFZi9JK7ffx8HGeOGYI+oHDa2aTnsX7FPzBa1clb1jmBP90GbCK1646PlwksHku3
 cUBJy7nVxNy2HEJ+qgCjTgs3yMX20B6bUVH6fsYOkXhNguAHWGma4lBMr2oQvn9Ctxs1bT7RZ7+
 A+i3xVQ6pFZF5VlcBQRVgaL8VGbxQdSLs3jKLB+lFl8TsPUgFT4+hBoTD+hk3jpfI1GN7SjLCqC
 cNhR+SMNIbgGqNuiWQvdG4+vs2XWwSelh537MOhLg0HCxV2l7kggGdD
X-Received: by 2002:a05:600c:6099:b0:4a0:1feb:de6a with SMTP id
 5b1f17b1804b1-4a18e4e7a85mr354418085e9.30.1792060144602; 
 Thu, 15 Oct 2026 03:29:04 -0700 (PDT)
Received: from localhost (89-93-216-19.hfc.dyn.abo.bbox.fr. [89.93.216.19])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4a1bd99faf3sm59782235e9.14.2026.10.15.03.29.03
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 15 Oct 2026 03:29:03 -0700 (PDT)
Date: Thu, 15 Oct 2026 11:28:30 +0200
Subject: [PATCH v3 43/50] tests/qtest: ina238: cover the ALERT path and
 conversion-ready flag
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261015-bmc-minerva-v3-43-7d50c8a108e5@free.fr>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1792056477; l=6719;
 i=emmanuel.blot@free.fr; s=20260602; h=from:subject:message-id;
 bh=ZC7CGjlcMtlHZ+/DXyYJ8lCNdfyQ5Stw/MJqODCAIbA=;
 b=rHpH4ya7Z9w2z+fyQEoQ6nfz3frhkTmVGa5QBucqGTtLqr+IurQIm8yf67taqNv7yLKf/d2eL
 Zo+T01lYxI7C5uurS0s/S3I3Uo6/yW27PBDpRv6G9BnnB5RJOHu9if4
X-Developer-Key: i=emmanuel.blot@free.fr; a=ed25519;
 pk=0qFrZ21FAAN8OfVsSoVcCFTk/NMYOWzxJz4paSAVm0g=
Received-SPF: pass client-ip=209.85.128.47; envelope-from=eblot.ml@gmail.com;
 helo=mail-wm1-f47.google.com
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

Cover the shunt/bus/temperature/power alert thresholds, the multi-alert
OR behaviour, the alert latch, the DIAG_ALRT control bits and the
conversion-ready (CNVRF) flag.

Reviewed-by: Glenn Miles <milesg@linux.ibm.com>
Signed-off-by: Emmanuel Blot <emmanuel.blot@free.fr>
---
 tests/qtest/ina238-test.c | 146 +++++++++++++++++++++++++++++++++++++++++++++-
 1 file changed, 145 insertions(+), 1 deletion(-)

diff --git a/tests/qtest/ina238-test.c b/tests/qtest/ina238-test.c
index 693139f988..08813377c9 100644
--- a/tests/qtest/ina238-test.c
+++ b/tests/qtest/ina238-test.c
@@ -306,7 +306,143 @@ static void test_overflow(void *obj, void *data, QGuestAllocator *alloc)
                     DIAG_MATHOF);
 }
 
-/* Shunt over-limit alert (transparent mode) */
+/* Shunt over-limit alert */
+static void test_alert_shunt(void *obj, void *data, QGuestAllocator *alloc)
+{
+    QI2CDevice *dev = (QI2CDevice *)obj;
+
+    i2c_set16(dev, REG_CONFIG, CONFIG_RST);
+    i2c_set16(dev, REG_SOVL, 0x1000);
+
+    qmp_ina238_set("shunt-voltage", 5000000);
+    g_assert_cmphex(i2c_get16(dev, REG_DIAG_ALRT) & DIAG_SHNTOL, ==, 0);
+
+    qmp_ina238_set("shunt-voltage", 97200000);
+    g_assert_cmphex(i2c_get16(dev, REG_DIAG_ALRT) & DIAG_SHNTOL, ==,
+                    DIAG_SHNTOL);
+
+    qmp_ina238_set("shunt-voltage", 5000000);
+    g_assert_cmphex(i2c_get16(dev, REG_DIAG_ALRT) & DIAG_SHNTOL, ==, 0);
+}
+
+/* Bus over-limit alert */
+static void test_alert_bus(void *obj, void *data, QGuestAllocator *alloc)
+{
+    QI2CDevice *dev = (QI2CDevice *)obj;
+
+    i2c_set16(dev, REG_CONFIG, CONFIG_RST);
+    i2c_set16(dev, REG_BOVL, 0x1000);
+
+    qmp_ina238_set("bus-voltage", 12000000);
+    g_assert_cmphex(i2c_get16(dev, REG_DIAG_ALRT) & DIAG_BUSOL, ==, 0);
+
+    qmp_ina238_set("bus-voltage", 48000000);
+    g_assert_cmphex(i2c_get16(dev, REG_DIAG_ALRT) & DIAG_BUSOL, ==, DIAG_BUSOL);
+}
+
+/* Over-temperature alert */
+static void test_alert_temp(void *obj, void *data, QGuestAllocator *alloc)
+{
+    QI2CDevice *dev = (QI2CDevice *)obj;
+
+    i2c_set16(dev, REG_CONFIG, CONFIG_RST);
+    i2c_set16(dev, REG_TEMP_LIMIT, 0x0A00);
+
+    qmp_ina238_set("die-temperature", 10000);
+    g_assert_cmphex(i2c_get16(dev, REG_DIAG_ALRT) & DIAG_TMPOL, ==, 0);
+
+    qmp_ina238_set("die-temperature", 25000);
+    g_assert_cmphex(i2c_get16(dev, REG_DIAG_ALRT) & DIAG_TMPOL, ==, DIAG_TMPOL);
+}
+
+/* Power over-limit alert */
+static void test_alert_power(void *obj, void *data, QGuestAllocator *alloc)
+{
+    QI2CDevice *dev = (QI2CDevice *)obj;
+
+    i2c_set16(dev, REG_CONFIG, CONFIG_RST);
+    qmp_ina238_set("shunt-voltage", 97200000);
+    qmp_ina238_set("bus-voltage", 48000000);
+    i2c_set16(dev, REG_SHUNT_CAL, 0x0FD2);
+
+    i2c_set16(dev, REG_PWR_LIMIT, 0x0100);
+    g_assert_cmphex(i2c_get16(dev, REG_DIAG_ALRT) & DIAG_POL, ==, DIAG_POL);
+
+    i2c_set16(dev, REG_PWR_LIMIT, 0x7FFF);
+    g_assert_cmphex(i2c_get16(dev, REG_DIAG_ALRT) & DIAG_POL, ==, 0);
+}
+
+/* Two thresholds crossed at once are reported simultaneously (multi-alert) */
+static void test_alert_multi(void *obj, void *data, QGuestAllocator *alloc)
+{
+    QI2CDevice *dev = (QI2CDevice *)obj;
+    uint16_t diag;
+
+    i2c_set16(dev, REG_CONFIG, CONFIG_RST);
+    i2c_set16(dev, REG_SOVL, 0x1000);
+    i2c_set16(dev, REG_BOVL, 0x1000);
+
+    qmp_ina238_set("shunt-voltage", 97200000);
+    qmp_ina238_set("bus-voltage", 48000000);
+
+    diag = i2c_get16(dev, REG_DIAG_ALRT);
+    g_assert_cmphex(diag & DIAG_SHNTOL, ==, DIAG_SHNTOL);
+    g_assert_cmphex(diag & DIAG_BUSOL, ==, DIAG_BUSOL);
+}
+
+/* Latch mode holds the flag until the DIAG_ALRT register is read */
+static void test_alert_latch(void *obj, void *data, QGuestAllocator *alloc)
+{
+    QI2CDevice *dev = (QI2CDevice *)obj;
+
+    i2c_set16(dev, REG_CONFIG, CONFIG_RST);
+    i2c_set16(dev, REG_SOVL, 0x1000);
+    i2c_set16(dev, REG_DIAG_ALRT, DIAG_ALATCH);
+
+    qmp_ina238_set("shunt-voltage", 97200000);
+    qmp_ina238_set("shunt-voltage", 5000000);
+
+    g_assert_cmphex(i2c_get16(dev, REG_DIAG_ALRT) & DIAG_SHNTOL, ==,
+                    DIAG_SHNTOL);
+
+    g_assert_cmphex(i2c_get16(dev, REG_DIAG_ALRT) & DIAG_SHNTOL, ==, 0);
+}
+
+/* DIAG_ALRT control bits are writable; status bits are read-only */
+static void test_diag_control(void *obj, void *data, QGuestAllocator *alloc)
+{
+    QI2CDevice *dev = (QI2CDevice *)obj;
+    uint16_t diag;
+
+    i2c_set16(dev, REG_CONFIG, CONFIG_RST);
+
+    i2c_set16(dev, REG_DIAG_ALRT,
+              DIAG_ALATCH | DIAG_CNVR | DIAG_SLOWALERT | DIAG_APOL);
+    diag = i2c_get16(dev, REG_DIAG_ALRT);
+    g_assert_cmphex(diag & DIAG_ALATCH, ==, DIAG_ALATCH);
+    g_assert_cmphex(diag & DIAG_CNVR, ==, DIAG_CNVR);
+    g_assert_cmphex(diag & DIAG_SLOWALERT, ==, DIAG_SLOWALERT);
+    g_assert_cmphex(diag & DIAG_APOL, ==, DIAG_APOL);
+    /* MEMSTAT stays set */
+    g_assert_cmphex(diag & DIAG_MEMSTAT, ==, DIAG_MEMSTAT);
+}
+
+/* Every DIAG_ALRT read clears CNVRF, whatever the alert-latch mode. */
+static void test_cnvrf(void *obj, void *data, QGuestAllocator *alloc)
+{
+    QI2CDevice *dev = (QI2CDevice *)obj;
+
+    i2c_set16(dev, REG_CONFIG, CONFIG_RST);
+    qmp_ina238_set("shunt-voltage", 20000000);
+    g_assert_cmphex(i2c_get16(dev, REG_DIAG_ALRT) & DIAG_CNVRF, ==, DIAG_CNVRF);
+    g_assert_cmphex(i2c_get16(dev, REG_DIAG_ALRT) & DIAG_CNVRF, ==, 0);
+
+    i2c_set16(dev, REG_DIAG_ALRT, DIAG_ALATCH);
+    qmp_ina238_set("shunt-voltage", 20000000);
+    g_assert_cmphex(i2c_get16(dev, REG_DIAG_ALRT) & DIAG_CNVRF, ==, DIAG_CNVRF);
+    g_assert_cmphex(i2c_get16(dev, REG_DIAG_ALRT) & DIAG_CNVRF, ==, 0);
+}
+
 static void ina238_register_nodes(void)
 {
     QOSGraphEdgeOptions opts = {
@@ -329,5 +465,13 @@ static void ina238_register_nodes(void)
     qos_add_test("zero-cal", "ina238", test_zero_cal, NULL);
     qos_add_test("adcrange", "ina238", test_adcrange, NULL);
     qos_add_test("overflow", "ina238", test_overflow, NULL);
+    qos_add_test("alert-shunt", "ina238", test_alert_shunt, NULL);
+    qos_add_test("alert-bus", "ina238", test_alert_bus, NULL);
+    qos_add_test("alert-temp", "ina238", test_alert_temp, NULL);
+    qos_add_test("alert-power", "ina238", test_alert_power, NULL);
+    qos_add_test("alert-multi", "ina238", test_alert_multi, NULL);
+    qos_add_test("alert-latch", "ina238", test_alert_latch, NULL);
+    qos_add_test("diag-control", "ina238", test_diag_control, NULL);
+    qos_add_test("cnvrf", "ina238", test_cnvrf, NULL);
 }
 libqos_init(ina238_register_nodes);

-- 
2.53.0-Meta


