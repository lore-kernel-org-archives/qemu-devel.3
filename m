Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9AB29D10F38
	for <qemu-devel@archiver.kernel.org>; Sun, 17 Nov 2024 23:02:22 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tCoGM-0008E3-5E; Sun, 17 Nov 2024 18:01:02 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jean.christian.cirstea@gmail.com>)
 id 1tCoCt-0007hQ-Ve
 for qemu-devel@nongnu.org; Sun, 17 Nov 2024 17:57:27 -0500
Received: from mail-wm1-x331.google.com ([2a00:1450:4864:20::331])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <jean.christian.cirstea@gmail.com>)
 id 1tCoCr-0002sX-KK
 for qemu-devel@nongnu.org; Sun, 17 Nov 2024 17:57:27 -0500
Received: by mail-wm1-x331.google.com with SMTP id
 5b1f17b1804b1-43161c0068bso11661175e9.1
 for <qemu-devel@nongnu.org>; Sun, 17 Nov 2024 14:57:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1731884244; x=1732489044; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=0O44kgEA0H9qZqq+GnlJX1T0whoQU7CXMA7+cZIGsIw=;
 b=Ky1OCDof5yTQQxU2PhjmZc13vZSJiT+DsoDi3KGceZUMmjiE7lPEzf5QXdJMR1yhkn
 gYIUpRGrFav9A5+va573HP1hCNZqHKPyNpsSnQWNGzTetteP30u6lmNzxr8ib+4DMgiA
 tgCM00isKU2H4KeDH3Kcdm5D5xriLNDb+uI7tgLe1Q9H4vmYcbfgYei7Im7vvhq+bLL0
 Woysuaw2xgh9VoFgvLkhoqiiHKCFm2P9xZwcsPxoE3cjrtj4vn82FbsuKIWtcqyMDWYf
 QL31ZqmkkOk90DqDGYZD5XTy2Y3VzM9tkwZ7sljVgWT/lV7KTBuKaXyrLFFAP9Q9lJjj
 6KZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1731884244; x=1732489044;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=0O44kgEA0H9qZqq+GnlJX1T0whoQU7CXMA7+cZIGsIw=;
 b=GVi0gNREdwasvGzmj9L+CCX8eCmx1QNWEpv4mmukYkEjhozLCBT2lZtlybjiLAGuD4
 KDSjpTnVvutcUnt0AbkI1LUnKwUfvVYqBJsYBPxTzpr2vw7sq9HVGLVYU1uB73TLoS0C
 z6Q39wtXrwV/MoKslkSey0FrNgUI4bK13/AtfXAAwnIFozcnCp+B/OfRNkPUgL/EeN5J
 SGX385wOpvDbaaMS+ib1oIDpSaz3ewvWg58adYlgmPGZ+GBYtVP27a4d49xXkhI9aqaP
 vFR13UQbnTLzudpGwzvOTk2r9jkGp7G7bVPmNm6WsHGsSgruEK3Nv5mzj5p9NaGXQ22D
 AYMg==
X-Gm-Message-State: AOJu0Ywe9cVxsf5TSA6sWrfqehX8INVfHC0VNKXrgKCWualGTFNLi/nx
 oOYjB5hE3UzOfwlyWI1H/8SdqryZy+vk2nd9mv5OoTsqheU0P63Nv45wcst4xwM6PA==
X-Google-Smtp-Source: AGHT+IEimwZR0/jQepn+mY7+9751a3OGCNN3DL2zvX91EN1Nw7OSitZhh9NuBG8jsdGnpCdgiFJz4Q==
X-Received: by 2002:a05:600c:1f96:b0:431:58c4:2eb9 with SMTP id
 5b1f17b1804b1-432df71b177mr97124725e9.3.1731884244015; 
 Sun, 17 Nov 2024 14:57:24 -0800 (PST)
Received: from asus-xubuntu.. ([82.78.167.190])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-432da2800absm136351505e9.25.2024.11.17.14.57.21
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 17 Nov 2024 14:57:22 -0800 (PST)
From: "=?UTF-8?q?Ioan-Cristian=20C=C3=8ERSTEA?="
 <jean.christian.cirstea@gmail.com>
X-Google-Original-From: =?UTF-8?q?Ioan-Cristian=20C=C3=8ERSTEA?=
 <ioan-cristian.cirstea@tutanota.com>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Ioan-Cristian=20C=C3=8ERSTEA?=
 <ioan-cristian.cirstea@tutanota.com>
