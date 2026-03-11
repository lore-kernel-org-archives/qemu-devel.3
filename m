Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A22A61125863
	for <qemu-devel@archiver.kernel.org>; Wed, 11 Mar 2026 18:36:07 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w0OOu-0004q8-Dj; Wed, 11 Mar 2026 14:35:20 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vikingtc4@gmail.com>)
 id 1w0OOs-0004pk-8a
 for qemu-devel@nongnu.org; Wed, 11 Mar 2026 14:35:18 -0400
Received: from mail-pl1-x630.google.com ([2607:f8b0:4864:20::630])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <vikingtc4@gmail.com>)
 id 1w0OOq-0000ky-Gk
 for qemu-devel@nongnu.org; Wed, 11 Mar 2026 14:35:17 -0400
Received: by mail-pl1-x630.google.com with SMTP id
 d9443c01a7336-2ad4d639db3so1681245ad.0
 for <qemu-devel@nongnu.org>; Wed, 11 Mar 2026 11:35:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1773254115; x=1773858915; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=vEGrUNVPcQF125YpSiWYiQ37cQPYi06xBjgPkk+Wxd0=;
 b=RD4g9us7mUKR9qBmOkZ7BDBo4bg+ngSpNXYTHTVLlXZxyA5G9kJca7smlkGLhprhir
 SzKXnxMg8bgf6v9dKqdqJLWO4jImvIgg2eM9te4lyh2VdvZVV3xcMIOQfZofJ4J5IVsT
 93cPkmS+fHZZmq4CR3K8pJF3tG5jOJJuyEeLVUzGQWgfXYjuPcqQs7bzsV6bo9+k97zj
 ePSDnqFBaTj9kDx3x2pkJcVofqaP7mDEo9uh5SVHu73rF3ftImOwEbTtSpVQvNaRObFK
 1BKy4VBwewR42346cZQY9eolL6R0ohJ+qUtCtsWTOG/deBJgPcuCdfWUi38lmbgJu4K5
 DoYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1773254115; x=1773858915;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=vEGrUNVPcQF125YpSiWYiQ37cQPYi06xBjgPkk+Wxd0=;
 b=ooS0eXas+NG5HTB21pO7SrxI5h6fBKy7iPjtgqONQbzVrTIkIjku5UeLw4YhR3gG93
 C/PkcmUgbriU8o0HztQZ8bN6PCjVr5WiE4Sfk+pgcSYC//b3tjSc4QaKWWTmTvDXHx6J
 b7LNwMIHHFpBEM2BabIexpMaADLqe4fB1/YW3+Nhf2J6F+7b8XV1Z9AB1LL/25DotSom
 MTFXdw85Mrvs+9RSp0NRjh7n09MnBi37vwRTrzjltFkJVjOkudY4EA/6ao0BF6V41GN9
 wEesexK6AbqQacZV9HQxJrTXYjTA1kvNuPSv6tTRnTPE/0fbWNQGrid84gOROHD3e8Of
 xeug==
X-Gm-Message-State: AOJu0YwVCVRhQrIGOseUAXXFKCDqB/zl1FlyeWyO6v4nMVckE15zD4Kj
 k63bbZJ1mcvnGrTb2o21Vh7oWkAsS+kRnbInbm2j4+iMEpTr8+2lYCS1LYJdDtNkxJTvEA==
X-Gm-Gg: ATEYQzzQUNqQQ/GIVviSfQdL7we4yuYTfRO/uaDwcL3uUOM6bGtnnmu/nbBzsKPoIXM
 r0Vf1FklU/iwAycW4QyhiJoaO1g2XUzmdK49uCXrU+5wNrj80UNgGa6X0S+iIDqvsdDs3fDf3LH
 t1BBOuECOan9oYI2T7I2rp5Lzasp/H8NDmL5dy3o4/5/HG4VdayJa8jcpkf2BHFZARLr5Fb0wQL
 nGaIg33sUEDE8MjVdK8SsQBGxf4+iJebLNkc0E1vyMuiyGr9F56Mv7kgjenOx3YFL0JKPONGqca
 iOOQHJZC0yoeGlVUcCd2xZPIQbitVfeXs9HXLhNxwi1uq2xDHvgYsnjlL/wp261q7t4yYOVs74N
 g8re28wicRbMO5xq7xh6XS3lvt0PBunzlCwx1vyqo1GBS11y6SI7X1v/Q1K/1hcNNzVRm+BENGN
 IPrmJ/vM6G0K/8SJ8+UXqYAT33O70LbMZoL6XTh07cXbyBgw==
X-Received: by 2002:a17:903:2a88:b0:2ae:7f70:b2aa with SMTP id
 d9443c01a7336-2aeae892fadmr40728955ad.29.1773254114898; 
 Wed, 11 Mar 2026 11:35:14 -0700 (PDT)
