Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2B6F5C021AB
	for <qemu-devel@archiver.kernel.org>; Wed, 19 Feb 2025 08:30:35 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tkfPx-0005Wj-UD; Wed, 19 Feb 2025 03:26:53 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhenzhong.duan@intel.com>)
 id 1tkfPu-0005WP-6y
 for qemu-devel@nongnu.org; Wed, 19 Feb 2025 03:26:50 -0500
Received: from mgamail.intel.com ([192.198.163.17])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhenzhong.duan@intel.com>)
 id 1tkfPr-0004bS-7a
 for qemu-devel@nongnu.org; Wed, 19 Feb 2025 03:26:49 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1739953607; x=1771489607;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=nYVvYeFiriU3MW0297bFJQJAXZzg8hZWGvEREGWkhUQ=;
 b=W5BMvw0MMO8eOnwtFkj0+M1GSy3K+6yAp+wGSLfpfB/771Q0IynL4sy7
 FkR5Ene9Qe/z7vb/OQr9znKW8BdT6lhQw/4OKYB5kwfqJhdqVlekDFIaD
 y5HfbWLqZb07x27g+IpSOb85tK/Af+pr7mJyc5JJBuyRxx3lK8bt/zsOw
 zZT/OrsMMlkDz3p11Yp8Ke3wEGiVgG2KVjSYeQjsKytnPeqnLH5QckF5v
 kq+cdB/V6+KUtc4ApNWS9KoNY8ixgC19qmKPkQD9gSu5xXVh0U3LuP5Ao
 nKqFcYmnmC5V0dyhS6ZPba922TJT0sJ+lpd8Mt75w68ltdNFHq2dtGOVk Q==;
X-CSE-ConnectionGUID: WVL3ErPhTN6owjbKbWELmw==
X-CSE-MsgGUID: gO9cqvWBRDK83PdHPxDwsQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11348"; a="40544145"
X-IronPort-AV: E=Sophos;i="6.13,298,1732608000"; d="scan'208";a="40544145"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
 by fmvoesa111.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 19 Feb 2025 00:26:47 -0800
X-CSE-ConnectionGUID: PO/Fj+PiRi+vdPCYuQWL9Q==
X-CSE-MsgGUID: ALOClG/ISx2JRUft0ZxT8A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,224,1728975600"; d="scan'208";a="119851079"
Received: from spr-s2600bt.bj.intel.com ([10.240.192.127])
 by orviesa005-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 19 Feb 2025 00:26:41 -0800
From: Zhenzhong Duan <zhenzhong.duan@intel.com>
To: qemu-devel@nongnu.org
Cc: alex.williamson@redhat.com, clg@redhat.com, eric.auger@redhat.com,
 mst@redhat.com, jasowang@redhat.com, peterx@redhat.com, jgg@nvidia.com,
 nicolinc@nvidia.com, shameerali.kolothum.thodi@huawei.com,
 joao.m.martins@oracle.com, clement.mathieu--drif@eviden.com,
 kevin.tian@intel.com, yi.l.liu@intel.com, chao.p.peng@intel.com,
 Zhenzhong Duan <zhenzhong.duan@intel.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Eduardo Habkost <eduardo@habkost.net>
Subject: [PATCH rfcv2 09/20] intel_iommu: Rename vtd_ce_get_rid2pasid_entry to
 vtd_ce_get_pasid_entry
Date: Wed, 19 Feb 2025 16:22:17 +0800
Message-Id: <20250219082228.3303163-10-zhenzhong.duan@intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250219082228.3303163-1-zhenzhong.duan@intel.com>
References: <20250219082228.3303163-1-zhenzhong.duan@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=192.198.163.17;
 envelope-from=zhenzhong.duan@intel.com; helo=mgamail.intel.com
