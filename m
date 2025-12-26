Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7A82EE8FDA1
	for <qemu-devel@archiver.kernel.org>; Fri, 26 Dec 2025 07:30:36 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vZ2HJ-0002pQ-8G; Fri, 26 Dec 2025 02:30:25 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhenzhong.duan@intel.com>)
 id 1vZ2HH-0002nM-6T
 for qemu-devel@nongnu.org; Fri, 26 Dec 2025 02:30:23 -0500
Received: from mgamail.intel.com ([192.198.163.15])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhenzhong.duan@intel.com>)
 id 1vZ2HD-0007JS-Is
 for qemu-devel@nongnu.org; Fri, 26 Dec 2025 02:30:22 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1766734219; x=1798270219;
 h=from:to:cc:subject:date:message-id:mime-version:
 content-transfer-encoding;
 bh=2YJkHNM0trutY8oJgVHZLOid6K0uwzlNYOSyahuALr8=;
 b=iV7dfLuoHEu7Daf19r+gKcUok8VEaR48nxqCnWV9DXdmIVoQaQDerPuW
 Nx0bYexl1uLChTLS1l3J/rJB9mK1pQmxRZn3+Dy1MEWiOh1rLlnGp4mMG
 9DU5oSWE0Rpw/vnr0bodiVV4WI9FOXqf7QMrkKp3KTv58v3KLTZCgeu88
 o9bhJ3LXxmv7oJi9KwkK+JVfcsTcF8gi9hH/DskYm2ja70VMkgeAHyigs
 dLD/BLuvrTMJvb6IE++1Ue/lMAGAYAJnUC7wcUHf6+GE3Qv47fvlIRWoT
 Muw+c/HPB5w5BZo5tDNxde151yHwmPN69GqwEW+4iJ/DjjiUDp2bxs4He w==;
X-CSE-ConnectionGUID: 0g/fQInDSLaNDoxSdCDNRQ==
X-CSE-MsgGUID: AhSK14lKSt2XiLISr2TmPQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11652"; a="68573695"
X-IronPort-AV: E=Sophos;i="6.21,177,1763452800"; d="scan'208";a="68573695"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
 by fmvoesa109.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 25 Dec 2025 23:30:15 -0800
X-CSE-ConnectionGUID: FkYeIMOySjSvkybI3yfTtQ==
X-CSE-MsgGUID: GIDv8OnCQP6v1ok5BQ6Zpg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,177,1763452800"; d="scan'208";a="204842473"
Received: from unknown (HELO gnr-sp-2s-612.sh.intel.com) ([10.112.230.229])
 by fmviesa005-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 25 Dec 2025 23:30:13 -0800
From: Zhenzhong Duan <zhenzhong.duan@intel.com>
To: qemu-devel@nongnu.org
Cc: alex@shazbot.org, clg@redhat.com, eric.auger@redhat.com,
 yi.l.liu@intel.com, joao.m.martins@oracle.com,
 Zhenzhong Duan <zhenzhong.duan@intel.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH v2] docs/devel: Remove stale comments related to iommufd dirty
 tracking
Date: Fri, 26 Dec 2025 02:30:01 -0500
Message-ID: <20251226073007.1139478-1-zhenzhong.duan@intel.com>
X-Mailer: git-send-email 2.47.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=192.198.163.15;
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

IOMMUFD dirty tracking support had be merged in merge commit dd4bc5f1cfe9,
the stale comments could be dropped.

Signed-off-by: Zhenzhong Duan <zhenzhong.duan@intel.com>
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 docs/devel/vfio-iommufd.rst | 12 ------------
 1 file changed, 12 deletions(-)

diff --git a/docs/devel/vfio-iommufd.rst b/docs/devel/vfio-iommufd.rst
index 3d1c11f175..b37098e1b6 100644
--- a/docs/devel/vfio-iommufd.rst
+++ b/docs/devel/vfio-iommufd.rst
@@ -127,18 +127,6 @@ Supports x86, ARM and s390x currently.
 Caveats
 =======
 
-Dirty page sync
----------------
-
-Dirty page sync with iommufd backend is unsupported yet, live migration is
-disabled by default. But it can be force enabled like below, low efficient
-though.
-
-.. code-block:: bash
-
-    -object iommufd,id=iommufd0
-    -device vfio-pci,host=0000:02:00.0,iommufd=iommufd0,enable-migration=on
-
 P2P DMA
 -------
 
-- 
2.47.1


