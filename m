Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0B495CC6B34
	for <qemu-devel@archiver.kernel.org>; Thu, 15 Oct 2026 10:33:22 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xHIjT-0000vH-MK; Thu, 15 Oct 2026 06:30:44 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eblot.ml@gmail.com>)
 id 1xHIgL-00048J-DO
 for qemu-devel@nongnu.org; Thu, 15 Oct 2026 06:27:34 -0400
Received: from mail-wm1-f48.google.com ([209.85.128.48])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <eblot.ml@gmail.com>)
 id 1xHIgH-00047r-Td
 for qemu-devel@nongnu.org; Thu, 15 Oct 2026 06:27:28 -0400
Received: by mail-wm1-f48.google.com with SMTP id
 5b1f17b1804b1-4a021c809e3so48459825e9.0
 for <qemu-devel@nongnu.org>; Thu, 15 Oct 2026 03:27:25 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792060044; x=1792664844;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=imFMkJM4Su/meWF7Bk/irxYZZDqQDWRnzR3YhZvsMNY=;
 b=pad4bKVt6Te8ha6k7KxQY8QDjN2li29yc6qFkyKeAtDYYmN6elWNLNCBFwQYLn+AO4
 H2RSyxJhN9zMP0JdkCeIP82VLCJy8jDW42lX5Pdh+1MqVpZRjm1oKh/TZqbWgWXavWo5
 kC5VZlpUxZTEZqFXgmyRLSQeycbQJad9Q6BAovgot62xN594QozMR59HOTl2Xdlqjaom
 SeekXvXfXT9nk0O/eCzv5jqxSAK5qO0q1RP1X4xqrGivasdIczR0Y4e4SfHg/GqLxRra
 3RzCk8/KAuG+W/wW4MSIMxzPBL0zJ+RwjfvYhGKzbX6KL6AUhHj3rVgpf2o4doPDmRWO
 hZRw==
X-Gm-Message-State: AFq9FYIAe8tzaKq8eTRt9JHsoY+SMMOGfxFTw90Ijqu8eljPmyhP4fp7
 iw7Xpl76VVOtVGwf6bfCEyV2iYTmClA/hz7xm6oH525eP2nzwRN0tUcFSfrJOg==
X-Gm-Gg: AYBFou1Um9/+J0cYSJ8tmr5nFuOcnK0Z0yLuAlKNVDrqYcQN9YmRWMIdiByFwJIuHvw
 hKiDcNOusTzdoV8uA4Jh+x0wwpCuocEvrFgUaoKn/UfvSAPBXsASCzH0XLFzfzHtTUFV61MZutK
 eIKt7b/fPg/Ulv4PiFM+UjoFFzgsfMG0TMDjtk5Ggl0sNPCkaHfHUBilK74VALaIw4cgx1hnk8V
 xkOfypA3nqAYuumfbfJjIMtsRk8IOqGdW1pbGUc0GnGRJ5MbWLIUt7z4+n0aOarwbSPjpn7Wf7l
 vbPy5FxlX7LPgj8zOAvYn2zwbJiG6QvDfsEDU1N49VH7xsisPWmhFyd5yx4hwPUaAZGUUXtddpQ
 fg+0jrIC51A6At0Tac7iSqmyFHHCkQC9+p+JtUeDnWJ0T598KLsrl3Cy+ozISkeZJCeI9VO7eIF
 bnKgClVa7YSa8FlrIxRoYMFsQwQMglrh67BExyIsuW9DYgcozkgH1oU3Rbh3sQO1FdH38+s4V74
 P+6jYFbxdSbL4JkbglLXensci54hc7+aV8T6LpQrvKiCw==
X-Received: by 2002:a05:600c:524a:b0:4a0:251f:a726 with SMTP id
 5b1f17b1804b1-4a18e4a54f2mr391008825e9.24.1792060044282; 
 Thu, 15 Oct 2026 03:27:24 -0700 (PDT)
Received: from localhost (89-93-216-19.hfc.dyn.abo.bbox.fr. [89.93.216.19])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4a1bd5e9dd7sm39694475e9.0.2026.10.15.03.27.23
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 15 Oct 2026 03:27:23 -0700 (PDT)
Date: Thu, 15 Oct 2026 11:28:16 +0200
Subject: [PATCH v3 29/50] tests/qtest: ds1339: cover the day-of-week
 counter
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261015-bmc-minerva-v3-29-7d50c8a108e5@free.fr>
References: <20261015-bmc-minerva-v3-0-7d50c8a108e5@free.fr>
In-Reply-To: <20261015-bmc-minerva-v3-0-7d50c8a108e5@free.fr>
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
X-Mailer: b4 0.16.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1792056476; l=2635;
 i=emmanuel.blot@free.fr; s=20260602; h=from:subject:message-id;
 bh=eyo+ejkyIwGpn53A6NDRDtcAT+GA1L3xUgmQjCv7Q5U=;
 b=+Sk24fn+A1CTVTRUyTLcv2AiuUMZSXksKbZwB6Kq2jE9ne2mGilDjJ/o6goP5C8kUsYiHyQ1a
 nQdER5bFZyYD0rNltnAKexpw5vG8BgblxULHjfRgTo4EB7cP7iGzzBh
