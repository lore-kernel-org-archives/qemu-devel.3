Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6339CC55174
	for <qemu-devel@archiver.kernel.org>; Sat,  8 Aug 2026 13:17:39 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wsgu0-0006Mk-8t; Sat, 08 Aug 2026 09:15:52 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <leo-cheng@vip.qq.com>)
 id 1wsegB-0006gL-VP; Sat, 08 Aug 2026 06:53:30 -0400
Received: from xmbghk7.mail.qq.com ([43.163.128.52])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <leo-cheng@vip.qq.com>)
 id 1wseg5-0003NL-3h; Sat, 08 Aug 2026 06:53:27 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vip.qq.com;
 s=s201512; t=1786186396;
 bh=AHXsFAFPHJl62d/f7kjXj5e+OqgkxYHHvSafKP7dmA8=;
 h=In-Reply-To:References:Date:Subject:To:Cc:From;
 b=ZEFLfNbB7lXmUhzO2fn2CY7JSQ5PhS/oy9zNEZjDOWZOFVO4yGKSI6M0fENCyxW5b
 tqJD3p3pkZxty8jAGZev5WKSFBOC1gnmSl+BM3EVbBg2qYFnGJCgMnPRbAszNexJF3
 X5XUNE+GgbrKjuAREZAkRUYcab7ML4s9Eeo1NuqQ=
Received: from localhost ([111.52.124.140])
 by newxmesmtplogicsvrszc56-0.qq.com (NewEsmtp) with SMTP
 id B6FA344F; Sat, 08 Aug 2026 18:45:47 +0800
X-QQ-mid: xmsmtpt1786185947tgijzem8x
Message-ID: <tencent_EA1AA0D0F20D0C4F6683A3A60AB1382DC607@qq.com>
X-QQ-XMAILINFO: MllZffuBkEb5NzIVztvRX/UaLelPnuKrJGv0TurC8SCyeSTwT5HRJxuxuNo5S7
 agNnBRO9qH+ZVDvS1tUxfMFx78szJN6vObOZj44rLrwvah8+DKqxBfeSnjbZETogGh2GRSLz0wXO
 b1uo5h4LEI/BHBkX+vhomTw2eIrO2aiOYVIOc4ts2Nn+akydRJhkeBg/t7rmkOBoWL2EWR6RWmQZ
 ODK4BuzrWX5PRim/3Nexuae+UlsqfCl9W5IR7liP/tiRFjs0dnsRRHKPqQ8eXeyPKMk3dML0GIRp
 VvIvOJnaJW+4NLRCDpGXuB1zeTPY4JzJD1DoQF91k/vckR85KoMy413Pf1Xlh990DT/LMg8mrIc7
 8JtzLtGy6u+jkEUuYwvvM3sbV8kMl1xF7M+ZcPqGBtR+Y4KmGehcAbXLSN2t0ZS3MZJOfqXtQIcR
 u1gADy/LV58Lg/Ej7RhJD2RSuSOyQ43WrtHA8bdObZubSiCMhI8JK+9Rh6bUy6ZgHw9LorPpNmxA
 rdKc3zY08l10Ie+R8AjJokQpzM1MMX+ZjWY8xgmpPj1fNXP/tdCmvrluXYbsFeBkm+Rdse6Qw+da
 D5ckayxXmcTJf95cVtd82fQUFY7D5/kPiT+TnkamBzshI04Gl1gFGMYcdSbpAcAqP1YTb20qisms
 45oGcyKAnVIW50D73YTVQV2LASGf2Bx8taiU96YAIcg5qmgNfHmeYNYur11u0rKk0WAGqBtOsZm8
 dx9LUygV9Sy7FTtIOSvagkTLvPSw5mCMXdUAADDpORA+PJWs2K+Yl46BLFlIn7qvAo9UoUfECons
 QNrpcAArq4yH9H9sMRzrXE8UXOlwQuXzLUSvmRwdZLq/6mUXSUbLjqQAP5YLdBTRMuhMHUkMKblW
 4SJ08++0hkZ1GQqxIFDnG9oP5o2A4aq2jwuS8BtgjYN4imeNOXS9oriQHOawf/J3J1ztz2cKyZ1q
 YFC5pMfnCit1wFSRpBSgE4QTZHnpRtljyW4jnUoMSRzKSszXfNAeT5ceDJfWnsfFQwnBTTzduhkM
 fBdZK/1uZBALAp3+thav2vmSYjz/saICpbnbKjFOLzhMypryIknWVqnbOYf5StVJ1KRVC84cRLEl
 ugNT3bqzrOzuWZ7+T1ZV3Mii9LYbtljTL+74spUBRz389kYSb5Miv+4IctSZ/37lMd+IJVy6Byb4
 6Hu9U=
