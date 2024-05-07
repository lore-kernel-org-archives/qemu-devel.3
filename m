Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 41339C25B75
	for <qemu-devel@archiver.kernel.org>; Tue,  7 May 2024 06:46:17 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s4EZl-00037s-Gb; Tue, 07 May 2024 02:45:21 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhenzhong.duan@intel.com>)
 id 1s4EZh-000366-08
 for qemu-devel@nongnu.org; Tue, 07 May 2024 02:45:17 -0400
Received: from mgamail.intel.com ([192.198.163.10])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhenzhong.duan@intel.com>)
 id 1s4EZd-0004xu-UE
 for qemu-devel@nongnu.org; Tue, 07 May 2024 02:45:16 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1715064314; x=1746600314;
 h=from:to:cc:subject:date:message-id:mime-version:
 content-transfer-encoding;
 bh=ZAnWuegHbLPuSZnA6eackL2uGPiM3H6HFgwU9RDIcpk=;
 b=XM2pOeQHxidBnUjYGxeKXgpHR4bwVwmoxnDPJN7BeLqc3UVJVRBWHD6K
 H0cbfojG3RIM2O5WxkWny08hup27EBYIIFffeTGnSWJIYWhG+rRkdEhza
 gIa0/XOA/+JBzdPj0rp/PZfzK+ykBLgW+iklCs1VfmECAcmo1htUe9n/Q
 ftMZr7UzGkDQUliMQQAAxMLddLPyAK+Krxcxb0ruxx8SJ2+TzZKjI/1f8
 MhufBc6czH6pMec0aJb7EkZiJtcGTw7ENlKaI3qWbgibSpzTqpYbDoq2r
 xdBRHHtZ+pDiJBP4drXPnmSThSXamoYaHUGngg2QQ8bOxrJ1eERYu8plv w==;
X-CSE-ConnectionGUID: cZxZLW6kSMqYoZ3jof8l0g==
X-CSE-MsgGUID: EKsqaEEvQzae+cAHOSKHng==
X-IronPort-AV: E=McAfee;i="6600,9927,11065"; a="22240211"
X-IronPort-AV: E=Sophos;i="6.07,260,1708416000"; d="scan'208";a="22240211"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
 by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 06 May 2024 23:45:11 -0700
X-CSE-ConnectionGUID: vveMYWi5TU+d1fL4ZwvRqQ==
X-CSE-MsgGUID: nU5hhprUTG2U29BcVXIUbg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,260,1708416000"; d="scan'208";a="28407501"
Received: from unknown (HELO SPR-S2600BT.bj.intel.com) ([10.240.192.124])
 by fmviesa008-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 06 May 2024 23:45:09 -0700
From: Zhenzhong Duan <zhenzhong.duan@intel.com>
To: qemu-devel@nongnu.org
Cc: alex.williamson@redhat.com, clg@redhat.com, eric.auger@redhat.com,
 chao.p.peng@intel.com, Zhenzhong Duan <zhenzhong.duan@intel.com>
Subject: [PATCH v2 00/11] VFIO: misc cleanups
Date: Tue,  7 May 2024 14:42:41 +0800
Message-Id: <20240507064252.457884-1-zhenzhong.duan@intel.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=192.198.163.10;
 envelope-from=zhenzhong.duan@intel.com; helo=mgamail.intel.com
X-Spam_score_int: -49
X-Spam_score: -5.0
X-Spam_bar: -----
X-Spam_report: (-5.0 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.581,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, SPF_HELO_NONE=0.001,
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

Hi

This is a cleanup series to change functions in hw/vfio/ to return bool 
when the error is passed through errp parameter, also some cleanup
with g_autofree.

See discussion at https://lists.gnu.org/archive/html/qemu-devel/2024-04/msg04782.html

This series processed below files:
hw/vfio/container.c
hw/vfio/iommufd.c
hw/vfio/cpr.c
backends/iommufd.c

So above files are clean now, there are still other files need processing
in hw/vfio.

Test done on x86 platform:
vfio device hotplug/unplug with different backend
reboot

Thanks
Zhenzhong

Changelog:
v2:
- split out g_autofree code as a patch (Cédric)
- add processing for more files

Zhenzhong Duan (11):
  vfio/pci: Use g_autofree in vfio_realize
  vfio/pci: Use g_autofree in iommufd_cdev_get_info_iova_range()
  vfio: Make VFIOIOMMUClass::attach_device() and its wrapper return bool
  vfio: Make VFIOIOMMUClass::setup() return bool
  vfio: Make VFIOIOMMUClass::add_window() and its wrapper return bool
  vfio/container: Make vfio_connect_container() return bool
  vfio/container: Make vfio_set_iommu() return bool
  vfio/container: Make vfio_get_device() return bool
  vfio/iommufd: Make iommufd_cdev_*() return bool
  vfio/cpr: Make vfio_cpr_register_container() return bool
  backends/iommufd: Make iommufd_backend_*() return bool

 include/hw/vfio/vfio-common.h         |   6 +-
 include/hw/vfio/vfio-container-base.h |  18 ++---
 include/sysemu/iommufd.h              |   6 +-
 backends/iommufd.c                    |  29 +++----
 hw/vfio/ap.c                          |   6 +-
 hw/vfio/ccw.c                         |   6 +-
 hw/vfio/common.c                      |   6 +-
 hw/vfio/container-base.c              |   8 +-
 hw/vfio/container.c                   |  81 +++++++++----------
 hw/vfio/cpr.c                         |   4 +-
 hw/vfio/iommufd.c                     | 109 +++++++++++---------------
 hw/vfio/pci.c                         |  12 ++-
 hw/vfio/platform.c                    |   7 +-
 hw/vfio/spapr.c                       |  28 +++----
 backends/trace-events                 |   4 +-
 15 files changed, 147 insertions(+), 183 deletions(-)

-- 
2.34.1


