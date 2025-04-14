Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 92AD3C369B2
	for <qemu-devel@archiver.kernel.org>; Mon, 14 Apr 2025 14:31:13 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u4KoH-0003IF-1G; Mon, 14 Apr 2025 10:29:17 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1u4KoA-0003Db-Gu; Mon, 14 Apr 2025 10:29:10 -0400
Received: from mgamail.intel.com ([192.198.163.7])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1u4Ko8-00064c-Up; Mon, 14 Apr 2025 10:29:10 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1744640949; x=1776176949;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=aHKZirzvZLm5HMaaF4zs6cIuJscdkK9KXJGrwuOgCto=;
 b=doU1NpLFAhNARvzzDp9ySMszwOZLjjpD8GffkRVcHKSoWBwWogqxyNcx
 PYDzI80jV8cBaE36Cz4cZVC2xVxZs4We/5x6ldGIjKmgOADq2LHx0iIOW
 Wm/PKNocN1A8ERUOWChqtn3oga5FgWVBfS1WTGvdQlGMGaM+f5ZQ4AXVV
 pVHmBP37GghsyiQ58rKqjgbopTn3Mex3l2/ml27/RIOodWx6ZkQ1PEUk7
 25KidhdPC7Hf06Hm0OeJ2nAqO9isVkegSWzMdTSbJqAVxb/6nf+F6RTSA
 P7Cw1vU8BHH/AqYJnddJf4JizwxVJmJAFMxhP16A6Tbd5w3L2FFY44zS+ Q==;
X-CSE-ConnectionGUID: XVUGEOo+T8CmpCXsJhzlHQ==
X-CSE-MsgGUID: 823HrQg7Ts6Yyx3DEAydqA==
X-IronPort-AV: E=McAfee;i="6700,10204,11403"; a="71501838"
X-IronPort-AV: E=Sophos;i="6.15,212,1739865600"; d="scan'208";a="71501838"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
 by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 14 Apr 2025 07:29:04 -0700
X-CSE-ConnectionGUID: WTmntqLIQQiakBGoPxZPuw==
X-CSE-MsgGUID: u50bFtodSAeeyM81GojwRQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,212,1739865600"; d="scan'208";a="134606072"
Received: from liuzhao-optiplex-7080.sh.intel.com ([10.239.160.39])
 by fmviesa005.fm.intel.com with ESMTP; 14 Apr 2025 07:29:02 -0700
From: Zhao Liu <zhao1.liu@intel.com>
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: qemu-devel@nongnu.org, qemu-rust@nongnu.org,
 Dapeng Mi <dapeng1.mi@intel.com>, Zhao Liu <zhao1.liu@intel.com>
Subject: [PATCH 4/9] rust/vmstate_test: Fix typo in
 test_vmstate_macro_array_of_pointer_wrapped()
Date: Mon, 14 Apr 2025 22:49:38 +0800
Message-Id: <20250414144943.1112885-5-zhao1.liu@intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250414144943.1112885-1-zhao1.liu@intel.com>
References: <20250414144943.1112885-1-zhao1.liu@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=192.198.163.7; envelope-from=zhao1.liu@intel.com;
 helo=mgamail.intel.com
X-Spam_score_int: -43
X-Spam_score: -4.4
X-Spam_bar: ----
X-Spam_report: (-4.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
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

test_vmstate_macro_array_of_pointer_wrapped() tests the 3rd element, so
fix the index.

Signed-off-by: Zhao Liu <zhao1.liu@intel.com>
---
 rust/qemu-api/tests/vmstate_tests.rs | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/rust/qemu-api/tests/vmstate_tests.rs b/rust/qemu-api/tests/vmstate_tests.rs
index d1e37c45eea4..f7a93117e1a0 100644
--- a/rust/qemu-api/tests/vmstate_tests.rs
+++ b/rust/qemu-api/tests/vmstate_tests.rs
@@ -408,12 +408,12 @@ fn test_vmstate_macro_array_of_pointer_wrapped() {
     );
     assert_eq!(foo_fields[3].offset, (FOO_ARRAY_MAX + 2) * PTR_SIZE);
     assert_eq!(foo_fields[3].num_offset, 0);
-    assert_eq!(foo_fields[2].info, unsafe { &vmstate_info_uint8 });
+    assert_eq!(foo_fields[3].info, unsafe { &vmstate_info_uint8 });
     assert_eq!(foo_fields[3].version_id, 0);
     assert_eq!(foo_fields[3].size, PTR_SIZE);
     assert_eq!(foo_fields[3].num, FOO_ARRAY_MAX as i32);
     assert_eq!(
-        foo_fields[2].flags.0,
+        foo_fields[3].flags.0,
         VMStateFlags::VMS_ARRAY.0 | VMStateFlags::VMS_ARRAY_OF_POINTER.0
     );
     assert!(foo_fields[3].vmsd.is_null());
-- 
2.34.1


