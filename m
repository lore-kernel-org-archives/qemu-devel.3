Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6F29BFD2D91
	for <qemu-devel@archiver.kernel.org>; Tue, 10 Mar 2026 13:43:45 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vzxM3-00073D-Fg; Tue, 10 Mar 2026 09:42:35 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1vzxLw-00070E-S7
 for qemu-devel@nongnu.org; Tue, 10 Mar 2026 09:42:29 -0400
Received: from mgamail.intel.com ([198.175.65.14])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1vzxLt-0003Dj-R3
 for qemu-devel@nongnu.org; Tue, 10 Mar 2026 09:42:28 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1773150146; x=1804686146;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=D0hw7OIpiW/NE4xd5uMdafmsbvzsIf/gcO9TbnVEeh8=;
 b=VvdtHSTGpOjota/0drd+Fhvc5qUQlY9+j3NYVbL1ca+s5vMYVwMb8zan
 jembudUl/rXhigIbIIMG5Bi7dIgocIJQHUUcbu7LiH2xZL/wG21Hnmyag
 Dqawzr1Fzsa6WBx1dqAIMt2VHJz0KbV6wOMHSa7wZ61YhNqgBIfYZ8bdS
 ExcO55BPUmGvKgQpyG89MUNmEnDpF2bJydQS9TlZxg3oXqC8NAcCEg6ky
 t6gS32vze12w6jbcapj3UbdnjCFSkTsjKb6fnKBQyWglBEinEXmT4cuWp
 bpKy1O7PLdka3reIVjW5mPTkyoQVmJPqvmNVkrlrM7wjNtUpayP44towG w==;
X-CSE-ConnectionGUID: VYyCoWRlTxGkcmy9NNwncg==
X-CSE-MsgGUID: RLMsDV4FTHqsDh0zSZ02zQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11725"; a="78048235"
X-IronPort-AV: E=Sophos;i="6.23,112,1770624000"; d="scan'208";a="78048235"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
 by orvoesa106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 10 Mar 2026 06:42:21 -0700
X-CSE-ConnectionGUID: PePB4s93S5KOulPFLpye5g==
X-CSE-MsgGUID: Pb31thVoSQuAoswSMyFGzg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,112,1770624000"; d="scan'208";a="217647971"
Received: from liuzhao-optiplex-7080.sh.intel.com ([10.239.160.39])
 by fmviesa007.fm.intel.com with ESMTP; 10 Mar 2026 06:42:20 -0700
From: Zhao Liu <zhao1.liu@intel.com>
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: qemu-devel@nongnu.org,
	Zhao Liu <zhao1.liu@intel.com>
Subject: [PATCH 2/5] i386/cpu: Rename AMX mirror feature words with -alias
 suffix
Date: Tue, 10 Mar 2026 22:08:16 +0800
Message-Id: <20260310140819.1563084-3-zhao1.liu@intel.com>
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

The commit 956b8f0fc38a ("i386/cpu: Add CPUID.0x1E.0x1 subleaf for AMX
instructions") names amx-int8/amx-bf16/amx-complex-amx-fp16 in CPUID
0x1E.1.EAX with "-mirror" suffix.

To align with the naming style of corresponding macros, rename these
feature words with "-alias" suffix.

Since the commit 956b8f0fc38a is merged in v11.0 development cycle,
it's safe to modify the names of feature words (before v11.0 is
released).

Signed-off-by: Zhao Liu <zhao1.liu@intel.com>
---
 target/i386/cpu.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/target/i386/cpu.c b/target/i386/cpu.c
index 953770db9c9a..21dcfa47c351 100644
--- a/target/i386/cpu.c
+++ b/target/i386/cpu.c
@@ -1314,7 +1314,7 @@ FeatureWordInfo feature_word_info[FEATURE_WORDS] = {
     [FEAT_1E_1_EAX] = {
         .type = CPUID_FEATURE_WORD,
         .feat_names = {
-            "amx-int8-mirror", "amx-bf16-mirror", "amx-complex-mirror", "amx-fp16-mirror",
+            "amx-int8-alias", "amx-bf16-alias", "amx-complex-alias", "amx-fp16-alias",
             "amx-fp8", NULL, "amx-tf32", "amx-avx512",
             "amx-movrs", NULL, NULL, NULL,
             NULL, NULL, NULL, NULL,
-- 
2.34.1


