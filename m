Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 17CA4C46CD2
	for <qemu-devel@archiver.kernel.org>; Thu, 25 Jan 2024 02:41:05 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rSpfH-0003Tn-Ma; Wed, 24 Jan 2024 21:40:27 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <xiaoyao.li@intel.com>)
 id 1rSpfF-0003TV-W9
 for qemu-devel@nongnu.org; Wed, 24 Jan 2024 21:40:26 -0500
Received: from mgamail.intel.com ([192.55.52.115])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <xiaoyao.li@intel.com>)
 id 1rSpfD-0007ct-QA
 for qemu-devel@nongnu.org; Wed, 24 Jan 2024 21:40:25 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1706150423; x=1737686423;
 h=from:to:cc:subject:date:message-id:mime-version:
 content-transfer-encoding;
 bh=3933UFFK4+NnKWVMGTTstsPH7Q7r+J7R/gfhlP4cKH4=;
 b=OPSA1UbnCF0HQkAFTlcU7CY1VPsVUFKxqjzQkR0PzHkOWZmEJiWUefbm
 93lBPhawTkSIX5/BzUWpZnBAZVkvvwT8JtC+TCYoIttBMCF47ahXxAuJ7
 MFA2EGLCbzzIl6iNtM2YndHTJqd4V+SJGy0uXVxbyoVPGm7gOBTOV8JrB
 gU1qfFE5FlHap64+nBWUIwIxuSFECariboa3E0/z8Twqzzv6kSdSDXQOm
 dEUG9FvsWiJ2RnsORbuECkcADpO1CuR2rhX3lzaKfc5nMr24khT8CBWT9
 l0o4gSRgAVJEtrrDbEZbOqIOxg4+2Y7xa1n4tjofYe52ZTjce3aT/cRMV A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10962"; a="401687446"
X-IronPort-AV: E=Sophos;i="6.05,216,1701158400"; d="scan'208";a="401687446"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
 by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 24 Jan 2024 18:40:21 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.05,216,1701158400"; 
   d="scan'208";a="2120527"
Received: from lxy-clx-4s.sh.intel.com ([10.239.48.52])
 by orviesa003.jf.intel.com with ESMTP; 24 Jan 2024 18:40:19 -0800
From: Xiaoyao Li <xiaoyao.li@intel.com>
To: Paolo Bonzini <pbonzini@redhat.com>, Marcelo Tosatti <mtosatti@redhat.com>
Cc: qemu-devel@nongnu.org,
	kvm@vger.kernel.org,
	xiaoyao.li@intel.com
Subject: [PATCH v3 0/3] i386: Minor fixes for building  CPUIDs
Date: Wed, 24 Jan 2024 21:40:13 -0500
Message-Id: <20240125024016.2521244-1-xiaoyao.li@intel.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=192.55.52.115; envelope-from=xiaoyao.li@intel.com;
 helo=mgamail.intel.com
X-Spam_score_int: -38
X-Spam_score: -3.9
X-Spam_bar: ---
X-Spam_report: (-3.9 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.5,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 HK_RANDOM_ENVFROM=0.999, HK_RANDOM_FROM=1, RCVD_IN_DNSWL_MED=-2.3,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

The issue that fixed by Patch 1 looks fatal though it doesn't appear on
KVM because KVM always searches with assending order and hit with the
correct cpuid leaf 0.

Patch 2 removes the wrong constraint on CPUID leaf 1f.

Patch 3 fix the build of CPUID leaf 7.

Changes in v3:
- collect Reviewed-by tags;
- rebase to latest master branch
  4a4efae44f19 ("Merge tag 'pull-hex-20240121' of https://github.com/quic/qemu into staging")

v2:
https://lore.kernel.org/qemu-devel/20230613131929.720453-1-xiaoyao.li@intel.com/
Changes in v2:
- Add Patch 3;
- rebase to latest master branch

v1:
https://lore.kernel.org/qemu-devel/20220712021249.3227256-1-xiaoyao.li@intel.com/


Xiaoyao Li (3):
  i386/cpuid: Decrease cpuid_i when skipping CPUID leaf 1F
  i386/cpuid: Remove subleaf constraint on CPUID leaf 1F
  i386/cpuid: Move leaf 7 to correct group

 target/i386/kvm/kvm.c | 7 ++-----
 1 file changed, 2 insertions(+), 5 deletions(-)

-- 
2.34.1


