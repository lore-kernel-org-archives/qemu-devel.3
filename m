Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 016B9CC6B3C
	for <qemu-devel@archiver.kernel.org>; Thu, 15 Oct 2026 10:37:12 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xHIlq-0005v8-PD; Thu, 15 Oct 2026 06:33:10 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eblot.ml@gmail.com>)
 id 1xHIiF-0008HN-8l
 for qemu-devel@nongnu.org; Thu, 15 Oct 2026 06:29:27 -0400
Received: from mail-wm1-f47.google.com ([209.85.128.47])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <eblot.ml@gmail.com>)
 id 1xHIiD-0004a7-8f
 for qemu-devel@nongnu.org; Thu, 15 Oct 2026 06:29:26 -0400
Received: by mail-wm1-f47.google.com with SMTP id
 5b1f17b1804b1-4a180fbeef5so46433145e9.1
 for <qemu-devel@nongnu.org>; Thu, 15 Oct 2026 03:29:24 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792060164; x=1792664964;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=c6Lwpzu4bQyFqEheBTwdIlkXZjUIiiE3va3aldXb5fM=;
 b=MCa5fEtzDq37xOMUhnO25/DrFRIkZYqM63eQQb8MoCRWpV3QUclQN2NSD/G1/3YLQC
 ZCJxxFPADeCoNYqvqOJZkhRoh0Lhc/LgPIru1eqVRmapyWycWrOO8tI68KZxyHsxNTaI
 5hVTYQt+z5Cx9fwm7ii5qmRcyeGylM69jAIXUJSW4clB3QnzGHkARQg8TARHi19B0Alt
 qjUNB4A6Lp94JimgRhr/Z8scttXxdYIhQ6SMBjcSrYaZmW1Q1Obn5o6BQqPKepmfBqtU
 8rIPHiJ/AxM1DiHfbSwxFnf3WH6HurtxWdSgvmNXgwxHejfVTS5JVIW5tqIZX2Vaa/HZ
 m0mA==
X-Gm-Message-State: AFq9FYKQvk7YIMaVC3I9Kme2j4lYuFK2n6sCdwSNFQWZtBzRH9M8j8r1
 6Uqo7ERkWBIJaZAlA/+qNNgx/7D9784i3RhcMK4dRaDnrXNljscNG9oXbvIX8Q==
X-Gm-Gg: AYBFou0gtcGBNauZ0bRY8WQ+eBtFYcm3NGooYAxbnEOye961AP2mmmLkdb7mBaRdsK9
 rq6eYXLLIM95UWO07jebMepiejJqlE39fOjesDfq7rfZ57In0DNUG/J4ayEKzWujNq5TivE+faT
 kYpfkZCCFvbHNGUf4EEtOGS1eN3ybbbUOgujJcYuZzpMzZZs6DVozR5OeX9Qp62icMgtYFfSSdO
 XHFEXFvajWWtc2WBouCQeZegiWT+Lws6maL7PL8zfvqbnOL6TM52tFHIV3JZlBuoXng+0dYHnDe
 LU+eT3UIbEb9jSIbaWQmVDujKZ69ZsSk0CbwKP5WPYnmZuDUTdq+1hDGOeXGSIMVHpSPxAiWN/Q
 SzteXlZox6233HG9qb47Bv5RVy9Wsg9IE6eI+pjrTlksvg3Oi7pfOOYaVtXr1i2LCyACbeHD5Ly
 7RRSvcmIukANzo7TZod6oDNG2GEeHBp8Osh03Mbt9uKkLS+xhSmZ6NGb62aq/maoo42WNmrSbpI
 +zeq0xNhOACQNtv42SFrlE9EvHe6s7VjtorYjOZtGFHYg==
X-Received: by 2002:a05:600c:1909:b0:4a1:722a:d2a3 with SMTP id
 5b1f17b1804b1-4a18e4a3f5amr413285845e9.23.1792060163587; 
 Thu, 15 Oct 2026 03:29:23 -0700 (PDT)
Received: from localhost (89-93-216-19.hfc.dyn.abo.bbox.fr. [89.93.216.19])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4a1bd97ed6asm60537935e9.6.2026.10.15.03.29.22
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 15 Oct 2026 03:29:23 -0700 (PDT)
Date: Thu, 15 Oct 2026 11:28:33 +0200
Subject: [PATCH v3 46/50] tests/qtest: ina238: cover conversion-ready and
 alert-latch semantics
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261015-bmc-minerva-v3-46-7d50c8a108e5@free.fr>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1792056477; l=6851;
 i=emmanuel.blot@free.fr; s=20260602; h=from:subject:message-id;
 bh=RdMmfGACFu+w8i2ytQE/+wzOyY16K5WkLJ6oJOceA5s=;
 b=ve2uV7WG0dY71mw/JESMZcvZHEfWsfc6Do7QWfX3cZuOjB3b31ZI/QO5FlSbW7XYCMFsaEA8k
 MEI7OoqMYQ5AXdZLNeMHkhqZ2QHHe7Hq10BhRBervDSBis/BlyIuAsK
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

