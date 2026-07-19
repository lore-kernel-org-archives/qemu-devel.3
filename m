Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 030A7C4451B
	for <qemu-devel@archiver.kernel.org>; Sun, 19 Jul 2026 18:03:53 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wlVrI-0006wL-7O; Sun, 19 Jul 2026 14:03:24 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <163wangjack@gmail.com>)
 id 1wlVrF-0006va-TW
 for qemu-devel@nongnu.org; Sun, 19 Jul 2026 14:03:21 -0400
Received: from mail-pg1-x52c.google.com ([2607:f8b0:4864:20::52c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <163wangjack@gmail.com>)
 id 1wlVrC-0004hS-HG
 for qemu-devel@nongnu.org; Sun, 19 Jul 2026 14:03:21 -0400
Received: by mail-pg1-x52c.google.com with SMTP id
 41be03b00d2f7-c96b08cdd1cso6149800a12.0
 for <qemu-devel@nongnu.org>; Sun, 19 Jul 2026 11:03:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1784484197; x=1785088997; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=sDBzCBBeKzYhlZ4EBSkgFwMKpaTq84txzgP/MSeZwi0=;
 b=e0RzWY8fxWsB1fWDRH8OQ7WydvqILNiN4LPmx11tk1GNdOnahbC33WlpHuQ3/dxR76
 gJQilYf4NLdgAFVIj/ZVMNQmJ33i+tktFZImd2I1cJ9SMIhUSfZV5M1gGgOdRd4LL1g8
 p1q9XjR9FBoOOOi1LT4jL10BB1Drjxxv2kZ4nVB/2N7OCOzyaVdKUq4n0d7W+Qz0SqIS
 Fdjdetcwa1Gv/GZBGS6gUFLDLQdfY7EE1Lb7HGy6gHoaXXHNlM0g+hXXae2nJuDLYDCa
 uMYSgKnmiFMAfLKnQix8IQO32Y/AhCMo2aXfbQRpRlLhg/wFGDjrOv8I1ikGD2XM1MO9
 //Hg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1784484197; x=1785088997;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=sDBzCBBeKzYhlZ4EBSkgFwMKpaTq84txzgP/MSeZwi0=;
 b=HZSn2oB0gmoP+iJgDV07O1d5mPU6SveVRW0Bmh8jMsu5M3et5MO6QF0VS7vs6qNVxl
 Cg/9CbQ8WP0icu6yDQXWHkejiIyAK8Whg1SwA5FjQ1FU9FUmdPO71C0Ebij/7RgWFFOi
 HxOB37u9xz1xkTZRmgTO6RZO2+2hB8DymH5cfYwZQmxli2QJo5VVORujB9p9r+RHuBYW
 bw+B/jy4yXc4ljk2ae4QrlrceMdnOH+iZYSIrh7w2xb9fYzznGM+yVdLQdJ/HEk7mm9g
 7U+GfiWqCwwA0gPDyeDiy1QaCBD8Ea4V2pzhuwYS33nJmyNY79vgp3CAjdga3ZgajNRt
 nOUg==
X-Gm-Message-State: AOJu0YxR4btaQUMlyF9hXlSP8MOt/ve5c98wIOaLDJho8C6E4nJV71Lb
 wdyZtCn6zt+YdvQYqaEJvFE02SZ91GbCvpTougWrxPawQZUhR68OkhJLRqmldA==
X-Gm-Gg: AfdE7cm1tBIeluOhaqyJYvEX9WK/hN7zssoESb2reYHrD9uBCnEzu41ov9uBiWxXpHB
 BjKZBaN4BShooS6xF251CHSoBMJcJu/cfQuerNCQsxRuNqGiGhQYMalVLvGE5eY2GRbueyCILZW
 d3OEwDqwGZGd4Uz4ApctndS8h3mpDTO3XRDoTVnVDdSGgs+P/FiigFytdoKUnooXS/Z7PWPaUCE
 /VsCUjYnilG3p7XAfDghXPGyfFx++WHl96xI/5e4CB04vsaH/ubmRodsbfeKJimFMUjbthMiO9a
 XNVGHQR1XBtK7XXwPrTPHOaFL2/84M0/dC5Tor3KDpOtveKybyh84gHfKxIXkGOtRMZA6dsa6jE
 L6TrDaFFioUfEncA8njP/WnYOW0m/pA7yO88i2G0B4Yz+eH2Nu4ai6vuQ8qBNM0c9zX/mjSFXS2
 ycgeAPk4t9G5L3JsBsgeVMKdjt
X-Received: by 2002:a05:6a21:9210:b0:3c0:9c19:65ad with SMTP id
 adf61e73a8af0-3c3ada3981dmr13492055637.69.1784484196454; 
 Sun, 19 Jul 2026 11:03:16 -0700 (PDT)
Received: from localhost.localdomain ([82.40.42.115])
 by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-cb519de3437sm3312907a12.28.2026.07.19.11.03.12
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Sun, 19 Jul 2026 11:03:15 -0700 (PDT)
From: Jack Wang <163wangjack@gmail.com>
To: qemu-devel@nongnu.org
Cc: Chao Liu <chao.liu.zevorn@gmail.com>,
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>,
 Alistair Francis <alistair.francis@wdc.com>,
 Jack Wang <163wangjack@gmail.com>, Paolo Bonzini <pbonzini@redhat.com>,
 qemu-riscv@nongnu.org (open list:K230 Machines)
Subject: [PATCH v2 1/2] hw/misc/k230_rmu: add Kendryte K230 Reset Management
 Unit model
Date: Mon, 20 Jul 2026 02:02:46 +0800
Message-ID: <20260719180247.8660-2-163wangjack@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260719180247.8660-1-163wangjack@gmail.com>
References: <20260719180247.8660-1-163wangjack@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::52c;
 envelope-from=163wangjack@gmail.com; helo=mail-pg1-x52c.google.com
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

The K230 Reset Management Unit (RMU) is a bank of reset-control registers
at 0x91101000. Each register gathers the software-controllable reset lines
of a group of peripherals. Register semantics are modelled after the reset
types described in the Linux mainline driver drivers/reset/reset-k230.c and
cross-checked against the K230 TRM chapter 2.1 "Reset":

  - CPU0      : high-half write-enable strobe and a done bit (bit12); the
                reset request is self-clearing.
  - CPU1      : same layout as CPU0 but the reset request is NOT self-
                clearing: software asserts it and later deasserts it as two
                separate operations.
  - FLUSH     : bit4 of the CPU registers; hardware auto-clears it, no done.
  - HW_DONE   : no write-enable; a done bit is latched when the reset fires
                and cleared by software (write-1-to-clear).
  - SW_DONE   : plain read/write storage, no write-enable and no done bit.
  - *_RST_TIM : reset-time-control registers; plain read/write storage that
                comes up with its documented reset value.

For most groups QEMU has no real peripheral to reset, so the model collapses
the hardware reset latency to zero: writing a reset request bit latches the
matching done bit in the same access and (for self-clearing lines) auto-
clears the request bit, which lets the kernel's readl_poll_timeout() loops
succeed on the first read. The reset values and reserved-bit masks of every
modelled register are taken from the K230 TRM chapter 2.1.5.

An optional pair of "wdt0"/"wdt1" QOM links lets the machine connect the two
watchdogs; asserting their PERI0 reset bits then performs a real
device_cold_reset() on the linked WDT devices.

This commit adds:
- Device model in hw/misc/k230_rmu.c with per-register pairing tables
- Header with register offsets and bit definitions
- Kconfig and meson.build integration
- Trace events for read/write/reset operations

Signed-off-by: Jack Wang <163wangjack@gmail.com>
---
 MAINTAINERS                |   2 +
 hw/misc/Kconfig            |   3 +
 hw/misc/k230_rmu.c         | 425 +++++++++++++++++++++++++++++++++++++
 hw/misc/meson.build        |   1 +
 hw/misc/trace-events       |   7 +
 include/hw/misc/k230_rmu.h | 126 +++++++++++
 6 files changed, 564 insertions(+)
 create mode 100644 hw/misc/k230_rmu.c
 create mode 100644 include/hw/misc/k230_rmu.h

diff --git a/MAINTAINERS b/MAINTAINERS
index 2ecfd7159d..80061ce66d 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -1808,8 +1808,10 @@ M: Chao Liu <chao.liu.zevorn@gmail.com>
 L: qemu-riscv@nongnu.org
 S: Maintained
 F: docs/system/riscv/k230.rst
+F: hw/misc/k230_rmu.c
 F: hw/riscv/k230.c
 F: hw/watchdog/k230_wdt.c
+F: include/hw/misc/k230_rmu.h
 F: include/hw/riscv/k230.h
 F: include/hw/watchdog/k230_wdt.h
 F: tests/qtest/k230-wdt-test.c
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
index 0000000000..af9767b3f4
--- /dev/null
+++ b/hw/misc/k230_rmu.c
@@ -0,0 +1,425 @@
+/*
+ * K230 Reset Management Unit (RMU / SYSCTL_RST)
+ *
+ * The RMU is a bank of reset-control registers at 0x91101000. Each register
+ * gathers the software-controllable reset lines of a group of peripherals.
+ * Register semantics are modelled after the five reset types described in the
+ * Linux mainline driver drivers/reset/reset-k230.c:
+ *
+ *   - CPU0      : high-half write-enable strobe, a done bit (bit12); the reset
+ *                 request is self-clearing.
+ *   - CPU1      : same layout as CPU0 but the reset request is NOT self-
+ *                 clearing: software must assert it and later deassert it as
+ *                 two separate operations.
+ *   - FLUSH     : bit4 of the CPU registers; hardware auto-clears it, no done.
+ *   - HW_DONE   : no write-enable; a done bit is latched when the reset fires
+ *                 and cleared by software (write-1-to-clear).
+ *   - SW_DONE   : plain read/write storage, no write-enable and no done bit.
+ *
+ * For most groups QEMU has no real peripheral to reset, so the model collapses
+ * the hardware reset latency to zero: writing a reset request bit latches the
+ * matching done bit in the same access and (for self-clearing lines) auto-
+ * clears the request bit, which lets the kernel's readl_poll_timeout() loops
+ * succeed on the first read. For the watchdogs, which ARE modelled, asserting
+ * their PERI0 reset bits additionally performs a real device_cold_reset() on
+ * the linked WDT devices (still zero latency, guest-visible ordering intact).
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
+#include "hw/core/qdev.h"
+#include "hw/core/qdev-properties.h"
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
+    /*
+     * true:  the reset request auto-clears once the reset fires.
+     * false: it stays asserted until software deasserts it (CPU1).
+     */
+    bool    self_clear;
+} K230RmuPair;
+
+/* Description of one control register. */
+typedef struct {
+    hwaddr             offset;        /* word-aligned register offset */
+    bool               has_we;        /* high 16 bits are write-enable */
+    const K230RmuPair *pairs;         /* reset/done pairs, NULL for SW_DONE */
+    unsigned           n_pairs;       /* number of pairings (0 for SW_DONE) */
+    uint32_t           reset_val;     /* TRM reset value (per-bit column) */
+    uint32_t           writable_mask; /* writable bits; reserved bits are 0 */
+} K230RmuReg;
+
+/*
+ * Per-register (reset bit -> done bit) tables, copied verbatim from the bit
+ * positions in the Linux driver's k230_resets[] table. The last field marks
+ * whether the reset request auto-clears (see K230RmuPair::self_clear).
+ */
+static const K230RmuPair pairs_cpu0[]    = { {0, 12, true},
+                                             {4, K230_RMU_NO_DONE, true} };
+/* CPU1 reset bit0 is NOT self-clearing: assert and deassert are two steps. */
+static const K230RmuPair pairs_cpu1[]    = { {0, 12, false},
+                                             {4, K230_RMU_NO_DONE, true} };
+static const K230RmuPair pairs_ai[]      = { {0, 31, true} };
+static const K230RmuPair pairs_vpu[]     = { {0, 31, true} };
+/* done in low bits */
+static const K230RmuPair pairs_hisys[]   = { {0, 4, true}, {1, 5, true} };
+static const K230RmuPair pairs_sdio[]    = { {0, 28, true}, {1, 29, true},
+                                             {2, 30, true} };
+static const K230RmuPair pairs_usb[]     = { {0, 28, true}, {1, 29, true},
+                                             {0, 30, true}, {1, 31, true} };
+static const K230RmuPair pairs_spi[]     = { {0, 28, true}, {1, 29, true},
+                                             {2, 30, true} };
+static const K230RmuPair pairs_sec[]     = { {0, 31, true} };
+static const K230RmuPair pairs_dma[]     = { {0, 28, true}, {1, 29, true} };
+static const K230RmuPair pairs_decomp[]  = { {0, 31, true} };
+/* bit1 SW_DONE */
+static const K230RmuPair pairs_sram[]    = { {0, 28, true}, {2, 30, true},
+                                             {3, 31, true} };
+static const K230RmuPair pairs_nonai2d[] = { {0, 31, true} };
+static const K230RmuPair pairs_mctl[]    = { {0, 31, true} };
+/* other low bits SW_DONE */
+static const K230RmuPair pairs_isp[]     = { {6, 29, true}, {5, 28, true} };
+static const K230RmuPair pairs_dpu[]     = { {0, 31, true} };
+static const K230RmuPair pairs_disp[]    = { {0, 31, true} };
+static const K230RmuPair pairs_gpu[]     = { {0, 31, true} };
+static const K230RmuPair pairs_audio[]   = { {0, 31, true} };
+
+/*
+ * Reset values and reserved-bit masks are taken from the K230 TRM (chapter
+ * 2.1.5).
+ *
+ * reset_val uses the per-bit "Reset" column of each register (the status
+ * "*_rst_done" bits reset to 0, so it can differ from the register's summarised
+ * "Total Reset Value"). writable_mask lists the bits the TRM documents as
+ * accessible; undocumented (reserved) bits read back as 0 and ignore writes.
+ *
+ * K230_RMU_REG():  a control register with a reset/done pairing table.
+ * K230_RMU_SW():   a plain read/write storage bank (no reset/done pairs).
+ * K230_RMU_TIM():  a reset-time-control register - plain storage, fully
+ *                  writable, backed by its documented reset value.
+ */
+#define K230_RMU_REG(off, we, p, rst, wmask) \
+    { (off), (we), (p), ARRAY_SIZE(p), (rst), (wmask) }
+#define K230_RMU_SW(off, rst, wmask) \
+    { (off), false, NULL, 0, (rst), (wmask) }
+#define K230_RMU_TIM(off, rst) \
+    { (off), false, NULL, 0, (rst), 0xffffffffu }
+
+static const K230RmuReg k230_rmu_regs[] = {
+    /* Control registers (offset, write-enable, pairs, reset_val, writable). */
+    K230_RMU_REG(K230_RMU_CPU0_CTRL, true, pairs_cpu0, 0x00000000, 0x0000701f),
+    K230_RMU_REG(K230_RMU_CPU1_CTRL, true, pairs_cpu1, 0x00000001, 0x00003011),
+    K230_RMU_REG(K230_RMU_AI_CTRL, false, pairs_ai, 0x00000000, 0x80000001),
+    K230_RMU_REG(K230_RMU_VPU_CTRL, false, pairs_vpu, 0x00000000, 0x80000001),
+    K230_RMU_SW(K230_RMU_PERI0_CTRL, 0x000ff0ff, 0x000ff0ff),
+    K230_RMU_SW(K230_RMU_PERI1_CTRL, 0x007e7fff, 0x007e7fff),
+    K230_RMU_REG(K230_RMU_HISYS_CTRL, false, pairs_hisys, 0x00000000, 0x33),
+    K230_RMU_REG(K230_RMU_SDIO_CTRL, false, pairs_sdio, 0x00000000, 0x70000007),
+    K230_RMU_REG(K230_RMU_USB_CTRL, false, pairs_usb, 0x00000000, 0xf0000003),
+    K230_RMU_REG(K230_RMU_SPI_CTRL, false, pairs_spi, 0x00000000, 0x70000007),
+    K230_RMU_REG(K230_RMU_SEC_CTRL, false, pairs_sec, 0x00000000, 0x80000001),
+    K230_RMU_REG(K230_RMU_DMA_CTRL, false, pairs_dma, 0x00000000, 0x30000003),
+    K230_RMU_REG(K230_RMU_DECOMP_CTRL, false, pairs_decomp, 0x0, 0x80000001),
+    K230_RMU_REG(K230_RMU_SRAM_CTRL, false, pairs_sram, 0x00000002, 0xd000000f),
+    K230_RMU_REG(K230_RMU_NONAI2D_CTRL, false, pairs_nonai2d, 0x0, 0x80000001),
+    K230_RMU_REG(K230_RMU_MCTL_CTRL, false, pairs_mctl, 0x00000000, 0x80000001),
+    K230_RMU_REG(K230_RMU_ISP_CTRL, false, pairs_isp, 0x0000039f, 0x300003ff),
+    K230_RMU_REG(K230_RMU_DPU_CTRL, false, pairs_dpu, 0x00000000, 0x80000001),
+    K230_RMU_REG(K230_RMU_DISP_CTRL, false, pairs_disp, 0x00000000, 0x80000001),
+    K230_RMU_REG(K230_RMU_GPU_CTRL, false, pairs_gpu, 0x00000000, 0x80000001),
+    K230_RMU_REG(K230_RMU_AUDIO_CTRL, false, pairs_audio, 0x0, 0x80000001),
+    K230_RMU_SW(K230_RMU_SPI2AXI_CTRL, 0x00000000, 0xffffffff),
+
+    /* Reset-time-control registers (offset, reset_val). */
+    K230_RMU_TIM(K230_RMU_CPU0_TIM, 0x00fff880),
+    K230_RMU_TIM(K230_RMU_CPU1_TIM, 0x00066660),
+    K230_RMU_TIM(K230_RMU_AI_TIM, 0x00000880),
+    K230_RMU_TIM(K230_RMU_VPU_TIM, 0x00000880),
+    K230_RMU_TIM(K230_RMU_HISYS_TIM, 0x00080800),
+    K230_RMU_TIM(K230_RMU_SDCTL_TIM, 0x00080800),
+    K230_RMU_TIM(K230_RMU_USB_TIM, 0x0008d288),
+    K230_RMU_TIM(K230_RMU_SPI_TIM, 0x00080c00),
+    K230_RMU_TIM(K230_RMU_SEC_TIM, 0x00080800),
+    K230_RMU_TIM(K230_RMU_DMAC_TIM, 0x00040400),
+    K230_RMU_TIM(K230_RMU_DECOMP_TIM, 0x00040400),
+    K230_RMU_TIM(K230_RMU_SRAM_TIM, 0x00020200),
+    K230_RMU_TIM(K230_RMU_NONAI2D_TIM, 0x00020200),
+    K230_RMU_TIM(K230_RMU_MCTL_TIM, 0x00000304),
+    K230_RMU_TIM(K230_RMU_ISP_TIM, 0x00030202),
+    K230_RMU_TIM(K230_RMU_ISP_DW_TIM, 0x00020202),
+    K230_RMU_TIM(K230_RMU_DPU_TIM, 0x00020200),
+    K230_RMU_TIM(K230_RMU_DISP_TIM, 0x00040404),
+    K230_RMU_TIM(K230_RMU_V2P5D_TIM, 0x00040404),
+    K230_RMU_TIM(K230_RMU_AUDIO_TIM, 0x00000880),
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
+/*
+ * Propagate a software reset request to the real peripherals the RMU controls.
+ * Only the two watchdogs are modelled today; asserting their PERI0 reset bits
+ * cold-resets the linked WDT device (a no-op if no device is linked).
+ */
+static void k230_rmu_propagate(K230RmuState *s, hwaddr offset, uint32_t v)
+{
+    if (offset != K230_RMU_PERI0_CTRL) {
+        return;
+    }
+    if ((v & K230_RMU_PERI0_WDT0_RST) && s->reset_targets[0]) {
+        trace_k230_rmu_target_reset(offset, 0);
+        device_cold_reset(s->reset_targets[0]);
+    }
+    if ((v & K230_RMU_PERI0_WDT1_RST) && s->reset_targets[1]) {
+        trace_k230_rmu_target_reset(offset, 1);
+        device_cold_reset(s->reset_targets[1]);
+    }
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
+    /*
+     * All hardware side effects happen on write, so a read just returns the
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
+    uint32_t reset_mask = 0, done_mask = 0, persist_mask = 0, sw_mask;
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
+        /*
+         * Inside the 4 KiB window but not modelled: accept the write and log
+         * it so unexpected accesses are visible while debugging.
+         */
+        qemu_log_mask(LOG_UNIMP,
+                      "%s: write to unmodelled offset 0x%" HWADDR_PRIx
+                      " = 0x%08x\n", __func__, offset, v);
+        s->regs[offset / 4] = v;
+        return;
+    }
+
+    /*
+     * Derive the reset/done/persist masks for this register from its pairing
+     * table. persist_mask collects reset bits that do NOT self-clear (CPU1):
+     * those behave as write-enable-gated storage so software can deassert them.
+     */
+    for (unsigned i = 0; i < r->n_pairs; i++) {
+        reset_mask |= BIT(r->pairs[i].reset_bit);
+        if (r->pairs[i].done_bit != K230_RMU_NO_DONE) {
+            done_mask |= BIT(r->pairs[i].done_bit);
+        }
+        if (!r->pairs[i].self_clear) {
+            persist_mask |= BIT(r->pairs[i].reset_bit);
+        }
+    }
+
+    /*
+     * we_gate holds the low-half bits this write is allowed to modify. With
+     * write-enable (CPU0/CPU1) a low bit n is writable only when the strobe
+     * bit n+16 is also set; otherwise every low bit is directly writable.
+     */
+    /*
+     * we_gate holds the bits this write is allowed to modify. With write-enable
+     * (CPU0/CPU1) a low bit n is writable only when the strobe bit n+16 is also
+     * set, so only the low half can ever change; without write-enable every bit
+     * is directly writable (reserved bits are still dropped by writable_mask).
+     */
+    we_gate = r->has_we ? ((v >> K230_RMU_WE_SHIFT) & 0xffffu) : 0xffffffffu;
+
+    new_val = old;
+
+    /*
+     * (A) Writable storage: bits that are neither reset nor done bits are plain
+     *     read/write storage, plus any non-self-clearing reset bits (so the
+     *     CPU1 request can be asserted and later deasserted). Reserved bits
+     *     are dropped via writable_mask; for write-enable registers only the
+     *     low half is ever reachable (we_gate is confined to 16 bits above).
+     */
+    sw_mask = ((~reset_mask & ~done_mask) | persist_mask)
+              & we_gate & r->writable_mask;
+    new_val = (new_val & ~sw_mask) | (v & sw_mask);
+
+    /*
+     * (B) Done bits are write-1-to-clear. CPU-type done bits sit in the low
+     *     half and their clear is gated by write-enable (the strobe is folded
+     *     into we_gate); HW_DONE done bits sit in the high half, clear direct.
+     */
+    done_gate = r->has_we ? (done_mask & we_gate) : done_mask;
+    new_val &= ~(v & done_gate);
+
+    /*
+     * (C) A reset request latches its paired done bit immediately (zero
+     *     latency). Self-clearing requests then auto-clear so they can fire
+     *     again; non-self-clearing ones (CPU1) stay asserted until deasserted.
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
+            if (r->pairs[i].self_clear) {
+                new_val &= ~rbit;
+            }
+        }
+    }
+
+    s->regs[offset / 4] = new_val;
+
+    /* (D) Drive a real cold reset of any linked peripheral (e.g. watchdogs). */
+    k230_rmu_propagate(s, offset, v);
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
+static void k230_rmu_reset_hold(Object *obj, ResetType type)
+{
+    K230RmuState *s = K230_RMU(obj);
+
+    trace_k230_rmu_reset_device();
+
+    /*
+     * Start from all-zero, then apply each modelled register's documented reset
+     * value (K230 TRM chapter 2.1.5). Unmodelled offsets stay 0.
+     */
+    memset(s->regs, 0, sizeof(s->regs));
+    for (size_t i = 0; i < ARRAY_SIZE(k230_rmu_regs); i++) {
+        s->regs[k230_rmu_regs[i].offset / 4] = k230_rmu_regs[i].reset_val;
+    }
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
+static void k230_rmu_init(Object *obj)
+{
+    K230RmuState *s = K230_RMU(obj);
+
+    /*
+     * Optional links to the peripherals the RMU resets. The machine sets these
+     * before realize; leaving one unset simply disables that reset path.
+     */
+    object_property_add_link(obj, "wdt0", TYPE_DEVICE,
+                             (Object **)&s->reset_targets[0],
+                             qdev_prop_allow_set_link_before_realize,
+                             OBJ_PROP_LINK_STRONG);
+    object_property_add_link(obj, "wdt1", TYPE_DEVICE,
+                             (Object **)&s->reset_targets[1],
+                             qdev_prop_allow_set_link_before_realize,
+                             OBJ_PROP_LINK_STRONG);
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
+    ResettableClass *rc = RESETTABLE_CLASS(klass);
+
+    dc->realize = k230_rmu_realize;
+    /* Resettable API: a register-clearing device needs only phases.hold. */
+    rc->phases.hold = k230_rmu_reset_hold;
+    dc->vmsd = &vmstate_k230_rmu;
+    dc->desc = "K230 Reset Management Unit";
+}
+
+static const TypeInfo k230_rmu_info = {
+    .name          = TYPE_K230_RMU,
+    .parent        = TYPE_SYS_BUS_DEVICE,
+    .instance_size = sizeof(K230RmuState),
+    .instance_init = k230_rmu_init,
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
index b88accc437..ee65409713 100644
--- a/hw/misc/trace-events
+++ b/hw/misc/trace-events
@@ -417,3 +417,10 @@ iommu_testdev_dma_read(uint64_t gva, uint32_t len) "gva=0x%" PRIx64 " len=%u"
 iommu_testdev_dma_verify(uint32_t expected, uint32_t actual) "expected=0x%x actual=0x%x"
 iommu_testdev_dma_result(uint32_t result) "DMA completed result=0x%x"
 iommu_testdev_dma_armed(bool armed) "armed=%d"
+
+# k230_rmu.c
+k230_rmu_read(uint64_t offset, uint32_t value) "K230 RMU read:  [0x%" PRIx64 "] -> 0x%08" PRIx32
+k230_rmu_write(uint64_t offset, uint32_t value) "K230 RMU write: [0x%" PRIx64 "] <- 0x%08" PRIx32
+k230_rmu_flush(uint64_t offset) "K230 RMU flush auto-clear at offset 0x%" PRIx64
+k230_rmu_reset_device(void) "K230 RMU device reset"
+k230_rmu_target_reset(uint64_t offset, unsigned target) "K230 RMU cold-reset target at offset 0x%" PRIx64 " target %u"
diff --git a/include/hw/misc/k230_rmu.h b/include/hw/misc/k230_rmu.h
new file mode 100644
index 0000000000..40ad70a14c
--- /dev/null
+++ b/include/hw/misc/k230_rmu.h
@@ -0,0 +1,126 @@
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
+/*
+ * Control-register offsets used by drivers/reset/reset-k230.c. The driver names
+ * differ from the K230 TRM (chapter 2.1 "Reset"), but the offsets and bit
+ * layouts match the TRM's "*_RST_CTL" registers, named in the trailing comment.
+ * The documented reset values live in k230_rmu_regs[] in k230_rmu.c.
+ */
+#define K230_RMU_CPU0_CTRL     0x04   /* CPU0_RST_CTL */
+#define K230_RMU_CPU1_CTRL     0x0C   /* CPU1_RST_CTL */
+#define K230_RMU_AI_CTRL       0x14   /* AI_RST_CTL */
+#define K230_RMU_VPU_CTRL      0x1C   /* VPU_RST_CTL */
+#define K230_RMU_PERI0_CTRL    0x20   /* SOC_CTL_RST_CTL */
+/*
+ * PERI0 (SOC_CTL_RST_CTL) software-reset bits for the two watchdogs. In the TRM
+ * these are wdt_0_reset (bit12) / wdt_1_reset (bit13), whose reset value is 1
+ * ("reset disassert"). The model treats a write of these bits as "trigger a
+ * reset", driving a real cold reset of the linked WDT devices (see the
+ * "wdt0"/"wdt1" QOM links).
+ */
+#define K230_RMU_PERI0_WDT0_RST  BIT(12)
+#define K230_RMU_PERI0_WDT1_RST  BIT(13)
+#define K230_RMU_PERI1_CTRL    0x24   /* LOSYS_RST_CTL */
+#define K230_RMU_HISYS_CTRL    0x2C   /* HISYS_RST_CTL */
+#define K230_RMU_SDIO_CTRL     0x34   /* SDC_RST_CTL */
+#define K230_RMU_USB_CTRL      0x3C   /* USB_RST_CTL */
+#define K230_RMU_SPI_CTRL      0x44   /* SPI_RST_CTL */
+#define K230_RMU_SEC_CTRL      0x4C   /* SEC_RST_CTL */
+#define K230_RMU_DMA_CTRL      0x54   /* DMA_RST_CTL */
+#define K230_RMU_DECOMP_CTRL   0x5C   /* DECOMPRESS_RST_CTL */
+#define K230_RMU_SRAM_CTRL     0x64   /* SRAM_RST_CTL */
+#define K230_RMU_NONAI2D_CTRL  0x6C   /* NONAI2D_RST_CTL */
+#define K230_RMU_MCTL_CTRL     0x74   /* MCTL_RST_CTL */
+#define K230_RMU_ISP_CTRL      0x80   /* ISP_RST_CTL */
+#define K230_RMU_DPU_CTRL      0x88   /* DPU_RST_CTL */
+#define K230_RMU_DISP_CTRL     0x90   /* DISP_RST_CTL */
+#define K230_RMU_GPU_CTRL      0x98   /* V2P5D_RST_CTL */
+#define K230_RMU_AUDIO_CTRL    0xA4   /* AUDIO_RST_CTL */
+#define K230_RMU_SPI2AXI_CTRL  0xA8   /* SW_DONE (not in TRM) */
+
+/*
+ * Reset-time-control ("*_RST_TIM") registers. These interleave with the control
+ * registers above and are plain read/write timing storage with no side effects,
+ * so the model backs them with their documented reset value (see k230_rmu.c).
+ */
+#define K230_RMU_CPU0_TIM      0x00   /* CPU0_RST_TIM */
+#define K230_RMU_CPU1_TIM      0x08   /* CPU1_RST_TIM */
+#define K230_RMU_AI_TIM        0x10   /* AI_RST_TIM */
+#define K230_RMU_VPU_TIM       0x18   /* VPU_RST_TIM */
+#define K230_RMU_HISYS_TIM     0x28   /* HISYS_HCLK_TIM */
+#define K230_RMU_SDCTL_TIM     0x30   /* SDCTL_RST_TIM */
+#define K230_RMU_USB_TIM       0x38   /* USB_RST_TIM */
+#define K230_RMU_SPI_TIM       0x40   /* SPI_RST_TIM */
+#define K230_RMU_SEC_TIM       0x48   /* SEC_SYS_RST_TIM */
+#define K230_RMU_DMAC_TIM      0x50   /* DMAC_RST_TIM */
+#define K230_RMU_DECOMP_TIM    0x58   /* DECOMPRESS_RST_TIM */
+#define K230_RMU_SRAM_TIM      0x60   /* SRAM_RST_TIM */
+#define K230_RMU_NONAI2D_TIM   0x68   /* NONAI2D_RST_TIM */
+#define K230_RMU_MCTL_TIM      0x70   /* MCTL_RST_TIM */
+#define K230_RMU_ISP_TIM       0x78   /* ISP_RST_TIM */
+#define K230_RMU_ISP_DW_TIM    0x7C   /* ISP_DW_RST_TIM */
+#define K230_RMU_DPU_TIM       0x84   /* DPU_RST_TIM */
+#define K230_RMU_DISP_TIM      0x8C   /* DISP_SYS_RST_TIM */
+#define K230_RMU_V2P5D_TIM     0x94   /* V2P5D_SYS_RST_TIM */
+#define K230_RMU_AUDIO_TIM     0xA0   /* AUDIO_RST_TIM */
+
+/* Bit layout shared by the CPU0/CPU1 control registers. */
+#define K230_RMU_CPU_RESET     BIT(0)    /* reset request, auto/soft cleared */
+#define K230_RMU_CPU_FLUSH     BIT(4)    /* L2 flush, hw auto-clears */
+#define K230_RMU_CPU_DONE      BIT(12)   /* done bit, write-1-to-clear */
+
+/* The high 16 bits are per-bit write-enable strobes (CPU0/CPU1 registers). */
+#define K230_RMU_WE_SHIFT      16
+
+/* Devices the RMU can cold-reset: WDT0, WDT1 (via the "wdt0"/"wdt1" links). */
+#define K230_RMU_NUM_TARGETS   2
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
+
+    /*
+     * Optional links to the peripherals the RMU actually resets. Populated by
+     * the machine via the "wdt0"/"wdt1" QOM link properties; a NULL entry just
+     * means "no device connected" and the reset request is a no-op.
+     */
+    DeviceState *reset_targets[K230_RMU_NUM_TARGETS];
+};
+
+#endif /* HW_MISC_K230_RMU_H */
-- 
2.53.0


