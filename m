Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0DBBDCD379F
	for <qemu-devel@archiver.kernel.org>; Tue,  3 Sep 2024 16:13:39 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1slW56-000723-Ln; Tue, 03 Sep 2024 12:08:36 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1slW55-0006wq-BX
 for qemu-devel@nongnu.org; Tue, 03 Sep 2024 12:08:35 -0400
Received: from mail-wm1-x330.google.com ([2a00:1450:4864:20::330])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1slW50-0002ny-LJ
 for qemu-devel@nongnu.org; Tue, 03 Sep 2024 12:08:35 -0400
Received: by mail-wm1-x330.google.com with SMTP id
 5b1f17b1804b1-42bbe809b06so34545865e9.1
 for <qemu-devel@nongnu.org>; Tue, 03 Sep 2024 09:08:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1725379709; x=1725984509; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=5unmeuI8alOgM/XhlyusQhY9aV4SblS1jZdNnLGY91Q=;
 b=tlZd0x2AEzt00YKP6EfVjfn3WTpGjpxkfMCFBs9XZfIF+6SRghWmpvwhHdTmQ86QwS
 aNozQygFCVsAsA8x2TISVg9mXsQyNr5+gwhqsj9yhYUc9q65kZe3uzfhRDZxau2Ilxf7
 63lNlhldIJXGnx00oM/oEdQ38AtS+wriqY4jgnKyA6rpDA6dNfX/Y+uqVUEcYrVSyqdR
 P8f+CnTedEaj9fjW8e7Bk3J4YgznDOZ/lFkoNzgdR099rvS6nT2ZwYEg/m03oCy58C4C
 /gxPe/ieqXLvPjmN+M+QVjDoVtlTtqYDQmXTXUP6wRuYyjoNlt+07lydWgRclykFmWKH
 76uw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1725379709; x=1725984509;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=5unmeuI8alOgM/XhlyusQhY9aV4SblS1jZdNnLGY91Q=;
 b=mNNscarKLOTEbOHBobQH+sNyZfkHySrJ5q5hGRV91YKK0dFSVsS9KKXoRHjo2uNab5
 lFZnImbHDVKNZ8u/mJ+o2N7EF2+Hbyr5PbjC5XjrpiEbRqiqk9DQ9VbAp+eQsPknNGOJ
 iaMh5YwSSZmb5Cf0/v2OIPbbQ5WGhJAdY2WVg3bHLL0BstSS5r5ffFPFRTx9TePwQ6zO
 Z2nbXInrO1EaALnJ5TCJ1AzakMfkUB17A+6fWvc9iCbBPqgzVk50CdGb2yD7GSaGEUx3
 BL8ZR6FVI1VeO8O6RWrjv+4+DaThHvCIRunxDs6E5zTvbGW/Zop3JcvTtuSVkH5l/omd
 GOyA==
X-Forwarded-Encrypted: i=1;
 AJvYcCW4/Tp6uQYQzCiu7CBZAL0GyXrlpnUJMHecCt5TENrFHj2mOH1V25zSC9I4vMvr9afugMLdy43abHVs@nongnu.org
X-Gm-Message-State: AOJu0Yxg5tU4UXwqwjqg9F6Uqirim47sVwcDcwm0UF3BHN3vj6WwN3wY
 fXI2fUoq/jvTSOQnxlQpz38idj1mTwEM+Q3e6VnrQScspOONjdfK3DzLplTf/N1dkSZ5dnV6jo8
 O
X-Google-Smtp-Source: AGHT+IFBmumiEaifNwvZ5zjKCPDzU5G5T5Q7/nELdweyArKKVvCSdi/XweRXKWXV2tv0e8DrcQwJmQ==
X-Received: by 2002:a05:600c:19c6:b0:428:1e8c:ff75 with SMTP id
 5b1f17b1804b1-42bb27bc825mr133913535e9.35.1725379709077; 
 Tue, 03 Sep 2024 09:08:29 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [2001:8b0:1d0::2])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-42bb6df1066sm175123065e9.18.2024.09.03.09.08.26
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 03 Sep 2024 09:08:26 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-arm@nongnu.org,
	qemu-devel@nongnu.org
Subject: [PATCH for-9.2 19/53] hw/dma: Remove pxa2xx_dma
Date: Tue,  3 Sep 2024 17:07:17 +0100
Message-Id: <20240903160751.4100218-20-peter.maydell@linaro.org>
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
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=unavailable autolearn_force=no
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

