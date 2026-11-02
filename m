Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 39DF7606A336
	for <qemu-devel@archiver.kernel.org>; Mon,  2 Nov 2026 10:21:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=eACJTi8+
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xNpAY-0002W8-9a; Mon, 02 Nov 2026 05:21:38 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <lorandmarton.dev@gmail.com>)
 id 1xNpAV-0002VE-Gr
 for qemu-devel@nongnu.org; Mon, 02 Nov 2026 05:21:35 -0500
Received: from mail-wr1-x42a.google.com ([2a00:1450:4864:20::42a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <lorandmarton.dev@gmail.com>)
 id 1xNpAT-0006Pv-Nf
 for qemu-devel@nongnu.org; Mon, 02 Nov 2026 05:21:35 -0500
Received: by mail-wr1-x42a.google.com with SMTP id
 ffacd0b85a97d-48c4d99c32bso1918383f8f.1
 for <qemu-devel@nongnu.org>; Mon, 02 Nov 2026 02:21:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20260707; t=1793614892; x=1794219692; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=92x6VYbWsp8ciG3WX4q28/bD1bwxNpteWF3TJUaiUvo=;
 b=eACJTi8++y6uxm+/KqdL8jh6wnCmm3ZdY0bGylYNpcuzpFRG6b1A5V730nz94nRAEe
 KevYVtcZkQVwjgtimCZ0PBI0QAf55spf39jx7s1DIdBr3JA7yyJRn6qBIOYIhkYVFUfS
 lyWNLBVua0vXZVDUFwWLeJ4N1F05KsFgqlpbTUGHpexNsxeC2dRrP3p3QiGhoIqjHYfB
 Vf0KseCiuW95yq9r5uWTNocP5+4At3L5eNDDciDAgDRoVmZxyP8daUesY8+3dMVQHNmj
 r6nZdstQpvRJo8Ti1dsLYWhtkwfm/8L2Zvq1qTTB+F3N4m8Y4VtsCSmnXcqFiFWoU7xV
 ubzQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793614892; x=1794219692;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=92x6VYbWsp8ciG3WX4q28/bD1bwxNpteWF3TJUaiUvo=;
 b=vnzYGcdBl2/TrD/3PP+Gq851TYL5vc2bLj/c1a+h2uO+COHb7HMASxiB/Rt6R9CKXC
 eM9pRkynYCdP5aU1MWnmIfmwioan2wySIj1RZHbL3Spps7OiwPTje1JdrXybqAgueE7e
 Q3wwUYGva9ZY3L9On3xyhfqVHc8cz6KWTxciaKJjg5JYrnkQ/zOUEB59CDbMaOpQVpAa
 QPHxiU1A41jZNDyC6f/TPl9f+L1KzkfekbV9Ha0Bnn1ZeH9rmW2Ep746oLnK3PARdQwB
 3CN86y0/+EQZfSZiG8wSqKlD2jy6m4RCTL58XZuUElE+ymQqoMTB9OZXoUT4V5zUH26f
 pYWw==
X-Gm-Message-State: AFq9FYLsHQ+mEep56blMZgi2n8KGa2REfuimJEgu3dfaPio2T/snuHzX
 Nd7Y4wN7XJsBofSAVi8LEuqNJShoCB2l9c23k8QXRfvvI77QMuEE7wbUUDT4K96nBog=
X-Gm-Gg: AYBFou2MNgeXQ8RVEFgxSlfZFiy/SzZLbsFJbxtFgoLpSdK4Z0qz8dS3cR0P1zZ7BI1
 NnR48zRz+ZvzAzouyz9Khnl9F4MLenqOcMRtQz8Xz405MIYGjxaS0JUNvk5FWs07lKeHWNQd2dy
 E6vjx7dWJgNv3h6clYAsW5MeIt2FC2OSjn+UpJwdoQ5yPREQqFm+xHrNMFx+JIU8OreTLdHSMeA
 YX70mA4CSUKBcUoRzcS7AodF1zU8tMqHq2t/m58wWhqVnHqpolt9OBrHv+oS6kPz+J0CjeLYIyN
 6cggzSrDZpNdjNaOgbLYyaxhGk9hxtPNLY5UDl50oKNlkVyERzvg3RKcJgopqQO+e1x27SI0p9M
 5bdCbMsvcQxdmhgsvAMxv03g0Uhn4eHWTNjvjWizmsCtHm1s3y4/ffKI4cYr/TpuoXkyomYaGg/
 vtFp7ja6CH4e1Nd5clzYJy3N6NxEAq7PCvT7hCaZE6d0LoK/Ax3QDJPXKaZuXfXyty95NG2NPHl
 6LJcv1rYyJEZbIP4FT3vFnI+DHtH8VXXk+xuKamnNT/dVfZWXBd5xGQJcvmVuBa0dtBnejlSbBW
 2LSbYlbZQnOXKGPGtIoxEhz1E26HR8q1X/AEjKUzuyli/MyHuR1HaI3KHrjVyt2bUvp1RhLuMDF
 jZQ==
X-Received: by 2002:a05:600c:3547:b0:4a1:e69d:90e8 with SMTP id
 5b1f17b1804b1-4ac1889d442mr219147845e9.22.1793614891762; 
 Mon, 02 Nov 2026 02:21:31 -0800 (PST)
Received: from localhost.localdomain (email.telematik-zentrum.de.
 [87.138.218.176]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-48e71b9eaeesm19273411f8f.49.2026.11.02.02.21.31
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 02 Nov 2026 02:21:31 -0800 (PST)
From: Lorand Marton <lorandmarton.dev@gmail.com>
To: qemu-devel@nongnu.org
Cc: peter.maydell@linaro.org, philmd@oss.qualcomm.com, qemu-arm@nongnu.org,
 farosas@suse.de, lvivier@redhat.com, pbonzini@redhat.com,
 alistair@alistair23.me
Subject: [PATCH 3/5] hw/ssi/bcm2835_spi: lower the interrupt on reset
Date: Mon,  2 Nov 2026 11:21:30 +0100
Message-ID: <9772fc00645a13988570f4107bf2eec7f5bbe2b7.1793613972.git.lorandmarton.dev@gmail.com>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <cover.1793613972.bcm2835-fixes-v1.git.lorandmarton.dev@gmail.com>
References: <cover.1793613972.bcm2835-fixes-v1.git.lorandmarton.dev@gmail.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42a;
 envelope-from=lorandmarton.dev@gmail.com; helo=mail-wr1-x42a.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_PASS,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

bcm2835_spi_reset() cleared CS, so neither DONE nor RXR is set
afterwards, but left the interrupt line as it was: a reset in the
middle of an interrupt-driven transfer (a guest reboot while
spi-bcm2835 waits for DONE) kept the line raised into the next boot.
Update the interrupt from the new register values.

Test that a reset during a transfer with INTD set drops the line.

Fixes: 28004fb74134 ("hw/ssi: Implement BCM2835 SPI Controller")
Signed-off-by: Lorand Marton <lorandmarton.dev@gmail.com>
---
 hw/ssi/bcm2835_spi.c           |  2 ++
 tests/qtest/bcm2835-spi-test.c | 42 ++++++++++++++++++++++++++++++++++
 tests/qtest/meson.build        |  3 ++-
 3 files changed, 46 insertions(+), 1 deletion(-)
 create mode 100644 tests/qtest/bcm2835-spi-test.c

diff --git a/hw/ssi/bcm2835_spi.c b/hw/ssi/bcm2835_spi.c
index 01763c458c..4ab47787a4 100644
--- a/hw/ssi/bcm2835_spi.c
+++ b/hw/ssi/bcm2835_spi.c
@@ -246,6 +246,8 @@ static void bcm2835_spi_reset(DeviceState *dev)
     s->dlen = 0;
     s->ltoh = 0x1;
     s->dc = 0x30201020;
+
+    bcm2835_spi_update_int(s);
 }
 
 static const VMStateDescription vmstate_bcm2835_spi = {
diff --git a/tests/qtest/bcm2835-spi-test.c b/tests/qtest/bcm2835-spi-test.c
new file mode 100644
index 0000000000..4888171e5b
--- /dev/null
+++ b/tests/qtest/bcm2835-spi-test.c
@@ -0,0 +1,42 @@
+/*
+ * QTest testcase for the BCM2835 SPI controller
+ *
+ * SPDX-License-Identifier: GPL-2.0-or-later
+ */
+
+#include "qemu/osdep.h"
+#include "qemu/bitops.h"
+#include "libqtest.h"
+
+#define SPI0_BASE       0x3f204000
+#define SPI_CS          0x00
+#define SPI_FIFO        0x04
+
+#define CS_CLEAR_RXTX   (3 << 4)
+#define CS_TA           BIT(7)
+#define CS_INTD         BIT(9)
+
+/* A reset in the middle of a transfer drops the interrupt */
+static void test_reset_irq(void)
+{
+    QTestState *qts = qtest_init("-M raspi3b");
+
+    qtest_irq_intercept_out_named(qts, "/machine/soc/peripherals/bcm2835-spi0",
+                                  "sysbus-irq");
+    qtest_writel(qts, SPI0_BASE + SPI_CS, CS_CLEAR_RXTX | CS_TA);
+    qtest_writel(qts, SPI0_BASE + SPI_FIFO, 0xa5);
+    qtest_writel(qts, SPI0_BASE + SPI_CS, CS_TA | CS_INTD);
+    g_assert_true(qtest_get_irq(qts, 0));
+
+    qtest_system_reset(qts);
+    g_assert_false(qtest_get_irq(qts, 0));
+
+    qtest_quit(qts);
+}
+
+int main(int argc, char **argv)
+{
+    g_test_init(&argc, &argv, NULL);
+    qtest_add_func("/bcm2835-spi/reset-irq", test_reset_irq);
+    return g_test_run();
+}
diff --git a/tests/qtest/meson.build b/tests/qtest/meson.build
index 6f74b519c7..d4a20cd408 100644
--- a/tests/qtest/meson.build
+++ b/tests/qtest/meson.build
@@ -285,7 +285,8 @@ qtests_aarch64 = \
     ['tpm-tis-device-test', 'tpm-tis-device-swtpm-test'] : []) +                                         \
   (config_all_devices.has_key('CONFIG_XLNX_ZYNQMP_ARM') ? ['xlnx-can-test', 'fuzz-xlnx-dp-test'] : []) + \
   (config_all_devices.has_key('CONFIG_XLNX_VERSAL') ? ['xlnx-canfd-test', 'xlnx-versal-trng-test'] : []) + \
-  (config_all_devices.has_key('CONFIG_RASPI') ? ['bcm2835-dma-test', 'bcm2835-i2c-test', 'bcm2835-ic-test'] : []) +  \
+  (config_all_devices.has_key('CONFIG_RASPI') ? ['bcm2835-dma-test', 'bcm2835-i2c-test', 'bcm2835-ic-test',
+                                                    'bcm2835-spi-test'] : []) +  \
   (config_all_accel.has_key('CONFIG_TCG') and                                            \
    config_all_devices.has_key('CONFIG_TPM_TIS_I2C') ? ['tpm-tis-i2c-test', 'tpm-tis-i2c-swtpm-test'] : []) + \
   (config_all_devices.has_key('CONFIG_ASPEED_SOC') ? qtests_aspeed64 : []) + \
-- 
2.56.0