Received: from localhost.localdomain ([123.19.166.13])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2aeae222e2fsm42124115ad.2.2026.03.11.11.35.10
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 11 Mar 2026 11:35:14 -0700 (PDT)
From: Trieu Huynh <vikingtc4@gmail.com>
X-Google-Original-From: Trieu Huynh <viking4@gmail.com>
To: qemu-devel@nongnu.org
Cc: Trieu Huynh <vikingtc4@gmail.com>,
 Anthony Krowiak <akrowiak@linux.ibm.com>,
 Jagannathan Raman <jag.raman@oracle.com>,
 "Maciej S. Szmigiero" <maciej.szmigiero@oracle.com>,
 Elena Ufimtseva <elena.ufimtseva@oracle.com>,
 Alex Williamson <alex@shazbot.org>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>,
 Halil Pasic <pasic@linux.ibm.com>, Jason Herne <jjherne@linux.ibm.com>,
 Thomas Huth <thuth@redhat.com>, Eric Farman <farman@linux.ibm.com>,
 Matthew Rosato <mjrosato@linux.ibm.com>,
 "Michael S. Tsirkin" <mst@redhat.com>,
 Stefano Garzarella <sgarzare@redhat.com>,
 qemu-s390x@nongnu.org (open list:vfio-ap)
Subject: [PATCH v2 3/4] util/event_notifier: fix error handling for
 event_notifier_init callers
Date: Thu, 12 Mar 2026 01:34:29 +0700
Message-ID: <20260311183432.214960-4-viking4@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260311183432.214960-1-viking4@gmail.com>
References: <20260311183432.214960-1-viking4@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::630;
 envelope-from=vikingtc4@gmail.com; helo=mail-pl1-x630.google.com
