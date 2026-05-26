Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C846BCD5BB1
	for <qemu-devel@archiver.kernel.org>; Tue, 26 May 2026 14:34:52 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wRsma-0000QP-VH; Tue, 26 May 2026 10:29:25 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1wRsmJ-0008KR-DT
 for qemu-devel@nongnu.org; Tue, 26 May 2026 10:29:10 -0400
Received: from mail-wm1-x333.google.com ([2a00:1450:4864:20::333])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1wRsmH-0001E4-4t
 for qemu-devel@nongnu.org; Tue, 26 May 2026 10:29:06 -0400
Received: by mail-wm1-x333.google.com with SMTP id
 5b1f17b1804b1-4891d7164ddso51386815e9.3
 for <qemu-devel@nongnu.org>; Tue, 26 May 2026 07:29:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1779805743; x=1780410543; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=Mmar4ZpXuPNj7eXVVmTwKPo9AaVohFLA2d4JdRkSYno=;
 b=QAKaDsh7SDwBYUz30I/gEyhrjmG6rOYwI6CfnyiTMax9qdzBX9cA5tR32/gMV95Qsr
 0Y8JN63WojEEQeCoYZsInaxELL80w4keTeMuAR8XHrZlYVTVQBDb85IFZuYpedxKhO9a
 34pATg2vYpovmYU48v26XPqJ/hkjCM1xASMah0o9o3nXX9v3MQrcC5OmnH1LCwsXEGJe
 TvNN0Max7JikCaAG562hq4LPmnh4zZ7uVEiH7FF9TKVrlcgR3KKtOcFk8OCMb+2nKw/m
 0hJe1bxGVkE4sdq5QeCKkGHyqiOOCTAkPJOiR22+BTARvrz+m1k09TNbWK1FqJwVMR3n
 7POg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779805743; x=1780410543;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=Mmar4ZpXuPNj7eXVVmTwKPo9AaVohFLA2d4JdRkSYno=;
 b=MEiTB4iY4UN060ae99J37gR8CuhKRYsoZtji/dV3zQh9eyuqhLeZp47nq37iFh4cwn
 O1NXV0dyuKyjP6WhAdNVcQuOaVLa6gbzZ3yFSYgD1bMiJENLQ7ooVuS+YxPAaSxkZrwP
 49asxSQK1vcLf5SZ4JB7v0sxnovJ5vvay4LcLFhfK0MjjE7pugUn7nnlUR9UpR+zREBO
 t5MZD1YjiYdekvrjxzptBz3HzbiNnfKObxV+tNa8+YSy+s6JtZtAJ2TyRYOjAnfX/3zE
 2pBzMF2mz5JcTii+EXvcx8oRQ/SFwmCpDMjqDPn/231qVgC5oJtgImpSoyOveqkpnTg6
 lBQg==
X-Gm-Message-State: AOJu0Yz9rFIFt4eVEpheZgtq2oUHWejRMWf9qgTqlW/01+eFHLXvRK6V
 ledFGq09YQM8Kqi6L0KGsgp32oj0ezY/IivIqCVu5bG+fyrTVBCDngllWHLjR+0OQh7JWGDVUeN
 cSNpW
X-Gm-Gg: Acq92OF9bZwyFXu79gD243Tai+xzKrEAms3FfwORNNA3CgZGn3Pgp+VlXbXpbEP3Up9
 2DUNF9ouvo+A8K3Cnno2SuVYN6rxDV6hJsVzvKYdQy5dEkPGI3PTBN+WX0DbtnwPt69+fJuoMVi
 q9/6NqHLqAK6E8VWmcKUvIS4o3IOgCYaeu/Og4GaRDl2cIGS/dOf3vs5DKdhf5Eh7cdEgChT2fy
 UOAE+3MDN5/1F//ddyNIstj1KCkN2qC/JhJOcLFG6tF2BQPVc0kx7tTOPNt6kbnniI8oOeZuINH
 jPRR+ooeFiekhHGouZ34ec1Lk9TiF6Rx6eALq/W5Tg6NsWvxN/DLNyQJDYz6b3+N2NUnovTvTgV
 eB+4/IcyR2L0pUsxHDgoUWUQRMIBaepSn4BvWvTx6NCXhBFqyYZhamFzwXoi+pTRQbuj7Ct+2pz
 Wl3kmULu30FLnRTdcqaJL7aVDTVW1sL+KbcfBaaxA80BhO+yQ6FiAv85GP6uE5aS8WE0LS5ksXc
 sM3N0pGgK1J13mwFH6LvRUhOI1jfhY=
X-Received: by 2002:a05:600c:154d:b0:490:44eb:c1d7 with SMTP id
 5b1f17b1804b1-49044ebc367mr303759555e9.30.1779805742532; 
 Tue, 26 May 2026 07:29:02 -0700 (PDT)
