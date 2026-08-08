Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BC241C5AC67
	for <qemu-devel@archiver.kernel.org>; Sat,  8 Aug 2026 13:17:39 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wsgu0-0006Mq-Cv; Sat, 08 Aug 2026 09:15:52 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <leo-cheng@vip.qq.com>)
 id 1wsegJ-0006h0-Dp; Sat, 08 Aug 2026 06:53:35 -0400
Received: from out203-205-221-202.mail.qq.com ([203.205.221.202])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <leo-cheng@vip.qq.com>)
 id 1wsegG-0003Nj-71; Sat, 08 Aug 2026 06:53:35 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vip.qq.com;
 s=s201512; t=1786186405;
 bh=jy0ezpp4wtzgY5AuB+2nqIqcRXxGJZgHNM+y/aGGHj8=;
 h=In-Reply-To:References:Date:Subject:To:Cc:From;
 b=X5I/oE0cFVDg+RhARa7KUFBT0J4o4/ZBOk0nkuUJs7EPiNaZF0WNpnEBOAl+Xx1vM
 V8ZQCxQLCXthTw8ugQPx07xhKp8/tKGBSBrHDnFQ558vxYXN9L8bqr6sCMxa12lQBl
 6iWOgIgF6BJiNMGuUzKjd3oMfrNjNf5IZJI3oe0Y=
Received: from localhost ([111.52.124.140])
 by newxmesmtplogicsvrszc50-0.qq.com (NewEsmtp) with SMTP
 id B7191645; Sat, 08 Aug 2026 18:45:49 +0800
X-QQ-mid: xmsmtpt1786185949tdv19d6fn
Message-ID: <tencent_9223890ACBB8754603A0FC726C0C0FE68F07@qq.com>
X-QQ-XMAILINFO: NyDiSH8JuwpVtdE8y+HEmBPCIzmZ/TDARZ5aZ/B0+cqHTVaQEfeeBzyZRurpGS
 U8f8GkdkZbvU+XuUygJNZPrSkGfCirhyLH36LLsceIn9gGNmVE21XzX6glZVb6PraC33gBIHRmFI
 wAJRbfK6QliWbjr/3GpMfyocBQSx8TGOtfJwsvOn12qcCHnr7qL/r54oN9qbwRWFCJDZ+UpRon0c
 MqGbo1Evm5iWsv5T3J2IJZzw6WLu6KrbwT2p7M8YqNEQzklISlj5Kfp7xuBxaUjNgGR8iHmlsUbZ
 K0LLJv9wtQU6nX/egWYFR6/v0CY7t7nZLmZD9S1VfKzQkXLte+yvKiN2uMNKs6nfz0ZLsKxgE6ou
 Y4bbFKbOhXwIh/XTHlT4/uBzm8KSWzQGbRF3D4+gckIcBtnnrU4cIpheJYTBNZBX5APkQkSnPmdo
 sj3+ErSEn+a51OOZA77vH3sZo58b76+lZUkMP/pkVG1pyQWaDRxDhqhdPBGXeQhc4Dv80/DzKN80
 tg7vv4xkIN2kLPumcXyVdzmgxaVP4Lql1JZOBoeXCV4I0biKxJdP4is+OxfxpIkqSEoXaSq9QZdG
 EJvYo0sIpWhh0rsFIdOcqVzQflSvCyAvs7AeKJyuXUZPSDIoSDQXMuXj91JnSIRHx7KFKVWrdqeb
 jp4SeI7Pv0PZdC12OvxjlHb1GoUAxyHQgSQ9eQIYzb8g09ipc2yn4LD/w3zrwrmJ0uG0QGfiza8g
 gxU/s3/Ia0Kfj1CT56VJJ2P5kV2sT5Zb0jWiBGFtEZbJJoewetkjlSuw6tdV1lb6I0I6YFVcqe6p
 Gmvib4l78JuCfEN0KM4fb0Pcdb0iF6mA7eu9PcPRM/w/TXTv9kJu0h5C0l8xOBIkCEahV0mEKzXj
 DwmoJCP+V39USUOAOkjYHaRtCrWqZi1jEP7iAX8v442G8MdSsrp2YisPzVMZEyVLyPYuAJ5xq8jL
 me7DHFsgJNKghK+Nm3kyimiAWZhMBhyn9LqzCKCfuo088jI/ApKVXfUkDmGpcKv8L3QqmzWJG/XH
 Fjjin8dtk0JiBMTVGvjqqbUamKS5kFFvUCqAF0EVB0y3Edd/XOtMIo792A4zd2XOFDFCcMvaAieW
 +X6APAnTXkrfyGDqLA4SF/xyJgXMoP6WwJnB3mFPvZ/xAev7o=
