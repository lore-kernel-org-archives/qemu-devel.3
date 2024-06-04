Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5069DC25B7E
	for <qemu-devel@archiver.kernel.org>; Tue,  4 Jun 2024 07:11:23 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sEOJY-0005JV-OW; Tue, 04 Jun 2024 03:10:36 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <fea.wang@sifive.com>)
 id 1sEOJU-0005FP-EL
 for qemu-devel@nongnu.org; Tue, 04 Jun 2024 03:10:33 -0400
Received: from mail-pg1-x532.google.com ([2607:f8b0:4864:20::532])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <fea.wang@sifive.com>)
 id 1sEOJR-0000Us-Hb
 for qemu-devel@nongnu.org; Tue, 04 Jun 2024 03:10:32 -0400
Received: by mail-pg1-x532.google.com with SMTP id
 41be03b00d2f7-6c4926bf9bbso2619509a12.2
 for <qemu-devel@nongnu.org>; Tue, 04 Jun 2024 00:10:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sifive.com; s=google; t=1717485027; x=1718089827; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=pKkT300tlD3TQh5kFCyDOARg3WfWGx7ttZZNCCqlZ5k=;
 b=FutteiJlNQtowCt3mYu3lbQkFyvXJgv5grMA5BEiJGehaMgYLGq6GC6wJOuVqMld4N
 0IR8YtF4CyarysAdwvjRb2flTf3W/HOsWwJQkSBYXPOa/k6oUBVUAkYpnOvbq+KFgUdI
 AMhfiVBSNvuoglswVZ58pLaOSjCq+D/XLlhIIhiYvdtP9zbw8yCoXfzMXO6MNLvf5kCc
 hdpon7LEcyUvpyyhrPWvQXsX7J5hFb+pTf311FyVmZygOOS3/eB0NAjmtOh6+8C5n8iW
 DbHiB1W7HILSqBVcmBDUyhIaYf5Pxu72CX50dbX80to/Q9CI6TIwBl4KSAYjqBvjmzF1
 ZLYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1717485027; x=1718089827;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=pKkT300tlD3TQh5kFCyDOARg3WfWGx7ttZZNCCqlZ5k=;
 b=BufPlgZ4Dz9djSwwvsT1cb6ghNnt1goQdeWHigDP1dKNRXmQyRoYGlDbhQ4RmHvr5X
 POZf5qk/770hMl5TXmYP109Ua3mlRM3/5qaWcaTxTn8ae1yPnn8khMnNAiRe0lbBUDNe
 kawBU/4k/ERZcobOxUGgxemZ4VHJRVFfCYyeMpkh/IR8XzPHQ5UKfhUnceaQdS80ayt0
 owmF27a/WMdTBtpPiggN3eDegGMuTUGOez08aERrItSCw1XHh6vHUeNeh0GHrAzFqgOP
 +nPPi7sompSrhoQq4XWPj4YY1I0Pr/ore4eW9HLmAt1x2+owu554iQKkSIFocsCpEcOv
 JFWA==
X-Gm-Message-State: AOJu0YzlG68Ed+0aTEZewYLIwDLk+0XUXcmBfWWs878w7EErZeslD5xL
 qNrhAzizq1YTzsEDk2fR5n6Z+9Dm1XX7A3lBCp0qNMdkD92y7b3uIeRjRIFGyyvEmRO+sAOD/fB
 iUvflW/R+DC0JalhOOLevMyc7SxQxen05mJkHpx9edlsGVmMlvnRt6nYVo0ItVTzBqjE8UdgMwc
 WkkeKMWtn1KPf99MrnZf1LSajrftQfXJXdrFc=
X-Google-Smtp-Source: AGHT+IEph1ovAjNTcsGX4Cf4PHFeYX4SzRN+q4nOM1RvaPQvCCKXZiDzk89z1LY4LiTEyOYTqMkOTg==
X-Received: by 2002:a17:90b:4ac9:b0:2bd:ebd5:8bf0 with SMTP id
 98e67ed59e1d1-2c1dc5d8bbemr10451632a91.42.1717485026681; 
 Tue, 04 Jun 2024 00:10:26 -0700 (PDT)
Received: from hsinchu36-syssw02.internal.sifive.com
 (59-124-168-89.hinet-ip.hinet.net. [59.124.168.89])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-2c1a775d68dsm9237943a91.6.2024.06.04.00.10.24
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 04 Jun 2024 00:10:26 -0700 (PDT)
From: "Fea.Wang" <fea.wang@sifive.com>
To: qemu-devel@nongnu.org
Cc: "Edgar E. Iglesias" <edgar.iglesias@gmail.com>,
 Alistair Francis <alistair@alistair23.me>,
 Peter Maydell <peter.maydell@linaro.org>, Jason Wang <jasowang@redhat.com>,
 qemu-arm@nongnu.org (open list:Xilinx Zynq),
 "Fea.Wang" <fea.wang@sifive.com>, Frank Chang <frank.chang@sifive.com>
