Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 056A2C44529
	for <qemu-devel@archiver.kernel.org>; Tue, 21 Jul 2026 12:00:56 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wm991-00040u-MZ; Tue, 21 Jul 2026 08:00:25 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <1640586082@qq.com>)
 id 1wm2B1-0001xw-Az; Tue, 21 Jul 2026 00:33:57 -0400
Received: from out162-62-57-87.mail.qq.com ([162.62.57.87])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <1640586082@qq.com>)
 id 1wm2Au-0004pL-9a; Tue, 21 Jul 2026 00:33:55 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qq.com; s=s201512;
 t=1784608419; bh=ZOSh+t6QdlLJy4k1iAKNQq5HJDxR1GCWIJYNVFIeTVg=;
 h=From:Date:Subject:To:Cc;
 b=Rs8BL7K501qYOLAtVOIUUqY6ci5P1Kyf7a0Hwe2PUJ9sp2pB4zVp2z862iyHmh7Rf
 Fu8vN8dfwd1SoQIQ9nDutFWCyM4fKyDoSrzldjpjAUU4KW5e6xUDTUe/kJFhUluO8p
 5Kdx7asNFyjeUceEfxBVn3HL3hMuFG3QD5bjHX+c=
Received: from [127.0.1.1] ([2409:895a:cad:26bc:1850:1304:aa14:14ba])
 by newxmesmtplogicsvrszc43-0.qq.com (NewEsmtp) with SMTP
 id 6882E433; Tue, 21 Jul 2026 12:26:08 +0800
X-QQ-mid: xmsmtpt1784607968t544f6mze
Message-ID: <tencent_FE5823EA5F7A9EDE163FEDCB3DBFBE1FD905@qq.com>
X-QQ-XMAILINFO: NIrVQ0DLdJesDtHD78BhM4Si2Z06USgw1jOOa6HncGwWFOvLjCtQzlTqHAo8Be
 0t43q3FlbFfxj7sC+WhYt95KDUHw6L+IMLxgYKMh0zkaAGr665Z4VWoXO4rdWQl/uEtN3rTWKjiw
 Bnm28vErIDE8Cvmy7PMcaMr3IKSDPlv6bJf8WwHP9o0O6gqM1cB/9VmTjvBFmoRpmFfbndvRhQXp
 XlkfTFK1LmHQQS3M0ekw7MXB2SZyjpZSCNEG6WKR5HJyf0IiKCMHip/CgyfeHfmwHq1pQeKT1cbe
 qNeSOmrkVpzrs1QbOeJuZ0MJLvo983qt3GG1q6Li7qcQJKubU7W0UW1QBb+4JvG982ii5OTH0+lF
 Y2sqY2XxhIci/GDO5AijWEGBT2vXrAgi1VVkvhUAHkb3oJqYJLDvEUkB2QY6GMm5RIO1UV2JYmwB
 UdVnTS2sP14RlQcvAi6gnoHcm7//QX2rlf4wX/4mfcD3SxFPYpfXHtxMIfCCPcYw0iCDnr9Pf6Kj
 W9z3ASHaIjeiv4nPTkwOWeLZma5bP+bnQHC+5tpkdVrsIc5c/0/+eMlA4VO+HLR7TjeCA76Sx3kW
 3u53U71slbJVxIDzVaIVL5Gsweo1aVxkxkfe2Jr+WcgJ2zQNWwFa8Ln6qCpLN/8PgqaRMsSsOaBh
 dPMhRGi1V8YV4xifP6Rt3EF3ZUizYIsK3hQTbhfNw9587TWGxeEpJzWDcowgNY3iMI6X+XQc6AHx
 g6hpaLUEXKf23Cfxl9PRdyNgjKETjRlZxiCNAsO5hzh0G6/qfbk16r3HsVEMo35NFJgoJ6W8Ug57
 j71tWg0JZBcTn8KFLDEcTz9HT8CKY/9gcyhAapkDQSHtbMfs8uqKY3MWxZ4insdJjaOJVPbnqSqV
 hwQ5f03N7Uo4jpfyTHPtuZHRA3CEDLgDY2tY1MedYoqGQnt51McqqzblniFbiitBqPHsNEoLAzzv
 WMAkWwKPEvL2v3+dOQuwvtmDAHoMIF+FTPiXCyBqQIWYhXNhcSHBq6PaScW6gbfTmGsrBxsW2qWt
 JgSyWoKKvDwtEpUc7vm1AqAtAq9Yu2C05/NbvkfeEL4PzH6+hZXgRs5lVB1Kfy2pIPaBT1trkphY
 bKbJxJI6Qbhg4qsh14TCUuMDiOGKjFHO7le2W3H6AtynKxiTFGt8vN0bSzZ/8brnGX1cWqXDQzZh
 H3/uXAM8gSQVGZlEKfXh7CA6fSOltm22PGUbA=
X-QQ-XMRINFO: MPJ6Tf5t3I/ylTmHUqvI8+Wpn+Gzalws3A==
From: zhenbaii <1640586082@qq.com>
Date: Tue, 21 Jul 2026 12:26:07 +0800
Subject: [PATCH] feat(char): implement DesignWare 8250-compatible UART
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-OQ-MSGID: <20260721-k230-uart-rfc-v1-1-0c331f67d89d@qq.com>
X-B4-Tracking: v=1; b=H4sIAN70XmoC/6tWKk4tykwtVrJSqFYqSi3LLM7MzwNyDHUUlJIzE
 vPSU3UzU4B8JSMDIzMDcyND3WwjYwPd0sSiEt2itGRdS1NTCzPjRLOUJNMUJaCegqLUtMwKsHn
 RsbW1AH5dLx9fAAAA
X-Change-ID: 20260721-k230-uart-rfc-955863a6db5d
To: qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>, 
 =?utf-8?q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>, 
 Chao Liu <chao.liu.zevorn@gmail.com>, Palmer Dabbelt <palmer@dabbelt.com>, 
 Alistair Francis <alistair.francis@wdc.com>, 
 Weiwei Li <liwei1518@gmail.com>, 
 Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>, 
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>, Fabiano Rosas <farosas@suse.de>, 
 Laurent Vivier <lvivier@redhat.com>, qemu-riscv@nongnu.org, 
 zhenbaii <1640586082@qq.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1784607968; l=59251;
 i=1640586082@qq.com; s=20260721; h=from:subject:message-id;
 bh=Avb1AsZwaIAbMMHhm+9AvPDZ02yQREkwH7Gv7iR4lDk=;
 b=iAsRRb5gV2NroG7Q1U+6qlDrH+L159ZVxKwtWyp9+5o09rg4/RCS1llpTmJybMA5TRhFkq2Oy
 G/IF474iSwbBo1Nw0dj5+67rgXhZyZRmANSLD82R3cXqj1YRJK2FaT/
X-Developer-Key: i=1640586082@qq.com; a=ed25519;
 pk=AjRy6i+I/zX9djX87K/xR2OQ2Myy7s7j7bDdi9Qz3zw=
Received-SPF: pass client-ip=162.62.57.87; envelope-from=1640586082@qq.com;
 helo=out162-62-57-87.mail.qq.com
