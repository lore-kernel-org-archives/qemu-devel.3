Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DFC5BC3ABDA
	for <qemu-devel@archiver.kernel.org>; Wed, 14 May 2025 08:29:28 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uF7U9-0006fq-Sn; Wed, 14 May 2025 04:29:06 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1uF7U8-0006ao-0L; Wed, 14 May 2025 04:29:04 -0400
Received: from mgamail.intel.com ([198.175.65.10])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1uF7U6-0006Fg-6y; Wed, 14 May 2025 04:29:03 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1747211342; x=1778747342;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=D1v/A0ZXU1bNqLebJ7M+DCdIHB/C2f5yFTku3+t4lqY=;
 b=aL6iuwKH8FKJ3jmOsSgjnQLk9Kvlyivwo82GisfHtSlvt/WuQuLvAfbZ
 0N5IvjM0srSRNLoR6JRMHxoFpHt9E3Mo1E04xQDIxDj3PIR1IipDi0H8Y
 yKKQ2C7FZreTk+V5fiv76I8I2t2lITKE+JUPSWNEZG0YlBuaUcSmcNXtP
 RaRaiw0lFwJdPhgGgBRTgOw7HKth9xAqnhLNb4c+R9Hok+ff5WFaNZzAI
 Dcrfy+mHB0N71HIxAHAz73OK9SfT5CZyCZGt0/3WTyC6aRNwR/WePaT9A
 ey6B4yXdHH4uiqbUb9z7NtRqQG0s9gvrKZoky80nm0T+KnVJM4x///pn7 w==;
X-CSE-ConnectionGUID: S4V9GTZVTOSMngMjl4M58Q==
X-CSE-MsgGUID: lliDimEnQcKzaMLUgrpX+A==
X-IronPort-AV: E=McAfee;i="6700,10204,11432"; a="66505574"
X-IronPort-AV: E=Sophos;i="6.15,287,1739865600"; d="scan'208";a="66505574"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
 by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 14 May 2025 01:28:58 -0700
X-CSE-ConnectionGUID: 6pjiF2b2SlGOFoe6V1Bv2A==
X-CSE-MsgGUID: ifdDoHMvQYKKJ3s1zzQVkg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,287,1739865600"; d="scan'208";a="169065810"
Received: from liuzhao-optiplex-7080.sh.intel.com ([10.239.160.39])
 by fmviesa001.fm.intel.com with ESMTP; 14 May 2025 01:28:56 -0700
From: Zhao Liu <zhao1.liu@intel.com>
To: Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Daniel=20P=20=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Eduardo Habkost <eduardo@habkost.net>
Cc: qemu-devel@nongnu.org, qemu-trivial@nongnu.org,
 Zhao Liu <zhao1.liu@intel.com>
Subject: [PATCH 2/9] docs/devel/qom: Fix the doc about
 OBJECT_DECLARE_SIMPLE_TYPE
Date: Wed, 14 May 2025 16:49:50 +0800
Message-Id: <20250514084957.2221975-3-zhao1.liu@intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250514084957.2221975-1-zhao1.liu@intel.com>
References: <20250514084957.2221975-1-zhao1.liu@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=198.175.65.10; envelope-from=zhao1.liu@intel.com;
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

Currently, the expansion example of OBJECT_DECLARE_SIMPLE_TYPE "roughly"
reflects what OBJECT_DECLARE_TYPE is doing.

Why "roughly"? Because this line -

>    G_DEFINE_AUTOPTR_CLEANUP_FUNC(MyDeviceClass, object_unref)

- is also wrong for OBJECT_DECLARE_TYPE.

Fix the expansion example of OBJECT_DECLARE_SIMPLE_TYPE, especially
drop that definition of MyDeviceClass.

Cc: Paolo Bonzini <pbonzini@redhat.com>
Cc: "Daniel P. Berrangé" <berrange@redhat.com>
Cc: Eduardo Habkost <eduardo@habkost.net>
Signed-off-by: Zhao Liu <zhao1.liu@intel.com>
---
 docs/devel/qom.rst | 11 +----------
 1 file changed, 1 insertion(+), 10 deletions(-)

diff --git a/docs/devel/qom.rst b/docs/devel/qom.rst
index 5870745ba27b..185f4c2f5921 100644
--- a/docs/devel/qom.rst
+++ b/docs/devel/qom.rst
@@ -326,21 +326,12 @@ This is equivalent to the following:
    :caption: Expansion from declaring a simple type
 
    typedef struct MyDevice MyDevice;
-   typedef struct MyDeviceClass MyDeviceClass;
 
-   G_DEFINE_AUTOPTR_CLEANUP_FUNC(MyDeviceClass, object_unref)
+   G_DEFINE_AUTOPTR_CLEANUP_FUNC(MyDevice, object_unref)
 
-   #define MY_DEVICE_GET_CLASS(void *obj) \
-           OBJECT_GET_CLASS(MyDeviceClass, obj, TYPE_MY_DEVICE)
-   #define MY_DEVICE_CLASS(void *klass) \
-           OBJECT_CLASS_CHECK(MyDeviceClass, klass, TYPE_MY_DEVICE)
    #define MY_DEVICE(void *obj)
            OBJECT_CHECK(MyDevice, obj, TYPE_MY_DEVICE)
 
-   struct MyDeviceClass {
-       DeviceClass parent_class;
-   };
-
 The 'struct MyDevice' needs to be declared separately.
 If the type requires virtual functions to be declared in the class
 struct, then the alternative OBJECT_DECLARE_TYPE() macro can be
-- 
2.34.1


