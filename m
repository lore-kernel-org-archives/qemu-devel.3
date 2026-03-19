Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 05A441091930
	for <qemu-devel@archiver.kernel.org>; Thu, 19 Mar 2026 23:26:30 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w3Mkt-0000sI-Kq; Thu, 19 Mar 2026 19:26:19 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1w3Mks-0000rw-B3
 for qemu-devel@nongnu.org; Thu, 19 Mar 2026 19:26:18 -0400
Received: from mail-pg1-x531.google.com ([2607:f8b0:4864:20::531])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1w3Mkq-0007hS-Nt
 for qemu-devel@nongnu.org; Thu, 19 Mar 2026 19:26:18 -0400
Received: by mail-pg1-x531.google.com with SMTP id
 41be03b00d2f7-c742824e1d3so527095a12.1
 for <qemu-devel@nongnu.org>; Thu, 19 Mar 2026 16:26:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1773962775; x=1774567575; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=FSL75QHFg495FNiNbzzE12kqDvsWACd2HsK7ER6Leyc=;
 b=FjrpJeY9+0uUzdRhftlTXkqY/cM+h0O5uirNpTcXuApnpPd6usix6BNnJnKprM0xqB
 8c4Xi43FCr685lxnmZfDsod4Sb9B6alDkKseVKJ3muD2fsaRhCqcwpqxUMUgP3D9/FXL
 QgpMOaoKV//4W460eRUidChQvwD7BF7A0rSSFnCQc3D1LnuGRhePbzcPEHmH56EUHSvc
 OERhDjDcTMYUigW4XvANmsVleFkJDKdI7VK0R31w8E/62VQze4e0ZekdqFxZrGmqTGd+
 hPkQkxEiSFQNMgGv7Hyv6Q5aIlGRHAm7cw4RWjTQxLIBqjB+lFfDBiQd0iOqYpxcivU7
 lBZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1773962775; x=1774567575;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=FSL75QHFg495FNiNbzzE12kqDvsWACd2HsK7ER6Leyc=;
 b=m034fHQDkVVisdph5ESxJMXNyxKXeOWIgjsm/WPhuBCPbdWpiWo56dKkm+6WB9pd8W
 lph458+tK899cmnrI5rEo2ewDUMl/dusJ35/9Ssu1dmbsVMqpk8k50AneaZlM7ICawLU
 PqncoVga6XqU8VGgcqyAX2aSwXrgntJ/IQxohy++aph/R7KbFkyA0AAuI0dWATr3O0Ul
 yqqaLLYT5afYo5kH7RmhGERg5c+ho9ImTAYgMZlQz5RweMGNHLFdQedrWlNt3FUkvhZv
 bCI85Ze71EIKCZIscxJtUPTC+DMK6BNxvconSiCQIm4mmMgTMuIk4iUBbveX14u/VMw5
 a8Hw==
X-Gm-Message-State: AOJu0YwmFJT7lQB7XLEfxnk4pLTDRmR+ghWRhogEMxNfRtWgYJvAT5p0
 IJ8m5w19t3FjWghDAOZ+a98Y5hcbg1nlI2cTTRone15KGrVYY+uU8HZXBK0LRw==
X-Gm-Gg: ATEYQzzFFye6EXzVqbB7xY61oKWMKips5ct62zPN2rQwtDZJoHluGODq8xyy9TorFyW
 +oPDC7iMKne8A/dU3bAxW6+DXydXRN/FetvcZ+A3A/WmhyfcG3Pig2N8Ej8e476uk820qi5w8yM
 0ptsXdmz/QWc4UxgJoNH5Au2jIKAPQzrmIrQFEUN6LbL9UKbdz6F/4amK2tD1Ne7PV1KrZ6bbcK
 BN+W9T9K0aKwxx2SdnJmCmdbyf53nAU3dai74/vEy4Fy3HhspPg8AO2HgDIdAEJJZCUJHVLViY4
 xENm2OlbQE20N56JJI92tfyJjc7rwshco/5ukwsiMg8nXC46F48nKVzvToRU0pH8tebXFMAUjAY
 jKWXPcnqxtfFSBWAv842DVAK8WwGdn7IoHFiQHiiwVBK0ipmpfBeriFsZ4ihgPtpbj0ZXmqv1Iu
 9iZ4Wm+hOfTzj969gOryJcwC82DOHDulkDabD22YYKInunEVtMGuJ+
X-Received: by 2002:a17:903:2449:b0:2b0:5ec1:97c1 with SMTP id
 d9443c01a7336-2b0827107e7mr9200765ad.7.1773962774647; 
 Thu, 19 Mar 2026 16:26:14 -0700 (PDT)
Received: from toolbx.alistair23.me ([2403:581e:fdf9:0:6209:4521:6813:45b7])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2b083516ae1sm2979165ad.13.2026.03.19.16.26.12
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 19 Mar 2026 16:26:14 -0700 (PDT)
From: alistair23@gmail.com
X-Google-Original-From: alistair.francis@wdc.com
To: qemu-devel@nongnu.org
Cc: alistair23@gmail.com, Frank Chang <frank.chang@sifive.com>,
 Alistair Francis <alistair.francis@wdc.com>
Subject: [PULL 11/17] hw/char: sifive_uart: Implement txctrl.txen and
 rxctrl.rxen
Date: Fri, 20 Mar 2026 09:25:16 +1000
Message-ID: <20260319232522.1867400-12-alistair.francis@wdc.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260319232522.1867400-1-alistair.francis@wdc.com>
References: <20260319232522.1867400-1-alistair.francis@wdc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::531;
 envelope-from=alistair23@gmail.com; helo=mail-pg1-x531.google.com
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

