Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 26E81CF8548
	for <qemu-devel@archiver.kernel.org>; Thu, 20 Nov 2025 06:50:17 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vLyTL-0005I7-Fo; Thu, 20 Nov 2025 01:48:52 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1vLyTA-0005Ce-0v
 for qemu-devel@nongnu.org; Thu, 20 Nov 2025 01:48:40 -0500
Received: from mgamail.intel.com ([192.198.163.17])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1vLyT7-0005r2-DJ
 for qemu-devel@nongnu.org; Thu, 20 Nov 2025 01:48:39 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1763621317; x=1795157317;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=2mnoY21GrNam+0buxwUbDCglrbwHVfUPGQtzxmbCKJw=;
 b=NGz6bIdaQvDJWKjbSJv/KZ9CUxvzQqtql8MPlL3rxLR+i2xDRYTLz8f1
 FJqqP0INA43h9yHBRjasVvznBVVgJnhsZiAbAf/ks5J4Tz46eb6oF/8T0
 fhPNtbXqeShlT2TLvCga7AfnxOjtV7Tb6OCaxl9TEqa94CrLHcm5QVpOf
 WUAwQFuXzRC0/HqV6GTv6sCOjuczTTTHPP1o9IwvQ0LF2LzQSbQ6NBWEe
 0JhBtUW84w3PPJXSijnVKvGbkMDEtx5XDcHOEosoH84JS65F2KEW0M0dH
 rYH0Rgtn+S0MfwuQpe4jh9+FaRFNgSIeLki+vixh5EkI/KmBUCcUq/Ym8 w==;
X-CSE-ConnectionGUID: 35JFZvOdSTKxUxqlZLF/Eg==
X-CSE-MsgGUID: io7hQp3uSXyWrP5RNePaCQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11618"; a="65572564"
X-IronPort-AV: E=Sophos;i="6.19,317,1754982000"; d="scan'208";a="65572564"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
 by fmvoesa111.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 19 Nov 2025 22:48:36 -0800
X-CSE-ConnectionGUID: EdNbSySyQlSlaXWbt20ezA==
X-CSE-MsgGUID: 63/I8cepS5OLnv2FAf9njg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,317,1754982000"; d="scan'208";a="191296143"
Received: from liuzhao-optiplex-7080.sh.intel.com ([10.239.160.39])
 by orviesa007.jf.intel.com with ESMTP; 19 Nov 2025 22:48:34 -0800
From: Zhao Liu <zhao1.liu@intel.com>
To: Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Daniel=20P=20=2E=20Berrang=C3=A9?= <berrange@redhat.com>
Cc: qemu-devel@nongnu.org, Xudong Hao <xudong.hao@intel.com>,
 Zhao Liu <zhao1.liu@intel.com>, Yu Chen <yu.c.chen@intel.com>
Subject: [PATCH 10/10] dosc/cpu-models-x86: Add documentation for DiamondRapids
Date: Thu, 20 Nov 2025 15:10:30 +0800
Message-Id: <20251120071030.961230-11-zhao1.liu@intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20251120071030.961230-1-zhao1.liu@intel.com>
References: <20251120071030.961230-1-zhao1.liu@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=192.198.163.17; envelope-from=zhao1.liu@intel.com;
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

Current DiamondRapids hasn't supported cache model. Instead, document
its special CPU & cache topology to allow user emulate with "-smp" &
"-machine smp-cache".

Cc: Yu Chen <yu.c.chen@intel.com>
Signed-off-by: Zhao Liu <zhao1.liu@intel.com>
---
 docs/system/cpu-models-x86.rst.inc | 20 ++++++++++++++++++++
 1 file changed, 20 insertions(+)

diff --git a/docs/system/cpu-models-x86.rst.inc b/docs/system/cpu-models-x86.rst.inc
index 6a770ca8351c..c4c8fc67a562 100644
--- a/docs/system/cpu-models-x86.rst.inc
+++ b/docs/system/cpu-models-x86.rst.inc
@@ -71,6 +71,26 @@ mixture of host CPU models between machines, if live migration
 compatibility is required, use the newest CPU model that is compatible
 across all desired hosts.
 
+``DiamondRapids``
+    Intel Xeon Processor.
+
+    Diamond Rapids product has a topology which differs from previous Xeon
+    products. It does not support SMT, but instead features a dual core
+    module (DCM) architecture. It also has core building blocks (CBB - die
+    level in CPU topology). The cache hierarchy is organized as follows:
+    L1 i/d cache is per thread, L2 cache is per DCM, and L3 cache is per
+    CBB. This cache topology can be emulated for DiamondRapids CPU model
+    using the smp-cache configuration as shown below:
+
+    Example:
+
+        ::
+
+            -machine smp-cache.0.cache=l1d,smp-cache.0.topology=thread,\
+                     smp-cache.1.cache=l1i,smp-cache.1.topology=thread,\
+                     smp-cache.2.cache=l2,smp-cache.2.topology=module,\
+                     smp-cache.3.cache=l3,smp-cache.3.topology=die\
+
 ``ClearwaterForest``
     Intel Xeon Processor (ClearwaterForest, 2025)
 
-- 
2.34.1


