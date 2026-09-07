Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2AA63C79FA7
	for <qemu-devel@archiver.kernel.org>; Mon,  7 Sep 2026 16:47:09 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x3cUU-00079i-4O; Mon, 07 Sep 2026 12:46:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eblot.ml@gmail.com>)
 id 1x3cUS-0006yZ-4z
 for qemu-devel@nongnu.org; Mon, 07 Sep 2026 12:46:40 -0400
Received: from mail-wm1-f51.google.com ([209.85.128.51])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <eblot.ml@gmail.com>)
 id 1x3cUO-0003fR-Qj
 for qemu-devel@nongnu.org; Mon, 07 Sep 2026 12:46:39 -0400
Received: by mail-wm1-f51.google.com with SMTP id
 5b1f17b1804b1-4995b0343c1so52975165e9.3
 for <qemu-devel@nongnu.org>; Mon, 07 Sep 2026 09:46:36 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1788799595; x=1789404395;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=m2GA4fazsDlog1s+fRBtwXY8L09cn4aW6lhQjZ5SfME=;
 b=d+IltZPD1/ZNJTnVZvQEeYHZuPnws1hfVzRRQX/3UOk3w9nl0ZOj+S3NCHnPWS+IUe
 JlcyHAlxSPA2KyslDv2psxWVbki0BGllhEHStDSRSkyQgoCriM6w0oTQ3FqSSNODdMNL
 OBoiEzIE+zQ1gZk0zaJHgqjCdIYOXatMa5jx4GtXLy9j6xawcTC7Z88IvyPvlwRSr3ta
 jwGBjCSeo4nVzE+HdySHRoNorL8XQLU6LjeMzheJmQqSaLayXMZ7EbuUpvlLbZij0iU1
 OQ8ZGxQgs9sx1g4LaRWMPU/p9S5Yv9YfhnyQYNRgoT2fiILZwR9EEBAe+Khlk/CWvmGB
 0hmg==
X-Gm-Message-State: AFuF++n/tlLQ/pTuEKeuDX56hjDXPBYOKoxu39uP4pX/Wap2C0wlpDHy
 JWg14OsxT6ArBjdYvzK/kTcAmOYjX3IrOF1CsaXDUSBymhScXhL+FrfrEnNrlDFc
X-Gm-Gg: AYBFou20d65ig35lRt05HVlGHLT9KMS7gQ6IigzMuaRNMv1FBbbUfvc50GFvyflOWDR
 RArh2MdWBIC2anbVkr2cLngjg6u0Tp1kUCE9M7471y6ECxXKmpEpe+gYhCHvX+GWPLHzdkFAqwb
 HmiTVtH5aRApEZ/PsJj+ti3REhjBBcIsBKAAAwz0FNR2PFUnDRAod8m7y85RET+hlR9+qVG3/CZ
 7PhyUI+sdQWwg88f9Vl+GGRcwc0zXhUnpVbjZw4YNRtnCre1WufXxvr5nOMgpQWypIM0AITyT8O
 Z+fLBZWGwjaW4a9vZnPALpYhrba7CQ4gbhnJP3kcDM+3r0qRKGi8ay+7peSM/yfnR3+XJlfJ1gp
 DE6nZNdqMUemrQyw8UrxooQuy4Eas+jJbGvM+VUT6EB179uOKAkGDHWYPuzRinBWJp9o9x0Gjcz
 ptbTC0nlgnhFUyIO1jzhwab9aFKdYGvCJTLCjDGr4uCuncwUxARcQGViVk9TAajh4Hy2zV+5Jgf
 2li7rXE8Q4zWhqDuc0IOHOzOQFWFqCh9tQ=
X-Received: by 2002:a05:600c:358d:b0:49d:797:8488 with SMTP id
 5b1f17b1804b1-49d0797853emr138784105e9.1.1788799595177; 
 Mon, 07 Sep 2026 09:46:35 -0700 (PDT)
