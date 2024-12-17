Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 09EB5E77184
	for <qemu-devel@archiver.kernel.org>; Tue, 17 Dec 2024 12:54:56 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tNX5L-0000Ar-2e; Tue, 17 Dec 2024 07:53:59 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <xiaoyao.li@intel.com>)
 id 1tNX5H-00009d-KL
 for qemu-devel@nongnu.org; Tue, 17 Dec 2024 07:53:55 -0500
Received: from mgamail.intel.com ([198.175.65.18])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <xiaoyao.li@intel.com>)
 id 1tNX5G-0005Dm-4r
 for qemu-devel@nongnu.org; Tue, 17 Dec 2024 07:53:55 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1734440034; x=1765976034;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=eP9ccYSBy7WauejSMKCP7v6630KiEs32C3sTsU8g46Y=;
 b=Nh+B6fmib3jYwKAGkNOkx9X80zujMIc7YRlbUq0wjvN5cRF41amblvMv
 J4udurNbWiRrhHGUmFqHHkUwSsTMre21GzrA3D3Zw1NFPJkSAHIR8gyI4
 GLf0WQts9lclD+kxjazHeMYq0D+Hxk1DBPHBxQhHGYGEifP6G4/POe4f4
 hul1F+ZHszrewu/KQ6d0pv1RlPFM56tqFeZX+aAvmVF9bjoPzASyojP4H
 +USSjQxfXEYU+5+EW9W8KF7kB4BK44WwsCxV6c8wCeJJ3NF7d5V2hB83y
 ozafkH6mcGsIRLabmxNfvQVGBxMcQv9S81+w37vtxZ0tZpgj3hO6I/AnW Q==;
X-CSE-ConnectionGUID: zOQtWqgTShqNNGS4z0D3oA==
X-CSE-MsgGUID: zdWApjetQEyWaad8ug11ww==
X-IronPort-AV: E=McAfee;i="6700,10204,11288"; a="34993238"
X-IronPort-AV: E=Sophos;i="6.12,241,1728975600"; d="scan'208";a="34993238"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
 by orvoesa110.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 17 Dec 2024 04:53:51 -0800
X-CSE-ConnectionGUID: M4b/ap9nSbyKrtqK9UQIUw==
X-CSE-MsgGUID: eGgFOjKxScaJfq4ryYMwOA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,241,1728975600"; d="scan'208";a="97760190"
Received: from lxy-clx-4s.sh.intel.com ([10.239.48.52])
 by fmviesa008.fm.intel.com with ESMTP; 17 Dec 2024 04:53:50 -0800
From: Xiaoyao Li <xiaoyao.li@intel.com>
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: Zhao Liu <zhao1.liu@intel.com>,
	qemu-devel@nongnu.org
Subject: [PATCH 1/2] i386: Remove unused parameter "uint32_t bit" in
 feature_word_description()
Date: Tue, 17 Dec 2024 07:39:31 -0500
Message-Id: <20241217123932.948789-2-xiaoyao.li@intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20241217123932.948789-1-xiaoyao.li@intel.com>
References: <20241217123932.948789-1-xiaoyao.li@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=198.175.65.18; envelope-from=xiaoyao.li@intel.com;
 helo=mgamail.intel.com
X-Spam_score_int: -33
X-Spam_score: -3.4
X-Spam_bar: ---
X-Spam_report: (-3.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 HK_RANDOM_ENVFROM=0.001, HK_RANDOM_FROM=0.998, RCVD_IN_DNSWL_MED=-2.3,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
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

From: Lei Wang <lei4.wang@intel.com>

Parameter "uint32_t bit" is not used in function feature_word_description(),
so remove it.

Signed-off-by: Lei Wang <lei4.wang@intel.com>
Reviewed-by: Igor Mammedov <imammedo@redhat.com>
Reviewed-by: Xiaoyao Li <xiaoyao.li@intel.com>
Signed-off-by: Xiaoyao Li <xiaoyao.li@intel.com>
---
 target/i386/cpu.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/target/i386/cpu.c b/target/i386/cpu.c
index 525339945920..d09e2f868c35 100644
--- a/target/i386/cpu.c
+++ b/target/i386/cpu.c
@@ -5451,7 +5451,7 @@ static const TypeInfo max_x86_cpu_type_info = {
     .class_init = max_x86_cpu_class_init,
 };
 
-static char *feature_word_description(FeatureWordInfo *f, uint32_t bit)
+static char *feature_word_description(FeatureWordInfo *f)
 {
     assert(f->type == CPUID_FEATURE_WORD || f->type == MSR_FEATURE_WORD);
 
@@ -5490,6 +5490,7 @@ static void mark_unavailable_features(X86CPU *cpu, FeatureWord w, uint64_t mask,
     CPUX86State *env = &cpu->env;
     FeatureWordInfo *f = &feature_word_info[w];
     int i;
+    g_autofree char *feat_word_str = feature_word_description(f);
 
     if (!cpu->force_features) {
         env->features[w] &= ~mask;
@@ -5502,7 +5503,6 @@ static void mark_unavailable_features(X86CPU *cpu, FeatureWord w, uint64_t mask,
 
     for (i = 0; i < 64; ++i) {
         if ((1ULL << i) & mask) {
-            g_autofree char *feat_word_str = feature_word_description(f, i);
             warn_report("%s: %s%s%s [bit %d]",
                         verbose_prefix,
                         feat_word_str,
-- 
2.34.1


