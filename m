Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 95891CA9ED1
	for <qemu-devel@archiver.kernel.org>; Mon, 12 Oct 2026 15:20:30 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xGHot-0006YM-5M; Mon, 12 Oct 2026 11:20:07 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eblot.ml@gmail.com>)
 id 1xGHor-0006Y3-Js
 for qemu-devel@nongnu.org; Mon, 12 Oct 2026 11:20:05 -0400
Received: from mail-wr1-f44.google.com ([209.85.221.44])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <eblot.ml@gmail.com>)
 id 1xGHop-0000Ub-Sv
 for qemu-devel@nongnu.org; Mon, 12 Oct 2026 11:20:05 -0400
Received: by mail-wr1-f44.google.com with SMTP id
 ffacd0b85a97d-48b0584ad71so1086858f8f.0
 for <qemu-devel@nongnu.org>; Mon, 12 Oct 2026 08:20:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1791818402; x=1792423202;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=zfzexpI+Sf5r0TVpd7delVcigz2TZ/5dYES5EEOvYCg=;
 b=Kcp4SZuyhG6nnm7tHonr8aCnIBGUNHx1OhGFqw2PkRyd22hkGk5ySf9nZ9Ynp1lNyd
 i9JtwEs5hmDkfhUWNeIpIGO6VY/OdYwyyk4vOzjqmvkEDzHs19PjhIkdwd9uzyrO5mDJ
 ERZMTXYnwOtqXXESLHhZFh7LyvYBcwZ+1IZ2Oiy0CWxcEV+RvXI3lHrh43s3kQVZHhMs
 WxKUQuXQOVos40RCYT4qwRGUo55lAqbiBe2LYUjaq7nZ3hSBgXZ1wHSzD4/wvJfBBFKa
 mgmPqFOYYJCHaR4mOCAKSqLE91nsqpAOohhDgmGS0FozHRjcwNyl5PwwLxbH8U4y7Qi/
 9ZnA==
X-Gm-Message-State: AFq9FYLU1QMkmE6F5rTj+bNCRuHlnO/x6g7aVO9CtjbEGr7uIUoCiiiT
 ccVWqYOF9EFDFJ6xTaePbwIQjX2kKxaKrl5ZHL7AAvK3LEPXK1sfI76l30+KobWT
X-Gm-Gg: AYBFou0VTKEl6oqowY1pUi2BPjvugs4h1BOtzXvVOacqU5D7PAjfyYhqzixVJeKbUP7
 y5gUcF5hgKN4gCksyQtKvbdI57E+lAVPEDexAJy/l4jd6Rqk5pAr4xpZW8HvQJyhXdO2N/Ys3S1
 KTdxfveOSpJwhUAKHoCZXpqN5NQWyQalbIiE8Ldzzm9Ho1pnaXGVeJyrn2fSKSFv7QiOjkERFUw
 ZDVl4YakmDDzjYs/X7jsuB4FRzlRrVw4rmPbKOocdUjCtErL7GnpB1Sm4rtZDjwu4aJ54zP5SKl
 eqwutvEMz9rFh2oxnmplu2hyTnrv6Swsdb9wYzAmkdZGZffCPLuf1KGax66kE7YhUmThA6VJbLC
 ArfGqgAeHP/chX89PeX4rCDzkYP/fc+dDOvqE7uvKHfqWtLA7FIC+fEyOGydiuQ0Dp1rLL118ns
 J7udeVe68edbIbgr682EPIWqEBjAO/yDNgnQ3ToaQ4r9iVq3OqDuRoayc0rGX1N5CMJcN38hBJ6
 od03ViNfb7FM5UEt2P6i0c+X8K2GHk5g/WxRwcOXGHeeQ==
X-Received: by 2002:a05:6000:2905:b0:48b:1119:5756 with SMTP id
 ffacd0b85a97d-48dbaceab8fmr14473744f8f.17.1791818402274; 
 Mon, 12 Oct 2026 08:20:02 -0700 (PDT)
Received: from localhost (89-93-216-19.hfc.dyn.abo.bbox.fr. [89.93.216.19])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-48de0514ab1sm171427f8f.0.2026.10.12.08.20.01
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 12 Oct 2026 08:20:01 -0700 (PDT)
Date: Mon, 12 Oct 2026 16:32:20 +0200
Subject: [PATCH v2 27/50] tests/qtest: ds1339: cover the end-of-month rollover
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261012-bmc-minerva-v2-27-4c3dff084ec9@free.fr>
References: <20261012-bmc-minerva-v2-0-4c3dff084ec9@free.fr>
In-Reply-To: <20261012-bmc-minerva-v2-0-4c3dff084ec9@free.fr>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1791815521; l=3753;
 i=emmanuel.blot@free.fr; s=20260602; h=from:subject:message-id;
 bh=X7KAfuckHBZBi2zykYy65RlVdT/TDTky7m/n0BwbF7w=;
 b=nwYCQgJ5SfEK46aZJb/XOfwFTrra1+YZItemSS7wsljzlFE5XHwx4hgBbR7+4Io1qsruofT7n
 umf5bfvNsK8CB5k0bBZEOKSp7de+rUHEjgu4CscyW3VMPCGkJjvg9h3
X-Developer-Key: i=emmanuel.blot@free.fr; a=ed25519;
 pk=0qFrZ21FAAN8OfVsSoVcCFTk/NMYOWzxJz4paSAVm0g=
Received-SPF: pass client-ip=209.85.221.44; envelope-from=eblot.ml@gmail.com;
 helo=mail-wr1-f44.google.com
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
2.50.1


