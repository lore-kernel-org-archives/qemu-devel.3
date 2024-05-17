Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 33CD8C04FFE
	for <qemu-devel@archiver.kernel.org>; Fri, 17 May 2024 06:13:02 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s7qpn-0004Cd-CU; Fri, 17 May 2024 02:12:52 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1s7qpj-00048V-85
 for qemu-devel@nongnu.org; Fri, 17 May 2024 02:12:47 -0400
Received: from mgamail.intel.com ([198.175.65.15])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1s7qpb-0002oD-IV
 for qemu-devel@nongnu.org; Fri, 17 May 2024 02:12:46 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1715926359; x=1747462359;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=ThiBVBuJSiLAGHZSgNXK0nWPd2pkS4T7DVvbx25AFcw=;
 b=gvckxfouBKbwu9nPO7uj77K2eR/FfeEoaD7iyT/NUDs/tLYIkcEZbizm
 jwP/cNuZkD2QW0zd4F35/KPK7yV6jo15U+eXbgtorGqHjU2SN1lOHfJui
 czbDrYaoIKiI5eTuQkVVY3sTKSEX/bWOfJTrS3uZv1vptjtE991twnZPg
 bGznrA0F0SlEePKmw4w6Q5yVlbJH0FCcmlGoESHFQQ35mNyOD6ynHU4RJ
 qU/tNPSXNXArd7sF4rC7ZtUpzTL6KCLDf0KdyllthKaLlpljzLqFOaGj4
 HupKI/JayyTgONKCA+deL19ojWQeNYkIBfKK9IUVEgCE/34jGelFV7jst g==;
X-CSE-ConnectionGUID: 2/0JaSW1RcOWAuJMVv2JzA==
X-CSE-MsgGUID: 0F0QWGHUS1aG/1TsFDHSuA==
X-IronPort-AV: E=McAfee;i="6600,9927,11074"; a="15869074"
X-IronPort-AV: E=Sophos;i="6.08,166,1712646000"; d="scan'208";a="15869074"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
 by orvoesa107.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 16 May 2024 23:12:35 -0700
X-CSE-ConnectionGUID: X2ZVh/I3TF64hzZd6W3X8g==
X-CSE-MsgGUID: f0nuc8dCSYSZHwBPKiUbkg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,166,1712646000"; d="scan'208";a="31620648"
Received: from liuzhao-optiplex-7080.sh.intel.com ([10.239.160.36])
 by fmviesa007.fm.intel.com with ESMTP; 16 May 2024 23:12:33 -0700
From: Zhao Liu <zhao1.liu@intel.com>
To: Eric Blake <eblake@redhat.com>,
	Markus Armbruster <armbru@redhat.com>
Cc: qemu-devel@nongnu.org,
	Zhao Liu <zhao1.liu@intel.com>
Subject: [PATCH 1/2] qapi: Reorder and categorize json files in
 qapi-schema.json
Date: Fri, 17 May 2024 14:27:47 +0800
Message-Id: <20240517062748.782366-2-zhao1.liu@intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240517062748.782366-1-zhao1.liu@intel.com>
References: <20240517062748.782366-1-zhao1.liu@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=198.175.65.15; envelope-from=zhao1.liu@intel.com;
 helo=mgamail.intel.com
