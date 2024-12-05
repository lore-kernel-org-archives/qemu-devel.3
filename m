Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 54E37E7716D
	for <qemu-devel@archiver.kernel.org>; Thu,  5 Dec 2024 15:12:18 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tJDVa-0005eq-Cg; Thu, 05 Dec 2024 10:11:14 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <xiaoyao.li@intel.com>)
 id 1tJDVV-0005dZ-Mv
 for qemu-devel@nongnu.org; Thu, 05 Dec 2024 10:11:09 -0500
Received: from mgamail.intel.com ([198.175.65.17])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <xiaoyao.li@intel.com>)
 id 1tJDVS-0005Mo-U4
 for qemu-devel@nongnu.org; Thu, 05 Dec 2024 10:11:09 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1733411466; x=1764947466;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=GUBrBUKmlcn1uCOimksccYgJWdP9dfdcg1bwUYf7oLc=;
 b=jAnr2QZgAQUWJKW1IUqmbf1aXUa40N0tetLxuSobi73nc9GbHBG6dwx5
 F/ctmAXeMW8a+/pkakvmsrKdG17OKiKuxWQbz1g2pXjzuazMuLL/H3dtx
 FXONY/VLTKueG7sonanlErNXi3xqbghezQI6Y2BjlsHQUfnAqqd9zHdTs
 foFeza+gTGyuSDWPjQcABCoHvob8XclvpzbwsnLXESqje7M0JXQWNwV70
 8Az2sO9G/hiulrY/49lfqUL5zSR06ut5ve8Yc2MA625+WtAItQS9o9Hbp
 Wi3+FEoid0YKNGfMXN2W6w+L7kQn/CLnWVnNMHSq6aUnsTWYCMB/WPjp2 g==;
X-CSE-ConnectionGUID: nbGhWy1XQUqb91uRQm4zRA==
X-CSE-MsgGUID: I1ckS2g5Rkqdzv0SOosf+Q==
X-IronPort-AV: E=McAfee;i="6700,10204,11277"; a="33786126"
X-IronPort-AV: E=Sophos;i="6.12,210,1728975600"; d="scan'208";a="33786126"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
 by orvoesa109.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 05 Dec 2024 07:11:04 -0800
X-CSE-ConnectionGUID: S9bMI51cSfSWfYNuVUtibg==
X-CSE-MsgGUID: 7S7DjVzSQSOphBJZ8MVHmw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,210,1728975600"; d="scan'208";a="93803087"
Received: from lxy-clx-4s.sh.intel.com ([10.239.48.52])
 by fmviesa006.fm.intel.com with ESMTP; 05 Dec 2024 07:11:01 -0800
From: Xiaoyao Li <xiaoyao.li@intel.com>
To: Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Igor Mammedov <imammedo@redhat.com>
Cc: xiaoyao.li@intel.com, Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Yanan Wang <wangyanan55@huawei.com>, Zhao Liu <zhao1.liu@intel.com>,
 "Michael S. Tsirkin" <mst@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Cameron Esfahani <dirty@apple.com>, Roman Bolshakov <rbolshakov@ddn.com>,
 Marcelo Tosatti <mtosatti@redhat.com>, qemu-devel@nongnu.org
Subject: [RFC PATCH 1/4] i386/topology: Update the comment of
 x86_apicid_from_topo_ids()
Date: Thu,  5 Dec 2024 09:57:13 -0500
Message-Id: <20241205145716.472456-2-xiaoyao.li@intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20241205145716.472456-1-xiaoyao.li@intel.com>
References: <20241205145716.472456-1-xiaoyao.li@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=198.175.65.17; envelope-from=xiaoyao.li@intel.com;
 helo=mgamail.intel.com
X-Spam_score_int: -65
X-Spam_score: -6.6
X-Spam_bar: ------
X-Spam_report: (-6.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-2.996,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 HK_RANDOM_ENVFROM=0.001, HK_RANDOM_FROM=0.822, RCVD_IN_DNSWL_MED=-2.3,
 RCVD_IN_MSPIKE_H2=-0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
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

Update the comment of x86_apicid_from_topo_ids() to match the current
implementation,

Signed-off-by: Xiaoyao Li <xiaoyao.li@intel.com>
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


