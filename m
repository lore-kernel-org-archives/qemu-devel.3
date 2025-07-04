Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 95C3EC83F03
	for <qemu-devel@archiver.kernel.org>; Fri,  4 Jul 2025 14:55:11 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uXhmX-0002Nn-PK; Fri, 04 Jul 2025 10:52:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <xiaoyao.li@intel.com>)
 id 1uXhmT-0001uz-JH
 for qemu-devel@nongnu.org; Fri, 04 Jul 2025 10:52:49 -0400
Received: from mgamail.intel.com ([192.198.163.11])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <xiaoyao.li@intel.com>)
 id 1uXhmP-0001bA-SY
 for qemu-devel@nongnu.org; Fri, 04 Jul 2025 10:52:49 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1751640766; x=1783176766;
 h=from:to:cc:subject:date:message-id:mime-version:
 content-transfer-encoding;
 bh=iqqgpTR765GsIEpfL6BRbX6sxm9V5oLqMlf/eUAmWzA=;
 b=LTvks3ZZmOqVbtD+Wej/8nli7rXDuuavdewkWM2JkxWkHo1S+ywiW1+t
 GMH/gs4jorWds/hPK9mrgI4TVBXd+ye1hJI0fIO658EKqnT5kNSHLEQVP
 BdqPLIbzSRqLTQQspUP/7iAbXHvr9hNmhj2GygNCpEQ2zttbZBti1OfYB
 Ul1g6yvA5dm6e4+Eu1NiF/c1DP0oke0khGef02qC4NsP196OtSEU+dYpt
 c4Dz2YeTMjXeFWZxzi7lgSqe9xAZGlAOD5ThEKCxaT7RPr9ZcZ66AwlGu
 lsSMpm3X+rqe/e05EULjc/cRD2Tje+GgS/TpVtrcYi6k+d1Yu+rDIl/jF g==;
X-CSE-ConnectionGUID: dYKSyPgsTR+/8n0DWVJC5A==
X-CSE-MsgGUID: U8AGobf2R52RLeYDlGizfQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11484"; a="64576071"
X-IronPort-AV: E=Sophos;i="6.16,287,1744095600"; d="scan'208";a="64576071"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
 by fmvoesa105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 04 Jul 2025 07:52:43 -0700
X-CSE-ConnectionGUID: yzU+YDRaQGOegLlQ0NeJsQ==
X-CSE-MsgGUID: xTjXYT+5SWSPs5WymSOLVQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,287,1744095600"; d="scan'208";a="185676903"
Received: from lxy-clx-4s.sh.intel.com ([10.239.48.52])
 by orviesa002.jf.intel.com with ESMTP; 04 Jul 2025 07:52:41 -0700
From: Xiaoyao Li <xiaoyao.li@intel.com>
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: qemu-devel@nongnu.org, Zhao Liu <zhao1.liu@intel.com>, tao1.su@intel.com,
 chenyi.qiang@intel.com, xiaoyao.li@intel.com
Subject: [PATCH] i386/cpu: Remove FEAT_24_0_EBX for AVX10
Date: Fri,  4 Jul 2025 22:45:04 +0800
Message-ID: <20250704144504.4094810-1-xiaoyao.li@intel.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=192.198.163.11; envelope-from=xiaoyao.li@intel.com;
 helo=mgamail.intel.com
