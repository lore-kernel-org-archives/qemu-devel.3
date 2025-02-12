Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 945BCC02198
	for <qemu-devel@archiver.kernel.org>; Wed, 12 Feb 2025 15:46:22 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tiEuI-0004YU-1f; Wed, 12 Feb 2025 10:44:10 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tiEu7-0004SH-EI
 for qemu-devel@nongnu.org; Wed, 12 Feb 2025 10:43:59 -0500
Received: from mail-wm1-x32e.google.com ([2a00:1450:4864:20::32e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tiEu5-0006vS-Jk
 for qemu-devel@nongnu.org; Wed, 12 Feb 2025 10:43:59 -0500
Received: by mail-wm1-x32e.google.com with SMTP id
 5b1f17b1804b1-4394036c0efso25016285e9.2
 for <qemu-devel@nongnu.org>; Wed, 12 Feb 2025 07:43:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1739375035; x=1739979835; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=mEULPqwUPtpzNSB0Z5/nLsqbWtVDcoNpITYqgf9zX7Q=;
 b=P7k3ZPyIkKFkLH4dwjWmK9/nwXvJJls5IXb1+24zeRE/ltvtUZO1JvtfS2XaXiqAPq
 k9CNs1GLJFtfsUEkEZHekY6cdM1eJydveHSUNlIoNCZUZlRw+832wOZW1aBU1GQI0Fds
 d3TKNUjd6oYDwFjXZmyk2sa9XA7yDjifbPyQ9hrJmL+URH1c/4NpE//fJPuf8Gn+Sb4P
 knHf+x+BzynCchaI3B9uIWC3CeLlxR95+6vz0sg1xhVqnNjXAZmE1BNB0QwKPZpsLzFN
 RbiW1W74J54LeBOyZ7sV4TNU3H11KWtkVWbGIUsZ/gSs8/gZBBWiy/MPU7CSsWwJ60ti
 JSQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1739375035; x=1739979835;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=mEULPqwUPtpzNSB0Z5/nLsqbWtVDcoNpITYqgf9zX7Q=;
 b=aaYOWg8UhnzTtOGnFs2hp7StJeDCNhGQr6xy4QpQ60Dd7oS3BcIBfZXARFD6b+Gzax
 QYXOG/NTV1V3HeZ/qnMGKuQpF8I6h8xnpigWJKAsTunFgSJQtVkrRSu+zX3MkSth0Kt+
 0DBQS01cPQ0Ykn4AD5OTU85kesN7JctwKTpBda/X3yXtAUsU82PXuRZMpzAFXcTFogQC
 U5ihbkaVZOSaBzOfugXNLB4T3WmzvNVDagPWLVcPqYGTdexlQSsogRrMnPJZToK/7pvX
 J6yyVQ0qIuRWELM8ZgMSZJ9xoUq/IPqq2fU61rgXXRBOTiaNvUw3YgLzYQoMK14Oy4VK
 O8QA==
X-Gm-Message-State: AOJu0Yz9WiZOfwvwwCureJv7DrRHVrBNNZWYCwDySs5v5HvskoXo+3Ox
 xrxXdoYvw2qNc6EAHuK2APNxSN4734VsjeN6843UiBpyU7AR/cR1r+X12wY0S38W51dlgDcFgZS
 JoXg=
X-Gm-Gg: ASbGncu1QQNaR9ZwFI5ZDl/eUipHWeYmlDCKx+lVIoqkK9rtYWxwzdCzA/dPLpUsXzc
 Gf4jRllqx1XRnLzWubCOY4mFdRp97uxFEkBIAkghYfAywjo5l/42IxHRtg+qE5Uv5Ou6z1Cm4Hr
 nOqjIilCYHo6tHwqpdhCKK+jRzs2wYF16k+72zBR1bfLhn9wP/vDhXpDSbupIDa/nhsF44U4p1+
 onPX/vcYpQR4kJ6V5lZkXz1tOg6R6OwQ8GHkeNmGjycrgA7lBimvl6QxOy7GqZZI/BBBPVhRR0Z
 lOAo2j5IyGHYRdefvG/HOjCKIKyAtrJgbUYdkeA5msvkIQGiHrvuAxBQE3Pie5Un2z4fg2c=
X-Google-Smtp-Source: AGHT+IEYQAYtDN6LNxaoqBIIuYAaq409qqUDrrCdqGiB3mJOl5DXL8EAn8jFbIQqurfd4jWnQ+03aA==
X-Received: by 2002:a05:600c:34cf:b0:431:3bf9:3ebb with SMTP id
 5b1f17b1804b1-439581b2618mr36292205e9.24.1739375035466; 
 Wed, 12 Feb 2025 07:43:55 -0800 (PST)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-38deb4f7bacsm2120986f8f.58.2025.02.12.07.43.54
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Wed, 12 Feb 2025 07:43:54 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: "Edgar E. Iglesias" <edgar.iglesias@gmail.com>,
 Alistair Francis <alistair@alistair23.me>,
 Peter Maydell <peter.maydell@linaro.org>, Rob Herring <robh@kernel.org>,
 Igor Mitsyanko <i.mitsyanko@gmail.com>, qemu-arm@nongnu.org,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH v2 4/8] hw/arm/xilinx_zynq: Replace IRQ_OFFSET -> GIC_INTERNAL
Date: Wed, 12 Feb 2025 16:43:29 +0100
Message-ID: <20250212154333.28644-5-philmd@linaro.org>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250212154333.28644-1-philmd@linaro.org>
References: <20250212154333.28644-1-philmd@linaro.org>
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

We already have a definition to distinct GIC internal
IRQs versus external ones, use it. No logical changes.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
---
 hw/arm/xilinx_zynq.c | 34 ++++++++++++++++------------------
 1 file changed, 16 insertions(+), 18 deletions(-)

diff --git a/hw/arm/xilinx_zynq.c b/hw/arm/xilinx_zynq.c
index 8477b828745..18051458945 100644
--- a/hw/arm/xilinx_zynq.c
+++ b/hw/arm/xilinx_zynq.c
@@ -54,8 +54,6 @@ OBJECT_DECLARE_SIMPLE_TYPE(ZynqMachineState, ZYNQ_MACHINE)
 #define FLASH_SIZE (64 * 1024 * 1024)
 #define FLASH_SECTOR_SIZE (128 * 1024)
 
-#define IRQ_OFFSET 32 /* pic interrupts start from index 32 */
-
 #define MPCORE_PERIPHBASE 0xF8F00000
 #define ZYNQ_BOARD_MIDR 0x413FC090
 
@@ -281,12 +279,12 @@ static void zynq_init(MachineState *machine)
         pic[n] = qdev_get_gpio_in(dev, n);
     }
 
