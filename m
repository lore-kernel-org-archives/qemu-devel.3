Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A1672CD379F
	for <qemu-devel@archiver.kernel.org>; Tue,  3 Sep 2024 16:11:01 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1slW57-000750-D0; Tue, 03 Sep 2024 12:08:37 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1slW56-00072I-Mw
 for qemu-devel@nongnu.org; Tue, 03 Sep 2024 12:08:36 -0400
Received: from mail-wm1-x329.google.com ([2a00:1450:4864:20::329])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1slW51-0002o8-Gw
 for qemu-devel@nongnu.org; Tue, 03 Sep 2024 12:08:36 -0400
Received: by mail-wm1-x329.google.com with SMTP id
 5b1f17b1804b1-42bbf138477so33770205e9.2
 for <qemu-devel@nongnu.org>; Tue, 03 Sep 2024 09:08:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1725379710; x=1725984510; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=QtQ5OrKSW2t6fizJbre4gyRxKdC3jG5vkpvzi9b1A8w=;
 b=c13ijzcIMlB2w9KPTwC8tQPVEBk46Q8sv9xLOKbKL0HqikWJ5Rlzo4kjv0yB8vPyyi
 3w5ogNSt7O5hcM1orTOx1zE01bRsKzUJSc2A4kr62BVSgNg4FZqba+EjfYvbtGeQaSxd
 NMdHK5TbCzgnnQKhGYDqlNrUlE4oRUWW25yFlFDlf5msv2TLFwFxrRfRQGGPAo2TUFMb
 NUAyX0WRcVGzBSKtFxMVKtWzmPHE66SbtTEi8EsgJewlNBmZ7wR7zcVyrmEq5RNIAi3I
 WBDr+jZMnCIw4DS8jS4Nufg+WF2GxZcBTM4XgW/pA3ASaetBt2dno/t0dk47bcw1CObC
 lABA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1725379710; x=1725984510;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=QtQ5OrKSW2t6fizJbre4gyRxKdC3jG5vkpvzi9b1A8w=;
 b=qPyZJ/BpEGwbcJC058geFhrrJ3ehGKKpeP9buSquu8tviyTObQ4BgE4GLNvoGlO3LY
 P2eNJYVUH0utXY4HshXXpPyKbAv2v3hlOvn7KbAA5FO6ZXj4H1AhmNJl/vHL+BwYkBnq
 VbhGk5Y+dR+ldU7Q4OazSyI8G/G8u5E8+qOdXj0FfawenKQrL508xxH6PvMfbhz9aG/S
 /1YlzohCs2IuU6VOHat+0PE0uCTvGR6vAkUBr5Kx991SmyFt1WSwiYlgIyrY0O8iEfEy
 HjiY91p1L+4wFSXvjFwz0oTf7l4KMWXObiEAK68tcve6CKxEd32VSRBrzfveYF9YQ6m1
 Og3g==
X-Forwarded-Encrypted: i=1;
 AJvYcCWFMxl/LFQyStvUlDL7lG5UhVRy+QEnnuhYYBraEmMNbJGvfQWQyyHyZap+hh7o6L63yvfI7TkshlqZ@nongnu.org
X-Gm-Message-State: AOJu0YzPnf7Ey48jpkI/ZnSB0Fk3/w6ecowQDDBhidbMsI/UEfqO+2oX
 5zi9JvaYR989ZZXXOWTPuTNGDIUF/OLgXOQyrhL+Y8/11Z0Jcu+1Qf0vWSyaznB7y33e58S/lzQ
 A
X-Google-Smtp-Source: AGHT+IHTj+yTmcwW3Uw8jmHwDTKG5raPogogt0m+i7gdKCd7aDwH8SvFYUKFN9/I5jD2p1WBEQQKPA==
X-Received: by 2002:a05:600c:4f8e:b0:426:6edb:7e14 with SMTP id
 5b1f17b1804b1-42c881085ecmr27252485e9.35.1725379710130; 
 Tue, 03 Sep 2024 09:08:30 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [2001:8b0:1d0::2])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-42bb6df1066sm175123065e9.18.2024.09.03.09.08.29
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 03 Sep 2024 09:08:29 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-arm@nongnu.org,
	qemu-devel@nongnu.org
