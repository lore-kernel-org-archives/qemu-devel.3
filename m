Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DEDC8D6B086
	for <qemu-devel@archiver.kernel.org>; Thu, 29 Jan 2026 16:10:17 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vlUaH-0008RM-Q3; Thu, 29 Jan 2026 11:09:29 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1vlUaD-0008QH-44
 for qemu-devel@nongnu.org; Thu, 29 Jan 2026 11:09:25 -0500
Received: from mail-wr1-x430.google.com ([2a00:1450:4864:20::430])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1vlUaA-0006Tz-4h
 for qemu-devel@nongnu.org; Thu, 29 Jan 2026 11:09:24 -0500
Received: by mail-wr1-x430.google.com with SMTP id
 ffacd0b85a97d-43591b55727so1042227f8f.3
 for <qemu-devel@nongnu.org>; Thu, 29 Jan 2026 08:09:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1769702960; x=1770307760; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=OFYLZeT7ofyrXtsXvZMxt3gggy8HcN1+3roFl5J8Wow=;
 b=tu7baT6Dl87A6ThM+/M5EKi+Yi7M7oHF6cwj6tOj6T74FSQgIKzBb+UePfIQAHhFKt
 cvKrwM7++NmwwyY0dZ1A7XMXGUpt7kMHtmvg32ntGu/pIyLNsNaglGhItFZ7T1esoWOR
 x0j8DsQ3DaU/68DCRtG5B3a3ueT2JPa3+BJv21aFTRQsVri5h0SNNQHabeBwSCJOvT+Y
 04vwEvlzZZ2vuVWcUb4AbCM7GN3jstej40EJOolBTal2bAVyqP33CmHPtm5zsKABjKXw
 VQaobqTaNydIQDmkTxmxOAdMM54PPgB7bDYEweTZ2RXorKa+ll3+fkc2nOLN39eU/g/5
 fMtg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1769702960; x=1770307760;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=OFYLZeT7ofyrXtsXvZMxt3gggy8HcN1+3roFl5J8Wow=;
 b=tqtuiX6/2AMfmAUT59MIC8WwvP/vVK6F2BcVikcV0t7uWbCBCtEjZcnCfKzjFMYaF1
 vbR2BfTDiEdsW9tRfXKE9diJVaxcpWaSKrRzJnJztGI/JoOZaf+AVESGtYIVEXIsVSzd
 Df+4jMQjPnQQcLy/klTSURszG5lHnylr1R8tFYlRP6bQ4fjMksk/uX1XC2jcED4LjgnJ
 003vURjSErP14jDF5F5hPQ8ZNwVi76E2bGypg+m+IvOdpCnOliSRvEZwta4MzighrkPE
 OM7/BmeJV7s6e69dXfv28TDAceBBEJM/EcYbLgk6aUrgRUu96WuXr7L1Ax2lhMz7f8n0
 Rdww==
X-Gm-Message-State: AOJu0YwurirbrDK3eZBzl4JUDevYuGROM3hHbp5PX3FndkV4OCKYm0C2
 zH7Q1H5ByD7POasyUoFM5Ae5QHWQmHsTtA+oYVl8BACNjfjbYYsGlJWFCSH+GO4Sw0V9Un2NVAt
 x0AOdIcQ=
X-Gm-Gg: AZuq6aK5o1GJXEtKhN/Ur5BfXXWnLEoOz4j2YMbMXSAZBFFndhMnbtxTPu5JYXcqfZB
 yLVGZJOwzhyYTgwgSg75qN/+nWOmieesPe2xN+1rLHQLH7P2tzFblea9v3fzxdvQd1VIb+LwKBd
 v5j+Dv6Fv/ROW0gV8tvZeujSYJa4vN5m9p1zwpV1Ilors2yVDBWvRQ4Fx3H8u9ncSmIDNZbJLlW
 wctIWQK3nhQ62lZ8Bqgpk8ZDz39nPpeoueyU8Qkwk3Qd8zuSiwqlSsR/zVRpFMMkRWotL+SoN1l
 q7Es9l+AXQZ6Edbw1i7Ji+LGeQ/BPNlXPxDD6XI5SZHUAwixEvcUNKiAEGPNFA5jsVbJqwm/JXn
 NR8GrIm9HT//1RzNB+ohGizx+hNubC/j9v4ZnHakDhExLcSHkzxQc5yV+L/FnRuMMZYN1Eg+VaM
 +7D7RfUx1J1tXrFzBpCfb0SVv43MkxQw==
X-Received: by 2002:a05:6000:1862:b0:435:96ec:679e with SMTP id
 ffacd0b85a97d-435f3a7b8d5mr192408f8f.23.1769702960256; 
 Thu, 29 Jan 2026 08:09:20 -0800 (PST)
Received: from lanath.. (wildly.archaic.org.uk. [81.2.115.145])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-435e10edf62sm16762185f8f.13.2026.01.29.08.09.19
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 29 Jan 2026 08:09:19 -0800 (PST)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 01/43] backends/iommufd: Introduce iommufd_backend_alloc_viommu
Date: Thu, 29 Jan 2026 16:08:35 +0000
Message-ID: <20260129160917.1415092-2-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260129160917.1415092-1-peter.maydell@linaro.org>
References: <20260129160917.1415092-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::430;
 envelope-from=peter.maydell@linaro.org; helo=mail-wr1-x430.google.com
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

Add a helper to allocate a viommu object.

Also introduce a struct IOMMUFDViommu that can be used later by vendor
IOMMU implementations.

