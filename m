Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E360BC531C9
	for <qemu-devel@archiver.kernel.org>; Sun, 26 Jul 2026 12:31:28 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wnxzj-00033b-Kn; Sun, 26 Jul 2026 08:30:15 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <flamboyant.h.01@gmail.com>)
 id 1wnxzb-0002eY-Mk
 for qemu-devel@nongnu.org; Sun, 26 Jul 2026 08:30:09 -0400
Received: from mail-pf1-x42d.google.com ([2607:f8b0:4864:20::42d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <flamboyant.h.01@gmail.com>)
 id 1wnxzZ-0003W8-Jr
 for qemu-devel@nongnu.org; Sun, 26 Jul 2026 08:30:07 -0400
Received: by mail-pf1-x42d.google.com with SMTP id
 d2e1a72fcca58-84e04df8c46so1936982b3a.2
 for <qemu-devel@nongnu.org>; Sun, 26 Jul 2026 05:30:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1785069003; x=1785673803; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=nifUjXxe5QBh90mmQAcHpR7NxfbtG30uL6XuUSI3+P8=;
 b=rQYWrLVJHqCsr+C6G2ybDVQFloqksQN5LP/7obN6lRqH11dCF1ItjcUiKFAT05FlE5
 ko4BdiJBxOoLhCi2Gx5++T/eJYqNXeP7/AcVv6t/DopEGuNSCs5qs5t+Bc0fTkCN+mOE
 vmdKJ5jZPFOpWR+LemHDFvPOP2kD9eSO6LgUfnt3h/C1Q3yAiQ1HIQFUip5TbX/6OmGr
 9gSJzNxiacYke+WSmsHXxRFw/LaSg9Q0eaFE3QWUCXbRnMye8ZKYcTVd79YEITb8L9VU
 0YBaO4Q6KsBvN5QfQOTLWkiBRkkCffo9bBH1H5GXBOo1K5aNwAm23GrpCRFPjwEQuC1m
 x78w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1785069003; x=1785673803;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=nifUjXxe5QBh90mmQAcHpR7NxfbtG30uL6XuUSI3+P8=;
 b=oYS7Y3he/hJmHB7YOciPiBuuHLw6l3lrieApL/GcErxU3Yu4vHBOtLViMMo1CnZFSk
 m4dMDQCFFDGGdnEsQ2YD4Dmfs2RKRUSzOKOLfyD9my3ClhGIvuEyVi5oAqXvdiUSN0vf
 SZFnn+Lhur2YxpUBoM97wwCfF5nmXt9bHlLTtcRUCKR629zqBr2a7NJVcDGQsJmj70a2
 y3QeV9Gw1LGyMOmRbO2wQtjCvA0qY+EudMBLcyosRWmDbUxqlhRI0l4rDRPU87LNNWZf
 TXWR5r+VOQFGFBi/7BtpaS9j9OWbo/rM17YJ1qdR1utJVoh2U7CNwDJ5Ha7/32DZcWhd
 M2JA==
X-Gm-Message-State: AOJu0YzcH0P8KrZafe2X5IA8bfGK0qF6kFRaFlXTKGeLC/fq/ystMWcL
 F0xHEaXMO+am1vJUZMISCa5+VEVeNeqsJownQP9CTdvBAaU726kbnfIYQCyGXofw5Kw=
X-Gm-Gg: AR+sD11xGbO+pyAaGkOHDJA2LezPAp4BvTW4NxQKxB5BdmlkdjI+MHjq/0hjdylXbDY
 tIjFWUlQgNMHhaVwIl355gclbagdhgR6W5xvhg00mwRfZFwSkwnr/tCBCYyrZGwpNbvema7KgiG
 Y73J2uhpYzjDRPOji7Zu/4GBGowJioFeECjGPVLngFY0V2xT4RIcl+JepYJffJP4SN6IkWXGFkU
 wQGN5Gan3n8IFRhvyuSpCj0AXMpmS/boHWCzWLgi2qZJTdWBwnJtoVpqoHotqfRW00doBOKn2Q7
 7NAVcnouU7VxW5aI/+H/b1hw6IT4FJU5r6kP+U8fXHTBSu3JfCPtTVhB6LWl478FNqwf6bF6Uei
 gK7DP4mzJO6Y+FC80IzgpKQvbsmlm3d+U0uThQj/G44uVUSEyFRhr2VNg/1kAszGksX040sLdws
 gGqq/m9v1wyS/F3v10TijD
X-Received: by 2002:a05:6a00:218f:b0:848:86cf:267b with SMTP id
 d2e1a72fcca58-84e5959cb48mr4190608b3a.61.1785069003535; 
 Sun, 26 Jul 2026 05:30:03 -0700 (PDT)
Received: from localhost.localdomain ([111.201.4.215])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-84e53426628sm1861647b3a.49.2026.07.26.05.29.58
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 26 Jul 2026 05:30:02 -0700 (PDT)
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
Subject: [PATCH 11/11] hw/ssi: Add trace events for K230 DesignWare SSI
Date: Sun, 26 Jul 2026 20:28:29 +0800
Message-ID: <1342f13a6ea463424245534989fab7840c13eb3f.1785064313.git.flamboyant.h.01@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1785064312.git.flamboyant.h.01@gmail.com>
References: <cover.1785064312.git.flamboyant.h.01@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::42d;
 envelope-from=flamboyant.h.01@gmail.com; helo=mail-pf1-x42d.google.com
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

Add trace events for the K230 DesignWare SSI model covering:

- register accesses using the effective masked or returned value;
- transaction boundaries for standard and enhanced PIO transfers;
- interrupt output levels driven toward the PLIC;
- IDMA start, completion, and AXI error paths; and
- XIP reads with the final returned value.

DR accesses are excluded from register tracing: every FIFO frame
passes through DR, so logging it would drown out everything else
during U-Boot and Linux SPI NOR traffic.

The events avoid tracing individual FIFO data frames so that traces remain
usable during U-Boot and Linux SPI NOR transfers.

The events only observe model behaviour and do not change it.

Signed-off-by: Kangjie Huang <flamboyant.h.01@gmail.com>
---
 hw/ssi/k230_dw_ssi.c | 26 ++++++++++++++++++++++++++
 hw/ssi/trace-events  | 11 +++++++++++
 2 files changed, 37 insertions(+)

diff --git a/hw/ssi/k230_dw_ssi.c b/hw/ssi/k230_dw_ssi.c
index d187e3345a..2bd84a4723 100644
--- a/hw/ssi/k230_dw_ssi.c
+++ b/hw/ssi/k230_dw_ssi.c
@@ -27,6 +27,7 @@
 #include "qemu/log.h"
 #include "qemu/module.h"
 #include "system/dma.h"
+#include "trace.h"
 
 #define K230_DW_SSI_FIFO_CAPACITY 256
 
@@ -285,6 +286,7 @@ static void k230_dw_ssi_write_masked(K230DwSsiState *s, unsigned int reg,
                                      uint32_t value, uint32_t mask)
 {
     s->regs[reg] = (s->regs[reg] & ~mask) | (value & mask);
+    trace_k230_dw_ssi_reg_write(s, reg * sizeof(uint32_t), s->regs[reg]);
 }
 
 static uint32_t k230_dw_ssi_irq_raw_status(K230DwSsiState *s)
@@ -312,6 +314,8 @@ static void k230_dw_ssi_update_irq(K230DwSsiState *s)
                       s->regs[R_IMR] & K230_DW_SSI_IRQ_VALID_MASK;
 
     for (int i = 0; i < K230_DW_SSI_IRQ_COUNT; i++) {
+        trace_k230_dw_ssi_irq_update(
+            s, i, !!(status & k230_dw_ssi_irq_status_mask[i]));
         qemu_set_irq(s->irqs[i], !!(status & k230_dw_ssi_irq_status_mask[i]));
     }
 }