Subject: [PATCH for-9.2 20/53] hw/pcmcia: Remove pxa2xx pcmcia device
Date: Tue,  3 Sep 2024 17:07:18 +0100
Message-Id: <20240903160751.4100218-21-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240903160751.4100218-1-peter.maydell@linaro.org>
References: <20240903160751.4100218-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::329;
 envelope-from=peter.maydell@linaro.org; helo=mail-wm1-x329.google.com
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

Remove the pxa2xx specific pcmcia device.

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 include/hw/arm/pxa.h  |   8 --
 hw/pcmcia/pxa2xx.c    | 248 ------------------------------------------
 hw/pcmcia/meson.build |   1 -
 3 files changed, 257 deletions(-)
 delete mode 100644 hw/pcmcia/pxa2xx.c

diff --git a/include/hw/arm/pxa.h b/include/hw/arm/pxa.h
index 944926e514b..5f98536bc69 100644
--- a/include/hw/arm/pxa.h
+++ b/include/hw/arm/pxa.h
@@ -76,12 +76,4 @@ DeviceState *pxa2xx_gpio_init(hwaddr base,
                               ARMCPU *cpu, DeviceState *pic, int lines);
 void pxa2xx_gpio_read_notifier(DeviceState *dev, qemu_irq handler);
 
-/* pxa2xx_pcmcia.c */
-#define TYPE_PXA2XX_PCMCIA "pxa2xx-pcmcia"
-OBJECT_DECLARE_SIMPLE_TYPE(PXA2xxPCMCIAState, PXA2XX_PCMCIA)
-
-int pxa2xx_pcmcia_attach(void *opaque, PCMCIACardState *card);
-int pxa2xx_pcmcia_detach(void *opaque);
-void pxa2xx_pcmcia_set_irq_cb(void *opaque, qemu_irq irq, qemu_irq cd_irq);
-
 #endif /* PXA_H */