-    n = zynq_init_spi_flashes(0xE0006000, pic[58 - IRQ_OFFSET], false, 0);
-    n = zynq_init_spi_flashes(0xE0007000, pic[81 - IRQ_OFFSET], false, n);
-    n = zynq_init_spi_flashes(0xE000D000, pic[51 - IRQ_OFFSET], true, n);
+    n = zynq_init_spi_flashes(0xE0006000, pic[58 - GIC_INTERNAL], false, 0);
+    n = zynq_init_spi_flashes(0xE0007000, pic[81 - GIC_INTERNAL], false, n);
+    n = zynq_init_spi_flashes(0xE000D000, pic[51 - GIC_INTERNAL], true, n);
 
-    sysbus_create_simple(TYPE_CHIPIDEA, 0xE0002000, pic[53 - IRQ_OFFSET]);
-    sysbus_create_simple(TYPE_CHIPIDEA, 0xE0003000, pic[76 - IRQ_OFFSET]);
+    sysbus_create_simple(TYPE_CHIPIDEA, 0xE0002000, pic[53 - GIC_INTERNAL]);
+    sysbus_create_simple(TYPE_CHIPIDEA, 0xE0003000, pic[76 - GIC_INTERNAL]);
 
     dev = qdev_new(TYPE_CADENCE_UART);
     busdev = SYS_BUS_DEVICE(dev);
@@ -295,7 +293,7 @@ static void zynq_init(MachineState *machine)
                           qdev_get_clock_out(slcr, "uart0_ref_clk"));
     sysbus_realize_and_unref(busdev, &error_fatal);
     sysbus_mmio_map(busdev, 0, 0xE0000000);
-    sysbus_connect_irq(busdev, 0, pic[59 - IRQ_OFFSET]);
+    sysbus_connect_irq(busdev, 0, pic[59 - GIC_INTERNAL]);
     dev = qdev_new(TYPE_CADENCE_UART);
     busdev = SYS_BUS_DEVICE(dev);
     qdev_prop_set_chr(dev, "chardev", serial_hd(1));
