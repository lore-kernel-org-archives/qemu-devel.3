Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 51DA5606A31B
	for <qemu-devel@archiver.kernel.org>; Thu,  5 Nov 2026 09:16:02 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xOtZU-0008CU-PV; Thu, 05 Nov 2026 04:15:49 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eblot.ml@gmail.com>)
 id 1xOtZP-0007a7-Kg
 for qemu-devel@nongnu.org; Thu, 05 Nov 2026 04:15:44 -0500
Received: from mail-pg1-f172.google.com ([209.85.215.172])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <eblot.ml@gmail.com>)
 id 1xOtZN-0005lr-Bm
 for qemu-devel@nongnu.org; Thu, 05 Nov 2026 04:15:43 -0500
Received: by mail-pg1-f172.google.com with SMTP id
 41be03b00d2f7-cc4c02ddd62so1067196a12.0
 for <qemu-devel@nongnu.org>; Thu, 05 Nov 2026 01:15:40 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793870139; x=1794474939;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=GgVTUxuGD9oTRYIDiMSJ0REbd9D3oR+ntYCQl5qLzoc=;
 b=tMkhtN5+0KZpC7YOHHYYtlaR4vw0VGzuC/KjBJ4n7topqtJAuXv1A0exR+2I6n/Z38
 tclU4Af5hvJcPjDWccaJ6meq76sEaZFeOYICgZeZb8CKQywZ52u3XG12ua4gG2g4Xqqg
 SgBoz4+Xlu6ISXNFZrzdi3VNBm2o/QfhVQjUoOAAkY9A0d6WDpU2Sc2AcWTso3E87Oy2
 TfHUzJywH00LL4GWtdo+tFAFjzitRUKMizEVJInqJRrNEFXLFunYYs+lgh/Mf6uI7j+I
 TlegluSPQ2o+0EbdDPMkSp8sQx8EAJSu9Cp3zqWRSef52Ut7RpfkApY2XRFS/JRc51E6
 f3jQ==
X-Gm-Message-State: APuU4Z874ApLE0iwUy3N++3pzBLap7LkvmkgaYD/WUnyAkFW53id0VT/
 7qiReVZ0vwee2eKwcf9+Fw/YTkALQZdUO9q0XPQGQUg435AE2mY67uQ0Q4jp1JDlMfc=
X-Gm-Gg: AYBFou2oMNgjPV9Bpmb5bGNox2iQZ7QKsxErMXt/eSusZClS3/kpyeE2eUMAvRJjsJB
 KoR9zS8YMOKmICPF3O4WBhhck/Hp6SyEKSe6w/e/NYhi3gYry6QcbpTj1eJQI6cHTm5S8M5Fdn1
 1lIFbsXJEen8B2j8CG/DkaRrzHXz/xPfMWUtCkBSfkVfOBfpXZGvgWHxRLX1A3mI4eShST9CNFv
 Xq7VtAV/49B3ve4xBT2StJJG9DeDKhz3Kg4ly2l871sOFuiH+8xe+cXuGWnVhXDudWzk+i1SXQr
 S6Vl2xA5+ecvmH+9+l2mFqsba3GOhrx8pSGHhIElN7ZKTVtjua066FVyS4zNZ5seWvZBicsCllF
 BjD03+9EEype1+p1zsS6Z33uolPIAVZ4ie3BNJsAf6ANBzIYEVS4mq+GYFNnoZPgREwt29300yB
 pG4cN7pgFtxfE0kSoMWTEqCukIomXER7uMqYgXpoiUv8n7mWatisIDP/+Wu1FAJ5zz5HyjO11Xm
 ThDIIqD7sfW/bR7VErjWSE3B5CludoJhyH7OmoQD4TlE0SE7q7i/bAxqJGZpe/2qi5UPz7LGfj0
 1tU3lBvPqUxy1tSAbEiCnw0kp3MvKIZ7aUH07yyJo9n2NjULZ3ZwAI/N0xVDCxkgEbW0SZm+9tL
 cTXNWmA==
X-Received: by 2002:a17:90b:3811:b0:3b0:adba:45e9 with SMTP id
 98e67ed59e1d1-3b0adc98d2emr2059059a91.58.1793870139343; 
 Thu, 05 Nov 2026 01:15:39 -0800 (PST)
Received: from localhost (118-163-122-149.hinet-ip.hinet.net.
 [118.163.122.149]) by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-3b0b3131f8csm3195613a91.2.2026.11.05.01.15.38
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 05 Nov 2026 01:15:38 -0800 (PST)
Date: Thu, 05 Nov 2026 17:13:08 +0800
Subject: [PATCH 16/16] tests/qtest: ina238: cover a cleared calibration per
 channel
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261105-sensor-ina23x-v1-16-5433ed104990@free.fr>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1793869976; l=4102;
 i=emmanuel.blot@free.fr; s=20260602; h=from:subject:message-id;
 bh=2gZSb8/zG9OIbMPLJl7bRBev6cgnZtrY0rkeYgdq44I=;
 b=6CZ3iFAartqcYhtQ3iug3b5RkJDKGtbt9LqMMbzhkiR5B08rXxn4SUPoaEYqHavyaKWkRPEFr
 29A1MGYGlDlCeUBXxpo68khC06uFpJuvZAzWGZzbdFI22JeP6nIt+WI
X-Developer-Key: i=emmanuel.blot@free.fr; a=ed25519;
 pk=0qFrZ21FAAN8OfVsSoVcCFTk/NMYOWzxJz4paSAVm0g=
Received-SPF: pass client-ip=209.85.215.172; envelope-from=eblot.ml@gmail.com;
 helo=mail-pg1-f172.google.com
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
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

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


