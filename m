Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2F500D42BBE
	for <qemu-devel@archiver.kernel.org>; Tue, 12 Nov 2024 18:14:43 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tAvNY-0007B2-JF; Tue, 12 Nov 2024 13:12:40 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tAvNG-0006CT-Rr
 for qemu-devel@nongnu.org; Tue, 12 Nov 2024 13:12:23 -0500
Received: from mail-wm1-x32e.google.com ([2a00:1450:4864:20::32e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tAvNF-00021s-8w
 for qemu-devel@nongnu.org; Tue, 12 Nov 2024 13:12:22 -0500
Received: by mail-wm1-x32e.google.com with SMTP id
 5b1f17b1804b1-431688d5127so47762005e9.0
 for <qemu-devel@nongnu.org>; Tue, 12 Nov 2024 10:12:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1731435139; x=1732039939; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=33ai2lENeDpCfbtpntzIEqfDXZ63d2DBrrpSSg3fCCg=;
 b=Y3L9CiDNfV+OM23aekSPqhFEtu4gvBB+r/uRNW8dYTQFWTFRJeHg6v1t3X/egn8tj3
 QVEQ7Uhs+3wsDuhv7GwQFpk6o7qs8hGnJDNjnQvCPjW450Ppwj5+73pkPyxe86IY2wya
 W3c4i8NKIQ4Xun9srLa2iGIxiLPNJ4e+KyBk8WZB790GgP9sRY52VmCHDt0btrYmeGoW
 QD/BZCbZYAfay0lcEvIqeLmGGgji8VwywkVXVB9e5TxiTw3s3BWv5eaaVw3eqN9Uv3JS
 xSxdh5yCrjZtA5XL6AfGQwNjvM35wq1wCSaC2+V1LzVzPYVPNUVdPrrI4Tbb8agdBhNa
 fKiw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1731435139; x=1732039939;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=33ai2lENeDpCfbtpntzIEqfDXZ63d2DBrrpSSg3fCCg=;
 b=GPdW76qtjUt4SuctLIgNGxg7fh3D9k71SIXBx6hlh1QsnKGQLC/YyL5EzdpYiLWf79
 ReEG2Au7yPS2UFWT3j/ZvRuF76sYLQEierypOf47gUNhD7XpFcrfzXlGiiHvDFjr91v4
 bvCoMLThzwNyU5yd5lIr+UUX0b4kyHulEFzyIustX0z5W6p7+pzsM+BQ+kToS+E+nPEZ
 xhK5L4QX1pY+SqZSxM83Ndp5XF9DsnkuUlQnsDWn3AurvfTp3qwsnfn9VxQFJC34DjmS
 vhFqLudhTtiwlBizF4zyaxwKbOZw7rtGsF6z9NznN3iqkUgecev2qaaAlEXjU4pwHW2p
 1wfQ==
X-Gm-Message-State: AOJu0YwyJj1KgTc3VBzjMh3yhyyuQJSWb28Ug5XCFNm2DsAEKsVj2R9N
 BU6AU3Ah2ysTm8yMI2bPR/4+cqlRgEtnRjRoyxflXU08p6TrJWj4H8MzUJHgn5bjJBzDAcxwXXN
 Z
X-Google-Smtp-Source: AGHT+IHpLteupMmSsopbmh2qzKKmKV0Wv9cZXs7WjQtinWx8atg2Uyt1sVnggiZzkL3xdK/BY56puA==
X-Received: by 2002:a05:6000:4107:b0:381:f604:30c2 with SMTP id
 ffacd0b85a97d-381f6043253mr12399576f8f.35.1731435139511; 
 Tue, 12 Nov 2024 10:12:19 -0800 (PST)
Received: from localhost.localdomain
 (cnf78-h01-176-184-27-250.dsl.sta.abo.bbox.fr. [176.184.27.250])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-381ed97071esm15832992f8f.12.2024.11.12.10.12.17
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Tue, 12 Nov 2024 10:12:18 -0800 (PST)
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
Subject: [PATCH 15/20] hw/net/xilinx_ethlite: Map RX_CTRL as MMIO
Date: Tue, 12 Nov 2024 19:10:39 +0100
Message-ID: <20241112181044.92193-16-philmd@linaro.org>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20241112181044.92193-1-philmd@linaro.org>
References: <20241112181044.92193-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32e;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x32e.google.com
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

Declare RX registers as MMIO region, split it out
of the current mixed RAM/MMIO region.
The memory flat view becomes:

  FlatView #0
   Root memory region: system
    0000000081000000-00000000810007e3 (prio 0, i/o): xlnx.xps-ethernetlite
    00000000810007e4-00000000810007f3 (prio 0, i/o): ethlite.mdio
    00000000810007f4-00000000810017fb (prio 0, i/o): xlnx.xps-ethernetlite @00000000000007f4
    00000000810017fc-00000000810017ff (prio 0, i/o): ethlite.rx[0]io
    0000000081001800-0000000081001ffb (prio 0, i/o): xlnx.xps-ethernetlite @0000000000001800
    0000000081001ffc-0000000081001fff (prio 0, i/o): ethlite.rx[1]io

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 hw/net/xilinx_ethlite.c | 79 +++++++++++++++++++++++++++++++++--------
 1 file changed, 65 insertions(+), 14 deletions(-)

diff --git a/hw/net/xilinx_ethlite.c b/hw/net/xilinx_ethlite.c
index 4d86851f38..161fd97f06 100644
--- a/hw/net/xilinx_ethlite.c
+++ b/hw/net/xilinx_ethlite.c
@@ -46,13 +46,18 @@
 #define R_TX_CTRL1    (0x0ffc / 4)
 
 #define R_RX_BUF0     (0x1000 / 4)
-#define R_RX_CTRL0    (0x17fc / 4)
+#define A_RX_BASE0    0x17fc
 #define R_RX_BUF1     (0x1800 / 4)
-#define R_RX_CTRL1    (0x1ffc / 4)
+#define A_RX_BASE1    0x1ffc
 #define R_MAX         (0x2000 / 4)
 
 #define RX_BUFSZ_MAX  0x07e0
 
+enum {
+    RX_CTRL = 0,
+    RX_MAX
+};
+
 #define GIE_GIE    0x80000000
 
 #define CTRL_I     0x8
@@ -61,6 +66,8 @@
 
 typedef struct XlnxXpsEthLitePort
 {
+    MemoryRegion rxio;
+
     struct {
         uint32_t tx_len;
         uint32_t tx_gie;
@@ -118,6 +125,53 @@ static void *rxbuf_ptr(XlnxXpsEthLite *s, unsigned port_index)
     return &s->regs[rxbase + R_RX_BUF0];
 }
 
+static uint64_t port_rx_read(void *opaque, hwaddr addr, unsigned int size)
+{
+    XlnxXpsEthLite *s = opaque;
+    unsigned port_index = addr_to_port_index(addr);
+    uint32_t r = 0;
+
+    switch (addr >> 2) {
+        case RX_CTRL:
+            r = s->port[port_index].reg.rx_ctrl;
+            break;
+        default:
+            g_assert_not_reached();
+    }
+
+    return r;
+}
+
+static void port_rx_write(void *opaque, hwaddr addr, uint64_t value,
+                          unsigned int size)
+{
+    XlnxXpsEthLite *s = opaque;
+
+    switch (addr >> 2) {
+        case RX_CTRL:
+            if (!(value & CTRL_S)) {
+                qemu_flush_queued_packets(qemu_get_queue(s->nic));
+            }
+            break;
+        default:
+            g_assert_not_reached();
+    }
+}
+
+static const MemoryRegionOps eth_portrx_ops = {
+        .read = port_rx_read,
+        .write = port_rx_write,
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
 static uint64_t
 eth_read(void *opaque, hwaddr addr, unsigned int size)
 {
@@ -143,10 +197,6 @@ eth_read(void *opaque, hwaddr addr, unsigned int size)
             r = s->port[port_index].reg.tx_ctrl;
             break;
 
-        case R_RX_CTRL1:
-        case R_RX_CTRL0:
-            r = s->port[port_index].reg.rx_ctrl;
-
         default:
             r = tswap32(s->regs[addr]);
             break;
@@ -187,14 +237,6 @@ eth_write(void *opaque, hwaddr addr,
             break;
 
         /* Keep these native.  */
-        case R_RX_CTRL0:
-        case R_RX_CTRL1:
-            if (!(value & CTRL_S)) {
-                qemu_flush_queued_packets(qemu_get_queue(s->nic));
-            }
-            s->port[port_index].reg.rx_ctrl = value;
-            break;
-
         case R_TX_LEN0:
         case R_TX_LEN1:
             s->port[port_index].reg.tx_len = value;
@@ -287,6 +329,15 @@ static void xilinx_ethlite_realize(DeviceState *dev, Error **errp)
     memory_region_add_subregion(&s->mmio, A_MDIO_BASE,
                             sysbus_mmio_get_region(SYS_BUS_DEVICE(&s->mdio), 0));
 
+    for (unsigned i = 0; i < 2; i++) {
+        memory_region_init_io(&s->port[i].rxio, OBJECT(dev),
+                              &eth_portrx_ops, s,
+                              i ? "ethlite.rx[1]io" : "ethlite.rx[0]io",
+                              4 * RX_MAX);
+        memory_region_add_subregion(&s->mmio, i ? A_RX_BASE1 : A_RX_BASE0,
+                                    &s->port[i].rxio);
+    }
+
     qemu_macaddr_default_if_unset(&s->conf.macaddr);
     s->nic = qemu_new_nic(&net_xilinx_ethlite_info, &s->conf,
                           object_get_typename(OBJECT(dev)), dev->id,
-- 
2.45.2


