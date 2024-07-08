Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 40D60C3DA41
	for <qemu-devel@archiver.kernel.org>; Mon,  8 Jul 2024 17:36:42 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sQsHU-0007Qd-Pt; Mon, 08 Jul 2024 13:36:05 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dbarboza@ventanamicro.com>)
 id 1sQsHK-0006jN-F2
 for qemu-devel@nongnu.org; Mon, 08 Jul 2024 13:35:54 -0400
Received: from mail-pl1-x630.google.com ([2607:f8b0:4864:20::630])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <dbarboza@ventanamicro.com>)
 id 1sQsHG-0008CZ-Vq
 for qemu-devel@nongnu.org; Mon, 08 Jul 2024 13:35:52 -0400
Received: by mail-pl1-x630.google.com with SMTP id
 d9443c01a7336-1fb3cf78ff3so25712755ad.0
 for <qemu-devel@nongnu.org>; Mon, 08 Jul 2024 10:35:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=ventanamicro.com; s=google; t=1720460149; x=1721064949; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=i5BLsUBoM4DKklbdUYYDED0EV+MqKP6S95+gLvE0eP0=;
 b=AAQMtBu6KM5lvSqHNW5VsyHXm4y1Y9fHM039SaL0sCGlMvmH2lmWuZwEhTpO01wD0K
 PolScUe7XSPP0GbrP70egGUfo5MgEHueDERbZIkn+4Nt+/af/LFlBvPTsm6wCJmQ8q+3
 h1nG4ZAfV9/v91rWUJUq4UHRYc8P0MwoOJ93ryckOYqEQALLkfIq76Tt7IZ0DpWHtari
 waoxev4k3/vcBujgddX0d+NGhGx+AvEntZl1zErHE4BVPVqjYL5rGwLr5tHuc5J7amvI
 fFEkWtPCSFeThi8Tn18Rfj5Zkgo3V1kMFLpQCHqx/9whHeIUD5hfIXkqzoGbG8WWdxUW
 T0PA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1720460149; x=1721064949;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=i5BLsUBoM4DKklbdUYYDED0EV+MqKP6S95+gLvE0eP0=;
 b=LaDgw3k4CwjXOyGai5vkDCUiggCg5V+MJCGUmQOacP52Dc7a1717JGIKvmZwn/U62i
 HH9xs0RbAZvjAC6IxN3wEg8LonycA0peIUmaUSYBe8bcdP7PBQwfd06/yIhkHmi0CzNp
 Mw9+FUhO628PK1uXz7WsB+s5exgEd1nkGFyYHMK/Hz+1hIhJbMR0g7hpY/RD3avvHmBT
 kdpjpJhi+mOa05OxiE/QMOp04/CsIdaUTpG3ZXLyHcN73/IYNP480TMOV+BZ0UojY62U
 bQZnSdzstz0oD3NUXu1kikVac9dT0WxWkom/pG8/nbSHaJ5NswoDAeb6M0/M9BgsnHPl
 CgxA==
X-Gm-Message-State: AOJu0Yy0CIKRrIchNoRDEK+wjMjhcH+4wt0S5VHcPmXrFXR3xiSUpevW
 BYecfybYrLytaxnhpH7Whzka/mEQfQrnhk3ChmESHKO9baoLkhfk0Enx/WA75UddzeDU3SwtTR7
 t
X-Google-Smtp-Source: AGHT+IEnvrO5rx4VhAhG3cxycYdLWHgoGdSvA4jhfp5IBOVz+02heSdjMGf5NCONBU7EipilDmtEwA==
X-Received: by 2002:a17:903:11ce:b0:1fb:d7d:73f1 with SMTP id
 d9443c01a7336-1fbb6eb4f17mr1649965ad.65.1720460148813; 
 Mon, 08 Jul 2024 10:35:48 -0700 (PDT)
Received: from grind.dc1.ventanamicro.com ([179.193.8.43])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-1fbb6ad3829sm1153765ad.299.2024.07.08.10.35.45
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 08 Jul 2024 10:35:48 -0700 (PDT)
From: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
To: qemu-devel@nongnu.org
Cc: qemu-riscv@nongnu.org, alistair.francis@wdc.com, bmeng@tinylab.org,
 liwei1518@gmail.com, zhiwei_liu@linux.alibaba.com, palmer@rivosinc.com,
 frank.chang@sifive.com, tjeznach@rivosinc.com, jason.chien@sifive.com,
 Andrew Jones <ajones@ventanamicro.com>,
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>
Subject: [PATCH v5 11/13] hw/riscv/riscv-iommu: Add another irq for mrif
 notifications
Date: Mon,  8 Jul 2024 14:34:58 -0300
Message-ID: <20240708173501.426225-12-dbarboza@ventanamicro.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240708173501.426225-1-dbarboza@ventanamicro.com>
References: <20240708173501.426225-1-dbarboza@ventanamicro.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::630;
 envelope-from=dbarboza@ventanamicro.com; helo=mail-pl1-x630.google.com
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
index 2985a49e53..c9ac3d348b 100644
--- a/hw/riscv/riscv-iommu.c
+++ b/hw/riscv/riscv-iommu.c
@@ -621,6 +621,7 @@ static MemTxResult riscv_iommu_msi_write(RISCVIOMMUState *s,
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


