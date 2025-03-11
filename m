Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8AAFEC2BA1B
	for <qemu-devel@archiver.kernel.org>; Tue, 11 Mar 2025 19:54:40 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ts5ez-0008IR-KN; Tue, 11 Mar 2025 15:53:05 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1ts5eZ-0007ft-Fx
 for qemu-devel@nongnu.org; Tue, 11 Mar 2025 15:52:45 -0400
Received: from mail-wm1-x330.google.com ([2a00:1450:4864:20::330])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1ts5eW-0007fH-GR
 for qemu-devel@nongnu.org; Tue, 11 Mar 2025 15:52:38 -0400
Received: by mail-wm1-x330.google.com with SMTP id
 5b1f17b1804b1-43cf0d787eeso27868695e9.3
 for <qemu-devel@nongnu.org>; Tue, 11 Mar 2025 12:52:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1741722755; x=1742327555; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=kwsN7Sji2LRfEhBwDQKA18+pD8AQLk8f7ip/gMXP/tM=;
 b=vhEAMecQzVK/puRtCMHwWbV/qLAH+RNQsdNb7YP4UPJ1B625wepUcKj8F3lnNgLaTJ
 FzU2cr0NhGhyCj7n91kzVtFquIErpKm6VMu9XO4+rZ5kiPMfdZCKzdWSFaBrIhQeK8+4
 T5dDP+S2Axwy3HmO7YcZpnxlKuT35p+CtImiC3pWUfhNbZUi0+qSiYtIut+DcFGeuYpD
 pY51w3ePSqjmyLxKzAz2FnEq5Qp3/TAXFMJgaYo5u3V+I7b6vp8vZ+8tuXnRHw5pgBLO
 +lse8wKUnGtCwejlPwwjDuELPy748iY3nxwsbN5t9FHpUoCy+vSJcBKpe42oRseRziMY
 hbpA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1741722755; x=1742327555;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=kwsN7Sji2LRfEhBwDQKA18+pD8AQLk8f7ip/gMXP/tM=;
 b=WB1ZmJ9Q+Iy//JgrCy1raa0x9nQNcTc8ASj9YU4JGFwJsY0QivoyrIw2HDpOkHzI1f
 9jhJjPkunDcfnwN9yVasDEJAy/UaThl/47crnPdRIu/chey6A6mjY3g6vh+WFtOwN4H5
 8Ky3PD5QXVEJc1qgi0n7PAUKQ9bzmCFaeTFYzyTr0zAhaSh+nLJ22hh3f2JPSuGd1zAu
 8tYHNuyUFdKtUDXVrpKkY4Zen8OSJ0y/InzgQ+cUNKqHTQnXPSUtlja1y0diHlldoE7O
 wdzILF3j36W/JaAJOM83NwmfLGIWl8AkfnFp6L5ijU7OFl60mzhBXfqEfNSFdxAHDjOy
 L32Q==
X-Gm-Message-State: AOJu0Yw76lTxTYRBt0cJyADqApKW9gAyMJcK/3eVvFP9Kal7/umw7Jlz
 B1Io/6f7Jt2jXbbH8x9yVlrwjLGb319loZWtjTnQxPd9FBaHh1jjU9tvdPfiARHOm7fvLT+V+6R
 Budk=
X-Gm-Gg: ASbGncubv5GqD1kFXIoxBMPPCSvao1n4/QDYNhmXle3oay/fR8+MFJknb5CLgZfzSbt
 AQZJT6j4JMkBYYGUt+Dj2AIz5bic2w4VkWiURw4MhkbraMiu5Ghn3X/eGcJv6Dc7BhXRDqew1eE
 r9SYlPR88sLmXn9VU8QcqUG7y5Ul7NqCdGx5XUTRLSiiLP4jqeoQlgzkJiC7f3a1uzJwcJZw8O2
 OnRb9im3QJCPSAfizWcXv3H0ZCsOMh83O94D1P5clURaQBd3zn6sDeDuJv5BaV+l/r9pNtWuq5I
 irgkgGmiSq360izus8YbXztDmND+uKb2F2OFFu20K0aStzKe6uEKngrbuHq9s7FRcvzoc0BHOVw
 IOYIaLY7bH46C8kSSb1PwEYOvTLLkGA==
