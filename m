Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4E710C3DA63
	for <qemu-devel@archiver.kernel.org>; Fri, 26 Jul 2024 06:01:13 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sXDzb-0001KP-6p; Fri, 26 Jul 2024 01:59:51 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jim.shu@sifive.com>)
 id 1sXDzZ-0001EP-Rc
 for qemu-devel@nongnu.org; Fri, 26 Jul 2024 01:59:49 -0400
Received: from mail-pf1-x434.google.com ([2607:f8b0:4864:20::434])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <jim.shu@sifive.com>)
 id 1sXDzY-0006h9-2D
 for qemu-devel@nongnu.org; Fri, 26 Jul 2024 01:59:49 -0400
Received: by mail-pf1-x434.google.com with SMTP id
 d2e1a72fcca58-70d2e68f5a8so501576b3a.3
 for <qemu-devel@nongnu.org>; Thu, 25 Jul 2024 22:59:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sifive.com; s=google; t=1721973586; x=1722578386; darn=nongnu.org;
 h=references:in-reply-to:message-id:date:subject:cc:to:from:from:to
 :cc:subject:date:message-id:reply-to;
 bh=JXlEGPL9thPPk61Tbq7dliSQC6vKn0rJatKn3l6TSro=;
 b=mv7R1nu4jAtErBkm8SMqp2EsuaTRBYS7xme89MqrjJHV7b5X+/zlYggnu00MxYUi29
 uIj+/t4bQ/Hqn5L0CPoC3TC8jmGm9OPGPJFDCTk7zW8hBNRbhB9iTHSCXOUNbCu98kSY
 2IWK8d9o4YnGf/I7C3nh9dmuHJENAYz3Ksq2pBxWLT6pAUd555xR+dmzRFhLxcRO+31x
 EdwC54sNP5q42ZE/v6mUkp4d3MmjkPxNLlN6m2MSI5g8NOx5hQwX33C7NgLSTABiM47j
 nNGjNL7jxe5IZ7gSzwJV+VpYl5ay+5pBskxD91k5zHL+z/UDzQ7jhPhfGW9hJLchnSoa
 KFBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1721973586; x=1722578386;
 h=references:in-reply-to:message-id:date:subject:cc:to:from
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=JXlEGPL9thPPk61Tbq7dliSQC6vKn0rJatKn3l6TSro=;
 b=eyascEOLIEG1d6soroiHl91lceNxK9/vtClG/UBl1a8JiXU7NHEZOgChkA/IcVrD0/
 ZPoz32NL3GRM2K+hZ5q1510Oq8gxsDQaUxrCf1oUqItp9t00JggBmWTpg7SkDhVuHavX
 4TC7WZLt69G2/ya04lxWPYC3IjzgIdj9sepfi0RkOxsi91pLfxw8kjnL3F4oNtQRtyOG
 fy4M3jXJ2ND79bTS4PTRxxlvFgUho0AtvJ1AgiZNIMI3zXZDRqVnocQMzn2IeAXvba01
 V42CtQAxXuIj0FUMpTgLK+CKRcuslkTfcgML/ulSf8LpcO52UnTIYmgQYJVkLt2YVelr
 ovCA==
X-Gm-Message-State: AOJu0Yzkfa+PC8UO1lQnQv2dwh9PTUIl7z7pZZRx3Fp/ML2AcJGk5n62
 N4QbXA+FBsO/3KCku031Yvl0dBIXKwepbeUMMvuRztVkzsbyJnxPQfsp6ryq+jrUUrWfWMqRf79
 ukDXgCKYuyz0PK4CC8BqBw5cMIn62MUbZc9LFKg7T64B2dOoYe8Hds03hB1/rLg18taDVXabItb
 TG1fx6pc8GiPoeYo2KHUM7bUp3momit/15/A==
X-Google-Smtp-Source: AGHT+IFjJ4CT/1XgiByKatIhqApZ0KVPGcBShByypRWOzDMw6FtU3tA58vo5x2Ta/Lm9SpkCX+TM9w==
X-Received: by 2002:a05:6a00:a1e:b0:70d:22b5:5420 with SMTP id
 d2e1a72fcca58-70eae906bb6mr5235617b3a.15.1721973585601; 
 Thu, 25 Jul 2024 22:59:45 -0700 (PDT)
