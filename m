Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AA4D4C54F54
	for <qemu-devel@archiver.kernel.org>; Fri, 31 Jul 2026 12:34:45 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wpmRJ-0006oJ-K1; Fri, 31 Jul 2026 08:34:13 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eblot.ml@gmail.com>)
 id 1wpmRF-0006k9-HQ
 for qemu-devel@nongnu.org; Fri, 31 Jul 2026 08:34:09 -0400
Received: from mail-wr1-f50.google.com ([209.85.221.50])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <eblot.ml@gmail.com>)
 id 1wpmRD-0000gZ-UE
 for qemu-devel@nongnu.org; Fri, 31 Jul 2026 08:34:09 -0400
Received: by mail-wr1-f50.google.com with SMTP id
 ffacd0b85a97d-47f84023916so960913f8f.3
 for <qemu-devel@nongnu.org>; Fri, 31 Jul 2026 05:34:07 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1785501246; x=1786106046;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=ifMbamIfJSoLu7/f73249giIpMXwm2cmTQROI/W8L9A=;
 b=HJTDnfdGoCvFU2sZkErr3V0YK1ISz+8bkwrRSDUKjl5LT5833KcsE3QOeZKW4qaQ1P
 IcPuIvnwig5JMRRG899x7EkjCz9aHlXRnCUccXjJby1jGU3xk3RMk1VLfEJMocFJGVi1
 lUguOCqKrPTHWa43pHhMPEzAKxI6r89xRo+qF0jzIl5VLJc0kDEXAJ7dDZ596LWPr82a
 f982ZrkgwElYdJzWzKe4eGC92MNgDO4YYblDyj7OyEDYu3KgQP2yWrpi3iUc0T2zWniL
 pwco4rtoyXPayfZiUy1jaRmmttnnao8k0ZJcrWLMwNWLIs0vdZbCAmLRdZKb5MP2HYPp
 zjEg==
X-Gm-Message-State: AOJu0Yx1t4yf8w9uwLI8nErJlScxtvBGAdWOlmCTEYLh9aOYg1K7hoGm
 hRawStzq4i0fuXqKdkwVqZIwXd3Q2tvmP5m058b+xpn/snPGG+x+3YQ6NONJBkHh
X-Gm-Gg: AR+sD12QWJIu8WPcN/wnI2K39aYLSe0Y44QNTHCHKBA5rHIHXzAZDY13eZrad9r+8rV
 TYeOxiXkSRIySopaFa+6kDmYKXwOuVtjrjk4MMHAYVFjiCjyCrHp/+kB75r0uuaHjToXqDSVz/K
 /wDjKG/MKR47wvtTV2/U7LFLg8AGn2VE5FvVjJpTG2JA3LP6IpEZQuSjgel4PGiozYddJPukVOI
 pGngV1KjqZD4sJhDdvyc4/gx/Blg1/eLXyK1V7CaKPRhY3mhVgDQXW01HAzCFt6Ngos2spHVlXT
 YVkquLt6ETvUu9RkjSJej+z0Y7XlMzoLSknv9HTZw+TG0sn9L+27cjCVF8EbFNZAnkxA6/JgFrQ
 cfPSCTuwk8LrKrAj2d4QueR4euuvhZWcEY3z/6a0dnGILnzT/VJpOE/u+p9AVua1g1dTn/+9IzQ
 0yIyw5vk6OOZtwqBSIgzp0pbwu0d8bo1vKazke1aDNJ69Kp1z4PPGf7BnydGm1Cx8U/pIYTCGwH
 fMM5B+TL+Z6pWS5tmfwEEgpIUgGwsZUr3aNZ1U0m9cGNZA=
X-Received: by 2002:a05:6000:385:b0:47f:d0fb:ea40 with SMTP id
 ffacd0b85a97d-47fd2add54fmr4435535f8f.21.1785501246321; 
 Fri, 31 Jul 2026 05:34:06 -0700 (PDT)
