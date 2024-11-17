Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1D1DCD10F38
	for <qemu-devel@archiver.kernel.org>; Sun, 17 Nov 2024 23:02:39 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tCoGO-0008Er-A5; Sun, 17 Nov 2024 18:01:04 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jean.christian.cirstea@gmail.com>)
 id 1tCoCv-0007hy-1G
 for qemu-devel@nongnu.org; Sun, 17 Nov 2024 17:57:29 -0500
Received: from mail-wr1-x431.google.com ([2a00:1450:4864:20::431])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <jean.christian.cirstea@gmail.com>)
 id 1tCoCt-0002sv-A7
 for qemu-devel@nongnu.org; Sun, 17 Nov 2024 17:57:28 -0500
Received: by mail-wr1-x431.google.com with SMTP id
 ffacd0b85a97d-382423e1f7aso489432f8f.2
 for <qemu-devel@nongnu.org>; Sun, 17 Nov 2024 14:57:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1731884246; x=1732489046; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=0iXs4DVWxzCMdGVyfkyZpFmSv1X5/7YzHmJZ/b9ZOv4=;
 b=CIAPMp+/VYiYqt+Gh9pPfnBL7OhF9ZOrB0PGJb+e39Kbwxc2fzemKbCdHV6KnNzyT9
 AQJNhHo5WJABM/FNlTngXBcCQVTDWvBGpxXsWjCaBOPDCve4ytp3334yfbMMP1h8lWeW
 J2SKD7iEOfeZzxYRSQOIaABtM/ODyTdGDOvtvv+4QPAFoXt1qbiV/PkhAS7ku5618e0I
 53BAYERmeq3/99cjxpmeHGlPHiutzxgcnj7c/1ihQNfHx3zTODSqUCvj4YC05avnqVQP
 VFR5LkIjGpXw/D/F7LG4FwHeSvP6fBzeR51zpq4yW/pfIv+IMtSHYoj1G8RAw5H0GwUL
 9Q/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1731884246; x=1732489046;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=0iXs4DVWxzCMdGVyfkyZpFmSv1X5/7YzHmJZ/b9ZOv4=;
 b=wK0EdVaviPToirz6amFFryxC3SQsTdX6192NLwYUxXNXj7XowSi9ISxwj8MkGV9WWL
 OQrdsYLrNA7lXO1gVLqPjTqRBEsS63ktsP74c61SH2JDuxS+a+TeAxW6SCbIea2rX2Dn
 Yzzo9elfxVH8bEMyHxAuraEeu3++m6S7tJDFj5y19WLragS0F78jUh1jlKCv/WUn+cJu
 gpAoLfM32tJYKssa3DDGmtH6r+IjtHYVs1RfTlPDxDkbofLu2SBCI2F+dT6MGX19g372
 AGuYupY6pWHofzxrVmK7IYSGt0lwkSm7h42WGbTFP9FRAMGN1YMUYWNFxwM8Jhf0t7Bp
 +Liw==
X-Gm-Message-State: AOJu0YzyB3ZweSMDTyqiRc+TWiy9I2DzJg1ehKHpHG2Lu1TBCFxHvDgt
 StGpWcJXZVPdmq6lm8bsSvYiNPzJelOrEwQctrU3sKDLBmVW4qTmhkUtayq/N1Dsbg==
X-Google-Smtp-Source: AGHT+IE6OM7k1f6I4uDUHTDl7S1fhv7OraRcFmX0kiNghwxvhQYYC+0tzBE9YgXfni1QxI4Z4apwpw==
X-Received: by 2002:a5d:6484:0:b0:382:3be6:5502 with SMTP id
 ffacd0b85a97d-3823be657ffmr4121338f8f.51.1731884245721; 
 Sun, 17 Nov 2024 14:57:25 -0800 (PST)
