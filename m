Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E48D1C38150
	for <qemu-devel@archiver.kernel.org>; Mon,  8 Jul 2024 03:21:52 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sQewL-0008DS-Ux; Sun, 07 Jul 2024 23:21:21 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <yi.l.liu@intel.com>)
 id 1sQewJ-0008C9-V9
 for qemu-devel@nongnu.org; Sun, 07 Jul 2024 23:21:19 -0400
Received: from mgamail.intel.com ([198.175.65.9])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <yi.l.liu@intel.com>)
 id 1sQewH-0005SL-UV
 for qemu-devel@nongnu.org; Sun, 07 Jul 2024 23:21:19 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1720408878; x=1751944878;
 h=from:to:cc:subject:date:message-id:mime-version:
 content-transfer-encoding;
 bh=qGpphKD2MHckpDsrvV7wCw2B5tZZdN5M0mP7XPL+FHI=;
 b=EQlB/uJPh7uzbpnCi64RVZhyO2x0BHiut2g46bdzgVQ9xQHLUIBelmv4
 G3W5ZeRQ+VxjSPcxjYuj1rJBVFFma7VBitiOE/b4FkB2nPAEYSgqSZlOY
 o+kcQNEso93ZkJ4ezZ9kIuEeQjosGN+wjfG1vj5xPd8SyFA/vPNjteTII
 kR+b5VBvJGcSat6ERHJyNL+CK0BP2g6S33ZFZYktFsnI1iFoZmK0z0NOL
 VT0XsFJy6rahxcVVSsD7IFaI3YrEOT2KM6KFelFKoO4+iaAGZoc4IH6Xi
 qUSqe6yEFfyX/890KUeNuuDaQfToxiO2tiA52IU2iJsFZHfogqyHZi232 g==;
X-CSE-ConnectionGUID: 8QOghVlzTxypCdKwOYhlqA==
X-CSE-MsgGUID: j/vxtbDFRJCueAMakA+t2Q==
X-IronPort-AV: E=McAfee;i="6700,10204,11126"; a="40103835"
X-IronPort-AV: E=Sophos;i="6.09,191,1716274800"; d="scan'208";a="40103835"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
 by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 07 Jul 2024 20:21:15 -0700
X-CSE-ConnectionGUID: 4e3QDb68SpOIcVmYlqwVYw==
X-CSE-MsgGUID: chhcKW8ZQlWD0iJa2LqxUw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.09,191,1716274800"; d="scan'208";a="47346258"
Received: from 984fee00a4c6.jf.intel.com ([10.165.58.231])
 by fmviesa009.fm.intel.com with ESMTP; 07 Jul 2024 20:21:14 -0700
From: Yi Liu <yi.l.liu@intel.com>
To: jasowang@redhat.com,
	mst@redhat.com
Cc: qemu-devel@nongnu.org,
	peterx@redhat.com,
	Yi Liu <yi.l.liu@intel.com>
Subject: [PATCH] MAINTAINERS: Add myself as a VT-d reviewer
Date: Sun,  7 Jul 2024 20:21:12 -0700
Message-Id: <20240708032112.796339-1-yi.l.liu@intel.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=198.175.65.9; envelope-from=yi.l.liu@intel.com;
 helo=mgamail.intel.com
X-Spam_score_int: -43
X-Spam_score: -4.4
X-Spam_bar: ----
X-Spam_report: (-4.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
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

Signed-off-by: Yi Liu <yi.l.liu@intel.com>
---
 MAINTAINERS | 1 +
 1 file changed, 1 insertion(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index 6725913c8b..61724b91d8 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -3656,6 +3656,7 @@ F: tests/uefi-test-tools/
 VT-d Emulation
 M: Michael S. Tsirkin <mst@redhat.com>
 R: Jason Wang <jasowang@redhat.com>
+R: Yi Liu <yi.l.liu@intel.com>
 S: Supported
 F: hw/i386/intel_iommu.c
 F: hw/i386/intel_iommu_internal.h
-- 
2.34.1


