Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8CEFECD98D6
	for <qemu-devel@archiver.kernel.org>; Sun, 14 Jun 2026 19:07:46 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wYqAz-0001ww-UH; Sun, 14 Jun 2026 15:07:21 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1wYqAx-0001jV-PB
 for qemu-devel@nongnu.org; Sun, 14 Jun 2026 15:07:19 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1wYqAu-0001w0-Vg
 for qemu-devel@nongnu.org; Sun, 14 Jun 2026 15:07:18 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1781464036;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=xNE+FzuWcPvZLw0zlSSEW+Itu4un1W0AmA555SPCbPk=;
 b=K3iOeabkH4BXtQMzaYrdI6aXthUdv+ShGxx9gr058eoTnfoF7ho5Ht2iAMYT2bf9ZX6nae
 EvKfBDjKQDt5eSDzdzLC2v0/XFSToD0PS7QR0WP1UmiBwQwlSOXWlg8/9PB7Fi5X5D9y9C
 CBsJco+4bXLdgb86youtOAI2eDeN0Nc=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-444-phmUaUz6NNu6I28N1aVxsQ-1; Sun, 14 Jun 2026 15:07:14 -0400
X-MC-Unique: phmUaUz6NNu6I28N1aVxsQ-1
X-Mimecast-MFC-AGG-ID: phmUaUz6NNu6I28N1aVxsQ_1781464034
Received: by mail-wr1-f70.google.com with SMTP id
 ffacd0b85a97d-4601c9b630fso1231359f8f.0
 for <qemu-devel@nongnu.org>; Sun, 14 Jun 2026 12:07:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1781464033; x=1782068833; darn=nongnu.org;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=xNE+FzuWcPvZLw0zlSSEW+Itu4un1W0AmA555SPCbPk=;
 b=Fr2PxEziOwdaLImd1i42bK4Aybyc2u9P75hQ8tRZH9owTmLkXllUhnvrqNut21maBP
 nV6FQ+AgbGZ9ZcPR+S/YQ3QjL+UTc9jfnaxRkGXWdglkFaNuoUbCMb4ziRNiVM9Prq4i
 xLkr59XqTxEEnydmpMcBWS+x08Uku9Cb+er4cX1YYib6ZMtBTLpktLi/gX9Fg9FK+KEQ
 OANkZVpbGR1E/jLRfU+oiTW+ZGEhBsyaizJ8pZ59Xf53auJs0J/KI7tRuqut933t5Np2
 j9kS/xiehAGJExOPfTmWPD9uro8Uylyra5k7pOwl19lSsD9kFBWyy5epURexPmfBxRbR
 C3Aw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1781464033; x=1782068833;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=xNE+FzuWcPvZLw0zlSSEW+Itu4un1W0AmA555SPCbPk=;
 b=r8eFUPlurqfG498S6MY5BRmO0flZ+N7sA/t8tocG5CnN1gUu5kFe8nnJPyOh5dIwdG
 bBh5V7O5iOhP4V414dvHswwdfqSYWg6s32TG/J3UypkOkt0DG85pme7XoIbdsMfY/ZWO
 HEbHnHIcQhkur2iLOqjFUBa4IQL+JtqkFe+pcctlnr5bdl8liiDIALDVhfWLFM3Y2a5N
 vzntHY0W3EelnmzCbnlsCZNWfk5P5GzlbCnyQKiCfY3pUUBEN5yDO9EHHnT7G6j6dsqd
 i8KDDyN/PKe4f+hrVkQS2d9aunnZHP8UOSwszRJ5Rg24CZSV4aWMBdiCh7raSfe6Otnl
 62IA==
X-Gm-Message-State: AOJu0YzM6514zlNUYvRH9cBiC3aSonZrxBXMgZbuSsbhKmJEkk+1XuBO
 K0BvQEDJAvKzKvrsaMBj6H2gFkmv+OYOMfJHOSi+WAcES8TG7KbL9NjEUiT9bZx4OPkAOckK/Oy
 MjI7tmxV5l54Zx/Y/e9D1FNgIRIeEmUWnCwGRZJk+VeAZ3f15D1l3yTvBMcu2rGqB8fqSEwtFW+
 dOQkduQjd7Cc0DD90L6COQneED0neKVncQpQ==
