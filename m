Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 088ADC3DA4A
	for <qemu-devel@archiver.kernel.org>; Mon,  5 Aug 2024 20:19:23 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sb49S-0003cc-2V; Mon, 05 Aug 2024 16:17:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from
 <3ZTOxZgUKCswBsD07y66y3w.u648w4C-vwDw3565y5C.69y@flex--tavip.bounces.google.com>)
 id 1sb49O-0003L9-GY
 for qemu-devel@nongnu.org; Mon, 05 Aug 2024 16:17:51 -0400
Received: from mail-pj1-x104a.google.com ([2607:f8b0:4864:20::104a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from
 <3ZTOxZgUKCswBsD07y66y3w.u648w4C-vwDw3565y5C.69y@flex--tavip.bounces.google.com>)
 id 1sb49L-0001Tr-Gg
 for qemu-devel@nongnu.org; Mon, 05 Aug 2024 16:17:49 -0400
Received: by mail-pj1-x104a.google.com with SMTP id
 98e67ed59e1d1-2cb4d02f34cso10950096a91.3
 for <qemu-devel@nongnu.org>; Mon, 05 Aug 2024 13:17:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=google.com; s=20230601; t=1722889063; x=1723493863; darn=nongnu.org;
 h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
 :date:from:to:cc:subject:date:message-id:reply-to;
 bh=JJx2zYTysuPPGq4jl/CUtBvGg4dYG4R93ytcuWg1fhs=;
 b=eFeDg+4ImBxloSjupfPH3XHn743nG7QTAZpYTG5QEt2aUMeLAwZJWTwVbZxQJIXRw1
 yqB+f4GFKP8FxMCt7VNC31bz8qCgF0AbR1N3NC/mR7z1VaCxWwnO8Sa2PCsATfDUJsIr
 IWIgLLZZ88C9j1Ju56JVABv1YF4kFna8cR+2vNPs/JLYbhl1YWt8El6rI1nJ3kE/jwBw
 pnKnYQjSHxI4CWZSEjsFUyXkILViD0ttHF4YcnHuLGM6Sq8SbAdwjCkN6N0fO6zubt/i
 9j2imVM35EI5cjt8c/lmTP4qnRfv9+a5JrHEP1DcXJIos5LmS63try320nFsuiHxprMq
 sehA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1722889063; x=1723493863;
 h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
 :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=JJx2zYTysuPPGq4jl/CUtBvGg4dYG4R93ytcuWg1fhs=;
 b=liEvEp8wY2CEQQbg7kDancJLogpSktcplHG3QwFokPN1vMV9HkDsmS4WAPleYT82uB
 9meUuZnBUWMOjCKcGDNeWSrSyN7Lx/eKGDGm55bmxjmUJh0SPnAyDtSuKEHf8GMCxgz1
 69Is21NqbRcjtBstjcmuxTsicbJEsIrO+T/PJJWnequKVpoLZqKew4NyQCk1xgrmWa0+
 +qRI+ubtS1jEOjkiqVwD4v/7QxDj8FXrQPUUMD8nYcAPVHd9iW735OBbVHOQTr+pBSb4
 sRfXkdKOQbwt4kPo++o5g+7Xy6gSQGgoWl1fduH4ILLeHDGtflctPVFkRIswFDRMTttg
 nS0Q==
X-Gm-Message-State: AOJu0YzLSyR4IQKMeVh7ziyNNNSVM8Pi4x1uCXdmY30HbVaQ55elL3Jo
 o6PoT3+OsT71z6wftNFSaHjGcEXgjr0h+7/tmjoCz7aIFluHtXYocEEvJ32pZPglqAt4e9bC2Q3
 MzCXQbWuGzhulgejxFwWlzzetNqUD5UY0S+zVogSquuRsXI/H6Rh0ke86G2PMm33cQz+hZsRAWg
 wvFXf/UwVN8pKz2wSs12QtC7LRyA==
X-Google-Smtp-Source: AGHT+IFJ6HmLYx+llIq607FEkRA2hqMCqRAGPVf+vAAKgX7jthaVgxS/Ia/9f+16jdToHqdzT0ceAn1c4g==
X-Received: from warp10.c.googlers.com ([fda3:e722:ac3:cc00:24:72f4:c0a8:750])
 (user=tavip job=sendgmr) by 2002:a17:90b:3e8c:b0:2c9:9208:ee66
 with SMTP id
 98e67ed59e1d1-2cff956d6f7mr34756a91.7.1722889061818; Mon, 05 Aug 2024
 13:17:41 -0700 (PDT)
Date: Mon,  5 Aug 2024 13:17:07 -0700
In-Reply-To: <20240805201719.2345596-1-tavip@google.com>
Mime-Version: 1.0
References: <20240805201719.2345596-1-tavip@google.com>
X-Mailer: git-send-email 2.46.0.rc2.264.g509ed76dc8-goog
Message-ID: <20240805201719.2345596-13-tavip@google.com>
Subject: [RFC PATCH 12/23] hw/i2c: add support for flexcomm i2c
From: Octavian Purdila <tavip@google.com>
To: qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org, stefanst@google.com, pbonzini@redhat.com, 
 alex.bennee@linaro.org, thuth@redhat.com, peter.maydell@linaro.org, 
 marcandre.lureau@redhat.com, alistair@alistair23.me, berrange@redhat.com, 
 philmd@linaro.org, jsnow@redhat.com, crosa@redhat.com, bleal@redhat.com
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::104a;
 envelope-from=3ZTOxZgUKCswBsD07y66y3w.u648w4C-vwDw3565y5C.69y@flex--tavip.bounces.google.com;
 helo=mail-pj1-x104a.google.com
X-Spam_score_int: -95
X-Spam_score: -9.6
X-Spam_bar: ---------
X-Spam_report: (-9.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_MED=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 USER_IN_DEF_DKIM_WL=-7.5 autolearn=unavailable autolearn_force=no
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

Add support for NXP's flexcomm i2c. It does not support slave mode or
DMA.

Signed-off-by: Octavian Purdila <tavip@google.com>
---
 hw/arm/svd/meson.build        |   4 +
 hw/i2c/flexcomm_i2c.c         | 224 ++++++++++++++++++++++++++++++++++
 hw/i2c/meson.build            |   1 +
 hw/i2c/trace-events           |  10 ++
 hw/misc/flexcomm.c            |   6 +
 include/hw/i2c/flexcomm_i2c.h |  27 ++++
 include/hw/misc/flexcomm.h    |   4 +
 tests/unit/meson.build        |   4 +
 8 files changed, 280 insertions(+)
 create mode 100644 hw/i2c/flexcomm_i2c.c
 create mode 100644 include/hw/i2c/flexcomm_i2c.h

diff --git a/hw/arm/svd/meson.build b/hw/arm/svd/meson.build
index ed0f69f437..fa0d3da829 100644
--- a/hw/arm/svd/meson.build
+++ b/hw/arm/svd/meson.build
@@ -6,3 +6,7 @@ genh += custom_target('flexcomm_usart.h',
                       output: 'flexcomm_usart.h',
                       input: 'MIMXRT595S_cm33.xml',
                       command: [ svd_gen_header, '-i', '@INPUT@', '-o', '@OUTPUT@', '-p', 'USART0', '-t', 'FLEXCOMM_USART'])
+genh += custom_target('flexcomm_i2c_regs.h',
+                      output: 'flexcomm_i2c.h',
+                      input: 'MIMXRT595S_cm33.xml',
+                      command: [ svd_gen_header, '-i', '@INPUT@', '-o', '@OUTPUT@', '-p', 'I2C0', '-t', 'FLEXCOMM_I2C'])
diff --git a/hw/i2c/flexcomm_i2c.c b/hw/i2c/flexcomm_i2c.c
new file mode 100644
index 0000000000..7e74f858ce
--- /dev/null
+++ b/hw/i2c/flexcomm_i2c.c
@@ -0,0 +1,224 @@
+/*
+ * QEMU model for NXP's FLEXCOMM I2C
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
+#include "hw/i2c/flexcomm_i2c.h"
+
+#define reg(field) offsetof(FLEXCOMM_I2C_Type, field)
+#define regi(x) (reg(x) / sizeof(uint32_t))
+#define REG_NO (sizeof(FLEXCOMM_I2C_Type) / sizeof(uint32_t))
+
+static FLEXCOMM_I2C_REGISTER_NAMES_ARRAY(reg_names);
+
+static void flexcomm_i2c_reset(FlexcommState *s)
+{
+    flexcomm_i2c_reset_registers(&s->regs.i2c);
+}
+
+static void flexcomm_i2c_irq_update(FlexcommState *s)
+{
+    bool enabled = s->regs.i2c.CFG_b.MSTEN;
+    bool irq, per_irqs;
+
+    s->regs.i2c.INTSTAT = s->regs.i2c.STAT & s->regs.i2c.INTENSET;
+    per_irqs = s->regs.i2c.INTSTAT != 0;
+
+    irq = enabled && per_irqs;
+
+    trace_flexcomm_i2c_irq(DEVICE(s)->id, irq, per_irqs, enabled);
+    flexcomm_irq(s, irq);
+}
+
+static MemTxResult flexcomm_i2c_reg_read(void *opaque, FlexcommState *s,
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
+    *data = reg32_read(&s->regs, addr);
+
+    flexcomm_i2c_irq_update(s);
+
+out:
+    trace_flexcomm_i2c_reg_read(DEVICE(s)->id, reg_names[addr], addr, *data);
+    return ret;
+}
+
+static MemTxResult flexcomm_i2c_reg_write(void *opaque, FlexcommState *s,
+                                           int f, hwaddr addr, uint64_t value,
+                                           unsigned size)
+{
+    MemTxResult ret = MEMTX_OK;
+    static uint32_t mask[REG_NO] = {
+        [regi(CFG)] = BITS(5, 0),
+        [regi(STAT)] = BITS(25, 24) | BIT(19) | BIT(17) | BIT(15) | BIT(6),
+        [regi(INTENSET)] = BITS(25, 24) | BIT(19) | BITS(17, 15) | BIT(11) |
+                           BIT(8) |  BIT(6) | BIT(4) | BIT(0),
+        [regi(INTENCLR)] = BITS(25, 24) | BIT(19) | BITS(17, 15) | BIT(11) |
+                           BIT(8) |  BIT(6) | BIT(4) | BIT(0),
+        [regi(TIMEOUT)] = BITS(15, 0),
+        [regi(CLKDIV)] = BITS(15, 0),
+        [regi(MSTCTL)] = BITS(3, 0),
+        [regi(MSTTIME)] = BITS(6, 4) | BITS(2, 0),
+        [regi(MSTDAT)] = BITS(7, 0),
+        [regi(SLVCTL)] = BITS(9, 8) | BIT(3) | BITS(1, 0),
+        [regi(SLVDAT)] = BITS(7, 0),
+        [regi(SLVADR0)] = BIT(15) | BITS(7, 0),
+        [regi(SLVADR1)] = BIT(15) | BITS(7, 0),
+        [regi(SLVADR2)] = BIT(15) | BITS(7, 0),
+        [regi(SLVADR3)] = BIT(15) | BITS(7, 0),
+        [regi(SLVQUAL0)] = BITS(7, 0),
+    };
+
+    if (!reg32_aligned_access(addr, size)) {
+        ret = MEMTX_ERROR;
+        goto out;
+    }
+
+    switch (addr) {
+    case reg(CFG):
+    {
+        reg32_write(&s->regs, addr, value, mask);
+        if (s->regs.i2c.CFG_b.SLVEN) {
+            qemu_log_mask(LOG_GUEST_ERROR, "I2C slave not supported");
+        }
+        if (s->regs.i2c.CFG_b.MONEN) {
+            qemu_log_mask(LOG_GUEST_ERROR, "I2C monitoring not supported");
+        }
+        break;
+    }
+    case reg(INTENCLR):
+    {
+        s->regs.i2c.INTENSET &= ~(value & mask[addr / 4]);
+        break;
+    }
+    case reg(TIMEOUT):
+    {
+        reg32_write(&s->regs, addr, value, mask);
+        /* The bottom 4 bits are hard-wired to 0xF */
+        s->regs.i2c.TIMEOUT_b.TOMIN = 0xf;
+        break;
+    }
+    case reg(MSTCTL):
+    {
+        reg32_write(&s->regs, addr, value, mask);
+        if (s->regs.i2c.MSTCTL_b.MSTSTART) {
+            uint8_t i2c_addr = s->regs.i2c.MSTDAT_b.DATA;
+            bool recv = i2c_addr & 1;
+
+            trace_flexcomm_i2c_start(DEVICE(s)->id, i2c_addr, recv);
+            if (i2c_start_transfer(s->i2c, i2c_addr, recv)) {
+                s->regs.i2c.STAT_b.MSTSTATE = MSTSTATE_NAKADR;
+                trace_flexcomm_i2c_nak(DEVICE(s)->id);
+            } else {
+                if (recv) {
+                    uint8_t data = i2c_recv(s->i2c);
+
+                    s->regs.i2c.MSTDAT_b.DATA = data;
+                    trace_flexcomm_i2c_rx(DEVICE(s)->id, data);
+                    s->regs.i2c.STAT_b.MSTSTATE = MSTSTATE_RXRDY;
+                } else {
+                    s->regs.i2c.STAT_b.MSTSTATE = MSTSTATE_TXRDY;
+                }
+            }
+        }
+        if (s->regs.i2c.MSTCTL_b.MSTSTOP) {
+            s->regs.i2c.STAT_b.MSTSTATE = MSTSTATE_IDLE;
+            i2c_end_transfer(s->i2c);
+        }
+        if (s->regs.i2c.MSTCTL_b.MSTCONTINUE) {
+            if (s->regs.i2c.STAT_b.MSTSTATE == MSTSTATE_TXRDY) {
+                uint8_t data = s->regs.i2c.MSTDAT_b.DATA;
+
+                trace_flexcomm_i2c_tx(DEVICE(s)->id, data);
+                if (i2c_send(s->i2c, data)) {
+                    s->regs.i2c.STAT_b.MSTSTATE = MSTSTATE_NAKDAT;
+                }
+            } else if (s->regs.i2c.STAT_b.MSTSTATE == MSTSTATE_RXRDY) {
+                uint8_t data = i2c_recv(s->i2c);
+
+                s->regs.i2c.MSTDAT_b.DATA = data;
+                trace_flexcomm_i2c_rx(DEVICE(s)->id, data);
+            }
+        }
+        break;
+    }
+    case reg(STAT):
+    {
+        /* write 1 to clear bits */
+        s->regs.i2c.STAT &= ~(value & mask[addr / 4]);
+        break;
+    }
+    case reg(SLVCTL):
+    case reg(SLVDAT):
+    case reg(SLVADR0):
+    case reg(SLVADR1):
+    case reg(SLVADR2):
+    case reg(SLVADR3):
+    case reg(SLVQUAL0):
+    {
+        qemu_log_mask(LOG_GUEST_ERROR, "I2C slave not supported\n");
+        break;
+    }
+    default:
+        reg32_write(&s->regs, addr, value, mask);
+        break;
+    }
+
+    flexcomm_i2c_irq_update(s);
+
+out:
+    trace_flexcomm_i2c_reg_write(DEVICE(s)->id, reg_names[addr], addr, value);
+    return ret;
+}
+
+static void flexcomm_i2c_select(void *opaque, FlexcommState *s, int f,
+                                 bool set)
+{
+    if (set) {
+        flexcomm_i2c_reset(s);
+    }
+}
+
+static const FlexcommFunctionOps flexcomm_i2c_ops = {
+    .select = flexcomm_i2c_select,
+    .reg_read = flexcomm_i2c_reg_read,
+    .reg_write = flexcomm_i2c_reg_write,
+};
+
+void flexcomm_i2c_init(FlexcommState *s)
+{
+    s->i2c = i2c_init_bus(DEVICE(s), "i2c");
+}
+
+void flexcomm_i2c_register(void)
+{
+    Error *err = NULL;
+
+    if (!flexcomm_register_ops(FLEXCOMM_FUNC_I2C, NULL,
+                               &flexcomm_i2c_ops, &err)) {
+        error_report_err(err);
+    }
+}
diff --git a/hw/i2c/meson.build b/hw/i2c/meson.build
index c459adcb59..e7d79e6938 100644
--- a/hw/i2c/meson.build
+++ b/hw/i2c/meson.build
@@ -18,4 +18,5 @@ i2c_ss.add(when: 'CONFIG_PPC4XX', if_true: files('ppc4xx_i2c.c'))
 i2c_ss.add(when: 'CONFIG_PCA954X', if_true: files('i2c_mux_pca954x.c'))
 i2c_ss.add(when: 'CONFIG_PMBUS', if_true: files('pmbus_device.c'))
 i2c_ss.add(when: 'CONFIG_BCM2835_I2C', if_true: files('bcm2835_i2c.c'))
