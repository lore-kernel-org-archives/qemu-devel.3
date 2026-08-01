Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3CAC8C55173
	for <qemu-devel@archiver.kernel.org>; Sat,  1 Aug 2026 19:31:36 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wqFPi-0002sq-42; Sat, 01 Aug 2026 15:30:30 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <flamboyant.h.01@gmail.com>)
 id 1wqFPg-0002sQ-FO
 for qemu-devel@nongnu.org; Sat, 01 Aug 2026 15:30:28 -0400
Received: from mail-pj1-x1029.google.com ([2607:f8b0:4864:20::1029])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <flamboyant.h.01@gmail.com>)
 id 1wqFPe-0002I8-9l
 for qemu-devel@nongnu.org; Sat, 01 Aug 2026 15:30:28 -0400
Received: by mail-pj1-x1029.google.com with SMTP id
 98e67ed59e1d1-382ef647e20so2299093a91.1
 for <qemu-devel@nongnu.org>; Sat, 01 Aug 2026 12:30:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1785612625; x=1786217425; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=rictVP0n1BHRIjGHJIrYt/EJeZRqsVqeFgYRbXHONws=;
 b=bFMF0mS4ghSkvXat1MTYTWL1JikSgMPbtm7SIGRGO7rQm6iw6ad9ZyI8RH7ilzkg2m
 AtyDcTVIJUlnS73iV7v4Ma+dt1HI0QsANaixaQYSbUPh3Vx98LVfsFnP4YMYIn2fsxh+
 LtYW+ACgFoCC6AI2hrK3CVsIVPtRySHD/Z9/A7fLv8kDUdbfNSBSnWCZBf8Lx9fpwELj
 z/tDxVvdvurxG0IJrLbPaqwELQ4Q2ITba/ZyxVBDa5FG1IN0s94r4p6qabzKNYOfBOeZ
 n/OIPdZ6MV/BR0deqpEfC0tP25WaDq/uijnZYaVdseUb8eTt/wStjN4uRKoDo8fXBdLi
 QC9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1785612625; x=1786217425;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=rictVP0n1BHRIjGHJIrYt/EJeZRqsVqeFgYRbXHONws=;
 b=L3/ftjkUqvusFp3qYMdSM0B4AxJj8VZ+bP3Hx5IBrL0RVh12HKQYU8flzFyISPC+sd
 1PvStxMRa0Na8ejnuiwlAcQtQm2mZvihQDePW8YGvHwhFoLo7rka/2jquqqd43r/ibYB
 lhpw1mbs9EL1TxwwRoHXii67YXzW+4ZqJqV8gI2hfuqC42YGZYuT2rDQkwMcCR4do54z
 FuQJt5c/sl4WsYw8JbS9DbuNScn1C326VHfwWhr3OaXx/zUJmOVCvBEhkTZFfSheTitC
 ZNg3Gv+ROaI5FDLazXUkDfPY1en1y8czGEw8wU5SlzUnULwMncVevmFepUKtTobE9A0v
 TeSQ==
X-Gm-Message-State: AOJu0Yx3ucInPV/rMXeCcScGvlzt8JOwLHZBgXqeVsCXz6JY5I50nX23
 Wj+jQDZ5LiAUEOkpcVZWllFXNr6FPpwvyr4ui0+i3UuWkl6dOCxxfHCsoQ7ab35OeG/8sA==
