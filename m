Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 70E95D3C932
	for <qemu-devel@archiver.kernel.org>; Wed, 10 Dec 2025 23:30:34 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vTTd7-0004Cv-OU; Wed, 10 Dec 2025 18:29:57 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from
 <3aAI6aQYKCqUdZGNSeLTTLQJ.HTRVJRZ-IJaJQSTSLSZ.TWL@flex--yubinz.bounces.google.com>)
 id 1vTTd0-0004AG-Pz
 for qemu-devel@nongnu.org; Wed, 10 Dec 2025 18:29:50 -0500
Received: from mail-pg1-x549.google.com ([2607:f8b0:4864:20::549])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from
 <3aAI6aQYKCqUdZGNSeLTTLQJ.HTRVJRZ-IJaJQSTSLSZ.TWL@flex--yubinz.bounces.google.com>)
 id 1vTTcy-0005jL-Da
 for qemu-devel@nongnu.org; Wed, 10 Dec 2025 18:29:49 -0500
Received: by mail-pg1-x549.google.com with SMTP id
 41be03b00d2f7-b471737e673so372613a12.1
 for <qemu-devel@nongnu.org>; Wed, 10 Dec 2025 15:29:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=google.com; s=20230601; t=1765409384; x=1766014184; darn=nongnu.org;
 h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
 :date:from:to:cc:subject:date:message-id:reply-to;
 bh=V/p7p5kZiMeVzqeCpGXZV3o/BNSDBxLa3oyslXCE1Sk=;
 b=f9hUcmNvCVDVI4969Bfa6rt1jhb+81inln16CRKyFHJ5NJfh1BBoXvLT8P2vd+Uo1J
 mTa/oxyeoS7HKxp70iFM3vHb8hggXGywZmsVK2TX65Y3a+jbEjrL/b+YxxWwqow7kknl
 GV1gPpoWodVH/bmog7KhQpPombRMSfIiZAI8eOdZe8ZEsE0NuCBDskdNWEM6cvedwTUy
 SYwJ7pqRwM0AZxoGO43eGdv+l3JeaoNeAEgADSEoZQ4q7rRthUO9Ms4lXmtuBDPjI5zL
 SmpANUjiPZF+pwdKkLnPF5RC7aexADWAwGjOmCSFy/JPBwZlD6ppGEcoJQLmSvo4a3qj
 r41g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1765409384; x=1766014184;
 h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
 :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=V/p7p5kZiMeVzqeCpGXZV3o/BNSDBxLa3oyslXCE1Sk=;
 b=wcPA9CZBrD5FchKDj7P7AmNYQOjJ4GhGTrNKePa6OjPw4VOgPuYG+RowwkPf9mtirx
 VxEgTCTAgtF3MhK0VlA6KxNryS/acKqs/pE3SX/ANbOcJUJ9vaelwHD6HUtq2JmMZ7kL
 T/4lhm3TNqJdgFZWlA2E92tNLz41oKg5ij6hmnTPyPFIphggSOVEukjvBoBk7BI3OBC0
 uDiTcLYWvu0pbjgKgxedsLio4sl+nQ+/qnpt7MGC0hj+c5hRT/f4lQOP6U5CU/13R4L6
 qGu9hsosq6V+Asv1yGIMFVakW7DDepESwI9e8dGn4uYq3sIL+wHCkoFZ+yXU6vRn0sob
 QlWg==
X-Gm-Message-State: AOJu0YwoMvVnRnrDIhQhuvd0a5PmEeZWMk4S8Y4HWG3ZAY2TUUE02FQY
 veF7MHjbOD2Cd/eO2mC6oTHwq3PJLv2EqQTlSXkkqClAnf1biwC1bCrUoBD/jR7BulaoU1tbQI5
 nmXljMRUyozR9l4KrHXLxk1jcBaNq2a7a/LjNddRi6gkW5xY3T77mQNtJ5vvpgK2psMA/HzvOw5
 p79f0phVBtphEba9u24OiLT5xmW4c7/6DZdd8=
