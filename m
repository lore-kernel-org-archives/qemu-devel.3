Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F03DBC5321C
	for <qemu-devel@archiver.kernel.org>; Sun, 26 Jul 2026 12:30:18 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wnxyz-0001Jc-3P; Sun, 26 Jul 2026 08:29:29 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <flamboyant.h.01@gmail.com>)
 id 1wnxyo-0001Fu-Qm
 for qemu-devel@nongnu.org; Sun, 26 Jul 2026 08:29:20 -0400
Received: from mail-pf1-x431.google.com ([2607:f8b0:4864:20::431])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <flamboyant.h.01@gmail.com>)
 id 1wnxym-0003I2-LK
 for qemu-devel@nongnu.org; Sun, 26 Jul 2026 08:29:18 -0400
Received: by mail-pf1-x431.google.com with SMTP id
 d2e1a72fcca58-84a4d8fd6ecso1856018b3a.1
 for <qemu-devel@nongnu.org>; Sun, 26 Jul 2026 05:29:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1785068955; x=1785673755; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=RfeUrKHUGv+U9oRVEXuUSDC6Vwliyabt5KfqsBfccrY=;
 b=QaLS2140Sal3XJhimitHJlK2Ku9oME2A91EkFwvc5B1Jc/vnhNKheZ4JMavAGxSRJb
 BhmSi8Xo52HEpiN2h6kwzSYgld2O+7E63NcTjrMIX0028zo19lJ/Kk6aa6VuvAhxDTID
 Odqj/NIIijsO73d4XRD15tzODV1Tb0fpg3qAtG5OJB+U/iD8TF2tJ9OMWpEDP+FlKbpz
 D5rx6s7XglK/6eLlguRkxjPkssqtD0gU683CGTklBJqOQYyho14gomrX8EQhVHt2SaZk
 khBH437OlU0f8OmP/3qlxvVGp3STZIkSU+bZyzXLT0z0C36w9wgibhMakOsL2vIAIldy
 amGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1785068955; x=1785673755;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=RfeUrKHUGv+U9oRVEXuUSDC6Vwliyabt5KfqsBfccrY=;
 b=YUHYdQuhb8UUCgN4LWglaq89Pa/Ep6aFKwjgOZ32NYldPPzpC4NMEB1BziQ5vSQF0q
 ofoU4kcouFAPvXMawvaRsgkrLeKEn0kgAnPhmk2KBSpWoxB3B+Hobiu1MpN7ZAXUXKEM
 ir17DmWKyvXt8fc9GXkvX29e+L2xm8OEKDZAGRiXgjK9xWSCy/tA911xgRbClxadKy1y
 /VUH41uaPNyi1DEiKlaWOHlOSeNknknYxGD8WM8rJbqvnKiAAoHqGDhZWMrFYKSh6Bf1
 kVdDQod9+CYIA+sutxDdslygUFHkXu48PVLfATAn3HX/6DuALjGUAPDLG4WP27sS7a4Z
 uH8A==
X-Gm-Message-State: AOJu0YzdG4xzBfp6Z5j3xDf1NypC3vwXp78N2CZ5BbdujgtGw0jdnUUm
 zQVahhEv9GhYKPJc6bpcANq+fo/9UtxhZTy8sHLSedTfxrchgWigeItltmQPN4nKrIE=
X-Gm-Gg: AR+sD13MWv5naUu1PQXXX3gQZprdYeut5GYG3DmRI6D7kgZVxSl+J4vj2CE7AFBSqx/
 nL0riyq6sfDYecp27H6+NqxHezOGnfq50mLs146ZGzxMoT0KDd/pq3YotF4nbPdjPKdNCmAb9+I
 3txOuJ0wPae/HbzZNtWsbBT7qI7ID2O3R+Kfh9gatCiQUgAop9Cu+0bR0xhwP4k6QBfpU8jzueS
 v1FaPXZh9YUx/bJwkaE5/6K4wL72cG0prL9FMYabIdCtDNM5Y/HQrarmSinkerUaUCTXHBDmOaq
 UKVwZGmmI/NmVN/WjMN5TxYWx0Aqa2NnaB6Q3MvdVyxBs45tdwrZoOUQ3KD98w0QAw6UrvGEa+G
 T89ud5ySpPP3JlPdFS1P4BZ62sPbDG/u92eOAbNmNNRcTQdM7zUCifAgg/Z8FCKcTDZVWZW2xUN
 pEmYCpP6l2xn3724ozIdMxBH8jdnwEU3w=
