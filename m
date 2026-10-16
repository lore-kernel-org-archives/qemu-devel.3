Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 40853CCA463
	for <qemu-devel@archiver.kernel.org>; Fri, 16 Oct 2026 01:11:38 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xHWPL-00056k-75; Thu, 15 Oct 2026 21:06:52 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1xHWNj-0002BB-IO
 for qemu-devel@nongnu.org; Thu, 15 Oct 2026 21:05:13 -0400
Received: from mail-pl1-x632.google.com ([2607:f8b0:4864:20::632])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1xHWNg-0004de-6T
 for qemu-devel@nongnu.org; Thu, 15 Oct 2026 21:05:11 -0400
Received: by mail-pl1-x632.google.com with SMTP id
 d9443c01a7336-2e987a2ba0cso1068055ad.3
 for <qemu-devel@nongnu.org>; Thu, 15 Oct 2026 18:05:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1792112706; x=1792717506; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=vEsPkFkLUyA1NU56nP525qgRMdEHY/E8F4lp51ZoNeY=;
 b=GiZspCq2UwsVzEst8pJBIE0u0iTK6RCp6R3ECAzF8kfJWPPuFeGEwpjcEkmFttZC1z
 vJFioourBfIOnv98J6TrTe6js4aEShTsJMZX4A6sHzonyL3pYUEwfcC74mHCh6z9HDEy
 vg9fdn2okfNAPyR6FTmCZxTOGOCcf5lwsWWSJkaGh1Jr6hM1nz1/GnWdDQeNdWvietXd
 DPmnJTSXHtox4nlcwi872kB/Q4mTdZcIUrRJ9vJnIu/K1fKGV058tFflFGNEdtdT1y6E
 rSs15xpfefN/iz9zqVyb/jZV0ZKD4yZzTK3/yD+vJpiYwjbIN4vwEynVN3Ok0vU4WSNV
 Cy/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792112706; x=1792717506;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=vEsPkFkLUyA1NU56nP525qgRMdEHY/E8F4lp51ZoNeY=;
 b=FUtfo1jTOqxhg40DqNsGrKb5F4C/wSQbzvtxt8p3NSjwngT6u0pELwEXQSvDvhyTB7
 y2Y9Kja5hY8OyTWFNeDdysM0XyIQVwogXVAym1of4aOlEcUR3MBuO+kJvJpFHjRACv8i
 H4c1ETxrYVMN1VoAUip5tK2C6j91CDUUsKOebbQkyLZLiJSsjjo1+xpB2kGGSFCMjv5l
 9IcTUR9Oh2BCuKtD2k+L4QeTeGQjgvFsQwBZwGlXmyW8usJ2eQmemr7IUK6ZeFT2erlo
 KJJrt4W0t9cj3J7yhphSYICW6GdFsLGzudTbugwNXy2bvRJEDpo4tp82uFTQiD0SX48Q
 ONQg==
X-Gm-Message-State: AFq9FYI7C+xwWmSrSYOssO5z1zicS2aHjyhfiCkkPw+zM80d3r4WAYeX
 fd4ox+fIqqaaP2vqwltWyWj5Yn894RhCYWtck8In5dWzytl7Xj3XJdcBbquyQA==
X-Gm-Gg: AYBFou3EO4N5+pPX0t7WnptOs3QVom5Fai0udUb9mjUGvT/J17Zym8aFv9mAVFmukKl
 KxzmLH2yYV/N+9v3ZMtlhnmTOAWEJGMhD9jsnlnf+KnpRb1oS3uNsefggy66ouOhbJe3HLmscTz
 92SbSlbaK+tbA2B7v3aYSNuionw6v85ux1LCKltVVq9EBr3aoQq8iJgQ/WAZcnzDaFXNRa0HZkl
 UGVy0GSir0HIrlIzImAUctXFP3xrCy5ya/DWG5spnjf1Ki+HxTThXyZU7aKxqkUNcu6aRCClxJF
 2EoxcrPxso233LUyzfNckMzAavMuZHhetG72LZR+QoHJxYida4IVR6jBBTKwuAn3V1igIqi6+SN
 Kk0Jt13hXzsWQUJIZUEUIXbQZA8gLmByz167JaOgM6vdGShB7CfzEI0+2xZRqwOe6zfMAQ8ZIuH
 R9YEPUc2jmFakiUPr6gfcnhPQz+0JmRmlF8bMAicIwe1UA0C/vENxRb6Vrvu2JL+izuETxNPZfO
 7H2TSkt6apfQqKO