X-Gm-Gg: AR+sD10wy7Ww97gNDwz/Mv7DC+EojabKypGY+ei4fjgUMqqQx9ZXj6DEJ3qjSOTv3Bu
 9dGhRxGNA1hZR3h80vc0nfHDVivS7jCBiJdWTu9fI7qDOqr5l8ZiW6wuVSLucyRQeI3Hlnmrtlc
 lWacAV54WVecHGH6lQ2K5ORoE0vjaKlT1UzO5/zxzVz74ikNwtVnLNj4yUiLZRaor3JvwlydMFv
 z5QS5cQbH+UUsH/f1zoFHo09wKYM97PJ7jnIIXyECVNG7jVqJc7drxfstKYNKM5yISFFwZOKYGq
 YPFwaYeeBxKYKqTm/fiCnz96kUyjoHDTVF8/afXz8Kuzukhj14MARUq4TL8uRHD0c62xYKi0lpy
 7w0iQpMpsSSdn7z6fyg2DAl0XikL/VCzIqYfI1aXOGfUeEYo2bhbHRy71H7wnh4DKVrYlpjv+Op
 7qGw3ANLrPdF7VGHwMgq3RzqeT+WZ1B34SZs2QW4Pb83AbJaLJeo1V1gb/9I0n3RmNrVKil3oV+
 Hiyuf2uG2ZUrsoNdr7W
X-Received: by 2002:a17:90b:3851:b0:38e:dc4:3f64 with SMTP id
 98e67ed59e1d1-38fbc52da42mr3876668a91.38.1785612624855; 
 Sat, 01 Aug 2026 12:30:24 -0700 (PDT)
Received: from localhost.localdomain ([111.198.227.173])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-38fb2bac654sm2148766a91.10.2026.08.01.12.30.20
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 01 Aug 2026 12:30:24 -0700 (PDT)
From: Kangjie Huang <flamboyant.h.01@gmail.com>
To: qemu-devel@nongnu.org
Cc: qemu-riscv@nongnu.org, Bin Meng <bmeng.cn@gmail.com>,
 Chao Liu <chao.liu@processmission.com>,
 Alistair Francis <alistair.francis@wdc.com>,
 Alistair Francis <alistair@alistair23.me>,
 Palmer Dabbelt <palmer@dabbelt.com>, Weiwei Li <liwei1518@gmail.com>,
 Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>,
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Fabiano Rosas <farosas@suse.de>,
 Laurent Vivier <lvivier@redhat.com>,
 Kangjie Huang <flamboyant.h.01@gmail.com>
Subject: [PATCH v2 2/5] hw/ssi: Add DesignWare SSI standard interrupt support
Date: Sun,  2 Aug 2026 03:28:45 +0800
Message-ID: <20260801192848.30606-3-flamboyant.h.01@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260801192848.30606-1-flamboyant.h.01@gmail.com>
References: <20260801192848.30606-1-flamboyant.h.01@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::1029;
 envelope-from=flamboyant.h.01@gmail.com; helo=mail-pj1-x1029.google.com
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

Implement raw and masked SSI interrupt status, threshold interrupts, and
the documented read-clear registers.

TXE and RXF are derived from FIFO levels. TXO, RXO, and RXU are latched
causes. Expose the nine physical interrupt outputs used by the K230 SSI
integration.

TXU, DONE, and AXIE depend on transfer engines outside the Standard PIO
scope and remain deasserted in this model.

Signed-off-by: Kangjie Huang <flamboyant.h.01@gmail.com>
---
 hw/ssi/dw_ssi.c         | 129 +++++++++++++++++++++++++++++++++++++++-
 include/hw/ssi/dw_ssi.h |  18 +++++-
 2 files changed, 145 insertions(+), 2 deletions(-)

diff --git a/hw/ssi/dw_ssi.c b/hw/ssi/dw_ssi.c
index f9f0e23730..57bca1687b 100644
--- a/hw/ssi/dw_ssi.c
+++ b/hw/ssi/dw_ssi.c
@@ -6,7 +6,7 @@
  * SPDX-License-Identifier: GPL-2.0-or-later
  *
  * Emulates the DesignWare SSI controller in Standard SPI mode,
- * covering the PIO/FIFO data path and chip selects.
+ * covering the PIO/FIFO data path, interrupt outputs and chip selects.
  */
 
 #include "qemu/osdep.h"
@@ -26,6 +26,9 @@
 #define DW_SSI_IDR_RESET               0xa1b2c3d5
 #define DW_SSI_VERSION                 0x3130332a
 #define DW_SSI_PIO_TX_BATCH            64
