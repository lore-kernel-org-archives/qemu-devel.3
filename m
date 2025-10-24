Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4D846CCD1A5
	for <qemu-devel@archiver.kernel.org>; Fri, 24 Oct 2025 06:36:41 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vCBP7-0004oe-Vb; Fri, 24 Oct 2025 02:36:01 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1vCBP6-0004i9-1A
 for qemu-devel@nongnu.org; Fri, 24 Oct 2025 02:36:00 -0400
Received: from mgamail.intel.com ([198.175.65.20])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1vCBOz-00040O-GL
 for qemu-devel@nongnu.org; Fri, 24 Oct 2025 02:35:59 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1761287754; x=1792823754;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=iT6pGek/T2hADwOEBibyNy2m4pKMn1dzTaK0Ge2+9QU=;
 b=NxR0Pqn8w1h6tLx92cjEdy4vchpkNL9QKTLu/dcTojomDUM4QKU+jxnL
 Ri1TzMhypL51T2W/lB6X41YWqJNiLUZDlQ7cHntv6yejd+jTjW2BU9Nrz
 JtIaQK21EUVgZaUFRvA43cVgGAQM95Upw+YgpIEgvicfJmr/zc/CHNfOT
 KQhKPcEfPx0pZ/twBndq/i+2EvmAiBcTx6a0eqTaP/swB4oZ42p2lo4uH
 oD0Tiz5/3dWHRjqBw6B0L0gjUXqLCGO2NUhZR0m09T1R5hWOZhbwMDJK5
 z91ymof1HcDovebsB5BPMuOUum8CVG7ojAIW6HeNIRk4Yq3lbXm/6qjMq A==;
X-CSE-ConnectionGUID: 3IwqbuR8Qi2fGjle8ytxKQ==
X-CSE-MsgGUID: cT5meV6mTzit+JGnIBO6fw==
X-IronPort-AV: E=McAfee;i="6800,10657,11586"; a="63170937"
X-IronPort-AV: E=Sophos;i="6.19,251,1754982000"; d="scan'208";a="63170937"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
 by orvoesa112.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 23 Oct 2025 23:35:52 -0700
X-CSE-ConnectionGUID: 6/Du4PsrQKecWwQXOAn6HQ==
X-CSE-MsgGUID: 76V0wjcmSm6iWeeDdSD99g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,251,1754982000"; d="scan'208";a="184276158"
Received: from liuzhao-optiplex-7080.sh.intel.com ([10.239.160.39])
 by fmviesa006.fm.intel.com with ESMTP; 23 Oct 2025 23:35:48 -0700
From: Zhao Liu <zhao1.liu@intel.com>
To: Paolo Bonzini <pbonzini@redhat.com>, Marcelo Tosatti <mtosatti@redhat.com>
Cc: qemu-devel@nongnu.org, kvm@vger.kernel.org, Chao Gao <chao.gao@intel.com>,
 John Allen <john.allen@amd.com>, Babu Moger <babu.moger@amd.com>,
 Mathias Krause <minipli@grsecurity.net>, Dapeng Mi <dapeng1.mi@intel.com>,
 Zide Chen <zide.chen@intel.com>, Chenyi Qiang <chenyi.qiang@intel.com>,
 Xiaoyao Li <xiaoyao.li@intel.com>, Farrah Chen <farrah.chen@intel.com>,
 Zhao Liu <zhao1.liu@intel.com>
Subject: [PATCH v3 19/20] i386/tdx: Fix missing spaces in tdx_xfam_deps[]
Date: Fri, 24 Oct 2025 14:56:31 +0800
Message-Id: <20251024065632.1448606-20-zhao1.liu@intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20251024065632.1448606-1-zhao1.liu@intel.com>
References: <20251024065632.1448606-1-zhao1.liu@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=198.175.65.20; envelope-from=zhao1.liu@intel.com;
 helo=mgamail.intel.com
X-Spam_score_int: -43
X-Spam_score: -4.4
X-Spam_bar: ----
X-Spam_report: (-4.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 UPPERCASE_50_75=0.008 autolearn=ham autolearn_force=no
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

The checkpatch.pl always complains: "ERROR: space required after that
close brace '}'".

Fix this issue.

Tested-by: Farrah Chen <farrah.chen@intel.com>
Signed-off-by: Zhao Liu <zhao1.liu@intel.com>
---
 target/i386/kvm/tdx.c | 18 +++++++++---------
 1 file changed, 9 insertions(+), 9 deletions(-)

diff --git a/target/i386/kvm/tdx.c b/target/i386/kvm/tdx.c
index dbf0fa2c9180..a3444623657f 100644
--- a/target/i386/kvm/tdx.c
+++ b/target/i386/kvm/tdx.c
@@ -520,15 +520,15 @@ typedef struct TdxXFAMDep {
  * supported.
  */
 TdxXFAMDep tdx_xfam_deps[] = {
-    { XSTATE_YMM_BIT,       { FEAT_1_ECX, CPUID_EXT_FMA }},
-    { XSTATE_YMM_BIT,       { FEAT_7_0_EBX, CPUID_7_0_EBX_AVX2 }},
-    { XSTATE_OPMASK_BIT,    { FEAT_7_0_ECX, CPUID_7_0_ECX_AVX512_VBMI}},
-    { XSTATE_OPMASK_BIT,    { FEAT_7_0_EDX, CPUID_7_0_EDX_AVX512_FP16}},
-    { XSTATE_PT_BIT,        { FEAT_7_0_EBX, CPUID_7_0_EBX_INTEL_PT}},
-    { XSTATE_PKRU_BIT,      { FEAT_7_0_ECX, CPUID_7_0_ECX_PKU}},
-    { XSTATE_XTILE_CFG_BIT, { FEAT_7_0_EDX, CPUID_7_0_EDX_AMX_BF16 }},
-    { XSTATE_XTILE_CFG_BIT, { FEAT_7_0_EDX, CPUID_7_0_EDX_AMX_TILE }},
-    { XSTATE_XTILE_CFG_BIT, { FEAT_7_0_EDX, CPUID_7_0_EDX_AMX_INT8 }},
+    { XSTATE_YMM_BIT,       { FEAT_1_ECX, CPUID_EXT_FMA } },
+    { XSTATE_YMM_BIT,       { FEAT_7_0_EBX, CPUID_7_0_EBX_AVX2 } },
+    { XSTATE_OPMASK_BIT,    { FEAT_7_0_ECX, CPUID_7_0_ECX_AVX512_VBMI } },
+    { XSTATE_OPMASK_BIT,    { FEAT_7_0_EDX, CPUID_7_0_EDX_AVX512_FP16 } },
+    { XSTATE_PT_BIT,        { FEAT_7_0_EBX, CPUID_7_0_EBX_INTEL_PT } },
+    { XSTATE_PKRU_BIT,      { FEAT_7_0_ECX, CPUID_7_0_ECX_PKU } },
+    { XSTATE_XTILE_CFG_BIT, { FEAT_7_0_EDX, CPUID_7_0_EDX_AMX_BF16 } },
+    { XSTATE_XTILE_CFG_BIT, { FEAT_7_0_EDX, CPUID_7_0_EDX_AMX_TILE } },
+    { XSTATE_XTILE_CFG_BIT, { FEAT_7_0_EDX, CPUID_7_0_EDX_AMX_INT8 } },
 };
 
 static struct kvm_cpuid_entry2 *find_in_supported_entry(uint32_t function,
-- 
2.34.1


