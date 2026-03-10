Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D1C00FD2D91
	for <qemu-devel@archiver.kernel.org>; Tue, 10 Mar 2026 13:43:38 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vzxM4-00074t-GD; Tue, 10 Mar 2026 09:42:36 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1vzxLv-0006zu-PF
 for qemu-devel@nongnu.org; Tue, 10 Mar 2026 09:42:28 -0400
Received: from mgamail.intel.com ([198.175.65.14])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1vzxLs-0003DW-4n
 for qemu-devel@nongnu.org; Tue, 10 Mar 2026 09:42:27 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1773150144; x=1804686144;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=F1OQS3PY94wOxpRKqt48XHCF9VcpDNaMAeV19dQvbPk=;
 b=T8tolifRphVC0sSlFhNLi0DnA4gbapM5YeGJrAUsIKKrsjDQMr1uu4Zf
 12OpsJurNqLCMtVzghoHA1HrtQ7w0/bE5Njjtyi7vDjvOJnW04ZZPvF0T
 vbyi6vi+msVKuWkCXDuJMzoWdCaBFID5EuAzBjYUwFL0kRHDzYzwp3Nup
 4nO7foRk/7le3wptCHzJa8WStzQBXtqbR38Ow8l6d4aHC0i3B3T5brN0V
 AsTCND24iITa45kcnKqH+lVQYkaB/oPNkGs88BLPUImLvcHJFVQqUq1q2
 4tUbeg4dRsD3Ism2uoiXrFFUnh2v5kWY2NF0ckaQ74eibP2cUzVUsvaxF g==;
X-CSE-ConnectionGUID: sQCG1UnCQj+TfqszzOYiHA==
X-CSE-MsgGUID: HIebVvIuSPenm5r73C9QiA==
X-IronPort-AV: E=McAfee;i="6800,10657,11725"; a="78048233"
X-IronPort-AV: E=Sophos;i="6.23,112,1770624000"; d="scan'208";a="78048233"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
 by orvoesa106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 10 Mar 2026 06:42:20 -0700
X-CSE-ConnectionGUID: T4VGanmVQ1Swh+cpIQBb2g==
X-CSE-MsgGUID: bZZU7lDNRp+bj5t/bSWisA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,112,1770624000"; d="scan'208";a="217647968"
Received: from liuzhao-optiplex-7080.sh.intel.com ([10.239.160.39])
 by fmviesa007.fm.intel.com with ESMTP; 10 Mar 2026 06:42:19 -0700
From: Zhao Liu <zhao1.liu@intel.com>
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: qemu-devel@nongnu.org,
	Zhao Liu <zhao1.liu@intel.com>
Subject: [PATCH 1/5] i386/cpu: Rename AMX mirror cpuid macros with _ALIAS
 suffix
Date: Tue, 10 Mar 2026 22:08:15 +0800
Message-Id: <20260310140819.1563084-2-zhao1.liu@intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260310140819.1563084-1-zhao1.liu@intel.com>
References: <20260310140819.1563084-1-zhao1.liu@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=198.175.65.14; envelope-from=zhao1.liu@intel.com;
 helo=mgamail.intel.com
