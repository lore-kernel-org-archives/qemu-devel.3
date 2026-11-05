Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E2C21606A31B
	for <qemu-devel@archiver.kernel.org>; Thu,  5 Nov 2026 08:59:33 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xOtJF-0006jS-1R; Thu, 05 Nov 2026 03:59:01 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eblot.ml@gmail.com>)
 id 1xOtJB-0006Pr-5K
 for qemu-devel@nongnu.org; Thu, 05 Nov 2026 03:58:57 -0500
Received: from mail-pj1-f48.google.com ([209.85.216.48])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <eblot.ml@gmail.com>)
 id 1xOtJ8-0003qT-S7
 for qemu-devel@nongnu.org; Thu, 05 Nov 2026 03:58:56 -0500
Received: by mail-pj1-f48.google.com with SMTP id
 98e67ed59e1d1-3adc4590de4so1441719a91.2
 for <qemu-devel@nongnu.org>; Thu, 05 Nov 2026 00:58:54 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793869132; x=1794473932;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=D3hF72qvu3mgNYGBtKwkXMBkTiV/O1VMMDWIM4mwyd4=;
 b=axM3X04lUIKfXUNjTxDaGFEig2nlglBou8GsuqnMfrF+n6Retj+DB12n8ATncfIO/F
 MICILNRTfSZgGrPcXhFwV6oCUphzSa1WILdVidBfGN8GsfG8/vrSQSJdxTDQ3QLOM6D4
 Bzu1Ytd6GtTkIiu0e1CC9I9XwEkhI4qVTdEdMAKEXnv6o0kRIa3UahLdcDyKPIl0CmTD
 VL+67s6qFAVj/hSi0cdBGlHl0ZQH1R7mvLDW6PhP/TFYMuJkak3o6+HuVV0XBUoROQ9l
 N720UeQL/ZMXZa/eTpkRcItExBOoSvMoNoWYkPavp9UGhmVJu4s0Fnnwvp70d+My7N0A
 o5+g==
X-Gm-Message-State: APuU4Z8CuNeK/d6dfryRPoI8UfjOkbNsgGG19RUYQF18o0qSI7IGsRXA
 /cZR7/l/sD2MhPcjU50wqas/K0HeqmvfbbDQQ7jkzufbDCuMgHk6LW7WB1wjzGMnFuo=
X-Gm-Gg: AYBFou3g9FJ0O1802Oe1FJZRZTJPIrwApQuPJE1ZsUlUooxkEcuk4ZQ4sp6WzSNWrYB
 QzEvBxj+E21mKdduP0fEQa7bCXbi7ZqH6gDGkqZxFkRzefKTctWIBu/oAb4fypTUv2p0C4Sp+fN
 MflaFWrWeBgL0QV/J1mb0nvIGhk+b+Mq/L0vE6xLWv7x10h4cuPm0aLUolIRE53q3c02NtPLVQs
 8MVbGRpRuJE0aGpeWwlp1YGV4pRssU16VQFS4PpDNedbv/9Gh1JUcIL8gQETR3J5zI3qL4uvI/V
 lDqmKHDZ8u62S3A43rfFsG9WdS/TrfdRwXHJlRi9l9jTsxbcfpNpVqlKqzTQkhFdxD1rixuQ8Kh
 z87foBqFkgdJKEA8BCAcxjilXp4aPRLLLwXz318avaehSPiBMrUrQzGJ2cuRQ5TGbv/CmAOav8J
 3nkzP4KN1RBxRgCBpNikYe5ZUFzWUYesrCYf0U32GeOmVtCNzFTs7dDEhDFcvPYmunwS0Ti8l9p
 ftdh9vJ9wAwyreGIFtxePyKitGEkKW5bw2T6uAZXQoAlNBIdqXLmMHSA1PlHKBJPq9dgb4sYY1z
 czU0+L+Ihl0fNDvqC0/2o2eN/BFWMD5nohID3XSLRhT1BrEar6lShEdLZ2Ylx2bEEAd46HIPmni
 b+kLiVQ==
X-Received: by 2002:a17:90b:28c3:b0:3b0:ae41:2707 with SMTP id
 98e67ed59e1d1-3b0ae41298bmr2190428a91.45.1793869132267; 
 Thu, 05 Nov 2026 00:58:52 -0800 (PST)
Received: from localhost (118-163-122-149.hinet-ip.hinet.net.
 [118.163.122.149]) by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-3b0b32678ecsm3136610a91.9.2026.11.05.00.58.51
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 05 Nov 2026 00:58:51 -0800 (PST)
Date: Thu, 05 Nov 2026 16:50:52 +0800
Subject: [PATCH 16/19] tests/qtest: ds1339: cover the 12-hour format
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261105-rtc-ds1339-v1-16-50a8dc463ee8@free.fr>
References: <20261105-rtc-ds1339-v1-0-50a8dc463ee8@free.fr>
In-Reply-To: <20261105-rtc-ds1339-v1-0-50a8dc463ee8@free.fr>
To: qemu-devel@nongnu.org
Cc: =?utf-8?q?C=C3=A9dric_Le_Goater?= <clg@kaod.org>, 
 Fabiano Rosas <farosas@suse.de>, Laurent Vivier <lvivier@redhat.com>, 
 Paolo Bonzini <pbonzini@redhat.com>, eblot@meta.com, 
 Emmanuel Blot <emmanuel.blot@free.fr>
