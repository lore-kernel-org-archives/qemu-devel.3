Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0E555D3B7FF
	for <qemu-devel@archiver.kernel.org>; Tue,  9 Dec 2025 16:03:02 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vT09o-0003cm-4R; Tue, 09 Dec 2025 11:01:44 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <frank.chang@sifive.com>)
 id 1vT09e-0003Zs-E1
 for qemu-devel@nongnu.org; Tue, 09 Dec 2025 11:01:34 -0500
Received: from mail-pf1-x42f.google.com ([2607:f8b0:4864:20::42f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <frank.chang@sifive.com>)
 id 1vT09c-0003qX-J6
 for qemu-devel@nongnu.org; Tue, 09 Dec 2025 11:01:33 -0500
Received: by mail-pf1-x42f.google.com with SMTP id
 d2e1a72fcca58-7b7828bf7bcso6641701b3a.2
 for <qemu-devel@nongnu.org>; Tue, 09 Dec 2025 08:01:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sifive.com; s=google; t=1765296090; x=1765900890; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=lF2fu4z2XG02l76l/IsUrBTfEhGWyD0UfOXyu3FKewU=;
 b=Nbt28RdlHzXH84zxGP36OsQLSc+74KllD2w3hFTzAozPTn6sXG1O/canB2j7rtNS97
 EpH8ELTYo55X1xUDM/ItimIIuvV3GxLRXjfYA1BDlzOnprERzpaqO/W9ndw45GRG/tT5
 CA2JjlfUibEGfOhSlimNQyqMd3UAAuyQzx0+mqzcJxGuUExb6iGlT03qkA1VFwPz0myN
 dYQ0ulfmzh00yaSURw8Jo9nS2eUI88d1dSx3noPF2VTRmA3bbzYPO7PjBge4E0K8JUoJ
 2d38HpqU4qi6fDHWQHHJ/ujTVYW1QFyMDDLSy0tmpS/yixpgzYHkAVfDeYYEGsueyKHl
 kCFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1765296090; x=1765900890;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=lF2fu4z2XG02l76l/IsUrBTfEhGWyD0UfOXyu3FKewU=;
 b=rCEXeuUzLqdDXGGtih2oWeyM/ES/aERaPiPg/fMrORV+YiwX6H1CzTmSew71n5VGCN
 tNpY2v11heL4nERLEwMmnek0gpcO73fW0WS28ph8UFxnmNuMqDdrJOmAHbzMUMilAFqD
 olxnllHin+sg01/FE14ZapCpV85Vb4ZS9V7cdulllXKScSteHdw1eIkAGkEK22mgV+iV
 2dObenT86XmErDSoiAyOgd76y+8cpb/o+BRyeCKwcjXGinvR+6xyiA4ekLkirBLgZ8T6
 Vr+d5rllX73wfocqRdsMDzLDVOD+SgXTSyRw6b21OXfSuJioXveV/gRsC/F3SaQ/Y3jH
 y4+w==
X-Gm-Message-State: AOJu0YxGBxXuUikzDvD/OZR8vmfbqdoSZfKIc0ojupGO33Or6vT2iGzO
 TGsWPhBccdN52DRvj52Eea7EDE9q+r2bqU5wP6sKqMsp4tA2mmvHwbAbk6ABbHEqIZOw/m61UyS
 rGC7SHTxIaJx41MUaWFYR3VgUo+La1IaAnfbet+nPgqOXoyNRGJ/zOFVsVhEQuViP71Ki4O4tDW
 3rn2nQ/iVzRLfk06gtd29qn3q6qQEqRiKzmWJO785k8s4=
X-Gm-Gg: ASbGncu1uUVVjddUGdcpEXKeauPyQIz2XBsNeKLFvU7WridpTboLVJzP/sUcsP3wwnX
 NHTgDyad9pFtEcCtYmc+TOpyZbfCLQh3hwQbBe1htszczN37YGwe9uxfJ0jgYQ9W8Dkmyi6lOWC
 e8FleYPopWang63mScOSWqj+1fjcStUzUsAKdVsuhfoIkY+YFe3S3lFpqlHK8+GqE+VfRleThLZ
 8zovttELLVU8qZiK1jLoPMSz1rv0MTJC1P0UdNWrzbe5U9QZag7lVGDz3YppAx+UHwL0tJsN6Ub
 628qU29NiVSPnQPh+K00OQlfHs6pINX1EGSXzEA2v75ChLO4M8i8fbklwDyqXgy6xCR5d3ESKXJ
 /kM2TZXzs3BKclTta5whd4ayS0gYqiMoqE8dOxtqRrCXJXxWFJj/tjBGYUrwyYXIJLsLWGO2KrE
 Uw0PpdVJjfC0WU80coPWHyYiAlDsKS5rJiHoblig==
X-Google-Smtp-Source: AGHT+IE+od/9o9LMlSLtdHhfpHVoW+3tGODFBffy9J0MnyK4HtdzkF05zt6I+0zduKb5hNWG2x3m3w==
X-Received: by 2002:a05:6a00:1812:b0:7b9:dbf2:3bae with SMTP id
 d2e1a72fcca58-7e8c1c30b46mr13082604b3a.24.1765296088538; 
 Tue, 09 Dec 2025 08:01:28 -0800 (PST)
Received: from hsinchu16.internal.sifive.com ([210.176.154.34])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-7e29ff6c68csm16475242b3a.19.2025.12.09.08.01.25
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 09 Dec 2025 08:01:28 -0800 (PST)
From: frank.chang@sifive.com
To: qemu-devel@nongnu.org
Cc: Alistair Francis <Alistair.Francis@wdc.com>,
 Palmer Dabbelt <palmer@dabbelt.com>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 qemu-riscv@nongnu.org (open list:SiFive Machines),
 Frank Chang <frank.chang@sifive.com>
Subject: [PATCH v2 1/4] hw/char: sifive_uart: Implement txctrl.txen and
 rxctrl.rxen
Date: Wed, 10 Dec 2025 00:01:14 +0800
Message-ID: <20251209160117.1239596-2-frank.chang@sifive.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20251209160117.1239596-1-frank.chang@sifive.com>
References: <20251209160117.1239596-1-frank.chang@sifive.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::42f;
 envelope-from=frank.chang@sifive.com; helo=mail-pf1-x42f.google.com
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
index e7357d585a1..4a54dd52a1e 100644
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
index 6486c3f4a5d..e216cacf693 100644
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


