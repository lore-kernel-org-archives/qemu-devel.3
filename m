Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 987EBC55174
	for <qemu-devel@archiver.kernel.org>; Wed,  5 Aug 2026 15:16:54 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wrdLf-0000Mq-Eb; Wed, 05 Aug 2026 11:16:03 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <guochun.wang@foxmail.com>)
 id 1wrdLI-0008Ur-RV
 for qemu-devel@nongnu.org; Wed, 05 Aug 2026 11:15:50 -0400
Received: from out203-205-221-233.mail.qq.com ([203.205.221.233])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <guochun.wang@foxmail.com>)
 id 1wrdLD-00049Q-52
 for qemu-devel@nongnu.org; Wed, 05 Aug 2026 11:15:40 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foxmail.com;
 s=s201512; t=1785942926;
 bh=5SUb3HnpYt+fgz0Gh/OU9ChJPgFqIyziZs2+p2PmoZM=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References;
 b=YtA9M5MSwigUkjVt40RkKhasWRde5pIa/WFbCIP5+81dP6lOj+6W72P6psrEsTQyO
 R9k0LUuoF8wAWT5PsBLcikOXU4kAKK8N3q2BY5sS9Xo1yh6CP5IyaAsysYuIjInOQ8
 ZDzsDL3rYtrOOEzGqffuftVgG4LA0EZ8zinahSkU=
Received: from DESKTOP-8MIQOKD.localdomain ([117.13.168.66])
 by newxmesmtplogicsvrsza63-0.qq.com (NewEsmtp) with SMTP
 id 3D43DC51; Wed, 05 Aug 2026 23:15:20 +0800
X-QQ-mid: xmsmtpt1785942923tk2fy9oxn
Message-ID: <tencent_76E410D79348037AB2CC88758B8A5B932907@qq.com>
X-QQ-XMAILINFO: NhmQchj2HcYZwVBc5ZzXL0Q9BbmLSzzazBpT2GdeLCts9WAsSN22cldnqZFm+a
 BFCFm/nssuBU7grDXg86REyJj3p9HWhcB62KLZCShzxNuYPxN7yj3pVWnl/6yMxSo8bqyTXH5lpF
 fqAepLkzSnqB4ilPKz2QEbHrJd0p9TKC4lxZ8RutyxkwdaIYJi1340louapAkC7YCupiuJYFh28x
 JNt2W4gptCw7LuopJOBNcLN7DOCHoOiofYoikkbPmsYX3U2PutEJqQ/KaN0U1Asf4jsj2AMBiP82
 hFXt+6px4p6HNwINisQv+KkVeY7/YIma7BNYvQnnEa1VTd4542WNX/R69KAxgXFJu/beOUoWBDlf
 m+8CODztdHCeAEIGsq7BJTTbatcsofwpQnxx8W4vagvRQUC89XdSX3yz7Oisu+9RuPtR4wDCCRe0
 1YQz8To+8zNIs+q9gAko64+CGjvYc0oS0tfyd6U2o+op740jjzRHp6yL4qRq6U0wrZJ/l72X64s5
 IP2kqO+Xa4D9Q8muUE8Uv8/2L/5jITCl54OPNqMaEi3LAn86bKY/3XmMpC4m13r3iv28ncDMQw99
 PIjMMc9v9fjaC7xQ8VR1n2aldQ0SzMOTBKG/4+eDGVG7kddWYTVRLgtQ9Rg1PFUNWltaa+KgejKj
 O7Tq/wU5aEifUlfJEN4EoEG7yF27J8uYl2PpWLmU5T9SToWaNSztGEv2lkpkotjsNfOhYuI3UCUN
 GyFR1A8SmGQEuEBE5IJOJogLbHk3IbjpIf96kr1elRP83aYush0uX90bAUD9jvL61DYrzRxiwLjb
 GqRut8MR2xFYGYnjdQjc/I9KGJcwwf9L//tjTDE5fIxzcCxxuw+U+mtTVzfIOy/EmdgDL81AdE2O
 i9iNwzV4nHluhKq8SJZdztBaTWNuJdPow6ayjIFTu1j6qRBopfbuvpTZV4OnJZNbO17XRTLQ2CCk
 kfYdX094aK56xM+qpLhEmbSO5Mnn1xaywtlgj0gVLNpNhvndA2dBZf8dSwTVvXdek0hBOUypTLcv
 poU6+uzLnCvPoqqupe0mftywhLdeHl1lh4vVoB6dbKOqQFtbllQAuGjJ2yVU18c9DOOM5LfHnaYf
 wN1hJ7dSZVds2kyE05HSU9vTMVMlY3vnruJBCcnfRzFshwIwat5J1x+aVjZnFk9OH4S5aeQinC1B
 vUjwjpwa8fAHnQX+eleljZOIyuMsw2/m3txb7xmL4izMeYDg==
