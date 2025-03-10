Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8FBA9C28B28
	for <qemu-devel@archiver.kernel.org>; Mon, 10 Mar 2025 01:29:22 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1trRx9-0004GF-3L; Sun, 09 Mar 2025 21:29:11 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1trRx7-0004G1-HS
 for qemu-devel@nongnu.org; Sun, 09 Mar 2025 21:29:09 -0400
Received: from mail-wr1-x432.google.com ([2a00:1450:4864:20::432])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1trRx5-0006VM-Qx
 for qemu-devel@nongnu.org; Sun, 09 Mar 2025 21:29:09 -0400
Received: by mail-wr1-x432.google.com with SMTP id
 ffacd0b85a97d-3913b539aabso713521f8f.2
 for <qemu-devel@nongnu.org>; Sun, 09 Mar 2025 18:29:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1741570146; x=1742174946; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Rrde3KHLzAFDrcctuuOnFTDDeYEo7R3jlkMLF4h0mXs=;
 b=h+1t1WNCzB1E2JtC0Hswyfgt7C2qX2aUCbB7oQO/hyAoPLJTdKM3pYjHImRW/CK9Ey
 26zDRlqyzSToMlFfc3iffPYEEyYFd84PzzzYonbLDdtira5fKPwx+fvbJ9mGEvBc6ygV
 wXzLnDfz4ngHx5DyXDcQ6pbSZrP51G7volD5r4hfF6d0nFP/q4DjrwlFfF2BwPYJr1Ks
 p5dS0lPljXplffgIAPEGAFezCQlW7j8we+jgRtf6wmPJNxs5hMJBo8mSqBgfjqcu7lUi
 hZC57rqLnbrQZ3P3sUwM3Q/OGnzGo9jmGCQKH24B3XW3zFWXBkdRcrDB9c+4u4Ft+oqc
 9JxA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1741570146; x=1742174946;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Rrde3KHLzAFDrcctuuOnFTDDeYEo7R3jlkMLF4h0mXs=;
 b=Y3My6Hksqz4YhB+aXR3a4NaIcn+EFCebJsm/ja+zxcTaBaO+yspb0Y6CDse4e8W4sC
 RdBr5fYQSWTeuMU9IisURy3Hp4vcU9EyZe/6UzJc72k7Uq3gozRiZzBrv52Lhly/NcHd
 j7A5J+7Ek9WBwR7+I/YQX21DuijEV3kNDxK2Oo+HkWJt4FjLlTnXKIPvDuMT6YP3BiAS
 ka1tL7e52+qcbwxZYSKzcEN/v3zR+bI02bnxK4X+9JVghWcNWRddApKJ3JxzBnN3kYgi
 iiJ4HQ5BEj6AuKXK4pjdK2W+6FOdB4S6c20kkSXwucSxtyWkyUQZQYRjCovPkoNNilrp
 5jnw==
X-Gm-Message-State: AOJu0Yw5HpWeK1riyyf/TsVwEJZfO7n34q+gl9jRP05Sd20spTFq6JLZ
 z9/ywVKMG3Fg0veHLPCWbNeLnJFi6zmiKUL2CqJeADPvIx/y4jIhTY/kWUNaOiLz/ABQuhQFIRX
 D+f0=
X-Gm-Gg: ASbGncttuwgA/ugriv/zDNLwCmZGQbe7Lo18T2Ee7mk7tJD6M8zR38UaMvinUpZpMLt
 4Uz4wHXZt/jcWEPomoBsYJgJXQ8SOgNuIRwqFR/SFySIuc/quRq0yIlV1uj3igZv8zILIet0pnd
 QgbbocGXu8e+/o2oN+P/MjQd5cn9jOpLnFdxFIexLdbuV3qaFzsZhHwtipGlRy87kvwg4W2QYbP
 lOm711piSmc+Q77hHThisS1eKzemeKiMdrJrw8PP2fhccU2wjzskpmZTGKeGJQvb7udc0T5delh
 mbjfPFhY0ok6aAe/CTZ21mxWlmcnbqa++Yr6hfPg9BN0ujT8FDybMSlFFbpZTzyseblYTLOcFgv
 ocyPVTjsRHq+sKj/gBnc=
X-Google-Smtp-Source: AGHT+IEjjbNUd/fjjVs/TgqBs+38DGmL924XOhJ7YZDqRqjfyUSLEZxaWX1770a0FruR1ihuojC2sA==
X-Received: by 2002:a05:6000:402a:b0:391:2fe3:24ec with SMTP id
 ffacd0b85a97d-39132d3c1a9mr7994487f8f.14.1741570145997; 
 Sun, 09 Mar 2025 18:29:05 -0700 (PDT)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3912bfe0004sm13025061f8f.40.2025.03.09.18.29.04
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Sun, 09 Mar 2025 18:29:04 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>, qemu-arm@nongnu.org,
 Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Mikko Rapeli <mikko.rapeli@linaro.org>
