Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C1E56FED2C3
	for <qemu-devel@archiver.kernel.org>; Thu, 12 Mar 2026 03:33:08 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w0Wmy-0007id-QI; Wed, 11 Mar 2026 23:32:44 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <frank.chang@sifive.com>)
 id 1w0Wmk-0007Qb-Vt
 for qemu-devel@nongnu.org; Wed, 11 Mar 2026 23:32:34 -0400
Received: from mail-wm1-x335.google.com ([2a00:1450:4864:20::335])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <frank.chang@sifive.com>)
 id 1w0Wmi-000680-Hr
 for qemu-devel@nongnu.org; Wed, 11 Mar 2026 23:32:29 -0400
Received: by mail-wm1-x335.google.com with SMTP id
 5b1f17b1804b1-4852e09e23dso3841975e9.0
 for <qemu-devel@nongnu.org>; Wed, 11 Mar 2026 20:32:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sifive.com; s=google; t=1773286346; x=1773891146; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=p/ir3+XQEQ4fiVwZaFm9CIl150MgD4MJ0b3dRmPSWCw=;
 b=UkmklrU+1OoV15EWMMB54fmjgpHLPXt2CpkT9LdjAjDX5SNdNfG96sg4xyuxG8vOUV
 CTV8bPIQnn1evG/IlwMuuoZ791HlF/CSs2eZgBzNFRssCBh4yJ0YWe9vFZ56iOXmjizl
 atgQD3w0MEtHZWa9PdDxHd8irjZZ4MfFvRx9m8ZGN3NnrjaIPN2pIG8yvhW0mU5ClDJa
 eqsDNn3AdPaUTYkGAlBQ9ctr4BeJkh/xFytxbgTVanQUrzQq5ZVbs8heh7ibhz7AYyBc
 4LeDtjoUOAZPACoM1UK2/LQx+ojtCIl/2io5Gf+AAga+Kw9Q8sbqI7J1U6uRxVokUZeo
 GECA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1773286346; x=1773891146;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=p/ir3+XQEQ4fiVwZaFm9CIl150MgD4MJ0b3dRmPSWCw=;
 b=P4MCUkTuYdfv5AQJA74fdBht0A2nrIxfwrMuBQh2y4BaPhV1riQ9fcmJxZm9iEx6ij
 G26+Y9yuERZztDRV7dSR1dxMKm3eo/rDpTBhPdspMA3iiXQGRL7l2pPbA5Y3Wr/YKK/B
 6WoStIM0O27Svs7QLIFHZJPnkNZ2JXX+icUOA8ZHC6kluQ6lF+vjgJt+XO7c9Uvmwoi4
 rCg6WnXeLnEbzT4HVqTO6oIYEI92uafNIMnWQ+zvGwOMmTm4Y+3VBseysfB8D6n7VuTf
 048Nh2mgdFVkauC35UOzUzqe2bCUp/shCUmvzZfgZZJnzsvYFbpMYsIqA0a9DRl4bE0p
 YfGg==
X-Gm-Message-State: AOJu0YyFn2nCSl4VzaI8tFM7CTtNewM3wHu3YjutJtXvstfzywRpPLZf
 kg0kXLBosMBUSCZQp2nWbqYt2FCgGDVEr3Yp3nWsUQwHxdzrPlH+bleaxbya/vhMe12KAcoM83S
 FR01N0d1gpeXP3awQSgkYM6RGgtklP1J+0xEqSFzOSMnnwdnLonYNoIdWm/i+XZZuGuneEzXWm2
 bijDyT8r/1fymHA8T9Ml6ZcPGw0+m2Fy0mY7AP5IeA4XQkhw==
X-Gm-Gg: ATEYQzzSJwWMqYf1HoNj5dhxkOk2l+CeNNbOaeHXBanxy9b0LeI1DpQUL5el3FhsxNn
 i0YFsrj1mTQ8rorNYuuSVgUHmaMZtzLAz2O9pS+bep47YhPx7J1y6YlBn2OYVgvkb/oF9gGayE6
 bFTn4XiN0PJlulah9qpfQcxFPCsrhq6p33xKW5JOZXt0Oic/fsKMRzEkymxSMjNQcDLf1RyF01L
 3BuDN2zoJIRh9AmZoZxwgTrecCm1dQ7JmQ80F5DD3XIIqwVwP6ieD6Y31NbXcZo5ZljroNC42oR
 WFDHid3QG63D7QdoEU3T6cgnleQk63S7E0u0vpIO/3WW+BzTRajy5v2NwmkfADf8TSbK//LABwr
 3KqthYp9vhmIk/fbKR7Jf4yJCXbXPqm4PAdc8g7zxSAuFiEdYSJ2m28jbXW6/mQKEqwmO9SeFCV
 8d9ona5io/4cfkGnOzndvt2EYq7fijDTCbEw9fMXqXW0rqOW0evQ==