diff --git a/hw/pcmcia/pxa2xx.c b/hw/pcmcia/pxa2xx.c
deleted file mode 100644
index e3111fdf1a1..00000000000
--- a/hw/pcmcia/pxa2xx.c
+++ /dev/null
@@ -1,248 +0,0 @@
-/*
- * Intel XScale PXA255/270 PC Card and CompactFlash Interface.
- *
- * Copyright (c) 2006 Openedhand Ltd.
- * Written by Andrzej Zaborowski <balrog@zabor.org>
- *
- * This code is licensed under the GPLv2.
- *
- * Contributions after 2012-01-13 are licensed under the terms of the
- * GNU GPL, version 2 or (at your option) any later version.
- */
-
-#include "qemu/osdep.h"
-#include "hw/irq.h"
-#include "hw/sysbus.h"
-#include "qapi/error.h"
-#include "qemu/module.h"
-#include "hw/pcmcia.h"
-#include "hw/arm/pxa.h"
-
-struct PXA2xxPCMCIAState {
-    SysBusDevice parent_obj;
-
-    PCMCIASocket slot;
-    MemoryRegion container_mem;
-    MemoryRegion common_iomem;
-    MemoryRegion attr_iomem;
-    MemoryRegion iomem;
-
-    qemu_irq irq;
-    qemu_irq cd_irq;
-
-    PCMCIACardState *card;
-};
-
-static uint64_t pxa2xx_pcmcia_common_read(void *opaque,
-                hwaddr offset, unsigned size)
-{
-    PXA2xxPCMCIAState *s = (PXA2xxPCMCIAState *) opaque;
-    PCMCIACardClass *pcc;
-
-    if (s->slot.attached) {
-        pcc = PCMCIA_CARD_GET_CLASS(s->card);
-        return pcc->common_read(s->card, offset);
-    }
-
-    return 0;
-}
-
-static void pxa2xx_pcmcia_common_write(void *opaque, hwaddr offset,
-                                       uint64_t value, unsigned size)
-{
-    PXA2xxPCMCIAState *s = (PXA2xxPCMCIAState *) opaque;
-    PCMCIACardClass *pcc;
-
-    if (s->slot.attached) {
-        pcc = PCMCIA_CARD_GET_CLASS(s->card);
-        pcc->common_write(s->card, offset, value);
-    }
-}
-
-static uint64_t pxa2xx_pcmcia_attr_read(void *opaque,
-                hwaddr offset, unsigned size)
-{
-    PXA2xxPCMCIAState *s = (PXA2xxPCMCIAState *) opaque;
-    PCMCIACardClass *pcc;
-
-    if (s->slot.attached) {
-        pcc = PCMCIA_CARD_GET_CLASS(s->card);
-        return pcc->attr_read(s->card, offset);
-    }
-
-    return 0;
-}
-
-static void pxa2xx_pcmcia_attr_write(void *opaque, hwaddr offset,
-                                     uint64_t value, unsigned size)
-{
-    PXA2xxPCMCIAState *s = (PXA2xxPCMCIAState *) opaque;
-    PCMCIACardClass *pcc;
-
-    if (s->slot.attached) {
-        pcc = PCMCIA_CARD_GET_CLASS(s->card);
-        pcc->attr_write(s->card, offset, value);
-    }
-}
-
-static uint64_t pxa2xx_pcmcia_io_read(void *opaque,
-                hwaddr offset, unsigned size)
-{
-    PXA2xxPCMCIAState *s = (PXA2xxPCMCIAState *) opaque;
-    PCMCIACardClass *pcc;
-
-    if (s->slot.attached) {
-        pcc = PCMCIA_CARD_GET_CLASS(s->card);
-        return pcc->io_read(s->card, offset);
-    }
-
-    return 0;
-}
-
-static void pxa2xx_pcmcia_io_write(void *opaque, hwaddr offset,
-                                   uint64_t value, unsigned size)
-{
-    PXA2xxPCMCIAState *s = (PXA2xxPCMCIAState *) opaque;
-    PCMCIACardClass *pcc;
-
-    if (s->slot.attached) {
-        pcc = PCMCIA_CARD_GET_CLASS(s->card);
-        pcc->io_write(s->card, offset, value);
-    }
-}
-
-static const MemoryRegionOps pxa2xx_pcmcia_common_ops = {
-    .read = pxa2xx_pcmcia_common_read,
-    .write = pxa2xx_pcmcia_common_write,
-    .endianness = DEVICE_NATIVE_ENDIAN
-};
-
-static const MemoryRegionOps pxa2xx_pcmcia_attr_ops = {
-    .read = pxa2xx_pcmcia_attr_read,
-    .write = pxa2xx_pcmcia_attr_write,
-    .endianness = DEVICE_NATIVE_ENDIAN
-};
-
-static const MemoryRegionOps pxa2xx_pcmcia_io_ops = {
-    .read = pxa2xx_pcmcia_io_read,
-    .write = pxa2xx_pcmcia_io_write,
-    .endianness = DEVICE_NATIVE_ENDIAN
-};
-
-static void pxa2xx_pcmcia_set_irq(void *opaque, int line, int level)
-{
-    PXA2xxPCMCIAState *s = (PXA2xxPCMCIAState *) opaque;
-    if (!s->irq)
-        return;
-
-    qemu_set_irq(s->irq, level);
-}
-
-static void pxa2xx_pcmcia_initfn(Object *obj)
-{
-    SysBusDevice *sbd = SYS_BUS_DEVICE(obj);
-    PXA2xxPCMCIAState *s = PXA2XX_PCMCIA(obj);
-
-    memory_region_init(&s->container_mem, obj, "container", 0x10000000);
-    sysbus_init_mmio(sbd, &s->container_mem);
-
-    /* Socket I/O Memory Space */
-    memory_region_init_io(&s->iomem, obj, &pxa2xx_pcmcia_io_ops, s,
-                          "pxa2xx-pcmcia-io", 0x04000000);
-    memory_region_add_subregion(&s->container_mem, 0x00000000,
-                                &s->iomem);
-
-    /* Then next 64 MB is reserved */
-
-    /* Socket Attribute Memory Space */
-    memory_region_init_io(&s->attr_iomem, obj, &pxa2xx_pcmcia_attr_ops, s,
-                          "pxa2xx-pcmcia-attribute", 0x04000000);
-    memory_region_add_subregion(&s->container_mem, 0x08000000,
-                                &s->attr_iomem);
-
-    /* Socket Common Memory Space */
-    memory_region_init_io(&s->common_iomem, obj, &pxa2xx_pcmcia_common_ops, s,
-                          "pxa2xx-pcmcia-common", 0x04000000);
-    memory_region_add_subregion(&s->container_mem, 0x0c000000,
-                                &s->common_iomem);
-
-    s->slot.irq = qemu_allocate_irq(pxa2xx_pcmcia_set_irq, s, 0);
-
-    object_property_add_link(obj, "card", TYPE_PCMCIA_CARD,
-                             (Object **)&s->card,
-                             NULL, /* read-only property */
-                             0);
-}
-
-/* Insert a new card into a slot */
-int pxa2xx_pcmcia_attach(void *opaque, PCMCIACardState *card)
-{
-    PXA2xxPCMCIAState *s = (PXA2xxPCMCIAState *) opaque;
-    PCMCIACardClass *pcc;
-
-    if (s->slot.attached) {
-        return -EEXIST;
-    }
-
-    if (s->cd_irq) {
-        qemu_irq_raise(s->cd_irq);
-    }
-
-    s->card = card;
-    pcc = PCMCIA_CARD_GET_CLASS(s->card);
-
-    s->slot.attached = true;
-    s->card->slot = &s->slot;
-    pcc->attach(s->card);
-
-    return 0;
-}
-
-/* Eject card from the slot */
-int pxa2xx_pcmcia_detach(void *opaque)
-{
-    PXA2xxPCMCIAState *s = (PXA2xxPCMCIAState *) opaque;
-    PCMCIACardClass *pcc;
-
-    if (!s->slot.attached) {
-        return -ENOENT;
-    }
-
-    pcc = PCMCIA_CARD_GET_CLASS(s->card);
-    pcc->detach(s->card);
-    s->card->slot = NULL;
-    s->card = NULL;
-
-    s->slot.attached = false;
-
-    if (s->irq) {
-        qemu_irq_lower(s->irq);
-    }
-    if (s->cd_irq) {
-        qemu_irq_lower(s->cd_irq);
-    }
-
-    return 0;
-}
-
-/* Who to notify on card events */
-void pxa2xx_pcmcia_set_irq_cb(void *opaque, qemu_irq irq, qemu_irq cd_irq)
-{
-    PXA2xxPCMCIAState *s = (PXA2xxPCMCIAState *) opaque;
-    s->irq = irq;
-    s->cd_irq = cd_irq;
-}
-
-static const TypeInfo pxa2xx_pcmcia_type_info = {
-    .name = TYPE_PXA2XX_PCMCIA,
-    .parent = TYPE_SYS_BUS_DEVICE,
-    .instance_size = sizeof(PXA2xxPCMCIAState),
-    .instance_init = pxa2xx_pcmcia_initfn,
-};
-
-static void pxa2xx_pcmcia_register_types(void)
-{
-    type_register_static(&pxa2xx_pcmcia_type_info);
-}
-
-type_init(pxa2xx_pcmcia_register_types)
diff --git a/hw/pcmcia/meson.build b/hw/pcmcia/meson.build
index 04e29c109c0..edcb7f5d263 100644
--- a/hw/pcmcia/meson.build
+++ b/hw/pcmcia/meson.build
@@ -1,2 +1 @@
 system_ss.add(when: 'CONFIG_PCMCIA', if_true: files('pcmcia.c'))
-system_ss.add(when: 'CONFIG_PXA2XX', if_true: files('pxa2xx.c'))
-- 
2.34.1


