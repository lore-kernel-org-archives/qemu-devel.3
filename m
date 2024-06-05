Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CBD2CC27C53
	for <qemu-devel@archiver.kernel.org>; Wed,  5 Jun 2024 23:39:24 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sF09u-0002sF-Qo; Wed, 05 Jun 2024 19:35:10 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1sF09s-0002rU-Se
 for qemu-devel@nongnu.org; Wed, 05 Jun 2024 19:35:08 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1sF09r-00051w-7D
 for qemu-devel@nongnu.org; Wed, 05 Jun 2024 19:35:08 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1717630506;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=uByx4Oz+CQ80E+9HMb1HUHKkD83RXYCyv+000WUVwgE=;
 b=gEjj1xLPugT4pw9YrfmCDe+sdQuRPDvf+zYxiEU3XT2iFqNAMbTmuypBTfhbw0fwBGk9re
 ElaaCAxJuSpocLE/9sQJNdvLrw9XsT3AOm7MZJDHqAvHrVbTar6qK21hCSo9XeT706CGJk
 3WZOUg2tQMNq8MO3n4O3xKr2U9XEt5c=
Received: from mail-ej1-f70.google.com (mail-ej1-f70.google.com
 [209.85.218.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-664-v-6oZm69ObWuK11cPWh0uA-1; Wed, 05 Jun 2024 19:35:05 -0400
X-MC-Unique: v-6oZm69ObWuK11cPWh0uA-1
Received: by mail-ej1-f70.google.com with SMTP id
 a640c23a62f3a-a6c718150f8so44955366b.2
 for <qemu-devel@nongnu.org>; Wed, 05 Jun 2024 16:35:04 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1717630503; x=1718235303;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=uByx4Oz+CQ80E+9HMb1HUHKkD83RXYCyv+000WUVwgE=;
 b=rPTmRoG6AtBNuvkbmk5LQFomsCvOB7vuOB2HusZuXqd/AGYdrohO1iCh74ZwnyzIvK
 M0km+wrf15JFRHuHryIS4ZhLYeyLIEJmWDcNpbXTuo22xWCjkj61PdleAwwGV1HP3Jou
 c3RDM9Bp0wIV4wt4usuLmMAqlaYV/QBmBy7XO3kKro3hms4++vMCKvu5wbGFtRTdbDPC
 Y992iojGko4uMF4OTkKzwc7laNkRgZcXNduxDbjRa7YJTPam9Fm7CXH7krtUBeKJoWqD
 SBHZCMulZxMJELu2DA53N5+dZzfByDLG5b4O7/Rc3vYrJymnpGVvS4iDnMmRiW+xvC7y
 Macw==
X-Gm-Message-State: AOJu0YyC7/wywPsIavqxa5NjAixzftZFDqE1FFAS0XzDYYheCeUkwOK2
 ntlbjb1eg0s/ctXAzj6zd7C1qciNtQbjLLmRcfHcVWe/Xpbzm2Avdn0X52Ior7tVsIfl6h9pRRI
 PnEg9jaTtVboVAtvQBSpoREtkNZoaswNpIT5g+qPbmr3Kr/kw6/SjM9h5i70bHHENRGH/EWkg3u
 9bewxLtYJKGhd8EwrrPsN5W99Rpr4ITg==
X-Received: by 2002:a17:907:bb84:b0:a59:c23d:85ce with SMTP id
 a640c23a62f3a-a69a000e2bcmr301116766b.51.1717630503535; 
 Wed, 05 Jun 2024 16:35:03 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IERTiJxar1crypFhv8A4eLSChTdHPg/PnttrCEUjwAT9bmo+mlH+Z2RDHVHXTRg/f1S1knd4w==
X-Received: by 2002:a17:907:bb84:b0:a59:c23d:85ce with SMTP id
 a640c23a62f3a-a69a000e2bcmr301115666b.51.1717630503029; 
 Wed, 05 Jun 2024 16:35:03 -0700 (PDT)
Received: from redhat.com ([2.55.56.67]) by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-a6c805cd97csm6950466b.67.2024.06.05.16.35.01
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 05 Jun 2024 16:35:02 -0700 (PDT)
Date: Wed, 5 Jun 2024 19:35:00 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Jonah Palmer <jonah.palmer@oracle.com>
Subject: [PULL v3 06/41] virtio-mmio: Handle extra notification data
Message-ID: <bed1d72d421f2d1acf6bc7d08603ca3c7bc6571a.1717630437.git.mst@redhat.com>
References: <cover.1717630437.git.mst@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1717630437.git.mst@redhat.com>
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