Remove the pxa2xx-specific pxa2xx_dma device.

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 include/hw/arm/pxa.h |   4 -
 hw/dma/pxa2xx_dma.c  | 591 -------------------------------------------
 hw/dma/meson.build   |   1 -
 3 files changed, 596 deletions(-)
 delete mode 100644 hw/dma/pxa2xx_dma.c

diff --git a/include/hw/arm/pxa.h b/include/hw/arm/pxa.h
index ef7976e1821..944926e514b 100644
--- a/include/hw/arm/pxa.h
+++ b/include/hw/arm/pxa.h
@@ -76,10 +76,6 @@ DeviceState *pxa2xx_gpio_init(hwaddr base,
                               ARMCPU *cpu, DeviceState *pic, int lines);
 void pxa2xx_gpio_read_notifier(DeviceState *dev, qemu_irq handler);
 
-/* pxa2xx_dma.c */
-DeviceState *pxa255_dma_init(hwaddr base, qemu_irq irq);
-DeviceState *pxa27x_dma_init(hwaddr base, qemu_irq irq);
-
 /* pxa2xx_pcmcia.c */
 #define TYPE_PXA2XX_PCMCIA "pxa2xx-pcmcia"
 OBJECT_DECLARE_SIMPLE_TYPE(PXA2xxPCMCIAState, PXA2XX_PCMCIA)
