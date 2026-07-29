Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ABD9BC53219
	for <qemu-devel@archiver.kernel.org>; Wed, 29 Jul 2026 15:31:42 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wp6FW-0004SN-7N; Wed, 29 Jul 2026 11:31:14 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eblot.ml@gmail.com>)
 id 1wp6FS-0004P4-DY
 for qemu-devel@nongnu.org; Wed, 29 Jul 2026 11:31:10 -0400
Received: from mail-wr1-f48.google.com ([209.85.221.48])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <eblot.ml@gmail.com>)
 id 1wp6FQ-0000EW-De
 for qemu-devel@nongnu.org; Wed, 29 Jul 2026 11:31:10 -0400
Received: by mail-wr1-f48.google.com with SMTP id
 ffacd0b85a97d-47f96c5b722so683320f8f.0
 for <qemu-devel@nongnu.org>; Wed, 29 Jul 2026 08:31:07 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1785339066; x=1785943866;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=jDYA5Xg1AcjoGqaDT6Y+c4Ycg06GuzHzyiFnFNhge4E=;
 b=tSl2P6/QNZyetkjrtbLH57HtB2lc69P6OToR/iGMBboBuzIlUxARqukUGAx8hNmVH8
 411OMswGvFfDGGq1kqyBFjmO6XPicP0bWX1WeTyO2hioZoF30HUVJ/8cActqkaJpS24M
 CXiHuC/xkugnXLMf3msK4kiEVUIs8lsvGE356nntO5gG4Nw6jcC2sMveva5ZKyUtZHD1
 odTuAb/nR7dCLKAPqroh3yeU+5L2qEOLVeEUEt2SemDReT4tfu0sy9DcO4ukK8LgR4JQ
 eXVEypa2chE0QTYGytw9LavPC/4x8MSIpMpCMUWLU7lMz3sZfT9dZ6mCVjkWbDZeQkzR
 j0uw==
X-Gm-Message-State: AOJu0YwmKYhPniVx2DFoE2eIgv+k/VmNFdg5Rjum9UkDkZaWEDSVdsrd
 b9oingcxLcqZduN6alv6GOnVATEDZXQwspBAKfrqOJkTjp/3P2qyaAceLMhArfuO
X-Gm-Gg: AR+sD1361PiimkHc+ajYe5BKPBZC7VZcISN4CLp6jK46EiikLl/s6XW+fsRG9P2aLMI
 +eROi80SgkZrRPz98CeGtRkPTKe0l8p0ZqAz2Ph6F+pYIcAyJh0n9FHqd8v8Fc4CQ3tnlpW4ECH
 P9R0D7TzKNkintmZ63XieDhU9Yoj5iLx0E6noLNN5cfVJt8r0KUVKy11N8b5Wd4+wC/lkNCy14V
 usDykYEHYoIWcbb5NvNWw1f8STtxZPBXomryhftEpIuOrjtNAqlf4RjkucYH9i8v7E5VCHamiiN
 Zp/2upUv3Y+oOz+WexsCnGpmMBHaBUFu5nlD9MYfe1K6ymzPk3B+wDWYGcp0QLHBQZNGTdg/WPt
 NzBWsdvEwujI17FPFVG2Q5wwQZIEh62Oe9JZAMMFWsluSmhOJ26f+TCG7MjgQ/LMuq/CmSdLRMN
 xUOnZNbrZukhg1YOJRtwkY/G5HyAnNyd3fYVIUco4WPrm7X12oTL1SqutIjeWDjBTYSu7new//K
 l8Pk7uG4ZjVdmVieloQzGEV/LaangNdM7ep
X-Received: by 2002:a05:6000:2505:b0:47f:93e2:a07b with SMTP id
 ffacd0b85a97d-47fb1f139bemr7833148f8f.30.1785339066052; 
 Wed, 29 Jul 2026 08:31:06 -0700 (PDT)
Received: from localhost (89-93-216-19.hfc.dyn.abo.bbox.fr. [89.93.216.19])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-47fb6b19653sm9241418f8f.30.2026.07.29.08.31.05
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 29 Jul 2026 08:31:05 -0700 (PDT)
Date: Wed, 29 Jul 2026 17:12:44 +0200
Subject: [PATCH 08/25] tests/qtest: tmp105: cover the ALERT fault queue
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260729-sanmiguel-bmc-locator-v1-8-c8f9a8d101f6@free.fr>
References: <20260729-sanmiguel-bmc-locator-v1-0-c8f9a8d101f6@free.fr>
In-Reply-To: <20260729-sanmiguel-bmc-locator-v1-0-c8f9a8d101f6@free.fr>
To: qemu-devel@nongnu.org
Cc: =?utf-8?q?Philippe_Mathieu-Daud=C3=A9?= <philmd@mailo.com>, 
 =?utf-8?q?C=C3=A9dric_Le_Goater?= <clg@kaod.org>, 
 Peter Maydell <peter.maydell@linaro.org>, 
 Steven Lee <steven_lee@aspeedtech.com>, Troy Lee <leetroy@gmail.com>, 
 Jamin Lin <jamin_lin@aspeedtech.com>, Kane Chen <kane_chen@aspeedtech.com>, 
 Andrew Jeffery <andrew@codeconstruct.com.au>, Joel Stanley <joel@jms.id.au>, 
 qemu-arm@nongnu.org, Fabiano Rosas <farosas@suse.de>, 
 Laurent Vivier <lvivier@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, 
 Thomas Huth <th.huth+qemu@posteo.eu>, 
 =?utf-8?q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>, 
 Emmanuel Blot <eblot@meta.com>, Emmanuel Blot <emmanuel.blot@free.fr>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1785337963; l=3508;
 i=emmanuel.blot@free.fr; s=20260602; h=from:subject:message-id;
 bh=STa9fNUK+ufnQgeeZ6iWhS9xfz1DLS6Eh0Aq6teT5tE=;
 b=xtY694VImiCxYAX0qVieR4ERcGUo2zzwI4PDzEuYHi94dRFnY9GdIDtdgSu+C4m6898aqkBLc
 eugd46uxI4rD6qYoFHqjM+CUOx6BFnK0KArniCyu2zO6AK9pd5BhvOC
