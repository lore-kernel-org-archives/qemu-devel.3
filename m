Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 983E9C5DF81
	for <qemu-devel@archiver.kernel.org>; Tue, 25 Aug 2026 04:06:03 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wyiQ0-0006fU-PR; Tue, 25 Aug 2026 00:05:48 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stephensportia@gmail.com>)
 id 1wyiPy-0006cO-8H
 for qemu-devel@nongnu.org; Tue, 25 Aug 2026 00:05:46 -0400
Received: from mail-pj1-x1036.google.com ([2607:f8b0:4864:20::1036])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <stephensportia@gmail.com>)
 id 1wyiPv-0007fj-Dp
 for qemu-devel@nongnu.org; Tue, 25 Aug 2026 00:05:45 -0400
Received: by mail-pj1-x1036.google.com with SMTP id
 98e67ed59e1d1-381c51fde6bso5371003a91.2
 for <qemu-devel@nongnu.org>; Mon, 24 Aug 2026 21:05:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1787630742; x=1788235542; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=xDc3uriN8ejBNB8eMT6Kj0ZXRhTp2iKJ4iNyMAkgAig=;
 b=NEd/3xak4MxMHhNM/0tcSVhHdwEFdxQXx8qNLiJrAtH0rj/5ZzfHanSC5TwUt39pgb
 iCOFgp1qvDVEy0TRulGUkQA0jvFF++CPxgTpqnm12OPB4dEPDTvXVyvVg6aDlqGldiyJ
 Blghtv5p1jgITBGFjWOQbiJJvCSMNZp4kGQBDW9y+yJzKuv+5aUWDg6frOT2URdlPexJ
 6zIRPKLziUwPpHjkcudLXjk/wTndHMzQo1+u8i4mTsJK7xWQfows/3Ki615uMc4hlxt4
 54YbDleq7rrkYQj6lgmR3Qi8R4CQhqQyVLjGkHZi7Idn4VPnFzg+QgNL3tMUIOxUeDbj
 bXvg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787630742; x=1788235542;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=xDc3uriN8ejBNB8eMT6Kj0ZXRhTp2iKJ4iNyMAkgAig=;
 b=QsQoJ0qKqpXDLQDQjliM9ucFaDEiJ8lSmksSbJVuq/S5c3fPZBxHPJdVBDTF5uqZIa
 IN72LMWGV9bIRNFbPrA4MclgJ0545mGdph8ASE5tH2B5EHRSz618axxcHYUpBYKmzqwX
 zP9joOcp2xrtFFmjCDmz+gC83dnUHOCenfG9vD7MBLkzmgJbH+2tLMIJgb/IG0xzkBay
 Zmvru7kGG/tMVx1bG4HmIH0Hm5xyQ5JcCahsOGqaDxVWjgaiwQbr8J/ZM3bN+qOF+Y1c
 CPfqU0SCULYT3JwAXe8AfCGpKb2h5ha8cFyt09L3LfnZe4mY/bXn9dFGzdMFFw7gbdvK
 jwpg==
X-Gm-Message-State: AFuF++koA7oy2eA7GP3zG4VeGFESGu3yQ7sSLgSMscGavu2xAKmMVwht
 a8VWBanQhrUF08nBzB4h9jsFzQKPWod/8nitYwr1WDVqkTI211l5JBpKaLk6o2rx
X-Gm-Gg: AR+sD13gW8AFsFslsgwGYw17rkQqEdMfQleE11Je3TKIvp54p5kx0BSZLoJEEkUz54i
 6YabTPaGkWbFJitwhuRqsmm4LnkoNplKoYCMr10NeH89zneoBhVRLNYQu9Oys/1jW1jPnlpRf1i
 C/p+/S47YJBCMtGTparrPtuiHu9S6JiuxXrWWBCzTP/5OOFy9eWLoOHpMxUGc40bw4yvY8h1xio
 cHGL3/2fpiZviq0umPG2mEynB1FDiZchhexDwSGxhDQJEUATdVXJwu1UFyYB+/+iQrWSNCcLQ56
 ecqkqOuKo/DWHM6D6yonNyJjiW25PJ8lfUEr25x1AB1FCmuwlPZUbDdI0HL8oB/ofn+QpyEpT46
 lRD/e0zjR/xEZM9uF3/I4NhAPT9A7VvR7rBfamNNq+zehgZ2cLVsVbSKYO9z9N+9UE6vDnBm8Yd
 bZMcA3KIzOUZ163U3Yb/iG8Eg8lQJsdUzzObCuE3hLOg4GKcA0FNN8kOUlJH0z4+FVEljZiqB17
 7iwDyd6qCuEbg8liNgHRWYMVmjwZ27JgWJTswITdvOp
X-Received: by 2002:a17:90b:1d50:b0:38f:dec8:f7e9 with SMTP id
 98e67ed59e1d1-395df29b3c5mr47931074a91.12.1787630741938; 
 Mon, 24 Aug 2026 21:05:41 -0700 (PDT)