X-Gm-Gg: Acq92OEo+M2Ujed+FLoLnt6MtOzdoWbpAJ0/mtxXuJDF+ULlDt0mYH2pwGEL7UgBB57
 5Qs0KvLcHmydoo17m3j8swRNkHt4KGiU/U5f3+GEBh5iovjRR5Ez7wKSphLxopLWk3i9jWfB+Yg
 +WE26zHG31s2HaJTb8r+g7F1IP4y5nRi3gypeCXx5VMj3j1VMg8/5lj0DIY/O7zmu50AzJIDqty
 3dtm9rpRcqt9Gqh9EFmtq2RDdsr04jUp1KaPf8JGznE82XOd6+3eOlcOLMGx2hIhnErgR7/g4gv
 y4tSCNaQgViJj6bJSmj7xwpkGto20gG4ns8WxXRYWNDHO84ORKujhSG+dgT6In8eMcJypF8wBjB
 JCoFZP7YO7VduXp7hF8R04LwvtlPs5/r8JPD+Mz8AogU=
X-Received: by 2002:a05:6000:2508:b0:452:8286:86bf with SMTP id
 ffacd0b85a97d-4606da8c96cmr14732158f8f.1.1781464033420; 
 Sun, 14 Jun 2026 12:07:13 -0700 (PDT)
X-Received: by 2002:a05:6000:2508:b0:452:8286:86bf with SMTP id
 ffacd0b85a97d-4606da8c96cmr14732110f8f.1.1781464032782; 
 Sun, 14 Jun 2026 12:07:12 -0700 (PDT)
Received: from redhat.com (IGLD-80-230-85-71.inter.net.il. [80.230.85.71])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-4606f2b0c35sm27630375f8f.22.2026.06.14.12.07.11
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 14 Jun 2026 12:07:12 -0700 (PDT)
Date: Sun, 14 Jun 2026 15:07:10 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>,
 Eric Farman <farman@linux.ibm.com>, Cornelia Huck <cohuck@redhat.com>,
 Halil Pasic <pasic@linux.ibm.com>,
 Christian Borntraeger <borntraeger@linux.ibm.com>,
 Matthew Rosato <mjrosato@linux.ibm.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Ilya Leoshkevich <iii@linux.ibm.com>,
 David Hildenbrand <david@kernel.org>, qemu-s390x@nongnu.org
Subject: [PULL 033/106] virtio: move common part of _set_guest_notifier to
 generic code
Message-ID: <a8f6b13f068b753d16588630654dfd51d7009436.1781463125.git.mst@redhat.com>
References: <cover.1781463125.git.mst@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1781463125.git.mst@redhat.com>
X-Mailer: git-send-email 2.51.2.2891.g4157995a80.dirty
X-Mutt-Fcc: =sent
Received-SPF: pass client-ip=170.10.133.124; envelope-from=mst@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.445,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

From: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>

virtio-pci, virtio-mmio and virtio-ccw handle config notifier equally
but with different code (mmio adds a separate function, when pci use
common function). Let's chose the more compact way (pci) and reuse it
for mmio.

Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
Acked-by: Eric Farman <farman@linux.ibm.com>
Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
Message-Id: <20260420200339.708640-8-vsementsov@yandex-team.ru>
---
 hw/s390x/virtio-ccw.c          | 35 ++++++++++++-------------
 hw/virtio/virtio-mmio.c        | 41 +++++------------------------
 hw/virtio/virtio-pci.c         | 34 +++---------------------
 hw/virtio/virtio.c             | 47 +++++++++++++++++++++++++++++++---
 include/hw/virtio/virtio-pci.h |  3 ---
 include/hw/virtio/virtio.h     | 15 ++++++++---
 6 files changed, 82 insertions(+), 93 deletions(-)

