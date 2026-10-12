Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 541C5CA9ED1
	for <qemu-devel@archiver.kernel.org>; Mon, 12 Oct 2026 15:33:10 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xGI1L-0006to-4A; Mon, 12 Oct 2026 11:33:01 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eblot.ml@gmail.com>)
 id 1xGI0s-0006i7-Vl
 for qemu-devel@nongnu.org; Mon, 12 Oct 2026 11:32:35 -0400
Received: from mail-wm1-f45.google.com ([209.85.128.45])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <eblot.ml@gmail.com>)
 id 1xGI0p-0002jL-Ed
 for qemu-devel@nongnu.org; Mon, 12 Oct 2026 11:32:30 -0400
Received: by mail-wm1-f45.google.com with SMTP id
 5b1f17b1804b1-4a018792ab3so17425165e9.0
 for <qemu-devel@nongnu.org>; Mon, 12 Oct 2026 08:32:21 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1791819141; x=1792423941;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=7JIouwvsYhybUqJx3bKqTjTPWbvwF34ZaZVav4+/RP8=;
 b=HZ4pvob/KsGoHWb84v6kK31tbjuHv0NNfMzeeiV4i4v/E33fTy62REuF+D7YRNuM9f
 eedtsdin/2o3vkKTKNLRY099H4jmazXybk8kypENyWkOtDa/TFShhbCkjxXv+LjgMaIa
 vkHgvHgDiWBGE07/wRpXxaky9N0WkxgSTBNsYcZirNb2tcGrerx+IUbioNzWsbVmBwg0
 ryXeXi+bhIVnQmqNxAI6tx4xpml02t70pTxxQz1My6bHXQLnpcuRdJeuPhfjghAMCUpY
 +hv/BmREtc7bmgZyvmv7bT7GrSI8B0gzkSDt5q6CU+Bwev689uopVKwbHFh26MeMtxBx
 Q5Zw==
X-Gm-Message-State: AFq9FYJzC5JLRh+OY9/aJ8sdJ3aMUu9LHuMBoSfEBlVwzr01drC3NkE3
 +qkRLOwFbNjXOFfOztTnnLujt95CMJ+9zM44niPVjancsdPh/YImjNHrbQXUmccH
X-Gm-Gg: AYBFou3QlnRDL4c30Swa77u9jY3tdiyZXNPZfBPI6rLcZzCFL6SqCjkufcfKn0XNqg3
 XHOoaoJD0T2mFdAYaUqcCoOt4zQ70mWeraSL8u98JUW9xlzDkMnAG3GzqYmZ2fo5EOvYIpIoghy
 8dF4F116yO91Kr1Thc7AT/ANMlEBgTCZU7vem+ckfMODtn2tt6FjXbbw++7u7/MC0gBuVhs+xT0
 uqniAG+LAAAEBsymV3oKqdo3Bj9Hs+0UztEkzDNG7JtQekpz2Oi6mxsnHf6rc0HRFnUPzBToRzb
 /fM6SMDt8MkCwH/4Lle6Willt8yL94L3aCetPV17fHuhaPdGZlhcAbrCBDCbIZ6GzE7DOlFjSXf
 Ar3LpTE3gPQ3c1K/oGYkwjSJLOD0xUdJ7huQ8chYv4OVjLRx64tnfEFs3fdMHzBHH6v4VGUefCp
 0vPgwMiDikWoaEAaAPQo4NgyGyHzmTa8YvXvriKdmqg2mozIBuLp1C/n8kT0QGkX95h/8KPfIEl
 akl60M7ZiRwPuTpYSZ3aGxXqEw22/Qw+HVVgJYLklgHUg==
X-Received: by 2002:a05:600c:3e0a:b0:4a0:1c10:1419 with SMTP id
 5b1f17b1804b1-4a18e4cd667mr186910165e9.26.1791819140449; 
 Mon, 12 Oct 2026 08:32:20 -0700 (PDT)
Received: from localhost (89-93-216-19.hfc.dyn.abo.bbox.fr. [89.93.216.19])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-48de0aaa9f9sm85865f8f.19.2026.10.12.08.32.19
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 12 Oct 2026 08:32:19 -0700 (PDT)
Date: Mon, 12 Oct 2026 16:32:32 +0200
Subject: [PATCH v2 39/50] tests/qtest: ina230: cover a cleared calibration
 per channel
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261012-bmc-minerva-v2-39-4c3dff084ec9@free.fr>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1791815521; l=2259;
 i=emmanuel.blot@free.fr; s=20260602; h=from:subject:message-id;
 bh=GNmGo7bU7FZIBaUuYEeUYDpyrPaavNbXBkjimavlGKE=;
 b=YHHcAWAL+RN/mB2DoSS6parFIvowP00mb1BSSostYSkVZ3/SSqW4obiZgjD8l/BZpUp350YFr
 5qNe/1wGWl7CDAUdOv5Dw5YM2jtNJeS4xjpTNnfdJwWiY7dOVIndjHS
X-Developer-Key: i=emmanuel.blot@free.fr; a=ed25519;
 pk=0qFrZ21FAAN8OfVsSoVcCFTk/NMYOWzxJz4paSAVm0g=
Received-SPF: pass client-ip=209.85.128.45; envelope-from=eblot.ml@gmail.com;
 helo=mail-wm1-f45.google.com
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