Received: from lanath.. (wildly.archaic.org.uk. [81.2.115.145])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-45eb6d70c51sm38325225f8f.36.2026.05.26.07.29.01
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 26 May 2026 07:29:01 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 11/54] hw/dma/omap_dma: Remove 3.1 mapping handling
Date: Tue, 26 May 2026 15:28:07 +0100
Message-ID: <20260526142850.2326589-12-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260526142850.2326589-1-peter.maydell@linaro.org>
References: <20260526142850.2326589-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::333;
 envelope-from=peter.maydell@linaro.org; helo=mail-wm1-x333.google.com
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

Now we have no 3.2 DMA support, the omap_dma_enable_3_1_mapping()
function is called at reset, and there is no longer anywhere that
disables it.  Remove the function and the unused
omap_3_1_mapping_disabled struct field, and drop the indirection from
omap_dma_interrupts_update() through the intr_update function pointer
to omap_dma_interrupts_3_1_update(), instead inlining that last
function into omap_dma_interrupts_update().

The only other thing omap_dma_enable_3_1_mapping() was doing was
setting s->chans; since this is now never changed at runtime we can
move its setting into the init function rather than reset.

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Message-id: 20260512203414.3633237-11-peter.maydell@linaro.org
---
 hw/dma/omap_dma.c | 52 ++++++++++++++++++++---------------------------
 1 file changed, 22 insertions(+), 30 deletions(-)

diff --git a/hw/dma/omap_dma.c b/hw/dma/omap_dma.c
index fe43fec58d..b05e46724c 100644
--- a/hw/dma/omap_dma.c
+++ b/hw/dma/omap_dma.c
@@ -106,8 +106,6 @@ struct omap_dma_s {
     struct omap_mpu_state_s *mpu;
     omap_clk clk;
     qemu_irq irq[4];
-    void (*intr_update)(struct omap_dma_s *s);
-    int omap_3_1_mapping_disabled;
 
     uint32_t gcr;
     uint32_t ocp;
@@ -134,7 +132,27 @@ struct omap_dma_s {
 
 static inline void omap_dma_interrupts_update(struct omap_dma_s *s)
 {
-    s->intr_update(s);
+    struct omap_dma_channel_s *ch = s->ch;
+
+    /* First three interrupts are shared between two channels each. */
+    if (ch[0].status | ch[6].status) {
+        qemu_irq_raise(ch[0].irq);
+    }
+    if (ch[1].status | ch[7].status) {
+        qemu_irq_raise(ch[1].irq);
+    }
+    if (ch[2].status | ch[8].status) {
+        qemu_irq_raise(ch[2].irq);
+    }
+    if (ch[3].status) {
+        qemu_irq_raise(ch[3].irq);
+    }
+    if (ch[4].status) {
+        qemu_irq_raise(ch[4].irq);
+    }
+    if (ch[5].status) {
+        qemu_irq_raise(ch[5].irq);
+    }
 }
 
 static void omap_dma_channel_load(struct omap_dma_channel_s *ch)
@@ -294,32 +312,6 @@ static void omap_dma_channel_end_prog(struct omap_dma_s *s,
     }
 }
 
-static void omap_dma_interrupts_3_1_update(struct omap_dma_s *s)
-{
-    struct omap_dma_channel_s *ch = s->ch;
-
-    /* First three interrupts are shared between two channels each. */
-    if (ch[0].status | ch[6].status)
-        qemu_irq_raise(ch[0].irq);
-    if (ch[1].status | ch[7].status)
-        qemu_irq_raise(ch[1].irq);
-    if (ch[2].status | ch[8].status)
-        qemu_irq_raise(ch[2].irq);
-    if (ch[3].status)
-        qemu_irq_raise(ch[3].irq);
-    if (ch[4].status)
-        qemu_irq_raise(ch[4].irq);
-    if (ch[5].status)
-        qemu_irq_raise(ch[5].irq);
-}
-
-static void omap_dma_enable_3_1_mapping(struct omap_dma_s *s)
-{
-    s->omap_3_1_mapping_disabled = 0;
-    s->chans = 9;
-    s->intr_update = omap_dma_interrupts_3_1_update;
-}
-
 static void omap_dma_process_request(struct omap_dma_s *s, int request)
 {
     int channel;
@@ -660,7 +652,6 @@ void omap_dma_reset(struct soc_dma_s *dma)
     s->lcd_ch.condition = 0;
     s->lcd_ch.interrupts = 0;
     s->lcd_ch.dual = 0;
-    omap_dma_enable_3_1_mapping(s);
     for (i = 0; i < s->chans; i ++) {
         s->ch[i].suspend = 0;
         s->ch[i].prefetch = 0;
@@ -1193,6 +1184,7 @@ struct soc_dma_s *omap_dma_init(hwaddr base, qemu_irq *irqs,
     s->clk = clk;
     s->lcd_ch.irq = lcd_irq;
     s->lcd_ch.mpu = mpu;
+    s->chans = 9;
 
     s->dma = soc_dma_init(9);
     s->dma->freq = omap_clk_getrate(clk);
-- 
2.43.0


