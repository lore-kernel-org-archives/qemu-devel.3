Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E2F89C3ABDA
	for <qemu-devel@archiver.kernel.org>; Wed, 14 May 2025 08:29:47 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uF7U9-0006f4-Gy; Wed, 14 May 2025 04:29:05 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1uF7U6-0006XB-5d; Wed, 14 May 2025 04:29:02 -0400
Received: from mgamail.intel.com ([198.175.65.10])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1uF7U4-0006Fs-9b; Wed, 14 May 2025 04:29:01 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1747211340; x=1778747340;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=FdOAj36KJleXLSX45p4llvGBDxu8kaQ/Flsl3wc8shs=;
 b=iLrHonJUpnw3kw7EY9b7kSHsgLmcRwFMdkFRWeFLWn6UzwtBwXuwUvJz
 mLp8hFYmyDkuEYeWEoqJGgdoPKNuEewBiHgYJC/5x+LJPYOxr68zlPlTI
 QlAEQP7GBrPBnUFNCOmX180PjvJVY98o/iSsfQryZfqjWxrWk7S3dxB0W
 /d/KDsoN9dEryNA9wvQUTMwGGGC10PqYsY/rJbWV9Pn7RQGgNueN7I7MZ
 V4c60IM5JUnrgXAGJINr1HG626tFGM4Fqc79Qs3PeUhtP9gyyd4aCHqP+
 riZBxRjAqguYhC62op8XmgJSBZ0HbQGkJpgE8LIsGpV33D/0s2w9RPHC7 Q==;
X-CSE-ConnectionGUID: +6YZbp5OTtqtf39B9lBKqw==
X-CSE-MsgGUID: QJEqJfR3T1Wl/Lc/6TcA/Q==
X-IronPort-AV: E=McAfee;i="6700,10204,11432"; a="66505568"
X-IronPort-AV: E=Sophos;i="6.15,287,1739865600"; d="scan'208";a="66505568"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
 by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 14 May 2025 01:28:57 -0700
X-CSE-ConnectionGUID: hYjjzZBxQmu2mNLdCbMYEw==
X-CSE-MsgGUID: sqcoE+Y6RqGv6+Je+l2zPA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,287,1739865600"; d="scan'208";a="169065806"
Received: from liuzhao-optiplex-7080.sh.intel.com ([10.239.160.39])
 by fmviesa001.fm.intel.com with ESMTP; 14 May 2025 01:28:54 -0700
From: Zhao Liu <zhao1.liu@intel.com>
To: Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Daniel=20P=20=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Eduardo Habkost <eduardo@habkost.net>
Cc: qemu-devel@nongnu.org, qemu-trivial@nongnu.org,
 Zhao Liu <zhao1.liu@intel.com>
Subject: [PATCH 1/9] qom/object: Improve the doc of macros related with simple
 type
Date: Wed, 14 May 2025 16:49:49 +0800
Message-Id: <20250514084957.2221975-2-zhao1.liu@intel.com>
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

There're 2 changes:
 - For OBJECT_DECLARE_SIMPLE_TYPE:

   Since a clase may not only has virtual method, but also field, thus
   mention when class is not needed for either, then there is no need
   to have the class.

 - For OBJECT_DEFINE_SIMPLE_TYPE_WITH_INTERFACES:

   And the words like OBJECT_DEFINE_SIMPLE_TYPE about when the type is
   declared by OBJECT_DECLARE_SIMPLE_TYPE, then user should consider
   to define the type via OBJECT_DEFINE_SIMPLE_TYPE or
   OBJECT_DEFINE_SIMPLE_TYPE_WITH_INTERFACES.

Cc: Paolo Bonzini <pbonzini@redhat.com>
Cc: "Daniel P. Berrangé" <berrange@redhat.com>
Cc: Eduardo Habkost <eduardo@habkost.net>
Signed-off-by: Zhao Liu <zhao1.liu@intel.com>
---
 include/qom/object.h | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/include/qom/object.h b/include/qom/object.h
index 1d5b03372429..14f84ae454d3 100644
--- a/include/qom/object.h
+++ b/include/qom/object.h
@@ -249,7 +249,7 @@ struct Object
  * declared.
  *
  * This macro should be used unless the class struct needs to have
- * virtual methods declared.
+ * virtual methods or fields declared.
  */
 #define OBJECT_DECLARE_SIMPLE_TYPE(InstanceType, MODULE_OBJ_NAME) \
     typedef struct InstanceType InstanceType; \
@@ -402,7 +402,8 @@ struct Object
  *
  * This is a variant of OBJECT_DEFINE_TYPE_EXTENDED, which is suitable for
  * the case of a non-abstract type, with interfaces, and with no requirement
- * for a class struct.
+ * for a class struct. If you declared your type with OBJECT_DECLARE_SIMPLE_TYPE
+ * then this is probably the right choice for defining it.
  */
 #define OBJECT_DEFINE_SIMPLE_TYPE_WITH_INTERFACES(ModuleObjName, \
                                                   module_obj_name, \
-- 
2.34.1


