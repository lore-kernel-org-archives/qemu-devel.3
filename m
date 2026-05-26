Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 25759CD5BD0
	for <qemu-devel@archiver.kernel.org>; Tue, 26 May 2026 14:34:52 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wRsma-0000Mi-A3; Tue, 26 May 2026 10:29:24 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1wRsmJ-0008KS-GK
 for qemu-devel@nongnu.org; Tue, 26 May 2026 10:29:10 -0400
Received: from mail-wr1-x42b.google.com ([2a00:1450:4864:20::42b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1wRsmH-0001ET-5G
 for qemu-devel@nongnu.org; Tue, 26 May 2026 10:29:07 -0400
Received: by mail-wr1-x42b.google.com with SMTP id
 ffacd0b85a97d-43fe608cb92so6502078f8f.2
 for <qemu-devel@nongnu.org>; Tue, 26 May 2026 07:29:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1779805743; x=1780410543; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=c3n7Oc7aeyIf5LNC1yLJVtTuyTWdjNqILdaKFA1BwMU=;
 b=f3jkK2FFU+rKOM/hCnldiY3ViHICSMGcS7mQb3sRFR57ibAn4Bgn0vZSvmpEeVAzFy
 OLeDkmIIxr6VKyCIRLuBgInRXkGNGrvG3v0Fct8qHMGfdRwCwHMEvJ92PNBn2aqv0Ptu
 RSvQbdCqs7nVglfwQafV6FBoGbQ6vmBWFTY/lnPw0Wo2IroBIbQcRItYnfVyo6TtXS9E
 KrtqwcG1eBzcYn10t5Lmwa6N7rbkGdBBz4UB7y9Z9kYJkdqyiE0yZFKM/Tu9v2aAKBtv
 iuLXnW+d+VBr3SvjsjXngBGLk7KjGhpWii4BPZSEM1ZwHsKWHY0UBRE78ot2XtmlttrJ
 XXeA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779805743; x=1780410543;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=c3n7Oc7aeyIf5LNC1yLJVtTuyTWdjNqILdaKFA1BwMU=;
 b=cn2Xlp813vrrBAHRQVwbuYN+lp8Owd4vXeGyEgSlTA0uhFyFFmpNdWvx/O0VkfqCAN
 Ct8Fk0Ykamx0qbKiEHgrdi0aIU/gzHFywaGtzUOUFVhSpUulPAO2VpfUHhDMWrYCt6gr
 KAsHVmbEXKqeopqOAODrj/eV6G1TCzBkH26IIsW3hQjgmTKsGnT34+MHixgiT5ltO5NI
 EayU+t/9GHIutlBMuyZiL+iiqdjTXOq0Sqos/iRYc4fMgd8aqRiJV6ovmOAH0vjBR8HP
 FqmGOWkAVitRrrDRJUCOL4qyUCItz2lQsQQp3U+8XJRE2/Ji5PpLK7g3EzJAexwZb0M1
 4/tw==
X-Gm-Message-State: AOJu0YzhaIHr8us9xNS+oQRY49nZeklJZA32LDWUEYe5NjZT5/TnGNPV
 bIOqPWSHcPV8xJaA3DVBrSMKYVT2RTB0fmkVxPa/nwKpJcaOTEHmDyYB403nWMR4vxRNs2q10Wg
 b0s8m
X-Gm-Gg: Acq92OEuQjI0EhakCKRCl5z0bDgTg2jkR2d/HuJjYVyK0wv62XANBSJ9NVa+kbxcmCv
 0hjObD61J2hjKFJ8GyfOcNL9H1nUg/UZvfjE1orrsl6rfCC8meDMMHSH0jdPx+LwtdeufotuGXa
 w8khrctSLtfe9OweTDvIEdfLnwK0FMscdTuhcXv0X0qgOYNqXvYjlhct3ip+x+oANYyTIWS84cF
 3jCXqYMJ9V/FE7tYUfxhLv2R9m2bfRMMGAJXEGA7BqMB0VeAxWz3my1OY9FnE+7gHpMewZM87fo
 Zw/jCpS4UaetSdNmNtcMbPvlhlPy0E1N4azL/OVZ2/ILAY1Dn9t8rvgKLUWxYlLOwsmCC4SNZ24
 +ylWk9/5SmoWUSO8L8WaZT2nu+MwMHJJ/g5LXTS2qvYv1vS1y9S/um7Orp67p7ZNzumXakD/fXd
 23D2d0MdS4sMP+PshFTGyq7gHQ4z57O1T+CI8lw0Xiczrgf6C9fhGlNsXRixL2Cv2jBgrxuH32g
 Qt7s9jC/j8HDDeIkbESaEwBB/2mPmapK+j6j3yC/Q==
X-Received: by 2002:a05:6000:430b:b0:43d:75a2:44aa with SMTP id
 ffacd0b85a97d-45eb38e4db6mr31296310f8f.43.1779805743451; 
 Tue, 26 May 2026 07:29:03 -0700 (PDT)
Received: from lanath.. (wildly.archaic.org.uk. [81.2.115.145])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-45eb6d70c51sm38325225f8f.36.2026.05.26.07.29.02
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 26 May 2026 07:29:02 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 12/54] hw/dma/omap_dma: Drop model argument to omap_dma_init()
Date: Tue, 26 May 2026 15:28:08 +0100
Message-ID: <20260526142850.2326589-13-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260526142850.2326589-1-peter.maydell@linaro.org>
References: <20260526142850.2326589-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42b;
 envelope-from=peter.maydell@linaro.org; helo=mail-wr1-x42b.google.com
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

The model argument to omap_dma_init() is always omap_dma_3_1, and all
we do with it now is assert this; drop the argument and the enum.

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Message-id: 20260512203414.3633237-13-peter.maydell@linaro.org
---
 hw/arm/omap1.c        |  2 +-
 hw/dma/omap_dma.c     |  8 +++-----
 include/hw/arm/omap.h | 12 +++---------
 3 files changed, 7 insertions(+), 15 deletions(-)

diff --git a/hw/arm/omap1.c b/hw/arm/omap1.c
index 80168644ce..44f9dd67c3 100644
--- a/hw/arm/omap1.c
+++ b/hw/arm/omap1.c
@@ -3789,7 +3789,7 @@ struct omap_mpu_state_s *omap310_mpu_init(MemoryRegion *dram,
     }
     s->dma = omap_dma_init(0xfffed800, dma_irqs, system_memory,
                            qdev_get_gpio_in(s->ih[0], OMAP_INT_DMA_LCD),
-                           s, omap_findclk(s, "dma_ck"), omap_dma_3_1);
+                           s, omap_findclk(s, "dma_ck"));
 
     s->port[emiff    ].addr_valid = omap_validate_emiff_addr;
     s->port[emifs    ].addr_valid = omap_validate_emifs_addr;
