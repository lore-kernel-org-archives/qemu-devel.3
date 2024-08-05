Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 87A7AC52D70
	for <qemu-devel@archiver.kernel.org>; Mon,  5 Aug 2024 20:18:07 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sb49Q-0003Vy-Qd; Mon, 05 Aug 2024 16:17:52 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from
 <3YjOxZgUKCsk8pAx4v33v0t.r315t19-stAt0232v29.36v@flex--tavip.bounces.google.com>)
 id 1sb49L-00036o-7N
 for qemu-devel@nongnu.org; Mon, 05 Aug 2024 16:17:47 -0400
Received: from mail-pf1-x44a.google.com ([2607:f8b0:4864:20::44a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from
 <3YjOxZgUKCsk8pAx4v33v0t.r315t19-stAt0232v29.36v@flex--tavip.bounces.google.com>)
 id 1sb49G-0001TF-4f
 for qemu-devel@nongnu.org; Mon, 05 Aug 2024 16:17:46 -0400
Received: by mail-pf1-x44a.google.com with SMTP id
 d2e1a72fcca58-70d1df50db2so119812b3a.0
 for <qemu-devel@nongnu.org>; Mon, 05 Aug 2024 13:17:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=google.com; s=20230601; t=1722889059; x=1723493859; darn=nongnu.org;
 h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
 :date:from:to:cc:subject:date:message-id:reply-to;
 bh=c49N6GGLSy9opjp4muaxH3Sb0XY//FAQu7ZNOX8Wu58=;
 b=vqSoI7DLM/cSp6I0LFfQiKIqAqtTP002ZrWTS9RaWynuJf5b5537cjjHfqOK4r6muH
 dNf4tKJpOtsrerBMBjIxiq8G8Sm1wINPTwn2nlfmKFL7M8oLYQtzGLWWm27KBDAxoCbj
 t/MO5P9prmHBwaS20V0q7LbRnnIDfuKTep1r6IGkxiMs/V7mURQq6L4F708dIQY+NSdv
 o3D+Ua0F4515uwddrY5lCKYQaKrefGgGMDV/OhY5cxTqPuHAT5HnSASODGDWlkYTglS9
 Y14ZXH+TlGc2JX38rLffjVn3yEl6Ns/rC9LODH+yVPDNMQLMan+3vknMvCbt3n/Dk0w8
 zhVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1722889059; x=1723493859;
 h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
 :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=c49N6GGLSy9opjp4muaxH3Sb0XY//FAQu7ZNOX8Wu58=;
 b=J4JqAmxyE2DUkhLcwZ41x+GeAvZGI/8dKdufpAuMtiv+bhhSzWMLG4o/i50lrvynBQ
 1/AA9PNIno0VeV07nplTZicMsnMEz0fsaWRT0kbO7GspNoO7ltJDGS0Gc96F37dMaYhy
 fuefQuSY1OxNMdq2essoRxwuYq8cSWh149Be2ilbvGSI3+gK8bNATNsruaeDbI3TnI5v
 i10uFOOjyaM/iHwqMWx97lTzjYd0ui27zfGokbVTml0n2j1tTDXBWI7vYwhfZH/Duvul
 pQdj2SKTPWlcCQpWk0WhjZaTYjHBOvkmtrGny1N2MLmhJK3TvCY95zBnWxL7m1hdV6tM
 1YKQ==
X-Gm-Message-State: AOJu0Yy3oCrV4C6opW2toStU/7PeSir8L7Y/UXZg0VHO12DfmtSCDoGi
 3TXdQAQ/mZvUf6+LBknBt2RGKIpIEWDnCyyogeHxPIFGG7t21DnfHfU9bxAiPPUpwMqOfO0Ngr1
 pnBp5OmtMI/+n55qtq8/qvBWbyaWhHu8mEjZk6hJ8plDGEgxoCeHAo8f3Px8DTZ/EjYGrZTB+u7
 8gwxUqFV1T464M/JbH4qqp3OVIQg==
X-Google-Smtp-Source: AGHT+IHUhdCBb2qP/Rfk7DkSllCc8S8AqxUyTM4uvF8QUbFgLoRBTH1nTm66VqdJDI0OhIag0/X4LPzILQ==
X-Received: from warp10.c.googlers.com ([fda3:e722:ac3:cc00:24:72f4:c0a8:750])
 (user=tavip job=sendgmr) by 2002:a05:6a00:85a1:b0:70d:1b0d:a15d
 with SMTP id
 d2e1a72fcca58-71065f30ddfmr146221b3a.3.1722889058476; Mon, 05 Aug 2024
 13:17:38 -0700 (PDT)
Date: Mon,  5 Aug 2024 13:17:05 -0700
In-Reply-To: <20240805201719.2345596-1-tavip@google.com>
Mime-Version: 1.0
References: <20240805201719.2345596-1-tavip@google.com>
X-Mailer: git-send-email 2.46.0.rc2.264.g509ed76dc8-goog
Message-ID: <20240805201719.2345596-11-tavip@google.com>
Subject: [RFC PATCH 10/23] hw/char: add support for flexcomm usart
From: Octavian Purdila <tavip@google.com>
To: qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org, stefanst@google.com, pbonzini@redhat.com, 
 alex.bennee@linaro.org, thuth@redhat.com, peter.maydell@linaro.org, 
 marcandre.lureau@redhat.com, alistair@alistair23.me, berrange@redhat.com, 
 philmd@linaro.org, jsnow@redhat.com, crosa@redhat.com, bleal@redhat.com
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::44a;
 envelope-from=3YjOxZgUKCsk8pAx4v33v0t.r315t19-stAt0232v29.36v@flex--tavip.bounces.google.com;
 helo=mail-pf1-x44a.google.com
X-Spam_score_int: -95
X-Spam_score: -9.6
X-Spam_bar: ---------
X-Spam_report: (-9.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_MED=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 USER_IN_DEF_DKIM_WL=-7.5 autolearn=ham autolearn_force=no
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

Add support for NXP's flexcomm usart. It supports interupts and FIFO
access but no DMA.

Signed-off-by: Octavian Purdila <tavip@google.com>
---
 hw/arm/svd/meson.build           |   4 +
 hw/char/flexcomm_usart.c         | 302 +++++++++++++++++++++++++++++++
 hw/char/meson.build              |   1 +
 hw/char/trace-events             |   9 +
 hw/misc/flexcomm.c               |   9 +
 include/hw/char/flexcomm_usart.h |  20 ++
 include/hw/misc/flexcomm.h       |   6 +
 tests/unit/meson.build           |   3 +-
 8 files changed, 353 insertions(+), 1 deletion(-)
 create mode 100644 hw/char/flexcomm_usart.c
 create mode 100644 include/hw/char/flexcomm_usart.h

diff --git a/hw/arm/svd/meson.build b/hw/arm/svd/meson.build
index 9ce6c1d838..ed0f69f437 100644
--- a/hw/arm/svd/meson.build
+++ b/hw/arm/svd/meson.build
@@ -2,3 +2,7 @@ genh += custom_target('flexcomm.h',
                       output: 'flexcomm.h',
                       input: 'MIMXRT595S_cm33.xml',
                       command: [ svd_gen_header, '-i', '@INPUT@', '-o', '@OUTPUT@', '-p', 'FLEXCOMM0', '-t', 'FLEXCOMM'])
+genh += custom_target('flexcomm_usart.h',
+                      output: 'flexcomm_usart.h',
+                      input: 'MIMXRT595S_cm33.xml',
+                      command: [ svd_gen_header, '-i', '@INPUT@', '-o', '@OUTPUT@', '-p', 'USART0', '-t', 'FLEXCOMM_USART'])
diff --git a/hw/char/flexcomm_usart.c b/hw/char/flexcomm_usart.c
new file mode 100644
index 0000000000..c00106eee6
--- /dev/null
+++ b/hw/char/flexcomm_usart.c
@@ -0,0 +1,302 @@
+/*
+ * QEMU model for NXP's FLEXCOMM USART
+ *
+ * Copyright (c) 2024 Google LLC
+ *
+ * SPDX-License-Identifier: GPL-2.0-or-later
+ *
+ * This work is licensed under the terms of the GNU GPL, version 2 or later.
+ * See the COPYING file in the top-level directory.
+ */
+
+#include "qemu/osdep.h"
+#include "qemu/cutils.h"
+#include "hw/irq.h"
+#include "hw/qdev-properties.h"
+#include "qemu/log.h"
+#include "qemu/module.h"
+#include "exec/address-spaces.h"
+#include "qapi/error.h"
+#include "trace.h"
+#include "hw/regs.h"
+#include "hw/char/flexcomm_usart.h"
+
+#define reg(field) offsetof(FLEXCOMM_USART_Type, field)
+#define regi(x) (reg(x) / sizeof(uint32_t))
+#define REG_NO (sizeof(FLEXCOMM_USART_Type) / sizeof(uint32_t))
+
+static FLEXCOMM_USART_REGISTER_NAMES_ARRAY(reg_names);
+
+static void flexcomm_usart_reset(FlexcommState *s)
+{
+    flexcomm_usart_reset_registers(&s->regs.usart);
+}
+
+static void update_fifo_stat(FlexcommState *s)
+{
+    int rxlvl = fifo32_num_used(&s->rx_fifo);
+    int txlvl = fifo32_num_used(&s->tx_fifo);
+
+    s->regs.usart.FIFOSTAT_b.RXLVL = fifo32_num_used(&s->rx_fifo);
+    s->regs.usart.FIFOSTAT_b.TXLVL = fifo32_num_used(&s->tx_fifo);
+    s->regs.usart.FIFOSTAT_b.RXFULL = fifo32_is_full(&s->rx_fifo) ? 1 : 0;
+    s->regs.usart.FIFOSTAT_b.RXNOTEMPTY = !fifo32_is_empty(&s->rx_fifo) ? 1 : 0;
+    s->regs.usart.FIFOSTAT_b.TXNOTFULL = !fifo32_is_full(&s->tx_fifo) ? 1 : 0;
+    s->regs.usart.FIFOSTAT_b.TXEMPTY = fifo32_is_empty(&s->tx_fifo) ? 1 : 0;
+
+    if (s->regs.usart.FIFOTRIG_b.RXLVLENA &&
+        (rxlvl > s->regs.usart.FIFOTRIG_b.RXLVL)) {
+        s->regs.usart.FIFOINTSTAT_b.RXLVL = 1;
+    } else {
+        s->regs.usart.FIFOINTSTAT_b.RXLVL = 0;
+    }
+
+    if (s->regs.usart.FIFOTRIG_b.TXLVLENA &&
+        (txlvl <= s->regs.usart.FIFOTRIG_b.TXLVL)) {
+        s->regs.usart.FIFOINTSTAT_b.TXLVL = 1;
+    } else {
+        s->regs.usart.FIFOINTSTAT_b.TXLVL = 0;
+    }
+
+    trace_flexcomm_usart_fifostat(DEVICE(s)->id, s->regs.usart.FIFOSTAT,
+                                 s->regs.usart.FIFOINTSTAT);
+}
+
+static void flexcomm_usart_irq_update(FlexcommState *s)
+{
+    bool irq, per_irqs, fifo_irqs, enabled = s->regs.usart.CFG_b.ENABLE;
+
+    update_fifo_stat(s);
+    fifo_irqs = s->regs.usart.FIFOINTSTAT & s->regs.usart.FIFOINTENSET;
+
+    s->regs.usart.INTSTAT = s->regs.usart.STAT & s->regs.usart.INTENSET;
+    per_irqs = s->regs.usart.INTSTAT != 0;
+
+    irq = enabled && (fifo_irqs || per_irqs);
+
+    trace_flexcomm_usart_irq(DEVICE(s)->id, irq, fifo_irqs, per_irqs, enabled);
+    flexcomm_irq(s, irq);
+}
+
+static int flexcomm_usart_rx_space(void *opaque)
+{
+    FlexcommState *s = opaque;
+    uint32_t ret = fifo32_num_free(&s->rx_fifo);
+
+    if (!s->regs.usart.CFG_b.ENABLE || !s->regs.usart.FIFOCFG_b.ENABLERX) {
+        ret = 0;
+    }
+
+    trace_flexcomm_usart_rx_space(DEVICE(s)->id, ret);
+
+    return ret;
+}
+
+static void flexcomm_usart_rx(void *opaque, const uint8_t *buf, int size)
+{
+    FlexcommState *s = opaque;
+
+    if (!s->regs.usart.CFG_b.ENABLE || !s->regs.usart.FIFOCFG_b.ENABLERX) {
+        return;
+    }
+
+    trace_flexcomm_usart_rx(DEVICE(s)->id);
+
+    while (!fifo32_is_full(&s->rx_fifo) && size) {
+        fifo32_push(&s->rx_fifo, *buf++);
+        size--;
+    }
+
+    flexcomm_usart_irq_update(s);
+}
+
+static MemTxResult flexcomm_usart_reg_read(void *opaque, FlexcommState *s,
+                                          int f, hwaddr addr, uint64_t *data,
+                                          unsigned size)
+{
+    MemTxResult ret = MEMTX_OK;
+
+    if (!reg32_aligned_access(addr, size)) {
+        ret = MEMTX_ERROR;
+        goto out;
+    }
+
+    switch (addr) {
+    case reg(FIFORD):
+    {
+        if (!fifo32_is_empty(&s->rx_fifo)) {
+            *data = fifo32_pop(&s->rx_fifo);
+            qemu_chr_fe_accept_input(&s->chr);
+        }
+        break;
+    }
+    case reg(FIFORDNOPOP):
+    {
+        if (!fifo32_is_empty(&s->rx_fifo)) {
+            *data = fifo32_peek(&s->rx_fifo);
+        }
+        break;
+    }
+    default:
+        *data = reg32_read(&s->regs, addr);
+        break;
+    }
+
+    flexcomm_usart_irq_update(s);
+
+out:
+    trace_flexcomm_usart_reg_read(DEVICE(s)->id, reg_names[addr], addr, *data);
+    return ret;
+}
+
+static MemTxResult flexcomm_usart_reg_write(void *opaque, FlexcommState *s,
+                                           int f, hwaddr addr, uint64_t value,
+                                           unsigned size)
+{
+    MemTxResult ret = MEMTX_OK;
+    static uint32_t mask[REG_NO] = {
+        [regi(CFG)] = BITS(23, 18) | BITS(15, 14) | BITS(12, 11) | BITS(9, 2) |
+                      BIT(0),
+        [regi(CTL)] = BIT(16) | BITS(9, 8) | BIT(6) | BITS(2, 1),
+        [regi(STAT)] = BITS(16, 11) | BIT(5),
+        [regi(INTENSET)] = BITS(16, 11) | BITS(6, 5) | BIT(3),
+        [regi(INTENCLR)] = BITS(16, 11) | BITS(6, 5) | BIT(3),
+        [regi(BRG)] = BITS(15, 0),
+        [regi(OSR)] = BITS(3, 0),
+        [regi(ADDR)] = BITS(7, 0),
+        [regi(FIFOCFG)] = BITS(16, 12) | BITS(5, 4) | BITS(1, 0),
+        [regi(FIFOSTAT)] = BITS(1, 0),
+        [regi(FIFOTRIG)] = BITS(19, 16) | BITS(11, 8) | BITS(1, 0),
+        [regi(FIFOINTENSET)] = BITS(3, 0),
+        [regi(FIFOINTENCLR)] = BITS(3, 0),
+        [regi(FIFOWR)] = BITS(8, 0),
+    };
+
+    if (!reg32_aligned_access(addr, size)) {
+        ret = MEMTX_ERROR;
+        goto out;
+    }
+
+    switch (addr) {
+    case reg(INTENCLR):
+    {
+        reg32_write(&s->regs, addr, value, mask);
+        s->regs.usart.INTENSET &= ~s->regs.usart.INTENCLR;
+        break;
+    }
+    case reg(FIFOCFG):
+    {
+        reg32_write(&s->regs, addr, value, mask);
+        if (s->regs.usart.FIFOCFG_b.EMPTYRX) {
+            s->regs.usart.FIFOCFG_b.EMPTYRX = 0;
+            fifo32_reset(&s->rx_fifo);
+        }
+        if (s->regs.usart.FIFOCFG_b.EMPTYTX) {
+            s->regs.usart.FIFOCFG_b.EMPTYTX = 0;
+            fifo32_reset(&s->tx_fifo);
+        }
+        break;
+    }
+    case reg(FIFOSTAT):
+    {
+        bool rxerr = s->regs.usart.FIFOSTAT_b.RXERR;
+        bool txerr = s->regs.usart.FIFOSTAT_b.TXERR;
+
+        reg32_write(&s->regs, addr, value, mask);
+
+        if (rxerr && s->regs.usart.FIFOSTAT_b.RXERR) {
+            rxerr = false;
+        }
+        if (txerr && s->regs.usart.FIFOSTAT_b.TXERR) {
+            txerr = false;
+        }
+
+        s->regs.usart.FIFOSTAT_b.RXERR = rxerr;
+        s->regs.usart.FIFOSTAT_b.TXERR = txerr;
+        break;
+    }
+    case reg(FIFOINTENSET):
+    {
+        s->regs.usart.FIFOINTENSET |= value & mask[addr / 4];
+        break;
+    }
+    case reg(FIFOINTENCLR):
+    {
+        reg32_write(&s->regs, addr, value, mask);
+        s->regs.usart.FIFOINTENSET &= ~s->regs.usart.FIFOINTENCLR;
+        break;
+    }
+    case reg(FIFOWR):
+    {
+        reg32_write(&s->regs, addr, value, mask);
+        if (!fifo32_is_full(&s->tx_fifo)) {
+            fifo32_push(&s->tx_fifo, s->regs.usart.FIFOWR);
+        }
+
+        if (!s->regs.usart.CFG_b.ENABLE || !s->regs.usart.FIFOCFG_b.ENABLETX) {
+            break;
+        }
+
+        while (!fifo32_is_empty(&s->tx_fifo)) {
+            uint32_t val32 = fifo32_pop(&s->tx_fifo);
+            uint8_t val8 = val32 & 0xff;
+
+            trace_flexcomm_usart_tx(DEVICE(s)->id);
+            qemu_chr_fe_write_all(&s->chr, &val8, sizeof(val8));
+        }
+        break;
+    }
+    case reg(CFG):
+    {
+        reg32_write(&s->regs, addr, value, mask);
+        break;
+    }
+    default:
+        reg32_write(&s->regs, addr, value, mask);
+        break;
+    }
+
+    flexcomm_usart_irq_update(s);
+
+out:
+    trace_flexcomm_usart_reg_write(DEVICE(s)->id, reg_names[addr], addr, value);
+    return ret;
+}
+
+static void flexcomm_usart_select(void *opaque, FlexcommState *s, int f,
+                                 bool set)
+{
+    if (set) {
+        qemu_chr_fe_set_handlers(&s->chr, flexcomm_usart_rx_space,
+                             flexcomm_usart_rx, NULL, NULL,
+                             s, NULL, true);
+        flexcomm_usart_reset(s);
+        fifo32_create(&s->rx_fifo, s->regs.usart.FIFOSIZE_b.FIFOSIZE);
+        fifo32_create(&s->tx_fifo, s->regs.usart.FIFOSIZE_b.FIFOSIZE);
+    } else {
+        qemu_chr_fe_set_handlers(&s->chr, NULL, NULL, NULL, NULL, NULL, NULL,
+                                 false);
+        fifo32_destroy(&s->rx_fifo);
+        fifo32_destroy(&s->tx_fifo);
+    }
+}
+
+static const FlexcommFunctionOps flexcomm_usart_ops = {
+    .select = flexcomm_usart_select,
+    .reg_read = flexcomm_usart_reg_read,
+    .reg_write = flexcomm_usart_reg_write,
+};
+
+void flexcomm_usart_init(FlexcommState *s)
+{
+}
+
+void flexcomm_usart_register(void)
+{
+    Error *err = NULL;
+
+    if (!flexcomm_register_ops(FLEXCOMM_FUNC_USART, NULL,
+                               &flexcomm_usart_ops, &err)) {
+        error_report_err(err);
+    }
+}
diff --git a/hw/char/meson.build b/hw/char/meson.build
index e5b13b6958..8f8c17ae66 100644
--- a/hw/char/meson.build
+++ b/hw/char/meson.build
@@ -39,3 +39,4 @@ system_ss.add(when: 'CONFIG_GOLDFISH_TTY', if_true: files('goldfish_tty.c'))
 specific_ss.add(when: 'CONFIG_TERMINAL3270', if_true: files('terminal3270.c'))
 specific_ss.add(when: 'CONFIG_VIRTIO', if_true: files('virtio-serial-bus.c'))
 specific_ss.add(when: 'CONFIG_PSERIES', if_true: files('spapr_vty.c'))
+system_ss.add(when: 'CONFIG_FLEXCOMM', if_true: files('flexcomm_usart.c'))
diff --git a/hw/char/trace-events b/hw/char/trace-events
index 8875758076..19fcf1f832 100644
--- a/hw/char/trace-events
+++ b/hw/char/trace-events
@@ -125,3 +125,12 @@ xen_console_unrealize(unsigned int idx) "idx %u"
 xen_console_realize(unsigned int idx, const char *chrdev) "idx %u chrdev %s"
 xen_console_device_create(unsigned int idx) "idx %u"
 xen_console_device_destroy(unsigned int idx) "idx %u"
+
+# flexcomm_usart.c
+flexcomm_usart_reg_read(const char *id, const char *reg_name, uint32_t addr, uint32_t val) " %s: %s[0x%04x] -> 0x%08x"
+flexcomm_usart_reg_write(const char *id, const char *reg_name, uint32_t addr, uint32_t val) "%s: %s[0x%04x] <- 0x%08x"
+flexcomm_usart_rx_space(const char *id, uint32_t rx) "%s: %d"
+flexcomm_usart_rx(const char *id) "%s"
+flexcomm_usart_tx(const char *id) "%s"
+flexcomm_usart_fifostat(const char *id, uint32_t fifostat, uint32_t fifoinstat) "%s: %08x %08x"
+flexcomm_usart_irq(const char *id, bool irq, bool fifoirqs, bool perirqs, bool enabled) "%s: %d %d %d %d"
diff --git a/hw/misc/flexcomm.c b/hw/misc/flexcomm.c
index 6ec3773910..0c94928aa2 100644
--- a/hw/misc/flexcomm.c
+++ b/hw/misc/flexcomm.c
@@ -22,6 +22,7 @@
 #include "trace.h"
 #include "hw/regs.h"
 #include "hw/misc/flexcomm.h"
+#include "hw/char/flexcomm_usart.h"
 
 #define reg(field) offsetof(FLEXCOMM_Type, field)
 #define regi(x) (reg(x) / sizeof(uint32_t))
@@ -203,6 +204,7 @@ static const MemoryRegionOps flexcomm_ops = {
 static Property flexcomm_properties[] = {
     DEFINE_PROP_UINT32("functions", FlexcommState, functions,
                        FLEXCOMM_FULL),
+    DEFINE_PROP_CHR("chardev", FlexcommState, chr),
     DEFINE_PROP_END_OF_LIST(),
 };
 
@@ -221,6 +223,11 @@ static void flexcomm_init(Object *obj)
 
 static void flexcomm_realize(DeviceState *dev, Error **errp)
 {
+    FlexcommState *s = FLEXCOMM(dev);
+
+    if (has_function(s, FLEXCOMM_FUNC_USART)) {
+        flexcomm_usart_init(s);
+    }
 }
 
 static void flexcomm_class_init(ObjectClass *klass, void *data)
@@ -230,6 +237,8 @@ static void flexcomm_class_init(ObjectClass *klass, void *data)
     dc->reset = flexcomm_reset;
     device_class_set_props(dc, flexcomm_properties);
     dc->realize = flexcomm_realize;
+
+    flexcomm_usart_register();
 }
 
 static const TypeInfo flexcomm_info = {
diff --git a/include/hw/char/flexcomm_usart.h b/include/hw/char/flexcomm_usart.h
new file mode 100644
index 0000000000..07d14cb330
--- /dev/null
+++ b/include/hw/char/flexcomm_usart.h
@@ -0,0 +1,20 @@
+/*
+ * QEMU model for NXP's FLEXCOMM USART
+ *
+ * Copyright (c) 2024 Google LLC
+ *
+ * SPDX-License-Identifier: GPL-2.0-or-later
+ *
+ * This work is licensed under the terms of the GNU GPL, version 2 or later.
+ * See the COPYING file in the top-level directory.
+ */
+
+#ifndef HW_CHAR_FLEXCOMM_USART_H
+#define HW_CHAR_FLEXCOMM_USART_H
+
+#include "hw/misc/flexcomm.h"
+
+void flexcomm_usart_init(FlexcommState *s);
+void flexcomm_usart_register(void);
+
+#endif /* HW_CHAR_RT500_FLEXCOMM_USART_H */
diff --git a/include/hw/misc/flexcomm.h b/include/hw/misc/flexcomm.h
index 422452bd96..db76e32c6d 100644
--- a/include/hw/misc/flexcomm.h
+++ b/include/hw/misc/flexcomm.h
@@ -13,7 +13,9 @@
 #define HW_FLEXCOMM_H
 
 #include "hw/sysbus.h"
+#include "chardev/char-fe.h"
 #include "hw/arm/svd/flexcomm.h"
+#include "hw/arm/svd/flexcomm_usart.h"
 #include "qemu/fifo32.h"
 
 #define TYPE_FLEXCOMM "flexcomm"
@@ -43,10 +45,14 @@ typedef struct {
     MemoryRegion mmio;
     union {
         FLEXCOMM_Type flex;
+        FLEXCOMM_USART_Type usart;
     } regs;
     uint32_t functions;
     qemu_irq irq;
     bool irq_state;
+    CharBackend chr;
+    Fifo32 tx_fifo;
+    Fifo32 rx_fifo;
 } FlexcommState;
 
 typedef struct {
diff --git a/tests/unit/meson.build b/tests/unit/meson.build
index 4ccb15404d..70e816c034 100644
--- a/tests/unit/meson.build
+++ b/tests/unit/meson.build
@@ -143,10 +143,11 @@ if have_system
     'test-vmstate': [migration, io],
     'test-yank': ['socket-helpers.c', qom, io, chardev],
     'test-flexcomm': [
-      hwcore,
+      hwcore, chardev, qom, migration,
       meson.project_source_root() / 'hw/core/gpio.c',
       meson.project_source_root() / 'tests/unit/sysbus-mock.c',
       meson.project_source_root() / 'hw/misc/flexcomm.c',
+      meson.project_source_root() / 'hw/char/flexcomm_usart.c',
      ],
   }
   if config_host_data.get('CONFIG_INOTIFY1')
-- 
2.46.0.rc2.264.g509ed76dc8-goog


