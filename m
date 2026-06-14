Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 776B0CD98D2
	for <qemu-devel@archiver.kernel.org>; Sun, 14 Jun 2026 19:12:21 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wYqA2-0007SU-Oj; Sun, 14 Jun 2026 15:06:23 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1wYqA0-0007S0-8k
 for qemu-devel@nongnu.org; Sun, 14 Jun 2026 15:06:20 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1wYq9y-0001gw-Jq
 for qemu-devel@nongnu.org; Sun, 14 Jun 2026 15:06:20 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1781463978;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=WFEkrxkw6JWUK0cwJODW6BoTrF/CT02ZhMQYnTFjvuQ=;
 b=EeQixWqyYA9Ji4sHoScpOpGeHXfRVo8s/bE+hTo8eSBIsaULAKsC+4YKnXV/7R7E0Y3yxn
 3aJcs7PjRR1DFFtBalK/p8kNgftNF99Tfyo6ZkT+rxVFaZgfWvj94iLhl0QBAmFFk4syza
 nuWIJBTo1ne9kLhSmycoO+HAlb6DxIs=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-688-hkxdhaZiO7GiWfxQVk97aA-1; Sun, 14 Jun 2026 15:06:16 -0400
X-MC-Unique: hkxdhaZiO7GiWfxQVk97aA-1
X-Mimecast-MFC-AGG-ID: hkxdhaZiO7GiWfxQVk97aA_1781463975
Received: by mail-wm1-f71.google.com with SMTP id
 5b1f17b1804b1-490ae3bcf4cso12093285e9.3
 for <qemu-devel@nongnu.org>; Sun, 14 Jun 2026 12:06:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1781463975; x=1782068775; darn=nongnu.org;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=WFEkrxkw6JWUK0cwJODW6BoTrF/CT02ZhMQYnTFjvuQ=;
 b=DAm35Wxy3otnAhHmrJUeNrwTYRnxQ5xibSgtLZs8CJNoT4wIIByBDx2lSYx3Bb2Ixc
 7505v+DpCfsHR7fRyYIeT7B9e4QKVmwGal8Oe8147bX1eMXprfb8JTW0DHC8SCoFmSx4
 IazcrT2y3SA3vbIBMO3XJKsSxuy5vZeCFRQFx4GcSnxAVTlNbzXgi5YopYQm65zmX7k9
 j4jia3Y5sD4lHEl7Ual9ReUma5tLJakzlmdkbYNJaPvl1w7gW1iL35qalvAG/Ifb/Rfj
 vfE/1mbabKtGEsewzSlhVo92gRlbhIQBHqAjfIYMLGjLz4eXrqBvpAfpn5XZOLopBhMK
 sSng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1781463975; x=1782068775;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=WFEkrxkw6JWUK0cwJODW6BoTrF/CT02ZhMQYnTFjvuQ=;
 b=EwmTJZ+cl9b76SnXubPHJ3TSxwjlMcLtBVgREKjIlycPzBTRTgbUw8Obng+z0g1NlI
 +a3cBynRB0DF5m2gZzjJN1gUwAjViKY76Yn9FQQcrozIRzNIKBDZAjTaryJDccWaA6gP
 QkBLIStwNb3R1d7bTIFVgVcLyZvbT6cefmIazndoMrNOcxSOIQuglK8/yNlxMcWXR1EU
 CNtWTXjwoF17HwSJ9fg+knGGea+HTCX/DP308cTuJcrJrYAawqjPYgPgT3QYkHPNvn/A
 Dq9i8lpDaP0v7aiNJBKOP4xD+Gcf/+HsYwtpji1Txe3JxzjlA0Je0xJAjh+W6TqP18Ja
 EvLw==
