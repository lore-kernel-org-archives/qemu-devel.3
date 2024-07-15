Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2C11EC3DA4B
	for <qemu-devel@archiver.kernel.org>; Mon, 15 Jul 2024 04:36:05 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sTDQ8-0000ZX-54; Mon, 15 Jul 2024 00:34:40 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1sTDQ6-0000Tg-LE
 for qemu-devel@nongnu.org; Mon, 15 Jul 2024 00:34:38 -0400
Received: from mgamail.intel.com ([198.175.65.10])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1sTDQ5-0004GK-5R
 for qemu-devel@nongnu.org; Mon, 15 Jul 2024 00:34:38 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1721018078; x=1752554078;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=u1cSsKiZS4LgVHWKLVbqsnZaR8V7g5t3vC4cMVukk+s=;
 b=DBN1PcuTae0rhh2hHDJRRqrWTIzwk3uhxYpvUHUeko1rkb/T1eM7kOAz
 Gv6sv7Jlyxdn36TxdVkuaknKfEpboux/HgyP1FtddmrJbYLrUoT7xESGX
 YUmnLVmWzNpPlBm9Gyvr3uEA0SugCXVr5nmBWb1sSpJBn6d4bF6Uhu+g7
 F5inb5Sz3C5bsV1ExQuIsdxkEj2hcaTYTur04yDBRqcc/0eWQKzW4/rQp
 xGxykv/SKr8uNOFDuZjOD3dt/9j35kFyHs5CXEKTgA0Va6m4oCSfznW+o
 xP15EyCWYjLnQ9FVbJGPK72CsfuwTOd3OFcJPElqwAIsFnoolZ2y9ahvO g==;
X-CSE-ConnectionGUID: HhsjA49ESvKK5DUlDBnJ9w==
X-CSE-MsgGUID: ow6KPQ+uQXydLwnImSoiGQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11133"; a="35809854"
X-IronPort-AV: E=Sophos;i="6.09,209,1716274800"; d="scan'208";a="35809854"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
 by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 14 Jul 2024 21:34:37 -0700
X-CSE-ConnectionGUID: mkQ7gO4nQv6RF0012GTDWg==
X-CSE-MsgGUID: C+xQ9yLOT4aENov63PuQ8A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.09,209,1716274800"; d="scan'208";a="54043096"
Received: from liuzhao-optiplex-7080.sh.intel.com ([10.239.160.36])
 by fmviesa004.fm.intel.com with ESMTP; 14 Jul 2024 21:34:33 -0700
From: Zhao Liu <zhao1.liu@intel.com>
To: Paolo Bonzini <pbonzini@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Eduardo Habkost <eduardo@habkost.net>,
 "Michael S . Tsirkin" <mst@redhat.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Marcelo Tosatti <mtosatti@redhat.com>
Cc: Xiaoyao Li <xiaoyao.li@intel.com>, Pankaj Gupta <pankaj.gupta@amd.com>,
 Zide Chen <zide.chen@intel.com>, qemu-devel@nongnu.org,
 kvm@vger.kernel.org, Zhao Liu <zhao1.liu@intel.com>
Subject: [PATCH v3 6/8] target/i386/confidential-guest: Fix comment of
 x86_confidential_guest_kvm_type()
Date: Mon, 15 Jul 2024 12:49:53 +0800
Message-Id: <20240715044955.3954304-7-zhao1.liu@intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240715044955.3954304-1-zhao1.liu@intel.com>
References: <20240715044955.3954304-1-zhao1.liu@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=198.175.65.10; envelope-from=zhao1.liu@intel.com;
 helo=mgamail.intel.com
X-Spam_score_int: -43
X-Spam_score: -4.4
X-Spam_bar: ----
X-Spam_report: (-4.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, SPF_HELO_NONE=0.001,
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

Update the comment to match the X86ConfidentialGuestClass
implementation.

Reported-by: Xiaoyao Li <xiaoyao.li@intel.com>
Signed-off-by: Zhao Liu <zhao1.liu@intel.com>
Reviewed-by: Pankaj Gupta <pankaj.gupta@amd.com>
---
 target/i386/confidential-guest.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/target/i386/confidential-guest.h b/target/i386/confidential-guest.h
index 7342d2843aa5..c90a59bac41a 100644
--- a/target/i386/confidential-guest.h
+++ b/target/i386/confidential-guest.h
@@ -46,7 +46,7 @@ struct X86ConfidentialGuestClass {
 /**
  * x86_confidential_guest_kvm_type:
  *
- * Calls #X86ConfidentialGuestClass.unplug callback of @plug_handler.
+ * Calls #X86ConfidentialGuestClass.kvm_type() callback.
  */
 static inline int x86_confidential_guest_kvm_type(X86ConfidentialGuest *cg)
 {
-- 
2.34.1


