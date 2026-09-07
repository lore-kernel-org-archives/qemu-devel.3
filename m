Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EE1A7C79FA7
	for <qemu-devel@archiver.kernel.org>; Mon,  7 Sep 2026 16:51:51 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x3cZA-00032W-Ul; Mon, 07 Sep 2026 12:51:33 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eblot.ml@gmail.com>)
 id 1x3cYu-0002nE-Pu
 for qemu-devel@nongnu.org; Mon, 07 Sep 2026 12:51:19 -0400
Received: from mail-wm1-f50.google.com ([209.85.128.50])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <eblot.ml@gmail.com>)
 id 1x3cYr-0004n0-Nc
 for qemu-devel@nongnu.org; Mon, 07 Sep 2026 12:51:16 -0400
Received: by mail-wm1-f50.google.com with SMTP id
 5b1f17b1804b1-49b9320423cso42490005e9.0
 for <qemu-devel@nongnu.org>; Mon, 07 Sep 2026 09:51:13 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1788799872; x=1789404672;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=RR0BfuP3zH0vPwsVTweTuUz+ywrZng5C/2ivP+6b+uc=;
 b=o32J6P/7Z+MoT7UfAOUaU18me+kVm5cMfL/Xkq4ivMbsLiXllBQJ69NfB8BFNaajpz
 if/baRWOzaUHAxQVgkwJTrgPx43fFr1h1jNKI+QJdKetQ76Ph8V/UPfM3wmbQs9tElRi
 Rp115gycvt9ultJ0EBdE24uNlxlkWjyV3Faz4nRdP0d5ooJIITTvtzlqtI5PgRSx5z31
 moDYitni+HotcnD3TlUd6g5kBTvgZnQve6s5RdpJyfYnjt5f10wUnW3eLN3pNQU058BU
 NP1Q/xbmHv5SZKOfq/VR7hl+Lu7s3o0SlcZ4i9gMtm7EcvRYYPpAF6C4+xqKpDXWkI9g
 pAiA==
X-Gm-Message-State: AFuF++lwvNTS6+JrmIrKBZ5LFeZecOhmChterxPFH/bmbC9rWWpAQl/p
 hOCKWbgt/a4+tjWNkilPYbsvUXXWn8EObokIEnO9xC/VZA1acQXNf/9vgLPqLh+B
X-Gm-Gg: AYBFou04vd+GAq/LSy4KxJObCQv9Zpnbixsqa0rlTgtBs0VP6GHtKGSXk8n7yUwOWTd
 NoieM/to6FPIG0mIGq4j7ZpI8WDdidAr3ZZ8saaLnJVqxwGNP675eejV/S5MMtZl713hbeT1F5Z
 tXm2PROXHXPet1WquljCZoUTUwtHszPqultJP+9ePPzmiMXh3r7HYJH6jg/sbnRto88N7uy2tqa
 YUWP4iyaEh+d0OLLDBwMzFMRVIrtTGzxd2+gMe+Wcz0F0uKVYwgjpBscBJ3WVL9ap4CmAkW8LXH
 nJUiSyJPzlES/SYnnM25BXNT7W59lyTLzC6W9qF6+Ubek7FU46UQcw+leEpzVkn68fgjE2XY3ZA
 cgCHotU0dL83GEhvwkB54q0Tu21RmsVL2D88A2D4wLa4KSlSGzPAOnexk3LOkH/bllMQwNKpSUI
 BH8Kbiq+TDa0uddA9iD/1k33EtNa9q4ea0Qm3SCXvRzCQsXKEzwiHWrJUXg9p4DqYEup4DF+9bm
 LCPc3MpW+w+bcZ/6X1cJap25UOKopx+62ZIVds0txFQtw==
X-Received: by 2002:a05:600c:6306:b0:49c:f5c0:aa76 with SMTP id
 5b1f17b1804b1-49cf81e366amr585455995e9.5.1788799872044; 
 Mon, 07 Sep 2026 09:51:12 -0700 (PDT)
Received: from localhost (89-93-216-19.hfc.dyn.abo.bbox.fr. [89.93.216.19])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-49cff8195ffsm269970415e9.14.2026.09.07.09.51.11
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 07 Sep 2026 09:51:11 -0700 (PDT)
Date: Mon, 07 Sep 2026 18:42:35 +0200
Subject: [PATCH 45/50] tests/qtest: ina238: cover the operating modes
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260907-bmc-minerva-v1-45-0d83ad610c3b@free.fr>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1788799323; l=4308;
 i=emmanuel.blot@free.fr; s=20260602; h=from:subject:message-id;
 bh=lzxHz2iTzcTzaY4NX8qYKf/WE7cfp3wqr3BkHmJe9dY=;
 b=1RzTCsOE0t6uStkKjl1WTxt5fZYdByATy0W6tYxQbJIghBnxFA+je62n4cs3cC3Avh5Ktu76l
 aJvz9mtokUBCQ/Oma5f4IoGYpSQqeI6u9xJEEaqQn4ufvofrihRtnsS
X-Developer-Key: i=emmanuel.blot@free.fr; a=ed25519;
 pk=0qFrZ21FAAN8OfVsSoVcCFTk/NMYOWzxJz4paSAVm0g=
Received-SPF: pass client-ip=209.85.128.50; envelope-from=eblot.ml@gmail.com;
 helo=mail-wm1-f50.google.com
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

Add coverage for the ADC_CONFIG MODE field: shutdown modes perform no
conversion and leave the measurement registers and CNVRF untouched,
triggered modes convert once per ADC_CONFIG write, and continuous
channel-select modes refresh only the enabled measurement registers.

