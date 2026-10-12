Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 23F13CA9ED1
	for <qemu-devel@archiver.kernel.org>; Mon, 12 Oct 2026 15:14:35 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xGHj9-0002Z5-8N; Mon, 12 Oct 2026 11:14:15 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eblot.ml@gmail.com>)
 id 1xGHiw-0002Y4-UM
 for qemu-devel@nongnu.org; Mon, 12 Oct 2026 11:14:00 -0400
Received: from mail-wr1-f46.google.com ([209.85.221.46])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <eblot.ml@gmail.com>)
 id 1xGHiu-00085C-1P
 for qemu-devel@nongnu.org; Mon, 12 Oct 2026 11:13:58 -0400
Received: by mail-wr1-f46.google.com with SMTP id
 ffacd0b85a97d-48af4d4e61fso1403307f8f.2
 for <qemu-devel@nongnu.org>; Mon, 12 Oct 2026 08:13:55 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1791818034; x=1792422834;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=m2GA4fazsDlog1s+fRBtwXY8L09cn4aW6lhQjZ5SfME=;
 b=YhKx3H4/SwQU9TSJUT8ckKH6bhQlM1FKLheNPghFN/yBdFWsROQaeAR4WyH4CpSMGF
 kEWH2S0fO+70kLV8t3/qgR1rrB7K5FpPXjEmu54BkG4eJyD0MTxSXFDIYHKMhw7gU+Rw
 iObkz5SnkxGb1nBGMzTeT4d7YBKAqn0Pd3TR0Ck2JhIqHQjzlznHNNUABmfSl4Qnv1KN
 1GJncuQggsEkr4gy8riIx8bFmSP1NMosLyFobB6kcFE1VjYofd7IqBeenAYUooqP8XQU
 opb/EdJHg47V7BcJpOhvMflrbExMFbCjmZaZvdzAcm8qzalX3mfqZeCUt3vhpV8AiHih
 LXSQ==
X-Gm-Message-State: AFq9FYKfI6TRtMpLqNG00JGAAfvg4U7PbBgtEyb3Lkogu4lBYUqRdCCd
 /LxuhDifRSEqVlYHJCIdAZSI3AriKa1JA5YEvCTwQ39JuvJH9kOePHKsS/qPtV27
X-Gm-Gg: AYBFou2sMv//W91FKncP7fJ1cGqJmYbyZZcN/ovfxUDGrKMlGNlgTVi5FM5UGlNEN0W
 d067cZMx4Vbk+O73KVw9VjLiQqKmIEZfbfBSrqZnQ9u30e3gaCKWM+zazk1ItfMXRgrmpDSI4UE
 +8BDR3tBndbFLOAr6h/jFbf8F0Fexz23eEgSC5CFnVAIOzNiMgVYBOuWTkjNkyNC9Xo9ev/32Mt
 KE79Ad/RphJ4Ql2Nlq5NdVuFJsKbmmSBTu4U6BXG3onp+gxslwBvFqTYaphqxpYK3CTLeoZJ9dY
 xg7w4If5gfI4rTw3KIrCghq7T9lk5a0s62fxpmiZ7YbYWN5yVOHFeWbnwj9MNAhbX8Slt/iHRK0
 qIzHz42krDpMMk7ACghQr9o2Ujh5M9vyvgKmM15lW4jyhWW/RWMa0WPuGV/ausST5KFPUYg8SFg
 LTQ1le9dQdUpgJh+v9bTFhJ0gfIm3jp+lFuW4WOVtYKOxOzI6FaNnG+YxJLC1MWZPRmx3Qvn0g1
 avyJvFmWxu/vT59Q5HZ4TijyWrW/CacZUypJJotIOqstw==
X-Received: by 2002:a5d:59c5:0:b0:48a:f592:fb63 with SMTP id
 ffacd0b85a97d-48dba7bea5dmr18541428f8f.1.1791818034234; 
 Mon, 12 Oct 2026 08:13:54 -0700 (PDT)
Received: from localhost (89-93-216-19.hfc.dyn.abo.bbox.fr. [89.93.216.19])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-48de0514ab1sm122891f8f.0.2026.10.12.08.13.53
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 12 Oct 2026 08:13:53 -0700 (PDT)
Date: Mon, 12 Oct 2026 16:32:14 +0200
Subject: [PATCH v2 21/50] tests/qtest: ds1338: cover the reserved bits of
 the time registers
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261012-bmc-minerva-v2-21-4c3dff084ec9@free.fr>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1791815520; l=2162;
 i=emmanuel.blot@free.fr; s=20260602; h=from:subject:message-id;
 bh=KJY0zIrKxG//LL1WKd4K1qyh6CHHxQ+6MszW1XMqpgc=;
 b=1iKV0oV3yRvjn623f+4E7dwXeJvrn/Atpfy20ZcQS0vfIIs2QwYrYErpilCTCDogvTZkW0I7j
 s42MtSTZ0vFByJP2wL5Ur5U+fqT3yfRebJ4WUolrZbgU803kZn3A1Ck
X-Developer-Key: i=emmanuel.blot@free.fr; a=ed25519;
 pk=0qFrZ21FAAN8OfVsSoVcCFTk/NMYOWzxJz4paSAVm0g=
Received-SPF: pass client-ip=209.85.221.46; envelope-from=eblot.ml@gmail.com;
 helo=mail-wr1-f46.google.com
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


