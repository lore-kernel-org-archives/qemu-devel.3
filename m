Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BC515C54FB3
	for <qemu-devel@archiver.kernel.org>; Sun,  1 Jun 2025 15:26:50 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uLka7-0003vx-2x; Sun, 01 Jun 2025 11:26:40 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1uLkZg-0003QM-6H
 for qemu-devel@nongnu.org; Sun, 01 Jun 2025 11:26:17 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1uLkZe-0004hV-Al
 for qemu-devel@nongnu.org; Sun, 01 Jun 2025 11:26:11 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1748791569;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=ZPyR+kdxKaWeyjstcc9d1CRAs5zwrN33s5qY/Fih3ks=;
 b=h0EZ0lVr/fBGUO+6c7iHGqGG+3R5qUhkC1LrwateAQGHdjROVuNG3FQfCrfFPAc9YuNO3/
 ztIzfwke704P+psRmgkAVX+7v3oZMoP2raAmpZ8xNqou0OpQLEuIQ4p12LFSlhHWXFILAr
 +LydfxB3hBeIXv7nV/DBto/rh1cvHe0=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-634-PRVdb3RzORWXUubz01mI3g-1; Sun, 01 Jun 2025 11:26:08 -0400
X-MC-Unique: PRVdb3RzORWXUubz01mI3g-1
X-Mimecast-MFC-AGG-ID: PRVdb3RzORWXUubz01mI3g_1748791567
Received: by mail-wr1-f71.google.com with SMTP id
 ffacd0b85a97d-3a4f7ebfd00so1054622f8f.2
 for <qemu-devel@nongnu.org>; Sun, 01 Jun 2025 08:26:08 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1748791566; x=1749396366;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=ZPyR+kdxKaWeyjstcc9d1CRAs5zwrN33s5qY/Fih3ks=;
 b=svQQnxv6BCUWZJf7V8+yAA05e755uyRpclSJ6vYj+SyMRRrErpm/yt98M/nqvRMwbB
 K7l4CPDFgSXE0d+/nfCoSx+7Ny5rc763ATM8+i3UWxIB6sNbGbJqCcnaqLCxBAQpXlyt
 bDllhECj3DcFlGHLGrYEdVM0i8lERq3sKvfm55ahWCo8qXSr0C/sRIg31/EHldLM1Qtb
 ar2fEgQHFEoXO8wTF0nLNw5c5nNCHooKc0R2oeGkRNJ2pfguCaP2gDMca59jxvAEJt87
 7MIxQL/cgCbmbce7pSDEogNhjBtoES0YLdvT3wARMXBwlX/sK+ZVEuey4kbsHHWngwx0
 zG1w==
X-Gm-Message-State: AOJu0YyCAcCWOgj5o3cEGOONaQ5rIFudCTo+kdEp6dEGEPb3DqQN1C6w
 zbf5GiN9X6u4VC6bf7mGLv9YH6EdOflQNycbhoRBoHb8VVB+Uwc/rn7SbEq8NRyTuBN/dPFuZsx
 i3pOAAYkM7aZ5d+h9IE1f+qWtQGl89/i6fAO8/Sve8EQQ/y6wvicrLtFyljztqlK4pHtmy/mLYk
 KN8i00xigqGgUkoHyxdBNBN6fx0gEUZ39Krg==
X-Gm-Gg: ASbGnctd3hf5dd/3/U9dnLyK77Kf99n7AFo+RoQxO+PA0m+rsiqIR4yhuFpbCSRFQwC
 B0/siby3//UVsXrdkw/vBRf5CIXCFbAHBB3Cm9MrcfraOJgSs27CVhtoDCVjPJVLx+sUalmi8dR
 RxnaBhVZ93tcPXe0BbFEP6WzXMZYQUz/yzHgj7mOqW0il396t3Q4T0WkpY57ABj6IBy8UIG1LFQ
 pXa6pGJ4hCDztxyoM6vXi38ZmJwKwHcQyBkEw5jaX55vBD46y4VV4HbfLLMUqvtZbzQ3W8O1djL
 4PXwKw==
