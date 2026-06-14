Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 74D9CCD98C5
	for <qemu-devel@archiver.kernel.org>; Sun, 14 Jun 2026 19:12:18 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wYq9w-0007R1-Qi; Sun, 14 Jun 2026 15:06:16 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1wYq9v-0007Qj-LH
 for qemu-devel@nongnu.org; Sun, 14 Jun 2026 15:06:15 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1wYq9u-0001ew-5N
 for qemu-devel@nongnu.org; Sun, 14 Jun 2026 15:06:15 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1781463973;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=xAhzQJ1J7Y0DMrpDuFRRLukdxYxQFBbtnkS/vGZ9KXY=;
 b=OSzMLwYpmDnzzeB9nY+K3JhTO57Rh6ScJPIUuVT3QnMajOW+vPGfluTl0G+8T3uLbnrTm1
 lBnE3JJ/eY5P3li8hqc9QlBO/YUBvoOrkFJEIf8S2i5UlANL0YLjqayfpikH0rOfe7pUMq
 sD5LyoTcE3xw+sSH9/ZgX3ZaRY9kGCs=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-346-RL17JjA_NR-IYTn5-GWw4g-1; Sun, 14 Jun 2026 15:06:09 -0400
X-MC-Unique: RL17JjA_NR-IYTn5-GWw4g-1
X-Mimecast-MFC-AGG-ID: RL17JjA_NR-IYTn5-GWw4g_1781463968
Received: by mail-wm1-f71.google.com with SMTP id
 5b1f17b1804b1-490a060eb84so19270865e9.0
 for <qemu-devel@nongnu.org>; Sun, 14 Jun 2026 12:06:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1781463968; x=1782068768; darn=nongnu.org;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=xAhzQJ1J7Y0DMrpDuFRRLukdxYxQFBbtnkS/vGZ9KXY=;
 b=BktpXsSHaHS7KFwwscj0yeGABJAMDoUa77ofi50PrpDb7rbpCE/lXNoLEXHxnT/Gc9
 f3div471RcUCTKDA/d47qmdRvUvAbIejYQ8EyIsptcSdS9j9B9TPnzqCE+1WUrmqI11g
 ebLanGOWZRpk/sDlCRyvHenUW4rKu4w4qkjARJXF7qz4xol0UtpVZkQcmxWAxUnI+ytl
 OY6kPmzwBqvyoZDfZ7sDpLi0ZNgokPlbtaSF1SdmNC56aK42K8FLyixDoVxBBsAHJHuu
 G6Hh4a8+iCoBs1bafeLbuMgw5GvvdGgO0Z5N5fneL//K0PC0Yymx6GhvQPW9fSwSzK5y
 xDwg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1781463968; x=1782068768;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=xAhzQJ1J7Y0DMrpDuFRRLukdxYxQFBbtnkS/vGZ9KXY=;
 b=mEZFjqgSIeIRM/aG+dQz1JqzjZXYgzNEOWikmG9cgNx2iYFls2xYSB6uKVOOb9XISA
 Xjt6EH7LOqVZ2uOA8QZt+ErtzPrUzonyigTVkYDbc2fFuMV0WD/mH3jAPFXe7Oix31oV
 oPFR26geYlCmbimAVs/El5lr9tRHqx9TaN5Hs3yThPODb5oUF13UzP98V61xubwXwMHt
 7NkKQZk47XnrMlo9DAxyrrWyZv5TzPzrvEDv9d2lbX1pk99RBJj5iLQc3tmLWTYvE/1e
 zai/TCifZkFoeimawXMQuVPVfQHrW04A6FoFi9zhykCsb7cVfQbnPpQywWLgQ7WF1H/S
 Pegg==
X-Gm-Message-State: AOJu0YyQj3FXCUi62cZoqflXI8RxNji9Ymb6yTEYCNzYLHLr2C0eReGo
 I00drr9qaMxT5pge/8/S+MVpZR8Px3XKLbKNA8+ZXw7MAH7p+pA5pkELpXulN10HBASkvEve8WW
 5G9OveNrgfjFpUDOcT2RVEDuB8os35PDy1yDrDroGnyZoQDqQMD28sWHL3/DEhmRS0zTKKGyqcR
 e1tLt9EjmTRgWt4nmgnnnh1JEl4v3lN4XEag==
