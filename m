Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 638F5C3DA7F
	for <qemu-devel@archiver.kernel.org>; Mon,  5 Aug 2024 20:19:12 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sb49K-000335-PE; Mon, 05 Aug 2024 16:17:46 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from
 <3YDOxZgUKCsc6n8v2t11tyr.p1z3rz7-qr8ry010t07.14t@flex--tavip.bounces.google.com>)
 id 1sb49I-0002of-Cq
 for qemu-devel@nongnu.org; Mon, 05 Aug 2024 16:17:44 -0400
Received: from mail-pg1-x549.google.com ([2607:f8b0:4864:20::549])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from
 <3YDOxZgUKCsc6n8v2t11tyr.p1z3rz7-qr8ry010t07.14t@flex--tavip.bounces.google.com>)
 id 1sb49F-0001RE-9v
 for qemu-devel@nongnu.org; Mon, 05 Aug 2024 16:17:44 -0400
Received: by mail-pg1-x549.google.com with SMTP id
 41be03b00d2f7-649731dd35bso8223203a12.0
 for <qemu-devel@nongnu.org>; Mon, 05 Aug 2024 13:17:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=google.com; s=20230601; t=1722889057; x=1723493857; darn=nongnu.org;
 h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
 :date:from:to:cc:subject:date:message-id:reply-to;
 bh=xU5YoCp1yOlClenc+sMgGqOCDAj0a2iC6b3QkZBvnbA=;
 b=pdm/NZJFqMH1tWDotNl04VKDoHIWvrEJ83hniYdxmn9D16cynV0ETM7EHgV3ubrJND
 w4ljJza6vW8B0awYubUlwZSNOJM8slmLYxE2jjYtyiep3cjBs/1J4wooPmrfHjSIZ5+x
 362gNKukqQ9W0A0GPKPA94YvAp5r62HVZ06ag3cm919WJib6UaHjskPNC7pAqDgvdAcy
 0ozf6UIjaZW4477dV7yDexEz4IYc9Z9zifTi43ijoEJS+8i8c8i1dcM6SirV0IWqD4sB
 HM5an3Djsdeolu7u+MutEld2KuzzDALFR5dK5NZAZuzqbEZjOrmM2l6Sd6+Pvh6eFCxP
 3MeA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1722889057; x=1723493857;
 h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
 :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=xU5YoCp1yOlClenc+sMgGqOCDAj0a2iC6b3QkZBvnbA=;
 b=IqIXX7D2pYayq/AGHjWUi45VHvuVp4i5iellKEjbAtai4YS3l+wafD3AEXFafKsFqK
 ozA4e2oj+nQcO2UA/QYSwTMIZMCSFoPTichU7hMQM91qgixSjNJZOE/4XttbY6xd6djj
 ylo6zHBP0nx7alcva7uevrnHBEq+aXqRa1ICU+hKMMYX2UPDZ+Ko/jN1YL0oZ9+DwPaO
 mZamxJVaPyfTxxoDwR6jKmY/SpCPBebLtEORg8F+45dANpVPVzp6d3deLfsuhMMKikqR
 ST4JGSUhcr9eAX+JxJhYr1UPo923nTE1kI5JhR2jCQxxSAn3A/P7JsAXufFKg4t0fyjy
 Wy3Q==
X-Gm-Message-State: AOJu0YyyQz0r/UCi/nFpXwTFlyDyf7aK5Y/q3rIkrwui0yALGV+tOare
 VDEFAXwbagZ5pvQpA8676OomZSilw7M98KGtke7e/Gr/Al83ADHt4tva7S/9Oi21rVdBJOtjaso
 O0+hAPNOwWmiRWmjnBqW8wG5EoAwhl60I09j8LQFE21YAQvmennYN7zQqQyTsPultMe72rYDc/7
 GcYWeDTuMa8dnHeARFpsspk04kfg==
X-Google-Smtp-Source: AGHT+IEtEwV3xypSgEnFhmUjU6qXW1j+oyQGdeQtD2Sw0m7UuLuMq4ZYQZwgA67eCesfEw+/BoRavLh1Bw==
X-Received: from warp10.c.googlers.com ([fda3:e722:ac3:cc00:24:72f4:c0a8:750])
 (user=tavip job=sendgmr) by 2002:a17:902:d4c5:b0:1fd:73e6:83c0
 with SMTP id
 d9443c01a7336-1ff572a43eemr5414585ad.1.1722889056755; Mon, 05 Aug 2024
 13:17:36 -0700 (PDT)
