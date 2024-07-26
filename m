Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B0F89C3DA70
	for <qemu-devel@archiver.kernel.org>; Fri, 26 Jul 2024 06:01:03 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sXDzk-0001oF-9q; Fri, 26 Jul 2024 02:00:00 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jim.shu@sifive.com>)
 id 1sXDzi-0001j9-IP
 for qemu-devel@nongnu.org; Fri, 26 Jul 2024 01:59:58 -0400
Received: from mail-oa1-x2a.google.com ([2001:4860:4864:20::2a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <jim.shu@sifive.com>)
 id 1sXDzg-0006xE-SP
 for qemu-devel@nongnu.org; Fri, 26 Jul 2024 01:59:58 -0400
Received: by mail-oa1-x2a.google.com with SMTP id
 586e51a60fabf-260209df55dso543173fac.2
 for <qemu-devel@nongnu.org>; Thu, 25 Jul 2024 22:59:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sifive.com; s=google; t=1721973591; x=1722578391; darn=nongnu.org;
 h=references:in-reply-to:message-id:date:subject:cc:to:from:from:to
 :cc:subject:date:message-id:reply-to;
 bh=9Za57CxWKyfgLnTqPQsh6nioQ4Nt2VfZ5IqfZz3w8wU=;
 b=j3lx9LmN36cst56okxcZR17ZWd4RH96C0R0fq4wuyqD0twF9FmJDYGjE6qRBp3bMps
 +5ikP/h7Wf8SYxNwsFe7+qVmvRooQhL/Yl+xPLgZ1Wrv1WhUreN2zV5R1DruG6f9ghtX
 6dIL0lmRUxBPahoRrmaCMQBK+dvMiRtuhr0ZhUluj6hDfTFqzUx7Pvk6UpmSqa3E+jIV
 dwKtSl4krl5sMuk1qpSnRWKBcHC6rjXt2mBobq5V8FQvP9iRnEa4vSjCvBhgtOOLZR4Y
 fDFH33pHDIMscOzRH0Bf456dyBrbZDs7ppm1C02lWOGAIQh4GJVBtEAvxqVJ/bV/H2Tm
 LZHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1721973591; x=1722578391;
 h=references:in-reply-to:message-id:date:subject:cc:to:from
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=9Za57CxWKyfgLnTqPQsh6nioQ4Nt2VfZ5IqfZz3w8wU=;
 b=VHJ9TieZJf3VbvcbbcULDq/4TCnKTLkmSuZdNrEvd+GsfmhEx/iQUhvzlRz1AD55Al
 rIwsUSOC3eBRcTJJdqmuYKTLiMxjPnBJgZbCoexzzoQj0nQv+tSClqYVsEq0S23QYrBH
 vRNCx1Ms0WFIxX5ZmyVEPZx6OTaat4iRBoDncN+8dQVPXLT1L8+1rPAGyrWKfG9IdnqP
 HXIgT0RitkKIqA034eLRF+Faqv7GDBDIooDQOxsZCwueVjIMquvDFJ+DwFKZLLVk/UlP
 M3XdZEzZdAeJiQ5rufnQYqkjVcHhngwxlgGLOCFL8FcHDv8aa6gNKg9nNBrOoq/Ootai
 eDjQ==
X-Gm-Message-State: AOJu0YytIyX6kTSmwn1QhrrogVBxkSNUeJBJ8crYvuQT6qmzp8NZqJ49
 WehG8CrXBbSa4bZfmUEqdUE67EPt8ijGChjfMnVwNjLIBM+CHGhGtssT56kcJPUH3cDSuAsLroQ
 EJ+25n9bT7rIdAnHkXn9jQMvpoHjdnuZgZZVuDRfBtjiwkWaD8GIbg4t7AeYJOrHm+ZOar7nvrA
 au9VdfjsLDbbWG5SKQFG7kcfB37/z/sOULEg==
X-Google-Smtp-Source: AGHT+IG54otcxzNYIjaBWXxWcE3vN8zSciDeBkaUgw+C25akiG2RjhXuOmwc1jFMwWvv8dTYbxSyMQ==
X-Received: by 2002:a05:6870:c1cf:b0:25d:f285:d008 with SMTP id
 586e51a60fabf-266cc1f0195mr5245876fac.7.1721973591059; 
 Thu, 25 Jul 2024 22:59:51 -0700 (PDT)
Received: from hsinchu26.internal.sifive.com
 (59-124-168-89.hinet-ip.hinet.net. [59.124.168.89])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-70ead6e1a4bsm2002128b3a.5.2024.07.25.22.59.49
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 25 Jul 2024 22:59:50 -0700 (PDT)
From: Jim Shu <jim.shu@sifive.com>
To: qemu-devel@nongnu.org
Cc: "Edgar E. Iglesias" <edgar.iglesias@gmail.com>,
 Alistair Francis <alistair@alistair23.me>,
 Peter Maydell <peter.maydell@linaro.org>, Jason Wang <jasowang@redhat.com>,
 qemu-arm@nongnu.org (open list:Xilinx Zynq), Jim Shu <jim.shu@sifive.com>
Subject: [PATCH 4/4] hw/net: xilinx_axienet: Fix DMA RX IRQ if ethernet
 disable RX
Date: Fri, 26 Jul 2024 13:59:33 +0800
Message-Id: <20240726055933.817-5-jim.shu@sifive.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20240726055933.817-1-jim.shu@sifive.com>
References: <20240726055933.817-1-jim.shu@sifive.com>
Received-SPF: pass client-ip=2001:4860:4864:20::2a;
 envelope-from=jim.shu@sifive.com; helo=mail-oa1-x2a.google.com
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

When AXI ethernet RX is disabled, it shouldn't send packets to AXI DMA,
which may let AXI DMA to send RX full IRQs. It is aligned with real AXI
DMA/ethernet IP behavior in the FPGA.

Also, now ethernet RX blocks the RX packets when it is disabled. It
should send and clear the remaining RX packets when enabling it.

Signed-off-by: Jim Shu <jim.shu@sifive.com>
---
 hw/net/xilinx_axienet.c | 71 ++++++++++++++++++++++++-----------------
 1 file changed, 42 insertions(+), 29 deletions(-)

diff --git a/hw/net/xilinx_axienet.c b/hw/net/xilinx_axienet.c
index 05d41bd548..8428f10946 100644
--- a/hw/net/xilinx_axienet.c
+++ b/hw/net/xilinx_axienet.c
@@ -530,6 +530,40 @@ static uint64_t enet_read(void *opaque, hwaddr addr, unsigned size)
     return r;
 }
 