Received: from asus-xubuntu.. ([82.78.167.190])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-432da2800absm136351505e9.25.2024.11.17.14.57.24
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 17 Nov 2024 14:57:25 -0800 (PST)
From: "=?UTF-8?q?Ioan-Cristian=20C=C3=8ERSTEA?="
 <jean.christian.cirstea@gmail.com>
X-Google-Original-From: =?UTF-8?q?Ioan-Cristian=20C=C3=8ERSTEA?=
 <ioan-cristian.cirstea@tutanota.com>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Ioan-Cristian=20C=C3=8ERSTEA?=
 <ioan-cristian.cirstea@tutanota.com>
Subject: [PATCH 6/7] [BCM2835 AUX 6/7] Add LSR register
Date: Mon, 18 Nov 2024 00:56:42 +0200
Message-Id: <20241117225643.768322-6-ioan-cristian.cirstea@tutanota.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20241117225643.768322-1-ioan-cristian.cirstea@tutanota.com>
References: <20241117225643.768322-1-ioan-cristian.cirstea@tutanota.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::431;
 envelope-from=jean.christian.cirstea@gmail.com; helo=mail-wr1-x431.google.com
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

This commit implements the LSR register found in standard UART 16550.

Signed-off-by: Ioan-Cristian CÎRSTEA <ioan-cristian.cirstea@tutanota.com>
---
 hw/char/bcm2835_aux.c         | 64 ++++++++++++++++++++++++++++++++---
 include/hw/char/bcm2835_aux.h |  2 +-
 2 files changed, 60 insertions(+), 6 deletions(-)

diff --git a/hw/char/bcm2835_aux.c b/hw/char/bcm2835_aux.c
index e887076d9b..577d9a9be3 100644
--- a/hw/char/bcm2835_aux.c
+++ b/hw/char/bcm2835_aux.c
@@ -45,7 +45,9 @@
 #define AUX_MU_BAUD_REG 0x68U
 
 /* Register masks */
+
 #define MASK_AUX_MU_CNTL_REG 0x3U
+
 /* Mask for TX-related bits */
 #define MASK_AUX_MU_STAT_REG_TX 0xF00032AU
 /*
@@ -54,6 +56,9 @@
  */
 #define MASK_AUX_MU_STAT_REG_RX 0xF0001U
 
+/* Mask for TX-related bits */
+#define MASK_AUX_MU_LSR_REG_TX 0x60U
+
 /* bits in IER register */
 #define IER_RX_IRQ_ENABLE  0x1U
 #define IER_TX_IRQ_ENABLE  0x2U
@@ -63,6 +68,9 @@
 #define IIR_TX_EMPTY 0x2U
 #define IIR_RX_VALID 0x4U
 
+/* bits in LSR register */
+#define LSR_OVERRUN 0x2U
+
 /* bits in CNTL register */
 #define CNTL_RX_ENABLE 0x1U
 #define CNTL_TX_ENABLE 0x2U
@@ -82,6 +90,16 @@
                   ##__VA_ARGS__ \
                   )
 
+static void bcm2835_aux_clear_overrun_bits(BCM2835AuxState *s)
+{
+    s->lsr &= ~LSR_OVERRUN;
+}
+
+static void bcm2835_aux_set_overrun_bits(BCM2835AuxState *s)
+{
+    s->lsr |= LSR_OVERRUN;
+}
+
 static void bcm2835_aux_update_irq(BCM2835AuxState *s)
 {
     s->iir |= IIR_IRQ_NOT_PEND;
@@ -123,9 +141,23 @@ static void bcm2835_aux_rx_stat_update(BCM2835AuxState *s)
                (rx_symbol_available << 0);
 }
 