From: Frank Chang <frank.chang@sifive.com>

Implement txctrl.txen and rxctrl.rxen as follows:

* txctrl.txen
  The txen bit controls whether the Tx channel is active. When cleared,
  transmission of Tx FIFO contents is suppressed, and the txd pin is
  driven high.

* rxctrl.rxen:
  The rxen bit controls whether the Rx channel is active. When cleared,
  the state of the rxd pin is ignored, and no characters will be
  enqueued into the Rx FIFO.

Therefore, the Tx FIFO should not be dequeued when txctrl.txen is
cleared, and the Rx FIFO should not be enqueued when rxctrl.rxen is
cleared.

Signed-off-by: Frank Chang <frank.chang@sifive.com>
Reviewed-by: Alistair Francis <alistair.francis@wdc.com>
Message-ID: <20260312033201.1619554-2-frank.chang@sifive.com>
Signed-off-by: Alistair Francis <alistair.francis@wdc.com>
---
 include/hw/char/sifive_uart.h |  2 ++
 hw/char/sifive_uart.c         | 27 ++++++++++++++++++++-------
 2 files changed, 22 insertions(+), 7 deletions(-)

diff --git a/include/hw/char/sifive_uart.h b/include/hw/char/sifive_uart.h
index 414564b026..c78d9bd1fc 100644
--- a/include/hw/char/sifive_uart.h
+++ b/include/hw/char/sifive_uart.h
@@ -51,6 +51,8 @@ enum {
 
 #define SIFIVE_UART_TXFIFO_FULL    0x80000000
 
+#define SIFIVE_UART_TXEN(txctrl)        (txctrl & 0x1)
+#define SIFIVE_UART_RXEN(rxctrl)        (rxctrl & 0x1)
 #define SIFIVE_UART_GET_TXCNT(txctrl)   ((txctrl >> 16) & 0x7)
 #define SIFIVE_UART_GET_RXCNT(rxctrl)   ((rxctrl >> 16) & 0x7)
 
diff --git a/hw/char/sifive_uart.c b/hw/char/sifive_uart.c
index af17cf9a6c..3ce6a4ee76 100644
--- a/hw/char/sifive_uart.c
+++ b/hw/char/sifive_uart.c
@@ -78,6 +78,11 @@ static gboolean sifive_uart_xmit(void *do_not_use, GIOCondition cond,
         return G_SOURCE_REMOVE;
     }
 
+    /* Don't pop the FIFO if transmit is disabled. */
+    if (!SIFIVE_UART_TXEN(s->txctrl)) {
+        return G_SOURCE_REMOVE;
+    }
+
     /* Don't pop the FIFO in case the write fails */
     characters = fifo8_peek_bufptr(&s->tx_fifo,
                                    fifo8_num_used(&s->tx_fifo), &numptr);
@@ -106,11 +111,19 @@ static gboolean sifive_uart_xmit(void *do_not_use, GIOCondition cond,
     return G_SOURCE_REMOVE;
 }
 
-static void sifive_uart_write_tx_fifo(SiFiveUARTState *s, const uint8_t *buf,
-                                      int size)
+static void sifive_uart_trigger_tx_fifo(SiFiveUARTState *s)
 {
     uint64_t current_time = qemu_clock_get_ns(QEMU_CLOCK_VIRTUAL);
 
+    if (!timer_pending(s->fifo_trigger_handle)) {
+        timer_mod(s->fifo_trigger_handle, current_time +
+            TX_INTERRUPT_TRIGGER_DELAY_NS);
+    }
+}
+
+static void sifive_uart_write_tx_fifo(SiFiveUARTState *s, const uint8_t *buf,
+                                      int size)
+{
     if (size > fifo8_num_free(&s->tx_fifo)) {
         size = fifo8_num_free(&s->tx_fifo);
         qemu_log_mask(LOG_GUEST_ERROR, "sifive_uart: TX FIFO overflow.\n");
@@ -124,10 +137,7 @@ static void sifive_uart_write_tx_fifo(SiFiveUARTState *s, const uint8_t *buf,
         s->txfifo |= SIFIVE_UART_TXFIFO_FULL;
     }
 
-    if (!timer_pending(s->fifo_trigger_handle)) {
-        timer_mod(s->fifo_trigger_handle, current_time +
-                      TX_INTERRUPT_TRIGGER_DELAY_NS);
-    }
+    sifive_uart_trigger_tx_fifo(s);
 }
 
 static uint64_t
@@ -184,6 +194,9 @@ sifive_uart_write(void *opaque, hwaddr addr,
         return;
     case SIFIVE_UART_TXCTRL:
         s->txctrl = val64;
+        if (SIFIVE_UART_TXEN(s->txctrl) && !fifo8_is_empty(&s->tx_fifo)) {
+            sifive_uart_trigger_tx_fifo(s);
+        }
         return;
     case SIFIVE_UART_RXCTRL:
         s->rxctrl = val64;
@@ -231,7 +244,7 @@ static int sifive_uart_can_rx(void *opaque)
 {
     SiFiveUARTState *s = opaque;
 
-    return s->rx_fifo_len < sizeof(s->rx_fifo);
+    return SIFIVE_UART_RXEN(s->rxctrl) && (s->rx_fifo_len < sizeof(s->rx_fifo));
 }
 
 static void sifive_uart_event(void *opaque, QEMUChrEvent event)
-- 
2.53.0


