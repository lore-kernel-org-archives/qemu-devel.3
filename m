Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C7D64CDD553
	for <qemu-devel@archiver.kernel.org>; Wed, 18 Sep 2024 19:24:32 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sr0HE-0006ey-Kb; Wed, 18 Sep 2024 15:23:49 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from
 <3uyjrZgUKCvYrYtgnemmejc.amkocks-bctcjlmlels.mpe@flex--tavip.bounces.google.com>)
 id 1sr0HB-0006PP-7N
 for qemu-devel@nongnu.org; Wed, 18 Sep 2024 15:23:45 -0400
Received: from mail-pf1-x44a.google.com ([2607:f8b0:4864:20::44a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from
 <3uyjrZgUKCvYrYtgnemmejc.amkocks-bctcjlmlels.mpe@flex--tavip.bounces.google.com>)
 id 1sr0H8-0007RO-Uf
 for qemu-devel@nongnu.org; Wed, 18 Sep 2024 15:23:44 -0400
Received: by mail-pf1-x44a.google.com with SMTP id
 d2e1a72fcca58-71985a317fcso50010b3a.1
 for <qemu-devel@nongnu.org>; Wed, 18 Sep 2024 12:23:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=google.com; s=20230601; t=1726687421; x=1727292221; darn=nongnu.org;
 h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
 :date:from:to:cc:subject:date:message-id:reply-to;
 bh=CWax01LO11cCMxk7XAjv93ylNJE01EbdgJ7/Pszq034=;
 b=zGhet/009glFKP7BXtgbv4pDmJ7s7lZoJHOGR9GQ4/Vot2oOYiHjsgOtqL5/TIbBmU
 ptuJTfwQfqUdT18ap8MSeuPEk2+DOMbIo8ZXZG7ZmwoKOzKkID54daYGnvK7yK63JhIp
 1PjCIph8Q5GM3zuEuDna9W/Eo1ZproFVfUTApjpLYstL9w3TpV3vcVwey/4jZDVLC/Ka
 Uxl8/CkqGi9lyHPTpVygHVnEPlGe3XZ8ZMMJZpfOtO3j8ajAq1p2TEyecWKkUlszgcNF
 wXmyMsbikapeZ3yLsnvjkSOP9K/flc5THw53on4QAQGZ/thABpRqcUEr+0svBiS26oYD
 xPFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1726687421; x=1727292221;
 h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
 :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=CWax01LO11cCMxk7XAjv93ylNJE01EbdgJ7/Pszq034=;
 b=pFrUGzgA4YVdIwbPIOMF2PATs6usPRx9qfcM5SDo4ZXfzFe3KnS9nQWV94+5kt0bRd
 Ud/wD0hzlBtmnIhlb9EDqzNYCybJYDF22tvV/aB+yoAK/laj4/Id8td3E3tZD9MCGjLc
 is+cp4DM0O5v+TlbuzRl5AjPb73Sn2D/XYXhtSapgAW1ZQsuH4rAEPBw2wwlCbQ4iMGI
 MOZeEu7n+9BIExzWS1W9+tXbuDJlDrXDeMtXwQTH6vCznZBN9ImV+dXpLegRMvcLo3nr
 BVL4xmIEYY61UFJOQt0P1Mfrms66gTvW42mtdfAIDcE55m6lXPQ9eVSuK/nU1yiGHUsX
 a+PA==
X-Gm-Message-State: AOJu0Yy83ayf/dDedWxt9C7BkxRdjzWiCDyB6ONneAciIcaMMAoNzyVu
 mrYBLSmbLKdlSanOPwowvY6BY7mqBEz16mh2jMhOm9bhVLCxbfESB6rwuh6OUejuk6dDbq6iNiD
 ZXektRNpieXzSj3fzJV5pS3dvDhNqCHvuMO5OL5jWc659AvS9HPDs4E/dw7C4bvs/uJ4GwL3ELo
 wu+x+cxcEHvZKY/9EQeo6/cDgJ5w==
X-Google-Smtp-Source: AGHT+IHvipsDN/lR67gcLqKAQStRGIe/Xifx2ShSlVwhQHbSb87y5XlxAEKzi/jyANlbDjk5JNKAxYhJdA==
X-Received: from warp10.c.googlers.com ([fda3:e722:ac3:cc00:24:72f4:c0a8:750])
 (user=tavip job=sendgmr) by 2002:a62:aa14:0:b0:717:9798:a8ca with
 SMTP id
 d2e1a72fcca58-719262286femr63984b3a.4.1726687419607; Wed, 18 Sep 2024
 12:23:39 -0700 (PDT)
Date: Wed, 18 Sep 2024 12:22:51 -0700
In-Reply-To: <20240918192254.3136903-1-tavip@google.com>
Mime-Version: 1.0
References: <20240918192254.3136903-1-tavip@google.com>
X-Mailer: git-send-email 2.46.0.662.g92d0881bb0-goog
Message-ID: <20240918192254.3136903-24-tavip@google.com>
Subject: [PATCH 23/25] tests/qtest: add tests for flexcomm spi
From: Octavian Purdila <tavip@google.com>
To: qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org, stefanst@google.com, pbonzini@redhat.com, 
 peter.maydell@linaro.org, marcandre.lureau@redhat.com, berrange@redhat.com, 
 eduardo@habkost.net, luc@lmichel.fr, damien.hedde@dahe.fr, 
 alistair@alistair23.me, thuth@redhat.com, philmd@linaro.org, jsnow@redhat.com, 
 crosa@redhat.com, lvivier@redhat.com
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::44a;
 envelope-from=3uyjrZgUKCvYrYtgnemmejc.amkocks-bctcjlmlels.mpe@flex--tavip.bounces.google.com;
 helo=mail-pf1-x44a.google.com
X-Spam_score_int: -95
X-Spam_score: -9.6
X-Spam_bar: ---------
X-Spam_report: (-9.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_MED=-0.001,
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
index 74fef28551..2cb0fa08c0 100644
--- a/tests/qtest/meson.build
+++ b/tests/qtest/meson.build
@@ -231,7 +231,7 @@ qtests_arm = \
   (config_all_devices.has_key('CONFIG_FSI_APB2OPB_ASPEED') ? ['aspeed_fsi-test'] : []) + \
   (config_all_devices.has_key('CONFIG_STM32L4X5_SOC') and
    config_all_devices.has_key('CONFIG_DM163')? ['dm163-test'] : []) + \
-  (config_all_devices.has_key('CONFIG_FLEXCOMM') ? ['flexcomm-test', 'flexcomm-usart-test', 'flexcomm-i2c-test'] : []) + \
+  (config_all_devices.has_key('CONFIG_FLEXCOMM') ? ['flexcomm-test', 'flexcomm-usart-test', 'flexcomm-i2c-test', 'flexcomm-spi-test'] : []) + \
   ['arm-cpu-features',
    'boot-serial-test']
 
-- 
2.46.0.662.g92d0881bb0-goog


