Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B5C4AD3B7E2
	for <qemu-devel@archiver.kernel.org>; Tue,  9 Dec 2025 00:02:44 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vSlBD-0007Nf-NQ; Mon, 08 Dec 2025 19:02:13 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from
 <38mY3aQYKCu0njQXcoVddVaT.RdbfTbj-STkTacdcVcj.dgV@flex--yubinz.bounces.google.com>)
 id 1vSlB1-0007HD-BJ
 for qemu-devel@nongnu.org; Mon, 08 Dec 2025 19:01:59 -0500
Received: from mail-pg1-x549.google.com ([2607:f8b0:4864:20::549])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from
 <38mY3aQYKCu0njQXcoVddVaT.RdbfTbj-STkTacdcVcj.dgV@flex--yubinz.bounces.google.com>)
 id 1vSlAz-0007Tf-GV
 for qemu-devel@nongnu.org; Mon, 08 Dec 2025 19:01:59 -0500
Received: by mail-pg1-x549.google.com with SMTP id
 41be03b00d2f7-bddf9ce4931so8715847a12.0
 for <qemu-devel@nongnu.org>; Mon, 08 Dec 2025 16:01:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=google.com; s=20230601; t=1765238515; x=1765843315; darn=nongnu.org;
 h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
 :date:from:to:cc:subject:date:message-id:reply-to;
 bh=bSakU68MOAqefQEVfQ70zw66AH6C0ci0Aetl72eSIF0=;
 b=preq52qJEpKzkWQBgPDZWi0x0BA/cXkWmc1spTvXESZkT1+9ZsOCjJk+gU675oAmkP
 MaEzozKwZ5+Ib42bDqhUTcNu9XlBAczr0Sb5duMbMFhS6aNHPK8eynpz4YjPRhPaJpv8
 Fi3xAOIkim1oEA8NLoqnxhCeuENof2Cn9k5kfmCQMbSEA8Xa5gJRaaxX4niwy3cx5Pax
 8yJ7pncl8bNuqgezRyQ85vBlCaVDJdHAmXIKNk2+JSieNp9Dt/YWZ8mi18IeguX7YhvM
 b73i+GEyilXa5N9/t1pCRXFOTV1ixFRGiPVoQtKs41YrH2kh30UTbAt/6oO/lpB132+u
 S6Fg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1765238515; x=1765843315;
 h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
 :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=bSakU68MOAqefQEVfQ70zw66AH6C0ci0Aetl72eSIF0=;
 b=CkcJ8mpcSSvhKdGKGlfDdJy1klNwcPa+0swXnQ4xeB45KUxER+ya2Oo3SikfJyeK06
 tIp4BUnAR4oK4FGvzsZ6VI4vxAlguw/icu1Dolfr5m1u4g3GkILaw/TEWjscXLCGLtWs
 Rylz5BwNATnmowQI5Uux+6X+/TBCLKEYzv85f/jiSDJBYPhhZPeE57dtxnISkNZ+Qrd5
 8M5ZQBpsCfIJNYFqAFOh8Zb6QK9pekP8p1uE7a2tC0NpikmMeFjL/aZSj+3yG9sXTdl1
 lv/GLckKoAUzVZERzsmbg6hKftMvnQkLZ8hM5CH83uZr1ieIdvgsDSa1bL0mNyVi7fZb
 0QZg==
X-Gm-Message-State: AOJu0YwPLRMcZOtBujFNzqzFMm0+CzAulOjuY95cDKloaTIbE9FMCrHa
 /OjEPgLMPxF/gy6V2B4XkcVeQFwW+tWPSMN6sxEbAtkonPWf1r8XnXcQgvSklRZ2D19gR/OGbgv
 rUQDN7n14pQ59rAYjBDPkGpgqPIQuyeoLgqJTNqA0mkLxmYWzqsOClaAp54XBUQxml5ssZi/Z+0
 LN6ag9at9/QzDuNUZ9Ays1Twfz6R25NcMWI1w=
X-Google-Smtp-Source: AGHT+IGcEWK2DdmZDYWJ9PxoE2Ys63+L/6KxbVLv8vENRgQEEbRnGZTn+n7vejWygrn/OSNwjxq3hrqtqZc=
X-Received: from dycai1.prod.google.com ([2002:a05:7300:fb01:b0:2a4:63df:76a5])
 (user=yubinz job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:7301:dd83:b0:2a4:63fb:c144
 with SMTP id 5a478bee46e88-2abc7156465mr3649381eec.16.1765238514935; Mon, 08
 Dec 2025 16:01:54 -0800 (PST)
Date: Tue, 09 Dec 2025 00:01:38 +0000
In-Reply-To: <20251209-aspeed-sgpio-v2-0-976e5f5790c2@google.com>
Mime-Version: 1.0
References: <20251209-aspeed-sgpio-v2-0-976e5f5790c2@google.com>
X-Mailer: b4 0.14.2
Message-ID: <20251209-aspeed-sgpio-v2-6-976e5f5790c2@google.com>
Subject: [PATCH v2 6/6] test/qtest: Add Unit test for Aspeed SGPIO
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
 envelope-from=38mY3aQYKCu0njQXcoVddVaT.RdbfTbj-STkTacdcVcj.dgV@flex--yubinz.bounces.google.com;
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
2.52.0.223.gf5cc29aaa4-goog