Subject: [PATCH v7 7/7] hw/char/pl011: Implement TX FIFO
Date: Mon, 10 Mar 2025 02:28:25 +0100
Message-ID: <20250310012825.79614-8-philmd@linaro.org>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250310012825.79614-1-philmd@linaro.org>
References: <20250310012825.79614-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::432;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x432.google.com
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
Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 hw/char/pl011.c      | 35 +++++++++++++++++++++++++++--------
 hw/char/trace-events |  1 +
 2 files changed, 28 insertions(+), 8 deletions(-)

diff --git a/hw/char/pl011.c b/hw/char/pl011.c
index 6d26a3e13f8..d93cd8b3f0e 100644
--- a/hw/char/pl011.c
+++ b/hw/char/pl011.c
@@ -258,6 +258,10 @@ static gboolean pl011_xmit_cb(void *do_not_use, GIOCondition cond, void *opaque)
 
     count = fifo8_num_used(&s->xmit_fifo);
     trace_pl011_fifo_tx_xmit_used(count);
+    if (count < 1) {
+        /* FIFO empty */
+        return G_SOURCE_REMOVE;
+    }
 
     if (!qemu_chr_fe_backend_connected(&s->chr)) {
         /* Instant drain the fifo when there's no back-end. */
@@ -265,15 +269,23 @@ static gboolean pl011_xmit_cb(void *do_not_use, GIOCondition cond, void *opaque)
         return G_SOURCE_REMOVE;
     }
 
-    buf[0] = fifo8_pop(&s->xmit_fifo);
-    bytes_consumed = 1;
+    count = fifo8_peek_buf(&s->xmit_fifo, buf, fifo8_num_used(&s->xmit_fifo));
+    trace_pl011_fifo_tx_xmit_peek(count);
 
-    /*
-     * XXX this blocks entire thread. Rewrite to use
-     * qemu_chr_fe_write and background I/O callbacks
-     */
-    qemu_chr_fe_write_all(&s->chr, buf, bytes_consumed);
+    /* Transmit as much data as we can. */
+    bytes_consumed = qemu_chr_fe_write(&s->chr, buf, count);
     trace_pl011_fifo_tx_xmit_consumed(bytes_consumed);
+    if (bytes_consumed < 0) {
+        /* Error in back-end: drain the fifo. */
+        pl011_drain_tx(s);
+        return G_SOURCE_REMOVE;
+    } else if (bytes_consumed == 0) {
+        /* Couldn't send anything, try again later */
+        return G_SOURCE_CONTINUE;
+    }
+
+    /* Pop the data we could transmit. */
+    fifo8_drop(&s->xmit_fifo, bytes_consumed);
     s->int_level |= INT_TX;
     s->flags &= ~PL011_FLAG_TXFF;
 
@@ -284,6 +296,11 @@ static gboolean pl011_xmit_cb(void *do_not_use, GIOCondition cond, void *opaque)
 
     pl011_update(s);
 
+    if (!emptied_fifo) {
+        /* Reschedule another transmission if we couldn't transmit all. */
+        return G_SOURCE_CONTINUE;
+    }
+
     return G_SOURCE_REMOVE;
 }
 
@@ -313,7 +330,9 @@ static void pl011_write_txdata(PL011State *s, uint8_t data)
     trace_pl011_fifo_tx_put(data);
     pl011_loopback_tx(s, data);
     fifo8_push(&s->xmit_fifo, data);
-    s->flags |= PL011_FLAG_TXFF;
+    if (pl011_is_tx_fifo_full(s)) {
+        s->flags |= PL011_FLAG_TXFF;
+    }
     s->flags &= ~PL011_FLAG_TXFE;
 
     pl011_xmit(s);
diff --git a/hw/char/trace-events b/hw/char/trace-events
index 730d6292a2d..c377f971a6c 100644
--- a/hw/char/trace-events
+++ b/hw/char/trace-events
@@ -68,6 +68,7 @@ pl011_fifo_rx_put(uint32_t c, unsigned read_count, size_t rx_fifo_depth) "RX FIF
 pl011_fifo_rx_full(void) "RX FIFO now full, RXFF set"
 pl011_fifo_tx_is_full(const char *desc, bool full) "mode:%s full:%u"
 pl011_fifo_tx_put(uint8_t byte) "TX FIFO push char [0x%02x]"
+pl011_fifo_tx_xmit_peek(unsigned sent) "TX FIFO peek %u chars"
 pl011_fifo_tx_xmit_used(unsigned sent) "TX FIFO used %u chars"
 pl011_fifo_tx_xmit_consumed(unsigned sent) "TX FIFO consumed %u chars"
 pl011_fifo_tx_overrun(void) "TX FIFO overrun"
-- 
2.47.1


