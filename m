Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A4D25C3ABC9
	for <qemu-devel@archiver.kernel.org>; Fri, 16 May 2025 08:51:09 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uFqm4-0005bz-Lu; Fri, 16 May 2025 04:50:36 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1uFqm1-0005X7-HI
 for qemu-devel@nongnu.org; Fri, 16 May 2025 04:50:33 -0400
Received: from mgamail.intel.com ([198.175.65.17])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1uFqlz-0007Az-Cu
 for qemu-devel@nongnu.org; Fri, 16 May 2025 04:50:33 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1747385432; x=1778921432;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=cZtwxIm46YJokOPKmFGuC++VN5X309opFf0akpU1FL4=;
 b=mdxHUlTC92tdL4HTmshPIwhA7D32bnlNACTGkyXS9ja6XF2hIJSzrHNN
 f+uIpUpFNRFeVgCs9ydi8Qz9I/KiB+Df46OGP4slWPI8sA6fzlXRU0/tV
 hS34OYxOyi7r5YUxjrtUfn8eGNP+URFsckgqfiyb6o227acER6cWzdQUA
 GICkClDnQlllw9+2HRgQbsbJm7+Ij0uCygaSVdXk+w7cL5u1jTdndP8rK
 j02oFqZX8rhtrVBKlBTInAYpJfPHOz2XCoNHBHrabFXXznMB9FE+SrBtU
 plSc737mExWBQycggsuFhRU21jeXYpVFOG6g9pY/VjZq8wRxhOkxxk0Ue A==;
X-CSE-ConnectionGUID: LZmCVZwLROK/6IsYDbkk9w==
X-CSE-MsgGUID: V098ijnZQzuWz4m826s3Mw==
X-IronPort-AV: E=McAfee;i="6700,10204,11434"; a="49334661"
X-IronPort-AV: E=Sophos;i="6.15,293,1739865600"; d="scan'208";a="49334661"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
 by orvoesa109.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 16 May 2025 01:50:30 -0700
X-CSE-ConnectionGUID: 8zLRHYjgSuC82bJIKtw7kQ==
X-CSE-MsgGUID: vrZigaU3SLWaDn5VJCiWLA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,293,1739865600"; d="scan'208";a="161939656"
Received: from liuzhao-optiplex-7080.sh.intel.com ([10.239.160.39])
 by fmviesa002.fm.intel.com with ESMTP; 16 May 2025 01:50:28 -0700
From: Zhao Liu <zhao1.liu@intel.com>
To: Markus Armbruster <armbru@redhat.com>, Eric Blake <eblake@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>
Cc: qemu-devel@nongnu.org,
	Zhao Liu <zhao1.liu@intel.com>
Subject: [PATCH 2/2] qapi/misc-target: Rename SGXInfo to SgxInfo
Date: Fri, 16 May 2025 17:11:30 +0800
Message-Id: <20250516091130.2374221-3-zhao1.liu@intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250516091130.2374221-1-zhao1.liu@intel.com>
References: <20250516091130.2374221-1-zhao1.liu@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=198.175.65.17; envelope-from=zhao1.liu@intel.com;
 helo=mgamail.intel.com
X-Spam_score_int: -60
X-Spam_score: -6.1
X-Spam_bar: ------
X-Spam_report: (-6.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.686,
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

QAPI requires strict PascalCase naming style, i.e., only the first
letter of a single word is allowed to be uppercase, which could help
with readability.

Rename SGXInfo to SgxInfo.

Signed-off-by: Zhao Liu <zhao1.liu@intel.com>
---
 hw/i386/sgx-stub.c    |  4 ++--
 hw/i386/sgx.c         | 14 +++++++-------
 qapi/misc-target.json | 12 ++++++------
 3 files changed, 15 insertions(+), 15 deletions(-)

diff --git a/hw/i386/sgx-stub.c b/hw/i386/sgx-stub.c
index 38ff75e9f377..ccb21a975d76 100644
--- a/hw/i386/sgx-stub.c
+++ b/hw/i386/sgx-stub.c
@@ -10,13 +10,13 @@ void sgx_epc_build_srat(GArray *table_data)
 {
 }
 
-SGXInfo *qmp_query_sgx(Error **errp)
+SgxInfo *qmp_query_sgx(Error **errp)
 {
     error_setg(errp, "SGX support is not compiled in");
     return NULL;
 }
 
-SGXInfo *qmp_query_sgx_capabilities(Error **errp)
+SgxInfo *qmp_query_sgx_capabilities(Error **errp)
 {
     error_setg(errp, "SGX support is not compiled in");
     return NULL;
diff --git a/hw/i386/sgx.c b/hw/i386/sgx.c
index 3c601689eb72..c80203b438ec 100644
--- a/hw/i386/sgx.c
+++ b/hw/i386/sgx.c
@@ -153,9 +153,9 @@ static void sgx_epc_reset(void *opaque)
      }
 }
 
