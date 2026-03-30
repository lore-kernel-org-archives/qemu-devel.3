Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A163ECD13DE
	for <qemu-devel@archiver.kernel.org>; Thu, 30 Apr 2026 16:05:35 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wITsY-0001qt-EV; Thu, 30 Apr 2026 12:04:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <outgoing@sr.ht>)
 id 1wITrH-0007Vt-B4; Thu, 30 Apr 2026 12:03:24 -0400
Received: from mail-a.sr.ht ([46.23.81.152])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <outgoing@sr.ht>)
 id 1wITr9-00078I-ED; Thu, 30 Apr 2026 12:03:21 -0400
DKIM-Signature: a=rsa-sha256; bh=YhDv+BeemcjcIdD2m5tEK+3Y1VpySq+/sAQO/AJLmhg=; 
 c=simple/simple; d=git.sr.ht;
 h=From:Date:Subject:Reply-to:In-Reply-To:To:Cc; q=dns/txt; s=20240113;
 t=1777564988; v=1;
 b=oEPx33kVhirBmNivuEnZvlwWXHZy6BQvfpfMZe2qsZfFFXMh9To0ifwH1gWefCJ1kFDUfNF5
 UFKNrKPGQyHbbqzM6wTc3frTJIItCZ/1mbP94hrius5Rp8Ik/GgZKKD5UgtU8I40wjjL9TjPXxX
 thRgaGquPwIvHoU41QUiCYJ7GuP0vUqB29ABDfsENRpssUr7GVXn11IqB6jaXnVAjI4F27ZJvTU
 rFYpu9jOs/C5WDmtsn6q0AgjRk3MOxouKiU/HcvawSITu/81d1XvYmgvCR7CKVrfmR61QY2F9Kp
 zm2cSQb2PpJB67NbiQrfxHcLz06pNBkJCKQ7KA8tWsWzQ==
Received: from git.sr.ht (unknown [46.23.81.155])
 by mail-a.sr.ht (Postfix) with ESMTPSA id D53B120C12;
 Thu, 30 Apr 2026 16:03:08 +0000 (UTC)
From: ~lexbaileylowrisc <lexbaileylowrisc@git.sr.ht>
Date: Mon, 30 Mar 2026 15:34:56 +0100
Subject: [PATCH qemu v4 1/9] Rename ibex_uart to ot_uart
Message-ID: <177756498815.8917.12449488721849651971-1@git.sr.ht>
X-Mailer: git.sr.ht
In-Reply-To: <177756498815.8917.12449488721849651971-0@git.sr.ht>
To: qemu-riscv@nongnu.org, Alistair Francis <Alistair.Francis@wdc.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>,
 =?utf-8?q?Marc-Andr=C3=A9?= Lureau <marcandre.lureau@redhat.com>,
 Palmer Dabbelt <palmer@dabbelt.com>, Weiwei Li <liwei1518@gmail.com>,
 Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>,
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>,
 Chao Liu <chao.liu.zevorn@gmail.com>, qemu-devel@nongnu.org,
 Amit Kumar-Hermosillo <amitkh@google.com>,
 nabihestefan <nabihestefan@google.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
Received-SPF: pass client-ip=46.23.81.152; envelope-from=outgoing@sr.ht;
 helo=mail-a.sr.ht
X-Spam_score_int: 17
X-Spam_score: 1.7
X-Spam_bar: +
X-Spam_report: (1.7 / 5.0 requ) BAYES_00=-1.9, DATE_IN_PAST_96_XX=3.405,
 DKIM_INVALID=0.1, DKIM_SIGNED=0.1, SPF_HELO_NONE=0.001,
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
Reply-To: ~lexbaileylowrisc <lex.bailey@lowrisc.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

From: Lex Bailey <lex.bailey@lowrisc.org>

This UART device is not specifically tied to ibex. Currently it is only used =
in the
opentitan machine, which does use an ibex core, but an opentitan machine with=
 a
different core would still use this UART, hence it should be considered a par=
t of
opentitan more than a part of ibex.

