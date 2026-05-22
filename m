Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7C178CD5BAB
	for <qemu-devel@archiver.kernel.org>; Fri, 22 May 2026 00:09:28 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wQDOA-0002Zv-Ch; Thu, 21 May 2026 20:05:23 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1wQDNo-0002C9-J4
 for qemu-devel@nongnu.org; Thu, 21 May 2026 20:04:59 -0400
Received: from mail-pl1-x62c.google.com ([2607:f8b0:4864:20::62c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1wQDNm-0003qg-Nq
 for qemu-devel@nongnu.org; Thu, 21 May 2026 20:04:56 -0400
Received: by mail-pl1-x62c.google.com with SMTP id
 d9443c01a7336-2b4583f0a1aso44351545ad.3
 for <qemu-devel@nongnu.org>; Thu, 21 May 2026 17:04:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1779408293; x=1780013093; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=rXGc+Ljv8bnjFKr9c9Nd+ZT8vlEMtLZsyDj7VfaMAvc=;
 b=a8Feke/MC7Ig/pJ7pc2stowazJfQc2Ki5spWzG3rC3Yu8iQZnBaZgdME+vCODu3tZZ
 q5Z9Yn1sHWMmVX4itiChFpI/AZfzw196+Q3igNd9ZvtqDWpp0UoZ4rKneFNcvhDFVr0m
 D7s/hjVy94CTqAnDnJQbG1dlAXprp9HlPTy4VUqzUDKLAzpml7OmFVULzeYDEcaUQs2x
 zaq49MkcYzlnhDC/JBmNto7TVUDGekBzq9gvIqq6TTIrjCM5JjMgDO+s4I+JZjUeLOZN
 he9eQuNLmCFTbOT686cs36GG7TRr+1dljMh44O+18s9gKsVe3fiqOHfYY3+6WD/Su14F
 aKRg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779408293; x=1780013093;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=rXGc+Ljv8bnjFKr9c9Nd+ZT8vlEMtLZsyDj7VfaMAvc=;
 b=dlssyr38KRJRyMr0jGFx+gt3UVlJ9tq1tMZ7CQmrijs/rM2P26MmEqYk05fvRb7Oxu
 /Sxew4UglyF02bOuJ0IP1GvM2gEokU/vyI8l1Y/o+ftP94kK48xTnng3A1l5e4/K+abT
 xm2kA7ZXaKoOe1HRR+Vv3Pg5DizwKl1yOFEa2+G/Z+BJTG8pz2JHQxSDQaTrdx5hLhXn
 II7KJaad2lPbJe3zUm8WdfrAaSi3TXycSoyj5AL6I4BeOkKntXwN2YEvDAqF2JjwMk+n
 a3KIlMA1ryg6a1Z5yvkkjXscr4raEmh7pPcqvOE9f5wg8ERXcngusYlxBKaHozUVnCM6
 cB8A==
X-Gm-Message-State: AOJu0YzWM3WTd91MmXgmSgdrhxlMiNgGA3/ycpVpgJ2Lv6HeAx9q0cWs
 EnSa3taSeCs4c16JyvimAdtu7ImgWbfo2JVoN/DR0UfaQ0WGAYSQ5lNlkrhGUvfi
X-Gm-Gg: Acq92OGh48CT/iOtWJoJIAHNDFehemDIKesy5M6VLewh5V1ZfKKeYfE6PeFQ7E3htyg
 QVHkhgD9iY2i7eR76jLk2Rw/rFdZDFTuiZEfZdyeE0FTKNgK9mm0rEJO3PPBwa6CDtu7CBySxN0
 Ig1qKMPOCvftoXgf11OvaU2d/4nZ5AQe0sbsCFwzHXjwrtb8+BIX6RcAsQ4cip5NJr6gPSPAlzo
 eMsJSvj0XNtoQFQzZX71gnAzojHmNhuyERGC6og8zq1StNczH5TgVXuCTIGxYIerN3QQCkKSbdV
 ++C7tOHyhbk+JWSQSqCqaYXv1rRVs1XR8RFWLK0BZUdZ/O+plOoeo5YoUlNfb0/6NgvjjG02JWf
 UG4jknsqVCc83Jqo6KF69A9k2uysyIx8m0pTWH0sGHkn79SddFKRxEwpI7dGgwB+Q6d09qfjXfE
 w19IslZ3kA4KOmyo1+7h1cu/wfI7T4JGNFBlL2TCCvbQ==
X-Received: by 2002:a17:902:cf0e:b0:2bd:ba87:40a1 with SMTP id
 d9443c01a7336-2beb07ffc75mr10586845ad.29.1779408293400; 
 Thu, 21 May 2026 17:04:53 -0700 (PDT)
Received: from toolbx.alistair23.me ([2403:581e:fdf9:0:6209:4521:6813:45b7])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2beb114b54csm3915475ad.42.2026.05.21.17.04.50
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 21 May 2026 17:04:52 -0700 (PDT)
From: alistair23@gmail.com
X-Google-Original-From: alistair.francis@wdc.com
To: qemu-devel@nongnu.org
Cc: alistair23@gmail.com, Chengbo Gao <gaochengbo@bosc.ac.cn>,
 Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>,
 Alistair Francis <alistair.francis@wdc.com>
Subject: [PULL 24/48] hw/riscv/riscv-iommu: Avoid caching PCI device IDs
Date: Fri, 22 May 2026 10:03:00 +1000
Message-ID: <20260522000324.23255-25-alistair.francis@wdc.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260522000324.23255-1-alistair.francis@wdc.com>
References: <20260522000324.23255-1-alistair.francis@wdc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62c;
 envelope-from=alistair23@gmail.com; helo=mail-pl1-x62c.google.com
X-Spam_score_int: -17
X-Spam_score: -1.8
X-Spam_bar: -
X-Spam_report: (-1.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FREEMAIL_ENVFROM_END_DIGIT=0.25, FREEMAIL_FROM=0.001,
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

From: Chengbo Gao <gaochengbo@bosc.ac.cn>

PCI bus numbers may still be unassigned when QEMU initializes a PCI
device's bus-master address space.  For devices behind bridges,
pci_bus_num() can return 0 at that point because the guest has not yet
programmed the bridge Secondary Bus Number register.

The RISC-V IOMMU currently stores a fixed device_id in RISCVIOMMUSpace
when the address space is created.  If the guest later enumerates the
device on a non-zero bus, DMA translation still uses the stale device_id
and may look up the wrong device context in the DDT.

Store the stable PCIBus pointer and devfn in RISCVIOMMUSpace instead,
and compute the device_id from the current bus number when it is needed.
This keeps DMA translation and ATS invalidation in sync with guest PCI
bus enumeration.

Signed-off-by: Chengbo Gao <gaochengbo@bosc.ac.cn>
Reviewed-by: Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>
Message-ID: <20260514020637.2819308-1-gaochengbo@bosc.ac.cn>
Signed-off-by: Alistair Francis <alistair.francis@wdc.com>
---
 hw/riscv/riscv-iommu.c | 40 +++++++++++++++++++++++++---------------
 1 file changed, 25 insertions(+), 15 deletions(-)

diff --git a/hw/riscv/riscv-iommu.c b/hw/riscv/riscv-iommu.c
index c9c64be24f..5bc2472a83 100644
--- a/hw/riscv/riscv-iommu.c
+++ b/hw/riscv/riscv-iommu.c
@@ -49,7 +49,8 @@ struct RISCVIOMMUSpace {
     IOMMUMemoryRegion iova_mr;  /* IOVA memory region for attached device */
     AddressSpace iova_as;       /* IOVA address space for attached device */
     RISCVIOMMUState *iommu;     /* Managing IOMMU device state */
-    uint32_t devid;             /* Requester identifier, AKA device_id */
+    PCIBus *bus;                /* PCI bus of the requester */
+    uint8_t devfn;              /* Requester identifier, AKA device_id */
     bool notifier;              /* IOMMU unmap notifier enabled */
     QLIST_ENTRY(RISCVIOMMUSpace) list;
 };
@@ -74,6 +75,15 @@ struct RISCVIOMMUEntry {
 /* IOMMU index for transactions without process_id specified. */
 #define RISCV_IOMMU_NOPROCID 0
 
+static uint32_t riscv_iommu_space_devid(RISCVIOMMUSpace *as)
+{
+    uint32_t devid = PCI_BUILD_BDF(pci_bus_num(as->bus), as->devfn);
+
+    /* FIXME: PCIe bus remapping for attached endpoints. */
+    devid |= as->iommu->bus << 8;
+    return devid;
+}
+
 static uint8_t riscv_iommu_get_icvec_vector(uint32_t icvec, uint32_t vec_type)
 {
     switch (vec_type) {
@@ -1379,15 +1389,13 @@ static void riscv_iommu_ctx_put(RISCVIOMMUState *s, void *ref)
 }
 
 /* Find or allocate address space for a given device */
-static AddressSpace *riscv_iommu_space(RISCVIOMMUState *s, uint32_t devid)
+static AddressSpace *riscv_iommu_space(RISCVIOMMUState *s, PCIBus *bus,
+                                            int devfn)
 {
     RISCVIOMMUSpace *as;
 
-    /* FIXME: PCIe bus remapping for attached endpoints. */
-    devid |= s->bus << 8;
-
     QLIST_FOREACH(as, &s->spaces, list) {
-        if (as->devid == devid) {
+        if (as->bus == bus && as->devfn == devfn) {
             break;
         }
     }
@@ -1397,10 +1405,11 @@ static AddressSpace *riscv_iommu_space(RISCVIOMMUState *s, uint32_t devid)
         as = g_new0(RISCVIOMMUSpace, 1);
 
         as->iommu = s;
-        as->devid = devid;
+        as->bus = bus;
+        as->devfn = devfn;
 
         snprintf(name, sizeof(name), "riscv-iommu-%04x:%02x.%d-iova",
-            PCI_BUS_NUM(as->devid), PCI_SLOT(as->devid), PCI_FUNC(as->devid));
+            pci_bus_num(bus), PCI_SLOT(devfn), PCI_FUNC(devfn));
 
         /* IOVA address space, untranslated addresses */
         memory_region_init_iommu(&as->iova_mr, sizeof(as->iova_mr),
@@ -1410,8 +1419,8 @@ static AddressSpace *riscv_iommu_space(RISCVIOMMUState *s, uint32_t devid)
 
         QLIST_INSERT_HEAD(&s->spaces, as, list);
 
-        trace_riscv_iommu_new(s->parent_obj.id, PCI_BUS_NUM(as->devid),
-                PCI_SLOT(as->devid), PCI_FUNC(as->devid));
+        trace_riscv_iommu_new(s->parent_obj.id, pci_bus_num(bus),
+                PCI_SLOT(devfn), PCI_FUNC(devfn));
     }
     return &as->iova_as;
 }
@@ -1732,7 +1741,7 @@ static void riscv_iommu_ats(RISCVIOMMUState *s,
     pid = get_field(cmd->dword0, RISCV_IOMMU_CMD_ATS_PID);
 
     QLIST_FOREACH(as, &s->spaces, list) {
-        if (as->devid == devid) {
+        if (riscv_iommu_space_devid(as) == devid) {
             break;
         }
     }
@@ -2745,8 +2754,9 @@ static IOMMUTLBEntry riscv_iommu_memory_region_translate(
         .addr_mask = ~0ULL,
         .perm = flag,
     };
+    uint32_t devid = riscv_iommu_space_devid(as);
 
-    ctx = riscv_iommu_ctx(as->iommu, as->devid, iommu_idx, &ref);
+    ctx = riscv_iommu_ctx(as->iommu, devid, iommu_idx, &ref);
     if (ctx == NULL) {
         /* Translation disabled or invalid. */
         iotlb.addr_mask = 0;
@@ -2758,8 +2768,8 @@ static IOMMUTLBEntry riscv_iommu_memory_region_translate(
     }
 
     /* Trace all dma translations with original access flags. */
-    trace_riscv_iommu_dma(as->iommu->parent_obj.id, PCI_BUS_NUM(as->devid),
-                          PCI_SLOT(as->devid), PCI_FUNC(as->devid), iommu_idx,
+    trace_riscv_iommu_dma(as->iommu->parent_obj.id, PCI_BUS_NUM(devid),
+                          PCI_SLOT(devid), PCI_FUNC(devid), iommu_idx,
                           IOMMU_FLAG_STR[flag & IOMMU_RW], iotlb.iova,
                           iotlb.translated_addr);
 
@@ -2807,7 +2817,7 @@ static AddressSpace *riscv_iommu_find_as(PCIBus *bus, void *opaque, int devfn)
 
     /* Find first matching IOMMU */
     while (s != NULL && as == NULL) {
-        as = riscv_iommu_space(s, PCI_BUILD_BDF(pci_bus_num(bus), devfn));
+        as = riscv_iommu_space(s, bus, devfn);
         s = s->iommus.le_next;
     }
 
-- 
2.53.0


