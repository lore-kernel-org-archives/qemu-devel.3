Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 285CEC3DA4A
	for <qemu-devel@archiver.kernel.org>; Wed, 14 May 2025 11:57:59 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uFAeI-0006vU-A1; Wed, 14 May 2025 07:51:46 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1uFAdl-00069H-Fi
 for qemu-devel@nongnu.org; Wed, 14 May 2025 07:51:14 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1uFAdj-0006JN-9e
 for qemu-devel@nongnu.org; Wed, 14 May 2025 07:51:13 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1747223470;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=PhRXtmUdCm+S5qOy3Bl4Anc/xV95bi9unHwGtH+zUJg=;
 b=Slj4UgXJ87xUZDKY4W8WrA0EZIKft9w2x09jGGv2OkEs5ppfjl83DSn/yWxggR1EKcW+lD
 Ltb4qAE8TGTfHB4joAb7fpCE9L9plg3Qhg7TtIsga6e1L3GDB6fkE4WSP1GDRhjW6oOEqF
 QvXRxjz+7Ul2RErguXBlNV8L1MRqjOM=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-447-YfgmrVS-Pe6zl-6hjdSkBg-1; Wed, 14 May 2025 07:51:09 -0400
X-MC-Unique: YfgmrVS-Pe6zl-6hjdSkBg-1
X-Mimecast-MFC-AGG-ID: YfgmrVS-Pe6zl-6hjdSkBg_1747223468
Received: by mail-wr1-f72.google.com with SMTP id
 ffacd0b85a97d-3a1f6c5f4f2so1842405f8f.2
 for <qemu-devel@nongnu.org>; Wed, 14 May 2025 04:51:08 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1747223467; x=1747828267;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=PhRXtmUdCm+S5qOy3Bl4Anc/xV95bi9unHwGtH+zUJg=;
 b=tMEfx2JnrSnnQgOAkLEG4SrG8e2+wSTufQU0PkuFiOuiSElsKlSRLGXXgfm3ZWLKej
 dZtQObBqrfk+s8I7F0j5QAloLEsmA8cAHsgWMDaIR4uf6supFramP6vJbltJBSwD26E+
 zLqGGCu/Nngo0KKbOB5FkjQmSGgfrpdvjtytPIk1yzc/V2GI63gOjDQiXkJCMtYZgJlz
 9wHNElHGPZsHZXkRkvgbDdCxCiAZlMK0CS9zQFL1JALDiIMF9W8IzrHlrMr4EXi7yS41
 BFyXJlMrmFLjy99t2OWzlAsYscV8W8P0A2SbrMcbfMXHDtlWHwpSpmOlsTqEjDsehX/F
 NNWw==
X-Gm-Message-State: AOJu0YxpMT/UxgHMAQ/2FDJSZGYln+2tar4MvD20TkUAb7EQ8UA32IkV
 1y5JNJbBVlT3FUKA+dlj+cZTkEPjhuZ6CD5CoilsC+d3K2IugtBGsw4sH7K4buzky7KYw4hoE82
 QlgRzF1hYYrupY1EKfBd8nOCF/8vuGeLutUdUOFz9IIRdkGs1joI7pWcWhB5+y8p8W5t8kPMVpz
 L9aml+zo6T8RnLMSFBksl++R+iWnzSEQ==
X-Gm-Gg: ASbGncsWNHJHCuR0L0UE/AwRNwWGmlgxfgonrQ1eO5Dx8iDbDJg8ZGZnGEBAFO9L68L
 khjITXl2n+7/sXSps1fxvNwIXEPalXbVnpEW/BjxHV30iD9LWf93bIO/dGYlvYfHECq553TLSjF
 fXI8oefDdPQy7z+/hJXtgBMcnK4wgsjPMNGRRnmn+CDxXGQd9IDeCkrECKppNsokKQMZg1GnVHv
 4UGodKjLr3Hm6fICoQZmFUdyM8qQkYCAvBfL2kwqqim4LVatoBTwlEuoW50KHeC3fO7LvJZMAzx
 P9H4FA==
