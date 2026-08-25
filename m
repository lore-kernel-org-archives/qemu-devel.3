Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7EB05C5DF81
	for <qemu-devel@archiver.kernel.org>; Tue, 25 Aug 2026 04:06:26 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wyiPZ-0006Gd-Ou; Tue, 25 Aug 2026 00:05:21 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stephensportia@gmail.com>)
 id 1wyiPX-0006FX-GF
 for qemu-devel@nongnu.org; Tue, 25 Aug 2026 00:05:19 -0400
Received: from mail-pg1-x52b.google.com ([2607:f8b0:4864:20::52b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <stephensportia@gmail.com>)
 id 1wyiPU-0007cH-24
 for qemu-devel@nongnu.org; Tue, 25 Aug 2026 00:05:19 -0400
Received: by mail-pg1-x52b.google.com with SMTP id
 41be03b00d2f7-cc147d86bebso375719a12.0
 for <qemu-devel@nongnu.org>; Mon, 24 Aug 2026 21:05:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1787630714; x=1788235514; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=bpZgNI6U09zLAIr/sXU7CBTSkl69mPWcZLi9Ua5xvg4=;
 b=WtWctR2nk/qxBUMMQ1U3JLfLbXtCNzqVKhZq573geYiKl8J/9pVtPOORf8cz2FHT2e
 f0KG0CSAXqdXkCG9NlMpsfjRm22c+cBzF6c4RN3GGYDFcOEBFEDDlumBqJyX5xcdh3RV
 eNOMD1k9tdMQ8VVTnnXxwVZU/3r8PooNWQ6yYrk+OO/LribtrnLm5PuMYhu18LirGeWG
 cUrT7WMaBB8EongEUn26kQ9z9IwhNzX/17cDgqU2xbkbzQC0ItXiAbOsttEMaLVR99mi
 XthQc8gzRi51LhnTZcHcGkxvD7VAmW1sdNrXCQZgrVuzml6xd5UogNvkpDzS/J7qoz3b
 cu9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787630714; x=1788235514;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=bpZgNI6U09zLAIr/sXU7CBTSkl69mPWcZLi9Ua5xvg4=;
 b=rtOvADVttOqE7bJXadD6eLgZ9L6X12dRTXgPi3aIOnWwi9gTzEhr/pBcpNBSwoc3Xk
 f7zxf5EnLGgm2GSXn67Mzn0Elzut/Lrv2NZTdvOYb1/r6/A9L+Da0juv47HJi9h3bHRN
 Gy14Z5aYdo9e1uGcSynF/v/c18/961KFUe5adAJXtC/3mypFx3GpnzoQAgp5A1lgGVli
 GJf4INJmWgVjY6Ewppw2CQo0o+0AEd6rXaYzu1oG9HOWVLyMvz5hqHI+CeWzWXFXSYot
 325Y9dn5bgvrIqqp3ScOerHOJEQRXp75qLrKWp/IFcP12E4RkKwjOdDaTqJq9ZbYj6aV
 pCQg==
X-Gm-Message-State: AFuF++m3TxLFD5I/PE78F5bkTLWbJDvdByR8PNAhqWbUuiutOnz3EL6G
 L3BMkovtJieZXLGsuVFNOkVGVLfGGMsdTKY6QusGnsxHVZpm7Ue9MQPiBT9CHn9Q
X-Gm-Gg: AR+sD10YMMBybHVqSBq9hARMNCPYPnNGBYtHdg+4DLpCWIfyJpN4UESNg+fESJw0TOy
 UFsPxWVJC3BAGEeETkupskNjYa/doa84x9LgaDb/fQ4Diw9rb7mxhxtAsVHReT6983llWooRsBN
 0dUelqrDkUwUQ4JFyzXC83d5QH1HX9UH1p1hmWHtvJqGgfDjTHCSF9Gcd4lTY2YpLpHfnOK/X3h
 vsEUyMXmII/9xFEdQWxxXBnA1sKpSz1V+WUUKu2P5PpDrs4orm6rP3H7KUERFghczTvRGIWGcPB
 9lQ0HgGOqw147LbmmLSnn1lPvD1z1NZlQsHJhlEv5SQtdEqz47WFeMlHwHwax3ExzUm7e05SakY
 yD7mPFhkBQ2ca6++DhSmGjzyp0Y5mgzy46quv9ihas+jWH6PFq3kmTYrJz31LzZgTArmV6ywqCt
 2l7keBZs3W4KmGGA/oGvpHwkfIiw4RE4tKVaCbaLJYGc/wx3RtRQrRvnImJe1lfiLY/pnx9leaO
 Uy1ERgU2JQKrzW/pGp2mbyzH0YJAq9uhA==
X-Received: by 2002:a17:90b:2b88:b0:38f:cab0:9aa9 with SMTP id
 98e67ed59e1d1-39645a57193mr5547960a91.13.1787630714066; 
 Mon, 24 Aug 2026 21:05:14 -0700 (PDT)
Received: from lima-default.tail89d63.ts.net ([159.196.41.205])
 by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-327f909adc8sm34104212eec.2.2026.08.24.21.05.05
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 24 Aug 2026 21:05:13 -0700 (PDT)
From: stephensportia@gmail.com
To: qemu-devel@nongnu.org
Cc: Palmer Dabbelt <palmer@dabbelt.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 Jamin Lin <jamin_lin@aspeedtech.com>, qemu-ppc@nongnu.org,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>,
 Steven Lee <steven_lee@aspeedtech.com>,
 Andrew Jeffery <andrew@codeconstruct.com.au>,
 Harsh Prateek Bora <harshpb@linux.ibm.com>,
 Subbaraya Sundeep <sundeep.lkml@gmail.com>, Troy Lee <leetroy@gmail.com>,
 "Edgar E. Iglesias" <edgar.iglesias@gmail.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@mailo.com>,
 Alistair Francis <alistair@alistair23.me>,
 Strahinja Jankovic <strahinja.p.jankovic@gmail.com>, qemu-arm@nongnu.org,
 Tyrone Ting <kfting@nuvoton.com>, Nicholas Piggin <npiggin@gmail.com>,
 Aditya Gupta <adityag@linux.ibm.com>, Kane Chen <kane_chen@aspeedtech.com>,
 Francisco Iglesias <francisco.iglesias@amd.com>,
 Joel Stanley <joel@jms.id.au>, Hao Wu <wuhaotsh@google.com>,
 Glenn Miles <milesg@linux.ibm.com>, qemu-riscv@nongnu.org,
 Jean-Christophe Dubois <jcd@tribudubois.net>,
 Portia Stephens <portias@oss.tenstorrent.com>
Subject: [PATCH 1/4] hw/ssi: Rename ssi_transfer to ssi_transfer8
Date: Tue, 25 Aug 2026 14:04:49 +1000
Message-ID: <20260825040452.1322251-2-stephensportia@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260825040452.1322251-1-stephensportia@gmail.com>
References: <20260825040452.1322251-1-stephensportia@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::52b;
 envelope-from=stephensportia@gmail.com; helo=mail-pg1-x52b.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

From: Portia Stephens <portias@oss.tenstorrent.com>

The ssi_transfer function comments say that it takes a word varying
between 8-bits and 32-bits. ssi_transfer takes a 32-bit arg to transfer
but there is no means to indicate the number of bits that should
actually be transferred. All child classes of SSI_PERIPHERAL class have
transfer functions that, despite accepting a 32-bit tx, only transfer a
single byte; m25p80_transfer8(), ssi_sd_transfer(), ssd0323_transfer().

The current implementation depends on the SSI model to know
what peripheral model will be attached and what transfer size it
expects which is error prone. If a SSI_PERIPHERAL model was written that
accepted 32-bit transfers, it could not attach to any existing SSI
models.

This change updates the naming of ssi_transfer to ssi_transfer8, as
well as changes the return value and transmit argument to be 8-bit.

Signed-off-by: Portia Stephens <portias@oss.tenstorrent.com>
---
 hw/arm/strongarm.c         |  2 +-
 hw/ssi/allwinner-a10-spi.c |  2 +-
 hw/ssi/aspeed_smc.c        | 14 ++++++-------
 hw/ssi/bcm2835_spi.c       |  2 +-
 hw/ssi/ibex_spi_host.c     |  5 +++--
 hw/ssi/imx_spi.c           |  2 +-
 hw/ssi/mss-spi.c           |  2 +-
 hw/ssi/npcm7xx_fiu.c       | 42 +++++++++++++++++++-------------------
 hw/ssi/npcm_pspi.c         |  4 ++--
 hw/ssi/pl022.c             |  2 +-
 hw/ssi/pnv_spi.c           |  2 +-
 hw/ssi/sifive_spi.c        |  2 +-
 hw/ssi/ssi.c               |  4 ++--
 hw/ssi/stm32f2xx_spi.c     |  2 +-
 hw/ssi/xilinx_spi.c        | 10 ++++-----
 hw/ssi/xilinx_spips.c      |  4 ++--
 hw/ssi/xlnx-versal-ospi.c  |  4 ++--
 include/hw/ssi/ssi.h       | 17 ++++++++-------
 18 files changed, 61 insertions(+), 61 deletions(-)

diff --git a/hw/arm/strongarm.c b/hw/arm/strongarm.c
index 5a3242195a..e400f0a185 100644
--- a/hw/arm/strongarm.c
+++ b/hw/arm/strongarm.c
@@ -1516,7 +1516,7 @@ static void strongarm_ssp_write(void *opaque, hwaddr addr,
             if (s->sscr[1] & SSCR1_LBM) {
                 readval = value;
             } else {
-                readval = ssi_transfer(s->bus, value);
+                readval = ssi_transfer8(s->bus, value);
             }
 
             if (s->rx_level < 0x08) {
diff --git a/hw/ssi/allwinner-a10-spi.c b/hw/ssi/allwinner-a10-spi.c
index 69920b935a..5758e81c10 100644
--- a/hw/ssi/allwinner-a10-spi.c
+++ b/hw/ssi/allwinner-a10-spi.c
@@ -300,7 +300,7 @@ static void allwinner_a10_spi_flush_txfifo(AWA10SPIState *s)
         trace_allwinner_a10_spi_tx(tx);
 
         /* Write one byte at a time */
-        rx = ssi_transfer(s->bus, tx);
+        rx = ssi_transfer8(s->bus, tx);
 
         trace_allwinner_a10_spi_rx(rx);
 
diff --git a/hw/ssi/aspeed_smc.c b/hw/ssi/aspeed_smc.c
index bf596f7b2d..f6e8dd9457 100644
--- a/hw/ssi/aspeed_smc.c
+++ b/hw/ssi/aspeed_smc.c
@@ -488,10 +488,10 @@ static void aspeed_smc_flash_setup(AspeedSMCFlash *fl, uint32_t addr)
     /* Flash access can not exceed CS segment */
     addr = aspeed_smc_check_segment_addr(fl, addr);
 
-    ssi_transfer(s->spi, cmd);
+    ssi_transfer8(s->spi, cmd);
     while (i--) {
         if (aspeed_smc_addr_byte_enabled(s, i)) {
-            ssi_transfer(s->spi, (addr >> (i * 8)) & 0xff);
+            ssi_transfer8(s->spi, (addr >> (i * 8)) & 0xff);
         }
     }
 
@@ -503,7 +503,7 @@ static void aspeed_smc_flash_setup(AspeedSMCFlash *fl, uint32_t addr)
      */
     if (aspeed_smc_flash_mode(fl) == CTRL_FREADMODE) {
         for (i = 0; i < aspeed_smc_flash_dummy_bytes(fl); i++) {
-            ssi_transfer(fl->controller->spi, s->regs[R_DUMMY_DATA] & 0xff);
+            ssi_transfer8(fl->controller->spi, s->regs[R_DUMMY_DATA] & 0xff);
         }
     }
 }
@@ -519,7 +519,7 @@ static MemTxResult aspeed_smc_flash_read(void *opaque, hwaddr addr,
     switch (aspeed_smc_flash_mode(fl)) {
     case CTRL_USERMODE:
         for (i = 0; i < size; i++) {
-            *data |= (uint64_t) ssi_transfer(s->spi, 0x0) << (8 * i);
+            *data |= (uint64_t) ssi_transfer8(s->spi, 0x0) << (8 * i);
         }
         break;
     case CTRL_READMODE:
@@ -528,7 +528,7 @@ static MemTxResult aspeed_smc_flash_read(void *opaque, hwaddr addr,
         aspeed_smc_flash_setup(fl, addr);
 
         for (i = 0; i < size; i++) {
-            *data |= (uint64_t) ssi_transfer(s->spi, 0x0) << (8 * i);
+            *data |= (uint64_t) ssi_transfer8(s->spi, 0x0) << (8 * i);
         }
 
         aspeed_smc_flash_unselect(fl);
@@ -561,7 +561,7 @@ static MemTxResult aspeed_smc_flash_write(void *opaque, hwaddr addr,
     switch (aspeed_smc_flash_mode(fl)) {
     case CTRL_USERMODE:
         for (i = 0; i < size; i++) {
-            ssi_transfer(s->spi, (data >> (8 * i)) & 0xff);
+            ssi_transfer8(s->spi, (data >> (8 * i)) & 0xff);
         }
         break;
     case CTRL_WRITEMODE:
@@ -569,7 +569,7 @@ static MemTxResult aspeed_smc_flash_write(void *opaque, hwaddr addr,
         aspeed_smc_flash_setup(fl, addr);
 
         for (i = 0; i < size; i++) {
-            ssi_transfer(s->spi, (data >> (8 * i)) & 0xff);
+            ssi_transfer8(s->spi, (data >> (8 * i)) & 0xff);
         }
 
         aspeed_smc_flash_unselect(fl);
diff --git a/hw/ssi/bcm2835_spi.c b/hw/ssi/bcm2835_spi.c
index 01763c458c..7a0a8fa392 100644
--- a/hw/ssi/bcm2835_spi.c
+++ b/hw/ssi/bcm2835_spi.c
@@ -91,7 +91,7 @@ static void bcm2835_spi_flush_tx_fifo(BCM2835SPIState *s)
 
     while (!fifo8_is_empty(&s->tx_fifo) && !fifo8_is_full(&s->rx_fifo)) {
         tx_byte = fifo8_pop(&s->tx_fifo);
-        rx_byte = ssi_transfer(s->bus, tx_byte);
+        rx_byte = ssi_transfer8(s->bus, tx_byte);
         fifo8_push(&s->rx_fifo, rx_byte);
     }
 
diff --git a/hw/ssi/ibex_spi_host.c b/hw/ssi/ibex_spi_host.c
index 1e574c3fcb..b5e556eedc 100644
--- a/hw/ssi/ibex_spi_host.c
+++ b/hw/ssi/ibex_spi_host.c
@@ -236,7 +236,8 @@ static void ibex_spi_host_irq(IbexSPIHostState *s)
 
 static void ibex_spi_host_transfer(IbexSPIHostState *s)
 {
-    uint32_t rx, tx, data;
+    uint32_t data;
+    uint8_t rx, tx;
     /* Get num of one byte transfers */
     uint8_t segment_len = FIELD_EX32(s->regs[IBEX_SPI_HOST_COMMAND],
                                      COMMAND,  LEN);
@@ -254,7 +255,7 @@ static void ibex_spi_host_transfer(IbexSPIHostState *s)
             tx = fifo8_pop(&s->tx_fifo);
         }
 
-        rx = ssi_transfer(s->ssi, tx);
+        rx = ssi_transfer8(s->ssi, tx);
 
         trace_ibex_spi_host_transfer(tx, rx);
 
diff --git a/hw/ssi/imx_spi.c b/hw/ssi/imx_spi.c
index 8e014b7a7b..b25cf6c559 100644
--- a/hw/ssi/imx_spi.c
+++ b/hw/ssi/imx_spi.c
@@ -194,7 +194,7 @@ static void imx_spi_flush_txfifo(IMXSPIState *s)
             DPRINTF("writing 0x%02x\n", (uint32_t)byte);
 
             /* We need to write one byte at a time */
-            byte = ssi_transfer(s->bus, byte);
+            byte = ssi_transfer8(s->bus, byte);
 
             DPRINTF("0x%02x read\n", (uint32_t)byte);
 
diff --git a/hw/ssi/mss-spi.c b/hw/ssi/mss-spi.c
index 3c118fc0f8..8a7af68a8a 100644
--- a/hw/ssi/mss-spi.c
+++ b/hw/ssi/mss-spi.c
@@ -234,7 +234,7 @@ static void spi_flush_txfifo(MSSSpiState *s)
 
         tx = fifo32_pop(&s->tx_fifo);
         DB_PRINT("data tx:0x%" PRIx32, tx);
-        rx = ssi_transfer(s->spi, tx);
+        rx = ssi_transfer8(s->spi, tx);
         DB_PRINT("data rx:0x%" PRIx32, rx);
 
         if (fifo32_num_used(&s->rx_fifo) == s->fifo_depth) {
diff --git a/hw/ssi/npcm7xx_fiu.c b/hw/ssi/npcm7xx_fiu.c
index d41d877cfb..b0be46aa18 100644
--- a/hw/ssi/npcm7xx_fiu.c
+++ b/hw/ssi/npcm7xx_fiu.c
@@ -162,16 +162,16 @@ static uint64_t npcm7xx_fiu_flash_read(void *opaque, hwaddr addr,
     npcm7xx_fiu_select(fiu, npcm7xx_fiu_cs_index(fiu, f));
 
     drd_cfg = fiu->regs[NPCM7XX_FIU_DRD_CFG];
-    ssi_transfer(fiu->spi, FIU_DRD_CFG_RDCMD(drd_cfg));
+    ssi_transfer8(fiu->spi, FIU_DRD_CFG_RDCMD(drd_cfg));
 
     switch (FIU_DRD_CFG_ADDSIZ(drd_cfg)) {
     case FIU_ADDSIZ_4BYTES:
-        ssi_transfer(fiu->spi, extract32(addr, 24, 8));
+        ssi_transfer8(fiu->spi, extract32(addr, 24, 8));
         /* fall through */
     case FIU_ADDSIZ_3BYTES:
-        ssi_transfer(fiu->spi, extract32(addr, 16, 8));
-        ssi_transfer(fiu->spi, extract32(addr, 8, 8));
-        ssi_transfer(fiu->spi, extract32(addr, 0, 8));
+        ssi_transfer8(fiu->spi, extract32(addr, 16, 8));
+        ssi_transfer8(fiu->spi, extract32(addr, 8, 8));
+        ssi_transfer8(fiu->spi, extract32(addr, 0, 8));
         break;
 
     default:
@@ -182,11 +182,11 @@ static uint64_t npcm7xx_fiu_flash_read(void *opaque, hwaddr addr,
 
     dummy_bytes = FIU_DRD_CFG_DBW(drd_cfg);
     for (i = 0; i < dummy_bytes; i++) {
-        ssi_transfer(fiu->spi, 0);
+        ssi_transfer8(fiu->spi, 0);
     }
 
     for (i = 0; i < size; i++) {
-        value = deposit64(value, 8 * i, 8, ssi_transfer(fiu->spi, 0));
+        value = deposit64(value, 8 * i, 8, ssi_transfer8(fiu->spi, 0));
     }
 
     trace_npcm7xx_fiu_flash_read(DEVICE(fiu)->canonical_path, fiu->active_cs,
@@ -219,16 +219,16 @@ static void npcm7xx_fiu_flash_write(void *opaque, hwaddr addr, uint64_t v,
     npcm7xx_fiu_select(fiu, cs_id);
 
     dwr_cfg = fiu->regs[NPCM7XX_FIU_DWR_CFG];
-    ssi_transfer(fiu->spi, FIU_DWR_CFG_WRCMD(dwr_cfg));
+    ssi_transfer8(fiu->spi, FIU_DWR_CFG_WRCMD(dwr_cfg));
 
     switch (FIU_DWR_CFG_ADDSIZ(dwr_cfg)) {
     case FIU_ADDSIZ_4BYTES:
-        ssi_transfer(fiu->spi, extract32(addr, 24, 8));
+        ssi_transfer8(fiu->spi, extract32(addr, 24, 8));
         /* fall through */
     case FIU_ADDSIZ_3BYTES:
-        ssi_transfer(fiu->spi, extract32(addr, 16, 8));
-        ssi_transfer(fiu->spi, extract32(addr, 8, 8));
-        ssi_transfer(fiu->spi, extract32(addr, 0, 8));
+        ssi_transfer8(fiu->spi, extract32(addr, 16, 8));
+        ssi_transfer8(fiu->spi, extract32(addr, 8, 8));
+        ssi_transfer8(fiu->spi, extract32(addr, 0, 8));
         break;
 
     default:
@@ -238,7 +238,7 @@ static void npcm7xx_fiu_flash_write(void *opaque, hwaddr addr, uint64_t v,
     }
 
     for (i = 0; i < size; i++) {
-        ssi_transfer(fiu->spi, extract64(v, i * 8, 8));
+        ssi_transfer8(fiu->spi, extract64(v, i * 8, 8));
     }
 
     npcm7xx_fiu_deselect(fiu);
@@ -287,16 +287,16 @@ static void send_address(SSIBus *spi, unsigned int addsiz, uint32_t addr)
 {
     switch (addsiz) {
     case 4:
-        ssi_transfer(spi, extract32(addr, 24, 8));
+        ssi_transfer8(spi, extract32(addr, 24, 8));
         /* fall through */
     case 3:
-        ssi_transfer(spi, extract32(addr, 16, 8));
+        ssi_transfer8(spi, extract32(addr, 16, 8));
         /* fall through */
     case 2:
-        ssi_transfer(spi, extract32(addr, 8, 8));
+        ssi_transfer8(spi, extract32(addr, 8, 8));
         /* fall through */
     case 1:
-        ssi_transfer(spi, extract32(addr, 0, 8));
+        ssi_transfer8(spi, extract32(addr, 0, 8));
         /* fall through */
     case 0:
         break;
@@ -309,7 +309,7 @@ static void send_dummy_bytes(SSIBus *spi, uint32_t uma_cfg)
     unsigned int i;
 
     for (i = 0; i < FIU_UMA_CFG_DBSIZ(uma_cfg); i++) {
-        ssi_transfer(spi, 0);
+        ssi_transfer8(spi, 0);
     }
 }
 
@@ -329,7 +329,7 @@ static void npcm7xx_fiu_uma_transaction(NPCM7xxFIUState *s)
     /* Send command, if present. */
     uma_cfg = s->regs[NPCM7XX_FIU_UMA_CFG];
     if (FIU_UMA_CFG_CMDSIZ(uma_cfg) > 0) {
-        ssi_transfer(s->spi, extract32(s->regs[NPCM7XX_FIU_UMA_CMD], 0, 8));
+        ssi_transfer8(s->spi, extract32(s->regs[NPCM7XX_FIU_UMA_CMD], 0, 8));
     }
 
     /* Send address, if present. */
@@ -342,7 +342,7 @@ static void npcm7xx_fiu_uma_transaction(NPCM7xxFIUState *s)
             (i < 16) ? (NPCM7XX_FIU_UMA_DW0 + i / 4) : NPCM7XX_FIU_UMA_DW3;
         unsigned int field = (i % 4) * 8;
 
-        ssi_transfer(s->spi, extract32(s->regs[reg], field, 8));
+        ssi_transfer8(s->spi, extract32(s->regs[reg], field, 8));
     }
 
     /* Send dummy bytes, if present */
@@ -354,7 +354,7 @@ static void npcm7xx_fiu_uma_transaction(NPCM7xxFIUState *s)
         unsigned int field = (i % 4) * 8;
         uint8_t c;
 
-        c = ssi_transfer(s->spi, 0);
+        c = ssi_transfer8(s->spi, 0);
         if (reg <= NPCM7XX_FIU_UMA_DR3) {
             s->regs[reg] = deposit32(s->regs[reg], field, 8, c);
         }
diff --git a/hw/ssi/npcm_pspi.c b/hw/ssi/npcm_pspi.c
index 2e05d5dacb..38ae6e0972 100644
--- a/hw/ssi/npcm_pspi.c
+++ b/hw/ssi/npcm_pspi.c
@@ -77,9 +77,9 @@ static void npcm_pspi_write_data(NPCMPSPIState *s, uint16_t data)
     uint16_t value = 0;
 
     if (FIELD_EX16(s->regs[R_PSPI_CTL1], PSPI_CTL1, MOD)) {
-        value = ssi_transfer(s->spi, extract16(data, 8, 8)) << 8;
+        value = ssi_transfer8(s->spi, extract16(data, 8, 8)) << 8;
     }
-    value |= ssi_transfer(s->spi, extract16(data, 0, 8));
+    value |= ssi_transfer8(s->spi, extract16(data, 0, 8));
     s->regs[R_PSPI_DATA] = value;
 
     /* Mark data as available */
diff --git a/hw/ssi/pl022.c b/hw/ssi/pl022.c
index 715a2d21f4..eaac664ec5 100644
--- a/hw/ssi/pl022.c
+++ b/hw/ssi/pl022.c
@@ -103,7 +103,7 @@ static void pl022_xfer(PL022State *s)
         if (s->cr1 & PL022_CR1_LBM) {
             /* Loopback mode.  */
         } else {
-            val = ssi_transfer(s->ssi, val);
+            val = ssi_transfer8(s->ssi, val);
         }
         s->rx_fifo[o] = val & s->bitmask;
         i = (i + 1) & 7;
diff --git a/hw/ssi/pnv_spi.c b/hw/ssi/pnv_spi.c
index f3add8cab9..e2a8a710da 100644
--- a/hw/ssi/pnv_spi.c
+++ b/hw/ssi/pnv_spi.c
@@ -209,7 +209,7 @@ static void transfer(PnvSpi *s)
                 qemu_log_mask(LOG_GUEST_ERROR, "pnv_spi: TX_FIFO underflow\n");
             }
         }
-        rx = ssi_transfer(s->ssi_bus, tx);
+        rx = ssi_transfer8(s->ssi_bus, tx);
         for (int i = 0; i < s->transfer_len; i++) {
             if ((offset + i) >= payload_len) {
                 break;
diff --git a/hw/ssi/sifive_spi.c b/hw/ssi/sifive_spi.c
index 2ece78053b..1a2aac2daa 100644
--- a/hw/ssi/sifive_spi.c
+++ b/hw/ssi/sifive_spi.c
@@ -134,7 +134,7 @@ static void sifive_spi_flush_txfifo(SiFiveSPIState *s)
 
     while (!fifo8_is_empty(&s->tx_fifo)) {
         tx = fifo8_pop(&s->tx_fifo);
-        rx = ssi_transfer(s->spi, tx);
+        rx = ssi_transfer8(s->spi, tx);
 
         if (!fifo8_is_full(&s->rx_fifo)) {
             if (!(s->regs[R_FMT] & FMT_DIR)) {
diff --git a/hw/ssi/ssi.c b/hw/ssi/ssi.c
index 3a4fade2d5..ce2325bbd4 100644
--- a/hw/ssi/ssi.c
+++ b/hw/ssi/ssi.c
@@ -153,11 +153,11 @@ SSIBus *ssi_create_bus(DeviceState *parent, const char *name)
     return SSI_BUS(bus);
 }
 
-uint32_t ssi_transfer(SSIBus *bus, uint32_t val)
+uint8_t ssi_transfer8(SSIBus *bus, uint8_t val)
 {
     BusState *b = BUS(bus);
     BusChild *kid;
-    uint32_t r = 0;
+    uint8_t r = 0;
 
     QTAILQ_FOREACH(kid, &b->children, sibling) {
         SSIPeripheral *p = SSI_PERIPHERAL(kid->child);
diff --git a/hw/ssi/stm32f2xx_spi.c b/hw/ssi/stm32f2xx_spi.c
index 871d57324d..eca0b93f3f 100644
--- a/hw/ssi/stm32f2xx_spi.c
+++ b/hw/ssi/stm32f2xx_spi.c
@@ -59,7 +59,7 @@ static void stm32f2xx_spi_transfer(STM32F2XXSPIState *s)
 {
     DB_PRINT("Data to send: 0x%x\n", s->spi_dr);
 
-    s->spi_dr = ssi_transfer(s->ssi, s->spi_dr);
+    s->spi_dr = ssi_transfer8(s->ssi, s->spi_dr);
     s->spi_sr |= STM_SPI_SR_RXNE;
 
     DB_PRINT("Data received: 0x%x\n", s->spi_dr);
diff --git a/hw/ssi/xilinx_spi.c b/hw/ssi/xilinx_spi.c
index 79f3e8bfae..45e9459396 100644
--- a/hw/ssi/xilinx_spi.c
+++ b/hw/ssi/xilinx_spi.c
@@ -176,18 +176,18 @@ static inline int spi_master_enabled(XilinxSPI *s)
 
 static void spi_flush_txfifo(XilinxSPI *s)
 {
-    uint32_t tx;
-    uint32_t rx;
+   uint8_t tx;
+   uint8_t rx;
 
     while (!fifo8_is_empty(&s->tx_fifo)) {
-        tx = (uint32_t)fifo8_pop(&s->tx_fifo);
+        tx = fifo8_pop(&s->tx_fifo);
         DB_PRINT("data tx:%x\n", tx);
-        rx = ssi_transfer(s->spi, tx);
+        rx = ssi_transfer8(s->spi, tx);
         DB_PRINT("data rx:%x\n", rx);
         if (fifo8_is_full(&s->rx_fifo)) {
             s->regs[R_IPISR] |= IRQ_DRR_OVERRUN;
         } else {
-            fifo8_push(&s->rx_fifo, (uint8_t)rx);
+            fifo8_push(&s->rx_fifo, rx);
             if (fifo8_is_full(&s->rx_fifo)) {
                 s->regs[R_SPISR] |= SR_RX_FULL;
                 s->regs[R_IPISR] |= IRQ_DRR_FULL;
diff --git a/hw/ssi/xilinx_spips.c b/hw/ssi/xilinx_spips.c
index e4fce2c195..b915000770 100644
--- a/hw/ssi/xilinx_spips.c
+++ b/hw/ssi/xilinx_spips.c
@@ -576,7 +576,7 @@ static void xlnx_zynqmp_qspips_flush_fifo_g(XlnxZynqMPQSPIPS *s)
         busses = ARRAY_FIELD_EX32(s->regs, GQSPI_GF_SNAPSHOT, DATA_BUS_SELECT);
         for (i = 0; i < 2; ++i) {
             DB_PRINT_L(1, "bus %d tx = %02x\n", i, tx_rx[i]);
-            tx_rx[i] = ssi_transfer(XILINX_SPIPS(s)->spi[i], tx_rx[i]);
+            tx_rx[i] = ssi_transfer8(XILINX_SPIPS(s)->spi[i], tx_rx[i]);
             DB_PRINT_L(1, "bus %d rx = %02x\n", i, tx_rx[i]);
         }
         if (s->regs[R_GQSPI_DATA_STS] > 1 &&
@@ -696,7 +696,7 @@ static void xilinx_spips_flush_txfifo(XilinxSPIPS *s)
             int bus = num_effective_busses(s) - 1 - i;
 
             DB_PRINT_L(debug_level, "tx = %02x\n", tx_rx[i]);
-            tx_rx[i] = ssi_transfer(s->spi[bus], (uint32_t)tx_rx[i]);
+            tx_rx[i] = ssi_transfer8(s->spi[bus], tx_rx[i]);
             DB_PRINT_L(debug_level, "rx = %02x\n", tx_rx[i]);
         }
 
diff --git a/hw/ssi/xlnx-versal-ospi.c b/hw/ssi/xlnx-versal-ospi.c
index e25e4c26c2..8f2cb71414 100644
--- a/hw/ssi/xlnx-versal-ospi.c
+++ b/hw/ssi/xlnx-versal-ospi.c
@@ -631,9 +631,9 @@ static void ospi_disable_cs(XlnxVersalOspi *s)
 static void ospi_flush_txfifo(XlnxVersalOspi *s)
 {
     while (!fifo8_is_empty(&s->tx_fifo)) {
-        uint32_t tx_rx = fifo8_pop(&s->tx_fifo);
+        uint8_t tx_rx = fifo8_pop(&s->tx_fifo);
 
-        tx_rx = ssi_transfer(s->spi, tx_rx);
+        tx_rx = ssi_transfer8(s->spi, tx_rx);
         fifo8_push(&s->rx_fifo, tx_rx);
     }
 }
diff --git a/include/hw/ssi/ssi.h b/include/hw/ssi/ssi.h
index 6d6d8ccb3d..e8be6c2023 100644
--- a/include/hw/ssi/ssi.h
+++ b/include/hw/ssi/ssi.h
@@ -38,7 +38,7 @@ struct SSIPeripheralClass {
 
     /* if you have standard or no CS behaviour, just override transfer.
      * This is called when the device cs is active (true by default).
-     * See ssi_transfer().
+     * See ssi_transfer8().
      */
     uint32_t (*transfer)(SSIPeripheral *dev, uint32_t val);
     /* called when the CS line changes. Optional, devices only need to implement
@@ -53,7 +53,7 @@ struct SSIPeripheralClass {
      * of the CS behaviour at the device level. transfer, set_cs, and
      * cs_polarity are unused if this is overwritten. Transfer_raw will
      * always be called for the device for every txrx access to the parent bus
-     * See ssi_transfer().
+     * See ssi_transfer8().
      */
     uint32_t (*transfer_raw)(SSIPeripheral *dev, uint32_t val);
 };
@@ -113,18 +113,17 @@ bool ssi_realize_and_unref(DeviceState *dev, SSIBus *bus, Error **errp);
 SSIBus *ssi_create_bus(DeviceState *parent, const char *name);
 
 /**
- * Transfer a word on a SSI bus
+ * Transfer a byte on a SSI bus
  * @bus: SSI bus
- * @val: word to transmit
+ * @val: byte to transmit
  *
- * At the same time, read a word and write the @val one on the SSI bus.
+ * At the same time, read a byte and write the @val one on the SSI bus.
  *
- * SSI words might vary between 8 and 32 bits. The same number of bits
- * written is received.
+ * SSI always transfers and receives 8-bits.
  *
- * Return: word value received
+ * Return: byte received
  */
-uint32_t ssi_transfer(SSIBus *bus, uint32_t val);
+uint8_t ssi_transfer8(SSIBus *bus, uint8_t val);
 
 DeviceState *ssi_get_cs(SSIBus *bus, uint8_t cs_index);
 
-- 
2.43.0


