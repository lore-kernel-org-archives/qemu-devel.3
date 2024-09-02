Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8807ECD342A
	for <qemu-devel@archiver.kernel.org>; Mon,  2 Sep 2024 13:38:41 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sl7Fk-000815-8W; Mon, 02 Sep 2024 09:37:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <satur9nine@gmail.com>)
 id 1sl0Qz-0006fE-1G
 for qemu-devel@nongnu.org; Mon, 02 Sep 2024 02:21:06 -0400
Received: from mail-pl1-x62d.google.com ([2607:f8b0:4864:20::62d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <satur9nine@gmail.com>)
 id 1sl0Qw-0006tg-PV
 for qemu-devel@nongnu.org; Mon, 02 Sep 2024 02:21:04 -0400
Received: by mail-pl1-x62d.google.com with SMTP id
 d9443c01a7336-20573eb852aso3722205ad.1
 for <qemu-devel@nongnu.org>; Sun, 01 Sep 2024 23:21:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1725258059; x=1725862859; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=viC0TnRDMlFJFecfriAtrtglq/Md4+8ZmupIiPVFeVc=;
 b=OQrfGSWu2R0ccw+5Kp6+iiV7e9nBfKEHKgFZNOIfsJnKxFn05e8t5Ei0UtnZrsR4H2
 mcltVssAxiDvJoEqhyX3WOD9AL3cz6W+2Rn/zu4+s9+dMAEjmbFdPxf3OfnxxG13d9Da
 6twcxYxiDChbfcqvyaAbXldDGbNxY5ZbMJWT7Lp/XAM0tn0ZTbvxkPdFRvNWzyFC5Zpc
 jeK62aS0ymq+rJ+xYOH0i+lLSlXD/V9zs0O+PUlnAQFm0byl/ub2JHgqrN4PiuIaUzIW
 8xvzBZ16bDn2zvsMGmOVI1LB3RyHuWc3To5c9AkPN38OaUEX82Vr5wlhDBvStsKj+scs
 NsGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1725258059; x=1725862859;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=viC0TnRDMlFJFecfriAtrtglq/Md4+8ZmupIiPVFeVc=;
 b=n2zrP7DM7LbAHcbqZOhGC9tMk0qtwWTrvKvVJ3xWjpIqZp9CVmIk33MpJjqMvtMDBJ
 JVutQZSB5hsi4BgkXtOpW/KDtgnRN10y5ObZ9Ha6Dx5V+UJYwL6rCqc8+TM9aoPC/tiq
 6P9tBZWqtMZS3SZuS+NdzNWZl2iYcdcfyXVzCipskPGxmNqw2gKvRw+2xCi3QeSa3h/X
 e2VlNy1D1/z2k1WjNimKcVxBbX0QI2/1F0J6kATRD+CIDqZIe8QrtrM9KUYIPMoT7MTL
 nWwytnw7qyCVgOP0rU35VBchI6w60qfZNKfUFxLbRKC5RcM7+VmY8NsaMBjTYaR8jz36
 9jkA==
X-Gm-Message-State: AOJu0Yz9A8a6Xbe8/mntIgtOVhE2TJGzewVZg/AdRa4YukcHm5xe3c1T
 67dErt/WuJTO4ceXiYzs665wqEVc+JWfwztGFCaO/7+SsVycvYZdF7tLw4djJfE=
X-Google-Smtp-Source: AGHT+IG6416GfUskvt7wPuX1dHG9s3UyaTi7j99BSBXN+GnoFppooIZ1s+iDmKeBeHp3cYeZK6tKVQ==
X-Received: by 2002:a17:902:db0b:b0:203:6cbd:7277 with SMTP id
 d9443c01a7336-2050e97c098mr226937945ad.9.1725258059161; 
 Sun, 01 Sep 2024 23:20:59 -0700 (PDT)
Received: from jacob-pop23u.lan ([2600:1700:88b2:a50:4ea0:6cd3:f2e:c79f])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2053e1261cbsm35592205ad.228.2024.09.01.23.20.58
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 01 Sep 2024 23:20:58 -0700 (PDT)
From: Jacob Abrams <satur9nine@gmail.com>
To: qemu-devel@nongnu.org
Cc: philmd@linaro.org,
	Jacob Abrams <satur9nine@gmail.com>
Subject: [PATCH] hw/char/stm32l4x5_usart.c: Fix ACK and min access size
Date: Sun,  1 Sep 2024 23:19:44 -0700
Message-ID: <20240902061944.526873-1-satur9nine@gmail.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62d;
 envelope-from=satur9nine@gmail.com; helo=mail-pl1-x62d.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-Mailman-Approved-At: Mon, 02 Sep 2024 09:37:54 -0400
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

These changes allow the official STM32L4xx HAL UART driver to function
properly with the b-l475e-iot01a machine.

Modifying USART_CR1 TE bit should alter USART_ISR TEACK bit, and
likewise for RE and REACK bit.

USART registers may be accessed via 16-bit instructions.

Reseting USART_CR1 UE bit should restore ISR to default value.

Fixes: 87b77e6e01ca ("hw/char/stm32l4x5_usart: Enable serial read and write")
Resolves: https://gitlab.com/qemu-project/qemu/-/issues/2540
Signed-off-by: Jacob Abrams <satur9nine@gmail.com>
---
 hw/char/stm32l4x5_usart.c          | 29 +++++++++++++++++++---
 tests/qtest/stm32l4x5_usart-test.c | 39 +++++++++++++++++++++++++++++-
 2 files changed, 64 insertions(+), 4 deletions(-)

diff --git a/hw/char/stm32l4x5_usart.c b/hw/char/stm32l4x5_usart.c
index fc5dcac0c4..859fc6236a 100644
--- a/hw/char/stm32l4x5_usart.c
+++ b/hw/char/stm32l4x5_usart.c
@@ -154,6 +154,28 @@ REG32(RDR, 0x24)
 REG32(TDR, 0x28)
     FIELD(TDR, TDR, 0, 9)
 
+#define ISR_RESET_VALUE (0x020000C0)
+
+static void stm32l4x5_update_isr(Stm32l4x5UsartBaseState *s)
+{
+    if (!(s->cr1 & R_CR1_UE_MASK)) {
+        s->isr = ISR_RESET_VALUE;
+        return;
+    }
+
+    if (s->cr1 & R_CR1_TE_MASK) {
+        s->isr |= R_ISR_TEACK_MASK;
+    } else {
+        s->isr &= ~R_ISR_TEACK_MASK;
+    }
+
+    if (s->cr1 & R_CR1_RE_MASK) {
+        s->isr |= R_ISR_REACK_MASK;
+    } else {
+        s->isr &= ~R_ISR_REACK_MASK;
+    }
+}
+
 static void stm32l4x5_update_irq(Stm32l4x5UsartBaseState *s)
 {
     if (((s->isr & R_ISR_WUF_MASK) && (s->cr3 & R_CR3_WUFIE_MASK))        ||
@@ -367,7 +389,7 @@ static void stm32l4x5_usart_base_reset_hold(Object *obj, ResetType type)
     s->brr = 0x00000000;
     s->gtpr = 0x00000000;
     s->rtor = 0x00000000;
-    s->isr = 0x020000C0;
+    s->isr = ISR_RESET_VALUE;
     s->rdr = 0x00000000;
     s->tdr = 0x00000000;
 
@@ -456,6 +478,7 @@ static void stm32l4x5_usart_base_write(void *opaque, hwaddr addr,
     case A_CR1:
         s->cr1 = value;
         stm32l4x5_update_params(s);
+        stm32l4x5_update_isr(s);
         stm32l4x5_update_irq(s);
         return;
     case A_CR2:
@@ -508,12 +531,12 @@ static const MemoryRegionOps stm32l4x5_usart_base_ops = {
     .endianness = DEVICE_NATIVE_ENDIAN,
     .valid = {
         .max_access_size = 4,
-        .min_access_size = 4,
+        .min_access_size = 2,
         .unaligned = false
     },
     .impl = {
         .max_access_size = 4,
-        .min_access_size = 4,
+        .min_access_size = 2,
         .unaligned = false
     },
 };
diff --git a/tests/qtest/stm32l4x5_usart-test.c b/tests/qtest/stm32l4x5_usart-test.c
index 8902518233..ef886074c0 100644
--- a/tests/qtest/stm32l4x5_usart-test.c
+++ b/tests/qtest/stm32l4x5_usart-test.c
@@ -36,6 +36,8 @@ REG32(GTPR, 0x10)
 REG32(RTOR, 0x14)
 REG32(RQR, 0x18)
 REG32(ISR, 0x1C)
+    FIELD(ISR, REACK, 22, 1)
+    FIELD(ISR, TEACK, 21, 1)
     FIELD(ISR, TXE, 7, 1)
     FIELD(ISR, RXNE, 5, 1)
     FIELD(ISR, ORE, 3, 1)
@@ -191,7 +193,7 @@ static void init_uart(QTestState *qts)
 
     /* Enable the transmitter, the receiver and the USART. */
     qtest_writel(qts, (USART1_BASE_ADDR + A_CR1),
-        R_CR1_UE_MASK | R_CR1_RE_MASK | R_CR1_TE_MASK);
+        cr1 | R_CR1_UE_MASK | R_CR1_RE_MASK | R_CR1_TE_MASK);
 }
 
 static void test_write_read(void)
@@ -202,6 +204,11 @@ static void test_write_read(void)
     qtest_writel(qts, USART1_BASE_ADDR + A_TDR, 0xFFFFFFFF);
     const uint32_t tdr = qtest_readl(qts, USART1_BASE_ADDR + A_TDR);
     g_assert_cmpuint(tdr, ==, 0x000001FF);
+
+    /* Official STM HAL uses uint16_t for TDR */
+    qtest_writew(qts, USART1_BASE_ADDR + A_TDR, 0xFFFF);
+    const uint16_t tdr16 = qtest_readw(qts, USART1_BASE_ADDR + A_TDR);
+    g_assert_cmpuint(tdr16, ==, 0x000001FF);
 }
 
 static void test_receive_char(void)
@@ -296,6 +303,35 @@ static void test_send_str(void)
     qtest_quit(qts);
 }
 
