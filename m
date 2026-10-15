Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0F355CC6B33
	for <qemu-devel@archiver.kernel.org>; Thu, 15 Oct 2026 15:15:22 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xHN7e-000868-JZ; Thu, 15 Oct 2026 11:11:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eblot.ml@gmail.com>)
 id 1xHN7X-0007uC-RZ
 for qemu-devel@nongnu.org; Thu, 15 Oct 2026 11:11:55 -0400
Received: from mail-wm1-f46.google.com ([209.85.128.46])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <eblot.ml@gmail.com>)
 id 1xHN7U-0001tn-8N
 for qemu-devel@nongnu.org; Thu, 15 Oct 2026 11:11:50 -0400
Received: by mail-wm1-f46.google.com with SMTP id
 5b1f17b1804b1-4a16c399641so52430625e9.2
 for <qemu-devel@nongnu.org>; Thu, 15 Oct 2026 08:11:47 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792077106; x=1792681906;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=tMqRetAxiQAIvpDJW998EtamxiidvOknZM6HJPGhQpw=;
 b=btbYyOG123HeOcEINyi2O4NC13XCC8USI0El5Du6l97TdjyJe5ILlqGaKqIJqA46cN
 dr4xaZsx1ZLTdtpeg/m2dH8/HOztgbLxa8JL0hL6iYSGQ4EI/8rH7aRhsFJxJJGJbLgn
 HMsO5uFZrgWRRAUY4+JbOBMMpIAYEAVH8wMqQWjiDWtAIWPQiMgkkla7RvKgjJVUCyxB
 I8rHKyOaRSXRI5/P/XPJhDSf6LtMbevGIci7xBssumQBVrACmEDLtumAxKeIBgFATSJR
 Ex93n8aZL1qJtlwEnDM4S/xXZRzP4gxk/VPltRU9V8xcT1XhyfRiHkXSZjcpgCvbNd+A
 nApg==
X-Gm-Message-State: AFq9FYJlDivAKYplFS4wevLaQMe77UFCYChCu3oUxjmUDqs/7rADp7DO
 0Unmx2LfjR2V2rhzK9AYCjn1QL0kLnxi+HJhvtDhU3lYQiJXqXYAa51YFQl5bQ==
X-Gm-Gg: AYBFou2szSQl3STCSwB7jPQPu+Oqy2lQKVQP1mUg/j+YK0hRZuFTxRFGeCYCLT/goXk
 /MN6eDaZvxsNPKJN5ipTBmdXJaq/Xhqai3p/kNnppYdzDWM91vxTS8s08miUIX8Yj1ZIfmf86R8
 O//KpcVbArNCBs7oSX3JvUlinzYG4z9hj/EEILO+KzqWwBwseNDhWi/yHYlhGooVvzhlmff76+D
 +L92x/RyagtQ1xpu8eWrLGuB6EbQnXieBkr97e0bbTXZFT36ZbS/xmmgNy2NB2Q1qQWgLjjo7+U
 a3gCGVWoqWwWL4YysT+4l7+Tt02H7Ou7PK+zuc3Rl6pWreQOzCzWwC9hIKSNR+kD1bDsQzeThEB
 KfxyovOY/0v2vnjCFNbbHjmiyq8o+tThAWWBUY4skqBBLqf6bQ/pergY30l04BqkGdfL97BKmXu
 s5BEir37sjUhAi6s7ksHUcytpjwNTFDLJRI7gGvRcAS601bW4DmSbABjZ2bpVKS7+s/EkeQixjJ
 Eou3BvjZeyTAIaDLKR/icItzPcT3EHvJPrZRu/qgFjNLw==
X-Received: by 2002:a05:600c:608d:b0:49c:cee0:e7c1 with SMTP id
 5b1f17b1804b1-4a18e48d45cmr423407005e9.16.1792077106332; 
 Thu, 15 Oct 2026 08:11:46 -0700 (PDT)
Received: from localhost (89-93-216-19.hfc.dyn.abo.bbox.fr. [89.93.216.19])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4a1bd67a080sm76025545e9.3.2026.10.15.08.11.45
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 15 Oct 2026 08:11:45 -0700 (PDT)
Date: Thu, 15 Oct 2026 13:57:52 +0200
Subject: [PATCH 14/22] tests/qtest: tmp421: cover per-variant channels and
 enablement
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261015-bmc-clemente-v1-14-bf591886b5b6@free.fr>
References: <20261015-bmc-clemente-v1-0-bf591886b5b6@free.fr>
In-Reply-To: <20261015-bmc-clemente-v1-0-bf591886b5b6@free.fr>
To: qemu-devel@nongnu.org
Cc: =?utf-8?q?Philippe_Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>, 
 =?utf-8?q?C=C3=A9dric_Le_Goater?= <clg@kaod.org>, 
 Peter Maydell <peter.maydell@linaro.org>, 
 Steven Lee <steven_lee@aspeedtech.com>, Troy Lee <leetroy@gmail.com>, 
 Jamin Lin <jamin_lin@aspeedtech.com>, Kane Chen <kane_chen@aspeedtech.com>, 
 Andrew Jeffery <andrew@codeconstruct.com.au>, Joel Stanley <joel@jms.id.au>, 
 qemu-arm@nongnu.org, Fabiano Rosas <farosas@suse.de>, 
 Laurent Vivier <lvivier@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, 
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>, 
 Emmanuel Blot <emmanuel.blot@free.fr>