diff --git a/hw/dma/pxa2xx_dma.c b/hw/dma/pxa2xx_dma.c
deleted file mode 100644
index 9f62f0b633b..00000000000
--- a/hw/dma/pxa2xx_dma.c
+++ /dev/null
@@ -1,591 +0,0 @@
-/*
- * Intel XScale PXA255/270 DMA controller.
- *
- * Copyright (c) 2006 Openedhand Ltd.
- * Copyright (c) 2006 Thorsten Zitterell
- * Written by Andrzej Zaborowski <balrog@zabor.org>
- *
- * This code is licensed under the GPL.
- */
-
-#include "qemu/osdep.h"
-#include "qemu/log.h"
-#include "hw/hw.h"
-#include "hw/irq.h"
-#include "hw/qdev-properties.h"
-#include "hw/arm/pxa.h"
-#include "hw/sysbus.h"
-#include "migration/vmstate.h"
-#include "qapi/error.h"
-#include "qemu/module.h"
-#include "qom/object.h"
-
-#define PXA255_DMA_NUM_CHANNELS 16
-#define PXA27X_DMA_NUM_CHANNELS 32
-
-#define PXA2XX_DMA_NUM_REQUESTS 75
-
-typedef struct {
-    uint32_t descr;
-    uint32_t src;
-    uint32_t dest;
-    uint32_t cmd;
-    uint32_t state;
-    int request;
-} PXA2xxDMAChannel;
-
-#define TYPE_PXA2XX_DMA "pxa2xx-dma"
-OBJECT_DECLARE_SIMPLE_TYPE(PXA2xxDMAState, PXA2XX_DMA)
-
-struct PXA2xxDMAState {
-    SysBusDevice parent_obj;
-
-    MemoryRegion iomem;
-    qemu_irq irq;
-
-    uint32_t stopintr;
-    uint32_t eorintr;
-    uint32_t rasintr;
-    uint32_t startintr;
-    uint32_t endintr;
-
-    uint32_t align;
-    uint32_t pio;
-
-    int channels;
-    PXA2xxDMAChannel *chan;
-
-    uint8_t req[PXA2XX_DMA_NUM_REQUESTS];
-
-    /* Flag to avoid recursive DMA invocations.  */
-    int running;
-};
-
-#define DCSR0	0x0000	/* DMA Control / Status register for Channel 0 */
-#define DCSR31	0x007c	/* DMA Control / Status register for Channel 31 */
-#define DALGN	0x00a0	/* DMA Alignment register */
-#define DPCSR	0x00a4	/* DMA Programmed I/O Control Status register */
-#define DRQSR0	0x00e0	/* DMA DREQ<0> Status register */
-#define DRQSR1	0x00e4	/* DMA DREQ<1> Status register */
-#define DRQSR2	0x00e8	/* DMA DREQ<2> Status register */
-#define DINT	0x00f0	/* DMA Interrupt register */
-#define DRCMR0	0x0100	/* Request to Channel Map register 0 */
-#define DRCMR63	0x01fc	/* Request to Channel Map register 63 */
-#define D_CH0	0x0200	/* Channel 0 Descriptor start */
-#define DRCMR64	0x1100	/* Request to Channel Map register 64 */
-#define DRCMR74	0x1128	/* Request to Channel Map register 74 */
-
-/* Per-channel register */
-#define DDADR	0x00
-#define DSADR	0x01
-#define DTADR	0x02
-#define DCMD	0x03
-
-/* Bit-field masks */
-#define DRCMR_CHLNUM		0x1f
-#define DRCMR_MAPVLD		(1 << 7)
-#define DDADR_STOP		(1 << 0)
-#define DDADR_BREN		(1 << 1)
-#define DCMD_LEN		0x1fff
-#define DCMD_WIDTH(x)		(1 << ((((x) >> 14) & 3) - 1))
-#define DCMD_SIZE(x)		(4 << (((x) >> 16) & 3))
-#define DCMD_FLYBYT		(1 << 19)
-#define DCMD_FLYBYS		(1 << 20)
-#define DCMD_ENDIRQEN		(1 << 21)
-#define DCMD_STARTIRQEN		(1 << 22)
-#define DCMD_CMPEN		(1 << 25)
-#define DCMD_FLOWTRG		(1 << 28)
-#define DCMD_FLOWSRC		(1 << 29)
-#define DCMD_INCTRGADDR		(1 << 30)
-#define DCMD_INCSRCADDR		(1 << 31)
-#define DCSR_BUSERRINTR		(1 << 0)
-#define DCSR_STARTINTR		(1 << 1)
-#define DCSR_ENDINTR		(1 << 2)
-#define DCSR_STOPINTR		(1 << 3)
-#define DCSR_RASINTR		(1 << 4)
-#define DCSR_REQPEND		(1 << 8)
-#define DCSR_EORINT		(1 << 9)
-#define DCSR_CMPST		(1 << 10)
-#define DCSR_MASKRUN		(1 << 22)
-#define DCSR_RASIRQEN		(1 << 23)
-#define DCSR_CLRCMPST		(1 << 24)
-#define DCSR_SETCMPST		(1 << 25)
-#define DCSR_EORSTOPEN		(1 << 26)
-#define DCSR_EORJMPEN		(1 << 27)
-#define DCSR_EORIRQEN		(1 << 28)
-#define DCSR_STOPIRQEN		(1 << 29)
-#define DCSR_NODESCFETCH	(1 << 30)
-#define DCSR_RUN		(1 << 31)
-
-static inline void pxa2xx_dma_update(PXA2xxDMAState *s, int ch)
-{
-    if (ch >= 0) {
-        if ((s->chan[ch].state & DCSR_STOPIRQEN) &&
-                (s->chan[ch].state & DCSR_STOPINTR))
-            s->stopintr |= 1 << ch;
-        else
-            s->stopintr &= ~(1 << ch);
-
-        if ((s->chan[ch].state & DCSR_EORIRQEN) &&
-                (s->chan[ch].state & DCSR_EORINT))
-            s->eorintr |= 1 << ch;
-        else
-            s->eorintr &= ~(1 << ch);
-
-        if ((s->chan[ch].state & DCSR_RASIRQEN) &&
-                (s->chan[ch].state & DCSR_RASINTR))
-            s->rasintr |= 1 << ch;
-        else
-            s->rasintr &= ~(1 << ch);
-
-        if (s->chan[ch].state & DCSR_STARTINTR)
-            s->startintr |= 1 << ch;
-        else
-            s->startintr &= ~(1 << ch);
-
-        if (s->chan[ch].state & DCSR_ENDINTR)
-            s->endintr |= 1 << ch;
-        else
-            s->endintr &= ~(1 << ch);
-    }
-
-    if (s->stopintr | s->eorintr | s->rasintr | s->startintr | s->endintr)
-        qemu_irq_raise(s->irq);
-    else
-        qemu_irq_lower(s->irq);
-}
-
-static inline void pxa2xx_dma_descriptor_fetch(
-                PXA2xxDMAState *s, int ch)
-{
-    uint32_t desc[4];
-    hwaddr daddr = s->chan[ch].descr & ~0xf;
-    if ((s->chan[ch].descr & DDADR_BREN) && (s->chan[ch].state & DCSR_CMPST))
-        daddr += 32;
-
-    cpu_physical_memory_read(daddr, desc, 16);
-    s->chan[ch].descr = desc[DDADR];
-    s->chan[ch].src = desc[DSADR];
-    s->chan[ch].dest = desc[DTADR];
-    s->chan[ch].cmd = desc[DCMD];
-
-    if (s->chan[ch].cmd & DCMD_FLOWSRC)
-        s->chan[ch].src &= ~3;
-    if (s->chan[ch].cmd & DCMD_FLOWTRG)
-        s->chan[ch].dest &= ~3;
-
-    if (s->chan[ch].cmd & (DCMD_CMPEN | DCMD_FLYBYS | DCMD_FLYBYT))
-        printf("%s: unsupported mode in channel %i\n", __func__, ch);
-
-    if (s->chan[ch].cmd & DCMD_STARTIRQEN)
-        s->chan[ch].state |= DCSR_STARTINTR;
-}
-
-static void pxa2xx_dma_run(PXA2xxDMAState *s)
-{
-    int c, srcinc, destinc;
-    uint32_t n, size;
-    uint32_t width;
-    uint32_t length;
-    uint8_t buffer[32];
-    PXA2xxDMAChannel *ch;
-
-    if (s->running ++)
-        return;
-
-    while (s->running) {
-        s->running = 1;
-        for (c = 0; c < s->channels; c ++) {
-            ch = &s->chan[c];
-
-            while ((ch->state & DCSR_RUN) && !(ch->state & DCSR_STOPINTR)) {
-                /* Test for pending requests */
-                if ((ch->cmd & (DCMD_FLOWSRC | DCMD_FLOWTRG)) && !ch->request)
-                    break;
-
-                length = ch->cmd & DCMD_LEN;
-                size = DCMD_SIZE(ch->cmd);
-                width = DCMD_WIDTH(ch->cmd);
-
-                srcinc = (ch->cmd & DCMD_INCSRCADDR) ? width : 0;
-                destinc = (ch->cmd & DCMD_INCTRGADDR) ? width : 0;
-
-                while (length) {
-                    size = MIN(length, size);
-
-                    for (n = 0; n < size; n += width) {
-                        cpu_physical_memory_read(ch->src, buffer + n, width);
-                        ch->src += srcinc;
-                    }
-
-                    for (n = 0; n < size; n += width) {
-                        cpu_physical_memory_write(ch->dest, buffer + n, width);
-                        ch->dest += destinc;
-                    }
-
-                    length -= size;
-
-                    if ((ch->cmd & (DCMD_FLOWSRC | DCMD_FLOWTRG)) &&
-                            !ch->request) {
-                        ch->state |= DCSR_EORINT;
-                        if (ch->state & DCSR_EORSTOPEN)
-                            ch->state |= DCSR_STOPINTR;
-                        if ((ch->state & DCSR_EORJMPEN) &&
-                                        !(ch->state & DCSR_NODESCFETCH))
-                            pxa2xx_dma_descriptor_fetch(s, c);
-                        break;
-                    }
-                }
-
-                ch->cmd = (ch->cmd & ~DCMD_LEN) | length;
-
-                /* Is the transfer complete now? */
-                if (!length) {
-                    if (ch->cmd & DCMD_ENDIRQEN)
-                        ch->state |= DCSR_ENDINTR;
-
-                    if ((ch->state & DCSR_NODESCFETCH) ||
-                                (ch->descr & DDADR_STOP) ||
-                                (ch->state & DCSR_EORSTOPEN)) {
-                        ch->state |= DCSR_STOPINTR;
-                        ch->state &= ~DCSR_RUN;
-
-                        break;
-                    }
-
-                    ch->state |= DCSR_STOPINTR;
-                    break;
-                }
-            }
-        }
-
-        s->running --;
-    }
-}
-
-static uint64_t pxa2xx_dma_read(void *opaque, hwaddr offset,
-                                unsigned size)
-{
-    PXA2xxDMAState *s = (PXA2xxDMAState *) opaque;
-    unsigned int channel;
-
-    if (size != 4) {
-        qemu_log_mask(LOG_GUEST_ERROR, "%s: Bad access width %u\n",
-                      __func__, size);
-        return 5;
-    }
-
-    switch (offset) {
-    case DRCMR64 ... DRCMR74:
-        offset -= DRCMR64 - DRCMR0 - (64 << 2);
-        /* Fall through */
-    case DRCMR0 ... DRCMR63:
-        channel = (offset - DRCMR0) >> 2;
-        return s->req[channel];
-
-    case DRQSR0:
-    case DRQSR1:
-    case DRQSR2:
-        return 0;
-
-    case DCSR0 ... DCSR31:
-        channel = offset >> 2;
-        if (s->chan[channel].request)
-            return s->chan[channel].state | DCSR_REQPEND;
-        return s->chan[channel].state;
-
-    case DINT:
-        return s->stopintr | s->eorintr | s->rasintr |
-                s->startintr | s->endintr;
-
-    case DALGN:
-        return s->align;
-
-    case DPCSR:
-        return s->pio;
-    }
-
-    if (offset >= D_CH0 && offset < D_CH0 + (s->channels << 4)) {
-        channel = (offset - D_CH0) >> 4;
-        switch ((offset & 0x0f) >> 2) {
-        case DDADR:
-            return s->chan[channel].descr;
-        case DSADR:
-            return s->chan[channel].src;
-        case DTADR:
-            return s->chan[channel].dest;
-        case DCMD:
-            return s->chan[channel].cmd;
-        }
-    }
-    qemu_log_mask(LOG_GUEST_ERROR, "%s: Bad offset 0x%" HWADDR_PRIX "\n",
-                  __func__, offset);
-    return 7;
-}
-
-static void pxa2xx_dma_write(void *opaque, hwaddr offset,
-                             uint64_t value, unsigned size)
-{
-    PXA2xxDMAState *s = (PXA2xxDMAState *) opaque;
-    unsigned int channel;
-
-    if (size != 4) {
-        qemu_log_mask(LOG_GUEST_ERROR, "%s: Bad access width %u\n",
-                      __func__, size);
-        return;
-    }
-
-    switch (offset) {
-    case DRCMR64 ... DRCMR74:
-        offset -= DRCMR64 - DRCMR0 - (64 << 2);
-        /* Fall through */
-    case DRCMR0 ... DRCMR63:
-        channel = (offset - DRCMR0) >> 2;
-
-        if (value & DRCMR_MAPVLD)
-            if ((value & DRCMR_CHLNUM) > s->channels)
-                hw_error("%s: Bad DMA channel %i\n",
-                         __func__, (unsigned)value & DRCMR_CHLNUM);
-
-        s->req[channel] = value;
-        break;
-
-    case DRQSR0:
-    case DRQSR1:
-    case DRQSR2:
-        /* Nothing to do */
-        break;
-
-    case DCSR0 ... DCSR31:
-        channel = offset >> 2;
-        s->chan[channel].state &= 0x0000071f & ~(value &
-                        (DCSR_EORINT | DCSR_ENDINTR |
-                         DCSR_STARTINTR | DCSR_BUSERRINTR));
-        s->chan[channel].state |= value & 0xfc800000;
-
-        if (s->chan[channel].state & DCSR_STOPIRQEN)
-            s->chan[channel].state &= ~DCSR_STOPINTR;
-
-        if (value & DCSR_NODESCFETCH) {
-            /* No-descriptor-fetch mode */
-            if (value & DCSR_RUN) {
-                s->chan[channel].state &= ~DCSR_STOPINTR;
-                pxa2xx_dma_run(s);
-            }
-        } else {
-            /* Descriptor-fetch mode */
-            if (value & DCSR_RUN) {
-                s->chan[channel].state &= ~DCSR_STOPINTR;
-                pxa2xx_dma_descriptor_fetch(s, channel);
-                pxa2xx_dma_run(s);
-            }
-        }
-
-        /* Shouldn't matter as our DMA is synchronous.  */
-        if (!(value & (DCSR_RUN | DCSR_MASKRUN)))
-            s->chan[channel].state |= DCSR_STOPINTR;
-
-        if (value & DCSR_CLRCMPST)
-            s->chan[channel].state &= ~DCSR_CMPST;
-        if (value & DCSR_SETCMPST)
-            s->chan[channel].state |= DCSR_CMPST;
-
-        pxa2xx_dma_update(s, channel);
-        break;
-
-    case DALGN:
-        s->align = value;
-        break;
-
-    case DPCSR:
-        s->pio = value & 0x80000001;
-        break;
-
-    default:
-        if (offset >= D_CH0 && offset < D_CH0 + (s->channels << 4)) {
-            channel = (offset - D_CH0) >> 4;
-            switch ((offset & 0x0f) >> 2) {
-            case DDADR:
-                s->chan[channel].descr = value;
-                break;
-            case DSADR:
-                s->chan[channel].src = value;
-                break;
-            case DTADR:
-                s->chan[channel].dest = value;
-                break;
-            case DCMD:
-                s->chan[channel].cmd = value;
-                break;
-            default:
-                goto fail;
-            }
-
-            break;
-        }
-    fail:
-        qemu_log_mask(LOG_GUEST_ERROR, "%s: Bad offset 0x%" HWADDR_PRIX "\n",
-                      __func__, offset);
-    }
-}
-
-static const MemoryRegionOps pxa2xx_dma_ops = {
-    .read = pxa2xx_dma_read,
-    .write = pxa2xx_dma_write,
-    .endianness = DEVICE_NATIVE_ENDIAN,
-};
-
-static void pxa2xx_dma_request(void *opaque, int req_num, int on)
-{
-    PXA2xxDMAState *s = opaque;
-    int ch;
-    if (req_num < 0 || req_num >= PXA2XX_DMA_NUM_REQUESTS)
-        hw_error("%s: Bad DMA request %i\n", __func__, req_num);
-
-    if (!(s->req[req_num] & DRCMR_MAPVLD))
-        return;
-    ch = s->req[req_num] & DRCMR_CHLNUM;
-
-    if (!s->chan[ch].request && on)
-        s->chan[ch].state |= DCSR_RASINTR;
-    else
-        s->chan[ch].state &= ~DCSR_RASINTR;
-    if (s->chan[ch].request && !on)
-        s->chan[ch].state |= DCSR_EORINT;
-
-    s->chan[ch].request = on;
-    if (on) {
-        pxa2xx_dma_run(s);
-        pxa2xx_dma_update(s, ch);
-    }
-}
-
-static void pxa2xx_dma_init(Object *obj)
-{
-    DeviceState *dev = DEVICE(obj);
-    PXA2xxDMAState *s = PXA2XX_DMA(obj);
-    SysBusDevice *sbd = SYS_BUS_DEVICE(obj);
-
-    memset(s->req, 0, sizeof(uint8_t) * PXA2XX_DMA_NUM_REQUESTS);
-
-    qdev_init_gpio_in(dev, pxa2xx_dma_request, PXA2XX_DMA_NUM_REQUESTS);
-
-    memory_region_init_io(&s->iomem, obj, &pxa2xx_dma_ops, s,
-                          "pxa2xx.dma", 0x00010000);
-    sysbus_init_mmio(sbd, &s->iomem);
-    sysbus_init_irq(sbd, &s->irq);
-}
-
-static void pxa2xx_dma_realize(DeviceState *dev, Error **errp)
-{
-    PXA2xxDMAState *s = PXA2XX_DMA(dev);
-    int i;
-
-    if (s->channels <= 0) {
-        error_setg(errp, "channels value invalid");
-        return;
-    }
-
-    s->chan = g_new0(PXA2xxDMAChannel, s->channels);
-
-    for (i = 0; i < s->channels; i ++)
-        s->chan[i].state = DCSR_STOPINTR;
-}
-
-DeviceState *pxa27x_dma_init(hwaddr base, qemu_irq irq)
-{
-    DeviceState *dev;
-
-    dev = qdev_new("pxa2xx-dma");
-    qdev_prop_set_int32(dev, "channels", PXA27X_DMA_NUM_CHANNELS);
-    sysbus_realize_and_unref(SYS_BUS_DEVICE(dev), &error_fatal);
-
-    sysbus_mmio_map(SYS_BUS_DEVICE(dev), 0, base);
-    sysbus_connect_irq(SYS_BUS_DEVICE(dev), 0, irq);
-
-    return dev;
-}
-
-DeviceState *pxa255_dma_init(hwaddr base, qemu_irq irq)
-{
-    DeviceState *dev;
-
-    dev = qdev_new("pxa2xx-dma");
-    qdev_prop_set_int32(dev, "channels", PXA27X_DMA_NUM_CHANNELS);
-    sysbus_realize_and_unref(SYS_BUS_DEVICE(dev), &error_fatal);
-
-    sysbus_mmio_map(SYS_BUS_DEVICE(dev), 0, base);
-    sysbus_connect_irq(SYS_BUS_DEVICE(dev), 0, irq);
-
-    return dev;
-}
-
-static bool is_version_0(void *opaque, int version_id)
-{
-    return version_id == 0;
-}
-
-static const VMStateDescription vmstate_pxa2xx_dma_chan = {
-    .name = "pxa2xx_dma_chan",
-    .version_id = 1,
-    .minimum_version_id = 1,
-    .fields = (const VMStateField[]) {
-        VMSTATE_UINT32(descr, PXA2xxDMAChannel),
-        VMSTATE_UINT32(src, PXA2xxDMAChannel),
-        VMSTATE_UINT32(dest, PXA2xxDMAChannel),
-        VMSTATE_UINT32(cmd, PXA2xxDMAChannel),
-        VMSTATE_UINT32(state, PXA2xxDMAChannel),
-        VMSTATE_INT32(request, PXA2xxDMAChannel),
-        VMSTATE_END_OF_LIST(),
-    },
-};
-
-static const VMStateDescription vmstate_pxa2xx_dma = {
-    .name = "pxa2xx_dma",
-    .version_id = 1,
-    .minimum_version_id = 0,
-    .fields = (const VMStateField[]) {
-        VMSTATE_UNUSED_TEST(is_version_0, 4),
-        VMSTATE_UINT32(stopintr, PXA2xxDMAState),
-        VMSTATE_UINT32(eorintr, PXA2xxDMAState),
-        VMSTATE_UINT32(rasintr, PXA2xxDMAState),
-        VMSTATE_UINT32(startintr, PXA2xxDMAState),
-        VMSTATE_UINT32(endintr, PXA2xxDMAState),
-        VMSTATE_UINT32(align, PXA2xxDMAState),
-        VMSTATE_UINT32(pio, PXA2xxDMAState),
-        VMSTATE_BUFFER(req, PXA2xxDMAState),
-        VMSTATE_STRUCT_VARRAY_POINTER_INT32(chan, PXA2xxDMAState, channels,
-                vmstate_pxa2xx_dma_chan, PXA2xxDMAChannel),
-        VMSTATE_END_OF_LIST(),
-    },
-};
-
-static Property pxa2xx_dma_properties[] = {
-    DEFINE_PROP_INT32("channels", PXA2xxDMAState, channels, -1),
-    DEFINE_PROP_END_OF_LIST(),
-};
-
-static void pxa2xx_dma_class_init(ObjectClass *klass, void *data)
-{
-    DeviceClass *dc = DEVICE_CLASS(klass);
-
-    dc->desc = "PXA2xx DMA controller";
-    dc->vmsd = &vmstate_pxa2xx_dma;
-    device_class_set_props(dc, pxa2xx_dma_properties);
-    dc->realize = pxa2xx_dma_realize;
-}
-
-static const TypeInfo pxa2xx_dma_info = {
-    .name          = TYPE_PXA2XX_DMA,
-    .parent        = TYPE_SYS_BUS_DEVICE,
-    .instance_size = sizeof(PXA2xxDMAState),
-    .instance_init = pxa2xx_dma_init,
-    .class_init    = pxa2xx_dma_class_init,
-};
-
-static void pxa2xx_dma_register_types(void)
-{
-    type_register_static(&pxa2xx_dma_info);
-}
-
-type_init(pxa2xx_dma_register_types)
diff --git a/hw/dma/meson.build b/hw/dma/meson.build
index a96c1be2c8d..90c875ac51a 100644
--- a/hw/dma/meson.build
+++ b/hw/dma/meson.build
@@ -10,7 +10,6 @@ system_ss.add(when: 'CONFIG_STP2000', if_true: files('sparc32_dma.c'))
 system_ss.add(when: 'CONFIG_XLNX_ZYNQMP_ARM', if_true: files('xlnx_dpdma.c'))
 system_ss.add(when: 'CONFIG_XLNX_ZDMA', if_true: files('xlnx-zdma.c'))
 system_ss.add(when: 'CONFIG_OMAP', if_true: files('omap_dma.c', 'soc_dma.c'))
-system_ss.add(when: 'CONFIG_PXA2XX', if_true: files('pxa2xx_dma.c'))
 system_ss.add(when: 'CONFIG_RASPI', if_true: files('bcm2835_dma.c'))
 system_ss.add(when: 'CONFIG_SIFIVE_PDMA', if_true: files('sifive_pdma.c'))
 system_ss.add(when: 'CONFIG_XLNX_CSU_DMA', if_true: files('xlnx_csu_dma.c'))
-- 
2.34.1


