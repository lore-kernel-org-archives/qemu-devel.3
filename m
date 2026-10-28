Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D61E606A32C
	for <qemu-devel@archiver.kernel.org>; Wed, 28 Oct 2026 17:19:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=WJHdc0ie;
	dkim=pass (2048-bit key, unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=google header.b=Lll8U9Xm
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xM7IR-0006Ki-V1; Wed, 28 Oct 2026 13:18:44 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1xM7HL-00031X-P4
 for qemu-devel@nongnu.org; Wed, 28 Oct 2026 13:17:35 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1xM7HJ-000430-OK
 for qemu-devel@nongnu.org; Wed, 28 Oct 2026 13:17:35 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1793207853;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=2wXbbb9QDEQpi3LDCkaV6Wh1NoMsGYl+QVOX1WHgrnQ=;
 b=WJHdc0ie9yhOyqBbV2ge2wCu3Vp02qhzaB51YsVIIFn6bP5XpZBhwtdn+RKC2Fe0ohguAz
 XWTZy7pgyXmUUBzsL/X0iv63i7iAYo0W9Q/2PDdlP9A1P8dTqhwToNnVbRDF3peKt4JIPq
 RSVs40HOhdJzjvmVBROi2Qp544i7cG0=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-454-aqoC228zP4SbZhRqkrDzJg-1; Wed, 28 Oct 2026 13:17:31 -0400
X-MC-Unique: aqoC228zP4SbZhRqkrDzJg-1
X-Mimecast-MFC-AGG-ID: aqoC228zP4SbZhRqkrDzJg_1793207850
Received: by mail-wm1-f69.google.com with SMTP id
 5b1f17b1804b1-4a20fd059ddso9046185e9.0
 for <qemu-devel@nongnu.org>; Wed, 28 Oct 2026 10:17:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1793207850; x=1793812650; darn=nongnu.org;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=2wXbbb9QDEQpi3LDCkaV6Wh1NoMsGYl+QVOX1WHgrnQ=;
 b=Lll8U9XmOHvsd7QnFwaOue0Vd6HsRliZsjrZgkpdqvuftD9M3tVzIMc8Mh0HJj5KM4
 tAvM4FqAFrWtiUSNooW3maHT7z5HGn/DqUGRgm+d4cM8lMgkvDA36xTi7/YMFTuUN5qh
 3PSzq/7Z3X6OP5Jb1lL47hBnkMhdYPZvb1DndeTe/P0pD90wYJFsAfhTLUvIeoIIpKRl
 WeOeatdQdH5TV1lZEq+hGXHh43zR7qyNRGNU+j3YJzPK/Z+EX7HU2k1q1ni8wKla2bTk
 0JCztjq6G9bmAaM/wMl+Hpg9+12gVPmIUe7TyH9Ry+9YgCBrqY9HgwU1o0TLZr7pBXnw
 sHag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793207850; x=1793812650;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=2wXbbb9QDEQpi3LDCkaV6Wh1NoMsGYl+QVOX1WHgrnQ=;
 b=qNLT1wDQltwzvrPhgo7h+p9wGGE0ctM/30hSW3Nj+hqxdsc6nFF/sxLOWNlUkLNyM0
 lqU90EqxWO2zV/A58D8S4geC9yUFikvJtAYHOBPHeNn7Inv3XtAj8qbNlP9KgJnrBUYp
 agcbZ3aH4ibyAPYpdGSYKtUwdNXn6a8w74X0ZaIZiJGzp0axD/6ZZgNw4IWqF2e2Bn9s
 J49fTvB9V3vRl0fJAU9mbGTrkNvncExu2gT0OjukaeJQZ24OfT4IzHi1AiW7CPiq479S
 S+5A1DGNe8kpZrTnFhXEvZ2A4gHMZyQ125vL5oLsBBn+d7T2/0WgR6/0G9ufPZQiHVEx
 Ac8w==
X-Gm-Message-State: AFq9FYI19wZZ7fcYUXM7nYmuBa4uqrvEyxXIULrNus47YPOebQHj03h7
 PE20Mw4TqgfKQ5oqOrSF/DuSdjcsWhMCoSv1t1YMOphLcuFMpzJ+G9izWkn8yTVTNy2kby63skO
 A6xHmBam1ViwxOzqBB2y1G5GimbP2rkGIQEIYILzSJ8G+w/OK8wKJ1jJIipt4+0KhRpmDzYaEtY
 E5JAIK6mB5poHPITI4rSEHeCm3oGomHV/DoA==
X-Gm-Gg: AYBFou1FFsrkgSXuawKUNY0u66KGLwYkn6wecCUupGoEu0sngz2Grt/CL3+hnuurnS+
 NOf0A+GLi4g2V19THKD4qWyOyNyzYICAk76Qsmf9xhdi+90TOwva+rVW/0giIdH+7lm5ZTXAH4e
 UO9HQHPe0WFZ69uO+tmDZhu81B43t/LrtE8t2a69TGZ6L/ppn5tFgaZez9P14YYrYEtiGE/5nBd
 4sptnQhMBziaz+WRa2PB2S80YJSzOLEJp4h3tyHcSerZwR2xGsRZDoIVOFnB5MVZ6MBxoshI5NF
 SIfZBUlPLtmWi3dcqyXeJ4bUmi1GY/NpCPheU75MddN0mENiZstGnOPmZwdo7a1JasHxQm6D+nv
 4qV8ettRt6EB0KnPmyBX5ad/M3klvKt87TVvfryzK
X-Received: by 2002:a05:600c:3b1e:b0:4a2:e0c:2b0a with SMTP id
 5b1f17b1804b1-4a966774f22mr74194405e9.16.1793207850230; 
 Wed, 28 Oct 2026 10:17:30 -0700 (PDT)
X-Received: by 2002:a05:600c:3b1e:b0:4a2:e0c:2b0a with SMTP id
 5b1f17b1804b1-4a966774f22mr74193385e9.16.1793207849479; 
 Wed, 28 Oct 2026 10:17:29 -0700 (PDT)
Received: from redhat.com ([2a0d:6fc0:1536:fc00:b838:383:1c7:6e81])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-48e3ebcb851sm25588034f8f.26.2026.10.28.10.17.24
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 28 Oct 2026 10:17:25 -0700 (PDT)
Date: Wed, 28 Oct 2026 13:17:23 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Zhenzhong Duan <zhenzhong.duan@intel.com>,
 Shameer Kolothum <skolothumtho@nvidia.com>,
 Yi Liu <yi.l.liu@intel.com>, Xudong Hao <xudong.hao@intel.com>,
 Clement Mathieu--Drif <clement.mathieu--drif@bull.com>,
 Jason Wang <jasowangio@gmail.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>
Subject: [PULL 74/78] intel_iommu_accel: Teardown FAULTQ resources in bottom
 half
Message-ID: <7ce51564c3365930d145ed31786ff2dac6f9b7be.1793207602.git.mst@redhat.com>
References: <cover.1793207602.git.mst@redhat.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1793207602.git.mst@redhat.com>
X-Mailer: git-send-email 2.51.2.2891.g4157995a80.dirty
X-Mutt-Fcc: =sent
Received-SPF: pass client-ip=170.10.133.124; envelope-from=mst@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

When a PASID entry becomes invalid, all resources allocated for that entry,
including the FAULTQ object and fault_fd, must be released.

Calling qemu_set_fd_handler() detaches the fault_fd I/O read handler and
wakes up the main loop thread from poll(). However, a race window exists
where iommufd_backend_free_id(fault_id) can be invoked before poll() exits
and releases its reference to the fault_fd file. In this scenario, freeing
the FAULTQ object returns -EBUSY because the opened fault_fd file still
holds an active reference to the FAULTQ object.

Defer FAULTQ resource teardown to a bottom half. This ensures poll() has
fully exited and dropped the file reference before the fault_fd is closed
and the FAULTQ object ID is freed. Additionally, keep the IOMMUFD backend
FD open via iommufd_backend_connect() across the asynchronous bottom half
execution to ensure FAULTQ object freed successfully.

Suggested-by: Shameer Kolothum <skolothumtho@nvidia.com>
Signed-off-by: Zhenzhong Duan <zhenzhong.duan@intel.com>
Reviewed-by: Yi Liu <yi.l.liu@intel.com>
Tested-by: Xudong Hao <xudong.hao@intel.com>
Reviewed-by: Clement Mathieu--Drif <clement.mathieu--drif@bull.com>
Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
Message-ID: <20261020091955.1607161-7-zhenzhong.duan@intel.com>
---
 hw/i386/intel_iommu_accel.c | 59 +++++++++++++++++++++++++++++++++++--
 1 file changed, 56 insertions(+), 3 deletions(-)

diff --git a/hw/i386/intel_iommu_accel.c b/hw/i386/intel_iommu_accel.c
index 243501f137..7db8319ad4 100644
--- a/hw/i386/intel_iommu_accel.c
+++ b/hw/i386/intel_iommu_accel.c
@@ -271,17 +271,70 @@ free_faultq:
     return false;
 }
 
