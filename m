Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A73A606A31B
	for <qemu-devel@archiver.kernel.org>; Thu,  5 Nov 2026 08:58:47 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xOtIe-0004Nm-5V; Thu, 05 Nov 2026 03:58:26 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eblot.ml@gmail.com>)
 id 1xOtIX-0004AA-3m
 for qemu-devel@nongnu.org; Thu, 05 Nov 2026 03:58:18 -0500
Received: from mail-pg1-f169.google.com ([209.85.215.169])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <eblot.ml@gmail.com>)
 id 1xOtIU-0003lu-Gy
 for qemu-devel@nongnu.org; Thu, 05 Nov 2026 03:58:16 -0500
Received: by mail-pg1-f169.google.com with SMTP id
 41be03b00d2f7-cd8ba7c2694so621780a12.1
 for <qemu-devel@nongnu.org>; Thu, 05 Nov 2026 00:58:14 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793869092; x=1794473892;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=f+J/E7rlsF4ENqt+oSs16NilK9Jn/qUNnLTlrU6QonQ=;
 b=IYNX/PV1BUSUxJKDARebUoXAMlmRR13D4QCjW/VI4M02kddpRSvWOtoev73XaNX/Dq
 iz1tFSVqcEH4YmFm6ULel7kyOPIZHoQtAApzUs8TbeP9rFJOo1+3v2zgPDbmcCm4NOc9
 fkJPAmVqWcUdcz8u52eS8YP5z6xb07xsvDd1Nzpc51d21DqT5bbIQicatPDrndZJselK
 UqK4/whtvpqWCWWN6EyTekM4tZ3qTMUl4imEP2LfJqNwDp9oMXg6mirvfFZZwmjTQdU2
 C8o83AwAflUzER6/JFt1cAP0/r7abxzfTzF4oHjP6PgukrKRvISu8mTR6QkQWjVvFGZm
 kdlw==
X-Gm-Message-State: APuU4Z+E6LU8i5V3nQYpBUcN7wuo33To+u0vvxkOWWf604EmA0+wnr1t
 pwh/9M2jlXHO6yYthbjMiM+1yd/ukVFtOcoBxyH9H8ur6gzp9lCUY4yxCVykFeO6SLc=
X-Gm-Gg: AYBFou3zNXyhPz1kp4crFhDNr5YFHqtxvgLMlZSExk2ct8MsmuJKFSmbuK2IkdRm0r0
 u0Xqk0GcOZWsVx7eLYbR7r4xaQMrBIARB5Rmiy1/GOZVcI+wrYjoI4EnT68sY8aFgjDKnTx54ju
 s3RQ1linmr4er/GLxN++98/P3DWgj9Di+B7HJjICrV3iurqMrfXCWSELWDru28oLLFYgMPSvp7o
 7XWfffhc4gx42sp9PwnoA+AKnfRmX+fXxWF6pmBn0kKsgXtJp4wGEtV2eb2R31QX48HL7yEOpb8
 Xw3NJcpJx77Yy/sQSR0C2ToVbhrZD4tC+KM7rNqEesCQZl0JmmaSynH1vSJ0AUI2tuSywuv+I50
 FGbPGYm0nqMh8KvY+N8o6ibI3tXjz1fpCS6m/W7WKTpwtC2ATxCjzFafCJ0VkGkFjsZQmsq/Co4
 kV/CWVsSzkyZx0/mxF6lJ2p9Lb0IUC/KoQ+wCMwUWhObe6imWDfz1+CZ4xBoz5vyXisuOuDAE/S
 aGFlpb5UA/qh/zmOWYcRQg1Ds5At+P2GliDUwHCj6RJsChFV4HLPsWN2VyVfyFwtDsbfa+h/K7d
 BtqtJxyzE7bhc3A/T8FCbkXLSMFjduVbG+LqGVOajmVXwyP0OjqQ+RK0BHAgl2gQpAtRPU0S8jM
 eKlW/6A==
