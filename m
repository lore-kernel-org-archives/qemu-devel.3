Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DB9B3FED2C3
	for <qemu-devel@archiver.kernel.org>; Thu, 12 Mar 2026 03:32:45 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w0Wmk-0007Ov-Q8; Wed, 11 Mar 2026 23:32:30 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <frank.chang@sifive.com>)
 id 1w0Wmd-0007JC-Iz
 for qemu-devel@nongnu.org; Wed, 11 Mar 2026 23:32:24 -0400
Received: from mail-wm1-x330.google.com ([2a00:1450:4864:20::330])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <frank.chang@sifive.com>)
 id 1w0Wmb-00067A-Ph
 for qemu-devel@nongnu.org; Wed, 11 Mar 2026 23:32:23 -0400
Received: by mail-wm1-x330.google.com with SMTP id
 5b1f17b1804b1-48534b59cf3so4310445e9.2
 for <qemu-devel@nongnu.org>; Wed, 11 Mar 2026 20:32:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sifive.com; s=google; t=1773286340; x=1773891140; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=29BufEZag21u7qldVD3ZzkUQ+ni7OCRy2fvs7jAv70U=;
 b=nHQZ0j6neGU0ALr2znSHi8fnmE5wyTPDnrZxHXgWx5XsnlvFjrEfIbea77xB28fY8N
 d9Dlyfx5p6HldhAaa7T+dBJrQaRkhbkOoBftZ4ZeejcC2ABh0xW+Db3qz2VkZl+fVwCp
 B65l5BfSJhUgS/l/OhCZE66AX0P6WPedf0rNAedKWLFibUDv2f8imJjitr8h07LHjIgk
 gVbumX43W7FiS6BQY6QPl0Ry+FYcHDsHnRVnMqaR35PWQv//NVRo8Z1SarXy+UI1fnMo
 ZeQto/rMEqz6xAKLGGPZzRMNXP6558a4AjriqG1UMR/ru1of4coUXvwAidUjtFyiTU97
 GVlQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1773286340; x=1773891140;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=29BufEZag21u7qldVD3ZzkUQ+ni7OCRy2fvs7jAv70U=;
 b=HlHIk7g722GoP0lWfgScc6wTm1ahFR457EXzM/crvV+yAzt/AnXYmLmS1celc9E4NN
 lG4G6VkBSmoO/GtKCM+JrU2leGNOsbNm9OAabQwezJ0Ad2xgNX9rZwAI+xLlELF1GdlD
 MwZABtBcL7XHLf6as3nyEQvcp4GnDAFxm704J2k5ted5It3OklG9ydXRXGrJ7fvyunCu
 hNNZ02GJ35avkBMeCSOP3ojJ/NAhq76eTk1gocMvPRnrf93Wy/TFo9yc77jeOWXf+Tfe
 YQBr3tPvtidUXtREbXYe5C2RwxMx+BYmx7TZq7XQZZwZGizJDw0EjoMT0N/XVpuwCFLs
 VgvQ==
X-Gm-Message-State: AOJu0Yw4eawfsWJ4kcpFqO4kk52FkeENeJ9yVe5LX10zRDa04rdWAAzH
 v5hR7oxcBEr40O/5Imfgc73AhbLp4IKdBOSjaLQ4KlYHKcsSxz6o8VaVE9iZDpQcfzlYUChs1yh
 bFQr96xzsr6XmUCkArGaevFaAgd6oBB/lgplRHsiVqxRpWxcY3mbjwC9IvQSS3JgYlwUZLLsgtn
 BQmk+2eYZ1pQkEXiHMq7Enuy2WMeFMMUL4lBx8Ja6oTJJlyQ==
X-Gm-Gg: ATEYQzy5Kt8qz9et2HGmQ5w3+8y/V79nPSQVKJoIcEpheF6yTxMbayrlFZqS7sl0F7p
 h5DwruAWPwbM/pVQBarqyRiSOKgrEZLOqbl8C8uO7VZMoqIEsQUUMLnvMvNhENRrlo+2dXiB/xV
 JTOT8jU6cYXOheA6A02SJsGfhZ9bEWdPbYeTbDzcD6/alNa+c5z/5Q7GUEUyYVPfvObLekn1i9V
 ZAVz06Pa+ViZFZli2A4E3J5KwBVGuFT3MUpfLV009Ajd/523MUa6oVpIuAGebvs7lr/TQ9+60TD
 kFc5L6SpdNwWYGS36yS77Ig7jm0Gwioo6RQEvbwjvd446kP/rxRNDJHyrUwbhZhbmKtHWp/VlQO
 L55tbOh0Nk+NqBm2QK8C7O0poNy+9YfIdx/teSb/UMcEvxh6+l2/U84x4xrN1GZWEt5nbCB6bu3
 Rtj663PcFPj+NBD062+9PyKndjl8p2fl1xItWQsokJdB+uuIRodw==
X-Received: by 2002:a05:600c:c0c9:b0:485:3fa9:358c with SMTP id
 5b1f17b1804b1-4854b100b5bmr61157025e9.17.1773286339874; 
 Wed, 11 Mar 2026 20:32:19 -0700 (PDT)
Received: from hsinchu16.internal.sifive.com ([210.176.154.34])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4854b5f6bb4sm94807735e9.4.2026.03.11.20.32.17
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 11 Mar 2026 20:32:19 -0700 (PDT)
From: frank.chang@sifive.com
To: qemu-devel@nongnu.org
Cc: Alistair Francis <Alistair.Francis@wdc.com>,
 Palmer Dabbelt <palmer@dabbelt.com>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 qemu-riscv@nongnu.org (open list:SiFive Machines),
 Frank Chang <frank.chang@sifive.com>
Subject: [PATCH v3 2/4] hw/char: sifive_uart: Sync txwm interrupt pending
 status after TX FIFO enqueue
Date: Thu, 12 Mar 2026 11:31:59 +0800
Message-ID: <20260312033201.1619554-3-frank.chang@sifive.com>
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
---
 hw/char/sifive_uart.c | 16 ++++++++++++++++
 1 file changed, 16 insertions(+)

diff --git a/hw/char/sifive_uart.c b/hw/char/sifive_uart.c
index 3ce6a4ee76a..ae71a15a2a4 100644
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
2.43.0


