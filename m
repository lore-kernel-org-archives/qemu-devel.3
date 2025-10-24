Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F001BCCD1AB
	for <qemu-devel@archiver.kernel.org>; Fri, 24 Oct 2025 08:47:12 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vCDPf-00041J-6L; Fri, 24 Oct 2025 04:44:43 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhenzhong.duan@intel.com>)
 id 1vCDPc-00040Z-0U
 for qemu-devel@nongnu.org; Fri, 24 Oct 2025 04:44:40 -0400
Received: from mgamail.intel.com ([192.198.163.19])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhenzhong.duan@intel.com>)
 id 1vCDPa-0006Em-7H
 for qemu-devel@nongnu.org; Fri, 24 Oct 2025 04:44:39 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1761295478; x=1792831478;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=/IF0YtM/KI703WWgd6Noo1X8CwvIIlAkJgWXiXtPlRk=;
 b=UpYPH79npqn9RuTPsahtI9qQqTEmpofQWPGY546TM233j4T4fSjocS9K
 94lRL2IqSJBhjIRaGagkXHm+1czUmkK6XMLS59//T/R9l1n/o496XW9p3
 6gug6N8hxjv/NiTPES7oAGu+BmBi67ITTyqfqAJz2Zxg2IGBUDXR2KKPe
 RzUjpmQsSMpKOAlp+M9CFQxNEWgH23jqJm67MD6oJ8bZHrvf2Y5vpZkn7
 reVHYx2SEBsYlTSkpg3yMW/0+Pk6biX1FZioGyK9GYfPXrhALOPUJ+dMS
 1BTfSsl+Ayn3WFxiAwbTxY1n+jXXkW3cFPEDO6JxNr78RE43mE4MXKrP/ g==;
X-CSE-ConnectionGUID: C1BfvtwsSeeYjDMZyUyc1g==
X-CSE-MsgGUID: X9YblqZ7Tjm7QfmUxUytPg==
X-IronPort-AV: E=McAfee;i="6800,10657,11586"; a="62504821"
X-IronPort-AV: E=Sophos;i="6.19,252,1754982000"; d="scan'208";a="62504821"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
 by fmvoesa113.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 24 Oct 2025 01:44:36 -0700
X-CSE-ConnectionGUID: JIZkaIe6RMmt7RYLqDza5w==
X-CSE-MsgGUID: AL20MxjIQ32x+YIpkuZMWQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,252,1754982000"; d="scan'208";a="183985777"
Received: from unknown (HELO gnr-sp-2s-612.sh.intel.com) ([10.112.230.229])
 by orviesa009-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 24 Oct 2025 01:44:32 -0700
From: Zhenzhong Duan <zhenzhong.duan@intel.com>
To: qemu-devel@nongnu.org
Cc: alex.williamson@redhat.com, clg@redhat.com, eric.auger@redhat.com,
 mst@redhat.com, jasowang@redhat.com, peterx@redhat.com, ddutile@redhat.com,
 jgg@nvidia.com, nicolinc@nvidia.com, skolothumtho@nvidia.com,
 joao.m.martins@oracle.com, clement.mathieu--drif@eviden.com,
 kevin.tian@intel.com, yi.l.liu@intel.com, chao.p.peng@intel.com,
 Zhenzhong Duan <zhenzhong.duan@intel.com>
Subject: [PATCH v7 01/23] intel_iommu: Rename vtd_ce_get_rid2pasid_entry to
 vtd_ce_get_pasid_entry
Date: Fri, 24 Oct 2025 04:43:25 -0400
Message-ID: <20251024084349.102322-2-zhenzhong.duan@intel.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20251024084349.102322-1-zhenzhong.duan@intel.com>
References: <20251024084349.102322-1-zhenzhong.duan@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=192.198.163.19;
 envelope-from=zhenzhong.duan@intel.com; helo=mgamail.intel.com
