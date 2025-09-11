Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3BC61CAC58E
	for <qemu-devel@archiver.kernel.org>; Thu, 11 Sep 2025 16:08:20 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uwjpD-00059X-Nk; Thu, 11 Sep 2025 12:07:07 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <frank.chang@sifive.com>)
 id 1uwjp7-00056e-PU
 for qemu-devel@nongnu.org; Thu, 11 Sep 2025 12:07:02 -0400
Received: from mail-pg1-x52d.google.com ([2607:f8b0:4864:20::52d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <frank.chang@sifive.com>)
 id 1uwjp6-00069R-25
 for qemu-devel@nongnu.org; Thu, 11 Sep 2025 12:07:01 -0400
Received: by mail-pg1-x52d.google.com with SMTP id
 41be03b00d2f7-b4fb8d3a2dbso718774a12.3
 for <qemu-devel@nongnu.org>; Thu, 11 Sep 2025 09:06:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sifive.com; s=google; t=1757606818; x=1758211618; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Vtn/P0RSi7hHJExTcycuQeWBhjKBhcvfR0eoJo2mnyg=;
 b=ISpUqbZRtT4r7zCAFy5vldedAUnSSGz/pG7b9SVVIuOVpmm6F5qfQVHOTbe6R+Rgvo
 hw2CZl8idgA5FzU5eAu1Mij1MOIEUtgOfQOm5KjBX/9e0TSIzWq+Q958oA5VPCccnqTq
 rr46AB5Y12LlglP+7HEA/fUEU23v9q82R9we0Ud7gfQDqf1c56usZfDvW34wf2SYPzkr
 MpQYjNd4M4dBzuxmHTdKLKtIRYHJ1/57bAGtDNbr9ZcMxoKEE7sBmZZPuuMom4sHRZbD
 jNmdXbj5Ep/o6kVv4ZY59xJ80B2zR+qwn3EZ8M/XvkbCcnkUxMJ2+z6rtOyaVcxxx6mv
 a27g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1757606818; x=1758211618;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Vtn/P0RSi7hHJExTcycuQeWBhjKBhcvfR0eoJo2mnyg=;
 b=cT/KkSewDF7dlMsqTKjPv+OVEDa9QzBeS0C/QkyNdrihhtd9p9EAmluIxC0usQD773
 I34qu2FZTkTF+LBuemyoVB6wBSCVPSqCpZNXRlkjCz6YyuN8dFzkpegb2lk/qLuvl6q1
 ZpG9Svd96hgomOJwRJsbaX42gLAK2dxO+5uImkcWtPpKZL8zE1m3bZ60tJqcFIF+cPY3
 aczSE8g2cc3a5kXU+NhUc3iO3J4tqSiYhBbiJsflbrDAwY1mffyY+ok1xIeZZAgL4YTF
 QdjRc6GrA4+pqolQqvYBuJRZFqy+NeNXFD3Ay5+5NenNtHL57mJTLoRP+QKIo2eDgbm6
 lGzA==
X-Gm-Message-State: AOJu0YzOyDO9gjHc3uoExT6iwU1TYP0WW23P1pL1W75iAhQOgunl/SyJ
 GXzjmopmnZyxQpK8qKuKSJE5PPNu4MhrzqBOIzrF+SUSz18QlubInWuVdfrXvs701V1hssCbum8
 H6kjuO7vTz/Nv5V/hWUbePby7TrekTMqjWPdSIwK944o9uzlxpcdRUiG0gNUaCKmnrUU03z0A5P
 WTPCOPf36EBQc8N0ziKbMbGf5ic4MnW10fjpQHSuq4bmB8MA==
X-Gm-Gg: ASbGncv91qZ7sa3t3bZfG4QwDEIEE1IckwKj/1jsvM/vtNLnCRFKNOMasOQymH6Api2
 Crt2Oczot3puzKaHXRaMS1PxcStfdKWWnGxB4CHElQDLFUClA4leNWsN22qb9o+mfu0DKisGE9Y
 spfmGrxj88jWvgICGQhobKqQDN1RXRPO7bag2dbE01t+N/5+LWQpw9Z+NMbmfFWjdMnE/JtR82r
 iLOqdbBX1b8EAdfHUPMnVtEITkpMj2RirIctbgLGhxTW7YK3+nCcEyQXrBbSJ+UPFC+UeYifleY
 fAg0UyVJ5D/vQl31BxoQyu4PyGyr74pZ+sAOzxx0qBaFmHaf0RCVf3QiNg8reAnfsoBNGEVnwIX
 /KlrNPjMuMrAfP+tZ4sqBmWHufz3Ck9ocF3SGm3Yo+EfdbDY12kIDdPjX1Jx2
X-Google-Smtp-Source: AGHT+IHSG7yc6QMm1MwjKEtdgpTLLmYFqDutKKmlNN/Skkiwm3gmRfQXNxpur/zJQlqMqpTo99hbUA==
X-Received: by 2002:a17:90b:2683:b0:327:ba77:a47 with SMTP id
 98e67ed59e1d1-32d43f05b51mr28369135a91.15.1757606817949; 
 Thu, 11 Sep 2025 09:06:57 -0700 (PDT)
Received: from hsinchu16.internal.sifive.com ([210.176.154.34])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-32dd9903a2asm2618765a91.24.2025.09.11.09.06.56
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 11 Sep 2025 09:06:57 -0700 (PDT)
From: frank.chang@sifive.com
To: qemu-devel@nongnu.org
Cc: Alistair Francis <Alistair.Francis@wdc.com>,
 Palmer Dabbelt <palmer@dabbelt.com>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 qemu-riscv@nongnu.org (open list:SiFive Machines),
 Frank Chang <frank.chang@sifive.com>
Subject: [PATCH 2/4] hw/char: sifive_uart: Avoid pushing Tx FIFO when size is
 zero
Date: Fri, 12 Sep 2025 00:06:44 +0800
Message-ID: <20250911160647.5710-3-frank.chang@sifive.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250911160647.5710-1-frank.chang@sifive.com>
References: <20250911160647.5710-1-frank.chang@sifive.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::52d;
 envelope-from=frank.chang@sifive.com; helo=mail-pg1-x52d.google.com
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

There's no need to call fifo8_push_all() when size is zero.

Signed-off-by: Frank Chang <frank.chang@sifive.com>
---
 hw/char/sifive_uart.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/hw/char/sifive_uart.c b/hw/char/sifive_uart.c
index 138c31fcabf..401f869680d 100644
--- a/hw/char/sifive_uart.c
+++ b/hw/char/sifive_uart.c
@@ -122,7 +122,9 @@ static void sifive_uart_write_tx_fifo(SiFiveUARTState *s, const uint8_t *buf,
         qemu_log_mask(LOG_GUEST_ERROR, "sifive_uart: TX FIFO overflow");
     }
 
-    fifo8_push_all(&s->tx_fifo, buf, size);
+    if (size > 0) {
+        fifo8_push_all(&s->tx_fifo, buf, size);
+    }
 
     if (fifo8_is_full(&s->tx_fifo)) {
         s->txfifo |= SIFIVE_UART_TXFIFO_FULL;
-- 
2.49.0


