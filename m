Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 26506C25B75
	for <qemu-devel@archiver.kernel.org>; Mon,  3 Jun 2024 05:49:10 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sE0Xx-0008Sf-NX; Mon, 03 Jun 2024 01:47:53 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <fea.wang@sifive.com>)
 id 1sE0Xw-0008RY-6z
 for qemu-devel@nongnu.org; Mon, 03 Jun 2024 01:47:52 -0400
Received: from mail-pl1-x630.google.com ([2607:f8b0:4864:20::630])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <fea.wang@sifive.com>)
 id 1sE0Xt-0005BK-JY
 for qemu-devel@nongnu.org; Mon, 03 Jun 2024 01:47:51 -0400
Received: by mail-pl1-x630.google.com with SMTP id
 d9443c01a7336-1f47f07aceaso23721075ad.0
 for <qemu-devel@nongnu.org>; Sun, 02 Jun 2024 22:47:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sifive.com; s=google; t=1717393668; x=1717998468; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=GEhvW8mMXGFmnN1YikczckSrxHyJV9SouAqt0p1mFPM=;
 b=OV7FobpQpqeLVKtgsJn72Byc/xzLgtjGYN+WnypUL0sG5fIMo+0ECDssba+g4AcKTK
 Jgsolf2cHA+v9u0nGAQYjkiHk/wzvH3/7SvCabVLrRxBABkW6QfVZiFC4vTDBoxhFs5l
 YzW9M4fD6J4rW7sRx2nMDBZEGW1z0IxlvLN5sgcKz97uYbFHXrurQicKSi7M+WXbIq8R
 Col/+CO43qqUqDtsW3vbiY+LXLYrQefnAAgZ3lU3cc7RRDUiC5YxId3g3FbAXsFoz8CP
 44CBb+hLKvUFCgHKy7ggNepaj9nPSDztk5OpHRzO8jvCuzY5DxFtrn6LALtQp+i53+OW
 hc2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1717393668; x=1717998468;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=GEhvW8mMXGFmnN1YikczckSrxHyJV9SouAqt0p1mFPM=;
 b=ZmDxRyNMUg0JAAr0cEUbo06hdKdcRnYwrqozgVjZC6ap1UUltLAbBomZWM2cLUbaPG
 NE/0x012MeIICHfxeMcqIM9LUQIP3tBhpGF5PwNmlGcIFNGlyXzy5h2h9kiKdBWdadzq
 JUlh/W5EoBhTgX77bbRgNEzVSjHjpDaEcxYLO2z94neKDDnOM+bzYjFc1cHEUj/9MWVs
 9YPj9pGGEUQyz5TXKQF4/YKdngaYE41ogDBHD61AP4PxOQTkBXwL+uX3GiYRfYrdf/jK
 0eBXWrnsaotA2LAsqBykFIHTiEru9TALdosPnKY3UkJLro+GpqBzEqYVcIrtI6wrbsKe
 ELKg==
X-Gm-Message-State: AOJu0YxTvBAsxP4+9MhCb4HOTDYyTGPr7n1iOC7DqqFT9XMZyAZN6kOu
 iRYh1eTdge2AOLRP5t3kByQztiLrVMDg2avqh6vV/yoOgFsEKYso5d7fcECrQJuAqz+TWavw2xO
 papFLGHNW7wCpYAeBZVlZfhGY5r9o4pJ6bn/k8s/IauxpIhYck5mb1X+lpI/NYk/Zl7pK2z1LdR
 YHu9jBdlV97qE/M1Ect2mSUMyqp2bnFSAoeE8=
X-Google-Smtp-Source: AGHT+IHmdBM6KFnJn5VK2xewRuucEsqZ8fKEK414IFJ+RE/5x+5oq1s2Q8A+zMWE3drGYrCkgzyjgA==
X-Received: by 2002:a17:902:ea03:b0:1f4:a45b:8429 with SMTP id
 d9443c01a7336-1f636ffde39mr95009475ad.27.1717393667593; 
 Sun, 02 Jun 2024 22:47:47 -0700 (PDT)
Received: from hsinchu36-syssw02.internal.sifive.com
 (59-124-168-89.hinet-ip.hinet.net. [59.124.168.89])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-1f63241e085sm55824135ad.299.2024.06.02.22.47.45
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 02 Jun 2024 22:47:47 -0700 (PDT)
From: "Fea.Wang" <fea.wang@sifive.com>
To: qemu-devel@nongnu.org,
	qemu-riscv@nongnu.org
Cc: "Edgar E. Iglesias" <edgar.iglesias@gmail.com>,
 Alistair Francis <alistair@alistair23.me>,
 Peter Maydell <peter.maydell@linaro.org>, Jason Wang <jasowang@redhat.com>,
 qemu-arm@nongnu.org (open list:Xilinx Zynq),
 "Fea.Wang" <fea.wang@sifive.com>
Subject: [PATCH 1/4] hw/dma: Enhance error handling in loading description
Date: Mon,  3 Jun 2024 13:52:45 +0800
Message-Id: <20240603055248.3928469-2-fea.wang@sifive.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240603055248.3928469-1-fea.wang@sifive.com>
References: <20240603055248.3928469-1-fea.wang@sifive.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::630;
 envelope-from=fea.wang@sifive.com; helo=mail-pl1-x630.google.com
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
the error value.

Signed-off-by: Fea.Wang <fea.wang@sifive.com>
---
 hw/dma/xilinx_axidma.c | 16 ++++++++++++++--
 1 file changed, 14 insertions(+), 2 deletions(-)

diff --git a/hw/dma/xilinx_axidma.c b/hw/dma/xilinx_axidma.c
index 0ae056ed06..4b475e5484 100644
--- a/hw/dma/xilinx_axidma.c
+++ b/hw/dma/xilinx_axidma.c
@@ -71,8 +71,10 @@ enum {
 enum {
     DMASR_HALTED = 1,
     DMASR_IDLE  = 2,
+    DMASR_SLVERR = 1 << 5,
     DMASR_IOC_IRQ  = 1 << 12,
     DMASR_DLY_IRQ  = 1 << 13,
+    DMASR_ERR_IRQ  = 1 << 14,
 
     DMASR_IRQ_MASK = 7 << 12
 };
@@ -190,17 +192,27 @@ static inline int streamid_from_addr(hwaddr addr)
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
+        s->regs[R_DMACR] &= ~DMACR_RUNSTOP;
+        s->regs[R_DMASR] |= DMASR_HALTED;
+        s->regs[R_DMASR] |= DMASR_SLVERR;
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
-- 
2.34.1


