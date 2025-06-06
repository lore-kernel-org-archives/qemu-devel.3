Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8C6ADC5B559
	for <qemu-devel@archiver.kernel.org>; Fri,  6 Jun 2025 09:30:17 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uNTND-0005q2-5e; Fri, 06 Jun 2025 05:28:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhenzhong.duan@intel.com>)
 id 1uNTN3-0005n7-Aj; Fri, 06 Jun 2025 05:28:18 -0400
Received: from mgamail.intel.com ([198.175.65.14])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhenzhong.duan@intel.com>)
 id 1uNTN0-00019f-5p; Fri, 06 Jun 2025 05:28:16 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1749202095; x=1780738095;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=mQp2Rj95gFaDs2LKL+jpY2PfnBtrL/PfpJAhnt6PF7w=;
 b=Bh2T28Cgeuj4d2YZhnk1GTINTEQxFXq8uLQ78VnXVCB5CtKUJN13KsOc
 fwb8pmyBe1ooV6R9VVbQJEu0A9LFDgrHPZ5sQFZGgmYMEOxDWf2K6v4U9
 Oa58I/iDH8Lm8OFdM8nLAxWdRJouB94NHSxlv0bZ8fKCCCqdApjlo9ih5
 04cEJ4Bq9/YiBITdXvEKVBlMWx8vx+iykhdav0C2Tsle3V6cjVl0PIcqR
 4GKm0jSg9zkvSzrVqu1qF5aZEjSwEq4tQt27a9a38ydTb7Mrri3KnTTwP
 3tN1JYHosD3irDtiaCWblP6+OpCVl+nW0om0+7qSoNX9TJLwb18T9lruy A==;
X-CSE-ConnectionGUID: IOPgySb+TaCNQ4qrWV9b0g==
X-CSE-MsgGUID: RzSLNagpTeipQxjBCgOHNA==
X-IronPort-AV: E=McAfee;i="6800,10657,11455"; a="55154665"
X-IronPort-AV: E=Sophos;i="6.16,214,1744095600"; d="scan'208";a="55154665"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
 by orvoesa106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 06 Jun 2025 02:28:09 -0700
X-CSE-ConnectionGUID: /7gdiOeBThaA2e0CMDgqeA==
X-CSE-MsgGUID: zIob0wZ8RKqBRE3H2/rEiw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,214,1744095600"; d="scan'208";a="145706199"
Received: from spr-s2600bt.bj.intel.com ([10.240.192.127])
 by fmviesa007-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 06 Jun 2025 02:28:05 -0700
From: Zhenzhong Duan <zhenzhong.duan@intel.com>
To: qemu-devel@nongnu.org
Cc: chao.p.peng@intel.com, david@redhat.com, armbru@redhat.com,
 Zhenzhong Duan <zhenzhong.duan@intel.com>,
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>,
 Palmer Dabbelt <palmer@dabbelt.com>,
 Alistair Francis <alistair.francis@wdc.com>,
 Weiwei Li <liwei1518@gmail.com>, Liu Zhiwei <zhiwei_liu@linux.alibaba.com>,
 qemu-riscv@nongnu.org (open list:RISC-V TCG CPUs)
Subject: [PATCH v4 5/5] hw/riscv/riscv-iommu: Remove definition of
 RISCVIOMMU[Pci|Sys]Class
Date: Fri,  6 Jun 2025 17:24:06 +0800
Message-Id: <20250606092406.229833-6-zhenzhong.duan@intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250606092406.229833-1-zhenzhong.duan@intel.com>
References: <20250606092406.229833-1-zhenzhong.duan@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=198.175.65.14;
 envelope-from=zhenzhong.duan@intel.com; helo=mgamail.intel.com
X-Spam_score_int: -44
X-Spam_score: -4.5
X-Spam_bar: ----
X-Spam_report: (-4.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.132,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

RISCVIOMMUPciClass and RISCVIOMMUSysClass are defined with missed
parent class, class_init on them may corrupt their parent class
fields.

It's lucky that parent_realize and parent_phases are not initialized
or used until now, so just remove the definitions. They can be added
back when really necessary.

Signed-off-by: Zhenzhong Duan <zhenzhong.duan@intel.com>
Reviewed-by: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
---
 include/hw/riscv/iommu.h   | 6 ++----
 hw/riscv/riscv-iommu-pci.c | 6 ------
 hw/riscv/riscv-iommu-sys.c | 6 ------
 3 files changed, 2 insertions(+), 16 deletions(-)

diff --git a/include/hw/riscv/iommu.h b/include/hw/riscv/iommu.h
index b03339d75c..8a8acfc3f0 100644
--- a/include/hw/riscv/iommu.h
+++ b/include/hw/riscv/iommu.h
@@ -30,14 +30,12 @@ typedef struct RISCVIOMMUState RISCVIOMMUState;
 typedef struct RISCVIOMMUSpace RISCVIOMMUSpace;
 
 #define TYPE_RISCV_IOMMU_PCI "riscv-iommu-pci"
-OBJECT_DECLARE_TYPE(RISCVIOMMUStatePci, RISCVIOMMUPciClass, RISCV_IOMMU_PCI)
+OBJECT_DECLARE_SIMPLE_TYPE(RISCVIOMMUStatePci, RISCV_IOMMU_PCI)
 typedef struct RISCVIOMMUStatePci RISCVIOMMUStatePci;
-typedef struct RISCVIOMMUPciClass RISCVIOMMUPciClass;
 
 #define TYPE_RISCV_IOMMU_SYS "riscv-iommu-device"
-OBJECT_DECLARE_TYPE(RISCVIOMMUStateSys, RISCVIOMMUSysClass, RISCV_IOMMU_SYS)
+OBJECT_DECLARE_SIMPLE_TYPE(RISCVIOMMUStateSys, RISCV_IOMMU_SYS)
 typedef struct RISCVIOMMUStateSys RISCVIOMMUStateSys;
-typedef struct RISCVIOMMUSysClass RISCVIOMMUSysClass;
 
 #define FDT_IRQ_TYPE_EDGE_LOW 1
 
diff --git a/hw/riscv/riscv-iommu-pci.c b/hw/riscv/riscv-iommu-pci.c
index 1f44eef74e..cdb4a7a8f0 100644
--- a/hw/riscv/riscv-iommu-pci.c
+++ b/hw/riscv/riscv-iommu-pci.c
@@ -68,12 +68,6 @@ typedef struct RISCVIOMMUStatePci {
     RISCVIOMMUState  iommu;   /* common IOMMU state */
 } RISCVIOMMUStatePci;
 
-struct RISCVIOMMUPciClass {
-    /*< public >*/
-    DeviceRealize parent_realize;
-    ResettablePhases parent_phases;
-};
-
 /* interrupt delivery callback */
 static void riscv_iommu_pci_notify(RISCVIOMMUState *iommu, unsigned vector)
 {
diff --git a/hw/riscv/riscv-iommu-sys.c b/hw/riscv/riscv-iommu-sys.c
index 74e76b94a5..e34d00aef6 100644
--- a/hw/riscv/riscv-iommu-sys.c
+++ b/hw/riscv/riscv-iommu-sys.c
@@ -53,12 +53,6 @@ struct RISCVIOMMUStateSys {
     uint8_t *msix_pba;
 };
 
-struct RISCVIOMMUSysClass {
-    /*< public >*/
-    DeviceRealize parent_realize;
-    ResettablePhases parent_phases;
-};
-
 static uint64_t msix_table_mmio_read(void *opaque, hwaddr addr,
                                      unsigned size)
 {
-- 
2.34.1


