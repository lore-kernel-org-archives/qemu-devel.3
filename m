Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 86CDFC79FAA
	for <qemu-devel@archiver.kernel.org>; Mon,  7 Sep 2026 16:48:27 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x3cW0-0003ni-0E; Mon, 07 Sep 2026 12:48:16 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eblot.ml@gmail.com>)
 id 1x3cVx-0003im-L2
 for qemu-devel@nongnu.org; Mon, 07 Sep 2026 12:48:13 -0400
Received: from mail-wm1-f46.google.com ([209.85.128.46])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <eblot.ml@gmail.com>)
 id 1x3cVu-0003w9-N5
 for qemu-devel@nongnu.org; Mon, 07 Sep 2026 12:48:13 -0400
Received: by mail-wm1-f46.google.com with SMTP id
 5b1f17b1804b1-49b0d78a801so38042695e9.2
 for <qemu-devel@nongnu.org>; Mon, 07 Sep 2026 09:48:10 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1788799689; x=1789404489;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=xDaZUroT2n8sJrtLzMe0uCr4D4Xox3szI0g/uL81yHs=;
 b=WjJynR1U/Rmmuj7J8k9hczwuZ6LUQ+eC+obLZpNRnCaNqn6ubSS5zsYcINKlb1rc3g
 IGeSYaF1VhE8LztC+1bP1RXHRzKyPkhHSD4bld8ggW5D6bS2BZrmefT4uEEOnI9wCyz6
 Vv2G7N+3S8T1yNf9JT9U7zikqveOz22b3oKTzNezNmgynyOw0Q/Q7FlbgyPle6mSUhjZ
 GlEpUnNGnXZqsSo0KVUQWNG07FVS/HWepl4Mkwlz8J2QLLs/IopvTx+B0S4wsXYsN3lB
 +nrSJSahQcuqfMnVUPQYeVV5vRdauyxqblAwA6NPqjmdFBMK9lidKe7BWCsu7EctwbOL
 XlNQ==
X-Gm-Message-State: AFuF++nBl72KzcIlK2vxNPKukEpy6z+QbGtIJMlfEUgno3S8uHLNAewT
 OhETci+8LcE7LVDyfVY3MhdXhRvVhF9krjh4Rsms761bvwXkZ/7NHTw//0y1rKmX
X-Gm-Gg: AYBFou1dRW8kji40uZiZ5SnAHWGVYHqT6jkWuXwwD9JQ8RkZfrUVeGmDHm3kgdPRlo4
 lc/gO1OyG8C9TgNuMuQnvbFmEVK0KR2lsxAUDC67LnFuTjmSfaj/ppTQrwT5v7umj5OdpTlLIzm
 3ACH1pJW0B9+NoxPn3QXMOAWJQ0p3gyHMf9VSV/kgSOBBb05sBI0RV/5+gF5nhKxuaEX7LrzWSR
 4b68Rr8GmmFOBM/4HFNrn9WGTzYuQD/WOh5X0B/mEwEEYZTmquIz7eLTpiAyjj1zg2Us3oUJVKy
 R9ZqUYeKoACqIptdfbt+ugSed+stvhqyLOQfg7US/j7VSwMEtEQlbfZLwkIVF6vjdPQbhOMkq44
 6XWX+6oNiYypP+WM8tO3XDBxLsEX8Is0zYViitH95piDtbVd+84gZ7+vaQe6gQKeffIO3AeCuuh
 q0KAGr293bPvGAUVSqHc/22TUIQYdIfqCKNwtTGZNmBt8C9W+9qGDi89YlS0/UkEutSO3bT9Up1
 Z+b1QEmQW5fIsvNblVNQO/IG9smAes7lYA=
X-Received: by 2002:a05:600c:4f12:b0:49c:fc6c:be00 with SMTP id
 5b1f17b1804b1-49cfc6cbfcamr207136815e9.23.1788799689202; 
 Mon, 07 Sep 2026 09:48:09 -0700 (PDT)
Received: from localhost (89-93-216-19.hfc.dyn.abo.bbox.fr. [89.93.216.19])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-49cee5d476esm447480005e9.1.2026.09.07.09.48.06
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 07 Sep 2026 09:48:07 -0700 (PDT)
Date: Mon, 07 Sep 2026 18:42:19 +0200
Subject: [PATCH 29/50] tests/qtest: ds1339: cover the day-of-week counter
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260907-bmc-minerva-v1-29-0d83ad610c3b@free.fr>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1788799321; l=2630;
 i=emmanuel.blot@free.fr; s=20260602; h=from:subject:message-id;
 bh=K9HOm83SsQOK9R4XDnsjhxDGcTLTCjXMrgk6bTqgUo0=;
 b=JqTAAXTa1cgPUsXsODqk7cQoKOlWxIWYoUxLPLHP78hdfyu1C66KsHKEnMwiCVuEejruUkYW9
 +AjcmKkEYZKDOS7XaDGtsoOYcPKbdBQ6nYI8iT7cbeDpTL7w97ZWif2
X-Developer-Key: i=emmanuel.blot@free.fr; a=ed25519;
 pk=0qFrZ21FAAN8OfVsSoVcCFTk/NMYOWzxJz4paSAVm0g=
Received-SPF: pass client-ip=209.85.128.46; envelope-from=eblot.ml@gmail.com;
 helo=mail-wm1-f46.google.com
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
2.50.1


