Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D59B6C3065C
	for <qemu-devel@archiver.kernel.org>; Tue,  2 Jul 2024 20:19:34 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sOjv6-0005x1-Oq; Tue, 02 Jul 2024 16:16:08 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1sOjuc-0005XH-Dr
 for qemu-devel@nongnu.org; Tue, 02 Jul 2024 16:15:40 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1sOjua-0007wv-OD
 for qemu-devel@nongnu.org; Tue, 02 Jul 2024 16:15:38 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1719951333;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=uByx4Oz+CQ80E+9HMb1HUHKkD83RXYCyv+000WUVwgE=;
 b=BA4r/NTOpAPOAiq2bCqkAO7uP1ojsiL6puhAt5fAVyKBzAuIJNJityeyUkErdiZ0CPOP0D
 aJikMMCzBuMyMqmusljArdPfzlIIdYqfLWPkpmQ3jbIikOHqwuYsECXUX19scDghM+4WIs
 B9u/SXj/dmpH7b9ndyDtfoKiaX47B2Q=
Received: from mail-ej1-f69.google.com (mail-ej1-f69.google.com
 [209.85.218.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-39-YrsH2GLOMmyJfc28WUdPEQ-1; Tue, 02 Jul 2024 16:15:32 -0400
X-MC-Unique: YrsH2GLOMmyJfc28WUdPEQ-1
Received: by mail-ej1-f69.google.com with SMTP id
 a640c23a62f3a-a6fe837c066so564030966b.1
 for <qemu-devel@nongnu.org>; Tue, 02 Jul 2024 13:15:32 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1719951330; x=1720556130;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=uByx4Oz+CQ80E+9HMb1HUHKkD83RXYCyv+000WUVwgE=;
 b=GcBGaRCMr2rO69u7zEL9qRMjLPgtaxqCyeqY2C/BWCYBvYIHXtbOAFE8iQhfDMG1DF
 89KSX4P1egtv9gXalM951l6k5YI24EiYgsmJbGCACmBEFNVbns4IydKNf1WVIj/oqbW3
 Z8agvIpdEB2J33f7a5m0zynFnLQFfPxci7INtM1zWatieGcBiXW9ocwFChNNNbwT+IV0
 RmiGOK789lCkaaa3GWvoG/ZqggJQIadx0YfVzzXU/nSbHH3etN5nF71fYbjxkDPYTKF/
 u9CijJAPsF7YzViWw8qukw8vfW/gmB0qLk4GONxaPl/iHFqnvlrqzBYgkP5XuNAx4FZT
 Xoqg==
X-Gm-Message-State: AOJu0Yxg3/g0KDYclAcoa5c55fXLOu0+tBgHjzolPU0Z2IaFkzPbpQL7
 Q/ezpIvuLc+s5XFFdDTwFFXT68RURVRvScfL/wVYxiRxdmKiIgU0EbTJG/fk4Mi9F1N85C39oYc
 ZI+Z6LIozwDnjJysL9F61BccxwtRbpz6Uw37Xm8T8gxG4dlNIv5l4FyGiX/5UZPzRwxTc5BQAIx
 lgifqx2AZwG8D+19207if4r0fCQXL2zg==
X-Received: by 2002:a17:906:5aca:b0:a6f:dcb6:223d with SMTP id
 a640c23a62f3a-a72aee3cf46mr925649066b.8.1719951330649; 
 Tue, 02 Jul 2024 13:15:30 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFlEfP0CafDl+sMSIZjW2ChHhrFkOSeZ+pHppBkBiQQqY000DCPiFeH+2DhXvdRg7Kqs2JT9Q==
X-Received: by 2002:a17:906:5aca:b0:a6f:dcb6:223d with SMTP id
 a640c23a62f3a-a72aee3cf46mr925646966b.8.1719951330129; 
 Tue, 02 Jul 2024 13:15:30 -0700 (PDT)
Received: from redhat.com ([2a02:14f:1f5:eadd:8c31:db01:9d01:7604])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-a7518578c23sm291507466b.127.2024.07.02.13.15.28
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 02 Jul 2024 13:15:29 -0700 (PDT)
Date: Tue, 2 Jul 2024 16:15:27 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Jonah Palmer <jonah.palmer@oracle.com>
Subject: [PULL v2 06/88] virtio-mmio: Handle extra notification data
Message-ID: <54869366be60af2eb52cffaedad73ba1f4247e15.1719951168.git.mst@redhat.com>
References: <cover.1719951168.git.mst@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1719951168.git.mst@redhat.com>
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

Add support to virtio-mmio devices for handling the extra data sent from
the driver to the device when the VIRTIO_F_NOTIFICATION_DATA transport
feature has been negotiated.

The extra data that's passed to the virtio-mmio device when this feature
is enabled varies depending on the device's virtqueue layout.

The data passed to the virtio-mmio device is in the same format as the
data passed to virtio-pci devices.

Signed-off-by: Jonah Palmer <jonah.palmer@oracle.com>
Message-Id: <20240315165557.26942-4-jonah.palmer@oracle.com>
Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
---
 hw/virtio/virtio-mmio.c | 11 +++++++++--
 1 file changed, 9 insertions(+), 2 deletions(-)

diff --git a/hw/virtio/virtio-mmio.c b/hw/virtio/virtio-mmio.c
index 22f9fbcf5a..320428ac0d 100644
--- a/hw/virtio/virtio-mmio.c
+++ b/hw/virtio/virtio-mmio.c
@@ -248,6 +248,7 @@ static void virtio_mmio_write(void *opaque, hwaddr offset, uint64_t value,
 {
     VirtIOMMIOProxy *proxy = (VirtIOMMIOProxy *)opaque;
     VirtIODevice *vdev = virtio_bus_get_device(&proxy->bus);
+    uint16_t vq_idx;
 
     trace_virtio_mmio_write_offset(offset, value);
 
@@ -407,8 +408,14 @@ static void virtio_mmio_write(void *opaque, hwaddr offset, uint64_t value,
         }
         break;
     case VIRTIO_MMIO_QUEUE_NOTIFY:
-        if (value < VIRTIO_QUEUE_MAX) {
-            virtio_queue_notify(vdev, value);
+        vq_idx = value;
+        if (vq_idx < VIRTIO_QUEUE_MAX && virtio_queue_get_num(vdev, vq_idx)) {
+            if (virtio_vdev_has_feature(vdev, VIRTIO_F_NOTIFICATION_DATA)) {
+                VirtQueue *vq = virtio_get_queue(vdev, vq_idx);
+
+                virtio_queue_set_shadow_avail_idx(vq, (value >> 16) & 0xFFFF);
+            }
+            virtio_queue_notify(vdev, vq_idx);
         }
         break;
     case VIRTIO_MMIO_INTERRUPT_ACK:
-- 
MST


