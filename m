Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ADA44C52D7F
	for <qemu-devel@archiver.kernel.org>; Sat, 17 Aug 2024 10:29:25 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sfGeK-00088V-Um; Sat, 17 Aug 2024 06:27:08 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from
 <34HrAZgUKChUEvG3A19916z.x97Bz7F-yzGz689818F.9C1@flex--tavip.bounces.google.com>)
 id 1sfGe3-0006lK-1J
 for qemu-devel@nongnu.org; Sat, 17 Aug 2024 06:26:52 -0400
Received: from mail-pg1-x54a.google.com ([2607:f8b0:4864:20::54a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from
 <34HrAZgUKChUEvG3A19916z.x97Bz7F-yzGz689818F.9C1@flex--tavip.bounces.google.com>)
 id 1sfGdz-0003Jo-BO
 for qemu-devel@nongnu.org; Sat, 17 Aug 2024 06:26:50 -0400
Received: by mail-pg1-x54a.google.com with SMTP id
 41be03b00d2f7-7a267d9e7b0so2230370a12.2
 for <qemu-devel@nongnu.org>; Sat, 17 Aug 2024 03:26:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=google.com; s=20230601; t=1723890402; x=1724495202; darn=nongnu.org;
 h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
 :date:from:to:cc:subject:date:message-id:reply-to;
 bh=jrfugPeSIojLMkZyOUDpR5lNbRABMXvASxgVCAUl6jI=;
 b=C4SvhjMPebb0BUE8eLnJlXTjYP1hRkvaM0H/uzT1Fhj3jNcNugeLkLbJHKyPYA15XH
 CMgVDxaH3Jzv01XAzdt5DZn2Tqo26NI3jnKR4bSECUVgl0vFrGC0uNp/EOvC3OsEKmlB
 W7MBzEZlSZPGL9fnoE6wjLv2nCC+8Yu4JGzUH/aa4W83A6xAhZgcD6YPKG/SooOW7QZg
 Njn7xqXFFrC5WkOVvmrGZFp34JU8PWeciMcC8HS6d6I4kOi8ya/lf26CsjCs1pmvfvVD
 dBtI0JF352VFuxpJBRuMzQfKQffX4Z5xbzUJSFRlzZ9PqQ3sfXNVvFOAyY56vnpDh4TI
 nZzQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1723890402; x=1724495202;
 h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
 :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=jrfugPeSIojLMkZyOUDpR5lNbRABMXvASxgVCAUl6jI=;
 b=P83W+4Kj0sL44XZyVpwQWaquNp8K/n3L81kAFGFob7vKnz3n2jRtcbIXZ7HALNzrbC
 AnYCFnc5W8vzt4XyK/d+7PWJLioDsSfGLujiKy/8orQMAr99j0ljo/u0UJC0fjVkN6Td
 wIoFTngwK9SrjZPgcUPS7dbKOHytwitxtVzRBuevlpTr0v43gpaKTpvFfF4gaZN9Ofk1
 wH8teTwVl5EZC0TPhTKYJXAL7svnu3w8C/uFRzvSaOvETMC9bs4KOX1tHLQJk2w0ffgp
 +178kRcAcYlfZ+IhbbaizNezoCNGFIAw8LwekFj6ZlRXB4JQJ/yrXJ1g6MyYuZtvTWUK
 PmsQ==
X-Gm-Message-State: AOJu0YyKJB4vfthSI426bIZUN4RsndNc4tb+7bLV1c5lSdqzFeiyNCPU
 0ZiY4pt23KHErUYnWUWxLlxzZY+itx/+28AhcabEbf43SLZMANiE++jqTaFbAmU4col1W5dO/A9
 pBdURtj6rLUOKPZPB/KA/MBdkca5AOu9fyooCXaFawU1fPnEJ0LEOOznu+W0u7f10rVtl7Vg5Vt
 BoyCAIPTZABX9e0Gn+IDZshARNTA==
X-Google-Smtp-Source: AGHT+IHaZll7FNxDwUjRwcF04hm24gyLNoSa3B7s6lzVwGAosu6Lf2SHaDxeIhEnAq1L3JTWKq4SCNv/eg==
X-Received: from warp10.c.googlers.com ([fda3:e722:ac3:cc00:24:72f4:c0a8:750])
 (user=tavip job=sendgmr) by 2002:a05:6a02:581:b0:7a1:95c1:de3f
 with SMTP id
 41be03b00d2f7-7c975f682c9mr10767a12.0.1723890400429; Sat, 17 Aug 2024
 03:26:40 -0700 (PDT)
Date: Sat, 17 Aug 2024 03:26:00 -0700
In-Reply-To: <20240817102606.3996242-1-tavip@google.com>
Mime-Version: 1.0
References: <20240817102606.3996242-1-tavip@google.com>
X-Mailer: git-send-email 2.46.0.184.g6999bdac58-goog
Message-ID: <20240817102606.3996242-18-tavip@google.com>
Subject: [RFC PATCH v2 17/23] test/unit: add unit tests for flexcomm spi
From: Octavian Purdila <tavip@google.com>
To: qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org, stefanst@google.com, pbonzini@redhat.com, 
 thuth@redhat.com, peter.maydell@linaro.org, marcandre.lureau@redhat.com, 
 alistair@alistair23.me, berrange@redhat.com, philmd@linaro.org, 
 jsnow@redhat.com, crosa@redhat.com
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::54a;
 envelope-from=34HrAZgUKChUEvG3A19916z.x97Bz7F-yzGz689818F.9C1@flex--tavip.bounces.google.com;
 helo=mail-pg1-x54a.google.com
X-Spam_score_int: -95
X-Spam_score: -9.6
X-Spam_bar: ---------
X-Spam_report: (-9.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_MED=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01,
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
[tavip: add master mode test]
Signed-off-by: Octavian Purdila <tavip@google.com>
---
 tests/unit/test-flexcomm-spi.c | 201 +++++++++++++++++++++++++++++++++
 tests/unit/meson.build         |  12 ++
 2 files changed, 213 insertions(+)
 create mode 100644 tests/unit/test-flexcomm-spi.c

diff --git a/tests/unit/test-flexcomm-spi.c b/tests/unit/test-flexcomm-spi.c
new file mode 100644
index 0000000000..c15c8e608b
--- /dev/null
+++ b/tests/unit/test-flexcomm-spi.c
@@ -0,0 +1,201 @@
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
+    tmp = FLEXCOMM_PERSEL_SPI;
+    FIELD_DP32(tmp, FLEXCOMM_PSELID, LOCK, 1);
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
+    configure_spi(f, true, true);
+
+    /* Write a sequence */
+    for (int i = 0; i < SEQ_LOOPBACK_MODE; i++) {
+        REG32_WRITE(f->dev, FLEXCOMM_SPI, FIFOWR, i);
+    }
+
+    /* Read the sequence back */
+    for (int i = 0; i < SEQ_LOOPBACK_MODE; i++) {
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
+    tmp = FIELD_DP32(0x1122, FLEXCOMM_SPI_FIFOWR, EOT, 1);
+    tmp = FIELD_DP32(tmp, FLEXCOMM_SPI_FIFOWR, TXSSEL0_N, 1);
+    tmp = FIELD_DP32(tmp, FLEXCOMM_SPI_FIFOWR, LEN, 0xF);
+    REG32_WRITE(f->dev, FLEXCOMM_SPI, FIFOWR, tmp);
+    g_assert(REG32_READ_FIELD(f->dev, FLEXCOMM_SPI, FIFOSTAT, RXNOTEMPTY) == 1);
+    g_assert_cmpuint(REG32_READ_FIELD(f->dev, FLEXCOMM_SPI, FIFORD, RXDATA),
+                     ==, 0x1122);
+    g_assert(REG32_READ_FIELD(f->dev, FLEXCOMM_SPI, FIFOSTAT, RXNOTEMPTY) == 0);
+
+    /* multi word 8 bits transfer */
+
+    tmp = FIELD_DP32(0x11, FLEXCOMM_SPI_FIFOWR, TXSSEL0_N, 1);
+    tmp = FIELD_DP32(tmp, FLEXCOMM_SPI_FIFOWR, LEN, 0x7);
+    REG32_WRITE(f->dev, FLEXCOMM_SPI, FIFOWR, tmp);
+    tmp = 0x22;
+    FIELD_DP32(tmp, FLEXCOMM_SPI_FIFOWR, EOT, 1);
+    FIELD_DP32(tmp, FLEXCOMM_SPI_FIFOWR, TXSSEL0_N, 1);
+    FIELD_DP32(tmp, FLEXCOMM_SPI_FIFOWR, LEN, 0x7);
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
diff --git a/tests/unit/meson.build b/tests/unit/meson.build
index 033e98483f..7a28e7b521 100644
--- a/tests/unit/meson.build
+++ b/tests/unit/meson.build
@@ -176,6 +176,18 @@ if have_system
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
+    ],
   }
   if config_host_data.get('CONFIG_INOTIFY1')
     tests += {'test-util-filemonitor': []}
-- 
2.46.0.184.g6999bdac58-goog


