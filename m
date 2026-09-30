Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EC0E0C9830E
	for <qemu-devel@archiver.kernel.org>; Wed, 30 Sep 2026 04:53:37 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xBmJS-0006v5-Kd; Wed, 30 Sep 2026 00:53:02 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1xBmJQ-0006uX-NH
 for qemu-devel@nongnu.org; Wed, 30 Sep 2026 00:53:00 -0400
Received: from mgamail.intel.com ([192.198.163.13])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1xBmJO-0001ML-Kb
 for qemu-devel@nongnu.org; Wed, 30 Sep 2026 00:53:00 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1790743979; x=1822279979;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=MdjqM2uX4tdfwER5KKwp7lZwK7OojUIzEOKitSnAa6g=;
 b=DOtN2Y7CZgxOklzHciLv9gu3LCLfcGFaoQdydJqACad1netBvO0KUlCg
 fu2Un4TIYbRnuLpinvwhzrOmTZgZNqRI8eVbpOQzzPUXuVIvi/f+4A+uC
 N3pYJFN+/vTaiK+t8zkAr6Yw4V7KfCjZNsAhS7GYDjJ6UrW3zS1Dz+xvT
 VNYlVLMCLhrb/C1YayK63hIC6Sr+6DX6TxpXgXiuPpx5yGYUDdR7YgOL6
 ArOFVfoXA6kPmCTd4locfLd+PmyO+0ckv+AixuUdAiqf+bnrFqxEKwsSF
 2SL8Eu36koBt9f/tLwRjlyNb0SS5TkDOAuT+KxAjihFevJuEHh8R08WUg g==;
X-CSE-ConnectionGUID: i4lMulO3QRuMdu8i7GnotQ==
X-CSE-MsgGUID: 7NH21ML3TW2WYse5/VnJTg==
X-IronPort-AV: E=McAfee;i="6800,10657,11920"; a="93959629"
X-IronPort-AV: E=Sophos;i="6.27,130,1787036400"; d="scan'208";a="93959629"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
 by fmvoesa107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 29 Sep 2026 21:52:55 -0700
X-CSE-ConnectionGUID: wmxvN6C8Q3CNLgAShhy1vg==
X-CSE-MsgGUID: v358QRS1SbS6x5PU2lMpjQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,130,1787036400"; d="scan'208";a="275721203"
Received: from zhaoliu1-desk.sh.intel.com ([10.112.226.173])
 by fmviesa008.fm.intel.com with ESMTP; 29 Sep 2026 21:52:53 -0700
From: Zhao Liu <zhao1.liu@intel.com>
To: Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
Cc: qemu-devel@nongnu.org,
	Zhao Liu <zhao1.liu@intel.com>
Subject: [PATCH 1/3] i386/cpu: rename feature name avx10-vnni-int to
 avx10-v1-aux
Date: Wed, 30 Sep 2026 12:52:35 +0800
Message-Id: <20260930045237.784060-2-zhao1.liu@intel.com>
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

Since the AVX10.2 Spec rev. 6.0, CPUID feature bit AVX10_VNNI_INT is
renamed to AVX10_V1_AUX to cover additional more convert instructions:
VCVT[,2]PH2[B,H]F8[,S], VCVT2PS2PHX,VCVTBIASPH2[B,H]F8[,S], VCVTHF82PH.

Therefore, rename the feature name to avx10-v1-aux and use the old name
avx10-vnni-int as an alias for compatibility.

Signed-off-by: Zhao Liu <zhao1.liu@intel.com>
---
 target/i386/cpu.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/target/i386/cpu.c b/target/i386/cpu.c
index f3bc6911c10f..e1c012cf2dfa 100644
--- a/target/i386/cpu.c
+++ b/target/i386/cpu.c
@@ -1370,7 +1370,7 @@ FeatureWordInfo feature_word_info[FEATURE_WORDS] = {
     [FEAT_24_1_ECX] = {
         .type = CPUID_FEATURE_WORD,
         .feat_names = {
-            [2] = "avx10-vnni-int",
+            [2] = "avx10-v1-aux",
         },
         .cpuid = {
             .eax = 0x24,
@@ -10556,6 +10556,7 @@ static void x86_cpu_initfn(Object *obj)
     object_property_add_alias(obj, "hv-apicv", obj, "hv-avic");
     cpu->lbr_fmt = ~PERF_CAP_LBR_FMT;
     object_property_add_alias(obj, "lbr_fmt", obj, "lbr-fmt");
+    object_property_add_alias(obj, "avx10-vnni-int", obj, "avx10-v1-aux");
 
     if (xcc->model) {
         x86_cpu_load_model(cpu, xcc->model);
-- 
2.34.1


