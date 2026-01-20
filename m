Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 94F6DD26289
	for <qemu-devel@archiver.kernel.org>; Tue, 20 Jan 2026 18:41:36 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1viGf0-0001rm-KH; Tue, 20 Jan 2026 13:41:02 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1viGef-0001aJ-1N
 for qemu-devel@nongnu.org; Tue, 20 Jan 2026 13:40:42 -0500
Received: from mail-wr1-x430.google.com ([2a00:1450:4864:20::430])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1viGec-0006L6-7K
 for qemu-devel@nongnu.org; Tue, 20 Jan 2026 13:40:39 -0500
Received: by mail-wr1-x430.google.com with SMTP id
 ffacd0b85a97d-43596062728so79635f8f.1
 for <qemu-devel@nongnu.org>; Tue, 20 Jan 2026 10:40:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1768934436; x=1769539236; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=g2CdOzO4uzMuyL3eUd9Xq4lX5VlpfqF563IVR0wUOKc=;
 b=lRw8RMRtX73qGmiqzipqTRqiUaP1040I3S7WintEseBY+t+twHDvmgiHRnfljXLyeW
 pomnMRGXZrSGBSELNFpiTGIafs/pRh+bru/hgjpUb8kS81FHHCkSz9sVFoGrMGax+PZc
 xtLU+FwGbI0B27JoeDln1AP/nlUsxQtHvRDiESHyhhY6K/7a9ChqyDr03Pi4+xzmWSM5
 ZFsAtxUE6vmsUMHC13eW0yU0NeqrflETit0DF1qI/IQ58oklsRd57v7fAJYGAUWjE13k
 N7F191Y5RRWiDFxVUr8hHckEYSYNY9orETbdjnsPKReWNVMsgqK2UJZJB0sYUlpWpbbZ
 /VZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1768934436; x=1769539236;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=g2CdOzO4uzMuyL3eUd9Xq4lX5VlpfqF563IVR0wUOKc=;
 b=F5Xih8dJJtIh/SB1HMh/WmuT6FMRMPGs7MUbq7GDtN2oErneAug5zUPz4Rqo9HfTco
 kjiNDMYj/3frIOKRzlcqaElCq+YFd9BIMRCIr0aGHMuQ/Q/wW4a62hyHBmCZlnVBBS84
 GnJeSpPP7YUphnQ31Mzz0b1JQQOsRHlXuoyeszpUYCitBxY4q/UCr2KIx1859TsB4J8X
 zeTBYSzhiBWCV5HhRB51FFTxlYhbOm74aeSH2gf0ftruLAZyTAu0HJ1v627OtoNK7Yy7
 1F/kZgLSy8wwVuw0b2o7jwIU4lroHwEfOZv/ShaVMsJfoMzvFkxXqtXjdff5v8GF5nLn
 Uc9Q==
X-Gm-Message-State: AOJu0YydPs49Bq+t+E2P/lEsdS35VxE7Lfr6JdBo2v1fjRKycMbWW/Fi
 rHZmN8arJZEYk3LASlP9A1JXU9obBbQJsoxGE00usocavIqvcmBi2Fu7ZsLF/YVJe7m6xzpXqLQ
 yw4muNKk=
X-Gm-Gg: AZuq6aI3JsuiZ40rxIEgOdBwwponPJSpypvbloX81EM8sx15TVgLsVtBRXBLQcCV1nw
 r/3fe8gcR+nGQq4V9PFFqqkgtsttCj/HQ3vNISFIkBAfxZoqHEKw3pP54fNHyk+KwhExmddX/2f
 0SK7hEm6vP3EJTnLC/ZtlPAHwgzWXY2OkqB3Jxuj7kP5bSixnWLiz9m5wRKS0eckwFLtmbmcukH
 He+rFVuybTd19Esm9ZzH8VfKPlYcsCE7S1cQlC+/TE56hPFg9DmgVig/lRQzVyxmCx7PjdbTwuL
 wXHgbqgvcDwKd3CIy35xXxcL6j/batoDHkKsUgBsCWyRCOSCfdpwkZCh71CwwvAVDzLfTP7/uFJ
 8RtRfTqtLPAzhGd+7JTn2aV/i2v/A+klh6tqJVOfRjR2bUHzRIw21jaKyLdwGV2+izJ8ciEP1TX
 bxHyLKAHNXSfmp45TYFG7n57qPrNlelXv8tjPKny7w8L8I9njjuVA4to2wSvBY
