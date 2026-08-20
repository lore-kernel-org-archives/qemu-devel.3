Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7594CC5DF89
	for <qemu-devel@archiver.kernel.org>; Thu, 20 Aug 2026 02:51:28 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wwsqR-0001zc-68; Wed, 19 Aug 2026 22:49:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kylefoxaustin.github@gmail.com>)
 id 1wwspu-0001r0-Ks
 for qemu-devel@nongnu.org; Wed, 19 Aug 2026 22:48:59 -0400
Received: from mail-yx1-xb12c.google.com ([2607:f8b0:4864:20::b12c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <kylefoxaustin.github@gmail.com>)
 id 1wwspr-0000PM-Mb
 for qemu-devel@nongnu.org; Wed, 19 Aug 2026 22:48:58 -0400
Received: by mail-yx1-xb12c.google.com with SMTP id
 956f58d0204a3-66c70d1672cso2042138d50.0
 for <qemu-devel@nongnu.org>; Wed, 19 Aug 2026 19:48:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1787194134; x=1787798934; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=uLySbPfUe/6ycb7XxkslGbgojMHRka83kHXjdiHFdOU=;
 b=GU1zfrVuH1kam2eHm1sYCVI497JKq/L3qSsVknFtHmLPeAgXeWJlJM4W5WnYxV4r/I
 ub2nD2ptc9Pl5wr+ENXaB8PwN9qPmJxxPByUtmo7e51EpXTSttXzBqrWQwIx4hAgD6Df
 K8uE6AOuwjbr7LjIm58OvtAF1wo2bPUulroe7+PYJ60/WvfRdIGBEfBC0N08V1AGLl7U
 /f+7+mIulGfwX1s3rlYl1zdodVAxh1qSOcyvoygPZQCzKqET5zLXDXENnyyktJAbXAvW
 H/X/g0PkC7ItaGQRuMFAqVVEkRbfp8P95hymMajTHAWbZXX/LHSrKV6+3z4/2bFi4pLo
 1fQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787194134; x=1787798934;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=uLySbPfUe/6ycb7XxkslGbgojMHRka83kHXjdiHFdOU=;
 b=IPidNNK4yBclcNPdVeFaeaUc+KGw0kS/mhka+co5nzCQW3fzDQfu2I+IH3LodIWZh4
 0qfuG7Z306QXkbuYDnHM4fsPzCgzf7IN5nCZSZ4MnkZO2Kp/OnPIVauCg6i8QjViqAB6
 6qX8O4oy5nzsDyEuKUOaG8bPg3SwdYXVBOzx81SAE2jW0o0qqcHi9Y8Ws+XJDbNHPufu
 v3Y0RyR2ivwyZI+VbA4TZuoy7JLD7hMTj8Wj23w/qtfgHfHVNUdCH1JAjyZj4zyP03ab
 FJ6OXpOdM9gXp11OP+qFB1VKRIx+yiEj3dPwaSm8ayUCQYV3nKT1L81QFMLaqdbSVZ4h
 XBbw==
X-Gm-Message-State: AFuF++mKRZ7AecfF4E8cXc/DBci+v1lLrX/7zKv1rL4nDgRrBA/lhBhI
 JqLB6SKOeErSWWtCUWzS03BeGwcS/ybEswmruy17q0kf8bJ7SKaNkirRRoCDLw==
X-Gm-Gg: AR+sD137oOoqV3PAMQi+EIGVqw39bXNP3fOG/cOfJLIMMVe6Lz14ygEFW3h2BS8F6/I
 T2IizZNakMBcuImbXkl67B8D+qbfEKZD3wgiVXnl9E8TiA4exea8U5n/jVJEe6EFBF3PaoE+lEN
 eS8RdfCJV8QQgrMplTV6YeU5MToPTn4Tk/JHU2JdfkLXpqjtvgMIksgjk2rkX1F3yiI/BLAyUi5
 pLf8GHuFsdYe+oeAUUnU+OsiaMjb6jRx8t/9UwKruqdU11tGltAkIPbAJVuUyvJrMkSihkkNMb2
 Lqy9LntJL1nISI6dl2QZYhEP0znFZRDoGP+zdfPEpE+lU7A0DmJEAKueik+PDmLzntzJEgCs5aA
 vj+K2q6Q+PATMQxb7fvrQPmtQ8/+T7ZSPgRu0XkjctrjfnMAXQSI+1/Drjl2W5eUv0i6nf0vSuN
 0E+nTANO5jru0uCP5IFxCSZo9f51pSELOT57tqFG6v2g1W106xx39qC8UMEJ05fo8m7A9f43DYf
 JxpUO8kq1oiMOdNqaOYU/4DOWtXl4+jR0SWgzcGEiy5bbIgajoRJQ==
X-Received: by 2002:a53:bf0d:0:b0:667:7dae:8707 with SMTP id
 956f58d0204a3-66ccb5a56f1mr2558707d50.8.1787194134007; 
 Wed, 19 Aug 2026 19:48:54 -0700 (PDT)
Received: from skippy.localdomain (99-61-67-1.lightspeed.austtx.sbcglobal.net.
 [99.61.67.1]) by smtp.gmail.com with ESMTPSA id
 956f58d0204a3-66ccafd03basm1986454d50.1.2026.08.19.19.48.52
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 19 Aug 2026 19:48:52 -0700 (PDT)
From: Kyle Fox <kylefoxaustin.github@gmail.com>
To: qemu-devel@nongnu.org
Cc: Kyle Fox <kylefoxaustin.github@gmail.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 qemu-arm@nongnu.org (open list:i.MX31 (kzm))
Subject: [PATCH 05/16] hw/char: add i.MX LPUART
Date: Wed, 19 Aug 2026 21:48:23 -0500
Message-Id: <20260820024834.3286721-6-kylefoxaustin.github@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260820024834.3286721-1-kylefoxaustin.github@gmail.com>
References: <20260820024834.3286721-1-kylefoxaustin.github@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::b12c;
 envelope-from=kylefoxaustin.github@gmail.com; helo=mail-yx1-xb12c.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

The i.MX Low-Power UART. Models the register subset the Linux fsl-lpuart
driver and the SM firmware drive (BAUD/CTRL/STAT/DATA plus the TX/RX
FIFOs) as an interrupt- and poll-capable serial device. On this machine
LPUART1 is the Linux console (ttyLP0), LPUART2 the SM debug monitor and
LPUART3 the M7 console.

Signed-off-by: Kyle Fox <kylefoxaustin.github@gmail.com>
---
 hw/char/Kconfig              |   3 +
 hw/char/imx_lpuart.c         | 382 +++++++++++++++++++++++++++++++++++
 hw/char/meson.build          |   1 +
 hw/char/trace-events         |   3 +
 include/hw/char/imx_lpuart.h | 123 +++++++++++
 5 files changed, 512 insertions(+)
 create mode 100644 hw/char/imx_lpuart.c
 create mode 100644 include/hw/char/imx_lpuart.h

diff --git a/hw/char/Kconfig b/hw/char/Kconfig
index 020c0a84bb6..51b4c3e00ce 100644
--- a/hw/char/Kconfig
+++ b/hw/char/Kconfig
@@ -95,3 +95,6 @@ config IP_OCTAL_232
     bool
     default y
     depends on IPACK
+
+config IMX_LPUART
+    bool
diff --git a/hw/char/imx_lpuart.c b/hw/char/imx_lpuart.c
new file mode 100644
index 00000000000..714bc3e52a4
--- /dev/null
+++ b/hw/char/imx_lpuart.c
@@ -0,0 +1,382 @@
+/*
+ * NXP i.MX LPUART (Low-Power UART) device model
+ *
+ * Copyright (c) 2026, Kyle Fox
+ *
+ * SPDX-License-Identifier: GPL-2.0-or-later
+ *
+ * Modelled on hw/char/imx_serial.c for structural conventions but with
+ * the LPUART register set and semantics. TX bytes are pushed through the
+ * chardev backend synchronously; RX bytes are buffered one-deep and
+ * surface in DATA, with an interrupt raised when CTRL.RIE is set.
+ * FIFO depth is reported as 1; no DMA, no baud-rate timing, no flow
+ * control are modelled.
+ */
+
+#include "qemu/osdep.h"
+#include "qemu/log.h"
+#include "qemu/module.h"
+#include "hw/char/imx_lpuart.h"
+#include "hw/core/irq.h"
+#include "hw/core/qdev-properties.h"
+#include "hw/core/qdev-properties-system.h"
+#include "migration/vmstate.h"
+#include "trace.h"
+
+static void imx_lpuart_update_irq(IMXLPUARTState *s);
+
+static int imx_lpuart_post_load(void *opaque, int version_id)
+{
+    /* Recompute the IRQ line level from the restored register state. */
+    imx_lpuart_update_irq(opaque);
+    return 0;
+}
+
+static const VMStateDescription vmstate_imx_lpuart = {
+    .name = TYPE_IMX_LPUART,
+    .version_id = 1,
+    .minimum_version_id = 1,
+    .post_load = imx_lpuart_post_load,
+    .fields = (const VMStateField[]) {
+        VMSTATE_UINT32(baud, IMXLPUARTState),
+        VMSTATE_UINT32(stat, IMXLPUARTState),
+        VMSTATE_UINT32(ctrl, IMXLPUARTState),
+        VMSTATE_UINT32(match, IMXLPUARTState),
+        VMSTATE_UINT32(modir, IMXLPUARTState),
+        VMSTATE_UINT32(fifo, IMXLPUARTState),
+        VMSTATE_UINT32(water, IMXLPUARTState),
+        VMSTATE_UINT32(pincfg, IMXLPUARTState),
+        VMSTATE_UINT8(rx_byte, IMXLPUARTState),
+        VMSTATE_BOOL(rx_full, IMXLPUARTState),
+        VMSTATE_END_OF_LIST()
+    },
+};
+
+/* Recompute the IRQ line from STAT & CTRL interrupt-enable bits. */
+static void imx_lpuart_update_irq(IMXLPUARTState *s)
+{
+    bool level =
+        ((s->stat & LPUART_STAT_RDRF) && (s->ctrl & LPUART_CTRL_RIE)) ||
+        ((s->stat & LPUART_STAT_TDRE) && (s->ctrl & LPUART_CTRL_TIE)) ||
+        ((s->stat & LPUART_STAT_TC)   && (s->ctrl & LPUART_CTRL_TCIE)) ||
+        ((s->stat & LPUART_STAT_IDLE) && (s->ctrl & LPUART_CTRL_ILIE));
+
+    qemu_set_irq(s->irq, level);
+}
+
+static void imx_lpuart_reset(IMXLPUARTState *s)
+{
+    /*
+     * Power-on reset values per the i.MX LPUART chapter. STAT comes up
+     * with TDRE and TC set because the FIFO is empty.
+     */
+    s->baud   = 0x0F000004;     /* default OSR = 4 + SBR field */
+    s->stat   = LPUART_STAT_TDRE | LPUART_STAT_TC;
+    s->ctrl   = 0;
+    s->match  = 0;
+    s->modir  = 0;
+    s->fifo   = 0;
+    s->water  = 0;
+    s->pincfg = 0;
+    s->rx_byte = 0;
+    s->rx_full = false;
+}
+
+static void imx_lpuart_reset_at_boot_hold(Object *obj, ResetType type)
+{
+    IMXLPUARTState *s = IMX_LPUART(obj);
+
+    imx_lpuart_reset(s);
+    imx_lpuart_update_irq(s);
+}
+
+static uint64_t imx_lpuart_read(void *opaque, hwaddr offset, unsigned size)
+{
+    IMXLPUARTState *s = opaque;
+    uint32_t value = 0;
+    uint32_t c;
+
+    switch (offset) {
+    case LPUART_VERID:
+        value = LPUART_VERID_VALUE;
+        break;
+
+    case LPUART_PARAM:
+        /* TXFIFO and RXFIFO size fields both zero -> depth = 1. */
+        value = 0;
+        break;
+
+    case LPUART_GLOBAL:
+        value = 0;
+        break;
+
+    case LPUART_PINCFG:
+        value = s->pincfg;
+        break;
+
+    case LPUART_BAUD:
+        value = s->baud;
+        break;
+
+    case LPUART_STAT:
+        value = s->stat;
+        break;
+
+    case LPUART_CTRL:
+        value = s->ctrl;
+        break;
+
+    case LPUART_DATA:
+        if (s->rx_full) {
+            c = s->rx_byte;
+            s->rx_full = false;
+            s->stat &= ~LPUART_STAT_RDRF;
+            value = c & LPUART_DATA_MASK;
+            imx_lpuart_update_irq(s);
+            qemu_chr_fe_accept_input(&s->chr);
+        } else {
+            value = LPUART_DATA_RXEMPT;
+        }
+        break;
+
+    case LPUART_MATCH:
+        value = s->match;
+        break;
+
+    case LPUART_MODIR:
+        value = s->modir;
+        break;
+
+    case LPUART_FIFO:
+        /*
+         * Report the FIFO control bits the guest set, plus the read-only
+         * TXEMPT/RXEMPT status computed from our 1-deep model. The status
+         * bits must be derived fresh, never returned from s->fifo: the Linux
+         * driver read-modify-writes UARTFIFO during setup, so a stored RXEMPT
+         * would stick set and make its RX drain loop (while !(FIFO & RXEMPT))
+         * believe the RX FIFO is always empty - it would never read DATA, RDRF
+         * would never clear, and the RX interrupt would storm.
+         */
+        value = s->fifo & ~(LPUART_FIFO_TXEMPT | LPUART_FIFO_RXEMPT);
+        value |= LPUART_FIFO_TXEMPT;  /* we drain TX instantly */
+        if (!s->rx_full) {
+            value |= LPUART_FIFO_RXEMPT;
+        }
+        break;
+
+    case LPUART_WATER:
+        /*
+         * Reflect the current fifo state in the RX/TX count fields
+         * (bits[31:24] RXCOUNT, bits[15:8] TXCOUNT). U-Boot's
+         * _lpuart32_serial_tstc() polls (water >> 24) for incoming-
+         * char detection, so RXCOUNT must update when imx_lpuart_receive
+         * stashes a byte. We are 1-deep: 0 or 1 in either slot.
+         * Preserve the guest-written watermark bits unchanged.
+         */
+        value = (s->water & 0x00ff00ffu)
+              | ((uint32_t)(s->rx_full ? 1 : 0) << 24)
+              | 0u;  /* TXCOUNT always 0 - we drain TR writes instantly */
+        break;
+
+    default:
+        qemu_log_mask(LOG_GUEST_ERROR,
+                      "%s: bad read offset 0x%" HWADDR_PRIx "\n",
+                      __func__, offset);
+        break;
+    }
+
+    return value;
+}
+
+static void imx_lpuart_write(void *opaque, hwaddr offset,
+                             uint64_t value, unsigned size)
+{
+    IMXLPUARTState *s = opaque;
+    uint8_t ch;
+
+    switch (offset) {
+    case LPUART_VERID:
+    case LPUART_PARAM:
+        /* Read-only registers; silently ignore writes (HW behavior). */
+        break;
+
+    case LPUART_GLOBAL:
+        if (value & LPUART_GLOBAL_RST) {
+            imx_lpuart_reset(s);
+            imx_lpuart_update_irq(s);
+        }
+        break;
+
+    case LPUART_PINCFG:
+        s->pincfg = value;
+        break;
+
+    case LPUART_BAUD:
+        /*
+         * Baud-rate timing isn't modelled, but the driver reads back what
+         * it wrote. Preserve DMA-enable and other configuration bits.
+         */
+        s->baud = value;
+        trace_imx_lpuart_baud(s->baud);
+        break;
+
+    case LPUART_STAT:
+        /*
+         * STAT bits IDLE and OR are W1C; the rest are read-only status
+         * managed by the model.
+         */
+        s->stat &= ~(value & LPUART_STAT_W1C_MASK);
+        imx_lpuart_update_irq(s);
+        break;
+
+    case LPUART_CTRL:
+        s->ctrl = value;
+        imx_lpuart_update_irq(s);
+        break;
+
+    case LPUART_DATA:
+        ch = value & LPUART_DATA_MASK;
+        /*
+         * Always push the byte through the chardev backend, even if
+         * CTRL_TE is currently 0. Real silicon would queue or drop the
+         * byte until TE is enabled; in emulation we don't model that
+         * gating because some consumers (notably the Linux earlycon
+         * path under -kernel direct boot, which assumes firmware
+         * already set TE before the kernel runs) write to DATA without
+         * first enabling TE themselves. Without this, kernel console
+         * output vanishes silently and earlycon appears broken.
+         */
+        trace_imx_lpuart_tx(ch);
+        qemu_chr_fe_write_all(&s->chr, &ch, 1);
+        /*
+         * TDRE and TC are pinned high; the byte goes out instantly. A
+         * future model would clear them for one host tick, then set TC
+         * when the line goes idle.
+         */
+        s->stat |= LPUART_STAT_TDRE | LPUART_STAT_TC;
+        imx_lpuart_update_irq(s);
+        break;
+
+    case LPUART_MATCH:
+        s->match = value;
+        break;
+
+    case LPUART_MODIR:
+        s->modir = value;
+        break;
+
+    case LPUART_FIFO:
+        /*
+         * Store only the writable configuration bits. The read-only status
+         * bits (TXEMPT/RXEMPT/TXOF/RXUF) and the self-clearing flush commands
+         * (TXFLUSH/RXFLUSH) must NOT be latched: the driver read-modify-writes
+         * UARTFIFO, so latching RXEMPT would make it stick set and break the
+         * RX drain loop (see the FIFO read).
+         */
+        s->fifo = value & ~LPUART_FIFO_RO_MASK;
+        if (value & LPUART_FIFO_RXFLUSH) {
+            s->rx_full = false;
+            s->stat &= ~LPUART_STAT_RDRF;
+        }
+        imx_lpuart_update_irq(s);
+        break;
+
+    case LPUART_WATER:
+        s->water = value;
+        break;
+
+    default:
+        qemu_log_mask(LOG_GUEST_ERROR,
+                      "%s: bad write offset 0x%" HWADDR_PRIx
+                      " value 0x%" PRIx64 "\n",
+                      __func__, offset, value);
+        break;
+    }
+}
+
+static int imx_lpuart_can_receive(void *opaque)
+{
+    IMXLPUARTState *s = opaque;
+
+    return ((s->ctrl & LPUART_CTRL_RE) && !s->rx_full) ? 1 : 0;
+}
+
+static void imx_lpuart_receive(void *opaque, const uint8_t *buf, int size)
+{
+    IMXLPUARTState *s = opaque;
+
+    if (size <= 0 || s->rx_full) {
+        return;
+    }
+
+    s->rx_byte = buf[0];
+    s->rx_full = true;
+    trace_imx_lpuart_rx(s->rx_byte);
+    s->stat |= LPUART_STAT_RDRF;
+    imx_lpuart_update_irq(s);
+}
+
+static const MemoryRegionOps imx_lpuart_ops = {
+    .read = imx_lpuart_read,
+    .write = imx_lpuart_write,
+    .endianness = DEVICE_LITTLE_ENDIAN,
+    .impl = {
+        .min_access_size = 4,
+        .max_access_size = 4,
+    },
+    .valid = {
+        .min_access_size = 4,
+        .max_access_size = 4,
+    },
+};
+
+static void imx_lpuart_realize(DeviceState *dev, Error **errp)
+{
+    IMXLPUARTState *s = IMX_LPUART(dev);
+
+    qemu_chr_fe_set_handlers(&s->chr, imx_lpuart_can_receive,
+                             imx_lpuart_receive, NULL, NULL, s, NULL, true);
+}
+
+static void imx_lpuart_init(Object *obj)
+{
+    SysBusDevice *sbd = SYS_BUS_DEVICE(obj);
+    IMXLPUARTState *s = IMX_LPUART(obj);
+
+    memory_region_init_io(&s->iomem, obj, &imx_lpuart_ops, s,
+                          TYPE_IMX_LPUART, IMX_LPUART_REG_SIZE);
+    sysbus_init_mmio(sbd, &s->iomem);
+    sysbus_init_irq(sbd, &s->irq);
+}
+
+static const Property imx_lpuart_properties[] = {
+    DEFINE_PROP_CHR("chardev", IMXLPUARTState, chr),
+};
+
+static void imx_lpuart_class_init(ObjectClass *klass, const void *data)
+{
+    DeviceClass *dc = DEVICE_CLASS(klass);
+    ResettableClass *rc = RESETTABLE_CLASS(klass);
+
+    dc->realize = imx_lpuart_realize;
+    dc->vmsd = &vmstate_imx_lpuart;
+    rc->phases.hold = imx_lpuart_reset_at_boot_hold;
+    set_bit(DEVICE_CATEGORY_INPUT, dc->categories);
+    dc->desc = "NXP i.MX LPUART";
+    device_class_set_props(dc, imx_lpuart_properties);
+}
+
+static const TypeInfo imx_lpuart_info = {
+    .name           = TYPE_IMX_LPUART,
+    .parent         = TYPE_SYS_BUS_DEVICE,
+    .instance_size  = sizeof(IMXLPUARTState),
+    .instance_init  = imx_lpuart_init,
+    .class_init     = imx_lpuart_class_init,
+};
+
+static void imx_lpuart_register_types(void)
+{
+    type_register_static(&imx_lpuart_info);
+}
+
+type_init(imx_lpuart_register_types)
diff --git a/hw/char/meson.build b/hw/char/meson.build
index fc3d7ee506f..440142ae803 100644
--- a/hw/char/meson.build
+++ b/hw/char/meson.build
@@ -41,3 +41,4 @@ system_ss.add(when: 'CONFIG_GOLDFISH_TTY', if_true: files('goldfish_tty.c'))
 
 specific_ss.add(when: 'CONFIG_TERMINAL3270', if_true: files('terminal3270.c'))
 specific_ss.add(when: 'CONFIG_PSERIES', if_true: files('spapr_vty.c'))
+system_ss.add(when: 'CONFIG_IMX_LPUART', if_true: files('imx_lpuart.c'))
diff --git a/hw/char/trace-events b/hw/char/trace-events
index a3fcc772877..6d9b71961e5 100644
--- a/hw/char/trace-events
+++ b/hw/char/trace-events
@@ -141,3 +141,6 @@ stm32f2xx_usart_receive(char *id, uint8_t chr) " %s receiving '%c'"
 # riscv_htif.c
 htif_uart_write_to_host(uint8_t device, uint8_t cmd, uint64_t payload) "device: %u cmd: %02u payload: %016" PRIx64
 htif_uart_unknown_device_command(uint8_t device, uint8_t cmd, uint64_t payload) "device: %u cmd: %02u payload: %016" PRIx64
+imx_lpuart_tx(uint8_t ch) "tx 0x%02x"
+imx_lpuart_rx(uint8_t ch) "rx 0x%02x"
+imx_lpuart_baud(uint32_t baud) "baud <- 0x%08x"
diff --git a/include/hw/char/imx_lpuart.h b/include/hw/char/imx_lpuart.h
new file mode 100644
index 00000000000..a18809c432f
--- /dev/null
+++ b/include/hw/char/imx_lpuart.h
@@ -0,0 +1,123 @@
+/*
+ * NXP i.MX LPUART (Low-Power UART) device model
+ *
+ * Copyright (c) 2026, Kyle Fox
+ *
+ * SPDX-License-Identifier: GPL-2.0-or-later
+ *
+ * Models the LPUART IP found in i.MX 7ULP / 8ULP / 8QXP / 95 and other
+ * recent NXP SoCs. Register layout matches the
+ * "fsl,imx95-lpuart" / "fsl,imx8ulp-lpuart" / "fsl,imx7ulp-lpuart"
+ * compatible string in the Linux fsl_lpuart driver.
+ */
+
+#ifndef IMX_LPUART_H
+#define IMX_LPUART_H
+
+#include "hw/core/sysbus.h"
+#include "chardev/char-fe.h"
+#include "qom/object.h"
+
+#define TYPE_IMX_LPUART "imx.lpuart"
+OBJECT_DECLARE_SIMPLE_TYPE(IMXLPUARTState, IMX_LPUART)
+
+/* MMIO size of one LPUART instance (from the device tree). */
+#define IMX_LPUART_REG_SIZE     0x1000
+
+/*
+ * Register offsets. The first four 32-bit words (VERID/PARAM/GLOBAL/
+ * PINCFG) sit before the UART register block proper, which starts at
+ * BAUD = 0x10. The Linux driver compensates with sport->reg_off = 0x10
+ * on i.MX variants; the model exposes the absolute offsets directly.
+ */
+#define LPUART_VERID            0x00
+#define LPUART_PARAM            0x04
+#define LPUART_GLOBAL           0x08
+#define LPUART_PINCFG           0x0C
+#define LPUART_BAUD             0x10
+#define LPUART_STAT             0x14
+#define LPUART_CTRL             0x18
+#define LPUART_DATA             0x1C
+#define LPUART_MATCH            0x20
+#define LPUART_MODIR            0x24
+#define LPUART_FIFO             0x28
+#define LPUART_WATER            0x2C
+
+/* GLOBAL: write GLOBAL_RST to trigger a software reset of the IP. */
+#define LPUART_GLOBAL_RST       0x00000002
+
+/* STAT bits the model implements. */
+#define LPUART_STAT_TDRE        0x00800000  /* TX data register empty */
+#define LPUART_STAT_TC          0x00400000  /* TX complete */
+#define LPUART_STAT_RDRF        0x00200000  /* RX data register full */
+#define LPUART_STAT_IDLE        0x00100000  /* RX line idle */
+#define LPUART_STAT_OR          0x00080000  /* RX overrun */
+/* RW1C mask: writing 1 to these bits clears them. */
+#define LPUART_STAT_W1C_MASK    (LPUART_STAT_IDLE | LPUART_STAT_OR)
+
+/* CTRL bits the model implements. */
+#define LPUART_CTRL_TIE         0x00800000  /* TDRE IRQ enable */
+#define LPUART_CTRL_TCIE        0x00400000  /* TC IRQ enable */
+#define LPUART_CTRL_RIE         0x00200000  /* RDRF IRQ enable */
+#define LPUART_CTRL_ILIE        0x00100000  /* IDLE IRQ enable */
+#define LPUART_CTRL_TE          0x00080000  /* Transmitter enable */
+#define LPUART_CTRL_RE          0x00040000  /* Receiver enable */
+
+/* DATA: bits [7:0] carry the actual character; upper bits are status. */
+#define LPUART_DATA_MASK        0x000000FF
+#define LPUART_DATA_RXEMPT      0x00001000  /* RX buffer was empty */
+
+/*
+ * FIFO bits. TXEMPT/RXEMPT/TXOF/RXUF are read-only (status) and must never be
+ * latched from a guest write - the Linux driver read-modify-writes UARTFIFO,
+ * so a stored RXEMPT would stick and break its RX drain loop. TXFLUSH/RXFLUSH
+ * are write-1 self-clearing commands.
+ */
+#define LPUART_FIFO_TXEMPT      0x00800000
+#define LPUART_FIFO_RXEMPT      0x00400000
+#define LPUART_FIFO_TXOF        0x00020000  /* TX overflow (W1C) */
+#define LPUART_FIFO_RXUF        0x00010000  /* RX underflow (W1C) */
+#define LPUART_FIFO_TXFLUSH     0x00008000  /* self-clearing */
+#define LPUART_FIFO_RXFLUSH     0x00004000  /* self-clearing */
+#define LPUART_FIFO_RO_MASK     (LPUART_FIFO_TXEMPT | LPUART_FIFO_RXEMPT | \
+                                 LPUART_FIFO_TXOF | LPUART_FIFO_RXUF | \
+                                 LPUART_FIFO_TXFLUSH | LPUART_FIFO_RXFLUSH)
+
+/*
+ * PARAM: FIFO depth is encoded as 1 << (field + 1) when nonzero, else 1.
+ * The model implements a single-byte TX path and a 1-deep RX buffer, so
+ * both TX and RX fields read back zero (depth = 1).
+ */
+#define LPUART_PARAM_TXFIFO_SHIFT   0
+#define LPUART_PARAM_RXFIFO_SHIFT   8
+
+/*
+ * VERID: report an i.MX 95-style version. The Linux driver
+ * does not branch on this field for any of the imx*ulp variants, so the
+ * exact value is not load-bearing.
+ */
+#define LPUART_VERID_VALUE      0x04040007
+
+struct IMXLPUARTState {
+    SysBusDevice    parent_obj;
+
+    MemoryRegion    iomem;
+    CharFrontend    chr;
+    qemu_irq        irq;
+
+    /* Register state. Only the writable bits are tracked. */
+    uint32_t        baud;
+    uint32_t        stat;
+    uint32_t        ctrl;
+    uint32_t        match;
+    uint32_t        modir;
+    uint32_t        fifo;
+    uint32_t        water;
+    uint32_t        pincfg;
+
+    /* Single-byte RX buffer (1-deep). */
+    uint8_t         rx_byte;
+    bool            rx_full;
+};
+
+#endif /* IMX_LPUART_H */
-- 
2.34.1


