Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D7F30CA5FA5
	for <qemu-devel@archiver.kernel.org>; Tue, 29 Sep 2026 10:03:31 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xBUen-0006z4-R2; Tue, 29 Sep 2026 06:01:53 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1xBUek-0006yJ-Tn
 for qemu-devel@nongnu.org; Tue, 29 Sep 2026 06:01:50 -0400
Received: from mail-wm2-x10.google.com ([2a00:1450:4864:31::10])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1xBUei-00088X-Ll
 for qemu-devel@nongnu.org; Tue, 29 Sep 2026 06:01:50 -0400
Received: by mail-wm2-x10.google.com with SMTP id
 5b1f17b1804b1-49ccf3ca626so24677065e9.0
 for <qemu-devel@nongnu.org>; Tue, 29 Sep 2026 03:01:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1790676107; x=1791280907; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=Ke7LuNt59a5nMt+1ImY7qly3Ui/jRhDMF92kFPy+wLA=;
 b=x+rkQu6o6N7AZmcTOeTaBqOP8GWS2dyTQ3VZXgigrEYfac5xw8S634QlVpSxDHPdmv
 Jg/iWVkOWpjZIsNbE/8te4QeKaw3tCIaIQvDUmTHQeQbTZAi8+DRxzF8nzHT/iEg58iC
 exRw5grxhARm/+ATl+/tSVlYqlm/EoOSPEHXLhn4LxqIZT6qh5VIK6CTszWod9gk6nj3
 wI3kNNDdO76dfOMA7QQF9QbwT6tnC1g+a17Z9pLuRkOxEcIj+LXvp1mPVNckdOOjsr0M
 Z+s4SOviw4Ovi7cP7laeJ1F7iM6qBjDx2it3gNj25SJv9OjR+Anyp21PI0mOgVpijT0q
 h5ZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790676107; x=1791280907;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=Ke7LuNt59a5nMt+1ImY7qly3Ui/jRhDMF92kFPy+wLA=;
 b=ydbxiXimV/JTVCLY/sCFLuL2bDazRbS4Xkg7ccNzkXpJO2tGYYf9H8uZGuPa5cBkf1
 PoJqp7ojzTNcA56XmoE4D6vMRkcT9qCdeBdC/QUmtQ+02K5FTvZ3wF2iynJFuEZ18/EK
 tulAs2xBfy86CXq4yXeZTsQE8HCL42ZX2IZGBLoLhirqWbokkl7WTUFC/HbCEfMw6C4i
 ptH5/Bw6xhQEeCM468kFX+R3Oe0lVxcgXx0ut5OfWRyrw52tAZyPjwBRBFvD7cuzOBdK
 Hd4UkclJPoryme62YkFl1UiuOCweTn5PoqLDgpcaFZUxxsLJsdzmv4QCcpJXEr3Gx0mm
 f8gg==
X-Gm-Message-State: AFuF++l90w9JQrR1igOP55LRu6dj2YXSrppB2U7IsAvYT81W45pqt2OV
 /9UxcvTMTwfV+LBKYmXW7mGxELhky0rmnay9g2IDIOHncUMDdz7sM01B3rEcqtUpGj2olA4gHkP
 uImBI
