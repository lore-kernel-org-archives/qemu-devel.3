Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 632F5C53209
	for <qemu-devel@archiver.kernel.org>; Mon, 27 Jul 2026 19:22:47 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1woQs3-0000CH-06; Mon, 27 Jul 2026 15:20:15 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1woQs2-0000C3-7s
 for qemu-devel@nongnu.org; Mon, 27 Jul 2026 15:20:14 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1woQs0-0000Q6-FI
 for qemu-devel@nongnu.org; Mon, 27 Jul 2026 15:20:13 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1785180011;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=84hPA+8jDla3npE9ffBr07SeKPeglYRBtqwzRIySi1s=;
 b=c2I6uF69zOcYrjtDJJjyJjrbESYiFeJwj/Vs+QZeW6xOoA470xfGRuTzGLFmwBRujsapmN
 5SlOIZWBWJbkERgFmxWUo3A+ipLM0co+pUHDY9B0VWZNm/FaNTXwCZ3xxtUYGfnJYMUMvB
 IqIwK8K9HuxcAz7qR/wUv4oh/j8Z/48=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-76-ywTFiE05ORuJz3laEVu_Cg-1; Mon, 27 Jul 2026 15:20:10 -0400
X-MC-Unique: ywTFiE05ORuJz3laEVu_Cg-1
X-Mimecast-MFC-AGG-ID: ywTFiE05ORuJz3laEVu_Cg_1785180010
Received: by mail-wm1-f71.google.com with SMTP id
 5b1f17b1804b1-4954c2d4081so22454335e9.2
 for <qemu-devel@nongnu.org>; Mon, 27 Jul 2026 12:20:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1785180009; x=1785784809; darn=nongnu.org;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=84hPA+8jDla3npE9ffBr07SeKPeglYRBtqwzRIySi1s=;
 b=XdjjNx4KEcqFw9w6WoaSHztCkx4y9xPRBHpdCrLbzGmwFxTT8gCprBihDSQ3Fnc8dJ
 qvRd8tA1Vk3mCzSDJ9PNZ08cDYvLHHZT2kgDWbjsR/ge1LCZJBPhxXTqydseZCiEKlHU
 ac6Q+ipPM0hGlRYG3j7pizcik08OJ3rOmRFSUzecVOucZE7O7DccJfC8HppOtQQGeFdN
 EMEm9fE568a60boNC8VI7L8sUuEXi2GHQAK5WoEf7Rwv5MpwW8ycFqN5HV1adtIEdHgf
 dTpB1tSAW4TBPc0fAc+ILPxOUVHOie2I+RiG5rVnOrFWo+YrcDF4C4+kHXGuBoVLn9vq
 vaww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1785180009; x=1785784809;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=84hPA+8jDla3npE9ffBr07SeKPeglYRBtqwzRIySi1s=;
 b=pOl27PUHMW+4jMadLxx6ylQMbP2/BgV7MrbmCVPj3K9wB6RsPsBYGpMHCdUpzrbWJj
 +V324K4sdfMwaoFUbTP847Jxi1/vLzmFUzWPlKh4CrKUQnslh2jkkrFbCp5oGp+rmIl5
 J2iy8eZHaz4UlMkW40YTNREZ5z0ufM7KxHbXqD/rfEK9sFG32CXQV5Wl3qjYK/DoJ9IQ
 atDVr8/M+JTQvAR/0L1aUT1HqGvI8Lx+eZgQkO4bJoqQfCIKuql+C0w53eW3qbYZMzBl
 2SBaIxRgiMTqQ/aMMGxzmTdNOcfchsdqrbyHqgdIZTCdcTBPxWUziLmkxBhmkoexuvGe
 F2gw==
