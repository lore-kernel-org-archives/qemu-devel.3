Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0E586EA7942
	for <qemu-devel@archiver.kernel.org>; Wed,  4 Feb 2026 19:04:27 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vni9z-0006kI-6h; Wed, 04 Feb 2026 14:03:31 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1vni9x-0006ie-3F
 for qemu-devel@nongnu.org; Wed, 04 Feb 2026 14:03:29 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1vni9v-0007lR-An
 for qemu-devel@nongnu.org; Wed, 04 Feb 2026 14:03:28 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1770231806;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=fvEsUtD4PbmE+Ms6GIDHh3NZPUYzXZdD4oNou5cZ8kI=;
 b=e4ztpHpokD0Lq58O91pd4tDwmGlWrxa8u8LHwmuJtL3BFkdPKLkLMaKmhmKyv3yk2ZzSzV
 L4848oUTBONhObD3x61UK8l+bV5zcVUrGzfBEll1fy9MANE1RZyafYzolz7zxJ/gZ6cCjK
 YHe4ABhdcdK7ATiCFftl7tGASGcI+0w=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-138-KfdjpgtBPeCpVuONFhQwDA-1; Wed, 04 Feb 2026 14:03:25 -0500
X-MC-Unique: KfdjpgtBPeCpVuONFhQwDA-1
X-Mimecast-MFC-AGG-ID: KfdjpgtBPeCpVuONFhQwDA_1770231803
Received: by mail-wr1-f71.google.com with SMTP id
 ffacd0b85a97d-43591aacca2so156043f8f.1
 for <qemu-devel@nongnu.org>; Wed, 04 Feb 2026 11:03:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1770231802; x=1770836602; darn=nongnu.org;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=fvEsUtD4PbmE+Ms6GIDHh3NZPUYzXZdD4oNou5cZ8kI=;
 b=eJMLG4nynrTgNNBE0aDfuGLhsWdUNR5Vt+nxbiJhf11jfX7Ku9VAr05j7dNrhc4W9l
 Gff0Y5UPLWTrwuWNGRScqgr/2G+kv3nbJ9ITZ+AuQ2K0bvS3pdFdJQwC8NSsEQNx5HTY
 YrvhxRjfEvw5hThN2dh/UoBl1sIc+ZeuaceU6ArdpZSyULwP7tt/gKDj3fLgRtkZFdIm
 vbxJliTfSnN5ZegZNGq8abVmE57XrDi3dT9M37QVQe5RnSvX9pPZDdOzcWwvAq3KkNT6
 n8ATAlWcqOFwfzA7XobJ0Hj+hc3UgV97sDNfHkjxDpZ7im2G3ryhK1JvT9/cjWfGUbUO
 kJwQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1770231802; x=1770836602;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=fvEsUtD4PbmE+Ms6GIDHh3NZPUYzXZdD4oNou5cZ8kI=;
 b=R9HOpISzZsgRXizgU3ggf0jRMVS58K0hRSdJ4DnV8yZ2LilP4xy77IlgnIKsun8SEu
 EqlKzj4jhdtb/e5wRdz7shkQFSuElpFN6nF4Hdyw6t/TlJisxpAPdlEbrmuF/H7gsuh4
 RfLgchJvNfJl+zbB2qk6yTgSj765h2GBWBVNXmA51yIR2mKBpu+fI/AEvMRfoAt/Fmzz
 D3bm73C761qLiM6bD+bpBiquOOcjVJkq+tDK9ERk5x/vz26veZz+4RgG5jzTB+XbwMb7
 INmDwN8bx572k+OMDbelnSDRTd2kLYOvwq9F7eKgSNll1r7KyPpI0oOsQT1Eh1i0smzw
 IVew==
X-Gm-Message-State: AOJu0Yz2qEuPHuttG95zEbgHac5Ah9pWX5rWq69kFo1rSJRtwVw1jZIa
 hEKiH6s9KyF8PXDl1WjCl6pg5R87xhcdQzXqP5nvOkisEedHovogfYxe52XSDeLGuLejYAvssJg
 UB3mIHdDn9VweBzd8mHRgf8NLnUbZFo9sh0wsftcWys4Yc5PzCdPMADGpxZUcG6WlxnxSBlsMWY
 5gt+ZtXWsZcSFTcS2oCyw2ujcGLTDCgQwdDw==
