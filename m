Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 947BBC02180
	for <qemu-devel@archiver.kernel.org>; Wed, 15 Jan 2025 18:09:59 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tY7pS-0006aT-2d; Wed, 15 Jan 2025 13:09:25 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1tY7pH-0006RD-NG
 for qemu-devel@nongnu.org; Wed, 15 Jan 2025 13:09:12 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1tY7pF-0006YJ-H6
 for qemu-devel@nongnu.org; Wed, 15 Jan 2025 13:09:11 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1736964549;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=PlqjkAn1GOlm1rdBdYghPXPBG+UbFaprj+bSyaXREJY=;
 b=d25nGh0OwciEXl6gzfwLVePmLl+lEjzGD2mycI8zUV1Mtr6l2oCxj3/XCqSVHX0lGxBwg4
 RYbIwpZ3pEmGSC7XnBaYpZt7/JHNfJajt3ZJUZS/vLKQk4RwYrORSvM6VBMsBQBP5o8bVC
 7ybkPv58C2JkQ2kQXvwiDaDDgCiwhxI=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-500-6JjloW3HNmyINCvTALHAnw-1; Wed, 15 Jan 2025 13:09:06 -0500
X-MC-Unique: 6JjloW3HNmyINCvTALHAnw-1
X-Mimecast-MFC-AGG-ID: 6JjloW3HNmyINCvTALHAnw
Received: by mail-wm1-f71.google.com with SMTP id
 5b1f17b1804b1-43621907030so32468375e9.1
 for <qemu-devel@nongnu.org>; Wed, 15 Jan 2025 10:09:05 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1736964544; x=1737569344;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=PlqjkAn1GOlm1rdBdYghPXPBG+UbFaprj+bSyaXREJY=;
 b=KPw8zQqHhHLbsVUrImtQs7CHs0372+xPknVBCRMyghXoLTJ/I4sRaeSuwZRO78/c7d
 +4gCE3Pc3FYEN89HcG2A4P7skha/St2VN2bu8zK0BYSyplGTsRgHXsTerKob/z7G8QIf
 CJF1SkVWseamqgjSIUXoVID2VjA0Zz1E7gemKWAF+QminICMUVDE72bO/KPuUYaiFN/K
 KHzhY2URnNpyU/dBBMLD69Doschj6uqJ7y/ciAPnkhRosfIjtGH5VGzJcNFD5Oydj5mP
 UztlRd2zctbV9Bp4f0KpWy0+DnFWHgvzqCl7EA9+k1uxdihKpCGTCkFIrYnzSmgi+Fns
 fuVg==
X-Gm-Message-State: AOJu0Yz/6FXGXLoaTUh9XMjSEnb6l7/IMXkxnYddIY9NbAl3eArZKqUw
 oqn9Cyy5hA85Zkt4izpcWA42l8vA6M+XAmqZPp4mHeQxJPzaFP5cJgslPMbEfi9HfMJOxt9I3o4
 buMtRQZ9uQFu2QcAr4BxjDM0SplMkqxn4buqbRVf9pfJmHsmYfgfN/D+rc6rP1Zhx264p0U4GHd
 RXfqz4Vp2dqVU5uhnUZKpjmq+l37i4kA==
X-Gm-Gg: ASbGncvCAEzJSYvUR9nmKa6H9mXkzYDSL4bGu8LnY7QLZA81UKZh1xPs011OmupHh/O
 K+Gzap36scyaybrmzgagNL0XoQoQcoQcuzUsp7cwBQx5OKSIQKgcWAxt0t5QUpCoRKA0fIsMn8u
 2XIslE8JJV1+RtYpxzbOjbVFbShXOAu0wrqvTVyiVflJ/LQligjXoKf+Y7cs8NjJa6F1TS8GY8p
 6iku5Iv6qRGQDapnGx/VKv8aAI5T/OLeHdIlxvnPmWhmT3aPHLs
X-Received: by 2002:a5d:64e2:0:b0:38b:e32a:109f with SMTP id
 ffacd0b85a97d-38be32a1305mr6677603f8f.12.1736964544291; 
 Wed, 15 Jan 2025 10:09:04 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGbb1NadXNCQKHClDQfeUX4DtZr/29cTo0WLFfbmgKFfBwdd5Q8YhZQBX1pc+O06qLZdf7A3Q==