+#define DW_SSI_IRQ_VALID_MASK          0x000009bf
+#define DW_SSI_IMPLEMENTED_LATCHED_IRQ_MASK \
+    (R_RISR_TXOIR_MASK | R_RISR_RXOIR_MASK | R_RISR_RXUIR_MASK)
 
 enum {
     DW_SSI_TMOD_TR,
@@ -217,6 +220,22 @@ REG32(XIP_WRITE_CTRL, 0x148)
 #define DW_SSI_RX_SAMPLE_DELAY_WRITABLE_MASK \
     (R_RX_SAMPLE_DELAY_RSD_MASK | R_RX_SAMPLE_DELAY_SE_MASK)
 
+/*
+ * TXU, DONE and AXIE depend on transfer engines outside Standard PIO.
+ * Their physical outputs are exposed but remain deasserted in this model.
+ */
+static const uint32_t dw_ssi_irq_status_mask[DW_SSI_IRQ_COUNT] = {
+    [DW_SSI_IRQ_TXE] = R_RISR_TXEIR_MASK,
+    [DW_SSI_IRQ_TXO] = R_RISR_TXOIR_MASK,
+    [DW_SSI_IRQ_RXF] = R_RISR_RXFIR_MASK,
+    [DW_SSI_IRQ_RXO] = R_RISR_RXOIR_MASK,
+    [DW_SSI_IRQ_TXU] = R_RISR_TXUIR_MASK,
+    [DW_SSI_IRQ_RXU] = R_RISR_RXUIR_MASK,
+    [DW_SSI_IRQ_MST] = R_RISR_MSTIR_MASK,
+    [DW_SSI_IRQ_DONE] = R_RISR_DONER_MASK,
+    [DW_SSI_IRQ_AXIE] = R_RISR_AXIER_MASK,
+};
+
 static bool dw_ssi_validate_config(DwSsiState *s, Error **errp)
 {
     DeviceState *dev = DEVICE(s);
@@ -253,6 +272,45 @@ static void dw_ssi_write_masked(DwSsiState *s, unsigned int reg,
     s->regs[reg] = (s->regs[reg] & ~mask) | (value & mask);
 }
 
+static uint32_t dw_ssi_irq_raw_status(DwSsiState *s)
+{
+    uint32_t status = s->irq_latched;
+    uint32_t tx_used = fifo32_num_used(&s->tx_fifo);
+    uint32_t rx_used = fifo32_num_used(&s->rx_fifo);
+    uint32_t tx_threshold =
+        FIELD_EX32(s->regs[R_TXFTLR], TXFTLR, TFT);
+    uint32_t rx_threshold =
+        FIELD_EX32(s->regs[R_RXFTLR], RXFTLR, RFT);
+
+    if (tx_used <= tx_threshold) {
+        status |= R_RISR_TXEIR_MASK;
+    }
+    if (rx_used > rx_threshold) {
+        status |= R_RISR_RXFIR_MASK;
+    }
+    return status & DW_SSI_IRQ_VALID_MASK;
+}
+
+static void dw_ssi_update_irq(DwSsiState *s)
+{
+    uint32_t status = dw_ssi_irq_raw_status(s) &
+                      s->regs[R_IMR] & DW_SSI_IRQ_VALID_MASK;
+
+    for (int i = 0; i < DW_SSI_IRQ_COUNT; i++) {
+        qemu_set_irq(s->irqs[i], !!(status & dw_ssi_irq_status_mask[i]));
+    }
+}
+
+static uint32_t dw_ssi_irq_read_clear(DwSsiState *s,
+                                            uint32_t clear_mask)
+{
+    uint32_t active = s->irq_latched & clear_mask;
+
+    s->irq_latched &= ~clear_mask;
+    dw_ssi_update_irq(s);
+    return !!active;
+}
+
 static uint32_t dw_ssi_frame_masked(DwSsiState *s)
 {
     unsigned int bits = FIELD_EX32(s->regs[R_CTRLR0], CTRLR0, DFS) + 1;
@@ -321,6 +379,7 @@ static void dw_ssi_abort_transfer(DwSsiState *s)
     fifo32_reset(&s->rx_fifo);
     s->phase = DW_SSI_PHASE_IDLE;
     s->remaining_frames = 0;
+    dw_ssi_update_irq(s);
 }
 
 static uint32_t dw_ssi_status(DwSsiState *s)
@@ -348,6 +407,8 @@ static void dw_ssi_push_tx(DwSsiState *s, uint32_t tx)
     }
 
     if (fifo32_is_full(&s->tx_fifo)) {
+        s->irq_latched |= R_RISR_TXOIR_MASK;
+        dw_ssi_update_irq(s);
         return;
     }
 
@@ -356,6 +417,7 @@ static void dw_ssi_push_tx(DwSsiState *s, uint32_t tx)
     if (s->phase != DW_SSI_PHASE_STANDARD_TX_ONLY) {
         dw_ssi_run_transfer(s);
     }
+    dw_ssi_update_irq(s);
 }
 
 static uint32_t dw_ssi_send_frame(DwSsiState *s,
@@ -415,6 +477,7 @@ static void dw_ssi_run_transfer(DwSsiState *s)
             if (!fifo32_is_full(&s->rx_fifo)) {
                 fifo32_push(&s->rx_fifo, rx);
             } else {
+                s->irq_latched |= R_RISR_RXOIR_MASK;
                 qemu_log_mask(LOG_GUEST_ERROR,
                               "%s: RX FIFO full, dropping frame\n",
                               DEVICE(s)->canonical_path);
@@ -602,9 +665,11 @@ static uint64_t dw_ssi_read(void *opaque, hwaddr addr, unsigned int size)
             value = fifo32_pop(&s->rx_fifo) & dw_ssi_frame_masked(s);
         } else {
             value = 0;
+            s->irq_latched |= R_RISR_RXUIR_MASK;
         }
 
         dw_ssi_run_transfer(s);
+        dw_ssi_update_irq(s);
         return value;
     }
 
