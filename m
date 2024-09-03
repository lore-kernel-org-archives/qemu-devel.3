Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E092FCD37A7
	for <qemu-devel@archiver.kernel.org>; Tue,  3 Sep 2024 16:13:07 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1slW5e-0001mo-IW; Tue, 03 Sep 2024 12:09:10 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1slW5U-0000r5-JI
 for qemu-devel@nongnu.org; Tue, 03 Sep 2024 12:09:00 -0400
Received: from mail-wm1-x330.google.com ([2a00:1450:4864:20::330])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1slW5S-0002wM-8x
 for qemu-devel@nongnu.org; Tue, 03 Sep 2024 12:09:00 -0400
Received: by mail-wm1-x330.google.com with SMTP id
 5b1f17b1804b1-42c7a384b18so26510525e9.0
 for <qemu-devel@nongnu.org>; Tue, 03 Sep 2024 09:08:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1725379737; x=1725984537; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=IBK9++lIy858o9BthLOcMzwPW6V+cbfDg3AQGuNzNcc=;
 b=bjSavRnshSYnAfN3nC0375JCL/icIHQwCE4mWDi0Ad46/dlS3vn/13W8V2zmdbs8L0
 QUht5t6VLLXJgI7MDQkzmlKzoB64K3khgm43ZSWSAz9v9rRU4sJDSczlkvuXzBh9mVyd
 D4ZGW3KimYckpdpO2W7af2f/RuvYv/Mofyrqn4BOuBHcCn653LsqGoJVZZ8+CZIICLlu
 GZqZqFqDLeOTtpsPwaogY/24sYhggZho/723x/SeEXDcxdD3J25CUmwTa8cbv7Mwq4OD
 LFHX0vPcac8XvhZbYBWkQjtIYqum1qGgdFyLSMvh4yvDRDTwE0D/eVhIg0xVDG0Cmrl0
 4XjQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1725379737; x=1725984537;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=IBK9++lIy858o9BthLOcMzwPW6V+cbfDg3AQGuNzNcc=;
 b=ejVC+Y/WfbgbuK+JwJL+GxnkA0BKOlbfrglhkEcfSFdeZzFi1zXKfNx1IwKkGi5M2L
 EwxEOFQk5wxwfYTnSd7qksgOhbV2OWuDMnaO9OyZiua7cqhUyp+LEtdzQnfcc9zC6TLn
 rUA3OvJGyihXoytlljS14TEXlqUFX5qjCXAR6SlKyPvHo61daItICtPzA1dhtmgP71c5
 4qploqrhxTUQsQQDwOC4hI650pBeOuig/8tFvfjb5vjm5WoKi9pLXAHt2sP2GgkQANyQ
 cFw0xt6XmzS8Q8gkc6S7uDan+sWL6qI9yVlZ00gBGjmchDPefnT+/h/c58tb5MbRQ+be
 mvgw==
X-Forwarded-Encrypted: i=1;
 AJvYcCWWRlCAw/vQ6tZZ8c4pAgMIr1Wo7KOnq3wQpBnI69cidPqwrAZ1UXoULVb3A2opxTUFWRdsdxFjHSPj@nongnu.org
X-Gm-Message-State: AOJu0YxEqp2nwpwIM+tPTHPtPnFHND2P3MNOX/adoTCFYvGBwpzKWSIP
 1znDIfOs41EyR36R7qdltCfKHpWXZbzOsnzbpdTGuy0+b5lmRf/0q7a1N3owkHsBNhepXzYpJaL
 9
X-Google-Smtp-Source: AGHT+IEFJXz0VkiDn5nAPBOs/bojJU+xAE30jrZQ/1R9d2JUZGO10RpC6sQ1LLuNfixnvDI6fk1eVg==
X-Received: by 2002:a05:600c:154d:b0:429:cc03:6450 with SMTP id
 5b1f17b1804b1-42bd731ee10mr90000435e9.7.1725379736719; 
 Tue, 03 Sep 2024 09:08:56 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [2001:8b0:1d0::2])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-42bb6df1066sm175123065e9.18.2024.09.03.09.08.54
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 03 Sep 2024 09:08:54 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-arm@nongnu.org,
	qemu-devel@nongnu.org