X-Received: by 2002:a05:6000:26d3:b0:3a3:621a:d3c5 with SMTP id
 ffacd0b85a97d-3a4f7a4c833mr7455792f8f.19.1748791566341; 
 Sun, 01 Jun 2025 08:26:06 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IH34UJRUQ84l+D6D73hUS5iIPauyby9ho/o1kVsDEUbWM6KWIm47qz09GbGf3m7rMBUqaF6lQ==
X-Received: by 2002:a05:6000:26d3:b0:3a3:621a:d3c5 with SMTP id
 ffacd0b85a97d-3a4f7a4c833mr7455766f8f.19.1748791565812; 
 Sun, 01 Jun 2025 08:26:05 -0700 (PDT)
Received: from redhat.com ([2a0d:6fc0:1517:1000:ea83:8e5f:3302:3575])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3a4f0097539sm12029877f8f.63.2025.06.01.08.26.04
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 01 Jun 2025 08:26:04 -0700 (PDT)
Date: Sun, 1 Jun 2025 11:26:03 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Eugenio =?utf-8?B?UMOpcmV6?= <eperezma@redhat.com>,
 Lei Yang <leiyang@redhat.com>, Si-Wei Liu <si-wei.liu@oracle.com>,
 Jason Wang <jasowang@redhat.com>, Jonah Palmer <jonah.palmer@oracle.com>,
 Stefano Garzarella <sgarzare@redhat.com>
Subject: [PULL 30/31] vdpa: move memory listener register to vhost_vdpa_init
Message-ID: <e88eeb089f33c6cb4c177952038c8e2613be7342.1748791463.git.mst@redhat.com>
References: <cover.1748791463.git.mst@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <cover.1748791463.git.mst@redhat.com>
X-Mailer: git-send-email 2.27.0.106.g8ac3dc51b1
X-Mutt-Fcc: =sent
Received-SPF: pass client-ip=170.10.133.124; envelope-from=mst@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -31
X-Spam_score: -3.2
X-Spam_bar: ---
X-Spam_report: (-3.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.071,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=-1, RCVD_IN_MSPIKE_WL=-0.01,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
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

From: Eugenio Pérez <eperezma@redhat.com>

Current memory operations like pinning may take a lot of time at the
destination.  Currently they are done after the source of the migration is
stopped, and before the workload is resumed at the destination.  This is a
period where neigher traffic can flow, nor the VM workload can continue
(downtime).

We can do better as we know the memory layout of the guest RAM at the
destination from the moment that all devices are initializaed.  So
moving that operation allows QEMU to communicate the kernel the maps
while the workload is still running in the source, so Linux can start
mapping them.

As a small drawback, there is a time in the initialization where QEMU
cannot respond to QMP etc.  By some testing, this time is about
0.2seconds.  This may be further reduced (or increased) depending on the
vdpa driver and the platform hardware, and it is dominated by the cost
of memory pinning.

This matches the time that we move out of the called downtime window.
The downtime is measured as the elapsed trace time between the last
vhost_vdpa_suspend on the source and the last vhost_vdpa_set_vring_enable_one
on the destination. In other words, from "guest CPUs freeze" to the
instant the final Rx/Tx queue-pair is able to start moving data.

Using ConnectX-6 Dx (MLX5) NICs in vhost-vDPA mode with 8 queue-pairs,
the series reduces guest-visible downtime during back-to-back live
migrations by more than half:
- 39G VM:   4.72s -> 2.09s (-2.63s, ~56% improvement)
- 128G VM:  14.72s -> 5.83s (-8.89s, ~60% improvement)

Tested-by: Lei Yang <leiyang@redhat.com>
Reviewed-by: Si-Wei Liu <si-wei.liu@oracle.com>
Acked-by: Jason Wang <jasowang@redhat.com>
Signed-off-by: Eugenio Pérez <eperezma@redhat.com>
Signed-off-by: Jonah Palmer <jonah.palmer@oracle.com>

Message-Id: <20250522145839.59974-8-jonah.palmer@oracle.com>
Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
---
 hw/virtio/vhost-vdpa.c | 35 ++++++++++++++++++++++++++++-------
 1 file changed, 28 insertions(+), 7 deletions(-)

diff --git a/hw/virtio/vhost-vdpa.c b/hw/virtio/vhost-vdpa.c
index de834f2ebd..e20da95f30 100644
--- a/hw/virtio/vhost-vdpa.c
+++ b/hw/virtio/vhost-vdpa.c
@@ -894,8 +894,14 @@ static int vhost_vdpa_reset_device(struct vhost_dev *dev)
 
     ret = vhost_vdpa_call(dev, VHOST_VDPA_SET_STATUS, &status);
     trace_vhost_vdpa_reset_device(dev);
+    if (ret) {
+        return ret;
+    }
+
+    memory_listener_unregister(&v->shared->listener);
+    v->shared->listener_registered = false;
     v->suspended = false;
-    return ret;
+    return 0;
 }
 
 static int vhost_vdpa_get_vq_index(struct vhost_dev *dev, int idx)
