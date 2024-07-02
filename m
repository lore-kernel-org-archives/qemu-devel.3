Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 86DA9C30658
	for <qemu-devel@archiver.kernel.org>; Tue,  2 Jul 2024 14:09:42 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sOeAE-0001yl-F7; Tue, 02 Jul 2024 10:07:22 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1sOeAA-0001y5-Np
 for qemu-devel@nongnu.org; Tue, 02 Jul 2024 10:07:19 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1sOeA8-0007rm-RV
 for qemu-devel@nongnu.org; Tue, 02 Jul 2024 10:07:18 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1719929236;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=rU41nJqg3mDUGH1bcBpKF5g1VLC3bOtqyqIezIWqM9s=;
 b=CS6zgzEQsfKgQfJB1mqFiWDIKJC5azum9SkuwxLOfmY8bMlmtgzf0MA9KcxC909kQ91feg
 X5/dHyBLYGJxJtRkaj+5hdThDVJSzkEkUHNzznQdCliII3f7RzHFr4ktEhvKoZweU8mm/B
 pHFmpVoAQ2Hysg6lsMFI03LDDB0WbEk=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-400-p0EHxYLUP7eQhYGOwWEWJA-1; Tue, 02 Jul 2024 10:07:14 -0400
X-MC-Unique: p0EHxYLUP7eQhYGOwWEWJA-1
Received: by mail-wr1-f71.google.com with SMTP id
 ffacd0b85a97d-3678fd1edf8so39431f8f.0
 for <qemu-devel@nongnu.org>; Tue, 02 Jul 2024 07:07:13 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1719929232; x=1720534032;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=rU41nJqg3mDUGH1bcBpKF5g1VLC3bOtqyqIezIWqM9s=;
 b=nHilNEe5f5h3udc4efZQhS0A5CQnSuhM8InwdU4IdsGWM+lU9iLRXSzr3DJ9XJxj/o
 QFWpMhpPgDNyjZPifRb/rLgsvLNqPoMWxZMS2XYY1ZSqXHKThNO6DaPXoHSY1bJ7pv0M
 Kpn9/SmwBWzqJS+Cg1vojY5784kQF7DT5nxHIqTMzJwq9l5HtWA+HmS6Sgyv/NYEziPu
 xMQEd6JbRNle0YBmYdK353sFpU3andIXFzXTFHEs0dxGB2umARYGMCK2W7M1d0RQRjED
 Jw7rhYPE2qm/lQSdEv/eZbZNNTCp9cwjMa9or46NdjG7gWKbYovzGdk3koH+CfKqBTry
 uKhA==
X-Gm-Message-State: AOJu0Yz+knt6djuKsLdTjc11vIqP3npQ4ct9eL+QU6fPtxRFCdzNeqjf
 +KxuH/GulSzQWs3/PFXtNGsp7qchyQCSbK8kQwdxJ7Ac0WUGc7Jp+L6IQUtgUKBOriYK15Zjys4
 aCilRayCXCTNK6ke8bHqIppynqd1jSCjLHRQdPVIn9SYunkX1n5fP928RI5TjlXAAUgBWgVrOyc
 gHucWJQkG7rNReKrL7KUFBjvxeYr766w==
X-Received: by 2002:a5d:64c5:0:b0:360:70e3:ef2b with SMTP id
 ffacd0b85a97d-36774f89a41mr8439742f8f.26.1719929231914; 
 Tue, 02 Jul 2024 07:07:11 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEKYqN4kUEY91+413iOThkoANb5xdm5ahQDHk4KC16IP4U6fwb0tJorIxYagv6TncIHOFDFaA==
X-Received: by 2002:a5d:64c5:0:b0:360:70e3:ef2b with SMTP id
 ffacd0b85a97d-36774f89a41mr8439701f8f.26.1719929231276; 
 Tue, 02 Jul 2024 07:07:11 -0700 (PDT)
Received: from redhat.com ([2a02:14f:1f5:eadd:8c31:db01:9d01:7604])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3675a0cd712sm13347433f8f.20.2024.07.02.07.07.09
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 02 Jul 2024 07:07:10 -0700 (PDT)
Date: Tue, 2 Jul 2024 10:07:08 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Jonah Palmer <jonah.palmer@oracle.com>,
 Eugenio =?utf-8?B?UMOpcmV6?= <eperezma@redhat.com>
Subject: [PULL 04/91] virtio/virtio-pci: Handle extra notification data
Message-ID: <cf39b82860b63589460d8797dd70ae3c1647ccca.1719929191.git.mst@redhat.com>
References: <cover.1719929191.git.mst@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <cover.1719929191.git.mst@redhat.com>
X-Mailer: git-send-email 2.27.0.106.g8ac3dc51b1
X-Mutt-Fcc: =sent
Received-SPF: pass client-ip=170.10.133.124; envelope-from=mst@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

