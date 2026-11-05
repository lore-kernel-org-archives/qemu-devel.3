Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6BA4D606A31B
	for <qemu-devel@archiver.kernel.org>; Thu,  5 Nov 2026 08:59:10 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xOtJL-0007IN-Cj; Thu, 05 Nov 2026 03:59:07 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eblot.ml@gmail.com>)
 id 1xOtJH-0006zj-VY
 for qemu-devel@nongnu.org; Thu, 05 Nov 2026 03:59:04 -0500
Received: from mail-pj1-f45.google.com ([209.85.216.45])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <eblot.ml@gmail.com>)
 id 1xOtJF-0003rL-T3
 for qemu-devel@nongnu.org; Thu, 05 Nov 2026 03:59:03 -0500
Received: by mail-pj1-f45.google.com with SMTP id
 98e67ed59e1d1-3ab41538192so1358952a91.0
 for <qemu-devel@nongnu.org>; Thu, 05 Nov 2026 00:59:01 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793869139; x=1794473939;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=imFMkJM4Su/meWF7Bk/irxYZZDqQDWRnzR3YhZvsMNY=;
 b=SoWI1sERSMXCROdS2G5IvZZJvZMfkyykF8himYT/4B8xDKR+cnmXe+OZEvZGmeSR/V
 c+ZbyuA6VhL3E/uZQHiOU6BE+8ZEoL5nXfqfI5Va/Gx9l1v6AO58Y19PTxpIGKHqT5ab
 B8i040gaurAa01hbNnGzAi1PU3w4mgaC2sE+qWixJdtpBK1/mrzUCiGT1LmpcrPEcTAd
 F/Rewi3tDjwlQVWb5ywTe/e7bZZSnKbsjlyzWapeFygo+wshRsRU856BGjHzrHs7ue27
 ziIXHBReFbb9lp6FG2Heq88ylKwMRuSsXN23TdJ4A+OZntn3adeAh7X6BUCqjAQpYcQF
 6/7w==
X-Gm-Message-State: APuU4Z/dEV2RFfIjd3ruDVKrTethPEOezs3j3O+Oq4IuUPG5pErTzjro
 KCCbuHH03d1FUaQVRNXVgkj2HoWmRVm2d7EFD4pl+ajmkWU5MFPRtimrgrRZjKyTF2E=
X-Gm-Gg: AYBFou3tmngmUTNPyHDAvicFPI0VjI7Fz+G/wsCqn6TrGOklWXr4RFGYRCwRA5bCTpT
 wWq5vmQb0Sr/OzwcIqsh1ZocStlfNvuDlSzOXkLKTSym7wgXYpwCwRA2OjWMNPIMLv37HkyIARM
 m55hZY/5RASdbf0+FY+YWzV1weYZhylOk9Dhe96OkhH58OJfSYTT2kIl3Tt0aM6fcTrgZTEwxmx
 MFeBUAIwzEdxT/zAQCRqT2ZMz0QuBu4ryuniP3TrOiDkv0dSWdfGHiH7NfOkQN1WkOiBQlnyMeg
 dIQMFijaFd0b6CDAktRfnHTnXCDOBA/yCi3l1tQQTSTjzwMA4IvhAn8VrQ7OHcHZiDl188Q9cDl
 aLIwzpRx2sp00V3q5UwP/CjwTbiOXqHGAJRocfXgjN71BzU7hgGlDZZOTHjwBF9eojA0JJi328K
 izT8tTD0eXpIjXdyLmb8oHMD6t3rjNW3rIPLdISbF7myiHJ61ao0DlsYctsOKuYsTvBhLqJw5XQ
 AYp+wwMGoPUSFZFA7k1MZ3C/pj4VNS3NMoDyOaJBSybJLhzC74o43CwH56elF5HEIAlYCG6J4Kx
 BldT+GW4ZM0c/k8Z3O4+KtzVBtnQL+d9mjxv/9RVTd5XHXWuudzKGZhBYYh16gk4kyqywx+F2bD
 AND4TEQ==
X-Received: by 2002:a17:90b:4d85:b0:3b0:a378:1cf with SMTP id
 98e67ed59e1d1-3b0a378049cmr2988421a91.22.1793869139290; 
 Thu, 05 Nov 2026 00:58:59 -0800 (PST)
Received: from localhost (118-163-122-149.hinet-ip.hinet.net.
 [118.163.122.149]) by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-3b0b313c143sm2912122a91.2.2026.11.05.00.58.58
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 05 Nov 2026 00:58:58 -0800 (PST)
Date: Thu, 05 Nov 2026 16:50:53 +0800
Subject: [PATCH 17/19] tests/qtest: ds1339: cover the day-of-week counter
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261105-rtc-ds1339-v1-17-50a8dc463ee8@free.fr>
References: <20261105-rtc-ds1339-v1-0-50a8dc463ee8@free.fr>
In-Reply-To: <20261105-rtc-ds1339-v1-0-50a8dc463ee8@free.fr>
To: qemu-devel@nongnu.org
Cc: =?utf-8?q?C=C3=A9dric_Le_Goater?= <clg@kaod.org>, 
 Fabiano Rosas <farosas@suse.de>, Laurent Vivier <lvivier@redhat.com>, 
 Paolo Bonzini <pbonzini@redhat.com>, eblot@meta.com, 
 Emmanuel Blot <emmanuel.blot@free.fr>
X-Mailer: b4 0.16.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1793868640; l=2635;
 i=emmanuel.blot@free.fr; s=20260602; h=from:subject:message-id;
 bh=eyo+ejkyIwGpn53A6NDRDtcAT+GA1L3xUgmQjCv7Q5U=;
 b=zhPRDSo2ujJgQ9oQZNK7SLcFBa/Q1z1VOoCTrgUam58E6o7BDfq9EGvF/LCCLM8287s3ElFjn
 hEHCpgP0L9HCuHpdUqUOd948R0RBToIBqaOrY1yMfO07vBP8+R/XN5o
X-Developer-Key: i=emmanuel.blot@free.fr; a=ed25519;
 pk=0qFrZ21FAAN8OfVsSoVcCFTk/NMYOWzxJz4paSAVm0g=
Received-SPF: pass client-ip=209.85.216.45; envelope-from=eblot.ml@gmail.com;
 helo=mail-pj1-f45.google.com
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


