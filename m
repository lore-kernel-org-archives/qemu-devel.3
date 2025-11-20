Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 09FE1CF8548
	for <qemu-devel@archiver.kernel.org>; Thu, 20 Nov 2025 06:50:46 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vLyTQ-0005Kx-Hj; Thu, 20 Nov 2025 01:48:56 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1vLyT8-0005Bn-Jb
 for qemu-devel@nongnu.org; Thu, 20 Nov 2025 01:48:38 -0500
Received: from mgamail.intel.com ([192.198.163.17])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1vLyT6-0005rC-Py
 for qemu-devel@nongnu.org; Thu, 20 Nov 2025 01:48:38 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1763621317; x=1795157317;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=Nndl4izXTqAyDYY4lwBwOWojXoOEw74I4SyFMd0/JBs=;
 b=Q97NfVXIAa4R70ulQ8KyYC+hRz0pP8cxzKbtHOYoOIbYxVPD+ZNn3pqT
 YhDAA63YXHmBOZsQQKj8lhBD+TE44rhIILDPJejRQh0FpgPzYtT9WFD9m
 lMNTJSpNYvtZsANnGWqrG+K1GVuPVuu6P20I9CR7qfrUDOKs6t6fpYiPD
 cO7/WHKnnSehsTwB5Z+OeSNDGmzCxy9pJ5NVf1Ipx41tKoOipLyA5Q+dM
 FEe34f/m1OIfXM6a6cJlo7Hc3uf5ioD49qxcVu4ZTCn3r6FWUf4lkKByj
 u5d1Kdxa8eeSPXan94EV8JCXiUZx6I2M66R28KFxAId9qsUXZME8T9N7H g==;
X-CSE-ConnectionGUID: TBhHrfYwTvSvxvmxoLJdcg==
X-CSE-MsgGUID: W7ToK3SDSt6yjMbT5sWh9A==
X-IronPort-AV: E=McAfee;i="6800,10657,11618"; a="65572559"
X-IronPort-AV: E=Sophos;i="6.19,317,1754982000"; d="scan'208";a="65572559"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
 by fmvoesa111.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 19 Nov 2025 22:48:32 -0800
X-CSE-ConnectionGUID: Gt2GvWXXRcGICMsbXLktxA==
X-CSE-MsgGUID: Olm1z26kQ7utTiGDtLUlaA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,317,1754982000"; d="scan'208";a="191296134"
Received: from liuzhao-optiplex-7080.sh.intel.com ([10.239.160.39])
 by orviesa007.jf.intel.com with ESMTP; 19 Nov 2025 22:48:30 -0800
From: Zhao Liu <zhao1.liu@intel.com>
To: Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Daniel=20P=20=2E=20Berrang=C3=A9?= <berrange@redhat.com>
Cc: qemu-devel@nongnu.org, Xudong Hao <xudong.hao@intel.com>,
 Zhao Liu <zhao1.liu@intel.com>
Subject: [PATCH 08/10] i386/cpu: Define dependency for
 VMX_VM_ENTRY_LOAD_IA32_FRED
Date: Thu, 20 Nov 2025 15:10:28 +0800
Message-Id: <20251120071030.961230-9-zhao1.liu@intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20251120071030.961230-1-zhao1.liu@intel.com>
References: <20251120071030.961230-1-zhao1.liu@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=192.198.163.17; envelope-from=zhao1.liu@intel.com;
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
index 143b3e9e0c21..e891883fa72f 100644
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
index a0b8a59f6c98..2631bd25981a 100644
--- a/target/i386/cpu.h
+++ b/target/i386/cpu.h
@@ -1426,6 +1426,7 @@ uint64_t x86_cpu_get_supported_feature_word(X86CPU *cpu, FeatureWord w);
 #define VMX_VM_ENTRY_LOAD_IA32_RTIT_CTL             0x00040000
 #define VMX_VM_ENTRY_LOAD_CET                       0x00100000
 #define VMX_VM_ENTRY_LOAD_IA32_PKRS                 0x00400000
+#define VMX_VM_ENTRY_LOAD_IA32_FRED                 0x00800000
 
 /* Supported Hyper-V Enlightenments */
 #define HYPERV_FEAT_RELAXED             0
-- 
2.34.1


