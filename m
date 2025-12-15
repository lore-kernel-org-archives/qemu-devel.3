Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 82219D59D99
	for <qemu-devel@archiver.kernel.org>; Mon, 15 Dec 2025 06:54:19 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vV2QX-0007yn-Co; Mon, 15 Dec 2025 01:51:25 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhenzhong.duan@intel.com>)
 id 1vV2QU-0007yE-Qs
 for qemu-devel@nongnu.org; Mon, 15 Dec 2025 01:51:22 -0500
Received: from mgamail.intel.com ([198.175.65.15])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhenzhong.duan@intel.com>)
 id 1vV2QR-0000t7-5f
 for qemu-devel@nongnu.org; Mon, 15 Dec 2025 01:51:22 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1765781480; x=1797317480;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=o7EFDuOyt6LdCO+MRYeG3gPf14I89uaBFCeSBtkVm7Y=;
 b=X1bbqkvGyqwnksHjsGdT5H4ZYYRz0T/iASAWtxtEbm63jQcsWpsFLYJS
 mnAwzQQvwoygfSMRMuxosGtC+hnA4gGRIIhFQZkNJVZJD76wlSjvZ3gJE
 8Vhg9hADFG02Fa4mQrBC979JM3uwZ7PoHrV8CPFcigZF14zGkfXyEcR/F
 a4PHdoJq8dmuv4PivOeu4wWghataq1b54oHit/dG71Ro+6AjZfm2cfYI0
 q1sEB23TvEabhq0ID5uBsQHacz6aV68zuPcuQXzBP0I64Yq9tdII7KljN
 46dyRhOgzrO68XHRMmgIqH+ARn4RTN50R8I2RcfHlr7B4B93AuVp8+ydk w==;
X-CSE-ConnectionGUID: ixXpa5G5QFSBxjFau75lCQ==
X-CSE-MsgGUID: MZqdhoE1Q5y0EIUwmwRR0Q==
X-IronPort-AV: E=McAfee;i="6800,10657,11642"; a="71304922"
X-IronPort-AV: E=Sophos;i="6.21,150,1763452800"; d="scan'208";a="71304922"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
 by orvoesa107.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 14 Dec 2025 22:51:16 -0800
X-CSE-ConnectionGUID: z+RFa0J3QS2cC7i2LJEMXw==
X-CSE-MsgGUID: WJtWESu6SqWixIIPVO0kRg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,150,1763452800"; d="scan'208";a="197408714"
Received: from unknown (HELO gnr-sp-2s-612.sh.intel.com) ([10.112.230.229])
 by orviesa009-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 14 Dec 2025 22:51:11 -0800
From: Zhenzhong Duan <zhenzhong.duan@intel.com>
To: qemu-devel@nongnu.org
Cc: alex@shazbot.org, clg@redhat.com, eric.auger@redhat.com, mst@redhat.com,
 jasowang@redhat.com, peterx@redhat.com, ddutile@redhat.com, jgg@nvidia.com,
 nicolinc@nvidia.com, skolothumtho@nvidia.com, joao.m.martins@oracle.com,
 clement.mathieu--drif@eviden.com, kevin.tian@intel.com, yi.l.liu@intel.com,
 chao.p.peng@intel.com, Zhenzhong Duan <zhenzhong.duan@intel.com>
Subject: [PATCH v9 01/19] intel_iommu: Rename vtd_ce_get_rid2pasid_entry to
 vtd_ce_get_pasid_entry
Date: Mon, 15 Dec 2025 01:50:25 -0500
Message-ID: <20251215065046.86991-2-zhenzhong.duan@intel.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20251215065046.86991-1-zhenzhong.duan@intel.com>
References: <20251215065046.86991-1-zhenzhong.duan@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=198.175.65.15;
 envelope-from=zhenzhong.duan@intel.com; helo=mgamail.intel.com
