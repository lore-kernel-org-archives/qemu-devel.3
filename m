Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 48EE8C25B78
	for <qemu-devel@archiver.kernel.org>; Tue,  4 Jun 2024 19:10:42 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sEZUP-0005p0-Gr; Tue, 04 Jun 2024 15:06:33 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1sEZUM-0005mv-Dn
 for qemu-devel@nongnu.org; Tue, 04 Jun 2024 15:06:30 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1sEZUK-0000k7-H4
 for qemu-devel@nongnu.org; Tue, 04 Jun 2024 15:06:30 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1717527987;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=uByx4Oz+CQ80E+9HMb1HUHKkD83RXYCyv+000WUVwgE=;
 b=Y22q+/BormzcpVg9XH0zgyGa0/TOOnVcHeDfzFetmBp4SWDHLkO/Q67rmZWoJovEswILFJ
 9eNBleFPSunntRekgUoji/H1fjmz07sKmlHK2GY56kbF10MhcTN8FXAFgxLRy6901wy90g
 B+gef46r8GlbaeKjqBp2O6kurTZQFxQ=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-620-YwX_07PCPXmQagG2w7IFbw-1; Tue, 04 Jun 2024 15:06:26 -0400
X-MC-Unique: YwX_07PCPXmQagG2w7IFbw-1
Received: by mail-wr1-f71.google.com with SMTP id
 ffacd0b85a97d-35e50fe93a5so2483978f8f.3
 for <qemu-devel@nongnu.org>; Tue, 04 Jun 2024 12:06:26 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1717527985; x=1718132785;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=uByx4Oz+CQ80E+9HMb1HUHKkD83RXYCyv+000WUVwgE=;
 b=Hxg3K4AwCMR9LFikj8eJ2LKytYZYJQh89KsFZevGj7dj8pTNBoeVQJjffTbdi/b4CZ
 QDzu+dRCAkfzSCM9T6mGcCYw6XWaFJFgHZBelxSsYPf3YW77lDEfl1qHVdsxzzXqusyT
 Rrhejv1kMdfv6JBYltAWCG74c/p0Wl+J2bvP5lvMtXOkimTYOdxMTYliVvykuHx4AVrA
 MJP9vNIGXE36A/uYOZm/HQW0TRYROPjAnzUCvzr344ib6hlNvlWMzzqvxwOUt6+haVcd
 6TWvwco5WFmAm2nVI8r0cHR/k4vVhhsVrymrtUVxzmCR1RnWi7/SBcZxa3Q6YXTBAisb
 Bc+g==
X-Gm-Message-State: AOJu0YxEGNV/EVuMQzO6y6VLJxt5A+A5XUT5E1eNEY3wAuV9bW4K4K9+
 jurgyoD3zVBTAsDcmmOHzz/g29Pfb2J4iXXjiKVTVBoxVtsUT6EiUq6sFTYBZDubHhcJ3BtHSl0
 VUVGD3x+yxXWgtCAwAsei2wPHQ5AaZBHHyO783LoZsysoatHPJR8IKt0fWJbrSHcnK/vJ1e0j5z
 QLNJB0PANgDrehbrOprU5Grv/O+S+icw==
X-Received: by 2002:a5d:5f4a:0:b0:356:4bb7:b205 with SMTP id
 ffacd0b85a97d-35e84049474mr313008f8f.1.1717527985025; 
 Tue, 04 Jun 2024 12:06:25 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHvt3wYWcLLINEPJx3l8wBE2H84xtjFgTjoE0jyCMI/f45rgHJg/ZLiTHTDi+a3B2cQYB3bDA==
X-Received: by 2002:a5d:5f4a:0:b0:356:4bb7:b205 with SMTP id
 ffacd0b85a97d-35e84049474mr312989f8f.1.1717527984609; 
 Tue, 04 Jun 2024 12:06:24 -0700 (PDT)
Received: from redhat.com ([2a0d:6fc7:552:cf5c:2b13:215c:b9df:f231])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-35dd04cac3esm12321635f8f.39.2024.06.04.12.06.23
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 04 Jun 2024 12:06:24 -0700 (PDT)
Date: Tue, 4 Jun 2024 15:06:21 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Jonah Palmer <jonah.palmer@oracle.com>
Subject: [PULL 07/46] virtio-mmio: Handle extra notification data
Message-ID: <552a973267cb99e09630094b23cf126bd0d57352.1717527933.git.mst@redhat.com>
References: <cover.1717527933.git.mst@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1717527933.git.mst@redhat.com>
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


