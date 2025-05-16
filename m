Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9EC0AC3ABC9
	for <qemu-devel@archiver.kernel.org>; Fri, 16 May 2025 08:51:15 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uFqm1-0005X8-UR; Fri, 16 May 2025 04:50:34 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1uFqm0-0005W7-Pe
 for qemu-devel@nongnu.org; Fri, 16 May 2025 04:50:32 -0400
Received: from mgamail.intel.com ([198.175.65.17])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1uFqlx-0007At-O9
 for qemu-devel@nongnu.org; Fri, 16 May 2025 04:50:32 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1747385430; x=1778921430;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=25m2XLfyCPE4Th4Ei2uPZUjYwK2mKIo1eCekumE2UQI=;
 b=j2dByZBcyNSO33CWUxVRYu5Acmdmv2rlDXkp/qoJ62gYhH+nuTcrt4H1
 j8VqZmd+/8U0FHgwI0L2ByOesINjugboPTKxu4eVViY0g9je5xbj2PlKZ
 vNd8R9hca7/HuaZPDKytCrY/40/vgmTaQCmEU/9VE1WSnsfhHcKu+c0/w
 KFSU0AdReyExBTrn9yvr15tYo230+YZ13EJSw/bM84uboon0Kag74w1zi
 Eb9HohiPY72Z6UrxSyHl3n8/G1rK9m/ki8Twuqk0ReA/hb2Ozy1yjKHRq
 cYVJJZXbFvA1YUPaeXsNTlJkROYgrm1KmduTqhQDHqX5RUZpf2Fi45LD2 g==;
X-CSE-ConnectionGUID: 4ra7xDgbS6GiEYEO8+4ugw==
X-CSE-MsgGUID: bZG1RyN4Qj2t27DZbd4oSw==
X-IronPort-AV: E=McAfee;i="6700,10204,11434"; a="49334657"
X-IronPort-AV: E=Sophos;i="6.15,293,1739865600"; d="scan'208";a="49334657"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
 by orvoesa109.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 16 May 2025 01:50:29 -0700
X-CSE-ConnectionGUID: xQ/tyx2KTQiEykHOQHQHyQ==
X-CSE-MsgGUID: 2Jsz15FnQbuqVvcnkesbWQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,293,1739865600"; d="scan'208";a="161939648"
Received: from liuzhao-optiplex-7080.sh.intel.com ([10.239.160.39])
 by fmviesa002.fm.intel.com with ESMTP; 16 May 2025 01:50:26 -0700
From: Zhao Liu <zhao1.liu@intel.com>
To: Markus Armbruster <armbru@redhat.com>, Eric Blake <eblake@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>
Cc: qemu-devel@nongnu.org,
	Zhao Liu <zhao1.liu@intel.com>
Subject: [PATCH 1/2] qapi/misc-target: Rename SGXEPCSection to SgxEpcSection
Date: Fri, 16 May 2025 17:11:29 +0800
Message-Id: <20250516091130.2374221-2-zhao1.liu@intel.com>
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

Rename SGXEPCSection to SgxEpcSection.

Signed-off-by: Zhao Liu <zhao1.liu@intel.com>
---
 hw/i386/sgx.c         | 18 +++++++++---------
 qapi/misc-target.json |  6 +++---
 2 files changed, 12 insertions(+), 12 deletions(-)

diff --git a/hw/i386/sgx.c b/hw/i386/sgx.c
index 5685c4fb802d..3c601689eb72 100644
--- a/hw/i386/sgx.c
+++ b/hw/i386/sgx.c
@@ -84,10 +84,10 @@ static uint64_t sgx_calc_section_metric(uint64_t low, uint64_t high)
            ((high & MAKE_64BIT_MASK(0, 20)) << 32);
 }
 
-static SGXEPCSectionList *sgx_calc_host_epc_sections(void)
+static SgxEpcSectionList *sgx_calc_host_epc_sections(void)
 {
-    SGXEPCSectionList *head = NULL, **tail = &head;
-    SGXEPCSection *section;
+    SgxEpcSectionList *head = NULL, **tail = &head;
+    SgxEpcSection *section;
     uint32_t i, type;
     uint32_t eax, ebx, ecx, edx;
     uint32_t j = 0;
@@ -104,7 +104,7 @@ static SGXEPCSectionList *sgx_calc_host_epc_sections(void)
             break;
         }
 
-        section = g_new0(SGXEPCSection, 1);
+        section = g_new0(SgxEpcSection, 1);
         section->node = j++;
         section->size = sgx_calc_section_metric(ecx, edx);
         QAPI_LIST_APPEND(tail, section);
@@ -183,17 +183,17 @@ SGXInfo *qmp_query_sgx_capabilities(Error **errp)
     return info;
 }
 
-static SGXEPCSectionList *sgx_get_epc_sections_list(void)
+static SgxEpcSectionList *sgx_get_epc_sections_list(void)
 {
     GSList *device_list = sgx_epc_get_device_list();
-    SGXEPCSectionList *head = NULL, **tail = &head;
-    SGXEPCSection *section;
+    SgxEpcSectionList *head = NULL, **tail = &head;
+    SgxEpcSection *section;
 
     for (; device_list; device_list = device_list->next) {
         DeviceState *dev = device_list->data;
         Object *obj = OBJECT(dev);
 
-        section = g_new0(SGXEPCSection, 1);
+        section = g_new0(SgxEpcSection, 1);
         section->node = object_property_get_uint(obj, SGX_EPC_NUMA_NODE_PROP,
                                                  &error_abort);
         section->size = object_property_get_uint(obj, SGX_EPC_SIZE_PROP,
@@ -237,7 +237,7 @@ SGXInfo *qmp_query_sgx(Error **errp)
 void hmp_info_sgx(Monitor *mon, const QDict *qdict)
 {
     Error *err = NULL;
-    SGXEPCSectionList *section_list, *section;
+    SgxEpcSectionList *section_list, *section;
     g_autoptr(SGXInfo) info = qmp_query_sgx(&err);
     uint64_t size = 0;
 
diff --git a/qapi/misc-target.json b/qapi/misc-target.json
index 42e4a7417dc6..a1275d3873ab 100644
--- a/qapi/misc-target.json
+++ b/qapi/misc-target.json
@@ -319,7 +319,7 @@
   'if': 'TARGET_ARM' }
 
 ##
-# @SGXEPCSection:
+# @SgxEpcSection:
 #
 # Information about intel SGX EPC section info
 #
@@ -329,7 +329,7 @@
 #
 # Since: 7.0
 ##
-{ 'struct': 'SGXEPCSection',
+{ 'struct': 'SgxEpcSection',
   'data': { 'node': 'int',
             'size': 'uint64'}}
 
@@ -355,7 +355,7 @@
             'sgx1': 'bool',
             'sgx2': 'bool',
             'flc': 'bool',
-            'sections': ['SGXEPCSection']},
+            'sections': ['SgxEpcSection']},
    'if': 'TARGET_I386' }
 
 ##
-- 
2.34.1


