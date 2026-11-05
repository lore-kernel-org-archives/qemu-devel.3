Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE329606A31B
	for <qemu-devel@archiver.kernel.org>; Thu,  5 Nov 2026 09:16:53 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xOtZ7-0006LU-SF; Thu, 05 Nov 2026 04:15:25 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eblot.ml@gmail.com>)
 id 1xOtYG-0005Zw-GJ
 for qemu-devel@nongnu.org; Thu, 05 Nov 2026 04:14:32 -0500
Received: from mail-pf1-f175.google.com ([209.85.210.175])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <eblot.ml@gmail.com>)
 id 1xOtYE-0005Tv-BU
 for qemu-devel@nongnu.org; Thu, 05 Nov 2026 04:14:32 -0500
Received: by mail-pf1-f175.google.com with SMTP id
 d2e1a72fcca58-8a06210b29fso875909b3a.1
 for <qemu-devel@nongnu.org>; Thu, 05 Nov 2026 01:14:29 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793870068; x=1794474868;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=SXVkV6BmIYa4CM52mZdbIuwD6cqbidYPD1oEQTmNrJw=;
 b=2bYAix3DP4e7hS0uct8LW9MsEPCXzCCimvWSI9i5UwH0dTu1TzwTFX0Eh++D6E80fe
 wVk2iGJ/FT0et9x34Y58wb/K+fHzvvTTT4bO1ewHWXkuo9cuk+PTwcMSFPDkuI9zo9Hl
 l5F0n7hEu/i6X+0CcyPjtm2eDNWWpW0bF4wAAg5FSUt1Y4uWblPEINEdqv2GfyW5wYoQ
 WwbaRzlywTOePLtjBL+5L6cYQPlEzgBg+Jv7vB2Y+w/2KUAa9x5dXZJ5AiGlEN3Nxix9
 k79KM1Lp2ESkbgHXBGFgnygd5OU7aPt9HvJ6lV8fSIIz4Q15ZYrMgGkaFq3mUEC0IK9Q
 IjMg==
X-Gm-Message-State: APuU4Z+gs8oa7ywBZjKG9/f6dS3ccC4K5tyNB0GvbCw308F1Zy3Me02/
 epEbYKWeO1S8C1nlhgHSIN3o0t/7kehUoA7kcHg3/u+QOlQix7YNeFeKuVBLVAMHyyo=
X-Gm-Gg: AYBFou13onSRvFSWXpQhxt4cjeb1wMlxHVSVKDDC49lg8s9zYER3cEfenhTnsIvxyti
 0OykvbGcGpQSHXuy3OfVJWGUQemsjbzC8W/og153uUbrRF2F3LbQGWtplxXvV0mQzqe+bXvPcjs
 Dne63Nu/+0AhvQi+Ck7sBqiq6pfKMkQobvPw6zzbbd1dWPTEzbPnz0NYI2k1EvaRQZsqc7FYTxT
 6S9YpQWYua2UToKUd8s64S2CjIyu9/bzF0ssPUcL0oUvV6nZ6kUiTvaOOsi5GVU7Fe3H2CoFUbs
 2Slj6lemZWHHeDL2ufvrY1dZUE7D/nqh5ui6ySVR0q6oSCFGZPwCr+wcMgACgJVwKvVV7/iGJ0E
 MWXyjw+7zunAxmJzJIols6gjOXcuUj48VIuroDXo+FPjEVbQF4ba8UcR7qBzGNwuO9i2Fwaa1VV
 8svaLhBuw+47YupMr7Db2s6e3Q6ikSKBNjTlAfBerZDwINwF+Z00qIdyJaG8JDM0/8iFeVkof09
 Otp4O2snqmi8Wy1JOG8NGUc3HgREmlolNsfKJJs8GuqEEfbgYcHA+ihtxIvWI0EeT+T5v5nvU76
 yw7D1vbXrNUr8hPAHzf/kuqT6ezwlWizwEUxAP2nBl7jbqGOuPJY+EImf3z5NnkmblfRAknPopC
 Z7bAeUA==