X-Received: by 2002:a05:6000:2a8:b0:3a2:3c51:f4a1 with SMTP id
 ffacd0b85a97d-3a34969ad98mr2493688f8f.7.1747223467378; 
 Wed, 14 May 2025 04:51:07 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFqXEE1dBvEGd9csjBwRFzOTLi/ecDj3LPyQvogr/wQAiWezzPb/qqRk28CDGGK1A/POmB8mg==
X-Received: by 2002:a05:6000:2a8:b0:3a2:3c51:f4a1 with SMTP id
 ffacd0b85a97d-3a34969ad98mr2493670f8f.7.1747223466872; 
 Wed, 14 May 2025 04:51:06 -0700 (PDT)
Received: from redhat.com ([2a0d:6fc0:1517:1000:ea83:8e5f:3302:3575])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3a1f5a2cf38sm19366554f8f.77.2025.05.14.04.51.03
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 14 May 2025 04:51:03 -0700 (PDT)
Date: Wed, 14 May 2025 07:51:02 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Haoqian He <haoqian.he@smartx.com>, Lei Yang <leiyang@redhat.com>,
 Stefano Garzarella <sgarzare@redhat.com>
Subject: [PULL 19/27] vhost: return failure if stop virtqueue failed in
 vhost_dev_stop
Message-ID: <5a317017b827e338358792cd07663f8ea25f1ffe.1747223385.git.mst@redhat.com>
References: <cover.1747223385.git.mst@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1747223385.git.mst@redhat.com>
X-Mailer: git-send-email 2.27.0.106.g8ac3dc51b1
X-Mutt-Fcc: =sent
Received-SPF: pass client-ip=170.10.129.124; envelope-from=mst@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -37
X-Spam_score: -3.8
X-Spam_bar: ---
X-Spam_report: (-3.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.686,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

From: Haoqian He <haoqian.he@smartx.com>

This patch captures the error of vhost_virtqueue_stop() in vhost_dev_stop()
and returns the error upward.

Specifically, if QEMU is disconnected from the vhost backend, some actions
in vhost_dev_stop() will fail, such as sending vhost-user messages to the
backend (GET_VRING_BASE, SET_VRING_ENABLE) and vhost_reset_status.

Considering that both set_vring_enable and vhost_reset_status require setting
the specific virtio feature bit, we can capture vhost_virtqueue_stop()'s
error to indicate that QEMU has lost connection with the backend.

This patch is the pre patch for 'vhost-user: return failure if backend crashes
when live migration', which makes the live migration aware of the loss of
connection with the vhost-user backend and aborts the live migration.

Signed-off-by: Haoqian He <haoqian.he@smartx.com>
Message-Id: <20250416024729.3289157-3-haoqian.he@smartx.com>
Tested-by: Lei Yang <leiyang@redhat.com>
Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
---
 include/hw/virtio/vhost.h |  8 +++++---
 hw/virtio/vhost.c         | 23 +++++++++++++----------
 2 files changed, 18 insertions(+), 13 deletions(-)

diff --git a/include/hw/virtio/vhost.h b/include/hw/virtio/vhost.h
index bb4b58e115..38800a7156 100644
--- a/include/hw/virtio/vhost.h
+++ b/include/hw/virtio/vhost.h
@@ -232,8 +232,10 @@ int vhost_dev_start(struct vhost_dev *hdev, VirtIODevice *vdev, bool vrings);
  * Stop the vhost device. After the device is stopped the notifiers
  * can be disabled (@vhost_dev_disable_notifiers) and the device can
  * be torn down (@vhost_dev_cleanup).
+ *
+ * Return: 0 on success, != 0 on error when stopping dev.
  */
-void vhost_dev_stop(struct vhost_dev *hdev, VirtIODevice *vdev, bool vrings);
+int vhost_dev_stop(struct vhost_dev *hdev, VirtIODevice *vdev, bool vrings);
 
 /**
  * DOC: vhost device configuration handling
@@ -333,8 +335,8 @@ int vhost_device_iotlb_miss(struct vhost_dev *dev, uint64_t iova, int write);
 
 int vhost_virtqueue_start(struct vhost_dev *dev, struct VirtIODevice *vdev,
                           struct vhost_virtqueue *vq, unsigned idx);
-void vhost_virtqueue_stop(struct vhost_dev *dev, struct VirtIODevice *vdev,
-                          struct vhost_virtqueue *vq, unsigned idx);
+int vhost_virtqueue_stop(struct vhost_dev *dev, struct VirtIODevice *vdev,
+                         struct vhost_virtqueue *vq, unsigned idx);
 
 void vhost_dev_reset_inflight(struct vhost_inflight *inflight);
 void vhost_dev_free_inflight(struct vhost_inflight *inflight);
diff --git a/hw/virtio/vhost.c b/hw/virtio/vhost.c
index 4cae7c1664..fc43853704 100644
--- a/hw/virtio/vhost.c
+++ b/hw/virtio/vhost.c
@@ -1367,10 +1367,10 @@ fail_alloc_desc:
     return r;
 }
 
-void vhost_virtqueue_stop(struct vhost_dev *dev,
-                          struct VirtIODevice *vdev,
-                          struct vhost_virtqueue *vq,
-                          unsigned idx)
+int vhost_virtqueue_stop(struct vhost_dev *dev,
+                         struct VirtIODevice *vdev,
+                         struct vhost_virtqueue *vq,
+                         unsigned idx)
 {
     int vhost_vq_index = dev->vhost_ops->vhost_get_vq_index(dev, idx);
     struct vhost_vring_state state = {
@@ -1380,7 +1380,7 @@ void vhost_virtqueue_stop(struct vhost_dev *dev,
 
     if (virtio_queue_get_desc_addr(vdev, idx) == 0) {
         /* Don't stop the virtqueue which might have not been started */
-        return;
+        return 0;
     }
 
     r = dev->vhost_ops->vhost_get_vring_base(dev, &state);
