Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4833CD3B9B7
	for <qemu-devel@archiver.kernel.org>; Tue, 26 Nov 2024 16:13:41 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tFyBP-0006sa-Vj; Tue, 26 Nov 2024 11:13:00 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1tFyBC-0006mX-2M; Tue, 26 Nov 2024 11:12:47 -0500
Received: from mgamail.intel.com ([192.198.163.16])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1tFyBA-0000fl-6T; Tue, 26 Nov 2024 11:12:45 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1732637564; x=1764173564;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=wTYR6sEj7FpEEgZC6d2tvMR+RRZObWL5PjGhWIrCUt8=;
 b=h6hnXYzX2IsLR4iUzgZzVdZuWvuWQeFdS8/3I1LwXukUITKCgnbQ3/Yr
 5NGHMLyXzLYZS/8t4aiPlUQGDd50BAcyTHmCN3rr5nkp3gd8wDUBrlfLo
 j+WN8xX7xj0iCc/WDcmZ+hxVm5/03+OPCI0E8pjQQVER2lsZaqGoAKkSl
 euFu2TvxdhNUZbQtSfCnSRHElsbXIkCnEXFF5ByGctRJqKXWw6MaHdWZp
 I8IXgdBmdqkW328Pc8tzOwM6FrelQwdzDvAngDU7D5U2qkhFzPcsmNqBx
 Lp61rlDbtjUxvVIjMc041kbUj7arSjioglc/BfZ6/wvUpYMsyNwg8RGyB g==;
X-CSE-ConnectionGUID: f7Awuw6WRFGGZEBrVVlScw==
X-CSE-MsgGUID: ZjOBy3F7Qhm6/HtoowB0vg==
X-IronPort-AV: E=McAfee;i="6700,10204,11268"; a="20399391"
X-IronPort-AV: E=Sophos;i="6.12,186,1728975600"; d="scan'208";a="20399391"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
 by fmvoesa110.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 26 Nov 2024 08:12:42 -0800
X-CSE-ConnectionGUID: YyO1dzIaRN6giLhVDvrs8Q==
X-CSE-MsgGUID: OWDh59O8S1OjuQo/xA8a3w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,186,1728975600"; d="scan'208";a="91277668"
Received: from liuzhao-optiplex-7080.sh.intel.com ([10.239.160.36])
 by fmviesa006.fm.intel.com with ESMTP; 26 Nov 2024 08:12:41 -0800
From: Zhao Liu <zhao1.liu@intel.com>
To: Paolo Bonzini <pbonzini@redhat.com>, "Michael S . Tsirkin" <mst@redhat.com>
Cc: qemu-devel@nongnu.org, qemu-trivial@nongnu.org,
 Zhao Liu <zhao1.liu@intel.com>
Subject: [PATCH 1/2] hw/timer/hpet: Fix comment about capabilities register
Date: Wed, 27 Nov 2024 00:30:45 +0800
Message-Id: <20241126163046.3344931-2-zhao1.liu@intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20241126163046.3344931-1-zhao1.liu@intel.com>
References: <20241126163046.3344931-1-zhao1.liu@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=192.198.163.16; envelope-from=zhao1.liu@intel.com;
 helo=mgamail.intel.com
X-Spam_score_int: -43
X-Spam_score: -4.4
X-Spam_bar: ----
X-Spam_report: (-4.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001, SPF_HELO_NONE=0.001,
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

HPETState.capability stores the emulated value for "general capabilities
and id register" instead of "main counter register".

Fix the comment to accurately reflect this.

Signed-off-by: Zhao Liu <zhao1.liu@intel.com>
---
 hw/timer/hpet.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/hw/timer/hpet.c b/hw/timer/hpet.c
index 5399f1b2a3f7..0f3dfe9f945b 100644
--- a/hw/timer/hpet.c
+++ b/hw/timer/hpet.c
@@ -736,7 +736,7 @@ static void hpet_realize(DeviceState *dev, Error **errp)
         timer->state = s;
     }
 
-    /* 64-bit main counter; LegacyReplacementRoute. */
+    /* 64-bit General Capabilities and ID Register; LegacyReplacementRoute. */
     s->capability = 0x8086a001ULL;
     s->capability |= (s->num_timers - 1) << HPET_ID_NUM_TIM_SHIFT;
     s->capability |= ((uint64_t)(HPET_CLK_PERIOD * FS_PER_NS) << 32);
-- 
2.34.1


