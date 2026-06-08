Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1A191CD8C9D
	for <qemu-devel@archiver.kernel.org>; Mon,  8 Jun 2026 06:36:16 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wWTa4-0000Ld-1Z; Mon, 08 Jun 2026 02:35:28 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <wang.yechao255@zte.com.cn>)
 id 1wWTZv-0000JY-SL; Mon, 08 Jun 2026 02:35:22 -0400
Received: from mxhk.zte.com.cn ([160.30.148.34])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <wang.yechao255@zte.com.cn>)
 id 1wWTZt-0004yt-Bb; Mon, 08 Jun 2026 02:35:19 -0400
Received: from mse-fl1.zte.com.cn (unknown [10.5.228.132])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mxhk.zte.com.cn (FangMail) with ESMTPS id 4gYj2f0Vbkz5B1Gv;
 Mon, 08 Jun 2026 14:35:06 +0800 (CST)
Received: from szxl2zmapp06.zte.com.cn ([10.1.32.108])
 by mse-fl1.zte.com.cn with SMTP id 6586Yupr091611;
 Mon, 8 Jun 2026 14:34:56 +0800 (+08)
 (envelope-from wang.yechao255@zte.com.cn)
Received: from mapi (szxl2zmapp07[null]) by mapi (Zmail) with MAPI id mid12;
 Mon, 8 Jun 2026 14:34:58 +0800 (CST)
X-Zmail-TransId: 2b096a2662920c1-4eefb
X-Mailer: Zmail v1.0
Message-ID: <20260608143458400rOXqFmoA6o1tmlztJH2gE@zte.com.cn>
Date: Mon, 8 Jun 2026 14:34:58 +0800 (CST)
Mime-Version: 1.0
From: <wang.yechao255@zte.com.cn>
To: <palmer@dabbelt.com>, <alistair.francis@wdc.com>, <liwei1518@gmail.com>,
 <daniel.barboza@oss.qualcomm.com>, <zhiwei_liu@linux.alibaba.com>,
 <chao.liu.zevorn@gmail.com>
Cc: <qemu-riscv@nongnu.org>, <qemu-devel@nongnu.org>
Subject: =?UTF-8?B?W1BBVENIXSBody9yaXNjdi92aXJ0OiBBZGQgImlvbW11LW1hcCIgcHJvcGVydHkgZm9yIHBjaWUgYnVz?=
Content-Type: text/plain;
	charset="UTF-8"
X-MAIL: mse-fl1.zte.com.cn 6586Yupr091611
X-TLS: YES
X-ENVELOPE-SENDER: wang.yechao255@zte.com.cn
X-SOURCE-IP: 10.5.228.132 unknown Mon, 08 Jun 2026 14:35:06 +0800
X-CLEAN: YES
X-Fangmail-Anti-Spam-Filtered: true
X-Fangmail-MID-QID: 6A26629A.000/4gYj2f0Vbkz5B1Gv
Received-SPF: pass client-ip=160.30.148.34;
 envelope-from=wang.yechao255@zte.com.cn; helo=mxhk.zte.com.cn
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001, UNPARSEABLE_RELAY=0.001 autolearn=ham autolearn_force=no
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

From: Wang Yechao <wang.yechao255@zte.com.cn>

On DT system, add the "iommu-map" property for pcie bus, so the kernel
can build the dependency between iommu and devices, to avoid the
incorrect removal order.

Signed-off-by: Wang Yechao <wang.yechao255@zte.com.cn>
---
 hw/riscv/virt.c         | 8 ++++++++
 include/hw/riscv/virt.h | 1 +
 2 files changed, 9 insertions(+)

diff --git a/hw/riscv/virt.c b/hw/riscv/virt.c
index ce64eaaef7..0ce16f13c2 100644
--- a/hw/riscv/virt.c
+++ b/hw/riscv/virt.c
@@ -904,6 +904,13 @@ static void create_fdt_pcie(RISCVVirtState *s,
                                iommu_sys_phandle, 0, 0xffff);
     }

+    if (s->pci_iommu_bdf) {
+        qemu_fdt_setprop_cells(ms->fdt, name, "iommu-map",
+                               0, s->pci_iommu_phandle, 0, s->pci_iommu_bdf,
+                               s->pci_iommu_bdf + 1, s->pci_iommu_phandle,
+                               s->pci_iommu_bdf + 1, 0xffff - s->pci_iommu_bdf);
+    }
+
     create_pcie_irq_map(s, ms->fdt, name, irq_pcie_phandle);
 }

@@ -1117,6 +1124,7 @@ static void create_fdt_iommu(RISCVVirtState *s, uint16_t bdf)
                            0, iommu_phandle, 0, bdf,
                            bdf + 1, iommu_phandle, bdf + 1, 0xffff - bdf);
     s->pci_iommu_bdf = bdf;
+    s->pci_iommu_phandle = iommu_phandle;
 }

 static void finalize_fdt(RISCVVirtState *s)
diff --git a/include/hw/riscv/virt.h b/include/hw/riscv/virt.h
index 18a2a323a3..25c563cf8f 100644
--- a/include/hw/riscv/virt.h
+++ b/include/hw/riscv/virt.h
@@ -64,6 +64,7 @@ struct RISCVVirtState {
     struct GPEXHost *gpex_host;
     OnOffAuto iommu_sys;
     uint16_t pci_iommu_bdf;
+    uint32_t pci_iommu_phandle;
 };

 enum {
-- 
2.27.0