Received: from lima-default.tail89d63.ts.net ([159.196.41.205])
 by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-327f909adc8sm34104212eec.2.2026.08.24.21.05.32
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 24 Aug 2026 21:05:41 -0700 (PDT)
From: stephensportia@gmail.com
To: qemu-devel@nongnu.org
Cc: Palmer Dabbelt <palmer@dabbelt.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 Jamin Lin <jamin_lin@aspeedtech.com>, qemu-ppc@nongnu.org,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>,
 Steven Lee <steven_lee@aspeedtech.com>,
 Andrew Jeffery <andrew@codeconstruct.com.au>,
 Harsh Prateek Bora <harshpb@linux.ibm.com>,
 Subbaraya Sundeep <sundeep.lkml@gmail.com>, Troy Lee <leetroy@gmail.com>,
 "Edgar E. Iglesias" <edgar.iglesias@gmail.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@mailo.com>,
 Alistair Francis <alistair@alistair23.me>,
 Strahinja Jankovic <strahinja.p.jankovic@gmail.com>, qemu-arm@nongnu.org,
 Tyrone Ting <kfting@nuvoton.com>, Nicholas Piggin <npiggin@gmail.com>,
 Aditya Gupta <adityag@linux.ibm.com>, Kane Chen <kane_chen@aspeedtech.com>,
 Francisco Iglesias <francisco.iglesias@amd.com>,
 Joel Stanley <joel@jms.id.au>, Hao Wu <wuhaotsh@google.com>,
 Glenn Miles <milesg@linux.ibm.com>, qemu-riscv@nongnu.org,
 Jean-Christophe Dubois <jcd@tribudubois.net>,
 Portia Stephens <portias@oss.tenstorrent.com>
Subject: [PATCH 4/4] hw/ssi/pnv_spi: Fix dropped upper bytes of ssi transfer
Date: Tue, 25 Aug 2026 14:04:52 +1000
Message-ID: <20260825040452.1322251-5-stephensportia@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260825040452.1322251-1-stephensportia@gmail.com>
References: <20260825040452.1322251-1-stephensportia@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::1036;
 envelope-from=stephensportia@gmail.com; helo=mail-pj1-x1036.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
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

From: Portia Stephens <portias@oss.tenstorrent.com>

The pnv_spi model supports transaction sizes of 4 bytes however there
are no in-tree SSI peripherals that support this. Update the model to
use a 8-bit transfer function.

Signed-off-by: Portia Stephens <portias@oss.tenstorrent.com>
---
 hw/ssi/pnv_spi.c | 28 +++++++++++-----------------
 1 file changed, 11 insertions(+), 17 deletions(-)

diff --git a/hw/ssi/pnv_spi.c b/hw/ssi/pnv_spi.c
index e2a8a710da..481798b1fa 100644
--- a/hw/ssi/pnv_spi.c
+++ b/hw/ssi/pnv_spi.c
@@ -194,32 +194,26 @@ static void spi_response(PnvSpi *s)
 
 static void transfer(PnvSpi *s)
 {
-    uint32_t tx, rx, payload_len;
+    uint32_t payload_len;
     uint8_t rx_byte;
 
     payload_len = fifo8_num_used(&s->tx_fifo);
     for (int offset = 0; offset < payload_len; offset += s->transfer_len) {
-        tx = 0;
-        for (int i = 0; i < s->transfer_len; i++) {
-            if ((offset + i) >= payload_len) {
-                tx <<= 8;
-            } else if (!fifo8_is_empty(&s->tx_fifo)) {
-                tx = (tx << 8) | fifo8_pop(&s->tx_fifo);
-            } else {
-                qemu_log_mask(LOG_GUEST_ERROR, "pnv_spi: TX_FIFO underflow\n");
-            }
-        }
-        rx = ssi_transfer8(s->ssi_bus, tx);
         for (int i = 0; i < s->transfer_len; i++) {
             if ((offset + i) >= payload_len) {
                 break;
             }
-            rx_byte = (rx >> (8 * (s->transfer_len - 1) - i * 8)) & 0xFF;
-            if (!fifo8_is_full(&s->rx_fifo)) {
-                fifo8_push(&s->rx_fifo, rx_byte);
+
+            if (!fifo8_is_empty(&s->tx_fifo)) {
+                rx_byte = ssi_transfer8(s->ssi_bus, fifo8_pop(&s->tx_fifo));
+                if (!fifo8_is_full(&s->rx_fifo)) {
+                    fifo8_push(&s->rx_fifo, rx_byte);
+                } else {
+                    qemu_log_mask(LOG_GUEST_ERROR, "pnv_spi: RX_FIFO is full\n");
+                    break;
+                }
             } else {
-                qemu_log_mask(LOG_GUEST_ERROR, "pnv_spi: RX_FIFO is full\n");
-                break;
+                qemu_log_mask(LOG_GUEST_ERROR, "pnv_spi: TX_FIFO underflow\n");
             }
         }
     }
-- 
2.43.0