X-Gm-Gg: AZuq6aLcRCw++4PReUQ/GqfzJvYPrmlphSkTiiqLfMFWd8rt3eFFdlkR5VBTD1DabuF
 qLgkX2Qh3V+Ee8sbPUmo9iyCF/QGpdWkZjkb68FcNaFWHpxhXua24/hwG0K1wDT0sKUrvoggolb
 q3/2EpNbevOhPHI8ZsFcvVp9TXvDorkKosi3KG3aq42cuODgNQEaSkg2R6+5/Er7GCq9It7rfrf
 /IhJ05NYUzyz7qVXWjmwSZeNUbc6ndZ/DoVgBWOJNeOj+AuWELh2F+TjQTn7mRY6i10yPuIvBsd
 oMYo8FLBw9NAnEUK/DVLtT1XB5oR+mB647CnEzKxgqMUy8+GUEIqXe41icZby6ZEhrf18auLodu
 68to1zbfL2kjGvf2R2geII0/0YNnJ4aUG0w==
X-Received: by 2002:a05:6000:2882:b0:436:141:82f8 with SMTP id
 ffacd0b85a97d-43617e41f07mr6095256f8f.25.1770231802325; 
 Wed, 04 Feb 2026 11:03:22 -0800 (PST)
X-Received: by 2002:a05:6000:2882:b0:436:141:82f8 with SMTP id
 ffacd0b85a97d-43617e41f07mr6095194f8f.25.1770231801767; 
 Wed, 04 Feb 2026 11:03:21 -0800 (PST)
Received: from redhat.com (IGLD-80-230-34-155.inter.net.il. [80.230.34.155])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-4361805faddsm8349158f8f.33.2026.02.04.11.03.20
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 04 Feb 2026 11:03:21 -0800 (PST)
Date: Wed, 4 Feb 2026 14:03:19 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>,
 CLEMENT MATHIEU--DRIF <clement.mathieu--drif@eviden.com>,
 Jason Wang <jasowang@redhat.com>, Yi Liu <yi.l.liu@intel.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Eduardo Habkost <eduardo@habkost.net>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>
Subject: [PULL 13/51] intel_iommu: Support memory operations with
 pre-translated addresses
Message-ID: <40376c5eb89f2961fef811db0ca4c15dfa673a6b.1770231744.git.mst@redhat.com>
References: <cover.1770231744.git.mst@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1770231744.git.mst@redhat.com>
X-Mailer: git-send-email 2.27.0.106.g8ac3dc51b1
X-Mutt-Fcc: =sent
Received-SPF: pass client-ip=170.10.133.124; envelope-from=mst@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

From: CLEMENT MATHIEU--DRIF <clement.mathieu--drif@eviden.com>

Signed-off-by: Clement Mathieu--Drif <clement.mathieu--drif@eviden.com>
Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
Message-Id: <20251029105137.1097933-3-clement.mathieu--drif@eviden.com>
---
 hw/i386/intel_iommu.c | 118 +++++++++++++++++++++++++++++-------------
 1 file changed, 81 insertions(+), 37 deletions(-)

diff --git a/hw/i386/intel_iommu.c b/hw/i386/intel_iommu.c
index 80b21a6468..7e7c31cb55 100644
--- a/hw/i386/intel_iommu.c
+++ b/hw/i386/intel_iommu.c
@@ -3985,6 +3985,25 @@ static void vtd_mem_write(void *opaque, hwaddr addr,
     }
 }
 
