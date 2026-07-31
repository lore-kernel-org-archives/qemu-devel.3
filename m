Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 226D9C54F54
	for <qemu-devel@archiver.kernel.org>; Fri, 31 Jul 2026 12:32:33 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wpmPJ-0005Wj-0t; Fri, 31 Jul 2026 08:32:09 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eblot.ml@gmail.com>)
 id 1wpmPG-0005Ve-JL
 for qemu-devel@nongnu.org; Fri, 31 Jul 2026 08:32:06 -0400
Received: from mail-wr1-f52.google.com ([209.85.221.52])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <eblot.ml@gmail.com>)
 id 1wpmPF-0000Yo-0N
 for qemu-devel@nongnu.org; Fri, 31 Jul 2026 08:32:06 -0400
Received: by mail-wr1-f52.google.com with SMTP id
 ffacd0b85a97d-47c6e9a694bso583985f8f.1
 for <qemu-devel@nongnu.org>; Fri, 31 Jul 2026 05:32:04 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1785501123; x=1786105923;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=jDYA5Xg1AcjoGqaDT6Y+c4Ycg06GuzHzyiFnFNhge4E=;
 b=Gm0OqdHoopl3sBtTWwrZfxAT7LxSHNy+UWFj2bkaukSzIf/FAMrX7VzuCXjzmTwPkB
 bu8EMqrVG8wsjuKxh3fiD9miO6rLjkE6Dy790UpJZMJDtU/uxfeJNsUJoC6ngOv89c1v
 t771DmG1nq/BHwXqXjENOGnCxJuP5ujznhgoM86VqQnKp/gm+4u1vMz6vR8MdI4qj+gj
 JU7XylLXlrsuUKcHdoaMYIbpe+PsGGZkEV1dnEnUbnNVT/4uB6bHFHo3mbh4s87QSQO9
 2JNnwpach8UZoSA/1zaz49blR74OHUzvgyRRhazpofxyYpPvSV0kztnK0pB4WzjkRl1B
 FAgw==
X-Gm-Message-State: AOJu0Yx3EZtMgaZYFv9uhGkUtJq1Dhf1NqeUl7UbuFndnMP09dfWV+qV
 VqfXRZgdTLNFEwbiJlItyCorKjJB/4VY2rmpXjiDeYVgCqyVvQG/bKmtpICxxr+k
X-Gm-Gg: AR+sD13PjmHbZ0ZdTlB6HCQI+bYAbWPRlcnt1ES9pDbjxkcyBN2OBoHbpWRbcC5DeRs
 4ZhiuIVQdZtg1Jywzrbj4b5ezyx+g5lTyA+79I0osU1Jy9WEqAZCgtImUn2LAqGiL300zzS5S5v
 9JZ6+Ck2rBr3hX6LQGFht9Ja7YzSmdesVAAPJSOvb3e5/U1IDuJpWauiwWtm9NF/BbeW0DnMD8M
 PTEfrJAt24BVDucFGwpS0OuWElhr617GbL/xxlX+pOw9xRI2zcffXqu0nsAlUZGmmMIjOqi0p6O
 EMszmvZcbxHyPCwlq/VPqqvft9XgMn09aYceMak8iVSWNqNWq/TS3ZQs6Mq9cd5L3+By1uR9szD
 YIMN9Xf+mXM4DMrNCqBqpBs01ponm/BUOWtc8sWuPQJMBwli8p8cSKB2hlPp8LbprDNa1y/nptr
 9jMGtX80aGulOUp1KDNRCtxepIFSE4dZUbf+N9VlC3p7bwjaBOP2nbP7R6PgIELLZ9nKm8uYkx5
 vBThql17leiNGCIW2B/P1Im3+DeDv+uBo6H
X-Received: by 2002:a05:6000:290a:b0:47f:c206:7d0 with SMTP id
 ffacd0b85a97d-47fd2b648fbmr4369004f8f.52.1785501123434; 
 Fri, 31 Jul 2026 05:32:03 -0700 (PDT)
Received: from localhost (89-93-216-19.hfc.dyn.abo.bbox.fr. [89.93.216.19])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-47fd456220esm4525736f8f.18.2026.07.31.05.32.02
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 31 Jul 2026 05:32:02 -0700 (PDT)
Date: Fri, 31 Jul 2026 12:45:07 +0200
Subject: [PATCH v2 08/25] tests/qtest: tmp105: cover the ALERT fault queue
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260731-sanmiguel-bmc-locator-v2-8-1266926ba769@free.fr>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1785494707; l=3508;
 i=emmanuel.blot@free.fr; s=20260602; h=from:subject:message-id;
 bh=STa9fNUK+ufnQgeeZ6iWhS9xfz1DLS6Eh0Aq6teT5tE=;
 b=6XmVQsZ66/Bw9+YAmfrKhBbf4l4TfAyq4U6bmZN57njvEe0cDzVwUtfIIw5o63M/r1k+L5T27
 kGpw6/NdFrsDWeOXEPrz2jRMim4+M9UsjbRXtCDX+LXDGzxqBA/PEv1
X-Developer-Key: i=emmanuel.blot@free.fr; a=ed25519;
 pk=0qFrZ21FAAN8OfVsSoVcCFTk/NMYOWzxJz4paSAVm0g=
Received-SPF: pass client-ip=209.85.221.52; envelope-from=eblot.ml@gmail.com;
 helo=mail-wr1-f52.google.com
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