Subject: [PATCH v2 1/3] hw/dma: Enhance error handling in loading description
Date: Tue,  4 Jun 2024 15:15:38 +0800
Message-Id: <20240604071540.18138-2-fea.wang@sifive.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240604071540.18138-1-fea.wang@sifive.com>
References: <20240604071540.18138-1-fea.wang@sifive.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::532;
 envelope-from=fea.wang@sifive.com; helo=mail-pg1-x532.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=unavailable autolearn_force=no
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

Loading a description from memory may cause a bus-error. In this
case, the DMA should stop working, set the error flag, and return
the failure value.

When calling the loading a description function, it should be noticed
that the function may return a failure value. Breaking the loop in this
case is one of the possible ways to handle it.

Signed-off-by: Fea.Wang <fea.wang@sifive.com>
Reviewed-by: Frank Chang <frank.chang@sifive.com>
---
 hw/dma/xilinx_axidma.c | 30 ++++++++++++++++++++++++++----
 1 file changed, 26 insertions(+), 4 deletions(-)

diff --git a/hw/dma/xilinx_axidma.c b/hw/dma/xilinx_axidma.c
index 0ae056ed06..ad307994c2 100644
--- a/hw/dma/xilinx_axidma.c
+++ b/hw/dma/xilinx_axidma.c
@@ -71,8 +71,11 @@ enum {
 enum {
     DMASR_HALTED = 1,
     DMASR_IDLE  = 2,
+    DMASR_SLVERR = 1 << 5,
+    DMASR_DECERR = 1 << 6,
     DMASR_IOC_IRQ  = 1 << 12,
     DMASR_DLY_IRQ  = 1 << 13,
+    DMASR_ERR_IRQ  = 1 << 14,
 
     DMASR_IRQ_MASK = 7 << 12
 };
@@ -190,17 +193,32 @@ static inline int streamid_from_addr(hwaddr addr)
     return sid;
 }
 
-static void stream_desc_load(struct Stream *s, hwaddr addr)
+static MemTxResult stream_desc_load(struct Stream *s, hwaddr addr)
 {
     struct SDesc *d = &s->desc;
 
-    address_space_read(&s->dma->as, addr, MEMTXATTRS_UNSPECIFIED, d, sizeof *d);
+    MemTxResult result = address_space_read(&s->dma->as,
+                                            addr, MEMTXATTRS_UNSPECIFIED,
+                                            d, sizeof *d);
+    if (result != MEMTX_OK) {
+        if (result == MEMTX_DECODE_ERROR) {
+            s->regs[R_DMASR] |= DMASR_DECERR;
+        } else {
+            s->regs[R_DMASR] |= DMASR_SLVERR;
+        }
+
+        s->regs[R_DMACR] &= ~DMACR_RUNSTOP;
+        s->regs[R_DMASR] |= DMASR_HALTED;
+        s->regs[R_DMASR] |= DMASR_ERR_IRQ;
+        return result;
+    }
 
     /* Convert from LE into host endianness.  */
     d->buffer_address = le64_to_cpu(d->buffer_address);
     d->nxtdesc = le64_to_cpu(d->nxtdesc);
     d->control = le32_to_cpu(d->control);
     d->status = le32_to_cpu(d->status);
+    return result;
 }
 
 static void stream_desc_store(struct Stream *s, hwaddr addr)
@@ -279,7 +297,9 @@ static void stream_process_mem2s(struct Stream *s, StreamSink *tx_data_dev,
     }
 
     while (1) {
-        stream_desc_load(s, s->regs[R_CURDESC]);
+        if (MEMTX_OK != stream_desc_load(s, s->regs[R_CURDESC])) {
+            break;
+        }
 
         if (s->desc.status & SDESC_STATUS_COMPLETE) {
             s->regs[R_DMASR] |= DMASR_HALTED;
@@ -336,7 +356,9 @@ static size_t stream_process_s2mem(struct Stream *s, unsigned char *buf,
     }
 
     while (len) {
-        stream_desc_load(s, s->regs[R_CURDESC]);
+        if (MEMTX_OK != stream_desc_load(s, s->regs[R_CURDESC])) {
+            break;
+        }
 
         if (s->desc.status & SDESC_STATUS_COMPLETE) {
             s->regs[R_DMASR] |= DMASR_HALTED;
-- 
2.34.1


