Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4EF25C61CE8
	for <qemu-devel@archiver.kernel.org>; Fri,  6 Jun 2025 09:29:07 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uNTN6-0005o9-JQ; Fri, 06 Jun 2025 05:28:20 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhenzhong.duan@intel.com>)
 id 1uNTN3-0005n8-AV
 for qemu-devel@nongnu.org; Fri, 06 Jun 2025 05:28:18 -0400
Received: from mgamail.intel.com ([198.175.65.14])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhenzhong.duan@intel.com>)
 id 1uNTMx-0001A3-Ri
 for qemu-devel@nongnu.org; Fri, 06 Jun 2025 05:28:16 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1749202092; x=1780738092;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=Q1xJF8Ah52Uw0aW5slqBi90Q1Dc1bkj0gSplaCj/C9o=;
 b=ZdwxsW9OGEQ3HwhetzsXeuKSeKpD/rD92E5EqIUqEgYaYU2SCSKedB56
 6dYxZWKPZJmYchhGwlSMAmzNk7Uqzpr99BURbG1KBK9DUiZ2DWmt8H0Yv
 r7eC0eSj/FJlQiyppVSbbe2W0Muoc0bw5sELJ9xLQd2oChAfxVV2XBoWN
 sWqNw4o6pDLAENpg0U4eB5ymIcM+mO37357Cx8ISAxIhxvxtuI1EJqLik
 bBss28qZDCD9TnE/XBWHSIZ39dm/1KLcmPRb6s7ZJXn6CXwMDS/cvOZCg
 R02q5rtw/wsRW0mF4LFJHCZxMjuH4q8CsWG/KZ2aEO7tM3OIVurSK7vhZ g==;
X-CSE-ConnectionGUID: 2vyaXakpTYiGQMkwV57krQ==
X-CSE-MsgGUID: 6/ohapU0RPaiPyNNrtb1zw==
X-IronPort-AV: E=McAfee;i="6800,10657,11455"; a="55154654"
X-IronPort-AV: E=Sophos;i="6.16,214,1744095600"; d="scan'208";a="55154654"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
 by orvoesa106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 06 Jun 2025 02:28:06 -0700
X-CSE-ConnectionGUID: fDIAfB33T620Eid2LPajcw==
X-CSE-MsgGUID: T0FLjf4JQueofwAbtEc4Zw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,214,1744095600"; d="scan'208";a="145706195"
Received: from spr-s2600bt.bj.intel.com ([10.240.192.127])
 by fmviesa007-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 06 Jun 2025 02:28:03 -0700
From: Zhenzhong Duan <zhenzhong.duan@intel.com>
To: qemu-devel@nongnu.org
Cc: chao.p.peng@intel.com, david@redhat.com, armbru@redhat.com,
 Zhenzhong Duan <zhenzhong.duan@intel.com>,
 Yoshinori Sato <ysato@users.sourceforge.jp>,
 Magnus Damm <magnus.damm@gmail.com>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>
Subject: [PATCH v4 4/5] hw/char/sh_serial: Remove dummy definition of
 SH_SERIAL class
Date: Fri,  6 Jun 2025 17:24:05 +0800
Message-Id: <20250606092406.229833-5-zhenzhong.duan@intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250606092406.229833-1-zhenzhong.duan@intel.com>
References: <20250606092406.229833-1-zhenzhong.duan@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=198.175.65.14;
 envelope-from=zhenzhong.duan@intel.com; helo=mgamail.intel.com
X-Spam_score_int: -44
X-Spam_score: -4.5
X-Spam_bar: ----
X-Spam_report: (-4.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.132,
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


