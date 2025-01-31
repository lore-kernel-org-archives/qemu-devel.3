Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3D046C0218F
	for <qemu-devel@archiver.kernel.org>; Fri, 31 Jan 2025 21:09:26 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tdyDh-00077o-CT; Fri, 31 Jan 2025 16:06:33 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tdyDf-00070h-GW
 for qemu-devel@nongnu.org; Fri, 31 Jan 2025 16:06:31 -0500
Received: from mail-wm1-x333.google.com ([2a00:1450:4864:20::333])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tdyDd-0007rd-RY
 for qemu-devel@nongnu.org; Fri, 31 Jan 2025 16:06:31 -0500
Received: by mail-wm1-x333.google.com with SMTP id
 5b1f17b1804b1-436a03197b2so16990725e9.2
 for <qemu-devel@nongnu.org>; Fri, 31 Jan 2025 13:06:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1738357588; x=1738962388; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=I05cOzS+i3UJgRm0Kn/FK0GGIAGJGVFzC35zyMSTnLU=;
 b=e1+FBAS+wfTEu4p2spqz2avwT+6XCfGxer7wf/n14Cw4rvUk/ZJyQem4Oj4ppPSXA2
 0KCe6d42KJwbcXpClF/cUQ9ssFBohKTojFYIaBol8UjvxxTtH9I2Y6dTHruVIeWhXUTD
 fKZWD4PXY+rMv53VOKknmNHssSFPg3k2GNwdA+0uouAt4DkuDmPqwgqYQ96UUw7Nlktp
 BPcU7XrR5EgLH25okkZ08LMnWVvrofNxEoa4oSpkqOm6kcLe/3FNTP6yqlgZx6UGsnGj
 K4SgIsKnz4FEAio2SYcgWoEpNt3q4vCEWzNpiGuLPQJjbU7S3pWrVKG7C3nlM1G6j9b7
 OHwA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1738357588; x=1738962388;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=I05cOzS+i3UJgRm0Kn/FK0GGIAGJGVFzC35zyMSTnLU=;
 b=SmewEdAM+pGnEDXkdHKMnJZ0nLoaE7RCXgLSC1GJYpVHINkUVKgLmh7/t/Xm16PeuW
 XPOvBohiMZ0soPiEM5VN/tGbaxQWnBLRBuCjubjvx+sbJS6D5WyJKekoWkIXJ295EDk0
 CjhS9oOGCDwPPA6y11hG9MRkncBZJDrTdTzBI2Nml9oamcAbPPIYUP/QVnybyVz4EvDW
 ixl9aTtT9IXYthXinOjhAOVbfkItdjHSdTr3Eoz6HuOFolSiBxc1gTNkG2jkL2m58ySv
 d8VX0vSrkt02cxdkv8XjcIMSX0NLf0pjVoJwwDn/VC5ToaAsrfi8fyiPR5PaSA0VFshy
 hUGg==
X-Gm-Message-State: AOJu0YyHUCCOX3ysV36nutqU0TSxwhOJOBzzRYTAkWVEqaL6U4ATuE1h
 XWfgrDz9Zc8KYx4bGEbFwZBqQM6JP1m74nAW+wAqsQLeJ7o1tNjk7I0BZJ7tt8yDvdOo9s+AVpY
 z6TE=
X-Gm-Gg: ASbGncs7EvHcg54yLwjdJ9xOES7J1B1iVpDIsUpkiclGaIO68q9G8PsnWutq5M+b+ee
 2Q2BRx9RbBJEzx60bzAqngQaFNJAqYrXHd9prHbn2qWNIJi4ONQlPbzAzEPsMuQ1Or8AHNjLLtt
 jpsZstDRRZNNCX/FeSgbMj1E+biyqkOQBOEledxq6A/BsYOpF7Pc8c41PhXvBVDIAhii06rHW1i
 0h1AQbJPUqTv9qr35eZ8E7Ktmt10SeP2OkFRtxMTg8NJPdM71TGdn8f2PIRb+vZpBDMAMIBuBZB
 WvjxnHxIOQtaAZqDFqQTQAvWEGDWFUb3wGOJWmsP5AK03qj8xvrRJOlUH9nSocRBRw==
X-Google-Smtp-Source: AGHT+IGPsdlmXiLGajme3lFITzwINgbO2o7QdPF0oLssVMOAihevY5MAaFQDfh/lUJ0YY4H+eJVYWQ==
X-Received: by 2002:a05:600c:c17:b0:436:51bb:7a52 with SMTP id
 5b1f17b1804b1-438dc3bd7e3mr120375475e9.7.1738357586309; 
 Fri, 31 Jan 2025 13:06:26 -0800 (PST)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-438d7aa605asm87406915e9.1.2025.01.31.13.06.25
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Fri, 31 Jan 2025 13:06:25 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Bernhard Beschow <shentey@gmail.com>,
 Richard Henderson <richard.henderson@linaro.org>
Subject: [PULL 13/36] hw/irq: Introduce qemu_init_irqs() helper
Date: Fri, 31 Jan 2025 22:04:56 +0100
Message-ID: <20250131210520.85874-14-philmd@linaro.org>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250131210520.85874-1-philmd@linaro.org>
References: <20250131210520.85874-1-philmd@linaro.org>
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
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Message-Id: <20250121155526.29982-2-philmd@linaro.org>
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


