Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 87288D42BBA
	for <qemu-devel@archiver.kernel.org>; Tue, 12 Nov 2024 18:19:03 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tAvMI-0004zV-FF; Tue, 12 Nov 2024 13:11:23 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tAvM9-0004xu-O2
 for qemu-devel@nongnu.org; Tue, 12 Nov 2024 13:11:14 -0500
Received: from mail-wm1-x331.google.com ([2a00:1450:4864:20::331])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tAvM7-0001t7-KW
 for qemu-devel@nongnu.org; Tue, 12 Nov 2024 13:11:12 -0500
Received: by mail-wm1-x331.google.com with SMTP id
 5b1f17b1804b1-431688d5127so47752925e9.0
 for <qemu-devel@nongnu.org>; Tue, 12 Nov 2024 10:11:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1731435068; x=1732039868; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=oH/SQSX4OUP5TxQrfvghzIartXS3npm2RFGdjSdA9Ng=;
 b=BsBqowxgsurXN+MW6A3LRV+KZr5BOOdjPGZucOjzunOoUzzFfggFvN7yKNzSwsnej2
 jxdN/eIYLa3CgaDZHa/TMjgpN1bFfsxI933n5lCbRGMEHivZWxxjsLnEsxS31Lcq+pLb
 7mBbZPbm8QijRukU32EyHrwrMX3Kfv95I8JJpSqir2Qt0n58AXnlq5M96SPEPfkUO2gu
 TnIib27NBNKlzng0Kzb42CkNtlIdVDJrQc+526oo7eVa9/0wi18uNB9TYT5BS5pSYQYH
 fGJ1oyY1FPhzZv7QDEwkIerWu31gpIITRYW1SLFKq7PVMJvyISezcsGBVYk3NKq/FFib
 TepA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1731435068; x=1732039868;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=oH/SQSX4OUP5TxQrfvghzIartXS3npm2RFGdjSdA9Ng=;
 b=HeakYu8Ii0R75PDPv7vFcDPyb3AIRzzxqcUdSRw/kCaU6xlq0V8w9g9QL8t07oooca
 RIUHq2f1PIDBz5gLE2wZ819K7TL2tVDWP9UbNfaYjzusReDkixNmbmHJ6UafCLJKJ05i
 DboUnOlqIMBfjDk6vdk9Ie13Y6JUGIPI7tpUka5+dwrGvui0N5um8n70eZ0zmHwesAsm
 7x5BHPw2JcupCgwSOUgGFpVTxLGDJ3rSvLHhmv1rnL+mFqa/dia8Kz0LFZdl4Cc7zyPU
 /o3WvkCKaLERvMlIRNO4waMg4WdwQK5iLwrtqQ2+P6w2vAy5AWB54ZBOiDnHIHfcXdgw
 hTRQ==
X-Gm-Message-State: AOJu0YzC6ANSVdkehh2UqUUtO8w6coOWZjGn9/D0FzjiMdqlbFoG0ZPO
 61FLALHSEmVoqJ8bmodXM7ke1UHRvBVmz9JM8CBi8S1GGkfXDGfSNQ9eFY9/cYt64jAg8bRnYtf
 h
X-Google-Smtp-Source: AGHT+IF2xSYolMBrVK6spGZeNQNxHkxgEzy+QkyG2R1yz5ZQTHw2BiN0KyGisHgaggMhDQscr4gvLA==
X-Received: by 2002:a05:600c:510a:b0:42f:7c9e:1f96 with SMTP id
 5b1f17b1804b1-432b74fdee3mr147919705e9.1.1731435068020; 
 Tue, 12 Nov 2024 10:11:08 -0800 (PST)
Received: from localhost.localdomain
 (cnf78-h01-176-184-27-250.dsl.sta.abo.bbox.fr. [176.184.27.250])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-381ed97e46bsm15765702f8f.30.2024.11.12.10.11.06
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Tue, 12 Nov 2024 10:11:07 -0800 (PST)
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
Subject: [PATCH 03/20] hw/net/xilinx_ethlite: Remove unuseful debug logs
Date: Tue, 12 Nov 2024 19:10:27 +0100
Message-ID: <20241112181044.92193-4-philmd@linaro.org>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20241112181044.92193-1-philmd@linaro.org>
References: <20241112181044.92193-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::331;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x331.google.com
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

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 hw/net/xilinx_ethlite.c | 8 --------
 1 file changed, 8 deletions(-)

diff --git a/hw/net/xilinx_ethlite.c b/hw/net/xilinx_ethlite.c
index bb330a233f..2b52597f03 100644
--- a/hw/net/xilinx_ethlite.c
+++ b/hw/net/xilinx_ethlite.c
@@ -32,7 +32,6 @@
 #include "net/net.h"
 #include "trace.h"
 
-#define D(x)
 #define R_TX_BUF0     0
 #define R_TX_LEN0     (0x07f4 / 4)
 #define R_TX_GIE0     (0x07f8 / 4)
@@ -100,7 +99,6 @@ eth_read(void *opaque, hwaddr addr, unsigned int size)
         case R_RX_CTRL1:
         case R_RX_CTRL0:
             r = s->regs[addr];
-            D(qemu_log("%s " HWADDR_FMT_plx "=%x\n", __func__, addr * 4, r));
             break;
 
         default:
@@ -126,13 +124,10 @@ eth_write(void *opaque, hwaddr addr,
             if (addr == R_TX_CTRL1)
                 base = 0x800 / 4;
 
-            D(qemu_log("%s addr=" HWADDR_FMT_plx " val=%x\n",
-                       __func__, addr * 4, value));
             if ((value & (CTRL_P | CTRL_S)) == CTRL_S) {
                 qemu_send_packet(qemu_get_queue(s->nic),
                                  (void *) &s->regs[base],
                                  s->regs[base + R_TX_LEN0]);
-                D(qemu_log("eth_tx %d\n", s->regs[base + R_TX_LEN0]));
                 if (s->regs[base + R_TX_CTRL0] & CTRL_I)
                     eth_pulse_irq(s);
             } else if ((value & (CTRL_P | CTRL_S)) == (CTRL_P | CTRL_S)) {
@@ -156,8 +151,6 @@ eth_write(void *opaque, hwaddr addr,
         case R_TX_LEN0:
         case R_TX_LEN1:
         case R_TX_GIE0:
-            D(qemu_log("%s addr=" HWADDR_FMT_plx " val=%x\n",
-                       __func__, addr * 4, value));
             s->regs[addr] = value;
             break;
 
@@ -203,7 +196,6 @@ static ssize_t eth_rx(NetClientState *nc, const uint8_t *buf, size_t size)
         return -1;
     }
 
-    D(qemu_log("%s %zd rxbase=%x\n", __func__, size, rxbase));
     if (size > (R_MAX - R_RX_BUF0 - rxbase) * 4) {
         trace_ethlite_pkt_size_too_big(size);
         return -1;
-- 
2.45.2


