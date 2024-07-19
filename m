Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D96C4C3DA5D
	for <qemu-devel@archiver.kernel.org>; Fri, 19 Jul 2024 18:13:01 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sUs52-0003ej-7Y; Fri, 19 Jul 2024 14:11:44 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sUs4x-0003G4-9O
 for qemu-devel@nongnu.org; Fri, 19 Jul 2024 14:11:40 -0400
Received: from mail-wm1-x32e.google.com ([2a00:1450:4864:20::32e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sUs4u-0003sc-IM
 for qemu-devel@nongnu.org; Fri, 19 Jul 2024 14:11:39 -0400
Received: by mail-wm1-x32e.google.com with SMTP id
 5b1f17b1804b1-427db004e36so248275e9.3
 for <qemu-devel@nongnu.org>; Fri, 19 Jul 2024 11:11:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1721412694; x=1722017494; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=k2XEnhFM3nuD2qGNt8O7aO/xmQeeA1+fM2YLyMtjpsg=;
 b=viZsthjWLt1sOM9/zWtp6qw4w6uBYfCHHCU6A5TmK+Pv4Cs608fLDMdtlBqqvzAgIY
 iqpOuJ0DoGZz4lbuCehZBo+oQq1DahlxqS2I7Wyz5lgWdaBzmhqWtGTbNKOTxwXsvHcn
 r5hWH//RA3i4fgnKgMMDMtg9K8VhGKoXQB6sPx23PXgua3wvqcZiV2JI2X8kEdajMqBS
 V/8IEDnLIHwSYV3WKO+8g9sDQldDMyfsOSENRALuJSAHOt7MaalVXAUe+sjtSE8bnhU2
 BvS3DI1lCs2r0+4kkfykj3iGrmqYJSm/iW8zesF/Dm1NCfGI6x8GF2Sqmttvfxm+CLzT
 yGtw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1721412694; x=1722017494;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=k2XEnhFM3nuD2qGNt8O7aO/xmQeeA1+fM2YLyMtjpsg=;
 b=ojFtWrN/uB8/hQNrJB8i8UG8mZvG9J2eqos8ih/9+OiGXBi/6+ekm7ENoUDfumf+LZ
 eQu8Gi6pVS902FSgKkiHi3nBmMK3FZ9h+EsaBJQXAzYD3x2qY9qvuRnj38PgcVUzsoey
 GtE5eq9NRBvSbLMaDCwUg60xQ7VfLZ+cqGPqzeoR67mB2TFFYH8+Ii1vfMPAwxocpNhJ
 ejngXI7qsUQg2shpvakotCDkphx+sSghMg1xKzG2BOf2fkyAzvfECzoThC/YEE3WZleP
 KFmPYFMsTDk7MIh4JLh5+RrA98hcJWCjGNKMlU4V4Z4eZh2rzh6aEBdOVeGYLQJT/mtX
 BHfA==
X-Gm-Message-State: AOJu0YyLxeFpnzNq9CkgSjwp5JLICeEpbDMhXhRvnRiqYudYegquOmcR
 TMENNoh9ZFbRn6O6W2xXCdRogW0UnvZ7Tmg82WEYXTcvDwIE9w5SZX7/1gzMbxuYcJc+hUhcV49
 M
X-Google-Smtp-Source: AGHT+IEr89MmK4OUZpr7c5pFLvBB8jJPGvUyda7rkXtYo6bxb/wIkpX5bKrrajVZmNqvyxZbn1T21Q==
X-Received: by 2002:a05:600c:1c21:b0:426:5d0d:a2c9 with SMTP id
 5b1f17b1804b1-427c2cd36d1mr63774875e9.10.1721412694282; 
 Fri, 19 Jul 2024 11:11:34 -0700 (PDT)
Received: from localhost.localdomain (52.170.88.92.rev.sfr.net. [92.88.170.52])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-427d2a7257esm59439785e9.28.2024.07.19.11.11.32
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Fri, 19 Jul 2024 11:11:33 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 qemu-arm@nongnu.org, Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
 Tong Ho <tong.ho@amd.com>,
 Manos Pitsidianakis <manos.pitsidianakis@linaro.org>,
 Peter Maydell <peter.maydell@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>
Subject: [PATCH v5 08/16] hw/char/pl011: Warn when using disabled transmitter
Date: Fri, 19 Jul 2024 20:10:33 +0200
Message-ID: <20240719181041.49545-9-philmd@linaro.org>
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

We shouldn't transmit characters when the full UART or its
transmitter is disabled. However we don't want to break the
possibly incomplete "my first bare metal assembly program"s,
so we choose to simply display a warning when this occurs.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Alex Bennée <alex.bennee@linaro.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
---
 hw/char/pl011.c | 9 ++++++++-
 1 file changed, 8 insertions(+), 1 deletion(-)

diff --git a/hw/char/pl011.c b/hw/char/pl011.c
index 5e44837206..c76283dccf 100644
--- a/hw/char/pl011.c
+++ b/hw/char/pl011.c
@@ -85,7 +85,9 @@ DeviceState *pl011_create(hwaddr addr, qemu_irq irq, Chardev *chr)
 #define CR_OUT1     (1 << 12)
 #define CR_RTS      (1 << 11)
 #define CR_DTR      (1 << 10)
+#define CR_TXE      (1 << 8)
 #define CR_LBE      (1 << 7)
+#define CR_UARTEN   (1 << 0)
 
 /* Integer Baud Rate Divider, UARTIBRD */
 #define IBRD_MASK 0x3f
@@ -223,7 +225,12 @@ static void pl011_loopback_tx(PL011State *s, uint32_t value)
 
 static void pl011_write_txdata(PL011State *s, uint8_t data)
 {
-    /* ??? Check if transmitter is enabled.  */
+    if (!(s->cr & CR_UARTEN)) {
+        qemu_log_mask(LOG_GUEST_ERROR, "PL011 data written to disabled UART\n");
+    }
+    if (!(s->cr & CR_TXE)) {
+        qemu_log_mask(LOG_GUEST_ERROR, "PL011 data written to disabled TX UART\n");
+    }
 
     /* XXX this blocks entire thread. Rewrite to use
      * qemu_chr_fe_write and background I/O callbacks */
-- 
2.41.0


