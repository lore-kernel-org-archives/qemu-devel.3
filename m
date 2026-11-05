Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 32D89606A31B
	for <qemu-devel@archiver.kernel.org>; Thu,  5 Nov 2026 09:16:21 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xOtYI-0005a8-7l; Thu, 05 Nov 2026 04:14:34 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eblot.ml@gmail.com>)
 id 1xOtXu-00057q-Di
 for qemu-devel@nongnu.org; Thu, 05 Nov 2026 04:14:13 -0500
Received: from mail-pl1-f169.google.com ([209.85.214.169])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <eblot.ml@gmail.com>)
 id 1xOtXr-0005RF-Hv
 for qemu-devel@nongnu.org; Thu, 05 Nov 2026 04:14:09 -0500
Received: by mail-pl1-f169.google.com with SMTP id
 d9443c01a7336-2e946155442so14223955ad.3
 for <qemu-devel@nongnu.org>; Thu, 05 Nov 2026 01:14:07 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793870045; x=1794474845;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=DeiJYZqRfQOfLFJzRerKdRRjmQabvVc3EFQMHa8VS4A=;
 b=tKZdBP/yRQFqH4Givc45z30gHE71N30qR6haQfiZ58blizGh2rknML9E2oJocVjEcf
 4+81kqibLG8nLbkl6loNa5sri3fIEvGzfWetYgwmcDJf9bl42iKNKZ7eWJarfER4rn8R
 KNJ1UqEOm62+FiZW7IYOwUvB1JhlfyZih1hEb8s10dzbikvohyQsAIv8fuCwduswEqOf
 aC4jEA3ELN17RvZCexR4jnIqrOtsthpK/5jhaNRCwoFKzo1C7ruldqE/WRAJrmDl+LkH
 Cn6t+ieFz3DzgZGp3FxN4dPivbRgXY9/kw48ckIZf5Mh4SaItP2cNPe3vCOWFMLsnFy6
 pzVg==
X-Gm-Message-State: APuU4Z9C5nFMvtpN/5zPngUG/pyV4vAQJ94ARRLZb+39/zqqs2I2GbJV
 Df6O1UFi++S77JP7Sw/lJkPl0DkYhwxerm7QioH9lTeYs2/6c/cNJtoYg/Qnc6P9GGs=
X-Gm-Gg: AYBFou00obMM9MPpfwu389jCCR9U7nyZuAeFIKUfOs18peoHz3Zp5D/9J91ZUJ2QUJp
 hYEGG3VWJlU7WnJq7kBtdgz/eZWA8cMKXHJ7L3NPtySJAJEdXMLzooX8ERq+WAhp1FdLclmd3cx
 TBb+l9wVMPw1t6LvJAoK9s5CIPSDVAsDMThOedH48jQ3ZMH/IwvzdVyktP9n1mhwfnbFFLxohgy
 8jFGR3OEO9fQ5hcq3Vo9irfuPwW5y9TtUHncii/IT+875qMB2vdXwScoztFNVTRxjuu08XF1lqo
 HMC3MCO0WaMRbCDyuypPkptKxCRGd3gQbj0uOoIAQ/zA9xPdSVQy7bdm8Z3bDzLZcbt6/ZtrR/v
 /Z2RhNUVaM50vjheJWpBebsemnt0lDQIdciPD9YNkIu04r6LiQF4St9oQTCctx2Iaeq/KxWuXVT
 G+PtdxKLkdsf6OvkRMb/GjqgZqy4F7ODWdiyt+WnX+W7Ol4PudYP7NID1O6kf/WNsedlfg7i/To
 HG6LX58WSIoquHl/rGiwkGoXIFWo3trLgX0DoFuFZz6THCaB6e5wdjjFUZMqNBya3k4AwdlencV
 0hcW1DVp6k08QsyzYusP6TqrK3d5o4BwV8Wu2bAXafrTQpqf1X/8FN3rl16gOcuEtsip9Wqkuco
 z3ewxWA==
X-Received: by 2002:a17:902:ce8a:b0:2d7:107c:917b with SMTP id
 d9443c01a7336-2eb36332024mr176198365ad.0.1793870045573; 
 Thu, 05 Nov 2026 01:14:05 -0800 (PST)
Received: from localhost (118-163-122-149.hinet-ip.hinet.net.
 [118.163.122.149]) by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2ed0908587dsm14858935ad.36.2026.11.05.01.14.04
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 05 Nov 2026 01:14:05 -0800 (PST)
Date: Thu, 05 Nov 2026 17:12:56 +0800
Subject: [PATCH 04/16] tests/qtest: ina230: cover the ALERT limit functions
 and CVRF
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261105-sensor-ina23x-v1-4-5433ed104990@free.fr>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1793869975; l=4653;
 i=emmanuel.blot@free.fr; s=20260602; h=from:subject:message-id;
 bh=yU/ASNKVFYSLSDsLa8e4k+jfJS9UQPvsF84TMUUNANI=;
 b=4tOjud+fCdbZb4WevjO1TSXlTh+gTknSjTeQwMzztSEgjPgyy2Ty1ih0TmligVbQvB3UegSiL
 Q1uyiyY1jvWC+DkCOqV2k5RExk7ZUB6qW8B0WDal7PWEHF5SGikwhsV
X-Developer-Key: i=emmanuel.blot@free.fr; a=ed25519;
 pk=0qFrZ21FAAN8OfVsSoVcCFTk/NMYOWzxJz4paSAVm0g=
Received-SPF: pass client-ip=209.85.214.169; envelope-from=eblot.ml@gmail.com;
 helo=mail-pl1-f169.google.com
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