X-Gm-Gg: AYBFou2G936OxhI/ukekkB3RCT3cVZuW7jACq8m629R6AeBVMitMZuwAe9My7kVX6X9
 rvFYU2wu8Yi0gyHXLXVuema3bQZpn/Qu8AmAUdt/iBd4kJv3hw1YuJ05bewA+nqoRr2M/wiMrS2
 9uCrbbtsRtQkTJTOhrGYRbA6tKW4e+Vn50jT4B0115zqgd+lMk5G0ecfMotvOhi8qVHmUuX+W3l
 Qekv/lajhcnr4L3Oo6fvFffYB+rlve+UE3Wb3aa9csVRu79CUhyr4GVQt5cymlvXz+RG8LmCbKM
 nL+rUX6I7cpC1dXJn3aiGIynP0VQaS/x1d9H2sBOeGD4EA4+qJUqVXdn3DKKRaSxKQ5bzP1Ok9R
 NEBnOcd8ztrIfRP4uRViB4I2Kljr7lr9zm/jzeJODKALCI7lJjir7i4Rv/boYJz2KTgv5b4AIzP
 V3StjOSuAI9tvlqF+RF02etDtxmyPDDPUpStZO/1cqu5luBaMFleubEw7J9okbsm5ufyxHPj677
 KVFxha88kdPKjJErH3fhV4slbPAT4tJFn9o7OYcalHRL/RNPyqQhP0Pjrpzx61fahqUD/uC23YM
 z9AF41fyViPXrg==
X-Received: by 2002:a05:600c:c173:b0:49c:fa20:cbfd with SMTP id
 5b1f17b1804b1-49fe66eb262mr268052995e9.20.1790676106415; 
 Tue, 29 Sep 2026 03:01:46 -0700 (PDT)
Received: from lanath.. (wildly.archaic.org.uk. [81.2.115.145])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-48af4f88b37sm3091412f8f.5.2026.09.29.03.01.45
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 29 Sep 2026 03:01:45 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 07/37] hw/char/exynos4210_uart: fix fifo overflow
Date: Tue, 29 Sep 2026 11:01:02 +0100
Message-ID: <20260929100133.2598676-8-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260929100133.2598676-1-peter.maydell@linaro.org>
References: <20260929100133.2598676-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:31::10;
 envelope-from=peter.maydell@linaro.org; helo=mail-wm2-x10.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

From: jprx <jravi@mit.edu>

The Exynos 4210 UART FIFO implementation uses a circular buffer with a
store and retrieve pointer. When implemented this way, a circular
buffer's capacity is 1 less than the size of the backing buffer, because
there is no way to disambiguate the empty and full states (when the
store pointer == retrieve pointer).

When exynos4210_uart_can_receive is called, it may report that the
entire is buffer is available for receiving data, as
fifo_empty_elements_number may incorrectly report that the FIFO capacity
is equal to the entire buffer size (rather than 1 less than the size).

If this happens, a full FIFO buffer's worth of data will be read into
the circular buffer, the store pointer will wrap around back to its
starting value, and the FIFO will reset back to the empty state. The
next time exynos4210_uart_can_receive is called, it will report the
entire buffer is empty instead of full, and promptly allow the data to
be overwritten before the guest has received it.

The consequence is that if a message is sent into the UART (eg. via a
chardev) longer than the FIFO's buffer length, the first part of the
message will be lost due to this overflowing behavior, and only the last
part of the message will be received.

This patch fixes this bug by refactoring the Exynos 4210 UART to make
use of the fifo8 implementation, which is implemented via a head pointer
and length field, and therefore has capacity equal to the buffer length
and is immune to this behavior.

The Exynos 4210 UART FIFO test now passes instead of timing out.

This is a migration compatibility break for the exynos4 boards,
but that is OK as they are not versioned boards.

Signed-off-by: Joseph Ravichandran <jravi@mit.edu>
Message-id: 178983644340.22135.11298603231632238119-2@git.sr.ht
[PMM: bump version fields to indicate migration compat break]
Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 hw/char/exynos4210_uart.c | 111 ++++++++++----------------------------
 1 file changed, 29 insertions(+), 82 deletions(-)

diff --git a/hw/char/exynos4210_uart.c b/hw/char/exynos4210_uart.c
index 46fc4e31b83..9d1825150d1 100644
--- a/hw/char/exynos4210_uart.c
+++ b/hw/char/exynos4210_uart.c
@@ -28,6 +28,7 @@
 #include "qemu/timer.h"
 #include "chardev/char-fe.h"
 #include "chardev/char-serial.h"
