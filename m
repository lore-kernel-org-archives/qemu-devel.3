Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0F3EDCCD19A
	for <qemu-devel@archiver.kernel.org>; Tue, 18 Nov 2025 07:47:02 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vLGQF-00075P-Rw; Tue, 18 Nov 2025 02:46:45 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1vLGQ2-00073B-V4
 for qemu-devel@nongnu.org; Tue, 18 Nov 2025 02:46:31 -0500
Received: from mgamail.intel.com ([192.198.163.9])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1vLGQ0-0000vO-4h
 for qemu-devel@nongnu.org; Tue, 18 Nov 2025 02:46:30 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1763451988; x=1794987988;
 h=from:to:cc:subject:date:message-id:mime-version:
 content-transfer-encoding;
 bh=6/2w2AwFpQGUVmQ83FBjmY4hHNfJSkZp1lpHdlY1a2g=;
 b=RE4CEqpqrNwXvI/lIovpSiZjIvqj3hN6YtIT1zYK7pY6UruOh4aqpI4F
 dsUDn5nHIRa3vJKcB/PJvxTdVTLGl8scKYPpi4pu6VaWTQvU77U6mrE1t
 wWzjUVV99dz/1qtaFOsK8v7xBRetXbLrVy9wUy0KDGyOLDYjz2J2sq0t2
 Gny+1C0XhuSKhk8guAe3JHAP33C31dDuTb5tJn+VRqmyLVEz9hfn9iMk7
 sowQs/gZlt7HyGV7EAd0WboztKvatmOtWsCLoPjHIshN0aAT5lCV3Pl1y
 gteQf06PtUqMC1xBnzEfsb/SRNeoPmVvTeCtY7gLRUe2ijGqa4Y8ccGcL Q==;
X-CSE-ConnectionGUID: kS8t2FZlTg2V5P5nhoNV3Q==
X-CSE-MsgGUID: wV5OqxnKT+mXu2SLClcs4Q==
X-IronPort-AV: E=McAfee;i="6800,10657,11616"; a="76142117"
X-IronPort-AV: E=Sophos;i="6.19,314,1754982000"; d="scan'208";a="76142117"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
 by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 17 Nov 2025 23:46:24 -0800
X-CSE-ConnectionGUID: F4haXyNtTRu6W7EhgDchvA==
X-CSE-MsgGUID: sgsVFWsSQYGc6ti3dVqXjQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,314,1754982000"; d="scan'208";a="190479561"
Received: from liuzhao-optiplex-7080.sh.intel.com ([10.239.160.39])
 by fmviesa006.fm.intel.com with ESMTP; 17 Nov 2025 23:46:23 -0800
From: Zhao Liu <zhao1.liu@intel.com>
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: qemu-devel@nongnu.org,
	Zhao Liu <zhao1.liu@intel.com>
Subject: [PATCH 0/2] i386/cpu: Correct comments for CPUID 0x1D and 0x1E
Date: Tue, 18 Nov 2025 16:08:35 +0800
Message-Id: <20251118080837.837505-1-zhao1.liu@intel.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=192.198.163.9; envelope-from=zhao1.liu@intel.com;
 helo=mgamail.intel.com
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

Hi,

CPUID 0x1D and 0x1E are marked as hardcoded for Sapphire Rapids and
there's the previous attempt [*] to make the fields in 0x1D.0x1 and
0x1E.0x0.EBX user-configurable.

In fact, the "hardcoded" values are defined for architecture, not
the SPR-specific thing, so that it's incorrect and unnecessary to make
them user-configurable.

Therefore, drop the incorrect and misleading comments.

[*]: https://lore.kernel.org/qemu-devel/20230106083826.5384-2-lei4.wang@intel.com/

Thanks and Best Regards,
Zhao
---
Zhao Liu (2):
  i386/cpu: Drop incorrect comment for CPUID 0x1D
  i386/cpu: Drop incorrect comment for CPUID 0x1E

 target/i386/cpu.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

-- 
2.34.1