diff --git a/hw/s390x/virtio-ccw.c b/hw/s390x/virtio-ccw.c
index ba55bf4fe9..cdad862ec2 100644
--- a/hw/s390x/virtio-ccw.c
+++ b/hw/s390x/virtio-ccw.c
@@ -1025,20 +1025,27 @@ static int virtio_ccw_set_guest_notifier(VirtioCcwDevice *dev, int n,
     VirtQueue *vq = virtio_get_queue(vdev, n);
     EventNotifier *notifier = virtio_queue_get_guest_notifier(vq);
     VirtioDeviceClass *k = VIRTIO_DEVICE_GET_CLASS(vdev);
+    int r;
+
+    if (!assign) {
+        if (k->guest_notifier_mask && vdev->use_guest_notifier_mask) {
+            k->guest_notifier_mask(vdev, n, true);
+        }
+        if (with_irqfd) {
+            virtio_ccw_remove_irqfd(dev, n);
+        }
+    }
+
+    r = virtio_set_guest_notifier(vdev, n, assign, with_irqfd);
+    if (r < 0) {
+        return r;
+    }
 
     if (assign) {
-        int r = event_notifier_init(notifier, 0);
-
-        if (r < 0) {
-            return r;
-        }
-        virtio_queue_set_guest_notifier_fd_handler(vq, true, with_irqfd);
         if (with_irqfd) {
             r = virtio_ccw_add_irqfd(dev, n);
             if (r) {
-                virtio_queue_set_guest_notifier_fd_handler(vq, false,
-                                                           with_irqfd);
-                event_notifier_cleanup(notifier);
+                virtio_set_guest_notifier(vdev, n, false, with_irqfd);
                 return r;
             }
         }
@@ -1054,16 +1061,8 @@ static int virtio_ccw_set_guest_notifier(VirtioCcwDevice *dev, int n,
             k->guest_notifier_pending(vdev, n)) {
             event_notifier_set(notifier);
         }
-    } else {
-        if (k->guest_notifier_mask && vdev->use_guest_notifier_mask) {
-            k->guest_notifier_mask(vdev, n, true);
-        }
-        if (with_irqfd) {
-            virtio_ccw_remove_irqfd(dev, n);
-        }
-        virtio_queue_set_guest_notifier_fd_handler(vq, false, with_irqfd);
-        event_notifier_cleanup(notifier);
     }
+
     return 0;
 }
 