@@ -359,6 +363,11 @@ static void k230_dw_ssi_deselect(K230DwSsiState *s)
         return;
     }
 
+    trace_k230_dw_ssi_transaction_end(
+        s, s->active_cs,
+        FIELD_EX32(s->regs[R_CTRLR0], CTRLR0, TMOD),
+        FIELD_EX32(s->regs[R_CTRLR0], CTRLR0, SPI_FRF),
+        fifo32_num_used(&s->tx_fifo), fifo32_num_used(&s->rx_fifo));
     qemu_irq_raise(s->cs_lines[s->active_cs]);
     s->active_cs = -1;
 }
@@ -380,6 +389,10 @@ static void k230_dw_ssi_select(K230DwSsiState *s, unsigned cs)
     k230_dw_ssi_deselect(s);
     qemu_irq_lower(s->cs_lines[cs]);
     s->active_cs = cs;
+    trace_k230_dw_ssi_transaction_start(
+        s, cs, FIELD_EX32(s->regs[R_CTRLR0], CTRLR0, TMOD),
+        FIELD_EX32(s->regs[R_CTRLR0], CTRLR0, SPI_FRF),
+        fifo32_num_used(&s->tx_fifo), fifo32_num_used(&s->rx_fifo));
 }
 
 static void k230_dw_ssi_update_cs(K230DwSsiState *s)
