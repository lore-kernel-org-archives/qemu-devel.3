Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5B56ACD98EE
	for <qemu-devel@archiver.kernel.org>; Tue, 16 Jun 2026 19:09:53 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wZZAJ-0005yS-Ey; Tue, 16 Jun 2026 15:09:40 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1wZZ80-0004V7-1R
 for qemu-devel@nongnu.org; Tue, 16 Jun 2026 15:07:28 -0400
Received: from mail-wm1-x336.google.com ([2a00:1450:4864:20::336])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1wZZ7u-0000wy-JE
 for qemu-devel@nongnu.org; Tue, 16 Jun 2026 15:07:13 -0400
Received: by mail-wm1-x336.google.com with SMTP id
 5b1f17b1804b1-4923139e940so6403245e9.3
 for <qemu-devel@nongnu.org>; Tue, 16 Jun 2026 12:06:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1781636818; x=1782241618; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=HvDKsaFNygtdm+lex5RPr5AUTu5fxx81lRj/cLRW5Mo=;
 b=Eq8eEJ5x7yrb6v2uLlGXOkzwNTXb59+Dafq88p6zI7bgADlX/3Z7xXqeJWhLh+/7+X
 1oOYLymjRNCF9bXfdskVvRXaiG6egBGakxIT7FInHJ1GWYICvFsU1ZdJFoIjxQEmwa2B
 4yIDNFK5ctSRrx9+c5r9eMMS3mREesmHj09KleNyJbaLLOyB94APLJYtOkpmTevrOyFr
 5H7GNliNKlW9/ZRPa4lqo7KbdDoymyPE68D+DCAz6BDBUxM0zbXGioZSBcH4FqXKrQV1
 AEV4LIjhTSDLF5iXoEDv9BcZu1dfWJXMYa1dEN0KpoCZZZutLLsVcWsdEEGST1Ldk2nH
 DU4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1781636818; x=1782241618;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=HvDKsaFNygtdm+lex5RPr5AUTu5fxx81lRj/cLRW5Mo=;
 b=IHyyxPp4XLtOhI1xIettXT9GF7gIZkn/cyxgm9Ma0sLZEUlDeg/QUAEK32FpAhEau2
 w00/kyvUIe7R5zKrgUzKOwR2BqSX9zYS11lWyXPM6BP2I0yc/q2MWe/I8r9YvMItSuVv
 /22qsU8nwgIjUzgj/7kqykQDIXOM8L4fJbsZD4crF9V0qDvS+x9lujhg5rArnFphU9XP
 PUZnExfvf/tT+/073n91oI0aeghvIS+auJPrjJKTsQ11FyaCDcuVTAk4w6WzRiXPXisv
 1NOHiiOtqnnqWNwHVc/2UAN0RUTlZWVGmfBHnXAAeZhR9ygLm26KEFJeKEyfwx/fkgx5
 KTlQ==
X-Gm-Message-State: AOJu0YyFhYUkVJzoP28uC5GJQ3Mp/3V8odFQgu9HLRJQ/sCBfsU81CCm
 qTU3BxdAEnHpk8WTIIPtva4zt9pO4/ptQ9vL1w/D4b8lHV/7CqlqIpjFNR8DfseKhkobhI8sHv3
 PozlY
