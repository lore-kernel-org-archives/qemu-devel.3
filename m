Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 29E01D41D74
	for <qemu-devel@archiver.kernel.org>; Mon, 15 Dec 2025 07:14:47 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vV2ly-0003I5-Jj; Mon, 15 Dec 2025 02:13:34 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1vV2lx-0003HY-EQ
 for qemu-devel@nongnu.org; Mon, 15 Dec 2025 02:13:33 -0500
Received: from mgamail.intel.com ([198.175.65.9])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1vV2lv-0008Ga-Pv
 for qemu-devel@nongnu.org; Mon, 15 Dec 2025 02:13:33 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1765782812; x=1797318812;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=qb/vshutsSrj3fhretVqp/6vsgjWlWps3KLTT4WJKLk=;
 b=NGLF2SdukdL6q1CpG7xoG/eoKcc7UDEhgAqnioc4rp7SEqr8XAQqaJl3
 H+e3fBnrzGpBkSrQcikif5VG+E7csZwcnlH/Cb1gklJmYBLWp+VZA4lzz
 ZmHgR+HAb4biabMl0at9uqhIh8Fwx0LP1sE/QLx0aLATXb67drYkQ2qnp
 bmmD+HfFCrovSWM/2vJqQGOMzR2dIZzYt4hyNO+qgxcXPF+ykAnZDJ0TF
 VBIsSkE9K0zpnwTIklyNsBhpCNrb1XhMILjSf+BevuITvxypfMyfxl9nF
 OGTZJ72NkdjZL/qGpSjy/XjQQAN0LX8PxKjFRSN/vOTIUVfEiFYXwISdy A==;
X-CSE-ConnectionGUID: lH1SqSGUTNGg5BjF/E8A+w==
X-CSE-MsgGUID: l1vEyTl3TSqB8cVJlAVCNQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11642"; a="90332267"
X-IronPort-AV: E=Sophos;i="6.21,150,1763452800"; d="scan'208";a="90332267"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
 by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 14 Dec 2025 23:13:20 -0800
X-CSE-ConnectionGUID: yJ6xNHsJQbqOyvE6rnALXg==
X-CSE-MsgGUID: 64KR+f/gQbCJ8sjR7kEaUA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,150,1763452800"; d="scan'208";a="197265982"
Received: from liuzhao-optiplex-7080.sh.intel.com ([10.239.160.39])
 by fmviesa007.fm.intel.com with ESMTP; 14 Dec 2025 23:13:18 -0800
From: Zhao Liu <zhao1.liu@intel.com>
To: Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Daniel=20P=20=2E=20Berrang=C3=A9?= <berrange@redhat.com>
Cc: qemu-devel@nongnu.org, Xudong Hao <xudong.hao@intel.com>,
 Zhao Liu <zhao1.liu@intel.com>, Yu Chen <yu.c.chen@intel.com>
Subject: [PATCH v2 11/11] dosc/cpu-models-x86: Add documentation for
 DiamondRapids
Date: Mon, 15 Dec 2025 15:37:43 +0800
Message-Id: <20251215073743.4055227-12-zhao1.liu@intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20251215073743.4055227-1-zhao1.liu@intel.com>
References: <20251215073743.4055227-1-zhao1.liu@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=198.175.65.9; envelope-from=zhao1.liu@intel.com;
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

Reviewed-by: Yu Chen <yu.c.chen@intel.com>
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
+                     smp-cache.3.cache=l3,smp-cache.3.topology=die
+
 ``ClearwaterForest``
     Intel Xeon Processor (ClearwaterForest, 2025)
 
-- 
2.34.1


