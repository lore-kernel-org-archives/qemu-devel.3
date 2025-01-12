Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AD525E77188
	for <qemu-devel@archiver.kernel.org>; Sun, 12 Jan 2025 22:25:22 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tX6Hn-0007hl-SJ; Sun, 12 Jan 2025 17:18:23 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tX6Hm-0007hB-Gh
 for qemu-devel@nongnu.org; Sun, 12 Jan 2025 17:18:22 -0500
Received: from mail-wm1-x329.google.com ([2a00:1450:4864:20::329])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tX6Hk-0006R5-Or
 for qemu-devel@nongnu.org; Sun, 12 Jan 2025 17:18:22 -0500
Received: by mail-wm1-x329.google.com with SMTP id
 5b1f17b1804b1-43635796b48so22728685e9.0
 for <qemu-devel@nongnu.org>; Sun, 12 Jan 2025 14:18:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1736720299; x=1737325099; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Ns13WgDbPYyZM/L1QpNS/fo2t3Mk0eblekogE1hWgpE=;
 b=IIwMgKp0Km7fFdvbVx08dCYVLUgr0IjdLs4+Pvd+bxqs37WGzzoKOOMu2jxms5NRs8
 96Wlvn6/iJfMpdhci6bgFVt7ZmOlEsuHahsmg2yuDKtZB2fcFwCL96Ni2DdNcnfqMMFx
 joLbnVVP9/pK2Sy2coqtzg9t2eEGJsXvRk4eP/f7/nH2GBPDuEjbNOBe726kItT+YTPy
 CgwbU+wVd4eKoIyAkpxh6bhQixmX5HzAwt2wZg2b4rw90EGniULOUVWw/TLwzvrsmrde
 8zZ52uMcTopa/ek2VrnVkC2hfE/qmmRkgrh+IE+1vUUzYfApd+PQMjBSm+cjZwgptNfO
 /QKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1736720299; x=1737325099;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Ns13WgDbPYyZM/L1QpNS/fo2t3Mk0eblekogE1hWgpE=;
 b=Xl/PINbRVgTzeKFxOvDfNCVHqyMUrCNxoeHoZ8UBBH6aOYVSJt95EuESiZjositoOH
 2mCQsBRHuV5LjVQcni+iFqWAxa8rhxM3iWTXZObTW2Rq196SULSngm4ajSLS0a7OYxot
 ZRYPBwrhQ22je66CFOR2toKQ6TjoAERRE0vBpUO6qJJN0zHgOnhmxJFcLMo0N+dYHUsI
 oMvdgoTE1zwbUDHO5estKFICKmiWwEaQ5QsRJno1w9Dajs5sRbz8o0w7iRghLh70I9OL
 4CbzT4t/Enh/E4csOeyqBgIGObv/guy2pSgNLu72FU7KHDF8g3dHE8VKQ3qtn35CN47W
 uIOQ==
X-Gm-Message-State: AOJu0YyeHAZN6s/s5CXQOga5EK77Cn2kNLwlloSfidAtH2UW36DxUGcR
 wGM/TKcEmz9ctevoLb1E9VZlFAiIoeLL/yeaf9yle0VW80Uw0M6A/B4bficLpUpkiK9JbnfbXTj
 Vj58=
X-Gm-Gg: ASbGncvHcNTnW1LUzfwsZHbvHe82njqfGs+DoPQgOBCogFukmgYWOFpITsBtTXyUulw
 Hx2Ms52HudmTb48MVP13i0FvYZz027QKxNbY/LMPu+rn3T2jR40nGukBQRsczA3Hiy58dSPOBOA
 jbOVCbOHMiX8rAKv0ze8smFJ7Uw4gcCvbtPNcG4lvEpuVCfPNZGhjbUCLmdW5e55hoDu357bvN+
 /OOMzpVmDGPEOp1D4bMdNKZuZqXX5Fyokx++HIUgAWehGdCA7PtJWqZOAxPxrmv+XHpb60NFu1Y
 tFSVlprHYz5aC8qi5xUShcR8UJlO03I=
X-Google-Smtp-Source: AGHT+IEc3GX3blyVqqtr4KgIFbtdZCepDzpMYZWzOVkVg4H7XJdk0r11hgSqzHmI6KH67UKzQmy3Rg==
X-Received: by 2002:a05:600c:1d02:b0:434:e69c:d338 with SMTP id
 5b1f17b1804b1-436e9d6ff89mr105271845e9.5.1736720298922; 
 Sun, 12 Jan 2025 14:18:18 -0800 (PST)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-436e9d8fc81sm124720305e9.5.2025.01.12.14.18.17
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Sun, 12 Jan 2025 14:18:18 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 "Edgar E. Iglesias" <edgar.iglesias@amd.com>
Subject: [PULL 10/49] hw/net/xilinx_ethlite: Introduce rxbuf_ptr() helper
Date: Sun, 12 Jan 2025 23:16:46 +0100
Message-ID: <20250112221726.30206-11-philmd@linaro.org>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250112221726.30206-1-philmd@linaro.org>
References: <20250112221726.30206-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::329;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x329.google.com
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

