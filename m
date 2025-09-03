Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C051BCA1007
	for <qemu-devel@archiver.kernel.org>; Wed,  3 Sep 2025 05:47:59 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1utgL4-0005Rz-Pz; Wed, 03 Sep 2025 01:47:24 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vivek.kasireddy@intel.com>)
 id 1utgKz-0005RW-PC
 for qemu-devel@nongnu.org; Wed, 03 Sep 2025 01:47:17 -0400
Received: from mgamail.intel.com ([198.175.65.20])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vivek.kasireddy@intel.com>)
 id 1utgKx-000206-Vq
 for qemu-devel@nongnu.org; Wed, 03 Sep 2025 01:47:17 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1756878437; x=1788414437;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=9bqaUsWa3QbbmlyhD5WfWA5wuCxJhAlSjQHGJk486Wc=;
 b=SNmt7GMeGCDdZ9gbMn+kE5+7Wh5s0V1+DkD+YtaRSpajaA1GL4r+Glql
 oCKwzntId1DwTCQrBF9wnlK6Nu1tu3j1c09a+y2u1P3Y+4fSP/1hKp283
 fhSYcWsUNp9QjP4QgP/1u/JUpM3rdnbXD+1+jwHcutNTbc/bamRC/139O
 RHJSl7S8YrV1ANo8o7xmW5yymCTwL3WycxMs9lT41CmodC9iw2pAS3hmo
 Gp7hEtSPhjTsJR9OGabHXDGhpCJW3INq59lHmApdDNRoxOzQBTsDTcz39
 TmP1DFR34eCDzpRmxMVF6qt/qZ42ZsCbLDH0YSha10T7h/Nhdeg/azmnI A==;
X-CSE-ConnectionGUID: 6V+KQSJKRGKNPz7W4o3RPw==
X-CSE-MsgGUID: TdeHfOpxSEejC++lOagGJQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11541"; a="58878186"
X-IronPort-AV: E=Sophos;i="6.18,233,1751266800"; d="scan'208";a="58878186"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
 by orvoesa112.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 02 Sep 2025 22:47:09 -0700
X-CSE-ConnectionGUID: Y08t34jhQcmKyODJS5b6yQ==
X-CSE-MsgGUID: GDoKVTtqRY63G6SDifAzEg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.18,233,1751266800"; d="scan'208";a="175634762"
Received: from vkasired-desk2.fm.intel.com ([10.105.128.132])
 by ORVIESA003-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 02 Sep 2025 22:47:08 -0700
From: Vivek Kasireddy <vivek.kasireddy@intel.com>
To: qemu-devel@nongnu.org
Cc: Vivek Kasireddy <vivek.kasireddy@intel.com>
Subject: [RFC 1/6] linux-headers: Update vfio.h to include
 VFIO_DEVICE_FEATURE_DMA_BUF
Date: Tue,  2 Sep 2025 22:42:14 -0700
Message-ID: <20250903054438.1179384-2-vivek.kasireddy@intel.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20250903054438.1179384-1-vivek.kasireddy@intel.com>
References: <20250903054438.1179384-1-vivek.kasireddy@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=198.175.65.20;
 envelope-from=vivek.kasireddy@intel.com; helo=mgamail.intel.com
X-Spam_score_int: -43
X-Spam_score: -4.4
X-Spam_bar: ----
X-Spam_report: (-4.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
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

Signed-off-by: Vivek Kasireddy <vivek.kasireddy@intel.com>
---
 linux-headers/linux/vfio.h | 25 +++++++++++++++++++++++++
 1 file changed, 25 insertions(+)

diff --git a/linux-headers/linux/vfio.h b/linux-headers/linux/vfio.h
index 79bf8c0cc5..d2177c9cba 100644
--- a/linux-headers/linux/vfio.h
+++ b/linux-headers/linux/vfio.h
@@ -1468,6 +1468,31 @@ struct vfio_device_feature_bus_master {
 };
 #define VFIO_DEVICE_FEATURE_BUS_MASTER 10
 
+/**
+ * Upon VFIO_DEVICE_FEATURE_GET create a dma_buf fd for the
+ * regions selected.
+ *
+ * open_flags are the typical flags passed to open(2), eg O_RDWR, O_CLOEXEC,
+ * etc. offset/length specify a slice of the region to create the dmabuf from.
+ * nr_ranges is the total number of (P2P DMA) ranges that comprise the dmabuf.
+ *
+ * Return: The fd number on success, -1 and errno is set on failure.
+ */
+#define VFIO_DEVICE_FEATURE_DMA_BUF 11
+
+struct vfio_region_dma_range {
+	__u64 offset;
+	__u64 length;
+};
+
+struct vfio_device_feature_dma_buf {
+	__u32	region_index;
+	__u32	open_flags;
+	__u32   flags;
+	__u32   nr_ranges;
+	struct vfio_region_dma_range dma_ranges[];
+};
+
 /* -------- API for Type1 VFIO IOMMU -------- */
 
 /**
-- 
2.50.1


