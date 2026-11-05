Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 476E3606A31B
	for <qemu-devel@archiver.kernel.org>; Thu,  5 Nov 2026 09:16:46 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xOtZd-0000TM-90; Thu, 05 Nov 2026 04:15:57 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eblot.ml@gmail.com>)
 id 1xOtZH-00070M-9d
 for qemu-devel@nongnu.org; Thu, 05 Nov 2026 04:15:35 -0500
Received: from mail-pj1-f41.google.com ([209.85.216.41])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <eblot.ml@gmail.com>)
 id 1xOtZF-0005l2-Ax
 for qemu-devel@nongnu.org; Thu, 05 Nov 2026 04:15:35 -0500
Received: by mail-pj1-f41.google.com with SMTP id
 98e67ed59e1d1-3ac77270fbfso995737a91.2
 for <qemu-devel@nongnu.org>; Thu, 05 Nov 2026 01:15:32 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793870132; x=1794474932;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=c6Lwpzu4bQyFqEheBTwdIlkXZjUIiiE3va3aldXb5fM=;
 b=fz01NeGpppjTgt3jOp4LxNY5QuKDjlybC+6khg1hWz7DcjO4oqW8hm7dDxoltgLw0N
 SoYON+SZS9EddR8S1ITkXxUnCzfPYeAs0rOeX09Cj+rWTT2SquA6R+MzZVN0OIj1zoQH
 BGcq9aBJe5rig4oLisMcik55qmLM+zfeO+dgowYXDTZyMyVNR8WD89yGcU9/zhzhU/Xo
 R7qpWkXLVhxSI5RN5cHgJFzo+Rs5ku+za6teaXLj4jGjghn8THbMTTo36d3lGBJ1vfh4
 x/k0QR/2sfz+jriVIWvJjWDiXh/GQdgKjgzDIVc9WMv6+HZB/h2C838j6u8MaeroeKX+
 f7wQ==
X-Gm-Message-State: APuU4Z92y9qJy5yVkQmyJXCDrrWLLcEWBc1zQ+koxwAY04O2V250XDvi
 S5/boUMK7IriWsPIV4DXZchbZCt7rbAEv7YApepg3ypzZDC3Lu2GaWLD2uI6U+meIqE=
X-Gm-Gg: AYBFou3JKE+mLGnYZhyuAduk19G8GynmPAJ1DzkPszC8/EMERiKW9NYzuDsLSmBAxbe
 wPM+OLacDDXTDXqLgRX8D+osBjhGXRP8diA/9yHn2nREI0TkW7sr6tMAozCAXJ6ucx1sUFG8xRu
 F1eEpx0hgYMwVg/fdyA47mRRkMV7MC/QmsRZQvvDYl1Q9aDFzL9l8zi+Cc1gKkXDlDukivmBFFt
 OpGHR7TT1xmSYyJdoWogBXkTRMO4P/upqMfFQ4TZe66XN9HFukmW9pgpV/asHn3vTcSwwHLBdNf
 iFK56NIatTO6dz6vnafaEh08T7wwQ5oAOuTgurGAva3i+VuE/scHVrr10oBf9ef+JrQ8WUKQXDw
 UwgTEBocsv3xKXKXT1grRsRZjA3Cm647hS9Bff0UjTULmfmoPsztIS3TBWBB/eYQo3j8roNPPE1
 wrbIcLDMObPfWQz4ORHzc0YcN14Mbu2tKW8VObYafY3txf53Y2640N7+fJfjEGA1TDpeS/03KPz
 Mwu1bmQR0xtvyOFPomga5Auzn3Br/6dAEtvzWuDS5r07A1RFbb6pTl+e6SPHfG0XAI4XV5t+vjk
 oqFa+PUHE2vB24C9q3KVF+z1e5PZTuLjx50hhxbfreZDTe1ZGj6UYKC77hsjvnIr55NAAFTv2qm
 nnvcqGg==
X-Received: by 2002:a17:90b:4c52:b0:3b0:a4d1:6d7a with SMTP id
 98e67ed59e1d1-3b0a4d1700dmr2760498a91.31.1793870131570; 
 Thu, 05 Nov 2026 01:15:31 -0800 (PST)
Received: from localhost (118-163-122-149.hinet-ip.hinet.net.
 [118.163.122.149]) by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-3b0969cf5d7sm3795244a91.3.2026.11.05.01.15.30
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 05 Nov 2026 01:15:30 -0800 (PST)
Date: Thu, 05 Nov 2026 17:13:07 +0800
Subject: [PATCH 15/16] tests/qtest: ina238: cover conversion-ready and
 alert-latch semantics
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261105-sensor-ina23x-v1-15-5433ed104990@free.fr>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1793869976; l=6851;
 i=emmanuel.blot@free.fr; s=20260602; h=from:subject:message-id;
 bh=RdMmfGACFu+w8i2ytQE/+wzOyY16K5WkLJ6oJOceA5s=;
 b=o5X3mJFRnFExcSirkSOkdRfGWzm6q/3xm9gKiBAmWgWKPFvUxfHYtSFDsCIiY64jUjkqFAlks
 Cxd5hC4j/cBCHt8AjC2kRFUOcItsF3UeYgR39J10GUdnRWkLGY083tU
X-Developer-Key: i=emmanuel.blot@free.fr; a=ed25519;
 pk=0qFrZ21FAAN8OfVsSoVcCFTk/NMYOWzxJz4paSAVm0g=
Received-SPF: pass client-ip=209.85.216.41; envelope-from=eblot.ml@gmail.com;
 helo=mail-pj1-f41.google.com
X-Spam_score_int: -15
X-Spam_score: -1.6
X-Spam_bar: -
X-Spam_report: (-1.6 / 5.0 requ) BAYES_00=-1.9,
 FREEMAIL_FORGED_FROMDOMAIN=0.001, FREEMAIL_FROM=0.001,
 HEADER_FROM_DIFFERENT_DOMAINS=0.249, RCVD_IN_DNSWL_NONE=-0.0001,
 RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001, SPF_HELO_NONE=0.001,
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


