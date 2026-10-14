Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 319CECC6B20
	for <qemu-devel@archiver.kernel.org>; Wed, 14 Oct 2026 03:43:59 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xGpsf-0003oO-EJ; Tue, 13 Oct 2026 23:42:17 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1xGpsX-0003cb-QW
 for qemu-devel@nongnu.org; Tue, 13 Oct 2026 23:42:10 -0400
Received: from mail-pg1-x534.google.com ([2607:f8b0:4864:20::534])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1xGpsW-0001sP-6K
 for qemu-devel@nongnu.org; Tue, 13 Oct 2026 23:42:09 -0400
Received: by mail-pg1-x534.google.com with SMTP id
 41be03b00d2f7-cc4dbda1e5dso1315119a12.2
 for <qemu-devel@nongnu.org>; Tue, 13 Oct 2026 20:42:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1791949327; x=1792554127; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=vEsPkFkLUyA1NU56nP525qgRMdEHY/E8F4lp51ZoNeY=;
 b=IHbQj5qFnvMFtkpYXwlZ42J8ENIzRr00dLJCvSUXh5MFF0d8TJ6VTlPz59mDIJ431W
 EdvXa5JlOduyLLvdwQJJmBk7FtPMda7zJjpCZldYcimXGR1MPKSQizlc//L1zeGiIm6C
 xLxCYv5wyY5bybyWOwWwBmCc8GwT6xpw82c42k+jv7e1IIjMnK59/zMcdVdyyfLA+/a5
 jWWfROnX0NRgMS0ynSfZOKgnG+5xawYPz17Jin/J3Dt/o5WEPvIeqbgpqOIks0wwXq2G
 QXruPZp1maquxjrD3CgxCNSfxuh/QbtByMgHjpRpna3tjLAbpoltlGdbol9LNGQ8QJYh
 K30A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1791949327; x=1792554127;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=vEsPkFkLUyA1NU56nP525qgRMdEHY/E8F4lp51ZoNeY=;
 b=PSSfJEmxnI7KiBAKLGtHPwTzW0XpQQ6wpP5aZ5zsIVwlS0Gt/fHfUpM1QyXAn6hRTZ
 chH0o6DVCFnXh51RMiMDjL7JT08SXMF5uNrT5nH8YnvsEcyEAkwW8VQnwrucI9SllczH
 F689DlQbDtmkt3TGTb7grhyntZxkAmd4EQfL6hSHvFPUqGLhNvT38toK1ExtgU9ViwTk
 RTDB6QNRaYyA63dhWxK/LVmps54e8WyPP/PVeSjdOEWypbK/rRmTl97/2d29MLqTlFJz
 gJkWEHTJ7Pg3+Xwp94SKlsrrrcyi569023N16XrVJbcqvyuqNOOgt/T6EkBa1tPXZ8Xb
 cJag==
X-Gm-Message-State: AFq9FYJUzR9d5emiXMlRTUxuQPak4zryjc9mFLdBw973ii93iwShIGPu
 aVXwdcGu5Pt6zdQW4mFc/BYK9acRMromMZdPC+wf4LzCf4bxAq7eH0X1nPUvFA==
X-Gm-Gg: AYBFou3c7X1DwFX2sZwDwes8xmnwk8IUfOL9EODjoZVX/S1AHSEE0vp7j4XdY0Aoe8w
 BwYjVPoJq2RXk4BuydZm1pP3BfYTvdoo8RQs6wa3XtUlPJVHTDjFqhTy7D+KPTXAM7H/7O87w/e
 pJm89JuPwj2bN3C+Mv7V93MbY38fgU/YcwI35sCHHFAqwW2+u/I/AfDJGD/mO5h0Bi9rgdbi5jo
 gN0g7ooe1UsVrQ/nm+W7W8opG7GvB3c+9i0S5MRHfbuyFbHXT1qWjVAbrvkG5ULyilhCuaHGn+l
 975Ce1G+3YUsugrnAxtbD+0cjqUEV7XQC89dFbVwFGV59dAJC82W95A/zv3zW6m2v9nHUBslXNa
 oTu7AYwGVv1t4d0eQv4V8harmMBIMId/jF2GZr3obu+INRHvyOVaD5MZXNEZmPGwaPG7eF3TIit
 3iVJ+PmualjbexQl9fDrRZJNNYwQH0D4HLxsZyC4+3zjmMjAsWWP0KCVAqlj+X4Yk0SO7wsk0I2
 Noun0/TcEf3JXMe
X-Received: by 2002:a17:90b:4b92:b0:3a8:545f:520d with SMTP id
 98e67ed59e1d1-3ab3ac9f939mr11437942a91.32.1791949326906; 
 Tue, 13 Oct 2026 20:42:06 -0700 (PDT)
Received: from toolbx.alistair23.me ([2403:581e:fdf9:0:13b2:851f:d9cb:44c5])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-3ac61170b7bsm2321457a91.16.2026.10.13.20.42.04
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 13 Oct 2026 20:42:06 -0700 (PDT)
From: alistair23@gmail.com
X-Google-Original-From: alistair.francis@wdc.com
To: qemu-devel@nongnu.org
Cc: Anirudh Srinivasan <asrinivasan@oss.tenstorrent.com>,
 Alistair Francis <alistair.francis@wdc.com>
Subject: [PULL 52/52] hw/riscv/tt-atlantis: Update UART and I2C to use clk
 from PRCM
Date: Wed, 14 Oct 2026 13:39:07 +1000
Message-ID: <20261014033907.3332383-53-alistair.francis@wdc.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20261014033907.3332383-1-alistair.francis@wdc.com>
References: <20261014033907.3332383-1-alistair.francis@wdc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::534;
 envelope-from=alistair23@gmail.com; helo=mail-pg1-x534.google.com
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


