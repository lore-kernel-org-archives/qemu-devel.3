Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4E67BFD2D91
	for <qemu-devel@archiver.kernel.org>; Tue, 10 Mar 2026 13:43:11 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vzxM7-00075n-S7; Tue, 10 Mar 2026 09:42:39 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1vzxLx-00070P-M0
 for qemu-devel@nongnu.org; Tue, 10 Mar 2026 09:42:30 -0400
Received: from mgamail.intel.com ([198.175.65.14])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1vzxLw-0003DN-2H
 for qemu-devel@nongnu.org; Tue, 10 Mar 2026 09:42:29 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1773150148; x=1804686148;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=/b530bJ07lOfzQ7t6KMd1QSzVbGo9GL2BuLTUMSx3PQ=;
 b=I9k2fF25ZUItqYLu0/2vETS4ra4QN27ngQb16IDJ4SVS98zYycdc4HDO
 TDSJUx8sIPCa0O9QNzFC2ddwAyEA4vYZ/vyDaLCNDjLviMQuv/AKAZL1G
 R4aG8FHe3Y+OycnwuIbiJhApCOTOsL91OYURY/SaERHFEgUbYNFTJdMXs
 Cw7NhH70+wWC198r87ph2eVNs9NmM3+yrA1xHvkd5FY5JbpXI36ruPV4m
 Vt/T51AFhncOBAggmwSOFSq6/Bt7pMr+5wrGCBdqaRCJIWkWFB+Zz2pR2
 W8luMCCNhmQwvbwrfBffaosAsRoHE3Gnw3FWbk0EwQKBTpTvFJQKiXy4M w==;
X-CSE-ConnectionGUID: M37ZweUHRLmMSBxOjvTqtA==
X-CSE-MsgGUID: ar2hKl83RR2/4mi26UmYEA==
X-IronPort-AV: E=McAfee;i="6800,10657,11725"; a="78048237"
X-IronPort-AV: E=Sophos;i="6.23,112,1770624000"; d="scan'208";a="78048237"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
 by orvoesa106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 10 Mar 2026 06:42:22 -0700
X-CSE-ConnectionGUID: XDa+Bqf/ToOH1nEE19YFcw==
X-CSE-MsgGUID: op0yftVsSf6l6PytyBg8sA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,112,1770624000"; d="scan'208";a="217647976"
Received: from liuzhao-optiplex-7080.sh.intel.com ([10.239.160.39])
 by fmviesa007.fm.intel.com with ESMTP; 10 Mar 2026 06:42:21 -0700
From: Zhao Liu <zhao1.liu@intel.com>
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: qemu-devel@nongnu.org,
	Zhao Liu <zhao1.liu@intel.com>
Subject: [PATCH 3/5] i386/cpu: Remove unnecessary cache_info fields from
 builtin CPU model
Date: Tue, 10 Mar 2026 22:08:17 +0800
Message-Id: <20260310140819.1563084-4-zhao1.liu@intel.com>
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

In x86_cpu_get_versioned_cache_info(), higher version CPU models will
inherit cache_info from lower versions if the cache_info field is not
specified, so there is no need to repeatedly set the same cache_info.

Therefore, remove the repeated cache models from SapphireRapids-v6
(SapphireRapids-v4 has set the cache model), GraniteRapids-v5
(GraniteRapids-v3 has set) and SierraForest-v5 (SierraForest-v3 has
set).

Signed-off-by: Zhao Liu <zhao1.liu@intel.com>
---
 target/i386/cpu.c | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/target/i386/cpu.c b/target/i386/cpu.c
index 21dcfa47c351..c6323fee94bb 100644
--- a/target/i386/cpu.c
+++ b/target/i386/cpu.c
@@ -5264,7 +5264,6 @@ static const X86CPUDefinition builtin_x86_defs[] = {
             {
                 .version = 6,
                 .note = "with cet-ss, cet-ibt, its-no",
-                .cache_info = &xeon_spr_cache_info,
                 .props = (PropValue[]) {
                     { "its-no", "on" },
                     { /* end of list */ },
@@ -5446,7 +5445,6 @@ static const X86CPUDefinition builtin_x86_defs[] = {
             {
                 .version = 5,
                 .note = "with cet-ss, cet-ibt, its-no",
-                .cache_info = &xeon_gnr_cache_info,
                 .props = (PropValue[]) {
                     { "its-no", "on" },
                     { /* end of list */ },
@@ -5812,7 +5810,6 @@ static const X86CPUDefinition builtin_x86_defs[] = {
             {
                 .version = 5,
                 .note = "with ITS_NO",
-                .cache_info = &xeon_srf_cache_info,
                 .props = (PropValue[]) {
                     { "its-no", "on" },
                     { /* end of list */ },
-- 
2.34.1


