Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9CDB9D10F38
	for <qemu-devel@archiver.kernel.org>; Sun, 17 Nov 2024 23:01:39 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tCoGG-0008Cx-Rn; Sun, 17 Nov 2024 18:00:57 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jean.christian.cirstea@gmail.com>)
 id 1tCoCr-0007hA-7N
 for qemu-devel@nongnu.org; Sun, 17 Nov 2024 17:57:25 -0500
Received: from mail-wm1-x336.google.com ([2a00:1450:4864:20::336])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <jean.christian.cirstea@gmail.com>)
 id 1tCoCp-0002s6-Fk
 for qemu-devel@nongnu.org; Sun, 17 Nov 2024 17:57:25 -0500
Received: by mail-wm1-x336.google.com with SMTP id
 5b1f17b1804b1-4314c4cb752so21914915e9.2
 for <qemu-devel@nongnu.org>; Sun, 17 Nov 2024 14:57:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1731884242; x=1732489042; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=OfUX/8zvMAkV8YsOzKiP/pvIj1mwKy7Bw3sUmbojNMA=;
 b=OjslYWJqhdKmMSRioKSRZij9Zb2JWZFav41vfsg8uiFc+e3u0VgeXVBzp6O5umLghG
 nRhxJ7x7axR3cfdiPLucvKptnWq+H5I1GYc8JoLpmJBAy+RAb+ugHWlYELouEARC8Zdi
 G4GaSJ5sGtYUzM/jNPg46o/4D/OFhqRknrmw/hChCOLU5BLsDLJv/bYMxzBOQ8RslDXx
 kvdnePM5hHdJ+Ab/wjc5mMRpjNBsb3UTg1+rNXr2EVtspNO0ll/4V+sy2/tv5+AGNd6t
 PAAF7Azu7iy4cYLyG9pczcCA2SUT/PrYZUeCh/b/mtGshmH4fhhSAuK5SKkGCPTPf+2f
 THew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1731884242; x=1732489042;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=OfUX/8zvMAkV8YsOzKiP/pvIj1mwKy7Bw3sUmbojNMA=;
 b=BiBbWQlW9vKgmXkClBVnN92h1bREyD8Rz3hB2RoOLBc6HZN+36K9BCdekz36XHsaMA
 Jqym+zSRf6XLjjdMXUf/1ozZx8974JOlc4T036JbAP9KlUI9VPjyHmGheC9LXKHkJkw0
 I3m3eJUlDW742/rULLrTbskDwoGXHXOrSRGvBSrQqH2UYjWhIGJa4LFijhWcbEEwMeZA
 /e3Z3jdo+Rc3RNeqPacrtNMsrgM2s/DPhAuGxy8F5f+NZKeXYTlkT78nXNL8f4togoLn
 JU3YMRFxImoga/L38bcGhctjld9LLN9SDUxKTVe1aqUwUHnXWxlSwkO50GDeqcec1fp5
 B98w==
X-Gm-Message-State: AOJu0YwZHQD6CFS223KaZ9QwL+eYeHEUS8kmFTRows4J1Bm8AGKr2hBw
 kh6GVBNGqzziLBkaTSCwGDJEakawrXEQMUxLR/InveU+RZFBMkPjdtm++KfrA22F/Q==
X-Google-Smtp-Source: AGHT+IHxVGZsrnGbwKvMGzproedHbdM7SqzzfnNAxoPJfvjQTJ2WD7rhSlfRYmYDKlAuh1g1Mp93Mg==
X-Received: by 2002:a05:600c:4693:b0:431:5632:448b with SMTP id
 5b1f17b1804b1-432df78ba78mr87569845e9.25.1731884241833; 
 Sun, 17 Nov 2024 14:57:21 -0800 (PST)
Received: from asus-xubuntu.. ([82.78.167.190])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-432da2800absm136351505e9.25.2024.11.17.14.57.20
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 17 Nov 2024 14:57:21 -0800 (PST)
From: "=?UTF-8?q?Ioan-Cristian=20C=C3=8ERSTEA?="
 <jean.christian.cirstea@gmail.com>
X-Google-Original-From: =?UTF-8?q?Ioan-Cristian=20C=C3=8ERSTEA?=
 <ioan-cristian.cirstea@tutanota.com>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Ioan-Cristian=20C=C3=8ERSTEA?=
 <ioan-cristian.cirstea@tutanota.com>
Subject: [PATCH 3/7] [BCM2835 AUX 3/7] Asynchronous transmit
Date: Mon, 18 Nov 2024 00:56:39 +0200
Message-Id: <20241117225643.768322-3-ioan-cristian.cirstea@tutanota.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20241117225643.768322-1-ioan-cristian.cirstea@tutanota.com>
References: <20241117225643.768322-1-ioan-cristian.cirstea@tutanota.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::336;
 envelope-from=jean.christian.cirstea@gmail.com; helo=mail-wm1-x336.google.com
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

