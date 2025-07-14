Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 34F34C83F1B
	for <qemu-devel@archiver.kernel.org>; Mon, 14 Jul 2025 09:37:06 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ubFc4-0005QY-J1; Mon, 14 Jul 2025 05:36:46 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <xiaoyao.li@intel.com>)
 id 1ubFTk-00012T-Bw
 for qemu-devel@nongnu.org; Mon, 14 Jul 2025 05:28:16 -0400
Received: from mgamail.intel.com ([192.198.163.10])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <xiaoyao.li@intel.com>)
 id 1ubFTi-0003Dn-GN
 for qemu-devel@nongnu.org; Mon, 14 Jul 2025 05:28:08 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1752485286; x=1784021286;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=ZMxbMTL6bAWxmAOXFXy6V/3TWlJVejOwkxqLEDzE1sI=;
 b=IEbjppsWpt+e3dqSBIAXjgQ+Rx6Q/t3CuOopXNKzwW3+WIlvvgH+TvKk
 KQUIjzzQtZnamI9WzOJE85KXgUwof/IHyC4VfKrKIUQx/5QsgKu04+b9J
 b8b8DwYggnU0JcoFDnKBa8XeOmBpTZglTLehbYACwu78av3ntTtGYmDqJ
 fn1GXMSbj2HtFbVx/0fWPlK6l5Q4+iPyIoDRVECTV0UPIdwB1/iiluMhc
 Z8CnaCbt3070bF38UdN7LyszdSzLcjebLB8QxsVhm+zINQF4DnxPm6GRi
 hkBKVMGRxHtPu6BRo2OxcE4lpGbhCGfkrIhTYR7eY9F0Z2KWxGUKWH3fB g==;
X-CSE-ConnectionGUID: Ke0/pcISTci9XuxU5a/GPA==
X-CSE-MsgGUID: l223o21qTueC1tSyHsjmuw==
X-IronPort-AV: E=McAfee;i="6800,10657,11491"; a="66029273"
X-IronPort-AV: E=Sophos;i="6.16,310,1744095600"; d="scan'208";a="66029273"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
 by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 14 Jul 2025 02:28:03 -0700
X-CSE-ConnectionGUID: kO1cpXzjQ0WNebkH7jYOGA==
X-CSE-MsgGUID: 9pOi4A94S/+1CJGBMvpreA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,310,1744095600"; d="scan'208";a="187882736"
Received: from lxy-clx-4s.sh.intel.com ([10.239.48.52])
 by orviesa002.jf.intel.com with ESMTP; 14 Jul 2025 02:28:02 -0700
From: Xiaoyao Li <xiaoyao.li@intel.com>
To: Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 =?UTF-8?q?Daniel=20P=20=2E=20Berrang=C3=A9?= <berrange@redhat.com>
Cc: qemu-devel@nongnu.org,
	Xiaoyao Li <xiaoyao.li@intel.com>
Subject: [PATCH 2/5] i386/sev: Remove the example that references
 memory-encryption
Date: Mon, 14 Jul 2025 17:19:50 +0800
Message-ID: <20250714091953.448226-3-xiaoyao.li@intel.com>
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

"confidential-guest-support" is the recommended property to configure
sev for the machine, and amd-memory-encryption.rst has already switched
to use "confidential-guest-support" in the example.

Instead of changing "memory-encryption" to "confidential-guest-support"
in the comment of struct SevGuestState, just drop the example for
simplicity.

Signed-off-by: Xiaoyao Li <xiaoyao.li@intel.com>
---
 target/i386/sev.c | 4 ----
 1 file changed, 4 deletions(-)

diff --git a/target/i386/sev.c b/target/i386/sev.c
index 1a12f0671cc6..b1831e9ab14e 100644
--- a/target/i386/sev.c
+++ b/target/i386/sev.c
@@ -131,10 +131,6 @@ struct SevCommonStateClass {
  *
  * The SevGuestState object is used for creating and managing a SEV
  * guest.
- *
- * # $QEMU \
- *         -object sev-guest,id=sev0 \
- *         -machine ...,memory-encryption=sev0
  */
 struct SevGuestState {
     SevCommonState parent_obj;
-- 
2.43.0