rxbuf_ptr() points to the beginning of a (RAM) RX buffer
within the device state.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Edgar E. Iglesias <edgar.iglesias@amd.com>
Message-Id: <20241112181044.92193-11-philmd@linaro.org>
---
 hw/net/xilinx_ethlite.c | 39 +++++++++++++++++++++++++++++----------
 1 file changed, 29 insertions(+), 10 deletions(-)

diff --git a/hw/net/xilinx_ethlite.c b/hw/net/xilinx_ethlite.c
index 8df621904a1..67adecc0883 100644
--- a/hw/net/xilinx_ethlite.c
+++ b/hw/net/xilinx_ethlite.c
@@ -60,6 +60,12 @@
 #define CTRL_P     0x2
 #define CTRL_S     0x1
 
+typedef struct XlnxXpsEthLitePort {
+    struct {
+        uint32_t rx_ctrl;
+    } reg;
+} XlnxXpsEthLitePort;
+
 #define TYPE_XILINX_ETHLITE "xlnx.xps-ethernetlite"
 OBJECT_DECLARE_SIMPLE_TYPE(XlnxXpsEthLite, XILINX_ETHLITE)
 
@@ -77,6 +83,7 @@ struct XlnxXpsEthLite
     unsigned int port_index; /* dual port RAM index */
 
     UnimplementedDeviceState mdio;
+    XlnxXpsEthLitePort port[2];
     uint32_t regs[R_MAX];
 };
 
@@ -100,10 +107,18 @@ static void *txbuf_ptr(XlnxXpsEthLite *s, unsigned port_index)
     return &s->regs[rxbase + R_TX_BUF0];
 }
 
+static void *rxbuf_ptr(XlnxXpsEthLite *s, unsigned port_index)
+{
+    unsigned int rxbase = port_index * (0x800 / 4);
+
+    return &s->regs[rxbase + R_RX_BUF0];
+}
+
 static uint64_t
 eth_read(void *opaque, hwaddr addr, unsigned int size)
 {
     XlnxXpsEthLite *s = opaque;
+    unsigned port_index = addr_to_port_index(addr);
     uint32_t r = 0;
 
     addr >>= 2;
@@ -115,9 +130,12 @@ eth_read(void *opaque, hwaddr addr, unsigned int size)
         case R_TX_LEN1:
         case R_TX_CTRL1:
         case R_TX_CTRL0:
+            r = s->regs[addr];
+            break;
+
         case R_RX_CTRL1:
         case R_RX_CTRL0:
-            r = s->regs[addr];
+            r = s->port[port_index].reg.rx_ctrl;
             break;
 
         default:
@@ -167,7 +185,9 @@ eth_write(void *opaque, hwaddr addr,
             if (!(value & CTRL_S)) {
                 qemu_flush_queued_packets(qemu_get_queue(s->nic));
             }
-            /* fall through */
+            s->port[port_index].reg.rx_ctrl = value;
+            break;
+
         case R_TX_LEN0:
         case R_TX_LEN1:
         case R_TX_GIE0:
@@ -197,22 +217,21 @@ static const MemoryRegionOps eth_ops = {
 static bool eth_can_rx(NetClientState *nc)
 {
     XlnxXpsEthLite *s = qemu_get_nic_opaque(nc);
-    unsigned int rxbase = s->port_index * (0x800 / 4);
 
-    return !(s->regs[rxbase + R_RX_CTRL0] & CTRL_S);
+    return !(s->port[s->port_index].reg.rx_ctrl & CTRL_S);
 }
 
 static ssize_t eth_rx(NetClientState *nc, const uint8_t *buf, size_t size)
 {
     XlnxXpsEthLite *s = qemu_get_nic_opaque(nc);
-    unsigned int rxbase = s->port_index * (0x800 / 4);
+    unsigned int port_index = s->port_index;
 
     /* DA filter.  */
     if (!(buf[0] & 0x80) && memcmp(&s->conf.macaddr.a[0], buf, 6))
         return size;
 
-    if (s->regs[rxbase + R_RX_CTRL0] & CTRL_S) {
-        trace_ethlite_pkt_lost(s->regs[R_RX_CTRL0]);
+    if (s->port[port_index].reg.rx_ctrl & CTRL_S) {
+        trace_ethlite_pkt_lost(s->port[port_index].reg.rx_ctrl);
         return -1;
     }
 
@@ -220,10 +239,10 @@ static ssize_t eth_rx(NetClientState *nc, const uint8_t *buf, size_t size)
         trace_ethlite_pkt_size_too_big(size);
         return -1;
     }
-    memcpy(&s->regs[rxbase + R_RX_BUF0], buf, size);
+    memcpy(rxbuf_ptr(s, port_index), buf, size);
 
-    s->regs[rxbase + R_RX_CTRL0] |= CTRL_S;
-    if (s->regs[R_RX_CTRL0] & CTRL_I) {
+    s->port[port_index].reg.rx_ctrl |= CTRL_S;
+    if (s->port[port_index].reg.rx_ctrl & CTRL_I) {
         eth_pulse_irq(s);
     }
 
-- 
2.47.1


