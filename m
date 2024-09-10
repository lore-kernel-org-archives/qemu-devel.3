Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 63394ECE564
	for <qemu-devel@archiver.kernel.org>; Tue, 10 Sep 2024 04:55:48 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1snsty-00044d-0N; Tue, 10 Sep 2024 00:54:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1snstx-00043k-6P; Tue, 10 Sep 2024 00:54:53 -0400
Received: from mail-pl1-x635.google.com ([2607:f8b0:4864:20::635])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1snstv-0002xD-85; Tue, 10 Sep 2024 00:54:52 -0400
Received: by mail-pl1-x635.google.com with SMTP id
 d9443c01a7336-205909af9b5so39802985ad.3; 
 Mon, 09 Sep 2024 21:54:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1725944089; x=1726548889; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=xw0KbrgvvvrtCjxJXIgOiVXG0kyfqQmRrStgJmdBHPI=;
 b=fXAM6kkQC1Msuw3wGSZHoKZvMar0rHakr9stpSGp0YX3YkTqhBYxEOHur+W8kiaofY
 Xw2kGK0BN7HFxrnUMVnVW6HMEwSFvs37rlI/DHv4LPjevpmBQDkecITBx9EZNVa+Xs/A
 cV/V+Xhguuxk0vH+w+pjeSyayEgHqQINA9mMk1tr6rBLna4cWOEintYwhwOWk1Zp+Z+L
 OEY0VTxCnK0q4mvI6NJSsQgsYhk3+h7Xh0aeriBNj1dHWtGd3W+8gsyMr5iO8bv6IANe
 q+/yOYK1C87VQNCGcl6Z0lADR9/kglaH+3HFKW+BSLsH74BxK1YZNGIANqgmzG+U3zwL
 j7eg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1725944089; x=1726548889;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=xw0KbrgvvvrtCjxJXIgOiVXG0kyfqQmRrStgJmdBHPI=;
 b=QRQg/aHZA9uclpi5duu/WxbXVM+2I+ll4wpa260aHJEC77IML+WfiP62JyDHomYWWv
 ioR76o5whnL3ISJaMGWxdQDscx/6RU4ynigU5CmYyqmrx6L9dZ3ZPFyNqvwFtHpLZOEb
 880ufZIFzhG6PGPBcu+9wbwASu3QDwMhiBtwaeFVe/Er5Rx3RLFY4qPauDMXax13w7kT
 fjJulLHkMuWl/av841zokE6aCVTK2cx5m94AFhvfJo/L3axCTOR9i5LvBV4tg8jGjH1c
 oXHHV+IpDxRJMymC7fEfrAw8XsVMX9Gimj+tWFyCB4/iegH8zIccVecLuNCHaiZ44eGi
 UY5g==
X-Forwarded-Encrypted: i=1;
 AJvYcCW5LeV3XwW6i5xN8H8vUzGagAnqqEE9pUDKOKHum5s/2h0dosQhyh0J6WYLT+GeYXEhBmjvD4XGECAS@nongnu.org
X-Gm-Message-State: AOJu0YwJggsQR7LDAnrooPy4/+iIC8NRbCvIsFtkP2TsKJqmgAW8kBBX
 wqZjeMHeBb1Vnvu/iUSDTHwjweLDfobdwhVYG7sdAYNmqmI2GpkuhTYNYA==
X-Google-Smtp-Source: AGHT+IFVvKHeXREYFwzfiMgzMiMLC1L9kwi4a+ues6mEIxR3Guj3Uhzvedx6mB3nU3jD+lXiV5oW6A==
X-Received: by 2002:a17:903:2409:b0:207:3c2f:37b7 with SMTP id
 d9443c01a7336-2073c2f37dbmr49444495ad.32.1725944088881; 
 Mon, 09 Sep 2024 21:54:48 -0700 (PDT)
