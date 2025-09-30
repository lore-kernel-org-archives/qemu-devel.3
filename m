Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4AE34CAC5B9
	for <qemu-devel@archiver.kernel.org>; Tue, 30 Sep 2025 07:33:11 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v3UqM-0003gJ-LT; Tue, 30 Sep 2025 03:32:14 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1v3UqJ-0003fg-IG; Tue, 30 Sep 2025 03:32:12 -0400
Received: from mgamail.intel.com ([198.175.65.21])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1v3UqF-0000wo-HB; Tue, 30 Sep 2025 03:32:11 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1759217527; x=1790753527;
 h=from:to:cc:subject:date:message-id:mime-version:
 content-transfer-encoding;
 bh=tyL90xQ/psWNfhHyJbOAxWbUINQafqkHOjy+g6gz1hQ=;
 b=PxHRojvfNDyae+PmuauT77PTLw8wRXndC7UmYpYHYhSUeI0sMOtNQiUl
 ZtcDonxiG6oPrg+26xaN2ns5lR0BgONiiCjDXo/b8KBiGcUnE6HdQXGFU
 H/ZnFlnBnzf/jqxMNYQhshXdkbcUzFk9Sqy3r4xgF/wk3zHJ72WbHSuxe
 yJgFlWMf7wZtVlSl2Wfj26R8TsOEssVnAemlvOaiTWCw6MondTXI2xELf
 ccl4eZcKkJk5WD5YkXdhBAznSv3sCmku6EPEW3x6UdOCjfJGyUZKep2jE
 OYUF6yqLIt1ZazH287yZxb7uaL92H06uNJ1wS/wq0JUxcjuNE9nfK/5vu g==;
X-CSE-ConnectionGUID: zgcBYmQHQISCA4eaU+036A==
X-CSE-MsgGUID: GQGxbOBwSmqcKkzSgK3suQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11531"; a="61380988"
X-IronPort-AV: E=Sophos;i="6.17,312,1747724400"; d="scan'208";a="61380988"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
 by orvoesa113.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 30 Sep 2025 00:31:58 -0700
X-CSE-ConnectionGUID: /VdAs/3MQgauh9/d1mRJrA==
X-CSE-MsgGUID: eDPr56yCTW6fy8hSeaDruA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.18,303,1751266800"; d="scan'208";a="177579608"
Received: from liuzhao-optiplex-7080.sh.intel.com ([10.239.160.39])
 by orviesa006.jf.intel.com with ESMTP; 30 Sep 2025 00:31:57 -0700
From: Zhao Liu <zhao1.liu@intel.com>
To: Paolo Bonzini <pbonzini@redhat.com>,
 Manos Pitsidianakis <manos.pitsidianakis@linaro.org>
Cc: qemu-devel@nongnu.org, qemu-rust@nongnu.org, Zhao Liu <zhao1.liu@intel.com>
Subject: [PATCH] subprojects: Update .gitignore for syn
Date: Tue, 30 Sep 2025 15:53:51 +0800
Message-Id: <20250930075351.1853721-1-zhao1.liu@intel.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=198.175.65.21; envelope-from=zhao1.liu@intel.com;
 helo=mgamail.intel.com
X-Spam_score_int: -48
X-Spam_score: -4.9
X-Spam_bar: ----
X-Spam_report: (-4.9 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.513,
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

The commit a530a8d4ac39 missed to update syn version, this is because
the code base of its v2 patch has fixed syn version, so that the fix for
syn were lost during the rebase from v1 to v2.

To rectify this mistake, update the syn version.

Fixes: a530a8d4ac39 ("subprojects: Update .gitignore for proc-macro2 and syn")
Signed-off-by: Zhao Liu <zhao1.liu@intel.com>
---
 subprojects/.gitignore | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/subprojects/.gitignore b/subprojects/.gitignore
index 58a29f012044..136e30cd99ad 100644
--- a/subprojects/.gitignore
+++ b/subprojects/.gitignore
@@ -19,7 +19,7 @@
 /proc-macro-error-attr-1.0.4
 /proc-macro2-1.0.95
 /quote-1.0.36
-/syn-2.0.66
+/syn-2.0.104
 /unicode-ident-1.0.12
 
 # Workaround for Meson v1.9.0 https://github.com/mesonbuild/meson/issues/14948
-- 
2.34.1


