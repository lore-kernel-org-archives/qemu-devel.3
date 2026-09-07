Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3BE74C79FAB
	for <qemu-devel@archiver.kernel.org>; Mon,  7 Sep 2026 16:48:32 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x3cWD-0004Gg-Ta; Mon, 07 Sep 2026 12:48:29 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eblot.ml@gmail.com>)
 id 1x3cWB-0004A0-HK
 for qemu-devel@nongnu.org; Mon, 07 Sep 2026 12:48:27 -0400
Received: from mail-wm2-f12.google.com ([74.125.225.140])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <eblot.ml@gmail.com>)
 id 1x3cW8-0003yb-EI
 for qemu-devel@nongnu.org; Mon, 07 Sep 2026 12:48:27 -0400
Received: by mail-wm2-f12.google.com with SMTP id
 5b1f17b1804b1-49b912e2406so1837895e9.1
 for <qemu-devel@nongnu.org>; Mon, 07 Sep 2026 09:48:22 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1788799702; x=1789404502;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=UwwxETLAztE1k6Pih+RsWxpK5u/uYELdrNm5CxCbYqw=;
 b=ZVyC/SyNozD/nZVf4hL2Piwlrr4kY8EUtTpO0LmRZ6ximwZwy0LeNrbvUd2WlGWTCm
 VCiPL0cmV3v3KnMabe2hM9X90EmIFc9YkNukGxLvpdYhoX5jsPWSGuTIfRvbc6t7K/lO
 7N3bOKqymTkGY/ivn8MCJn1kwcXIqfIeyriI9Dd+R2n6XQ5KDNbQaP66+ObTTyP0TaAj
 3JYyiJgPACAgDlE4E8BO4SFKtaW6wCOTtqvkSvtEG5IX8daRQmdAJ38+nPKZHAlvSFRX
 cIEKLLBMY0YUV8JoSHs8IYWYzoWHjqK68rYLm2WkYs1S9rGo82OTzRhyXpdKfyEj/Njb
 6jew==
X-Gm-Message-State: AFuF++lhwgkzRQc0Bsak+K6gR3oSlksWnNifZTU3Z78bOqpikxQ7pJrt
 AiI2ht/Qfq54RGV/7q4WIITlQRvxqnAAhFT/nOZVrNguhoR/j5TihspDCS85cYzJ
X-Gm-Gg: AYBFou0aQPSZvcF0HABlstlUL2UyzVr2X9MZIi7fWLZd0GCYU0D7ySI6L/ifJqcGA1H
 3mw9Fdscskp47b7VckRIECOHsZ0sF4z+xAm+lj0Hkeommejp1L+OKjT+YkvpEEgLJfxweUKqYML
 KYsgTW/UBee6mnROmriVZjxSd9nQJvgC7DdIQ1fBl/62eH9ABJN0JhyM7rfF64DPAWzfLOy+hCk
 30Wo/gjEAWxmK1cu/J4xsEfjKNdeR5opQ159qj/ALRWweZ0cOGmey1xjU4HkIsNGBsEQhNnLw7y
 bRVPcYFycQNJ8/O61RiEpSQoxp1pNr5lkPiGe1hbkrk4aNisH4eksv+C1dSDhTkGGW633Ug+36B
 VqkbvzoJT5WnuLk30/KihXKhJMHwR8LTaafzrNRDTs4zCnAV+SVxW+nNlU0e8tfHAsnaU5RW38m
 cz8ISN7vvDTXmYYTOpwOGqk8HJ6AbHnSv7xtSDSxwmwJEtrCs5tTyxiCnRADTTfCnojm3PuSG5z
 1TGDtGfupc3Nf69glQEHHw8ZFxTvIxr0C0=
X-Received: by 2002:a05:600c:c4b8:b0:49b:8f5e:51fb with SMTP id
 5b1f17b1804b1-49d17543be5mr23115645e9.3.1788799701596; 
 Mon, 07 Sep 2026 09:48:21 -0700 (PDT)
Received: from localhost (89-93-216-19.hfc.dyn.abo.bbox.fr. [89.93.216.19])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-49ce831af89sm286858465e9.1.2026.09.07.09.48.19
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 07 Sep 2026 09:48:20 -0700 (PDT)
Date: Mon, 07 Sep 2026 18:42:20 +0200
Subject: [PATCH 30/50] tests/qtest: ds1339: cover persist-on-reset
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260907-bmc-minerva-v1-30-0d83ad610c3b@free.fr>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1788799321; l=3347;
 i=emmanuel.blot@free.fr; s=20260602; h=from:subject:message-id;
 bh=40jEbTSK65E3MsKCMaeknpjZMmqbQRo2Y3v73NUToek=;
 b=ZFO5CpeGmTn3Hy1w5L73yZy7vcKC/+kqjkZRXezIpJjiTjL4uJ0/lxPaYjWjgIGjqTHrn25ma
 OpW9RPEheCBBFNYtjIiKTUzjmgaL10V6emK9mVTgxYCdMkk7sjHZIxQ