X-Google-Smtp-Source: AGHT+IFS/9OdBLdpWdhCU3iipASY/Z0xgSH+859lC6ak0eDn5qlrFANEtacj9ncqRS4WwV/Udiwmhg==
X-Received: by 2002:a05:600c:19c8:b0:43d:82c:2b23 with SMTP id
 5b1f17b1804b1-43d082c2db3mr21292695e9.23.1741722754721; 
 Tue, 11 Mar 2025 12:52:34 -0700 (PDT)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3912c102e01sm19501603f8f.93.2025.03.11.12.52.33
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Tue, 11 Mar 2025 12:52:33 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 BALATON Zoltan <balaton@eik.bme.hu>, Bernhard Beschow <shentey@gmail.com>
Subject: [PULL 14/14] hw/sd/sdhci: Remove need for SDHCI_VENDOR_FSL definition
Date: Tue, 11 Mar 2025 20:51:23 +0100
Message-ID: <20250311195123.94212-15-philmd@linaro.org>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250311195123.94212-1-philmd@linaro.org>
References: <20250311195123.94212-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::330;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x330.google.com
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

All instances of TYPE_IMX_USDHC set vendor=SDHCI_VENDOR_IMX.
No need to special-case it.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: BALATON Zoltan <balaton@eik.bme.hu>
Reviewed-by: Bernhard Beschow <shentey@gmail.com>
Message-Id: <20250308213640.13138-3-philmd@linaro.org>
---
 include/hw/sd/sdhci.h |  1 -
 hw/arm/fsl-imx25.c    |  2 --
 hw/arm/fsl-imx6.c     |  2 --
 hw/arm/fsl-imx6ul.c   |  2 --
 hw/arm/fsl-imx7.c     |  2 --
 hw/arm/fsl-imx8mp.c   |  2 --
 hw/sd/sdhci.c         | 14 ++++----------
 7 files changed, 4 insertions(+), 21 deletions(-)