X-Received: by 2002:a05:6a21:9cc8:b0:3e2:ab48:c3e0 with SMTP id
 adf61e73a8af0-3e928c8f144mr16807537637.25.1793870068516; 
 Thu, 05 Nov 2026 01:14:28 -0800 (PST)
Received: from localhost (118-163-122-149.hinet-ip.hinet.net.
 [118.163.122.149]) by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-8b09c024a45sm1778162b3a.56.2026.11.05.01.14.27
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 05 Nov 2026 01:14:28 -0800 (PST)
Date: Thu, 05 Nov 2026 17:12:59 +0800
Subject: [PATCH 07/16] tests/qtest: ina230: cover ALERT latch persistence
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261105-sensor-ina23x-v1-7-5433ed104990@free.fr>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1793869975; l=4970;
 i=emmanuel.blot@free.fr; s=20260602; h=from:subject:message-id;
 bh=W8bVV49/k/VdCQ886gBN1IQ0GLO/G1VK52xof55CHLg=;
 b=jjJhkCbtup9uUvlQ54dTHCLDEEpAPJBQz6AnzG7AzbX/OSHuRtw9Id3O9vdANNLNn4HzOgG2Q
 mt0kQiYdDnzApmTm34YijGDZzi7ajJaX6L9HauXAha2c+o9t72cQguh
X-Developer-Key: i=emmanuel.blot@free.fr; a=ed25519;
 pk=0qFrZ21FAAN8OfVsSoVcCFTk/NMYOWzxJz4paSAVm0g=
Received-SPF: pass client-ip=209.85.210.175; envelope-from=eblot.ml@gmail.com;
 helo=mail-pf1-f175.google.com
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

Verify what releases a latched alert and what can bring it back: a
Mask/Enable read and a Configuration write both clear it, and only a
conversion that re-samples the fault on a channel it converted asserts
it again.

Reviewed-by: Glenn Miles <milesg@linux.ibm.com>
Signed-off-by: Emmanuel Blot <emmanuel.blot@free.fr>
---
 tests/qtest/ina230-test.c | 89 +++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 89 insertions(+)

diff --git a/tests/qtest/ina230-test.c b/tests/qtest/ina230-test.c
index 4d601c74b5..cda52bb815 100644
--- a/tests/qtest/ina230-test.c
+++ b/tests/qtest/ina230-test.c
@@ -364,6 +364,88 @@ static void test_alert_latch(void *obj, void *data, QGuestAllocator *alloc)
 }
 
 /* Bus over-limit alert */
