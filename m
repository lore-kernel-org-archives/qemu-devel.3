Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DCC88CAC59A
	for <qemu-devel@archiver.kernel.org>; Thu, 18 Sep 2025 08:59:51 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uzATW-0000id-5n; Thu, 18 Sep 2025 04:58:46 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhenzhong.duan@intel.com>)
 id 1uzATT-0000gH-Q0
 for qemu-devel@nongnu.org; Thu, 18 Sep 2025 04:58:43 -0400
Received: from mgamail.intel.com ([192.198.163.8])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhenzhong.duan@intel.com>)
 id 1uzATR-0004iq-MY
 for qemu-devel@nongnu.org; Thu, 18 Sep 2025 04:58:43 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1758185921; x=1789721921;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=PauFapVo+fEKOPZXad/UTloRlbZBHB9uumVac4Y0hT4=;
 b=FwPSIFXHeeBYS9yX8AWg2G/PUfgVF1mZPjIIVq2Jh8fJOCaL23TQawB4
 C4vrwap33hoewxirw+XuN11rgD3Kh+oTtVQd3uNW6QpfwtSBcllZ97Bi9
 poewjl2Rk27OmKOq2qv6nR4nPPgIG+6yt+wXoNFX61EV6CoJWgXQwD7/Q
 2HU+P1h0D/xweZsi46sszeR/hDfXmI5KjKD6LMAmrFJAwYwBZSc72G4Pn
 2jJXMhjtXKQpCDOcB3x/djXFMNW9FegdQ95/WKZeg8Vu6zDK/L9f9UWcF
 Pqg3KZy7CcOrrDXz7whmvff5IRfawDH8KZ//rJDFnXzwSCSa7jceIr6vR A==;
X-CSE-ConnectionGUID: D1JVVPV8QSu85BMRC5lfog==
X-CSE-MsgGUID: 5u6P1CybQlOGKtMzIaZxoA==
X-IronPort-AV: E=McAfee;i="6800,10657,11556"; a="78109367"
X-IronPort-AV: E=Sophos;i="6.18,274,1751266800"; d="scan'208";a="78109367"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
 by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 18 Sep 2025 01:58:37 -0700
X-CSE-ConnectionGUID: TLSQ/p4vSfSvraeC3rsMmg==
X-CSE-MsgGUID: Sh9+u8v/Rnq6Pz177IErBg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.18,274,1751266800"; d="scan'208";a="175930274"
Received: from unknown (HELO gnr-sp-2s-612.sh.intel.com) ([10.112.230.229])
 by fmviesa009-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 18 Sep 2025 01:58:34 -0700
From: Zhenzhong Duan <zhenzhong.duan@intel.com>
To: qemu-devel@nongnu.org
Cc: alex.williamson@redhat.com, clg@redhat.com, eric.auger@redhat.com,
 mst@redhat.com, jasowang@redhat.com, peterx@redhat.com, ddutile@redhat.com,
 jgg@nvidia.com, nicolinc@nvidia.com, skolothumtho@nvidia.com,
 joao.m.martins@oracle.com, clement.mathieu--drif@eviden.com,
 kevin.tian@intel.com, yi.l.liu@intel.com, chao.p.peng@intel.com,
 Zhenzhong Duan <zhenzhong.duan@intel.com>
Subject: [PATCH v6 01/22] intel_iommu: Rename vtd_ce_get_rid2pasid_entry to
 vtd_ce_get_pasid_entry
Date: Thu, 18 Sep 2025 04:57:40 -0400
Message-ID: <20250918085803.796942-2-zhenzhong.duan@intel.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250918085803.796942-1-zhenzhong.duan@intel.com>
References: <20250918085803.796942-1-zhenzhong.duan@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=192.198.163.8;
 envelope-from=zhenzhong.duan@intel.com; helo=mgamail.intel.com
X-Spam_score_int: -43
X-Spam_score: -4.4
X-Spam_bar: ----
X-Spam_report: (-4.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001, SPF_HELO_NONE=0.001,
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
 hw/i386/intel_iommu.c | 18 ++++++++----------
 1 file changed, 8 insertions(+), 10 deletions(-)

diff --git a/hw/i386/intel_iommu.c b/hw/i386/intel_iommu.c
index 83c5e44413..71b70b795d 100644
--- a/hw/i386/intel_iommu.c
+++ b/hw/i386/intel_iommu.c
@@ -944,10 +944,8 @@ static int vtd_get_pe_from_pasid_table(IntelIOMMUState *s,
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
@@ -1025,7 +1023,7 @@ static uint32_t vtd_get_iova_level(IntelIOMMUState *s,
     VTDPASIDEntry pe;
 
     if (s->root_scalable) {
-        vtd_ce_get_rid2pasid_entry(s, ce, &pe, pasid);
+        vtd_ce_get_pasid_entry(s, ce, &pe, pasid);
         if (s->flts) {
             return VTD_PE_GET_FL_LEVEL(&pe);
         } else {
@@ -1048,7 +1046,7 @@ static uint32_t vtd_get_iova_agaw(IntelIOMMUState *s,
     VTDPASIDEntry pe;
 
     if (s->root_scalable) {
-        vtd_ce_get_rid2pasid_entry(s, ce, &pe, pasid);
+        vtd_ce_get_pasid_entry(s, ce, &pe, pasid);
         return 30 + ((pe.val[0] >> 2) & VTD_SM_PASID_ENTRY_AW) * 9;
     }
 
@@ -1116,7 +1114,7 @@ static dma_addr_t vtd_get_iova_pgtbl_base(IntelIOMMUState *s,
     VTDPASIDEntry pe;
 
     if (s->root_scalable) {
-        vtd_ce_get_rid2pasid_entry(s, ce, &pe, pasid);
+        vtd_ce_get_pasid_entry(s, ce, &pe, pasid);
         if (s->flts) {
             return pe.val[2] & VTD_SM_PASID_ENTRY_FLPTPTR;
         } else {
@@ -1522,7 +1520,7 @@ static int vtd_ce_rid2pasid_check(IntelIOMMUState *s,
      * has valid rid2pasid setting, which includes valid
      * rid2pasid field and corresponding pasid entry setting
      */
-    return vtd_ce_get_rid2pasid_entry(s, ce, &pe, PCI_NO_PASID);
+    return vtd_ce_get_pasid_entry(s, ce, &pe, PCI_NO_PASID);
 }
 
 /* Map a device to its corresponding domain (context-entry) */
@@ -1611,7 +1609,7 @@ static uint16_t vtd_get_domain_id(IntelIOMMUState *s,
     VTDPASIDEntry pe;
 
     if (s->root_scalable) {
-        vtd_ce_get_rid2pasid_entry(s, ce, &pe, pasid);
+        vtd_ce_get_pasid_entry(s, ce, &pe, pasid);
         return VTD_SM_PASID_ENTRY_DID(pe.val[1]);
     }
 
@@ -1687,7 +1685,7 @@ static bool vtd_dev_pt_enabled(IntelIOMMUState *s, VTDContextEntry *ce,
     int ret;
 
     if (s->root_scalable) {
-        ret = vtd_ce_get_rid2pasid_entry(s, ce, &pe, pasid);
+        ret = vtd_ce_get_pasid_entry(s, ce, &pe, pasid);
         if (ret) {
             /*
              * This error is guest triggerable. We should assumt PT
-- 
2.47.1


