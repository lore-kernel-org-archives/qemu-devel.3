Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5F8B3C83F1B
	for <qemu-devel@archiver.kernel.org>; Mon, 14 Jul 2025 23:29:57 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ubSG0-0002hV-Rr; Mon, 14 Jul 2025 19:06:51 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1ubSFu-0002Fp-WB
 for qemu-devel@nongnu.org; Mon, 14 Jul 2025 19:06:43 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1ubSFt-0005NZ-9H
 for qemu-devel@nongnu.org; Mon, 14 Jul 2025 19:06:42 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1752534400;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=jIH1CkCCFSXcgs6SwD/lkBtxMtFMYESPhTMyWu2YSEw=;
 b=TWkaqVjNg3KtfMFt0WrzOqt0U6S1heptWdBQGrqqSESAQt0oV2cDzZxGpMegW4vNeZztpM
 NEBy5jzC1mMZCeUanHnW1RRNVoKEegO6AlKs8aA6VYfDKZA1F7I6LrSrJYwANYVFzCC+4V
 dra8q67ZLpsf7t+7en4LvLUfahcz+AI=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-526-DFyKStcbNAC0RLdd1Z8HKw-1; Mon, 14 Jul 2025 19:06:39 -0400
X-MC-Unique: DFyKStcbNAC0RLdd1Z8HKw-1
X-Mimecast-MFC-AGG-ID: DFyKStcbNAC0RLdd1Z8HKw_1752534398
Received: by mail-wm1-f71.google.com with SMTP id
 5b1f17b1804b1-45359bfe631so29214725e9.0
 for <qemu-devel@nongnu.org>; Mon, 14 Jul 2025 16:06:39 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1752534398; x=1753139198;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=jIH1CkCCFSXcgs6SwD/lkBtxMtFMYESPhTMyWu2YSEw=;
 b=LSWAVKqly2yh3coiumfXVJPhtZxoX8h36GJxGr3++zP7/kAJVP7Ap5dcbqr6T1npP6
 QcMshRV4Jdc1zKPnobVVIWtYOZnTAQGySLhz4CVb/M4Gd9BUKkxXYx95U1BvbSdeu1wK
 9PCmY6sgaNPS2rTqLj4JQ4mdp+XVcJH5Qq2qUzOKK7c/JrTYlMUJlzgFApJ5OwrtG1vW
 bnE4cLLKDWRreUy+kKF919hjJevS0q7MvNt0ceoEqK6PHbOg1lQQt1jimsA4Asaz3lPV
 L2SWMBAV5qA6MomB2GZYQ5wBPwfrwGSeknyy3Iizs78E79ZWedPT9etv85Cr6gsjcgsD
 YISQ==
X-Gm-Message-State: AOJu0YwtzxPTIe+6eXd8Dt6/ABHflV48OQyEyTf1PZm+cwk9EdysE1kk
 XULD/t0+5QY4Z6TcrEbDEKOvaOyHsaE1p6Q2qtxWcXnVdvzJI1KpvSafA/zPvRY9ZHdvUzZJnyZ
 8OMAHHEYeQ9AKwY/BbAcR9aHEw8kusK3TK7O5bwoJvd+u0+w7Mv76iNtSTGLf5QZZ4ggeLkcOEJ
 80AXOinWavURgQe4uXvF3hof2mLJ6vpiuGhg==
X-Gm-Gg: ASbGncuWbNPe8CozvJwN65G2I2loRTBfdlHnvaTb0HHpHiXlHVpFLtcbK5huldNfT31
 hQbFZGPR575Ve1A3EtKrbfR6yTrTlkHms+BZgMUd6g1J/6deUXdpUODqzfw9ab1r6G1vht8H3z2
 37vFBYkkXeWh4ppdq9Z9kcLjL3sm80NgUXwdDFLFR/363TK3smUJdtmXSj2EuBWm8rafTakLmwi
 uP/bx4m7Vyaw0Pc6b2eLdyPqfZyumJrR7i/kirnbYt40VRrSkGy5jZd+MinAyJv3yWn9bY/GOQ5
 75/jc/5BZoCYB5INBONuH7ChGhSidND8
