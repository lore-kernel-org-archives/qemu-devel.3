Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D558CC5B56A
	for <qemu-devel@archiver.kernel.org>; Tue, 11 Aug 2026 14:37:16 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wtnaZ-0000M7-KA; Tue, 11 Aug 2026 10:36:25 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcelomanzo@gmail.com>)
 id 1wtnaI-0000HF-Rm
 for qemu-devel@nongnu.org; Tue, 11 Aug 2026 10:36:06 -0400
Received: from mail-qt1-x832.google.com ([2607:f8b0:4864:20::832])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <marcelomanzo@gmail.com>)
 id 1wtnaG-0001rV-EV
 for qemu-devel@nongnu.org; Tue, 11 Aug 2026 10:36:06 -0400
Received: by mail-qt1-x832.google.com with SMTP id
 d75a77b69052e-51c0cea8883so8898141cf.1
 for <qemu-devel@nongnu.org>; Tue, 11 Aug 2026 07:36:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1786458963; x=1787063763; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=xUCaDY/np0WAstzilj/aRxu/YjTtEwlLG0s9zckn39E=;
 b=Wk6qyPE7//WuTKp7itmwKCectCLrzx0MdfVuIJadfUj6RB6b/zW1ma3rhRPiH/0IyL
 AubL6P4BVfXGigE6jgHBAqlSip13CVXMVJh7QeAuyuEQ3kuHBwm4/JrFOH1+LBf5AYf9
 dF/crBU5ao8A6giq8iDr/gIbnNeDO9dcKAuv6vPaIIgqk1icRyIQ1hQLxk4vql8Mu/XZ
 aY1wzHHLvYYAcrQMoJWkBGdRcX0oIxKUNA07iAb5BL2v1Bq7VMfu1Mw+svtEf2f4G+Xe
 JZ50FyjRwieTdhGo4zM2ASm/6yaBMLRIzsyg1Re/Nlmlo+ZcgCwlYVli5u1hVy5lJMaF
 H8/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1786458963; x=1787063763;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=xUCaDY/np0WAstzilj/aRxu/YjTtEwlLG0s9zckn39E=;
 b=jdzDj94q4nR9EEfBNbJnJ22TTT59hOweDD0XGGRIswxyeJK7lSYV8cWmsEPlkd5qLX
 nN5wp15m9VO6hbSyQsLHllpoehAhGpzK5q1Cxl9Xn2AxUo/WUA8PWze5qBYW4qudbxDG
 xmeS0kKiTJF2QmNWwv/hnvMCKG1T5fLAKQdTesqsBCbjGuVx4SZLsPJ31dzoQlpXQwoe
 kOxASxNzS2/w20O4s8Cnx6ITNfXuAyc8QIvtrx3fXPHQYovDptFKpBSpZZZSLUc7pH4K
 6MBg5+JicL7XtUERSGTg5AJ38iFNrj1CIaPwHZo1X5XRypATpOvKywYshq0xPAEWbPYy
 nP6Q==
X-Gm-Message-State: AOJu0YxktSEObQtsSdqjH4gOhefk+uRD8tsU6HMxdG73vHmdtTtWaaf1
 aehpotQEK23tVEXTLKQOno7ym8P9+mnAZHdLf/Kaxfwkt0mE694yx2UffPoFvg==
X-Gm-Gg: AR+sD13MD2hsTwRa2EiTMQBVZpLMx19PYkIwHxIyniV8gY0a4CxTp6tc6/hbJQWHheh
 fPIEpyPGdVcDCkj/wfn6RT5aoWd1RNR+jCHsmRJXXviHAaioBWEqCh18TSfSMUsTxoQt5oRK0J2
 J44F4m/J7Bs2l9JBvmdtJgW1LFQIoGaqFVblCk0OoCbi5aCc5QIEAK0pazehl8ZMDlqu2SDF1Rd
 v6BSFPlZlUF0vsWAtHneTKSsl15tSvh3CnMu66lL4RzrKFXLlT3Kwn7DTgna5P6IWX2nVoyHCZu
 8uoi1xH+agGct8TgVc9lc9oah25fxwMtGZVj4zwGdiy5wXB5ecn57xLI0dyThHmeRUFGYaIjLi5
 zl6Lp0wmn7nkSOtjmhUgx9INKJ8zVUCpUR4odQRjW+vJeGxU+++zatqLhJDbRSqbnX/CDwt3ZfR
 J/FkbiYWX48m2sJi00wqHvv3wl8BcmKTzt5Epu7Z39cz/Q+NhTmqRR6zrPrlcobTLsLHlGbmyNS
 4dfX4qok58Wznnkq5w=