+static void test_ack(void)
+{
+    uint32_t cr1;
+    uint32_t isr;
+    QTestState *qts = qtest_init("-M b-l475e-iot01a");
+
+    init_uart(qts);
+
+    cr1 = qtest_readl(qts, (USART1_BASE_ADDR + A_CR1));
+
+    /* Disable the transmitter and receiver. */
+    qtest_writel(qts, (USART1_BASE_ADDR + A_CR1),
+        cr1 & ~(R_CR1_RE_MASK | R_CR1_TE_MASK));
+
+    /* Test ISR ACK for transmitter and receiver disabled */
+    isr = qtest_readl(qts, (USART1_BASE_ADDR + A_ISR));
+    g_assert_false(isr & R_ISR_TEACK_MASK);
+    g_assert_false(isr & R_ISR_REACK_MASK);
+
+    /* Enable the transmitter and receiver. */
+    qtest_writel(qts, (USART1_BASE_ADDR + A_CR1),
+        cr1 | (R_CR1_RE_MASK | R_CR1_TE_MASK));
+
+    /* Test ISR ACK for transmitter and receiver disabled */
+    isr = qtest_readl(qts, (USART1_BASE_ADDR + A_ISR));
+    g_assert_true(isr & R_ISR_TEACK_MASK);
+    g_assert_true(isr & R_ISR_REACK_MASK);
+}
+
 int main(int argc, char **argv)
 {
     int ret;
@@ -308,6 +344,7 @@ int main(int argc, char **argv)
     qtest_add_func("stm32l4x5/usart/send_char", test_send_char);
     qtest_add_func("stm32l4x5/usart/receive_str", test_receive_str);
     qtest_add_func("stm32l4x5/usart/send_str", test_send_str);
+    qtest_add_func("stm32l4x5/usart/ack", test_ack);
     ret = g_test_run();
 
     return ret;
-- 
2.43.0