+static void vtd_prepare_identity_entry(hwaddr addr, IOMMUAccessFlags perm,
+                                         uint32_t pasid, IOMMUTLBEntry *iotlb)
+{
+    iotlb->iova = addr & VTD_PAGE_MASK_4K;
+    iotlb->translated_addr = addr & VTD_PAGE_MASK_4K;
+    iotlb->addr_mask = ~VTD_PAGE_MASK_4K;
+    iotlb->perm = perm;
+    iotlb->pasid = pasid;
+}
+
+static inline void vtd_prepare_error_entry(IOMMUTLBEntry *entry)
+{
+    entry->iova = 0;
+    entry->translated_addr = 0;
+    entry->addr_mask = ~VTD_PAGE_MASK_4K;
+    entry->perm = IOMMU_NONE;
+    entry->pasid = PCI_NO_PASID;
+}
+
 static IOMMUTLBEntry vtd_iommu_translate(IOMMUMemoryRegion *iommu, hwaddr addr,
                                          IOMMUAccessFlags flag, int iommu_idx)
 {
@@ -3996,16 +4015,29 @@ static IOMMUTLBEntry vtd_iommu_translate(IOMMUMemoryRegion *iommu, hwaddr addr,
         .pasid = vtd_as->pasid,
     };
     bool success;
+    bool is_write = flag & IOMMU_WO;
 
     if (likely(s->dmar_enabled)) {
-        success = vtd_do_iommu_translate(vtd_as, vtd_as->bus, vtd_as->devfn,
-                                         addr, flag & IOMMU_WO, &iotlb);
+        /* Only support translated requests in scalable mode */
+        if (iommu_idx == VTD_IDX_TRANSLATED && s->root_scalable) {
+            if (vtd_as->pasid == PCI_NO_PASID) {
+                vtd_prepare_identity_entry(addr, IOMMU_RW, PCI_NO_PASID,
+                                           &iotlb);
+                success = true;
+            } else {
+                vtd_prepare_error_entry(&iotlb);
+                error_report_once("%s: translated request with PASID not "
+                                  "allowed (pasid=0x%" PRIx32 ")", __func__,
+                                  vtd_as->pasid);
+                success = false;
+            }
+        } else {
+            success = vtd_do_iommu_translate(vtd_as, vtd_as->bus, vtd_as->devfn,
+                                            addr, is_write, &iotlb);
+        }
     } else {
         /* DMAR disabled, passthrough, use 4k-page*/
-        iotlb.iova = addr & VTD_PAGE_MASK_4K;
-        iotlb.translated_addr = addr & VTD_PAGE_MASK_4K;
-        iotlb.addr_mask = ~VTD_PAGE_MASK_4K;
-        iotlb.perm = IOMMU_RW;
+        vtd_prepare_identity_entry(addr, IOMMU_RW, vtd_as->pasid, &iotlb);
         success = true;
     }
 
@@ -4414,6 +4446,37 @@ static int vtd_int_remap(X86IOMMUState *iommu, MSIMessage *src,
                                    src, dst, sid, false);
 }
 
+static void vtd_report_sid_ir_illegal_access(IntelIOMMUState *s, uint16_t sid,
+                                             uint32_t pasid, hwaddr addr,
+                                             bool is_write)
+{
+    uint8_t bus_n = VTD_SID_TO_BUS(sid);
+    uint8_t devfn = VTD_SID_TO_DEVFN(sid);
+    bool is_fpd_set = false;
+    VTDContextEntry ce;
+
+    /* Try out best to fetch FPD, we can't do anything more */
+    if (vtd_dev_to_context_entry(s, bus_n, devfn, &ce) == 0) {
+        is_fpd_set = ce.lo & VTD_CONTEXT_ENTRY_FPD;
+        if (!is_fpd_set && s->root_scalable) {
+            vtd_ce_get_pasid_fpd(s, &ce, &is_fpd_set, pasid);
+        }
+    }
+
+    vtd_report_fault(s, VTD_FR_SM_INTERRUPT_ADDR, is_fpd_set, sid, addr,
+                     is_write, pasid != PCI_NO_PASID, pasid);
+}
+
+static void vtd_report_ir_illegal_access(VTDAddressSpace *vtd_as,
+                                         hwaddr addr, bool is_write)
+{
+    uint8_t bus_n = pci_bus_num(vtd_as->bus);
+    uint16_t sid = PCI_BUILD_BDF(bus_n, vtd_as->devfn);
+
+    vtd_report_sid_ir_illegal_access(vtd_as->iommu_state, sid, vtd_as->pasid,
+                                     addr, is_write);
+}
+
 static MemTxResult vtd_mem_ir_read(void *opaque, hwaddr addr,
                                    uint64_t *data, unsigned size,
                                    MemTxAttrs attrs)
