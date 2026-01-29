Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 208E6D6B086
	for <qemu-devel@archiver.kernel.org>; Thu, 29 Jan 2026 16:09:57 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vlUaK-0008Sj-Mu; Thu, 29 Jan 2026 11:09:32 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1vlUaE-0008QY-NY
 for qemu-devel@nongnu.org; Thu, 29 Jan 2026 11:09:27 -0500
Received: from mail-wm1-x32c.google.com ([2a00:1450:4864:20::32c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1vlUaB-0006UR-SE
 for qemu-devel@nongnu.org; Thu, 29 Jan 2026 11:09:25 -0500
Received: by mail-wm1-x32c.google.com with SMTP id
 5b1f17b1804b1-480142406b3so8835355e9.1
 for <qemu-devel@nongnu.org>; Thu, 29 Jan 2026 08:09:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1769702962; x=1770307762; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=T0N0B5cWcZZOhJc+vK4KHyIYqbyF+U6ChwUVIRwX2tA=;
 b=aTPB5D10lIdQ/H9E8ir4KQO26Y4c+K27ieq65BWmaBnsWHoebxUYz+VXEayXoLjO0q
 JARhnHNtFZtWlP6MjoXOILDOnw2VWshxoybxZCHU6lU4ohKN7mdobZ1NxZ8V5/7NbWjn
 JwwLQMvgr4v3d9KV92BJgkKSFvOKZGPebIFzqnJOjDORJsybHdC6t0u77mO+H9zLStPv
 QQQVxogHkvZJIlq4HvqminxM4xuzEay/T19HrrhxZ7tfZ1SrxuKsZJ17SFHoTXVBHimD
 DcdGSQMrpVRT6YyBWdNWN7EA0aVBIvMNIIixIJcerS8UC29WxMlO/kKn3xLCIsDWB8aT
 B+vQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1769702962; x=1770307762;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=T0N0B5cWcZZOhJc+vK4KHyIYqbyF+U6ChwUVIRwX2tA=;
 b=r8SdvwixmY8U8t99dWLGrAIwL8XYrMdbJVCcv7vFP7MK4qMg/gW7UzM1QmBCjmWBwZ
 E1+5iTmXMRcEPR68iAILU8h+1x/7/5eYK4hF5U5kL7zAo/OQ5JPFBLjmGxx1Kgrld85M
 Vc+PdmhzgI7PIVKXRqJn7enGkvW9+APJRcoSwq8RJDpnSy+DfecQZAAsC5V5sz4ALHOm
 nf67k7IfT0eIE8H/0Eevipo9xC51gp7HyTnS50RC85kwhlJCpCLQ8FowTfcfeve11FmZ
 cpLH2RSxUIU3obVnsr/8LAVmxEtNh1qgjNauRK1x36wqSEmUT6eHPON8qEFAIyD11Cq+
 FtoQ==
X-Gm-Message-State: AOJu0Yy6IrRoWVFwS/y4bxh/23iUWx5hNaZuUoEWGAuD67jz0zsr8PRo
 amk5pj2plGYGPQVH5ByoaMSr070SgSvPlaIfmJ5nNtSwqoSbHjm7Wtv9FYmVCo3k1DgRAnlXnXi
 NRKPwCoc=
X-Gm-Gg: AZuq6aKGf8bGvZxzuy62Q5gNecpDa1g+71nrUczMJK8rJe6nyp3JW7vOSxUg4NehtaJ
 frZ18QIbWwv2cM+1GpCfkMfkhta7TP1FKjp/U05FHn4JlQcRNBOnpSGfw71n6f3A942PXM1JcPa
 gGzHOZ+vontOaUTdfE/phxgSVv80gwzWxI8E9vk+FAQOj5ozV5OzYyt7GGM8gooWPDkntjIov+q
 WvaSuEGqGqRjNFIKm0cXpIMBAFnjbJ564Vs0B/v/1yptWLNUw5ebOhUmV2/N9XbT2dHBer5TQCw
 4KaPpdjygYaZN7ihXnBam5eQBGBPiaA53PKdztRUtzaK3UOpLjzch0TDrVJQLHDINYJ+s+yIbVa
 xM/YdUXDjNQqR0TYbjkAHJaw+t5LiBviqxVmCqMHw+AC215NKRHpGt2cHOFRfFpRxPaM2mefmTA
 35wQTuHbp6Vqik6/M3KcX+Q3R3ovJAFVSvUJIZuJop
X-Received: by 2002:a05:6000:1a8d:b0:431:1ae:a3be with SMTP id
 ffacd0b85a97d-435f3a6f7fbmr156796f8f.3.1769702962318; 
 Thu, 29 Jan 2026 08:09:22 -0800 (PST)
Received: from lanath.. (wildly.archaic.org.uk. [81.2.115.145])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-435e10edf62sm16762185f8f.13.2026.01.29.08.09.20
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 29 Jan 2026 08:09:20 -0800 (PST)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 02/43] backends/iommufd: Introduce iommufd_backend_alloc_vdev
Date: Thu, 29 Jan 2026 16:08:36 +0000
Message-ID: <20260129160917.1415092-3-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260129160917.1415092-1-peter.maydell@linaro.org>
References: <20260129160917.1415092-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32c;
 envelope-from=peter.maydell@linaro.org; helo=mail-wm1-x32c.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

From: Nicolin Chen <nicolinc@nvidia.com>

Add a helper to allocate an iommufd device's virtual device (in the user
space) per a viommu instance.

While at it, introduce a struct IOMMUFDVdev for later use by vendor
IOMMU implementations.