Signed-off-by: Lex Bailey <lex.bailey@lowrisc.org>
Reviewed-by: Alistair Francis <alistair.francis@wdc.com>
---
 MAINTAINERS                                |   1 +
 hw/char/Kconfig                            |   3 +
 hw/char/meson.build                        |   2 +-
 hw/char/{ibex_uart.c =3D> ot_uart.c}         | 177 ++++++++++-----------
 hw/riscv/Kconfig                           |   1 +
 hw/riscv/opentitan.c                       |   2 +-
 include/hw/char/{ibex_uart.h =3D> ot_uart.h} |  20 +--
 include/hw/riscv/opentitan.h               |   4 +-
 8 files changed, 107 insertions(+), 103 deletions(-)
 rename hw/char/{ibex_uart.c =3D> ot_uart.c} (75%)
 rename include/hw/char/{ibex_uart.h =3D> ot_uart.h} (84%)

diff --git a/MAINTAINERS b/MAINTAINERS
index e41f0eb92c..42abaa1ee3 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -1727,6 +1727,7 @@ L: qemu-riscv@nongnu.org
 S: Supported
 F: hw/riscv/opentitan.c
 F: hw/*/ibex_*.c
+F: hw/*/ot_*.c
 F: include/hw/riscv/opentitan.h
 F: include/hw/*/ibex_*.h
 F: target/riscv/insn_trans/trans_xthead.c.inc
diff --git a/hw/char/Kconfig b/hw/char/Kconfig
index 020c0a84bb..23ddab6b78 100644
--- a/hw/char/Kconfig
+++ b/hw/char/Kconfig
@@ -95,3 +95,6 @@ config IP_OCTAL_232
     bool
     default y
     depends on IPACK
+
+config OT_UART
+    bool
diff --git a/hw/char/meson.build b/hw/char/meson.build
index fc3d7ee506..056153085f 100644
--- a/hw/char/meson.build
+++ b/hw/char/meson.build
@@ -2,7 +2,7 @@ system_ss.add(when: 'CONFIG_CADENCE', if_true: files('cadence=
_uart.c'))
 system_ss.add(when: 'CONFIG_CMSDK_APB_UART', if_true: files('cmsdk-apb-uart.=
c'))
 system_ss.add(when: 'CONFIG_ESCC', if_true: files('escc.c'))
 system_ss.add(when: 'CONFIG_GRLIB', if_true: files('grlib_apbuart.c'))
-system_ss.add(when: 'CONFIG_IBEX', if_true: files('ibex_uart.c'))
+system_ss.add(when: 'CONFIG_OT_UART', if_true: files('ot_uart.c'))
 system_ss.add(when: 'CONFIG_IMX', if_true: files('imx_serial.c'))
 system_ss.add(when: 'CONFIG_IP_OCTAL_232', if_true: files('ipoctal232.c'))
 system_ss.add(when: 'CONFIG_ISA_BUS', if_true: files('parallel-isa.c'))
diff --git a/hw/char/ibex_uart.c b/hw/char/ot_uart.c
similarity index 75%
rename from hw/char/ibex_uart.c
rename to hw/char/ot_uart.c
index 26ed1aea14..b3eb619641 100644
--- a/hw/char/ibex_uart.c
+++ b/hw/char/ot_uart.c
@@ -1,5 +1,5 @@
 /*
- * QEMU lowRISC Ibex UART device
+ * QEMU OpenTitan UART device
  *
  * Copyright (c) 2020 Western Digital
  *
@@ -26,7 +26,7 @@
  */
=20
 #include "qemu/osdep.h"
-#include "hw/char/ibex_uart.h"
+#include "hw/char/ot_uart.h"
 #include "hw/core/irq.h"
 #include "hw/core/qdev-clock.h"
 #include "hw/core/qdev-properties.h"
@@ -74,7 +74,7 @@ REG32(OVRD, 0x28)
 REG32(VAL, 0x2C)
 REG32(TIMEOUT_CTRL, 0x30)
=20
-static void ibex_uart_update_irqs(IbexUartState *s)
+static void ot_uart_update_irqs(OtUARTState *s)
 {
     if (s->uart_intr_state & s->uart_intr_enable & R_INTR_STATE_TX_WATERMARK=
_MASK) {
         qemu_set_irq(s->tx_watermark, 1);
@@ -101,9 +101,9 @@ static void ibex_uart_update_irqs(IbexUartState *s)
     }
 }