X-Received: by 2002:a05:6a00:1f05:b0:846:c7f4:74d with SMTP id
 d2e1a72fcca58-84e5955b5b4mr3526491b3a.41.1785068955003; 
 Sun, 26 Jul 2026 05:29:15 -0700 (PDT)
Received: from localhost.localdomain ([111.201.4.215])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-84e53426628sm1861647b3a.49.2026.07.26.05.29.10
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 26 Jul 2026 05:29:14 -0700 (PDT)
From: Kangjie Huang <flamboyant.h.01@gmail.com>
To: qemu-devel@nongnu.org
Cc: Kangjie Huang <flamboyant.h.01@gmail.com>, qemu-riscv@nongnu.org,
 Chao Liu <chao.liu@processmission.com>,
 Alistair Francis <alistair.francis@wdc.com>,
 Alistair Francis <alistair@alistair23.me>,
 Palmer Dabbelt <palmer@dabbelt.com>, Weiwei Li <liwei1518@gmail.com>,
 Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>,
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Fabiano Rosas <farosas@suse.de>,
 Laurent Vivier <lvivier@redhat.com>
Subject: [PATCH 03/11] hw/ssi: Implement K230 SSI FIFO and standard PIO
 transfers
Date: Sun, 26 Jul 2026 20:28:21 +0800
Message-ID: <6fc734d599f433d0f4e3193be70fcf60615e031e.1785064313.git.flamboyant.h.01@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1785064312.git.flamboyant.h.01@gmail.com>
References: <cover.1785064312.git.flamboyant.h.01@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::431;
 envelope-from=flamboyant.h.01@gmail.com; helo=mail-pf1-x431.google.com
X-Spam_score_int: -17
X-Spam_score: -1.8
X-Spam_bar: -
X-Spam_report: (-1.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FREEMAIL_ENVFROM_END_DIGIT=0.25, FREEMAIL_FROM=0.001,
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

Implement FIFO-backed standard SPI transfers for all four TMOD modes.

Writes to DR while the TX FIFO is full are dropped, and frames wider
than the DFS field are truncated on read, per the K230 TRM. Disabling
the controller stops the serial engine but leaves queued frames in the
FIFOs.

Extend the qtest with an 8-bit loopback transfer, receive-only NDF
handling, FIFO status checks, and FIFO cleanup on controller disable.

Signed-off-by: Kangjie Huang <flamboyant.h.01@gmail.com>
---
 hw/ssi/k230_dw_ssi.c           | 160 ++++++++++++++++++++++++++++++++-
 include/hw/ssi/k230_dw_ssi.h   |  11 +++
 tests/qtest/k230-dw-ssi-test.c |  77 ++++++++++++++++
 3 files changed, 245 insertions(+), 3 deletions(-)

diff --git a/hw/ssi/k230_dw_ssi.c b/hw/ssi/k230_dw_ssi.c
index d0dcad4312..d7315f28ef 100644
--- a/hw/ssi/k230_dw_ssi.c
+++ b/hw/ssi/k230_dw_ssi.c
@@ -37,6 +37,7 @@
 #define K230_DW_SSI_AXIAWLEN_RESET          0x00000700
 #define K230_DW_SSI_AXIARLEN_RESET          0x00000700
 #define K230_DW_SSI_VERSION                 0x3130332a
+#define K230_DW_SSI_PIO_TX_BATCH            64
 
 REG32(CTRLR0, 0x000)
     FIELD(CTRLR0, DFS, 0, 5)
@@ -330,6 +331,8 @@ static void k230_dw_ssi_abort_transfer(K230DwSsiState *s)
     k230_dw_ssi_deselect(s);
     fifo32_reset(&s->tx_fifo);
     fifo32_reset(&s->rx_fifo);
+    s->phase = K230_DW_SSI_PHASE_IDLE;
+    s->remaining_frames = 0;
 }
 
 static uint32_t k230_dw_ssi_status(K230DwSsiState *s)
@@ -338,6 +341,7 @@ static uint32_t k230_dw_ssi_status(K230DwSsiState *s)
     uint32_t rx_used = fifo32_num_used(&s->rx_fifo);
     uint32_t sr = 0;
 
