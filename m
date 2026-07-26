Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7BC5AC531C9
	for <qemu-devel@archiver.kernel.org>; Sun, 26 Jul 2026 12:31:13 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wnxzT-0002Ix-VF; Sun, 26 Jul 2026 08:30:00 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <flamboyant.h.01@gmail.com>)
 id 1wnxzJ-00023i-Jt
 for qemu-devel@nongnu.org; Sun, 26 Jul 2026 08:29:51 -0400
Received: from mail-pf1-x42f.google.com ([2607:f8b0:4864:20::42f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <flamboyant.h.01@gmail.com>)
 id 1wnxzG-0003Kf-0x
 for qemu-devel@nongnu.org; Sun, 26 Jul 2026 08:29:48 -0400
Received: by mail-pf1-x42f.google.com with SMTP id
 d2e1a72fcca58-84862b0d5f8so1399304b3a.3
 for <qemu-devel@nongnu.org>; Sun, 26 Jul 2026 05:29:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1785068985; x=1785673785; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=lGCkWJzQd7BJMWOS08X/BktnfKt61NKByqz9ghUWBQs=;
 b=YYZD/bSwyLBQ5gPOwYonQaKzKSR8s6ge/8DmM6SXa61KAQLOZdmp4gLKmhaVDHRfYe
 9hyIhbKLz5m3jgypNcJhgp3d17TyRay8t4VFyfC7d1ywS8bruZxlzMYvDdMdqofWuJeO
 qEidkEzOdBrPog/BnQrvcDgUhWTiOuFwnq8au1hKlex2shUPqLqbh1/GGzHbJP16P3gx
 Oye/gEW6mwE5HR+q88xnFDcXbb8MhSZKCkmBe/QJ68NGEk/JE02ktPXb3YuGccQJ9qI1
 Dy0bcRIqsK0OrbWd47PaKeW/DlcJGITX6FMzOqwM71arhRs8lr2CCB3xC4pVq692qRV2
 1Fsw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1785068985; x=1785673785;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=lGCkWJzQd7BJMWOS08X/BktnfKt61NKByqz9ghUWBQs=;
 b=Kmq53pQlHGBZdqnWsbw91RnKF3RDXfMrdXRDdcAIRhmoSkx6txXne50kB3s/g/S/mv
 dJ5fYWp8SNJv90qUmk2QHt9LnVCZlPZvgub44SOv3PUT6fQUTErwM1geaE5obWFk+mWF
 aBUjYpQG6rI0vlXDr+XOHskveZq/C2c0UoPmdiyrugvEvkjWrDaR+LKLJdZe9TZ3inUP
 LE/OOu7Xgp5GzzeJDv7m5n4Zi77LFupRYld2XA8CHcCO5n3Q3ZRwW2s/3clQjXnSr5KM
 KLecOyBlTbNzKG/S8YE2bVOqQhGzEP3ykx3t0Wcgw5ojDZ5A8EX5GrppBo09SUDWbNVz
 VN7A==
X-Gm-Message-State: AOJu0YxCyxs1VaboCeMxVlhzFG3prw+JRSErsqYmB4pP452RzSs1jqIJ
 wvIdjRk3cjpocxUoPYCifKJKTNvMflQQA0ysZiA8/XldhVGIluai1aQM94pC+FjawBg=
X-Gm-Gg: AR+sD12t6sWu/Z7h9U65JmkzzPnRXlaoIMWUee5PGSDqAYHNQjwpz/mke2J2n9AsRSd
 r3IrzElIqiIXR/nXn6R9UEG8kUZsLHBPShEeOIXoM0+kbaMWw/9PYRnuMLmytNnpBtLFekWCiiJ
 nAEB88intwvCKppEdWMzpc5naJdwLbXdZJAK+c6fESzUy45dZHDLh4D+dg/FsLlgVZwyOWzcknj
 K+da8sXLQWNqlUM8/7Vsf3TiMgoU5hxqS/vW88xHYxvMCUSjE9+iD7wPk+uQURCtGZhmf+A07S5
 pFFpLJg+JqJLgrQpjUSHjJqC1Xt9b32CfmFXA9Q1ScVtA0CXvsRl2nJmMsDAbpX1wg04ypIOFiz
 T47jlaeyZIoF9dNG4kqS6RU42bJNDv0LBMfzCHpQW+EcjCeJ4XZ2zM0Hymd9FZ1/axStMf7Ui31
 q1CO+DwSK7D8NW6nTv4LHV
X-Received: by 2002:a05:6a00:6c95:b0:847:c014:864e with SMTP id
 d2e1a72fcca58-84e594969bfmr3791282b3a.30.1785068984445; 
 Sun, 26 Jul 2026 05:29:44 -0700 (PDT)
Received: from localhost.localdomain ([111.201.4.215])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-84e53426628sm1861647b3a.49.2026.07.26.05.29.40
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 26 Jul 2026 05:29:44 -0700 (PDT)
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
Subject: [PATCH 08/11] hw/ssi: Implement K230 SSI internal DMA transfers
Date: Sun, 26 Jul 2026 20:28:26 +0800
Message-ID: <8f3b84c222bc1d4cc5d5704b13cd70e9af39cce4.1785064313.git.flamboyant.h.01@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1785064312.git.flamboyant.h.01@gmail.com>
References: <cover.1785064312.git.flamboyant.h.01@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::42f;
 envelope-from=flamboyant.h.01@gmail.com; helo=mail-pf1-x42f.google.com
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

Implement synchronous internal DMA for 8-bit SDR Dual and Quad transfer
modes. The K230 SDK driver polls DONE before touching the buffer, so a
synchronous model is sufficient and avoids racing guest memory. Only the
8-bit SDR Dual and Quad modes are supported, matching what that driver
uses.

Build enhanced commands from SPIDR and SPIAR, move data through AXIAR0/1,
and report completion or guest-memory failures through the DONE and AXIE
interrupt causes.

Keep DR accesses out of the FIFO while IDMA is enabled. Implement the
read-clear status registers, terminate each transaction with SSI
disabled and chip select inactive, and migrate the completed-frame
count.

Cover a Quad read into guest RAM, completed-frame reporting, DONE
routing and clearing, and the AXIE path for an invalid guest address.

Exercise QSPI read and write commands from U-Boot and Linux. With spi0
configured for QSPI in the device tree, boot a Linux image from QSPI
flash.

Signed-off-by: Kangjie Huang <flamboyant.h.01@gmail.com>
---
 docs/system/riscv/k230.rst     |   1 +
 hw/ssi/k230_dw_ssi.c           | 203 +++++++++++++++++++++++++++++++--
 include/hw/ssi/k230_dw_ssi.h   |   1 +
 tests/qtest/k230-dw-ssi-test.c |  95 +++++++++++++++
 4 files changed, 290 insertions(+), 10 deletions(-)

diff --git a/docs/system/riscv/k230.rst b/docs/system/riscv/k230.rst
index 0d2617c0f9..3067c1b5d7 100644
--- a/docs/system/riscv/k230.rst
+++ b/docs/system/riscv/k230.rst
@@ -22,6 +22,7 @@ The ``k230`` machine supports the following devices:
 * 5 UART
 * 3 K230 SSI controllers for SPI and QSPI
 * Optional SPI NOR flash on spi0 CS0
+* QSPI IDMA transfers for 8-bit SDR Dual and Quad modes
 
 Boot options
 ------------
diff --git a/hw/ssi/k230_dw_ssi.c b/hw/ssi/k230_dw_ssi.c
index 31da3a06a3..65b2a8c245 100644
--- a/hw/ssi/k230_dw_ssi.c
+++ b/hw/ssi/k230_dw_ssi.c
@@ -25,6 +25,7 @@
 #include "qemu/bitops.h"
 #include "qemu/log.h"
 #include "qemu/module.h"
+#include "system/dma.h"
 
 #define K230_DW_SSI_FIFO_CAPACITY 256
 
@@ -331,7 +332,7 @@ static uint32_t k230_dw_ssi_frame_masked(K230DwSsiState *s)
     return bits == 32 ? UINT32_MAX : MAKE_64BIT_MASK(0, bits);
 }
 