=20
-static int ibex_uart_can_receive(void *opaque)
+static int ot_uart_can_receive(void *opaque)
 {
-    IbexUartState *s =3D opaque;
+    OtUARTState *s =3D opaque;
=20
     if ((s->uart_ctrl & R_CTRL_RX_ENABLE_MASK)
            && !(s->uart_status & R_STATUS_RXFULL_MASK)) {
@@ -113,9 +113,9 @@ static int ibex_uart_can_receive(void *opaque)
     return 0;
 }
=20
-static void ibex_uart_receive(void *opaque, const uint8_t *buf, int size)
+static void ot_uart_receive(void *opaque, const uint8_t *buf, int size)
 {
-    IbexUartState *s =3D opaque;
+    OtUARTState *s =3D opaque;
     uint8_t rx_fifo_level =3D (s->uart_fifo_ctrl & R_FIFO_CTRL_RXILVL_MASK)
                             >> R_FIFO_CTRL_RXILVL_SHIFT;
=20
@@ -133,13 +133,13 @@ static void ibex_uart_receive(void *opaque, const uint8=
_t *buf, int size)
         s->uart_intr_state |=3D R_INTR_STATE_RX_WATERMARK_MASK;
     }
=20
-    ibex_uart_update_irqs(s);
+    ot_uart_update_irqs(s);
 }
