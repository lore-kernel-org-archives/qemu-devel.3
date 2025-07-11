Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4C8E7C8303C
	for <qemu-devel@archiver.kernel.org>; Fri, 11 Jul 2025 10:02:42 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uaAa2-0004R3-RT; Fri, 11 Jul 2025 06:02:11 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1uaAZ3-0002f0-C7
 for qemu-devel@nongnu.org; Fri, 11 Jul 2025 06:01:10 -0400
Received: from mgamail.intel.com ([198.175.65.17])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1uaAZ0-0005KY-ST
 for qemu-devel@nongnu.org; Fri, 11 Jul 2025 06:01:09 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1752228067; x=1783764067;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=m/3V6uk+n+NZ1SFoxeznqGZElzksyaiZeYkUPu8QMoI=;
 b=aqXQRifm26cE4HevO9r/fkVbIJ9SyNWPJ0nfn9NmT/MVTjsRD/atoiUU
 0PScU4lqQFZN/DUjKv5exq9PI/cigXlL9BWnSR71Jw/6BfGLP2OQsMsZ6
 edQAq/g74n7W6aD8hvyFGQzSTDumBCMEhpZVJOosrS9ECKVQbwJMxRVGZ
 5Hs7SiQ46kUd5YrZijqkcudHZmt+03sEZ7246rat131n9BPuM6lpddEWJ
 k/FMcjsPA8GIDoe1k3nBYvvjW57+ajZE9kMBHaNnMaKoEZFzuzSleBdeq
 d1wr+ruE/OQREs1I/+dUfbM54rhHNJb5HhpXN93KmJFl+QQFY0IxIxdM3 Q==;
X-CSE-ConnectionGUID: Bmhg+Hy6SQG/xI3glc7caw==
X-CSE-MsgGUID: hhzNCI7BQQOBALvs5LeP+Q==
X-IronPort-AV: E=McAfee;i="6800,10657,11490"; a="54496327"
X-IronPort-AV: E=Sophos;i="6.16,303,1744095600"; d="scan'208";a="54496327"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
 by orvoesa109.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 11 Jul 2025 03:01:05 -0700
X-CSE-ConnectionGUID: evhk2FJkTOS7fU+EyNZjgA==
X-CSE-MsgGUID: KyTMyk8lRNOLMW+rqHZ91A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,303,1744095600"; d="scan'208";a="160662069"
Received: from liuzhao-optiplex-7080.sh.intel.com ([10.239.160.39])
 by orviesa003.jf.intel.com with ESMTP; 11 Jul 2025 03:01:01 -0700
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
 qemu-devel@nongnu.org, kvm@vger.kernel.org, Zhao Liu <zhao1.liu@intel.com>
Subject: [PATCH v2 09/18] i386/cpu: Rename AMD_ENC_ASSOC to X86_ENC_ASSOC
Date: Fri, 11 Jul 2025 18:21:34 +0800
Message-Id: <20250711102143.1622339-10-zhao1.liu@intel.com>
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

Rename AMD_ENC_ASSOC to X86_ENC_ASSOC since Intel also uses the same
rules.

While there are some slight differences between the rules in AMD APM
v4.07 no.40332 and Intel. But considerring the needs of current QEMU,
generally they are consistent and current AMD_ENC_ASSOC can be applied
for Intel CPUs..

Tested-by: Yi Lai <yi1.lai@intel.com>
Signed-off-by: Zhao Liu <zhao1.liu@intel.com>
---
Changes Since v1:
 * Spilt this cleanup as a seperate patch.
---
 target/i386/cpu.c | 16 ++++++++--------
 1 file changed, 8 insertions(+), 8 deletions(-)

diff --git a/target/i386/cpu.c b/target/i386/cpu.c
index 6ab199c9a112..e0d5a39e477c 100644
--- a/target/i386/cpu.c
+++ b/target/i386/cpu.c
@@ -505,8 +505,8 @@ static uint32_t encode_cache_cpuid80000005(CPUCacheInfo *cache)
 
 #define ASSOC_FULL 0xFF
 
-/* AMD associativity encoding used on CPUID Leaf 0x80000006: */
-#define AMD_ENC_ASSOC(a) (a <=   1 ? a   : \
+/* x86 associativity encoding used on CPUID Leaf 0x80000006: */
+#define X86_ENC_ASSOC(a) (a <=   1 ? a   : \
                           a ==   2 ? 0x2 : \
                           a ==   4 ? 0x4 : \
                           a ==   8 ? 0x6 : \
@@ -532,7 +532,7 @@ static void encode_cache_cpuid80000006(CPUCacheInfo *l2,
     assert(l2->lines_per_tag > 0);
     assert(l2->line_size > 0);
     *ecx = ((l2->size / 1024) << 16) |
-           (AMD_ENC_ASSOC(l2->associativity) << 12) |
+           (X86_ENC_ASSOC(l2->associativity) << 12) |
            (l2->lines_per_tag << 8) | (l2->line_size);
 
     if (l3) {
@@ -541,7 +541,7 @@ static void encode_cache_cpuid80000006(CPUCacheInfo *l2,
         assert(l3->lines_per_tag > 0);
         assert(l3->line_size > 0);
         *edx = ((l3->size / (512 * 1024)) << 18) |
-               (AMD_ENC_ASSOC(l3->associativity) << 12) |
+               (X86_ENC_ASSOC(l3->associativity) << 12) |
                (l3->lines_per_tag << 8) | (l3->line_size);
     } else {
         *edx = 0;
@@ -7907,13 +7907,13 @@ void cpu_x86_cpuid(CPUX86State *env, uint32_t index, uint32_t count,
             x86_cpu_get_cache_cpuid(index, 0, eax, ebx, ecx, edx);
             break;
         }
-        *eax = (AMD_ENC_ASSOC(L2_DTLB_2M_ASSOC) << 28) |
+        *eax = (X86_ENC_ASSOC(L2_DTLB_2M_ASSOC) << 28) |
                (L2_DTLB_2M_ENTRIES << 16) |
-               (AMD_ENC_ASSOC(L2_ITLB_2M_ASSOC) << 12) |
+               (X86_ENC_ASSOC(L2_ITLB_2M_ASSOC) << 12) |
                (L2_ITLB_2M_ENTRIES);
-        *ebx = (AMD_ENC_ASSOC(L2_DTLB_4K_ASSOC) << 28) |
+        *ebx = (X86_ENC_ASSOC(L2_DTLB_4K_ASSOC) << 28) |
                (L2_DTLB_4K_ENTRIES << 16) |
-               (AMD_ENC_ASSOC(L2_ITLB_4K_ASSOC) << 12) |
+               (X86_ENC_ASSOC(L2_ITLB_4K_ASSOC) << 12) |
                (L2_ITLB_4K_ENTRIES);
         encode_cache_cpuid80000006(env->cache_info_amd.l2_cache,
                                    cpu->enable_l3_cache ?
-- 
2.34.1