X-QQ-XMRINFO: MPJ6Tf5t3I/ylTmHUqvI8+Wpn+Gzalws3A==
From: guochun.wang@foxmail.com
To: qemu-devel@nongnu.org
Cc: chao.liu@processmission.com, palmer@dabbelt.com, alistair.francis@wdc.com,
 liwei1518@gmail.com, daniel.barboza@oss.qualcomm.com,
 zhiwei_liu@linux.alibaba.com, pbonzini@redhat.com, farosas@suse.de,
 lvivier@redhat.com, qemu-riscv@nongnu.org,
 guochun wang <guochun.wang@foxmail.com>
Subject: [PATCH v2 2/2] tests/qtest: add K230 GPIO controller test
Date: Wed,  5 Aug 2026 23:14:55 +0800
X-OQ-MSGID: <20260805151455.99076-3-guochun.wang@foxmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260805151455.99076-1-guochun.wang@foxmail.com>
References: <20260805151455.99076-1-guochun.wang@foxmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=203.205.221.233;
 envelope-from=guochun.wang@foxmail.com; helo=out203-205-221-233.mail.qq.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 HELO_STATIC_HOST=-0.001, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001,
 RCVD_IN_MSPIKE_WL=0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

From: guochun wang <guochun.wang@foxmail.com>

Add qtest cases verifying the K230 GPIO model against TRM v0.3.1
behaviour and Linux gpio-k230 driver requirements.

Tests cover:
  - Reset values: all registers cleared after machine init
  - Edge detection: rising / falling / both-edge, with EOI clearing
  - Level-sensitive: active-high / active-low, cleared by source removal
  - EOI: clears edge interrupts only, raw status verified
  - INTEN gating and INTMASK masking (raw status still recorded)
  - No new interrupts while DDR=output or CTL=hardware mode
  - PLIC integration: per-pin IRQ, claim/complete flow
  - Multiple simultaneous interrupts on independent lines
  - GPIO1 controller (second instance at 0x9140C000)
  - DDR/CTL mode switching: pending interrupts preserved; on switch
    back to input/software mode, level interrupts re-evaluated against
    current ext level, edge interrupts left untouched (TRM v0.3.1)

Update MAINTAINERS with the new test file.

Signed-off-by: guochun wang <guochun.wang@foxmail.com>
---
 MAINTAINERS                  |   1 +
 tests/qtest/k230-gpio-test.c | 521 +++++++++++++++++++++++++++++++++++
 tests/qtest/meson.build      |   2 +-
 3 files changed, 523 insertions(+), 1 deletion(-)
 create mode 100644 tests/qtest/k230-gpio-test.c

diff --git a/MAINTAINERS b/MAINTAINERS
index 4301d29f7e..bb4f585426 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -1834,6 +1834,7 @@ F: include/hw/gpio/k230_gpio.h
 F: include/hw/riscv/k230.h
 F: include/hw/watchdog/k230_wdt.h
 F: tests/functional/riscv64/test_k230.py
+F: tests/qtest/k230-gpio-test.c
 F: tests/qtest/k230-wdt-test.c
 
 RX Machines