@@ -776,6 +789,7 @@ static uint64_t k230_dw_ssi_xip_read(void *opaque, hwaddr address,
         value |= (uint64_t)(ssi_transfer(s->spi, 0) & 0xff) << (8 * i);
     }
 
+    trace_k230_dw_ssi_xip_read(s, address, size, value);
     k230_dw_ssi_deselect(s);
     return value;
 }
@@ -907,15 +921,19 @@ static void k230_dw_ssi_try_idma(K230DwSsiState *s)
     s->idma_completed_frames = 0;
 
     if (address > UINT64_MAX - (length - 1)) {
+        trace_k230_dw_ssi_idma_error(s, 0, address);
         k230_dw_ssi_idma_fail(s, "address range");
         return;
     }
 
+    trace_k230_dw_ssi_idma_start(
+        s, command.tmod, command.spi_frf, length, address, command.address);
     buffer = g_malloc(length);
     if (command.tmod == K230_DW_SSI_TMOD_TO) {
         result = dma_memory_read(&address_space_memory, address, buffer,
                                  length, MEMTXATTRS_UNSPECIFIED);
         if (result != MEMTX_OK) {
+            trace_k230_dw_ssi_idma_error(s, 1, address);
             k230_dw_ssi_idma_fail(s, "source");
             return;
         }
@@ -960,6 +978,7 @@ static void k230_dw_ssi_try_idma(K230DwSsiState *s)
         result = dma_memory_write(&address_space_memory, address, buffer,
                                   length, MEMTXATTRS_UNSPECIFIED);
         if (result != MEMTX_OK) {
+            trace_k230_dw_ssi_idma_error(s, 2, address);
             k230_dw_ssi_idma_fail(s, "destination");
             return;
         }
@@ -970,6 +989,7 @@ static void k230_dw_ssi_try_idma(K230DwSsiState *s)
     }
 
     s->idma_completed_frames = length;
+    trace_k230_dw_ssi_idma_done(s, address, length);
     k230_dw_ssi_idma_end(s, R_RISR_DONER_MASK);
 }
 
@@ -1245,6 +1265,7 @@ static uint64_t k230_dw_ssi_read(void *opaque, hwaddr addr, unsigned int size)
     }
 
     if (k230_dw_ssi_is_razwi(addr)) {
+        trace_k230_dw_ssi_reg_read(s, addr, 0);
         return 0;
     }
 
@@ -1334,6 +1355,7 @@ static uint64_t k230_dw_ssi_read(void *opaque, hwaddr addr, unsigned int size)
         break;
     }
 
+    trace_k230_dw_ssi_reg_read(s, addr, value);
     return value;
 }
 
@@ -1352,6 +1374,7 @@ static void k230_dw_ssi_write(void *opaque, hwaddr addr,
     }
 
     if (k230_dw_ssi_is_razwi(addr)) {
+        trace_k230_dw_ssi_reg_write(s, addr, 0);
         return;
     }
 
