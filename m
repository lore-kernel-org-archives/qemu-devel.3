Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D1618C31D97
	for <qemu-devel@archiver.kernel.org>; Wed,  3 Jul 2024 22:45:52 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sP8iX-00023P-V3; Wed, 03 Jul 2024 18:44:50 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1sP8iW-000234-B2
 for qemu-devel@nongnu.org; Wed, 03 Jul 2024 18:44:48 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1sP8iU-0000te-UR
 for qemu-devel@nongnu.org; Wed, 03 Jul 2024 18:44:48 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1720046686;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=uByx4Oz+CQ80E+9HMb1HUHKkD83RXYCyv+000WUVwgE=;
 b=MLYrDlrZ9xe/2FZrpRoVU754aqYpqqgfN3xIZ8gr02AJ9RYs99z+4/McsxPqa8b4WNIbfU
 hMyDIZNw3NaEzAnJYXQ2ZyD7HxOZ2frCq3ijLZE7Q4cmJrHduNpS8xCIJcMBzw6FyDHArm
 AM4qkRKtcQbBEmdB1vmPjL1CxToOHG4=
Received: from mail-ej1-f70.google.com (mail-ej1-f70.google.com
 [209.85.218.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-361-qV9kRkMxOk-t4ziYx-A18A-1; Wed, 03 Jul 2024 18:44:44 -0400
X-MC-Unique: qV9kRkMxOk-t4ziYx-A18A-1
Received: by mail-ej1-f70.google.com with SMTP id
 a640c23a62f3a-a751eb024abso1034566b.0
 for <qemu-devel@nongnu.org>; Wed, 03 Jul 2024 15:44:44 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1720046682; x=1720651482;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=uByx4Oz+CQ80E+9HMb1HUHKkD83RXYCyv+000WUVwgE=;
 b=mzMWkITh5ajbz7ZhtErh0cFih7gAMg6WlqlYIyml6wYuuT0pl2RqnmFlU5556FpdbI
 +eU1S2Qh3wicMRzVXUKokN4WmOYbC0y+1JDk0t7kVHlMHve8L0nl6xe7j+a8dlA1pWkY
 2Vgp+5jfjAswOvtvo/s2tyJ6lVWBTEv43MJnRX57r2b5wT9F3YyGFP9UVYp/lc864vEu
 9QM54HL1VFt8hESZ1o6J0+v0ciZwf5xlX1DjtAj0Fv4gmdUQR2YfuKxMQT4qHQ9Fnl+0
 Cf/6J1babYnPXPKMiqQqPEXSI9iNbtZMi7kkZWMqW4X5Xs4STjN/PvGz9Gk98EPZc3/f
 +wIg==
X-Gm-Message-State: AOJu0YwzcFLHJ5a2rzfMbUs9P5fHejRgeRSGRqo9FPPzgDUQ3YZOdh4/
 r9d/oxbrV4c/np3s/n+m2LxBR8djnih1+H5n955A3Jm2V3oXxhB/w/4M9W6UJWw5O7D+yqKeEA5
 MAk5Hj81Xng6NmVfZicBVAZygYSRFEWvnKbDWNulRFaCuIINLjCl1IUwwu81rs/o6ZtnWjJ/XIG
 Bfa6E3f5vGGu2Y36qY7ZISuglzmSlDhA==
X-Received: by 2002:a05:6402:1d53:b0:57c:dd3a:f399 with SMTP id
 4fb4d7f45d1cf-5879f3ac31cmr12412872a12.12.1720046682750; 
 Wed, 03 Jul 2024 15:44:42 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IH6BaNgtRNtOqLP1M0YQIRWr9YOpRrDtW1kO6IfIIC+qIuz6K7XGhED+kG1EAzMMhOoJlj4gw==
X-Received: by 2002:a05:6402:1d53:b0:57c:dd3a:f399 with SMTP id
 4fb4d7f45d1cf-5879f3ac31cmr12412849a12.12.1720046681755; 
 Wed, 03 Jul 2024 15:44:41 -0700 (PDT)
Received: from redhat.com ([2a0d:6fc7:441:91a8:a47d:5a9:c02f:92f2])
 by smtp.gmail.com with ESMTPSA id
 4fb4d7f45d1cf-58b4a97b1f3sm2914010a12.18.2024.07.03.15.44.39
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 03 Jul 2024 15:44:41 -0700 (PDT)
Date: Wed, 3 Jul 2024 18:44:38 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Jonah Palmer <jonah.palmer@oracle.com>
Subject: [PULL v3 06/85] virtio-mmio: Handle extra notification data
Message-ID: <54869366be60af2eb52cffaedad73ba1f4247e15.1720046570.git.mst@redhat.com>
References: <cover.1720046570.git.mst@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1720046570.git.mst@redhat.com>
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