X-Received: by 2002:a17:90b:3881:b0:3ad:5c64:c7a0 with SMTP id
 98e67ed59e1d1-3ae89814e7dmr15012925a91.38.1793869092039; 
 Thu, 05 Nov 2026 00:58:12 -0800 (PST)
Received: from localhost (118-163-122-149.hinet-ip.hinet.net.
 [118.163.122.149]) by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-3b0b313c0dcsm2899944a91.1.2026.11.05.00.58.11
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 05 Nov 2026 00:58:11 -0800 (PST)
Date: Thu, 05 Nov 2026 16:50:47 +0800
Subject: [PATCH 11/19] tests/qtest: ds1339: add RTC test
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261105-rtc-ds1339-v1-11-50a8dc463ee8@free.fr>
References: <20261105-rtc-ds1339-v1-0-50a8dc463ee8@free.fr>
In-Reply-To: <20261105-rtc-ds1339-v1-0-50a8dc463ee8@free.fr>
To: qemu-devel@nongnu.org
Cc: =?utf-8?q?C=C3=A9dric_Le_Goater?= <clg@kaod.org>, 
 Fabiano Rosas <farosas@suse.de>, Laurent Vivier <lvivier@redhat.com>, 
 Paolo Bonzini <pbonzini@redhat.com>, eblot@meta.com, 
 Emmanuel Blot <emmanuel.blot@free.fr>
X-Mailer: b4 0.16.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1793868640; l=7125;
 i=emmanuel.blot@free.fr; s=20260602; h=from:subject:message-id;
 bh=y/YegUWDnNx3TOGpnx4wFBpa4TX5WO9a9LqgZpv2Rq8=;
 b=maXU+bX9lYHM81AOmIdGvEH/cFnv53O712hPAKUe8Lm9FGEpbw0iyXw4eTLXlfGCeeNXG7f8y
 wKrDEIJe6oPDP/BUs8ZDErxW6umWvXsbillnlOweuFg8AeHjrZmhlM7
X-Developer-Key: i=emmanuel.blot@free.fr; a=ed25519;
 pk=0qFrZ21FAAN8OfVsSoVcCFTk/NMYOWzxJz4paSAVm0g=
Received-SPF: pass client-ip=209.85.215.169; envelope-from=eblot.ml@gmail.com;
 helo=mail-pg1-f169.google.com
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

The variant had no test of its own. Cover its register map, the
write-protection of the oscillator-stop flag, and the wrap of the
register pointer at the end of the map.

Signed-off-by: Emmanuel Blot <emmanuel.blot@free.fr>
---
 tests/qtest/ds1339-test.c | 166 ++++++++++++++++++++++++++++++++++++++++++++++
 tests/qtest/meson.build   |   1 +
 2 files changed, 167 insertions(+)

