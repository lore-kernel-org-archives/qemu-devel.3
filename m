Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 08C9FCD6E4A
	for <qemu-devel@archiver.kernel.org>; Fri, 29 May 2026 11:49:58 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wSvgt-0001iq-58; Fri, 29 May 2026 07:47:51 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1wSvgr-0001hz-9n
 for qemu-devel@nongnu.org; Fri, 29 May 2026 07:47:49 -0400
Received: from mail-wr1-x430.google.com ([2a00:1450:4864:20::430])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1wSvgp-0008F9-FV
 for qemu-devel@nongnu.org; Fri, 29 May 2026 07:47:49 -0400
Received: by mail-wr1-x430.google.com with SMTP id
 ffacd0b85a97d-45ef189aa1cso506761f8f.0
 for <qemu-devel@nongnu.org>; Fri, 29 May 2026 04:47:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1780055266; x=1780660066; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=ramOWrlR3t8XVUyFSiGNcrPRaqjo7C5Q2fq7bwfvjM8=;
 b=MySFhFE4a8qH1YUWSEJmrp486+hLm8zksHSL2p61ilQ+1Kti7NOoAsoyO86/LPWPKq
 61y6aKtYq7yPihr0R9tZlsq4ZOwTUIYmttpgfCQ2qKVbjiU/rbmfEDSJSkV2+d9TFLQm
 Wv+w8IdeeJS1aVpUIknlWtoPr40NllUnpquOVqndf1Or8AMrKZNCiOPRiOK5TWLrUQA6
 bV7asEX1ed3YnM3z512F8h5S4n7qOiNf8n6914ll+Lmne5+X+nNsCCEfQrYFO1vkihCe
 znrNYanck5bbp7AW/fa8xJKNQuGlhUtXWUNw9OnsemqgNsJiH1H0tBxnuNB//ou3b4NH
 sNaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1780055266; x=1780660066;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=ramOWrlR3t8XVUyFSiGNcrPRaqjo7C5Q2fq7bwfvjM8=;
 b=CoTQpEEJU05p+Lw19rXNKYurBKweQHYsghbSbfFcCiFeLqx6mttTSaDEXeLOAT+jzY
 TGAefEGKYkL/7v3mxzO7/tquYT0Vlhi5rn7T0OPlv77zKqTPnGwZmh6xk9NF/V1NFRUZ
 DypJiB4FirCtRIaRYeBMkBj+i54t1X4X1IyXqUJns0Hij7Y7aoyw+79RQq1ZOqekWwrc
 j1J3BQ+eAT3QqSLLuot/TjT9q5SW0eFVtt/wp3g1s2g7tXTGJdvkIzeu9vfkXsD9Ji/J
 WgSquZYvY1eHueCvVbAfDnyDg+j/3zgBmo3NZ7uPCiBUbiM5B+KZmAxE6ujlfGgEjXmw
 bfLQ==
X-Gm-Message-State: AOJu0Yzkcm8wYZ0k9giDCvDqq5ZGoHwprumCP4h9/gfZmWdRKYXVRlJf
 FdGT7FCBblXzRq6VROjOHRsfRcWzje5s4H27w99FaKvI7uiSG1xbab5nw8lslsBCvkJIWYdyssm
 2gMON
X-Gm-Gg: Acq92OH7ZJFq/1+cn3YVwGeLV0gP2aLBaI5ZUyU5BgHxxL90hP1sakjzuOVyEvk6Fa9
 OyHTVzHQ5WzOFFI/mbsb88CBvEFRhV2oaAXHszHEtrtf5SD1CV5WYVC2UFounN/lB8QK9iBfR2t
 7JwGJ34gDUC5ndL2lU3VTKn5uofbxhTnXHOvdoHf2T4IB4XCGgmaeZyduI+nUk0Q2OvX0qs3CGo
 PyRJzToXEa/0pqlwYUf90evw/8p5APnbXmuDnqYUDNdDkTbFTh9DJ6UjgLcfl8bHqZuwFyHSDFo
 wsH9IA/me1CKqGdsRm9SflIoW9NRZK9MNXTfgyR2xE7eR2hApKMa951ef5z/S/fVxrhiojtVn+Z
 fXrilcNuueX5FxjghkiqPCPmdtbAUWnj6yF73qwaPlNDSQKOWkwq2etDV9znyp9wDjjvnsyQRGd
 PQCDH1ajnKWyDwgRdlY8jwne8xZKj02LFW2j87RERkCt1oHq+X6l7jVQL5MCxZu5ke6vkFH4HiX
 jSrtnW5quyx4Q4tWh885qKMG4IiZ+fFNlEWkpdvjA==