X-Spam_score_int: -43
X-Spam_score: -4.4
X-Spam_bar: ----
X-Spam_report: (-4.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
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
index 78b142ccea..ab7afdbf3d 100644
--- a/hw/i386/intel_iommu.c
+++ b/hw/i386/intel_iommu.c
@@ -954,10 +954,8 @@ static int vtd_get_pe_from_pasid_table(IntelIOMMUState *s,
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
@@ -1035,7 +1033,7 @@ static uint32_t vtd_get_iova_level(IntelIOMMUState *s,
     VTDPASIDEntry pe;
 
     if (s->root_scalable) {
-        vtd_ce_get_rid2pasid_entry(s, ce, &pe, pasid);
+        vtd_ce_get_pasid_entry(s, ce, &pe, pasid);
         if (s->flts) {
             return VTD_PE_GET_FL_LEVEL(&pe);
         } else {
@@ -1058,7 +1056,7 @@ static uint32_t vtd_get_iova_agaw(IntelIOMMUState *s,
     VTDPASIDEntry pe;
 
     if (s->root_scalable) {
-        vtd_ce_get_rid2pasid_entry(s, ce, &pe, pasid);
+        vtd_ce_get_pasid_entry(s, ce, &pe, pasid);
         return 30 + ((pe.val[0] >> 2) & VTD_SM_PASID_ENTRY_AW) * 9;
     }
 
@@ -1126,7 +1124,7 @@ static dma_addr_t vtd_get_iova_pgtbl_base(IntelIOMMUState *s,
     VTDPASIDEntry pe;
 
     if (s->root_scalable) {
-        vtd_ce_get_rid2pasid_entry(s, ce, &pe, pasid);
+        vtd_ce_get_pasid_entry(s, ce, &pe, pasid);
         if (s->flts) {
             return pe.val[2] & VTD_SM_PASID_ENTRY_FLPTPTR;
         } else {
@@ -1532,7 +1530,7 @@ static int vtd_ce_rid2pasid_check(IntelIOMMUState *s,
      * has valid rid2pasid setting, which includes valid
      * rid2pasid field and corresponding pasid entry setting
      */
-    return vtd_ce_get_rid2pasid_entry(s, ce, &pe, PCI_NO_PASID);
+    return vtd_ce_get_pasid_entry(s, ce, &pe, PCI_NO_PASID);
 }
 
 /* Map a device to its corresponding domain (context-entry) */
@@ -1621,7 +1619,7 @@ static uint16_t vtd_get_domain_id(IntelIOMMUState *s,
     VTDPASIDEntry pe;
 
     if (s->root_scalable) {
-        vtd_ce_get_rid2pasid_entry(s, ce, &pe, pasid);
+        vtd_ce_get_pasid_entry(s, ce, &pe, pasid);
         return VTD_SM_PASID_ENTRY_DID(pe.val[1]);
     }
 
@@ -1697,7 +1695,7 @@ static bool vtd_dev_pt_enabled(IntelIOMMUState *s, VTDContextEntry *ce,
     int ret;
 
     if (s->root_scalable) {
-        ret = vtd_ce_get_rid2pasid_entry(s, ce, &pe, pasid);
+        ret = vtd_ce_get_pasid_entry(s, ce, &pe, pasid);
         if (ret) {
             /*
              * This error is guest triggerable. We should assumt PT
@@ -3083,7 +3081,7 @@ static inline int vtd_dev_get_pe_from_pasid(VTDAddressSpace *vtd_as,
         return ret;
     }
 
-    return vtd_ce_get_rid2pasid_entry(s, &ce, pe, vtd_as->pasid);
+    return vtd_ce_get_pasid_entry(s, &ce, pe, vtd_as->pasid);
 }
 
 static int vtd_pasid_entry_compare(VTDPASIDEntry *p1, VTDPASIDEntry *p2)
@@ -5161,7 +5159,7 @@ static int vtd_pri_perform_implicit_invalidation(VTDAddressSpace *vtd_as,
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