X-Gm-Message-State: AOJu0YyIuBTqyuGykSZRGm9Cqfeb7o1/N7KFYDnepQ6ojfR3YwYd8KPA
 8IYMQ4E4wgv9W2TXhw6v13IA5X7xq+rC+fJ6wyjMwkZwldAiAncMvvX72OGBa+lo5+fIdMJyBf2
 8tN8oZr8aJGzjWdFqmAyiFlY2Nlm3tK2S0N+0PhwooUvHQhhLtVUrMiYODLeXIAtglash0RqoLH
 xbKCYKEmObMT8jLiO9jnZrQ6/eWFPPEI7sYQ==
X-Gm-Gg: AR+sD10Y6K4hLosY8NVkjNQzy/AQLuShtTYDzQYJaq2TZh3wplfJ0zlJ/gPUuPidGas
 cp69u9mOYMyVH2J0KgXgtubrJ3K8ER6+dGeXgYEWP0FdgeKxjzPwuXGHj0zfmYpdWzi63sqwHfr
 VlJfuEH3dK223NckFxnAEmlN/faRFmt2FB2Kiv0GUMG1d2IOxSZRkovyTkB//Ekvco6/lqgfpMh
 pAXkVDf05MSE3D6QsDX6EY+xXCBVO68KMyuZ7W0bDiOIWP/Vf+YdbfsFzatmdHBIgnYCqalAiiV
 NzPvbUX0DLsfEWpOMwuN0orhnjFzfGOkrMkpu+GM8TCCD8IfwJYHclE41/t8shd25O6JFeV/Jq1
 /H3JE5rwWKNNtBgizy252AA==
X-Received: by 2002:a05:600c:c87:b0:495:69eb:27fe with SMTP id
 5b1f17b1804b1-496b56c58bfmr113116715e9.11.1785180009223; 
 Mon, 27 Jul 2026 12:20:09 -0700 (PDT)
X-Received: by 2002:a05:600c:c87:b0:495:69eb:27fe with SMTP id
 5b1f17b1804b1-496b56c58bfmr113116245e9.11.1785180008644; 
 Mon, 27 Jul 2026 12:20:08 -0700 (PDT)
Received: from redhat.com (IGLD-80-230-28-14.inter.net.il. [80.230.28.14])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-496c45e0424sm14783805e9.13.2026.07.27.12.20.07
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 27 Jul 2026 12:20:08 -0700 (PDT)
Date: Mon, 27 Jul 2026 15:20:06 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>,
 David Hildenbrand <david@kernel.org>,
 Pankaj Gupta <pagupta@redhat.com>, Jia Jia <physicalmtea@gmail.com>
