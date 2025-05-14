Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 87402C3ABD8
	for <qemu-devel@archiver.kernel.org>; Wed, 14 May 2025 11:58:48 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uFAfx-0000e3-SU; Wed, 14 May 2025 07:53:30 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1uFAe0-0006cE-6F
 for qemu-devel@nongnu.org; Wed, 14 May 2025 07:51:33 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1uFAdu-0006Nb-Ku
 for qemu-devel@nongnu.org; Wed, 14 May 2025 07:51:27 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1747223479;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=HnuqpIUtdmJu47LKWP+h8IXAeG/9kJhvAnZOIfqpYg8=;
 b=NRePbIlSZvFhIKzfHv6DLRmDSIhxutCcs3hvgVDVFnbsdfsPHWg14cCTafR1K4VR3qaWkm
 9JGnAuR7tRkBxnimektZd6rcBYHYIUPGiXFHmyJjWnXe0B2MEXPncUQhZDiCG2S4oHmTOm
 GZ+5WzipPvjrDUlCjTMD9Jw+5czwplw=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-190-SLeayItWO3OODACn6ahKcA-1; Wed, 14 May 2025 07:51:18 -0400
X-MC-Unique: SLeayItWO3OODACn6ahKcA-1
X-Mimecast-MFC-AGG-ID: SLeayItWO3OODACn6ahKcA_1747223477
Received: by mail-wm1-f69.google.com with SMTP id
 5b1f17b1804b1-43d0a037f97so34800435e9.2
 for <qemu-devel@nongnu.org>; Wed, 14 May 2025 04:51:18 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1747223477; x=1747828277;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=HnuqpIUtdmJu47LKWP+h8IXAeG/9kJhvAnZOIfqpYg8=;
 b=jbZENrY6SPtddrVfwegc+HO6b4GZY4gKDTYm23XPw9cEs9917bAWRTXPFQm6rprXYN
 0r8R/W6WG4sx4Bn1nPaHT3uW8XiDkGom8EfSx1RVbFXQzVBhnGRUIC7Q/gs2rfTvVUdR
 e2A6MrFnIi/T04itqR7vbLCMlvzt2Tlwu7uBTHqvohu6151TS/wGZ+PJ6H6mVYVSlhtu
 Bi81bG5NGKUcaXX084vQS00igfYqIWuYEfgH/09dZQcagY7OFE0t2RybR8zF6fraTGjm
 JHBt9cesxw9sP3r0OT6mm79/BfR4yVAjTb30NBEEigHsmXT54ZDHIQmGd0mmx1MtmeIh
 qg9g==
X-Gm-Message-State: AOJu0YxVym0PF0zk8qDv5ZqcQZLMyc3tNL57gSQ2ZkHSIljvtP2KhZwe
 4bVb9uPw0eY4HTv+S+rWKI6ZaSTMBwEQOK0Th7mJERDIIkAhUey8ehvmDgaA7fYEILW9PYXUepP
 DcnU/hqOBnw26wOb8oBfu/B8OK3LPES8cVdC5PACVL2aRffXNKrKtfIoZUw2gSwdhK78OZQuxZd
 /V4mbh2zjygR+GY1W0shjsDWqG17zKOA==
X-Gm-Gg: ASbGncum/bWOYPuaD/lahR6zQDpNqXKnfYv9EaRLVmSpR/7LE4ytDgPnnu2b1tdvmwx
 zQlCPAIDBDwZU0DMyCUT4X5eR65Q5PN5LgmyuMQYYiudNpKwyAKT3QofsKlf3q1SEIZAxA2cecd
 n7/2vz5V7vTz1VaW/hKKwKkgYs8uhiNjYV+kGBfE/os+ITxChsFKfuM/W28eAJ3Kd8Hk9j1u/Au
 drEdR61OdJej3tIawIEm2AKPfTvWBQ61dl2PPHce1YVQ+QlwFDguOOzx4UGcE6p9PboD01PNTS7
 f48ZHg==
X-Received: by 2002:a05:600c:8508:b0:440:59eb:bfc with SMTP id
 5b1f17b1804b1-442f752f78fmr2058545e9.23.1747223476856; 
 Wed, 14 May 2025 04:51:16 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGK+tkNrWQ23VX/0Xt5GPJfFb5LwXcWoqKhbKXuZjFXfBp+A0FCydWm7Aatlek+OjfqTn/zTQ==
X-Received: by 2002:a05:600c:8508:b0:440:59eb:bfc with SMTP id
 5b1f17b1804b1-442f752f78fmr2058345e9.23.1747223476510; 
 Wed, 14 May 2025 04:51:16 -0700 (PDT)