X-QQ-XMRINFO: M/715EihBoGS47X28/vv4NpnfpeBLnr4Qg==
X-OQ-MSGID: <973a27fabd0a3a56e46231be62905b70ec35d35b.1786185889.git.chengkelfan@qq.com>
In-Reply-To: <cover.1786185889.git.chengkelfan@qq.com>
References: <cover.1786185889.git.chengkelfan@qq.com>
Date: Sat, 8 Aug 2026 18:44:25 +0800
Subject: [PATCH 3/5] hw/misc: add K230 IOMUX and mailbox/IPCM.
To: qemu-devel@nongnu.org, qemu-riscv@nongnu.org
Cc: Chao Liu <chao.liu@processmission.com>, Palmer Dabbelt <palmer@dabbelt.com>,
 Alistair Francis <alistair.francis@wdc.com>, Weiwei Li <liwei1518@gmail.com>,
 Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>,
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Fabiano Rosas <farosas@suse.de>, Laurent Vivier <lvivier@redhat.com>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
From: Leo Cheng <leo-cheng@vip.qq.com>
Received-SPF: pass client-ip=43.163.128.52; envelope-from=leo-cheng@vip.qq.com;
 helo=xmbghk7.mail.qq.com
X-Spam_score_int: -19
X-Spam_score: -2.0
X-Spam_bar: --
X-Spam_report: (-2.0 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-Mailman-Approved-At: Sat, 08 Aug 2026 09:15:43 -0400
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

IOMUX is the K230 pin-configuration controller (64 pins, one 32-bit register per pin) with the field layout of the upstream Linux pinctrl-k230 driver. The mailbox/IPCM block at 0x91104000 is an inter-core interrupt-notify mailbox plus a hardware spinlock array: a write to a CPU2DSP/DSP2CPU SET register rings the doorbell IRQ, CLEAR acks, and the 0xA0 array is 128 test-and-set locks. Message payloads travel through shared memory, so no data registers are modelled. Register semantics from the Canaan k230_sdk. Covered by the k230-iomux and k230-mailbox qtests.

Signed-off-by: Leo Cheng <leo-cheng@vip.qq.com>
---
 hw/misc/Kconfig                 |   6 +
 hw/misc/k230_iomux.c            | 101 ++++++++++++++++
 hw/misc/k230_mailbox.c          | 206 ++++++++++++++++++++++++++++++++
 hw/misc/meson.build             |   2 +
 hw/misc/trace-events            |  10 ++
 include/hw/misc/k230_iomux.h    |  44 +++++++
 include/hw/misc/k230_mailbox.h  |  61 ++++++++++
 tests/qtest/k230-iomux-test.c   |  62 ++++++++++
 tests/qtest/k230-mailbox-test.c |  89 ++++++++++++++
 9 files changed, 581 insertions(+)
 create mode 100644 hw/misc/k230_iomux.c
 create mode 100644 hw/misc/k230_mailbox.c
 create mode 100644 include/hw/misc/k230_iomux.h
 create mode 100644 include/hw/misc/k230_mailbox.h
 create mode 100644 tests/qtest/k230-iomux-test.c
 create mode 100644 tests/qtest/k230-mailbox-test.c

diff --git a/hw/misc/Kconfig b/hw/misc/Kconfig
index 1543ee6..742ea2f 100644
--- a/hw/misc/Kconfig
+++ b/hw/misc/Kconfig
@@ -186,6 +186,12 @@ config AUX
 config UNIMP
     bool
 
+config K230_IOMUX
+    bool
+
+config K230_MAILBOX
+    bool
+
 config LED
     bool
 
diff --git a/hw/misc/k230_iomux.c b/hw/misc/k230_iomux.c
new file mode 100644
index 0000000..87e7587
--- /dev/null
+++ b/hw/misc/k230_iomux.c
@@ -0,0 +1,101 @@
+/*
+ * K230 IOMUX (pin configuration) controller
+ *
+ * Copyright (c) 2026 Leo Cheng <chengkelfan@qq.com>
+ *
+ * SPDX-License-Identifier: GPL-2.0-or-later
+ *
+ * K230 Technical Reference Manual V0.3.1 (2024-11-18); register layout matches
+ * the upstream Linux driver drivers/pinctrl/pinctrl-k230.c.
+ */
+#include "qemu/osdep.h"
+#include "qemu/log.h"
+#include "qemu/module.h"
+#include "hw/core/sysbus.h"
+#include "migration/vmstate.h"
+#include "hw/misc/k230_iomux.h"
+#include "trace.h"
+
+static uint64_t k230_iomux_read(void *opaque, hwaddr addr, unsigned int size)
+{
+    K230IomuxState *s = K230_IOMUX(opaque);
+    uint32_t value = 0;
+
+    if (addr / 4 < K230_IOMUX_NPINS) {
+        value = s->pin[addr / 4];
+    }
+
+    trace_k230_iomux_read(addr, value);
+    return value;
+}
+
+static void k230_iomux_write(void *opaque, hwaddr addr,
+                             uint64_t value, unsigned int size)
+{
+    K230IomuxState *s = K230_IOMUX(opaque);
+
+    trace_k230_iomux_write(addr, value);
+
+    if (addr / 4 < K230_IOMUX_NPINS) {
+        s->pin[addr / 4] = value & K230_PC_MASK;
+    }
+}
+
+static const MemoryRegionOps k230_iomux_ops = {
+    .read = k230_iomux_read,
+    .write = k230_iomux_write,
+    .endianness = DEVICE_LITTLE_ENDIAN,
+    .impl = {
+        .min_access_size = 4,
+        .max_access_size = 4,
+        .unaligned = false,
+    },
+};
+
+static void k230_iomux_reset(DeviceState *dev)
+{
+    K230IomuxState *s = K230_IOMUX(dev);
+
+    memset(s->pin, 0, sizeof(s->pin));
+}
+
+static const VMStateDescription vmstate_k230_iomux = {
+    .name = "k230.iomux",
+    .fields = (const VMStateField[]) {
+        VMSTATE_UINT32_ARRAY(pin, K230IomuxState, K230_IOMUX_NPINS),
+        VMSTATE_END_OF_LIST()
+    }
+};
+
+static void k230_iomux_realize(DeviceState *dev, Error **errp)
+{
+    K230IomuxState *s = K230_IOMUX(dev);
+
+    memory_region_init_io(&s->mmio, OBJECT(dev), &k230_iomux_ops, s,
+                          TYPE_K230_IOMUX, K230_IOMUX_MMIO_SIZE);
+    sysbus_init_mmio(SYS_BUS_DEVICE(dev), &s->mmio);
+}
+
+static void k230_iomux_class_init(ObjectClass *klass, const void *data)
+{
+    DeviceClass *dc = DEVICE_CLASS(klass);
+
+    dc->realize = k230_iomux_realize;
+    device_class_set_legacy_reset(dc, k230_iomux_reset);
+    dc->vmsd = &vmstate_k230_iomux;
+    dc->desc = "K230 IOMUX";
+}
+
+static const TypeInfo k230_iomux_info = {
+    .name          = TYPE_K230_IOMUX,
+    .parent        = TYPE_SYS_BUS_DEVICE,
+    .instance_size = sizeof(K230IomuxState),
+    .class_init    = k230_iomux_class_init,
+};
+
+static void k230_iomux_register_type(void)
+{
+    type_register_static(&k230_iomux_info);
+}
+
+type_init(k230_iomux_register_type)
diff --git a/hw/misc/k230_mailbox.c b/hw/misc/k230_mailbox.c
new file mode 100644
index 0000000..efcb843
--- /dev/null
+++ b/hw/misc/k230_mailbox.c
@@ -0,0 +1,206 @@
+/*
+ * K230 mailbox / IPCM block (inter-core interrupt notify + hardware spinlock)
+ *
+ * Copyright (c) 2026 Leo Cheng <chengkelfan@qq.com>
+ *
+ * SPDX-License-Identifier: GPL-2.0-or-later
+ *
+ * Register semantics from the Canaan k230_sdk: ipcm_platform.h (interrupt
+ * register offsets/bits), platform_riscv_rtsmart.c (SET rings the doorbell,
+ * CLEAR acks), drv_hardlock.c (test-and-set array at 0xA0). Message payloads
+ * are not carried by any register; they travel through shared memory.
+ */
+#include "qemu/osdep.h"
+#include "qemu/module.h"
+#include "hw/core/sysbus.h"
+#include "hw/core/irq.h"
+#include "migration/vmstate.h"
+#include "hw/misc/k230_mailbox.h"
+#include "trace.h"
+
+static void k230_mailbox_update_irq(K230MailboxState *s, int ch)
+{
+    bool level = s->status[ch] && (s->en[ch] & K230_MB_INT_EN);
+
+    qemu_set_irq(s->irq[ch], level);
+}
+
+static int k230_mailbox_lock_num(hwaddr addr)
+{
+    if (addr < K230_MB_HARDLOCK_BASE) {
+        return -1;
+    }
+    addr -= K230_MB_HARDLOCK_BASE;
+    if (addr / 4 >= K230_MB_HARDLOCK_MAX) {
+        return -1;
+    }
+    return addr / 4;
+}
+
+static uint64_t k230_mailbox_read(void *opaque, hwaddr addr, unsigned int size)
+{
+    K230MailboxState *s = K230_MAILBOX(opaque);
+    int num = k230_mailbox_lock_num(addr);
+    uint32_t value = 0;
+
+    if (num >= 0) {
+        value = s->lock[num];   /* 0 = free (now taken), 1 = already held */
+        s->lock[num] = 1;
+        trace_k230_mailbox_lock_read(num, value);
+        return value;
+    }
+
+    switch (addr) {
+    case K230_MB_CPU2DSP_EN:
+        value = s->en[0];
+        break;
+    case K230_MB_CPU2DSP_STATUS:
+        value = s->status[0];
+        break;
+    case K230_MB_CPU2DSP_ERR:
+        value = s->err[0];
+        break;
+    case K230_MB_DSP2CPU_EN:
+        value = s->en[1];
+        break;
+    case K230_MB_DSP2CPU_STATUS:
+        value = s->status[1];
+        break;
+    case K230_MB_DSP2CPU_ERR:
+        value = s->err[1];
+        break;
+    default:
+        break;
+    }
+
+    trace_k230_mailbox_read(addr, value);
+    return value;
+}
+
+static void k230_mailbox_write(void *opaque, hwaddr addr,
+                               uint64_t value, unsigned int size)
+{
+    K230MailboxState *s = K230_MAILBOX(opaque);
+    int num = k230_mailbox_lock_num(addr);
+
+    if (num >= 0) {
+        s->lock[num] = value & 1;
+        trace_k230_mailbox_lock_write(num, value);
+        return;
+    }
+
+    trace_k230_mailbox_write(addr, value);
+
+    switch (addr) {
+    case K230_MB_CPU2DSP_EN:
+        s->en[0] = value;
+        if (value & K230_MB_INT_SOFTRST) {
+            s->status[0] = 0;
+        }
+        k230_mailbox_update_irq(s, 0);
+        break;
+    case K230_MB_CPU2DSP_SET:
+        s->status[0] = 1;
+        k230_mailbox_update_irq(s, 0);
+        break;
+    case K230_MB_CPU2DSP_CLEAR:
+        s->status[0] = 0;
+        k230_mailbox_update_irq(s, 0);
+        break;
+    case K230_MB_CPU2DSP_ERR:
+        s->err[0] = value;
+        break;
+    case K230_MB_DSP2CPU_EN:
+        s->en[1] = value;
+        if (value & K230_MB_INT_SOFTRST) {
+            s->status[1] = 0;
+        }
+        k230_mailbox_update_irq(s, 1);
+        break;
+    case K230_MB_DSP2CPU_SET:
+        s->status[1] = 1;
+        k230_mailbox_update_irq(s, 1);
+        break;
+    case K230_MB_DSP2CPU_CLEAR:
+        s->status[1] = 0;
+        k230_mailbox_update_irq(s, 1);
+        break;
+    case K230_MB_DSP2CPU_ERR:
+        s->err[1] = value;
+        break;
+    default:
+        break;
+    }
+}
+
+static const MemoryRegionOps k230_mailbox_ops = {
+    .read = k230_mailbox_read,
+    .write = k230_mailbox_write,
+    .endianness = DEVICE_LITTLE_ENDIAN,
+    .impl = {
+        .min_access_size = 4,
+        .max_access_size = 4,
+        .unaligned = false,
+    },
+};
+
+static void k230_mailbox_reset(DeviceState *dev)
+{
+    K230MailboxState *s = K230_MAILBOX(dev);
+
+    memset(s->en, 0, sizeof(s->en));
+    memset(s->status, 0, sizeof(s->status));
+    memset(s->err, 0, sizeof(s->err));
+    memset(s->lock, 0, sizeof(s->lock));
+    for (int i = 0; i < K230_MB_CHANNELS; i++) {
+        qemu_set_irq(s->irq[i], 0);
+    }
+}
+
+static const VMStateDescription vmstate_k230_mailbox = {
+    .name = "k230.mailbox",
+    .fields = (const VMStateField[]) {
+        VMSTATE_UINT32_ARRAY(en, K230MailboxState, K230_MB_CHANNELS),
+        VMSTATE_UINT32_ARRAY(status, K230MailboxState, K230_MB_CHANNELS),
+        VMSTATE_UINT32_ARRAY(err, K230MailboxState, K230_MB_CHANNELS),
+        VMSTATE_UINT8_ARRAY(lock, K230MailboxState, K230_MB_HARDLOCK_MAX),
+        VMSTATE_END_OF_LIST()
+    }
+};
+
+static void k230_mailbox_realize(DeviceState *dev, Error **errp)
+{
+    K230MailboxState *s = K230_MAILBOX(dev);
+    SysBusDevice *sbd = SYS_BUS_DEVICE(dev);
+
+    memory_region_init_io(&s->mmio, OBJECT(dev), &k230_mailbox_ops, s,
+                          TYPE_K230_MAILBOX, K230_MAILBOX_MMIO_SIZE);
+    sysbus_init_mmio(sbd, &s->mmio);
+    for (int i = 0; i < K230_MB_CHANNELS; i++) {
+        sysbus_init_irq(sbd, &s->irq[i]);
+    }
+}
+
+static void k230_mailbox_class_init(ObjectClass *klass, const void *data)
+{
+    DeviceClass *dc = DEVICE_CLASS(klass);
+
+    dc->realize = k230_mailbox_realize;
+    device_class_set_legacy_reset(dc, k230_mailbox_reset);
+    dc->vmsd = &vmstate_k230_mailbox;
+    dc->desc = "K230 mailbox/IPCM";
+}
+
+static const TypeInfo k230_mailbox_info = {
+    .name          = TYPE_K230_MAILBOX,
+    .parent        = TYPE_SYS_BUS_DEVICE,
+    .instance_size = sizeof(K230MailboxState),
+    .class_init    = k230_mailbox_class_init,
+};
+
+static void k230_mailbox_register_type(void)
+{
+    type_register_static(&k230_mailbox_info);
+}
+
+type_init(k230_mailbox_register_type)
diff --git a/hw/misc/meson.build b/hw/misc/meson.build
index 23265f6..c0a678b 100644
--- a/hw/misc/meson.build
+++ b/hw/misc/meson.build
@@ -6,6 +6,8 @@ system_ss.add(when: 'CONFIG_ISA_TESTDEV', if_true: files('pc-testdev.c'))
 system_ss.add(when: 'CONFIG_PCI_TESTDEV', if_true: files('pci-testdev.c'))
 system_ss.add(when: 'CONFIG_IOMMU_TESTDEV', if_true: files('iommu-testdev.c'))
 system_ss.add(when: 'CONFIG_UNIMP', if_true: files('unimp.c'))
+system_ss.add(when: 'CONFIG_K230_IOMUX', if_true: files('k230_iomux.c'))
+system_ss.add(when: 'CONFIG_K230_MAILBOX', if_true: files('k230_mailbox.c'))
 system_ss.add(when: 'CONFIG_EMPTY_SLOT', if_true: files('empty_slot.c'))
 system_ss.add(when: 'CONFIG_LED', if_true: files('led.c'))
 system_ss.add(when: 'CONFIG_PVPANIC_COMMON', if_true: files('pvpanic.c'))
diff --git a/hw/misc/trace-events b/hw/misc/trace-events
index c9a868b..5bf28dd 100644
--- a/hw/misc/trace-events
+++ b/hw/misc/trace-events
@@ -442,3 +442,13 @@ iommu_testdev_dma_read(uint64_t gva, uint32_t len) "gva=0x%" PRIx64 " len=%u"
 iommu_testdev_dma_verify(uint32_t expected, uint32_t actual) "expected=0x%x actual=0x%x"
 iommu_testdev_dma_result(uint32_t result) "DMA completed result=0x%x"
 iommu_testdev_dma_armed(bool armed) "armed=%d"
+
+# k230_iomux.c
+k230_iomux_read(uint64_t addr, uint32_t val) "addr 0x%" PRIx64 " val 0x%08x"
+k230_iomux_write(uint64_t addr, uint64_t val) "addr 0x%" PRIx64 " val 0x%" PRIx64
+
+# k230_mailbox.c
+k230_mailbox_read(uint64_t addr, uint32_t val) "addr 0x%" PRIx64 " val 0x%08x"
+k230_mailbox_write(uint64_t addr, uint64_t val) "addr 0x%" PRIx64 " val 0x%" PRIx64
+k230_mailbox_lock_read(int num, uint32_t old) "lock %d old %u"
+k230_mailbox_lock_write(int num, uint64_t val) "lock %d val 0x%" PRIx64
diff --git a/include/hw/misc/k230_iomux.h b/include/hw/misc/k230_iomux.h
new file mode 100644
index 0000000..83c3acf
--- /dev/null
+++ b/include/hw/misc/k230_iomux.h
@@ -0,0 +1,44 @@
+/*
+ * K230 IOMUX (pin configuration) controller
+ *
+ * Copyright (c) 2026 Leo Cheng <chengkelfan@qq.com>
+ *
+ * SPDX-License-Identifier: GPL-2.0-or-later
+ *
+ * Register layout follows the upstream Linux pinctrl-k230 driver.
+ * (64 pins, one 32-bit config register per pin at pin*4).
+ */
+#ifndef HW_MISC_K230_IOMUX_H
+#define HW_MISC_K230_IOMUX_H
+
+#include "hw/core/sysbus.h"
+#include "qom/object.h"
+
+#define TYPE_K230_IOMUX "riscv.k230.iomux"
+OBJECT_DECLARE_SIMPLE_TYPE(K230IomuxState, K230_IOMUX)
+
+#define K230_IOMUX_MMIO_SIZE 0x800
+#define K230_IOMUX_NPINS     64
+
+/* Per-pin config bits (pinctrl-k230.c) */
+#define K230_PC_ST   (1u << 0)        /* schmitt trigger */
+#define K230_PC_DS   (0xfu << 1)      /* drive strength [4:1] */
+#define K230_PC_PD   (1u << 5)        /* pull-down */
+#define K230_PC_PU   (1u << 6)        /* pull-up */
+#define K230_PC_OE   (1u << 7)        /* output enable */
+#define K230_PC_IE   (1u << 8)        /* input enable */
+#define K230_PC_MSC  (1u << 9)        /* power/misc select */
+#define K230_PC_SL   (1u << 10)       /* slew rate */
+#define K230_PC_SEL  (0x7u << 11)     /* function/mux select [13:11] */
+#define K230_PC_MASK (K230_PC_ST | K230_PC_DS | K230_PC_PD | K230_PC_PU | \
+                      K230_PC_OE | K230_PC_IE | K230_PC_MSC | K230_PC_SL | \
+                      K230_PC_SEL)
+
+struct K230IomuxState {
+    SysBusDevice parent_obj;
+
+    MemoryRegion mmio;
+    uint32_t pin[K230_IOMUX_NPINS];
+};
+
+#endif
diff --git a/include/hw/misc/k230_mailbox.h b/include/hw/misc/k230_mailbox.h
new file mode 100644
index 0000000..f939637
--- /dev/null
+++ b/include/hw/misc/k230_mailbox.h
@@ -0,0 +1,61 @@
+/*
+ * K230 mailbox / IPCM block (inter-core interrupt notify + hardware spinlock)
+ *
+ * Copyright (c) 2026 Leo Cheng <chengkelfan@qq.com>
+ *
+ * SPDX-License-Identifier: GPL-2.0-or-later
+ *
+ * The K230 mailbox at 0x91104000 is an interrupt-notification block, not a
+ * data FIFO: payloads travel through shared memory, the mailbox only rings a
+ * doorbell interrupt. Two sub-blocks share the 4KB page:
+ *   - IPCM interrupt registers 0x00-0x24 (CPU2DSP / DSP2CPU EN/SET/CLEAR/
+ *     STATUS/ERR), from Canaan k230_sdk ipcm_platform.h.
+ *   - hardware spinlock array at 0xA0 (128 test-and-set locks), from the
+ *     Canaan k230_sdk drv_hardlock.
+ */
+#ifndef HW_MISC_K230_MAILBOX_H
+#define HW_MISC_K230_MAILBOX_H
+
+#include "hw/core/sysbus.h"
+#include "qom/object.h"
+
+#define TYPE_K230_MAILBOX "riscv.k230.mailbox"
+OBJECT_DECLARE_SIMPLE_TYPE(K230MailboxState, K230_MAILBOX)
+
+#define K230_MAILBOX_MMIO_SIZE 0x1000
+
+/* IPCM interrupt block (ipcm_platform.h) */
+#define K230_MB_CPU2DSP_EN     0x00
+#define K230_MB_CPU2DSP_SET    0x04
+#define K230_MB_CPU2DSP_CLEAR  0x08
+#define K230_MB_CPU2DSP_STATUS 0x0c
+#define K230_MB_CPU2DSP_ERR    0x10
+#define K230_MB_DSP2CPU_EN     0x14
+#define K230_MB_DSP2CPU_SET    0x18
+#define K230_MB_DSP2CPU_CLEAR  0x1c
+#define K230_MB_DSP2CPU_STATUS 0x20
+#define K230_MB_DSP2CPU_ERR    0x24
+
+#define K230_MB_INT_EN     (1u << 0)   /* INTR_EN_EABLE */
+#define K230_MB_INT_SOFTRST (1u << 1)  /* INTR_SOFT_RST_VALID */
+#define K230_MB_INT_RAW_EN (1u << 16)  /* INTR_RAW_EN_EABLE */
+
+/* hardware spinlock array */
+#define K230_MB_HARDLOCK_BASE 0xa0
+#define K230_MB_HARDLOCK_MAX  128
+
+#define K230_MB_CHANNELS 2   /* CPU2DSP, DSP2CPU */
+
+struct K230MailboxState {
+    SysBusDevice parent_obj;
+
+    MemoryRegion mmio;
+    qemu_irq irq[K230_MB_CHANNELS];
+
+    uint32_t en[K230_MB_CHANNELS];
+    uint32_t status[K230_MB_CHANNELS];
+    uint32_t err[K230_MB_CHANNELS];
+    uint8_t lock[K230_MB_HARDLOCK_MAX];
+};
+
+#endif
diff --git a/tests/qtest/k230-iomux-test.c b/tests/qtest/k230-iomux-test.c
new file mode 100644
index 0000000..855d993
--- /dev/null
+++ b/tests/qtest/k230-iomux-test.c
@@ -0,0 +1,62 @@
+/*
+ * QTest testcase for K230 IOMUX
+ *
+ * Copyright (c) 2026 Leo Cheng <chengkelfan@qq.com>
+ *
+ * SPDX-License-Identifier: GPL-2.0-or-later
+ */
+#include "qemu/osdep.h"
+#include "libqtest.h"
+#include "hw/misc/k230_iomux.h"
+
+#define IOMUX_BASE 0x91105000
+
+static void test_reset_values(void)
+{
+    QTestState *qts = qtest_init("-machine k230");
+
+    g_assert_cmphex(qtest_readl(qts, IOMUX_BASE + 0), ==, 0);
+    g_assert_cmphex(qtest_readl(qts, IOMUX_BASE + 63 * 4), ==, 0);
+
+    qtest_quit(qts);
+}
+
+/* Each pin config register is read/write; reserved bits above [13:0] drop */
+static void test_pin_rw(void)
+{
+    QTestState *qts = qtest_init("-machine k230");
+    uint32_t cfg = K230_PC_IE | K230_PC_PU | (3u << 11);  /* IE, PU, SEL=3 */
+
+    qtest_writel(qts, IOMUX_BASE + 5 * 4, cfg);
+    g_assert_cmphex(qtest_readl(qts, IOMUX_BASE + 5 * 4), ==, cfg);
+
+    qtest_writel(qts, IOMUX_BASE + 10 * 4, 0xFFFFFFFF);
+    g_assert_cmphex(qtest_readl(qts, IOMUX_BASE + 10 * 4), ==, K230_PC_MASK);
+
+    /* pin 5 unaffected by pin 10 */
+    g_assert_cmphex(qtest_readl(qts, IOMUX_BASE + 5 * 4), ==, cfg);
+
+    qtest_quit(qts);
+}
+
+/* Registers past the 64-pin window read back zero and ignore writes */
+static void test_out_of_range(void)
+{
+    QTestState *qts = qtest_init("-machine k230");
+
+    qtest_writel(qts, IOMUX_BASE + 64 * 4, 0x1234);
+    g_assert_cmphex(qtest_readl(qts, IOMUX_BASE + 64 * 4), ==, 0);
+
+    qtest_quit(qts);
+}
+
+int main(int argc, char **argv)
+{
+    g_test_init(&argc, &argv, NULL);
+
+    qtest_add_func("/k230-iomux/reset_values", test_reset_values);
+    qtest_add_func("/k230-iomux/pin_rw", test_pin_rw);
+    qtest_add_func("/k230-iomux/out_of_range", test_out_of_range);
+
+    return g_test_run();
+}
diff --git a/tests/qtest/k230-mailbox-test.c b/tests/qtest/k230-mailbox-test.c
new file mode 100644
index 0000000..c3869f0
--- /dev/null
+++ b/tests/qtest/k230-mailbox-test.c
@@ -0,0 +1,89 @@
+/*
+ * QTest testcase for K230 mailbox / IPCM block
+ *
+ * Copyright (c) 2026 Leo Cheng <chengkelfan@qq.com>
+ *
+ * SPDX-License-Identifier: GPL-2.0-or-later
+ */
+#include "qemu/osdep.h"
+#include "libqtest.h"
+#include "hw/misc/k230_mailbox.h"
+
+#define MB_BASE      0x91104000
+#define PLIC_BASE    0xF00000000ULL
+#define PLIC_PENDING (PLIC_BASE + 0x1000)
+#define MB_IRQ0      109
+#define MB_IRQ1      110
+
+static bool plic_pending(QTestState *qts, int irq)
+{
+    uint32_t word = qtest_readl(qts, PLIC_PENDING + (irq / 32) * 4);
+    return (word >> (irq % 32)) & 1;
+}
+
+/* SET rings the doorbell only when the channel interrupt is enabled */
+static void test_doorbell_cpu2dsp(void)
+{
+    QTestState *qts = qtest_init("-machine k230");
+
+    /* SET with interrupt disabled: no doorbell */
+    qtest_writel(qts, MB_BASE + K230_MB_CPU2DSP_SET, 0);
+    g_assert_false(plic_pending(qts, MB_IRQ0));
+    qtest_writel(qts, MB_BASE + K230_MB_CPU2DSP_CLEAR, 0);
+
+    /* enable, then SET rings the doorbell and latches STATUS */
+    qtest_writel(qts, MB_BASE + K230_MB_CPU2DSP_EN, K230_MB_INT_EN);
+    qtest_writel(qts, MB_BASE + K230_MB_CPU2DSP_SET, 0);
+    g_assert_true(plic_pending(qts, MB_IRQ0));
+    g_assert_cmpuint(qtest_readl(qts, MB_BASE + K230_MB_CPU2DSP_STATUS), ==, 1);
+
+    /* CLEAR acks and drops STATUS */
+    qtest_writel(qts, MB_BASE + K230_MB_CPU2DSP_CLEAR, 0);
+    g_assert_cmpuint(qtest_readl(qts, MB_BASE + K230_MB_CPU2DSP_STATUS), ==, 0);
+
+    qtest_quit(qts);
+}
+
+/* The reverse channel rings its own doorbell line */
+static void test_doorbell_dsp2cpu(void)
+{
+    QTestState *qts = qtest_init("-machine k230");
+
+    qtest_writel(qts, MB_BASE + K230_MB_DSP2CPU_EN, K230_MB_INT_EN);
+    qtest_writel(qts, MB_BASE + K230_MB_DSP2CPU_SET, 0);
+    g_assert_true(plic_pending(qts, MB_IRQ1));
+    g_assert_false(plic_pending(qts, MB_IRQ0));   /* independent of ch0 */
+
+    qtest_quit(qts);
+}
+
+/* Hardlock array at 0xA0: read = test-and-set, write 0 = release */
+static void test_hardlock(void)
+{
+    QTestState *qts = qtest_init("-machine k230");
+    hwaddr l0 = MB_BASE + K230_MB_HARDLOCK_BASE;
+
+    g_assert_cmpuint(qtest_readl(qts, l0), ==, 0);   /* acquired */
+    g_assert_cmpuint(qtest_readl(qts, l0), ==, 1);   /* busy */
+    qtest_writel(qts, l0, 0);                         /* release */
+    g_assert_cmpuint(qtest_readl(qts, l0), ==, 0);   /* acquired again */
+
+    /* independence + last lock */
+    g_assert_cmpuint(qtest_readl(qts, l0 + 4), ==, 0);
+    g_assert_cmpuint(qtest_readl(qts, l0), ==, 1);
+    g_assert_cmpuint(qtest_readl(qts,
+                     l0 + (K230_MB_HARDLOCK_MAX - 1) * 4), ==, 0);
+
+    qtest_quit(qts);
+}
+
+int main(int argc, char **argv)
+{
+    g_test_init(&argc, &argv, NULL);
+
+    qtest_add_func("/k230-mailbox/doorbell_cpu2dsp", test_doorbell_cpu2dsp);
+    qtest_add_func("/k230-mailbox/doorbell_dsp2cpu", test_doorbell_dsp2cpu);
+    qtest_add_func("/k230-mailbox/hardlock", test_hardlock);
+
+    return g_test_run();
+}
-- 
2.43.0


