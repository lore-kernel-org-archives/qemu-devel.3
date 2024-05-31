Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 862AFC25B75
	for <qemu-devel@archiver.kernel.org>; Fri, 31 May 2024 12:47:12 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sD1eV-0008HY-C0; Fri, 31 May 2024 08:46:35 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1sD1eT-0008H7-OS
 for qemu-devel@nongnu.org; Fri, 31 May 2024 08:46:33 -0400
Received: from mail-wm1-x32e.google.com ([2a00:1450:4864:20::32e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1sD1eS-0002vQ-3Q
 for qemu-devel@nongnu.org; Fri, 31 May 2024 08:46:33 -0400
Received: by mail-wm1-x32e.google.com with SMTP id
 5b1f17b1804b1-42122ac2f38so11238185e9.1
 for <qemu-devel@nongnu.org>; Fri, 31 May 2024 05:46:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1717159590; x=1717764390; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=KNkb3HO1mvzGdO6PMr4OlLUGGePFzcV+YKoXtQ1aEQw=;
 b=jJ2Dxt+elG1xV10f1wiisVgRyrKsAh2rMAhHlxr6AbD8HnHoKDexktJmrIlFXf/qs6
 9q1pGZXCd3P5oJ0npy1eBvlHiIUQcmYnx+MWI0o/q1vtcXaAWXj4zd57rnzD5ddWHJyp
 CT68oRyYZg4zLSyoQ8fwaWtrqONEoD8BbWU0fjmjLgKiZoq4zruvftlC6ds6gnVVK5pQ
 Bpza0G4j8OD4RYrgbqKtaSov4M4GIaUPcCIN42fPj7b+IOGV3av9sAXsflws9UnEcDWh
 tfiZbXCP+po7U1qccRDXb7N44DBNHqndRR99BBkJ6s97JKAvNaaadoeMiWhizqrJzymm
 vjsA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1717159590; x=1717764390;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=KNkb3HO1mvzGdO6PMr4OlLUGGePFzcV+YKoXtQ1aEQw=;
 b=pzq3+MwVpq9uKbOtvtM5sPYePbetmqCG2sQZhJxLlBZsc+1hzNoJwaNh/UKw4PkXYh
 m63HwEs73XVL/kigtiMP/h14oP+owHOOMp3WO7bCUIp06jL7HultUzjzi+smwVB7Sqw2
 eM66AucphZaJHB9PwnxP7OGltg5YOudHhrQf2aET7P1R9v5Sx2R6ZvJb2ZKQbYFvnbEj
 cI53XauXMvjS/l6bZrGNryTMAjrXVmFRtsxKBU0XLpN4z8Yh2nrU/HK/pMCkaYF9KLsk
 4FjgXc1zOqRwwaoyoORV3eDtsvs/pVT5hnZ+poKJzc4+bweZfMZa4YVY+JrySRE1CgN7
 k3Ew==
X-Forwarded-Encrypted: i=1;
 AJvYcCVaD8pOcFh/CAYsOqcCf/rkhjZDrRIm8QTkK7qPzuIrkytp1HYw9TcFPEGG1HIQB9Jdp5H+lUymu3IwS3po1HocMdNhZVQ=
X-Gm-Message-State: AOJu0YzC7DpgLYwGCEPjkyJu7W7j4fsbz4e6O5Js+G/jk1GWT7qmg60D
 CqGuQdPMNGnrjg2OVdsn7uVhdj//FqOB7tFBYausYpMkc9XVJrtTz6b98F1BWArO252oF4zLOXY
 A
X-Google-Smtp-Source: AGHT+IGhvARVHHgsJ6IATKqYgfllm9tvrphAqMPba4EUZNRz1rcDx452tfSQxn7UiMC2XeU5IhFxEA==
X-Received: by 2002:a05:600c:444e:b0:421:29c0:b6c9 with SMTP id
 5b1f17b1804b1-42129c0b9bbmr35328005e9.12.1717159590354; 
 Fri, 31 May 2024 05:46:30 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [2001:8b0:1d0::2])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-42132471e01sm10905625e9.13.2024.05.31.05.46.29
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 31 May 2024 05:46:29 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-arm@nongnu.org,
	qemu-devel@nongnu.org
Cc: Alistair Francis <alistair@alistair23.me>,
 "Edgar E. Iglesias" <edgar.iglesias@gmail.com>,
 Alexandra Diupina <adiupina@astralinux.ru>
Subject: [PATCH] hw/dma/xlnx_dpdma: Read descriptor into buffer,
 not into pointer-to-buffer
Date: Fri, 31 May 2024 13:46:28 +0100
Message-Id: <20240531124628.476938-1-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32e;
 envelope-from=peter.maydell@linaro.org; helo=mail-wm1-x32e.google.com
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

In fdf029762f501 we factored out the handling of reading and writing
DMA descriptors from guest memory.  Unfortunately we accidentally
made the descriptor-read read the descriptor into the address of the
buffer rather than into the buffer, because we didn't notice we
needed to update the arguments to the dma_memory_read() call. Before
the refactoring, "&desc" is the address of a local struct DPDMADescriptor
variable in xlnx_dpdma_start_operation(), which is the correct target
for the guest-memory-read. But after the refactoring 'desc' is the
"DPDMADescriptor *desc" argument to the new function, and so it is
already an address.

This bug is an overrun of a stack variable, since a pointer is at
most 8 bytes long and we try to read 64 bytes, as well as being
incorrect behaviour.

Pass 'desc' rather than '&desc' as the dma_memory_read() argument
to fix this.

(The same bug is not present in xlnx_dpdma_write_descriptor(),
because there we are writing the descriptor from a local struct
variable "DPDMADescriptor tmp_desc" and so passing &tmp_desc to
dma_memory_write() is correct.)

Spotted by Coverity: CID 1546649

Fixes: fdf029762f50101 ("xlnx_dpdma: fix descriptor endianness bug")
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 hw/dma/xlnx_dpdma.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/hw/dma/xlnx_dpdma.c b/hw/dma/xlnx_dpdma.c
index dde4aeca401..a685bd28bb8 100644
--- a/hw/dma/xlnx_dpdma.c
+++ b/hw/dma/xlnx_dpdma.c
@@ -619,7 +619,7 @@ static MemTxResult xlnx_dpdma_read_descriptor(XlnxDPDMAState *s,
                                               DPDMADescriptor *desc)
 {
     MemTxResult res = dma_memory_read(&address_space_memory, desc_addr,
-                                      &desc, sizeof(DPDMADescriptor),
+                                      desc, sizeof(DPDMADescriptor),
                                       MEMTXATTRS_UNSPECIFIED);
     if (res) {
         return res;
-- 
2.34.1


