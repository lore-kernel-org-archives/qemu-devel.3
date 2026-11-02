Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C7DD606A326
	for <qemu-devel@archiver.kernel.org>; Mon,  2 Nov 2026 13:41:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256 header.s=google header.b=Qp2z316j
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xNsCf-000322-2k; Mon, 02 Nov 2026 08:36:01 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1xNsCc-000312-S6
 for qemu-devel@nongnu.org; Mon, 02 Nov 2026 08:35:58 -0500
Received: from mail-wr1-x434.google.com ([2a00:1450:4864:20::434])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1xNsCa-0002Dv-Fo
 for qemu-devel@nongnu.org; Mon, 02 Nov 2026 08:35:58 -0500
Received: by mail-wr1-x434.google.com with SMTP id
 ffacd0b85a97d-48e10a70540so1680254f8f.1
 for <qemu-devel@nongnu.org>; Mon, 02 Nov 2026 05:35:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1793626555; x=1794231355; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=Z+CpVNwtF4nE0HIFM4etF+R48PbjYXvaf19Mi6a6HGU=;
 b=Qp2z316jYhNneT+XrGPofJV1dVlBo3+BB1Fixgk6gFM86VVN3El0QiypASIpzMREaP
 Xsk4lDE+knEnnv0wLbn2LJjxu6e12tpOev9hdgUHo7Fv7tqpCgE8D6ffrUO8B2uAlzjS
 9H56I4uA0rmvYnI67g0Vffrq0KTT1yNDJzEvqlxI2ua27sQZRo4R3/09xV5CZIKnhBsK
 8JZN6QCh/vs6y2ZDp1sWzRyrYLrge0k6+pewr6TasKN/ngA1Kt6ukcp81KJ24WzTI/AZ
 /Y++q713s8IA7tv8xT7PwZD1fd4n3Hh+WGCgvSgAxK8xKPo2ETRkKDGtt2bxroGcJUCB
 sJ5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793626555; x=1794231355;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=Z+CpVNwtF4nE0HIFM4etF+R48PbjYXvaf19Mi6a6HGU=;
 b=vs2pROX4Fifd6Z/+w0nkhiQNpPGKJ1DAxOzj1wF/S5tqaBUrul3jm18GNwCftkOjft
 zOlhtymXxNFnxZoFlnzvOPJfoyRi8x4cweQETy4dqOCQ9894BHSZ8p2ZMd9+FnsLGQLm
 OdJ3ZM1QzjPU1kjdJILP8H9A3UCLsoaWAlGoFjLkZHzyQLl3slv+ZDzo+WnlAUxAC4U1
 f0JFyiTXlASPUh37bw8dcaagUiDNhPPj//TB6SCJK7M/Dc8E848n7pqKpkM0yk1+VJ4r
 wnVYjRlc9c+SVKM7aMXUSMxMWTG2uteLwwtEJ202uVFz8oQL9aN0fmuxxetBl3LT1XWD
 WSrA==
X-Gm-Message-State: APuU4Z9OX+C2/8HMcGS6dFyqmIBxXpw7PjnWtGJ3+NqjhCxqURaCIp8N
 zKYEwPbdKt8+JJPDjJohnBjoKmXarqc455K4xiEwdjqeAvLk4Uj8jYfyjVqYh6PkicsC//LI+Rw
 fgSkdrKo=
X-Gm-Gg: AYBFou0skKT3UaZw3kN8XH1AOqv8zp65Tsa1/cjKdkzUjoO7hTHasTkxc4xn7UgVOvw
 YGTMuVQbSQ/OhimJwqSQuguoQVAULEcPA4RpFquuTWDI5olIOnAFkLdpYj3EAofIwPd9n/V5I+f
 I3IyucPjP7+NG3PF8nKB+Vh5zKomB/0vPjkSoOmjEzZjxDPvWZIz1BhKx2mNSSyQ7d1m9QwRZ/o
 Dqb61nzV9i6wCDhU3cKreeCf3lpIQbIw4HjbHvVWM8uBEIRjdTH5QHxVLM6gycDeulCAUICqsKn
 7OKw1pXN9slsBl3OhHi5z3Q8H4Kk7Qdl0QViRXfW1fqg6K95vMtjv5ipvoKJg/WqFoG2Zc2rbfZ
 lIORcXrZqbdIrqoNu4W4vmYjIKR2xOkpzVFdlOPZaKuoBibe+scOrowICDSdSsXniO381QHv/qD
 RHA+9G+aCfQSy+g3sdsgikJqMO7Z9sT6NKqrpxTLu7npa2pECw86Or8wBgaQ7RJGsRsMnN/DmRL
 XH73Zn6Si2hCH691BSVow08ICxHHhO3cw2CgN7KLnb8+Kmkr2t2JET25AnExfQ/M6nfvNVnC231
 s/H86FfZ7z79CtXpq5cdHmc0MtnsXq8+5Wd8HcucUbExFPKAP4/vT23d0k2rqVzHlMvgDFYP5GQ
 YTtwUUE/vc8Y7IrLso1lpgXuGlarrLtLDxxd8B3Pqsrlfewt2XNV8VC4=
