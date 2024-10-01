Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E9A0DCEACE9
	for <qemu-devel@archiver.kernel.org>; Tue,  1 Oct 2024 16:53:32 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1svfuq-0005qh-PK; Tue, 01 Oct 2024 12:40:00 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1svfuW-0005XC-3C
 for qemu-devel@nongnu.org; Tue, 01 Oct 2024 12:39:40 -0400
Received: from mail-wm1-x32d.google.com ([2a00:1450:4864:20::32d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1svfuR-00064C-0H
 for qemu-devel@nongnu.org; Tue, 01 Oct 2024 12:39:39 -0400
Received: by mail-wm1-x32d.google.com with SMTP id
 5b1f17b1804b1-42cb0f28bfbso45140635e9.1
 for <qemu-devel@nongnu.org>; Tue, 01 Oct 2024 09:39:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1727800773; x=1728405573; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=e2PWkBdkpEGOyBOt0SMBAVNJSPW6cVrnyUy1o917REw=;
 b=ajqk9mdda7avT1a1MkunbrQHeWTBODwhlggcZ6ltEtNUgS7VR7bq8A1blz0ixhgquS
 ovTpT+5PQakE21BwvHMJHTVCY10B4iyRCt7O4NQBf1szXkWYCW+MtIR8EcO1/Tb66JOj
 2tjL6G9NVwzZ/J7/7E/0Kn1c2jJyx33u6obyDmpjjbHOb2uYgfjIX8c6RI5NfLCMjKT2
 4IdERL41CUR84Nm1K2OJcEF/cSVVmZ+mkz/RNTUgNEt42l+lwFiV7bwzi0ZOAsF0FPLX
 SNw8tMsD3x8ArbRCg8mbq0LypI0DkyjzMivkP3X83n2M+67xL7szpMsAg9VkfPsSGu8U
 fpng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1727800773; x=1728405573;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=e2PWkBdkpEGOyBOt0SMBAVNJSPW6cVrnyUy1o917REw=;
 b=VT+npiWtpv1id32wsx4hj9BEH0B9+HI24rFtspRjJ/oGjN2aZa21N4KD4uughFu4qA
 g2K6IVFkPphRv4pl0b7Ka39XwWXy3CgdKxH6WiggNc5apltEgv4S7TAofBz18fukRTZB
 PQgGpvy7CYynhepwWdwTi1NTIraxbraX/hg6V9LDFc7DdQ+T9Slp0sDqsWMuq/ferrsA
 U1BOMp9yJL+DeJgi95R6Bdt0srC13g6ZnfQuci+GMxqsHniL5ZCXCdBvrHxauI4sLmsW
 ZjRsPEnzK7YUX4Gg4zczz0rJ0uptL0gsGwJa4fkCmu5gOt4HGS5o0LmELJGUhJm0v7eU
 Z2GA==
X-Gm-Message-State: AOJu0YweHu8VuHhi59ATTSvwFXeNROWOYA2apkrUSaRHgpnMMU0geYUL
 JFCCCdYd52jhkwbU+q9jqw5MndGJ46OaoNHmgM6RIWGKwz7dOvBjEHk/pOEe0Wm0gpqTtSPRZYI
 o
X-Google-Smtp-Source: AGHT+IFm6TfEbJk8KulZGYk43cyFfe+OzlRZeGYTAHoyb1x3w7k4W5vi1S4QgOyw0nWNI7mUPxJ/fw==
X-Received: by 2002:a05:600c:3b06:b0:42c:bc03:e765 with SMTP id
 5b1f17b1804b1-42f777c097amr872615e9.16.1727800773311; 
 Tue, 01 Oct 2024 09:39:33 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [2001:8b0:1d0::2])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-37cd56e6547sm12243771f8f.58.2024.10.01.09.39.32
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 01 Oct 2024 09:39:33 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 25/54] hw/arm: Remove pxa2xx_gpio
Date: Tue,  1 Oct 2024 17:38:49 +0100
Message-Id: <20241001163918.1275441-26-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20241001163918.1275441-1-peter.maydell@linaro.org>
References: <20241001163918.1275441-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32d;
 envelope-from=peter.maydell@linaro.org; helo=mail-wm1-x32d.google.com
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

Remove the pxa2xx-specific GPIO device.

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Message-id: 20240903160751.4100218-22-peter.maydell@linaro.org
---
 include/hw/arm/pxa.h |   5 -
 hw/arm/pxa2xx_gpio.c | 365 -------------------------------------------
 hw/arm/meson.build   |   2 +-
 3 files changed, 1 insertion(+), 371 deletions(-)
 delete mode 100644 hw/arm/pxa2xx_gpio.c

