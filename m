Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0413DC54F51
	for <qemu-devel@archiver.kernel.org>; Tue, 28 Jul 2026 22:39:29 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1woqRd-0007FJ-SD; Tue, 28 Jul 2026 18:38:41 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <nodokaorganized@gmail.com>)
 id 1woqRa-0007D3-Nw
 for qemu-devel@nongnu.org; Tue, 28 Jul 2026 18:38:38 -0400
Received: from mail-yw1-x112a.google.com ([2607:f8b0:4864:20::112a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <nodokaorganized@gmail.com>)
 id 1woqRY-00027j-9R
 for qemu-devel@nongnu.org; Tue, 28 Jul 2026 18:38:38 -0400
Received: by mail-yw1-x112a.google.com with SMTP id
 00721157ae682-81ed2a06b9eso4454487b3.3
 for <qemu-devel@nongnu.org>; Tue, 28 Jul 2026 15:38:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1785278315; x=1785883115; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=sMriARsa9eOcDpZtXd4roMj5Gf+r4mB80SLKoT5xREA=;
 b=FV5OqUpsVD4ysjIzrCaBfCsRnsOyiBYcKaZnbQ8tLNGoiRcsw3ocCGnuJhxensTQvE
 5OFUZ4W92Rhr7XMcoIgvLMIIs4MKNZFPCC+ivK1VDqZFDvkAcfs9UaLO1yfnKHhDqKT4
 wWCFTPoL+yJRrpKwoQfxIbKJN3JHVYQoB4RB9SwhYpx2XOZPGZ+xkx06R9i4AhrVfOL+
 QDQe+UXpRpxa95onG46VV/zGtYUWtVFXHIlTWjfl1GvZHKTGUBliLvMnq+lajXs1+Wq/
 LqboTnfQV1xt5kai32lP4rFHdR5bWc8XoJ8emy3IFrFmdjMy7hyn2s/XGkdhD1Z7X3jx
 kD9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1785278315; x=1785883115;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=sMriARsa9eOcDpZtXd4roMj5Gf+r4mB80SLKoT5xREA=;
 b=Ko7QZG9STVDu1fqMpxP4f5Jrx0qoDgTyWm7EoekjzCf+Rkx6qyrJ3YIoVxXSA6pes0
 xaB+2SsswzhYrdCHLgEAspiUKZd6t2IlLdjUi1XD/rgblYw3fqKnej+t9rHMsDosvcbo
 RpIHe+MN1rkn+YyH1UNsGOoyuDcFvuQcIyVM2AFgojBgyAnLFIN5AbNfmMNFhlwep0I+
 hfgNwhBPmsufQVIxnpoLoAYOUxqe+lZxfHlbfJAM1MHK4DhmW7DpNF9gM4K/Vs7sf+i4
 DkYFFvZIVwp4fNiuk9zPho6cTB7V/j3+ozvRWjvIi3cq8BQU+Rnm1RLy55xNv325E9/+
 2kiQ==
X-Gm-Message-State: AOJu0Yx/FgtdBT/HSoCBDXmhLaiJzJUnf6WzjIYkDmzECZnt4fZ3Y2yl
 h941i+w5xZbCgoGPgrmZTWH5c9PedhyNrkhKIdQQvyURWhmhc7ivtkpje/fiEFoh
X-Gm-Gg: AR+sD135vN4ZXNioQ9VhIM0V8Ucurv4kovpsiytsDoApvpelbuzmgav68ZhnEUtykPr
 BA4+ULwY5iTwAImI2w4MgxnLwHR0Z+m66uz9cIET/NMWnB6ybmAiEjKVof3iM9K/HjIyrlolf/H
 C25ktvKAe29G/xzyjTr1IM5GWjxdWhGGqFsW2pg9JslUMEn1zyenYecAd3kYVQCsWm7NiY5DJKC
 IQbLRVYBbXi+dr7LYWSjPpOzLYPhsiK2cquKSkkvkyhVJlY9c5MPSsCywCOuQKJRJHPvZPjeLU4
 zgk12+aZMaSjJRG65SSItSZll79dVOOIcUASgyPCoYHfN+JFyg87rJN/fhVjDc44E7825Mt3EJS
 hYqt7IKp6x2o1dYItWQ6fk4ONy2t8XYLh65sZw29kOERnMM2mjwIX22UKj2DKJ8Z3gLH7i5AUMM
 VQidMRhCJ7NSUxKoKw83t/+NrhjYKvVefa0DLoAAYJgsU6t3NEdCzcYoGDiScZ/a391vxciXwTe
 Izn30QeAFhLcDg0oo6C6nRTRLeH0w44fh3l+/WFZN51IHSsEnL87DoGuDDk7O4qzy1UTTIPyB4o
 Y5FMyYno1eSudkCDrFZA
X-Received: by 2002:a05:690c:4b90:b0:81e:a4cf:131b with SMTP id
 00721157ae682-81f99258c81mr19974947b3.22.1785278315080; 
 Tue, 28 Jul 2026 15:38:35 -0700 (PDT)
Received: from ip-172-32-0-41.us-east-2.compute.internal
 (ec2-3-143-144-70.us-east-2.compute.amazonaws.com. [3.143.144.70])
 by smtp.gmail.com with ESMTPSA id
 00721157ae682-81fa27592e9sm7541447b3.8.2026.07.28.15.38.34
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 28 Jul 2026 15:38:34 -0700 (PDT)
From: Nodoka Shibasaki <nodokaorganized@gmail.com>
To: qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>,
 Nodoka Shibasaki <nodokaorganized@gmail.com>
Subject: [RFC PATCH v2 1/2] hw/i2c: add xlnx-axi-iic,
 a Xilinx AXI IIC controller
Date: Tue, 28 Jul 2026 22:38:28 +0000
Message-ID: <20260728223829.2613524-2-nodokaorganized@gmail.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20260728223829.2613524-1-nodokaorganized@gmail.com>
References: <20260715221400.1484805-1-nodokaorganized@gmail.com>
 <20260728223829.2613524-1-nodokaorganized@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::112a;
 envelope-from=nodokaorganized@gmail.com; helo=mail-yw1-x112a.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
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

Add a model of the AMD/Xilinx AXI IIC controller (LogiCORE IP, PG090),
an I2C bus controller. QEMU has no AXI IIC model today; this lets a guest
driver for it, and the I2C slaves behind it, be exercised without real
hardware.

The device is a SysBus device: it owns one I2C bus, decodes the AXI IIC
register map, implements the controller's dynamic transfer mode, and
drives a single level-triggered interrupt line while DGIER is enabled and
IISR & IIER is set. It has a reset handler and migration state, and a
register-level specification in docs/specs/xlnx-axi-iic.rst.

Signed-off-by: Nodoka Shibasaki <nodokaorganized@gmail.com>
---
 MAINTAINERS                   |  10 ++
 docs/specs/index.rst          |   1 +
 docs/specs/xlnx-axi-iic.rst   |  62 ++++++++
 hw/i2c/Kconfig                |   4 +
 hw/i2c/meson.build            |   1 +
 hw/i2c/xlnx-axi-iic.c         | 284 ++++++++++++++++++++++++++++++++++
 include/hw/i2c/xlnx-axi-iic.h |  69 +++++++++
 7 files changed, 431 insertions(+)
 create mode 100644 docs/specs/xlnx-axi-iic.rst
 create mode 100644 hw/i2c/xlnx-axi-iic.c
 create mode 100644 include/hw/i2c/xlnx-axi-iic.h

diff --git a/MAINTAINERS b/MAINTAINERS
index a28935c898..8339c9bf83 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -2158,6 +2158,16 @@ S: Maintained
 F: hw/misc/edu.c
 F: docs/specs/edu.rst
 
+<<<<<<< Updated upstream
+=======
+xiic-fpga-i2c
+M: Nodoka Shibasaki <nodokaorganized@gmail.com>
+S: Maintained
+F: hw/i2c/xlnx-axi-iic.c
+F: include/hw/i2c/xlnx-axi-iic.h
+F: docs/specs/xlnx-axi-iic.rst
+
+>>>>>>> Stashed changes
 IDE
 M: John Snow <jsnow@redhat.com>
 L: qemu-block@nongnu.org
diff --git a/docs/specs/index.rst b/docs/specs/index.rst
index b7909a108a..41b45a5be4 100644
--- a/docs/specs/index.rst
+++ b/docs/specs/index.rst
@@ -40,3 +40,4 @@ guest hardware that is specific to QEMU.
    riscv-aia
    aspeed-intc
    iommu-testdev
+   xlnx-axi-iic
diff --git a/docs/specs/xlnx-axi-iic.rst b/docs/specs/xlnx-axi-iic.rst
new file mode 100644
index 0000000000..a19b479522
--- /dev/null
+++ b/docs/specs/xlnx-axi-iic.rst
@@ -0,0 +1,62 @@
+.. SPDX-License-Identifier: GPL-2.0-or-later
+
+Xilinx AXI IIC device
+======================
+
+``xlnx-axi-iic`` models the AMD/Xilinx AXI IIC (LogiCORE IP, documented in
+Xilinx PG090) I2C bus controller. It is a SysBus device: a board or a parent
+device maps its single MMIO region and connects its interrupt line, and I2C
+slave models are attached to the ``i2c`` bus it creates.
+
+The model implements the controller's *dynamic* transfer mode, which is what
+a guest driver uses by default.
+
+Properties
+----------
+
+``bus-name``
+  Name given to the I2C bus the controller creates (default ``i2c``). A parent
+  device that instantiates several controllers uses this to give each bus a
+  unique, user-referenceable name.
+
+MMIO register map
+-----------------
+
+Offsets are relative to the start of the controller's MMIO region.
+
+  0x1C (RW) : DGIER, global interrupt enable (bit 31)
+  0x20 (RW) : IISR, interrupt status; write-1-to-clear
+  0x28 (RW) : IIER, interrupt enable
+  0x40 (WO) : RESETR, soft reset (write 0xA)
+  0x100 (RW) : CR, control
+  0x104 (RO) : SR, status (computed)
+  0x108 (WO) : DTR, tx data and dynamic START (bit 8) / STOP (bit 9)
+  0x10C (RO) : DRR, rx data
+  0x114 (RO) : TFO, tx FIFO occupancy (always 0; the FIFO drains immediately)
+  0x118 (RO) : RFO, rx FIFO occupancy
+  0x120 (RW) : RFD, rx FIFO programmable depth
+
+Status register (SR) bits: 0x04 bus busy, 0x20 rx FIFO full, 0x40 rx FIFO
+empty, 0x80 tx FIFO empty. Interrupt (IISR/IIER) bits: 0x01 arbitration lost,
+0x02 tx error / NACK, 0x04 tx FIFO empty, 0x08 rx FIFO full, 0x10 bus-not-busy.
+
+Dynamic-mode transfers
+----------------------
+
+The low 8 bits of a DTR write are the data byte; bit 8 (START) frames the
+8-bit address (bit 0 is the read/write flag) that opens a transfer, and bit 9
+(STOP) ends it.
+
+- Write: DTR <- addr|START, then each data byte, the last with STOP.
+- Read: DTR <- addr|START (read flag set), then DTR <- count|STOP. The
+  controller clocks ``count`` bytes from the slave into the rx FIFO, raises
+  IISR.RX_FULL, and raises IISR.BNB once the FIFO has been drained through DRR.
+
+A slave that does not acknowledge sets IISR.TX_ERROR and releases the bus.
+
+Interrupt
+---------
+
+The controller drives a single level-triggered output line, asserted while
+DGIER is enabled and ``IISR & IIER`` is non-zero, and deasserted when the guest
+clears the pending, enabled causes.
diff --git a/hw/i2c/Kconfig b/hw/i2c/Kconfig
index 0766130b59..4faf2bda99 100644
--- a/hw/i2c/Kconfig
+++ b/hw/i2c/Kconfig
@@ -43,6 +43,10 @@ config ALLWINNER_I2C
     bool
     select I2C
 
+config XLNX_AXI_IIC
+    bool
+    select I2C
+
 config PCA954X
     bool
     select I2C
diff --git a/hw/i2c/meson.build b/hw/i2c/meson.build
index 88aea35662..939f02f03b 100644
--- a/hw/i2c/meson.build
+++ b/hw/i2c/meson.build
@@ -9,6 +9,7 @@ i2c_ss.add(when: 'CONFIG_EXYNOS4', if_true: files('exynos4210_i2c.c'))
 i2c_ss.add(when: 'CONFIG_IMX_I2C', if_true: files('imx_i2c.c'))
 i2c_ss.add(when: 'CONFIG_MPC_I2C', if_true: files('mpc_i2c.c'))
 i2c_ss.add(when: 'CONFIG_ALLWINNER_I2C', if_true: files('allwinner-i2c.c'))
+i2c_ss.add(when: 'CONFIG_XLNX_AXI_IIC', if_true: files('xlnx-axi-iic.c'))
 i2c_ss.add(when: 'CONFIG_NRF51_SOC', if_true: files('microbit_i2c.c'))
 i2c_ss.add(when: 'CONFIG_NPCM7XX', if_true: files('npcm7xx_smbus.c'))
 i2c_ss.add(when: 'CONFIG_DESIGNWARE_I2C', if_true: files('designware_i2c.c'))
diff --git a/hw/i2c/xlnx-axi-iic.c b/hw/i2c/xlnx-axi-iic.c
new file mode 100644
index 0000000000..c27398c319
--- /dev/null
+++ b/hw/i2c/xlnx-axi-iic.c
@@ -0,0 +1,284 @@
+/*
+ * xlnx-axi-iic.c - QEMU model of the Xilinx AXI IIC (LogiCORE IP) controller.
+ *
+ * SPDX-License-Identifier: GPL-2.0-or-later
+ */
+
+#include "qemu/osdep.h"
+#include "qemu/log.h"
+#include "qemu/module.h"
+#include "migration/vmstate.h"
+#include "hw/core/irq.h"
+#include "hw/core/sysbus.h"
+#include "hw/core/qdev-properties.h"
+#include "hw/i2c/xlnx-axi-iic.h"
+
+static bool xlnx_axi_iic_pending(XlnxAxiIicState *s)
+{
+    if (!(s->dgier & XLNX_AXI_IIC_GINTR_ENABLE_MASK)) {
+        return false;
+    }
+    return (s->isr & s->ier) != 0;
+}
+
+static void xlnx_axi_iic_update_irq(XlnxAxiIicState *s)
+{
+    qemu_set_irq(s->irq, xlnx_axi_iic_pending(s));
+}
+
+static void xlnx_axi_iic_reset_regs(XlnxAxiIicState *s)
+{
+    if (s->in_xfer) {
+        i2c_end_transfer(s->bus);
+    }
+    s->cr = 0;
+    s->isr = 0;
+    s->ier = 0;
+    s->dgier = 0;
+    s->rfd = 0;
+    s->in_xfer = false;
+    s->is_recv = false;
+    s->stop_pending = false;
+    s->rx_len = 0;
+    s->rx_pos = 0;
+    memset(s->rx_fifo, 0, sizeof(s->rx_fifo));
+}
+
+static uint32_t xlnx_axi_iic_status(XlnxAxiIicState *s)
+{
+    uint32_t sr = XLNX_AXI_IIC_SR_TX_FIFO_EMPTY_MASK;
+
+    sr |= (s->rx_pos >= s->rx_len) ? XLNX_AXI_IIC_SR_RX_FIFO_EMPTY_MASK
+                                   : XLNX_AXI_IIC_SR_RX_FIFO_FULL_MASK;
+    if (s->in_xfer) {
+        sr |= XLNX_AXI_IIC_SR_BUS_BUSY_MASK;
+    }
+    return sr;
+}
+
+static void xlnx_axi_iic_fail(XlnxAxiIicState *s)
+{
+    i2c_end_transfer(s->bus);
+    s->in_xfer = false;
+    s->isr |= XLNX_AXI_IIC_INTR_TX_ERROR_MASK | XLNX_AXI_IIC_INTR_BNB_MASK;
+    xlnx_axi_iic_update_irq(s);
+}
+
+static uint64_t xlnx_axi_iic_read(void *opaque, hwaddr addr, unsigned size)
+{
+    XlnxAxiIicState *s = opaque;
+    bool rx_empty = s->rx_pos >= s->rx_len;
+    uint64_t val = 0;
+
+    switch (addr) {
+    case XLNX_AXI_IIC_SR:
+        val = xlnx_axi_iic_status(s);
+        break;
+    case XLNX_AXI_IIC_IISR:
+        val = s->isr;
+        break;
+    case XLNX_AXI_IIC_IIER:
+        val = s->ier;
+        break;
+    case XLNX_AXI_IIC_DGIER:
+        val = s->dgier;
+        break;
+    case XLNX_AXI_IIC_CR:
+        val = s->cr;
+        break;
+    case XLNX_AXI_IIC_RFD:
+        val = s->rfd;
+        break;
+    case XLNX_AXI_IIC_RFO:
+        val = rx_empty ? 0 : (s->rx_len - s->rx_pos - 1);
+        break;
+    case XLNX_AXI_IIC_DRR:
+        if (!rx_empty) {
+            val = s->rx_fifo[s->rx_pos++];
+            if (s->rx_pos >= s->rx_len) {
+                s->isr &= ~(uint32_t)XLNX_AXI_IIC_INTR_RX_FULL_MASK;
+                if (s->stop_pending) {
+                    s->stop_pending = false;
+                    s->in_xfer = false;
+                    s->isr |= XLNX_AXI_IIC_INTR_BNB_MASK;
+                }
+                xlnx_axi_iic_update_irq(s);
+            }
+        }
+        break;
+    default:
+        break;
+    }
+    return val;
+}
+
+static void xlnx_axi_iic_dtr_write(XlnxAxiIicState *s, uint64_t val)
+{
+    uint16_t word = val & 0xFFFF;
+    bool stop = word & XLNX_AXI_IIC_TX_DYN_STOP_MASK;
+
+    if (word & XLNX_AXI_IIC_TX_DYN_START_MASK) {
+        uint8_t addr8 = word & 0xFF;
+        s->is_recv = addr8 & 1;
+        s->rx_len = 0;
+        s->rx_pos = 0;
+
+        int nack = s->is_recv ? i2c_start_recv(s->bus, addr8 >> 1)
+                              : i2c_start_send(s->bus, addr8 >> 1);
+        s->in_xfer = true;
+        if (nack) {
+            xlnx_axi_iic_fail(s);
+        }
+        return;
+    }
+
+    if (!s->in_xfer) {
+        return;
+    }
+
+    if (s->is_recv) {
+        unsigned room = XLNX_AXI_IIC_RX_FIFO_MAX - s->rx_len;
+        unsigned n = MIN((unsigned)(word & 0xFF), room);
+
+        for (unsigned i = 0; i < n; i++) {
+            s->rx_fifo[s->rx_len++] = i2c_recv(s->bus);
+        }
+        if (stop) {
+            i2c_end_transfer(s->bus);
+            s->stop_pending = true;
+        }
+        if (s->rx_len > 0) {
+            s->isr |= XLNX_AXI_IIC_INTR_RX_FULL_MASK;
+        }
+        xlnx_axi_iic_update_irq(s);
+        return;
+    }
+
+    if (i2c_send(s->bus, word & 0xFF)) {
+        xlnx_axi_iic_fail(s);
+        return;
+    }
+    if (stop) {
+        i2c_end_transfer(s->bus);
+        s->in_xfer = false;
+        s->isr |= XLNX_AXI_IIC_INTR_TX_EMPTY_MASK | XLNX_AXI_IIC_INTR_BNB_MASK;
+    } else {
+        s->isr |= XLNX_AXI_IIC_INTR_TX_EMPTY_MASK;
+    }
+    xlnx_axi_iic_update_irq(s);
+}
+
+static void xlnx_axi_iic_write(void *opaque, hwaddr addr, uint64_t val,
+                               unsigned size)
+{
+    XlnxAxiIicState *s = opaque;
+
+    switch (addr) {
+    case XLNX_AXI_IIC_RESETR:
+        if ((val & 0xf) == XLNX_AXI_IIC_RESET_MASK) {
+            device_cold_reset(DEVICE(s));
+        }
+        break;
+    case XLNX_AXI_IIC_CR:
+        s->cr = val;
+        break;
+    case XLNX_AXI_IIC_DGIER:
+        s->dgier = val;
+        xlnx_axi_iic_update_irq(s);
+        break;
+    case XLNX_AXI_IIC_IIER:
+        s->ier = val;
+        xlnx_axi_iic_update_irq(s);
+        break;
+    case XLNX_AXI_IIC_IISR:
+        s->isr &= ~(uint32_t)val;
+        xlnx_axi_iic_update_irq(s);
+        break;
+    case XLNX_AXI_IIC_RFD:
+        s->rfd = val;
+        break;
+    case XLNX_AXI_IIC_DTR:
+        xlnx_axi_iic_dtr_write(s, val);
+        break;
+    default:
+        break;
+    }
+}
+
+static const MemoryRegionOps xlnx_axi_iic_ops = {
+    .read = xlnx_axi_iic_read,
+    .write = xlnx_axi_iic_write,
+    .endianness = DEVICE_LITTLE_ENDIAN,
+    .impl  = { .min_access_size = 1, .max_access_size = 4 },
+    .valid = { .min_access_size = 1, .max_access_size = 4 },
+};
+
+static void xlnx_axi_iic_realize(DeviceState *dev, Error **errp)
+{
+    XlnxAxiIicState *s = XLNX_AXI_IIC(dev);
+
+    memory_region_init_io(&s->mmio, OBJECT(s), &xlnx_axi_iic_ops, s,
+                          TYPE_XLNX_AXI_IIC, XLNX_AXI_IIC_REGS_SIZE);
+    sysbus_init_mmio(SYS_BUS_DEVICE(dev), &s->mmio);
+    sysbus_init_irq(SYS_BUS_DEVICE(dev), &s->irq);
+    s->bus = i2c_init_bus(dev, s->bus_name ? s->bus_name : "i2c");
+}
+
+static void xlnx_axi_iic_reset_hold(Object *obj, ResetType type)
+{
+    XlnxAxiIicState *s = XLNX_AXI_IIC(obj);
+
+    xlnx_axi_iic_reset_regs(s);
+    xlnx_axi_iic_update_irq(s);
+}
+
+static const VMStateDescription vmstate_xlnx_axi_iic = {
+    .name = TYPE_XLNX_AXI_IIC,
+    .version_id = 1,
+    .minimum_version_id = 1,
+    .fields = (const VMStateField[]) {
+        VMSTATE_UINT32(cr, XlnxAxiIicState),
+        VMSTATE_UINT32(isr, XlnxAxiIicState),
+        VMSTATE_UINT32(ier, XlnxAxiIicState),
+        VMSTATE_UINT32(dgier, XlnxAxiIicState),
+        VMSTATE_UINT32(rfd, XlnxAxiIicState),
+        VMSTATE_BOOL(in_xfer, XlnxAxiIicState),
+        VMSTATE_BOOL(is_recv, XlnxAxiIicState),
+        VMSTATE_BOOL(stop_pending, XlnxAxiIicState),
+        VMSTATE_UINT8_ARRAY(rx_fifo, XlnxAxiIicState, XLNX_AXI_IIC_RX_FIFO_MAX),
+        VMSTATE_INT32(rx_len, XlnxAxiIicState),
+        VMSTATE_INT32(rx_pos, XlnxAxiIicState),
+        VMSTATE_END_OF_LIST()
+    }
+};
+
+static const Property xlnx_axi_iic_props[] = {
+    DEFINE_PROP_STRING("bus-name", XlnxAxiIicState, bus_name),
+};
+
+static void xlnx_axi_iic_class_init(ObjectClass *klass, const void *data)
+{
+    DeviceClass *dc = DEVICE_CLASS(klass);
+    ResettableClass *rc = RESETTABLE_CLASS(klass);
+
+    dc->realize = xlnx_axi_iic_realize;
+    dc->vmsd = &vmstate_xlnx_axi_iic;
+    rc->phases.hold = xlnx_axi_iic_reset_hold;
+    dc->desc = "Xilinx AXI IIC controller";
+    set_bit(DEVICE_CATEGORY_MISC, dc->categories);
+    device_class_set_props(dc, xlnx_axi_iic_props);
+}
+
+static const TypeInfo xlnx_axi_iic_info = {
+    .name          = TYPE_XLNX_AXI_IIC,
+    .parent        = TYPE_SYS_BUS_DEVICE,
+    .instance_size = sizeof(XlnxAxiIicState),
+    .class_init    = xlnx_axi_iic_class_init,
+};
+
+static void xlnx_axi_iic_register_types(void)
+{
+    type_register_static(&xlnx_axi_iic_info);
+}
+
+type_init(xlnx_axi_iic_register_types)
diff --git a/include/hw/i2c/xlnx-axi-iic.h b/include/hw/i2c/xlnx-axi-iic.h
new file mode 100644
index 0000000000..daa65c4140
--- /dev/null
+++ b/include/hw/i2c/xlnx-axi-iic.h
@@ -0,0 +1,69 @@
+/* SPDX-License-Identifier: GPL-2.0-or-later */
+
+#ifndef HW_I2C_XLNX_AXI_IIC_H
+#define HW_I2C_XLNX_AXI_IIC_H
+
+#include "hw/core/sysbus.h"
+#include "hw/i2c/i2c.h"
+#include "qom/object.h"
+
+#define TYPE_XLNX_AXI_IIC "xlnx-axi-iic"
+OBJECT_DECLARE_SIMPLE_TYPE(XlnxAxiIicState, XLNX_AXI_IIC)
+
+#define XLNX_AXI_IIC_REGS_SIZE      0x1000
+#define XLNX_AXI_IIC_RX_FIFO_MAX    256
+
+#define XLNX_AXI_IIC_DGIER          0x1C
+#define XLNX_AXI_IIC_IISR           0x20
+#define XLNX_AXI_IIC_IIER           0x28
+#define XLNX_AXI_IIC_RESETR         0x40
+#define XLNX_AXI_IIC_CR             0x100
+#define XLNX_AXI_IIC_SR             0x104
+#define XLNX_AXI_IIC_DTR            0x108
+#define XLNX_AXI_IIC_DRR            0x10C
+#define XLNX_AXI_IIC_TFO            0x114
+#define XLNX_AXI_IIC_RFO            0x118
+#define XLNX_AXI_IIC_RFD            0x120
+
+#define XLNX_AXI_IIC_RESET_MASK             0xA
+
+#define XLNX_AXI_IIC_SR_BUS_BUSY_MASK       0x04
+#define XLNX_AXI_IIC_SR_RX_FIFO_FULL_MASK   0x20
+#define XLNX_AXI_IIC_SR_RX_FIFO_EMPTY_MASK  0x40
+#define XLNX_AXI_IIC_SR_TX_FIFO_EMPTY_MASK  0x80
+
+#define XLNX_AXI_IIC_INTR_ARB_LOST_MASK     0x01
+#define XLNX_AXI_IIC_INTR_TX_ERROR_MASK     0x02
+#define XLNX_AXI_IIC_INTR_TX_EMPTY_MASK     0x04
+#define XLNX_AXI_IIC_INTR_RX_FULL_MASK      0x08
+#define XLNX_AXI_IIC_INTR_BNB_MASK          0x10
+
+#define XLNX_AXI_IIC_GINTR_ENABLE_MASK      0x80000000UL
+
+#define XLNX_AXI_IIC_TX_DYN_START_MASK      0x0100
+#define XLNX_AXI_IIC_TX_DYN_STOP_MASK       0x0200
+
+struct XlnxAxiIicState {
+    SysBusDevice parent_obj;
+
+    MemoryRegion mmio;
+    qemu_irq irq;
+    I2CBus *bus;
+    char *bus_name;
+
+    uint32_t cr;
+    uint32_t isr;
+    uint32_t ier;
+    uint32_t dgier;
+    uint32_t rfd;
+
+    bool in_xfer;
+    bool is_recv;
+    bool stop_pending;
+
+    uint8_t rx_fifo[XLNX_AXI_IIC_RX_FIFO_MAX];
+    int rx_len;
+    int rx_pos;
+};
+
+#endif
-- 
2.50.1


