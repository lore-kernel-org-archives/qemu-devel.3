Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B350DD42BBA
	for <qemu-devel@archiver.kernel.org>; Tue, 12 Nov 2024 18:14:24 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tAvNG-00064i-At; Tue, 12 Nov 2024 13:12:22 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tAvMy-0005TV-50
 for qemu-devel@nongnu.org; Tue, 12 Nov 2024 13:12:07 -0500
Received: from mail-wm1-x329.google.com ([2a00:1450:4864:20::329])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tAvMw-0001yi-06
 for qemu-devel@nongnu.org; Tue, 12 Nov 2024 13:12:03 -0500
Received: by mail-wm1-x329.google.com with SMTP id
 5b1f17b1804b1-4316cce103dso75272755e9.3
 for <qemu-devel@nongnu.org>; Tue, 12 Nov 2024 10:11:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1731435117; x=1732039917; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=90u2pbXGOCmIRt7v1T1RJKt/kgJQ6BpSNcFSvHFisE0=;
 b=STnerbudDb1Q7FXX+K8frKsaQz4r7B+S/PkQdELdzfO03HGTBozhsjoTR/i4qG7eiJ
 aS8IkvFB6CGndI3zTB6oEYtp5HLjYR6V8aUqF+qu5I7AI6Tr1LVSkxuW8Act0oO9rAaC
 Gecuyqa7V49bnFKxPEUm3vAayM/pIv2/xwLgpcfY+T3lUrDgfqDo/bhuu92ptUa5Yv+q
 2yNBOBVNBCeqHFcTDrXB65YXvhRXgXPlH5EJAkoJ56qgfSz7lWW0fttl3I9hfiM7umMS
 7RxZnU+lbV0Ky5n0pfCZNNP+NnEhhrfLp6/RuR8b94DXUF8P8jJoo6tBRYh/TPoE9jgi
 a6DA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1731435117; x=1732039917;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=90u2pbXGOCmIRt7v1T1RJKt/kgJQ6BpSNcFSvHFisE0=;
 b=PplenUPO2NszqTjVlryzFPIU1iGNXRhBWjxPfZahr+HIQ8ATMb088hRqt6uq5IPLYS
 BJclMhBu1US+/PnZRF2+tpO6YHSH4FwUV/bjLEDK7FURcFQAlEbPs+UonGH72G3xhQEY
 gzebZz3hmPMowb6K1hNowiMcwl369UfQC6KnkbsQYIAXO54sDWXrwhnV7mjq6wvpS9wR
 Y3NmudpYrGy+OZhpY9ThdCzZVpt2FMN5c3beBh21FNY3jQ94C1U7rZ3o4CwZf9V84nmm
 Wcz5JQFrAG1tdp4jM+k8I3qC+tBojY+89B+T3N/bui+L8dpOBIWniWZbiwbRYjPtMZUD
 PqEQ==
X-Gm-Message-State: AOJu0YzyV4u0fRHbyLXnf3bF4B4esNZL9DgGhnt3uq+OCa5WHYlsGCFv
 Lm4NXDsHmz8yYqlF0IAdLc0X8XxClX95JzVBJiFhUjmtAn7f6Adwh0ibb/1unGvCxiDQkxXKoMX
 Z
X-Google-Smtp-Source: AGHT+IHtXi8iiUapm1TTUiMS/geV1SJOX6Dj5AuKi6Te8F7KhqH1L0+qYyUQbMzHWeFgLUNZwydJcQ==
X-Received: by 2002:a05:600c:3c99:b0:42c:ba83:3f00 with SMTP id
 5b1f17b1804b1-432b74febf4mr191045485e9.1.1731435115823; 
 Tue, 12 Nov 2024 10:11:55 -0800 (PST)
Received: from localhost.localdomain
 (cnf78-h01-176-184-27-250.dsl.sta.abo.bbox.fr. [176.184.27.250])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-432b05e5871sm219236105e9.37.2024.11.12.10.11.54
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Tue, 12 Nov 2024 10:11:55 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: "Edgar E. Iglesias" <edgar.iglesias@gmail.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Peter Maydell <peter.maydell@linaro.org>, Anton Johansson <anjo@rev.ng>,
 Jason Wang <jasowang@redhat.com>, qemu-arm@nongnu.org,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Thomas Huth <thuth@redhat.com>, Alistair Francis <alistair@alistair23.me>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Gustavo Romero <gustavo.romero@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH 11/20] hw/net/xilinx_ethlite: Access RX_CTRL register for each
 port
