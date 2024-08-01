Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9C8D5C3DA64
	for <qemu-devel@archiver.kernel.org>; Thu,  1 Aug 2024 14:08:17 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sZWRq-0006eR-KH; Thu, 01 Aug 2024 10:06:30 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jim.shu@sifive.com>)
 id 1sZWRo-0006VM-F5
 for qemu-devel@nongnu.org; Thu, 01 Aug 2024 10:06:28 -0400
Received: from mail-pj1-x1031.google.com ([2607:f8b0:4864:20::1031])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <jim.shu@sifive.com>)
 id 1sZWRk-0006ru-IQ
 for qemu-devel@nongnu.org; Thu, 01 Aug 2024 10:06:26 -0400
Received: by mail-pj1-x1031.google.com with SMTP id
 98e67ed59e1d1-2cd48ad7f0dso5400271a91.0
 for <qemu-devel@nongnu.org>; Thu, 01 Aug 2024 07:06:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sifive.com; s=google; t=1722521182; x=1723125982; darn=nongnu.org;
 h=references:in-reply-to:message-id:date:subject:cc:to:from:from:to
 :cc:subject:date:message-id:reply-to;
 bh=CHB3owSw+cm0RxH1hCZLRPT/ElZgDxKRpTJY+BemXwg=;
 b=NE2LQtfujViqrd2LRH6t1Hj+GYw/OL8/XJVGeXtuPhsYE0D+kvoLWjG1/GctC0QiCN
 rkKOaLHsRK3WbBlVfAwI7YlyBHGWDvaADH9G3l2EWbORdpxJ6MweLQ4lmAtP1AusdPNL
 QpfMLE91RsqXj9W0wVAtMpcfiY1ho1u7s5bDeX7C021F7QYDj4u5mWywYltBzWrcJcsx
 fjzQDNRGXXi9amfBZcJ8KAhbz7gUMnBPlCUVbRJ/6GiG9ufhRRt0rOETbKhixSGXbJ8h
 nluL1pvMfEjnpogQRazfygBGKqVICIuV0rbnepvzbAb2KaGdu8AmdeIKeb9Q8VNA9iRu
 Tsvw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1722521182; x=1723125982;
 h=references:in-reply-to:message-id:date:subject:cc:to:from
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=CHB3owSw+cm0RxH1hCZLRPT/ElZgDxKRpTJY+BemXwg=;
 b=qd0MlTcRAju45qF0FeSgdn/8c+6lLomA+LOMnFu54REmGGRjx1ZsIDwn5q13eC6fny
 UJ/bqNDOENuf1nnJssMnu+iW+7EPypWTsEMUT4JbhP2iW8za4Awj3u/qc2AmS6EUxGEu
 dfdpQBy9GMW368Db8KwCDYaAAv8KKhUMeCNqBbEGs115mV5QCIyArnxuzGWiFE3UWco1
 YmAjp0m/tgNVCyauJPvFIbhAhiNBgP+eX/Su+77X+oGmq75VRGJCWZ+YLL2Y+PDUQ0Mo
 zjnCcpdzuq/0Vm1NERhtWqkIneOw/Eyjlhz9tCd6bO0gXZplvrq+hIlHffNy3OKCXcq3
 JUsA==
X-Gm-Message-State: AOJu0YxUoch7W4c6Dk626IpPJQxvwrtjg4d8zb0iwpRel5h/rAfGnksm
 mz+TgabQasztL38wy3A0E5KQtozWTTL7cFccPFpcujyHevlPgivt/akTk9l6tL9w/n7RQehpowY
 YohzuRXzJFL8OLJWGTo1kt1MKR23ToVPq7qCA7M+x4dtu62eRn813RX+81G/21LOcVdCQdzxIi2
 ClAy/GiR85MBwjNU47GoQYa/Li+mm7pjQ8mnrp
X-Google-Smtp-Source: AGHT+IFxWowPuHLotwvNULGYlHrMhyRdtnGhTAqBwNWaXoAfsWs+XLVdC8gi1UvESGr5ZNK/BNOE5Q==
X-Received: by 2002:a17:90b:1e4c:b0:2c8:858:7035 with SMTP id
 98e67ed59e1d1-2cff948df14mr364635a91.25.1722521181901; 
 Thu, 01 Aug 2024 07:06:21 -0700 (PDT)
Received: from hsinchu26.internal.sifive.com
 (59-124-168-89.hinet-ip.hinet.net. [59.124.168.89])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-1fed7cc0213sm142631275ad.72.2024.08.01.07.06.20
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 01 Aug 2024 07:06:21 -0700 (PDT)
From: Jim Shu <jim.shu@sifive.com>
To: qemu-devel@nongnu.org,
	qemu-riscv@nongnu.org
Cc: Jim Shu <jim.shu@sifive.com>
Subject: [PATCH v2 3/3] hw/net: xilinx_axienet: Fix DMA RX IRQ if ethernet
 disable RX
Date: Thu,  1 Aug 2024 22:06:09 +0800
Message-Id: <20240801140609.26922-4-jim.shu@sifive.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20240801140609.26922-1-jim.shu@sifive.com>
References: <20240801140609.26922-1-jim.shu@sifive.com>
Received-SPF: pass client-ip=2607:f8b0:4864:20::1031;
 envelope-from=jim.shu@sifive.com; helo=mail-pj1-x1031.google.com
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
index 05d41bd548..0ecdc30be6 100644
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
+            if (addr & 1) {
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