Subject: [PULL v2 14/30] virtio-pmem: wait for flush requests on unrealize
Message-ID: <5cc182ba39a3ca8ec9ba0576de9696be76dc087d.1785179875.git.mst@redhat.com>
References: <cover.1785179875.git.mst@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1785179875.git.mst@redhat.com>
X-Mailer: git-send-email 2.51.2.2891.g4157995a80.dirty
X-Mutt-Fcc: =sent
Received-SPF: pass client-ip=170.10.133.124; envelope-from=mst@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -36
X-Spam_score: -3.7
X-Spam_bar: ---
X-Spam_report: (-3.7 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.58,
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

virtio_pmem_flush submits fsync requests to the thread pool and stores a
VirtIOPMEM pointer in each request. If device is deleted e.g. by
hot-unplug, once these complete, done_cb can run after
virtio_pmem_unrealize frees the device, causing a use-after-free.

Track in-flight requests and wait in virtio_pmem_unrealize until
their completions finish before tearing the device down.

Fixes: CVE-2026-63323
Fixes: 5f503cd9f3 ("virtio-pmem: add virtio device")
Cc: David Hildenbrand <david@kernel.org>
Cc: Pankaj Gupta <pagupta@redhat.com>
Resolves: https://gitlab.com/qemu-project/qemu/-/work_items/3938
Reported-by: Jia Jia <physicalmtea@gmail.com>
Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
Message-ID: <417b6685f37ce818c660ca3c84945992f5c30dcf.1784894206.git.mst@redhat.com>
---
 include/hw/virtio/virtio-pmem.h |  1 +
 hw/virtio/virtio-pmem.c         | 17 +++++++++++++++--
 2 files changed, 16 insertions(+), 2 deletions(-)

diff --git a/include/hw/virtio/virtio-pmem.h b/include/hw/virtio/virtio-pmem.h
index 9cce600d0b..bb959d10cf 100644
--- a/include/hw/virtio/virtio-pmem.h
+++ b/include/hw/virtio/virtio-pmem.h
@@ -32,6 +32,7 @@ struct VirtIOPMEM {
     VirtQueue *rq_vq;
     uint64_t start;
     HostMemoryBackend *memdev;
+    unsigned int inflight;
 };
 
 struct VirtIOPMEMClass {
diff --git a/hw/virtio/virtio-pmem.c b/hw/virtio/virtio-pmem.c
index c3b3299c9c..6f7271c140 100644
--- a/hw/virtio/virtio-pmem.c
+++ b/hw/virtio/virtio-pmem.c
@@ -23,6 +23,7 @@
 #include "standard-headers/linux/virtio_pmem.h"
 #include "system/hostmem.h"
 #include "block/thread-pool.h"
+#include "qemu/aio-wait.h"
 #include "trace.h"
 
 typedef struct VirtIODeviceRequest {
@@ -54,14 +55,20 @@ static int worker_cb(void *opaque)
 static void done_cb(void *opaque, int ret)
 {
     VirtIODeviceRequest *req_data = opaque;
+    VirtIOPMEM *pmem = req_data->pmem;
     int len = iov_from_buf(req_data->elem.in_sg, req_data->elem.in_num, 0,
                               &req_data->resp, sizeof(struct virtio_pmem_resp));
 
     /* Callbacks are serialized, so no need to use atomic ops. */
-    virtqueue_push(req_data->pmem->rq_vq, &req_data->elem, len);
-    virtio_notify((VirtIODevice *)req_data->pmem, req_data->pmem->rq_vq);
+    virtqueue_push(pmem->rq_vq, &req_data->elem, len);
+    virtio_notify((VirtIODevice *)pmem, pmem->rq_vq);
     trace_virtio_pmem_response();
     g_free(req_data);
+
+    pmem->inflight--;
+    if (!pmem->inflight) {
+        aio_wait_kick();
+    }
 }
 
 static void virtio_pmem_flush(VirtIODevice *vdev, VirtQueue *vq)
@@ -85,6 +92,7 @@ static void virtio_pmem_flush(VirtIODevice *vdev, VirtQueue *vq)
     req_data->fd   = memory_region_get_fd(&backend->mr);
     req_data->pmem = pmem;
     req_data->vdev = vdev;
+    pmem->inflight++;
     thread_pool_submit_aio(worker_cb, req_data, done_cb, req_data);
 }
 
@@ -122,6 +130,7 @@ static void virtio_pmem_realize(DeviceState *dev, Error **errp)
     host_memory_backend_set_mapped(pmem->memdev, true);
     virtio_init(vdev, VIRTIO_ID_PMEM, sizeof(struct virtio_pmem_config));
     pmem->rq_vq = virtio_add_queue(vdev, 128, virtio_pmem_flush);
+    pmem->inflight = 1;
 }
 
 static void virtio_pmem_unrealize(DeviceState *dev)
@@ -129,6 +138,10 @@ static void virtio_pmem_unrealize(DeviceState *dev)
     VirtIODevice *vdev = VIRTIO_DEVICE(dev);
     VirtIOPMEM *pmem = VIRTIO_PMEM(dev);
 
+    /* Release the device's own reference and wait for in-flight flushes */
+    pmem->inflight--;
+    AIO_WAIT_WHILE(NULL, pmem->inflight > 0);
+
     host_memory_backend_set_mapped(pmem->memdev, false);
     virtio_delete_queue(pmem->rq_vq);
     virtio_cleanup(vdev);
-- 
MST