diff --git a/include/hw/arm/pxa.h b/include/hw/arm/pxa.h
index 5f98536bc69..fb28a683f38 100644
--- a/include/hw/arm/pxa.h
+++ b/include/hw/arm/pxa.h
@@ -71,9 +71,4 @@
 /* pxa2xx_pic.c */
 DeviceState *pxa2xx_pic_init(hwaddr base, ARMCPU *cpu);
 
-/* pxa2xx_gpio.c */
-DeviceState *pxa2xx_gpio_init(hwaddr base,
-                              ARMCPU *cpu, DeviceState *pic, int lines);
-void pxa2xx_gpio_read_notifier(DeviceState *dev, qemu_irq handler);
-
 #endif /* PXA_H */
diff --git a/hw/arm/pxa2xx_gpio.c b/hw/arm/pxa2xx_gpio.c
deleted file mode 100644
index 41dca036fbb..00000000000
--- a/hw/arm/pxa2xx_gpio.c
+++ /dev/null
@@ -1,365 +0,0 @@
-/*
- * Intel XScale PXA255/270 GPIO controller emulation.
- *
- * Copyright (c) 2006 Openedhand Ltd.
- * Written by Andrzej Zaborowski <balrog@zabor.org>
- *
- * This code is licensed under the GPL.
- */
-
-#include "qemu/osdep.h"
-#include "cpu.h"
-#include "hw/irq.h"
-#include "hw/qdev-properties.h"
-#include "hw/sysbus.h"
-#include "migration/vmstate.h"
-#include "hw/arm/pxa.h"
-#include "qapi/error.h"
-#include "qemu/log.h"
-#include "qemu/module.h"
-#include "qom/object.h"
-
-#define PXA2XX_GPIO_BANKS	4
-
-#define TYPE_PXA2XX_GPIO "pxa2xx-gpio"
-OBJECT_DECLARE_SIMPLE_TYPE(PXA2xxGPIOInfo, PXA2XX_GPIO)
-
-struct PXA2xxGPIOInfo {
-    /*< private >*/
-    SysBusDevice parent_obj;
-    /*< public >*/
-
-    MemoryRegion iomem;
-    qemu_irq irq0, irq1, irqX;
-    int lines;
-    ARMCPU *cpu;
-
-    /* XXX: GNU C vectors are more suitable */
-    uint32_t ilevel[PXA2XX_GPIO_BANKS];
-    uint32_t olevel[PXA2XX_GPIO_BANKS];
-    uint32_t dir[PXA2XX_GPIO_BANKS];
-    uint32_t rising[PXA2XX_GPIO_BANKS];
-    uint32_t falling[PXA2XX_GPIO_BANKS];
-    uint32_t status[PXA2XX_GPIO_BANKS];
-    uint32_t gafr[PXA2XX_GPIO_BANKS * 2];
-
-    uint32_t prev_level[PXA2XX_GPIO_BANKS];
-    qemu_irq handler[PXA2XX_GPIO_BANKS * 32];
-    qemu_irq read_notify;
-};
-
-static struct {
-    enum {
-        GPIO_NONE,
-        GPLR,
-        GPSR,
-        GPCR,
-        GPDR,
-        GRER,
-        GFER,
-        GEDR,
-        GAFR_L,
-        GAFR_U,
-    } reg;
-    int bank;
-} pxa2xx_gpio_regs[0x200] = {
-    [0 ... 0x1ff] = { GPIO_NONE, 0 },
-#define PXA2XX_REG(reg, a0, a1, a2, a3)	\
-    [a0] = { reg, 0 }, [a1] = { reg, 1 }, [a2] = { reg, 2 }, [a3] = { reg, 3 },
-
-    PXA2XX_REG(GPLR, 0x000, 0x004, 0x008, 0x100)
-    PXA2XX_REG(GPSR, 0x018, 0x01c, 0x020, 0x118)
-    PXA2XX_REG(GPCR, 0x024, 0x028, 0x02c, 0x124)
-    PXA2XX_REG(GPDR, 0x00c, 0x010, 0x014, 0x10c)
-    PXA2XX_REG(GRER, 0x030, 0x034, 0x038, 0x130)
-    PXA2XX_REG(GFER, 0x03c, 0x040, 0x044, 0x13c)
-    PXA2XX_REG(GEDR, 0x048, 0x04c, 0x050, 0x148)
-    PXA2XX_REG(GAFR_L, 0x054, 0x05c, 0x064, 0x06c)
-    PXA2XX_REG(GAFR_U, 0x058, 0x060, 0x068, 0x070)
-};
-
-static void pxa2xx_gpio_irq_update(PXA2xxGPIOInfo *s)
-{
-    if (s->status[0] & (1 << 0))
-        qemu_irq_raise(s->irq0);
-    else
-        qemu_irq_lower(s->irq0);
-
-    if (s->status[0] & (1 << 1))
-        qemu_irq_raise(s->irq1);
-    else
-        qemu_irq_lower(s->irq1);
-
-    if ((s->status[0] & ~3) | s->status[1] | s->status[2] | s->status[3])
-        qemu_irq_raise(s->irqX);
-    else
-        qemu_irq_lower(s->irqX);
-}
-
-/* Bitmap of pins used as standby and sleep wake-up sources.  */
-static const int pxa2xx_gpio_wake[PXA2XX_GPIO_BANKS] = {
-    0x8003fe1b, 0x002001fc, 0xec080000, 0x0012007f,
-};
-
-static void pxa2xx_gpio_set(void *opaque, int line, int level)
-{
-    PXA2xxGPIOInfo *s = (PXA2xxGPIOInfo *) opaque;
-    CPUState *cpu = CPU(s->cpu);
-    int bank;
-    uint32_t mask;
-
-    if (line >= s->lines) {
-        printf("%s: No GPIO pin %i\n", __func__, line);
-        return;
-    }
-
-    bank = line >> 5;
-    mask = 1U << (line & 31);
-
-    if (level) {
-        s->status[bank] |= s->rising[bank] & mask &
-                ~s->ilevel[bank] & ~s->dir[bank];
-        s->ilevel[bank] |= mask;
-    } else {
-        s->status[bank] |= s->falling[bank] & mask &
-                s->ilevel[bank] & ~s->dir[bank];
-        s->ilevel[bank] &= ~mask;
-    }
-
-    if (s->status[bank] & mask)
-        pxa2xx_gpio_irq_update(s);
-
-    /* Wake-up GPIOs */
-    if (cpu->halted && (mask & ~s->dir[bank] & pxa2xx_gpio_wake[bank])) {
-        cpu_interrupt(cpu, CPU_INTERRUPT_EXITTB);
-    }
-}
-
-static void pxa2xx_gpio_handler_update(PXA2xxGPIOInfo *s) {
-    uint32_t level, diff;
-    int i, bit, line;
-    for (i = 0; i < PXA2XX_GPIO_BANKS; i ++) {
-        level = s->olevel[i] & s->dir[i];
-
-        for (diff = s->prev_level[i] ^ level; diff; diff ^= 1 << bit) {
-            bit = ctz32(diff);
-            line = bit + 32 * i;
-            qemu_set_irq(s->handler[line], (level >> bit) & 1);
-        }
-
-        s->prev_level[i] = level;
-    }
-}
-
-static uint64_t pxa2xx_gpio_read(void *opaque, hwaddr offset,
-                                 unsigned size)
-{
-    PXA2xxGPIOInfo *s = (PXA2xxGPIOInfo *) opaque;
-    uint32_t ret;
-    int bank;
-    if (offset >= 0x200)
-        return 0;
-
-    bank = pxa2xx_gpio_regs[offset].bank;
-    switch (pxa2xx_gpio_regs[offset].reg) {
-    case GPDR:		/* GPIO Pin-Direction registers */
-        return s->dir[bank];
-
-    case GPSR:		/* GPIO Pin-Output Set registers */
-        qemu_log_mask(LOG_GUEST_ERROR,
-                      "pxa2xx GPIO: read from write only register GPSR\n");
-        return 0;
-
-    case GPCR:		/* GPIO Pin-Output Clear registers */
-        qemu_log_mask(LOG_GUEST_ERROR,
-                      "pxa2xx GPIO: read from write only register GPCR\n");
-        return 0;
-
-    case GRER:		/* GPIO Rising-Edge Detect Enable registers */
-        return s->rising[bank];
-
-    case GFER:		/* GPIO Falling-Edge Detect Enable registers */
-        return s->falling[bank];
-
-    case GAFR_L:	/* GPIO Alternate Function registers */
-        return s->gafr[bank * 2];
-
-    case GAFR_U:	/* GPIO Alternate Function registers */
-        return s->gafr[bank * 2 + 1];
-
-    case GPLR:		/* GPIO Pin-Level registers */
-        ret = (s->olevel[bank] & s->dir[bank]) |
-                (s->ilevel[bank] & ~s->dir[bank]);
-        qemu_irq_raise(s->read_notify);
-        return ret;
-
-    case GEDR:		/* GPIO Edge Detect Status registers */
-        return s->status[bank];
-
-    default:
-        qemu_log_mask(LOG_GUEST_ERROR, "%s: Bad offset 0x%" HWADDR_PRIX "\n",
-                      __func__, offset);
-    }
-
-    return 0;
-}
-
-static void pxa2xx_gpio_write(void *opaque, hwaddr offset,
-                              uint64_t value, unsigned size)
-{
-    PXA2xxGPIOInfo *s = (PXA2xxGPIOInfo *) opaque;
-    int bank;
-    if (offset >= 0x200)
-        return;
-
-    bank = pxa2xx_gpio_regs[offset].bank;
-    switch (pxa2xx_gpio_regs[offset].reg) {
-    case GPDR:		/* GPIO Pin-Direction registers */
-        s->dir[bank] = value;
-        pxa2xx_gpio_handler_update(s);
-        break;
-
-    case GPSR:		/* GPIO Pin-Output Set registers */
-        s->olevel[bank] |= value;
-        pxa2xx_gpio_handler_update(s);
-        break;
-
-    case GPCR:		/* GPIO Pin-Output Clear registers */
-        s->olevel[bank] &= ~value;
-        pxa2xx_gpio_handler_update(s);
-        break;
-
-    case GRER:		/* GPIO Rising-Edge Detect Enable registers */
-        s->rising[bank] = value;
-        break;
-
-    case GFER:		/* GPIO Falling-Edge Detect Enable registers */
-        s->falling[bank] = value;
-        break;
-
-    case GAFR_L:	/* GPIO Alternate Function registers */
-        s->gafr[bank * 2] = value;
-        break;
-
-    case GAFR_U:	/* GPIO Alternate Function registers */
-        s->gafr[bank * 2 + 1] = value;
-        break;
-
-    case GEDR:		/* GPIO Edge Detect Status registers */
-        s->status[bank] &= ~value;
-        pxa2xx_gpio_irq_update(s);
-        break;
-
-    default:
-        qemu_log_mask(LOG_GUEST_ERROR, "%s: Bad offset 0x%" HWADDR_PRIX "\n",
-                      __func__, offset);
-    }
-}
-
-static const MemoryRegionOps pxa_gpio_ops = {
-    .read = pxa2xx_gpio_read,
-    .write = pxa2xx_gpio_write,
-    .endianness = DEVICE_NATIVE_ENDIAN,
-};
-
-DeviceState *pxa2xx_gpio_init(hwaddr base,
-                              ARMCPU *cpu, DeviceState *pic, int lines)
-{
-    DeviceState *dev;
-
-    dev = qdev_new(TYPE_PXA2XX_GPIO);
-    qdev_prop_set_int32(dev, "lines", lines);
-    object_property_set_link(OBJECT(dev), "cpu", OBJECT(cpu), &error_abort);
-    sysbus_realize_and_unref(SYS_BUS_DEVICE(dev), &error_fatal);
-
-    sysbus_mmio_map(SYS_BUS_DEVICE(dev), 0, base);
-    sysbus_connect_irq(SYS_BUS_DEVICE(dev), 0,
-                    qdev_get_gpio_in(pic, PXA2XX_PIC_GPIO_0));
-    sysbus_connect_irq(SYS_BUS_DEVICE(dev), 1,
-                    qdev_get_gpio_in(pic, PXA2XX_PIC_GPIO_1));
-    sysbus_connect_irq(SYS_BUS_DEVICE(dev), 2,
-                    qdev_get_gpio_in(pic, PXA2XX_PIC_GPIO_X));
-
-    return dev;
-}
-
-static void pxa2xx_gpio_initfn(Object *obj)
-{
-    SysBusDevice *sbd = SYS_BUS_DEVICE(obj);
-    DeviceState *dev = DEVICE(sbd);
-    PXA2xxGPIOInfo *s = PXA2XX_GPIO(dev);
-
-    memory_region_init_io(&s->iomem, obj, &pxa_gpio_ops,
-                          s, "pxa2xx-gpio", 0x1000);
-    sysbus_init_mmio(sbd, &s->iomem);
-    sysbus_init_irq(sbd, &s->irq0);
-    sysbus_init_irq(sbd, &s->irq1);
-    sysbus_init_irq(sbd, &s->irqX);
-}
-
-static void pxa2xx_gpio_realize(DeviceState *dev, Error **errp)
-{
-    PXA2xxGPIOInfo *s = PXA2XX_GPIO(dev);
-
-    qdev_init_gpio_in(dev, pxa2xx_gpio_set, s->lines);
-    qdev_init_gpio_out(dev, s->handler, s->lines);
-}
-
-/*
- * Registers a callback to notify on GPLR reads.  This normally
- * shouldn't be needed but it is used for the hack on Spitz machines.
- */
-void pxa2xx_gpio_read_notifier(DeviceState *dev, qemu_irq handler)
-{
-    PXA2xxGPIOInfo *s = PXA2XX_GPIO(dev);
-
-    s->read_notify = handler;
-}
-
-static const VMStateDescription vmstate_pxa2xx_gpio_regs = {
-    .name = "pxa2xx-gpio",
-    .version_id = 1,
-    .minimum_version_id = 1,
-    .fields = (const VMStateField[]) {
-        VMSTATE_UINT32_ARRAY(ilevel, PXA2xxGPIOInfo, PXA2XX_GPIO_BANKS),
-        VMSTATE_UINT32_ARRAY(olevel, PXA2xxGPIOInfo, PXA2XX_GPIO_BANKS),
-        VMSTATE_UINT32_ARRAY(dir, PXA2xxGPIOInfo, PXA2XX_GPIO_BANKS),
-        VMSTATE_UINT32_ARRAY(rising, PXA2xxGPIOInfo, PXA2XX_GPIO_BANKS),
-        VMSTATE_UINT32_ARRAY(falling, PXA2xxGPIOInfo, PXA2XX_GPIO_BANKS),
-        VMSTATE_UINT32_ARRAY(status, PXA2xxGPIOInfo, PXA2XX_GPIO_BANKS),
-        VMSTATE_UINT32_ARRAY(gafr, PXA2xxGPIOInfo, PXA2XX_GPIO_BANKS * 2),
-        VMSTATE_UINT32_ARRAY(prev_level, PXA2xxGPIOInfo, PXA2XX_GPIO_BANKS),
-        VMSTATE_END_OF_LIST(),
-    },
-};
-
-static Property pxa2xx_gpio_properties[] = {
-    DEFINE_PROP_INT32("lines", PXA2xxGPIOInfo, lines, 0),
-    DEFINE_PROP_LINK("cpu", PXA2xxGPIOInfo, cpu, TYPE_ARM_CPU, ARMCPU *),
-    DEFINE_PROP_END_OF_LIST(),
-};
-
-static void pxa2xx_gpio_class_init(ObjectClass *klass, void *data)
-{
-    DeviceClass *dc = DEVICE_CLASS(klass);
-
-    dc->desc = "PXA2xx GPIO controller";
-    device_class_set_props(dc, pxa2xx_gpio_properties);
-    dc->vmsd = &vmstate_pxa2xx_gpio_regs;
-    dc->realize = pxa2xx_gpio_realize;
-}
-
-static const TypeInfo pxa2xx_gpio_info = {
-    .name          = TYPE_PXA2XX_GPIO,
-    .parent        = TYPE_SYS_BUS_DEVICE,
-    .instance_size = sizeof(PXA2xxGPIOInfo),
-    .instance_init = pxa2xx_gpio_initfn,
-    .class_init    = pxa2xx_gpio_class_init,
-};
-
-static void pxa2xx_gpio_register_types(void)
-{
-    type_register_static(&pxa2xx_gpio_info);
-}
-
-type_init(pxa2xx_gpio_register_types)
diff --git a/hw/arm/meson.build b/hw/arm/meson.build
index fb2bc71e30f..c2b717f3118 100644
--- a/hw/arm/meson.build
+++ b/hw/arm/meson.build
@@ -22,7 +22,7 @@ arm_ss.add(when: 'CONFIG_SABRELITE', if_true: files('sabrelite.c'))
 
 arm_ss.add(when: 'CONFIG_ARM_V7M', if_true: files('armv7m.c'))
 arm_ss.add(when: 'CONFIG_EXYNOS4', if_true: files('exynos4210.c'))
-arm_ss.add(when: 'CONFIG_PXA2XX', if_true: files('pxa2xx_gpio.c', 'pxa2xx_pic.c'))
+arm_ss.add(when: 'CONFIG_PXA2XX', if_true: files('pxa2xx_pic.c'))
 arm_ss.add(when: 'CONFIG_DIGIC', if_true: files('digic.c'))
 arm_ss.add(when: 'CONFIG_OMAP', if_true: files('omap1.c'))
 arm_ss.add(when: 'CONFIG_ALLWINNER_A10', if_true: files('allwinner-a10.c', 'cubieboard.c'))
-- 
2.34.1