@@ -634,6 +699,7 @@ static uint64_t dw_ssi_read(void *opaque, hwaddr addr, unsigned int size)
         value = fifo32_num_used(&s->tx_fifo);
         if (s->phase == DW_SSI_PHASE_STANDARD_TX_ONLY) {
             dw_ssi_run_transfer(s);
+            dw_ssi_update_irq(s);
         }
         break;
     case A_RXFLR:
@@ -643,8 +709,35 @@ static uint64_t dw_ssi_read(void *opaque, hwaddr addr, unsigned int size)
         value = dw_ssi_status(s);
         if (s->phase == DW_SSI_PHASE_STANDARD_TX_ONLY) {
             dw_ssi_run_transfer(s);
+            dw_ssi_update_irq(s);
         }
         break;
+    case A_ISR:
+        value = dw_ssi_irq_raw_status(s) & s->regs[R_IMR] &
+                DW_SSI_IRQ_VALID_MASK;
+        break;
+    case A_RISR:
+        value = dw_ssi_irq_raw_status(s);
+        break;
+    case A_TXEICR:
+        value = dw_ssi_irq_read_clear(
+            s, R_RISR_TXOIR_MASK | R_RISR_TXUIR_MASK);
+        break;
+    case A_RXOICR:
+        value = dw_ssi_irq_read_clear(s, R_RISR_RXOIR_MASK);
+        break;
+    case A_RXUICR:
+        value = dw_ssi_irq_read_clear(s, R_RISR_RXUIR_MASK);
+        break;
+    case A_MSTICR:
+        value = dw_ssi_irq_read_clear(s, R_RISR_MSTIR_MASK);
+        break;
+    case A_ICR:
+        value = dw_ssi_irq_read_clear(
+            s, R_RISR_TXOIR_MASK | R_RISR_RXUIR_MASK |
+               R_RISR_RXOIR_MASK | R_RISR_MSTIR_MASK);
+        break;
+
     default:
         if (addr >= DW_SSI_REGS_SIZE || (addr & 0x3) != 0) {
             qemu_log_mask(LOG_GUEST_ERROR,
@@ -707,6 +800,7 @@ static void dw_ssi_write(void *opaque, hwaddr addr,
 
         dw_ssi_update_cs(s);
         dw_ssi_run_transfer(s);
+        dw_ssi_update_irq(s);
         break;
     }
     case A_MWCR:
@@ -730,6 +824,7 @@ static void dw_ssi_write(void *opaque, hwaddr addr,
 
         dw_ssi_update_cs(s);
         dw_ssi_run_transfer(s);
+        dw_ssi_update_irq(s);
         break;
     }
     case A_BAUDR:
@@ -749,6 +844,7 @@ static void dw_ssi_write(void *opaque, hwaddr addr,
         dw_ssi_write_masked(s, R_TXFTLR, value,
                                  DW_SSI_TXFTLR_WRITABLE_MASK);
         dw_ssi_run_transfer(s);
+        dw_ssi_update_irq(s);
         break;
     case A_RXFTLR:
         if (!dw_ssi_fifo_threshold_valid(
@@ -760,6 +856,7 @@ static void dw_ssi_write(void *opaque, hwaddr addr,
         }
         dw_ssi_write_masked(s, R_RXFTLR, value,
                                  DW_SSI_RXFTLR_WRITABLE_MASK);
+        dw_ssi_update_irq(s);
         break;
     case A_TXFLR:
     case A_RXFLR:
@@ -768,6 +865,16 @@ static void dw_ssi_write(void *opaque, hwaddr addr,
     case A_IMR:
         dw_ssi_write_masked(s, R_IMR, value,
                                  DW_SSI_IMR_WRITABLE_MASK);
+        dw_ssi_update_irq(s);
+        break;
+    case A_ISR:
+    case A_RISR:
+        break;
+    case A_TXEICR:
+    case A_RXOICR:
+    case A_RXUICR:
+    case A_MSTICR:
+    case A_ICR:
         break;
     case A_IDR:
     case A_SSIC_VERSION_ID:
@@ -807,12 +914,15 @@ static void dw_ssi_enter_reset(Object *obj, ResetType type)
     fifo32_reset(&s->rx_fifo);
     s->phase = DW_SSI_PHASE_IDLE;
     s->remaining_frames = 0;
+    s->irq_latched = 0;
 
     s->regs[R_CTRLR0] = DW_SSI_CTRLR0_RESET;
     s->regs[R_SR] = DW_SSI_SR_RESET;
     s->regs[R_IMR] = s->cfg.imr_reset & DW_SSI_IMR_WRITABLE_MASK;
     s->regs[R_IDR] = DW_SSI_IDR_RESET;
     s->regs[R_SSIC_VERSION_ID] = DW_SSI_VERSION;
+
+    dw_ssi_update_irq(s);
 }
 
 static void dw_ssi_hold_reset(Object *obj, ResetType type)
@@ -827,6 +937,13 @@ static void dw_ssi_hold_reset(Object *obj, ResetType type)
     }
 }
 
+static void dw_ssi_exit_reset(Object *obj, ResetType type)
+{
+    DwSsiState *s = DW_SSI(obj);
+
+    dw_ssi_update_irq(s);
+}
+
 static int dw_ssi_post_load(void *opaque, int version_id)
 {
     DwSsiState *s = opaque;
@@ -835,6 +952,9 @@ static int dw_ssi_post_load(void *opaque, int version_id)
     if (s->active_cs < -1 || s->active_cs >= (int)s->cfg.num_cs) {
         return -EINVAL;
     }
+    if (s->irq_latched & ~DW_SSI_IMPLEMENTED_LATCHED_IRQ_MASK) {
+        return -EINVAL;
+    }
     if (s->phase > DW_SSI_PHASE_STANDARD_TR) {
         return -EINVAL;
     }
@@ -859,6 +979,7 @@ static int dw_ssi_post_load(void *opaque, int version_id)
         qemu_irq_lower(s->cs_lines[s->active_cs]);
     }
 
+    dw_ssi_update_irq(s);
     return 0;
 }
 
@@ -874,6 +995,7 @@ static const VMStateDescription vmstate_dw_ssi = {
         VMSTATE_UINT32_ARRAY(regs, DwSsiState, DW_SSI_NUM_REGS),
         VMSTATE_FIFO32(tx_fifo, DwSsiState),
         VMSTATE_FIFO32(rx_fifo, DwSsiState),
+        VMSTATE_UINT32(irq_latched, DwSsiState),
         VMSTATE_UINT32(phase, DwSsiState),
         VMSTATE_UINT32(remaining_frames, DwSsiState),
         VMSTATE_INT32(active_cs, DwSsiState),
@@ -893,6 +1015,10 @@ static void dw_ssi_init(Object *obj)
                           TYPE_DW_SSI, DW_SSI_MMIO_SIZE);
     sysbus_init_mmio(sbd, &s->mmio);
 
+    for (int i = 0; i < DW_SSI_IRQ_COUNT; i++) {
+        sysbus_init_irq(sbd, &s->irqs[i]);
+    }
+
     s->active_cs = -1;
 }
 
@@ -937,6 +1063,7 @@ static void dw_ssi_class_init(ObjectClass *klass, const void *data)
     device_class_set_props(dc, dw_ssi_properties);
     rc->phases.enter = dw_ssi_enter_reset;
     rc->phases.hold = dw_ssi_hold_reset;
+    rc->phases.exit = dw_ssi_exit_reset;
 }
 
 static const TypeInfo dw_ssi_info = {
diff --git a/include/hw/ssi/dw_ssi.h b/include/hw/ssi/dw_ssi.h
index a74e906ef8..4d4e1fa4c8 100644
--- a/include/hw/ssi/dw_ssi.h
+++ b/include/hw/ssi/dw_ssi.h
@@ -6,7 +6,7 @@
  * SPDX-License-Identifier: GPL-2.0-or-later
  *
  * Emulates the DesignWare SSI controller in Standard SPI mode,
- * covering the PIO/FIFO data path and chip selects.
+ * covering the PIO/FIFO data path, interrupt outputs and chip selects.
  */
 
 #ifndef HW_SSI_DW_SSI_H
@@ -25,6 +25,20 @@ OBJECT_DECLARE_SIMPLE_TYPE(DwSsiState, DW_SSI)
 #define DW_SSI_NUM_REGS \
     (DW_SSI_REGS_SIZE / sizeof(uint32_t))
 
+/* SSI GPIO output ordering differs from RISR/ISR bit ordering. */
+typedef enum DwSsiIrq {
+    DW_SSI_IRQ_TXE,
+    DW_SSI_IRQ_TXO,
+    DW_SSI_IRQ_RXF,
+    DW_SSI_IRQ_RXO,
+    DW_SSI_IRQ_TXU,
+    DW_SSI_IRQ_RXU,
+    DW_SSI_IRQ_MST,
+    DW_SSI_IRQ_DONE,
+    DW_SSI_IRQ_AXIE,
+    DW_SSI_IRQ_COUNT,
+} DwSsiIrq;
+
 typedef enum DwSsiPhase {
     DW_SSI_PHASE_IDLE,
     DW_SSI_PHASE_STANDARD_TX_ONLY,
@@ -47,6 +61,7 @@ struct DwSsiState {
     SSIBus *spi;
 
     qemu_irq *cs_lines;
+    qemu_irq irqs[DW_SSI_IRQ_COUNT];
 
     Fifo32 tx_fifo;
     Fifo32 rx_fifo;
@@ -54,6 +69,7 @@ struct DwSsiState {
 
     DwSsiConfig cfg;
 
+    uint32_t irq_latched;
     uint32_t phase;
     uint32_t remaining_frames;
 
-- 
2.43.0


