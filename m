Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2AFAFCDD552
	for <qemu-devel@archiver.kernel.org>; Wed, 18 Sep 2024 19:29:33 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sr0H6-00064v-BU; Wed, 18 Sep 2024 15:23:40 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from
 <3tSjrZgUKCvAlSnahYggYdW.UgeiWem-VWnWdfgfYfm.gjY@flex--tavip.bounces.google.com>)
 id 1sr0H4-0005wW-7T
 for qemu-devel@nongnu.org; Wed, 18 Sep 2024 15:23:38 -0400
Received: from mail-pf1-x44a.google.com ([2607:f8b0:4864:20::44a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from
 <3tSjrZgUKCvAlSnahYggYdW.UgeiWem-VWnWdfgfYfm.gjY@flex--tavip.bounces.google.com>)
 id 1sr0H2-0007Py-EK
 for qemu-devel@nongnu.org; Wed, 18 Sep 2024 15:23:37 -0400
Received: by mail-pf1-x44a.google.com with SMTP id
 d2e1a72fcca58-7190c5e73cdso70788b3a.0
 for <qemu-devel@nongnu.org>; Wed, 18 Sep 2024 12:23:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=google.com; s=20230601; t=1726687415; x=1727292215; darn=nongnu.org;
 h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
 :date:from:to:cc:subject:date:message-id:reply-to;
 bh=j5CsnkrzorKCa1JKdBu6zJdVCIAE7wiQPKdUlC6Xodk=;
 b=eDl230l9bIYG93zlieor77rVvz/LSQXHsKjCBmAdj/na7dDSBz9wizbK88eQD0fZVy
 zBRLyy0W0/4i17Vj/vvYkjdR9k5O1xWoTyo6AWP8HaAGKM9wRF4C8xyX4XjsgK5LCn/S
 Z6stsTvMjYdnw3+/PCS3Wiwq5gS8FKr/b/ilx8tpu6TIcx0LJqJEj0P6KgV3EPXQAG8r
 fBut1c6t4e+wJbbntsvaMvX8Kl+4f3X/oBAz9MjFnZ9geEgDOqN++VC4pefe9oTxTSnh
 I1Xl+aKuFWKT0tVqTzSzg772pdu4OeqisbkGr/yWobJfq895D6LgA63OrelzuHteds3t
 UN3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1726687415; x=1727292215;
 h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
 :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=j5CsnkrzorKCa1JKdBu6zJdVCIAE7wiQPKdUlC6Xodk=;
 b=MRrR5aYbJLcFBWjAWyn2m6FgeSMRxjsnwB0jM5ZqXCpF9xBNpFsAuEydtakW4SUUD1
 BBhNGflc/bbExl3dwkFcxawwe5EpPHacNjJdbCKVQ94bEz27yYAVMnnP9qZRafDZK/fx
 dTmxKQOU/hImO1vaNaaGc8otZejQfHhnDZtDjlFn28eJlPircOm7E8e8Tt5yhHsQhlF5
 7vGZZnnkSAr/rmcFkOr75vKP5Lv6CeMHJyWq7yNf1USSARFrcDY66KY3TzFXBhpy6DUN
 dPOoD/V1j0jctDVmChzJvLifIda55ItjRVXevt/FnEODGeqBBEcqxIQNVvsApCswOGkL
 Y/eQ==
X-Gm-Message-State: AOJu0YymOag+KqVYeCMy/YjT8lvXGuY+pmtqGHGq663R5XZAgLPfK/bT
 Sd8k7d4njRDiv3kIAlfjr+dMAfOSaaG1AvP/dwugjyFnpNjBvgTrPy8vOr9Dvff3NQhWorgic9v
 +ZDUhSUG3hJvYvOjpb6ezMEcyWPGtTO7WV5TJnPscAKXeegGVPYrXCt9w7pvWALww27jwRH0gPW
 HDA+MenntcZ9ztRQt6To6Kzlk5hw==
X-Google-Smtp-Source: AGHT+IF2luWrPonjjl6Z2oIL7v55+3iflPoD++N7H/zqtc9j/3ZEBELLQW+6Rd3cqgi8AZpWLNNxg8JbXQ==
X-Received: from warp10.c.googlers.com ([fda3:e722:ac3:cc00:24:72f4:c0a8:750])
 (user=tavip job=sendgmr) by 2002:a05:6a00:6419:b0:70d:1285:bbcf
 with SMTP id
 d2e1a72fcca58-71925fa7878mr71729b3a.0.1726687413707; Wed, 18 Sep 2024
 12:23:33 -0700 (PDT)
Date: Wed, 18 Sep 2024 12:22:48 -0700
In-Reply-To: <20240918192254.3136903-1-tavip@google.com>
Mime-Version: 1.0
References: <20240918192254.3136903-1-tavip@google.com>
X-Mailer: git-send-email 2.46.0.662.g92d0881bb0-goog
Message-ID: <20240918192254.3136903-21-tavip@google.com>
Subject: [PATCH 20/25] tests/qtest: add tests for flexcomm i2c
From: Octavian Purdila <tavip@google.com>
To: qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org, stefanst@google.com, pbonzini@redhat.com, 
 peter.maydell@linaro.org, marcandre.lureau@redhat.com, berrange@redhat.com, 
 eduardo@habkost.net, luc@lmichel.fr, damien.hedde@dahe.fr, 
 alistair@alistair23.me, thuth@redhat.com, philmd@linaro.org, jsnow@redhat.com, 
 crosa@redhat.com, lvivier@redhat.com
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::44a;
 envelope-from=3tSjrZgUKCvAlSnahYggYdW.UgeiWem-VWnWdfgfYfm.gjY@flex--tavip.bounces.google.com;
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

Add master mode tests for flexcomm i2c.

Signed-off-by: Octavian Purdila <tavip@google.com>
---
 tests/qtest/flexcomm-i2c-test.c | 170 ++++++++++++++++++++++++++++++++
 tests/qtest/meson.build         |   2 +-
 2 files changed, 171 insertions(+), 1 deletion(-)
 create mode 100644 tests/qtest/flexcomm-i2c-test.c

diff --git a/tests/qtest/flexcomm-i2c-test.c b/tests/qtest/flexcomm-i2c-test.c
new file mode 100644
index 0000000000..45f31da7de
--- /dev/null
+++ b/tests/qtest/flexcomm-i2c-test.c
@@ -0,0 +1,170 @@
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
+#include "hw/arm/svd/flexcomm_i2c.h"
+#include "hw/arm/svd/rt500.h"
+#include "hw/misc/i2c_tester.h"
+#include "reg-utils.h"
+
+#define PERIPH_ADDR (0x50)
+#define INVALID_ADDR (0x10)
+
+#define REG_ADDR 11
+#define REG_VALUE 0xAA
+
+#define FLEXCOMM_BASE RT500_FLEXCOMM0_BASE
+#define FLEXCOMM_I2C_BASE RT500_FLEXCOMM0_BASE
+#define DEVICE_NAME "/machine/soc/flexcomm0"
+
+struct TestState {
+    QTestState *qtest;
+};
+
+static void master_test(gconstpointer user_data)
+{
+    struct TestState *t = (struct TestState *)user_data;
+    uint32_t tmp;
+
+    qtest_irq_intercept_out_named(t->qtest, DEVICE_NAME,
+                                  SYSBUS_DEVICE_GPIO_IRQ);
+
+    /* Select and lock I2C */
+    tmp = FLEXCOMM_PERSEL_I2C;
+    FIELD_DP32(tmp, FLEXCOMM_PSELID, LOCK, 1);
+    REG32_WRITE(FLEXCOMM, PSELID, tmp);
+
+    /* Enable master mode */
+    REG32_WRITE_FIELD(FLEXCOMM_I2C, CFG, MSTEN, 1);
+    g_assert(REG32_READ_FIELD(FLEXCOMM_I2C, CFG, MSTEN) == 1);
+
+    g_assert(REG32_READ_FIELD(FLEXCOMM_I2C, STAT, MSTPENDING) == 1);
+    g_assert(REG32_READ_FIELD(FLEXCOMM_I2C, STAT, MSTSTATE) ==
+             MSTSTATE_IDLE);
+
+    /* Enable interrupts */
+    REG32_WRITE_FIELD(FLEXCOMM_I2C, INTENSET, MSTPENDINGEN, 1);
+    g_assert_true(get_irq(0));
+
+    /* start for invalid address  */
+    REG32_WRITE(FLEXCOMM_I2C, MSTDAT, INVALID_ADDR);
+    REG32_WRITE_FIELD_NOUPDATE(FLEXCOMM_I2C, MSTCTL, MSTSTART, 1);
+    g_assert(REG32_READ_FIELD(FLEXCOMM_I2C, STAT, MSTSTATE) ==
+             MSTSTATE_NAKADR);
+    g_assert_true(get_irq(0));
+    REG32_WRITE_FIELD_NOUPDATE(FLEXCOMM_I2C, MSTCTL, MSTSTOP, 1);
+
+    /* write past the last register */
+    REG32_WRITE_FIELD(FLEXCOMM_I2C, MSTDAT, DATA, PERIPH_ADDR);
+    REG32_WRITE_FIELD_NOUPDATE(FLEXCOMM_I2C, MSTCTL, MSTSTART, 1);
+    g_assert_true(get_irq(0));
+    g_assert(REG32_READ_FIELD(FLEXCOMM_I2C, STAT, MSTSTATE) ==
+             MSTSTATE_TXRDY);
+    REG32_WRITE_FIELD(FLEXCOMM_I2C, MSTDAT, DATA, I2C_TESTER_NUM_REGS + 10);
+    REG32_WRITE_FIELD_NOUPDATE(FLEXCOMM_I2C, MSTCTL, MSTCONTINUE, 1);
+    g_assert_true(get_irq(0));
+    g_assert(REG32_READ_FIELD(FLEXCOMM_I2C, STAT, MSTSTATE) ==
+             MSTSTATE_TXRDY);
+    REG32_WRITE_FIELD_NOUPDATE(FLEXCOMM_I2C, MSTCTL, MSTCONTINUE, 1);
+    g_assert_true(get_irq(0));
+    g_assert(REG32_READ_FIELD(FLEXCOMM_I2C, STAT, MSTSTATE) ==
+             MSTSTATE_NAKDAT);
+    REG32_WRITE_FIELD_NOUPDATE(FLEXCOMM_I2C, MSTCTL, MSTSTOP, 1);
+
+    /* write value to register */
+    REG32_WRITE_FIELD(FLEXCOMM_I2C, MSTDAT, DATA, PERIPH_ADDR);
+    REG32_WRITE_FIELD_NOUPDATE(FLEXCOMM_I2C, MSTCTL, MSTSTART, 1);
+    g_assert_true(get_irq(0));
+    g_assert(REG32_READ_FIELD(FLEXCOMM_I2C, STAT, MSTSTATE) ==
+             MSTSTATE_TXRDY);
+    REG32_WRITE_FIELD(FLEXCOMM_I2C, MSTDAT, DATA, REG_ADDR);
+    REG32_WRITE_FIELD_NOUPDATE(FLEXCOMM_I2C, MSTCTL, MSTCONTINUE, 1);
+    g_assert_true(get_irq(0));
+    g_assert(REG32_READ_FIELD(FLEXCOMM_I2C, STAT, MSTSTATE) ==
+             MSTSTATE_TXRDY);
+    REG32_WRITE_FIELD(FLEXCOMM_I2C, MSTDAT, DATA, REG_VALUE);
+    REG32_WRITE_FIELD_NOUPDATE(FLEXCOMM_I2C, MSTCTL, MSTCONTINUE, 1);
+    g_assert_true(get_irq(0));
+    g_assert(REG32_READ_FIELD(FLEXCOMM_I2C, STAT, MSTSTATE) ==
+             MSTSTATE_TXRDY);
+    REG32_WRITE_FIELD_NOUPDATE(FLEXCOMM_I2C, MSTCTL, MSTSTOP, 1);
+    g_assert_true(get_irq(0));
+    g_assert(REG32_READ_FIELD(FLEXCOMM_I2C, STAT, MSTSTATE) ==
+             MSTSTATE_IDLE);
+
+    /* read value back from register */
+    REG32_WRITE_FIELD(FLEXCOMM_I2C, MSTDAT, DATA, PERIPH_ADDR);
+    REG32_WRITE_FIELD_NOUPDATE(FLEXCOMM_I2C, MSTCTL, MSTSTART, 1);
+    g_assert_true(get_irq(0));
+    g_assert(REG32_READ_FIELD(FLEXCOMM_I2C, STAT, MSTSTATE) ==
+             MSTSTATE_TXRDY);
+    REG32_WRITE_FIELD(FLEXCOMM_I2C, MSTDAT, DATA, REG_ADDR);
+    REG32_WRITE_FIELD_NOUPDATE(FLEXCOMM_I2C, MSTCTL, MSTCONTINUE, 1);
+    g_assert_true(get_irq(0));
+    g_assert(REG32_READ_FIELD(FLEXCOMM_I2C, STAT, MSTSTATE) ==
+             MSTSTATE_TXRDY);
+    REG32_WRITE_FIELD(FLEXCOMM_I2C, MSTDAT, DATA, (PERIPH_ADDR + 1));
+    REG32_WRITE_FIELD_NOUPDATE(FLEXCOMM_I2C, MSTCTL, MSTSTART, 1);
+    g_assert_true(get_irq(0));
+    g_assert(REG32_READ_FIELD(FLEXCOMM_I2C, STAT, MSTSTATE) ==
+             MSTSTATE_RXRDY);
+    g_assert_cmpuint(REG32_READ_FIELD(FLEXCOMM_I2C, MSTDAT, DATA), ==,
+                     REG_VALUE);
+    REG32_WRITE_FIELD_NOUPDATE(FLEXCOMM_I2C, MSTCTL, MSTSTOP, 1);
+
+    /*
+     * Check that the master ended the transaction (i.e. i2c_end_transfer was
+     * called). If the master does not properly end the transaction this would
+     * be seen as a restart and it would not be NACKed.
+     */
+    REG32_WRITE_FIELD(FLEXCOMM_I2C, MSTDAT, DATA, INVALID_ADDR);
+    REG32_WRITE_FIELD_NOUPDATE(FLEXCOMM_I2C, MSTCTL, MSTSTART, 1);
+
+    g_assert(REG32_READ_FIELD(FLEXCOMM_I2C, STAT, MSTSTATE) ==
+             MSTSTATE_NAKADR);
+    g_assert_true(get_irq(0));
+    REG32_WRITE_FIELD_NOUPDATE(FLEXCOMM_I2C, MSTCTL, MSTSTOP, 1);
+
+    /* Disable interrupts */
+    REG32_WRITE_FIELD(FLEXCOMM_I2C, INTENCLR, MSTPENDINGCLR, 1);
+    g_assert_false(get_irq(0));
+}
+
+int main(int argc, char **argv)
+{
+    int ret;
+    struct TestState test;
+
+    module_call_init(MODULE_INIT_QOM);
+    g_test_init(&argc, &argv, NULL);
+
+    qtest_add_data_func("/flexcomm-i2c/master", &test, master_test);
+
+    test.qtest = qtest_start("-M rt595-evk "
+                          "-device i2c-tester,address=0x50,bus=/flexcomm0-i2c");
+    ret = g_test_run();
+    qtest_end();
+
+    return ret;
+}
diff --git a/tests/qtest/meson.build b/tests/qtest/meson.build
index 663e44f3c6..74fef28551 100644
--- a/tests/qtest/meson.build
+++ b/tests/qtest/meson.build
@@ -231,7 +231,7 @@ qtests_arm = \
   (config_all_devices.has_key('CONFIG_FSI_APB2OPB_ASPEED') ? ['aspeed_fsi-test'] : []) + \
   (config_all_devices.has_key('CONFIG_STM32L4X5_SOC') and
    config_all_devices.has_key('CONFIG_DM163')? ['dm163-test'] : []) + \
-  (config_all_devices.has_key('CONFIG_FLEXCOMM') ? ['flexcomm-test', 'flexcomm-usart-test'] : []) + \
+  (config_all_devices.has_key('CONFIG_FLEXCOMM') ? ['flexcomm-test', 'flexcomm-usart-test', 'flexcomm-i2c-test'] : []) + \
   ['arm-cpu-features',
    'boot-serial-test']
 
-- 
2.46.0.662.g92d0881bb0-goog


