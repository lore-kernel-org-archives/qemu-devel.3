Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4ABF0C3DA7F
	for <qemu-devel@archiver.kernel.org>; Mon,  5 Aug 2024 20:18:30 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sb49f-0004Rq-Hy; Mon, 05 Aug 2024 16:18:09 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from
 <3bzOxZgUKCtYL2NAH8GG8D6.4GEI6EM-56N6DFGF8FM.GJ8@flex--tavip.bounces.google.com>)
 id 1sb49V-0003t9-Vg
 for qemu-devel@nongnu.org; Mon, 05 Aug 2024 16:17:58 -0400
Received: from mail-pl1-x64a.google.com ([2607:f8b0:4864:20::64a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from
 <3bzOxZgUKCtYL2NAH8GG8D6.4GEI6EM-56N6DFGF8FM.GJ8@flex--tavip.bounces.google.com>)
 id 1sb49T-0001Vp-45
 for qemu-devel@nongnu.org; Mon, 05 Aug 2024 16:17:57 -0400
Received: by mail-pl1-x64a.google.com with SMTP id
 d9443c01a7336-1ff3dfaa090so56173155ad.3
 for <qemu-devel@nongnu.org>; Mon, 05 Aug 2024 13:17:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=google.com; s=20230601; t=1722889071; x=1723493871; darn=nongnu.org;
 h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
 :date:from:to:cc:subject:date:message-id:reply-to;
 bh=wzBmDOceMrnHqMQIWuQIRSZOR9yk0Yvpmsomz+UG+gg=;
 b=O3PgGvJq0KeHXh/UXMpemJC46Dp/bohzJ8pJdeBz8zkAVHh00+KxRhlNPael4tibPs
 SCT916P9BE11j++9g/WyWc3LzOVRwg0N7dqsdNxTDCQBeDaSiDunnKYVtb0oH8uj3to7
 ZC/aTkGUQllEiXgJmh68hW4IiD9mep6hB4HoS6Z0Ywe61a5lf38KAX8BDjq6I9E4y6yO
 oH4FH00VlXBU/bIottUWf/iYKU0SRbRGMMhphf4Xc5RUQyfveRdkMWaPf3iNULK7gB2z
 KAPQt5TGAWGFydnWxMSFebUKoPSv6NcwfISoAAmqRvLCdSzS2q2ZVXanMPbg25wpW6tU
 jMlg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1722889071; x=1723493871;
 h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
 :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=wzBmDOceMrnHqMQIWuQIRSZOR9yk0Yvpmsomz+UG+gg=;
 b=Hug4BOmX92WNsDgLFuMYTWlpnpmjCy3fcxheXK4q26yJ6b5XW2+izHgJE//XAlbDsy
 VKAjC+V3RDWOZj6q9urQ8Za5lGVXd6dBE7K1pAdkvb9782c76CoEb8xu5IYwn5FH8Qxc
 VgNcso/5b268HonZijqW/t6ff87ITwgcN9jrOMVtEztoZ7YddxgYPOxhcKIaFyjATOIE
 EjIRirrF0AWz/nBN9LKZEIuhUPrg9YYJbpQn5SMeIcSWVI3HcQ/LrmJBQVyjRHJs6n8p
 Gc3xFW1ZGTfH7a9IWjoOP4rsG+6W7b5I8RZuEIa7yfMgGQxrUWVuhr0CzxWq8HBxT5tr
 4xXQ==
X-Gm-Message-State: AOJu0YwVdMTDwidKOM/t2FpA0op3OZk4LVcq08DGaIgxM1RKttGTJ86g
 SUG/4t2LHTHk3f/uU8FdGaNLyUcUp04YgGROlRxaY+CSc76PO+9xECREz5CGjNEW2OVqZiedcI4
 xYsyLRcl83A474YbWONlAajfdD18e4tx4cBCc0xiyg8KI4k6eAqdqXTB5cIoo39jaA0H23RAB0e
 Dgk6eBkays2TgX1ydQfNhUgU9Pqw==
X-Google-Smtp-Source: AGHT+IHVi7BSDYYhjOka8/Q/qJLSQwS1b7zusawaDngOT+BQcrbPW5yMM/adD7GWmfTork0iu8CQc2L59Q==
X-Received: from warp10.c.googlers.com ([fda3:e722:ac3:cc00:24:72f4:c0a8:750])
 (user=tavip job=sendgmr) by 2002:a17:902:ec85:b0:1fb:1ae6:6ab9
 with SMTP id
 d9443c01a7336-1ff570db092mr4983795ad.0.1722889071130; Mon, 05 Aug 2024
 13:17:51 -0700 (PDT)
Date: Mon,  5 Aug 2024 13:17:12 -0700
In-Reply-To: <20240805201719.2345596-1-tavip@google.com>
Mime-Version: 1.0
References: <20240805201719.2345596-1-tavip@google.com>
X-Mailer: git-send-email 2.46.0.rc2.264.g509ed76dc8-goog
Message-ID: <20240805201719.2345596-18-tavip@google.com>
Subject: [RFC PATCH 17/23] test/unit: add unit tests for flexcomm spi
From: Octavian Purdila <tavip@google.com>
To: qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org, stefanst@google.com, pbonzini@redhat.com, 
 alex.bennee@linaro.org, thuth@redhat.com, peter.maydell@linaro.org, 
 marcandre.lureau@redhat.com, alistair@alistair23.me, berrange@redhat.com, 
 philmd@linaro.org, jsnow@redhat.com, crosa@redhat.com, bleal@redhat.com
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::64a;
 envelope-from=3bzOxZgUKCtYL2NAH8GG8D6.4GEI6EM-56N6DFGF8FM.GJ8@flex--tavip.bounces.google.com;
 helo=mail-pl1-x64a.google.com
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

From: Sebastian Ene <sebastianene@google.com>

Add master and loopback tests for flexcomm spi.

Signed-off-by: Sebastian Ene <sebastianene@google.com>
Signed-off-by: Octavian Purdila <tavip@google.com>
---
 tests/unit/meson.build         |  11 ++
 tests/unit/test-flexcomm-spi.c | 204 +++++++++++++++++++++++++++++++++
 2 files changed, 215 insertions(+)
 create mode 100644 tests/unit/test-flexcomm-spi.c

diff --git a/tests/unit/meson.build b/tests/unit/meson.build
index 1ddd174576..7a28e7b521 100644
--- a/tests/unit/meson.build
+++ b/tests/unit/meson.build
@@ -176,6 +176,17 @@ if have_system
       meson.project_source_root() / 'hw/ssi/flexcomm_spi.c',
       meson.project_source_root() / 'hw/ssi/ssi.c',
     ],