X-Mailer: b4 0.16.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1793868640; l=3522;
 i=emmanuel.blot@free.fr; s=20260602; h=from:subject:message-id;
 bh=H+2NRBVduAD0kusIRvsLO1TF7emsp4ss30ZRGVmVNhU=;
 b=gIUjxoRzKDS0r9jgzfLmn02mP+6bFwZNVGEqs4tVQCy/KXUmq69cirw/B1ihnpEwtHW4c3msB
 iTfRXr5V9V4ASOdqQrP81F1+qpUeykuJv/IuqJeib4Gj9OmhBQbWSeL
X-Developer-Key: i=emmanuel.blot@free.fr; a=ed25519;
 pk=0qFrZ21FAAN8OfVsSoVcCFTk/NMYOWzxJz4paSAVm0g=
Received-SPF: pass client-ip=209.85.216.48; envelope-from=eblot.ml@gmail.com;
 helo=mail-pj1-f48.google.com
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

Both directions of the 12-hour conversion carry a fixup for midnight
and noon, and neither had been exercised.

Signed-off-by: Emmanuel Blot <emmanuel.blot@free.fr>
---
 tests/qtest/ds1339-test.c | 45 +++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 45 insertions(+)

diff --git a/tests/qtest/ds1339-test.c b/tests/qtest/ds1339-test.c
index 7eec163049..3259fa1df3 100644
--- a/tests/qtest/ds1339-test.c
+++ b/tests/qtest/ds1339-test.c
@@ -14,6 +14,7 @@
 
 /* DS1339 register map */
 #define DS1339_SECONDS   0x00
+#define DS1339_HOURS     0x02
 #define DS1339_DATE      0x04
 #define DS1339_MONTH     0x05
 #define DS1339_YEAR      0x06
@@ -26,6 +27,9 @@
 
 #define DS1339_STATUS_OSF 0x80
 
+#define DS1339_HOURS_12  0x40
+#define DS1339_HOURS_PM  0x20
+
 /* The clock and calendar come up on the host time. */
 static void test_time(void *obj, void *data, QGuestAllocator *alloc)
 {
@@ -170,6 +174,46 @@ static void test_eosc_restart(void *obj, void *data, QGuestAllocator *alloc)
     g_assert_cmphex(resp[6], ==, 0x31);
 }
 
+/* Midnight and noon are the hours the 12-hour encoding special-cases. */
+static void test_hour_mode_12(void *obj, void *data, QGuestAllocator *alloc)
+{
+    QI2CDevice *i2cdev = (QI2CDevice *)obj;
+    const uint8_t tod[3] = {
+        0x59, 0x59, DS1339_HOURS_12 | DS1339_HOURS_PM | 0x11 /* 11:59:59 PM */
+    };
+    unsigned idx;
+
+    i2c_set8(i2cdev, DS1339_HOURS, DS1339_HOURS_12 | 0x12);
+    g_assert_cmphex(i2c_get8(i2cdev, DS1339_HOURS), ==,
+                    DS1339_HOURS_12 | 0x12);          /* 12 AM is midnight */
+
+    i2c_set8(i2cdev, DS1339_HOURS, DS1339_HOURS_12 | DS1339_HOURS_PM | 0x12);
+    g_assert_cmphex(i2c_get8(i2cdev, DS1339_HOURS), ==,
+                    DS1339_HOURS_12 | DS1339_HOURS_PM | 0x12); /* 12 PM noon */
+
+    i2c_set8(i2cdev, DS1339_HOURS, DS1339_HOURS_12 | DS1339_HOURS_PM | 0x01);
+    g_assert_cmphex(i2c_get8(i2cdev, DS1339_HOURS), ==,
+                    DS1339_HOURS_12 | DS1339_HOURS_PM | 0x01);
+
+    i2c_set8(i2cdev, DS1339_HOURS, DS1339_HOURS_12 | 0x11);
+    g_assert_cmphex(i2c_get8(i2cdev, DS1339_HOURS), ==,
+                    DS1339_HOURS_12 | 0x11);
+
+    i2c_set8(i2cdev, DS1339_HOURS, 0x13);
+    g_assert_cmphex(i2c_get8(i2cdev, DS1339_HOURS), ==, 0x13);
+
+    /* An elapsed midnight moves 11 PM on to 12 AM, not to 00 or 13. */
+    i2c_write_block(i2cdev, DS1339_SECONDS, tod, sizeof(tod));
+    for (idx = 0; idx < 50; idx++) {
+        if (i2c_get8(i2cdev, DS1339_HOURS) != tod[2]) {
+            break;
+        }
+        g_usleep(100 * 1000);
+    }
+    g_assert_cmphex(i2c_get8(i2cdev, DS1339_HOURS), ==,
+                    DS1339_HOURS_12 | 0x12);
+}
+
 /* Program 23:59:59 on the last day of a month and run the clock past it. */
 static void check_month_rollover(QI2CDevice *i2cdev,
                                  uint8_t date, uint8_t month, uint8_t year,
@@ -370,6 +414,7 @@ static void ds1339_register_nodes(void)
     qos_add_test("eosc-restart", "ds1339", test_eosc_restart, NULL);
     qos_add_test("stopped-reserved-bits", "ds1339",
                  test_stopped_reserved_bits, NULL);
+    qos_add_test("hour-mode-12", "ds1339", test_hour_mode_12, NULL);
     qos_add_test("month-28-days", "ds1339", test_month_28_days, NULL);
     qos_add_test("month-29-days", "ds1339", test_month_29_days, NULL);
     qos_add_test("month-30-days", "ds1339", test_month_30_days, NULL);

-- 
2.53.0-Meta


