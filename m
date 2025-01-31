Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 26A73C02195
	for <qemu-devel@archiver.kernel.org>; Fri, 31 Jan 2025 21:11:16 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tdyFN-0004WG-9l; Fri, 31 Jan 2025 16:08:17 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tdyEr-0003rF-LC
 for qemu-devel@nongnu.org; Fri, 31 Jan 2025 16:07:46 -0500
Received: from mail-wm1-x32f.google.com ([2a00:1450:4864:20::32f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tdyEp-000800-SF
 for qemu-devel@nongnu.org; Fri, 31 Jan 2025 16:07:45 -0500
Received: by mail-wm1-x32f.google.com with SMTP id
 5b1f17b1804b1-436326dcb1cso17109405e9.0
 for <qemu-devel@nongnu.org>; Fri, 31 Jan 2025 13:07:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1738357661; x=1738962461; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=9N3BSf00evn14ZysC8qEFhKlpze4TdqYVBorbd99L/M=;
 b=sdGyFc0CmYnQqi/Je3YzWxOIULzDfVU9t6pvwugIST4rLP+V0gKCqDTot0Fz+yolyZ
 Y+6PzScqHzYTE3e5zgHFHzOfLSaes14iHxdJClwrasLD02zn9ZZ/ygJ0Qez9JwniZdgx
 y8lQL6z2b39iuV5kCX5Ltg5KDla/Jzy5n4d745j/SQ89Sz/TFPaHRVu1WPImwl8Oyz8e
 9iqeiWHmiLXwjhGEN0pltcYdtVSzWQCP0uZeEyNUEdKVg3oEmsAA2+rTKyGR2ibfBx40
 gAvB+9BTSlaojWgnoLYG2t8ideKetJTxz45CsOByTBl/9djrhonOJEeVEHFqhqkEorUA
 nOsw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1738357661; x=1738962461;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=9N3BSf00evn14ZysC8qEFhKlpze4TdqYVBorbd99L/M=;
 b=PNApABcx1pHksLn1ghqBVzhMQlJ4TPR2aWDLWPfqtzscdm6rXLVFebxMXT8kjrweoq
 FRqlslGZZLaLnx/a9rKfzlboskcI5NEAdNx5mEgdEl47HqATponT9VLUojCEs0guAxPO
 hVa0bB91s+PM7P1P1JC5A7aGrpfLgxX+oY+YXOpkdRk0xIhW8OGhdZIREEDhdJHawYA9
 kx1sKQ4VXAbNQLJtewUr/ZSvbEwEMnzHOjz0Joh3HQi/1HDTQsOzR0FyWh+XH6uOnsyA
 jrVtB/TqYxE1OaM1yF844ymUriUrNuZ2qNwKBt6hH/ad1z46NRHZxfpTOVupqX9O+6Ne
 jnjQ==
X-Gm-Message-State: AOJu0Yw6P/BiUKuGrX3bdFVqaeHr3jzqpO0yJqgQO6SgfhTDysDVHEAW
 4mES14aB7p9RpGRryZiLXZ1DyxTklOGIA2WH2Om6oR/DEw5QAGpqALNWCvQMAg3GBuF3cMujsyH
 3Hz0=
X-Gm-Gg: ASbGnctnMPP/ynpsUVuxc3PBqLsS1yBjURnV2fqZPFv8r5SaMupvuk/IAG/raV6p1eK
 +RYVPHIetN1XAOKGU8C3PksxfFe7TYorpoYtyxtuGzoPwbDHa87xEg290Edre+YB89aaN5ZzLxs
 4073ob3A9+zGIofDA0TcbCJEMqqfHfLBQpCkSfjjkSIfvut0W/vRH6rZIYqulCaeIxCd1mO1F71
 ZV1Tq0FWZ6UHU0fKkskcyx1OxaqDwtYqsFquLfUu3sm5JpLe9eWdKJwKtDgkVQDrUzSV8TyAp2U
 U5Ln9bM5yHIdCI/XYb+y6x/QAAgudDBgxWqMiXVnqZf2apDfB9MXQwULGt8yRJGscw==
X-Google-Smtp-Source: AGHT+IFRST/9omdZJm2MHvHuuTxqfsIl7UbubeL0ZfHynfJ/kEb36QvOKpfLeLFbWOub4LA5fEkTGA==
X-Received: by 2002:a5d:5384:0:b0:38a:8ed1:c5c7 with SMTP id
 ffacd0b85a97d-38c520bdb45mr8449662f8f.46.1738357661386; 
 Fri, 31 Jan 2025 13:07:41 -0800 (PST)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-38c5c102bc0sm5656665f8f.35.2025.01.31.13.07.39
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Fri, 31 Jan 2025 13:07:40 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PULL 28/36] hw/sd/omap_mmc: Convert output qemu_irqs to gpio and
 sysbus IRQ APIs
Date: Fri, 31 Jan 2025 22:05:11 +0100
Message-ID: <20250131210520.85874-29-philmd@linaro.org>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250131210520.85874-1-philmd@linaro.org>
References: <20250131210520.85874-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32f;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x32f.google.com
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

From: Peter Maydell <peter.maydell@linaro.org>

The omap_mmc device has three outbound qemu_irq lines:
 * one actual interrupt line
 * two which connect to the DMA controller and are signalled for
   TX and RX DMA

Convert these to a sysbus IRQ and two named GPIO outputs.

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Message-ID: <20250128104519.3981448-4-peter.maydell@linaro.org>
Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 hw/sd/omap_mmc.c | 20 +++++++++++++-------
 1 file changed, 13 insertions(+), 7 deletions(-)

diff --git a/hw/sd/omap_mmc.c b/hw/sd/omap_mmc.c
index 0f17479ecb8..43203a76c58 100644
--- a/hw/sd/omap_mmc.c
+++ b/hw/sd/omap_mmc.c
@@ -31,7 +31,8 @@ typedef struct OMAPMMCState {
     SysBusDevice parent_obj;
 
     qemu_irq irq;
-    qemu_irq *dma;
+    qemu_irq dma_tx_gpio;
+    qemu_irq dma_rx_gpio;
     qemu_irq coverswitch;
     MemoryRegion iomem;
     omap_clk clk;
@@ -87,22 +88,22 @@ static void omap_mmc_fifolevel_update(OMAPMMCState *host)
     if (host->fifo_len > host->af_level && host->ddir) {
         if (host->rx_dma) {
             host->status &= 0xfbff;
-            qemu_irq_raise(host->dma[1]);
+            qemu_irq_raise(host->dma_rx_gpio);
         } else
             host->status |= 0x0400;
     } else {
         host->status &= 0xfbff;
-        qemu_irq_lower(host->dma[1]);
+        qemu_irq_lower(host->dma_rx_gpio);
     }
 
     if (host->fifo_len < host->ae_level && !host->ddir) {
         if (host->tx_dma) {
             host->status &= 0xf7ff;
-            qemu_irq_raise(host->dma[0]);
+            qemu_irq_raise(host->dma_tx_gpio);
         } else
             host->status |= 0x0800;
     } else {
-        qemu_irq_lower(host->dma[0]);
+        qemu_irq_lower(host->dma_tx_gpio);
         host->status &= 0xf7ff;
     }
 }
@@ -601,12 +602,13 @@ DeviceState *omap_mmc_init(hwaddr base,
     s = OMAP_MMC(dev);
     sysbus_realize_and_unref(SYS_BUS_DEVICE(s), &error_fatal);
 
-    s->irq = irq;
-    s->dma = dma;
     s->clk = clk;
 
     memory_region_add_subregion(sysmem, base,
                                 sysbus_mmio_get_region(SYS_BUS_DEVICE(s), 0));
+    qdev_connect_gpio_out_named(dev, "dma-tx", 0, dma[0]);
+    qdev_connect_gpio_out_named(dev, "dma-rx", 0, dma[1]);
+    sysbus_connect_irq(SYS_BUS_DEVICE(dev), 0, irq);
 
     /* Instantiate the storage */
     s->card = sd_init(blk, false);
@@ -633,6 +635,10 @@ static void omap_mmc_initfn(Object *obj)
 
     memory_region_init_io(&s->iomem, obj, &omap_mmc_ops, s, "omap.mmc", 0x800);
     sysbus_init_mmio(SYS_BUS_DEVICE(s), &s->iomem);
+
+    sysbus_init_irq(SYS_BUS_DEVICE(obj), &s->irq);
+    qdev_init_gpio_out_named(DEVICE(obj), &s->dma_tx_gpio, "dma-tx", 1);
+    qdev_init_gpio_out_named(DEVICE(obj), &s->dma_rx_gpio, "dma-rx", 1);
 }
 
 static void omap_mmc_class_init(ObjectClass *oc, void *data)
-- 
2.47.1


