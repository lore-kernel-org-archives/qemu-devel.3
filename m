Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9D2C4E6894E
	for <qemu-devel@archiver.kernel.org>; Thu, 31 Oct 2024 03:54:28 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t6MGH-0007M6-ST; Wed, 30 Oct 2024 23:54:17 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1t6MGF-0007LG-AN
 for qemu-devel@nongnu.org; Wed, 30 Oct 2024 23:54:15 -0400
Received: from mail-pl1-x634.google.com ([2607:f8b0:4864:20::634])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1t6MGD-0003w7-B0
 for qemu-devel@nongnu.org; Wed, 30 Oct 2024 23:54:15 -0400
Received: by mail-pl1-x634.google.com with SMTP id
 d9443c01a7336-20c6f492d2dso5819435ad.0
 for <qemu-devel@nongnu.org>; Wed, 30 Oct 2024 20:54:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1730346852; x=1730951652; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=AktGiR8ovsGryNkBXTUT4evAW3zZcrfX6pzkUArGLbo=;
 b=R6B4F+NYYEtXXaEpekmTiBIDCE31sj0pZ3lQ0R6Lwc4+OMI7bZrmA/xfAeYufNmGIJ
 Rb4BnctPKv7xbr1xjpcWsTOG1mNKvWj3oDLqoPyaMOHN06H1uVwPIeMAYe0+t+RELlf5
 z4fCP6sVEb6obSnTgju6k66O2SlKWeCt75KA9bdeETlf1CLxM2TSI6Es3Tq1AdrLPuu0
 pY3dnFwd8UE6dd+1zSTaf1+dDFOlQcPijZxRFTiGB1q9q6fIi6Rkv5jqvzwYywv1WRa/
 Ldc0D4Bqp1WA3AXMzfsRlP7HGIvlbZcXNHj86/h4jBz3JQhD/Zk9T/C7zFj7Zay00x8c
 MWfw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1730346852; x=1730951652;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=AktGiR8ovsGryNkBXTUT4evAW3zZcrfX6pzkUArGLbo=;
 b=LXJsQ+DB5mZZ0+ub+2NB+YtxdCR7D5C/rg1NgXFs685ulrisnAjdGj95EDYrtlpo8s
 q1M8cQHVBzHdrzf6/yHz9vpuMGJzm+hj1oMtZa41AliD0N5xGw4EOC7Yoru0l3sjZUjV
 s/H7Ka/nDzBlORe7m+bLBW8xtdD2ZfwyRm7DdmH/0Hvn1v5YnWV+9mbTEbJPfz5VXEAh
 +P5dWKQ/FE585JPM0NHI0pzPJ44kb+/nhz4hZ4xfszpA2SCQ87gGL+XAyr6fJRKPWICd
 Kmt8QeE1Gpa9i7k8dMjZUPnBgXyKv5WznivP7MVQFSQdXjlBb86Mo4zIYoPO2H9xSbaa
 1pmg==
X-Gm-Message-State: AOJu0YxFKnf1SMg0WN3mrtfPu8oSJHjIeSwwglKiZ43ReMlXv/wKbHXu
 TbBFjCEL/35eGoDSGH+UEu0KFDi3gAK9EQTTD/kMixGEhVmETt8yuTP8nhi/
X-Google-Smtp-Source: AGHT+IFUSJZBuh0VkTrSktvMuWsYyQZqi4Sp8DVDy0BJQ8wqTMKlc+WSjwoxfjAXxv8b7V0h6DOLSw==
X-Received: by 2002:a17:903:240b:b0:20c:c9ac:bd05 with SMTP id
 d9443c01a7336-210c689b948mr235408795ad.15.1730346851854; 
 Wed, 30 Oct 2024 20:54:11 -0700 (PDT)
