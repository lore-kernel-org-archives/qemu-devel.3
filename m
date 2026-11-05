Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A5F83606A328
	for <qemu-devel@archiver.kernel.org>; Thu,  5 Nov 2026 09:30:38 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xOtn2-00014O-Po; Thu, 05 Nov 2026 04:29:48 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eblot.ml@gmail.com>)
 id 1xOtn0-0000wd-D2
 for qemu-devel@nongnu.org; Thu, 05 Nov 2026 04:29:46 -0500
Received: from mail-pj1-f48.google.com ([209.85.216.48])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <eblot.ml@gmail.com>)
 id 1xOtmy-00073U-Em
 for qemu-devel@nongnu.org; Thu, 05 Nov 2026 04:29:45 -0500
Received: by mail-pj1-f48.google.com with SMTP id
 98e67ed59e1d1-3ab41538192so1376672a91.0
 for <qemu-devel@nongnu.org>; Thu, 05 Nov 2026 01:29:44 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793870982; x=1794475782;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=ElO83exPm/Nk9fwRFrC4lA4TMItjH/WcdCQDoITT8Is=;
 b=roCXqzNh/afHYTNjmvJRi9Bqsxj+Gs7fm+FsasgM5SP1aaw9xIC5gO8uItSmtv2nx+
 FXpsGT82U6+5jdAhzqxm3IThMC/ejpnp5nhQ3Sy8TN01frYui+mZmmKo9oRP+wuy6scv
 v2mtRInbdzvRCMaj+Z/FycQilWyEg/+l0j4HlNsfZXnAXE2qn+C02KVNdb0kx4Lw3Bxp
 Z7rhR/tTAIWh04HIQMvIvf3/Rb9AIh6p3v6cT+3dvWMJNVie+NBPzujwi4C027XMTWHq
 xgOHHA1g82bHT6r1OYJTpohR4PADoYSyBspn8diipHi1Eoxf4w75FXj6YpjcL0lUaqDs
 vQGg==
X-Gm-Message-State: APuU4Z+7IK66EGibgm0JovhVUQhOADoXTgJX6P47LjPUSW9cipazVgMZ
 SgW/7+mgi3Ofata9sMkgyDDapvSPPf3RRV5OEEhFMNtbOyKkdJpxHPgqBGNXtg==
X-Gm-Gg: AYBFou14jIErc6zgsfuzBnlEgfuff7GIv7UC2nfdruDeFVXOEZQllLqpTXfsyJYN/po
 AeG+0hVVTSoKHMrh3xyVPfLVfCfozNy7Lwq/bfeGiqfM1tuzcrQHl4x2ELR7a0etRSmTaohOZNk
 6Q94stPj0ZIPWa12IAJlSYIZR4KdrrQb2P128LtbunfwLxCBL0v/CpFb2+an47nsJuWzWzFCSrX
 89WUOFBswfZkpOkRve6fC3KADfyEFJXIufioMBduqQcrZEOj8Td3pQNb3JWuWkan0g8VXgX0N0U
 ho5iUZ/Q+UcwrFC840pzbGm/U04ArIKHNXeTDZgss0LhSvTb686ecjmTEDidBCuAXGcgEsIqpQp
 d8scwS+TKop5rRjpR7Gj8M9PX7qQroJqXU+1TDPuUwBwhQbn1vhhqUQyd66oZIH/lzlvpFyaTOX
 zltfttKmtLqw5TA+c8Iq/fua0WY9XddwgemFzVS6XsgHWiZMET8iQB6CmogfnZd1FLlH/FNJqD/
 TAF+Sg8H0TOFYZ/I7EBl0j5cpgxQsSol+gauqmmEGeU0qefwI3AEMP4GTJYG/H2iR41NkK1hwpl
 EJmAd/y3cE0fP/cvXhY8t8DxJ86oROzmXxwOztq6bGWXdGRJC6wF1mO1YNYytgU1u+DpVGL/j/K
 E
X-Received: by 2002:a17:90b:4c85:b0:3a4:b418:94ce with SMTP id
 98e67ed59e1d1-3ae89574db4mr14679727a91.1.1793870982530; 
 Thu, 05 Nov 2026 01:29:42 -0800 (PST)
Received: from localhost (118-163-122-149.hinet-ip.hinet.net.
 [118.163.122.149]) by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-3b0b90def97sm2561852a91.7.2026.11.05.01.29.41
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 05 Nov 2026 01:29:42 -0800 (PST)
Date: Thu, 05 Nov 2026 17:25:54 +0800
Subject: [PATCH 15/16] tests/qtest: tmp421: cover software reset and
 N-factor registers
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261105-sensor-tmp421-v1-15-c46853f5e1f0@free.fr>
References: <20261105-sensor-tmp421-v1-0-c46853f5e1f0@free.fr>
In-Reply-To: <20261105-sensor-tmp421-v1-0-c46853f5e1f0@free.fr>
To: qemu-devel@nongnu.org
Cc: =?utf-8?q?C=C3=A9dric_Le_Goater?= <clg@kaod.org>, eblot@meta.com, 
 =?utf-8?q?Philippe_Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>, 
 Peter Maydell <peter.maydell@linaro.org>, 
 Jamin Lin <jamin_lin@aspeedtech.com>, Kane Chen <kane_chen@aspeedtech.com>, 
 qemu-arm@nongnu.org, Fabiano Rosas <farosas@suse.de>, 
 Laurent Vivier <lvivier@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, 
 Emmanuel Blot <emmanuel.blot@free.fr>
