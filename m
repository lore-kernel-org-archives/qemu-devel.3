Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BC4E7C021AA
	for <qemu-devel@archiver.kernel.org>; Wed, 19 Feb 2025 21:12:04 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tkrJa-0001va-6X; Wed, 19 Feb 2025 16:09:06 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tkrJX-0001sY-Ez
 for qemu-devel@nongnu.org; Wed, 19 Feb 2025 16:09:03 -0500
Received: from mail-wm1-x334.google.com ([2a00:1450:4864:20::334])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tkrJV-0008Vj-Nf
 for qemu-devel@nongnu.org; Wed, 19 Feb 2025 16:09:03 -0500
Received: by mail-wm1-x334.google.com with SMTP id
 5b1f17b1804b1-4393dc02b78so1202525e9.3
 for <qemu-devel@nongnu.org>; Wed, 19 Feb 2025 13:09:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1739999340; x=1740604140; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=4FHsuKvW5lxqHnKhRd7Yijx1j/tjAzvjfWfwUFBfXHI=;
 b=AI6drNCz+OCGWjvsJ1ELqWheL4gN7Wzs1Bu97iNgZrjU5E5w6o9cqdRwQlhbXQEhA8
 5jbS1GY9pqwtmFOPnPc29miT5yTomY3Me3bs9Zg3MulUpe+wtK092iP07eUE3vo9SFsQ
 tnvNqAjn32miITLYjuoyyzkmM0hJFw4ga3CehxQd6WqcH9oB1KPEfnVffA3VKaGSddBL
 CmK1c7Gn8xqijJTUsgFvGMc8p0dDwOqdhbT+vqzSB9Bs49eOYIq5ZZUEzgLDHNDNj5gE
 sajESgQ7tRCU8hqpUlP/nig3RGCIzSoWIEeD9dC1oGSlcPJ06BfvZO0voL5xc2W/aHzy
 SWuw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1739999340; x=1740604140;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=4FHsuKvW5lxqHnKhRd7Yijx1j/tjAzvjfWfwUFBfXHI=;
 b=N/2WC8IRjJEXbdh3lwiRw2I9Si7O+Ih3HLG3tXxdOBySMGw8/YE/6iXNNghXzTEtcS
 Dw48umHcqImbT+ZKLKpDVki7rUMWXtSUxflIbJdU+XNe7Pw5sYzJigLy0pAUfwChkkZz
 NLaiRLGKgr8NGRAEtLmrCr2xpb26WcYz7QdM12HvsbGHIskQWhSvBXJPduz7AZV+JoWH
 +pKnRvRpQBYrwVoCCHPg42NBTxU4Ub/iggG4hE0aEejZbYXiLVYFInFi/DUBi0HGo6i6
 K5UpUmLvtCZSEhAWinMiNdtEdAsNkemz5kYMJZjKDAreFhhwqaOnU8ybZeDDOpIs3TjQ
 dMpQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCXwaHmIBJnTxDa5uSpWeyEpVKfRnT/NFfBcGESmHrn55uDPZ3HRFMx7syQC0otsBQKyLwyUxRavz4ZJ@nongnu.org
X-Gm-Message-State: AOJu0YyHYqYUhbbRtcfPxykSizBI2shOKrxNEs+iiJaDixRKPMtnI99+
 59rVpObIwwXPRd5v7bgHsPb6mzRpc+Jw7O/r5++MBTDTeQDi5a+wr0WrbjwD/82E6DvL8M/Sb0Y
 ImzQ=
X-Gm-Gg: ASbGncvh1qoTCQSlVRZje7xuMLXuhS8aTZA6AKji6oDgaFjQl37MVJJmpvy4wuWIGlU
 brPnwiVXeAu/l7aCJbb+1kXQbvNpEylzOfgXSJLmv0sFGuzXK61Zo8uiJYV8922znZHSDDWQtWm
 Sgw16OqmebIF06pj4iZIvwdS1b6rUkpjSklbZvw6AsyKY56agJfFGAccKZN/N8hBsNVAu8w6kR7
 DwcmuqkuDZBNcOGl95gF2hH7gaWBZ3H5mtddqJf/2I7jQtv4uGKTQP7pMnkriQALwew9GZTRK4f
 F5mpKn2KxwR+u1QIlS1+cVDE3dM0WzuMuDFrgakV/zVdSUZi6gvTviusrw/tnoDw6g==
X-Google-Smtp-Source: AGHT+IERTR1XiiAxvQUqcL7HgCAWEcqCxi9fc99r9lHG3vrUskwUdQLOHiIzY3gm4LBo+mMusZ7Jww==
X-Received: by 2002:a05:600c:3b1a:b0:439:9274:81ed with SMTP id
 5b1f17b1804b1-439927483e2mr72162935e9.1.1739999340068; 
 Wed, 19 Feb 2025 13:09:00 -0800 (PST)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-38f259f8730sm19267996f8f.93.2025.02.19.13.08.58
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Wed, 19 Feb 2025 13:08:59 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 qemu-devel@nongnu.org
Cc: Evgeny Iakovlev <eiakovlev@linux.microsoft.com>,
 Rayhan Faizel <rayhan.faizel@gmail.com>, Luc Michel <luc.michel@amd.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Yoshinori Sato <ysato@users.sourceforge.jp>,
 Magnus Damm <magnus.damm@gmail.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Thomas Huth <huth@tuxfamily.org>,
 Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-arm@nongnu.org