X-Spam_score_int: -26
X-Spam_score: -2.7
X-Spam_bar: --
X-Spam_report: (-2.7 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.819,
 RCVD_IN_VALIDITY_SAFE_BLOCKED=0.903, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

For the similar case - CPUID_EXT2_AMD_ALIASES, the term "alias" has
already been used. Therefore, reintroducing the new term "mirror" is
likely to cause confusion.

Rename the relevant CPUID macros of AMX with _ALIAS suffix, aligning
with KVM's naming convention.

Signed-off-by: Zhao Liu <zhao1.liu@intel.com>
---
 target/i386/cpu.c |  6 +++---
 target/i386/cpu.h | 16 ++++++++--------
 2 files changed, 11 insertions(+), 11 deletions(-)

diff --git a/target/i386/cpu.c b/target/i386/cpu.c
index c77addd2c25a..953770db9c9a 100644
--- a/target/i386/cpu.c
+++ b/target/i386/cpu.c
@@ -5550,9 +5550,9 @@ static const X86CPUDefinition builtin_x86_defs[] = {
             CPUID_XSAVE_XSAVEOPT | CPUID_XSAVE_XSAVEC |
             CPUID_XSAVE_XGETBV1 | CPUID_XSAVE_XSAVES | CPUID_D_1_EAX_XFD,
         .features[FEAT_1E_1_EAX] =
-            CPUID_1E_1_EAX_AMX_INT8_MIRROR | CPUID_1E_1_EAX_AMX_BF16_MIRROR |
-            CPUID_1E_1_EAX_AMX_COMPLEX_MIRROR |
-            CPUID_1E_1_EAX_AMX_FP16_MIRROR | CPUID_1E_1_EAX_AMX_FP8 |
+            CPUID_1E_1_EAX_AMX_INT8_ALIAS | CPUID_1E_1_EAX_AMX_BF16_ALIAS |
+            CPUID_1E_1_EAX_AMX_COMPLEX_ALIAS |
+            CPUID_1E_1_EAX_AMX_FP16_ALIAS | CPUID_1E_1_EAX_AMX_FP8 |
             CPUID_1E_1_EAX_AMX_TF32 | CPUID_1E_1_EAX_AMX_AVX512 |
             CPUID_1E_1_EAX_AMX_MOVRS,
         .features[FEAT_29_0_EBX] = CPUID_29_0_EBX_APX_NCI_NDD_NF,
diff --git a/target/i386/cpu.h b/target/i386/cpu.h
index 2b70d56e9b03..a34c874839ad 100644
--- a/target/i386/cpu.h
+++ b/target/i386/cpu.h
@@ -1098,14 +1098,14 @@ uint64_t x86_cpu_get_supported_feature_word(X86CPU *cpu, FeatureWord w);
 /* Packets which contain IP payload have LIP values */
 #define CPUID_14_0_ECX_LIP              (1U << 31)
 
-/* AMX_INT8 instruction (mirror of CPUID_7_0_EDX_AMX_INT8) */
-#define CPUID_1E_1_EAX_AMX_INT8_MIRROR      (1U << 0)
-/* AMX_BF16 instruction (mirror of CPUID_7_0_EDX_AMX_BF16) */
-#define CPUID_1E_1_EAX_AMX_BF16_MIRROR      (1U << 1)
-/* AMX_COMPLEX instruction (mirror of CPUID_7_1_EDX_AMX_COMPLEX) */
-#define CPUID_1E_1_EAX_AMX_COMPLEX_MIRROR   (1U << 2)
-/* AMX_FP16 instruction (mirror of CPUID_7_1_EAX_AMX_FP16) */
-#define CPUID_1E_1_EAX_AMX_FP16_MIRROR      (1U << 3)
+/* AMX_INT8 instruction (alias of CPUID_7_0_EDX_AMX_INT8) */
+#define CPUID_1E_1_EAX_AMX_INT8_ALIAS      (1U << 0)
+/* AMX_BF16 instruction (alias of CPUID_7_0_EDX_AMX_BF16) */
+#define CPUID_1E_1_EAX_AMX_BF16_ALIAS      (1U << 1)
+/* AMX_COMPLEX instruction (alias of CPUID_7_1_EDX_AMX_COMPLEX) */
+#define CPUID_1E_1_EAX_AMX_COMPLEX_ALIAS   (1U << 2)
+/* AMX_FP16 instruction (alias of CPUID_7_1_EAX_AMX_FP16) */
+#define CPUID_1E_1_EAX_AMX_FP16_ALIAS      (1U << 3)
 /* AMX_FP8 instruction */
 #define CPUID_1E_1_EAX_AMX_FP8              (1U << 4)
 /* AMX_TF32 instruction */
-- 
2.34.1


