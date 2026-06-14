Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6996ECD98C5
	for <qemu-devel@archiver.kernel.org>; Sun, 14 Jun 2026 19:10:03 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wYq9u-0007QO-3Q; Sun, 14 Jun 2026 15:06:14 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1wYq9q-0007Q1-FG
 for qemu-devel@nongnu.org; Sun, 14 Jun 2026 15:06:11 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1wYq9o-0001eI-MB
 for qemu-devel@nongnu.org; Sun, 14 Jun 2026 15:06:10 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1781463968;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=AJr3eu+AuR7FAiU+yG3Gt396W13EZFiJzLPt71reZ20=;
 b=ZSowemuig89Reap86XlWQffasGbkMCHzrCpZyOB1aADsLBDkcC/EfdIiE0RnAoj2zhEns1
 Mxx8pumEQq/2knHLK4Rx1xXeIwi3o/N2M8g0Izr2cCakBPu5TKJ9vkPtul3D9ijHEozrCh
 4B2OhWdfQPS/WLp9cAxoyjALJ2O+N2c=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-541-pQtxObrEORSxbGDGuw9C1A-1; Sun, 14 Jun 2026 15:06:06 -0400
X-MC-Unique: pQtxObrEORSxbGDGuw9C1A-1
X-Mimecast-MFC-AGG-ID: pQtxObrEORSxbGDGuw9C1A_1781463965
Received: by mail-wm1-f71.google.com with SMTP id
 5b1f17b1804b1-490c56e2576so19641215e9.3
 for <qemu-devel@nongnu.org>; Sun, 14 Jun 2026 12:06:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1781463965; x=1782068765; darn=nongnu.org;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=AJr3eu+AuR7FAiU+yG3Gt396W13EZFiJzLPt71reZ20=;
 b=KFY0beOSCDqtrlG6ozKWVj3U80PH4jzlH8STC7gXTzo/yr8XGks3Yn/dSOVPldGKZw
 x63abo+ojqG17w49CYOvbDhlvbYzCZesuy0heo0wTs4l2VL0SZF6yWvQ4DT+C7ZOPN6G
 0ZyqBm9SJ9UwvW5fB/7Uv9+RNOHXP6riguJd+VlXxHOUQOiLaEvY4+7foj2U5zoNk44A
 h6I7/9o7QZ/MzmQfMQFH1jPYVZ5UJ1PoWCdBOTgZeZQHMzrQPHu7v3RnMPfEl+BFNl2A
 iCU12i1eai/sGXhraD4BM6MyEmspL55aB8yum66l1Z/aISPGmW3XcjdkM80Ka5cnHoIv
 dQPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1781463965; x=1782068765;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=AJr3eu+AuR7FAiU+yG3Gt396W13EZFiJzLPt71reZ20=;
 b=Puc8fIRrRAesy3fxB55uyRnWpcpi87UagfeVXAcoJYCIbHWrYJoLc+5bXn8ScASXf/
 a6FDXsxymJ/0K1UcodNPHlCpkQudNS7Kjj5kED92hBC4EODsUO4eIO3AXHn4eM4E7f/7
 WCoZSCCymiDvlYznQ0k/exSnvUZrvMInkDPfbUqecf+9I+A7Z0MGT4La/8q0oj1mL+8/
 rYXuCEQWqt+7fHkkya5m+qEK+5CPuNV0/sO72T2FZU5ICDfy87D0BNbpjaPKNKlGa2Ra
 kET2KjeV662jI9JrFvu/1hoNI3OsOBk/mDRZstKK3fiqcBUo4hTMJ7qnI9zYKH0acAkI
 ASWw==
X-Gm-Message-State: AOJu0YyjKEgO3gxVdrF2V5C+H0bIaiEqI5oLzkLYICoVigz2SiNW82rk
 j8tgZLjCqVmktEj9mS1i8R92z9atuFDDSobC1KBDJBabqV9PEGjY9qjHgNSoO1OLg8j3Nl5ta6/
 SPjxMyNbVx+6sH0aUX5Xn77rkUzAgFek0LdUPKAN7ZTHmeADxrwxosqiD6wUeMjR+G6Ef+1R6Ku
 4OtibbhGlcaSPbkdAgfYM0Q5MICQCgT8Ltrg==