X-Received: by 2002:a5d:588c:0:b0:432:c0b8:ee42 with SMTP id
 ffacd0b85a97d-434d7553187mr30023517f8f.11.1768934436253; 
 Tue, 20 Jan 2026 10:40:36 -0800 (PST)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-4356997e6dasm31430283f8f.32.2026.01.20.10.40.35
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Tue, 20 Jan 2026 10:40:35 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 13/29] Revert "hw/sd/sdhci: Rename ESDHC_* defines to USDHC_*"
Date: Tue, 20 Jan 2026 19:38:46 +0100
Message-ID: <20260120183902.73845-14-philmd@linaro.org>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260120183902.73845-1-philmd@linaro.org>
References: <20260120183902.73845-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::430;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x430.google.com
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
List-Id: qemu development <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

From: Bernhard Beschow <shentey@gmail.com>

This reverts commit 1e76667f7adf48c6c3596aaa26b8886b57b8498d.

Unaware that the constants were named after Linux and U-Boot code,
commit 1e76667f7adf ("hw/sd/sdhci: Rename ESDHC_* defines to USDHC_*")
changed the naming to be consistent with the function names. Fix the
constant naming to be consistent with Linux and U-Boot again. In the
next step, the function names will be renamed according to Linux and
U-Boot code as well.

Signed-off-by: Bernhard Beschow <shentey@gmail.com>
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Tested-by: BALATON Zoltan <balaton@eik.bme.hu>
Message-ID: <20260112145418.220506-6-shentey@gmail.com>
Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 hw/sd/sdhci.c | 66 +++++++++++++++++++++++++--------------------------
 1 file changed, 33 insertions(+), 33 deletions(-)

diff --git a/hw/sd/sdhci.c b/hw/sd/sdhci.c
index 23d8f7cbc8d..ccdfc59af85 100644
--- a/hw/sd/sdhci.c
+++ b/hw/sd/sdhci.c
@@ -1639,24 +1639,24 @@ static void sdhci_bus_class_init(ObjectClass *klass, const void *data)
 
 /* --- qdev i.MX eSDHC --- */
 
-#define USDHC_MIX_CTRL                  0x48
+#define ESDHC_MIX_CTRL                  0x48
 
-#define USDHC_VENDOR_SPEC               0xc0
-#define USDHC_IMX_FRC_SDCLK_ON          (1 << 8)
+#define ESDHC_VENDOR_SPEC               0xc0
+#define ESDHC_IMX_FRC_SDCLK_ON          (1 << 8)
 
-#define USDHC_DLL_CTRL                  0x60
+#define ESDHC_DLL_CTRL                  0x60
 
-#define USDHC_TUNING_CTRL               0xcc
-#define USDHC_TUNE_CTRL_STATUS          0x68
-#define USDHC_WTMK_LVL                  0x44
+#define ESDHC_TUNING_CTRL               0xcc
+#define ESDHC_TUNE_CTRL_STATUS          0x68
+#define ESDHC_WTMK_LVL                  0x44
 
 /* Undocumented register used by guests working around erratum ERR004536 */
-#define USDHC_UNDOCUMENTED_REG27        0x6c
+#define ESDHC_UNDOCUMENTED_REG27        0x6c
 
-#define USDHC_CTRL_4BITBUS              (0x1 << 1)
-#define USDHC_CTRL_8BITBUS              (0x2 << 1)
+#define ESDHC_CTRL_4BITBUS              (0x1 << 1)
+#define ESDHC_CTRL_8BITBUS              (0x2 << 1)
 
