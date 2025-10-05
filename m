Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 91E28CAC5B8
	for <qemu-devel@archiver.kernel.org>; Sun,  5 Oct 2025 19:19:11 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v5UDj-0007Sv-Aa; Sun, 05 Oct 2025 15:16:35 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1v5UDX-0007R3-BF
 for qemu-devel@nongnu.org; Sun, 05 Oct 2025 15:16:25 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1v5UDV-0006Ll-7U
 for qemu-devel@nongnu.org; Sun, 05 Oct 2025 15:16:22 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1759691780;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=qrOfnlzVApHW7nCp9cywejc9Pajk0HVvbfCIV3RzkUo=;
 b=QDJXhqTS6gZz1L67EXiFdjw3qbw0aFVTukPVQzJqZAPQMt/W9h9KFdaC5Hj083LtbPHjOd
 7vmg5mO1WDu2tS4KOzNx359YnCawn41X+1YUCUiqOrDKyNhjjn/2rHtxOAm96s4JfNg52a
 IRMOHGZP9BZyxcWBDu0N5H9vubEihJw=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-516-MYf0rnJsME-BQB2R7wspfQ-1; Sun, 05 Oct 2025 15:16:19 -0400
X-MC-Unique: MYf0rnJsME-BQB2R7wspfQ-1
X-Mimecast-MFC-AGG-ID: MYf0rnJsME-BQB2R7wspfQ_1759691778
Received: by mail-wr1-f70.google.com with SMTP id
 ffacd0b85a97d-42421b15185so3097748f8f.1
 for <qemu-devel@nongnu.org>; Sun, 05 Oct 2025 12:16:18 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1759691777; x=1760296577;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=qrOfnlzVApHW7nCp9cywejc9Pajk0HVvbfCIV3RzkUo=;
 b=xTMuoDTG4hNkr10joPkQHgeMhBNTHvi1V1oFX0KW99RfFXYkbXdmfels3gpmUFOuH7
 VqSC4d541xZA9Yc6fjK9QcjFjpPFDLTj1zSq9nO4HoyAye61ZPLIhhDF1FJbhTWif8SI
 jeqvmQdkJ9QaknxnABvKq/E7rdCZ9bcBgTG/nBx4u5Elw26ID5GNwnpX2uYOPrjy344o
 B1MT8MPMYFAZ3mv3OXX6RXaOmwLDGw0X0dyZc0glXVef9HwBn1Zvst2/GczVhr4dIQ+g
 xNb8xOyv3xNNd1kMnSj184hUHDnd035LKHPyDD4lcB5vqD/4igMtoTNJQaSZ/4uw1XNv
 Ay5Q==
X-Gm-Message-State: AOJu0Yx1EWmQ8t5D8oFTlyEhSWddKlDzhiypi4EdhIVXP0c+cTlES6TT
 evy7UcT+qYKerjwm6c35TbfYGekDpt0HziLQYBmcKvewn6UzXWw3zTkQPD2yzQbr2w1fPUzvP3X
 7Pe49IbOti5b++yQXr1qgH0Cg4epQtmCwweRfYa8bDl6/L25oebt4nSXVl2Z4FqnGQR/RxXRCdi
 5tR+QfKbN+cTNKBgz80UTbNgNofa+O+umSZA==
X-Gm-Gg: ASbGnctLK/uebvUxE4w5gN6A54rDrAqZIedf2E9ZcGKGxPhsBdl5x6Eeqe/jwqQ5cX/
 S2zranWXkjZHgTqSCQo6EyS7mZ0bbDpdpPOQ4eA6OyyKPan2iTfnR/s2eV/miC7+7sRy2wQ1Imv
 7vEkljQICY16/GRyKMdU6bbKSRqYQiuo3Zipoej3aV/61zFUz/iTGDYl8UmAMOqx0JoyJkJNgu4
 H78NaA1B5v+E8hBwbseYmlSR5A1DC7dzab+lmD7SEIk1h0MGBxs+tYtF9mqA88nrT267yELRlVl
 dypwQ70J9d7q83FnY1Y76983J4OyRZOG8Qh9jUA=
X-Received: by 2002:a05:6000:22c2:b0:3e6:f91e:fa72 with SMTP id
 ffacd0b85a97d-4256713edb3mr5851564f8f.7.1759691777245; 
 Sun, 05 Oct 2025 12:16:17 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFs468vAjdBo/BoHJhvgXOcGckaMGaLlnNU12LRDFYAvwH/uzw/ZaWKOiAihqyswnFFqwHdPg==
X-Received: by 2002:a05:6000:22c2:b0:3e6:f91e:fa72 with SMTP id
 ffacd0b85a97d-4256713edb3mr5851546f8f.7.1759691776740; 
 Sun, 05 Oct 2025 12:16:16 -0700 (PDT)
Received: from redhat.com ([2a0d:6fc0:1518:6900:b69a:73e1:9698:9cd3])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-4255d8a6c54sm17766671f8f.11.2025.10.05.12.16.15
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 05 Oct 2025 12:16:16 -0700 (PDT)
Date: Sun, 5 Oct 2025 15:16:14 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>, Paolo Abeni <pabeni@redhat.com>,
 Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>,
 Jason Wang <jasowang@redhat.com>, Stefano Garzarella <sgarzare@redhat.com>,
 Lei Yang <leiyang@redhat.com>
Subject: [PULL 06/75] virtio: add support for negotiating extended features
Message-ID: <64a6a336f42bc6305ab7589fd874cb4a3d403bd0.1759691708.git.mst@redhat.com>
References: <cover.1759691708.git.mst@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1759691708.git.mst@redhat.com>
X-Mailer: git-send-email 2.27.0.106.g8ac3dc51b1
X-Mutt-Fcc: =sent
Received-SPF: pass client-ip=170.10.133.124; envelope-from=mst@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.43,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

