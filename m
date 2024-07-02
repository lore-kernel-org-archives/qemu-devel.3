Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 31754C30658
	for <qemu-devel@archiver.kernel.org>; Tue,  2 Jul 2024 20:21:56 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sOjv5-0005vw-ML; Tue, 02 Jul 2024 16:16:08 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1sOjuZ-0005R5-Sh
 for qemu-devel@nongnu.org; Tue, 02 Jul 2024 16:15:40 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1sOjuV-0007ql-1b
 for qemu-devel@nongnu.org; Tue, 02 Jul 2024 16:15:35 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1719951330;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=czI6QAqPz2gxBOi54M6w2CiDVJgkcwfGVW3OGis4Be4=;
 b=fDapGwo/nvk2tgxNuIZW9WgCgzNJPPO7OMOQoviQHOeyHySRMa9uji9Y0710uVgTkt0noY
 GItouUKMqe9JMN5rWT6wofwyFVBwgIFPUkkoDVtOKfT+08+kAFUcTv6i48aAKrFB++z4aN
 WVuG+pAhhMjLDkE6lvJ3vrGybA9yQJU=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-665-m5ZzvgMuO6WS5qNnqSOtow-1; Tue, 02 Jul 2024 16:15:29 -0400
X-MC-Unique: m5ZzvgMuO6WS5qNnqSOtow-1
Received: by mail-wm1-f71.google.com with SMTP id
 5b1f17b1804b1-4257a75193aso21948485e9.1
 for <qemu-devel@nongnu.org>; Tue, 02 Jul 2024 13:15:29 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1719951327; x=1720556127;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=czI6QAqPz2gxBOi54M6w2CiDVJgkcwfGVW3OGis4Be4=;
 b=ZpeY2CjuRgAjWXrusazXgb/i14J0LXHl0ClM2n1PBZBQvRfUvU5N63CrG/Uytig7Jh
 T+pgb2jp4dll/+xPQ3j0Y9CR6c5VqySmi4swTOlEaA5VBxWwXJxCkxbrBxT/UT2D9P0M
 6Z3TZu0rmgbsU8nM1WNfm74udClMO/OOuZjWUZaea8zZBfaP1RUZgrRbpVJQ4iWuwkiE
 4ANP7lAFf8glkuqux8Sb9s7j0rT3sKcMVke15lNLJUqphUOvv0OT4G1NoZMn0xX80rCa
 46jGHb0TRB5x7i/O3Jd7tyi2QY7+ZDlX4PhUMz565cyAL3ocfN9RTOdCITQejzYd4u8C
 GXgg==
X-Gm-Message-State: AOJu0Yz7KZ8Vk+UWNzOKjHv3g+eZLkqCtKEi7ry/1oi2WVQeeIBhZ66Z
 tGPH6vqJQOGwQ6RU1rBBprz6K+xrBYKp6xurMepSIzuPc19z4vY4v+SedvKw7SQ/NAacdH7m/D0
 tVddJY+XlAWWeE2ZDjpOczpHwyLvp6FxjEGnwM94xZH0Lobk4W14fGDwIw87d4rjvIlaTTevfvT
 8CoWViu7iQqtAq1TRsYcK/gFpP+WzfEw==
X-Received: by 2002:a05:600c:5108:b0:425:7e44:d2f0 with SMTP id
 5b1f17b1804b1-4257e44d51dmr48069015e9.4.1719951327301; 
 Tue, 02 Jul 2024 13:15:27 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFNQUtEetDBvfLfY5xvXb+C/h/Rdo1cdE2H8s6zTKCxumeGGyhsaKdpCZxvz8q97G3qEdtB2Q==
X-Received: by 2002:a05:600c:5108:b0:425:7e44:d2f0 with SMTP id
 5b1f17b1804b1-4257e44d51dmr48068835e9.4.1719951326773; 
 Tue, 02 Jul 2024 13:15:26 -0700 (PDT)
Received: from redhat.com ([2a02:14f:1f5:eadd:8c31:db01:9d01:7604])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4256af3cf90sm208753135e9.5.2024.07.02.13.15.25
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 02 Jul 2024 13:15:26 -0700 (PDT)
Date: Tue, 2 Jul 2024 16:15:22 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Jonah Palmer <jonah.palmer@oracle.com>
Subject: [PULL v2 05/88] virtio: Prevent creation of device using
 notification-data with ioeventfd
Message-ID: <78378f450a723eed34156259ca2861a0c5ca77cf.1719951168.git.mst@redhat.com>
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


