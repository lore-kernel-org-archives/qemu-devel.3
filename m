Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7CD47D10F39
	for <qemu-devel@archiver.kernel.org>; Sun, 17 Nov 2024 23:01:48 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tCoGI-0008DC-S3; Sun, 17 Nov 2024 18:00:59 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jean.christian.cirstea@gmail.com>)
 id 1tCoCp-0007gu-Oz
 for qemu-devel@nongnu.org; Sun, 17 Nov 2024 17:57:23 -0500
Received: from mail-wm1-x334.google.com ([2a00:1450:4864:20::334])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <jean.christian.cirstea@gmail.com>)
 id 1tCoCn-0002rp-Vl
 for qemu-devel@nongnu.org; Sun, 17 Nov 2024 17:57:23 -0500
Received: by mail-wm1-x334.google.com with SMTP id
 5b1f17b1804b1-4314f38d274so22193485e9.1
 for <qemu-devel@nongnu.org>; Sun, 17 Nov 2024 14:57:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1731884239; x=1732489039; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=1NcEwOeWHFjScd3fyiWygZ/Gn+PwBjhmbkNrTkjnAq0=;
 b=mupT/e7qdYOYXt7+377+465MdHDdTAL3RMBh5s2FDz04dxM6h3VeHww7cTej85Y7Ct
 F/1klm5+e+VyZnITo3AOmiunE3GJtDobz0xyDpJ7vaYLlZYlWoB9J2Qai/PFJicru6nR
 lKHxfUy/BLiRB8D42vGgTOD5bkWs14mhIZim5cFIlNjcAo/58P6l49znOGleUDe+2TS+
 rB4nl4Zd1SbSH/pNXQjJeq8rk9159Bsq8hDNHv/uBX/Z68tM5DoaXdvvSDuF40mb1Iic
 fs42ONvCOXT2JCxP53gMuhsFj8Af1GGg2i9Kg02oCjwoB8904Mt8+YM7j7/tX+guPQuz
 S3hA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1731884239; x=1732489039;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=1NcEwOeWHFjScd3fyiWygZ/Gn+PwBjhmbkNrTkjnAq0=;
 b=nwQD8s0L/Q0ZQav7oU2FHmiJM1Fs/RQw2l3eZaGnD8vQ7QB1sRwWgpTjmlVlvywqq/
 uKz8EBRp+XL5JBeMt/XtDCLoGuhmxkIJkECcI6Cm1kbPLWQxN9SHjmrq8JlUcBgnm5JF
 WD9awAjc8grFiWhx4q+rkCZPust6lDhlQ1lCUi9s0Kxai0KPvY1zsQo2JWuU7oICUY0c
 H07zdT98gbQmKs8n4IhnjCsHXQO0v32IobP0n0L4nOfunrtaxm0S99S5dIubXc8FhsuM
 7ZUlTI0w7MY3IlJ4i6z9pudRJQPS6/K7dZ3sguc5wtXR2z0ZhPWTU7ufGvVNfPoLBAOW
 C3bQ==
X-Gm-Message-State: AOJu0Yy+k5x1q5YsHlUPZaFiDvuSrJbk5KRItgRmhcpMakoltrxGP1UJ
 oLrzHIO4tFrsmvA8TKl823uZ8FY0jrviy2UKbwTS2w68n4yc3cEAGxf7RJ4of46pWg==
X-Google-Smtp-Source: AGHT+IGityb++P2QNHfzL1tQFPXgnzhhnm2gEnYCP+wueEUgsHkCwmXS8D9lwl3W2HTByrQFFEvmeA==
X-Received: by 2002:a05:600c:501e:b0:431:4847:47c0 with SMTP id
 5b1f17b1804b1-432df722c63mr103673425e9.7.1731884238771; 
 Sun, 17 Nov 2024 14:57:18 -0800 (PST)
Received: from asus-xubuntu.. ([82.78.167.190])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-432da2800absm136351505e9.25.2024.11.17.14.57.17
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 17 Nov 2024 14:57:18 -0800 (PST)
From: "=?UTF-8?q?Ioan-Cristian=20C=C3=8ERSTEA?="
 <jean.christian.cirstea@gmail.com>
X-Google-Original-From: =?UTF-8?q?Ioan-Cristian=20C=C3=8ERSTEA?=
 <ioan-cristian.cirstea@tutanota.com>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Ioan-Cristian=20C=C3=8ERSTEA?=
 <ioan-cristian.cirstea@tutanota.com>
Subject: [PATCH 1/7] [BCM2835 AUX 1/7] Replace hard-coded FIFO
Date: Mon, 18 Nov 2024 00:56:37 +0200
Message-Id: <20241117225643.768322-1-ioan-cristian.cirstea@tutanota.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::334;
 envelope-from=jean.christian.cirstea@gmail.com; helo=mail-wm1-x334.google.com
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