+static void bcm2835_aux_rx_lsr_update(BCM2835AuxState *s)
+{
+    /*
+     * TODO: this should be a pointer to const data. However, the fifo8 API
+     * requires a pointer to non-const data.
+     */
+    Fifo8 *rx_fifo = &s->rx_fifo;
+    const bool data_ready = !fifo8_is_empty(rx_fifo);
+
+    s->lsr &= ~0x1;
+    s->lsr |= data_ready << 0;
+}
+
 static void bcm2835_aux_rx_update(BCM2835AuxState *s)
 {
     bcm2835_aux_rx_stat_update(s);
+    bcm2835_aux_rx_lsr_update(s);
     bcm2835_aux_rx_iir_update(s);
 }
 
@@ -164,9 +196,24 @@ static void bcm2835_aux_tx_stat_update(BCM2835AuxState *s, bool busy)
                (tx_space_available << 1);
 }
 
+static void bcm2835_aux_tx_lsr_update(BCM2835AuxState *s, bool busy)
+{
+    /*
+     * TODO: This should be a pointer to constant data, but the FIFO API
+     * requires a pointer to mutable data.
+     */
+    Fifo8 *tx_fifo = &s->tx_fifo;
+    const bool is_tx_idle = !busy;
+    const bool is_tx_empty = fifo8_is_empty(tx_fifo);
+
+    s->lsr &= ~MASK_AUX_MU_LSR_REG_TX;
+    s->lsr |= (is_tx_idle << 6) | (is_tx_empty << 5);
+}
+
 static void bcm2835_aux_tx_update(BCM2835AuxState *s, bool busy)
 {
     bcm2835_aux_tx_stat_update(s, busy);
+    bcm2835_aux_tx_lsr_update(s, busy);
     bcm2835_aux_tx_iir_update(s);
 }
 
@@ -291,10 +338,9 @@ static uint64_t bcm2835_aux_read(void *opaque, hwaddr offset, unsigned size)
         return 0;
 
     case AUX_MU_LSR_REG:
-        res = 0x60; /* tx idle, empty */
-        if (is_rx_fifo_not_empty) {
-            res |= 0x1;
-        }
+        res = s->lsr;
+        /* Overrun bit is self-clearing */
+        bcm2835_aux_clear_overrun_bits(s);
         return res;
 
     case AUX_MU_MSR_REG:
@@ -391,8 +437,14 @@ static void bcm2835_aux_write(void *opaque, hwaddr offset, uint64_t value,
 static int bcm2835_aux_can_receive(void *opaque)
 {
     BCM2835AuxState *s = opaque;
+    const bool is_rx_fifo_full = fifo8_is_full(&s->rx_fifo);
+    const bool is_rx_enabled = bcm2835_aux_is_rx_enabled(s);
+
+    if (is_rx_fifo_full && is_rx_enabled) {
+        bcm2835_aux_set_overrun_bits(s);
+    }
 
-    return !fifo8_is_full(&s->rx_fifo);
+    return !is_rx_fifo_full;
 }
 
 static void bcm2835_aux_put_fifo(BCM2835AuxState *s, uint8_t value)
@@ -459,6 +511,8 @@ static void bcm2835_aux_realize(DeviceState *dev, Error **errp)
     s->ier = 0x0;
     /* FIFOs enabled and interrupt pending */
     s->iir = 0xC1;
+    /* Transmitter idle and TX FIFO empty */
+    s->lsr = 0x60;
     /* Both transmitter and receiver are initially enabled */
     s->cntl = 0x3;
     /* Transmitter done and FIFO empty */
diff --git a/include/hw/char/bcm2835_aux.h b/include/hw/char/bcm2835_aux.h
index f024277169..601c1fabcc 100644
--- a/include/hw/char/bcm2835_aux.h
+++ b/include/hw/char/bcm2835_aux.h
@@ -29,7 +29,7 @@ struct BCM2835AuxState {
     Fifo8 rx_fifo;
     Fifo8 tx_fifo;
     /* Registers */
-    uint32_t ier, iir, cntl, stat;
+    uint32_t ier, iir, lsr, cntl, stat;
 };
 
 #endif
-- 
2.34.1


