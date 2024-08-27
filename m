Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3CB9CC5320E
	for <qemu-devel@archiver.kernel.org>; Tue, 27 Aug 2024 06:50:32 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sipyT-00056M-Ct; Tue, 27 Aug 2024 02:46:41 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from
 <3LnbNZgUKCo0ArCz6x55x2v.t537v3B-uvCv2454x4B.58x@flex--tavip.bounces.google.com>)
 id 1sipyN-0004fd-QL
 for qemu-devel@nongnu.org; Tue, 27 Aug 2024 02:46:35 -0400
Received: from mail-yb1-xb4a.google.com ([2607:f8b0:4864:20::b4a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from
 <3LnbNZgUKCo0ArCz6x55x2v.t537v3B-uvCv2454x4B.58x@flex--tavip.bounces.google.com>)
 id 1sipyJ-0006BC-Ar
 for qemu-devel@nongnu.org; Tue, 27 Aug 2024 02:46:35 -0400
Received: by mail-yb1-xb4a.google.com with SMTP id
 3f1490d57ef6-e165d8c8c28so7892470276.2
 for <qemu-devel@nongnu.org>; Mon, 26 Aug 2024 23:46:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=google.com; s=20230601; t=1724741167; x=1725345967; darn=nongnu.org;
 h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
 :date:from:to:cc:subject:date:message-id:reply-to;
 bh=0X5ajN0GlVBjzS6CMfRPYWSbMFYtloxhycByOvUYOGU=;
 b=jq5EI/oaS4i1T3OAR0vWf7DEZqpFY0WDruPGiOAqQECgkCobgOM3IL2BY0XosXIzGB
 zl72MZo97F0BkGhnXDHXlM3VhA4W1tf6pmx0/SRYuNSzIKV7+dzd8UnqNFRBcAt4dFqh
 IE8L2IyExq+XVFOzioMtobYKe9cd/mv6JOM3SlZXts/hd8lUJ3bKkEAx78bpl27hUjKZ
 NfkKieiBSm+hEUFWraKtKa1RkQgtE8fIcWNOf1jaVl6vwi7UkLl+GizO5egqShi3lJEw
 kt6/otsiUKdDisHbvRVgVXNRaqpm6iYrPA7Uxyo4YhcdjSnF9E/lQoYHOcjks5oGpYAF
 T9Gw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1724741167; x=1725345967;
 h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
 :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=0X5ajN0GlVBjzS6CMfRPYWSbMFYtloxhycByOvUYOGU=;
 b=sBwVz911Cx2+QkLiWYtzRAOSQQbHBUUiYkDOCI3HUhZitB1Skmer6yLZ7VqdsAgbdu
 wHgQH5w14nMvb3PXIAO48SqN7w29kfye7e+bMoWxNlRMhUtaQWYimpd5OwyiJBbeAwyI
 DkXZshUo0vNkWkepg01LRiiXZpnd0OPgsDmr73fhXpxXGrYjBQrywFOi34uokhhbB0dY
 +zfPA9p0pbihvD7VVfHc4934Vzr8mUmMpK0EZJ51LjrIHzBtkF15nAsrzrSSuNCyRyXm
 q0dK+uIajE/YXCYxaXGEKivNRUhTduwLSttawtKrDE9YWULCBJghvLUMJDo93ekWy8Ay
 0XUA==
X-Gm-Message-State: AOJu0YwuTe/dDhkV1MIp8X9VhwimcYBYoK0LtHTOjawclUSC85931VUL
 OggYNOPMMOQVP+NuFKk3LZ9QfE3BLm9FKARRIUQ97xbEIVR0jEvlxqgnrR2niHibtvTcgRk4X5Q
 7zJrht7gZnwNeK94clVJlH3jbFePVCWpuQReb5wCt6QxrFPxpQKMYPYptk140fjA5awtW5pGpM/
 O185LvoQ5qfzu9rAKSOGDBcby+zA==
X-Google-Smtp-Source: AGHT+IGSBf210H+/oALG2gNlPVjFSeLSSQNVebsLEcGsLKB21hhq/BeRXV86vC5dMK34bFIgI0GqQQNUXQ==
X-Received: from warp10.c.googlers.com ([fda3:e722:ac3:cc00:24:72f4:c0a8:750])
 (user=tavip job=sendgmr) by 2002:a5b:dc5:0:b0:e11:6d5f:79b3 with
 SMTP id
 3f1490d57ef6-e17a83cdb5dmr215584276.4.1724741166685; Mon, 26 Aug 2024
 23:46:06 -0700 (PDT)
Date: Mon, 26 Aug 2024 23:45:23 -0700
In-Reply-To: <20240827064529.1246786-1-tavip@google.com>
Mime-Version: 1.0
References: <20240827064529.1246786-1-tavip@google.com>
X-Mailer: git-send-email 2.46.0.295.g3b9ea8a38a-goog
Message-ID: <20240827064529.1246786-20-tavip@google.com>
Subject: [RFC PATCH v3 19/24] tests/qtest: add tests for flexcomm i2c
From: Octavian Purdila <tavip@google.com>
To: qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org, stefanst@google.com, pbonzini@redhat.com, 
 peter.maydell@linaro.org, marcandre.lureau@redhat.com, berrange@redhat.com, 
 eduardo@habkost.net, luc@lmichel.fr, damien.hedde@dahe.fr, 
 alistair@alistair23.me, thuth@redhat.com, philmd@linaro.org, jsnow@redhat.com, 
 crosa@redhat.com, lvivier@redhat.com
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::b4a;
 envelope-from=3LnbNZgUKCo0ArCz6x55x2v.t537v3B-uvCv2454x4B.58x@flex--tavip.bounces.google.com;
 helo=mail-yb1-xb4a.google.com
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

Add master mode tests for flexcomm i2c.

Signed-off-by: Octavian Purdila <tavip@google.com>
---
 tests/qtest/flexcomm-i2c-test.c | 169 ++++++++++++++++++++++++++++++++
 tests/qtest/meson.build         |   2 +-
 2 files changed, 170 insertions(+), 1 deletion(-)
 create mode 100644 tests/qtest/flexcomm-i2c-test.c

diff --git a/tests/qtest/flexcomm-i2c-test.c b/tests/qtest/flexcomm-i2c-test.c
new file mode 100644
index 0000000000..30ab40e132
--- /dev/null
+++ b/tests/qtest/flexcomm-i2c-test.c
@@ -0,0 +1,169 @@
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
+                          "-device i2c-tester,address=0x50,bus=/flexcomm0/i2c");
+    ret = g_test_run();
+    qtest_end();
+
+    return ret;
+}
diff --git a/tests/qtest/meson.build b/tests/qtest/meson.build
index 93d1f781bc..df69c1cfbf 100644
--- a/tests/qtest/meson.build
+++ b/tests/qtest/meson.build
@@ -229,7 +229,7 @@ qtests_arm = \
   (config_all_devices.has_key('CONFIG_FSI_APB2OPB_ASPEED') ? ['aspeed_fsi-test'] : []) + \
   (config_all_devices.has_key('CONFIG_STM32L4X5_SOC') and
    config_all_devices.has_key('CONFIG_DM163')? ['dm163-test'] : []) + \
-  (config_all_devices.has_key('CONFIG_FLEXCOMM') ? ['flexcomm-test', 'flexcomm-usart-test'] : []) + \
+  (config_all_devices.has_key('CONFIG_FLEXCOMM') ? ['flexcomm-test', 'flexcomm-usart-test', 'flexcomm-i2c-test'] : []) + \
   ['arm-cpu-features',
    'boot-serial-test']
 
-- 
2.46.0.295.g3b9ea8a38a-goog