+typedef struct IOMMUFaultQueue {
+    IOMMUFDBackend *iommufd;
+    uint32_t id;
+    int fd;
+    QLIST_HEAD(, VTDPRQEntry) vtd_prq_list;
+} IOMMUFaultQueue;
+
+static void faultq_teardown_bh(void *opaque)
+{
+    IOMMUFaultQueue *fq = opaque;
+    VTDPRQEntry *prqe, *next;
+
+    QLIST_FOREACH_SAFE(prqe, &fq->vtd_prq_list, next, next) {
+        QLIST_REMOVE(prqe, next);
+        g_free(prqe);
+    }
+
+    qemu_set_fd_handler(fq->fd, NULL, NULL, NULL);
+    close(fq->fd);
+    iommufd_backend_free_id(fq->iommufd, fq->id);
+    iommufd_backend_disconnect(fq->iommufd);
+
+    g_free(fq);
+}
+
 static void vtd_destroy_old_fs_faultq(VTDAccelPASIDCacheEntry *vtd_pce)
 {
+    HostIOMMUDeviceIOMMUFD *idev =
+        HOST_IOMMU_DEVICE_IOMMUFD(vtd_pce->vtd_hiod->hiod);
+    IOMMUFaultQueue *fq;
+
     if (vtd_pce->fault_fd < 0) {
         return;
     }
 
-    qemu_set_fd_handler(vtd_pce->fault_fd, NULL, NULL, NULL);
-    vtd_destroy_fs_faultq(vtd_pce->vtd_hiod, vtd_pce->fault_id,
-                          vtd_pce->fault_fd);
+    fq = g_malloc(sizeof(*fq));
+    fq->iommufd = idev->iommufd;
+    fq->fd = vtd_pce->fault_fd;
+    fq->id = vtd_pce->fault_id;
     vtd_pce->fault_id = 0;
     vtd_pce->fault_fd = -1;
+    fq->vtd_prq_list.lh_first = vtd_pce->vtd_prq_list.lh_first;
+    QLIST_INIT(&vtd_pce->vtd_prq_list);
+
+    /*
+     * During a VFIO device hot-unplug, if this is the last device connected
+     * to the IOMMUFDBackend, the backend user count (iommufd->users) will
+     * drop to zero, triggering iommufd_backend_disconnect() which closes
+     * the backend's opened container FD.
+     *
+     * Since the teardown of this fault queue (faultq_teardown_bh) is
+     * scheduled asynchronously as a bottom half, we must temporarily
+     * increment the connection user count of the iommufd backend here.
+     * This guarantees the backend connection remains open and its opened
+     * FD remains active until the async BH completes.
+     *
+     * Incrementing the user count is guaranteed to succeed here because the
+     * VFIO device is still registered as an active user of the backend at
+     * this point in the teardown sequence.
+     */
+    iommufd_backend_connect(fq->iommufd, &error_abort);
+
+    aio_bh_schedule_oneshot(iohandler_get_aio_context(),
+                            faultq_teardown_bh, fq);
 }
 
 static void vtd_setup_fs_faultq(VTDAccelPASIDCacheEntry *vtd_pce,
-- 
MST


