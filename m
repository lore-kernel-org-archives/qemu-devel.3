Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4DDE7FED2C4
	for <qemu-devel@archiver.kernel.org>; Thu, 12 Mar 2026 03:32:53 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w0Wme-0007Jw-OB; Wed, 11 Mar 2026 23:32:24 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <frank.chang@sifive.com>)
 id 1w0Wma-0007Fb-Oc
 for qemu-devel@nongnu.org; Wed, 11 Mar 2026 23:32:20 -0400
Received: from mail-wm1-x330.google.com ([2a00:1450:4864:20::330])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <frank.chang@sifive.com>)
 id 1w0WmY-00066W-JW
 for qemu-devel@nongnu.org; Wed, 11 Mar 2026 23:32:20 -0400
Received: by mail-wm1-x330.google.com with SMTP id
 5b1f17b1804b1-485345e1013so12290495e9.1
 for <qemu-devel@nongnu.org>; Wed, 11 Mar 2026 20:32:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sifive.com; s=google; t=1773286337; x=1773891137; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Ou9B4i7N9WVBHQU4lFuCxr1TRlnBVHCFmOECesKkzXU=;
 b=L7CTqbylBOpiuYEI5TkYXHFoIv8Lni6s3GxTzdZ2FcBQoc9qLpbZEwDIOtovo2O6bN
 IgICVMBcUupkn5qDjbVsYPwciFdVsx6gA8sV9glfhxPkAEYeZSWI2Q8liZPMB9hnznXT
 YnGWbz/I6dw6aR48mVKLw/+Rwanmj3tqk3VV18NUguqC218uKYH+mciADyQJ1ukNx0Ig
 QyFe4q03aa2HRvw+YJoA/ixvNa2j4POYRpCLWhFAy3tRFci1zjjzWxBpSAdz2rk5kh2Q
 0yDBzfaVVb925XGQakubiU7sbHvBprMHVCUmEN8wMa4FHS2o0tBpyrtyun6YQslRGuw0
 ob0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1773286337; x=1773891137;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=Ou9B4i7N9WVBHQU4lFuCxr1TRlnBVHCFmOECesKkzXU=;
 b=D5VQs8RKVblHuBHyZkjjfkj9AMJPLmkG0jMzmBldc+szEqMdSxTJBWD7ID6QDmqq+0
 yhXwDMWrU2PopzS0BliaOBTRDGqcXnCbQM84uxbVLCDdiLrA/r250S3Y5mHuBt6M4pLT
 f+SJL0+PhfVb5XlZOvlZQQv21gXLqBNNPVnlhxXyibbJbIFQQhgLLWrY1RkNHNjWDpfU
 /AjCPHeK8BS2D/gWGmXDuzaF+u/LuOsenfIGl0XlXTtuRuGWvQ/9N9wI4mhHM/KGVcf2
 Y6OfU7WRVP807XkDND/VcW3blsbEFP7xfsCcYleeIHzM3P8Lm/CxP91hWUgaxfO75iBZ
 oMtQ==
X-Gm-Message-State: AOJu0YxoHp695v96kk9QCSEotOvIXwT9TUjz6MndABr8jb0kxsoLbNy2
 LogcAX3/Nw7u7xAJ5w7aAy6jsnDQ77ZpEpzI/1ZI1tl1RwuzPAeTyzTne898lsHHlmHx0PlvKDI
 86ADOCP+Q8veDDTymCxnMc3Q5UitcfFKDZRhGSMGl6gVp2oVCRcTMFODdSOBqrV38R6EPMBNh49
 2GnCQIJgaLpyictBLRRI+MC7FweepEIk6C9wT7U6glUlyYXA==
X-Gm-Gg: ATEYQzz19XyGAFA28Lyg6HnDtR4pPbDpz0X6X5Lnfmg2gp99EPSCGhDT07qWYcG/GPt
 v5glbirXtHadnZhM8KYAEYs7F4P7gVR9ITA8J/5TOgg0DVd5GufWYT//ymx4kty736dQQldnx7x
 DEv7PsLT3lUwgnubZjUNp78Huf/WVE3yUyuG4u96SaEFp7c6xYjNctwfSbbDntbKIf83Su+k5rj
 ATbSRZh0j+/CT70Q/L0djDt2JhiFIqqGz7SQEQyechva9uY7M0mFYJpylbiOIYMV8yoeUNE/dvI
 JKIZ7qQJwyBm7qQdn+VewHp/NXHDJVifWF2c4nfFC323+xhkMC5Z1dylBFhjBUr7ND84CxVHvYl
 kLIKjqJSrdluh5dJ8tZPC2v+QAnn7SrxAMktoZCYHWVb2epJR8dpeUxnMRtwzHnXgLkD2RguJp3
 XrVC4lEQvB1zseFP9up13L+fQG1CVAFQjldX7sgpO7I/mV7Is3OQ==
X-Received: by 2002:a05:600c:4e8e:b0:485:3f58:da2 with SMTP id
 5b1f17b1804b1-4854f59f546mr28300595e9.16.1773286336846; 
 Wed, 11 Mar 2026 20:32:16 -0700 (PDT)
Received: from hsinchu16.internal.sifive.com ([210.176.154.34])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4854b5f6bb4sm94807735e9.4.2026.03.11.20.32.14
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 11 Mar 2026 20:32:16 -0700 (PDT)
From: frank.chang@sifive.com
To: qemu-devel@nongnu.org
Cc: Alistair Francis <Alistair.Francis@wdc.com>,
 Palmer Dabbelt <palmer@dabbelt.com>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 qemu-riscv@nongnu.org (open list:SiFive Machines),
 Frank Chang <frank.chang@sifive.com>
Subject: [PATCH v3 1/4] hw/char: sifive_uart: Implement txctrl.txen and
 rxctrl.rxen
Date: Thu, 12 Mar 2026 11:31:58 +0800
Message-ID: <20260312033201.1619554-2-frank.chang@sifive.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260312033201.1619554-1-frank.chang@sifive.com>
References: <20260312033201.1619554-1-frank.chang@sifive.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::330;
 envelope-from=frank.chang@sifive.com; helo=mail-wm1-x330.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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
---
 hw/char/sifive_uart.c         | 27 ++++++++++++++++++++-------
 include/hw/char/sifive_uart.h |  2 ++
 2 files changed, 22 insertions(+), 7 deletions(-)

diff --git a/hw/char/sifive_uart.c b/hw/char/sifive_uart.c
index af17cf9a6ce..3ce6a4ee76a 100644
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
diff --git a/include/hw/char/sifive_uart.h b/include/hw/char/sifive_uart.h
index 414564b0266..c78d9bd1fc6 100644
--- a/include/hw/char/sifive_uart.h
+++ b/include/hw/char/sifive_uart.h
@@ -51,6 +51,8 @@ enum {
 
 #define SIFIVE_UART_TXFIFO_FULL    0x80000000
 
+#define SIFIVE_UART_TXEN(txctrl)        (txctrl & 0x1)
+#define SIFIVE_UART_RXEN(rxctrl)        (rxctrl & 0x1)
 #define SIFIVE_UART_GET_TXCNT(txctrl)   ((txctrl >> 16) & 0x7)
 #define SIFIVE_UART_GET_RXCNT(rxctrl)   ((rxctrl >> 16) & 0x7)
 
-- 
2.43.0


