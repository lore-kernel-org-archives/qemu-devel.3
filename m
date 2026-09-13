Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E1816C88E5C
	for <qemu-devel@archiver.kernel.org>; Sun, 13 Sep 2026 19:50:25 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x5qCy-0005Kz-C6; Sun, 13 Sep 2026 15:49:49 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <contact@sayyadumar.com>)
 id 1x5oqK-00014i-Lr; Sun, 13 Sep 2026 14:22:22 -0400
Received: from www675.your-server.de ([85.10.213.182])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <contact@sayyadumar.com>)
 id 1x5oqD-0003bf-SL; Sun, 13 Sep 2026 14:22:19 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sayyadumar.com; s=default2511; h=Cc:To:In-Reply-To:References:Message-Id:
 Content-Transfer-Encoding:Content-Type:MIME-Version:Subject:Date:From:Sender:
 Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender
 :Resent-To:Resent-Cc:Resent-Message-ID;
 bh=6ZoAdvpTuXr4K4f7AgGo2JY75YUEJSQMCbiYugcux6g=; b=PZUMQmPieQjB3oejm3DIW3Ku//
 aOdNpZk+/QzfZq4Buibjpw/YPU6+YHHx+kVz8FHT6itOx3GC4hZXB/GdUCTy5yY5+j9DCkqaXfGB9
 PhqjUzD6h2e3zAdCQ5smg6J4sWhGvR9Bj4LO6/ptQ4N88+7MZpurdXd0jNmFjA2ZygrEQh48mDchp
 qmSpuV32rHsa/VQWv3nNH91YwgHdm7Woq3ElThM+OOzeRwLYjVaiK38nN0LMivaM8pIGtfDXSVAOJ
 o/CU+9bMju5bgiFAMSl3Izs+TAlFbJSBaFaxOb852UiCQCE+AY8Ri+nm/KAcCvlJZVursyUr5t3G5
 9bpmx0Uw==;
Received: from sslproxy07.your-server.de ([78.47.199.104])
 by www675.your-server.de with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
 (Exim 4.96.2) (envelope-from <contact@sayyadumar.com>)
 id 1x5oq5-000LWj-20; Sun, 13 Sep 2026 20:22:05 +0200
Received: from localhost ([127.0.0.1])
 by sslproxy07.your-server.de with esmtpsa (TLS1.3) tls TLS_AES_256_GCM_SHA384
 (Exim 4.96) (envelope-from <contact@sayyadumar.com>)
 id 1x5oq5-000PM1-14; Sun, 13 Sep 2026 20:22:05 +0200
From: Sayyad Mahammad Umar <contact@sayyadumar.com>
Date: Sun, 13 Sep 2026 20:21:06 +0200
Subject: [PATCH 2/2] hw/rx: add common RX peripherals
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20260913-umar-rx-series-v1-2-5a5841a5d1e9@sayyadumar.com>
References: <20260913-umar-rx-series-v1-0-5a5841a5d1e9@sayyadumar.com>
In-Reply-To: <20260913-umar-rx-series-v1-0-5a5841a5d1e9@sayyadumar.com>
To: qemu-devel@nongnu.org
Cc: Yoshinori Sato <yoshinori.sato@nifty.com>, 
 Alistair Francis <alistair@alistair23.me>, 
 Peter Maydell <peter.maydell@linaro.org>, Jason Wang <jasowangio@gmail.com>, 
 qemu-arm@nongnu.org, Sayyad Mahammad Umar <contact@sayyadumar.com>
X-Mailer: b4 0.16.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1789323724; l=188919;
 i=contact@sayyadumar.com; s=qemu; h=from:subject:message-id;
 bh=704bB4yRlSvwWkt3R4nmRrMS9MVPnIyyyfoqmXQyO5g=;
 b=QSOt9t/Yg9iQbM2VWA4okdX78P2Hwe+xiF8UGgVaJdLWz9jM3zJWY1+MlE8AkaZjG1NPuSNne
 6btTGUfewqgDQwoEHZIa8RrDq3GHn+0nD0ysbsLiJqxaMQ607VJ0dg3
X-Developer-Key: i=contact@sayyadumar.com; a=ed25519;
 pk=CsAjTLRCB7+pnzmj8902JER4gL8CTzNQFxlMZTl4wDk=
X-Virus-Scanned: Clear (ClamAV 1.4.3/28122/Sun Sep 13 08:26:25 2026)
Received-SPF: pass client-ip=85.10.213.182;
 envelope-from=contact@sayyadumar.com; helo=www675.your-server.de
X-Spam_score_int: -16
X-Spam_score: -1.7
X-Spam_bar: -
X-Spam_report: (-1.7 / 5.0 requ) BAYES_00=-1.9, DKIM_INVALID=0.1,
 DKIM_SIGNED=0.1, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
X-Spam_action: no action
X-Mailman-Approved-At: Sun, 13 Sep 2026 15:49:41 -0400
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

Signed-off-by: Sayyad Mahammad Umar <contact@sayyadumar.com>
---
 MAINTAINERS                           |  20 +
 hw/adc/renesas_s12ad.c                | 324 +++++++++++
 hw/dma/renesas_rx_dmac.c              | 317 +++++++++++
 hw/dma/renesas_rx_dtc.c               | 169 ++++++
 hw/gpio/renesas_rx_gpio.c             | 256 +++++++++
 hw/misc/renesas_rx_crc.c              | 219 ++++++++
 hw/misc/renesas_rx_fcu.c              | 985 ++++++++++++++++++++++++++++++++++
 hw/misc/renesas_rx_romcache.c         | 139 +++++
 hw/misc/rx65n_sysclk.c                | 190 +++++++
 hw/net/renesas_etherc.c               | 955 ++++++++++++++++++++++++++++++++
 hw/rtc/renesas_rx_rtc.c               | 330 ++++++++++++
 hw/ssi/renesas_rspi.c                 | 319 +++++++++++
 hw/timer/renesas_mtu3.c               | 509 ++++++++++++++++++
 hw/watchdog/renesas_rx_wdt.c          | 193 +++++++
 include/hw/adc/renesas_s12ad.h        |  61 +++
 include/hw/dma/renesas_rx_dmac.h      |  57 ++
 include/hw/dma/renesas_rx_dtc.h       |  42 ++
 include/hw/gpio/renesas_rx_gpio.h     |  64 +++
 include/hw/misc/renesas_rx_crc.h      |  30 ++
 include/hw/misc/renesas_rx_fcu.h      | 191 +++++++
 include/hw/misc/renesas_rx_romcache.h |  30 ++
 include/hw/misc/rx65n_sysclk.h        |  37 ++
 include/hw/net/renesas_etherc.h       | 109 ++++
 include/hw/rtc/renesas_rx_rtc.h       |  52 ++
 include/hw/ssi/renesas_rspi.h         |  61 +++
 include/hw/timer/renesas_mtu3.h       |  73 +++
 include/hw/watchdog/renesas_rx_wdt.h  |  48 ++
 27 files changed, 5780 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index 7183babd6a..8cd5fb62c7 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -3034,10 +3034,30 @@ F: include/hw/timer/renesas_*.h
 Renesas RX peripherals
 R: Yoshinori Sato <yoshinori.sato@nifty.com>
 S: Orphan
+F: hw/adc/renesas_s12ad.c
+F: hw/dma/renesas_rx_*.c
+F: hw/gpio/renesas_rx_gpio.c
 F: hw/intc/rx_icu.c
+F: hw/misc/renesas_rx_*.c
+F: hw/misc/rx65n_sysclk.c
+F: hw/net/renesas_etherc.c
+F: hw/rtc/renesas_rx_rtc.c
 F: hw/rx/
+F: hw/ssi/renesas_rspi.c
+F: hw/timer/renesas_mtu3.c
+F: hw/watchdog/renesas_rx_wdt.c
+F: include/hw/adc/renesas_s12ad.h
+F: include/hw/dma/renesas_rx_*.h
+F: include/hw/gpio/renesas_rx_gpio.h
 F: include/hw/intc/rx_icu.h
+F: include/hw/misc/renesas_rx_*.h
+F: include/hw/misc/rx65n_sysclk.h
+F: include/hw/net/renesas_etherc.h
+F: include/hw/rtc/renesas_rx_rtc.h
 F: include/hw/rx/
+F: include/hw/ssi/renesas_rspi.h
+F: include/hw/timer/renesas_mtu3.h
+F: include/hw/watchdog/renesas_rx_wdt.h
 
 CAN bus subsystem and hardware
 M: Pavel Pisa <pisa@cmp.felk.cvut.cz>
