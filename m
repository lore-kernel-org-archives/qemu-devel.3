Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0884EC531DC
	for <qemu-devel@archiver.kernel.org>; Thu, 15 Aug 2024 01:55:05 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sePhQ-0005nb-Gq; Wed, 14 Aug 2024 21:54:48 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1sePhE-0005VI-Rb; Wed, 14 Aug 2024 21:54:37 -0400
Received: from mail-pg1-x52f.google.com ([2607:f8b0:4864:20::52f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1sePhC-0003mQ-Co; Wed, 14 Aug 2024 21:54:36 -0400
Received: by mail-pg1-x52f.google.com with SMTP id
 41be03b00d2f7-6c5bcb8e8edso421749a12.2; 
 Wed, 14 Aug 2024 18:54:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1723686872; x=1724291672; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=1bvHodl2jEUsnoYK8bbKlLRBXcXSo+b9l+ftccdVbUA=;
 b=HkL2FbhF7Q8suVtoPFmcYApFusrtpbZp6TM1JluDSX+Ie45dEFcKVq6wxK2D6lQtr/
 BLYKJr7XE3u7iGlCU+s9V02+SXf1JE3i/L6RkcMjIJpF4DVtQdxu9wX0augzE7Dyqeq7
 9hqdIUXC+2XUBhycnm1f9HE+5YtaUgnQQPCnmvtG3v6H1XgFA1sMgzfA6zIa8ILEb3wR
 Ufz7nsAx/WFfzqOXX+VJoUX0v4+MtbvWfZMgESVuOfWEvfqcD2yVF3aKXoTGZSPfnTk+
 rKdUze+YhaVKClLH38Q2c4AUHKERG6a/vnvF9WPaSImxlQtBJpqaYAWzx/Ot7nCWYq2Z
 7LVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1723686872; x=1724291672;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=1bvHodl2jEUsnoYK8bbKlLRBXcXSo+b9l+ftccdVbUA=;
 b=Hbhzj3NWjnH0iH4C2KTKjjmxth61oAO3ZkVDsFHemaPEjto9AgAhrq2JnQwj9DrpwW
 QbFEBOmv7Flw5ZBByK2kgc70qhgHR0UTrhccxwFDKRTpnQmwO2pBz37Kc35aumjLBmGR
 GBACrclq0GSezdhHgn3L7QuHq4AXK/iYZVQ2ZaExypSm17eI0f0YoaYliC9hdWEsRZfx
 17Ae1Z0dzixm5QBOqkA0hJDBwx+mwcx9g65JydVZzjnotVt5f5ee2XfMHFcZQoiJiz04
 WE4T1vWWDeYckBlXjtdJ0qFXfMHOchG4KiIAIsHIZUFkhZSc+XgK7FYhZbwzo402zneb
 bbow==
X-Forwarded-Encrypted: i=1;
 AJvYcCV9dysyFZuEgHYKgjvndjPXS2jdVmpJpF88WUOUj3eRpnOW6qJIopZkyhmOcaZQp2PAoPIm9XkTCe9I7RaBRTrD3nPczAZncwJqEYsIlkg8yx31XYCYy8DaoSL48w==
X-Gm-Message-State: AOJu0YyPOqMiMbWqhNuo+Na6z1u51yCNS9O4YQVd+uki8SWrDQU4GkbV
 /umuPPVX2+VbAcZmzsjWn0imsfxyrLrio53tW8Dm/Z2OjE4gR8o4
X-Google-Smtp-Source: AGHT+IF1nbHAslh5XjgPsDe0fTMdCgyOHiUdKzoOPGUtwEiOQdH19dV8CHJTlhD5gcLX2FsLcSoDQQ==
X-Received: by 2002:a17:90a:eacb:b0:2d3:b60c:45e7 with SMTP id
 98e67ed59e1d1-2d3b60c46e1mr3328850a91.32.1723686871716; 
 Wed, 14 Aug 2024 18:54:31 -0700 (PDT)
Received: from toolbox.alistair23.me
 (2403-580b-97e8-0-82ce-f179-8a79-69f4.ip6.aussiebb.net.
 [2403:580b:97e8:0:82ce:f179:8a79:69f4])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-2d396a59287sm2477688a91.0.2024.08.14.18.54.26
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 14 Aug 2024 18:54:31 -0700 (PDT)
From: Alistair Francis <alistair23@gmail.com>
X-Google-Original-From: Alistair Francis <alistair.francis@wdc.com>
To: alex.bennee@linaro.org,
	qemu-devel@nongnu.org,
	peter.maydell@linaro.org
Cc: alistair23@gmail.com, dbarboza@ventanamicro.com, palmer@dabbelt.com,
 qemu-riscv@nongnu.org,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 zhiwei_liu@linux.alibaba.com, atishp@rivosinc.com,
 Bin Meng <bmeng.cn@gmail.com>, liwei1518@gmail.com,
 Alistair Francis <Alistair.Francis@wdc.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Alistair Francis <alistair.francis@wdc.com>
Subject: [PATCH 2/2] hw/char: sifive_uart: Print uart charecters async
Date: Thu, 15 Aug 2024 11:54:10 +1000
Message-ID: <20240815015410.369925-3-alistair.francis@wdc.com>
X-Mailer: git-send-email 2.46.0
In-Reply-To: <20240815015410.369925-1-alistair.francis@wdc.com>
References: <20240815015410.369925-1-alistair.francis@wdc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::52f;
 envelope-from=alistair23@gmail.com; helo=mail-pg1-x52f.google.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FREEMAIL_ENVFROM_END_DIGIT=0.25, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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
return values results in dropped charecters [1].

Let's update the SiFive UART to use a async sifive_uart_xmit() function
to transmit the charecters and apply back preassure to the guest with
the SIFIVE_UART_TXFIFO_FULL status.

This should avoid dropped charecters and more realisiticly model the
hardware.

1: https://gitlab.com/qemu-project/qemu/-/issues/2114

Signed-off-by: Alistair Francis <alistair.francis@wdc.com>
---
 include/hw/char/sifive_uart.h | 17 +++++++-
 hw/char/sifive_uart.c         | 81 +++++++++++++++++++++++++++++++++--
 2 files changed, 92 insertions(+), 6 deletions(-)

diff --git a/include/hw/char/sifive_uart.h b/include/hw/char/sifive_uart.h
index 7f6c79f8bd..73379457a0 100644
--- a/include/hw/char/sifive_uart.h
+++ b/include/hw/char/sifive_uart.h
@@ -48,9 +48,13 @@ enum {
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
@@ -63,13 +67,22 @@ struct SiFiveUARTState {
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
+    uint8_t tx_fifo[SIFIVE_UART_TX_FIFO_SIZE];
+    uint32_t tx_level;
+
+    QEMUTimer *fifo_trigger_handle;
+    uint64_t char_tx_time;
 };
 
 SiFiveUARTState *sifive_uart_create(MemoryRegion *address_space, hwaddr base,
diff --git a/hw/char/sifive_uart.c b/hw/char/sifive_uart.c
index 7fc6787f69..f517500df4 100644
--- a/hw/char/sifive_uart.c
+++ b/hw/char/sifive_uart.c
@@ -64,6 +64,64 @@ static void sifive_uart_update_irq(SiFiveUARTState *s)
     }
 }
 
+static gboolean sifive_uart_xmit(void *do_not_use, GIOCondition cond,
+                                 void *opaque)
+{
+    SiFiveUARTState *s = opaque;
+    int ret;
+
+    /* instant drain the fifo when there's no back-end */
+    if (!qemu_chr_fe_backend_connected(&s->chr)) {
+        s->tx_level = 0;
+        return G_SOURCE_REMOVE;
+    }
+
+    ret = qemu_chr_fe_write(&s->chr, s->tx_fifo, s->tx_level);
+
+    if (ret >= 0) {
+        s->tx_level -= ret;
+        memmove(s->tx_fifo, s->tx_fifo + ret, s->tx_level);
+    }
+
+    if (s->tx_level) {
+        guint r = qemu_chr_fe_add_watch(&s->chr, G_IO_OUT | G_IO_HUP,
+                                        sifive_uart_xmit, s);
+        if (!r) {
+            s->tx_level = 0;
+            return G_SOURCE_REMOVE;
+        }
+    }
+
+    /* Clear the TX Full bit */
+    if (s->tx_level != SIFIVE_UART_TX_FIFO_SIZE) {
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
+    if (size > SIFIVE_UART_TX_FIFO_SIZE - s->tx_level) {
+        size = SIFIVE_UART_TX_FIFO_SIZE - s->tx_level;
+        qemu_log_mask(LOG_GUEST_ERROR, "sifive_uart: TX FIFO overflow");
+    }
+
+    memcpy(s->tx_fifo + s->tx_level, buf, 1);
+    s->tx_level += 1;
+
+    if (s->tx_level == SIFIVE_UART_TX_FIFO_SIZE) {
+        s->txfifo |= SIFIVE_UART_TXFIFO_FULL;
+    }
+
+    timer_mod(s->fifo_trigger_handle, current_time +
+              (s->char_tx_time * 4));
+}
+
 static uint64_t
 sifive_uart_read(void *opaque, hwaddr addr, unsigned int size)
 {
@@ -82,7 +140,7 @@ sifive_uart_read(void *opaque, hwaddr addr, unsigned int size)
         return 0x80000000;
 
     case SIFIVE_UART_TXFIFO:
-        return 0; /* Should check tx fifo */
+        return s->txfifo;
     case SIFIVE_UART_IE:
         return s->ie;
     case SIFIVE_UART_IP:
@@ -106,12 +164,10 @@ sifive_uart_write(void *opaque, hwaddr addr,
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
@@ -131,6 +187,13 @@ sifive_uart_write(void *opaque, hwaddr addr,
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
@@ -197,6 +260,9 @@ static void sifive_uart_realize(DeviceState *dev, Error **errp)
 {
     SiFiveUARTState *s = SIFIVE_UART(dev);
 
+    s->fifo_trigger_handle = timer_new_ns(QEMU_CLOCK_VIRTUAL,
+                                          fifo_trigger_update, s);
+
     qemu_chr_fe_set_handlers(&s->chr, sifive_uart_can_rx, sifive_uart_rx,
                              sifive_uart_event, sifive_uart_be_change, s,
                              NULL, true);
@@ -206,12 +272,19 @@ static void sifive_uart_realize(DeviceState *dev, Error **errp)
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
+    s->tx_level = 0;
     s->rx_fifo_len = 0;
+
+    memset(s->rx_fifo, 0, SIFIVE_UART_RX_FIFO_SIZE);
+    memset(s->tx_fifo, 0, SIFIVE_UART_TX_FIFO_SIZE);
 }
 
 static void sifive_uart_reset_hold(Object *obj, ResetType type)
-- 
2.46.0