+    sr = FIELD_DP32(sr, SR, BUSY, s->phase != K230_DW_SSI_PHASE_IDLE);
     sr = FIELD_DP32(sr, SR, TFNF, tx_used < K230_DW_SSI_FIFO_CAPACITY);
     sr = FIELD_DP32(sr, SR, TFE, tx_used == 0);
     sr = FIELD_DP32(sr, SR, RFNE, rx_used != 0);
@@ -351,7 +355,7 @@ static void k230_dw_ssi_run_transfer(K230DwSsiState *s);
 
 static void k230_dw_ssi_push_tx(K230DwSsiState *s, uint32_t tx)
 {
-    if (!k230_dw_ssi_enabled(s) || s->active_cs < 0) {
+    if (!k230_dw_ssi_enabled(s)) {
         return;
     }
 
@@ -360,12 +364,139 @@ static void k230_dw_ssi_push_tx(K230DwSsiState *s, uint32_t tx)
     }
 
     fifo32_push(&s->tx_fifo, tx & k230_dw_ssi_frame_masked(s));
-    k230_dw_ssi_run_transfer(s);
+
+    if (s->phase != K230_DW_SSI_PHASE_STANDARD_TX_ONLY) {
+        k230_dw_ssi_run_transfer(s);
+    }
 }
 
+static uint32_t k230_dw_ssi_send_frame(K230DwSsiState *s,
+                                        uint32_t tx)
+{
+    uint32_t mask = k230_dw_ssi_frame_masked(s);
+    uint32_t rx;
+
+    tx &= mask;
+
+    if (FIELD_EX32(s->regs[R_CTRLR0], CTRLR0, SRL)) {
+        rx = tx;
+    } else {
+        rx = ssi_transfer(s->spi, tx);
+    }
+
+    return rx & mask;
+}
 
 static void k230_dw_ssi_run_transfer(K230DwSsiState *s)
 {
+    uint32_t spi_frf;
+    uint32_t tmod;
+
+    if (!k230_dw_ssi_enabled(s) || s->active_cs < 0) {
+        return;
+    }
+
+    spi_frf = FIELD_EX32(s->regs[R_CTRLR0], CTRLR0, SPI_FRF);
+    if (spi_frf != 0) {
+        return;
+    }
+
+    tmod = FIELD_EX32(s->regs[R_CTRLR0], CTRLR0, TMOD);
+
+    switch (tmod) {
+    case 0: /* TX_AND_RX */
+        while (!fifo32_is_empty(&s->tx_fifo)) {
+            uint32_t tx = fifo32_pop(&s->tx_fifo);
+            uint32_t rx = k230_dw_ssi_send_frame(s, tx);
+            if (!fifo32_is_full(&s->rx_fifo)) {
+                fifo32_push(&s->rx_fifo, rx);
+            }
+        }
+        break;
+    case 1: { /* TX_ONLY */
+        unsigned int frames = 0;
+
+        if (fifo32_is_empty(&s->tx_fifo)) {
+            s->phase = K230_DW_SSI_PHASE_IDLE;
+            break;
+        }
+
+        s->phase = K230_DW_SSI_PHASE_STANDARD_TX_ONLY;
+        while (!fifo32_is_empty(&s->tx_fifo) &&
+               frames < K230_DW_SSI_PIO_TX_BATCH) {
+            uint32_t tx = fifo32_pop(&s->tx_fifo);
+
+            k230_dw_ssi_send_frame(s, tx);
+            frames++;
+        }
+        if (fifo32_is_empty(&s->tx_fifo)) {
+            s->phase = K230_DW_SSI_PHASE_IDLE;
+        }
+        break;
+    }
+    case 2: /* RX_ONLY */
+        switch (s->phase) {
+        case K230_DW_SSI_PHASE_IDLE:
+            if (fifo32_is_empty(&s->tx_fifo)) {
+                break;
+            }
+            fifo32_pop(&s->tx_fifo);
+            s->phase = K230_DW_SSI_PHASE_RX_ONLY;
+            s->remaining_frames = FIELD_EX32(s->regs[R_CTRLR1], CTRLR1,
+                                              NDF) + 1;
+            /* Fall through. */
+        case K230_DW_SSI_PHASE_RX_ONLY:
+            while (!fifo32_is_full(&s->rx_fifo) &&
+                   s->remaining_frames > 0) {
+                uint32_t rx = k230_dw_ssi_send_frame(s, 0x00);
+
+                fifo32_push(&s->rx_fifo, rx);
+                s->remaining_frames--;
+            }
+            if (s->remaining_frames == 0) {
+                s->phase = K230_DW_SSI_PHASE_IDLE;
+            }
+            break;
+        }
+        break;
+    case 3: /* EEPROM_READ */
+        switch (s->phase) {
+        case K230_DW_SSI_PHASE_IDLE:
+            if (fifo32_is_empty(&s->tx_fifo)) {
+                break;
+            }
+            s->phase = K230_DW_SSI_PHASE_EEPROM_COMMAND;
+            /* Fall through. */
+        case K230_DW_SSI_PHASE_EEPROM_COMMAND:
+            if (fifo32_is_empty(&s->tx_fifo)) {
+                break;
+            }
+            while (!fifo32_is_empty(&s->tx_fifo)) {
+                uint32_t tx = fifo32_pop(&s->tx_fifo);
+
+                k230_dw_ssi_send_frame(s, tx);
+            }
+            s->phase = K230_DW_SSI_PHASE_EEPROM_DATA;
+            s->remaining_frames = FIELD_EX32(s->regs[R_CTRLR1], CTRLR1,
+                                              NDF) + 1;
+            /* Fall through. */
+        case K230_DW_SSI_PHASE_EEPROM_DATA:
+            while (!fifo32_is_full(&s->rx_fifo) &&
+                   s->remaining_frames > 0) {
+                uint32_t rx = k230_dw_ssi_send_frame(s, 0x00);
+
+                fifo32_push(&s->rx_fifo, rx);
+                s->remaining_frames--;
+            }
+            if (s->remaining_frames == 0) {
+                s->phase = K230_DW_SSI_PHASE_IDLE;
+            }
+            break;
+        }
+        break;
+    default:
+        g_assert_not_reached();
+    }
 }
 
 
