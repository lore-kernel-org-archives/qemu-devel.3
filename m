Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B492BC83F1A
	for <qemu-devel@archiver.kernel.org>; Mon, 14 Jul 2025 09:44:25 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ubFj7-0002uJ-9B; Mon, 14 Jul 2025 05:44:01 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <xiaoyao.li@intel.com>)
 id 1ubFTq-00013h-EQ
 for qemu-devel@nongnu.org; Mon, 14 Jul 2025 05:28:22 -0400
Received: from mgamail.intel.com ([192.198.163.10])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <xiaoyao.li@intel.com>)
 id 1ubFTl-0003Eh-0R
 for qemu-devel@nongnu.org; Mon, 14 Jul 2025 05:28:13 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1752485289; x=1784021289;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=FB0fZNdTYpwcn9/HGH9AHlXJ8al41jgEAb5jOqIWwek=;
 b=SDHntWmMfsoojmLcr9hO8jd4e3DFFz/kBsUCDRsX41IRW2az4+y2mUVF
 /pVIxX8N4JROko3wFWY6pHldBb144Sx+WIpAuQLrhjJlWWUl3YOuvnujC
 8k8X5MUfeU1LxZjUudpXmHplqT38afhBXmb4TYcnDAtJ7pWcgEmLbZBtt
 lA2Vu/kDimxWBZsW9Z7IYx716Pc/CAQgyJ18J22wkWXBo4/itw7MMY+38
 Dn63wqLuGJuSXn/aL9N2xzv0xL/gc6genj6tQhYS7f1rY4kYd4kz3txIz
 E/m6hQSSXJ0Lm3gIcb45jwvCnlMUyWTA33/YNMLhCPUhgPkynCTK/cUAb g==;
X-CSE-ConnectionGUID: tYYVb4HOQSC3xrfW9VnRAw==
X-CSE-MsgGUID: aE3IaogYTXmNvzlHX4b2Cw==
X-IronPort-AV: E=McAfee;i="6800,10657,11491"; a="66029286"
X-IronPort-AV: E=Sophos;i="6.16,310,1744095600"; d="scan'208";a="66029286"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
 by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 14 Jul 2025 02:28:05 -0700
X-CSE-ConnectionGUID: Nux5FFbGQUK2xF+uUmY9cw==
X-CSE-MsgGUID: uvtkfgdiT9m8qKVNzuyl6A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,310,1744095600"; d="scan'208";a="187882743"
Received: from lxy-clx-4s.sh.intel.com ([10.239.48.52])
 by orviesa002.jf.intel.com with ESMTP; 14 Jul 2025 02:28:04 -0700
From: Xiaoyao Li <xiaoyao.li@intel.com>
To: Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 =?UTF-8?q?Daniel=20P=20=2E=20Berrang=C3=A9?= <berrange@redhat.com>
Cc: qemu-devel@nongnu.org,
	Xiaoyao Li <xiaoyao.li@intel.com>
Subject: [PATCH 3/5] qemu-options: Change memory-encryption to
 confidential-guest-support in the example
Date: Mon, 14 Jul 2025 17:19:51 +0800
Message-ID: <20250714091953.448226-4-xiaoyao.li@intel.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250714091953.448226-1-xiaoyao.li@intel.com>
References: <20250714091953.448226-1-xiaoyao.li@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=192.198.163.10; envelope-from=xiaoyao.li@intel.com;
 helo=mgamail.intel.com
X-Spam_score_int: -33
X-Spam_score: -3.4
X-Spam_bar: ---
X-Spam_report: (-3.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 HK_RANDOM_ENVFROM=0.001, HK_RANDOM_FROM=0.999, RCVD_IN_DNSWL_MED=-2.3,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

"confidential-guest-support" is the recommended property instead of
"memory-encryption". Switch to "confidential-guest-support" in the
example of sev-guest.

Signed-off-by: Xiaoyao Li <xiaoyao.li@intel.com>
---
 qemu-options.hx | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/qemu-options.hx b/qemu-options.hx
index 740323f22bc2..27b7b79c6cad 100644
--- a/qemu-options.hx
+++ b/qemu-options.hx
@@ -5986,7 +5986,7 @@ SRST
              # |qemu_system_x86| \\
                  ...... \\
                  -object sev-guest,id=sev0,cbitpos=47,reduced-phys-bits=1 \\
-                 -machine ...,memory-encryption=sev0 \\
+                 -machine ...,confidential-guest-support=sev0 \\
                  .....
 
     ``-object authz-simple,id=id,identity=string``
-- 
2.43.0


