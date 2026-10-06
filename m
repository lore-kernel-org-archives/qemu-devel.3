Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 41114CA5FF1
	for <qemu-devel@archiver.kernel.org>; Wed,  7 Oct 2026 08:38:24 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xEN5k-00074b-Ln; Wed, 07 Oct 2026 04:33:36 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <shentey@gmail.com>) id 1xEHww-0007vm-58
 for qemu-devel@nongnu.org; Tue, 06 Oct 2026 23:04:12 -0400
Received: from mail-ej1-x62f.google.com ([2a00:1450:4864:20::62f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <shentey@gmail.com>) id 1xEHwk-0006Sc-Ak
 for qemu-devel@nongnu.org; Tue, 06 Oct 2026 23:04:06 -0400
Received: by mail-ej1-x62f.google.com with SMTP id
 a640c23a62f3a-c2acc1e170cso201299166b.1
 for <qemu-devel@nongnu.org>; Tue, 06 Oct 2026 19:59:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1791341950; x=1791946750; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=PYKfHPldhWeFOjyIkeLoCzfvceJRidlCUcbU149i39Q=;
 b=Q8hsb6m8HSn5k7bMtZLm/QRjbqODEpA4HbHozIG/p2TqZ8c8kNg7Wb109BWKGEB8BR
 JBUSsbIlONjpgjObVMAS35/9sNYxqdLfc/Ez3uMhCsu9nvbXz54A6nqNN7vqNhrCQKju
 D5C+7RUYXO4gOTOdF6JMzyv8P+8x/NOjYFcwVlKXX4Pk7RDhvxOYeTyN8qkjyF0k/BRv
 dzjhgq69mxQNQUOqI9o434duYvpmtBXbaBhGOPI78mCNu2wgNUOcv9ZmL8nZCWmBkPwr
 9h5dd/m19qyOhg1Os6WTWGi1vkzXkfiH1yThP6xIWLX/eGFVZrxhcJM4EZTWycZbyHK4
 X8Ew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1791341950; x=1791946750;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=PYKfHPldhWeFOjyIkeLoCzfvceJRidlCUcbU149i39Q=;
 b=2sZEjJ9zEJfW465YwngRhlhWgyiXqquyf+wfJ09w3/cnI1WjZbgUkmcWiGqAcVsS7O
 r69H7k5g4K4buz6kzp5ebyFDV4HxVfu5OrcbvG/0t30zlOp98/GNzNaEX67MGiur8N+6
 uO0kAZtouT6D07TMky2tBANX+2p6ozL0IHBp4IQBJIomBN2HuAIQuULL0C9Pix1WQYkA
 maGwNwkE6ckqHdQ9+CNt8rnF89mdlEEYTMI0ipTWvej3Ype9DVJooQQRld2Hg8qwzT+t
 mvRP1VjedUriTwefVkuVcKMYtGCmafmMcA4POtKxcoH5Oc17fEJ2buOIbnDI+KqWs+BG
 u0hg==
X-Gm-Message-State: AFq9FYKuAPLhKGNRKc6JE7o7w8p8VNODBNo1MLNCZKPe3sYxeAp0+1Nx
 Avg6bxh16pEyHdLpqojB5H+kQOsRZED6ArOyDKrO80NUBTYOo60VYt+L9WObPg==
X-Gm-Gg: AYBFou1qJP7/ud/lnqA4Fobh1p1YRwOlFT2HH22VzCXdZv3grzIpsFxZu2NsCwVz+qw
 z4q7EeN61hYxEBLaEt8St5jedcXPQITpOg4EE5AWgGzoGKXMu5Uo1rDkIBSzGAEtqmLr7oY2h4G
 lVfq6qfiGDVmxGNOEjwYpk28uAyJUjXduNNRder7Wj+MUR0PG2kw4kObuMNIqozmQaV0wShUJku
 /FjGarIkOrTkMa0/GOYY9QZq4cCFNid7AWEDj32vCmlTcsLjoLGqJl7rGrABwVBGQ1AApg/CUOC
 AOEiHDu41l64b4R6+zT1dXJvobkk8jcMULkFxLr2sprrABi/ovDmEo7yj4Clm0jtdOCHHOFLXV5
 bLKGh4YPtBvhf4VwRgaehGbXruD37dfte44O+d7nA/yzWKKbJo5G7TPGpPv7Vrl8zfWenY1lqrP
 nB4MzPKyjtcHi4aMI97cetET0uaYkuV9YY3u9vLA6oFIBlFCpJd+OsloDi5/hq7WaiAFgX8mYPy
 4u5Ml80S2Iq0F51rNg/rjmsQmTxzt9eymSnTrIM2k2gp4sj
X-Received: by 2002:a05:6000:40ca:b0:48c:4f83:f42f with SMTP id
 ffacd0b85a97d-48c6d0f432dmr1564943f8f.8.1791279908514; 
 Tue, 06 Oct 2026 02:45:08 -0700 (PDT)
Received: from archlinux (pd95eda80.dip0.t-ipconnect.de. [217.94.218.128])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-48c6faa93fbsm433426f8f.16.2026.10.06.02.45.07
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 06 Oct 2026 02:45:08 -0700 (PDT)
From: Bernhard Beschow <shentey@gmail.com>
To: qemu-devel@nongnu.org
Cc: Zhao Liu <zhao1.liu@intel.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>,
 Christian Speich <c.speich@avm.de>, Bin Meng <bmeng.cn@gmail.com>,
 qemu-block@nongnu.org,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH v5 4/8] hw/sd/sdhci: Don't use bounce buffer for ADMA