X-Gm-Gg: Acq92OEwvIp22Cv/dgjg7bzDKOJkxV7DHH9kyLkblf9DC3+dEFrocYFA+0cWXEYAJQf
 wxMbb4iFR4RXeI1xh8IwMB6od3gP2t87KI1FObjC9yb9vZLljbrjCJLU/uvUhOMB2/ijajlHmXI
 GqDkBnLKG/VebRqxDcv6UaEJolPkiKsFNeOsUIsX2pJujjCemEkgSV4GG2fej2wewlJhnVtK7mY
 2Rj8AbaXAOSkkRw9alTC+RYs75+SiXm4D+t6VdF7Viymmy3+M9v62Xw/Eg9iOEzXWAs3+8qpD6W
 xjl8jCxC3pq8bsHCvDNPk9v0YlVqBlyxBSxc9h6idBZhuQN7i506akLfPHr/vWMn5Zrv6t5j7N/
 lFg7azVb4FfgAl5LTjkpRPfKNUV9wJmyotlaalxoRBLlPTh9/0foDB7FU1At+FlJIKQ7dE3vjrc
 2rlUfezF0YNWQ1dho/9Zn/r639Ij8oPVEQAypRrKF3TY6vhwHRhS0DKQySinoINT2RjNRH4xKnU
 TwDshHJRIdZV5ThicukBrvjVH1pL/Gs1QHFogKBkJY=
X-Received: by 2002:a05:600c:6090:b0:492:30f2:963a with SMTP id
 5b1f17b1804b1-492340c9cecmr260145e9.0.1781636817577; 
 Tue, 16 Jun 2026 12:06:57 -0700 (PDT)
Received: from lanath.. (wildly.archaic.org.uk. [81.2.115.145])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-4606f2d9becsm45078765f8f.34.2026.06.16.12.06.56
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 16 Jun 2026 12:06:56 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 13/61] backends/iommufd: Introduce
 iommufd_backend_alloc_hw_queue
Date: Tue, 16 Jun 2026 20:05:50 +0100
Message-ID: <20260616190639.3462006-14-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260616190639.3462006-1-peter.maydell@linaro.org>
References: <20260616190639.3462006-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::336;
 envelope-from=peter.maydell@linaro.org; helo=mail-wm1-x336.google.com
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

Add a helper to allocate an iommufd backed HW queue for a vIOMMU.

While at it, define a struct IOMMUFDHWqueue for use by vendor
implementations.

Signed-off-by: Nicolin Chen <nicolinc@nvidia.com>
Reviewed-by: Eric Auger <eric.auger@redhat.com>
Tested-by: Nicolin Chen <nicolinc@nvidia.com>
Signed-off-by: Shameer Kolothum <skolothumtho@nvidia.com>
Tested-by: Eric Auger <eric.auger@redhat.com>
Message-id: 20260609112552.378999-4-skolothumtho@nvidia.com
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 backends/iommufd.c       | 31 +++++++++++++++++++++++++++++++
 backends/trace-events    |  1 +
 include/system/iommufd.h | 11 +++++++++++
 3 files changed, 43 insertions(+)

diff --git a/backends/iommufd.c b/backends/iommufd.c
index c745dbd2b1..8eaaf456e8 100644
--- a/backends/iommufd.c
+++ b/backends/iommufd.c
@@ -549,6 +549,37 @@ bool iommufd_backend_alloc_veventq(IOMMUFDBackend *be, uint32_t viommu_id,
     return true;
 }
 