X-Received: by 2002:a05:6000:41e2:b0:45e:ea46:ce11 with SMTP id
 ffacd0b85a97d-45ef13f8ef9mr4418780f8f.14.1780055265950; 
 Fri, 29 May 2026 04:47:45 -0700 (PDT)
Received: from lanath.. (wildly.archaic.org.uk. [81.2.115.145])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-45ef3563cb9sm3007358f8f.29.2026.05.29.04.47.44
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 29 May 2026 04:47:45 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 19/21] hw/dma/omap_dma: Remove unused ifdeffed out code
Date: Fri, 29 May 2026 12:47:20 +0100
Message-ID: <20260529114723.42040-20-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260529114723.42040-1-peter.maydell@linaro.org>
References: <20260529114723.42040-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::430;
 envelope-from=peter.maydell@linaro.org; helo=mail-wr1-x430.google.com
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

The OMAP DMA device includes a lot of code which has been disabled
via ifdefs for over a decade. Whatever this unfinished development
work was, all knowledge of it is long gone, and we're unlikely to
be doing any serious work on this device model in future. If we
did, we'd likely have to start from scratch.

Remove all the ifdeffed out code. We will fix up the indentation
in a followup commit that has only whitespace changes.

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Message-id: 20260528152852.3349928-2-peter.maydell@linaro.org
---
 hw/dma/omap_dma.c | 94 -----------------------------------------------
 1 file changed, 94 deletions(-)

diff --git a/hw/dma/omap_dma.c b/hw/dma/omap_dma.c
index b042e7c59c..a93d9ad196 100644
--- a/hw/dma/omap_dma.c
+++ b/hw/dma/omap_dma.c
@@ -343,9 +343,6 @@ static void omap_dma_transfer_generic(struct soc_dma_ch_s *dma)
     struct omap_dma_channel_s *ch = dma->opaque;
     struct omap_dma_reg_set_s *a = &ch->active_set;
     int bytes = dma->bytes;
-#ifdef MULTI_REQ
-    uint16_t status = ch->status;
-#endif
 
     do {
         /* Transfer a single element */
@@ -362,7 +359,6 @@ static void omap_dma_transfer_generic(struct soc_dma_ch_s *dma)
         a->dest += a->elem_delta[1];
         a->element ++;
 
-#ifndef MULTI_REQ
         if (a->element == a->elements) {
             /* End of Frame */
             a->element = 0;
@@ -375,78 +371,6 @@ static void omap_dma_transfer_generic(struct soc_dma_ch_s *dma)
                 ch->cpc = a->dest & 0xffff;
         }
     } while ((bytes -= ch->data_type));
