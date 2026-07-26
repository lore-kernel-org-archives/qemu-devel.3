Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D6F98C531C9
	for <qemu-devel@archiver.kernel.org>; Sun, 26 Jul 2026 12:31:18 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wnxz5-0001Nq-Eq; Sun, 26 Jul 2026 08:29:35 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <flamboyant.h.01@gmail.com>)
 id 1wnxyv-0001JW-90
 for qemu-devel@nongnu.org; Sun, 26 Jul 2026 08:29:27 -0400
Received: from mail-pf1-x42c.google.com ([2607:f8b0:4864:20::42c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <flamboyant.h.01@gmail.com>)
 id 1wnxys-0003IN-9O
 for qemu-devel@nongnu.org; Sun, 26 Jul 2026 08:29:24 -0400
Received: by mail-pf1-x42c.google.com with SMTP id
 d2e1a72fcca58-84847482584so1290940b3a.0
 for <qemu-devel@nongnu.org>; Sun, 26 Jul 2026 05:29:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1785068960; x=1785673760; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=1EUjSvAnMqQXZ+QbNsMcHRIM+RX+l2GUa0m0wryPHcA=;
 b=sjPVjxu3ARcUsz8Af+TreCzTGKGfm1/ZP6YdxuM7E2yDb8WTbf9ItqfVAui/jEuH+A
 jIIPLTKa1GQZsdNv/OGIXyZK3W9h8iFdwmDzXvUqXDd/y6LIUBoXzjO0sAbnpob6BinP
 FElnKIasSjMGImv0yFVsgmFf55GL/RuNGLbNb/0b6sVERd6TiwqJ9XsiycQlO8OP101O
 qzCG4/lgECDbHim90LJ040egGILlpaan1pl0znuAFBtqb1EKe5DI0ccmAuAlV5ciccaA
 1TMmI0C8lRwqy+zDrQ0HzKSRxTrGEkfQUxywmI2KBBA6o4+XbHejKjgGE4qE327Wd8IL
 NXfA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1785068960; x=1785673760;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=1EUjSvAnMqQXZ+QbNsMcHRIM+RX+l2GUa0m0wryPHcA=;
 b=UfPh/9SImkElapdatgQVeQ5/0TTjUlXsdKXGIDjrRUzKR8nqhxaXPuiwRaHnwGubd5
 u/YKymArzZp9lFENpmLB78GHMo+J4ce8/2JdFdUP4hzRh9HxkUx/+lgzyLIdN1p41Y6E
 e82+02fiOpjUon3CmYCG7xIjfcUR40bqR7OYSh56Uee/LeaxYeiqQhNCatrtrgIq0EdN
 mz4rY5W7BWDUE7Cu1OuNuXgMhKJMbS6nlEQR7QGXEtmi/6QGlKluXVb9jU0eqax0zpBU
 Yx03b+wy5tl49EkO0dO8/xUol21Zldl3Qhd8yG7CSfGHR8SAzUYIem5AluB6Mkbqpyph
 NcXg==
X-Gm-Message-State: AOJu0YzAGiooJgKT1Z4+jPkly9nZjmCS+B66xcl6UpMx1/WUHrlBWkgw
 CMoQO1MeElFAqVWpTM2plhieayNr76i8mY4km0GB1WUjicV8Uft3WoIcAAUPOiadL44=
X-Gm-Gg: AR+sD11HyDMPMKVO0CnDGfJQBW3OMVU1Jjj2fmo24M/bc3nfLgiPd18vpx1ZIKxbuvy
 90RpIepMpW8oJzVoLpldrmxCJTsdDCcn5EVmpqeLQNmJgOWOKZ1uuCflEdmTA2YB5L5DuGSYPY5
 iqPNN9rPjGjNmWXUtltURIXUHN+4tsVPLsJ1uHg1rzvYsVQEedw3FoYLS6pTjsZHM+6td9Y9bg0
 9Fi0dWuHLTly2+/WalvWx1b9osABgCtYRwOvao2EDiji3pIqLK38fjTKsW9zQZ9zqt8tcLXRp4E
 NoR60BnA+5LikQGgWxMY5xDRNMr8rJ/gmpXMUwprKZn7hh+9WB56bfbejOhpU3xG8DRkCzc8doH
 nIbuRrfVq7m2I9utlCCLK3D7Ctb53sl+U2oADw8XcjEO2Y6XkHQmo+5x+JmJV9fdQcSbru+fIKY
 6Uc/jtwrTTtKkvQ4a/WRiy
X-Received: by 2002:a05:6a00:174c:b0:848:2ef5:50de with SMTP id
 d2e1a72fcca58-84e595b089emr3731467b3a.38.1785068960465; 
 Sun, 26 Jul 2026 05:29:20 -0700 (PDT)
Received: from localhost.localdomain ([111.201.4.215])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-84e53426628sm1861647b3a.49.2026.07.26.05.29.15
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 26 Jul 2026 05:29:20 -0700 (PDT)
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
Subject: [PATCH 04/11] hw/ssi: Add K230 SSI interrupt controller
Date: Sun, 26 Jul 2026 20:28:22 +0800
Message-ID: <087a0aba5b55336b11fe599e01da59cc6c5aba96.1785064313.git.flamboyant.h.01@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1785064312.git.flamboyant.h.01@gmail.com>
References: <cover.1785064312.git.flamboyant.h.01@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::42c;
 envelope-from=flamboyant.h.01@gmail.com; helo=mail-pf1-x42c.google.com
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

Implement the SSI interrupt state and GPIO outputs.

Derive TXE and RXF from the FIFO thresholds. Keep RXU, TXO, and RXO as
latched causes with their documented read-clear behaviour.

Cover TXE level signalling, RXU latching, interrupt masking, and cause
clearing in qtest. PLIC routing is added by the next patch.

Signed-off-by: Kangjie Huang <flamboyant.h.01@gmail.com>
---
 hw/ssi/k230_dw_ssi.c           | 128 ++++++++++++++++++++++++++++++++-
 include/hw/ssi/k230_dw_ssi.h   |  17 +++++
 tests/qtest/k230-dw-ssi-test.c |  36 ++++++++++
 3 files changed, 179 insertions(+), 2 deletions(-)

diff --git a/hw/ssi/k230_dw_ssi.c b/hw/ssi/k230_dw_ssi.c
index d7315f28ef..26ac052a63 100644
--- a/hw/ssi/k230_dw_ssi.c
+++ b/hw/ssi/k230_dw_ssi.c
@@ -38,6 +38,7 @@
 #define K230_DW_SSI_AXIARLEN_RESET          0x00000700
 #define K230_DW_SSI_VERSION                 0x3130332a
 #define K230_DW_SSI_PIO_TX_BATCH            64
+#define K230_DW_SSI_IRQ_VALID_MASK          0x000009bf
 
 REG32(CTRLR0, 0x000)
     FIELD(CTRLR0, DFS, 0, 5)
@@ -258,12 +259,64 @@ REG32(XIP_WRITE_CTRL, 0x148)
 #define K230_DW_SSI_AXIAR0_WRITABLE_MASK R_AXIAR0_AXIAR_0_31_MASK
 #define K230_DW_SSI_AXIAR1_WRITABLE_MASK R_AXIAR1_AXIAR_32_63_MASK
 
+static const uint32_t k230_dw_ssi_irq_status_mask[
+    K230_DW_SSI_IRQ_COUNT] = {
+    [K230_DW_SSI_IRQ_TXE] = R_RISR_TXEIR_MASK,
+    [K230_DW_SSI_IRQ_TXO] = R_RISR_TXOIR_MASK,
+    [K230_DW_SSI_IRQ_RXF] = R_RISR_RXFIR_MASK,
+    [K230_DW_SSI_IRQ_RXO] = R_RISR_RXOIR_MASK,
+    [K230_DW_SSI_IRQ_TXU] = R_RISR_TXUIR_MASK,
+    [K230_DW_SSI_IRQ_RXU] = R_RISR_RXUIR_MASK,
+    [K230_DW_SSI_IRQ_MST] = R_RISR_MSTIR_MASK,
+    [K230_DW_SSI_IRQ_DONE] = R_RISR_DONER_MASK,
+    [K230_DW_SSI_IRQ_AXIE] = R_RISR_AXIER_MASK,
+};
+
 static void k230_dw_ssi_write_masked(K230DwSsiState *s, unsigned int reg,
                                      uint32_t value, uint32_t mask)
 {
     s->regs[reg] = (s->regs[reg] & ~mask) | (value & mask);
 }
 
+static uint32_t k230_dw_ssi_irq_raw_status(K230DwSsiState *s)
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
+    return status & K230_DW_SSI_IRQ_VALID_MASK;
+}
+
+static void k230_dw_ssi_update_irq(K230DwSsiState *s)
+{
+    uint32_t status = k230_dw_ssi_irq_raw_status(s) &
+                      s->regs[R_IMR] & K230_DW_SSI_IRQ_VALID_MASK;
+
+    for (int i = 0; i < K230_DW_SSI_IRQ_COUNT; i++) {
+        qemu_set_irq(s->irqs[i], !!(status & k230_dw_ssi_irq_status_mask[i]));
+    }
+}
+
+static uint32_t k230_dw_ssi_irq_read_clear(K230DwSsiState *s,
+                                            uint32_t clear_mask)
+{
+    uint32_t active = s->irq_latched & clear_mask;
+
+    s->irq_latched &= ~clear_mask;
+    k230_dw_ssi_update_irq(s);
+    return !!active;
+}
+
 static uint32_t k230_dw_ssi_frame_masked(K230DwSsiState *s)
 {
     unsigned int bits = FIELD_EX32(s->regs[R_CTRLR0], CTRLR0, DFS) + 1;
@@ -333,6 +386,7 @@ static void k230_dw_ssi_abort_transfer(K230DwSsiState *s)
     fifo32_reset(&s->rx_fifo);
     s->phase = K230_DW_SSI_PHASE_IDLE;
     s->remaining_frames = 0;
+    k230_dw_ssi_update_irq(s);
 }
 
 static uint32_t k230_dw_ssi_status(K230DwSsiState *s)