X-Received: by 2002:a05:600c:8b21:b0:43d:42b:e186 with SMTP id
 5b1f17b1804b1-454f427c7a3mr147535745e9.8.1752534397872; 
 Mon, 14 Jul 2025 16:06:37 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEN8SfCBdNXDgKWYDMwQdzn82ZtYJ6VggooxMWqvitHxa9yFK5df/3iCQaRkYLeVks4Wlxggg==
X-Received: by 2002:a05:600c:8b21:b0:43d:42b:e186 with SMTP id
 5b1f17b1804b1-454f427c7a3mr147535485e9.8.1752534397398; 
 Mon, 14 Jul 2025 16:06:37 -0700 (PDT)
Received: from redhat.com ([2a0d:6fc0:150d:fc00:de3:4725:47c6:6809])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3b5e8e0d785sm13819909f8f.59.2025.07.14.16.06.36
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 14 Jul 2025 16:06:37 -0700 (PDT)
Date: Mon, 14 Jul 2025 19:06:35 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Daniil Tatianin <d-tatianin@yandex-team.ru>,
 Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>,
 Stefano Garzarella <sgarzare@redhat.com>
Subject: [PULL 09/97] vhost: add a helper for force stopping a device
Message-ID: <2f527fff460a2c67fd37298dbd7fe42fffdb738b.1752534227.git.mst@redhat.com>
References: <cover.1752534227.git.mst@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1752534227.git.mst@redhat.com>
X-Mailer: git-send-email 2.27.0.106.g8ac3dc51b1
X-Mutt-Fcc: =sent
Received-SPF: pass client-ip=170.10.133.124; envelope-from=mst@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
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

From: Daniil Tatianin <d-tatianin@yandex-team.ru>

This adds an ability to skip GET_VRING_BASE during device stop entirely,
and thus the expensive drain operation that this call entails as well,
which may be useful during a non-graceful shutdown in case the guest
operating system hangs or refuses to react to a previously requested
ACPI shutdown for whatever reason.

Signed-off-by: Daniil Tatianin <d-tatianin@yandex-team.ru>
Message-Id: <20250609212547.2859224-3-d-tatianin@yandex-team.ru>
Reviewed-by: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
---
 include/hw/virtio/vhost.h | 15 +++++++++++
 hw/virtio/vhost.c         | 52 +++++++++++++++++++++++++++++----------
 2 files changed, 54 insertions(+), 13 deletions(-)

diff --git a/include/hw/virtio/vhost.h b/include/hw/virtio/vhost.h
index 38800a7156..eb3dd7616b 100644
--- a/include/hw/virtio/vhost.h
+++ b/include/hw/virtio/vhost.h
@@ -237,6 +237,21 @@ int vhost_dev_start(struct vhost_dev *hdev, VirtIODevice *vdev, bool vrings);
  */
 int vhost_dev_stop(struct vhost_dev *hdev, VirtIODevice *vdev, bool vrings);
 
+/**
+ * vhost_dev_force_stop() - force stop the vhost device
+ * @hdev: common vhost_dev structure
+ * @vdev: the VirtIODevice structure
+ * @vrings: true to have vrings disabled in this call
+ *
+ * Force stop the vhost device. After the device is stopped the notifiers
+ * can be disabled (@vhost_dev_disable_notifiers) and the device can
+ * be torn down (@vhost_dev_cleanup). Unlike @vhost_dev_stop, this doesn't
+ * attempt to flush in-flight backend requests by skipping GET_VRING_BASE
+ * entirely.
+ */
+int vhost_dev_force_stop(struct vhost_dev *hdev, VirtIODevice *vdev,
+                         bool vrings);
+
 /**
  * DOC: vhost device configuration handling
  *
diff --git a/hw/virtio/vhost.c b/hw/virtio/vhost.c
index c87861b31f..c30ea1156e 100644
--- a/hw/virtio/vhost.c
+++ b/hw/virtio/vhost.c
@@ -1354,25 +1354,30 @@ fail_alloc_desc:
     return r;
 }
 
-int vhost_virtqueue_stop(struct vhost_dev *dev,
-                         struct VirtIODevice *vdev,
-                         struct vhost_virtqueue *vq,
-                         unsigned idx)
+static int do_vhost_virtqueue_stop(struct vhost_dev *dev,
+                                   struct VirtIODevice *vdev,
+                                   struct vhost_virtqueue *vq,
+                                   unsigned idx, bool force)
 {
     int vhost_vq_index = dev->vhost_ops->vhost_get_vq_index(dev, idx);
     struct vhost_vring_state state = {
         .index = vhost_vq_index,
     };
-    int r;
+    int r = 0;
 
     if (virtio_queue_get_desc_addr(vdev, idx) == 0) {
         /* Don't stop the virtqueue which might have not been started */
         return 0;
     }
 