+static void test_alert_latch_persist(void *obj, void *data,
+                                     QGuestAllocator *alloc)
+{
+    QI2CDevice *dev = (QI2CDevice *)obj;
+
+    i2c_set16(dev, REG_CONFIG, CONFIG_RST);
+    i2c_set16(dev, REG_ALERT_LIMIT, 0x1000);
+    i2c_set16(dev, REG_MASK_ENABLE, ME_SOL | ME_LEN);
+
+    qmp_ina230_set("shunt-voltage", 20000000);
+
+    /* First read shows the latched AFF and clears the latch */
+    g_assert_cmphex(i2c_get16(dev, REG_MASK_ENABLE) & ME_AFF, ==, ME_AFF);
+
+    /* Fault still present but no new conversion: AFF stays cleared */
+    g_assert_cmphex(i2c_get16(dev, REG_MASK_ENABLE) & ME_AFF, ==, 0);
+
+    qmp_ina230_set("shunt-voltage", 20000000);
+    g_assert_cmphex(i2c_get16(dev, REG_MASK_ENABLE) & ME_AFF, ==, ME_AFF);
+}
+
+/* A Configuration write releases the latch as a Mask/Enable read does. */
+static void test_alert_latch_config(void *obj, void *data,
+                                    QGuestAllocator *alloc)
+{
+    QI2CDevice *dev = (QI2CDevice *)obj;
+
+    i2c_set16(dev, REG_CONFIG, CONFIG_RST);
+    i2c_set16(dev, REG_ALERT_LIMIT, 0x1000);
+    i2c_set16(dev, REG_MASK_ENABLE, ME_SOL | ME_LEN);
+
+    /* Latch a fault, then bring the input back below the limit */
+    qmp_ina230_set("shunt-voltage", 20000000);
+    qmp_ina230_set("shunt-voltage", 2500000);
+
+    i2c_set16(dev, REG_CONFIG, CONFIG_POR);
+    g_assert_cmphex(i2c_get16(dev, REG_MASK_ENABLE) & ME_AFF, ==, 0);
+
+    /* With the fault present, the reconversion latches it again */
+    qmp_ina230_set("shunt-voltage", 20000000);
+    i2c_set16(dev, REG_CONFIG, CONFIG_POR);
+    g_assert_cmphex(i2c_get16(dev, REG_MASK_ENABLE) & ME_AFF, ==, ME_AFF);
+}
+
+/* The releasing write need not reconvert: a power-down leaves it clear. */
+static void test_alert_latch_shutdown(void *obj, void *data,
+                                      QGuestAllocator *alloc)
+{
+    QI2CDevice *dev = (QI2CDevice *)obj;
+
+    i2c_set16(dev, REG_CONFIG, CONFIG_RST);
+    i2c_set16(dev, REG_ALERT_LIMIT, 0x1000);
+    i2c_set16(dev, REG_MASK_ENABLE, ME_SOL | ME_LEN);
+
+    qmp_ina230_set("shunt-voltage", 20000000);
+
+    i2c_set16(dev, REG_CONFIG, 0x0000); /* power-down */
+    g_assert_cmphex(i2c_get16(dev, REG_MASK_ENABLE) & ME_AFF, ==, 0);
+}
+
+/*
+ * A conversion only re-samples the alert of a channel it converted: the bus
+ * register a shunt-only conversion left stale must not re-latch.
+ */
+static void test_alert_channel(void *obj, void *data, QGuestAllocator *alloc)
+{
+    QI2CDevice *dev = (QI2CDevice *)obj;
+
+    i2c_set16(dev, REG_CONFIG, CONFIG_RST);
+    i2c_set16(dev, REG_ALERT_LIMIT, 0x2000);
+    i2c_set16(dev, REG_MASK_ENABLE, ME_BOL | ME_LEN);
+
+    qmp_ina230_set("bus-voltage", 12000000);
+    g_assert_cmphex(i2c_get16(dev, REG_MASK_ENABLE) & ME_AFF, ==, ME_AFF);
+
+    /* Shunt-only mode: the bus register keeps its over-limit value */
+    i2c_set16(dev, REG_CONFIG, 0x0005);
+    qmp_ina230_set("shunt-voltage", 20000000);
+    g_assert_cmphex(i2c_get16(dev, REG_BUS), ==, 0x2580);
+    g_assert_cmphex(i2c_get16(dev, REG_MASK_ENABLE) & ME_AFF, ==, 0);
+}
+
 static void test_alert_bus(void *obj, void *data, QGuestAllocator *alloc)
 {
     QI2CDevice *dev = (QI2CDevice *)obj;
@@ -481,6 +563,13 @@ static void ina230_register_nodes(void)
     qos_add_test("edges-overflow", "ina230", test_edges_overflow, NULL);
     qos_add_test("alert-shunt-over", "ina230", test_alert_shunt_over, NULL);
     qos_add_test("alert-latch", "ina230", test_alert_latch, NULL);
+    qos_add_test("alert-latch-persist", "ina230", test_alert_latch_persist,
+                 NULL);
+    qos_add_test("alert-latch-config", "ina230", test_alert_latch_config,
+                 NULL);
+    qos_add_test("alert-latch-shutdown", "ina230", test_alert_latch_shutdown,
+                 NULL);
+    qos_add_test("alert-channel", "ina230", test_alert_channel, NULL);
     qos_add_test("alert-bus", "ina230", test_alert_bus, NULL);
     qos_add_test("alert-power", "ina230", test_alert_power, NULL);
     qos_add_test("cvrf", "ina230", test_cvrf, NULL);

-- 
2.53.0-Meta


