Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AED57EE49B8
	for <qemu-devel@archiver.kernel.org>; Wed, 11 Sep 2024 14:27:36 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1soOI2-0004cx-65; Wed, 11 Sep 2024 10:25:50 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1soOHL-00048E-DX
 for qemu-devel@nongnu.org; Wed, 11 Sep 2024 10:25:07 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1soOGR-0007zt-Gt
 for qemu-devel@nongnu.org; Wed, 11 Sep 2024 10:25:06 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1726064646;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=XMtC5Kei8mxn7YHbK2SX3QVuhzxpI5xgFrkix64PgUI=;
 b=MzQrDSi3XPuvrpwYaQofeaJyfLPEPz0W+8yLnjZkJU1pw13+jQVuP54O2EqVXLVTy5sYQh
 anRm30au7E2Td1KU/3UAwFE49hXsZZB8xxHtrI6sBD8g5kphauhXg6IpSPWGV7c5shfPFY
 WfV+K8rUL/w5tAthHx2E8Viv/j6+Uss=
Received: from mail-lf1-f70.google.com (mail-lf1-f70.google.com
 [209.85.167.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-81-au1uDgSkPOGTLP08l9c3OA-1; Wed, 11 Sep 2024 09:52:11 -0400
X-MC-Unique: au1uDgSkPOGTLP08l9c3OA-1
Received: by mail-lf1-f70.google.com with SMTP id
 2adb3069b0e04-53661a13121so3605555e87.0
 for <qemu-devel@nongnu.org>; Wed, 11 Sep 2024 06:52:11 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1726062729; x=1726667529;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=XMtC5Kei8mxn7YHbK2SX3QVuhzxpI5xgFrkix64PgUI=;
 b=vL0HtUo3TCtJEuLafKzM6zpf51K7Bj8DlWbjQ8UUwktFCEAsM5gWaDAmeB04QQ9/V9
 54l/tsXkdNCiS6p5xyS6Ft9UkyxVdPMCzG6E1reBJqoaEaAWVTkRUlzFyqi2gAaN3H0+
 aX/zGzht80Z/QrqYI/uL/1l3xmSJq/xX4YOBdLoI0JWJyC8yHay53c+B/AvBvMH4M27L
 nr53t3jAT4l829GZXOObu6GZFDoUH1jopycBNSYzgdQeaQ/J6qaQZfTVguKjVnYTV5S+
 oIqPD2zWToRb6J7Y5ECYnhQVmeWEgztaUGZlBODF0QGzsCpOkdJYbVfBmJz8EeChPFUy
 ePAQ==
X-Gm-Message-State: AOJu0Yx6inKm8YUAdPJKhMo7HgDY2EKT/PmH9wAjlz04+lWyDcIgYIWn
 2qTT9dna8WxwmzfAS4p0O5r5+ECjq9s9NoWP23ty1Rl0bM8lMqprWEUkg5gRmZyZHC3OqRdIyKu
 YZ0XSuHCzrmUspUnV0xBxhNrSdNnbVISXaVTxyuJOLHuu4IOK1Zk+XkSMoq0N1CYbpeI7tu5dLK
 2VExw3EIbKXvMDZWodcnISucRnobzD7A==
X-Received: by 2002:a05:6512:1388:b0:535:6a84:68df with SMTP id
 2adb3069b0e04-536587b5421mr11748610e87.27.1726062729259; 
 Wed, 11 Sep 2024 06:52:09 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHBWytkJ5CWSFxMbY7O4YMGl+gyzbtWIAORmncdYcSIAUTUOVvIm5SzPCDv1FawPAkuriqtwA==
X-Received: by 2002:a05:6512:1388:b0:535:6a84:68df with SMTP id
 2adb3069b0e04-536587b5421mr11748576e87.27.1726062728400; 
 Wed, 11 Sep 2024 06:52:08 -0700 (PDT)
Received: from redhat.com ([2.55.9.133]) by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-a8d25ced18csm612219766b.161.2024.09.11.06.52.06
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 11 Sep 2024 06:52:07 -0700 (PDT)
Date: Wed, 11 Sep 2024 09:52:05 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>, zuoboqun <zuoboqun@baidu.com>,
 Stefano Garzarella <sgarzare@redhat.com>, Jason Wang <jasowang@redhat.com>
Subject: [PULL 13/18] vhost_net: configure all host notifiers in a single MR
 transaction
Message-ID: <6166799f698512ab35e216b4ff4f7156f47923c6.1726062663.git.mst@redhat.com>
References: <cover.1726062663.git.mst@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1726062663.git.mst@redhat.com>
X-Mailer: git-send-email 2.27.0.106.g8ac3dc51b1
X-Mutt-Fcc: =sent
Received-SPF: pass client-ip=170.10.133.124; envelope-from=mst@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.144,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
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

From: zuoboqun <zuoboqun@baidu.com>

This allows the vhost_net device which has multiple virtqueues to batch
the setup of all its host notifiers. This significantly reduces the
vhost_net device starting and stoping time, e.g. the time spend
on enabling notifiers reduce from 630ms to 75ms and the time spend on
disabling notifiers reduce from 441ms to 45ms for a VM with 192 vCPUs
and 15 vhost-user-net devices (64vq per device) in our case.

Signed-off-by: zuoboqun <zuoboqun@baidu.com>
Message-Id: <20240816070835.8309-1-zuoboqun@baidu.com>
Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
---
 include/hw/virtio/vhost.h |   4 +
 hw/net/vhost_net.c        | 155 +++++++++++++++++++++++++++++++++++---
 hw/virtio/vhost.c         |   6 +-
 3 files changed, 150 insertions(+), 15 deletions(-)

diff --git a/include/hw/virtio/vhost.h b/include/hw/virtio/vhost.h
index d75faf46e9..c75be46c06 100644
--- a/include/hw/virtio/vhost.h
+++ b/include/hw/virtio/vhost.h
@@ -171,6 +171,10 @@ int vhost_dev_init(struct vhost_dev *hdev, void *opaque,
  */
 void vhost_dev_cleanup(struct vhost_dev *hdev);
 
+void vhost_dev_disable_notifiers_nvqs(struct vhost_dev *hdev,
+                                      VirtIODevice *vdev,
+                                      unsigned int nvqs);
+
 /**
  * vhost_dev_enable_notifiers() - enable event notifiers
  * @hdev: common vhost_dev structure
diff --git a/hw/net/vhost_net.c b/hw/net/vhost_net.c
index dedf9ad7c2..997aab0557 100644
--- a/hw/net/vhost_net.c
+++ b/hw/net/vhost_net.c
@@ -162,6 +162,135 @@ void vhost_net_save_acked_features(NetClientState *nc)
 #endif
 }
 
+static void vhost_net_disable_notifiers_nvhosts(VirtIODevice *dev,
+                NetClientState *ncs, int data_queue_pairs, int nvhosts)
+{
+    VirtIONet *n = VIRTIO_NET(dev);
+    BusState *qbus = BUS(qdev_get_parent_bus(DEVICE(dev)));
+    struct vhost_net *net;
+    struct vhost_dev *hdev;
+    int r, i, j;
+    NetClientState *peer;
+
+    /*
+     * Batch all the host notifiers in a single transaction to avoid
+     * quadratic time complexity in address_space_update_ioeventfds().
+     */
+    memory_region_transaction_begin();
+
+    for (i = 0; i < nvhosts; i++) {
+        if (i < data_queue_pairs) {
+            peer = qemu_get_peer(ncs, i);
+        } else {
+            peer = qemu_get_peer(ncs, n->max_queue_pairs);
+        }
+
+        net = get_vhost_net(peer);
+        hdev = &net->dev;
+        for (j = 0; j < hdev->nvqs; j++) {
+            r = virtio_bus_set_host_notifier(VIRTIO_BUS(qbus),
+                                             hdev->vq_index + j,
+                                             false);
+            if (r < 0) {
+                error_report("vhost %d VQ %d notifier cleanup failed: %d",
+                              i, j, -r);
+            }
+            assert(r >= 0);
+        }
+    }
+    /*
+     * The transaction expects the ioeventfds to be open when it
+     * commits. Do it now, before the cleanup loop.
+     */
+    memory_region_transaction_commit();
+
+    for (i = 0; i < nvhosts; i++) {
+        if (i < data_queue_pairs) {
+            peer = qemu_get_peer(ncs, i);
+        } else {
+            peer = qemu_get_peer(ncs, n->max_queue_pairs);
+        }
+
+        net = get_vhost_net(peer);
+        hdev = &net->dev;
+        for (j = 0; j < hdev->nvqs; j++) {
+            virtio_bus_cleanup_host_notifier(VIRTIO_BUS(qbus),
+                                             hdev->vq_index + j);
+        }
+        virtio_device_release_ioeventfd(dev);
+    }
+}
+
+static int vhost_net_enable_notifiers(VirtIODevice *dev,
+                NetClientState *ncs, int data_queue_pairs, int cvq)
+{
+    VirtIONet *n = VIRTIO_NET(dev);
+    BusState *qbus = BUS(qdev_get_parent_bus(DEVICE(dev)));
+    int nvhosts = data_queue_pairs + cvq;
+    struct vhost_net *net;
+    struct vhost_dev *hdev;
+    int r, i, j;
+    NetClientState *peer;
+
+    /*
+     * Batch all the host notifiers in a single transaction to avoid
+     * quadratic time complexity in address_space_update_ioeventfds().
+     */
+    memory_region_transaction_begin();
+
+    for (i = 0; i < nvhosts; i++) {
+        if (i < data_queue_pairs) {
+            peer = qemu_get_peer(ncs, i);
+        } else {
+            peer = qemu_get_peer(ncs, n->max_queue_pairs);
+        }
+
+        net = get_vhost_net(peer);
+        hdev = &net->dev;
+        /*
+         * We will pass the notifiers to the kernel, make sure that QEMU
+         * doesn't interfere.
+         */
+        r = virtio_device_grab_ioeventfd(dev);
+        if (r < 0) {
+            error_report("binding does not support host notifiers");
+            memory_region_transaction_commit();
+            goto fail_nvhosts;
+        }
+
+        for (j = 0; j < hdev->nvqs; j++) {
+            r = virtio_bus_set_host_notifier(VIRTIO_BUS(qbus),
+                                             hdev->vq_index + j,
+                                             true);
+            if (r < 0) {
+                error_report("vhost %d VQ %d notifier binding failed: %d",
+                              i, j, -r);
+                memory_region_transaction_commit();
+                vhost_dev_disable_notifiers_nvqs(hdev, dev, j);
+                goto fail_nvhosts;
+            }
+        }
+    }
+
+    memory_region_transaction_commit();
+
+    return 0;
+fail_nvhosts:
+    vhost_net_disable_notifiers_nvhosts(dev, ncs, data_queue_pairs, i);
+    return r;
+}
+
+/*
+ * Stop processing guest IO notifications in qemu.
+ * Start processing them in vhost in kernel.
+ */
+static void vhost_net_disable_notifiers(VirtIODevice *dev,
+                NetClientState *ncs, int data_queue_pairs, int cvq)
+{
+    vhost_net_disable_notifiers_nvhosts(dev, ncs, data_queue_pairs,
+                                        data_queue_pairs + cvq);
+}
+
 static int vhost_net_get_fd(NetClientState *backend)
 {
     switch (backend->info->type) {
@@ -272,11 +401,6 @@ static int vhost_net_start_one(struct vhost_net *net,
         }
     }
 
-    r = vhost_dev_enable_notifiers(&net->dev, dev);
-    if (r < 0) {
-        goto fail_notifiers;
-    }
-
     r = vhost_dev_start(&net->dev, dev, false);
     if (r < 0) {
         goto fail_start;
@@ -328,8 +452,6 @@ fail:
     }
     vhost_dev_stop(&net->dev, dev, false);
 fail_start:
-    vhost_dev_disable_notifiers(&net->dev, dev);
-fail_notifiers:
     return r;
 }
 
@@ -351,7 +473,6 @@ static void vhost_net_stop_one(struct vhost_net *net,
     if (net->nc->info->stop) {
         net->nc->info->stop(net->nc);
     }
-    vhost_dev_disable_notifiers(&net->dev, dev);
 }
 
 int vhost_net_start(VirtIODevice *dev, NetClientState *ncs,
@@ -396,10 +517,16 @@ int vhost_net_start(VirtIODevice *dev, NetClientState *ncs,
         }
      }
 
+    r = vhost_net_enable_notifiers(dev, ncs, data_queue_pairs, cvq);
+    if (r < 0) {
+        error_report("Error enabling host notifiers: %d", -r);
+        goto err;
+    }
+
     r = k->set_guest_notifiers(qbus->parent, total_notifiers, true);
     if (r < 0) {
         error_report("Error binding guest notifier: %d", -r);
-        goto err;
+        goto err_host_notifiers;
     }
 
     for (i = 0; i < nvhosts; i++) {
@@ -414,19 +541,19 @@ int vhost_net_start(VirtIODevice *dev, NetClientState *ncs,
             r = vhost_set_vring_enable(peer, peer->vring_enable);
 
             if (r < 0) {
-                goto err_start;
+                goto err_guest_notifiers;
             }
         }
 
         r = vhost_net_start_one(get_vhost_net(peer), dev);
         if (r < 0) {
-            goto err_start;
+            goto err_guest_notifiers;
         }
     }
 
     return 0;
 
-err_start:
+err_guest_notifiers:
     while (--i >= 0) {
         peer = qemu_get_peer(ncs, i < data_queue_pairs ?
                                   i : n->max_queue_pairs);
@@ -437,6 +564,8 @@ err_start:
         fprintf(stderr, "vhost guest notifier cleanup failed: %d\n", e);
         fflush(stderr);
     }
+err_host_notifiers:
+    vhost_net_disable_notifiers(dev, ncs, data_queue_pairs, cvq);
 err:
     return r;
 }
@@ -468,6 +597,8 @@ void vhost_net_stop(VirtIODevice *dev, NetClientState *ncs,
         fflush(stderr);
     }
     assert(r >= 0);
+
+    vhost_net_disable_notifiers(dev, ncs, data_queue_pairs, cvq);
 }
 
 void vhost_net_cleanup(struct vhost_net *net)
diff --git a/hw/virtio/vhost.c b/hw/virtio/vhost.c
index 06fc71746e..7c5ef81b55 100644
--- a/hw/virtio/vhost.c
+++ b/hw/virtio/vhost.c
@@ -1682,9 +1682,9 @@ void vhost_dev_cleanup(struct vhost_dev *hdev)
     memset(hdev, 0, sizeof(struct vhost_dev));
 }
 
-static void vhost_dev_disable_notifiers_nvqs(struct vhost_dev *hdev,
-                                             VirtIODevice *vdev,
-                                             unsigned int nvqs)
+void vhost_dev_disable_notifiers_nvqs(struct vhost_dev *hdev,
+                                      VirtIODevice *vdev,
+                                      unsigned int nvqs)
 {
     BusState *qbus = BUS(qdev_get_parent_bus(DEVICE(vdev)));
     int i, r;
-- 
MST