diff --git a/hw/adc/renesas_s12ad.c b/hw/adc/renesas_s12ad.c
new file mode 100644
index 0000000000..e01d9ececd
--- /dev/null
+++ b/hw/adc/renesas_s12ad.c
@@ -0,0 +1,324 @@
+/*
+ * Renesas RX65N 12-bit Successive Approximation A/D Converter (S12AD)
+ *
+ * Datasheet: RX65N Group, RX651 Group User's Manual: Hardware
+ *            (Rev.1.00 R01UH0590EJ0100), Section 40
+ *
+ * Copyright (c) 2026 Umar, Sayyad Mahammad
+ *
+ * SPDX-License-Identifier: GPL-2.0-or-later
+ *
+ */
+
+#include "qemu/osdep.h"
+#include "qemu/log.h"
+#include "hw/core/irq.h"
+#include "hw/core/registerfields.h"
+#include "hw/core/qdev-properties.h"
+#include "hw/adc/renesas_s12ad.h"
+#include "migration/vmstate.h"
+
+/*
+ * Register offsets from device base (0x00089000).
+ * Reference: RX65N Group Hardware Manual Table 40.1
+ */
+REG16(ADCSR,   0x00)
+  FIELD(ADCSR, DBLANS,  0, 5)   /* double trigger channel */
+  FIELD(ADCSR, GBADIE,  6, 1)   /* group B scan end interrupt enable */
+  FIELD(ADCSR, DBLE,    7, 1)   /* double trigger enable */
+  FIELD(ADCSR, EXTRG,   8, 1)   /* trigger select (0=sync, 1=async) */
+  FIELD(ADCSR, TRGE,    9, 1)   /* trigger start enable */
+  FIELD(ADCSR, ADHSC,  10, 1)   /* high-speed conversion */
+  FIELD(ADCSR, ADIE,   12, 1)   /* group A end interrupt enable */
+  FIELD(ADCSR, ADCS,   13, 2)   /* scan mode */
+  FIELD(ADCSR, ADST,   15, 1)   /* start conversion (W1 to start, hw clears) */
+
+REG16(ADANSA0, 0x04)   /* channel select 0 (AN000-AN015) */
+REG16(ADANSA1, 0x06)   /* channel select 1 (AN016-AN020) */
+REG16(ADADS0,  0x08)   /* average enable 0 */
+REG16(ADADS1,  0x0A)   /* average enable 1 */
+REG8(ADADC,    0x0C)   /* average count */
+REG16(ADCER,   0x0E)   /* control extended */
+REG16(ADSTRGR, 0x10)   /* start trigger select */
+REG16(ADEXICR, 0x12)   /* extended input */
+REG16(ADANSB0, 0x14)   /* group B channel select 0 */
+REG16(ADANSB1, 0x16)   /* group B channel select 1 */
+REG16(ADDBLDR, 0x18)   /* double-buffer result */
+REG16(ADRD,    0x1E)   /* temperature sensor / internal Vref result */
+/* ADDR0–ADDR15 at offsets 0x20–0x3E (16-bit each) */
+#define A_ADDR_BASE   0x20
+#define A_ADDR_END    0x3E   /* inclusive */
+#define A_ADSAMPR     0x63
+#define A_ADSAM       0x6e
+
+/*
+ * Simulated conversion time: ~1 µs (typical for 12-bit at 60 MHz PCLK).
+ * Real hardware takes ~1–17 µs depending on mode and clock.
+ */
+#define CONV_TIME_NS   1000
+
+/* Fixed mid-scale return value for all channels: 0x0800 = 2048 (12-bit) */
+#define DUMMY_RESULT   0x0800
+
+static void s12ad_conv_done(void *opaque)
+{
+    RX65NS12ADState *s = opaque;
+
+    /* Clear ADST, set results */
+    s->adcsr = FIELD_DP16(s->adcsr, ADCSR, ADST, 0);
+
+    /* Fill result registers with mid-scale dummy value */
+    for (int i = 0; i < S12AD_NR_CHANNELS; i++) {
+        if (s->adansa0 & (1u << i)) {
+            s->addr[i] = DUMMY_RESULT << 4; /* left-justified by default */
+        }
+    }
+    s->adrd = DUMMY_RESULT << 4;
+
+    /* Fire end-of-scan interrupt if enabled */
+    if (FIELD_EX16(s->adcsr, ADCSR, ADIE)) {
+        qemu_irq_pulse(s->irq[S12AD_IRQ_S12ADI]);
+    }
+    if (FIELD_EX16(s->adcsr, ADCSR, GBADIE)) {
+        qemu_irq_pulse(s->irq[S12AD_IRQ_GBADI]);
+    }
+}
+
+static uint64_t s12ad_read(void *opaque, hwaddr addr, unsigned size)
+{
+    RX65NS12ADState *s = opaque;
+
+    if (addr >= 0x70 && addr + size <= 0xf0) {
+        uint8_t *p = &s->ext_regs[addr - 0x70];
+
+        return size == 1 ? *p : lduw_le_p(p);
+    }
+
+    if (addr >= A_ADDR_BASE && addr <= A_ADDR_END) {
+        int ch = (addr - A_ADDR_BASE) / 2;
+        return (ch < S12AD_NR_CHANNELS) ? s->addr[ch] : UINT64_MAX;
+    }
+
+    switch (addr) {
+    case A_ADCSR:
+        return s->adcsr;
+    case A_ADANSA0:
+        return s->adansa0;
+    case A_ADANSA1:
+        return s->adansa1;
+    case A_ADADS0:
+        return s->adads0;
+    case A_ADADS1:
+        return s->adads1;
+    case A_ADADC:
+        return s->adadc;
+    case A_ADCER:
+        return s->adcer;
+    case A_ADSTRGR:
+        return s->adstrgr;
+    case A_ADEXICR:
+        return s->adexicr;
+    case A_ADANSB0:
+        return s->adansb0;
+    case A_ADANSB1:
+        return s->adansb1;
+    case A_ADDBLDR:
+        return 0;
+    case 0x1a:  /* ADTSDR */
+    case 0x1c:  /* ADOCDR */
+        return DUMMY_RESULT << 4;
+    case A_ADRD:
+        return s->adrd;
+    case A_ADSAMPR:
+        return s->adsampr == 3 ? 1 : 0;
+    case A_ADSAM:
+        return s->adsampr == 3 ? s->adsam : 0;
+    default:
+        qemu_log_mask(LOG_UNIMP, "renesas_s12ad: read 0x%" HWADDR_PRIX
+                      " not implemented\n",
+                      addr);
+        return UINT64_MAX;
+    }
+}
+
+static void s12ad_write(void *opaque, hwaddr addr, uint64_t val, unsigned size)
+{
+    RX65NS12ADState *s = opaque;
+
+    if (addr >= 0x70 && addr + size <= 0xf0) {
+        uint8_t *p = &s->ext_regs[addr - 0x70];
+
+        if (size == 1) {
+            *p = val;
+        } else {
+            stw_le_p(p, val);
+        }
+        return;
+    }
+
+    switch (addr) {
+    case A_ADCSR:
+        s->adcsr = val & ~FIELD_DP16(0, ADCSR, ADST, 1); /* keep ADST for now */
+        s->adcsr |= (val & FIELD_DP16(0, ADCSR, ADST, 1));
+        if (FIELD_EX16(val, ADCSR, ADST)) {
+            /* Software-triggered start: schedule conversion completion */
+            timer_mod(&s->conv_timer,
+                      qemu_clock_get_ns(QEMU_CLOCK_VIRTUAL) + CONV_TIME_NS);
+        }
+        break;
+    case A_ADANSA0:
+        s->adansa0  = val;
+        break;
+    case A_ADANSA1:
+        s->adansa1  = val;
+        break;
+    case A_ADADS0:
+        s->adads0   = val;
+        break;
+    case A_ADADS1:
+        s->adads1   = val;
+        break;
+    case A_ADADC:
+        s->adadc    = val;
+        break;
+    case A_ADCER:
+        s->adcer    = val;
+        break;
+    case A_ADSTRGR:
+        s->adstrgr  = val;
+        break;
+    case A_ADEXICR:
+        s->adexicr  = val;
+        break;
+    case A_ADANSB0:
+        s->adansb0  = val;
+        break;
+    case A_ADANSB1:
+        s->adansb1  = val;
+        break;
+    case A_ADSAMPR:
+        s->adsampr = val & 0x3;
+        break;
+    case A_ADSAM:
+        if (s->adsampr == 3) {
+            s->adsam = val & 0x20;
+        }
+        break;
+    default:
+        qemu_log_mask(LOG_UNIMP, "renesas_s12ad: write 0x%" HWADDR_PRIX
+                      " not implemented\n",
+                      addr);
+        break;
+    }
+}
+
+static const MemoryRegionOps s12ad_ops = {
+    .read  = s12ad_read,
+    .write = s12ad_write,
+    .endianness = DEVICE_LITTLE_ENDIAN,
+    .impl = {
+        .min_access_size = 1,
+        .max_access_size = 2,
+    },
+    .valid = {
+        .min_access_size = 1,
+        .max_access_size = 2,
+    },
+};
+
+static void s12ad_reset(DeviceState *dev)
+{
+    RX65NS12ADState *s = RENESAS_S12AD(dev);
+    int i;
+
+    s->adcsr   = 0x0000;
+    s->adansa0 = 0x0000;
+    s->adansa1 = 0x0000;
+    s->adads0  = 0x0000;
+    s->adads1  = 0x0000;
+    s->adadc   = 0x00;
+    s->adcer   = 0x0000;
+    s->adstrgr = 0x0000;
+    s->adexicr = 0x0000;
+    s->adansb0 = 0x0000;
+    s->adansb1 = 0x0000;
+    s->adrd    = 0x0000;
+    s->adsam   = 0x0000;
+    s->adsampr = 0x00;
+    memset(s->ext_regs, 0, sizeof(s->ext_regs));
+    for (i = 0; i < S12AD_NR_CHANNELS; i++) {
+        s->addr[i] = 0x0000;
+    }
+    timer_del(&s->conv_timer);
+}
+
+static void s12ad_init(Object *obj)
+{
+    SysBusDevice *d = SYS_BUS_DEVICE(obj);
+    RX65NS12ADState *s = RENESAS_S12AD(obj);
+    int i;
+
+    /* Includes the conversion-time registers at offsets 0x63 and 0x6e. */
+    memory_region_init_io(&s->memory, obj, &s12ad_ops, s,
+                          "renesas-s12ad", 0xf0);
+    sysbus_init_mmio(d, &s->memory);
+
+    for (i = 0; i < S12AD_NR_IRQ; i++) {
+        sysbus_init_irq(d, &s->irq[i]);
+    }
+    timer_init_ns(&s->conv_timer, QEMU_CLOCK_VIRTUAL, s12ad_conv_done, s);
+}
+
+static const VMStateDescription vmstate_s12ad = {
+    .name = "renesas-s12ad",
+    .version_id = 1,
+    .minimum_version_id = 1,
+    .fields = (const VMStateField[]) {
+        VMSTATE_UINT16(adcsr,   RX65NS12ADState),
+        VMSTATE_UINT16(adansa0, RX65NS12ADState),
+        VMSTATE_UINT16(adansa1, RX65NS12ADState),
+        VMSTATE_UINT16(adads0,  RX65NS12ADState),
+        VMSTATE_UINT16(adads1,  RX65NS12ADState),
+        VMSTATE_UINT8(adadc,    RX65NS12ADState),
+        VMSTATE_UINT16(adcer,   RX65NS12ADState),
+        VMSTATE_UINT16(adstrgr, RX65NS12ADState),
+        VMSTATE_UINT16(adexicr, RX65NS12ADState),
+        VMSTATE_UINT16(adansb0, RX65NS12ADState),
+        VMSTATE_UINT16(adansb1, RX65NS12ADState),
+        VMSTATE_UINT16(adrd,    RX65NS12ADState),
+        VMSTATE_UINT16(adsam,   RX65NS12ADState),
+        VMSTATE_UINT8(adsampr,  RX65NS12ADState),
+        VMSTATE_UINT8_ARRAY(ext_regs, RX65NS12ADState, 0x80),
+        VMSTATE_UINT16_ARRAY(addr, RX65NS12ADState, S12AD_NR_CHANNELS),
+        VMSTATE_TIMER(conv_timer, RX65NS12ADState),
+        VMSTATE_END_OF_LIST()
+    }
+};
+
+static const Property s12ad_properties[] = {
+    DEFINE_PROP_UINT64("input-freq", RX65NS12ADState, input_freq, 0),
+};
+
+static void s12ad_class_init(ObjectClass *klass, const void *data)
+{
+    DeviceClass *dc = DEVICE_CLASS(klass);
+
+    dc->vmsd = &vmstate_s12ad;
+    device_class_set_legacy_reset(dc, s12ad_reset);
+    device_class_set_props(dc, s12ad_properties);
+}
+
+static const TypeInfo s12ad_info = {
+    .name          = TYPE_RENESAS_S12AD,
+    .parent        = TYPE_SYS_BUS_DEVICE,
+    .instance_size = sizeof(RX65NS12ADState),
+    .instance_init = s12ad_init,
+    .class_init    = s12ad_class_init,
+};
+
+static void s12ad_register_types(void)
+{
+    type_register_static(&s12ad_info);
+}
+
+type_init(s12ad_register_types)
diff --git a/hw/dma/renesas_rx_dmac.c b/hw/dma/renesas_rx_dmac.c
new file mode 100644
index 0000000000..11e44e104c
--- /dev/null
+++ b/hw/dma/renesas_rx_dmac.c
@@ -0,0 +1,317 @@
+/*
+ * Renesas RX DMA Controller (DMAC)
+ *
+ * Datasheet: RX65N Group, RX651 Group User's Manual: Hardware
+ *            (Rev.1.00 R01UH0590EJ0100), section 17 (DMAC)
+ *
+ * Copyright (c) 2026 Umar, Sayyad Mahammad
+ *
+ * SPDX-License-Identifier: GPL-2.0-or-later
+ *
+ *
+ * Models the eight DMAC channels. Hardware (peripheral-triggered) activation is
+ * not modelled; software-requested transfers (DMREQ.SWREQ) are performed
+ * synchronously, which covers memory-to-memory use and driver self-tests. The
+ * source/destination address increment modes and 8/16/32-bit transfer unit are
+ * honoured.
+ */
+
+#include "qemu/osdep.h"
+#include "qemu/log.h"
+#include "hw/dma/renesas_rx_dmac.h"
+#include "hw/core/irq.h"
+#include "hw/core/qdev-properties.h"
+#include "migration/vmstate.h"
+#include "system/address-spaces.h"
+
+/* Per-channel register offsets. */
+#define R_DMSAR     0x00    /* 32-bit */
+#define R_DMDAR     0x04    /* 32-bit */
+#define R_DMCRA     0x08    /* 32-bit */
+#define R_DMCRB     0x0C    /* 16-bit */
+#define R_DMTMD     0x10    /* 16-bit */
+#define R_DMINT     0x13    /* 8-bit  */
+#define R_DMAMD     0x14    /* 16-bit */
+#define R_DMOFR     0x18    /* 32-bit */
+#define R_DMCNT     0x1C    /* 8-bit  */
+#define R_DMREQ     0x1D    /* 8-bit  */
+#define R_DMSTS     0x1E    /* 8-bit  */
+
+/* Common registers. */
+#define R_DMAST     0x200   /* 8-bit  */
+
+/* DMTMD: SZ field (bits 9:8) = transfer unit. */
+#define DMTMD_SZ(v)     (((v) >> 8) & 3)
+/* DMAMD: SM (bits 9:8) source mode, DM (bits 13:12) destination mode. */
+#define DMAMD_SM(v)     (((v) >> 8) & 3)
+#define DMAMD_DM(v)     (((v) >> 12) & 3)
+#define ADDR_MODE_FIXED 0
+#define ADDR_MODE_OFF   1   /* offset addition (not modelled, treated fixed) */
+#define ADDR_MODE_INC   2
+#define ADDR_MODE_DEC   3
+
+#define DMCNT_DTE       (1u << 0)   /* transfer enable */
+#define DMREQ_SWREQ     (1u << 0)   /* software request */
+#define DMREQ_CLRS      (1u << 4)
+#define DMSTS_ACT       (1u << 7)
+#define DMSTS_DTIF      (1u << 1)   /* transfer-end interrupt flag */
+
+static unsigned dmac_unit_bytes(uint16_t dmtmd)
+{
+    switch (DMTMD_SZ(dmtmd)) {
+    case 0:
+        return 1;
+    case 1:
+        return 2;
+    default: return 4;
+    }
+}
+
+static void dmac_step_addr(uint32_t *addr, unsigned mode, unsigned bytes)
+{
+    if (mode == ADDR_MODE_INC) {
+        *addr += bytes;
+    } else if (mode == ADDR_MODE_DEC) {
+        *addr -= bytes;
+    }
+}
+
+/* Perform a software-requested transfer on a channel. */
+static void dmac_do_transfer(RenesasRxDmacState *s, int n)
+{
+    RxDmacChannel *c = &s->ch[n];
+    unsigned bytes = dmac_unit_bytes(c->dmtmd);
+    unsigned smode = DMAMD_SM(c->dmamd);
+    unsigned dmode = DMAMD_DM(c->dmamd);
+    uint16_t count = c->dmcra & 0xffff;
+    uint8_t buf[4];
+
+    if (!(s->dmast & 1) || !(c->dmcnt & DMCNT_DTE)) {
+        return;
+    }
+
+    /* A zero count means 65536 transfers on hardware; clamp it for QEMU. */
+    if (count == 0) {
+        count = 1;
+    }
+
+    while (count--) {
+        address_space_read(s->as, c->dmsar, MEMTXATTRS_UNSPECIFIED, buf, bytes);
+        address_space_write(s->as, c->dmdar, MEMTXATTRS_UNSPECIFIED,
+                            buf, bytes);
+        dmac_step_addr(&c->dmsar, smode, bytes);
+        dmac_step_addr(&c->dmdar, dmode, bytes);
+    }
+
+    /* Transfer complete: clear enable, flag status, raise interrupt. */
+    c->dmcra &= 0xffff0000;
+    c->dmcnt &= ~DMCNT_DTE;
+    c->dmsts = (c->dmsts & ~DMSTS_ACT) | DMSTS_DTIF;
+    if (c->dmint & 1) {
+        qemu_irq_pulse(s->irq[n]);
+    }
+}
+
+static uint64_t dmac_read(void *opaque, hwaddr offset, unsigned size)
+{
+    RenesasRxDmacState *s = opaque;
+    RxDmacChannel *c;
+    unsigned reg;
+
+    if (offset == R_DMAST) {
+        return s->dmast;
+    }
+    if (offset >= RX_DMAC_NR_CH * RX_DMAC_CH_SIZE) {
+        return 0;
+    }
+
+    c = &s->ch[offset / RX_DMAC_CH_SIZE];
+    reg = offset % RX_DMAC_CH_SIZE;
+    switch (reg) {
+    case R_DMSAR:
+        return c->dmsar;
+    case R_DMDAR:
+        return c->dmdar;
+    case R_DMCRA:
+        return c->dmcra;
+    case R_DMCRB:
+        return c->dmcrb;
+    case R_DMTMD:
+        return c->dmtmd;
+    case R_DMINT:
+        return c->dmint;
+    case R_DMAMD:
+        return c->dmamd;
+    case R_DMOFR:
+        return c->dmofr;
+    case R_DMCNT:
+        return c->dmcnt;
+    case R_DMREQ:
+        return c->dmreq;
+    case R_DMSTS:
+        return c->dmsts;
+    default:      return 0;
+    }
+}
+
+static void dmac_write(void *opaque, hwaddr offset, uint64_t value,
+                       unsigned size)
+{
+    RenesasRxDmacState *s = opaque;
+    RxDmacChannel *c;
+    unsigned reg, n;
+
+    if (offset == R_DMAST) {
+        s->dmast = value;
+        return;
+    }
+    if (offset >= RX_DMAC_NR_CH * RX_DMAC_CH_SIZE) {
+        qemu_log_mask(LOG_UNIMP, "renesas-rx-dmac: write unimplemented 0x%"
+                      HWADDR_PRIx "\n", offset);
+        return;
+    }
+
+    n = offset / RX_DMAC_CH_SIZE;
+    c = &s->ch[n];
+    reg = offset % RX_DMAC_CH_SIZE;
+    switch (reg) {
+    case R_DMSAR:
+        c->dmsar = value;
+        break;
+    case R_DMDAR:
+        c->dmdar = value;
+        break;
+    case R_DMCRA:
+        c->dmcra = value;
+        break;
+    case R_DMCRB:
+        c->dmcrb = value;
+        break;
+    case R_DMTMD:
+        c->dmtmd = value;
+        break;
+    case R_DMINT:
+        c->dmint = value;
+        break;
+    case R_DMAMD:
+        c->dmamd = value;
+        break;
+    case R_DMOFR:
+        c->dmofr = value;
+        break;
+    case R_DMCNT:
+        c->dmcnt = value;
+        break;
+    case R_DMREQ:
+        c->dmreq = value;
+        if (value & DMREQ_SWREQ) {
+            dmac_do_transfer(s, n);
+            c->dmreq &= ~DMREQ_SWREQ;
+        }
+        break;
+    case R_DMSTS:
+        /* DTIF/ACT are status flags cleared by writing the register. */
+        c->dmsts = value;
+        break;
+    default:
+        qemu_log_mask(LOG_UNIMP, "renesas-rx-dmac: write unimplemented 0x%"
+                      HWADDR_PRIx "\n", offset);
+        break;
+    }
+}
+
+static const MemoryRegionOps dmac_ops = {
+    .read = dmac_read,
+    .write = dmac_write,
+    .endianness = DEVICE_LITTLE_ENDIAN,
+    .impl = { .min_access_size = 1, .max_access_size = 4 },
+    .valid = { .min_access_size = 1, .max_access_size = 4 },
+};
+
+static void rx_dmac_reset(DeviceState *dev)
+{
+    RenesasRxDmacState *s = RENESAS_RX_DMAC(dev);
+
+    memset(s->ch, 0, sizeof(s->ch));
+    s->dmast = 0;
+}
+
+static void rx_dmac_realize(DeviceState *dev, Error **errp)
+{
+    RenesasRxDmacState *s = RENESAS_RX_DMAC(dev);
+    SysBusDevice *sbd = SYS_BUS_DEVICE(dev);
+
+    if (s->dma_mr == NULL) {
+        s->dma_mr = get_system_memory();
+    }
+    s->as = g_new0(AddressSpace, 1);
+    address_space_init(s->as, s->dma_mr, "renesas-rx-dmac");
+
+    memory_region_init_io(&s->mr, OBJECT(s), &dmac_ops, s,
+                          "renesas-rx-dmac", RX_DMAC_REGS_SIZE);
+    sysbus_init_mmio(sbd, &s->mr);
+    for (int i = 0; i < RX_DMAC_NR_CH; i++) {
+        sysbus_init_irq(sbd, &s->irq[i]);
+    }
+}
+
+static const Property rx_dmac_properties[] = {
+    DEFINE_PROP_LINK("dma-memory", RenesasRxDmacState, dma_mr,
+                     TYPE_MEMORY_REGION, MemoryRegion *),
+};
+
+static const VMStateDescription vmstate_rx_dmac_ch = {
+    .name = "renesas-rx-dmac-channel",
+    .version_id = 1,
+    .minimum_version_id = 1,
+    .fields = (const VMStateField[]) {
+        VMSTATE_UINT32(dmsar, RxDmacChannel),
+        VMSTATE_UINT32(dmdar, RxDmacChannel),
+        VMSTATE_UINT32(dmcra, RxDmacChannel),
+        VMSTATE_UINT16(dmcrb, RxDmacChannel),
+        VMSTATE_UINT16(dmtmd, RxDmacChannel),
+        VMSTATE_UINT8(dmint, RxDmacChannel),
+        VMSTATE_UINT16(dmamd, RxDmacChannel),
+        VMSTATE_UINT32(dmofr, RxDmacChannel),
+        VMSTATE_UINT8(dmcnt, RxDmacChannel),
+        VMSTATE_UINT8(dmreq, RxDmacChannel),
+        VMSTATE_UINT8(dmsts, RxDmacChannel),
+        VMSTATE_END_OF_LIST()
+    }
+};
+
+static const VMStateDescription vmstate_rx_dmac = {
+    .name = "renesas-rx-dmac",
+    .version_id = 1,
+    .minimum_version_id = 1,
+    .fields = (const VMStateField[]) {
+        VMSTATE_STRUCT_ARRAY(ch, RenesasRxDmacState, RX_DMAC_NR_CH, 1,
+                             vmstate_rx_dmac_ch, RxDmacChannel),
+        VMSTATE_UINT8(dmast, RenesasRxDmacState),
+        VMSTATE_END_OF_LIST()
+    }
+};
+
+static void rx_dmac_class_init(ObjectClass *klass, const void *data)
+{
+    DeviceClass *dc = DEVICE_CLASS(klass);
+
+    dc->realize = rx_dmac_realize;
+    dc->vmsd = &vmstate_rx_dmac;
+    device_class_set_props(dc, rx_dmac_properties);
+    device_class_set_legacy_reset(dc, rx_dmac_reset);
+}
+
+static const TypeInfo rx_dmac_info = {
+    .name = TYPE_RENESAS_RX_DMAC,
+    .parent = TYPE_SYS_BUS_DEVICE,
+    .instance_size = sizeof(RenesasRxDmacState),
+    .class_init = rx_dmac_class_init,
+};
+
+static void rx_dmac_register_types(void)
+{
+    type_register_static(&rx_dmac_info);
+}
+
+type_init(rx_dmac_register_types)
diff --git a/hw/dma/renesas_rx_dtc.c b/hw/dma/renesas_rx_dtc.c
new file mode 100644
index 0000000000..10ac87be9a
--- /dev/null
+++ b/hw/dma/renesas_rx_dtc.c
@@ -0,0 +1,169 @@
+/*
+ * Renesas RX Data Transfer Controller (DTC)
+ *
+ * Datasheet: RX65N Group, RX651 Group User's Manual: Hardware
+ *            (Rev.1.00 R01UH0590EJ0100), section 18 (DTC)
+ *
+ * Copyright (c) 2026 Umar, Sayyad Mahammad
+ *
+ * SPDX-License-Identifier: GPL-2.0-or-later
+ *
+ *
+ * Register-level model of the DTC. The DTC fetches RAM-resident transfer
+ * descriptors when activated by a peripheral interrupt; that activation path is
+ * not modelled, so the control/status registers behave as storage and the
+ * module always reports idle. This lets FIT/RTOS drivers configure and enable
+ * the DTC (and fall back to interrupt-driven transfers) without faulting.
+ */
+
+#include "qemu/osdep.h"
+#include "qemu/log.h"
+#include "hw/dma/renesas_rx_dtc.h"
+#include "hw/core/qdev-properties.h"
+#include "migration/vmstate.h"
+
+#define R_DTCCR     0x00    /* 8-bit  */
+#define R_DTCVBR    0x04    /* 32-bit */
+#define R_DTCADMOD  0x08    /* 8-bit  */
+#define R_DTCST     0x0C    /* 8-bit  */
+#define R_DTCSTS    0x0E    /* 16-bit */
+#define R_DTCIBR    0x10    /* 32-bit */
+#define R_DTCOR     0x14    /* 8-bit  */
+#define R_DTCEXBR   0x18    /* 16-bit */
+
+static uint64_t dtc_read(void *opaque, hwaddr offset, unsigned size)
+{
+    RenesasRxDtcState *s = opaque;
+
+    switch (offset) {
+    case R_DTCCR:
+        return s->dtccr;
+    case R_DTCVBR:
+        return s->dtcvbr;
+    case R_DTCADMOD:
+        return s->dtcadmod;
+    case R_DTCST:
+        return s->dtcst;
+    case R_DTCSTS:
+        /*ACT=0: never busy */
+        return s->dtcsts;
+    case R_DTCIBR:
+        return s->dtcibr;
+    case R_DTCOR:
+        return s->dtcor;
+    case R_DTCEXBR:
+        return s->dtcexbr;
+    default:
+        qemu_log_mask(LOG_UNIMP, "renesas-rx-dtc: read unimplemented 0x%"
+                      HWADDR_PRIx "\n", offset);
+        return 0;
+    }
+}
+
+static void dtc_write(void *opaque, hwaddr offset, uint64_t value,
+                      unsigned size)
+{
+    RenesasRxDtcState *s = opaque;
+
+    switch (offset) {
+    case R_DTCCR:
+        s->dtccr = value;
+        break;
+    case R_DTCVBR:
+        s->dtcvbr = value;
+        break;
+    case R_DTCADMOD:
+        s->dtcadmod = value;
+        break;
+    case R_DTCST:
+        s->dtcst = value;
+        break;
+    case R_DTCIBR:
+        s->dtcibr = value;
+        break;
+    case R_DTCOR:
+        s->dtcor = value;
+        break;
+    case R_DTCEXBR:
+        s->dtcexbr = value;
+        break;
+    case R_DTCSTS:
+        /*status, read-only */
+        break;
+    default:
+        qemu_log_mask(LOG_UNIMP, "renesas-rx-dtc: write unimplemented 0x%"
+                      HWADDR_PRIx "\n", offset);
+        break;
+    }
+}
+
+static const MemoryRegionOps dtc_ops = {
+    .read = dtc_read,
+    .write = dtc_write,
+    .endianness = DEVICE_LITTLE_ENDIAN,
+    .impl = { .min_access_size = 1, .max_access_size = 4 },
+    .valid = { .min_access_size = 1, .max_access_size = 4 },
+};
+
+static void rx_dtc_reset(DeviceState *dev)
+{
+    RenesasRxDtcState *s = RENESAS_RX_DTC(dev);
+
+    s->dtccr = 0x08;    /* RRS = 1 out of reset */
+    s->dtcvbr = 0;
+    s->dtcadmod = 0;
+    s->dtcst = 0;
+    s->dtcsts = 0;
+    s->dtcibr = 0;
+    s->dtcor = 0;
+    s->dtcexbr = 0;
+}
+
+static void rx_dtc_init(Object *obj)
+{
+    RenesasRxDtcState *s = RENESAS_RX_DTC(obj);
+
+    memory_region_init_io(&s->mr, obj, &dtc_ops, s,
+                          "renesas-rx-dtc", RX_DTC_REGS_SIZE);
+    sysbus_init_mmio(SYS_BUS_DEVICE(obj), &s->mr);
+}
+
+static const VMStateDescription vmstate_rx_dtc = {
+    .name = "renesas-rx-dtc",
+    .version_id = 1,
+    .minimum_version_id = 1,
+    .fields = (const VMStateField[]) {
+        VMSTATE_UINT8(dtccr, RenesasRxDtcState),
+        VMSTATE_UINT32(dtcvbr, RenesasRxDtcState),
+        VMSTATE_UINT8(dtcadmod, RenesasRxDtcState),
+        VMSTATE_UINT8(dtcst, RenesasRxDtcState),
+        VMSTATE_UINT16(dtcsts, RenesasRxDtcState),
+        VMSTATE_UINT32(dtcibr, RenesasRxDtcState),
+        VMSTATE_UINT8(dtcor, RenesasRxDtcState),
+        VMSTATE_UINT16(dtcexbr, RenesasRxDtcState),
+        VMSTATE_END_OF_LIST()
+    }
+};
+
+static void rx_dtc_class_init(ObjectClass *klass, const void *data)
+{
+    DeviceClass *dc = DEVICE_CLASS(klass);
+
+    dc->vmsd = &vmstate_rx_dtc;
+    device_class_set_legacy_reset(dc, rx_dtc_reset);
+}
+
+static const TypeInfo rx_dtc_info = {
+    .name = TYPE_RENESAS_RX_DTC,
+    .parent = TYPE_SYS_BUS_DEVICE,
+    .instance_size = sizeof(RenesasRxDtcState),
+    .instance_init = rx_dtc_init,
+    .class_init = rx_dtc_class_init,
+};
+
+static void rx_dtc_register_types(void)
+{
+    type_register_static(&rx_dtc_info);
+}
+
+type_init(rx_dtc_register_types)
diff --git a/hw/gpio/renesas_rx_gpio.c b/hw/gpio/renesas_rx_gpio.c
new file mode 100644
index 0000000000..3a40d88948
--- /dev/null
+++ b/hw/gpio/renesas_rx_gpio.c
@@ -0,0 +1,256 @@
+/*
+ * Renesas RX I/O Ports (GPIO) and Multi-Function Pin Controller (MPC)
+ *
+ * Datasheet: RX65N Group, RX651 Group User's Manual: Hardware
+ *            (Rev.1.00 R01UH0590EJ0100), sections 20 (I/O Ports) and 22 (MPC)
+ *
+ * Copyright (c) 2026 Umar, Sayyad Mahammad
+ *
+ * SPDX-License-Identifier: GPL-2.0-or-later
+ *
+ *
+ * Each 8-bit I/O port exposes a direction register (PDR), an output data
+ * register (PODR) and an input data register (PIDR). Output pins drive the
+ * corresponding "gpio-out" line (used by board LEDs); input pins read back the
+ * level driven on the "gpio-in" line (used by board switches). The MPC PFS
+ * registers select alternate pin functions and behave as plain storage.
+ */
+
+#include "qemu/osdep.h"
+#include "qemu/log.h"
+#include "hw/gpio/renesas_rx_gpio.h"
+#include "hw/core/irq.h"
+#include "hw/core/qdev-properties.h"
+#include "migration/vmstate.h"
+
+/* Per-port register offsets within the I/O port block (index = port number). */
+#define R_PDR   0x000   /* 1 byte per port */
+#define R_PODR  0x020
+#define R_PIDR  0x040
+#define R_PMR   0x060
+#define R_ODR   0x080   /* 2 bytes per port */
+#define R_PCR   0x0C0
+#define R_DSCR  0x0E0
+#define R_END   0x100
+
+/* MPC write-protect register, relative to the MPC block base (0x0008C100). */
+#define R_PWPR  0x01F   /* 0x0008C11F */
+
+/* Compute the input-data value seen for a port. */
+static uint8_t port_pidr(RenesasRxGpioState *s, unsigned p)
+{
+    uint8_t value;
+
+    /* Output pins read back their output latch; input pins read the pin. */
+    value = (s->podr[p] & s->pdr[p]) | (s->input[p] & ~s->pdr[p]);
+    return value;
+}
+
+/* Drive the per-pin output lines for a port from PDR/PODR. */
+static void port_update_out(RenesasRxGpioState *s, unsigned p)
+{
+    for (unsigned b = 0; b < 8; b++) {
+        int level = 0;
+        if (s->pdr[p] & (1 << b)) {                 /* output pin */
+            level = (s->podr[p] >> b) & 1;
+        }
+        qemu_set_irq(s->out[p * 8 + b], level);
+    }
+}
+
+static uint64_t gpio_port_read(void *opaque, hwaddr offset, unsigned size)
+{
+    RenesasRxGpioState *s = opaque;
+    unsigned p = offset & 0x1f;
+
+    switch (offset & ~0x1f) {
+    case R_PDR:
+        return s->pdr[p];
+    case R_PODR:
+        return s->podr[p];
+    case R_PIDR:
+        return port_pidr(s, p);
+    case R_PMR:
+        return s->pmr[p];
+    case R_PCR:
+        return s->pcr[p];
+    case R_DSCR:
+        return s->dscr[p];
+    default:
+        if (offset >= R_ODR && offset < R_PCR) {
+            return s->odr[offset - R_ODR];
+        }
+        qemu_log_mask(LOG_UNIMP, "renesas-rx-gpio: read unimplemented 0x%"
+                      HWADDR_PRIx "\n", offset);
+        return 0;
+    }
+}
+
+static void gpio_port_write(void *opaque, hwaddr offset, uint64_t value,
+                            unsigned size)
+{
+    RenesasRxGpioState *s = opaque;
+    unsigned p = offset & 0x1f;
+
+    switch (offset & ~0x1f) {
+    case R_PDR:
+        s->pdr[p] = value;
+        port_update_out(s, p);
+        break;
+    case R_PODR:
+        s->podr[p] = value;
+        port_update_out(s, p);
+        break;
+    case R_PMR:
+        s->pmr[p] = value;
+        break;
+    case R_PCR:
+        s->pcr[p] = value;
+        break;
+    case R_DSCR:
+        s->dscr[p] = value;
+        break;
+    case R_PIDR:
+        /* Input data register is read-only. */
+        break;
+    default:
+        if (offset >= R_ODR && offset < R_PCR) {
+            s->odr[offset - R_ODR] = value;
+        } else {
+            qemu_log_mask(LOG_UNIMP, "renesas-rx-gpio: write unimplemented 0x%"
+                          HWADDR_PRIx "\n", offset);
+        }
+        break;
+    }
+}
+
+static const MemoryRegionOps gpio_port_ops = {
+    .read = gpio_port_read,
+    .write = gpio_port_write,
+    .endianness = DEVICE_LITTLE_ENDIAN,
+    .impl = { .min_access_size = 1, .max_access_size = 1 },
+    .valid = { .min_access_size = 1, .max_access_size = 1 },
+};
+
+static uint64_t gpio_mpc_read(void *opaque, hwaddr offset, unsigned size)
+{
+    RenesasRxGpioState *s = opaque;
+    uint64_t val = 0;
+
+    for (unsigned i = 0; i < size && offset + i < RX_GPIO_MPC_SIZE; i++) {
+        val |= (uint64_t)s->mpc[offset + i] << (8 * i);
+    }
+    return val;
+}
+
+static void gpio_mpc_write(void *opaque, hwaddr offset, uint64_t value,
+                           unsigned size)
+{
+    RenesasRxGpioState *s = opaque;
+
+    /*
+     * PFS registers are locked unless PWPR.PFSWE is set (and PWPR.B0WI clear).
+     * Storing the PFS selection is otherwise sufficient: QEMU peripherals are
+     * wired unconditionally, so pin muxing has no functional effect here.
+     */
+    for (unsigned i = 0; i < size && offset + i < RX_GPIO_MPC_SIZE; i++) {
+        s->mpc[offset + i] = (value >> (8 * i)) & 0xff;
+    }
+}
+
+static const MemoryRegionOps gpio_mpc_ops = {
+    .read = gpio_mpc_read,
+    .write = gpio_mpc_write,
+    .endianness = DEVICE_LITTLE_ENDIAN,
+    .impl = { .min_access_size = 1, .max_access_size = 1 },
+    .valid = { .min_access_size = 1, .max_access_size = 1 },
+};
+
+/* External input line handler: pin = port * 8 + bit. */
+static void gpio_set_input(void *opaque, int pin, int level)
+{
+    RenesasRxGpioState *s = opaque;
+    unsigned p = pin / 8, b = pin % 8;
+
+    if (level) {
+        s->input[p] |= (1 << b);
+    } else {
+        s->input[p] &= ~(1 << b);
+    }
+}
+
+static void rx_gpio_reset(DeviceState *dev)
+{
+    RenesasRxGpioState *s = RENESAS_RX_GPIO(dev);
+
+    memset(s->pdr, 0, sizeof(s->pdr));
+    memset(s->podr, 0, sizeof(s->podr));
+    memset(s->pmr, 0, sizeof(s->pmr));
+    memset(s->odr, 0, sizeof(s->odr));
+    memset(s->pcr, 0, sizeof(s->pcr));
+    memset(s->dscr, 0, sizeof(s->dscr));
+    memset(s->mpc, 0, sizeof(s->mpc));
+    /* PWPR resets with B0WI set (PFS write disabled). */
+    s->mpc[R_PWPR] = 0x80;
+
+    for (unsigned p = 0; p < RX_GPIO_NR_PORTS; p++) {
+        port_update_out(s, p);
+    }
+}
+
+static void rx_gpio_init(Object *obj)
+{
+    RenesasRxGpioState *s = RENESAS_RX_GPIO(obj);
+    SysBusDevice *sbd = SYS_BUS_DEVICE(obj);
+
+    memory_region_init_io(&s->port_mr, obj, &gpio_port_ops, s,
+                          "renesas-rx-gpio.port", RX_GPIO_PORT_SIZE);
+    memory_region_init_io(&s->mpc_mr, obj, &gpio_mpc_ops, s,
+                          "renesas-rx-gpio.mpc", RX_GPIO_MPC_SIZE);
+    sysbus_init_mmio(sbd, &s->port_mr);
+    sysbus_init_mmio(sbd, &s->mpc_mr);
+
+    qdev_init_gpio_out_named(DEVICE(obj), s->out, "gpio-out", RX_GPIO_NR_PINS);
+    qdev_init_gpio_in_named(DEVICE(obj), gpio_set_input, "gpio-in",
+                            RX_GPIO_NR_PINS);
+}
+
+static const VMStateDescription vmstate_rx_gpio = {
+    .name = "renesas-rx-gpio",
+    .version_id = 1,
+    .minimum_version_id = 1,
+    .fields = (const VMStateField[]) {
+        VMSTATE_UINT8_ARRAY(pdr, RenesasRxGpioState, RX_GPIO_NR_PORTS),
+        VMSTATE_UINT8_ARRAY(podr, RenesasRxGpioState, RX_GPIO_NR_PORTS),
+        VMSTATE_UINT8_ARRAY(pmr, RenesasRxGpioState, RX_GPIO_NR_PORTS),
+        VMSTATE_UINT8_ARRAY(odr, RenesasRxGpioState, RX_GPIO_NR_PORTS * 2),
+        VMSTATE_UINT8_ARRAY(pcr, RenesasRxGpioState, RX_GPIO_NR_PORTS),
+        VMSTATE_UINT8_ARRAY(dscr, RenesasRxGpioState, RX_GPIO_NR_PORTS),
+        VMSTATE_UINT8_ARRAY(input, RenesasRxGpioState, RX_GPIO_NR_PORTS),
+        VMSTATE_UINT8_ARRAY(mpc, RenesasRxGpioState, RX_GPIO_MPC_SIZE),
+        VMSTATE_END_OF_LIST()
+    }
+};
+
+static void rx_gpio_class_init(ObjectClass *klass, const void *data)
+{
+    DeviceClass *dc = DEVICE_CLASS(klass);
+
+    dc->vmsd = &vmstate_rx_gpio;
+    device_class_set_legacy_reset(dc, rx_gpio_reset);
+}
+
+static const TypeInfo rx_gpio_info = {
+    .name = TYPE_RENESAS_RX_GPIO,
+    .parent = TYPE_SYS_BUS_DEVICE,
+    .instance_size = sizeof(RenesasRxGpioState),
+    .instance_init = rx_gpio_init,
+    .class_init = rx_gpio_class_init,
+};
+
+static void rx_gpio_register_types(void)
+{
+    type_register_static(&rx_gpio_info);
+}
+
+type_init(rx_gpio_register_types)
diff --git a/hw/misc/renesas_rx_crc.c b/hw/misc/renesas_rx_crc.c
new file mode 100644
index 0000000000..f06ac4a64e
--- /dev/null
+++ b/hw/misc/renesas_rx_crc.c
@@ -0,0 +1,219 @@
+/*
+ * Renesas RX CRC Calculator (CRCA)
+ *
+ * Datasheet: RX65N Group, RX651 Group User's Manual: Hardware
+ *            (Rev.2.40 R01UH0590EJ0240), section 42
+ *
+ * Copyright (c) 2026 Umar, Sayyad Mahammad
+ *
+ * SPDX-License-Identifier: GPL-2.0-or-later
+ *
+ * Writing to CRCDIR runs the selected polynomial over the data and leaves the
+ * result in CRCDOR, which doubles as the initial value: it is zero out of
+ * reset, DORCLR puts it back, and firmware wanting a different seed writes it
+ * directly. There is no final XOR, so the familiar CRC-32 of a message is
+ * obtained by seeding CRCDOR with all ones and inverting the result.
+ *
+ * CRCCR.LMS picks the bit order. MSB first is the plain shift-left form; LSB
+ * first is the reflected form, computed with the reversed polynomial. The two
+ * worked examples in section 42.3 pin this down: with the CCITT polynomial and
+ * a cleared CRCDOR, feeding 0xf0 gives 0xef1f MSB first and 0xf78f LSB first.
+ */
+
+#include "qemu/osdep.h"
+#include "qemu/log.h"
+#include "qemu/bitops.h"
+#include "hw/misc/renesas_rx_crc.h"
+#include "hw/core/registerfields.h"
+#include "hw/core/qdev-properties.h"
+#include "migration/vmstate.h"
+
+REG8(CRCCR, 0)
+    FIELD(CRCCR, GPS, 0, 3)
+    FIELD(CRCCR, LMS, 6, 1)
+    FIELD(CRCCR, DORCLR, 7, 1)
+
+#define R_CRCDIR    0x04
+#define R_CRCDOR    0x08
+
+/* CRCCR is read/write apart from the write-only DORCLR bit. */
+#define CRCCR_RW_MASK   (R_CRCCR_GPS_MASK | R_CRCCR_LMS_MASK)
+
+/*
+ * Generating polynomials selected by CRCCR.GPS, without the implicit top
+ * term. Entries 0, 6 and 7 select "no calculation".
+ */
+static const struct {
+    uint32_t poly;
+    uint8_t width;
+} crc_gps[8] = {
+    [1] = { 0x07,       8  },   /* X8 + X2 + X + 1                          */
+    [2] = { 0x8005,     16 },   /* X16 + X15 + X2 + 1                       */
+    [3] = { 0x1021,     16 },   /* X16 + X12 + X5 + 1                       */
+    [4] = { 0x04c11db7, 32 },   /* X32 + X26 + X23 + ... + X2 + X + 1       */
+    [5] = { 0x1edc6f41, 32 },   /* X32 + X28 + X27 + ... + X8 + X6 + 1      */
+};
+
+static uint32_t bitreverse(uint32_t value, unsigned width)
+{
+    return revbit32(value) >> (32 - width);
+}
+
+/* Run nbits of data through the selected polynomial. */
+static void crc_feed(RenesasRxCrcState *s, uint32_t data, unsigned nbits)
+{
+    unsigned gps = FIELD_EX8(s->crccr, CRCCR, GPS);
+    uint32_t poly = crc_gps[gps].poly;
+    unsigned width = crc_gps[gps].width;
+    uint32_t mask, crc;
+
+    if (width == 0) {
+        return;             /* GPS selects no calculation */
+    }
+    if (nbits > width) {
+        qemu_log_mask(LOG_GUEST_ERROR,
+                      "renesas-rx-crc: %u-bit write to CRCDIR with a %u-bit "
+                      "polynomial selected\n", nbits, width);
+        nbits = width;
+    }
+
+    mask = width == 32 ? UINT32_MAX : (1u << width) - 1;
+    crc = s->crcdor & mask;
+
+    if (FIELD_EX8(s->crccr, CRCCR, LMS)) {
+        /* MSB first: shift up, align the data with the top of the register. */
+        crc ^= (data << (width - nbits)) & mask;
+        while (nbits--) {
+            crc = (crc & (mask ^ (mask >> 1))) ? ((crc << 1) ^ poly) & mask
+                                               : (crc << 1) & mask;
+        }
+    } else {
+        /* LSB first: the reflected form, so shift down with a reversed poly. */
+        uint32_t rpoly = bitreverse(poly, width);
+
+        crc ^= data & mask;
+        while (nbits--) {
+            crc = (crc & 1) ? (crc >> 1) ^ rpoly : crc >> 1;
+        }
+    }
+
+    s->crcdor = crc;
+}
+
+static uint64_t crc_read(void *opaque, hwaddr offset, unsigned size)
+{
+    RenesasRxCrcState *s = opaque;
+
+    switch (offset) {
+    case A_CRCCR:
+        /* DORCLR always reads back as 0. */
+        return s->crccr & CRCCR_RW_MASK;
+    case R_CRCDIR:
+        /*
+         * CRCDIR is documented readable, but the hardware keeps no separate
+         * copy of the data written to it, so nothing meaningful comes back.
+         */
+        return 0;
+    case R_CRCDOR:
+        if (size >= 4) {
+            return s->crcdor;
+        }
+        return s->crcdor & ((1u << (size * 8)) - 1);
+    default:
+        qemu_log_mask(LOG_GUEST_ERROR,
+                      "renesas-rx-crc: read from unmapped offset 0x%"
+                      HWADDR_PRIx "\n", offset);
+        return 0;
+    }
+}
+
+static void crc_write(void *opaque, hwaddr offset, uint64_t value,
+                      unsigned size)
+{
+    RenesasRxCrcState *s = opaque;
+
+    switch (offset) {
+    case A_CRCCR:
+        s->crccr = value & CRCCR_RW_MASK;
+        if (FIELD_EX8(value, CRCCR, DORCLR)) {
+            s->crcdor = 0;
+        }
+        break;
+    case R_CRCDIR:
+        crc_feed(s, value, size * 8);
+        break;
+    case R_CRCDOR:
+        /* Writable so firmware can seed the calculation. */
+        if (size >= 4) {
+            s->crcdor = value;
+        } else {
+            uint32_t m = (1u << (size * 8)) - 1;
+            s->crcdor = (s->crcdor & ~m) | (value & m);
+        }
+        break;
+    default:
+        qemu_log_mask(LOG_GUEST_ERROR,
+                      "renesas-rx-crc: write to unmapped offset 0x%"
+                      HWADDR_PRIx "\n", offset);
+        break;
+    }
+}
+
+static const MemoryRegionOps crc_ops = {
+    .read = crc_read,
+    .write = crc_write,
+    .endianness = DEVICE_LITTLE_ENDIAN,
+    .impl = { .min_access_size = 1, .max_access_size = 4 },
+    .valid = { .min_access_size = 1, .max_access_size = 4 },
+};
+
+static void rx_crc_reset(DeviceState *dev)
+{
+    RenesasRxCrcState *s = RENESAS_RX_CRC(dev);
+
+    s->crccr = 0;
+    s->crcdor = 0;
+}
+
+static void rx_crc_init(Object *obj)
+{
+    RenesasRxCrcState *s = RENESAS_RX_CRC(obj);
+
+    memory_region_init_io(&s->memory, obj, &crc_ops, s,
+                          "renesas-rx-crc", RX_CRC_SIZE);
+    sysbus_init_mmio(SYS_BUS_DEVICE(obj), &s->memory);
+}
+
+static const VMStateDescription vmstate_rx_crc = {
+    .name = "renesas-rx-crc",
+    .version_id = 1,
+    .minimum_version_id = 1,
+    .fields = (const VMStateField[]) {
+        VMSTATE_UINT8(crccr, RenesasRxCrcState),
+        VMSTATE_UINT32(crcdor, RenesasRxCrcState),
+        VMSTATE_END_OF_LIST()
+    }
+};
+
+static void rx_crc_class_init(ObjectClass *klass, const void *data)
+{
+    DeviceClass *dc = DEVICE_CLASS(klass);
+
+    dc->vmsd = &vmstate_rx_crc;
+    device_class_set_legacy_reset(dc, rx_crc_reset);
+}
+
+static const TypeInfo rx_crc_info = {
+    .name          = TYPE_RENESAS_RX_CRC,
+    .parent        = TYPE_SYS_BUS_DEVICE,
+    .instance_size = sizeof(RenesasRxCrcState),
+    .instance_init = rx_crc_init,
+    .class_init    = rx_crc_class_init,
+};
+
+static void rx_crc_register_types(void)
+{
+    type_register_static(&rx_crc_info);
+}
+
+type_init(rx_crc_register_types)
diff --git a/hw/misc/renesas_rx_fcu.c b/hw/misc/renesas_rx_fcu.c
new file mode 100644
index 0000000000..309abdb0f2
--- /dev/null
+++ b/hw/misc/renesas_rx_fcu.c
@@ -0,0 +1,985 @@
+/*
+ * Renesas RX Flash Control Unit (FCU) with FACI command interface
+ *
+ * Datasheet: RX65N Group, RX651 Group User's Manual: Hardware
+ *            (Rev.1.00 R01UH0590EJ0100), section 6 (Flash Memory)
+ *
+ * Copyright (c) 2026 Umar, Sayyad Mahammad
+ *
+ * SPDX-License-Identifier: GPL-2.0-or-later
+ *
+ *
+ * The RX65N programs and erases its on-chip code and data flash through the
+ * Flash Application Command Interface (FACI). Firmware first enters P/E mode
+ * for the target array via FENTRYR, then issues command sequences by writing
+ * command bytes and data words to the destination address inside the flash
+ * array itself, polling FSTATR.FRDY for completion.
+ *
+ * Both flash arrays are modelled as ROM-device memory regions: ordinary reads
+ * and instruction fetches hit the backing RAM directly (fast, and firmware is
+ * still loaded by the QEMU ROM loader, which bypasses these write callbacks),
+ * while guest writes are routed here and interpreted as FACI commands. QEMU
+ * models no real program/erase timing, so every command completes
+ * synchronously and FRDY always reads ready.
+ */
+
+#include "qemu/osdep.h"
+#include "qemu/log.h"
+#include "qemu/bswap.h"
+#include "hw/misc/renesas_rx_fcu.h"
+#include "hw/core/irq.h"
+#include "hw/core/qdev-properties.h"
+#include "hw/core/qdev-properties-system.h"
+#include "system/block-backend.h"
+#include "hw/block/block.h"
+#include "qemu/error-report.h"
+#include "qemu/units.h"
+#include "migration/vmstate.h"
+#include "qapi/error.h"
+
+/* FACI control register offsets from the register block base (0x007FE000). */
+#define R_FASTAT    0x010   /* Flash Access Status            (8-bit)  */
+#define R_FAEINT    0x014   /* Flash Access Err Int Enable    (8-bit)  */
+#define R_FRDYIE    0x018   /* Flash Ready Int Enable         (8-bit)  */
+#define R_FSADDR    0x030   /* Flash Processing Start Address (32-bit) */
+#define R_FEADDR    0x034   /* Flash Processing End Address    (32-bit) */
+#define R_FSTATR    0x080   /* Flash Status                   (32-bit) */
+#define R_FENTRYR   0x084   /* Flash P/E Mode Entry           (16-bit) */
+#define R_FPROTR    0x088   /* Flash Protection               (16-bit) */
+#define R_FSUACR    0x08C   /* Startup Area Control           (16-bit) */
+#define R_FCMDR     0x0A0   /* FACI Command                   (16-bit) */
+#define R_FPESTAT   0x0C0   /* P/E Error Status               (16-bit) */
+#define R_FBCCNT    0x0D0   /* Blank Check Control            (16-bit) */
+#define R_FBCSTAT   0x0D4   /* Blank Check Status             (8-bit)  */
+#define R_FPSADDR   0x0D8   /* Programmed/Erased Start Addr   (32-bit) */
+#define R_FCPSR     0x0E0   /* Clear/Processing Switch        (16-bit) */
+#define R_FPCKAR    0x0E4   /* Processing Clock Notification  (16-bit) */
+
+/* FSTATR bit definitions. */
+#define FSTATR_FRDY     (1u << 6)   /* Flash ready                     */
+#define FSTATR_PRGERR   (1u << 13)  /* Programming error               */
+#define FSTATR_ERSERR   (1u << 14)  /* Erasure error                   */
+#define FSTATR_ILGLERR  (1u << 15)  /* Illegal command error           */
+#define FSTATR_OTERR    (1u << 16)  /* Other error                     */
+#define FSTATR_ERRORS   (FSTATR_PRGERR | FSTATR_ERSERR | \
+                         FSTATR_ILGLERR | FSTATR_OTERR)
+
+/* FASTAT bit definitions. */
+#define FASTAT_CMDLK    (1u << 4)   /* Command lock                    */
+
+/* FENTRYR: key code in the upper byte, target bits in the lower byte. */
+#define FENTRYR_KEY     0xAA00
+#define FENTRYR_CODE    0x0001      /* code flash P/E mode             */
+#define FENTRYR_DATA    0x0080      /* data flash P/E mode             */
+
+/* FBCSTAT: BCST = 0 means the checked range is blank (all 0xFF). */
+#define FBCSTAT_BCST    (1u << 0)
+
+/* FACI command codes. */
+#define FACI_CMD_PROGRAM     0xE8
+#define FACI_CMD_BLOCK_ERASE 0x20
+#define FACI_CMD_BLANK_CHECK 0x71
+#define FACI_CMD_CONFIG_SET  0x40
+#define FACI_CMD_CLEAR_STAT  0x50
+#define FACI_CMD_FORCED_STOP 0xB3
+#define FACI_CMD_CONFIRM     0xD0
+
+/* Erase block granularity (HW manual section 6). */
+#define CFLASH_ERASE_BLOCK   0x8000     /* 32 KiB code flash block     */
+#define CFLASH_SMALL_BLOCK   0x2000     /* 8 KiB block, blocks 0 to 7  */
+#define CFLASH_SMALL_REGION  0x10000    /* the eight small blocks span 64 KiB */
+#define CFLASH_MIN_DUAL_SIZE (1536 * KiB)
+#define DFLASH_ERASE_BLOCK   0x40       /* 64-byte data flash block    */
+
+static bool target_in_pe_mode(RenesasRxFcuState *s, RxFcuTarget t)
+{
+    return t == RX_FCU_CFLASH ? (s->fentryr & FENTRYR_CODE)
+                              : (s->fentryr & FENTRYR_DATA);
+}
+
+static uint8_t *target_storage(RenesasRxFcuState *s, RxFcuTarget t)
+{
+    return t == RX_FCU_CFLASH ? s->cflash_ptr : s->dflash_ptr;
+}
+
+static uint32_t target_size(RenesasRxFcuState *s, RxFcuTarget t)
+{
+    return t == RX_FCU_CFLASH ? s->cflash_size : s->dflash_size;
+}
+
+/* Translate an absolute CPU flash address to an array-relative offset. */
+static bool addr_to_offset(RenesasRxFcuState *s, RxFcuTarget t,
+                           uint32_t addr, uint32_t *off)
+{
+    uint32_t base = t == RX_FCU_CFLASH ? s->cflash_base : s->dflash_base;
+
+    if (t == RX_FCU_CFLASH && s->dual_mode) {
+        uint32_t bank_size = s->cflash_size / 2;
+        uint32_t lower_base = s->cflash_base - s->dual_bank_gap_size;
+        uint32_t upper_base = s->cflash_base + bank_size;
+        uint32_t bank;
+
+        if (addr >= lower_base && addr - lower_base < bank_size) {
+            bank = 0;
+            *off = addr - lower_base;
+        } else if (addr >= upper_base && addr - upper_base < bank_size) {
+            bank = 1;
+            *off = addr - upper_base;
+        } else {
+            return false;
+        }
+        if (s->bank_swapped) {
+            bank ^= 1;
+        }
+        *off += bank * bank_size;
+        return true;
+    }
+
+    if (addr < base || addr - base >= target_size(s, t)) {
+        return false;
+    }
+    *off = addr - base;
+    return true;
+}
+
+/*
+ * Code flash erase blocks are not uniform: the top 64 KB of each bank (of the
+ * whole array in linear mode) is eight 8 KB blocks, and everything below is
+ * 32 KB blocks. Return the block containing a physical offset.
+ */
+static void cflash_erase_block(RenesasRxFcuState *s, uint32_t off,
+                               uint32_t *start, uint32_t *len)
+{
+    uint32_t unit = s->dual_mode ? s->cflash_size / 2 : s->cflash_size;
+    uint32_t within = off % unit;
+    uint32_t base = off - within;
+
+    if (within >= unit - CFLASH_SMALL_REGION) {
+        *len = CFLASH_SMALL_BLOCK;
+    } else {
+        *len = CFLASH_ERASE_BLOCK;
+    }
+    *start = base + (within & ~(*len - 1));
+}
+
+/*
+ * FCMDR pairs the command just received (CMDR, low byte) with the one before
+ * it (PCMDR, high byte). A two-byte sequence such as block erase therefore
+ * ends up reading 0x20d0: 0x20 shifted up by the 0xd0 confirm. The confirm
+ * that terminates a programming sequence is not recorded, which is why the
+ * manual lists programming as leaving CMDR at 0xe8.
+ */
+static void faci_set_cmdr(RenesasRxFcuState *s, uint8_t cmd)
+{
+    s->fcmdr = ((s->fcmdr & 0xff) << 8) | cmd;
+}
+
+/* Finish a command: report ready and pulse the ready interrupt if enabled. */
+static void faci_complete(RenesasRxFcuState *s)
+{
+    s->cmd_state = RX_FCU_ST_READY;
+    s->fstatr |= FSTATR_FRDY;
+    if (s->frdyie & 1) {
+        qemu_irq_pulse(s->frdyi);
+    }
+}
+
+/* Flag an illegal command: lock the sequencer and raise the error interrupt. */
+static void faci_illegal(RenesasRxFcuState *s)
+{
+    s->cmd_state = RX_FCU_ST_READY;
+    s->fstatr |= FSTATR_ILGLERR | FSTATR_FRDY;
+    s->fastat |= FASTAT_CMDLK;
+    if (s->faeint) {
+        qemu_set_irq(s->fiferr, 1);
+    }
+}
+
+/* Write the option-setting memory back to its image, if one is attached. */
+static void fcu_ofsm_sync(RenesasRxFcuState *s)
+{
+    if (!s->ofsm_blk || s->ofsm_ro) {
+        return;
+    }
+    if (blk_pwrite(s->ofsm_blk, 0, RX_FCU_OFSM_SIZE, s->ofsm_ptr, 0) < 0) {
+        error_report("renesas-rx-fcu: could not write the OFSM image");
+    }
+}
+
+/*
+ * Write a modified range of an array back to its block backend, if one is
+ * attached. Offsets are widened to sector boundaries the way pflash does.
+ */
+static void fcu_flash_sync(RenesasRxFcuState *s, RxFcuTarget t,
+                           uint32_t off, uint32_t len)
+{
+    BlockBackend *blk = t == RX_FCU_CFLASH ? s->cflash_blk : s->dflash_blk;
+    bool ro = t == RX_FCU_CFLASH ? s->cflash_ro : s->dflash_ro;
+    uint32_t size = target_size(s, t);
+    uint64_t start, end;
+    int ret;
+
+    if (!blk || ro) {
+        return;
+    }
+    start = QEMU_ALIGN_DOWN(off, BDRV_SECTOR_SIZE);
+    end = QEMU_ALIGN_UP((uint64_t)off + len, BDRV_SECTOR_SIZE);
+    if (end > size) {
+        end = size;
+    }
+    if (start >= end) {
+        return;
+    }
+    ret = blk_pwrite(blk, start, end - start,
+                     target_storage(s, t) + start, 0);
+    if (ret < 0) {
+        error_report("renesas-rx-fcu: could not write flash image: %s",
+                     strerror(-ret));
+    }
+}
+
+static void faci_block_erase(RenesasRxFcuState *s, RxFcuTarget t, uint32_t off)
+{
+    uint32_t size = target_size(s, t);
+    uint32_t block, start;
+
+    if (t == RX_FCU_CFLASH) {
+        cflash_erase_block(s, off, &start, &block);
+    } else {
+        block = DFLASH_ERASE_BLOCK;
+        start = off & ~(block - 1);
+    }
+
+    if (start >= size) {
+        faci_illegal(s);
+        return;
+    }
+    if (start + block > size) {
+        block = size - start;
+    }
+    memset(target_storage(s, t) + start, 0xff, block);
+    fcu_flash_sync(s, t, start, block);
+    s->fpsaddr = (t == RX_FCU_CFLASH ? s->cflash_base : s->dflash_base) + start;
+    faci_complete(s);
+}
+
+static void faci_blank_check(RenesasRxFcuState *s, RxFcuTarget t)
+{
+    uint32_t start, end;
+    const uint8_t *p;
+
+    if (!addr_to_offset(s, t, s->fsaddr, &start) ||
+        !addr_to_offset(s, t, s->feaddr, &end) || end < start) {
+        faci_illegal(s);
+        return;
+    }
+
+    p = target_storage(s, t);
+    s->fbcstat = 0;     /* assume blank */
+    for (uint32_t i = start; i <= end; i++) {
+        if (p[i] != 0xff) {
+            s->fbcstat = FBCSTAT_BCST;  /* not blank */
+            break;
+        }
+    }
+    faci_complete(s);
+}
+
+/*
+ * Interpret a guest write to a flash array address while that array is in P/E
+ * mode. Implements the FACI program / block-erase / blank-check sequences.
+ */
+static void faci_command(RenesasRxFcuState *s, RxFcuTarget t,
+                         uint32_t off, uint64_t value, unsigned size)
+{
+    uint8_t cmd = value & 0xff;
+
+    switch (s->cmd_state) {
+    case RX_FCU_ST_READY:
+        faci_set_cmdr(s, cmd);
+        switch (cmd) {
+        case FACI_CMD_PROGRAM:
+            s->cmd_target = t;
+            s->prog_off = off;
+            s->cmd_state = RX_FCU_ST_PROGRAM_COUNT;
+            break;
+        case FACI_CMD_BLOCK_ERASE:
+            s->cmd_target = t;
+            s->prog_off = off;
+            s->cmd_state = RX_FCU_ST_ERASE;
+            break;
+        case FACI_CMD_BLANK_CHECK:
+            s->cmd_target = t;
+            s->cmd_state = RX_FCU_ST_BLANKCHECK;
+            break;
+        case FACI_CMD_CONFIG_SET:
+            /*
+             * Configuration set writes one 16-byte row of the option-setting
+             * memory. FSADDR selects the row: its low byte is the offset
+             * within the OFSM, so 0x00ff5d20 reaches BANKSEL at +0x20.
+             */
+            s->cfg_off = s->fsaddr & (RX_FCU_OFSM_SIZE - 1) & ~0xfu;
+            s->cmd_state = RX_FCU_ST_CONFIG_COUNT;
+            break;
+        case FACI_CMD_CLEAR_STAT:
+            s->fstatr = (s->fstatr & ~FSTATR_ERRORS) | FSTATR_FRDY;
+            s->fastat &= ~FASTAT_CMDLK;
+            qemu_set_irq(s->fiferr, 0);
+            break;
+        case FACI_CMD_FORCED_STOP:
+            s->fstatr = (s->fstatr & ~FSTATR_ERRORS) | FSTATR_FRDY;
+            s->fastat &= ~FASTAT_CMDLK;
+            s->cmd_state = RX_FCU_ST_READY;
+            qemu_set_irq(s->fiferr, 0);
+            break;
+        default:
+            faci_illegal(s);
+            break;
+        }
+        break;
+
+    case RX_FCU_ST_CONFIG_COUNT:
+        /* Always eight 16-bit words, i.e. the 16-byte row. */
+        s->prog_words = value & 0xff;
+        s->cmd_state = RX_FCU_ST_CONFIG_DATA;
+        break;
+
+    case RX_FCU_ST_CONFIG_DATA:
+        if (s->prog_words > 0) {
+            if (s->cfg_off + 2 <= RX_FCU_OFSM_SIZE) {
+                /* Like the arrays, programming can only clear bits. */
+                uint16_t cur = lduw_le_p(s->ofsm_ptr + s->cfg_off);
+                stw_le_p(s->ofsm_ptr + s->cfg_off, cur & (uint16_t)value);
+            }
+            s->cfg_off += 2;
+            s->prog_words--;
+        } else if (cmd == FACI_CMD_CONFIRM) {
+            fcu_ofsm_sync(s);
+            faci_complete(s);
+        } else {
+            faci_illegal(s);
+        }
+        break;
+
+    case RX_FCU_ST_PROGRAM_COUNT:
+        /* Number of 16-bit data words that follow. */
+        s->prog_words = value & 0xff;
+        s->cmd_state = RX_FCU_ST_PROGRAM_DATA;
+        break;
+
+    case RX_FCU_ST_PROGRAM_DATA:
+        if (s->prog_words > 0) {
+            uint8_t *p = target_storage(s, s->cmd_target);
+            uint32_t sz = target_size(s, s->cmd_target);
+            if (s->prog_off + 2 <= sz) {
+                /* Flash programming only clears bits; emulate it with AND. */
+                uint16_t cur = lduw_le_p(p + s->prog_off);
+                stw_le_p(p + s->prog_off, cur & (uint16_t)value);
+                fcu_flash_sync(s, s->cmd_target, s->prog_off, 2);
+            }
+            s->prog_off += 2;
+            s->prog_words--;
+        } else if (cmd == FACI_CMD_CONFIRM) {
+            faci_complete(s);
+        } else {
+            faci_illegal(s);
+        }
+        break;
+
+    case RX_FCU_ST_ERASE:
+        if (cmd == FACI_CMD_CONFIRM) {
+            faci_set_cmdr(s, cmd);
+            faci_block_erase(s, s->cmd_target, s->prog_off);
+        } else {
+            faci_illegal(s);
+        }
+        break;
+
+    case RX_FCU_ST_BLANKCHECK:
+        if (cmd == FACI_CMD_CONFIRM) {
+            faci_set_cmdr(s, cmd);
+            faci_blank_check(s, s->cmd_target);
+        } else {
+            faci_illegal(s);
+        }
+        break;
+    }
+}
+
+static uint64_t faci_flash_read(void *opaque, hwaddr offset, unsigned size)
+{
+    RxFcuFlash *f = opaque;
+    const uint8_t *p = target_storage(f->fcu, f->target);
+
+    /*
+     * This callback is only reached while the array is in P/E mode (romd is
+     * disabled); outside P/E mode reads hit the backing RAM directly. Return
+     * the stored contents so reads remain coherent in either mode.
+     */
+    switch (size) {
+    case 1:
+        return p[offset];
+    case 2:
+        return lduw_le_p(p + offset);
+    default:
+        return ldl_le_p(p + offset);
+    }
+}
+
+static void faci_flash_write(void *opaque, hwaddr offset, uint64_t value,
+                             unsigned size)
+{
+    RxFcuFlash *f = opaque;
+
+    qemu_log_mask(LOG_GUEST_ERROR,
+                  "renesas-rx-fcu: write to the %s flash array @0x%"
+                  HWADDR_PRIx "; FACI commands are issued to 0x%08x\n",
+                  f->target == RX_FCU_CFLASH ? "code" : "data", offset,
+                  RX_FCU_FACI_ISSUE_BASE);
+}
+
+/*
+ * The FACI command-issuing area. Every FACI command byte and every data word
+ * is written here, four bytes at 0x007E0000, rather than to the flash array;
+ * the destination inside the array comes from FSADDR. The array itself is
+ * not writable, so a write there is a guest error rather than a command.
+ */
+static void faci_issue_write(void *opaque, hwaddr offset, uint64_t value,
+                             unsigned size)
+{
+    RenesasRxFcuState *s = opaque;
+    RxFcuTarget t;
+    uint32_t off;
+
+    if (target_in_pe_mode(s, RX_FCU_CFLASH)) {
+        t = RX_FCU_CFLASH;
+    } else if (target_in_pe_mode(s, RX_FCU_DFLASH)) {
+        t = RX_FCU_DFLASH;
+    } else {
+        qemu_log_mask(LOG_GUEST_ERROR,
+                      "renesas-rx-fcu: FACI command 0x%02x issued while "
+                      "neither array is in P/E mode\n", (uint8_t)value);
+        return;
+    }
+
+    /*
+     * Only the command that opens a sequence needs an address; the count,
+     * data words and confirmation that follow continue where it left off.
+     */
+    if (s->cmd_state == RX_FCU_ST_READY) {
+        if (!addr_to_offset(s, t, s->fsaddr, &off)) {
+            faci_illegal(s);
+            return;
+        }
+    } else {
+        off = s->prog_off;
+    }
+    faci_command(s, t, off, value, size);
+}
+
+static uint64_t faci_issue_read(void *opaque, hwaddr offset, unsigned size)
+{
+    /* The command-issuing area is write-only; reads are undefined. */
+    return 0;
+}
+
+static const MemoryRegionOps faci_issue_ops = {
+    .read = faci_issue_read,
+    .write = faci_issue_write,
+    .endianness = DEVICE_LITTLE_ENDIAN,
+    .valid = {
+        .min_access_size = 1,
+        .max_access_size = 4,
+    },
+};
+
+static const MemoryRegionOps faci_flash_ops = {
+    .read = faci_flash_read,
+    .write = faci_flash_write,
+    .endianness = DEVICE_LITTLE_ENDIAN,
+    .valid = {
+        .min_access_size = 1,
+        .max_access_size = 4,
+    },
+};
+
+/* Update P/E mode entry and toggle the rom_device read path accordingly. */
+static void fcu_set_fentryr(RenesasRxFcuState *s, uint16_t value)
+{
+    bool was_code = s->fentryr & FENTRYR_CODE;
+    bool was_data = s->fentryr & FENTRYR_DATA;
+    bool code, data;
+
+    if ((value & 0xff00) != FENTRYR_KEY) {
+        qemu_log_mask(LOG_GUEST_ERROR,
+                      "renesas-rx-fcu: FENTRYR write without key (0x%04x)\n",
+                      value);
+        return;
+    }
+
+    code = value & FENTRYR_CODE;
+    data = value & FENTRYR_DATA;
+    s->fentryr = (code ? FENTRYR_CODE : 0) | (data ? FENTRYR_DATA : 0);
+
+    if (code != was_code) {
+        memory_region_rom_device_set_romd(&s->cflash_mr, !code);
+    }
+    if (data != was_data) {
+        memory_region_rom_device_set_romd(&s->dflash_mr, !data);
+    }
+    if (!code && !data) {
+        /* Leaving P/E mode resets the command sequencer. */
+        s->cmd_state = RX_FCU_ST_READY;
+    }
+}
+
+static uint64_t fcu_regs_read(void *opaque, hwaddr offset, unsigned size)
+{
+    RenesasRxFcuState *s = opaque;
+    uint64_t val;
+
+    switch (offset) {
+    case R_FASTAT:
+        val = s->fastat;
+        break;
+    case R_FAEINT:
+        val = s->faeint;
+        break;
+    case R_FRDYIE:
+        val = s->frdyie;
+        break;
+    case R_FSADDR:
+        val = s->fsaddr;
+        break;
+    case R_FEADDR:
+        val = s->feaddr;
+        break;
+    case R_FSTATR:
+        val = s->fstatr;
+        break;
+    case R_FENTRYR:
+        val = s->fentryr;
+        break;
+    case R_FPROTR:
+        val = s->fprotr;
+        break;
+    case R_FSUACR:
+        val = s->fsuacr;
+        break;
+    case R_FCMDR:
+        val = s->fcmdr;
+        break;
+    case R_FPESTAT:
+        val = s->fpestat;
+        break;
+    case R_FBCCNT:
+        val = s->fbccnt;
+        break;
+    case R_FBCSTAT:
+        val = s->fbcstat;
+        break;
+    case R_FPSADDR:
+        val = s->fpsaddr;
+        break;
+    case R_FCPSR:
+        val = s->fcpsr;
+        break;
+    case R_FPCKAR:
+        val = s->fpckar;
+        break;
+    default:
+        qemu_log_mask(LOG_UNIMP,
+                      "renesas-rx-fcu: read from unimplemented reg 0x%"
+                      HWADDR_PRIx "\n", offset);
+        return 0;
+    }
+
+    if (size < 4) {
+        val &= (1ull << (8 * size)) - 1;
+    }
+    return val;
+}
+
+static void fcu_regs_write(void *opaque, hwaddr offset, uint64_t value,
+                           unsigned size)
+{
+    RenesasRxFcuState *s = opaque;
+
+    switch (offset) {
+    case R_FASTAT:
+        s->fastat = value;
+        break;
+    case R_FAEINT:
+        s->faeint = value;
+        break;
+    case R_FRDYIE:
+        s->frdyie = value;
+        break;
+    case R_FSADDR:
+        s->fsaddr = value;
+        break;
+    case R_FEADDR:
+        s->feaddr = value;
+        break;
+    case R_FENTRYR:
+        fcu_set_fentryr(s, value);
+        break;
+    case R_FPROTR:
+        s->fprotr = value;
+        break;
+    case R_FSUACR:
+        s->fsuacr = value;
+        break;
+    case R_FBCCNT:
+        s->fbccnt = value;
+        break;
+    case R_FCPSR:
+        s->fcpsr = value;
+        break;
+    case R_FPCKAR:
+        s->fpckar = value;
+        break;
+    case R_FSTATR:
+    case R_FBCSTAT:
+    case R_FCMDR:
+    case R_FPESTAT:
+    case R_FPSADDR:
+        /* Read-only status registers; ignore writes. */
+        break;
+    default:
+        qemu_log_mask(LOG_UNIMP,
+                      "renesas-rx-fcu: write to unimplemented reg 0x%"
+                      HWADDR_PRIx " = 0x%" PRIx64 "\n", offset, value);
+        break;
+    }
+}
+
+static const MemoryRegionOps fcu_regs_ops = {
+    .read = fcu_regs_read,
+    .write = fcu_regs_write,
+    .endianness = DEVICE_LITTLE_ENDIAN,
+    .impl = {
+        .min_access_size = 1,
+        .max_access_size = 4,
+    },
+    .valid = {
+        .min_access_size = 1,
+        .max_access_size = 4,
+    },
+};
+
+/*
+ * Latch the code flash bank layout from the option-setting memory. The
+ * hardware samples MDE.BANKMD and BANKSEL.BANKSWP at reset, so a mode or
+ * bank switch only takes effect on the next reset, which is what makes the
+ * "program the other bank then reboot into it" update flow work.
+ *
+ * BANKSWP = 111b maps bank 0, the one holding the vectors, into the upper
+ * half, which is the layout a linearly programmed image already has, so it
+ * needs no aliasing. 000b swaps the halves.
+ */
+void rx_fcu_update_bank_map(RenesasRxFcuState *s)
+{
+    uint32_t mde, banksel;
+    bool dual, swapped;
+
+    mde = ldl_le_p(s->ofsm_ptr + RX_OFSM_MDE);
+    banksel = ldl_le_p(s->ofsm_ptr + RX_OFSM_BANKSEL);
+
+    dual = (mde & RX_BANKMD_MASK) == RX_BANKMD_DUAL;
+    swapped = (banksel & RX_BANKSWP_MASK) == RX_BANKSWP_SWAPPED;
+
+    /* Dual mode is only available on parts with at least 1.5 MiB of flash. */
+    if (dual && s->cflash_size < CFLASH_MIN_DUAL_SIZE) {
+        qemu_log_mask(LOG_UNIMP,
+                      "renesas-rx-fcu: dual mode requested on a %u KiB code "
+                      "flash is not modelled; staying linear\n",
+                      s->cflash_size / 1024);
+        dual = false;
+    }
+
+    s->dual_mode = dual;
+    s->bank_swapped = dual && swapped;
+
+    memory_region_transaction_begin();
+    memory_region_set_enabled(&s->cflash_linear, !s->dual_mode);
+    memory_region_set_enabled(&s->cflash_bank[0], s->dual_mode);
+    memory_region_set_enabled(&s->cflash_bank[1], s->dual_mode);
+    if (s->dual_mode) {
+        uint32_t bank_size = s->cflash_size / 2;
+
+        memory_region_set_alias_offset(&s->cflash_bank[0],
+                                       s->bank_swapped ? bank_size : 0);
+        memory_region_set_alias_offset(&s->cflash_bank[1],
+                                       s->bank_swapped ? 0 : bank_size);
+    }
+    memory_region_transaction_commit();
+}
+
+static void rx_fcu_reset(DeviceState *dev)
+{
+    RenesasRxFcuState *s = RENESAS_RX_FCU(dev);
+
+    /* The bank layout is sampled from the OFSM at every reset. */
+    rx_fcu_update_bank_map(s);
+
+    /* Exit P/E mode and restore direct (romd) flash reads. */
+    memory_region_rom_device_set_romd(&s->cflash_mr, true);
+    memory_region_rom_device_set_romd(&s->dflash_mr, true);
+
+    s->fentryr = 0;
+    s->fstatr = FSTATR_FRDY;
+    s->fastat = 0;
+    s->frdyie = 0;
+    s->faeint = 0;
+    s->fsaddr = 0;
+    s->feaddr = 0;
+    s->fpsaddr = 0;
+    s->fbcstat = 0;
+    s->fbccnt = 0;
+    s->fcpsr = 0;
+    s->fpckar = 0;
+    s->fprotr = 0;
+    s->fsuacr = 0;
+    s->fpestat = 0;
+    s->fcmdr = 0;
+    s->cmd_state = RX_FCU_ST_READY;
+    s->prog_off = 0;
+    s->prog_words = 0;
+
+    qemu_set_irq(s->frdyi, 0);
+    qemu_set_irq(s->fiferr, 0);
+}
+
+/*
+ * Attach one array to its block backend: take the write permission if the
+ * image allows it, then load the image over the erased contents. A backend
+ * whose size does not match the array is rejected rather than silently
+ * truncated.
+ */
+static bool fcu_attach_blk(RenesasRxFcuState *s, DeviceState *dev,
+                           RxFcuTarget t, Error **errp)
+{
+    BlockBackend *blk = t == RX_FCU_CFLASH ? s->cflash_blk : s->dflash_blk;
+    MemoryRegion *mr = t == RX_FCU_CFLASH ? &s->cflash_mr : &s->dflash_mr;
+    uint32_t size = target_size(s, t);
+    uint64_t perm;
+    bool ro;
+
+    if (!blk) {
+        return true;
+    }
+
+    ro = !blk_supports_write_perm(blk);
+    if (t == RX_FCU_CFLASH) {
+        s->cflash_ro = ro;
+    } else {
+        s->dflash_ro = ro;
+    }
+
+    perm = BLK_PERM_CONSISTENT_READ | (ro ? 0 : BLK_PERM_WRITE);
+    if (blk_set_perm(blk, perm, BLK_PERM_ALL, errp) < 0) {
+        return false;
+    }
+
+    /* The block helper skips zero extents, so its destination must be zero. */
+    memset(target_storage(s, t), 0, size);
+    if (!blk_check_size_and_read_all(blk, dev, target_storage(s, t),
+                                     size, errp)) {
+        vmstate_unregister_ram(mr, dev);
+        return false;
+    }
+    return true;
+}
+
+static void rx_fcu_realize(DeviceState *dev, Error **errp)
+{
+    RenesasRxFcuState *s = RENESAS_RX_FCU(dev);
+    SysBusDevice *sbd = SYS_BUS_DEVICE(dev);
+
+    if (s->cflash_size == 0 || s->dflash_size == 0) {
+        error_setg(errp, "code-flash-size and data-flash-size must be set");
+        return;
+    }
+    if (s->dual_bank_gap_size > s->cflash_base) {
+        error_setg(errp, "dual-bank-gap-size exceeds code-flash-base");
+        return;
+    }
+
+    s->cflash_ctx.fcu = s;
+    s->cflash_ctx.target = RX_FCU_CFLASH;
+    s->dflash_ctx.fcu = s;
+    s->dflash_ctx.target = RX_FCU_DFLASH;
+
+    memory_region_init_io(&s->regs_mr, OBJECT(s), &fcu_regs_ops, s,
+                          "renesas-rx-fcu.regs", RX_FCU_REGS_SIZE);
+    memory_region_init_io(&s->faci_mr, OBJECT(s), &faci_issue_ops, s,
+                          "renesas-rx-fcu.faci", RX_FCU_FACI_ISSUE_SIZE);
+
+    if (!memory_region_init_rom_device(&s->cflash_mr, OBJECT(s),
+                                       &faci_flash_ops, &s->cflash_ctx,
+                                       "renesas-rx-fcu.cflash",
+                                       s->cflash_size, errp)) {
+        return;
+    }
+    if (!memory_region_init_rom_device(&s->dflash_mr, OBJECT(s),
+                                       &faci_flash_ops, &s->dflash_ctx,
+                                       "renesas-rx-fcu.dflash",
+                                       s->dflash_size, errp)) {
+        return;
+    }
+    /*
+     * The option-setting memory is read-only to ordinary accesses. It is
+     * changed through the FACI configuration-set command, so a plain ROM is
+     * the right shape for the CPU-visible mapping.
+     */
+    if (!memory_region_init_rom(&s->ofsm_mr, OBJECT(s),
+                                "renesas-rx-fcu.ofsm",
+                                RX_FCU_OFSM_SIZE, errp)) {
+        return;
+    }
+
+    /*
+     * The code flash reaches the bus through a container holding either one
+     * alias over the whole array (linear mode) or one per bank (dual mode).
+     */
+    memory_region_init(&s->cflash_container, OBJECT(s),
+                       "renesas-rx-fcu.cflash-map",
+                       s->cflash_size + s->dual_bank_gap_size);
+    memory_region_init_alias(&s->cflash_linear, OBJECT(s),
+                             "renesas-rx-fcu.cflash-linear",
+                             &s->cflash_mr, 0, s->cflash_size);
+    memory_region_add_subregion(&s->cflash_container,
+                                s->dual_bank_gap_size, &s->cflash_linear);
+
+    for (int i = 0; i < 2; i++) {
+        g_autofree char *name =
+            g_strdup_printf("renesas-rx-fcu.cflash-bank%d", i);
+        memory_region_init_alias(&s->cflash_bank[i], OBJECT(s), name,
+                                 &s->cflash_mr, 0, s->cflash_size / 2);
+        memory_region_add_subregion(&s->cflash_container,
+                                    (hwaddr)i * (s->cflash_size / 2 +
+                                                s->dual_bank_gap_size),
+                                    &s->cflash_bank[i]);
+        memory_region_set_enabled(&s->cflash_bank[i], false);
+    }
+
+    s->cflash_ptr = memory_region_get_ram_ptr(&s->cflash_mr);
+    s->dflash_ptr = memory_region_get_ram_ptr(&s->dflash_mr);
+    s->ofsm_ptr = memory_region_get_ram_ptr(&s->ofsm_mr);
+
+    /*
+     * Erased flash reads as all ones, but the backing memory starts zeroed.
+     * Fill both arrays here rather than at reset: realize runs before the
+     * ROM loader writes the firmware image into the code flash, and flash
+     * is non-volatile, so anything the guest programmed must survive a
+     * later system reset.
+     */
+    memset(s->cflash_ptr, 0xff, s->cflash_size);
+    memset(s->dflash_ptr, 0xff, s->dflash_size);
+    memset(s->ofsm_ptr, 0xff, RX_FCU_OFSM_SIZE);
+
+    if (!fcu_attach_blk(s, dev, RX_FCU_CFLASH, errp) ||
+        !fcu_attach_blk(s, dev, RX_FCU_DFLASH, errp)) {
+        return;
+    }
+    if (s->ofsm_blk) {
+        uint64_t perm;
+        int64_t len;
+
+        s->ofsm_ro = !blk_supports_write_perm(s->ofsm_blk);
+        perm = BLK_PERM_CONSISTENT_READ | (s->ofsm_ro ? 0 : BLK_PERM_WRITE);
+        if (blk_set_perm(s->ofsm_blk, perm, BLK_PERM_ALL, errp) < 0) {
+            return;
+        }
+        /*
+         * The OFSM is smaller than a block sector, so an exact size match is
+         * not something an image file can offer. Require enough bytes and
+         * read only the ones the region holds.
+         */
+        len = blk_getlength(s->ofsm_blk);
+        if (len < RX_FCU_OFSM_SIZE) {
+            error_setg(errp, "ofsm-drive is %" PRId64
+                       " bytes, need at least %d",
+                       len, RX_FCU_OFSM_SIZE);
+            return;
+        }
+        if (blk_pread(s->ofsm_blk, 0, RX_FCU_OFSM_SIZE, s->ofsm_ptr, 0) < 0) {
+            error_setg(errp, "could not read ofsm-drive");
+            return;
+        }
+    }
+
+    sysbus_init_mmio(sbd, &s->regs_mr);
+    sysbus_init_mmio(sbd, &s->cflash_container);
+    sysbus_init_mmio(sbd, &s->dflash_mr);
+    sysbus_init_mmio(sbd, &s->ofsm_mr);
+    sysbus_init_mmio(sbd, &s->faci_mr);
+    sysbus_init_irq(sbd, &s->frdyi);
+    sysbus_init_irq(sbd, &s->fiferr);
+}
+
+static const Property rx_fcu_properties[] = {
+    DEFINE_PROP_DRIVE("code-flash-drive", RenesasRxFcuState, cflash_blk),
+    DEFINE_PROP_DRIVE("data-flash-drive", RenesasRxFcuState, dflash_blk),
+    DEFINE_PROP_DRIVE("ofsm-drive", RenesasRxFcuState, ofsm_blk),
+    DEFINE_PROP_UINT32("code-flash-size", RenesasRxFcuState, cflash_size, 0),
+    DEFINE_PROP_UINT32("data-flash-size", RenesasRxFcuState, dflash_size, 0),
+    DEFINE_PROP_UINT32("code-flash-base", RenesasRxFcuState, cflash_base, 0),
+    DEFINE_PROP_UINT32("data-flash-base", RenesasRxFcuState, dflash_base, 0),
+    DEFINE_PROP_UINT32("dual-bank-gap-size", RenesasRxFcuState,
+                       dual_bank_gap_size, 0),
+};
+
+static const VMStateDescription vmstate_rx_fcu = {
+    .name = "renesas-rx-fcu",
+    .version_id = 1,
+    .minimum_version_id = 1,
+    .fields = (const VMStateField[]) {
+        VMSTATE_UINT16(fentryr, RenesasRxFcuState),
+        VMSTATE_UINT32(fstatr, RenesasRxFcuState),
+        VMSTATE_UINT8(fastat, RenesasRxFcuState),
+        VMSTATE_UINT8(frdyie, RenesasRxFcuState),
+        VMSTATE_UINT8(faeint, RenesasRxFcuState),
+        VMSTATE_UINT32(fsaddr, RenesasRxFcuState),
+        VMSTATE_UINT32(fpsaddr, RenesasRxFcuState),
+        VMSTATE_UINT32(feaddr, RenesasRxFcuState),
+        VMSTATE_UINT8(fbcstat, RenesasRxFcuState),
+        VMSTATE_UINT16(fbccnt, RenesasRxFcuState),
+        VMSTATE_UINT16(fcpsr, RenesasRxFcuState),
+        VMSTATE_UINT16(fpckar, RenesasRxFcuState),
+        VMSTATE_UINT16(fprotr, RenesasRxFcuState),
+        VMSTATE_UINT16(fsuacr, RenesasRxFcuState),
+        VMSTATE_UINT16(fpestat, RenesasRxFcuState),
+        VMSTATE_UINT16(fcmdr, RenesasRxFcuState),
+        VMSTATE_INT32(cmd_state, RenesasRxFcuState),
+        VMSTATE_INT32(cmd_target, RenesasRxFcuState),
+        VMSTATE_UINT32(prog_off, RenesasRxFcuState),
+        VMSTATE_UINT32(prog_words, RenesasRxFcuState),
+        VMSTATE_END_OF_LIST()
+    }
+};
+
+static void rx_fcu_class_init(ObjectClass *klass, const void *data)
+{
+    DeviceClass *dc = DEVICE_CLASS(klass);
+
+    dc->realize = rx_fcu_realize;
+    dc->vmsd = &vmstate_rx_fcu;
+    device_class_set_props(dc, rx_fcu_properties);
+    device_class_set_legacy_reset(dc, rx_fcu_reset);
+}
+
+static const TypeInfo rx_fcu_info = {
+    .name = TYPE_RENESAS_RX_FCU,
+    .parent = TYPE_SYS_BUS_DEVICE,
+    .instance_size = sizeof(RenesasRxFcuState),
+    .class_init = rx_fcu_class_init,
+};
+
+static void rx_fcu_register_types(void)
+{
+    type_register_static(&rx_fcu_info);
+}
+
+type_init(rx_fcu_register_types)
diff --git a/hw/misc/renesas_rx_romcache.c b/hw/misc/renesas_rx_romcache.c
new file mode 100644
index 0000000000..22797d569d
--- /dev/null
+++ b/hw/misc/renesas_rx_romcache.c
@@ -0,0 +1,139 @@
+/*
+ * Renesas RX ROM cache control registers
+ *
+ * Datasheet: RX65N Group, RX651 Group User's Manual: Hardware
+ *            (Rev.2.40 R01UH0590EJ0240)
+ *
+ * Copyright (c) 2026 Umar, Sayyad Mahammad
+ *
+ * SPDX-License-Identifier: GPL-2.0-or-later
+ *
+ * The ROM cache speeds up code flash reads and is architecturally invisible
+ * apart from these two registers. QEMU has no such cache, so there is nothing
+ * to model beyond them -- but they do have to exist, because start-up code
+ * routinely enables the cache and then spins until the enable reads back:
+ *
+ *     FLASH.ROMCE.WORD = 0x0001;
+ *     while (FLASH.ROMCE.WORD != 0x0001) {
+ *     }
+ *
+ * With no device here that loop never terminates, and the machine hangs
+ * before anything else in the firmware runs.
+ *
+ * ROMCE holds the enable bit and reads back what was written. ROMCIV starts
+ * an invalidation, which completes instantly here, so the bit reads back as
+ * zero the way it does on hardware once invalidation has finished.
+ */
+
+#include "qemu/osdep.h"
+#include "qemu/log.h"
+#include "hw/misc/renesas_rx_romcache.h"
+#include "migration/vmstate.h"
+
+#define R_ROMCE     0x00    /* 16-bit ROM cache enable     */
+#define R_ROMCIV    0x04    /* 16-bit ROM cache invalidate */
+#define R_ROMWT     0x1c    /* 8-bit ROM wait-cycle setting */
+
+#define ROMCE_ROMCEN    0x0001
+
+static uint64_t romcache_read(void *opaque, hwaddr offset, unsigned size)
+{
+    RenesasRxRomCacheState *s = opaque;
+
+    switch (offset) {
+    case R_ROMCE:
+        return s->romce;
+    case R_ROMCIV:
+        /* Invalidation is instantaneous, so it always reads as complete. */
+        return 0;
+    case R_ROMWT:
+        return s->romwt;
+    default:
+        qemu_log_mask(LOG_GUEST_ERROR,
+                      "renesas-rx-romcache: read from unmapped offset 0x%"
+                      HWADDR_PRIx "\n", offset);
+        return 0;
+    }
+}
+
+static void romcache_write(void *opaque, hwaddr offset, uint64_t value,
+                           unsigned size)
+{
+    RenesasRxRomCacheState *s = opaque;
+
+    switch (offset) {
+    case R_ROMCE:
+        s->romce = value & ROMCE_ROMCEN;
+        break;
+    case R_ROMCIV:
+        /* Nothing to invalidate; the write is accepted and completes. */
+        break;
+    case R_ROMWT:
+        s->romwt = value & 0x3;
+        break;
+    default:
+        qemu_log_mask(LOG_GUEST_ERROR,
+                      "renesas-rx-romcache: write to unmapped offset 0x%"
+                      HWADDR_PRIx "\n", offset);
+        break;
+    }
+}
+
+static const MemoryRegionOps romcache_ops = {
+    .read = romcache_read,
+    .write = romcache_write,
+    .endianness = DEVICE_LITTLE_ENDIAN,
+    .impl = { .min_access_size = 1, .max_access_size = 4 },
+    .valid = { .min_access_size = 1, .max_access_size = 4 },
+};
+
+static void romcache_reset(DeviceState *dev)
+{
+    RenesasRxRomCacheState *s = RENESAS_RX_ROMCACHE(dev);
+
+    s->romce = 0;
+    s->romwt = 0;
+}
+
+static void romcache_init(Object *obj)
+{
+    RenesasRxRomCacheState *s = RENESAS_RX_ROMCACHE(obj);
+
+    memory_region_init_io(&s->memory, obj, &romcache_ops, s,
+                          "renesas-rx-romcache", RX_ROMCACHE_SIZE);
+    sysbus_init_mmio(SYS_BUS_DEVICE(obj), &s->memory);
+}
+
+static const VMStateDescription vmstate_romcache = {
+    .name = "renesas-rx-romcache",
+    .version_id = 1,
+    .minimum_version_id = 1,
+    .fields = (const VMStateField[]) {
+        VMSTATE_UINT16(romce, RenesasRxRomCacheState),
+        VMSTATE_UINT8(romwt, RenesasRxRomCacheState),
+        VMSTATE_END_OF_LIST()
+    }
+};
+
+static void romcache_class_init(ObjectClass *klass, const void *data)
+{
+    DeviceClass *dc = DEVICE_CLASS(klass);
+
+    dc->vmsd = &vmstate_romcache;
+    device_class_set_legacy_reset(dc, romcache_reset);
+}
+
+static const TypeInfo romcache_info = {
+    .name          = TYPE_RENESAS_RX_ROMCACHE,
+    .parent        = TYPE_SYS_BUS_DEVICE,
+    .instance_size = sizeof(RenesasRxRomCacheState),
+    .instance_init = romcache_init,
+    .class_init    = romcache_class_init,
+};
+
+static void romcache_register_types(void)
+{
+    type_register_static(&romcache_info);
+}
+
+type_init(romcache_register_types)
diff --git a/hw/misc/rx65n_sysclk.c b/hw/misc/rx65n_sysclk.c
new file mode 100644
index 0000000000..8f21ddd860
--- /dev/null
+++ b/hw/misc/rx65n_sysclk.c
@@ -0,0 +1,190 @@
+/*
+ * RX65N Clock Generation Circuit (SYSTEM)
+ *
+ * Datasheet: RX65N Group, RX651 Group User's Manual: Hardware
+ *            (Rev.1.00 R01UH0590EJ0100), section 9
+ *
+ * Copyright (c) 2026 Umar, Sayyad Mahammad
+ *
+ * SPDX-License-Identifier: GPL-2.0-or-later
+ *
+ *
+ * The RX65N clock generation circuit configures the oscillators, PLL and
+ * clock dividers. QEMU does not model real clock timing, so most registers
+ * behave as plain read/write storage. The crucial exception is the
+ * Oscillation Stabilization Flag Register (OSCOVFSR): startup code busy-waits
+ * on it until every selected clock source reports "stable", so it is forced
+ * to report all sources stabilized.
+ */
+
+#include "qemu/osdep.h"
+#include "qemu/log.h"
+#include "hw/misc/rx65n_sysclk.h"
+#include "migration/vmstate.h"
+
+/* Register offsets from the SYSTEM base (0x00080000). */
+#define R_PLLCR2    0x2A    /* PLL control register 2                (8-bit)  */
+#define R_MOSCCR    0x32    /* Main clock oscillator control reg     (8-bit)  */
+#define R_SOSCCR    0x33    /* Sub-clock oscillator control reg      (8-bit)  */
+#define R_HOCOCR    0x36    /* High-speed on-chip osc control reg    (8-bit)  */
+#define R_OSCOVFSR  0x3C    /* Oscillation stabilization flag reg    (8-bit)  */
+
+/* OSCOVFSR flag bits. */
+#define OSCOVFSR_MOOVF  (1 << 0)    /* Main clock oscillator           */
+#define OSCOVFSR_SOOVF  (1 << 1)    /* Sub-clock oscillator            */
+#define OSCOVFSR_PLOVF  (1 << 2)    /* PLL                             */
+#define OSCOVFSR_HCOVF  (1 << 3)    /* High-speed on-chip oscillator   */
+#define OSCOVFSR_ILCOVF (1 << 4)    /* IWDT low-speed on-chip osc      */
+#define OSCOVFSR_PPLOVF (1 << 5)    /* PLL2 (RX72M, high-speed periph) */
+
+/*
+ * Compute the Oscillation Stabilization Flag Register from the oscillator
+ * control registers. Each flag reads 1 once its oscillator is enabled (its
+ * stop bit is clear) and 0 while it is stopped. QEMU has no real oscillator
+ * timing, so stabilization is reported as immediate. PLLCR2.PLLEN uses the
+ * same "0 = operating" polarity as the stop bits.
+ */
+static uint8_t oscovfsr_value(RX65NSysClkState *s)
+{
+    uint8_t v = 0;
+
+    if (!(s->regs[R_MOSCCR] & 1)) {
+        v |= OSCOVFSR_MOOVF;
+    }
+    if (!(s->regs[R_SOSCCR] & 1)) {
+        v |= OSCOVFSR_SOOVF;
+    }
+    if (!(s->regs[R_PLLCR2] & 1)) {
+        v |= OSCOVFSR_PLOVF;
+    }
+    if (!(s->regs[R_HOCOCR] & 1)) {
+        v |= OSCOVFSR_HCOVF;
+    }
+    /*
+     * The IWDT low-speed on-chip oscillator and (on the RX72M) PLL2 have no
+     * stop bit modelled here; report them stabilized so firmware that selects
+     * them does not busy-wait forever. QEMU has no real oscillator timing.
+     */
+    v |= OSCOVFSR_ILCOVF | OSCOVFSR_PPLOVF;
+    return v;
+}
+
+static uint64_t rx65n_sysclk_read(void *opaque, hwaddr offset, unsigned size)
+{
+    RX65NSysClkState *s = opaque;
+    uint64_t val = 0;
+    unsigned i;
+
+    if (offset + size > RX65N_SYSCLK_SIZE) {
+        qemu_log_mask(LOG_GUEST_ERROR,
+                      "rx65n_sysclk: read out of range 0x%" HWADDR_PRIX "\n",
+                      offset);
+        return 0;
+    }
+
+    for (i = 0; i < size; i++) {
+        val |= (uint64_t)s->regs[offset + i] << (8 * i);
+    }
+
+    /* OSCOVFSR is read-only and derived from the oscillator controls. */
+    if (offset <= R_OSCOVFSR && offset + size > R_OSCOVFSR) {
+        unsigned b = R_OSCOVFSR - offset;
+        val &= ~((uint64_t)0xff << (8 * b));
+        val |= (uint64_t)oscovfsr_value(s) << (8 * b);
+    }
+
+    return val;
+}
+
+static void rx65n_sysclk_write(void *opaque, hwaddr offset, uint64_t val,
+                               unsigned size)
+{
+    RX65NSysClkState *s = opaque;
+    unsigned i;
+
+    if (offset + size > RX65N_SYSCLK_SIZE) {
+        qemu_log_mask(LOG_GUEST_ERROR,
+                      "rx65n_sysclk: write out of range 0x%" HWADDR_PRIX "\n",
+                      offset);
+        return;
+    }
+
+    for (i = 0; i < size; i++) {
+        s->regs[offset + i] = (val >> (8 * i)) & 0xff;
+    }
+}
+
+static const MemoryRegionOps rx65n_sysclk_ops = {
+    .read = rx65n_sysclk_read,
+    .write = rx65n_sysclk_write,
+    .endianness = DEVICE_LITTLE_ENDIAN,
+    .impl = {
+        .min_access_size = 1,
+        .max_access_size = 4,
+    },
+    .valid = {
+        .min_access_size = 1,
+        .max_access_size = 4,
+    },
+};
+
+static void rx65n_sysclk_reset(DeviceState *dev)
+{
+    RX65NSysClkState *s = RX65N_SYSCLK(dev);
+
+    memset(s->regs, 0, sizeof(s->regs));
+
+    /*
+     * Reset values for the oscillator controls (HW manual section 9). The
+     * main and sub-clock oscillators and the PLL are stopped out of reset;
+     * the high-speed on-chip oscillator (HOCO) is left running so its
+     * stabilization flag reads ready for firmware that selects it directly.
+     */
+    s->regs[R_MOSCCR] = 0x01;   /* MOSTP = 1: main oscillator stopped */
+    s->regs[R_SOSCCR] = 0x01;   /* SOSTP = 1: sub-clock stopped       */
+    s->regs[R_PLLCR2] = 0x01;   /* PLLEN = 1: PLL stopped             */
+    s->regs[R_HOCOCR] = 0x00;   /* HCSTP = 0: HOCO running            */
+}
+
+static void rx65n_sysclk_init(Object *obj)
+{
+    SysBusDevice *d = SYS_BUS_DEVICE(obj);
+    RX65NSysClkState *s = RX65N_SYSCLK(obj);
+
+    memory_region_init_io(&s->memory, obj, &rx65n_sysclk_ops, s,
+                          "rx65n-sysclk", RX65N_SYSCLK_SIZE);
+    sysbus_init_mmio(d, &s->memory);
+}
+
+static const VMStateDescription vmstate_rx65n_sysclk = {
+    .name = "rx65n-sysclk",
+    .version_id = 1,
+    .minimum_version_id = 1,
+    .fields = (const VMStateField[]) {
+        VMSTATE_UINT8_ARRAY(regs, RX65NSysClkState, RX65N_SYSCLK_SIZE),
+        VMSTATE_END_OF_LIST()
+    }
+};
+
+static void rx65n_sysclk_class_init(ObjectClass *klass, const void *data)
+{
+    DeviceClass *dc = DEVICE_CLASS(klass);
+
+    dc->vmsd = &vmstate_rx65n_sysclk;
+    device_class_set_legacy_reset(dc, rx65n_sysclk_reset);
+}
+
+static const TypeInfo rx65n_sysclk_info = {
+    .name = TYPE_RX65N_SYSCLK,
+    .parent = TYPE_SYS_BUS_DEVICE,
+    .instance_size = sizeof(RX65NSysClkState),
+    .instance_init = rx65n_sysclk_init,
+    .class_init = rx65n_sysclk_class_init,
+};
+
+static void rx65n_sysclk_register_types(void)
+{
+    type_register_static(&rx65n_sysclk_info);
+}
+
+type_init(rx65n_sysclk_register_types)
diff --git a/hw/net/renesas_etherc.c b/hw/net/renesas_etherc.c
new file mode 100644
index 0000000000..2a95469ab2
--- /dev/null
+++ b/hw/net/renesas_etherc.c
@@ -0,0 +1,955 @@
+/*
+ * Renesas RX65N Ethernet Controller (ETHERC) + Ethernet DMA Controller (EDMAC)
+ *
+ * Datasheet: RX65N Group, RX651 Group User's Manual: Hardware
+ *            (Rev.1.00 R01UH0590EJ0100), Sections 32–33
+ *
+ * Copyright (c) 2026 Umar, Sayyad Mahammad
+ *
+ * SPDX-License-Identifier: GPL-2.0-or-later
+ *
+ */
+
+#include "qemu/osdep.h"
+#include "qemu/log.h"
+#include "qemu/module.h"
+#include "hw/core/irq.h"
+#include "hw/net/renesas_etherc.h"
+#include "hw/core/qdev-properties.h"
+#include "hw/core/qdev-properties-system.h"
+#include "migration/vmstate.h"
+#include "net/net.h"
+#include "system/dma.h"
+
+/*
+ * Register offsets within one channel's 0x200-byte MMIO window.
+ * EDMAC occupies offsets 0x000-0x0ff; ETHERC occupies 0x100-0x1ff.
+ * RX65N/RX72M/RX72N channel 0 starts at 0x000c0000. RX72M/RX72N
+ * channel 1 starts at 0x000c0200 and must use a separate device instance.
+ * References: RX65N hardware manual sections 34/35; RX72M/RX72N 36/38.
+ */
+/* ETHERC */
+#define R_ECMR      0x100
+#define R_RFLR      0x108
+#define R_ECSR      0x110
+#define R_ECSIPR    0x118
+#define R_PIR       0x120
+#define R_PSR       0x128
+#define R_RDMLR     0x140
+#define R_IPGR      0x150
+#define R_APR       0x154
+#define R_MPR       0x158
+#define R_RFCF      0x160
+#define R_TPAUSER   0x164
+#define R_TPAUSECR  0x168
+#define R_BCFRR     0x16C
+#define R_MAHR      0x1C0
+#define R_MALR      0x1C8
+#define R_TROCR     0x1D0
+#define R_CDCR      0x1D4
+#define R_LCCR      0x1D8
+#define R_CNDCR     0x1DC
+#define R_CEFCR     0x1E4
+#define R_FRECR     0x1E8
+#define R_TSFRCR    0x1EC
+#define R_TLFRCR    0x1F0
+#define R_RFCR      0x1F4
+#define R_MAFCR     0x1F8
+/* EDMAC */
+#define R_EDMR      0x000
+#define R_EDTRR     0x008
+#define R_EDRRR     0x010
+#define R_TDLAR     0x018
+#define R_RDLAR     0x020
+#define R_EESR      0x028
+#define R_EESIPR    0x030
+#define R_TRSCER    0x038
+#define R_RMFCR     0x040
+#define R_TFTR      0x048
+#define R_FDR       0x050
+#define R_RMCR      0x058
+#define R_TFUCR     0x064
+#define R_RFOCR     0x068
+#define R_IOSR      0x06C
+#define R_FCFTR     0x070
+#define R_RPADIR    0x078
+#define R_TRIMD     0x07C
+#define R_RBWAR     0x0C8
+#define R_RDFAR     0x0CC
+#define R_TBRAR     0x0D4
+#define R_TDFAR     0x0D8
+
+/* ECMR bits */
+#define ECMR_PRM    (1u << 0)   /* promiscuous */
+#define ECMR_DM     (1u << 1)   /* full duplex */
+#define ECMR_TE     (1u << 5)   /* transmit enable */
+#define ECMR_RE     (1u << 6)   /* receive enable */
+
+/* PIR bits */
+#define PIR_MDC     (1u << 0)
+#define PIR_MDO     (1u << 2)
+#define PIR_MMD     (1u << 1)   /* direction: 1=SoC drives MDO */
+#define PIR_MDI     (1u << 3)   /* MDI input (read-only) */
+
+/* EESR / EESIPR bits */
+#define EESR_CERF   (1u << 0)
+#define EESR_RMAF   (1u << 7)
+#define EESR_RFOF   (1u << 21)
+#define EESR_RDE    (1u << 22)
+#define EESR_FR     (1u << 23)
+#define EESR_TFUF   (1u << 25)
+#define EESR_TDE    (1u << 26)
+#define EESR_TC     (1u << 27)
+#define EESR_TWB    (1u << 31)
+
+/* TX descriptor word 0 (TD0) bits */
+#define TD0_TACT    (1u << 31)
+#define TD0_TDLE    (1u << 30)
+#define TD0_TFP1    (1u << 29)
+#define TD0_TFP0    (1u << 28)
+#define TD0_TFE     (1u << 27)
+#define TD0_TWBI    (1u << 26)
+#define TD0_TBL     0x0000FFFFu
+
+/* RX descriptor word 0 (RD0) bits */
+#define RD0_RACT    (1u << 31)
+#define RD0_RDLE    (1u << 30)
+#define RD0_RFP1    (1u << 29)
+#define RD0_RFP0    (1u << 28)
+#define RD0_RBL     0x0000FFFFu
+
+/* Descriptor size (EDMR.DL = 00 → 4 words = 16 bytes) */
+#define DESC_SIZE   16
+
+/*
+ * PHY simulation
+ * Emulates a generic 100BASE-TX PHY at addresses 0 and 1, always link-up.
+ */
+static uint16_t mdio_phy_read(RX65NEthercState *s, int phy, int reg)
+{
+    /* Accept both PHY station addresses used by RX firmware variants. */
+    if (phy != 0 && phy != 1) {
+        return 0xFFFF;
+    }
+    switch (reg) {
+    case 0:
+        /*Basic Control: FD, 100Mbps */
+        return 0x3100;
+    case 1:
+        /*Basic Status: link up, AN complete */
+        return 0x786D;
+    case 2:
+        /*PHY ID 1 */
+        return 0x0022;
+    case 3:
+        /*PHY ID 2 */
+        return 0x1550;
+    case 4:
+        /*ANAR */
+        return 0x05E1;
+    case 5:
+        /*ANLPAR */
+        return 0x45E1;
+    default: return s->mdio.phy_regs[reg < 32 ? reg : 0];
+    }
+}
+
+static void mdio_phy_write(RX65NEthercState *s, int phy, int reg, uint16_t val)
+{
+    if ((phy == 0 || phy == 1) && reg < 32) {
+        s->mdio.phy_regs[reg] = val;
+    }
+}
+
+/*
+ * MDIO bit-bang state machine.
+ *
+ * Invoked on every PIR write that has a MDC rising edge.
+ * Accumulates the MDIO frame header (SOF + OP + PHYADDR + REGADDR = 13
+ * master bits after the preamble-terminating 0), decodes read/write,
+ * and then either: schedules slave-driven MDI bits for reads, or
+ * accumulates the TA + DATA bits for writes.
+ *
+ * MDI is updated in pir immediately so the firmware can read it back.
+ */
+static void mdio_do_rising(RX65NEthercState *s, bool mdo, bool mden)
+{
+    MDIOState *m = &s->mdio;
+
+    /* ---- Slave output phase (read response) ---- */
+    if (m->out_cnt >= 0) {
+        /*
+         * out_cnt 0  → TA[1]: floating pull-up (MDI=1)
+         * out_cnt 1  → TA[0]: slave drives 0    (MDI=0)
+         * out_cnt 2–17 → DATA[15:0] MSB-first
+         */
+        if (m->out_cnt == 0) {
+            m->mdi = true;
+        } else if (m->out_cnt == 1) {
+            m->mdi = false;
+        } else {
+            int bit = 17 - m->out_cnt;           /* 15 down to 0 */
+            m->mdi = (m->read_data >> bit) & 1;
+        }
+        m->out_cnt++;
+        if (m->out_cnt >= 18) {
+            m->out_cnt = -1;
+            m->in_cnt  = -1;
+            m->preamble = 0;
+        }
+        return;
+    }
+
+    if (!mden) {
+        return;    /* master not driving; ignore (should be in output phase) */
+    }
+
+    /* ---- Preamble phase ---- */
+    if (m->in_cnt == -1) {
+        if (mdo) {
+            m->preamble++;
+        } else if (m->preamble >= 32) {
+            /* SOF[0] = 0 detected, start header accumulation */
+            m->in_cnt  = 0;
+            m->sr      = 0;
+            m->write_cnt = -1;
+        } else {
+            m->preamble = 0;
+        }
+        return;
+    }
+
+    /* ---- Header accumulation (13 bits after SOF[0]) ---- */
+    if (m->in_cnt < 13) {
+        m->sr = (m->sr << 1) | (mdo ? 1 : 0);
+        m->in_cnt++;
+
+        if (m->in_cnt == 13) {
+            /*
+             * sr[12] = SOF[1]
+             * sr[11:10] = OP  (10=read, 01=write)
+             * sr[9:5]   = PHYADDR
+             * sr[4:0]   = REGADDR
+             */
+            int sof1  = (m->sr >> 12) & 1;
+            int op    = (m->sr >> 10) & 3;
+            int paddr = (m->sr >> 5) & 0x1F;
+            int raddr = m->sr & 0x1F;
+
+            if (sof1 != 1) {
+                m->in_cnt = -1;
+                m->preamble = 0;
+                return;
+            }
+            if (op == 2) {
+                m->is_read = true;
+                m->read_data = mdio_phy_read(s, paddr, raddr);
+                /* Slave output starts on the next rising edge. */
+                m->out_cnt = 0;
+            } else if (op == 1) {
+                m->is_read = false;
+                m->write_paddr = paddr;
+                m->write_raddr = raddr;
+                m->write_data = 0;
+                m->write_cnt = 0;
+            }
+        }
+        return;
+    }
+
+    /* ---- Write: TA (2) + DATA (16) = 18 master bits ---- */
+    if (!m->is_read && m->write_cnt >= 0 && m->write_cnt < 18) {
+        if (m->write_cnt >= 2) {
+            m->write_data = (m->write_data << 1) | (mdo ? 1 : 0);
+        }
+        m->write_cnt++;
+        if (m->write_cnt == 18) {
+            mdio_phy_write(s, m->write_paddr, m->write_raddr, m->write_data);
+            m->in_cnt   = -1;
+            m->write_cnt = -1;
+            m->preamble = 0;
+        }
+    }
+}
+
+static void etherc_pir_write(RX65NEthercState *s, uint32_t val)
+{
+    bool old_mdc = !!(s->pir & PIR_MDC);
+    bool new_mdc = !!(val & PIR_MDC);
+    bool new_mden = !!(val & PIR_MMD);
+    bool new_mdo  = !!(val & PIR_MDO);
+
+    /* Update writable bits, keep MDI */
+    s->pir = (val & ~PIR_MDI) | (s->pir & PIR_MDI);
+
+    if (!old_mdc && new_mdc) {
+        /* Rising edge: run state machine and update MDI */
+        mdio_do_rising(s, new_mdo, new_mden);
+        s->pir = (s->pir & ~PIR_MDI) | (s->mdio.mdi ? PIR_MDI : 0);
+    }
+}
+
+/*
+ * Interrupt management
+ */
+static void etherc_update_irq(RX65NEthercState *s)
+{
+    qemu_set_irq(s->irq[ETHERC_IRQ_EINT], !!(s->eesr & s->eesipr));
+}
+
+/*
+ * TX path: walk descriptor ring, send frames, update EESR.
+ */
+static void etherc_tx_run(RX65NEthercState *s)
+{
+    bool did_tx = false;
+
+    for (;;) {
+        uint32_t td0, td1;
+        dma_memory_read(&address_space_memory, s->tx_cur,
+                        &td0, 4, MEMTXATTRS_UNSPECIFIED);
+        dma_memory_read(&address_space_memory, s->tx_cur + 4,
+                        &td1, 4, MEMTXATTRS_UNSPECIFIED);
+        td0 = le32_to_cpu(td0);
+        td1 = le32_to_cpu(td1);
+
+        if (!(td0 & TD0_TACT)) {
+            /* CPU owns descriptor: TX descriptor list exhausted */
+            s->eesr |= EESR_TDE;
+            break;
+        }
+
+        uint32_t buf_addr = td1;
+        uint32_t buf_len  = td0 & TD0_TBL;
+
+        if (buf_len > 0 && (s->ecmr & ECMR_TE)) {
+            uint8_t *buf = g_malloc(buf_len);
+            dma_memory_read(&address_space_memory, buf_addr,
+                            buf, buf_len, MEMTXATTRS_UNSPECIFIED);
+            qemu_send_packet(qemu_get_queue(s->nic), buf, buf_len);
+            g_free(buf);
+        }
+
+        /* Return descriptor to CPU: clear TACT, mark SOF+EOF */
+        td0 &= ~TD0_TACT;
+        td0 |= TD0_TFP1 | TD0_TFP0;
+        uint32_t w = cpu_to_le32(td0);
+        dma_memory_write(&address_space_memory, s->tx_cur,
+                         &w, 4, MEMTXATTRS_UNSPECIFIED);
+
+        s->eesr |= EESR_TC;
+        if (td0 & TD0_TWBI) {
+            s->eesr |= EESR_TWB;
+        }
+        did_tx = true;
+
+        if (td0 & TD0_TDLE) {
+            s->tx_cur = s->tdlar;
+        } else {
+            s->tx_cur += DESC_SIZE;
+        }
+    }
+
+    if (did_tx) {
+        s->edtrr &= ~0x1u;
+        etherc_update_irq(s);
+    }
+}
+
+/*
+ * RX path: called by QEMU net layer on packet arrival.
+ */
+static bool etherc_can_receive(NetClientState *nc)
+{
+    RX65NEthercState *s = qemu_get_nic_opaque(nc);
+    return !!(s->edrrr & 0x1) && !!(s->ecmr & ECMR_RE);
+}
+
+static ssize_t etherc_receive(NetClientState *nc, const uint8_t *buf,
+                              size_t len)
+{
+    RX65NEthercState *s = qemu_get_nic_opaque(nc);
+
+    if (!(s->edrrr & 0x1) || !(s->ecmr & ECMR_RE)) {
+        return -1;
+    }
+
+    /* Walk descriptor ring to find an EDMAC-owned (RACT=1) entry */
+    uint32_t start = s->rx_cur;
+    for (;;) {
+        uint32_t rd0, rd1;
+        dma_memory_read(&address_space_memory, s->rx_cur,
+                        &rd0, 4, MEMTXATTRS_UNSPECIFIED);
+        dma_memory_read(&address_space_memory, s->rx_cur + 4,
+                        &rd1, 4, MEMTXATTRS_UNSPECIFIED);
+        rd0 = le32_to_cpu(rd0);
+        rd1 = le32_to_cpu(rd1);
+
+        if (rd0 & RD0_RACT) {
+            break;   /* found a free descriptor */
+        }
+
+        /* Descriptor is CPU-owned: advance */
+        bool last = !!(rd0 & RD0_RDLE);
+        s->rx_cur = last ? s->rdlar : s->rx_cur + DESC_SIZE;
+
+        if (s->rx_cur == start) {
+            /* Wrapped all the way around: no free descriptors */
+            s->eesr  |= EESR_RDE;
+            s->rmfcr += 1;
+            etherc_update_irq(s);
+            return -1;
+        }
+    }
+
+    /* Read the free descriptor */
+    uint32_t rd0, rd1;
+    dma_memory_read(&address_space_memory, s->rx_cur,
+                    &rd0, 4, MEMTXATTRS_UNSPECIFIED);
+    dma_memory_read(&address_space_memory, s->rx_cur + 4,
+                    &rd1, 4, MEMTXATTRS_UNSPECIFIED);
+    rd0 = le32_to_cpu(rd0);
+    rd1 = le32_to_cpu(rd1);
+
+    uint32_t buf_addr = rd1;
+    uint32_t buf_len  = rd0 & RD0_RBL;
+    size_t   copy_len = MIN(len, buf_len);
+
+    dma_memory_write(&address_space_memory, buf_addr,
+                     buf, copy_len, MEMTXATTRS_UNSPECIFIED);
+
+    /* Write back descriptor: clear RACT, mark SOF+EOF, write RFL in RD2 */
+    rd0 &= ~RD0_RACT;
+    rd0 |= RD0_RFP1 | RD0_RFP0;
+
+    uint32_t w0 = cpu_to_le32(rd0);
+    uint32_t w2 = cpu_to_le32((uint32_t)copy_len << 16);
+    dma_memory_write(&address_space_memory, s->rx_cur,
+                     &w0, 4, MEMTXATTRS_UNSPECIFIED);
+    dma_memory_write(&address_space_memory, s->rx_cur + 8,
+                     &w2, 4, MEMTXATTRS_UNSPECIFIED);
+
+    s->eesr |= EESR_FR;
+    if (buf[0] & 0x01) {
+        s->eesr |= EESR_RMAF;
+    }
+
+    if (rd0 & RD0_RDLE) {
+        s->rx_cur = s->rdlar;
+    } else {
+        s->rx_cur += DESC_SIZE;
+    }
+
+    etherc_update_irq(s);
+    return (ssize_t)len;
+}
+
+/*
+ * Filtering: honour promiscuous mode and MAC address.
+ */
+static bool etherc_accept_frame(RX65NEthercState *s, const uint8_t *buf)
+{
+    uint8_t mac[6];
+
+    if (s->ecmr & ECMR_PRM) {
+        return true;
+    }
+    /* Build our 6-byte MAC from MAHR/MALR */
+    mac[0] = (s->mahr >> 24) & 0xFF;
+    mac[1] = (s->mahr >> 16) & 0xFF;
+    mac[2] = (s->mahr >>  8) & 0xFF;
+    mac[3] = s->mahr & 0xFF;
+    mac[4] = (s->malr >> 24) & 0xFF;
+    mac[5] = (s->malr >> 16) & 0xFF;
+
+    if (buf[0] & 0x01) {
+        return true;   /* multicast / broadcast */
+    }
+    return memcmp(buf, mac, 6) == 0;
+}
+
+static ssize_t etherc_receive_filter(NetClientState *nc,
+                                     const uint8_t *buf, size_t len)
+{
+    RX65NEthercState *s = qemu_get_nic_opaque(nc);
+    if (!etherc_accept_frame(s, buf)) {
+        return len;    /* silently discard */
+    }
+    return etherc_receive(nc, buf, len);
+}
+
+/*
+ * EDMAC software reset
+ */
+static void etherc_sw_reset(RX65NEthercState *s)
+{
+    s->eesr   = 0;
+    s->edtrr  = 0;
+    s->edrrr  = 0;
+    s->tx_cur = s->tdlar;
+    s->rx_cur = s->rdlar;
+    etherc_update_irq(s);
+}
+
+/*
+ * MMIO read
+ */
+static uint64_t etherc_read(void *opaque, hwaddr addr, unsigned size)
+{
+    RX65NEthercState *s = opaque;
+
+    switch (addr) {
+    /* ETHERC */
+    case R_ECMR:
+        return s->ecmr;
+    case R_RFLR:
+        return s->rflr;
+    case R_ECSR:
+        return s->ecsr;
+    case R_ECSIPR:
+        return s->ecsipr;
+    case R_PIR:
+        return s->pir;
+    case R_PSR:
+        /*link up */
+        return 0x0001;
+    case R_RDMLR:
+        return s->rdmlr;
+    case R_IPGR:
+        return s->ipgr;
+    case R_APR:
+        return s->apr;
+    case R_MPR:
+        return s->mpr;
+    case R_RFCF:
+        return 0;
+    case R_TPAUSER:
+        return s->tpauser;
+    case R_TPAUSECR:return 0;
+    case R_BCFRR:
+        return s->bcfrr;
+    case R_MAHR:
+        return s->mahr;
+    case R_MALR:
+        return s->malr;
+    case R_TROCR:
+        return s->trocr;
+    case R_CDCR:
+        return s->cdcr;
+    case R_LCCR:
+        return s->lccr;
+    case R_CNDCR:
+        return s->cndcr;
+    case R_CEFCR:
+        return s->cefcr;
+    case R_FRECR:
+        return s->frecr;
+    case R_TSFRCR:
+        return s->tsfrcr;
+    case R_TLFRCR:
+        return s->tlfrcr;
+    case R_RFCR:
+        return s->rfcr;
+    case R_MAFCR:
+        return s->mafcr;
+    /* EDMAC */
+    case R_EDMR:
+        return s->edmr;
+    case R_EDTRR:
+        return s->edtrr;
+    case R_EDRRR:
+        return s->edrrr;
+    case R_TDLAR:
+        return s->tdlar;
+    case R_RDLAR:
+        return s->rdlar;
+    case R_EESR:
+        return s->eesr;
+    case R_EESIPR:
+        return s->eesipr;
+    case R_TRSCER:
+        return s->trscer;
+    case R_RMFCR:
+        return s->rmfcr;
+    case R_TFTR:
+        return s->tftr;
+    case R_FDR:
+        return s->fdr;
+    case R_RMCR:
+        return s->rmcr;
+    case R_TFUCR:
+        return s->tfucr;
+    case R_RFOCR:
+        return s->rfocr;
+    case R_FCFTR:
+        return s->fcftr;
+    case R_RPADIR:
+        return s->rpadir;
+    case R_TRIMD:
+        return s->trimd;
+    case R_RBWAR:
+        return s->rx_cur;
+    case R_RDFAR:
+        return s->rx_cur;
+    case R_TBRAR:
+        return s->tx_cur;
+    case R_TDFAR:
+        return s->tx_cur;
+    default:
+        qemu_log_mask(LOG_UNIMP,
+                      "renesas_etherc: read 0x%" HWADDR_PRIX " unimplemented\n",
+                      addr);
+        return UINT64_MAX;
+    }
+}
+
+/*
+ * MMIO write
+ */
+static void etherc_write(void *opaque, hwaddr addr, uint64_t val, unsigned size)
+{
+    RX65NEthercState *s = opaque;
+
+    switch (addr) {
+    /* ETHERC */
+    case R_ECMR:
+        s->ecmr   = val;
+        break;
+    case R_RFLR:
+        s->rflr   = val;
+        break;
+    case R_ECSR:
+        /*W0C */
+        s->ecsr  &= ~val;
+        break;
+    case R_ECSIPR:
+        s->ecsipr = val;
+        break;
+    case R_PIR:
+        etherc_pir_write(s, val);
+        break;
+    case R_RDMLR:
+        s->rdmlr  = val;
+        break;
+    case R_IPGR:
+        s->ipgr   = val;
+        break;
+    case R_APR:
+        s->apr    = val;
+        break;
+    case R_MPR:
+        s->mpr    = val;
+        break;
+    case R_TPAUSER:
+        s->tpauser = val;
+        break;
+    case R_BCFRR:
+        s->bcfrr  = val;
+        break;
+    case R_MAHR:
+        s->mahr   = val;
+        break;
+    case R_MALR:
+        s->malr   = val;
+        break;
+    case R_TROCR:
+        /*write clears counter */
+        s->trocr  = 0;
+        break;
+    case R_CDCR:
+        s->cdcr   = 0;
+        break;
+    case R_LCCR:
+        s->lccr   = 0;
+        break;
+    case R_CNDCR:
+        s->cndcr  = 0;
+        break;
+    case R_CEFCR:
+        s->cefcr  = 0;
+        break;
+    case R_FRECR:
+        s->frecr  = 0;
+        break;
+    case R_TSFRCR:
+        s->tsfrcr = 0;
+        break;
+    case R_TLFRCR:
+        s->tlfrcr = 0;
+        break;
+    case R_RFCR:
+        s->rfcr   = 0;
+        break;
+    case R_MAFCR:
+        s->mafcr  = 0;
+        break;
+
+    /* EDMAC */
+    case R_EDMR:
+        s->edmr = val;
+        if (val & 0x1) {   /* SWR: software reset */
+            etherc_sw_reset(s);
+            s->edmr &= ~0x1u;
+        }
+        break;
+    case R_EDTRR:
+        s->edtrr = val;
+        if (val & 0x1) {
+            s->tx_cur = s->tdlar;
+            etherc_tx_run(s);
+        }
+        break;
+    case R_EDRRR:
+        s->edrrr = val;
+        if (val & 0x1) {
+            s->rx_cur = s->rdlar;
+            qemu_flush_queued_packets(qemu_get_queue(s->nic));
+        }
+        break;
+    case R_TDLAR:
+        s->tdlar  = val;
+        s->tx_cur = val;
+        break;
+    case R_RDLAR:
+        s->rdlar  = val;
+        s->rx_cur = val;
+        break;
+    case R_EESR:
+        /*W0C */
+        s->eesr  &= ~val;
+        etherc_update_irq(s);
+        break;
+    case R_EESIPR:
+        s->eesipr = val;
+        etherc_update_irq(s);
+        break;
+    case R_TRSCER:
+        s->trscer = val;
+        break;
+    case R_RMFCR:
+        s->rmfcr  = 0;
+        break;
+    case R_TFTR:
+        s->tftr   = val;
+        break;
+    case R_FDR:
+        s->fdr    = val;
+        break;
+    case R_RMCR:
+        s->rmcr   = val;
+        break;
+    case R_TFUCR:
+        s->tfucr  = 0;
+        break;
+    case R_RFOCR:
+        s->rfocr  = 0;
+        break;
+    case R_FCFTR:
+        s->fcftr  = val;
+        break;
+    case R_RPADIR:
+        s->rpadir = val;
+        break;
+    case R_TRIMD:
+        s->trimd  = val;
+        break;
+    default:
+        qemu_log_mask(LOG_UNIMP, "renesas_etherc: write 0x%" HWADDR_PRIX
+                      " unimplemented\n",
+                      addr);
+        break;
+    }
+}
+
+static const MemoryRegionOps etherc_ops = {
+    .read  = etherc_read,
+    .write = etherc_write,
+    .endianness = DEVICE_LITTLE_ENDIAN,
+    .impl  = { .min_access_size = 4, .max_access_size = 4 },
+    .valid = { .min_access_size = 4, .max_access_size = 4 },
+};
+
+/*
+ * NIC callbacks
+ */
+static NetClientInfo etherc_net_info = {
+    .type         = NET_CLIENT_DRIVER_NIC,
+    .size         = sizeof(NICState),
+    .can_receive  = etherc_can_receive,
+    .receive      = etherc_receive_filter,
+};
+
+/*
+ * Device lifecycle
+ */
+static void etherc_reset(DeviceState *dev)
+{
+    RX65NEthercState *s = RENESAS_ETHERC(dev);
+
+    s->ecmr    = 0;
+    s->rflr    = 0x05EE;   /* 1518 bytes max frame length (reset value) */
+    s->ecsr    = 0;
+    s->ecsipr  = 0;
+    s->pir     = 0;
+    s->rdmlr   = 0;
+    s->ipgr    = 0x0014;
+    s->apr     = 0x0000FFFF;
+    s->mpr     = 0;
+    s->tpauser = 0;
+    s->bcfrr   = 0;
+    s->mahr    = 0;
+    s->malr    = 0;
+    s->trocr   = 0; s->cdcr  = 0; s->lccr  = 0; s->cndcr = 0;
+    s->cefcr   = 0; s->frecr = 0; s->tsfrcr = 0; s->tlfrcr = 0;
+    s->rfcr    = 0; s->mafcr = 0;
+
+    s->edmr    = 0;
+    s->edtrr   = 0;
+    s->edrrr   = 0;
+    s->tdlar   = 0;
+    s->rdlar   = 0;
+    s->eesr    = 0;
+    s->eesipr  = 0;
+    s->trscer  = 0;
+    s->rmfcr   = 0;
+    s->tftr    = 0;
+    s->fdr     = 0x0707;
+    s->rmcr    = 0;
+    s->tfucr   = 0; s->rfocr = 0;
+    s->fcftr   = 0;
+    s->rpadir  = 0;
+    s->trimd   = 0;
+
+    s->tx_cur  = 0;
+    s->rx_cur  = 0;
+
+    memset(&s->mdio, 0, sizeof(s->mdio));
+    s->mdio.in_cnt  = -1;
+    s->mdio.out_cnt = -1;
+    s->mdio.write_cnt = -1;
+
+    etherc_update_irq(s);
+}
+
+static void etherc_init(Object *obj)
+{
+    SysBusDevice *d = SYS_BUS_DEVICE(obj);
+    RX65NEthercState *s = RENESAS_ETHERC(obj);
+
+    memory_region_init_io(&s->memory, obj, &etherc_ops, s,
+                          "renesas-etherc", ETHERC_MMIO_SIZE);
+    sysbus_init_mmio(d, &s->memory);
+
+    sysbus_init_irq(d, &s->irq[ETHERC_IRQ_EINT]);
+}
+
+static void etherc_realize(DeviceState *dev, Error **errp)
+{
+    RX65NEthercState *s = RENESAS_ETHERC(dev);
+
+    qemu_macaddr_default_if_unset(&s->conf.macaddr);
+    s->nic = qemu_new_nic(&etherc_net_info, &s->conf,
+                          object_get_typename(OBJECT(dev)),
+                          dev->id, &dev->mem_reentrancy_guard, s);
+    qemu_format_nic_info_str(qemu_get_queue(s->nic), s->conf.macaddr.a);
+
+    /* Pre-load MAC address registers from NICConf */
+    const uint8_t *m = s->conf.macaddr.a;
+    s->mahr = ((uint32_t)m[0] << 24) | ((uint32_t)m[1] << 16) |
+              ((uint32_t)m[2] <<  8) | m[3];
+    s->malr = ((uint32_t)m[4] << 24) | ((uint32_t)m[5] << 16);
+}
+
+/*
+ * VMState
+ */
+static const VMStateDescription vmstate_mdio = {
+    .name = "renesas-etherc-mdio",
+    .version_id = 1,
+    .minimum_version_id = 1,
+    .fields = (const VMStateField[]) {
+        VMSTATE_INT32(preamble,    MDIOState),
+        VMSTATE_INT32(in_cnt,      MDIOState),
+        VMSTATE_UINT32(sr,         MDIOState),
+        VMSTATE_BOOL(is_read,      MDIOState),
+        VMSTATE_INT32(write_cnt,   MDIOState),
+        VMSTATE_INT32(write_paddr, MDIOState),
+        VMSTATE_INT32(write_raddr, MDIOState),
+        VMSTATE_UINT16(write_data, MDIOState),
+        VMSTATE_UINT16(read_data,  MDIOState),
+        VMSTATE_INT32(out_cnt,     MDIOState),
+        VMSTATE_BOOL(mdi,          MDIOState),
+        VMSTATE_UINT16_ARRAY(phy_regs, MDIOState, 32),
+        VMSTATE_END_OF_LIST()
+    }
+};
+
+static const VMStateDescription vmstate_etherc = {
+    .name = "renesas-etherc",
+    .version_id = 1,
+    .minimum_version_id = 1,
+    .fields = (const VMStateField[]) {
+        VMSTATE_UINT32(ecmr,    RX65NEthercState),
+        VMSTATE_UINT32(rflr,    RX65NEthercState),
+        VMSTATE_UINT32(ecsr,    RX65NEthercState),
+        VMSTATE_UINT32(ecsipr,  RX65NEthercState),
+        VMSTATE_UINT32(pir,     RX65NEthercState),
+        VMSTATE_UINT32(rdmlr,   RX65NEthercState),
+        VMSTATE_UINT32(ipgr,    RX65NEthercState),
+        VMSTATE_UINT32(apr,     RX65NEthercState),
+        VMSTATE_UINT32(mpr,     RX65NEthercState),
+        VMSTATE_UINT32(tpauser, RX65NEthercState),
+        VMSTATE_UINT32(bcfrr,   RX65NEthercState),
+        VMSTATE_UINT32(mahr,    RX65NEthercState),
+        VMSTATE_UINT32(malr,    RX65NEthercState),
+        VMSTATE_UINT32(edmr,    RX65NEthercState),
+        VMSTATE_UINT32(edtrr,   RX65NEthercState),
+        VMSTATE_UINT32(edrrr,   RX65NEthercState),
+        VMSTATE_UINT32(tdlar,   RX65NEthercState),
+        VMSTATE_UINT32(rdlar,   RX65NEthercState),
+        VMSTATE_UINT32(eesr,    RX65NEthercState),
+        VMSTATE_UINT32(eesipr,  RX65NEthercState),
+        VMSTATE_UINT32(trscer,  RX65NEthercState),
+        VMSTATE_UINT32(rmfcr,   RX65NEthercState),
+        VMSTATE_UINT32(tftr,    RX65NEthercState),
+        VMSTATE_UINT32(fdr,     RX65NEthercState),
+        VMSTATE_UINT32(rmcr,    RX65NEthercState),
+        VMSTATE_UINT32(fcftr,   RX65NEthercState),
+        VMSTATE_UINT32(rpadir,  RX65NEthercState),
+        VMSTATE_UINT32(trimd,   RX65NEthercState),
+        VMSTATE_UINT32(tx_cur,  RX65NEthercState),
+        VMSTATE_UINT32(rx_cur,  RX65NEthercState),
+        VMSTATE_STRUCT(mdio, RX65NEthercState, 1, vmstate_mdio, MDIOState),
+        VMSTATE_END_OF_LIST()
+    }
+};
+
+static const Property etherc_properties[] = {
+    DEFINE_NIC_PROPERTIES(RX65NEthercState, conf),
+};
+
+static void etherc_class_init(ObjectClass *klass, const void *data)
+{
+    DeviceClass *dc = DEVICE_CLASS(klass);
+
+    dc->realize = etherc_realize;
+    dc->vmsd    = &vmstate_etherc;
+    device_class_set_legacy_reset(dc, etherc_reset);
+    device_class_set_props(dc, etherc_properties);
+    set_bit(DEVICE_CATEGORY_NETWORK, dc->categories);
+}
+
+static const TypeInfo etherc_info = {
+    .name          = TYPE_RENESAS_ETHERC,
+    .parent        = TYPE_SYS_BUS_DEVICE,
+    .instance_size = sizeof(RX65NEthercState),
+    .instance_init = etherc_init,
+    .class_init    = etherc_class_init,
+};
+
+static void etherc_register_types(void)
+{
+    type_register_static(&etherc_info);
+}
+
+type_init(etherc_register_types)
diff --git a/hw/rtc/renesas_rx_rtc.c b/hw/rtc/renesas_rx_rtc.c
new file mode 100644
index 0000000000..69cfa19d81
--- /dev/null
+++ b/hw/rtc/renesas_rx_rtc.c
@@ -0,0 +1,330 @@
+/*
+ * Renesas RX Realtime Clock (RTC)
+ *
+ * Datasheet: RX65N Group, RX651 Group User's Manual: Hardware
+ *            (Rev.1.00 R01UH0590EJ0100), section 26 (RTC)
+ *
+ * Copyright (c) 2026 Umar, Sayyad Mahammad
+ *
+ * SPDX-License-Identifier: GPL-2.0-or-later
+ *
+ *
+ * Calendar-count-mode model. The time/date registers are BCD-encoded and the
+ * counter advances once per second (driven by a host timer) while RCR2.START is
+ * set. Seeded from host wall-clock time at reset. Periodic/alarm/carry
+ * interrupts are not generated.
+ */
+
+#include "qemu/osdep.h"
+#include "qemu/log.h"
+#include "qemu/timer.h"
+#include "qemu/bcd.h"
+#include "hw/rtc/renesas_rx_rtc.h"
+#include "migration/vmstate.h"
+#include "system/rtc.h"
+#include "system/system.h"
+
+/* Register offsets from the RTC base (0x0008C400), calendar count mode. */
+#define R_R64CNT    0x00    /* 8-bit  64 Hz counter (read-only)  */
+#define R_RSECCNT   0x02    /* 8-bit  seconds  (BCD)             */
+#define R_RMINCNT   0x04    /* 8-bit  minutes  (BCD)             */
+#define R_RHRCNT    0x06    /* 8-bit  hours    (BCD)             */
+#define R_RWKCNT    0x08    /* 8-bit  day of week                */
+#define R_RDAYCNT   0x0A    /* 8-bit  day      (BCD)             */
+#define R_RMONCNT   0x0C    /* 8-bit  month    (BCD)             */
+#define R_RYRCNT    0x0E    /* 16-bit year     (BCD)             */
+#define R_RSECAR    0x10
+#define R_RMINAR    0x12
+#define R_RHRAR     0x14
+#define R_RWKAR     0x16
+#define R_RDAYAR    0x18
+#define R_RMONAR    0x1A
+#define R_RYRAR     0x1C
+#define R_RCR1      0x22    /* 8-bit  control 1                  */
+#define R_RCR2      0x24    /* 8-bit  control 2                  */
+#define R_RCR3      0x26    /* 8-bit  control 3                  */
+#define R_RCR4      0x28    /* 8-bit  control 4                  */
+
+#define RCR2_START  (1u << 0)
+#define RCR2_RESET  (1u << 1)
+
+static int days_in_month(int mon, int year)
+{
+    static const int d[] = { 31, 28, 31, 30, 31, 30, 31, 31, 30, 31, 30, 31 };
+    if (mon == 2 && ((year % 4 == 0 && year % 100 != 0) || year % 400 == 0)) {
+        return 29;
+    }
+    return d[(mon - 1) % 12];
+}
+
+static void rtc_seed_from_host(RenesasRxRtcState *s)
+{
+    struct tm now;
+
+    qemu_get_timedate(&now, 0);
+    s->sec = now.tm_sec;
+    s->min = now.tm_min;
+    s->hour = now.tm_hour;
+    s->wday = now.tm_wday;
+    s->mday = now.tm_mday;
+    s->mon = now.tm_mon + 1;
+    s->year = now.tm_year + 1900;
+}
+
+static void rtc_advance_second(RenesasRxRtcState *s)
+{
+    if (++s->sec < 60) {
+        return;
+    }
+    s->sec = 0;
+    if (++s->min < 60) {
+        return;
+    }
+    s->min = 0;
+    if (++s->hour < 24) {
+        return;
+    }
+    s->hour = 0;
+    s->wday = (s->wday + 1) % 7;
+    if (++s->mday <= days_in_month(s->mon, s->year)) {
+        return;
+    }
+    s->mday = 1;
+    if (++s->mon <= 12) {
+        return;
+    }
+    s->mon = 1;
+    s->year++;
+}
+
+static void rtc_timer_tick(void *opaque)
+{
+    RenesasRxRtcState *s = opaque;
+
+    if (!(s->rcr2 & RCR2_START)) {
+        return;
+    }
+    rtc_advance_second(s);
+    timer_mod(s->timer,
+              qemu_clock_get_ms(rtc_clock) + 1000);
+}
+
+static void rtc_arm_timer(RenesasRxRtcState *s)
+{
+    if (s->rcr2 & RCR2_START) {
+        timer_mod(s->timer, qemu_clock_get_ms(rtc_clock) + 1000);
+    } else {
+        timer_del(s->timer);
+    }
+}
+
+static uint64_t rtc_read(void *opaque, hwaddr offset, unsigned size)
+{
+    RenesasRxRtcState *s = opaque;
+
+    switch (offset) {
+    case R_R64CNT:
+        return 0;
+    case R_RSECCNT:
+        return to_bcd(s->sec);
+    case R_RMINCNT:
+        return to_bcd(s->min);
+    case R_RHRCNT:
+        return to_bcd(s->hour);
+    case R_RWKCNT:
+        return s->wday;
+    case R_RDAYCNT:
+        return to_bcd(s->mday);
+    case R_RMONCNT:
+        return to_bcd(s->mon);
+    case R_RYRCNT:
+        return to_bcd(s->year % 100) | (to_bcd(s->year / 100) << 8);
+    case R_RSECAR:
+        return s->secar;
+    case R_RMINAR:
+        return s->minar;
+    case R_RHRAR:
+        return s->hrar;
+    case R_RWKAR:
+        return s->wkar;
+    case R_RDAYAR:
+        return s->dayar;
+    case R_RMONAR:
+        return s->monar;
+    case R_RYRAR:
+        return s->yrar;
+    case R_RCR1:
+        return s->rcr1;
+    case R_RCR2:
+        return s->rcr2;
+    case R_RCR3:
+        return s->rcr3;
+    case R_RCR4:
+        return s->rcr4;
+    default:
+        qemu_log_mask(LOG_UNIMP, "renesas-rx-rtc: read unimplemented 0x%"
+                      HWADDR_PRIx "\n", offset);
+        return 0;
+    }
+}
+
+static void rtc_write(void *opaque, hwaddr offset, uint64_t value,
+                      unsigned size)
+{
+    RenesasRxRtcState *s = opaque;
+
+    switch (offset) {
+    case R_RSECCNT:
+        s->sec = from_bcd(value & 0x7f);
+        break;
+    case R_RMINCNT:
+        s->min = from_bcd(value & 0x7f);
+        break;
+    case R_RHRCNT:
+        s->hour = from_bcd(value & 0x3f);
+        break;
+    case R_RWKCNT:
+        s->wday = value & 7;
+        break;
+    case R_RDAYCNT:
+        s->mday = from_bcd(value & 0x3f);
+        break;
+    case R_RMONCNT:
+        s->mon = from_bcd(value & 0x1f);
+        break;
+    case R_RYRCNT:
+        s->year = 2000 + from_bcd(value & 0xff);
+        break;
+    case R_RSECAR:
+        s->secar = value;
+        break;
+    case R_RMINAR:
+        s->minar = value;
+        break;
+    case R_RHRAR:
+        s->hrar = value;
+        break;
+    case R_RWKAR:
+        s->wkar = value;
+        break;
+    case R_RDAYAR:
+        s->dayar = value;
+        break;
+    case R_RMONAR:
+        s->monar = value;
+        break;
+    case R_RYRAR:
+        s->yrar = value;
+        break;
+    case R_RCR1:
+        s->rcr1 = value;
+        break;
+    case R_RCR2:
+        if (value & RCR2_RESET) {
+            s->sec = s->min = s->hour = 0;
+        }
+        s->rcr2 = value & ~RCR2_RESET;
+        rtc_arm_timer(s);
+        break;
+    case R_RCR3:
+        s->rcr3 = value;
+        break;
+    case R_RCR4:
+        s->rcr4 = value;
+        break;
+    default:
+        qemu_log_mask(LOG_UNIMP, "renesas-rx-rtc: write unimplemented 0x%"
+                      HWADDR_PRIx "\n", offset);
+        break;
+    }
+}
+
+static const MemoryRegionOps rtc_ops = {
+    .read = rtc_read,
+    .write = rtc_write,
+    .endianness = DEVICE_LITTLE_ENDIAN,
+    .impl = { .min_access_size = 1, .max_access_size = 2 },
+    .valid = { .min_access_size = 1, .max_access_size = 2 },
+};
+
+static void rx_rtc_reset(DeviceState *dev)
+{
+    RenesasRxRtcState *s = RENESAS_RX_RTC(dev);
+
+    rtc_seed_from_host(s);
+    s->secar = s->minar = s->hrar = s->wkar = s->dayar = s->monar = 0;
+    s->yrar = 0;
+    s->rcr1 = 0;
+    s->rcr2 = 0;
+    s->rcr3 = 0;
+    s->rcr4 = 0;
+    timer_del(s->timer);
+}
+
+static void rx_rtc_realize(DeviceState *dev, Error **errp)
+{
+    RenesasRxRtcState *s = RENESAS_RX_RTC(dev);
+
+    s->timer = timer_new_ms(rtc_clock, rtc_timer_tick, s);
+}
+
+static void rx_rtc_init(Object *obj)
+{
+    RenesasRxRtcState *s = RENESAS_RX_RTC(obj);
+
+    memory_region_init_io(&s->mr, obj, &rtc_ops, s,
+                          "renesas-rx-rtc", RX_RTC_REGS_SIZE);
+    sysbus_init_mmio(SYS_BUS_DEVICE(obj), &s->mr);
+}
+
+static const VMStateDescription vmstate_rx_rtc = {
+    .name = "renesas-rx-rtc",
+    .version_id = 1,
+    .minimum_version_id = 1,
+    .fields = (const VMStateField[]) {
+        VMSTATE_INT32(sec, RenesasRxRtcState),
+        VMSTATE_INT32(min, RenesasRxRtcState),
+        VMSTATE_INT32(hour, RenesasRxRtcState),
+        VMSTATE_INT32(wday, RenesasRxRtcState),
+        VMSTATE_INT32(mday, RenesasRxRtcState),
+        VMSTATE_INT32(mon, RenesasRxRtcState),
+        VMSTATE_INT32(year, RenesasRxRtcState),
+        VMSTATE_UINT8(secar, RenesasRxRtcState),
+        VMSTATE_UINT8(minar, RenesasRxRtcState),
+        VMSTATE_UINT8(hrar, RenesasRxRtcState),
+        VMSTATE_UINT8(wkar, RenesasRxRtcState),
+        VMSTATE_UINT8(dayar, RenesasRxRtcState),
+        VMSTATE_UINT8(monar, RenesasRxRtcState),
+        VMSTATE_UINT16(yrar, RenesasRxRtcState),
+        VMSTATE_UINT8(rcr1, RenesasRxRtcState),
+        VMSTATE_UINT8(rcr2, RenesasRxRtcState),
+        VMSTATE_UINT8(rcr3, RenesasRxRtcState),
+        VMSTATE_UINT8(rcr4, RenesasRxRtcState),
+        VMSTATE_TIMER_PTR(timer, RenesasRxRtcState),
+        VMSTATE_END_OF_LIST()
+    }
+};
+
+static void rx_rtc_class_init(ObjectClass *klass, const void *data)
+{
+    DeviceClass *dc = DEVICE_CLASS(klass);
+
+    dc->realize = rx_rtc_realize;
+    dc->vmsd = &vmstate_rx_rtc;
+    device_class_set_legacy_reset(dc, rx_rtc_reset);
+}
+
+static const TypeInfo rx_rtc_info = {
+    .name = TYPE_RENESAS_RX_RTC,
+    .parent = TYPE_SYS_BUS_DEVICE,
+    .instance_size = sizeof(RenesasRxRtcState),
+    .instance_init = rx_rtc_init,
+    .class_init = rx_rtc_class_init,
+};
+
+static void rx_rtc_register_types(void)
+{
+    type_register_static(&rx_rtc_info);
+}
+
+type_init(rx_rtc_register_types)
diff --git a/hw/ssi/renesas_rspi.c b/hw/ssi/renesas_rspi.c
new file mode 100644
index 0000000000..ad5d8ca278
--- /dev/null
+++ b/hw/ssi/renesas_rspi.c
@@ -0,0 +1,319 @@
+/*
+ * Renesas RX65N Serial Peripheral Interface (RSPI)
+ *
+ * Datasheet: RX65N Group, RX651 Group User's Manual: Hardware
+ *            (Rev.1.00 R01UH0590EJ0100), Section 30
+ *
+ * Copyright (c) 2026 Umar, Sayyad Mahammad
+ *
+ * SPDX-License-Identifier: GPL-2.0-or-later
+ *
+ */
+
+#include "qemu/osdep.h"
+#include "qemu/log.h"
+#include "hw/core/irq.h"
+#include "hw/core/registerfields.h"
+#include "hw/core/qdev-properties.h"
+#include "hw/ssi/renesas_rspi.h"
+#include "migration/vmstate.h"
+
+/*
+ * Register offsets from device base.
+ * Reference: RX65N Group Hardware Manual Table 30.1
+ */
+REG8(SPCR,   0x00)
+  FIELD(SPCR, SPMS,   0, 1)   /* SPI mode: 0=4-wire, 1=3-wire */
+  FIELD(SPCR, TXONLY, 1, 1)   /* transmit-only mode */
+  FIELD(SPCR, MODFEN, 2, 1)   /* mode fault detect enable */
+  FIELD(SPCR, MSTR,   3, 1)   /* master/slave: 1=master */
+  FIELD(SPCR, SPEIE,  4, 1)   /* error interrupt enable */
+  FIELD(SPCR, SPTIE,  5, 1)   /* transmit interrupt enable */
+  FIELD(SPCR, SPE,    6, 1)   /* SPI function enable */
+  FIELD(SPCR, SPRIE,  7, 1)   /* receive interrupt enable */
+
+REG8(SSLP,   0x01)   /* SSL polarity */
+REG8(SPPCR,  0x02)   /* pin control */
+
+REG8(SPSR,   0x03)
+  FIELD(SPSR, OVRF,   0, 1)   /* overrun flag */
+  FIELD(SPSR, IDLNF,  1, 1)   /* idle flag */
+  FIELD(SPSR, MODF,   2, 1)   /* mode fault flag */
+  FIELD(SPSR, PERF,   3, 1)   /* parity error flag */
+  FIELD(SPSR, UDRF,   4, 1)   /* underrun flag */
+  FIELD(SPSR, SPTEF,  5, 1)   /* transmit buffer empty */
+  FIELD(SPSR, SPRFF,  6, 1)   /* receive FIFO full (not implemented here) */
+  FIELD(SPSR, SPRF,   7, 1)   /* receive buffer full */
+
+REG32(SPDR,  0x04)   /* data register (also 16-bit and 8-bit access) */
+REG8(SPSCR,  0x08)   /* sequence control */
+REG8(SPSSR,  0x09)   /* sequence status */
+REG8(SPBR,   0x0A)   /* bit rate */
+REG8(SPDCR,  0x0B)
+  FIELD(SPDCR, SPFC,  0, 2)   /* frames per access */
+  FIELD(SPDCR, SPRDTD, 4, 1)   /* receive/transmit data select */
+  FIELD(SPDCR, SPLW,  5, 1)   /* access width (1=long word) */
+  FIELD(SPDCR, SPBYT, 6, 1)   /* byte access */
+
+REG8(SPCKD,  0x0C)   /* clock delay */
+REG8(SSLND,  0x0D)   /* SSL negate delay */
+REG8(SPND,   0x0E)   /* next-access delay */
+REG8(SPCR2,  0x0F)   /* control 2 */
+/* SPCMD0–SPCMD7 at offsets 0x10–0x1E (16-bit each) */
+#define A_SPCMD_BASE 0x10
+#define A_SPCMD_END  0x1E
+REG8(SPDCR2, 0x20)   /* data control 2 */
+
+static void rspi_do_transfer(RX65NRSPIState *s)
+{
+    uint32_t rx;
+
+    /* Only transfer in master mode with SPI enabled */
+    if (!FIELD_EX8(s->spcr, SPCR, MSTR) ||
+        !FIELD_EX8(s->spcr, SPCR, SPE)) {
+        return;
+    }
+
+    rx = ssi_transfer(s->ssi, s->spdr);
+    s->spdr = rx;
+
+    /* Mark receive buffer full, transmit buffer empty */
+    s->spsr = FIELD_DP8(s->spsr, SPSR, SPRF,  1);
+    s->spsr = FIELD_DP8(s->spsr, SPSR, SPTEF, 1);
+
+    /* Fire receive interrupt */
+    if (FIELD_EX8(s->spcr, SPCR, SPRIE)) {
+        qemu_irq_pulse(s->irq[RSPI_IRQ_SPRI]);
+    }
+}
+
+static uint64_t rspi_read(void *opaque, hwaddr addr, unsigned size)
+{
+    RX65NRSPIState *s = opaque;
+    uint64_t ret;
+
+    if (addr >= A_SPCMD_BASE && addr <= A_SPCMD_END) {
+        int idx = (addr - A_SPCMD_BASE) / 2;
+        return s->spcmd[idx];
+    }
+
+    switch (addr) {
+    case A_SPCR:
+        return s->spcr;
+    case A_SSLP:
+        return s->sslp;
+    case A_SPPCR:
+        return s->sppcr;
+    case A_SPSR:
+        ret = s->spsr;
+        /* Reading SPSR clears SPRF and OVRF */
+        s->spsr = FIELD_DP8(s->spsr, SPSR, SPRF, 0);
+        s->spsr = FIELD_DP8(s->spsr, SPSR, OVRF, 0);
+        return ret;
+    case A_SPDR:
+        s->spsr = FIELD_DP8(s->spsr, SPSR, SPRF, 0);
+        /* Raise transmit interrupt now that the buffer is free again */
+        if (FIELD_EX8(s->spcr, SPCR, SPTIE)) {
+            qemu_irq_pulse(s->irq[RSPI_IRQ_SPTI]);
+        }
+        return s->spdr;
+    case A_SPSCR:
+        return s->spscr;
+    case A_SPSSR:
+        return s->spssr;
+    case A_SPBR:
+        return s->spbr;
+    case A_SPDCR:
+        return s->spdcr;
+    case A_SPCKD:
+        return s->spckd;
+    case A_SSLND:
+        return s->sslnd;
+    case A_SPND:
+        return s->spnd;
+    case A_SPCR2:
+        return s->spcr2;
+    case A_SPDCR2:
+        return s->spdcr2;
+    default:
+        qemu_log_mask(LOG_UNIMP,
+                      "renesas_rspi: read 0x%" HWADDR_PRIX " not implemented\n",
+                      addr);
+        return UINT64_MAX;
+    }
+}
+
+static void rspi_write(void *opaque, hwaddr addr, uint64_t val, unsigned size)
+{
+    RX65NRSPIState *s = opaque;
+
+    if (addr >= A_SPCMD_BASE && addr <= A_SPCMD_END) {
+        int idx = (addr - A_SPCMD_BASE) / 2;
+        s->spcmd[idx] = val;
+        return;
+    }
+
+    switch (addr) {
+    case A_SPCR:
+        s->spcr = val;
+        /* Raise SPTI when SPE+SPTIE are both set (buffer initially empty) */
+        if (FIELD_EX8(s->spcr, SPCR, SPE) &&
+            FIELD_EX8(s->spcr, SPCR, SPTIE) &&
+            FIELD_EX8(s->spsr, SPSR, SPTEF)) {
+            qemu_irq_pulse(s->irq[RSPI_IRQ_SPTI]);
+        }
+        break;
+    case A_SSLP:
+        s->sslp   = val;
+        break;
+    case A_SPPCR:
+        s->sppcr  = val;
+        break;
+    case A_SPSR:
+        /* W0C for error/status bits */
+        s->spsr &= val | 0xe0;  /* keep SPTEF, SPRFF, SPRF read-only */
+        break;
+    case A_SPDR:
+        s->spdr = val;
+        s->spsr = FIELD_DP8(s->spsr, SPSR, SPTEF, 0);
+        rspi_do_transfer(s);
+        break;
+    case A_SPSCR:
+        s->spscr  = val;
+        break;
+    case A_SPBR:
+        s->spbr   = val;
+        break;
+    case A_SPDCR:
+        s->spdcr  = val;
+        break;
+    case A_SPCKD:
+        s->spckd  = val;
+        break;
+    case A_SSLND:
+        s->sslnd  = val;
+        break;
+    case A_SPND:
+        s->spnd   = val;
+        break;
+    case A_SPCR2:
+        s->spcr2  = val;
+        break;
+    case A_SPDCR2:
+        s->spdcr2 = val;
+        break;
+    default:
+        qemu_log_mask(LOG_UNIMP, "renesas_rspi: write 0x%" HWADDR_PRIX
+                      " not implemented\n",
+                      addr);
+        break;
+    }
+}
+
+static const MemoryRegionOps rspi_ops = {
+    .read  = rspi_read,
+    .write = rspi_write,
+    .endianness = DEVICE_LITTLE_ENDIAN,
+    .impl = {
+        .min_access_size = 1,
+        .max_access_size = 4,
+    },
+    .valid = {
+        .min_access_size = 1,
+        .max_access_size = 4,
+    },
+};
+
+static void rspi_reset(DeviceState *dev)
+{
+    RX65NRSPIState *s = RENESAS_RSPI(dev);
+    int i;
+
+    s->spcr   = 0x00;
+    s->sslp   = 0x00;
+    s->sppcr  = 0x00;
+    s->spsr   = 0x20;  /* SPTEF=1: transmit buffer initially empty */
+    s->spdr   = 0x00000000;
+    s->spscr  = 0x00;
+    s->spssr  = 0x00;
+    s->spbr   = 0xff;
+    s->spdcr  = 0x20;  /* SPLW=1: long-word access default */
+    s->spckd  = 0x00;
+    s->sslnd  = 0x00;
+    s->spnd   = 0x00;
+    s->spcr2  = 0x00;
+    s->spdcr2 = 0x00;
+    for (i = 0; i < 8; i++) {
+        s->spcmd[i] = 0x0700; /* default: 8-bit, CPOL=0, CPHA=0 */
+    }
+}
+
+static void rspi_init(Object *obj)
+{
+    SysBusDevice *d = SYS_BUS_DEVICE(obj);
+    RX65NRSPIState *s = RENESAS_RSPI(obj);
+    int i;
+
+    /* 0x24 bytes covers SPCR through SPDCR2 */
+    memory_region_init_io(&s->memory, obj, &rspi_ops, s,
+                          "renesas-rspi", 0x24);
+    sysbus_init_mmio(d, &s->memory);
+
+    for (i = 0; i < RSPI_NR_IRQ; i++) {
+        sysbus_init_irq(d, &s->irq[i]);
+    }
+
+    s->ssi = ssi_create_bus(DEVICE(obj), "ssi");
+}
+
+static const VMStateDescription vmstate_rspi = {
+    .name = "renesas-rspi",
+    .version_id = 1,
+    .minimum_version_id = 1,
+    .fields = (const VMStateField[]) {
+        VMSTATE_UINT8(spcr,   RX65NRSPIState),
+        VMSTATE_UINT8(sslp,   RX65NRSPIState),
+        VMSTATE_UINT8(sppcr,  RX65NRSPIState),
+        VMSTATE_UINT8(spsr,   RX65NRSPIState),
+        VMSTATE_UINT32(spdr,  RX65NRSPIState),
+        VMSTATE_UINT8(spscr,  RX65NRSPIState),
+        VMSTATE_UINT8(spssr,  RX65NRSPIState),
+        VMSTATE_UINT8(spbr,   RX65NRSPIState),
+        VMSTATE_UINT8(spdcr,  RX65NRSPIState),
+        VMSTATE_UINT8(spckd,  RX65NRSPIState),
+        VMSTATE_UINT8(sslnd,  RX65NRSPIState),
+        VMSTATE_UINT8(spnd,   RX65NRSPIState),
+        VMSTATE_UINT8(spcr2,  RX65NRSPIState),
+        VMSTATE_UINT16_ARRAY(spcmd, RX65NRSPIState, 8),
+        VMSTATE_UINT8(spdcr2, RX65NRSPIState),
+        VMSTATE_END_OF_LIST()
+    }
+};
+
+static const Property rspi_properties[] = {
+    DEFINE_PROP_UINT64("input-freq", RX65NRSPIState, input_freq, 0),
+};
+
+static void rspi_class_init(ObjectClass *klass, const void *data)
+{
+    DeviceClass *dc = DEVICE_CLASS(klass);
+
+    dc->vmsd = &vmstate_rspi;
+    device_class_set_legacy_reset(dc, rspi_reset);
+    device_class_set_props(dc, rspi_properties);
+}
+
+static const TypeInfo rspi_info = {
+    .name          = TYPE_RENESAS_RSPI,
+    .parent        = TYPE_SYS_BUS_DEVICE,
+    .instance_size = sizeof(RX65NRSPIState),
+    .instance_init = rspi_init,
+    .class_init    = rspi_class_init,
+};
+
+static void rspi_register_types(void)
+{
+    type_register_static(&rspi_info);
+}
+
+type_init(rspi_register_types)
diff --git a/hw/timer/renesas_mtu3.c b/hw/timer/renesas_mtu3.c
new file mode 100644
index 0000000000..7dd20843ed
--- /dev/null
+++ b/hw/timer/renesas_mtu3.c
@@ -0,0 +1,509 @@
+/*
+ * Renesas RX65N Multi-Function Timer Pulse Unit 3 (MTU3)
+ *
+ * Models MTU channels 3 and 4 (the pair sharing base address 0x000C1200).
+ *
+ * Datasheet: RX65N Group, RX651 Group User's Manual: Hardware
+ *            (Rev.1.00 R01UH0590EJ0100), Section 17
+ *
+ * Copyright (c) 2026 Umar, Sayyad Mahammad
+ *
+ * SPDX-License-Identifier: GPL-2.0-or-later
+ *
+ */
+
+#include "qemu/osdep.h"
+#include "qemu/log.h"
+#include "hw/core/irq.h"
+#include "hw/core/registerfields.h"
+#include "hw/core/qdev-properties.h"
+#include "hw/timer/renesas_mtu3.h"
+#include "migration/vmstate.h"
+
+/*
+ * Register offsets from device base (0x000C1200).
+ * MTU3 and MTU4 channel registers are interleaved at the base.
+ * ch[0] = MTU channel 3, ch[1] = MTU channel 4.
+ *
+ * Reference: RX65N Group Hardware Manual Table 17.1
+ */
+#define R_TCR_CH3    0x00   /* 8-bit */
+#define R_TCR_CH4    0x01   /* 8-bit */
+#define R_TMDR1_CH3  0x02   /* 8-bit */
+#define R_TMDR1_CH4  0x03   /* 8-bit */
+#define R_TIORH_CH3  0x04   /* 8-bit */
+#define R_TIORL_CH3  0x05   /* 8-bit */
+#define R_TIORH_CH4  0x06   /* 8-bit */
+#define R_TIORL_CH4  0x07   /* 8-bit */
+#define R_TIER_CH3   0x08   /* 8-bit */
+#define R_TIER_CH4   0x09   /* 8-bit */
+#define R_TCNT_CH3   0x10   /* 16-bit */
+#define R_TCNT_CH4   0x12   /* 16-bit */
+#define R_TGRA_CH3   0x18   /* 16-bit */
+#define R_TGRB_CH3   0x1A   /* 16-bit */
+#define R_TGRA_CH4   0x1C   /* 16-bit */
+#define R_TGRB_CH4   0x1E   /* 16-bit */
+#define R_TGRC_CH3   0x24   /* 16-bit */
+#define R_TGRD_CH3   0x26   /* 16-bit */
+#define R_TGRC_CH4   0x28   /* 16-bit */
+#define R_TGRD_CH4   0x2A   /* 16-bit */
+#define R_TSR_CH3    0x2C   /* 8-bit */
+#define R_TSR_CH4    0x2D   /* 8-bit */
+#define R_TSTRA      0x80   /* 8-bit: Timer Start Register A */
+
+/* TCR register fields */
+#define TCR_TPCS_MASK   0x07   /* bits [2:0]: prescale select */
+#define TCR_CCLR_SHIFT  3
+#define TCR_CCLR_MASK   (0x07 << 3)
+#define TCR_CCLR_NONE   0
+#define TCR_CCLR_TGRA   1      /* clear TCNT on TGRA match */
+#define TCR_CCLR_TGRB   2      /* clear TCNT on TGRB match */
+
+/* TIER register bits */
+#define TIER_TGIEA  (1 << 0)   /* TGRA interrupt enable */
+#define TIER_TGIEB  (1 << 1)   /* TGRB interrupt enable */
+#define TIER_TGIEC  (1 << 2)   /* TGRC interrupt enable */
+#define TIER_TGIED  (1 << 3)   /* TGRD interrupt enable */
+#define TIER_TCIEV  (1 << 4)   /* overflow interrupt enable */
+
+/* TSR register bits */
+#define TSR_TGFA    (1 << 0)   /* TGRA compare match flag */
+#define TSR_TGFB    (1 << 1)   /* TGRB compare match flag */
+#define TSR_TGFC    (1 << 2)   /* TGRC compare match flag */
+#define TSR_TGFD    (1 << 3)   /* TGRD compare match flag */
+#define TSR_TCFV    (1 << 4)   /* overflow flag */
+
+/* TSTRA register bits */
+#define TSTR_STR3   (1 << 6)   /* MTU channel 3 start */
+#define TSTR_STR4   (1 << 7)   /* MTU channel 4 start */
+
+/* Clock prescaler: index = TCR.TPCS[2:0] */
+static const uint16_t prescaler_table[8] = {1, 4, 16, 64, 256, 1024, 1, 1};
+
+static bool chan_is_running(RXMTU3State *s, int ci)
+{
+    return !!(s->tstr & (ci == 0 ? TSTR_STR3 : TSTR_STR4));
+}
+
+static uint16_t chan_read_tcnt(RXMTU3State *s, int ci)
+{
+    struct RXMTU3ChanState *ch = &s->ch[ci];
+    int64_t now, delta;
+    uint16_t prescaler;
+    int64_t elapsed;
+
+    if (!chan_is_running(s, ci)) {
+        return ch->tcnt;
+    }
+
+    prescaler = prescaler_table[ch->tcr & TCR_TPCS_MASK];
+    if (prescaler == 0) {
+        return ch->tcnt;
+    }
+
+    now = qemu_clock_get_ns(QEMU_CLOCK_VIRTUAL);
+    delta = now - ch->tick;
+    if (delta <= 0) {
+        return ch->tcnt;
+    }
+
+    ch->div_round += delta;
+    elapsed = ch->div_round / ((int64_t)prescaler * NANOSECONDS_PER_SECOND
+                               / s->input_freq);
+    ch->div_round %= ((int64_t)prescaler * NANOSECONDS_PER_SECOND
+                      / s->input_freq);
+    ch->tick = now;
+    ch->tcnt = (uint16_t)(ch->tcnt + elapsed);
+    return ch->tcnt;
+}
+
+static void chan_mod_timer(RXMTU3State *s, int ci)
+{
+    struct RXMTU3ChanState *ch = &s->ch[ci];
+    uint16_t prescaler;
+    uint32_t diff;
+    int64_t next_ns;
+
+    if (!chan_is_running(s, ci)) {
+        timer_del(&ch->timer);
+        return;
+    }
+
+    prescaler = prescaler_table[ch->tcr & TCR_TPCS_MASK];
+    if (prescaler == 0) {
+        timer_del(&ch->timer);
+        return;
+    }
+
+    /*
+     * Schedule at the nearer of: TGRA compare match or 16-bit overflow.
+     * TGRB/C/D are not separately scheduled here; the event handler checks
+     * all flags once the timer fires.
+     */
+    uint16_t tcnt = chan_read_tcnt(s, ci);
+    uint32_t to_tgra = (ch->tgra >= tcnt) ? (uint32_t)(ch->tgra - tcnt)
+                                           : (uint32_t)(0x10000u - tcnt);
+    uint32_t to_ovf  = (uint32_t)(0x10000u - tcnt);
+    diff = MIN(to_tgra, to_ovf);
+    if (diff == 0) {
+        diff = 0x10000u;
+    }
+
+    next_ns = (int64_t)diff * prescaler
+            * (NANOSECONDS_PER_SECOND / s->input_freq);
+    timer_mod(&ch->timer,
+              qemu_clock_get_ns(QEMU_CLOCK_VIRTUAL) + next_ns);
+}
+
+static void chan_timer_event(RXMTU3State *s, int ci)
+{
+    struct RXMTU3ChanState *ch = &s->ch[ci];
+    int base = ci * MTU3_CH_NR_IRQ;
+    uint16_t tcnt = chan_read_tcnt(s, ci);
+    uint8_t cclr = (ch->tcr & TCR_CCLR_MASK) >> TCR_CCLR_SHIFT;
+
+    /* TGRA compare match */
+    if (tcnt >= ch->tgra) {
+        ch->tsr |= TSR_TGFA;
+        if (ch->tier & TIER_TGIEA) {
+            qemu_irq_pulse(s->irq[base + MTU3_IRQ_TGIA]);
+        }
+        if (cclr == TCR_CCLR_TGRA) {
+            ch->tcnt = tcnt - ch->tgra;
+            ch->tick = qemu_clock_get_ns(QEMU_CLOCK_VIRTUAL);
+            ch->div_round = 0;
+            chan_mod_timer(s, ci);
+            return;
+        }
+    }
+
+    /* TGRB compare match */
+    if (tcnt >= ch->tgrb && ch->tgrb != 0xffff) {
+        ch->tsr |= TSR_TGFB;
+        if (ch->tier & TIER_TGIEB) {
+            qemu_irq_pulse(s->irq[base + MTU3_IRQ_TGIB]);
+        }
+        if (cclr == TCR_CCLR_TGRB) {
+            ch->tcnt = tcnt - ch->tgrb;
+            ch->tick = qemu_clock_get_ns(QEMU_CLOCK_VIRTUAL);
+            ch->div_round = 0;
+            chan_mod_timer(s, ci);
+            return;
+        }
+    }
+
+    /* Overflow (TCNT wraps from 0xFFFF) */
+    if (tcnt == 0 || (tcnt >= ch->tgra && ch->tgra == 0xffff)) {
+        ch->tsr |= TSR_TCFV;
+        if (ch->tier & TIER_TCIEV) {
+            qemu_irq_pulse(s->irq[base + MTU3_IRQ_TCIV]);
+        }
+    }
+
+    chan_mod_timer(s, ci);
+}
+
+static void chan0_timer_event(void *opaque)
+{
+    chan_timer_event(opaque, 0);
+}
+
+static void chan1_timer_event(void *opaque)
+{
+    chan_timer_event(opaque, 1);
+}
+
+static uint64_t mtu3_read(void *opaque, hwaddr addr, unsigned size)
+{
+    RXMTU3State *s = opaque;
+
+    switch (addr) {
+    case R_TCR_CH3:
+        return s->ch[0].tcr;
+    case R_TCR_CH4:
+        return s->ch[1].tcr;
+    case R_TMDR1_CH3:
+        return s->ch[0].tmdr1;
+    case R_TMDR1_CH4:
+        return s->ch[1].tmdr1;
+    case R_TIORH_CH3:
+        return s->ch[0].tiorh;
+    case R_TIORL_CH3:
+        return s->ch[0].tiorl;
+    case R_TIORH_CH4:
+        return s->ch[1].tiorh;
+    case R_TIORL_CH4:
+        return s->ch[1].tiorl;
+    case R_TIER_CH3:
+        return s->ch[0].tier;
+    case R_TIER_CH4:
+        return s->ch[1].tier;
+    case R_TCNT_CH3:
+        return chan_read_tcnt(s, 0);
+    case R_TCNT_CH4:
+        return chan_read_tcnt(s, 1);
+    case R_TGRA_CH3:
+        return s->ch[0].tgra;
+    case R_TGRB_CH3:
+        return s->ch[0].tgrb;
+    case R_TGRA_CH4:
+        return s->ch[1].tgra;
+    case R_TGRB_CH4:
+        return s->ch[1].tgrb;
+    case R_TGRC_CH3:
+        return s->ch[0].tgrc;
+    case R_TGRD_CH3:
+        return s->ch[0].tgrd;
+    case R_TGRC_CH4:
+        return s->ch[1].tgrc;
+    case R_TGRD_CH4:
+        return s->ch[1].tgrd;
+    case R_TSR_CH3:
+        return s->ch[0].tsr;
+    case R_TSR_CH4:
+        return s->ch[1].tsr;
+    case R_TSTRA:
+        return s->tstr;
+    default:
+        qemu_log_mask(LOG_UNIMP,
+                      "renesas_mtu3: read 0x%" HWADDR_PRIX " not implemented\n",
+                      addr);
+        return UINT64_MAX;
+    }
+}
+
+static void mtu3_write(void *opaque, hwaddr addr, uint64_t val, unsigned size)
+{
+    RXMTU3State *s = opaque;
+    int ci = -1;
+
+    switch (addr) {
+    case R_TCR_CH3:
+        s->ch[0].tcr = val;
+        chan_mod_timer(s, 0);
+        break;
+    case R_TCR_CH4:
+        s->ch[1].tcr = val;
+        chan_mod_timer(s, 1);
+        break;
+    case R_TMDR1_CH3:
+        s->ch[0].tmdr1 = val;
+        break;
+    case R_TMDR1_CH4:
+        s->ch[1].tmdr1 = val;
+        break;
+    case R_TIORH_CH3:
+        s->ch[0].tiorh = val;
+        break;
+    case R_TIORL_CH3:
+        s->ch[0].tiorl = val;
+        break;
+    case R_TIORH_CH4:
+        s->ch[1].tiorh = val;
+        break;
+    case R_TIORL_CH4:
+        s->ch[1].tiorl = val;
+        break;
+    case R_TIER_CH3:
+        s->ch[0].tier = val;
+        break;
+    case R_TIER_CH4:
+        s->ch[1].tier = val;
+        break;
+    case R_TCNT_CH3:
+        s->ch[0].tcnt = val;
+        s->ch[0].tick = qemu_clock_get_ns(QEMU_CLOCK_VIRTUAL);
+        s->ch[0].div_round = 0;
+        chan_mod_timer(s, 0);
+        break;
+    case R_TCNT_CH4:
+        s->ch[1].tcnt = val;
+        s->ch[1].tick = qemu_clock_get_ns(QEMU_CLOCK_VIRTUAL);
+        s->ch[1].div_round = 0;
+        chan_mod_timer(s, 1);
+        break;
+    case R_TGRA_CH3:
+        ci = 0;
+        s->ch[0].tgra = val;
+        break;
+    case R_TGRB_CH3:
+        ci = 0;
+        s->ch[0].tgrb = val;
+        break;
+    case R_TGRA_CH4:
+        ci = 1;
+        s->ch[1].tgra = val;
+        break;
+    case R_TGRB_CH4:
+        ci = 1;
+        s->ch[1].tgrb = val;
+        break;
+    case R_TGRC_CH3:
+        s->ch[0].tgrc = val;
+        break;
+    case R_TGRD_CH3:
+        s->ch[0].tgrd = val;
+        break;
+    case R_TGRC_CH4:
+        s->ch[1].tgrc = val;
+        break;
+    case R_TGRD_CH4:
+        s->ch[1].tgrd = val;
+        break;
+    case R_TSR_CH3:
+        /* W0C: clear flags that are written as 0 */
+        s->ch[0].tsr &= val;
+        break;
+    case R_TSR_CH4:
+        s->ch[1].tsr &= val;
+        break;
+    case R_TSTRA: {
+        uint8_t prev = s->tstr;
+        s->tstr = val & (TSTR_STR3 | TSTR_STR4);
+        for (int i = 0; i < MTU3_NR_CHAN; i++) {
+            uint8_t bit = (i == 0) ? TSTR_STR3 : TSTR_STR4;
+            if ((s->tstr & bit) && !(prev & bit)) {
+                /* Channel just started: latch tick */
+                s->ch[i].tick = qemu_clock_get_ns(QEMU_CLOCK_VIRTUAL);
+                s->ch[i].div_round = 0;
+                chan_mod_timer(s, i);
+            } else if (!(s->tstr & bit) && (prev & bit)) {
+                /* Channel stopped: snapshot counter */
+                chan_read_tcnt(s, i);
+                timer_del(&s->ch[i].timer);
+            }
+        }
+        break;
+    }
+    default:
+        qemu_log_mask(LOG_UNIMP, "renesas_mtu3: write 0x%" HWADDR_PRIX
+                      " not implemented\n",
+                      addr);
+        break;
+    }
+
+    /* Re-arm timer if a TGR register was updated while channel is running */
+    if (ci >= 0 && chan_is_running(s, ci)) {
+        chan_mod_timer(s, ci);
+    }
+}
+
+static const MemoryRegionOps mtu3_ops = {
+    .read  = mtu3_read,
+    .write = mtu3_write,
+    .endianness = DEVICE_LITTLE_ENDIAN,
+    .impl = {
+        .min_access_size = 1,
+        .max_access_size = 2,
+    },
+    .valid = {
+        .min_access_size = 1,
+        .max_access_size = 2,
+    },
+};
+
+static void mtu3_reset(DeviceState *dev)
+{
+    RXMTU3State *s = RXMTU3(dev);
+    int i;
+
+    s->tstr = 0x00;
+    for (i = 0; i < MTU3_NR_CHAN; i++) {
+        s->ch[i].tcr   = 0x00;
+        s->ch[i].tmdr1 = 0x00;
+        s->ch[i].tiorh = 0x00;
+        s->ch[i].tiorl = 0x00;
+        s->ch[i].tier  = 0x00;
+        s->ch[i].tsr   = 0xc0;  /* reset value per HW manual */
+        s->ch[i].tcnt  = 0x0000;
+        s->ch[i].tgra  = 0xffff;
+        s->ch[i].tgrb  = 0xffff;
+        s->ch[i].tgrc  = 0xffff;
+        s->ch[i].tgrd  = 0xffff;
+        s->ch[i].tick  = qemu_clock_get_ns(QEMU_CLOCK_VIRTUAL);
+        s->ch[i].div_round = 0;
+        timer_del(&s->ch[i].timer);
+    }
+}
+
+static void mtu3_init(Object *obj)
+{
+    SysBusDevice *d = SYS_BUS_DEVICE(obj);
+    RXMTU3State *s = RXMTU3(obj);
+    int i;
+
+    /* 256-byte MMIO covers the interleaved MTU3/MTU4 registers + TSTR */
+    memory_region_init_io(&s->memory, obj, &mtu3_ops, s,
+                          "renesas-mtu3", 0x100);
+    sysbus_init_mmio(d, &s->memory);
+
+    for (i = 0; i < MTU3_NR_IRQ; i++) {
+        sysbus_init_irq(d, &s->irq[i]);
+    }
+
+    timer_init_ns(&s->ch[0].timer, QEMU_CLOCK_VIRTUAL, chan0_timer_event, s);
+    timer_init_ns(&s->ch[1].timer, QEMU_CLOCK_VIRTUAL, chan1_timer_event, s);
+}
+
+static const VMStateDescription vmstate_mtu3_chan = {
+    .name = "renesas-mtu3-chan",
+    .version_id = 1,
+    .minimum_version_id = 1,
+    .fields = (const VMStateField[]) {
+        VMSTATE_UINT8(tcr,   struct RXMTU3ChanState),
+        VMSTATE_UINT8(tmdr1, struct RXMTU3ChanState),
+        VMSTATE_UINT8(tiorh, struct RXMTU3ChanState),
+        VMSTATE_UINT8(tiorl, struct RXMTU3ChanState),
+        VMSTATE_UINT8(tier,  struct RXMTU3ChanState),
+        VMSTATE_UINT8(tsr,   struct RXMTU3ChanState),
+        VMSTATE_UINT16(tcnt, struct RXMTU3ChanState),
+        VMSTATE_UINT16(tgra, struct RXMTU3ChanState),
+        VMSTATE_UINT16(tgrb, struct RXMTU3ChanState),
+        VMSTATE_UINT16(tgrc, struct RXMTU3ChanState),
+        VMSTATE_UINT16(tgrd, struct RXMTU3ChanState),
+        VMSTATE_INT64(tick,  struct RXMTU3ChanState),
+        VMSTATE_INT64(div_round, struct RXMTU3ChanState),
+        VMSTATE_TIMER(timer, struct RXMTU3ChanState),
+        VMSTATE_END_OF_LIST()
+    }
+};
+
+static const VMStateDescription vmstate_mtu3 = {
+    .name = "renesas-mtu3",
+    .version_id = 1,
+    .minimum_version_id = 1,
+    .fields = (const VMStateField[]) {
+        VMSTATE_UINT8(tstr, RXMTU3State),
+        VMSTATE_STRUCT_ARRAY(ch, RXMTU3State, MTU3_NR_CHAN, 1,
+                             vmstate_mtu3_chan, struct RXMTU3ChanState),
+        VMSTATE_END_OF_LIST()
+    }
+};
+
+static const Property mtu3_properties[] = {
+    DEFINE_PROP_UINT64("input-freq", RXMTU3State, input_freq, 0),
+};
+
+static void mtu3_class_init(ObjectClass *klass, const void *data)
+{
+    DeviceClass *dc = DEVICE_CLASS(klass);
+
+    dc->vmsd = &vmstate_mtu3;
+    device_class_set_legacy_reset(dc, mtu3_reset);
+    device_class_set_props(dc, mtu3_properties);
+}
+
+static const TypeInfo mtu3_info = {
+    .name          = TYPE_RENESAS_MTU3,
+    .parent        = TYPE_SYS_BUS_DEVICE,
+    .instance_size = sizeof(RXMTU3State),
+    .instance_init = mtu3_init,
+    .class_init    = mtu3_class_init,
+};
+
+static void mtu3_register_types(void)
+{
+    type_register_static(&mtu3_info);
+}
+
+type_init(mtu3_register_types)
diff --git a/hw/watchdog/renesas_rx_wdt.c b/hw/watchdog/renesas_rx_wdt.c
new file mode 100644
index 0000000000..f95374b139
--- /dev/null
+++ b/hw/watchdog/renesas_rx_wdt.c
@@ -0,0 +1,193 @@
+/*
+ * Renesas RX Watchdog Timers (WDT and IWDT)
+ *
+ * Datasheet: RX65N Group, RX651 Group User's Manual: Hardware
+ *            (Rev.1.00 R01UH0590EJ0100), sections 28 (WDT) and 29 (IWDT)
+ *
+ * Copyright (c) 2026 Umar, Sayyad Mahammad
+ *
+ * SPDX-License-Identifier: GPL-2.0-or-later
+ *
+ *
+ * The watchdogs accept their refresh sequences (write 0x00 then 0xFF to the
+ * refresh register) and present a ready, non-underflowed status. QEMU models no
+ * real timeout, so a missed refresh never resets the guest; this keeps firmware
+ * that arms the watchdog during init running normally.
+ */
+
+#include "qemu/osdep.h"
+#include "qemu/log.h"
+#include "hw/watchdog/renesas_rx_wdt.h"
+#include "migration/vmstate.h"
+
+/* WDT register offsets from 0x00088020. */
+#define R_WDTRR     0x00    /* 8-bit  refresh        */
+#define R_WDTCR     0x02    /* 16-bit control        */
+#define R_WDTSR     0x04    /* 16-bit status         */
+#define R_WDTRCR    0x06    /* 8-bit  reset control  */
+
+/* IWDT register offsets (block at 0x00088030, i.e. +0x10). */
+#define R_IWDTRR    0x10    /* 8-bit  refresh        */
+#define R_IWDTCR    0x12    /* 16-bit control        */
+#define R_IWDTSR    0x14    /* 16-bit status         */
+#define R_IWDTRCR   0x16    /* 8-bit  reset control  */
+#define R_IWDTCSTPR 0x18    /* 8-bit  count-stop     */
+
+/* The counter value lives in the status register's low 14 bits. */
+#define WDT_COUNT_RELOAD    0x3fff
+
+static void wdt_refresh(uint8_t *phase, uint16_t *sr, uint64_t value)
+{
+    /* A 0x00 followed by 0xFF reloads the down-counter to its top value. */
+    if (*phase == 0 && value == 0x00) {
+        *phase = 1;
+    } else if (*phase == 1 && value == 0xff) {
+        *phase = 0;
+        *sr = (*sr & ~WDT_COUNT_RELOAD) | WDT_COUNT_RELOAD;
+    } else {
+        *phase = 0;
+    }
+}
+
+static uint64_t wdt_read(void *opaque, hwaddr offset, unsigned size)
+{
+    RenesasRxWdtState *s = opaque;
+
+    switch (offset) {
+    case R_WDTRR:
+        return 0xff;
+    case R_WDTCR:
+        return s->wdtcr;
+    case R_WDTSR:
+        return s->wdtsr;
+    case R_WDTRCR:
+        return s->wdtrcr;
+    case R_IWDTRR:
+        return 0xff;
+    case R_IWDTCR:
+        return s->iwdtcr;
+    case R_IWDTSR:
+        return s->iwdtsr;
+    case R_IWDTRCR:
+        return s->iwdtrcr;
+    case R_IWDTCSTPR:
+        return s->iwdtcstpr;
+    default:
+        qemu_log_mask(LOG_UNIMP, "renesas-rx-wdt: read unimplemented 0x%"
+                      HWADDR_PRIx "\n", offset);
+        return 0;
+    }
+}
+
+static void wdt_write(void *opaque, hwaddr offset, uint64_t value,
+                      unsigned size)
+{
+    RenesasRxWdtState *s = opaque;
+
+    switch (offset) {
+    case R_WDTRR:
+        wdt_refresh(&s->wdt_rr_phase, &s->wdtsr, value);
+        break;
+    case R_WDTCR:
+        s->wdtcr = value;
+        break;
+    case R_WDTSR:
+        s->wdtsr = value;
+        break;
+    case R_WDTRCR:
+        s->wdtrcr = value;
+        break;
+    case R_IWDTRR:
+        wdt_refresh(&s->iwdt_rr_phase, &s->iwdtsr, value);
+        break;
+    case R_IWDTCR:
+        s->iwdtcr = value;
+        break;
+    case R_IWDTSR:
+        s->iwdtsr = value;
+        break;
+    case R_IWDTRCR:
+        s->iwdtrcr = value;
+        break;
+    case R_IWDTCSTPR:
+        s->iwdtcstpr = value;
+        break;
+    default:
+        qemu_log_mask(LOG_UNIMP, "renesas-rx-wdt: write unimplemented 0x%"
+                      HWADDR_PRIx "\n", offset);
+        break;
+    }
+}
+
+static const MemoryRegionOps wdt_ops = {
+    .read = wdt_read,
+    .write = wdt_write,
+    .endianness = DEVICE_LITTLE_ENDIAN,
+    .impl = { .min_access_size = 1, .max_access_size = 2 },
+    .valid = { .min_access_size = 1, .max_access_size = 2 },
+};
+
+static void rx_wdt_reset(DeviceState *dev)
+{
+    RenesasRxWdtState *s = RENESAS_RX_WDT(dev);
+
+    s->wdtcr = 0x33f3;
+    s->wdtsr = 0;
+    s->wdtrcr = 0x80;
+    s->wdt_rr_phase = 0;
+    s->iwdtcr = 0;
+    s->iwdtsr = 0;
+    s->iwdtrcr = 0x80;
+    s->iwdtcstpr = 0;
+    s->iwdt_rr_phase = 0;
+}
+
+static void rx_wdt_init(Object *obj)
+{
+    RenesasRxWdtState *s = RENESAS_RX_WDT(obj);
+
+    memory_region_init_io(&s->mr, obj, &wdt_ops, s,
+                          "renesas-rx-wdt", RX_WDT_REGS_SIZE);
+    sysbus_init_mmio(SYS_BUS_DEVICE(obj), &s->mr);
+}
+
+static const VMStateDescription vmstate_rx_wdt = {
+    .name = "renesas-rx-wdt",
+    .version_id = 1,
+    .minimum_version_id = 1,
+    .fields = (const VMStateField[]) {
+        VMSTATE_UINT16(wdtcr, RenesasRxWdtState),
+        VMSTATE_UINT16(wdtsr, RenesasRxWdtState),
+        VMSTATE_UINT8(wdtrcr, RenesasRxWdtState),
+        VMSTATE_UINT8(wdt_rr_phase, RenesasRxWdtState),
+        VMSTATE_UINT16(iwdtcr, RenesasRxWdtState),
+        VMSTATE_UINT16(iwdtsr, RenesasRxWdtState),
+        VMSTATE_UINT8(iwdtrcr, RenesasRxWdtState),
+        VMSTATE_UINT8(iwdtcstpr, RenesasRxWdtState),
+        VMSTATE_UINT8(iwdt_rr_phase, RenesasRxWdtState),
+        VMSTATE_END_OF_LIST()
+    }
+};
+
+static void rx_wdt_class_init(ObjectClass *klass, const void *data)
+{
+    DeviceClass *dc = DEVICE_CLASS(klass);
+
+    dc->vmsd = &vmstate_rx_wdt;
+    device_class_set_legacy_reset(dc, rx_wdt_reset);
+}
+
+static const TypeInfo rx_wdt_info = {
+    .name = TYPE_RENESAS_RX_WDT,
+    .parent = TYPE_SYS_BUS_DEVICE,
+    .instance_size = sizeof(RenesasRxWdtState),
+    .instance_init = rx_wdt_init,
+    .class_init = rx_wdt_class_init,
+};
+
+static void rx_wdt_register_types(void)
+{
+    type_register_static(&rx_wdt_info);
+}
+
+type_init(rx_wdt_register_types)
diff --git a/include/hw/adc/renesas_s12ad.h b/include/hw/adc/renesas_s12ad.h
new file mode 100644
index 0000000000..2f85e0660f
--- /dev/null
+++ b/include/hw/adc/renesas_s12ad.h
@@ -0,0 +1,61 @@
+/*
+ * Renesas RX65N 12-bit Successive Approximation A/D Converter (S12AD)
+ *
+ * Datasheet: RX65N Group, RX651 Group User's Manual: Hardware
+ *            (Rev.1.00 R01UH0590EJ0100), Section 40
+ *
+ * Copyright (c) 2026 Umar, Sayyad Mahammad
+ *
+ * SPDX-License-Identifier: GPL-2.0-or-later
+ */
+
+#ifndef HW_ADC_RENESAS_S12AD_H
+#define HW_ADC_RENESAS_S12AD_H
+
+#include "qemu/timer.h"
+#include "hw/core/sysbus.h"
+#include "qom/object.h"
+
+#define TYPE_RENESAS_S12AD "renesas-s12ad"
+typedef struct RX65NS12ADState RX65NS12ADState;
+DECLARE_INSTANCE_CHECKER(RX65NS12ADState, RENESAS_S12AD, TYPE_RENESAS_S12AD)
+
+#define S12AD_NR_CHANNELS   16  /* AN000–AN015 */
+
+enum {
+    S12AD_IRQ_S12ADI = 0,  /* end of scan (group A) */
+    S12AD_IRQ_GBADI  = 1,  /* end of scan (group B) */
+    S12AD_NR_IRQ     = 2,
+};
+
+struct RX65NS12ADState {
+    /*< private >*/
+    SysBusDevice parent_obj;
+    /*< public >*/
+
+    MemoryRegion memory;
+    uint64_t input_freq;
+
+    /* Registers */
+    uint16_t adcsr;     /* A/D Control/Status */
+    uint16_t adansa0;   /* Channel select 0 (AN000–AN015) */
+    uint16_t adansa1;   /* Channel select 1 (AN016–AN020) */
+    uint16_t adads0;    /* Average enable 0 */
+    uint16_t adads1;    /* Average enable 1 */
+    uint8_t  adadc;     /* Average count */
+    uint16_t adcer;     /* Control extended */
+    uint16_t adstrgr;   /* Start trigger select */
+    uint16_t adexicr;   /* Extended input */
+    uint16_t adansb0;   /* Group B channel select 0 */
+    uint16_t adansb1;   /* Group B channel select 1 */
+    uint16_t addr[S12AD_NR_CHANNELS]; /* Result registers AN000–AN015 */
+    uint16_t adrd;      /* Temperature sensor / internal ref result */
+    uint16_t adsam;     /* Conversion time setting */
+    uint8_t adsampr;    /* ADSAM write protection */
+    uint8_t ext_regs[0x80]; /* Extended configuration, offsets 0x70-0xef */
+
+    qemu_irq irq[S12AD_NR_IRQ];
+    QEMUTimer conv_timer; /* models conversion delay */
+};
+
+#endif /* HW_ADC_RENESAS_S12AD_H */
diff --git a/include/hw/dma/renesas_rx_dmac.h b/include/hw/dma/renesas_rx_dmac.h
new file mode 100644
index 0000000000..47242a31b6
--- /dev/null
+++ b/include/hw/dma/renesas_rx_dmac.h
@@ -0,0 +1,57 @@
+/*
+ * Renesas RX DMA Controller (DMAC) and Data Transfer Controller (DTC)
+ *
+ * Datasheet: RX65N Group, RX651 Group User's Manual: Hardware
+ *            (Rev.1.00 R01UH0590EJ0100), sections 17 (DMAC) and 18 (DTC)
+ *
+ * Copyright (c) 2026 Umar, Sayyad Mahammad
+ *
+ * SPDX-License-Identifier: GPL-2.0-or-later
+ *
+ */
+
+#ifndef HW_DMA_RENESAS_RX_DMAC_H
+#define HW_DMA_RENESAS_RX_DMAC_H
+
+#include "hw/core/sysbus.h"
+#include "qom/object.h"
+
+#define TYPE_RENESAS_RX_DMAC "renesas-rx-dmac"
+typedef struct RenesasRxDmacState RenesasRxDmacState;
+DECLARE_INSTANCE_CHECKER(RenesasRxDmacState, RENESAS_RX_DMAC,
+                         TYPE_RENESAS_RX_DMAC)
+
+#define RX_DMAC_NR_CH       8
+#define RX_DMAC_CH_SIZE     0x40        /* per-channel register spacing  */
+#define RX_DMAC_REGS_SIZE   0x300       /* channels + common registers   */
+
+typedef struct RxDmacChannel {
+    uint32_t dmsar;     /* source address                       */
+    uint32_t dmdar;     /* destination address                  */
+    uint32_t dmcra;     /* transfer count (A: lower, B: upper)  */
+    uint16_t dmcrb;     /* block transfer count                 */
+    uint16_t dmtmd;     /* transfer mode                        */
+    uint8_t  dmint;     /* interrupt setting                    */
+    uint16_t dmamd;     /* address mode                         */
+    uint32_t dmofr;     /* offset                               */
+    uint8_t  dmcnt;     /* transfer enable                      */
+    uint8_t  dmreq;     /* software/refresh request             */
+    uint8_t  dmsts;     /* status                               */
+} RxDmacChannel;
+
+struct RenesasRxDmacState {
+    /*< private >*/
+    SysBusDevice parent_obj;
+    /*< public >*/
+
+    MemoryRegion mr;
+    AddressSpace *as;
+    MemoryRegion *dma_mr;
+
+    RxDmacChannel ch[RX_DMAC_NR_CH];
+    uint8_t dmast;      /* module activation                    */
+
+    qemu_irq irq[RX_DMAC_NR_CH];
+};
+
+#endif /* HW_DMA_RENESAS_RX_DMAC_H */
diff --git a/include/hw/dma/renesas_rx_dtc.h b/include/hw/dma/renesas_rx_dtc.h
new file mode 100644
index 0000000000..aa02bf5d66
--- /dev/null
+++ b/include/hw/dma/renesas_rx_dtc.h
@@ -0,0 +1,42 @@
+/*
+ * Renesas RX Data Transfer Controller (DTC)
+ *
+ * Datasheet: RX65N Group, RX651 Group User's Manual: Hardware
+ *            (Rev.1.00 R01UH0590EJ0100), section 18 (DTC)
+ *
+ * Copyright (c) 2026 Umar, Sayyad Mahammad
+ *
+ * SPDX-License-Identifier: GPL-2.0-or-later
+ *
+ */
+
+#ifndef HW_DMA_RENESAS_RX_DTC_H
+#define HW_DMA_RENESAS_RX_DTC_H
+
+#include "hw/core/sysbus.h"
+#include "qom/object.h"
+
+#define TYPE_RENESAS_RX_DTC "renesas-rx-dtc"
+typedef struct RenesasRxDtcState RenesasRxDtcState;
+DECLARE_INSTANCE_CHECKER(RenesasRxDtcState, RENESAS_RX_DTC, TYPE_RENESAS_RX_DTC)
+
+#define RX_DTC_REGS_SIZE    0x20
+
+struct RenesasRxDtcState {
+    /*< private >*/
+    SysBusDevice parent_obj;
+    /*< public >*/
+
+    MemoryRegion mr;
+
+    uint8_t  dtccr;     /* control                    */
+    uint32_t dtcvbr;    /* vector base address        */
+    uint8_t  dtcadmod;  /* address mode               */
+    uint8_t  dtcst;     /* module start               */
+    uint16_t dtcsts;    /* status                     */
+    uint32_t dtcibr;    /* index table base           */
+    uint8_t  dtcor;     /* operation                  */
+    uint16_t dtcexbr;   /* extended repeat-area base  */
+};
+
+#endif /* HW_DMA_RENESAS_RX_DTC_H */
diff --git a/include/hw/gpio/renesas_rx_gpio.h b/include/hw/gpio/renesas_rx_gpio.h
new file mode 100644
index 0000000000..24784d7d1a
--- /dev/null
+++ b/include/hw/gpio/renesas_rx_gpio.h
@@ -0,0 +1,64 @@
+/*
+ * Renesas RX I/O Ports (GPIO) and Multi-Function Pin Controller (MPC)
+ *
+ * Datasheet: RX65N Group, RX651 Group User's Manual: Hardware
+ *            (Rev.1.00 R01UH0590EJ0100), sections 20 (I/O Ports) and 22 (MPC)
+ *
+ * Copyright (c) 2026 Umar, Sayyad Mahammad
+ *
+ * SPDX-License-Identifier: GPL-2.0-or-later
+ *
+ */
+
+#ifndef HW_GPIO_RENESAS_RX_GPIO_H
+#define HW_GPIO_RENESAS_RX_GPIO_H
+
+#include "hw/core/sysbus.h"
+#include "qom/object.h"
+
+#define TYPE_RENESAS_RX_GPIO "renesas-rx-gpio"
+typedef struct RenesasRxGpioState RenesasRxGpioState;
+DECLARE_INSTANCE_CHECKER(RenesasRxGpioState, RENESAS_RX_GPIO,
+                         TYPE_RENESAS_RX_GPIO)
+
+/* Number of 8-bit ports modelled (PORT0..PORT1F register indices). */
+#define RX_GPIO_NR_PORTS    0x20
+#define RX_GPIO_NR_PINS     (RX_GPIO_NR_PORTS * 8)
+
+/* MMIO regions. */
+enum {
+    RX_GPIO_MMIO_PORT = 0,  /* I/O port register block (0x0008C000) */
+    RX_GPIO_MMIO_MPC,       /* MPC pin-function block   (0x0008C100) */
+    RX_GPIO_NR_MMIO,
+};
+
+#define RX_GPIO_PORT_SIZE   0x100
+#define RX_GPIO_MPC_SIZE    0x200
+
+struct RenesasRxGpioState {
+    /*< private >*/
+    SysBusDevice parent_obj;
+    /*< public >*/
+
+    MemoryRegion port_mr;
+    MemoryRegion mpc_mr;
+
+    /* Per-port registers. */
+    uint8_t pdr[RX_GPIO_NR_PORTS];      /* direction: 1 = output         */
+    uint8_t podr[RX_GPIO_NR_PORTS];     /* output data                   */
+    uint8_t pmr[RX_GPIO_NR_PORTS];      /* mode: 1 = peripheral          */
+    uint8_t odr[RX_GPIO_NR_PORTS * 2];  /* open-drain control (2/port)   */
+    uint8_t pcr[RX_GPIO_NR_PORTS];      /* pull-up control               */
+    uint8_t dscr[RX_GPIO_NR_PORTS];     /* drive capacity                */
+
+    /* External input level driven onto each port by board wiring. */
+    uint8_t input[RX_GPIO_NR_PORTS];
+
+    /* MPC PFS storage and write-protect register. */
+    uint8_t mpc[RX_GPIO_MPC_SIZE];
+
+    /* Output lines, one per pin (port * 8 + bit). */
+    qemu_irq out[RX_GPIO_NR_PINS];
+};
+
+#endif /* HW_GPIO_RENESAS_RX_GPIO_H */
diff --git a/include/hw/misc/renesas_rx_crc.h b/include/hw/misc/renesas_rx_crc.h
new file mode 100644
index 0000000000..1c41b6bd4b
--- /dev/null
+++ b/include/hw/misc/renesas_rx_crc.h
@@ -0,0 +1,30 @@
+/*
+ * Renesas RX CRC Calculator (CRCA)
+ *
+ * Copyright (c) 2026 Umar, Sayyad Mahammad
+ *
+ * SPDX-License-Identifier: GPL-2.0-or-later
+ */
+
+#ifndef HW_MISC_RENESAS_RX_CRC_H
+#define HW_MISC_RENESAS_RX_CRC_H
+
+#include "hw/core/sysbus.h"
+#include "qom/object.h"
+
+#define TYPE_RENESAS_RX_CRC "renesas-rx-crc"
+OBJECT_DECLARE_SIMPLE_TYPE(RenesasRxCrcState, RENESAS_RX_CRC)
+
+/* CRCCR, CRCDIR and CRCDOR occupy 0x8280, 0x8284 and 0x8288. */
+#define RX_CRC_SIZE     0x10
+
+struct RenesasRxCrcState {
+    SysBusDevice parent_obj;
+
+    MemoryRegion memory;
+
+    uint8_t crccr;      /* control: GPS[2:0], LMS, DORCLR */
+    uint32_t crcdor;    /* running result, also the initial value */
+};
+
+#endif /* HW_MISC_RENESAS_RX_CRC_H */
diff --git a/include/hw/misc/renesas_rx_fcu.h b/include/hw/misc/renesas_rx_fcu.h
new file mode 100644
index 0000000000..5bc580f51e
--- /dev/null
+++ b/include/hw/misc/renesas_rx_fcu.h
@@ -0,0 +1,191 @@
+/*
+ * Renesas RX Flash Control Unit (FCU) with FACI command interface
+ *
+ * Datasheet: RX65N Group, RX651 Group User's Manual: Hardware
+ *            (Rev.1.00 R01UH0590EJ0100), section 6 (Flash Memory)
+ *
+ * Copyright (c) 2026 Umar, Sayyad Mahammad
+ *
+ * SPDX-License-Identifier: GPL-2.0-or-later
+ *
+ */
+
+#ifndef HW_MISC_RENESAS_RX_FCU_H
+#define HW_MISC_RENESAS_RX_FCU_H
+
+#include "hw/core/sysbus.h"
+#include "qom/object.h"
+
+#define TYPE_RENESAS_RX_FCU "renesas-rx-fcu"
+#include "system/block-backend.h"
+
+typedef struct RenesasRxFcuState RenesasRxFcuState;
+DECLARE_INSTANCE_CHECKER(RenesasRxFcuState, RENESAS_RX_FCU, TYPE_RENESAS_RX_FCU)
+
+/* The FACI control register block (0x007FE000) covers the first 4 KiB. */
+#define RX_FCU_REGS_SIZE    0x1000
+
+/*
+ * FACI command-issuing area: every command byte and data word is written
+ * here, and the destination inside the flash comes from FSADDR.
+ */
+#define RX_FCU_FACI_ISSUE_BASE  0x007E0000
+#define RX_FCU_FACI_ISSUE_SIZE  4
+
+/*
+ * Option-setting memory (OFSM). It sits apart from the code flash array and
+ * holds, among other things, the two registers that select the code flash
+ * bank layout.
+ */
+#define RX_FCU_OFSM_SIZE    0x80
+#define RX_OFSM_MDE         0x00    /* Endian Select Register  (BANKMD) */
+#define RX_OFSM_BANKSEL     0x20    /* Bank Select Register    (BANKSWP) */
+
+/*
+ * MDE.BANKMD[2:0] picks the code flash layout: 111b is linear mode, 000b is
+ * dual mode. A blank part reads 0xffffffff, hence linear.
+ */
+#define RX_BANKMD_MASK      0x7
+#define RX_BANKMD_DUAL      0x0
+#define RX_BANKMD_LINEAR    0x7
+
+/*
+ * BANKSEL.BANKSWP[2:0] picks which bank is mapped where in dual mode. 111b
+ * puts bank 0 in the upper half, which is where the vectors live, so it is
+ * the layout a linearly programmed image already has; 000b swaps the two.
+ */
+#define RX_BANKSWP_MASK     0x7
+#define RX_BANKSWP_NORMAL   0x7
+#define RX_BANKSWP_SWAPPED  0x0
+
+/* sysbus MMIO regions exposed by the device. */
+enum {
+    RX_FCU_MMIO_REGS = 0,   /* FACI control/status registers      */
+    RX_FCU_MMIO_CFLASH,     /* code flash array (rom_device)      */
+    RX_FCU_MMIO_DFLASH,     /* data flash array (rom_device)      */
+    RX_FCU_MMIO_OFSM,       /* option-setting memory              */
+    RX_FCU_MMIO_FACI,       /* FACI command-issuing area          */
+    RX_FCU_NR_MMIO,
+};
+
+/* sysbus IRQ lines. */
+enum {
+    RX_FCU_IRQ_FRDYI = 0,   /* flash ready interrupt   */
+    RX_FCU_IRQ_FIFERR,      /* flash access error      */
+    RX_FCU_NR_IRQ,
+};
+
+/* Identifies which flash array a FACI command targets. */
+typedef enum {
+    RX_FCU_CFLASH = 0,
+    RX_FCU_DFLASH = 1,
+} RxFcuTarget;
+
+/*
+ * Per-array context handed to the flash MemoryRegion ops so a single set of
+ * callbacks can serve both the code and data flash arrays.
+ */
+typedef struct RxFcuFlash {
+    RenesasRxFcuState *fcu;
+    RxFcuTarget target;
+} RxFcuFlash;
+
+/* FACI command sequencer state. */
+typedef enum {
+    RX_FCU_ST_READY = 0,
+    RX_FCU_ST_PROGRAM_COUNT,    /* awaiting the data-word count       */
+    RX_FCU_ST_PROGRAM_DATA,     /* receiving data words, then 0xD0     */
+    RX_FCU_ST_ERASE,            /* awaiting the 0xD0 confirmation      */
+    RX_FCU_ST_BLANKCHECK,       /* awaiting the 0xD0 confirmation      */
+    RX_FCU_ST_CONFIG_COUNT,     /* awaiting the config data-word count */
+    RX_FCU_ST_CONFIG_DATA,      /* receiving config words, then 0xD0   */
+} RxFcuCmdState;
+
+struct RenesasRxFcuState {
+    /*< private >*/
+    SysBusDevice parent_obj;
+    /*< public >*/
+
+    MemoryRegion regs_mr;
+    MemoryRegion cflash_mr;     /* backing store, reached through the aliases */
+    MemoryRegion dflash_mr;
+    MemoryRegion ofsm_mr;
+    MemoryRegion faci_mr;
+
+    /*
+     * The code flash is exposed through a container so the two dual-mode
+     * banks can be mapped in either order. In linear mode the container
+     * holds one alias spanning the whole array; in dual mode it holds one
+     * alias per half, placed according to BANKSWP. The 1.5 MiB parts have a
+     * gap between the two bank windows.
+     */
+    MemoryRegion cflash_container;
+    MemoryRegion cflash_linear;
+    MemoryRegion cflash_bank[2];
+
+    RxFcuFlash cflash_ctx;
+    RxFcuFlash dflash_ctx;
+
+    qemu_irq frdyi;
+    qemu_irq fiferr;
+
+    /* Geometry (set via properties by the MCU). */
+    uint32_t cflash_size;
+    uint32_t dflash_size;
+    uint32_t cflash_base;       /* absolute CPU address of code flash */
+    uint32_t dflash_base;       /* absolute CPU address of data flash */
+    uint32_t dual_bank_gap_size;
+
+    /* Backing storage pointers (into the rom_device RAM). */
+    uint8_t *cflash_ptr;
+    uint8_t *dflash_ptr;
+    uint8_t *ofsm_ptr;
+
+    /* Code flash bank layout latched at reset from the OFSM. */
+    uint32_t cfg_off;           /* OFSM offset for a configuration set  */
+    bool dual_mode;
+    bool bank_swapped;
+
+    /*
+     * Optional block backends. When present the array is loaded from the
+     * image at realize and every program or erase is written back, so flash
+     * contents survive across runs the way real flash does.
+     */
+    BlockBackend *cflash_blk;
+    BlockBackend *dflash_blk;
+    BlockBackend *ofsm_blk;
+    bool cflash_ro;
+    bool dflash_ro;
+    bool ofsm_ro;
+
+    /* FACI registers. */
+    uint16_t fentryr;           /* P/E mode entry (read-back form)    */
+    uint32_t fstatr;            /* flash status                       */
+    uint8_t  fastat;            /* flash access status                */
+    uint8_t  frdyie;            /* flash ready interrupt enable       */
+    uint8_t  faeint;            /* flash access error interrupt enable */
+    uint32_t fsaddr;            /* processing start address           */
+    uint32_t fpsaddr;           /* programmed/erased start address    */
+    uint32_t feaddr;            /* processing end address             */
+    uint8_t  fbcstat;           /* blank check status                 */
+    uint16_t fbccnt;            /* blank check control                */
+    uint16_t fcpsr;             /* clear/processing switch            */
+    uint16_t fpckar;            /* clock notification                 */
+    uint16_t fprotr;            /* protection                         */
+    uint16_t fsuacr;            /* startup area control               */
+    uint16_t fpestat;           /* P/E error status                   */
+    uint16_t fcmdr;             /* last FACI command (read-only)      */
+
+    /*
+     * Command sequencer (RxFcuCmdState / RxFcuTarget, stored as int32 for
+     * migration).
+     */
+    int32_t cmd_state;
+    int32_t cmd_target;         /* array of the in-progress command   */
+    uint32_t      prog_off;     /* next program offset within array   */
+    uint32_t      prog_words;   /* remaining 16-bit words to program  */
+};
+
+void rx_fcu_update_bank_map(RenesasRxFcuState *s);
+
+#endif /* HW_MISC_RENESAS_RX_FCU_H */
diff --git a/include/hw/misc/renesas_rx_romcache.h b/include/hw/misc/renesas_rx_romcache.h
new file mode 100644
index 0000000000..2c3ddeb4bb
--- /dev/null
+++ b/include/hw/misc/renesas_rx_romcache.h
@@ -0,0 +1,30 @@
+/*
+ * Renesas RX ROM cache control registers
+ *
+ * Copyright (c) 2026 Umar, Sayyad Mahammad
+ *
+ * SPDX-License-Identifier: GPL-2.0-or-later
+ */
+
+#ifndef HW_MISC_RENESAS_RX_ROMCACHE_H
+#define HW_MISC_RENESAS_RX_ROMCACHE_H
+
+#include "hw/core/sysbus.h"
+#include "qom/object.h"
+
+#define TYPE_RENESAS_RX_ROMCACHE "renesas-rx-romcache"
+OBJECT_DECLARE_SIMPLE_TYPE(RenesasRxRomCacheState, RENESAS_RX_ROMCACHE)
+
+/* Also covers the adjacent system ROMWT register at +0x01c. */
+#define RX_ROMCACHE_SIZE    0x20
+
+struct RenesasRxRomCacheState {
+    SysBusDevice parent_obj;
+
+    MemoryRegion memory;
+
+    uint16_t romce;     /* ROM cache enable */
+    uint8_t romwt;      /* ROM wait cycles */
+};
+
+#endif /* HW_MISC_RENESAS_RX_ROMCACHE_H */
diff --git a/include/hw/misc/rx65n_sysclk.h b/include/hw/misc/rx65n_sysclk.h
new file mode 100644
index 0000000000..5733e9a126
--- /dev/null
+++ b/include/hw/misc/rx65n_sysclk.h
@@ -0,0 +1,37 @@
+/*
+ * RX65N Clock Generation Circuit (SYSTEM) registers
+ *
+ * Datasheet: RX65N Group, RX651 Group User's Manual: Hardware
+ *            (Rev.1.00 R01UH0590EJ0100), section 9
+ *
+ * Copyright (c) 2026 Umar, Sayyad Mahammad
+ *
+ * SPDX-License-Identifier: GPL-2.0-or-later
+ *
+ */
+
+#ifndef HW_MISC_RX65N_SYSCLK_H
+#define HW_MISC_RX65N_SYSCLK_H
+
+#include "hw/core/sysbus.h"
+#include "qom/object.h"
+
+#define TYPE_RX65N_SYSCLK "rx65n-sysclk"
+typedef struct RX65NSysClkState RX65NSysClkState;
+DECLARE_INSTANCE_CHECKER(RX65NSysClkState, RX65N_SYSCLK, TYPE_RX65N_SYSCLK)
+
+/* The clock-generation register block occupies 0x80000-0x80FFF. */
+#define RX65N_SYSCLK_SIZE   0x1000
+
+struct RX65NSysClkState {
+    /*< private >*/
+    SysBusDevice parent_obj;
+    /*< public >*/
+
+    MemoryRegion memory;
+
+    /* Backing storage for the register block. */
+    uint8_t regs[RX65N_SYSCLK_SIZE];
+};
+
+#endif /* HW_MISC_RX65N_SYSCLK_H */
diff --git a/include/hw/net/renesas_etherc.h b/include/hw/net/renesas_etherc.h
new file mode 100644
index 0000000000..c35a7b3f6e
--- /dev/null
+++ b/include/hw/net/renesas_etherc.h
@@ -0,0 +1,109 @@
+/*
+ * Renesas RX65N Ethernet Controller (ETHERC) + Ethernet DMA Controller (EDMAC)
+ *
+ * Datasheet: RX65N Group, RX651 Group User's Manual: Hardware
+ *            (Rev.1.00 R01UH0590EJ0100), Sections 32–33
+ *
+ * Copyright (c) 2026 Umar, Sayyad Mahammad
+ *
+ * SPDX-License-Identifier: GPL-2.0-or-later
+ */
+
+#ifndef HW_NET_RENESAS_ETHERC_H
+#define HW_NET_RENESAS_ETHERC_H
+
+#include "hw/core/sysbus.h"
+#include "net/net.h"
+#include "qom/object.h"
+
+#define TYPE_RENESAS_ETHERC "renesas-etherc"
+typedef struct RX65NEthercState RX65NEthercState;
+DECLARE_INSTANCE_CHECKER(RX65NEthercState, RENESAS_ETHERC, TYPE_RENESAS_ETHERC)
+
+/* MMIO covers ETHERC (0x000–0x1FF) + EDMAC (0x200–0x3FF) */
+#define ETHERC_MMIO_SIZE    0x200
+
+enum {
+    ETHERC_IRQ_EINT = 0,  /* EDMAC interrupt (vector 32) */
+    ETHERC_NR_IRQ   = 1,
+};
+
+/* MDIO bit-bang state machine */
+typedef struct {
+    int     preamble;       /* consecutive MDO=1 count */
+    int     in_cnt;         /* master bits received (-1 = idle) */
+    uint32_t sr;            /* shift register for header bits */
+    bool    is_read;        /* current transaction is a read */
+    int     write_cnt;      /* write data/TA bits accumulated */
+    int     write_paddr;
+    int     write_raddr;
+    uint16_t write_data;
+    uint16_t read_data;     /* latched PHY register value */
+    int     out_cnt;        /* slave output bit counter (-1 = idle) */
+    bool    mdi;            /* current MDI output level */
+    uint16_t phy_regs[32];  /* shared register bank for PHY addresses 0 and 1 */
+} MDIOState;
+
+struct RX65NEthercState {
+    /*< private >*/
+    SysBusDevice parent_obj;
+    /*< public >*/
+
+    MemoryRegion memory;
+    NICState *nic;
+    NICConf conf;
+
+    qemu_irq irq[ETHERC_NR_IRQ];
+
+    /* ETHERC registers (offsets 0x000–0x0FF) */
+    uint32_t ecmr;
+    uint32_t rflr;
+    uint32_t ecsr;
+    uint32_t ecsipr;
+    uint32_t pir;
+    uint32_t rdmlr;
+    uint32_t ipgr;
+    uint32_t apr;
+    uint32_t mpr;
+    uint32_t tpauser;
+    uint32_t bcfrr;
+    uint32_t mahr;
+    uint32_t malr;
+    uint32_t trocr;
+    uint32_t cdcr;
+    uint32_t lccr;
+    uint32_t cndcr;
+    uint32_t cefcr;
+    uint32_t frecr;
+    uint32_t tsfrcr;
+    uint32_t tlfrcr;
+    uint32_t rfcr;
+    uint32_t mafcr;
+
+    /* EDMAC registers (offsets 0x200–0x2FF) */
+    uint32_t edmr;
+    uint32_t edtrr;
+    uint32_t edrrr;
+    uint32_t tdlar;
+    uint32_t rdlar;
+    uint32_t eesr;
+    uint32_t eesipr;
+    uint32_t trscer;
+    uint32_t rmfcr;
+    uint32_t tftr;
+    uint32_t fdr;
+    uint32_t rmcr;
+    uint32_t tfucr;
+    uint32_t rfocr;
+    uint32_t fcftr;
+    uint32_t rpadir;
+    uint32_t trimd;
+
+    /* DMA ring state */
+    uint32_t tx_cur;
+    uint32_t rx_cur;
+
+    MDIOState mdio;
+};
+
+#endif /* HW_NET_RENESAS_ETHERC_H */
diff --git a/include/hw/rtc/renesas_rx_rtc.h b/include/hw/rtc/renesas_rx_rtc.h
new file mode 100644
index 0000000000..762d8cea51
--- /dev/null
+++ b/include/hw/rtc/renesas_rx_rtc.h
@@ -0,0 +1,52 @@
+/*
+ * Renesas RX Realtime Clock (RTC)
+ *
+ * Datasheet: RX65N Group, RX651 Group User's Manual: Hardware
+ *            (Rev.1.00 R01UH0590EJ0100), section 26 (RTC)
+ *
+ * Copyright (c) 2026 Umar, Sayyad Mahammad
+ *
+ * SPDX-License-Identifier: GPL-2.0-or-later
+ *
+ */
+
+#ifndef HW_RTC_RENESAS_RX_RTC_H
+#define HW_RTC_RENESAS_RX_RTC_H
+
+#include "hw/core/sysbus.h"
+#include "qom/object.h"
+
+#define TYPE_RENESAS_RX_RTC "renesas-rx-rtc"
+typedef struct RenesasRxRtcState RenesasRxRtcState;
+DECLARE_INSTANCE_CHECKER(RenesasRxRtcState, RENESAS_RX_RTC, TYPE_RENESAS_RX_RTC)
+
+#define RX_RTC_REGS_SIZE    0x40
+
+struct RenesasRxRtcState {
+    /*< private >*/
+    SysBusDevice parent_obj;
+    /*< public >*/
+
+    MemoryRegion mr;
+    QEMUTimer *timer;
+
+    /* Current time held as binary fields (converted to/from BCD on access). */
+    int sec;
+    int min;
+    int hour;
+    int wday;       /* 0 = Sunday */
+    int mday;       /* 1..31 */
+    int mon;        /* 1..12 */
+    int year;       /* full year, e.g. 2024 */
+
+    /* Alarm match registers (raw BCD as written). */
+    uint8_t secar, minar, hrar, wkar, dayar, monar;
+    uint16_t yrar;
+
+    uint8_t rcr1;
+    uint8_t rcr2;
+    uint8_t rcr3;
+    uint8_t rcr4;
+};
+
+#endif /* HW_RTC_RENESAS_RX_RTC_H */
diff --git a/include/hw/ssi/renesas_rspi.h b/include/hw/ssi/renesas_rspi.h
new file mode 100644
index 0000000000..b6f5bf8b0b
--- /dev/null
+++ b/include/hw/ssi/renesas_rspi.h
@@ -0,0 +1,61 @@
+/*
+ * Renesas RX65N Serial Peripheral Interface (RSPI)
+ *
+ * Datasheet: RX65N Group, RX651 Group User's Manual: Hardware
+ *            (Rev.1.00 R01UH0590EJ0100), Section 30
+ *
+ * Copyright (c) 2026 Umar, Sayyad Mahammad
+ *
+ * SPDX-License-Identifier: GPL-2.0-or-later
+ */
+
+#ifndef HW_SSI_RENESAS_RSPI_H
+#define HW_SSI_RENESAS_RSPI_H
+
+#include "hw/core/sysbus.h"
+#include "hw/ssi/ssi.h"
+#include "qom/object.h"
+
+#define TYPE_RENESAS_RSPI "renesas-rspi"
+typedef struct RX65NRSPIState RX65NRSPIState;
+DECLARE_INSTANCE_CHECKER(RX65NRSPIState, RENESAS_RSPI, TYPE_RENESAS_RSPI)
+
+enum {
+    RSPI_IRQ_SPEI = 0,  /* error */
+    RSPI_IRQ_SPRI = 1,  /* receive buffer full */
+    RSPI_IRQ_SPTI = 2,  /* transmit buffer empty */
+    RSPI_IRQ_SPII = 3,  /* idle */
+    RSPI_NR_IRQ   = 4,
+};
+
+struct RX65NRSPIState {
+    /*< private >*/
+    SysBusDevice parent_obj;
+    /*< public >*/
+
+    MemoryRegion memory;
+    uint64_t input_freq;
+    SSIBus *ssi;
+
+    /* Registers */
+    uint8_t  spcr;    /* Control */
+    uint8_t  sslp;    /* SSL polarity */
+    uint8_t  sppcr;   /* Pin control */
+    uint8_t  spsr;    /* Status */
+    /* Data is double-buffered in hardware; this model uses one buffer. */
+    uint32_t spdr;
+    uint8_t  spscr;   /* Sequence control */
+    uint8_t  spssr;   /* Sequence status */
+    uint8_t  spbr;    /* Bit rate */
+    uint8_t  spdcr;   /* Data control */
+    uint8_t  spckd;   /* Clock delay */
+    uint8_t  sslnd;   /* SSL negate delay */
+    uint8_t  spnd;    /* Next-access delay */
+    uint8_t  spcr2;   /* Control 2 */
+    uint16_t spcmd[8]; /* Command registers 0–7 */
+    uint8_t  spdcr2;  /* Data control 2 */
+
+    qemu_irq irq[RSPI_NR_IRQ];
+};
+
+#endif /* HW_SSI_RENESAS_RSPI_H */
diff --git a/include/hw/timer/renesas_mtu3.h b/include/hw/timer/renesas_mtu3.h
new file mode 100644
index 0000000000..8d1b82aec5
--- /dev/null
+++ b/include/hw/timer/renesas_mtu3.h
@@ -0,0 +1,73 @@
+/*
+ * Renesas RX65N Multi-Function Timer Pulse Unit 3 (MTU3)
+ *
+ * Datasheet: RX65N Group, RX651 Group User's Manual: Hardware
+ *            (Rev.1.00 R01UH0590EJ0100), Section 17
+ *
+ * Copyright (c) 2026 Umar, Sayyad Mahammad
+ *
+ * SPDX-License-Identifier: GPL-2.0-or-later
+ */
+
+#ifndef HW_TIMER_RENESAS_MTU3_H
+#define HW_TIMER_RENESAS_MTU3_H
+
+#include "qemu/timer.h"
+#include "hw/core/sysbus.h"
+#include "qom/object.h"
+
+#define TYPE_RENESAS_MTU3 "renesas-mtu3"
+typedef struct RXMTU3State RXMTU3State;
+DECLARE_INSTANCE_CHECKER(RXMTU3State, RXMTU3, TYPE_RENESAS_MTU3)
+
+/*
+ * This device models MTU3 channels 3 and 4 of the RX65N MTU3 module,
+ * which share base address 0x000C1200 with an interleaved register layout.
+ * ch[0] = MTU channel 3, ch[1] = MTU channel 4.
+ */
+enum {
+    MTU3_NR_CHAN    = 2,
+    MTU3_CH_NR_IRQ = 5,   /* TGIA, TGIB, TGIC, TGID, TCIV per channel */
+    MTU3_NR_IRQ    = MTU3_CH_NR_IRQ * MTU3_NR_CHAN   /* = 10 */
+};
+
+/* IRQ index within the per-channel group */
+enum {
+    MTU3_IRQ_TGIA = 0,
+    MTU3_IRQ_TGIB = 1,
+    MTU3_IRQ_TGIC = 2,
+    MTU3_IRQ_TGID = 3,
+    MTU3_IRQ_TCIV = 4,
+};
+
+struct RXMTU3ChanState {
+    uint8_t  tcr;
+    uint8_t  tmdr1;
+    uint8_t  tiorh;
+    uint8_t  tiorl;
+    uint8_t  tier;
+    uint8_t  tsr;
+    uint16_t tcnt;
+    uint16_t tgra;
+    uint16_t tgrb;
+    uint16_t tgrc;
+    uint16_t tgrd;
+    int64_t  tick;       /* virtual-clock time when tcnt was last latched */
+    int64_t  div_round;  /* fractional cycles accumulator */
+    QEMUTimer timer;
+};
+
+struct RXMTU3State {
+    /*< private >*/
+    SysBusDevice parent_obj;
+    /*< public >*/
+
+    MemoryRegion memory;
+    uint64_t input_freq;
+
+    uint8_t tstr; /* Timer Start Register A (offset 0x80) */
+    struct RXMTU3ChanState ch[MTU3_NR_CHAN];
+    qemu_irq irq[MTU3_NR_IRQ];
+};
+
+#endif /* HW_TIMER_RENESAS_MTU3_H */
diff --git a/include/hw/watchdog/renesas_rx_wdt.h b/include/hw/watchdog/renesas_rx_wdt.h
new file mode 100644
index 0000000000..d232f13582
--- /dev/null
+++ b/include/hw/watchdog/renesas_rx_wdt.h
@@ -0,0 +1,48 @@
+/*
+ * Renesas RX Watchdog Timers (WDT and IWDT)
+ *
+ * Datasheet: RX65N Group, RX651 Group User's Manual: Hardware
+ *            (Rev.1.00 R01UH0590EJ0100), sections 28 (WDT) and 29 (IWDT)
+ *
+ * Copyright (c) 2026 Umar, Sayyad Mahammad
+ *
+ * SPDX-License-Identifier: GPL-2.0-or-later
+ *
+ */
+
+#ifndef HW_WATCHDOG_RENESAS_RX_WDT_H
+#define HW_WATCHDOG_RENESAS_RX_WDT_H
+
+#include "hw/core/boards.h"
+#include "hw/core/sysbus.h"
+#include "qom/object.h"
+
+#define TYPE_RENESAS_RX_WDT "renesas-rx-wdt"
+typedef struct RenesasRxWdtState RenesasRxWdtState;
+DECLARE_INSTANCE_CHECKER(RenesasRxWdtState, RENESAS_RX_WDT, TYPE_RENESAS_RX_WDT)
+
+/* One block covering both WDT (0x88020) and IWDT (0x88030). */
+#define RX_WDT_REGS_SIZE    0x20
+
+struct RenesasRxWdtState {
+    /*< private >*/
+    SysBusDevice parent_obj;
+    /*< public >*/
+
+    MemoryRegion mr;
+
+    /* WDT registers. */
+    uint16_t wdtcr;
+    uint16_t wdtsr;
+    uint8_t  wdtrcr;
+    uint8_t  wdt_rr_phase;  /* tracks the 0x00 -> 0xFF refresh sequence */
+
+    /* IWDT registers. */
+    uint16_t iwdtcr;
+    uint16_t iwdtsr;
+    uint8_t  iwdtrcr;
+    uint8_t  iwdtcstpr;
+    uint8_t  iwdt_rr_phase;
+};
+
+#endif /* HW_WATCHDOG_RENESAS_RX_WDT_H */

-- 
2.53.0