X-Received: by 2002:a5d:64e2:0:b0:38b:e32a:109f with SMTP id
 ffacd0b85a97d-38be32a1305mr6677569f8f.12.1736964543849; 
 Wed, 15 Jan 2025 10:09:03 -0800 (PST)
Received: from redhat.com ([2a0d:6fc7:342:db8c:4ec4:322b:a6a8:f411])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-38a8e4b81e4sm18569634f8f.64.2025.01.15.10.09.01
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 15 Jan 2025 10:09:03 -0800 (PST)
Date: Wed, 15 Jan 2025 13:09:00 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>, Yi Liu <yi.l.liu@intel.com>,
 =?utf-8?Q?Cl=C3=A9ment?= Mathieu--Drif <clement.mathieu--drif@eviden.com>,
 Yi Sun <yi.y.sun@linux.intel.com>,
 Zhenzhong Duan <zhenzhong.duan@intel.com>,
 Jason Wang <jasowang@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Eduardo Habkost <eduardo@habkost.net>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>
Subject: [PULL 11/48] intel_iommu: Implement stage-1 translation
Message-ID: <eb9da9d2632839c386ecbfc50f78032c9f3a75a4.1736964488.git.mst@redhat.com>
References: <cover.1736964487.git.mst@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <cover.1736964487.git.mst@redhat.com>
X-Mailer: git-send-email 2.27.0.106.g8ac3dc51b1
X-Mutt-Fcc: =sent
Received-SPF: pass client-ip=170.10.133.124; envelope-from=mst@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -39
X-Spam_score: -4.0
X-Spam_bar: ----
X-Spam_report: (-4.0 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.141,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-1.793,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

From: Yi Liu <yi.l.liu@intel.com>

This adds stage-1 page table walking to support stage-1 only
translation in scalable mode.

Signed-off-by: Yi Liu <yi.l.liu@intel.com>
Co-developed-by: Clément Mathieu--Drif <clement.mathieu--drif@eviden.com>
Signed-off-by: Clément Mathieu--Drif <clement.mathieu--drif@eviden.com>
Signed-off-by: Yi Sun <yi.y.sun@linux.intel.com>
Signed-off-by: Zhenzhong Duan <zhenzhong.duan@intel.com>
Acked-by: Jason Wang <jasowang@redhat.com>
Message-Id: <20241212083757.605022-7-zhenzhong.duan@intel.com>
Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
---
 hw/i386/intel_iommu_internal.h |  34 +++++++
 hw/i386/intel_iommu.c          | 158 ++++++++++++++++++++++++++++++++-
 2 files changed, 188 insertions(+), 4 deletions(-)

diff --git a/hw/i386/intel_iommu_internal.h b/hw/i386/intel_iommu_internal.h
index e810b0071f..86d3354198 100644
--- a/hw/i386/intel_iommu_internal.h
+++ b/hw/i386/intel_iommu_internal.h
@@ -320,6 +320,15 @@ typedef enum VTDFaultReason {
     VTD_FR_PASID_ENTRY_P = 0x59,
     VTD_FR_PASID_TABLE_ENTRY_INV = 0x5b,  /*Invalid PASID table entry */
 
+    /* Fail to access a first-level paging entry (not FS_PML4E) */
+    VTD_FR_FS_PAGING_ENTRY_INV = 0x70,
+    VTD_FR_FS_PAGING_ENTRY_P = 0x71,
+    /* Non-zero reserved field in present first-stage paging entry */
+    VTD_FR_FS_PAGING_ENTRY_RSVD = 0x72,
+    VTD_FR_PASID_ENTRY_FSPTPTR_INV = 0x73, /* Invalid FSPTPTR in PASID entry */
+    VTD_FR_FS_PAGING_ENTRY_US = 0x81,      /* Privilege violation */
+    VTD_FR_SM_WRITE = 0x85,                /* No write permission */
+
     /* Output address in the interrupt address range for scalable mode */
     VTD_FR_SM_INTERRUPT_ADDR = 0x87,
     VTD_FR_MAX,                 /* Guard */
@@ -438,6 +447,22 @@ typedef union VTDInvDesc VTDInvDesc;
         (0x3ffff800ULL | ~(VTD_HAW_MASK(aw) | VTD_SL_IGN_COM | VTD_SL_TM)) : \
         (0x3ffff800ULL | ~(VTD_HAW_MASK(aw) | VTD_SL_IGN_COM))
 
+/* Rsvd field masks for fpte */
+#define VTD_FS_UPPER_IGNORED 0xfff0000000000000ULL
+#define VTD_FPTE_PAGE_L1_RSVD_MASK(aw) \
+        (~(VTD_HAW_MASK(aw) | VTD_FS_UPPER_IGNORED))
+#define VTD_FPTE_PAGE_L2_RSVD_MASK(aw) \
+        (~(VTD_HAW_MASK(aw) | VTD_FS_UPPER_IGNORED))
+#define VTD_FPTE_PAGE_L3_RSVD_MASK(aw) \
+        (~(VTD_HAW_MASK(aw) | VTD_FS_UPPER_IGNORED))
+#define VTD_FPTE_PAGE_L4_RSVD_MASK(aw) \
+        (0x80ULL | ~(VTD_HAW_MASK(aw) | VTD_FS_UPPER_IGNORED))
+
+#define VTD_FPTE_LPAGE_L2_RSVD_MASK(aw) \
+        (0x1fe000ULL | ~(VTD_HAW_MASK(aw) | VTD_FS_UPPER_IGNORED))
+#define VTD_FPTE_LPAGE_L3_RSVD_MASK(aw) \
+        (0x3fffe000ULL | ~(VTD_HAW_MASK(aw) | VTD_FS_UPPER_IGNORED))
+
 /* Masks for PIOTLB Invalidate Descriptor */
 #define VTD_INV_DESC_PIOTLB_G             (3ULL << 4)
 #define VTD_INV_DESC_PIOTLB_ALL_IN_PASID  (2ULL << 4)
@@ -530,6 +555,15 @@ typedef struct VTDRootEntry VTDRootEntry;
 #define VTD_SM_PASID_ENTRY_AW          7ULL /* Adjusted guest-address-width */
 #define VTD_SM_PASID_ENTRY_DID(val)    ((val) & VTD_DOMAIN_ID_MASK)
 
+#define VTD_SM_PASID_ENTRY_FLPM          3ULL
+#define VTD_SM_PASID_ENTRY_FLPTPTR       (~0xfffULL)
+
+/* First Level Paging Structure */
+/* Masks for First Level Paging Entry */
+#define VTD_FL_P                    1ULL
+#define VTD_FL_RW                   (1ULL << 1)
+#define VTD_FL_US                   (1ULL << 2)
+
 /* Second Level Page Translation Pointer*/
 #define VTD_SM_PASID_ENTRY_SLPTPTR     (~0xfffULL)
 
diff --git a/hw/i386/intel_iommu.c b/hw/i386/intel_iommu.c
index dfac5982d6..bd6de71c02 100644
--- a/hw/i386/intel_iommu.c
+++ b/hw/i386/intel_iommu.c
@@ -48,6 +48,8 @@
 
 /* pe operations */
 #define VTD_PE_GET_TYPE(pe) ((pe)->val[0] & VTD_SM_PASID_ENTRY_PGTT)
+#define VTD_PE_GET_FL_LEVEL(pe) \
+    (4 + (((pe)->val[2] >> 2) & VTD_SM_PASID_ENTRY_FLPM))
 #define VTD_PE_GET_SL_LEVEL(pe) \
     (2 + (((pe)->val[0] >> 2) & VTD_SM_PASID_ENTRY_AW))
 
@@ -755,6 +757,11 @@ static inline bool vtd_is_sl_level_supported(IntelIOMMUState *s, uint32_t level)
            (1ULL << (level - 2 + VTD_CAP_SAGAW_SHIFT));
 }
 
+static inline bool vtd_is_fl_level_supported(IntelIOMMUState *s, uint32_t level)
+{
+    return level == VTD_PML4_LEVEL;
+}
+
 /* Return true if check passed, otherwise false */
 static inline bool vtd_pe_type_check(X86IOMMUState *x86_iommu,
                                      VTDPASIDEntry *pe)
@@ -838,6 +845,11 @@ static int vtd_get_pe_in_pasid_leaf_table(IntelIOMMUState *s,
             return -VTD_FR_PASID_TABLE_ENTRY_INV;
     }
 
+    if (pgtt == VTD_SM_PASID_ENTRY_FLT &&
+        !vtd_is_fl_level_supported(s, VTD_PE_GET_FL_LEVEL(pe))) {
+            return -VTD_FR_PASID_TABLE_ENTRY_INV;
+    }
+
     return 0;
 }
 
