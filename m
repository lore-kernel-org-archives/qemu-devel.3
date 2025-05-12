Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ABE71C3ABC3
	for <qemu-devel@archiver.kernel.org>; Mon, 12 May 2025 17:27:28 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uEWvQ-0006ad-Sr; Mon, 12 May 2025 13:26:49 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pawan.kumar.gupta@linux.intel.com>)
 id 1uEWvF-0006Rb-1l
 for qemu-devel@nongnu.org; Mon, 12 May 2025 13:26:40 -0400
Received: from mgamail.intel.com ([198.175.65.13])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pawan.kumar.gupta@linux.intel.com>)
 id 1uEWvC-0003rv-Fg
 for qemu-devel@nongnu.org; Mon, 12 May 2025 13:26:36 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1747070794; x=1778606794;
 h=date:from:to:cc:subject:message-id:mime-version;
 bh=JM9m8m9IoKVRfmW+OOBZpgOU7fi7ucvcJfL/s75wI0M=;
 b=Ce4MJHM6oWGxUBEm5SABMjWrArP7CyOOYUHUfDO7xYmr6Ml9z19Vnxl3
 ZJK4gulXUXuTJsqhApETqvHuXL7A055wYZvEOq28ZtXiMtRY9tfQMA+Jk
 WvkAkm/UsUP78V7mB40kxoFgQYCPq3HyM5GEpOXNvTSQUGiC+AE/aItFJ
 ewvc1qeiB++7gnp1VWBZGNLDoF11dSb/TqLnJRuis7+vESbPrPJ/SoKda
 72bYBV5fqFfxZ8vtmJw9Hmyh5TJp2SLLfJRZHquOy34Oj1fgZzoNEbpEy
 N+V6wQA7dLUMqFpZc242kL5D+TIuyVEplHeo4b82ir0QmZtGXUYKec6u1 g==;
X-CSE-ConnectionGUID: ha21Z1HfRCC9AB4/s/BKvA==
X-CSE-MsgGUID: 9oac1RwKR9elQj5PTel6aw==
X-IronPort-AV: E=McAfee;i="6700,10204,11431"; a="59885376"
X-IronPort-AV: E=Sophos;i="6.15,282,1739865600"; d="scan'208";a="59885376"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
 by orvoesa105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 12 May 2025 10:26:29 -0700
X-CSE-ConnectionGUID: Y9lxdFEwQpS5XAYuBiFh6A==
X-CSE-MsgGUID: mfQuUr/gSUmRCsaTIpCgkg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,282,1739865600"; d="scan'208";a="138374819"
Received: from lvelazqu-mobl.amr.corp.intel.com (HELO desk) ([10.125.146.9])
 by orviesa008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 12 May 2025 10:26:29 -0700
Date: Mon, 12 May 2025 10:26:04 -0700
From: Pawan Gupta <pawan.kumar.gupta@linux.intel.com>
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: qemu-devel@nongnu.org, Chao Gao <chao.gao@intel.com>
Subject: [PATCH] target/i386: Make ITS_NO available to guests
Message-ID: <8c1797e488b42650f62d816f25c58726eb522fad.1745946029.git.pawan.kumar.gupta@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Received-SPF: none client-ip=198.175.65.13;
 envelope-from=pawan.kumar.gupta@linux.intel.com; helo=mgamail.intel.com
X-Spam_score_int: -38
X-Spam_score: -3.9
X-Spam_bar: ---
X-Spam_report: (-3.9 / 5.0 requ) AC_FROM_MANY_DOTS=1.959, BAYES_00=-1.9,
 DKIMWL_WL_HIGH=-1.551, DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, SPF_HELO_NONE=0.001,
 SPF_NONE=0.001 autolearn=ham autolearn_force=no
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

When a system is not affected by Indirect Target Selection (ITS)
vulnerability, VMMs set ITS_NO bit in MSR IA32_ARCH_CAPABILITIES to let the
guest know that it is not affected.

Make it available to guests.

Signed-off-by: Pawan Gupta <pawan.kumar.gupta@linux.intel.com>
---
 target/i386/cpu.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/target/i386/cpu.c b/target/i386/cpu.c
index 1b64ceaaba46..89807ee1aace 100644
--- a/target/i386/cpu.c
+++ b/target/i386/cpu.c
@@ -1370,6 +1370,14 @@ FeatureWordInfo feature_word_info[FEATURE_WORDS] = {
             "bhi-no", NULL, NULL, NULL,
             "pbrsb-no", NULL, "gds-no", "rfds-no",
             "rfds-clear", NULL, NULL, NULL,
+            NULL, NULL, NULL, NULL,
+            NULL, NULL, NULL, NULL,
+            NULL, NULL, NULL, NULL,
+            NULL, NULL, NULL, NULL,
+            NULL, NULL, NULL, NULL,
+            NULL, NULL, NULL, NULL,
+            NULL, NULL, NULL, NULL,
+            NULL, NULL, "its-no", NULL,
         },
         .msr = {
             .index = MSR_IA32_ARCH_CAPABILITIES,

base-commit: 56c6e249b6988c1b6edc2dd34ebb0f1e570a1365
-- 
2.34.1


