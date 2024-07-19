Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 39DABC3DA5D
	for <qemu-devel@archiver.kernel.org>; Fri, 19 Jul 2024 18:14:31 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sUs6O-0002vg-5q; Fri, 19 Jul 2024 14:13:08 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sUs5g-0006o1-37
 for qemu-devel@nongnu.org; Fri, 19 Jul 2024 14:12:30 -0400
Received: from mail-wm1-x32f.google.com ([2a00:1450:4864:20::32f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sUs5e-00042p-CD
 for qemu-devel@nongnu.org; Fri, 19 Jul 2024 14:12:23 -0400
Received: by mail-wm1-x32f.google.com with SMTP id
 5b1f17b1804b1-4266f344091so14865695e9.0
 for <qemu-devel@nongnu.org>; Fri, 19 Jul 2024 11:12:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1721412740; x=1722017540; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=/3cF/tU//YplS5nRyz5oLLMVLav+V+FPLOKof/J5MTo=;
 b=JuiUZf/2vEba1fg7Xw+gSyXcl3g/LCwHZise8u3g/cBs3rDGnUr1c5lpVCBBuOAstt
 v5B0/SRBcTokOTxIU9PaJTTDipO2IYtpZrEfoTHP2OBtq52N47BvauF5T1ck9BH2kLeZ
 p9Kv/oWIqDHzCqFJY7y+yBFQ+T7fR9/X3Oj0vJu5uH6mIt2f6lQ/rB3ER4ZhZpm5mf/C
 vrpimojRHiiaK3KxBPBgMmw4sov5WaoMvWHDcExRTIwx16Dketpu1x9OmUYD6NrIOGr+
 /PLxfjK5WZVuiuSaniLJWnX/OmqQQdTODUbBcf+6gbb3rkhhNGlqm822abjSzo34YpYG
 e3lg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1721412740; x=1722017540;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=/3cF/tU//YplS5nRyz5oLLMVLav+V+FPLOKof/J5MTo=;
 b=smzQrysEOj95zXeUTTRblPuulxjwTV2xS6J3WEmNBsCq48kNgvaGA6ge5J92/RPkDI
 xwNUH/xQPvUSw3ZrhmFE3UOUoMW8pINTGilu+VWQBxGkX13FzR8Q4AD6IHVwsEHFb9VL
 TKlXPyyxwjz7Yk4wkXqOGY5S6mlE8uozlEc9S9aJIxAyZkbJ/dytWWcdxDjGMfzHW/Un
 spyg3T8Bc+YV5VLkgLLWTrUgXCtSdf88WvRtCWTiFl4dQBtOk2rLJGUAgl5gi0SV4rJL
 oV2ZrnWmwT5lPhc4G9pFHUNKW5F9yJw3qmy31zJiaqbrmBJavrumzxlSh6kEfqjmZekv
 nj9A==
X-Gm-Message-State: AOJu0Yzh4ortMJmrpvXul620tIFU68LTP17PKG3UQSqnxaKyPYG5QFcv
 DzBqLv+4B+6U15Xk20Xmk0113MkXpJdnRRNg5VpGi46qv7mlx54Wqvg1On4bCV1FRFKE4LVev0D
 v
X-Google-Smtp-Source: AGHT+IGQkwbVcp4D8oKxdRtPoLQiC3jGXnrExIerD6OV6FKZNbP9aUTq/C3jX1Ze1T2q/jqwmQXFDQ==
X-Received: by 2002:a05:600c:c09:b0:426:640b:73d9 with SMTP id
 5b1f17b1804b1-427c2ca9070mr63116805e9.10.1721412739853; 
 Fri, 19 Jul 2024 11:12:19 -0700 (PDT)
Received: from localhost.localdomain (52.170.88.92.rev.sfr.net. [92.88.170.52])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-427d68fa0a6sm33549825e9.9.2024.07.19.11.12.18
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Fri, 19 Jul 2024 11:12:19 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 qemu-arm@nongnu.org, Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
 Tong Ho <tong.ho@amd.com>,
 Manos Pitsidianakis <manos.pitsidianakis@linaro.org>,
 Peter Maydell <peter.maydell@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH v5 15/16] hw/char/pl011: Drain TX FIFO when no backend
 connected
Date: Fri, 19 Jul 2024 20:10:40 +0200
Message-ID: <20240719181041.49545-16-philmd@linaro.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20240719181041.49545-1-philmd@linaro.org>
References: <20240719181041.49545-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32f;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x32f.google.com
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

When no character backend is connected, the PL011 frontend
just drains the FIFO.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 hw/char/pl011.c      | 13 +++++++++++++
 hw/char/trace-events |  1 +
 2 files changed, 14 insertions(+)

diff --git a/hw/char/pl011.c b/hw/char/pl011.c
index b8cde03f98..cfa3fd3da4 100644
--- a/hw/char/pl011.c
+++ b/hw/char/pl011.c
@@ -229,6 +229,13 @@ static void pl011_loopback_tx(PL011State *s, uint32_t value)
     pl011_fifo_rx_put(s, value);
 }
 
+static void pl011_drain_tx(PL011State *s)
+{
+    trace_pl011_fifo_tx_drain(fifo8_num_used(&s->xmit_fifo));
+    pl011_reset_tx_fifo(s);
+    s->rsr &= ~RSR_OE;
+}
+
 static gboolean pl011_xmit(void *do_not_use, GIOCondition cond, void *opaque)
 {
     PL011State *s = opaque;
@@ -242,6 +249,12 @@ static gboolean pl011_xmit(void *do_not_use, GIOCondition cond, void *opaque)
         qemu_log_mask(LOG_GUEST_ERROR, "PL011 data written to disabled TX UART\n");
     }
 
+    if (!qemu_chr_fe_backend_connected(&s->chr)) {
+        /* Instant drain the fifo when there's no back-end. */
+        pl011_drain_tx(s);
+        return G_SOURCE_REMOVE;
+    }
+
     data = fifo8_pop(&s->xmit_fifo);
     bytes_consumed = 1;
 
diff --git a/hw/char/trace-events b/hw/char/trace-events
index 4a9c0bd271..bf586ba664 100644
--- a/hw/char/trace-events
+++ b/hw/char/trace-events
@@ -63,6 +63,7 @@ pl011_fifo_rx_full(void) "RX FIFO now full, RXFF set"
 pl011_fifo_tx_put(uint8_t byte) "TX FIFO push char [0x%02x]"
 pl011_fifo_tx_xmit(int count) "TX FIFO pop %d chars"
 pl011_fifo_tx_overrun(void) "TX FIFO overrun"
+pl011_fifo_tx_drain(unsigned drained) "TX FIFO draining %u chars"
 pl011_baudrate_change(unsigned int baudrate, uint64_t clock, uint32_t ibrd, uint32_t fbrd) "new baudrate %u (clk: %" PRIu64 "hz, ibrd: %" PRIu32 ", fbrd: %" PRIu32 ")"
 
 # cmsdk-apb-uart.c
-- 
2.41.0


