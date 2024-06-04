Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9B551C25B7E
	for <qemu-devel@archiver.kernel.org>; Tue,  4 Jun 2024 09:59:37 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sEQwJ-0007QF-OI; Tue, 04 Jun 2024 05:58:47 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sEQwI-0007Ez-Cb
 for qemu-devel@nongnu.org; Tue, 04 Jun 2024 05:58:46 -0400
Received: from mail-wm1-x336.google.com ([2a00:1450:4864:20::336])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sEQwG-0002LO-90
 for qemu-devel@nongnu.org; Tue, 04 Jun 2024 05:58:45 -0400
Received: by mail-wm1-x336.google.com with SMTP id
 5b1f17b1804b1-42134bb9735so29710245e9.1
 for <qemu-devel@nongnu.org>; Tue, 04 Jun 2024 02:58:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1717495122; x=1718099922; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=2xJYxwlPHFAuhiLDRZkfUXQ6zjFldlOAPPa4Gg5JdMk=;
 b=Kg4SYeE+81ZHVI/OjjQdnyDC1cEVEl7ZOYYhoyx2G5ugbA1zYEHp6MvCtiH9Yp7pWH
 CiUCG8agC02dx+wx0C/gMa7lEPp5cSAzOeuyJwO/q5ip0MamoaUUCCkaGyYb6UcHeFbn
 yFFk4Uj6h8RoshSfMNZ95SJndc6Og1yWSWPMd/5btbFyWQ+ITpIkKjxy9JjzQ8LfPSMJ
 8HFPuzttcJqaV7bgAyPFL1veDurCsKCkKH5KkWNRmXwvvNOkHGJk/UX/lEmc3KgMgMKo
 NR1rhnMaAMNEMVBrvu6eXbLKVXGk/m6vj1Kk95WKLBWkZSoXJaMfmufwjpRcJN1GkwhD
 D1MA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1717495122; x=1718099922;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=2xJYxwlPHFAuhiLDRZkfUXQ6zjFldlOAPPa4Gg5JdMk=;
 b=Wssf/MjEkXdvsWzpfe58qN/bWX62OY9yGIUVWEk98rfU4dMYC55NDSakV3lGUG0ka5
 jIdIzboq94+bOkzreAAhhXl11xnk/87q48VSJgMGh1/mlGrdKt50KxQ0eojYlYJzijaT
 UMdhi6hnAmHRiaeWN4dQNU9Tf+GCG3yYqLH8tUdNUmF5HbxxGZ9RXlBYc9oMKOAx/NuI
 uGCMhFBDCqfBX95Hv0zv0oBgEF60QEdoZ79UpJykFRbkhVTtv7J/DThwOZ/b1mMRr/J9
 LGUFvw0T5t+GKr7bKoaWhc+uCDC/STs4xKhSa9pxyPLKvPoaBlNGZO9eT40V9KJi+yGn
 0BsQ==
X-Gm-Message-State: AOJu0Yyhtg2cPNvnwdhOnvVSmiUMsMGPGoFn4XU0M87c1HD7UEyish89
 xqgTJQkaA5/UOnms29YMYEx/MCZ9SE15qLNvG2VsLRZ0wgXUvM3tV+7gZ/gnuyN1QWmNqk8wdDv
 1
X-Google-Smtp-Source: AGHT+IGXYO5WgcV76r2okXv1SIz5QZc9EfEaCRwCvct+pMZdg0fDNclY/39UOOdYBXmVYxeJySJV+g==
X-Received: by 2002:a05:600c:4f8d:b0:41b:85bf:f3a8 with SMTP id
 5b1f17b1804b1-42138622459mr60251755e9.35.1717495122078; 
 Tue, 04 Jun 2024 02:58:42 -0700 (PDT)
Received: from m1x-phil.lan ([176.176.159.34])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-42133d745aasm128622335e9.38.2024.06.04.02.58.41
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Tue, 04 Jun 2024 02:58:41 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>,
 "Edgar E . Iglesias" <edgar.iglesias@amd.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PULL 28/32] hw/dma/xlnx_dpdma: Read descriptor into buffer,
 not into pointer-to-buffer
Date: Tue,  4 Jun 2024 11:56:04 +0200
Message-ID: <20240604095609.12285-29-philmd@linaro.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20240604095609.12285-1-philmd@linaro.org>
References: <20240604095609.12285-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::336;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x336.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
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

From: Peter Maydell <peter.maydell@linaro.org>

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
Reviewed-by: Edgar E. Iglesias <edgar.iglesias@amd.com>
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Message-ID: <20240531124628.476938-1-peter.maydell@linaro.org>
Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 hw/dma/xlnx_dpdma.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/hw/dma/xlnx_dpdma.c b/hw/dma/xlnx_dpdma.c
index dde4aeca40..a685bd28bb 100644
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
2.41.0