@@ -419,6 +550,8 @@ static uint64_t k230_dw_ssi_read(void *opaque, hwaddr addr, unsigned int size)
         if (!fifo32_is_empty(&s->rx_fifo)) {
             value = fifo32_pop(&s->rx_fifo) & k230_dw_ssi_frame_masked(s);
         }
+
+        k230_dw_ssi_run_transfer(s);
         return value;
     }
 
@@ -457,12 +590,18 @@ static uint64_t k230_dw_ssi_read(void *opaque, hwaddr addr, unsigned int size)
         break;
     case A_TXFLR:
         value = fifo32_num_used(&s->tx_fifo);
+        if (s->phase == K230_DW_SSI_PHASE_STANDARD_TX_ONLY) {
+            k230_dw_ssi_run_transfer(s);
+        }
         break;
     case A_RXFLR:
         value = fifo32_num_used(&s->rx_fifo);
         break;
     case A_SR:
         value = k230_dw_ssi_status(s);
+        if (s->phase == K230_DW_SSI_PHASE_STANDARD_TX_ONLY) {
+            k230_dw_ssi_run_transfer(s);
+        }
         break;
     case A_ISR:
     case A_RISR:
@@ -538,15 +677,26 @@ static void k230_dw_ssi_write(void *opaque, hwaddr addr,
         }
 
         k230_dw_ssi_update_cs(s);
+        k230_dw_ssi_run_transfer(s);
         break;
     }
     case A_MWCR:
         k230_dw_ssi_write_masked(s, R_MWCR, value,
                                  K230_DW_SSI_MWCR_WRITABLE_MASK);
         break;
-    case A_SER:
+    case A_SER: {
+        uint32_t old_ser = s->regs[R_SER];
+
         s->regs[R_SER] = value & MAKE_64BIT_MASK(0, s->num_cs);
+        if (old_ser && !s->regs[R_SER]) {
+            k230_dw_ssi_abort_transfer(s);
+            break;
+        }
+
+        k230_dw_ssi_update_cs(s);
+        k230_dw_ssi_run_transfer(s);
         break;
+    }
     case A_BAUDR:
         k230_dw_ssi_write_masked(s, R_BAUDR, value,
                                  K230_DW_SSI_BAUDR_WRITABLE_MASK);
