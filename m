Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 31A1BCAC5A8
	for <qemu-devel@archiver.kernel.org>; Sat, 20 Sep 2025 15:45:38 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uzzkj-0007wy-4t; Sat, 20 Sep 2025 11:43:57 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1uzzkb-0007uJ-48; Sat, 20 Sep 2025 11:43:50 -0400
Received: from mgamail.intel.com ([198.175.65.11])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1uzzkY-0001zT-8d; Sat, 20 Sep 2025 11:43:48 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1758383027; x=1789919027;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=FiodBfQIWHUki8bQeGhImk08nFJr+3jgVXS0P5WVo3s=;
 b=lDahQF+1x00hdMBNle8vrOmCSHaIEmO43rl0HTFDKOOz5SiKtINXAs2h
 nfMvTSMO4Yhnw15Fz9UTZ+KXg6YkaTros8++dPzG69e6xG6aBSL9dTong
 3Vqudt3OewYPhKv5osTzSB+tcMdv09CxmTyTQfb+kAwzcKSRpBdRmDY9b
 NXvGSFaOv7vG0gEE+IXvUE9RBL8MfFF6zDwGtxCL21YwsLxu4rD3uwQPu
 HDeC3+yswjwV7hNDr9tFvz2UV1BtxIUn24yB/csehWGMPf/t+Pvq4/9X+
 vD0IAi7Ly03HT6EdYXIGY6kuawn03Aw1Y50rPceB7V1RmwwPh4PQ2ExHI Q==;
X-CSE-ConnectionGUID: kxSEbgx0T9inDMJfrmMynQ==
X-CSE-MsgGUID: MWjlggIVTlq541I/XuqKzA==
X-IronPort-AV: E=McAfee;i="6800,10657,11559"; a="70955491"
X-IronPort-AV: E=Sophos;i="6.18,281,1751266800"; d="scan'208";a="70955491"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
 by orvoesa103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 20 Sep 2025 08:43:41 -0700
X-CSE-ConnectionGUID: SMUMti+dQ36IuvJ9OWis1Q==
X-CSE-MsgGUID: WmqcS8HsT5uGBoEHhAJc2g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.18,281,1751266800"; d="scan'208";a="181349430"
Received: from liuzhao-optiplex-7080.sh.intel.com ([10.239.160.39])
 by fmviesa004.fm.intel.com with ESMTP; 20 Sep 2025 08:43:39 -0700
From: Zhao Liu <zhao1.liu@intel.com>
To: Paolo Bonzini <pbonzini@redhat.com>,
 Manos Pitsidianakis <manos.pitsidianakis@linaro.org>
Cc: qemu-devel@nongnu.org, qemu-rust@nongnu.org, Zhao Liu <zhao1.liu@intel.com>
Subject: [PATCH v2 01/12] subprojects: Update .gitignore for proc-macro2 and
 syn
Date: Sun, 21 Sep 2025 00:05:09 +0800
Message-Id: <20250920160520.3699591-2-zhao1.liu@intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250920160520.3699591-1-zhao1.liu@intel.com>
References: <20250920160520.3699591-1-zhao1.liu@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=198.175.65.11; envelope-from=zhao1.liu@intel.com;
 helo=mgamail.intel.com
X-Spam_score_int: -43
X-Spam_score: -4.4
X-Spam_bar: ----
X-Spam_report: (-4.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.045,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001, SPF_HELO_NONE=0.001,
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

Reviewed-by: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>
Signed-off-by: Zhao Liu <zhao1.liu@intel.com>
---
 subprojects/.gitignore | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/subprojects/.gitignore b/subprojects/.gitignore
index 4f2a489105e9..085de898d9d3 100644
--- a/subprojects/.gitignore
+++ b/subprojects/.gitignore
@@ -17,7 +17,7 @@
 /libc-0.2.162
 /proc-macro-error-1.0.4
 /proc-macro-error-attr-1.0.4
-/proc-macro2-1.0.84
+/proc-macro2-1.0.95
 /quote-1.0.36
 /serde-1.0.219
 /syn-2.0.104
-- 
2.34.1