X-Spam_score_int: -47
X-Spam_score: -4.8
X-Spam_bar: ----
X-Spam_report: (-4.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.423,
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

In early days vtd_ce_get_rid2pasid_entry() is used to get pasid entry of
rid2pasid, then extend to any pasid. So a new name vtd_ce_get_pasid_entry
is better to match its functions.

No functional change intended.

Signed-off-by: Zhenzhong Duan <zhenzhong.duan@intel.com>
---
 hw/i386/intel_iommu.c | 14 +++++++-------
 1 file changed, 7 insertions(+), 7 deletions(-)

diff --git a/hw/i386/intel_iommu.c b/hw/i386/intel_iommu.c
index 7fde0603bf..df5fb30bc8 100644
--- a/hw/i386/intel_iommu.c
+++ b/hw/i386/intel_iommu.c
@@ -944,7 +944,7 @@ static int vtd_get_pe_from_pasid_table(IntelIOMMUState *s,
     return 0;
 }
 
-static int vtd_ce_get_rid2pasid_entry(IntelIOMMUState *s,
+static int vtd_ce_get_pasid_entry(IntelIOMMUState *s,
                                       VTDContextEntry *ce,
                                       VTDPASIDEntry *pe,
                                       uint32_t pasid)
@@ -1025,7 +1025,7 @@ static uint32_t vtd_get_iova_level(IntelIOMMUState *s,
     VTDPASIDEntry pe;
 
     if (s->root_scalable) {
-        vtd_ce_get_rid2pasid_entry(s, ce, &pe, pasid);
+        vtd_ce_get_pasid_entry(s, ce, &pe, pasid);
         if (s->flts) {
             return VTD_PE_GET_FL_LEVEL(&pe);
         } else {
@@ -1048,7 +1048,7 @@ static uint32_t vtd_get_iova_agaw(IntelIOMMUState *s,
     VTDPASIDEntry pe;
 
     if (s->root_scalable) {
-        vtd_ce_get_rid2pasid_entry(s, ce, &pe, pasid);
+        vtd_ce_get_pasid_entry(s, ce, &pe, pasid);
         return 30 + ((pe.val[0] >> 2) & VTD_SM_PASID_ENTRY_AW) * 9;
     }
 
@@ -1116,7 +1116,7 @@ static dma_addr_t vtd_get_iova_pgtbl_base(IntelIOMMUState *s,
     VTDPASIDEntry pe;
 
     if (s->root_scalable) {
-        vtd_ce_get_rid2pasid_entry(s, ce, &pe, pasid);
+        vtd_ce_get_pasid_entry(s, ce, &pe, pasid);
         if (s->flts) {
             return pe.val[2] & VTD_SM_PASID_ENTRY_FLPTPTR;
         } else {
@@ -1522,7 +1522,7 @@ static int vtd_ce_rid2pasid_check(IntelIOMMUState *s,
      * has valid rid2pasid setting, which includes valid
      * rid2pasid field and corresponding pasid entry setting
      */
-    return vtd_ce_get_rid2pasid_entry(s, ce, &pe, PCI_NO_PASID);
+    return vtd_ce_get_pasid_entry(s, ce, &pe, PCI_NO_PASID);
 }
 
 /* Map a device to its corresponding domain (context-entry) */
@@ -1611,7 +1611,7 @@ static uint16_t vtd_get_domain_id(IntelIOMMUState *s,
     VTDPASIDEntry pe;
 
     if (s->root_scalable) {
-        vtd_ce_get_rid2pasid_entry(s, ce, &pe, pasid);
+        vtd_ce_get_pasid_entry(s, ce, &pe, pasid);
         return VTD_SM_PASID_ENTRY_DID(pe.val[1]);
     }
 
@@ -1687,7 +1687,7 @@ static bool vtd_dev_pt_enabled(IntelIOMMUState *s, VTDContextEntry *ce,
     int ret;
 
     if (s->root_scalable) {
-        ret = vtd_ce_get_rid2pasid_entry(s, ce, &pe, pasid);
+        ret = vtd_ce_get_pasid_entry(s, ce, &pe, pasid);
         if (ret) {
             /*
              * This error is guest triggerable. We should assumt PT
-- 
2.34.1