X-Gm-Gg: Acq92OHixVwnsDHekP8xV2axq4Dtd05emH8s7AYbmGc21E1PQeZvUbjWZggX9y9NKrD
 Jb9ySTCe/dR0wIU7ae2Juhft7C/LLIXmnDUZRwa11mn55SQpAJBxgt69XWnKyw09euHO9QX4dpn
 TWISgkBHS5cKDwhZJuiMK5mrO1BRwjtrQsqtkm5p3/iNYcHttvsLE7VfsWS4mBgI667u9KcXDWa
 WVPD5pnJtpxlggVN0HS/Jv+UGS3KSJ9XOBOajn77nzjlMqONrzUrh8kE3yAAfZAA1Mee2yjE9e7
 vvmhTj5WHnipnsXULiQx/Cy64AXLe7MrcYpCQNyDTq3I9KvYtSyGFHu4Ij6uUykVSaRL+uzkyGJ
 5s2DIDSNjCid7oo8RonqtSAYSLIJ/k5OvQbUc/PkrkZo=
X-Received: by 2002:a05:600d:8497:10b0:490:be41:87c6 with SMTP id
 5b1f17b1804b1-490ec4a8309mr99676505e9.10.1781463965336; 
 Sun, 14 Jun 2026 12:06:05 -0700 (PDT)
X-Received: by 2002:a05:600d:8497:10b0:490:be41:87c6 with SMTP id
 5b1f17b1804b1-490ec4a8309mr99676105e9.10.1781463964764; 
 Sun, 14 Jun 2026 12:06:04 -0700 (PDT)
Received: from redhat.com (IGLD-80-230-85-71.inter.net.il. [80.230.85.71])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-49220368ef4sm181845835e9.12.2026.06.14.12.06.03
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 14 Jun 2026 12:06:04 -0700 (PDT)
Date: Sun, 14 Jun 2026 15:06:02 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Zhenzhong Duan <zhenzhong.duan@intel.com>,
 Yi Liu <yi.l.liu@intel.com>, Xudong Hao <xudong.hao@intel.com>,
 Shameer Kolothum <skolothumtho@nvidia.com>,
 Alex Williamson <alex@shazbot.org>,
 =?utf-8?Q?C=C3=A9dric?= Le Goater <clg@redhat.com>,
 Eric Auger <eric.auger@redhat.com>
Subject: [PULL 008/106] vfio/iommufd: Create nesting parent hwpt with
 IOMMU_HWPT_ALLOC_PASID flag
Message-ID: <8c12118f7bad41cd544803f23da323d2cb61dae7.1781463125.git.mst@redhat.com>
References: <cover.1781463125.git.mst@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1781463125.git.mst@redhat.com>
X-Mailer: git-send-email 2.51.2.2891.g4157995a80.dirty
X-Mutt-Fcc: =sent
Received-SPF: pass client-ip=170.10.129.124; envelope-from=mst@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.445,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

When both device and vIOMMU have PASID enabled, then guest may setup
pasid usages such as SVM.

VFIO needs to be aware of potential pasid usage and should attach the
non-pasid part of pasid-capable device to hwpt flagged with
IOMMU_HWPT_ALLOC_PASID.

ARM SMMU doesn't support IOMMU_HWPT_ALLOC_PASID, only VTD need it. So
we can't check the existing vIOMMU flag VIOMMU_FLAG_PASID_SUPPORTED to
determine if set flag IOMMU_HWPT_ALLOC_PASID. Instead, introduce a new
flag VIOMMU_FLAG_WANT_PASID_ATTACH which will only be exposed by VTD.

Opportunistically add documentation for VIOMMU_FLAG_PASID_SUPPORTED
and explain the difference with VIOMMU_FLAG_WANT_PASID_ATTACH.

Signed-off-by: Zhenzhong Duan <zhenzhong.duan@intel.com>
Reviewed-by: Yi Liu <yi.l.liu@intel.com>
Tested-by: Xudong Hao <xudong.hao@intel.com>
Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
Message-Id: <20260527054658.1021096-4-zhenzhong.duan@intel.com>
Reviewed-by: Shameer Kolothum <skolothumtho@nvidia.com>
Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
---
 hw/vfio/device.c              | 11 +++++++++++
 hw/vfio/iommufd.c             |  8 +++++++-
 include/hw/core/iommu.h       | 11 +++++++++++
 include/hw/vfio/vfio-device.h |  1 +
 4 files changed, 30 insertions(+), 1 deletion(-)

diff --git a/hw/vfio/device.c b/hw/vfio/device.c
index ccf14743e9..1a7f8088aa 100644
--- a/hw/vfio/device.c
+++ b/hw/vfio/device.c
@@ -543,6 +543,17 @@ bool vfio_device_get_viommu_flags_want_nesting(VFIODevice *vbasedev)
     return false;
 }
 