@@ -360,6 +414,8 @@ static void k230_dw_ssi_push_tx(K230DwSsiState *s, uint32_t tx)
     }
 
     if (fifo32_is_full(&s->tx_fifo)) {
+        s->irq_latched |= R_RISR_TXOIR_MASK;
+        k230_dw_ssi_update_irq(s);
         return;
     }
 
@@ -368,6 +424,7 @@ static void k230_dw_ssi_push_tx(K230DwSsiState *s, uint32_t tx)
     if (s->phase != K230_DW_SSI_PHASE_STANDARD_TX_ONLY) {
         k230_dw_ssi_run_transfer(s);
     }
+    k230_dw_ssi_update_irq(s);
 }
 
 static uint32_t k230_dw_ssi_send_frame(K230DwSsiState *s,
@@ -410,6 +467,12 @@ static void k230_dw_ssi_run_transfer(K230DwSsiState *s)
             uint32_t rx = k230_dw_ssi_send_frame(s, tx);
             if (!fifo32_is_full(&s->rx_fifo)) {
                 fifo32_push(&s->rx_fifo, rx);
+            } else {
+                s->irq_latched |= R_RISR_RXOIR_MASK;
+                qemu_log_mask(LOG_GUEST_ERROR,
+                              "%s: RX FIFO full, dropping frame\n",
+                              DEVICE(s)->canonical_path);
+                break;
             }
         }
         break;