X-Developer-Key: i=emmanuel.blot@free.fr; a=ed25519;
 pk=0qFrZ21FAAN8OfVsSoVcCFTk/NMYOWzxJz4paSAVm0g=
Received-SPF: pass client-ip=74.125.225.140; envelope-from=eblot.ml@gmail.com;
 helo=mail-wm2-f12.google.com
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

The property was untested on this variant.

Signed-off-by: Emmanuel Blot <emmanuel.blot@free.fr>
---
 tests/qtest/ds1339-test.c | 56 +++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 56 insertions(+)

diff --git a/tests/qtest/ds1339-test.c b/tests/qtest/ds1339-test.c
index 12562eff5f..a1b5afb331 100644
--- a/tests/qtest/ds1339-test.c
+++ b/tests/qtest/ds1339-test.c
@@ -8,7 +8,10 @@
 
 #include "qemu/osdep.h"
 #include "qemu/bcd.h"
+#include "libqtest.h"
+#include "libqtest-single.h"
 #include "libqos/i2c.h"
+#include "qobject/qdict.h"
 
 #define DS1339_ADDR 0x68
 
@@ -426,6 +429,52 @@ static void test_alarm_registers(void *obj, void *data,
     }
 }
 
+/* A reset restores the power-on state, unless persist-on-reset is set. */
+static void check_reset(QI2CDevice *i2cdev, bool persists)
+{
+    uint8_t year = i2c_get8(i2cdev, DS1339_YEAR);
+    /* A year the clock is not already showing, so the check discriminates. */
+    uint8_t marker = year == 0x42 ? 0x77 : 0x42;
+    QDict *rsp;
+
+    i2c_set8(i2cdev, DS1339_ALARM1, 0xa5);
+    i2c_set8(i2cdev, DS1339_STATUS, 0x00);
+    i2c_set8(i2cdev, DS1339_YEAR, marker);
+    g_assert_cmphex(i2c_get8(i2cdev, DS1339_ALARM1), ==, 0xa5);
+    g_assert_cmphex(i2c_get8(i2cdev, DS1339_STATUS), ==, 0x00);
+    g_assert_cmphex(i2c_get8(i2cdev, DS1339_YEAR), ==, marker);
+
+    rsp = qmp("{ 'execute': 'system_reset' }");
+    g_assert(qdict_haskey(rsp, "return"));
+    qobject_unref(rsp);
+    qmp_eventwait("RESET");
+
+    if (persists) {
+        g_assert_cmphex(i2c_get8(i2cdev, DS1339_ALARM1), ==, 0xa5);
+        g_assert_cmphex(i2c_get8(i2cdev, DS1339_STATUS), ==, 0x00);
+        g_assert_cmphex(i2c_get8(i2cdev, DS1339_YEAR), ==, marker);
+    } else {
+        g_assert_cmphex(i2c_get8(i2cdev, DS1339_ALARM1), ==, 0x00);
+        g_assert_cmphex(i2c_get8(i2cdev, DS1339_CONTROL), ==, 0x18);
+        g_assert_cmphex(i2c_get8(i2cdev, DS1339_STATUS), ==,
+                        DS1339_STATUS_OSF);
+        /* Back on host time, which is where the year came from. */
+        g_assert_cmphex(i2c_get8(i2cdev, DS1339_YEAR), ==, year);
+    }
+}
+
+/* Without persist-on-reset, a reset takes the part back to power-on. */
+static void test_reset_clears(void *obj, void *data, QGuestAllocator *alloc)
+{
+    check_reset((QI2CDevice *)obj, false);
+}
+
+/* With persist-on-reset, the registers and the clock survive a reset. */
+static void test_reset_persists(void *obj, void *data, QGuestAllocator *alloc)
+{
+    check_reset((QI2CDevice *)obj, true);
+}
+
 static void ds1339_register_nodes(void)
 {
     QOSGraphEdgeOptions opts = {
@@ -459,6 +508,13 @@ static void ds1339_register_nodes(void)
     qos_add_test("block-wrap", "ds1339", test_block_wrap, NULL);
     qos_add_test("alarm-registers", "ds1339", test_alarm_registers,
                  NULL);
+    qos_add_test("reset-clears", "ds1339", test_reset_clears, NULL);
+
+    opts.extra_device_opts = "address=0x68,persist-on-reset=on";
+    qos_node_create_driver_named("ds1339-persist", "ds1339", i2c_device_create);
+    qos_node_consumes("ds1339-persist", "i2c-bus", &opts);
+
+    qos_add_test("reset-persists", "ds1339-persist", test_reset_persists, NULL);
 }
 
 libqos_init(ds1339_register_nodes);

-- 
2.50.1