-static bool k230_dw_ssi_enabled(K230DwSsiState *s)
+static bool k230_dw_ssi_enabled(const K230DwSsiState *s)
 {
     return FIELD_EX32(s->regs[R_SSIENR], SSIENR, SSIC_EN);
 }
@@ -408,6 +409,7 @@ static uint32_t k230_dw_ssi_status(K230DwSsiState *s)
     sr = FIELD_DP32(sr, SR, RFNE, rx_used != 0);
     sr = FIELD_DP32(sr, SR, RFF,
                     rx_used == K230_DW_SSI_FIFO_CAPACITY);
+    sr = FIELD_DP32(sr, SR, CMPLTD_DF, s->idma_completed_frames);
 
     return sr;
 }
@@ -623,6 +625,172 @@ static uint32_t k230_dw_ssi_dummy_bytes(uint32_t spi_frf,
     return DIV_ROUND_UP(wait_cycles * lines, 8);
 }
 
+static bool k230_dw_ssi_idma_enabled(const K230DwSsiState *s)
+{
+    return FIELD_EX32(s->regs[R_DMACR], DMACR, IDMAE);
+}
+
+static uint64_t k230_dw_ssi_idma_address(const K230DwSsiState *s)
+{
+    return s->regs[R_AXIAR0] | ((uint64_t)s->regs[R_AXIAR1] << 32);
+}
+
+static bool k230_dw_ssi_idma_triggered(const K230DwSsiState *s)
+{
+    uint32_t ser = s->regs[R_SER];
+
+    return k230_dw_ssi_idma_enabled(s) &&
+           k230_dw_ssi_enabled(s) && ser &&
+           !(ser & (ser - 1)) &&
+           s->phase == K230_DW_SSI_PHASE_IDLE;
+}
+
+static void k230_dw_ssi_idma_end(K230DwSsiState *s, uint32_t cause)
+{
+    s->regs[R_SSIENR] = 0;
+    s->phase = K230_DW_SSI_PHASE_IDLE;
+    s->remaining_frames = 0;
+    k230_dw_ssi_deselect(s);
+    s->irq_latched |= cause;
+    k230_dw_ssi_update_irq(s);
+}
+
+static void k230_dw_ssi_idma_fail(K230DwSsiState *s, const char *operation)
+{
+    qemu_log_mask(LOG_GUEST_ERROR,
+                  "%s: IDMA %s memory access failed\n",
+                  DEVICE(s)->canonical_path, operation);
+    s->idma_completed_frames = 0;
+    k230_dw_ssi_idma_end(s, R_RISR_AXIER_MASK);
+}
+
+/*
+ * Supported SDK paths observe the final memory contents and DONE/AXIE,
+ * so complete IDMA synchronously without modeling AXI timing or FIFO
+ * backpressure.
+ */
+static void k230_dw_ssi_try_idma(K230DwSsiState *s)
+{
+    K230DwSsiEnhancedCommand command = { 0 };
+    g_autofree uint8_t *buffer = NULL;
+    uint64_t address;
+    uint32_t dummy_bytes;
+    uint32_t length;
+    MemTxResult result;
+
+    if (!k230_dw_ssi_idma_triggered(s)) {
+        return;
+    }
+
+    if (!FIELD_EX32(s->regs[R_DMACR], DMACR, AINC)) {
+        qemu_log_mask(LOG_UNIMP,
+                      "%s: fixed-address IDMA is unsupported\n",
+                      DEVICE(s)->canonical_path);
+        s->idma_completed_frames = 0;
+        k230_dw_ssi_idma_end(s, 0);
+        return;
+    }
+
+    if (!fifo32_is_empty(&s->tx_fifo) ||
+        !fifo32_is_empty(&s->rx_fifo)) {
+        qemu_log_mask(LOG_GUEST_ERROR,
+                      "%s: IDMA requires empty TX and RX FIFOs\n",
+                      DEVICE(s)->canonical_path);
+        s->idma_completed_frames = 0;
+        k230_dw_ssi_idma_end(s, 0);
+        return;
+    }
+
+    if (FIELD_EX32(s->regs[R_CTRLR0], CTRLR0, DFS) != 7) {
+        qemu_log_mask(LOG_UNIMP,
+                      "%s: IDMA only supports 8-bit data frames\n",
+                      DEVICE(s)->canonical_path);
+        s->idma_completed_frames = 0;
+        k230_dw_ssi_idma_end(s, 0);
+        return;
+    }
+
+    if (!k230_dw_ssi_decode_enhanced_command(s, &command)) {
+        s->idma_completed_frames = 0;
+        k230_dw_ssi_idma_end(s, 0);
+        return;
+    }
+
+    command.instruction = s->regs[R_SPIDR] &
+        (uint32_t)MAKE_64BIT_MASK(0, command.instruction_bits);
+    command.address = s->regs[R_SPIAR] &
+        (uint32_t)MAKE_64BIT_MASK(0, command.address_bits);
+    length = command.data_frames;
+    address = k230_dw_ssi_idma_address(s);
+    s->idma_completed_frames = 0;
+
+    if (address > UINT64_MAX - (length - 1)) {
+        k230_dw_ssi_idma_fail(s, "address range");
+        return;
+    }
+
+    buffer = g_malloc(length);
+    if (command.tmod == K230_DW_SSI_TMOD_TO) {
+        result = dma_memory_read(&address_space_memory, address, buffer,
+                                 length, MEMTXATTRS_UNSPECIFIED);
+        if (result != MEMTX_OK) {
+            k230_dw_ssi_idma_fail(s, "source");
+            return;
+        }
+    }
+
+    k230_dw_ssi_update_cs(s);
+    if (s->active_cs < 0) {
+        k230_dw_ssi_idma_end(s, 0);
+        return;
+    }
+
+    if (command.instruction_bits != 0) {
+        k230_dw_ssi_send_enhanced_field(s, command.instruction,
+                                         command.instruction_bits);
+    }
+    if (command.address_bits != 0) {
+        k230_dw_ssi_send_enhanced_field(s, command.address,
+                                         command.address_bits);
+    }
+    if (command.mode_bits_enabled) {
+        k230_dw_ssi_send_enhanced_field(s, command.mode,
+                                         command.mode_bits);
+    } else if (command.trans_type == 1 && command.wait_cycles >= 2) {
+        /*
+         * The SDK's 1-4-4 read supplies its mode byte through XIP_MODE_BITS
+         * without XIP_MD_BIT_EN; one Quad byte consumes two wait cycles.
+         */
+        k230_dw_ssi_send_enhanced_field(s, s->regs[R_XIP_MODE_BITS], 8);
+        command.wait_cycles -= 2;
+    }
+
+    dummy_bytes = k230_dw_ssi_dummy_bytes(
+        command.spi_frf, command.trans_type, command.wait_cycles);
+    for (uint32_t i = 0; i < dummy_bytes; i++) {
+        ssi_transfer(s->spi, 0);
+    }
+
+    if (command.tmod == K230_DW_SSI_TMOD_RO) {
+        for (uint32_t i = 0; i < length; i++) {
+            buffer[i] = ssi_transfer(s->spi, 0);
+        }
+        result = dma_memory_write(&address_space_memory, address, buffer,
+                                  length, MEMTXATTRS_UNSPECIFIED);
+        if (result != MEMTX_OK) {
+            k230_dw_ssi_idma_fail(s, "destination");
+            return;
+        }
+    } else {
+        for (uint32_t i = 0; i < length; i++) {
+            ssi_transfer(s->spi, buffer[i]);
+        }
+    }
+
+    s->idma_completed_frames = length;
+    k230_dw_ssi_idma_end(s, R_RISR_DONER_MASK);
+}
+
 static void k230_dw_ssi_run_enhanced_rx_data(K230DwSsiState *s)
 {
     while (!fifo32_is_full(&s->rx_fifo) &&
@@ -878,6 +1046,10 @@ static uint64_t k230_dw_ssi_read(void *opaque, hwaddr addr, unsigned int size)
     uint32_t value = 0;
 
     if (k230_dw_ssi_is_dr(addr)) {
+        if (k230_dw_ssi_idma_enabled(s)) {
+            return 0;
+        }
+
         if (!fifo32_is_empty(&s->rx_fifo)) {
             value = fifo32_pop(&s->rx_fifo) & k230_dw_ssi_frame_masked(s);
         } else {
@@ -966,8 +1138,10 @@ static uint64_t k230_dw_ssi_read(void *opaque, hwaddr addr, unsigned int size)
                R_RISR_RXOIR_MASK | R_RISR_MSTIR_MASK);
         break;
     case A_AXIECR:
+        value = k230_dw_ssi_irq_read_clear(s, R_RISR_AXIER_MASK);
+        break;
     case A_DONECR:
-        value = 0;
+        value = k230_dw_ssi_irq_read_clear(s, R_RISR_DONER_MASK);
         break;
     default:
         if (addr >= K230_DW_SSI_REGS_SIZE || (addr & 0x3) != 0) {
@@ -987,6 +1161,10 @@ static void k230_dw_ssi_write(void *opaque, hwaddr addr,
     K230DwSsiState *s = K230_DW_SSI(opaque);
 
     if (k230_dw_ssi_is_dr(addr)) {
+        if (k230_dw_ssi_idma_enabled(s)) {
+            return;
+        }
+
         k230_dw_ssi_push_tx(s, value);
         return;
     }
@@ -1028,7 +1206,11 @@ static void k230_dw_ssi_write(void *opaque, hwaddr addr,
         }
 
         k230_dw_ssi_update_cs(s);
-        k230_dw_ssi_run_transfer(s);
+        if (k230_dw_ssi_idma_enabled(s)) {
+            k230_dw_ssi_try_idma(s);
+        } else {
+            k230_dw_ssi_run_transfer(s);
+        }
         k230_dw_ssi_update_irq(s);
         break;
     }
@@ -1046,7 +1228,11 @@ static void k230_dw_ssi_write(void *opaque, hwaddr addr,
         }
 
         k230_dw_ssi_update_cs(s);
-        k230_dw_ssi_run_transfer(s);
+        if (k230_dw_ssi_idma_enabled(s)) {
+            k230_dw_ssi_try_idma(s);
+        } else {
+            k230_dw_ssi_run_transfer(s);
+        }
         k230_dw_ssi_update_irq(s);
         break;
     }
@@ -1085,12 +1271,7 @@ static void k230_dw_ssi_write(void *opaque, hwaddr addr,
     case A_DMACR:
         k230_dw_ssi_write_masked(s, R_DMACR, value,
                                  K230_DW_SSI_DMACR_WRITABLE_MASK);
-        if (FIELD_EX32(s->regs[R_DMACR], DMACR, IDMAE)) {
-            qemu_log_mask(LOG_UNIMP,
-                          "%s: DMACR.IDMAE enabled, internal DMA is not "
-                          "implemented\n",
-                          DEVICE(s)->canonical_path);
-        }
+        k230_dw_ssi_try_idma(s);
         break;
     case A_AXIAWLEN:
         k230_dw_ssi_write_masked(s, R_AXIAWLEN, value,
@@ -1188,6 +1369,7 @@ static void k230_dw_ssi_enter_reset(Object *obj, ResetType type)
     s->phase = K230_DW_SSI_PHASE_IDLE;
     s->remaining_frames = 0;
     s->irq_latched = 0;
+    s->idma_completed_frames = 0;
     memset(&s->enhanced, 0, sizeof(s->enhanced));
 
     s->regs[R_CTRLR0] = K230_DW_SSI_CTRLR0_RESET;
@@ -1250,6 +1432,7 @@ static const VMStateDescription vmstate_k230_dw_ssi = {
         VMSTATE_FIFO32(tx_fifo, K230DwSsiState),
         VMSTATE_FIFO32(rx_fifo, K230DwSsiState),
         VMSTATE_UINT32(irq_latched, K230DwSsiState),
+        VMSTATE_UINT32(idma_completed_frames, K230DwSsiState),
         VMSTATE_UINT32(phase, K230DwSsiState),
         VMSTATE_UINT32(remaining_frames, K230DwSsiState),
         VMSTATE_UINT32(enhanced.instruction, K230DwSsiState),
diff --git a/include/hw/ssi/k230_dw_ssi.h b/include/hw/ssi/k230_dw_ssi.h
index b692a616d6..3a1b2c08cd 100644
--- a/include/hw/ssi/k230_dw_ssi.h
+++ b/include/hw/ssi/k230_dw_ssi.h
@@ -87,6 +87,7 @@ struct K230DwSsiState {
     uint32_t regs[K230_DW_SSI_NUM_REGS];
 
     uint32_t irq_latched;
+    uint32_t idma_completed_frames;
 
     uint32_t phase;
     uint32_t remaining_frames;
diff --git a/tests/qtest/k230-dw-ssi-test.c b/tests/qtest/k230-dw-ssi-test.c
index 658b1f4cbf..ddf5e13145 100644
--- a/tests/qtest/k230-dw-ssi-test.c
+++ b/tests/qtest/k230-dw-ssi-test.c
@@ -79,12 +79,18 @@
 #define K230_SSI_SR_TFNF                BIT(1)
 #define K230_SSI_SR_TFE                 BIT(2)
 #define K230_SSI_SR_RFNE                BIT(3)
+#define K230_SSI_SR_CMPLTD_DF_SHIFT     15
+#define K230_SSI_SR_CMPLTD_DF_MASK      (0x1ffffU << 15)
 
 #define K230_SSI_INT_TXE                BIT(0)
 #define K230_SSI_INT_RXU                BIT(2)
 #define K230_SSI_INT_AXIE               BIT(8)
 #define K230_SSI_INT_DONE               BIT(11)
 
+#define K230_SSI_IDMAE                  BIT(2)
+#define K230_SSI_AINC                   BIT(6)
+#define K230_SSI_DMA_ADDR               0x80201000ULL
+
 #define K230_SSI_IRQ_TXE                0
 #define K230_SSI_IRQ_RXU                5
 #define K230_SSI_IRQ_DONE               7
@@ -414,6 +420,44 @@ static void read_enhanced_result(QTestState *qts, uint8_t *data, size_t len)
     k230_ssi_disable(qts, K230_SPI0_BASE);
 }
 
+static void configure_idma(QTestState *qts, uint32_t tmod,
+                           uint8_t opcode, uint32_t flash_address,
+                           uint64_t dma_address, size_t length)
+{
+    uint32_t ctrlr0;
+    uint32_t spi_ctrlr0;
+
+    k230_ssi_configure(qts, K230_SPI0_BASE, tmod, 8, length - 1);
+    k230_ssi_writel(qts, K230_SPI0_BASE, K230_SSI_SER, 0);
+    ctrlr0 = k230_ssi_readl(qts, K230_SPI0_BASE, K230_SSI_CTRLR0);
+    ctrlr0 |= K230_SSI_FRF_QUAD << K230_SSI_CTRLR0_SPI_FRF_SHIFT;
+    k230_ssi_writel(qts, K230_SPI0_BASE, K230_SSI_CTRLR0, ctrlr0);
+    spi_ctrlr0 = K230_SSI_SPI_CTRLR0_TRANS_TYPE(0) |
+                 K230_SSI_SPI_CTRLR0_ADDR_L(24) |
+                 K230_SSI_SPI_CTRLR0_INST_L_8 |
+                 K230_SSI_SPI_CTRLR0_WAIT(8);
+    k230_ssi_writel(qts, K230_SPI0_BASE, K230_SSI_SPI_CTRLR0, spi_ctrlr0);
+    k230_ssi_writel(qts, K230_SPI0_BASE, K230_SSI_DMACR,
+                    K230_SSI_IDMAE | K230_SSI_AINC);
+    k230_ssi_writel(qts, K230_SPI0_BASE, K230_SSI_SPIDR, opcode);
+    k230_ssi_writel(qts, K230_SPI0_BASE, K230_SSI_SPIAR, flash_address);
+    k230_ssi_writel(qts, K230_SPI0_BASE, K230_SSI_AXIAR0, dma_address);
+    k230_ssi_writel(qts, K230_SPI0_BASE, K230_SSI_AXIAR1,
+                    dma_address >> 32);
+    k230_ssi_writel(qts, K230_SPI0_BASE, K230_SSI_SSIENR, 1);
+    k230_ssi_writel(qts, K230_SPI0_BASE, K230_SSI_SER, BIT(0));
+}
+
+static void assert_idma_stopped(QTestState *qts, size_t completed)
+{
+    uint32_t status = k230_ssi_readl(qts, K230_SPI0_BASE, K230_SSI_SR);
+
+    g_assert_cmphex(k230_ssi_readl(qts, K230_SPI0_BASE, K230_SSI_SSIENR),
+                    ==, 0);
+    g_assert_cmpuint((status & K230_SSI_SR_CMPLTD_DF_MASK) >>
+                     K230_SSI_SR_CMPLTD_DF_SHIFT, ==, completed);
+}
+
 static void test_register_contract(void)
 {
     QTestState *qts = k230_ssi_start();
@@ -673,6 +717,56 @@ static void test_qspi_sdr(void)
     k230_ssi_flash_image_clear(&image);
 }
 
+static void test_idma(void)
+{
+    static const uint8_t expected[] = { 0xa5, 0x5a, 0x3c, 0xc3 };
+    K230SsiFlashImage image;
+    QTestState *qts = k230_ssi_start_with_flash(&image);
+    uint8_t actual[ARRAY_SIZE(expected)];
+
+    qtest_memset(qts, K230_SSI_DMA_ADDR, 0, sizeof(actual));
+    k230_ssi_writel(qts, K230_SPI0_BASE, K230_SSI_IMR, 0);
+    configure_idma(qts, K230_SSI_TMOD_RO, FLASH_CMD_QUAD_OUT,
+                   K230_SSI_FLASH_PATTERN_ADDR, K230_SSI_DMA_ADDR,
+                   sizeof(actual));
+    g_assert_cmphex(k230_ssi_readl(qts, K230_SPI0_BASE, K230_SSI_RISR) &
+                    K230_SSI_INT_DONE, ==, K230_SSI_INT_DONE);
+    g_assert_cmphex(k230_ssi_readl(qts, K230_SPI0_BASE, K230_SSI_ISR) &
+                    K230_SSI_INT_DONE, ==, 0);
+    k230_ssi_writel(qts, K230_SPI0_BASE, K230_SSI_IMR,
+                    K230_SSI_INT_DONE);
+    g_assert_true(k230_ssi_plic_pending(
+        qts, k230_ssi_instances[0].first_irq + K230_SSI_IRQ_DONE));
+    assert_idma_stopped(qts, sizeof(actual));
+    qtest_memread(qts, K230_SSI_DMA_ADDR, actual, sizeof(actual));
+    g_assert_cmpmem(actual, sizeof(actual), expected, sizeof(expected));
+    k230_ssi_writel(qts, K230_SPI0_BASE, K230_SSI_DONECR, 1);
+    g_assert_cmphex(k230_ssi_readl(qts, K230_SPI0_BASE, K230_SSI_DONECR),
+                    ==, 1);
+    g_assert_cmphex(k230_ssi_readl(qts, K230_SPI0_BASE, K230_SSI_RISR) &
+                    K230_SSI_INT_DONE, ==, 0);
+
+    k230_ssi_writel(qts, K230_SPI0_BASE, K230_SSI_IMR, 0);
+    configure_idma(qts, K230_SSI_TMOD_RO, FLASH_CMD_QUAD_OUT,
+                   K230_SSI_FLASH_PATTERN_ADDR, 0x100000000ULL,
+                   sizeof(actual));
+    g_assert_cmphex(k230_ssi_readl(qts, K230_SPI0_BASE, K230_SSI_RISR) &
+                    K230_SSI_INT_AXIE, ==, K230_SSI_INT_AXIE);
+    assert_idma_stopped(qts, 0);
+    k230_ssi_writel(qts, K230_SPI0_BASE, K230_SSI_IMR,
+                    K230_SSI_INT_AXIE);
+    g_assert_true(k230_ssi_plic_pending(
+        qts, k230_ssi_instances[0].first_irq + K230_SSI_IRQ_AXIE));
+    k230_ssi_writel(qts, K230_SPI0_BASE, K230_SSI_AXIECR, 1);
+    g_assert_cmphex(k230_ssi_readl(qts, K230_SPI0_BASE, K230_SSI_AXIECR),
+                    ==, 1);
+    g_assert_cmphex(k230_ssi_readl(qts, K230_SPI0_BASE, K230_SSI_RISR) &
+                    K230_SSI_INT_AXIE, ==, 0);
+
+    qtest_quit(qts);
+    k230_ssi_flash_image_clear(&image);
+}
+
 int main(int argc, char **argv)
 {
     g_test_init(&argc, &argv, NULL);
@@ -685,5 +779,6 @@ int main(int argc, char **argv)
     qtest_add_func("/k230-dw-ssi/qspi-config", test_qspi_config);
     qtest_add_func("/k230-dw-ssi/spi-nor", test_spi_nor);
     qtest_add_func("/k230-dw-ssi/qspi-sdr", test_qspi_sdr);
+    qtest_add_func("/k230-dw-ssi/idma", test_idma);
     return g_test_run();
 }
-- 
2.43.0