Received: from redhat.com ([2a0d:6fc0:1517:1000:ea83:8e5f:3302:3575])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-442f39e84d3sm29380325e9.32.2025.05.14.04.51.15
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 14 May 2025 04:51:16 -0700 (PDT)
Date: Wed, 14 May 2025 07:51:14 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Akihiko Odaki <akihiko.odaki@daynix.com>
Subject: [PULL 23/27] virtio: Move virtio_reset()
Message-ID: <77a9408fc774ad99dcd16ea08f31b96b590fbf99.1747223385.git.mst@redhat.com>
References: <cover.1747223385.git.mst@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1747223385.git.mst@redhat.com>
X-Mailer: git-send-email 2.27.0.106.g8ac3dc51b1
X-Mutt-Fcc: =sent
Received-SPF: pass client-ip=170.10.133.124; envelope-from=mst@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -37
X-Spam_score: -3.8
X-Spam_bar: ---
X-Spam_report: (-3.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.686,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, T_SPF_TEMPERROR=0.01 autolearn=ham autolearn_force=no
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

From: Akihiko Odaki <akihiko.odaki@daynix.com>

Move virtio_reset() to a later part of the file to remove the forward
declaration of virtio_set_features_nocheck() and to prepare the
situation that we need more operations to perform during reset.

Signed-off-by: Akihiko Odaki <akihiko.odaki@daynix.com>
Message-Id: <20250421-reset-v2-2-e4c1ead88ea1@daynix.com>
Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
---
 hw/virtio/virtio.c | 88 ++++++++++++++++++++++------------------------
 1 file changed, 43 insertions(+), 45 deletions(-)

diff --git a/hw/virtio/virtio.c b/hw/virtio/virtio.c
index 3300f4afb0..2e98cecf64 100644
--- a/hw/virtio/virtio.c
+++ b/hw/virtio/virtio.c
@@ -2320,51 +2320,6 @@ void virtio_queue_enable(VirtIODevice *vdev, uint32_t queue_index)
     }
 }
 
-static int virtio_set_features_nocheck(VirtIODevice *vdev, uint64_t val);
-
-void virtio_reset(void *opaque)
-{
-    VirtIODevice *vdev = opaque;
-    VirtioDeviceClass *k = VIRTIO_DEVICE_GET_CLASS(vdev);
-    int i;
-
-    virtio_set_status(vdev, 0);
-    if (current_cpu) {
-        /* Guest initiated reset */
-        vdev->device_endian = virtio_current_cpu_endian();
-    } else {
-        /* System reset */
-        vdev->device_endian = virtio_default_endian();
-    }
-
-    if (k->get_vhost) {
-        struct vhost_dev *hdev = k->get_vhost(vdev);
-        /* Only reset when vhost back-end is connected */
-        if (hdev && hdev->vhost_ops) {
-            vhost_reset_device(hdev);
-        }
-    }
-
-    if (k->reset) {
-        k->reset(vdev);
-    }
-
-    vdev->start_on_kick = false;
-    vdev->started = false;
-    vdev->broken = false;
-    virtio_set_features_nocheck(vdev, 0);
-    vdev->queue_sel = 0;
-    vdev->status = 0;
-    vdev->disabled = false;
-    qatomic_set(&vdev->isr, 0);
-    vdev->config_vector = VIRTIO_NO_VECTOR;
-    virtio_notify_vector(vdev, vdev->config_vector);
-
-    for(i = 0; i < VIRTIO_QUEUE_MAX; i++) {
-        __virtio_queue_reset(vdev, i);
-    }
-}
-
 void virtio_queue_set_addr(VirtIODevice *vdev, int n, hwaddr addr)
 {
     if (!vdev->vq[n].vring.num) {
@@ -3175,6 +3130,49 @@ int virtio_set_features(VirtIODevice *vdev, uint64_t val)
     return ret;
 }
 
+void virtio_reset(void *opaque)
+{
+    VirtIODevice *vdev = opaque;
+    VirtioDeviceClass *k = VIRTIO_DEVICE_GET_CLASS(vdev);
+    int i;
+
+    virtio_set_status(vdev, 0);
+    if (current_cpu) {
+        /* Guest initiated reset */
+        vdev->device_endian = virtio_current_cpu_endian();
+    } else {
+        /* System reset */
+        vdev->device_endian = virtio_default_endian();
+    }
+
+    if (k->get_vhost) {
+        struct vhost_dev *hdev = k->get_vhost(vdev);
+        /* Only reset when vhost back-end is connected */
+        if (hdev && hdev->vhost_ops) {
+            vhost_reset_device(hdev);
+        }
+    }
+
+    if (k->reset) {
+        k->reset(vdev);
+    }
+
+    vdev->start_on_kick = false;
+    vdev->started = false;
+    vdev->broken = false;
+    virtio_set_features_nocheck(vdev, 0);
+    vdev->queue_sel = 0;
+    vdev->status = 0;
+    vdev->disabled = false;
+    qatomic_set(&vdev->isr, 0);
+    vdev->config_vector = VIRTIO_NO_VECTOR;
+    virtio_notify_vector(vdev, vdev->config_vector);
+
+    for (i = 0; i < VIRTIO_QUEUE_MAX; i++) {
+        __virtio_queue_reset(vdev, i);
+    }
+}
+
 static void virtio_device_check_notification_compatibility(VirtIODevice *vdev,
                                                            Error **errp)
 {
-- 
MST


