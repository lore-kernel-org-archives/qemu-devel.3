Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 938BDF53D8C
	for <qemu-devel@archiver.kernel.org>; Mon, 16 Mar 2026 18:47:57 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w2CyV-0000F8-AG; Mon, 16 Mar 2026 14:47:35 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vikingtc4@gmail.com>)
 id 1w2CyU-0000Ek-6R
 for qemu-devel@nongnu.org; Mon, 16 Mar 2026 14:47:34 -0400
Received: from mail-pl1-x635.google.com ([2607:f8b0:4864:20::635])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <vikingtc4@gmail.com>)
 id 1w2CyS-0006EI-Cp
 for qemu-devel@nongnu.org; Mon, 16 Mar 2026 14:47:33 -0400
Received: by mail-pl1-x635.google.com with SMTP id
 d9443c01a7336-2ad21f437eeso241395ad.0
 for <qemu-devel@nongnu.org>; Mon, 16 Mar 2026 11:47:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1773686851; x=1774291651; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=9AsPYgj95PXD3MBcJoJu/VQSlxFjkWCj9VT48jKP+PA=;
 b=JBWwA4SS63psi908GzZEtZUp4I0BC61XPYavdJeGt1es64ShJNxMHLbL5QyR4t+3OQ
 MW5r1yBS1KfZl3HbvJmVfY7oeKRZEz2q9Ena2hQDRtos2o+5VF8ZTT6ukv+MvRP3i3SS
 yVbaGS157FdpPs9gZh2Jd8LIRislieoKitccChM/Q83yohhh0OBAYErAch2ANkqDQEV3
 sv4c9ybwGx7fSRMdv7c711ekd/DY8L4ynH3AfJ6/6z1e1jQRttan2ryHN6rGDhIAXrzt
 Na2sfAyPdmLESFXhMo8p3GRsYyAjNn79QzQ3CvT/2VGYm1EjFHrdkc51mkkiBwKjMv/T
 JivA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1773686851; x=1774291651;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=9AsPYgj95PXD3MBcJoJu/VQSlxFjkWCj9VT48jKP+PA=;
 b=gDAHaWH3geRXewtF2LbY/IRPfGeUOkfN7S1r0a2t5Ki+F5lXrM4FYjcUGbPvFk0cy9
 t6/1QNYe1EigxO6E0qTESNsUYbR4RVpTwIU/wj8EVxa6YzLNT3txCnm+aR2rzhf4H2/r
 SuVDAF6OApX27qPpi4GKs8uJYfqa6NLugQGtnPzu2+1+jadcPEoCK/HwubedY2eHadKT
 3C0g3cH9VYA/cuxSW8yvsXipVgdLUQoW9ipCNcchR+WcX/m+LDO8LG0AeimQoU5lLCP2
 /lgJO0twrph6W3gAbsk//12HMZj99l+5sklzuHvGcGIOpjYVyeM/8BSpPTnOtmPxXEN8
 nkpA==
X-Gm-Message-State: AOJu0YwskDZH3nQcmwGvZTdqyvaWgjZxSSi7IG5MHHP7kRYF2H6/HgQY
 Lm9X8mCmh1jppkam/QtZHJq3OBbs9Ssu2z1UtogngieGev0ywJ5B4kr0VynipfrP3gQ=
X-Gm-Gg: ATEYQzwP+jJamD85FOQgKv3vNXVxgyd0xCo53zmj+k85mMfx95v83lvEWTEbz+DUBLq
 Qp/YLZ1XWJ5rKc07aXJpcVMiZlJ2tJRSVBTsKW+4l3nPD3KX7qyvxC5D7g6deZDnOO9VD41rMaq
 8xkwYNCBqVb1deQjI70srcXoEAj81lxZMZP6Ej4pxoRR5jE7u1SrxnF0rkFcB1ft5VX4Ki5vwy4
 5Oz6PIdUzFugZkHFQj2AgxAYAwQ75sG8PzZhrKfH/h7PoqfhHgF/hASj1r3a6ym3blAlxlhe/Q8
 qkbNPnBTxF9FQ5XGUBVFobp3YFY3dnSbUipXYjASCBDyFxgrq3hS8sw0dl0VY3f65jUWOrc80P3
 HWu7fCBzc018lLpZFH37V97azaVWSA4sDmb/zOte/aPhVVusAsevqj5xLLfJuRaGp+gwLcU05UH
 u/WpQ1uK+STyJWZJQ5QyYhGU29zkdvYKGhq9uAO9j/xpSHgzpn2j+MSvzjh5agnzgIK5tOo6wvm
 nUMOJhWsY6nVrtUTnjP
X-Received: by 2002:a17:902:e802:b0:2ae:46f9:a115 with SMTP id
 d9443c01a7336-2b0636844bdmr5135175ad.22.1773686850836; 
 Mon, 16 Mar 2026 11:47:30 -0700 (PDT)
Received: from trieu2-huynh-trieuhpn-ubuntu24.bee-live.svc.cluster.local
 ([27.122.242.65]) by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2b04f40f515sm77284145ad.74.2026.03.16.11.47.29
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 16 Mar 2026 11:47:30 -0700 (PDT)
From: Trieu Huynh <vikingtc4@gmail.com>
To: qemu-devel@nongnu.org
Cc: Trieu Huynh <vikingtc4@gmail.com>,
 Anthony Krowiak <akrowiak@linux.ibm.com>,
 Jagannathan Raman <jag.raman@oracle.com>,
 "Maciej S . Szmigiero" <maciej.szmigiero@oracle.com>,
 Matthew Rosato <mjrosato@linux.ibm.com>
Subject: [PATCH v3 v3 3/4] util/event_notifier: fix error handling for
 event_notifier_init callers
Date: Tue, 17 Mar 2026 03:46:39 +0900
Message-ID: <20260316184644.68116-4-vikingtc4@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260316184644.68116-1-vikingtc4@gmail.com>
References: <20260311183432.214960-1-viking4@gmail.com>
 <20260316184644.68116-1-vikingtc4@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::635;
 envelope-from=vikingtc4@gmail.com; helo=mail-pl1-x635.google.com
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