From: Jonah Palmer <jonah.palmer@oracle.com>

Add support to virtio-pci devices for handling the extra data sent
from the driver to the device when the VIRTIO_F_NOTIFICATION_DATA
transport feature has been negotiated.

The extra data that's passed to the virtio-pci device when this
feature is enabled varies depending on the device's virtqueue
layout.

In a split virtqueue layout, this data includes:
 - upper 16 bits: shadow_avail_idx
 - lower 16 bits: virtqueue index

In a packed virtqueue layout, this data includes:
 - upper 16 bits: 1-bit wrap counter & 15-bit shadow_avail_idx
 - lower 16 bits: virtqueue index

Signed-off-by: Jonah Palmer <jonah.palmer@oracle.com>
Message-Id: <20240315165557.26942-2-jonah.palmer@oracle.com>
Reviewed-by: Eugenio Pérez <eperezma@redhat.com>
Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
---
 include/hw/virtio/virtio.h |  2 ++
 hw/virtio/virtio-pci.c     | 12 +++++++++---
 hw/virtio/virtio.c         | 18 ++++++++++++++++++
 3 files changed, 29 insertions(+), 3 deletions(-)

diff --git a/include/hw/virtio/virtio.h b/include/hw/virtio/virtio.h
index 7d5ffdc145..1451926a13 100644
--- a/include/hw/virtio/virtio.h
+++ b/include/hw/virtio/virtio.h
@@ -307,6 +307,8 @@ int virtio_queue_ready(VirtQueue *vq);
 
 int virtio_queue_empty(VirtQueue *vq);
 
+void virtio_queue_set_shadow_avail_idx(VirtQueue *vq, uint16_t idx);
+
 /* Host binding interface.  */
 
 uint32_t virtio_config_readb(VirtIODevice *vdev, uint32_t addr);
diff --git a/hw/virtio/virtio-pci.c b/hw/virtio/virtio-pci.c
index b1d02f4b3d..cffc7efcae 100644
--- a/hw/virtio/virtio-pci.c
+++ b/hw/virtio/virtio-pci.c
@@ -384,7 +384,7 @@ static void virtio_ioport_write(void *opaque, uint32_t addr, uint32_t val)
 {
     VirtIOPCIProxy *proxy = opaque;
     VirtIODevice *vdev = virtio_bus_get_device(&proxy->bus);
-    uint16_t vector;
+    uint16_t vector, vq_idx;
     hwaddr pa;
 
     switch (addr) {
@@ -408,8 +408,14 @@ static void virtio_ioport_write(void *opaque, uint32_t addr, uint32_t val)
             vdev->queue_sel = val;
         break;
     case VIRTIO_PCI_QUEUE_NOTIFY:
-        if (val < VIRTIO_QUEUE_MAX) {
-            virtio_queue_notify(vdev, val);
+        vq_idx = val;
+        if (vq_idx < VIRTIO_QUEUE_MAX && virtio_queue_get_num(vdev, vq_idx)) {
+            if (virtio_vdev_has_feature(vdev, VIRTIO_F_NOTIFICATION_DATA)) {
+                VirtQueue *vq = virtio_get_queue(vdev, vq_idx);
+
+                virtio_queue_set_shadow_avail_idx(vq, val >> 16);
+            }
+            virtio_queue_notify(vdev, vq_idx);
         }
         break;
     case VIRTIO_PCI_STATUS:
diff --git a/hw/virtio/virtio.c b/hw/virtio/virtio.c
index 893a072c9d..f7c99e3a96 100644
--- a/hw/virtio/virtio.c
+++ b/hw/virtio/virtio.c
@@ -2264,6 +2264,24 @@ void virtio_queue_set_align(VirtIODevice *vdev, int n, int align)
     }
 }
 
+void virtio_queue_set_shadow_avail_idx(VirtQueue *vq, uint16_t shadow_avail_idx)
+{
+    if (!vq->vring.desc) {
+        return;
+    }
+
+    /*
+     * 16-bit data for packed VQs include 1-bit wrap counter and
+     * 15-bit shadow_avail_idx.
+     */
+    if (virtio_vdev_has_feature(vq->vdev, VIRTIO_F_RING_PACKED)) {
+        vq->shadow_avail_wrap_counter = (shadow_avail_idx >> 15) & 0x1;
+        vq->shadow_avail_idx = shadow_avail_idx & 0x7FFF;
+    } else {
+        vq->shadow_avail_idx = shadow_avail_idx;
+    }
+}
+
 static void virtio_queue_notify_vq(VirtQueue *vq)
 {
     if (vq->vring.desc && vq->handle_output) {
-- 
MST


