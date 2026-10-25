Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE1DA606A31A
	for <qemu-devel@archiver.kernel.org>; Sun, 25 Oct 2026 17:33:57 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xL268-0003bM-PF; Sun, 25 Oct 2026 13:33:33 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <contact@sayyadumar.com>)
 id 1xL24s-00020U-26; Sun, 25 Oct 2026 13:32:24 -0400
Received: from www675.your-server.de ([85.10.213.182])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <contact@sayyadumar.com>)
 id 1xL24p-0007Ms-CT; Sun, 25 Oct 2026 13:32:13 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sayyadumar.com; s=default2511; h=Cc:To:In-Reply-To:References:Message-Id:
 Content-Transfer-Encoding:Content-Type:MIME-Version:Subject:Date:From:Sender:
 Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender
 :Resent-To:Resent-Cc:Resent-Message-ID;
 bh=GxJrCy/LdeDAONZG12nA19YVEW5dzWPG1qWZXEC0Bn0=; b=CAbFIGWLim+3n5Gs+WvhNEaxBK
 8LztGE2K5MjlDTDwShWlASsJ0sKhSpWHIQYXqr4KHfH3k4bb94xtBunSCKxnkOgWQmEO+qu5tJ+t9
 mstGX5PvYyWODc44NRG7DbooX3jdcDlvBpVugPmUALK/1p8eZkntvnTLWKA7S6EWIa71+j7O0IIp5
 A7TjTxIZPzDMkStnzFpXVWhHLixczQqEhlh6+xaWVYQk25efvrFj945yVQed3MZtWw1kWd5ONOlWP
 aitrDN0rHsH1tWobf/yvCW0jCpXTgckv73mvj1tig/a8Cq5k3Y7t0pcBMnN1+vkNn+Bb+fREJuMej
 lkYtf2HA==;
Received: from sslproxy01.your-server.de ([78.46.139.224])
 by www675.your-server.de with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
 (Exim 4.96.2) (envelope-from <contact@sayyadumar.com>)
 id 1xL1gP-00097n-1w; Sun, 25 Oct 2026 18:06:57 +0100
Received: from localhost ([127.0.0.1])
 by sslproxy01.your-server.de with esmtpsa (TLS1.3) tls TLS_AES_256_GCM_SHA384
 (Exim 4.96) (envelope-from <contact@sayyadumar.com>)
 id 1xL1Vw-000OzG-2W; Sun, 25 Oct 2026 17:56:08 +0100
From: Sayyad Mahammad Umar <contact@sayyadumar.com>
Date: Sun, 25 Oct 2026 17:55:39 +0100
Subject: [PATCH v2 23/31] hw/adc: add Renesas RX S12AD
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20261025-umar-rx-series-v2-23-9e846577cad0@sayyadumar.com>
References: <20261025-umar-rx-series-v2-0-9e846577cad0@sayyadumar.com>
In-Reply-To: <20261025-umar-rx-series-v2-0-9e846577cad0@sayyadumar.com>
To: qemu-devel@nongnu.org
Cc: Yoshinori Sato <yoshinori.sato@nifty.com>, 
 Alistair Francis <alistair@alistair23.me>, 
 Peter Maydell <peter.maydell@linaro.org>, Jason Wang <jasowangio@gmail.com>, 
 qemu-arm@nongnu.org, Sayyad Mahammad Umar <contact@sayyadumar.com>, 
 Paolo Bonzini <pbonzini@redhat.com>
X-Mailer: b4 0.16.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1792947366; l=14830;
 i=contact@sayyadumar.com; s=qemu; h=from:subject:message-id;
 bh=mXNG5bfdB0ucEzpAoK3TRQluqD0DgUtKo7c7wbd5deY=;
 b=om/kPpwZRbotmeMwu/aWRtZhewl2l17bNgM9f9ddt9WxBiZQbzv2Zhy+a+HQFkVhY6bETpYzD
 Yh0EUoaUZVsCosecIB1Fa3sOoSsea5DsFGb4jt2dAGDCYIQUzpjTFk2
