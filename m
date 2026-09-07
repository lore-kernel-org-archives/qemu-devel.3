Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 82E3DC79FA1
	for <qemu-devel@archiver.kernel.org>; Mon,  7 Sep 2026 16:48:06 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x3cVn-000302-RX; Mon, 07 Sep 2026 12:48:03 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eblot.ml@gmail.com>)
 id 1x3cVl-0002na-CO
 for qemu-devel@nongnu.org; Mon, 07 Sep 2026 12:48:01 -0400
Received: from mail-wm1-f43.google.com ([209.85.128.43])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <eblot.ml@gmail.com>)
 id 1x3cVi-0003uF-8V
 for qemu-devel@nongnu.org; Mon, 07 Sep 2026 12:48:01 -0400
Received: by mail-wm1-f43.google.com with SMTP id
 5b1f17b1804b1-49d0da752ffso16174445e9.3
 for <qemu-devel@nongnu.org>; Mon, 07 Sep 2026 09:47:57 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1788799676; x=1789404476;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=LphZT+IzejkArL3oUvhqeY3sCcOug01WUt4J0/5+FMM=;
 b=aVlNgXYvkPwVStCFeL85xxIBvd1973s0u6h/KagsDibfxWXgtqHzG71yrAvTUghO0X
 i+921k8sfnfYKkgcW6YSdxrzotgeXICtfgDrk9IRwwVyQhlMmf5SQFCvbqQOlUBz+ddf
 MJOyw0x5ESNIhifC9nbtkhZJrB0w7543CjQsBcOdwowAxWbLdtTAftJFc/EtdCBiP0bz
 nOwGzd5KWwQpwl4GgGSDkQP5zypuzQDqHxsLv11Q9RrXjklPZSKf56Xavx73ZZWqwGVu
 vt1hxJ9QNPqEBQNVFLVx0T8Gbs17aBDCdYSiNGksLTc/lAUibRS75POeOHJcNI39LGYq
 7KNA==
X-Gm-Message-State: AFuF++mY/4sLpWSJgkW45dnRlEcb+RI4lYQ8+c5mAb2O4o+1zCTIv5cd
 jEae9/Nqa3l3LMucbpUic+0U/sHW0aMVFQMcjxnB5fc+hr8FSVpuuHtJSxRkwSBl
X-Gm-Gg: AYBFou1TuYGmmwqJ3Tv1eloaQFnO/y10YQGcwQs0baIs1XAaQGIezMRBv4yaRLnSl+W
 dYh5qj+iuQwwfVW2J0ORHxEblE1YIHxmZrc1jjY+YIJukba6BzRDj6Ulqpb2eUuNW+VwK2HtZPh
 9XVeyG/vZoJ/4d4rwxSK/hf/4vIkPMFMCRPRr85VI37E3OpGdAz4zm4UO6uJC3lXCjskadnsjlC
 IbIPcyfJxwNNK/vf3v+CqxpJFqvBXNwuCS8WLn1UbvRbxwbDUeTIf/xlwTTCDJBwj6k7BACjwzZ
 8N+OQUnehQ2yOCiw7sbzLqDdytjG6/gmSZ5akK0meDsxkNFALY2QoK55IOOVSTcbv3V0tMLKWnd
 VvRO+kT08qwpfy+TPzT9M/xVBTWIOSDlniLgWXiVjo/FEP5unwfJ1yeQNPi4Jz1b+xkJmce4MBU
 mWiMoSglBeNzp7hgFdsDbrdB67/eAWdk9nJCJScQOiXqhgBqishM0LMVS2J7czhUlxlXMhjOyrX
 hbhSeWU70koVTOXMMAmHSvz7PhZchAegRg=
X-Received: by 2002:a05:600c:4714:b0:49d:462:6eda with SMTP id
 5b1f17b1804b1-49d04627387mr147409055e9.28.1788799676293; 
 Mon, 07 Sep 2026 09:47:56 -0700 (PDT)
Received: from localhost (89-93-216-19.hfc.dyn.abo.bbox.fr. [89.93.216.19])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-49d00a5b19dsm256272105e9.2.2026.09.07.09.47.54
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 07 Sep 2026 09:47:55 -0700 (PDT)
Date: Mon, 07 Sep 2026 18:42:18 +0200
Subject: [PATCH 28/50] tests/qtest: ds1339: cover the 12-hour format
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260907-bmc-minerva-v1-28-0d83ad610c3b@free.fr>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1788799321; l=3517;
 i=emmanuel.blot@free.fr; s=20260602; h=from:subject:message-id;
 bh=d52DOv2V3QB3CGvMZYkl6mYb22coBmAW9Fq+mpMglf8=;
 b=8YgWFhQAHFckAd2VW3wFUmavs5Bco2/obcvgu7M/qizAK5VPt6XBRsk08kjKwkLhWfijPK4Y2
 8pQQ88Q1t3YC4kI6csgDojdwBWslTEvHTHBOUQoQtO+YnxF+6vyMBKB
X-Developer-Key: i=emmanuel.blot@free.fr; a=ed25519;
 pk=0qFrZ21FAAN8OfVsSoVcCFTk/NMYOWzxJz4paSAVm0g=
Received-SPF: pass client-ip=209.85.128.43; envelope-from=eblot.ml@gmail.com;
 helo=mail-wm1-f43.google.com
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
2.50.1


