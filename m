Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7F02DD42BBA
	for <qemu-devel@archiver.kernel.org>; Tue, 12 Nov 2024 18:14:29 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tAvNd-0007hv-LQ; Tue, 12 Nov 2024 13:12:45 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tAvNZ-0007PK-Mf
 for qemu-devel@nongnu.org; Tue, 12 Nov 2024 13:12:41 -0500
Received: from mail-wm1-x333.google.com ([2a00:1450:4864:20::333])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tAvNX-00023a-2Y
 for qemu-devel@nongnu.org; Tue, 12 Nov 2024 13:12:41 -0500
Received: by mail-wm1-x333.google.com with SMTP id
 5b1f17b1804b1-4314f38d274so75430075e9.1
 for <qemu-devel@nongnu.org>; Tue, 12 Nov 2024 10:12:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1731435157; x=1732039957; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=toHAwahSX4A1oHkXEKjfL9qzsyS5xjf5aUzpCpynlgA=;
 b=TPSdYAfRx7LyUYWGUBqiHh39ZfQQ7TC8uyFbtrcx1mEcGs6hzCp0KOasIMWYvequPH
 Id2EpIeunjLmokLqn2pVaqUY9otbzaJcif8K7jvitypkPgHGsHeaNxQfQTiWIdSEKPjM
 HVEWUmlMqRcbw4bvTy68QFTiDj5Z72kaDkuuYmAMzlIG1Ev5OaTauAbB/ZSw1a1jiVbj
 RYsjdbiiaFPwVQKVoKKV/jJVvukuvQk2XQBubZnW9TY/yXCbM9d6NFky622hrP1e4y1u
 YZbaT77/U2jpcRHoFAYO97vU1dau64GzFSZySMHV0k54jFgQq8qHnibZIsdJFvV9fQsS
 n80g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1731435157; x=1732039957;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=toHAwahSX4A1oHkXEKjfL9qzsyS5xjf5aUzpCpynlgA=;
 b=b5oSANEZxQZwbIcNdQ0a0FrJUQAvQYqQ2DDlxmWR2uZIiPIJeV30yt+aJEvNJ2Jd/s
 cy0vsvrInBLBaQbDNzbQwqiCzuBljYWKmc+i1kIbqzTT5R732/aCOIZyaNwaSjBSXoEz
 UiRxRJUJ6dv2+W1EzcbGxf7wDNqMFzUVbS+LiBvtNGMdx8dsCX1iV4VZ85zhT1azjDGj
 0icJ3FmwbrnSEDSRxJf66eq5GEwc00nB5CfyRkA76rTaiSxtDp5r/+6tVRS7mROSgu6X
 U2/XH8YorTWtoJkUy5MfLvCDUyvAiiJYn1vz+A2x7L1RCPxUludPCSiXmNmOOwKiIbSG
 CA7A==
X-Gm-Message-State: AOJu0YzxQ+ustCw9h6FFhHb8T5XJDjXKrTOmW8eGmaP+ejSrwSTNyZSp
 JGMLSsHAxldnL7rvxiBn1wj8a1UmqeB8Zl+iMMOLAIjY/yUggyW+1FLw3Sk7eJD0oQ65Cne5dtA
 o
X-Google-Smtp-Source: AGHT+IGJ4C1DA0pFl4GpesJxVHascgNF4xttCRS4MrwMr7gFwJzayFXaOmAREoFpEVQGQPboMhHCPg==
X-Received: by 2002:a05:600c:3b87:b0:431:5ba1:a520 with SMTP id
 5b1f17b1804b1-432b74fec0bmr196747635e9.3.1731435157152; 
 Tue, 12 Nov 2024 10:12:37 -0800 (PST)
Received: from localhost.localdomain
 (cnf78-h01-176-184-27-250.dsl.sta.abo.bbox.fr. [176.184.27.250])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-381ed997391sm16150539f8f.45.2024.11.12.10.12.35
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Tue, 12 Nov 2024 10:12:36 -0800 (PST)
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
Subject: [PATCH 18/20] hw/net/xilinx_ethlite: Map TX_CTRL as MMIO
Date: Tue, 12 Nov 2024 19:10:42 +0100
Message-ID: <20241112181044.92193-19-philmd@linaro.org>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20241112181044.92193-1-philmd@linaro.org>
References: <20241112181044.92193-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::333;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x333.google.com
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

Add TX_CTRL to the TX registers MMIO region.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 hw/net/xilinx_ethlite.c | 56 +++++++++++++++++++----------------------
 1 file changed, 26 insertions(+), 30 deletions(-)

diff --git a/hw/net/xilinx_ethlite.c b/hw/net/xilinx_ethlite.c
index f7a5b1620a..f681b91769 100644
--- a/hw/net/xilinx_ethlite.c
+++ b/hw/net/xilinx_ethlite.c
@@ -39,10 +39,8 @@
 
 #define R_TX_BUF0     0
 #define A_TX_BASE0    0x07f4