Add coverage for the DIAG_ALRT flag-clearing rules: which of a read and
a write clears CNVRF and the limit flags in each alert mode, and that a
conversion only re-evaluates the flags of the channels it converted.

Reviewed-by: Glenn Miles <milesg@linux.ibm.com>
Signed-off-by: Emmanuel Blot <emmanuel.blot@free.fr>
---
 tests/qtest/ina238-test.c | 127 ++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 127 insertions(+)

diff --git a/tests/qtest/ina238-test.c b/tests/qtest/ina238-test.c
index fb7bcc265c..e7dd50a822 100644
--- a/tests/qtest/ina238-test.c
+++ b/tests/qtest/ina238-test.c
@@ -494,6 +494,106 @@ static void test_alert_latch(void *obj, void *data, QGuestAllocator *alloc)
     g_assert_cmphex(i2c_get16(dev, REG_DIAG_ALRT) & DIAG_SHNTOL, ==, 0);
 }
 
+/* In latch mode a read releases the flag even while the fault persists. */
+static void test_alert_latch_persist(void *obj, void *data,
+                                     QGuestAllocator *alloc)
+{
+    QI2CDevice *dev = (QI2CDevice *)obj;
+
+    i2c_set16(dev, REG_CONFIG, CONFIG_RST);
+    i2c_set16(dev, REG_SOVL, 0x1000);
+    i2c_set16(dev, REG_DIAG_ALRT, DIAG_ALATCH);
+
+    qmp_ina238_set("shunt-voltage", 97200000);
+
+    /* First read shows the latched flag and clears it */
+    g_assert_cmphex(i2c_get16(dev, REG_DIAG_ALRT) & DIAG_SHNTOL, ==,
+                    DIAG_SHNTOL);
+
+    /* Fault still present but no new conversion: the flag stays cleared */
+    g_assert_cmphex(i2c_get16(dev, REG_DIAG_ALRT) & DIAG_SHNTOL, ==, 0);
+
+    qmp_ina238_set("shunt-voltage", 97200000);
+    g_assert_cmphex(i2c_get16(dev, REG_DIAG_ALRT) & DIAG_SHNTOL, ==,
+                    DIAG_SHNTOL);
+}
+
+/*
+ * In transparent mode a limit flag follows the live condition: a read leaves
+ * it set while the fault persists.
+ */
+static void test_alert_transparent_persist(void *obj, void *data,
+                                           QGuestAllocator *alloc)
+{
+    QI2CDevice *dev = (QI2CDevice *)obj;
+
+    i2c_set16(dev, REG_CONFIG, CONFIG_RST);
+    i2c_set16(dev, REG_SOVL, 0x1000);
+
+    qmp_ina238_set("shunt-voltage", 97200000);
+    g_assert_cmphex(i2c_get16(dev, REG_DIAG_ALRT) & DIAG_SHNTOL, ==,
+                    DIAG_SHNTOL);
+
+    /* Repeated reads do not clear the flag while the fault is still present. */
+    g_assert_cmphex(i2c_get16(dev, REG_DIAG_ALRT) & DIAG_SHNTOL, ==,
+                    DIAG_SHNTOL);
+
+    /* A conversion with the fault gone clears it. */
+    qmp_ina238_set("shunt-voltage", 5000000);
+    g_assert_cmphex(i2c_get16(dev, REG_DIAG_ALRT) & DIAG_SHNTOL, ==, 0);
+}
+
+/* A DIAG_ALRT write releases a latched limit flag as a read does. */
+static void test_alert_latch_write_clears(void *obj, void *data,
+                                          QGuestAllocator *alloc)
+{
+    QI2CDevice *dev = (QI2CDevice *)obj;
+
+    i2c_set16(dev, REG_CONFIG, CONFIG_RST);
+    i2c_set16(dev, REG_SOVL, 0x1000);
+    i2c_set16(dev, REG_DIAG_ALRT, DIAG_ALATCH);
+
+    qmp_ina238_set("shunt-voltage", 97200000);
+    g_assert_cmphex(i2c_get16(dev, REG_DIAG_ALRT) & DIAG_SHNTOL, ==,
+                    DIAG_SHNTOL);
+
+    /* The read above cleared it; re-latch it with another conversion. */
+    qmp_ina238_set("shunt-voltage", 97200000);
+
+    /* A write (keeping latch mode) clears the flag while the fault persists. */
+    i2c_set16(dev, REG_DIAG_ALRT, DIAG_ALATCH);
+    g_assert_cmphex(i2c_get16(dev, REG_DIAG_ALRT) & DIAG_SHNTOL, ==, 0);
+
+    /* The next conversion re-asserts the still-present fault. */
+    qmp_ina238_set("shunt-voltage", 97200000);
+    g_assert_cmphex(i2c_get16(dev, REG_DIAG_ALRT) & DIAG_SHNTOL, ==,
+                    DIAG_SHNTOL);
+}
+
+/*
+ * A conversion only re-evaluates the flags of the channels it converted: the
+ * shunt register a bus-only conversion left stale must not resurrect one.
+ */
+static void test_alert_channel(void *obj, void *data, QGuestAllocator *alloc)
+{
+    QI2CDevice *dev = (QI2CDevice *)obj;
+
+    i2c_set16(dev, REG_CONFIG, CONFIG_RST);
+    i2c_set16(dev, REG_SOVL, 0x1000);
+    i2c_set16(dev, REG_DIAG_ALRT, DIAG_ALATCH);
+
+    qmp_ina238_set("shunt-voltage", 97200000);
+    g_assert_cmphex(i2c_get16(dev, REG_DIAG_ALRT) & DIAG_SHNTOL, ==,
+                    DIAG_SHNTOL);
+
+    /* Continuous bus-only mode */
+    i2c_set16(dev, REG_ADC_CONFIG, 0x9000);
+    qmp_ina238_set("bus-voltage", 12000000);
+
+    g_assert_cmphex(i2c_get16(dev, REG_VSHUNT), ==, 0x4BF0);
+    g_assert_cmphex(i2c_get16(dev, REG_DIAG_ALRT) & DIAG_SHNTOL, ==, 0);
+}
+
 /* DIAG_ALRT control bits are writable; status bits are read-only */
 static void test_diag_control(void *obj, void *data, QGuestAllocator *alloc)
 {
@@ -529,6 +629,25 @@ static void test_cnvrf(void *obj, void *data, QGuestAllocator *alloc)
     g_assert_cmphex(i2c_get16(dev, REG_DIAG_ALRT) & DIAG_CNVRF, ==, 0);
 }
 
