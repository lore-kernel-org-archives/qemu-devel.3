Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 362F4C83F1D
	for <qemu-devel@archiver.kernel.org>; Fri, 11 Jul 2025 10:06:57 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uaAYt-0001v6-72; Fri, 11 Jul 2025 06:01:01 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1uaAYR-0001SK-AB
 for qemu-devel@nongnu.org; Fri, 11 Jul 2025 06:00:31 -0400
Received: from mgamail.intel.com ([198.175.65.17])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1uaAYO-0005FJ-5v
 for qemu-devel@nongnu.org; Fri, 11 Jul 2025 06:00:30 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1752228028; x=1783764028;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=Q8vxlSp8vNdf+rAvGc2M8Yga/kO4BDydluyykj+THNg=;
 b=Lb6Qx6YJvKLE08qqKHhJCwV8+TrzxiPbRXP97Itcjph7B9dLF15tio/0
 PLNCGFmqzn6vp0GG7YB87LNRVk9sfUTl9afWcZ4bUDIPLzw00F6Zit6IN
 lrg8FqfQm0jvKwAcOJrh9mbgKRjq01uWcBC7CxuAgDM7jFWVHw4oRTs4M
 WEKWfHBap5K8ZhyOVfq5vlpfUmdsq3PKcANwjDJ2J+FaW4/1RsO9OOSca
 r04tXaPTOOtwS3ap0mpbJ0DAJ/YxCJoJcgTRu6zzKAxlJi+q1PZe/O86k
 +0JHRUCV2x27bAgU0LP/VXQdhldUHWL7kdQPI7qR9Dk1yNDsxe4vgeyzJ Q==;
X-CSE-ConnectionGUID: h0YKNzBtREiIeFkzGKUqsg==
X-CSE-MsgGUID: eD6qA7BVTlGIr/bDjc4XTQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11490"; a="54496191"
X-IronPort-AV: E=Sophos;i="6.16,303,1744095600"; d="scan'208";a="54496191"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
 by orvoesa109.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 11 Jul 2025 03:00:26 -0700
X-CSE-ConnectionGUID: onw+2bYBQkuhQgZOe42X2w==
X-CSE-MsgGUID: KuWsCJSDR7WF/8+CEpZN8Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,303,1744095600"; d="scan'208";a="160662006"
Received: from liuzhao-optiplex-7080.sh.intel.com ([10.239.160.39])
 by orviesa003.jf.intel.com with ESMTP; 11 Jul 2025 03:00:21 -0700
From: Zhao Liu <zhao1.liu@intel.com>
To: Paolo Bonzini <pbonzini@redhat.com>, Marcelo Tosatti <mtosatti@redhat.com>,
 "Michael S . Tsirkin" <mst@redhat.com>,
 =?UTF-8?q?Daniel=20P=20=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Igor Mammedov <imammedo@redhat.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Eduardo Habkost <eduardo@habkost.net>
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Babu Moger <babu.moger@amd.com>, Ewan Hai <ewanhai-oc@zhaoxin.com>,
 Pu Wen <puwen@hygon.cn>, Tao Su <tao1.su@intel.com>,
 Yi Lai <yi1.lai@intel.com>, Dapeng Mi <dapeng1.mi@intel.com>,
 qemu-devel@nongnu.org, kvm@vger.kernel.org, Zhao Liu <zhao1.liu@intel.com>,
 Dapeng Mi <dapeng1.mi@linux.intel.com>
Subject: [PATCH v2 01/18] i386/cpu: Refine comment of CPUID2CacheDescriptorInfo
Date: Fri, 11 Jul 2025 18:21:26 +0800
Message-Id: <20250711102143.1622339-2-zhao1.liu@intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250711102143.1622339-1-zhao1.liu@intel.com>
References: <20250711102143.1622339-1-zhao1.liu@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=198.175.65.17; envelope-from=zhao1.liu@intel.com;
 helo=mgamail.intel.com