Subject: [PATCH 4/7] [BCM2835 AUX 4/7] STAT & IIR registers
Date: Mon, 18 Nov 2024 00:56:40 +0200
Message-Id: <20241117225643.768322-4-ioan-cristian.cirstea@tutanota.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20241117225643.768322-1-ioan-cristian.cirstea@tutanota.com>
References: <20241117225643.768322-1-ioan-cristian.cirstea@tutanota.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::331;
 envelope-from=jean.christian.cirstea@gmail.com; helo=mail-wm1-x331.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-Mailman-Approved-At: Sun, 17 Nov 2024 18:00:54 -0500
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

This commits implements the required logic for STAT & IIR registers. The
STAT register is an extension of the UART 16550 that provides useful
(more helpful than the base state register) insights of the peripheral
state. The STAT register is intrinsically related to the IIR register,
so this commit implements the logic for both of them.

Interrupt status logic has been updated accordingly.

Signed-off-by: Ioan-Cristian CÎRSTEA <ioan-cristian.cirstea@tutanota.com>
---
 hw/char/bcm2835_aux.c | 173 +++++++++++++++++++++++++++---------------
 1 file changed, 113 insertions(+), 60 deletions(-)

diff --git a/hw/char/bcm2835_aux.c b/hw/char/bcm2835_aux.c
index 2ef3459566..266d0dfdc7 100644
--- a/hw/char/bcm2835_aux.c
+++ b/hw/char/bcm2835_aux.c
@@ -46,14 +46,26 @@
 
 /* Register masks */
 #define MASK_AUX_MU_CNTL_REG 0x3
+/* Mask for TX-related bits */
+#define MASK_AUX_MU_STAT_REG_TX 0xF00032A
+/*
+ * Mask for RX-related bits.
+ * XXX: It does not include receiver IDLE and receiver overrun for now.
+ */
+#define MASK_AUX_MU_STAT_REG_RX 0xF0001
 
-/* bits in IER/IIR registers */
-#define RX_INT  0x1
-#define TX_INT  0x2
+/* bits in IER register */
+#define IER_RX_IRQ_ENABLE  0x1
+#define IER_TX_IRQ_ENABLE  0x2
+
+/* bits in IIR register */
+#define IIR_IRQ_NOT_PEND 0x1
+#define IIR_TX_EMPTY 0x2
+#define IIR_RX_VALID 0x4
 
 /* bits in CNTL register */
-#define RX_ENABLE 0x1
-#define TX_ENABLE 0x2
+#define CNTL_RX_ENABLE 0x1
+#define CNTL_TX_ENABLE 0x2
 
 /* bits in STAT register */
 #define STAT_TRANSMITTER_DONE 0x200
@@ -70,42 +82,102 @@
                   ##__VA_ARGS__ \
                   )
 