-SGXInfo *qmp_query_sgx_capabilities(Error **errp)
+SgxInfo *qmp_query_sgx_capabilities(Error **errp)
 {
-    SGXInfo *info = NULL;
+    SgxInfo *info = NULL;
     uint32_t eax, ebx, ecx, edx;
     Error *local_err = NULL;
 
@@ -166,7 +166,7 @@ SGXInfo *qmp_query_sgx_capabilities(Error **errp)
         return NULL;
     }
 
-    info = g_new0(SGXInfo, 1);
+    info = g_new0(SgxInfo, 1);
     host_cpuid(0x7, 0, &eax, &ebx, &ecx, &edx);
 
     info->sgx = ebx & (1U << 2) ? true : false;
@@ -205,9 +205,9 @@ static SgxEpcSectionList *sgx_get_epc_sections_list(void)
     return head;
 }
 
-SGXInfo *qmp_query_sgx(Error **errp)
+SgxInfo *qmp_query_sgx(Error **errp)
 {
-    SGXInfo *info = NULL;
+    SgxInfo *info = NULL;
     X86MachineState *x86ms;
     PCMachineState *pcms =
         (PCMachineState *)object_dynamic_cast(qdev_get_machine(),
@@ -223,7 +223,7 @@ SGXInfo *qmp_query_sgx(Error **errp)
         return NULL;
     }
 
-    info = g_new0(SGXInfo, 1);
+    info = g_new0(SgxInfo, 1);
 
     info->sgx = true;
     info->sgx1 = true;
@@ -238,7 +238,7 @@ void hmp_info_sgx(Monitor *mon, const QDict *qdict)
 {
     Error *err = NULL;
     SgxEpcSectionList *section_list, *section;
-    g_autoptr(SGXInfo) info = qmp_query_sgx(&err);
+    g_autoptr(SgxInfo) info = qmp_query_sgx(&err);
     uint64_t size = 0;
 
     if (err) {
diff --git a/qapi/misc-target.json b/qapi/misc-target.json
index a1275d3873ab..6b3c9d8bd589 100644
--- a/qapi/misc-target.json
+++ b/qapi/misc-target.json
@@ -334,7 +334,7 @@
             'size': 'uint64'}}
 
 ##
-# @SGXInfo:
+# @SgxInfo:
 #
 # Information about intel Safe Guard eXtension (SGX) support
 #
@@ -350,7 +350,7 @@
 #
 # Since: 6.2
 ##
-{ 'struct': 'SGXInfo',
+{ 'struct': 'SgxInfo',
   'data': { 'sgx': 'bool',
             'sgx1': 'bool',
             'sgx2': 'bool',
@@ -363,7 +363,7 @@
 #
 # Returns information about SGX
 #
-# Returns: @SGXInfo
+# Returns: @SgxInfo
 #
 # Since: 6.2
 #
@@ -375,14 +375,14 @@
 #                      "sections": [{"node": 0, "size": 67108864},
 #                      {"node": 1, "size": 29360128}]} }
 ##
-{ 'command': 'query-sgx', 'returns': 'SGXInfo', 'if': 'TARGET_I386' }
+{ 'command': 'query-sgx', 'returns': 'SgxInfo', 'if': 'TARGET_I386' }
 
 ##
 # @query-sgx-capabilities:
 #
 # Returns information from host SGX capabilities
 #
-# Returns: @SGXInfo
+# Returns: @SgxInfo
 #
 # Since: 6.2
 #
@@ -394,7 +394,7 @@
 #                      "section" : [{"node": 0, "size": 67108864},
 #                      {"node": 1, "size": 29360128}]} }
 ##
-{ 'command': 'query-sgx-capabilities', 'returns': 'SGXInfo', 'if': 'TARGET_I386' }
+{ 'command': 'query-sgx-capabilities', 'returns': 'SgxInfo', 'if': 'TARGET_I386' }
 
 
 ##
-- 
2.34.1


