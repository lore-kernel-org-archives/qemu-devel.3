Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4A6FFC5475B
	for <qemu-devel@archiver.kernel.org>; Tue, 20 Feb 2024 13:43:49 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rcQOE-0007to-He; Tue, 20 Feb 2024 08:42:30 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <rayhan.faizel@gmail.com>)
 id 1rcQOC-0007t7-Gz; Tue, 20 Feb 2024 08:42:28 -0500
Received: from mail-ej1-x62e.google.com ([2a00:1450:4864:20::62e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <rayhan.faizel@gmail.com>)
 id 1rcQOA-0004EA-MH; Tue, 20 Feb 2024 08:42:28 -0500
Received: by mail-ej1-x62e.google.com with SMTP id
 a640c23a62f3a-a28a6cef709so618088066b.1; 
 Tue, 20 Feb 2024 05:42:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1708436544; x=1709041344; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=jhfq92Ac1Csn+Nw/u2MeCXPpb7cdlLgcWS/VQidUjmo=;
 b=AOrtoOfjLCVYp/vJkeKAEKcPAaa2h19+xSV/HYtrV8tu0dzXbJy9Db6309zMky0Fvo
 a4MJP/xdgMQsFxmkwlWFSXEcf8n+k8lfgq0UFFEVLnZzkQCFh79ntMW1hTtYSMl/r9VY
 E0wmhaEMylekaHNJsmSN0xDiKYQbnh4/857F80EyxX0KbDRjCvGC0OaS+NiCUc63LyaP
 Pi9zXr4xWdjl7xP0ZrJkYSDPj/8SB8yomrA/w6Iqlx6moha0KAmx3vy8vE2a/gEY9BA+
 h7Nk8saQzVjk4pw403NEfQNTqTBZy9KS1bkx8apOh005sqs81cbhcRE03tAkuxN5NxUz
 DJZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1708436544; x=1709041344;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=jhfq92Ac1Csn+Nw/u2MeCXPpb7cdlLgcWS/VQidUjmo=;
 b=eTQ6SAZuQoB3v91hop9Mvdr0X2MwWtmBcF8qXYcbl2k7C4QzrVd0Lmfm5hE5Ak0ef8
 RNBDjzjXr7D4R5hsrV3E7MQYB5V1SRUHwFwCunhe02Cvpvdj+lvbMghsfa3EJb3oylVo
 bnxF8bZQTNSKJsKANbK/aEl+mCMNHibwA0sOg5wQEbkdGi6kWJKNgF+2Cb9tFHmbgI8V
 e+Z9M5V6OYyg1E8QwPvxe7UPVCwYeGTFyRa6acxnHvKESRAAT1hIfAzQBDQO3xdSMgAA
 tID/EkleiQl23hbXhIBFxuI5ZBQcJkyL0xLvA5T80p/JFJ9FcaCd6jXPzJz/nqwo6BnQ
 lagg==
X-Forwarded-Encrypted: i=1;
 AJvYcCUiJHISPVyxJK6IEVIFbjtN3+rHaSefuW2eTh/h6+TyNCqRXSTIijLUujeoPAeBq5oXmTFYvN7WCu9Z9iRaBLFue8qT
X-Gm-Message-State: AOJu0YyQLrBU6qN8YYDksITK5Vo+gypHDlKjWrvJDHOTMjPQnCHfYgTy
 LkQ9D0b9h81tYzFMvm8iLXtIw4S7a/+dwt8EwMOEJWX6eauUBJ+uNuQM6ecoLQc=
X-Google-Smtp-Source: AGHT+IHFq7iDn9AhObcnzL6KA9d6/W4MVq6lH/BMGepeAEer0omiYzLr9XNoXIMM4kWKnv3uO5S0AA==
X-Received: by 2002:a17:906:60f:b0:a3e:b8ac:288f with SMTP id
 s15-20020a170906060f00b00a3eb8ac288fmr2974844ejb.4.1708436544356; 
 Tue, 20 Feb 2024 05:42:24 -0800 (PST)
Received: from localhost.localdomain ([37.186.51.232])
 by smtp.gmail.com with ESMTPSA id
 h23-20020a170906591700b00a3ef17464b1sm728449ejq.9.2024.02.20.05.42.22
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 20 Feb 2024 05:42:24 -0800 (PST)
From: Rayhan Faizel <rayhan.faizel@gmail.com>
To: qemu-devel@nongnu.org
Cc: peter.maydell@linaro.org, philmd@linaro.org, pbonzini@redhat.com,
 qemu-arm@nongnu.org, Rayhan Faizel <rayhan.faizel@gmail.com>,
 Thomas Huth <thuth@redhat.com>, Laurent Vivier <lvivier@redhat.com>
Subject: [PATCH v3 3/3] tests/qtest: Add testcase for BCM2835 BSC
Date: Tue, 20 Feb 2024 19:11:20 +0530
Message-Id: <20240220134120.2961059-4-rayhan.faizel@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240220134120.2961059-1-rayhan.faizel@gmail.com>
References: <20240220134120.2961059-1-rayhan.faizel@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::62e;
 envelope-from=rayhan.faizel@gmail.com; helo=mail-ej1-x62e.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

Simple testcase for validating proper operation of read and write for all
three BSC controllers.

Signed-off-by: Rayhan Faizel <rayhan.faizel@gmail.com>
---
 tests/qtest/bcm2835-i2c-test.c | 107 +++++++++++++++++++++++++++++++++
 tests/qtest/meson.build        |   2 +-
 2 files changed, 108 insertions(+), 1 deletion(-)
 create mode 100644 tests/qtest/bcm2835-i2c-test.c

diff --git a/tests/qtest/bcm2835-i2c-test.c b/tests/qtest/bcm2835-i2c-test.c
new file mode 100644
index 0000000000..70817202dc
--- /dev/null
+++ b/tests/qtest/bcm2835-i2c-test.c
@@ -0,0 +1,107 @@
+/*
+ * QTest testcase for Broadcom Serial Controller (BSC)
+ *
+ * Copyright (c) 2024 Rayhan Faizel <rayhan.faizel@gmail.com>
+ *
+ * SPDX-License-Identifier: MIT
+ *
+ * Permission is hereby granted, free of charge, to any person obtaining a copy
+ * of this software and associated documentation files (the "Software"), to deal
+ * in the Software without restriction, including without limitation the rights
+ * to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
+ * copies of the Software, and to permit persons to whom the Software is
+ * furnished to do so, subject to the following conditions:
+ *
+ * The above copyright notice and this permission notice shall be included in
+ * all copies or substantial portions of the Software.
+ *
+ * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
+ * IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
+ * FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL
+ * THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
+ * LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
+ * OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
+ * THE SOFTWARE.
+ */
+
+#include "qemu/osdep.h"
+#include "libqtest-single.h"
+
+#include "hw/i2c/bcm2835_i2c.h"
+#include "hw/sensor/tmp105_regs.h"
+
+static const uint32_t bsc_base_addrs[] = {
+    0x3f205000,                         /* I2C0 */
+    0x3f804000,                         /* I2C1 */
+    0x3f805000,                         /* I2C2 */
+};
+
+static void bcm2835_i2c_init_transfer(uint32_t base_addr, bool read)
+{
+    /* read flag is bit 0 so we can write it directly */
+    int interrupt = read ? BCM2835_I2C_C_INTR : BCM2835_I2C_C_INTT;
+
+    writel(base_addr + BCM2835_I2C_C,
+           BCM2835_I2C_C_I2CEN | BCM2835_I2C_C_INTD |
+           BCM2835_I2C_C_ST | BCM2835_I2C_C_CLEAR | interrupt | read);
+}
+
+static void test_i2c_read_write(gconstpointer data)
+{
+    uint32_t i2cdata;
+    intptr_t index = (intptr_t) data;
+    uint32_t base_addr = bsc_base_addrs[index];
+
+    /* Write to TMP105 register */
+    writel(base_addr + BCM2835_I2C_A, 0x50);
+    writel(base_addr + BCM2835_I2C_DLEN, 3);
+
+    bcm2835_i2c_init_transfer(base_addr, 0);
+
+    writel(base_addr + BCM2835_I2C_FIFO, TMP105_REG_T_HIGH);
+    writel(base_addr + BCM2835_I2C_FIFO, 0xde);
+    writel(base_addr + BCM2835_I2C_FIFO, 0xad);
+
+
+    /* Read from TMP105 register */
+    writel(base_addr + BCM2835_I2C_A, 0x50);
+    writel(base_addr + BCM2835_I2C_DLEN, 1);
+
+    bcm2835_i2c_init_transfer(base_addr, 0);
+
+    writel(base_addr + BCM2835_I2C_FIFO, TMP105_REG_T_HIGH);
+
+    writel(base_addr + BCM2835_I2C_DLEN, 2);
+    bcm2835_i2c_init_transfer(base_addr, 1);
+
+    i2cdata = readl(base_addr + BCM2835_I2C_FIFO);
+    g_assert_cmpint(i2cdata, ==, 0xde);
+
+    i2cdata = readl(base_addr + BCM2835_I2C_FIFO);
+    g_assert_cmpint(i2cdata, ==, 0xad);
+}
+
+int main(int argc, char **argv)
+{
+    int ret;
+    int i;
+
+    g_test_init(&argc, &argv, NULL);
+
+    for (i = 0; i < 3; i++) {
+        g_autofree char *test_name =
+        g_strdup_printf("/bcm2835/bcm2835-i2c%d/read_write", i);
+        qtest_add_data_func(test_name, (void *)(intptr_t) i,
+                            test_i2c_read_write);
+    }
+
+    /* Run I2C tests with TMP105 slaves on all three buses */
+    qtest_start("-M raspi3b "
+                "-device tmp105,address=0x50,bus=i2c-bus.0 "
+                "-device tmp105,address=0x50,bus=i2c-bus.1 "
+                "-device tmp105,address=0x50,bus=i2c-bus.2");
+    ret = g_test_run();
+    qtest_end();
+
+    return ret;
+}
diff --git a/tests/qtest/meson.build b/tests/qtest/meson.build
index 39557d5ecb..8fe303160e 100644
--- a/tests/qtest/meson.build
+++ b/tests/qtest/meson.build
@@ -228,7 +228,7 @@ qtests_aarch64 = \
     ['tpm-tis-device-test', 'tpm-tis-device-swtpm-test'] : []) +                                         \
   (config_all_devices.has_key('CONFIG_XLNX_ZYNQMP_ARM') ? ['xlnx-can-test', 'fuzz-xlnx-dp-test'] : []) + \
   (config_all_devices.has_key('CONFIG_XLNX_VERSAL') ? ['xlnx-canfd-test', 'xlnx-versal-trng-test'] : []) + \
-  (config_all_devices.has_key('CONFIG_RASPI') ? ['bcm2835-dma-test'] : []) +  \
+  (config_all_devices.has_key('CONFIG_RASPI') ? ['bcm2835-dma-test', 'bcm2835-i2c-test'] : []) +  \
   (config_all_accel.has_key('CONFIG_TCG') and                                            \
    config_all_devices.has_key('CONFIG_TPM_TIS_I2C') ? ['tpm-tis-i2c-test'] : []) + \
   (config_all_devices.has_key('CONFIG_NPCM7XX') ? qtests_npcm7xx : []) + \
-- 
2.34.1


