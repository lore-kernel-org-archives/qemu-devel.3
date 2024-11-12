Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D0DEBD42BBA
	for <qemu-devel@archiver.kernel.org>; Tue, 12 Nov 2024 18:13:51 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tAvNO-0006qM-Jh; Tue, 12 Nov 2024 13:12:30 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tAvNB-0005mP-1c
 for qemu-devel@nongnu.org; Tue, 12 Nov 2024 13:12:17 -0500
Received: from mail-wm1-x32a.google.com ([2a00:1450:4864:20::32a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tAvN9-00021E-8U
 for qemu-devel@nongnu.org; Tue, 12 Nov 2024 13:12:16 -0500
Received: by mail-wm1-x32a.google.com with SMTP id
 5b1f17b1804b1-4315eeb2601so75306635e9.2
 for <qemu-devel@nongnu.org>; Tue, 12 Nov 2024 10:12:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1731435133; x=1732039933; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=4nCaOfvRzjvZ75Fs3bp8T2IB7oZkyC8yIZExkGUsnvA=;
 b=d2E2lzYmUqiAjwmqwWBs/RSvo4TlXudGtwBbeMu8d9HwivQnLRJnSl0CtO/lqGdw5C
 klQEiEcS/m2GfYmWTyoJ9ltsBaShwoZr6HZTJY4G7hwhFvAWauvh3xljOr2GPAEq/89B
 09m53NOh/uo0hawjP4Rsp5W7tIeI9ic1fC/CTev6xNoNuC3Xm3M/mPjFPylfZdk0gUyz
 ibYwD9Sr4vFhgGEkKDWjW5WOYIzdryeXZOHr322AbsqTlsfNZmgCsUZ6rNHDMJ1dUNqk
 bb7ih3JeZZdGxgnYMTLFwxE02dygxN1GvAZ4zFFKah2+GA66GujYqt0mKpzBnilQxLiq
 WAVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1731435133; x=1732039933;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=4nCaOfvRzjvZ75Fs3bp8T2IB7oZkyC8yIZExkGUsnvA=;
 b=TS1o8y7JVXTNW7TvwVUPQl1LX3+OqMumw5m+5yojqdxtNHRtfebWhBjVF+BMDo7Rzl
 vE4ATTCBJ+CjAHp+q+NCBsQi8Q7b0fczUCsHEw3ouWRDUz2Ww9pba9WQPw73koDSX/PZ
 TAQxxzO4nKT+OV5mSk9qdYIJi/b1irNv/9a7Xevi1jTFtFbNMaRvD8nWmGVrgP0ONZh+
 Tf0EePgA4CvXUPf3JZS7sY7VlAXyv+k0FXzViCLtMru5U8O6gX613ypt16vuuM1HNQd6
 lJDyV+sG+r782yltNbUJwOx7Oi5VbqIewwSPGE+GAz3PCrTY2EZFIl8u3mBTgV4cwuiG
 U7Yw==
X-Gm-Message-State: AOJu0YxZpgdYHiUMsdNHJpsXO0R2+hf5h3wkXkVCbO+MO6i7nEoLj98y
 RG4HQB4bzV1zk2PNW3nfspXVq3bJvg9fx2z1BEBRypRwoBhU8RwEpezyJDD9a/NayKWMwB/A93s
 3
X-Google-Smtp-Source: AGHT+IFgpPxUG5b3T9HtrgoCVqOLI4PZbxsGXVj1QmSN+kbygjqdsXMfKmRmS2U5ch4GJzN73psr9Q==
X-Received: by 2002:a5d:6d05:0:b0:37d:4c40:699 with SMTP id
 ffacd0b85a97d-381f1866b54mr19039210f8f.5.1731435133425; 
 Tue, 12 Nov 2024 10:12:13 -0800 (PST)
Received: from localhost.localdomain
 (cnf78-h01-176-184-27-250.dsl.sta.abo.bbox.fr. [176.184.27.250])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-381ed970e23sm15919690f8f.18.2024.11.12.10.12.11
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Tue, 12 Nov 2024 10:12:12 -0800 (PST)
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
Subject: [PATCH 14/20] hw/net/xilinx_ethlite: Access TX_CTRL register for each
 port
Date: Tue, 12 Nov 2024 19:10:38 +0100
Message-ID: <20241112181044.92193-15-philmd@linaro.org>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20241112181044.92193-1-philmd@linaro.org>
References: <20241112181044.92193-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32a;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x32a.google.com
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
region as indexed register, declare a per-port TX_CTRL. This
will help to map the RAM as RAM (keeping MMIO as MMIO) in few
commits.

Previous s->regs[R_TX_CTRL0] and s->regs[R_TX_CTRL1] are now
unused. Not a concern, this array will soon disappear.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 hw/net/xilinx_ethlite.c | 15 +++++++--------
 1 file changed, 7 insertions(+), 8 deletions(-)

diff --git a/hw/net/xilinx_ethlite.c b/hw/net/xilinx_ethlite.c
index 1a3b295b4b..4d86851f38 100644
--- a/hw/net/xilinx_ethlite.c
+++ b/hw/net/xilinx_ethlite.c
@@ -64,6 +64,7 @@ typedef struct XlnxXpsEthLitePort
     struct {
         uint32_t tx_len;
         uint32_t tx_gie;
+        uint32_t tx_ctrl;
 
         uint32_t rx_ctrl;
     } reg;
@@ -139,7 +140,7 @@ eth_read(void *opaque, hwaddr addr, unsigned int size)
 
         case R_TX_CTRL1:
         case R_TX_CTRL0:
-            r = s->regs[addr];
+            r = s->port[port_index].reg.tx_ctrl;
             break;
 
         case R_RX_CTRL1:
@@ -159,7 +160,6 @@ eth_write(void *opaque, hwaddr addr,
 {
     XlnxXpsEthLite *s = opaque;
     unsigned int port_index = addr_to_port_index(addr);
-    unsigned int base = 0;
     uint32_t value = val64;
 
     addr >>= 2;
@@ -167,24 +167,23 @@ eth_write(void *opaque, hwaddr addr,
     {
         case R_TX_CTRL0:
         case R_TX_CTRL1:
-            if (addr == R_TX_CTRL1)
-                base = 0x800 / 4;
-
             if ((value & (CTRL_P | CTRL_S)) == CTRL_S) {
                 qemu_send_packet(qemu_get_queue(s->nic),
                                  txbuf_ptr(s, port_index),
                                  s->port[port_index].reg.tx_len);
-                if (s->regs[base + R_TX_CTRL0] & CTRL_I)
+                if (s->port[port_index].reg.tx_ctrl & CTRL_I) {
                     eth_pulse_irq(s);
+                }
             } else if ((value & (CTRL_P | CTRL_S)) == (CTRL_P | CTRL_S)) {
                 memcpy(&s->conf.macaddr.a[0], txbuf_ptr(s, port_index), 6);
-                if (s->regs[base + R_TX_CTRL0] & CTRL_I)
+                if (s->port[port_index].reg.tx_ctrl & CTRL_I) {
                     eth_pulse_irq(s);
+                }
             }
 
             /* We are fast and get ready pretty much immediately so
                we actually never flip the S nor P bits to one.  */
-            s->regs[addr] = value & ~(CTRL_P | CTRL_S);
+            s->port[port_index].reg.tx_ctrl = value & ~(CTRL_P | CTRL_S);
             break;
 
         /* Keep these native.  */
-- 
2.45.2


