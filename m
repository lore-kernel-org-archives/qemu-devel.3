Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 55919CA5FAB
	for <qemu-devel@archiver.kernel.org>; Wed, 30 Sep 2026 04:53:48 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xBmJT-0006vY-CL; Wed, 30 Sep 2026 00:53:03 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1xBmJR-0006ub-2v
 for qemu-devel@nongnu.org; Wed, 30 Sep 2026 00:53:01 -0400
Received: from mgamail.intel.com ([192.198.163.13])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1xBmJO-0001MG-NV
 for qemu-devel@nongnu.org; Wed, 30 Sep 2026 00:53:00 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1790743979; x=1822279979;
 h=from:to:cc:subject:date:message-id:mime-version:
 content-transfer-encoding;
 bh=CW6OXHqYQ1vhOSuGaKFSorThCe3HC5YEDOkxzWHKL8k=;
 b=ZcdfqSdnSKXSgxpZgjVvCrQpVveWEqvVl24uhnNslAIiPE9tPQAOEX2v
 OD912jF1M4EpOHABX0gvul5Q3eyo42nbAkOs9TOa+cONtqxdyTzCr/dAW
 tPSx+AL/Xnk4PiNerCRbIsmPiNof5SI8uMw5TPoItQyJ3Ae7dw+0lf25y
 fttuF0NeKITSitwOsjWD/QTX+VflArmyvo/sqJuGao67zR64H/HwWrq/r
 HgBOSGvWS75UAbKxCpudQDVCZPOL/TiMG1rz8D7/i06TQu8LC4Abfs1Ht
 OciLOytOHCfKiFbAgN7W4CKdKHzxgnQhBvSf4rfSgOSlTbN6JMMYURj0T w==;
X-CSE-ConnectionGUID: GXwXFFQBTwiV8RTKy8X3ag==
X-CSE-MsgGUID: N2ypksLuTeSLvgMqAE8LnA==
X-IronPort-AV: E=McAfee;i="6800,10657,11920"; a="93959624"
X-IronPort-AV: E=Sophos;i="6.27,130,1787036400"; d="scan'208";a="93959624"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
 by fmvoesa107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 29 Sep 2026 21:52:54 -0700
X-CSE-ConnectionGUID: n8x4rQANQJKyVbWO/UV1Tw==
X-CSE-MsgGUID: X+d8PRyxS/+obM5pZYDevw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,130,1787036400"; d="scan'208";a="275721197"
Received: from zhaoliu1-desk.sh.intel.com ([10.112.226.173])
 by fmviesa008.fm.intel.com with ESMTP; 29 Sep 2026 21:52:52 -0700
From: Zhao Liu <zhao1.liu@intel.com>
To: Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
Cc: qemu-devel@nongnu.org,
	Zhao Liu <zhao1.liu@intel.com>
Subject: [PATCH 0/3] i386/cpu: miscellaneous fixes for DiamondRapids
Date: Wed, 30 Sep 2026 12:52:34 +0800
Message-Id: <20260930045237.784060-1-zhao1.liu@intel.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=192.198.163.13; envelope-from=zhao1.liu@intel.com;
 helo=mgamail.intel.com
X-Spam_score_int: -46
X-Spam_score: -4.7
X-Spam_bar: ----
X-Spam_report: (-4.7 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.341,
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

Hi,

This series includes:
 * AVX10.2 feature renaming to keep up with the latest spec changes.
 * A fix for DMR cache topology emulation.

In addition, there is another TF32 fix remaining in the mail list,
which is a change in hardware implementation:

https://lore.kernel.org/qemu-devel/20260720205227.519647-1-chang.seok.bae@intel.com/

Thanks and Best Regards,
Zhao
---
Zhao Liu (3):
  i386/cpu: rename feature name avx10-vnni-int to avx10-v1-aux
  i386/cpu: rename CPUID_24_1_ECX_AVX10_VNNI_INT macro to
    CPUID_24_1_ECX_AVX10_V1_AUX
  hw/core/machine-smp: allow thread level cache

 hw/core/machine-smp.c | 7 -------
 target/i386/cpu.c     | 7 ++++---
 target/i386/cpu.h     | 4 ++--
 3 files changed, 6 insertions(+), 12 deletions(-)

-- 
2.34.1


