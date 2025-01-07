Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F37CBE77197
	for <qemu-devel@archiver.kernel.org>; Tue,  7 Jan 2025 19:27:37 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tVFE1-0003L7-46; Tue, 07 Jan 2025 14:26:49 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tVFDv-0003KV-C3
 for qemu-devel@nongnu.org; Tue, 07 Jan 2025 14:26:45 -0500
Received: from mail-wr1-x432.google.com ([2a00:1450:4864:20::432])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tVFDt-0007oJ-2c
 for qemu-devel@nongnu.org; Tue, 07 Jan 2025 14:26:42 -0500
Received: by mail-wr1-x432.google.com with SMTP id
 ffacd0b85a97d-3863494591bso8201776f8f.1
 for <qemu-devel@nongnu.org>; Tue, 07 Jan 2025 11:26:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1736277999; x=1736882799; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=jQpe/t9gE90x9xB1kiTd2LC7ZhqmJPaLIwleQhgmA4g=;
 b=tACTlSaNNumfLn9lWEpyPUQBk/pKlWa9eUdntVXhDsbruvxK1ZQVfD7Lunbt9jviee
 nmtapRiXQgcIaFpQjrwlOLh3Yl+l2PGbRSDb1YjhPgUAwSYMS319X2YvO0UmL+IdHlAt
 dtT9etAsnZHaap0pzRme08mU6UTIUQVkI3lhwk6f4SVgsrOvgGzXRFMyFb0hntBQNL8W
 k/lQvCpU3Jy4ar89DL9BRXZn092EPUuyvvWIajjWAj/yC7ldh2ktXyf02BDSKPpsy7QB
 KmEDonzPZx9WwwKtABsQ7PcVb5l+wYnBoZ2IwsE5m6aQs2hPLUKGsvVz1dVndvtKh/+L
 he4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1736277999; x=1736882799;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=jQpe/t9gE90x9xB1kiTd2LC7ZhqmJPaLIwleQhgmA4g=;
 b=puIjJHNcMiiQ8OaW9CO3v9kmg30cXIEss6PWsWjx02Q+F3yoVhRUZQ/FLClKEmUGa6
 iYgPF+JrWDGXMKz9Lrq5G+zhes7Nj7UntISLmrHlGnz5iqo03uCoN062KCG9qitgnhST
 4WBcHHqYbJ+dP63C/38Ik00UlV387aU39esh9c3JRqvYIJTXD19TyaLefP/f18pRFl13
 03lfbV+4361ZR8KI5PuuoWP3FCjP6MMcXQZycadauTNVUhLc2chX2BwqcyiRJNfpIEcD
 GDslUXnf6MfYtyTDIXRz9FU23f6To/QD3WiPKpCTAX/qFEPbnliA/dzrO8XFL1IAedOy
 LmCQ==
X-Gm-Message-State: AOJu0Yy7pj//ExQYJuKprNQ+o3kHT8fBbfrc+wxpxF+GIkX2Gd6rpt5V
 kIQvh9zlG7c9w12VzgOWBpLlKGKgY4pWiIV+LRB/D10Zcd/lMYqxOK+yrG8A7h2xfkR8TDcfc8p
 rdoY=
X-Gm-Gg: ASbGncvwYHYx4oRRtm/4F8fptwExzNHinEcmHUKDwVKtmxDhfbCpGctXLYsXmpT8eEj
 hOBvFdSx2yCk5ul/dS9PTB2eIc6aCTvH7kTSP4iDbiPcbQSCTexHdjIGfSoYhoBRUG3v7PUBxxL
 J+4TmDJA3IC31qNnJcuk3zZP1WE0tJ47amDJkmbfrGpIDdAAx60BuotegIvnpj/9B9+CIegNL79
 O7ky2HM3kMDHRt31nou8Zu1Zt+/VvjxOYa9HZhPzICMoX1RSpj9xTfUKnt25lEdq5PqmclZ4au7
 cBWeQaYod5ZRrgIeuXyJ1FNo8mADAXo=
X-Google-Smtp-Source: AGHT+IHLTbv1Vkh/klZ/gKZbygji4sVpVuH+nf3/hXfJlGgADfO39TPn1BJuftl1wlMw79bhQYgFww==
X-Received: by 2002:a05:6000:2c5:b0:385:f195:27f with SMTP id
 ffacd0b85a97d-38a221f339emr57011373f8f.5.1736277999177; 
 Tue, 07 Jan 2025 11:26:39 -0800 (PST)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-38a1c828e7asm50601297f8f.21.2025.01.07.11.26.38
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Tue, 07 Jan 2025 11:26:38 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Fabiano Rosas <farosas@suse.de>, Laurent Vivier <lvivier@redhat.com>,
 Gustavo Romero <gustavo.romero@linaro.org>,
 Samuel Tardieu <sam@rfc1149.net>, qemu-arm@nongnu.org,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Thomas Huth <thuth@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [RFC PATCH] tests/qtest/stm32l4x5_usart: Avoid accessing NVIC via MMIO
Date: Tue,  7 Jan 2025 20:26:37 +0100
Message-ID: <20250107192637.67683-1-philmd@linaro.org>
X-Mailer: git-send-email 2.47.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::432;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x432.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

The STM32L4x5 SoC family use a ARM Cortex-M core. Such
core is architecturally tied with a NVIC (interrupt controller),
having the NVIC MMIO mapped in the core address space.

When using the QTest accelerator, we don't emulate vCPU, only
a dummy is created. For now, QTest is only supposed to access
MMIO devices mapped on the main 'SysBus'. Thus it shouldn't
be able to access a NVIC MMIO region, because such region is
specific to a vCPU address space, which isn't available under
QTest.