This commit changes data transmission: instead of using the blocking
function `qemu_chr_fe_write_all()`, the transmit logic using the
asynchronous counterpart `qemu_chr_fe_write()`.

Signed-off-by: Ioan-Cristian CÎRSTEA <ioan-cristian.cirstea@tutanota.com>
---
 hw/char/bcm2835_aux.c         | 110 ++++++++++++++++++++++++++++++----
 include/hw/char/bcm2835_aux.h |   5 +-
 2 files changed, 101 insertions(+), 14 deletions(-)

diff --git a/hw/char/bcm2835_aux.c b/hw/char/bcm2835_aux.c
index ebc7f5ade5..2ef3459566 100644
--- a/hw/char/bcm2835_aux.c
+++ b/hw/char/bcm2835_aux.c
@@ -55,17 +55,29 @@
 #define RX_ENABLE 0x1
 #define TX_ENABLE 0x2
 
+/* bits in STAT register */
+#define STAT_TRANSMITTER_DONE 0x200
+
 /* FIFOs length */
 #define BCM2835_AUX_RX_FIFO_LEN 8
-#define BCM2835_AUX_TX_FIOF_LEN 8
+#define BCM2835_AUX_TX_FIFO_LEN 8
+
+#define log_guest_error(fmt, ...) \
+    qemu_log_mask(LOG_GUEST_ERROR, \
+                  "bcm2835_aux:%s:%d: " fmt, \
+                  __func__, \
+                  __LINE__, \
+                  ##__VA_ARGS__ \
+                  )
 
 /* TODO: Add separate functions for RX and TX interrupts */
-static void bcm2835_aux_update(BCM2835AuxState *s)
+static void bcm2835_aux_update_irq(BCM2835AuxState *s)
 {
     /* TODO: this should be a pointer to const data. However, the fifo8 API
      * requires a pointer to non-const data.
      */
     Fifo8 *rx_fifo = &s->rx_fifo;
+    Fifo8 *tx_fifo = &s->tx_fifo;
     /* signal an interrupt if either:
      * 1. rx interrupt is enabled and we have a non-empty rx fifo, or
      * 2. the tx interrupt is enabled (since we instantly drain the tx fifo)
@@ -74,13 +86,19 @@ static void bcm2835_aux_update(BCM2835AuxState *s)
     if ((s->ier & RX_INT) && fifo8_is_empty(rx_fifo) == false) {
         s->iir |= RX_INT;
     }
-    if (s->ier & TX_INT) {
+    if (s->ier & TX_INT && fifo8_is_empty(tx_fifo)) {
         s->iir |= TX_INT;
     }
     qemu_set_irq(s->irq, s->iir != 0);
 }
 
-static bool bcm2835_aux_is_tx_enabled(BCM2835AuxState *s)
+static void bcm2835_aux_update(BCM2835AuxState *s)
+{
+    /* Currently, only IRQ registers are updated */
+    bcm2835_aux_update_irq(s);
+}
+
+static bool bcm2835_aux_is_tx_enabled(const BCM2835AuxState *s)
 {
     return (s->cntl & TX_ENABLE) != 0;
 }
@@ -90,6 +108,70 @@ static bool bcm2835_aux_is_rx_enabled(BCM2835AuxState *s)
     return (s->cntl & RX_ENABLE) != 0;
 }
 