X-Gm-Message-State: AOJu0YywvUoKYe5elyC1K8sknkpl5FqaWr19JUzSmLpANYiANE+O3kPo
 iE+5PMriBapTNG5bR4q902sF7vmXsreisRElkAgguMQmkBczpXk0hIYQ0qWlBhbgFAOEqwqRDcF
 /c7iGxfeJp89pLm35I9bLu9Wv3eM6H4Y86ccjsCPUBka1J0c7/MOudQaeUHphbY8AZwlrgrq5FL
 rVtD8n9+7ye4npMvKy6VYJoGMAr/4jxzy9dg==
X-Gm-Gg: Acq92OEwS3rLlfWkYAG4bLIupuXkABCy9cqQbp+XT/XwawBL+vdqCt2/OkDt5YAoT8O
 4uTZptLTYcnSAzORVIo/M3ijEU/7UbeXgk+dUw6Ik6tPNj5cf1GFZGv7NEsm4TEEUGZ/T5CA2ZF
 q9k+HpTZCF/q41KFMcIs67S+wJcRzbPahXpckDw8PclRGVhDXwnTPca1KAM2rxinZX+XJJNI+vg
 fFl0WncN8bOgVQWoJAtlp8dqPm8+zbChxKuJGjC0hcZRY1U4FzT2TnJ0khNTxtm8uyIBz7mm5YN
 1N3laPcaAf1TxTz3Oz/VmcPmcY6OAtJa4PNbixKC2yQeyLsAp/+iRCZ4NNcMp+RIne5pG8lw2A2
 1Tm1i5Ec4MMmdNiPqFUPRFoHj4jucvT+DWmaINQOar1I=
X-Received: by 2002:a05:600c:628f:b0:492:1e36:85dc with SMTP id
 5b1f17b1804b1-4922017b005mr87470375e9.36.1781463974699; 
 Sun, 14 Jun 2026 12:06:14 -0700 (PDT)
X-Received: by 2002:a05:600c:628f:b0:492:1e36:85dc with SMTP id
 5b1f17b1804b1-4922017b005mr87469875e9.36.1781463974025; 
 Sun, 14 Jun 2026 12:06:14 -0700 (PDT)
Received: from redhat.com (IGLD-80-230-85-71.inter.net.il. [80.230.85.71])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-4606f2ce361sm26281050f8f.31.2026.06.14.12.06.12
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 14 Jun 2026 12:06:13 -0700 (PDT)
Date: Sun, 14 Jun 2026 15:06:11 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Zhenzhong Duan <zhenzhong.duan@intel.com>,
 Clement Mathieu--Drif <clement.mathieu--drif@eviden.com>,
 Yi Liu <yi.l.liu@intel.com>, Xudong Hao <xudong.hao@intel.com>,
 Jason Wang <jasowang@redhat.com>,
 =?utf-8?Q?Cl=C3=A9ment?= Mathieu--Drif <clement.mathieu--drif@bull.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>
Subject: [PULL 012/106] intel_iommu: Export some functions
Message-ID: <0d0f3f962eab4342b5d6314e28e7e87434ca9eff.1781463125.git.mst@redhat.com>
References: <cover.1781463125.git.mst@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1781463125.git.mst@redhat.com>
X-Mailer: git-send-email 2.51.2.2891.g4157995a80.dirty
X-Mutt-Fcc: =sent
Received-SPF: pass client-ip=170.10.133.124; envelope-from=mst@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.445,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

From: Zhenzhong Duan <zhenzhong.duan@intel.com>

Export some functions for accel code usages. Inline functions and MACROs
are moved to internal header files. Then accel code in following patches
could access them.

Signed-off-by: Zhenzhong Duan <zhenzhong.duan@intel.com>
Reviewed-by: Clement Mathieu--Drif <clement.mathieu--drif@eviden.com>
Reviewed-by: Yi Liu <yi.l.liu@intel.com>
Tested-by: Xudong Hao <xudong.hao@intel.com>
Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
Message-Id: <20260527054658.1021096-8-zhenzhong.duan@intel.com>
---
 hw/i386/intel_iommu.c          | 43 +++++++---------------------------
 hw/i386/intel_iommu_internal.h | 31 ++++++++++++++++++++++++
 2 files changed, 40 insertions(+), 34 deletions(-)

