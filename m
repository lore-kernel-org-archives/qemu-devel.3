Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8070BC2BD09
	for <qemu-devel@archiver.kernel.org>; Wed,  3 Jul 2024 22:45:20 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sP8iS-00022l-OP; Wed, 03 Jul 2024 18:44:44 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1sP8iQ-00022B-Ne
 for qemu-devel@nongnu.org; Wed, 03 Jul 2024 18:44:42 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1sP8iP-0000tN-80
 for qemu-devel@nongnu.org; Wed, 03 Jul 2024 18:44:42 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1720046680;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=czI6QAqPz2gxBOi54M6w2CiDVJgkcwfGVW3OGis4Be4=;
 b=UUSTtBZ0iskQvP0Tlxk3vJ83C2bnyLLAF0t02TCIeGZn3KbZQEgtc5N2ceDNJsGXlMmaW4
 DP2uBs9SMHAggMm4H6BSh8i+Gc3dP+qTs0M0CR+Zz87L1EF7K7Rgqf2n/nhWiooMSee5fD
 5EN9LSx+B2059mTIm33qa/c7hbPWNe8=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-230-M6yfTxGHPByf42RpDEhRYQ-1; Wed, 03 Jul 2024 18:44:39 -0400
X-MC-Unique: M6yfTxGHPByf42RpDEhRYQ-1
Received: by mail-wm1-f70.google.com with SMTP id
 5b1f17b1804b1-4256718144dso23595e9.1
 for <qemu-devel@nongnu.org>; Wed, 03 Jul 2024 15:44:39 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1720046678; x=1720651478;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=czI6QAqPz2gxBOi54M6w2CiDVJgkcwfGVW3OGis4Be4=;
 b=KdpgsWVQTwVB2jPgX5+gSSFwko9WuDQ7Haf85GJoGzpmiwiPyAvE34Mo2OUKVsgsi/
 a6kibXciNc4XKETZoYjtkBpdqr4rc+UBbzbImYLqkd5Jub3TCN0wXyfqSt05vbYHG/WA
 XEULwdiK5EGlJ66Ln16FfedAvg3/1utEKzgYEV4cdfrZRWFfWliXIY+tLLuH/TcE1nmz
 3DpriYZRmfMIty3aC5TLmxZFx4Q/Z32R1WCrfQnaP6ob/Ll0SUL0twMC3JrvlPK1ysLU
 GI2RixbdtOnNMUmJOSVGSks0jCJbeXcd2x3pmP71X/W3u866zoWPh7V1BCOQV9LUMzsQ
 s3eA==
X-Gm-Message-State: AOJu0YzzZ6O9kNyiw8DcbDoQsTN+TB3M9+vMwsZprkW08K3oQeRcROhD
 A8r7V8WZQfASIJ1SD7FCBFhg9QlWZPeuy05sQ/xSpfV2lYj9kYT0zsMTw00s38IefFhq/i0y6x/
 pQvnj2mg0oNbQQwTjkt4vGhDhOcVyJsfFUxsdgCLGJzpoOPGqJu0WU6glKq3/CXHsNvBSGvXVbe
 8Ppp+tWwsFjNq99sukuyCGgZvHzuvDdQ==
X-Received: by 2002:adf:e552:0:b0:367:92c7:3ac0 with SMTP id
 ffacd0b85a97d-3679dd2761dmr9451f8f.22.1720046678271; 
 Wed, 03 Jul 2024 15:44:38 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGB0Gz7EUxGj1I1NI838U7/bX3Gq2PsJCDUswCTVJ6CyTi4vb76KelzWvyEng5YTwwgwrwYOg==
X-Received: by 2002:adf:e552:0:b0:367:92c7:3ac0 with SMTP id
 ffacd0b85a97d-3679dd2761dmr9414f8f.22.1720046677312; 
 Wed, 03 Jul 2024 15:44:37 -0700 (PDT)
Received: from redhat.com ([2a0d:6fc7:441:91a8:a47d:5a9:c02f:92f2])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-a72aafb3c2esm548349866b.91.2024.07.03.15.44.35
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 03 Jul 2024 15:44:36 -0700 (PDT)
Date: Wed, 3 Jul 2024 18:44:33 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Jonah Palmer <jonah.palmer@oracle.com>
Subject: [PULL v3 05/85] virtio: Prevent creation of device using
 notification-data with ioeventfd
Message-ID: <78378f450a723eed34156259ca2861a0c5ca77cf.1720046570.git.mst@redhat.com>
References: <cover.1720046570.git.mst@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1720046570.git.mst@redhat.com>
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