+i2c_ss.add(when: 'CONFIG_FLEXCOMM', if_true: files('flexcomm_i2c.c'))
 system_ss.add_all(when: 'CONFIG_I2C', if_true: i2c_ss)
diff --git a/hw/i2c/trace-events b/hw/i2c/trace-events
index 6900e06eda..9f0175fab7 100644
--- a/hw/i2c/trace-events
+++ b/hw/i2c/trace-events
@@ -51,3 +51,13 @@ npcm7xx_smbus_recv_fifo(const char *id, uint8_t received, uint8_t expected) "%s
 
 pca954x_write_bytes(uint8_t value) "PCA954X write data: 0x%02x"
 pca954x_read_data(uint8_t value) "PCA954X read data: 0x%02x"
+
+# flexcomm_i2c.c
+
+flexcomm_i2c_reg_read(const char *id, const char *reg_name, uint32_t addr, uint32_t val) " %s: %s[0x%04x] -> 0x%08x"
+flexcomm_i2c_reg_write(const char *id, const char *reg_name, uint32_t addr, uint32_t val) "%s: %s[0x%04x] <- 0x%08x"
+flexcomm_i2c_start(const char *id, uint8_t addr, uint8_t recv) "%s: 0x%02x %d"
+flexcomm_i2c_rx(const char *id, uint8_t data) "%s: <- 0x%02x"
+flexcomm_i2c_tx(const char *id, uint8_t data) "%s: -> 0x%02x"
+flexcomm_i2c_nak(const char *id) "%s: <- nak"
+flexcomm_i2c_irq(const char *id, bool irq, bool perirqs, bool enabled) "%s: %d %d %d"
diff --git a/hw/misc/flexcomm.c b/hw/misc/flexcomm.c
index 0c94928aa2..2722c1d6a9 100644
--- a/hw/misc/flexcomm.c
+++ b/hw/misc/flexcomm.c
@@ -23,6 +23,7 @@
 #include "hw/regs.h"
 #include "hw/misc/flexcomm.h"
 #include "hw/char/flexcomm_usart.h"