Received: from hsinchu26.internal.sifive.com
 (59-124-168-89.hinet-ip.hinet.net. [59.124.168.89])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-70ead6e1a4bsm2002128b3a.5.2024.07.25.22.59.43
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 25 Jul 2024 22:59:45 -0700 (PDT)
From: Jim Shu <jim.shu@sifive.com>
To: qemu-devel@nongnu.org
Cc: "Edgar E. Iglesias" <edgar.iglesias@gmail.com>,
 Alistair Francis <alistair@alistair23.me>,
 Peter Maydell <peter.maydell@linaro.org>, Jason Wang <jasowang@redhat.com>,
 qemu-arm@nongnu.org (open list:Xilinx Zynq), Jim Shu <jim.shu@sifive.com>
Subject: [PATCH 2/4] hw/dma: xilinx_axidma: Send DMA error IRQ if any memory
 access is failed
Date: Fri, 26 Jul 2024 13:59:31 +0800
Message-Id: <20240726055933.817-3-jim.shu@sifive.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20240726055933.817-1-jim.shu@sifive.com>
References: <20240726055933.817-1-jim.shu@sifive.com>
Received-SPF: pass client-ip=2607:f8b0:4864:20::434;
 envelope-from=jim.shu@sifive.com; helo=mail-pf1-x434.google.com
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

The memory transactions from DMA could have bus-error in some cases. If
it is failed, DMA device should send error IRQs.

Signed-off-by: Jim Shu <jim.shu@sifive.com>
---
 hw/dma/trace-events    |  1 +
 hw/dma/xilinx_axidma.c | 69 ++++++++++++++++++++++++++++++------------
 2 files changed, 50 insertions(+), 20 deletions(-)

diff --git a/hw/dma/trace-events b/hw/dma/trace-events
index 4c09790f9a..7db38e0e93 100644
--- a/hw/dma/trace-events
+++ b/hw/dma/trace-events
@@ -47,3 +47,4 @@ pl330_iomem_read(uint32_t addr, uint32_t data) "addr: 0x%08"PRIx32" data: 0x%08"
 
 # xilinx_axidma.c
 xilinx_axidma_loading_desc_fail(uint32_t res) "error:%u"
+xilinx_axidma_storing_desc_fail(uint32_t res) "error:%u"
diff --git a/hw/dma/xilinx_axidma.c b/hw/dma/xilinx_axidma.c
index 6aa8c9272c..728246f925 100644
--- a/hw/dma/xilinx_axidma.c
+++ b/hw/dma/xilinx_axidma.c
@@ -194,6 +194,20 @@ static inline int streamid_from_addr(hwaddr addr)
     return sid;
 }
 
+/* When DMA is error, fill in the register of this Stream. */
+static void stream_dma_error(struct Stream *s, MemTxResult result)
+{
+    if (result == MEMTX_DECODE_ERROR) {
+        s->regs[R_DMASR] |= DMASR_DECERR;
+    } else {
+        s->regs[R_DMASR] |= DMASR_SLVERR;
+    }
+
+    s->regs[R_DMACR] &= ~DMACR_RUNSTOP;
+    s->regs[R_DMASR] |= DMASR_HALTED;
+    s->regs[R_DMASR] |= DMASR_ERR_IRQ;
+}
+
 static MemTxResult stream_desc_load(struct Stream *s, hwaddr addr)
 {
     struct SDesc *d = &s->desc;
@@ -203,16 +217,7 @@ static MemTxResult stream_desc_load(struct Stream *s, hwaddr addr)
                                             d, sizeof *d);
     if (result != MEMTX_OK) {
         trace_xilinx_axidma_loading_desc_fail(result);
-
-        if (result == MEMTX_DECODE_ERROR) {
-            s->regs[R_DMASR] |= DMASR_DECERR;
-        } else {
-            s->regs[R_DMASR] |= DMASR_SLVERR;
-        }
-
-        s->regs[R_DMACR] &= ~DMACR_RUNSTOP;
-        s->regs[R_DMASR] |= DMASR_HALTED;
-        s->regs[R_DMASR] |= DMASR_ERR_IRQ;
+        stream_dma_error(s, result);
         return result;
     }
 
@@ -224,17 +229,24 @@ static MemTxResult stream_desc_load(struct Stream *s, hwaddr addr)
     return result;
 }
 