-#define R_TX_CTRL0    (0x07fc / 4)
 #define R_TX_BUF1     (0x0800 / 4)
 #define A_TX_BASE1    0x0ff4
-#define R_TX_CTRL1    (0x0ffc / 4)
 
 #define R_RX_BUF0     (0x1000 / 4)
 #define A_RX_BASE0    0x17fc
@@ -55,6 +53,7 @@
 enum {
     TX_LEN =  0,
     TX_GIE =  1,
+    TX_CTRL = 2,
     TX_MAX
 };
 
@@ -71,6 +70,7 @@ enum {
 
 typedef struct XlnxXpsEthLitePort
 {
+    MemoryRegion txio;
     MemoryRegion rxio;
 
     struct {
@@ -143,6 +143,9 @@ static uint64_t port_tx_read(void *opaque, hwaddr addr, unsigned int size)
         case TX_GIE:
             r = s->port[port_index].reg.tx_gie;
             break;
+        case TX_CTRL:
+            r = s->port[port_index].reg.tx_ctrl;
+            break;
         default:
             g_assert_not_reached();
     }
@@ -154,6 +157,7 @@ static void port_tx_write(void *opaque, hwaddr addr, uint64_t value,
                           unsigned int size)
 {
     XlnxXpsEthLite *s = opaque;
+    unsigned port_index = addr_to_port_index(addr);
 
     switch (addr >> 2) {
         case TX_LEN:
@@ -162,6 +166,26 @@ static void port_tx_write(void *opaque, hwaddr addr, uint64_t value,
         case TX_GIE:
             s->port[port_index].reg.tx_gie = value;
             break;
+        case TX_CTRL:
+            if ((value & (CTRL_P | CTRL_S)) == CTRL_S) {
+                qemu_send_packet(qemu_get_queue(s->nic),
+                                 txbuf_ptr(s, port_index),
+                                 s->port[port_index].reg.tx_len);
+                if (s->port[port_index].reg.tx_ctrl & CTRL_I) {
+                    eth_pulse_irq(s);
+                }
+            } else if ((value & (CTRL_P | CTRL_S)) == (CTRL_P | CTRL_S)) {
+                memcpy(&s->conf.macaddr.a[0], txbuf_ptr(s, port_index), 6);
+                if (s->port[port_index].reg.tx_ctrl & CTRL_I) {
+                    eth_pulse_irq(s);
+                }
+            }
+            /*
+             * We are fast and get ready pretty much immediately
+             * so we actually never flip the S nor P bits to one.
+             */
+            s->port[port_index].reg.tx_ctrl = value & ~(CTRL_P | CTRL_S);
+            break;
         default:
             g_assert_not_reached();
     }
@@ -232,18 +256,12 @@ static uint64_t
 eth_read(void *opaque, hwaddr addr, unsigned int size)
 {
     XlnxXpsEthLite *s = opaque;
-    unsigned port_index = addr_to_port_index(addr);
     uint32_t r = 0;
 
     addr >>= 2;
 
     switch (addr)
     {
-        case R_TX_CTRL1:
-        case R_TX_CTRL0:
-            r = s->port[port_index].reg.tx_ctrl;
-            break;
-
         default:
             r = tswap32(s->regs[addr]);
             break;
@@ -256,33 +274,11 @@ eth_write(void *opaque, hwaddr addr,
           uint64_t val64, unsigned int size)
 {
     XlnxXpsEthLite *s = opaque;
-    unsigned int port_index = addr_to_port_index(addr);
     uint32_t value = val64;
 
     addr >>= 2;
     switch (addr) 
     {
-        case R_TX_CTRL0:
-        case R_TX_CTRL1:
-            if ((value & (CTRL_P | CTRL_S)) == CTRL_S) {
-                qemu_send_packet(qemu_get_queue(s->nic),
-                                 txbuf_ptr(s, port_index),
-                                 s->port[port_index].reg.tx_len);
-                if (s->port[port_index].reg.tx_ctrl & CTRL_I) {
-                    eth_pulse_irq(s);
-                }
-            } else if ((value & (CTRL_P | CTRL_S)) == (CTRL_P | CTRL_S)) {
-                memcpy(&s->conf.macaddr.a[0], txbuf_ptr(s, port_index), 6);
-                if (s->port[port_index].reg.tx_ctrl & CTRL_I) {
-                    eth_pulse_irq(s);
-                }
-            }
-
-            /* We are fast and get ready pretty much immediately so
-               we actually never flip the S nor P bits to one.  */
-            s->port[port_index].reg.tx_ctrl = value & ~(CTRL_P | CTRL_S);
-            break;
-
         default:
             s->regs[addr] = tswap32(value);
             break;
-- 
2.45.2