X-Google-Smtp-Source: AGHT+IFnH1Uj5Zp6ckTavj8XiQlSDJn8c8GXpiFB4Kilp7a2eKpL0MER75YlbhZzBEKq2HvudOppQknKwWg=
X-Received: from dlbrb20.prod.google.com
 ([2002:a05:7022:f014:b0:11b:a892:80ac])
 (user=yubinz job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:7022:e21:b0:119:e569:f615
 with SMTP id a92af1059eb24-11f2963f1bamr3036459c88.14.1765409384218; Wed, 10
 Dec 2025 15:29:44 -0800 (PST)
Date: Wed, 10 Dec 2025 23:29:17 +0000
In-Reply-To: <20251210-aspeed-sgpio-v3-0-eb8b0cf3dd51@google.com>
Mime-Version: 1.0
References: <20251210-aspeed-sgpio-v3-0-eb8b0cf3dd51@google.com>
X-Mailer: b4 0.14.2
Message-ID: <20251210-aspeed-sgpio-v3-6-eb8b0cf3dd51@google.com>
Subject: [PATCH v3 6/6] test/qtest: Add Unit test for Aspeed SGPIO
From: Yubin Zou <yubinz@google.com>
To: qemu-devel@nongnu.org
Cc: "=?utf-8?q?C=C3=A9dric_Le_Goater?=" <clg@kaod.org>,
 Peter Maydell <peter.maydell@linaro.org>, 
 Steven Lee <steven_lee@aspeedtech.com>, Troy Lee <leetroy@gmail.com>, 
 Jamin Lin <jamin_lin@aspeedtech.com>,
 Andrew Jeffery <andrew@codeconstruct.com.au>, 
 Joel Stanley <joel@jms.id.au>, Fabiano Rosas <farosas@suse.de>,
 Laurent Vivier <lvivier@redhat.com>, 
 Paolo Bonzini <pbonzini@redhat.com>, Kane-Chen-AS <kane_chen@aspeedtech.com>, 
 Nabih Estefan <nabihestefan@google.com>, qemu-arm@nongnu.org, 
 Yubin Zou <yubinz@google.com>
Content-Type: text/plain; charset="utf-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::549;
 envelope-from=3aAI6aQYKCqUdZGNSeLTTLQJ.HTRVJRZ-IJaJQSTSLSZ.TWL@flex--yubinz.bounces.google.com;
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

This commit introduces a new qtest for the Aspeed SGPIO controller
The test covers the following:
  - Setting and clearing SGPIO output pins and verifying the pin state.
  - Setting and clearing SGPIO input pins and verifying the pin state.
  - Verifying that level-high interrupts are correctly triggered and cleared.

Signed-off-by: Yubin Zou <yubinz@google.com>
---
 tests/qtest/ast2700-sgpio-test.c | 152 +++++++++++++++++++++++++++++++++++++++
 tests/qtest/meson.build          |   1 +
 2 files changed, 153 insertions(+)

diff --git a/tests/qtest/ast2700-sgpio-test.c b/tests/qtest/ast2700-sgpio-test.c
new file mode 100644
index 0000000000000000000000000000000000000000..fc52839c4b149a3010c6a035d8b29f9ad295930a
--- /dev/null
+++ b/tests/qtest/ast2700-sgpio-test.c
@@ -0,0 +1,152 @@
+/*
+ * QTest testcase for the ASPEED AST2700 GPIO Controller.
+ *
+ * SPDX-License-Identifier: GPL-2.0-or-later
+ * Copyright (C) 2025 Google LLC.
+ */
+
+#include "qemu/osdep.h"
+#include "qobject/qdict.h"
+#include "qemu/bitops.h"
+#include "qemu/timer.h"
+#include "qobject/qdict.h"
+#include "libqtest-single.h"
+#include "qemu/error-report.h"
+#include "hw/registerfields.h"
+#include "hw/gpio/aspeed_sgpio.h"
+
+#define ASPEED_SGPIO_MAX_PIN_PAIR 256
+#define AST2700_SGPIO0_BASE 0x14C0C000
+#define AST2700_SGPIO1_BASE 0x14C0D000
+
+static void test_output_pins(const char *machine, const uint32_t base, int idx)
+{
+    QTestState *s = qtest_init(machine);
+    char name[16];
+    char qom_path[64];
+    uint32_t offset = 0;
+    uint32_t value = 0;
+    for (int i = 0; i < ASPEED_SGPIO_MAX_PIN_PAIR; i++) {
+        /* Odd index is output port */
+        sprintf(name, "sgpio%d", i * 2 + 1);
+        sprintf(qom_path, "/machine/soc/sgpio[%d]", idx);
+        offset = base + (R_SGPIO_0_CONTROL + i) * 4;
+        /* set serial output */
+        qtest_writel(s, offset, 0x00000001);
+        value = qtest_readl(s, offset);
+        g_assert_cmphex(SHARED_FIELD_EX32(value, SGPIO_SERIAL_OUT_VAL), ==, 1);
+        g_assert_cmphex(qtest_qom_get_bool(s, qom_path, name), ==, true);
+
+        /* clear serial output */
+        qtest_writel(s, offset, 0x00000000);
+        value = qtest_readl(s, offset);
+        g_assert_cmphex(SHARED_FIELD_EX32(value, SGPIO_SERIAL_OUT_VAL), ==, 0);
+        g_assert_cmphex(qtest_qom_get_bool(s, qom_path, name), ==, false);
+    }
+    qtest_quit(s);
+}
+
+static void test_input_pins(const char *machine, const uint32_t base, int idx)
+{
+    QTestState *s = qtest_init(machine);
+    char name[16];
+    char qom_path[64];
+    uint32_t offset = 0;
+    uint32_t value = 0;
+    for (int i = 0; i < ASPEED_SGPIO_MAX_PIN_PAIR; i++) {
+        /* Even index is input port */
+        sprintf(name, "sgpio%d", i * 2);
+        sprintf(qom_path, "/machine/soc/sgpio[%d]", idx);
+        offset = base + (R_SGPIO_0_CONTROL + i) * 4;
+        /* set serial input */
+        qtest_qom_set_bool(s, qom_path, name, true);
+        value = qtest_readl(s, offset);
+        g_assert_cmphex(SHARED_FIELD_EX32(value, SGPIO_SERIAL_IN_VAL), ==, 1);
+        g_assert_cmphex(qtest_qom_get_bool(s, qom_path, name), ==, true);
+
+        /* clear serial input */
+        qtest_qom_set_bool(s, qom_path, name, false);
+        value = qtest_readl(s, offset);
+        g_assert_cmphex(SHARED_FIELD_EX32(value, SGPIO_SERIAL_IN_VAL), ==, 0);
+        g_assert_cmphex(qtest_qom_get_bool(s, qom_path, name), ==, false);
+    }
+    qtest_quit(s);
+}
+
+static void test_irq_level_high(const char *machine,
+                                const uint32_t base, int idx)
+{
+    QTestState *s = qtest_init(machine);
+    char name[16];
+    char qom_path[64];
+    uint32_t ctrl_offset = 0;
+    uint32_t int_offset = 0;
+    uint32_t int_reg_idx = 0;
+    uint32_t int_bit_idx = 0;
+    uint32_t value = 0;
+    for (int i = 0; i < ASPEED_SGPIO_MAX_PIN_PAIR; i++) {
+        /* Even index is input port */
+        sprintf(name, "sgpio%d", i * 2);
+        sprintf(qom_path, "/machine/soc/sgpio[%d]", idx);
+        int_reg_idx = i / 32;
+        int_bit_idx = i % 32;
+        int_offset = base + (R_SGPIO_INT_STATUS_0 + int_reg_idx) * 4;
+        ctrl_offset = base + (R_SGPIO_0_CONTROL + i) * 4;
+
+        /* Enable the interrupt */
+        value = SHARED_FIELD_DP32(value, SGPIO_INT_EN, 1);
+        qtest_writel(s, ctrl_offset, value);
+
+        /* Set the interrupt type to level-high trigger */
+        value = SHARED_FIELD_DP32(qtest_readl(s, ctrl_offset),
+                                              SGPIO_INT_TYPE, 3);
+        qtest_writel(s, ctrl_offset, value);
+
+        /* Set serial input high */
+        qtest_qom_set_bool(s, qom_path, name, true);
+        value = qtest_readl(s, ctrl_offset);
+        g_assert_cmphex(SHARED_FIELD_EX32(value, SGPIO_SERIAL_IN_VAL), ==, 1);
+
+        /* Interrupt status is set */
+        value = qtest_readl(s, int_offset);
+        g_assert_cmphex(extract32(value, int_bit_idx, 1), ==, 1);
+
+        /* Clear Interrupt */
+        value = SHARED_FIELD_DP32(qtest_readl(s, ctrl_offset),
+                                              SGPIO_INT_STATUS, 1);
+        qtest_writel(s, ctrl_offset, value);
+        value = qtest_readl(s, int_offset);
+        g_assert_cmphex(extract32(value, int_bit_idx, 1), ==, 0);
+
+        /* Clear serial input */
+        qtest_qom_set_bool(s, qom_path, name, false);
+        value = qtest_readl(s, ctrl_offset);
+        g_assert_cmphex(SHARED_FIELD_EX32(value, SGPIO_SERIAL_IN_VAL), ==, 0);
+    }
+    qtest_quit(s);
+}
+
+static void test_2700_input_pins(void)
+{
+    test_input_pins("-machine ast2700-evb",
+                    AST2700_SGPIO0_BASE, 0);
+    test_input_pins("-machine ast2700-evb",
+                    AST2700_SGPIO1_BASE, 1);
+    test_output_pins("-machine ast2700-evb",
+                    AST2700_SGPIO0_BASE, 0);
+    test_output_pins("-machine ast2700-evb",
+                    AST2700_SGPIO1_BASE, 1);
+    test_irq_level_high("-machine ast2700-evb",
+                    AST2700_SGPIO0_BASE, 0);
+    test_irq_level_high("-machine ast2700-evb",
+                    AST2700_SGPIO1_BASE, 1);
+}
+
+int main(int argc, char **argv)
+{
+    g_test_init(&argc, &argv, NULL);
+
+    qtest_add_func("/ast2700/sgpio/input_pins", test_2700_input_pins);
+
+    return g_test_run();
+}
diff --git a/tests/qtest/meson.build b/tests/qtest/meson.build
index 669d07c06bdedc6be0c69acadeba989dc15ddf3f..5c80b2ed6de1f453d2483db482c1b0e7801ba980 100644
--- a/tests/qtest/meson.build
+++ b/tests/qtest/meson.build
@@ -221,6 +221,7 @@ qtests_aspeed = \
 qtests_aspeed64 = \
   ['ast2700-gpio-test',
    'ast2700-hace-test',
+   'ast2700-sgpio-test',
    'ast2700-smc-test']
 
 qtests_stm32l4x5 = \

-- 
2.52.0.239.gd5f0c6e74e-goog


