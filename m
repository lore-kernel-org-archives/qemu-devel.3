Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B6427C79FA7
	for <qemu-devel@archiver.kernel.org>; Mon,  7 Sep 2026 16:46:55 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x3cUR-0006uz-QE; Mon, 07 Sep 2026 12:46:39 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eblot.ml@gmail.com>)
 id 1x3cUH-00064x-Pf
 for qemu-devel@nongnu.org; Mon, 07 Sep 2026 12:46:30 -0400
Received: from mail-wm1-f44.google.com ([209.85.128.44])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <eblot.ml@gmail.com>)
 id 1x3cUD-0003e6-CT
 for qemu-devel@nongnu.org; Mon, 07 Sep 2026 12:46:29 -0400
Received: by mail-wm1-f44.google.com with SMTP id
 5b1f17b1804b1-49b8e527d63so44661595e9.2
 for <qemu-devel@nongnu.org>; Mon, 07 Sep 2026 09:46:24 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1788799583; x=1789404383;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=CE66LIeSclgE4NkiTTrzb49MDOENKPAt6wmOxVbF85E=;
 b=L7qkc/07kgjKBjt9A/mUeRYU4QD5GRXF9RmfMZyAqf4USeKmLnf/XFvQt86NPrttmw
 NeHSaDXCqCLkjzFiTQJ97bFx0hK9rbOnoFdqQiVFOHm+PxeT8Ya0O+ddoRGv0Mbc56Qe
 jx+oz8lp4m+nGZYl8GQFwTs9mDFNXFwkbAFqbHVriFYcJnvT68Go5LHq6dyIwJqIhN0a
 UpYtkMXcfpaeTS0TJ3tRQRFAQAVsP8nBSWFTsJf5DOM8y5L7zFpQ1jSRck/X5vPmSsNN
 VFKT8918qvvXfwJPf/q2WEnZQcAE1U6MqaPSrA9P1oM/9uqo/Jc0B6ujkuqONoRUKVqw
 F2sg==
X-Gm-Message-State: AFuF++kHpn86up3EDcBMEcfQSfQS+GqsVPXnKR2nvduuqvdKDq34HOQl
 aC4wYVDaTg8Yiy1PDCSBpPLvaNycgnbOQmlLqdnr+P6dMySOF9gdPCCcTqSCNqu7
X-Gm-Gg: AYBFou3u4WolP1Xh2ALJewPKp8jGPrcnLFCX09ygcjOFeJaSeDhGwmrj1w6tRyOo148
 UvE/gaS5ykgAUHjIhi/5JekQK2ycsc8xoE/T+OpecTjI0VITSx/yZzlUucGg9ydxATy6F5QXDzf
 NVWQY+wAjpYGVa1tfoD25pGkCKkxOwpi8nIVLe/QWHgzFBPcwWFYrh30FkjXmlyk5LiocrWhmi3
 sFGzFH09PK7iCCcZPwF+y/9YyhKuqhcv6WiyIApaaUjXWpyB87gCi9gBQ0SBuv5Y1PekTdF1GUE
 bA4quRJYUGK7SAn2KRf+/45bG4lVamNSHABNc9keOVbcm0FCSGBVVAonvJfn8dButgSDgVLyaDz
 tKC+LUCtj1lwVZKCOjMiBLO2T8RTsE/EGCfhOXA8MzjagSRTi9xRm+7XhYSnQq9EPk/bTHwVt2Y
 BybQ7ARjsTGuBIwwrhJdWJQqOp5aqoFLpL6mNHjaMaxh+8v391986bMbhhW5jUA3fJ6cApHO5YI
 md3/p8tGpw8DmbYy7cvS/AmtaJPXCM0mvyH4xyo1ZMC0wE=
X-Received: by 2002:a05:600c:34c2:b0:49d:10d6:fd55 with SMTP id
 5b1f17b1804b1-49d10d6fdeemr66158695e9.1.1788799582958; 
 Mon, 07 Sep 2026 09:46:22 -0700 (PDT)
Received: from localhost (89-93-216-19.hfc.dyn.abo.bbox.fr. [89.93.216.19])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-49cf7703cc7sm324542035e9.4.2026.09.07.09.46.22
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 07 Sep 2026 09:46:22 -0700 (PDT)
Date: Mon, 07 Sep 2026 18:42:10 +0200
Subject: [PATCH 20/50] tests/qtest: ds1338: cover persist-on-reset
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260907-bmc-minerva-v1-20-0d83ad610c3b@free.fr>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1788799320; l=3608;
 i=emmanuel.blot@free.fr; s=20260602; h=from:subject:message-id;
 bh=whBRDkq86D+HpAogEE9qlSe08li7AMBnF3gE+b/1tiI=;
 b=fE3po2qgxHAmHgUa4dRQpxZcl6z4vvKKQ6RD22BiwT5SnNM9Qw32VHN+jGPvf0UX/K0o9Q3P7
 ymISKZzSLRVAaz/gLKl2uuJ/UcEezdNlSW2hBLpIyJHiWQ8pGgYf+oc
