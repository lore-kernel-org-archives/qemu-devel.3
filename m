Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3D2F1C3DA5D
	for <qemu-devel@archiver.kernel.org>; Fri, 19 Jul 2024 18:14:39 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sUs5s-0007qX-0g; Fri, 19 Jul 2024 14:12:36 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sUs5U-00061H-KA
 for qemu-devel@nongnu.org; Fri, 19 Jul 2024 14:12:15 -0400
Received: from mail-wm1-x32e.google.com ([2a00:1450:4864:20::32e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sUs5R-00040Z-OZ
 for qemu-devel@nongnu.org; Fri, 19 Jul 2024 14:12:11 -0400
Received: by mail-wm1-x32e.google.com with SMTP id
 5b1f17b1804b1-4266ea6a488so16327295e9.1
 for <qemu-devel@nongnu.org>; Fri, 19 Jul 2024 11:12:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1721412728; x=1722017528; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=liDvD10Kju4SXJGwkPuAqGOs/WSuNz1hvgqWr6MAicc=;
 b=rGTHTFztX9peVezqgLUNuQ3CINe0RG9R7/jirrZK151gVRdEU7d41Fno9aS9dpyHSn
 bougTfEUlk+Uy1j89Nfk1Zb9WzxHOnJHZ4a8C9O9pZYLXhiva1/SbX930da/nv3dRJfI
 JsI1q2IOGYG4w8woukLGXgsZA1VoU+j8EXFeOesnzIdwKxUxB74vObW0fCHzoq8eP03n
 jAv+PHLuMktriPm4a5UNUYl99zzLBXG20Ra4zqxMTasOKT/z6C97Pn3XjbqQkxpqgRmm
 iyZJ6/RbEAIBzBqeO8tAWKl4dVLodsYRZ14xUytxI+tMdQUXcFDiyduwYLkjXWA3FRgb
 hfBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1721412728; x=1722017528;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=liDvD10Kju4SXJGwkPuAqGOs/WSuNz1hvgqWr6MAicc=;
 b=VYqrSTCsy707gMsyh5p5LqoFfErBDUZcY7ymwPOCQZ6Svy3vVtCr0iiddEUtWfZGLK
 QoxUd+lC6Yj1UbXxRmhx1LYJRPy+ZrWWCFPgLHp7O4bxwhWVO9XaJKmc48lVlhp+8Mu9
 QA98nA/Etub9qZp4/YZaUSU17f3cc3GbUgfTM6pH9bsDSxsokbijjtAqbeNbCjl8MN2s
 DN3L1XWJWznnTq+i5WIhNhp4Kp3AdEuh+JSwA6dnkzLelLAd2G81V+4SGNpBHIFFehwM
 xnYj+/zqOIyvc3E5NS6XuJB80NZI7zL/XpUehyYY2AeMgLl4HJi0V4hFIDkmnCo+PHTa
 qgkQ==
X-Gm-Message-State: AOJu0Yy+7Dy6Ep4p8M5y3cDjwjN0l1pDhCi0J/8AAzrxgsZsEkyqV0M9
 BkdEqjb6Rmm1JpWkhlL85lTgLyQQ2gUZ03dNujFJ8+5ChKmb1QT5d3VWR9seTR1hsMbYiyPRFx2
 7
X-Google-Smtp-Source: AGHT+IHWtTELjCDNtCSmmXDnKB84VYtaNnBUuuXv6AU6MMAO1IwggvgbxulY77NjjwDgREO0mtuUEg==
X-Received: by 2002:a05:600c:3595:b0:426:5c81:2538 with SMTP id
 5b1f17b1804b1-427c2cb8a05mr68634095e9.14.1721412727834; 
 Fri, 19 Jul 2024 11:12:07 -0700 (PDT)
Received: from localhost.localdomain (52.170.88.92.rev.sfr.net. [92.88.170.52])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-427d6929827sm33457315e9.34.2024.07.19.11.12.06
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Fri, 19 Jul 2024 11:12:07 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 qemu-arm@nongnu.org, Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
 Tong Ho <tong.ho@amd.com>,
 Manos Pitsidianakis <manos.pitsidianakis@linaro.org>,
 Peter Maydell <peter.maydell@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH v5 13/16] hw/char/pl011: Introduce pl011_xmit() as GSource
Date: Fri, 19 Jul 2024 20:10:38 +0200
Message-ID: <20240719181041.49545-14-philmd@linaro.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20240719181041.49545-1-philmd@linaro.org>
References: <20240719181041.49545-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32e;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x32e.google.com
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

Extract pl011_xmit() from pl011_write_txdata(). Use the
FIFO to pass the character to be transmitted.

Implement it using the FEWatchFunc prototype, since we want
to register it as GSource later. While the return value is
not yet used, we return G_SOURCE_REMOVE meaning the GSource
is removed from the main loop (because we only send one char).

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 hw/char/pl011.c      | 30 +++++++++++++++++++++++++-----
 hw/char/trace-events |  2 ++
 2 files changed, 27 insertions(+), 5 deletions(-)

diff --git a/hw/char/pl011.c b/hw/char/pl011.c
index 6519340b50..6394d6eb36 100644
--- a/hw/char/pl011.c
+++ b/hw/char/pl011.c
@@ -226,6 +226,28 @@ static void pl011_loopback_tx(PL011State *s, uint32_t value)
     pl011_fifo_rx_put(s, value);
 }
 
