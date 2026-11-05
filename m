Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 21F62606A31B
	for <qemu-devel@archiver.kernel.org>; Thu,  5 Nov 2026 08:58:54 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xOtIz-0005VG-U3; Thu, 05 Nov 2026 03:58:46 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eblot.ml@gmail.com>)
 id 1xOtIv-0005Ar-OL
 for qemu-devel@nongnu.org; Thu, 05 Nov 2026 03:58:42 -0500
Received: from mail-pf1-f181.google.com ([209.85.210.181])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <eblot.ml@gmail.com>)
 id 1xOtIt-0003oa-7Q
 for qemu-devel@nongnu.org; Thu, 05 Nov 2026 03:58:41 -0500
Received: by mail-pf1-f181.google.com with SMTP id
 d2e1a72fcca58-8a058315c79so896451b3a.3
 for <qemu-devel@nongnu.org>; Thu, 05 Nov 2026 00:58:38 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793869117; x=1794473917;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=Zzjq066d1DK9BL6AffnijbYCb4eLXuskQFLQ8zYtsCk=;
 b=lXwJ5qb5QaDYukUvTr0tzpd2Q6oS30d5jwQh2l9AUblcpGaXdSs4c1yJqdvYVU8wXY
 gIQCn2M2+sDvSkkJI7543ms+MX1TMT6NeXW0YQN1s/rv165rcELt4fPikSWpmnPhtuOe
 u+KQiWHn6LjDwT1jhhN4V2sUr2RSCifwoLmnCHV7qNw6lxaq+c3zIGWKI5TyY1OicWJP
 xxAIN2gzpldHV+GmUcT/GGvDk+q8lnDqUt3mBtdk9Pji0Sur1ULb6fzjnCXv+EILGqxS
 ZaC4k7EMCkUOUSRs2SzpwF+pZ0OvYRxqrT+NEHWAqvabQq0NsA0M2HwiUIobeJzDK336
 Jcfw==
X-Gm-Message-State: APuU4Z8y/IvS9bJGXUaYkRB2WO37pqYCpn82RkLQowzXUSHPfdamh9e+
 +p+kJjLkeCPnbEEg6xSEbiSyXP6CTJ13o7y3s3AW/WmnDX8vmlbbjjaubFZ7iLyLUP8=
X-Gm-Gg: AYBFou3UGahkAEHrvBGuDyLvb9oIRWcK7Ohb0vzx+ZBsm6wup3iOPnlYANeYft+r+Lp
 /CZySepoL5fcT3la7HVzAd3iuWxq+p7sZkfrHRZU3jIZuUgCckycESjV58rT8j5TR8Nrwja1paU
 rtyXB/ozQ27cHCcELEQ+BPy0r9bBzXendtJ7k3pn2YoHAAZtvwxkzoWFRs/DCxYfdzIfXXwIyh+
 ipYY85Vw25RiMVw3Ov7VvVAz5/sFa3rxEfUGvUUHvLDu9Zkjm34knCkTL8d4Yd3m/+fCx9AKAWZ
 SDoDr4fmK5XLGZo2wiab/sXXfXhKmuYlijT8ozKHpjTHOYSfXcwnCiVWF32cYlY9XoT/Rn7kfJM
 p82E5R1iyqEPzDTRSx7duugjqX2gKI4oveS90jUBA7phcZFI/yVL5DNiM6nUUMElMAvvvvGV/R7
 WKcy9yct2qSyAh+peGaV+1lmXgt4kfcqaEnXdh1ad2MfTfMnqsMOIq1wFoVstiOFTTNdhOY65nk
 cz9NoRNirq9Bk487TzYzWin5/4bs/veAYOTdJAcqc9J4vlnVGWkq2hhG22xJfrltBR2LP1QNN8i
 ddKFwvL8QX5UFGN+4S4LDbU60Sx9tQHqVe0rDA++Qoc72Cq9KMs/F42jPaeRDM+VnIDSegF8PJI
 cYK4BXg==
X-Received: by 2002:a05:6a00:22c7:b0:881:cbb0:6a90 with SMTP id
 d2e1a72fcca58-8a9bef522cbmr14521222b3a.58.1793869116526; 
 Thu, 05 Nov 2026 00:58:36 -0800 (PST)
Received: from localhost (118-163-122-149.hinet-ip.hinet.net.
 [118.163.122.149]) by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-8b09a8c303dsm1692412b3a.20.2026.11.05.00.58.35
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 05 Nov 2026 00:58:36 -0800 (PST)
Date: Thu, 05 Nov 2026 16:50:50 +0800
Subject: [PATCH 14/19] tests/qtest: ds1339: cover the Century bit
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261105-rtc-ds1339-v1-14-50a8dc463ee8@free.fr>
References: <20261105-rtc-ds1339-v1-0-50a8dc463ee8@free.fr>
In-Reply-To: <20261105-rtc-ds1339-v1-0-50a8dc463ee8@free.fr>
To: qemu-devel@nongnu.org
Cc: =?utf-8?q?C=C3=A9dric_Le_Goater?= <clg@kaod.org>, 
 Fabiano Rosas <farosas@suse.de>, Laurent Vivier <lvivier@redhat.com>, 
 Paolo Bonzini <pbonzini@redhat.com>, eblot@meta.com, 
 Emmanuel Blot <emmanuel.blot@free.fr>