@@ -679,6 +829,8 @@ static void k230_dw_ssi_enter_reset(Object *obj, ResetType type)
     memset(s->regs, 0, sizeof(s->regs));
     fifo32_reset(&s->tx_fifo);
     fifo32_reset(&s->rx_fifo);
+    s->phase = K230_DW_SSI_PHASE_IDLE;
+    s->remaining_frames = 0;
 
     s->regs[R_CTRLR0] = K230_DW_SSI_CTRLR0_RESET;
     s->regs[R_SR] = K230_DW_SSI_SR_RESET;
@@ -710,6 +862,8 @@ static const VMStateDescription vmstate_k230_dw_ssi = {
         VMSTATE_UINT32_ARRAY(regs, K230DwSsiState, K230_DW_SSI_NUM_REGS),
         VMSTATE_FIFO32(tx_fifo, K230DwSsiState),
         VMSTATE_FIFO32(rx_fifo, K230DwSsiState),
+        VMSTATE_UINT32(phase, K230DwSsiState),
+        VMSTATE_UINT32(remaining_frames, K230DwSsiState),
         VMSTATE_INT32(active_cs, K230DwSsiState),
         VMSTATE_END_OF_LIST()
     },
diff --git a/include/hw/ssi/k230_dw_ssi.h b/include/hw/ssi/k230_dw_ssi.h
index 953f6cc0e5..993cb19745 100644
--- a/include/hw/ssi/k230_dw_ssi.h
+++ b/include/hw/ssi/k230_dw_ssi.h
@@ -31,6 +31,14 @@ OBJECT_DECLARE_SIMPLE_TYPE(K230DwSsiState, K230_DW_SSI)
 #define K230_DW_SSI_NUM_REGS \
     (K230_DW_SSI_REGS_SIZE / sizeof(uint32_t))
 
