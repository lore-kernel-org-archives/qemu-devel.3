Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 11BD7C25B7E
	for <qemu-devel@archiver.kernel.org>; Tue,  4 Jun 2024 07:11:29 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sEOJZ-0005JW-4V; Tue, 04 Jun 2024 03:10:37 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <fea.wang@sifive.com>)
 id 1sEOJW-0005IJ-Bi
 for qemu-devel@nongnu.org; Tue, 04 Jun 2024 03:10:35 -0400
Received: from mail-pg1-x534.google.com ([2607:f8b0:4864:20::534])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <fea.wang@sifive.com>)
 id 1sEOJT-0000WY-GJ
 for qemu-devel@nongnu.org; Tue, 04 Jun 2024 03:10:32 -0400
Received: by mail-pg1-x534.google.com with SMTP id
 41be03b00d2f7-681bc7f50d0so3745453a12.0
 for <qemu-devel@nongnu.org>; Tue, 04 Jun 2024 00:10:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sifive.com; s=google; t=1717485030; x=1718089830; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Sbuv/MOyNIQ6l5m1LicrtKm3mCmCzjFzQu45Z/Y7Z5s=;
 b=OimBvCpPPeyaFBtPU2hmyFUHI06pyTHUQtoLp5YSv6SYXbxE33SKBQlyk3Z7YFKxWS
 b18jYWVM6fUBaIOCkh1tSGx82kjee81Y2NdSpdgatHcKBvmfVlgveP27XrBa3tbor/30
 SiyEsg8hBKHJJOgMxdhDFDBFo5zg+H945ZTVvHGd2WSAlp8JI6YKI2Xz83nWP6t3VJvy
 0CMJT1E949osNKWd/voDA5gY12xAbEmvlJT6Z9O4bA78NJRbBS63a4qDJkrepycM12Cu
 U4uWmurQH4r+qWYfBjL6LUTMSfplL3xLDDeK15IWj27L9O9EMMNItnrZ7ySpW+979lV6
 OrpA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1717485030; x=1718089830;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Sbuv/MOyNIQ6l5m1LicrtKm3mCmCzjFzQu45Z/Y7Z5s=;
 b=HT1W1NTC3nDOjnlfBQAOsRBL+fX3XioOAOIy5Zflu5AgZSWTHkyHLqSQHmnKgrp1EU
 gUQ8AKeDUkk+2uOJB9/Eex/J2XDvrVKUXs68bE/IO7KcLRO/Lx9temkUnFdDLzYMJ8nA
 yCXTP2AIj4Nmiw27LHncjAMPyZR3BNVneYK2/lOVWt0hb05yUtgk5JRYx2kO8RNk4txZ
 6mXMK2hxvO0Ew9rrs26P1bAswWPBjxtx2oXqyK7KtQdf4ZyPhP8XyPD9NKYj63FWhFgi
 xHixbTXLcDokrdzYHPoc4AhCVboioDOjH8SDbv/hqTo/GwzfVFLcjaCHhm59ucLh+LQD
 Silw==
X-Gm-Message-State: AOJu0YzrzY29H4SUIhl/rBAVilYGAxKGGGnbJ7qQyTTtMLxgj+rWPf1w
 u56caXE8Rtl07VzhuKhzj2+vqPmKMCBLoERh8w99JI2VoXIhBv16r4VCt3cqm3OuLv0E/v5cbK/
 HBXG9AQudWNd85MVW1xr1ieJJ5tcksrN1sO1dw9EA1y707UTz7efoegb9yRMXr1Ckk+0uwx4ZW5
 aBiJApdZIPZotna1Wu+6fKj+UnqDRtGDsl+xc=