X-Spam_score_int: -31
X-Spam_score: -3.2
X-Spam_bar: ---
X-Spam_report: (-3.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 HK_RANDOM_ENVFROM=0.001, HK_RANDOM_FROM=0.999, RCVD_IN_DNSWL_MED=-2.3,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.218, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
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

Intel AVX10 spec has been updated to make the bit 16-18 of
CPUID.24_0.EBX as reserved at 1 because all the Intel processors with
AVX10 support will support all the vector lengths.

The bits will be reserved at 1 to ensure the compatibility of the
existing software. For QEMU, it makes no sense to allow the
configurability of the bits anymore. So just remove the leaf
FEAT_24_0_EBX and related stuff and hardcore the bits to all 1 when
AVX10 is exposed to guest.

Signed-off-by: Xiaoyao Li <xiaoyao.li@intel.com>
---
 target/i386/cpu.c | 36 +-----------------------------------
 target/i386/cpu.h | 12 ------------
 2 files changed, 1 insertion(+), 47 deletions(-)

diff --git a/target/i386/cpu.c b/target/i386/cpu.c
index 0d35e95430fe..d0c4a3fa113c 100644
--- a/target/i386/cpu.c
+++ b/target/i386/cpu.c
@@ -912,7 +912,6 @@ void x86_cpu_vendor_words2str(char *dst, uint32_t vendor1,
 #define TCG_SGX_12_0_EAX_FEATURES 0
 #define TCG_SGX_12_0_EBX_FEATURES 0
 #define TCG_SGX_12_1_EAX_FEATURES 0
-#define TCG_24_0_EBX_FEATURES 0
 
 #if defined CONFIG_USER_ONLY
 #define CPUID_8000_0008_EBX_KERNEL_FEATURES (CPUID_8000_0008_EBX_IBPB | \
@@ -1208,20 +1207,6 @@ FeatureWordInfo feature_word_info[FEATURE_WORDS] = {
         },
         .tcg_features = TCG_7_2_EDX_FEATURES,
     },
-    [FEAT_24_0_EBX] = {
-        .type = CPUID_FEATURE_WORD,
-        .feat_names = {
-            [16] = "avx10-128",
-            [17] = "avx10-256",
-            [18] = "avx10-512",
-        },
-        .cpuid = {
-            .eax = 0x24,
-            .needs_ecx = true, .ecx = 0,
-            .reg = R_EBX,
-        },
-        .tcg_features = TCG_24_0_EBX_FEATURES,
-    },
     [FEAT_8000_0007_EDX] = {
         .type = CPUID_FEATURE_WORD,
         .feat_names = {
@@ -1839,22 +1824,6 @@ static FeatureDep feature_dependencies[] = {
         .from = { FEAT_7_0_EBX,             CPUID_7_0_EBX_SGX },
         .to = { FEAT_SGX_12_1_EAX,          ~0ull },
     },
-    {
-        .from = { FEAT_24_0_EBX,            CPUID_24_0_EBX_AVX10_128 },
-        .to = { FEAT_24_0_EBX,              CPUID_24_0_EBX_AVX10_256 },
-    },
-    {
-        .from = { FEAT_24_0_EBX,            CPUID_24_0_EBX_AVX10_256 },
-        .to = { FEAT_24_0_EBX,              CPUID_24_0_EBX_AVX10_512 },
-    },
-    {
-        .from = { FEAT_24_0_EBX,            CPUID_24_0_EBX_AVX10_VL_MASK },
-        .to = { FEAT_7_1_EDX,               CPUID_7_1_EDX_AVX10 },
-    },
-    {
-        .from = { FEAT_7_1_EDX,             CPUID_7_1_EDX_AVX10 },
-        .to = { FEAT_24_0_EBX,              ~0ull },
-    },
 };
 
 typedef struct X86RegisterInfo32 {
@@ -4732,9 +4701,6 @@ static const X86CPUDefinition builtin_x86_defs[] = {
                     { "movdiri", "on" },
                     { "movdir64b", "on" },
                     { "avx10", "on" },
-                    { "avx10-128", "on" },
-                    { "avx10-256", "on" },
-                    { "avx10-512", "on" },
                     { "avx10-version", "1" },
                     { "stepping", "1" },
                     { /* end of list */ }
@@ -7720,7 +7686,7 @@ void cpu_x86_cpuid(CPUX86State *env, uint32_t index, uint32_t count,
         *ecx = 0;
         *edx = 0;
         if ((env->features[FEAT_7_1_EDX] & CPUID_7_1_EDX_AVX10) && count == 0) {
-            *ebx = env->features[FEAT_24_0_EBX] | env->avx10_version;
+            *ebx = (0x7U << 16) | env->avx10_version;
         }
         break;
     }
diff --git a/target/i386/cpu.h b/target/i386/cpu.h
index 51e10139dfdf..7856a882f014 100644
--- a/target/i386/cpu.h
+++ b/target/i386/cpu.h
@@ -671,7 +671,6 @@ typedef enum FeatureWord {
     FEAT_7_1_ECX,       /* CPUID[EAX=7,ECX=1].ECX */
     FEAT_7_1_EDX,       /* CPUID[EAX=7,ECX=1].EDX */
     FEAT_7_2_EDX,       /* CPUID[EAX=7,ECX=2].EDX */
-    FEAT_24_0_EBX,      /* CPUID[EAX=0x24,ECX=0].EBX */
     FEATURE_WORDS,
 } FeatureWord;
 
@@ -1037,17 +1036,6 @@ uint64_t x86_cpu_get_supported_feature_word(X86CPU *cpu, FeatureWord w);
 /* Packets which contain IP payload have LIP values */
 #define CPUID_14_0_ECX_LIP              (1U << 31)
 
-/* AVX10 128-bit vector support is present */
-#define CPUID_24_0_EBX_AVX10_128        (1U << 16)
-/* AVX10 256-bit vector support is present */
-#define CPUID_24_0_EBX_AVX10_256        (1U << 17)
-/* AVX10 512-bit vector support is present */
-#define CPUID_24_0_EBX_AVX10_512        (1U << 18)
-/* AVX10 vector length support mask */
-#define CPUID_24_0_EBX_AVX10_VL_MASK    (CPUID_24_0_EBX_AVX10_128 | \
-                                         CPUID_24_0_EBX_AVX10_256 | \
-                                         CPUID_24_0_EBX_AVX10_512)
-
 /* RAS Features */
 #define CPUID_8000_0007_EBX_OVERFLOW_RECOV    (1U << 0)
 #define CPUID_8000_0007_EBX_SUCCOR      (1U << 1)
-- 
2.43.0