@@ -1378,10 +1401,12 @@ static void k230_dw_ssi_write(void *opaque, hwaddr addr,
         bool new_enabled = value & R_SSIENR_SSIC_EN_MASK;
 
         if (old_enabled == new_enabled) {
+            trace_k230_dw_ssi_reg_write(s, addr, s->regs[R_SSIENR]);
             return;
         }
 
         s->regs[R_SSIENR] = FIELD_DP32(0, SSIENR, SSIC_EN, new_enabled);
+        trace_k230_dw_ssi_reg_write(s, addr, s->regs[R_SSIENR]);
         if (!new_enabled) {
             k230_dw_ssi_abort_transfer(s);
             s->sleep_status = true;
@@ -1406,6 +1431,7 @@ static void k230_dw_ssi_write(void *opaque, hwaddr addr,
         uint32_t old_ser = s->regs[R_SER];
 
         s->regs[R_SER] = value & MAKE_64BIT_MASK(0, s->num_cs);
+        trace_k230_dw_ssi_reg_write(s, addr, s->regs[R_SER]);
         if (old_ser && !s->regs[R_SER]) {
             k230_dw_ssi_abort_transfer(s);
             break;
diff --git a/hw/ssi/trace-events b/hw/ssi/trace-events
index b9d8648297..873ca3ba51 100644
--- a/hw/ssi/trace-events
+++ b/hw/ssi/trace-events
@@ -62,3 +62,14 @@ allwinner_a10_spi_tx(uint8_t byte) "write 0x%02x"
 allwinner_a10_spi_rx(uint8_t byte) "read 0x%02x"
 allwinner_a10_spi_read(const char* regname, uint32_t value) "reg[%s] => 0x%08x"
 allwinner_a10_spi_write(const char* regname, uint32_t value) "reg[%s] <= 0x%08x"
+
+# k230_dw_ssi.c
+k230_dw_ssi_reg_read(void *dev, uint64_t addr, uint32_t value) "dev=%p addr=0x%" PRIx64 " value=0x%" PRIx32
+k230_dw_ssi_reg_write(void *dev, uint64_t addr, uint32_t value) "dev=%p addr=0x%" PRIx64 " value=0x%" PRIx32
+k230_dw_ssi_irq_update(void *dev, uint32_t irq, uint32_t level) "dev=%p irq=%" PRIu32 " level=%" PRIu32
+k230_dw_ssi_transaction_start(void *dev, uint32_t cs, uint32_t tmod, uint32_t frf, uint32_t tx, uint32_t rx) "dev=%p cs=%" PRIu32 " tmod=%" PRIu32 " frf=%" PRIu32 " tx=%" PRIu32 " rx=%" PRIu32
+k230_dw_ssi_transaction_end(void *dev, uint32_t cs, uint32_t tmod, uint32_t frf, uint32_t tx, uint32_t rx) "dev=%p cs=%" PRIu32 " tmod=%" PRIu32 " frf=%" PRIu32 " tx=%" PRIu32 " rx=%" PRIu32
+k230_dw_ssi_idma_start(void *dev, uint32_t tmod, uint32_t frf, uint32_t frames, uint64_t guest_addr, uint32_t flash_addr) "dev=%p tmod=%" PRIu32 " frf=%" PRIu32 " frames=%" PRIu32 " guest=0x%" PRIx64 " flash=0x%" PRIx32
+k230_dw_ssi_idma_done(void *dev, uint64_t guest_addr, uint32_t frames) "dev=%p guest=0x%" PRIx64 " frames=%" PRIu32
+k230_dw_ssi_idma_error(void *dev, uint32_t stage, uint64_t guest_addr) "dev=%p stage=%" PRIu32 " guest=0x%" PRIx64
+k230_dw_ssi_xip_read(void *dev, uint64_t addr, uint32_t size, uint64_t value) "dev=%p addr=0x%" PRIx64 " size=%" PRIu32 " value=0x%" PRIx64
-- 
2.43.0


