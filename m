Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 68338ECE56F
	for <qemu-devel@archiver.kernel.org>; Sat,  7 Sep 2024 21:47:07 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sn3G1-0007m9-Ql; Sat, 07 Sep 2024 17:46:13 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <satur9nine@gmail.com>)
 id 1sn3G0-0007le-I9
 for qemu-devel@nongnu.org; Sat, 07 Sep 2024 17:46:12 -0400
Received: from mail-pj1-x1036.google.com ([2607:f8b0:4864:20::1036])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <satur9nine@gmail.com>)
 id 1sn3Fw-0006am-GQ
 for qemu-devel@nongnu.org; Sat, 07 Sep 2024 17:46:11 -0400
Received: by mail-pj1-x1036.google.com with SMTP id
 98e67ed59e1d1-2d87f34a650so2143864a91.1
 for <qemu-devel@nongnu.org>; Sat, 07 Sep 2024 14:46:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1725745566; x=1726350366; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=tsZ1skBJYv0lTXgXWfwzxn7N+kD9w6DoeE5PWN/73iM=;
 b=GIvaAinqZQuw2o5POyo80+w28LdUfsW6FOoICWMhmWIvmrUwVc3W0zMbtBY8Hvw3gd
 Bp5OdRQx4rFN35MC4J6TsyUKrquwHWIpVwkRnoiaAwGPKphCrOD3XqSA+tNRa5Wv+roF
 I23jfkLDH7+CLeSf5QwKDJE/qvMrEMg+CnP6JDlMlGfUIs/FqmiZALyP3N/UeTuPEtyV
 sSJgMt7ShaQAxCtk+nkDJiPjXBNZ1nApNHYhuFdE2De1EP/ud9ogyyAK2den3vL8op3r
 Y7xnc2MNww0WFfilM4gMLVB1xoB9Zl0QKpcgCY3YwJveBqty8Uv5/dWN9lXNHNZbfd26
 SXZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1725745566; x=1726350366;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=tsZ1skBJYv0lTXgXWfwzxn7N+kD9w6DoeE5PWN/73iM=;
 b=UHrRr3CcXZ2zK0MSr06wxDdes+niuINrtCJ8rLuXug2Hc4ArC06uynI4oedviJebBs
 NSjKZcUZmI9cYm7kFmwao5bLPlMvfAGocSs8NF9k48vptg3VFyPocdyE4lN1RMdqe1q8
 rdPvtT0t0EGtFwop+fEaPOpTkqrNwqneuEyfa4xNhQKobh4r4lUCDa7q6mlNgBg6nmga
 4eEPBkCMcAI9b6tytQs9fyZbnhzL91rmBcT06BEVy4O5Jn3eOUiTJPXWdOOOHTDphF7V
 JuLCZJET0lexRxCq23ltsum366ycnNCzzcTfSdfqPQN5dFD3Bd8wcnwReJrhUPuWQoBn
 oLPA==
X-Gm-Message-State: AOJu0Yyjjj0AccI3sRZ0t2rK8Bl2aU7UaSCllw8Lxya0wn2EtU6opsv1
 cBMjlQ8gytkaKZMSKj5QAsX420kahBFbuRHNNspfIq5cf193rMD24kJ6f/ASA6E=
X-Google-Smtp-Source: AGHT+IFUNwN7dzm3tUpyBTwB7N+TIiIC5DsIKFJD0hbJOhlCTG4djjY+r+7kx1zcqEE9Y7nwTF6l8w==
X-Received: by 2002:a17:90b:2247:b0:2da:6e46:ad48 with SMTP id
 98e67ed59e1d1-2dad4f0e439mr10101471a91.1.1725745566014; 
 Sat, 07 Sep 2024 14:46:06 -0700 (PDT)
Received: from jacob-pop23u.lan ([2600:1700:88b2:a50:2c86:7da2:dc34:a97f])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-2db04966aa5sm1721116a91.37.2024.09.07.14.46.05
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 07 Sep 2024 14:46:05 -0700 (PDT)
From: Jacob Abrams <satur9nine@gmail.com>
To: qemu-devel@nongnu.org
Cc: philmd@linaro.org, peter.maydell@linaro.org,
 Jacob Abrams <satur9nine@gmail.com>
Subject: [PATCH v2] hw/char/stm32l4x5_usart.c: Fix ACK and min access size
Date: Sat,  7 Sep 2024 14:45:39 -0700
Message-ID: <20240907214602.96920-1-satur9nine@gmail.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::1036;
 envelope-from=satur9nine@gmail.com; helo=mail-pj1-x1036.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
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
Changes since version 1:
 - Add qtest_quit to end of new test

 hw/char/stm32l4x5_usart.c          | 29 ++++++++++++++++++---
 tests/qtest/stm32l4x5_usart-test.c | 41 +++++++++++++++++++++++++++++-
 2 files changed, 66 insertions(+), 4 deletions(-)

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
index c175ff3064..018a8a62bf 100644
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
@@ -203,6 +205,11 @@ static void test_write_read(void)
     const uint32_t tdr = qtest_readl(qts, USART1_BASE_ADDR + A_TDR);
     g_assert_cmpuint(tdr, ==, 0x000001FF);
 
+    /* Official STM HAL uses uint16_t for TDR */
+    qtest_writew(qts, USART1_BASE_ADDR + A_TDR, 0xFFFF);
+    const uint16_t tdr16 = qtest_readw(qts, USART1_BASE_ADDR + A_TDR);
+    g_assert_cmpuint(tdr16, ==, 0x000001FF);
+
     qtest_quit(qts);
 }
 
@@ -298,6 +305,37 @@ static void test_send_str(void)
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
+
+    qtest_quit(qts);
+}
+
 int main(int argc, char **argv)
 {
     int ret;
@@ -310,6 +348,7 @@ int main(int argc, char **argv)
     qtest_add_func("stm32l4x5/usart/send_char", test_send_char);
     qtest_add_func("stm32l4x5/usart/receive_str", test_receive_str);
     qtest_add_func("stm32l4x5/usart/send_str", test_send_str);
+    qtest_add_func("stm32l4x5/usart/ack", test_ack);
     ret = g_test_run();
 
     return ret;
-- 
2.43.0