X-Developer-Key: i=contact@sayyadumar.com; a=ed25519;
 pk=CsAjTLRCB7+pnzmj8902JER4gL8CTzNQFxlMZTl4wDk=
X-Virus-Scanned: Clear (ClamAV 1.4.6/28164/Sun Oct 25 07:24:12 2026)
Received-SPF: pass client-ip=85.10.213.182;
 envelope-from=contact@sayyadumar.com; helo=www675.your-server.de
X-Spam_score_int: -16
X-Spam_score: -1.7
X-Spam_bar: -
X-Spam_report: (-1.7 / 5.0 requ) BAYES_00=-1.9, DKIM_INVALID=0.1,
 DKIM_SIGNED=0.1, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
X-Spam-Status: No, score=-16.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Add the 12-bit successive approximation A/D converter, Section 40 of
the RX65N hardware manual.

Signed-off-by: Sayyad Mahammad Umar <contact@sayyadumar.com>
---
 MAINTAINERS                            |   2 +
 configs/devices/rx-softmmu/default.mak |   1 +
 hw/adc/Kconfig                         |   3 +
 hw/adc/meson.build                     |   1 +
 hw/adc/renesas_s12ad.c                 | 324 +++++++++++++++++++++++++++++++++
 include/hw/adc/renesas_s12ad.h         |  61 +++++++
 6 files changed, 392 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index e747530308..8f552c69cc 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -3081,12 +3081,14 @@ F: include/hw/timer/renesas_*.h
 Renesas RX peripherals
 R: Yoshinori Sato <yoshinori.sato@nifty.com>
 S: Orphan
+F: hw/adc/renesas_s12ad.c
 F: hw/dma/renesas_rx_*.c
 F: hw/dma/renesas_rx_dtc.c
 F: hw/gpio/renesas_rx_gpio.c
 F: hw/intc/rx_icu.c
 F: hw/rx/
 F: hw/timer/renesas_mtu3.c
+F: include/hw/adc/renesas_s12ad.h
 F: include/hw/dma/renesas_rx_*.h
 F: include/hw/dma/renesas_rx_dtc.h
 F: include/hw/gpio/renesas_rx_gpio.h
diff --git a/configs/devices/rx-softmmu/default.mak b/configs/devices/rx-softmmu/default.mak
index 9e0e1ef31d..59f124f0d3 100644
--- a/configs/devices/rx-softmmu/default.mak
+++ b/configs/devices/rx-softmmu/default.mak
@@ -6,3 +6,4 @@ CONFIG_RENESAS_MTU3=y
 CONFIG_RENESAS_RX_GPIO=y
 CONFIG_RENESAS_RX_DMAC=y
 CONFIG_RENESAS_RX_DTC=y
+CONFIG_RENESAS_S12AD=y
diff --git a/hw/adc/Kconfig b/hw/adc/Kconfig
index 25d2229fb8..cfe2c48262 100644
--- a/hw/adc/Kconfig
+++ b/hw/adc/Kconfig
@@ -1,2 +1,5 @@
 config STM32F2XX_ADC
     bool
+
+config RENESAS_S12AD
+    bool
diff --git a/hw/adc/meson.build b/hw/adc/meson.build
index 7f7acc1619..446cd3a3f0 100644
--- a/hw/adc/meson.build
+++ b/hw/adc/meson.build
@@ -2,3 +2,4 @@ system_ss.add(when: 'CONFIG_STM32F2XX_ADC', if_true: files('stm32f2xx_adc.c'))
 system_ss.add(when: 'CONFIG_ASPEED_SOC', if_true: files('aspeed_adc.c'))
 system_ss.add(when: 'CONFIG_NPCM7XX', if_true: files('npcm7xx_adc.c'))
 system_ss.add(when: 'CONFIG_ZYNQ', if_true: files('zynq-xadc.c'))
+system_ss.add(when: 'CONFIG_RENESAS_S12AD', if_true: files('renesas_s12ad.c'))
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

-- 
2.53.0