X-Received: by 2002:a05:6000:200b:b0:48e:5df2:fd24 with SMTP id
 ffacd0b85a97d-48e6e305bc0mr22966203f8f.32.1793626554862; 
 Mon, 02 Nov 2026 05:35:54 -0800 (PST)
Received: from lanath.. (wildly.archaic.org.uk. [81.2.115.145])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-48e71a4d3e9sm22556760f8f.6.2026.11.02.05.35.53
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 02 Nov 2026 05:35:54 -0800 (PST)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 04/47] hw/net/bcm2838_genet: add GENET stub device
Date: Mon,  2 Nov 2026 13:35:04 +0000
Message-ID: <20261102133547.1375701-5-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261102133547.1375701-1-peter.maydell@linaro.org>
References: <20261102133547.1375701-1-peter.maydell@linaro.org>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::434;
 envelope-from=peter.maydell@linaro.org; helo=mail-wr1-x434.google.com
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
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

From: Marcelo Manzo <marcelomanzo@gmail.com>

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
Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
Message-id: 20261027143036.44973-5-marcelomanzo@gmail.com
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 include/hw/arm/bcm2838_peripherals.h |   2 +
 include/hw/net/bcm2838_genet.h       |  40 +++++++++++
 hw/net/bcm2838_genet.c               | 103 +++++++++++++++++++++++++++
 hw/net/meson.build                   |   2 +
 hw/net/trace-events                  |  16 +++++
 5 files changed, 163 insertions(+)
 create mode 100644 include/hw/net/bcm2838_genet.h
 create mode 100644 hw/net/bcm2838_genet.c

diff --git a/include/hw/arm/bcm2838_peripherals.h b/include/hw/arm/bcm2838_peripherals.h
index 0afc2c7bd2e..c6a8850cfe6 100644
--- a/include/hw/arm/bcm2838_peripherals.h
+++ b/include/hw/arm/bcm2838_peripherals.h
@@ -54,6 +54,8 @@
 #define BCM2838_MPHI_OFFSET     0xb200
 #define BCM2838_MPHI_SIZE       0x200
 
+#define GENET_OFFSET            0x1580000
+
 #define TYPE_BCM2838_PERIPHERALS "bcm2838-peripherals"
 OBJECT_DECLARE_TYPE(BCM2838PeripheralState, BCM2838PeripheralClass,
                     BCM2838_PERIPHERALS)
diff --git a/include/hw/net/bcm2838_genet.h b/include/hw/net/bcm2838_genet.h
new file mode 100644
index 00000000000..91cf1773d5f
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
diff --git a/hw/net/bcm2838_genet.c b/hw/net/bcm2838_genet.c
new file mode 100644
index 00000000000..a20a9e7c728
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
+    .impl = {.min_access_size = 4, .max_access_size = 4},
+    .valid = {.min_access_size = 4, .max_access_size = 4},
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
index 63b0e96245f..ef85b85adf1 100644
--- a/hw/net/meson.build
+++ b/hw/net/meson.build
@@ -70,4 +70,6 @@ if have_hmp
   system_ss.add(files('rocker/rocker-hmp-cmds.c'))
 endif
 
+system_ss.add(when: 'CONFIG_RASPI', if_true: files('bcm2838_genet.c'))
+
 subdir('can')
diff --git a/hw/net/trace-events b/hw/net/trace-events
index 839a612d356..709b0edc76b 100644
--- a/hw/net/trace-events
+++ b/hw/net/trace-events
@@ -529,3 +529,19 @@ xen_netdev_rx(int dev, int idx, int status, int flags) "vif%u idx %d status %d f
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
-- 
2.43.0


