Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 31322C19F32
	for <qemu-devel@archiver.kernel.org>; Sun,  2 Mar 2025 09:13:46 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tofND-0001EE-6C; Sun, 02 Mar 2025 04:12:35 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jason.chien@sifive.com>)
 id 1tofN3-0001Bm-Ga
 for qemu-devel@nongnu.org; Sun, 02 Mar 2025 04:12:26 -0500
Received: from mail-pl1-x635.google.com ([2607:f8b0:4864:20::635])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <jason.chien@sifive.com>)
 id 1tofN1-0003Iz-T5
 for qemu-devel@nongnu.org; Sun, 02 Mar 2025 04:12:25 -0500
Received: by mail-pl1-x635.google.com with SMTP id
 d9443c01a7336-22185cddbffso76465685ad.1
 for <qemu-devel@nongnu.org>; Sun, 02 Mar 2025 01:12:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sifive.com; s=google; t=1740906741; x=1741511541; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=OtyLrb1aKO9DhjGPwejqW8uHWFAo2HE0XI7GenYT5VA=;
 b=SjnLCIBnAzCGBq+dgVISbHPoODBnD2eoeLpu7+vgLt9CE1Onnp44XEkz8729pv4Tbk
 S28bqri0vMlxR6dDaxZzYtA5uMu5a4hDw27KnZw0YXj6wreGQTqErn5HRuye98fiDL08
 b+Q+vmTaP21YB5X6f2pAJqVkWftNip3v7yFaOCK9kWJJQyLYg2mapzveNKUMydpJLJup
 2BMDTji0nU9iscdIRKOzn3E+HsF58JhhXamjtY6Zyfi2BLB09iTnk3UDfhCqStdeo72u
 9BlZb4TjsDyli9uvJoBo3BUEZ5bnzWY4zwbrzTJCfoIW2C0Nt/368MphZL23Z65VEEbX
 zlhA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1740906741; x=1741511541;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=OtyLrb1aKO9DhjGPwejqW8uHWFAo2HE0XI7GenYT5VA=;
 b=TAKcg4Y+PZFw1MWHkoSRFCWbu5sqCQSvIbXrLOG6tCjik3IGnAi4RelEwexLOIYH7d
 +Ue7bWX2QvIS95Kq5mXk7jf5khdeKhq1SP6PsXDoF8pu1+Kh5mkEVL0ewFck8Jdpauvb
 VDGOADiab1uPkGvT0d5Tv0pDyu1sPCekfV2FtM7VRXh5eJgQoBFnTig8abi5+RMSeHN5
 DawsKGiEZWvkJXepgrWApefysHMnOqz1B80N/4sWdcmfqQhtbmH9C5yw78RWAN0gN5DI
 XBf2pjltDRzGjYBtR6CbJYTkS6Wtl3Z5CRw4BdHjhNsCVVkKzqpYtTlrIoawhqtjpMrn
 6Dsw==
X-Gm-Message-State: AOJu0YzQhCe8S7vcalKAnlTc4YzkYHpl77arXVkjhnFeehIwmYdpwsba
 XNnNgKhhZuNUxlTmwrsFor8EmpdZhPZTR1xZ8kFlUR+2Hr6lkVvG4XHhq1Eswx8dfRVZKLuHor5
 RQ0hBujMwtq4qgwRota1eH/YWgjnHLGSpibYOn4wqHHq+3KNd8u6U/ff+wnEcZjdAeKyWQnRoLk
 twrJfdrAm/FKvq+/Q90KCL4KkyKU+wzDgQYXDWOtQ=
X-Gm-Gg: ASbGnctxLLgRQ2sKitK/yd3QOZEiRDkprCKHpngYd0MoUxe77EG/SsROGZGXJ7pcoPH
 XHW824AgmQ/A3mLMzhHXUbl2zphWiDNBf1XmmF7w3eOzRToTFLLimnK0QizR+3MygqyNQWrow//
 JcAD6rG1VhV/rB13lNp4Dm2+vvbovmfTTn4+dO6ATaa+R/9tdRFjEqi1FoZYTpESxEGGckwn5Fu
 zJcS4UVTQpZiflGPGqOj21vGQxM8RjDTgyEaRkxub2W0hTGXY/WgliuIS/hvHsL4vLFfICWcesk
 C+XE9zY32dqOokuS/PPtcT8FoU++kAup1ryPR7/JDhwEPiW/vgjBCFRCuIMmeg5owDEbyFn9
