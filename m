Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1F204C3DA49
	for <qemu-devel@archiver.kernel.org>; Fri, 26 Jul 2024 06:01:13 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sXDzj-0001jk-4u; Fri, 26 Jul 2024 01:59:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jim.shu@sifive.com>)
 id 1sXDzh-0001iY-34
 for qemu-devel@nongnu.org; Fri, 26 Jul 2024 01:59:57 -0400
Received: from mail-pf1-x42f.google.com ([2607:f8b0:4864:20::42f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <jim.shu@sifive.com>)
 id 1sXDza-0006ot-HS
 for qemu-devel@nongnu.org; Fri, 26 Jul 2024 01:59:51 -0400
Received: by mail-pf1-x42f.google.com with SMTP id
 d2e1a72fcca58-70d1d6369acso382564b3a.0
 for <qemu-devel@nongnu.org>; Thu, 25 Jul 2024 22:59:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sifive.com; s=google; t=1721973588; x=1722578388; darn=nongnu.org;
 h=references:in-reply-to:message-id:date:subject:cc:to:from:from:to
 :cc:subject:date:message-id:reply-to;
 bh=bCYAojS36KJlYYD+6PO9pHqhAb0FjLUF0zDaVffQqIA=;
 b=IWDaH9OxKT8XrXEC/3A1D+xVqz5gwCyiLB/l4TLXVGSafJukdXvAOwf5WMiGTPyMMm
 I88x/1xV2+2dQBXEfxTu1n3l4duan+1APz8X2R5S17jT4LZVUj5MWAtwPbfLT7789a66
 kOVTUyu69GyYehr0SuwwF4Ly4tn2RjIwB3oszufAqvF2njQLDWrbb/JdWBf7NwqfFYtI
 YgKPrZZTm+9flCPefp5r/Nb1JJET/okrvfXYuCOTVJH9BTCrWVLJEQ7yrM5P1OcRbgGb
 qfPzyCIR/YW+8rDrMJfpb92tVjROAg7dMjAMHYMvur09SIFxMX8zircbFptA8+dDsWy7
 zF6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1721973588; x=1722578388;
 h=references:in-reply-to:message-id:date:subject:cc:to:from
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=bCYAojS36KJlYYD+6PO9pHqhAb0FjLUF0zDaVffQqIA=;
 b=hQARX+elRRjPhF0zyBCcPTyVaugNovqLRCuGx5cc4olhzzXqeiK1sKkC8CxF+v+Vts
 MiIRFt5oOcNwj+3jQV2VPBUmh9+ENCagvdZ1cz6VB0DW3lQnRnrMA2fnuElWnl+37UsE
 jREKC4Km30d5wjY6W5sP2kctbnVV+TvSqUJcqFi5eVAx5F1eW7gMkwA1hOJBjFsL0JbT
 1E0gkS2KePlbNCN8dH9qtvHtBh+JhhO6ncxKtNuz9YgTQ4fs6mrb5XjFjP2R5csOQG/T
 XpHOmw6DqLfGH7oPfu+O5gnu7e1BqoJnqVS8ZHDKvn+HO3e3BtBGjcy9jXZJq9SfY9Kj
 aN1g==
X-Gm-Message-State: AOJu0YxEObwJTQGLtWwMXhv8cEZqN4dwvaqwTjldMIUHrg/ho83tIozB
 F/BN6ChUGIPBqyCcv6VOk1iBu2hI+PLqE0WriaAK+xJKWFxEGFqOlFdShOJPTzaAQwhCH8ui00t
 3/IAGm9ENeE4WhfBcF+aJnPSaoiO7+gD6TmGXupwIuTo0FlKEOeBWBwRwPKUYSxDgY7YGwrV3Bz
 qruh+S9ZmAb/OmjhLUBaKHT1wsFfdul46WNQ==
X-Google-Smtp-Source: AGHT+IGA+W8v+q+SNgfOFlbxcuLWDfW5ML3c2jghfHnFeE7EfcANpvVS4STE9xOQiYM0xHNhWGFJBw==
X-Received: by 2002:a05:6a20:4322:b0:1c3:b1d1:db6 with SMTP id
 adf61e73a8af0-1c463693d39mr14118160637.10.1721973588177; 
 Thu, 25 Jul 2024 22:59:48 -0700 (PDT)
Received: from hsinchu26.internal.sifive.com
 (59-124-168-89.hinet-ip.hinet.net. [59.124.168.89])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-70ead6e1a4bsm2002128b3a.5.2024.07.25.22.59.46
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 25 Jul 2024 22:59:47 -0700 (PDT)
From: Jim Shu <jim.shu@sifive.com>
To: qemu-devel@nongnu.org
Cc: "Edgar E. Iglesias" <edgar.iglesias@gmail.com>,
 Alistair Francis <alistair@alistair23.me>,
 Peter Maydell <peter.maydell@linaro.org>, Jason Wang <jasowang@redhat.com>,
 qemu-arm@nongnu.org (open list:Xilinx Zynq), Jim Shu <jim.shu@sifive.com>
Subject: [PATCH 3/4] hw/dma: xilinx_axidma: Reset qemu_irq when DMA/Stream is
 reset
Date: Fri, 26 Jul 2024 13:59:32 +0800
Message-Id: <20240726055933.817-4-jim.shu@sifive.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20240726055933.817-1-jim.shu@sifive.com>
References: <20240726055933.817-1-jim.shu@sifive.com>
Received-SPF: pass client-ip=2607:f8b0:4864:20::42f;
 envelope-from=jim.shu@sifive.com; helo=mail-pf1-x42f.google.com
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

Current DMA/Stream reset will clear interrupt pending bit of DMA device.
The qemu_irq of device should be updated at the same time.

Signed-off-by: Jim Shu <jim.shu@sifive.com>
---
 hw/dma/xilinx_axidma.c | 25 +++++++++++++------------
 1 file changed, 13 insertions(+), 12 deletions(-)

diff --git a/hw/dma/xilinx_axidma.c b/hw/dma/xilinx_axidma.c
index 728246f925..beb3fbf1d5 100644
--- a/hw/dma/xilinx_axidma.c
+++ b/hw/dma/xilinx_axidma.c
@@ -177,11 +177,24 @@ static inline int stream_halted(struct Stream *s)
     return !!(s->regs[R_DMASR] & DMASR_HALTED);
 }
 