Subject: [PATCH 3/9] hw/char/pl011: Improve RX flow tracing events
Date: Wed, 19 Feb 2025 22:08:35 +0100
Message-ID: <20250219210841.94797-4-philmd@linaro.org>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250219210841.94797-1-philmd@linaro.org>
References: <20250219210841.94797-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::334;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x334.google.com
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

Log FIFO use (availability and depth).

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 hw/char/pl011.c      | 10 ++++++----
 hw/char/trace-events |  7 ++++---
 2 files changed, 10 insertions(+), 7 deletions(-)

diff --git a/hw/char/pl011.c b/hw/char/pl011.c
index bcd516d682d..148a7d0dc60 100644
--- a/hw/char/pl011.c
+++ b/hw/char/pl011.c
@@ -185,7 +185,7 @@ static void pl011_fifo_rx_put(void *opaque, uint32_t value)
     s->read_fifo[slot] = value;
     s->read_count++;
     s->flags &= ~PL011_FLAG_RXFE;
-    trace_pl011_fifo_rx_put(value, s->read_count);
+    trace_pl011_fifo_rx_put(value, s->read_count, pipe_depth);
     if (s->read_count == pipe_depth) {
         trace_pl011_fifo_rx_full();
         s->flags |= PL011_FLAG_RXFF;
@@ -248,12 +248,13 @@ static void pl011_write_txdata(PL011State *s, uint8_t data)
 static uint32_t pl011_read_rxdata(PL011State *s)
 {
     uint32_t c;
+    unsigned fifo_depth = pl011_get_fifo_depth(s);
 
     s->flags &= ~PL011_FLAG_RXFF;
     c = s->read_fifo[s->read_pos];
     if (s->read_count > 0) {
         s->read_count--;
-        s->read_pos = (s->read_pos + 1) & (pl011_get_fifo_depth(s) - 1);
+        s->read_pos = (s->read_pos + 1) & (fifo_depth - 1);
     }
     if (s->read_count == 0) {
         s->flags |= PL011_FLAG_RXFE;
@@ -261,7 +262,7 @@ static uint32_t pl011_read_rxdata(PL011State *s)
     if (s->read_count == s->read_trigger - 1) {
         s->int_level &= ~INT_RX;
     }
-    trace_pl011_read_fifo(s->read_count);
+    trace_pl011_read_fifo(s->read_count, fifo_depth);
     s->rsr = c >> 8;
     pl011_update(s);
     qemu_chr_fe_accept_input(&s->chr);
@@ -496,12 +497,13 @@ static int pl011_can_receive(void *opaque)
     if (!(s->cr & CR_RXE)) {
         qemu_log_mask(LOG_GUEST_ERROR, "PL011 reading data on disabled TX UART\n");
     }
-    trace_pl011_can_receive(s->lcr, s->read_count, r);
+    trace_pl011_can_receive(s->lcr, s->read_count, fifo_depth, fifo_available);
     return r;
 }
 
 static void pl011_receive(void *opaque, const uint8_t *buf, int size)
 {
+    trace_pl011_receive(size);
     /*
      * In loopback mode, the RX input signal is internally disconnected
      * from the entire receiving logics; thus, all inputs are ignored,
diff --git a/hw/char/trace-events b/hw/char/trace-events
index b2e3d25ae34..05a33036c12 100644
--- a/hw/char/trace-events
+++ b/hw/char/trace-events
@@ -60,12 +60,13 @@ imx_serial_put_data(const char *chrname, uint32_t value) "%s: 0x%" PRIx32
 # pl011.c
 pl011_irq_state(int level) "irq state %d"
 pl011_read(uint32_t addr, uint32_t value, const char *regname) "addr 0x%03x value 0x%08x reg %s"
-pl011_read_fifo(int read_count) "FIFO read, read_count now %d"
+pl011_read_fifo(unsigned rx_fifo_used, size_t rx_fifo_depth) "RX FIFO read, used %u/%zu"
 pl011_write(uint32_t addr, uint32_t value, const char *regname) "addr 0x%03x value 0x%08x reg %s"
-pl011_can_receive(uint32_t lcr, int read_count, int r) "LCR 0x%08x read_count %d returning %d"
-pl011_fifo_rx_put(uint32_t c, int read_count) "new char 0x%02x read_count now %d"
+pl011_can_receive(uint32_t lcr, unsigned rx_fifo_used, size_t rx_fifo_depth, unsigned rx_fifo_available) "LCR 0x%02x, RX FIFO used %u/%zu, can_receive %u chars"
+pl011_fifo_rx_put(uint32_t c, unsigned read_count, size_t rx_fifo_depth) "RX FIFO push char [0x%02x] %d/%zu depth used"
 pl011_fifo_rx_full(void) "RX FIFO now full, RXFF set"
 pl011_baudrate_change(unsigned int baudrate, uint64_t clock, uint32_t ibrd, uint32_t fbrd) "new baudrate %u (clk: %" PRIu64 "hz, ibrd: %" PRIu32 ", fbrd: %" PRIu32 ")"
+pl011_receive(int size) "recv %d chars"
 
 # cmsdk-apb-uart.c
 cmsdk_apb_uart_read(uint64_t offset, uint64_t data, unsigned size) "CMSDK APB UART read: offset 0x%" PRIx64 " data 0x%" PRIx64 " size %u"
-- 
2.47.1


