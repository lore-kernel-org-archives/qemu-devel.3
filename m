Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CC0B7C2BD09
	for <qemu-devel@archiver.kernel.org>; Mon,  1 Jul 2024 16:10:54 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sOJaR-0004ZF-M4; Mon, 01 Jul 2024 12:09:04 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1sOJZT-0001Sq-U8
 for qemu-devel@nongnu.org; Mon, 01 Jul 2024 12:08:04 -0400
Received: from mail-lj1-x22e.google.com ([2a00:1450:4864:20::22e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1sOJZD-0005Ue-Su
 for qemu-devel@nongnu.org; Mon, 01 Jul 2024 12:08:02 -0400
Received: by mail-lj1-x22e.google.com with SMTP id
 38308e7fff4ca-2ebe0a81dc8so43097791fa.2
 for <qemu-devel@nongnu.org>; Mon, 01 Jul 2024 09:07:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1719850066; x=1720454866; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=N665C21il6XnrjbsnfmTOCOC5JXdKF9F2qCwJefFlO8=;
 b=R2fbrwI+vkCAAZm783gpexVetFxqoTxj+IbPbL+QUZjJTXHrPANpccl/kBKQwPw35b
 UPywK4o6fhy1XnEMwWSMa9q2qxJpfpuo3cnbowLDNjrL3mjyMXnjaQVEF/GidEfUgQN7
 e1LvhuKP4kfKd5y45Q27u1gzExPLATFuayl2t6ulXviSVBJb2laZ2ehRX8GCfVPPo54o
 UeLtiHdt93YJfk9dGe/NM9JPuyU3SgbU1m457y2CNY9lHqD6D0GRy9aF0Hhc1QljLfuh
 ctLoTiEdoZMUMnQ1dt72J8UdsQ0uuh8K//h0GdGffYT1bZ8dhpPaU0v7B3TbvzyF364C
 MJ0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1719850066; x=1720454866;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=N665C21il6XnrjbsnfmTOCOC5JXdKF9F2qCwJefFlO8=;
 b=rAKdvM/l7LdndZXeuaQTrHPcUD5oAutnKwyLVmiag3t2/JiodtDThQhWanS8sFf9AQ
 JvB1BHM/f3l/HJ57+P/RPmxRcErzX/PRhC6WxR+fGnDwyXdIhllCi8QHPuDTvRX3lEwZ
 /t71p6rwE1DfFs4MVf7Kutmsj/17JOq7uoNE79U94B9ByPr7gCejACrejifs3H/IHPnd
 LoSlLyXMbPXC9RqVNH/oO4yQb+//AlAfarWPmVjJau1i/MVMMsCORZnW9cZ7WzsFjzQx
 VP1XL4rJCyYHHb5148f0wFaMcxg4pvwjqoqqt+NobVR7+ow1++QBANsbG8wXfg8pym1r
 uf7A==
X-Gm-Message-State: AOJu0Ywt1qEHz2oajNMFctdjjGvyRJVzpTNUWeDy00KY5CgUBmaZWrvv
 axfqk338vMoNq3MhRq9/QraQPdxLY4Se7FL3agZcxJD+qSz/5C+C23hUi0gRSdLxlJlHfkHMh5l
 BgoA=
X-Google-Smtp-Source: AGHT+IHOQ6ZRPPIHNm3q0WpCK/yEj8VkODkukv1bUr+Atj4S+cuZBgMLFktOhMWC+EmDC2Omo1y9qQ==
X-Received: by 2002:a05:6512:12cc:b0:52d:a55b:fa9d with SMTP id
 2adb3069b0e04-52e8268cf32mr4519273e87.38.1719850064107; 
 Mon, 01 Jul 2024 09:07:44 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [2001:8b0:1d0::2])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4256af557fesm161952135e9.11.2024.07.01.09.07.43
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 01 Jul 2024 09:07:43 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 27/29] tests/qtest: Fix STM32L4x5 SYSCFG irq line 15 state
 assumption
Date: Mon,  1 Jul 2024 17:07:27 +0100
Message-Id: <20240701160729.1910763-28-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240701160729.1910763-1-peter.maydell@linaro.org>
References: <20240701160729.1910763-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::22e;
 envelope-from=peter.maydell@linaro.org; helo=mail-lj1-x22e.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_NONE=0.001,
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

The QTest `test_irq_pin_multiplexer` makes the assumption that the
reset state of irq line 15 is low, which is false since STM32L4x5 GPIO
was implemented (the reset state of pin GPIOA15 is high because there's
pull-up and it results in the irq line 15 also being high at reset).

It wasn't triggering an error because `test_interrupt` was mistakenly
"resetting" the line low.

This commit corrects these two mistakes by :
- not setting the line low in `test_interrupt`
- using an irq line in `test_irq_pin_multiplexer` which is low at reset

Signed-off-by: Inès Varhol <ines.varhol@telecom-paris.fr>
Message-id: 20240629104454.366283-1-ines.varhol@telecom-paris.fr
Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 tests/qtest/stm32l4x5_syscfg-test.c | 14 +++++++-------
 1 file changed, 7 insertions(+), 7 deletions(-)

diff --git a/tests/qtest/stm32l4x5_syscfg-test.c b/tests/qtest/stm32l4x5_syscfg-test.c
index 506ca08bc24..1cdf8f05c80 100644
--- a/tests/qtest/stm32l4x5_syscfg-test.c
+++ b/tests/qtest/stm32l4x5_syscfg-test.c
@@ -223,7 +223,7 @@ static void test_interrupt(void)
     /* Clean the test */
     syscfg_writel(SYSCFG_EXTICR1, 0x00000000);
     syscfg_set_irq(0, 0);
-    syscfg_set_irq(15, 0);
+    /* irq 15 is high at reset because GPIOA15 is high at reset */
     syscfg_set_irq(17, 0);
 }
 
@@ -237,21 +237,21 @@ static void test_irq_pin_multiplexer(void)
 
     syscfg_set_irq(0, 1);
 
-    /* Check that irq 0 was set and irq 15 wasn't */
+    /* Check that irq 0 was set and irq 2 wasn't */
     g_assert_true(get_irq(0));
-    g_assert_false(get_irq(15));
+    g_assert_false(get_irq(2));
 
     /* Clean the test */
     syscfg_set_irq(0, 0);
 
-    syscfg_set_irq(15, 1);
+    syscfg_set_irq(2, 1);
 
-    /* Check that irq 15 was set and irq 0 wasn't */
-    g_assert_true(get_irq(15));
+    /* Check that irq 2 was set and irq 0 wasn't */
+    g_assert_true(get_irq(2));
     g_assert_false(get_irq(0));
 
     /* Clean the test */
-    syscfg_set_irq(15, 0);
+    syscfg_set_irq(2, 0);
 }
 
 static void test_irq_gpio_multiplexer(void)
-- 
2.34.1