X-Mailer: b4 0.16.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1793868640; l=3691;
 i=emmanuel.blot@free.fr; s=20260602; h=from:subject:message-id;
 bh=a51PVO883sS5BmzswPWqVtyHVJ/pN81H084v6xEIBwk=;
 b=2PDOqlPZg5yc5wNW7YYIRCeZcoSg/V0lP9ZQoQZ8NsyL4RUAXehjpWjHZtbKNmGq5dc7G7MOF
 ZYvlRIHdaulDXs2gbogiHxVJZF4D+M31o/d26WAUHLYYCmfqJOLSfyo
X-Developer-Key: i=emmanuel.blot@free.fr; a=ed25519;
 pk=0qFrZ21FAAN8OfVsSoVcCFTk/NMYOWzxJz4paSAVm0g=
Received-SPF: pass client-ip=209.85.210.181; envelope-from=eblot.ml@gmail.com;
 helo=mail-pf1-f181.google.com
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

The Century bit had no coverage: neither its guest read/write
behaviour, nor the rule that only an elapsed rollover toggles it.

Signed-off-by: Emmanuel Blot <emmanuel.blot@free.fr>
---
 tests/qtest/ds1339-test.c | 60 +++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 60 insertions(+)

diff --git a/tests/qtest/ds1339-test.c b/tests/qtest/ds1339-test.c
index ac19ebd71d..8c144579e6 100644
--- a/tests/qtest/ds1339-test.c
+++ b/tests/qtest/ds1339-test.c
@@ -169,6 +169,62 @@ static void test_eosc_restart(void *obj, void *data, QGuestAllocator *alloc)
     g_assert_cmphex(resp[6], ==, 0x31);
 }
 
+/* The Century bit is guest-writable and survives an oscillator restart. */
+static void test_century_bit(void *obj, void *data, QGuestAllocator *alloc)
+{
+    QI2CDevice *i2cdev = (QI2CDevice *)obj;
+
+    i2c_set8(i2cdev, DS1339_MONTH, 0x86); /* Century | June */
+    g_assert_cmphex(i2c_get8(i2cdev, DS1339_MONTH) & 0x80, ==, 0x80);
+
+    i2c_set8(i2cdev, DS1339_CONTROL, 0x18 | 0x80);
+    i2c_set8(i2cdev, DS1339_CONTROL, 0x18);
+    g_assert_cmphex(i2c_get8(i2cdev, DS1339_MONTH) & 0x80, ==, 0x80);
+
+    i2c_set8(i2cdev, DS1339_MONTH, 0x06); /* June, century clear */
+    g_assert_cmphex(i2c_get8(i2cdev, DS1339_MONTH) & 0x80, ==, 0x00);
+}
+
+/* A guest write never toggles the Century bit. */
+static void test_century_write_no_toggle(void *obj, void *data,
+                                         QGuestAllocator *alloc)
+{
+    QI2CDevice *i2cdev = (QI2CDevice *)obj;
+
+    i2c_set8(i2cdev, DS1339_MONTH, 0x86);
+    i2c_set8(i2cdev, DS1339_YEAR, 0x99);
+    g_assert_cmphex(i2c_get8(i2cdev, DS1339_MONTH) & 0x80, ==, 0x80);
+    i2c_set8(i2cdev, DS1339_YEAR, 0x00);
+    g_assert_cmphex(i2c_get8(i2cdev, DS1339_MONTH) & 0x80, ==, 0x80);
+
+    i2c_set8(i2cdev, DS1339_MONTH, 0x06);
+    i2c_set8(i2cdev, DS1339_YEAR, 0x99);
+    g_assert_cmphex(i2c_get8(i2cdev, DS1339_MONTH) & 0x80, ==, 0x00);
+    i2c_set8(i2cdev, DS1339_YEAR, 0x00);
+    g_assert_cmphex(i2c_get8(i2cdev, DS1339_MONTH) & 0x80, ==, 0x00);
+}
+
+/* A clock-driven year rollover from 99 to 00 toggles the Century bit. */
+static void test_century_rollover(void *obj, void *data,
+                                  QGuestAllocator *alloc)
+{
+    QI2CDevice *i2cdev = (QI2CDevice *)obj;
+    const uint8_t tod[7] = { 0x59, 0x59, 0x23, 0x01, 0x31, 0x12, 0x99 };
+    unsigned idx;
+
+    i2c_write_block(i2cdev, DS1339_SECONDS, tod, sizeof(tod));
+
+    for (idx = 0; idx < 50; idx++) {
+        if (i2c_get8(i2cdev, DS1339_YEAR) == 0x00) {
+            break;
+        }
+        g_usleep(100 * 1000);
+    }
+
+    g_assert_cmphex(i2c_get8(i2cdev, DS1339_YEAR), ==, 0x00);
+    g_assert_cmphex(i2c_get8(i2cdev, DS1339_MONTH) & 0x80, ==, 0x80);
+}
+
 /* The register pointer wraps at the end of the map. */
 static void test_address_wrap(void *obj, void *data, QGuestAllocator *alloc)
 {
@@ -258,6 +314,10 @@ static void ds1339_register_nodes(void)
     qos_add_test("eosc-restart", "ds1339", test_eosc_restart, NULL);
     qos_add_test("stopped-reserved-bits", "ds1339",
                  test_stopped_reserved_bits, NULL);
+    qos_add_test("century-bit", "ds1339", test_century_bit, NULL);
+    qos_add_test("century-write-no-toggle", "ds1339",
+                 test_century_write_no_toggle, NULL);
+    qos_add_test("century-rollover", "ds1339", test_century_rollover, NULL);
     qos_add_test("address-wrap", "ds1339", test_address_wrap, NULL);
     qos_add_test("block-wrap", "ds1339", test_block_wrap, NULL);
     qos_add_test("alarm-registers", "ds1339", test_alarm_registers,

-- 
2.53.0-Meta