@@ -549,9 +612,13 @@ static uint64_t k230_dw_ssi_read(void *opaque, hwaddr addr, unsigned int size)
     if (k230_dw_ssi_is_dr(addr)) {
         if (!fifo32_is_empty(&s->rx_fifo)) {
             value = fifo32_pop(&s->rx_fifo) & k230_dw_ssi_frame_masked(s);
+        } else {
+            value = 0;
+            s->irq_latched |= R_RISR_RXUIR_MASK;
         }
 
         k230_dw_ssi_run_transfer(s);
+        k230_dw_ssi_update_irq(s);
         return value;
     }
 
@@ -592,6 +659,7 @@ static uint64_t k230_dw_ssi_read(void *opaque, hwaddr addr, unsigned int size)
         value = fifo32_num_used(&s->tx_fifo);
         if (s->phase == K230_DW_SSI_PHASE_STANDARD_TX_ONLY) {
             k230_dw_ssi_run_transfer(s);
+            k230_dw_ssi_update_irq(s);
         }
         break;
     case A_RXFLR:
@@ -601,18 +669,33 @@ static uint64_t k230_dw_ssi_read(void *opaque, hwaddr addr, unsigned int size)
         value = k230_dw_ssi_status(s);
         if (s->phase == K230_DW_SSI_PHASE_STANDARD_TX_ONLY) {
             k230_dw_ssi_run_transfer(s);
+            k230_dw_ssi_update_irq(s);
         }
         break;
     case A_ISR:
+        value = k230_dw_ssi_irq_raw_status(s) & s->regs[R_IMR] &
+                K230_DW_SSI_IRQ_VALID_MASK;
+        break;
     case A_RISR:
-        value = 0;
+        value = k230_dw_ssi_irq_raw_status(s);
         break;
     case A_TXEICR:
+        value = k230_dw_ssi_irq_read_clear(
+            s, R_RISR_TXOIR_MASK | R_RISR_TXUIR_MASK);
+        break;
     case A_RXOICR:
+        value = k230_dw_ssi_irq_read_clear(s, R_RISR_RXOIR_MASK);
+        break;
     case A_RXUICR:
+        value = k230_dw_ssi_irq_read_clear(s, R_RISR_RXUIR_MASK);
+        break;
     case A_MSTICR:
+        value = k230_dw_ssi_irq_read_clear(s, R_RISR_MSTIR_MASK);
+        break;
     case A_ICR:
-        value = 0;
+        value = k230_dw_ssi_irq_read_clear(
+            s, R_RISR_TXOIR_MASK | R_RISR_RXUIR_MASK |
+               R_RISR_RXOIR_MASK | R_RISR_MSTIR_MASK);
         break;
     case A_AXIECR:
     case A_DONECR:
@@ -678,6 +761,7 @@ static void k230_dw_ssi_write(void *opaque, hwaddr addr,
 
         k230_dw_ssi_update_cs(s);
         k230_dw_ssi_run_transfer(s);
+        k230_dw_ssi_update_irq(s);
         break;
     }
     case A_MWCR:
@@ -695,6 +779,7 @@ static void k230_dw_ssi_write(void *opaque, hwaddr addr,
 
         k230_dw_ssi_update_cs(s);
         k230_dw_ssi_run_transfer(s);
+        k230_dw_ssi_update_irq(s);
         break;
     }
     case A_BAUDR:
@@ -704,10 +789,12 @@ static void k230_dw_ssi_write(void *opaque, hwaddr addr,
     case A_TXFTLR:
         k230_dw_ssi_write_masked(s, R_TXFTLR, value,
                                  K230_DW_SSI_TXFTLR_WRITABLE_MASK);
+        k230_dw_ssi_update_irq(s);
         break;
     case A_RXFTLR:
         k230_dw_ssi_write_masked(s, R_RXFTLR, value,
                                  K230_DW_SSI_RXFTLR_WRITABLE_MASK);
+        k230_dw_ssi_update_irq(s);
         break;
     case A_TXFLR:
     case A_RXFLR:
@@ -716,6 +803,7 @@ static void k230_dw_ssi_write(void *opaque, hwaddr addr,
     case A_IMR:
         k230_dw_ssi_write_masked(s, R_IMR, value,
                                  K230_DW_SSI_IMR_WRITABLE_MASK);
+        k230_dw_ssi_update_irq(s);
         break;
     case A_ISR:
     case A_RISR:
@@ -831,6 +919,7 @@ static void k230_dw_ssi_enter_reset(Object *obj, ResetType type)
     fifo32_reset(&s->rx_fifo);
     s->phase = K230_DW_SSI_PHASE_IDLE;
     s->remaining_frames = 0;
+    s->irq_latched = 0;
 
     s->regs[R_CTRLR0] = K230_DW_SSI_CTRLR0_RESET;
     s->regs[R_SR] = K230_DW_SSI_SR_RESET;
@@ -842,6 +931,8 @@ static void k230_dw_ssi_enter_reset(Object *obj, ResetType type)
     s->regs[R_SPI_CTRLR0] = s->max_lines == 8 ?
         K230_DW_SSI_SPI_CTRLR0_FMC_RESET :
         K230_DW_SSI_SPI_CTRLR0_SPI_RESET;
+
+    k230_dw_ssi_update_irq(s);
 }
 
 static void k230_dw_ssi_hold_reset(Object *obj, ResetType type)
@@ -856,12 +947,40 @@ static void k230_dw_ssi_hold_reset(Object *obj, ResetType type)
     }
 }
 