From: Paolo Abeni <pabeni@redhat.com>

The virtio specifications allows for a device features space up
to 128 bits and more. Soon we are going to use some of the 'extended'
bits features for the virtio net driver.

Add support to allow extended features negotiation on a per
devices basis. Devices willing to negotiated extended features
need to implemented a new pair of features getter/setter, the
core will conditionally use them instead of the basic one.

Note that 'bad_features' don't need to be extended, as they are
bound to the 64 bits limit.

Reviewed-by: Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>
Acked-by: Jason Wang <jasowang@redhat.com>
Acked-by: Stefano Garzarella <sgarzare@redhat.com>
Signed-off-by: Paolo Abeni <pabeni@redhat.com>
Tested-by: Lei Yang <leiyang@redhat.com>
Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
Message-ID: <9bb29d70adc3f2b8c7756d4e3cd076cffee87826.1758549625.git.pabeni@redhat.com>
Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
---
 include/hw/virtio/virtio.h |  4 ++++
 hw/virtio/virtio-bus.c     | 11 ++++++++---
 hw/virtio/virtio.c         | 14 +++++++++++---
 3 files changed, 23 insertions(+), 6 deletions(-)

diff --git a/include/hw/virtio/virtio.h b/include/hw/virtio/virtio.h
index 39e4059a66..2aeb021fb3 100644
--- a/include/hw/virtio/virtio.h
+++ b/include/hw/virtio/virtio.h
@@ -178,6 +178,9 @@ struct VirtioDeviceClass {
     /* This is what a VirtioDevice must implement */
     DeviceRealize realize;
     DeviceUnrealize unrealize;
+    void (*get_features_ex)(VirtIODevice *vdev, uint64_t *requested_features,
+                            Error **errp);
+    void (*set_features_ex)(VirtIODevice *vdev, const uint64_t *val);
     uint64_t (*get_features)(VirtIODevice *vdev,
                              uint64_t requested_features,
                              Error **errp);
@@ -373,6 +376,7 @@ void virtio_queue_reset(VirtIODevice *vdev, uint32_t queue_index);
 void virtio_queue_enable(VirtIODevice *vdev, uint32_t queue_index);
 void virtio_update_irq(VirtIODevice *vdev);
 int virtio_set_features(VirtIODevice *vdev, uint64_t val);
+int virtio_set_features_ex(VirtIODevice *vdev, const uint64_t *val);
 
 /* Base devices.  */
 typedef struct VirtIOBlkConf VirtIOBlkConf;
diff --git a/hw/virtio/virtio-bus.c b/hw/virtio/virtio-bus.c
index 11adfbf3ab..cef944e015 100644
--- a/hw/virtio/virtio-bus.c
+++ b/hw/virtio/virtio-bus.c
@@ -62,9 +62,14 @@ void virtio_bus_device_plugged(VirtIODevice *vdev, Error **errp)
     }
 
     /* Get the features of the plugged device. */
-    assert(vdc->get_features != NULL);
-    vdev->host_features = vdc->get_features(vdev, vdev->host_features,
-                                            &local_err);
+    if (vdc->get_features_ex) {
+        vdc->get_features_ex(vdev, vdev->host_features_ex, &local_err);
+    } else {
+        assert(vdc->get_features != NULL);
+        virtio_features_from_u64(vdev->host_features_ex,
+                                 vdc->get_features(vdev, vdev->host_features,
+                                                   &local_err));
+    }
     if (local_err) {
         error_propagate(errp, local_err);
         return;
diff --git a/hw/virtio/virtio.c b/hw/virtio/virtio.c
index bf53c211e5..34f977a3c9 100644
--- a/hw/virtio/virtio.c
+++ b/hw/virtio/virtio.c
@@ -3103,7 +3103,9 @@ static int virtio_set_features_nocheck(VirtIODevice *vdev, const uint64_t *val)
     bad = virtio_features_andnot(tmp, val, vdev->host_features_ex);
     virtio_features_and(tmp, val, vdev->host_features_ex);
 
-    if (k->set_features) {
+    if (k->set_features_ex) {
+        k->set_features_ex(vdev, val);
+    } else if (k->set_features) {
         bad = bad || virtio_features_use_ex(tmp);
         k->set_features(vdev, tmp[0]);
     }
@@ -3149,6 +3151,13 @@ virtio_set_features_nocheck_maybe_co(VirtIODevice *vdev,
 int virtio_set_features(VirtIODevice *vdev, uint64_t val)
 {
     uint64_t features[VIRTIO_FEATURES_NU64S];
+
+    virtio_features_from_u64(features, val);
+    return virtio_set_features_ex(vdev, features);
+}
+
+int virtio_set_features_ex(VirtIODevice *vdev, const uint64_t *features)
+{
     int ret;
     /*
      * The driver must not attempt to set features after feature negotiation
@@ -3158,13 +3167,12 @@ int virtio_set_features(VirtIODevice *vdev, uint64_t val)
         return -EINVAL;
     }
 
-    if (val & (1ull << VIRTIO_F_BAD_FEATURE)) {
+    if (features[0] & (1ull << VIRTIO_F_BAD_FEATURE)) {
         qemu_log_mask(LOG_GUEST_ERROR,
                       "%s: guest driver for %s has enabled UNUSED(30) feature bit!\n",
                       __func__, vdev->name);
     }
 
-    virtio_features_from_u64(features, val);
     ret = virtio_set_features_nocheck(vdev, features);
     if (virtio_vdev_has_feature(vdev, VIRTIO_RING_F_EVENT_IDX)) {
         /* VIRTIO_RING_F_EVENT_IDX changes the size of the caches.  */
-- 
MST


