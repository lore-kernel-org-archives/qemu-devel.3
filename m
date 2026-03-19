Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3DABA109192F
	for <qemu-devel@archiver.kernel.org>; Thu, 19 Mar 2026 23:27:51 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w3Mkx-000102-4A; Thu, 19 Mar 2026 19:26:23 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1w3Mkv-0000sv-4h
 for qemu-devel@nongnu.org; Thu, 19 Mar 2026 19:26:21 -0400
Received: from mail-pl1-x629.google.com ([2607:f8b0:4864:20::629])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1w3Mkt-0007ht-I9
 for qemu-devel@nongnu.org; Thu, 19 Mar 2026 19:26:20 -0400
Received: by mail-pl1-x629.google.com with SMTP id
 d9443c01a7336-2b056b7f783so7079595ad.1
 for <qemu-devel@nongnu.org>; Thu, 19 Mar 2026 16:26:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1773962778; x=1774567578; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=rk9qu+43yuAwQNmV+HOd24mU8ny8bR4PCXHORU3AcGI=;
 b=nd3SxwTFEz2RixrDv/348UglldLOTBaTjIoMAKwAryTk46OJAYzgiApZgEyyP5giQt
 fFWViMUQev7gMT+qXNG0svFFmnSgjLSCZTemQrW+vkdNcfabvSYd1W5NZFn1xis3AkVI
 dp2MGmsSkDlMaCH/B3U2YrJSZ6BYnoFJn8QL7q26UUq1VWxMntnF/CHQizkgZSILoi8u
 eWRKtnMo3DzsEVhs4n3A36kQwEhCmJcJCgRcIWz1hwwse/EFUvJgorOgSVXzFr4qsyDt
 8cHTxOgcJ7pfdzhb7PDKPV3bfE/bz3HGZSfHEGFyoO42yG4ctQaWhLFQzzz66U2BaRoW
 0ysg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1773962778; x=1774567578;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=rk9qu+43yuAwQNmV+HOd24mU8ny8bR4PCXHORU3AcGI=;
 b=aBj1LnwP0EqQezJQNzia8/wM/83v0A4ynO6/ijsYYVHNdz/y1Bd67J1KrVELlD0slm
 hbEtrCwiFPuhk6HYVQeSJADUUQ9se+L0CdjarA6Pq4HCOiVgQtKiDJ/M/kbS6c3UYUdT
 wcAmKPzkMuEBOFu46IGTSnBjrx5Hi1LIECJC6YvY8X4UtYv2fq7226uL9P4VNSKlGjug
 hIgLx+ymO4Jub/AY8HmQMGFF2rpmSC9+eQSAc0XiJQZqP+TyYAeDitQyZmNyTH/PzGqv
 4A5uCOrS8vbbt/+ArdXAHq/Vav39aPIooS+gZEaXWwniibVDPPfr+4Aq5Gk+sVHaN1J2
 f7Eg==
X-Gm-Message-State: AOJu0YxrgqFb+ZTmzIjMSJsHXDrQ3P1K9QuFt8nyoH+kLnVMruL/hGtr
 So8a3mYMwXwpYjZJIB5VB4G7/qYew5bmzC2v3HENR9S9FaEBRamMyFMPw0/uNA==
X-Gm-Gg: ATEYQzyD/k362tzI6mX5xFnAierx7xX9qrE+wyNBmjF/kRc5OijAUsIiBE7Br7humtv
 jUOhx2yhgjmxwgsYWbcDAaEUCpFcxRiF9udB1mRxmskLpO2mDX3ObZLpVW8pt14SSQx2tpZC8uM
 MfjfzP99la2+nLiSkEjNtaXEOjEqhCBXpRejxdKbdrt0k7Kw9ysx2oFUWdTu+54dKH5lAfSkHiL
 //XEnvNkMUalJJJz4ykwuqX1Jp0dfS3Hml8FjYxZhoickCZ6jWQP/TJADrKIavWrn0VFA6v1Ltp
 Oyi2Ngg0C6NZxY8oJ8kVsbVaq1UNEvn2i2+NdRr7oE4Ad3QrzNqIXMYKioCpVrPqlDEb3uTJ2/3
 vcGLj8Gik1122ndH9rLntz01dRWoER2oM7DRWjNTxFFNJRGZCEltD2C+bNNNH1kXTj3wZZQdIPt
 23lcZUSswhtOj3Pp6JQdfG8rqkuW603H/vNfVXEZo6kA==
