Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8D534C0218C
	for <qemu-devel@archiver.kernel.org>; Tue, 21 Jan 2025 15:25:58 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1taG7u-00079x-7k; Tue, 21 Jan 2025 10:25:14 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1taG7g-000765-AG; Tue, 21 Jan 2025 10:25:02 -0500
Received: from mgamail.intel.com ([192.198.163.18])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1taG7Y-0004q4-1K; Tue, 21 Jan 2025 10:24:54 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1737473092; x=1769009092;
 h=from:to:cc:subject:date:message-id:mime-version:
 content-transfer-encoding;
 bh=sBoM8VbyjbRHsxpBifS88o/i94+X4mAgrq2AfHsN/rE=;
 b=Z/lOlw5HkPGCHLbFWvZkUmTB/PAUfQBc7+Xb/Nuj/MXPEP5o8CZ2PSeL
 /SxeA8dwbwqQidS3QMaQ0u5uQwg7SyVc7Ta5iBu8Cgi9LXsVbmHeDMC+p
 WX6KtMOjHTBwykEbjvz02b/LbbtVKrLbf9JFaYTKj0sPVsZs8r30HggHt
 cTwvuyEkT8DqY6uThUZNGQWjhec2BBtEPfFYFcq+tHKphCBF7/qfSUMAb
 pY9nT14pX6bf2Q6AqaFGEA1m7SQ588ajlAQhJ92LcCtTIqmCBiinVKe7g
 K+Vi2YIi/711XFRBynSSTL0YyDiDBw/pM2TiWILBQwPCq+4qQNuYSegCf w==;
X-CSE-ConnectionGUID: f6ffFvUjToCMRVjp547ffw==
X-CSE-MsgGUID: bZjqfgO1RuWmV99IRcUC7g==
X-IronPort-AV: E=McAfee;i="6700,10204,11322"; a="37161725"
X-IronPort-AV: E=Sophos;i="6.13,222,1732608000"; d="scan'208";a="37161725"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
 by fmvoesa112.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 21 Jan 2025 07:24:48 -0800
X-CSE-ConnectionGUID: HGrUpOkKRouOSlElOm+adw==
X-CSE-MsgGUID: ngnpjfRBQ2y6Om3ZGv162w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,224,1728975600"; d="scan'208";a="144089178"
Received: from liuzhao-optiplex-7080.sh.intel.com ([10.239.160.39])
 by orviesa001.jf.intel.com with ESMTP; 21 Jan 2025 07:24:47 -0800
From: Zhao Liu <zhao1.liu@intel.com>
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: qemu-devel@nongnu.org, Zhao Liu <zhao1.liu@intel.com>,
 qemu-stable@nongnu.org
Subject: [PATCH] stub: Fix build failure with --enable-user --disable-system
 --enable-tools
Date: Tue, 21 Jan 2025 23:43:18 +0800
Message-Id: <20250121154318.214680-1-zhao1.liu@intel.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=192.198.163.18; envelope-from=zhao1.liu@intel.com;
 helo=mgamail.intel.com
X-Spam_score_int: -73
X-Spam_score: -7.4
X-Spam_bar: -------
X-Spam_report: (-7.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-2.996,
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

Configuring "--enable-user --disable-system --enable-tools" causes the
build failure with the following information:

/usr/bin/ld: libhwcore.a.p/hw_core_qdev.c.o: in function `device_finalize':
/qemu/build/../hw/core/qdev.c:688: undefined reference to `qapi_event_send_device_deleted'
collect2: error: ld returned 1 exit status

To fix the above issue, add qdev.c stub when build with `have_tools`.

With this fix, QEMU could be successfully built in the following cases:
 --enable-user --disable-system --enable-tools
 --enable-user --disable-system --disable-tools
 --enable-user --disable-system

Cc: qemu-stable@nongnu.org
Fixes: 388b849fb6c3 ("stubs: avoid duplicate symbols in libqemuutil.a")
Resolves: https://gitlab.com/qemu-project/qemu/-/issues/2766
Signed-off-by: Zhao Liu <zhao1.liu@intel.com>
---
 stubs/meson.build | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/stubs/meson.build b/stubs/meson.build
index e91614a874dc..a8b3aeb56450 100644
--- a/stubs/meson.build
+++ b/stubs/meson.build
@@ -57,8 +57,8 @@ if have_user
   stub_ss.add(files('cpu-synchronize-state.c'))
 
   # Stubs for QAPI events.  Those can always be included in the build, but
-  # they are not built at all for --disable-system --disable-tools builds.
-  if not (have_system or have_tools)
+  # they are not built at all for --disable-system builds.
+  if not have_system
     stub_ss.add(files('qdev.c'))
   endif
 endif
-- 
2.34.1