@@ -303,15 +301,15 @@ static void zynq_init(MachineState *machine)
                           qdev_get_clock_out(slcr, "uart1_ref_clk"));
     sysbus_realize_and_unref(busdev, &error_fatal);
     sysbus_mmio_map(busdev, 0, 0xE0001000);
-    sysbus_connect_irq(busdev, 0, pic[82 - IRQ_OFFSET]);
+    sysbus_connect_irq(busdev, 0, pic[82 - GIC_INTERNAL]);
 
     sysbus_create_varargs("cadence_ttc", 0xF8001000,
-            pic[42-IRQ_OFFSET], pic[43-IRQ_OFFSET], pic[44-IRQ_OFFSET], NULL);
+            pic[42-GIC_INTERNAL], pic[43-GIC_INTERNAL], pic[44-GIC_INTERNAL], NULL);
     sysbus_create_varargs("cadence_ttc", 0xF8002000,
-            pic[69-IRQ_OFFSET], pic[70-IRQ_OFFSET], pic[71-IRQ_OFFSET], NULL);
+            pic[69-GIC_INTERNAL], pic[70-GIC_INTERNAL], pic[71-GIC_INTERNAL], NULL);
 
-    gem_init(0xE000B000, pic[54 - IRQ_OFFSET]);
-    gem_init(0xE000C000, pic[77 - IRQ_OFFSET]);
+    gem_init(0xE000B000, pic[54 - GIC_INTERNAL]);
+    gem_init(0xE000C000, pic[77 - GIC_INTERNAL]);
 
     for (n = 0; n < 2; n++) {
         int hci_irq = n ? 79 : 56;
@@ -330,7 +328,7 @@ static void zynq_init(MachineState *machine)
         qdev_prop_set_uint64(dev, "capareg", ZYNQ_SDHCI_CAPABILITIES);
         sysbus_realize_and_unref(SYS_BUS_DEVICE(dev), &error_fatal);
         sysbus_mmio_map(SYS_BUS_DEVICE(dev), 0, hci_addr);
-        sysbus_connect_irq(SYS_BUS_DEVICE(dev), 0, pic[hci_irq - IRQ_OFFSET]);
+        sysbus_connect_irq(SYS_BUS_DEVICE(dev), 0, pic[hci_irq - GIC_INTERNAL]);
 
         di = drive_get(IF_SD, 0, n);
         blk = di ? blk_by_legacy_dinfo(di) : NULL;
@@ -343,7 +341,7 @@ static void zynq_init(MachineState *machine)
     dev = qdev_new(TYPE_ZYNQ_XADC);
     sysbus_realize_and_unref(SYS_BUS_DEVICE(dev), &error_fatal);
     sysbus_mmio_map(SYS_BUS_DEVICE(dev), 0, 0xF8007100);
-    sysbus_connect_irq(SYS_BUS_DEVICE(dev), 0, pic[39-IRQ_OFFSET]);
+    sysbus_connect_irq(SYS_BUS_DEVICE(dev), 0, pic[39-GIC_INTERNAL]);
 
     dev = qdev_new("pl330");
     object_property_set_link(OBJECT(dev), "memory",
@@ -363,15 +361,15 @@ static void zynq_init(MachineState *machine)
     busdev = SYS_BUS_DEVICE(dev);
     sysbus_realize_and_unref(busdev, &error_fatal);
     sysbus_mmio_map(busdev, 0, 0xF8003000);
-    sysbus_connect_irq(busdev, 0, pic[45-IRQ_OFFSET]); /* abort irq line */
+    sysbus_connect_irq(busdev, 0, pic[45-GIC_INTERNAL]); /* abort irq line */
     for (n = 0; n < ARRAY_SIZE(dma_irqs); ++n) { /* event irqs */
-        sysbus_connect_irq(busdev, n + 1, pic[dma_irqs[n] - IRQ_OFFSET]);
+        sysbus_connect_irq(busdev, n + 1, pic[dma_irqs[n] - GIC_INTERNAL]);
     }
 
     dev = qdev_new("xlnx.ps7-dev-cfg");
     busdev = SYS_BUS_DEVICE(dev);
     sysbus_realize_and_unref(busdev, &error_fatal);
-    sysbus_connect_irq(busdev, 0, pic[40 - IRQ_OFFSET]);
+    sysbus_connect_irq(busdev, 0, pic[40 - GIC_INTERNAL]);
     sysbus_mmio_map(busdev, 0, 0xF8007000);
 
     /*
-- 
2.47.1