X-Received: by 2002:a17:902:f650:b0:2e9:5507:b538 with SMTP id
 d9443c01a7336-2e95507b924mr45356965ad.3.1792112705511; 
 Thu, 15 Oct 2026 18:05:05 -0700 (PDT)
Received: from toolbx.alistair23.me ([2403:581e:fdf9:0:13b2:851f:d9cb:44c5])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2e97e833f1asm2513995ad.43.2026.10.15.18.05.03
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 15 Oct 2026 18:05:05 -0700 (PDT)
From: alistair23@gmail.com
X-Google-Original-From: alistair.francis@wdc.com
To: qemu-devel@nongnu.org
Cc: Anirudh Srinivasan <asrinivasan@oss.tenstorrent.com>,
 Alistair Francis <alistair.francis@wdc.com>
Subject: [PULL v2 47/50] hw/riscv/tt-atlantis: Update UART and I2C to use clk
 from PRCM
Date: Fri, 16 Oct 2026 11:02:34 +1000
Message-ID: <20261016010237.1102834-48-alistair.francis@wdc.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20261016010237.1102834-1-alistair.francis@wdc.com>
References: <20261016010237.1102834-1-alistair.francis@wdc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::632;
 envelope-from=alistair23@gmail.com; helo=mail-pl1-x632.google.com