Received: from localhost (89-93-216-19.hfc.dyn.abo.bbox.fr. [89.93.216.19])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-47fd41e2abbsm4345519f8f.9.2026.07.31.05.34.05
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 31 Jul 2026 05:34:05 -0700 (PDT)
Date: Fri, 31 Jul 2026 12:45:09 +0200
Subject: [PATCH v2 10/25] tests/qtest: tmp105: cover one-shot and
 fault-queue write immunity
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20260731-sanmiguel-bmc-locator-v2-10-1266926ba769@free.fr>
References: <20260731-sanmiguel-bmc-locator-v2-0-1266926ba769@free.fr>
In-Reply-To: <20260731-sanmiguel-bmc-locator-v2-0-1266926ba769@free.fr>
To: qemu-devel@nongnu.org
Cc: =?utf-8?q?Philippe_Mathieu-Daud=C3=A9?= <philmd@mailo.com>, 
 =?utf-8?q?C=C3=A9dric_Le_Goater?= <clg@kaod.org>, 
 Peter Maydell <peter.maydell@linaro.org>, 
 Steven Lee <steven_lee@aspeedtech.com>, 
 Jamin Lin <jamin_lin@aspeedtech.com>, Kane Chen <kane_chen@aspeedtech.com>, 
 Andrew Jeffery <andrew@codeconstruct.com.au>, Joel Stanley <joel@jms.id.au>, 
 qemu-arm@nongnu.org, Fabiano Rosas <farosas@suse.de>, 
 Laurent Vivier <lvivier@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, 
 Thomas Huth <th.huth+qemu@posteo.eu>, 
 =?utf-8?q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>, 
 Emmanuel Blot <eblot@meta.com>, Emmanuel Blot <emmanuel.blot@free.fr>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1785494708; l=5455;
 i=emmanuel.blot@free.fr; s=20260602; h=from:subject:message-id;
 bh=bmmLFTJHN8a4jRPifYNuZA58n5LYCH8vK49esOFrf4o=;
 b=VE3J4rAQZ+CX0YQwXuO1U0Zal5PI/MwDee/JsD7ayPXRzONhWAnQ4vwX4mWjT68c3zYjA8cKh
 TZMN6n8H2Q4B6WBMemkfhcmo5udauNlNT0sB/sH0hUC7hUH0SeHwWBN
X-Developer-Key: i=emmanuel.blot@free.fr; a=ed25519;
 pk=0qFrZ21FAAN8OfVsSoVcCFTk/NMYOWzxJz4paSAVm0g=
Received-SPF: pass client-ip=209.85.221.50; envelope-from=eblot.ml@gmail.com;
 helo=mail-wr1-f50.google.com
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

Verify that the one-shot (OS) bit triggers a conversion only in shutdown
mode and is ignored in continuous mode, and that
configuration/limit-register writes never advance the fault queue — only
real conversions do.

Signed-off-by: Emmanuel Blot <emmanuel.blot@free.fr>
---
 tests/qtest/tmp105-test.c | 102 ++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 102 insertions(+)

diff --git a/tests/qtest/tmp105-test.c b/tests/qtest/tmp105-test.c
index ea6803715a..e586a634d8 100644
--- a/tests/qtest/tmp105-test.c
+++ b/tests/qtest/tmp105-test.c
@@ -33,6 +33,8 @@
 #define TMP105_CONFIG_FQ_1  (0 << 3)   /* fault queue: 1 consecutive fault */
 #define TMP105_CONFIG_FQ_4  (2 << 3)   /* fault queue: 4 consecutive faults */
 #define TMP105_CONFIG_FQ(f) ((f) << 3) /* raw F1:F0 fault-queue field value */
