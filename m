Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 40852CA1012
	for <qemu-devel@archiver.kernel.org>; Wed,  3 Sep 2025 22:22:28 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1utvrG-0005Dq-Vl; Wed, 03 Sep 2025 18:21:39 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from
 <3TLW4aAkKCuUSPePHVfHUNVVNSL.JVTXLTb-KLcLSUVUNUb.VYN@flex--lixiaoyan.bounces.google.com>)
 id 1utvBQ-0005k0-1i
 for qemu-devel@nongnu.org; Wed, 03 Sep 2025 17:38:24 -0400
Received: from mail-yb1-xb49.google.com ([2607:f8b0:4864:20::b49])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from
 <3TLW4aAkKCuUSPePHVfHUNVVNSL.JVTXLTb-KLcLSUVUNUb.VYN@flex--lixiaoyan.bounces.google.com>)
 id 1utvBO-0003TW-Il
 for qemu-devel@nongnu.org; Wed, 03 Sep 2025 17:38:23 -0400
Received: by mail-yb1-xb49.google.com with SMTP id
 3f1490d57ef6-e9d6c0373a7so297123276.2
 for <qemu-devel@nongnu.org>; Wed, 03 Sep 2025 14:38:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=google.com; s=20230601; t=1756935501; x=1757540301; darn=nongnu.org;
 h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
 :date:from:to:cc:subject:date:message-id:reply-to;
 bh=X5hS1tZ22zNRIVkY1EfuAvsxIjxJYrjbWB6arPiOJWo=;
 b=zHGJ8itsOg1Au+KLlraW8NUUpcjNwsT7g9XCZpLV19rOXDH8VzBGFZSROaGoPSJyfJ
 kxJ/GgBIZUJ+eEoNpoGSAxjGShxoqhaKn+xkGOBB7abhV1Y+Tc2NuCZX6AC/ymKpi89o
 GJyInSKvJ4lhxkgK0dncs6+hA+OJ4AiNRP1bOCpf0vL8ZoJF2P+6ljQMIJBCLEBo3IId
 bF0uBJsTahPgYv5KnzLaaVWKD6zYvNuQSHKZaUVIAU9SqW4Y/WKPeL4P9Yf2HFZVzg21
 yTvsixe1aOR/oLcQVSQIEJ3mAY5J3g8wmYx7Z7xYhSukMSvanFluKuW0jL5QTjBLhd20
 bmYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1756935501; x=1757540301;
 h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
 :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=X5hS1tZ22zNRIVkY1EfuAvsxIjxJYrjbWB6arPiOJWo=;
 b=hon835L8OWkJ4Ut5L44ZKQuFLgeem2FlFmIYJHkK2Hm4dcWCScA7CFvKWU/xHG9KoJ
 dAH3WNOF0vwvL7TNetvP0CeE3MBcoj2cdXNbzUgDO5TzHYlBFVgxCCu/0qyWjcZK4ogy
 yiDvARGIaCTl5zK7ks9KXjA3mDUOepmEVGlgCfZ4OtUkJzZcNK16mtXotlq5fNPVdAS7
 HCcEF3G/vRv4DYJyBepItcRWwhCHgogurm0FEwpNqCzAkjr8qFboLQZ2/KaniyoMhZsc
 0xievBXQ4cDwtywzTXt+vR8nlbuV8Tli1oQ7ljHPLX+Lcw0VpiF39ofB95u0B2tjnLN/
 sBsw==
X-Forwarded-Encrypted: i=1;
 AJvYcCVpXs5rTNnBIIpcAHjj57G+A9khgxNrj+GPrXJ3C27SUNbIcXDGvaB0Zn90s7I6StvSDCBod9Eysukr@nongnu.org
