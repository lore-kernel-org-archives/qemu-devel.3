Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D8BECC27C4F
	for <qemu-devel@archiver.kernel.org>; Tue, 18 Jun 2024 15:50:23 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sJb5g-0003Cj-Sq; Tue, 18 Jun 2024 11:49:48 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <edgar.iglesias@gmail.com>)
 id 1sJb5e-0003BM-JF; Tue, 18 Jun 2024 11:49:46 -0400
Received: from mail-lj1-x22d.google.com ([2a00:1450:4864:20::22d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <edgar.iglesias@gmail.com>)
 id 1sJb5c-0004sd-Uf; Tue, 18 Jun 2024 11:49:46 -0400
Received: by mail-lj1-x22d.google.com with SMTP id
 38308e7fff4ca-2ec1ac1aed2so43807841fa.3; 
 Tue, 18 Jun 2024 08:49:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1718725783; x=1719330583; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=AfiianYgOnEkXrIoFJQhOr0kIjrM7N1rg2F+4S9qH8g=;
 b=S6sKHu4X6J7Aac17W5ysKe1FdBioZUFoHdVuq7kzhIA+4iJgsEI/1oPhLxfGKN4ztt
 tjzkgNt7A4AkLEd50qj/hG993n64t8yUljlpAeSApLudfkh6aaPhdpl07tDwjt1a1eo/
 x7eAa9U49IGBXHZOHe5COVM9Z+1LG28ZNAiMB316Aou7eRlcq+9B9miRcwziDvdrpM0/
 ZwD3RP7Vkjs9qXUkLLyI8BqV5J4rMs8uwJ2nKuLKp7Sxqdl9KS2D/yN1TP1FpsrfJAOC
 rkOiYB/PwW0sWsQ43GyVa4zzxnRkrWM4BheV1zaSBfZTAeslmLUfafxqK6OOrYvAnxLI
 EFMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1718725783; x=1719330583;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=AfiianYgOnEkXrIoFJQhOr0kIjrM7N1rg2F+4S9qH8g=;
 b=GMNgbvWq9Iwp0Mr+2CvyrNvSYuvnQNV/bRqmEfYmhhdN9peRC408xSdvhbZOjXpq8B
 4uBMECfgPYUxsy5j8r34XwabkLPSWAx/0Pdfb/O9cwoIXDO/jO8XOKhZbCK9EkksJUMu
 hrTFQ37X/69tonGxkZ889SNCGOVh4hchfEQIJXRmmYJK60Znq1X8VnbtzgxT+bR9cfVf
 hW1fXy5+hF4eACbapv6KlovYVeGKtew4HWnzyQifo+X7vhnaSvCsyVaFfpEyBwKTfUdm
 fa8xh8aLcE0A9IYlXLQWigQ0icjROLu74fAj8k8+r53U5Zp7lKj8ABbyPptMPVfyfBS8
 FEfQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCVrWHkl8qyJWaR4DteLaK6G67vjmg/Ru35Zsg+OA3ca2ghirWQWN4AYgNUUBd9sENgAno1RzQ00QwadPOOHThpFfcWu
X-Gm-Message-State: AOJu0YxLujgTcabowancOS2huprRvB9uZHp4EgFj4vztG7ScVsuiKmVG
 vvWwSKemNYWhSx9AcJkEOWVetl39EDv72fQu90V3siCSJC1oJ/dEg8bCrUNaAQ4FtA==
X-Google-Smtp-Source: AGHT+IGjmJhwiyiE34mjU/5PYVqhYmAJ/rE5+rK6s0FHX8HgamP3P6dn0evwNxD95uJnWaI+eyKnUQ==
X-Received: by 2002:a19:4311:0:b0:51d:4595:3527 with SMTP id
 2adb3069b0e04-52ccaa5a38cmr15647e87.61.1718725782569; 
 Tue, 18 Jun 2024 08:49:42 -0700 (PDT)
Received: from gmail.com (213-67-3-247-no600.tbcn.telia.com. [213.67.3.247])
 by smtp.gmail.com with ESMTPSA id
 2adb3069b0e04-52ca282567bsm1532581e87.54.2024.06.18.08.49.41
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 18 Jun 2024 08:49:41 -0700 (PDT)
From: "Edgar E. Iglesias" <edgar.iglesias@gmail.com>
To: qemu-devel@nongnu.org
Cc: richard.henderson@linaro.org, edgar.iglesias@amd.com,
 "Fea.Wang" <fea.wang@sifive.com>, Frank Chang <frank.chang@sifive.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 "Edgar E. Iglesias" <edgar.iglesias@gmail.com>,
 Alistair Francis <alistair@alistair23.me>,
 Peter Maydell <peter.maydell@linaro.org>, qemu-arm@nongnu.org
Subject: [PULL v1 2/3] hw/dma: Add a trace log for a description loading
 failure
Date: Tue, 18 Jun 2024 17:49:34 +0200
Message-ID: <20240618154935.203544-3-edgar.iglesias@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240618154935.203544-1-edgar.iglesias@gmail.com>
References: <20240618154935.203544-1-edgar.iglesias@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::22d;
 envelope-from=edgar.iglesias@gmail.com; helo=mail-lj1-x22d.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

From: "Fea.Wang" <fea.wang@sifive.com>

Due to a description loading failure, adding a trace log makes observing
the DMA behavior easy.

Signed-off-by: Fea.Wang <fea.wang@sifive.com>
Reviewed-by: Edgar E. Iglesias <edgar.iglesias@amd.com>
Reviewed-by: Frank Chang <frank.chang@sifive.com>
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Signed-off-by: Edgar E. Iglesias <edgar.iglesias@amd.com>
---
 hw/dma/trace-events    | 3 +++
 hw/dma/xilinx_axidma.c | 3 +++
 2 files changed, 6 insertions(+)

diff --git a/hw/dma/trace-events b/hw/dma/trace-events
index 3c47df54e4..4c09790f9a 100644
--- a/hw/dma/trace-events
+++ b/hw/dma/trace-events
@@ -44,3 +44,6 @@ pl330_debug_exec_stall(void) "stall of debug instruction not implemented"
 pl330_iomem_write(uint32_t offset, uint32_t value) "addr: 0x%08"PRIx32" data: 0x%08"PRIx32
 pl330_iomem_write_clr(int i) "event interrupt lowered %d"
 pl330_iomem_read(uint32_t addr, uint32_t data) "addr: 0x%08"PRIx32" data: 0x%08"PRIx32
+
+# xilinx_axidma.c
+xilinx_axidma_loading_desc_fail(uint32_t res) "error:%u"
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
2.43.0