+#define TMP105_CONFIG_SD    (1 << 0)   /* shutdown mode */
+#define TMP105_CONFIG_OS    (1 << 7)   /* one-shot conversion */
 
 static int qmp_tmp105_get_temperature(const char *id)
 {
@@ -200,6 +202,102 @@ static void check_fault_queue(QI2CDevice *i2cdev, const char *id,
     g_assert_true(get_irq(0));
 }
 
+/*
+ * The one-shot (OS) bit starts a conversion only in shutdown mode. In
+ * continuous mode it is ignored, so writing it must not advance the fault
+ * queue; in shutdown each OS write performs one conversion that does.
+ */
+static void test_one_shot(void *obj, void *data, QGuestAllocator *alloc)
+{
+    QI2CDevice *i2cdev = (QI2CDevice *)obj;
+    int i;
+
+    qtest_irq_intercept_out(global_qtest, TMP105_TEST_PATH);
+
+    i2c_set8(i2cdev, TMP105_REG_CONFIG, TMP105_CONFIG_POL | TMP105_CONFIG_FQ_4);
+    qmp_tmp105_set_temperature(TMP105_TEST_ID, 85000);
+    g_assert_false(get_irq(0));
+
+    for (i = 0; i < 8; i++) {
+        i2c_set8(i2cdev, TMP105_REG_CONFIG,
+                 TMP105_CONFIG_POL | TMP105_CONFIG_FQ_4 | TMP105_CONFIG_OS);
+        g_assert_false(get_irq(0));
+    }
+
+    i2c_set8(i2cdev, TMP105_REG_CONFIG,
+             TMP105_CONFIG_POL | TMP105_CONFIG_FQ_4 | TMP105_CONFIG_SD);
+    for (i = 0; i < 2; i++) {
+        i2c_set8(i2cdev, TMP105_REG_CONFIG, TMP105_CONFIG_POL |
+                 TMP105_CONFIG_FQ_4 | TMP105_CONFIG_SD | TMP105_CONFIG_OS);
+        g_assert_false(get_irq(0));
+    }
+    i2c_set8(i2cdev, TMP105_REG_CONFIG, TMP105_CONFIG_POL |
+             TMP105_CONFIG_FQ_4 | TMP105_CONFIG_SD | TMP105_CONFIG_OS);
+    g_assert_true(get_irq(0));
+}
+
+/*
+ * Configuration and limit-register writes are not conversions and must not
+ * advance the fault queue.
+ */
+static void test_fault_queue_ignores_writes(void *obj, void *data,
+                                            QGuestAllocator *alloc)
+{
+    QI2CDevice *i2cdev = (QI2CDevice *)obj;
+    int i;
+
+    qtest_irq_intercept_out(global_qtest, TMP105_TEST_PATH);
+
+    i2c_set8(i2cdev, TMP105_REG_CONFIG, TMP105_CONFIG_POL | TMP105_CONFIG_FQ_4);
+    g_assert_false(get_irq(0));
+
+    qmp_tmp105_set_temperature(TMP105_TEST_ID, 85000);
+    g_assert_false(get_irq(0));
+
+    for (i = 0; i < 8; i++) {
+        i2c_set8(i2cdev, TMP105_REG_CONFIG,
+                 TMP105_CONFIG_POL | TMP105_CONFIG_FQ_4);
+        i2c_set16(i2cdev, TMP105_REG_T_HIGH, 0x5000);
+        i2c_set16(i2cdev, TMP105_REG_T_LOW, 0x4b00);
+        g_assert_false(get_irq(0));
+    }
+
+    for (i = 0; i < 2; i++) {
+        qmp_tmp105_set_temperature(TMP105_TEST_ID, 85000);
+        g_assert_false(get_irq(0));
+    }
+    qmp_tmp105_set_temperature(TMP105_TEST_ID, 85000);
+    g_assert_true(get_irq(0));
+}
+
+/*
+ * Leaving shutdown (SD 1->0) resumes continuous conversion, which must
+ * re-evaluate the current temperature against the limits.
+ */
+static void test_wake_from_shutdown(void *obj, void *data,
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
+    i2c_set8(i2cdev, TMP105_REG_CONFIG,
+             TMP105_CONFIG_POL | TMP105_CONFIG_FQ_1 | TMP105_CONFIG_SD);
+    g_assert_true(get_irq(0));
+
+    qmp_tmp105_set_temperature(TMP105_TEST_ID, 70000);
+    g_assert_true(get_irq(0));
+
+    i2c_set8(i2cdev, TMP105_REG_CONFIG, TMP105_CONFIG_POL | TMP105_CONFIG_FQ_1);
+    g_assert_false(get_irq(0));
+}
+
 /* The TMP75 maps F1:F0 = 10b to 3 consecutive faults. */
 static void test_tmp75_fault_queue(void *obj, void *data,
                                    QGuestAllocator *alloc)
@@ -282,6 +380,10 @@ static void tmp105_register_nodes(void)
     qos_add_test("tx-rx", "tmp105", send_and_receive, NULL);
     qos_add_test("alert-single-fault", "tmp105", test_alert_single_fault, NULL);
     qos_add_test("fault-queue", "tmp105", test_fault_queue, NULL);
+    qos_add_test("fault-queue-ignores-writes", "tmp105",
+                 test_fault_queue_ignores_writes, NULL);
+    qos_add_test("one-shot", "tmp105", test_one_shot, NULL);
+    qos_add_test("wake-from-shutdown", "tmp105", test_wake_from_shutdown, NULL);
 
     /* TMP75: register-compatible, but with a 1/2/3/4 fault queue. */
     QOSGraphEdgeOptions tmp75_opts = {

-- 
2.50.1


