Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 87432CAC5AE
	for <qemu-devel@archiver.kernel.org>; Thu, 25 Sep 2025 01:00:53 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v1aK5-0001na-Tj; Wed, 24 Sep 2025 20:59:01 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from
 <3wZPUaAkKCogxu9um0Amzs00sxq.o0y2qy6-pq7qxz0zsz6.03s@flex--lixiaoyan.bounces.google.com>)
 id 1v1aK3-0001mt-SF
 for qemu-devel@nongnu.org; Wed, 24 Sep 2025 20:59:00 -0400
Received: from mail-pj1-x104a.google.com ([2607:f8b0:4864:20::104a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from
 <3wZPUaAkKCogxu9um0Amzs00sxq.o0y2qy6-pq7qxz0zsz6.03s@flex--lixiaoyan.bounces.google.com>)
 id 1v1aJt-0004nD-Hm
 for qemu-devel@nongnu.org; Wed, 24 Sep 2025 20:58:58 -0400
Received: by mail-pj1-x104a.google.com with SMTP id
 98e67ed59e1d1-32eae48beaaso364901a91.0
 for <qemu-devel@nongnu.org>; Wed, 24 Sep 2025 17:58:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=google.com; s=20230601; t=1758761921; x=1759366721; darn=nongnu.org;
 h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
 :date:from:to:cc:subject:date:message-id:reply-to;
 bh=wya99TQHepjllZHYg3chFlfHlvWpGiWN+a2T8JQ02C0=;
 b=y7IPdqvTacY5WedXeNXF61LjHCwawsnSOXaK1rJenxKhCbYv+QPkXVoaM3h/2InIhV
 5Bkp/8zBF9Wu0LrqaILM6IsMrvzI/g3x7ESNGq/HQxhEpmy4WvUr7LZ+9cOO74ZMeh1E
 AVkr/nF3wpOiL6QNN2pa9e4xOZiVh/Pj0JyzcTmSaD5j382lHfe4M/PTSq9O8iLNkLX3
 CBFc4xjM9RgQorrwzWHWxrnE49g6nkEkyaDO1mYpqIoYsykMPAMa2RyY28Qn9qAiMDcZ
 GGthUFwuK6wpOBhGyy2p0lxFK2FHoBlGjX+pI+dwAM7q8j95lExQzQrqVVv93sxx55F3
 OvvQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1758761921; x=1759366721;
 h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
 :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=wya99TQHepjllZHYg3chFlfHlvWpGiWN+a2T8JQ02C0=;
 b=RXHn+SeVjgfOAC+Ojjv8YzxZsadga2/eWeezPGuFvDBQcogTKxn6eMq3w/kLYrcaZl
 uRHjhOa9deeyv8cC5lochK2xuWb/E0+cNPn4WgisEGBQszRFjgwHN8sF9Q1vhSaj8feb
 rAgv5lSbF8no4yJIZxTjif+rbTfoTWWmD5F3VZDXBT9JC4BzDhLZAbfuYqD6wDu4VLUe
 JAzz2C6BD2xC6w9z4yTWrekDaKM+PM1PHASZpwfK2HbS2UHgadlgwZdpg+sNksPMTLce
 JMQEfaZINYRXKy8b1eCc8zO94Njw38Vk+NmYlWBfYxPizbx7efltQxnPg662rjUbKuMX
 sbqQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCX1gAl5+0ssJ0R4gwAyvkd9uSmHmYB53vr937ql4s3N5GsAV3lxMJmbICyXj80JGUVaZvq9XVPCqnmc@nongnu.org
X-Gm-Message-State: AOJu0Yyij1m4wLZTn6ZBmCOvTkb4/dEjP51FTW48yo0h33LgWaESJFOS
 ixuvPn2gzBB6VsSMQ+yF3yiJQL5kkUK91Orwd/Mn8CTBzoT/bygwzu2IW3zM1C2EtGmEuJwCgTQ
 ZmntaWBoFfFPGEtw2wA==
X-Google-Smtp-Source: AGHT+IHCYsOlyBzJTBP5k0mS8oNBvgkV4CfV75lBGVnNid6o8lA/mBSMk0qPpw1KGeA3uzJWx7IuVVVAzgcBV/g=
X-Received: from pjnu2.prod.google.com ([2002:a17:90a:8902:b0:32d:e096:fcd5])
 (user=lixiaoyan job=prod-delivery.src-stubby-dispatcher) by
 2002:a17:903:110e:b0:271:b6b3:71ef with SMTP id
 d9443c01a7336-27ed4a471b4mr18227985ad.43.1758761921087; 
 Wed, 24 Sep 2025 17:58:41 -0700 (PDT)
Date: Thu, 25 Sep 2025 00:58:30 +0000
In-Reply-To: <20250925005832.3708492-1-lixiaoyan@google.com>
Mime-Version: 1.0
References: <20250925005832.3708492-1-lixiaoyan@google.com>
X-Mailer: git-send-email 2.51.0.536.g15c5d4f767-goog
Message-ID: <20250925005832.3708492-4-lixiaoyan@google.com>
Subject: [PATCH v1 3/5] hw/arm/npcm8xx.c: Add all IRQ ENUMs
From: Coco Li <lixiaoyan@google.com>
To: peter.maydell@linaro.org, clg@kaod.org
Cc: qemu-arm@nongnu.org, qemu-devel@nongnu.org, lixiaoyan@google.com, 
 flwu@google.com, andrew@codeconstruct.com.au, Hao Wu <wuhaotsh@google.com>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::104a;
 envelope-from=3wZPUaAkKCogxu9um0Amzs00sxq.o0y2qy6-pq7qxz0zsz6.03s@flex--lixiaoyan.bounces.google.com;
 helo=mail-pj1-x104a.google.com
X-Spam_score_int: -85
X-Spam_score: -8.6
X-Spam_bar: --------
X-Spam_report: (-8.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_MED=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 HK_RANDOM_FROM=0.999, RCVD_IN_DNSWL_NONE=-0.0001, SPF_PASS=-0.001,
 T_SPF_HELO_TEMPERROR=0.01, UPPERCASE_50_75=0.008,
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
2.51.0.536.g15c5d4f767-goog