X-Gm-Gg: Acq92OHT8BlUymaHEev8xvH25tgGffCSkFjsO9A6YUSZJUpAcsOF6tCzTQ2VsFyElQ9
 fEK8OPTSmnN0VPRyvHRTJdEQ+6GU0XVz7W8aCP3IV30gfoWsITcygt6zrTQ/QjtVtjBocylyTvO
 fcP7Jqe+HWtdbD6+xwkIyYlB7eu9hkZOnobFb0WXSd7/5E7cMqVoNGSS6yJPAerDYAQ8QNMbxhU
 9G8jE36QoEK6ylteR5G2rSeLEPCIMyvyN/IPwNk8uAJzuCeqCdNye17JRsUOnrJ6JqUzoahvzR1
 qieP1He2UXUwY0l+j1vnZ9jBpFJW4fnrRzK1MCk5BMa9Cs7O9h4vFcPGzrryvXqyvNH2KuDtaZd
 valE+BkKL+lExUlrGXFeqzcmu39PxsPBcHdu5PiJ7jRc=
X-Received: by 2002:a05:600c:e556:20b0:490:b9c3:6c58 with SMTP id
 5b1f17b1804b1-490ec4fe879mr102011885e9.16.1781463967618; 
 Sun, 14 Jun 2026 12:06:07 -0700 (PDT)
X-Received: by 2002:a05:600c:e556:20b0:490:b9c3:6c58 with SMTP id
 5b1f17b1804b1-490ec4fe879mr102011545e9.16.1781463967109; 
 Sun, 14 Jun 2026 12:06:07 -0700 (PDT)
Received: from redhat.com (IGLD-80-230-85-71.inter.net.il. [80.230.85.71])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-4606f26f3basm25831576f8f.12.2026.06.14.12.06.05
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 14 Jun 2026 12:06:06 -0700 (PDT)
Date: Sun, 14 Jun 2026 15:06:04 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Zhenzhong Duan <zhenzhong.duan@intel.com>,
 Clement Mathieu--Drif <clement.mathieu--drif@bull.com>,
 Yi Liu <yi.l.liu@intel.com>, Xudong Hao <xudong.hao@intel.com>,
 Jason Wang <jasowang@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>
Subject: [PULL 009/106] intel_iommu: Create the nested hwpt with
 IOMMU_HWPT_ALLOC_PASID flag
Message-ID: <76330797b0eab06ebe2cbf5c8a21953da71ba4ba.1781463125.git.mst@redhat.com>
References: <cover.1781463125.git.mst@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1781463125.git.mst@redhat.com>
X-Mailer: git-send-email 2.51.2.2891.g4157995a80.dirty
X-Mutt-Fcc: =sent
Received-SPF: pass client-ip=170.10.133.124; envelope-from=mst@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.445,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

From: Zhenzhong Duan <zhenzhong.duan@intel.com>

When pasid is enabled, any hwpt attached to non-PASID or PASID should be
IOMMU_HWPT_ALLOC_PASID flagged, or else attachment fails.

Change vtd_destroy_old_fs_hwpt() to pass in 'VTDHostIOMMUDevice *' for
naming consistency.

Signed-off-by: Zhenzhong Duan <zhenzhong.duan@intel.com>
Reviewed-by: Clement Mathieu--Drif <clement.mathieu--drif@bull.com>
Reviewed-by: Yi Liu <yi.l.liu@intel.com>
Tested-by: Xudong Hao <xudong.hao@intel.com>
Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
Message-Id: <20260527054658.1021096-5-zhenzhong.duan@intel.com>
---
 hw/i386/intel_iommu_accel.c | 19 ++++++++++++-------
 1 file changed, 12 insertions(+), 7 deletions(-)