=20
-static gboolean ibex_uart_xmit(void *do_not_use, GIOCondition cond,
-                               void *opaque)
+static gboolean ot_uart_xmit(void *do_not_use, GIOCondition cond,
+                             void *opaque)
 {
-    IbexUartState *s =3D opaque;
+    OtUARTState *s =3D opaque;
     uint8_t tx_fifo_level =3D (s->uart_fifo_ctrl & R_FIFO_CTRL_TXILVL_MASK)
                             >> R_FIFO_CTRL_TXILVL_SHIFT;
     int ret;
@@ -155,7 +155,7 @@ static gboolean ibex_uart_xmit(void *do_not_use, GIOCondi=
tion cond,
         s->uart_status |=3D R_STATUS_TXEMPTY_MASK;
         s->uart_intr_state |=3D R_INTR_STATE_TX_EMPTY_MASK;
         s->uart_intr_state &=3D ~R_INTR_STATE_TX_WATERMARK_MASK;
-        ibex_uart_update_irqs(s);
+        ot_uart_update_irqs(s);
         return G_SOURCE_REMOVE;
     }
=20
@@ -168,7 +168,7 @@ static gboolean ibex_uart_xmit(void *do_not_use, GIOCondi=
tion cond,
=20
     if (s->tx_level) {
         guint r =3D qemu_chr_fe_add_watch(&s->chr, G_IO_OUT | G_IO_HUP,
-                                        ibex_uart_xmit, s);
+                                        ot_uart_xmit, s);
         if (!r) {
             s->tx_level =3D 0;
             return G_SOURCE_REMOVE;
@@ -176,7 +176,7 @@ static gboolean ibex_uart_xmit(void *do_not_use, GIOCondi=
tion cond,
     }
=20
     /* Clear the TX Full bit */
-    if (s->tx_level !=3D IBEX_UART_TX_FIFO_SIZE) {
+    if (s->tx_level !=3D OT_UART_TX_FIFO_SIZE) {
         s->uart_status &=3D ~R_STATUS_TXFULL_MASK;
     }
=20
@@ -191,20 +191,20 @@ static gboolean ibex_uart_xmit(void *do_not_use, GIOCon=
dition cond,
         s->uart_intr_state |=3D R_INTR_STATE_TX_EMPTY_MASK;
     }
=20
-    ibex_uart_update_irqs(s);
+    ot_uart_update_irqs(s);
     return G_SOURCE_REMOVE;
 }
=20
-static void uart_write_tx_fifo(IbexUartState *s, const uint8_t *buf,
+static void uart_write_tx_fifo(OtUARTState *s, const uint8_t *buf,
                                int size)
 {
     uint64_t current_time =3D qemu_clock_get_ns(QEMU_CLOCK_VIRTUAL);
     uint8_t tx_fifo_level =3D (s->uart_fifo_ctrl & R_FIFO_CTRL_TXILVL_MASK)
                             >> R_FIFO_CTRL_TXILVL_SHIFT;
=20
-    if (size > IBEX_UART_TX_FIFO_SIZE - s->tx_level) {
-        size =3D IBEX_UART_TX_FIFO_SIZE - s->tx_level;
-        qemu_log_mask(LOG_GUEST_ERROR, "ibex_uart: TX FIFO overflow");
+    if (size > OT_UART_TX_FIFO_SIZE - s->tx_level) {
+        size =3D OT_UART_TX_FIFO_SIZE - s->tx_level;
+        qemu_log_mask(LOG_GUEST_ERROR, "ot_uart: TX FIFO overflow");
     }
=20
     memcpy(s->tx_fifo + s->tx_level, buf, size);
@@ -216,10 +216,10 @@ static void uart_write_tx_fifo(IbexUartState *s, const =
uint8_t *buf,
=20
     if (s->tx_level >=3D tx_fifo_level) {
         s->uart_intr_state |=3D R_INTR_STATE_TX_WATERMARK_MASK;
-        ibex_uart_update_irqs(s);
+        ot_uart_update_irqs(s);
     }
=20
-    if (s->tx_level =3D=3D IBEX_UART_TX_FIFO_SIZE) {
+    if (s->tx_level =3D=3D OT_UART_TX_FIFO_SIZE) {
         s->uart_status |=3D R_STATUS_TXFULL_MASK;
     }
=20
@@ -227,9 +227,9 @@ static void uart_write_tx_fifo(IbexUartState *s, const ui=
nt8_t *buf,
               (s->char_tx_time * 4));
 }
=20
-static void ibex_uart_reset(DeviceState *dev)
+static void ot_uart_reset(DeviceState *dev)
 {
-    IbexUartState *s =3D IBEX_UART(dev);
+    OtUARTState *s =3D OT_UART(dev);
=20
     s->uart_intr_state =3D 0x00000000;
     s->uart_intr_state =3D 0x00000000;
@@ -248,10 +248,10 @@ static void ibex_uart_reset(DeviceState *dev)
=20
     s->char_tx_time =3D (NANOSECONDS_PER_SECOND / 230400) * 10;
=20
-    ibex_uart_update_irqs(s);
+    ot_uart_update_irqs(s);
 }
=20
-static uint64_t ibex_uart_get_baud(IbexUartState *s)
+static uint64_t ot_uart_get_baud(OtUARTState *s)
 {
     uint64_t baud;
=20
@@ -262,10 +262,9 @@ static uint64_t ibex_uart_get_baud(IbexUartState *s)
     return baud;
 }
=20
-static uint64_t ibex_uart_read(void *opaque, hwaddr addr,
-                                       unsigned int size)
+static uint64_t ot_uart_read(void *opaque, hwaddr addr, unsigned int size)
 {
-    IbexUartState *s =3D opaque;
+    OtUARTState *s =3D opaque;
     uint64_t retvalue =3D 0;
=20
     switch (addr >> 2) {
@@ -342,25 +341,25 @@ static uint64_t ibex_uart_read(void *opaque, hwaddr add=
r,
     return retvalue;
 }
=20
-static void ibex_uart_write(void *opaque, hwaddr addr,
-                                  uint64_t val64, unsigned int size)
+static void ot_uart_write(void *opaque, hwaddr addr, uint64_t val64,
+                          unsigned int size)
 {
-    IbexUartState *s =3D opaque;
+    OtUARTState *s =3D opaque;
     uint32_t value =3D val64;
=20
     switch (addr >> 2) {
     case R_INTR_STATE:
         /* Write 1 clear */
         s->uart_intr_state &=3D ~value;
-        ibex_uart_update_irqs(s);
+        ot_uart_update_irqs(s);
         break;
     case R_INTR_ENABLE:
         s->uart_intr_enable =3D value;
-        ibex_uart_update_irqs(s);
+        ot_uart_update_irqs(s);
         break;
     case R_INTR_TEST:
         s->uart_intr_state |=3D value;
-        ibex_uart_update_irqs(s);
+        ot_uart_update_irqs(s);
         break;
=20
     case R_CTRL:
@@ -393,7 +392,7 @@ static void ibex_uart_write(void *opaque, hwaddr addr,
                           "%s: UART_CTRL_RXBLVL is not supported\n", __func_=
_);
         }
         if (value & R_CTRL_NCO_MASK) {
-            uint64_t baud =3D ibex_uart_get_baud(s);
+            uint64_t baud =3D ot_uart_get_baud(s);
=20
             s->char_tx_time =3D (NANOSECONDS_PER_SECOND / baud) * 10;
         }
@@ -448,122 +447,122 @@ static void ibex_uart_write(void *opaque, hwaddr addr,
     }
 }
=20
-static void ibex_uart_clk_update(void *opaque, ClockEvent event)
+static void ot_uart_clk_update(void *opaque, ClockEvent event)
 {
-    IbexUartState *s =3D opaque;
+    OtUARTState *s =3D opaque;
=20
     /* recompute uart's speed on clock change */
-    uint64_t baud =3D ibex_uart_get_baud(s);
+    uint64_t baud =3D ot_uart_get_baud(s);
=20
     s->char_tx_time =3D (NANOSECONDS_PER_SECOND / baud) * 10;
 }
=20
 static void fifo_trigger_update(void *opaque)
 {
-    IbexUartState *s =3D opaque;
+    OtUARTState *s =3D opaque;
=20
     if (s->uart_ctrl & R_CTRL_TX_ENABLE_MASK) {
-        ibex_uart_xmit(NULL, G_IO_OUT, s);
+        ot_uart_xmit(NULL, G_IO_OUT, s);
     }
 }
=20
-static const MemoryRegionOps ibex_uart_ops =3D {
-    .read =3D ibex_uart_read,
-    .write =3D ibex_uart_write,
+static const MemoryRegionOps ot_uart_ops =3D {
+    .read =3D ot_uart_read,
+    .write =3D ot_uart_write,
     .endianness =3D DEVICE_LITTLE_ENDIAN,
     .impl.min_access_size =3D 4,
     .impl.max_access_size =3D 4,
 };
=20
-static int ibex_uart_post_load(void *opaque, int version_id)
+static int ot_uart_post_load(void *opaque, int version_id)
 {
-    IbexUartState *s =3D opaque;
+    OtUARTState *s =3D opaque;
=20
-    ibex_uart_update_irqs(s);
+    ot_uart_update_irqs(s);
     return 0;
 }
=20
-static const VMStateDescription vmstate_ibex_uart =3D {
-    .name =3D TYPE_IBEX_UART,
+static const VMStateDescription vmstate_ot_uart =3D {
+    .name =3D TYPE_OT_UART,
     .version_id =3D 1,
     .minimum_version_id =3D 1,
-    .post_load =3D ibex_uart_post_load,
+    .post_load =3D ot_uart_post_load,
     .fields =3D (const VMStateField[]) {
-        VMSTATE_UINT8_ARRAY(tx_fifo, IbexUartState,
-                            IBEX_UART_TX_FIFO_SIZE),
-        VMSTATE_UINT32(tx_level, IbexUartState),
-        VMSTATE_UINT64(char_tx_time, IbexUartState),
-        VMSTATE_TIMER_PTR(fifo_trigger_handle, IbexUartState),
-        VMSTATE_UINT32(uart_intr_state, IbexUartState),
-        VMSTATE_UINT32(uart_intr_enable, IbexUartState),
-        VMSTATE_UINT32(uart_ctrl, IbexUartState),
-        VMSTATE_UINT32(uart_status, IbexUartState),
-        VMSTATE_UINT32(uart_rdata, IbexUartState),
-        VMSTATE_UINT32(uart_fifo_ctrl, IbexUartState),
-        VMSTATE_UINT32(uart_fifo_status, IbexUartState),
-        VMSTATE_UINT32(uart_ovrd, IbexUartState),
-        VMSTATE_UINT32(uart_val, IbexUartState),
-        VMSTATE_UINT32(uart_timeout_ctrl, IbexUartState),
+        VMSTATE_UINT8_ARRAY(tx_fifo, OtUARTState,
+                            OT_UART_TX_FIFO_SIZE),
+        VMSTATE_UINT32(tx_level, OtUARTState),
+        VMSTATE_UINT64(char_tx_time, OtUARTState),
+        VMSTATE_TIMER_PTR(fifo_trigger_handle, OtUARTState),
+        VMSTATE_UINT32(uart_intr_state, OtUARTState),
+        VMSTATE_UINT32(uart_intr_enable, OtUARTState),
+        VMSTATE_UINT32(uart_ctrl, OtUARTState),
+        VMSTATE_UINT32(uart_status, OtUARTState),
+        VMSTATE_UINT32(uart_rdata, OtUARTState),
+        VMSTATE_UINT32(uart_fifo_ctrl, OtUARTState),
+        VMSTATE_UINT32(uart_fifo_status, OtUARTState),
+        VMSTATE_UINT32(uart_ovrd, OtUARTState),
+        VMSTATE_UINT32(uart_val, OtUARTState),
+        VMSTATE_UINT32(uart_timeout_ctrl, OtUARTState),
         VMSTATE_END_OF_LIST()
     }
 };
=20
-static const Property ibex_uart_properties[] =3D {
-    DEFINE_PROP_CHR("chardev", IbexUartState, chr),
+static const Property ot_uart_properties[] =3D {
+    DEFINE_PROP_CHR("chardev", OtUARTState, chr),
 };
=20
-static void ibex_uart_init(Object *obj)
+static void ot_uart_init(Object *obj)
 {
-    IbexUartState *s =3D IBEX_UART(obj);
+    OtUARTState *s =3D OT_UART(obj);
=20
     s->f_clk =3D qdev_init_clock_in(DEVICE(obj), "f_clock",
-                                  ibex_uart_clk_update, s, ClockUpdate);
-    clock_set_hz(s->f_clk, IBEX_UART_CLOCK);
+                                  ot_uart_clk_update, s, ClockUpdate);
+    clock_set_hz(s->f_clk, OT_UART_CLOCK);
=20
     sysbus_init_irq(SYS_BUS_DEVICE(obj), &s->tx_watermark);
     sysbus_init_irq(SYS_BUS_DEVICE(obj), &s->rx_watermark);
     sysbus_init_irq(SYS_BUS_DEVICE(obj), &s->tx_empty);
     sysbus_init_irq(SYS_BUS_DEVICE(obj), &s->rx_overflow);
=20
-    memory_region_init_io(&s->mmio, obj, &ibex_uart_ops, s,
-                          TYPE_IBEX_UART, 0x400);
+    memory_region_init_io(&s->mmio, obj, &ot_uart_ops, s,
+                          TYPE_OT_UART, 0x400);
     sysbus_init_mmio(SYS_BUS_DEVICE(obj), &s->mmio);
 }
=20
-static void ibex_uart_realize(DeviceState *dev, Error **errp)
+static void ot_uart_realize(DeviceState *dev, Error **errp)
 {
-    IbexUartState *s =3D IBEX_UART(dev);
+    OtUARTState *s =3D OT_UART(dev);
=20
     s->fifo_trigger_handle =3D timer_new_ns(QEMU_CLOCK_VIRTUAL,
                                           fifo_trigger_update, s);
=20
-    qemu_chr_fe_set_handlers(&s->chr, ibex_uart_can_receive,
-                             ibex_uart_receive, NULL, NULL,
+    qemu_chr_fe_set_handlers(&s->chr, ot_uart_can_receive,
+                             ot_uart_receive, NULL, NULL,
                              s, NULL, true);
 }
=20
-static void ibex_uart_class_init(ObjectClass *klass, const void *data)
+static void ot_uart_class_init(ObjectClass *klass, const void *data)
 {
     DeviceClass *dc =3D DEVICE_CLASS(klass);
=20
-    device_class_set_legacy_reset(dc, ibex_uart_reset);
-    dc->realize =3D ibex_uart_realize;
-    dc->vmsd =3D &vmstate_ibex_uart;
-    device_class_set_props(dc, ibex_uart_properties);
+    device_class_set_legacy_reset(dc, ot_uart_reset);
+    dc->realize =3D ot_uart_realize;
+    dc->vmsd =3D &vmstate_ot_uart;
+    device_class_set_props(dc, ot_uart_properties);
     set_bit(DEVICE_CATEGORY_INPUT, dc->categories);
 }
=20
-static const TypeInfo ibex_uart_info =3D {
-    .name          =3D TYPE_IBEX_UART,
+static const TypeInfo ot_uart_info =3D {
+    .name          =3D TYPE_OT_UART,
     .parent        =3D TYPE_SYS_BUS_DEVICE,
-    .instance_size =3D sizeof(IbexUartState),
-    .instance_init =3D ibex_uart_init,
-    .class_init    =3D ibex_uart_class_init,
+    .instance_size =3D sizeof(OtUARTState),
+    .instance_init =3D ot_uart_init,
+    .class_init    =3D ot_uart_class_init,
 };
=20
-static void ibex_uart_register_types(void)
+static void ot_uart_register_types(void)
 {
-    type_register_static(&ibex_uart_info);
+    type_register_static(&ot_uart_info);
 }
=20
-type_init(ibex_uart_register_types)
+type_init(ot_uart_register_types)
diff --git a/hw/riscv/Kconfig b/hw/riscv/Kconfig
index 0222c93f87..cb4bb5f442 100644
--- a/hw/riscv/Kconfig
+++ b/hw/riscv/Kconfig
@@ -38,6 +38,7 @@ config OPENTITAN
     default y
     depends on RISCV32
     select IBEX
+    select OT_UART
     select SIFIVE_PLIC
     select UNIMP
=20
diff --git a/hw/riscv/opentitan.c b/hw/riscv/opentitan.c
index 309125e854..97c33d1b53 100644
--- a/hw/riscv/opentitan.c
+++ b/hw/riscv/opentitan.c
@@ -132,7 +132,7 @@ static void lowrisc_ibex_soc_init(Object *obj)
=20
     object_initialize_child(obj, "plic", &s->plic, TYPE_SIFIVE_PLIC);
=20
-    object_initialize_child(obj, "uart", &s->uart, TYPE_IBEX_UART);
+    object_initialize_child(obj, "uart", &s->uart, TYPE_OT_UART);
=20
     object_initialize_child(obj, "timer", &s->timer, TYPE_IBEX_TIMER);
=20
diff --git a/include/hw/char/ibex_uart.h b/include/hw/char/ot_uart.h
similarity index 84%
rename from include/hw/char/ibex_uart.h
rename to include/hw/char/ot_uart.h
index 882796e0c6..517324b65d 100644
--- a/include/hw/char/ibex_uart.h
+++ b/include/hw/char/ot_uart.h
@@ -1,5 +1,5 @@
 /*
- * QEMU lowRISC Ibex UART device
+ * QEMU OpenTitan UART device
  *
  * Copyright (c) 2020 Western Digital
  *
@@ -22,28 +22,28 @@
  * THE SOFTWARE.
  */
=20
-#ifndef HW_IBEX_UART_H
-#define HW_IBEX_UART_H
+#ifndef HW_OT_UART_H
+#define HW_OT_UART_H
=20
 #include "hw/core/sysbus.h"
 #include "chardev/char-fe.h"
 #include "qemu/timer.h"
 #include "qom/object.h"
=20
-#define IBEX_UART_TX_FIFO_SIZE 16
-#define IBEX_UART_CLOCK 50000000 /* 50MHz clock */
+#define OT_UART_TX_FIFO_SIZE 16
+#define OT_UART_CLOCK 50000000 /* 50MHz clock */
=20
-#define TYPE_IBEX_UART "ibex-uart"
-OBJECT_DECLARE_SIMPLE_TYPE(IbexUartState, IBEX_UART)
+#define TYPE_OT_UART "ot-uart"
+OBJECT_DECLARE_SIMPLE_TYPE(OtUARTState, OT_UART)
=20
-struct IbexUartState {
+struct OtUARTState {
     /* <private> */
     SysBusDevice parent_obj;
=20
     /* <public> */
     MemoryRegion mmio;
=20
-    uint8_t tx_fifo[IBEX_UART_TX_FIFO_SIZE];
+    uint8_t tx_fifo[OT_UART_TX_FIFO_SIZE];
     uint32_t tx_level;
=20
     uint32_t rx_level;
@@ -70,4 +70,4 @@ struct IbexUartState {
     qemu_irq tx_empty;
     qemu_irq rx_overflow;
 };
-#endif /* HW_IBEX_UART_H */
+#endif /* HW_OT_UART_H */
diff --git a/include/hw/riscv/opentitan.h b/include/hw/riscv/opentitan.h
index 5b9016e1d8..f2b4bf3814 100644
--- a/include/hw/riscv/opentitan.h
+++ b/include/hw/riscv/opentitan.h
@@ -21,7 +21,7 @@
=20
 #include "hw/riscv/riscv_hart.h"
 #include "hw/intc/sifive_plic.h"
-#include "hw/char/ibex_uart.h"
+#include "hw/char/ot_uart.h"
 #include "hw/timer/ibex_timer.h"
 #include "hw/ssi/ibex_spi_host.h"
 #include "hw/core/boards.h"
@@ -43,7 +43,7 @@ struct LowRISCIbexSoCState {
     /*< public >*/
     RISCVHartArrayState cpus;
     SiFivePLICState plic;
-    IbexUartState uart;
+    OtUARTState uart;
     IbexTimerState timer;
     IbexSPIHostState spi_host[OPENTITAN_NUM_SPI_HOSTS];
=20
--=20
2.49.1