+static void stream_update_irq(struct Stream *s)
+{
+    unsigned int pending, mask, irq;
+
+    pending = s->regs[R_DMASR] & DMASR_IRQ_MASK;
+    mask = s->regs[R_DMACR] & DMASR_IRQ_MASK;
+
+    irq = pending & mask;
+
+    qemu_set_irq(s->irq, !!irq);
+}
+
 static void stream_reset(struct Stream *s)
 {
     s->regs[R_DMASR] = DMASR_HALTED;  /* starts up halted.  */
     s->regs[R_DMACR] = 1 << 16; /* Starts with one in compl threshold.  */
     s->sof = true;
+    stream_update_irq(s); /* Clear interrupt */
 }
 
 /* Map an offset addr into a channel index.  */
@@ -249,18 +262,6 @@ static MemTxResult stream_desc_store(struct Stream *s, hwaddr addr)
     return result;
 }
 
-static void stream_update_irq(struct Stream *s)
-{
-    unsigned int pending, mask, irq;
-
-    pending = s->regs[R_DMASR] & DMASR_IRQ_MASK;
-    mask = s->regs[R_DMACR] & DMASR_IRQ_MASK;
-
-    irq = pending & mask;
-
-    qemu_set_irq(s->irq, !!irq);
-}
-
 static void stream_reload_complete_cnt(struct Stream *s)
 {
     unsigned int comp_th;
-- 
2.17.1


