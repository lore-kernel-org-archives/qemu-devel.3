Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E679DC83F0A
	for <qemu-devel@archiver.kernel.org>; Fri,  4 Jul 2025 22:34:29 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uXoxs-0001jl-Gb; Fri, 04 Jul 2025 18:33:04 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jackson88044@gmail.com>)
 id 1uXoxi-0001gF-L7
 for qemu-devel@nongnu.org; Fri, 04 Jul 2025 18:32:58 -0400
Received: from mail-qt1-x82e.google.com ([2607:f8b0:4864:20::82e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <jackson88044@gmail.com>)
 id 1uXoxa-00078p-Pn
 for qemu-devel@nongnu.org; Fri, 04 Jul 2025 18:32:51 -0400
Received: by mail-qt1-x82e.google.com with SMTP id
 d75a77b69052e-4a44b9b2af8so7934121cf.3
 for <qemu-devel@nongnu.org>; Fri, 04 Jul 2025 15:32:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1751668364; x=1752273164; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=AWnu/oAAzVkXqcGwl/ibho3UTNb/WrEZ456/ajF/M5o=;
 b=M9xg0rzvTKSAymOVudNRHazTXb85a22G+bIRUFROno77YGOiyhBr6lg9wp6+wmO2+S
 1awcnPTjdNuqJPcHqppqv/P7Va3g518RUIWBs9EQxQKxz3tUkrkiIWxwh6Nx4xbH92BM
 zCBcEC7/cjsDodM2icG6Gunx24AYXGDD5NsDAWY8FnbZAyf2c/AuV5xnMgjV9BkfXWQK
 xPdHVUc9k3SQPjDCppBaZEMv9HlURDjXoDRBkXAcsiQx8EcChd5aAC9IWE94ukpGhMyS
 cnsmleNPHqHk+991n6OLbBLavXCBwo7xFwjFVwN8yOYCKp9BavbfnQRfAqDqr3YwOEZZ
 lOEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1751668364; x=1752273164;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=AWnu/oAAzVkXqcGwl/ibho3UTNb/WrEZ456/ajF/M5o=;
 b=iBmFLbOPH6/LMNBUjPUYD+0iTdazv+l6nB3P7nuoB0Cd3CInHx5m42ZFRbQKCeMKOz
 EgQauPtRpF4juDhFWFvcY2BDgF656Jr4p/AB3d7yO2mH+ICrmoWu6L6WrGargpk789ch
 XEJEJMyd6R/mMyQhgaZW6SbzdSoRjSR5JT0Uc7FUPgfizjEy4VLOVsrWd4KESBBnsw4X
 6rsCWdZ7v7DBwmPWTEIDsVURqiZwqQ1qggk2U4lSoBx2iMJt1dhD8M1Q6ajUy68Y4REi
 9L+FRKo9alQHuoFcki/1qOWGn0XqUVW3no+MGxr8be8mHc1rSp/O0am34S/jVEkOaNPq
 TvlA==
X-Gm-Message-State: AOJu0Yzvn4YhGotjedytTDTkdrWxIxLPH22QJ/MBd4zzezS/+jzvsKOh
 lQ94H47i6x5W/YSoP5QovrA/LWftLj3vuD8BS4zCVu60jKsVPYiT3UzqF3B82g==
X-Gm-Gg: ASbGncuZoR5GMNOp9F6+mwfYMqmju2Tz3hPgqASt+51lcJAGnQVcRcNbewH5cTqPSIi
 MB+6CRSZ+JjFRSYKEoQ1/Pr+DxLH481NgRaHjeJ7ER/1c2eeJglMq67tJ7TjCfj74nR8u8I2zjP
 6u1SUH2HCfEKvGTGTMF8upuzCtLIuostXUNHU/PI+Z8svAp58rcNR4HORyNcuKw/BcTPYuc0YU4
 bjgmPjxrK1zN4Ep/7iGxVM3MUG0e/voymVS0rnGcgXOK6XxpuQM/68RS3FJNmR+vy1sUbGMeUry
 fa6bTjeOswBLN1WXzzLUXhLwwqNq/v4qdaxu0fg3lL24eq7L5QGOo+kIYLUJ8ZdYjlbOXdlnIqP
 uafBvJQ==
X-Google-Smtp-Source: AGHT+IFpxRXVrj6mKmIHO398+rG+eMrQ9kfMtugrCZZ85c/QXH0MS+hzwYm4GE4cWE5NGgwMxZaNiA==
X-Received: by 2002:a05:622a:a6c9:b0:4a9:a3ff:28bb with SMTP id
 d75a77b69052e-4a9a3ff3079mr19196581cf.25.1751668363652; 
 Fri, 04 Jul 2025 15:32:43 -0700 (PDT)
Received: from user-jcksn.myfiosgateway.com
 ([2600:4040:2bcd:3800:7cf4:c69f:10f5:f5b9])
 by smtp.gmail.com with ESMTPSA id
 d75a77b69052e-4a994a3093asm21528851cf.36.2025.07.04.15.32.43
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 04 Jul 2025 15:32:43 -0700 (PDT)
From: Jackson Donaldson <jackson88044@gmail.com>
X-Google-Original-From: Jackson Donaldson <jcksn@duck.com>
To: qemu-devel@nongnu.org
Cc: peter.maydell@linaro.org
Subject: [PATCH v4 04/11] MAX78000: UART Implementation
Date: Fri,  4 Jul 2025 18:32:32 -0400
Message-Id: <20250704223239.248781-5-jcksn@duck.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250704223239.248781-1-jcksn@duck.com>
References: <20250704223239.248781-1-jcksn@duck.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::82e;
 envelope-from=jackson88044@gmail.com; helo=mail-qt1-x82e.google.com
X-Spam_score_int: -17
X-Spam_score: -1.8
X-Spam_bar: -
X-Spam_report: (-1.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FREEMAIL_ENVFROM_END_DIGIT=0.25, FREEMAIL_FROM=0.001,
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

This commit implements UART support for the MAX78000

Signed-off-by: Jackson Donaldson <jcksn@duck.com>
Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
---
 hw/arm/Kconfig                  |   1 +
 hw/char/Kconfig                 |   3 +
 hw/char/max78000_uart.c         | 285 ++++++++++++++++++++++++++++++++
 hw/char/meson.build             |   1 +
 include/hw/char/max78000_uart.h |  78 +++++++++
 5 files changed, 368 insertions(+)
 create mode 100644 hw/char/max78000_uart.c
 create mode 100644 include/hw/char/max78000_uart.h

diff --git a/hw/arm/Kconfig b/hw/arm/Kconfig
index e3b419b468..031e0bf59e 100644
--- a/hw/arm/Kconfig
+++ b/hw/arm/Kconfig
@@ -367,6 +367,7 @@ config MAX78000_SOC
     bool
     select ARM_V7M
     select MAX78000_ICC
+    select MAX78000_UART
 
 config RASPI
     bool
diff --git a/hw/char/Kconfig b/hw/char/Kconfig
index 9d517f3e28..020c0a84bb 100644
--- a/hw/char/Kconfig
+++ b/hw/char/Kconfig
@@ -48,6 +48,9 @@ config VIRTIO_SERIAL
     default y
     depends on VIRTIO
 
+config MAX78000_UART
+    bool
+
 config STM32F2XX_USART
     bool
 
diff --git a/hw/char/max78000_uart.c b/hw/char/max78000_uart.c
new file mode 100644
index 0000000000..19506d52ef
--- /dev/null
+++ b/hw/char/max78000_uart.c
@@ -0,0 +1,285 @@
+/*
+ * MAX78000 UART
+ *
+ * Copyright (c) 2025 Jackson Donaldson <jcksn@duck.com>
+ *
+ * SPDX-License-Identifier: GPL-2.0-or-later
+ */
+
+#include "qemu/osdep.h"
+#include "hw/char/max78000_uart.h"
+#include "hw/irq.h"
+#include "hw/qdev-properties.h"
+#include "hw/qdev-properties-system.h"
+#include "qemu/log.h"
+#include "qemu/module.h"
+#include "migration/vmstate.h"
+#include "trace.h"
+
+
+static int max78000_uart_can_receive(void *opaque)
+{
+    Max78000UartState *s = opaque;
+    if (!(s->ctrl & UART_BCLKEN)) {
+        return 0;
+    }
+    return fifo8_num_free(&s->rx_fifo);
+}
+
+static void max78000_update_irq(Max78000UartState *s)
+{
+    int interrupt_level;
+
+    interrupt_level = s->int_fl & s->int_en;
+    qemu_set_irq(s->irq, interrupt_level);
+}
+
+static void max78000_uart_receive(void *opaque, const uint8_t *buf, int size)
+{
+    Max78000UartState *s = opaque;
+
+    assert(size <= fifo8_num_free(&s->rx_fifo));
+
+    fifo8_push_all(&s->rx_fifo, buf, size);
+
+    uint32_t rx_threshold = s->ctrl & 0xf;
+
+    if (fifo8_num_used(&s->rx_fifo) >= rx_threshold) {
+        s->int_fl |= UART_RX_THD;
+    }
+
+    max78000_update_irq(s);
+}
+
+static void max78000_uart_reset_hold(Object *obj, ResetType type)
+{
+    Max78000UartState *s = MAX78000_UART(obj);
+
+    s->ctrl = 0;
+    s->status = UART_TX_EM | UART_RX_EM;
+    s->int_en = 0;
+    s->int_fl = 0;
+    s->osr = 0;
+    s->txpeek = 0;
+    s->pnr = UART_RTS;
+    s->fifo = 0;
+    s->dma = 0;
+    s->wken = 0;
+    s->wkfl = 0;
+    fifo8_reset(&s->rx_fifo);
+}
+
+static uint64_t max78000_uart_read(void *opaque, hwaddr addr,
+                                       unsigned int size)
+{
+    Max78000UartState *s = opaque;
+    uint64_t retvalue = 0;
+    switch (addr) {
+    case UART_CTRL:
+        retvalue = s->ctrl;
+        break;
+    case UART_STATUS:
+        retvalue = (fifo8_num_used(&s->rx_fifo) << UART_RX_LVL) |
+                    UART_TX_EM |
+                    (fifo8_is_empty(&s->rx_fifo) ? UART_RX_EM : 0);
+        break;
+    case UART_INT_EN:
+        retvalue = s->int_en;
+        break;
+    case UART_INT_FL:
+        retvalue = s->int_fl;
+        break;
+    case UART_CLKDIV:
+        retvalue = s->clkdiv;
+        break;
+    case UART_OSR:
+        retvalue = s->osr;
+        break;
+    case UART_TXPEEK:
+        if (!fifo8_is_empty(&s->rx_fifo)) {
+            retvalue = fifo8_peek(&s->rx_fifo);
+        }
+        break;
+    case UART_PNR:
+        retvalue = s->pnr;
+        break;
+    case UART_FIFO:
+        if (!fifo8_is_empty(&s->rx_fifo)) {
+            retvalue = fifo8_pop(&s->rx_fifo);
+            max78000_update_irq(s);
+        }
+        break;
+    case UART_DMA:
+        /* DMA not implemented */
+        retvalue = s->dma;
+        break;
+    case UART_WKEN:
+        retvalue = s->wken;
+        break;
+    case UART_WKFL:
+        retvalue = s->wkfl;
+        break;
+    default:
+        qemu_log_mask(LOG_GUEST_ERROR,
+            "%s: Bad offset 0x%"HWADDR_PRIx"\n", __func__, addr);
+        break;
+    }
+
+    return retvalue;
+}
+
+static void max78000_uart_write(void *opaque, hwaddr addr,
+                                  uint64_t val64, unsigned int size)
+{
+    Max78000UartState *s = opaque;
+
+    uint32_t value = val64;
+    uint8_t data;
+
+    switch (addr) {
+    case UART_CTRL:
+        if (value & UART_FLUSH_RX) {
+            fifo8_reset(&s->rx_fifo);
+        }
+        if (value & UART_BCLKEN) {
+            value = value | UART_BCLKRDY;
+        }
+        s->ctrl = value & ~(UART_FLUSH_RX | UART_FLUSH_TX);
+
+        /*
+         * Software can manage UART flow control manually by setting hfc_en
+         * in UART_CTRL. This would require emulating uart at a lower level,
+         * and is currently unimplemented.
+         */
+
+        return;
+    case UART_STATUS:
+        /* UART_STATUS is read only */
+        return;
+    case UART_INT_EN:
+        s->int_en = value;
+        return;
+    case UART_INT_FL:
+        s->int_fl = s->int_fl & ~(value);
+        max78000_update_irq(s);
+        return;
+    case UART_CLKDIV:
+        s->clkdiv = value;
+        return;
+    case UART_OSR:
+        s->osr = value;
+        return;
+    case UART_PNR:
+        s->pnr = value;
+        return;
+    case UART_FIFO:
+        data = value & 0xff;
+        /*
+         * XXX this blocks entire thread. Rewrite to use
+         * qemu_chr_fe_write and background I/O callbacks
+         */
+        qemu_chr_fe_write_all(&s->chr, &data, 1);
+
+        /* TX is always empty */
+        s->int_fl |= UART_TX_HE;
+        max78000_update_irq(s);
+
+        return;
+    case UART_DMA:
+        /* DMA not implemented */
+        s->dma = value;
+        return;
+    case UART_WKEN:
+        s->wken = value;
+        return;
+    case UART_WKFL:
+        s->wkfl = value;
+        return;
+    default:
+        qemu_log_mask(LOG_GUEST_ERROR, "%s: Bad offset 0x%"
+            HWADDR_PRIx "\n", __func__, addr);
+    }
+}
+
+static const MemoryRegionOps max78000_uart_ops = {
+    .read = max78000_uart_read,
+    .write = max78000_uart_write,
+    .endianness = DEVICE_LITTLE_ENDIAN,
+    .valid.min_access_size = 4,
+    .valid.max_access_size = 4,
+};
+
+static const Property max78000_uart_properties[] = {
+    DEFINE_PROP_CHR("chardev", Max78000UartState, chr),
+};
+
+static const VMStateDescription max78000_uart_vmstate = {
+    .name = TYPE_MAX78000_UART,
+    .version_id = 1,
+    .minimum_version_id = 1,
+    .fields = (VMStateField[]) {
+        VMSTATE_UINT32(ctrl, Max78000UartState),
+        VMSTATE_UINT32(status, Max78000UartState),
+        VMSTATE_UINT32(int_en, Max78000UartState),
+        VMSTATE_UINT32(int_fl, Max78000UartState),
+        VMSTATE_UINT32(clkdiv, Max78000UartState),
+        VMSTATE_UINT32(osr, Max78000UartState),
+        VMSTATE_UINT32(txpeek, Max78000UartState),
+        VMSTATE_UINT32(pnr, Max78000UartState),
+        VMSTATE_UINT32(fifo, Max78000UartState),
+        VMSTATE_UINT32(dma, Max78000UartState),
+        VMSTATE_UINT32(wken, Max78000UartState),
+        VMSTATE_UINT32(wkfl, Max78000UartState),
+        VMSTATE_FIFO8(rx_fifo, Max78000UartState),
+        VMSTATE_END_OF_LIST()
+    }
+};
+
+static void max78000_uart_init(Object *obj)
+{
+    Max78000UartState *s = MAX78000_UART(obj);
+    fifo8_create(&s->rx_fifo, 8);
+
+    sysbus_init_irq(SYS_BUS_DEVICE(obj), &s->irq);
+
+    memory_region_init_io(&s->mmio, obj, &max78000_uart_ops, s,
+                          TYPE_MAX78000_UART, 0x400);
+    sysbus_init_mmio(SYS_BUS_DEVICE(obj), &s->mmio);
+}
+
+static void max78000_uart_realize(DeviceState *dev, Error **errp)
+{
+    Max78000UartState *s = MAX78000_UART(dev);
+
+    qemu_chr_fe_set_handlers(&s->chr, max78000_uart_can_receive,
+                             max78000_uart_receive, NULL, NULL,
+                             s, NULL, true);
+}
+
+static void max78000_uart_class_init(ObjectClass *klass, const void *data)
+{
+    DeviceClass *dc = DEVICE_CLASS(klass);
+    ResettableClass *rc = RESETTABLE_CLASS(klass);
+
+    rc->phases.hold = max78000_uart_reset_hold;
+
+    device_class_set_props(dc, max78000_uart_properties);
+    dc->realize = max78000_uart_realize;
+
+    dc->vmsd = &max78000_uart_vmstate;
+}
+
+static const TypeInfo max78000_uart_info = {
+    .name          = TYPE_MAX78000_UART,
+    .parent        = TYPE_SYS_BUS_DEVICE,
+    .instance_size = sizeof(Max78000UartState),
+    .instance_init = max78000_uart_init,
+    .class_init    = max78000_uart_class_init,
+};
+
+static void max78000_uart_register_types(void)
+{
+    type_register_static(&max78000_uart_info);
+}
+
+type_init(max78000_uart_register_types)
diff --git a/hw/char/meson.build b/hw/char/meson.build
index 4e439da8b9..a9e1dc26c0 100644
--- a/hw/char/meson.build
+++ b/hw/char/meson.build
@@ -26,6 +26,7 @@ system_ss.add(when: 'CONFIG_AVR_USART', if_true: files('avr_usart.c'))
 system_ss.add(when: 'CONFIG_COLDFIRE', if_true: files('mcf_uart.c'))
 system_ss.add(when: 'CONFIG_DIGIC', if_true: files('digic-uart.c'))
 system_ss.add(when: 'CONFIG_EXYNOS4', if_true: files('exynos4210_uart.c'))
+system_ss.add(when: 'CONFIG_MAX78000_UART', if_true: files('max78000_uart.c'))
 system_ss.add(when: 'CONFIG_OMAP', if_true: files('omap_uart.c'))
 system_ss.add(when: 'CONFIG_RASPI', if_true: files('bcm2835_aux.c'))
 system_ss.add(when: 'CONFIG_RENESAS_SCI', if_true: files('renesas_sci.c'))
diff --git a/include/hw/char/max78000_uart.h b/include/hw/char/max78000_uart.h
new file mode 100644
index 0000000000..cf90d51dbf
--- /dev/null
+++ b/include/hw/char/max78000_uart.h
@@ -0,0 +1,78 @@
+/*
+ * MAX78000 UART
+ *
+ * Copyright (c) 2025 Jackson Donaldson <jcksn@duck.com>
+ *
+ * SPDX-License-Identifier: GPL-2.0-or-later
+ */
+
+#ifndef HW_MAX78000_UART_H
+#define HW_MAX78000_UART_H
+
+#include "hw/sysbus.h"
+#include "chardev/char-fe.h"
+#include "qemu/fifo8.h"
+#include "qom/object.h"
+
+#define UART_CTRL       0x0
+#define UART_STATUS     0x4
+#define UART_INT_EN     0x8
+#define UART_INT_FL     0xc
+#define UART_CLKDIV     0x10
+#define UART_OSR        0x14
+#define UART_TXPEEK     0x18
+#define UART_PNR        0x1c
+#define UART_FIFO       0x20
+#define UART_DMA        0x30
+#define UART_WKEN       0x34
+#define UART_WKFL       0x38
+
+/* CTRL */
+#define UART_CTF_DIS    (1 << 7)
+#define UART_FLUSH_TX   (1 << 8)
+#define UART_FLUSH_RX   (1 << 9)
+#define UART_BCLKEN     (1 << 15)
+#define UART_BCLKRDY    (1 << 19)
+
+/* STATUS */
+#define UART_RX_LVL     8
+#define UART_TX_EM      (1 << 6)
+#define UART_RX_FULL    (1 << 5)
+#define UART_RX_EM      (1 << 4)
+
+/* PNR (Pin Control Register) */
+#define UART_CTS        1
+#define UART_RTS        (1 << 1)
+
+/* INT_EN / INT_FL */
+#define UART_RX_THD     (1 << 4)
+#define UART_TX_HE      (1 << 6)
+
+#define UART_RXBUFLEN   0x100
+#define TYPE_MAX78000_UART "max78000-uart"
+OBJECT_DECLARE_SIMPLE_TYPE(Max78000UartState, MAX78000_UART)
+
+struct Max78000UartState {
+    SysBusDevice parent_obj;
+
+    MemoryRegion mmio;
+
+    uint32_t ctrl;
+    uint32_t status;
+    uint32_t int_en;
+    uint32_t int_fl;
+    uint32_t clkdiv;
+    uint32_t osr;
+    uint32_t txpeek;
+    uint32_t pnr;
+    uint32_t fifo;
+    uint32_t dma;
+    uint32_t wken;
+    uint32_t wkfl;
+
+    Fifo8 rx_fifo;
+
+    CharBackend chr;
+    qemu_irq irq;
+};
+#endif /* HW_STM32F2XX_USART_H */
-- 
2.34.1


