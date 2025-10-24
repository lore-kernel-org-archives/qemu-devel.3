Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5463FCCD1A5
	for <qemu-devel@archiver.kernel.org>; Fri, 24 Oct 2025 06:36:03 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vCBNy-0003M3-6k; Fri, 24 Oct 2025 02:34:50 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1vCBNv-0003Lc-QK
 for qemu-devel@nongnu.org; Fri, 24 Oct 2025 02:34:47 -0400
Received: from mgamail.intel.com ([192.198.163.9])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1vCBNt-0003jZ-Vj
 for qemu-devel@nongnu.org; Fri, 24 Oct 2025 02:34:47 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1761287686; x=1792823686;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=b6plKWihII+6RJhuLKcgMFrd7Qpmmp9/C3krzhBvVSw=;
 b=DY0Ab5Qr0opb1IVgr7t8ahN0DmFge5HLSukrGRaT4dmO0BY/q3UwJckx
 HveuLqG6wVriunoAFW8XAZM3trcoxMC7iqegYMAhk1FjAVh0d4XlSGVf2
 JYjtJbSJI4MCAWp6FjrU1iQe7gcx22jJ/NhIoZw6g6LudDxaomUR6X2Qa
 hzVgr+/1n+TM8b9AGOJtpgc4mu+04zzBdX8gcea1pb+SKhuUrS5KDhuXK
 /1KvXfLS/SAbYi7OrUQErGvHyVRa7mheKnqHof7+Z1YKazOMWjfQT3yAX
 FunNlbnBLyj1ZNKp22QxPnxKoQwd/kdgJ2a7TUNp5FFjPA3/lyy6FR0Jy w==;
X-CSE-ConnectionGUID: CVBZTsIsQb+TgqiScc9zcg==
X-CSE-MsgGUID: 92mFF0DJT1iuBWy1ufJidw==
X-IronPort-AV: E=McAfee;i="6800,10657,11586"; a="74137853"
X-IronPort-AV: E=Sophos;i="6.19,251,1754982000"; d="scan'208";a="74137853"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
 by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 23 Oct 2025 23:34:45 -0700
X-CSE-ConnectionGUID: 0QUAmH1gS9qrgLL/Dkmxkw==
X-CSE-MsgGUID: wy5mimrYRdKnHSHnHgvAzA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,251,1754982000"; d="scan'208";a="184275882"
Received: from liuzhao-optiplex-7080.sh.intel.com ([10.239.160.39])
 by fmviesa006.fm.intel.com with ESMTP; 23 Oct 2025 23:34:41 -0700
From: Zhao Liu <zhao1.liu@intel.com>
To: Paolo Bonzini <pbonzini@redhat.com>, Marcelo Tosatti <mtosatti@redhat.com>
Cc: qemu-devel@nongnu.org, kvm@vger.kernel.org, Chao Gao <chao.gao@intel.com>,
 John Allen <john.allen@amd.com>, Babu Moger <babu.moger@amd.com>,
 Mathias Krause <minipli@grsecurity.net>, Dapeng Mi <dapeng1.mi@intel.com>,
 Zide Chen <zide.chen@intel.com>, Chenyi Qiang <chenyi.qiang@intel.com>,
 Xiaoyao Li <xiaoyao.li@intel.com>, Farrah Chen <farrah.chen@intel.com>,
 Zhao Liu <zhao1.liu@intel.com>
Subject: [PATCH v3 02/20] i386/cpu: Clean up indent style of
 x86_ext_save_areas[]
Date: Fri, 24 Oct 2025 14:56:14 +0800
Message-Id: <20251024065632.1448606-3-zhao1.liu@intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20251024065632.1448606-1-zhao1.liu@intel.com>
References: <20251024065632.1448606-1-zhao1.liu@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=192.198.163.9; envelope-from=zhao1.liu@intel.com;
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

Tested-by: Farrah Chen <farrah.chen@intel.com>
Signed-off-by: Zhao Liu <zhao1.liu@intel.com>
---
 target/i386/cpu.c | 58 +++++++++++++++++++++++++++--------------------
 1 file changed, 33 insertions(+), 25 deletions(-)

diff --git a/target/i386/cpu.c b/target/i386/cpu.c
index 0a66e1fec939..f0e179c2d235 100644
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


