Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 673FACC6B30
	for <qemu-devel@archiver.kernel.org>; Thu, 15 Oct 2026 10:32:59 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xHIiO-0008Ka-VL; Thu, 15 Oct 2026 06:29:40 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eblot.ml@gmail.com>)
 id 1xHIgE-0003zI-Fa
 for qemu-devel@nongnu.org; Thu, 15 Oct 2026 06:27:25 -0400
Received: from mail-wr1-f49.google.com ([209.85.221.49])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <eblot.ml@gmail.com>)
 id 1xHIgB-00045u-Dg
 for qemu-devel@nongnu.org; Thu, 15 Oct 2026 06:27:22 -0400
Received: by mail-wr1-f49.google.com with SMTP id
 ffacd0b85a97d-48441a2ba1bso868734f8f.1
 for <qemu-devel@nongnu.org>; Thu, 15 Oct 2026 03:27:19 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792060038; x=1792664838;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=D3hF72qvu3mgNYGBtKwkXMBkTiV/O1VMMDWIM4mwyd4=;
 b=fwD1gshyIXfl2lyEcKADAG15bju++BEL5fIrkMdWOliL6OfccgrG/zK2ulsYKkRjNy
 tZ6zVz9N3xKSVoqxFwFnwWEDBE5JXpTiWnWYYpoM3bPZJtPXEewug9yrpxD9WCR+o42/
 iRc8vhK9hoDzw1PklWAdUPY5cHMURI5UL/oPJXf6shlc7PRFAqQlZXLJ7+7J1BukcS1s
 IT2P9lZRW2Mmx0eVWl6LHHkikG7FlYcTBLwKkmtD4z9DsQfvDuSDyV/HGKkMlgMm7WmZ
 gdzY1NZYQBohdh1dXoB9BJtyOA/N7kj8QyGmYsRYpcK7QxmfzHIfGEe5Hx35r7PJHMVS
 b8KQ==
X-Gm-Message-State: AFq9FYIrSGC6VbRN8vwTPkKuMC9YCpe0APo51UW5pJhhrdexKJleksEU
 09bDt9vgo1DUHdcuWGtoIuOV1qOC97XGf8OA5ortnrXF+xQkBhpRm92YtFLBpw==
X-Gm-Gg: AYBFou1SoswE5FZwHObFbVs1s4rEdZT6BEByR1Sk70u8WfMZjKFjkfpc4ngWTNMT4g8
 hsxAIHMDDZbocjdTwX0A+kST5Osm9swrBvhCK0n2SDnAyFtd+M3yhkh4BeHNxboACX5iIikOTDk
 EWuGpbgrhOx1F58QnojnxWC4rCC7DHwj0c8W1LpB6ZBpHgBcZJ9yM/1OvsXRxl+7/We25qMrE/i
 VQYc3YUsRpG7ETaSUUS/1fMJ7Lqv+20l1KVL6DOd7hvLMBwuo5ROA1uI+3ejmE0NsSAbZTTd1H6
 4BgFzRG/83K04rbgNty4Eyb7A8LxbtpQi6PmHIPahlgruJKQ5pBe+sCJE8f7k4Lg5cNHHjP1Ip/
 LeMoJSC1sekMZaE3X0NYlpNj4mBSFRqJo1UYgHNpD9UeQbtd/TmDP9zUQqQJ3ruOLZUQeGBASqt
 KZeQm35JNCKuSHab2K8Rv7ihqLWn30uAV6o4QbHd5SH+hN5NMcSKXzAPs2r+6c6KNx5+3fDGKaS
 +uRkoszoasgHHAVI9tzoNG6DVXn8Yd+t8OuIcGIdkchPg==
X-Received: by 2002:a05:600c:6215:b0:49f:ff32:8044 with SMTP id
 5b1f17b1804b1-4a18e47a88fmr344547825e9.7.1792060037886; 
 Thu, 15 Oct 2026 03:27:17 -0700 (PDT)
Received: from localhost (89-93-216-19.hfc.dyn.abo.bbox.fr. [89.93.216.19])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4a1bd9a8a22sm67733135e9.5.2026.10.15.03.27.16
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 15 Oct 2026 03:27:16 -0700 (PDT)
Date: Thu, 15 Oct 2026 11:28:15 +0200
Subject: [PATCH v3 28/50] tests/qtest: ds1339: cover the 12-hour format
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261015-bmc-minerva-v3-28-7d50c8a108e5@free.fr>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1792056476; l=3522;
 i=emmanuel.blot@free.fr; s=20260602; h=from:subject:message-id;
 bh=H+2NRBVduAD0kusIRvsLO1TF7emsp4ss30ZRGVmVNhU=;
 b=kgK1KOPriKfBLbra3npt1yfQDCgIZ5Ia6Ofrho6uYIjWiv8TpzKN46QhjNPpHBvqVL30yNJIW
 NTjCTEsudIYDN/W7HJUesZVdgUjISErDmefewuWFeR0ayIImBYX2DXK
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