+/* A DIAG_ALRT write clears CNVRF only in latch mode. */
+static void test_cnvrf_write(void *obj, void *data, QGuestAllocator *alloc)
+{
+    QI2CDevice *dev = (QI2CDevice *)obj;
+
+    /* Latch mode: a write clears CNVRF. */
+    i2c_set16(dev, REG_CONFIG, CONFIG_RST);
+    i2c_set16(dev, REG_DIAG_ALRT, DIAG_ALATCH);
+    qmp_ina238_set("shunt-voltage", 20000000);
+    i2c_set16(dev, REG_DIAG_ALRT, DIAG_ALATCH);
+    g_assert_cmphex(i2c_get16(dev, REG_DIAG_ALRT) & DIAG_CNVRF, ==, 0);
+
+    /* Transparent mode: a write does not clear CNVRF. */
+    i2c_set16(dev, REG_CONFIG, CONFIG_RST);
+    qmp_ina238_set("shunt-voltage", 20000000);
+    i2c_set16(dev, REG_DIAG_ALRT, 0x0000);
+    g_assert_cmphex(i2c_get16(dev, REG_DIAG_ALRT) & DIAG_CNVRF, ==, DIAG_CNVRF);
+}
+
 /* Shunt-voltage injection limits */
 static void test_shunt_limits(void *obj, void *data, QGuestAllocator *alloc)
 {
@@ -625,7 +744,15 @@ static void ina238_register_nodes(void)
     qos_add_test("alert-power", "ina238", test_alert_power, NULL);
     qos_add_test("alert-multi", "ina238", test_alert_multi, NULL);
     qos_add_test("alert-latch", "ina238", test_alert_latch, NULL);
+    qos_add_test("alert-latch-persist", "ina238", test_alert_latch_persist,
+                 NULL);
+    qos_add_test("alert-transparent-persist", "ina238",
+                 test_alert_transparent_persist, NULL);
+    qos_add_test("alert-latch-write-clears", "ina238",
+                 test_alert_latch_write_clears, NULL);
+    qos_add_test("alert-channel", "ina238", test_alert_channel, NULL);
     qos_add_test("diag-control", "ina238", test_diag_control, NULL);
     qos_add_test("cnvrf", "ina238", test_cnvrf, NULL);
+    qos_add_test("cnvrf-write", "ina238", test_cnvrf_write, NULL);
 }
 libqos_init(ina238_register_nodes);

-- 
2.53.0-Meta


