Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8CBF9C5AD49
	for <qemu-devel@archiver.kernel.org>; Tue,  3 Jun 2025 05:13:20 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uMJx9-0006ub-F7; Tue, 03 Jun 2025 01:12:47 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <xiaoyao.li@intel.com>)
 id 1uMJx5-0006tS-IP
 for qemu-devel@nongnu.org; Tue, 03 Jun 2025 01:12:43 -0400
Received: from mgamail.intel.com ([198.175.65.13])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <xiaoyao.li@intel.com>)
 id 1uMJx4-0003OJ-1o
 for qemu-devel@nongnu.org; Tue, 03 Jun 2025 01:12:43 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1748927562; x=1780463562;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=/o9QMCkvz+rS2wSdoCiqmfI/zo6XBVkcN10+Q9PmT0A=;
 b=Wts/mP7weakuQDz/y3W8PN8uApqM1FmuA28sCQwTEoy7n2qdM+FQz3wP
 oCSftYD8nK97IIQas5ZGcZpgnwIzJ5o1AHDh411RsYxIR2QzXgpByyP9g
 Fqvd5i116DMdw5RJZZhCJOgoJmou5VSgd9+H+e9tx4XZb9bAoNaFKp/8p
 GaEdYXxzN5oMD6UmE9YAUPZbe1wgA4MO3i6I5Uv3WIMxndd8qcc9cwRdl
 k1Wq8YtjyStyW7UBBCg1aUa7kEoNLBN+9w8NzynA+ufUt/5pgRzwMwpuc
 otAdCn7M7BVmFPD0uOE1ToSyRxGjGOI/wVLMbWlNFLEaqsptNbBxZzuUh Q==;
X-CSE-ConnectionGUID: zCdTELykRTWXF072FonCUg==
X-CSE-MsgGUID: M1j5h+94R9iQFdvzlTZWfg==
X-IronPort-AV: E=McAfee;i="6700,10204,11451"; a="62007527"
X-IronPort-AV: E=Sophos;i="6.16,205,1744095600"; d="scan'208";a="62007527"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
 by orvoesa105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 02 Jun 2025 22:09:13 -0700
X-CSE-ConnectionGUID: +zKWB90qQoeMrDvsK2ulcA==
X-CSE-MsgGUID: u60MaGTkTt+QBCB9JYHUmg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,205,1744095600"; d="scan'208";a="175700647"
Received: from lxy-clx-4s.sh.intel.com ([10.239.48.52])
 by orviesa002.jf.intel.com with ESMTP; 02 Jun 2025 22:09:11 -0700
From: Xiaoyao Li <xiaoyao.li@intel.com>
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: Igor Mammedov <imammedo@redhat.com>,
 =?UTF-8?q?Daniel=20P=20=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Xiaoyao Li <xiaoyao.li@intel.com>, qemu-devel@nongnu.org
Subject: [PATCH 2/3] i386/tdx: Fix the typo of the comment of struct TdxGuest
Date: Tue,  3 Jun 2025 01:03:04 -0400
Message-ID: <20250603050305.1704586-3-xiaoyao.li@intel.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250603050305.1704586-1-xiaoyao.li@intel.com>
References: <20250603050305.1704586-1-xiaoyao.li@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=198.175.65.13; envelope-from=xiaoyao.li@intel.com;
 helo=mgamail.intel.com
X-Spam_score_int: -33
X-Spam_score: -3.4
X-Spam_bar: ---
X-Spam_report: (-3.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.015,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 HK_RANDOM_ENVFROM=0.001, HK_RANDOM_FROM=0.999, RCVD_IN_DNSWL_MED=-2.3,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
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

Change sha348 to sha384.

Signed-off-by: Xiaoyao Li <xiaoyao.li@intel.com>
---
 target/i386/kvm/tdx.h | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/target/i386/kvm/tdx.h b/target/i386/kvm/tdx.h
index 04b5afe199f9..8dd66e90149b 100644
--- a/target/i386/kvm/tdx.h
+++ b/target/i386/kvm/tdx.h
@@ -40,9 +40,9 @@ typedef struct TdxGuest {
     bool initialized;
     uint64_t attributes;    /* TD attributes */
     uint64_t xfam;
-    char *mrconfigid;       /* base64 encoded sha348 digest */
-    char *mrowner;          /* base64 encoded sha348 digest */
-    char *mrownerconfig;    /* base64 encoded sha348 digest */
+    char *mrconfigid;       /* base64 encoded sha384 digest */
+    char *mrowner;          /* base64 encoded sha384 digest */
+    char *mrownerconfig;    /* base64 encoded sha384 digest */
 
     MemoryRegion *tdvf_mr;
     TdxFirmware tdvf;
-- 
2.43.0


