Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 229DFCED240
	for <qemu-devel@archiver.kernel.org>; Tue, 18 Nov 2025 03:22:14 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vLCGa-0001I7-2X; Mon, 17 Nov 2025 22:20:28 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1vLCGY-0001Hb-09
 for qemu-devel@nongnu.org; Mon, 17 Nov 2025 22:20:26 -0500
Received: from mgamail.intel.com ([192.198.163.13])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1vLCGV-0004Cj-8f
 for qemu-devel@nongnu.org; Mon, 17 Nov 2025 22:20:25 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1763436023; x=1794972023;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=i0sp4wj5rSSd6tZSRimjqOo45WUYte6rhpv/w5HY6HQ=;
 b=lb0yskbOws2sNFWwuBV4EKMjF8DfnjT0oNl/Ewj6vhAKayzYnUhZiVt5
 BtXvfkrU5J8pRADbvNyZz3xN/qKuPdETCuLvqpjvYS1W8cyRYa1d9nUT/
 s9pVkB1zsyZv3AEJ1AAWWFZ4DTmpb2tOMHvsTIOf8hEIf++ld7RTcXXkV
 bRAfi95/w6jM/caBslBcp5B6DTZkQnhY/UlejpSBFOWGh62gNK9W+cokB
 IL5Vw1M0J0mhL4LZ+tKMc+7ectLQH6EinG7qrm7jtr8oDcvn6KlBM16cN
 m6Fx8cUXX65RNeHl2B3ZgK+44hkLpZ1SDAzd0FZQzqsOM4sX7AA2nwy57 A==;
X-CSE-ConnectionGUID: OErsOu7nSvu+H9dpra4KTg==
X-CSE-MsgGUID: 6dUPJkIIT12ZjsKnyIakng==
X-IronPort-AV: E=McAfee;i="6800,10657,11616"; a="68053725"
X-IronPort-AV: E=Sophos;i="6.19,313,1754982000"; d="scan'208";a="68053725"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
 by fmvoesa107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 17 Nov 2025 19:20:20 -0800
X-CSE-ConnectionGUID: jryimD4CS16MurwiigIJLg==
X-CSE-MsgGUID: P4zwZAEkRfKOyfaRWxrCAA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,313,1754982000"; d="scan'208";a="221537132"
Received: from liuzhao-optiplex-7080.sh.intel.com ([10.239.160.39])
 by fmviesa001.fm.intel.com with ESMTP; 17 Nov 2025 19:20:17 -0800
From: Zhao Liu <zhao1.liu@intel.com>
To: Paolo Bonzini <pbonzini@redhat.com>, Marcelo Tosatti <mtosatti@redhat.com>
Cc: qemu-devel@nongnu.org, kvm@vger.kernel.org, Chao Gao <chao.gao@intel.com>,
 Xin Li <xin@zytor.com>, John Allen <john.allen@amd.com>,
 Babu Moger <babu.moger@amd.com>, Mathias Krause <minipli@grsecurity.net>,
 Dapeng Mi <dapeng1.mi@intel.com>, Zide Chen <zide.chen@intel.com>,
 Xiaoyao Li <xiaoyao.li@intel.com>, Chenyi Qiang <chenyi.qiang@intel.com>,
 Farrah Chen <farrah.chen@intel.com>, Zhao Liu <zhao1.liu@intel.com>
Subject: [PATCH v4 01/23] i386/cpu: Clean up indent style of
 x86_ext_save_areas[]
Date: Tue, 18 Nov 2025 11:42:09 +0800
Message-Id: <20251118034231.704240-2-zhao1.liu@intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20251118034231.704240-1-zhao1.liu@intel.com>
References: <20251118034231.704240-1-zhao1.liu@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=192.198.163.13; envelope-from=zhao1.liu@intel.com;
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

The indentation style in `x86_ext_save_areas[]` is extremely
inconsistent. Clean it up to ensure a uniform style.

Tested-by: Farrah Chen <farrah.chen@intel.com>
Reviewed-by: Xiaoyao Li <xiaoyao.li@intel.com>
Signed-off-by: Zhao Liu <zhao1.liu@intel.com>
---
 target/i386/cpu.c | 58 +++++++++++++++++++++++++++--------------------
 1 file changed, 33 insertions(+), 25 deletions(-)

