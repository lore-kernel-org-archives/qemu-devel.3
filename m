Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AA510CCA471
	for <qemu-devel@archiver.kernel.org>; Fri,  3 Oct 2025 23:45:06 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v4pRY-0005CQ-5t; Fri, 03 Oct 2025 19:44:11 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vivek.kasireddy@intel.com>)
 id 1v4pRT-0005Bg-SR
 for qemu-devel@nongnu.org; Fri, 03 Oct 2025 19:44:03 -0400
Received: from mgamail.intel.com ([198.175.65.19])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vivek.kasireddy@intel.com>)
 id 1v4pRO-0001SP-TE
 for qemu-devel@nongnu.org; Fri, 03 Oct 2025 19:44:03 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1759535039; x=1791071039;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=9bqaUsWa3QbbmlyhD5WfWA5wuCxJhAlSjQHGJk486Wc=;
 b=RnacmVi5MV1cZ8QVKVGlbj+cR7LOIWDUBxmdw0AiE4lpB7FTFIIOf3nv
 HrQ4uHvWWHLiWSN7yd2hau9MSxeX5f57lcdlGTtHaIxTobCdvbbw01N/e
 9uiqkvYXyw32WkQrJiAQ5KHbkrDfNUZzzuvvaPj4Q5NAcbnOguf4R/Jec
 x63Wn42jVH6kvS63UdpGoSde0Pw3iaYOoX9SZcgzaN50cIxt8TyFZIArH
 2JQRHlFvbcYwdiKhXLOZImxBqjoe15ZjhHz/5BRaxcv2mEH/FXyNnFxyL
 Ett0XpdToyJsjTuWEnjRNCpv2GEBJKOhXzrAiplxSAex7+tXEvYwnffE2 A==;
X-CSE-ConnectionGUID: trBtUU/OQ4KgVezztA7Etw==
X-CSE-MsgGUID: FDRJvPvcTIKkwEWtxr+YMA==
X-IronPort-AV: E=McAfee;i="6800,10657,11571"; a="61705042"
X-IronPort-AV: E=Sophos;i="6.18,314,1751266800"; d="scan'208";a="61705042"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
 by orvoesa111.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 03 Oct 2025 16:43:39 -0700
X-CSE-ConnectionGUID: MjlfTFPhR/SaDjOskSbbeA==
X-CSE-MsgGUID: FShdKA38REimdiXGHVQSCg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.18,314,1751266800"; d="scan'208";a="179428155"
Received: from vkasired-desk2.fm.intel.com ([10.105.128.132])
 by orviesa008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 03 Oct 2025 16:43:38 -0700
From: Vivek Kasireddy <vivek.kasireddy@intel.com>
To: qemu-devel@nongnu.org
Cc: Vivek Kasireddy <vivek.kasireddy@intel.com>
Subject: [PATCH v1 5/7] linux-headers: Update vfio.h to include
 VFIO_DEVICE_FEATURE_DMA_BUF
Date: Fri,  3 Oct 2025 16:35:58 -0700
Message-ID: <20251003234138.85820-6-vivek.kasireddy@intel.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20251003234138.85820-1-vivek.kasireddy@intel.com>
References: <20251003234138.85820-1-vivek.kasireddy@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=198.175.65.19;
 envelope-from=vivek.kasireddy@intel.com; helo=mgamail.intel.com
X-Spam_score_int: -48
X-Spam_score: -4.9
X-Spam_bar: ----
X-Spam_report: (-4.9 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.467,
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


