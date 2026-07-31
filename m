Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 02F7EC54F54
	for <qemu-devel@archiver.kernel.org>; Fri, 31 Jul 2026 12:35:26 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wpmSG-0007N5-Ts; Fri, 31 Jul 2026 08:35:12 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eblot.ml@gmail.com>)
 id 1wpmSE-0007MZ-My
 for qemu-devel@nongnu.org; Fri, 31 Jul 2026 08:35:10 -0400
Received: from mail-wr1-f49.google.com ([209.85.221.49])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <eblot.ml@gmail.com>)
 id 1wpmSD-0000v5-5y
 for qemu-devel@nongnu.org; Fri, 31 Jul 2026 08:35:10 -0400
Received: by mail-wr1-f49.google.com with SMTP id
 ffacd0b85a97d-47f93b2fe4cso592152f8f.0
 for <qemu-devel@nongnu.org>; Fri, 31 Jul 2026 05:35:08 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1785501308; x=1786106108;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=cgbT+Nkm1dADHvR/4vLeWGsR4IryoIoADhqYOAUzjvs=;
 b=pXng6LGhuhdg6yknsU9vcHHeOLeYnjLWwwTDI590QgmgykvoISLr4Wgv91E3tCCeUt
 /J0LjnC0U5Az6OPcs2wiJYssW4Xa7FyVIMKrFY0S0pOMisp5+Wtz8P8MaxxwpluDuE4Q
 4hBgZF6UYh5wyiqbC5U1i9VfMkAdt3QU0X8MuhXCkKv+N9/bRyidcZo9MD92eTsSdQmT
 mtQ0Mdmtu7ph3lCfUAdR66C5nlwAQEmpWziOadRz8Xs+CtXR/rNqWLa/juQ2RjRWm1Pm
 5qMrUtrIrGPRWKcm6aM6/HgXfTNCwXwMskgfk0D7WKchE6sOUt1kQLGlyGqIDR9rv3WI
 MbGQ==
X-Gm-Message-State: AOJu0Yyto7HfVAr/SRE5Z4S49q9+ZUj03DksExzYb+c/XZds809uovOj
 SJd7H8LXUMDoP8HZc9pMx95S9nFl27Ww65PxYehzTYy4sUK3mGtWsIUwXvHXcsjk
X-Gm-Gg: AR+sD12ufBVoGiHn7STqvgDBYfEYQfFK5d+TGCBQfsUIBuzwuQ/R1DIp27okFCV/Vza
 aI8DWJA0sFVZGxL7UEsf2cFIS2bTnxWw64N86o3Bn/4N66xBvALT+5XahgC5fQ0NM5KFJcs8TiG
 FszqwiweAY85VAmrb3PQqNtmBPbTkf4FOEo+0zT0ju8N0Msp6uvHsyYzIHsn4/DuBJ0XuD2wn1y
 fLbGxehbJHVQ1n18Vn2RRf/HNMmaOt+7ZQbOuPJn0t+scHjerKg/+qCt+VXu5y8eEhdGvv3uoXz
 c5cDwWutxQubGzymMnRu7lpsEvyOQox2vya0/RYHNG58ghtGhHFTdhyLpUouygiwSx7f1Ns5N6D
 YgB0GbuKUOtXOAbHK0mU5tWyD8C2JWYkkYIS2eyCnxNqlKh3pAnfqLRHAK8wgpX2I9yZfp23unr
 fSsKWIon2oyMaXLlLFXa97hP22gv8BnU/Ut3eJNsQjND5FUUZ+ZxGupkKL3v9Hax9H6xcSfPIkV
 kicukH9J3fHvt+fGoXzSkPawuKGoCdZVUBk
X-Received: by 2002:a05:6000:2994:20b0:47f:8fb6:c32e with SMTP id
 ffacd0b85a97d-47fd2b578damr3454076f8f.46.1785501307713; 
 Fri, 31 Jul 2026 05:35:07 -0700 (PDT)
Received: from localhost (89-93-216-19.hfc.dyn.abo.bbox.fr. [89.93.216.19])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-47fd4562a38sm4162627f8f.21.2026.07.31.05.35.06
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 31 Jul 2026 05:35:07 -0700 (PDT)
Date: Fri, 31 Jul 2026 12:45:10 +0200
Subject: [PATCH v2 11/25] tests/qtest: tmp105: cover shutdown clearing the
 ALERT across variants
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260731-sanmiguel-bmc-locator-v2-11-1266926ba769@free.fr>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1785494708; l=3738;
 i=emmanuel.blot@free.fr; s=20260602; h=from:subject:message-id;
 bh=2fRBCplKTjlFLd6EsRzXdhUj/5B9QVDOaJYG5Z5CWwc=;
 b=3oPlxId5SWQ2928LfG4btUnPH189fpHIha7nQppuFkIJ9+uXf+Ofh3wiHE38jShW05QjqR5rL
 yvY+L+QuG4XA2Elxtcj5VqniL6MpixKAq21fMUkJslEnLr+TO5+z3C0
X-Developer-Key: i=emmanuel.blot@free.fr; a=ed25519;
 pk=0qFrZ21FAAN8OfVsSoVcCFTk/NMYOWzxJz4paSAVm0g=