Received: from toolbox.alistair23.me
 (2403-580b-97e8-0-82ce-f179-8a79-69f4.ip6.aussiebb.net.
 [2403:580b:97e8:0:82ce:f179:8a79:69f4])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-20710e352d8sm40944425ad.72.2024.09.09.21.54.41
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 09 Sep 2024 21:54:48 -0700 (PDT)
From: Alistair Francis <alistair23@gmail.com>
X-Google-Original-From: Alistair Francis <alistair.francis@wdc.com>
To: qemu-devel@nongnu.org,
	alex.bennee@linaro.org,
	peter.maydell@linaro.org
Cc: Bin Meng <bmeng.cn@gmail.com>, palmer@dabbelt.com, liwei1518@gmail.com,
 zhiwei_liu@linux.alibaba.com, alistair23@gmail.com, qemu-riscv@nongnu.org,
 Alistair Francis <Alistair.Francis@wdc.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 atishp@rivosinc.com, dbarboza@ventanamicro.com,
 Alistair Francis <alistair.francis@wdc.com>, Thomas Huth <thuth@redhat.com>
Subject: [PATCH v4 2/2] hw/char: sifive_uart: Print uart characters async
Date: Tue, 10 Sep 2024 14:54:19 +1000
Message-ID: <20240910045419.1252277-3-alistair.francis@wdc.com>
X-Mailer: git-send-email 2.46.0
In-Reply-To: <20240910045419.1252277-1-alistair.francis@wdc.com>
References: <20240910045419.1252277-1-alistair.francis@wdc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::635;
 envelope-from=alistair23@gmail.com; helo=mail-pl1-x635.google.com
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
---
 include/hw/char/sifive_uart.h | 16 +++++-
 hw/char/sifive_uart.c         | 94 ++++++++++++++++++++++++++++++++---
 2 files changed, 102 insertions(+), 8 deletions(-)

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
index 7fc6787f69..16a70c7ad7 100644
--- a/hw/char/sifive_uart.c
+++ b/hw/char/sifive_uart.c
@@ -64,6 +64,71 @@ static void sifive_uart_update_irq(SiFiveUARTState *s)
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
+    timer_mod(s->fifo_trigger_handle, current_time + 100);
+}
+
 static uint64_t
 sifive_uart_read(void *opaque, hwaddr addr, unsigned int size)
 {
@@ -82,7 +147,7 @@ sifive_uart_read(void *opaque, hwaddr addr, unsigned int size)
         return 0x80000000;
 
     case SIFIVE_UART_TXFIFO:
-        return 0; /* Should check tx fifo */
+        return s->txfifo;
     case SIFIVE_UART_IE:
         return s->ie;
     case SIFIVE_UART_IP:
@@ -106,12 +171,10 @@ sifive_uart_write(void *opaque, hwaddr addr,
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
@@ -131,6 +194,13 @@ sifive_uart_write(void *opaque, hwaddr addr,
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
@@ -197,6 +267,9 @@ static void sifive_uart_realize(DeviceState *dev, Error **errp)
 {
     SiFiveUARTState *s = SIFIVE_UART(dev);
 
+    s->fifo_trigger_handle = timer_new_ns(QEMU_CLOCK_VIRTUAL,
+                                          fifo_trigger_update, s);
+
     qemu_chr_fe_set_handlers(&s->chr, sifive_uart_can_rx, sifive_uart_rx,
                              sifive_uart_event, sifive_uart_be_change, s,
                              NULL, true);
@@ -206,12 +279,18 @@ static void sifive_uart_realize(DeviceState *dev, Error **errp)
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
@@ -222,8 +301,8 @@ static void sifive_uart_reset_hold(Object *obj, ResetType type)
 
 static const VMStateDescription vmstate_sifive_uart = {
     .name = TYPE_SIFIVE_UART,
-    .version_id = 1,
-    .minimum_version_id = 1,
+    .version_id = 2,
+    .minimum_version_id = 2,
     .fields = (const VMStateField[]) {
         VMSTATE_UINT8_ARRAY(rx_fifo, SiFiveUARTState,
                             SIFIVE_UART_RX_FIFO_SIZE),
@@ -233,6 +312,9 @@ static const VMStateDescription vmstate_sifive_uart = {
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
2.46.0