+static bool bcm2835_aux_put_tx_fifo(BCM2835AuxState *s, char ch)
+{
+    Fifo8 *tx_fifo = &s->tx_fifo;
+
+    if (fifo8_is_full(tx_fifo)) {
+        log_guest_error("TX buffer overflow");
+
+        return false;
+    }
+
+    fifo8_push(tx_fifo, ch);
+
+    return true;
+}
+
+static gboolean bcm2835_aux_xmit_handler(void *do_not_use, GIOCondition cond,
+                                         void *opaque)
+{
+    BCM2835AuxState *s = opaque;
+    Fifo8 *tx_fifo = &s->tx_fifo;
+
+    if (!fifo8_is_empty(tx_fifo)) {
+        const uint8_t ch = fifo8_pop(&s->tx_fifo);
+        qemu_chr_fe_write(&s->chr, &ch, 1);
+
+        return G_SOURCE_CONTINUE;
+    } else {
+        bcm2835_aux_update(s);
+
+        return G_SOURCE_REMOVE;
+    }
+}
+
+static bool bcm2835_aux_is_tx_busy(const BCM2835AuxState *s)
+{
+    return !(s->stat & STAT_TRANSMITTER_DONE);
+}
+
+static bool bcm2835_aux_can_send(const BCM2835AuxState *s)
+{
+    return bcm2835_aux_is_tx_enabled(s) && !bcm2835_aux_is_tx_busy(s);
+}
+
+static void bcm2835_aux_send(BCM2835AuxState *s)
+{
+    if (bcm2835_aux_can_send(s)) {
+        const uint8_t ch = fifo8_pop(&s->tx_fifo);
+        qemu_chr_fe_write(&s->chr, &ch, 1);
+        qemu_chr_fe_add_watch(&s->chr, G_IO_OUT | G_IO_HUP,
+                              bcm2835_aux_xmit_handler, s);
+    }
+}
+
+static void bcm2835_aux_transmit(BCM2835AuxState *s, uint8_t ch)
+{
+    const bool result = bcm2835_aux_put_tx_fifo(s, ch);
+
+    if (result) {
+        bcm2835_aux_send(s);
+    }
+
+    bcm2835_aux_update(s);
+}
+
 static uint64_t bcm2835_aux_read(void *opaque, hwaddr offset, unsigned size)
 {
     BCM2835AuxState *s = opaque;
@@ -205,9 +287,7 @@ static void bcm2835_aux_write(void *opaque, hwaddr offset, uint64_t value,
         ch = value;
         /* XXX this blocks entire thread. Rewrite to use
          * qemu_chr_fe_write and background I/O callbacks */
-        if (bcm2835_aux_is_tx_enabled(s)) {
-            qemu_chr_fe_write_all(&s->chr, &ch, 1);
-        }
+        bcm2835_aux_transmit(s, ch);
         break;
 
     case AUX_MU_IER_REG:
@@ -264,7 +344,6 @@ static int bcm2835_aux_can_receive(void *opaque)
 
 static void bcm2835_aux_put_fifo(BCM2835AuxState *s, uint8_t value)
 {
-    BCM2835AuxState *s = opaque;
     Fifo8 *rx_fifo = &s->rx_fifo;
 
     if (fifo8_is_full(rx_fifo) == false) {
@@ -298,10 +377,11 @@ static const VMStateDescription vmstate_bcm2835_aux = {
     .minimum_version_id = 1,
     .fields = (const VMStateField[]) {
         VMSTATE_FIFO8(rx_fifo, BCM2835AuxState),
-        VMSTATE_FIFO8(_tx_fifo, BCM2835AuxState),
+        VMSTATE_FIFO8(tx_fifo, BCM2835AuxState),
         VMSTATE_UINT32(ier, BCM2835AuxState),
         VMSTATE_UINT32(iir, BCM2835AuxState),
         VMSTATE_UINT32(cntl, BCM2835AuxState),
+        VMSTATE_UINT32(stat, BCM2835AuxState),
         VMSTATE_END_OF_LIST()
     }
 };
@@ -311,8 +391,6 @@ static void bcm2835_aux_init(Object *obj)
     SysBusDevice *sbd = SYS_BUS_DEVICE(obj);
     BCM2835AuxState *s = BCM2835_AUX(obj);
 
-    fifo8_create(&s->rx_fifo, BCM2835_AUX_RX_FIFO_LEN);
-
     memory_region_init_io(&s->iomem, OBJECT(s), &bcm2835_aux_ops, s,
                           TYPE_BCM2835_AUX, 0x100);
     sysbus_init_mmio(sbd, &s->iomem);
@@ -323,6 +401,16 @@ static void bcm2835_aux_realize(DeviceState *dev, Error **errp)
 {
     BCM2835AuxState *s = BCM2835_AUX(dev);
 
+    fifo8_create(&s->rx_fifo, BCM2835_AUX_RX_FIFO_LEN);
+    fifo8_create(&s->tx_fifo, BCM2835_AUX_TX_FIFO_LEN);
+    s->ier = 0x0;
+    /* FIFOs enabled and interrupt pending */
+    s->iir = 0xC1;
+    /* Both transmitter and receiver are initially enabled */
+    s->cntl = 0x3;
+    /* Transmitter done and FIFO empty */
+    s->stat = 0x300;
+
     qemu_chr_fe_set_handlers(&s->chr, bcm2835_aux_can_receive,
                              bcm2835_aux_receive, NULL, NULL, s, NULL, true);
 }
diff --git a/include/hw/char/bcm2835_aux.h b/include/hw/char/bcm2835_aux.h
index feaedc9e2f..f024277169 100644
--- a/include/hw/char/bcm2835_aux.h
+++ b/include/hw/char/bcm2835_aux.h
@@ -27,10 +27,9 @@ struct BCM2835AuxState {
     qemu_irq irq;
 
     Fifo8 rx_fifo;
-    /* Unused for now */
-    Fifo8 _tx_fifo;
+    Fifo8 tx_fifo;
     /* Registers */
-    uint32_t ier, iir, cntl;
+    uint32_t ier, iir, cntl, stat;
 };
 
 #endif
-- 
2.34.1