-    r = dev->vhost_ops->vhost_get_vring_base(dev, &state);
-    if (r < 0) {
-        VHOST_OPS_DEBUG(r, "vhost VQ %u ring restore failed: %d", idx, r);
+    if (!force) {
+        r = dev->vhost_ops->vhost_get_vring_base(dev, &state);
+        if (r < 0) {
+            VHOST_OPS_DEBUG(r, "vhost VQ %u ring restore failed: %d", idx, r);
+        }
+    }
+
+    if (r < 0 || force) {
         /* Connection to the backend is broken, so let's sync internal
          * last avail idx to the device used idx.
          */
@@ -1401,6 +1406,14 @@ int vhost_virtqueue_stop(struct vhost_dev *dev,
     return r;
 }
 
+int vhost_virtqueue_stop(struct vhost_dev *dev,
+                         struct VirtIODevice *vdev,
+                         struct vhost_virtqueue *vq,
+                         unsigned idx)
+{
+    return do_vhost_virtqueue_stop(dev, vdev, vq, idx, false);
+}
+
 static int vhost_virtqueue_set_busyloop_timeout(struct vhost_dev *dev,
                                                 int n, uint32_t timeout)
 {
@@ -2119,7 +2132,8 @@ fail_features:
 }
 
 /* Host notifiers must be enabled at this point. */
-int vhost_dev_stop(struct vhost_dev *hdev, VirtIODevice *vdev, bool vrings)
+static int do_vhost_dev_stop(struct vhost_dev *hdev, VirtIODevice *vdev,
+                             bool vrings, bool force)
 {
     int i;
     int rc = 0;
@@ -2141,10 +2155,11 @@ int vhost_dev_stop(struct vhost_dev *hdev, VirtIODevice *vdev, bool vrings)
         vhost_dev_set_vring_enable(hdev, false);
     }
     for (i = 0; i < hdev->nvqs; ++i) {
-        rc |= vhost_virtqueue_stop(hdev,
-                                   vdev,
-                                   hdev->vqs + i,
-                                   hdev->vq_index + i);
+        rc |= do_vhost_virtqueue_stop(hdev,
+                                      vdev,
+                                      hdev->vqs + i,
+                                      hdev->vq_index + i,
+                                      force);
     }
     if (hdev->vhost_ops->vhost_reset_status) {
         hdev->vhost_ops->vhost_reset_status(hdev);
@@ -2164,6 +2179,17 @@ int vhost_dev_stop(struct vhost_dev *hdev, VirtIODevice *vdev, bool vrings)
     return rc;
 }
 
+int vhost_dev_stop(struct vhost_dev *hdev, VirtIODevice *vdev, bool vrings)
+{
+    return do_vhost_dev_stop(hdev, vdev, vrings, false);
+}
+
+int vhost_dev_force_stop(struct vhost_dev *hdev, VirtIODevice *vdev,
+                         bool vrings)
+{
+    return do_vhost_dev_stop(hdev, vdev, vrings, true);
+}
+
 int vhost_net_set_backend(struct vhost_dev *hdev,
                           struct vhost_vring_file *file)
 {
-- 
MST


