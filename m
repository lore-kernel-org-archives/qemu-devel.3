Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4F21DC3DA5D
	for <qemu-devel@archiver.kernel.org>; Fri, 19 Jul 2024 18:13:17 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sUs6R-0003VL-6Z; Fri, 19 Jul 2024 14:13:11 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sUs5m-0007Bn-I4
 for qemu-devel@nongnu.org; Fri, 19 Jul 2024 14:12:32 -0400
Received: from mail-wm1-x32a.google.com ([2a00:1450:4864:20::32a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sUs5j-00043c-H1
 for qemu-devel@nongnu.org; Fri, 19 Jul 2024 14:12:30 -0400
Received: by mail-wm1-x32a.google.com with SMTP id
 5b1f17b1804b1-4266edee10cso13012035e9.2
 for <qemu-devel@nongnu.org>; Fri, 19 Jul 2024 11:12:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1721412746; x=1722017546; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=e/ZQe/yHYS+wM7PLPDCR+wv5t4w+2k62yQLSsqaNg4w=;
 b=Ema5H3bBaCIiunby+hOcZuy9QZbFih2im+s00sAymMZBarnlQUsYk9SiucY/XCdMRS
 J3dW6jgBzRQprroy9tNv3/gilmIhvX6LlNKuST6cvZeGdzGdIKmVa4UvYlqMjiuTeZsZ
 6YaXebypWCXWe5Fw+QtQZQ9CF46JzNgPBdKme00q43FeYylJYaPUYDG9GgJ/Vvp6FzJj
 K9mtqJ7XyPPYuW0wdT3HCEReYaV0wMpUU2AzMnJ5e7CuJR5mgCk3rtiWpwUfRj3So7gl
 lEbOlXdrUP36gBd1OYjiTM393qlRT3LEFM3WEQDrkIZFcpR1+X7o/htSb88mQaHJ25zi
 PKAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1721412746; x=1722017546;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=e/ZQe/yHYS+wM7PLPDCR+wv5t4w+2k62yQLSsqaNg4w=;
 b=bFuYEtVyw6bRhOoN0UvFyJMTbBj49yDY3tI5YWsdJrvuEpaXNagct49BlJS6Kz7i7I
 V7b/DiHgUfMq9NraxzAyoXNMvzcr7devv6AXmnc5CI/3ShRwtNUQgcwBAgVGdP1IVP6b
 v5oo1Dw4yV59cIwB3gFa+ThHEbVgY2LWLYjhsjv92Mbt89eg2UvoyYUhwmhMt+6YAe6g
 NpOhuuN9JQshudidORMQjWTm1M2irJWnut1gM9Lmhhdroqdzm+HtV9QahhTdIEGDcBOB
 pC1f5LwK1u42qbh9ULgfLLTta1iM76l7UPWzJ7gOv5Px9GzJLM4J2WevKvAI2kcYyqev
 UztQ==
X-Gm-Message-State: AOJu0Ywbrxgew6tELksbjQf9WrZm69f8FIaFT9W4sLvxCUAbCdGNvFqw
 7c5PWFNeGd2Lfr4xsbanwoRUcKqvxMbjX+0W+F/w15nvJUDX2ywIv4YHzxN1T9ACHCnqx9Tdtp/
 f
X-Google-Smtp-Source: AGHT+IEka99OAZtI0h2En3VRTvDYiJuupj8PiTozQteCkvzdFJ54IYUgWSRstsrhskAVbkyoUotZwg==
X-Received: by 2002:a05:600c:19cd:b0:427:dac4:d36 with SMTP id
 5b1f17b1804b1-427dac4132fmr1307245e9.7.1721412745794; 
 Fri, 19 Jul 2024 11:12:25 -0700 (PDT)
Received: from localhost.localdomain (52.170.88.92.rev.sfr.net. [92.88.170.52])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-427d6929976sm33385325e9.29.2024.07.19.11.12.24
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Fri, 19 Jul 2024 11:12:25 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 qemu-arm@nongnu.org, Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
 Tong Ho <tong.ho@amd.com>,
 Manos Pitsidianakis <manos.pitsidianakis@linaro.org>,
 Peter Maydell <peter.maydell@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Mikko Rapeli <mikko.rapeli@linaro.org>
Subject: [RFC PATCH v5 16/16] hw/char/pl011: Implement TX FIFO
Date: Fri, 19 Jul 2024 20:10:41 +0200
Message-ID: <20240719181041.49545-17-philmd@linaro.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20240719181041.49545-1-philmd@linaro.org>
References: <20240719181041.49545-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32a;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x32a.google.com
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

If the UART back-end chardev doesn't drain data as fast as stdout
does or blocks, buffer in the TX FIFO to try again later.

This avoids having the IO-thread busy waiting on chardev back-ends,
reported recently when testing the Trusted Reference Stack and
using the socket backend.

Implement registering a front-end 'watch' callback on back-end
events, so we can resume transmitting when the back-end is writable
again, not blocking the main loop.

Similarly to the RX FIFO path, FIFO level selection is not
implemented (interrupt is triggered when a single byte is available
in the FIFO).

Reported-by: Mikko Rapeli <mikko.rapeli@linaro.org>
Suggested-by: Alex Bennée <alex.bennee@linaro.org>
Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
RFC: Something is still broken, some characters are emitted async...
---
 hw/char/pl011.c      | 60 ++++++++++++++++++++++++++++++++++++--------
 hw/char/trace-events |  1 +
 2 files changed, 51 insertions(+), 10 deletions(-)

diff --git a/hw/char/pl011.c b/hw/char/pl011.c
index cfa3fd3da4..9f72b6a765 100644
--- a/hw/char/pl011.c
+++ b/hw/char/pl011.c
@@ -240,7 +240,9 @@ static gboolean pl011_xmit(void *do_not_use, GIOCondition cond, void *opaque)
 {
     PL011State *s = opaque;
     int bytes_consumed;
-    uint8_t data;
+    const uint8_t *buf;
+    uint32_t buflen;
+    uint32_t count;
 
     if (!(s->cr & CR_UARTEN)) {
         qemu_log_mask(LOG_GUEST_ERROR, "PL011 data written to disabled UART\n");
@@ -249,25 +251,40 @@ static gboolean pl011_xmit(void *do_not_use, GIOCondition cond, void *opaque)
         qemu_log_mask(LOG_GUEST_ERROR, "PL011 data written to disabled TX UART\n");
     }
 
+    count = fifo8_num_used(&s->xmit_fifo);
+    if (count < 1) {
+        /* FIFO empty */
+        return G_SOURCE_REMOVE;
+    }
+
     if (!qemu_chr_fe_backend_connected(&s->chr)) {
         /* Instant drain the fifo when there's no back-end. */
         pl011_drain_tx(s);
         return G_SOURCE_REMOVE;
     }
 
-    data = fifo8_pop(&s->xmit_fifo);
-    bytes_consumed = 1;
+    buf = fifo8_peek_buf(&s->xmit_fifo, count, &buflen);
 
-    /*
-     * XXX this blocks entire thread. Rewrite to use
-     * qemu_chr_fe_write and background I/O callbacks
-     */
-    qemu_chr_fe_write_all(&s->chr, &data, bytes_consumed);
+    /* Transmit as much data as we can. */
+    bytes_consumed = qemu_chr_fe_write(&s->chr, buf, buflen);
     trace_pl011_fifo_tx_xmit(bytes_consumed);
+    if (bytes_consumed < 0) {
+        /* Error in back-end: drain the fifo. */
+        pl011_drain_tx(s);
+        return G_SOURCE_REMOVE;
+    }
+
+    /* Pop the data we could transmit. */
+    fifo8_pop_buf(&s->xmit_fifo, bytes_consumed, NULL);
     s->int_level |= INT_TX;
 
     pl011_update(s);
 
+    if (!fifo8_is_empty(&s->xmit_fifo)) {
+        /* Reschedule another transmission if we couldn't transmit all. */
+        return G_SOURCE_CONTINUE;
+    }
+
     return G_SOURCE_REMOVE;
 }
 
@@ -290,6 +307,10 @@ static void pl011_write_txdata(PL011State *s, uint8_t data)
     trace_pl011_fifo_tx_put(data);
     pl011_loopback_tx(s, data);
     fifo8_push(&s->xmit_fifo, data);
+    if (fifo8_is_full(&s->xmit_fifo)) {
+        s->flags |= PL011_FLAG_TXFF;
+    }
+
     pl011_xmit(NULL, G_IO_OUT, s);
 }
 
@@ -488,10 +509,24 @@ static void pl011_write(void *opaque, hwaddr offset,
         pl011_trace_baudrate_change(s);
         break;
     case 11: /* UARTLCR_H */
-        /* Reset the FIFO state on FIFO enable or disable */
         if ((s->lcr ^ value) & LCR_FEN) {
-            pl011_reset_rx_fifo(s);
+            bool fifo_enabled = value & LCR_FEN;
+
+            trace_pl011_fifo_enable(fifo_enabled);
+            if (fifo_enabled) {
+                /* Transmit and receive FIFO buffers are enabled (FIFO mode). */
+                fifo8_change_capacity(&s->xmit_fifo, PL011_FIFO_DEPTH);
+            } else {
+                /*
+                 * FIFOs are disabled (character mode) that is, the FIFOs
+                 * become 1-byte-deep holding registers.
+                 */
+                pl011_drain_tx(s);
+                fifo8_change_capacity(&s->xmit_fifo, 1);
+            }
+            /* Reset the FIFO state on FIFO enable or disable */
             pl011_reset_tx_fifo(s);
+            pl011_reset_rx_fifo(s);
         }
         if ((s->lcr ^ value) & LCR_BRK) {
             int break_enable = value & LCR_BRK;
@@ -636,6 +671,11 @@ static int pl011_post_load(void *opaque, int version_id)
         s->read_pos = 0;
     }
 
+    if (!fifo8_is_empty(&s->xmit_fifo)) {
+        /* Reschedule another transmission */
+        qemu_chr_fe_add_watch(&s->chr, G_IO_OUT | G_IO_HUP, pl011_xmit, s);
+    }
+
     s->ibrd &= IBRD_MASK;
     s->fbrd &= FBRD_MASK;
 
diff --git a/hw/char/trace-events b/hw/char/trace-events
index bf586ba664..2405819812 100644
--- a/hw/char/trace-events
+++ b/hw/char/trace-events
@@ -58,6 +58,7 @@ pl011_read(uint32_t addr, uint32_t value, const char *regname) "addr 0x%03x valu
 pl011_read_fifo(int read_count) "FIFO read, read_count now %d"
 pl011_write(uint32_t addr, uint32_t value, const char *regname) "addr 0x%03x value 0x%08x reg %s"
 pl011_can_receive(uint32_t lcr, int read_count, int r) "LCR 0x%08x read_count %d returning %d"
+pl011_fifo_enable(bool enable) "enable:%u"
 pl011_fifo_rx_put(uint32_t c, int read_count) "new char 0x%02x read_count now %d"
 pl011_fifo_rx_full(void) "RX FIFO now full, RXFF set"
 pl011_fifo_tx_put(uint8_t byte) "TX FIFO push char [0x%02x]"
-- 
2.41.0


