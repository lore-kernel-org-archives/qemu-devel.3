Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 86956C2D0D1
	for <qemu-devel@archiver.kernel.org>; Mon, 24 Jun 2024 20:20:30 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sLqA8-00054N-DG; Mon, 24 Jun 2024 16:19:40 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dbarboza@ventanamicro.com>)
 id 1sLqA7-0004w8-9x
 for qemu-devel@nongnu.org; Mon, 24 Jun 2024 16:19:39 -0400
Received: from mail-pf1-x42d.google.com ([2607:f8b0:4864:20::42d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <dbarboza@ventanamicro.com>)
 id 1sLqA5-0003jz-NH
 for qemu-devel@nongnu.org; Mon, 24 Jun 2024 16:19:39 -0400
Received: by mail-pf1-x42d.google.com with SMTP id
 d2e1a72fcca58-70666aceb5bso1906899b3a.1
 for <qemu-devel@nongnu.org>; Mon, 24 Jun 2024 13:19:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=ventanamicro.com; s=google; t=1719260376; x=1719865176; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=SYHhEoV3vydSIfLIXvEJm/GFH7lO17Epc6zzzdv2Yds=;
 b=PmR6BhAJM56CDDlm1GNkoj7Zhp4YxZIf2zmKPROHPiXh2dO9nV9VXZ9f8VF8N/e3Si
 i3kdBnl5SMfNe3YZwFcH7jzTz5wyM87fE33869SqWSJqQ7HXEsE1HP06Y9xLiGt8JL2A
 3bz1m9DYQ+oUxu7A/V5WEra5Lgar3VeGHilh4whsAa/QplNAPmEI2O1fKt/pVUDZfLwr
 FkZMJqePnCW0njv/EDX86IVUVj4yfUpyResp+2//EL7FGCVmJG9QgFtNkSVzNDaPv5rS
 2LyHrRqXZpz4GIYEtdNIuyLrEuU5KRHhYGFI3TT9B3ETxfFyVitujvAJVqnyQmmiyjuo
 xRpw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1719260376; x=1719865176;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=SYHhEoV3vydSIfLIXvEJm/GFH7lO17Epc6zzzdv2Yds=;
 b=Lhhg2riJ+h7p+xjE9LJX43ZGmzwU2eXhp9OVj9h+9h7nwCVKWpkn5X1NhmI4Sq2EbS
 ftM2dnuEDvtMcW0zKpUzPiHGlykus3aia/vccb1Ea/zx8gHE4NSJkKQ0tLwucRjvGoej
 ULd+VnLz6eTyDCdQ8qnSBrVGIra0COTCFhPrePZLPxjiMu1i+zSNP6e25T/skXJ3PPq0
 9BRJ/UtbpK3+vTCGHf2+qql9nH8e3XZlrXoUbFbI3BHC4kNEypdF4Y39Ve9gvi8SO+nm
 Spry/bjGEx9Hj+o9URo/7rrZhyoR4NWB73B5xPWAq6f33id5e1rAIj5a1D2QD2RiREuv
 MK9w==
X-Gm-Message-State: AOJu0YxyM3LRLpWR1Z3SBGF1jIfM07s+3dPCxmgHWBk4wnuv/oTwHwUc
 TJXTTdzfi8DfjVXtwro2aLYHI94EW+zgZcwDZfqwgxNF8Pjp78Pbtd9qU8j7h263HU5vwJCDLTm
 M
X-Google-Smtp-Source: AGHT+IFw27Mp3iCbQGYw3xRPSuOQOkTImtIgXmGIGjFBw/Gsnj88IH4XKnY/ZSfpDcC82swS6ZrRVQ==
X-Received: by 2002:a05:6a20:158b:b0:1bc:f42f:6e9d with SMTP id
 adf61e73a8af0-1bcf7e8eb3cmr7234925637.21.1719260376168; 
 Mon, 24 Jun 2024 13:19:36 -0700 (PDT)
Received: from grind.dc1.ventanamicro.com
 ([2804:7f0:bcc0:1aea:63a7:288e:eb77:fe54])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-70688f2d76bsm1927091b3a.41.2024.06.24.13.19.31
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 24 Jun 2024 13:19:35 -0700 (PDT)
From: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
To: qemu-devel@nongnu.org
Cc: qemu-riscv@nongnu.org, alistair.francis@wdc.com, bmeng@tinylab.org,
 liwei1518@gmail.com, zhiwei_liu@linux.alibaba.com, palmer@rivosinc.com,
 ajones@ventanamicro.com, tjeznach@rivosinc.com, frank.chang@sifive.com,
 jason.chien@sifive.com, Daniel Henrique Barboza <dbarboza@ventanamicro.com>
Subject: [PATCH v4 12/14] hw/riscv/riscv-iommu: Add another irq for mrif
 notifications
Date: Mon, 24 Jun 2024 17:18:22 -0300
Message-ID: <20240624201825.1054980-13-dbarboza@ventanamicro.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240624201825.1054980-1-dbarboza@ventanamicro.com>
References: <20240624201825.1054980-1-dbarboza@ventanamicro.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::42d;
 envelope-from=dbarboza@ventanamicro.com; helo=mail-pf1-x42d.google.com
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

From: Andrew Jones <ajones@ventanamicro.com>

And add mrif notification trace.

Signed-off-by: Andrew Jones <ajones@ventanamicro.com>
Reviewed-by: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
Reviewed-by: Frank Chang <frank.chang@sifive.com>
---
 hw/riscv/riscv-iommu-pci.c | 2 +-
 hw/riscv/riscv-iommu.c     | 1 +
 hw/riscv/trace-events      | 1 +
 3 files changed, 3 insertions(+), 1 deletion(-)

diff --git a/hw/riscv/riscv-iommu-pci.c b/hw/riscv/riscv-iommu-pci.c
index 7b82ce0645..d7e5f20885 100644
--- a/hw/riscv/riscv-iommu-pci.c
+++ b/hw/riscv/riscv-iommu-pci.c
@@ -81,7 +81,7 @@ static void riscv_iommu_pci_realize(PCIDevice *dev, Error **errp)
     pci_register_bar(dev, 0, PCI_BASE_ADDRESS_SPACE_MEMORY |
                      PCI_BASE_ADDRESS_MEM_TYPE_64, &s->bar0);
 
-    int ret = msix_init(dev, RISCV_IOMMU_INTR_COUNT,
+    int ret = msix_init(dev, RISCV_IOMMU_INTR_COUNT + 1,
                         &s->bar0, 0, RISCV_IOMMU_REG_MSI_CONFIG,
                         &s->bar0, 0, RISCV_IOMMU_REG_MSI_CONFIG + 256, 0, &err);
 
diff --git a/hw/riscv/riscv-iommu.c b/hw/riscv/riscv-iommu.c
index b7a9c4cec7..9d9a6ed2d9 100644
--- a/hw/riscv/riscv-iommu.c
+++ b/hw/riscv/riscv-iommu.c
@@ -623,6 +623,7 @@ static MemTxResult riscv_iommu_msi_write(RISCVIOMMUState *s,
         cause = RISCV_IOMMU_FQ_CAUSE_MSI_WR_FAULT;
         goto err;
     }
+    trace_riscv_iommu_mrif_notification(s->parent_obj.id, n190, addr);
 
     return MEMTX_OK;
 
diff --git a/hw/riscv/trace-events b/hw/riscv/trace-events
index 4b486b6420..d69719a27a 100644
--- a/hw/riscv/trace-events
+++ b/hw/riscv/trace-events
@@ -6,6 +6,7 @@ riscv_iommu_flt(const char *id, unsigned b, unsigned d, unsigned f, uint64_t rea
 riscv_iommu_pri(const char *id, unsigned b, unsigned d, unsigned f, uint64_t iova) "%s: page request %04x:%02x.%u iova: 0x%"PRIx64
 riscv_iommu_dma(const char *id, unsigned b, unsigned d, unsigned f, unsigned pasid, const char *dir, uint64_t iova, uint64_t phys) "%s: translate %04x:%02x.%u #%u %s 0x%"PRIx64" -> 0x%"PRIx64
 riscv_iommu_msi(const char *id, unsigned b, unsigned d, unsigned f, uint64_t iova, uint64_t phys) "%s: translate %04x:%02x.%u MSI 0x%"PRIx64" -> 0x%"PRIx64
+riscv_iommu_mrif_notification(const char *id, uint32_t nid, uint64_t phys) "%s: sent MRIF notification 0x%x to 0x%"PRIx64
 riscv_iommu_cmd(const char *id, uint64_t l, uint64_t u) "%s: command 0x%"PRIx64" 0x%"PRIx64
 riscv_iommu_notifier_add(const char *id) "%s: dev-iotlb notifier added"
 riscv_iommu_notifier_del(const char *id) "%s: dev-iotlb notifier removed"
-- 
2.45.2


