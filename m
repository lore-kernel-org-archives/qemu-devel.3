Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0581FC44503
	for <qemu-devel@archiver.kernel.org>; Thu,  9 Jul 2026 03:13:49 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1whfCD-0005PM-45; Wed, 08 Jul 2026 23:13:05 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <163wangjack@gmail.com>)
 id 1whfCB-0005P0-L8
 for qemu-devel@nongnu.org; Wed, 08 Jul 2026 23:13:03 -0400
Received: from mail-pj1-x102f.google.com ([2607:f8b0:4864:20::102f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <163wangjack@gmail.com>)
 id 1whfC8-0005yO-Fb
 for qemu-devel@nongnu.org; Wed, 08 Jul 2026 23:13:03 -0400
Received: by mail-pj1-x102f.google.com with SMTP id
 98e67ed59e1d1-381b831d535so1644114a91.0
 for <qemu-devel@nongnu.org>; Wed, 08 Jul 2026 20:13:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1783566779; x=1784171579; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=Vo6S50djuSQnTtaaJ5rluWW3igUtVLZRCod4SZK+AA0=;
 b=Qn+gRzNTTSE0lkZNkUey34kshKRXCryZQMinYH1/N62An+03KjVGEwuuDbT3iVCFUg
 57/NqQLVMVv6+YZu5BGko3vzqKWB0o5foa6Nkl4sg2J53KQm/tituJmZvhMImLWs/cNz
 P5GnP7k0g1RphMOJAFSu1N7ggk0VKuZgJB/+CHD8gBm+wteBKuwnqCn/yGetmd1mCCtj
 FnVtlHRd/vc9owfIeTXxPZby8poG6RKAacyRtwq8YssdYmpsyOvfbqZcUs4ZdxL2fzR9
 6qEBoAV8fzlV6vGg9pgN4JTMwu6ADcC5cI8sg3vppvggSfdZhHuikxN4hDY79JwP35dX
 4eoQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1783566779; x=1784171579;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=Vo6S50djuSQnTtaaJ5rluWW3igUtVLZRCod4SZK+AA0=;
 b=jTVv1K72DqilOfG2e73AF3y+NzUrRWqh8y/e+zWRhUCW6c1QPS9b3HESB9hsYht9sZ
 b7A9kaB4WLk/sXI/6th8r1JFpUsSDYxy90kPeraJpxRNp70uoQllZdqrKHJfVzAifS6D
 /N3aDFSpoSmNg19pvVxml3qM5cphS9Hoy2ABIR/XFfuyU1S9GdTgqGmya1HivY2WjK1d
 L2p6jt2XpmmNtJt7oCZqsSTH9omu0fh8SvtqfbCE6xJHOuIUqtLE6MpxZwfos9WGo+sz
 sK6jEmBo1FY6kdkelfVi/xjRtNMqxkpMDzJt449PIuWh2XdhFASvpEwBdiyj5vWrAFhY
 08Wg==
X-Gm-Message-State: AOJu0YyldawaC6Xh87Fg1SGe72HNHru7koNDEAdw6MUSrNEn+mEHwxp7
 71J0PY/48jDOuydQGJBNLQ/WkD0Bj9hdrDjiGQ+VUIyJSWvjCyB54wJfgpnmbMY1
X-Gm-Gg: AfdE7ckws3+4uRqoQseqBtytv/ZK9WsIxf/nlu8e6LgaD61rgQFIoffZ1DQ1lpzuJSM
 AzA/oilXhz1qqf4QaH0Zjp0i5CY+8VJr/hY7tfbuU/4W9XxXeUs1IZbOZDJ0F4uXMzRZWZZuq9l
 B31gz4iihIKiRDHBM3AVDV5C8OgOf21N7yswu7F/C1rwqLIO/hw1xE8Xq9vxgwXRErc6Nr1Iuoy
 bMvJ0GiazBojPNKkW3QfGQnFFJaXgRDFgOK/9EEaEWMNYgaTmaxhejEXbjfLKmS9QI01kZvJGXO
 WRu8mNG9TRwvcGEoVaRIxh3MocxL8FzVKN/gv703wgGxHy4fScYh018IE+ZGWanavrbVonDHeSD
 zq2ggXjq4OzmgDy5uRTu4ZhqNyzNOKeaDfXEv0x4SY+/u2VXzO1YX4q/2P9cCWzc9HoIIvosGiq
 s1oQYII/2008RsesGk+d/xBv7OwWLG
X-Received: by 2002:a17:90b:3891:b0:387:e0db:3fac with SMTP id
 98e67ed59e1d1-38942798114mr5801717a91.37.1783566778797; 
 Wed, 08 Jul 2026 20:12:58 -0700 (PDT)
Received: from localhost.localdomain ([212.135.212.213])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-38a5516949asm392988a91.1.2026.07.08.20.12.55
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Wed, 08 Jul 2026 20:12:56 -0700 (PDT)
From: jack wang <163wangjack@gmail.com>
To: qemu-devel@nongnu.org
Cc: Jack Wang <163wangjack@gmail.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Fabiano Rosas <farosas@suse.de>, Laurent Vivier <lvivier@redhat.com>
Subject: [RFC PATCH 1/2] hw/misc/k230_rmu: add Kendryte K230 Reset Management
 Unit model
Date: Thu,  9 Jul 2026 11:12:36 +0800
Message-ID: <20260709031237.21284-2-163wangjack@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260709031237.21284-1-163wangjack@gmail.com>
References: <20260709031237.21284-1-163wangjack@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::102f;
 envelope-from=163wangjack@gmail.com; helo=mail-pj1-x102f.google.com
X-Spam_score_int: -13
X-Spam_score: -1.4
X-Spam_bar: -
X-Spam_report: (-1.4 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 FROM_STARTS_WITH_NUMS=0.738, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
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

From: Jack Wang <163wangjack@gmail.com>

Model the K230 Reset Management Unit (RMU / SYSCTL_RST) at 0x91101000.
Its control registers gather the software-controllable reset lines of the
SoC peripherals. The register semantics are modelled after the five reset
types described by the Linux mainline driver drivers/reset/reset-k230.c:

  - CPU0/CPU1: high-half per-bit write-enable strobe plus a done bit (bit12)
  - FLUSH:     the CPU register bit4, auto-cleared by hardware, no done bit
  - HW_DONE:   no write-enable; a done bit is latched when the reset fires
               and acknowledged by software with write-1-to-clear
  - SW_DONE:   plain read/write storage, no write-enable and no done bit

QEMU does not reset the target peripherals, so the model collapses the
hardware reset latency to zero: writing a reset request bit latches the
paired done bit and auto-clears the request bit in the same access, which
lets the kernel's readl_poll_timeout() loops succeed on the first read.

A qtest exercises the reset defaults, write-enable gating, HW_DONE latch
and write-1-to-clear, repeated resets, flush auto-clear and SW_DONE
storage behaviour.

Signed-off-by: Jack Wang <163wangjack@gmail.com>
---
 hw/misc/Kconfig             |   3 +
 hw/misc/k230_rmu.c          | 280 ++++++++++++++++++++++++++++++++++++
 hw/misc/meson.build         |   1 +
 hw/misc/trace-events        |   6 +
 include/hw/misc/k230_rmu.h  |  76 ++++++++++
 tests/qtest/k230-rmu-test.c | 125 ++++++++++++++++
 tests/qtest/meson.build     |   3 +-
 7 files changed, 493 insertions(+), 1 deletion(-)
 create mode 100644 hw/misc/k230_rmu.c
 create mode 100644 include/hw/misc/k230_rmu.h
 create mode 100644 tests/qtest/k230-rmu-test.c

diff --git a/hw/misc/Kconfig b/hw/misc/Kconfig
index 1543ee6653..a1470b285f 100644
--- a/hw/misc/Kconfig
+++ b/hw/misc/Kconfig
@@ -251,6 +251,9 @@ config DJMEMC
 config IOSB
     bool
 
+config K230_RMU
+    bool
+
 config XLNX_VERSAL_TRNG
     bool
 
diff --git a/hw/misc/k230_rmu.c b/hw/misc/k230_rmu.c
new file mode 100644
index 0000000000..f9ead7a1a0
--- /dev/null
+++ b/hw/misc/k230_rmu.c
@@ -0,0 +1,280 @@
+/*
+ * K230 Reset Management Unit (RMU / SYSCTL_RST)
+ *
+ * The RMU is a bank of reset-control registers at 0x91101000. Each register
+ * gathers the software-controllable reset lines of a group of peripherals.
+ * Register semantics are modelled after the five reset types described in the
+ * Linux mainline driver drivers/reset/reset-k230.c:
+ *
+ *   - CPU0/CPU1 : have a high-half write-enable strobe and a done bit (bit12).
+ *   - FLUSH     : bit4 of the CPU registers; hardware auto-clears it, no done.
+ *   - HW_DONE   : no write-enable; a done bit is latched when the reset fires
+ *                 and cleared by software (write-1-to-clear).
+ *   - SW_DONE   : plain read/write storage, no write-enable and no done bit.
+ *
+ * QEMU never actually resets the target peripherals, so the model collapses
+ * the hardware reset latency to zero: writing a reset request bit latches the
+ * matching done bit in the same access and auto-clears the request bit, which
+ * lets the kernel's readl_poll_timeout() loops succeed on the first read.
+ *
+ * Copyright (c) 2026 Jack Wang <163wangjack@gmail.com>
+ *
+ * SPDX-License-Identifier: GPL-2.0-or-later
+ */
+
+#include "qemu/osdep.h"
+#include "qemu/bitops.h"
+#include "qemu/log.h"
+#include "qemu/module.h"
+#include "migration/vmstate.h"
+#include "hw/misc/k230_rmu.h"
+#include "trace.h"
+
+/* Sentinel meaning "this reset request bit has no associated done bit". */
+#define K230_RMU_NO_DONE  0xff
+
+/* A single (reset request bit -> done bit) pairing within one register. */
+typedef struct {
+    uint8_t reset_bit;   /* reset request bit index, 0..15               */
+    uint8_t done_bit;    /* matching done bit index, or K230_RMU_NO_DONE  */
+} K230RmuPair;
+
+/* Description of one control register. */
+typedef struct {
+    hwaddr             offset;   /* word-aligned register offset               */
+    bool               has_we;   /* high 16 bits are write-enable (CPU0/CPU1)  */
+    const K230RmuPair *pairs;    /* reset/done pairings, NULL for SW_DONE banks */
+    unsigned           n_pairs;  /* number of pairings (0 for SW_DONE banks)   */
+} K230RmuReg;
+
+/*
+ * Per-register (reset bit -> done bit) tables, copied verbatim from the bit
+ * positions in the Linux driver's k230_resets[] table.
+ */
+static const K230RmuPair pairs_cpu0[]    = { {0, 12}, {4, K230_RMU_NO_DONE} };
+static const K230RmuPair pairs_cpu1[]    = { {0, 12}, {4, K230_RMU_NO_DONE} };
+static const K230RmuPair pairs_ai[]      = { {0, 31} };
+static const K230RmuPair pairs_vpu[]     = { {0, 31} };
+static const K230RmuPair pairs_hisys[]   = { {0, 4}, {1, 5} };  /* done in low bits */
+static const K230RmuPair pairs_sdio[]    = { {0, 28}, {1, 29}, {2, 30} };
+static const K230RmuPair pairs_usb[]     = { {0, 28}, {1, 29}, {0, 30}, {1, 31} };
+static const K230RmuPair pairs_spi[]     = { {0, 28}, {1, 29}, {2, 30} };
+static const K230RmuPair pairs_sec[]     = { {0, 31} };
+static const K230RmuPair pairs_dma[]     = { {0, 28}, {1, 29} };
+static const K230RmuPair pairs_decomp[]  = { {0, 31} };
+static const K230RmuPair pairs_sram[]    = { {0, 28}, {2, 30}, {3, 31} }; /* bit1 SW_DONE */
+static const K230RmuPair pairs_nonai2d[] = { {0, 31} };
+static const K230RmuPair pairs_mctl[]    = { {0, 31} };
+static const K230RmuPair pairs_isp[]     = { {6, 29}, {5, 28} }; /* other low bits SW_DONE */
+static const K230RmuPair pairs_dpu[]     = { {0, 31} };
+static const K230RmuPair pairs_disp[]    = { {0, 31} };
+static const K230RmuPair pairs_gpu[]     = { {0, 31} };
+static const K230RmuPair pairs_audio[]   = { {0, 31} };
+
+#define K230_RMU_REG(off, we, p)  { (off), (we), (p), ARRAY_SIZE(p) }
+#define K230_RMU_SW(off)          { (off), false, NULL, 0 }  /* pure SW_DONE bank */
+
+static const K230RmuReg k230_rmu_regs[] = {
+    K230_RMU_REG(K230_RMU_CPU0_CTRL,    true,  pairs_cpu0),
+    K230_RMU_REG(K230_RMU_CPU1_CTRL,    true,  pairs_cpu1),
+    K230_RMU_REG(K230_RMU_AI_CTRL,      false, pairs_ai),
+    K230_RMU_REG(K230_RMU_VPU_CTRL,     false, pairs_vpu),
+    K230_RMU_SW (K230_RMU_PERI0_CTRL),
+    K230_RMU_SW (K230_RMU_PERI1_CTRL),
+    K230_RMU_REG(K230_RMU_HISYS_CTRL,   false, pairs_hisys),
+    K230_RMU_REG(K230_RMU_SDIO_CTRL,    false, pairs_sdio),
+    K230_RMU_REG(K230_RMU_USB_CTRL,     false, pairs_usb),
+    K230_RMU_REG(K230_RMU_SPI_CTRL,     false, pairs_spi),
+    K230_RMU_REG(K230_RMU_SEC_CTRL,     false, pairs_sec),
+    K230_RMU_REG(K230_RMU_DMA_CTRL,     false, pairs_dma),
+    K230_RMU_REG(K230_RMU_DECOMP_CTRL,  false, pairs_decomp),
+    K230_RMU_REG(K230_RMU_SRAM_CTRL,    false, pairs_sram),
+    K230_RMU_REG(K230_RMU_NONAI2D_CTRL, false, pairs_nonai2d),
+    K230_RMU_REG(K230_RMU_MCTL_CTRL,    false, pairs_mctl),
+    K230_RMU_REG(K230_RMU_ISP_CTRL,     false, pairs_isp),
+    K230_RMU_REG(K230_RMU_DPU_CTRL,     false, pairs_dpu),
+    K230_RMU_REG(K230_RMU_DISP_CTRL,    false, pairs_disp),
+    K230_RMU_REG(K230_RMU_GPU_CTRL,     false, pairs_gpu),
+    K230_RMU_REG(K230_RMU_AUDIO_CTRL,   false, pairs_audio),
+    K230_RMU_SW (K230_RMU_SPI2AXI_CTRL),
+};
+
+/* Look up the register description for a word-aligned offset, or NULL. */
+static const K230RmuReg *k230_rmu_lookup(hwaddr offset)
+{
+    for (size_t i = 0; i < ARRAY_SIZE(k230_rmu_regs); i++) {
+        if (k230_rmu_regs[i].offset == offset) {
+            return &k230_rmu_regs[i];
+        }
+    }
+    return NULL;
+}
+
+static uint64_t k230_rmu_read(void *opaque, hwaddr offset, unsigned size)
+{
+    K230RmuState *s = K230_RMU(opaque);
+    uint32_t value;
+
+    if ((offset & 0x3) || offset >= K230_RMU_MMIO_SIZE) {
+        qemu_log_mask(LOG_GUEST_ERROR,
+                      "%s: bad read offset 0x%" HWADDR_PRIx "\n",
+                      __func__, offset);
+        return 0;
+    }
+
+    /* All hardware side effects happen on write, so a read just returns the
+     * backing store: done bits already latched, request bits already cleared.
+     */
+    value = s->regs[offset / 4];
+    trace_k230_rmu_read(offset, value);
+    return value;
+}
+
+static void k230_rmu_write(void *opaque, hwaddr offset,
+                           uint64_t val64, unsigned size)
+{
+    K230RmuState *s = K230_RMU(opaque);
+    const K230RmuReg *r;
+    uint32_t v = (uint32_t)val64;
+    uint32_t old, new_val, we_gate, done_gate;
+    uint32_t reset_mask = 0, done_mask = 0, sw_mask;
+
+    if ((offset & 0x3) || offset >= K230_RMU_MMIO_SIZE) {
+        qemu_log_mask(LOG_GUEST_ERROR,
+                      "%s: bad write offset 0x%" HWADDR_PRIx "\n",
+                      __func__, offset);
+        return;
+    }
+
+    trace_k230_rmu_write(offset, v);
+    old = s->regs[offset / 4];
+    r = k230_rmu_lookup(offset);
+
+    if (!r) {
+        /* Inside the 4 KiB window but not modelled: accept the write and log
+         * it so unexpected accesses are visible while debugging.
+         */
+        qemu_log_mask(LOG_UNIMP,
+                      "%s: write to unmodelled offset 0x%" HWADDR_PRIx
+                      " = 0x%08x\n", __func__, offset, v);
+        s->regs[offset / 4] = v;
+        return;
+    }
+
+    /* Derive the reset/done masks for this register from its pairing table. */
+    for (unsigned i = 0; i < r->n_pairs; i++) {
+        reset_mask |= BIT(r->pairs[i].reset_bit);
+        if (r->pairs[i].done_bit != K230_RMU_NO_DONE) {
+            done_mask |= BIT(r->pairs[i].done_bit);
+        }
+    }
+
+    /*
+     * we_gate holds the low-half bits this write is allowed to modify. With
+     * write-enable (CPU0/CPU1) a low bit n is writable only when the strobe
+     * bit n+16 is also set; otherwise every low bit is directly writable.
+     */
+    we_gate = r->has_we ? ((v >> K230_RMU_WE_SHIFT) & 0xffffu) : 0xffffu;
+
+    new_val = old;
+
+    /* (A) SW_DONE storage: low-half bits that are neither reset nor done bits
+     *     are plain read/write storage.
+     */
+    sw_mask = 0xffffu & ~reset_mask & ~done_mask & we_gate;
+    new_val = (new_val & ~sw_mask) | (v & sw_mask);
+
+    /* (B) Done bits are write-1-to-clear. CPU-type done bits sit in the low
+     *     half and their clear is gated by write-enable (the strobe is folded
+     *     into we_gate); HW_DONE done bits sit in the high half, clear direct.
+     */
+    done_gate = r->has_we ? (done_mask & we_gate) : done_mask;
+    new_val &= ~(v & done_gate);
+
+    /* (C) A reset request latches its paired done bit immediately (zero
+     *     latency) and the request bit auto-clears so it can fire again.
+     *     FLUSH-type pairs (done_bit == NO_DONE) only auto-clear.
+     */
+    for (unsigned i = 0; i < r->n_pairs; i++) {
+        uint32_t rbit = BIT(r->pairs[i].reset_bit);
+        bool fire = (v & rbit) &&
+                    (!r->has_we || (v & (rbit << K230_RMU_WE_SHIFT)));
+
+        if (fire) {
+            if (r->pairs[i].done_bit != K230_RMU_NO_DONE) {
+                new_val |= BIT(r->pairs[i].done_bit);
+            } else {
+                trace_k230_rmu_flush(offset);
+            }
+            new_val &= ~rbit;
+        }
+    }
+
+    s->regs[offset / 4] = new_val;
+}
+
+static const MemoryRegionOps k230_rmu_ops = {
+    .read       = k230_rmu_read,
+    .write      = k230_rmu_write,
+    .endianness = DEVICE_LITTLE_ENDIAN,
+    .impl = {
+        .min_access_size = 4,
+        .max_access_size = 4,
+        .unaligned       = false,
+    },
+    .valid = {
+        .min_access_size = 4,
+        .max_access_size = 4,
+    },
+};
+
+static void k230_rmu_reset(DeviceState *dev)
+{
+    K230RmuState *s = K230_RMU(dev);
+
+    trace_k230_rmu_reset_device();
+    memset(s->regs, 0, sizeof(s->regs));
+}
+
+static void k230_rmu_realize(DeviceState *dev, Error **errp)
+{
+    K230RmuState *s = K230_RMU(dev);
+    SysBusDevice *sbd = SYS_BUS_DEVICE(dev);
+
+    memory_region_init_io(&s->mmio, OBJECT(dev), &k230_rmu_ops, s,
+                          TYPE_K230_RMU, K230_RMU_MMIO_SIZE);
+    sysbus_init_mmio(sbd, &s->mmio);
+}
+
+static const VMStateDescription vmstate_k230_rmu = {
+    .name               = "k230.rmu",
+    .version_id         = 1,
+    .minimum_version_id = 1,
+    .fields = (const VMStateField[]) {
+        VMSTATE_UINT32_ARRAY(regs, K230RmuState, K230_RMU_NUM_REGS),
+        VMSTATE_END_OF_LIST()
+    },
+};
+
+static void k230_rmu_class_init(ObjectClass *klass, const void *data)
+{
+    DeviceClass *dc = DEVICE_CLASS(klass);
+
+    dc->realize = k230_rmu_realize;
+    device_class_set_legacy_reset(dc, k230_rmu_reset);
+    dc->vmsd = &vmstate_k230_rmu;
+    dc->desc = "K230 Reset Management Unit";
+}
+
+static const TypeInfo k230_rmu_info = {
+    .name          = TYPE_K230_RMU,
+    .parent        = TYPE_SYS_BUS_DEVICE,
+    .instance_size = sizeof(K230RmuState),
+    .class_init    = k230_rmu_class_init,
+};
+
+static void k230_rmu_register_type(void)
+{
+    type_register_static(&k230_rmu_info);
+}
+type_init(k230_rmu_register_type)
diff --git a/hw/misc/meson.build b/hw/misc/meson.build
index 23265f6035..5e1155723f 100644
--- a/hw/misc/meson.build
+++ b/hw/misc/meson.build
@@ -111,6 +111,7 @@ system_ss.add(when: 'CONFIG_XLNX_VERSAL', if_true: files(
 system_ss.add(when: 'CONFIG_XLNX_VERSAL_TRNG', if_true: files(
   'xlnx-versal-trng.c',
 ))
+system_ss.add(when: 'CONFIG_K230_RMU', if_true: files('k230_rmu.c'))
 system_ss.add(when: 'CONFIG_STM32_RCC', if_true: files('stm32_rcc.c'))
 system_ss.add(when: 'CONFIG_STM32F2XX_SYSCFG', if_true: files('stm32f2xx_syscfg.c'))
 system_ss.add(when: 'CONFIG_STM32F4XX_SYSCFG', if_true: files('stm32f4xx_syscfg.c'))
diff --git a/hw/misc/trace-events b/hw/misc/trace-events
index b88accc437..da0e32582e 100644
--- a/hw/misc/trace-events
+++ b/hw/misc/trace-events
@@ -417,3 +417,9 @@ iommu_testdev_dma_read(uint64_t gva, uint32_t len) "gva=0x%" PRIx64 " len=%u"
 iommu_testdev_dma_verify(uint32_t expected, uint32_t actual) "expected=0x%x actual=0x%x"
 iommu_testdev_dma_result(uint32_t result) "DMA completed result=0x%x"
 iommu_testdev_dma_armed(bool armed) "armed=%d"
+
+# k230_rmu.c
+k230_rmu_read(uint64_t offset, uint32_t value) "K230 RMU read:  [0x%" PRIx64 "] -> 0x%08" PRIx32
+k230_rmu_write(uint64_t offset, uint32_t value) "K230 RMU write: [0x%" PRIx64 "] <- 0x%08" PRIx32
+k230_rmu_flush(uint64_t offset) "K230 RMU flush auto-clear at offset 0x%" PRIx64
+k230_rmu_reset_device(void) "K230 RMU device reset"
diff --git a/include/hw/misc/k230_rmu.h b/include/hw/misc/k230_rmu.h
new file mode 100644
index 0000000000..e6f5073c1e
--- /dev/null
+++ b/include/hw/misc/k230_rmu.h
@@ -0,0 +1,76 @@
+/*
+ * K230 Reset Management Unit (RMU / SYSCTL_RST)
+ *
+ * K230 Technical Reference Manual V0.3.1 (2024-11-18):
+ * https://github.com/revyos/external-docs/blob/master/K230/en-us/K230_Technical_Reference_Manual_V0.3.1_20241118.pdf
+ *
+ * Register semantics cross-checked against the Linux mainline driver
+ * drivers/reset/reset-k230.c (compatible "canaan,k230-rst").
+ *
+ * Copyright (c) 2026 Jack Wang <163wangjack@gmail.com>
+ *
+ * SPDX-License-Identifier: GPL-2.0-or-later
+ */
+
+#ifndef HW_MISC_K230_RMU_H
+#define HW_MISC_K230_RMU_H
+
+#include "qemu/bitops.h"
+#include "hw/core/sysbus.h"
+#include "qom/object.h"
+
+#define TYPE_K230_RMU "riscv.k230.rmu"
+OBJECT_DECLARE_SIMPLE_TYPE(K230RmuState, K230_RMU)
+
+/* 1 KiB MMIO window, see K230_DEV_RMU in hw/riscv/k230.c. */
+#define K230_RMU_MMIO_SIZE   0x1000
+#define K230_RMU_NUM_REGS    (K230_RMU_MMIO_SIZE / 4)
+
+/* Control register offsets used by drivers/reset/reset-k230.c. */
+#define K230_RMU_CPU0_CTRL     0x04
+#define K230_RMU_CPU1_CTRL     0x0C
+#define K230_RMU_AI_CTRL       0x14
+#define K230_RMU_VPU_CTRL      0x1C
+#define K230_RMU_PERI0_CTRL    0x20   /* SW_DONE bank: TIMERx, WDTx, MAILBOX   */
+#define K230_RMU_PERI1_CTRL    0x24   /* SW_DONE bank: UARTx, I2Cx, GPIO       */
+#define K230_RMU_HISYS_CTRL    0x2C
+#define K230_RMU_SDIO_CTRL     0x34
+#define K230_RMU_USB_CTRL      0x3C
+#define K230_RMU_SPI_CTRL      0x44
+#define K230_RMU_SEC_CTRL      0x4C
+#define K230_RMU_DMA_CTRL      0x54
+#define K230_RMU_DECOMP_CTRL   0x5C
+#define K230_RMU_SRAM_CTRL     0x64   /* mixed: HW_DONE bits + SW_DONE bit1     */
+#define K230_RMU_NONAI2D_CTRL  0x6C
+#define K230_RMU_MCTL_CTRL     0x74
+#define K230_RMU_ISP_CTRL      0x80   /* mixed: HW_DONE bits + SW_DONE bits     */
+#define K230_RMU_DPU_CTRL      0x88
+#define K230_RMU_DISP_CTRL     0x90
+#define K230_RMU_GPU_CTRL      0x98
+#define K230_RMU_AUDIO_CTRL    0xA4
+#define K230_RMU_SPI2AXI_CTRL  0xA8   /* SW_DONE (active high)                  */
+
+/* Bit layout shared by the CPU0/CPU1 control registers. */
+#define K230_RMU_CPU_RESET     BIT(0)    /* reset request, auto/soft cleared    */
+#define K230_RMU_CPU_FLUSH     BIT(4)    /* L2 flush request, hw auto-clears     */
+#define K230_RMU_CPU_DONE      BIT(12)   /* done bit, write-1-to-clear           */
+
+/* The high 16 bits are per-bit write-enable strobes (CPU0/CPU1 registers). */
+#define K230_RMU_WE_SHIFT      16
+
+struct K230RmuState {
+    /*< private >*/
+    SysBusDevice parent_obj;
+
+    /*< public >*/
+    MemoryRegion mmio;
+
+    /*
+     * One 32-bit word per MMIO offset. Indexing by word offset keeps the
+     * VMState description trivial. Reset requests auto-clear, so what
+     * actually persists here is done bits and SW_DONE storage bits.
+     */
+    uint32_t regs[K230_RMU_NUM_REGS];
+};
+
+#endif /* HW_MISC_K230_RMU_H */
diff --git a/tests/qtest/k230-rmu-test.c b/tests/qtest/k230-rmu-test.c
new file mode 100644
index 0000000000..c2c862cd1d
--- /dev/null
+++ b/tests/qtest/k230-rmu-test.c
@@ -0,0 +1,125 @@
+/*
+ * QTest for the K230 Reset Management Unit.
+ *
+ * SPDX-License-Identifier: GPL-2.0-or-later
+ */
+#include "qemu/osdep.h"
+#include "qemu/bitops.h"
+#include "libqtest.h"
+#include "hw/misc/k230_rmu.h"
+
+#define K230_RMU_BASE 0x91101000ULL
+
+static inline uint32_t rd(QTestState *qts, uint64_t off)
+{
+    return qtest_readl(qts, K230_RMU_BASE + off);
+}
+static inline void wr(QTestState *qts, uint64_t off, uint32_t val)
+{
+    qtest_writel(qts, K230_RMU_BASE + off, val);
+}
+
+/* Every known register reads back as 0 after reset. */
+static void test_reset_values(void)
+{
+    QTestState *qts = qtest_init("-machine k230");
+
+    g_assert_cmphex(rd(qts, K230_RMU_CPU0_CTRL),  ==, 0);
+    g_assert_cmphex(rd(qts, K230_RMU_AI_CTRL),    ==, 0);
+    g_assert_cmphex(rd(qts, K230_RMU_HISYS_CTRL), ==, 0);
+    g_assert_cmphex(rd(qts, K230_RMU_PERI0_CTRL), ==, 0);
+
+    qtest_quit(qts);
+}
+
+/*
+ * CPU0: a low-half write without its strobe is ignored; with the strobe the
+ * reset request fires, latches done (bit12), and the request bit auto-clears.
+ */
+static void test_cpu_write_enable(void)
+{
+    QTestState *qts = qtest_init("-machine k230");
+
+    /* No strobe: the low-half write is dropped, reads back as 0. */
+    wr(qts, K230_RMU_CPU0_CTRL, K230_RMU_CPU_RESET);
+    g_assert_cmphex(rd(qts, K230_RMU_CPU0_CTRL), ==, 0);
+
+    /* With strobe (bit16): request bit0 takes effect, done (bit12) latches. */
+    wr(qts, K230_RMU_CPU0_CTRL,
+       K230_RMU_CPU_RESET | (K230_RMU_CPU_RESET << K230_RMU_WE_SHIFT));
+    g_assert_cmphex(rd(qts, K230_RMU_CPU0_CTRL), ==, K230_RMU_CPU_DONE);
+
+    qtest_quit(qts);
+}
+
+/*
+ * HW_DONE: no write-enable needed. Writing HISYS request bit0 latches its
+ * done bit (bit4); writing 1 to the done bit clears it.
+ */
+static void test_hw_done_and_w1c(void)
+{
+    QTestState *qts = qtest_init("-machine k230");
+    uint32_t v;
+
+    wr(qts, K230_RMU_HISYS_CTRL, BIT(0));      /* no strobe */
+    v = rd(qts, K230_RMU_HISYS_CTRL);
+    g_assert_cmphex(v & BIT(4), ==, BIT(4));   /* done latched */
+    g_assert_cmphex(v & BIT(0), ==, 0);        /* request bit auto-cleared */
+
+    wr(qts, K230_RMU_HISYS_CTRL, BIT(4));      /* write-1-to-clear */
+    g_assert_cmphex(rd(qts, K230_RMU_HISYS_CTRL) & BIT(4), ==, 0);
+
+    qtest_quit(qts);
+}
+
+/* Repeated resets: one HW_DONE line can be triggered again and again. */
+static void test_repeat_reset(void)
+{
+    QTestState *qts = qtest_init("-machine k230");
+
+    for (int i = 0; i < 3; i++) {
+        wr(qts, K230_RMU_AI_CTRL, BIT(0));                 /* request */
+        g_assert_cmphex(rd(qts, K230_RMU_AI_CTRL) & BIT(31), ==, BIT(31));
+        wr(qts, K230_RMU_AI_CTRL, BIT(31));                /* W1C done */
+        g_assert_cmphex(rd(qts, K230_RMU_AI_CTRL) & BIT(31), ==, 0);
+    }
+
+    qtest_quit(qts);
+}
+
+/* FLUSH: the CPU0 bit4 flush request is auto-cleared, reads back as 0. */
+static void test_flush_auto_clear(void)
+{
+    QTestState *qts = qtest_init("-machine k230");
+
+    wr(qts, K230_RMU_CPU0_CTRL,
+       K230_RMU_CPU_FLUSH | (K230_RMU_CPU_FLUSH << K230_RMU_WE_SHIFT));
+    g_assert_cmphex(rd(qts, K230_RMU_CPU0_CTRL) & K230_RMU_CPU_FLUSH, ==, 0);
+
+    qtest_quit(qts);
+}
+
+/* SW_DONE: the PERI0 low half is plain storage, no strobe and no done bit. */
+static void test_sw_done_storage(void)
+{
+    QTestState *qts = qtest_init("-machine k230");
+
+    wr(qts, K230_RMU_PERI0_CTRL, BIT(12) | BIT(13));   /* WDT0 / WDT1 reset bits */
+    g_assert_cmphex(rd(qts, K230_RMU_PERI0_CTRL), ==, (BIT(12) | BIT(13)));
+
+    qtest_quit(qts);
+}
+
+int main(int argc, char **argv)
+{
+    g_test_init(&argc, &argv, NULL);
+
+    qtest_add_func("/k230/rmu/reset_values",   test_reset_values);
+    qtest_add_func("/k230/rmu/cpu_we",         test_cpu_write_enable);
+    qtest_add_func("/k230/rmu/hw_done_w1c",    test_hw_done_and_w1c);
+    qtest_add_func("/k230/rmu/repeat_reset",   test_repeat_reset);
+    qtest_add_func("/k230/rmu/flush",          test_flush_auto_clear);
+    qtest_add_func("/k230/rmu/sw_done",        test_sw_done_storage);
+
+    return g_test_run();
+}
diff --git a/tests/qtest/meson.build b/tests/qtest/meson.build
index 822e0bd286..70c9a53454 100644
--- a/tests/qtest/meson.build
+++ b/tests/qtest/meson.build
@@ -294,7 +294,8 @@ qtests_riscv64 = ['riscv-csr-test'] + \
   (config_all_devices.has_key('CONFIG_IOMMU_TESTDEV') and
    config_all_devices.has_key('CONFIG_RISCV_IOMMU') ?
    ['iommu-riscv-test'] : []) + \
-  (config_all_devices.has_key('CONFIG_K230') ? ['k230-wdt-test'] : [])
+  (config_all_devices.has_key('CONFIG_K230') ? ['k230-wdt-test',
+                                                'k230-rmu-test'] : [])
 
 qtests_hexagon = ['boot-serial-test']
 
-- 
2.53.0