X-QQ-XMRINFO: NS+P29fieYNwqS3WCnRCOn9D1NpZuCnCRA==
X-OQ-MSGID: <5de261e9faa950b6a11819f70fef5c602b70ce8d.1786185889.git.chengkelfan@qq.com>
In-Reply-To: <cover.1786185889.git.chengkelfan@qq.com>
References: <cover.1786185889.git.chengkelfan@qq.com>
Date: Sat, 8 Aug 2026 18:44:25 +0800
Subject: [PATCH 4/5] hw/sd: add K230 SD/eMMC (DesignWare dw_mmc).
To: qemu-devel@nongnu.org, qemu-riscv@nongnu.org
Cc: Chao Liu <chao.liu@processmission.com>, Palmer Dabbelt <palmer@dabbelt.com>,
 Alistair Francis <alistair.francis@wdc.com>, Weiwei Li <liwei1518@gmail.com>,
 Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>,
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Fabiano Rosas <farosas@suse.de>, Laurent Vivier <lvivier@redhat.com>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
From: Leo Cheng <leo-cheng@vip.qq.com>
Received-SPF: pass client-ip=203.205.221.202;
 envelope-from=leo-cheng@vip.qq.com; helo=out203-205-221-202.mail.qq.com
X-Spam_score_int: -19
X-Spam_score: -2.0
X-Spam_bar: --
X-Spam_report: (-2.0 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, FREEMAIL_FROM=0.001,
 HELO_STATIC_HOST=-0.001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-Mailman-Approved-At: Sat, 08 Aug 2026 09:15:48 -0400
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

Model the register interface of the DesignWare dw_mmc host used by the K230: self-clearing CTRL reset bits, a self-clearing CMD.START that raises command completion, W1C RINTSTS and masked-interrupt delivery. The FIFO/DMA data path is not modelled; this is enough for a driver to probe. Register map from the DesignWare dw_mmc driver. Covered by tests/qtest/k230-dwmmc-test.

Signed-off-by: Leo Cheng <leo-cheng@vip.qq.com>
---
 hw/sd/Kconfig                 |   3 +
 hw/sd/k230_dwmmc.c            | 139 ++++++++++++++++++++++++++++++++++
 hw/sd/meson.build             |   1 +
 hw/sd/trace-events            |   4 +
 include/hw/sd/k230_dwmmc.h    |  61 +++++++++++++++
 tests/qtest/k230-dwmmc-test.c |  79 +++++++++++++++++++
 6 files changed, 287 insertions(+)
 create mode 100644 hw/sd/k230_dwmmc.c
 create mode 100644 include/hw/sd/k230_dwmmc.h
 create mode 100644 tests/qtest/k230-dwmmc-test.c

diff --git a/hw/sd/Kconfig b/hw/sd/Kconfig
index 633b9af..15f1fd9 100644
--- a/hw/sd/Kconfig
+++ b/hw/sd/Kconfig
@@ -23,3 +23,6 @@ config SDHCI_PCI
 config CADENCE_SDHCI
     bool
     select SDHCI
+
+config K230_DWMMC
+    bool
diff --git a/hw/sd/k230_dwmmc.c b/hw/sd/k230_dwmmc.c
new file mode 100644
index 0000000..47a68a0
--- /dev/null
+++ b/hw/sd/k230_dwmmc.c
@@ -0,0 +1,139 @@
+/*
+ * K230 SD/eMMC host (Synopsys DesignWare dw_mmc)
+ *
+ * Copyright (c) 2026 Leo Cheng <chengkelfan@qq.com>
+ *
+ * SPDX-License-Identifier: GPL-2.0-or-later
+ *
+ * Register map from the DesignWare dw_mmc driver (Canaan k230_sdk). Models the
+ * register interface and command completion; the FIFO/DMA data path is not
+ * modelled.
+ */
+#include "qemu/osdep.h"
+#include "qemu/module.h"
+#include "hw/core/sysbus.h"
+#include "hw/core/irq.h"
+#include "migration/vmstate.h"
+#include "hw/sd/k230_dwmmc.h"
+#include "trace.h"
+
+static void k230_dwmmc_update_irq(K230DwmmcState *s)
+{
+    uint32_t masked = s->regs[SDMMC_RINTSTS / 4] & s->regs[SDMMC_INTMASK / 4];
+
+    s->regs[SDMMC_MINTSTS / 4] = masked;
+    qemu_set_irq(s->irq, masked != 0);
+}
+
+static uint64_t k230_dwmmc_read(void *opaque, hwaddr addr, unsigned int size)
+{
+    K230DwmmcState *s = K230_DWMMC(opaque);
+    uint32_t value = addr / 4 < K230_DWMMC_NREGS ? s->regs[addr / 4] : 0;
+
+    trace_k230_dwmmc_read(addr, value);
+    return value;
+}
+
+static void k230_dwmmc_write(void *opaque, hwaddr addr,
+                             uint64_t value, unsigned int size)
+{
+    K230DwmmcState *s = K230_DWMMC(opaque);
+
+    if (addr / 4 >= K230_DWMMC_NREGS) {
+        return;
+    }
+    trace_k230_dwmmc_write(addr, value);
+
+    switch (addr) {
+    case SDMMC_CTRL:
+        /* the three reset bits are self-clearing */
+        s->regs[SDMMC_CTRL / 4] = value & ~SDMMC_CTRL_RESET_ALL;
+        break;
+    case SDMMC_CMD:
+        /* START self-clears; completing a command raises command-done */
+        s->regs[SDMMC_CMD / 4] = value & ~SDMMC_CMD_START;
+        if (value & SDMMC_CMD_START) {
+            s->regs[SDMMC_RINTSTS / 4] |= SDMMC_INT_CMD_DONE;
+            k230_dwmmc_update_irq(s);
+        }
+        break;
+    case SDMMC_RINTSTS:
+        s->regs[SDMMC_RINTSTS / 4] &= ~(uint32_t)value;   /* W1C */
+        k230_dwmmc_update_irq(s);
+        break;
+    case SDMMC_INTMASK:
+        s->regs[SDMMC_INTMASK / 4] = value;
+        k230_dwmmc_update_irq(s);
+        break;
+    case SDMMC_STATUS:
+    case SDMMC_MINTSTS:
+        break;                                            /* read-only */
+    default:
+        s->regs[addr / 4] = value;
+        break;
+    }
+}
+
+static const MemoryRegionOps k230_dwmmc_ops = {
+    .read = k230_dwmmc_read,
+    .write = k230_dwmmc_write,
+    .endianness = DEVICE_LITTLE_ENDIAN,
+    .impl = {
+        .min_access_size = 4,
+        .max_access_size = 4,
+        .unaligned = false,
+    },
+};
+
+static void k230_dwmmc_reset(DeviceState *dev)
+{
+    K230DwmmcState *s = K230_DWMMC(dev);
+
+    memset(s->regs, 0, sizeof(s->regs));
+    s->regs[SDMMC_STATUS / 4] = SDMMC_STATUS_FIFO_EMPTY;
+    qemu_set_irq(s->irq, 0);
+}
+
+static const VMStateDescription vmstate_k230_dwmmc = {
+    .name = "k230.dwmmc",
+    .fields = (const VMStateField[]) {
+        VMSTATE_UINT32_ARRAY(regs, K230DwmmcState, K230_DWMMC_NREGS),
+        VMSTATE_END_OF_LIST()
+    }
+};
+
+static void k230_dwmmc_realize(DeviceState *dev, Error **errp)
+{
+    K230DwmmcState *s = K230_DWMMC(dev);
+    SysBusDevice *sbd = SYS_BUS_DEVICE(dev);
+
+    memory_region_init_io(&s->mmio, OBJECT(dev), &k230_dwmmc_ops, s,
+                          TYPE_K230_DWMMC, K230_DWMMC_MMIO_SIZE);
+    sysbus_init_mmio(sbd, &s->mmio);
+    sysbus_init_irq(sbd, &s->irq);
+    s->regs[SDMMC_STATUS / 4] = SDMMC_STATUS_FIFO_EMPTY;
+}
+
+static void k230_dwmmc_class_init(ObjectClass *klass, const void *data)
+{
+    DeviceClass *dc = DEVICE_CLASS(klass);
+
+    dc->realize = k230_dwmmc_realize;
+    device_class_set_legacy_reset(dc, k230_dwmmc_reset);
+    dc->vmsd = &vmstate_k230_dwmmc;
+    dc->desc = "K230 SD/eMMC (dw_mmc)";
+}
+
+static const TypeInfo k230_dwmmc_info = {
+    .name          = TYPE_K230_DWMMC,
+    .parent        = TYPE_SYS_BUS_DEVICE,
+    .instance_size = sizeof(K230DwmmcState),
+    .class_init    = k230_dwmmc_class_init,
+};
+
+static void k230_dwmmc_register_type(void)
+{
+    type_register_static(&k230_dwmmc_info);
+}
+
+type_init(k230_dwmmc_register_type)
diff --git a/hw/sd/meson.build b/hw/sd/meson.build
index b43d45b..d642de3 100644
--- a/hw/sd/meson.build
+++ b/hw/sd/meson.build
@@ -10,3 +10,4 @@ system_ss.add(when: 'CONFIG_ASPEED_SOC', if_true: files('aspeed_sdhci.c'))
 system_ss.add(when: 'CONFIG_ALLWINNER_H3', if_true: files('allwinner-sdhost.c'))
 system_ss.add(when: 'CONFIG_NPCM7XX', if_true: files('npcm7xx_sdhci.c'))
 system_ss.add(when: 'CONFIG_CADENCE_SDHCI', if_true: files('cadence_sdhci.c'))
+system_ss.add(when: 'CONFIG_K230_DWMMC', if_true: files('k230_dwmmc.c'))
diff --git a/hw/sd/trace-events b/hw/sd/trace-events
index c6811f3..8537b25 100644
--- a/hw/sd/trace-events
+++ b/hw/sd/trace-events
@@ -75,3 +75,7 @@ pl181_data_engine_idle(void) "data engine idle"
 # aspeed_sdhci.c
 aspeed_sdhci_read(uint64_t addr, uint32_t size, uint64_t data) "@0x%" PRIx64 " size %u: 0x%" PRIx64
 aspeed_sdhci_write(uint64_t addr, uint32_t size, uint64_t data) "@0x%" PRIx64 " size %u: 0x%" PRIx64
+
+# k230_dwmmc.c
+k230_dwmmc_read(uint64_t addr, uint32_t val) "addr 0x%" PRIx64 " val 0x%08x"
+k230_dwmmc_write(uint64_t addr, uint64_t val) "addr 0x%" PRIx64 " val 0x%" PRIx64
diff --git a/include/hw/sd/k230_dwmmc.h b/include/hw/sd/k230_dwmmc.h
new file mode 100644
index 0000000..6c5c255
--- /dev/null
+++ b/include/hw/sd/k230_dwmmc.h
@@ -0,0 +1,61 @@
+/*
+ * K230 SD/eMMC host (Synopsys DesignWare dw_mmc)
+ *
+ * Copyright (c) 2026 Leo Cheng <chengkelfan@qq.com>
+ *
+ * SPDX-License-Identifier: GPL-2.0-or-later
+ *
+ * Register map from the DesignWare dw_mmc driver (Canaan k230_sdk
+ * drivers/mmc/host/dw_mmc.h). This models the register interface and command
+ * completion enough for a driver to probe; the FIFO/DMA data path is not
+ * modelled (documented limitation).
+ */
+#ifndef HW_SD_K230_DWMMC_H
+#define HW_SD_K230_DWMMC_H
+
+#include "hw/core/sysbus.h"
+#include "qom/object.h"
+
+#define TYPE_K230_DWMMC "riscv.k230.dwmmc"
+OBJECT_DECLARE_SIMPLE_TYPE(K230DwmmcState, K230_DWMMC)
+
+#define K230_DWMMC_MMIO_SIZE 0x1000
+#define K230_DWMMC_NREGS     (0x100 / 4)
+
+#define SDMMC_CTRL    0x000
+#define SDMMC_PWREN   0x004
+#define SDMMC_CLKDIV  0x008
+#define SDMMC_CLKENA  0x010
+#define SDMMC_TMOUT   0x014
+#define SDMMC_CTYPE   0x018
+#define SDMMC_BLKSIZ  0x01c
+#define SDMMC_BYTCNT  0x020
+#define SDMMC_INTMASK 0x024
+#define SDMMC_CMDARG  0x028
+#define SDMMC_CMD     0x02c
+#define SDMMC_RESP0   0x030
+#define SDMMC_RESP3   0x03c
+#define SDMMC_MINTSTS 0x040
+#define SDMMC_RINTSTS 0x044
+#define SDMMC_STATUS  0x048
+
+#define SDMMC_CTRL_RESET      (1u << 0)
+#define SDMMC_CTRL_FIFO_RESET (1u << 1)
+#define SDMMC_CTRL_DMA_RESET  (1u << 2)
+#define SDMMC_CTRL_RESET_ALL  (SDMMC_CTRL_RESET | SDMMC_CTRL_FIFO_RESET | \
+                               SDMMC_CTRL_DMA_RESET)
+#define SDMMC_CMD_START       (1u << 31)
+#define SDMMC_INT_CMD_DONE    (1u << 2)
+
+/* STATUS: FIFO empty so a polling driver does not stall */
+#define SDMMC_STATUS_FIFO_EMPTY (1u << 2)
+
+struct K230DwmmcState {
+    SysBusDevice parent_obj;
+
+    MemoryRegion mmio;
+    qemu_irq irq;
+    uint32_t regs[K230_DWMMC_NREGS];
+};
+
+#endif
diff --git a/tests/qtest/k230-dwmmc-test.c b/tests/qtest/k230-dwmmc-test.c
new file mode 100644
index 0000000..1adeef0
--- /dev/null
+++ b/tests/qtest/k230-dwmmc-test.c
@@ -0,0 +1,79 @@
+/*
+ * QTest testcase for K230 SD/eMMC (dw_mmc)
+ *
+ * Copyright (c) 2026 Leo Cheng <chengkelfan@qq.com>
+ *
+ * SPDX-License-Identifier: GPL-2.0-or-later
+ */
+#include "qemu/osdep.h"
+#include "libqtest.h"
+#include "hw/sd/k230_dwmmc.h"
+
+#define SD0_BASE     0x91580000
+#define PLIC_BASE    0xF00000000ULL
+#define PLIC_PENDING (PLIC_BASE + 0x1000)
+#define SD0_IRQ      142
+
+static bool plic_pending(QTestState *qts, int irq)
+{
+    uint32_t word = qtest_readl(qts, PLIC_PENDING + (irq / 32) * 4);
+    return (word >> (irq % 32)) & 1;
+}
+
+static void test_reset_values(void)
+{
+    QTestState *qts = qtest_init("-machine k230");
+
+    g_assert_cmphex(qtest_readl(qts, SD0_BASE + SDMMC_CTRL), ==, 0);
+    g_assert_cmphex(qtest_readl(qts, SD0_BASE + SDMMC_STATUS), ==,
+                    SDMMC_STATUS_FIFO_EMPTY);
+
+    qtest_quit(qts);
+}
+
+/* The three CTRL reset bits are self-clearing */
+static void test_ctrl_reset_selfclear(void)
+{
+    QTestState *qts = qtest_init("-machine k230");
+
+    qtest_writel(qts, SD0_BASE + SDMMC_CTRL, SDMMC_CTRL_RESET_ALL | 0x10);
+    g_assert_cmphex(qtest_readl(qts, SD0_BASE + SDMMC_CTRL) &
+                    SDMMC_CTRL_RESET_ALL, ==, 0);
+    g_assert_cmphex(qtest_readl(qts, SD0_BASE + SDMMC_CTRL) & 0x10, ==, 0x10);
+
+    qtest_quit(qts);
+}
+
+/* Starting a command auto-clears START, raises command-done, W1C clears it */
+static void test_cmd_done(void)
+{
+    QTestState *qts = qtest_init("-machine k230");
+
+    qtest_writel(qts, SD0_BASE + SDMMC_INTMASK, SDMMC_INT_CMD_DONE);
+    qtest_writel(qts, SD0_BASE + SDMMC_CMD, SDMMC_CMD_START | 0x1);
+
+    g_assert_cmphex(qtest_readl(qts, SD0_BASE + SDMMC_CMD) & SDMMC_CMD_START,
+                    ==, 0);
+    g_assert_cmphex(qtest_readl(qts, SD0_BASE + SDMMC_RINTSTS) &
+                    SDMMC_INT_CMD_DONE, ==, SDMMC_INT_CMD_DONE);
+    g_assert_true(plic_pending(qts, SD0_IRQ));
+
+    /* RINTSTS is write-1-to-clear */
+    qtest_writel(qts, SD0_BASE + SDMMC_RINTSTS, SDMMC_INT_CMD_DONE);
+    g_assert_cmphex(qtest_readl(qts, SD0_BASE + SDMMC_RINTSTS) &
+                    SDMMC_INT_CMD_DONE, ==, 0);
+
+    qtest_quit(qts);
+}
+
+int main(int argc, char **argv)
+{
+    g_test_init(&argc, &argv, NULL);
+
+    qtest_add_func("/k230-dwmmc/reset_values", test_reset_values);
+    qtest_add_func("/k230-dwmmc/ctrl_reset_selfclear",
+                   test_ctrl_reset_selfclear);
+    qtest_add_func("/k230-dwmmc/cmd_done", test_cmd_done);
+
+    return g_test_run();
+}
-- 
2.43.0