diff --git a/tests/qtest/ds1339-test.c b/tests/qtest/ds1339-test.c
new file mode 100644
index 0000000000..08fc16acda
--- /dev/null
+++ b/tests/qtest/ds1339-test.c
@@ -0,0 +1,166 @@
+/*
+ * QTest testcase for the DS1339 RTC
+ *
+ * Copyright (c) 2026 Meta Platforms, Inc. and affiliates.
+ *
+ * SPDX-License-Identifier: GPL-2.0-or-later
+ */
+
+#include "qemu/osdep.h"
+#include "qemu/bcd.h"
+#include "libqos/i2c.h"
+
+#define DS1339_ADDR 0x68
+
+/* DS1339 register map */
+#define DS1339_SECONDS   0x00
+#define DS1339_MONTH     0x05
+#define DS1339_YEAR      0x06
+#define DS1339_ALARM1    0x07
+#define DS1339_ALARM2    0x0b
+#define DS1339_CONTROL   0x0e
+#define DS1339_STATUS    0x0f
+#define DS1339_TRICKLE   0x10
+#define DS1339_NUM_REGS  0x11
+
+#define DS1339_STATUS_OSF 0x80
+
+/* The clock and calendar come up on the host time. */
+static void test_time(void *obj, void *data, QGuestAllocator *alloc)
+{
+    QI2CDevice *i2cdev = (QI2CDevice *)obj;
+    uint8_t resp[7];
+    time_t now = time(NULL);
+    struct tm *tm_ptr = gmtime(&now);
+
+    i2c_read_block(i2cdev, DS1339_SECONDS, resp, sizeof(resp));
+
+    g_assert_cmpuint(from_bcd(resp[4]), ==, tm_ptr->tm_mday);
+    g_assert_cmpuint(from_bcd(resp[5]), ==, 1 + tm_ptr->tm_mon);
+    g_assert_cmpuint(2000 + from_bcd(resp[6]), ==, 1900 + tm_ptr->tm_year);
+}
+
+/* Writable control bits round-trip; the reserved one reads back zero. */
+static void test_control_register(void *obj, void *data,
+                                  QGuestAllocator *alloc)
+{
+    QI2CDevice *i2cdev = (QI2CDevice *)obj;
+
+    i2c_set8(i2cdev, DS1339_CONTROL, 0x1c);
+    g_assert_cmphex(i2c_get8(i2cdev, DS1339_CONTROL), ==, 0x1c);
+
+    i2c_set8(i2cdev, DS1339_CONTROL, 0xff);
+    g_assert_cmphex(i2c_get8(i2cdev, DS1339_CONTROL), ==, 0xbf);
+
+    i2c_set8(i2cdev, DS1339_CONTROL, 0x00);
+    g_assert_cmphex(i2c_get8(i2cdev, DS1339_CONTROL), ==, 0x00);
+}
+
+/* The oscillator-stop flag can only be cleared by a write, never set. */
+static void test_osf_write_protect(void *obj, void *data,
+                                   QGuestAllocator *alloc)
+{
+    QI2CDevice *i2cdev = (QI2CDevice *)obj;
+
+    g_assert_cmphex(i2c_get8(i2cdev, DS1339_STATUS) & DS1339_STATUS_OSF,
+                    ==, DS1339_STATUS_OSF);
+    i2c_set8(i2cdev, DS1339_STATUS, DS1339_STATUS_OSF);
+    g_assert_cmphex(i2c_get8(i2cdev, DS1339_STATUS) & DS1339_STATUS_OSF,
+                    ==, DS1339_STATUS_OSF);
+
+    i2c_set8(i2cdev, DS1339_STATUS, 0x00);
+    g_assert_cmphex(i2c_get8(i2cdev, DS1339_STATUS) & DS1339_STATUS_OSF, ==, 0);
+    i2c_set8(i2cdev, DS1339_STATUS, DS1339_STATUS_OSF);
+    g_assert_cmphex(i2c_get8(i2cdev, DS1339_STATUS) & DS1339_STATUS_OSF, ==, 0);
+}
+
+/* The register pointer wraps at the end of the map. */
+static void test_address_wrap(void *obj, void *data, QGuestAllocator *alloc)
+{
+    QI2CDevice *i2cdev = (QI2CDevice *)obj;
+
+    i2c_set8(i2cdev, DS1339_CONTROL, 0x2a);
+    g_assert_cmphex(i2c_get8(i2cdev, DS1339_CONTROL + DS1339_NUM_REGS),
+                    ==, 0x2a);
+}
+
+/* A block transfer off the end of the map carries on from the start. */
+static void test_block_wrap(void *obj, void *data, QGuestAllocator *alloc)
+{
+    QI2CDevice *i2cdev = (QI2CDevice *)obj;
+    /* The alarm 2 block, then on into the time registers once it wraps. */
+    const uint8_t out[11] = {
+        0x0b, 0x0c, 0x0d,              /* alarm 2 */
+        0x18,                          /* control */
+        0x00,                          /* status */
+        0xa5,                          /* trickle charger */
+        0x30, 0x20, 0x10, 0x05, 0x12,  /* 10:20:30, day 5, the 12th */
+    };
+    uint8_t resp[11];
+
+    /* A month and year the wrapping write never reaches. */
+    i2c_set8(i2cdev, DS1339_MONTH, 0x07);
+    i2c_set8(i2cdev, DS1339_YEAR, 0x31);
+
+    i2c_write_block(i2cdev, DS1339_ALARM2, out, sizeof(out));
+
+    i2c_read_block(i2cdev, DS1339_SECONDS, resp, 7);
+    g_assert_cmphex(resp[2], ==, 0x10);
+    g_assert_cmphex(resp[3], ==, 0x05);
+    g_assert_cmphex(resp[4], ==, 0x12);
+    g_assert_cmphex(resp[5] & 0x1f, ==, 0x07);
+    g_assert_cmphex(resp[6], ==, 0x31);
+
+    i2c_read_block(i2cdev, DS1339_ALARM2, resp, sizeof(resp));
+    g_assert_cmphex(resp[0], ==, 0x0b);
+    g_assert_cmphex(resp[1], ==, 0x0c);
+    g_assert_cmphex(resp[2], ==, 0x0d);
+    g_assert_cmphex(resp[3], ==, 0x18);
+    g_assert_cmphex(resp[4], ==, 0x00);
+    g_assert_cmphex(resp[5], ==, 0xa5);
+    g_assert_cmphex(resp[8], ==, 0x10);
+    g_assert_cmphex(resp[9], ==, 0x05);
+    g_assert_cmphex(resp[10], ==, 0x12);
+}
+
+/* The alarm and trickle registers are stored but never evaluated. */
+static void test_alarm_registers(void *obj, void *data,
+                                 QGuestAllocator *alloc)
+{
+    QI2CDevice *i2cdev = (QI2CDevice *)obj;
+    static const uint8_t regs[] = {
+        DS1339_ALARM1, 0x08, 0x09, 0x0a,        /* alarm 1 */
+        DS1339_ALARM2, 0x0c, 0x0d,              /* alarm 2 */
+        DS1339_TRICKLE,
+    };
+    static const uint8_t vals[] = { 0xff, 0x00, 0x5a, 0xa5 };
+    unsigned reg, val;
+
+    for (reg = 0; reg < ARRAY_SIZE(regs); reg++) {
+        for (val = 0; val < ARRAY_SIZE(vals); val++) {
+            i2c_set8(i2cdev, regs[reg], vals[val]);
+            g_assert_cmphex(i2c_get8(i2cdev, regs[reg]), ==, vals[val]);
+        }
+    }
+}
+
+static void ds1339_register_nodes(void)
+{
+    QOSGraphEdgeOptions opts = {
+        .extra_device_opts = "address=0x68"
+    };
+    add_qi2c_address(&opts, &(QI2CAddress) { DS1339_ADDR });
+
+    qos_node_create_driver("ds1339", i2c_device_create);
+    qos_node_consumes("ds1339", "i2c-bus", &opts);
+
+    qos_add_test("time", "ds1339", test_time, NULL);
+    qos_add_test("control-register", "ds1339", test_control_register, NULL);
+    qos_add_test("osf-write-protect", "ds1339", test_osf_write_protect, NULL);
+    qos_add_test("address-wrap", "ds1339", test_address_wrap, NULL);
+    qos_add_test("block-wrap", "ds1339", test_block_wrap, NULL);
+    qos_add_test("alarm-registers", "ds1339", test_alarm_registers,
+                 NULL);
+}
+
+libqos_init(ds1339_register_nodes);
diff --git a/tests/qtest/meson.build b/tests/qtest/meson.build
index ff4bf9528a..f700442607 100644
--- a/tests/qtest/meson.build
+++ b/tests/qtest/meson.build
@@ -335,6 +335,7 @@ qos_test_ss.add(
   'adm1272-test.c',
   'adm1266-test.c',
   'ds1338-test.c',
+  'ds1339-test.c',
   'e1000-test.c',
   'eepro100-test.c',
   'es1370-test.c',

-- 
2.53.0-Meta


