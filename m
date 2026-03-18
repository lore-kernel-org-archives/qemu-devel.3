Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B19AB103E183
	for <qemu-devel@archiver.kernel.org>; Wed, 18 Mar 2026 14:16:07 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w2rgf-0007Ld-He; Wed, 18 Mar 2026 10:15:53 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vikingtc4@gmail.com>)
 id 1w2rgR-0007Fc-1o
 for qemu-devel@nongnu.org; Wed, 18 Mar 2026 10:15:39 -0400
Received: from mail-pf1-x434.google.com ([2607:f8b0:4864:20::434])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <vikingtc4@gmail.com>)
 id 1w2rgM-00060J-RE
 for qemu-devel@nongnu.org; Wed, 18 Mar 2026 10:15:38 -0400
Received: by mail-pf1-x434.google.com with SMTP id
 d2e1a72fcca58-82a67ce6969so886331b3a.1
 for <qemu-devel@nongnu.org>; Wed, 18 Mar 2026 07:15:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1773843333; x=1774448133; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=9AsPYgj95PXD3MBcJoJu/VQSlxFjkWCj9VT48jKP+PA=;
 b=Ja0rutqfHkCD4mBBvgqyd0BtZrPUWHSL8npaKbpFtMHyNODifeKabtKnfVU8XsiCXe
 ouSa2syaBH/PYUamzy2ZLolxG3g1wGc1wSRM9JqcWYi2POmzKpZDnc9fOrE9wwCtTQsw
 kFsFAVbjHagaKIop0JgG3HTTUzQCUzubPPOYuMn4z1AIwq9fan2sJBwwCntBtPb48tA1
 wjpAgLtMB7s4lq68GVcugX3pCvkEw0SNhsbzeNJ5aTM8LqQMS3hyqtvRdgDAV6pCM7AU
 kHV3k9xWWxyXd0d6XOS4UB7LD4fCJs6+oyrbLv1zNW/VuUQzCEJuJSpGBsbjg5AzaCK2
 4y+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1773843333; x=1774448133;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=9AsPYgj95PXD3MBcJoJu/VQSlxFjkWCj9VT48jKP+PA=;
 b=Dc55+C+DwAXkjytHhqXRe0Z3SNLCoblSGoJ1Zs/pUsuoFuMtnfO7+bp8xZnEvDjdKm
 zv1b4YjDx0f7VTl1IXYEBuBOoQACLWvNWTzDlc3ow+lVrFmFlfFiXGLIWVTaEtkFe//H
 QtP4011lacHj9OLp8zShFxBoq0ycwKGrRSwppLFWX3hjgVp5eowz+wdqBMcDqTDeR/IR
 GivOJTDgH/3LF0caZe9c8zrco25tkmcTPdFrsVOog1Y3LZVDYSnrCguKG7lDlPMREXbr
 N4Am+ocLIi4RQPEg1J3Cv327y/clay/EmvHIEWlnBy98EOCLXit90v+o4AUlb8g927ld
 bhqA==
X-Gm-Message-State: AOJu0YxmiqMEh92cXCq22jorsStr9KyJpw60KvHayD1l0LMpOy9oYpKF
 JwUcB51t3R96/pqBSe5gR/67jUpLWvZPb8J7iS9/ReEt4Q0OzLmrQT3QcGmU2CniDAw=
X-Gm-Gg: ATEYQzzBs7bUMKNplcTVoyU67kaLNAhNT21SVmOmXT+2Xra43uHx9C5Si0rgTeVOQvE
 QvD8uzRJI5nHJR2ig6dPsAWeyJig/jfC+R4Xag1zfl+kFOpiJH6q4JspisZECPcuw0J6/UmhtZk
 xVJWSz7vB/XQFeL5aDjCSZZvApJTcYeFqAJJgzBdcMGnJXiftyRyo5af/II6CKX26Xoo6qyk8qe
 nr3mkMuSjA5l6rdKPBveyB4UCbrbJKZZE6VcIxJx1u8y8RovJU2PgNSaDH33tq738zrpTaRSwYe
 VwA54A3IDW+oFhNhOcdPc3sLvnifpq78fhxof3BKB2YXjrba9Dv/dKTGUi7o4SXKlwsgqYpP4cw
 MDcCGEuyMHsvZbIXb76y8igu/sCtIeLBEZsqCHUWdNoQRmEYxuxvwJoTNMATJ+rZBATQDHSVIts
 TLeD3b7MignOe4t872oyoW779BWlza8h0jqLaTAYPAAOu+yTQmdMajNHWHOpBU8rAG2r30Oqy9m
 nwccgBhsA==
X-Received: by 2002:a05:6a00:908e:b0:82a:78cd:3ba4 with SMTP id
 d2e1a72fcca58-82a78cd64a0mr422801b3a.13.1773843332696; 
 Wed, 18 Mar 2026 07:15:32 -0700 (PDT)
Received: from trieu2-huynh-trieuhpn-ubuntu24.bee-live.svc.cluster.local
 ([27.122.242.65]) by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-82a6af06bd7sm2927272b3a.0.2026.03.18.07.15.28
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 18 Mar 2026 07:15:32 -0700 (PDT)
From: Trieu Huynh <vikingtc4@gmail.com>
To: qemu-devel@nongnu.org
Cc: Trieu Huynh <vikingtc4@gmail.com>,
 Anthony Krowiak <akrowiak@linux.ibm.com>,
 Jagannathan Raman <jag.raman@oracle.com>,
 "Maciej S . Szmigiero" <maciej.szmigiero@oracle.com>,
 Matthew Rosato <mjrosato@linux.ibm.com>,
 Elena Ufimtseva <elena.ufimtseva@oracle.com>,
 Halil Pasic <pasic@linux.ibm.com>, Jason Herne <jjherne@linux.ibm.com>,
 Cornelia Huck <cohuck@redhat.com>, Eric Farman <farman@linux.ibm.com>,
 Alex Williamson <alex@shazbot.org>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>,
 "Michael S. Tsirkin" <mst@redhat.com>,
 Stefano Garzarella <sgarzare@redhat.com>,
 qemu-s390x@nongnu.org (open list:vfio-ap)
Subject: [PATCH v3 3/4] util/event_notifier: fix error handling for
 event_notifier_init callers
Date: Wed, 18 Mar 2026 23:14:12 +0900
Message-ID: <20260318141415.8538-4-vikingtc4@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260318141415.8538-1-vikingtc4@gmail.com>
References: <20260318141415.8538-1-vikingtc4@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::434;
 envelope-from=vikingtc4@gmail.com; helo=mail-pf1-x434.google.com
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

Check return value of event_notifier_init() and return early on
failure instead of continuing with invalid state.
- Use ret < 0 to handle negative return value.
- No functional changes.

Resolves: https://gitlab.com/qemu-project/qemu/-/issues/413
Signed-off-by: Trieu Huynh <vikingtc4@gmail.com>
Acked-by: Anthony Krowiak <akrowiak@linux.ibm.com>
Reviewed-by: Jagannathan Raman <jag.raman@oracle.com>
Reviewed-by: Maciej S. Szmigiero <maciej.szmigiero@oracle.com> # for the Hyper-V part
Reviewed-by: Matthew Rosato <mjrosato@linux.ibm.com>
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


