Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 51685CCD184
	for <qemu-devel@archiver.kernel.org>; Wed, 15 Oct 2025 01:19:56 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v8qA9-0000RD-6k; Tue, 14 Oct 2025 21:18:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from
 <3b_buaAkKCmYPMbMEScERKSSKPI.GSQUIQY-HIZIPRSRKRY.SVK@flex--lixiaoyan.bounces.google.com>)
 id 1v8qA8-0000Q9-4j
 for qemu-devel@nongnu.org; Tue, 14 Oct 2025 21:18:44 -0400
Received: from mail-pj1-x1049.google.com ([2607:f8b0:4864:20::1049])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from
 <3b_buaAkKCmYPMbMEScERKSSKPI.GSQUIQY-HIZIPRSRKRY.SVK@flex--lixiaoyan.bounces.google.com>)
 id 1v8qA6-0003DB-BM
 for qemu-devel@nongnu.org; Tue, 14 Oct 2025 21:18:43 -0400
Received: by mail-pj1-x1049.google.com with SMTP id
 98e67ed59e1d1-33428befd39so22936813a91.0
 for <qemu-devel@nongnu.org>; Tue, 14 Oct 2025 18:18:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=google.com; s=20230601; t=1760491119; x=1761095919; darn=nongnu.org;
 h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
 :date:from:to:cc:subject:date:message-id:reply-to;
 bh=tFcrpMNqUzSK5xY1pNPFjqerwuvA1GbCVm02DaoYGWw=;
 b=Dhg7rMZniMNCdmiLpWuOYbbQ1V6hAftFwweWxGzonOKqOV+kX/1MDiZeGpYslRn12f
 HrQ7elrVlPQqhFVoNQlLDd6XM0NdMDyu8qcPwbrX4BpCRYViX6kea3VRiI2EcSwwRi7O
 Aye07CgUS9RSe80SIqppN5vohke74yzMxdpAna8uNHMJDejUN6ARtDh2IbHLSQHqujzd
 1HSfajy4HlRti6Dqfq9aOhslycSfjoXGSl2UvCq8uambVKUWVzCoW10UaN6SfeSwhbvS
 dHqDjCjtnVHcDNjJYoCh7vNpT5AqC05dw2Mkn+XJLh0jTmruFJ4e0p+HYpf1EITjHVFB
 Jbyw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1760491119; x=1761095919;
 h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
 :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=tFcrpMNqUzSK5xY1pNPFjqerwuvA1GbCVm02DaoYGWw=;
 b=sHMoUmo6UtBpfouuyqY1lwOSnUKXy0Bx5UW3ehnLJFUrQC1Z0xgu7sj4TfJKly+s32
 Ddow55f1Z8t8tbU1DOrm+RbTLZxYQ/eLstr/3ywXJluvzqaxTqI16mu86rh46UI4ykJG
 66s7DTp7yDRXSbi5eapE0zl3JKtiSyjSaCcCINz4w+VGX2ADNKM9y/MA8LGuKARzD6Gv
 TxVHqej3SCtVZTiH7GYaKYXsUseWFDTdqA/0MZ5V2Ort+ktXg89ZKzwwtYBF+K/UGaeM
 UqzDhAopQBGRp0B91h3gt17G7bwAERjcvgzH+VWoZXoiUs4Gy8dDsdvN77EcZg0ks1e3
 iYLQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCWcXFjPPhTg2EYjpR+9vD5kzm0QgBgMZF4hkUD4BlqnQWpSvyJINZr31vnrImJea4bhUL5Fw5ugYF30@nongnu.org
X-Gm-Message-State: AOJu0Yyr6/EacfY5q2Hde1pTQG8Xq7qqumB+Y7Ksn7zBWYpN7zscxFXW
 M2nOOpsnl6IqeHzxhPr+LzNt+G8cy5TZ6lowNLbtAGHo/7/yoI0iBFg6CdLxwyjlyoja+GvJPO2
 E3hbvplHQBeb3PlWR6g==
X-Google-Smtp-Source: AGHT+IFZhDR+vh+kuynIcVAxf3GbvjB/ncgWkyQSmW0gDVUzvv6yS2h499GC8W5hXkls5C1vc5Jx5D8QVwS7qww=
X-Received: from pjblt11.prod.google.com ([2002:a17:90b:354b:b0:33b:51fe:1a8d])
 (user=lixiaoyan job=prod-delivery.src-stubby-dispatcher) by
 2002:a17:90b:1648:b0:32e:e18a:368c with SMTP id
 98e67ed59e1d1-33b51106a8emr38759811a91.7.1760491119120; 
 Tue, 14 Oct 2025 18:18:39 -0700 (PDT)
Date: Wed, 15 Oct 2025 01:18:27 +0000
In-Reply-To: <20251015011830.1688468-1-lixiaoyan@google.com>
Mime-Version: 1.0
References: <20251015011830.1688468-1-lixiaoyan@google.com>
X-Mailer: git-send-email 2.51.0.788.g6d19910ace-goog
Message-ID: <20251015011830.1688468-4-lixiaoyan@google.com>
Subject: [PATCH v2 3/5] hw/arm/npcm8xx.c: Add all IRQ ENUMs
From: Coco Li <lixiaoyan@google.com>
To: peter.maydell@linaro.org, clg@kaod.org
Cc: qemu-arm@nongnu.org, qemu-devel@nongnu.org, lixiaoyan@google.com, 
 flwu@google.com, andrew@codeconstruct.com.au, philmd@linaro.org, 
 Hao Wu <wuhaotsh@google.com>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::1049;
 envelope-from=3b_buaAkKCmYPMbMEScERKSSKPI.GSQUIQY-HIZIPRSRKRY.SVK@flex--lixiaoyan.bounces.google.com;
 helo=mail-pj1-x1049.google.com
X-Spam_score_int: -88
X-Spam_score: -8.9
X-Spam_bar: --------
X-Spam_report: (-8.9 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_MED=-0.269,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 HK_RANDOM_FROM=0.998, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001, UPPERCASE_50_75=0.008,
 USER_IN_DEF_DKIM_WL=-7.5 autolearn=no autolearn_force=no
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
2.51.0.788.g6d19910ace-goog