@@ -973,7 +985,11 @@ static uint32_t vtd_get_iova_level(IntelIOMMUState *s,
 
     if (s->root_scalable) {
         vtd_ce_get_rid2pasid_entry(s, ce, &pe, pasid);
-        return VTD_PE_GET_SL_LEVEL(&pe);
+        if (s->flts) {
+            return VTD_PE_GET_FL_LEVEL(&pe);
+        } else {
+            return VTD_PE_GET_SL_LEVEL(&pe);
+        }
     }
 
     return vtd_ce_get_level(ce);
@@ -1060,7 +1076,11 @@ static dma_addr_t vtd_get_iova_pgtbl_base(IntelIOMMUState *s,
 
     if (s->root_scalable) {
         vtd_ce_get_rid2pasid_entry(s, ce, &pe, pasid);
-        return pe.val[0] & VTD_SM_PASID_ENTRY_SLPTPTR;
+        if (s->flts) {
+            return pe.val[2] & VTD_SM_PASID_ENTRY_FLPTPTR;
+        } else {
+            return pe.val[0] & VTD_SM_PASID_ENTRY_SLPTPTR;
+        }
     }
 
     return vtd_ce_get_slpt_base(ce);
@@ -1800,6 +1820,12 @@ static const bool vtd_qualified_faults[] = {
     [VTD_FR_PASID_TABLE_ACCESS_ERR] = false,
     [VTD_FR_PASID_ENTRY_P] = true,
     [VTD_FR_PASID_TABLE_ENTRY_INV] = true,
+    [VTD_FR_FS_PAGING_ENTRY_INV] = true,
+    [VTD_FR_FS_PAGING_ENTRY_P] = true,
+    [VTD_FR_FS_PAGING_ENTRY_RSVD] = true,
+    [VTD_FR_PASID_ENTRY_FSPTPTR_INV] = true,
+    [VTD_FR_FS_PAGING_ENTRY_US] = true,
+    [VTD_FR_SM_WRITE] = true,
     [VTD_FR_SM_INTERRUPT_ADDR] = true,
     [VTD_FR_MAX] = false,
 };
@@ -1862,6 +1888,113 @@ out:
     trace_vtd_pt_enable_fast_path(source_id, success);
 }
 
+/*
+ * Rsvd field masks for fpte:
+ *     vtd_fpte_rsvd 4k pages
+ *     vtd_fpte_rsvd_large large pages
+ *
+ * We support only 4-level page tables.
+ */
+#define VTD_FPTE_RSVD_LEN 5
+static uint64_t vtd_fpte_rsvd[VTD_FPTE_RSVD_LEN];
+static uint64_t vtd_fpte_rsvd_large[VTD_FPTE_RSVD_LEN];
+
+static bool vtd_flpte_nonzero_rsvd(uint64_t flpte, uint32_t level)
+{
+    uint64_t rsvd_mask;
+
+    /*
+     * We should have caught a guest-mis-programmed level earlier,
+     * via vtd_is_fl_level_supported.
+     */
+    assert(level < VTD_FPTE_RSVD_LEN);
+    /*
+     * Zero level doesn't exist. The smallest level is VTD_PT_LEVEL=1 and
+     * checked by vtd_is_last_pte().
+     */
+    assert(level);
+
+    if ((level == VTD_PD_LEVEL || level == VTD_PDP_LEVEL) &&
+        (flpte & VTD_PT_PAGE_SIZE_MASK)) {
+        /* large page */
+        rsvd_mask = vtd_fpte_rsvd_large[level];
+    } else {
+        rsvd_mask = vtd_fpte_rsvd[level];
+    }
+
+    return flpte & rsvd_mask;
+}
+
+static inline bool vtd_flpte_present(uint64_t flpte)
+{
+    return !!(flpte & VTD_FL_P);
+}
+
+/*
+ * Given the @iova, get relevant @flptep. @flpte_level will be the last level
+ * of the translation, can be used for deciding the size of large page.
+ */
+static int vtd_iova_to_flpte(IntelIOMMUState *s, VTDContextEntry *ce,
+                             uint64_t iova, bool is_write,
+                             uint64_t *flptep, uint32_t *flpte_level,
+                             bool *reads, bool *writes, uint8_t aw_bits,
+                             uint32_t pasid)
+{
+    dma_addr_t addr = vtd_get_iova_pgtbl_base(s, ce, pasid);
+    uint32_t level = vtd_get_iova_level(s, ce, pasid);
+    uint32_t offset;
+    uint64_t flpte;
+
+    while (true) {
+        offset = vtd_iova_level_offset(iova, level);
+        flpte = vtd_get_pte(addr, offset);
+
+        if (flpte == (uint64_t)-1) {
+            if (level == vtd_get_iova_level(s, ce, pasid)) {
+                /* Invalid programming of pasid-entry */
+                return -VTD_FR_PASID_ENTRY_FSPTPTR_INV;
+            } else {
+                return -VTD_FR_FS_PAGING_ENTRY_INV;
+            }
+        }
+
+        if (!vtd_flpte_present(flpte)) {
+            *reads = false;
+            *writes = false;
+            return -VTD_FR_FS_PAGING_ENTRY_P;
+        }
+
+        /* No emulated device supports supervisor privilege request yet */
+        if (!(flpte & VTD_FL_US)) {
+            *reads = false;
+            *writes = false;
+            return -VTD_FR_FS_PAGING_ENTRY_US;
+        }
+
+        *reads = true;
+        *writes = (*writes) && (flpte & VTD_FL_RW);
+        if (is_write && !(flpte & VTD_FL_RW)) {
+            return -VTD_FR_SM_WRITE;
+        }
+        if (vtd_flpte_nonzero_rsvd(flpte, level)) {
+            error_report_once("%s: detected flpte reserved non-zero "
+                              "iova=0x%" PRIx64 ", level=0x%" PRIx32
+                              "flpte=0x%" PRIx64 ", pasid=0x%" PRIX32 ")",
+                              __func__, iova, level, flpte, pasid);
+            return -VTD_FR_FS_PAGING_ENTRY_RSVD;
+        }
+
+        if (vtd_is_last_pte(flpte, level)) {
+            *flptep = flpte;
+            *flpte_level = level;
+            return 0;
+        }
+
+        addr = vtd_get_pte_addr(flpte, aw_bits);
+        level--;
+    }
+}
+
 static void vtd_report_fault(IntelIOMMUState *s,
                              int err, bool is_fpd_set,
                              uint16_t source_id,
@@ -2010,8 +2143,13 @@ static bool vtd_do_iommu_translate(VTDAddressSpace *vtd_as, PCIBus *bus,
         }
     }
 
-    ret_fr = vtd_iova_to_slpte(s, &ce, addr, is_write, &pte, &level,
-                               &reads, &writes, s->aw_bits, pasid);
+    if (s->flts && s->root_scalable) {
+        ret_fr = vtd_iova_to_flpte(s, &ce, addr, is_write, &pte, &level,
+                                   &reads, &writes, s->aw_bits, pasid);
+    } else {
+        ret_fr = vtd_iova_to_slpte(s, &ce, addr, is_write, &pte, &level,
+                                   &reads, &writes, s->aw_bits, pasid);
+    }
     if (ret_fr) {
         vtd_report_fault(s, -ret_fr, is_fpd_set, source_id,
                          addr, is_write, pasid != PCI_NO_PASID, pasid);
@@ -4286,6 +4424,18 @@ static void vtd_init(IntelIOMMUState *s)
     vtd_spte_rsvd_large[3] = VTD_SPTE_LPAGE_L3_RSVD_MASK(s->aw_bits,
                                         x86_iommu->dt_supported && s->stale_tm);
 
+    /*
+     * Rsvd field masks for fpte
+     */
+    vtd_fpte_rsvd[0] = ~0ULL;
+    vtd_fpte_rsvd[1] = VTD_FPTE_PAGE_L1_RSVD_MASK(s->aw_bits);
+    vtd_fpte_rsvd[2] = VTD_FPTE_PAGE_L2_RSVD_MASK(s->aw_bits);
+    vtd_fpte_rsvd[3] = VTD_FPTE_PAGE_L3_RSVD_MASK(s->aw_bits);
+    vtd_fpte_rsvd[4] = VTD_FPTE_PAGE_L4_RSVD_MASK(s->aw_bits);
+
+    vtd_fpte_rsvd_large[2] = VTD_FPTE_LPAGE_L2_RSVD_MASK(s->aw_bits);
+    vtd_fpte_rsvd_large[3] = VTD_FPTE_LPAGE_L3_RSVD_MASK(s->aw_bits);
+
     if (s->scalable_mode || s->snoop_control) {
         vtd_spte_rsvd[1] &= ~VTD_SPTE_SNP;
         vtd_spte_rsvd_large[2] &= ~VTD_SPTE_SNP;
-- 
MST