diff --git a/hw/i386/intel_iommu_accel.c b/hw/i386/intel_iommu_accel.c
index 3beadab035..6a12cdac10 100644
--- a/hw/i386/intel_iommu_accel.c
+++ b/hw/i386/intel_iommu_accel.c
@@ -69,11 +69,13 @@ VTDHostIOMMUDevice *vtd_find_hiod_iommufd(VTDAddressSpace *as)
     return NULL;
 }
 
-static bool vtd_create_fs_hwpt(HostIOMMUDeviceIOMMUFD *hiodi,
+static bool vtd_create_fs_hwpt(VTDHostIOMMUDevice *vtd_hiod,
                                VTDPASIDEntry *pe, uint32_t *fs_hwpt_id,
                                Error **errp)
 {
+    HostIOMMUDeviceIOMMUFD *hiodi = HOST_IOMMU_DEVICE_IOMMUFD(vtd_hiod->hiod);
     struct iommu_hwpt_vtd_s1 vtd = {};
+    uint32_t flags = vtd_hiod->iommu_state->pasid ? IOMMU_HWPT_ALLOC_PASID : 0;
 
     vtd.flags = (VTD_SM_PASID_ENTRY_SRE(pe) ? IOMMU_VTD_S1_SRE : 0) |
                 (VTD_SM_PASID_ENTRY_WPE(pe) ? IOMMU_VTD_S1_WPE : 0) |
@@ -82,13 +84,16 @@ static bool vtd_create_fs_hwpt(HostIOMMUDeviceIOMMUFD *hiodi,
     vtd.pgtbl_addr = (uint64_t)vtd_pe_get_fspt_base(pe);
 
     return iommufd_backend_alloc_hwpt(hiodi->iommufd, hiodi->devid,
-                                      hiodi->hwpt_id, 0, IOMMU_HWPT_DATA_VTD_S1,
-                                      sizeof(vtd), &vtd, fs_hwpt_id, errp);
+                                      hiodi->hwpt_id, flags,
+                                      IOMMU_HWPT_DATA_VTD_S1, sizeof(vtd), &vtd,
+                                      fs_hwpt_id, errp);
 }
 
-static void vtd_destroy_old_fs_hwpt(HostIOMMUDeviceIOMMUFD *hiodi,
+static void vtd_destroy_old_fs_hwpt(VTDHostIOMMUDevice *vtd_hiod,
                                     VTDAddressSpace *vtd_as)
 {
+    HostIOMMUDeviceIOMMUFD *hiodi = HOST_IOMMU_DEVICE_IOMMUFD(vtd_hiod->hiod);
+
     if (!vtd_as->fs_hwpt_id) {
         return;
     }
@@ -116,7 +121,7 @@ static bool vtd_device_attach_iommufd(VTDHostIOMMUDevice *vtd_hiod,
     }
 
     if (vtd_pe_pgtt_is_fst(pe)) {
-        if (!vtd_create_fs_hwpt(hiodi, pe, &hwpt_id, errp)) {
+        if (!vtd_create_fs_hwpt(vtd_hiod, pe, &hwpt_id, errp)) {
             return false;
         }
     }
@@ -126,7 +131,7 @@ static bool vtd_device_attach_iommufd(VTDHostIOMMUDevice *vtd_hiod,
     trace_vtd_device_attach_hwpt(hiodi->devid, IOMMU_NO_PASID, hwpt_id, ret);
     if (ret) {
         /* Destroy old fs_hwpt if it's a replacement */
-        vtd_destroy_old_fs_hwpt(hiodi, vtd_as);
+        vtd_destroy_old_fs_hwpt(vtd_hiod, vtd_as);
         if (vtd_pe_pgtt_is_fst(pe)) {
             vtd_as->fs_hwpt_id = hwpt_id;
         }
@@ -161,7 +166,7 @@ static bool vtd_device_detach_iommufd(VTDHostIOMMUDevice *vtd_hiod,
     }
 
     if (ret) {
-        vtd_destroy_old_fs_hwpt(hiodi, vtd_as);
+        vtd_destroy_old_fs_hwpt(vtd_hiod, vtd_as);
     }
 
     return ret;
-- 
MST