+#include "hw/i2c/flexcomm_i2c.h"
 
 #define reg(field) offsetof(FLEXCOMM_Type, field)
 #define regi(x) (reg(x) / sizeof(uint32_t))
@@ -228,6 +229,10 @@ static void flexcomm_realize(DeviceState *dev, Error **errp)
     if (has_function(s, FLEXCOMM_FUNC_USART)) {
         flexcomm_usart_init(s);
     }
+
+    if (has_function(s, FLEXCOMM_FUNC_I2C)) {
+        flexcomm_i2c_init(s);
+    }
 }
 
 static void flexcomm_class_init(ObjectClass *klass, void *data)
@@ -239,6 +244,7 @@ static void flexcomm_class_init(ObjectClass *klass, void *data)
     dc->realize = flexcomm_realize;
 
     flexcomm_usart_register();
+    flexcomm_i2c_register();
 }
 
 static const TypeInfo flexcomm_info = {
diff --git a/include/hw/i2c/flexcomm_i2c.h b/include/hw/i2c/flexcomm_i2c.h
new file mode 100644
index 0000000000..aea01f13bd
--- /dev/null
+++ b/include/hw/i2c/flexcomm_i2c.h
@@ -0,0 +1,27 @@
+/*
+ * QEMU model for NXP's FLEXCOMM I2C
+ *
+ * Copyright (c) 2024 Google LLC
+ *
+ * SPDX-License-Identifier: GPL-2.0-or-later
+ *
+ * This work is licensed under the terms of the GNU GPL, version 2 or later.
+ * See the COPYING file in the top-level directory.
+ */
+
+#ifndef HW_CHAR_FLEXCOMM_I2C_H
+#define HW_CHAR_FLEXCOMM_I2C_H
+
+#include "hw/misc/flexcomm.h"
+
+void flexcomm_i2c_init(FlexcommState *s);
+void flexcomm_i2c_register(void);
+
+#define MSTSTATE_IDLE 0
+#define MSTSTATE_RXRDY 1
+#define MSTSTATE_TXRDY 2
+#define MSTSTATE_NAKADR 3
+#define MSTSTATE_NAKDAT 4
+
+
+#endif /* HW_CHAR_FLEXCOMM_I2C_H */
diff --git a/include/hw/misc/flexcomm.h b/include/hw/misc/flexcomm.h
index db76e32c6d..3d042a3511 100644
--- a/include/hw/misc/flexcomm.h
+++ b/include/hw/misc/flexcomm.h
@@ -14,8 +14,10 @@
 
 #include "hw/sysbus.h"
 #include "chardev/char-fe.h"
+#include "hw/i2c/i2c.h"
 #include "hw/arm/svd/flexcomm.h"
 #include "hw/arm/svd/flexcomm_usart.h"
+#include "hw/arm/svd/flexcomm_i2c.h"
 #include "qemu/fifo32.h"
 
 #define TYPE_FLEXCOMM "flexcomm"
@@ -46,6 +48,7 @@ typedef struct {
     union {
         FLEXCOMM_Type flex;
         FLEXCOMM_USART_Type usart;
+        FLEXCOMM_I2C_Type i2c;
     } regs;
     uint32_t functions;
     qemu_irq irq;
@@ -53,6 +56,7 @@ typedef struct {
     CharBackend chr;
     Fifo32 tx_fifo;
     Fifo32 rx_fifo;
+    I2CBus *i2c;
 } FlexcommState;
 
 typedef struct {
diff --git a/tests/unit/meson.build b/tests/unit/meson.build
index dcfd2e661c..4c22cb3ccc 100644
--- a/tests/unit/meson.build
+++ b/tests/unit/meson.build
@@ -148,6 +148,8 @@ if have_system
       meson.project_source_root() / 'tests/unit/sysbus-mock.c',
       meson.project_source_root() / 'hw/misc/flexcomm.c',
       meson.project_source_root() / 'hw/char/flexcomm_usart.c',
+      meson.project_source_root() / 'hw/i2c/flexcomm_i2c.c',
+      meson.project_source_root() / 'hw/i2c/core.c',
      ],
     'test-flexcomm-usart': [
       hwcore, chardev, qom, migration,
@@ -155,6 +157,8 @@ if have_system
       meson.project_source_root() / 'tests/unit/sysbus-mock.c',
       meson.project_source_root() / 'hw/misc/flexcomm.c',
       meson.project_source_root() / 'hw/char/flexcomm_usart.c',
+      meson.project_source_root() / 'hw/i2c/flexcomm_i2c.c',
+      meson.project_source_root() / 'hw/i2c/core.c',
     ],
   }
   if config_host_data.get('CONFIG_INOTIFY1')
-- 
2.46.0.rc2.264.g509ed76dc8-goog


