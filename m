Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D25D5CCD1AB
	for <qemu-devel@archiver.kernel.org>; Fri, 24 Oct 2025 08:47:49 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vCDRq-0007Rt-Sx; Fri, 24 Oct 2025 04:46:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhenzhong.duan@intel.com>)
 id 1vCDRK-0006k9-3e
 for qemu-devel@nongnu.org; Fri, 24 Oct 2025 04:46:31 -0400
Received: from mgamail.intel.com ([192.198.163.19])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhenzhong.duan@intel.com>)
 id 1vCDRG-0006Vx-Fh
 for qemu-devel@nongnu.org; Fri, 24 Oct 2025 04:46:25 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1761295582; x=1792831582;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=LP1D7XetZb6ZhMXtSAU5yfiQPqQ/UQw5oX+K5RQFgU0=;
 b=nHX6wy8pCaR1K3Pj1d+wpxD0atB1dtu3yQY2nzyPvxubSJk14fA4Jy/2
 GvPn/Lj7galgzlSsHbbkhsj7xBFD9I0pyf6XQqhC0dbmMczoijfJ2Rif9
 xsnGFveAraGp+d85tP+kqELA1sMn4aHm44Nx5/uL2KmlAQ0tJ02QwBeT9
 JUeJ9pMYcD3QJN6x0DTQPV3zCWrKN0rlmVg6FugrpfSXgJBx+PjfOQJO2
 g0DyX7uLiKemxqsQ0irwnTaNdUQj924saJRMJbQT5pzGKNBwoUt31Tw11
 aaAFRmmTZb5sizu2G8NgYNeH9mCNoV2tqpQXNLbz0nRC3MAUqikch933w A==;
X-CSE-ConnectionGUID: TdSgl7yZQo+iM7UFKkDUiA==
X-CSE-MsgGUID: unAr2bzrTM+hl7oiytAtwA==
X-IronPort-AV: E=McAfee;i="6800,10657,11586"; a="62504927"
X-IronPort-AV: E=Sophos;i="6.19,252,1754982000"; d="scan'208";a="62504927"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
 by fmvoesa113.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 24 Oct 2025 01:46:08 -0700
X-CSE-ConnectionGUID: pN/Ux4sCQkOCn6iu8FWVmQ==
X-CSE-MsgGUID: AanNRT4BQNSgSrO+k0UBsw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,252,1754982000"; d="scan'208";a="183986151"
Received: from unknown (HELO gnr-sp-2s-612.sh.intel.com) ([10.112.230.229])
 by orviesa009-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 24 Oct 2025 01:46:04 -0700
From: Zhenzhong Duan <zhenzhong.duan@intel.com>
To: qemu-devel@nongnu.org
Cc: alex.williamson@redhat.com, clg@redhat.com, eric.auger@redhat.com,
 mst@redhat.com, jasowang@redhat.com, peterx@redhat.com, ddutile@redhat.com,
 jgg@nvidia.com, nicolinc@nvidia.com, skolothumtho@nvidia.com,
 joao.m.martins@oracle.com, clement.mathieu--drif@eviden.com,
 kevin.tian@intel.com, yi.l.liu@intel.com, chao.p.peng@intel.com,
 Zhenzhong Duan <zhenzhong.duan@intel.com>
Subject: [PATCH v7 23/23] docs/devel: Add IOMMUFD nesting documentation
Date: Fri, 24 Oct 2025 04:43:47 -0400
Message-ID: <20251024084349.102322-24-zhenzhong.duan@intel.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20251024084349.102322-1-zhenzhong.duan@intel.com>
References: <20251024084349.102322-1-zhenzhong.duan@intel.com>
MIME-Version: 1.0
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

Add documentation about using IOMMUFD backed VFIO device with intel_iommu with
x-flts=on.

Suggested-by: Yi Liu <yi.l.liu@intel.com>
Signed-off-by: Zhenzhong Duan <zhenzhong.duan@intel.com>
---
 docs/devel/vfio-iommufd.rst | 25 +++++++++++++++++++++++++
 1 file changed, 25 insertions(+)

diff --git a/docs/devel/vfio-iommufd.rst b/docs/devel/vfio-iommufd.rst
index 3d1c11f175..f1e4d940e6 100644
--- a/docs/devel/vfio-iommufd.rst
+++ b/docs/devel/vfio-iommufd.rst
@@ -164,3 +164,28 @@ RAM discarding for mdev.
 
 ``vfio-ap`` and ``vfio-ccw`` devices don't have same issue as their backend
 devices are always mdev and RAM discarding is force enabled.
+
+Usage with intel_iommu with x-flts=on
+-------------------------------------
+
+Only IOMMUFD backed VFIO device is supported when intel_iommu is configured
+with x-flts=on, for legacy container backed VFIO device, below error shows:
+
+.. code-block:: none
+
+    qemu-system-x86_64: -device vfio-pci,host=0000:02:00.0: vfio 0000:02:00.0: Failed to set vIOMMU: Need IOMMUFD backend when x-flts=on
+
+VFIO device under PCI bridge is unsupported, use PCIE bridge if necessary,
+or else below error shows:
+
+.. code-block:: none
+
+    qemu-system-x86_64: -device vfio-pci,host=0000:02:00.0,bus=bridge1,iommufd=iommufd0: vfio 0000:02:00.0: Failed to set vIOMMU: Host device under PCI bridge is unsupported when x-flts=on
+
+If host IOMMU has ERRATA_772415_SPR17, kexec or reboot from "intel_iommu=on,sm_on"
+to "intel_iommu=on,sm_off" in guest is also unsupported. Configure scalable mode
+off as below if it's not needed by guest.
+
+.. code-block:: bash
+
+    -device intel-iommu,x-scalable-mode=off
-- 
2.47.1


