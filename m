Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DC345C3065A
	for <qemu-devel@archiver.kernel.org>; Mon,  1 Jul 2024 16:09:42 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sOJZk-0001rE-2M; Mon, 01 Jul 2024 12:08:21 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1sOJZI-0000wj-5U
 for qemu-devel@nongnu.org; Mon, 01 Jul 2024 12:07:54 -0400
Received: from mail-wm1-x32d.google.com ([2a00:1450:4864:20::32d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1sOJZE-0005V6-DM
 for qemu-devel@nongnu.org; Mon, 01 Jul 2024 12:07:51 -0400
Received: by mail-wm1-x32d.google.com with SMTP id
 5b1f17b1804b1-424a3ccd0c0so23522725e9.1
 for <qemu-devel@nongnu.org>; Mon, 01 Jul 2024 09:07:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1719850067; x=1720454867; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=jDxsxwb6wke90AJTR7bX+v27HwUxef5Wp/hVnhRyzbY=;
 b=WVRt26Jwrr5RVBjnVcHP0r2HRnMgK2xzX66Hw+dlMB3IGXxebtC86e7NVjudUe7nP/
 DBBgSvCsE7GBCOM3r8q1er3p7KkMzLeeHOUH1VImAo2eNVGvd40Uyt416Cz7+DMCbOZR
 i0yrJNBpnMsuPCTdZVtfqKDy5hKBNnojlrNwoqNaww0C/TIyV4jZxW58QpTZa1anXalj
 njdiLfGAwh58q/ymBobhuw7DefXyvZ7tvhHh4Igd+1RnYu6KT4fC8VDcQiZXb2Oi8LhI
 NTaMVYWw66OwhfPcrOAVcOAK/bOhTn5renqIzfdIPiOJCHzotAxbTvyWF4vi1MOQsBYn
 3tWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1719850067; x=1720454867;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=jDxsxwb6wke90AJTR7bX+v27HwUxef5Wp/hVnhRyzbY=;
 b=bcR8am2+50IGCXHVGnNfgEwFODTBu4hlR43cReDAqAgbqSfypPaD2aomcrxceGoKr+
 XPCRa03vkL4g1xvcWLfvewxLclGxAtk7BzNV9vGh41KlgaavSvdkt//m93tgluXPb8qB
 cmoSGukTjq93UiCp02w94qXbfH4pYO/9mvGef2AyomDaRvk4nT9JYKYlq9GTqfkW9/BK
 itRKEQjNuKJ1TpDWP0Ty5vyLKZ3SRKyQozzX2p/5JS/TaY7W3c27ykS9vro6Sg4Il6ij
 G6vp4tNw5149jXoPwz4Eu7NViCC0IyK2XF5l2f5NHCef0aSWlowGw3D4fx8iz0QmTTYQ
 7H2g==
X-Gm-Message-State: AOJu0Yz8McT3TIXNe+DEgqgV3Sr++6QObkqlb3Fd2BwdNjXIx9vPIN2c
 qG5TGm3Ywfx1hcyeyLxwGJo21PjTfb1MOAN9yONDdoG2zAAIXIh+xey2Yy5HGmije4LQCD5F0KR
 gL9E=
X-Google-Smtp-Source: AGHT+IGsuKXI3YaXResEN87ED5WxbotncR7N7Zq1ktyaNgcBXHIXtK2IWJ9jKerW5exS0q3GhioWyQ==
X-Received: by 2002:a05:600c:6a8d:b0:425:77b4:366d with SMTP id
 5b1f17b1804b1-4257a02f3f6mr41316475e9.11.1719850067025; 
 Mon, 01 Jul 2024 09:07:47 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [2001:8b0:1d0::2])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4256af557fesm161952135e9.11.2024.07.01.09.07.46
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 01 Jul 2024 09:07:46 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 29/29] tests/qtest: Ensure STM32L4x5 EXTI state is correct at
 the end of QTests
Date: Mon,  1 Jul 2024 17:07:29 +0100
Message-Id: <20240701160729.1910763-30-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240701160729.1910763-1-peter.maydell@linaro.org>
References: <20240701160729.1910763-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32d;
 envelope-from=peter.maydell@linaro.org; helo=mail-wm1-x32d.google.com
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

From: Inès Varhol <ines.varhol@telecom-paris.fr>

EXTI's new field `irq_levels` tracks irq levels between tests when using
`global_qtest`.
This happens in `stm32l4x5_exti-test.c`, `stm32l4x5_syscfg-test.c` and
`stm32l4x5_gpio-test.c` (`dm163.c` doesn't use `global_qtest`).

To ensure that `irq_levels` has the same value before and after each
QTest, this commit toggles back the irq lines that were changed at the
end of each problematic test. Most QTests were already doing this.

Signed-off-by: Inès Varhol <ines.varhol@telecom-paris.fr>
Message-id: 20240629110800.539969-3-ines.varhol@telecom-paris.fr
Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 tests/qtest/stm32l4x5_exti-test.c   | 8 ++++++++
 tests/qtest/stm32l4x5_syscfg-test.c | 2 +-
 2 files changed, 9 insertions(+), 1 deletion(-)

diff --git a/tests/qtest/stm32l4x5_exti-test.c b/tests/qtest/stm32l4x5_exti-test.c
index 7092860b9b7..7e39c992fd3 100644
--- a/tests/qtest/stm32l4x5_exti-test.c
+++ b/tests/qtest/stm32l4x5_exti-test.c
@@ -448,6 +448,9 @@ static void test_masked_interrupt(void)
     g_assert_cmphex(exti_readl(EXTI_PR1), ==, 0x00000000);
     /* Check that the interrupt isn't pending in NVIC */
     g_assert_false(check_nvic_pending(EXTI1_IRQ));
+
+    /* Clean EXTI */
+    exti_set_irq(1, 0);
 }
 
 static void test_interrupt(void)
@@ -498,6 +501,9 @@ static void test_interrupt(void)
     /* Clean NVIC */
     unpend_nvic_irq(EXTI1_IRQ);
     g_assert_false(check_nvic_pending(EXTI1_IRQ));
+
+    /* Clean EXTI */
+    exti_set_irq(1, 0);
 }
 
 static void test_orred_interrupts(void)
@@ -531,6 +537,8 @@ static void test_orred_interrupts(void)
 
         unpend_nvic_irq(EXTI5_9_IRQ);
         g_assert_false(check_nvic_pending(EXTI5_9_IRQ));
+
+        exti_set_irq(i, 0);
     }
 }
 
diff --git a/tests/qtest/stm32l4x5_syscfg-test.c b/tests/qtest/stm32l4x5_syscfg-test.c
index 1cdf8f05c80..258417cd889 100644
--- a/tests/qtest/stm32l4x5_syscfg-test.c
+++ b/tests/qtest/stm32l4x5_syscfg-test.c
@@ -221,10 +221,10 @@ static void test_interrupt(void)
     g_assert_true(get_irq(1));
 
     /* Clean the test */
-    syscfg_writel(SYSCFG_EXTICR1, 0x00000000);
     syscfg_set_irq(0, 0);
     /* irq 15 is high at reset because GPIOA15 is high at reset */
     syscfg_set_irq(17, 0);
+    syscfg_writel(SYSCFG_EXTICR1, 0x00000000);
 }
 
 static void test_irq_pin_multiplexer(void)
-- 
2.34.1