X-Gm-Message-State: AOJu0YwUhtzm7F9WQb+sHVDNvERZphg+R8RijazyGgL7hfkGdA+hJoj7
 9T5qTCZPT+lAjhbLWq7WqSzJSKMDLKX/qpFHTmuizc5XhKiPEZ1Vv1fVz0fq5wl2Vb5UjTQJKK7
 Acob/t7Quw5qFTGBV6g==
X-Google-Smtp-Source: AGHT+IH20bEt+lOXFlacb73BNjN3iG6qx3SuvvCV81+aK3lDiMZblYU8I9joK91/dKCzOzCRs4ptqRWaDsgvKFU=
X-Received: from ybiv44.prod.google.com ([2002:a25:abaf:0:b0:e96:dd0e:6347])
 (user=lixiaoyan job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:6902:1004:b0:e9d:6a31:d514 with SMTP id
 3f1490d57ef6-e9d6a31dacemr1383224276.44.1756935500853; 
 Wed, 03 Sep 2025 14:38:20 -0700 (PDT)
Date: Wed,  3 Sep 2025 21:38:07 +0000
In-Reply-To: <20250903213809.3779860-1-lixiaoyan@google.com>
Mime-Version: 1.0
References: <20250903213809.3779860-1-lixiaoyan@google.com>
X-Mailer: git-send-email 2.51.0.338.gd7d06c2dae-goog
Message-ID: <20250903213809.3779860-4-lixiaoyan@google.com>
Subject: [PATCH 3/5] hw/arm/npcm8xx.c: Add all IRQ ENUMs
From: Coco Li <lixiaoyan@google.com>
To: peter.maydell@linaro.org, clg@kaod.org
Cc: qemu-arm@nongnu.org, qemu-devel@nongnu.org, Coco Li <lixiaoyan@google.com>,
 Hao Wu <wuhaotsh@google.com>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::b49;
 envelope-from=3TLW4aAkKCuUSPePHVfHUNVVNSL.JVTXLTb-KLcLSUVUNUb.VYN@flex--lixiaoyan.bounces.google.com;
 helo=mail-yb1-xb49.google.com
X-Spam_score_int: -86
X-Spam_score: -8.7
X-Spam_bar: --------
X-Spam_report: (-8.7 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_MED=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 HK_RANDOM_FROM=0.938, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001, UPPERCASE_50_75=0.008,
 USER_IN_DEF_DKIM_WL=-7.5 autolearn=no autolearn_force=no
X-Spam_action: no action
X-Mailman-Approved-At: Wed, 03 Sep 2025 18:21:28 -0400
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

In the process of implementing serial gpio and adding the corresponding
ENUMs, also complete the list for npcm8xx.

Signed-off-by: Coco Li <lixiaoyan@google.com>
Reviewed-by: Hao Wu <wuhaotsh@google.com>
---
 hw/arm/npcm8xx.c | 43 ++++++++++++++++++++++++++++++++++++++++++-
 1 file changed, 42 insertions(+), 1 deletion(-)

diff --git a/hw/arm/npcm8xx.c b/hw/arm/npcm8xx.c
index a276fea698..10887d07fa 100644
--- a/hw/arm/npcm8xx.c
+++ b/hw/arm/npcm8xx.c
@@ -92,8 +92,14 @@ enum NPCM8xxInterrupt {
     NPCM8XX_GMAC2_IRQ,
     NPCM8XX_GMAC3_IRQ,
     NPCM8XX_GMAC4_IRQ,
-    NPCM8XX_MMC_IRQ             = 26,
+    NPCM8XX_ESPI_IRQ,
+    NPCM8XX_SIOX0_IRQ,
+    NPCM8XX_SIOX1_IRQ,
+    NPCM8XX_MC_IRQ              = 25,
+    NPCM8XX_MMC_IRQ,
     NPCM8XX_PSPI_IRQ            = 28,
+    NPCM8XX_VDMA_IRQ,
+    NPCM8XX_MCTP_IRQ,
     NPCM8XX_TIMER0_IRQ          = 32,   /* Timer Module 0 */
     NPCM8XX_TIMER1_IRQ,
     NPCM8XX_TIMER2_IRQ,
@@ -116,6 +122,14 @@ enum NPCM8xxInterrupt {
     NPCM8XX_OHCI1_IRQ,
     NPCM8XX_EHCI2_IRQ,
     NPCM8XX_OHCI2_IRQ,
+    NPCM8XX_SPI1_IRQ            = 82,
+    NPCM8XX_RNG_IRQ             = 84,
+    NPCM8XX_SPI0_IRQ            = 85,
+    NPCM8XX_SPI3_IRQ            = 87,
+    NPCM8XX_GDMA0_IRQ           = 88,
+    NPCM8XX_GDMA1_IRQ,
+    NPCM8XX_GDMA2_IRQ,
+    NPCM8XX_OTP_IRQ             = 92,
     NPCM8XX_PWM0_IRQ            = 93,   /* PWM module 0 */
     NPCM8XX_PWM1_IRQ,                   /* PWM module 1 */
     NPCM8XX_MFT0_IRQ            = 96,   /* MFT module 0 */
@@ -128,6 +142,11 @@ enum NPCM8xxInterrupt {
     NPCM8XX_MFT7_IRQ,                   /* MFT module 7 */
     NPCM8XX_PCI_MBOX1_IRQ       = 105,
     NPCM8XX_PCI_MBOX2_IRQ,
+    NPCM8XX_GPIO231_IRQ         = 108,
+    NPCM8XX_GPIO233_IRQ,
+    NPCM8XX_GPIO234_IRQ,
+    NPCM8XX_GPIO93_IRQ,
+    NPCM8XX_GPIO94_IRQ,
     NPCM8XX_GPIO0_IRQ           = 116,
     NPCM8XX_GPIO1_IRQ,
     NPCM8XX_GPIO2_IRQ,
@@ -163,6 +182,12 @@ enum NPCM8xxInterrupt {
     NPCM8XX_SMBUS24_IRQ,
     NPCM8XX_SMBUS25_IRQ,
     NPCM8XX_SMBUS26_IRQ,
+    NPCM8XX_FLM0_IRQ            = 160,
+    NPCM8XX_FLM1_IRQ,
+    NPCM8XX_FLM2_IRQ,
+    NPCM8XX_FLM3_IRQ,
+    NPCM8XX_JMT1_IRQ            = 188,
+    NPCM8XX_JMT2_IRQ,
     NPCM8XX_UART0_IRQ           = 192,
     NPCM8XX_UART1_IRQ,
     NPCM8XX_UART2_IRQ,
@@ -170,6 +195,22 @@ enum NPCM8xxInterrupt {
     NPCM8XX_UART4_IRQ,
     NPCM8XX_UART5_IRQ,
     NPCM8XX_UART6_IRQ,
+    NPCM8XX_I3C0_IRQ            = 224,
+    NPCM8XX_I3C1_IRQ,
+    NPCM8XX_I3C2_IRQ,
+    NPCM8XX_I3C3_IRQ,
+    NPCM8XX_I3C4_IRQ,
+    NPCM8XX_I3C5_IRQ,
+    NPCM8XX_A35INTERR_IRQ       = 240,
+    NPCM8XX_A35EXTERR_IRQ,
+    NPCM8XX_PMU0_IRQ,
+    NPCM8XX_PMU1_IRQ,
+    NPCM8XX_PMU2_IRQ,
+    NPCM8XX_PMU3_IRQ,
+    NPCM8XX_CTI0_IRQ,
+    NPCM8XX_CTI1_IRQ,
+    NPCM8XX_CTI2_IRQ,
+    NPCM8XX_CTI3_IRQ,
 };
 
 /* Total number of GIC interrupts, including internal Cortex-A35 interrupts. */
-- 
2.51.0.338.gd7d06c2dae-goog


