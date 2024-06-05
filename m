Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 91219C25B76
	for <qemu-devel@archiver.kernel.org>; Wed,  5 Jun 2024 23:37:18 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sF09r-0002rC-N4; Wed, 05 Jun 2024 19:35:07 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1sF09p-0002r3-Ud
 for qemu-devel@nongnu.org; Wed, 05 Jun 2024 19:35:06 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1sF09o-0004w0-BH
 for qemu-devel@nongnu.org; Wed, 05 Jun 2024 19:35:05 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1717630503;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=czI6QAqPz2gxBOi54M6w2CiDVJgkcwfGVW3OGis4Be4=;
 b=Q3a4WbZGliQd/g6ukAcJfOlvkVXzNIRUUoIMAFRUWDIu+qPx3xB0aCL8tRGCbMZqalFlNo
 FPf3njUueSuZEDrK9A/2rvri5Tm3rlS/JVh6AlF8+AE0KmvTHweBb4zQgwN7l9YFC0CI0r
 fZ8R3nRwDN/etlADE/whyDtHt8erTPE=
Received: from mail-lf1-f71.google.com (mail-lf1-f71.google.com
 [209.85.167.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-463-pscAqLgpPwWIpG81SfnxVA-1; Wed, 05 Jun 2024 19:35:02 -0400
X-MC-Unique: pscAqLgpPwWIpG81SfnxVA-1
Received: by mail-lf1-f71.google.com with SMTP id
 2adb3069b0e04-52b91217fcfso211831e87.3
 for <qemu-devel@nongnu.org>; Wed, 05 Jun 2024 16:35:01 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1717630500; x=1718235300;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=czI6QAqPz2gxBOi54M6w2CiDVJgkcwfGVW3OGis4Be4=;
 b=ErruqIlt7L2nFrsLdJEFGknCBFZwA50hvgB+U7Ys3dCdtExPA/lZ8wvJym5ARcjRYy
 sxBnDm49QqKdlfSkqmabnzIjni+Jw8wh5spCQeslCtH3J04c68z2EBxUqcmcnI2l6wPE
 ZG2yIDpO8wgrjPbrag/2qUw4JUZwtVGSXmdq3mY6zlj/h/R8kqVe8JgQ0HH3P2WUIbvX
 Fp8BgkcYfOhGcEENTeo/SeYGkMBw7tjte5WZwCtgg/tVsYmOGwWkcnYK7yvVQf23Cq6v
 yoKH7U7YwBP6wK0nGl/3OdKPUKYjm9IELEdZL9BveRj5iBwxOfRnPCN6P0yEKlH18dCK
 ZF/g==
X-Gm-Message-State: AOJu0YxyPhH+1cy/egj9onWU5NlMev+FsXqA++Wm9vjcCh1pNNmhYUn5
 wCG7AXmi+QHVwiRV+KLKBDpRUt+1+pHT4ygtiA0Gy3Yg8gjZW1cRiN7YPxpaG97JkxGpmOFiJxX
 oBRxrsOZEVmRHvWy1cg0mL8RXu7nS5Fe9DPGl32dIcl1/gwqUngF9VZ+hLY6zHb9u8ghwJ57U/s
 Gk90eNzpswGRs+N5w/3Fe/zwzwX1wvDQ==
X-Received: by 2002:a05:6512:701:b0:52b:851e:256 with SMTP id
 2adb3069b0e04-52bab4c8ea5mr2121686e87.2.1717630500006; 
 Wed, 05 Jun 2024 16:35:00 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IE4WLXi0bBIL3OT03bJ4+nfahaM13sRo7yMo9FqEV9GAEsx9c5tKE3MUq3g9cAdqUttkIihFw==
X-Received: by 2002:a05:6512:701:b0:52b:851e:256 with SMTP id
 2adb3069b0e04-52bab4c8ea5mr2121679e87.2.1717630499532; 
 Wed, 05 Jun 2024 16:34:59 -0700 (PDT)
Received: from redhat.com ([2.55.56.67]) by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-a6c805d0af8sm6914366b.87.2024.06.05.16.34.57
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 05 Jun 2024 16:34:58 -0700 (PDT)
Date: Wed, 5 Jun 2024 19:34:56 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Jonah Palmer <jonah.palmer@oracle.com>
Subject: [PULL v3 05/41] virtio: Prevent creation of device using
 notification-data with ioeventfd
Message-ID: <8fdfaf02767748eadab7ad8ab41da78f261824f2.1717630437.git.mst@redhat.com>
References: <cover.1717630437.git.mst@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1717630437.git.mst@redhat.com>
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

Prevent the realization of a virtio device that attempts to use the
VIRTIO_F_NOTIFICATION_DATA transport feature without disabling
ioeventfd.

Due to ioeventfd not being able to carry the extra data associated with
this feature, having both enabled is a functional mismatch and therefore
Qemu should not continue the device's realization process.

Although the device does not yet know if the feature will be
successfully negotiated, many devices using this feature wont actually
work without this extra data and would fail FEATURES_OK anyway.

If ioeventfd is able to work with the extra notification data in the
future, this compatibility check can be removed.

Signed-off-by: Jonah Palmer <jonah.palmer@oracle.com>
Message-Id: <20240315165557.26942-3-jonah.palmer@oracle.com>
Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
---
 hw/virtio/virtio.c | 22 ++++++++++++++++++++++
 1 file changed, 22 insertions(+)

diff --git a/hw/virtio/virtio.c b/hw/virtio/virtio.c
index f7c99e3a96..28cd406e16 100644
--- a/hw/virtio/virtio.c
+++ b/hw/virtio/virtio.c
@@ -2980,6 +2980,20 @@ int virtio_set_features(VirtIODevice *vdev, uint64_t val)
     return ret;
 }
 
+static void virtio_device_check_notification_compatibility(VirtIODevice *vdev,
+                                                           Error **errp)
+{
+    VirtioBusState *bus = VIRTIO_BUS(qdev_get_parent_bus(DEVICE(vdev)));
+    VirtioBusClass *k = VIRTIO_BUS_GET_CLASS(bus);
+    DeviceState *proxy = DEVICE(BUS(bus)->parent);
+
+    if (virtio_host_has_feature(vdev, VIRTIO_F_NOTIFICATION_DATA) &&
+        k->ioeventfd_enabled(proxy)) {
+        error_setg(errp,
+                   "notification_data=on without ioeventfd=off is not supported");
+    }
+}
+
 size_t virtio_get_config_size(const VirtIOConfigSizeParams *params,
                               uint64_t host_features)
 {
@@ -3740,6 +3754,14 @@ static void virtio_device_realize(DeviceState *dev, Error **errp)
         }
     }
 
+    /* Devices should not use both ioeventfd and notification data feature */
+    virtio_device_check_notification_compatibility(vdev, &err);
+    if (err != NULL) {
+        error_propagate(errp, err);
+        vdc->unrealize(dev);
+        return;
+    }
+
     virtio_bus_device_plugged(vdev, &err);
     if (err != NULL) {
         error_propagate(errp, err);
-- 
MST


