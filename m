Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7177D606A31B
	for <qemu-devel@archiver.kernel.org>; Thu,  5 Nov 2026 08:58:11 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xOtI2-0003TV-6q; Thu, 05 Nov 2026 03:57:46 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eblot.ml@gmail.com>)
 id 1xOtI0-0003Re-F9
 for qemu-devel@nongnu.org; Thu, 05 Nov 2026 03:57:44 -0500
Received: from mail-pl1-f180.google.com ([209.85.214.180])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <eblot.ml@gmail.com>)
 id 1xOtHy-0003jN-Ks
 for qemu-devel@nongnu.org; Thu, 05 Nov 2026 03:57:44 -0500
Received: by mail-pl1-f180.google.com with SMTP id
 d9443c01a7336-2e96502e447so13903215ad.1
 for <qemu-devel@nongnu.org>; Thu, 05 Nov 2026 00:57:42 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793869061; x=1794473861;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=QSX7oFL3j7413Q4nQT+SGQuVL91uJZdU8V0ijp2OEps=;
 b=CQz9jjT+Kd73bDYu8LQdyTnh6YlaFa/ECcLKg5k1AyLUnGqMlpyVNbdqofD360pkRa
 XYMf7+yc1q4K3ZdwlGUbEqvKUC3p3gx2jqQ2Hz7W78Z2iYRBj3bqWppyNiLToR6V+oXO
 ZGEKEdmCrSLkdZt5jdmcr01Yy5rA6Vc6EWPvJ6RYDhOICk8N4BMZnYaoZXqYRUrbdjMm
 LcE3J/qPeXaHYqMMtNoWKnxmeL+TyYdKsDySvAxVWTOnr0e2d+yOv5hTyVupZbvaCN+Z
 RJiKICEq5GnzFUhyaGEDEOHT+lc5T23SmZaXIBBzZcP/v4Xgiwat5lfnkFM5dHoRlGbF
 Cxmw==
X-Gm-Message-State: APuU4Z9bLlmetJiZkzrE+5/JFgr57OJNu7HYRRflmpcPN5j37Iab9dJk
 lHp9qCchhN+leUnP1JESHqXU97eNtQFqEFj2VDfzV2zGspFi1y0OXfSuxk2uAOtAAJ4=
X-Gm-Gg: AYBFou1u/KBGCWAo1RFvtmSsczvv/M9rQYHLe2BSgtkPX9KUdbYoPb/QxYkYub9e37v
 UGe2oP5FRzmpm26IJVTTaqvrLdZC+Ly2+U2OZIBwQb/ObrOx645Xr7Ffr07uxFKEAmZOjBKicxg
 JmJu3NbgHfnG197C3j7xl2gt1LUXJFEZGZjmrjVb7dvwOPR4usm4xv9B7JZKy4zwKzRu58/SUJE
 NvLClqBXeErvN7mG0iDFIijUvONCo5PNunguPP1Xqb9Uvpjqv1ml7bPSepD3isIDPppaCnvPtJQ
 jjNgRKlRGv2EXfxNBABLq6MhvnySuPlWyTju1etwwislMUz3d9uWXrYIONSePZH0Dd5gxU/XE3v
 fKFZQOjE6RLTD+B6hrbREifyPyFW01Fo6Z8Z2tzYt8hL1Rxf4XA3ZCHl2RLZGF/PAp9jg8DbCcN
 27Wn4LG2C3/KiDRDO0LLgZQQmmxPRT8yZKniUZd4n7BUvdRSauYLjR9ooQU6DBGYUPsO3cx+Sju
 xEcKxBOolWP6zgGg4VaRu1OGswLiga6fq2H3eOTcoMpquPqs1wYjwIox1PnKalzj6k06H+kvhMS
 f2q3tAv3lvkeLJ47HGiAhajrhXu3MzFEq1W7Ro5V9USMYIQ9DvQ8b3XMmgwwGKwGiqVyzFAroOn
 nIzj72A==
X-Received: by 2002:a17:902:ec90:b0:2e8:1910:e398 with SMTP id
 d9443c01a7336-2eb3649bf6amr187321315ad.9.1793869060817; 
 Thu, 05 Nov 2026 00:57:40 -0800 (PST)
Received: from localhost (118-163-122-149.hinet-ip.hinet.net.
 [118.163.122.149]) by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2ed0906175bsm15699265ad.27.2026.11.05.00.57.40
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 05 Nov 2026 00:57:40 -0800 (PST)
Date: Thu, 05 Nov 2026 16:50:43 +0800
Subject: [PATCH 07/19] tests/qtest: ds1338: cover the clock-halt bit
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261105-rtc-ds1339-v1-7-50a8dc463ee8@free.fr>
References: <20261105-rtc-ds1339-v1-0-50a8dc463ee8@free.fr>
In-Reply-To: <20261105-rtc-ds1339-v1-0-50a8dc463ee8@free.fr>
To: qemu-devel@nongnu.org
Cc: =?utf-8?q?C=C3=A9dric_Le_Goater?= <clg@kaod.org>, 
 Fabiano Rosas <farosas@suse.de>, Laurent Vivier <lvivier@redhat.com>, 
 Paolo Bonzini <pbonzini@redhat.com>, eblot@meta.com, 
 Emmanuel Blot <emmanuel.blot@free.fr>