X-Spam_score_int: -53
X-Spam_score: -5.4
X-Spam_bar: -----
X-Spam_report: (-5.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.022,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, SPF_HELO_NONE=0.001,
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

Currently, the C code is generated sequentially in the order of the QAPI
json files in qapi-schema.json. This requires that the included file
must be listed first, before the file that includes it.

The current files' order implicitly fulfills this requirement, but
unclear dependency relationship makes it unfriendly for subsequent
dependency handling/adding new files.

While dependencies can be better handled by adding a sorting algorithm
to scripts/qapi/gen.py, to simplify and visualize the current API JSON
dependencies, sort them manually and categorize by dependency hierarchy.

Based on this, the new files should be placed in the corresponding
sections according to the dependencies/dependency hierarchy.

Signed-off-by: Zhao Liu <zhao1.liu@intel.com>
---
 qapi/qapi-schema.json | 100 +++++++++++++++++++++++++++++-------------
 1 file changed, 69 insertions(+), 31 deletions(-)

diff --git a/qapi/qapi-schema.json b/qapi/qapi-schema.json
index 5e33da7228f2..57ea6bcb33e9 100644
--- a/qapi/qapi-schema.json
+++ b/qapi/qapi-schema.json
@@ -38,45 +38,83 @@
 
 # Documentation generated with qapi-gen.py is in source order, with
 # included sub-schemas inserted at the first include directive
-# (subsequent include directives have no effect).  To get a sane and
-# stable order, it's best to include each sub-schema just once, or
-# include it first right here.
+# (subsequent include directives have no effect). Please place the
+# file correctly in the following sections according to the
+# dependencies.
+#
+# To get a sane and stable order, it's best to include each sub-schema
+# just once, or include it first right here.
 
-{ 'include': 'error.json' }
+# Section 1. Files without dependencies.
+
+{ 'include': 'acpi.json' }
+{ 'include': 'audio.json' }
+{ 'include': 'authz.json' }
 { 'include': 'common.json' }
-{ 'include': 'sockets.json' }
-{ 'include': 'run-state.json' }
+{ 'include': 'compat.json' }
+{ 'include': 'control.json' }
 { 'include': 'crypto.json' }
-{ 'include': 'job.json' }
-{ 'include': 'block.json' }
-{ 'include': 'block-export.json' }
-{ 'include': 'char.json' }
+{ 'include': 'cryptodev.json' }
+{ 'include': 'cxl.json' }
 { 'include': 'dump.json' }
-{ 'include': 'net.json' }
 { 'include': 'ebpf.json' }
-{ 'include': 'rocker.json' }
-{ 'include': 'tpm.json' }
-{ 'include': 'ui.json' }
-{ 'include': 'authz.json' }
-{ 'include': 'migration.json' }
-{ 'include': 'transaction.json' }
-{ 'include': 'trace.json' }
-{ 'include': 'compat.json' }
-{ 'include': 'control.json' }
+{ 'include': 'error.json' }
 { 'include': 'introspect.json' }
-{ 'include': 'qom.json' }
-{ 'include': 'qdev.json' }
+{ 'include': 'job.json' }
 { 'include': 'machine-common.json' }
-{ 'include': 'machine.json' }
-{ 'include': 'machine-target.json' }
-{ 'include': 'replay.json' }
-{ 'include': 'yank.json' }
-{ 'include': 'misc.json' }
 { 'include': 'misc-target.json' }
-{ 'include': 'audio.json' }
-{ 'include': 'acpi.json' }
 { 'include': 'pci.json' }
+{ 'include': 'rocker.json' }
+{ 'include': 'run-state.json' }
+{ 'include': 'sockets.json' }
 { 'include': 'stats.json' }
+{ 'include': 'tpm.json' }
+{ 'include': 'trace.json' }
 { 'include': 'virtio.json' }
-{ 'include': 'cryptodev.json' }
-{ 'include': 'cxl.json' }
+{ 'include': 'yank.json' }
+
+# Section 2. Files with 1-level dependencies.
+#
+# All their dependencies are listed in the section 1.
+
+# include sockets.json
+{ 'include': 'char.json' }
+# include machine-common.json
+{ 'include': 'machine-target.json' }
+# include common.json, machine-common.json
+{ 'include': 'machine.json' }
+# include common.json, sockets.json
+{ 'include': 'migration.json' }
+# include common.json
+{ 'include': 'misc.json' }
+# include sockets.json
+{ 'include': 'net.json' }
+# include common.json
+{ 'include': 'replay.json' }
+# include common.json, sockets.json
+{ 'include': 'ui.json' }
+
+# Section 3. Files with 2-level dependencies.
+#
+# Their dependencies are either listed in the previous sections, or are
+# not listed but include files from the previous section. At least one
+# dependency is a 1-level dependency file.
+
+# include sockets.json (section 1), block-core.json (not listed, 1-level
+# dependencies)
+{ 'include': 'block-export.json' }
+# include block-core.json (not listed, 1-level dependencies)
+{ 'include': 'block.json' }
+# include authz.json (section 1), common.json (section 1), crypto.json
+# (section 1), block-core.json (not listed, 1-level dependencies)
+{ 'include': 'qom.json' }
+# include block-core.json (not listed, 1-level dependencies)
+{ 'include': 'transaction.json' }
+
+# Section 4. Files with 3-level dependencies.
+#
+# All their dependencies are listed in the previous sections. At least one
+# dependency is from section 3.
+
+# include qom.json (section 3)
+{ 'include': 'qdev.json' }
-- 
2.34.1