diff --git a/target/i386/cpu.c b/target/i386/cpu.c
index 641777578637..c598f09f3d50 100644
--- a/target/i386/cpu.c
+++ b/target/i386/cpu.c
@@ -2028,38 +2028,46 @@ ExtSaveArea x86_ext_save_areas[XSAVE_STATE_AREA_COUNT] = {
         .feature = FEAT_1_ECX, .bits = CPUID_EXT_XSAVE,
         .size = sizeof(X86LegacyXSaveArea) + sizeof(X86XSaveHeader),
     },
-    [XSTATE_YMM_BIT] =
-          { .feature = FEAT_1_ECX, .bits = CPUID_EXT_AVX,
-            .size = sizeof(XSaveAVX) },
-    [XSTATE_BNDREGS_BIT] =
-          { .feature = FEAT_7_0_EBX, .bits = CPUID_7_0_EBX_MPX,
-            .size = sizeof(XSaveBNDREG)  },
-    [XSTATE_BNDCSR_BIT] =
-          { .feature = FEAT_7_0_EBX, .bits = CPUID_7_0_EBX_MPX,
-            .size = sizeof(XSaveBNDCSR)  },
-    [XSTATE_OPMASK_BIT] =
-          { .feature = FEAT_7_0_EBX, .bits = CPUID_7_0_EBX_AVX512F,
-            .size = sizeof(XSaveOpmask) },
-    [XSTATE_ZMM_Hi256_BIT] =
-          { .feature = FEAT_7_0_EBX, .bits = CPUID_7_0_EBX_AVX512F,
-            .size = sizeof(XSaveZMM_Hi256) },
-    [XSTATE_Hi16_ZMM_BIT] =
-          { .feature = FEAT_7_0_EBX, .bits = CPUID_7_0_EBX_AVX512F,
-            .size = sizeof(XSaveHi16_ZMM) },
-    [XSTATE_PKRU_BIT] =
-          { .feature = FEAT_7_0_ECX, .bits = CPUID_7_0_ECX_PKU,
-            .size = sizeof(XSavePKRU) },
+    [XSTATE_YMM_BIT] = {
+        .feature = FEAT_1_ECX, .bits = CPUID_EXT_AVX,
+        .size = sizeof(XSaveAVX),
+    },
+    [XSTATE_BNDREGS_BIT] = {
+        .feature = FEAT_7_0_EBX, .bits = CPUID_7_0_EBX_MPX,
+        .size = sizeof(XSaveBNDREG),
+    },
+    [XSTATE_BNDCSR_BIT] = {
+        .feature = FEAT_7_0_EBX, .bits = CPUID_7_0_EBX_MPX,
+        .size = sizeof(XSaveBNDCSR),
+    },
+    [XSTATE_OPMASK_BIT] = {
+        .feature = FEAT_7_0_EBX, .bits = CPUID_7_0_EBX_AVX512F,
+        .size = sizeof(XSaveOpmask),
+    },
+    [XSTATE_ZMM_Hi256_BIT] = {
+        .feature = FEAT_7_0_EBX, .bits = CPUID_7_0_EBX_AVX512F,
+        .size = sizeof(XSaveZMM_Hi256),
+    },
+    [XSTATE_Hi16_ZMM_BIT] = {
+        .feature = FEAT_7_0_EBX, .bits = CPUID_7_0_EBX_AVX512F,
+        .size = sizeof(XSaveHi16_ZMM),
+    },
+    [XSTATE_PKRU_BIT] = {
+        .feature = FEAT_7_0_ECX, .bits = CPUID_7_0_ECX_PKU,
+        .size = sizeof(XSavePKRU),
+    },
     [XSTATE_ARCH_LBR_BIT] = {
-            .feature = FEAT_7_0_EDX, .bits = CPUID_7_0_EDX_ARCH_LBR,
-            .offset = 0 /*supervisor mode component, offset = 0 */,
-            .size = sizeof(XSavesArchLBR) },
+        .feature = FEAT_7_0_EDX, .bits = CPUID_7_0_EDX_ARCH_LBR,
+        .offset = 0 /*supervisor mode component, offset = 0 */,
+        .size = sizeof(XSavesArchLBR),
+    },
     [XSTATE_XTILE_CFG_BIT] = {
         .feature = FEAT_7_0_EDX, .bits = CPUID_7_0_EDX_AMX_TILE,
         .size = sizeof(XSaveXTILECFG),
     },
     [XSTATE_XTILE_DATA_BIT] = {
         .feature = FEAT_7_0_EDX, .bits = CPUID_7_0_EDX_AMX_TILE,
-        .size = sizeof(XSaveXTILEDATA)
+        .size = sizeof(XSaveXTILEDATA),
     },
 };
 
-- 
2.34.1


