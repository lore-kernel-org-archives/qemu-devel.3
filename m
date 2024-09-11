Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D0173EDE997
	for <qemu-devel@archiver.kernel.org>; Wed, 11 Sep 2024 04:33:57 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1soF2Y-000784-A8; Wed, 11 Sep 2024 00:33:14 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <satur9nine@gmail.com>)
 id 1soF2W-00077Z-TH
 for qemu-devel@nongnu.org; Wed, 11 Sep 2024 00:33:13 -0400
Received: from mail-pg1-x534.google.com ([2607:f8b0:4864:20::534])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <satur9nine@gmail.com>)
 id 1soF2S-0007oj-11
 for qemu-devel@nongnu.org; Wed, 11 Sep 2024 00:33:12 -0400
Received: by mail-pg1-x534.google.com with SMTP id
 41be03b00d2f7-6e7b121be30so4021407a12.1
 for <qemu-devel@nongnu.org>; Tue, 10 Sep 2024 21:33:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1726029186; x=1726633986; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=YcUwxdhEJk5+b6O6bHWWTFLCBALOoRPwHKekSWBLJfQ=;
 b=EY2DT3iogj/8NgWw5TzmXqwaqSwqTEn1FnyGze/gjrpXm1Byf3w/HQrlbeIxRELeM3
 F/I/Bxr39oy/CTdKOLifQrO0O51EC/fbeChNl5J38ugA+NXhOsOMa0flVxuiRjqc/o+8
 hgTV5Dbry7wncBqVcoZE/PWhZALLZtkB5TokGBRqbKNtcxQK84nPAO3F6d0LVFQ5KQy2
 HIoJmnSQkFUjM+VN9zSvOA+eQ/SLUI4qssyVvPOR7C3YioenR7nuFft3X0NHLskC0ULo
 ldVbCM60QcOsVJxWOHSF42XPn4iXCqHjS8mJNrcih4TorUJ0OHE91cQCrDm2jidQKGkv
 LpZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1726029186; x=1726633986;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=YcUwxdhEJk5+b6O6bHWWTFLCBALOoRPwHKekSWBLJfQ=;
 b=a+aWKeAOKhZxhKD1LSNva9cELRciyj+lev66pZkTfr7e2kur4uABRBQ0HPthdTedfO
 RrB7o7i59Lv7QTwKbH1As+ywxk6tXPwpYqdlWCHyWB6/X5LYbPP7DIjqsRVL1kV69DsR
 f6+hST7bQaOWb6SssdmWCv9N9z5awQtUvCTcrvUDgjsS4yku75gUr42a83dWWyXODscE
 YqW2Vb/pNKE66bFfPeNkVb0JF3nzJD9zs3nZhFVt3QzJMZL3aEHCQltYm2AUWx2Fbd8V
 T6CR1xs0HxX2U2Gu6fqgBil4BDzbNtyfW5ntG36ibBY6NyI0vjkx2GAg2K3F+dswYXAb
 AqlA==
X-Gm-Message-State: AOJu0Yxd5QQDS0oo7tl5clWZTJGavgSt3LaC2zLPr3qJAmJLHaL1IZaS
 7aVZ5e8BtiOpR4V5VrgslGQ53p2mjlK4509jgC3B+OT1caCC9kkQHEymDa/6Szk=
X-Google-Smtp-Source: AGHT+IE/oy91I9NnW8KOAwzV4S3xUuX7XYtPLejJooQCzAjCb1tfx4f4PEP/zZAuY2FmW5epY+mRzw==
X-Received: by 2002:a17:902:f648:b0:206:a1ea:f4fe with SMTP id
 d9443c01a7336-2074c4afc77mr44005135ad.10.1726029185759; 
 Tue, 10 Sep 2024 21:33:05 -0700 (PDT)
Received: from jacob-pop23u.lan ([2600:1700:88b2:a50:6e2b:9045:bc15:3220])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-20710f32611sm55228285ad.270.2024.09.10.21.33.04
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 10 Sep 2024 21:33:04 -0700 (PDT)
From: Jacob Abrams <satur9nine@gmail.com>
To: qemu-devel@nongnu.org
Cc: philmd@linaro.org, peter.maydell@linaro.org,
 Jacob Abrams <satur9nine@gmail.com>
Subject: [PATCH] hw/char/stm32l4x5_usart.c: Enable USART ACK bit response
Date: Tue, 10 Sep 2024 21:32:55 -0700
Message-ID: <20240911043255.51966-1-satur9nine@gmail.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::534;
 envelope-from=satur9nine@gmail.com; helo=mail-pg1-x534.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 T_SPF_TEMPERROR=0.01 autolearn=ham autolearn_force=no
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

SW modifying USART_CR1 TE bit should cuase HW to respond by altering
USART_ISR TEACK bit, and likewise for RE and REACK bit.

This resolves some but not all issues necessary for the official STM USART
HAL driver to function as is.

Fixes: 87b77e6e01ca ("hw/char/stm32l4x5_usart: Enable serial read and write")
Resolves: https://gitlab.com/qemu-project/qemu/-/issues/2540
Signed-off-by: Jacob Abrams <satur9nine@gmail.com>
---
 hw/char/stm32l4x5_usart.c          | 16 +++++++++++++
 tests/qtest/stm32l4x5_usart-test.c | 36 +++++++++++++++++++++++++++++-
 2 files changed, 51 insertions(+), 1 deletion(-)

diff --git a/hw/char/stm32l4x5_usart.c b/hw/char/stm32l4x5_usart.c
index fc5dcac0c4..3cf200c080 100644
--- a/hw/char/stm32l4x5_usart.c
+++ b/hw/char/stm32l4x5_usart.c
@@ -154,6 +154,21 @@ REG32(RDR, 0x24)
 REG32(TDR, 0x28)
     FIELD(TDR, TDR, 0, 9)
 
+static void stm32l4x5_update_isr(Stm32l4x5UsartBaseState *s)
+{
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
@@ -456,6 +471,7 @@ static void stm32l4x5_usart_base_write(void *opaque, hwaddr addr,
     case A_CR1:
         s->cr1 = value;
         stm32l4x5_update_params(s);
+        stm32l4x5_update_isr(s);
         stm32l4x5_update_irq(s);
         return;
     case A_CR2:
diff --git a/tests/qtest/stm32l4x5_usart-test.c b/tests/qtest/stm32l4x5_usart-test.c
index c175ff3064..64cebda60f 100644
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
@@ -298,6 +300,37 @@ static void test_send_str(void)
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
@@ -310,6 +343,7 @@ int main(int argc, char **argv)
     qtest_add_func("stm32l4x5/usart/send_char", test_send_char);
     qtest_add_func("stm32l4x5/usart/receive_str", test_receive_str);
     qtest_add_func("stm32l4x5/usart/send_str", test_send_str);
+    qtest_add_func("stm32l4x5/usart/ack", test_ack);
     ret = g_test_run();
 
     return ret;
-- 
2.43.0