Date: Mon,  5 Aug 2024 13:17:04 -0700
In-Reply-To: <20240805201719.2345596-1-tavip@google.com>
Mime-Version: 1.0
References: <20240805201719.2345596-1-tavip@google.com>
X-Mailer: git-send-email 2.46.0.rc2.264.g509ed76dc8-goog
Message-ID: <20240805201719.2345596-10-tavip@google.com>
Subject: [RFC PATCH 09/23] test/unit: add flexcomm unit test
From: Octavian Purdila <tavip@google.com>
To: qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org, stefanst@google.com, pbonzini@redhat.com, 
 alex.bennee@linaro.org, thuth@redhat.com, peter.maydell@linaro.org, 
 marcandre.lureau@redhat.com, alistair@alistair23.me, berrange@redhat.com, 
 philmd@linaro.org, jsnow@redhat.com, crosa@redhat.com, bleal@redhat.com
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::549;
 envelope-from=3YDOxZgUKCsc6n8v2t11tyr.p1z3rz7-qr8ry010t07.14t@flex--tavip.bounces.google.com;
 helo=mail-pg1-x549.google.com
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

Add flexcomm function selection unit tests.

Signed-off-by: Octavian Purdila <tavip@google.com>
---
 tests/unit/meson.build     |   8 +-
 tests/unit/test-flexcomm.c | 215 +++++++++++++++++++++++++++++++++++++
 2 files changed, 222 insertions(+), 1 deletion(-)
 create mode 100644 tests/unit/test-flexcomm.c

diff --git a/tests/unit/meson.build b/tests/unit/meson.build
index 397f2503f8..4ccb15404d 100644
--- a/tests/unit/meson.build
+++ b/tests/unit/meson.build
@@ -141,7 +141,13 @@ if have_system
     'test-bufferiszero': [],
     'test-smp-parse': [qom, meson.project_source_root() / 'hw/core/machine-smp.c'],
     'test-vmstate': [migration, io],
-    'test-yank': ['socket-helpers.c', qom, io, chardev]
+    'test-yank': ['socket-helpers.c', qom, io, chardev],
+    'test-flexcomm': [
+      hwcore,
+      meson.project_source_root() / 'hw/core/gpio.c',
+      meson.project_source_root() / 'tests/unit/sysbus-mock.c',
+      meson.project_source_root() / 'hw/misc/flexcomm.c',
+     ],
   }
   if config_host_data.get('CONFIG_INOTIFY1')
     tests += {'test-util-filemonitor': []}