diff --git a/include/hw/sd/sdhci.h b/include/hw/sd/sdhci.h
index f722d8eb1cc..51fb30ea528 100644
--- a/include/hw/sd/sdhci.h
+++ b/include/hw/sd/sdhci.h
@@ -109,7 +109,6 @@ struct SDHCIState {
 typedef struct SDHCIState SDHCIState;
 
 #define SDHCI_VENDOR_NONE       0
-#define SDHCI_VENDOR_IMX        1
 #define SDHCI_VENDOR_FSL        2
 
 /*
diff --git a/hw/arm/fsl-imx25.c b/hw/arm/fsl-imx25.c
index 5359a6d8d3b..02214ca1a1c 100644
--- a/hw/arm/fsl-imx25.c
+++ b/hw/arm/fsl-imx25.c
@@ -243,8 +243,6 @@ static void fsl_imx25_realize(DeviceState *dev, Error **errp)
                                  &error_abort);
         object_property_set_uint(OBJECT(&s->esdhc[i]), "capareg",
                                  IMX25_ESDHC_CAPABILITIES, &error_abort);
-        object_property_set_uint(OBJECT(&s->esdhc[i]), "vendor",
-                                 SDHCI_VENDOR_IMX, &error_abort);
         if (!sysbus_realize(SYS_BUS_DEVICE(&s->esdhc[i]), errp)) {
             return;
         }
diff --git a/hw/arm/fsl-imx6.c b/hw/arm/fsl-imx6.c
index dc86338b3a5..a114dc0d63d 100644
--- a/hw/arm/fsl-imx6.c
+++ b/hw/arm/fsl-imx6.c
@@ -327,8 +327,6 @@ static void fsl_imx6_realize(DeviceState *dev, Error **errp)
                                  &error_abort);
         object_property_set_uint(OBJECT(&s->esdhc[i]), "capareg",
                                  IMX6_ESDHC_CAPABILITIES, &error_abort);
-        object_property_set_uint(OBJECT(&s->esdhc[i]), "vendor",
-                                 SDHCI_VENDOR_IMX, &error_abort);
         if (!sysbus_realize(SYS_BUS_DEVICE(&s->esdhc[i]), errp)) {
             return;
         }
diff --git a/hw/arm/fsl-imx6ul.c b/hw/arm/fsl-imx6ul.c
index 34c4aa15cd0..ce8d3ef535f 100644
--- a/hw/arm/fsl-imx6ul.c
+++ b/hw/arm/fsl-imx6ul.c
@@ -531,8 +531,6 @@ static void fsl_imx6ul_realize(DeviceState *dev, Error **errp)
             FSL_IMX6UL_USDHC2_IRQ,
         };
 
-        object_property_set_uint(OBJECT(&s->usdhc[i]), "vendor",
-                                 SDHCI_VENDOR_IMX, &error_abort);
         sysbus_realize(SYS_BUS_DEVICE(&s->usdhc[i]), &error_abort);
 
         sysbus_mmio_map(SYS_BUS_DEVICE(&s->usdhc[i]), 0,
diff --git a/hw/arm/fsl-imx7.c b/hw/arm/fsl-imx7.c
index 3374018cde0..ed1f10bca26 100644
--- a/hw/arm/fsl-imx7.c
+++ b/hw/arm/fsl-imx7.c
@@ -471,8 +471,6 @@ static void fsl_imx7_realize(DeviceState *dev, Error **errp)
             FSL_IMX7_USDHC3_IRQ,
         };
 
-        object_property_set_uint(OBJECT(&s->usdhc[i]), "vendor",
-                                 SDHCI_VENDOR_IMX, &error_abort);
         sysbus_realize(SYS_BUS_DEVICE(&s->usdhc[i]), &error_abort);
 
         sysbus_mmio_map(SYS_BUS_DEVICE(&s->usdhc[i]), 0,
diff --git a/hw/arm/fsl-imx8mp.c b/hw/arm/fsl-imx8mp.c
index 1ea98e14635..c3f6da63220 100644
--- a/hw/arm/fsl-imx8mp.c
+++ b/hw/arm/fsl-imx8mp.c
@@ -524,8 +524,6 @@ static void fsl_imx8mp_realize(DeviceState *dev, Error **errp)
             { fsl_imx8mp_memmap[FSL_IMX8MP_USDHC3].addr, FSL_IMX8MP_USDHC3_IRQ },
         };
 
-        object_property_set_uint(OBJECT(&s->usdhc[i]), "vendor",
-                                 SDHCI_VENDOR_IMX, &error_abort);
         if (!sysbus_realize(SYS_BUS_DEVICE(&s->usdhc[i]), errp)) {
             return;
         }
diff --git a/hw/sd/sdhci.c b/hw/sd/sdhci.c
index fe87e18d5d2..69baf73ae9b 100644
--- a/hw/sd/sdhci.c
+++ b/hw/sd/sdhci.c
@@ -1735,16 +1735,10 @@ usdhc_write(void *opaque, hwaddr offset, uint64_t val, unsigned size)
 
     case USDHC_VENDOR_SPEC:
         s->vendor_spec = value;
-        switch (s->vendor) {
-        case SDHCI_VENDOR_IMX:
-            if (value & USDHC_IMX_FRC_SDCLK_ON) {
-                s->prnsts &= ~SDHC_IMX_CLOCK_GATE_OFF;
-            } else {
-                s->prnsts |= SDHC_IMX_CLOCK_GATE_OFF;
-            }
-            break;
-        default:
-            break;
+        if (value & USDHC_IMX_FRC_SDCLK_ON) {
+            s->prnsts &= ~SDHC_IMX_CLOCK_GATE_OFF;
+        } else {
+            s->prnsts |= SDHC_IMX_CLOCK_GATE_OFF;
         }
         break;
 
-- 
2.47.1


