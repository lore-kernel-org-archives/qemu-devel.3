Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CBF09606A31B
	for <qemu-devel@archiver.kernel.org>; Thu,  5 Nov 2026 08:59:09 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xOtJ8-0006B5-1j; Thu, 05 Nov 2026 03:58:54 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eblot.ml@gmail.com>)
 id 1xOtJ4-0005vP-N3
 for qemu-devel@nongnu.org; Thu, 05 Nov 2026 03:58:50 -0500
Received: from mail-pf1-f179.google.com ([209.85.210.179])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <eblot.ml@gmail.com>)
 id 1xOtJ1-0003p6-C6
 for qemu-devel@nongnu.org; Thu, 05 Nov 2026 03:58:50 -0500
Received: by mail-pf1-f179.google.com with SMTP id
 d2e1a72fcca58-8a0880a46e7so278786b3a.1
 for <qemu-devel@nongnu.org>; Thu, 05 Nov 2026 00:58:46 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793869124; x=1794473924;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=Adz/rIkVxKmnpzPklQqKGWWgHGHy0e2h5cr4SvKWE0I=;
 b=ptGI8x7DDZdlzT58vy52Rb3xkQpzFlMdM0akhpII01EofIRETGdgz/Jfi4u13HxlIt
 OBKYWX6mXQ6hYIFvKVqOXt42pHsA+JW1EcnFzpUv75+WtCxqUyXnMRiQmp1/QIRaWirE
 n9Gs0fBHTcUH9ymAZ+aWfTS2mAac3X6cvTAkCtylvgd69zC3MppUWU1ecsTnhII64kJp
 cXdDxrOOGoFkTauEQvrBVPz66JLfkqYaAqiYZvTGNM7APnbyQdINmAKHI0Fg5Z82eqhT
 8wduYzkRbTB5YFPr8nQ6ZjAM2XN/6+Nq0JAmgTbt2O/RAkjwIIDJIXwzz03WY08J0RBS
 sRWA==
X-Gm-Message-State: APuU4Z81HpSJ0L1tyMVpLu2tW0474SwigVEoy4QIvf525NSLE2vcnc0O
 E5VmnR9NL7QvLFQ07C5xN4iLyP1ggOzah002vacClybmTny3CMKbAq7Io/dyaUgHKt4=
X-Gm-Gg: AYBFou2nKLYXcwG+YYUSdAMKU7+JA2rVgviKhoYMkLXTS9zULJ97/qS6Je0Y+Dfjr+R
 nBd0UPVjMn34I96ffF52qB/p2ipF3iPHHwZ0kARRb5ZYJvpTnLn3gTRqfHXGCVxm/N2o90juTmy
 GrQVjOcPP2WUomvMkiNG9LkonbvQSaafLobSCQPQn8sRDvL+1DEAbv523YUPAKgdOrwflB3wGSU
 563YHLhhucufqvW8YbqGIPG0CLE2yLsMB7YpzTRGUsV83cejBvreqWqpazl7R/oHw/tO2RQrd7W
 j9PdTE/+CqWc2VMJc828KnuEgEPuBZmCuhZm5RW7BDBp3GGTIt80GBoXowUL3AZ32sZAJEEbafw
 n0Bi6qx2C15er7nRq23xylf2DpkvPmzQjnmnfC2OSe1PGdnO6yh/XIei6dat+avAeXH7VFqtG7+
 orWv1JRoopzRl9UMNy1cnRbz7i7O1TDKW1NA89iiVRIOveIoBcMLtb4GZgCfJAs26xhIR/oF4tV
 iRwEcj7TYX2bpbp2+w2HYyAs7yTMHaOVcs5tGN7Y0wnbxOPZXeZ3nbINq2XlPL6liFfEc2v6VHo
 2PeIhI/bI+N+rIwHtcwYM6bQKAxAeXAVEVgW6qM4cCW4JTDIVZrwBdmy/hleKrWqRbEfCcptRp5
 FqB7qlg==
X-Received: by 2002:a05:6a00:400a:b0:8a0:6db5:9450 with SMTP id
 d2e1a72fcca58-8b1e612e4c2mr1270976b3a.38.1793869124456; 
 Thu, 05 Nov 2026 00:58:44 -0800 (PST)
Received: from localhost (118-163-122-149.hinet-ip.hinet.net.
 [118.163.122.149]) by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-8b097fe0dc0sm1887655b3a.1.2026.11.05.00.58.43
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 05 Nov 2026 00:58:44 -0800 (PST)
Date: Thu, 05 Nov 2026 16:50:51 +0800
Subject: [PATCH 15/19] tests/qtest: ds1339: cover the end-of-month rollover
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261105-rtc-ds1339-v1-15-50a8dc463ee8@free.fr>
References: <20261105-rtc-ds1339-v1-0-50a8dc463ee8@free.fr>
In-Reply-To: <20261105-rtc-ds1339-v1-0-50a8dc463ee8@free.fr>
To: qemu-devel@nongnu.org
Cc: =?utf-8?q?C=C3=A9dric_Le_Goater?= <clg@kaod.org>, 
 Fabiano Rosas <farosas@suse.de>, Laurent Vivier <lvivier@redhat.com>, 
 Paolo Bonzini <pbonzini@redhat.com>, eblot@meta.com, 
 Emmanuel Blot <emmanuel.blot@free.fr>