+static gboolean pl011_xmit(void *do_not_use, GIOCondition cond, void *opaque)
+{
+    PL011State *s = opaque;
+    int bytes_consumed;
+    uint8_t data;
+
+    data = fifo8_pop(&s->xmit_fifo);
+    bytes_consumed = 1;
+
+    /*
+     * XXX this blocks entire thread. Rewrite to use
+     * qemu_chr_fe_write and background I/O callbacks
+     */
+    qemu_chr_fe_write_all(&s->chr, &data, bytes_consumed);
+    trace_pl011_fifo_tx_xmit(bytes_consumed);
+    s->int_level |= INT_TX;
+
+    pl011_update(s);
+
+    return G_SOURCE_REMOVE;
+}
+
 static void pl011_write_txdata(PL011State *s, uint8_t data)
 {
     if (!(s->cr & CR_UARTEN)) {
@@ -235,12 +257,10 @@ static void pl011_write_txdata(PL011State *s, uint8_t data)
         qemu_log_mask(LOG_GUEST_ERROR, "PL011 data written to disabled TX UART\n");
     }
 
-    /* XXX this blocks entire thread. Rewrite to use
-     * qemu_chr_fe_write and background I/O callbacks */
-    qemu_chr_fe_write_all(&s->chr, &data, 1);
+    trace_pl011_fifo_tx_put(data);
     pl011_loopback_tx(s, data);
-    s->int_level |= INT_TX;
-    pl011_update(s);
+    fifo8_push(&s->xmit_fifo, data);
+    pl011_xmit(NULL, G_IO_OUT, s);
 }
 
 static uint32_t pl011_read_rxdata(PL011State *s)
diff --git a/hw/char/trace-events b/hw/char/trace-events
index 59e1f734a7..30d06a2383 100644
--- a/hw/char/trace-events
+++ b/hw/char/trace-events
@@ -60,6 +60,8 @@ pl011_write(uint32_t addr, uint32_t value, const char *regname) "addr 0x%03x val
 pl011_can_receive(uint32_t lcr, int read_count, int r) "LCR 0x%08x read_count %d returning %d"
 pl011_fifo_rx_put(uint32_t c, int read_count) "new char 0x%02x read_count now %d"
 pl011_fifo_rx_full(void) "RX FIFO now full, RXFF set"
+pl011_fifo_tx_put(uint8_t byte) "TX FIFO push char [0x%02x]"
+pl011_fifo_tx_xmit(int count) "TX FIFO pop %d chars"
 pl011_baudrate_change(unsigned int baudrate, uint64_t clock, uint32_t ibrd, uint32_t fbrd) "new baudrate %u (clk: %" PRIu64 "hz, ibrd: %" PRIu32 ", fbrd: %" PRIu32 ")"
 
 # cmsdk-apb-uart.c
-- 
2.41.0


