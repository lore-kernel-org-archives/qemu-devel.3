Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7E552C2D0CD
	for <qemu-devel@archiver.kernel.org>; Wed, 21 May 2025 11:07:48 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uHhHl-0002PN-HR; Wed, 21 May 2025 07:06:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhenzhong.duan@intel.com>)
 id 1uHhHj-0002Oi-Ff
 for qemu-devel@nongnu.org; Wed, 21 May 2025 07:06:55 -0400
Received: from mgamail.intel.com ([198.175.65.11])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhenzhong.duan@intel.com>)
 id 1uHhHh-0004O6-77
 for qemu-devel@nongnu.org; Wed, 21 May 2025 07:06:55 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1747825614; x=1779361614;
 h=from:to:cc:subject:date:message-id:mime-version:
 content-transfer-encoding;
 bh=++EC2gZa0kDxUUVtUM66Xho/ya2K8OS0SPlDwdld7Js=;
 b=auv3rqRfwxMqFJ5nxFCYlpRlUyXnOi5haEc2DRoYLuZeBfJwKWqtMB+C
 97mU7BVXRXZ1nJGywcur1OPnX7b/blJlHZ+zU3bZHzXnr5eTv8BciB24N
 tdV9dQCD2iYPNqA8QNB1ES0ztwe67fkc77PAeFaz5cTXD9aJUBVAh4nNa
 9wVW9GATGmFD6JTi/+IxhFWTK9YboY4TZhMKGPqvh+nbRzJ7CmM3fT356
 O8IE9fafsUYTW7hyJ5ciB/voYjpBhAMsALHOUMECpe+sf1+j+BFJfStUT
 7bBTGXfz+sta2ChB8c9XdmFcHJjxz9Nm61wv2j6nI7EeKDcIBxMDfDoSD Q==;
X-CSE-ConnectionGUID: REt8nFK7QuK9/un7onsWUQ==
X-CSE-MsgGUID: yF4sP4lbT7yWMlbAXWulXQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11439"; a="60032907"
X-IronPort-AV: E=Sophos;i="6.15,303,1739865600"; d="scan'208";a="60032907"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
 by orvoesa103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 21 May 2025 04:06:49 -0700
X-CSE-ConnectionGUID: PC0tt5giTOWpH9I38RqmbQ==
X-CSE-MsgGUID: gLQEvYOAQgqa316jex7cvQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,303,1739865600"; d="scan'208";a="171019909"
Received: from spr-s2600bt.bj.intel.com ([10.240.192.127])
 by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 21 May 2025 04:06:47 -0700
From: Zhenzhong Duan <zhenzhong.duan@intel.com>
To: qemu-devel@nongnu.org
Cc: alex.williamson@redhat.com, clg@redhat.com, chao.p.peng@intel.com,
 Zhenzhong Duan <zhenzhong.duan@intel.com>
Subject: [PATCH] vfio/iommufd: Add comment emphasizing no movement of
 hiod->realize() call
Date: Wed, 21 May 2025 19:03:01 +0800
Message-Id: <20250521110301.3313877-1-zhenzhong.duan@intel.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=198.175.65.11;
 envelope-from=zhenzhong.duan@intel.com; helo=mgamail.intel.com
X-Spam_score_int: -45
X-Spam_score: -4.6
X-Spam_bar: ----
X-Spam_report: (-4.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.184,
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

The nested IOMMU support needs device and hwpt id which are generated
only after attachment. Hiod encapsulates these information in realize()
and passes to vIOMMU.

Suggested-by: Cédric Le Goater <clg@redhat.com>
Signed-off-by: Zhenzhong Duan <zhenzhong.duan@intel.com>
---
 hw/vfio/iommufd.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/hw/vfio/iommufd.c b/hw/vfio/iommufd.c
index af1c7ab10a..6b2696793f 100644
--- a/hw/vfio/iommufd.c
+++ b/hw/vfio/iommufd.c
@@ -592,6 +592,10 @@ found_container:
         goto err_listener_register;
     }
 
+    /*
+     * Do not move this code before attachment! The nested IOMMU support
+     * needs device and hwpt id which are generated only after attachment.
+     */
     if (!vfio_device_hiod_create_and_realize(vbasedev,
                      TYPE_HOST_IOMMU_DEVICE_IOMMUFD_VFIO, errp)) {
         goto err_listener_register;
-- 
2.34.1