In order to avoid NVIC MMIO accesses, rather than checking
UART IRQs on the NVIC, intercept the UART IRQ and check for
raised/lowered events.

The sysbus USART1 IRQ output is wired to EXTI #26 input.
Use qtest_irq_intercept_out_named() to intercept it, count
the events with qtest_get_irq_lowered_counter() and
qtest_get_irq_raised_counter().

Remove the then unused check/clear_nvic_pending() methods.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
Based-on: <20241216141818.111255-7-gustavo.romero@linaro.org>
"tests/qtest: Add API functions to capture IRQ toggling"

This patch is to fix the problem reported by Fabiano when
removing the &first_cpu global in qtest, see analysis in:
https://lore.kernel.org/qemu-devel/05820c9b-a683-4eb4-a836-e97aa708d5e5@linaro.org/

Note, while writing that patch I noticed a problem with the
b-l475e-iot01a machine. In bl475e_init() somes output GPIOs
are wired twice. The EXTI outputs are passed to the SoC with
qdev_pass_gpios(), and few are re-wired to the various output
IRQ splitters. I'll open a GitLab issue so it can be cleared
later.
---
 tests/qtest/stm32l4x5_usart-test.c | 33 +++++++-----------------------
 1 file changed, 7 insertions(+), 26 deletions(-)

diff --git a/tests/qtest/stm32l4x5_usart-test.c b/tests/qtest/stm32l4x5_usart-test.c
index 927bab63614..35622e9434d 100644
--- a/tests/qtest/stm32l4x5_usart-test.c
+++ b/tests/qtest/stm32l4x5_usart-test.c
@@ -46,26 +46,7 @@ REG32(ICR, 0x20)
 REG32(RDR, 0x24)
 REG32(TDR, 0x28)
 
-#define NVIC_ISPR1 0XE000E204
-#define NVIC_ICPR1 0xE000E284
-#define USART1_IRQ 37
-
-static bool check_nvic_pending(QTestState *qts, unsigned int n)
-{
-    /* No USART interrupts are less than 32 */
-    assert(n > 32);
-    n -= 32;
-    return qtest_readl(qts, NVIC_ISPR1) & (1 << n);
-}
-
-static bool clear_nvic_pending(QTestState *qts, unsigned int n)
-{
-    /* No USART interrupts are less than 32 */
-    assert(n > 32);
-    n -= 32;
-    qtest_writel(qts, NVIC_ICPR1, (1 << n));
-    return true;
-}
+#define USART1_EXTI_IRQ 26
 
 /*
  * Wait indefinitely for the flag to be updated.
@@ -195,6 +176,8 @@ static void init_uart(QTestState *qts)
     /* Enable the transmitter, the receiver and the USART. */
     qtest_writel(qts, (USART1_BASE_ADDR + A_CR1),
         cr1 | R_CR1_UE_MASK | R_CR1_RE_MASK | R_CR1_TE_MASK);
+
+    qtest_irq_intercept_out_named(qts, "machine/soc/exti", "sysbus-irq");
 }
 
 static void test_write_read(void)
@@ -221,7 +204,7 @@ static void test_receive_char(void)
     g_assert_true(send(sock_fd, "a", 1, 0) == 1);
     usart_wait_for_flag(qts, USART1_BASE_ADDR + A_ISR, R_ISR_RXNE_MASK);
     g_assert_cmphex(qtest_readl(qts, USART1_BASE_ADDR + A_RDR), ==, 'a');
-    g_assert_false(check_nvic_pending(qts, USART1_IRQ));
+    g_assert_cmpuint(qtest_get_irq_lowered_counter(qts, USART1_EXTI_IRQ), ==, 0);
 
     /* Now with the IRQ */
     cr1 = qtest_readl(qts, (USART1_BASE_ADDR + A_CR1));
@@ -230,8 +213,7 @@ static void test_receive_char(void)
     g_assert_true(send(sock_fd, "b", 1, 0) == 1);
     usart_wait_for_flag(qts, USART1_BASE_ADDR + A_ISR, R_ISR_RXNE_MASK);
     g_assert_cmphex(qtest_readl(qts, USART1_BASE_ADDR + A_RDR), ==, 'b');
-    g_assert_true(check_nvic_pending(qts, USART1_IRQ));
-    clear_nvic_pending(qts, USART1_IRQ);
+    g_assert_cmpuint(qtest_get_irq_lowered_counter(qts, USART1_EXTI_IRQ), >, 0);
 
     close(sock_fd);
 
@@ -251,7 +233,7 @@ static void test_send_char(void)
     qtest_writel(qts, USART1_BASE_ADDR + A_TDR, 'c');
     g_assert_true(recv(sock_fd, s, 1, 0) == 1);
     g_assert_cmphex(s[0], ==, 'c');
-    g_assert_false(check_nvic_pending(qts, USART1_IRQ));
+    g_assert_cmpuint(qtest_get_irq_lowered_counter(qts, USART1_EXTI_IRQ), ==, 0);
 
     /* Now with the IRQ */
     cr1 = qtest_readl(qts, (USART1_BASE_ADDR + A_CR1));
@@ -260,8 +242,7 @@ static void test_send_char(void)
     qtest_writel(qts, USART1_BASE_ADDR + A_TDR, 'd');
     g_assert_true(recv(sock_fd, s, 1, 0) == 1);
     g_assert_cmphex(s[0], ==, 'd');
-    g_assert_true(check_nvic_pending(qts, USART1_IRQ));
-    clear_nvic_pending(qts, USART1_IRQ);
+    g_assert_cmpuint(qtest_get_irq_raised_counter(qts, USART1_EXTI_IRQ), >, 0);
 
     close(sock_fd);
 
-- 
2.47.1


