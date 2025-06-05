Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 21356C5B543
	for <qemu-devel@archiver.kernel.org>; Thu,  5 Jun 2025 10:28:36 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uN7oy-0001hv-1y; Thu, 05 Jun 2025 06:27:41 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhenzhong.duan@intel.com>)
 id 1uN7oX-0001dG-G2
 for qemu-devel@nongnu.org; Thu, 05 Jun 2025 06:27:16 -0400
Received: from mgamail.intel.com ([192.198.163.14])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhenzhong.duan@intel.com>)
 id 1uN7oV-00054A-1N
 for qemu-devel@nongnu.org; Thu, 05 Jun 2025 06:27:12 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1749119231; x=1780655231;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=Q1xJF8Ah52Uw0aW5slqBi90Q1Dc1bkj0gSplaCj/C9o=;
 b=Q7hWL0sIzC0A7weKEquGLzjKuWMp9K9EQSDhMVaM8EiWUuddYXJelAO0
 aTnjjPzvyGZs28zZOX1O6qKdA5XQpJzOH5SkMwEmxL4ueQSiTWncQoUhs
 L8xkM+RJkue0KnHyQMQ8FbH1cnYV8vkFid2fEuq1ZrGDInGegp0GCriVc
 rsgNg2S5cV/1m8lbsfGMiSLHKaeuvUZOF2N7GgUHZ8dtE1HpvDeTQgrtr
 nHvkbc3vZwRtUxaRQrx+D1sBLHqWlEUg0Bd452tX3T1UdW4Q4NTSmpAc2
 5mXh8q7z0fk8QlGb1ctmq/lx7ZEFk40UGhyVKb3pjXQxvUuZ1JkFarftx Q==;
X-CSE-ConnectionGUID: 2o5rNx4TRW+D5AvHMoCn2w==
X-CSE-MsgGUID: ZlZttwJWS/uElnlYhs9w1Q==
X-IronPort-AV: E=McAfee;i="6800,10657,11454"; a="51325337"
X-IronPort-AV: E=Sophos;i="6.16,211,1744095600"; d="scan'208";a="51325337"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
 by fmvoesa108.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 05 Jun 2025 03:27:09 -0700
X-CSE-ConnectionGUID: M7+t4JrpTTmcYiZprAZkHg==
X-CSE-MsgGUID: FBK4F8mMR5mI+G3kbd9OlA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,211,1744095600"; d="scan'208";a="145808672"
Received: from spr-s2600bt.bj.intel.com ([10.240.192.127])
 by fmviesa008-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 05 Jun 2025 03:27:07 -0700
From: Zhenzhong Duan <zhenzhong.duan@intel.com>
To: qemu-devel@nongnu.org
Cc: chao.p.peng@intel.com, david@redhat.com,
 Zhenzhong Duan <zhenzhong.duan@intel.com>,
 Yoshinori Sato <ysato@users.sourceforge.jp>,
 Magnus Damm <magnus.damm@gmail.com>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>
Subject: [PATCH v3 4/5] hw/char/sh_serial: Remove dummy definition of
 SH_SERIAL class
Date: Thu,  5 Jun 2025 18:23:10 +0800
Message-Id: <20250605102311.148171-5-zhenzhong.duan@intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250605102311.148171-1-zhenzhong.duan@intel.com>
References: <20250605102311.148171-1-zhenzhong.duan@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=192.198.163.14;
 envelope-from=zhenzhong.duan@intel.com; helo=mgamail.intel.com
X-Spam_score_int: -44
X-Spam_score: -4.5
X-Spam_bar: ----
X-Spam_report: (-4.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.128,
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

SH_SERIAL is declared with OBJECT_DECLARE_SIMPLE_TYPE but defined with
OBJECT_DEFINE_TYPE, SHSerialStateClass is also a dummy class which
missed its parent.

Change to use OBJECT_DEFINE_SIMPLE_TYPE and remove SHSerialStateClass.

Closes: https://lists.gnu.org/archive/html/qemu-devel/2025-06/msg00586.html
Suggested-by: David Hildenbrand <david@redhat.com>
Signed-off-by: Zhenzhong Duan <zhenzhong.duan@intel.com>
---
 hw/char/sh_serial.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/hw/char/sh_serial.c b/hw/char/sh_serial.c
index 6abd80386f..8ccc2234ba 100644
--- a/hw/char/sh_serial.c
+++ b/hw/char/sh_serial.c
@@ -78,9 +78,7 @@ struct SHSerialState {
     qemu_irq bri;
 };
 
-typedef struct {} SHSerialStateClass;
-
-OBJECT_DEFINE_TYPE(SHSerialState, sh_serial, SH_SERIAL, SYS_BUS_DEVICE)
+OBJECT_DEFINE_SIMPLE_TYPE(SHSerialState, sh_serial, SH_SERIAL, SYS_BUS_DEVICE)
 
 static void sh_serial_clear_fifo(SHSerialState *s)
 {
-- 
2.34.1