The previous BCM2835 mini UART implementation used a hard-coded FIFO.
This commit changes the implementation by making use of the provided
Fifo8.

Signed-off-by: Ioan-Cristian CÎRSTEA <ioan-cristian.cirstea@tutanota.com>
---
 hw/char/bcm2835_aux.c         | 61 ++++++++++++++++++-----------------
 include/hw/char/bcm2835_aux.h | 10 +++---
 2 files changed, 37 insertions(+), 34 deletions(-)

diff --git a/hw/char/bcm2835_aux.c b/hw/char/bcm2835_aux.c
index fca2f27a55..540cb30872 100644
--- a/hw/char/bcm2835_aux.c
+++ b/hw/char/bcm2835_aux.c
@@ -47,14 +47,23 @@
 #define RX_INT  0x1
 #define TX_INT  0x2
 
+/* FIFOs length */
+#define BCM2835_AUX_RX_FIFO_LEN 8
+#define BCM2835_AUX_TX_FIOF_LEN 8
+
+/* TODO: Add separate functions for RX and TX interrupts */
 static void bcm2835_aux_update(BCM2835AuxState *s)
 {
+    /* TODO: this should be a pointer to const data. However, the fifo8 API
+     * requires a pointer to non-const data.
+     */
+    Fifo8 *rx_fifo = &s->rx_fifo;
     /* signal an interrupt if either:
      * 1. rx interrupt is enabled and we have a non-empty rx fifo, or
      * 2. the tx interrupt is enabled (since we instantly drain the tx fifo)
      */
     s->iir = 0;
-    if ((s->ier & RX_INT) && s->read_count != 0) {
+    if ((s->ier & RX_INT) && fifo8_is_empty(rx_fifo) == false) {
         s->iir |= RX_INT;
     }
     if (s->ier & TX_INT) {
@@ -66,7 +75,10 @@ static void bcm2835_aux_update(BCM2835AuxState *s)
 static uint64_t bcm2835_aux_read(void *opaque, hwaddr offset, unsigned size)
 {
     BCM2835AuxState *s = opaque;
-    uint32_t c, res;
+    Fifo8 *rx_fifo = &s->rx_fifo;
+    const bool is_rx_fifo_not_empty = !fifo8_is_empty(rx_fifo);
+    const uint32_t rx_fifo_fill_level = fifo8_num_used(rx_fifo);
+    uint32_t c = 0, res;
 
     switch (offset) {
     case AUX_IRQ:
@@ -77,12 +89,8 @@ static uint64_t bcm2835_aux_read(void *opaque, hwaddr offset, unsigned size)
 
     case AUX_MU_IO_REG:
         /* "DLAB bit set means access baudrate register" is NYI */
-        c = s->read_fifo[s->read_pos];
-        if (s->read_count > 0) {
-            s->read_count--;
-            if (++s->read_pos == BCM2835_AUX_RX_FIFO_LEN) {
-                s->read_pos = 0;
-            }
+        if (is_rx_fifo_not_empty) {
+            c = fifo8_pop(rx_fifo);
         }
         qemu_chr_fe_accept_input(&s->chr);
         bcm2835_aux_update(s);
@@ -98,7 +106,7 @@ static uint64_t bcm2835_aux_read(void *opaque, hwaddr offset, unsigned size)
          * interrupts are active, besides that this cannot occur. At
          * present, we choose to prioritise the rx interrupt, since
          * the tx fifo is always empty. */
-        if (s->read_count != 0) {
+        if (is_rx_fifo_not_empty) {
             res |= 0x4;
         } else {
             res |= 0x2;
@@ -118,7 +126,7 @@ static uint64_t bcm2835_aux_read(void *opaque, hwaddr offset, unsigned size)
 
     case AUX_MU_LSR_REG:
         res = 0x60; /* tx idle, empty */
-        if (s->read_count != 0) {
+        if (is_rx_fifo_not_empty) {
             res |= 0x1;
         }
         return res;
@@ -136,10 +144,10 @@ static uint64_t bcm2835_aux_read(void *opaque, hwaddr offset, unsigned size)
 
     case AUX_MU_STAT_REG:
         res = 0x30e; /* space in the output buffer, empty tx fifo, idle tx/rx */
-        if (s->read_count > 0) {
+        if (is_rx_fifo_not_empty) {
             res |= 0x1; /* data in input buffer */
-            assert(s->read_count <= BCM2835_AUX_RX_FIFO_LEN);
-            res |= ((uint32_t)s->read_count) << 16; /* rx fifo fill level */
+            assert(rx_fifo_fill_level <= BCM2835_AUX_RX_FIFO_LEN);
+            res |= ((uint32_t)rx_fifo_fill_level) << 16; /* rx fifo fill level */
         }
         return res;
 
@@ -158,6 +166,7 @@ static void bcm2835_aux_write(void *opaque, hwaddr offset, uint64_t value,
                               unsigned size)
 {
     BCM2835AuxState *s = opaque;
+    Fifo8 *rx_fifo = &s->rx_fifo;
     unsigned char ch;
 
     switch (offset) {
@@ -185,7 +194,7 @@ static void bcm2835_aux_write(void *opaque, hwaddr offset, uint64_t value,
 
     case AUX_MU_IIR_REG:
         if (value & 0x2) {
-            s->read_count = 0;
+            fifo8_reset(rx_fifo);
         }
         break;
 
@@ -221,24 +230,18 @@ static int bcm2835_aux_can_receive(void *opaque)
 {
     BCM2835AuxState *s = opaque;
 
-    return s->read_count < BCM2835_AUX_RX_FIFO_LEN;
+    return !fifo8_is_full(&s->rx_fifo);
 }
 
 static void bcm2835_aux_put_fifo(void *opaque, uint8_t value)
 {
     BCM2835AuxState *s = opaque;
-    int slot;
+    Fifo8 *rx_fifo = &s->rx_fifo;
 
-    slot = s->read_pos + s->read_count;
-    if (slot >= BCM2835_AUX_RX_FIFO_LEN) {
-        slot -= BCM2835_AUX_RX_FIFO_LEN;
-    }
-    s->read_fifo[slot] = value;
-    s->read_count++;
-    if (s->read_count == BCM2835_AUX_RX_FIFO_LEN) {
-        /* buffer full */
+    if (fifo8_is_full(rx_fifo) == false) {
+        fifo8_push(rx_fifo, value);
+        bcm2835_aux_update(s);
     }
-    bcm2835_aux_update(s);
 }
 
 static void bcm2835_aux_receive(void *opaque, const uint8_t *buf, int size)
@@ -261,10 +264,8 @@ static const VMStateDescription vmstate_bcm2835_aux = {
     .version_id = 1,
     .minimum_version_id = 1,
     .fields = (const VMStateField[]) {
-        VMSTATE_UINT8_ARRAY(read_fifo, BCM2835AuxState,
-                            BCM2835_AUX_RX_FIFO_LEN),
-        VMSTATE_UINT8(read_pos, BCM2835AuxState),
-        VMSTATE_UINT8(read_count, BCM2835AuxState),
+        VMSTATE_FIFO8(rx_fifo, BCM2835AuxState),
+        VMSTATE_FIFO8(_tx_fifo, BCM2835AuxState),
         VMSTATE_UINT8(ier, BCM2835AuxState),
         VMSTATE_UINT8(iir, BCM2835AuxState),
         VMSTATE_END_OF_LIST()
@@ -276,6 +277,8 @@ static void bcm2835_aux_init(Object *obj)
     SysBusDevice *sbd = SYS_BUS_DEVICE(obj);
     BCM2835AuxState *s = BCM2835_AUX(obj);
 
+    fifo8_create(&s->rx_fifo, BCM2835_AUX_RX_FIFO_LEN);
+
     memory_region_init_io(&s->iomem, OBJECT(s), &bcm2835_aux_ops, s,
                           TYPE_BCM2835_AUX, 0x100);
     sysbus_init_mmio(sbd, &s->iomem);
diff --git a/include/hw/char/bcm2835_aux.h b/include/hw/char/bcm2835_aux.h
index 9e081793a0..cb1a824994 100644
--- a/include/hw/char/bcm2835_aux.h
+++ b/include/hw/char/bcm2835_aux.h
@@ -9,15 +9,14 @@
 #ifndef BCM2835_AUX_H
 #define BCM2835_AUX_H
 
-#include "hw/sysbus.h"
 #include "chardev/char-fe.h"
+#include "hw/sysbus.h"
+#include "qemu/fifo8.h"
 #include "qom/object.h"
 
 #define TYPE_BCM2835_AUX "bcm2835-aux"
 OBJECT_DECLARE_SIMPLE_TYPE(BCM2835AuxState, BCM2835_AUX)
 
-#define BCM2835_AUX_RX_FIFO_LEN 8
-
 struct BCM2835AuxState {
     /*< private >*/
     SysBusDevice parent_obj;
@@ -27,8 +26,9 @@ struct BCM2835AuxState {
     CharBackend chr;
     qemu_irq irq;
 
-    uint8_t read_fifo[BCM2835_AUX_RX_FIFO_LEN];
-    uint8_t read_pos, read_count;
+    Fifo8 rx_fifo;
+    /* Unused for now */
+    Fifo8 _tx_fifo;
     uint8_t ier, iir;
 };
 
-- 
2.34.1