diff --git a/tests/qtest/k230-gpio-test.c b/tests/qtest/k230-gpio-test.c
new file mode 100644
index 0000000000..9c930cbd1c
--- /dev/null
+++ b/tests/qtest/k230-gpio-test.c
@@ -0,0 +1,521 @@
+/*
+ * QTest testcase for K230 GPIO
+ *
+ * Copyright (c) 2025 Wang Guochun <wdasn99@gmail.com>
+ *
+ * SPDX-License-Identifier: GPL-2.0-or-later
+ *
+ * K230 Technical Reference Manual V0.3.1 (2024-11-18)
+ */
+
+#include "qemu/osdep.h"
+#include "qemu/bitops.h"
+#include "libqtest.h"
+#include "hw/gpio/k230_gpio.h"
+
+#define K230_GPIO0_BASE  0x9140B000
+#define K230_GPIO1_BASE  0x9140C000
+
+#define GPIO_BASE K230_GPIO0_BASE
+
+#define PLIC_BASE           0xF00000000ULL
+#define PLIC_PRIORITY       (PLIC_BASE + 0x000000)
+#define PLIC_PENDING        (PLIC_BASE + 0x001000)
+#define PLIC_ENABLE         (PLIC_BASE + 0x002000)
+#define PLIC_CONTEXT        (PLIC_BASE + 0x200000)
+#define PLIC_THRESHOLD      (PLIC_CONTEXT + 0x0)
+#define PLIC_CLAIM          (PLIC_CONTEXT + 0x4)
+
+#define GPIO0_IRQ_BASE  32
+#define GPIO1_IRQ_BASE  64
+
+static inline bool plic_irq_pending(QTestState *qts, int irq)
+{
+    uint32_t word = qtest_readl(qts, PLIC_PENDING + (irq / 32) * 4);
+    return extract32(word, irq % 32, 1);
+}
+
+static void gpio0_set_input(QTestState *qts, int line, int level)
+{
+    qtest_set_irq_in(qts, "/machine/soc/k230-gpio0",
+                     "unnamed-gpio-in", line, level);
+}
+
+static void gpio1_set_input(QTestState *qts, int line, int level)
+{
+    qtest_set_irq_in(qts, "/machine/soc/k230-gpio1",
+                     "unnamed-gpio-in", line, level);
+}
+
+static void plic_enable_irq(QTestState *qts, int irq)
+{
+    qtest_writel(qts, PLIC_PRIORITY + irq * 4, 1);
+    qtest_writel(qts, PLIC_THRESHOLD, 0);
+    qtest_writel(qts, PLIC_ENABLE + (irq / 32) * 4, BIT(irq % 32));
+}
+
+static void plic_claim_complete(QTestState *qts, int irq)
+{
+    uint32_t claimed = qtest_readl(qts, PLIC_CLAIM);
+    g_assert_cmpuint(claimed, ==, irq);
+    qtest_writel(qts, PLIC_CLAIM, irq);
+}
+
+static uint32_t gpio0_read(QTestState *qts, hwaddr offset)
+{
+    return qtest_readl(qts, GPIO_BASE + offset);
+}
+
+static void gpio0_write(QTestState *qts, hwaddr offset, uint32_t value)
+{
+    qtest_writel(qts, GPIO_BASE + offset, value);
+}
+
+static uint32_t gpio0_raw_intstatus(QTestState *qts)
+{
+    return gpio0_read(qts, K230_GPIO_RAW_INTSTATUS);
+}
+
+static void test_reset_values(void)
+{
+    QTestState *qts = qtest_init("-machine k230");
+
+    g_assert_cmphex(gpio0_read(qts, K230_GPIO_SWPORTA_DR), ==, 0x0);
+    g_assert_cmphex(gpio0_read(qts, K230_GPIO_SWPORTA_DDR), ==, 0x0);
+    g_assert_cmphex(gpio0_read(qts, K230_GPIO_SWPORTA_CTL), ==, 0x0);
+    g_assert_cmphex(gpio0_read(qts, K230_GPIO_INTEN), ==, 0x0);
+    g_assert_cmphex(gpio0_read(qts, K230_GPIO_INTMASK), ==, 0x0);
+    g_assert_cmphex(gpio0_read(qts, K230_GPIO_INTTYPE_LEVEL), ==, 0x0);
+    g_assert_cmphex(gpio0_read(qts, K230_GPIO_INT_POLARITY), ==, 0x0);
+    g_assert_cmphex(gpio0_read(qts, K230_GPIO_INTSTATUS), ==, 0x0);
+    g_assert_cmphex(gpio0_read(qts, K230_GPIO_RAW_INTSTATUS), ==, 0x0);
+    g_assert_cmphex(gpio0_read(qts, K230_GPIO_CONFIG_REG2), ==, 0x0);
+    g_assert_cmphex(gpio0_read(qts, K230_GPIO_CONFIG_REG1), ==, 0x0);
+
+    qtest_quit(qts);
+}
+
+static void test_edge_rising(void)
+{
+    QTestState *qts = qtest_init("-machine k230");
+    int gpio_irq = GPIO0_IRQ_BASE + 5;
+
+    plic_enable_irq(qts, gpio_irq);
+
+    gpio0_write(qts, K230_GPIO_SWPORTA_DDR, 0);
+    gpio0_write(qts, K230_GPIO_INTTYPE_LEVEL, BIT(5));
+    gpio0_write(qts, K230_GPIO_INT_POLARITY, BIT(5));
+    gpio0_write(qts, K230_GPIO_INTMASK, 0);
+    gpio0_write(qts, K230_GPIO_INTEN, BIT(5));
+
+    gpio0_set_input(qts, 5, 0);
+    g_assert_false(plic_irq_pending(qts, gpio_irq));
+
+    gpio0_set_input(qts, 5, 1);
+    g_assert_true(plic_irq_pending(qts, gpio_irq));
+
+    qtest_quit(qts);
+}
+
+static void test_edge_falling(void)
+{
+    QTestState *qts = qtest_init("-machine k230");
+    int gpio_irq = GPIO0_IRQ_BASE + 3;
+
+    plic_enable_irq(qts, gpio_irq);
+
+    gpio0_write(qts, K230_GPIO_SWPORTA_DDR, 0);
+    gpio0_write(qts, K230_GPIO_INTTYPE_LEVEL, BIT(3));
+    gpio0_write(qts, K230_GPIO_INT_POLARITY, 0);
+    gpio0_write(qts, K230_GPIO_INTMASK, 0);
+    gpio0_write(qts, K230_GPIO_INTEN, BIT(3));
+
+    gpio0_set_input(qts, 3, 1);
+    g_assert_false(plic_irq_pending(qts, gpio_irq));
+
+    gpio0_set_input(qts, 3, 0);
+    g_assert_true(plic_irq_pending(qts, gpio_irq));
+
+    qtest_quit(qts);
+}
+
+static void test_both_edge(void)
+{
+    QTestState *qts = qtest_init("-machine k230");
+    int gpio_irq = GPIO0_IRQ_BASE + 7;
+
+    plic_enable_irq(qts, gpio_irq);
+
+    gpio0_write(qts, K230_GPIO_SWPORTA_DDR, 0);
+    gpio0_write(qts, K230_GPIO_INTTYPE_LEVEL, BIT(7));
+    gpio0_write(qts, K230_GPIO_INT_BOTHEDGE, BIT(7));
+    gpio0_write(qts, K230_GPIO_INTMASK, 0);
+    gpio0_write(qts, K230_GPIO_INTEN, BIT(7));
+
+    gpio0_set_input(qts, 7, 0);
+    g_assert_false(plic_irq_pending(qts, gpio_irq));
+
+    gpio0_set_input(qts, 7, 1);
+    g_assert_true(plic_irq_pending(qts, gpio_irq));
+
+    gpio0_write(qts, K230_GPIO_PORTA_EOI, BIT(7));
+    g_assert_cmphex(gpio0_raw_intstatus(qts) & BIT(7), ==, 0);
+    plic_claim_complete(qts, gpio_irq);
+    g_assert_false(plic_irq_pending(qts, gpio_irq));
+
+    gpio0_set_input(qts, 7, 0);
+    g_assert_true(plic_irq_pending(qts, gpio_irq));
+
+    qtest_quit(qts);
+}
+
+static void test_level_high(void)
+{
+    QTestState *qts = qtest_init("-machine k230");
+    int gpio_irq = GPIO0_IRQ_BASE + 2;
+
+    plic_enable_irq(qts, gpio_irq);
+
+    gpio0_write(qts, K230_GPIO_SWPORTA_DDR, 0);
+    gpio0_write(qts, K230_GPIO_INTTYPE_LEVEL, 0);
+    gpio0_write(qts, K230_GPIO_INT_POLARITY, BIT(2));
+    gpio0_write(qts, K230_GPIO_INTMASK, 0);
+    gpio0_write(qts, K230_GPIO_INTEN, BIT(2));
+
+    gpio0_set_input(qts, 2, 0);
+    g_assert_false(plic_irq_pending(qts, gpio_irq));
+
+    gpio0_set_input(qts, 2, 1);
+    g_assert_true(plic_irq_pending(qts, gpio_irq));
+
+    gpio0_set_input(qts, 2, 0);
+    g_assert_cmphex(gpio0_raw_intstatus(qts) & BIT(2), ==, 0);
+    plic_claim_complete(qts, gpio_irq);
+    g_assert_false(plic_irq_pending(qts, gpio_irq));
+
+    qtest_quit(qts);
+}
+
+static void test_level_low(void)
+{
+    QTestState *qts = qtest_init("-machine k230");
+    int gpio_irq = GPIO0_IRQ_BASE + 4;
+
+    plic_enable_irq(qts, gpio_irq);
+
+    gpio0_write(qts, K230_GPIO_SWPORTA_DDR, 0);
+    gpio0_write(qts, K230_GPIO_INTTYPE_LEVEL, 0);
+    gpio0_write(qts, K230_GPIO_INT_POLARITY, 0);
+    gpio0_write(qts, K230_GPIO_INTMASK, 0);
+    gpio0_write(qts, K230_GPIO_INTEN, BIT(4));
+
+    gpio0_set_input(qts, 4, 1);
+    g_assert_false(plic_irq_pending(qts, gpio_irq));
+
+    gpio0_set_input(qts, 4, 0);
+    g_assert_true(plic_irq_pending(qts, gpio_irq));
+
+    /*
+     * Level goes away: GPIO deasserts, but the PLIC pending bit is
+     * sticky. Verify the GPIO-side status is cleared, then
+     * claim/complete to clear the PLIC pending bit.
+     */
+    gpio0_set_input(qts, 4, 1);
+    g_assert_cmphex(gpio0_raw_intstatus(qts) & BIT(4), ==, 0);
+    plic_claim_complete(qts, gpio_irq);
+    g_assert_false(plic_irq_pending(qts, gpio_irq));
+
+    qtest_quit(qts);
+}
+
+static void test_eoi_clear(void)
+{
+    QTestState *qts = qtest_init("-machine k230");
+    int gpio_irq = GPIO0_IRQ_BASE + 10;
+
+    plic_enable_irq(qts, gpio_irq);
+
+    gpio0_write(qts, K230_GPIO_SWPORTA_DDR, 0);
+    gpio0_write(qts, K230_GPIO_INTTYPE_LEVEL, BIT(10));
+    gpio0_write(qts, K230_GPIO_INT_POLARITY, BIT(10));
+    gpio0_write(qts, K230_GPIO_INTMASK, 0);
+    gpio0_write(qts, K230_GPIO_INTEN, BIT(10));
+
+    gpio0_set_input(qts, 10, 0);
+    gpio0_set_input(qts, 10, 1);
+    g_assert_true(plic_irq_pending(qts, gpio_irq));
+
+    /*
+     * EOI clears the GPIO-side raw status, then claim/complete
+     * clears the sticky PLIC pending bit.
+     */
+    gpio0_write(qts, K230_GPIO_PORTA_EOI, BIT(10));
+    g_assert_cmphex(gpio0_raw_intstatus(qts) & BIT(10), ==, 0);
+    plic_claim_complete(qts, gpio_irq);
+    g_assert_false(plic_irq_pending(qts, gpio_irq));
+
+    qtest_quit(qts);
+}
+
+static void test_inten_disabled(void)
+{
+    QTestState *qts = qtest_init("-machine k230");
+    int gpio_irq = GPIO0_IRQ_BASE + 15;
+
+    plic_enable_irq(qts, gpio_irq);
+
+    gpio0_write(qts, K230_GPIO_SWPORTA_DDR, 0);
+    gpio0_write(qts, K230_GPIO_INTTYPE_LEVEL, BIT(15));
+    gpio0_write(qts, K230_GPIO_INT_POLARITY, BIT(15));
+    gpio0_write(qts, K230_GPIO_INTMASK, 0);
+    gpio0_write(qts, K230_GPIO_INTEN, 0);
+
+    gpio0_set_input(qts, 15, 0);
+    gpio0_set_input(qts, 15, 1);
+    g_assert_false(plic_irq_pending(qts, gpio_irq));
+
+    qtest_quit(qts);
+}
+
+static void test_intmask(void)
+{
+    QTestState *qts = qtest_init("-machine k230");
+    int gpio_irq = GPIO0_IRQ_BASE + 20;
+
+    plic_enable_irq(qts, gpio_irq);
+
+    gpio0_write(qts, K230_GPIO_SWPORTA_DDR, 0);
+    gpio0_write(qts, K230_GPIO_INTTYPE_LEVEL, BIT(20));
+    gpio0_write(qts, K230_GPIO_INT_POLARITY, BIT(20));
+    gpio0_write(qts, K230_GPIO_INTMASK, BIT(20));
+    gpio0_write(qts, K230_GPIO_INTEN, BIT(20));
+
+    gpio0_set_input(qts, 20, 0);
+    gpio0_set_input(qts, 20, 1);
+
+    g_assert_cmphex(gpio0_raw_intstatus(qts) & BIT(20), ==, BIT(20));
+    g_assert_false(plic_irq_pending(qts, gpio_irq));
+
+    qtest_quit(qts);
+}
+
+static void test_ddr_output_no_int(void)
+{
+    QTestState *qts = qtest_init("-machine k230");
+    int gpio_irq = GPIO0_IRQ_BASE + 25;
+
+    plic_enable_irq(qts, gpio_irq);
+
+    gpio0_write(qts, K230_GPIO_SWPORTA_DDR, BIT(25));
+    gpio0_write(qts, K230_GPIO_INTTYPE_LEVEL, BIT(25));
+    gpio0_write(qts, K230_GPIO_INT_POLARITY, BIT(25));
+    gpio0_write(qts, K230_GPIO_INTMASK, 0);
+    gpio0_write(qts, K230_GPIO_INTEN, BIT(25));
+
+    gpio0_set_input(qts, 25, 0);
+    gpio0_set_input(qts, 25, 1);
+    g_assert_false(plic_irq_pending(qts, gpio_irq));
+
+    qtest_quit(qts);
+}
+
+static void test_ctl_hw_no_int(void)
+{
+    QTestState *qts = qtest_init("-machine k230");
+    int gpio_irq = GPIO0_IRQ_BASE + 27;
+
+    plic_enable_irq(qts, gpio_irq);
+
+    gpio0_write(qts, K230_GPIO_SWPORTA_DDR, 0);
+    gpio0_write(qts, K230_GPIO_SWPORTA_CTL, BIT(27));
+    gpio0_write(qts, K230_GPIO_INTTYPE_LEVEL, BIT(27));
+    gpio0_write(qts, K230_GPIO_INT_POLARITY, BIT(27));
+    gpio0_write(qts, K230_GPIO_INTMASK, 0);
+    gpio0_write(qts, K230_GPIO_INTEN, BIT(27));
+
+    gpio0_set_input(qts, 27, 0);
+    gpio0_set_input(qts, 27, 1);
+    g_assert_false(plic_irq_pending(qts, gpio_irq));
+
+    qtest_quit(qts);
+}
+
+static void test_gpio_plic(void)
+{
+    QTestState *qts = qtest_init("-machine k230");
+    int gpio_irq = GPIO0_IRQ_BASE + 6;
+
+    plic_enable_irq(qts, gpio_irq);
+
+    gpio0_write(qts, K230_GPIO_SWPORTA_DDR, 0);
+    gpio0_write(qts, K230_GPIO_INTTYPE_LEVEL, BIT(6));
+    gpio0_write(qts, K230_GPIO_INT_POLARITY, BIT(6));
+    gpio0_write(qts, K230_GPIO_INTMASK, 0);
+    gpio0_write(qts, K230_GPIO_INTEN, BIT(6));
+
+    gpio0_set_input(qts, 6, 0);
+    gpio0_set_input(qts, 6, 1);
+
+    g_assert_true(plic_irq_pending(qts, gpio_irq));
+
+    /*
+     * EOI clears the GPIO-side raw status, then claim/complete
+     * clears the sticky PLIC pending bit and returns the claimed
+     * IRQ id.
+     */
+    gpio0_write(qts, K230_GPIO_PORTA_EOI, BIT(6));
+    plic_claim_complete(qts, gpio_irq);
+    g_assert_false(plic_irq_pending(qts, gpio_irq));
+
+    qtest_quit(qts);
+}
+
+static void test_multiple_irqs(void)
+{
+    QTestState *qts = qtest_init("-machine k230");
+    int irq_a = GPIO0_IRQ_BASE + 1;
+    int irq_b = GPIO0_IRQ_BASE + 9;
+
+    qtest_writel(qts, PLIC_PRIORITY + irq_a * 4, 1);
+    qtest_writel(qts, PLIC_PRIORITY + irq_b * 4, 1);
+    qtest_writel(qts, PLIC_THRESHOLD, 0);
+    qtest_writel(qts, PLIC_ENABLE + (irq_a / 32) * 4,
+                 BIT(irq_a % 32) | BIT(irq_b % 32));
+
+    gpio0_write(qts, K230_GPIO_SWPORTA_DDR, 0);
+    gpio0_write(qts, K230_GPIO_INTTYPE_LEVEL, BIT(1) | BIT(9));
+    gpio0_write(qts, K230_GPIO_INT_POLARITY, BIT(1) | BIT(9));
+    gpio0_write(qts, K230_GPIO_INTMASK, 0);
+    gpio0_write(qts, K230_GPIO_INTEN, BIT(1) | BIT(9));
+
+    gpio0_set_input(qts, 1, 0);
+    gpio0_set_input(qts, 9, 0);
+
+    gpio0_set_input(qts, 1, 1);
+    g_assert_true(plic_irq_pending(qts, irq_a));
+    g_assert_false(plic_irq_pending(qts, irq_b));
+
+    gpio0_set_input(qts, 9, 1);
+    g_assert_true(plic_irq_pending(qts, irq_a));
+    g_assert_true(plic_irq_pending(qts, irq_b));
+
+    qtest_quit(qts);
+}
+
+static void test_gpio1_plic(void)
+{
+    QTestState *qts = qtest_init("-machine k230");
+    int gpio_irq = GPIO1_IRQ_BASE + 5;
+
+    plic_enable_irq(qts, gpio_irq);
+
+    qtest_writel(qts, K230_GPIO1_BASE + K230_GPIO_SWPORTA_DDR, 0);
+    qtest_writel(qts, K230_GPIO1_BASE + K230_GPIO_INTTYPE_LEVEL, BIT(5));
+    qtest_writel(qts, K230_GPIO1_BASE + K230_GPIO_INT_POLARITY, BIT(5));
+    qtest_writel(qts, K230_GPIO1_BASE + K230_GPIO_INTMASK, 0);
+    qtest_writel(qts, K230_GPIO1_BASE + K230_GPIO_INTEN, BIT(5));
+
+    gpio1_set_input(qts, 5, 0);
+    gpio1_set_input(qts, 5, 1);
+
+    g_assert_true(plic_irq_pending(qts, gpio_irq));
+
+    qtest_quit(qts);
+}
+
+static void test_ddr_switch_output_to_input(void)
+{
+    QTestState *qts = qtest_init("-machine k230");
+    int level_irq = GPIO0_IRQ_BASE + 12;
+    int edge_irq = GPIO0_IRQ_BASE + 13;
+
+    qtest_writel(qts, PLIC_PRIORITY + level_irq * 4, 1);
+    qtest_writel(qts, PLIC_PRIORITY + edge_irq * 4, 1);
+    qtest_writel(qts, PLIC_THRESHOLD, 0);
+    qtest_writel(qts, PLIC_ENABLE + (level_irq / 32) * 4,
+                 BIT(level_irq % 32) | BIT(edge_irq % 32));
+
+    gpio0_write(qts, K230_GPIO_SWPORTA_DDR, BIT(12) | BIT(13));
+    gpio0_write(qts, K230_GPIO_INTTYPE_LEVEL, BIT(13));
+    gpio0_write(qts, K230_GPIO_INT_POLARITY, BIT(12) | BIT(13));
+    gpio0_write(qts, K230_GPIO_INTMASK, 0);
+    gpio0_write(qts, K230_GPIO_INTEN, BIT(12) | BIT(13));
+
+    gpio0_set_input(qts, 12, 0);
+    gpio0_set_input(qts, 13, 0);
+
+    gpio0_set_input(qts, 12, 1);
+    gpio0_set_input(qts, 13, 1);
+
+    g_assert_false(plic_irq_pending(qts, level_irq));
+    g_assert_false(plic_irq_pending(qts, edge_irq));
+
+    gpio0_write(qts, K230_GPIO_SWPORTA_DDR, 0);
+
+    g_assert_true(plic_irq_pending(qts, level_irq));
+    g_assert_false(plic_irq_pending(qts, edge_irq));
+
+    qtest_quit(qts);
+}
+
+static void test_ctl_switch_hw_to_sw(void)
+{
+    QTestState *qts = qtest_init("-machine k230");
+    int level_irq = GPIO0_IRQ_BASE + 14;
+    int edge_irq = GPIO0_IRQ_BASE + 16;
+
+    qtest_writel(qts, PLIC_PRIORITY + level_irq * 4, 1);
+    qtest_writel(qts, PLIC_PRIORITY + edge_irq * 4, 1);
+    qtest_writel(qts, PLIC_THRESHOLD, 0);
+    qtest_writel(qts, PLIC_ENABLE + (level_irq / 32) * 4,
+                 BIT(level_irq % 32) | BIT(edge_irq % 32));
+
+    gpio0_write(qts, K230_GPIO_SWPORTA_DDR, 0);
+    gpio0_write(qts, K230_GPIO_SWPORTA_CTL, BIT(14) | BIT(16));
+    gpio0_write(qts, K230_GPIO_INTTYPE_LEVEL, BIT(16));
+    gpio0_write(qts, K230_GPIO_INT_POLARITY, BIT(14) | BIT(16));
+    gpio0_write(qts, K230_GPIO_INTMASK, 0);
+    gpio0_write(qts, K230_GPIO_INTEN, BIT(14) | BIT(16));
+
+    gpio0_set_input(qts, 14, 0);
+    gpio0_set_input(qts, 16, 0);
+
+    gpio0_set_input(qts, 14, 1);
+    gpio0_set_input(qts, 16, 1);
+
+    g_assert_false(plic_irq_pending(qts, level_irq));
+    g_assert_false(plic_irq_pending(qts, edge_irq));
+
+    gpio0_write(qts, K230_GPIO_SWPORTA_CTL, 0);
+
+    g_assert_true(plic_irq_pending(qts, level_irq));
+    g_assert_false(plic_irq_pending(qts, edge_irq));
+
+    qtest_quit(qts);
+}
+
+int main(int argc, char *argv[])
+{
+    g_test_init(&argc, &argv, NULL);
+
+    qtest_add_func("/k230-gpio/reset_values", test_reset_values);
+    qtest_add_func("/k230-gpio/edge_rising", test_edge_rising);
+    qtest_add_func("/k230-gpio/edge_falling", test_edge_falling);
+    qtest_add_func("/k230-gpio/both_edge", test_both_edge);
+    qtest_add_func("/k230-gpio/level_high", test_level_high);
+    qtest_add_func("/k230-gpio/level_low", test_level_low);
+    qtest_add_func("/k230-gpio/eoi_clear", test_eoi_clear);
+    qtest_add_func("/k230-gpio/inten_disabled", test_inten_disabled);
+    qtest_add_func("/k230-gpio/intmask", test_intmask);
+    qtest_add_func("/k230-gpio/ddr_output_no_int", test_ddr_output_no_int);
+    qtest_add_func("/k230-gpio/ctl_hw_no_int", test_ctl_hw_no_int);
+    qtest_add_func("/k230-gpio/gpio_plic", test_gpio_plic);
+    qtest_add_func("/k230-gpio/multiple_irqs", test_multiple_irqs);
+    qtest_add_func("/k230-gpio/gpio1_plic", test_gpio1_plic);
+    qtest_add_func("/k230-gpio/ddr_switch_out_to_in",
+                   test_ddr_switch_output_to_input);
+    qtest_add_func("/k230-gpio/ctl_switch_hw_to_sw",
+                   test_ctl_switch_hw_to_sw);
+
+    return g_test_run();
+}
diff --git a/tests/qtest/meson.build b/tests/qtest/meson.build
index 56ff860e21..cec2f818ae 100644
--- a/tests/qtest/meson.build
+++ b/tests/qtest/meson.build
@@ -297,7 +297,7 @@ qtests_riscv64 = ['riscv-csr-test'] + \
   (config_all_devices.has_key('CONFIG_IOMMU_TESTDEV') and
    config_all_devices.has_key('CONFIG_RISCV_IOMMU') ?
    ['iommu-riscv-test'] : []) + \
-  (config_all_devices.has_key('CONFIG_K230') ? ['k230-wdt-test'] : [])
+  (config_all_devices.has_key('CONFIG_K230') ? ['k230-wdt-test', 'k230-gpio-test'] : [])
 
 qtests_hexagon = ['boot-serial-test']
 
-- 
2.43.0


