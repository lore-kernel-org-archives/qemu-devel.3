Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D436DC52D7D
	for <qemu-devel@archiver.kernel.org>; Sat, 17 Aug 2024 10:32:35 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sfGeM-0008Ha-SL; Sat, 17 Aug 2024 06:27:10 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from
 <32nrAZgUKCg88pAx4v33v0t.r315t19-stAt0232v29.36v@flex--tavip.bounces.google.com>)
 id 1sfGdx-0006T5-9P
 for qemu-devel@nongnu.org; Sat, 17 Aug 2024 06:26:47 -0400
Received: from mail-pj1-x1049.google.com ([2607:f8b0:4864:20::1049])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from
 <32nrAZgUKCg88pAx4v33v0t.r315t19-stAt0232v29.36v@flex--tavip.bounces.google.com>)
 id 1sfGdt-0003IX-CJ
 for qemu-devel@nongnu.org; Sat, 17 Aug 2024 06:26:44 -0400
Received: by mail-pj1-x1049.google.com with SMTP id
 98e67ed59e1d1-2d3b438c8c9so2775439a91.0
 for <qemu-devel@nongnu.org>; Sat, 17 Aug 2024 03:26:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=google.com; s=20230601; t=1723890395; x=1724495195; darn=nongnu.org;
 h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
 :date:from:to:cc:subject:date:message-id:reply-to;
 bh=TFG0GcsuE3kOisrSR4liiPOd2eXKV3NpYPJrlboG3Jc=;
 b=m1dKtKef8a/DYglUX4k+/modQAsWgWYU2GufaM4h3TP8eaegWeyNI6eXCEZAEDciVW
 TBFyqecHSN3oxUrBws9uACK3TwHaMOmXvwsMaFqt+yuUyIOcyakhEpK6JlezoaTL7NnZ
 ICgy+DYdjou6wk+lvtvLOxFtkTiHfbjBN04MCB5Seze6vqlydhBV4Di9SMMFIf9NapT5
 3dx5m/lRR1oNSvow0S0IFmqv77LDu/Bwa3BvwjCAsSqXjvxpCESsaIOYUMYmarNrSgzF
 aDd6ga1p11gDdlYOoMvO8taL3hPikD1ht7RK+FUQX2tT21sbgIn4qldbVjvlvYctJahi
 juBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1723890395; x=1724495195;
 h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
 :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=TFG0GcsuE3kOisrSR4liiPOd2eXKV3NpYPJrlboG3Jc=;
 b=lD/er1wCjHmygQpvwa/laZ6qKjG5+zdBUU0YNRTrhFtSkRomMRbDdsupN8D9R6WNMK
 XbI1RlDMR6gmtwfQMW2BCbGi/5DNMAYR6i9Af8XwcERUNlQywDyaI0L5/wrXcxwDiCg9
 /sc9On5/bICb5YAFDPbetNOwLT4vBk10skG4Y7NhuXBbx3FOZx/xwIu8jwWEv5QEutEp
 E83Vu5LYHJdNP5rtQeHL7FH1lCFWtN7WnB7u6UmhBcS2KxyYfPCksI/6gm1ccKJEeI7I
 IXeNKKoayItkyK/CZPwnZmFpIuW/Dt4p1FLsMwejh2rIK5e0Z7I2cudTi5czntezhLQJ
 doLA==
X-Gm-Message-State: AOJu0YzZXHyvOcG/QZTXxaPhFhYk7P5gz9gsm8yruSfnqam6qcQ4cb1f
 jLALocJHtbhbIdpv5Nz8wyhDQmA9snHuq+nsyh3m7RXGf17B4MTiP5tSX6vyu0+9CnMSfAJkcf5
 gNMSLetBhXo4CW6X10DXtuOEoNvO4Oj6sQIBCNYRPvmqxbujwX/WvLKr8rX0AZONXu9B43zuA0s
 eWbHnLO37LF1TiWpIUAPLdI0tS4Q==
X-Google-Smtp-Source: AGHT+IEKUmAU1SK61mqZ7+P1HKjZbmM12FkENOFc+bZhmshGNrefIhOIajkIQwf1qL34GB7pSDGJn0JmtQ==
X-Received: from warp10.c.googlers.com ([fda3:e722:ac3:cc00:24:72f4:c0a8:750])
 (user=tavip job=sendgmr) by 2002:a17:90b:1e50:b0:2d3:b7c7:d681
 with SMTP id
 98e67ed59e1d1-2d3e00ede53mr64440a91.3.1723890394594; Sat, 17 Aug 2024
 03:26:34 -0700 (PDT)
