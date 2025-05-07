Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 08DA2C3ABC0
	for <qemu-devel@archiver.kernel.org>; Wed,  7 May 2025 09:20:22 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uCavy-00087H-Jo; Wed, 07 May 2025 05:19:22 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <timlee660101@gmail.com>)
 id 1uCavu-00080b-VX; Wed, 07 May 2025 05:19:19 -0400
Received: from mail-pj1-x102a.google.com ([2607:f8b0:4864:20::102a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <timlee660101@gmail.com>)
 id 1uCavp-0006Ne-QH; Wed, 07 May 2025 05:19:18 -0400
Received: by mail-pj1-x102a.google.com with SMTP id
 98e67ed59e1d1-30aa8a259e0so798467a91.1; 
 Wed, 07 May 2025 02:19:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1746609549; x=1747214349; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=pcdvujWM7E7CRcZLjZytCLuGjS6SIp8h6sop6QNazwE=;
 b=Brh+MHWHtn1hZHjfE9q6TEszCIfcy7bo02bFtJ4rews5fCNjRliNhXCdB+7v0oHVuc
 knzCJeibfFO7U7QwFBMuUgvSeUzWvoTDA8JKEOiMLfn3CChwkSaRg+TMjCFmH03+ywdQ
 tyd3BCSeTXAwGgK5dJjkB0TMy0uAdw1QOjpCOfXaKLfotm+izR79w0REVMDHHh9733US
 cXccynZil0YYJPadnpbEJrac5lEiZnPpJxu7uokmkycuBNQdi2vu+xBZaWMkZZLFWk8h
 WSyMgtKFvY2AdNjuHoS2uN9TumhJ1Nf1arXuzxyqmrlfZIl0KQl7nbdQYMVDLE/UDrXF
 CMRg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1746609549; x=1747214349;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=pcdvujWM7E7CRcZLjZytCLuGjS6SIp8h6sop6QNazwE=;
 b=Xn3ojEnG6D5TRZ/aJw867K45HjOwgZqupYWSLltZG+A6PPxOQUkmRbzx3QYYtTuPGL
 nSJaiWbuLa/GewOiVd4fxBLMZFAgyOogRBc0BhQkSZhGY2zhJUzvRmBo6R+FqlqUI846
 yOyN9vzCQwq4FIPOmgmHOPknlYTUI8P+iKiIOkiUL12E6/f6Gm6Vndyo8XzBcmg7srpI
 8JIkHx4tHO6NvCgan+uFh2EpCwCIe7rvvNiN4r6bSPBujbDT3iL7zu12zQFAOypSAfGQ
 t0Vv0DJi42wHlqnKL4hUrzgdEKjApWQE8Jb1Pzgh1WMC06M77oZrsclzuuMam2/rMx17
 mr8g==
X-Forwarded-Encrypted: i=1;
 AJvYcCVKmxppADghlCKnPx58evpUaW6SqLW8LgUXoxO6EOd+qrxeo+KbMLi8W//dkGSR0UYIFss9PHUM1HBs@nongnu.org
X-Gm-Message-State: AOJu0Yy6hRs7FGBNchbIuGCDWQRRyfIU1yr1Ua9rsnkJSoU9+4dvfsHn
 1rV6e+NHjB3TOlfrIM212jwy2U84/Hu4nqofRr73ZmVv41Oz3fwl
X-Gm-Gg: ASbGnctNGi7XXoMCqRe9glwgUHZBRAfHHRXHRfRYUVQPI3e8iGlwT7PEAGkc3V42+LY
 EU2L5IELx+0VIt9jCZsXdISr3z+k9x2I/fFvsHycbcAl/vTrBYt+C958/MLT+fWmNUyj7micSJN
 5HW3LQUFO0IheTCNY+n2CnHILA8I7R+3mhGlS9MShg19hdPdlO3s4TyDEse9/gTWqJzSkjFmAGW
 yFWbCL+qsF2sqsngZZFMWrlhczuWMZGPy+Po4ZJtg7HTWbEDPkxsZ8fI/EcSPo8ycBJknXHAtQI
 jffdR7lhub+9qDYIshX44N5/qkewmjhRyKM+fvyiedKgFLgCAag9x0fRf+sikLpqWXpFExmeuAI
 UBVprczyS
X-Google-Smtp-Source: AGHT+IH7E+GG21tSGVJCJdNyvDEOLYzzD70bRR1+bHl1+/prcu+yrywbPhVfd97GlYFOw6Gsw3+FRA==
X-Received: by 2002:a17:90b:3908:b0:2ee:aa28:79aa with SMTP id
 98e67ed59e1d1-30aac184527mr3839449a91.6.1746609549362; 
 Wed, 07 May 2025 02:19:09 -0700 (PDT)
Received: from hcdev-d520mt.. (60-250-196-139.hinet-ip.hinet.net.
 [60.250.196.139]) by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-30aae500d66sm1489788a91.7.2025.05.07.02.19.07
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 07 May 2025 02:19:09 -0700 (PDT)
From: Tim Lee <timlee660101@gmail.com>
To: farosas@suse.de, lvivier@redhat.com, pbonzini@redhat.com,
 wuhaotsh@google.com, kfting@nuvoton.com, chli30@nuvoton.com
Cc: qemu-arm@nongnu.org, qemu-devel@nongnu.org,
 Tim Lee <timlee660101@gmail.com>
Subject: [v2] tests/qtest: Add qtest for NPCM8XX PSPI module
Date: Wed,  7 May 2025 17:18:59 +0800
Message-Id: <20250507091859.2507455-1-timlee660101@gmail.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::102a;
 envelope-from=timlee660101@gmail.com; helo=mail-pj1-x102a.google.com
X-Spam_score_int: -17
X-Spam_score: -1.8
X-Spam_bar: -
X-Spam_report: (-1.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FREEMAIL_ENVFROM_END_DIGIT=0.25, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

- Created qtest to check initialization of registers in PSPI Module
- Implemented test into Build File

Tested:
./build/tests/qtest/npcm8xx-pspi_test

Signed-off-by: Tim Lee <timlee660101@gmail.com>
---
Changes since v1:
- MAINTAINERS file not need to change
- Add comment for copyright/license information
- Correct CTL registers to use 16 bits
- Remove printf() in test cases

 tests/qtest/meson.build         |   3 +
 tests/qtest/npcm8xx_pspi-test.c | 118 ++++++++++++++++++++++++++++++++
 2 files changed, 121 insertions(+)
 create mode 100644 tests/qtest/npcm8xx_pspi-test.c

diff --git a/tests/qtest/meson.build b/tests/qtest/meson.build
index 3136d15e0f..88672a8b00 100644
--- a/tests/qtest/meson.build
+++ b/tests/qtest/meson.build
@@ -210,6 +210,8 @@ qtests_npcm7xx = \
    'npcm7xx_watchdog_timer-test',
    'npcm_gmac-test'] + \
    (slirp.found() ? ['npcm7xx_emc-test'] : [])
+qtests_npcm8xx = \
+  ['npcm8xx_pspi-test']
 qtests_aspeed = \
   ['aspeed_hace-test',
    'aspeed_smc-test',
@@ -257,6 +259,7 @@ qtests_aarch64 = \
   (config_all_accel.has_key('CONFIG_TCG') and                                            \
    config_all_devices.has_key('CONFIG_TPM_TIS_I2C') ? ['tpm-tis-i2c-test'] : []) + \
   (config_all_devices.has_key('CONFIG_ASPEED_SOC') ? qtests_aspeed64 : []) + \
+  (config_all_devices.has_key('CONFIG_NPCM8XX') ? qtests_npcm8xx : []) + \
   ['arm-cpu-features',
    'numa-test',
    'boot-serial-test',
diff --git a/tests/qtest/npcm8xx_pspi-test.c b/tests/qtest/npcm8xx_pspi-test.c
new file mode 100644
index 0000000000..13b8a8229c
--- /dev/null
+++ b/tests/qtest/npcm8xx_pspi-test.c
@@ -0,0 +1,118 @@
+/*
+ * QTests for the Nuvoton NPCM8XX PSPI Controller
+ *
+ * Copyright (c) 2025 Nuvoton Technology Corporation
+ *
+ * SPDX-License-Identifier: GPL-2.0-or-later
+ *
+ */
+
+#include "qemu/osdep.h"
+#include "libqtest.h"
+#include "qemu/module.h"
+
+/* Register offsets */
+#define DATA_OFFSET 0x00
+#define CTL_SPIEN   0x01
+#define CTL_OFFSET  0x02
+#define CTL_MOD     0x04
+
+typedef struct PSPI {
+    uint64_t base_addr;
+} PSPI;
+
+PSPI pspi_defs = {
+    .base_addr  = 0xf0201000
+};
+
+static uint16_t pspi_read_data(QTestState *qts, const PSPI *pspi)
+{
+    return qtest_readw(qts, pspi->base_addr + DATA_OFFSET);
+}
+
+static void pspi_write_data(QTestState *qts, const PSPI *pspi, uint16_t value)
+{
+    qtest_writew(qts, pspi->base_addr + DATA_OFFSET, value);
+}
+
+static uint16_t pspi_read_ctl(QTestState *qts, const PSPI *pspi)
+{
+    return qtest_readw(qts, pspi->base_addr + CTL_OFFSET);
+}
+
+static void pspi_write_ctl(QTestState *qts, const PSPI *pspi, uint16_t value)
+{
+    qtest_writew(qts, pspi->base_addr + CTL_OFFSET, value);
+}
+
+/* Check PSPI can be reset to default value */
+static void test_init(gconstpointer pspi_p)
+{
+    const PSPI *pspi = pspi_p;
+
+    QTestState *qts = qtest_init("-machine npcm845-evb");
+
+    /* Write CTL_SPIEN value to control register for enable PSPI module */
+    pspi_write_ctl(qts, pspi, CTL_SPIEN);
+    g_assert_cmphex(pspi_read_ctl(qts, pspi), ==, CTL_SPIEN);
+
+    qtest_quit(qts);
+}
+
+/* Check PSPI can be r/w data register */
+static void test_data(gconstpointer pspi_p)
+{
+    const PSPI *pspi = pspi_p;
+    uint16_t test = 0x1234;
+    uint16_t output;
+
+    QTestState *qts = qtest_init("-machine npcm845-evb");
+
+    /* Enable 16-bit data interface mode */
+    pspi_write_ctl(qts, pspi, CTL_MOD);
+    g_assert_cmphex(pspi_read_ctl(qts, pspi), ==, CTL_MOD);
+
+    /* Write to data register */
+    pspi_write_data(qts, pspi, test);
+
+    /* Read from data register */
+    output = pspi_read_data(qts, pspi);
+    g_assert_cmphex(output, ==, test);
+
+    qtest_quit(qts);
+}
+
+/* Check PSPI can be r/w control register */
+static void test_ctl(gconstpointer pspi_p)
+{
+    const PSPI *pspi = pspi_p;
+    uint8_t control = CTL_MOD;
+
+    QTestState *qts = qtest_init("-machine npcm845-evb");
+
+    /* Write CTL_MOD value to control register for 16-bit interface mode */
+    qtest_memwrite(qts, pspi->base_addr + CTL_OFFSET,
+                   &control, sizeof(control));
+    g_assert_cmphex(pspi_read_ctl(qts, pspi), ==, control);
+
+    qtest_quit(qts);
+}
+
+static void pspi_add_test(const char *name, const PSPI* wd,
+        GTestDataFunc fn)
+{
+    g_autofree char *full_name = g_strdup_printf("npcm8xx_pspi/%s",  name);
+    qtest_add_data_func(full_name, wd, fn);
+}
+
+#define add_test(name, td) pspi_add_test(#name, td, test_##name)
+
+int main(int argc, char **argv)
+{
+    g_test_init(&argc, &argv, NULL);
+
+    add_test(init, &pspi_defs);
+    add_test(ctl, &pspi_defs);
+    add_test(data, &pspi_defs);
+    return g_test_run();
+}
-- 
2.34.1