X-Spam_score_int: -43
X-Spam_score: -4.4
X-Spam_bar: ----
X-Spam_report: (-4.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
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

Refer to SDM vol.3 table 1-21, add the notes about the missing
descriptor, and fix the typo and comment format.

Reviewed-by: Dapeng Mi <dapeng1.mi@linux.intel.com>
Tested-by: Yi Lai <yi1.lai@intel.com>
Signed-off-by: Zhao Liu <zhao1.liu@intel.com>
---
Changes Since v1:
 * Fix the typo in comment. (Dapeng)
---
 target/i386/cpu.c | 31 ++++++++++++++++++++++---------
 1 file changed, 22 insertions(+), 9 deletions(-)

diff --git a/target/i386/cpu.c b/target/i386/cpu.c
index 0d35e95430fe..6983b5f70457 100644
--- a/target/i386/cpu.c
+++ b/target/i386/cpu.c
@@ -66,6 +66,7 @@ struct CPUID2CacheDescriptorInfo {
 
 /*
  * Known CPUID 2 cache descriptors.
+ * TLB, prefetch and sectored cache related descriptors are not included.
  * From Intel SDM Volume 2A, CPUID instruction
  */
 struct CPUID2CacheDescriptorInfo cpuid2_cache_descriptors[] = {
@@ -87,18 +88,29 @@ struct CPUID2CacheDescriptorInfo cpuid2_cache_descriptors[] = {
                .associativity = 2,  .line_size = 64, },
     [0x21] = { .level = 2, .type = UNIFIED_CACHE,     .size = 256 * KiB,
                .associativity = 8,  .line_size = 64, },
-    /* lines per sector is not supported cpuid2_cache_descriptor(),
-    * so descriptors 0x22, 0x23 are not included
-    */
+    /*
+     * lines per sector is not supported cpuid2_cache_descriptor(),
+     * so descriptors 0x22, 0x23 are not included
+     */
     [0x24] = { .level = 2, .type = UNIFIED_CACHE,     .size =   1 * MiB,
                .associativity = 16, .line_size = 64, },
-    /* lines per sector is not supported cpuid2_cache_descriptor(),
-    * so descriptors 0x25, 0x20 are not included
-    */
+    /*
+     * lines per sector is not supported cpuid2_cache_descriptor(),
+     * so descriptors 0x25, 0x29 are not included
+     */
     [0x2C] = { .level = 1, .type = DATA_CACHE,        .size =  32 * KiB,
                .associativity = 8,  .line_size = 64, },
     [0x30] = { .level = 1, .type = INSTRUCTION_CACHE, .size =  32 * KiB,
                .associativity = 8,  .line_size = 64, },
+    /*
+     * Newer Intel CPUs (having the cores without L3, e.g., Intel MTL, ARL)
+     * use CPUID 0x4 leaf to describe cache topology, by encoding CPUID 0x2
+     * leaf with 0xFF. For older CPUs (without 0x4 leaf), it's also valid
+     * to just ignore L3's code if there's no L3.
+     *
+     * This already covers all the cases in QEMU, so code 0x40 is not
+     * included.
+     */
     [0x41] = { .level = 2, .type = UNIFIED_CACHE,     .size = 128 * KiB,
                .associativity = 4,  .line_size = 32, },
     [0x42] = { .level = 2, .type = UNIFIED_CACHE,     .size = 256 * KiB,
@@ -136,9 +148,10 @@ struct CPUID2CacheDescriptorInfo cpuid2_cache_descriptors[] = {
                .associativity = 4,  .line_size = 64, },
     [0x78] = { .level = 2, .type = UNIFIED_CACHE,     .size =   1 * MiB,
                .associativity = 4,  .line_size = 64, },
-    /* lines per sector is not supported cpuid2_cache_descriptor(),
-    * so descriptors 0x79, 0x7A, 0x7B, 0x7C are not included.
-    */
+    /*
+     * lines per sector is not supported cpuid2_cache_descriptor(),
+     * so descriptors 0x79, 0x7A, 0x7B, 0x7C are not included.
+     */
     [0x7D] = { .level = 2, .type = UNIFIED_CACHE,     .size =   2 * MiB,
                .associativity = 8,  .line_size = 64, },
     [0x7F] = { .level = 2, .type = UNIFIED_CACHE,     .size = 512 * KiB,
-- 
2.34.1