+bool vfio_device_get_viommu_flags_want_pasid_attach(VFIODevice *vbasedev)
+{
+    VFIOPCIDevice *vdev = vfio_pci_from_vfio_device(vbasedev);
+
+    if (vdev) {
+        return !!(pci_device_get_viommu_flags(PCI_DEVICE(vdev)) &
+                  VIOMMU_FLAG_WANT_PASID_ATTACH);
+    }
+    return false;
+}
+
 bool vfio_device_get_host_iommu_quirk_bypass_ro(VFIODevice *vbasedev,
                                                 uint32_t type, void *caps,
                                                 uint32_t size)
diff --git a/hw/vfio/iommufd.c b/hw/vfio/iommufd.c
index 78e7b6a045..0718f029ca 100644
--- a/hw/vfio/iommufd.c
+++ b/hw/vfio/iommufd.c
@@ -364,6 +364,7 @@ static bool iommufd_cdev_autodomains_get(VFIODevice *vbasedev,
     VendorCaps caps;
     VFIOIOASHwpt *hwpt;
     uint32_t hwpt_id;
+    uint8_t max_pasid_log2 = 0;
     int ret;
 
     /* Try to find a domain */
@@ -409,7 +410,7 @@ static bool iommufd_cdev_autodomains_get(VFIODevice *vbasedev,
      */
     if (!iommufd_backend_get_device_info(vbasedev->iommufd, vbasedev->devid,
                                          &type, &caps, sizeof(caps), &hw_caps,
-                                         NULL, errp)) {
+                                         &max_pasid_log2, errp)) {
         return false;
     }
 
@@ -437,6 +438,11 @@ static bool iommufd_cdev_autodomains_get(VFIODevice *vbasedev,
         }
     }
 
+    if (max_pasid_log2 &&
+        vfio_device_get_viommu_flags_want_pasid_attach(vbasedev)) {
+        flags |= IOMMU_HWPT_ALLOC_PASID;
+    }
+
     if (cpr_is_incoming()) {
         hwpt_id = vbasedev->cpr.hwpt_id;
         goto skip_alloc;
diff --git a/include/hw/core/iommu.h b/include/hw/core/iommu.h
index 7fb5c81c9f..fd513d6472 100644
--- a/include/hw/core/iommu.h
+++ b/include/hw/core/iommu.h
@@ -20,9 +20,20 @@
 enum viommu_flags {
     /* vIOMMU needs nesting parent HWPT to create nested HWPT */
     VIOMMU_FLAG_WANT_NESTING_PARENT = BIT_ULL(0),
+    /*
+     * vIOMMU supports PASID capability, VFIO checks this flag and synthesize
+     * a PASID capability.
+     */
     VIOMMU_FLAG_PASID_SUPPORTED = BIT_ULL(1),
     /* vIOMMU needs dirty tracking on the nesting parent HWPT for nested use */
     VIOMMU_FLAG_WANT_NESTING_DIRTY_TRACKING = BIT_ULL(2),
+    /*
+     * vIOMMU requests other sub-system like VFIO to create a HWPT that can be
+     * used with PASID attachment. VIOMMU_FLAG_PASID_SUPPORTED can't be used
+     * for this purpose as PASID attachment is needed by VTD IOMMU but not ARM
+     * SMMU.
+     */
+    VIOMMU_FLAG_WANT_PASID_ATTACH = BIT_ULL(3),
 };
 
 /* Host IOMMU quirks. Extracted from host IOMMU capabilities */
diff --git a/include/hw/vfio/vfio-device.h b/include/hw/vfio/vfio-device.h
index 380a55d6e5..8472420d3f 100644
--- a/include/hw/vfio/vfio-device.h
+++ b/include/hw/vfio/vfio-device.h
@@ -282,6 +282,7 @@ void vfio_device_unprepare(VFIODevice *vbasedev);
 
 bool vfio_device_get_viommu_flags_want_nesting(VFIODevice *vbasedev);
 bool vfio_device_get_viommu_flags_want_nesting_dirty(VFIODevice *vbasedev);
+bool vfio_device_get_viommu_flags_want_pasid_attach(VFIODevice *vbasedev);
 bool vfio_device_get_host_iommu_quirk_bypass_ro(VFIODevice *vbasedev,
                                                 uint32_t type, void *caps,
                                                 uint32_t size);
-- 
MST