+#include "qemu/fifo8.h"
 
 #include "hw/arm/exynos4210.h"
 #include "hw/core/irq.h"
@@ -133,12 +134,6 @@ static const Exynos4210UartReg exynos4210_uart_regs[] = {
 #define UERSTAT_FRAME    0x4
 #define UERSTAT_BREAK    0x8
 
-typedef struct {
-    uint8_t    *data;
-    uint32_t    sp, rp; /* store and retrieve pointers */
-    uint32_t    size;
-} Exynos4210UartFIFO;
-
 #define TYPE_EXYNOS4210_UART "exynos4210.uart"
 OBJECT_DECLARE_SIMPLE_TYPE(Exynos4210UartState, EXYNOS4210_UART)
 
@@ -148,8 +143,10 @@ struct Exynos4210UartState {
     MemoryRegion iomem;
 
     uint32_t             reg[EXYNOS4210_UART_REGS_MEM_SIZE / sizeof(uint32_t)];
-    Exynos4210UartFIFO   rx;
-    Exynos4210UartFIFO   tx;
+    Fifo8                rx;
+    Fifo8                tx;
+    uint32_t             rx_capacity;
+    uint32_t             tx_capacity;
 
     QEMUTimer *fifo_timeout_timer;
     uint64_t wordtime;        /* word time in ns */
@@ -178,45 +175,6 @@ static const char *exynos4210_uart_regname(hwaddr  offset)
     return NULL;
 }
 
-
-static void fifo_store(Exynos4210UartFIFO *q, uint8_t ch)
-{
-    q->data[q->sp] = ch;
-    q->sp = (q->sp + 1) % q->size;
-}
-
-static uint8_t fifo_retrieve(Exynos4210UartFIFO *q)
-{
-    uint8_t ret = q->data[q->rp];
-    q->rp = (q->rp + 1) % q->size;
-    return  ret;
-}
-
-static int fifo_elements_number(const Exynos4210UartFIFO *q)
-{
-    if (q->sp < q->rp) {
-        return q->size - q->rp + q->sp;
-    }
-
-    return q->sp - q->rp;
-}
-
-static int fifo_empty_elements_number(const Exynos4210UartFIFO *q)
-{
-    return q->size - fifo_elements_number(q);
-}
-
-static void fifo_reset(Exynos4210UartFIFO *q)
-{
-    g_free(q->data);
-    q->data = NULL;
-
-    q->data = g_malloc0(q->size);
-
-    q->sp = 0;
-    q->rp = 0;
-}
-
 static uint32_t exynos4210_uart_FIFO_trigger_level(uint32_t channel,
                                                    uint32_t reg)
 {
@@ -271,7 +229,7 @@ exynos4210_uart_Rx_FIFO_trigger_level(const Exynos4210UartState *s)
 static void exynos4210_uart_update_dmabusy(Exynos4210UartState *s)
 {
     bool rx_dma_enabled = (s->reg[I_(UCON)] & 0x03) == 0x02;
-    uint32_t count = fifo_elements_number(&s->rx);
+    uint32_t count = fifo8_num_used(&s->rx);
 
     if (rx_dma_enabled && !count) {
         qemu_irq_raise(s->dmairq);
@@ -300,7 +258,7 @@ static void exynos4210_uart_update_irq(Exynos4210UartState *s)
          * Rx interrupt if trigger level is reached or if rx timeout
          * interrupt is disabled and there is data in the receive buffer
          */
-        count = fifo_elements_number(&s->rx);
+        count = fifo8_num_used(&s->rx);
         if ((count && !(s->reg[I_(UCON)] & 0x80)) ||
             count >= exynos4210_uart_Rx_FIFO_trigger_level(s)) {
             exynos4210_uart_update_dmabusy(s);
@@ -416,12 +374,12 @@ static void exynos4210_uart_write(void *opaque, hwaddr offset,
     case UFCON:
         s->reg[I_(UFCON)] = val;
         if (val & UFCON_Rx_FIFO_RESET) {
-            fifo_reset(&s->rx);
+            fifo8_reset(&s->rx);
             s->reg[I_(UFCON)] &= ~UFCON_Rx_FIFO_RESET;
             trace_exynos_uart_rx_fifo_reset(s->channel);
         }
         if (val & UFCON_Tx_FIFO_RESET) {
-            fifo_reset(&s->tx);
+            fifo8_reset(&s->tx);
             s->reg[I_(UFCON)] &= ~UFCON_Tx_FIFO_RESET;
             trace_exynos_uart_tx_fifo_reset(s->channel);
         }
@@ -490,8 +448,8 @@ static uint64_t exynos4210_uart_read(void *opaque, hwaddr offset,
                                exynos4210_uart_regname(offset), res);
         return res;
     case UFSTAT: /* Read Only */
-        s->reg[I_(UFSTAT)] = fifo_elements_number(&s->rx) & 0xff;
-        if (fifo_empty_elements_number(&s->rx) == 0) {
+        s->reg[I_(UFSTAT)] = fifo8_num_used(&s->rx) & 0xff;
+        if (fifo8_num_free(&s->rx) == 0) {
             s->reg[I_(UFSTAT)] |= UFSTAT_Rx_FIFO_FULL;
             s->reg[I_(UFSTAT)] &= ~0xff;
         }
@@ -501,10 +459,10 @@ static uint64_t exynos4210_uart_read(void *opaque, hwaddr offset,
         return s->reg[I_(UFSTAT)];
     case URXH:
         if (s->reg[I_(UFCON)] & UFCON_FIFO_ENABLE) {
-            if (fifo_elements_number(&s->rx)) {
-                res = fifo_retrieve(&s->rx);
+            if (fifo8_num_used(&s->rx)) {
+                res = fifo8_pop(&s->rx);
                 trace_exynos_uart_rx(s->channel, res);
-                if (!fifo_elements_number(&s->rx)) {
+                if (!fifo8_num_used(&s->rx)) {
                     s->reg[I_(UTRSTAT)] &= ~UTRSTAT_Rx_BUFFER_DATA_READY;
                 } else {
                     s->reg[I_(UTRSTAT)] |= UTRSTAT_Rx_BUFFER_DATA_READY;
@@ -555,7 +513,7 @@ static int exynos4210_uart_can_receive(void *opaque)
     Exynos4210UartState *s = (Exynos4210UartState *)opaque;
 
     if (s->reg[I_(UFCON)] & UFCON_FIFO_ENABLE) {
-        return fifo_empty_elements_number(&s->rx);
+        return fifo8_num_free(&s->rx);
     } else {
         return !(s->reg[I_(UTRSTAT)] & UTRSTAT_Rx_BUFFER_DATA_READY);
     }
@@ -567,12 +525,12 @@ static void exynos4210_uart_receive(void *opaque, const uint8_t *buf, int size)
     int i;
 
     if (s->reg[I_(UFCON)] & UFCON_FIFO_ENABLE) {
-        if (fifo_empty_elements_number(&s->rx) < size) {
-            size = fifo_empty_elements_number(&s->rx);
+        if (fifo8_num_free(&s->rx) < size) {
+            size = fifo8_num_free(&s->rx);
             s->reg[I_(UINTSP)] |= UINTSP_ERROR;
         }
         for (i = 0; i < size; i++) {
-            fifo_store(&s->rx, buf[i]);
+            fifo8_push(&s->rx, buf[i]);
         }
         exynos4210_uart_rx_timeout_set(s);
     } else {
@@ -591,7 +549,7 @@ static void exynos4210_uart_event(void *opaque, QEMUChrEvent event)
     if (event == CHR_EVENT_BREAK) {
         /* When the RxDn is held in logic 0, then a null byte is pushed into the
          * fifo */
-        fifo_store(&s->rx, '\0');
+        fifo8_push(&s->rx, '\0');
         s->reg[I_(UERSTAT)] |= UERSTAT_BREAK;
         exynos4210_uart_update_irq(s);
     }
@@ -608,10 +566,10 @@ static void exynos4210_uart_reset(DeviceState *dev)
                 exynos4210_uart_regs[i].reset_value;
     }
 
-    fifo_reset(&s->rx);
-    fifo_reset(&s->tx);
+    fifo8_reset(&s->rx);
+    fifo8_reset(&s->tx);
 
-    trace_exynos_uart_rxsize(s->channel, s->rx.size);
+    trace_exynos_uart_rxsize(s->channel, s->rx_capacity);
 }
 
 static int exynos4210_uart_post_load(void *opaque, int version_id)
@@ -624,26 +582,13 @@ static int exynos4210_uart_post_load(void *opaque, int version_id)
     return 0;
 }
 
-static const VMStateDescription vmstate_exynos4210_uart_fifo = {
-    .name = "exynos4210.uart.fifo",
-    .version_id = 1,
-    .minimum_version_id = 1,
-    .fields = (const VMStateField[]) {
-        VMSTATE_UINT32(sp, Exynos4210UartFIFO),
-        VMSTATE_UINT32(rp, Exynos4210UartFIFO),
-        VMSTATE_VBUFFER_UINT32(data, Exynos4210UartFIFO, 1, NULL, size),
-        VMSTATE_END_OF_LIST()
-    }
-};
-
 static const VMStateDescription vmstate_exynos4210_uart = {
     .name = "exynos4210.uart",
-    .version_id = 1,
-    .minimum_version_id = 1,
+    .version_id = 2,
+    .minimum_version_id = 2,
     .post_load = exynos4210_uart_post_load,
     .fields = (const VMStateField[]) {
-        VMSTATE_STRUCT(rx, Exynos4210UartState, 1,
-                       vmstate_exynos4210_uart_fifo, Exynos4210UartFIFO),
+        VMSTATE_FIFO8(rx, Exynos4210UartState),
         VMSTATE_UINT32_ARRAY(reg, Exynos4210UartState,
                              EXYNOS4210_UART_REGS_MEM_SIZE / sizeof(uint32_t)),
         VMSTATE_END_OF_LIST()
@@ -699,6 +644,8 @@ static void exynos4210_uart_realize(DeviceState *dev, Error **errp)
     s->fifo_timeout_timer = timer_new_ns(QEMU_CLOCK_VIRTUAL,
                                          exynos4210_uart_timeout_int, s);
 
+    fifo8_create(&s->rx, s->rx_capacity);
+    fifo8_create(&s->tx, s->tx_capacity);
     qemu_chr_fe_set_handlers(&s->chr, exynos4210_uart_can_receive,
                              exynos4210_uart_receive, exynos4210_uart_event,
                              NULL, s, NULL, true);
@@ -707,8 +654,8 @@ static void exynos4210_uart_realize(DeviceState *dev, Error **errp)
 static const Property exynos4210_uart_properties[] = {
     DEFINE_PROP_CHR("chardev", Exynos4210UartState, chr),
     DEFINE_PROP_UINT32("channel", Exynos4210UartState, channel, 0),
-    DEFINE_PROP_UINT32("rx-size", Exynos4210UartState, rx.size, 16),
-    DEFINE_PROP_UINT32("tx-size", Exynos4210UartState, tx.size, 16),
+    DEFINE_PROP_UINT32("rx-size", Exynos4210UartState, rx_capacity, 16),
+    DEFINE_PROP_UINT32("tx-size", Exynos4210UartState, tx_capacity, 16),
 };
 
 static void exynos4210_uart_class_init(ObjectClass *klass, const void *data)
-- 
2.43.0