Received: from localhost (89-93-216-19.hfc.dyn.abo.bbox.fr. [89.93.216.19])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-49cee5f912esm418860875e9.4.2026.09.07.09.46.33
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 07 Sep 2026 09:46:34 -0700 (PDT)
Date: Mon, 07 Sep 2026 18:42:11 +0200
Subject: [PATCH 21/50] tests/qtest: ds1338: cover the reserved bits of the
 time registers
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260907-bmc-minerva-v1-21-0d83ad610c3b@free.fr>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1788799321; l=2162;
 i=emmanuel.blot@free.fr; s=20260602; h=from:subject:message-id;
 bh=KJY0zIrKxG//LL1WKd4K1qyh6CHHxQ+6MszW1XMqpgc=;
 b=DkpZIF6av8FRJBac7TBSPEXMoJk9MJKiRNQQ+5grcndk5XTSmIoBIZK+HYudb+2IEsgln3bA7
 +Kp8iiVOQ++CQgvK7QAructEQfgWjkHhaqd7cCHpuZfkUyWAcBNN4Eg
X-Developer-Key: i=emmanuel.blot@free.fr; a=ed25519;
 pk=0qFrZ21FAAN8OfVsSoVcCFTk/NMYOWzxJz4paSAVm0g=
Received-SPF: pass client-ip=209.85.128.51; envelope-from=eblot.ml@gmail.com;
 helo=mail-wm1-f51.google.com
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

Nothing pinned which bits of a time register survive a write.

Signed-off-by: Emmanuel Blot <emmanuel.blot@free.fr>
---
 tests/qtest/ds1338-test.c | 22 ++++++++++++++++++++++
 1 file changed, 22 insertions(+)

diff --git a/tests/qtest/ds1338-test.c b/tests/qtest/ds1338-test.c
index 1b9c02d931..9e2e257307 100644
--- a/tests/qtest/ds1338-test.c
+++ b/tests/qtest/ds1338-test.c
@@ -125,6 +125,26 @@ static void test_clock_halt(void *obj, void *data, QGuestAllocator *alloc)
                     ==, DS1338_CTRL_OSF);
 }
 
+/* Reserved time-register bits read back zero even with the clock halted. */
+static void test_stopped_reserved_bits(void *obj, void *data,
+                                       QGuestAllocator *alloc)
+{
+    QI2CDevice *i2cdev = (QI2CDevice *)obj;
+    const uint8_t all_ones[7] = { 0xff, 0xff, 0xff, 0xff, 0xff, 0xff, 0xff };
+    uint8_t resp[7];
+
+    i2c_write_block(i2cdev, DS1338_SECONDS, all_ones, sizeof(all_ones));
+
+    i2c_read_block(i2cdev, DS1338_SECONDS, resp, sizeof(resp));
+    g_assert_cmphex(resp[0], ==, 0xff);   /* the halt bit is writable here */
+    g_assert_cmphex(resp[1], ==, 0x7f);
+    g_assert_cmphex(resp[2], ==, 0x7f);
+    g_assert_cmphex(resp[3], ==, 0x07);
+    g_assert_cmphex(resp[4], ==, 0x3f);
+    g_assert_cmphex(resp[5], ==, 0x1f);   /* no century bit on this part */
+    g_assert_cmphex(resp[6], ==, 0xff);
+}
+
 /* The user RAM returns what the guest wrote to it. */
 static void test_nvram(void *obj, void *data, QGuestAllocator *alloc)
 {
@@ -207,6 +227,8 @@ static void ds1338_register_nodes(void)
     qos_add_test("control-register", "ds1338", test_control_register, NULL);
     qos_add_test("osf-write-protect", "ds1338", test_osf_write_protect, NULL);
     qos_add_test("clock-halt", "ds1338", test_clock_halt, NULL);
+    qos_add_test("stopped-reserved-bits", "ds1338",
+                 test_stopped_reserved_bits, NULL);
     qos_add_test("nvram", "ds1338", test_nvram, NULL);
     qos_add_test("address-wrap", "ds1338", test_address_wrap, NULL);
     qos_add_test("reset-clears", "ds1338", test_reset_clears, NULL);

-- 
2.50.1