Signed-off-by: Emmanuel Blot <emmanuel.blot@free.fr>
---
 tests/qtest/ina238-test.c | 70 +++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 70 insertions(+)

diff --git a/tests/qtest/ina238-test.c b/tests/qtest/ina238-test.c
index 74912424c0..fb7bcc265c 100644
--- a/tests/qtest/ina238-test.c
+++ b/tests/qtest/ina238-test.c
@@ -304,6 +304,73 @@ static void test_adcrange(void *obj, void *data, QGuestAllocator *alloc)
     g_assert_cmphex(i2c_get16(dev, REG_CURRENT), ==, 0x1F40);
 }
 
+/* Shutdown converts nothing: registers are held, CNVRF stays clear. */
+static void test_mode_shutdown(void *obj, void *data, QGuestAllocator *alloc)
+{
+    QI2CDevice *dev = (QI2CDevice *)obj;
+
+    i2c_set16(dev, REG_CONFIG, CONFIG_RST);
+    i2c_set16(dev, REG_SHUNT_CAL, 0x1000);
+    qmp_ina238_set("shunt-voltage", 20000000);
+    qmp_ina238_set("bus-voltage", 12000000);
+    g_assert_cmphex(i2c_get16(dev, REG_VSHUNT), ==, 0x0FA0);
+    g_assert_cmphex(i2c_get16(dev, REG_VBUS), ==, 0x0F00);
+
+    /* Clear CNVRF, then enter shutdown (MODE = 0). */
+    (void)i2c_get16(dev, REG_DIAG_ALRT);
+    i2c_set16(dev, REG_ADC_CONFIG, 0x0000);
+
+    /* Injecting while shut down performs no conversion: registers are held. */
+    qmp_ina238_set("shunt-voltage", 40000000);
+    qmp_ina238_set("bus-voltage", 24000000);
+    g_assert_cmphex(i2c_get16(dev, REG_VSHUNT), ==, 0x0FA0);
+    g_assert_cmphex(i2c_get16(dev, REG_VBUS), ==, 0x0F00);
+
+    /* No conversion completed, so CNVRF stays clear. */
+    g_assert_cmphex(i2c_get16(dev, REG_DIAG_ALRT) & DIAG_CNVRF, ==, 0);
+}
+
+/* Triggered modes convert once per ADC_CONFIG write. */
+static void test_mode_triggered(void *obj, void *data, QGuestAllocator *alloc)
+{
+    QI2CDevice *dev = (QI2CDevice *)obj;
+
+    i2c_set16(dev, REG_CONFIG, CONFIG_RST);
+    i2c_set16(dev, REG_SHUNT_CAL, 0x1000);
+    qmp_ina238_set("shunt-voltage", 20000000);
+
+    /* Enter triggered bus+shunt+temp mode: one conversion. */
+    i2c_set16(dev, REG_ADC_CONFIG, 0x7000);
+    g_assert_cmphex(i2c_get16(dev, REG_VSHUNT), ==, 0x0FA0);
+
+    /* A new input does not convert until the next trigger. */
+    qmp_ina238_set("shunt-voltage", 40000000);
+    g_assert_cmphex(i2c_get16(dev, REG_VSHUNT), ==, 0x0FA0);
+
+    /* Re-triggering with another ADC_CONFIG write samples the new input. */
+    i2c_set16(dev, REG_ADC_CONFIG, 0x7000);
+    g_assert_cmphex(i2c_get16(dev, REG_VSHUNT), ==, 0x1F40);
+}
+
+/* A bus-only mode refreshes the bus register alone; the rest are held. */
+static void test_mode_channels(void *obj, void *data, QGuestAllocator *alloc)
+{
+    QI2CDevice *dev = (QI2CDevice *)obj;
+
+    i2c_set16(dev, REG_CONFIG, CONFIG_RST);
+    i2c_set16(dev, REG_SHUNT_CAL, 0x1000);
+    qmp_ina238_set("shunt-voltage", 20000000);
+    qmp_ina238_set("bus-voltage", 12000000);
+
+    /* Continuous bus-only mode. */
+    i2c_set16(dev, REG_ADC_CONFIG, 0x9000);
+    qmp_ina238_set("shunt-voltage", 40000000);
+    qmp_ina238_set("bus-voltage", 24000000);
+
+    g_assert_cmphex(i2c_get16(dev, REG_VSHUNT), ==, 0x0FA0);
+    g_assert_cmphex(i2c_get16(dev, REG_VBUS), ==, 0x1E00);
+}
+
 /* Clamping at full scale and the MATHOF flag */
 static void test_overflow(void *obj, void *data, QGuestAllocator *alloc)
 {
@@ -548,6 +615,9 @@ static void ina238_register_nodes(void)
     qos_add_test("power", "ina238", test_power, NULL);
     qos_add_test("zero-cal", "ina238", test_zero_cal, NULL);
     qos_add_test("adcrange", "ina238", test_adcrange, NULL);
+    qos_add_test("mode-shutdown", "ina238", test_mode_shutdown, NULL);
+    qos_add_test("mode-triggered", "ina238", test_mode_triggered, NULL);
+    qos_add_test("mode-channels", "ina238", test_mode_channels, NULL);
     qos_add_test("overflow", "ina238", test_overflow, NULL);
     qos_add_test("alert-shunt", "ina238", test_alert_shunt, NULL);
     qos_add_test("alert-bus", "ina238", test_alert_bus, NULL);

-- 
2.50.1