X-Google-Smtp-Source: AGHT+IEPgaeswxzBB5snUh1+YbFPKiwckJaobiKav0mUxgKPqYReHYWFGvksxgN4Rkz3isbcm0kcjA==
X-Received: by 2002:a17:90b:4d87:b0:2c1:ad50:5e1b with SMTP id
 98e67ed59e1d1-2c2530789a2mr2691816a91.8.1717485029538; 
 Tue, 04 Jun 2024 00:10:29 -0700 (PDT)
Received: from hsinchu36-syssw02.internal.sifive.com
 (59-124-168-89.hinet-ip.hinet.net. [59.124.168.89])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-2c1a775d68dsm9237943a91.6.2024.06.04.00.10.27
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 04 Jun 2024 00:10:29 -0700 (PDT)
From: "Fea.Wang" <fea.wang@sifive.com>
To: qemu-devel@nongnu.org
Cc: "Edgar E. Iglesias" <edgar.iglesias@gmail.com>,
 Alistair Francis <alistair@alistair23.me>,
 Peter Maydell <peter.maydell@linaro.org>, Jason Wang <jasowang@redhat.com>,
 qemu-arm@nongnu.org (open list:Xilinx Zynq),
 "Fea.Wang" <fea.wang@sifive.com>,
 "Edgar E . Iglesias" <edgar.iglesias@amd.com>,
 Frank Chang <frank.chang@sifive.com>
Subject: [PATCH v2 2/3] hw/dma: Add a trace log for a description loading
 failure
Date: Tue,  4 Jun 2024 15:15:39 +0800
Message-Id: <20240604071540.18138-3-fea.wang@sifive.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240604071540.18138-1-fea.wang@sifive.com>
References: <20240604071540.18138-1-fea.wang@sifive.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::534;
 envelope-from=fea.wang@sifive.com; helo=mail-pg1-x534.google.com
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

Due to a description loading failure, adding a trace log makes observing
the DMA behavior easy.

Signed-off-by: Fea.Wang <fea.wang@sifive.com>
Reviewed-by: Edgar E. Iglesias <edgar.iglesias@amd.com>
Reviewed-by: Frank Chang <frank.chang@sifive.com>
---
 hw/dma/trace-events    | 3 +++
 hw/dma/xilinx_axidma.c | 3 +++
 2 files changed, 6 insertions(+)

diff --git a/hw/dma/trace-events b/hw/dma/trace-events
index 3c47df54e4..95db083be4 100644
--- a/hw/dma/trace-events
+++ b/hw/dma/trace-events
@@ -44,3 +44,6 @@ pl330_debug_exec_stall(void) "stall of debug instruction not implemented"
 pl330_iomem_write(uint32_t offset, uint32_t value) "addr: 0x%08"PRIx32" data: 0x%08"PRIx32
 pl330_iomem_write_clr(int i) "event interrupt lowered %d"
 pl330_iomem_read(uint32_t addr, uint32_t data) "addr: 0x%08"PRIx32" data: 0x%08"PRIx32
+
+# xilinx_axidma.c
+xilinx_axidma_loading_desc_fail(uint32_t res) "error:%d"
diff --git a/hw/dma/xilinx_axidma.c b/hw/dma/xilinx_axidma.c
index ad307994c2..c9cfc3169b 100644
--- a/hw/dma/xilinx_axidma.c
+++ b/hw/dma/xilinx_axidma.c
@@ -36,6 +36,7 @@
 #include "sysemu/dma.h"
 #include "hw/stream.h"
 #include "qom/object.h"
+#include "trace.h"
 
 #define D(x)
 
@@ -201,6 +202,8 @@ static MemTxResult stream_desc_load(struct Stream *s, hwaddr addr)
                                             addr, MEMTXATTRS_UNSPECIFIED,
                                             d, sizeof *d);
     if (result != MEMTX_OK) {
+        trace_xilinx_axidma_loading_desc_fail(result);
+
         if (result == MEMTX_DECODE_ERROR) {
             s->regs[R_DMASR] |= DMASR_DECERR;
         } else {
-- 
2.34.1


