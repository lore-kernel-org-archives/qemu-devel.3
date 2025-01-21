Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DB38EC02182
	for <qemu-devel@archiver.kernel.org>; Tue, 21 Jan 2025 15:55:55 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1taGbS-0003tp-GF; Tue, 21 Jan 2025 10:55:47 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1taGbM-0003n8-DZ
 for qemu-devel@nongnu.org; Tue, 21 Jan 2025 10:55:42 -0500
Received: from mail-wm1-x333.google.com ([2a00:1450:4864:20::333])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1taGbH-0001w8-Je
 for qemu-devel@nongnu.org; Tue, 21 Jan 2025 10:55:40 -0500
Received: by mail-wm1-x333.google.com with SMTP id
 5b1f17b1804b1-43626213fffso42696205e9.1
 for <qemu-devel@nongnu.org>; Tue, 21 Jan 2025 07:55:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1737474933; x=1738079733; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=h7fX1pHLOdoQX1u1iC7jxTdcN+u9AigZsBxvTYyjuig=;
 b=L11HTGcnKtJIMr8rPxNiiozYUppvarUrm1suTswWy6CieDtEzULf3iIG2Ojv20oJ5M
 EPDvAwWAV66pAG0GjyclLwpN6Z0qXisuVeqTYpTdqn9fbsVPP8+kSBz2xpexfQt9DIwt
 iyD/f+VZH2PTU3RZJVqRhktBip1zfn1YfoLPqwjgow+OqVUUnp/dSAiynEYN/sfjainQ
 Zw8BHsN21nmVHJfIw9VL+/I1RHl8lNIYDTgg5s7S36mjhbYH5sahnTqbxQ2Pu4P8ldzw
 Ysb5/5LJk47d4h8Zz3dSNfOlnSaDHRBm10/88LrS0+jpGHOBre+0luk2VzK66U+UGioh
 4++Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1737474933; x=1738079733;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=h7fX1pHLOdoQX1u1iC7jxTdcN+u9AigZsBxvTYyjuig=;
 b=v28SorcAN9gpwEyBsZuDux+xJy6T2xcndukN9OC/UCHc7gN65rag0s1xRvT8Lycl+Q
 hVTYI6GIFUYa4SXKO/5UOu4R9TQxTseCSb2l5+RbuceW0nySZO6nZ0lVxLTIoBBbndP7
 Jm5wzJ07vjdlXCkb2o4/XuYDYzErBRvFV0SfmjL1iNyZoULeOfref7u8M9PcHCRgsSUk
 YAXaUsGBrdws/+gU+TAUrYwZeXZ7MdS+N9alzxFWeZZV9ylK7jRZVVjPfFucZzDRUWCH
 cB3lHpdvzZE3rLITEOQiYlbDg98RVuyDl1C0jmDiqbdiUKNcYF/BzgBnphrmBCrt1cw8
 R65w==
X-Gm-Message-State: AOJu0Yz4FDiWucE3FZb8B4yOcMMszQuwrg+nj2b9ueIn7i1GrK+TU0bM
 hLll53Aqvr1T0ERx7a144NzOujog82g6+ER6iK9gDU0CelMmn5hSoFvmqkn1mOSrpBakXiKsTut
 ixFo=
X-Gm-Gg: ASbGnctiC60TtGX5PF5+7HTr8NjaRIE4VSRrPpG3guLqlFBzhYdFUxCGRTotA13ckX9
 xqncDtF4K0bfjdNztSbfZkDStMj4Y+g2FtB4Ra8xcxrg0DH0aJTAwxXXZjiWok7iIyzZB5oeo48
 xFGhbFVS46BEvp7ZBdNZSWSLfulylv26iprWQtXiUOpbdTSBjndF1ieQTZwFjrydoJtej/DIczb
 WHb9ttEpnWglHp18p6aoYcijRE2/yf3yuUAO/m+gL2dBHH4LTDz/U4f6Kdrmq2aAs9rhwZWo32n
 DY79XFOzYxzLRIgiByAGWx98O3Jj/ikDsrWM+2qzjpB1
X-Google-Smtp-Source: AGHT+IEhtYhnc9mq8r6kBZyWT6ZDmAUTw04hfLhqW4O6uQ9MyR99pKL58IxS2XkVIw/X5SzHZ/v+kw==
X-Received: by 2002:adf:9dce:0:b0:38a:88bc:aea6 with SMTP id
 ffacd0b85a97d-38bec4f592amr15248853f8f.6.1737474932698; 
 Tue, 21 Jan 2025 07:55:32 -0800 (PST)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-38bf322ac88sm14052137f8f.54.2025.01.21.07.55.31
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Tue, 21 Jan 2025 07:55:32 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Alberto Garcia <berto@igalia.com>, Bernhard Beschow <shentey@gmail.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH v3 1/3] hw/irq: Introduce qemu_init_irqs() helper
Date: Tue, 21 Jan 2025 16:55:24 +0100
Message-ID: <20250121155526.29982-2-philmd@linaro.org>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250121155526.29982-1-philmd@linaro.org>
References: <20250121155526.29982-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::333;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x333.google.com
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

While qemu_init_irq() initialize a single IRQ,
qemu_init_irqs() initialize an array of them.

Suggested-by: Bernhard Beschow <shentey@gmail.com>
Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 include/hw/irq.h | 11 +++++++++++
 hw/core/irq.c    |  8 ++++++++
 2 files changed, 19 insertions(+)

diff --git a/include/hw/irq.h b/include/hw/irq.h
index c861c1debda..b3012237acd 100644
--- a/include/hw/irq.h
+++ b/include/hw/irq.h
@@ -41,6 +41,17 @@ static inline void qemu_irq_pulse(qemu_irq irq)
 void qemu_init_irq(IRQState *irq, qemu_irq_handler handler, void *opaque,
                    int n);
 
+/**
+ * qemu_init_irqs: Initialize an array of IRQs.
+ *
+ * @irq: Array of IRQs to initialize
+ * @count: number of IRQs to initialize
+ * @handler: handler to assign to each IRQ
+ * @opaque: opaque data to pass to @handler
+ */
+void qemu_init_irqs(IRQState irq[], size_t count,
+                    qemu_irq_handler handler, void *opaque);
+
 /* Returns an array of N IRQs. Each IRQ is assigned the argument handler and
  * opaque data.
  */
diff --git a/hw/core/irq.c b/hw/core/irq.c
index 7d5b0038c12..6dd8d47bd6e 100644
--- a/hw/core/irq.c
+++ b/hw/core/irq.c
@@ -49,6 +49,14 @@ void qemu_init_irq(IRQState *irq, qemu_irq_handler handler, void *opaque,
     init_irq_fields(irq, handler, opaque, n);
 }
 
+void qemu_init_irqs(IRQState irq[], size_t count,
+                    qemu_irq_handler handler, void *opaque)
+{
+    for (size_t i = 0; i < count; i++) {
+        qemu_init_irq(&irq[i], handler, opaque, i);
+    }
+}
+
 qemu_irq *qemu_extend_irqs(qemu_irq *old, int n_old, qemu_irq_handler handler,
                            void *opaque, int n)
 {
-- 
2.47.1


