Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F1367C3ABCC
	for <qemu-devel@archiver.kernel.org>; Tue, 13 May 2025 14:11:31 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uEqLA-0006p3-2I; Tue, 13 May 2025 10:10:40 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1uEqL7-0006ck-G7
 for qemu-devel@nongnu.org; Tue, 13 May 2025 10:10:38 -0400
Received: from mgamail.intel.com ([198.175.65.12])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1uEqL4-0004X8-Vn
 for qemu-devel@nongnu.org; Tue, 13 May 2025 10:10:37 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1747145435; x=1778681435;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=IywGN8iS91I+KpKFILARN0JiAFwB/AfNeLchq7nT2Os=;
 b=bu8NXhWAbfhHtlrz+ExLjAwLkSgGgwc9z21tXa1E3L54HI2DApK6WmmH
 pzdCim9917ZkRKKS0W56gHOqpAL/OEPXmytQMJUlPq0orqF9wJ3nXtEM5
 aP0A7e9BGEhIgQ4qr5HHMr/pmhxmz9HmInRp7y5LVkShqBN669hKRPNw4
 KZGV8R6HMiL+DEg5UTdvDJsQjlzLvSXDyspLhK2+Hf+oDevmVaSy9m71P
 UxpOk4hrX5HUa8nUJdLdE0BkzKYMoVWpNWDtlyBNJmPzNydmV+MLKgSUz
 z5tNNAjSJ37QZLBbKaVFeHXsKijOV4aL5rzs/nXKwaqNqLVHbiHtKeaBm A==;
X-CSE-ConnectionGUID: uOjzHMitQAOmEGBmK2T61w==
X-CSE-MsgGUID: hV9g5+LYRxeRGKCj86DWmw==
X-IronPort-AV: E=McAfee;i="6700,10204,11431"; a="60393337"
X-IronPort-AV: E=Sophos;i="6.15,285,1739865600"; d="scan'208";a="60393337"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
 by orvoesa104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 13 May 2025 07:10:32 -0700
X-CSE-ConnectionGUID: lYxrU7gKQKCxWoFIwlBPrA==
X-CSE-MsgGUID: gV3uekk0Q9WkkPVZ6v9INA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,285,1739865600"; d="scan'208";a="138132790"
Received: from liuzhao-optiplex-7080.sh.intel.com ([10.239.160.39])
 by fmviesa008.fm.intel.com with ESMTP; 13 May 2025 07:10:30 -0700
From: Zhao Liu <zhao1.liu@intel.com>
To: Markus Armbruster <armbru@redhat.com>, Eric Blake <eblake@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>
Cc: qemu-devel@nongnu.org,
	Zhao Liu <zhao1.liu@intel.com>
Subject: [PATCH 2/2] qapi/misc-target: Fix the doc to distinguish query-sgx
 and query-sgx-capabilities
Date: Tue, 13 May 2025 22:31:31 +0800
Message-Id: <20250513143131.2008078-3-zhao1.liu@intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250513143131.2008078-1-zhao1.liu@intel.com>
References: <20250513143131.2008078-1-zhao1.liu@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=198.175.65.12; envelope-from=zhao1.liu@intel.com;
 helo=mgamail.intel.com
X-Spam_score_int: -58
X-Spam_score: -5.9
X-Spam_bar: -----
X-Spam_report: (-5.9 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.549,
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

There're 2 QMP commands: query-sgx and query-sgx-capabilities, but
their outputs are very similar and the documentation lacks clear
differentiation.

From the codes, query-sgx is used to gather guest's SGX capabilities
(including SGX related CPUIDs and EPC sections' size, in SGXInfo), and
if guest doesn't have SGX, then QEMU will report the error message.

On the other hand, query-sgx-capabilities is used to gather host's SGX
capabilities (descripted by SGXInfo as well). And if host doesn't
support SGX, then QEMU will also report the error message.

Considering that SGXInfo is already documented and both these 2 commands
have enough error messages (for the exception case in their codes).

Therefore the QAPI documentation for these two commands only needs to
emphasize that one of them applies to the guest and the other to the
host.

Fix their documentation to reflect this difference.

Reported-by: Markus Armbruster <armbru@redhat.com>
Suggested-by: Paolo Bonzini <pbonzini@redhat.com>
Signed-off-by: Zhao Liu <zhao1.liu@intel.com>
---
 qapi/misc-target.json | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/qapi/misc-target.json b/qapi/misc-target.json
index ed5b7db1bd2a..903863e8d0c2 100644
--- a/qapi/misc-target.json
+++ b/qapi/misc-target.json
@@ -361,7 +361,7 @@
 ##
 # @query-sgx:
 #
-# Returns information about SGX
+# Returns information about configured SGX capabilities of guest
 #
 # Returns: @SGXInfo
 #
@@ -380,7 +380,7 @@
 ##
 # @query-sgx-capabilities:
 #
-# Returns information from host SGX capabilities
+# Returns information about SGX capabilities of host
 #
 # Returns: @SGXInfo
 #
-- 
2.34.1


