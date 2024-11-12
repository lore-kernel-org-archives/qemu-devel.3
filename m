Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 16025D42BBA
	for <qemu-devel@archiver.kernel.org>; Tue, 12 Nov 2024 18:17:11 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tAvO2-0008S3-F7; Tue, 12 Nov 2024 13:13:10 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tAvNm-00087h-7g
 for qemu-devel@nongnu.org; Tue, 12 Nov 2024 13:12:56 -0500
Received: from mail-wm1-x32b.google.com ([2a00:1450:4864:20::32b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tAvNe-00024U-Iz
 for qemu-devel@nongnu.org; Tue, 12 Nov 2024 13:12:54 -0500
Received: by mail-wm1-x32b.google.com with SMTP id
 5b1f17b1804b1-431695fa98bso47576605e9.3
 for <qemu-devel@nongnu.org>; Tue, 12 Nov 2024 10:12:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1731435164; x=1732039964; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=2SAvDiAsNxCj5xV4d5IUtJExFxHe3WGoYxScpi/ms1o=;
 b=b1I3AWgJ8fZn9s7dnxtsfBRIdMykYkIzM62I+GwT0GqtXyvIaxGRwhLLlwEJy1DSg5
 BAWWd7PN4k5QSLgh28FGcZlC1N3TxjZweX/El6gdgC8utqyYnsShNdUMEQMNrJ2DF3qL
 59uAVWo6a52TDWeHEespyTR/u4afsWUWrM+5KbN6sZXgdBBq8vWqUsKaxmtNMx49co4u
 0VCWOqDP1j15Vdmt/mNL4fQxNrd4LSyJCpM2zsFZ+SWPCjdUiFDgCsXZhbGCtSl3r+oq
 chFlyud50KLv6wugtZC99zcfAtEJMkYyr47Eck/k9eJdQiLFfEFkckyFjqN+BZvauqvh
 FZuA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1731435164; x=1732039964;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=2SAvDiAsNxCj5xV4d5IUtJExFxHe3WGoYxScpi/ms1o=;
 b=vJ+z9lhC5+wPxSmTNRbFQS6H7UUr7dT3b9v/lpLFnRjQpfVt0mKJ51U2onOuROjAGU
 YEnfN3lqp9jZDjXPtW8x87zvbcNzrG7FIqueABdRW85sgp0amORUNCmPSolZVC54zTFO
 sAoUGTEib9jybqsYOc+BomGrTCofBva4K/bcBdPGAp6kfMmOrAu1WvtWPGHQHM7VBlPn
 l5h6VW/D1gbBVsfD2pT0rIHV+sEhwIFaLjVarkd/jiX8q5Yasjyqx1i22zLX67rcoOF7
 fObO/9EzpfEyr5D+8d3EQI6p9jMuJgku6BJ25+Dq+KAfW3vceJC3dWFBftqcsTs/+VK0
 7p3w==
X-Gm-Message-State: AOJu0Yyz3Jz7mzb/j+Nivxhu0Vr8lVSaabwAa5yt1iX+TRCzvIbbMFaS
 wBJm3yMv3wXXdb/YbJvHwWVOyf62BSbBpUs1n5BbIWOw9+4RAyLHZAKyPuhv46QgK6Q1z07Ch7K
 K
X-Google-Smtp-Source: AGHT+IEwhOC/1UmfJ+2BGE6lNRu6lnJ/c8JnaHGRgrzWFLg8ySoUo3+gtz+ldwxPwOx4xqOYNEwd6w==
X-Received: by 2002:a05:600c:1c15:b0:42c:a580:71cf with SMTP id
 5b1f17b1804b1-432b751e27cmr148068795e9.30.1731435163019; 
 Tue, 12 Nov 2024 10:12:43 -0800 (PST)
Received: from localhost.localdomain
 (cnf78-h01-176-184-27-250.dsl.sta.abo.bbox.fr. [176.184.27.250])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-432aa6bee9asm260965995e9.19.2024.11.12.10.12.41
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Tue, 12 Nov 2024 10:12:42 -0800 (PST)
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
Subject: [PATCH 19/20] hw/net/xilinx_ethlite: Map the RAM buffer as RAM memory
 region
Date: Tue, 12 Nov 2024 19:10:43 +0100
Message-ID: <20241112181044.92193-20-philmd@linaro.org>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20241112181044.92193-1-philmd@linaro.org>
References: <20241112181044.92193-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32b;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x32b.google.com
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

Rather than using I/O registers for RAM buffer, having to
swap endianness back and forth (because the core memory layer
automatically swaps endiannes for us), declare the buffers
as RAM regions. Remove the now unused s->regs[] array.

The memory flat view becomes:

  FlatView #0
   Root memory region: system
    0000000081000000-00000000810007f3 (prio 0, ram): ethlite.tx[0]buf
    00000000810007f4-00000000810007ff (prio 0, i/o): ethlite.tx[0]io
    0000000081000800-0000000081000ff3 (prio 0, ram): ethlite.tx[1]buf
    0000000081000ff4-0000000081000fff (prio 0, i/o): ethlite.tx[1]io
    0000000081001000-00000000810017f3 (prio 0, ram): ethlite.rx[0]buf
    00000000810017fc-00000000810017ff (prio 0, i/o): ethlite.rx[0]io
    0000000081001800-0000000081001ff3 (prio 0, ram): ethlite.rx[1]buf
    0000000081001ffc-0000000081001fff (prio 0, i/o): ethlite.rx[1]io

Mention the device datasheet in the file header.

Reported-by: Paolo Bonzini <pbonzini@redhat.com>
Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 hw/net/xilinx_ethlite.c | 79 +++++++++++------------------------------
 1 file changed, 20 insertions(+), 59 deletions(-)

diff --git a/hw/net/xilinx_ethlite.c b/hw/net/xilinx_ethlite.c
index f681b91769..da453465ca 100644
--- a/hw/net/xilinx_ethlite.c
+++ b/hw/net/xilinx_ethlite.c
@@ -2,6 +2,10 @@
  * QEMU model of the Xilinx Ethernet Lite MAC.
  *
  * Copyright (c) 2009 Edgar E. Iglesias.
+ * Copyright (c) 2024 Linaro, Ltd
+ *
+ * DS580: https://docs.amd.com/v/u/en-US/xps_ethernetlite
+ * LogiCORE IP XPS Ethernet Lite Media Access Controller
  *
  * Permission is hereby granted, free of charge, to any person obtaining a copy
  * of this software and associated documentation files (the "Software"), to deal
@@ -27,7 +31,6 @@
 #include "qemu/bitops.h"
 #include "qom/object.h"
 #include "qapi/error.h"
-#include "exec/tswap.h"
 #include "hw/sysbus.h"
 #include "hw/irq.h"
 #include "hw/qdev-properties.h"
@@ -46,7 +49,6 @@
 #define A_RX_BASE0    0x17fc
 #define R_RX_BUF1     (0x1800 / 4)
 #define A_RX_BASE1    0x1ffc
-#define R_MAX         (0x2000 / 4)
 
 #define RX_BUFSZ_MAX  0x07e0
 
@@ -72,6 +74,8 @@ typedef struct XlnxXpsEthLitePort
 {
     MemoryRegion txio;
     MemoryRegion rxio;
+    MemoryRegion txbuf;
+    MemoryRegion rxbuf;
 
     struct {
         uint32_t tx_len;
@@ -100,7 +104,6 @@ struct XlnxXpsEthLite
 
     UnimplementedDeviceState mdio;
     XlnxXpsEthLitePort port[2];
-    uint32_t regs[R_MAX];
 };
 
 static inline void eth_pulse_irq(XlnxXpsEthLite *s)
@@ -118,16 +121,12 @@ static unsigned addr_to_port_index(hwaddr addr)
 
 static void *txbuf_ptr(XlnxXpsEthLite *s, unsigned port_index)
 {
-    unsigned int rxbase = port_index * (0x800 / 4);
-
-    return &s->regs[rxbase + R_TX_BUF0];
+    return memory_region_get_ram_ptr(&s->port[port_index].txbuf);
 }
 
 static void *rxbuf_ptr(XlnxXpsEthLite *s, unsigned port_index)
 {
-    unsigned int rxbase = port_index * (0x800 / 4);
-
-    return &s->regs[rxbase + R_RX_BUF0];
+    return memory_region_get_ram_ptr(&s->port[port_index].rxbuf);
 }
 
 static uint64_t port_tx_read(void *opaque, hwaddr addr, unsigned int size)
@@ -252,53 +251,6 @@ static const MemoryRegionOps eth_portrx_ops = {
         },
 };
 
-static uint64_t
-eth_read(void *opaque, hwaddr addr, unsigned int size)
-{
-    XlnxXpsEthLite *s = opaque;
-    uint32_t r = 0;
-
-    addr >>= 2;
-
-    switch (addr)
-    {
-        default:
-            r = tswap32(s->regs[addr]);
-            break;
-    }
-    return r;
-}
-
-static void
-eth_write(void *opaque, hwaddr addr,
-          uint64_t val64, unsigned int size)
-{
-    XlnxXpsEthLite *s = opaque;
-    uint32_t value = val64;
-
-    addr >>= 2;
-    switch (addr) 
-    {
-        default:
-            s->regs[addr] = tswap32(value);
-            break;
-    }
-}
-
-static const MemoryRegionOps eth_ops = {
-    .read = eth_read,
-    .write = eth_write,
-    .endianness = DEVICE_NATIVE_ENDIAN,
-    .impl = {
-        .min_access_size = 4,
-        .max_access_size = 4,
-    },
-    .valid = {
-        .min_access_size = 4,
-        .max_access_size = 4
-    }
-};
-
 static bool eth_can_rx(NetClientState *nc)
 {
     XlnxXpsEthLite *s = qemu_get_nic_opaque(nc);
@@ -354,6 +306,9 @@ static void xilinx_ethlite_realize(DeviceState *dev, Error **errp)
 {
     XlnxXpsEthLite *s = XILINX_ETHLITE(dev);
 
+    memory_region_init(&s->mmio, OBJECT(dev),
+                       "xlnx.xps-ethernetlite", 0x2000);
+
     object_initialize_child(OBJECT(dev), "ethlite.mdio", &s->mdio,
                            TYPE_UNIMPLEMENTED_DEVICE);
     qdev_prop_set_string(DEVICE(&s->mdio), "name", "ethlite.mdio");
@@ -363,6 +318,10 @@ static void xilinx_ethlite_realize(DeviceState *dev, Error **errp)
                             sysbus_mmio_get_region(SYS_BUS_DEVICE(&s->mdio), 0));
 
     for (unsigned i = 0; i < 2; i++) {
+        memory_region_init_ram(&s->port[i].txbuf, OBJECT(dev),
+                               i ? "ethlite.tx[1]buf" : "ethlite.tx[0]buf",
+                               0x07f4, &error_abort);
+        memory_region_add_subregion(&s->mmio, 0x0800 * i, &s->port[i].txbuf);
         memory_region_init_io(&s->port[i].txio, OBJECT(dev),
                               &eth_porttx_ops, s,
                               i ? "ethlite.tx[1]io" : "ethlite.tx[0]io",
@@ -370,6 +329,11 @@ static void xilinx_ethlite_realize(DeviceState *dev, Error **errp)
         memory_region_add_subregion(&s->mmio, i ? A_TX_BASE1 : A_TX_BASE0,
                                     &s->port[i].txio);
 
+        memory_region_init_ram(&s->port[i].rxbuf, OBJECT(dev),
+                               i ? "ethlite.rx[1]buf" : "ethlite.rx[0]buf",
+                               0x07f4, &error_abort);
+        memory_region_add_subregion(&s->mmio, 0x1000 + 0x0800 * i,
+                                    &s->port[i].rxbuf);
         memory_region_init_io(&s->port[i].rxio, OBJECT(dev),
                               &eth_portrx_ops, s,
                               i ? "ethlite.rx[1]io" : "ethlite.rx[0]io",
@@ -390,9 +354,6 @@ static void xilinx_ethlite_init(Object *obj)
     XlnxXpsEthLite *s = XILINX_ETHLITE(obj);
 
     sysbus_init_irq(SYS_BUS_DEVICE(obj), &s->irq);
-
-    memory_region_init_io(&s->mmio, obj, &eth_ops, s,
-                          "xlnx.xps-ethernetlite", R_MAX * 4);
     sysbus_init_mmio(SYS_BUS_DEVICE(obj), &s->mmio);
 }
 
-- 
2.45.2