-/* TODO: Add separate functions for RX and TX interrupts */
 static void bcm2835_aux_update_irq(BCM2835AuxState *s)
 {
-    /* TODO: this should be a pointer to const data. However, the fifo8 API
+    s->iir |= IIR_IRQ_NOT_PEND;
+
+    if (s->iir & IIR_RX_VALID) {
+        s->iir &= ~IIR_IRQ_NOT_PEND;
+    } else if (s->iir & IIR_TX_EMPTY) {
+        s->iir &= ~IIR_IRQ_NOT_PEND;
+    }
+
+    /* An interrupt is raised whenever the IRQ_NOT_PEND bit is cleared */
+    qemu_set_irq(s->irq, (s->iir & IIR_IRQ_NOT_PEND) == 0);
+}
+
+static void bcm2835_aux_rx_iir_update(BCM2835AuxState *s)
+{
+    /*
+     * TODO: this should be a pointer to const data. However, the fifo8 API
      * requires a pointer to non-const data.
      */
     Fifo8 *rx_fifo = &s->rx_fifo;
-    Fifo8 *tx_fifo = &s->tx_fifo;
-    /* signal an interrupt if either:
-     * 1. rx interrupt is enabled and we have a non-empty rx fifo, or
-     * 2. the tx interrupt is enabled (since we instantly drain the tx fifo)
-     */
-    s->iir = 0;
-    if ((s->ier & RX_INT) && fifo8_is_empty(rx_fifo) == false) {
-        s->iir |= RX_INT;
-    }
-    if (s->ier & TX_INT && fifo8_is_empty(tx_fifo)) {
-        s->iir |= TX_INT;
+
+    s->iir &= ~IIR_RX_VALID;
+    if ((s->ier & IER_RX_IRQ_ENABLE) && fifo8_is_empty(rx_fifo) == false) {
+        s->iir |= IIR_RX_VALID;
     }
-    qemu_set_irq(s->irq, s->iir != 0);
+
+    bcm2835_aux_update_irq(s);
+}
+
+static void bcm2835_aux_rx_stat_update(BCM2835AuxState *s)
+{
+    Fifo8 *rx_fifo = &s->rx_fifo;
+    const bool rx_symbol_available = !fifo8_is_empty(rx_fifo);
+    const uint32_t rx_fifo_level = fifo8_num_used(rx_fifo);
+
+    s->stat &= ~MASK_AUX_MU_STAT_REG_RX;
+    s->stat |= (rx_fifo_level << 16) |
+               (rx_symbol_available << 0);
+}
+
+static void bcm2835_aux_rx_update(BCM2835AuxState *s)
+{
+    bcm2835_aux_rx_stat_update(s);
+    bcm2835_aux_rx_iir_update(s);
 }
 
-static void bcm2835_aux_update(BCM2835AuxState *s)
+static void bcm2835_aux_tx_iir_update(BCM2835AuxState *s)
 {
-    /* Currently, only IRQ registers are updated */
+    /*
+     * TODO: this should be a pointer to const data. However, the fifo8 API
+     * requires a pointer to non-const data.
+     */
+    Fifo8 *tx_fifo = &s->tx_fifo;
+
+    s->iir &= ~IIR_TX_EMPTY;
+    if (s->ier & IER_TX_IRQ_ENABLE && fifo8_is_empty(tx_fifo)) {
+        s->iir |= IIR_TX_EMPTY | IIR_IRQ_NOT_PEND;
+    }
+
     bcm2835_aux_update_irq(s);
 }
 
+static void bcm2835_aux_tx_stat_update(BCM2835AuxState *s, bool busy)
+{
+    Fifo8 *tx_fifo = &s->tx_fifo;
+    const uint32_t tx_fifo_level = fifo8_num_used(tx_fifo);
+    const uint32_t tx_fifo_empty = !tx_fifo_level;
+    const uint32_t tx_fifo_full =
+        tx_fifo_level == BCM2835_AUX_TX_FIFO_LEN ? 1 : 0;
+    const uint32_t tx_done = !busy && tx_fifo_empty;
+    const uint32_t tx_space_available = !tx_fifo_full;
+
+    s->stat &= ~MASK_AUX_MU_STAT_REG_TX;
+    s->stat = (tx_fifo_level << 24) |
+               (tx_done << 9) |
+               (tx_fifo_empty << 8) |
+               (tx_fifo_full << 5) |
+               (busy << 3) |
+               (tx_space_available << 1);
+}
+
+static void bcm2835_aux_tx_update(BCM2835AuxState *s, bool busy)
+{
+    bcm2835_aux_tx_stat_update(s, busy);
+    bcm2835_aux_tx_iir_update(s);
+}
+
 static bool bcm2835_aux_is_tx_enabled(const BCM2835AuxState *s)
 {
-    return (s->cntl & TX_ENABLE) != 0;
+    return (s->cntl & CNTL_TX_ENABLE) != 0;
 }
 
 static bool bcm2835_aux_is_rx_enabled(BCM2835AuxState *s)
 {
-    return (s->cntl & RX_ENABLE) != 0;
+    return (s->cntl & CNTL_RX_ENABLE) != 0;
 }
 
 static bool bcm2835_aux_put_tx_fifo(BCM2835AuxState *s, char ch)
@@ -132,10 +204,11 @@ static gboolean bcm2835_aux_xmit_handler(void *do_not_use, GIOCondition cond,
     if (!fifo8_is_empty(tx_fifo)) {
         const uint8_t ch = fifo8_pop(&s->tx_fifo);
         qemu_chr_fe_write(&s->chr, &ch, 1);
+        bcm2835_aux_tx_update(s, true);
 
         return G_SOURCE_CONTINUE;
     } else {
-        bcm2835_aux_update(s);
+        bcm2835_aux_tx_update(s, false);
 
         return G_SOURCE_REMOVE;
     }
@@ -151,25 +224,28 @@ static bool bcm2835_aux_can_send(const BCM2835AuxState *s)
     return bcm2835_aux_is_tx_enabled(s) && !bcm2835_aux_is_tx_busy(s);
 }
 
-static void bcm2835_aux_send(BCM2835AuxState *s)
+static void bcm2835_aux_try_send(BCM2835AuxState *s)
 {
+    bool busy = false;
+
     if (bcm2835_aux_can_send(s)) {
         const uint8_t ch = fifo8_pop(&s->tx_fifo);
         qemu_chr_fe_write(&s->chr, &ch, 1);
         qemu_chr_fe_add_watch(&s->chr, G_IO_OUT | G_IO_HUP,
                               bcm2835_aux_xmit_handler, s);
+        busy = true;
     }
+
+    bcm2835_aux_tx_update(s, busy);
 }
 
-static void bcm2835_aux_transmit(BCM2835AuxState *s, uint8_t ch)
+static void bcm2835_aux_try_transmit(BCM2835AuxState *s, uint8_t ch)
 {
     const bool result = bcm2835_aux_put_tx_fifo(s, ch);
 
     if (result) {
-        bcm2835_aux_send(s);
+        bcm2835_aux_try_send(s);
     }
-
-    bcm2835_aux_update(s);
 }
 
 static uint64_t bcm2835_aux_read(void *opaque, hwaddr offset, unsigned size)
@@ -177,7 +253,6 @@ static uint64_t bcm2835_aux_read(void *opaque, hwaddr offset, unsigned size)
     BCM2835AuxState *s = opaque;
     Fifo8 *rx_fifo = &s->rx_fifo;
     const bool is_rx_fifo_not_empty = !fifo8_is_empty(rx_fifo);
-    const uint32_t rx_fifo_fill_level = fifo8_num_used(rx_fifo);
     /*
      * 0xFF trashes terminal output, so device driver bugs can be found quickly
      * in case the RX_FIFO is read while empty
@@ -197,7 +272,7 @@ static uint64_t bcm2835_aux_read(void *opaque, hwaddr offset, unsigned size)
             c = fifo8_pop(rx_fifo);
         }
         qemu_chr_fe_accept_input(&s->chr);
-        bcm2835_aux_update(s);
+        bcm2835_aux_rx_update(s);
         return c;
 
     case AUX_MU_IER_REG:
@@ -205,20 +280,7 @@ static uint64_t bcm2835_aux_read(void *opaque, hwaddr offset, unsigned size)
         return 0xc0 | s->ier; /* FIFO enables always read 1 */
 
     case AUX_MU_IIR_REG:
-        res = 0xc0; /* FIFO enables */
-        /* The spec is unclear on what happens when both tx and rx
-         * interrupts are active, besides that this cannot occur. At
-         * present, we choose to prioritise the rx interrupt, since
-         * the tx fifo is always empty. */
-        if (is_rx_fifo_not_empty) {
-            res |= 0x4;
-        } else {
-            res |= 0x2;
-        }
-        if (s->iir == 0) {
-            res |= 0x1;
-        }
-        return res;
+        return s->iir;
 
     case AUX_MU_LCR_REG:
         qemu_log_mask(LOG_UNIMP, "%s: AUX_MU_LCR_REG unsupported\n", __func__);
@@ -247,13 +309,7 @@ static uint64_t bcm2835_aux_read(void *opaque, hwaddr offset, unsigned size)
         return s->cntl;
 
     case AUX_MU_STAT_REG:
-        res = 0x30e; /* space in the output buffer, empty tx fifo, idle tx/rx */
-        if (is_rx_fifo_not_empty) {
-            res |= 0x1; /* data in input buffer */
-            assert(rx_fifo_fill_level <= BCM2835_AUX_RX_FIFO_LEN);
-            res |= ((uint32_t)rx_fifo_fill_level) << 16; /* rx fifo fill level */
-        }
-        return res;
+        return s->stat;
 
     case AUX_MU_BAUD_REG:
         qemu_log_mask(LOG_UNIMP, "%s: AUX_MU_BAUD_REG unsupported\n", __func__);
@@ -285,15 +341,14 @@ static void bcm2835_aux_write(void *opaque, hwaddr offset, uint64_t value,
     case AUX_MU_IO_REG:
         /* "DLAB bit set means access baudrate register" is NYI */
         ch = value;
-        /* XXX this blocks entire thread. Rewrite to use
-         * qemu_chr_fe_write and background I/O callbacks */
-        bcm2835_aux_transmit(s, ch);
+        bcm2835_aux_try_transmit(s, ch);
         break;
 
     case AUX_MU_IER_REG:
         /* "DLAB bit set means access baudrate register" is NYI */
-        s->ier = value & (TX_INT | RX_INT);
-        bcm2835_aux_update(s);
+        s->ier = value & (IER_TX_IRQ_ENABLE | IER_RX_IRQ_ENABLE);
+        bcm2835_aux_rx_update(s);
+        bcm2835_aux_tx_update(s, false);
         break;
 
     case AUX_MU_IIR_REG:
@@ -331,8 +386,6 @@ static void bcm2835_aux_write(void *opaque, hwaddr offset, uint64_t value,
         qemu_log_mask(LOG_GUEST_ERROR, "%s: Bad offset %"HWADDR_PRIx"\n",
                       __func__, offset);
     }
-
-    bcm2835_aux_update(s);
 }
 
 static int bcm2835_aux_can_receive(void *opaque)
@@ -348,7 +401,7 @@ static void bcm2835_aux_put_fifo(BCM2835AuxState *s, uint8_t value)
 
     if (fifo8_is_full(rx_fifo) == false) {
         fifo8_push(rx_fifo, value);
-        bcm2835_aux_update(s);
+        bcm2835_aux_rx_update(s);
     }
 }
 
-- 
2.34.1


