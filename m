Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DA068D59D99
	for <qemu-devel@archiver.kernel.org>; Mon, 15 Dec 2025 07:13:59 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vV2lk-0003BB-U8; Mon, 15 Dec 2025 02:13:20 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1vV2li-00039p-IN
 for qemu-devel@nongnu.org; Mon, 15 Dec 2025 02:13:18 -0500
Received: from mgamail.intel.com ([198.175.65.9])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1vV2lh-0008DF-0o
 for qemu-devel@nongnu.org; Mon, 15 Dec 2025 02:13:18 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1765782797; x=1797318797;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=Od7MH3p6ChJmtLWUaAsLaiPAZLqzLKYPw3Ayr328ah8=;
 b=ZzBdHMDD3d0YARqfx22BJOMxLJKzCK+eZ3nRDqzrligcx8hp4I1wZhMA
 Dxz0z29uDUqisogo/+T9O4DhfFa9t0u0E2VmgORvOp1vnUrRKdqj6SdR5
 25oRjqZcxrjfLRdhjDeGJIRItqEaP6xe4LniiXd2gZOXBsOamlPP2sWHE
 8w+yldskP2U/W7kFxaMUcNrQGDqg2W5kNeK6qX49mtL33VPMUoFBZqaGb
 qBX0vWA+/uML+DwXML3L48lhm3/uslVNUyRYAFdE95s497IS4dHXHHOYF
 SIN9NM3LaZKAr2TZWpoypTPnBVFgYFPbTv4Mqel4dc50uCxXrRUQmatl9 w==;
X-CSE-ConnectionGUID: JD+1utEdR5uU+Xvz4tQesg==
X-CSE-MsgGUID: +TZO43qAS4WdwkE13HGk8g==
X-IronPort-AV: E=McAfee;i="6800,10657,11642"; a="90332262"
X-IronPort-AV: E=Sophos;i="6.21,150,1763452800"; d="scan'208";a="90332262"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
 by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 14 Dec 2025 23:13:17 -0800
X-CSE-ConnectionGUID: 2x8ehcjzTTeBTiiJTHLyeQ==
X-CSE-MsgGUID: i42Pdx5xTwq/NAlLeqtxvQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,150,1763452800"; d="scan'208";a="197265970"
Received: from liuzhao-optiplex-7080.sh.intel.com ([10.239.160.39])
 by fmviesa007.fm.intel.com with ESMTP; 14 Dec 2025 23:13:15 -0800
From: Zhao Liu <zhao1.liu@intel.com>
To: Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Daniel=20P=20=2E=20Berrang=C3=A9?= <berrange@redhat.com>
Cc: qemu-devel@nongnu.org, Xudong Hao <xudong.hao@intel.com>,
 Zhao Liu <zhao1.liu@intel.com>
Subject: [PATCH v2 09/11] i386/cpu: Define dependency for
 VMX_VM_ENTRY_LOAD_IA32_FRED
Date: Mon, 15 Dec 2025 15:37:41 +0800
Message-Id: <20251215073743.4055227-10-zhao1.liu@intel.com>
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

VMX_VM_ENTRY_LOAD_IA32_FRED depends on FRED. Define this dependency
relationship.

Tested-by: Xudong Hao <xudong.hao@intel.com>
Signed-off-by: Zhao Liu <zhao1.liu@intel.com>
---
 target/i386/cpu.c | 4 ++++
 target/i386/cpu.h | 1 +
 2 files changed, 5 insertions(+)

diff --git a/target/i386/cpu.c b/target/i386/cpu.c
index 6998c900b1dc..07ece8878542 100644
--- a/target/i386/cpu.c
+++ b/target/i386/cpu.c
@@ -2036,6 +2036,10 @@ static FeatureDep feature_dependencies[] = {
         .from = { FEAT_7_1_EDX,             CPUID_7_1_EDX_AVX10 },
         .to = { FEAT_24_1_ECX,              ~0ull },
     },
+    {
+        .from = { FEAT_7_1_EAX,             CPUID_7_1_EAX_FRED },
+        .to = { FEAT_VMX_ENTRY_CTLS,        VMX_VM_ENTRY_LOAD_IA32_FRED },
+    },
 };
 
 typedef struct X86RegisterInfo32 {
diff --git a/target/i386/cpu.h b/target/i386/cpu.h
index 2546463fd6fe..d341e9835716 100644
--- a/target/i386/cpu.h
+++ b/target/i386/cpu.h
@@ -1441,6 +1441,7 @@ uint64_t x86_cpu_get_supported_feature_word(X86CPU *cpu, FeatureWord w);
 #define VMX_VM_ENTRY_LOAD_IA32_RTIT_CTL             0x00040000
 #define VMX_VM_ENTRY_LOAD_CET                       0x00100000
 #define VMX_VM_ENTRY_LOAD_IA32_PKRS                 0x00400000
+#define VMX_VM_ENTRY_LOAD_IA32_FRED                 0x00800000
 
 /* Supported Hyper-V Enlightenments */
 #define HYPERV_FEAT_RELAXED             0
-- 
2.34.1


