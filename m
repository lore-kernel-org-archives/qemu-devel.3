Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 10E4BCA5FAB
	for <qemu-devel@archiver.kernel.org>; Wed, 30 Sep 2026 04:53:51 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xBmJW-0006wL-1S; Wed, 30 Sep 2026 00:53:06 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1xBmJR-0006un-Vj
 for qemu-devel@nongnu.org; Wed, 30 Sep 2026 00:53:02 -0400
Received: from mgamail.intel.com ([192.198.163.13])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1xBmJP-0001MR-1P
 for qemu-devel@nongnu.org; Wed, 30 Sep 2026 00:53:01 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1790743979; x=1822279979;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=mLkoxDzVv5Mxn5ux4lAilETYizLwl/vJcPN2MS2GGQs=;
 b=G5C7XzTYLXUodJmWs9pwWmnbaeGPLrixg9KTTB6/Ku/YQUOck05usj6g
 XilHeV+ZkIt8Ibiz3xcrvVERaxbAk6/rEi8qYB2mi5bEv5/ekQ4fy6jTP
 OWOE6q6pojdGaieg5cGdCDw+3Spc3zB21L8OUvCcm1mGKWEzrq5DJsP9y
 xnURY6uOCjGdZ4CxtN0K+NyQN/LteoF3SvsHIOGh0FTd3wPwnv/PSF8Az
 WjmK7sqeAI6A7bPH/iLvi1dDdg8BXODPqeO8cvHc3fqccXMS4rilKXSiY
 YO58MbRx1nVMAzffCmSmlDnhxVZGOBOlm+KmCTNIeM8S2RAHUhU3l/7sW w==;
X-CSE-ConnectionGUID: tO2OjMJnTDCPlGsgjcv9HA==
X-CSE-MsgGUID: H0N1sVWJQhmgrEGkpRGHvw==
X-IronPort-AV: E=McAfee;i="6800,10657,11920"; a="93959632"
X-IronPort-AV: E=Sophos;i="6.27,130,1787036400"; d="scan'208";a="93959632"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
 by fmvoesa107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 29 Sep 2026 21:52:56 -0700
X-CSE-ConnectionGUID: /3P/JoVdSuWsulzaJv4Gwg==
X-CSE-MsgGUID: xr+PdKhTRVar/94hmFRuuQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,130,1787036400"; d="scan'208";a="275721206"
Received: from zhaoliu1-desk.sh.intel.com ([10.112.226.173])
 by fmviesa008.fm.intel.com with ESMTP; 29 Sep 2026 21:52:55 -0700
From: Zhao Liu <zhao1.liu@intel.com>
To: Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
Cc: qemu-devel@nongnu.org,
	Zhao Liu <zhao1.liu@intel.com>
Subject: [PATCH 2/3] i386/cpu: rename CPUID_24_1_ECX_AVX10_VNNI_INT macro to
 CPUID_24_1_ECX_AVX10_V1_AUX
Date: Wed, 30 Sep 2026 12:52:36 +0800
Message-Id: <20260930045237.784060-3-zhao1.liu@intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260930045237.784060-1-zhao1.liu@intel.com>
References: <20260930045237.784060-1-zhao1.liu@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=192.198.163.13; envelope-from=zhao1.liu@intel.com;
 helo=mgamail.intel.com
X-Spam_score_int: -46
X-Spam_score: -4.7
X-Spam_bar: ----
X-Spam_report: (-4.7 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.341,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, SPF_HELO_NONE=0.001,
 SPF_NONE=0.001 autolearn=ham autolearn_force=no
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

Use CPUID_24_1_ECX_AVX10_V1_AUX macro to align with the official feature
name in AVX10.2 (since AVX10.2 spec rev 6.0).

Signed-off-by: Zhao Liu <zhao1.liu@intel.com>
---
 target/i386/cpu.c | 4 ++--
 target/i386/cpu.h | 4 ++--
 2 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/target/i386/cpu.c b/target/i386/cpu.c
index e1c012cf2dfa..6f27c2e7b00b 100644
--- a/target/i386/cpu.c
+++ b/target/i386/cpu.c
@@ -2395,7 +2395,7 @@ static const AVX10VersionDefinition builtin_avx10_defs[] = {
         .version = 2,
         .max_subleaf = 1,
         .features = (FeatureMask[]) {
-            { FEAT_24_1_ECX,         CPUID_24_1_ECX_AVX10_VNNI_INT },
+            { FEAT_24_1_ECX,         CPUID_24_1_ECX_AVX10_V1_AUX },
             { /* end of list */ }
         }
     },
@@ -5733,7 +5733,7 @@ static const X86CPUDefinition builtin_x86_defs[] = {
          * Though this bit will be set by avx_version=2, it's better to
          * explicitly enumerate this feature here.
          */
-        .features[FEAT_24_1_ECX] = CPUID_24_1_ECX_AVX10_VNNI_INT,
+        .features[FEAT_24_1_ECX] = CPUID_24_1_ECX_AVX10_V1_AUX,
         .features[FEAT_8000_0001_ECX] =
             CPUID_EXT3_LAHF_LM | CPUID_EXT3_ABM | CPUID_EXT3_3DNOWPREFETCH,
         .features[FEAT_8000_0001_EDX] =
diff --git a/target/i386/cpu.h b/target/i386/cpu.h
index 786957fadd08..771673d0902a 100644
--- a/target/i386/cpu.h
+++ b/target/i386/cpu.h
@@ -1136,8 +1136,8 @@ uint64_t x86_cpu_get_supported_feature_word(X86CPU *cpu, FeatureWord w);
                                          CPUID_24_0_EBX_AVX10_256 | \
                                          CPUID_24_0_EBX_AVX10_512)
 
-/* AVX10_VNNI_INT instruction */
-#define CPUID_24_1_ECX_AVX10_VNNI_INT         (1U << 2)
+/* AVX10_V1_AUX instruction */
+#define CPUID_24_1_ECX_AVX10_V1_AUX           (1U << 2)
 
 /*
  * New Conditional Instructions (NCIs), explicit New Data Destination (NDD)
-- 
2.34.1


