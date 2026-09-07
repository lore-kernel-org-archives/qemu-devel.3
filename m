Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CC463C79FA0
	for <qemu-devel@archiver.kernel.org>; Mon,  7 Sep 2026 16:50:26 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x3cXs-0008Ho-NT; Mon, 07 Sep 2026 12:50:12 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eblot.ml@gmail.com>)
 id 1x3cXo-0007xm-J7
 for qemu-devel@nongnu.org; Mon, 07 Sep 2026 12:50:08 -0400
Received: from mail-wm1-f54.google.com ([209.85.128.54])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <eblot.ml@gmail.com>)
 id 1x3cXm-0004QB-13
 for qemu-devel@nongnu.org; Mon, 07 Sep 2026 12:50:08 -0400
Received: by mail-wm1-f54.google.com with SMTP id
 5b1f17b1804b1-49b8687630fso32304185e9.3
 for <qemu-devel@nongnu.org>; Mon, 07 Sep 2026 09:50:05 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1788799804; x=1789404604;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=7JIouwvsYhybUqJx3bKqTjTPWbvwF34ZaZVav4+/RP8=;
 b=VvylwzgxnJ2VzyNi5LQp9i8SuCZ/xid9CxtohMyGWhHHgjF2tu10XgeqO16dK6aONx
 3Pn2ORUXgSjYT3sjB8LNqtl2xi2c/3UhwNPRe+wSTHrh48RJ9m7KLRzFBx5JdgBI9Pet
 CDvxGm5kA6KAIV8PbqhG98e9RKRR8RfOm9hv1qH7tjU7k1IVnCx0tGAklJJ1IYzcUTp0
 Hzd2Rm5RiRXpUi4dAUGyi5MMnebnsqCImp4+ZFrM84X+MfIQLUbHaie8QLeBUJpxy51T
 Si2EAgriRBTo7mM1sSqD+UTD32CQSC98LpeUag2v5sdsvJCrYU+qyws8CagsqVUbQ2uG
 7V3A==
X-Gm-Message-State: AFuF++ljkRcnZWBVYIO/FN0K1HRiMGKxvbvOXSdknM6SRG9JsGarGv5J
 4+IxGS2oK3rhZjNbd8kdqy7Z2BGlocnLLemW7zo2mabamsUjD7N9jXgkk1KSDzt9
X-Gm-Gg: AYBFou3mhdi5OnnD0F7pqiNlJsY74xG14C7GkyTCmfdEl5+4TPtkXkAgs2DolS1Nual
 lIZq74c2YhB86yI4TyYmB7sgXc3ODVgatif+xucm7iQBloknHxUVCz/p7cl+PMYmCrzPAv6+wJm
 +944QqEpt1z2Xmssti1H5NmOY0WKT8aRFxU5brCs1ouTVcaDO63kWYvYSapdcTZ4x6/KGOgr2ZF
 PwiWvoKJulUmaXy1DvjUGqdZyYggs1XMZQRbp8+om+nyO8n0ApKA/39yY0LZyVzGGOni36++TKl
 BQPRO5HJwx68sA0D7t2gjiI5liMTHE3Sv4w4kABf4BkS7aRJF/OGx+gwhv+Q8lEQwfjnj+Ndhj8
 XJhZ00XIJ1yRcLjdwSFg57f6aTbLwyb5Xc54ot9BFv9Dx6i1niLiFn+5w1SVZAtJXqZP1pQneuL
 S+tqn8NSIqyMvHAqTqOG4WvIfyVa9G+MQhGecMLGS+6h/trMGhAWwzPVh5d9rRcwbvs0XGhZi/P
 kL2LHVhQL5quTjd8U/Ig6Mux2TzZSbrGwa0jjbe1Wwytw==
X-Received: by 2002:a05:600c:4515:b0:49c:c0d4:53d9 with SMTP id
 5b1f17b1804b1-49cf8273002mr232397105e9.14.1788799804299; 
 Mon, 07 Sep 2026 09:50:04 -0700 (PDT)
