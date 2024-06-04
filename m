Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D4CBAC41513
	for <qemu-devel@archiver.kernel.org>; Tue,  4 Jun 2024 19:07:12 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sEZUM-0005nF-Id; Tue, 04 Jun 2024 15:06:30 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1sEZUL-0005lR-DU
 for qemu-devel@nongnu.org; Tue, 04 Jun 2024 15:06:29 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1sEZUJ-0000k1-MD
 for qemu-devel@nongnu.org; Tue, 04 Jun 2024 15:06:29 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1717527986;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=dtEoeRDSt/hukSx1+wwR8G88DQKSruaP42MuHd75N3g=;
 b=M9ceiOLG0+ejlioM8+Cm16buY+3L/s2JmO8aQXSJMYg6lRAoeeD7YfEBpI+FFzliHDcQ3o
 XTn7rR1+3BBLfh7J2XcM1mK0e2KGkJ0pTB4VgbvQsUC8uAMD2S1KLw1Cb+BxJNIQqpq6E6
 zEU+TQpfWbTmvF5+XvF6inii5FJtMSg=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-257-yLBNVmXRMUu1GmcSb2HnAQ-1; Tue, 04 Jun 2024 15:06:20 -0400
X-MC-Unique: yLBNVmXRMUu1GmcSb2HnAQ-1
Received: by mail-wm1-f72.google.com with SMTP id
 5b1f17b1804b1-4210d151c5bso45057765e9.3
 for <qemu-devel@nongnu.org>; Tue, 04 Jun 2024 12:06:20 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1717527979; x=1718132779;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=dtEoeRDSt/hukSx1+wwR8G88DQKSruaP42MuHd75N3g=;
 b=OnWNk4QM3BfTmunQ6CwzouLS+A/LjVt4+MTwq9f3EWbIkGf2p6pCJjKWb4E4FR3xa4
 6d/tCv3IxDgnYi8rbDXPfX09LYvV29z+BGuzpBCC8Vn/+IyQhcJrJTlQvBRjE4tFSRAP
 1XE6YzxoCpC0be1U1qQD/wzoBncLarB+eNZEzx0itympkmm2pOFQZS3DpBb33HnCAiwH
 ADg4pIJFCu9ngFgu3sb5QAUzhsvbbrsuucfyWrKAqMuHhq3kB3H9zhZ9z4H+Qr1VuZ2b
 wguEyTqpo4yOlFDEDlamj7w03qtdhZfL6CiR+jC4KOc4MdSk0s7ypVolylB+GWEwNf5P
 P1WQ==
X-Gm-Message-State: AOJu0Ywcpr26kjznbHPmr5OEMCzNZoDYkAM9GklESGUMxepDRiXJSGFo
 gKE50JS4R9AbtXNIUuRzGcS+oCSJtKw0Rtg34aW86tX8KBgXfqQQ1JB1gGeM1H17LHt1gdh2xR+
 BvpnrfF4iPskiwXsQiqZBgJa5jdw9i4WGjTTK77NE821FKpIGlUiZyaFT7VjGwqkgqeuxONXKR8
 eeB+AFHU63YkPRSSgKbRlLUgrKX8VtTg==
X-Received: by 2002:a05:600c:1e02:b0:41a:41c8:d8e7 with SMTP id
 5b1f17b1804b1-421562df1f7mr3461275e9.3.1717527979007; 
 Tue, 04 Jun 2024 12:06:19 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGp44H/nTfoe/dcDLPcW4ennQ5FlRwdnvKJHPvztIvpNJKMenwvWTFpITCNQjOjcw36itU2Bw==
X-Received: by 2002:a05:600c:1e02:b0:41a:41c8:d8e7 with SMTP id
 5b1f17b1804b1-421562df1f7mr3461095e9.3.1717527978459; 
 Tue, 04 Jun 2024 12:06:18 -0700 (PDT)
Received: from redhat.com ([2a0d:6fc7:552:cf5c:2b13:215c:b9df:f231])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4212b51082dsm165919005e9.0.2024.06.04.12.06.16
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 04 Jun 2024 12:06:17 -0700 (PDT)
Date: Tue, 4 Jun 2024 15:06:15 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Jonah Palmer <jonah.palmer@oracle.com>,
 Eugenio =?utf-8?B?UMOpcmV6?= <eperezma@redhat.com>
Subject: [PULL 05/46] virtio/virtio-pci: Handle extra notification data
Message-ID: <a88ab3cfa7548d36eac5a624100a66158a94a514.1717527933.git.mst@redhat.com>
References: <cover.1717527933.git.mst@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <cover.1717527933.git.mst@redhat.com>
X-Mailer: git-send-email 2.27.0.106.g8ac3dc51b1
X-Mutt-Fcc: =sent
Received-SPF: pass client-ip=170.10.129.124; envelope-from=mst@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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
index a7faee5b33..ad0035952f 100644
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