-static void stream_desc_store(struct Stream *s, hwaddr addr)
+static MemTxResult stream_desc_store(struct Stream *s, hwaddr addr)
 {
     struct SDesc *d = &s->desc;
+    MemTxResult result;
 
     /* Convert from host endianness into LE.  */
     d->buffer_address = cpu_to_le64(d->buffer_address);
     d->nxtdesc = cpu_to_le64(d->nxtdesc);
     d->control = cpu_to_le32(d->control);
     d->status = cpu_to_le32(d->status);
-    address_space_write(&s->dma->as, addr, MEMTXATTRS_UNSPECIFIED,
-                        d, sizeof *d);
+    result = address_space_write(&s->dma->as, addr, MEMTXATTRS_UNSPECIFIED,
+                                 d, sizeof *d);
+
+    if (result != MEMTX_OK) {
+        trace_xilinx_axidma_storing_desc_fail(result);
+        stream_dma_error(s, result);
+    }
+    return result;
 }
 
 static void stream_update_irq(struct Stream *s)
@@ -294,6 +306,7 @@ static void stream_process_mem2s(struct Stream *s, StreamSink *tx_data_dev,
     uint32_t txlen, origin_txlen;
     uint64_t addr;
     bool eop;
+    MemTxResult result;
 
     if (!stream_running(s) || stream_idle(s) || stream_halted(s)) {
         return;
@@ -322,9 +335,14 @@ static void stream_process_mem2s(struct Stream *s, StreamSink *tx_data_dev,
             unsigned int len;
 
             len = txlen > sizeof s->txbuf ? sizeof s->txbuf : txlen;
-            address_space_read(&s->dma->as, addr,
-                               MEMTXATTRS_UNSPECIFIED,
-                               s->txbuf, len);
+            result = address_space_read(&s->dma->as, addr,
+                                        MEMTXATTRS_UNSPECIFIED,
+                                        s->txbuf, len);
+            if (result != MEMTX_OK) {
+                stream_dma_error(s, result);
+                return;
+            }
+
             stream_push(tx_data_dev, s->txbuf, len, eop && len == txlen);
             txlen -= len;
             addr += len;
@@ -336,7 +354,9 @@ static void stream_process_mem2s(struct Stream *s, StreamSink *tx_data_dev,
 
         /* Update the descriptor.  */
         s->desc.status = origin_txlen | SDESC_STATUS_COMPLETE;
-        stream_desc_store(s, s->regs[R_CURDESC]);
+        if (stream_desc_store(s, s->regs[R_CURDESC]) != MEMTX_OK) {
+            break;
+        }
 
         /* Advance.  */
         prev_d = s->regs[R_CURDESC];
@@ -354,6 +374,7 @@ static size_t stream_process_s2mem(struct Stream *s, unsigned char *buf,
     uint32_t prev_d;
     unsigned int rxlen;
     size_t pos = 0;
+    MemTxResult result;
 
     if (!stream_running(s) || stream_idle(s) || stream_halted(s)) {
         return 0;
@@ -375,8 +396,13 @@ static size_t stream_process_s2mem(struct Stream *s, unsigned char *buf,
             rxlen = len;
         }
 
-        address_space_write(&s->dma->as, s->desc.buffer_address,
-                            MEMTXATTRS_UNSPECIFIED, buf + pos, rxlen);
+        result = address_space_write(&s->dma->as, s->desc.buffer_address,
+                                     MEMTXATTRS_UNSPECIFIED, buf + pos, rxlen);
+        if (result != MEMTX_OK) {
+            stream_dma_error(s, result);
+            break;
+        }
+
         len -= rxlen;
         pos += rxlen;
 
@@ -389,7 +415,10 @@ static size_t stream_process_s2mem(struct Stream *s, unsigned char *buf,
 
         s->desc.status |= s->sof << SDESC_STATUS_SOF_BIT;
         s->desc.status |= SDESC_STATUS_COMPLETE;
-        stream_desc_store(s, s->regs[R_CURDESC]);
+        result = stream_desc_store(s, s->regs[R_CURDESC]);
+        if (result != MEMTX_OK) {
+            break;
+        }
         s->sof = eop;
 
         /* Advance.  */
-- 
2.17.1


