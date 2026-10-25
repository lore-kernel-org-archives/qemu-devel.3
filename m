Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 50B9E606A31B
	for <qemu-devel@archiver.kernel.org>; Sun, 25 Oct 2026 17:33:54 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xL26Q-00043I-IH; Sun, 25 Oct 2026 13:33:50 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <contact@sayyadumar.com>)
 id 1xL24U-0001Oh-JK; Sun, 25 Oct 2026 13:31:51 -0400
Received: from www675.your-server.de ([85.10.213.182])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <contact@sayyadumar.com>)
 id 1xL24S-0007LO-Fd; Sun, 25 Oct 2026 13:31:50 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sayyadumar.com; s=default2511; h=Cc:To:In-Reply-To:References:Message-Id:
 Content-Transfer-Encoding:Content-Type:MIME-Version:Subject:Date:From:Sender:
 Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender
 :Resent-To:Resent-Cc:Resent-Message-ID;
 bh=b8zcLnUCgyvS4u+OLphx6okTNB3Pa3TDXvdplNceGFA=; b=R9ZYui6W6cbpdepO2lM1S5iQtH
 QudsHprRT+sqReLaFqCXY431lMkmShw8lWuKW1ABqbIESdlsMQ4rYmCoTQUhwU7P6sckeg4mBhmlg
 Uj0RPWrhm5pIvcnixTYEXBPWYnlXNvD6oP0jSyNj4k0er1Zc6eIn+2OB9nbBQ58MBwBMwwZ06XYwI
 q7OBeYucLdzkMWJOrWPlgtrbrEK1uRSo2i4kCrqIZsRNX4psmBO2eOwlUGJAgeqEck2Bhimxb+RFh
 5CAH0qC7zkuNrW4xd3Mj4JDps53SOLZ1n/bklNvS6dXjflVvCv+8ubYyMhHPLERjlVLaznL+BK96a
 9JeLLl+w==;
Received: from sslproxy01.your-server.de ([78.46.139.224])
 by www675.your-server.de with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
 (Exim 4.96.2) (envelope-from <contact@sayyadumar.com>)
 id 1xL1gL-00096r-03; Sun, 25 Oct 2026 18:06:53 +0100
Received: from localhost ([127.0.0.1])
 by sslproxy01.your-server.de with esmtpsa (TLS1.3) tls TLS_AES_256_GCM_SHA384
 (Exim 4.96) (envelope-from <contact@sayyadumar.com>)
 id 1xL1Vx-000OzG-0q; Sun, 25 Oct 2026 17:56:08 +0100
From: Sayyad Mahammad Umar <contact@sayyadumar.com>
Date: Sun, 25 Oct 2026 17:55:45 +0100
Subject: [PATCH v2 29/31] hw/misc: add RX65N clock generation circuit
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261025-umar-rx-series-v2-29-9e846577cad0@sayyadumar.com>
References: <20261025-umar-rx-series-v2-0-9e846577cad0@sayyadumar.com>
In-Reply-To: <20261025-umar-rx-series-v2-0-9e846577cad0@sayyadumar.com>
To: qemu-devel@nongnu.org
Cc: Yoshinori Sato <yoshinori.sato@nifty.com>, 
 Alistair Francis <alistair@alistair23.me>, 
 Peter Maydell <peter.maydell@linaro.org>, Jason Wang <jasowangio@gmail.com>, 
 qemu-arm@nongnu.org, Sayyad Mahammad Umar <contact@sayyadumar.com>, 
 Paolo Bonzini <pbonzini@redhat.com>
X-Mailer: b4 0.16.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1792947366; l=10408;
 i=contact@sayyadumar.com; s=qemu; h=from:subject:message-id;
 bh=NzCYOrdd2OTOdcA2guOmtLgbBgHxoUHcxH+Gf88AU/w=;
 b=kFtvmD7bG5aMb3mQ0IA0sAgoWLrtrRfQlt5jfz0gJ3Q9tbla2JZdrsGPDAtke6ZRHyOBBBsmx
 WxfS+aTdCPsCTonIUF7Xv3CmQzQT8mdu90vPxgvVi+lJyRctERyDLQ7
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
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Add the RX65N SYSTEM clock generation circuit, section 9 of the RX65N
hardware manual.

Signed-off-by: Sayyad Mahammad Umar <contact@sayyadumar.com>
---
 MAINTAINERS                            |   2 +
 configs/devices/rx-softmmu/default.mak |   1 +
 hw/misc/Kconfig                        |   3 +
 hw/misc/meson.build                    |   1 +
 hw/misc/rx65n_sysclk.c                 | 190 +++++++++++++++++++++++++++++++++
 include/hw/misc/rx65n_sysclk.h         |  37 +++++++
 6 files changed, 234 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index 8ba36637f2..6af2849a1a 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -3089,6 +3089,7 @@ F: hw/intc/rx_icu.c
 F: hw/misc/renesas_rx_*.c
 F: hw/misc/renesas_rx_romcache.c
 F: hw/misc/renesas_rx_fcu.c
+F: hw/misc/rx65n_sysclk.c
 F: hw/rtc/renesas_rx_rtc.c
 F: hw/rx/
 F: hw/ssi/renesas_rspi.c
@@ -3101,6 +3102,7 @@ F: include/hw/intc/rx_icu.h
 F: include/hw/misc/renesas_rx_*.h
 F: include/hw/misc/renesas_rx_romcache.h
 F: include/hw/misc/renesas_rx_fcu.h
+F: include/hw/misc/rx65n_sysclk.h
 F: include/hw/rtc/renesas_rx_rtc.h
 F: include/hw/rx/
 F: include/hw/ssi/renesas_rspi.h
diff --git a/configs/devices/rx-softmmu/default.mak b/configs/devices/rx-softmmu/default.mak
index bd7ba03f57..562dce7b85 100644
--- a/configs/devices/rx-softmmu/default.mak
+++ b/configs/devices/rx-softmmu/default.mak
@@ -12,3 +12,4 @@ CONFIG_RENESAS_RX_RTC=y
 CONFIG_RENESAS_RX_CRC=y
 CONFIG_RENESAS_RX_ROMCACHE=y
 CONFIG_RENESAS_RX_FCU=y
+CONFIG_RX65N_SYSCLK=y
diff --git a/hw/misc/Kconfig b/hw/misc/Kconfig
index 75282d49be..8ec388b401 100644
--- a/hw/misc/Kconfig
+++ b/hw/misc/Kconfig
@@ -276,3 +276,6 @@ config RENESAS_RX_ROMCACHE
 
 config RENESAS_RX_FCU
     bool
+
+config RX65N_SYSCLK
+    bool
diff --git a/hw/misc/meson.build b/hw/misc/meson.build
index 8604f4ad21..b910b17814 100644
--- a/hw/misc/meson.build
+++ b/hw/misc/meson.build
@@ -184,3 +184,4 @@ system_ss.add(when: 'CONFIG_AXIADO_CLK', if_true: files('axiado_clk.c'))
 system_ss.add(when: 'CONFIG_RENESAS_RX_CRC', if_true: files('renesas_rx_crc.c'))
 system_ss.add(when: 'CONFIG_RENESAS_RX_ROMCACHE', if_true: files('renesas_rx_romcache.c'))
 system_ss.add(when: 'CONFIG_RENESAS_RX_FCU', if_true: files('renesas_rx_fcu.c'))
+system_ss.add(when: 'CONFIG_RX65N_SYSCLK', if_true: files('rx65n_sysclk.c'))
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

-- 
2.53.0