Received: from localhost (89-93-216-19.hfc.dyn.abo.bbox.fr. [89.93.216.19])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-49ce591f846sm200827645e9.1.2026.09.07.09.50.03
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 07 Sep 2026 09:50:03 -0700 (PDT)
Date: Mon, 07 Sep 2026 18:42:29 +0200
Subject: [PATCH 39/50] tests/qtest: ina230: cover a cleared calibration per
 channel
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260907-bmc-minerva-v1-39-0d83ad610c3b@free.fr>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1788799322; l=2259;
 i=emmanuel.blot@free.fr; s=20260602; h=from:subject:message-id;
 bh=GNmGo7bU7FZIBaUuYEeUYDpyrPaavNbXBkjimavlGKE=;
 b=Bxzff034JA32VQyuB9pyTahSx5144M/bWSmix9wX7PcRLpDcyyV78rP35YuNYlveXHJCxHQO3
 Nz6cmtOhAaIAZcUOU3HGurJ+xKbriGP/o5JChoVHjOXKUKRJuLzqpFV
X-Developer-Key: i=emmanuel.blot@free.fr; a=ed25519;
 pk=0qFrZ21FAAN8OfVsSoVcCFTk/NMYOWzxJz4paSAVm0g=
Received-SPF: pass client-ip=209.85.128.54; envelope-from=eblot.ml@gmail.com;
 helo=mail-wm1-f54.google.com
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

Verify that without a calibration value the current and power
registers read zero, whichever channels the mode converts.

Signed-off-by: Emmanuel Blot <emmanuel.blot@free.fr>
---
 tests/qtest/ina230-test.c | 25 +++++++++++++++++++++++++
 1 file changed, 25 insertions(+)

diff --git a/tests/qtest/ina230-test.c b/tests/qtest/ina230-test.c
index 591927e551..5749b0bd46 100644
--- a/tests/qtest/ina230-test.c
+++ b/tests/qtest/ina230-test.c
@@ -301,6 +301,30 @@ static void test_zero_cal(void *obj, void *data, QGuestAllocator *alloc)
     g_assert_cmphex(i2c_get16(dev, REG_POWER), ==, 0x0000);
 }
 
+/* Clearing the Calibration zeroes both derived registers in any mode */
+static void test_zero_cal_channels(void *obj, void *data,
+                                   QGuestAllocator *alloc)
+{
+    QI2CDevice *dev = (QI2CDevice *)obj;
+    static const uint8_t modes[] = { 0x5, 0x6, 0x7 };
+    size_t idx;
+
+    for (idx = 0; idx < ARRAY_SIZE(modes); idx++) {
+        i2c_set16(dev, REG_CONFIG, CONFIG_RST);
+        i2c_set16(dev, REG_CALIBRATION, 0x0A00);
+        qmp_ina230_set("shunt-voltage", 20000000);
+        qmp_ina230_set("bus-voltage", 11980000);
+        g_assert_cmphex(i2c_get16(dev, REG_CURRENT), !=, 0x0000);
+        g_assert_cmphex(i2c_get16(dev, REG_POWER), !=, 0x0000);
+
+        i2c_set16(dev, REG_CONFIG, modes[idx]);
+        i2c_set16(dev, REG_CALIBRATION, 0x0000);
+
+        g_assert_cmphex(i2c_get16(dev, REG_CURRENT), ==, 0x0000);
+        g_assert_cmphex(i2c_get16(dev, REG_POWER), ==, 0x0000);
+    }
+}
+
 /* Clamping at full scale and the OVF (math overflow) flag */
 static void test_edges_overflow(void *obj, void *data, QGuestAllocator *alloc)
 {
@@ -560,6 +584,7 @@ static void ina230_register_nodes(void)
                  NULL);
     qos_add_test("power", "ina230", test_power, NULL);
     qos_add_test("zero-cal", "ina230", test_zero_cal, NULL);
+    qos_add_test("zero-cal-channels", "ina230", test_zero_cal_channels, NULL);
     qos_add_test("edges-overflow", "ina230", test_edges_overflow, NULL);
     qos_add_test("alert-shunt-over", "ina230", test_alert_shunt_over, NULL);
     qos_add_test("alert-latch", "ina230", test_alert_latch, NULL);

-- 
2.50.1