@@ -4425,9 +4488,11 @@ static MemTxResult vtd_mem_ir_write(void *opaque, hwaddr addr,
                                     uint64_t value, unsigned size,
                                     MemTxAttrs attrs)
 {
+    IntelIOMMUState *s = opaque;
     int ret = 0;
     MSIMessage from = {}, to = {};
     uint16_t sid = X86_IOMMU_SID_INVALID;
+    uint32_t pasid;
 
     from.address = (uint64_t) addr + VTD_INTERRUPT_ADDR_FIRST;
     from.data = (uint32_t) value;
@@ -4435,9 +4500,16 @@ static MemTxResult vtd_mem_ir_write(void *opaque, hwaddr addr,
     if (!attrs.unspecified) {
         /* We have explicit Source ID */
         sid = attrs.requester_id;
+        pasid = attrs.pid != 0 ? attrs.pid : PCI_NO_PASID;
+
+        if (attrs.address_type == PCI_AT_TRANSLATED &&
+            sid != X86_IOMMU_SID_INVALID) {
+            vtd_report_sid_ir_illegal_access(s, sid, pasid, from.address, true);
+            return MEMTX_ERROR;
+        }
     }
 
-    ret = vtd_interrupt_remap_msi(opaque, &from, &to, sid, true);
+    ret = vtd_interrupt_remap_msi(s, &from, &to, sid, true);
     if (ret) {
         /* Drop this interrupt */
         return MEMTX_ERROR;
@@ -4462,30 +4534,6 @@ static const MemoryRegionOps vtd_mem_ir_ops = {
     },
 };
 
-static void vtd_report_ir_illegal_access(VTDAddressSpace *vtd_as,
-                                         hwaddr addr, bool is_write)
-{
-    IntelIOMMUState *s = vtd_as->iommu_state;
-    uint8_t bus_n = pci_bus_num(vtd_as->bus);
-    uint16_t sid = PCI_BUILD_BDF(bus_n, vtd_as->devfn);
-    bool is_fpd_set = false;
-    VTDContextEntry ce;
-
-    assert(vtd_as->pasid != PCI_NO_PASID);
-
-    /* Try out best to fetch FPD, we can't do anything more */
-    if (vtd_dev_to_context_entry(s, bus_n, vtd_as->devfn, &ce) == 0) {
-        is_fpd_set = ce.lo & VTD_CONTEXT_ENTRY_FPD;
-        if (!is_fpd_set && s->root_scalable) {
-            vtd_ce_get_pasid_fpd(s, &ce, &is_fpd_set, vtd_as->pasid);
-        }
-    }
-
-    vtd_report_fault(s, VTD_FR_SM_INTERRUPT_ADDR,
-                     is_fpd_set, sid, addr, is_write,
-                     true, vtd_as->pasid);
-}
-
 static MemTxResult vtd_mem_ir_fault_read(void *opaque, hwaddr addr,
                                          uint64_t *data, unsigned size,
                                          MemTxAttrs attrs)
@@ -5145,14 +5193,10 @@ static IOMMUTLBEntry vtd_iommu_ats_do_translate(IOMMUMemoryRegion *iommu,
 
     if (vtd_is_interrupt_addr(addr)) {
         vtd_report_ir_illegal_access(vtd_as, addr, flags & IOMMU_WO);
+        vtd_prepare_error_entry(&entry);
         entry.target_as = &address_space_memory;
-        entry.iova = 0;
-        entry.translated_addr = 0;
-        entry.addr_mask = ~VTD_PAGE_MASK_4K;
-        entry.perm = IOMMU_NONE;
-        entry.pasid = PCI_NO_PASID;
     } else {
-        entry = vtd_iommu_translate(iommu, addr, flags, 0);
+        entry = vtd_iommu_translate(iommu, addr, flags, VTD_IDX_UNTRANSLATED);
     }
 
     return entry;
-- 
MST