X-Mailer: b4 0.16.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1793868640; l=2998;
 i=emmanuel.blot@free.fr; s=20260602; h=from:subject:message-id;
 bh=ZuX+spACHMjQ3cHCqU6XOjJREiGhA+BBWl2nnVGddEk=;
 b=iB0UPmJGsAbiIGYduo3YMEceUwkNmXgz5aYh98m6vjvwTeFiV2iTlRfj+XH7ZpM5MayC9LLbU
 eLpkqAV2nH3A2fCG+fJJTqiolQENZTRjDmxCVuPr15FHDuB0+ST7otO
X-Developer-Key: i=emmanuel.blot@free.fr; a=ed25519;
 pk=0qFrZ21FAAN8OfVsSoVcCFTk/NMYOWzxJz4paSAVm0g=
Received-SPF: pass client-ip=209.85.214.180; envelope-from=eblot.ml@gmail.com;
 helo=mail-pl1-f180.google.com
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

The clock-halt bit had no coverage, nor did its effect on the
oscillator-stop flag.

Signed-off-by: Emmanuel Blot <emmanuel.blot@free.fr>
---
 tests/qtest/ds1338-test.c | 38 ++++++++++++++++++++++++++++++++++++++
 1 file changed, 38 insertions(+)

diff --git a/tests/qtest/ds1338-test.c b/tests/qtest/ds1338-test.c
index fad0ca53d4..1b73dca98d 100644
--- a/tests/qtest/ds1338-test.c
+++ b/tests/qtest/ds1338-test.c
@@ -32,6 +32,7 @@
 
 #define DS1338_CTRL_OSF  0x20
 #define DS1338_CTRL_POR  0xb3
+#define DS1338_SEC_CH    0x80
 
 /* The clock and calendar come up on the host time. */
 static void send_and_receive(void *obj, void *data, QGuestAllocator *alloc)
@@ -85,6 +86,42 @@ static void test_osf_write_protect(void *obj, void *data,
     g_assert_cmphex(i2c_get8(i2cdev, DS1338_CONTROL) & DS1338_CTRL_OSF, ==, 0);
 }
 
+/* Halting the clock freezes the counters; clearing the halt resumes them. */
+static void test_clock_halt(void *obj, void *data, QGuestAllocator *alloc)
+{
+    QI2CDevice *i2cdev = (QI2CDevice *)obj;
+    uint8_t frozen[7], again[7];
+    unsigned idx;
+
+    /* Clear OSF first, so that halting the clock is what sets it again. */
+    i2c_set8(i2cdev, DS1338_CONTROL, 0x00);
+    g_assert_cmphex(i2c_get8(i2cdev, DS1338_CONTROL) & DS1338_CTRL_OSF, ==, 0);
+
+    i2c_set8(i2cdev, DS1338_SECONDS, DS1338_SEC_CH | 0x30);
+    g_assert_cmphex(i2c_get8(i2cdev, DS1338_SECONDS), ==,
+                    DS1338_SEC_CH | 0x30);
+    g_assert_cmphex(i2c_get8(i2cdev, DS1338_CONTROL) & DS1338_CTRL_OSF,
+                    ==, DS1338_CTRL_OSF);
+
+    i2c_read_block(i2cdev, DS1338_SECONDS, frozen, sizeof(frozen));
+    g_usleep(1200 * 1000);
+    i2c_read_block(i2cdev, DS1338_SECONDS, again, sizeof(again));
+    g_assert_cmpmem(frozen, sizeof(frozen), again, sizeof(again));
+
+    i2c_set8(i2cdev, DS1338_SECONDS, 0x30);
+    g_assert_cmphex(i2c_get8(i2cdev, DS1338_SECONDS) & DS1338_SEC_CH, ==, 0);
+    for (idx = 0; idx < 50; idx++) {
+        if (i2c_get8(i2cdev, DS1338_SECONDS) != 0x30) {
+            break;
+        }
+        g_usleep(100 * 1000);
+    }
+    g_assert_cmpuint(from_bcd(i2c_get8(i2cdev, DS1338_SECONDS)), >, 30);
+
+    g_assert_cmphex(i2c_get8(i2cdev, DS1338_CONTROL) & DS1338_CTRL_OSF,
+                    ==, DS1338_CTRL_OSF);
+}
+
 /* The user RAM returns what the guest wrote to it. */
 static void test_nvram(void *obj, void *data, QGuestAllocator *alloc)
 {
@@ -122,6 +159,7 @@ static void ds1338_register_nodes(void)
     qos_add_test("reset-defaults", "ds1338", test_reset_defaults, NULL);
     qos_add_test("control-register", "ds1338", test_control_register, NULL);
     qos_add_test("osf-write-protect", "ds1338", test_osf_write_protect, NULL);
+    qos_add_test("clock-halt", "ds1338", test_clock_halt, NULL);
     qos_add_test("nvram", "ds1338", test_nvram, NULL);
     qos_add_test("address-wrap", "ds1338", test_address_wrap, NULL);
 }

-- 
2.53.0-Meta


