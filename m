Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C7F8DC83028
	for <qemu-devel@archiver.kernel.org>; Mon, 30 Jun 2025 08:14:45 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uW9eC-00040W-Ef; Mon, 30 Jun 2025 04:13:52 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <xiaoyao.li@intel.com>)
 id 1uW9eA-0003wc-Dv
 for qemu-devel@nongnu.org; Mon, 30 Jun 2025 04:13:50 -0400
Received: from mgamail.intel.com ([192.198.163.15])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <xiaoyao.li@intel.com>)
 id 1uW9e7-0008FC-8H
 for qemu-devel@nongnu.org; Mon, 30 Jun 2025 04:13:50 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1751271227; x=1782807227;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=nCRHuUYhe42P6UuwE38kZ1hSX8NACPLufNZ+MC6x+3s=;
 b=FSdyjsypCD9fwhcN82UWAvZLEpO0NM2QSPOCWmlmGWx2k6VVTz5iu/wi
 KM5qRhWGy+TAESA/BQ0u9IdBwvCT6Bdn9LTy1/7nS1EJI5mV0/OtQwz+x
 R6wEx1KzVVpxAY/1ctp0CWXdopLL8pdd8aT0CyaYnX3iAXUHU0e9EnOtn
 R5QYkxgsrTvVD2yoW/pYMR0iC/UIRKbNz7MzOljgfhZfZ0cvtweLmEV+F
 sLie6TjHRAtSgcc6sBWc3+K3gCKCdnSDDWv2Let8RN41ox2ZXPd1Kkscb
 sHC6IooBuzuroHuxGKk8s2vvN2RZ5IrMDS2oCg+H/rYmM/ZMhLc5Z0hoo w==;
X-CSE-ConnectionGUID: 8WPZonCHRDOZdnXe+A3vzw==
X-CSE-MsgGUID: 7GKb5hkBQeuQCeZfC25wRA==
X-IronPort-AV: E=McAfee;i="6800,10657,11479"; a="53637405"
X-IronPort-AV: E=Sophos;i="6.16,277,1744095600"; d="scan'208";a="53637405"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
 by fmvoesa109.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 30 Jun 2025 01:13:41 -0700
X-CSE-ConnectionGUID: otzw2sJqRgSlhlujdF7OSA==
X-CSE-MsgGUID: m44nY6AmR6Wkl0r5QVa0vA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,277,1744095600"; d="scan'208";a="152777295"
Received: from lxy-clx-4s.sh.intel.com ([10.239.48.52])
 by orviesa010.jf.intel.com with ESMTP; 30 Jun 2025 01:13:39 -0700
From: Xiaoyao Li <xiaoyao.li@intel.com>
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: Zhao Liu <zhao1.liu@intel.com>, Marcelo Tosatti <mtosatti@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org,
 xiaoyao.li@intel.com
Subject: [PATCH 3/4] i386/kvm-cpu: Fix the indentation inside
 kvm_cpu_realizefn()
Date: Mon, 30 Jun 2025 16:06:09 +0800
Message-ID: <20250630080610.3151956-4-xiaoyao.li@intel.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250630080610.3151956-1-xiaoyao.li@intel.com>
References: <20250630080610.3151956-1-xiaoyao.li@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=192.198.163.15; envelope-from=xiaoyao.li@intel.com;
 helo=mgamail.intel.com
X-Spam_score_int: -33
X-Spam_score: -3.4
X-Spam_bar: ---
X-Spam_report: (-3.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 HK_RANDOM_ENVFROM=0.001, HK_RANDOM_FROM=0.999, RCVD_IN_DNSWL_MED=-2.3,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
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

The indentation of one of the } inside kvm_cpu_realizefn() isn'f
correct. fix it.

Signed-off-by: Xiaoyao Li <xiaoyao.li@intel.com>
---
 target/i386/kvm/kvm-cpu.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/target/i386/kvm/kvm-cpu.c b/target/i386/kvm/kvm-cpu.c
index 16bde4de01e5..6df92dc6d703 100644
--- a/target/i386/kvm/kvm-cpu.c
+++ b/target/i386/kvm/kvm-cpu.c
@@ -72,7 +72,7 @@ static bool kvm_cpu_realizefn(CPUState *cs, Error **errp)
             if (env->features[FEAT_1_ECX] & CPUID_EXT_MONITOR) {
                 host_cpuid(5, 0, &cpu->mwait.eax, &cpu->mwait.ebx,
                            &cpu->mwait.ecx, &cpu->mwait.edx);
-	    }
+            }
         }
         if (cpu->ucode_rev == 0) {
             cpu->ucode_rev =
-- 
2.43.0


