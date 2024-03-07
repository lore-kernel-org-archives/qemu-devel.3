Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 85375C48BF6
	for <qemu-devel@archiver.kernel.org>; Thu,  7 Mar 2024 16:08:50 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1riGEd-0006Kg-BI; Thu, 07 Mar 2024 11:04:43 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dbarboza@ventanamicro.com>)
 id 1riGET-0006E9-7x
 for qemu-devel@nongnu.org; Thu, 07 Mar 2024 11:04:33 -0500
Received: from mail-pl1-x62d.google.com ([2607:f8b0:4864:20::62d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <dbarboza@ventanamicro.com>)
 id 1riGEK-0006TV-Ob
 for qemu-devel@nongnu.org; Thu, 07 Mar 2024 11:04:31 -0500
Received: by mail-pl1-x62d.google.com with SMTP id
 d9443c01a7336-1dc5d0162bcso9386705ad.0
 for <qemu-devel@nongnu.org>; Thu, 07 Mar 2024 08:04:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=ventanamicro.com; s=google; t=1709827460; x=1710432260; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=1aXRP2KVTe35bDOq459aCYA3XDBPGwRmCn+nfWu9Dtg=;
 b=K2L8Ji48bxE+Tf21r93ixkNye5ZgEwesNZrDQRieyvwplDZSq+N133WLQSVhpmMiVF
 RaLuVpETuSRtS0x81m9zzaLhLRpUcbIerW6xbPp70PGTmYqo8thl/mTiI+Law+zVjzIS
 FHki9PYt6S2vusWW3d85LBQy0HM+jtHEcMvdW90YRVgB9ACmNJsADoc2qKsZXt03soLK
 4dOYKyKag+Vmr5jY6useJwQ8Z1JBHJ3D9t9wdR3/jqq5Dqu1sdSkpBuaa+hEpCKFdzB7
 npGUbXg6uar3DCBaAvCn6cuEACI6z7sQR4MdW/tGrwB++7zDab/ZfiXKjlZ4hHw++L4I
 3hBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1709827460; x=1710432260;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=1aXRP2KVTe35bDOq459aCYA3XDBPGwRmCn+nfWu9Dtg=;
 b=U0HbA+HGZjaEz7AMvVLtqxe/aN0yL1QRSUwdpjhdcYhY0WtUtAn8/VW2xBDnjR13I/
 iP08p0YhcXYtaL9OsAZfBoRuaemk7FlvC8jAq21+dBkN9MLvZ131S5DFJLnwVHcIZgUH
 QvGjQebfstYkB3DTWGIhQpC+5JcS5dt0zQ9ATdPlhBCGqa+kyvonuwdlaa9rih7Wlg6G
 OYjhoFgwrXHaYkebwbJjGWIriIPFzTIUCe6ldhFuXYkz95xBxaemRj43zyPUX+NiS7wm
 TeMm6EDb+YmtL1UprvR7mxo1XnsvPnw/TrJHZBVwPF+VBDo5y+z5BRph2p7Az8CfSPMG
 vicA==
X-Gm-Message-State: AOJu0YzR/Z6Quqye2mVEHxaj2Jievi7rOf1ENx9lm0J5nXKIKJPU8L+1
 rEzKuIBLpzz3EpKS0Jf/S1R0ZdPqlCly1oUxnIxTJ/0YS3rudYrFt1HOP/UHKBpcoT29oB/bStu
 d
X-Google-Smtp-Source: AGHT+IGoFS2MF0reIo/AKEmeI92FN3H728A+uxneGTTHUYFyLi7GdBPRQBQNqP0YBROznPlPMSgQKQ==
X-Received: by 2002:a17:902:7c92:b0:1dc:cc09:ebad with SMTP id
 y18-20020a1709027c9200b001dccc09ebadmr6875109pll.28.1709827459524; 
 Thu, 07 Mar 2024 08:04:19 -0800 (PST)
Received: from grind.dc1.ventanamicro.com ([177.94.15.159])
 by smtp.gmail.com with ESMTPSA id
 u11-20020a170903124b00b001db2b8b2da7sm14663136plh.122.2024.03.07.08.04.16
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 07 Mar 2024 08:04:19 -0800 (PST)
From: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
To: qemu-devel@nongnu.org
Cc: qemu-riscv@nongnu.org, alistair.francis@wdc.com, bmeng@tinylab.org,
 liwei1518@gmail.com, zhiwei_liu@linux.alibaba.com, palmer@rivosinc.com,
 ajones@ventanamicro.com, tjeznach@rivosinc.com
Subject: [PATCH v2 15/15] hw/misc: EDU: add ATS/PRI capability
Date: Thu,  7 Mar 2024 13:03:18 -0300
Message-ID: <20240307160319.675044-16-dbarboza@ventanamicro.com>
X-Mailer: git-send-email 2.43.2
In-Reply-To: <20240307160319.675044-1-dbarboza@ventanamicro.com>
References: <20240307160319.675044-1-dbarboza@ventanamicro.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62d;
 envelope-from=dbarboza@ventanamicro.com; helo=mail-pl1-x62d.google.com
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

From: Tomasz Jeznach <tjeznach@rivosinc.com>

Mimic ATS interface with IOMMU translate request with IOMMU_NONE.  If
mapping exists, translation service will return current permission
flags, otherwise will report no permissions.

Implement and register the IOMMU memory region listener to be notified
whenever an ATS invalidation request is sent from the IOMMU.

Implement and register the IOMMU memory region listener to be notified
whenever an ATS page request group response is triggered from the IOMMU.

Introduces a retry mechanism to the timer design so that any page that's
not available should be only accessed after the PRGR notification has
been received.

Signed-off-by: Tomasz Jeznach <tjeznach@rivosinc.com>
Signed-off-by: Sebastien Boeuf <seb@rivosinc.com>
---
 hw/misc/edu.c | 258 ++++++++++++++++++++++++++++++++++++++++++++++++--
 1 file changed, 251 insertions(+), 7 deletions(-)

diff --git a/hw/misc/edu.c b/hw/misc/edu.c
index 522cec85b3..f4f6c15ec6 100644
--- a/hw/misc/edu.c
+++ b/hw/misc/edu.c
@@ -45,6 +45,14 @@ DECLARE_INSTANCE_CHECKER(EduState, EDU,
 #define DMA_START       0x40000
 #define DMA_SIZE        4096
 
+/*
+ * Number of tries before giving up on page request group response.
+ * Given the timer callback is scheduled to be run again after 100ms,
+ * 10 tries give roughly a second for the PRGR notification to be
+ * received.
+ */
+#define NUM_TRIES       10
+
 struct EduState {
     PCIDevice pdev;
     MemoryRegion mmio;
@@ -55,6 +63,7 @@ struct EduState {
     bool stopping;
 
     bool enable_pasid;
+    uint32_t try;
 
     uint32_t addr4;
     uint32_t fact;
@@ -81,6 +90,20 @@ struct EduState {
     QEMUTimer dma_timer;
     char dma_buf[DMA_SIZE];
     uint64_t dma_mask;
+
+    MemoryListener iommu_listener;
+    QLIST_HEAD(, edu_iommu) iommu_list;
+
+    bool prgr_rcvd;
+    bool prgr_success;
+};
+
+struct edu_iommu {
+    EduState *edu;
+    IOMMUMemoryRegion *iommu_mr;
+    hwaddr iommu_offset;
+    IOMMUNotifier n;
+    QLIST_ENTRY(edu_iommu) iommu_next;
 };
 
 static bool edu_msi_enabled(EduState *edu)
@@ -136,11 +159,65 @@ static dma_addr_t edu_clamp_addr(const EduState *edu, dma_addr_t addr)
     return res;
 }
 
+static bool __find_iommu_mr_cb(Int128 start, Int128 len, const MemoryRegion *mr,
+    hwaddr offset_in_region, void *opaque)
+{
+    IOMMUMemoryRegion **iommu_mr = opaque;
+    *iommu_mr = memory_region_get_iommu((MemoryRegion *)mr);
+    return *iommu_mr != NULL;
+}
+
+static int pci_dma_perm(PCIDevice *pdev, dma_addr_t iova, MemTxAttrs attrs)
+{
+    IOMMUMemoryRegion *iommu_mr = NULL;
+    IOMMUMemoryRegionClass *imrc;
+    int iommu_idx;
+    FlatView *fv;
+    EduState *edu = EDU(pdev);
+    struct edu_iommu *iommu;
+
+    RCU_READ_LOCK_GUARD();
+
+    fv = address_space_to_flatview(pci_get_address_space(pdev));
+
+    /* Find first IOMMUMemoryRegion */
+    flatview_for_each_range(fv, __find_iommu_mr_cb, &iommu_mr);
+
+    if (iommu_mr) {
+        imrc = memory_region_get_iommu_class_nocheck(iommu_mr);
+
+        /* IOMMU Index is mapping to memory attributes (PASID, etc) */
+        iommu_idx = imrc->attrs_to_index ?
+                    imrc->attrs_to_index(iommu_mr, attrs) : 0;
+
+        /* Update IOMMU notifiers with proper index */
+        QLIST_FOREACH(iommu, &edu->iommu_list, iommu_next) {
+            if (iommu->iommu_mr == iommu_mr &&
+                iommu->n.iommu_idx != iommu_idx) {
+                memory_region_unregister_iommu_notifier(
+                    MEMORY_REGION(iommu->iommu_mr), &iommu->n);
+                iommu->n.iommu_idx = iommu_idx;
+                memory_region_register_iommu_notifier(
+                    MEMORY_REGION(iommu->iommu_mr), &iommu->n, NULL);
+            }
+        }
+
+        /* Translate request with IOMMU_NONE is an ATS request */
+        IOMMUTLBEntry iotlb = imrc->translate(iommu_mr, iova, IOMMU_NONE,
+                                              iommu_idx);
+
+        return iotlb.perm;
+    }
+
+    return IOMMU_NONE;
+}
+
 static void edu_dma_timer(void *opaque)
 {
     EduState *edu = opaque;
     bool raise_irq = false;
     MemTxAttrs attrs = MEMTXATTRS_UNSPECIFIED;
+    MemTxResult res;
 
     if (!(edu->dma.cmd & EDU_DMA_RUN)) {
         return;
@@ -155,18 +232,70 @@ static void edu_dma_timer(void *opaque)
 
     if (EDU_DMA_DIR(edu->dma.cmd) == EDU_DMA_FROM_PCI) {
         uint64_t dst = edu->dma.dst;
+        uint64_t src = edu_clamp_addr(edu, edu->dma.src);
         edu_check_range(dst, edu->dma.cnt, DMA_START, DMA_SIZE);
         dst -= DMA_START;
-        pci_dma_rw(&edu->pdev, edu_clamp_addr(edu, edu->dma.src),
-                edu->dma_buf + dst, edu->dma.cnt,
-                DMA_DIRECTION_TO_DEVICE, attrs);
+        if (edu->try-- == NUM_TRIES) {
+            edu->prgr_rcvd = false;
+            if (!(pci_dma_perm(&edu->pdev, src, attrs) & IOMMU_RO)) {
+                timer_mod(&edu->dma_timer,
+                          qemu_clock_get_ms(QEMU_CLOCK_VIRTUAL) + 100);
+                return;
+            }
+        } else if (edu->try) {
+            if (!edu->prgr_rcvd) {
+                timer_mod(&edu->dma_timer,
+                          qemu_clock_get_ms(QEMU_CLOCK_VIRTUAL) + 100);
+                return;
+            }
+            if (!edu->prgr_success) {
+                /* PRGR failure, fail DMA. */
+                edu->dma.cmd &= ~EDU_DMA_RUN;
+                return;
+            }
+        } else {
+            /* timeout, fail DMA. */
+            edu->dma.cmd &= ~EDU_DMA_RUN;
+            return;
+        }
+        res = pci_dma_rw(&edu->pdev, src, edu->dma_buf + dst, edu->dma.cnt,
+            DMA_DIRECTION_TO_DEVICE, attrs);
+        if (res != MEMTX_OK) {
+            hw_error("EDU: DMA transfer TO 0x%"PRIx64" failed.\n", dst);
+        }
     } else {
         uint64_t src = edu->dma.src;
+        uint64_t dst = edu_clamp_addr(edu, edu->dma.dst);
         edu_check_range(src, edu->dma.cnt, DMA_START, DMA_SIZE);
         src -= DMA_START;
-        pci_dma_rw(&edu->pdev, edu_clamp_addr(edu, edu->dma.dst),
-                edu->dma_buf + src, edu->dma.cnt,
-                DMA_DIRECTION_FROM_DEVICE, attrs);
+        if (edu->try-- == NUM_TRIES) {
+            edu->prgr_rcvd = false;
+            if (!(pci_dma_perm(&edu->pdev, dst, attrs) & IOMMU_WO)) {
+                timer_mod(&edu->dma_timer,
+                          qemu_clock_get_ms(QEMU_CLOCK_VIRTUAL) + 100);
+                return;
+            }
+        } else if (edu->try) {
+            if (!edu->prgr_rcvd) {
+                timer_mod(&edu->dma_timer,
+                          qemu_clock_get_ms(QEMU_CLOCK_VIRTUAL) + 100);
+                return;
+            }
+            if (!edu->prgr_success) {
+                /* PRGR failure, fail DMA. */
+                edu->dma.cmd &= ~EDU_DMA_RUN;
+                return;
+            }
+        } else {
+            /* timeout, fail DMA. */
+            edu->dma.cmd &= ~EDU_DMA_RUN;
+            return;
+        }
+        res = pci_dma_rw(&edu->pdev, dst, edu->dma_buf + src, edu->dma.cnt,
+            DMA_DIRECTION_FROM_DEVICE, attrs);
+        if (res != MEMTX_OK) {
+            hw_error("EDU: DMA transfer FROM 0x%"PRIx64" failed.\n", src);
+        }
     }
 
     edu->dma.cmd &= ~EDU_DMA_RUN;
@@ -193,6 +322,7 @@ static void dma_rw(EduState *edu, bool write, dma_addr_t *val, dma_addr_t *dma,
     }
 
     if (timer) {
+        edu->try = NUM_TRIES;
         timer_mod(&edu->dma_timer, qemu_clock_get_ms(QEMU_CLOCK_VIRTUAL) + 100);
     }
 }
@@ -376,9 +506,92 @@ static void *edu_fact_thread(void *opaque)
     return NULL;
 }
 
+static void edu_iommu_ats_prgr_notify(IOMMUNotifier *n, IOMMUTLBEntry *iotlb)
+{
+    struct edu_iommu *iommu = container_of(n, struct edu_iommu, n);
+    EduState *edu = iommu->edu;
+    edu->prgr_success = (iotlb->perm != IOMMU_NONE);
+    barrier();
+    edu->prgr_rcvd = true;
+}
+
+static void edu_iommu_ats_inval_notify(IOMMUNotifier *n,
+                                       IOMMUTLBEntry *iotlb)
+{
+
+}
+
+static void edu_iommu_region_add(MemoryListener *listener,
+                                   MemoryRegionSection *section)
+{
+    EduState *edu = container_of(listener, EduState, iommu_listener);
+    struct edu_iommu *iommu;
+    Int128 end;
+    int iommu_idx;
+    IOMMUMemoryRegion *iommu_mr;
+
+    if (!memory_region_is_iommu(section->mr)) {
+        return;
+    }
+
+    iommu_mr = IOMMU_MEMORY_REGION(section->mr);
+
+    /* Register ATS.INVAL notifier */
+    iommu = g_malloc0(sizeof(*iommu));
+    iommu->iommu_mr = iommu_mr;
+    iommu->iommu_offset = section->offset_within_address_space -
+                          section->offset_within_region;
+    iommu->edu = edu;
+    end = int128_add(int128_make64(section->offset_within_region),
+                     section->size);
+    end = int128_sub(end, int128_one());
+    iommu_idx = memory_region_iommu_attrs_to_index(iommu_mr,
+                                                   MEMTXATTRS_UNSPECIFIED);
+    iommu_notifier_init(&iommu->n, edu_iommu_ats_inval_notify,
+                        IOMMU_NOTIFIER_DEVIOTLB_UNMAP,
+                        section->offset_within_region,
+                        int128_get64(end),
+                        iommu_idx);
+    memory_region_register_iommu_notifier(section->mr, &iommu->n, NULL);
+    QLIST_INSERT_HEAD(&edu->iommu_list, iommu, iommu_next);
+
+    /* Register ATS.PRGR notifier */
+    iommu = g_memdup2(iommu, sizeof(*iommu));
+    iommu_notifier_init(&iommu->n, edu_iommu_ats_prgr_notify,
+                        IOMMU_NOTIFIER_MAP,
+                        section->offset_within_region,
+                        int128_get64(end),
+                        iommu_idx);
+    memory_region_register_iommu_notifier(section->mr, &iommu->n, NULL);
+    QLIST_INSERT_HEAD(&edu->iommu_list, iommu, iommu_next);
+}
+
+static void edu_iommu_region_del(MemoryListener *listener,
+                                   MemoryRegionSection *section)
+{
+    EduState *edu = container_of(listener, EduState, iommu_listener);
+    struct edu_iommu *iommu;
+
+    if (!memory_region_is_iommu(section->mr)) {
+        return;
+    }
+
+    QLIST_FOREACH(iommu, &edu->iommu_list, iommu_next) {
+        if (MEMORY_REGION(iommu->iommu_mr) == section->mr &&
+            iommu->n.start == section->offset_within_region) {
+            memory_region_unregister_iommu_notifier(section->mr,
+                                                    &iommu->n);
+            QLIST_REMOVE(iommu, iommu_next);
+            g_free(iommu);
+            break;
+        }
+    }
+}
+
 static void pci_edu_realize(PCIDevice *pdev, Error **errp)
 {
     EduState *edu = EDU(pdev);
+    AddressSpace *dma_as = NULL;
     uint8_t *pci_conf = pdev->config;
     int pos;
 
@@ -390,9 +603,28 @@ static void pci_edu_realize(PCIDevice *pdev, Error **errp)
     pos = PCI_CONFIG_SPACE_SIZE;
     if (edu->enable_pasid) {
         /* PCIe Spec 7.8.9 PASID Extended Capability Structure */
-        pcie_add_capability(pdev, 0x1b, 1, pos, 8);
+        pcie_add_capability(pdev, PCI_EXT_CAP_ID_PASID, 1, pos, 8);
         pci_set_long(pdev->config + pos + 4, 0x00001400);
         pci_set_long(pdev->wmask + pos + 4,  0xfff0ffff);
+        pos += 8;
+
+        /* ATS Capability */
+        pcie_ats_init(pdev, pos, true);
+        pos += PCI_EXT_CAP_ATS_SIZEOF;
+
+        /* PRI Capability */
+        pcie_add_capability(pdev, PCI_EXT_CAP_ID_PRI, 1, pos, 16);
+        /* PRI STOPPED */
+        pci_set_long(pdev->config + pos +  4, 0x01000000);
+        /* PRI ENABLE bit writable */
+        pci_set_long(pdev->wmask  + pos +  4, 0x00000001);
+        /* PRI Capacity Supported */
+        pci_set_long(pdev->config + pos +  8, 0x00000080);
+        /* PRI Allocations Allowed, 32 */
+        pci_set_long(pdev->config + pos + 12, 0x00000040);
+        pci_set_long(pdev->wmask  + pos + 12, 0x0000007f);
+
+        pos += 8;
     }
 
     if (msi_init(pdev, 0, 1, true, false, errp)) {
@@ -409,12 +641,24 @@ static void pci_edu_realize(PCIDevice *pdev, Error **errp)
     memory_region_init_io(&edu->mmio, OBJECT(edu), &edu_mmio_ops, edu,
                     "edu-mmio", 1 * MiB);
     pci_register_bar(pdev, 0, PCI_BASE_ADDRESS_SPACE_MEMORY, &edu->mmio);
+
+    /* Register IOMMU listener */
+    edu->iommu_listener = (MemoryListener) {
+        .name = "edu-iommu",
+        .region_add = edu_iommu_region_add,
+        .region_del = edu_iommu_region_del,
+    };
+
+    dma_as = pci_device_iommu_address_space(pdev);
+    memory_listener_register(&edu->iommu_listener, dma_as);
 }
 
 static void pci_edu_uninit(PCIDevice *pdev)
 {
     EduState *edu = EDU(pdev);
 
+    memory_listener_unregister(&edu->iommu_listener);
+
     qemu_mutex_lock(&edu->thr_mutex);
     edu->stopping = true;
     qemu_mutex_unlock(&edu->thr_mutex);
-- 
2.43.2