X-Developer-Key: i=emmanuel.blot@free.fr; a=ed25519;
 pk=0qFrZ21FAAN8OfVsSoVcCFTk/NMYOWzxJz4paSAVm0g=
Received-SPF: pass client-ip=209.85.128.44; envelope-from=eblot.ml@gmail.com;
 helo=mail-wm1-f44.google.com
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

The property had no coverage in either of its two settings.

Signed-off-by: Emmanuel Blot <emmanuel.blot@free.fr>
---
 tests/qtest/ds1338-test.c | 54 +++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 54 insertions(+)

diff --git a/tests/qtest/ds1338-test.c b/tests/qtest/ds1338-test.c
index 1b73dca98d..1b9c02d931 100644
--- a/tests/qtest/ds1338-test.c
+++ b/tests/qtest/ds1338-test.c
@@ -20,12 +20,15 @@
 #include "qemu/osdep.h"
 #include "qemu/bcd.h"
 #include "libqtest.h"
+#include "libqtest-single.h"
 #include "libqos/i2c.h"
+#include "qobject/qdict.h"
 
 #define DS1338_ADDR 0x68
 
 /* DS1338 register map */
 #define DS1338_SECONDS   0x00
+#define DS1338_YEAR      0x06
 #define DS1338_CONTROL   0x07
 #define DS1338_NVRAM     0x08
 #define DS1338_NUM_REGS  0x40
@@ -136,6 +139,50 @@ static void test_nvram(void *obj, void *data, QGuestAllocator *alloc)
     g_assert_cmphex(i2c_get8(i2cdev, 0x3f), ==, 0xc3);
 }
 
+/* A reset restores the power-on state, unless persist-on-reset is set. */
+static void check_reset(QI2CDevice *i2cdev, bool persists)
+{
+    uint8_t year = i2c_get8(i2cdev, DS1338_YEAR);
+    /* A year the clock is not already showing, so the check discriminates. */
+    uint8_t marker = year == 0x42 ? 0x77 : 0x42;
+    QDict *rsp;
+
+    i2c_set8(i2cdev, DS1338_NVRAM, 0xa5);
+    i2c_set8(i2cdev, DS1338_CONTROL, 0x00);
+    i2c_set8(i2cdev, DS1338_YEAR, marker);
+    g_assert_cmphex(i2c_get8(i2cdev, DS1338_NVRAM), ==, 0xa5);
+    g_assert_cmphex(i2c_get8(i2cdev, DS1338_CONTROL), ==, 0x00);
+    g_assert_cmphex(i2c_get8(i2cdev, DS1338_YEAR), ==, marker);
+
+    rsp = qmp("{ 'execute': 'system_reset' }");
+    g_assert(qdict_haskey(rsp, "return"));
+    qobject_unref(rsp);
+    qmp_eventwait("RESET");
+
+    if (persists) {
+        g_assert_cmphex(i2c_get8(i2cdev, DS1338_NVRAM), ==, 0xa5);
+        g_assert_cmphex(i2c_get8(i2cdev, DS1338_CONTROL), ==, 0x00);
+        g_assert_cmphex(i2c_get8(i2cdev, DS1338_YEAR), ==, marker);
+    } else {
+        g_assert_cmphex(i2c_get8(i2cdev, DS1338_NVRAM), ==, 0x00);
+        g_assert_cmphex(i2c_get8(i2cdev, DS1338_CONTROL), ==, DS1338_CTRL_POR);
+        /* Back on host time, which is where the year came from. */
+        g_assert_cmphex(i2c_get8(i2cdev, DS1338_YEAR), ==, year);
+    }
+}
+
+/* Without persist-on-reset, a reset takes the part back to power-on. */
+static void test_reset_clears(void *obj, void *data, QGuestAllocator *alloc)
+{
+    check_reset((QI2CDevice *)obj, false);
+}
+
+/* With persist-on-reset, the registers and the clock survive a reset. */
+static void test_reset_persists(void *obj, void *data, QGuestAllocator *alloc)
+{
+    check_reset((QI2CDevice *)obj, true);
+}
+
 /* The register pointer wraps at the end of the map. */
 static void test_address_wrap(void *obj, void *data, QGuestAllocator *alloc)
 {
@@ -162,6 +209,13 @@ static void ds1338_register_nodes(void)
     qos_add_test("clock-halt", "ds1338", test_clock_halt, NULL);
     qos_add_test("nvram", "ds1338", test_nvram, NULL);
     qos_add_test("address-wrap", "ds1338", test_address_wrap, NULL);
+    qos_add_test("reset-clears", "ds1338", test_reset_clears, NULL);
+
+    opts.extra_device_opts = "address=0x68,persist-on-reset=on";
+    qos_node_create_driver_named("ds1338-persist", "ds1338", i2c_device_create);
+    qos_node_consumes("ds1338-persist", "i2c-bus", &opts);
+
+    qos_add_test("reset-persists", "ds1338-persist", test_reset_persists, NULL);
 }
 
 libqos_init(ds1338_register_nodes);

-- 
2.50.1


