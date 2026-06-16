Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 59596CD98E1
	for <qemu-devel@archiver.kernel.org>; Tue, 16 Jun 2026 19:16:03 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wZZEE-0004pO-N0; Tue, 16 Jun 2026 15:13:46 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1wZZ8Y-0004lt-B0
 for qemu-devel@nongnu.org; Tue, 16 Jun 2026 15:07:52 -0400
Received: from mail-wm1-x332.google.com ([2a00:1450:4864:20::332])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1wZZ8T-0000zH-T6
 for qemu-devel@nongnu.org; Tue, 16 Jun 2026 15:07:49 -0400
Received: by mail-wm1-x332.google.com with SMTP id
 5b1f17b1804b1-490b1bbcf3aso37690415e9.1
 for <qemu-devel@nongnu.org>; Tue, 16 Jun 2026 12:07:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1781636830; x=1782241630; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=CF2PjHRoqnkXEbIdrl1cHC73lx4B4AOTIM81CeISaZE=;
 b=awNBaIKLrw2hY4X8VIN70HMZJqnCUYVYfxheYkYdS/zM8uGzJJlzP07dzXNTRtM2bh
 HD5ufXwRJ+7yVWVtzkXyaOxSjNEkM4UCWDzPlcTWOuh4oJ98SrmIYfX8usfeNT5NjIpK
 swSLxjnY4H3EUVWtJQyStxar7gmj3/n/C6hUVDbkGiwLDK3TU102pGoSCdpNAec3pOQJ
 JSNW2NbjhaVmuuRJIPnYgCRL6e5dd5Hdh124PkfAiyXYIAj5LeuWGUoDBjpxlkNf58jr
 s1P43lm7ryydOsInAt0CxtgcKMUI8cbPe/67Q4DLZ7Z2HkJguLAMlTTgJKqGuYd+synC
 daQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1781636830; x=1782241630;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=CF2PjHRoqnkXEbIdrl1cHC73lx4B4AOTIM81CeISaZE=;
 b=Y95D7uSK5A4olD1GPKe17XlVdn0WnnSZ8hE5N5hKJLEmpuR9vVnbcGwZn5j8VOmWM+
 YpKU0tqgcIbQnRmVyRICFfnpQxWwz1yMkWC3bcsK/3D+68CDlQyE4XQKS3knVAsj4UOn
 I7wwguSYGFZVQ+D5KNfXxzg4k74XMUQcvO8fIsFai36yc5cjP43DfcDB8ETV+Yyc9E0E
 eOg5da2v6/8FdCe8SNCDmcAPCtK6f/MuWOcHhvl3bH5viDU6ikVX5FHgyptW3fjsizC8
 dteinkN5ow3NtIgSxYDpyPTcvmlnUe8AHNCsS7OkwWjHXTTgvqFcoCFpVZE93R1bHUXq
 6bUQ==
X-Gm-Message-State: AOJu0YxhHghHQt8HKaetuU/xJ1sjVv3TfBfott2OEhcI3wj1XbMS4F3O
 p8WYgX7FmbYyTkKR3Za5pMNE/y3J73wc8YDLRblyXRVus3z5/q23S/9AAXsOiuBUp0syqsHoc/q
 sZact
X-Gm-Gg: Acq92OHlp1chZKbrnoVRDUJWheFZvcGtPTKdMNd2+QZSvsJ8YDWmnXtVyT6LBlfOUa+
 dgVNFu43wjoTHe+PDTnEYqtWsxLO9p5u7X1+YxvsCEH6mmkj8KpZg8gQiPeaSwVAVeiUedyrkX9
 ETwV7dMPraHexpopfstb+bm9pG4EgOmjJW9r2JCM3duZnDE2wIkSAm6ZZTOJBXqCJm9UImPXISG
 F7f230oqUVxb0vJGsx/3bOZ8scbdXd24iYu+q9WUbjttJaXADcuOF06F13a87LxIrxdYhz1NluJ
 6qTaja/pJD+0kRHORImeN/F2QmNPackVU61w+jxsbRpS0i7MZXhLI9gVtzDzBhnZqQeZPIm8Sdy
 migGk4YUNAtqqR5xvGCd7oZXAZwqK8/U/ulTUZNhesKUtZtnZL1ZnKE9/CjQNgWMvUCiWovU55y
 pLPSZ+KEKXceSGm8CYOhJnyVGBn8g0hsBAUXyftQZhH7vylzy+Kghtw7uhqNxe65DjtRGLXCcbJ
 G7n8lBd06xXg+ZpvTplFRMgDA++NGJ8
X-Received: by 2002:a05:600c:818f:b0:490:b6a4:9f43 with SMTP id
 5b1f17b1804b1-492333a5291mr15383805e9.7.1781636829660; 
 Tue, 16 Jun 2026 12:07:09 -0700 (PDT)
Received: from lanath.. (wildly.archaic.org.uk. [81.2.115.145])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-4606f2d9becsm45078765f8f.34.2026.06.16.12.07.08
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 16 Jun 2026 12:07:08 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 24/61] hw/arm/tegra241-cmdqv: mmap host VINTF Page0 for CMDQV
Date: Tue, 16 Jun 2026 20:06:01 +0100
Message-ID: <20260616190639.3462006-25-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260616190639.3462006-1-peter.maydell@linaro.org>
References: <20260616190639.3462006-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::332;
 envelope-from=peter.maydell@linaro.org; helo=mail-wm1-x332.google.com
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