Signed-off-by: Nicolin Chen <nicolinc@nvidia.com>
Reviewed-by: Eric Auger <eric.auger@redhat.com>
Reviewed-by: Jonathan Cameron <jonathan.cameron@huawei.com>
Signed-off-by: Shameer Kolothum <shameerali.kolothum.thodi@huawei.com>
Tested-by: Zhangfei Gao <zhangfei.gao@linaro.org>
Tested-by: Eric Auger <eric.auger@redhat.com>
Signed-off-by: Shameer Kolothum <skolothumtho@nvidia.com>
Reviewed-by: Yi Liu <yi.l.liu@intel.com>
Message-id: 20260126104342.253965-2-skolothumtho@nvidia.com
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 backends/iommufd.c       | 26 ++++++++++++++++++++++++++
 backends/trace-events    |  1 +
 include/system/iommufd.h | 14 ++++++++++++++
 3 files changed, 41 insertions(+)

diff --git a/backends/iommufd.c b/backends/iommufd.c
index 086bd67aea..c65dc41d71 100644
--- a/backends/iommufd.c
+++ b/backends/iommufd.c
@@ -447,6 +447,32 @@ bool iommufd_backend_invalidate_cache(IOMMUFDBackend *be, uint32_t id,
     return !ret;
 }
 
+bool iommufd_backend_alloc_viommu(IOMMUFDBackend *be, uint32_t dev_id,
+                                  uint32_t viommu_type, uint32_t hwpt_id,
+                                  uint32_t *out_viommu_id, Error **errp)
+{
+    int ret;
+    struct iommu_viommu_alloc alloc_viommu = {
+        .size = sizeof(alloc_viommu),
+        .type = viommu_type,
+        .dev_id = dev_id,
+        .hwpt_id = hwpt_id,
+    };
+
+    ret = ioctl(be->fd, IOMMU_VIOMMU_ALLOC, &alloc_viommu);
+
+    trace_iommufd_backend_alloc_viommu(be->fd, dev_id, viommu_type, hwpt_id,
+                                       alloc_viommu.out_viommu_id, ret);
+    if (ret) {
+        error_setg_errno(errp, errno, "IOMMU_VIOMMU_ALLOC failed");
+        return false;
+    }
+
+    g_assert(out_viommu_id);
+    *out_viommu_id = alloc_viommu.out_viommu_id;
+    return true;
+}
+
 bool host_iommu_device_iommufd_attach_hwpt(HostIOMMUDeviceIOMMUFD *idev,
                                            uint32_t hwpt_id, Error **errp)
 {
diff --git a/backends/trace-events b/backends/trace-events
index e1992ba12f..1ae94c4290 100644
--- a/backends/trace-events
+++ b/backends/trace-events
@@ -21,3 +21,4 @@ iommufd_backend_free_id(int iommufd, uint32_t id, int ret) " iommufd=%d id=%d (%
 iommufd_backend_set_dirty(int iommufd, uint32_t hwpt_id, bool start, int ret) " iommufd=%d hwpt=%u enable=%d (%d)"
 iommufd_backend_get_dirty_bitmap(int iommufd, uint32_t hwpt_id, uint64_t iova, uint64_t size, uint64_t flags, uint64_t page_size, int ret) " iommufd=%d hwpt=%u iova=0x%"PRIx64" size=0x%"PRIx64" flags=0x%"PRIx64" page_size=0x%"PRIx64" (%d)"
 iommufd_backend_invalidate_cache(int iommufd, uint32_t id, uint32_t data_type, uint32_t entry_len, uint32_t entry_num, uint32_t done_num, uint64_t data_ptr, int ret) " iommufd=%d id=%u data_type=%u entry_len=%u entry_num=%u done_num=%u data_ptr=0x%"PRIx64" (%d)"
+iommufd_backend_alloc_viommu(int iommufd, uint32_t dev_id, uint32_t type, uint32_t hwpt_id, uint32_t viommu_id, int ret) " iommufd=%d type=%u dev_id=%u hwpt_id=%u viommu_id=%u (%d)"
diff --git a/include/system/iommufd.h b/include/system/iommufd.h
index 1392706b83..bc4acd1e8b 100644
--- a/include/system/iommufd.h
+++ b/include/system/iommufd.h
@@ -38,6 +38,16 @@ struct IOMMUFDBackend {
     /*< public >*/
 };
 
+/*
+ * Virtual IOMMU object that represents physical IOMMU's virtualization
+ * support
+ */
+typedef struct IOMMUFDViommu {
+    IOMMUFDBackend *iommufd;
+    uint32_t s2_hwpt_id; /* ID of stage 2 HWPT */
+    uint32_t viommu_id;  /* virtual IOMMU ID of allocated object */
+} IOMMUFDViommu;
+
 bool iommufd_backend_connect(IOMMUFDBackend *be, Error **errp);
 void iommufd_backend_disconnect(IOMMUFDBackend *be);
 
@@ -59,6 +69,10 @@ bool iommufd_backend_alloc_hwpt(IOMMUFDBackend *be, uint32_t dev_id,
                                 uint32_t data_type, uint32_t data_len,
                                 void *data_ptr, uint32_t *out_hwpt,
                                 Error **errp);
+bool iommufd_backend_alloc_viommu(IOMMUFDBackend *be, uint32_t dev_id,
+                                  uint32_t viommu_type, uint32_t hwpt_id,
+                                  uint32_t *out_hwpt, Error **errp);
+
 bool iommufd_backend_set_dirty_tracking(IOMMUFDBackend *be, uint32_t hwpt_id,
                                         bool start, Error **errp);
 bool iommufd_backend_get_dirty_bitmap(IOMMUFDBackend *be, uint32_t hwpt_id,
-- 
2.43.0