-#define USDHC_PRNSTS_SDSTB              (1 << 3)
+#define ESDHC_PRNSTS_SDSTB              (1 << 3)
 
 static uint64_t usdhc_read(void *opaque, hwaddr offset, unsigned size)
 {
@@ -1677,11 +1677,11 @@ static uint64_t usdhc_read(void *opaque, hwaddr offset, unsigned size)
         hostctl1 = SDHC_DMA_TYPE(s->hostctl1) << (8 - 3);
 
         if (s->hostctl1 & SDHC_CTRL_8BITBUS) {
-            hostctl1 |= USDHC_CTRL_8BITBUS;
+            hostctl1 |= ESDHC_CTRL_8BITBUS;
         }
 
         if (s->hostctl1 & SDHC_CTRL_4BITBUS) {
-            hostctl1 |= USDHC_CTRL_4BITBUS;
+            hostctl1 |= ESDHC_CTRL_4BITBUS;
         }
 
         ret  = hostctl1;
@@ -1692,21 +1692,21 @@ static uint64_t usdhc_read(void *opaque, hwaddr offset, unsigned size)
 
     case SDHC_PRNSTS:
         /* Add SDSTB (SD Clock Stable) bit to PRNSTS */
-        ret = sdhci_read(opaque, offset, size) & ~USDHC_PRNSTS_SDSTB;
+        ret = sdhci_read(opaque, offset, size) & ~ESDHC_PRNSTS_SDSTB;
         if (s->clkcon & SDHC_CLOCK_INT_STABLE) {
-            ret |= USDHC_PRNSTS_SDSTB;
+            ret |= ESDHC_PRNSTS_SDSTB;
         }
         break;
 
-    case USDHC_VENDOR_SPEC:
+    case ESDHC_VENDOR_SPEC:
         ret = s->vendor_spec;
         break;
-    case USDHC_DLL_CTRL:
-    case USDHC_TUNE_CTRL_STATUS:
-    case USDHC_UNDOCUMENTED_REG27:
-    case USDHC_TUNING_CTRL:
-    case USDHC_MIX_CTRL:
-    case USDHC_WTMK_LVL:
+    case ESDHC_DLL_CTRL:
+    case ESDHC_TUNE_CTRL_STATUS:
+    case ESDHC_UNDOCUMENTED_REG27:
+    case ESDHC_TUNING_CTRL:
+    case ESDHC_MIX_CTRL:
+    case ESDHC_WTMK_LVL:
         ret = 0;
         break;
     }
@@ -1722,16 +1722,16 @@ usdhc_write(void *opaque, hwaddr offset, uint64_t val, unsigned size)
     uint32_t value = (uint32_t)val;
 
     switch (offset) {
-    case USDHC_DLL_CTRL:
-    case USDHC_TUNE_CTRL_STATUS:
-    case USDHC_UNDOCUMENTED_REG27:
-    case USDHC_TUNING_CTRL:
-    case USDHC_WTMK_LVL:
+    case ESDHC_DLL_CTRL:
+    case ESDHC_TUNE_CTRL_STATUS:
+    case ESDHC_UNDOCUMENTED_REG27:
+    case ESDHC_TUNING_CTRL:
+    case ESDHC_WTMK_LVL:
         break;
 
-    case USDHC_VENDOR_SPEC:
+    case ESDHC_VENDOR_SPEC:
         s->vendor_spec = value;
-        if (value & USDHC_IMX_FRC_SDCLK_ON) {
+        if (value & ESDHC_IMX_FRC_SDCLK_ON) {
             s->prnsts &= ~SDHC_IMX_CLOCK_GATE_OFF;
         } else {
             s->prnsts |= SDHC_IMX_CLOCK_GATE_OFF;
@@ -1796,12 +1796,12 @@ usdhc_write(void *opaque, hwaddr offset, uint64_t val, unsigned size)
          * Second, split "Data Transfer Width" from bits 2 and 1 in to
          * bits 5 and 1
          */
-        if (value & USDHC_CTRL_8BITBUS) {
+        if (value & ESDHC_CTRL_8BITBUS) {
             hostctl1 |= SDHC_CTRL_8BITBUS;
         }
 
-        if (value & USDHC_CTRL_4BITBUS) {
-            hostctl1 |= USDHC_CTRL_4BITBUS;
+        if (value & ESDHC_CTRL_4BITBUS) {
+            hostctl1 |= ESDHC_CTRL_4BITBUS;
         }
 
         /*
@@ -1824,7 +1824,7 @@ usdhc_write(void *opaque, hwaddr offset, uint64_t val, unsigned size)
         sdhci_write(opaque, offset, value, size);
         break;
 
-    case USDHC_MIX_CTRL:
+    case ESDHC_MIX_CTRL:
         /*
          * So, when SD/MMC stack in Linux tries to write to "Transfer
          * Mode Register", ESDHC i.MX quirk code will translate it
-- 
2.52.0


