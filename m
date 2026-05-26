Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 08DD1CD5BD2
	for <qemu-devel@archiver.kernel.org>; Tue, 26 May 2026 14:34:17 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wRsmT-0008Mu-7O; Tue, 26 May 2026 10:29:20 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1wRsmD-0008Ef-VT
 for qemu-devel@nongnu.org; Tue, 26 May 2026 10:29:02 -0400
Received: from mail-wr1-x436.google.com ([2a00:1450:4864:20::436])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1wRsmC-0001DR-AV
 for qemu-devel@nongnu.org; Tue, 26 May 2026 10:29:01 -0400
Received: by mail-wr1-x436.google.com with SMTP id
 ffacd0b85a97d-43d73422431so7551375f8f.2
 for <qemu-devel@nongnu.org>; Tue, 26 May 2026 07:28:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1779805738; x=1780410538; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=WDOMQi4BCdtFH39y4Uw1CTj59WhkNb3bAUovvCrdX7A=;
 b=dak6Up5RcmhAJx0O5ndhdH2KvZfxJEzvRlBqLaG/GvKmrox8CUElgA+eiffu1cW/P0
 qakLjnO5v+9R4JIvq3CpAb/zEVTVJbTocK5AB9aZt6aX2PltMB/u3MHANKld2gemw2AQ
 TkAIbh2+Opw6B+MbSHHOxcOiHRC+0KzEEiCYxTv6TSdRHNIZr7AKmIIPycuxa887+iY4
 J2LprHjndKevl+2IK7R1VsL5trwXHfjC4RYIeyIi40YY/Bd0ecR/B8I2xeUO9Ql92KA+
 cFLXTBdaoxaOhDRe6wLaigJqeES7Fq3+yM7Ipuj3yp/VUmXnRoc6Plag777Imgp6lERf
 l76g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779805738; x=1780410538;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=WDOMQi4BCdtFH39y4Uw1CTj59WhkNb3bAUovvCrdX7A=;
 b=NRn8pFL/R9yTfCRBoQuu/Ss92n83E4UqhScOwBN93/2O6i74UEQgd3oAvu72FAqwJy
 wV3975neC8qUXV61ioXKOxhUqVPVtuuB/fXY2M/ACyM18ERbeIN6Q3JvM1HqXGQ0E7Lv
 n9Fzu/yMv7NTyw5gY8UZiM539PJ+crq2f0amYLLhRup2FXV2IPF6Yiq27aR5eQIfNFSk
 hYkZWpsTKrNErMSZpDhmYGALUVQevrW9lTxpJibrQ4C/YSFjUx5XZ2VyD893sqAm546w
 da9iihOWaHJMbBHonpx0jcYiDreUjPCYIk8cF+Zewtqr27b+D7I5AbOtRa3gJN07rrjY
 eeBQ==
X-Gm-Message-State: AOJu0YzPxt3kRzpSAXQViA0VwXGbIs671bSLkuo7zzIkGf+rpyoratRz
 PO4w+PuD0+sLZnqq7WQsAPYL8V7WNlqZfIcnsViNDZ45l+tmjT4AAzCtctlQX6OQrTmXF15yzUB
 6AvOY
X-Gm-Gg: Acq92OHc0+5dTNQSw+7mQvz9mWAW/2mnOo5+5NZ0Pg+5PaNqG6fz5OEY+lDZDrIj2EO
 3vuDdWZiMJbaYAxnKsnroB9yTJTVnJFSVu51miYdb95eOAUIGUGkW68UCPE0uq1DxvI5L/PFcW0
 ddmVqUG7a+K4f3+QGOQcmeigljDBayCGD6tIIzk7rMsObFB2JkJ2LwLiEjXJWWTdJi5oMQ91FqT
 Qg5sUhTuUFbHmprbD3AGZ/vCQSuU1uvbR720ir3NcjU3bYSPoZNCGwZf3X926DAkHM8yPKc55x1
 6C5C/6PXevnno7/+A4FnNHJuhhqV0NvqJTia9ZyiWEQ81rTwMSQ4hnFZTEkEEYNJjhLqWZIX2VZ
 EKNJDtXFGb21zu4vRPYgk9reQyA0eujuDd0L2wmzPeLMH/saR5rutsRmXS8JKTyu5Zq3baqMLJ2
 x2LMMZIT4djLmeuzFE8Mjj8777RIeTjRjq6AnJNCb/iEb5vgojRExvAgGKDSbwxFoih1dvfbB5H
 RxzsEZ7NyM4SIgIaR7OgMkDvlI0fnM=
X-Received: by 2002:a05:6000:26c4:b0:44a:2555:f8a9 with SMTP id
 ffacd0b85a97d-45eb369072emr31072369f8f.10.1779805738384; 
 Tue, 26 May 2026 07:28:58 -0700 (PDT)