Date: Sat, 17 Aug 2024 03:25:57 -0700
In-Reply-To: <20240817102606.3996242-1-tavip@google.com>
Mime-Version: 1.0
References: <20240817102606.3996242-1-tavip@google.com>
X-Mailer: git-send-email 2.46.0.184.g6999bdac58-goog
Message-ID: <20240817102606.3996242-15-tavip@google.com>
Subject: [RFC PATCH v2 14/23] test/unit: add unit tests for flexcomm i2c
From: Octavian Purdila <tavip@google.com>
To: qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org, stefanst@google.com, pbonzini@redhat.com, 
 thuth@redhat.com, peter.maydell@linaro.org, marcandre.lureau@redhat.com, 
 alistair@alistair23.me, berrange@redhat.com, philmd@linaro.org, 
 jsnow@redhat.com, crosa@redhat.com
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::1049;
 envelope-from=32nrAZgUKCg88pAx4v33v0t.r315t19-stAt0232v29.36v@flex--tavip.bounces.google.com;
 helo=mail-pj1-x1049.google.com
X-Spam_score_int: -95
X-Spam_score: -9.6
X-Spam_bar: ---------
X-Spam_report: (-9.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_MED=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01,
 USER_IN_DEF_DKIM_WL=-7.5 autolearn=ham autolearn_force=no
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

Add master mode tests for flexcomm i2c.

Signed-off-by: Octavian Purdila <tavip@google.com>
---
 tests/unit/test-flexcomm-i2c.c | 210 +++++++++++++++++++++++++++++++++
 tests/unit/meson.build         |  10 ++
 2 files changed, 220 insertions(+)
 create mode 100644 tests/unit/test-flexcomm-i2c.c

diff --git a/tests/unit/test-flexcomm-i2c.c b/tests/unit/test-flexcomm-i2c.c
new file mode 100644
index 0000000000..d31af884d0
--- /dev/null
+++ b/tests/unit/test-flexcomm-i2c.c
@@ -0,0 +1,210 @@
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
+#include "hw/i2c/flexcomm_i2c.h"
+#include "i2c_tester.h"
+#include "sysbus-mock.h"
+#include "reg-utils.h"
+
+#define PERIPH_ADDR (0x20)
+#define INVALID_ADDR (0x10)
+
+#define REG_ADDR 0x11
+#define REG_VALUE 0xAA
+
+#define FLEXCOMM_BASE 0x40106000UL
+#define FLEXCOMM_I2C_BASE FLEXCOMM_BASE
+
+typedef struct {
+    DeviceState *dev;
+    I2CSlave *periph;
+    bool irq;
+} TestFixture;
+
+/* Callback for the interrupt line. */
+static void spi_irq_set(void *opaque, int line, int level)
+{
+    TestFixture *f = (TestFixture *)opaque;
+
+    f->irq = level;
+}
+
+/*
+ * Test fixture initialization.
+ */
+static void set_up(TestFixture *f, gconstpointer data)
+{
+    FlexcommState *s;
+
+    f->dev = qdev_new(TYPE_FLEXCOMM);
+    g_assert(f->dev);
+
+    s = FLEXCOMM(f->dev);
+    s->irq = qemu_allocate_irq(spi_irq_set, f, 0);
+
+    if (data != NULL) {
+        qdev_prop_set_int32(DEVICE(f->dev), "functions", (uintptr_t)data);
+    }
+
+    qdev_realize_and_unref(f->dev, NULL, &error_abort);
+    sysbus_mmio_map(SYS_BUS_DEVICE(f->dev), 0, FLEXCOMM_BASE);
+
+    device_cold_reset(f->dev);
+
+    f->periph = i2c_slave_create_simple(s->i2c, TYPE_I2C_TESTER, PERIPH_ADDR);
+}
+
+static void tear_down(TestFixture *f, gconstpointer user_data)
+{
+    qdev_unrealize(f->dev);
+    qdev_unrealize(DEVICE(f->periph));
+}
+
+static void master_test(TestFixture *f, gconstpointer user_data)
+{
+    uint32_t tmp;
+
+    /* Select and lock I2C */
+    tmp = FLEXCOMM_PERSEL_I2C;
+    FIELD_DP32(tmp, FLEXCOMM_PSELID, LOCK, 1);
+    REG32_WRITE(f->dev, FLEXCOMM, PSELID, tmp);
+
+    /* Enable master mode */
+    REG32_WRITE_FIELD(f->dev, FLEXCOMM_I2C, CFG, MSTEN, 1);
+    g_assert(REG32_READ_FIELD(f->dev, FLEXCOMM_I2C, CFG, MSTEN) == 1);
+
+    g_assert(REG32_READ_FIELD(f->dev, FLEXCOMM_I2C, STAT, MSTPENDING) == 1);
+    g_assert(REG32_READ_FIELD(f->dev, FLEXCOMM_I2C, STAT, MSTSTATE) ==
+             MSTSTATE_IDLE);
+
+    /* Enable interrupts */
+    REG32_WRITE_FIELD(f->dev, FLEXCOMM_I2C, INTENSET, MSTPENDINGEN, 1);
+    g_assert(f->irq == true);
+
+    /* start for invalid address  */
+    REG32_WRITE(f->dev, FLEXCOMM_I2C, MSTDAT, INVALID_ADDR);
+    REG32_WRITE_FIELD_NOUPDATE(f->dev, FLEXCOMM_I2C, MSTCTL, MSTSTART, 1);
+    g_assert(REG32_READ_FIELD(f->dev, FLEXCOMM_I2C, STAT, MSTSTATE) ==
+             MSTSTATE_NAKADR);
+    g_assert(f->irq == true);
+    REG32_WRITE_FIELD_NOUPDATE(f->dev, FLEXCOMM_I2C, MSTCTL, MSTSTOP, 1);
+
+    /* write past the last register */
+    REG32_WRITE_FIELD(f->dev, FLEXCOMM_I2C, MSTDAT, DATA, PERIPH_ADDR);
+    REG32_WRITE_FIELD_NOUPDATE(f->dev, FLEXCOMM_I2C, MSTCTL, MSTSTART, 1);
+    g_assert(f->irq == true);
+    g_assert(REG32_READ_FIELD(f->dev, FLEXCOMM_I2C, STAT, MSTSTATE) ==
+             MSTSTATE_TXRDY);
+    REG32_WRITE_FIELD(f->dev, FLEXCOMM_I2C, MSTDAT, DATA,
+                    (I2C_TESTER_NUM_REGS + 10));
+    REG32_WRITE_FIELD_NOUPDATE(f->dev, FLEXCOMM_I2C, MSTCTL, MSTCONTINUE, 1);
+    g_assert(f->irq == true);
+    g_assert(REG32_READ_FIELD(f->dev, FLEXCOMM_I2C, STAT, MSTSTATE) ==
+             MSTSTATE_TXRDY);
+    REG32_WRITE_FIELD_NOUPDATE(f->dev, FLEXCOMM_I2C, MSTCTL, MSTCONTINUE, 1);
+    g_assert(f->irq == true);
+    g_assert(REG32_READ_FIELD(f->dev, FLEXCOMM_I2C, STAT, MSTSTATE) ==
+             MSTSTATE_NAKDAT);
+    REG32_WRITE_FIELD_NOUPDATE(f->dev, FLEXCOMM_I2C, MSTCTL, MSTSTOP, 1);
+
+    /* write value to register */
+    REG32_WRITE_FIELD(f->dev, FLEXCOMM_I2C, MSTDAT, DATA, PERIPH_ADDR);
+    REG32_WRITE_FIELD_NOUPDATE(f->dev, FLEXCOMM_I2C, MSTCTL, MSTSTART, 1);
+    g_assert(f->irq == true);
+    g_assert(REG32_READ_FIELD(f->dev, FLEXCOMM_I2C, STAT, MSTSTATE) ==
+             MSTSTATE_TXRDY);
+    REG32_WRITE_FIELD(f->dev, FLEXCOMM_I2C, MSTDAT, DATA, REG_ADDR);
+    REG32_WRITE_FIELD_NOUPDATE(f->dev, FLEXCOMM_I2C, MSTCTL, MSTCONTINUE, 1);
+    g_assert(f->irq == true);
+    g_assert(REG32_READ_FIELD(f->dev, FLEXCOMM_I2C, STAT, MSTSTATE) ==
+             MSTSTATE_TXRDY);
+    REG32_WRITE_FIELD(f->dev, FLEXCOMM_I2C, MSTDAT, DATA, REG_VALUE);
+    REG32_WRITE_FIELD_NOUPDATE(f->dev, FLEXCOMM_I2C, MSTCTL, MSTCONTINUE, 1);
+    g_assert(f->irq == true);
+    g_assert(REG32_READ_FIELD(f->dev, FLEXCOMM_I2C, STAT, MSTSTATE) ==
+             MSTSTATE_TXRDY);
+    REG32_WRITE_FIELD_NOUPDATE(f->dev, FLEXCOMM_I2C, MSTCTL, MSTSTOP, 1);
+    g_assert(f->irq == true);
+    g_assert(REG32_READ_FIELD(f->dev, FLEXCOMM_I2C, STAT, MSTSTATE) ==
+             MSTSTATE_IDLE);
+    REG32_WRITE_FIELD_NOUPDATE(f->dev, FLEXCOMM_I2C, MSTCTL, MSTSTOP, 1);
+
+    /* read value back from register */
+    REG32_WRITE_FIELD(f->dev, FLEXCOMM_I2C, MSTDAT, DATA, PERIPH_ADDR);
+    REG32_WRITE_FIELD_NOUPDATE(f->dev, FLEXCOMM_I2C, MSTCTL, MSTSTART, 1);
+    g_assert(f->irq == true);
+    g_assert(REG32_READ_FIELD(f->dev, FLEXCOMM_I2C, STAT, MSTSTATE) ==
+             MSTSTATE_TXRDY);
+    REG32_WRITE_FIELD(f->dev, FLEXCOMM_I2C, MSTDAT, DATA, REG_ADDR);
+    REG32_WRITE_FIELD_NOUPDATE(f->dev, FLEXCOMM_I2C, MSTCTL, MSTCONTINUE, 1);
+    g_assert(f->irq == true);
+    g_assert(REG32_READ_FIELD(f->dev, FLEXCOMM_I2C, STAT, MSTSTATE) ==
+             MSTSTATE_TXRDY);
+    REG32_WRITE_FIELD(f->dev, FLEXCOMM_I2C, MSTDAT, DATA, (PERIPH_ADDR + 1));
+    REG32_WRITE_FIELD_NOUPDATE(f->dev, FLEXCOMM_I2C, MSTCTL, MSTSTART, 1);
+    g_assert(f->irq == true);
+    g_assert(REG32_READ_FIELD(f->dev, FLEXCOMM_I2C, STAT, MSTSTATE) ==
+             MSTSTATE_RXRDY);
+    REG32_WRITE_FIELD_NOUPDATE(f->dev, FLEXCOMM_I2C, MSTCTL, MSTCONTINUE, 1);
+    g_assert(REG32_READ_FIELD(f->dev, FLEXCOMM_I2C, MSTDAT, DATA) == REG_VALUE);
+    REG32_WRITE_FIELD_NOUPDATE(f->dev, FLEXCOMM_I2C, MSTCTL, MSTSTOP, 1);
+
+    /*
+     * Check that the master ended the transaction (i.e. i2c_end_transfer was
+     * called). If the master does not properly end the transaction this would
+     * be seen as a restart and it would not be NACKed.
+     */
+    REG32_WRITE_FIELD(f->dev, FLEXCOMM_I2C, MSTDAT, DATA, INVALID_ADDR);
+    REG32_WRITE_FIELD_NOUPDATE(f->dev, FLEXCOMM_I2C, MSTCTL, MSTSTART, 1);
+
+    g_assert(REG32_READ_FIELD(f->dev, FLEXCOMM_I2C, STAT, MSTSTATE) ==
+             MSTSTATE_NAKADR);
+    g_assert(f->irq == true);
+    REG32_WRITE_FIELD_NOUPDATE(f->dev, FLEXCOMM_I2C, MSTCTL, MSTSTOP, 1);
+
+    /* Disable interrupts */
+    REG32_WRITE_FIELD(f->dev, FLEXCOMM_I2C, INTENCLR, MSTPENDINGCLR, 1);
+    g_assert(f->irq == false);
+}
+
+/* mock-up */
+const PropertyInfo qdev_prop_chr;
+
+int main(int argc, char **argv)
+{
+    qemu_init_main_loop(&error_abort);
+
+    g_test_init(&argc, &argv, NULL);
+
+    /* Initialize object types. */
+    sysbus_mock_init();
+    module_call_init(MODULE_INIT_QOM);
+    qemu_add_opts(&qemu_chardev_opts);
+
+    g_test_add("/flexcomm-i2c/master", TestFixture,
+               (gconstpointer)(1 << FLEXCOMM_FUNC_I2C),
+               set_up, master_test, tear_down);
+
+    return g_test_run();
+}
diff --git a/tests/unit/meson.build b/tests/unit/meson.build
index 4c22cb3ccc..3491e2003b 100644
--- a/tests/unit/meson.build
+++ b/tests/unit/meson.build
@@ -160,6 +160,16 @@ if have_system
       meson.project_source_root() / 'hw/i2c/flexcomm_i2c.c',
       meson.project_source_root() / 'hw/i2c/core.c',
     ],
+    'test-flexcomm-i2c': [
+      hwcore, chardev, qom, migration,
+      meson.project_source_root() / 'hw/core/gpio.c',
+      meson.project_source_root() / 'tests/unit/sysbus-mock.c',
+      meson.project_source_root() / 'hw/misc/flexcomm.c',
+      meson.project_source_root() / 'hw/char/flexcomm_usart.c',
+      meson.project_source_root() / 'hw/i2c/flexcomm_i2c.c',
+      meson.project_source_root() / 'hw/i2c/core.c',
+      'i2c_tester.c',
+    ],
   }
   if config_host_data.get('CONFIG_INOTIFY1')
     tests += {'test-util-filemonitor': []}
-- 
2.46.0.184.g6999bdac58-goog


