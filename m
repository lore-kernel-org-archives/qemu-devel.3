Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DFA35F483D6
	for <qemu-devel@archiver.kernel.org>; Mon, 23 Mar 2026 16:53:41 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w4iWt-0002Fw-0j; Mon, 23 Mar 2026 12:53:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1w4iWe-0001z2-PD
 for qemu-devel@nongnu.org; Mon, 23 Mar 2026 12:53:16 -0400
Received: from mail-wr1-x429.google.com ([2a00:1450:4864:20::429])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1w4iWc-0000Vf-KV
 for qemu-devel@nongnu.org; Mon, 23 Mar 2026 12:53:12 -0400
Received: by mail-wr1-x429.google.com with SMTP id
 ffacd0b85a97d-439b7c2788dso1955377f8f.1
 for <qemu-devel@nongnu.org>; Mon, 23 Mar 2026 09:53:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1774284787; x=1774889587; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=ZUL4OvcdIzqgWJj0q2pMTC7lXI6ZXxkYtPaw18rj/bk=;
 b=TWsGa17Zrg9DNfWbFNJ4r8LxyKxfJuCgQGORD3kGC53hImI+Tw8SYZOijGcPvDE3a5
 TNzC1I+9l+A4y1O7uhNobFQHt7NxrCvB8PRkQ8/VROMxlQUCmMXD32P6sasbbEkfxwED
 k56zB/Ol43gfymCRtI9bcvr/v/U25YrcPVJzFujV+lRYIFLZUYappBgZsfjKF+zPO04I
 0YCa/yApAZGsRb3CcCRpjN6E4FD0L4wwYZgXzM5omWkPRi6gKAXujg83REcGCzsp1jJO
 fx1Rxk72NYImNa+4KfBpqOToYf//fzFvypn6dBlHiqM/kGofRU2z/MImIen4aekoxTUT
 ZZxg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1774284787; x=1774889587;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=ZUL4OvcdIzqgWJj0q2pMTC7lXI6ZXxkYtPaw18rj/bk=;
 b=OA/AaPpAS0JOzPl4+pbc6vTFRQ1j5Pgah4ES1RdMo92q6Q7DU8u+CxHnNleG5gFXGp
 SaL6GceI9L7oXUL90fx1EqQtx45JdvcWsfikC2ilHOgr7I4KlD0bzCm+hEzGLkYcOQEJ
 fGP5xt1RQdtqWx9oLdhWsoojKUq11gmj2lRGDUgImE9ZgaYlYsdhfZ3UCqnFn+ynrxIj
 2K6BmphY+pdgk/4yY47v5bn+OME+UmUuqsZ26zwnejYi9plpPTJgag9cNFEiX47GPph/
 tlme5VwOSNbVMrC5F5yzgZOs1NEhtPQ8QIlyQre7hapDMV5T7XN1JFEQGyWnYTqTK0wx
 UiVg==
X-Gm-Message-State: AOJu0Yza79DF+YcCQz7ffjACwJI473B4H9Wjs0OUMlh5G7ZWzsLlWgeO
 cmQjGjFE1ny/q1T8savyWdVqyw46pckcEinXTCC0BBzqGY0X/qV9qYT7kStgv5TiMtCjEp+cnj1
 vq0+62PQ=
X-Gm-Gg: ATEYQzziYIzE4boo0s0R6g7gCw/8sCms7CVZscdYtWeAHReuX33OZb/yjOuFbUMn4Gq
 Fql7yjq9xM+M7CSo41cQVvVvkgzotcD/f6FSxOwe1C/Xoj1YeN6DkX/wGQH1YDC/zuCt71KdMlV
 X9hvlzU+HqQ4aV6vUsoomOg5tRDXOqvgvrJdnapef3yqZEOhmGZXpSMgK0epvyvM/ZyItRRCmym
 D6wtM3SiP+p48VMawAwHmmGxia151AScv9Pnr6jGt18iyZ/K2TC0ZleNAoMKLSarjiS6Lo5ozl3
 ZiEWxw3n1un2LX/vPhF0QvrkBQ8hanVZT1LyC9T0fxy+CDlQy6dWAoXIekRGrAsbhIl6bDy5SHA
 lsQWLXSKmGVXebuTmPptFjLNBtIy/DyBux42zhzRVeOVCzawgmh3wFaIkAL48LFR5NtDFGxNP95
 SsAFaeSxGrPjPhBOW6irYRCfaysENEdpJ18rhNisiMSIecFHgMyL53NYNtLBi54wnn9Xhg7Eyt
X-Received: by 2002:a05:6000:26c4:b0:439:abcd:b317 with SMTP id
 ffacd0b85a97d-43b6424e33dmr18890214f8f.14.1774284787351; 
 Mon, 23 Mar 2026 09:53:07 -0700 (PDT)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-43b6470c239sm30908066f8f.27.2026.03.23.09.53.06
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Mon, 23 Mar 2026 09:53:06 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 07/27] util/event_notifier: fix error handling for
 event_notifier_init callers
Date: Mon, 23 Mar 2026 17:51:58 +0100
Message-ID: <20260323165218.96607-8-philmd@linaro.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260323165218.96607-1-philmd@linaro.org>
References: <20260323165218.96607-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::429;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x429.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
Reviewed-by: Maciej S. Szmigiero <maciej.szmigiero@oracle.com> # for the Hyper-V part
Reviewed-by: Matthew Rosato <mjrosato@linux.ibm.com>
Message-ID: <20260318141415.8538-4-vikingtc4@gmail.com>
Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
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
index 27e323a8196..aa278b179e6 100644
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
index 64abe4c4c16..5388f4277f3 100644
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
index 5081d67e7f4..e91566509f3 100644
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
index e58a0169af9..5c8f3056530 100644
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
index 2251facb356..ce9c014e6a7 100644
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
index 7b907b9360d..66e02b15a48 100644
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
index 94c174a773f..1945751ffd4 100644
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
index 2f8f11df869..9c7634e2439 100644
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
2.53.0


