Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1AE9AE7718B
	for <qemu-devel@archiver.kernel.org>; Thu, 19 Dec 2024 11:16:45 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tOEVl-0004YP-Qo; Thu, 19 Dec 2024 06:16:09 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <xiaoyao.li@intel.com>)
 id 1tOEVg-0004Wl-9G
 for qemu-devel@nongnu.org; Thu, 19 Dec 2024 06:16:05 -0500
Received: from mgamail.intel.com ([198.175.65.19])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <xiaoyao.li@intel.com>)
 id 1tOEVe-0005H9-Kv
 for qemu-devel@nongnu.org; Thu, 19 Dec 2024 06:16:03 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1734606963; x=1766142963;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=svD0Sz+s3Tirwo4k9cnsmvSDpD6Ex6DEuucB26NUaZ0=;
 b=arjpRb5Jx7ayt7p9uWKIHXOXyeJ8tfS+N64t/YhCDFVIUu1Fv+lYGrIE
 /7a5g/NOmwbPpxQ3604Wlj/7LD9IGW6wihTe7bdw3e44AiM+A07/LIVxd
 AR6HqcB9fVjGtGI1M1GBUE0MNGsgc636e5h7Hu8+M2Jr5BxQLzzbBCZAL
 iB59JmBQuAKNokxpTFncNjJa2fg2JGj4A4yDWSz1DJqj82yL9+6ekmgO5
 JcFurlyCZnuqk24JcMGkLLrsfcnDZkaeJTiTmD0H/lLiI4nwRM71an7ll
 xWiC62mWjL8Q1CWNdDmmZ9BL5TKuWfk5NslT1/N+PF6omcFU5yFbb8iSz w==;
X-CSE-ConnectionGUID: FHT1RwKOReSmGVsqqLY11g==
X-CSE-MsgGUID: iYvxkXv7TJGhH7ACG6sUFA==
X-IronPort-AV: E=McAfee;i="6700,10204,11290"; a="34994951"
X-IronPort-AV: E=Sophos;i="6.12,247,1728975600"; d="scan'208";a="34994951"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
 by orvoesa111.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 19 Dec 2024 03:16:03 -0800
X-CSE-ConnectionGUID: kIeCHDmXTQi5ge7VRhTtmQ==
X-CSE-MsgGUID: 0Rk3RJytTbu9GxgqpAfPnw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,247,1728975600"; d="scan'208";a="97956156"
Received: from lxy-clx-4s.sh.intel.com ([10.239.48.52])
 by fmviesa006.fm.intel.com with ESMTP; 19 Dec 2024 03:15:59 -0800
From: Xiaoyao Li <xiaoyao.li@intel.com>
To: Paolo Bonzini <pbonzini@redhat.com>, Igor Mammedov <imammedo@redhat.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Cc: qemu-devel@nongnu.org, Yanan Wang <wangyanan55@huawei.com>,
 Zhao Liu <zhao1.liu@intel.com>, "Michael S. Tsirkin" <mst@redhat.com>,
 Marcelo Tosatti <mtosatti@redhat.com>, xiaoyao.li@intel.com
Subject: [PATCH v2 04/10] i386/topology: Update the comment of
 x86_apicid_from_topo_ids()
Date: Thu, 19 Dec 2024 06:01:19 -0500
Message-Id: <20241219110125.1266461-5-xiaoyao.li@intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20241219110125.1266461-1-xiaoyao.li@intel.com>
References: <20241219110125.1266461-1-xiaoyao.li@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=198.175.65.19; envelope-from=xiaoyao.li@intel.com;
 helo=mgamail.intel.com
X-Spam_score_int: -33
X-Spam_score: -3.4
X-Spam_bar: ---
X-Spam_report: (-3.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 HK_RANDOM_ENVFROM=0.001, HK_RANDOM_FROM=0.998, RCVD_IN_DNSWL_MED=-2.3,
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

Update the comment of x86_apicid_from_topo_ids() to match the current
implementation,

Signed-off-by: Xiaoyao Li <xiaoyao.li@intel.com>
Reviewed-by: Zhao Liu <zhao1.liu@intel.com>
---
 include/hw/i386/topology.h | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/include/hw/i386/topology.h b/include/hw/i386/topology.h
index b2c8bf2de158..21b65219a5ca 100644
--- a/include/hw/i386/topology.h
+++ b/include/hw/i386/topology.h
@@ -121,9 +121,10 @@ static inline unsigned apicid_pkg_offset(X86CPUTopoInfo *topo_info)
 }
 
 /*
- * Make APIC ID for the CPU based on Pkg_ID, Core_ID, SMT_ID
+ * Make APIC ID for the CPU based on topology and IDs of each topology level.
  *
- * The caller must make sure core_id < nr_cores and smt_id < nr_threads.
+ * The caller must make sure the ID of each level doesn't exceed the width of
+ * the level.
  */
 static inline apic_id_t x86_apicid_from_topo_ids(X86CPUTopoInfo *topo_info,
                                                  const X86CPUTopoIDs *topo_ids)
-- 
2.34.1