+static void axienet_eth_rx_notify(void *opaque)
+{
+    XilinxAXIEnet *s = XILINX_AXI_ENET(opaque);
+
+    /* If RX is disabled, don't trigger DMA to update RX desc and send IRQ */
+    if (!axienet_rx_enabled(s)) {
+        return;
+    }
+
+    while (s->rxappsize && stream_can_push(s->tx_control_dev,
+                                           axienet_eth_rx_notify, s)) {
+        size_t ret = stream_push(s->tx_control_dev,
+                                 (void *)s->rxapp + CONTROL_PAYLOAD_SIZE
+                                 - s->rxappsize, s->rxappsize, true);
+        s->rxappsize -= ret;
+    }
+
+    while (s->rxsize && stream_can_push(s->tx_data_dev,
+                                        axienet_eth_rx_notify, s)) {
+        size_t ret = stream_push(s->tx_data_dev, (void *)s->rxmem + s->rxpos,
+                                 s->rxsize, true);
+        s->rxsize -= ret;
+        s->rxpos += ret;
+        if (!s->rxsize) {
+            s->regs[R_IS] |= IS_RX_COMPLETE;
+            if (s->need_flush) {
+                s->need_flush = false;
+                qemu_flush_queued_packets(qemu_get_queue(s->nic));
+            }
+        }
+    }
+    enet_update_irq(s);
+}
+
 static void enet_write(void *opaque, hwaddr addr,
                        uint64_t value, unsigned size)
 {
@@ -546,6 +580,14 @@ static void enet_write(void *opaque, hwaddr addr,
             } else {
                 qemu_flush_queued_packets(qemu_get_queue(s->nic));
             }
+
+            /*
+             * When RX is enabled, check if any remaining data in rxmem
+             * and send them.
+             */
+            if ((addr & 1) && s->rcw[addr & 1] & RCW1_RX) {
+                axienet_eth_rx_notify(s);
+            }
             break;
 
         case R_TC:
@@ -666,35 +708,6 @@ static int enet_match_addr(const uint8_t *buf, uint32_t f0, uint32_t f1)
     return match;
 }
 
-static void axienet_eth_rx_notify(void *opaque)
-{
-    XilinxAXIEnet *s = XILINX_AXI_ENET(opaque);
-
-    while (s->rxappsize && stream_can_push(s->tx_control_dev,
-                                           axienet_eth_rx_notify, s)) {
-        size_t ret = stream_push(s->tx_control_dev,
-                                 (void *)s->rxapp + CONTROL_PAYLOAD_SIZE
-                                 - s->rxappsize, s->rxappsize, true);
-        s->rxappsize -= ret;
-    }
-
-    while (s->rxsize && stream_can_push(s->tx_data_dev,
-                                        axienet_eth_rx_notify, s)) {
-        size_t ret = stream_push(s->tx_data_dev, (void *)s->rxmem + s->rxpos,
-                                 s->rxsize, true);
-        s->rxsize -= ret;
-        s->rxpos += ret;
-        if (!s->rxsize) {
-            s->regs[R_IS] |= IS_RX_COMPLETE;
-            if (s->need_flush) {
-                s->need_flush = false;
-                qemu_flush_queued_packets(qemu_get_queue(s->nic));
-            }
-        }
-    }
-    enet_update_irq(s);
-}
-
 static ssize_t eth_rx(NetClientState *nc, const uint8_t *buf, size_t size)
 {
     XilinxAXIEnet *s = qemu_get_nic_opaque(nc);
-- 
2.17.1


