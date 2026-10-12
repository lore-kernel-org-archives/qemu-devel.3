Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 18F64CA9EC5
	for <qemu-devel@archiver.kernel.org>; Mon, 12 Oct 2026 15:39:54 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xGI7k-000385-50; Mon, 12 Oct 2026 11:39:36 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eblot.ml@gmail.com>)
 id 1xGI7i-00037Q-8s
 for qemu-devel@nongnu.org; Mon, 12 Oct 2026 11:39:34 -0400
Received: from mail-wm1-f48.google.com ([209.85.128.48])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <eblot.ml@gmail.com>)
 id 1xGI7g-0003hg-7v
 for qemu-devel@nongnu.org; Mon, 12 Oct 2026 11:39:33 -0400
Received: by mail-wm1-f48.google.com with SMTP id
 5b1f17b1804b1-4a020e65269so12695005e9.2
 for <qemu-devel@nongnu.org>; Mon, 12 Oct 2026 08:39:31 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1791819571; x=1792424371;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=YTjYUeqnG0FlRaXGHN4hD5QBCzdcaj4DW5tltJJmmu4=;
 b=Q7xCit10cFzCKuBcOTJX8XTEUynZUcYkGS0vZwZbTEt+iGwikrvgs39kIDIglVjlwb
 cwPpwW89dtz4acRUkPYfZFffaTp+4e3lxEQSuc2f84naXif6qG0OOqqhsoCq6VAC17KO
 aNTpmkYjX0PJEEdx+HSRB3RrIcFkYoS/2Lfd8MqC729I4DM7CqeuWbsnil49DTMSDbuD
 m/a3nDH0Bv5JIl0vC5yRB0fYTNQeCfYBrr+miTafMQ+Uq8/e4dnPYUgOiV8z3H9uvcJj
 NctXc1Hfkmm+sMW0qqEva580AWylioomfzfWJdvwXaBWoIQJOsXXSj6CSy+nd3jD/Yl3
 EL7A==
X-Gm-Message-State: AFq9FYKSqLFV7youruj8tZzd9POjI4AVFx4S+Rrr30b8RNAMb2E+H0aC
 TYGYK7B/D6lnhkrVsKBIKPm9pf13WVftaWzLEdJr1Zh6Oi/WR11pRyEkNoHtdaVh
X-Gm-Gg: AYBFou1gnzPOL43Ifk0AKQFkAVS4p+Di1XjBw0RxM69fbV4+PAA+iekBlmXJg5bsyEB
 8P2TAQpPc9d7BAeuP+l9UEfT2FLfsE03eopCoIuf194cy9RoV0OhaS60YYfFMwNlcxfmnsl0EET
 uq4dIB5TpEdyLEqNzR0PLNLbMRXGzd8LWbhxyQ0uvZyiCfvfupsmBLWf/mHs9OYSBMTmZcjNqWB
 H6Dhrrbbz+xMwneMm81m4FQXNdwBUI9fHIiDvupSl5ZJvRBgBcwNUReqzpKMNYq/XuRPYd85I9Y
 2DiEj6lMw++snE7TOE7KZ8EK+UcGO5XIAlCmsW2E7ZI7cCEVh3+Yv2RaFFheaLjT9tI/PNYidrN
 cg9d2HIuZnSiwA1aOZ1Cu9r7Rs1DYjPAN6pYWXkomTIPDWVOCMQweXiRQWGSGDbhTetCYK7e05Y
 KgY1IlWAxOducS4J670bEdXkStbnn0N4f9G0Tv28V1Q1zOFnN9SVmSwsK+C9Qy3FbTikKu+vdPB
 HD6uUipBab0AIaQaTFqQ4IFmp8013LmtjBo9CgkGk6FMJY=
X-Received: by 2002:a05:600c:6215:b0:4a0:eae0:b30e with SMTP id
 5b1f17b1804b1-4a18e4ca157mr161813135e9.22.1791819570538; 
 Mon, 12 Oct 2026 08:39:30 -0700 (PDT)
Received: from localhost (89-93-216-19.hfc.dyn.abo.bbox.fr. [89.93.216.19])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4a18c198134sm296467685e9.15.2026.10.12.08.39.28
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 12 Oct 2026 08:39:29 -0700 (PDT)
Date: Mon, 12 Oct 2026 16:32:39 +0200
Subject: [PATCH v2 46/50] tests/qtest: ina238: cover conversion-ready and
 alert-latch semantics
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261012-bmc-minerva-v2-46-4c3dff084ec9@free.fr>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1791815522; l=6797;
 i=emmanuel.blot@free.fr; s=20260602; h=from:subject:message-id;
 bh=MyS/xSNcSv5LSSPZg2ndQf9zSlLfmLoiztp1hbYzpOs=;
 b=xnDUphlTqyJPwfS1ABCmgzR8NLRAFXaxpNYp8MXZSigjJvc4CkVRyT/sV5eGoNiWW1ynbCYSV
 QuPbxeUXX/RBGxUdr/recPupa2F8U4Io0H+Tc5tmt6LJV3cPAwozzX3
X-Developer-Key: i=emmanuel.blot@free.fr; a=ed25519;
 pk=0qFrZ21FAAN8OfVsSoVcCFTk/NMYOWzxJz4paSAVm0g=
Received-SPF: pass client-ip=209.85.128.48; envelope-from=eblot.ml@gmail.com;
 helo=mail-wm1-f48.google.com
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
2.50.1