Signed-off-by: Nicolin Chen <nicolinc@nvidia.com>
Reviewed-by: Eric Auger <eric.auger@redhat.com>
Signed-off-by: Shameer Kolothum <shameerali.kolothum.thodi@huawei.com>
Reviewed-by: Jonathan Cameron <jonathan.cameron@huawei.com>
Tested-by: Zhangfei Gao <zhangfei.gao@linaro.org>
Tested-by: Eric Auger <eric.auger@redhat.com>
Signed-off-by: Shameer Kolothum <skolothumtho@nvidia.com>
Reviewed-by: Yi Liu <yi.l.liu@intel.com>
Message-id: 20260126104342.253965-3-skolothumtho@nvidia.com
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 backends/iommufd.c       | 27 +++++++++++++++++++++++++++
 backends/trace-events    |  1 +
 include/system/iommufd.h | 12 ++++++++++++
 3 files changed, 40 insertions(+)

diff --git a/backends/iommufd.c b/backends/iommufd.c
index c65dc41d71..e3a3c1480e 100644
--- a/backends/iommufd.c
+++ b/backends/iommufd.c
@@ -473,6 +473,33 @@ bool iommufd_backend_alloc_viommu(IOMMUFDBackend *be, uint32_t dev_id,
     return true;
 }
 
+bool iommufd_backend_alloc_vdev(IOMMUFDBackend *be, uint32_t dev_id,
+                                uint32_t viommu_id, uint64_t virt_id,
+                                uint32_t *out_vdev_id, Error **errp)
+{
+    int ret;
+    struct iommu_vdevice_alloc alloc_vdev = {
+        .size = sizeof(alloc_vdev),
+        .viommu_id = viommu_id,
+        .dev_id = dev_id,
+        .virt_id = virt_id,
+    };
+
+    ret = ioctl(be->fd, IOMMU_VDEVICE_ALLOC, &alloc_vdev);
+
+    trace_iommufd_backend_alloc_vdev(be->fd, dev_id, viommu_id, virt_id,
+                                     alloc_vdev.out_vdevice_id, ret);
+
+    if (ret) {
+        error_setg_errno(errp, errno, "IOMMU_VDEVICE_ALLOC failed");
+        return false;
+    }
+
+    g_assert(out_vdev_id);
+    *out_vdev_id = alloc_vdev.out_vdevice_id;
+    return true;
+}
+
 bool host_iommu_device_iommufd_attach_hwpt(HostIOMMUDeviceIOMMUFD *idev,
                                            uint32_t hwpt_id, Error **errp)
 {
diff --git a/backends/trace-events b/backends/trace-events
index 1ae94c4290..14a7ecf5aa 100644
--- a/backends/trace-events
+++ b/backends/trace-events
@@ -22,3 +22,4 @@ iommufd_backend_set_dirty(int iommufd, uint32_t hwpt_id, bool start, int ret) "
 iommufd_backend_get_dirty_bitmap(int iommufd, uint32_t hwpt_id, uint64_t iova, uint64_t size, uint64_t flags, uint64_t page_size, int ret) " iommufd=%d hwpt=%u iova=0x%"PRIx64" size=0x%"PRIx64" flags=0x%"PRIx64" page_size=0x%"PRIx64" (%d)"
 iommufd_backend_invalidate_cache(int iommufd, uint32_t id, uint32_t data_type, uint32_t entry_len, uint32_t entry_num, uint32_t done_num, uint64_t data_ptr, int ret) " iommufd=%d id=%u data_type=%u entry_len=%u entry_num=%u done_num=%u data_ptr=0x%"PRIx64" (%d)"
 iommufd_backend_alloc_viommu(int iommufd, uint32_t dev_id, uint32_t type, uint32_t hwpt_id, uint32_t viommu_id, int ret) " iommufd=%d type=%u dev_id=%u hwpt_id=%u viommu_id=%u (%d)"
+iommufd_backend_alloc_vdev(int iommufd, uint32_t dev_id, uint32_t viommu_id, uint64_t virt_id, uint32_t vdev_id, int ret) " iommufd=%d dev_id=%u viommu_id=%u virt_id=0x%"PRIx64" vdev_id=%u (%d)"
diff --git a/include/system/iommufd.h b/include/system/iommufd.h
index bc4acd1e8b..567dfb7b1d 100644
--- a/include/system/iommufd.h
+++ b/include/system/iommufd.h
@@ -48,6 +48,14 @@ typedef struct IOMMUFDViommu {
     uint32_t viommu_id;  /* virtual IOMMU ID of allocated object */
 } IOMMUFDViommu;
 
+/*
+ * Virtual device object for a physical device bind to a vIOMMU.
+ */
+typedef struct IOMMUFDVdev {
+    uint32_t vdevice_id; /* object handle for vDevice */
+    uint32_t virt_id;  /* virtual device ID */
+} IOMMUFDVdev;
+
 bool iommufd_backend_connect(IOMMUFDBackend *be, Error **errp);
 void iommufd_backend_disconnect(IOMMUFDBackend *be);
 
@@ -73,6 +81,10 @@ bool iommufd_backend_alloc_viommu(IOMMUFDBackend *be, uint32_t dev_id,
                                   uint32_t viommu_type, uint32_t hwpt_id,
                                   uint32_t *out_hwpt, Error **errp);
 
+bool iommufd_backend_alloc_vdev(IOMMUFDBackend *be, uint32_t dev_id,
+                                uint32_t viommu_id, uint64_t virt_id,
+                                uint32_t *out_vdev_id, Error **errp);
+
 bool iommufd_backend_set_dirty_tracking(IOMMUFDBackend *be, uint32_t hwpt_id,
                                         bool start, Error **errp);
 bool iommufd_backend_get_dirty_bitmap(IOMMUFDBackend *be, uint32_t hwpt_id,
-- 
2.43.0


