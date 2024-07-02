Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8C132C30658
	for <qemu-devel@archiver.kernel.org>; Tue,  2 Jul 2024 20:19:07 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sOjtD-0001Vy-W9; Tue, 02 Jul 2024 16:14:12 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1sOjtB-0001VE-W0
 for qemu-devel@nongnu.org; Tue, 02 Jul 2024 16:14:10 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1sOjtA-0007Yz-FM
 for qemu-devel@nongnu.org; Tue, 02 Jul 2024 16:14:09 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1719951247;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=uByx4Oz+CQ80E+9HMb1HUHKkD83RXYCyv+000WUVwgE=;
 b=AlptASjlyoHuYFztJ56q7wssmD1Vnp5YL03WTbSve9UupoXwQWJqXhAmD6V09CltHBi2fk
 UbIWKRuOjIxRwBkK+3/WHpPb7hsFQuuUkXmBPyaZ9ogneGnTW2iStkaeQM3DtdJZKHK3xo
 fdx5NkgztxLaFRg9vtXWImuhmviBPTw=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-2-4EdYDHWTPqevVZHe4tz8bw-1; Tue, 02 Jul 2024 16:14:06 -0400
X-MC-Unique: 4EdYDHWTPqevVZHe4tz8bw-1
Received: by mail-wm1-f71.google.com with SMTP id
 5b1f17b1804b1-4257db9d71fso19086395e9.2
 for <qemu-devel@nongnu.org>; Tue, 02 Jul 2024 13:14:06 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1719951245; x=1720556045;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=uByx4Oz+CQ80E+9HMb1HUHKkD83RXYCyv+000WUVwgE=;
 b=I0Batvxl4ZLkLzE1+eNOge9swTIQO1ISDnm72qu7bDS4N0vkQdGuI50/AKfT0MdGlg
 fyBUKmfu5t7DTCukcopK0zVUT71PMX383C90IYn1CUuss9JPRVquS4rR15nA1rZ2JOYj
 3XjTTxjWxKZjWGkazLqvwJ3lzf2rV3tuqbwAiOSgWjEjcnuyRyilET8uJw9pmKBtnpB6
 Gvfmy3Ah+CrtOVLIvxyX/1X6varPBP5fktDj1FPUGo1ZPYj9zVbB/SV6KhaP2iCru1dX
 mm6JKdE1Ot9pRTUcAxXVfXxBh98V1ux/vigInITnnDM7Q0O0kwz6ShWAbG9rJsxg2zNS
 tK8A==
X-Gm-Message-State: AOJu0Yxp9WyJ4N7KMqeA7bHBb+3GGXgN0bJ5FUaUMUjWc4p+MFzggiU+
 3mmzS5rePh46udKwTTRlk3n8YDd2wgZG2Oq46jiaOZ4jAfjEFQP7UKmmnhshIFPJMNMAj1thi/i
 uhh2Lib4tpxQesuLnzTvWIwNSFxMc7Vn4ADABbcItq4trC0rXp21fk/LpT2RK60lSD2eXNoZgLT
 99JH85bMVoAg94nKa0q/sgWcu+X0dQng==
X-Received: by 2002:a05:600c:1585:b0:425:7b77:e943 with SMTP id
 5b1f17b1804b1-4257b77ea48mr60665825e9.14.1719951244899; 
 Tue, 02 Jul 2024 13:14:04 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFfM70DX5kf2eTXsf+4cnmZtOBBDUwk72e6Sjs/XlocyKXLowO2MjypsHZ2q0Z4NtpBA4ejmw==
X-Received: by 2002:a05:600c:1585:b0:425:7b77:e943 with SMTP id
 5b1f17b1804b1-4257b77ea48mr60665535e9.14.1719951244265; 
 Tue, 02 Jul 2024 13:14:04 -0700 (PDT)
Received: from redhat.com ([2a02:14f:1f5:eadd:8c31:db01:9d01:7604])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4256af376f5sm211281955e9.6.2024.07.02.13.14.01
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 02 Jul 2024 13:14:03 -0700 (PDT)
Date: Tue, 2 Jul 2024 16:13:59 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Jonah Palmer <jonah.palmer@oracle.com>
Subject: [PULL v2 06/91] virtio-mmio: Handle extra notification data
Message-ID: <54869366be60af2eb52cffaedad73ba1f4247e15.1719951026.git.mst@redhat.com>
References: <cover.1719951026.git.mst@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1719951026.git.mst@redhat.com>
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


