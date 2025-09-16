Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3AC61CAC59A
	for <qemu-devel@archiver.kernel.org>; Tue, 16 Sep 2025 08:35:01 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uyR8z-0006aa-GN; Tue, 16 Sep 2025 04:34:35 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1uyR8q-0006RR-7f; Tue, 16 Sep 2025 04:34:25 -0400
Received: from mgamail.intel.com ([198.175.65.10])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1uyR8l-0005zx-Bp; Tue, 16 Sep 2025 04:34:23 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1758011659; x=1789547659;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=fFiQva2H+sKhH01fGDe/OdD0HBnTFMbT9bzsKhKkEaA=;
 b=ktc6c8ojwu734IYAfmZZZLGp10nU3H5YEUh1rsE2q1nWk2LAnqIfJNj8
 SeIEdPZP9MGQgsAYWXu+H0OyTiQrlb/MFG/R5nq4uccvMEOmr6ywUUqLs
 786MwsEZqHkGFd8WOE7/i/yErxj2QjVm1iTjzuRmoSSwha58K0yraxFjN
 b/K/3Sx+UfWJ0HKm+NiOHDbgHTYP0Jc0BOiVMJ7rv9TknMXoZsIGhjnAc
 iO49d7AB3z8GHaU3/+tilBihKtOzjgGPSY8QLokYEZyAfKw2RQq6R60o0
 IA4I80YPFIMUJvY8fOvrSINoKErvuOjWNyX9yVfddN/wJGjbWSj0xzaZQ Q==;
X-CSE-ConnectionGUID: cbMZ6IQ/Qza3z1EeNud1ww==
X-CSE-MsgGUID: 5gcz3rPlTGu103vJBPShtQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11554"; a="77725132"
X-IronPort-AV: E=Sophos;i="6.18,268,1751266800"; d="scan'208";a="77725132"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
 by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 16 Sep 2025 01:34:12 -0700
X-CSE-ConnectionGUID: Fco1SyDoQJy6oYrDFwSO7g==
X-CSE-MsgGUID: vHVACnGCT5qrXkKlUZr7IA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.18,268,1751266800"; d="scan'208";a="174691003"
Received: from liuzhao-optiplex-7080.sh.intel.com ([10.239.160.39])
 by orviesa007.jf.intel.com with ESMTP; 16 Sep 2025 01:34:10 -0700
From: Zhao Liu <zhao1.liu@intel.com>
To: Paolo Bonzini <pbonzini@redhat.com>,
 Manos Pitsidianakis <manos.pitsidianakis@linaro.org>
Cc: qemu-devel@nongnu.org, qemu-rust@nongnu.org, Zhao Liu <zhao1.liu@intel.com>
Subject: [PATCH 01/12] subprojects: Update .gitignore for proc-macro2 and syn
Date: Tue, 16 Sep 2025 16:55:46 +0800
Message-Id: <20250916085557.2008344-2-zhao1.liu@intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250916085557.2008344-1-zhao1.liu@intel.com>
References: <20250916085557.2008344-1-zhao1.liu@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=198.175.65.10; envelope-from=zhao1.liu@intel.com;
 helo=mgamail.intel.com
X-Spam_score_int: -43
X-Spam_score: -4.4
X-Spam_bar: ----
X-Spam_report: (-4.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.035,
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

Signed-off-by: Zhao Liu <zhao1.liu@intel.com>
---
 subprojects/.gitignore | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/subprojects/.gitignore b/subprojects/.gitignore
index f4281934ce11..9d579f72d121 100644
--- a/subprojects/.gitignore
+++ b/subprojects/.gitignore
@@ -16,7 +16,7 @@
 /libc-0.2.162
 /proc-macro-error-1.0.4
 /proc-macro-error-attr-1.0.4
-/proc-macro2-1.0.84
+/proc-macro2-1.0.95
 /quote-1.0.36
-/syn-2.0.66
+/syn-2.0.104
 /unicode-ident-1.0.12
-- 
2.34.1


