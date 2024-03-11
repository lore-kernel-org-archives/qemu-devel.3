Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B5B77C5475B
	for <qemu-devel@archiver.kernel.org>; Mon, 11 Mar 2024 03:25:30 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rjWHS-0005Xp-3F; Sun, 10 Mar 2024 23:24:50 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@linux.intel.com>)
 id 1rjWHP-0005W8-E3; Sun, 10 Mar 2024 23:24:47 -0400
Received: from mgamail.intel.com ([198.175.65.10])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@linux.intel.com>)
 id 1rjWHN-0007qJ-DL; Sun, 10 Mar 2024 23:24:47 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1710127485; x=1741663485;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=9u2qpUQw+97M2ytR4D9PH0ERtHP9EM+bxi7PUz1J0MM=;
 b=f+5F5Oh0AUwUKO3ZQFnhLZRafbXONiq4LZ7t91ncgJXDQFeujqgaUtCZ
 C8O2k3loJlSr86qOk9EjZqd2pfKV2mcokdlcUAhTiNiw/WZcaZbYgQssN
 Wdtd0JxQTU1F84hki38zLPApLk1MU482a2s/Hb46TTW1AzAPA65sud+l8
 pRsKldQP7BK8jL8Wm3qJ6QgaJnOf1h8UzeUaWjoGGb9Gpxq5H8N/IebZX
 Lut5YmP9PMUv4/PRTqJ+PxWYRmAeWzjwa8EsLJbBZzLwn6W2GlNO4YcrH
 cdvA7YtIpD7B5t/xQQ/alEGAcugpnKfZOeoB7XgivDv7yAjfMLK6pjzTP A==;
X-IronPort-AV: E=McAfee;i="6600,9927,11009"; a="22229576"
X-IronPort-AV: E=Sophos;i="6.07,115,1708416000"; d="scan'208";a="22229576"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
 by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 10 Mar 2024 20:24:43 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,115,1708416000"; d="scan'208";a="15593711"
Received: from liuzhao-optiplex-7080.sh.intel.com ([10.239.160.36])
 by fmviesa003.fm.intel.com with ESMTP; 10 Mar 2024 20:24:42 -0700
From: Zhao Liu <zhao1.liu@linux.intel.com>
To: Thomas Huth <thuth@redhat.com>, Markus Armbruster <armbru@redhat.com>,
 Michael Roth <michael.roth@amd.com>, Michael Tokarev <mjt@tls.msk.ru>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org
Cc: qemu-trivial@nongnu.org,
	Zhao Liu <zhao1.liu@intel.com>
Subject: [PATCH v2 01/29] error: Add error_vprepend() in comment of
 ERRP_GUARD() rules
Date: Mon, 11 Mar 2024 11:37:54 +0800
Message-Id: <20240311033822.3142585-2-zhao1.liu@linux.intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240311033822.3142585-1-zhao1.liu@linux.intel.com>
References: <20240311033822.3142585-1-zhao1.liu@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: none client-ip=198.175.65.10;
 envelope-from=zhao1.liu@linux.intel.com; helo=mgamail.intel.com
X-Spam_score_int: -29
X-Spam_score: -3.0
X-Spam_bar: ---
X-Spam_report: (-3.0 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.945,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_NONE=0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

Cc: Markus Armbruster <armbru@redhat.com>
Cc: Michael Roth <michael.roth@amd.com>
Signed-off-by: Zhao Liu <zhao1.liu@intel.com>
Reviewed-by: Markus Armbruster <armbru@redhat.com>
---
v2: Add a comma after error_vprepend(). (Markus)
---
 include/qapi/error.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/qapi/error.h b/include/qapi/error.h
index f21a231bb1a6..71f8fb2c50ee 100644
--- a/include/qapi/error.h
+++ b/include/qapi/error.h
@@ -207,7 +207,7 @@
  *
  * Without ERRP_GUARD(), use of the @errp parameter is restricted:
  * - It must not be dereferenced, because it may be null.
- * - It should not be passed to error_prepend() or
+ * - It should not be passed to error_prepend(), error_vprepend(), or
  *   error_append_hint(), because that doesn't work with &error_fatal.
  * ERRP_GUARD() lifts these restrictions.
  *
-- 
2.34.1


