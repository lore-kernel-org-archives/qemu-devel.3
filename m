Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E7D4CFD2D9D
	for <qemu-devel@archiver.kernel.org>; Wed, 11 Mar 2026 09:24:33 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w0Fn8-0003ku-Jt; Wed, 11 Mar 2026 05:23:46 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhenzhong.duan@intel.com>)
 id 1w0Fn6-0003kQ-AI
 for qemu-devel@nongnu.org; Wed, 11 Mar 2026 05:23:44 -0400
Received: from mgamail.intel.com ([198.175.65.9])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhenzhong.duan@intel.com>)
 id 1w0Fn0-0001Qx-FM
 for qemu-devel@nongnu.org; Wed, 11 Mar 2026 05:23:42 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1773221019; x=1804757019;
 h=from:to:cc:subject:date:message-id:mime-version:
 content-transfer-encoding;
 bh=7fu1PwVfPWhuQKOHLxcNglUxfvsJ3RT2O2mDqeAtmsM=;
 b=dXzgY5ST4PW1FeFPowtU5l+Pgh/tdtTDdgfY3XvwexoLyywu6f8POTUa
 HjoAe4aFLs8DsBX5Ls4m4EYHA6BB8qQCquSZm+mxLjpQvtY+Hmcxyhl78
 ucIc3LxnAsRREeZH9H9W3A8GRhC7t486YYqcZjDdAEBcBEtxkdT1RAcLd
 1W50dhVwJ+78gX1RSd/3uR5iWoma80xe1jZJ9owsF1zvcyqqH737vgs8I
 0XvFsjeLKmrk3/7MPSdn2FDOc2Y4WfzvTH5UkD3gvOtywRfFmoc0CXPZg
 +E4rukGddnFAuYi4UoyLnN3lqlgcUXb376TWeQ0HgYZpt28Yu6gVsU16v w==;
X-CSE-ConnectionGUID: I5Iy5lRwSk2KU1FxSbIPfg==
X-CSE-MsgGUID: 9LAIGP/YSNKVfa6RnoJXgg==
X-IronPort-AV: E=McAfee;i="6800,10657,11725"; a="96899422"
X-IronPort-AV: E=Sophos;i="6.23,113,1770624000"; d="scan'208";a="96899422"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
 by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 11 Mar 2026 02:23:31 -0700
X-CSE-ConnectionGUID: nt7DmJ7BT2K6GLBdmo88uw==
X-CSE-MsgGUID: /cTVAlTrQAuEUlEocBgRwg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,113,1770624000"; d="scan'208";a="220353991"
Received: from unknown (HELO gnr-sp-2s-612.sh.intel.com) ([10.112.230.229])
 by orviesa009-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 11 Mar 2026 02:23:29 -0700
From: Zhenzhong Duan <zhenzhong.duan@intel.com>
To: qemu-devel@nongnu.org
Cc: mst@redhat.com, jasowang@redhat.com, berrange@redhat.com, clg@redhat.com,
 nathanc@nvidia.com, clement.mathieu--drif@bull.com, philmd@linaro.org,
 yi.l.liu@intel.com, Zhenzhong Duan <zhenzhong.duan@intel.com>
Subject: [PATCH v2 0/2] Update properties naming for 'x-scalable-mode' and
 'x-flts'
Date: Wed, 11 Mar 2026 05:23:18 -0400
Message-ID: <20260311092320.212849-1-zhenzhong.duan@intel.com>
X-Mailer: git-send-email 2.47.3
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=198.175.65.9;
 envelope-from=zhenzhong.duan@intel.com; helo=mgamail.intel.com
X-Spam_score_int: -26
X-Spam_score: -2.7
X-Spam_bar: --
X-Spam_report: (-2.7 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.819,
 RCVD_IN_VALIDITY_SAFE_BLOCKED=0.903, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

Hi,

This series dropped 'x-' prefix for properties 'x-scalable-mode' and 'x-flts',
by this chance also renamed 'flts' to 'fsts' to align with newer spec.

After that, we can add scalable mode and first stage translation support to
libvirt.

Thanks
Zhenzhong

Zhenzhong Duan (2):
  intel_iommu: Remove 'x-' prefix from 'x-scalable-mode' and 'x-flts'
    properties
  intel_iommu: Change 'flts' property naming to 'fsts'

 docs/devel/vfio-iommufd.rst    | 10 +++++-----
 hw/i386/intel_iommu.c          | 12 ++++++------
 hw/i386/intel_iommu_accel.c    |  6 +++---
 tests/qtest/intel-iommu-test.c |  2 +-
 4 files changed, 15 insertions(+), 15 deletions(-)

-- 
2.47.3


