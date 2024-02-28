Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2CA81C5478C
	for <qemu-devel@archiver.kernel.org>; Wed, 28 Feb 2024 16:25:50 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rfMis-0003rU-7d; Wed, 28 Feb 2024 11:23:58 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@linux.intel.com>)
 id 1rfMip-0003qZ-Ux; Wed, 28 Feb 2024 11:23:55 -0500
Received: from mgamail.intel.com ([192.198.163.7])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@linux.intel.com>)
 id 1rfMio-0000kj-2e; Wed, 28 Feb 2024 11:23:55 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1709137434; x=1740673434;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=ph7yx45DpHdKw7PwqnWGdtJMzif59rJ5VMJHMtnScN4=;
 b=etBsxr4UU4Uo5lqwRzhw7r4amZ6R3zPQmRZGFqN7xYoK9f/12hpdopSE
 kbqRAZ/2MEEcj8B3tp3Yjq8cPop0d+Wr/61bGa+LmLzfOFPaklWbAFXKX
 lZwIMFYjHXq9xi67Qt7o1Zk3mDYpRfjBgLlY+1FOQqVBMHrthXzrLG0Iz
 WGyTlub3U0o55ow9xZ3XnA+q3A+ZyeotFieSuuwO1Ht+EEQ7N1qwVxGNL
 kpErF4ggkISBCWrro7b1RmviYPNNRGwvM2vQfRviyq9O8JyHvGlle9aKG
 gNX3HbWOBjYIdTnICZGtjV0VwBeU1oG0XgfQ2/wheL1TCGHV8NV/2GoEi Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10998"; a="28982411"
X-IronPort-AV: E=Sophos;i="6.06,190,1705392000"; d="scan'208";a="28982411"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
 by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 28 Feb 2024 08:23:50 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.06,190,1705392000"; d="scan'208";a="12144802"
Received: from liuzhao-optiplex-7080.sh.intel.com ([10.239.160.36])
 by orviesa004.jf.intel.com with ESMTP; 28 Feb 2024 08:23:48 -0800
From: Zhao Liu <zhao1.liu@linux.intel.com>
To: Markus Armbruster <armbru@redhat.com>, Michael Roth <michael.roth@amd.com>,
 Michael Tokarev <mjt@tls.msk.ru>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org
Cc: qemu-trivial@nongnu.org,
	Zhao Liu <zhao1.liu@intel.com>
Subject: [PATCH 01/16] error: Add error_vprepend() in comment of ERRP_GUARD()
 rules
Date: Thu, 29 Feb 2024 00:37:08 +0800
Message-Id: <20240228163723.1775791-2-zhao1.liu@linux.intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240228163723.1775791-1-zhao1.liu@linux.intel.com>
References: <20240228163723.1775791-1-zhao1.liu@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: none client-ip=192.198.163.7;
 envelope-from=zhao1.liu@linux.intel.com; helo=mgamail.intel.com
X-Spam_score_int: 4
X-Spam_score: 0.4
X-Spam_bar: /
X-Spam_report: (0.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.102,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_MSPIKE_H2=-0.001,
 SORTED_RECIPS=2.499, SPF_HELO_NONE=0.001, SPF_NONE=0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=no autolearn_force=no
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

From: Zhao Liu <zhao1.liu@intel.com>

The error_vprepend() should use ERRP_GUARD() just as the documentation
of ERRP_GUARD() says:

> It must be used when the function dereferences @errp or passes
> @errp to error_prepend(), error_vprepend(), or error_append_hint().

Considering that error_vprepend() is also an API provided in error.h,
it is necessary to add it to the description of the rules for using
ERRP_GUARD().

Signed-off-by: Zhao Liu <zhao1.liu@intel.com>
---
 include/qapi/error.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/qapi/error.h b/include/qapi/error.h
index f21a231bb1a6..b1b389967f92 100644
--- a/include/qapi/error.h
+++ b/include/qapi/error.h
@@ -207,7 +207,7 @@
  *
  * Without ERRP_GUARD(), use of the @errp parameter is restricted:
  * - It must not be dereferenced, because it may be null.
- * - It should not be passed to error_prepend() or
+ * - It should not be passed to error_prepend(), error_vprepend() or
  *   error_append_hint(), because that doesn't work with &error_fatal.
  * ERRP_GUARD() lifts these restrictions.
  *
-- 
2.34.1