+bool iommufd_backend_alloc_hw_queue(IOMMUFDBackend *be, uint32_t viommu_id,
+                                    uint32_t queue_type, uint32_t index,
+                                    uint64_t addr, uint64_t length,
+                                    uint32_t *out_hw_queue_id, Error **errp)
+{
+    int ret;
+    struct iommu_hw_queue_alloc alloc_hw_queue = {
+        .size = sizeof(alloc_hw_queue),
+        .flags = 0,
+        .viommu_id = viommu_id,
+        .type = queue_type,
+        .index = index,
+        .nesting_parent_iova = addr,
+        .length = length,
+    };
+
+    ret = ioctl(be->fd, IOMMU_HW_QUEUE_ALLOC, &alloc_hw_queue);
+
+    trace_iommufd_backend_alloc_hw_queue(be->fd, viommu_id, queue_type,
+                                         index, addr, length,
+                                         alloc_hw_queue.out_hw_queue_id, ret);
+    if (ret) {
+        error_setg_errno(errp, errno, "IOMMU_HW_QUEUE_ALLOC failed");
+        return false;
+    }
+
+    g_assert(out_hw_queue_id);
+    *out_hw_queue_id = alloc_hw_queue.out_hw_queue_id;
+    return true;
+}
+
 bool host_iommu_device_iommufd_attach_hwpt(HostIOMMUDeviceIOMMUFD *hiodi,
                                            uint32_t hwpt_id, Error **errp)
 {
diff --git a/backends/trace-events b/backends/trace-events
index 3ba0c3503c..c5c1d95aad 100644
--- a/backends/trace-events
+++ b/backends/trace-events
@@ -24,6 +24,7 @@ iommufd_backend_invalidate_cache(int iommufd, uint32_t id, uint32_t data_type, u
 iommufd_backend_alloc_viommu(int iommufd, uint32_t dev_id, uint32_t type, uint32_t hwpt_id, uint64_t data_ptr, uint32_t data_len, uint32_t viommu_id, int ret) " iommufd=%d type=%u dev_id=%u hwpt_id=%u data_ptr=0x%"PRIx64" data_len=0x%x viommu_id=%u (%d)"
 iommufd_backend_alloc_vdev(int iommufd, uint32_t dev_id, uint32_t viommu_id, uint64_t virt_id, uint32_t vdev_id, int ret) " iommufd=%d dev_id=%u viommu_id=%u virt_id=0x%"PRIx64" vdev_id=%u (%d)"
 iommufd_viommu_alloc_eventq(int iommufd, uint32_t viommu_id, uint32_t type, uint32_t veventq_id, uint32_t veventq_fd, int ret) " iommufd=%d viommu_id=%u type=%u veventq_id=%u veventq_fd=%u (%d)"
+iommufd_backend_alloc_hw_queue(int iommufd, uint32_t viommu_id, uint32_t queue_type, uint32_t index, uint64_t addr, uint64_t size, uint32_t queue_id, int ret) " iommufd=%d viommu_id=%u queue_type=%u index=%u addr=0x%"PRIx64" size=0x%"PRIx64" queue_id=%u (%d)"
 
 # igvm-cfg.c
 igvm_reset_enter(int type) "type=%u"
diff --git a/include/system/iommufd.h b/include/system/iommufd.h
index 1b0266f660..c6f2e87a7e 100644
--- a/include/system/iommufd.h
+++ b/include/system/iommufd.h
@@ -65,6 +65,12 @@ typedef struct IOMMUFDVeventq {
     bool event_start; /* True after first valid event; cleared on overflow */
 } IOMMUFDVeventq;
 
+/* HW queue object for a vIOMMU-specific HW-accelerated queue */
+typedef struct IOMMUFDHWqueue {
+    IOMMUFDViommu *viommu;
+    uint32_t hw_queue_id;
+} IOMMUFDHWqueue;
+
 bool iommufd_backend_connect(IOMMUFDBackend *be, Error **errp);
 void iommufd_backend_disconnect(IOMMUFDBackend *be);
 
@@ -101,6 +107,11 @@ bool iommufd_backend_alloc_veventq(IOMMUFDBackend *be, uint32_t viommu_id,
                                    uint32_t *out_veventq_id,
                                    uint32_t *out_veventq_fd, Error **errp);
 
+bool iommufd_backend_alloc_hw_queue(IOMMUFDBackend *be, uint32_t viommu_id,
+                                    uint32_t queue_type, uint32_t index,
+                                    uint64_t addr, uint64_t length,
+                                    uint32_t *out_hw_queue_id, Error **errp);
+
 bool iommufd_backend_set_dirty_tracking(IOMMUFDBackend *be, uint32_t hwpt_id,
                                         bool start, Error **errp);
 bool iommufd_backend_get_dirty_bitmap(IOMMUFDBackend *be, uint32_t hwpt_id,
-- 
2.43.0