Date: Tue,  6 Oct 2026 11:44:43 +0200
Message-ID: <20261006094447.43491-5-shentey@gmail.com>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <20261006094447.43491-1-shentey@gmail.com>
References: <20261006094447.43491-1-shentey@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::62f;
 envelope-from=shentey@gmail.com; helo=mail-ej1-x62f.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
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

From: Christian Speich <c.speich@avm.de>

Currently, ADMA will temporarily store data into a local bounce buffer
when transferring it. This will produce unneeded copies of the data and
limit us to the bounce buffer size for each step.

This patch now maps the requested DMA address and passes this buffer
directly to sdbus_{read,write}_data. This allows to pass much larger
buffers down to increase the performance. sdbus_{read,write}_data is
already able to handle arbitrary length and alignments, so we do not
need to ensure this.

Signed-off-by: Christian Speich <c.speich@avm.de>
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 hw/sd/sdhci.c | 102 +++++++++++++++++++++++++++-----------------------
 1 file changed, 55 insertions(+), 47 deletions(-)

diff --git a/hw/sd/sdhci.c b/hw/sd/sdhci.c
index bd74c60f72..2f52b252ce 100644
--- a/hw/sd/sdhci.c
+++ b/hw/sd/sdhci.c
@@ -852,7 +852,7 @@ static void get_adma_description(SDHCIState *s, ADMADescr *dscr)
 
 static void sdhci_do_adma(SDHCIState *s)
 {
-    unsigned int begin, length;
+    unsigned int length;
     const uint16_t block_size = s->blksize & BLOCK_SIZE_MASK;
     const MemTxAttrs attrs = { .memory = true };
     ADMADescr dscr = {};
@@ -894,66 +894,74 @@ static void sdhci_do_adma(SDHCIState *s)
             if (s->trnmod & SDHC_TRNS_READ) {
                 s->prnsts |= SDHC_DOING_READ;
                 while (length) {
-                    if (s->data_count == 0) {
-                        sdbus_read_data(&s->sdbus, s->fifo_buffer, block_size);
-                    }
-                    begin = s->data_count;
-                    if ((length + begin) < block_size) {
-                        s->data_count = length + begin;
-                        length = 0;
-                     } else {
-                        s->data_count = block_size;
-                        length -= block_size - begin;
-                    }
-                    res = dma_memory_write(s->dma_as, dscr.addr,
-                                           &s->fifo_buffer[begin],
-                                           s->data_count - begin,
-                                           attrs);
-                    if (res != MEMTX_OK) {
+                    dma_addr_t dma_len = length;
+
+                    void *buf = dma_memory_map(s->dma_as, dscr.addr, &dma_len,
+                                               DMA_DIRECTION_FROM_DEVICE,
+                                               attrs);
+
+                    if (buf == NULL) {
+                        res = MEMTX_ERROR;
                         break;
+                    } else {
+                        res = MEMTX_OK;
                     }
-                    dscr.addr += s->data_count - begin;
-                    if (s->data_count == block_size) {
-                        s->data_count = 0;
-                        if (s->trnmod & SDHC_TRNS_BLK_CNT_EN) {
-                            s->blkcnt--;
-                            if (s->blkcnt == 0) {
-                                break;
-                            }
+
+                    sdbus_read_data(&s->sdbus, buf, dma_len);
+                    length -= dma_len;
+                    dscr.addr += dma_len;
+
+                    dma_memory_unmap(s->dma_as, buf, dma_len,
+                                     DMA_DIRECTION_FROM_DEVICE, dma_len);
+
+                    if (s->trnmod & SDHC_TRNS_BLK_CNT_EN) {
+                        size_t transfered = s->data_count + dma_len;
+
+                        s->blkcnt -= transfered / block_size;
+                        s->data_count = transfered % block_size;
+
+                        if (s->blkcnt == 0) {
+                            s->data_count = 0;
+                            break;
                         }
                     }
                 }
             } else {
                 s->prnsts |= SDHC_DOING_WRITE;
                 while (length) {
-                    begin = s->data_count;
-                    if ((length + begin) < block_size) {
-                        s->data_count = length + begin;
-                        length = 0;
-                     } else {
-                        s->data_count = block_size;
-                        length -= block_size - begin;
-                    }
-                    res = dma_memory_read(s->dma_as, dscr.addr,
-                                          &s->fifo_buffer[begin],
-                                          s->data_count - begin,
-                                          attrs);
-                    if (res != MEMTX_OK) {
+                    dma_addr_t dma_len = length;
+
+                    void *buf = dma_memory_map(s->dma_as, dscr.addr, &dma_len,
+                                               DMA_DIRECTION_TO_DEVICE, attrs);
+
+                    if (buf == NULL) {
+                        res = MEMTX_ERROR;
                         break;
+                    } else {
+                        res = MEMTX_OK;
                     }
-                    dscr.addr += s->data_count - begin;
-                    if (s->data_count == block_size) {
-                        sdbus_write_data(&s->sdbus, s->fifo_buffer, block_size);
-                        s->data_count = 0;
-                        if (s->trnmod & SDHC_TRNS_BLK_CNT_EN) {
-                            s->blkcnt--;
-                            if (s->blkcnt == 0) {
-                                break;
-                            }
+
+                    sdbus_write_data(&s->sdbus, buf, dma_len);
+                    length -= dma_len;
+                    dscr.addr += dma_len;
+
+                    dma_memory_unmap(s->dma_as, buf, dma_len,
+                                     DMA_DIRECTION_TO_DEVICE, dma_len);
+
+                    if (s->trnmod & SDHC_TRNS_BLK_CNT_EN) {
+                        size_t transfered = s->data_count + dma_len;
+
+                        s->blkcnt -= transfered / block_size;
+                        s->data_count = transfered % block_size;
+
+                        if (s->blkcnt == 0) {
+                            s->data_count = 0;
+                            break;
                         }
                     }
                 }
             }
+
             if (res != MEMTX_OK) {
                 s->data_count = 0;
                 if (s->errintstsen & SDHC_EISEN_ADMAERR) {
-- 
2.56.0


