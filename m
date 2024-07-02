Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B9555C30658
	for <qemu-devel@archiver.kernel.org>; Tue,  2 Jul 2024 14:08:26 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sOeAG-0001zR-9w; Tue, 02 Jul 2024 10:07:24 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1sOeAD-0001yX-HM
 for qemu-devel@nongnu.org; Tue, 02 Jul 2024 10:07:21 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1sOeAB-0007s7-6L
 for qemu-devel@nongnu.org; Tue, 02 Jul 2024 10:07:20 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1719929238;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=czI6QAqPz2gxBOi54M6w2CiDVJgkcwfGVW3OGis4Be4=;
 b=FY+5dSWwVwcQiRAW6pbH2Pse05TxzsEBJQ22572uAuOzTY69hcbqHUp1a8eKfjAnX8E/dX
 g6sdmm5Suzltwg2WYqu3n0ziQdMS5xTgBloUrtNDW+2ktpeU5xd1i0WEEUewdC8IfNSZ1r
 xPh1+RyqaxdRHRXDVuCJsUmU27IuHX0=
Received: from mail-lf1-f70.google.com (mail-lf1-f70.google.com
 [209.85.167.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-57-6Xs-EZmUNT2nXnWLPvb3UA-1; Tue, 02 Jul 2024 10:07:17 -0400
X-MC-Unique: 6Xs-EZmUNT2nXnWLPvb3UA-1
Received: by mail-lf1-f70.google.com with SMTP id
 2adb3069b0e04-52cdd05fec8so4374138e87.0
 for <qemu-devel@nongnu.org>; Tue, 02 Jul 2024 07:07:16 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1719929235; x=1720534035;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=czI6QAqPz2gxBOi54M6w2CiDVJgkcwfGVW3OGis4Be4=;
 b=MD0jSQ9QP81mNvcJeJ3z12wGHQv+reVxMAr+M9dWJNdWhFAeY7wsNwgd94N2m4yiOc
 EcLfSAj6DJpdJwACW2uaLEr9csg+ZE/qPM7Gtpq+hslfjc2L0mMX7+EG/syiKtlwvnTX
 ydey+g1b+xQRTr0cn72op2XyCBxRGnREcbC7o32WajImt5MV0ecNMDGsVvsvcYlTXey0
 5IQvB86xFEiXlYlDv1UVMB2Z+eI4oGmB3yI33aKR+3GX1X+va+CRXYMbFMsQuTd+jjL2
 UL6IczOUyJw1eZ/F2snYAzBpqr47/yahf+CDXECNQUytizHPh7Hy/m5dB3GnqLCrB/kl
 kDXw==
X-Gm-Message-State: AOJu0YzhrLUb2lfN/Xae+JgxH852iVKVhMMPZMNLh2/NP35Yrq+hgbSN
 meNtd+wMnJT/rDSmj/gN7gBoYpVeLHGDb52IQQohliB19TWWR/qxupAHLmukIsV0e2yK8IYZY5K
 XXA/nfXiSnQLCkC3rETMGw1nwMFRhQqCqh/lD8YdA6Ki7jor0X6IJpP+nxAZKbeK3mbztZ4X8y9
 qLjlO+JB12E3Dphym+mQMNLkQNoktdLA==
X-Received: by 2002:a05:6512:3da3:b0:52e:713e:697c with SMTP id
 2adb3069b0e04-52e8267b8d0mr7346553e87.25.1719929234741; 
 Tue, 02 Jul 2024 07:07:14 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHIbEIOMOFei5IYQ1lsrlJQKcfWJJgZdgqCYLdwihBAYmZzxlPo+Vqxul3hYAoPQQzezBquJw==
X-Received: by 2002:a05:6512:3da3:b0:52e:713e:697c with SMTP id
 2adb3069b0e04-52e8267b8d0mr7346516e87.25.1719929234065; 
 Tue, 02 Jul 2024 07:07:14 -0700 (PDT)
Received: from redhat.com ([2a02:14f:1f5:eadd:8c31:db01:9d01:7604])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3675a1030dfsm13279767f8f.100.2024.07.02.07.07.12
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 02 Jul 2024 07:07:13 -0700 (PDT)
Date: Tue, 2 Jul 2024 10:07:11 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Jonah Palmer <jonah.palmer@oracle.com>
Subject: [PULL 05/91] virtio: Prevent creation of device using
 notification-data with ioeventfd
Message-ID: <78378f450a723eed34156259ca2861a0c5ca77cf.1719929191.git.mst@redhat.com>
References: <cover.1719929191.git.mst@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1719929191.git.mst@redhat.com>
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