X-Received: by 2002:a05:600c:1d16:b0:483:1403:c47f with SMTP id
 5b1f17b1804b1-4854b0a6fcamr81807555e9.6.1773286346013; 
 Wed, 11 Mar 2026 20:32:26 -0700 (PDT)
Received: from hsinchu16.internal.sifive.com ([210.176.154.34])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4854b5f6bb4sm94807735e9.4.2026.03.11.20.32.23
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 11 Mar 2026 20:32:25 -0700 (PDT)
From: frank.chang@sifive.com
To: qemu-devel@nongnu.org
Cc: Alistair Francis <Alistair.Francis@wdc.com>,
 Palmer Dabbelt <palmer@dabbelt.com>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 qemu-riscv@nongnu.org (open list:SiFive Machines),
 Frank Chang <frank.chang@sifive.com>
Subject: [PATCH v3 4/4] hw/char: sifive_uart: Remove ip variable
Date: Thu, 12 Mar 2026 11:32:01 +0800
Message-ID: <20260312033201.1619554-5-frank.chang@sifive.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260312033201.1619554-1-frank.chang@sifive.com>
References: <20260312033201.1619554-1-frank.chang@sifive.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::335;
 envelope-from=frank.chang@sifive.com; helo=mail-wm1-x335.google.com
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

The ip variable is no longer used in the code. Remove it from the
codebase.

Signed-off-by: Frank Chang <frank.chang@sifive.com>
---
 hw/char/sifive_uart.c         | 6 ++----
 include/hw/char/sifive_uart.h | 1 -
 2 files changed, 2 insertions(+), 5 deletions(-)

diff --git a/hw/char/sifive_uart.c b/hw/char/sifive_uart.c
index f255cca960d..4c30fbf5685 100644
--- a/hw/char/sifive_uart.c
+++ b/hw/char/sifive_uart.c
@@ -285,7 +285,6 @@ static void sifive_uart_reset_enter(Object *obj, ResetType type)
 
     s->txfifo = 0;
     s->ie = 0;
-    s->ip = 0;
     s->txctrl = 0;
     s->rxctrl = 0;
     s->div = 0;
@@ -343,14 +342,13 @@ static void sifive_uart_reset_hold(Object *obj, ResetType type)
 
 static const VMStateDescription vmstate_sifive_uart = {
     .name = TYPE_SIFIVE_UART,
-    .version_id = 2,
-    .minimum_version_id = 2,
+    .version_id = 3,
+    .minimum_version_id = 3,
     .fields = (const VMStateField[]) {
         VMSTATE_UINT8_ARRAY(rx_fifo, SiFiveUARTState,
                             SIFIVE_UART_RX_FIFO_SIZE),
         VMSTATE_UINT8(rx_fifo_len, SiFiveUARTState),
         VMSTATE_UINT32(ie, SiFiveUARTState),
-        VMSTATE_UINT32(ip, SiFiveUARTState),
         VMSTATE_UINT32(txctrl, SiFiveUARTState),
         VMSTATE_UINT32(rxctrl, SiFiveUARTState),
         VMSTATE_UINT32(div, SiFiveUARTState),
diff --git a/include/hw/char/sifive_uart.h b/include/hw/char/sifive_uart.h
index c78d9bd1fc6..5f3b1327de0 100644
--- a/include/hw/char/sifive_uart.h
+++ b/include/hw/char/sifive_uart.h
@@ -73,7 +73,6 @@ struct SiFiveUARTState {
 
     uint32_t txfifo;
     uint32_t ie;
-    uint32_t ip;
     uint32_t txctrl;
     uint32_t rxctrl;
     uint32_t div;
-- 
2.43.0


