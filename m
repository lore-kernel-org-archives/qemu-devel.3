Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 30B0FC79FA1
	for <qemu-devel@archiver.kernel.org>; Mon,  7 Sep 2026 16:51:39 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x3cZD-0003Ep-Tb; Mon, 07 Sep 2026 12:51:35 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eblot.ml@gmail.com>)
 id 1x3cZ7-0002vK-Hk
 for qemu-devel@nongnu.org; Mon, 07 Sep 2026 12:51:31 -0400
Received: from mail-wr1-f41.google.com ([209.85.221.41])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <eblot.ml@gmail.com>)
 id 1x3cZ3-0004oD-R7
 for qemu-devel@nongnu.org; Mon, 07 Sep 2026 12:51:29 -0400
Received: by mail-wr1-f41.google.com with SMTP id
 ffacd0b85a97d-482e4998d28so2995117f8f.2
 for <qemu-devel@nongnu.org>; Mon, 07 Sep 2026 09:51:24 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1788799883; x=1789404683;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=YTjYUeqnG0FlRaXGHN4hD5QBCzdcaj4DW5tltJJmmu4=;
 b=sg4uLfnHpXLNG8urgbmo7A+INQyK5IZDJ5Q1wpBatxANkjxIjj75NkT6hOucQH79EU
 fDc4QAb4NwNJ+nNyBcm1k0EfH0EQsRpzmIlCeN+4hhvN2m70bKJcnWIdikj4xAX5z0eu
 OPRbVUeUdgqU8rS6XRPrv2Pef4k5liNJzf8dtVVXpn2VgOMKz7bYp4qtDgVNAM7p2OG3
 NDvCaG+xC7lQfOOTlIlfC3HUc0WmOKxmwMUD1Jsbz0lhw/jM/UbI1EHrcDherDNIPosx
 mtgZXX5jJ1bOMX2sjEFdOoar+giQiS/5bZO1cMwilsm3YzD6rsPQOjwFS3ny0VR/w05u
 TY9A==
X-Gm-Message-State: AFuF++n4LmlpmjAqsK4829S1KVGn5ussDvCqEHp/Psi4HtHjJpl6df7w
 ilP02KXVSy1rfDgUojOxvbQlIkC6XbRB8mnU6zliKnHoCg6Z4kQbuVYzuw82Yl4n
X-Gm-Gg: AYBFou0JTqQ0reM9OrIx3irgNEnuDWE0NAoUv4h+1XHdm7aNZ0P/rbzHYKJg85cSSr9
 Z2UN0Cm2t8onQYxbEcnFw1L18owSDlvjWvZ/sIi+dRo2xm0CG8XPhGNidWzmiDFnmmLLdvZ9M98
 9d7aXYvKeDTDEJ5WwaAdn8XVm8wKPvm18PKRh0c5b9+OJ+aNYid8cVFlV67e+fOg+e9ODomgj0Q
 6ltKJ/DJYwF38SekFt/fs9xaZ8VNHhfTb4iSIi/Vdx/McM4B88CiyxN1bZBf5Bl1JFNzor17jll
 k+18KTN7zjterCyv0TMMql68DF8OVUCXDEiuW/dpKRV3NiX3ftD0HuBcr6sskkcGXqY6M7wpwyo
 MtXyVB3Pk5+6DOaSutbY9nCXLegTJ4mGm67EMz8c8Qr03s7Tg0PAMwrmseV06Kv/oJdVSpcmI5l
 qEv+5MZHSRqvrmH1EJRsVy6q2N3k2YO6bDoK4Xx372MRR5VZ5X75gJ9v+xvZVeJemglM70FRFRY
 3kCAmhhAeKfqUUPXJv1ihVmRR+/BAalyvs=
X-Received: by 2002:a5d:4691:0:b0:484:3326:983b with SMTP id
 ffacd0b85a97d-485872eb42amr22386299f8f.26.1788799883246; 
 Mon, 07 Sep 2026 09:51:23 -0700 (PDT)
Received: from localhost (89-93-216-19.hfc.dyn.abo.bbox.fr. [89.93.216.19])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-485883c074asm28991228f8f.23.2026.09.07.09.51.22
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 07 Sep 2026 09:51:22 -0700 (PDT)
Date: Mon, 07 Sep 2026 18:42:36 +0200
Subject: [PATCH 46/50] tests/qtest: ina238: cover conversion-ready and
 alert-latch semantics
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260907-bmc-minerva-v1-46-0d83ad610c3b@free.fr>
References: <20260907-bmc-minerva-v1-0-0d83ad610c3b@free.fr>
In-Reply-To: <20260907-bmc-minerva-v1-0-0d83ad610c3b@free.fr>
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
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1788799323; l=6797;
 i=emmanuel.blot@free.fr; s=20260602; h=from:subject:message-id;
 bh=MyS/xSNcSv5LSSPZg2ndQf9zSlLfmLoiztp1hbYzpOs=;
 b=gvP8LUtkbNgevtM2ebL+KYBuUtOe9okNxHqfSUP+J9oSVnGhlUm6Tq/u77rqcFEAAuFxnLAYt
 FoBXEO566oNA9GxF0djFU+2bbwU7YpvoksL3/MRqgloVaNDDjCaHCiR
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