Received: from lanath.. (wildly.archaic.org.uk. [81.2.115.145])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-45eb6d70c51sm38325225f8f.36.2026.05.26.07.28.57
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 26 May 2026 07:28:57 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 07/54] hw/arm/omap: Remove unused wakeup irq
Date: Tue, 26 May 2026 15:28:03 +0100
Message-ID: <20260526142850.2326589-8-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260526142850.2326589-1-peter.maydell@linaro.org>
References: <20260526142850.2326589-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::436;
 envelope-from=peter.maydell@linaro.org; helo=mail-wr1-x436.google.com
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

The OMAP code creates a qemu_irq whose set function is
omap_mpu_wakeup(), and passes that irq into omap_mpuio_init(), which
saves it in its omap_mpuio_s::wakeup field.  However nothing ever
touches that qemu_irq again, so omap_mpu_wakeup() is never called.

Remove all this as dead code.  This lets us remove a direct call to
cpu_interrupt(cpu, CPU_INTERRUPT_EXITTB) from within board/SoC code,
which is pretty ugly and might not even do the right thing these
days.

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Message-id: 20260512203414.3633237-7-peter.maydell@linaro.org
---
 hw/arm/omap1.c        | 18 ++----------------
 include/hw/arm/omap.h |  2 --
 2 files changed, 2 insertions(+), 18 deletions(-)

diff --git a/hw/arm/omap1.c b/hw/arm/omap1.c
index 40ca8c9890..80168644ce 100644
--- a/hw/arm/omap1.c
+++ b/hw/arm/omap1.c
@@ -1846,7 +1846,6 @@ struct omap_mpuio_s {
     qemu_irq kbd_irq;
     qemu_irq *in;
     qemu_irq handler[16];
-    qemu_irq wakeup;
     MemoryRegion iomem;
 
     uint16_t inputs;
@@ -2074,14 +2073,13 @@ static void omap_mpuio_onoff(void *opaque, int line, int on)
 
 static struct omap_mpuio_s *omap_mpuio_init(MemoryRegion *memory,
                 hwaddr base,
-                qemu_irq kbd_int, qemu_irq gpio_int, qemu_irq wakeup,
+                qemu_irq kbd_int, qemu_irq gpio_int,
                 omap_clk clk)
 {
     struct omap_mpuio_s *s = g_new0(struct omap_mpuio_s, 1);
 
     s->irq = gpio_int;
     s->kbd_irq = kbd_int;
-    s->wakeup = wakeup;
     s->in = qemu_allocate_irqs(omap_mpuio_set, s, 16);
     omap_mpuio_reset(s);
 
@@ -3693,16 +3691,6 @@ static void omap_setup_dsp_mapping(MemoryRegion *system_memory,
     }
 }
 
-void omap_mpu_wakeup(void *opaque, int irq, int req)
-{
-    struct omap_mpu_state_s *mpu = opaque;
-    CPUState *cpu = CPU(mpu->cpu);
-
-    if (cpu->halted) {
-        cpu_interrupt(cpu, CPU_INTERRUPT_EXITTB);
-    }
-}
-
 static const struct dma_irq_map omap1_dma_irq_map[] = {
     { 0, OMAP_INT_DMA_CH0_6 },
     { 0, OMAP_INT_DMA_CH1_7 },
@@ -3765,8 +3753,6 @@ struct omap_mpu_state_s *omap310_mpu_init(MemoryRegion *dram,
     s->sdram_size = memory_region_size(dram);
     s->sram_size = OMAP15XX_SRAM_SIZE;
 
-    s->wakeup = qemu_allocate_irq(omap_mpu_wakeup, s, 0);
-
     /* Clocks */
     omap_clk_init(s);
 
@@ -3912,7 +3898,7 @@ struct omap_mpu_state_s *omap310_mpu_init(MemoryRegion *dram,
     s->mpuio = omap_mpuio_init(system_memory, 0xfffb5000,
                                qdev_get_gpio_in(s->ih[1], OMAP_INT_KEYBOARD),
                                qdev_get_gpio_in(s->ih[1], OMAP_INT_MPUIO),
-                               s->wakeup, omap_findclk(s, "clk32-kHz"));
+                               omap_findclk(s, "clk32-kHz"));
 
     s->gpio = qdev_new("omap-gpio");
     omap_gpio_set_clk(OMAP1_GPIO(s->gpio), omap_findclk(s, "arm_gpio_ck"));
diff --git a/include/hw/arm/omap.h b/include/hw/arm/omap.h
index 14d6e9d214..ea5c0eff8b 100644
--- a/include/hw/arm/omap.h
+++ b/include/hw/arm/omap.h
@@ -463,8 +463,6 @@ struct omap_mpu_state_s {
 struct omap_mpu_state_s *omap310_mpu_init(MemoryRegion *sdram,
                 const char *core);
 
-void omap_mpu_wakeup(void *opaque, int irq, int req);
-
 #define OMAP_BAD_REG(paddr)        \
         qemu_log_mask(LOG_GUEST_ERROR, "%s: Bad register %#08"HWADDR_PRIx"\n", \
                       __func__, paddr)
-- 
2.43.0