X-Spam_score_int: -28
X-Spam_score: -2.9
X-Spam_bar: --
X-Spam_report: (-2.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FREEMAIL_ENVFROM_END_DIGIT=0.25, FREEMAIL_FROM=0.001, HELO_STATIC_HOST=-0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=-1, RCVD_IN_MSPIKE_WL=-0.01,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-Mailman-Approved-At: Tue, 21 Jul 2026 08:00:08 -0400
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

Implement a K230 SoC DesignWare 8250-compatible UART controller model for
QEMU, capable of running the Linux 8250_dw driver and providing an
interactive shell.

Implemented:
  - Standard 16550 registers (RBR/THR/DLL, IER/DLH, IIR/FCR, LCR, MCR,
    LSR, MSR, SCR) and DesignWare-specific registers (USR, TFL, RFL, SRR,
    SRTS, SBCR, SDMAM, SFE, SRT, STET, HTX, CPR, UCV, CTR)
  - DLAB switching; 32-byte TX/RX FIFO; synchronous transmit with
    backpressure handling
  - Loopback mode; chardev BREAK routed to LSR.BI/FE via CHR_EVENT_BREAK
  - Four-level prioritized interrupt scheme (ELSI / RX Data / Timeout /
    THRE), with edge-triggered THRE
  - RX Character Timeout interrupt (IID=0xc) with 4-char-time timer that
    tracks the programmed divisor latch
  - Busy Detect interrupt (IID=0x7): LCR (and its shadow SBCR) writes
    while USR.BUSY=1 are rejected and raise IID=0x7, cleared by reading
    USR; USR.BUSY reflects TX-not-empty / RX-data-ready
  - Shadow registers alias their underlying fields
  - SRR (UR/RFR/XFR) self-clearing software reset

Not implemented:
  - RS485 transceiver control (TCR/DE_EN/RE_EN/DET/TAT)
  - 9-bit multidrop (LCR_EXT/RAR/TAR)
  - Fractional baud rate (DLF)
  - Auto Flow Control (MCR.AFCE)
  - IrDA SIR mode (MCR.SIRE)
  - Low-power divisor latch (LPDLL/LPDLH)
  - FIFO access test mode (FAR/TFR/RFW)
  - DMA Software Acknowledge (DMASA)

qtest:
  - 8 functional-path test cases covering driver scenarios (device probe,
    init & baud config, TX/RX datapath, THRE interrupt, RX interrupts,
    error interrupts & IIR priority, busy detect & USR, advanced
    features); all pass.

Verification:
  - Using the k230-boot-assets image from
        https://github.com/zevorn/k230-boot-assets, the 8250_dw driver probes successfully
    and the interactive shell works. Bidirectional transmission with the
    host was verified via microcom + pty.

Signed-off-by: zhenbaii <1640586082@qq.com>
---
Sending this as RFC since it is my first submission to QEMU.  Feedback on
code structure, coding style, and whether the feature set is appropriate
would be greatly appreciated.
---
 hw/char/Kconfig              |   3 +
 hw/char/k230_uart.c          | 840 +++++++++++++++++++++++++++++++++++++++++++
 hw/char/meson.build          |   1 +
 hw/riscv/k230.c              |  33 +-
 include/hw/char/k230_uart.h  | 180 ++++++++++
 include/hw/riscv/k230.h      |   6 +-
 tests/qtest/k230-uart-test.c | 514 ++++++++++++++++++++++++++
 tests/qtest/meson.build      |   2 +-
 8 files changed, 1565 insertions(+), 14 deletions(-)

diff --git a/hw/char/Kconfig b/hw/char/Kconfig
index 020c0a84bb6e5f11cc7d532a7999ade23505a1ba..bd000f7127e7881dabac191c81b2bcf66f549250 100644
--- a/hw/char/Kconfig
+++ b/hw/char/Kconfig
@@ -91,6 +91,9 @@ config GOLDFISH_TTY
 config SHAKTI_UART
     bool
 
+config K230_UART
+    bool
+
 config IP_OCTAL_232
     bool
     default y
diff --git a/hw/char/k230_uart.c b/hw/char/k230_uart.c
new file mode 100644
index 0000000000000000000000000000000000000000..0e5bee4c1fcd415e42a2761bcc5d4446027d60a6
--- /dev/null
+++ b/hw/char/k230_uart.c
@@ -0,0 +1,840 @@
+/*
+ * K230 UART
+ *
+ * Copyright (c) 2026 zhenbaii <1640586082@qq.com>
+ *
+ * SPDX-License-Identifier: GPL-2.0-or-later
+ */
+
+#include "qemu/osdep.h"
+#include "hw/char/k230_uart.h"
+#include "hw/core/irq.h"
+#include "hw/core/qdev-properties-system.h"
+#include "migration/vmstate.h"
+#include "qemu/module.h"
+#include "qemu/timer.h"
+#include "qemu/host-utils.h"
+#include "system/memory.h"
+
+/* Serial clock from the K230 DT "clock-frequency" property (50 MHz). */
+#define K230_UART_SCLK_HZ   50000000ull
+
+static void k230_uart_xmit(K230UartState *s);
+static void k230_uart_update_all(K230UartState *s);
+static uint64_t k230_uart_read_rbr(K230UartState *s);
+static void k230_uart_push_rx_byte(K230UartState *s, uint8_t ch);
+static void k230_uart_reset_hold(Object *obj, ResetType type);
+
+/* ---- interrupt line ---- */
+
+/*
+ * RX FIFO trigger level. When rx_count reaches this,
+ * the RX Data Available interrupt (IID=0x4) fires.
+ */
+static uint32_t k230_uart_rx_trigger_level(const K230UartState *s)
+{
+    if (!FIELD_EX32(s->fcr, FCR, FIFOE)) {
+        return 1;  /* non-FIFO mode: 1 byte */
+    }
+    switch (FIELD_EX32(s->fcr, FCR, RT)) {
+    case 0:  return 1;
+    case 1:  return K230_UART_FIFO_DEPTH / 4;
+    case 2:  return K230_UART_FIFO_DEPTH / 2;
+    case 3:  return K230_UART_FIFO_DEPTH - 2;
+    default: return 1;
+    }
+}
+
+static void k230_uart_update_irq(K230UartState *s)
+{
+    bool irq = false;
+    uint32_t rx_itl = k230_uart_rx_trigger_level(s);
+
+    /* RX trigger level > 1 */
+    if (FIELD_EX32(s->ier, IER, ERBFI) &&
+        (s->rx_count >= rx_itl || s->timeout_ipending)) {
+        irq = true;
+    }
+    /* Transmit Holding Register Empty Interrupt */
+    if (FIELD_EX32(s->ier, IER, ETBEI) && s->thr_ipending) {
+        irq = true;
+    }
+    /* Receiver Line Status Interrupt */
+    if (FIELD_EX32(s->ier, IER, ELSI) &&
+        (FIELD_EX32(s->lsr, LSR, OE) || FIELD_EX32(s->lsr, LSR, PE) ||
+         FIELD_EX32(s->lsr, LSR, FE) || FIELD_EX32(s->lsr, LSR, BI))) {
+        irq = true;
+    }
+    /* Busy detect interrupt (DW-specific, no IER gate). */
+    if (s->busy_ipending) {
+        irq = true;
+    }
+    qemu_set_irq(s->irq, irq ? 1 : 0);
+}
+
+/* ---- FIFO reset ---- */
+
+static void k230_uart_fifo_reset(K230UartState *s, bool rx, bool tx)
+{
+    if (rx) {
+        s->rx_head = s->rx_tail = s->rx_count = 0;
+        s->lsr = FIELD_DP32(s->lsr, LSR, DR, 0);
+        s->timeout_ipending = 0;
+        timer_del(&s->rx_timeout);
+    }
+    if (tx) {
+        s->tx_head = s->tx_tail = s->tx_count = 0;
+        s->lsr = FIELD_DP32(s->lsr, LSR, THRE, 1);
+        s->lsr = FIELD_DP32(s->lsr, LSR, TEMT, 1);
+        s->thr_ipending = 1;
+    }
+    k230_uart_update_all(s);
+}
+
+/* ---- transmit ---- */
+
+static gboolean k230_uart_chr_can_write(void *do_not_use, GIOCondition cond,
+                                        void *opaque)
+{
+    K230UartState *s = K230_UART(opaque);
+    if (!s->htx) {
+        k230_uart_xmit(s);
+    }
+    return G_SOURCE_REMOVE;
+}
+
+/* ---- baud / char-transmit time ---- */
+
+/*
+ * Recompute the per-character transmit time from the current divisor latch:
+ *
+ *   baud    = sclk / (16 * divisor)
+ *   char_ns = 10 * 16 * divisor * 1e9 / sclk     (10 = 8N1 start+data+stop)
+ *
+ * Drives the RX timeout interrupt (IID=0xc), which fires after 4 char times.
+ * divisor == 0 means "unprogrammed": keep the previous (reset default) value.
+ */
+static void k230_uart_update_char_time(K230UartState *s)
+{
+    uint32_t divisor = ((uint32_t)s->dlh << 8) | s->dll;
+    if (divisor == 0) {
+        return;
+    }
+    s->char_transmit_time = muldiv64(10ull * 16 * divisor,
+                                     NANOSECONDS_PER_SECOND,
+                                     K230_UART_SCLK_HZ);
+}
+
+/* Send all characters in THR or TX-FIFO into char backend */
+static void k230_uart_xmit(K230UartState *s)
+{
+    int ret;
+
+    if (s->tx_count == 0 || s->htx) {
+        return;
+    }
+
+    while (s->tx_count > 0) {
+        uint8_t ch = (uint8_t)s->tx_fifo[s->tx_tail];
+
+        if (FIELD_EX32(s->mcr, MCR, LOOPBACK)) {
+            /* Go to RX fifo */
+            k230_uart_push_rx_byte(s, ch);
+            ret = 1;
+        } else {
+            /* Go to char backend */
+            ret = qemu_chr_fe_write(&s->chr, &ch, 1);
+        }
+        if (ret < 0) {
+            /* Wait for backend to be accessible then call the callback */
+            qemu_chr_fe_add_watch(&s->chr, G_IO_OUT,
+                                  k230_uart_chr_can_write, s);
+            break;
+        }
+
+        s->tx_tail = (s->tx_tail + 1) % K230_UART_FIFO_DEPTH;
+        s->tx_count--;
+    }
+
+    s->lsr = FIELD_DP32(s->lsr, LSR, TEMT, (s->tx_count == 0) ? 1 : 0);
+    k230_uart_update_all(s);
+}
+
+/* ---- RX timeout ---- */
+
+/* Character timeout callback */
+static void k230_uart_rx_timeout(void *opaque)
+{
+    K230UartState *s = K230_UART(opaque);
+    if (s->rx_count > 0) {
+        s->timeout_ipending = 1;
+        k230_uart_update_all(s);
+    }
+}
+
+/* ---- receive ---- */
+
+/* Push a byte to rxfifo(when FIFO_EN is set) or RBR(FIFO_EN not set). */
+static void k230_uart_push_rx_byte(K230UartState *s, uint8_t ch)
+{
+    bool fifo_en = FIELD_EX32(s->fcr, FCR, FIFOE);
+    uint16_t capacity = fifo_en ? K230_UART_FIFO_DEPTH : 1;
+
+    if (s->rx_count < capacity) {
+        s->rx_fifo[s->rx_head] = ch;
+        s->rx_head = (s->rx_head + 1) % K230_UART_FIFO_DEPTH;
+        s->rx_count++;
+        s->lsr = FIELD_DP32(s->lsr, LSR, DR, 1);
+        timer_mod(&s->rx_timeout,
+                  qemu_clock_get_ns(QEMU_CLOCK_VIRTUAL)
+                  + 4 * s->char_transmit_time);
+    } else {
+        s->lsr = FIELD_DP32(s->lsr, LSR, OE, 1);
+    }
+    k230_uart_update_all(s);
+}
+
+/* ---- derived register recomputation ---- */
+
+static void k230_uart_update_thre(K230UartState *s)
+{
+    bool should_set = (s->tx_count == 0);
+#if K230_UART_THRE_MODE
+    if (FIELD_EX32(s->ier, IER, PTIME)
+        && FIELD_EX32(s->fcr, FCR, FIFOE)) {
+        uint8_t tet = FIELD_EX32(s->fcr, FCR, TET);
+        uint16_t threshold;
+        switch (tet) {
+        case 0x0:
+            threshold = 0;
+            break;
+        case 0x1:
+            threshold = 2;
+            break;
+        case 0x2:
+            threshold = K230_UART_FIFO_DEPTH / 4;
+            break;
+        case 0x3:
+            threshold = K230_UART_FIFO_DEPTH / 2;
+            break;
+        default:
+            threshold = 0;
+            break;
+        }
+        should_set = (s->tx_count <= threshold);
+    }
+#endif
+
+    uint8_t old_thre = FIELD_EX32(s->lsr, LSR, THRE);
+    s->lsr = FIELD_DP32(s->lsr, LSR, THRE, should_set ? 1 : 0);
+
+    /* Edge trigger */
+    if (should_set && !old_thre) {
+        s->thr_ipending = 1;
+    }
+}
+
+static bool k230_uart_is_busy(const K230UartState *s)
+{
+    return !FIELD_EX32(s->lsr, LSR, TEMT) || FIELD_EX32(s->lsr, LSR, DR);
+}
+
+static void k230_uart_update_usr(K230UartState *s)
+{
+    bool fifo_en = FIELD_EX32(s->fcr, FCR, FIFOE);
+    uint16_t capacity = fifo_en ? K230_UART_FIFO_DEPTH : 1;
+
+    s->usr = 0;
+#if !K230_UART_16550_COMPATIBLE
+    if (k230_uart_is_busy(s)) {
+        s->usr = FIELD_DP32(s->usr, USR, BUSY, 1);
+    }
+#endif
+#if K230_UART_FIFO_STAT && K230_UART_FIFO_MODE
+    s->usr = FIELD_DP32(s->usr, USR, TFNF, s->tx_count < capacity ? 1 : 0);
+    s->usr = FIELD_DP32(s->usr, USR, TFE, s->tx_count == 0 ? 1 : 0);
+    s->usr = FIELD_DP32(s->usr, USR, RFNE, s->rx_count != 0 ? 1 : 0);
+    s->usr = FIELD_DP32(s->usr, USR, RFF, s->rx_count == capacity ? 1 : 0);
+#endif
+}
+
+static void k230_uart_update_iir(K230UartState *s)
+{
+    s->iir = 0;
+    /* Indicate whether FIFO is enabled or not */
+    if (FIELD_EX32(s->fcr, FCR, FIFOE)) {
+        s->iir = FIELD_DP32(s->iir, IIR, FIFOSE, 0x3);
+    }
+
+    if (FIELD_EX32(s->ier, IER, ELSI) &&
+        (FIELD_EX32(s->lsr, LSR, OE) || FIELD_EX32(s->lsr, LSR, PE) ||
+         FIELD_EX32(s->lsr, LSR, FE) || FIELD_EX32(s->lsr, LSR, BI))) {
+        /* Receiver Line Status Interrupt */
+        s->iir = FIELD_DP32(s->iir, IIR, IID, 0x6);
+    } else if (FIELD_EX32(s->ier, IER, ERBFI) &&
+               (s->rx_count >= k230_uart_rx_trigger_level(s))) {
+        /* Receiver Data Available Interrupt */
+        s->iir = FIELD_DP32(s->iir, IIR, IID, 0x4);
+    } else if (FIELD_EX32(s->ier, IER, ERBFI) && s->timeout_ipending) {
+        /* Character timeout interrupt */
+        s->iir = FIELD_DP32(s->iir, IIR, IID, 0xc);
+    } else if (FIELD_EX32(s->ier, IER, ETBEI) && s->thr_ipending) {
+        /* THR Empty Interrupt */
+        s->iir = FIELD_DP32(s->iir, IIR, IID, 0x2);
+    } else if (s->busy_ipending) {
+        /* Busy detect: LCR written while USR.BUSY=1 (DW-specific) */
+        s->iir = FIELD_DP32(s->iir, IIR, IID, 0x7);
+    } else {
+        s->iir = FIELD_DP32(s->iir, IIR, IID, 0x1);
+    }
+}
+
+
+static void k230_uart_update_msr(K230UartState *s)
+{
+    uint8_t old_status = s->msr & 0xf0;
+    uint8_t new_status;
+
+    if (FIELD_EX32(s->mcr, MCR, LOOPBACK)) {
+        /*
+         * Standard 16550 loopback mapping:
+         * DTR -> DSR, RTS -> CTS, OUT1 -> RI, OUT2 -> DCD
+         */
+        new_status = 0;
+        if (FIELD_EX32(s->mcr, MCR, RTS)) {
+            new_status |= 0x10; /* CTS */
+        }
+        if (FIELD_EX32(s->mcr, MCR, DTR)) {
+            new_status |= 0x20; /* DSR */
+        }
+        if (FIELD_EX32(s->mcr, MCR, OUT1)) {
+            new_status |= 0x40; /* RI  */
+        }
+        if (FIELD_EX32(s->mcr, MCR, OUT2)) {
+            new_status |= 0x80; /* DCD */
+        }
+    } else {
+        /* No real modem: report CTS/DSR/DCD as active (ready) */
+        new_status = 0xb0; /* CTS | DSR | DCD */
+    }
+
+    /* Accumulate delta bits on status changes */
+    uint8_t deltas = s->msr & 0x0f;
+    uint8_t changes = old_status ^ new_status;
+    if (changes & 0x10) {
+        deltas |= 0x01; /* DCTS */
+    }
+    if (changes & 0x20) {
+        deltas |= 0x02; /* DDSR */
+    }
+    if ((old_status & 0x40) && !(new_status & 0x40)) {
+        deltas |= 0x04; /* TERI */
+    }
+    if (changes & 0x80) {
+        deltas |= 0x08; /* DDCD */
+    }
+
+    s->msr = new_status | deltas;
+}
+
+static void k230_uart_update_all(K230UartState *s)
+{
+    k230_uart_update_thre(s);
+    k230_uart_update_usr(s);
+    k230_uart_update_iir(s);
+    k230_uart_update_irq(s);
+}
+
+/* ---- MMIO read ---- */
+
+static uint64_t k230_uart_read_rbr(K230UartState *s)
+{
+    uint64_t ret = 0;
+
+    if (s->rx_count > 0) {
+        ret = s->rx_fifo[s->rx_tail];
+        s->rx_tail = (s->rx_tail + 1) % K230_UART_FIFO_DEPTH;
+        s->rx_count--;
+        s->timeout_ipending = 0;
+        if (s->rx_count == 0) {
+            s->lsr = FIELD_DP32(s->lsr, LSR, DR, 0);
+            timer_del(&s->rx_timeout);
+        } else {
+            timer_mod(&s->rx_timeout,
+                      qemu_clock_get_ns(QEMU_CLOCK_VIRTUAL)
+                      + 4 * s->char_transmit_time);
+        }
+        qemu_chr_fe_accept_input(&s->chr);
+    }
+
+    if (!FIELD_EX32(s->ier, IER, ELCOLR)) {
+        s->lsr = FIELD_DP32(s->lsr, LSR, OE, 0);
+        s->lsr = FIELD_DP32(s->lsr, LSR, PE, 0);
+        s->lsr = FIELD_DP32(s->lsr, LSR, FE, 0);
+        s->lsr = FIELD_DP32(s->lsr, LSR, BI, 0);
+    }
+
+    k230_uart_update_all(s);
+    return ret;
+}
+
+static uint64_t k230_uart_read(void *opaque, hwaddr addr, unsigned int size)
+{
+    K230UartState *s = K230_UART(opaque);
+    uint64_t ret = 0;
+
+    switch (addr >> 2) {
+    case R_RBR_DLL_THR:
+        if (FIELD_EX32(s->lcr, LCR, DLAB)) {
+            /* DLL accessible only when not busy. */
+            ret = (K230_UART_16550_COMPATIBLE || !k230_uart_is_busy(s))
+                  ? s->dll : 0;
+        } else {
+            ret = k230_uart_read_rbr(s);
+        }
+        break;
+    case R_IER_DLH:
+        if (FIELD_EX32(s->lcr, LCR, DLAB)) {
+            /* DLH accessible only when not busy. */
+            ret = (K230_UART_16550_COMPATIBLE || !k230_uart_is_busy(s))
+                  ? s->dlh : 0;
+        } else {
+            /* IER */
+            ret = s->ier;
+        }
+        break;
+    case R_IIR:
+        ret = s->iir;
+        if (FIELD_EX32(s->iir, IIR, IID) == 0x2) {
+            s->thr_ipending = 0;
+            k230_uart_update_all(s);
+        }
+        break;
+    case R_LCR:
+        ret = s->lcr;
+        break;
+    case R_LSR:
+        ret = s->lsr;
+        /* Clear OE PE FE and Break Interrupt status bits */
+        s->lsr = FIELD_DP32(s->lsr, LSR, OE, 0);
+        s->lsr = FIELD_DP32(s->lsr, LSR, PE, 0);
+        s->lsr = FIELD_DP32(s->lsr, LSR, FE, 0);
+        s->lsr = FIELD_DP32(s->lsr, LSR, BI, 0);
+        k230_uart_update_all(s);
+        break;
+    case R_MCR:
+        ret = s->mcr;
+        break;
+    case R_MSR:
+        ret = s->msr;
+        s->msr &= 0xf0; /* clear delta bits on read */
+        break;
+    case R_SCR:
+        ret = s->scr;
+        break;
+
+    /* Shadow registers: aliases of standard registers. */
+    case R_SRTS:
+        ret = FIELD_EX32(s->mcr, MCR, RTS);
+        break;
+    case R_SBCR:
+        ret = FIELD_EX32(s->lcr, LCR, BC);
+        break;
+    case R_SDMAM:
+        ret = FIELD_EX32(s->fcr, FCR, DMAM);
+        break;
+    case R_SFE:
+        ret = FIELD_EX32(s->fcr, FCR, FIFOE);
+        break;
+    case R_SRT:
+        ret = FIELD_EX32(s->fcr, FCR, RT);
+        break;
+    case R_STET:
+        ret = FIELD_EX32(s->fcr, FCR, TET);
+        break;
+    case R_HTX:
+        ret = s->htx;
+        break;
+
+    case R_CPR:
+        ret = (K230_UART_APB_DATA_WIDTH          << 0)   |
+                   (K230_UART_AFCE_MODE               << 4)   |
+                   (K230_UART_THRE_MODE                << 5)   |
+                   (K230_UART_SIR_MODE                 << 6)   |
+                   (K230_UART_SIR_LP_MODE              << 7)   |
+                   (K230_UART_ADDITIONAL_FEATURES      << 8)   |
+                   (K230_UART_FIFO_ACCESS              << 9)   |
+                   (K230_UART_FIFO_STAT                << 10)  |
+                   (K230_UART_SHADOW                   << 11)  |
+                   (K230_UART_ADD_ENCODED_PARAMS       << 12)  |
+                   (K230_UART_DMA_EXTRA                << 13)  |
+                   (K230_UART_FIFO_MODE                << 16);
+        break;
+    case R_UCV:
+        /* Version */
+        ret = 0x342e3061;
+        break;
+    case R_DLF:
+        ret = 0;
+        break;
+    case R_USR:
+        ret = s->usr;
+        /* Reading USR clears the busy-detect interrupt. */
+        if (s->busy_ipending) {
+            s->busy_ipending = 0;
+            k230_uart_update_all(s);
+        }
+        break;
+    case R_TFL:
+        /* Transmit FIFO Level: number of bytes in TX FIFO. */
+        ret = s->tx_count;
+        break;
+    case R_RFL:
+        /* Receive FIFO Level: number of bytes in RX FIFO. */
+        ret = s->rx_count;
+        break;
+    case R_CTR:
+        /* Component Type Register: fixed ID. */
+        ret = K230_UART_CTR_VALUE;
+        break;
+    default:
+        ret = 0;
+        break;
+    }
+    return ret;
+}
+
+/* ---- MMIO write ---- */
+
+static void k230_uart_write(void *opaque, hwaddr addr,
+                                uint64_t val64, unsigned int size)
+{
+    K230UartState *s = K230_UART(opaque);
+    uint32_t val = (uint32_t)val64;
+    uint32_t offset = addr >> 2;
+
+    switch (offset) {
+    case R_RBR_DLL_THR:
+        if (FIELD_EX32(s->lcr, LCR, DLAB)) {
+            /* DLL writable only when not busy. */
+            if (K230_UART_16550_COMPATIBLE || !k230_uart_is_busy(s)) {
+                s->dll = val & 0xff;
+                k230_uart_update_char_time(s);
+            }
+        } else {
+            bool fifo_en = FIELD_EX32(s->fcr, FCR, FIFOE);
+            uint16_t capacity = fifo_en ? K230_UART_FIFO_DEPTH : 1;
+            if (s->tx_count < capacity) {
+                s->tx_fifo[s->tx_head] = val & 0xff;
+                s->tx_head = (s->tx_head + 1) % K230_UART_FIFO_DEPTH;
+                s->tx_count++;
+            } else if (!fifo_en) {
+                s->tx_fifo[s->tx_tail] = val & 0xff;
+            }
+            s->lsr = FIELD_DP32(s->lsr, LSR, THRE, 0);
+            s->thr_ipending = 0;
+            s->lsr = FIELD_DP32(s->lsr, LSR, TEMT, 0);
+            k230_uart_xmit(s);
+        }
+        break;
+    case R_IER_DLH:
+        if (FIELD_EX32(s->lcr, LCR, DLAB)) {
+            /* DLH writable only when not busy. */
+            if (K230_UART_16550_COMPATIBLE || !k230_uart_is_busy(s)) {
+                s->dlh = val & 0xff;
+                k230_uart_update_char_time(s);
+            }
+        } else {
+            uint8_t old_etbei = FIELD_EX32(s->ier, IER, ETBEI);
+            s->ier = FIELD_DP32(s->ier, IER, ERBFI,
+                                FIELD_EX32(val, IER, ERBFI));
+            s->ier = FIELD_DP32(s->ier, IER, ETBEI,
+                                FIELD_EX32(val, IER, ETBEI));
+            s->ier = FIELD_DP32(s->ier, IER, ELSI,
+                                FIELD_EX32(val, IER, ELSI));
+            s->ier = FIELD_DP32(s->ier, IER, EDSSI,
+                                FIELD_EX32(val, IER, EDSSI));
+            s->ier = FIELD_DP32(s->ier, IER, ELCOLR,
+                                FIELD_EX32(val, IER, ELCOLR));
+    #if K230_UART_THRE_MODE
+            s->ier = FIELD_DP32(s->ier, IER, PTIME,
+                                FIELD_EX32(val, IER, PTIME));
+    #endif
+            if (!old_etbei && FIELD_EX32(s->ier, IER, ETBEI)
+                && FIELD_EX32(s->lsr, LSR, THRE)) {
+                s->thr_ipending = 1;
+            }
+        }
+        break;
+    case R_FCR:
+        if ((val ^ s->fcr) & R_FCR_FIFOE_MASK) {
+            val |= R_FCR_RFIFOR_MASK | R_FCR_XFIFOR_MASK;
+        }
+        s->fcr = FIELD_DP32(s->fcr, FCR, FIFOE,
+                            FIELD_EX32(val, FCR, FIFOE));
+        s->fcr = FIELD_DP32(s->fcr, FCR, DMAM,
+                            FIELD_EX32(val, FCR, DMAM));
+        s->fcr = FIELD_DP32(s->fcr, FCR, RT,
+                            FIELD_EX32(val, FCR, RT));
+    #if K230_UART_THRE_MODE
+        s->fcr = FIELD_DP32(s->fcr, FCR, TET,
+                            FIELD_EX32(val, FCR, TET));
+    #endif
+        if (FIELD_EX32(val, FCR, RFIFOR)) {
+            k230_uart_fifo_reset(s, true, false);
+        }
+        if (FIELD_EX32(val, FCR, XFIFOR)) {
+            k230_uart_fifo_reset(s, false, true);
+        }
+        break;
+    case R_LCR:
+        /*
+         * When UART_16550_COMPATIBLE == NO (the K230 case),
+         * LCR is writable only when USR.BUSY == 0.  A write while busy is
+         * ignored and triggers the busy-detect interrupt (IID=0x7), which is
+         * cleared by reading USR.  The 8250_dw driver detects this via
+         * dw8250_check_lcr() and retries after draining the FIFOs.
+         */
+        if (!K230_UART_16550_COMPATIBLE && k230_uart_is_busy(s)) {
+            s->busy_ipending = 1;
+        } else {
+            s->lcr = val & 0xff;
+        }
+        break;
+    case R_MCR:
+        /*
+         * K230 advertises AFCE_MODE=0 and SIR_MODE=0 in CPR, so MCR[5:6]
+         * (AFCE/SIRE) are read-only 0.  MCR[7] is reserved and also 0.
+         */
+        s->mcr = val & 0x1f;
+        k230_uart_update_msr(s);
+        break;
+    case R_SCR:
+        s->scr = val & 0xff;
+        break;
+
+    /*
+     * Shadow registers: aliases of standard register fields.
+     * They let software update a single bit without read-modify-write on the
+     * original register.  SBCR shadows LCR[6] (BC), which is gated by the
+     * busy-detect logic just like a direct LCR write.
+     */
+    case R_SRTS:
+        s->mcr = FIELD_DP32(s->mcr, MCR, RTS, val & 0x1);
+        k230_uart_update_msr(s);
+        break;
+    case R_SBCR:
+        if (!K230_UART_16550_COMPATIBLE && k230_uart_is_busy(s)) {
+            s->busy_ipending = 1;
+        } else {
+            s->lcr = FIELD_DP32(s->lcr, LCR, BC, val & 0x1);
+        }
+        break;
+    case R_SDMAM:
+        s->fcr = FIELD_DP32(s->fcr, FCR, DMAM, val & 0x1);
+        break;
+    case R_SFE:
+        /* Shadow of FCR[0]; changing FIFOE resets both FIFOs */
+        if ((s->fcr ^ val) & R_FCR_FIFOE_MASK) {
+            k230_uart_fifo_reset(s, true, true);
+        }
+        s->fcr = FIELD_DP32(s->fcr, FCR, FIFOE, val & 0x1);
+        break;
+    case R_SRT:
+        s->fcr = FIELD_DP32(s->fcr, FCR, RT, val & 0x3);
+        break;
+    case R_STET:
+    #if K230_UART_THRE_MODE
+        s->fcr = FIELD_DP32(s->fcr, FCR, TET, val & 0x3);
+    #endif
+        break;
+    case R_HTX:
+        s->htx = val & 0x1;
+        /* Clearing HTX resumes transmission of any buffered TX data. */
+        if (!s->htx) {
+            k230_uart_xmit(s);
+        }
+        break;
+
+    case R_SRR:
+        if (FIELD_EX32(val, SRR, UR)) {
+            device_cold_reset(DEVICE(s));
+            return;
+        }
+        if (FIELD_EX32(val, SRR, RFR)) {
+            k230_uart_fifo_reset(s, true, false);
+        }
+        if (FIELD_EX32(val, SRR, XFR)) {
+            k230_uart_fifo_reset(s, false, true);
+        }
+        break;
+
+    default:
+        break;
+    }
+    k230_uart_update_all(s);
+}
+
+/* ---- device lifecycle ---- */
+
+static const MemoryRegionOps k230_uart_ops = {
+    .read = k230_uart_read,
+    .write = k230_uart_write,
+    .endianness = DEVICE_LITTLE_ENDIAN,
+    .impl.min_access_size = 4,
+    .impl.max_access_size = 4,
+};
+
+static void k230_uart_init(Object *obj)
+{
+    K230UartState *s = K230_UART(obj);
+    SysBusDevice *sbd = SYS_BUS_DEVICE(obj);
+
+    memory_region_init_io(&s->mmio, OBJECT(s), &k230_uart_ops, s,
+                          TYPE_K230_UART, 0x100);
+    sysbus_init_mmio(sbd, &s->mmio);
+    sysbus_init_irq(sbd, &s->irq);
+}
+
+static int k230_uart_can_receive(void *opaque)
+{
+    K230UartState *s = K230_UART(opaque);
+    return K230_UART_FIFO_DEPTH - s->rx_count;
+}
+
+static void k230_uart_receive(void *opaque, const uint8_t *buf, int size)
+{
+    K230UartState *s = K230_UART(opaque);
+    for (int i = 0; i < size; i++) {
+        k230_uart_push_rx_byte(s, buf[i]);
+    }
+}
+
+static void k230_uart_event(void *opaque, QEMUChrEvent event)
+{
+    K230UartState *s = K230_UART(opaque);
+
+    if (event == CHR_EVENT_BREAK) {
+        k230_uart_push_rx_byte(s, 0);
+        s->lsr = FIELD_DP32(s->lsr, LSR, BI, 1);
+        s->lsr = FIELD_DP32(s->lsr, LSR, FE, 1);
+        k230_uart_update_all(s);
+    }
+}
+
+static void k230_uart_reset_hold(Object *obj, ResetType type)
+{
+    K230UartState *s = K230_UART(obj);
+    s->lcr = 0;
+    s->fcr = 0;
+    s->ier = 0;
+    s->mcr = 0;
+    s->scr = 0;
+    s->dll = 0;
+    s->dlh = 0;
+    s->lsr = 0x60;
+    s->msr = 0xb0;
+
+    s->rx_head = s->rx_tail = s->rx_count = 0;
+    s->tx_head = s->tx_tail = s->tx_count = 0;
+    s->htx = 0;
+
+    qemu_set_irq(s->irq, 0);
+
+    s->thr_ipending = 0;
+    s->timeout_ipending = 0;
+    s->busy_ipending = 0;
+    timer_del(&s->rx_timeout);
+    /* Default to 115200 baud until the driver programs the divisor latch. */
+    s->char_transmit_time = (NANOSECONDS_PER_SECOND / 115200) * 10;
+
+    k230_uart_update_all(s);
+}
+
+static void k230_uart_realize(DeviceState *dev, Error **errp)
+{
+    K230UartState *s = K230_UART(dev);
+    qemu_chr_fe_set_handlers(&s->chr, k230_uart_can_receive,
+                             k230_uart_receive, k230_uart_event,
+                             NULL, s, NULL, true);
+
+    timer_init_ns(&s->rx_timeout, QEMU_CLOCK_VIRTUAL,
+                  k230_uart_rx_timeout, s);
+}
+
+static int k230_uart_post_load(void *opaque, int version_id)
+{
+    K230UartState *s = K230_UART(opaque);
+
+    /*
+     * iir and usr are derived from the saved state; recompute them after
+     * migration so the device is consistent.
+     */
+    k230_uart_update_all(s);
+    return 0;
+}
+
+static const VMStateDescription vmstate_k230_uart = {
+    .name = "k230.uart",
+    .version_id = 2,
+    .minimum_version_id = 1,
+    .post_load = k230_uart_post_load,
+    .fields = (const VMStateField[]) {
+        VMSTATE_UINT8(lcr,   K230UartState),
+        VMSTATE_UINT8(fcr,   K230UartState),
+        VMSTATE_UINT8(ier,   K230UartState),
+        VMSTATE_UINT8(dll,   K230UartState),
+        VMSTATE_UINT8(dlh,   K230UartState),
+        VMSTATE_UINT8(mcr,   K230UartState),
+        VMSTATE_UINT8(lsr,   K230UartState),
+        VMSTATE_UINT8(msr,   K230UartState),
+        VMSTATE_UINT8(scr,   K230UartState),
+        VMSTATE_UINT8(htx,   K230UartState),
+        VMSTATE_UINT16_ARRAY(rx_fifo, K230UartState,
+                             K230_UART_FIFO_DEPTH),
+        VMSTATE_UINT16_ARRAY(tx_fifo, K230UartState,
+                             K230_UART_FIFO_DEPTH),
+        VMSTATE_UINT32(rx_head, K230UartState),
+        VMSTATE_UINT32(rx_tail, K230UartState),
+        VMSTATE_UINT32(rx_count, K230UartState),
+        VMSTATE_UINT32(tx_head, K230UartState),
+        VMSTATE_UINT32(tx_tail, K230UartState),
+        VMSTATE_UINT32(tx_count, K230UartState),
+        VMSTATE_UINT8(thr_ipending, K230UartState),
+        VMSTATE_UINT8(timeout_ipending, K230UartState),
+        VMSTATE_UINT8(busy_ipending, K230UartState),
+        VMSTATE_UINT64(char_transmit_time, K230UartState),
+        VMSTATE_END_OF_LIST()
+    }
+};
+
+static const Property k230_uart_properties[] = {
+    DEFINE_PROP_CHR("chardev", K230UartState, chr),
+};
+
+static void k230_uart_class_init(ObjectClass *klass, const void *data)
+{
+    DeviceClass *dc = DEVICE_CLASS(klass);
+    ResettableClass *rc = RESETTABLE_CLASS(klass);
+
+    dc->realize = k230_uart_realize;
+    rc->phases.hold = k230_uart_reset_hold;
+    dc->vmsd = &vmstate_k230_uart;
+    dc->desc = "K230 UART (16550-compatible)";
+    device_class_set_props(dc, k230_uart_properties);
+}
+
+static const TypeInfo k230_uart_info = {
+    .name = TYPE_K230_UART,
+    .parent = TYPE_SYS_BUS_DEVICE,
+    .instance_size = sizeof(K230UartState),
+    .instance_init = k230_uart_init,
+    .class_init = k230_uart_class_init
+};
+
+static void k230_uart_register_types(void)
+{
+    type_register_static(&k230_uart_info);
+}
+
+type_init(k230_uart_register_types)
diff --git a/hw/char/meson.build b/hw/char/meson.build
index fc3d7ee506fcf8eb1219f6af9689fd90573861c9..23d8ede3f031f80d1b519bf49beac9d23502e2cb 100644
--- a/hw/char/meson.build
+++ b/hw/char/meson.build
@@ -38,6 +38,7 @@ system_ss.add(when: 'CONFIG_STM32L4X5_USART', if_true: files('stm32l4x5_usart.c'
 system_ss.add(when: 'CONFIG_MCHP_PFSOC_MMUART', if_true: files('mchp_pfsoc_mmuart.c'))
 system_ss.add(when: 'CONFIG_HTIF', if_true: files('riscv_htif.c'))
 system_ss.add(when: 'CONFIG_GOLDFISH_TTY', if_true: files('goldfish_tty.c'))
+system_ss.add(when: 'CONFIG_K230', if_true: files('k230_uart.c'))
 
 specific_ss.add(when: 'CONFIG_TERMINAL3270', if_true: files('terminal3270.c'))
 specific_ss.add(when: 'CONFIG_PSERIES', if_true: files('spapr_vty.c'))
diff --git a/hw/riscv/k230.c b/hw/riscv/k230.c
index 502281c52cff1dce6febb7487dfdefefe6363e9c..d49fa23448f38dfed45a570eb5bece64519bfe27 100644
--- a/hw/riscv/k230.c
+++ b/hw/riscv/k230.c
@@ -29,7 +29,6 @@
 #include "hw/riscv/machines-qom.h"
 #include "hw/intc/riscv_aclint.h"
 #include "hw/intc/sifive_plic.h"
-#include "hw/char/serial-mm.h"
 #include "hw/misc/unimp.h"
 
 /* Align K230_SDK k230_canmv_defconfig */
@@ -111,6 +110,11 @@ static void k230_soc_init(Object *obj)
     object_initialize_child(obj, "k230-wdt0", &s->wdt[0], TYPE_K230_WDT);
     object_initialize_child(obj, "k230-wdt1", &s->wdt[1], TYPE_K230_WDT);
 
+    for (int i = 0; i < K230_UART_COUNT; i++) {
+        g_autofree char *name = g_strdup_printf("k230-uart%d", i);
+        object_initialize_child(obj, name, &s->uart[i], TYPE_K230_UART);
+    }
+
     qdev_prop_set_uint32(DEVICE(cpu0), "hartid-base", 0);
     qdev_prop_set_string(DEVICE(cpu0), "cpu-type", TYPE_RISCV_CPU_THEAD_C908);
     qdev_prop_set_uint64(DEVICE(cpu0), "resetvec",
@@ -136,19 +140,26 @@ static DeviceState *k230_create_plic(int base_hartid, int hartid_count)
                               memmap[K230_DEV_PLIC].size);
 }
 
-static void k230_create_uart(MemoryRegion *sys_mem, DeviceState *plic,
-                             int index)
+static void k230_create_uart(K230SoCState *s, DeviceState *plic, int index)
 {
     int uart_dev = K230_DEV_UART0 + index;
-    g_autofree char *name = g_strdup_printf("uart%d", index);
+    g_autofree char *unimpl_name = g_strdup_printf("uart%d", index);
+    DeviceState *dev = DEVICE(&s->uart[index]);
 
-    /* Cover the non-16550 part of the SDK's 0x1000 UART window. */
-    create_unimplemented_device(name, memmap[uart_dev].base,
-                                memmap[uart_dev].size);
+    qdev_prop_set_chr(dev, "chardev", serial_hd(index));
 
-    serial_mm_init(sys_mem, memmap[uart_dev].base, 2,
-                   qdev_get_gpio_in(plic, K230_UART0_IRQ + index),
-                   399193, serial_hd(index), DEVICE_LITTLE_ENDIAN);
+    if (!sysbus_realize(SYS_BUS_DEVICE(dev), &error_fatal)) {
+        return;
+    }
+
+    sysbus_mmio_map(SYS_BUS_DEVICE(dev), 0, memmap[uart_dev].base);
+    sysbus_connect_irq(SYS_BUS_DEVICE(dev), 0,
+                       qdev_get_gpio_in(plic, K230_UART0_IRQ + index));
+
+    /* Cover the non-16550 part of the SDK's 0x1000 UART window. */
+    create_unimplemented_device(unimpl_name,
+                                memmap[uart_dev].base + 0x100,
+                                memmap[uart_dev].size - 0x100);
 }
 
 static void k230_soc_realize(DeviceState *dev, Error **errp)
@@ -188,7 +199,7 @@ static void k230_soc_realize(DeviceState *dev, Error **errp)
 
     /* UART */
     for (int i = 0; i < K230_UART_COUNT; i++) {
-        k230_create_uart(sys_mem, DEVICE(s->c908_plic), i);
+        k230_create_uart(s, DEVICE(s->c908_plic), i);
     }
 
     /* Watchdog */
diff --git a/include/hw/char/k230_uart.h b/include/hw/char/k230_uart.h
new file mode 100644
index 0000000000000000000000000000000000000000..60e39101c00c73d0167fcff47bc1e56fe4cf0b19
--- /dev/null
+++ b/include/hw/char/k230_uart.h
@@ -0,0 +1,180 @@
+/*
+ * K230 UART device
+ *
+ * K230 Technical Reference Manual V0.3.1 (2024-11-18):
+ * https://github.com/revyos/external-docs/blob/master/K230/en-us/K230_Technical_Reference_Manual_V0.3.1_20241118.pdf
+ *
+ * Register semantics cross-checked against the SDK Linux driver
+ * src/little/linux/drivers/tty/serial/8250/8250_dw.c in
+ * https://github.com/kendryte/k230_sdk (compatible "snps,dw-apb-uart").
+ *
+ * Copyright (c) 2026 zhenbaii <1640586082@qq.com>
+ *
+ * SPDX-License-Identifier: GPL-2.0-or-later
+ */
+
+#ifndef HW_K230_UART_H
+#define HW_K230_UART_H
+
+#include "hw/core/sysbus.h"
+#include "chardev/char-fe.h"
+#include "hw/core/registerfields.h"
+#include "qom/object.h"
+
+REG32(RBR_DLL_THR, 0x00)
+REG32(IER_DLH, 0x04)
+REG32(IER, 0x04)
+    FIELD(IER, ERBFI, 0, 1)
+    FIELD(IER, ETBEI, 1, 1)
+    FIELD(IER, ELSI, 2, 1)
+    FIELD(IER, EDSSI, 3, 1)
+    FIELD(IER, ELCOLR, 4, 1)
+    FIELD(IER, PTIME, 7, 1)
+REG32(FCR, 0x08)
+    FIELD(FCR, FIFOE, 0, 1)
+    FIELD(FCR, RFIFOR, 1, 1)
+    FIELD(FCR, XFIFOR, 2, 1)
+    FIELD(FCR, DMAM, 3, 1)
+    FIELD(FCR, TET, 4, 2)
+    FIELD(FCR, RT, 6, 2)
+REG32(IIR, 0x08)
+    FIELD(IIR, IID, 0, 4)
+    FIELD(IIR, FIFOSE, 6, 2)
+REG32(LCR, 0x0c)
+    FIELD(LCR, DLS, 0, 2)
+    FIELD(LCR, STOP, 2, 1)
+    FIELD(LCR, PEN, 3, 1)
+    FIELD(LCR, EPS, 4, 1)
+    FIELD(LCR, SP, 5, 1)
+    FIELD(LCR, BC, 6, 1)
+    FIELD(LCR, DLAB, 7, 1)
+REG32(MCR, 0x10)
+    FIELD(MCR, DTR, 0, 1)
+    FIELD(MCR, RTS, 1, 1)
+    FIELD(MCR, OUT1, 2, 1)
+    FIELD(MCR, OUT2, 3, 1)
+    FIELD(MCR, LOOPBACK, 4, 1)
+    FIELD(MCR, AFCE, 5, 1)
+    FIELD(MCR, SIRE, 6, 1)
+REG32(LSR, 0x14)
+    FIELD(LSR, DR, 0, 1)
+    FIELD(LSR, OE, 1, 1)
+    FIELD(LSR, PE, 2, 1)
+    FIELD(LSR, FE, 3, 1)
+    FIELD(LSR, BI, 4, 1)
+    FIELD(LSR, THRE, 5, 1)
+    FIELD(LSR, TEMT, 6, 1)
+    FIELD(LSR, RFE, 7, 1)
+    FIELD(LSR, ADDR_RSVD, 8, 1)
+REG32(MSR, 0x18)
+    FIELD(MSR, DCTS, 0, 1)
+    FIELD(MSR, DDSR, 1, 1)
+    FIELD(MSR, TERI, 2, 1)
+    FIELD(MSR, DDCD, 3, 1)
+    FIELD(MSR, CTS, 4, 1)
+    FIELD(MSR, DSR, 5, 1)
+    FIELD(MSR, RI, 6, 1)
+    FIELD(MSR, DCD, 7, 1)
+REG32(RFW, 0x78)
+    FIELD(RFW, RFWD, 0, 8)
+    FIELD(RFW, RFPE, 8, 1)
+    FIELD(RFW, RFFE, 9, 1)
+REG32(USR, 0x7c)
+    FIELD(USR, BUSY, 0, 1)
+    FIELD(USR, TFNF, 1, 1)
+    FIELD(USR, TFE, 2, 1)
+    FIELD(USR, RFNE, 3, 1)
+    FIELD(USR, RFF, 4, 1)
+REG32(TFL, 0x80)
+    FIELD(TFL, TFL, 0, 5)
+REG32(RFL, 0x84)
+    FIELD(RFL, RFL, 0, 5)
+REG32(SRR, 0x88)
+    FIELD(SRR, UR, 0, 1)
+    FIELD(SRR, RFR, 1, 1)
+    FIELD(SRR, XFR, 2, 1)
+REG32(SRTS, 0x8c)
+    FIELD(SRTS, SRTS, 0, 1)
+REG32(SBCR, 0x90)
+    FIELD(SBCR, SBCB, 0, 1)
+REG32(SDMAM, 0x94)
+    FIELD(SDMAM, SDMAM, 0, 1)
+REG32(SFE, 0x98)
+    FIELD(SFE, SFE, 0, 1)
+REG32(SRT, 0x9c)
+    FIELD(SRT, SRT, 0, 2)
+REG32(STET, 0xa0)
+    FIELD(STET, STET, 0, 2)
+REG32(HTX, 0xa4)
+    FIELD(HTX, HTX, 0, 1)
+REG32(TCR, 0xac)
+    FIELD(TCR, RS485_EN, 0, 1)
+    FIELD(TCR, RE_POL, 1, 1)
+    FIELD(TCR, DE_POL, 2, 1)
+    FIELD(TCR, XFER_MODE, 3, 2)
+REG32(SCR, 0x1c)
+REG32(DLF, 0xc0)
+REG32(CPR, 0xf4)
+REG32(UCV, 0xf8)
+REG32(CTR, 0xfc)
+
+/* peripheral ID 0x44570110 ("DW\x01\x10").  Read-only. */
+#define K230_UART_CTR_VALUE  0x44570110u
+#define K230_UART_16550_COMPATIBLE    0
+#define K230_UART_FIFO_DEPTH          32
+
+/* CPR */
+#define K230_UART_APB_DATA_WIDTH      2      /* CPR[1:0]  - 32-bit APB       */
+#define K230_UART_AFCE_MODE           0      /* CPR[4]    - not implemented */
+#define K230_UART_THRE_MODE           1      /* CPR[5]    - implemented     */
+#define K230_UART_SIR_MODE            0      /* CPR[6]    - not implemented */
+#define K230_UART_SIR_LP_MODE         0      /* CPR[7]    - not implemented */
+#define K230_UART_ADDITIONAL_FEATURES 1      /* CPR[8]    - UCV/CTR present */
+#define K230_UART_FIFO_ACCESS         0      /* CPR[9]    - not implemented */
+#define K230_UART_FIFO_STAT           1      /* CPR[10]   - TFL/RFL present */
+#define K230_UART_SHADOW              1      /* CPR[11]   - shadow regs     */
+#define K230_UART_ADD_ENCODED_PARAMS  1      /* CPR[12]   - CPR present     */
+#define K230_UART_DMA_EXTRA           0      /* CPR[13]   - not implemented */
+#define K230_UART_FIFO_MODE           0x2    /* CPR[23:16] - 32-byte FIFO   */
+
+#define TYPE_K230_UART "k230-uart"
+OBJECT_DECLARE_SIMPLE_TYPE(K230UartState, K230_UART)
+struct K230UartState {
+    SysBusDevice parent_obj;
+    MemoryRegion mmio;
+
+    /* Standard 16550 registers */
+    uint8_t  dll;       /* Divisor Latch Low,               offset 0x00 */
+    uint8_t  ier;       /* Interrupt Enable,                offset 0x04 */
+    uint8_t  dlh;       /* Divisor Latch High,              offset 0x04 */
+    uint8_t  fcr;       /* FIFO Control,                    offset 0x08 */
+    uint8_t  iir;       /* Interrupt Identification,        offset 0x08 */
+    uint8_t  lcr;       /* Line Control,                    offset 0x0c */
+    uint8_t  mcr;       /* Modem Control,                   offset 0x10 */
+    uint8_t  lsr;       /* Line Status,                     offset 0x14 */
+    uint8_t  msr;       /* Modem Status,                    offset 0x18 */
+    uint8_t  scr;       /* Scratchpad,                      offset 0x1c */
+
+    /* DesignWare-specific registers */
+    uint8_t  usr;       /* UART Status,                     offset 0x7c */
+    uint8_t  htx;       /* Halt TX,                         offset 0xa4 */
+
+    /* Internal interrupt state. */
+    uint8_t  thr_ipending;       /* THR empty (IID=0x2) pending     */
+    uint8_t  timeout_ipending;   /* RX FIFO timeout (IID=0xc)       */
+    uint8_t  busy_ipending;      /* busy detect (IID=0x7) pending   */
+
+    /* FIFO */
+    uint16_t rx_fifo[K230_UART_FIFO_DEPTH];
+    uint32_t rx_head, rx_tail, rx_count;
+    uint16_t tx_fifo[K230_UART_FIFO_DEPTH];
+    uint32_t tx_head, tx_tail, tx_count;
+
+    uint64_t char_transmit_time;
+
+    CharFrontend chr;
+    qemu_irq    irq;
+    QEMUTimer rx_timeout;
+};
+
+#endif
diff --git a/include/hw/riscv/k230.h b/include/hw/riscv/k230.h
index 592e1c26bf8a8f8a1c66653ff9b568fbfe98a3ea..fed0357c2b9e1f5254cb157e0cd4d75d4946d1a1 100644
--- a/include/hw/riscv/k230.h
+++ b/include/hw/riscv/k230.h
@@ -17,10 +17,13 @@
 
 #include "hw/core/boards.h"
 #include "hw/riscv/riscv_hart.h"
+#include "hw/char/k230_uart.h"
 #include "hw/watchdog/k230_wdt.h"
 
 #define C908_CPU_HARTID   (0)
 
+#define K230_UART_COUNT 5
+
 #define TYPE_RISCV_K230_SOC "riscv.k230.soc"
 #define RISCV_K230_SOC(obj) \
     OBJECT_CHECK(K230SoCState, (obj), TYPE_RISCV_K230_SOC)
@@ -32,6 +35,7 @@ typedef struct K230SoCState {
     /*< public >*/
     RISCVHartArrayState c908_cpu; /* Small core */
 
+    K230UartState uart[K230_UART_COUNT];
     K230WdtState wdt[2];
     MemoryRegion sram;
     MemoryRegion bootrom;
@@ -131,8 +135,6 @@ enum {
     K230_WDT1_IRQ   = 108,
 };
 
-#define K230_UART_COUNT 5
-
 /*
  * Integrates with the interrupt controller (PLIC),
  * which can process 208 interrupt external sources
diff --git a/tests/qtest/k230-uart-test.c b/tests/qtest/k230-uart-test.c
new file mode 100644
index 0000000000000000000000000000000000000000..f85c690ebb57abb5b7f753f36c06c0900c3cfbb9
--- /dev/null
+++ b/tests/qtest/k230-uart-test.c
@@ -0,0 +1,514 @@
+/*
+ * QTest for the K230 UART — functional-path coverage.
+ *
+ * Tests are organised around driver usage scenarios rather than
+ * enumerating every register in isolation.
+ *
+ * SPDX-License-Identifier: GPL-2.0-or-later
+ */
+
+#include "qemu/osdep.h"
+#include "libqtest.h"
+#include <string.h>
+
+#define UART_BASE  0x91400000
+#define R(off)     (UART_BASE + (off))
+
+/* register offsets */
+#define THR    0x00
+#define IER    0x04
+#define IIR    0x08
+#define LCR    0x0c
+#define MCR    0x10
+#define LSR    0x14
+#define SCR    0x1c
+#define USR    0x7c
+#define TFL    0x80
+#define RFL    0x84
+#define SRR    0x88
+#define SRTS   0x8c
+#define SBCR   0x90
+#define SDMAM  0x94
+#define SFE    0x98
+#define SRT    0x9c
+#define STET   0xa0
+#define HTX    0xa4
+#define CPR    0xf4
+#define CTR    0xfc
+
+/* bit fields */
+#define LCR_DLAB     0x80
+#define LCR_BC       0x40
+#define LCR_8N1      0x03
+
+#define LSR_DR       0x01
+#define LSR_OE       0x02
+#define LSR_THRE     0x20
+#define LSR_TEMT     0x40
+#define LSR_RESET    0x60
+
+#define IIR_IID      0x0f
+#define IIR_NONE     0x01
+#define IIR_THR      0x02
+#define IIR_RX       0x04
+#define IIR_LINE     0x06
+#define IIR_BUSY     0x07
+#define IIR_TO       0x0c
+#define IIR_FF       0xc0
+
+#define IER_RX       0x01
+#define IER_TX       0x02
+#define IER_LS       0x04
+#define IER_COLR     0x10
+#define IER_PTIME    0x80
+
+#define MCR_LB       0x10
+#define MCR_RTS      0x02
+
+#define FCR_FE       0x01
+#define FCR_RR       0x02
+#define FCR_XR       0x04
+#define FCR_TET_H    (3 << 4)
+#define FCR_RT_Q     (1 << 6)
+#define FCR_RT_F     (3 << 6)
+
+#define USR_BUSY     0x01
+#define USR_RESET    0x06
+
+#define SRR_UR       0x01
+#define SRR_RFR      0x02
+
+/* helpers */
+static uint32_t rd(QTestState *qts, uint32_t o)
+{
+    return qtest_readl(qts, R(o));
+}
+static uint32_t iid(QTestState *qts)
+{
+    return rd(qts, IIR) & IIR_IID;
+}
+
+static void poll_lsr(QTestState *qts, uint32_t m)
+{
+    int i;
+
+    for (i = 0; i < 1000; i++) {
+        if (rd(qts, LSR) & m) {
+            return;
+        }
+        g_usleep(1000);
+    }
+    g_assert_not_reached();
+}
+
+static void s1(QTestState *qts, int fd, char c)
+{
+    g_assert_cmpint(send(fd, &c, 1, 0), ==, 1);
+    poll_lsr(qts, LSR_DR);
+}
+
+static void sn(QTestState *qts, int fd, const char *d, int n)
+{
+    g_assert_cmpint(send(fd, d, n, 0), ==, n);
+    poll_lsr(qts, LSR_DR);
+}
+
+static void oe_nf(QTestState *qts, int fd)
+{
+    int i;
+
+    s1(qts, fd, 'A');
+    {
+        char c = 'B';
+        g_assert_cmpint(send(fd, &c, 1, 0), ==, 1);
+    }
+    for (i = 0; i < 200; i++) {
+        rd(qts, SCR);
+        g_usleep(1000);
+    }
+}
+
+/* 1. device probe */
+static void test_device_probe(void)
+{
+    QTestState *qts = qtest_init("-machine k230");
+    uint32_t cpr = rd(qts, CPR);
+
+    g_assert_cmphex(cpr & 0x3, ==, 0x2);
+    g_assert_cmphex(cpr & (1 << 5), ==, (1 << 5));
+    g_assert_cmphex(cpr & (1 << 8), ==, (1 << 8));
+    g_assert_cmphex((cpr >> 16) & 0xff, ==, 0x2);
+    g_assert_cmphex(cpr & (1 << 4), ==, 0);
+    g_assert_cmphex(rd(qts, CTR), ==, 0x44570110);
+    g_assert_cmphex(rd(qts, LSR), ==, LSR_RESET);
+    g_assert_cmphex(rd(qts, USR), ==, USR_RESET);
+    g_assert_cmphex(iid(qts), ==, IIR_NONE);
+    g_assert_cmphex(rd(qts, IIR) & IIR_FF, ==, 0);
+    g_assert_cmphex(rd(qts, USR) & USR_BUSY, ==, 0);
+
+    qtest_writel(qts, R(IIR), FCR_FE);
+    g_assert_cmphex(rd(qts, IIR) & IIR_FF, ==, IIR_FF);
+    qtest_quit(qts);
+}
+
+/* 2. init & baud */
+static void test_init_and_baud(void)
+{
+    int fd;
+    QTestState *qts = qtest_init_with_serial("-machine k230", &fd);
+
+    qtest_writel(qts, R(LCR), LCR_DLAB);
+    qtest_writel(qts, R(THR), 0x55);
+    g_assert_cmphex(rd(qts, THR), ==, 0x55);
+    qtest_writel(qts, R(LCR), LCR_8N1);
+    g_assert_cmphex(rd(qts, THR), ==, 0x00);
+
+    qtest_writel(qts, R(IIR), FCR_FE | FCR_RT_F);
+    qtest_writel(qts, R(IER), IER_RX);
+
+    /* divisor=1 -> timeout=12800ns */
+    qtest_writel(qts, R(LCR), LCR_8N1 | LCR_DLAB);
+    qtest_writel(qts, R(THR), 1); qtest_writel(qts, R(IER), 0);
+    qtest_writel(qts, R(LCR), LCR_8N1);
+    s1(qts, fd, 'X');
+    qtest_clock_step(qts, 13000);
+    g_assert_cmphex(iid(qts), ==, IIR_TO);
+
+    /* divisor=100 -> timeout=1.28e6ns; 13000ns too short */
+    rd(qts, THR);
+    qtest_writel(qts, R(LCR), LCR_8N1 | LCR_DLAB);
+    qtest_writel(qts, R(THR), 100); qtest_writel(qts, R(IER), 0);
+    qtest_writel(qts, R(LCR), LCR_8N1);
+    s1(qts, fd, 'Y');
+    qtest_clock_step(qts, 13000);
+    g_assert_cmphex(iid(qts), !=, IIR_TO);
+    qtest_clock_step(qts, 1300000);
+    g_assert_cmphex(iid(qts), ==, IIR_TO);
+
+    close(fd); qtest_quit(qts);
+}
+
+/* 3. TX / RX datapath */
+static void test_tx_rx_datapath(void)
+{
+    int fd;
+    QTestState *qts = qtest_init_with_serial("-machine k230", &fd);
+
+    qtest_writel(qts, R(LCR), LCR_8N1);
+    g_assert_cmphex(rd(qts, LSR) & (LSR_THRE | LSR_TEMT),
+                    ==, LSR_THRE | LSR_TEMT);
+    qtest_writel(qts, R(THR), 'A');
+    g_assert_cmphex(rd(qts, LSR) & (LSR_THRE | LSR_TEMT),
+                    ==, LSR_THRE | LSR_TEMT);
+
+    /* external RX (FIFO mode) */
+    qtest_writel(qts, R(IIR), FCR_FE);
+    qtest_writel(qts, R(IER), IER_RX);
+    sn(qts, fd, "K230", 4);
+    for (int i = 0; i < 4; i++) {
+        if (i < 3) {
+            g_assert_cmphex(iid(qts), ==, IIR_RX);
+        }
+        g_assert_cmphex(rd(qts, THR), ==, "K230"[i]);
+    }
+    g_assert_cmphex(rd(qts, LSR) & LSR_DR, ==, 0);
+
+    /* loopback */
+    qtest_writel(qts, R(MCR), MCR_LB);
+    qtest_writel(qts, R(THR), 'L');
+    g_assert_cmphex(rd(qts, THR), ==, 'L');
+    g_assert_cmphex(rd(qts, LSR) & LSR_DR, ==, 0);
+
+    /* no loopback */
+    qtest_writel(qts, R(MCR), 0);
+    qtest_writel(qts, R(THR), 'Z');
+    g_assert_cmphex(rd(qts, LSR) & LSR_DR, ==, 0);
+
+    /* TFL / RFL */
+    qtest_writel(qts, R(MCR), MCR_LB);
+    qtest_writel(qts, R(IIR), FCR_FE | FCR_RR | FCR_XR);
+    qtest_writel(qts, R(THR), 'X'); qtest_writel(qts, R(THR), 'Y');
+    g_assert_cmphex(rd(qts, TFL), ==, 0);
+    g_assert_cmphex(rd(qts, RFL), ==, 2);
+
+    /* non-FIFO mode */
+    qtest_writel(qts, R(MCR), 0);
+    qtest_writel(qts, R(IIR), 0);
+    s1(qts, fd, 'N');
+    g_assert_cmphex(rd(qts, THR), ==, 'N');
+    g_assert_cmphex(rd(qts, LSR) & LSR_DR, ==, 0);
+
+    /* non-FIFO overrun */
+    int i;
+    s1(qts, fd, 'n');
+    g_assert_cmphex(rd(qts, LSR) & LSR_DR, ==, LSR_DR);
+    {
+        char c = 'o';
+        send(fd, &c, 1, 0);
+    }
+    for (i = 0; i < 200; i++) {
+        rd(qts, SCR);
+        g_usleep(1000);
+    }
+    g_assert_cmphex(rd(qts, LSR) & LSR_OE, ==, LSR_OE);
+
+    close(fd); qtest_quit(qts);
+}
+
+/* 4. THRE interrupt */
+static void test_thre_interrupt(void)
+{
+    QTestState *qts = qtest_init("-machine k230 "
+                                 "-chardev null,id=c0 -serial chardev:c0");
+    qtest_writel(qts, R(LCR), LCR_8N1);
+
+    qtest_writel(qts, R(THR), 'A');
+    g_assert_cmphex(iid(qts), ==, IIR_NONE);
+
+    qtest_writel(qts, R(IER), IER_TX);
+    g_assert_cmphex(iid(qts), ==, IIR_THR);
+
+    qtest_writel(qts, R(THR), 'B');
+    g_assert_cmphex(iid(qts), ==, IIR_THR);
+
+    g_assert_cmphex(iid(qts), ==, IIR_NONE);
+    qtest_quit(qts);
+}
+
+/* 5. RX interrupts: timeout & trigger level */
+static void test_rx_interrupts(void)
+{
+    int fd;
+    QTestState *qts = qtest_init_with_serial("-machine k230", &fd);
+
+    qtest_writel(qts, R(LCR), LCR_8N1);
+    qtest_writel(qts, R(IIR), FCR_FE | FCR_RT_F);
+    qtest_writel(qts, R(IER), IER_RX);
+
+    /* basic timeout */
+    s1(qts, fd, 'T');
+    qtest_clock_step(qts, 400000);
+    g_assert_cmphex(iid(qts), ==, IIR_TO);
+    g_assert_cmphex(rd(qts, THR), ==, 'T');
+    g_assert_cmphex(iid(qts), !=, IIR_TO);
+
+    /* timeout reset by new byte */
+    s1(qts, fd, 'A'); qtest_clock_step(qts, 200000);
+    s1(qts, fd, 'B');
+    qtest_clock_step(qts, 200000);
+    g_assert_cmphex(iid(qts), ==, IIR_NONE);
+    qtest_clock_step(qts, 200000);
+    g_assert_cmphex(iid(qts), ==, IIR_TO);
+    rd(qts, THR);
+    rd(qts, THR);
+
+    /* timeout rearmed by partial drain */
+    s1(qts, fd, 'X');
+    s1(qts, fd, 'Y');
+    qtest_clock_step(qts, 400000);
+    g_assert_cmphex(iid(qts), ==, IIR_TO);
+    g_assert_cmphex(rd(qts, THR), ==, 'X');
+    qtest_clock_step(qts, 200000);
+    g_assert_cmphex(iid(qts), !=, IIR_TO);
+    qtest_clock_step(qts, 250000);
+    g_assert_cmphex(iid(qts), ==, IIR_TO);
+    g_assert_cmphex(rd(qts, THR), ==, 'Y');
+
+    /* RX trigger level: RT=Q -> trigger at 8 bytes */
+    qtest_writel(qts, R(IIR), FCR_FE | FCR_RT_Q);
+    sn(qts, fd, "ABCDEFG", 7);
+    g_usleep(20000);
+    g_assert_cmphex(iid(qts), ==, IIR_NONE);
+    qtest_clock_step(qts, 400000);
+    g_assert_cmphex(iid(qts), ==, IIR_TO);
+    for (int i = 0; i < 7; i++) {
+        rd(qts, THR);
+    }
+
+    sn(qts, fd, "12345678", 8);
+    for (int i = 0; i < 1000; i++) {
+        if (iid(qts) == IIR_RX) {
+            break;
+        }
+        g_usleep(1000);
+    }
+    g_assert_cmphex(iid(qts), ==, IIR_RX);
+
+    close(fd); qtest_quit(qts);
+}
+
+/* 6. error interrupts & IIR priority */
+static void test_error_interrupts(void)
+{
+    int fd;
+    QTestState *qts = qtest_init_with_serial("-machine k230", &fd);
+
+    qtest_writel(qts, R(LCR), LCR_8N1);
+    qtest_writel(qts, R(IER), IER_LS);
+
+    /* OE -> IIR=0x6; LSR clears; ELCOLR=0: RBR clears; ELCOLR=1: RBR keeps */
+    oe_nf(qts, fd);
+    g_assert_cmphex(iid(qts), ==, IIR_LINE);
+    rd(qts, LSR);
+    g_assert_cmphex(iid(qts), !=, IIR_LINE);
+
+    oe_nf(qts, fd);
+    g_assert_cmphex(iid(qts), ==, IIR_LINE);
+    rd(qts, THR);
+    g_assert_cmphex(iid(qts), !=, IIR_LINE);
+
+    qtest_writel(qts, R(IER), IER_LS | IER_COLR);
+    oe_nf(qts, fd);
+    g_assert_cmphex(iid(qts), ==, IIR_LINE);
+    rd(qts, THR);
+    g_assert_cmphex(iid(qts), ==, IIR_LINE);
+    rd(qts, LSR);
+    g_assert_cmphex(iid(qts), !=, IIR_LINE);
+
+    /* IIR priority: RX > TX (loopback) */
+    qtest_writel(qts, R(IIR), FCR_FE);
+    qtest_writel(qts, R(MCR), MCR_LB);
+    qtest_writel(qts, R(IER), IER_TX | IER_RX);
+    qtest_writel(qts, R(THR), 'P');
+    g_assert_cmphex(iid(qts), ==, IIR_RX);
+    g_assert_cmphex(rd(qts, THR), ==, 'P');
+    g_assert_cmphex(iid(qts), ==, IIR_THR);
+    iid(qts);
+    g_assert_cmphex(iid(qts), ==, IIR_NONE);
+
+    /* OE in FIFO mode via loopback */
+    qtest_writel(qts, R(IER), IER_LS);
+    for (int i = 0; i < 32; i++) {
+        qtest_writel(qts, R(THR), 'a');
+    }
+    g_assert_cmphex(rd(qts, LSR) & LSR_OE, ==, 0);
+    qtest_writel(qts, R(THR), 'z');
+    g_assert_cmphex(iid(qts), ==, IIR_LINE);
+    g_assert_cmphex(rd(qts, LSR) & LSR_OE, ==, LSR_OE);
+
+    close(fd); qtest_quit(qts);
+}
+
+/* 7. USR & busy detect */
+static void test_busy_detect(void)
+{
+    int fd;
+    QTestState *qts = qtest_init_with_serial("-machine k230", &fd);
+
+    qtest_writel(qts, R(LCR), LCR_8N1);
+    qtest_writel(qts, R(IIR), FCR_FE);
+
+    g_assert_cmphex(rd(qts, USR) & 0x1e, ==, 0x06);
+
+    qtest_writel(qts, R(MCR), MCR_LB);
+    qtest_writel(qts, R(THR), 'A');
+    g_assert_cmphex(rd(qts, USR) & 0x08, ==, 0x08);
+    rd(qts, THR);
+    g_assert_cmphex(rd(qts, USR) & 0x08, ==, 0);
+    qtest_writel(qts, R(MCR), 0);
+
+    /* BUSY via RX & loopback */
+    g_assert_cmphex(rd(qts, USR) & USR_BUSY, ==, 0);
+    s1(qts, fd, 'Z');
+    g_assert_cmphex(rd(qts, USR) & USR_BUSY, ==, USR_BUSY);
+    rd(qts, THR);
+    g_assert_cmphex(rd(qts, USR) & USR_BUSY, ==, 0);
+
+    qtest_writel(qts, R(MCR), MCR_LB);
+    qtest_writel(qts, R(THR), 'L');
+    g_assert_cmphex(rd(qts, USR) & USR_BUSY, ==, USR_BUSY);
+    rd(qts, THR);
+    g_assert_cmphex(rd(qts, USR) & USR_BUSY, ==, 0);
+
+    /* busy-detect: LCR write rejected while BUSY=1 */
+    qtest_writel(qts, R(MCR), 0);
+    qtest_writel(qts, R(IIR), FCR_FE | FCR_RR | FCR_XR);
+    s1(qts, fd, 'B');
+    g_assert_cmphex(rd(qts, USR) & USR_BUSY, ==, USR_BUSY);
+    qtest_writel(qts, R(LCR), LCR_8N1 | LCR_DLAB);
+    g_assert_cmphex(rd(qts, LCR), ==, LCR_8N1);
+    g_assert_cmphex(iid(qts), ==, IIR_BUSY);
+    rd(qts, USR);
+    g_assert_cmphex(iid(qts), ==, IIR_NONE);
+    qtest_writel(qts, R(IIR), FCR_FE | FCR_RR);
+    g_assert_cmphex(rd(qts, USR) & USR_BUSY, ==, 0);
+    qtest_writel(qts, R(LCR), LCR_8N1 | LCR_DLAB);
+    g_assert_cmphex(rd(qts, LCR), ==, LCR_8N1 | LCR_DLAB);
+
+    close(fd); qtest_quit(qts);
+}
+
+/* 8. advanced features */
+static void test_advanced_features(void)
+{
+    QTestState *qts = qtest_init("-machine k230 "
+                                 "-chardev null,id=c0 -serial chardev:c0");
+
+    /* shadow: SRTS<->MCR.RTS, SBCR<->LCR.BC, SDMAM, SFE, SRT, STET, HTX */
+    qtest_writel(qts, R(SRTS), 1);
+    g_assert_cmphex(rd(qts, MCR) & MCR_RTS, ==, MCR_RTS);
+    qtest_writel(qts, R(MCR), 0); g_assert_cmphex(rd(qts, SRTS), ==, 0);
+    qtest_writel(qts, R(SBCR), 1);
+    g_assert_cmphex(rd(qts, LCR) & LCR_BC, ==, LCR_BC);
+    qtest_writel(qts, R(LCR), 0); g_assert_cmphex(rd(qts, SBCR), ==, 0);
+    qtest_writel(qts, R(SDMAM), 1); g_assert_cmphex(rd(qts, SDMAM), ==, 1);
+    qtest_writel(qts, R(SRT), 0x2); g_assert_cmphex(rd(qts, SRT), ==, 0x2);
+    qtest_writel(qts, R(STET), 0x3); g_assert_cmphex(rd(qts, STET), ==, 0x3);
+    qtest_writel(qts, R(SFE), 1); g_assert_cmphex(rd(qts, SFE), ==, 1);
+    g_assert_cmphex(rd(qts, IIR) & IIR_FF, ==, IIR_FF);
+    qtest_writel(qts, R(HTX), 1); g_assert_cmphex(rd(qts, HTX), ==, 1);
+    qtest_writel(qts, R(HTX), 0); g_assert_cmphex(rd(qts, HTX), ==, 0);
+
+    /* HTX halt TX */
+    qtest_writel(qts, R(LCR), LCR_8N1);
+    qtest_writel(qts, R(IIR), FCR_FE);
+    qtest_writel(qts, R(MCR), MCR_LB);
+
+    qtest_writel(qts, R(HTX), 1);
+    qtest_writel(qts, R(THR), 'H');
+    g_assert_cmphex(rd(qts, TFL), ==, 1);
+    g_assert_cmphex(rd(qts, RFL), ==, 0);
+
+    qtest_writel(qts, R(HTX), 0);
+    g_assert_cmphex(rd(qts, TFL), ==, 0);
+    g_assert_cmphex(rd(qts, RFL), ==, 1);
+    g_assert_cmphex(rd(qts, THR), ==, 'H');
+
+    /* SRR: RFR & UR */
+    qtest_writel(qts, R(THR), 'Z');
+    g_assert_cmphex(rd(qts, RFL), ==, 1);
+    g_assert_cmphex(rd(qts, LSR) & LSR_DR, ==, LSR_DR);
+    qtest_writel(qts, R(SRR), SRR_RFR);
+    g_assert_cmphex(rd(qts, RFL), ==, 0);
+    g_assert_cmphex(rd(qts, LSR) & LSR_DR, ==, 0);
+    g_assert_cmphex(rd(qts, SRR), ==, 0);
+    qtest_writel(qts, R(THR), 'Y');
+    qtest_writel(qts, R(SRR), SRR_UR);
+    g_assert_cmphex(rd(qts, LSR), ==, LSR_RESET);
+    g_assert_cmphex(iid(qts), ==, IIR_NONE);
+    g_assert_cmphex(rd(qts, RFL), ==, 0);
+
+    /* PTIME + TET programmable THRE */
+    qtest_writel(qts, R(LCR), LCR_8N1);
+    qtest_writel(qts, R(IIR), FCR_FE | FCR_TET_H);
+    qtest_writel(qts, R(IER), IER_TX | IER_PTIME);
+    qtest_writel(qts, R(THR), 'A');
+    g_assert_cmphex(rd(qts, LSR) & LSR_THRE, ==, LSR_THRE);
+    g_assert_cmphex(iid(qts), ==, IIR_THR);
+
+    qtest_quit(qts);
+}
+
+int main(int argc, char *argv[])
+{
+    g_test_init(&argc, &argv, NULL);
+    qtest_add_func("/k230-uart/device_probe",       test_device_probe);
+    qtest_add_func("/k230-uart/init_and_baud",      test_init_and_baud);
+    qtest_add_func("/k230-uart/tx_rx_datapath",     test_tx_rx_datapath);
+    qtest_add_func("/k230-uart/thre_interrupt",     test_thre_interrupt);
+    qtest_add_func("/k230-uart/rx_interrupts",      test_rx_interrupts);
+    qtest_add_func("/k230-uart/error_interrupts",   test_error_interrupts);
+    qtest_add_func("/k230-uart/busy_detect",        test_busy_detect);
+    qtest_add_func("/k230-uart/advanced_features",  test_advanced_features);
+    return g_test_run();
+}
diff --git a/tests/qtest/meson.build b/tests/qtest/meson.build
index 822e0bd286970339fe28127649feb131ce8a81b2..93246d9bf77206e9cebb9d8ade5801f4541d3b8d 100644
--- a/tests/qtest/meson.build
+++ b/tests/qtest/meson.build
@@ -294,7 +294,7 @@ qtests_riscv64 = ['riscv-csr-test'] + \
   (config_all_devices.has_key('CONFIG_IOMMU_TESTDEV') and
    config_all_devices.has_key('CONFIG_RISCV_IOMMU') ?
    ['iommu-riscv-test'] : []) + \
-  (config_all_devices.has_key('CONFIG_K230') ? ['k230-wdt-test'] : [])
+  (config_all_devices.has_key('CONFIG_K230') ? ['k230-wdt-test', 'k230-uart-test'] : [])
 
 qtests_hexagon = ['boot-serial-test']
 

---
base-commit: 30e8a06b64aa58a3990ba39cb5d09531e7d265e0
change-id: 20260721-k230-uart-rfc-955863a6db5d

Best regards,
-- 
zhenbaii <1640586082@qq.com>