X-Spam_score_int: -17
X-Spam_score: -1.8
X-Spam_bar: -
X-Spam_report: (-1.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FREEMAIL_ENVFROM_END_DIGIT=0.25, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

From: Anirudh Srinivasan <asrinivasan@oss.tenstorrent.com>

Now that we have the PRCM modelled, update the DT nodes for UART1 and
the 5 I2C controllers to use the rcpu_prcm as a clock provider. This
also allows us to eliminate the periph_clk that was added to the DT
previously.

Signed-off-by: Anirudh Srinivasan <asrinivasan@oss.tenstorrent.com>
Acked-by: Alistair Francis <alistair.francis@wdc.com>
Message-ID: <20261001-atlantis_prcm-v4-3-95d33c470eeb@oss.tenstorrent.com>
Signed-off-by: Alistair Francis <alistair.francis@wdc.com>
---
 include/hw/riscv/tt_atlantis.h |  6 ++++++
 hw/riscv/tt_atlantis.c         | 23 ++++++++++++++---------
 2 files changed, 20 insertions(+), 9 deletions(-)

diff --git a/include/hw/riscv/tt_atlantis.h b/include/hw/riscv/tt_atlantis.h
index db1dfed157..577c867d71 100644
--- a/include/hw/riscv/tt_atlantis.h
+++ b/include/hw/riscv/tt_atlantis.h
@@ -99,6 +99,12 @@ enum {
     TT_ATL_CLK_RCPU_ROOT = 1,
     TT_ATL_CLK_NOC_PLL = 25,
     TT_ATL_CLK_NOCC_CLK = 26,
+    TT_ATL_CLK_I2C0_PCLK = 33,
+    TT_ATL_CLK_I2C1_PCLK = 34,
+    TT_ATL_CLK_I2C2_PCLK = 35,
+    TT_ATL_CLK_I2C3_PCLK = 36,
+    TT_ATL_CLK_I2C4_PCLK = 37,
+    TT_ATL_CLK_UART1_PCLK = 39,
     TT_ATL_CLK_HSIO_PLL = 54,
     TT_ATL_CLK_PCIE_PLL = 55,
     TT_ATL_CLK_MM_PLL0 = 56,
diff --git a/hw/riscv/tt_atlantis.c b/hw/riscv/tt_atlantis.c
index 10ae3c2850..4e6c39982c 100644
--- a/hw/riscv/tt_atlantis.c
+++ b/hw/riscv/tt_atlantis.c
@@ -265,7 +265,8 @@ static void create_fdt_cpu(void *fdt, TTAtlantisSoCState *s,
 }
 
 static void create_fdt_uart(void *fdt, const MemMapEntry *mem, int irq,
-                            int irqchip_phandle)
+                            int irqchip_phandle, uint32_t clk_parent_phandle,
+                            uint32_t clk_phandle)
 {
     g_autofree char *name = g_strdup_printf("/soc/serial@%"HWADDR_PRIX,
                                             mem->base);
@@ -275,6 +276,8 @@ static void create_fdt_uart(void *fdt, const MemMapEntry *mem, int irq,
     qemu_fdt_setprop_sized_cells(fdt, name, "reg", 2, mem->base, 2, mem->size);
     qemu_fdt_setprop_cell(fdt, name, "reg-shift", 2);
     qemu_fdt_setprop_cell(fdt, name, "reg-io-width", 4);
+    qemu_fdt_setprop_cells(fdt, name, "clocks", clk_parent_phandle,
+                           clk_phandle);
     qemu_fdt_setprop_cell(fdt, name, "clock-frequency", 3686400);
     qemu_fdt_setprop_cell(fdt, name, "interrupt-parent", irqchip_phandle);
     qemu_fdt_setprop_cells(fdt, name, "interrupts", irq, 0x4);
@@ -305,7 +308,9 @@ static void create_fdt_clk(void *fdt, const char *clock_name,
 }
 
 static void create_fdt_i2c(void *fdt, const MemMapEntry *mem, uint32_t irq,
-                           uint32_t irqchip_phandle, uint32_t clk_phandle)
+                           uint32_t irqchip_phandle,
+                           uint32_t clk_parent_phandle,
+                           uint32_t clk_phandle)
 {
     g_autofree char *name = g_strdup_printf("/soc/i2c@%"HWADDR_PRIX, mem->base);
 
@@ -314,7 +319,8 @@ static void create_fdt_i2c(void *fdt, const MemMapEntry *mem, uint32_t irq,
     qemu_fdt_setprop_sized_cells(fdt, name, "reg", 2, mem->base, 2, mem->size);
     qemu_fdt_setprop_cell(fdt, name, "interrupt-parent", irqchip_phandle);
     qemu_fdt_setprop_cells(fdt, name, "interrupts", irq, 0x4);
-    qemu_fdt_setprop_cell(fdt, name, "clocks", clk_phandle);
+    qemu_fdt_setprop_cells(fdt, name, "clocks", clk_parent_phandle,
+                           clk_phandle);
     qemu_fdt_setprop_cell(fdt, name, "clock-frequency", 100000);
     qemu_fdt_setprop_cell(fdt, name, "#address-cells", 1);
     qemu_fdt_setprop_cell(fdt, name, "#size-cells", 0);
@@ -356,7 +362,6 @@ static void finalize_fdt(void *fdt, TTAtlantisSoCState *s)
 {
     uint32_t aplic_s_phandle = next_phandle();
     uint32_t imsic_s_phandle = next_phandle();
-    uint32_t periph_clk_phandle = next_phandle();
     uint32_t osc_24m_phandle = next_phandle();
     uint32_t prcm_rcpu_phandle;
     g_autofree char *rcpu_name, *hsio_name, *pcie_name, *mm_name;
@@ -372,10 +377,6 @@ static void finalize_fdt(void *fdt, TTAtlantisSoCState *s)
      *                       aplic_s_phandle);
      */
 
-    create_fdt_uart(fdt, &s->memmap[TT_ATL_UART1], TT_ATL_UART1_IRQ,
-                    aplic_s_phandle);
-
-    create_fdt_clk(fdt, "periph-clk", 100000000, periph_clk_phandle);
     create_fdt_clk(fdt, "osc-24m", 24000000, osc_24m_phandle);
 
     rcpu_name = create_fdt_prcm(fdt, &s->memmap[TT_ATL_PRCM_RCPU], "rcpu");
@@ -401,11 +402,15 @@ static void finalize_fdt(void *fdt, TTAtlantisSoCState *s)
                            prcm_rcpu_phandle, TT_ATL_CLK_MM_PLL0,
                            prcm_rcpu_phandle, TT_ATL_CLK_MM_PLL1);
 
+    create_fdt_uart(fdt, &s->memmap[TT_ATL_UART1], TT_ATL_UART1_IRQ,
+                    aplic_s_phandle, prcm_rcpu_phandle, TT_ATL_CLK_UART1_PCLK);
+
     for (int i = 0; i < TT_ATL_NUM_I2C; i++) {
         create_fdt_i2c(fdt,
                        &s->memmap[TT_ATL_I2C0 + i],
                        TT_ATL_I2C0_IRQ + i,
-                       aplic_s_phandle, periph_clk_phandle);
+                       aplic_s_phandle, prcm_rcpu_phandle,
+                       TT_ATL_CLK_I2C0_PCLK + i);
     }
 
     /* I2C peripherals: qemu specific */
-- 
2.55.0


