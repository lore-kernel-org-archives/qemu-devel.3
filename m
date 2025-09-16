Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6C84DCAC599
	for <qemu-devel@archiver.kernel.org>; Tue, 16 Sep 2025 08:36:43 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uyR9G-0006z2-E5; Tue, 16 Sep 2025 04:34:50 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1uyR9E-0006xo-HY; Tue, 16 Sep 2025 04:34:48 -0400
Received: from mgamail.intel.com ([198.175.65.10])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1uyR9A-0005zs-L0; Tue, 16 Sep 2025 04:34:48 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1758011685; x=1789547685;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=waLJ79Z2ZxPOvRkgcef2yGkHILtwcEpwytE2aQ9sNt8=;
 b=kQYE2k9KCu1/S7Hd7L7B1uiICL45GpTwUaqcmNmpMWbLRE8+cqKVa5UZ
 JKk7d3aUHupNRXx0l2QPTarUuPXp62eE61kuJKtKysA4Ax21VN8QtoM4t
 eR05Jnf3Sh1inbKowNc1YCrE7jbhT6f1WNVrBReDJHOGE2Txm5F5pIkaI
 jOkT0LIVxK3qkcTmbW26gu5HPmfxiTiyTd5riDrP0LKb3mf7iNpBCfeQO
 /KKxr3EbVjlBFF3d2P7B3se9M2phTAdFDH2mbE9GgXHy9bJInjfIXf84F
 Buq/mDRVbj9G9IafRDDCOcAB2tByxYFhKOequfoERLGLMCZ/jl9n2hHV4 g==;
X-CSE-ConnectionGUID: KgDHgSVbQ0mMFGurNvVNsg==
X-CSE-MsgGUID: QkYjZcwRTdO7Q7qKphBk9g==
X-IronPort-AV: E=McAfee;i="6800,10657,11554"; a="77725201"
X-IronPort-AV: E=Sophos;i="6.18,268,1751266800"; d="scan'208";a="77725201"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
 by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 16 Sep 2025 01:34:28 -0700
X-CSE-ConnectionGUID: OoSbty66ScCOe6p/w/1OEw==
X-CSE-MsgGUID: zMOfhShATlKWLN2qdCebBQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.18,268,1751266800"; d="scan'208";a="174691118"
Received: from liuzhao-optiplex-7080.sh.intel.com ([10.239.160.39])
 by orviesa007.jf.intel.com with ESMTP; 16 Sep 2025 01:34:26 -0700
From: Zhao Liu <zhao1.liu@intel.com>
To: Paolo Bonzini <pbonzini@redhat.com>,
 Manos Pitsidianakis <manos.pitsidianakis@linaro.org>
Cc: qemu-devel@nongnu.org, qemu-rust@nongnu.org, Zhao Liu <zhao1.liu@intel.com>
Subject: [PATCH 10/12] rust/hpet: Clean up type mismatch for num_timers
 property
Date: Tue, 16 Sep 2025 16:55:55 +0800
Message-Id: <20250916085557.2008344-11-zhao1.liu@intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250916085557.2008344-1-zhao1.liu@intel.com>
References: <20250916085557.2008344-1-zhao1.liu@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=198.175.65.10; envelope-from=zhao1.liu@intel.com;
 helo=mgamail.intel.com
X-Spam_score_int: -43
X-Spam_score: -4.4
X-Spam_bar: ----
X-Spam_report: (-4.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.035,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, SPF_HELO_NONE=0.001,
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

Now `num_timers` is `usize` other than `u8`. Although the type field in
`declare_properties` macro hasn't been used, it's better to explicitly
point this out and clean up this before doing other property work.

Signed-off-by: Zhao Liu <zhao1.liu@intel.com>
---
 rust/hw/timer/hpet/src/device.rs | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/rust/hw/timer/hpet/src/device.rs b/rust/hw/timer/hpet/src/device.rs
index 3cfbe9c32bb1..fce75415579d 100644
--- a/rust/hw/timer/hpet/src/device.rs
+++ b/rust/hw/timer/hpet/src/device.rs
@@ -909,7 +909,7 @@ impl ObjectImpl for HPETState {
         HPETState,
         num_timers,
         unsafe { &qdev_prop_usize },
-        u8,
+        usize,
         default = HPET_MIN_TIMERS
     ),
     define_property!(
-- 
2.34.1