+static void k230_dw_ssi_exit_reset(Object *obj, ResetType type)
+{
+    K230DwSsiState *s = K230_DW_SSI(obj);
+
+    k230_dw_ssi_update_irq(s);
+}
+
+static int k230_dw_ssi_post_load(void *opaque, int version_id)
+{
+    K230DwSsiState *s = opaque;
+
+    if (s->active_cs < -1 || s->active_cs >= (int)s->num_cs) {
+        return -EINVAL;
+    }
+
+    for (int i = 0; i < s->num_cs; i++) {
+        qemu_irq_raise(s->cs_lines[i]);
+    }
+    if (s->active_cs >= 0) {
+        qemu_irq_lower(s->cs_lines[s->active_cs]);
+    }
+
+    k230_dw_ssi_update_irq(s);
+    return 0;
+}
+
 static const VMStateDescription vmstate_k230_dw_ssi = {
     .name = TYPE_K230_DW_SSI,
+    .post_load = k230_dw_ssi_post_load,
     .fields = (const VMStateField[]) {
         VMSTATE_UINT32_ARRAY(regs, K230DwSsiState, K230_DW_SSI_NUM_REGS),
         VMSTATE_FIFO32(tx_fifo, K230DwSsiState),
         VMSTATE_FIFO32(rx_fifo, K230DwSsiState),
+        VMSTATE_UINT32(irq_latched, K230DwSsiState),
         VMSTATE_UINT32(phase, K230DwSsiState),
         VMSTATE_UINT32(remaining_frames, K230DwSsiState),
         VMSTATE_INT32(active_cs, K230DwSsiState),
@@ -881,6 +1000,10 @@ static void k230_dw_ssi_init(Object *obj)
                           TYPE_K230_DW_SSI, K230_DW_SSI_MMIO_SIZE);
     sysbus_init_mmio(sbd, &s->mmio);
 
+    for (int i = 0; i < K230_DW_SSI_IRQ_COUNT; i++) {
+        sysbus_init_irq(sbd, &s->irqs[i]);
+    }
+
     fifo32_create(&s->tx_fifo, K230_DW_SSI_FIFO_CAPACITY);
     fifo32_create(&s->rx_fifo, K230_DW_SSI_FIFO_CAPACITY);
     s->active_cs = -1;
@@ -930,6 +1053,7 @@ static void k230_dw_ssi_class_init(ObjectClass *klass, const void *data)
     device_class_set_props(dc, k230_dw_ssi_properties);
     rc->phases.enter = k230_dw_ssi_enter_reset;
     rc->phases.hold = k230_dw_ssi_hold_reset;
+    rc->phases.exit = k230_dw_ssi_exit_reset;
 }
 
 static const TypeInfo k230_dw_ssi_info = {
diff --git a/include/hw/ssi/k230_dw_ssi.h b/include/hw/ssi/k230_dw_ssi.h
index 993cb19745..404215245b 100644
--- a/include/hw/ssi/k230_dw_ssi.h
+++ b/include/hw/ssi/k230_dw_ssi.h
@@ -31,6 +31,20 @@ OBJECT_DECLARE_SIMPLE_TYPE(K230DwSsiState, K230_DW_SSI)
 #define K230_DW_SSI_NUM_REGS \
     (K230_DW_SSI_REGS_SIZE / sizeof(uint32_t))
 
+/* SSI GPIO output ordering differs from RISR/ISR bit ordering. */
+typedef enum K230DwSsiIrq {
+    K230_DW_SSI_IRQ_TXE,
+    K230_DW_SSI_IRQ_TXO,
+    K230_DW_SSI_IRQ_RXF,
+    K230_DW_SSI_IRQ_RXO,
+    K230_DW_SSI_IRQ_TXU,
+    K230_DW_SSI_IRQ_RXU,
+    K230_DW_SSI_IRQ_MST,
+    K230_DW_SSI_IRQ_DONE,
+    K230_DW_SSI_IRQ_AXIE,
+    K230_DW_SSI_IRQ_COUNT,
+} K230DwSsiIrq;
+
 typedef enum K230DwSsiPhase {
     K230_DW_SSI_PHASE_IDLE,
     K230_DW_SSI_PHASE_STANDARD_TX_ONLY,
@@ -45,11 +59,14 @@ struct K230DwSsiState {
     MemoryRegion mmio;
     SSIBus *spi;
     qemu_irq *cs_lines;
+    qemu_irq irqs[K230_DW_SSI_IRQ_COUNT];
 
     Fifo32 tx_fifo;
     Fifo32 rx_fifo;
     uint32_t regs[K230_DW_SSI_NUM_REGS];
 
+    uint32_t irq_latched;
+
     uint32_t phase;
     uint32_t remaining_frames;
 
diff --git a/tests/qtest/k230-dw-ssi-test.c b/tests/qtest/k230-dw-ssi-test.c
index a62b1a7ff6..0a3d03d6f3 100644
--- a/tests/qtest/k230-dw-ssi-test.c
+++ b/tests/qtest/k230-dw-ssi-test.c
@@ -25,6 +25,7 @@
 #define K230_SSI_IMR             0x02c
 #define K230_SSI_ISR             0x030
 #define K230_SSI_RISR            0x034
+#define K230_SSI_RXUICR          0x040
 #define K230_SSI_DMACR           0x04c
 #define K230_SSI_IDR             0x058
 #define K230_SSI_VERSION_ID      0x05c
@@ -63,6 +64,8 @@
 #define K230_SSI_SR_TFE                 BIT(2)
 #define K230_SSI_SR_RFNE                BIT(3)
 
+#define K230_SSI_INT_TXE                BIT(0)
+#define K230_SSI_INT_RXU                BIT(2)
 #define K230_SSI_INT_AXIE               BIT(8)
 #define K230_SSI_INT_DONE               BIT(11)
 
@@ -245,11 +248,44 @@ static void test_pio_data_path(void)
     qtest_quit(qts);
 }
 
+static void test_interrupt_controller(void)
+{
+    QTestState *qts = k230_ssi_start();
+
+    k230_ssi_configure(qts, K230_SPI1_BASE, K230_SSI_TMOD_TR, 8, 0);
+    k230_ssi_writel(qts, K230_SPI1_BASE, K230_SSI_TXFTLR, 0);
+    k230_ssi_writel(qts, K230_SPI1_BASE, K230_SSI_IMR, 0);
+    k230_ssi_writel(qts, K230_SPI1_BASE, K230_SSI_SSIENR, 1);
+    g_assert_cmphex(k230_ssi_readl(qts, K230_SPI1_BASE, K230_SSI_RISR) &
+                    K230_SSI_INT_TXE, ==, K230_SSI_INT_TXE);
+    g_assert_cmphex(k230_ssi_readl(qts, K230_SPI1_BASE, K230_SSI_ISR) &
+                    K230_SSI_INT_TXE, ==, 0);
+    k230_ssi_writel(qts, K230_SPI1_BASE, K230_SSI_IMR,
+                    K230_SSI_INT_TXE);
+    g_assert_cmphex(k230_ssi_readl(qts, K230_SPI1_BASE, K230_SSI_ISR) &
+                    K230_SSI_INT_TXE, ==, K230_SSI_INT_TXE);
+
+    k230_ssi_writel(qts, K230_SPI1_BASE, K230_SSI_IMR,
+                    K230_SSI_INT_RXU);
+    (void)k230_ssi_read_frame(qts, K230_SPI1_BASE);
+    g_assert_cmphex(k230_ssi_readl(qts, K230_SPI1_BASE, K230_SSI_RISR) &
+                    K230_SSI_INT_RXU, ==, K230_SSI_INT_RXU);
+    g_assert_cmphex(k230_ssi_readl(qts, K230_SPI1_BASE, K230_SSI_ISR) &
+                    K230_SSI_INT_RXU, ==, K230_SSI_INT_RXU);
+    g_assert_cmphex(k230_ssi_readl(qts, K230_SPI1_BASE, K230_SSI_RXUICR),
+                    ==, 1);
+    g_assert_cmphex(k230_ssi_readl(qts, K230_SPI1_BASE, K230_SSI_RISR) &
+                    K230_SSI_INT_RXU, ==, 0);
+    qtest_quit(qts);
+}
+
 int main(int argc, char **argv)
 {
     g_test_init(&argc, &argv, NULL);
 
     qtest_add_func("/k230-dw-ssi/register-contract", test_register_contract);
     qtest_add_func("/k230-dw-ssi/pio-data-path", test_pio_data_path);
+    qtest_add_func("/k230-dw-ssi/interrupt-controller",
+                   test_interrupt_controller);
     return g_test_run();
 }
-- 
2.43.0