diff --git a/hw/virtio/virtio-mmio.c b/hw/virtio/virtio-mmio.c
index 742ca3d3e4..58c6d46aab 100644
--- a/hw/virtio/virtio-mmio.c
+++ b/hw/virtio/virtio-mmio.c
@@ -670,18 +670,11 @@ static int virtio_mmio_set_guest_notifier(DeviceState *d, int n, bool assign,
     VirtIOMMIOProxy *proxy = VIRTIO_MMIO(d);
     VirtIODevice *vdev = virtio_bus_get_device(&proxy->bus);
     VirtioDeviceClass *vdc = VIRTIO_DEVICE_GET_CLASS(vdev);
-    VirtQueue *vq = virtio_get_queue(vdev, n);
-    EventNotifier *notifier = virtio_queue_get_guest_notifier(vq);
+    int r;
 
-    if (assign) {
-        int r = event_notifier_init(notifier, 0);
-        if (r < 0) {
-            return r;
-        }
-        virtio_queue_set_guest_notifier_fd_handler(vq, true, with_irqfd);
-    } else {
-        virtio_queue_set_guest_notifier_fd_handler(vq, false, with_irqfd);
-        event_notifier_cleanup(notifier);
+    r = virtio_set_guest_notifier(vdev, n, assign, with_irqfd);
+    if (r < 0) {
+        return r;
     }
 
     if (vdc->guest_notifier_mask && vdev->use_guest_notifier_mask) {
@@ -690,30 +683,7 @@ static int virtio_mmio_set_guest_notifier(DeviceState *d, int n, bool assign,
 
     return 0;
 }
-static int virtio_mmio_set_config_guest_notifier(DeviceState *d, bool assign,
-                                                 bool with_irqfd)
-{
-    VirtIOMMIOProxy *proxy = VIRTIO_MMIO(d);
-    VirtIODevice *vdev = virtio_bus_get_device(&proxy->bus);
-    VirtioDeviceClass *vdc = VIRTIO_DEVICE_GET_CLASS(vdev);
-    EventNotifier *notifier = virtio_config_get_guest_notifier(vdev);
-    int r = 0;
 
-    if (assign) {
-        r = event_notifier_init(notifier, 0);
-        if (r < 0) {
-            return r;
-        }
-        virtio_config_set_guest_notifier_fd_handler(vdev, assign, with_irqfd);
-    } else {
-        virtio_config_set_guest_notifier_fd_handler(vdev, assign, with_irqfd);
-        event_notifier_cleanup(notifier);
-    }
-    if (vdc->guest_notifier_mask && vdev->use_guest_notifier_mask) {
-        vdc->guest_notifier_mask(vdev, VIRTIO_CONFIG_IRQ_IDX, !assign);
-    }
-    return r;
-}
 static int virtio_mmio_set_guest_notifiers(DeviceState *d, int nvqs,
                                            bool assign)
 {
@@ -735,7 +705,8 @@ static int virtio_mmio_set_guest_notifiers(DeviceState *d, int nvqs,
             goto assign_error;
         }
     }
-    r = virtio_mmio_set_config_guest_notifier(d, assign, with_irqfd);
+    r = virtio_mmio_set_guest_notifier(d, VIRTIO_CONFIG_IRQ_IDX, assign,
+                                       with_irqfd);
     if (r < 0) {
         goto assign_error;
     }
diff --git a/hw/virtio/virtio-pci.c b/hw/virtio/virtio-pci.c
index bcab2d18b8..fd9719547f 100644
--- a/hw/virtio/virtio-pci.c
+++ b/hw/virtio/virtio-pci.c
@@ -1208,43 +1208,17 @@ static void virtio_pci_vector_poll(PCIDevice *dev,
     }
 }
 
-void virtio_pci_set_guest_notifier_fd_handler(VirtIODevice *vdev, VirtQueue *vq,
-                                              int n, bool assign,
-                                              bool with_irqfd)
-{
-    if (n == VIRTIO_CONFIG_IRQ_IDX) {
-        virtio_config_set_guest_notifier_fd_handler(vdev, assign, with_irqfd);
-    } else {
-        virtio_queue_set_guest_notifier_fd_handler(vq, assign, with_irqfd);
-    }
-}
-
 static int virtio_pci_set_guest_notifier(DeviceState *d, int n, bool assign,
                                          bool with_irqfd)
 {
     VirtIOPCIProxy *proxy = to_virtio_pci_proxy(d);
     VirtIODevice *vdev = virtio_bus_get_device(&proxy->bus);
     VirtioDeviceClass *vdc = VIRTIO_DEVICE_GET_CLASS(vdev);
-    VirtQueue *vq = NULL;
-    EventNotifier *notifier = NULL;
+    int r;
 
-    if (n == VIRTIO_CONFIG_IRQ_IDX) {
-        notifier = virtio_config_get_guest_notifier(vdev);
-    } else {
-        vq = virtio_get_queue(vdev, n);
-        notifier = virtio_queue_get_guest_notifier(vq);
-    }
-
-    if (assign) {
-        int r = event_notifier_init(notifier, 0);
-        if (r < 0) {
-            return r;
-        }
-        virtio_pci_set_guest_notifier_fd_handler(vdev, vq, n, true, with_irqfd);
-    } else {
-        virtio_pci_set_guest_notifier_fd_handler(vdev, vq, n, false,
-                                                 with_irqfd);
-        event_notifier_cleanup(notifier);
+    r = virtio_set_guest_notifier(vdev, n, assign, with_irqfd);
+    if (r < 0) {
+        return r;
     }
 
     if (!msix_enabled(&proxy->pci_dev) &&
diff --git a/hw/virtio/virtio.c b/hw/virtio/virtio.c
index 63e2faee99..3780e86039 100644
--- a/hw/virtio/virtio.c
+++ b/hw/virtio/virtio.c
@@ -3835,8 +3835,10 @@ static void virtio_config_guest_notifier_read(EventNotifier *n)
         virtio_notify_config(vdev);
     }
 }
-void virtio_queue_set_guest_notifier_fd_handler(VirtQueue *vq, bool assign,
-                                                bool with_irqfd)
+
+static void virtio_queue_set_guest_notifier_fd_handler(VirtQueue *vq,
+                                                       bool assign,
+                                                       bool with_irqfd)
 {
     if (assign && !with_irqfd) {
         event_notifier_set_handler(&vq->guest_notifier,
@@ -3851,7 +3853,7 @@ void virtio_queue_set_guest_notifier_fd_handler(VirtQueue *vq, bool assign,
     }
 }
 
-void virtio_config_set_guest_notifier_fd_handler(VirtIODevice *vdev,
+static void virtio_config_set_guest_notifier_fd_handler(VirtIODevice *vdev,
                                                  bool assign, bool with_irqfd)
 {
     EventNotifier *n;
@@ -3868,6 +3870,45 @@ void virtio_config_set_guest_notifier_fd_handler(VirtIODevice *vdev,
     }
 }
 
+static void virtio_set_guest_notifier_fd_handler(VirtIODevice *vdev,
+                                                 VirtQueue *vq,
+                                                 int n, bool assign,
+                                                 bool with_irqfd)
+{
+    if (n == VIRTIO_CONFIG_IRQ_IDX) {
+        virtio_config_set_guest_notifier_fd_handler(vdev, assign, with_irqfd);
+    } else {
+        virtio_queue_set_guest_notifier_fd_handler(vq, assign, with_irqfd);
+    }
+}
+
+int virtio_set_guest_notifier(VirtIODevice *vdev, int n, bool assign,
+                              bool with_irqfd)
+{
+    VirtQueue *vq = NULL;
+    EventNotifier *notifier = NULL;
+
+    if (n == VIRTIO_CONFIG_IRQ_IDX) {
+        notifier = virtio_config_get_guest_notifier(vdev);
+    } else {
+        vq = virtio_get_queue(vdev, n);
+        notifier = virtio_queue_get_guest_notifier(vq);
+    }
+
+    if (assign) {
+        int r = event_notifier_init(notifier, 0);
+        if (r < 0) {
+            return r;
+        }
+        virtio_set_guest_notifier_fd_handler(vdev, vq, n, true, with_irqfd);
+    } else {
+        virtio_set_guest_notifier_fd_handler(vdev, vq, n, false, with_irqfd);
+        event_notifier_cleanup(notifier);
+    }
+
+    return 0;
+}
+
 EventNotifier *virtio_queue_get_guest_notifier(VirtQueue *vq)
 {
     return &vq->guest_notifier;
diff --git a/include/hw/virtio/virtio-pci.h b/include/hw/virtio/virtio-pci.h
index 5cb20b73f6..ee50fb0d55 100644
--- a/include/hw/virtio/virtio-pci.h
+++ b/include/hw/virtio/virtio-pci.h
@@ -250,9 +250,6 @@ void virtio_pci_types_register(const VirtioPCIDeviceTypeInfo *t);
  * @fixed_queues.
  */
 unsigned virtio_pci_optimal_num_queues(unsigned fixed_queues);
-void virtio_pci_set_guest_notifier_fd_handler(VirtIODevice *vdev, VirtQueue *vq,
-                                              int n, bool assign,
-                                              bool with_irqfd);
 
 int virtio_pci_add_shm_cap(VirtIOPCIProxy *proxy, uint8_t bar, uint64_t offset,
                            uint64_t length, uint8_t id);
diff --git a/include/hw/virtio/virtio.h b/include/hw/virtio/virtio.h
index 6344bd7b68..d9fde42558 100644
--- a/include/hw/virtio/virtio.h
+++ b/include/hw/virtio/virtio.h
@@ -420,8 +420,6 @@ void virtio_queue_update_used_idx(VirtIODevice *vdev, int n);
 VirtQueue *virtio_get_queue(VirtIODevice *vdev, int n);
 uint16_t virtio_get_queue_index(VirtQueue *vq);
 EventNotifier *virtio_queue_get_guest_notifier(VirtQueue *vq);
-void virtio_queue_set_guest_notifier_fd_handler(VirtQueue *vq, bool assign,
-                                                bool with_irqfd);
 int virtio_device_start_ioeventfd(VirtIODevice *vdev);
 int virtio_device_grab_ioeventfd(VirtIODevice *vdev);
 void virtio_device_release_ioeventfd(VirtIODevice *vdev);
@@ -435,8 +433,17 @@ void virtio_queue_aio_detach_host_notifier(VirtQueue *vq, AioContext *ctx);
 VirtQueue *virtio_vector_first_queue(VirtIODevice *vdev, uint16_t vector);
 VirtQueue *virtio_vector_next_queue(VirtQueue *vq);
 EventNotifier *virtio_config_get_guest_notifier(VirtIODevice *vdev);
-void virtio_config_set_guest_notifier_fd_handler(VirtIODevice *vdev,
-                                                 bool assign, bool with_irqfd);
+
+/**
+ * virtio_set_guest_notifier - set/unset queue or config guest notifier
+ *
+ * @vdev: the VirtIO device
+ * @n: queue number, or VIRTIO_CONFIG_IRQ_IDX to set config notifer
+ * @assign: true to set notifier, false to unset
+ * @with_irqfd: irqfd enabled
+ */
+int virtio_set_guest_notifier(VirtIODevice *vdev, int n, bool assign,
+                              bool with_irqfd);
 
 static inline void virtio_add_feature(uint64_t *features, unsigned int fbit)
 {
-- 
MST


