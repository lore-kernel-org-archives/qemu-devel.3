Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 70887606A31C
	for <qemu-devel@archiver.kernel.org>; Wed, 28 Oct 2026 17:19:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=Ne52RAkE;
	dkim=pass (2048-bit key, unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=google header.b=YVwsOtEE
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xM7Hd-000494-C6; Wed, 28 Oct 2026 13:17:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1xM7H6-0001sK-VL
 for qemu-devel@nongnu.org; Wed, 28 Oct 2026 13:17:22 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1xM7H4-00040q-T8
 for qemu-devel@nongnu.org; Wed, 28 Oct 2026 13:17:20 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1793207838;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=8r7GpswjYliRUYMu308FD2l8ZVNNAemsFlYF1KvgFJQ=;
 b=Ne52RAkEuCA6G82ldIFcWL34xtEyNJmvGRJGS/eJV+aau6iw1zQlHen01QpxhqJ6Vk4ivv
 IkwrW7ybsQtIEU7qVAhx779G4sYARkCUSAHQj0QI+XmQzYoRUX0CIfnUB3aQeEych3IO3c
 r5bzN3Wg289uSGxDMKwuK5aGXPAkBnQ=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-479-6b64YBC6ONaLcZHqVfZBhQ-1; Wed, 28 Oct 2026 13:17:17 -0400
X-MC-Unique: 6b64YBC6ONaLcZHqVfZBhQ-1
X-Mimecast-MFC-AGG-ID: 6b64YBC6ONaLcZHqVfZBhQ_1793207836
Received: by mail-wr1-f72.google.com with SMTP id
 ffacd0b85a97d-48b027578a4so954444f8f.3
 for <qemu-devel@nongnu.org>; Wed, 28 Oct 2026 10:17:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1793207835; x=1793812635; darn=nongnu.org;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=8r7GpswjYliRUYMu308FD2l8ZVNNAemsFlYF1KvgFJQ=;
 b=YVwsOtEEnoasGIzRkil4WrmqY//bu3ezCAAtLkCYhm1wQRjEXYAFpNtCiCOa9tkNaE
 kppD62NYE4ktn+5/9yYH7tUzw9b6cRX/G1OuKP7oWdPV8eIlug6TCG/nrk4jHtDObEpS
 4eJpfdO4uCbcI2LjPaBJ0wTENXVQm6jSTjY4pCjelg2EtD16JSsDPpq7mvUZ7MUMjNkx
 va6uSCAutnAQd++8HQJcHoMgTDSXqIaqrUvZhRWTpz+so2KXKSyZ2MJEp8z2wOSm3zm+
 RHdXNPgJ3faadF8/iIQfaerWW8/pttFvtzlljQnL8ehJEFtJms8hb9kIE2raF4wuzP/F
 oN+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793207835; x=1793812635;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=8r7GpswjYliRUYMu308FD2l8ZVNNAemsFlYF1KvgFJQ=;
 b=axI9vlvBii5+JCVVCFcQkmQ858BV/0Nj8QZwvndooDBoRRP+3OKMhHiXM4ednf9Gst
 JOt32PE0IIC+npfzyY734LtPv9gWMqNeUD1cObpqkHhFvmd2WQebG8IWHsEd7bsC72Wo
 50TBRlVOUys+HjF9NLMB1jIANnnJADCuGjd80XbO0jMAHq8En3bZBBzJCOADIa4tnwL6
 f6rpUrsIX+D3W1N8nGaMfrN7mwLcMzv1i//iQ6X+gh8nfDnQzMlLeUu5TPi8F/dT/JkL
 XhbTjQ3ySTkGRSuGNTYCxTy2p/tc50R6raDjYJp2FeN7MoKRQI+ACyniddvg9vd3PBE+
 ESug==
X-Gm-Message-State: AFq9FYK7Or/g+K375QeiTMGHEcWMD81uwShQ4oQjuKOdEUSoI0dNwzmU
 wtUc0OfnKeBBzSRv/FOK+MThuxOx0GVxR0x+rA/9S1dfIm4ALOo8GndtorM6MqFbunhrhv3oMeJ
 ReOWpppK0gFcCvNc/bXX++EHbyXCtlRN5TAmAqXNtwlF4Lbjvd//5dRr3BW4nOMzUzFREG8JHoC
 NnEBsHoTQI7r3JYpg3W3y0Z8fKprsvsQT4VA==
X-Gm-Gg: AYBFou0kZ+Mr3IBhPrOiuT9svxt/3GYeEFTS1fBX8G/MDT+YbK6yYzBaQ1RXeT3BeTs
 /JKDbAbQIjDPFXxDGR3NKLCdLVqPIl7lxSIBy//QMy+H5IN0XXP8mkoOo+RQTKu6DLIFZwFogea
 3M7lt8gfbZBf8DTCXr8VGXxk83PUbgsAByvGsIvtMROtXWonmK7sk40rDBoixUcfVv1URoySgxq
 kEtYSN7rqU19jmSUalNHFvkHmBnm0OR2MEHisI9Q9NTzBhYo4YJ8EwAxl/h9JHa9Zj2vuYjhDbF
 Fy2wlFDER648lnOjL9EojPA5ekvifP30IWafmyiP6ff1ftZUf+vjlg+NUoNcaf3YBKQt2xeGwmS
 LgWVvRNYz9rT/mq7w9Vx+SfJLjLUFZG2ZA730FmS/
X-Received: by 2002:a05:6000:1866:b0:488:7b66:140c with SMTP id
 ffacd0b85a97d-48e5d45a69amr7787599f8f.28.1793207835469; 
 Wed, 28 Oct 2026 10:17:15 -0700 (PDT)
X-Received: by 2002:a05:6000:1866:b0:488:7b66:140c with SMTP id
 ffacd0b85a97d-48e5d45a69amr7787499f8f.28.1793207834832; 
 Wed, 28 Oct 2026 10:17:14 -0700 (PDT)
Received: from redhat.com ([2a0d:6fc0:1536:fc00:b838:383:1c7:6e81])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-48e3ebd49afsm29812183f8f.35.2026.10.28.10.17.13
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 28 Oct 2026 10:17:14 -0700 (PDT)
Date: Wed, 28 Oct 2026 13:17:12 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Zhenzhong Duan <zhenzhong.duan@intel.com>,
 Clement Mathieu--Drif <clement.mathieu--drif@bull.com>,
 Yi Liu <yi.l.liu@intel.com>, Nicolin Chen <nicolinc@nvidia.com>,
 Xudong Hao <xudong.hao@intel.com>, Eric Auger <eric.auger@redhat.com>
Subject: [PULL 70/78] backends/iommufd: Introduce iommufd_backend_alloc_faultq
Message-ID: <fb57097733fb0b6198f908fc9c0753df054c6b5a.1793207602.git.mst@redhat.com>
References: <cover.1793207602.git.mst@redhat.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1793207602.git.mst@redhat.com>
X-Mailer: git-send-email 2.51.2.2891.g4157995a80.dirty
X-Mutt-Fcc: =sent
Received-SPF: pass client-ip=170.10.129.124; envelope-from=mst@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

From: Zhenzhong Duan <zhenzhong.duan@intel.com>

Add a new helper for IOMMU_FAULT_QUEUE_ALLOC ioctl to allocate a fault
handling object which will be used in hwpt allocation.

Signed-off-by: Zhenzhong Duan <zhenzhong.duan@intel.com>
Reviewed-by: Clement Mathieu--Drif <clement.mathieu--drif@bull.com>
Reviewed-by: Yi Liu <yi.l.liu@intel.com>
Reviewed-by: Nicolin Chen <nicolinc@nvidia.com>
Tested-by: Xudong Hao <xudong.hao@intel.com>
Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
Message-ID: <20261020091955.1607161-3-zhenzhong.duan@intel.com>
---
 include/system/iommufd.h |  3 +++
 backends/iommufd.c       | 21 +++++++++++++++++++++
 backends/trace-events    |  1 +
 3 files changed, 25 insertions(+)

diff --git a/include/system/iommufd.h b/include/system/iommufd.h
index 17bf1a3727..36b34b4899 100644
--- a/include/system/iommufd.h
+++ b/include/system/iommufd.h
@@ -106,6 +106,9 @@ bool iommufd_backend_alloc_veventq(IOMMUFDBackend *be, uint32_t viommu_id,
                                    uint32_t *out_veventq_id,
                                    uint32_t *out_veventq_fd, Error **errp);
 
+bool iommufd_backend_alloc_faultq(IOMMUFDBackend *be, uint32_t *out_fault_id,
+                                  uint32_t *out_fault_fd, Error **errp);
+
 bool iommufd_backend_alloc_hw_queue(IOMMUFDBackend *be, uint32_t viommu_id,
                                     uint32_t queue_type, uint32_t index,
                                     uint64_t addr, uint64_t length,
diff --git a/backends/iommufd.c b/backends/iommufd.c
index 45fd2e44c7..457b74a558 100644
--- a/backends/iommufd.c
+++ b/backends/iommufd.c
@@ -556,6 +556,27 @@ bool iommufd_backend_alloc_veventq(IOMMUFDBackend *be, uint32_t viommu_id,
     return true;
 }
 
+bool iommufd_backend_alloc_faultq(IOMMUFDBackend *be, uint32_t *out_fault_id,
+                                  uint32_t *out_fault_fd, Error **errp)
+{
+    int ret, fd = be->fd;
+    struct iommu_fault_alloc cmd = {
+        .size = sizeof(cmd),
+    };
+
+    ret = ioctl(fd, IOMMU_FAULT_QUEUE_ALLOC, &cmd);
+    trace_iommufd_backend_alloc_faultq(fd, cmd.out_fault_id, cmd.out_fault_fd,
+                                       ret);
+    if (ret) {
+        error_setg_errno(errp, errno, "Failed to allocate fault queue");
+        return false;
+    }
+
+    *out_fault_id = cmd.out_fault_id;
+    *out_fault_fd = cmd.out_fault_fd;
+    return true;
+}
+
 bool iommufd_backend_alloc_hw_queue(IOMMUFDBackend *be, uint32_t viommu_id,
                                     uint32_t queue_type, uint32_t index,
                                     uint64_t addr, uint64_t length,
diff --git a/backends/trace-events b/backends/trace-events
index 9b7b9b7d68..b1c1d89dd8 100644
--- a/backends/trace-events
+++ b/backends/trace-events
@@ -17,6 +17,7 @@ iommufd_backend_unmap_dma_non_exist(int iommufd, uint32_t ioas, uint64_t iova, u
 iommufd_backend_unmap_dma(int iommufd, uint32_t ioas, uint64_t iova, uint64_t size, int ret) " iommufd=%d ioas=%d iova=0x%"PRIx64" size=0x%"PRIx64" (%d)"
 iommufd_backend_alloc_ioas(int iommufd, uint32_t ioas) " iommufd=%d ioas=%d"
 iommufd_backend_alloc_hwpt(int iommufd, uint32_t dev_id, uint32_t pt_id, uint32_t flags, uint32_t hwpt_type, uint32_t len, uint64_t data_ptr, uint32_t out_hwpt_id, int ret) " iommufd=%d dev_id=%u pt_id=%u flags=0x%x hwpt_type=%u len=%u data_ptr=0x%"PRIx64" out_hwpt=%u (%d)"
+iommufd_backend_alloc_faultq(int iommufd, uint32_t fault_id, uint32_t fault_fd, int ret) " iommufd=%d fault_id=%u fault_fd=%u (%d)"
 iommufd_backend_free_id(int iommufd, uint32_t id, int ret) " iommufd=%d id=%d (%d)"
 iommufd_backend_set_dirty(int iommufd, uint32_t hwpt_id, bool start, int ret) " iommufd=%d hwpt=%u enable=%d (%d)"
 iommufd_backend_get_dirty_bitmap(int iommufd, uint32_t hwpt_id, uint64_t iova, uint64_t size, uint64_t flags, uint64_t page_size, int ret) " iommufd=%d hwpt=%u iova=0x%"PRIx64" size=0x%"PRIx64" flags=0x%"PRIx64" page_size=0x%"PRIx64" (%d)"
-- 
MST


