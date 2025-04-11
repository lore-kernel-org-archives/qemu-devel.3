Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2C961C36010
	for <qemu-devel@archiver.kernel.org>; Fri, 11 Apr 2025 10:21:38 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u3BVo-0002kF-2W; Fri, 11 Apr 2025 06:21:28 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhenzhong.duan@intel.com>)
 id 1u3BVe-0002ba-18
 for qemu-devel@nongnu.org; Fri, 11 Apr 2025 06:21:18 -0400
Received: from mgamail.intel.com ([198.175.65.15])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhenzhong.duan@intel.com>)
 id 1u3BVT-0005Nr-4m
 for qemu-devel@nongnu.org; Fri, 11 Apr 2025 06:21:11 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1744366867; x=1775902867;
 h=from:to:cc:subject:date:message-id:mime-version:
 content-transfer-encoding;
 bh=1F7a1sjUDngnN5oBLAUAUwgEDgDAboQux7dnCudMDgI=;
 b=hZgWI7L6Q/0p/HvvnMQleogswwiGyd8QyTazLNzPuwV56oiLWZrfAGji
 kDsMbiwwjHa5Cca7eirmn8FILvIRwiJqCv05Eu6Xyo4d1mwVcfHkAOWUc
 xpLcTo2jYL3w8lYJ4m6EuZSPHhLT+EdZ2C9r6b+rEZkmpbvGi2Kc9jKub
 ccMf3Wii43p2Fj8fzKo38VIEX1TXalVQztakbxHmlKi0Aetxb14m33fqD
 cDdGDCSwRLHi+Zx5DKzBYuz7GpBC5vmrwXl51ztB4hYCbAXOm+a518yCg
 zinUzdcZDlQEUwRtC63J/tIUMP1vgh/7Uw9hTbcfarFwRePinOUPDcXhG w==;
X-CSE-ConnectionGUID: 92ZFZwgMSsyuzlPb9C4msA==
X-CSE-MsgGUID: RwdnyvwGRGeMuIPcUyG/aw==
X-IronPort-AV: E=McAfee;i="6700,10204,11400"; a="49566775"
X-IronPort-AV: E=Sophos;i="6.15,205,1739865600"; d="scan'208";a="49566775"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
 by orvoesa107.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 11 Apr 2025 03:20:46 -0700
X-CSE-ConnectionGUID: +qcDf0G7Qq2eUJazeBmj3w==
X-CSE-MsgGUID: 4gPhNCWtTNGrjv6WwsxbcA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,205,1739865600"; d="scan'208";a="133917406"
Received: from spr-s2600bt.bj.intel.com ([10.240.192.127])
 by fmviesa005-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 11 Apr 2025 03:20:44 -0700
From: Zhenzhong Duan <zhenzhong.duan@intel.com>
To: qemu-devel@nongnu.org
Cc: alex.williamson@redhat.com, clg@redhat.com, eric.auger@redhat.com,
 nicolinc@nvidia.com, joao.m.martins@oracle.com, chao.p.peng@intel.com,
 Zhenzhong Duan <zhenzhong.duan@intel.com>
Subject: [PATCH 0/5] cleanup interfaces
Date: Fri, 11 Apr 2025 18:17:02 +0800
Message-Id: <20250411101707.3460429-1-zhenzhong.duan@intel.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=198.175.65.15;
 envelope-from=zhenzhong.duan@intel.com; helo=mgamail.intel.com
X-Spam_score_int: -49
X-Spam_score: -5.0
X-Spam_bar: -----
X-Spam_report: (-5.0 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.593,
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

Hi,

This series addresses Cédric's suggestion[1] and Donald's suggestion[2] to
move realize() call after attach_device().

Also addresses Eric and Nicolin's suggestion[3] to use a union to hold different
vendor capabilities.

[1] https://lists.gnu.org/archive/html/qemu-devel/2025-04/msg01211.html
[2] https://lists.gnu.org/archive/html/qemu-devel/2025-04/msg00898.html
[3] https://lists.gnu.org/archive/html/qemu-devel/2025-03/msg01552.html

Test:
net card passthrough and ping test
hotplug/unplug

Based on vfio-next(b9d42a878b).

Thanks
Zhenzhong


Zhenzhong Duan (5):
  vfio/iommufd: Save host iommu capabilities in VFIODevice.caps
  vfio: Move realize() after attach_device()
  vfio/iommufd: Implement .get_cap() in
    TYPE_HOST_IOMMU_DEVICE_IOMMUFD_VFIO sub-class
  backends/iommufd: Drop hiod_iommufd_get_cap()
  vfio/iommufd: Drop HostIOMMUDeviceCaps from HostIOMMUDevice

 include/hw/vfio/vfio-device.h      |  2 +-
 include/system/host_iommu_device.h | 14 -------
 include/system/iommufd.h           | 26 ++++++++++++
 backends/iommufd.c                 | 63 +++++++++++++++++++-----------
 hw/vfio/container.c                |  4 --
 hw/vfio/device.c                   | 28 ++++++-------
 hw/vfio/iommufd.c                  | 39 ++++++++++--------
 7 files changed, 100 insertions(+), 76 deletions(-)

-- 
2.34.1


