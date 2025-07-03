Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AAECEC8303C
	for <qemu-devel@archiver.kernel.org>; Thu,  3 Jul 2025 02:48:38 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uX9zb-0002a1-J4; Wed, 02 Jul 2025 22:48:08 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <xiaoyao.li@intel.com>)
 id 1uX9zY-0002Y4-K8
 for qemu-devel@nongnu.org; Wed, 02 Jul 2025 22:48:05 -0400
Received: from mgamail.intel.com ([198.175.65.15])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <xiaoyao.li@intel.com>)
 id 1uX9zR-0007ux-R2
 for qemu-devel@nongnu.org; Wed, 02 Jul 2025 22:48:04 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1751510877; x=1783046877;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=GM3oITmKPvCB1mMVAy/DbcAc4/N7/dTkZo/RHHoELIw=;
 b=e/vFWTabTxIubWvW7DCVo+emW2ttrfkuX/shq0xcMn3u+NesjojqV0PS
 xcl2Xe4UlErqKv/C+1XVQ4btJ8TQpg2golunOaYjGYTZDO0xSfQCjhHkb
 lyz1hGdR9IBn6QUfrASdWsU5KshnjGwyDmubnW7dN2pRsPT52Pn8sonRv
 JJFOojqdrvQvGRk+a0iMufbsPrHjtKxs57xn49ZMoWNT5PKx580Y4tIMT
 n1Msz2neGpYugALYAJ2cz1YJmsGMXHYPP3t7PkSZvrwq/sHpPE7k9s4nv
 f/L/rU/BTnGtp59iwiTRRsMP2qk7UcP3+2zExxLdLSY1YIhl7fTBTGngN g==;
X-CSE-ConnectionGUID: FT0RlAuySrqwTev9S3wsBQ==
X-CSE-MsgGUID: jopSIopNT/aTRNfBxQ2uIw==
X-IronPort-AV: E=McAfee;i="6800,10657,11482"; a="57499453"
X-IronPort-AV: E=Sophos;i="6.16,283,1744095600"; d="scan'208";a="57499453"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
 by orvoesa107.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 02 Jul 2025 19:47:55 -0700
X-CSE-ConnectionGUID: PYpaIqCpTtSlbPj+gY7qzA==
X-CSE-MsgGUID: mrJM3aVjRUyU1KyROBiHBA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,283,1744095600"; d="scan'208";a="153880365"
Received: from lxy-clx-4s.sh.intel.com ([10.239.48.52])
 by fmviesa007.fm.intel.com with ESMTP; 02 Jul 2025 19:47:55 -0700
From: Xiaoyao Li <xiaoyao.li@intel.com>
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: Marcelo Tosatti <mtosatti@redhat.com>, qemu-devel@nongnu.org,
 xiaoyao.li@intel.com
Subject: [PATCH 2/4] update Linux headers to KVM tree master
Date: Thu,  3 Jul 2025 10:40:18 +0800
Message-ID: <20250703024021.3559286-3-xiaoyao.li@intel.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250703024021.3559286-1-xiaoyao.li@intel.com>
References: <20250703024021.3559286-1-xiaoyao.li@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=198.175.65.15; envelope-from=xiaoyao.li@intel.com;
 helo=mgamail.intel.com
X-Spam_score_int: -31
X-Spam_score: -3.2
X-Spam_bar: ---
X-Spam_report: (-3.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 HK_RANDOM_ENVFROM=0.001, HK_RANDOM_FROM=0.999, RCVD_IN_DNSWL_MED=-2.3,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.237, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
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

To fetch the update of TDX

Signed-off-by: Xiaoyao Li <xiaoyao.li@intel.com>
---
 linux-headers/asm-x86/kvm.h | 8 +++++++-
 linux-headers/linux/kvm.h   | 4 ++++
 2 files changed, 11 insertions(+), 1 deletion(-)

diff --git a/linux-headers/asm-x86/kvm.h b/linux-headers/asm-x86/kvm.h
index cd275ae76d25..f0c1a730d9c3 100644
--- a/linux-headers/asm-x86/kvm.h
+++ b/linux-headers/asm-x86/kvm.h
@@ -963,7 +963,13 @@ struct kvm_tdx_cmd {
 struct kvm_tdx_capabilities {
 	__u64 supported_attrs;
 	__u64 supported_xfam;
-	__u64 reserved[254];
+
+	__u64 kernel_tdvmcallinfo_1_r11;
+	__u64 user_tdvmcallinfo_1_r11;
+	__u64 kernel_tdvmcallinfo_1_r12;
+	__u64 user_tdvmcallinfo_1_r12;
+
+	__u64 reserved[250];
 
 	/* Configurable CPUID bits for userspace */
 	struct kvm_cpuid2 cpuid;
diff --git a/linux-headers/linux/kvm.h b/linux-headers/linux/kvm.h
index 0690743944bd..32c5885a3c20 100644
--- a/linux-headers/linux/kvm.h
+++ b/linux-headers/linux/kvm.h
@@ -459,6 +459,10 @@ struct kvm_run {
 					__u64 leaf;
 					__u64 r11, r12, r13, r14;
 				} get_tdvmcall_info;
+				struct {
+					__u64 ret;
+					__u64 vector;
+				} setup_event_notify;
 			};
 		} tdx;
 		/* Fix the size of the union. */
-- 
2.43.0