Received-SPF: pass client-ip=209.85.221.49; envelope-from=eblot.ml@gmail.com;
 helo=mail-wr1-f49.google.com
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

Verify that entering shutdown clears the ALERT/OS output in interrupt
mode but leaves it asserted in comparator mode, for both the TMP75 and
the LM75B.

Signed-off-by: Emmanuel Blot <emmanuel.blot@free.fr>
---
 tests/qtest/tmp105-test.c | 56 +++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 56 insertions(+)

diff --git a/tests/qtest/tmp105-test.c b/tests/qtest/tmp105-test.c
index e586a634d8..504f6b7202 100644
--- a/tests/qtest/tmp105-test.c
+++ b/tests/qtest/tmp105-test.c
@@ -335,6 +335,41 @@ static void test_tmp75_tm_clears_alert(void *obj, void *data,
     g_assert_false(get_irq(0));
 }
 
+/*
+ * Entering shutdown clears the ALERT in interrupt mode but leaves it asserted
+ * in comparator mode.
+ */
+static void test_tmp75_shutdown_clears_alert(void *obj, void *data,
+                                             QGuestAllocator *alloc)
+{
+    QI2CDevice *i2cdev = (QI2CDevice *)obj;
+    int i;
+
+    qtest_irq_intercept_out(global_qtest, TMP75_TEST_PATH);
+
+    i2c_set8(i2cdev, TMP105_REG_CONFIG,
+             TMP105_CONFIG_POL | TMP105_CONFIG_TM | TMP105_CONFIG_FQ(3));
+    for (i = 0; i < 4; i++) {
+        qmp_tmp105_set_temperature(TMP75_TEST_ID, 85000);
+    }
+    g_assert_true(get_irq(0));
+
+    i2c_set8(i2cdev, TMP105_REG_CONFIG,
+             TMP105_CONFIG_POL | TMP105_CONFIG_TM | TMP105_CONFIG_FQ(3) |
+             TMP105_CONFIG_SD);
+    g_assert_false(get_irq(0));
+
+    i2c_set8(i2cdev, TMP105_REG_CONFIG,
+             TMP105_CONFIG_POL | TMP105_CONFIG_FQ(3));
+    for (i = 0; i < 4; i++) {
+        qmp_tmp105_set_temperature(TMP75_TEST_ID, 85000);
+    }
+    g_assert_true(get_irq(0));
+    i2c_set8(i2cdev, TMP105_REG_CONFIG,
+             TMP105_CONFIG_POL | TMP105_CONFIG_FQ(3) | TMP105_CONFIG_SD);
+    g_assert_true(get_irq(0));
+}
+
 /*
  * The LM75B has a fixed 11-bit (0.125 C) converter: the resolution and one-shot
  * Config bits are reserved (read/write as zero) and the temperature register is
@@ -367,6 +402,23 @@ static void test_lm75b_limits(void *obj, void *data,
     g_assert_cmphex(i2c_get16(i2cdev, TMP105_REG_T_LOW), ==, 0x1280);
 }
 
+/* The LM75B likewise resets its OS output on shutdown in interrupt mode. */
+static void test_lm75b_shutdown_clears_alert(void *obj, void *data,
+                                             QGuestAllocator *alloc)
+{
+    QI2CDevice *i2cdev = (QI2CDevice *)obj;
+
+    qtest_irq_intercept_out(global_qtest, LM75B_TEST_PATH);
+
+    i2c_set8(i2cdev, TMP105_REG_CONFIG, TMP105_CONFIG_POL | TMP105_CONFIG_TM);
+    qmp_tmp105_set_temperature(LM75B_TEST_ID, 85000);
+    g_assert_true(get_irq(0));
+
+    i2c_set8(i2cdev, TMP105_REG_CONFIG,
+             TMP105_CONFIG_POL | TMP105_CONFIG_TM | TMP105_CONFIG_SD);
+    g_assert_false(get_irq(0));
+}
+
 static void tmp105_register_nodes(void)
 {
     QOSGraphEdgeOptions opts = {
@@ -396,6 +448,8 @@ static void tmp105_register_nodes(void)
 
     qos_add_test("fault-queue", "tmp75", test_tmp75_fault_queue, NULL);
     qos_add_test("tm-clears-alert", "tmp75", test_tmp75_tm_clears_alert, NULL);
+    qos_add_test("shutdown-clears-alert", "tmp75",
+                 test_tmp75_shutdown_clears_alert, NULL);
 
     /* TMP175: like the TMP105, with a 1/2/4/6 fault queue. */
     QOSGraphEdgeOptions tmp175_opts = {
@@ -419,5 +473,7 @@ static void tmp105_register_nodes(void)
 
     qos_add_test("resolution", "lm75b", test_lm75b_resolution, NULL);
     qos_add_test("limits", "lm75b", test_lm75b_limits, NULL);
+    qos_add_test("shutdown-clears-alert", "lm75b",
+                 test_lm75b_shutdown_clears_alert, NULL);
 }
 libqos_init(tmp105_register_nodes);

-- 
2.50.1


