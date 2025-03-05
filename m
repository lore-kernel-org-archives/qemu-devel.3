Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CA5FEC282D0
	for <qemu-devel@archiver.kernel.org>; Wed,  5 Mar 2025 01:30:27 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tpdV2-0003on-Fp; Tue, 04 Mar 2025 20:24:41 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tpdU9-0001iQ-Vp
 for qemu-devel@nongnu.org; Tue, 04 Mar 2025 20:23:46 -0500
Received: from mail-wr1-x435.google.com ([2a00:1450:4864:20::435])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tpdU7-000785-NZ
 for qemu-devel@nongnu.org; Tue, 04 Mar 2025 20:23:45 -0500
Received: by mail-wr1-x435.google.com with SMTP id
 ffacd0b85a97d-38f403edb4eso3753946f8f.3
 for <qemu-devel@nongnu.org>; Tue, 04 Mar 2025 17:23:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1741137822; x=1741742622; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=flZzPJvyMRfjjg+eGkch3F0VvTnr5vwIJOoCHfTrgLI=;
 b=NH5ah1M/6PA1SP+nhSAtD862QsGto/IoMrABa+++YLrHX94buabEEHlzZbaYfV7/Rm
 VAjDteZNC8Q5q7d8rIxm+bPD0YYYejjWXWFZYn8l3/GPntSQi0q+oxQ0915dydweRqOP
 ZPsNnvZ7ak7RBfPNFy1R22pwq2MzEBmfSX7Exk2razPwBmXIUJhBpgtj3k0aUE6Nb70q
 5YhsDB/c9A9mRjvMyMF5eDx9j7ZTMDPe7QT9yVcVlf1ANzayR16kIjqbZPXstQ7LiR9U
 d52GYhaz/SLSD60IoDXPwudNrunGK+O5O83X4J4IaDXAohX+xVG4HAvwu7+M0Vyy9f2e
 vBSg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1741137822; x=1741742622;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=flZzPJvyMRfjjg+eGkch3F0VvTnr5vwIJOoCHfTrgLI=;
 b=OW8NXAOx9EGqyKUsDyAzyaR+7Euf4y4gSjXc+lURnb4SLvCrl3xIxSK5bC7VhU9nyG
 AJunYPkYJ5nSNX3FJTzTXECnqCyRzgmfgbzugw+VZSNJ9aEAyEqBSgRTB3GS63sF0C4U
 8QI/+LYmg5Rg5g+Wu0mfHQZb2vA65SJEXa1Tl1HDBvy845qUXnfzwwOx+ro3neu9FUfl
 l6GGDH9MbvofChtEwbElAi9WzuvSD/f6RWOG2GhgSwaUW+0URz3Out53tGfxuzE6WdWv
 hPec6IEs4MMiZkp9tjSa/19uNaE+eIbgABBQbJr2CLPoIBskwer6YG81l5yiivTlL/1Z
 BDbQ==
X-Gm-Message-State: AOJu0Yz2CWBM4xWl33lNqno3xBWWZIgHWWMrjr4ySteAmdLxVQ2IrMRc
 N8z2lHJyB9nVVWW7I5UQj5Hn51bSv9+GP3TB3iBlVcRwCEeGj1jVi12bSrrlE+UsbLAKr8TE5ci
 epD0=
X-Gm-Gg: ASbGncvK+1tIhLUv/9wCyuMBTg9auHNq92VQ0GYhYkywv4KDedUZtog5JRPhUfvkdU/
 GYJLFgQA5Q12OlOd7Yb98ue7IHGsTdj6AzuZtjqZNBDnL2NA09jOKmkBGUQUuBIm6Vmi2HOpc9y
 Q06KewGU2n3DHvWak7q8gsm/gNuvZlX/68Bb6QuWzzPZHQBGhkr74HaygDJMrrPKrP4WjhT89xq
 VGfn42qRWmW071o/Zs7Nk0aKEr64JSr8II23Uu4aT7Ma+HUPjVmFVJ7qf4HTZUmRSFYOh0QO83r
 XuFIg4DdpsmcIM8gzm7gaOZLJvNEYd25O2N6rUOd0aDG2Bg9xTaluZ0nHyxx1wf38C44bjDGsdw
 tC6qWqm0IbatLYeoC8UU=
X-Google-Smtp-Source: AGHT+IEyOMOEsO1mGNDe2n9ctvOuojYYnZNsKyNiryZ5oPQSruFqhZNpgdrkFIg8iz8ZXqiJ50SpUw==
X-Received: by 2002:a05:6000:2ac:b0:38d:e48b:1766 with SMTP id
 ffacd0b85a97d-3911f726200mr554415f8f.6.1741137821811; 
 Tue, 04 Mar 2025 17:23:41 -0800 (PST)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-43bd426cd51sm2049175e9.6.2025.03.04.17.23.41
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Tue, 04 Mar 2025 17:23:41 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Luc Michel <luc.michel@amd.com>,
 Richard Henderson <richard.henderson@linaro.org>
Subject: [PULL 21/41] hw/char/pl011: Improve RX flow tracing events
Date: Wed,  5 Mar 2025 02:21:36 +0100
Message-ID: <20250305012157.96463-22-philmd@linaro.org>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250305012157.96463-1-philmd@linaro.org>
References: <20250305012157.96463-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::435;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x435.google.com
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
Reviewed-by: Alex Bennée <alex.bennee@linaro.org>
Reviewed-by: Luc Michel <luc.michel@amd.com>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Message-Id: <20250220092903.3726-4-philmd@linaro.org>
---
 hw/char/pl011.c      | 10 ++++++----
 hw/char/trace-events |  7 ++++---
 2 files changed, 10 insertions(+), 7 deletions(-)

diff --git a/hw/char/pl011.c b/hw/char/pl011.c
index 5bb83c54216..f7485e7c541 100644
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
@@ -498,12 +499,13 @@ static int pl011_can_receive(void *opaque)
         qemu_log_mask(LOG_GUEST_ERROR,
                       "PL011 receiving data on disabled RX UART\n");
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


