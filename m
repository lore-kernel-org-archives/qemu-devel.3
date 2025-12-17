Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 21E3FD64061
	for <qemu-devel@archiver.kernel.org>; Wed, 17 Dec 2025 00:23:35 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vVfJN-0006FE-LU; Tue, 16 Dec 2025 19:22:37 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from
 <3x_dBaQYKChAEAry3Fw44w1u.s426u2A-tuBu1343w3A.47w@flex--yubinz.bounces.google.com>)
 id 1vVfJM-0006Bb-0l
 for qemu-devel@nongnu.org; Tue, 16 Dec 2025 19:22:36 -0500
Received: from mail-pg1-x549.google.com ([2607:f8b0:4864:20::549])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from
 <3x_dBaQYKChAEAry3Fw44w1u.s426u2A-tuBu1343w3A.47w@flex--yubinz.bounces.google.com>)
 id 1vVfJJ-00057U-UW
 for qemu-devel@nongnu.org; Tue, 16 Dec 2025 19:22:35 -0500
Received: by mail-pg1-x549.google.com with SMTP id
 41be03b00d2f7-be8c77ecc63so7900259a12.2
 for <qemu-devel@nongnu.org>; Tue, 16 Dec 2025 16:22:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=google.com; s=20230601; t=1765930952; x=1766535752; darn=nongnu.org;
 h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
 :date:from:to:cc:subject:date:message-id:reply-to;
 bh=wtQWpzqrkzhQ62X+JBS6XXEpmyy4naPMlbQEjR9jrn0=;
 b=gsiLeqAZl6ZmlGabVDI/gybhQOpx4IL5Tut2mNRhYfUDpJOtgoL6victEVZ1q7Yi82
 jXHp8QRMobFO8udI5TlhbVSNJSXe54EAib9loIisS3RDutQ5lwUHdlxcXkCw8Zb5e0TT
 mOdgE3tVViFWaX/NGlPsSBmLlUeexf60LkUIfJfaiErpb+JLsWl1UIl1AcNFkLHs5DWy
 B461bIcCtHSH1IPMZ0QTbedVAMA2ictm6pntqMpA+uNsEH094fMfYNQ/dZPGgQlhlS0x
 tuQJlNlTbvwTkm8EW7EDamYp9IbAZozXNkIl/1Kz4w21iPis1ITu0k3N8dg93IotUf7u
 1qhA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1765930952; x=1766535752;
 h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
 :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=wtQWpzqrkzhQ62X+JBS6XXEpmyy4naPMlbQEjR9jrn0=;
 b=DI5vUZzxJHwlBfFM6yE8LSVfG9FYo2C92lCslGxTrAQwTWD6IDsgD4WFdOAcL8iyqA
 TaNJe6JdsDPEePbBe4HoQUw2R40hRBVd+8+NmLxxNhg9Ks442FXhBP+pocDsq9YuD9U2
 WzLZuIBsPAwbYX9VZRaPKiBywcdCmDNz3InHYjhug2+X6s8WeCtzgty4N1/wyNsk9m1W
 c1FYFA8iygiN+5LPazRDdYHq9Z3rDkT/h67J2ykNgbqVtxnsG0m+WGsUv7wlRpmNqgdu
 NxiEv9eoGbhwMYKYtZiTvM6Ev20G7H1Lhe7sQEaF7PWnIFhWTTmBvOnh7yBERpbZ7aau
 R6Hg==
X-Gm-Message-State: AOJu0Yyz55q05qrFBJGC24l9N478lNIjPVQRRkrMOeXTAaeChZrGuHmz
 rPQeEaOklnVf9vbUg22q0KS0d9pyIq5ia3FVAuzdYSJ9HAJc1gzdzJs0CtFdV4pR6G02FGfbN5G
 pSY76bl0Ff00gPm5vGQJ6NlHI/WDO9Qc8Yhu5gHmltDGZ1pj0YW8UyID4Nb72oEsfhuW7uE6cLm
 UBHDk5CSA2F402aMn9h2RNhSLPF4T/yMLIpHU=
X-Google-Smtp-Source: AGHT+IEG8k0gCHTMNfEWpaLqJ0elZtTAghdcAuWHvpsKErFfzwRLNTcp5x//myYMQ+oPQCtHpXiSVfpwW/0=
X-Received: from dlbcm18.prod.google.com ([2002:a05:7022:6892:b0:11f:3fcf:58c])
 (user=yubinz job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:7022:3a8e:b0:11a:44d1:533a
 with SMTP id a92af1059eb24-11f349c54ddmr12856072c88.12.1765930951993; Tue, 16
 Dec 2025 16:22:31 -0800 (PST)
Date: Wed, 17 Dec 2025 00:22:16 +0000
In-Reply-To: <20251217-aspeed-sgpio-v4-0-28bbb8dcab30@google.com>
Mime-Version: 1.0
References: <20251217-aspeed-sgpio-v4-0-28bbb8dcab30@google.com>
X-Mailer: b4 0.14.2
Message-ID: <20251217-aspeed-sgpio-v4-6-28bbb8dcab30@google.com>
Subject: [PATCH v4 6/6] test/qtest: Add Unit test for Aspeed SGPIO
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
 envelope-from=3x_dBaQYKChAEAry3Fw44w1u.s426u2A-tuBu1343w3A.47w@flex--yubinz.bounces.google.com;
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
 tests/qtest/ast2700-sgpio-test.c | 166 +++++++++++++++++++++++++++++++++++++++
 tests/qtest/meson.build          |   1 +
 2 files changed, 167 insertions(+)

diff --git a/tests/qtest/ast2700-sgpio-test.c b/tests/qtest/ast2700-sgpio-test.c
new file mode 100644
index 0000000000000000000000000000000000000000..6d024524a32717560301f73ee1c7132f4181e711
--- /dev/null
+++ b/tests/qtest/ast2700-sgpio-test.c
@@ -0,0 +1,166 @@
+/*
+ * QTest testcase for the ASPEED AST2700 SGPIO Controller.
+ *
+ * SPDX-License-Identifier: GPL-2.0-or-later
+ * Copyright (C) 2025 Google LLC.
+ */
+
+#include "qemu/osdep.h"
+#include "qemu/bitops.h"
+#include "qobject/qdict.h"
+#include "libqtest-single.h"
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
+        sprintf(name, "sgpio%03d", i * 2 + 1);
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
+        sprintf(name, "sgpio%03d", i * 2);
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
+        sprintf(name, "sgpio%03d", i * 2);
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
+static void test_ast_2700_sgpio_input(void)
+{
+    test_input_pins("-machine ast2700-evb",
+                    AST2700_SGPIO0_BASE, 0);
+    test_input_pins("-machine ast2700-evb",
+                    AST2700_SGPIO1_BASE, 1);
+}
+
+static void test_ast_2700_sgpio_output(void)
+{
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
+static void test_ast_2700_sgpio_irq(void)
+{
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
+    qtest_add_func("/ast2700/sgpio/ast_2700_sgpio_input",
+                   test_ast_2700_sgpio_input);
+    qtest_add_func("/ast2700/sgpio/ast_2700_sgpio_output",
+                   test_ast_2700_sgpio_output);
+    qtest_add_func("/ast2700/sgpio/ast_2700_sgpio_irq",
+                   test_ast_2700_sgpio_irq);
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
2.52.0.305.g3fc767764a-goog