Received: from toolbox.alistair23.me
 (2403-580b-97e8-0-82ce-f179-8a79-69f4.ip6.aussiebb.net.
 [2403:580b:97e8:0:82ce:f179:8a79:69f4])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-21105707064sm3022795ad.70.2024.10.30.20.54.09
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 30 Oct 2024 20:54:11 -0700 (PDT)
From: Alistair Francis <alistair23@gmail.com>
X-Google-Original-From: Alistair Francis <alistair.francis@wdc.com>
To: qemu-devel@nongnu.org
Cc: alistair23@gmail.com, Alistair Francis <alistair.francis@wdc.com>,
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>,
 Thomas Huth <thuth@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PULL 15/50] hw/char: sifive_uart: Print uart characters async
Date: Thu, 31 Oct 2024 13:52:43 +1000
Message-ID: <20241031035319.731906-16-alistair.francis@wdc.com>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <20241031035319.731906-1-alistair.francis@wdc.com>
References: <20241031035319.731906-1-alistair.francis@wdc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::634;
 envelope-from=alistair23@gmail.com; helo=mail-pl1-x634.google.com
X-Spam_score_int: -17
X-Spam_score: -1.8
X-Spam_bar: -
X-Spam_report: (-1.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FREEMAIL_ENVFROM_END_DIGIT=0.25, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

The current approach of using qemu_chr_fe_write() and ignoring the
return values results in dropped characters [1].

Let's update the SiFive UART to use a async sifive_uart_xmit() function
to transmit the characters and apply back pressure to the guest with
the SIFIVE_UART_TXFIFO_FULL status.

This should avoid dropped characters and more realisticly model the
hardware.

1: https://gitlab.com/qemu-project/qemu/-/issues/2114

Signed-off-by: Alistair Francis <alistair.francis@wdc.com>
Reviewed-by: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
Tested-by: Thomas Huth <thuth@redhat.com>
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Message-ID: <20240910045419.1252277-3-alistair.francis@wdc.com>
Signed-off-by: Alistair Francis <alistair.francis@wdc.com>
---
 include/hw/char/sifive_uart.h | 16 +++++-
 hw/char/sifive_uart.c         | 97 ++++++++++++++++++++++++++++++++---
 2 files changed, 105 insertions(+), 8 deletions(-)

diff --git a/include/hw/char/sifive_uart.h b/include/hw/char/sifive_uart.h
index 7f6c79f8bd..0846cf6218 100644
--- a/include/hw/char/sifive_uart.h
+++ b/include/hw/char/sifive_uart.h
@@ -24,6 +24,7 @@
 #include "hw/qdev-properties.h"
 #include "hw/sysbus.h"
 #include "qom/object.h"
+#include "qemu/fifo8.h"
 
 enum {
     SIFIVE_UART_TXFIFO        = 0,
@@ -48,9 +49,13 @@ enum {
     SIFIVE_UART_IP_RXWM       = 2  /* Receive watermark interrupt pending */
 };
 
+#define SIFIVE_UART_TXFIFO_FULL    0x80000000
+
 #define SIFIVE_UART_GET_TXCNT(txctrl)   ((txctrl >> 16) & 0x7)
 #define SIFIVE_UART_GET_RXCNT(rxctrl)   ((rxctrl >> 16) & 0x7)
+
 #define SIFIVE_UART_RX_FIFO_SIZE 8
+#define SIFIVE_UART_TX_FIFO_SIZE 8
 
 #define TYPE_SIFIVE_UART "riscv.sifive.uart"
 OBJECT_DECLARE_SIMPLE_TYPE(SiFiveUARTState, SIFIVE_UART)
@@ -63,13 +68,20 @@ struct SiFiveUARTState {
     qemu_irq irq;
     MemoryRegion mmio;
     CharBackend chr;
-    uint8_t rx_fifo[SIFIVE_UART_RX_FIFO_SIZE];
-    uint8_t rx_fifo_len;
+
+    uint32_t txfifo;
     uint32_t ie;
     uint32_t ip;
     uint32_t txctrl;
     uint32_t rxctrl;
     uint32_t div;
+
+    uint8_t rx_fifo[SIFIVE_UART_RX_FIFO_SIZE];
+    uint8_t rx_fifo_len;
+
+    Fifo8 tx_fifo;
+
+    QEMUTimer *fifo_trigger_handle;
 };
 
 SiFiveUARTState *sifive_uart_create(MemoryRegion *address_space, hwaddr base,
diff --git a/hw/char/sifive_uart.c b/hw/char/sifive_uart.c
index 7fc6787f69..aeb45d3601 100644
--- a/hw/char/sifive_uart.c
+++ b/hw/char/sifive_uart.c
@@ -26,6 +26,8 @@
 #include "hw/char/sifive_uart.h"
 #include "hw/qdev-properties-system.h"
 
+#define TX_INTERRUPT_TRIGGER_DELAY_NS 100
+
 /*
  * Not yet implemented:
  *
@@ -64,6 +66,72 @@ static void sifive_uart_update_irq(SiFiveUARTState *s)
     }
 }
 
+static gboolean sifive_uart_xmit(void *do_not_use, GIOCondition cond,
+                                 void *opaque)
+{
+    SiFiveUARTState *s = opaque;
+    int ret;
+    const uint8_t *characters;
+    uint32_t numptr = 0;
+
+    /* instant drain the fifo when there's no back-end */
+    if (!qemu_chr_fe_backend_connected(&s->chr)) {
+        fifo8_reset(&s->tx_fifo);
+        return G_SOURCE_REMOVE;
+    }
+
+    if (fifo8_is_empty(&s->tx_fifo)) {
+        return G_SOURCE_REMOVE;
+    }
+
+    /* Don't pop the FIFO in case the write fails */
+    characters = fifo8_peek_bufptr(&s->tx_fifo,
+                                   fifo8_num_used(&s->tx_fifo), &numptr);
+    ret = qemu_chr_fe_write(&s->chr, characters, numptr);
+
+    if (ret >= 0) {
+        /* We wrote the data, actually pop the fifo */
+        fifo8_pop_bufptr(&s->tx_fifo, ret, NULL);
+    }
+
+    if (!fifo8_is_empty(&s->tx_fifo)) {
+        guint r = qemu_chr_fe_add_watch(&s->chr, G_IO_OUT | G_IO_HUP,
+                                        sifive_uart_xmit, s);
+        if (!r) {
+            fifo8_reset(&s->tx_fifo);
+            return G_SOURCE_REMOVE;
+        }
+    }
+
+    /* Clear the TX Full bit */
+    if (!fifo8_is_full(&s->tx_fifo)) {
+        s->txfifo &= ~SIFIVE_UART_TXFIFO_FULL;
+    }
+
+    sifive_uart_update_irq(s);
+    return G_SOURCE_REMOVE;
+}
+
+static void sifive_uart_write_tx_fifo(SiFiveUARTState *s, const uint8_t *buf,
+                                      int size)
+{
+    uint64_t current_time = qemu_clock_get_ns(QEMU_CLOCK_VIRTUAL);
+
+    if (size > fifo8_num_free(&s->tx_fifo)) {
+        size = fifo8_num_free(&s->tx_fifo);
+        qemu_log_mask(LOG_GUEST_ERROR, "sifive_uart: TX FIFO overflow");
+    }
+
+    fifo8_push_all(&s->tx_fifo, buf, size);
+
+    if (fifo8_is_full(&s->tx_fifo)) {
+        s->txfifo |= SIFIVE_UART_TXFIFO_FULL;
+    }
+
+    timer_mod(s->fifo_trigger_handle, current_time +
+                  TX_INTERRUPT_TRIGGER_DELAY_NS);
+}
+
 static uint64_t
 sifive_uart_read(void *opaque, hwaddr addr, unsigned int size)
 {
@@ -82,7 +150,7 @@ sifive_uart_read(void *opaque, hwaddr addr, unsigned int size)
         return 0x80000000;
 
     case SIFIVE_UART_TXFIFO:
-        return 0; /* Should check tx fifo */
+        return s->txfifo;
     case SIFIVE_UART_IE:
         return s->ie;
     case SIFIVE_UART_IP:
@@ -106,12 +174,10 @@ sifive_uart_write(void *opaque, hwaddr addr,
 {
     SiFiveUARTState *s = opaque;
     uint32_t value = val64;
-    unsigned char ch = value;
 
     switch (addr) {
     case SIFIVE_UART_TXFIFO:
-        qemu_chr_fe_write(&s->chr, &ch, 1);
-        sifive_uart_update_irq(s);
+        sifive_uart_write_tx_fifo(s, (uint8_t *) &value, 1);
         return;
     case SIFIVE_UART_IE:
         s->ie = val64;
@@ -131,6 +197,13 @@ sifive_uart_write(void *opaque, hwaddr addr,
                   __func__, (int)addr, (int)value);
 }
 
+static void fifo_trigger_update(void *opaque)
+{
+    SiFiveUARTState *s = opaque;
+
+    sifive_uart_xmit(NULL, G_IO_OUT, s);
+}
+
 static const MemoryRegionOps sifive_uart_ops = {
     .read = sifive_uart_read,
     .write = sifive_uart_write,
@@ -197,6 +270,9 @@ static void sifive_uart_realize(DeviceState *dev, Error **errp)
 {
     SiFiveUARTState *s = SIFIVE_UART(dev);
 
+    s->fifo_trigger_handle = timer_new_ns(QEMU_CLOCK_VIRTUAL,
+                                          fifo_trigger_update, s);
+
     qemu_chr_fe_set_handlers(&s->chr, sifive_uart_can_rx, sifive_uart_rx,
                              sifive_uart_event, sifive_uart_be_change, s,
                              NULL, true);
@@ -206,12 +282,18 @@ static void sifive_uart_realize(DeviceState *dev, Error **errp)
 static void sifive_uart_reset_enter(Object *obj, ResetType type)
 {
     SiFiveUARTState *s = SIFIVE_UART(obj);
+
+    s->txfifo = 0;
     s->ie = 0;
     s->ip = 0;
     s->txctrl = 0;
     s->rxctrl = 0;
     s->div = 0;
+
     s->rx_fifo_len = 0;
+
+    memset(s->rx_fifo, 0, SIFIVE_UART_RX_FIFO_SIZE);
+    fifo8_create(&s->tx_fifo, SIFIVE_UART_TX_FIFO_SIZE);
 }
 
 static void sifive_uart_reset_hold(Object *obj, ResetType type)
@@ -222,8 +304,8 @@ static void sifive_uart_reset_hold(Object *obj, ResetType type)
 
 static const VMStateDescription vmstate_sifive_uart = {
     .name = TYPE_SIFIVE_UART,
-    .version_id = 1,
-    .minimum_version_id = 1,
+    .version_id = 2,
+    .minimum_version_id = 2,
     .fields = (const VMStateField[]) {
         VMSTATE_UINT8_ARRAY(rx_fifo, SiFiveUARTState,
                             SIFIVE_UART_RX_FIFO_SIZE),
@@ -233,6 +315,9 @@ static const VMStateDescription vmstate_sifive_uart = {
         VMSTATE_UINT32(txctrl, SiFiveUARTState),
         VMSTATE_UINT32(rxctrl, SiFiveUARTState),
         VMSTATE_UINT32(div, SiFiveUARTState),
+        VMSTATE_UINT32(txfifo, SiFiveUARTState),
+        VMSTATE_FIFO8(tx_fifo, SiFiveUARTState),
+        VMSTATE_TIMER_PTR(fifo_trigger_handle, SiFiveUARTState),
         VMSTATE_END_OF_LIST()
     },
 };
-- 
2.47.0