+typedef enum K230DwSsiPhase {
+    K230_DW_SSI_PHASE_IDLE,
+    K230_DW_SSI_PHASE_STANDARD_TX_ONLY,
+    K230_DW_SSI_PHASE_RX_ONLY,
+    K230_DW_SSI_PHASE_EEPROM_COMMAND,
+    K230_DW_SSI_PHASE_EEPROM_DATA,
+} K230DwSsiPhase;
+
 struct K230DwSsiState {
     SysBusDevice parent_obj;
 
@@ -42,6 +50,9 @@ struct K230DwSsiState {
     Fifo32 rx_fifo;
     uint32_t regs[K230_DW_SSI_NUM_REGS];
 
+    uint32_t phase;
+    uint32_t remaining_frames;
+
     uint32_t num_cs;
     uint32_t max_lines;
     int active_cs;
diff --git a/tests/qtest/k230-dw-ssi-test.c b/tests/qtest/k230-dw-ssi-test.c
index dcd6cb1d6e..a62b1a7ff6 100644
--- a/tests/qtest/k230-dw-ssi-test.c
+++ b/tests/qtest/k230-dw-ssi-test.c
@@ -28,6 +28,7 @@
 #define K230_SSI_DMACR           0x04c
 #define K230_SSI_IDR             0x058
 #define K230_SSI_VERSION_ID      0x05c
+#define K230_SSI_DR0             0x060
 #define K230_SSI_SPI_CTRLR0      0x0f4
 #define K230_SSI_XIP_MODE_BITS   0x0fc
 #define K230_SSI_XIP_INCR_INST   0x100
@@ -50,8 +51,11 @@
 
 #define K230_SSI_CTRLR0_DFS_MASK        0x1fU
 #define K230_SSI_CTRLR0_TMOD_SHIFT      10
+#define K230_SSI_CTRLR0_SRL             BIT(13)
 
 #define K230_SSI_TMOD_TR                0
+#define K230_SSI_TMOD_TO                1
+#define K230_SSI_TMOD_RO                2
 #define K230_SSI_TMOD_EEPROM_READ       3
 
 #define K230_SSI_SR_BUSY                BIT(0)
@@ -62,6 +66,8 @@
 #define K230_SSI_INT_AXIE               BIT(8)
 #define K230_SSI_INT_DONE               BIT(11)
 
+#define K230_SSI_FIFO_DEPTH             256
+
 typedef struct K230SsiInstance {
     uint64_t base;
     uint32_t num_cs;
@@ -130,6 +136,45 @@ static void k230_ssi_enable_cs(QTestState *qts, uint64_t base, uint32_t ser)
     k230_ssi_writel(qts, base, K230_SSI_SSIENR, 1);
 }
 
+static void k230_ssi_write_frame(QTestState *qts, uint64_t base,
+                                 uint32_t value)
+{
+    k230_ssi_writel(qts, base, K230_SSI_DR0, value);
+}
+
+static uint32_t k230_ssi_read_frame(QTestState *qts, uint64_t base)
+{
+    return k230_ssi_readl(qts, base, K230_SSI_DR0);
+}
+
+static void k230_ssi_wait_mask(QTestState *qts, uint64_t base,
+                               uint32_t offset, uint32_t mask,
+                               uint32_t expected)
+{
+    for (int i = 0; i < 1000; i++) {
+        uint32_t value = k230_ssi_readl(qts, base, offset);
+
+        if ((value & mask) == expected) {
+            return;
+        }
+        qtest_clock_step(qts, 1000);
+    }
+
+    g_assert_cmphex(k230_ssi_readl(qts, base, offset) & mask,
+                    ==, expected);
+}
+
+static void configure_loopback(QTestState *qts, uint32_t tmod,
+                               uint32_t ndf)
+{
+    uint32_t ctrlr0;
+
+    k230_ssi_configure(qts, K230_SPI1_BASE, tmod, 8, ndf);
+    ctrlr0 = k230_ssi_readl(qts, K230_SPI1_BASE, K230_SSI_CTRLR0);
+    k230_ssi_writel(qts, K230_SPI1_BASE, K230_SSI_CTRLR0,
+                    ctrlr0 | K230_SSI_CTRLR0_SRL);
+}
+
 static void test_register_contract(void)
 {
     QTestState *qts = k230_ssi_start();
@@ -169,10 +214,42 @@ static void test_register_contract(void)
     qtest_quit(qts);
 }
 
+static void test_pio_data_path(void)
+{
+    QTestState *qts = k230_ssi_start();
+    uint32_t status;
+
+    configure_loopback(qts, K230_SSI_TMOD_TR, 0);
+    k230_ssi_enable_cs(qts, K230_SPI1_BASE, BIT(0));
+    k230_ssi_write_frame(qts, K230_SPI1_BASE, 0xa5);
+    k230_ssi_wait_mask(qts, K230_SPI1_BASE, K230_SSI_SR,
+                       K230_SSI_SR_RFNE, K230_SSI_SR_RFNE);
+    g_assert_cmphex(k230_ssi_read_frame(qts, K230_SPI1_BASE), ==, 0xa5);
+
+    configure_loopback(qts, K230_SSI_TMOD_RO, 3);
+    k230_ssi_enable_cs(qts, K230_SPI1_BASE, BIT(0));
+    k230_ssi_write_frame(qts, K230_SPI1_BASE, 0);
+    k230_ssi_wait_mask(qts, K230_SPI1_BASE, K230_SSI_RXFLR,
+                       UINT32_MAX, 4);
+    for (int i = 0; i < 4; i++) {
+        g_assert_cmphex(k230_ssi_read_frame(qts, K230_SPI1_BASE), ==, 0);
+    }
+
+    k230_ssi_disable(qts, K230_SPI1_BASE);
+    status = k230_ssi_readl(qts, K230_SPI1_BASE, K230_SSI_SR);
+    g_assert_cmpuint(k230_ssi_readl(qts, K230_SPI1_BASE, K230_SSI_RXFLR),
+                     ==, 0);
+    g_assert_cmphex(status & (K230_SSI_SR_BUSY | K230_SSI_SR_TFNF |
+                              K230_SSI_SR_TFE | K230_SSI_SR_RFNE),
+                    ==, K230_SSI_SR_TFNF | K230_SSI_SR_TFE);
+    qtest_quit(qts);
+}
+
 int main(int argc, char **argv)
 {
     g_test_init(&argc, &argv, NULL);
 
     qtest_add_func("/k230-dw-ssi/register-contract", test_register_contract);
+    qtest_add_func("/k230-dw-ssi/pio-data-path", test_pio_data_path);
     return g_test_run();
 }
-- 
2.43.0


