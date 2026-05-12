Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5F189CD4855
	for <qemu-devel@archiver.kernel.org>; Tue, 12 May 2026 08:35:14 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wMiZO-00024W-QU; Tue, 12 May 2026 04:34:26 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <xiaoyao.li@intel.com>)
 id 1wMiZN-00023t-3a
 for qemu-devel@nongnu.org; Tue, 12 May 2026 04:34:25 -0400
Received: from mgamail.intel.com ([192.198.163.11])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <xiaoyao.li@intel.com>)
 id 1wMiZK-000055-7J
 for qemu-devel@nongnu.org; Tue, 12 May 2026 04:34:24 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1778574862; x=1810110862;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=T262GeUkgJ9n1t/2mqAHvvUTp3s6sBxxPF2cFuudCeU=;
 b=YTrY/xjwwIqHg+G7td8ij0REOfN03k/TAa8thPEacjTS34pXzqokvbe9
 pP8qGL198PqydwRIodlVQW8nPNRkQIqjugbHAsXsyKmsaub9PyyOJro77
 a29UvpHVjergYHQUOYdUzyGgK9nawwQlBIiED5xAorkm9nTXT0e4MKkky
 OP1pbR79jWHS/0Ra6zxC2RNIrlpYWoIry6gennsuz+vI4jymNXWjvywq2
 fl7nDg8uhDzzshuhvCo1aoyU5lXUFkKh7qKRWiZ+7LfaAJvd9hG6N9xtJ
 dA0LdjM4/usYjKePNTuMqu3mBL+FGqUCRtrvTClI9WCCvsGXtuvMpq1Np w==;
X-CSE-ConnectionGUID: C3HalHuXTtSNM0cHqb9OLQ==
X-CSE-MsgGUID: fawhNhGQRgGsCMU7tKzi7w==
X-IronPort-AV: E=McAfee;i="6800,10657,11783"; a="90060007"
X-IronPort-AV: E=Sophos;i="6.23,230,1770624000"; d="scan'208";a="90060007"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
 by fmvoesa105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 12 May 2026 01:34:19 -0700
X-CSE-ConnectionGUID: 1GtA795FSLmt63R32VOrVA==
X-CSE-MsgGUID: pETO5cfbRKmC3ga1VaFhNg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,230,1770624000"; d="scan'208";a="237947190"
Received: from lxy-clx-4s.sh.intel.com ([10.239.48.22])
 by orviesa007.jf.intel.com with ESMTP; 12 May 2026 01:34:16 -0700
From: Xiaoyao Li <xiaoyao.li@intel.com>
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: qemu-devel@nongnu.org,
 =?UTF-8?q?Daniel=20P=20=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Chenyi Qiang <chenyi.qiang@intel.com>, xiaoyao.li@intel.com
Subject: [PATCH 3/3] i386/tdx: Add CPUID_24_0_EBX_AVX10_VL_MASK as supported
Date: Tue, 12 May 2026 16:21:08 +0800
Message-ID: <20260512082108.621596-4-xiaoyao.li@intel.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260512082108.621596-1-xiaoyao.li@intel.com>
References: <20260512082108.621596-1-xiaoyao.li@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=192.198.163.11; envelope-from=xiaoyao.li@intel.com;
 helo=mgamail.intel.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.445,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 HK_RANDOM_ENVFROM=0.999, HK_RANDOM_FROM=0.999, RCVD_IN_DNSWL_MED=-2.3,
 SPF_HELO_NONE=0.001, SPF_NONE=0.001 autolearn=ham autolearn_force=no
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

AVX10 depends on CPUID_24_0_EBX_AVX10_VL_MASK as defined in
feature_dependencies[]. Currently CPUID_24_0_EBX_AVX10_VL_MASK is always
not supported for TDX, so AVX10 cannot be exposed to TD guest.

The TDX virtualization type of these bits is "XFAM & CPUID_Enabled &
Native": their value is determined by XFAM[5:7], the AVX10 CPUID bit,
and the native hardware value.

For simplicity, add CPUID_24_0_EBX_AVX10_VL_MASK to tdx_xfam_deps[]
under the AVX512/XFAM dependency, without separately checking the AVX10
bit. It's safe because any invalid combination supplied by the user will
be caught by tdx_check_features().

Signed-off-by: Xiaoyao Li <xiaoyao.li@intel.com>
Tested-by: Chenyi Qiang <chenyi.qiang@intel.com>
---
 target/i386/kvm/tdx.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/target/i386/kvm/tdx.c b/target/i386/kvm/tdx.c
index 6c80f6e7dcbe..b1bc4ffd950f 100644
--- a/target/i386/kvm/tdx.c
+++ b/target/i386/kvm/tdx.c
@@ -571,6 +571,9 @@ typedef struct TdxXFAMDep {
  * - AMX alias bits, their type is "CPUID_Enabled & Native" which means their
  * value is determined by the CPUID bit they are aliased to.
  *
+ * - AVX10_VL_MASK, their type is "XFAM & CPUID_Enabled & Native" which means
+ * their value is determined by both the corresponding XFAM bit and CPUID bit.
+ *
  * For simplicity, relax the dependency to related XFAM bit.
  * tdx_check_features() will eventually catch the unsupported configurations.
  */
@@ -579,6 +582,7 @@ TdxXFAMDep tdx_xfam_deps[] = {
     { XSTATE_YMM_BIT,       { FEAT_7_0_EBX, CPUID_7_0_EBX_AVX2 } },
     { XSTATE_OPMASK_BIT,    { FEAT_7_0_ECX, CPUID_7_0_ECX_AVX512_VBMI } },
     { XSTATE_OPMASK_BIT,    { FEAT_7_0_EDX, CPUID_7_0_EDX_AVX512_FP16 } },
+    { XSTATE_OPMASK_BIT,    { FEAT_24_0_EBX, CPUID_24_0_EBX_AVX10_VL_MASK } },
     { XSTATE_PT_BIT,        { FEAT_7_0_EBX, CPUID_7_0_EBX_INTEL_PT } },
     { XSTATE_PKRU_BIT,      { FEAT_7_0_ECX, CPUID_7_0_ECX_PKU } },
     { XSTATE_CET_U_BIT,     { FEAT_7_0_ECX, CPUID_7_0_ECX_CET_SHSTK } },
-- 
2.43.0


