Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4AD08C04FF6
	for <qemu-devel@archiver.kernel.org>; Fri, 12 Apr 2024 08:41:59 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rvCTg-0007eM-DX; Fri, 12 Apr 2024 04:41:44 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@linux.intel.com>)
 id 1rvCT1-0006qQ-DP
 for qemu-devel@nongnu.org; Fri, 12 Apr 2024 04:41:04 -0400
Received: from mgamail.intel.com ([192.198.163.12])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@linux.intel.com>)
 id 1rvCSS-0002ja-Er
 for qemu-devel@nongnu.org; Fri, 12 Apr 2024 04:41:01 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1712911228; x=1744447228;
 h=from:to:cc:subject:date:message-id:mime-version:
 content-transfer-encoding;
 bh=Gye3ezfUZUQgYabKp57UFmi3HZOsbTFqJkeu2em8YCM=;
 b=aeC5A2kPHeBErGp+o6Xj86LscBcPFsiMyGP6qqdyUfYKpAbNtnw1VsAc
 vHDAoZWiKGiyrdY14yXYb1hJJTYldiNekjacis83gI+jyYNR/kIeS0tWO
 VC90bFaf19vOnipIsAFNMbS8GmNpEE0xJ0aWxHxCsjwV0DhhM+PYy2iDA
 K3DKf6Fj3b+0JYa/dLcIelP//SHKZ9sWw1AH0vplJrjsN1d+Vlyzai6nQ
 j8fhGGwbHvDACJOWQpa75qcKcAezg3aM8y5HsSmxSyPKiHgUl7s0otiTI
 I1bBKS04h3D/yhCrcLFJXiZpvKB/hJNMQJxs+Iyhj1fJeY0RytDy4S2dy Q==;
X-CSE-ConnectionGUID: 8RwkV5+gQF6G+jSrHNszvw==
X-CSE-MsgGUID: hEHquW+XRWq4Eda93Y7ctw==
X-IronPort-AV: E=McAfee;i="6600,9927,11041"; a="12143747"
X-IronPort-AV: E=Sophos;i="6.07,195,1708416000"; d="scan'208";a="12143747"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
 by fmvoesa106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 12 Apr 2024 01:40:14 -0700
X-CSE-ConnectionGUID: H+uqnmNSTPWs4DG7kgruWg==
X-CSE-MsgGUID: 41y+7qHXTo2M9fMNokmIuQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,195,1708416000"; d="scan'208";a="21261803"
Received: from liuzhao-optiplex-7080.sh.intel.com ([10.239.160.36])
 by fmviesa008.fm.intel.com with ESMTP; 12 Apr 2024 01:40:12 -0700
From: Zhao Liu <zhao1.liu@linux.intel.com>
To: Paolo Bonzini <pbonzini@redhat.com>,
 "Michael S . Tsirkin" <mst@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Cc: qemu-devel@nongnu.org,
	Zhao Liu <zhao1.liu@intel.com>
Subject: [PATCH-for-9.0?] docs: i386: pc: Update maximum CPU numbers for PC Q35
Date: Fri, 12 Apr 2024 16:53:58 +0800
Message-Id: <20240412085358.731560-1-zhao1.liu@linux.intel.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: none client-ip=192.198.163.12;
 envelope-from=zhao1.liu@linux.intel.com; helo=mgamail.intel.com
X-Spam_score_int: -51
X-Spam_score: -5.2
X-Spam_bar: -----
X-Spam_report: (-5.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-2.49,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_DNSWL_LOW=-0.7,
 SPF_HELO_NONE=0.001, SPF_NONE=0.001 autolearn=ham autolearn_force=no
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

From: Zhao Liu <zhao1.liu@intel.com>

Commit e4e98c7eebfa ("pc: q35: Bump max_cpus to 4096 vcpus") increases
the supported CPUs for PC Q35 machine.

Update maximum CPU numbers for PC Q35 in the document.

Signed-off-by: Zhao Liu <zhao1.liu@intel.com>
---
 docs/system/target-i386-desc.rst.inc | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/docs/system/target-i386-desc.rst.inc b/docs/system/target-i386-desc.rst.inc
index 5ebbcda9db4c..319e540573d3 100644
--- a/docs/system/target-i386-desc.rst.inc
+++ b/docs/system/target-i386-desc.rst.inc
@@ -36,7 +36,7 @@ The QEMU PC System emulator simulates the following peripherals:
 -  PCI UHCI, OHCI, EHCI or XHCI USB controller and a virtual USB-1.1
    hub.
 
-SMP is supported with up to 255 CPUs.
+SMP is supported with up to 255 CPUs (and 4096 CPUs for PC Q35 machine).
 
 QEMU uses the PC BIOS from the Seabios project and the Plex86/Bochs LGPL
 VGA BIOS.
-- 
2.34.1


