Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C2E15CED24E
	for <qemu-devel@archiver.kernel.org>; Tue,  8 Oct 2024 01:26:08 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sxyur-00085g-DX; Mon, 07 Oct 2024 21:21:34 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from
 <3qIgEZwUKCgs4l6t0rzzrwp.nzx1px5-op6pwyzyry5.z2r@flex--tavip.bounces.google.com>)
 id 1sxyt5-0000Xn-Ff
 for qemu-devel@nongnu.org; Mon, 07 Oct 2024 21:19:43 -0400
Received: from mail-pf1-x44a.google.com ([2607:f8b0:4864:20::44a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from
 <3qIgEZwUKCgs4l6t0rzzrwp.nzx1px5-op6pwyzyry5.z2r@flex--tavip.bounces.google.com>)
 id 1sxyt0-0000GH-KG
 for qemu-devel@nongnu.org; Mon, 07 Oct 2024 21:19:43 -0400
Received: by mail-pf1-x44a.google.com with SMTP id
 d2e1a72fcca58-7174c6cbdbaso5838164b3a.2
 for <qemu-devel@nongnu.org>; Mon, 07 Oct 2024 18:19:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=google.com; s=20230601; t=1728350377; x=1728955177; darn=nongnu.org;
 h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
 :date:from:to:cc:subject:date:message-id:reply-to;
 bh=6ZAi4gulNhaksWV2hV6e+8oRvcK8JyjNz4xRR0r3KZA=;
 b=mIuqcCO3I+GMI85RVK4eeZvdlM8e2J0QEjuyj570kUH8/ZzIM/fQtJCi47FaP0nwd5
 Anid2Poew2RKM2xa0DwtJOymo3y/djxh6ch9RTkBw1Z3j/PwkiglZR3Taa5kmiNo3QvR
 w0jKirWPnMlXaMuQJQAfFBw9MFwZ76bLmaWude4SfozqTSvW7Lo6EKMQ/fSGj5QxdZC1
 WuF7DFWIk/pFJwI6UOdMcDkONKwDzZBcKnqBfCTYKeMqKpdsu46cVDbD1ElHesW+WKsf
 e3V8B/+uDe4DxRMJAReYhCwDboOQ78zXauBi9faP6UtyiW6Nyj+QMx1bvBqRZJ40RdI9
 BYjw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1728350377; x=1728955177;
 h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
 :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=6ZAi4gulNhaksWV2hV6e+8oRvcK8JyjNz4xRR0r3KZA=;
 b=ouUYmeY3Apj6LmciqKADQZGZvD1v2rOtx7J+JtmVMkMwDSTogcGqDkmUF2Zr7NfzGv
 hPwsp69O8w3BKnySMoPlZh76oP4nFF25A+XqUOLel01TiMEykY8gKestNgaqyjCPfnKm
 gK8kj7bfTb9E5gWEn0FM90f7fep0fSaxEUqx4tNEXnQy46JojOT6X+rK9PcELG7dUaw3
 8MZ4Be3cZ8yTJ9jgIli5xfyVKvxHunIr0KFvsfo9JperU0+TMoVwUeM6atgAKVbo3/sB
 QVp97anmWW8hkz1XkyNPMd1qtGcBc9BZgPkkRj1YKe27D81smBMwn2pxffsNs61PbfLz
 UrqQ==
X-Gm-Message-State: AOJu0Yx9kwOnXYJSm1F2LQ+SAb2W29h7BY76wWvsXlhPiOJCHP4efMI6
 R0dmRTJ31EkZWGATGX3IVKPItCfCycURl5ZjRUBFxCW9/kRoF+OPLffO+KKLsIiEYNvfBThacj2
 Emb5bjXG3LB367OBOGFiDi7w2gqxlwz2n0sYrPCUGDVz7JLqflVED43WgsNAHsg2a+c3cap4yTv
 0tJM6WthcaQ+Ejzlhb4//pXzbKRg==
X-Google-Smtp-Source: AGHT+IH7/MV6R5ex7R/s8YoXOodTUCEW4seC2LmeSVI6mh5M/35dcwCp5grJHjlS8iaBVFJyIoSE+XHi7g==
X-Received: from warp10.c.googlers.com ([fda3:e722:ac3:cc00:24:72f4:c0a8:750])
 (user=tavip job=sendgmr) by 2002:a05:6a00:2cf:b0:71d:f324:bd3e
 with SMTP id
 d2e1a72fcca58-71df324be2cmr39081b3a.3.1728350376065; Mon, 07 Oct 2024
 18:19:36 -0700 (PDT)
Date: Mon,  7 Oct 2024 18:18:49 -0700
In-Reply-To: <20241008011852.1439154-1-tavip@google.com>
Mime-Version: 1.0
References: <20241008011852.1439154-1-tavip@google.com>
X-Mailer: git-send-email 2.47.0.rc0.187.ge670bccf7e-goog
Message-ID: <20241008011852.1439154-24-tavip@google.com>
Subject: [PATCH v2 23/25] tests/qtest: add tests for flexcomm spi
From: Octavian Purdila <tavip@google.com>
To: qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org, stefanst@google.com, pbonzini@redhat.com, 
 peter.maydell@linaro.org, marcandre.lureau@redhat.com, berrange@redhat.com, 
 eduardo@habkost.net, luc@lmichel.fr, damien.hedde@dahe.fr, 
 alistair@alistair23.me, thuth@redhat.com, philmd@linaro.org, jsnow@redhat.com, 
 crosa@redhat.com, lvivier@redhat.com
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::44a;
 envelope-from=3qIgEZwUKCgs4l6t0rzzrwp.nzx1px5-op6pwyzyry5.z2r@flex--tavip.bounces.google.com;
 helo=mail-pf1-x44a.google.com
X-Spam_score_int: -95
X-Spam_score: -9.6
X-Spam_bar: ---------
X-Spam_report: (-9.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_MED=-0.024,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 USER_IN_DEF_DKIM_WL=-7.5 autolearn=unavailable autolearn_force=no
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

From: Sebastian Ene <sebastianene@google.com>

Add master and loopback tests for flexcomm spi.

Signed-off-by: Sebastian Ene <sebastianene@google.com>
[tavip: add master mode test, convert to qtest]
Signed-off-by: Octavian Purdila <tavip@google.com>
---
 tests/qtest/flexcomm-spi-test.c | 145 ++++++++++++++++++++++++++++++++
 tests/qtest/meson.build         |   2 +-
 2 files changed, 146 insertions(+), 1 deletion(-)
 create mode 100644 tests/qtest/flexcomm-spi-test.c

diff --git a/tests/qtest/flexcomm-spi-test.c b/tests/qtest/flexcomm-spi-test.c
new file mode 100644
index 0000000000..4658835b8f
--- /dev/null
+++ b/tests/qtest/flexcomm-spi-test.c
@@ -0,0 +1,145 @@
+/*
+ * Copyright (c) 2024 Google LLC.
+ *
+ * SPDX-License-Identifier: GPL-2.0-or-later
+ *
+ * This work is licensed under the terms of the GNU GPL, version 2 or later.
+ * See the COPYING file in the top-level directory.
+ */
+
+#include "qemu/osdep.h"
+
+#include "qemu/config-file.h"
+#include "qemu/log.h"
+#include "qemu/module.h"
+#include "qapi/error.h"
+#include "qemu/sockets.h"
+#include "sysemu/sysemu.h"
+#include "qemu/main-loop.h"
+#include "qemu/option.h"
+#include "exec/memory.h"
+#include "hw/irq.h"
+#include "hw/qdev-properties.h"
+#include "hw/qdev-core.h"
+
+#include "hw/misc/flexcomm.h"
+#include "hw/arm/svd/flexcomm_spi.h"
+#include "hw/arm/svd/rt500.h"
+#include "reg-utils.h"
+
+/* The number of words sent on the SPI in loopback mode. */
+#define SEQ_LOOPBACK_MODE   (8)
+
+/* This value is used to set the cycle counter for the spi tester */
+#define SPI_TESTER_CONFIG (0x10)
+
+#define FLEXCOMM_BASE RT500_FLEXCOMM0_BASE
+#define FLEXCOMM_SPI_BASE RT500_FLEXCOMM0_BASE
+#define DEVICE_NAME "/machine/soc/flexcomm0"
+
+static void configure_spi(bool master, bool is_loopback_mode)
+{
+    uint32_t tmp;
+
+    /* Select and lock SPI */
+    tmp = FLEXCOMM_PERSEL_SPI;
+    FIELD_DP32(tmp, FLEXCOMM_PSELID, LOCK, 1);
+    REG32_WRITE(FLEXCOMM, PSELID, tmp);
+
+    /* Disable the FIFO */
+    REG32_WRITE_FIELD(FLEXCOMM_SPI, CFG, ENABLE, 0);
+    REG32_WRITE_FIELD(FLEXCOMM_SPI, FIFOCFG, ENABLETX, 0);
+    REG32_WRITE_FIELD(FLEXCOMM_SPI, FIFOCFG, ENABLERX, 0);
+
+    if (is_loopback_mode) {
+        /* Set up SPI interface - loop mode, master mode */
+        REG32_WRITE_FIELD(FLEXCOMM_SPI, CFG, LOOP, 1);
+        g_assert(REG32_READ_FIELD(FLEXCOMM_SPI, CFG, LOOP) == 1);
+    }
+
+    if (master) {
+        REG32_WRITE_FIELD(FLEXCOMM_SPI, CFG, MASTER, 1);
+        g_assert(REG32_READ_FIELD(FLEXCOMM_SPI, CFG, MASTER) == 1);
+    } else {
+        REG32_WRITE_FIELD(FLEXCOMM_SPI, CFG, MASTER, 0);
+        g_assert(REG32_READ_FIELD(FLEXCOMM_SPI, CFG, MASTER) == 0);
+    }
+
+    /* Enable the FIFO */
+    REG32_WRITE_FIELD(FLEXCOMM_SPI, FIFOCFG, ENABLETX, 1);
+    REG32_WRITE_FIELD(FLEXCOMM_SPI, FIFOCFG, ENABLERX, 1);
+
+    /* Enable the SPI */
+    REG32_WRITE_FIELD(FLEXCOMM_SPI, CFG, ENABLE, 1);
+    g_assert(REG32_READ_FIELD(FLEXCOMM_SPI, CFG, ENABLE) == 1);
+}
+
+/* The SPI controller running in master mode can run in loopback mode for */
+/* internal testing. Transmit and receive lines are connected together. */
+static void loopback_test(gconstpointer user_data)
+{
+    configure_spi(true, true);
+
+    /* Write a sequence */
+    for (int i = 0; i < SEQ_LOOPBACK_MODE; i++) {
+        REG32_WRITE(FLEXCOMM_SPI, FIFOWR, i);
+    }
+
+    /* Read the sequence back */
+    for (int i = 0; i < SEQ_LOOPBACK_MODE; i++) {
+        g_assert(REG32_READ_FIELD(FLEXCOMM_SPI, FIFORD, RXDATA) == i);
+    }
+}
+
+static void master_test(gconstpointer user_data)
+{
+    uint32_t tmp;
+
+    configure_spi(true, false);
+
+    REG32_WRITE_FIELD(FLEXCOMM_SPI, CFG, LSBF, 1);
+
+    /* single 16bit word transfer */
+
+    tmp = FIELD_DP32(0x1122, FLEXCOMM_SPI_FIFOWR, EOT, 1);
+    tmp = FIELD_DP32(tmp, FLEXCOMM_SPI_FIFOWR, TXSSEL0_N, 1);
+    tmp = FIELD_DP32(tmp, FLEXCOMM_SPI_FIFOWR, LEN, 0xF);
+    REG32_WRITE(FLEXCOMM_SPI, FIFOWR, tmp);
+    g_assert(REG32_READ_FIELD(FLEXCOMM_SPI, FIFOSTAT, RXNOTEMPTY) == 1);
+    g_assert_cmpuint(REG32_READ_FIELD(FLEXCOMM_SPI, FIFORD, RXDATA),
+                     ==, 0x1122);
+    g_assert(REG32_READ_FIELD(FLEXCOMM_SPI, FIFOSTAT, RXNOTEMPTY) == 0);
+
+    /* multi word 8 bits transfer */
+
+    tmp = FIELD_DP32(0x11, FLEXCOMM_SPI_FIFOWR, TXSSEL0_N, 1);
+    tmp = FIELD_DP32(tmp, FLEXCOMM_SPI_FIFOWR, LEN, 0x7);
+    REG32_WRITE(FLEXCOMM_SPI, FIFOWR, tmp);
+    tmp = 0x22;
+    FIELD_DP32(tmp, FLEXCOMM_SPI_FIFOWR, EOT, 1);
+    FIELD_DP32(tmp, FLEXCOMM_SPI_FIFOWR, TXSSEL0_N, 1);
+    FIELD_DP32(tmp, FLEXCOMM_SPI_FIFOWR, LEN, 0x7);
+    REG32_WRITE(FLEXCOMM_SPI, FIFOWR, tmp);
+    g_assert(REG32_READ_FIELD(FLEXCOMM_SPI, FIFOSTAT, RXNOTEMPTY) == 1);
+    g_assert(REG32_READ_FIELD(FLEXCOMM_SPI, FIFORD, RXDATA) == 0x11);
+    g_assert(REG32_READ_FIELD(FLEXCOMM_SPI, FIFOSTAT, RXNOTEMPTY) == 1);
+    g_assert(REG32_READ_FIELD(FLEXCOMM_SPI, FIFORD, RXDATA) == 0x22);
+    g_assert(REG32_READ_FIELD(FLEXCOMM_SPI, FIFOSTAT, RXNOTEMPTY) == 0);
+}
+
+int main(int argc, char **argv)
+{
+    int ret;
+
+    module_call_init(MODULE_INIT_QOM);
+    g_test_init(&argc, &argv, NULL);
+
+    qtest_add_data_func("/flexcomm-spi/loopack", NULL, loopback_test);
+    qtest_add_data_func("/flexcomm-spi/master", NULL, master_test);
+
+    qtest_start("-M rt595-evk -device spi-tester,bus=/flexcomm0-spi");
+    ret = g_test_run();
+    qtest_end();
+
+    return ret;
+}
diff --git a/tests/qtest/meson.build b/tests/qtest/meson.build
index c21b18c304..d3bf33b855 100644
--- a/tests/qtest/meson.build
+++ b/tests/qtest/meson.build
@@ -233,7 +233,7 @@ qtests_arm = \
   (config_all_devices.has_key('CONFIG_FSI_APB2OPB_ASPEED') ? ['aspeed_fsi-test'] : []) + \
   (config_all_devices.has_key('CONFIG_STM32L4X5_SOC') and
    config_all_devices.has_key('CONFIG_DM163')? ['dm163-test'] : []) + \
-  (config_all_devices.has_key('CONFIG_FLEXCOMM') ? ['flexcomm-test', 'flexcomm-usart-test', 'flexcomm-i2c-test'] : []) + \
+  (config_all_devices.has_key('CONFIG_FLEXCOMM') ? ['flexcomm-test', 'flexcomm-usart-test', 'flexcomm-i2c-test', 'flexcomm-spi-test'] : []) + \
   ['arm-cpu-features',
    'boot-serial-test']
 
-- 
2.47.0.rc0.187.ge670bccf7e-goog