diff --git a/hw/dma/omap_dma.c b/hw/dma/omap_dma.c
index b05e46724c..b042e7c59c 100644
--- a/hw/dma/omap_dma.c
+++ b/hw/dma/omap_dma.c
@@ -1169,15 +1169,13 @@ static void omap_dma_clk_update(void *opaque, int line, int on)
 }
 
 struct soc_dma_s *omap_dma_init(hwaddr base, qemu_irq *irqs,
-                MemoryRegion *sysmem,
-                qemu_irq lcd_irq, struct omap_mpu_state_s *mpu, omap_clk clk,
-                enum omap_dma_model model)
+                                MemoryRegion *sysmem,
+                                qemu_irq lcd_irq,
+                                struct omap_mpu_state_s *mpu, omap_clk clk)
 {
     int num_irqs, memsize, i;
     struct omap_dma_s *s = g_new0(struct omap_dma_s, 1);
 
-    assert(model == omap_dma_3_1);
-
     num_irqs = 6;
     memsize = 0x800;
     s->mpu = mpu;
diff --git a/include/hw/arm/omap.h b/include/hw/arm/omap.h
index 36569815e8..2675d064f2 100644
--- a/include/hw/arm/omap.h
+++ b/include/hw/arm/omap.h
@@ -172,17 +172,11 @@ void omap_gpio_set_clk(Omap1GpioState *gpio, omap_clk clk);
 #define OMAP_INT_310_McBSP2RX_OF       31
 
 /* omap_dma.c */
-enum omap_dma_model {
-    omap_dma_3_0,
-    omap_dma_3_1,
-    omap_dma_3_2,
-};
-
 struct soc_dma_s;
 struct soc_dma_s *omap_dma_init(hwaddr base, qemu_irq *irqs,
-                MemoryRegion *sysmem,
-                qemu_irq lcd_irq, struct omap_mpu_state_s *mpu, omap_clk clk,
-                enum omap_dma_model model);
+                                MemoryRegion *sysmem,
+                                qemu_irq lcd_irq,
+                                struct omap_mpu_state_s *mpu, omap_clk clk);
 void omap_dma_reset(struct soc_dma_s *s);
 
 struct dma_irq_map {
-- 
2.43.0


