Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3A8A6D6A230
	for <qemu-devel@archiver.kernel.org>; Thu, 14 Nov 2024 21:04:44 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tBgyi-0002x6-3Y; Thu, 14 Nov 2024 16:02:12 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tBgye-0002aL-8W
 for qemu-devel@nongnu.org; Thu, 14 Nov 2024 16:02:08 -0500
Received: from mail-wm1-x335.google.com ([2a00:1450:4864:20::335])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tBgyc-00088x-CW
 for qemu-devel@nongnu.org; Thu, 14 Nov 2024 16:02:07 -0500
Received: by mail-wm1-x335.google.com with SMTP id
 5b1f17b1804b1-43155abaf0bso10053045e9.0
 for <qemu-devel@nongnu.org>; Thu, 14 Nov 2024 13:02:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1731618123; x=1732222923; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=WHsXd+6nklg/Fen/qM8UGXgjnDFu4CazQunEUxBn5NI=;
 b=Mb9848ZRBfIgcRmkLoRzj/OJ7cmWmcTKAzeSn4hKOxguOdYAmfvO3hlZc48C+6t26U
 dKK6Pqcte53LY5N9auqAcYL9vdNfEpkeTyoH1Pvm7ifeN1/h26D2UUczBj9XEG625HIy
 qGzhNArFKhTpvFqCrhE7fJtOXKBIUPmOfoX4o+bq4h0qE+HweHJYiC39PomhumOdeUB3
 JzSX5gzulXBnGHxcRyPsu6BdP4BfXuoCT14kue2mh64LgCxhHGCoc1ppx4sI+N4k6BQV
 j9CmOdHDj7yjW87yZmZdCzXRkVBT9dLdKMpaeZiSvTyL1YKrIRbK/1R8haqXP0UNPaey
 FoKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1731618123; x=1732222923;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=WHsXd+6nklg/Fen/qM8UGXgjnDFu4CazQunEUxBn5NI=;
 b=w+MFYSdX472DX4K/3uziPOqm+Fn0TVv/bmP1jF6ON/xvm2ZOGjo1TRNbQ4Odnziq6N
 KU732ILzZy67UE5z9uSUVGc7k4LvMh2JJ96UKwQwYLFz/Ccn7mA1y5yEH41Ykx5Vp7Yg
 mcJk6hMnEbcHyDlJ1s5mA9PNBi50wwB0SCFeu3ZC9AJ2ZZtvNmB/y2Afs+uDDOgVnF0L
 uHEG0Mej3uSUENpgwfcS/7TLjRKKzPSloxVMIXcVjJZnOJll/mmNCdF+reK3wIWLOyTp
 tneIcywQk2WVI/io+ImD5i6f6ZQQF0Xp/t/8hhGmFNUYXygYUmh6Pk8kqhjjIBWZ2B9U
 vNaA==
X-Gm-Message-State: AOJu0Yx9+MPyf074ESQYcoIJHvpxoh13/EijO+/90/zlQakhz6XO1ODI
 Z7sHfaGdbSZzCQaf4pFgLFwm0acu8aslPbSVV9b7ZyeBiPsEwhr8oDdNO/P32h1oVsrJnVlMhIk
 l
X-Google-Smtp-Source: AGHT+IHFreiSmbiBUC8gtfRYJj6tGdKGFrIYpzwYK09XmrW8Kl/f5SGiTdLz3xXwlzRL6ukzsisKqw==
X-Received: by 2002:a05:600c:34c3:b0:42f:8229:a0a1 with SMTP id
 5b1f17b1804b1-432df793c74mr1277045e9.33.1731618123191; 
 Thu, 14 Nov 2024 13:02:03 -0800 (PST)
Received: from localhost.localdomain ([176.187.209.228])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3821ae313a8sm2402592f8f.105.2024.11.14.13.01.59
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Thu, 14 Nov 2024 13:02:01 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: "Edgar E. Iglesias" <edgar.iglesias@gmail.com>, qemu-arm@nongnu.org,
 Richard Henderson <richard.henderson@linaro.org>,
 Thomas Huth <thuth@redhat.com>, Anton Johansson <anjo@rev.ng>,
 Bernhard Beschow <shentey@gmail.com>,
 Alistair Francis <alistair@alistair23.me>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Gustavo Romero <gustavo.romero@linaro.org>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>, Jason Wang <jasowang@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 "Edgar E . Iglesias" <edgar.iglesias@amd.com>
Subject: [PATCH RESEND v2 14/19] hw/net/xilinx_ethlite: Map TX_LEN as MMIO
Date: Thu, 14 Nov 2024 22:00:05 +0100
Message-ID: <20241114210010.34502-15-philmd@linaro.org>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20241114210010.34502-1-philmd@linaro.org>
References: <20241114210010.34502-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::335;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x335.google.com
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

Declare TX registers as MMIO region, split it out
of the current mixed RAM/MMIO region.

