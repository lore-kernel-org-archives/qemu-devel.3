Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 26879C25B76
	for <qemu-devel@archiver.kernel.org>; Mon,  3 Jun 2024 05:49:10 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sE0YH-00008q-Ed; Mon, 03 Jun 2024 01:48:13 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <fea.wang@sifive.com>)
 id 1sE0YF-000088-K2
 for qemu-devel@nongnu.org; Mon, 03 Jun 2024 01:48:11 -0400
Received: from mail-pl1-x634.google.com ([2607:f8b0:4864:20::634])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <fea.wang@sifive.com>)
 id 1sE0YD-0005Hs-3C
 for qemu-devel@nongnu.org; Mon, 03 Jun 2024 01:48:11 -0400
Received: by mail-pl1-x634.google.com with SMTP id
 d9443c01a7336-1f4c7b022f8so36082905ad.1
 for <qemu-devel@nongnu.org>; Sun, 02 Jun 2024 22:48:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sifive.com; s=google; t=1717393687; x=1717998487; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=cIMV2nOWBCTz/Oo6LeglZMbxXhMl+MsC5E+aszYQKEM=;
 b=ABMpQgkximJF4pdY0/0yqQ4X1Wq55FXsv8VWPfGkbL0/qi5Tg0g+u7DPtYaLbhFTqZ
 4j/T5yDY8BJ416mk9DCh7i5/p2QZtXpkpdiiSqBu5Wqu8zNtg1jfik7/OXa9sDX3/ELe
 A32jh1f96EITmVeyxQ/RXNPLmWlzF5rKg9sJEo1Gu9gDU6BJF1ZssLpntiAmOqECQwdG
 p5zUdaBOXnd+dYqUAnoTMFtEN+ry89YuYp3fwWgRp11XNiqMldiKnQFqVNYx4pSCvXXf
 /H0vI8NadFGkwEK0TeXCNTH/wX0JDGMjzeGKn21t02mBdO4uuw7M6waqzH731CWRKKNI
 ixjQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1717393687; x=1717998487;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=cIMV2nOWBCTz/Oo6LeglZMbxXhMl+MsC5E+aszYQKEM=;
 b=J76HqRg7vlJfYLv/fQORtA6yyx024rl3PEHWsmit5xMvUZfMFBgPjcPP4jLgPpXyV1
 sS5sbwl+Exq1sacs60PCR7/tK8b6dEZqSK/JBisIS7h33Tj4op6y1reXXzsR3V+m/qJJ
 rADNOOjq4IC/535MfMwdMRNjpS3DW3mFUxLh0CUj4M+P7cpwGkwNoSohgX0xunKtctRI
 2qvIHHweN57PYZCXtVB6uMP2LcdXnM3pOOSIMchMBAKHHaOhmsnKX9L7XbW0oKtN+vE9
 3MNoBM+0Oy51p7PyAGt7Ky5GY6tJYW03lLHDArHAZCuroF3acrRcws4ounqovDunykdu
 XiQw==
X-Gm-Message-State: AOJu0YxoeJi94f6cXIUvjodIDS2gUd0FF0Ivq46xL2XXRvuDjO5a4+85
 EN7Dv7L/dYH3ZllKaxcYoDIvmF9vAPrA14Z5GQ9H9YhdAn42WTrrTPwT+uxNEzLkPSK4rHeh099
 ScqE2xiJKX/pcolEESdUn3Js5we0Acdzca4sQ835KX5YszddvwM6G3Eg0lKOgRx9PRoIsjrRFYj
 ryREzp82KN4il3i0JyaSredeSoxRz/K9XoG5o=
X-Google-Smtp-Source: AGHT+IG9sR3Lbk0P2DrcGCvVv+0dBNBdvurAmpPa/q3lq8CpggaeU1psBMaEZu7/E42HSZVYjCLTrQ==
X-Received: by 2002:a17:903:30cd:b0:1f4:7d47:b889 with SMTP id
 d9443c01a7336-1f6370209femr66241885ad.30.1717393686959; 
 Sun, 02 Jun 2024 22:48:06 -0700 (PDT)
Received: from hsinchu36-syssw02.internal.sifive.com
 (59-124-168-89.hinet-ip.hinet.net. [59.124.168.89])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-1f63241e085sm55824135ad.299.2024.06.02.22.48.05
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 02 Jun 2024 22:48:06 -0700 (PDT)
From: "Fea.Wang" <fea.wang@sifive.com>
To: qemu-devel@nongnu.org,
	qemu-riscv@nongnu.org
Cc: "Edgar E. Iglesias" <edgar.iglesias@gmail.com>,
 Alistair Francis <alistair@alistair23.me>,
 Peter Maydell <peter.maydell@linaro.org>, Jason Wang <jasowang@redhat.com>,
 qemu-arm@nongnu.org (open list:Xilinx Zynq),
 "Fea.Wang" <fea.wang@sifive.com>
Subject: [PATCH 2/4] hw/dma: Break the loop when loading descriptions fails
Date: Mon,  3 Jun 2024 13:52:46 +0800
Message-Id: <20240603055248.3928469-3-fea.wang@sifive.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240603055248.3928469-1-fea.wang@sifive.com>
References: <20240603055248.3928469-1-fea.wang@sifive.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::634;
 envelope-from=fea.wang@sifive.com; helo=mail-pl1-x634.google.com
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

When calling the loading a description function, it should be noticed
that the function may return a failure value. Breaking the loop is one
of the possible ways to handle it.

Signed-off-by: Fea.Wang <fea.wang@sifive.com>
---
 hw/dma/xilinx_axidma.c | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/hw/dma/xilinx_axidma.c b/hw/dma/xilinx_axidma.c
index 4b475e5484..b8ab5a423d 100644
--- a/hw/dma/xilinx_axidma.c
+++ b/hw/dma/xilinx_axidma.c
@@ -291,7 +291,9 @@ static void stream_process_mem2s(struct Stream *s, StreamSink *tx_data_dev,
     }
 
     while (1) {
-        stream_desc_load(s, s->regs[R_CURDESC]);
+        if (MEMTX_OK != stream_desc_load(s, s->regs[R_CURDESC])) {
+            break;
+        }
 
         if (s->desc.status & SDESC_STATUS_COMPLETE) {
             s->regs[R_DMASR] |= DMASR_HALTED;
@@ -348,7 +350,9 @@ static size_t stream_process_s2mem(struct Stream *s, unsigned char *buf,
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