X-Google-Smtp-Source: AGHT+IEXjGU0kwn2xcJSd0qRW7Na0ZbtDN1x+vk6uFRz5H9gVULuxc56TEu3uVJ4VJ0QmB+B4pYLbg==
X-Received: by 2002:a05:6a00:cd1:b0:736:4d05:2e35 with SMTP id
 d2e1a72fcca58-7364d0530cfmr1248045b3a.3.1740906741135; 
 Sun, 02 Mar 2025 01:12:21 -0800 (PST)
Received: from hsinchu16.internal.sifive.com ([210.176.154.34])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-736310abc8csm2952616b3a.77.2025.03.02.01.12.19
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 02 Mar 2025 01:12:20 -0800 (PST)
From: Jason Chien <jason.chien@sifive.com>
To: qemu-devel@nongnu.org,
	qemu-riscv@nongnu.org
Cc: Palmer Dabbelt <palmer@dabbelt.com>,
 Alistair Francis <alistair.francis@wdc.com>,
 Weiwei Li <liwei1518@gmail.com>,
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>,
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>,
 "Michael S. Tsirkin" <mst@redhat.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Jason Chien <jason.chien@sifive.com>
Subject: [PATCH 1/3] include/hw/pci: Attach BDF to Memory Attributes
Date: Sun,  2 Mar 2025 17:12:07 +0800
Message-ID: <20250302091209.20063-2-jason.chien@sifive.com>
X-Mailer: git-send-email 2.43.2
In-Reply-To: <20250302091209.20063-1-jason.chien@sifive.com>
References: <20250302091209.20063-1-jason.chien@sifive.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::635;
 envelope-from=jason.chien@sifive.com; helo=mail-pl1-x635.google.com
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

This commit adds the BDF to the memory attributes for DMA operations.

Signed-off-by: Jason Chien <jason.chien@sifive.com>
---
 include/hw/pci/pci_device.h | 10 ++++++++--
 1 file changed, 8 insertions(+), 2 deletions(-)

diff --git a/include/hw/pci/pci_device.h b/include/hw/pci/pci_device.h
index add208edfa..968f1ba3e9 100644
--- a/include/hw/pci/pci_device.h
+++ b/include/hw/pci/pci_device.h
@@ -244,6 +244,8 @@ static inline MemTxResult pci_dma_rw(PCIDevice *dev, dma_addr_t addr,
                                      void *buf, dma_addr_t len,
                                      DMADirection dir, MemTxAttrs attrs)
 {
+    attrs.unspecified = 0;
+    attrs.requester_id = pci_requester_id(dev);
     return dma_memory_rw(pci_get_address_space(dev), addr, buf, len,
                          dir, attrs);
 }
@@ -292,6 +294,8 @@ static inline MemTxResult pci_dma_write(PCIDevice *dev, dma_addr_t addr,
                                                uint##_bits##_t *val, \
                                                MemTxAttrs attrs) \
     { \
+        attrs.unspecified = 0; \
+        attrs.requester_id = pci_requester_id(dev); \
         return ld##_l##_dma(pci_get_address_space(dev), addr, val, attrs); \
     } \
     static inline MemTxResult st##_s##_pci_dma(PCIDevice *dev, \
@@ -299,6 +303,8 @@ static inline MemTxResult pci_dma_write(PCIDevice *dev, dma_addr_t addr,
                                                uint##_bits##_t val, \
                                                MemTxAttrs attrs) \
     { \
+        attrs.unspecified = 0; \
+        attrs.requester_id = pci_requester_id(dev); \
         return st##_s##_dma(pci_get_address_space(dev), addr, val, attrs); \
     }
 
@@ -327,8 +333,8 @@ PCI_DMA_DEFINE_LDST(q_be, q_be, 64);
 static inline void *pci_dma_map(PCIDevice *dev, dma_addr_t addr,
                                 dma_addr_t *plen, DMADirection dir)
 {
-    return dma_memory_map(pci_get_address_space(dev), addr, plen, dir,
-                          MEMTXATTRS_UNSPECIFIED);
+    MemTxAttrs attrs = {.requester_id = pci_requester_id(dev)};
+    return dma_memory_map(pci_get_address_space(dev), addr, plen, dir, attrs);
 }
 
 static inline void pci_dma_unmap(PCIDevice *dev, void *buffer, dma_addr_t len,
-- 
2.43.2