X-Developer-Key: i=emmanuel.blot@free.fr; a=ed25519;
 pk=0qFrZ21FAAN8OfVsSoVcCFTk/NMYOWzxJz4paSAVm0g=
Received-SPF: pass client-ip=209.85.128.48; envelope-from=eblot.ml@gmail.com;
 helo=mail-wm1-f48.google.com
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

The day-of-week register and the offset behind it had no coverage at
all.

Signed-off-by: Emmanuel Blot <emmanuel.blot@free.fr>
---
 tests/qtest/ds1339-test.c | 32 ++++++++++++++++++++++++++++++++
 1 file changed, 32 insertions(+)

diff --git a/tests/qtest/ds1339-test.c b/tests/qtest/ds1339-test.c
index 3259fa1df3..12562eff5f 100644
--- a/tests/qtest/ds1339-test.c
+++ b/tests/qtest/ds1339-test.c
@@ -15,6 +15,7 @@
 /* DS1339 register map */
 #define DS1339_SECONDS   0x00
 #define DS1339_HOURS     0x02
+#define DS1339_DAY       0x03
 #define DS1339_DATE      0x04
 #define DS1339_MONTH     0x05
 #define DS1339_YEAR      0x06
@@ -174,6 +175,36 @@ static void test_eosc_restart(void *obj, void *data, QGuestAllocator *alloc)
     g_assert_cmphex(resp[6], ==, 0x31);
 }
 
+/* The day counter is the guest's own numbering, and steps at midnight. */
+static void test_day_of_week(void *obj, void *data, QGuestAllocator *alloc)
+{
+    QI2CDevice *i2cdev = (QI2CDevice *)obj;
+    /* 23:59:59 on 14 June 2024, the day counter reading 7. */
+    const uint8_t tod[7] = { 0x59, 0x59, 0x23, 0x07, 0x14, 0x06, 0x24 };
+    unsigned idx;
+
+    for (idx = 1; idx <= 7; idx++) {
+        i2c_set8(i2cdev, DS1339_DAY, idx);
+        g_assert_cmphex(i2c_get8(i2cdev, DS1339_DAY), ==, idx);
+    }
+
+    i2c_set8(i2cdev, DS1339_DAY, 0x03);
+    i2c_set8(i2cdev, DS1339_DATE, 0x14);
+    i2c_set8(i2cdev, DS1339_MONTH, 0x06);
+    i2c_set8(i2cdev, DS1339_YEAR, 0x24);
+    g_assert_cmphex(i2c_get8(i2cdev, DS1339_DAY), ==, 0x03);
+
+    i2c_write_block(i2cdev, DS1339_SECONDS, tod, sizeof(tod));
+    for (idx = 0; idx < 50; idx++) {
+        if (i2c_get8(i2cdev, DS1339_DAY) != 0x07) {
+            break;
+        }
+        g_usleep(100 * 1000);
+    }
+    g_assert_cmphex(i2c_get8(i2cdev, DS1339_DAY), ==, 0x01);
+    g_assert_cmphex(i2c_get8(i2cdev, DS1339_DATE), ==, 0x15);
+}
+
 /* Midnight and noon are the hours the 12-hour encoding special-cases. */
 static void test_hour_mode_12(void *obj, void *data, QGuestAllocator *alloc)
 {
@@ -414,6 +445,7 @@ static void ds1339_register_nodes(void)
     qos_add_test("eosc-restart", "ds1339", test_eosc_restart, NULL);
     qos_add_test("stopped-reserved-bits", "ds1339",
                  test_stopped_reserved_bits, NULL);
+    qos_add_test("day-of-week", "ds1339", test_day_of_week, NULL);
     qos_add_test("hour-mode-12", "ds1339", test_hour_mode_12, NULL);
     qos_add_test("month-28-days", "ds1339", test_month_28_days, NULL);
     qos_add_test("month-29-days", "ds1339", test_month_29_days, NULL);

-- 
2.53.0-Meta