Subject: [PATCH for-9.2 41/53] hw/sd: Remove omap2_mmc device
Date: Tue,  3 Sep 2024 17:07:39 +0100
Message-Id: <20240903160751.4100218-42-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240903160751.4100218-1-peter.maydell@linaro.org>
References: <20240903160751.4100218-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::330;
 envelope-from=peter.maydell@linaro.org; helo=mail-wm1-x330.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

Remove the OMAP2 specific code from omap_mmc.c.

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 include/hw/arm/omap.h |  5 ----
 hw/sd/omap_mmc.c      | 63 -------------------------------------------
 2 files changed, 68 deletions(-)

diff --git a/include/hw/arm/omap.h b/include/hw/arm/omap.h
index 67bb83dff5d..b0bd1e6f540 100644
--- a/include/hw/arm/omap.h
+++ b/include/hw/arm/omap.h
@@ -797,12 +797,7 @@ struct omap_mmc_s *omap_mmc_init(hwaddr base,
                 MemoryRegion *sysmem,
                 BlockBackend *blk,
                 qemu_irq irq, qemu_irq dma[], omap_clk clk);
-struct omap_mmc_s *omap2_mmc_init(struct omap_target_agent_s *ta,
-                BlockBackend *blk, qemu_irq irq, qemu_irq dma[],
-                omap_clk fclk, omap_clk iclk);
 void omap_mmc_reset(struct omap_mmc_s *s);
-void omap_mmc_handlers(struct omap_mmc_s *s, qemu_irq ro, qemu_irq cover);
-void omap_mmc_enable(struct omap_mmc_s *s, int enable);
 
 /* omap_i2c.c */
 I2CBus *omap_i2c_bus(DeviceState *omap_i2c);
diff --git a/hw/sd/omap_mmc.c b/hw/sd/omap_mmc.c
index edd3cf2a1eb..91e9a3f1c6a 100644
--- a/hw/sd/omap_mmc.c
+++ b/hw/sd/omap_mmc.c
@@ -573,24 +573,6 @@ static const MemoryRegionOps omap_mmc_ops = {
     .endianness = DEVICE_NATIVE_ENDIAN,
 };
 
-static void omap_mmc_cover_cb(void *opaque, int line, int level)
-{
-    struct omap_mmc_s *host = opaque;
-
-    if (!host->cdet_state && level) {
-        host->status |= 0x0002;
-        omap_mmc_interrupts_update(host);
-        if (host->cdet_wakeup) {
-            /* TODO: Assert wake-up */
-        }
-    }
-
-    if (host->cdet_state != level) {
-        qemu_set_irq(host->coverswitch, level);
-        host->cdet_state = level;
-    }
-}
-
 struct omap_mmc_s *omap_mmc_init(hwaddr base,
                 MemoryRegion *sysmem,
                 BlockBackend *blk,
@@ -617,48 +599,3 @@ struct omap_mmc_s *omap_mmc_init(hwaddr base,
 
     return s;
 }
-
-struct omap_mmc_s *omap2_mmc_init(struct omap_target_agent_s *ta,
-                BlockBackend *blk, qemu_irq irq, qemu_irq dma[],
-                omap_clk fclk, omap_clk iclk)
-{
-    struct omap_mmc_s *s = g_new0(struct omap_mmc_s, 1);
-
-    s->irq = irq;
-    s->dma = dma;
-    s->clk = fclk;
-    s->lines = 4;
-    s->rev = 2;
-
-    memory_region_init_io(&s->iomem, NULL, &omap_mmc_ops, s, "omap.mmc",
-                          omap_l4_region_size(ta, 0));
-    omap_l4_attach(ta, 0, &s->iomem);
-
-    /* Instantiate the storage */
-    s->card = sd_init(blk, false);
-    if (s->card == NULL) {
-        exit(1);
-    }
-
-    s->cdet = qemu_allocate_irq(omap_mmc_cover_cb, s, 0);
-    sd_set_cb(s->card, NULL, s->cdet);
-
-    omap_mmc_reset(s);
-
-    return s;
-}
-
-void omap_mmc_handlers(struct omap_mmc_s *s, qemu_irq ro, qemu_irq cover)
-{
-    if (s->cdet) {
-        sd_set_cb(s->card, ro, s->cdet);
-        s->coverswitch = cover;
-        qemu_set_irq(cover, s->cdet_state);
-    } else
-        sd_set_cb(s->card, ro, cover);
-}
-
-void omap_mmc_enable(struct omap_mmc_s *s, int enable)
-{
-    sd_enable(s->card, enable);
-}
-- 
2.34.1