-#else
-        /* If the channel is element synchronized, deactivate it */
-        if (ch->sync && !ch->fs && !ch->bs)
-            omap_dma_deactivate_channel(s, ch);
-
-        /* If it is the last frame, set the LAST_FRAME interrupt */
-        if (a->element == 1 && a->frame == a->frames - 1)
-            if (ch->interrupts & LAST_FRAME_INTR)
-                ch->status |= LAST_FRAME_INTR;
-
-        /* If the half of the frame was reached, set the HALF_FRAME
-           interrupt */
-        if (a->element == (a->elements >> 1))
-            if (ch->interrupts & HALF_FRAME_INTR)
-                ch->status |= HALF_FRAME_INTR;
-
-        if (ch->fs && ch->bs) {
-            a->pck_element ++;
-            /* Check if a full packet has been transferred.  */
-            if (a->pck_element == a->pck_elements) {
-                a->pck_element = 0;
-
-                /* Set the END_PKT interrupt */
-                if ((ch->interrupts & END_PKT_INTR) && !ch->src_sync)
-                    ch->status |= END_PKT_INTR;
-
-                /* If the channel is packet-synchronized, deactivate it */
-                if (ch->sync)
-                    omap_dma_deactivate_channel(s, ch);
-            }
-        }
-
-        if (a->element == a->elements) {
-            /* End of Frame */
-            a->element = 0;
-            a->src += a->frame_delta[0];
-            a->dest += a->frame_delta[1];
-            a->frame ++;
-
-            /* If the channel is frame synchronized, deactivate it */
-            if (ch->sync && ch->fs && !ch->bs)
-                omap_dma_deactivate_channel(s, ch);
-
-            /* If the channel is async, update cpc */
-            if (!ch->sync)
-                ch->cpc = a->dest & 0xffff;
-
-            /* Set the END_FRAME interrupt */
-            if (ch->interrupts & END_FRAME_INTR)
-                ch->status |= END_FRAME_INTR;
-
-            if (a->frame == a->frames) {
-                /* End of Block */
-                /* Disable the channel */
-
-                if (!ch->auto_init)
-                    omap_dma_disable_channel(s, ch);
-                else if (ch->repeat || ch->end_prog)
-                    omap_dma_channel_load(ch);
-                else {
-                    ch->waiting_end_prog = 1;
-                    omap_dma_deactivate_channel(s, ch);
-                }
-
-                if (ch->interrupts & END_BLOCK_INTR)
-                    ch->status |= END_BLOCK_INTR;
-            }
-        }
-    } while (status == ch->status && ch->active);
-
-    omap_dma_interrupts_update(s);
-#endif
 }
 
 enum {
@@ -475,13 +399,6 @@ static void omap_dma_transfer_setup(struct soc_dma_ch_s *dma)
     dest_p = &s->mpu->port[ch->port[1]];
     if ((!ch->constant_fill && !src_p->addr_valid(s->mpu, a->src)) ||
                     (!dest_p->addr_valid(s->mpu, a->dest))) {
-#if 0
-        /* Bus time-out */
-        if (ch->interrupts & TIMEOUT_INTR)
-            ch->status |= TIMEOUT_INTR;
-        omap_dma_deactivate_channel(s, ch);
-        continue;
-#endif
         printf("%s: Bus time-out in DMA%i operation\n",
                         __func__, dma->num);
     }
@@ -552,11 +469,6 @@ static void omap_dma_transfer_setup(struct soc_dma_ch_s *dma)
 
     /* Set appropriate interrupts and/or deactivate channels */
 
-#ifdef MULTI_REQ
-    /* TODO: should all of this only be done if dma->update, and otherwise
-     * inside omap_dma_transfer_generic below - check what's faster.  */
-    if (dma->update) {
-#endif
 
         /* If the channel is element synchronized, deactivate it */
         if (min_elems == elements[omap_dma_intr_element_sync])
@@ -612,9 +524,7 @@ static void omap_dma_transfer_setup(struct soc_dma_ch_s *dma)
 
         /* TODO: check if we really need to update anything here or perhaps we
          * can skip part of this.  */
-#ifndef MULTI_REQ
         if (dma->update) {
-#endif
             a->element += min_elems;
 
             frames = a->element / a->elements;
@@ -629,11 +539,7 @@ static void omap_dma_transfer_setup(struct soc_dma_ch_s *dma)
 
             /* TODO: if the destination port is IMIF or EMIFF, set the dirty
              * bits on it.  */
-#ifndef MULTI_REQ
         }
-#else
-    }
-#endif
 
     omap_dma_interrupts_update(s);
 }
-- 
2.43.0


