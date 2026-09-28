Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6F525CA5FA6
	for <qemu-devel@archiver.kernel.org>; Mon, 28 Sep 2026 08:43:05 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xB6wa-0005Th-Fh; Mon, 28 Sep 2026 04:42:40 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <yuan1.wang@intel.com>)
 id 1xB6wY-0005TV-ST
 for qemu-devel@nongnu.org; Mon, 28 Sep 2026 04:42:38 -0400
Received: from mgamail.intel.com ([192.198.163.13])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <yuan1.wang@intel.com>)
 id 1xB6wW-0001ko-PP
 for qemu-devel@nongnu.org; Mon, 28 Sep 2026 04:42:38 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1790584957; x=1822120957;
 h=from:to:cc:subject:date:message-id:mime-version:
 content-transfer-encoding;
 bh=U296VDTVmyeKHYcJjaaCCIa9zNXSAZUOiLYy3QNe0EM=;
 b=Ti+L4WsPgKOYqfhjsnTNVWc3zNqbEpPs5tdv2bJTSbHQ3Ez2TbqqzK6h
 bkiEOsr+O7y2ruGIHE1ZLQScKLIQsCowos83zsgL2xjSr61dGnb/5OCE0
 X5ZTYKOxqh31EHfnkv/UEUmRgL1Y5nCIsO3288IAw6cY1zXqCvwpBlSCY
 77TOAo6Hw2FpH+UnTRQ0DycIAnYLtUp1lrBhsu/gwjT5Y4eQRHjQeLJvc
 JKULzNwXdxVFy9SzFcqQNQRPvZ+btNVy0QDBZQUt4Bqs6v7EUHUicU2mp
 bItDaSvV/gTxv5dLMtJY0JHOa7VpHtFWaF756dBXTf4gy4EBTUOWJ9XCa w==;
X-CSE-ConnectionGUID: b1trljpCRNypELxcsXJhaw==
X-CSE-MsgGUID: fEIlnRy0SvWbbcst6Z5dNw==
X-IronPort-AV: E=McAfee;i="6800,10657,11918"; a="93768028"
X-IronPort-AV: E=Sophos;i="6.27,128,1787036400"; d="scan'208";a="93768028"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
 by fmvoesa107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 28 Sep 2026 01:42:31 -0700
X-CSE-ConnectionGUID: 5vD66DsGTf+gfFsVhwgIOA==
X-CSE-MsgGUID: Rh8CsiViSqeDU9HNa/3kyw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,128,1787036400"; d="scan'208";a="302937407"
Received: from qat-wangyuan-17e.sh.intel.com ([10.239.92.81])
 by fmviesa001.fm.intel.com with ESMTP; 28 Sep 2026 01:42:30 -0700
From: Yuan Wang <yuan1.wang@intel.com>
To: qemu-devel@nongnu.org
Cc: alex@shazbot.org, clg@redhat.com, tomitamoeko@gmail.com,
 bosheng.xue@intel.com, Yuan Wang <yuan1.wang@intel.com>
Subject: [PATCH v1] vfio/igd: Update igd-assign.txt for Intel MTL and newer
 platforms
Date: Mon, 28 Sep 2026 16:42:26 +0800
Message-Id: <20260928084226.3537126-1-yuan1.wang@intel.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=192.198.163.13; envelope-from=yuan1.wang@intel.com;
 helo=mgamail.intel.com
X-Spam_score_int: -46
X-Spam_score: -4.7
X-Spam_bar: ----
X-Spam_report: (-4.7 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.34,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, SPF_HELO_NONE=0.001,
 SPF_NONE=0.001 autolearn=ham autolearn_force=no
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

Update the igd-assign.txt documentation to reflect the addition of
the 0006 patch in the ECI repository. This patch is required to
enable support for Meteor Lake (MTL) and subsequent Intel platforms.

Starting from MTL, the hardware-accessible BDSM (Base of Data Stolen
Memory) register in the PCI configuration space has been removed.
Instead, IGD devices now access stolen memory via MMIO BAR2 (LMEMBAR).
Consequently, guest firmware no longer needs to program the legacy
BDSM register.

Reviewed-by: Bosheng Xue <bosheng.xue@intel.com>
Signed-off-by: Yuan Wang <yuan1.wang@intel.com>
---
Note:

We added a patch to the ECI website to skip the DSM zero-size check as
the sixth patch. Accordingly, we updated igd-assign.txt to reflect this
change.

Link:
https://eci.intel.com/docs/3.3/components/kvm-hypervisor.html
---
 docs/igd-assign.txt | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/docs/igd-assign.txt b/docs/igd-assign.txt
index e54040335b..b9abfdbac3 100644
--- a/docs/igd-assign.txt
+++ b/docs/igd-assign.txt
@@ -263,6 +263,6 @@ Footnotes
 [2] # echo "vfio-pci" > /sys/bus/pci/devices/0000:00:02.0/driver_override
 [3] https://web.archive.org/web/20240827012422/https://bugzilla.tianocore.org/show_bug.cgi?id=935
     Tianocore bugzilla was down since Jan 2025 :(
-[4] https://eci.intel.com/docs/3.3/components/kvm-hypervisor.html, Patch 0001-0004
+[4] https://eci.intel.com/docs/3.3/components/kvm-hypervisor.html, Patch 0001-0004, 0006
 [5] https://github.com/tomitamoeko/VfioIgdPkg
 [6] https://winraid.level1techs.com/t/tool-guide-news-uefi-bios-updater-ubu/30357
-- 
2.34.1