diff --git a/tests/unit/test-flexcomm.c b/tests/unit/test-flexcomm.c
new file mode 100644
index 0000000000..f4efe2ac52
--- /dev/null
+++ b/tests/unit/test-flexcomm.c
@@ -0,0 +1,215 @@
+/*
+ * Copyright (C) 2024 Google LLC
+ *
+ * SPDX-License-Identifier: GPL-2.0-or-later
+ *
+ * This work is licensed under the terms of the GNU GPL, version 2 or later.
+ * See the COPYING file in the top-level directory.
+ */
+
+#include "qemu/osdep.h"
+#include "qemu/log.h"
+#include "qemu/module.h"
+#include "qemu/main-loop.h"
+#include "exec/memory.h"
+#include "hw/irq.h"
+#include "hw/qdev-properties.h"
+
+#include "hw/misc/flexcomm.h"
+#include "sysbus-mock.h"
+#include "reg-utils.h"
+
+#define MAX_MSG_STACK 2
+
+typedef struct {
+    DeviceState *dev;
+    char *msg[MAX_MSG_STACK];
+    int msg_count;
+} TestFixture;
+
+#define SELECT_MSG(f, selected) "f[%d]select(%d)", f, selected
+#define REG_READ_MSG(f, addr, size) "f[%d]reg_read(%x, %d)", f, \
+        (uint32_t)addr, size
+#define REG_WRITE_MSG(f, addr, data, size) "f[%d]reg_write(%x, %x, %d)", \
+        f, (uint32_t)addr, (uint32_t)data, size
+
+#define FLEXCOMM_BASE 0x40106000UL
+
+
+static void f_ops_select(void *opaque, FlexcommState *s, int f,
+                         bool selected)
+{
+    TestFixture *tf = (TestFixture *)opaque;
+
+    tf->msg[tf->msg_count++] = g_strdup_printf(SELECT_MSG(f, selected));
+}
+
+static MemTxResult f_ops_reg_read(void *opaque, FlexcommState *s, int f,
+                                  hwaddr addr, uint64_t *data, unsigned size)
+{
+    TestFixture *tf = (TestFixture *)opaque;
+
+    tf->msg[tf->msg_count++] = g_strdup_printf(REG_READ_MSG(f, addr, size));
+    return MEMTX_OK;
+}
+
+static MemTxResult f_ops_reg_write(void *opaque, FlexcommState *s, int f,
+                                   hwaddr addr, uint64_t data, unsigned size)
+{
+    TestFixture *tf = (TestFixture *)opaque;
+
+    tf->msg[tf->msg_count++] = g_strdup_printf(REG_WRITE_MSG(f, addr, data,
+                                                             size));
+    return MEMTX_OK;
+}
+
+static void assert_msg(TestFixture *f, const char *fmt, ...)
+    __attribute__((format(printf, 2, 3)));
+
+static void assert_msg(TestFixture *f, const char *fmt, ...)
+{
+    va_list ap;
+    char *msg;
+
+    va_start(ap, fmt);
+    msg = g_strdup_vprintf(fmt, ap);
+    va_end(ap);
+
+    g_assert_cmpstr(msg, ==, f->msg[--f->msg_count]);
+}
+
+static const FlexcommFunctionOps f_ops = {
+    .select = f_ops_select,
+    .reg_read = f_ops_reg_read,
+    .reg_write = f_ops_reg_write,
+};
+
+/*
+ * Test fixture initialization.
+ */
+static void set_up(TestFixture *f, gconstpointer data)
+{
+    int i;
+
+    f->dev = qdev_new(TYPE_FLEXCOMM);
+    g_assert(f->dev);
+
+    if (data != NULL) {
+        qdev_prop_set_int32(DEVICE(f->dev), "functions", (uintptr_t)data);
+    }
+
+    qdev_realize_and_unref(f->dev, NULL, NULL);
+    sysbus_mmio_map(SYS_BUS_DEVICE(f->dev), 0, FLEXCOMM_BASE);
+
+    for (i = 0; i < FLEXCOMM_FUNCTIONS; i++) {
+        /* replace functions ops */
+        flexcomm_unregister_ops(i);
+        assert(flexcomm_register_ops(i, f, &f_ops, NULL));
+        assert(!flexcomm_register_ops(i, f, &f_ops, NULL));
+    }
+
+    device_cold_reset(f->dev);
+}
+
+static void tear_down(TestFixture *f, gconstpointer user_data)
+{
+    qdev_unrealize(f->dev);
+    g_free(f->dev);
+}
+
+static void select_test(TestFixture *f, gconstpointer user_data)
+{
+    uint32_t tmp = 0;
+    struct {
+        int persel;
+        int func;
+    } persel_func_map[] = {
+        { FLEXCOMM_PERSEL_USART, FLEXCOMM_FUNC_USART },
+        { FLEXCOMM_PERSEL_SPI, FLEXCOMM_FUNC_SPI },
+        { FLEXCOMM_PERSEL_I2C, FLEXCOMM_FUNC_I2C },
+        { FLEXCOMM_PERSEL_I2S_TX, FLEXCOMM_FUNC_I2S },
+        { FLEXCOMM_PERSEL_I2S_RX, FLEXCOMM_FUNC_I2S },
+    };
+    int i;
+
+    /* test that no function is selected */
+    g_assert(REG32_READ_FIELD(f->dev, FLEXCOMM, PSELID, PERSEL) == 0);
+
+    /* no register access until a function is selected  */
+    g_assert(reg32_addr_read_raw(f->dev, FLEXCOMM_BASE, &tmp, 4)
+             == MEMTX_ERROR);
+    g_assert(reg32_addr_write_raw(f->dev, FLEXCOMM_BASE, tmp, 4)
+             == MEMTX_ERROR);
+
+    /* test that we can select all functions (including I2S RX) */
+    for (i = 0; i < ARRAY_SIZE(persel_func_map); i++) {
+        int persel = persel_func_map[i].persel;
+        int func = persel_func_map[i].func;
+
+        REG32_WRITE(f->dev, FLEXCOMM, PSELID, persel);
+        g_assert(REG32_READ_FIELD(f->dev, FLEXCOMM, PSELID, PERSEL) == persel);
+        g_assert(REG32_READ_FIELD(f->dev, FLEXCOMM, PID, ID) == persel);
+
+        /* check that current function was selected */
+        assert_msg(f, SELECT_MSG(func, 1));
+
+        /* check that previous function was de-selected */
+        if (i > 0) {
+            int prev_func = persel_func_map[i - 1].func;
+
+            assert_msg(f, SELECT_MSG(prev_func, 0));
+        }
+
+        /* test that we can access function registers */
+        reg32_addr_write_raw(f->dev, FLEXCOMM_BASE + 0x100, 0xabcd, 4);
+        assert_msg(f, REG_WRITE_MSG(func, 0x100, 0xabcd, 4));
+
+        reg32_addr_read_raw(f->dev, FLEXCOMM_BASE + 0x100, &tmp, 4);
+        assert_msg(f, REG_READ_MSG(func, 0x100, 4));
+    }
+
+    /* try to select something invalid */
+    REG32_WRITE(f->dev, FLEXCOMM, PSELID, 7);
+    /* check for no function selected */
+    g_assert(REG32_READ_FIELD(f->dev, FLEXCOMM, PSELID, PERSEL) == 0);
+    g_assert(REG32_READ_FIELD(f->dev, FLEXCOMM, PID, ID) == 0);
+    /* check that previous function was deselected */
+    assert_msg(f, SELECT_MSG(FLEXCOMM_FUNC_I2S, 0));
+
+    /* now select and lock USART */
+    tmp = FLEXCOMM_PSELID_LOCK_Msk | FLEXCOMM_PERSEL_USART;
+    REG32_WRITE(f->dev, FLEXCOMM, PSELID, tmp);
+    tmp = REG32_READ_FIELD(f->dev, FLEXCOMM, PSELID, PERSEL);
+    g_assert(tmp == FLEXCOMM_PERSEL_USART);
+    g_assert(REG32_READ_FIELD(f->dev, FLEXCOMM, PSELID, LOCK) == 1);
+    tmp = REG32_READ_FIELD(f->dev, FLEXCOMM, PID, ID);
+    g_assert(tmp == FLEXCOMM_PERSEL_USART);
+    assert_msg(f, SELECT_MSG(FLEXCOMM_FUNC_USART, 1));
+
+    /* try to change the selection to spi */
+    REG32_WRITE(f->dev, FLEXCOMM, PSELID, FLEXCOMM_PERSEL_SPI);
+    /* it should still be locked USART */
+    tmp = REG32_READ_FIELD(f->dev, FLEXCOMM, PSELID, PERSEL);
+    g_assert(tmp == FLEXCOMM_PERSEL_USART);
+    g_assert(REG32_READ_FIELD(f->dev, FLEXCOMM, PSELID, LOCK) == 1);
+    tmp = REG32_READ_FIELD(f->dev, FLEXCOMM, PID, ID);
+    g_assert(tmp == FLEXCOMM_PERSEL_USART);
+}
+
+/* mock-up */
+const PropertyInfo qdev_prop_chr;
+
+int main(int argc, char **argv)
+{
+    g_test_init(&argc, &argv, NULL);
+
+    /* Initialize object types. */
+    sysbus_mock_init();
+    module_call_init(MODULE_INIT_QOM);
+
+    g_test_add("/flexcomm/select_test", TestFixture,
+               (gconstpointer)FLEXCOMM_FULL, set_up, select_test,
+               tear_down);
+
+    return g_test_run();
+}
-- 
2.46.0.rc2.264.g509ed76dc8-goog