X-Spam_score_int: -43
X-Spam_score: -4.4
X-Spam_bar: ----
X-Spam_report: (-4.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, RCVD_IN_MSPIKE_H2=0.001,
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

In early days vtd_ce_get_rid2pasid_entry() was used to get pasid entry
of rid2pasid, then it was extended to get any pasid entry. So a new name
vtd_ce_get_pasid_entry is better to match what it actually does.

No functional change intended.

Signed-off-by: Zhenzhong Duan <zhenzhong.duan@intel.com>
Reviewed-by: Clément Mathieu--Drif<clement.mathieu--drif@eviden.com>
Reviewed-by: Yi Liu <yi.l.liu@intel.com>
Reviewed-by: Eric Auger <eric.auger@redhat.com>
Reviewed-by: Nicolin Chen <nicolinc@nvidia.com>
---
 hw/i386/intel_iommu.c | 22 ++++++++++------------
 1 file changed, 10 insertions(+), 12 deletions(-)

diff --git a/hw/i386/intel_iommu.c b/hw/i386/intel_iommu.c
index b00fdecaf8..70746e3080 100644
--- a/hw/i386/intel_iommu.c
+++ b/hw/i386/intel_iommu.c
@@ -956,10 +956,8 @@ static int vtd_get_pe_from_pasid_table(IntelIOMMUState *s,
     return 0;
 }
 
-static int vtd_ce_get_rid2pasid_entry(IntelIOMMUState *s,
-                                      VTDContextEntry *ce,
-                                      VTDPASIDEntry *pe,
-                                      uint32_t pasid)
+static int vtd_ce_get_pasid_entry(IntelIOMMUState *s, VTDContextEntry *ce,
+                                  VTDPASIDEntry *pe, uint32_t pasid)
 {
     dma_addr_t pasid_dir_base;
     int ret = 0;
@@ -1037,7 +1035,7 @@ static uint32_t vtd_get_iova_level(IntelIOMMUState *s,
     VTDPASIDEntry pe;
 
     if (s->root_scalable) {
-        vtd_ce_get_rid2pasid_entry(s, ce, &pe, pasid);
+        vtd_ce_get_pasid_entry(s, ce, &pe, pasid);
         if (s->flts) {
             return VTD_PE_GET_FL_LEVEL(&pe);
         } else {
@@ -1060,7 +1058,7 @@ static uint32_t vtd_get_iova_agaw(IntelIOMMUState *s,
     VTDPASIDEntry pe;
 
     if (s->root_scalable) {
-        vtd_ce_get_rid2pasid_entry(s, ce, &pe, pasid);
+        vtd_ce_get_pasid_entry(s, ce, &pe, pasid);
         return 30 + ((pe.val[0] >> 2) & VTD_SM_PASID_ENTRY_AW) * 9;
     }
 
@@ -1128,7 +1126,7 @@ static dma_addr_t vtd_get_iova_pgtbl_base(IntelIOMMUState *s,
     VTDPASIDEntry pe;
 
     if (s->root_scalable) {
-        vtd_ce_get_rid2pasid_entry(s, ce, &pe, pasid);
+        vtd_ce_get_pasid_entry(s, ce, &pe, pasid);
         if (s->flts) {
             return pe.val[2] & VTD_SM_PASID_ENTRY_FLPTPTR;
         } else {
@@ -1534,7 +1532,7 @@ static int vtd_ce_rid2pasid_check(IntelIOMMUState *s,
      * has valid rid2pasid setting, which includes valid
      * rid2pasid field and corresponding pasid entry setting
      */
-    return vtd_ce_get_rid2pasid_entry(s, ce, &pe, PCI_NO_PASID);
+    return vtd_ce_get_pasid_entry(s, ce, &pe, PCI_NO_PASID);
 }
 
 /* Map a device to its corresponding domain (context-entry) */
@@ -1623,7 +1621,7 @@ static uint16_t vtd_get_domain_id(IntelIOMMUState *s,
     VTDPASIDEntry pe;
 
     if (s->root_scalable) {
-        vtd_ce_get_rid2pasid_entry(s, ce, &pe, pasid);
+        vtd_ce_get_pasid_entry(s, ce, &pe, pasid);
         return VTD_SM_PASID_ENTRY_DID(pe.val[1]);
     }
 
@@ -1699,7 +1697,7 @@ static bool vtd_dev_pt_enabled(IntelIOMMUState *s, VTDContextEntry *ce,
     int ret;
 
     if (s->root_scalable) {
-        ret = vtd_ce_get_rid2pasid_entry(s, ce, &pe, pasid);
+        ret = vtd_ce_get_pasid_entry(s, ce, &pe, pasid);
         if (ret) {
             /*
              * This error is guest triggerable. We should assumt PT
@@ -3085,7 +3083,7 @@ static inline int vtd_dev_get_pe_from_pasid(VTDAddressSpace *vtd_as,
         return ret;
     }
 
-    return vtd_ce_get_rid2pasid_entry(s, &ce, pe, vtd_as->pasid);
+    return vtd_ce_get_pasid_entry(s, &ce, pe, vtd_as->pasid);
 }
 
 static int vtd_pasid_entry_compare(VTDPASIDEntry *p1, VTDPASIDEntry *p2)
@@ -5204,7 +5202,7 @@ static int vtd_pri_perform_implicit_invalidation(VTDAddressSpace *vtd_as,
     if (ret) {
         return -EINVAL;
     }
-    ret = vtd_ce_get_rid2pasid_entry(s, &ce, &pe, vtd_as->pasid);
+    ret = vtd_ce_get_pasid_entry(s, &ce, &pe, vtd_as->pasid);
     if (ret) {
         return -EINVAL;
     }
-- 
2.47.1


