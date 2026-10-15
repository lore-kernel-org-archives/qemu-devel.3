Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7ECC0CC6B3D
	for <qemu-devel@archiver.kernel.org>; Thu, 15 Oct 2026 10:37:13 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xHIlN-0003R8-Un; Thu, 15 Oct 2026 06:32:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eblot.ml@gmail.com>)
 id 1xHIhb-0007sf-Op
 for qemu-devel@nongnu.org; Thu, 15 Oct 2026 06:28:51 -0400
Received: from mail-wr1-f50.google.com ([209.85.221.50])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <eblot.ml@gmail.com>)
 id 1xHIhP-0004QQ-5S
 for qemu-devel@nongnu.org; Thu, 15 Oct 2026 06:28:44 -0400
Received: by mail-wr1-f50.google.com with SMTP id
 ffacd0b85a97d-48af4d4e61fso3748615f8f.2
 for <qemu-devel@nongnu.org>; Thu, 15 Oct 2026 03:28:34 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792060113; x=1792664913;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=eT68nxMn01vW7O3JJprDmDkWOIfn9yjPcnQ/rqWRCTw=;
 b=koSpdOPz50Ur21NL6PylvLNVIVAc2bJ3UxcSVnBJrIo/5zr8jNQw8sZ/2kXmXDCCE0
 e7OZp+w0H/dT7PgZmhdw+hWfxsqSfnYuWzRg0zmcHp3XPbDYoJHR4YT3zbNUSy73MlhV
 4CD1eREdcsaracmH5FT+HqMV5ZTfg3Wxg17n4TiqSKDC7Ev1vzb1k+G7IJnPYuyLrIVW
 VfIvSBD6J0YhnY3dgR/eftVAaKqvOadmcK7qccvcvQEcXozAU4ybRGeQVM/j0Ve4SuNn
 KZ/v14vjnEKYNOPbLzHD+2j7+r5PqWiAbAZVl9kGJApKjzJKEiWxawPC1d4mlMKtVgfD
 pqEQ==
X-Gm-Message-State: AFq9FYKDZS4Lvp2wR5RowGlQQR+4lSwJGJutqUc8p6mmW+y7vqBZLsaO
 34TIZVwCG4r534+E8rarfxhZyHFwv1E5iq648XQqVun+WMnZKpAVdlnmvqDxyA==
X-Gm-Gg: AYBFou1oqABY9Yk3emZ8QuuypwW3qKNi82rx1AYqqDc8Qm9KhFPg6atEDKSk2Nmg/9h
 NHq5DFbHvJiQFX+qsgBXp2Lo1iFkp78WZ0p0AG19AvVngkmtIjy7uFhk78Ws3JlvHLY794mUoIe
 qjQPYx0Jg8r2vNP7+OXnQ6JXHFQZdCpgd0nkN02wkqFxn+HdJRSptgWqKpX7QjwvxlkBkgRvx/y
 Y/nZVvMU8FvhJckxW55BiP3cDrNVdDNERGvxpsi9DZx7kSHt1QyQm97TpJ+MfmN/UzjBvp/Sl2I
 9gyB2LCMKpjdj226yDdZxe7SxrJbfJi1SBdRZeFyvmq/So3HugGgTzRsUnKvcOW9RVMUh1c1g8G
 9pOFxS6o62XrCzlqzZ3AycGN9fpid8SfO/yNfbp8yq/j1DetV0p4QCVqBymBM6AAFg7ubIJbMcJ
 8ezWguOelMKs/BwVDvrPHGANhhQg4OfD9h5YvyPBCaRPB3uvF0eG1sd1T9rhIgcNHZ6q4SQ6oql
 hosJNcqq8j3R0c1XOeUemF1globyiHS5Ci3frWkkIFW+Q==
X-Received: by 2002:a05:6000:2584:b0:48d:f14a:917a with SMTP id
 ffacd0b85a97d-48df14a9278mr6447729f8f.48.1792060113001; 
 Thu, 15 Oct 2026 03:28:33 -0700 (PDT)
Received: from localhost (89-93-216-19.hfc.dyn.abo.bbox.fr. [89.93.216.19])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-48df57e8549sm2765816f8f.0.2026.10.15.03.28.31
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 15 Oct 2026 03:28:32 -0700 (PDT)
Date: Thu, 15 Oct 2026 11:28:26 +0200
Subject: [PATCH v3 39/50] tests/qtest: ina230: cover a cleared calibration
 per channel
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261015-bmc-minerva-v3-39-7d50c8a108e5@free.fr>
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
 Emmanuel Blot <emmanuel.blot@free.fr>, Glenn Miles <milesg@linux.ibm.com>
X-Mailer: b4 0.16.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1792056476; l=2313;
 i=emmanuel.blot@free.fr; s=20260602; h=from:subject:message-id;
 bh=PzxGOCXpiAe3gOLqCnGKqAPPjR61GoJKj4uRIt53Dm4=;
 b=bJb2wT2ZeI9+k0h0aJE+pP6RFyQjal6KrsGQyeAEVh0Rk0I4neF+iKUwkSgCoFfyixERZAvjo
 VjOp9Ccuu+6Azeo5m8qFQlKX6FAnoLmcrFpXjR+gHv+97ssbMj/KXe7
X-Developer-Key: i=emmanuel.blot@free.fr; a=ed25519;
 pk=0qFrZ21FAAN8OfVsSoVcCFTk/NMYOWzxJz4paSAVm0g=
Received-SPF: pass client-ip=209.85.221.50; envelope-from=eblot.ml@gmail.com;
 helo=mail-wr1-f50.google.com
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

Reviewed-by: Glenn Miles <milesg@linux.ibm.com>
Signed-off-by: Emmanuel Blot <emmanuel.blot@free.fr>
---
 tests/qtest/ina230-test.c | 25 +++++++++++++++++++++++++
 1 file changed, 25 insertions(+)

diff --git a/tests/qtest/ina230-test.c b/tests/qtest/ina230-test.c
index cda52bb815..f9e8d3ab9f 100644
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
2.53.0-Meta