@@ -1379,6 +1385,11 @@ static int vhost_vdpa_dev_start(struct vhost_dev *dev, bool started)
                          "IOMMU and try again");
             return -1;
         }
+        if (v->shared->listener_registered &&
+            dev->vdev->dma_as != v->shared->listener.address_space) {
+            memory_listener_unregister(&v->shared->listener);
+            v->shared->listener_registered = false;
+        }
         if (!v->shared->listener_registered) {
             memory_listener_register(&v->shared->listener, dev->vdev->dma_as);
             v->shared->listener_registered = true;
@@ -1392,8 +1403,6 @@ static int vhost_vdpa_dev_start(struct vhost_dev *dev, bool started)
 
 static void vhost_vdpa_reset_status(struct vhost_dev *dev)
 {
-    struct vhost_vdpa *v = dev->opaque;
-
     if (!vhost_vdpa_last_dev(dev)) {
         return;
     }
@@ -1401,9 +1410,6 @@ static void vhost_vdpa_reset_status(struct vhost_dev *dev)
     vhost_vdpa_reset_device(dev);
     vhost_vdpa_add_status(dev, VIRTIO_CONFIG_S_ACKNOWLEDGE |
                                VIRTIO_CONFIG_S_DRIVER);
-    memory_listener_unregister(&v->shared->listener);
-    v->shared->listener_registered = false;
-
 }
 
 static int vhost_vdpa_set_log_base(struct vhost_dev *dev, uint64_t base,
@@ -1537,12 +1543,27 @@ static int vhost_vdpa_get_features(struct vhost_dev *dev,
 
 static int vhost_vdpa_set_owner(struct vhost_dev *dev)
 {
+    int r;
+    struct vhost_vdpa *v;
+
     if (!vhost_vdpa_first_dev(dev)) {
         return 0;
     }
 
     trace_vhost_vdpa_set_owner(dev);
-    return vhost_vdpa_call(dev, VHOST_SET_OWNER, NULL);
+    r = vhost_vdpa_call(dev, VHOST_SET_OWNER, NULL);
+    if (unlikely(r < 0)) {
+        return r;
+    }
+
+    /*
+     * Being optimistic and listening address space memory. If the device
+     * uses vIOMMU, it is changed at vhost_vdpa_dev_start.
+     */
+    v = dev->opaque;
+    memory_listener_register(&v->shared->listener, &address_space_memory);
+    v->shared->listener_registered = true;
+    return 0;
 }
 
 static int vhost_vdpa_vq_get_addr(struct vhost_dev *dev,
-- 
MST