The memory flat view becomes:

  (qemu) info mtree -f
  FlatView #0
   Root memory region: system
    0000000081000000-00000000810007e3 (prio 0, i/o): xlnx.xps-ethernetlite
    00000000810007e4-00000000810007f3 (prio 0, i/o): ethlite.mdio
    00000000810007f4-00000000810007f7 (prio 0, i/o): ethlite.tx[0]io
    00000000810007f8-0000000081000ff3 (prio 0, i/o): xlnx.xps-ethernetlite @00000000000007f8
    0000000081000ff4-0000000081000ff7 (prio 0, i/o): ethlite.tx[1]io
    0000000081000ff8-00000000810017fb (prio 0, i/o): xlnx.xps-ethernetlite @0000000000000ff8
    00000000810017fc-00000000810017ff (prio 0, i/o): ethlite.rx[0]io
    0000000081001800-0000000081001ffb (prio 0, i/o): xlnx.xps-ethernetlite @0000000000001800
    0000000081001ffc-0000000081001fff (prio 0, i/o): ethlite.rx[1]io

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Edgar E. Iglesias <edgar.iglesias@amd.com>
---
 hw/net/xilinx_ethlite.c | 73 ++++++++++++++++++++++++++++++++++-------
 1 file changed, 61 insertions(+), 12 deletions(-)

diff --git a/hw/net/xilinx_ethlite.c b/hw/net/xilinx_ethlite.c
index d8f5a06182..b105fb7524 100644
--- a/hw/net/xilinx_ethlite.c
+++ b/hw/net/xilinx_ethlite.c
@@ -41,11 +41,11 @@
 #define R_TX_BUF0     0
 #define BUFSZ_MAX      0x07e4
 #define A_MDIO_BASE    0x07e4
-#define R_TX_LEN0     (0x07f4 / 4)
+#define A_TX_BASE0     0x07f4
 #define R_TX_GIE0     (0x07f8 / 4)
 #define R_TX_CTRL0    (0x07fc / 4)
 #define R_TX_BUF1     (0x0800 / 4)
-#define R_TX_LEN1     (0x0ff4 / 4)
+#define A_TX_BASE1     0x0ff4
 #define R_TX_CTRL1    (0x0ffc / 4)
 
 #define R_RX_BUF0     (0x1000 / 4)
@@ -54,6 +54,11 @@
 #define A_RX_BASE1     0x1ffc
 #define R_MAX         (0x2000 / 4)
 
+enum {
+    TX_LEN =  0,
+    TX_MAX
+};
+
 enum {
     RX_CTRL = 0,
     RX_MAX
@@ -67,6 +72,7 @@ enum {
 
 typedef struct XlnxXpsEthLitePort
 {
+    MemoryRegion txio;
     MemoryRegion rxio;
 
     struct {
@@ -126,6 +132,52 @@ static void *rxbuf_ptr(XlnxXpsEthLite *s, unsigned port_index)
     return &s->regs[rxbase + R_RX_BUF0];
 }
 
+static uint64_t port_tx_read(void *opaque, hwaddr addr, unsigned int size)
+{
+    XlnxXpsEthLite *s = opaque;
+    unsigned port_index = addr_to_port_index(addr);
+    uint32_t r = 0;
+
+    switch (addr >> 2) {
+        case TX_LEN:
+            r = s->port[port_index].reg.tx_len;
+            break;
+        default:
+            g_assert_not_reached();
+    }
+
+    return r;
+}
+
+static void port_tx_write(void *opaque, hwaddr addr, uint64_t value,
+                          unsigned int size)
+{
+    XlnxXpsEthLite *s = opaque;
+    unsigned port_index = addr_to_port_index(addr);
+
+    switch (addr >> 2) {
+        case TX_LEN:
+            s->port[port_index].reg.tx_len = value;
+            break;
+        default:
+            g_assert_not_reached();
+    }
+}
+
+static const MemoryRegionOps eth_porttx_ops = {
+        .read = port_tx_read,
+        .write = port_tx_write,
+        .endianness = DEVICE_NATIVE_ENDIAN,
+        .impl = {
+            .min_access_size = 4,
+            .max_access_size = 4,
+        },
+        .valid = {
+            .min_access_size = 4,
+            .max_access_size = 4,
+        },
+};
+
 static uint64_t port_rx_read(void *opaque, hwaddr addr, unsigned int size)
 {
     XlnxXpsEthLite *s = opaque;
@@ -190,11 +242,6 @@ eth_read(void *opaque, hwaddr addr, unsigned int size)
             r = s->port[port_index].reg.tx_gie;
             break;
 
-        case R_TX_LEN0:
-        case R_TX_LEN1:
-            r = s->port[port_index].reg.tx_len;
-            break;
-
         case R_TX_CTRL1:
         case R_TX_CTRL0:
             r = s->port[port_index].reg.tx_ctrl;
@@ -240,11 +287,6 @@ eth_write(void *opaque, hwaddr addr,
             break;
 
         /* Keep these native.  */
-        case R_TX_LEN0:
-        case R_TX_LEN1:
-            s->port[port_index].reg.tx_len = value;
-            break;
-
         case R_TX_GIE0:
             s->port[port_index].reg.tx_gie = value;
             break;
@@ -333,6 +375,13 @@ static void xilinx_ethlite_realize(DeviceState *dev, Error **errp)
                            sysbus_mmio_get_region(SYS_BUS_DEVICE(&s->mdio), 0));
 
     for (unsigned i = 0; i < 2; i++) {
+        memory_region_init_io(&s->port[i].txio, OBJECT(dev),
+                              &eth_porttx_ops, s,
+                              i ? "ethlite.tx[1]io" : "ethlite.tx[0]io",
+                              4 * TX_MAX);
+        memory_region_add_subregion(&s->mmio, i ? A_TX_BASE1 : A_TX_BASE0,
+                                    &s->port[i].txio);
+
         memory_region_init_io(&s->port[i].rxio, OBJECT(dev),
                               &eth_portrx_ops, s,
                               i ? "ethlite.rx[1]io" : "ethlite.rx[0]io",
-- 
2.45.2