X-Mailer: b4 0.16.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1793870743; l=2952;
 i=emmanuel.blot@free.fr; s=20260602; h=from:subject:message-id;
 bh=sHWJWSoGggCvrRbUN63qwoGmhhEQg3PCcE0NhyHKFWg=;
 b=yxdcLQU53y+WK88YgfgmoawGLklElF6qvy755iUWTlJxwCuEqcerwvhX2HmTwZsT4FSYLxgX9
 mduq/Zd70e8BaQONwD271wabEIf5ZdxGRDM4IQ0BDbvZ+6SFvIUlspH
X-Developer-Key: i=emmanuel.blot@free.fr; a=ed25519;
 pk=0qFrZ21FAAN8OfVsSoVcCFTk/NMYOWzxJz4paSAVm0g=
Received-SPF: pass client-ip=209.85.216.48; envelope-from=eblot.ml@gmail.com;
 helo=mail-pj1-f48.google.com
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
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Check that the software-reset register restores the configuration and
conversion-rate defaults, and that the N-factor correction registers
are writable only on the remote channels each variant provides.

Signed-off-by: Emmanuel Blot <emmanuel.blot@free.fr>
---
 tests/qtest/tmp421-test.c | 37 +++++++++++++++++++++++++++++++++++++
 1 file changed, 37 insertions(+)

diff --git a/tests/qtest/tmp421-test.c b/tests/qtest/tmp421-test.c
index 04f9252188..6c5332211b 100644
--- a/tests/qtest/tmp421-test.c
+++ b/tests/qtest/tmp421-test.c
@@ -25,6 +25,7 @@
 #define    TMP421_CONFIG_REN              (1 << 4)
 #define TMP421_CONVERSION_RATE_REG      0x0B
 #define TMP421_TEMP_LSB0                0x10
+#define TMP421_N_CORRECT                0x21
 #define TMP421_RESET                    0xFC
 #define TMP421_MANUFACTURER_ID_REG      0xFE
 #define TMP421_DEVICE_ID_REG            0xFF
@@ -191,6 +192,38 @@ static void test_channels(void *obj, void *data, QGuestAllocator *alloc)
     g_assert_cmphex(i2c_get16(i2cdev, TMP421_TEMP_MSB0 + 1), ==, 0x1900);
 }
 
+static void test_soft_reset(void *obj, void *data, QGuestAllocator *alloc)
+{
+    const TMP421Variant *var = data;
+    QI2CDevice *i2cdev = obj;
+
+    i2c_set8(i2cdev, TMP421_CONFIG_REG_1, TMP421_CONFIG_RANGE);
+    i2c_set8(i2cdev, TMP421_CONFIG_REG_2, 0);
+    i2c_set8(i2cdev, TMP421_CONVERSION_RATE_REG, 0);
+
+    i2c_set8(i2cdev, TMP421_RESET, 0);
+
+    g_assert_cmphex(i2c_get8(i2cdev, TMP421_CONFIG_REG_1), ==, 0);
+    g_assert_cmphex(i2c_get8(i2cdev, TMP421_CONFIG_REG_2), ==,
+                    var->config2_reset);
+    g_assert_cmphex(i2c_get8(i2cdev, TMP421_CONVERSION_RATE_REG), ==, 0x07);
+}
+
+static void test_n_correct(void *obj, void *data, QGuestAllocator *alloc)
+{
+    const TMP421Variant *var = data;
+    QI2CDevice *i2cdev = obj;
+
+    for (unsigned remote = 0; remote < 3; remote++) {
+        uint8_t reg = TMP421_N_CORRECT + remote;
+
+        i2c_set8(i2cdev, reg, 0x7f);
+        /* Registers exist only for the variant's remote channels. */
+        g_assert_cmphex(i2c_get8(i2cdev, reg), ==,
+                        remote + 1 < var->nchannels ? 0x7f : 0);
+    }
+}
+
 static void tmp421_register_node(const TMP421Variant *var, const char *type,
                                  uint8_t addr)
 {
@@ -207,6 +240,10 @@ static void tmp421_register_node(const TMP421Variant *var, const char *type,
                  &(QOSGraphTestOptions) { .arg = (void *)var });
     qos_add_test("channels", type, test_channels,
                  &(QOSGraphTestOptions) { .arg = (void *)var });
+    qos_add_test("soft-reset", type, test_soft_reset,
+                 &(QOSGraphTestOptions) { .arg = (void *)var });
+    qos_add_test("n-correct", type, test_n_correct,
+                 &(QOSGraphTestOptions) { .arg = (void *)var });
 }
 
 static void tmp421_register_nodes(void)

-- 
2.53.0-Meta