X-Mailer: b4 0.16.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1793868640; l=3758;
 i=emmanuel.blot@free.fr; s=20260602; h=from:subject:message-id;
 bh=iOwmzyJ4hd6oW//GUNriTfBTlQKKZhGGR+JckreHq5Q=;
 b=aczM5V7X7kWpZY3oaaYAdR/UfuPs3pgS+59/up+DFOunBG+VEjlsSiYxVlaaPJne4wNqyCmu/
 hbXPI9XV+AKDhrh0GUYP4L4pnGMBkLWYpxJ4luKHnbPXhfrPjKa+shO
X-Developer-Key: i=emmanuel.blot@free.fr; a=ed25519;
 pk=0qFrZ21FAAN8OfVsSoVcCFTk/NMYOWzxJz4paSAVm0g=
Received-SPF: pass client-ip=209.85.210.179; envelope-from=eblot.ml@gmail.com;
 helo=mail-pf1-f179.google.com
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
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

The end-of-month rollover was untested, for any of the lengths the
calendar gives a month.

Signed-off-by: Emmanuel Blot <emmanuel.blot@free.fr>
---
 tests/qtest/ds1339-test.c | 60 +++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 60 insertions(+)

diff --git a/tests/qtest/ds1339-test.c b/tests/qtest/ds1339-test.c
index 8c144579e6..7eec163049 100644
--- a/tests/qtest/ds1339-test.c
+++ b/tests/qtest/ds1339-test.c
@@ -14,6 +14,7 @@
 
 /* DS1339 register map */
 #define DS1339_SECONDS   0x00
+#define DS1339_DATE      0x04
 #define DS1339_MONTH     0x05
 #define DS1339_YEAR      0x06
 #define DS1339_ALARM1    0x07
@@ -169,6 +170,61 @@ static void test_eosc_restart(void *obj, void *data, QGuestAllocator *alloc)
     g_assert_cmphex(resp[6], ==, 0x31);
 }
 
+/* Program 23:59:59 on the last day of a month and run the clock past it. */
+static void check_month_rollover(QI2CDevice *i2cdev,
+                                 uint8_t date, uint8_t month, uint8_t year,
+                                 uint8_t next_date, uint8_t next_month,
+                                 uint8_t next_year)
+{
+    const uint8_t tod[7] = { 0x59, 0x59, 0x23, 0x01, date, month, year };
+    uint8_t resp[7];
+    unsigned idx;
+
+    i2c_write_block(i2cdev, DS1339_SECONDS, tod, sizeof(tod));
+
+    for (idx = 0; idx < 50; idx++) {
+        if (i2c_get8(i2cdev, DS1339_DATE) != date) {
+            break;
+        }
+        g_usleep(100 * 1000);
+    }
+
+    i2c_read_block(i2cdev, DS1339_SECONDS, resp, sizeof(resp));
+    g_assert_cmphex(resp[4], ==, next_date);
+    g_assert_cmphex(resp[5] & 0x1f, ==, next_month);
+    g_assert_cmphex(resp[6], ==, next_year);
+}
+
+/* A 31-day month rolls over to the first of the next. */
+static void test_month_31_days(void *obj, void *data, QGuestAllocator *alloc)
+{
+    check_month_rollover((QI2CDevice *)obj,
+                         0x31, 0x01, 0x23, 0x01, 0x02, 0x23);
+}
+
+/* A 30-day month rolls over to the first of the next. */
+static void test_month_30_days(void *obj, void *data, QGuestAllocator *alloc)
+{
+    check_month_rollover((QI2CDevice *)obj,
+                         0x30, 0x04, 0x23, 0x01, 0x05, 0x23);
+}
+
+/* Outside a leap year, February rolls over after the 28th. */
+static void test_month_28_days(void *obj, void *data, QGuestAllocator *alloc)
+{
+    check_month_rollover((QI2CDevice *)obj,
+                         0x28, 0x02, 0x23, 0x01, 0x03, 0x23);
+}
+
+/* In a leap year the 28th is not the last day of February. */
+static void test_month_29_days(void *obj, void *data, QGuestAllocator *alloc)
+{
+    QI2CDevice *i2cdev = (QI2CDevice *)obj;
+
+    check_month_rollover(i2cdev, 0x28, 0x02, 0x24, 0x29, 0x02, 0x24);
+    check_month_rollover(i2cdev, 0x29, 0x02, 0x24, 0x01, 0x03, 0x24);
+}
+
 /* The Century bit is guest-writable and survives an oscillator restart. */
 static void test_century_bit(void *obj, void *data, QGuestAllocator *alloc)
 {
@@ -314,6 +370,10 @@ static void ds1339_register_nodes(void)
     qos_add_test("eosc-restart", "ds1339", test_eosc_restart, NULL);
     qos_add_test("stopped-reserved-bits", "ds1339",
                  test_stopped_reserved_bits, NULL);
+    qos_add_test("month-28-days", "ds1339", test_month_28_days, NULL);
+    qos_add_test("month-29-days", "ds1339", test_month_29_days, NULL);
+    qos_add_test("month-30-days", "ds1339", test_month_30_days, NULL);
+    qos_add_test("month-31-days", "ds1339", test_month_31_days, NULL);
     qos_add_test("century-bit", "ds1339", test_century_bit, NULL);
     qos_add_test("century-write-no-toggle", "ds1339",
                  test_century_write_no_toggle, NULL);

-- 
2.53.0-Meta