+    'test-flexcomm-spi': [
+      qom, hwcore, migration, chardev,
+      meson.project_source_root() / 'hw/core/gpio.c',
+      meson.project_source_root() / 'tests/unit/sysbus-mock.c',
+      meson.project_source_root() / 'hw/misc/flexcomm.c',
+      meson.project_source_root() / 'hw/char/flexcomm_usart.c',
+      meson.project_source_root() / 'hw/i2c/flexcomm_i2c.c',
+      meson.project_source_root() / 'hw/i2c/core.c',
+      meson.project_source_root() / 'hw/ssi/flexcomm_spi.c',
+      meson.project_source_root() / 'hw/ssi/ssi.c',
+      'spi_tester.c',
     ],
   }
   if config_host_data.get('CONFIG_INOTIFY1')
diff --git a/tests/unit/test-flexcomm-spi.c b/tests/unit/test-flexcomm-spi.c
new file mode 100644
index 0000000000..4aaf511d70
--- /dev/null
+++ b/tests/unit/test-flexcomm-spi.c
@@ -0,0 +1,204 @@
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
+#include "spi_tester.h"
+#include "sysbus-mock.h"
+#include "reg-utils.h"
+
+/* The number of words sent on the SPI in loopback mode. */
+#define SEQ_LOOPBACK_MODE   (8)
+
+/* This value is used to set the cycle counter for the spi tester */
+#define SPI_TESTER_CONFIG (0x10)
+
+#define FLEXCOMM_BASE 0x40106000UL
+#define FLEXCOMM_SPI_BASE FLEXCOMM_BASE
+
+typedef struct {
+    DeviceState *dev;
+    DeviceState *periph;
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
+    f->periph = ssi_create_peripheral(s->spi, TYPE_SPI_TESTER);
+    s->cs[0] = qdev_get_gpio_in_named(f->periph, SSI_GPIO_CS, 0);
+}
+
+static void tear_down(TestFixture *f, gconstpointer user_data)
+{
+    qdev_unrealize(f->dev);
+    qdev_unrealize(DEVICE(f->periph));
+    g_free(f->dev);
+}
+
+static void configure_spi(TestFixture *f, bool master, bool is_loopback_mode)
+{
+    uint32_t tmp;
+
+    /* Select and lock SPI */
+    tmp = FLEXCOMM_PSELID_LOCK_Msk | FLEXCOMM_PERSEL_SPI;
+    REG32_WRITE(f->dev, FLEXCOMM, PSELID, tmp);
+
+    /* Disable the FIFO */
+    REG32_WRITE_FIELD(f->dev, FLEXCOMM_SPI, CFG, ENABLE, 0);
+    REG32_WRITE_FIELD(f->dev, FLEXCOMM_SPI, FIFOCFG, ENABLETX, 0);
+    REG32_WRITE_FIELD(f->dev, FLEXCOMM_SPI, FIFOCFG, ENABLERX, 0);
+
+    if (is_loopback_mode) {
+        /* Set up SPI interface - loop mode, master mode */
+        REG32_WRITE_FIELD(f->dev, FLEXCOMM_SPI, CFG, LOOP, 1);
+        g_assert(REG32_READ_FIELD(f->dev, FLEXCOMM_SPI, CFG, LOOP) == 1);
+    }
+
+    if (master) {
+        REG32_WRITE_FIELD(f->dev, FLEXCOMM_SPI, CFG, MASTER, 1);
+        g_assert(REG32_READ_FIELD(f->dev, FLEXCOMM_SPI, CFG, MASTER) == 1);
+    } else {
+        REG32_WRITE_FIELD(f->dev, FLEXCOMM_SPI, CFG, MASTER, 0);
+        g_assert(REG32_READ_FIELD(f->dev, FLEXCOMM_SPI, CFG, MASTER) == 0);
+    }
+
+    /* Enable the FIFO */
+    REG32_WRITE_FIELD(f->dev, FLEXCOMM_SPI, FIFOCFG, ENABLETX, 1);
+    REG32_WRITE_FIELD(f->dev, FLEXCOMM_SPI, FIFOCFG, ENABLERX, 1);
+
+    /* Enable the SPI */
+    REG32_WRITE_FIELD(f->dev, FLEXCOMM_SPI, CFG, ENABLE, 1);
+    g_assert(REG32_READ_FIELD(f->dev, FLEXCOMM_SPI, CFG, ENABLE) == 1);
+}
+
+/* The SPI controller running in master mode can run in loopback mode for */
+/* internal testing. Transmit and receive lines are connected together. */
+static void loopback_test(TestFixture *f, gconstpointer user_data)
+{
+    int i;
+
+    configure_spi(f, true, true);
+
+    /* Write a sequence */
+    for (i = 0; i < SEQ_LOOPBACK_MODE; i++) {
+        REG32_WRITE(f->dev, FLEXCOMM_SPI, FIFOWR, i);
+    }
+
+    /* Read the sequence back */
+    for (i = 0; i < SEQ_LOOPBACK_MODE; i++) {
+        g_assert(REG32_READ_FIELD(f->dev, FLEXCOMM_SPI, FIFORD, RXDATA) == i);
+    }
+}
+
+static void spi_master_test(TestFixture *f, gconstpointer user_data)
+{
+    uint32_t tmp;
+
+    configure_spi(f, true, false);
+
+    REG32_WRITE_FIELD(f->dev, FLEXCOMM_SPI, CFG, LSBF, 1);
+
+    /* single 16bit word transfer */
+
+    tmp = 0x1122;
+    tmp |= FLEXCOMM_SPI_FIFOWR_EOT_Msk;
+    tmp |= FLEXCOMM_SPI_FIFOWR_TXSSEL0_N_Msk;
+    tmp |= (0xF << FLEXCOMM_SPI_FIFOWR_LEN_Pos);
+    REG32_WRITE(f->dev, FLEXCOMM_SPI, FIFOWR, tmp);
+    g_assert(REG32_READ_FIELD(f->dev, FLEXCOMM_SPI, FIFOSTAT, RXNOTEMPTY) == 1);
+    g_assert_cmpuint(REG32_READ_FIELD(f->dev, FLEXCOMM_SPI, FIFORD, RXDATA),
+                     ==, 0x1122);
+    g_assert(REG32_READ_FIELD(f->dev, FLEXCOMM_SPI, FIFOSTAT, RXNOTEMPTY) == 0);
+
+    /* multi word 8 bits transfer */
+
+    tmp = 0x11;
+    tmp |= FLEXCOMM_SPI_FIFOWR_TXSSEL0_N_Msk;
+    tmp |= (0x7 << FLEXCOMM_SPI_FIFOWR_LEN_Pos);
+    REG32_WRITE(f->dev, FLEXCOMM_SPI, FIFOWR, tmp);
+    tmp = 0x22;
+    tmp |= FLEXCOMM_SPI_FIFOWR_EOT_Msk;
+    tmp |= FLEXCOMM_SPI_FIFOWR_TXSSEL0_N_Msk;
+    tmp |= (0x7 << FLEXCOMM_SPI_FIFOWR_LEN_Pos);
+    REG32_WRITE(f->dev, FLEXCOMM_SPI, FIFOWR, tmp);
+    g_assert(REG32_READ_FIELD(f->dev, FLEXCOMM_SPI, FIFOSTAT, RXNOTEMPTY) == 1);
+    g_assert(REG32_READ_FIELD(f->dev, FLEXCOMM_SPI, FIFORD, RXDATA) == 0x11);
+    g_assert(REG32_READ_FIELD(f->dev, FLEXCOMM_SPI, FIFOSTAT, RXNOTEMPTY) == 1);
+    g_assert(REG32_READ_FIELD(f->dev, FLEXCOMM_SPI, FIFORD, RXDATA) == 0x22);
+    g_assert(REG32_READ_FIELD(f->dev, FLEXCOMM_SPI, FIFOSTAT, RXNOTEMPTY) == 0);
+}
+
+
+/* mock-up */
+const PropertyInfo qdev_prop_chr;
+
+int main(int argc, char **argv)
+{
+    qemu_init_main_loop(&error_abort);
+    socket_init();
+
+    g_test_init(&argc, &argv, NULL);
+
+    /* Initialize object types. */
+    sysbus_mock_init();
+    module_call_init(MODULE_INIT_QOM);
+    qemu_add_opts(&qemu_chardev_opts);
+
+    g_test_add("/flexcomm-spi/loopback", TestFixture,
+               (gconstpointer)(1 << FLEXCOMM_FUNC_SPI),
+               set_up, loopback_test, tear_down);
+
+    g_test_add("/flexcomm-spi/master", TestFixture,
+               (gconstpointer)(1 << FLEXCOMM_FUNC_SPI),
+               set_up, spi_master_test, tear_down);
+
+    return g_test_run();
+}
-- 
2.46.0.rc2.264.g509ed76dc8-goog


