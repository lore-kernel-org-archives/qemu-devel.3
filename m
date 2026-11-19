Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B83D2606A326
	for <qemu-devel@archiver.kernel.org>; Thu, 19 Nov 2026 19:05:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=WpHfu2is
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xU7RB-0000GB-N6; Thu, 19 Nov 2026 14:04:49 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <chang.seok.bae@intel.com>)
 id 1xU7RA-0000Fx-6l; Thu, 19 Nov 2026 14:04:48 -0500
Received: from mgamail.intel.com ([192.198.163.14])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <chang.seok.bae@intel.com>)
 id 1xU7R8-0002Hd-4c; Thu, 19 Nov 2026 14:04:47 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1795115086; x=1826651086;
 h=from:to:cc:subject:date:message-id:mime-version:
 content-transfer-encoding;
 bh=Tk0rmUlFS5C2Sx+tSxdwEpYiwwTI+GAQnZaBagHpXw8=;
 b=WpHfu2ispum98qpMqJuWkBAtdZa0C4MqxbUxt6Kr0rT3O5t/Kdqv6SnD
 hqjL0NicIaZgNjSkWvNM2yFG4IcimCbUhSH9eOyPDLxu6KcBA3ykt2F6q
 mrvZ7CRN1PkK5OC8LuUnNHXFDxz2i5RqGIEOiGAmOy3/GLkvS2M76VYb6
 f6hZx2hgFwvshORdGtV3UDccswH+c75fGMCQigjlD4bEvb5apkw2fOCOE
 Gbdvq8Ttbbr0Ly4+lSUr07PZVYzg3Kbxq/eXuoFOHKjmS1OodpUXh8Emy
 EYlMgyllBy9YNrAzwo371GNRrN5LprQn06OrQee9968LlWFW3e5WyjXRg A==;
X-CSE-ConnectionGUID: vOkKYuajTs++Sv34JK/NHA==
X-CSE-MsgGUID: GyF+C8SoQQqaclhLh3z1Kw==
X-IronPort-AV: E=McAfee;i="6800,10657,11971"; a="3868096"
X-IronPort-AV: E=Sophos;i="6.27,221,1787036400"; 
   d="scan'208";a="3868096"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
 by fmvoesa108.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 19 Nov 2026 11:04:42 -0800
X-CSE-ConnectionGUID: GNXPMJFTRE6Arcrn/bD7Kw==
X-CSE-MsgGUID: Ls9ZdQaxT7q7diFgy++7uw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,221,1787036400"; d="scan'208";a="10846185"
Received: from chang-linux-3.sc.intel.com (HELO chang-linux-3)
 ([172.25.66.174])
 by fmviesa006.fm.intel.com with ESMTP; 19 Nov 2026 11:04:41 -0800
From: "Chang S. Bae" <chang.seok.bae@intel.com>
To: qemu-devel@nongnu.org
Cc: pbonzini@redhat.com, berrange@redhat.com, zhao1.liu@intel.com,
 chang.seok.bae@intel.com, qemu-stable@nongnu.org
Subject: [PATCH v3] i386/cpu: Remove AMX-TF32 CPUID bit from Diamond Rapids
Date: Thu, 19 Nov 2026 18:37:17 +0000
Message-ID: <20261119183717.962303-1-chang.seok.bae@intel.com>
X-Mailer: git-send-email 2.53.0
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=192.198.163.14;
 envelope-from=chang.seok.bae@intel.com; helo=mgamail.intel.com
X-Spam_score_int: -42
X-Spam_score: -4.3
X-Spam_bar: ----
X-Spam_report: (-4.3 / 5.0 requ) AC_FROM_MANY_DOTS=0.135, BAYES_00=-1.9,
 DKIMWL_WL_HIGH=-0.001, DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1,
 DKIM_VALID_EF=-0.1, RCVD_IN_DNSWL_MED=-2.3, SPF_HELO_NONE=0.001,
 SPF_NONE=0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

A recent update (rev. 62) to the Intel document [1] clarifies that the
feature will not be implemented on Diamond Rapids. Listing it would
result in spurious warnings due to the mismatch. Remove the feature from
the CPU model.

Note [1] (rev. 63) now clarifies that the CPUID bit is reserved rather
than removed. So, the existing CPUID bit enumeration does not conflict
with it and can be retained.

[1] Intel Architecture Instruction Set Extensions and Future Features

Cc: qemu-stable@nongnu.org # v11.0+
Reviewed-by: Zhao Liu <zhao1.liu@intel.com>
Signed-off-by: Chang S. Bae <chang.seok.bae@intel.com>
---
V2 -> V3: Remove it from DMR only.
---
 target/i386/cpu.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/target/i386/cpu.c b/target/i386/cpu.c
index 5805d33ab92d..5460ad4494a9 100644
--- a/target/i386/cpu.c
+++ b/target/i386/cpu.c
@@ -5726,8 +5726,7 @@ static const X86CPUDefinition builtin_x86_defs[] = {
             CPUID_1E_1_EAX_AMX_INT8_ALIAS | CPUID_1E_1_EAX_AMX_BF16_ALIAS |
             CPUID_1E_1_EAX_AMX_COMPLEX_ALIAS |
             CPUID_1E_1_EAX_AMX_FP16_ALIAS | CPUID_1E_1_EAX_AMX_FP8 |
-            CPUID_1E_1_EAX_AMX_TF32 | CPUID_1E_1_EAX_AMX_AVX512 |
-            CPUID_1E_1_EAX_AMX_MOVRS,
+            CPUID_1E_1_EAX_AMX_AVX512 | CPUID_1E_1_EAX_AMX_MOVRS,
         .features[FEAT_29_0_EBX] = CPUID_29_0_EBX_APX_NCI_NDD_NF,
         /*
          * Though this bit will be set by avx_version=2, it's better to
-- 
2.53.0


