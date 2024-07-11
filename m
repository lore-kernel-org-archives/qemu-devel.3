Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B76E5C3DA4A
	for <qemu-devel@archiver.kernel.org>; Thu, 11 Jul 2024 13:22:22 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sRthG-0001hK-Cc; Thu, 11 Jul 2024 09:18:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1sRth7-0001Ca-Ta
 for qemu-devel@nongnu.org; Thu, 11 Jul 2024 09:18:46 -0400
Received: from mail-wm1-x332.google.com ([2a00:1450:4864:20::332])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1sRth6-000642-32
 for qemu-devel@nongnu.org; Thu, 11 Jul 2024 09:18:45 -0400
Received: by mail-wm1-x332.google.com with SMTP id
 5b1f17b1804b1-42122ac2f38so5480515e9.1
 for <qemu-devel@nongnu.org>; Thu, 11 Jul 2024 06:18:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1720703913; x=1721308713; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=QR2NXELLGLvw8JsL5lqZLeeutghLd/fRnYWQHU0+2J4=;
 b=Z7PjmKNGkm427d83zFkxUnWOp02sJRTfdsRY8Q8RbkgkyVbPPCw6zS/iFZZAz5vgxh
 jKh6LRgRzudbA3z8JYCArbszXM979p7wIFaG6vEsYtORk2t37qgxFA6LLFTYRo9vcqXf
 b9JMTMibbOFdwG5vLjGNZZLBu9C6ymuZ2UhjIxoLo32KzwFDxX1qhGwava5rTihRzCWQ
 6oqQeB7hnsQwrbOCXUbOeuUszhk9ft1QgSPhD+9b6MQgwK6jaQNZUrgKPxjGat8Zbl1z
 sXLcR/1Y12JRzWIRqK13dgZ8pzqquwS6BMCiNCzMrKXD2yPBJmylzAejtI/lgRSIndbC
 8BNg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1720703913; x=1721308713;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=QR2NXELLGLvw8JsL5lqZLeeutghLd/fRnYWQHU0+2J4=;
 b=H0Pio1d/xKKEjHAStvY5BKU9gazYdhEkQ7aFZ9a/VFVJMJiL5TqJtwo3bQrc8KhClC
 z01Kz6+YSWkMkHltKpYWxcBluQMFFdF8YXPWxTQaaYobU4cywTm+/i3QGKasTn+UrQKk
 bIv9ptZ88E8ptVCz5SsS4g9mG2Lb3U+3Tp6nlT2bvbyJcRzNthPp/7r7tyYGn8yiXa2i
 spXTq125Lw1ps7lIX9onb5kxhakpUT2VZCbWwVUSm12UCyXneY0BKJo1vkTUBiRmUOpb
 h1794Z3RCrI2OASt6UqTjCnpX3AyV0hHqxRK+RhaNAClM556TOeJfe5CnLcVN6dU3cjj
 +rjw==
X-Gm-Message-State: AOJu0YxAAA4X1SUaFeWhUczcCHpBr9KclAOrIQh80Q7U2Yw80GTGmNwo
 YRKS9wGtho8IM5bEDZr8/Kf4kZKf7KYtTEM6ve8HQ9uLX0stWz1XDmjJjZms59bGzh3MwacTJKD
 9kMs=
X-Google-Smtp-Source: AGHT+IGdaIIvkGyrIbpDccFeeWR0e+pKOZHY2qeh+IFQy7WabksA8OKWVNsG7wvdxCi9/VWFyKX9ig==
X-Received: by 2002:a05:600c:1d24:b0:426:698b:791f with SMTP id
 5b1f17b1804b1-427981b2287mr23138165e9.3.1720703913021; 
 Thu, 11 Jul 2024 06:18:33 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [2001:8b0:1d0::2])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4266f736939sm119412025e9.37.2024.07.11.06.18.32
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 11 Jul 2024 06:18:32 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 17/24] hw/misc: In STM32L4x5 EXTI, handle direct interrupts
Date: Thu, 11 Jul 2024 14:18:15 +0100
Message-Id: <20240711131822.3909903-18-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240711131822.3909903-1-peter.maydell@linaro.org>
References: <20240711131822.3909903-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::332;
 envelope-from=peter.maydell@linaro.org; helo=mail-wm1-x332.google.com
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

The previous implementation for EXTI interrupts only handled
"configurable" interrupts, like those originating from STM32L4x5 SYSCFG
(the only device currently connected to the EXTI up until now).

In order to connect STM32L4x5 USART to the EXTI, this commit adds
handling for direct interrupts (interrupts without configurable edge).

Signed-off-by: Inès Varhol <ines.varhol@telecom-paris.fr>
Message-id: 20240707085927.122867-3-ines.varhol@telecom-paris.fr
Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 hw/misc/stm32l4x5_exti.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/hw/misc/stm32l4x5_exti.c b/hw/misc/stm32l4x5_exti.c
index b9a69a69f60..e281841dcf4 100644
--- a/hw/misc/stm32l4x5_exti.c
+++ b/hw/misc/stm32l4x5_exti.c
@@ -113,6 +113,13 @@ static void stm32l4x5_exti_set_irq(void *opaque, int irq, int level)
         return;
     }
 
+    /* In case of a direct line interrupt */
+    if (extract32(exti_romask[bank], irq, 1)) {
+        qemu_set_irq(s->irq[oirq], level);
+        return;
+    }
+
+    /* In case of a configurable interrupt */
     if ((level && extract32(s->rtsr[bank], irq, 1)) ||
         (!level && extract32(s->ftsr[bank], irq, 1))) {
 
-- 
2.34.1


