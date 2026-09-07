Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 83967C79FA0
	for <qemu-devel@archiver.kernel.org>; Mon,  7 Sep 2026 16:49:39 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x3cX7-00069R-Fd; Mon, 07 Sep 2026 12:49:25 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eblot.ml@gmail.com>)
 id 1x3cX4-00061e-Uj
 for qemu-devel@nongnu.org; Mon, 07 Sep 2026 12:49:23 -0400
Received: from mail-wm1-f46.google.com ([209.85.128.46])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <eblot.ml@gmail.com>)
 id 1x3cX2-00048n-GO
 for qemu-devel@nongnu.org; Mon, 07 Sep 2026 12:49:22 -0400
Received: by mail-wm1-f46.google.com with SMTP id
 5b1f17b1804b1-49b8e527d63so44685865e9.2
 for <qemu-devel@nongnu.org>; Mon, 07 Sep 2026 09:49:20 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1788799759; x=1789404559;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=MZwOnu4u3mbwMqdzuk9WWRV5vzGX0PpwyIdVH5RHZDU=;
 b=J8PVCiYin2VY11UWZxV1Vss+ZuZOJq4ZXYd12vRqeq5cVd/+3qcbue3SACvgEItMI8
 DbRCRwj/5z2OhGCGy++Kp9OxTnBsWaVC4T937zeWTWaMINR0GuFx+tv2Qo6qJpOH6ajI
 /mbeDECzATlCSigI26SMDKbqMbhQP3JWbJb8VNUXd7/tx2QgWjFxEUQ1QfGNnNAWi2mu
 rUEPl9xfS4W5/LIN411b8r6zteSau6XCV0+MEKyVNcZoz0Gi6iPSOiqLfYVePF1uBmTM
 8SRUaKXgDfIV1EzDIoK8zhSrGgIusDvcoSwGGvuR8+LPGAT2ICtAei2thlhI5IEZfr0p
 7hkw==
X-Gm-Message-State: AFuF++nzPYt1uLkAT80dLK1JRNlPicIA/HUnnYfk+NgwuIa2GZr8FUqL
 qkePkFjhFYy3HOGUr5kQLa4pqDfeLL9qhJHxKTiyN6VGiHvqQIX+Pu5v9CI7kmUU
X-Gm-Gg: AYBFou3PR0ExKIAILhfZ9eIsvS3Be8L7heh/Fld5Gm98zFe5nmW3oRdwH5+EAAgtYmM
 UBVR660z6LWyyxCAkvgxiZqbMfVsLssZKOCPMXz3nJ8f7j375RsySfcgdDhyrH1k3TCmQPIfIYG
 gfkdymTZrWJlpROULN2w08wPQMEMJI8fwwdrlyFffVM3MvT29v1cZ6MCLXiYYGlOB6BqxjmD9F+
 Hk9cygBhsjNgih9YVQPHphQ8UCQ+YHpOZMnPOyXOqw1ja0BV0sOutnpilcBVXG23jYbTdfrVFBQ
 5aYP+vLT4Rk9EJvWzdboWhJtNA18mPHZSivrlkj7OCdD29MM+d73cmz+aF9wWwY88OTF52fD3d0
 R1a9Qw81idt5juY8RvtcAJcJspbwEj4SL5gIZGInGw9ROiPy5USh4W04jmYe/FNLZdWhgL/0p6h
 AozdQepk0ss3kI0am1x95kuyYZUrgF5hQG0WNuM9nbT6ejSJ0IWFj8iNG9L3ct9jzERKAaSCok5
 uT8PyXAclJw4vmwnvZsQYRwnn85UmBjf4RJchgOIDVcFQ==
X-Received: by 2002:a05:600c:1da8:b0:49c:cf18:494e with SMTP id
 5b1f17b1804b1-49cf825a530mr284573165e9.12.1788799758881; 
 Mon, 07 Sep 2026 09:49:18 -0700 (PDT)
Received: from localhost (89-93-216-19.hfc.dyn.abo.bbox.fr. [89.93.216.19])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-49cff8195ffsm269860585e9.14.2026.09.07.09.49.18
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 07 Sep 2026 09:49:18 -0700 (PDT)
Date: Mon, 07 Sep 2026 18:42:25 +0200
Subject: [PATCH 35/50] tests/qtest: ina230: cover the ALERT limit functions
 and CVRF
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260907-bmc-minerva-v1-35-0d83ad610c3b@free.fr>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1788799322; l=4599;
 i=emmanuel.blot@free.fr; s=20260602; h=from:subject:message-id;
 bh=g1WQNWNWvejsNUmKknPzwDjtl/zzqUIEuhP5ANmhVl4=;
 b=tUBf2HfFmowEQjPjIIQYDcvcY8arjZ+mEQt4LiRsrw0Uk90DyAHpWcXS8BpmEM0TE5JoIRsyR
 P3su0cibwWhBC6ooPytgNBdFWYreqiBDms0Q1Esag2fFOKkV9e2FTro
X-Developer-Key: i=emmanuel.blot@free.fr; a=ed25519;
 pk=0qFrZ21FAAN8OfVsSoVcCFTk/NMYOWzxJz4paSAVm0g=
Received-SPF: pass client-ip=209.85.128.46; envelope-from=eblot.ml@gmail.com;
 helo=mail-wm1-f46.google.com
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
2.50.1