X-Developer-Key: i=emmanuel.blot@free.fr; a=ed25519;
 pk=0qFrZ21FAAN8OfVsSoVcCFTk/NMYOWzxJz4paSAVm0g=
Received-SPF: pass client-ip=209.85.221.48; envelope-from=eblot.ml@gmail.com;
 helo=mail-wr1-f48.google.com
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

Add two qgraph tests exercising the ALERT pin, the only way the TMP105
exposes its alarm state. One checks the default single-fault behaviour;
the other checks a deeper fault queue, including the running-count reset
on an in-range conversion and its effect on both asserting and releasing
the alarm.

Signed-off-by: Emmanuel Blot <emmanuel.blot@free.fr>
---
 tests/qtest/tmp105-test.c | 63 +++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 63 insertions(+)

diff --git a/tests/qtest/tmp105-test.c b/tests/qtest/tmp105-test.c
index 3b114a50f55..29a031fb7bf 100644
--- a/tests/qtest/tmp105-test.c
+++ b/tests/qtest/tmp105-test.c
@@ -17,6 +17,11 @@
 
 #define TMP105_TEST_ID   "tmp105-test"
 #define TMP105_TEST_ADDR 0x49
+#define TMP105_TEST_PATH "/machine/peripheral/" TMP105_TEST_ID
+
+#define TMP105_CONFIG_POL   (1 << 2)   /* ALERT active-high when set */
+#define TMP105_CONFIG_FQ_1  (0 << 3)   /* fault queue: 1 consecutive fault */
+#define TMP105_CONFIG_FQ_4  (2 << 3)   /* fault queue: 4 consecutive faults */
 
 static int qmp_tmp105_get_temperature(const char *id)
 {
@@ -105,6 +110,62 @@ static void send_and_receive(void *obj, void *data, QGuestAllocator *alloc)
     g_assert_cmphex(i2c_get16(i2cdev, TMP105_REG_T_HIGH), ==, 0x4230);
 }
 
+/*
+ * The TMP105 exposes its alarm state only through the ALERT pin.
+ */
+static void test_alert_single_fault(void *obj, void *data,
+                                    QGuestAllocator *alloc)
+{
+    QI2CDevice *i2cdev = (QI2CDevice *)obj;
+
+    qtest_irq_intercept_out(global_qtest, TMP105_TEST_PATH);
+
+    i2c_set8(i2cdev, TMP105_REG_CONFIG, TMP105_CONFIG_POL | TMP105_CONFIG_FQ_1);
+    g_assert_false(get_irq(0));
+
+    qmp_tmp105_set_temperature(TMP105_TEST_ID, 85000);
+    g_assert_true(get_irq(0));
+
+    qmp_tmp105_set_temperature(TMP105_TEST_ID, 70000);
+    g_assert_false(get_irq(0));
+}
+
+static void test_fault_queue(void *obj, void *data, QGuestAllocator *alloc)
+{
+    QI2CDevice *i2cdev = (QI2CDevice *)obj;
+    int i;
+
+    qtest_irq_intercept_out(global_qtest, TMP105_TEST_PATH);
+
+    /* Comparator mode, active-high ALERT, fault queue of four. */
+    i2c_set8(i2cdev, TMP105_REG_CONFIG, TMP105_CONFIG_POL | TMP105_CONFIG_FQ_4);
+    g_assert_false(get_irq(0));
+
+    for (i = 0; i < 3; i++) {
+        qmp_tmp105_set_temperature(TMP105_TEST_ID, 85000);
+        g_assert_false(get_irq(0));
+    }
+
+    qmp_tmp105_set_temperature(TMP105_TEST_ID, 25000);
+    g_assert_false(get_irq(0));
+
+    for (i = 0; i < 3; i++) {
+        qmp_tmp105_set_temperature(TMP105_TEST_ID, 85000);
+        g_assert_false(get_irq(0));
+    }
+
+    qmp_tmp105_set_temperature(TMP105_TEST_ID, 85000);
+    g_assert_true(get_irq(0));
+
+    for (i = 0; i < 3; i++) {
+        qmp_tmp105_set_temperature(TMP105_TEST_ID, 70000);
+        g_assert_true(get_irq(0));
+    }
+
+    qmp_tmp105_set_temperature(TMP105_TEST_ID, 70000);
+    g_assert_false(get_irq(0));
+}
+
 static void tmp105_register_nodes(void)
 {
     QOSGraphEdgeOptions opts = {
@@ -116,5 +177,7 @@ static void tmp105_register_nodes(void)
     qos_node_consumes("tmp105", "i2c-bus", &opts);
 
     qos_add_test("tx-rx", "tmp105", send_and_receive, NULL);
+    qos_add_test("alert-single-fault", "tmp105", test_alert_single_fault, NULL);
+    qos_add_test("fault-queue", "tmp105", test_fault_queue, NULL);
 }
 libqos_init(tmp105_register_nodes);

-- 
2.50.1