X-Received: by 2002:ac8:7dc1:0:b0:52d:3483:ed0a with SMTP id
 d75a77b69052e-52d6030e1femr5395411cf.18.1786458963329; 
 Tue, 11 Aug 2026 07:36:03 -0700 (PDT)
Received: from localhost.localdomain ([198.16.145.87])
 by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-90a6c26e074sm681286d6.2.2026.08.11.07.36.02
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Tue, 11 Aug 2026 07:36:02 -0700 (PDT)
From: Marcelo Manzo <marcelomanzo@gmail.com>
To: qemu-devel@nongnu.org,
	qemu-arm@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>,
 Marcelo Manzo <marcelomanzo@gmail.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@mailo.com>,
 Jason Wang <jasowangio@gmail.com>
Subject: [PATCH v2 04/19] hw/net/bcm2838_genet: add GENET stub device
Date: Tue, 11 Aug 2026 10:35:41 -0400
Message-ID: <20260811143557.7862-5-marcelomanzo@gmail.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20260811143557.7862-1-marcelomanzo@gmail.com>
References: <20260811143557.7862-1-marcelomanzo@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::832;
 envelope-from=marcelomanzo@gmail.com; helo=mail-qt1-x832.google.com
X-Spam_score_int: -10
X-Spam_score: -1.1
X-Spam_bar: -
X-Spam_report: (-1.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FORGED_GMAIL_RCVD=1,
 FREEMAIL_FROM=0.001, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

Add a bare-bones BCM2838 GENET (Gigabit Ethernet) sysbus device:
MMIO region registration, an out-of-range read/write handler that
just logs, and a reset callback. No register-level behavior yet;
that comes in the following patches.

Adapted from patch 19/41 of Sergey Kambalin's Raspberry Pi 4B
series (patchwork series 829638) against current QEMU master. The
reset callback and class_init() use the current Resettable-phases
API (ResettableClass / resettable_class_set_parent_phases()) rather
than the plain DeviceClass::reset hook the original patch used, and
headers moved under hw/core/, both API changes since the series was
originally posted.

Signed-off-by: Marcelo Manzo <marcelomanzo@gmail.com>
---
 hw/net/bcm2838_genet.c               | 103 +++++++++++++++++++++++++++
 hw/net/meson.build                   |   2 +
 hw/net/trace-events                  |  16 +++++
 include/hw/arm/bcm2838_peripherals.h |   2 +
 include/hw/net/bcm2838_genet.h       |  40 +++++++++++
 5 files changed, 163 insertions(+)
 create mode 100644 hw/net/bcm2838_genet.c
 create mode 100644 include/hw/net/bcm2838_genet.h

diff --git a/hw/net/bcm2838_genet.c b/hw/net/bcm2838_genet.c
new file mode 100644
index 0000000000..2ff93a3417
--- /dev/null
+++ b/hw/net/bcm2838_genet.c
@@ -0,0 +1,103 @@
+/*
+ * BCM2838 Gigabit Ethernet emulation
+ *
+ * Copyright (C) 2022 Ovchinnikov Vitalii <vitalii.ovchinnikov@auriga.com>
+ *
+ * SPDX-License-Identifier: GPL-2.0-or-later
+ */
+
+#include "qemu/osdep.h"
+#include "qemu/module.h"
+#include "qemu/log.h"
+#include "qemu/error-report.h"
+#include "net/eth.h"
+#include "qapi/error.h"
+#include "hw/core/irq.h"
+#include "net/checksum.h"
+#include "system/dma.h"
+#include "hw/core/resettable.h"
+#include "hw/net/bcm2838_genet.h"
+#include "trace.h"
+
+
+static uint64_t bcm2838_genet_read(void *opaque, hwaddr offset, unsigned size)
+{
+    uint64_t value = ~0;
+
+    qemu_log_mask(
+        LOG_GUEST_ERROR,
+        "%s: out-of-range access, %u bytes @ offset 0x%04" PRIx64 "\n",
+        __func__, size, offset);
+
+    trace_bcm2838_genet_read(size, offset, value);
+    return value;
+}
+
+static void bcm2838_genet_write(void *opaque, hwaddr offset, uint64_t value,
+                                unsigned size) {
+    qemu_log_mask(
+        LOG_GUEST_ERROR,
+        "%s: out-of-range access, %u bytes @ offset 0x%04" PRIx64 "\n",
+        __func__, size, offset);
+}
+
+static const MemoryRegionOps bcm2838_genet_ops = {
+    .read = bcm2838_genet_read,
+    .write = bcm2838_genet_write,
+    .endianness = DEVICE_LITTLE_ENDIAN,
+    .impl = {.max_access_size = 4},
+    .valid = {.min_access_size = 4},
+};
+
+
+static void bcm2838_genet_realize(DeviceState *dev, Error **errp)
+{
+    BCM2838GenetState *s = BCM2838_GENET(dev);
+    SysBusDevice *sbd = SYS_BUS_DEVICE(dev);
+
+    /* Controller registers */
+    memory_region_init_io(&s->regs_mr, OBJECT(s), &bcm2838_genet_ops, s,
+                          "bcm2838_genet_regs", sizeof(s->regs));
+    sysbus_init_mmio(sbd, &s->regs_mr);
+}
+
+static void bcm2838_genet_phy_reset(BCM2838GenetState *s)
+{
+    trace_bcm2838_genet_phy_reset("done");
+}
+
+static void bcm2838_genet_reset(Object *obj, ResetType type)
+{
+    BCM2838GenetState *s = BCM2838_GENET(obj);
+
+    memset(&s->regs, 0x00, sizeof(s->regs));
+
+    trace_bcm2838_genet_reset("done");
+
+    bcm2838_genet_phy_reset(s);
+}
+
+static void bcm2838_genet_class_init(ObjectClass *class, const void *data)
+{
+    static ResettablePhases unused_parent_phases;
+    DeviceClass *dc = DEVICE_CLASS(class);
+    ResettableClass *rc = RESETTABLE_CLASS(class);
+
+    dc->realize = bcm2838_genet_realize;
+    resettable_class_set_parent_phases(rc, NULL, bcm2838_genet_reset, NULL,
+                                       &unused_parent_phases);
+}
+
+static const TypeInfo bcm2838_genet_info = {
+    .name       = TYPE_BCM2838_GENET,
+    .parent     = TYPE_SYS_BUS_DEVICE,
+    .instance_size = sizeof(BCM2838GenetState),
+    .class_init = bcm2838_genet_class_init,
+};
+
+static void bcm2838_genet_register(void)
+{
+    type_register_static(&bcm2838_genet_info);
+}
+
+type_init(bcm2838_genet_register)
diff --git a/hw/net/meson.build b/hw/net/meson.build
index 84f142df22..e290e1796b 100644
--- a/hw/net/meson.build
+++ b/hw/net/meson.build
@@ -69,4 +69,6 @@ system_ss.add(when: 'CONFIG_ROCKER', if_true: files(
 stub_ss.add(files('rocker/rocker-stubs.c'))
 system_ss.add(files('rocker/rocker-hmp-cmds.c'))
 
+system_ss.add(when: 'CONFIG_RASPI', if_true: files('bcm2838_genet.c'))
+
 subdir('can')
diff --git a/hw/net/trace-events b/hw/net/trace-events
index 001a20b0e2..2dde33e892 100644
--- a/hw/net/trace-events
+++ b/hw/net/trace-events
@@ -528,3 +528,19 @@ xen_netdev_rx(int dev, int idx, int status, int flags) "vif%u idx %d status %d f
 ethlite_pkt_lost(uint32_t rx_ctrl) "rx_ctrl:0x%" PRIx32
 ethlite_pkt_size_too_big(uint64_t size) "size:0x%" PRIx64
 ethlite_pkt_tx_size_too_big(uint64_t size) "size:0x%" PRIx64
+# bcm2838_genet.c
+bcm2838_genet_read(unsigned int size, uint64_t offset, uint64_t value) "%u bytes @ 0x%04" PRIx64 ": 0x%016" PRIx64
+bcm2838_genet_write(unsigned int size, uint64_t offset, uint64_t value) "%u bytes @ 0x%04" PRIx64 ": 0x%016" PRIx64
+bcm2838_genet_can_receive(const char *state) "receive is %s"
+bcm2838_genet_receive(ssize_t bytes_received) "%zd bytes received"
+bcm2838_genet_phy_update_link(const char *link_state) "link is %s"
+bcm2838_genet_phy_reset(const char *status) "PHY reset %s"
+bcm2838_genet_reset(const char *status) "MAC reset %s"
+bcm2838_genet_mac_address(const char *info) "%s"
+bcm2838_genet_tx_dma(const char *dma_state) "TX DMA %s"
+bcm2838_genet_tx_dma_ring(uint32_t ring_en) "TX DMA enabled rings: 0x%05x"
+bcm2838_genet_tx_dma_ring_buf(uint32_t ring_buf_en) "TX DMA enabled ring buffers: 0x%05x"
+bcm2838_genet_tx_dma_ring_active(unsigned int ring, const char *ring_state) "ring %u is %s"
+bcm2838_genet_tx_request(unsigned int ring_idx, uint32_t prod_idx, uint32_t cons_idx) "ring %u, PROD_INDEX %u, CONS_INDEX %u"
+bcm2838_genet_tx(unsigned int ring_idx, uint64_t desc_idx, uint32_t desc_status, uint64_t data_addr) "ring %u, descriptor %" PRIu64 ": 0x%08x, data @ 0x%08" PRIx64
+bcm2838_genet_rx_dma_ring_active(unsigned int ring, const char *ring_state) "ring %u is %s"
diff --git a/include/hw/arm/bcm2838_peripherals.h b/include/hw/arm/bcm2838_peripherals.h
index 7fe92789e8..2a4307bed7 100644
--- a/include/hw/arm/bcm2838_peripherals.h
+++ b/include/hw/arm/bcm2838_peripherals.h
@@ -52,6 +52,8 @@
 #define BCM2838_MPHI_OFFSET     0xb200
 #define BCM2838_MPHI_SIZE       0x200
 
+#define GENET_OFFSET            0x1580000
+
 #define TYPE_BCM2838_PERIPHERALS "bcm2838-peripherals"
 OBJECT_DECLARE_TYPE(BCM2838PeripheralState, BCM2838PeripheralClass,
                     BCM2838_PERIPHERALS)
diff --git a/include/hw/net/bcm2838_genet.h b/include/hw/net/bcm2838_genet.h
new file mode 100644
index 0000000000..91cf1773d5
--- /dev/null
+++ b/include/hw/net/bcm2838_genet.h
@@ -0,0 +1,40 @@
+/*
+ * BCM2838 Gigabit Ethernet emulation
+ *
+ * Copyright (C) 2022 Ovchinnikov Vitalii <vitalii.ovchinnikov@auriga.com>
+ *
+ * SPDX-License-Identifier: GPL-2.0-or-later
+ */
+
+#ifndef BCM2838_GENET_H
+#define BCM2838_GENET_H
+
+#include "net/net.h"
+#include "hw/core/sysbus.h"
+
+#define TYPE_BCM2838_GENET "bcm2838-genet"
+OBJECT_DECLARE_SIMPLE_TYPE(BCM2838GenetState, BCM2838_GENET)
+
+#define BCM2838_GENET_REV_MAJOR         6
+#define BCM2838_GENET_REV_MINOR         0
+
+typedef struct {
+    uint8_t stub_area[0x10000]; /* temporary stub */
+} BCM2838GenetRegs;
+
+struct BCM2838GenetState {
+    /*< private >*/
+    SysBusDevice parent_obj;
+
+    /*< public >*/
+
+    MemoryRegion regs_mr;
+    AddressSpace dma_as;
+
+    BCM2838GenetRegs regs;
+
+    qemu_irq irq_default;
+    qemu_irq irq_prio;
+};
+
+#endif /* BCM2838_GENET_H */
-- 
2.47.1