X-Mailer: b4 0.16.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1792065465; l=3174;
 i=emmanuel.blot@free.fr; s=20260602; h=from:subject:message-id;
 bh=6nvwu9Ryau4lnUGBjjuEHQaAZ8bpboeH30ZpsRWrAg8=;
 b=HhA8RHg1vxLyr/RENBtHEhSzLZGngzeRTfx5zbWgykNa6LMEYbLF2r/UAYqLyKP0TS7KRyP6S
 ROVZx8tVuY9AMA3PQUv2DJSFhIhdN0FH4OXdx/Pr5HBaTV2yHZH//Kj
X-Developer-Key: i=emmanuel.blot@free.fr; a=ed25519;
 pk=0qFrZ21FAAN8OfVsSoVcCFTk/NMYOWzxJz4paSAVm0g=
Received-SPF: pass client-ip=209.85.128.46; envelope-from=eblot.ml@gmail.com;
 helo=mail-wm1-f46.google.com
X-Spam_score_int: 0
X-Spam_score: -0.1
X-Spam_bar: /
X-Spam_report: (-0.1 / 5.0 requ) BAYES_00=-1.9, DATE_IN_PAST_03_06=1.592,
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

Check that each variant exposes only its own temperature properties,
that writing an absent channel's enable bit is ignored, and that
disabling a present channel makes it read back as zero.

Signed-off-by: Emmanuel Blot <emmanuel.blot@free.fr>
---
 tests/qtest/tmp421-test.c | 37 +++++++++++++++++++++++++++++++++++++
 1 file changed, 37 insertions(+)

diff --git a/tests/qtest/tmp421-test.c b/tests/qtest/tmp421-test.c
index 390f17b6b2..04f9252188 100644
--- a/tests/qtest/tmp421-test.c
+++ b/tests/qtest/tmp421-test.c
@@ -22,6 +22,7 @@
 #define TMP421_CONFIG_REG_1             0x09
 #define    TMP421_CONFIG_RANGE            (1 << 2)
 #define TMP421_CONFIG_REG_2             0x0A
+#define    TMP421_CONFIG_REN              (1 << 4)
 #define TMP421_CONVERSION_RATE_REG      0x0B
 #define TMP421_TEMP_LSB0                0x10
 #define TMP421_RESET                    0xFC
@@ -78,6 +79,15 @@ static void set_temperature(const char *id, unsigned channel, int value)
     qobject_unref(response);
 }
 
+static bool has_temperature(const char *id, unsigned channel)
+{
+    QDict *response = qmp_get_temperature(id, channel);
+    bool present = qdict_haskey(response, "return");
+
+    qobject_unref(response);
+    return present;
+}
+
 static void test_ids(void *obj, void *data, QGuestAllocator *alloc)
 {
     const TMP421Variant *var = data;
@@ -156,6 +166,31 @@ static void test_range_saturation(void *obj, void *data,
     g_assert_cmphex(i2c_get16(i2cdev, TMP421_TEMP_MSB0), ==, 0xD5F0);
 }
 
+static void test_channels(void *obj, void *data, QGuestAllocator *alloc)
+{
+    const TMP421Variant *var = data;
+    QI2CDevice *i2cdev = obj;
+
+    /* Only the variant's own channels expose a temperature property. */
+    for (unsigned ch = 0; ch < 4; ch++) {
+        g_assert_true(has_temperature(var->id, ch) == (ch < var->nchannels));
+    }
+
+    /* Absent channel enables and reserved bits are dropped on write. */
+    i2c_set8(i2cdev, TMP421_CONFIG_REG_2, 0xff);
+    g_assert_cmphex(i2c_get8(i2cdev, TMP421_CONFIG_REG_2), ==,
+                    var->config2_reset);
+
+    /* Disabling remote channel 1 makes it read back as zero. */
+    set_temperature(var->id, 1, 25001);
+    g_assert_cmphex(i2c_get16(i2cdev, TMP421_TEMP_MSB0 + 1), ==, 0x1900);
+    i2c_set8(i2cdev, TMP421_CONFIG_REG_2,
+             var->config2_reset & ~TMP421_CONFIG_REN);
+    g_assert_cmphex(i2c_get16(i2cdev, TMP421_TEMP_MSB0 + 1), ==, 0);
+    i2c_set8(i2cdev, TMP421_CONFIG_REG_2, var->config2_reset);
+    g_assert_cmphex(i2c_get16(i2cdev, TMP421_TEMP_MSB0 + 1), ==, 0x1900);
+}
+
 static void tmp421_register_node(const TMP421Variant *var, const char *type,
                                  uint8_t addr)
 {
@@ -170,6 +205,8 @@ static void tmp421_register_node(const TMP421Variant *var, const char *type,
 
     qos_add_test("ids", type, test_ids,
                  &(QOSGraphTestOptions) { .arg = (void *)var });
+    qos_add_test("channels", type, test_channels,
+                 &(QOSGraphTestOptions) { .arg = (void *)var });
 }
 
 static void tmp421_register_nodes(void)

-- 
2.53.0-Meta