diff --git a/hw/i386/intel_iommu.c b/hw/i386/intel_iommu.c
index 632df21034..e15aecf5f9 100644
--- a/hw/i386/intel_iommu.c
+++ b/hw/i386/intel_iommu.c
@@ -42,12 +42,6 @@
 #include "migration/vmstate.h"
 #include "trace.h"
 
-/* context entry operations */
-#define VTD_CE_GET_PASID_DIR_TABLE(ce) \
-    ((ce)->val[0] & VTD_PASID_DIR_BASE_ADDR_MASK)
-#define VTD_CE_GET_PRE(ce) \
-    ((ce)->val[0] & VTD_SM_CONTEXT_ENTRY_PRE)
-
 /*
  * Paging mode for first-stage translation (VTD spec Figure 9-6)
  * 00: 4-level paging, 01: 5-level paging
@@ -831,18 +825,12 @@ static inline bool vtd_pe_type_check(IntelIOMMUState *s, VTDPASIDEntry *pe)
     }
 }
 
-static inline bool vtd_pdire_present(VTDPASIDDirEntry *pdire)
-{
-    return pdire->val & 1;
-}
-
 /**
  * Caller of this function should check present bit if wants
  * to use pdir entry for further usage except for fpd bit check.
  */
-static int vtd_get_pdire_from_pdir_table(dma_addr_t pasid_dir_base,
-                                         uint32_t pasid,
-                                         VTDPASIDDirEntry *pdire)
+int vtd_get_pdire_from_pdir_table(dma_addr_t pasid_dir_base, uint32_t pasid,
+                                  VTDPASIDDirEntry *pdire)
 {
     uint32_t index;
     dma_addr_t addr, entry_size;
@@ -860,15 +848,8 @@ static int vtd_get_pdire_from_pdir_table(dma_addr_t pasid_dir_base,
     return 0;
 }
 
-static inline bool vtd_pe_present(VTDPASIDEntry *pe)
-{
-    return pe->val[0] & VTD_PASID_ENTRY_P;
-}
-
-static int vtd_get_pe_in_pasid_leaf_table(IntelIOMMUState *s,
-                                          uint32_t pasid,
-                                          dma_addr_t addr,
-                                          VTDPASIDEntry *pe)
+int vtd_get_pe_in_pasid_leaf_table(IntelIOMMUState *s, uint32_t pasid,
+                                   dma_addr_t addr, VTDPASIDEntry *pe)
 {
     uint8_t pgtt;
     uint32_t index;
@@ -1526,8 +1507,8 @@ static int vtd_ce_pasid_0_check(IntelIOMMUState *s, VTDContextEntry *ce)
 }
 
 /* Map a device to its corresponding domain (context-entry) */
-static int vtd_dev_to_context_entry(IntelIOMMUState *s, uint8_t bus_num,
-                                    uint8_t devfn, VTDContextEntry *ce)
+int vtd_dev_to_context_entry(IntelIOMMUState *s, uint8_t bus_num,
+                             uint8_t devfn, VTDContextEntry *ce)
 {
     VTDRootEntry re;
     int ret_fr;
@@ -1909,7 +1890,7 @@ static VTDAddressSpace *vtd_get_as_by_sid_and_pasid(IntelIOMMUState *s,
                              vtd_find_as_by_sid_and_pasid, &key);
 }
 
-static VTDAddressSpace *vtd_get_as_by_sid(IntelIOMMUState *s, uint16_t sid)
+VTDAddressSpace *vtd_get_as_by_sid(IntelIOMMUState *s, uint16_t sid)
 {
     return vtd_get_as_by_sid_and_pasid(s, sid, PCI_NO_PASID);
 }
@@ -3113,9 +3094,8 @@ static bool vtd_process_piotlb_desc(IntelIOMMUState *s,
     return true;
 }
 
-static int vtd_dev_get_pe_from_pasid(IntelIOMMUState *s, PCIBus *bus,
-                                     uint8_t devfn, uint32_t pasid,
-                                     VTDPASIDEntry *pe)
+int vtd_dev_get_pe_from_pasid(IntelIOMMUState *s, PCIBus *bus, uint8_t devfn,
+                              uint32_t pasid, VTDPASIDEntry *pe)
 {
     VTDContextEntry ce;
     int ret;
@@ -3132,11 +3112,6 @@ static int vtd_dev_get_pe_from_pasid(IntelIOMMUState *s, PCIBus *bus,
     return vtd_ce_get_pasid_entry(s, &ce, pe, pasid);
 }
 
-static int vtd_pasid_entry_compare(VTDPASIDEntry *p1, VTDPASIDEntry *p2)
-{
-    return memcmp(p1, p2, sizeof(*p1));
-}
-
 /* Update or invalidate pasid cache based on the pasid entry in guest memory. */
 static void vtd_pasid_cache_sync_locked(gpointer key, gpointer value,
                                         gpointer user_data)
diff --git a/hw/i386/intel_iommu_internal.h b/hw/i386/intel_iommu_internal.h
index db4f186a3e..d738ef1803 100644
--- a/hw/i386/intel_iommu_internal.h
+++ b/hw/i386/intel_iommu_internal.h
@@ -620,6 +620,12 @@ typedef struct VTDRootEntry VTDRootEntry;
 #define VTD_SM_CONTEXT_ENTRY_RSVD_VAL1      0xffffffffffe00000ULL
 #define VTD_SM_CONTEXT_ENTRY_PRE            0x10ULL
 
+/* context entry operations */
+#define VTD_CE_GET_PASID_DIR_TABLE(ce) \
+    ((ce)->val[0] & VTD_PASID_DIR_BASE_ADDR_MASK)
+#define VTD_CE_GET_PRE(ce) \
+    ((ce)->val[0] & VTD_SM_CONTEXT_ENTRY_PRE)
+
 typedef struct VTDPASIDCacheInfo {
     uint8_t type;
     uint16_t did;
@@ -746,4 +752,29 @@ static inline bool vtd_pe_pgtt_is_fst(VTDPASIDEntry *pe)
 {
     return (VTD_SM_PASID_ENTRY_PGTT(pe) == VTD_SM_PASID_ENTRY_FST);
 }
+
+static inline bool vtd_pdire_present(VTDPASIDDirEntry *pdire)
+{
+    return pdire->val & 1;
+}
+
+static inline bool vtd_pe_present(VTDPASIDEntry *pe)
+{
+    return pe->val[0] & VTD_PASID_ENTRY_P;
+}
+
+static inline int vtd_pasid_entry_compare(VTDPASIDEntry *p1, VTDPASIDEntry *p2)
+{
+    return memcmp(p1, p2, sizeof(*p1));
+}
+
+int vtd_get_pdire_from_pdir_table(dma_addr_t pasid_dir_base, uint32_t pasid,
+                                  VTDPASIDDirEntry *pdire);
+int vtd_get_pe_in_pasid_leaf_table(IntelIOMMUState *s, uint32_t pasid,
+                                   dma_addr_t addr, VTDPASIDEntry *pe);
+int vtd_dev_to_context_entry(IntelIOMMUState *s, uint8_t bus_num,
+                             uint8_t devfn, VTDContextEntry *ce);
+VTDAddressSpace *vtd_get_as_by_sid(IntelIOMMUState *s, uint16_t sid);
+int vtd_dev_get_pe_from_pasid(IntelIOMMUState *s, PCIBus *bus, uint8_t devfn,
+                              uint32_t pasid, VTDPASIDEntry *pe);
 #endif
-- 
MST


