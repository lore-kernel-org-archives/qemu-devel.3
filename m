Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 328D8C4451B
	for <qemu-devel@archiver.kernel.org>; Sat, 18 Jul 2026 17:52:47 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wl9D3-0004bw-3U; Sat, 18 Jul 2026 13:52:21 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <danielpaziyski@gmail.com>)
 id 1wl9D1-0004bZ-5B
 for qemu-devel@nongnu.org; Sat, 18 Jul 2026 13:52:19 -0400
Received: from mail-wm1-x32f.google.com ([2a00:1450:4864:20::32f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <danielpaziyski@gmail.com>)
 id 1wl9Cy-00081W-VC
 for qemu-devel@nongnu.org; Sat, 18 Jul 2026 13:52:18 -0400
Received: by mail-wm1-x32f.google.com with SMTP id
 5b1f17b1804b1-490d6730461so10053075e9.3
 for <qemu-devel@nongnu.org>; Sat, 18 Jul 2026 10:52:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1784397135; x=1785001935; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=3uDNuslyYdBmpRzW9mOI+m+LtQ3M11xiT3tdksQ7zfU=;
 b=W/1sj2t5p2oO+6/yF0eBi3BemI35UyUekanGzG5SfRx90RHdXW1b8tTUjxrnfeUCTF
 Yw0BoJsRJ9iUuh92a0nIq05lk42T7Q4ZSeOMUBt0VJ8iFvaleScVcvTUlDKM89xe35yU
 LqRZgLZ95pv+R40pn0x1tCjSzF9f0Ai3vwc0lrUBgBmNMHI0AA4dy0PDovfbzyI2iaah
 8ZbdLL5jUu4oUxfEaQleObxzoW8iEbDEM1OEE9JRNhok97x8Gyxbdjluzcqlcc39XTv0
 nIRRNnnctJ4PgRUfqko1z+y1M6SOdV3LHNUERampUoctj0JH4hAstBGr4+pF7ZERBGUO
 qFQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1784397135; x=1785001935;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=3uDNuslyYdBmpRzW9mOI+m+LtQ3M11xiT3tdksQ7zfU=;
 b=LIfcFklO4tKwslcNkfChY/Q1TbNwWKqQoaWzyw1wAy4EfZ192Q2pNhSO5WWRngLVP7
 Qbfcu5Cx0PpP0wSvF1hodF1/vCwaC4zZN3jtBD/A5QoglBEJMQGuPH23dO2l6Z4FU0/s
 4/zAYW/nkp5X1YAcOwu+buZM+dkCN192ltxRQN+mPIkSA6PkkocqeeJps4li3e52+hef
 BzCog/uWX7bf+C/8Iiw39JtHlZehUikPuROyc741bsASnSAdg7RE4FzIvLC8q3ruGmGx
 6SP5Duo4XV3wqqSdcpwx/+CxhMGaIz62k9uKvsCC18z89OnwND7rEjP413uBmQrY6gVA
 kbpA==
X-Forwarded-Encrypted: i=1;
 AHgh+Rp6bdRUDxfT0UYLm0l2wRvmwd5kbf6F8AYRdUKVLdK5auROlS8qG3zCnbnHdYI9PFSdn6cxnxCeQt6q@nongnu.org
X-Gm-Message-State: AOJu0Yx7SYasY8DresvFUIbt0ovbhrK/805FivpaNOiPJ24lQCJTwJ3H
 Wtrg+qcx50gS7funtMzgGMvPui5HYkuFVwUz8ufCO58RXgG3ATrJA8Nc
X-Gm-Gg: AfdE7clP1/Xav/OpU10uVvL8MBTRfdVncbABZDApVIV0utpVFH0/1NQ8ex5rMio12gf
 oj9la7Di2tGisYix0pDXRbje3+CchHroTlv8irL4SSX9Wvuk6BiCbK3aqfl+eEaZsavrmP4SyA3
 aBSusBO8j7S/uyfMuC2RASqAB5thsWJZrRdGuVIPcBZ3eYRDKBa1tzpJNbg73AKviz4lRs+jM2b
 LvVYvVEki/SWGVf9mbxC3VoDV3sg+kbDroJMK3k8ZlLoaRT3QarHpUsCQgc2yPltARijHz6vnv0
 gyegHTtEW0X85610uwzk3t/dr7vKhsfxHZ2e6m63mzWOBJ6sjcVwjlTVWWom5wENFxz+oecqupG
 XV93cUaNRZIvZ7/Bec7b3DAPmOSPGDisNhiqShN1pO6ExKl5/6F/eY2ktIuE5DROn1aqrrOAAVt
 U=
X-Received: by 2002:a05:600c:1c0b:b0:493:fe47:d528 with SMTP id
 5b1f17b1804b1-4954a51b6d3mr55526215e9.8.1784397134977; 
 Sat, 18 Jul 2026 10:52:14 -0700 (PDT)
Received: from AtiePC ([79.117.54.17]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-47f63e52aa4sm15220181f8f.10.2026.07.18.10.52.13
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 18 Jul 2026 10:52:14 -0700 (PDT)
From: Daniel Paziyski <danielpaziyski@gmail.com>
To: Alejandro Jimenez <alejandro.j.jimenez@oracle.com>,
 "Michael S. Tsirkin" <mst@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Fabiano Rosas <farosas@suse.de>, Laurent Vivier <lvivier@redhat.com>
Cc: Daniel Paziyski <danielpaziyski@gmail.com>,
 Sairaj Kodilkar <sarunkod@amd.com>,
 qemu-devel@nongnu.org (open list:All patches CC here)
Subject: [PATCH 1/2] amd_iommu: Honor DTE[IR] and DTE[IW] when DTE[Mode] is 0
Date: Sat, 18 Jul 2026 19:52:06 +0200
Message-ID: <20260718175208.118721-2-danielpaziyski@gmail.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260718175208.118721-1-danielpaziyski@gmail.com>
References: <20260718175208.118721-1-danielpaziyski@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32f;
 envelope-from=danielpaziyski@gmail.com; helo=mail-wm1-x32f.google.com
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

In an AMD IOMMU's Device Table Entry (DTE), the Mode field specifies the number
of levels that the page table hierarchy for translating Guest Physical Addresses
(GPAs) to System Physical Addresses (SPAs) will have. When the DTE is valid and
translation is active (V = 1, TV = 1), and Mode is equal to 0, then the IOMMU
will act as a "filter": GPAs are the same as SPAs, but, whether reads or writes
are allowed depends on the values of I/O read permission (IR) and I/O write
permission (IW) in the DTE.

In the current code, the values of IR and IW are considered only when traversing
the page tables for translating GPAs to SPAs when Mode is not 0 (and are ANDed
with their counterparts in the page tables to determine the final permission),
and when the DTE for a device is in passthrough mode (Mode is 0), IR and IW
are not taken into consideration, and access is given unconditionally, which
conflicts with the specification.

This patch implements honoring of the IR and IW DTE bits when Mode is 0. To do
so, both the iommu and iommu_nodma memory regions in the AMDVIAddressSpace
struct are preserved, and a new field is added, passthrough_perms, which along
with addr_translation will determine whether the iommu or the iommu_nodma memory
region will be used.

After a DTE invalidation, passthrough_perms and addr_translation will be set
accordingly with the new DTE configuration, and when it's time to switch address
spaces in amdvi_switch_address_space:

    - Iff passthrough is desired and IR = 1 and IW = 1, use the iommu_nodma
      memory region,

    - otherwise, use the iommu memory region.

The handler for translation (amdvi_translate), which is called when the iommu
memory region is enabled, has a fastpath which handles passthrough mode and
verifies permissions. Additionally, since the DTE is fetched in the page walker,
and it is possible for it to have been updated concurrently, if passthrough mode
is requested, it is handled properly. Moreover, care has been taken to not fill
the IOTLB with entries handed out when passthrough is active.

Also, for the sake of easier debugging, the trace_amdvi_page_fault tracepoint
now also takes the BDF of the device which has caused the page fault.

Signed-off-by: Daniel Paziyski <danielpaziyski@gmail.com>
---
 hw/i386/amd_iommu.c  | 136 +++++++++++++++++++++++++++++--------------
 hw/i386/trace-events |   2 +-
 2 files changed, 92 insertions(+), 46 deletions(-)

diff --git a/hw/i386/amd_iommu.c b/hw/i386/amd_iommu.c
index 90252c52af..10d75a5088 100644
--- a/hw/i386/amd_iommu.c
+++ b/hw/i386/amd_iommu.c
@@ -54,6 +54,8 @@ struct AMDVIAddressSpace {
     IOVATree *iova_tree;
     /* DMA address translation active */
     bool addr_translation;
+    /* Permissions for direct map when DMA address translation is not active */
+    unsigned passthrough_perms;
 };
 
 /* AMDVI cache entry */
@@ -1162,34 +1164,16 @@ static void amdvi_switch_address_space(AMDVIAddressSpace *amdvi_as)
 {
     AMDVIState *s = amdvi_as->iommu_state;
 
-    if (s->dma_remap && amdvi_as->addr_translation) {
-        /* Enabling DMA region */
-        memory_region_set_enabled(&amdvi_as->iommu_nodma, false);
-        memory_region_set_enabled(MEMORY_REGION(&amdvi_as->iommu), true);
-    } else {
-        /* Disabling DMA region, using passthrough */
-        memory_region_set_enabled(MEMORY_REGION(&amdvi_as->iommu), false);
-        memory_region_set_enabled(&amdvi_as->iommu_nodma, true);
+    if (!(s->dma_remap && amdvi_as->addr_translation)) {
+        if (amdvi_as->passthrough_perms == (AMDVI_PERM_READ | AMDVI_PERM_WRITE)) {
+            memory_region_set_enabled(MEMORY_REGION(&amdvi_as->iommu), false);
+            memory_region_set_enabled(&amdvi_as->iommu_nodma, true);
+            return;
+        }
     }
-}
-
-/*
- * For all existing address spaces managed by the IOMMU, enable/disable the
- * corresponding memory regions to reset the address translation mode and
- * use passthrough by default.
- */
-static void amdvi_reset_address_translation_all(AMDVIState *s)
-{
-    AMDVIAddressSpace *iommu_as;
-    GHashTableIter as_it;
-
-    g_hash_table_iter_init(&as_it, s->address_spaces);
 
-    while (g_hash_table_iter_next(&as_it, NULL, (void **)&iommu_as)) {
-        /* Use passthrough as default mode after reset */
-        iommu_as->addr_translation = false;
-        amdvi_switch_address_space(iommu_as);
-    }
+    memory_region_set_enabled(&amdvi_as->iommu_nodma, false);
+    memory_region_set_enabled(MEMORY_REGION(&amdvi_as->iommu), true);
 }
 
 static void enable_dma_mode(AMDVIAddressSpace *as, bool inval_current)
@@ -1222,23 +1206,43 @@ static void enable_dma_mode(AMDVIAddressSpace *as, bool inval_current)
  * - invalidate all existing mappings
  * - switch to no_dma memory region
  */
-static void enable_nodma_mode(AMDVIAddressSpace *as)
+static void enable_nodma_mode(AMDVIAddressSpace *as, unsigned perms)
 {
     IOMMUNotifier *n;
 
-    if (!as->addr_translation) {
+    if (!as->addr_translation && as->passthrough_perms == perms) {
         /* passthrough is already active, nothing to do */
         return;
     }
 
-    as->addr_translation = false;
     IOMMU_NOTIFIER_FOREACH(n, &as->iommu) {
         /* Drop all mappings for the address space */
         amdvi_address_space_unmap(as, n);
     }
+
+    as->addr_translation = false;
+    as->passthrough_perms = perms;
     amdvi_switch_address_space(as);
 }
 
+/*
+ * For all existing address spaces managed by the IOMMU, enable/disable the
+ * corresponding memory regions to reset the address translation mode and
+ * use passthrough by default.
+ */
+static void amdvi_reset_address_translation_all(AMDVIState *s)
+{
+    AMDVIAddressSpace *iommu_as;
+    GHashTableIter as_it;
+
+    g_hash_table_iter_init(&as_it, s->address_spaces);
+
+    while (g_hash_table_iter_next(&as_it, NULL, (void **)&iommu_as)) {
+        /* Use passthrough as default mode after reset */
+        enable_nodma_mode(iommu_as, AMDVI_PERM_READ | AMDVI_PERM_WRITE);
+    }
+}
+
 /*
  * A guest driver must issue the INVALIDATE_DEVTAB_ENTRY command to the IOMMU
  * after changing a Device Table entry. We can use this fact to detect when a
@@ -1252,6 +1256,7 @@ static void amdvi_update_addr_translation_mode(AMDVIState *s, uint16_t devid)
     AMDVIAddressSpace *as;
     uint64_t dte[4] = { 0 };
     int ret;
+    unsigned perms;
 
     as = amdvi_get_as_by_devid(s, devid);
     if (!as) {
@@ -1268,14 +1273,16 @@ static void amdvi_update_addr_translation_mode(AMDVIState *s, uint16_t devid)
     case 0:
         /* DTE was successfully retrieved */
         if (!dte_mode) {
-            enable_nodma_mode(as); /* DTE[V]=1 && DTE[Mode]=0 => passthrough */
+            /* DTE[V]=1 && DTE[Mode]=0 => passthrough */
+            perms = amdvi_get_perms(dte[0]);
+            enable_nodma_mode(as, perms);
         } else {
             enable_dma_mode(as, false); /* Enable DMA translation */
         }
         break;
     case -AMDVI_FR_DTE_V:
         /* DTE[V]=0, address is passed untranslated */
-        enable_nodma_mode(as);
+        enable_nodma_mode(as, AMDVI_PERM_READ | AMDVI_PERM_WRITE);
         break;
     case -AMDVI_FR_DTE_RTR_ERR:
     case -AMDVI_FR_DTE_TV:
@@ -1889,15 +1896,45 @@ static void amdvi_mmio_write(void *opaque, hwaddr addr, uint64_t val,
     }
 }
 
+static void amdvi_fill_iotlb_entry_passthrough(IOMMUTLBEntry *entry,
+                                               AMDVIAddressSpace *as,
+                                               unsigned passthrough_perms,
+                                               hwaddr addr,
+                                               IOMMUAccessFlags flag)
+{
+    unsigned perms = 0;
+
+    if (flag & IOMMU_RO) {
+        perms |= AMDVI_PERM_READ;
+    }
+    if (flag & IOMMU_WO) {
+        perms |= AMDVI_PERM_WRITE;
+    }
+
+    if ((passthrough_perms & perms) != perms) {
+        amdvi_page_fault(as->iommu_state, as->devfn, addr, perms);
+        trace_amdvi_page_fault(addr, pci_bus_num(as->bus), PCI_SLOT(as->devfn),
+                               PCI_FUNC(as->devfn), perms);
+        return;
+    }
+
+    entry->iova = addr & AMDVI_PAGE_MASK_4K;
+    entry->translated_addr = addr & AMDVI_PAGE_MASK_4K;
+    entry->addr_mask = ~AMDVI_PAGE_MASK_4K;
+    entry->perm = flag & IOMMU_RW;
+}
+
 static void amdvi_page_walk(AMDVIAddressSpace *as, uint64_t *dte,
                             IOMMUTLBEntry *ret, unsigned perms,
-                            hwaddr addr)
+                            hwaddr addr, bool *update_iotlb)
 {
     hwaddr page_mask, pagesize = 0;
     uint8_t mode;
     uint64_t pte;
     int fetch_ret;
 
+    *update_iotlb = false;
+
     /* make sure the DTE has TV = 1 */
     if (!(dte[0] & AMDVI_DEV_TRANSLATION_VALID)) {
         /*
@@ -1916,7 +1953,9 @@ static void amdvi_page_walk(AMDVIAddressSpace *as, uint64_t *dte,
         return;
     }
     if (mode == 0) {
-        goto no_remap;
+        amdvi_fill_iotlb_entry_passthrough(ret, as, amdvi_get_perms(dte[0]),
+            addr, perms == AMDVI_PERM_WRITE ? IOMMU_WO : IOMMU_RO);
+        return;
     }
 
     /* Attempt to fetch the PTE to determine if a valid mapping exists */
@@ -1931,7 +1970,8 @@ static void amdvi_page_walk(AMDVIAddressSpace *as, uint64_t *dte,
         perms != (perms & amdvi_get_perms(pte))) {
 
         amdvi_page_fault(as->iommu_state, as->devfn, addr, perms);
-        trace_amdvi_page_fault(addr);
+        trace_amdvi_page_fault(addr, pci_bus_num(as->bus), PCI_SLOT(as->devfn),
+                               PCI_FUNC(as->devfn), perms);
         return;
     }
 
@@ -1944,13 +1984,7 @@ static void amdvi_page_walk(AMDVIAddressSpace *as, uint64_t *dte,
     ret->translated_addr = (pte & AMDVI_DEV_PT_ROOT_MASK) & page_mask;
     ret->addr_mask = ~page_mask;
     ret->perm = amdvi_get_perms(pte);
-    return;
-
-no_remap:
-    ret->iova = addr & AMDVI_PAGE_MASK_4K;
-    ret->translated_addr = addr & AMDVI_PAGE_MASK_4K;
-    ret->addr_mask = ~AMDVI_PAGE_MASK_4K;
-    ret->perm = amdvi_get_perms(dte[0]);
+    *update_iotlb = true;
 }
 
 static void amdvi_do_translate(AMDVIAddressSpace *as, hwaddr addr,
@@ -1961,6 +1995,7 @@ static void amdvi_do_translate(AMDVIAddressSpace *as, hwaddr addr,
     AMDVIIOTLBEntry *iotlb_entry = amdvi_iotlb_lookup(s, addr, devid);
     uint64_t entry[4];
     int dte_ret;
+    bool update_iotlb;
 
     if (iotlb_entry) {
         trace_amdvi_iotlb_hit(PCI_BUS_NUM(devid), PCI_SLOT(devid),
@@ -1983,10 +2018,14 @@ static void amdvi_do_translate(AMDVIAddressSpace *as, hwaddr addr,
     }
 
     amdvi_page_walk(as, entry, ret,
-                    is_write ? AMDVI_PERM_WRITE : AMDVI_PERM_READ, addr);
+                    is_write ? AMDVI_PERM_WRITE : AMDVI_PERM_READ, addr,
+                    &update_iotlb);
+
+    if (update_iotlb) {
+        amdvi_update_iotlb(s, devid, addr, *ret,
+                           entry[1] & AMDVI_DEV_DOMID_ID_MASK);
+    }
 
-    amdvi_update_iotlb(s, devid, addr, *ret,
-                       entry[1] & AMDVI_DEV_DOMID_ID_MASK);
     return;
 
 out:
@@ -2031,7 +2070,13 @@ static IOMMUTLBEntry amdvi_translate(IOMMUMemoryRegion *iommu, hwaddr addr,
         return ret;
     }
 
-    amdvi_do_translate(as, addr, flag & IOMMU_WO, &ret);
+    if (!as->addr_translation) {
+        amdvi_fill_iotlb_entry_passthrough(&ret, as, as->passthrough_perms,
+                                           addr, flag);
+    } else {
+        amdvi_do_translate(as, addr, flag & IOMMU_WO, &ret);
+    }
+
     trace_amdvi_translation_result(pci_bus_num(as->bus), PCI_SLOT(as->devfn),
             PCI_FUNC(as->devfn), addr, ret.translated_addr);
     return ret;
@@ -2423,6 +2468,7 @@ static AddressSpace *amdvi_host_dma_iommu(PCIBus *bus, void *opaque, int devfn)
         amdvi_dev_as->notifier_flags = IOMMU_NOTIFIER_NONE;
         amdvi_dev_as->iova_tree = iova_tree_new();
         amdvi_dev_as->addr_translation = false;
+        amdvi_dev_as->passthrough_perms = AMDVI_PERM_READ | AMDVI_PERM_WRITE;
         key->bus = bus;
         key->devfn = devfn;
 
diff --git a/hw/i386/trace-events b/hw/i386/trace-events
index a1a50d0910..df2d046000 100644
--- a/hw/i386/trace-events
+++ b/hw/i386/trace-events
@@ -103,7 +103,7 @@ amdvi_dte_get_fail(uint64_t addr, uint32_t offset) "error: failed to access Devi
 amdvi_invalid_dte(uint64_t addr) "PTE entry at 0x%"PRIx64" is invalid "
 amdvi_get_pte_hwerror(uint64_t addr) "hardware error eccessing PTE at addr 0x%"PRIx64
 amdvi_mode_invalid(uint8_t level, uint64_t addr)"error: translation level 0x%"PRIx8" translating addr 0x%"PRIx64
-amdvi_page_fault(uint64_t addr) "error: page fault accessing guest physical address 0x%"PRIx64
+amdvi_page_fault(uint64_t addr, uint8_t bus, uint8_t slot, uint8_t func, unsigned perms) "error: page fault accessing guest physical address 0x%"PRIx64" by devid %02x:%02x.%x with perms 0x%x"
 amdvi_iotlb_hit(uint8_t bus, uint8_t slot, uint8_t func, uint64_t addr, uint64_t txaddr) "hit iotlb devid %02x:%02x.%x gpa 0x%"PRIx64" hpa 0x%"PRIx64
 amdvi_translation_result(uint8_t bus, uint8_t slot, uint8_t func, uint64_t addr, uint64_t txaddr) "devid: %02x:%02x.%x gpa 0x%"PRIx64" hpa 0x%"PRIx64
 amdvi_mem_ir_write_req(uint64_t addr, uint64_t val, uint32_t size) "addr 0x%"PRIx64" data 0x%"PRIx64" size 0x%"PRIx32
-- 
2.55.0


