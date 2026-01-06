Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 437DACD043E
	for <qemu-devel@archiver.kernel.org>; Tue,  6 Jan 2026 06:16:12 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vd0LY-0005jq-0M; Tue, 06 Jan 2026 01:15:12 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhenzhong.duan@intel.com>)
 id 1vd0LB-0004fx-BJ
 for qemu-devel@nongnu.org; Tue, 06 Jan 2026 01:14:51 -0500
Received: from mgamail.intel.com ([198.175.65.18])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhenzhong.duan@intel.com>)
 id 1vd0L9-0007OC-RM
 for qemu-devel@nongnu.org; Tue, 06 Jan 2026 01:14:49 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1767680088; x=1799216088;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=Bgi2daNKrnU1uskTe90+7gs2wScsxhhyHbewx3ITebg=;
 b=O5ukluYklNyXFfSf2oc5PZaS8CbdsExVPz25HqO/eO3GAEGlY4Xbw8r9
 xFntdYGIy5BfJZB0xlotO5+EmfTH57cf5fcP9B3UL60GqjE/3qtg4tr7f
 VgzY3nf5sP1mCzUDbv5Y2OX2V7Q48y6fVT5HTPVdWbhu8jO93FRc8ugoq
 WRwOL6817Xww4Chfz3aAAKnfcF3Ln7qpV5e8LZx9M1OsdMaJAOAMMAONn
 558yFoUj1x8eeFo5LYIN7bpYrMOmSX5V5V61Bk3megRtx8i/kojDIS1AH
 61RjmOrmkUFGI9buf1yG3y6wQmir2XPjBAeeS8+DElL4+PF0ro3Hw8uC9 w==;
X-CSE-ConnectionGUID: DvSuCgjTTEyRsd2Cv82xgA==
X-CSE-MsgGUID: 4MU3FU+EQB2HofvBCvtWkg==
X-IronPort-AV: E=McAfee;i="6800,10657,11662"; a="69094115"
X-IronPort-AV: E=Sophos;i="6.21,204,1763452800"; d="scan'208";a="69094115"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
 by orvoesa110.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 05 Jan 2026 22:14:47 -0800
X-CSE-ConnectionGUID: SfHT7wt5SyS48Mn6Z3X05A==
X-CSE-MsgGUID: jKxWHSzBTjq63iyzKmjZSg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,204,1763452800"; d="scan'208";a="202589115"
Received: from unknown (HELO gnr-sp-2s-612.sh.intel.com) ([10.112.230.229])
 by orviesa007-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 05 Jan 2026 22:14:37 -0800
From: Zhenzhong Duan <zhenzhong.duan@intel.com>
To: qemu-devel@nongnu.org
Cc: alex@shazbot.org, clg@redhat.com, eric.auger@redhat.com, mst@redhat.com,
 jasowang@redhat.com, peterx@redhat.com, ddutile@redhat.com, jgg@nvidia.com,
 nicolinc@nvidia.com, skolothumtho@nvidia.com, joao.m.martins@oracle.com,
 clement.mathieu--drif@eviden.com, kevin.tian@intel.com, yi.l.liu@intel.com,
 chao.p.peng@intel.com, Zhenzhong Duan <zhenzhong.duan@intel.com>
Subject: [PATCH v10 19/19] docs/devel: Add IOMMUFD nesting documentation
Date: Tue,  6 Jan 2026 01:13:01 -0500
Message-ID: <20260106061304.314546-20-zhenzhong.duan@intel.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20260106061304.314546-1-zhenzhong.duan@intel.com>
References: <20260106061304.314546-1-zhenzhong.duan@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=198.175.65.18;
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

Add documentation about using IOMMUFD backed VFIO device with intel_iommu with
x-flts=on.

Suggested-by: Yi Liu <yi.l.liu@intel.com>
Signed-off-by: Zhenzhong Duan <zhenzhong.duan@intel.com>
Reviewed-by: Eric Auger <eric.auger@redhat.com>
---
 docs/devel/vfio-iommufd.rst | 17 +++++++++++++++++
 1 file changed, 17 insertions(+)

diff --git a/docs/devel/vfio-iommufd.rst b/docs/devel/vfio-iommufd.rst
index 3d1c11f175..cbf59924ba 100644
--- a/docs/devel/vfio-iommufd.rst
+++ b/docs/devel/vfio-iommufd.rst
@@ -164,3 +164,20 @@ RAM discarding for mdev.
 
 ``vfio-ap`` and ``vfio-ccw`` devices don't have same issue as their backend
 devices are always mdev and RAM discarding is force enabled.
+
+Usage with intel_iommu featuring x-flts=on
+------------------------------------------
+
+Only IOMMUFD backed VFIO device is supported when intel_iommu is configured
+with x-flts=on, for legacy container backed VFIO device, below error shows:
+
+.. code-block:: none
+
+    qemu-system-x86_64: -device vfio-pci,host=0000:02:00.0: vfio 0000:02:00.0: Failed to set vIOMMU: Need IOMMUFD backend when x-flts=on
+
+VFIO device under PCI bridge is unsupported, use PCIE bridge if necessary,
+otherwise below error shows:
+
+.. code-block:: none
+
+    qemu-system-x86_64: -device vfio-pci,host=0000:02:00.0,bus=bridge1,iommufd=iommufd0: vfio 0000:02:00.0: Failed to set vIOMMU: Host device downstream to a PCI bridge is unsupported when x-flts=on
-- 
2.47.1


