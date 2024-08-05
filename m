Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4D4A0C3DA7F
	for <qemu-devel@archiver.kernel.org>; Mon,  5 Aug 2024 20:19:26 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sb49U-0003lZ-7k; Mon, 05 Aug 2024 16:17:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from
 <3aTOxZgUKCtAFwH4B2AA270.yA8C08G-z0H079A929G.AD2@flex--tavip.bounces.google.com>)
 id 1sb49R-0003YK-6p
 for qemu-devel@nongnu.org; Mon, 05 Aug 2024 16:17:53 -0400
Received: from mail-yb1-xb49.google.com ([2607:f8b0:4864:20::b49])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from
 <3aTOxZgUKCtAFwH4B2AA270.yA8C08G-z0H079A929G.AD2@flex--tavip.bounces.google.com>)
 id 1sb49M-0001Ua-QM
 for qemu-devel@nongnu.org; Mon, 05 Aug 2024 16:17:52 -0400
Received: by mail-yb1-xb49.google.com with SMTP id
 3f1490d57ef6-e0ba4d19585so12221910276.0
 for <qemu-devel@nongnu.org>; Mon, 05 Aug 2024 13:17:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=google.com; s=20230601; t=1722889066; x=1723493866; darn=nongnu.org;
 h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
 :date:from:to:cc:subject:date:message-id:reply-to;
 bh=ZCjJ5sPbPGT4/PTAX3XbZdjutmIYVAwZmRenYV+abhM=;
 b=nN6T+zNebGkR+9/2SR8+ARnk98GB+/+d+nP312ksC/Bn/FijEizrVu+pW1fMsrIib2
 BkcuyUbh/qMO99cuxg2WSf91IJU2yovUjiz5UKrB08pGvzdKKhV4hvgH1R9rD7puNLK7
 XkLldWV/Cdlw8EK/kU3Morwl+rxvPoAiO9F9yybQGCBzkvjh+/rTt41DRukeRJPSWlZ0
 jJWZjlGEcR3s2EILTVJG6wNgFgD886NxNUwiJa3C7loeQvJxqJT8mH/cfhhz/IH+JZLN
 uD2iXzdwFzJsO3VymKwSTNrWrTyZJEelRcU4e9nkus93DIWL5A6DgR3j7U8PV6GO1f3/
 hsEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1722889066; x=1723493866;
 h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
 :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=ZCjJ5sPbPGT4/PTAX3XbZdjutmIYVAwZmRenYV+abhM=;
 b=PST0zBMibx1eRk2PzF550GUYvm7xGrWkULr82EzD/MhLsboBnY25RY2VhjE9FlWwYE
 MXvRDVz/xqhIGvlLKSuN0B39/18qUXdSutSODyqCF0qEAndRXfE5D2RLrw81uBJM8go1
 tRrW5TLTRTbiKMsDqILziG2iJLc4YoWZ3O7IwOrr0jcAm0T/AJl7+6MSyZs8bN7hFFhb
 6eMju0n8tFOhpq1OTRkYgWgfAmm9HeOE26GXx07ZdaqrKblUU6hOGk2A0YmdB+LkyRRr
 2dt3rmtkigDrFJd3Lnbz8pvRirhLaurS6scSLpHh1Zq/d4fpzbwseqArss7lsaVy2UXp
 f4Ug==
X-Gm-Message-State: AOJu0YwXSsOEbvRSfqJ45TlFZTFwH8ezIXpRlO/qwV0PG4Gk9o9KcsoR
 5cGpfDAFeNtKA7mwy83c7d1xbtFhYX9uWpJoAWhz1pkWWFJPTYRrrehBjOOLxtiKirZNySibIU3
 032nA5ygle/1b6/ePa/1ad9r/xNQv9A7gXPzzinarpd7y6LYv95lcvpQsEB/uOVTuc8yekZckPH
 KuQEKd+eaqseMrHboToD7FjGl4Vw==
X-Google-Smtp-Source: AGHT+IG1Pt6E3mwx56V6QB58tAS/P9w8eY0tLuEvmxKONHteSzlgUW4zheNvXzY2wiJgw8FsY0r8S0yjHw==
X-Received: from warp10.c.googlers.com ([fda3:e722:ac3:cc00:24:72f4:c0a8:750])
 (user=tavip job=sendgmr) by 2002:a05:6902:154e:b0:e02:c06f:1db8
 with SMTP id
 3f1490d57ef6-e0bde2612ebmr23616276.4.1722889065783; Mon, 05 Aug 2024 13:17:45
 -0700 (PDT)
Date: Mon,  5 Aug 2024 13:17:09 -0700
In-Reply-To: <20240805201719.2345596-1-tavip@google.com>
Mime-Version: 1.0
References: <20240805201719.2345596-1-tavip@google.com>
X-Mailer: git-send-email 2.46.0.rc2.264.g509ed76dc8-goog
Message-ID: <20240805201719.2345596-15-tavip@google.com>
Subject: [RFC PATCH 14/23] test/unit: add unit tests for flexcomm i2c
From: Octavian Purdila <tavip@google.com>
To: qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org, stefanst@google.com, pbonzini@redhat.com, 
 alex.bennee@linaro.org, thuth@redhat.com, peter.maydell@linaro.org, 
 marcandre.lureau@redhat.com, alistair@alistair23.me, berrange@redhat.com, 
 philmd@linaro.org, jsnow@redhat.com, crosa@redhat.com, bleal@redhat.com
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::b49;
 envelope-from=3aTOxZgUKCtAFwH4B2AA270.yA8C08G-z0H079A929G.AD2@flex--tavip.bounces.google.com;
 helo=mail-yb1-xb49.google.com
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

Add master mode tests for flexcomm i2c.

Signed-off-by: Octavian Purdila <tavip@google.com>
---
 tests/unit/meson.build         |  10 ++
 tests/unit/test-flexcomm-i2c.c | 209 +++++++++++++++++++++++++++++++++
 2 files changed, 219 insertions(+)
 create mode 100644 tests/unit/test-flexcomm-i2c.c

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
diff --git a/tests/unit/test-flexcomm-i2c.c b/tests/unit/test-flexcomm-i2c.c
new file mode 100644
index 0000000000..9d02c94101
--- /dev/null
+++ b/tests/unit/test-flexcomm-i2c.c
@@ -0,0 +1,209 @@
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
+    tmp = FLEXCOMM_PSELID_LOCK_Msk | FLEXCOMM_PERSEL_I2C;
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
-- 
2.46.0.rc2.264.g509ed76dc8-goog