@@ -1411,6 +1411,7 @@ void vhost_virtqueue_stop(struct vhost_dev *dev,
                        0, virtio_queue_get_avail_size(vdev, idx));
     vhost_memory_unmap(dev, vq->desc, virtio_queue_get_desc_size(vdev, idx),
                        0, virtio_queue_get_desc_size(vdev, idx));
+    return r;
 }
 
 static int vhost_virtqueue_set_busyloop_timeout(struct vhost_dev *dev,
@@ -2135,9 +2136,10 @@ fail_features:
 }
 
 /* Host notifiers must be enabled at this point. */
-void vhost_dev_stop(struct vhost_dev *hdev, VirtIODevice *vdev, bool vrings)
+int vhost_dev_stop(struct vhost_dev *hdev, VirtIODevice *vdev, bool vrings)
 {
     int i;
+    int rc = 0;
 
     /* should only be called after backend is connected */
     assert(hdev->vhost_ops);
@@ -2156,10 +2158,10 @@ void vhost_dev_stop(struct vhost_dev *hdev, VirtIODevice *vdev, bool vrings)
         vhost_dev_set_vring_enable(hdev, false);
     }
     for (i = 0; i < hdev->nvqs; ++i) {
-        vhost_virtqueue_stop(hdev,
-                             vdev,
-                             hdev->vqs + i,
-                             hdev->vq_index + i);
+        rc |= vhost_virtqueue_stop(hdev,
+                                   vdev,
+                                   hdev->vqs + i,
+                                   hdev->vq_index + i);
     }
     if (hdev->vhost_ops->vhost_reset_status) {
         hdev->vhost_ops->vhost_reset_status(hdev);
@@ -2176,6 +2178,7 @@ void vhost_dev_stop(struct vhost_dev *hdev, VirtIODevice *vdev, bool vrings)
     hdev->started = false;
     vdev->vhost_started = false;
     hdev->vdev = NULL;
+    return rc;
 }
 
 int vhost_net_set_backend(struct vhost_dev *hdev,
-- 
MST


