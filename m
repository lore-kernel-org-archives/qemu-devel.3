Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E159AFD4F17
	for <qemu-devel@archiver.kernel.org>; Tue, 10 Mar 2026 18:32:43 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w01sJ-000242-EU; Tue, 10 Mar 2026 14:32:11 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vikingtc4@gmail.com>)
 id 1w01sH-00023m-7Q
 for qemu-devel@nongnu.org; Tue, 10 Mar 2026 14:32:09 -0400
Received: from mail-pj1-x102d.google.com ([2607:f8b0:4864:20::102d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <vikingtc4@gmail.com>)
 id 1w01sF-0007iB-GB
 for qemu-devel@nongnu.org; Tue, 10 Mar 2026 14:32:08 -0400
Received: by mail-pj1-x102d.google.com with SMTP id
 98e67ed59e1d1-3598e7155bbso6549154a91.2
 for <qemu-devel@nongnu.org>; Tue, 10 Mar 2026 11:32:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1773167526; x=1773772326; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=YftEthnO5ZbHmCNgkv0qnfwkakmKxf+SOGKN2IGfTXs=;
 b=mRNEx2fbCsMgzTL2IalXcc9+sxhnrlIFHitDFTnZzvd2tZUkyAtpyO/uaJmbhkrHNu
 DnYIoNfczcI3da2NgFyhhsCls8ZKFVHyEob9vJb/hQ4ri3FrGw4+yXWKtnbejhRx12Et
 YvLYMY94eSmlDoT5FDWmdCHZl5IyWeIqbxesuB1gsO6s3QfSFJmgzMEMopVCyNysuTnx
 DHVjFy+/8fyGopmxjsm68YzF9cyXYLw14G9/nq9ir0EFq4ir+NfYq/7aritHGUG4Y0Y/
 /sToW9Nd/bUvTi/0qhR45+TvEDUeturr+AbY51iAs11kZm16O1h3O3s4ORDJ1ge6GRFp
 40Zw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1773167526; x=1773772326;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=YftEthnO5ZbHmCNgkv0qnfwkakmKxf+SOGKN2IGfTXs=;
 b=odSAKZif5eaKuOSah/jtudF2GJRnhmj7KMs4l5Km3zEBvEPfeVopkxPlmOOzMo0oRp
 c5u0nSI1MAug1Q8Ftd1f/yUR/rvIkLnzDhHWX5P5r8Uv2ECxVIF4OaxGW/cmoPg1zQg4
 Yo5D6D1PpMtz2ezBrrUmhj0qf7OixstRzcjf6wHVe/ABuhFbR1MTm+dcq4xyEoRNOpit
 pNDSxasNMtIi5r9lmUZFSTC5wIfpt67qgpJ6YRA4SmAV9OnJV+rADCD1dopXVbXDhbNv
 pKaHzlhPE4lykX5rhLuGIyHHKCB8mJ2mMM1s9t5optk84GUT+hsvDg4QlZPkMvBni9CV
 NM4A==
X-Gm-Message-State: AOJu0YxVmBMHiXtY2ahOMbU1MogEnhAyYb0iO6SZXoMTLBf5U+pKntkb
 BgLJXQ1XHMrcNEja1kKdsiPEUI88H3DTCgXpu3aU7CcrIsVnZ6jgNHFQ4Yqrj7wosIMSKQ==
X-Gm-Gg: ATEYQzwhxQ+0/1LDRo3ZyXP16vX578H+S7rRQaC5EwrCuooOc4QXIc0Fp82L+XH1sSo
 g4Oxjwrt4SsLBktke7SsIZD2foBgz42Ck8JaCzYbg/3FPRjlaLW2YXnKgkH8TTk2KV9tUpC9VF0
 K6r6BAeAw/cM/YMx4i4Kka/82KbwEDDDmtsxPrAkTwcyPvankMnmnQwvpMsKz9FmGS+KR6AJ5nE
 fiCLx6pQfoTBME337LH1puxzHtV96KJt/b9+3NNebPUxOHiDlM52lepUs2wmtTXAbSW3UMau2/D
 elIu2DShidnQHrpt8Nk7rO+fS9eZ5Fpovdi3drokNudQgfL9d8HlJWN46f68qPHHMT/pcYTgrZW
 aKHssOhUWRlw2De+E8aXoLax5ou1tM6INHOh1rp5TNtBheMTLvx9iUqkb0LCR/ah29A4xabimWc
 Y0AdVaeZdyHurXCqfxn1BNSp7oPqZpNEX1Dvr9acFUomU/Uw==
X-Received: by 2002:a17:903:3845:b0:2ae:80a3:ca7d with SMTP id
 d9443c01a7336-2ae8246be97mr176422845ad.39.1773167525946; 
 Tue, 10 Mar 2026 11:32:05 -0700 (PDT)
Received: from localhost.localdomain ([123.19.166.13])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2ae840b2e9dsm209437015ad.85.2026.03.10.11.32.01
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 10 Mar 2026 11:32:05 -0700 (PDT)
From: Trieu Huynh <vikingtc4@gmail.com>
X-Google-Original-From: Trieu Huynh <viking4@gmail.com>
To: qemu-devel@nongnu.org
Cc: Trieu Huynh <vikingtc4@gmail.com>,
 "Maciej S. Szmigiero" <maciej.szmigiero@oracle.com>,
 Elena Ufimtseva <elena.ufimtseva@oracle.com>,
 Jagannathan Raman <jag.raman@oracle.com>, Thomas Huth <thuth@redhat.com>,
 Alex Williamson <alex@shazbot.org>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>,
 Tony Krowiak <akrowiak@linux.ibm.com>, Halil Pasic <pasic@linux.ibm.com>,
 Jason Herne <jjherne@linux.ibm.com>, Eric Farman <farman@linux.ibm.com>,
 Matthew Rosato <mjrosato@linux.ibm.com>,
 "Michael S. Tsirkin" <mst@redhat.com>,
 Stefano Garzarella <sgarzare@redhat.com>, qemu-s390x@nongnu.org
Subject: [PATCH 3/4] util/event_notifier: fix error handling for
 event_notifier_init callers
Date: Wed, 11 Mar 2026 01:27:59 +0700
Message-ID: <20260310182801.196443-4-viking4@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260310182801.196443-1-viking4@gmail.com>
References: <20260310182801.196443-1-viking4@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::102d;
 envelope-from=vikingtc4@gmail.com; helo=mail-pj1-x102d.google.com
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
index c5bab5d245..2f0d2a03d8 100644
--- a/hw/hyperv/vmbus.c
+++ b/hw/hyperv/vmbus.c
@@ -1425,7 +1425,7 @@ static void open_channel(VMBusChannel *chan)
         goto put_gpadl;
     }
 
-    if (event_notifier_init(&chan->notifier, 0)) {
+    if (event_notifier_init(&chan->notifier, 0) < 0) {
         goto put_gpadl;
     }
 
@@ -2416,7 +2416,7 @@ static void vmbus_realize(BusState *bus, Error **errp)
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
index c89f3fbea3..29bf6511b3 100644
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