Date: Tue, 12 Nov 2024 19:10:35 +0100
Message-ID: <20241112181044.92193-12-philmd@linaro.org>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20241112181044.92193-1-philmd@linaro.org>
References: <20241112181044.92193-1-philmd@linaro.org>
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

Rather than accessing the registers within the mixed RAM/MMIO
region as indexed register, declare a per-port RX_CTRL. This
will help to map the RAM as RAM (keeping MMIO as MMIO) in few
commits.

Previous s->regs[R_RX_CTRL0] and s->regs[R_RX_CTRL1] are now
unused. Not a concern, this array will soon disappear.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 hw/net/xilinx_ethlite.c | 31 +++++++++++++++++++++----------
 1 file changed, 21 insertions(+), 10 deletions(-)

diff --git a/hw/net/xilinx_ethlite.c b/hw/net/xilinx_ethlite.c
index fdbf25fd91..605451a522 100644
--- a/hw/net/xilinx_ethlite.c
+++ b/hw/net/xilinx_ethlite.c
@@ -59,6 +59,13 @@
 #define CTRL_P     0x2
 #define CTRL_S     0x1
 
+typedef struct XlnxXpsEthLitePort
+{
+    struct {
+        uint32_t rx_ctrl;
+    } reg;
+} XlnxXpsEthLitePort;
+
 #define TYPE_XILINX_ETHLITE "xlnx.xps-ethernetlite"
 OBJECT_DECLARE_SIMPLE_TYPE(XlnxXpsEthLite, XILINX_ETHLITE)
 
@@ -76,6 +83,7 @@ struct XlnxXpsEthLite
     unsigned int port_index;
 
     UnimplementedDeviceState mdio;
+    XlnxXpsEthLitePort port[2];
     uint32_t regs[R_MAX];
 };
 
@@ -110,6 +118,7 @@ static uint64_t
 eth_read(void *opaque, hwaddr addr, unsigned int size)
 {
     XlnxXpsEthLite *s = opaque;
+    unsigned port_index = addr_to_port_index(addr);
     uint32_t r = 0;
 
     addr >>= 2;
@@ -121,11 +130,13 @@ eth_read(void *opaque, hwaddr addr, unsigned int size)
         case R_TX_LEN1:
         case R_TX_CTRL1:
         case R_TX_CTRL0:
-        case R_RX_CTRL1:
-        case R_RX_CTRL0:
             r = s->regs[addr];
             break;
 
+        case R_RX_CTRL1:
+        case R_RX_CTRL0:
+            r = s->port[port_index].reg.rx_ctrl;
+
         default:
             r = tswap32(s->regs[addr]);
             break;
@@ -173,7 +184,9 @@ eth_write(void *opaque, hwaddr addr,
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
@@ -203,23 +216,21 @@ static const MemoryRegionOps eth_ops = {
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
     unsigned int port_index = s->port_index;
-    unsigned int rxbase = port_index * (0x800 / 4);
 
     /* DA filter.  */
     if (!(buf[0] & 0x80) && memcmp(&s->conf.macaddr.a[0], buf, 6))
         return size;
 
-    if (s->regs[rxbase + R_RX_CTRL0] & CTRL_S) {
-        trace_ethlite_pkt_lost(s->regs[R_RX_CTRL0]);
+    if (s->port[port_index].reg.rx_ctrl & CTRL_S) {
+        trace_ethlite_pkt_lost(s->port[port_index].reg.rx_ctrl);
         return -1;
     }
 
@@ -229,8 +240,8 @@ static ssize_t eth_rx(NetClientState *nc, const uint8_t *buf, size_t size)
     }
     memcpy(rxbuf_ptr(s, port_index), buf, size);
 
-    s->regs[rxbase + R_RX_CTRL0] |= CTRL_S;
-    if (s->regs[R_RX_CTRL0] & CTRL_I) {
+    s->port[port_index].reg.rx_ctrl |= CTRL_S;
+    if (s->port[port_index].reg.rx_ctrl & CTRL_I) {
         eth_pulse_irq(s);
     }
 
-- 
2.45.2