X-Received: by 2002:a17:903:388d:b0:2ae:5346:d4e6 with SMTP id
 d9443c01a7336-2b07725f8cbmr51729315ad.28.1773962777687; 
 Thu, 19 Mar 2026 16:26:17 -0700 (PDT)
Received: from toolbx.alistair23.me ([2403:581e:fdf9:0:6209:4521:6813:45b7])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2b083516ae1sm2979165ad.13.2026.03.19.16.26.15
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 19 Mar 2026 16:26:17 -0700 (PDT)
From: alistair23@gmail.com
X-Google-Original-From: alistair.francis@wdc.com
To: qemu-devel@nongnu.org
Cc: alistair23@gmail.com, Frank Chang <frank.chang@sifive.com>,
 Alistair Francis <alistair.francis@wdc.com>
Subject: [PULL 12/17] hw/char: sifive_uart: Sync txwm interrupt pending status
 after TX FIFO enqueue
Date: Fri, 20 Mar 2026 09:25:17 +1000
Message-ID: <20260319232522.1867400-13-alistair.francis@wdc.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260319232522.1867400-1-alistair.francis@wdc.com>
References: <20260319232522.1867400-1-alistair.francis@wdc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::629;
 envelope-from=alistair23@gmail.com; helo=mail-pl1-x629.google.com
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

Currently, the txwm interrupt pending status is only updated when the
asynchronous transmit handler runs. This can cause the txwm interrupt
state to become unsynchronized between the SiFive UART and the
interrupt controller.

For example, when a txwm interrupt is raised, the corresponding APLIC
pending bit is also set. However, if software later enqueues additional
characters into the TX FIFO exceeding the transmit watermark, the
APLIC pending bit may remain set because the txwm interrupt pending
status is not updated at enqueue time.

This issue has been observed on resource-constrained machines, where
Linux reports spurious IRQ errors. In these cases, the asynchronous
transmit handler is unable to drain the TX FIFO quickly enough to update
the txwm pending status before software reads the ip register, which
derives the txwm pending state directly from the actual number of
characters in the TX FIFO.

This commit fixes the issue by updating the txwm interrupt pending
status immediately after enqueuing data into the TX FIFO, ensuring that
the interrupt pending status between the SiFive UART and the interrupt
controller remains synchronized.

Signed-off-by: Frank Chang <frank.chang@sifive.com>
Reviewed-by: Alistair Francis <alistair.francis@wdc.com>
Message-ID: <20260312033201.1619554-3-frank.chang@sifive.com>
Signed-off-by: Alistair Francis <alistair.francis@wdc.com>
---
 hw/char/sifive_uart.c | 16 ++++++++++++++++
 1 file changed, 16 insertions(+)

diff --git a/hw/char/sifive_uart.c b/hw/char/sifive_uart.c
index 3ce6a4ee76..ae71a15a2a 100644
--- a/hw/char/sifive_uart.c
+++ b/hw/char/sifive_uart.c
@@ -124,12 +124,20 @@ static void sifive_uart_trigger_tx_fifo(SiFiveUARTState *s)
 static void sifive_uart_write_tx_fifo(SiFiveUARTState *s, const uint8_t *buf,
                                       int size)
 {
+    uint32_t txcnt = SIFIVE_UART_GET_TXCNT(s->txctrl);
+    bool update_irq = false;
+
     if (size > fifo8_num_free(&s->tx_fifo)) {
         size = fifo8_num_free(&s->tx_fifo);
         qemu_log_mask(LOG_GUEST_ERROR, "sifive_uart: TX FIFO overflow.\n");
     }
 
     if (size > 0) {
+        if (fifo8_num_used(&s->tx_fifo) < txcnt &&
+            (fifo8_num_used(&s->tx_fifo) + size) >= txcnt) {
+            update_irq = true;
+        }
+
         fifo8_push_all(&s->tx_fifo, buf, size);
     }
 
@@ -137,6 +145,14 @@ static void sifive_uart_write_tx_fifo(SiFiveUARTState *s, const uint8_t *buf,
         s->txfifo |= SIFIVE_UART_TXFIFO_FULL;
     }
 
+    /*
+     * Update txwm interrupt pending status when the number of entries
+     * in the transmit FIFO crosses or reaches the watermark.
+     */
+    if (update_irq) {
+        sifive_uart_update_irq(s);
+    }
+
     sifive_uart_trigger_tx_fifo(s);
 }
 
-- 
2.53.0