X-Spam_score_int: 15
X-Spam_score: 1.5
X-Spam_bar: +
X-Spam_report: (1.5 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1, DKIM_VALID=-0.1,
 DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_ENVFROM_END_DIGIT=0.25,
 FREEMAIL_FROM=0.001, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_SBL_CSS=3.335,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

From: Trieu Huynh <vikingtc4@gmail.com>

Check return value of event_notifier_init() and return early on
failure instead of continuing with invalid state.
- Use ret < 0 to handle negative return value.
- No functional changes.

Resolves: https://gitlab.com/qemu-project/qemu/-/issues/413
Signed-off-by: Trieu Huynh <vikingtc4@gmail.com>
Acked-by: Anthony Krowiak <akrowiak@linux.ibm.com>
Reviewed-by: Jagannathan Raman <jag.raman@oracle.com>
---
 hw/hyperv/hyperv.c     |  4 ++--
 hw/hyperv/vmbus.c      |  4 ++--
 hw/remote/proxy.c      | 15 +++++++++++++--
 hw/vfio/ap.c           |  2 +-
 hw/vfio/ccw.c          |  2 +-
 hw/vfio/pci-quirks.c   |  2 +-
 hw/vfio/pci.c          |  2 +-
 hw/virtio/vhost-vdpa.c |  4 ++--
 8 files changed, 23 insertions(+), 12 deletions(-)

diff --git a/hw/hyperv/hyperv.c b/hw/hyperv/hyperv.c
index 27e323a819..aa278b179e 100644
--- a/hw/hyperv/hyperv.c
+++ b/hw/hyperv/hyperv.c
@@ -439,7 +439,7 @@ HvSintRoute *hyperv_sint_route_new(uint32_t vp_index, uint32_t sint,
         sint_route->staged_msg->cb_data = cb_data;
 
         r = event_notifier_init(ack_notifier, false);
-        if (r) {
+        if (r < 0) {
             goto cleanup_err_sint;
         }
         event_notifier_set_handler(ack_notifier, sint_ack_handler);
@@ -453,7 +453,7 @@ HvSintRoute *hyperv_sint_route_new(uint32_t vp_index, uint32_t sint,
 
     /* We need to setup a GSI for this SintRoute */
     r = event_notifier_init(&sint_route->sint_set_notifier, false);
-    if (r) {
+    if (r < 0) {
         goto cleanup_err_sint;
     }
 
diff --git a/hw/hyperv/vmbus.c b/hw/hyperv/vmbus.c
index 64abe4c4c1..5388f4277f 100644
--- a/hw/hyperv/vmbus.c
+++ b/hw/hyperv/vmbus.c
@@ -1432,7 +1432,7 @@ static void open_channel(VMBusChannel *chan)
         goto put_gpadl;
     }
 
-    if (event_notifier_init(&chan->notifier, 0)) {
+    if (event_notifier_init(&chan->notifier, 0) < 0) {
         goto put_gpadl;
     }
 
@@ -2450,7 +2450,7 @@ static void vmbus_realize(BusState *bus, Error **errp)
     }
 
     ret = event_notifier_init(&vmbus->notifier, 0);
-    if (ret != 0) {
+    if (ret < 0) {
         error_setg(errp, "event notifier failed to init with %d", ret);
         goto remove_msg_handler;
     }
diff --git a/hw/remote/proxy.c b/hw/remote/proxy.c
index 5081d67e7f..e91566509f 100644
--- a/hw/remote/proxy.c
+++ b/hw/remote/proxy.c
@@ -52,9 +52,20 @@ static void setup_irqfd(PCIProxyDev *dev)
     PCIDevice *pci_dev = PCI_DEVICE(dev);
     MPQemuMsg msg;
     Error *local_err = NULL;
+    int ret = 0;
 
-    event_notifier_init(&dev->intr, 0);
-    event_notifier_init(&dev->resample, 0);
+    ret = event_notifier_init(&dev->intr, 0);
+    if (ret < 0) {
+        error_report("Failed to init intr notifier: %s", strerror(-ret));
+        return;
+    }
+
+    ret = event_notifier_init(&dev->resample, 0);
+    if (ret < 0) {
+        error_report("Failed to init resample notifier: %s", strerror(-ret));
+        event_notifier_cleanup(&dev->intr);
+        return;
+    }
 
     memset(&msg, 0, sizeof(MPQemuMsg));
     msg.cmd = MPQEMU_CMD_SET_IRQFD;
diff --git a/hw/vfio/ap.c b/hw/vfio/ap.c
index e58a0169af..5c8f305653 100644
--- a/hw/vfio/ap.c
+++ b/hw/vfio/ap.c
@@ -180,7 +180,7 @@ static bool vfio_ap_register_irq_notifier(VFIOAPDevice *vapdev,
         return false;
     }
 
-    if (event_notifier_init(notifier, 0)) {
+    if (event_notifier_init(notifier, 0) < 0) {
         error_setg_errno(errp, errno,
                          "vfio: Unable to init event notifier for irq (%d)",
                          irq);
diff --git a/hw/vfio/ccw.c b/hw/vfio/ccw.c
index 2251facb35..ce9c014e6a 100644
--- a/hw/vfio/ccw.c
+++ b/hw/vfio/ccw.c
@@ -418,7 +418,7 @@ static bool vfio_ccw_register_irq_notifier(VFIOCCWDevice *vcdev,
         return false;
     }
 
-    if (event_notifier_init(notifier, 0)) {
+    if (event_notifier_init(notifier, 0) < 0) {
         error_setg_errno(errp, errno,
                          "vfio: Unable to init event notifier for irq (%d)",
                          irq);
diff --git a/hw/vfio/pci-quirks.c b/hw/vfio/pci-quirks.c
index 7b907b9360..66e02b15a4 100644
--- a/hw/vfio/pci-quirks.c
+++ b/hw/vfio/pci-quirks.c
@@ -318,7 +318,7 @@ static VFIOIOEventFD *vfio_ioeventfd_init(VFIOPCIDevice *vdev,
 
     ioeventfd = g_malloc0(sizeof(*ioeventfd));
 
-    if (event_notifier_init(&ioeventfd->e, 0)) {
+    if (event_notifier_init(&ioeventfd->e, 0) < 0) {
         g_free(ioeventfd);
         return NULL;
     }
diff --git a/hw/vfio/pci.c b/hw/vfio/pci.c
index 94c174a773..1945751ffd 100644
--- a/hw/vfio/pci.c
+++ b/hw/vfio/pci.c
@@ -70,7 +70,7 @@ static bool vfio_notifier_init(VFIOPCIDevice *vdev, EventNotifier *e,
     }
 
     ret = event_notifier_init(e, 0);
-    if (ret) {
+    if (ret < 0) {
         error_setg_errno(errp, -ret, "vfio_notifier_init %s failed", name);
         return false;
     }
diff --git a/hw/virtio/vhost-vdpa.c b/hw/virtio/vhost-vdpa.c
index 2f8f11df86..9c7634e243 100644
--- a/hw/virtio/vhost-vdpa.c
+++ b/hw/virtio/vhost-vdpa.c
@@ -1075,13 +1075,13 @@ static int vhost_vdpa_svq_set_fds(struct vhost_dev *dev,
     int r;
 
     r = event_notifier_init(&svq->hdev_kick, 0);
-    if (r != 0) {
+    if (r < 0) {
         error_setg_errno(errp, -r, "Couldn't create kick event notifier");
         goto err_init_hdev_kick;
     }
 
     r = event_notifier_init(&svq->hdev_call, 0);
-    if (r != 0) {
+    if (r < 0) {
         error_setg_errno(errp, -r, "Couldn't create call event notifier");
         goto err_init_hdev_call;
     }
-- 
2.43.0