The kernel currently exposes a single VINTF per emulated SMMUv3
instance. IOMMU_VIOMMU_ALLOC returns an mmap offset for the host
VINTF Page0 allocated for this SMMU. However, VCMDQs only become
bound to that VINTF after IOMMU_HW_QUEUE_ALLOC, so until then the
mapped Page0 does not back any real VCMDQ state.

mmap the host VINTF Page0 right after IOMMU_VIOMMU_ALLOC, as the host
VINTF is already enabled at that point, and unmap it when the vIOMMU is
freed. The mapping shares the vIOMMU's lifetime. This prepares the VINTF
mapping in advance of subsequent patches that add VCMDQ allocation.

Signed-off-by: Nicolin Chen <nicolinc@nvidia.com>
Tested-by: Nicolin Chen <nicolinc@nvidia.com>
Tested-by: Eric Auger <eric.auger@redhat.com>
Signed-off-by: Shameer Kolothum <skolothumtho@nvidia.com>
Reviewed-by: Eric Auger <eric.auger@redhat.com>
Message-id: 20260609112552.378999-15-skolothumtho@nvidia.com
Co-developed-by: Shameer Kolothum <skolothumtho@nvidia.com>
Signed-off-by: Shameer Kolothum <skolothumtho@nvidia.com>
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 hw/arm/tegra241-cmdqv.c | 16 +++++++++++++++-
 hw/arm/tegra241-cmdqv.h |  3 +++
 2 files changed, 18 insertions(+), 1 deletion(-)

diff --git a/hw/arm/tegra241-cmdqv.c b/hw/arm/tegra241-cmdqv.c
index c1351c8519..3eec6073a4 100644
--- a/hw/arm/tegra241-cmdqv.c
+++ b/hw/arm/tegra241-cmdqv.c
@@ -41,6 +41,10 @@ static void tegra241_cmdqv_free_viommu(SMMUv3State *s)
         g_free(veventq);
         cmdqv->veventq = NULL;
     }
+    if (cmdqv->vintf_page0) {
+        munmap(cmdqv->vintf_page0, VINTF_PAGE_SIZE);
+        cmdqv->vintf_page0 = NULL;
+    }
     iommufd_backend_free_id(viommu->iommufd, viommu->viommu_id);
 }
 
@@ -60,13 +64,20 @@ tegra241_cmdqv_alloc_viommu(SMMUv3State *s, HostIOMMUDeviceIOMMUFD *idev,
         return false;
     }
 
+    if (!iommufd_backend_viommu_mmap(idev->iommufd, viommu_id, VINTF_PAGE_SIZE,
+                                     cmdqv->cmdqv_data->out_vintf_mmap_offset,
+                                     &cmdqv->vintf_page0, errp)) {
+        error_append_hint(errp, "Tegra241 CMDQV: failed to mmap VINTF page0");
+        goto free_viommu;
+    }
+
     if (!iommufd_backend_alloc_veventq(idev->iommufd, viommu_id,
                                        IOMMU_VEVENTQ_TYPE_TEGRA241_CMDQV,
                                        1 << SMMU_EVENTQS, &veventq_id,
                                        &veventq_fd,
                                        errp)) {
         error_append_hint(errp, "Tegra241 CMDQV: failed to alloc veventq");
-        goto free_viommu;
+        goto munmap_page0;
     }
 
     veventq = g_new(IOMMUFDVeventq, 1);
@@ -77,6 +88,9 @@ tegra241_cmdqv_alloc_viommu(SMMUv3State *s, HostIOMMUDeviceIOMMUFD *idev,
     *out_viommu_id = viommu_id;
     return true;
 
+munmap_page0:
+    munmap(cmdqv->vintf_page0, VINTF_PAGE_SIZE);
+    cmdqv->vintf_page0 = NULL;
 free_viommu:
     iommufd_backend_free_id(idev->iommufd, viommu_id);
     return false;
diff --git a/hw/arm/tegra241-cmdqv.h b/hw/arm/tegra241-cmdqv.h
index 9fc720e96c..00c83b6186 100644
--- a/hw/arm/tegra241-cmdqv.h
+++ b/hw/arm/tegra241-cmdqv.h
@@ -25,6 +25,8 @@
  */
 #define TEGRA241_CMDQV_IO_LEN 0x50000
 
+#define VINTF_PAGE_SIZE 0x10000
+
 struct iommu_viommu_tegra241_cmdqv;
 
 typedef struct Tegra241CMDQV {
@@ -33,6 +35,7 @@ typedef struct Tegra241CMDQV {
     MemoryRegion mmio_cmdqv;
     qemu_irq irq;
     IOMMUFDVeventq *veventq;
+    void *vintf_page0;
 } Tegra241CMDQV;
 
 const SMMUv3AccelCmdqvOps *tegra241_cmdqv_get_ops(void);
-- 
2.43.0


